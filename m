Return-Path: <netdev+bounces-57989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 993FA814B71
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 16:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB38D1C236EB
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 15:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76BB36B17;
	Fri, 15 Dec 2023 15:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="JrusyhDr"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADC947F4F;
	Fri, 15 Dec 2023 15:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ajCDZGvijk75rbYCqf20oSN8lDe4VchzPQ8rt1SGUQo=; b=JrusyhDrivvsqoMqFLBzLU2VRm
	AG2fVovX6NKXHUNxQhbuV/xX3x6rulTxAeHs7c9xKdlwVMiI986ar4ZG+Ub+9x8H9ZQXfvR0PB6s2
	FqMeFZcic1Dek1hxwb4zXNlSUocCJuHbue6I1P1H9zhZTx07Y8SXDXSuD4Fby0P42UtxVqCAxvwe2
	ayPlrb3aLfqplL20VCZO8w5pFEdxGqi/XhuGVBjU9yRgfgW5p5lXxEXOQMIwI6KeoFf+gVH30Nq1J
	GpqZprMo39kJqjWs2KU7OEqTIQa1S7NqSTblpPqW/yGvi7bq+9aElknwD8eJwM25kIGO8DlS2moyY
	b/uxUFww==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38654)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rE9rn-0002oc-1C;
	Fri, 15 Dec 2023 15:12:44 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rE9ro-0003iF-DD; Fri, 15 Dec 2023 15:12:44 +0000
Date: Fri, 15 Dec 2023 15:12:44 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Tobias Waldekranz <tobias@waldekranz.com>, davem@davemloft.net,
	kuba@kernel.org, kabel@kernel.org, hkallweit1@gmail.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 3/4] net: phy: marvell10g: Add LED support for
 88X3310
Message-ID: <ZXxs7JhgEMzp/cli@shell.armlinux.org.uk>
References: <20231214201442.660447-1-tobias@waldekranz.com>
 <20231214201442.660447-4-tobias@waldekranz.com>
 <9e2305e5-6b04-4032-8a71-dd24db04ddab@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e2305e5-6b04-4032-8a71-dd24db04ddab@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Dec 15, 2023 at 03:44:07PM +0100, Andrew Lunn wrote:
> > +static int mv3310_led_funcs_from_flags(struct mv3310_led *led,
> > +				       unsigned long flags,
> > +				       enum mv3310_led_func *solid,
> > +				       enum mv3310_led_func *blink)
> > +{
> > +	unsigned long activity, duplex, link;
> > +
> > +	if (flags & ~(BIT(TRIGGER_NETDEV_LINK) |
> > +		      BIT(TRIGGER_NETDEV_HALF_DUPLEX) |
> > +		      BIT(TRIGGER_NETDEV_FULL_DUPLEX) |
> > +		      BIT(TRIGGER_NETDEV_TX) |
> > +		      BIT(TRIGGER_NETDEV_RX)))
> > +		return -EINVAL;
> 
> This probably should be -EOPNOTSUPP. The trigger will then do the
> blinking in software.
> 
> > +
> > +	link = flags & BIT(TRIGGER_NETDEV_LINK);
> > +
> > +	duplex = flags & (BIT(TRIGGER_NETDEV_HALF_DUPLEX) |
> > +			  BIT(TRIGGER_NETDEV_FULL_DUPLEX));
> > +
> > +	activity = flags & (BIT(TRIGGER_NETDEV_TX) |
> > +			    BIT(TRIGGER_NETDEV_RX));
> > +
> > +	if (link && duplex)
> > +		return -EINVAL;
> 
> It is an odd combination, but again, if the hardware cannot do it,
> return -EOPNOTSUPP and leave it to the software.

I don't recall how the LED triggers work (whether they logically OR
or AND). The hardware supports indicating whether it has a half or
full duplex link, and if the LED is programmed for that, then it will
illuminate when it has link _and_ the duplex is of the specified type.
If the link is down, or the duplex is of the other type, then it won't.

I'm guessing that if link is set and duplex is set, then what userspace
is asking for is the LED to be illuminated whenever the link is up _or_
the duplex is of the specified type, which basically logically resolves
to _only_ "link is up" (because a link that is down has no duplex.)

So, I'm not sure "leaving it to software" is good, that combination is
effectively just "has link".

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

