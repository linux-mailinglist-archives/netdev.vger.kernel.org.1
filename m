Return-Path: <netdev+bounces-111992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF4A9346D2
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 05:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19407B22474
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 03:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFF33B1AC;
	Thu, 18 Jul 2024 03:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="m0sp+9SF"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10C218B14;
	Thu, 18 Jul 2024 03:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721274221; cv=none; b=QoTV7HNhx/jqracqEkyS/0aa460fJzYMk2AMNkawc1guO937zCL3b3msCoBI9f35QB2RxVirVA7nXQp8ny1uPEvUBZBhfiwGs/0ZgvZj3GLwV00T4TM5NiqzIDl3h2NZpSi6T/BQrc/5zP9VMjdLPdEsjQN6InQruAX+C8nhfLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721274221; c=relaxed/simple;
	bh=GzyvvKzZH5y2ciGXa8Zgv8Fjm+LB1ZjTCwBD3mDoZqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GTSNoHtZiAFapYgeQuQMenlY6FTuzFqQ7Z3GrDUCPAiVFahpdop5ag3rszkGZQN+nosFXt9iSIyb8mn64D1ROyejNqqDEZBroeAB6Dkuo7SNOnfEtRO3/8DhvoKQUBj2dHLdztDeXfW8vE8cfgnEzsx0AXQmXZ13pEUsljOb+No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=m0sp+9SF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=w2Rb5xtjUAcysFBI4RbnPrtA3RsVFaCe7jVSn6HDIs8=; b=m0sp+9SFsnj5/vXyBFxFaSP7tI
	k5foUnJWM5DKlpfITK2e5gmSFa9Hm1393fnuXO6PQ0PGAQFf5fJlDc7/akrN996YmF/vxJzTJsw5A
	TrU0JMqgPk57u0yWM4kkhQIkFacPUm7pBvEvYBKjWa/fTF6Os4B9p1ylMhTIG9tPIuHw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sUI3E-002kqb-Qn; Thu, 18 Jul 2024 05:43:28 +0200
Date: Thu, 18 Jul 2024 05:43:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	horms@kernel.org, hkallweit1@gmail.com, richardcochran@gmail.com,
	rdunlap@infradead.org, linux@armlinux.org.uk,
	bryan.whitehead@microchip.com, edumazet@google.com,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next V2 3/4] net: lan743x: Migrate phylib to phylink
Message-ID: <cdf2e1e8-39ff-48b3-84b6-73c673ab1eb1@lunn.ch>
References: <20240716113349.25527-1-Raju.Lakkaraju@microchip.com>
 <20240716113349.25527-4-Raju.Lakkaraju@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716113349.25527-4-Raju.Lakkaraju@microchip.com>

On Tue, Jul 16, 2024 at 05:03:48PM +0530, Raju Lakkaraju wrote:
> Migrate phy support from phylib to phylink.
> Fixed phy support is still used together with phylink since we need to support
> dynamic fallback when a phy is not found over mdio. While phylink's FIXED mode
> supports fixed phys that, it's dynamic and requires device tree entries which
> are most of the time not present for LAN743x devices

> +static int lan743x_phylink_connect(struct lan743x_adapter *adapter)
> +{
> +	struct device_node *dn = adapter->pdev->dev.of_node;
> +	struct net_device *dev = adapter->netdev;
> +	struct fixed_phy_status fphy_status = {
> +		.link = 1,
> +		.speed = SPEED_1000,
> +		.duplex = DUPLEX_FULL,
> +	};


So you are happy to limit it to 1G, even thought it can do more? That
is the problem with fixed PHY done this way. If you were to use
PHYLINK fixed PHY you can use the full bandwidth of the hardware.

You might want to look at what the wangxun drivers do for some ideas
how you can make use of PHYLINK fixed link without having DT.

    Andrew


