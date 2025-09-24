Return-Path: <netdev+bounces-226064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CED55B9B89B
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 20:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7CA8E4E30C1
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 18:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A331631329E;
	Wed, 24 Sep 2025 18:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZG/ewCJR"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5D7199230;
	Wed, 24 Sep 2025 18:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758739286; cv=none; b=SqYr/aBfVXfKTPDf11BlnCExjUxl3HWwu66IunSAj4qcpNCOQ/tGCFsUKFNIJ39iA4pl45dZiJsgVEEApm97OyW/NWAvXJ/Kq7VDPyhlf9Xm9KAMCoK9tbCGsFJEtheJPAvmyluGtXUiYEbHo/9yRRZe93SJv/xuSqftgP7YgEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758739286; c=relaxed/simple;
	bh=rk/YqIAr3psTXwnRF88FFgZF0USARgQwHWYYUih+ZrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sca7C1h8OAR5vO1NVVIFpVx8fo8HXFjEvhtC+pQZmFqj+HCbXFXrWXpMsfqqB+5SDp2+KwHGCiUlK3REiUE8XQy9gkpo88m0CGcF3S02j9aH6cNvMcoyOf9B9umqudDfAdIdm+5VgJxyvUAeRXIArNreC6Lq+oUZP1425gR60iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZG/ewCJR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=oP/eS7INwt9yq8GjuQkiEiRAXKwufdViyrT21UpRM/o=; b=ZG/ewCJRLBP0Eckk7X8wsBMFes
	jeE1L/DOiWCYl4VjvcHNgFgTV7ruTEtQIZnQM01o335XjkxyaOOr/npGPQFOwaC/oAGAcwfwwLyGi
	0TSQznoCR2ukfEJ3Rm2DbMGCMdjcJ+7N8EsHE5QmhbGK0JUuILflNHW2bEvXmdtPU8Yc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v1UQM-009O1c-5E; Wed, 24 Sep 2025 20:41:06 +0200
Date: Wed, 24 Sep 2025 20:41:06 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: David Yang <mmyangfl@gmail.com>, netdev@vger.kernel.org,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Simon Horman <horms@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v11 2/5] net: phy: introduce
 PHY_INTERFACE_MODE_REVSGMII
Message-ID: <fe6a4073-eed0-499d-89ee-04559967b420@lunn.ch>
References: <20250922131148.1917856-1-mmyangfl@gmail.com>
 <20250922131148.1917856-3-mmyangfl@gmail.com>
 <aNQvW54sk3EzmoJp@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNQvW54sk3EzmoJp@shell.armlinux.org.uk>

On Wed, Sep 24, 2025 at 06:50:19PM +0100, Russell King (Oracle) wrote:
> On Mon, Sep 22, 2025 at 09:11:40PM +0800, David Yang wrote:
> > The "reverse SGMII" protocol name is a personal invention, derived from
> > "reverse MII" and "reverse RMII", this means: "behave like an SGMII
> > PHY".
> 
> Sorry to mess you around, but... I've been getting further with stmmac's
> PCS stuff (I've started again with it) and I've come to realise that the
> stmmac driver is full of worms here.
> 
> I think we need to have a bigger discussion here.
> 
> Today, we have:
> 
> - PHY_INTERFACE_MODE_REVMII
> - PHY_INTERFACE_MODE_REVRMII
> 
> which both complement their _MII and _RMII definitions. So, it seems
> entirely sensible to also introduce REVSGMII to complement SGMII.

Maybe we need to think about, what does REVfoo actually mean?

Is it simply about, who provides the clock? For MII, the 'PHY'
provides the clock to the 'MAC;. So does REVMII simply mean a MAC in
REVMII mode provides the clock? Is more needed? As far as i know MII
does not have any inband signalling.

For RMII, it appears each side can provide the clock, or consume the
clock, or a 3rd party can provide the clock. It is a hardware design
choice. So does REVRMII actual mean anything? Again there is no inband
signalling.

GMII the transmit clock is provided by the transmitter, the receive
clock by the receiver. It is symmetrical. REV has no meaning here?

In theory, {R}GMII does have inband signalling, but it is pretty much
never used. REV for GMII could thus indicate what role the device is
playing in this in-band signalling?

For any SERDES based links likes like SGMII, 1000Base-X and above,
clocking is part of the SERDES, so symmetrical. There clearly is
inband signalling, mostly, when it is not broken because of
overclocked SGMII. But we have never needed to specify what role each
end needs to play.

> However, stmmac hardware supports "reverse" mode for more than just
> SGMII, also RGMII and SMII.

How does the databook describe reverse SGMII? How does it differ from
SGMII?

	Andrew

