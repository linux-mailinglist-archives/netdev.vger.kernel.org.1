Return-Path: <netdev+bounces-140348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B574E9B622E
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 12:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 463691F21CB0
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 11:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6084C1E47B9;
	Wed, 30 Oct 2024 11:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yf+8nCu/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A131E47CE;
	Wed, 30 Oct 2024 11:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730288834; cv=none; b=bHa+IAu2AAwKowycsF1FskigbMAaNA2Pas+PQY1QuY0ot0MLhOuhz2UdHxCoJVI5CFiUaWdFomekthjWxiYfg5DE20JFjofkwVAQwa2IS8fZQ9+W5/qFTCEsVPp3TiMilqqOq/YYb7DyFskAdpatgxoxHEb1Df83Wqou5j4eCi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730288834; c=relaxed/simple;
	bh=a10ZdxMtL4d0AOZv+brjgYZyiOYcVyQqAW0BY+GhlQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dnA7coCH6wn4lrsFQfpufOhyXW8sLGFOJwJFlGjlxqvNHhBv0JBi+BBepg63pqfwGiNkRANF9AGo3XEpKHwoL9p7pDYaFiIW3YjJqxu6Q7URX0udotP4c7kt75ukA64DRHFb+cM110253rA/JIvZBvQi6ALeIsmPdyFgzhkd9x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yf+8nCu/; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37ece998fe6so886228f8f.1;
        Wed, 30 Oct 2024 04:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730288830; x=1730893630; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=71Z6N0f0s9Q9l3FMkhrwHC4fWFLGTTR2mo+j6DbIOd4=;
        b=Yf+8nCu/BirKOEVQ7a0HqNm05ZMsF8QKL2PEcKlTP1ud3iGNDYUtb1Ig2PRwU8mt5Q
         snzsK9PL+oJXk48wPnDNBDKlOWmPhZKuEa+0zNMS57FnxwBGoEa4xDTLr+pBW9pxg0j7
         mZ95qAIIpKwaCnR24ZvZG7uqzEk/TPUvc5dgp1RAFC7KIZ9lvU/K4DPNonxx1pCgaMH0
         KfxIX4UcD3uncKc01/aGRna2w3pU32jod0DoWMGvGndD/97yxDzGGLHgJ3VouQha0o9X
         hpzyGbFrlmSd2Iu7HyyAMejTBxG/bSHu8/g5SkpcxKgle81EVzfZJtRZmIpg4jUkkSVM
         cIeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730288830; x=1730893630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=71Z6N0f0s9Q9l3FMkhrwHC4fWFLGTTR2mo+j6DbIOd4=;
        b=g4kdiQOs2rbDcmsM7D7yX1J32xEGbjeNTyq+4YcHNIkcwlS4GHxmCEiTrM5+V6Tyeh
         H1BXm4APdVdcGP1/tRyZtVEldVZky8VHKQY3FUcU9lX7VULLW3POstPPimoxnB11rKEr
         xGue5hsNOvQhEAoEWtFTQI9rjVCM9bsp8O6ungssMSWu/3T6XUbyBnl6aZ4eR4+XYumY
         DvlQh8QlkAb0g9S0C/mc/URTWLlgLoVUijHw/2XpDCUpGRc2AArfOWT4fdxpWUrU7l+C
         JtkDdSRAXzgyMXlCOrqWwK5QZws8KgnqM1Mx6M64WFLPaqvRftTT6mHJF/9fqxlBSbZ4
         xlzw==
X-Forwarded-Encrypted: i=1; AJvYcCVTccIS4uNT9oPGFb2a9zfTYbWsOWRCzoYIvCExG5V4b58nVzvE29IOY/L7jn1KoOYLe2qpTq0MmeO+KpM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4JU0lNHrEldyLSWgLvW1XnpyRsfONXvedWaYiuPU5IwlodsOQ
	SAyQO1n2clMdpMFjYghqep2+QHZpm8aGZg6ajsv3d652ArqJqtdD
X-Google-Smtp-Source: AGHT+IH9XhTipE8INCmJM9rDpTSk6gZJf8Rw2L5Pqs2PM2odooDFAsmqFnRjL6M7rtEJXarPjCXh7g==
X-Received: by 2002:a05:6000:18a3:b0:378:c6f5:9e54 with SMTP id ffacd0b85a97d-3806112785amr5406861f8f.5.1730288829817;
        Wed, 30 Oct 2024 04:47:09 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd917f0bsm18906905e9.17.2024.10.30.04.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 04:47:08 -0700 (PDT)
Date: Wed, 30 Oct 2024 13:47:06 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>,
	andrew+netdev@lunn.ch,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com
Subject: Re: [PATCH net-next v6 3/6] net: stmmac: Refactor FPE functions to
 generic version
Message-ID: <20241030114706.yaevtgpefwfxva5v@skbuf>
References: <cover.1730263957.git.0x1207@gmail.com>
 <cover.1730263957.git.0x1207@gmail.com>
 <cc87e0e02610a5ebfb0079716061f57fb9678dfc.1730263957.git.0x1207@gmail.com>
 <cc87e0e02610a5ebfb0079716061f57fb9678dfc.1730263957.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc87e0e02610a5ebfb0079716061f57fb9678dfc.1730263957.git.0x1207@gmail.com>
 <cc87e0e02610a5ebfb0079716061f57fb9678dfc.1730263957.git.0x1207@gmail.com>

On Wed, Oct 30, 2024 at 01:36:12PM +0800, Furong Xu wrote:
> FPE implementation for DWMAC4 and DWXGMAC differs only for:
> 1) Offset address of MAC_FPE_CTRL_STS and MTL_FPE_CTRL_STS
> 2) FPRQ(Frame Preemption Residue Queue) field in MAC_RxQ_Ctrl1
> 3) Bit offset of Frame Preemption Interrupt Enable
> 
> Refactor FPE functions to avoid code duplication.

I would add "and to simplify the code flow by avoiding the use of
function pointers".

> 
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> ---
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
> index 70ea475046f0..ee86658f77b4 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
> @@ -27,6 +27,20 @@
>  #define STMMAC_MAC_FPE_CTRL_STS_SVER	BIT(1)
>  #define STMMAC_MAC_FPE_CTRL_STS_EFPE	BIT(0)
>  
> +struct stmmac_fpe_reg {
> +	const u32 mac_fpe_reg;		/* offset of MAC_FPE_CTRL_STS */
> +	const u32 mtl_fpe_reg;		/* offset of MTL_FPE_CTRL_STS */
> +	const u32 rxq_ctrl1_reg;	/* offset of MAC_RxQ_Ctrl1 */
> +	const u32 fprq_mask;		/* Frame Preemption Residue Queue */
> +	const u32 int_en_reg;		/* offset of MAC_Interrupt_Enable */
> +	const u32 int_en_bit;		/* Frame Preemption Interrupt Enable */
> +};
> +
> +bool stmmac_fpe_supported(struct stmmac_priv *priv)
> +{
> +	return (priv->dma_cap.fpesel && priv->fpe_cfg.reg);
> +}

This is a separate logical change from just refactoring. Refactoring
changes (which are noisy) should not have functional changes. Could
the introduction and use of stmmac_fpe_supported() please be a separate
patch?

Also, parentheses are not necessary.

> +
>  void stmmac_fpe_link_state_handle(struct stmmac_priv *priv, bool is_up)
>  {
>  	struct stmmac_fpe_cfg *fpe_cfg = &priv->fpe_cfg;
> @@ -38,25 +52,19 @@ void stmmac_fpe_link_state_handle(struct stmmac_priv *priv, bool is_up)
>  
>  	if (is_up && fpe_cfg->pmac_enabled) {
>  		/* VERIFY process requires pmac enabled when NIC comes up */
> -		stmmac_fpe_configure(priv, priv->ioaddr, fpe_cfg,
> -				     priv->plat->tx_queues_to_use,
> -				     priv->plat->rx_queues_to_use,
> -				     false, true);
> +		stmmac_fpe_configure(priv, false, true);
>  
>  		/* New link => maybe new partner => new verification process */
>  		stmmac_fpe_apply(priv);
>  	} else {
>  		/* No link => turn off EFPE */
> -		stmmac_fpe_configure(priv, priv->ioaddr, fpe_cfg,
> -				     priv->plat->tx_queues_to_use,
> -				     priv->plat->rx_queues_to_use,
> -				     false, false);
> +		stmmac_fpe_configure(priv, false, false);
>  	}
>  
>  	spin_unlock_irqrestore(&fpe_cfg->lock, flags);
>  }
>  
> -void stmmac_fpe_event_status(struct stmmac_priv *priv, int status)
> +static void stmmac_fpe_event_status(struct stmmac_priv *priv, int status)
>  {
>  	struct stmmac_fpe_cfg *fpe_cfg = &priv->fpe_cfg;
>  
> @@ -68,8 +76,7 @@ void stmmac_fpe_event_status(struct stmmac_priv *priv, int status)
>  
>  	/* LP has sent verify mPacket */
>  	if ((status & FPE_EVENT_RVER) == FPE_EVENT_RVER)
> -		stmmac_fpe_send_mpacket(priv, priv->ioaddr, fpe_cfg,
> -					MPACKET_RESPONSE);
> +		stmmac_fpe_send_mpacket(priv, MPACKET_RESPONSE);
>  
>  	/* Local has sent verify mPacket */
>  	if ((status & FPE_EVENT_TVER) == FPE_EVENT_TVER &&
> @@ -107,8 +114,7 @@ static void stmmac_fpe_verify_timer(struct timer_list *t)
>  	case ETHTOOL_MM_VERIFY_STATUS_INITIAL:
>  	case ETHTOOL_MM_VERIFY_STATUS_VERIFYING:
>  		if (fpe_cfg->verify_retries != 0) {
> -			stmmac_fpe_send_mpacket(priv, priv->ioaddr,
> -						fpe_cfg, MPACKET_VERIFY);
> +			stmmac_fpe_send_mpacket(priv, MPACKET_VERIFY);
>  			rearm = true;
>  		} else {
>  			fpe_cfg->status = ETHTOOL_MM_VERIFY_STATUS_FAILED;
> @@ -118,10 +124,7 @@ static void stmmac_fpe_verify_timer(struct timer_list *t)
>  		break;
>  
>  	case ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED:
> -		stmmac_fpe_configure(priv, priv->ioaddr, fpe_cfg,
> -				     priv->plat->tx_queues_to_use,
> -				     priv->plat->rx_queues_to_use,
> -				     true, true);
> +		stmmac_fpe_configure(priv, true, true);
>  		break;
>  
>  	default:
> @@ -154,6 +157,9 @@ void stmmac_fpe_init(struct stmmac_priv *priv)
>  	priv->fpe_cfg.status = ETHTOOL_MM_VERIFY_STATUS_DISABLED;
>  	timer_setup(&priv->fpe_cfg.verify_timer, stmmac_fpe_verify_timer, 0);
>  	spin_lock_init(&priv->fpe_cfg.lock);
> +
> +	if (priv->dma_cap.fpesel && !priv->fpe_cfg.reg)
> +		dev_info(priv->device, "FPE on this MAC is not supported by driver.\n");

This as well.

>  }
>  
>  void stmmac_fpe_apply(struct stmmac_priv *priv)
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h
> index 25725fd5182f..00e616d7cbf1 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.h
> @@ -22,24 +22,21 @@ struct stmmac_priv;
>  struct stmmac_fpe_cfg;
>  
>  void stmmac_fpe_link_state_handle(struct stmmac_priv *priv, bool is_up);
> -void stmmac_fpe_event_status(struct stmmac_priv *priv, int status);
> +bool stmmac_fpe_supported(struct stmmac_priv *priv);
>  void stmmac_fpe_init(struct stmmac_priv *priv);
>  void stmmac_fpe_apply(struct stmmac_priv *priv);
> -
> -void dwmac5_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
> -			  u32 num_txq, u32 num_rxq,
> -			  bool tx_enable, bool pmac_enable);
> -void dwmac5_fpe_send_mpacket(void __iomem *ioaddr,
> -			     struct stmmac_fpe_cfg *cfg,
> +void stmmac_fpe_configure(struct stmmac_priv *priv, bool tx_enable,
> +			  bool pmac_enable);
> +void stmmac_fpe_send_mpacket(struct stmmac_priv *priv,
>  			     enum stmmac_mpacket_type type);

Sorry I noticed this just now. After the refactoring, stmmac_fpe_send_mpacket()
is only used from stmmac_fpe.c, and thus can be unexported and made static.
Same goes for enum stmmac_mpacket_type.

> -int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev);
> -int dwmac5_fpe_get_add_frag_size(const void __iomem *ioaddr);
> -void dwmac5_fpe_set_add_frag_size(void __iomem *ioaddr, u32 add_frag_size);
> +void stmmac_fpe_irq_status(struct stmmac_priv *priv);
> +int stmmac_fpe_get_add_frag_size(struct stmmac_priv *priv);
> +void stmmac_fpe_set_add_frag_size(struct stmmac_priv *priv, u32 add_frag_size);
> +
>  int dwmac5_fpe_map_preemption_class(struct net_device *ndev,
>  				    struct netlink_ext_ack *extack, u32 pclass);
>  
> -void dwxgmac3_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
> -			    u32 num_txq, u32 num_rxq,
> -			    bool tx_enable, bool pmac_enable);
> +extern const struct stmmac_fpe_reg dwmac5_fpe_reg;
> +extern const struct stmmac_fpe_reg dwxgmac3_fpe_reg;
>  
>  #endif

