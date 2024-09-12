Return-Path: <netdev+bounces-127939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2D297717C
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 21:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 533601C23A14
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 19:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A201BE86F;
	Thu, 12 Sep 2024 19:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Zi3JgrSU"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD44418BC20;
	Thu, 12 Sep 2024 19:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726169886; cv=none; b=iU9fhvN5rEdXSjDygxgViBsO0UBhPv5tuDILBP6XbgjYiZ4FDwj+T24pOKsvH89M1qRwHm3TJwg3hD9+2z7LQySbyC4XQTYTgx1Moz0Y/RP/T3BcmknFpeJO6Q8bTjwNmt8Atwga9HN/1CJzxluUXZdfQ/yr7LR9xBng3UjTXlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726169886; c=relaxed/simple;
	bh=GlHn2Wjig0XjkKzD9shgFjd6oGagoxGcQqbzq+rmMHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YxwpPcmsVd9I6xb6Fv2zFQFIcRvTfM1zr+jCenECPtkrVccvfZaGPoQAuABklJ6v9eVXevC2dfp1pBkVsEWO231cU2anrUtirHQIOQddrk1FNx4Jgl5ljT+uhz3guTGKX7NSB6zDXOYSNNMLP6t+enE38bdljH72jxWm7ZwIOPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Zi3JgrSU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yb4dKd+Zim0/9uWomLTc7IVQqv4OKV/WQNVcMBfCUtA=; b=Zi3JgrSUjSpZOuspQRfnBiymBf
	tPfQN3WERaNmtz27hqgHOceGScodrP3ruIFKIWCySQ7QV8//kRFijRQAoiMpRBf2f2Oa6NCrUCJiv
	ECtAMiysOMhygLnU3SwO6h2k81Wo4hmYPToQWpTf0SOAp1fTBk3A54Uq+rpspLXRVyF4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sopdU-007L0p-N2; Thu, 12 Sep 2024 21:37:48 +0200
Date: Thu, 12 Sep 2024 21:37:48 +0200
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
Message-ID: <cde5eba7-770c-4521-8539-cecd69cc1db9@lunn.ch>
References: <20240911161054.4494-1-Raju.Lakkaraju@microchip.com>
 <20240911161054.4494-5-Raju.Lakkaraju@microchip.com>
 <c6e36569-e3a8-4962-ac85-2fd7d35ab5d1@lunn.ch>
 <ZuKP6XcWTSk0SUn4@HYD-DK-UNGSW21.microchip.com>
 <cbc505ca-3df0-4139-87a1-db603f9f426a@lunn.ch>
 <PH8PR11MB79651A4A42D0492064F6541B95642@PH8PR11MB7965.namprd11.prod.outlook.com>
 <100f9c30-f6cc-4995-a6e9-2856dd3a029f@lunn.ch>
 <PH8PR11MB79651E0A10963CD805666D9295642@PH8PR11MB7965.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH8PR11MB79651E0A10963CD805666D9295642@PH8PR11MB7965.namprd11.prod.outlook.com>

> > But where is the PCS connected?
> 
> For SGMII/BASE-X support the PCI11010 uses Synopsys IP which is all internal to the device. The registers of this Synopsys block are accessible indirectly using a couple of registers (called SGMII_ACCESS and SGMII_DATA) that are mapped into the PCI11010 PCIe BAR.

Right, so not actually on the MDIO bus. Hence it is not correct to
replace the true MDIO access functions with these that do MMIO.

I do understand wanting this to look like an MDIO bus, that is what
the Synopsys driver expects. So create an MDIO bus for it. A bus of
its own.

Just for my understanding. The configuration is purely EEPROM, not
fuses? The PCS exists independent of the 'RGMII/not RGMII' bit in the
EEPROM. So you could unconditionally create the PCS MDIO bus, and
instantiate the PCS driver. In the RGMII case it would just sit there
idle. In the 'not RGMII' mode, the PCS could be used to connect to an
external PHY using SGMII or 2500BaseX. Or it could be connected to an
SFP cage, using SGMII, 1000BaseX or 2500BaseX. In both cases, you tell
phylink about it, phylink will tell you how to configure it.

	  Andrew

