Return-Path: <netdev+bounces-176777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA7EA6C1B8
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 18:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31229189340B
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 17:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E176C22DF97;
	Fri, 21 Mar 2025 17:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="g4BlFBJq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA5222DF86
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 17:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742578762; cv=none; b=VdvEBwXr7p+71Z+uzVoKA2PZO8IO2HGBBaGxHFFN7HXxtZqEw/XyYDIKW1XvsMoRarmCtWUVlDQ5S8YqBq4qtaTHbUj+DXt7q+F73TgnCP4MuXIbjr3izzCseUjL8vXr5O8b/Xtz8Ils0038vYOeSxmb7JmmrDtT9imZUiKlu+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742578762; c=relaxed/simple;
	bh=Z24ZkfQTkO2qsqkG+prpvqFeOLYUgl0Q5C/iST2VvRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JkYSwU+AOb4FW43hGYhILBIAXxqfE9Kmi3dEHNXH0pZMl839t61KTW1f8fCU4b0XWQdLhseAPq3FfhBE6URIGZ5yNUhHSEQsqfy8xb9oWW/15haa1zz2TIyvms/hR4oYCRqctL9ZbKonK/74lHIhyV/wYtk7M9EKP1EhudXdaeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=g4BlFBJq; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22438c356c8so47108585ad.1
        for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 10:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742578760; x=1743183560; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6wYIYbVK16NXRYkveWo4gR1XApiz8O5iEB75f7LsBck=;
        b=g4BlFBJqGkcsAMeVyq2s67n5gYA+6kKX1fr7oBB0OWIRxlT1opCY8i9c/rRJfrKbrB
         WdeiaoJF4tyeRc7xTkbJnBPyFhTeNJQxlzpGStysHCdyKDZ6fscS5ffpmW0NP4g0eA5S
         Ajd50sqXOE4zCaMB/nvidcysbV6/S0m9HhjtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742578760; x=1743183560;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6wYIYbVK16NXRYkveWo4gR1XApiz8O5iEB75f7LsBck=;
        b=oqnHcNPTLcOucurADSScK13QDG7thDRC8AxXNy3+rrHDh8TnT5e20d7DTVbHUl4JoG
         EVTNrbUeyRj6wErBEqi6bJ7IIA/C4pORMdh9bMlghu6WWhhXoCCqTVErwHI0TPLpqYVf
         zRUkThGfkFywtVqEn8KecR/Pd5EfWnclQIuzQCqnd1CAaRLWEuH6b2QDRH89ZKq2WT2U
         uuwZ4N8CdANt3r2ZGMXHDoEWgaQ7+2oGdZ0mXmkp0faD9JnI7uZIrUxBQu4uanY63y2Y
         uwUebRlW4x1YALv0z1b1iy5UBqYO733xwjSdXp6KxWpI0Jd/rdHdtp2axYpUnLUnnZ3z
         rWjw==
X-Forwarded-Encrypted: i=1; AJvYcCUyhs+oXLIbyT/8O7rC7n29l0oA/+MAEPJTis4AKHGvMNR5T027Wrk7/nepbWvSmMPwtzhcj5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YykTI95Pj9BVqnrL2xi9fd5TvBFMXjPXSakHPfSBhnWTm35pS2Y
	s/uvquunnr87tfNcrmYBMDrZWBvqtP3MDrqiL/J/sVFGTB5Y55hvXozFLjVRXRY=
X-Gm-Gg: ASbGnctiGUpCOXPaq02usouJBLePwELqWnIrcznlcSgssTy3Vj3akOyW+JQLRpridMF
	KEXx8OedZWu1ibeqeK4P+ay6hWiBk6hTAC4RsNTM22P7HfakFVlIOvPctDGt1vCEE1875+oLvKX
	GhPhyA3nVN1PC+8cp36nXv4ptJNEHfvI8DpNiMpcEv5AQgcxs/mQaSl2+QSi8kKnv/ZgRj6eh6C
	/BCREv1VIYzJUTmTDB4KJKyimdmHN9g8hqqdlu7Pfvb0/RQrT3tlLCaRZKqeqvE4J8RdccHKhIZ
	XxNgiOqxjJ19imQhINbzVIIM3MCuU349v1aiDNVSqe0Vr8jH8QnURfmssLFDYxs1m4M3Tx3JCIU
	Ji8yTopwgAmESjHcA
X-Google-Smtp-Source: AGHT+IEhlItaj2pC9Wf82CLdmLgdITwlz2p+d7lIz2Le5i+dk9F2Qi4DXLQbsiyL+XPB1IxdTxRq7w==
X-Received: by 2002:a17:902:d549:b0:223:5a6e:b20 with SMTP id d9443c01a7336-22780c55215mr71050115ad.7.1742578760339;
        Fri, 21 Mar 2025 10:39:20 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811d968asm19847205ad.162.2025.03.21.10.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 10:39:19 -0700 (PDT)
Date: Fri, 21 Mar 2025 10:39:16 -0700
From: Joe Damato <jdamato@fastly.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller " <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, willemb@google.com, mkarsten@uwaterloo.ca,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 3/4] Extend napi threaded polling to allow
 kthread based busy polling
Message-ID: <Z92kRKwkDmcRbc41@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller " <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, willemb@google.com, mkarsten@uwaterloo.ca,
	netdev@vger.kernel.org
References: <20250321021521.849856-1-skhawaja@google.com>
 <20250321021521.849856-4-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321021521.849856-4-skhawaja@google.com>

On Fri, Mar 21, 2025 at 02:15:20AM +0000, Samiullah Khawaja wrote:
> Add a new state to napi state enum:
> 
> - STATE_THREADED_BUSY_POLL
>   Threaded busy poll is enabled/running for this napi.
> 
> Following changes are introduced in the napi scheduling and state logic:
> 
> - When threaded busy poll is enabled through sysfs it also enables
>   NAPI_STATE_THREADED so a kthread is created per napi. It also sets
>   NAPI_STATE_THREADED_BUSY_POLL bit on each napi to indicate that we are
>   supposed to busy poll for each napi.
> 
> - When napi is scheduled with STATE_SCHED_THREADED and associated
>   kthread is woken up, the kthread owns the context. If
>   NAPI_STATE_THREADED_BUSY_POLL and NAPI_SCHED_THREADED both are set
>   then it means that we can busy poll.
> 
> - To keep busy polling and to avoid scheduling of the interrupts, the
>   napi_complete_done returns false when both SCHED_THREADED and
>   THREADED_BUSY_POLL flags are set. Also napi_complete_done returns
>   early to avoid the STATE_SCHED_THREADED being unset.
> 
> - If at any point STATE_THREADED_BUSY_POLL is unset, the
>   napi_complete_done will run and unset the SCHED_THREADED bit also.
>   This will make the associated kthread go to sleep as per existing
>   logic.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>  Documentation/ABI/testing/sysfs-class-net     |  3 +-
>  Documentation/netlink/specs/netdev.yaml       | 12 ++-
>  Documentation/networking/napi.rst             | 67 ++++++++++++-
>  .../net/ethernet/atheros/atl1c/atl1c_main.c   |  2 +-
>  drivers/net/ethernet/mellanox/mlxsw/pci.c     |  2 +-
>  drivers/net/ethernet/renesas/ravb_main.c      |  2 +-
>  drivers/net/wireless/ath/ath10k/snoc.c        |  2 +-
>  include/linux/netdevice.h                     | 20 +++-
>  include/uapi/linux/netdev.h                   |  6 ++
>  net/core/dev.c                                | 93 ++++++++++++++++---
>  net/core/net-sysfs.c                          |  2 +-
>  net/core/netdev-genl-gen.c                    |  2 +-
>  net/core/netdev-genl.c                        |  2 +-
>  tools/include/uapi/linux/netdev.h             |  6 ++
>  14 files changed, 188 insertions(+), 33 deletions(-)
  
I think this should be split into two patches which would ease
review and bisection:

  - First patch: introduce enum netdev_napi_threaded and
    NETDEV_NAPI_THREADED_ENABLE and the associated driver changes.

  - Second patch: introduce NETDEV_NAPI_THREADED_BUSY_POLL_ENABLE

I'll have to take a closer look at all the changes here after I've
read the cover letter and have reproduced the results, but one issue
stands out:

> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 3c244fd9ae6d..b990cbe76f86 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h

[...]

> @@ -2432,7 +2442,7 @@ struct net_device {
>  	struct sfp_bus		*sfp_bus;
>  	struct lock_class_key	*qdisc_tx_busylock;
>  	bool			proto_down;
> -	bool			threaded;
> +	u8			threaded;

Doesn't

Documentation/networking/net_cachelines/net_device.rst

Also need to be updated if you are changing the width of this field
from bool to u8?

