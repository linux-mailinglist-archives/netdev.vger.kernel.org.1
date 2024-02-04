Return-Path: <netdev+bounces-68980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35195849064
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 21:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEACB2813F5
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 20:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713AD22EE9;
	Sun,  4 Feb 2024 20:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKb/bqG/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961AB2868D
	for <netdev@vger.kernel.org>; Sun,  4 Feb 2024 20:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707078799; cv=none; b=SPqKLuhF936uaC1uPaFm8csQBpECORsG+QM3rluvQTfAXwvIvKS3ZrOhJXYy5x9HorpB0CloI+IG0fwb2Jg5C02W1qfUNlc8CIF85Fq4wwpqPgwwOmbt+ULCkQXhzNawErXhNUiuWNK8Jb8Q3gioWmyGFCE4WyVSGhs5bC9HWis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707078799; c=relaxed/simple;
	bh=jpQz9S0RlvnSyuRTZY1d9FsYlY4XcUB/RYURABtW42s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tq6FAqUmBamIGaIe75N06znZEglYoApLNSheIpzfU20O3+a5tPIMI3sgtvXxIwHVPaO2mnqXZCZ0kxc9PtxOgyQGyJmChpXt0QDf4qVnZDPhrlqkQFXhk03Pq1CIRKMunbZuGhz6z/jEQN+HMMmD8h7Vm8PS76c0Fq05YdKLso0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKb/bqG/; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d093cb1ef3so19384351fa.3
        for <netdev@vger.kernel.org>; Sun, 04 Feb 2024 12:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707078795; x=1707683595; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kxjcuB49pne7j7JK9VPquwmBIBDNkYwt4O9i7GIttQY=;
        b=cKb/bqG/GnRHzz/pp7ZAXOpLPKvC5ikAdNBDVFVrhSaANOV8F6y6Ms+mq9cOLxNw1Z
         zcMB1y5g3xL/W9Ay6rticQbcAcS9u8u3pw8pGLzdFrdgz+O57QaZ/KXKBt7OpDo25uBG
         A2Gc6/jWyuIUQ7+ShNZldB3PM2lXCwHSMakF/pQ/PI3sCjqO83HiCIFLGfldbxRYpQAI
         t+nwZrWeWVV/uym3awr7UhfTQ/6HhSR0KI715azNdeZvlZ/udZ107qoCzDp3So92q9BQ
         xj9yj2Qa4AlrRJf8i+/TDI+BDnhywVPpE9tgGspIyqpoAcUcTWcffm4ot+NSlRRSwQ6N
         R3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707078795; x=1707683595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kxjcuB49pne7j7JK9VPquwmBIBDNkYwt4O9i7GIttQY=;
        b=Hh25O2m/aPuU5zjPaDjJqs8nkJLs0LXnsXYZQBSuY9AIQZCYghGg3r5pv83qzkVo7q
         wHBxSkb1C45VISekQQMHUEW1ay1pEQkE8oz0vJKJ/Ss4ePnO4b1VAG2T04UjIVCdvY4R
         kfwz/4ycXz3rMRqbaASyOxGhpQwbLwE27+FJ7BLi91dsffSYBK0lnoxhBC600/NIwikE
         P+rLNiDaI0wUsxr/pf5Tmzk9p/+tAj/8V3L1SppJP4AX3rsjx6h6jKtsu2/mQbmWgAxH
         XsftjStz9M22h8DmrVJBwu4n4hZjIbGkCsMIE5kUu3M9UxXHNYRjNNRiPT3MTpLvIOxa
         wmsQ==
X-Gm-Message-State: AOJu0YwbxIdOM7/EsuaNJDxcuOi9lyB5C9xlSgQ5DJMoUX0uE916pA29
	Vp9GppOpBN4bMJjkjVs2Pv5plI9cWLjOxxgZ1a6gc+7Fi9OdmJM8
X-Google-Smtp-Source: AGHT+IF6pdsEQtOYy+KiRExWaimHNCtW16kXk8FPu127ttAR3t4Ax2TAeoB9MUJekYX0LNQM8LVm4w==
X-Received: by 2002:a05:651c:19aa:b0:2d0:8918:f36d with SMTP id bx42-20020a05651c19aa00b002d08918f36dmr5598189ljb.4.1707078795310;
        Sun, 04 Feb 2024 12:33:15 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVRfzDw0r+IFKenroOV1CRTUepcfTygL//eODx88SnB6bXMtS8uano7zSkT0DFA25B5RUudXdZz4R1G+GX/ECmNFTYsIKy8+z6xL+f5enql6FRWcGh9qZjpch6t5m1x4u846GgVDmjAKCQV1vqk7ZJHbuSNGtJ7zylbWJsfmEP6xi20vLU3S2AHLaEpbRGz+h7udL+qm2ss644Z2fL5xaYsNgflOUIITx0EsieiS/+nZXgQk+iyu9x4h567RHmvhqSUoPSjvT2rxecYuaqtTUc8NqFAgnp6qerBx+SaZPYbCLIgMz1ioADsJMrQz59F+4yZxvkNgZJ6klPiJM1GSvLVcYwk+Jx68Zfpx0H5rQCIsC9MQco3mn40ssnpSTWEv4KJaltMymmwjoQXptFbc2J8F6p4Q9FxPxFgXF/m7064icmp7hiVPGoE+vpLJ1Ki7IeCC7PNIiPoT3QcGsX+LssIEy1rZ9+CGJVdTp2CmUn88/GbeZUL7uKYRsDfCft7+SfQ1AfOebu588q0GWfcAfwkkVVHfzNccnnKh7PwHx+jMGaI80MQRR56sT2CjhN7fmNrG+g9awXU57TsvZEPEOgjGlzHv5oGiVOUsNjs4mwNvv77AYOruaQ9ZQE7mrbTJEur8Jcx7YTg+au/aWs7AYghYg5Y0Os38iDtnB0yXtOcBS4X5eETu6tgD+SVwQhiafH/bOUOwRibh3YD76qMLekWI5hvmDAJWWZBLA38bm8semPLc+4qqg==
Received: from mobilestation ([95.79.203.166])
        by smtp.gmail.com with ESMTPSA id f6-20020a2e3806000000b002cf55fddca7sm494137lja.49.2024.02.04.12.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 12:33:14 -0800 (PST)
Date: Sun, 4 Feb 2024 23:33:12 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, bcm-kernel-feedback-list@broadcom.com, 
	Byungho An <bh74.an@samsung.com>, Clark Wang <xiaoning.wang@nxp.com>, 
	"David S. Miller" <davem@davemloft.net>, Doug Berger <opendmb@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>, 
	Justin Chen <justin.chen@broadcom.com>, linux-arm-kernel@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	netdev@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>, 
	Paolo Abeni <pabeni@redhat.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Vladimir Oltean <olteanv@gmail.com>, Wei Fang <wei.fang@nxp.com>
Subject: Re: [PATCH net-next v2 1/6] net: stmmac: remove
 eee_enabled/eee_active in stmmac_ethtool_op_get_eee()
Message-ID: <ximzpxurwkawprzuxkfdczrtvzyzjsfhk4taz4pxbzbj5kg6lv@4nqiycwcrgcr>
References: <Zb9/O81fVAZw4ANr@shell.armlinux.org.uk>
 <E1rWbMs-002cCV-EE@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1rWbMs-002cCV-EE@rmk-PC.armlinux.org.uk>

On Sun, Feb 04, 2024 at 12:13:02PM +0000, Russell King (Oracle) wrote:
> stmmac_ethtool_op_get_eee() sets both eee_enabled and eee_active, and
> then goes on to call phylink_ethtool_get_eee().
> 
> phylink_ethtool_get_eee() will return -EOPNOTSUPP if there is no PHY
> present, otherwise calling phy_ethtool_get_eee() which in turn will call
> genphy_c45_ethtool_get_eee().
> 
> genphy_c45_ethtool_get_eee() will overwrite eee_enabled and eee_active
> with its own interpretation from the PHYs settings and negotiation
> result.
> 
> Thus, when there is no PHY, stmmac_ethtool_op_get_eee() will fail with
> -EOPNOTSUPP, meaning eee_enabled and eee_active will not be returned to
> userspace. When there is a PHY, eee_enabled and eee_active will be
> overwritten by phylib, making the setting of these members in
> stmmac_ethtool_op_get_eee() entirely unnecessary.
> 
> Remove this code, thus simplifying stmmac_ethtool_op_get_eee().

Right. and AFAICS stmmac_priv::{eee_active,eee_enabled} will be in
sync with the ethtool_eee::{eee_active,eee_enabled} values since they
are basically determined by means of the genphy_c45_eee_is_active()
method too. But damn it wasn't that easy to figure out... Anyway
thanks for the patch:

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> index bbecb3b89535..411c3ac8cb17 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> @@ -859,8 +859,6 @@ static int stmmac_ethtool_op_get_eee(struct net_device *dev,
>  	if (!priv->dma_cap.eee)
>  		return -EOPNOTSUPP;
>  
> -	edata->eee_enabled = priv->eee_enabled;
> -	edata->eee_active = priv->eee_active;
>  	edata->tx_lpi_timer = priv->tx_lpi_timer;
>  	edata->tx_lpi_enabled = priv->tx_lpi_enabled;
>  
> -- 
> 2.30.2
> 
> 

