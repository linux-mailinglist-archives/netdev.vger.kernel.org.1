Return-Path: <netdev+bounces-69283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E8984A91A
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 23:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3FA11F2C88B
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 22:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650EE1DA59;
	Mon,  5 Feb 2024 22:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMNeRTKh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824C01EEE7
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 22:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707171207; cv=none; b=lE2xjLr2U692aEF3QKGkGhnuoxE/tKJ7Ew02mtG3dLK8nVPHVIhelgqj8Vjvwei+TQRdrdlH3D2KkTPktf13EL9FX5enOHCrth5DmzKjvMJnzeKr8kC8AqzyZt4MV3N4monUu2gEWP40xvWG3uNj9WLwxMa1d5kgshkMu52ovgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707171207; c=relaxed/simple;
	bh=vDGRMU9iCrBh/iCgzzEgEkXd5DxoF3+KozKAfE4GxsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZMAy5p0/T/kSBtNUAZBPgw6IW7UL+f5bsIczs9W+2wQRInlTcwiJ/Y6Y4G3poy+RW+s6IhV/sNraJNmEAo/8jBLJBhuKIKwVTyCbGyLzGla+pd6vay356eAnARMhZRBnplNKgnG9ylCYQ+7qbZ6xJIgR7J39Rd050FwVDEcu1Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMNeRTKh; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d0aabed735so2614971fa.0
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 14:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707171203; x=1707776003; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+77/Mg3Owtl7Gl7S89Kjzl9TVjmzBkI+Ta+2PqPp/D8=;
        b=mMNeRTKhvluNUheFHOXPfm6wJSTZLDFfdHVmkKp9z3F3fcp8BM7Tt9axQH26nIcALq
         /VpExf5HhSgfMFTZSg0YFLuwChYy5oIlFJ8+BBSnMiG37hC0fSuKbNtJAJCACjoRUk3T
         cRYf1vHvXt6+5USJWAPHQjFosDppCBV2a3gIw23A1OiFMBSsiI6/TirH9LvTSQ+UT2pq
         vYwE2sfAaWEiMVFBAZVlpde0ArGq3c1F9ZNdzK45XP1qbFJ0C3zQl9BCE1iOid+BOvET
         ALKa17VwOF0npuE/JplNmpo7e6OJBy0gFNGSxLm/qb2wOilKcq1CRTz6f/Clpda4d/K5
         oGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707171203; x=1707776003;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+77/Mg3Owtl7Gl7S89Kjzl9TVjmzBkI+Ta+2PqPp/D8=;
        b=pbiT+gTOUE+RNFBzsYcIboLw39qhMSA+bwyBW+gLnkG/2Zqug2/0EWcaq1JJ8/V3tF
         XGGblMwymqnXcwI1XutY7UidtOVwlSTZRisvKCtuBY00yh5f2v6QcFR2Il8lC9YTsaHo
         yyZwQVcM4R3N7xb2E97fVoUCtpo7ahsbn8cx/F7HjewXJGvqtAumNdlRaDHAS4kuaWQQ
         lPuQJg4P4hQEUmuzdzD5lb9B24BjysQZH0khuCS3YESvcNdXo26VCaBGayQ8hE2TmAf0
         raVecmX3/6oHFlB0Xvrl1yZMx1UfBJ91L/EOdM7xW8fIscfLAuSdD2vCb0gf/fLU022s
         8pHA==
X-Gm-Message-State: AOJu0YyVwtZ/OZqL/ZojCEyJjBuKyh2AuZI5D3OA/lUFcmpHHYQm2FMq
	BTljy5521OLM1x+17NeY85wj3ELDMDE7k+NbY5bNwumYouU3vJEayZx/2pCRrO4=
X-Google-Smtp-Source: AGHT+IEclGNiaAmIOkWsEdGhMKTOnN/ukFHQ05A8HchrD42MhiLiUGI4BQq+pBf1Qk94qASDstdqXg==
X-Received: by 2002:a2e:a174:0:b0:2d0:9e44:1af2 with SMTP id u20-20020a2ea174000000b002d09e441af2mr715900ljl.24.1707171203280;
        Mon, 05 Feb 2024 14:13:23 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXf6gsWRayMwOMCbPGWlC6mdzr20STCe4tCxF4OvsOp5OgfXwe9HJ9/DRgqfIUI+e5sMevMVAwCFz0K7olqG6Es19VcEUBwBiLbi/FCabQ3yIRLGI4secklQ1SGFRWPrgji3oe++aBWMsKpOQFx1imcrvpsNKuLiphmmidD7rWUb/5qE46vkon+yutFOnb6lgj53cWqNLJnd3mmvqaDlh7wMHM9R7FFWDBUgq+kiCIimM6QLjpGP7sFYmcFTQUxwFXQbIBFxVtBbsQ63BsGIbY+yXlEOViVvjj8T8Ie3nhIE7Lp32/voFCuvPE1EKZa3HBahfCgrXHGikIS6wdIG2uEgYcbbwAkAOZlChHqkh4AFtlS18NJPOnHmdYoaLpxiqrR7qeZ4g==
Received: from mobilestation ([95.79.203.166])
        by smtp.gmail.com with ESMTPSA id y18-20020a2e95d2000000b002d0a82800fcsm73664ljh.82.2024.02.05.14.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 14:13:22 -0800 (PST)
Date: Tue, 6 Feb 2024 01:13:20 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@loongson.cn, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com
Subject: Re: [PATCH net-next v8 10/11] net: stmmac: dwmac-loongson: Disable
 flow control for GMAC
Message-ID: <7iyirk4une53gmiabdk5j7rhsehdbqegmz5tyhhcyx4wae5i7s@5x6ueq527l6d>
References: <cover.1706601050.git.siyanteng@loongson.cn>
 <101bfd570686485c59a325f65c5d0328c6cd91dd.1706601050.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <101bfd570686485c59a325f65c5d0328c6cd91dd.1706601050.git.siyanteng@loongson.cn>

On Tue, Jan 30, 2024 at 04:49:15PM +0800, Yanteng Si wrote:
> Loongson GMAC does not support Flow Control feature. Set flags to
> disable it.
> 
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 1 +
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c    | 6 +++---
>  include/linux/stmmac.h                               | 1 +
>  3 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> index 1753a3c46b77..b78a73ea748b 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
> @@ -335,6 +335,7 @@ static int loongson_gmac_config(struct pci_dev *pdev,
>  				struct stmmac_resources *res,
>  				struct device_node *np)
>  {
> +	plat->flags |= STMMAC_FLAG_DISABLE_FLOW_CONTROL;
>  
>  	return 0;
>  }
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 3aa862269eb0..8d676cbfba1e 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -1237,9 +1237,9 @@ static int stmmac_phy_setup(struct stmmac_priv *priv)
>  		xpcs_get_interfaces(priv->hw->xpcs,
>  				    priv->phylink_config.supported_interfaces);
>  
> -	priv->phylink_config.mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
> -						MAC_10FD | MAC_100FD |
> -						MAC_1000FD;
> +	priv->phylink_config.mac_capabilities = MAC_10FD | MAC_100FD | MAC_1000FD;
> +	if (!(priv->plat->flags & STMMAC_FLAG_DISABLE_FLOW_CONTROL))
> +		priv->phylink_config.mac_capabilities |= MAC_ASYM_PAUSE | MAC_SYM_PAUSE;
>  
>  	stmmac_set_half_duplex(priv);
>  
> diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> index 197f6f914104..832cd8cd688f 100644
> --- a/include/linux/stmmac.h
> +++ b/include/linux/stmmac.h
> @@ -223,6 +223,7 @@ struct dwmac4_addrs {
>  #define STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY	BIT(12)
>  #define STMMAC_FLAG_DISABLE_FORCE_1000	BIT(13)
>  #define STMMAC_FLAG_DISABLE_HALF_DUPLEX	BIT(14)
> +#define STMMAC_FLAG_DISABLE_FLOW_CONTROL	BIT(15)

See my last comment in patch 9/11. This can be reached by re-defining
the stmmac_ops::phylink_get_caps() callback.

-Serge(y)

>  
>  struct plat_stmmacenet_data {
>  	int bus_id;
> -- 
> 2.31.4
> 

