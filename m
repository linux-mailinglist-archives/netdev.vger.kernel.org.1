Return-Path: <netdev+bounces-150657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D849EB211
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 14:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E7B6284C42
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 13:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5FB1AA1D8;
	Tue, 10 Dec 2024 13:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="asH3PMsr"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A19A1A0BD7;
	Tue, 10 Dec 2024 13:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733838005; cv=none; b=LalNYOPSMwE3JS6HBh5i0I3iIHb+M3+/A8ICsSp6PurHJrlJ7beyNHNo2EoGqsjbU1znlIXf5RZ63SfZx24c8ybP4sZ2pLRYWDgsdbqUM41pLMc7vPyhgSW+mIINpOVBn7zZYV3SFTSGax+ggRQ2Hfmn0hUQCVBD/+uXep/SjIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733838005; c=relaxed/simple;
	bh=igP+6cjwIi11c8Fg1QAKUEQKMJ0V/et6RiwVp2fStR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HfjoRA36qlfgLaZkb3xq8hdoAbS/wwBRx4j/tWJj9mJEMnW4tZmqi4iafgNR5kU8/vZeyKyHZskHbPj1f9GYdegv20weSOqNuKbVZG8ygaBgYFiPOMpIE3KgWI6fpXw6iE7fw7SWYkGXmMwCPivGS4U4RKjbwKHmbHKiTHc59gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=asH3PMsr; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UJX/8xrhEUU6XIQbmDy2O/PG0ZMWemC8KWil8DsF0s4=; b=asH3PMsr0djKISSZvkaKiVPas4
	C0pfCwI0wDPzRSBUFRdQR5DwuvF/8S+ly9EcCqrPelbwmYtlrUBUjNFEF7it1j8BNn4cUjI+qfOxE
	UuJB56y8a2/KfBj8Lh/1TpyKfUtCqUAvN9/P6XenmZbIxvkicYvjY5gQAmFTrj1NE5+8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tL0Ss-00Fnxx-No; Tue, 10 Dec 2024 14:39:50 +0100
Date: Tue, 10 Dec 2024 14:39:50 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v11 9/9] net: phy: Add Airoha AN8855 Internal
 Switch Gigabit PHY
Message-ID: <ca20895b-9223-4af6-b49c-e405b69e5f08@lunn.ch>
References: <20241209134459.27110-1-ansuelsmth@gmail.com>
 <20241209134459.27110-10-ansuelsmth@gmail.com>
 <b3b79c80-ac7c-456b-a3b5-eee61f671694@lunn.ch>
 <67582fca.050a0220.2d187a.9e01@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67582fca.050a0220.2d187a.9e01@mx.google.com>

On Tue, Dec 10, 2024 at 01:10:45PM +0100, Christian Marangi wrote:
> On Tue, Dec 10, 2024 at 02:36:29AM +0100, Andrew Lunn wrote:
> > > +config AIR_AN8855_PHY
> > > +	tristate "Airoha AN8855 Internal Gigabit PHY"
> > > +	help
> > > +	  Currently supports the internal Airoha AN8855 Switch PHY.
> > > +
> > >  config AIR_EN8811H_PHY
> > >  	tristate "Airoha EN8811H 2.5 Gigabit PHY"
> > >  	help
> > 
> > Do you have any idea why the new one is AN, and previous one is EN?  I
> > just like consistent naming, or an explanation why it is not
> > consistent.
> >
> 
> EN EcoNet that was then absorbed by Airoha (AN). Hence it's the same
> thing. Airoha is suggesting to use AN for new submission. So it's just
> about timing.

Thanks for the explanation.

> 
> > > +#define AN8855_PHY_ID				0xc0ff0410
> > > +static struct phy_driver an8855_driver[] = {
> > > +{
> > > +	PHY_ID_MATCH_EXACT(AN8855_PHY_ID),
> > 
> > Is there any documentation about the ID, and the lower nibble. Given
> > it is 0, i'm wondering if PHY_ID_MATCH_EXACT() is correct.
> >
> 
> I will check this but I doubt there is any explaination. These are internal
> to the switch so my theory is that no exact logic was applied.

O.K. It can always be changed later, if a different revision of the
PHY appears.

	Andrew

