Return-Path: <netdev+bounces-101092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4478FD44F
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 19:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 105E7286822
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 17:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55C613AA47;
	Wed,  5 Jun 2024 17:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q6XGPEKJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861E01CFBC;
	Wed,  5 Jun 2024 17:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717609705; cv=none; b=N9myrhPn+fA6hdWg0uUU7lDBhJpAsSuMGGa0S9pa6eKb8x69E5oWuxSF4rptkhtRyEZlJ0UtuWw0L7WgImyzMEXuOssgVD96kTgKdD58ntMEcKJlcDeYRpSN4uSjQr0HIwxq9D4FHfA72IB5+I20mM4KAIu0QzRSCo09nl0TDDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717609705; c=relaxed/simple;
	bh=enupfRHuA/sUxcPvYiVVg7oNNALRyFrXlotRKy7IvuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i1cNbuuJULO2rdN5xMhNoDYLGeiizVSj0nde0zYzmX+8fBtgWkatdPiJPiQwrrU8AUheqB+1fXVdz3dCbLhVOrK4r5B9DHJl/ajsEyQAlLVdC3diLbXfqNBP8unOh+d4LiqdopqVqU6+xtZXhgbv34sxg/xI8VLgbQb1R+10t78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q6XGPEKJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E54DC2BD11;
	Wed,  5 Jun 2024 17:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717609705;
	bh=enupfRHuA/sUxcPvYiVVg7oNNALRyFrXlotRKy7IvuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q6XGPEKJV+EC0QMabsGEV9vd0/gyTkTUfF+TAEXj9Jy82MgO8X2lzIXWqIRAyBC86
	 p4XFyPX0I/WfDCqM65cOTJJ9NtKpl/hvtdUdsUpBcVVWkFc3jG6Q8rAEkBNStkNJs5
	 EeMBLlqRH+zZaZrNfQwk35LbS5N95a8bjDH9lzLQvjv7h1K8dVURxuxRCT3CuS5mlI
	 wnRXZtwm4GPtEcZMOi8f5BwtzvNtu9FnvxuB9E0f0+/V3OOEXYLQmrnZIKL2mBm75A
	 Cuee7zNrJx1tzlb/W2d4QWFOgOXgEjONB2UVOHmux2fi2SBrWeUwLfey2ouK6lGMGA
	 PlcBGDPnUqH0w==
Date: Wed, 5 Jun 2024 18:48:17 +0100
From: Simon Horman <horms@kernel.org>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sagar Cheluvegowda <quic_scheluve@quicinc.com>,
	Abhishek Chauhan <quic_abchauha@quicinc.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Tomer Maimon <tmaimon77@gmail.com>, openbmc@lists.ozlabs.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 07/10] net: pcs: xpcs: Add Synopsys DW xPCS
 platform device driver
Message-ID: <20240605174817.GQ791188@kernel.org>
References: <20240602143636.5839-1-fancer.lancer@gmail.com>
 <20240602143636.5839-8-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240602143636.5839-8-fancer.lancer@gmail.com>

On Sun, Jun 02, 2024 at 05:36:21PM +0300, Serge Semin wrote:

...

> diff --git a/drivers/net/pcs/pcs-xpcs-plat.c b/drivers/net/pcs/pcs-xpcs-plat.c

...

> +const struct dev_pm_ops xpcs_plat_pm_ops = {
> +	SET_RUNTIME_PM_OPS(xpcs_plat_pm_runtime_suspend,
> +			   xpcs_plat_pm_runtime_resume,
> +			   NULL)
> +};

nit: xpcs_plat_pm_ops only seems to be used in this file.
     If so it should probably be static.

     Flagged by Sparse.

...

> +static struct platform_driver xpcs_plat_driver = {
> +	.probe = xpcs_plat_probe,
> +	.driver = {
> +		.name = "dwxpcs",
> +		.pm = &xpcs_plat_pm_ops,
> +		.of_match_table = xpcs_of_ids,
> +	},
> +};
> +module_platform_driver(xpcs_plat_driver);

...

