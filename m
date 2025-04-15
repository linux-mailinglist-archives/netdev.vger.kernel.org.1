Return-Path: <netdev+bounces-182746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4CDA89D2B
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 14:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 183213B007F
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 12:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E470294A16;
	Tue, 15 Apr 2025 12:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wW5cAcCJ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6312741BF;
	Tue, 15 Apr 2025 12:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744718960; cv=none; b=FPW6k8p7SmHZkrpXdvO7CfPjSL6Z4MiVCBKXAWRPoZeb3i8pD07NgH/p+rTABgUJchuBCr1P817G10Ry5O9chVO2jjfHHbj2m70BWt6duftebLZAJ89rCQeJJL0f/SDZ4kMqvOENeOS7AmdTxIpwYkoQYcVVTI8mm8Nz3N3Coz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744718960; c=relaxed/simple;
	bh=rQmzUcWv9Msu+Y5N0LxfY+yN9yp1GHh3rCejwhqJfNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pc0U77WWiahvykjMWpqjx4DTz3HaHLK72XXryTPaNx+6tssPZahAMnyG2Ylbx1herJqKWVQaosOEqTC2IfLyBkmdbTfNnTpNn0adehzlnyUQy/YKqSZHg49fexSxpxL6LGi1rBORIl5DaqebsVN5+2BIEX87iI6vpcsJS5RuzT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wW5cAcCJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vmwziB2QVw1Qr19BFPphA8MaFnyigzwEzdHBN9OFZHs=; b=wW5cAcCJFw2naWbMZ72P4VjQta
	6HpRQGMmka0nQN542fTwufjaehEQw3hcbvz9hRvt9wcCk37asYm6WYVTIkVLfPsVnvHlUUks0M0Mn
	PhWdu632aZ0vlSiE/BNMVtaJ/dcCY7iaFmTtesoaeNMN7VjmqooKVo668G81ouU7Ekw0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u4f5z-009Qfa-Cp; Tue, 15 Apr 2025 14:08:55 +0200
Date: Tue, 15 Apr 2025 14:08:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Emil Renner Berthing <kernel@esmil.dk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [net-next v1] net: stmmac: starfive: Add serdes PHY init/deinit
 function
Message-ID: <840346cf-52a3-4e40-bf38-9d66231366d7@lunn.ch>
References: <20250410070453.61178-1-minda.chen@starfivetech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410070453.61178-1-minda.chen@starfivetech.com>

> +static int starfive_dwmac_serdes_powerup(struct net_device *ndev, void *priv)
> +{
> +	struct starfive_dwmac *dwmac = priv;
> +	int ret;
> +
> +	ret = phy_init(dwmac->serdes_phy);
> +	if (ret)
> +		return ret;
> +
> +	return phy_power_on(dwmac->serdes_phy);
> +}

static int qcom_ethqos_serdes_powerup(struct net_device *ndev, void *priv)
{
        struct qcom_ethqos *ethqos = priv;
        int ret;

        ret = phy_init(ethqos->serdes_phy);
        if (ret)
                return ret;

        ret = phy_power_on(ethqos->serdes_phy);
        if (ret)
                return ret;

        return phy_set_speed(ethqos->serdes_phy, ethqos->speed);
}

Similar?

> +static void starfive_dwmac_serdes_powerdown(struct net_device *ndev, void *priv)
> +{
> +	struct starfive_dwmac *dwmac = priv;
> +
> +	phy_power_off(dwmac->serdes_phy);
> +	phy_exit(dwmac->serdes_phy);
> +}

static void qcom_ethqos_serdes_powerdown(struct net_device *ndev, void *priv)
{
        struct qcom_ethqos *ethqos = priv;

        phy_power_off(ethqos->serdes_phy);
        phy_exit(ethqos->serdes_phy);
}

Pretty much cut & paste.

>  static int starfive_dwmac_probe(struct platform_device *pdev)
>  {
>  	struct plat_stmmacenet_data *plat_dat;
> @@ -102,6 +125,11 @@ static int starfive_dwmac_probe(struct platform_device *pdev)
>  	if (!dwmac)
>  		return -ENOMEM;
>  
> +	dwmac->serdes_phy = devm_phy_optional_get(&pdev->dev, NULL);
> +	if (IS_ERR(dwmac->serdes_phy))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(dwmac->serdes_phy),
> +				     "Failed to get serdes phy\n");
> +

        ethqos->serdes_phy = devm_phy_optional_get(dev, "serdes");
        if (IS_ERR(ethqos->serdes_phy))
                return dev_err_probe(dev, PTR_ERR(ethqos->serdes_phy),
                                     "Failed to get serdes phy\n");


>  	dwmac->data = device_get_match_data(&pdev->dev);
>  
>  	plat_dat->clk_tx_i = devm_clk_get_enabled(&pdev->dev, "tx");
> @@ -132,6 +160,11 @@ static int starfive_dwmac_probe(struct platform_device *pdev)
>  	if (err)
>  		return err;
>  
> +	if (dwmac->serdes_phy) {
> +		plat_dat->serdes_powerup = starfive_dwmac_serdes_powerup;
> +		plat_dat->serdes_powerdown  = starfive_dwmac_serdes_powerdown;
> +	}
> +

        if (ethqos->serdes_phy) {
                plat_dat->serdes_powerup = qcom_ethqos_serdes_powerup;
                plat_dat->serdes_powerdown  = qcom_ethqos_serdes_powerdown;
        }


I assume you have seen all the work Russell King has been doing
recently cleaning up all the copy/paste code between various glue
drivers. Please don't add to that mess. Please consider how you can
refactor the ethqos code to make is generic for any stmmac driver
which has a generic phy.

    Andrew

---
pw-bot: cr

