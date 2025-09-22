Return-Path: <netdev+bounces-225288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 075B5B91E4B
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 17:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC4262A4CE3
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 15:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D6B2E22A7;
	Mon, 22 Sep 2025 15:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="zyWhhdpT"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4662E22BA
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 15:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758554729; cv=none; b=ZYmP5lQwbjP2VJg0U8hgt/xGbYw3XRj2MfIdlrvHNHRIFInFMuczy8BKq+LPRdBUdJJc99EIk+posUxbQXu9RG9D4706g3+IVys6OnadwrURhEDZwWTeVHJANFvw/uhjBv2QDnNKQnGBX21vjwippw6sKojyVUpKEL/Ml7llj7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758554729; c=relaxed/simple;
	bh=eNGRKmKef90Z0gUWXeJv7e98H+DrPVpKsNbPa/DqHJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2caS/bG7XzHZ5RcyOlMt3BCNSAkDhieke+g5qeSgN0yPPvswj9SsRXzRfLznUBZOVf6457TFevkrVH6PLoS2m7Te4SH3/Wp3T/A9xtIQ4j3eGHDLLWxOYGMvph90OaPzZvDTLSrvNk/h6MWgTitWN2fqFsOuWR2T5E8V4wWzaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=zyWhhdpT; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=c1GxQlbGW+1oOeAKp5HJWvU1a6bWHhkCXKLaJOFvnjM=; b=zyWhhdpTHBIli9kiEzi/iXIVzQ
	CwdA5DYW/bM878m4OEgGV8peuqMudm3Gu+cxS1LWYaX7RiLLGXYJ2c8LBTn8s/61HRgMJPlYH/14z
	hBAjZujoOoS7LDLGWVKOahc01PQcz5b3knwg8uxXGhXGBk84n+pzvz/xT/0V9/hAUD7tiYOkBXTFu
	S2Mz3uOfZxerhuGFr0QQX5E+prKMn5LpTS7kvBaNEsArEfcekfQ2jLAPRvRA4lf13a5Dy8M7ebiq/
	VNMesvAEzUA36RgH4N20az5DA2HM5lyy9w0kmlOFY71mK22ENvgKHdiD1GwDo9pM+zc8A4VPTNxYE
	LUTN72Fg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42808)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1v0iPr-0000000056h-0Z7y;
	Mon, 22 Sep 2025 16:25:23 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1v0iPo-000000005D3-1Zd5;
	Mon, 22 Sep 2025 16:25:20 +0100
Date: Mon, 22 Sep 2025 16:25:20 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Janpieter Sollie <janpieter.sollie@kabelmail.de>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [RFC] increase MDIO i2c poll timeout gradually (including patch)
Message-ID: <aNFqYPLP2igudMq2@shell.armlinux.org.uk>
References: <971aaa4c-ee1d-4ca1-ba38-d65db776d869@kabelmail.de>
 <cbc4a620-36d3-409b-a248-a2b4add0016a@lunn.ch>
 <f86737b0-a0fe-49a6-aeca-9e51fbdf0f0d@kabelmail.de>
 <aM6Ng7tnEYdWmI1F@shell.armlinux.org.uk>
 <6d444507-1c97-4904-8edb-e8cc1aa4399e@kabelmail.de>
 <aM6xwq6Ns_LGxl4o@shell.armlinux.org.uk>
 <4683e9ea-f795-4dab-8a0a-bd0b0f4fbd99@kabelmail.de>
 <3fab95da-95c8-4cf5-af16-4b576095a1d9@kabelmail.de>
 <aNFDKaIh6RNqLcBM@shell.armlinux.org.uk>
 <6ea48bbb-972e-41f7-8c73-5ddffd9d0384@kabelmail.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ea48bbb-972e-41f7-8c73-5ddffd9d0384@kabelmail.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Sep 22, 2025 at 04:30:56PM +0200, Janpieter Sollie wrote:
> Based on my mails, I can certainly see why you're thinking this way.
> I have no idea what goes wrong anywhere between me making a modification in
> the mdio.c file -> i2c code -> ... -> SFP phy.
> I'm curious what goes wrong, notice the 3 dots in between,
> I know there's a pca9545 muxer in in there further complicating it, but that's about it.
> 
> Long story short: should I somehow try to test the reliability of something else?

What you have in these setups is:

1. The I2C bus from the host to the SFP module pins. On the SFP module
   is an EEPROM at address 0x50 which contains some useful, some not so
   useful identification of the module.

2. Sometimes there is a PHY at 0x56, which is normally a Marvell
   88E1111 which was designed for use on SFPs, and has not only the
   conventional MDIO bus connectivity, but also supports I2C as well.

3. Some baseT modules, the PHY is not accessible.

4. Others have a microcontroller on them - so far identified some with
   an Arm Cortex-M controller, but others have an 8051-based controller
   to implement the "Rollball" protocol.

So, in the case of Rollball protocol modules, one is at the mercy of
the microcontroller receiving the I2C transactions, then accessing the
PHY over MDIO, and then responding appropriately. Given that there are
two different microcontrollers used for this task, I wouldn't be
surprised if there were numerous different firmwares running on them
of varying quality and efficiency.

I would suggest your module is taking excessively long to respond for
_some_ accesses. Maybe the controller isn't merely converting the
Rollball protocol to MDIO, but is doing other PHY manipulation as well,
e.g. emulating some functionality.

It may be interesting to work out whether it is a specific register or
set of registers that need longer access, and augment our knowledge
about what is going on with this stuff.

Ultimately yes, we likely have no option but to increase the timeout,
and to do that I suggest simply increasing the number of loops -
having the approx. 20ms delay between each attempt doesn't stress
anything.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

