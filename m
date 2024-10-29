Return-Path: <netdev+bounces-140060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3ECF9B5226
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 19:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 130761C22CE4
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 18:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CDB20495C;
	Tue, 29 Oct 2024 18:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXPcfPyd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C142107;
	Tue, 29 Oct 2024 18:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730227959; cv=none; b=LlCpsXSHKyuOlhfFFCXlazhjpWPcfExC2Y12JzjXHuigCH/y9EKIsnPHhRkJdUBEiHK6PwHedsWq8GT5f05+4kFoA/O/OnZOPVbwL/bT08m9jwZYBFoNVuW32YxTXczsrTg4qnLVPg/eZ3C6+DKUcSnEUvEario4+fEL49nvwAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730227959; c=relaxed/simple;
	bh=ozz4hURXeyBj83gfyGu/jPcUlqZvfx4tiPjPQaXoWTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fIbFUPOJRtT1Rz6TWptlYtE+K/FnPNLMT4NKljgQwukXZAeEWMqHr7r6U6xMIbnlnOGxjQFAG+CvMLrUmjZmxRy2o7nJ5GmHirr5DYKlAO2Ip4xx3q0/Z0hrp8RmSYVRQE6Q+jUdjzS2nt8VTqbtiTGusogtvxe/9f0IyjSo3k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FXPcfPyd; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d58a51fa5so493227f8f.1;
        Tue, 29 Oct 2024 11:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730227955; x=1730832755; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cQbHGrEqsKD5aF1OKVKnRulxpzJaf4NY46AhJlO9sJg=;
        b=FXPcfPydeg7MMqNdUkZ4FQZJ84UWwhqi0e7msxmg/2KpcG5DfsC3GY8y8agRWyWiSd
         8Nid5bb7vqndGXxRFhVlHbI6txZ36fP5fB3RbdhOch/kQg7WGmATbuiQuJhnbRqjChJT
         9EERUE8c+VFq/aeTklogPWnOsWVKrIK7C/ruo4IJFcha9wMFY8BBogIi8pP2ta/sfJF/
         trLv8D+n+dEMD0lfCk945cn0+oF+k+9KKeKRWbqMaR6nkgiQkWYVXQ9LxTOe2gjSVopV
         5J5R4ttqZN4Y4DUosVqizas6o8/tFMuiI/fa5xxAyh+XOS0PaDQF7M/Gj+zroq05x9Je
         n9WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730227955; x=1730832755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cQbHGrEqsKD5aF1OKVKnRulxpzJaf4NY46AhJlO9sJg=;
        b=khwrdVf99G35cv+lDnL37P7+8rz4g7VqRZSnIUFkzYk0tCMxugSlPcEV1ggT8ssf0q
         FRWpxGwDi8AkN0oG9/rXgtmAlj3sXknpZCgD7mPZI8AnuLEaUecHaAqNHfU5vSfDI2rS
         tK5/7CpYeyYwWjJ4q8cdf+3dNphOwnzdsi9hcmClqJtkZgNCn1EFpkWDl3FNewWCRN1c
         CzyHVedJlB7XPmuBFISfJZh7bsVbBJZUYc/HhHwNgudZThsfjSXxjFX7QjZoiqWW2kxn
         hPwPSS5+CaDWjhfSWXDxrJjV8mNRA/Y/EtHsOI7yacn07CHoMRdu9kpt+9V4FNVvmiK7
         DpfA==
X-Forwarded-Encrypted: i=1; AJvYcCXYxYtkhU5DGDhGwX6iYz6Mk1k5EwvVqqv5NFXxr+KlqwArp1EgO73aePP079cZMdMAIaMgcG52dRGcxOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzsrjcFzgwGDtY7r1J6hykaR3wP1+et6sPomhlCWTrpd2qzNCD
	IgTChHsA2e0XyFwgGh/pgV+cBYmFNPtRW5jECQQgo7E2Nu7eMyYXaZ2w8BIS
X-Google-Smtp-Source: AGHT+IF1JuH5GETYzM48l9lfnZfPVRTjPuBUwhpTxF2mnfjmnhq15lSAoKb5oQuP+txb+/2Ssczf8A==
X-Received: by 2002:a05:600c:1c29:b0:431:50b9:fa81 with SMTP id 5b1f17b1804b1-4319ad368f4mr46064815e9.7.1730227955179;
        Tue, 29 Oct 2024 11:52:35 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43193573e47sm154555825e9.8.2024.10.29.11.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 11:52:34 -0700 (PDT)
Date: Tue, 29 Oct 2024 20:52:31 +0200
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
Subject: Re: [PATCH net-next v5 3/6] net: stmmac: Refactor FPE functions to
 generic version
Message-ID: <20241029185231.fgy6tofi2uoslp3l@skbuf>
References: <cover.1730084449.git.0x1207@gmail.com>
 <0f13217c5f7a543121286f13b389b5800bde1730.1730084449.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f13217c5f7a543121286f13b389b5800bde1730.1730084449.git.0x1207@gmail.com>

On Mon, Oct 28, 2024 at 11:07:26AM +0800, Furong Xu wrote:
>  void stmmac_fpe_link_state_handle(struct stmmac_priv *priv, bool is_up)
>  {
>  	struct stmmac_fpe_cfg *fpe_cfg = &priv->fpe_cfg;
>  	unsigned long flags;
>  
> +	if (!priv->dma_cap.fpesel)
> +		return;
> +

Minor nitpick: all call sites also have this test already.

>  	timer_shutdown_sync(&fpe_cfg->verify_timer);
>  
>  	spin_lock_irqsave(&fpe_cfg->lock, flags);
>  
>  	if (is_up && fpe_cfg->pmac_enabled) {
>  		/* VERIFY process requires pmac enabled when NIC comes up */
> -		stmmac_fpe_configure(priv, priv->ioaddr, fpe_cfg,
> -				     priv->plat->tx_queues_to_use,
> +		stmmac_fpe_configure(priv, priv->plat->tx_queues_to_use,
>  				     priv->plat->rx_queues_to_use,
>  				     false, true);
>  
> @@ -154,6 +161,11 @@ void stmmac_fpe_init(struct stmmac_priv *priv)
>  	priv->fpe_cfg.status = ETHTOOL_MM_VERIFY_STATUS_DISABLED;
>  	timer_setup(&priv->fpe_cfg.verify_timer, stmmac_fpe_verify_timer, 0);
>  	spin_lock_init(&priv->fpe_cfg.lock);
> +
> +	if (priv->dma_cap.fpesel && !priv->fpe_cfg.reg) {
> +		dev_warn(priv->device, "FPE on this MAC is not supported by driver, force disable it.\n");
> +		priv->dma_cap.fpesel = 0;
> +	}

Let's not change the output of stmmac_dma_cap_show() sysfs attribute if
we don't have to. Who knows what depends on that. It's better to
introduce stmmac_fpe_supported(), which tests for both conditions,
and use it throughout (except, of course, for the sysfs, which should
still print the raw DMA capability).

Which devices would those even be, which support FPE but the driver
doesn't deal with them (after your XGMAC addition), do you have any idea?

>  }
>  
>  void stmmac_fpe_apply(struct stmmac_priv *priv)
> @@ -164,8 +176,7 @@ void stmmac_fpe_apply(struct stmmac_priv *priv)
>  	 * Otherwise let the timer code do it.
>  	 */
>  	if (!fpe_cfg->verify_enabled) {
> -		stmmac_fpe_configure(priv, priv->ioaddr, fpe_cfg,
> -				     priv->plat->tx_queues_to_use,
> +		stmmac_fpe_configure(priv, priv->plat->tx_queues_to_use,
>  				     priv->plat->rx_queues_to_use,
>  				     fpe_cfg->tx_enabled,
>  				     fpe_cfg->pmac_enabled);
> @@ -178,50 +189,54 @@ void stmmac_fpe_apply(struct stmmac_priv *priv)
>  	}
>  }
>  
> -void dwmac5_fpe_configure(void __iomem *ioaddr, struct stmmac_fpe_cfg *cfg,
> -			  u32 num_txq, u32 num_rxq,
> +void stmmac_fpe_configure(struct stmmac_priv *priv, u32 num_txq, u32 num_rxq,
>  			  bool tx_enable, bool pmac_enable)

num_txq? not used anywhere. num_rxq? can be retrieved from the "priv"
pointer already provided.

The rest of the series looks good, I have no other comments.

