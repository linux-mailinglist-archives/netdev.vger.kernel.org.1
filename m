Return-Path: <netdev+bounces-96074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5B18C43A8
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 17:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 846B0B22FF4
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 15:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7504F4C62;
	Mon, 13 May 2024 15:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="etqs3r4H"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BFC4A35
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 15:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715612669; cv=none; b=sXY+x/cOzCcfTwu5o1azmmbi027AXXJeRkrxihbgNxm9quNIFzHK2goerkCuDkfccFKGbccLPVySbzR4cvMxFBbUmR2LOwjcbEz0HI2S2jNpzww8jNizMbXj78r2iO2A0dn0slrgemPOPEpcV8Du8Jj48DLUni2GXj/0eG86uxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715612669; c=relaxed/simple;
	bh=Y4cgtybKrVbogclcdn+EC8EjlXPJSlKIuVgB78gSBH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GSDflK8CL6IQpEq5Gemec99/vLZjSOg8jEIltqaqc7Q11+MqL+RpRg917PTJccJDACWKzr7UPBdVQ3xUU3ThAprxRbIviWvEqASbS+pm1q6BKpior0V7YEMdvWM20Ud1f0ANmZZy3Pi60h4aMPwsjfLildwZCtf2WhcWWuA5DaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=etqs3r4H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715612666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RTW29I4CyELTNosgb5eLNanHw8DFrZrqRr6uqkajeWw=;
	b=etqs3r4H7RaNFO02Rommu27HpDtfVnB4u/J3KXxiLLNKMb65XGaDnt0BXl14zfN0Y45u8B
	qL8vQ6Kd0Ony9cw8aG8yeS6aAp5KnYsniWia3X4INBxLt6ctRGVs7kf4lSlsiSddNgkMP8
	5GkwsCpN/EHM3h72xcmKudGCnm9VIvk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-DGpa25bsMWiROv3HSG9Qrw-1; Mon, 13 May 2024 11:04:23 -0400
X-MC-Unique: DGpa25bsMWiROv3HSG9Qrw-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-792c707ca4aso342190485a.1
        for <netdev@vger.kernel.org>; Mon, 13 May 2024 08:04:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715612663; x=1716217463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RTW29I4CyELTNosgb5eLNanHw8DFrZrqRr6uqkajeWw=;
        b=uKUBNVqohPG7Dp+v0kYynUhqx2v9HPS/bPWjdcc2aI7TettxXsI2GRWEgDgidz258R
         xESNbgvMcHPXBWyOrjrf8YWgibTI55Kt3JH9FKhTvr0cEM/2sZGz/06bfND2xtD7o0TN
         Rxrazw7m1h5jMQuUQ2wnT95/8Nqfs6Qr2woNP/frsHi30o0Cll2GwNaAIIGgbKQ+ZPgl
         ZFIv3VBbx9Ctgm3fg8LSbphQWXOmOrO6p7dmT0iosd3nRqsf6FgMg1/g5Tl+W0ZRtooK
         mjqA5o/txKbM4OguA/uOQuPqi+vUTI8LvjDnotcZCBp2912I4YT5EhDVOu0aHkF4VvSY
         21lA==
X-Forwarded-Encrypted: i=1; AJvYcCV3fra5gtAJzTfo807nmjaO+DmoGmhofO+mLeDmbiW6jexcTa99pVnd7IguzuIkp1N/WFcHGx+7yQPVnSAeTzN2hmyPPl86
X-Gm-Message-State: AOJu0YwTemQSNeqm6w7vuAUUt+D8SDz25t5f/6TNM/s80Rfgx8r3CvpE
	n65cTG9VDByzI7gbQbKbWOtWG7kz/T1WocafKHTBd9iUWz5MaffXkS3gEQsAnpqWOntuVV2SpGQ
	MQMtYYbP9bREDyvI5QxTzPr5aysJbFdelsQhDV2JsO51EJb0hdAsf5A==
X-Received: by 2002:a05:620a:5dda:b0:792:c02c:a979 with SMTP id af79cd13be357-792c7597db8mr1114506185a.23.1715612662973;
        Mon, 13 May 2024 08:04:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwCNTOyFP8kkdVD3hcINZqHo9Fx3MQUnlhQroroknttLiIYTJKYfRCO1rmF9ivXSg9sdMWZg==
X-Received: by 2002:a05:620a:5dda:b0:792:c02c:a979 with SMTP id af79cd13be357-792c7597db8mr1114500985a.23.1715612662435;
        Mon, 13 May 2024 08:04:22 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf27779fsm462541085a.21.2024.05.13.08.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 08:04:21 -0700 (PDT)
Date: Mon, 13 May 2024 10:04:19 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Xiaolei Wang <xiaolei.wang@windriver.com>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mcoquelin.stm32@gmail.com, richardcochran@gmail.com, bartosz.golaszewski@linaro.org, 
	horms@kernel.org, rohan.g.thomas@intel.com, rmk+kernel@armlinux.org.uk, 
	fancer.lancer@gmail.com, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [net PATCH v6 1/2] net: stmmac: move the EST lock to struct
 stmmac_priv
Message-ID: <7qiunwxhvxpembddu6lfg32pec67rhlph3uuqxezey4zd64ig4@wocacehc5lws>
References: <20240513014346.1718740-1-xiaolei.wang@windriver.com>
 <20240513014346.1718740-2-xiaolei.wang@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513014346.1718740-2-xiaolei.wang@windriver.com>

On Mon, May 13, 2024 at 09:43:45AM GMT, Xiaolei Wang wrote:
> Reinitialize the whole EST structure would also reset the mutex
> lock which is embedded in the EST structure, and then trigger
> the following warning. To address this, move the lock to struct
> stmmac_priv. We also need to reacquire the mutex lock when doing
> this initialization.
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
> Fixes: b2aae654a479 ("net: stmmac: add mutex lock to protect est parameters")
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h   |  2 ++
>  .../net/ethernet/stmicro/stmmac/stmmac_ptp.c   |  8 ++++----
>  .../net/ethernet/stmicro/stmmac/stmmac_tc.c    | 18 ++++++++++--------
>  include/linux/stmmac.h                         |  1 -
>  4 files changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> index dddcaa9220cc..64b21c83e2b8 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> @@ -261,6 +261,8 @@ struct stmmac_priv {
>  	struct stmmac_extra_stats xstats ____cacheline_aligned_in_smp;
>  	struct stmmac_safety_stats sstats;
>  	struct plat_stmmacenet_data *plat;
> +	/* Protect est parameters */
> +	struct mutex est_lock;
>  	struct dma_features dma_cap;
>  	struct stmmac_counters mmc;
>  	int hw_cap_support;
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> index e04830a3a1fb..0c5aab6dd7a7 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> @@ -70,11 +70,11 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
>  	/* If EST is enabled, disabled it before adjust ptp time. */
>  	if (priv->plat->est && priv->plat->est->enable) {
>  		est_rst = true;
> -		mutex_lock(&priv->plat->est->lock);
> +		mutex_lock(&priv->est_lock);
>  		priv->plat->est->enable = false;
>  		stmmac_est_configure(priv, priv, priv->plat->est,
>  				     priv->plat->clk_ptp_rate);
> -		mutex_unlock(&priv->plat->est->lock);
> +		mutex_unlock(&priv->est_lock);
>  	}
>  
>  	write_lock_irqsave(&priv->ptp_lock, flags);
> @@ -87,7 +87,7 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
>  		ktime_t current_time_ns, basetime;
>  		u64 cycle_time;
>  
> -		mutex_lock(&priv->plat->est->lock);
> +		mutex_lock(&priv->est_lock);
>  		priv->ptp_clock_ops.gettime64(&priv->ptp_clock_ops, &current_time);
>  		current_time_ns = timespec64_to_ktime(current_time);
>  		time.tv_nsec = priv->plat->est->btr_reserve[0];
> @@ -104,7 +104,7 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
>  		priv->plat->est->enable = true;
>  		ret = stmmac_est_configure(priv, priv, priv->plat->est,
>  					   priv->plat->clk_ptp_rate);
> -		mutex_unlock(&priv->plat->est->lock);
> +		mutex_unlock(&priv->est_lock);
>  		if (ret)
>  			netdev_err(priv->dev, "failed to configure EST\n");
>  	}
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> index cce00719937d..620c16e9be3a 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> @@ -1004,17 +1004,19 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>  		if (!plat->est)
>  			return -ENOMEM;
>  
> -		mutex_init(&priv->plat->est->lock);
> +		mutex_init(&priv->est_lock);
>  	} else {
> +		mutex_lock(&priv->est_lock);
>  		memset(plat->est, 0, sizeof(*plat->est));
> +		mutex_unlock(&priv->est_lock);
>  	}
>  
>  	size = qopt->num_entries;
>  
> -	mutex_lock(&priv->plat->est->lock);
> +	mutex_lock(&priv->est_lock);
>  	priv->plat->est->gcl_size = size;
>  	priv->plat->est->enable = qopt->cmd == TAPRIO_CMD_REPLACE;
> -	mutex_unlock(&priv->plat->est->lock);
> +	mutex_unlock(&priv->est_lock);
>  
>  	for (i = 0; i < size; i++) {
>  		s64 delta_ns = qopt->entries[i].interval;
> @@ -1045,7 +1047,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>  		priv->plat->est->gcl[i] = delta_ns | (gates << wid);
>  	}
>  
> -	mutex_lock(&priv->plat->est->lock);
> +	mutex_lock(&priv->est_lock);
>  	/* Adjust for real system time */
>  	priv->ptp_clock_ops.gettime64(&priv->ptp_clock_ops, &current_time);
>  	current_time_ns = timespec64_to_ktime(current_time);
> @@ -1068,7 +1070,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>  	tc_taprio_map_maxsdu_txq(priv, qopt);
>  
>  	if (fpe && !priv->dma_cap.fpesel) {
> -		mutex_unlock(&priv->plat->est->lock);
> +		mutex_unlock(&priv->est_lock);
>  		return -EOPNOTSUPP;
>  	}
>  
> @@ -1079,7 +1081,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>  
>  	ret = stmmac_est_configure(priv, priv, priv->plat->est,
>  				   priv->plat->clk_ptp_rate);
> -	mutex_unlock(&priv->plat->est->lock);
> +	mutex_unlock(&priv->est_lock);
>  	if (ret) {
>  		netdev_err(priv->dev, "failed to configure EST\n");
>  		goto disable;
> @@ -1096,7 +1098,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>  
>  disable:
>  	if (priv->plat->est) {
> -		mutex_lock(&priv->plat->est->lock);
> +		mutex_lock(&priv->est_lock);
>  		priv->plat->est->enable = false;
>  		stmmac_est_configure(priv, priv, priv->plat->est,
>  				     priv->plat->clk_ptp_rate);
> @@ -1105,7 +1107,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>  			priv->xstats.max_sdu_txq_drop[i] = 0;
>  			priv->xstats.mtl_est_txq_hlbf[i] = 0;
>  		}
> -		mutex_unlock(&priv->plat->est->lock);
> +		mutex_unlock(&priv->est_lock);
>  	}
>  
>  	priv->plat->fpe_cfg->enable = false;
> diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> index dfa1828cd756..c0d74f97fd18 100644
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
> -- 
> 2.25.1
> 


