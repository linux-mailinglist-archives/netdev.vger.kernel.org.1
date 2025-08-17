Return-Path: <netdev+bounces-214400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3EFB293FD
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 18:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB5523AD654
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 16:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5704624503F;
	Sun, 17 Aug 2025 16:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Opg5pem+"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE13E221F20;
	Sun, 17 Aug 2025 16:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755446938; cv=none; b=OTbtzrkwWs3CRPr6QMQyYPqYu+xuNq1d2t+GWI3nXz+/1GEx82E2dG/KBzsKz9au5pLHkIsudfkDmrNANKfhZPQb5tJkpxHwY7Kb8PESMGW2TUCMoUjW3fj605JmaPC5e7m0/VbWogJ/I96FLtzo9qEjuezKA+4DcRrdG9Is0b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755446938; c=relaxed/simple;
	bh=skV41jtJKj+HRyzZcu5vgRnO6C4o4EOzdEenmf66HXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mcI4knXBev5jtrVHKPcDiiaQcJCLv9JUHi2LptC5xkIZY24D7Ik1E/H6HqRTcJflFN/J9IDYbDCOQWCBCnV8PsvkERPoVTlzwbD0BN1orJd1stHjAKc/FQO0h35QFP9CvZmgPEJIYiZqf1hqP0VNwfxufObzeFdCGa6ozZyXzfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Opg5pem+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=RuNr5+uELnlthKQSzo8Ze141ti2qAGZDBcFOROky5nk=; b=Opg5pem+Y6Cd3rfPqge7r2J3mY
	KooJEx2sT7wLY0T71B0EOqkig161HizvLhnmfRPz/GRXFi7QfkMhVPltJUb8wXrN/QSFNiM8G/ADh
	XoxLmDfxCSrvxDOjv4XuDd/6sFbaQ42psg0zFZOIF24DB7q6feiLgrB628KJrlykHKiU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1unfw5-004yee-Am; Sun, 17 Aug 2025 18:08:45 +0200
Date: Sun, 17 Aug 2025 18:08:45 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rob Landley <rob@landley.net>
Cc: Artur Rojek <contact@artur-rojek.eu>, Jeff Dionne <jeff@coresemi.io>,
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
Message-ID: <bd36cf9a-3070-493a-9785-33e23123391c@lunn.ch>
References: <20250815194806.1202589-1-contact@artur-rojek.eu>
 <20250815194806.1202589-4-contact@artur-rojek.eu>
 <973c6f96-6020-43e0-a7cf-9c129611da13@lunn.ch>
 <b1a9b50471d80d51691dfbe1c0dbe6fb@artur-rojek.eu>
 <02ce17e8f00955bab53194a366b9a542@artur-rojek.eu>
 <fc6ed96e-2bab-4f2f-9479-32a895b9b1b2@lunn.ch>
 <dd48568e-90db-430a-b910-623c7aaf566e@landley.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd48568e-90db-430a-b910-623c7aaf566e@landley.net>

On Sun, Aug 17, 2025 at 11:04:36AM -0500, Rob Landley wrote:
> On 8/15/25 17:38, Andrew Lunn wrote:
> > > > > What support is there for MDIO? Normally the MAC driver would not be
> > > > > setting the carrier status, phylink or phylib would do that.
> > > > 
> > > >  From what I can tell, none. This is a very simple FPGA RTL
> > > > implementation of a MAC, and looking at the VHDL, I don't see any MDIO
> > > > registers.
> > > 
> > > > Moreover, the MDIO pin on the PHY IC on my dev board also
> > > > appears unconnected.
> > > 
> > > I spoke too soon on that one. It appears to be connected through a trace
> > > that goes under the IC. Nevertheless, I don't think MDIO support is in
> > > the IP core design.
> > 
> > MDIO is actually two pins. MDC and MDIO.
> 
> I asked Jeff and he pointed me at https://github.com/j-core/jcore-soc/blob/master/targets/boards/turtle_1v1/pad_ring.vhd#L732
> and
> https://github.com/j-core/jcore-soc/blob/master/targets/pins/turtle_1v0.pins
> and said those two pins are "wired to zero".
> 
> He also said: "It would only take a few hrs to add MDIO." but there
> basically hasn't been a use case yet.

Has anybody tried a link peer which only does 10Mbps? Or one which
negotiates 100Mbs half duplex? Does the MAC still work, or is the link
dead? That would be one use case, making the system more robust to
such conditions.

	Andrew

