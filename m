Return-Path: <netdev+bounces-184734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD616A97119
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 17:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2901018853FB
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 15:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4902900BA;
	Tue, 22 Apr 2025 15:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="fYDmlBUq"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A0F284B5D;
	Tue, 22 Apr 2025 15:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745335889; cv=none; b=OcUE71CRK+Pml86J9QnwAaNrOheULqsHj85w+qtIwVgIqH+Oj/gpuATzMjCkGX/Nqb9QNqOSi9wAiEnwgXycL/nO7kxjQHpO//pD9/9Feb/RWdtWVPoFfiUQ/2gEZeCaUWwnIhWLCHVNFnYnJ0qczrIh7kn+b7ICfP87t/orhGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745335889; c=relaxed/simple;
	bh=MQNQkrPPcC7LKPOQVQW5RB7uvEPTiEv7n5ZEWn92mSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kM9j+GvpoDrhA6G0kmFlodPde+c5BlLsbZD0evpOs2eYjqm+0qHjhOVFN3AJZPuTuUX052MAuzw7Lu7DxHMnF5WI+KnPgnaKW16wTkYs2yRGcLIzcgMUHlyusSx38G9QgxMLOVKPIlzhxKVFqUDjGWPVazO03O4mEiSdSN7YGSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=fYDmlBUq; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Td9goxiMzFg+ZSKQu8L6C/qdbNZNgQG5kJwAGOsifSk=; b=fYDmlBUq82sXEic7j3/kGcqQpl
	OWpUsCDPaMShS8xWRkUPGWrCVyks24gtdDpLWO2D+2J9m3/UgH9oQfhy3a8kexUxaTAkIxN7dlCen
	4WVxkNoAXeg/tfyXZ1Jb2t4rg2NebadOY5agbKK9CDsk5e8BFlnFzuXoTcy5VPjnMUezYTlZp9CfQ
	LK/x1B2YiTPVJnlJow/0npfaDe3NLEz+/14FVj4VDfCmVxsnmCqrFwNXVkQw8RkzlfQm+Srhz0QNR
	3IAPK7F8AuYhyGVcJDTuYSl2J36+WOlw8AuK9w1NTZxbvOLfKVLMIEB6Kli7PwRtbNQchfwb+CHfP
	hLX2YCRw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37550)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u7FaT-0004dS-1a;
	Tue, 22 Apr 2025 16:31:05 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u7FaO-0007a1-1j;
	Tue, 22 Apr 2025 16:31:00 +0100
Date: Tue, 22 Apr 2025 16:31:00 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
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
Message-ID: <aAe2NFFrcXDice2Z@shell.armlinux.org.uk>
References: <cover.1744710099.git.matthias.schiffer@ew.tq-group.com>
 <218a27ae2b2ef2db53fdb3573b58229659db65f9.1744710099.git.matthias.schiffer@ew.tq-group.com>
 <aAaafd8LZ3Ks-AoT@shell.armlinux.org.uk>
 <a53b5f22-d603-4b7d-9765-a1fc8571614d@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a53b5f22-d603-4b7d-9765-a1fc8571614d@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Apr 22, 2025 at 05:00:37PM +0200, Andrew Lunn wrote:
> On Mon, Apr 21, 2025 at 08:20:29PM +0100, Russell King (Oracle) wrote:
> > On Tue, Apr 15, 2025 at 12:18:01PM +0200, Matthias Schiffer wrote:
> > > diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> > > index 45819b2358002..2ddc1ce2439a6 100644
> > > --- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> > > +++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
> > > @@ -74,19 +74,21 @@ properties:
> > >        - rev-rmii
> > >        - moca
> > >  
> > > -      # RX and TX delays are added by the MAC when required
> > > +      # RX and TX delays are part of the board design (through PCB traces). MAC
> > > +      # and PHY must not add delays.
> > >        - rgmii
> > >  
> > > -      # RGMII with internal RX and TX delays provided by the PHY,
> > > -      # the MAC should not add the RX or TX delays in this case
> > > +      # RGMII with internal RX and TX delays provided by the MAC or PHY. No
> > > +      # delays are included in the board design; this is the most common case
> > > +      # in modern designs.
> > >        - rgmii-id
> > >  
> > > -      # RGMII with internal RX delay provided by the PHY, the MAC
> > > -      # should not add an RX delay in this case
> > > +      # RGMII with internal RX delay provided by the MAC or PHY. TX delay is
> > > +      # part of the board design.
> > >        - rgmii-rxid
> > >  
> > > -      # RGMII with internal TX delay provided by the PHY, the MAC
> > > -      # should not add an TX delay in this case
> > > +      # RGMII with internal TX delay provided by the MAC or PHY. RX delay is
> > > +      # part of the board design.
> > >        - rgmii-txid
> > >        - rtbi
> > >        - smii
> > 
> > Sorry, but I don't think this wording improves the situation - in fact,
> > I think it makes the whole thing way more confusing.
> > 
> > Scenario 1: I'm a network device driver author. I read the above, Okay,
> > I have a RGMII interface, but I need delays to be added. I'll detect
> > when RGMII-ID is used, and cause the MAC driver to add the delays, but
> > still pass PHY_INTERFACE_MODE_RGMII_ID to phylib.
> > 
> > Scenario 2: I'm writing a DT file for a board. Hmm, so if I specify
> > rgmii because the delays are implemented in the traces, but I need to
> > fine-tune them. However, the documentation says that delays must not
> > be added by the MAC or the PHY so how do I adjust them. I know, I'll
> > use rgmii-id because that allows delays!
> > 
> > I suspect neither of these two are really want you mean, but given
> > this wording, that's exactly where it leads - which is more
> > confusion and less proper understanding.
> 
> These DT documents are supposed to be normative and OS agnostic. I
> wounder what the DT Maintainers will say if we add an Informative
> section afterwards giving a detailed description of how Linux actually
> implements these normative statements? It will need to open with a
> clear statement that it is describing Linux behaviour, and other OSes
> can implement the normative part in other ways and still be compliant,
> but that Linux has seen a lot of broken implementations and so wants
> to add Informative information to guide Linux developers.

Well, looking at ePAPR, the only thing that was defined back then was
the presence of a property to describe the interface type between the
ethernet device and PHY. The values were left to the implementation
to decide upon, but with some recommendations.

What that means is that the values to this property are not part of
the DT standard, but are a matter for the implementation.

However, with the yaml stuff, if that is basically becoming "DT
specification" then it needs to be clearly defined what each value
actually means for the system, and not this vague airy-fairy thing
we have now.

We've learnt the hard way in the kernel where that gets us with
the number of back-compat breaking changes we've had to make where
the RGMII delays have been totally wrongly interpreted and leaving
it vague means that other implementations will suffer the same pain.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

