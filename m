Return-Path: <netdev+bounces-121327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A5695CBCB
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 13:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A20F1F25015
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 11:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF12187568;
	Fri, 23 Aug 2024 11:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVJ6usbv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25081186298;
	Fri, 23 Aug 2024 11:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724414216; cv=none; b=mYEy9yTJQi5QUt4m8DA/kYOLuz273V3U4sEHIMRq5WsP1JCdOe3uXUf9fxcjoGj28ZsNOebW1GyHEazzZU9TEFmtLuBfQlVjuuZ4y6isCb5N4QkDikP0aH3RBLbJOkYEKdpgUpBDlMBaWMtBTumVu23Cd0jZZ+LjSbTu01/CS2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724414216; c=relaxed/simple;
	bh=WDg99TsPmFuwg03XPMsu7QBSjftuxiBjFonlSiKHfio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vsf/J6le8sziJWIvukYLBLXzJtAEZ2ExZq8VdezifPjaBlwyLtHImjeZVs8kvZ3j7rseoOJ86p7SP4wMerwyhSmmbdMtBpIKKuVBaKzJNpP+wEnOMHZEbOTcqtTdkitghJo8KootLFV+p4B7g4abT0e41ib+TjmMzSz4ExX38+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hVJ6usbv; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-533496017f8so2525227e87.0;
        Fri, 23 Aug 2024 04:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724414212; x=1725019012; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qgZV4tyks6GAMQWfK4L38P65yZL2kRRfBpNWa0hJOFY=;
        b=hVJ6usbv6dwS3tim2cGVdsbins/D62Wnql4rsi+gEenYz4m/P093jRCNUF/Sz3ut4L
         g5D0o2c3MVjOs5e2KIoX8naW/5EsxQiTvEa9359tcCviyw0+try80rcOvl3X8cIzyKGg
         jHKN6oUkwNxbbKLyUfpmsl4Sg9HXhTyxqP2rFeCUdSd6eDa25hvdKSD4/Wss/DDPPyND
         gZ6QyouRAXr4R9hbi+uQoaWC+t/Nbncp68YvhFOn8hhb5lz+vvTC4GPfk8JAEAAgy4WL
         VE/Ob8r++f+bDpIvPN2nbjH7wtHNl7lTlwaDnUFi5aq8ak8SOLpffcXNES8IFZcnGkmB
         bgVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724414212; x=1725019012;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qgZV4tyks6GAMQWfK4L38P65yZL2kRRfBpNWa0hJOFY=;
        b=Q02R2hZoIUfjwC0+dlWdZbg/WvSWd9hresWAConu/ZfMVCg1RtSI/a1UyOjL6lCvU0
         IWhgPwLX6YQy0IR+LBGXRW8kMuRO32kTCyVKSMWS2txNmOEf6+l817FxXNTRUxkREF5Y
         6pC9eNyiUC6VDtGoDXC4pwMzF+uHiTSIzOzhZxI+qCrL/i/pPvFx+wKxr0ljVr+TDbmd
         1FNBDK40ZCvRfES67t117rv+OhBSMpBijiWJFFZoMEcXA+P2/KZQa/RHQONXNziExtCr
         YumLoa958WTxEFKSfNFsdCw5YlmA0d+aLEVCH05V8tbnhx5MLwvW3U8R/FMbYMExqKn2
         +oVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUT1Exf8oNYp1hEFbW1HOxnbLL4ToaFr73JKgOc8yVOCg8ST6Ofa4LxR3QzKc0Yvxibk20ZTb2KNN0MNcA=@vger.kernel.org, AJvYcCVZ8u6JB1fjE7yrtL4VDe0Bj0YhGQtFJ4uUBYpf0vNSVHdZEbC4iFkK17NIwINJCv3Z+pANtT4U@vger.kernel.org
X-Gm-Message-State: AOJu0YxIUIiZhhnB7Xzi+G9MLIeejyEyvXHqqFOvDgEj1QPFx9C6yA18
	cVHwql9rZQ5ukYWS5grWl4WqDWY0zUTEwv5FYXR9sKMkgOQdU21O
X-Google-Smtp-Source: AGHT+IHdAqAk6DpZd9sGZOVHkcPaqutovShJdwo7b99VJ/xrWNo1e0HoCkmY7ZKsjoXcxQ0Oe8N1rg==
X-Received: by 2002:a05:6512:ad1:b0:533:4b76:cb59 with SMTP id 2adb3069b0e04-53438869c7fmr1528825e87.57.1724414211306;
        Fri, 23 Aug 2024 04:56:51 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5334ea5d8b8sm532166e87.216.2024.08.23.04.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 04:56:50 -0700 (PDT)
Date: Fri, 23 Aug 2024 14:56:46 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Joao Pinto <jpinto@synopsys.com>, netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, xfr@outlook.com
Subject: Re: [PATCH net-next v6 1/7] net: stmmac: move stmmac_fpe_cfg to
 stmmac_priv data
Message-ID: <ekzmq7y5is7em2zlsmf4bzne4z346dkyvynynmd45m7iqulamq@sle2yzzx7o4t>
References: <cover.1724409007.git.0x1207@gmail.com>
 <8c6e74ee569d33ee5c7db78e3964c60001b3fb48.1724409007.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c6e74ee569d33ee5c7db78e3964c60001b3fb48.1724409007.git.0x1207@gmail.com>

On Fri, Aug 23, 2024 at 06:50:08PM +0800, Furong Xu wrote:
> By moving the fpe_cfg field to the stmmac_priv data, stmmac_fpe_cfg
> becomes platform-data eventually, instead of a run-time config.
> 
> Suggested-by: Serge Semin <fancer.lancer@gmail.com>
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/hwif.h    |  2 ++
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h  | 30 ++++++++++++++++++-
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 20 ++++++-------
>  .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 16 ++--------
>  include/linux/stmmac.h                        | 28 -----------------
>  5 files changed, 44 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> index 7e90f34b8c88..d3da82982012 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> @@ -26,6 +26,8 @@
>  })
>  

>  struct stmmac_extra_stats;
> +struct stmmac_fpe_cfg;
> +enum   stmmac_mpacket_type;
>  struct stmmac_priv;
>  struct stmmac_safety_stats;
>  struct dma_desc;

Not sure whether it's supposed to be alphabetically ordered, but using
additional spaces to align the names seems an abnormal approach. I
failed to find any similar sample in kernel. So seeing the driver
doesn't implement the forward declarations as you suggest I'd convert
this to just:

 struct stmmac_extra_stats;
 struct stmmac_priv;
 struct stmmac_safety_stats;
+struct stmmac_fpe_cfg;
+enum stmmac_mpacket_type;
 struct dma_desc;

Other than that the patch looks good:
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

Thanks
-Serge(y)

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> index b23b920eedb1..458d6b16ce21 100644
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
> @@ -339,11 +366,12 @@ struct stmmac_priv {
>  	struct workqueue_struct *wq;
>  	struct work_struct service_task;
>  
> -	/* Workqueue for handling FPE hand-shaking */
> +	/* Frame Preemption feature (FPE) */
>  	unsigned long fpe_task_state;
>  	struct workqueue_struct *fpe_wq;
>  	struct work_struct fpe_task;
>  	char wq_name[IFNAMSIZ + 4];
> +	struct stmmac_fpe_cfg fpe_cfg;
>  
>  	/* TC Handling */
>  	unsigned int tc_entries_max;
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

