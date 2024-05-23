Return-Path: <netdev+bounces-97811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F17B8CD57E
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 16:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BABFCB231C1
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 14:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2F914A09F;
	Thu, 23 May 2024 14:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SR1KH14X"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B42433C4;
	Thu, 23 May 2024 14:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716473771; cv=none; b=A9boc4R5FVALFYC4ThDv4jgtBkmruiu5dbmratbevDHpqwVSR5J2m2ng1n2jYL0LGqrPjMuN9u5TvJfvxX/9p4kB5Lw1OWISBUOdx3hrbNxnb7j+tdahSOEZ4bewQner1WRHQYjhTQfFKLc7AYn+rSHLbuib0/lgNXmDfC3ipqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716473771; c=relaxed/simple;
	bh=wQDOxHZXka4xUVaynAl1Woi5FfNCzGUUkNL42C79K1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R166LprV7F4pu69g6IWQ7239HHeUOZ/AQzWHSJtkDxobuDQzv/EEcG3uwyBqC59vrenE1+QFZaKI2NZYIuRCCk7sgqen6UUYcZ6Z+SioVFZ3U9uaL8dtz4XQxU3SUiJtrjFRPJCPLO22xLTSuzmCkWHYW67swicUciAdwjSBauI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SR1KH14X; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=g+ebpXfO143PFW9N1XZMquOC4h2pBt/C1Sj6RJ/sCfs=; b=SR1KH14XWZPiQ0OQbzRNHsCtt8
	PONHV0Jdgb+2TuKlCGQTbOOX/+qbMc7Ew0c715FDlQZAA9rETdWKuBsBcKpNgm9AznRQjNV/k2t8o
	/g1Mf0OMC/gDKEJQ26sGZU7B/4G8YL2+VHgPqo1q9RI7epVK0HcPU6JpH5kFda2rOujU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sA9EQ-00Ftiv-GT; Thu, 23 May 2024 16:15:46 +0200
Date: Thu, 23 May 2024 16:15:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Mathieu Othacehe <othacehe@gnu.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Karim Ben Houcine <karim.benhoucine@landisgyr.com>
Subject: Re: [PATCH] net: phy: micrel: set soft_reset callback to
 genphy_soft_reset for KSZ8061
Message-ID: <f865a21d-b080-48ae-9c16-468c9f83d7e3@lunn.ch>
References: <20240521065406.4233-1-othacehe@gnu.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521065406.4233-1-othacehe@gnu.org>

On Tue, May 21, 2024 at 08:54:06AM +0200, Mathieu Othacehe wrote:
> Following a similar reinstate for the KSZ8081 and KSZ9031.
> 
> Older kernels would use the genphy_soft_reset if the PHY did not implement
> a .soft_reset.
> 
> The KSZ8061 errata described here:
> https://ww1.microchip.com/downloads/en/DeviceDoc/KSZ8061-Errata-DS80000688B.pdf
> and worked around with 232ba3a51c ("net: phy: Micrel KSZ8061: link failure after cable connect")
> is back again without this soft reset.
> 
> Fixes: 6e2d85ec0559 ("net: phy: Stop with excessive soft reset")
> Tested-by: Karim Ben Houcine <karim.benhoucine@landisgyr.com>
> Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

