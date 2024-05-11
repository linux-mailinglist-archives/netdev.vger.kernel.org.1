Return-Path: <netdev+bounces-95736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 089478C3312
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 20:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34F551C20A4E
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 18:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477041C6B7;
	Sat, 11 May 2024 18:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KY7iQZW6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D861BC41;
	Sat, 11 May 2024 18:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715451020; cv=none; b=DSmfKh9jCxVerYrFIFfmz4Vzu0GqAMkw5d8gO/tpmweMysSmMDDSgJHoc+IodsXSm0cmAIcWlQzdKe6kY1oL9RtHxW5xwbG4EaypfyuaPAfQD5KJ2MDCr5ukxawSA5GWkO7rN2PLL5cyXjck0VOZ3j/3iH9uEwuS6nK8vj6DoCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715451020; c=relaxed/simple;
	bh=AeqlypXQUONSOwJW81p3YuA9Ltg5IDQt7lRQn5lqXSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d6tveiIfKgSz60OHMUDACb4JdZExdKeM6jxbPGbsSwSbRsVrbP4d9jHuMm9RQCtZj0iWnKslTRlRq4u+IF9eTRX/GJkbiFtBa6HuXYHdsGG/eY7JeIYgobPGE9WR+24xSucAgNAnW5B13mGpaYw4oVyo6RN4YKbfpQ0kKzezFzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KY7iQZW6; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2e27277d2c1so39230351fa.2;
        Sat, 11 May 2024 11:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715451016; x=1716055816; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+X8Pgw9b1n09f4if+qG52s1rC7sizSyA5jgd5Lg9bZc=;
        b=KY7iQZW62cnKWrXuF13V+5sghZyULbF2AfdGYZ2vlPbOTwC6MR9L1jdkVhbctawuLV
         QQSYKb1ySvCd6qRDV39q4Q0hqSWwcNXHavdwQoMzDgJXGOmBoxGu1wXFHfA/99znbVit
         /Q4gYXV0zuo1nbcZ3SCPDLquLQx6v26ZyYlS0A9qeSQsDIgxGF8coFBKoiIFqK2YNTuZ
         pQMRW2ACJpDBFt48TGtzUK+svyRINKwHKnGBNFb9qm7TmkY1KRlwTvJNx19QuWXgaKR0
         W4AfL3Wft/cDoPZwiN/u3QX61958N6s74RJcYR8LpQK5K3B2qEaPmK7OkikHq3lCxUHu
         nSAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715451016; x=1716055816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+X8Pgw9b1n09f4if+qG52s1rC7sizSyA5jgd5Lg9bZc=;
        b=h8uyWm8vVSWlcENjytmJ71Z/+JVt5fjd+rZFdVkqdqlKnG+RaV4j6meKu2luEDJvsx
         2Z53Vk5L9fTP9ItiBQ2TjlX0GRJzTu5ywACKv/kGOwBvNT1hRkUPgH8beDfkeQDxG+w6
         bn6VBJG8u8CUC5lh7wK02RBzbepATdW8IdBqHmztbEa+TSh4TcUeKF4SFDFzZLIm5MCc
         +i7ieXaxRYIm52kjnB1k6tF/FSdzOmATe1IU0zXdHlQVlv7B4uSP8OoGo6K9ohLrKDQq
         EbHUO1Pvw8Yxiv7TBlJPmZm1EilXFyxrIHDcJ0bfegXMqcf5q1z4j//vgwSEBZtBWnT/
         JuGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDub3HI2c2+sFAa3VHsJ7PdD9pRsztE7ODwHYE+vsVYDzXLBkJ82+KAFP+OhjoFzvpUUwq86/pekwgm3+QIs5IWo97eCN0Wt/CPF/QDgrQFxxVzgVqSiQxA+FlgYx0N+UjRGfy
X-Gm-Message-State: AOJu0YwUgIlJSJlAyiymmrQjS0aw95W9rOULCHgDZ3P4sMfuiuvq84Q+
	4ZpabsVY2/F1fwh9p+QndA6D4D264ciX3VXZsNNGGRDLf0Q8KcrZ
X-Google-Smtp-Source: AGHT+IH5zn2XCaRhqMIWEDIu5V5GLtDvMGnI/qgcYg25IdLGKgEdc9rWt3zK6m0FdqglAc+aEbJ31A==
X-Received: by 2002:ac2:5e67:0:b0:51b:f78d:c189 with SMTP id 2adb3069b0e04-5220fb69910mr3323287e87.14.1715451015776;
        Sat, 11 May 2024 11:10:15 -0700 (PDT)
Received: from mobilestation ([95.79.182.53])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f35ba49asm1049692e87.64.2024.05.11.11.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 May 2024 11:10:15 -0700 (PDT)
Date: Sat, 11 May 2024 21:10:13 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Xiaolei Wang <xiaolei.wang@windriver.com>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mcoquelin.stm32@gmail.com, richardcochran@gmail.com, bartosz.golaszewski@linaro.org, 
	horms@kernel.org, rohan.g.thomas@intel.com, rmk+kernel@armlinux.org.uk, 
	ahalaney@redhat.com, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [net PATCH v5 2/2] net: stmmac: move the EST structure to struct
 stmmac_priv
Message-ID: <j2lpk7afsuitkdgalkwlihpcrjsrxz3eeihiy2hwbuswxmhhkl@qk23rovif2mq>
References: <20240510122155.3394723-1-xiaolei.wang@windriver.com>
 <20240510122155.3394723-3-xiaolei.wang@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510122155.3394723-3-xiaolei.wang@windriver.com>

On Fri, May 10, 2024 at 08:21:55PM +0800, Xiaolei Wang wrote:
> Move the EST structure to struct stmmac_priv, because the
> EST configs don't look like platform config, but EST is
> enabled in runtime with the settings retrieved for the TC
> TAPRIO feature also in runtime. So it's better to have the
> EST-data preserved in the driver private data instead of
> the platform data storage.

As Simon correctly noted this isn't a fix, so the patch was supposed
to be submitted for the net-next tree.

> 
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  1 +
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 18 ++++-----
>  .../net/ethernet/stmicro/stmmac/stmmac_ptp.c  | 22 +++++-----
>  .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 40 +++++++++----------
>  include/linux/stmmac.h                        |  1 -
>  5 files changed, 40 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> index 64b21c83e2b8..e05a775b463e 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h

Seeing you'll likely need to resubmit the patch against the net-next
tree please move the stmmac_est structure declaration from 
include/linux/stmmac.h
to
drivers/net/ethernet/stmicro/stmmac/stmmac.h
since there is no longer point in having stmmac_est declared in the
former file, and the pointer to the structure is going to be preserved
in the stmmac_priv structure now which is declared in the later header
file.

With the above done feel free to add
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

Thanks
-Serge(y)

> @@ -263,6 +263,7 @@ struct stmmac_priv {
>  	struct plat_stmmacenet_data *plat;
>  	/* Protect est parameters */
>  	struct mutex est_lock;
> +	struct stmmac_est *est;
>  	struct dma_features dma_cap;
>  	struct stmmac_counters mmc;
>  	int hw_cap_support;
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 7c6fb14b5555..0eafd609bf53 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -2491,9 +2491,9 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
>  		if (!xsk_tx_peek_desc(pool, &xdp_desc))
>  			break;
>  
> -		if (priv->plat->est && priv->plat->est->enable &&
> -		    priv->plat->est->max_sdu[queue] &&
> -		    xdp_desc.len > priv->plat->est->max_sdu[queue]) {
> +		if (priv->est && priv->est->enable &&
> +		    priv->est->max_sdu[queue] &&
> +		    xdp_desc.len > priv->est->max_sdu[queue]) {
>  			priv->xstats.max_sdu_txq_drop[queue]++;
>  			continue;
>  		}
> @@ -4528,9 +4528,9 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
>  			return stmmac_tso_xmit(skb, dev);
>  	}
>  
> -	if (priv->plat->est && priv->plat->est->enable &&
> -	    priv->plat->est->max_sdu[queue] &&
> -	    skb->len > priv->plat->est->max_sdu[queue]){
> +	if (priv->est && priv->est->enable &&
> +	    priv->est->max_sdu[queue] &&
> +	    skb->len > priv->est->max_sdu[queue]){
>  		priv->xstats.max_sdu_txq_drop[queue]++;
>  		goto max_sdu_err;
>  	}
> @@ -4909,9 +4909,9 @@ static int stmmac_xdp_xmit_xdpf(struct stmmac_priv *priv, int queue,
>  	if (stmmac_tx_avail(priv, queue) < STMMAC_TX_THRESH(priv))
>  		return STMMAC_XDP_CONSUMED;
>  
> -	if (priv->plat->est && priv->plat->est->enable &&
> -	    priv->plat->est->max_sdu[queue] &&
> -	    xdpf->len > priv->plat->est->max_sdu[queue]) {
> +	if (priv->est && priv->est->enable &&
> +	    priv->est->max_sdu[queue] &&
> +	    xdpf->len > priv->est->max_sdu[queue]) {
>  		priv->xstats.max_sdu_txq_drop[queue]++;
>  		return STMMAC_XDP_CONSUMED;
>  	}
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> index 0c5aab6dd7a7..a6b1de9a251d 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> @@ -68,11 +68,11 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
>  	nsec = reminder;
>  
>  	/* If EST is enabled, disabled it before adjust ptp time. */
> -	if (priv->plat->est && priv->plat->est->enable) {
> +	if (priv->est && priv->est->enable) {
>  		est_rst = true;
>  		mutex_lock(&priv->est_lock);
> -		priv->plat->est->enable = false;
> -		stmmac_est_configure(priv, priv, priv->plat->est,
> +		priv->est->enable = false;
> +		stmmac_est_configure(priv, priv, priv->est,
>  				     priv->plat->clk_ptp_rate);
>  		mutex_unlock(&priv->est_lock);
>  	}
> @@ -90,19 +90,19 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
>  		mutex_lock(&priv->est_lock);
>  		priv->ptp_clock_ops.gettime64(&priv->ptp_clock_ops, &current_time);
>  		current_time_ns = timespec64_to_ktime(current_time);
> -		time.tv_nsec = priv->plat->est->btr_reserve[0];
> -		time.tv_sec = priv->plat->est->btr_reserve[1];
> +		time.tv_nsec = priv->est->btr_reserve[0];
> +		time.tv_sec = priv->est->btr_reserve[1];
>  		basetime = timespec64_to_ktime(time);
> -		cycle_time = (u64)priv->plat->est->ctr[1] * NSEC_PER_SEC +
> -			     priv->plat->est->ctr[0];
> +		cycle_time = (u64)priv->est->ctr[1] * NSEC_PER_SEC +
> +			     priv->est->ctr[0];
>  		time = stmmac_calc_tas_basetime(basetime,
>  						current_time_ns,
>  						cycle_time);
>  
> -		priv->plat->est->btr[0] = (u32)time.tv_nsec;
> -		priv->plat->est->btr[1] = (u32)time.tv_sec;
> -		priv->plat->est->enable = true;
> -		ret = stmmac_est_configure(priv, priv, priv->plat->est,
> +		priv->est->btr[0] = (u32)time.tv_nsec;
> +		priv->est->btr[1] = (u32)time.tv_sec;
> +		priv->est->enable = true;
> +		ret = stmmac_est_configure(priv, priv, priv->est,
>  					   priv->plat->clk_ptp_rate);
>  		mutex_unlock(&priv->est_lock);
>  		if (ret)
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> index 620c16e9be3a..222540b55480 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> @@ -918,7 +918,6 @@ struct timespec64 stmmac_calc_tas_basetime(ktime_t old_base_time,
>  static void tc_taprio_map_maxsdu_txq(struct stmmac_priv *priv,
>  				     struct tc_taprio_qopt_offload *qopt)
>  {
> -	struct plat_stmmacenet_data *plat = priv->plat;
>  	u32 num_tc = qopt->mqprio.qopt.num_tc;
>  	u32 offset, count, i, j;
>  
> @@ -933,7 +932,7 @@ static void tc_taprio_map_maxsdu_txq(struct stmmac_priv *priv,
>  		count = qopt->mqprio.qopt.count[i];
>  
>  		for (j = offset; j < offset + count; j++)
> -			plat->est->max_sdu[j] = qopt->max_sdu[i] + ETH_HLEN - ETH_TLEN;
> +			priv->est->max_sdu[j] = qopt->max_sdu[i] + ETH_HLEN - ETH_TLEN;
>  	}
>  }
>  
> @@ -941,7 +940,6 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>  			       struct tc_taprio_qopt_offload *qopt)
>  {
>  	u32 size, wid = priv->dma_cap.estwid, dep = priv->dma_cap.estdep;
> -	struct plat_stmmacenet_data *plat = priv->plat;
>  	struct timespec64 time, current_time, qopt_time;
>  	ktime_t current_time_ns;
>  	bool fpe = false;
> @@ -998,24 +996,24 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>  	if (qopt->cycle_time_extension >= BIT(wid + 7))
>  		return -ERANGE;
>  
> -	if (!plat->est) {
> -		plat->est = devm_kzalloc(priv->device, sizeof(*plat->est),
> +	if (!priv->est) {
> +		priv->est = devm_kzalloc(priv->device, sizeof(*priv->est),
>  					 GFP_KERNEL);
> -		if (!plat->est)
> +		if (!priv->est)
>  			return -ENOMEM;
>  
>  		mutex_init(&priv->est_lock);
>  	} else {
>  		mutex_lock(&priv->est_lock);
> -		memset(plat->est, 0, sizeof(*plat->est));
> +		memset(priv->est, 0, sizeof(*priv->est));
>  		mutex_unlock(&priv->est_lock);
>  	}
>  
>  	size = qopt->num_entries;
>  
>  	mutex_lock(&priv->est_lock);
> -	priv->plat->est->gcl_size = size;
> -	priv->plat->est->enable = qopt->cmd == TAPRIO_CMD_REPLACE;
> +	priv->est->gcl_size = size;
> +	priv->est->enable = qopt->cmd == TAPRIO_CMD_REPLACE;
>  	mutex_unlock(&priv->est_lock);
>  
>  	for (i = 0; i < size; i++) {
> @@ -1044,7 +1042,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>  			return -EOPNOTSUPP;
>  		}
>  
> -		priv->plat->est->gcl[i] = delta_ns | (gates << wid);
> +		priv->est->gcl[i] = delta_ns | (gates << wid);
>  	}
>  
>  	mutex_lock(&priv->est_lock);
> @@ -1054,18 +1052,18 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>  	time = stmmac_calc_tas_basetime(qopt->base_time, current_time_ns,
>  					qopt->cycle_time);
>  
> -	priv->plat->est->btr[0] = (u32)time.tv_nsec;
> -	priv->plat->est->btr[1] = (u32)time.tv_sec;
> +	priv->est->btr[0] = (u32)time.tv_nsec;
> +	priv->est->btr[1] = (u32)time.tv_sec;
>  
>  	qopt_time = ktime_to_timespec64(qopt->base_time);
> -	priv->plat->est->btr_reserve[0] = (u32)qopt_time.tv_nsec;
> -	priv->plat->est->btr_reserve[1] = (u32)qopt_time.tv_sec;
> +	priv->est->btr_reserve[0] = (u32)qopt_time.tv_nsec;
> +	priv->est->btr_reserve[1] = (u32)qopt_time.tv_sec;
>  
>  	ctr = qopt->cycle_time;
> -	priv->plat->est->ctr[0] = do_div(ctr, NSEC_PER_SEC);
> -	priv->plat->est->ctr[1] = (u32)ctr;
> +	priv->est->ctr[0] = do_div(ctr, NSEC_PER_SEC);
> +	priv->est->ctr[1] = (u32)ctr;
>  
> -	priv->plat->est->ter = qopt->cycle_time_extension;
> +	priv->est->ter = qopt->cycle_time_extension;
>  
>  	tc_taprio_map_maxsdu_txq(priv, qopt);
>  
> @@ -1079,7 +1077,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>  	 */
>  	priv->plat->fpe_cfg->enable = fpe;
>  
> -	ret = stmmac_est_configure(priv, priv, priv->plat->est,
> +	ret = stmmac_est_configure(priv, priv, priv->est,
>  				   priv->plat->clk_ptp_rate);
>  	mutex_unlock(&priv->est_lock);
>  	if (ret) {
> @@ -1097,10 +1095,10 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>  	return 0;
>  
>  disable:
> -	if (priv->plat->est) {
> +	if (priv->est) {
>  		mutex_lock(&priv->est_lock);
> -		priv->plat->est->enable = false;
> -		stmmac_est_configure(priv, priv, priv->plat->est,
> +		priv->est->enable = false;
> +		stmmac_est_configure(priv, priv, priv->est,
>  				     priv->plat->clk_ptp_rate);
>  		/* Reset taprio status */
>  		for (i = 0; i < priv->plat->tx_queues_to_use; i++) {
> diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> index c0d74f97fd18..8aa255485a35 100644
> --- a/include/linux/stmmac.h
> +++ b/include/linux/stmmac.h
> @@ -245,7 +245,6 @@ struct plat_stmmacenet_data {
>  	struct fwnode_handle *port_node;
>  	struct device_node *mdio_node;
>  	struct stmmac_dma_cfg *dma_cfg;
> -	struct stmmac_est *est;
>  	struct stmmac_fpe_cfg *fpe_cfg;
>  	struct stmmac_safety_feature_cfg *safety_feat_cfg;
>  	int clk_csr;
> -- 
> 2.25.1
> 

