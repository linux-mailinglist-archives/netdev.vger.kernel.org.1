Return-Path: <netdev+bounces-177755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BEDA719A4
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 16:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D30017C226
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 14:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658301F3FF8;
	Wed, 26 Mar 2025 14:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wQ6UwGiE"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E631547C9;
	Wed, 26 Mar 2025 14:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743000987; cv=none; b=cjEtstPGynH0j9If6Gm6M8dUIb9+r9na7NVFlE9zsGwQNxGPs+hOKuQ3ckOgX+ef4eXgoFPTJ5sp0W9xeH+d35M1XAIGU1587nAxW63naeqXQGCNg+W1A7tfbleXs1X8iD4MHeeH/KwhrVh8D/zS6g2kAmgzS5YLSZPh/c0qoDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743000987; c=relaxed/simple;
	bh=V7bIP3PfXYHdxWscf/6gdQ5fxEXhiB2IjmMn4K1DbyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=najUy2SpNoasz6baJlauTnpijZCsOXuBUWZpdLoICfNQlQqZAx3byFZgT8OUO6EEixa27GyawwMwGXQhNUXO43FXeHk/4Wylb85zZEamQX50jIbPSR643JjY2QtAeiezNesVZSa0W7gi1JtgBHn9HU7qC566iIHOkpwjueoWnMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wQ6UwGiE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=XsXoxAWOHRxb8XUNWIPSw3DwDe7Nwe/bbRvZogg7X78=; b=wQ6UwGiE+di8+hXe0P4v50aG+y
	PpXsJ74I/SUjB5p+UszPuGpykVfHURE4rvToqITr5EHQXHov0N+BE0Qgc67Ye40x96hbbplFIaaN/
	COv7cvehMHhaJNMy4kDozA5AbkyziIg8Kh0kiEHAJNMT1jf1Jt6zOZ9OKBndtSWeb/CM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1txSAx-007BFX-38; Wed, 26 Mar 2025 15:56:15 +0100
Date: Wed, 26 Mar 2025 15:56:15 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH v2 2/3] net: phy: Add support for Aeonsemi
 AS21xxx PHYs
Message-ID: <dfa78876-d4a6-4226-b3d4-dbf112e001ee@lunn.ch>
References: <20250326002404.25530-1-ansuelsmth@gmail.com>
 <20250326002404.25530-3-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326002404.25530-3-ansuelsmth@gmail.com>

> +#define PHY_ID_AS21XXX			0x75009410
> +/* AS21xxx ID Legend
> + * AS21x1xxB1
> + *     ^ ^^
> + *     | |J: Supports SyncE/PTP
> + *     | |P: No SyncE/PTP support
> + *     | 1: Supports 2nd Serdes
> + *     | 2: Not 2nd Serdes support
> + *     0: 10G, 5G, 2.5G
> + *     5: 5G, 2.5G
> + *     2: 2.5G
> + */
> +#define PHY_ID_AS21011JB1		0x75009402
> +#define PHY_ID_AS21011PB1		0x75009412
> +#define PHY_ID_AS21010JB1		0x75009422
> +#define PHY_ID_AS21010PB1		0x75009432
> +#define PHY_ID_AS21511JB1		0x75009442
> +#define PHY_ID_AS21511PB1		0x75009452
> +#define PHY_ID_AS21510JB1		0x75009462
> +#define PHY_ID_AS21510PB1		0x75009472
> +#define PHY_ID_AS21210JB1		0x75009482
> +#define PHY_ID_AS21210PB1		0x75009492
> +#define PHY_VENDOR_AEONSEMI		0x75009400

O.K. This helps.

> +static struct phy_driver as21xxx_drivers[] = {
> +	{
> +		/* PHY expose in C45 as 0x7500 0x9410
> +		 * before firmware is loaded.
> +		 */
> +		PHY_ID_MATCH_EXACT(PHY_ID_AS21XXX),
> +		.name		= "Aeonsemi AS21xxx",
> +		.probe		= as21xxx_probe,
> +	},
> +	{
> +		PHY_ID_MATCH_EXACT(PHY_ID_AS21011JB1),
> +		.name		= "Aeonsemi AS21011JB1",
> +		.read_status	= as21xxx_read_status,
> +		.led_brightness_set = as21xxx_led_brightness_set,
> +		.led_hw_is_supported = as21xxx_led_hw_is_supported,
> +		.led_hw_control_set = as21xxx_led_hw_control_set,
> +		.led_hw_control_get = as21xxx_led_hw_control_get,
> +		.led_polarity_set = as21xxx_led_polarity_set,
> +	},

It is guaranteed by the current code that these entries are tried in
the order listed here. If that was to change, other drivers would
break.

So what you can do is have the first entry for PHY_ID_AS21XXX with
as21xxx_probe, have the probe download the firmware and then return
-ENODEV. PHY_ID_AS21XXX tells us there is no firmware, so this is what
we need to do. The -ENODEV then tells the core that this driver entry
does not match the hardware, try the next.

After the firmware download, the phylib core will still have the wrong
ID values. So you cannot use PHY_ID_MATCH_EXACT(PHY_ID_AS21011JB1).
But what you can do is have a .match_phy_device function. It will get
called, and it can read the real ID from the device, and perform a
match. If it does not match return -ENODEV, and the core will try the
next entry.

You either need N match_phy_device functions, one per ID value, or you
can make use of the .driver_data in phy_driver, and place the matching
data there.

In the end you should have the correct phy_driver structure for the
device. The core will still have the wrong ID values, which you should
document with a comment. But that mostly only effects
/sys/class/bus/mdio-bus/...

	Andrew

