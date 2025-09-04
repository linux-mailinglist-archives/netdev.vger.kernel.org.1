Return-Path: <netdev+bounces-220071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 221F4B445E1
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 20:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D636E1C85690
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 18:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0982673AF;
	Thu,  4 Sep 2025 18:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lUlOD1Pk"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75BD25A33A
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 18:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757012174; cv=none; b=E9oiTh4vdSVT1ZZoOTl0cQ36OJbGQopUiQLbf8jOT7zD2WscQK4Rm+YcAlO62KEepmx/+bYWt6kbuaJ015/py3NjgFs6uzuMZqvgciXZ7KqF+KnxfrFdGZ/dLKjbxyPjyLGxh+WeUR0AyvrxBe0fgnlhqzuZ7VjMZwiZy1np2JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757012174; c=relaxed/simple;
	bh=HQFbP0tlOzJh4rPRWUTl5/3aGmXqKdk2novvY2kKoYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XnY99giXl/HeM9HEyw3wYL5/YFW/oSrgLmCV+ON1sk9gf18bhk6fu398n+FpmHGulyk7jDK2mhl04hOWH5kBE5rvpdc+RLiwMheDTuutKxzcb60axNjt82o3PegmUvuFOk4jCLZxOAXGsqZDZUAKl4ylujwavP7/VkAhB0nUZfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lUlOD1Pk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xjjY66RcfO89xgSgq3BI/Zi1XnS61E6x2hm5O5e/pcM=; b=lUlOD1PkTGxanSr7AKvyXl8irJ
	J0gSgg248DiESUGkemYaDyC0CGalgiBh2QKBPxkVuQvH3KXixAHvWJCy2cDHpkkIrcv1UOXPg48bf
	6/FdAVdH97UqdLXuQe+qQzfzwClHRrYwceo5RKKMbfUfatzwU1sgBq9IrAVzgMGMLpok=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uuF7o-007G0E-VD; Thu, 04 Sep 2025 20:56:00 +0200
Date: Thu, 4 Sep 2025 20:56:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 01/11] net: stmmac: mdio: provide address
 register formatter
Message-ID: <d961d42e-e539-451d-ad17-b29fa5cfab9b@lunn.ch>
References: <aLmBwsMdW__XBv7g@shell.armlinux.org.uk>
 <E1uu8ns-00000001voU-0S7b@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1uu8ns-00000001voU-0S7b@rmk-PC.armlinux.org.uk>

On Thu, Sep 04, 2025 at 01:11:00PM +0100, Russell King (Oracle) wrote:
> Rather than duplicating the logic for filling the PA (MDIO address),
> GR (MDIO register/devad), CR (clock range) and GB (busy) fields of the
> address register in four locations, provide a helper to do this.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

I cannot test any of these patches, so please don't merge just because
of my review. Russell specifically asked for testers.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

