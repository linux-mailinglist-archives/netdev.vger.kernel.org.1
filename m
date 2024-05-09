Return-Path: <netdev+bounces-94944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F19728C10C4
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 16:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 536D3B2246C
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 14:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1746F15CD7D;
	Thu,  9 May 2024 14:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OlTYuD03"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB89415CD57
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 14:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715263358; cv=none; b=SlmjH6lcQMjeXinmU2WhcJR7pNSDJmtxgEq8uLgY6kHuNSl7GWVb8qkJOf6ohauAB5vv38X47UYk0FKpeZ+wEXrGhNK09pK3FM7MFKViwazEnqWm/QKJVLgdb/m0bMUuhaKw4SE1IjELQYf+osfJYPt91Qnf2xC3eRPvV2XijJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715263358; c=relaxed/simple;
	bh=M89f4JxvDZO7Wkg1mZkwfN3E/fIofrCsbB8My3FVZXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iLayKBlSpEgF4ANn6si9tKN9q/FLW+de9yiO9pQZwwPetZVtNLkB/9Ey7bGP0UVHMbN6dV62KOCLwe/jtNhQ+3Uci4iXOhVqL/vgHSXo7pWxBUnEMUk3/DePRhCM1jHT51aKgNekt0pDFGAtVxSGkGgmmAsB9+LOQgeZANjPNno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OlTYuD03; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715263354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5ZTwxpxIm3jP8wJ5K1zCnRqK9+djnMvtRAb3oqUW/B8=;
	b=OlTYuD03WyB00A6D327dx/QjaONYA0/HMXkwz8bNJSqP0UbFjVtq3xQIBgo3/sOBaccTUk
	c7ffT7pnNxpFmJ1N7WXfC2WXPVsaGCLnh55grPEZLUNJpZBT+C0/29EDx+Liij5EeCzu70
	2nxbpsb4cDwgSR16gj/Uxqn2+YHvM38=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-TGOhQrxdNw6SLqMxBcD4-A-1; Thu, 09 May 2024 10:02:33 -0400
X-MC-Unique: TGOhQrxdNw6SLqMxBcD4-A-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-792c2650197so54207885a.0
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 07:02:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715263353; x=1715868153;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ZTwxpxIm3jP8wJ5K1zCnRqK9+djnMvtRAb3oqUW/B8=;
        b=jVYwkigwpJ6UFcz5dMLfkcOPJe1p2PgsB3T7v5oAmMvzYy80/kCQlUUXtMUSg7pDL8
         tCpkLPXj0mivZdVTdOe8d7/wczGiMghqNJdu8gnkj72mVkB+J0wk3ftZzoZIm2w9LDBx
         Dly8WHIUb4t925Cxy4+P9nLLknvrEXxRnHxvGxQNFno5aQAcvJHrgBoNa3s7XXF9Xwop
         p6b43VvGyXj5Efhs9SGUaIYKF3QWTon5zb1AZ4NHgUoZWkPxAe1xQX+QrcA1vcu15Azp
         Ah48T7v8ct/A2XcE2tXACBCUBeAC3052FjQazWPlP9E3v81IJFuat4JLJ1XXchUbTfsc
         S7Rw==
X-Forwarded-Encrypted: i=1; AJvYcCUhwxFwzhX8Qe/ddu0AJGtO9+de90AU1Inyt8X5L3HyAbmVBXa9RCLA/MgSEBIq1fqHkWRNBk7ziqNUrPBB+YelvNXRRrBv
X-Gm-Message-State: AOJu0YzSVIdyYfoBg1Io3xFpRkd4FgRBKcZqtUQrWDQiUsX9lwmIAqRN
	FZn0VAUrcK2Hh1gy9SFPYMiQYuaUqDj34rNsR2jWF9bwtm4H2bSL22GYyuzIIe/fCRyA6QizNsu
	a/OGxtDAdcBjxbQPGguJM9BQmtbQDvi+OSJ+FWuIteZaOvih5fnrsxQ==
X-Received: by 2002:a05:620a:b51:b0:792:bc5b:8420 with SMTP id af79cd13be357-792bc5b852amr275783485a.68.1715263352566;
        Thu, 09 May 2024 07:02:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvy0fly+MbgI/ymeHxiNHEtVGbsNFz/4zYAZdRXiIkiKXuJLTyNwaXJYBCzRxPik6ejxLgbA==
X-Received: by 2002:a05:620a:b51:b0:792:bc5b:8420 with SMTP id af79cd13be357-792bc5b852amr275777185a.68.1715263351828;
        Thu, 09 May 2024 07:02:31 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf315009sm70873685a.118.2024.05.09.07.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 07:02:31 -0700 (PDT)
Date: Thu, 9 May 2024 09:02:29 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Xiaolei Wang <xiaolei.wang@windriver.com>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mcoquelin.stm32@gmail.com, richardcochran@gmail.com, bartosz.golaszewski@linaro.org, 
	horms@kernel.org, rohan.g.thomas@intel.com, rmk+kernel@armlinux.org.uk, 
	fancer.lancer@gmail.com, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [net PATCH v4] net: stmmac: move the EST and EST lock to struct
 stmmac_priv
Message-ID: <5t4o3ayne7g46rt23lmiz3ksw7zfztbh6tzghojblaicw2zsbu@pv575lrpoltu>
References: <20240509123718.1521924-1-xiaolei.wang@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509123718.1521924-1-xiaolei.wang@windriver.com>

Hey Xialei Wang,

Some nitpicky comments below :)

On Thu, May 09, 2024 at 08:37:18PM GMT, Xiaolei Wang wrote:
> Reinitialize the whole EST structure would also reset the mutex lock
> which is embedded in the EST structure, and then trigger the following
> warning. To address this, move the lock to struct stmmac_priv,
> and move EST to struct stmmac_priv, because the EST configs don't look
> as the platform config, but EST is enabled in runtime with the settings

s/as/at/

> retrieved for the TC TAPRIO feature also in runtime. So it's better to
> have the EST-data preserved in the driver private date instead of the

s/date/data/

> platform data storage. We also need to require the mutex lock when doing

s/require/reacquire/

So in this patch you are:

1. Pulling the mutex protecting the EST structure out to avoid
   clearing it during reinit/memset of the EST structure
2. Moving the EST structure to a more logical location

In my opinion this would make sense in two patches, and the former patch
would have a:

    Fixes: b2aae654a479 ("net: stmmac: add mutex lock to protect est parameters")

above your Signed-off-by:. Please at least consider adding the Fixes tag!

Otherwise, this change seems good to me.

Thanks,
Andrew

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
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> ---
> v1 -> v2:
>  - move the lock to struct plat_stmmacenet_data
> v2 -> v3:
>  - Add require the mutex lock for reinitialization
> v3 -> v4
>  - Move est and est lock to stmmac_priv as suggested by Serge
> 
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  3 +
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 18 +++---
>  .../net/ethernet/stmicro/stmmac/stmmac_ptp.c  | 30 +++++-----
>  .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 58 +++++++++----------
>  include/linux/stmmac.h                        |  2 -
>  5 files changed, 56 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> index dddcaa9220cc..e05a775b463e 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> @@ -261,6 +261,9 @@ struct stmmac_priv {
>  	struct stmmac_extra_stats xstats ____cacheline_aligned_in_smp;
>  	struct stmmac_safety_stats sstats;
>  	struct plat_stmmacenet_data *plat;
> +	/* Protect est parameters */
> +	struct mutex est_lock;
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
> index e04830a3a1fb..a6b1de9a251d 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> @@ -68,13 +68,13 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
>  	nsec = reminder;
>  
>  	/* If EST is enabled, disabled it before adjust ptp time. */
> -	if (priv->plat->est && priv->plat->est->enable) {
> +	if (priv->est && priv->est->enable) {
>  		est_rst = true;
> -		mutex_lock(&priv->plat->est->lock);
> -		priv->plat->est->enable = false;
> -		stmmac_est_configure(priv, priv, priv->plat->est,
> +		mutex_lock(&priv->est_lock);
> +		priv->est->enable = false;
> +		stmmac_est_configure(priv, priv, priv->est,
>  				     priv->plat->clk_ptp_rate);
> -		mutex_unlock(&priv->plat->est->lock);
> +		mutex_unlock(&priv->est_lock);
>  	}
>  
>  	write_lock_irqsave(&priv->ptp_lock, flags);
> @@ -87,24 +87,24 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
>  		ktime_t current_time_ns, basetime;
>  		u64 cycle_time;
>  
> -		mutex_lock(&priv->plat->est->lock);
> +		mutex_lock(&priv->est_lock);
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
> -		mutex_unlock(&priv->plat->est->lock);
> +		mutex_unlock(&priv->est_lock);
>  		if (ret)
>  			netdev_err(priv->dev, "failed to configure EST\n");
>  	}
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> index cce00719937d..222540b55480 100644
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
> @@ -998,23 +996,25 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
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
> -		mutex_init(&priv->plat->est->lock);
> +		mutex_init(&priv->est_lock);
>  	} else {
> -		memset(plat->est, 0, sizeof(*plat->est));
> +		mutex_lock(&priv->est_lock);
> +		memset(priv->est, 0, sizeof(*priv->est));
> +		mutex_unlock(&priv->est_lock);
>  	}
>  
>  	size = qopt->num_entries;
>  
> -	mutex_lock(&priv->plat->est->lock);
> -	priv->plat->est->gcl_size = size;
> -	priv->plat->est->enable = qopt->cmd == TAPRIO_CMD_REPLACE;
> -	mutex_unlock(&priv->plat->est->lock);
> +	mutex_lock(&priv->est_lock);
> +	priv->est->gcl_size = size;
> +	priv->est->enable = qopt->cmd == TAPRIO_CMD_REPLACE;
> +	mutex_unlock(&priv->est_lock);
>  
>  	for (i = 0; i < size; i++) {
>  		s64 delta_ns = qopt->entries[i].interval;
> @@ -1042,33 +1042,33 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>  			return -EOPNOTSUPP;
>  		}
>  
> -		priv->plat->est->gcl[i] = delta_ns | (gates << wid);
> +		priv->est->gcl[i] = delta_ns | (gates << wid);
>  	}
>  
> -	mutex_lock(&priv->plat->est->lock);
> +	mutex_lock(&priv->est_lock);
>  	/* Adjust for real system time */
>  	priv->ptp_clock_ops.gettime64(&priv->ptp_clock_ops, &current_time);
>  	current_time_ns = timespec64_to_ktime(current_time);
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
>  	if (fpe && !priv->dma_cap.fpesel) {
> -		mutex_unlock(&priv->plat->est->lock);
> +		mutex_unlock(&priv->est_lock);
>  		return -EOPNOTSUPP;
>  	}
>  
> @@ -1077,9 +1077,9 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>  	 */
>  	priv->plat->fpe_cfg->enable = fpe;
>  
> -	ret = stmmac_est_configure(priv, priv, priv->plat->est,
> +	ret = stmmac_est_configure(priv, priv, priv->est,
>  				   priv->plat->clk_ptp_rate);
> -	mutex_unlock(&priv->plat->est->lock);
> +	mutex_unlock(&priv->est_lock);
>  	if (ret) {
>  		netdev_err(priv->dev, "failed to configure EST\n");
>  		goto disable;
> @@ -1095,17 +1095,17 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>  	return 0;
>  
>  disable:
> -	if (priv->plat->est) {
> -		mutex_lock(&priv->plat->est->lock);
> -		priv->plat->est->enable = false;
> -		stmmac_est_configure(priv, priv, priv->plat->est,
> +	if (priv->est) {
> +		mutex_lock(&priv->est_lock);
> +		priv->est->enable = false;
> +		stmmac_est_configure(priv, priv, priv->est,
>  				     priv->plat->clk_ptp_rate);
>  		/* Reset taprio status */
>  		for (i = 0; i < priv->plat->tx_queues_to_use; i++) {
>  			priv->xstats.max_sdu_txq_drop[i] = 0;
>  			priv->xstats.mtl_est_txq_hlbf[i] = 0;
>  		}
> -		mutex_unlock(&priv->plat->est->lock);
> +		mutex_unlock(&priv->est_lock);
>  	}
>  
>  	priv->plat->fpe_cfg->enable = false;
> diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> index dfa1828cd756..8aa255485a35 100644
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
> @@ -246,7 +245,6 @@ struct plat_stmmacenet_data {
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


