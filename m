Return-Path: <netdev+bounces-59419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B75E81ACAB
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 03:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 565F01C22F61
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 02:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32C619D;
	Thu, 21 Dec 2023 02:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3tJwVFt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8D263D5
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 02:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50e44c1b35fso438413e87.3
        for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 18:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703126144; x=1703730944; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GEf3YG7C8kY2/90mq3hm/YKHffQ3Qa3P1jVyjwQb3h4=;
        b=K3tJwVFtRVdV1hlaCyN+12YL4eKKyD+jOWubNhrDRNj6iN1O2eYAhTjYy2RaTPyZA+
         bNqmKkT99695g3V0SYGVsRC5AOMWfYYL/iWA7J4RmkH5JycDo5x6WVSTy1kYl6eDuA/H
         5yNfQ+XvPuOARLkvkiN8w0gmqPVGDy1/JMzRj0sMwTovj3VMq0rSbNu3VNk6QM/uibq+
         JHmdsu5a61dth1PouuMGd890jGFaxvdYHnsy52PO5/y1WQJ8zInb4RILN0eqNmhalVJ4
         zMBvItVUH2w4Tl72ZzKP7+nAzcZ8PCwiHPcBoDXvpG2s+Ht3CdYh+/dXN1IE0wh4mfCd
         fT5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703126144; x=1703730944;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GEf3YG7C8kY2/90mq3hm/YKHffQ3Qa3P1jVyjwQb3h4=;
        b=pyWPfPNySwkGFRsx3eTWrpTvO1BWPtQSQyVh0SXqNX1fogMDJ7g/wAFNLX4LSU19LP
         nZuo9wYTZsk0fYRKpK12bnv/OmgQh4OoBYsRAC9D7WwNEwhVCRMOHarnZyWEHeuYGq9x
         DiXHMiato4Br3LcL7yAs59dpRKfiG4L+2W7JyZePrIiHvpnSqVti6afGetzOMZKRx+X5
         tHJ8kOAgm5uSkA/bfKzGTvSm3j2blyF5ZCfmcAigVrIRhsDosVApqWhHPEod1bIS1L4b
         V++vKhglRDjBwMvEj9lF1SXTViimU1F4ObNMRpbvGNKA/KDwlgE6ksKtQm7O6p+iZ9b2
         q8Dw==
X-Gm-Message-State: AOJu0YynLymtzLjj3dCXjaMCuapIH66usIKtshq6jv5bgTC4+h0/s/0a
	DJoz8efUQ17EmoMBL4BBJYk=
X-Google-Smtp-Source: AGHT+IFsJM65eaj1d/kpiYzMcYmum6XECwQzypcIuB5+IogJa9X7FZwh5PJBGiqSMUfc63P8agaBog==
X-Received: by 2002:a05:6512:70f:b0:50e:2f28:52c6 with SMTP id b15-20020a056512070f00b0050e2f2852c6mr3799162lfs.35.1703126144102;
        Wed, 20 Dec 2023 18:35:44 -0800 (PST)
Received: from mobilestation ([95.79.203.166])
        by smtp.gmail.com with ESMTPSA id o28-20020ac25e3c000000b0050dfaac6270sm130956lfg.260.2023.12.20.18.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 18:35:43 -0800 (PST)
Date: Thu, 21 Dec 2023 05:35:41 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@loongson.cn, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH net-next v7 8/9] net: stmmac: dwmac-loongson: Disable
 flow control for GMAC
Message-ID: <ex6xwrpnjbgq3vzvycyninsrdb2spc32t5aoiftnuq5aqkh4yx@fexrffrpec5l>
References: <cover.1702990507.git.siyanteng@loongson.cn>
 <89d95c7121117df7ce6236b330c443e13fdbaa80.1702990507.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89d95c7121117df7ce6236b330c443e13fdbaa80.1702990507.git.siyanteng@loongson.cn>

On Tue, Dec 19, 2023 at 10:28:18PM +0800, Yanteng Si wrote:
> Loongson GMAC does not support Flow Control feature. Set flags to
> disable it.
> 
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 2 ++
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c    | 6 +++---
>  include/linux/stmmac.h                               | 1 +
>  3 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index 9e4953c7e4e0..77c9bcb66a8e 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -160,6 +160,8 @@ static int loongson_gmac_config(struct pci_dev *pdev,
>  		break;
>  	}
>  

> +	plat->flags |= FIELD_PREP(STMMAC_FLAG_DISABLE_FLOW_CONTROL, 1);

Why FIELD_PREP()-ing?

> +
>  	return ret;
>  }
>  
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 9764d2ab7e46..d94f61742772 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -1236,9 +1236,9 @@ static int stmmac_phy_setup(struct stmmac_priv *priv)
>  		xpcs_get_interfaces(priv->hw->xpcs,
>  				    priv->phylink_config.supported_interfaces);
>  
> -	priv->phylink_config.mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
> -						MAC_10FD | MAC_100FD |
> -						MAC_1000FD;
> +	priv->phylink_config.mac_capabilities = MAC_10FD | MAC_100FD | MAC_1000FD;

> +	if (!FIELD_GET(STMMAC_FLAG_DISABLE_FLOW_CONTROL, priv->plat->flags))

!(priv->plat->flags & STMMAC_FLAG_DISABLE_FLOW_CONTROL) ?

-Serge(y)

> +		priv->phylink_config.mac_capabilities |= MAC_ASYM_PAUSE | MAC_SYM_PAUSE;
>  
>  	stmmac_set_half_duplex(priv);
>  
> diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> index 067030cdb60f..5ece92e4d8c3 100644
> --- a/include/linux/stmmac.h
> +++ b/include/linux/stmmac.h
> @@ -224,6 +224,7 @@ struct dwmac4_addrs {
>  #define STMMAC_FLAG_HAS_LGMAC			BIT(13)
>  #define STMMAC_FLAG_DISABLE_HALF_DUPLEX	BIT(14)
>  #define STMMAC_FLAG_DISABLE_FORCE_1000	BIT(15)
> +#define STMMAC_FLAG_DISABLE_FLOW_CONTROL	BIT(16)
>  
>  struct plat_stmmacenet_data {
>  	int bus_id;
> -- 
> 2.31.4
> 

