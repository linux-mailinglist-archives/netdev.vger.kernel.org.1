Return-Path: <netdev+bounces-119713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CC8956B00
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 14:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 797131C219C6
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 12:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8850016B397;
	Mon, 19 Aug 2024 12:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y53mTtL0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729A01D696;
	Mon, 19 Aug 2024 12:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724071141; cv=none; b=OJvCdJZMFaTPOEJZNLNoDA2J/ehRmwQjc8+ljRa3YxiuYljcT/3ih32bsC/ZFwqdChmQJSIRLBhGkz+MT1/vzoMxzpRnyTDne1/lHFgz2zTOuXKcBKKVk19SuLvfR+S/jLaIgaPM/dFV41d3AEsKDCUQwE235LSqGI9cl7SefFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724071141; c=relaxed/simple;
	bh=Lt7kcqup8e2AT40M6EHiR9PGMZ6OLvMlW7KU2pQZH9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NN+phCy8VRBkXLEoPemt2gyC9DIEUpGQWD/q7klAnbRqbEgrZJ7p1530uImLAUxJyxwHLx8BOOhkus8U6D66n8ezov/Qsm8hxsuk/E1CFuGrIE0k6IIgbjM9O0eTPdBGwTK+LSbzxwv1BVU4nCugR01FHs1J8dAmPS+HGXmd8KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y53mTtL0; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ef2d96164aso50715791fa.3;
        Mon, 19 Aug 2024 05:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724071137; x=1724675937; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rbJWDPdJVbQfKRSb7v4Ofvu2EYmBmMWPzeLc8ysoEf4=;
        b=Y53mTtL0XXCRmVgZwMdT0vup1rohsX1lk61c83N3JDt7drD8LG1fGIUGoQEFZ6q+2Z
         KsBT4NIa5pLxkJ57jpfAL7YulJM0AgvevzjXP4jP0jTF4dJl4eRPgB1q4zkANd8RNN6H
         eWg1Tmr9wfoPlTBRdUGHUTIJ4aNM/XnThFgJE8xoJg+0HxlbAh8WJBIxyK8sQleLO04D
         iWQRQJjcj7tuXtFo3rvJ6Cylep/o9GUdt3A6rKJzxILcWNmXltwyVPgRM/cqR/gNA1+p
         foKDx2vawCqmd7JeA0iTMacL4XLtr5DtTjX2q6ESHHkeOd2CdMNG/fOjv23rueBfFoo1
         9czA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724071137; x=1724675937;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rbJWDPdJVbQfKRSb7v4Ofvu2EYmBmMWPzeLc8ysoEf4=;
        b=E/QPh2EfvGSlfFMUlTwaAF1KwhYE15z+cHh3NBewTHc0Hvxxe2VAglgwXuaZUHFBh2
         yyiGO0Zc8ALbE0e0Y4pPKpT7AmG4PAnOiZwm+LDofuh0ZK/7kDK7o/JWpXd20+FnoBho
         SNWLo/r1pkKzwUGr13LpVX32lrMv0uxEUEJAvSKf6vZOzHYy71UZu6myXFOXoMQficc4
         DDH4RRVlrfoABstEKPz3AVUOMXsBwabX1SynmQPLQYQxxMdlWz5Ri7+Iw1eoh5MewrTA
         y7L20IcSBV99R9KpNbKcNwdFzxZyYv54a4Pa5YPZaTBWhOhY3/N9Vfwuzslyt0T18sf3
         OgkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUP/wNB2uOwgnNAAPfByr7wQne9MYbHrU8iAlBEenPqXeUz5zZUTE3FIMXccM0NOUiFqWxmjed8yaZHwunL6GNSfJAXDJoGTplzorM7fLtlcHhD7cRdrLNrXagVeO2hj9vB6v70
X-Gm-Message-State: AOJu0Yz1RjLo1O6/oG5QfSDJRAdDDz3r04FLW70dzfVvriZg1ov5/47J
	1+MUWmmOqvnFMJ0PxrnMUrBazOZAt7ptrwchnVFM0soi1A81Y+b7VLvxIw==
X-Google-Smtp-Source: AGHT+IHjVtUiFGdvZt9U3XzNKewVSldj32BhTddiebEgBlWtPyQVtAGYLJ3iza2b9OaGHVj0Gf+9yw==
X-Received: by 2002:a2e:9d44:0:b0:2f0:1fd5:2f29 with SMTP id 38308e7fff4ca-2f3be586ab8mr69525311fa.19.1724071136978;
        Mon, 19 Aug 2024 05:38:56 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f3b771eee0sm14923951fa.121.2024.08.19.05.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 05:38:56 -0700 (PDT)
Date: Mon, 19 Aug 2024 15:38:53 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Joao Pinto <jpinto@synopsys.com>, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, xfr@outlook.com
Subject: Re: [PATCH net-next v3 1/7] net: stmmac: move stmmac_fpe_cfg to
 stmmac_priv data
Message-ID: <em2izdbwkycbbgytbm7gysvfpjfi5wnez5hq7c2ku3qjzogd4z@6m2tr6m2x6dq>
References: <cover.1724051326.git.0x1207@gmail.com>
 <b1e63dfc1ca886f11ed0e9ae80fca16082de905e.1724051326.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1e63dfc1ca886f11ed0e9ae80fca16082de905e.1724051326.git.0x1207@gmail.com>

On Mon, Aug 19, 2024 at 03:25:14PM +0800, Furong Xu wrote:
> By moving the fpe_cfg field to the stmmac_priv data, stmmac_fpe_cfg
> becomes platform-data eventually, instead of a run-time config.
> 
> Suggested-by: Serge Semin <fancer.lancer@gmail.com>
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/hwif.h    |  2 ++
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h  | 29 +++++++++++++++++++
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 20 ++++++-------
>  .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 16 ++--------
>  include/linux/stmmac.h                        | 28 ------------------
>  5 files changed, 44 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> index 7e90f34b8c88..28dfc0054a3a 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> @@ -31,6 +31,8 @@ struct stmmac_safety_stats;
>  struct dma_desc;
>  struct dma_extended_desc;
>  struct dma_edesc;

> +struct stmmac_fpe_cfg;
> +enum stmmac_mpacket_type;

Please move these being declared above struct dma_desc, so to group up
the stmmac_-prefixed entities declarations.

>  
>  /* Descriptors helpers */
>  struct stmmac_desc_ops {
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> index b23b920eedb1..2c2181febb39 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> @@ -146,6 +146,33 @@ struct stmmac_channel {
>  	u32 index;
>  };
>  
> +/* FPE link state */
> +enum stmmac_fpe_state {
> +	FPE_STATE_OFF = 0,
> +	FPE_STATE_CAPABLE = 1,
> +	FPE_STATE_ENTERING_ON = 2,
> +	FPE_STATE_ON = 3,
> +};
> +
> +/* FPE link-partner hand-shaking mPacket type */
> +enum stmmac_mpacket_type {
> +	MPACKET_VERIFY = 0,
> +	MPACKET_RESPONSE = 1,
> +};
> +
> +enum stmmac_fpe_task_state_t {
> +	__FPE_REMOVING,
> +	__FPE_TASK_SCHED,
> +};
> +
> +struct stmmac_fpe_cfg {
> +	bool enable;				/* FPE enable */
> +	bool hs_enable;				/* FPE handshake enable */
> +	enum stmmac_fpe_state lp_fpe_state;	/* Link Partner FPE state */
> +	enum stmmac_fpe_state lo_fpe_state;	/* Local station FPE state */
> +	u32 fpe_csr;				/* MAC_FPE_CTRL_STS reg cache */
> +};
> +
>  struct stmmac_tc_entry {
>  	bool in_use;
>  	bool in_hw;
> @@ -339,6 +366,8 @@ struct stmmac_priv {
>  	struct workqueue_struct *wq;
>  	struct work_struct service_task;
>  

> +	struct stmmac_fpe_cfg fpe_cfg;
> +

Could you please move this field to being joined with the
FPE Workqueue-related stuff in the structure? Like this:

-	/* Workqueue for handling FPE hand-shaking */
+	/* Frame Preemption feature (FPE) */
	unsigned long fpe_task_state;
	struct workqueue_struct *fpe_wq;
	struct work_struct fpe_task;
	char wq_name[IFNAMSIZ + 4];
+	struct stmmac_fpe_cfg fpe_cfg;

So the FPE-related fields would be grouped together as it's done for
the TC, PPS, RSS, XDP features.

Other than that the change looks good.

Thanks
-Serge(y)

>  	/* Workqueue for handling FPE hand-shaking */
>  	unsigned long fpe_task_state;
>  	struct workqueue_struct *fpe_wq;
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index d9fca8d1227c..529fe31f8b04 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -968,7 +968,7 @@ static void stmmac_mac_config(struct phylink_config *config, unsigned int mode,
>  
>  static void stmmac_fpe_link_state_handle(struct stmmac_priv *priv, bool is_up)
>  {
> -	struct stmmac_fpe_cfg *fpe_cfg = priv->plat->fpe_cfg;
> +	struct stmmac_fpe_cfg *fpe_cfg = &priv->fpe_cfg;
>  	enum stmmac_fpe_state *lo_state = &fpe_cfg->lo_fpe_state;
>  	enum stmmac_fpe_state *lp_state = &fpe_cfg->lp_fpe_state;
>  	bool *hs_enable = &fpe_cfg->hs_enable;
> @@ -3536,7 +3536,7 @@ static int stmmac_hw_setup(struct net_device *dev, bool ptp_register)
>  	if (priv->dma_cap.fpesel) {
>  		stmmac_fpe_start_wq(priv);
>  
> -		if (priv->plat->fpe_cfg->enable)
> +		if (priv->fpe_cfg.enable)
>  			stmmac_fpe_handshake(priv, true);
>  	}
>  
> @@ -5982,7 +5982,7 @@ static int stmmac_set_features(struct net_device *netdev,
>  
>  static void stmmac_fpe_event_status(struct stmmac_priv *priv, int status)
>  {
> -	struct stmmac_fpe_cfg *fpe_cfg = priv->plat->fpe_cfg;
> +	struct stmmac_fpe_cfg *fpe_cfg = &priv->fpe_cfg;
>  	enum stmmac_fpe_state *lo_state = &fpe_cfg->lo_fpe_state;
>  	enum stmmac_fpe_state *lp_state = &fpe_cfg->lp_fpe_state;
>  	bool *hs_enable = &fpe_cfg->hs_enable;
> @@ -7381,7 +7381,7 @@ static void stmmac_fpe_lp_task(struct work_struct *work)
>  {
>  	struct stmmac_priv *priv = container_of(work, struct stmmac_priv,
>  						fpe_task);
> -	struct stmmac_fpe_cfg *fpe_cfg = priv->plat->fpe_cfg;
> +	struct stmmac_fpe_cfg *fpe_cfg = &priv->fpe_cfg;
>  	enum stmmac_fpe_state *lo_state = &fpe_cfg->lo_fpe_state;
>  	enum stmmac_fpe_state *lp_state = &fpe_cfg->lp_fpe_state;
>  	bool *hs_enable = &fpe_cfg->hs_enable;
> @@ -7427,17 +7427,17 @@ static void stmmac_fpe_lp_task(struct work_struct *work)
>  
>  void stmmac_fpe_handshake(struct stmmac_priv *priv, bool enable)
>  {
> -	if (priv->plat->fpe_cfg->hs_enable != enable) {
> +	if (priv->fpe_cfg.hs_enable != enable) {
>  		if (enable) {
>  			stmmac_fpe_send_mpacket(priv, priv->ioaddr,
> -						priv->plat->fpe_cfg,
> +						&priv->fpe_cfg,
>  						MPACKET_VERIFY);
>  		} else {
> -			priv->plat->fpe_cfg->lo_fpe_state = FPE_STATE_OFF;
> -			priv->plat->fpe_cfg->lp_fpe_state = FPE_STATE_OFF;
> +			priv->fpe_cfg.lo_fpe_state = FPE_STATE_OFF;
> +			priv->fpe_cfg.lp_fpe_state = FPE_STATE_OFF;
>  		}
>  
> -		priv->plat->fpe_cfg->hs_enable = enable;
> +		priv->fpe_cfg.hs_enable = enable;
>  	}
>  }
>  
> @@ -7898,7 +7898,7 @@ int stmmac_suspend(struct device *dev)
>  	if (priv->dma_cap.fpesel) {
>  		/* Disable FPE */
>  		stmmac_fpe_configure(priv, priv->ioaddr,
> -				     priv->plat->fpe_cfg,
> +				     &priv->fpe_cfg,
>  				     priv->plat->tx_queues_to_use,
>  				     priv->plat->rx_queues_to_use, false);
>  
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> index 996f2bcd07a2..9cc41ed01882 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> @@ -282,16 +282,6 @@ static int tc_init(struct stmmac_priv *priv)
>  	if (ret)
>  		return -ENOMEM;
>  
> -	if (!priv->plat->fpe_cfg) {
> -		priv->plat->fpe_cfg = devm_kzalloc(priv->device,
> -						   sizeof(*priv->plat->fpe_cfg),
> -						   GFP_KERNEL);
> -		if (!priv->plat->fpe_cfg)
> -			return -ENOMEM;
> -	} else {
> -		memset(priv->plat->fpe_cfg, 0, sizeof(*priv->plat->fpe_cfg));
> -	}
> -
>  	/* Fail silently as we can still use remaining features, e.g. CBS */
>  	if (!dma_cap->frpsel)
>  		return 0;
> @@ -1076,7 +1066,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>  	/* Actual FPE register configuration will be done after FPE handshake
>  	 * is success.
>  	 */
> -	priv->plat->fpe_cfg->enable = fpe;
> +	priv->fpe_cfg.enable = fpe;
>  
>  	ret = stmmac_est_configure(priv, priv, priv->est,
>  				   priv->plat->clk_ptp_rate);
> @@ -1109,9 +1099,9 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>  		mutex_unlock(&priv->est_lock);
>  	}
>  
> -	priv->plat->fpe_cfg->enable = false;
> +	priv->fpe_cfg.enable = false;
>  	stmmac_fpe_configure(priv, priv->ioaddr,
> -			     priv->plat->fpe_cfg,
> +			     &priv->fpe_cfg,
>  			     priv->plat->tx_queues_to_use,
>  			     priv->plat->rx_queues_to_use,
>  			     false);
> diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> index 338991c08f00..d79ff252cfdc 100644
> --- a/include/linux/stmmac.h
> +++ b/include/linux/stmmac.h
> @@ -138,33 +138,6 @@ struct stmmac_txq_cfg {
>  	int tbs_en;
>  };
>  
> -/* FPE link state */
> -enum stmmac_fpe_state {
> -	FPE_STATE_OFF = 0,
> -	FPE_STATE_CAPABLE = 1,
> -	FPE_STATE_ENTERING_ON = 2,
> -	FPE_STATE_ON = 3,
> -};
> -
> -/* FPE link-partner hand-shaking mPacket type */
> -enum stmmac_mpacket_type {
> -	MPACKET_VERIFY = 0,
> -	MPACKET_RESPONSE = 1,
> -};
> -
> -enum stmmac_fpe_task_state_t {
> -	__FPE_REMOVING,
> -	__FPE_TASK_SCHED,
> -};
> -
> -struct stmmac_fpe_cfg {
> -	bool enable;				/* FPE enable */
> -	bool hs_enable;				/* FPE handshake enable */
> -	enum stmmac_fpe_state lp_fpe_state;	/* Link Partner FPE state */
> -	enum stmmac_fpe_state lo_fpe_state;	/* Local station FPE state */
> -	u32 fpe_csr;				/* MAC_FPE_CTRL_STS reg cache */
> -};
> -
>  struct stmmac_safety_feature_cfg {
>  	u32 tsoee;
>  	u32 mrxpee;
> @@ -232,7 +205,6 @@ struct plat_stmmacenet_data {
>  	struct fwnode_handle *port_node;
>  	struct device_node *mdio_node;
>  	struct stmmac_dma_cfg *dma_cfg;
> -	struct stmmac_fpe_cfg *fpe_cfg;
>  	struct stmmac_safety_feature_cfg *safety_feat_cfg;
>  	int clk_csr;
>  	int has_gmac;
> -- 
> 2.34.1
> 

