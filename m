Return-Path: <netdev+bounces-158890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C085A13A75
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 14:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73F09188BA83
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 13:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104C91E5708;
	Thu, 16 Jan 2025 13:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Jm5IRekK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9F41E3DFE;
	Thu, 16 Jan 2025 13:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737032793; cv=none; b=bhBioYoH5ZLTNK6EmNzb6qzYyEhd/BHT4+eFskpzfvYRujQ3Asy/vsg93U4IH04N9OuL6LJ2O6JVxEJHycDRbi+zFSoYMevI0GuVQr+Fwdmc4l3TS+T4GcdRsFopdZK9UIHqWxQZaduzKgugzT8c30xYCk9zHIoS4ItKjyV9At4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737032793; c=relaxed/simple;
	bh=OnXHaP2RXlZAkdXMUBJaRh3PdILLHIcuTgCimQm/K60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UNVLywDsnCv3D8sbQoSxjc9X9aMVDKPDk8BxhiQuSvZiD2KN+Dnxd+YEZJ0RP3tBz8vxCNMdjhjd+dPq8j9mMuvbxbZllCqwdEdm8R7ajL7CHkIpWL4JSIv7BW8jN4MlftwItxzrJcLSgqn/i8AE7jXFSJRM9j/je7MYHD6r2Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Jm5IRekK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gGfqbH0+0xNHDaBP8mufxix1MaSaVnHOZLrK9FPiOgQ=; b=Jm5IRekKNfHpSJBpdovOOR/X1F
	4+XkY+5vrPKiy+RrkNFrHkKkTjTjoRvdjg4/yvV1XYGXoKssZR5dmsKu+ETY7/iyTBEP9HUbv9Osw
	aHI75CwnRw4gHylFHvU19qv8uLWj8vGGBszWxxdCStfdnU8NTLo5S6jeGQhNpTX2tBpk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tYPZX-00582T-GD; Thu, 16 Jan 2025 14:06:07 +0100
Date: Thu, 16 Jan 2025 14:06:07 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Marek Vasut <marex@denx.de>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Tristram Ha <tristram.ha@microchip.com>,
	UNGLinuxDriver@microchip.com, Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next,PATCH 1/2] net: dsa: microchip: Add emulated MIIM
 access to switch LED config registers
Message-ID: <ec7861e2-85f5-45bf-bff6-19bc5009cac2@lunn.ch>
References: <20250113001543.296510-1-marex@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113001543.296510-1-marex@denx.de>

> This preparatory patch exposes the LED control bits in those Switch Config
> Registers by mapping them at high addresses in the MIIM space, so the PHY
> driver can access those registers and surely not collide with the existing
> MIIM block registers. The two registers which are exposed are the global
> Register 11 (0x0B): Global Control 9 as MIIM block register 0x0b00 and
> port specific Register 29/45/61 (0x1D/0x2D/0x3D): Port 1/2/3 Control 10
> as MIIM block register 0x0d00 . The access to those registers is further
> restricted only to the LED configuration bits to prevent the PHY driver
> or userspace tools like 'phytool' from tampering with any other switch
> configuration through this interface.

I do wounder about using register numbers outside of the 0-31
range. We never have enforced it, but these clearly break 802.3 C22.

I wounder if it would be better to emulate pages as well. The PHY
driver already has lanphy_write_page_reg() and
lanphy_read_page_reg(). Could you emulate what those need?  It adds a
lot of complexity, but it should be future proof.

What might be simpler is to expose an emulated C45 register range, and
put the registers in the vendor section.


	Andrew

