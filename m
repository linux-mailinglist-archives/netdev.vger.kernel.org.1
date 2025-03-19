Return-Path: <netdev+bounces-176200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB596A694D9
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 17:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0914E17C71B
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 16:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F711DED54;
	Wed, 19 Mar 2025 16:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="un9zBFfe"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E08F9DA;
	Wed, 19 Mar 2025 16:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742401598; cv=none; b=uwvBcaZgXEAT5TZpHP/3fqBpLxKJWCzO51zGvb6q7X/JcZEa4vvv75RNc6n+JG/w1HMS46KrJzbq8t96TGo1wzdy5hEj9vkCRiS92nURC9CuFDRdxnZhmpLbRKlqVNW6n8Xe1Vo9/RatrOg2p6UGSjbcN3/W9F9hVrQhSdWxPzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742401598; c=relaxed/simple;
	bh=60lYz6yjO7YLU9zDDPbJr7qEQycANq2vlfp5CxfCljc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h63Yf5I1HPK1vsIFke6Ody9rY1BJ71b29cFHqmNiccA/MdXSKtzoWx3iDuNIXW/JNFljU0PSwAU1Rwqp/fhmoJkZQiMbcEoRQZGlp/ykTTMDF+Q6PBBKH9XCkKdXuK1QiTYec8ljF3AqHZR6UFelWYnohECByeMUDtYI9bOJXt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=un9zBFfe; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=B2YI5dem3RGg1TkB0pW2+3ClFRfM27ppeEKf2F4PHwE=; b=un9zBFfesiq6EY0chgd8Ucso+T
	hzL7YSHVC83EKoOAibh57hqgqrrftkh8NbyquaNrKerdQG6Wp3/eaqrk1jdj/QOm7Z8BIllUL4pc8
	o/xW7bu0mJT7+xzRJoqWkpmk/Y/lbiVE038+uCPy4zDUK7HUojPxOvi8512maSjf3n+C1uIH6bpNB
	EAqtYKnKGY+egNA8AWtFUu3zRM+1z+jAHlxmgoRaqm22SCyBPfmtJQEfKdTyAF/gwjblgjGTPmNqf
	0sFDx46JBD8SPtx1JRxiZoeD7n5xduNbqZdsiZ5OJOeiiz5wMBY8Dwv//ReIAdnjeJETGnTPJJ1H3
	IeKSkGrw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39522)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tuwFL-0006fO-1h;
	Wed, 19 Mar 2025 16:26:23 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tuwFG-0005km-1Z;
	Wed, 19 Mar 2025 16:26:18 +0000
Date: Wed, 19 Mar 2025 16:26:18 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH 2/6] net: pcs: Implement OF support for PCS
 driver
Message-ID: <Z9rwKglOA411lYu5@shell.armlinux.org.uk>
References: <20250318235850.6411-1-ansuelsmth@gmail.com>
 <20250318235850.6411-3-ansuelsmth@gmail.com>
 <Z9rgB1Ko_xAj44zS@shell.armlinux.org.uk>
 <67daeac5.050a0220.3179c5.ce19@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67daeac5.050a0220.3179c5.ce19@mx.google.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Mar 19, 2025 at 05:03:15PM +0100, Christian Marangi wrote:
> On Wed, Mar 19, 2025 at 03:17:27PM +0000, Russell King (Oracle) wrote:
> > On Wed, Mar 19, 2025 at 12:58:38AM +0100, Christian Marangi wrote:
> > > Implement the foundation of OF support for PCS driver.
> > > 
> > > To support this, implement a simple Provider API where a PCS driver can
> > > expose multiple PCS with an xlate .get function.
> > > 
> > > PCS driver will have to call of_pcs_add_provider() and pass the device
> > > node pointer and a xlate function to return the correct PCS for the
> > > requested interface and the passed #pcs-cells.
> > > 
> > > This will register the PCS in a global list of providers so that
> > > consumer can access it.
> > > 
> > > Consumer will then use of_pcs_get() to get the actual PCS by passing the
> > > device_node pointer, the index for #pcs-cells and the requested
> > > interface.
> > > 
> > > For simple implementation where #pcs-cells is 0 and the PCS driver
> > > expose a single PCS, the xlate function of_pcs_simple_get() is
> > > provided. In such case the passed interface is ignored and is expected
> > > that the PCS supports any interface mode supported by the MAC.
> > > 
> > > For advanced implementation a custom xlate function is required. Such
> > > function should return an error if the PCS is not supported for the
> > > requested interface type.
> > > 
> > > This is needed for the correct function of of_phylink_mac_select_pcs()
> > > later described.
> > > 
> > > PCS driver on removal should first call phylink_pcs_release() on every
> > > PCS the driver provides and then correctly delete as a provider with
> > > the usage of of_pcs_del_provider().
> > > 
> > > A generic function for .mac_select_pcs is provided for any MAC driver
> > > that will declare PCS in DT, of_phylink_mac_select_pcs().
> > > This function will parse "pcs-handle" property and will try every PCS
> > > declared in DT until one that supports the requested interface type is
> > > found. This works by leveraging the return value of the xlate function
> > > returned by of_pcs_get() and checking if it's an ERROR or NULL, in such
> > > case the next PCS in the phandle array is tested.
> > > 
> > > Some additional helper are provided for xlate functions,
> > > pcs_supports_interface() as a simple function to check if the requested
> > > interface is supported by the PCS and phylink_pcs_release() to release a
> > > PCS from a phylink instance.
> > > 
> > > Co-developed-by: Daniel Golle <daniel@makrotopia.org>
> > > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > 
> > As a general comment, should we be developing stuff that is DT-centric
> > or fwnode-centric. We already have users of phylink using swnodes, and
> > it seems bad to design something today that is centred around just one
> > method of describing something.
> >
> 
> Honestly, at least for me testing scenario different than DT is quite
> difficult, we can make changes to also support swnodes but we won't have
> anything to test them. Given the bad situation PCS is currently I feel
> we should first focus on DT or at least model something workable first
> than put even more complex stuff on the table.

The problem I have is that once we invent DT specific interfaces, we
seem to endlessly persist with them even when we have corresponding
fwnode interfaces, even when it's easy to convert.

So, my opinion today is that we should avoid single-firmware specific
interfaces.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

