Return-Path: <netdev+bounces-119526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39536956135
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 04:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4313B2096F
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 02:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF7320330;
	Mon, 19 Aug 2024 02:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUGwXpir"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B8239FC1
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 02:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724035436; cv=none; b=aNXLrO1HMWhEvYAfXMbrRd/kA97Ffx7RF85Rq2o8yvhzRctpHd/31FLvEWPxo+CsNPTMCbmsdnIf4CdT9pKbQiB/qHKKcz0jEA/DUKuQUkhjtI7QAUFNpBK/LEIZ1uSXORQnTFiGHEkP/zxFz6xfPYm54Zx/WsEZP8UKMiUPGRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724035436; c=relaxed/simple;
	bh=EHybFs5yVVwEZurvp1O4PSTi/71KCa2skaVod0ubhTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FsDgVQb/1nNvw+sM+YvZobYuVNr9NT1grsrgq3nBkOObTKmpC/qaSeRES93dSr2b6CllpuEWIXpUjf9D3Xm5DuYUDsrLjDLMSxK+3GfBDzWpu+hOeOXuNOe+z59BUQ/6U5a4U4/vvbCRjspl9ZzKOf/AD7XNa28kkaK3i6FXHWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUGwXpir; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70f5ef740b7so3499302b3a.2
        for <netdev@vger.kernel.org>; Sun, 18 Aug 2024 19:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724035434; x=1724640234; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uebzB1jH+QiQlcVVZjVPGclTVBreQ5gnneHPxRNcfr8=;
        b=FUGwXpirnDPG15/JQlyrPsH3kpG8rkCiaOce8Kci9T4PmNjY+IC2vX0l5qKjkLWssi
         TVEGvXAqesfMAZfaUWF+5zZ4wPv3k8l+1UGnc7m/JxdihIH9PEvXEE+Vntp4XCKUf5Wr
         VeoFjy7Hlr7TB3l78cLzTzeIZ7fINM+gb4Jf5bEOYv5FbY2D7mzG8iPIWBwecJpAL0Jn
         K1YEwQ2opD4S6gDG4DmIKWHq5psbHsGoC0rE31f3zzEpiDOE+sBZXyI0RPXxWGqty9Gs
         bspV+djJ+mANvXTqPIalnWOlX8JS13jIRxITRuE969pmYddb+Iaq/ecjuJhy5gkjw/0+
         HCLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724035434; x=1724640234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uebzB1jH+QiQlcVVZjVPGclTVBreQ5gnneHPxRNcfr8=;
        b=vya88TplzTPZPwiQ/hKWCIPAoWNg3c9Lu7DiyM9tSAjiXcq3GhGXdZgTh02mjNhhtm
         tGtR2+Age0olp7mzny0glZZ4jAsJsP+hPuSdRDV3/oP9kDceF3e15okysOHbjD2iv/cH
         TAsJYjXultErp7Q7etIh3aJHVD9vw6UJuIqBRD6ovFP6v4QFdLr73XIs+gs/pmAsfn6/
         n9jvxJaKNIZqBF6DiTSAgaHMBkYbGsn1hdozmGv/lkZ9B+8qj0Y96gRey2+AfismbGdp
         EsVrWGRWla0PAOJ4pwRBJ4M7eNUgUi/ZkR5Q3DIc46EUlaNpn60ijMn5zTV3Af+UDa/6
         ae1w==
X-Gm-Message-State: AOJu0Yy2JGKNsknv391tygH15Ob52p0EkUs8jZvxG7bs+YbaAqzc8QuK
	hMeMN5InQP+R+HhRjyAbu++/SEzXKUWwBhrQdaCKCp3zy2I03zFp
X-Google-Smtp-Source: AGHT+IGZA131+JtIdhkCOuhUigiwTHXIJ54l5FCzjR/3wVNGqHaOyQeXhcU3d+KTkcAi3mLnAgLxWw==
X-Received: by 2002:a05:6a21:9187:b0:1c4:8bba:76e4 with SMTP id adf61e73a8af0-1c9050534e7mr12208685637.50.1724035434463;
        Sun, 18 Aug 2024 19:43:54 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e2b65aa7sm6097318a91.5.2024.08.18.19.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 19:43:54 -0700 (PDT)
Date: Mon, 19 Aug 2024 10:43:36 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, Taehee Yoo <ap420073@gmail.com>,
	davem@davemloft.net, jv@jvosburgh.net, andy@greyhouse.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	jarod@redhat.com
Subject: Re: [PATCH net 1/4] bonding: fix bond_ipsec_offload_ok return type
Message-ID: <ZsKxWKBQ74bPXy1n@Laptop-X1>
References: <20240816114813.326645-1-razor@blackwall.org>
 <20240816114813.326645-2-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816114813.326645-2-razor@blackwall.org>

On Fri, Aug 16, 2024 at 02:48:10PM +0300, Nikolay Aleksandrov wrote:
> Fix the return type which should be bool.
> 
> Fixes: 955b785ec6b3 ("bonding: fix suspicious RCU usage in bond_ipsec_offload_ok()")
> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
> ---
>  drivers/net/bonding/bond_main.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 1cd92c12e782..85b5868deeea 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -599,34 +599,28 @@ static bool bond_ipsec_offload_ok(struct sk_buff *skb, struct xfrm_state *xs)
>  	struct net_device *real_dev;
>  	struct slave *curr_active;
>  	struct bonding *bond;
> -	int err;
> +	bool ok = false;
>  
>  	bond = netdev_priv(bond_dev);
>  	rcu_read_lock();
>  	curr_active = rcu_dereference(bond->curr_active_slave);
>  	real_dev = curr_active->dev;
>  
> -	if (BOND_MODE(bond) != BOND_MODE_ACTIVEBACKUP) {
> -		err = false;
> +	if (BOND_MODE(bond) != BOND_MODE_ACTIVEBACKUP)
>  		goto out;
> -	}
>  
> -	if (!xs->xso.real_dev) {
> -		err = false;
> +	if (!xs->xso.real_dev)
>  		goto out;
> -	}
>  
>  	if (!real_dev->xfrmdev_ops ||
>  	    !real_dev->xfrmdev_ops->xdo_dev_offload_ok ||
> -	    netif_is_bond_master(real_dev)) {
> -		err = false;
> +	    netif_is_bond_master(real_dev))
>  		goto out;
> -	}
>  
> -	err = real_dev->xfrmdev_ops->xdo_dev_offload_ok(skb, xs);
> +	ok = real_dev->xfrmdev_ops->xdo_dev_offload_ok(skb, xs);
>  out:
>  	rcu_read_unlock();
> -	return err;
> +	return ok;
>  }
>  
>  static const struct xfrmdev_ops bond_xfrmdev_ops = {
> -- 
> 2.44.0
> 

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

