Return-Path: <netdev+bounces-127863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 834AC976E7D
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 18:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91EABB239AE
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 16:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55EA13D245;
	Thu, 12 Sep 2024 16:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Iw0lvd7p"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5BF4AEF4;
	Thu, 12 Sep 2024 16:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726157609; cv=none; b=GFlHYP/KWagWl/21iI27ulLhibPOPDhMei+Tf07rXcVuppOpB2tonJRRp+lvDGv0oEnrMibQG1N2po7CkGZZ4W2TnMvA5gOo2y/dByT9niy9f71w7eP/bcxHev6CkB4XUay5at5GRzMF5hV9MA9m9BcJW0WIqQ68ltXM+pzHB0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726157609; c=relaxed/simple;
	bh=OmBNvMITlRvb/PXVvd52qXHe7Mn5kVTL0UEHOyL4oFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJH7oNdt7EQUqWiyeWGyHu64992wNn1fi0DwM03nIXRsaZBHbe5mB9MrEF2C2xPCpvZUX496NhHp3Pq3A89V0stdqwHqT58pVRiSdVP0j2zkKAQVE/POC0sg8/GoF1O3Da4vfcngNpX+1zJALfp5quIRpa+Yx2dIwd3vISHDWZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Iw0lvd7p; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1L5pXQ28q1fdoApfphTH3xK6rcuMrjSLTotIfwo+pTE=; b=Iw0lvd7pKeU4Y2DGDxdV8KhpxF
	tECzdll2V5BOdQpJFYNPyaesZgQDD2wbTIhKNG2KmDPizQYmu6t1JO5S8SQYNcMN/uKDr4xDKfIqy
	wt2QZF6TNYXk/xyCCs2HqjDRr41NNAAbx1cixpkODp4Eo4ni+ttS1HMb46ErHwaIjRGE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1somRX-007K6X-JT; Thu, 12 Sep 2024 18:13:15 +0200
Date: Thu, 12 Sep 2024 18:13:15 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ronnie.Kunin@microchip.com
Cc: Raju.Lakkaraju@microchip.com, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, Bryan.Whitehead@microchip.com,
	UNGLinuxDriver@microchip.com, linux@armlinux.org.uk,
	maxime.chevallier@bootlin.com, rdunlap@infradead.org,
	Steen.Hegelund@microchip.com, Daniel.Machon@microchip.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next V2 4/5] net: lan743x: Implement phylink pcs
Message-ID: <100f9c30-f6cc-4995-a6e9-2856dd3a029f@lunn.ch>
References: <20240911161054.4494-1-Raju.Lakkaraju@microchip.com>
 <20240911161054.4494-5-Raju.Lakkaraju@microchip.com>
 <c6e36569-e3a8-4962-ac85-2fd7d35ab5d1@lunn.ch>
 <ZuKP6XcWTSk0SUn4@HYD-DK-UNGSW21.microchip.com>
 <cbc505ca-3df0-4139-87a1-db603f9f426a@lunn.ch>
 <PH8PR11MB79651A4A42D0492064F6541B95642@PH8PR11MB7965.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH8PR11MB79651A4A42D0492064F6541B95642@PH8PR11MB7965.namprd11.prod.outlook.com>

> Our PCI11x1x hardware has a single MDIO controller that gets used
> regardless of whether the chip interface is set to RGMII or to
> SGMII/BASE-X.

That would be the external MDIO bus. 

But where is the PCS connected?

> When we are using an SFP, the MDIO lines from our controller are not
> used / connected at all to the SFP.

Correct. The SFP cage does not have MDIO pins. There are two commonly
used protocols for MDIO over I2C, which phylink supports. The MAC
driver is not involved. All it needs to report to phylink is when the
PCS transitions up/down.

    Andrew

