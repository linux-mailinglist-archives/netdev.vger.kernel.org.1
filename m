Return-Path: <netdev+bounces-139547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CA29B2FC9
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 13:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 726B01C238B6
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 12:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9293E1D86C3;
	Mon, 28 Oct 2024 12:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ChkjRBZe"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5CE1D2B1B;
	Mon, 28 Oct 2024 12:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730117354; cv=none; b=ofnuiywetFdBNXi/cBSMKDZoXetUCOONeL46SbO0M39RawJbSaAitcYYBf2w7I6OPzQyte0G5O4fIANj/XLvKDokN6FN9QlHnM+54jtgFK5vr58HiFN2+3mCmzw9poiEjT/BLMHFoHhfUjk5Dzq0UkjwYyJqm7S4YL85krIbD3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730117354; c=relaxed/simple;
	bh=HrqkcnS8K0reyGHjGl5rW2kINv0fidWpSi7vYMFo9u8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pT3f7CDfhWui6gFknzpW8kuudfA4KZJ7KFDGEp3HcGpfGHniIYm80dcvas+xLvWDg3FK0S3IMUniTFUdgPBptcuoJJtOIwxQQ9JMDZlZNzUusxIl4dXOmsMfmwGnlKwnze0tWR981CJHtJnl2J4dnyyaiIuqDDJ5bNwA3W3+8Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ChkjRBZe; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=aqf2XUK3JGfMkS9238PqKD3f8BtXyktl6yHI/B0ObdQ=; b=ChkjRBZef4/Xsg0ZJa71WtVmRh
	kP7PvJCw9BhdUmI1wTlitPTpDr9In9G/a+U+AlSkwa7jLV0Jl0i8yb27weMYjGQ1Hz5fgE3s1lSIh
	HuUU5VM15Rp3YmQsnD8bi7su8FSHeTc8HaYENXhw/uK1W91iP26fD8Znerdu+69MDcGY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t5OYB-00BRNc-UL; Mon, 28 Oct 2024 13:08:47 +0100
Date: Mon, 28 Oct 2024 13:08:47 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v1 3/5] net: dsa: microchip: Refactor MDIO
 handling for side MDIO access
Message-ID: <7738e272-b0ee-4a8c-8501-7030798c4e9c@lunn.ch>
References: <20241026063538.2506143-1-o.rempel@pengutronix.de>
 <20241026063538.2506143-4-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241026063538.2506143-4-o.rempel@pengutronix.de>

>  static int ksz_mdio_register(struct ksz_device *dev)
>  {
> +	struct device_node *parent_bus_node;
> +	struct mii_bus *parent_bus = NULL;
>  	struct dsa_switch *ds = dev->ds;
>  	struct device_node *mdio_np;
>  	struct mii_bus *bus;
> -	int ret;
> +	struct dsa_port *dp;
> +	int ret, i;
>  
>  	mdio_np = of_get_child_by_name(dev->dev->of_node, "mdio");
>  	if (!mdio_np)
>  		return 0;
>  
> +	parent_bus_node = of_parse_phandle(mdio_np, "mdio-parent-bus", 0);
> +	if (parent_bus_node && !dev->info->phy_side_mdio_supported) {
> +		dev_warn(dev->dev, "Side MDIO bus is not supported for this HW, ignoring 'mdio-parent-bus' property.\n");

I think dev_err() and return -EINVAL. It is an error in the DT.


    Andrew

---
pw-bot: cr

