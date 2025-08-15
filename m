Return-Path: <netdev+bounces-214212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 228B5B28860
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 00:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC01DAE4B61
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 22:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAE4242D87;
	Fri, 15 Aug 2025 22:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="27VAkc/2"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0553B13FEE;
	Fri, 15 Aug 2025 22:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755297538; cv=none; b=QSbuawqsB3xsKO2pks0o5yrLFMqtHMfkup5buopmDPp5OaBJskYw7Qdy3Hg48u4XUVNqe7Dh3YTGAJKvb+36rmcCQxtqmz4G3aMWgQHuoHZ05wZBglhrHdvD+QZmYUcp2fVpz+cjc6Ac1Hl8rkAsLhIT5V/aB8R/F2GpQpRrEXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755297538; c=relaxed/simple;
	bh=SU5U9JA8BpJrLDqB6qFZ5x7j2WQF/0eO5Lpaikl8yFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tBtO8V4G3I3c0pc9Qbv8zTyvgbc0PhLleLuelVTHYgbjniwfqrY6XD/kw217WHewZAjKdUnPU7l+G+ZJCnvWMqIDNFCx0iBdHU/m08vLebyduuFE3XL3if7UqnRULBpxJUlYM5ji8oA22O6Y4gUd3x4cMwHOCsGm3+73za/nzVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=27VAkc/2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vH9M3gIPfPvhVLyqEXopQg5B5Azi5msqEGmfM/vCccc=; b=27VAkc/2u764qpgBbHqTK5WWRS
	XL1zcYEU4nMVBCkjVnQcp0a8RyrdamOfE7gbIzdL3kmkiMkjPJASJU3Oteh5NoQ54QjnWmBhpu78g
	jacLrAJBrgdEMIPfJWLSsHK7TwDTrB90jEvvG6mZ0ciwN/T7GcJl2YeM6u2TVCzIj86E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1un34H-004rtV-M4; Sat, 16 Aug 2025 00:38:37 +0200
Date: Sat, 16 Aug 2025 00:38:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Artur Rojek <contact@artur-rojek.eu>
Cc: Rob Landley <rob@landley.net>, Jeff Dionne <jeff@coresemi.io>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] net: j2: Introduce J-Core EMAC
Message-ID: <fc6ed96e-2bab-4f2f-9479-32a895b9b1b2@lunn.ch>
References: <20250815194806.1202589-1-contact@artur-rojek.eu>
 <20250815194806.1202589-4-contact@artur-rojek.eu>
 <973c6f96-6020-43e0-a7cf-9c129611da13@lunn.ch>
 <b1a9b50471d80d51691dfbe1c0dbe6fb@artur-rojek.eu>
 <02ce17e8f00955bab53194a366b9a542@artur-rojek.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02ce17e8f00955bab53194a366b9a542@artur-rojek.eu>

On Fri, Aug 15, 2025 at 11:14:08PM +0200, Artur Rojek wrote:
> On 2025-08-15 22:52, Artur Rojek wrote:
> > On 2025-08-15 22:16, Andrew Lunn wrote:
> > 
> > Hi Andrew,
> > thanks for the review!
> > 
> > > > +static irqreturn_t jcore_emac_irq(int irq, void *data)
> > > > +{
> > > > +	struct jcore_emac *priv = data;
> > > > +	struct net_device *ndev = priv->ndev;
> > > > +	struct sk_buff *skb;
> > > > +	struct {
> > > > +		int packets;
> > > > +		int bytes;
> > > > +		int dropped;
> > > > +		int crc_errors;
> > > > +	} stats = {};
> > > > +	unsigned int status, pkt_len, i;
> > > 
> > > netdev uses 'reverse christmas tree' for local variables. They should
> > > be sorted longest to shortest. This sometimes means you need to move
> > > assignments into the body of the function, in this case, ndev.
> 
> Should I move the struct stats members into stand alone variables as
> well? Or is below sorting acceptable with regards to stats vs skb:

I would pull the structure definition out of the function. Then just
create one instance of the structure on the stack.

> > > What support is there for MDIO? Normally the MAC driver would not be
> > > setting the carrier status, phylink or phylib would do that.
> > 
> > From what I can tell, none. This is a very simple FPGA RTL
> > implementation of a MAC, and looking at the VHDL, I don't see any MDIO
> > registers.
> 
> > Moreover, the MDIO pin on the PHY IC on my dev board also
> > appears unconnected.
> 
> I spoke too soon on that one. It appears to be connected through a trace
> that goes under the IC. Nevertheless, I don't think MDIO support is in
> the IP core design.

MDIO is actually two pins. MDC and MDIO.

It might be there is a second IP core which implements MDIO. There is
no reason it needs to be tightly integrated into the MAC. But it does
make the MAC driver slightly more complex. You then need a Linux MDIO
bus driver for it, and the DT for the MAC would include a phy-handle
property pointing to the PHY on the MDIO bus.

Is there an Ethernet PHY on your board?

	Andrew

