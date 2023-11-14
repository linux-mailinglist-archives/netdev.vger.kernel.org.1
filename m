Return-Path: <netdev+bounces-47805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CDD7EB6C9
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 20:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57F9B2812AF
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 19:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D807D443C;
	Tue, 14 Nov 2023 19:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TLqcEmZm"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BFD1D684;
	Tue, 14 Nov 2023 19:14:53 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDE5100;
	Tue, 14 Nov 2023 11:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=aLvUllYQGqXGDQdh72KiIi5LC4LM3SED0J0aPwPEZpU=; b=TLqcEmZmP0XbNCf1f0vYT8bjE+
	+Q7MAFPnjKIDXUkatdEdt/1mcden3rJTuLLO+Kjx7JFaS7jVqqVVV6hFxTSemHasspVFTv8jLPqkG
	9500sFnxAhGhXoFLia+PGMrTsGGeNLm535zgBiSKJMp1kiDvrWK3YCJZpgNhhY0QSOpM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r2ys1-000BVe-C7; Tue, 14 Nov 2023 20:14:45 +0100
Date: Tue, 14 Nov 2023 20:14:45 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: davem@davemloft.net, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Luka Perkov <luka.perkov@sartura.hr>,
	Robert Marko <robert.marko@sartura.hr>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH net-next v3 6/8] net: phy: add calibration callbacks to
 phy_driver
Message-ID: <a4dd8cb4-f662-4dc7-8311-712c64de6f21@lunn.ch>
References: <20231114105600.1012056-1-romain.gantois@bootlin.com>
 <20231114105600.1012056-7-romain.gantois@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114105600.1012056-7-romain.gantois@bootlin.com>

> +static inline
> +int phy_start_calibration(struct phy_device *phydev)
> +{
> +	if (!(phydev->drv &&
> +	      phydev->drv->calibration_start &&
> +	      phydev->drv->calibration_stop))
> +		return -EOPNOTSUPP;
> +
> +	return phydev->drv->calibration_start(phydev);
> +}
> +
> +static inline
> +int phy_stop_calibration(struct phy_device *phydev)
> +{
> +	if (!(phydev->drv &&
> +	      phydev->drv->calibration_stop))
> +		return -EOPNOTSUPP;
> +
> +	return phydev->drv->calibration_stop(phydev);
> +}
> +

What is the locking model?

     Andrew

