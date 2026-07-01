Return-Path: <netdev+bounces-303777-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zKQuHvVKRWrR+AoAu9opvQ
	(envelope-from <netdev+bounces-303777-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 19:14:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA2D6F03D7
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 19:14:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=nX6eeoJU;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303777-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-303777-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D6D94301982B
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 17:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699BF385D89;
	Wed,  1 Jul 2026 17:05:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE3F37DE98;
	Wed,  1 Jul 2026 17:05:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782925524; cv=none; b=IsvQshr/8oZof2nxP6Mbnx4Xd1Dr6bsC6r7krLcAkZCQ8kx0Za55BNjmw1CwXzbbmoDwisTWWSb3O/QaZAaWGD4XvdR3mFWR0JrlPKYSMWkqxfDNjBoyDMOLPzFCC3BcwTtKLrBGHmHWaV65koFOumRaUVU27us39Fqh8P5Olyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782925524; c=relaxed/simple;
	bh=kyikHHYq7103RTtVY1DSWkKPeB/tAEKF9dHlVnGrOrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRGfryftUauJr73KXHgKwOHic6Ymg951ZiW1oGAnrPzm5ywRgn4+xmu/9jV8i5HsbbgCs9cGvl4OKo38q9TtmPlESxQOrOZxYJILUNy+ptVjHgXFMHMaZtz8HGsA3Gis7EQ4tcjPR65y9KInDvcGGPgahZB2GQGUM2Rc+eJepPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nX6eeoJU; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MxFSTPpY0FYKfF60h712NAcU5QinacG+K9Gn0XhlhBY=; b=nX6eeoJUSnQgzOPWTnnShNnPoq
	WFe9k3hTbmCmA/U0LVQR31IrW+xbdBsoHglTvb0xuMse62n9H01BmCNrWMNQ7eunrKCIa6aUehZ1N
	/zsuj/Ywgvp4jsV43zvp2hN6cKxh+nTlOBXAB1mW45I+dPHNupv4uUhyL/Anqd4n94F0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1weyN6-00ADHN-QP; Wed, 01 Jul 2026 19:05:12 +0200
Date: Wed, 1 Jul 2026 19:05:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] ax88179_178a: Add support for ethtool pause
 parameter configuration
Message-ID: <46553470-9be3-4ae0-824d-ae85441c920d@lunn.ch>
References: <20260701-ax88179a-v1-0-13685df67515@birger-koblitz.de>
 <20260701-ax88179a-v1-5-13685df67515@birger-koblitz.de>
 <587499ee-d87e-4056-8d2a-8fda2ef3f0f1@bootlin.com>
 <947860cc-de6e-48b8-804b-e27f27b2f82c@lunn.ch>
 <d2edb164-91c8-40e4-a104-db690609cb57@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2edb164-91c8-40e4-a104-db690609cb57@birger-koblitz.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-303777-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mail@birger-koblitz.de,m:maxime.chevallier@bootlin.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-usb@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6BA2D6F03D7

On Wed, Jul 01, 2026 at 06:22:31PM +0200, Birger Koblitz wrote:
> Hi Andrew,
> 
> thanks for reviewing this patch-series! I will answer to the other questions later,
> so that the answers stay together. But it is probably best if I give this answer
> immediately:
> On 7/1/26 17:08, Andrew Lunn wrote:
> > > > +static void ax88179a_get_pauseparam(struct net_device *net, struct ethtool_pauseparam *pause)
> > > > +	if (!(bmcr & BMCR_ANENABLE)) {
> > > > +		pause->autoneg = 0;
> > > > +		pause->rx_pause = 0;
> > > > +		pause->tx_pause = 0;
> > > The best way to have this correct is to use phylink, but for that you'd need to
> > > have a proper PHY driver instead of using the mii_ API here.
> > 
> > I said the some to one of the other patches.
> > 
> > Do we know what PHYs are being used? Can register 2 and 3 be read to
> > get the PHY IDs?
> > 
> > 	Andrew
> 
> I tested
>   id1 = ax88179_mdio_read(dev->net, dev->mii.phy_id, MII_PHYSID1);
>   id2 = ax88179_mdio_read(dev->net, dev->mii.phy_id, MII_PHYSID2);
> 
> and got:

Thanks for these numbers.

> Renkforce AX88179A: ID1 7c9f, ID2 7061
> Delock AX88279  ID1 03a2, ID2 a411

air_en8811h.c:#define EN8811H_PHY_ID		0x03a2a411

> UGreen AX88772D ID1 e65b, ID2 2c61
> TP-Link AX88179A ID1 e65b, ID2 2c61

The two ID registers contain part of an OUI, but it has some bits
missing. So it is not so easy to look it up.

However, anything using the MII framework basically assumes a very
simple PHY and only looks at the 802.3 defined registers. So the
genphy generic PHY driver might be sufficient for when there is not a
specific driver. At lot depends on how much extra code there is
accessing the PHY registers in the driver.

	 Andrew

