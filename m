Return-Path: <netdev+bounces-94487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FBE8BF9E0
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 11:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A93FB20A4D
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 09:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC512768E1;
	Wed,  8 May 2024 09:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jd3/3MUB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12629BA27;
	Wed,  8 May 2024 09:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715162176; cv=none; b=Pz6i54+NKCI9IfuUjRPWphLtuUl0O8BK/yIX9UNm41i9A8APNL7lgIeVc06zMoI6giWzRolKS+cUiEyVKGz6O97cWUUEN6t1MHxS1iREQlT8BiebhmGe0RgVJMZJfJQDHffgprOd1oxQIGAuM+oRcEpq9WPMboADkKmIr2qOEF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715162176; c=relaxed/simple;
	bh=L58OHrtgnGvD6BMHNnxub1BnLgpGqwKlRG8lHbKfkmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GC8pjJpz1PRBh5kMy6oFDC1bNd9VX4jf4l6oDfs77hFPJjDHY9Gv6mw9RIcPFAwhx1eD6ZLqM1kvywsd2pSc1Jc4Gk/voQFxd+FCZVfNx/orSWfQbeOSe+rHFnjUzD5ctmIoxTdOWB+uPpjCURj4sWGZCFo6h2+gWkmoo/exiqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jd3/3MUB; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51f71e4970bso4934972e87.2;
        Wed, 08 May 2024 02:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715162173; x=1715766973; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=io8fmhR7P9iwCv/52XS5SThweh8W+4/Do9egkjm9CcM=;
        b=Jd3/3MUBTiSrw/xZ5I3Q4pNQBXsBYWyDUVofdyQ9yeEPFWuPpNjYV1NxSwb+WMstj7
         8chDKeCC3Zh7cxgO4CU2BW68SGm7R7nfpGfDovlhH5jmpBL02Y6J2fq1rzi/XQiOG2Mj
         UKRu/fal++BMgtrH/TkGsblpCE7VGRKa5Be0GWI6vKQjZ1gIhvN5NN9kMei6Z8jrPT+q
         Jmble/hOmxwlVMZnAKp3MxPb7aJ8uKnNtum0CjfP7Pjly9u9UhY7Q3yF/79AQpG2Zf3+
         jcikFhLP2kE2Yam9zDlFFUen9cr9w2MGRYRcbBDMFTw+OcYiKzsT2RjMMCtufc2MgrI5
         5qng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715162173; x=1715766973;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=io8fmhR7P9iwCv/52XS5SThweh8W+4/Do9egkjm9CcM=;
        b=tW0DWys1Ie2mgXDdv8oV9o1iDhE0Cbc6DvOc8DanDyZQ5BV+jo70OJbPg6l+WIotBN
         YVV+BaHEpCxO6q/Wp4CJYs+1B7pB8DUac20augfRNZOP/HRX913BGUDdypOS9JhO37ZD
         q6AcC6Dd3/qplK2nkQIXrhtn7kOAlewK9Klsp1iEpQDPUySYsXLix1/RkQpS5tFVuz7e
         NMWrR2+qpQaubTrqYyJdPMBeX42ZxxkaDlpoSmwQUqs6fWgh4uW6o35jjCOswcMCk3NC
         MKU8cNfcGw8g3YtsbKdbJ+5ds2pln6pxt9WHDD08SudKkv+NnlqDmW05GH3zORYd31Im
         dAVg==
X-Forwarded-Encrypted: i=1; AJvYcCWQqPGyyUf1wZrESi+/OWVpNTZhruI6DcoK8YFcnuztT/r9lNOYsJoaG+p+oeyekMuqXvdegUu0ovhUoaK88LKwxPwwz/b/E09xeY0mx+nWdSJjy5cNC2tHvq+D+B1woSDLzXyV
X-Gm-Message-State: AOJu0YxZIqonjy2o2qj4L4XGcFrHTyOpHM59AFFfvKHAsQjAd124n7HF
	QlJH5/beFPIkF41GV96fLdJUMBzGO1APq+dQmb9C/gnIDIqE5dbk
X-Google-Smtp-Source: AGHT+IFSg3ipoB9x/q9K5s3nqoZPNbvUw9v4r5YNPaHHmzhGDbABkPL44NPpL7eQYgs74L94b0SGPg==
X-Received: by 2002:a05:6512:3157:b0:518:eef0:45c0 with SMTP id 2adb3069b0e04-5217cc520d0mr1791398e87.48.1715162172805;
        Wed, 08 May 2024 02:56:12 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id o3-20020ac24943000000b0051e12a2c07bsm2475872lfi.20.2024.05.08.02.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 02:56:12 -0700 (PDT)
Date: Wed, 8 May 2024 12:56:09 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Xiaolei Wang <xiaolei.wang@windriver.com>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mcoquelin.stm32@gmail.com, richardcochran@gmail.com, bartosz.golaszewski@linaro.org, 
	horms@kernel.org, ahalaney@redhat.com, rohan.g.thomas@intel.com, 
	j.zink@pengutronix.de, rmk+kernel@armlinux.org.uk, leong.ching.swee@intel.com, 
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] net: stmmac: move the lock to struct
 plat_stmmacenet_data
Message-ID: <dvtilkr2ho5yy56fii6voglgu3tnopmoy556vrdo4evlynet5g@lnrlv73a27hm>
References: <20240508045257.2470698-1-xiaolei.wang@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508045257.2470698-1-xiaolei.wang@windriver.com>

On Wed, May 08, 2024 at 12:52:57PM +0800, Xiaolei Wang wrote:
> Reinitialize the whole est structure would also reset the mutex lock
> which is embedded in the est structure, and then trigger the following
> warning. To address this, move the lock to struct plat_stmmacenet_data.
> We also need to require the mutex lock when doing this initialization.
> 
> DEBUG_LOCKS_WARN_ON(lock->magic != lock)
> WARNING: CPU: 3 PID: 505 at kernel/locking/mutex.c:587 __mutex_lock+0xd84/0x1068
>  Modules linked in:
>  CPU: 3 PID: 505 Comm: tc Not tainted 6.9.0-rc6-00053-g0106679839f7-dirty #29
>  Hardware name: NXP i.MX8MPlus EVK board (DT)
>  pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>  pc : __mutex_lock+0xd84/0x1068
>  lr : __mutex_lock+0xd84/0x1068
>  sp : ffffffc0864e3570
>  x29: ffffffc0864e3570 x28: ffffffc0817bdc78 x27: 0000000000000003
>  x26: ffffff80c54f1808 x25: ffffff80c9164080 x24: ffffffc080d723ac
>  x23: 0000000000000000 x22: 0000000000000002 x21: 0000000000000000
>  x20: 0000000000000000 x19: ffffffc083bc3000 x18: ffffffffffffffff
>  x17: ffffffc08117b080 x16: 0000000000000002 x15: ffffff80d2d40000
>  x14: 00000000000002da x13: ffffff80d2d404b8 x12: ffffffc082b5a5c8
>  x11: ffffffc082bca680 x10: ffffffc082bb2640 x9 : ffffffc082bb2698
>  x8 : 0000000000017fe8 x7 : c0000000ffffefff x6 : 0000000000000001
>  x5 : ffffff8178fe0d48 x4 : 0000000000000000 x3 : 0000000000000027
>  x2 : ffffff8178fe0d50 x1 : 0000000000000000 x0 : 0000000000000000
>  Call trace:
>   __mutex_lock+0xd84/0x1068
>   mutex_lock_nested+0x28/0x34
>   tc_setup_taprio+0x118/0x68c
>   stmmac_setup_tc+0x50/0xf0
>   taprio_change+0x868/0xc9c
> 
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> ---
> v1 -> v2:
>  - move the lock to struct plat_stmmacenet_data
> v2 -> v3:
>  - Add require the mutex lock for reinitialization
> 
>  .../net/ethernet/stmicro/stmmac/stmmac_ptp.c   |  8 ++++----
>  .../net/ethernet/stmicro/stmmac/stmmac_tc.c    | 18 ++++++++++--------
>  include/linux/stmmac.h                         |  2 +-
>  3 files changed, 15 insertions(+), 13 deletions(-)
> 
> [...]
>
> diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> index dfa1828cd756..316ff7eb8b33 100644
> --- a/include/linux/stmmac.h
> +++ b/include/linux/stmmac.h
> @@ -117,7 +117,6 @@ struct stmmac_axi {
>  
>  #define EST_GCL		1024
>  struct stmmac_est {
> -	struct mutex lock;
>  	int enable;
>  	u32 btr_reserve[2];
>  	u32 btr_offset[2];
> @@ -246,6 +245,7 @@ struct plat_stmmacenet_data {
>  	struct fwnode_handle *port_node;
>  	struct device_node *mdio_node;
>  	struct stmmac_dma_cfg *dma_cfg;
> +	struct mutex lock;
>  	struct stmmac_est *est;
>  	struct stmmac_fpe_cfg *fpe_cfg;
>  	struct stmmac_safety_feature_cfg *safety_feat_cfg;

Seeing you are going to move things around I suggest to move the
entire stmmac_est instance out of the plat_stmmacenet_data structure
and place it in the stmmac_priv instead. Why? Because the EST configs
don't look as the platform config, but EST is enabled in runtime with
the settings retrieved for the TC TAPRIO feature also in runtime. So
it's better to have the EST-data preserved in the driver private date
instead of the platform data storage. You could move the structure
there and place the lock aside of it. Field name like "est_lock" might
be most suitable to be looking unified with the "ptp_lock" or
"aux_ts_lock".

* The same, but with no lock-related thing should be done for the
* stmmac_safety_feature_cfg structure,
but it's unrelated to the subject...

-Serge(y)

> -- 
> 2.25.1
> 
> 

