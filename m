Return-Path: <netdev+bounces-100100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 605E28D7DE6
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 10:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81CB61C2264E
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 08:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CDE6F533;
	Mon,  3 Jun 2024 08:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOvkn34i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6223D551;
	Mon,  3 Jun 2024 08:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717404869; cv=none; b=ULqeqBRGj5vmbWYWYAI4okzWXUnM28PlJOZKhPZ/w8koJTs2WI8Mu7Z7WzILIm8sJy8ijLPGprPQ6/1wndT92jWJXK0i+PuI+3LCNA0xd5R30ekH46qmtSul0S6880f8oeOa9j4B9KtChtvFRdGWLz6XijR0jQ1oQnNkEu964nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717404869; c=relaxed/simple;
	bh=ZXatMpqAH2RG0Z1wwxGvkBcoNORMoyvIO8jZwlatgnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u2/L68Ha7gqpckyGVmA/KZvsShey5bdqgOszsmF6QwngeXc9r8rNiBIxKFFhHo2orpBOF7G8BJxOvxMuiFjDfRNXTrQfhLoJP1FGoEMQoXkIhoFtdX/qNqSjS1SwvL2SCXKlRzUo74/3dCdgfqyE6F9MKKIbAhQu+fBIMQNKOVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LOvkn34i; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52b9af7a01bso816445e87.0;
        Mon, 03 Jun 2024 01:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717404866; x=1718009666; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NY422RM8D/dbgd/9UPZ5mROW0tVlpPtXiW4z+0KlNnE=;
        b=LOvkn34iuGvtqEMEpCbMsFAeM0UFNYC02aYM7B97uGwZDM67dP6TNRg5KduqQSQQAs
         IWW40U38O6tpWLVDnrCkeADWm7hxQ/DKhxEV3g12iFlak3gTanMTcmQbefe1zm+B4c2+
         3oY0MvIkwOuVAtShaYfS4M3Q4UcjhQgLO11zb6969XkEKnSWniLYBzfapAO7hKM74N4M
         gBun3hnnLpt+qZPF96DvNe5nq5M4eg5vzra1NdU6OHbe5XrbyP/QKntUn13WPKiDwFto
         S9DSlQwq1mPoqjTf/t+X1nr4PIPtZK0KB9z5H8F5siuDGGJ/OMSpzjQhrdbclCt3oail
         2bwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717404866; x=1718009666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NY422RM8D/dbgd/9UPZ5mROW0tVlpPtXiW4z+0KlNnE=;
        b=lM3/SPpkbhznPC6wO98bT9F0kgSmhCA54kJf4c81qHxOWARI5aWso0FO4EYYOTXKJr
         P3/Jbc698EEJSSgFxRl+93JZRtmXQpzj3U6tpeMmEUjdNwv9S71Zb6cbpnZ68GU18If/
         WY1S2hYfSaF5OIxNuL6sxx8npFJFkw4MS3y8C5ieW6WdjKEBb61l1b+T0QpGWK9CyPO7
         ZYHwlRYqsvhtqvLEey+Rm01pTdVAUKb9Kfqg9AOI0ZqwaAUMujz7gMc8RXlVm+63jiMk
         Ym6W49lahRI+ovECSSHcGCbR1mhdF0kOrHgNCxR0mbbPzDNA1VShRnxAGmWJyiXEoGQa
         i9bQ==
X-Forwarded-Encrypted: i=1; AJvYcCXID6py6PQcQvhCe+NKsvv7HNZLR7jOl9wiPpQtCMRT1GeFKYUkqeXAtmgFD35kaE0sG6G/LPFRWfWDRJ4Io9PLIMg8MAyAtNAKSUN7CgFJCPguovoYDU94GRs1KfByYDyQEXRa4FsO+OOCEyrdMCK0KKKuNTnbs+s8IPrvMjmxLQ==
X-Gm-Message-State: AOJu0YzuuNQb0uJdj+LGG1mRRnkdvU5llrYVcaHwwrNkQoYwYf8Jb0O0
	JqQU2Ql11Iobjo1CrSbTkrQvLrOenepIUf7OJ1fY/7DC+09tvB3Y
X-Google-Smtp-Source: AGHT+IGmEy0pYkF0twnrOuWMhktsYiK7HkcxKp/i55MnzurvZ0bHVnO1byEssKtiE9Jq5GqpgYVslA==
X-Received: by 2002:a05:6512:1152:b0:52b:9c8a:735a with SMTP id 2adb3069b0e04-52b9c8a74fcmr1011745e87.40.1717404866030;
        Mon, 03 Jun 2024 01:54:26 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b97571ba8sm437665e87.205.2024.06.03.01.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 01:54:25 -0700 (PDT)
Date: Mon, 3 Jun 2024 11:54:22 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Jose Abreu <Jose.Abreu@synopsys.com>, 
	Vladimir Oltean <olteanv@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Sagar Cheluvegowda <quic_scheluve@quicinc.com>, 
	Abhishek Chauhan <quic_abchauha@quicinc.com>, Andrew Halaney <ahalaney@redhat.com>, 
	Jiawen Wu <jiawenwu@trustnetic.com>, Mengyuan Lou <mengyuanlou@net-swift.com>, 
	Tomer Maimon <tmaimon77@gmail.com>, openbmc@lists.ozlabs.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v2 10/10] net: stmmac: Add DW XPCS specified via
 "pcs-handle" support
Message-ID: <2lpomvxhmh7bxqhkuexukztwzjfblulobepmnc4g4us7leldgp@o3a3zgnpua2a>
References: <20240602143636.5839-1-fancer.lancer@gmail.com>
 <20240602143636.5839-11-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240602143636.5839-11-fancer.lancer@gmail.com>

On Sun, Jun 02, 2024 at 05:36:24PM +0300, Serge Semin wrote:
> Recently the DW XPCS DT-bindings have been introduced and the DW XPCS
> driver has been altered to support the DW XPCS registered as a platform
> device. In order to have the DW XPCS DT-device accessed from the STMMAC
> driver let's alter the STMMAC PCS-setup procedure to support the
> "pcs-handle" property containing the phandle reference to the DW XPCS
> device DT-node. The respective fwnode will be then passed to the
> xpcs_create_fwnode() function which in its turn will create the DW XPCS
> descriptor utilized in the main driver for the PCS-related setups.
> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> index 807789d7309a..dc040051aa53 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> @@ -497,15 +497,22 @@ int stmmac_mdio_reset(struct mii_bus *bus)
>  
>  int stmmac_pcs_setup(struct net_device *ndev)
>  {
> +	struct fwnode_handle *devnode, *pcsnode;
>  	struct dw_xpcs *xpcs = NULL;
>  	struct stmmac_priv *priv;
>  	int addr, mode, ret;
>  
>  	priv = netdev_priv(ndev);
>  	mode = priv->plat->phy_interface;
> +	devnode = priv->plat->port_node;
>  
>  	if (priv->plat->pcs_init) {
>  		ret = priv->plat->pcs_init(priv);

> +	} else if (fwnode_property_present(devnode, "pcs-handle")) {
> +		pcsnode = fwnode_find_reference(devnode, "pcs-handle", 0);
> +		xpcs = xpcs_create_fwnode(pcsnode, mode);
> +		fwnode_handle_put(pcsnode);
> +		ret = PTR_ERR_OR_ZERO(xpcs);

Just figured, we might wish to be a bit more portable in the
"pcs-handle" property semantics implementation seeing there can be at
least three different PCS attached:
DW XPCS
Lynx PCS
Renesas RZ/N1 MII

Any suggestion of how to distinguish the passed handle? Perhaps
named-property, phandle argument, by the compatible string or the
node-name?

-Serge(y)

>  	} else if (priv->plat->mdio_bus_data &&
>  		   priv->plat->mdio_bus_data->has_xpcs) {
>  		addr = priv->plat->mdio_bus_data->xpcs_addr;
> @@ -515,10 +522,8 @@ int stmmac_pcs_setup(struct net_device *ndev)
>  		return 0;
>  	}
>  
> -	if (ret) {
> -		dev_warn(priv->device, "No xPCS found\n");
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(priv->device, ret, "No xPCS found\n");
>  
>  	priv->hw->xpcs = xpcs;
>  
> -- 
> 2.43.0
> 

