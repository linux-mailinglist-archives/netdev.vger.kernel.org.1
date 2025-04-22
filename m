Return-Path: <netdev+bounces-184717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E92B8A96FD4
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 17:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EAA83A5497
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 15:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79729292934;
	Tue, 22 Apr 2025 15:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rQ2mMiaz"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4821EF37A;
	Tue, 22 Apr 2025 15:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745334057; cv=none; b=UhC1yg62092+Js3HQtfYfzLefAQCzdYsZm89XDa7SGdn26kbqZKL6f5W6pFr300LadtwUVBZ1pLElHb5Syx9l6+OCsdtS1v6wIOgUziFEGDoHy6zIpLrBjKaNuezs333fyx6ocvXAX25dL4m9Uz9ac+/rzT/a+R5oEukzOud0tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745334057; c=relaxed/simple;
	bh=HZVHS4IPySnMn9xD+qPcIx/5bnoYe6A07DDfnd/Nzyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T839i1Jl5D8YicYHLTVzqp1UsJF31Nz2kk7Delp6ghyhnKj7sYISPwMwHYUrY08+9MpLY8NczDyB+dMjTavY2R5uuAYOM3MaHbcFTyxkrQJmaujZ5emIu36ugjQgg8coDmOH1TGZSciwwDbjOykztVgF5aT29FgXj8EajMXPhGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rQ2mMiaz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=29nqVClkVJOEOI67Hmj+Amifgccth5t3PZQd0ZpbUiQ=; b=rQ2mMiaztt3yrB/gN6a1Hhlc14
	wKRbAfHk6NMJaaWizl24Qp43YxbsrgFfQPwFKEcAeO8ODDl+erqZ/nRkLahizuGzkkOxtoeiS0n/Z
	6qtxNMMBzzTNUnzdqsqmzLhYFAtf4e731yy4HOunBwY0h0kyFPAMyFz+5dBSaChxqwSA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u7F6z-00ADQa-PK; Tue, 22 Apr 2025 17:00:37 +0200
Date: Tue, 22 Apr 2025 17:00:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Whitcroft <apw@canonical.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>, Tero Kristo <kristo@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com
Subject: Re: [PATCH net-next 1/4] dt-bindings: net: ethernet-controller:
 update descriptions of RGMII modes
Message-ID: <a53b5f22-d603-4b7d-9765-a1fc8571614d@lunn.ch>
References: <cover.1744710099.git.matthias.schiffer@ew.tq-group.com>
 <218a27ae2b2ef2db53fdb3573b58229659db65f9.1744710099.git.matthias.schiffer@ew.tq-group.com>
 <aAaafd8LZ3Ks-AoT@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAaafd8LZ3Ks-AoT@shell.armlinux.org.uk>

On Mon, Apr 21, 2025 at 08:20:29PM +0100, Russell King (Oracle) wrote:
> On Tue, Apr 15, 2025 at 12:18:01PM +0200, Matthias Schiffer wrote:
> > diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> > index 45819b2358002..2ddc1ce2439a6 100644
> > --- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> > +++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> > @@ -74,19 +74,21 @@ properties:
> >        - rev-rmii
> >        - moca
> >  
> > -      # RX and TX delays are added by the MAC when required
> > +      # RX and TX delays are part of the board design (through PCB traces). MAC
> > +      # and PHY must not add delays.
> >        - rgmii
> >  
> > -      # RGMII with internal RX and TX delays provided by the PHY,
> > -      # the MAC should not add the RX or TX delays in this case
> > +      # RGMII with internal RX and TX delays provided by the MAC or PHY. No
> > +      # delays are included in the board design; this is the most common case
> > +      # in modern designs.
> >        - rgmii-id
> >  
> > -      # RGMII with internal RX delay provided by the PHY, the MAC
> > -      # should not add an RX delay in this case
> > +      # RGMII with internal RX delay provided by the MAC or PHY. TX delay is
> > +      # part of the board design.
> >        - rgmii-rxid
> >  
> > -      # RGMII with internal TX delay provided by the PHY, the MAC
> > -      # should not add an TX delay in this case
> > +      # RGMII with internal TX delay provided by the MAC or PHY. RX delay is
> > +      # part of the board design.
> >        - rgmii-txid
> >        - rtbi
> >        - smii
> 
> Sorry, but I don't think this wording improves the situation - in fact,
> I think it makes the whole thing way more confusing.
> 
> Scenario 1: I'm a network device driver author. I read the above, Okay,
> I have a RGMII interface, but I need delays to be added. I'll detect
> when RGMII-ID is used, and cause the MAC driver to add the delays, but
> still pass PHY_INTERFACE_MODE_RGMII_ID to phylib.
> 
> Scenario 2: I'm writing a DT file for a board. Hmm, so if I specify
> rgmii because the delays are implemented in the traces, but I need to
> fine-tune them. However, the documentation says that delays must not
> be added by the MAC or the PHY so how do I adjust them. I know, I'll
> use rgmii-id because that allows delays!
> 
> I suspect neither of these two are really want you mean, but given
> this wording, that's exactly where it leads - which is more
> confusion and less proper understanding.

These DT documents are supposed to be normative and OS agnostic. I
wounder what the DT Maintainers will say if we add an Informative
section afterwards giving a detailed description of how Linux actually
implements these normative statements? It will need to open with a
clear statement that it is describing Linux behaviour, and other OSes
can implement the normative part in other ways and still be compliant,
but that Linux has seen a lot of broken implementations and so wants
to add Informative information to guide Linux developers.

   Andrew

