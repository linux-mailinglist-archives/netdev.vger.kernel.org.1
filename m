Return-Path: <netdev+bounces-161328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39981A20B32
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 14:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 398E67A51D5
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 13:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD0C19D06A;
	Tue, 28 Jan 2025 13:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ups2EbaM"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A4C26ACD;
	Tue, 28 Jan 2025 13:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738070210; cv=none; b=Pct1zXa00VtRPNSrYOp3Swe+RQ3l4BDOEvA+jZihfBzD9IKbA32FzVHL1+wKp3nkAq1VIPUQa5PIP185giMGSFoxWqYpg/QWHGUGba+He70wW/HDak9qn6gJAlTX2up2zlX68tIJaAtyszBwVsFdsQ92dgyFw1r/Pr6016zpCp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738070210; c=relaxed/simple;
	bh=xXYNG+FECuVc5g5kuRcuUJfW51EocZ9u9sccvRH5ah8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RFBdNO9WcRIOVZWn7Y0kvjpOltoPEfMDz0h0wQmvbJESIZZ7lGxqp2hunA1JaZV2fU4hUGXR4cSM4S1I7N1lZllgy/UhzzHALBNy5SIv2Ne0R740VPz+OofvqrgB/IqGagYUNBCOrpA/qFAZY6GOe+q5cHJuL5BBS+VjvuwmY7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ups2EbaM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2fTIhLLqVGdNuQf3eSfM0j6y5NR5g1PGWJNmqdHFyNU=; b=ups2EbaMtVcG2dp6cBnu5xMVw1
	A00bW9bNE8P4ocngiVPH4gt7tXTorYhzp1nM/0kDxjut+CidMco0P5o05O4Oprv5U53MlEOHnkWm7
	UVWDrI6mg5xbiQjBupKlu2ago2Rku4yuel0i09rA/B+697mFfGOtn+N5xsAnBNVjgmrY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tclS8-008qw8-KO; Tue, 28 Jan 2025 14:16:28 +0100
Date: Tue, 28 Jan 2025 14:16:28 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Tristram.Ha@microchip.com
Cc: Woojung Huh <woojung.huh@microchip.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 1/2] net: pcs: xpcs: Add special code to
 operate in Microchip KSZ9477 switch
Message-ID: <69e2c86e-b463-4c4a-8f2c-0613b29be916@lunn.ch>
References: <20250128033226.70866-1-Tristram.Ha@microchip.com>
 <20250128033226.70866-2-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128033226.70866-2-Tristram.Ha@microchip.com>

> For 1000BaseX mode setting neg_mode to false works, but that does not
> work for SGMII mode.  Setting 0x18 value in register 0x1f8001 allows
> 1000BaseX mode to work with auto-negotiation enabled.

Unless you have the datasheet, writing 0x18 to 0x1f8001 is pretty
meaningless. You need to explain what these two bits mean in this
register.

	Andrew

