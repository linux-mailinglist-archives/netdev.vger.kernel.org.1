Return-Path: <netdev+bounces-147511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF389D9E90
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 21:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8801116563F
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 20:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34051DDC16;
	Tue, 26 Nov 2024 20:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CdiZhN05"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AF51DA631
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 20:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732654673; cv=none; b=Bp2VE7z3ivM81OKf+oNHuWHb1A5Ase1EbKxHwg60nxBIBdLKn3CuZ29ReQcDGCcSMmanYyk9h3elWg6YeQeEIlHUxRkUB7dtuzlXNg+nKZ9yMWonp3UaoBji1Bs1UnvR1bWjpkZggV6qNSm+v+4CHLrM4QOxAnFR0oY0hmkJfzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732654673; c=relaxed/simple;
	bh=QXNe6ZgVb7HZvNUvE70B7eaVrZniTnXDfT5aII6LN+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bRaAiqiYLqhuy0EMA7kQnkscT5rB2QlhV8+mMh7NH/GKyoOIxoBj4YS3RbJNF86qR94YcdevF4eJdSF+lwfjZSvckZVaAXc2OV/j+j/I2jlJvHhh2xhPihD7DigP9FX7bPg8O5feaMGs78wtX880mhArTI9ap+sCNDyA5a30vKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CdiZhN05; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qwOuK+RU+Vr3FPd0NUqSDUOTFabmPgce9CBmDTXSQQg=; b=CdiZhN05S248jze/q9tRiG9oXZ
	0UZQi+r/YpuHF8kQIPcQ01H66r2B2rJD994yzQ8OXv6ojyNA+MhT0YHj/8sPATG8aF0BZZQuPgsNW
	zeljd6ZXPcEqc6KlTN35zF88QoGdarRdk+pTXl0YIHVC2IjALT4C57ryAj0I10DBp9Do=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tG2cs-00EZ6I-DL; Tue, 26 Nov 2024 21:57:38 +0100
Date: Tue, 26 Nov 2024 21:57:38 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexander Couzens <lynxis@fe80.eu>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH RFC net-next 05/16] net: phy: bcm84881: implement
 phy_inband_caps() method
Message-ID: <4f344457-47f8-4a7e-809e-a2ad82b66cd8@lunn.ch>
References: <Z0WTpE8wkpjMiv_J@shell.armlinux.org.uk>
 <E1tFroH-005xQ2-2v@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tFroH-005xQ2-2v@rmk-PC.armlinux.org.uk>

On Tue, Nov 26, 2024 at 09:24:41AM +0000, Russell King (Oracle) wrote:
> BCM84881 has no support for inband signalling, so this is a trivial
> implementation that returns no support for inband.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

