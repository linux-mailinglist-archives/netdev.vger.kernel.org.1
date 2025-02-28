Return-Path: <netdev+bounces-170542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A91ADA48EE6
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 03:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D91C16CC9F
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 02:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA51F14B08C;
	Fri, 28 Feb 2025 02:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1pWcmCc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D09B23CB
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 02:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740711134; cv=none; b=bPoPEwSmcd8Xo3d7CfxajtSDD0RN0j6t5BXnRDsYpr8bIsTqwm+NDXZedeWXT5QKfJOTVozG1vFI0unDVfTtwEP3v1dR6yiQJX88FPmK/a6HtfKAkGPL2qTpEPLo7N8v40aXK8y5pV2Vzmava5Y1z/oxyZrzfMJq9D1RFOxNyZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740711134; c=relaxed/simple;
	bh=Ug4DwtMLU/99Cz0YIlrgCNpXbNlhI8q7taCR6q1Hsck=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ktycCGZhkwqphjHQ1ZXGdZ13nJ8N69Z5vi+AlyscQ46psVpOSn/34kwokw0jwNf7mzP4OlBxoKS6oid7DNitV8uoa3DqJEzfO/84OhgNI4GFxa/EgCnaCCW82DtQuXpMri9esUgsck37Mjf/5qvSKEI075mXEkCbvDPneMrMg/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j1pWcmCc; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-223594b3c6dso24740585ad.2
        for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 18:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740711132; x=1741315932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=boGNm2RHbfdjeQuZKJQLhCH8tI0ZaSHF+L70lDAp7g0=;
        b=j1pWcmCc8Bf+Y1CLNcXwl64QGR+7CyvhsWKwCzvdNOlprYVOQz0e2a+TNcmmbFCjYP
         cfRSZuksVB/BAnO4Y+sFEyTPnigH0yVwqM3nDhYBXvJjRE4TkfeXOY5CTVg/6U8fpDE6
         PceReMkYaV+dHEkcuqOwzD6ia8jUupGhloGFYls0nTwxOy73Rp8g1YaRtghPhoxfNs4P
         DAbVCD1zPtzK0ijoTK9V15vP5qXswXGBo9aZM2+dTLUM32wAd0WLK2a2KFODyf1rmRN9
         mGb5rOnrIeU4clZWtx7DiJN3yeCWaG/hhH799clu+8sKkayiF+rCxyQyF/2+8iIy6U/A
         YGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740711132; x=1741315932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=boGNm2RHbfdjeQuZKJQLhCH8tI0ZaSHF+L70lDAp7g0=;
        b=DpOiemgsig5KkfrcGyCASMEjpYoaTGDjZb4G06dmQY6O+q6iouUyZ8LCmTM+KHzUgS
         3Ao5R0sTPI/gCfgSM7tDUtLWZTOp5R65MJLDMh2L9ZRlcZEdh3R2SUZqCZy+FB6f37mV
         IY8rFJYUgCcbudcH4AIArbLTgnT5UKJAI55A749XqWHQn4e92YE6ScdO5CHsriHWhzM8
         1L1/SyIT3zQedADcOK2oDSOYnAZt3qEz+Ky6bbw+rZrU31LxZiG/tx8JZVP4WJmZxR5+
         YPIoa9BcpsjeoCE90KMjfjKvHi9sAdeR9mgyjGEqao4RF/iKs7RXqzn11SPnPB3FaJw3
         8SIQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6WmgIWuxU0scs5U+5In7345it5GYOWnC7zkxdEoVXhhPS3fHZaxdWcYV+IuGoC72AC2Af0pE=@vger.kernel.org
X-Gm-Message-State: AOJu0YywhztLbbfMD4AXPFjL7WNW5mosdKQuUzzUG5UX76JvgyYl1QwI
	xJiYQedw8PmxQi1Fxru7txxE87wKI4j3waY6G4p8wjqN2ItNBvNv
X-Gm-Gg: ASbGnctTDQVeUB1u0mUGWwD8gxCfDZchtV0k4Pc6k68IzGq256TeLwW0tdvXNLENBy+
	nZZjkveDcdtMqHy/ZvrBH366aLziBlj8sPjW+AQ1VgLN0GPnipRbEfoUIGTzCuQ+4S7obXY+qPF
	dJEcQxRyUMyzwau8BlyLlVwZLm2B7U6vkf+Up8ezz3yfqjJYRMmpoGvNjnRcLT2H5XLEHCuqDwi
	3Tqc8t3sOmDmVKDVaqjkH7r55sW5TLf/PDtOPvP1byrUbN3cEPiwUdEcMAvS7+B3PbDcnHVZMq0
	jtU7rk174BWyRp2F4UsdCII=
X-Google-Smtp-Source: AGHT+IGQJlnrpGPiZBb33hDJef87VPOt8uSo1pNSRv/iEORfCM/cnXJBkr2516ecg+lJIS6ML0/RpQ==
X-Received: by 2002:a17:903:244d:b0:215:9470:7e82 with SMTP id d9443c01a7336-22368f71b7amr24670965ad.4.1740711131676;
        Thu, 27 Feb 2025 18:52:11 -0800 (PST)
Received: from localhost ([129.146.253.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501d287dsm23054945ad.43.2025.02.27.18.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 18:52:11 -0800 (PST)
Date: Fri, 28 Feb 2025 10:52:02 +0800
From: Furong Xu <0x1207@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Jon Hunter
 <jonathanh@nvidia.com>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, Paolo Abeni
 <pabeni@redhat.com>, Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH RFC net-next 4/5] net: stmmac: remove _RE and _TE in
 (start|stop)_(tx|rx)() methods
Message-ID: <20250228105202.0000635f@gmail.com>
In-Reply-To: <E1tnfRt-0057SR-Hx@rmk-PC.armlinux.org.uk>
References: <Z8B-DPGhuibIjiA7@shell.armlinux.org.uk>
	<E1tnfRt-0057SR-Hx@rmk-PC.armlinux.org.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Feb 2025 15:05:17 +0000
"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk> wrote:

> Remove fiddling with _TE and _RE in the GMAC control register in the
> start_tx/stop_tx/start_rx/stop_rx() methods as this should be handled
> by phylink and not during initialisation.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c   |  8 --------
>  drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c | 12 ------------
>  2 files changed, 20 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
> index 57c03d491774..61584b569be7 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
> @@ -50,10 +50,6 @@ void dwmac4_dma_start_tx(struct stmmac_priv *priv, void __iomem *ioaddr,
>  
>  	value |= DMA_CONTROL_ST;
>  	writel(value, ioaddr + DMA_CHAN_TX_CONTROL(dwmac4_addrs, chan));
> -
> -	value = readl(ioaddr + GMAC_CONFIG);
> -	value |= GMAC_CONFIG_TE;
> -	writel(value, ioaddr + GMAC_CONFIG);
>  }
>  
>  void dwmac4_dma_stop_tx(struct stmmac_priv *priv, void __iomem *ioaddr,
> @@ -77,10 +73,6 @@ void dwmac4_dma_start_rx(struct stmmac_priv *priv, void __iomem *ioaddr,
>  	value |= DMA_CONTROL_SR;
>  
>  	writel(value, ioaddr + DMA_CHAN_RX_CONTROL(dwmac4_addrs, chan));
> -
> -	value = readl(ioaddr + GMAC_CONFIG);
> -	value |= GMAC_CONFIG_RE;
> -	writel(value, ioaddr + GMAC_CONFIG);
>  }
>  
>  void dwmac4_dma_stop_rx(struct stmmac_priv *priv, void __iomem *ioaddr,
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> index 7840bc403788..cba12edc1477 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> @@ -288,10 +288,6 @@ static void dwxgmac2_dma_start_tx(struct stmmac_priv *priv,
>  	value = readl(ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
>  	value |= XGMAC_TXST;
>  	writel(value, ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
> -
> -	value = readl(ioaddr + XGMAC_TX_CONFIG);
> -	value |= XGMAC_CONFIG_TE;
> -	writel(value, ioaddr + XGMAC_TX_CONFIG);
>  }
>  
>  static void dwxgmac2_dma_stop_tx(struct stmmac_priv *priv, void __iomem *ioaddr,
> @@ -302,10 +298,6 @@ static void dwxgmac2_dma_stop_tx(struct stmmac_priv *priv, void __iomem *ioaddr,
>  	value = readl(ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
>  	value &= ~XGMAC_TXST;
>  	writel(value, ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
> -
> -	value = readl(ioaddr + XGMAC_TX_CONFIG);
> -	value &= ~XGMAC_CONFIG_TE;
> -	writel(value, ioaddr + XGMAC_TX_CONFIG);
>  }
>  
>  static void dwxgmac2_dma_start_rx(struct stmmac_priv *priv,
> @@ -316,10 +308,6 @@ static void dwxgmac2_dma_start_rx(struct stmmac_priv *priv,
>  	value = readl(ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan));
>  	value |= XGMAC_RXST;
>  	writel(value, ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan));
> -
> -	value = readl(ioaddr + XGMAC_RX_CONFIG);
> -	value |= XGMAC_CONFIG_RE;
> -	writel(value, ioaddr + XGMAC_RX_CONFIG);
>  }
>  
>  static void dwxgmac2_dma_stop_rx(struct stmmac_priv *priv, void __iomem *ioaddr,

Tested-by: Furong Xu <0x1207@gmail.com>

