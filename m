Return-Path: <netdev+bounces-258288-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIj2BvmLjGmHqgAAu9opvQ
	(envelope-from <netdev+bounces-258288-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 15:02:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D417F12509F
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 15:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90AB33010B87
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 14:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F4E28640B;
	Wed, 11 Feb 2026 14:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bmsdh2+j"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8835D25A359;
	Wed, 11 Feb 2026 14:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770818549; cv=none; b=ZQY9Wk0jz18V6y4e2ijcF+JtfLYCmn9wuLdkOG9aqwNWg0Wjp0RzpT1P/2s/jJjE0+lgZZQN4R5PoRSx1qWo4+g09Bgur87pmE6S7bwQzlfy2MPvIUHJjUcsp5qAYggTmp+0uRdnuAR3m0GxwkDzYqQ85m5fKDRBS5MQ5oMlGvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770818549; c=relaxed/simple;
	bh=+P8eqhuI0NkNiO4o0ManyV2fZWkZL0WZOBVNe4WQ83A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=poNbRw833mrFxHze/s9SDf4fnxJ6oMKVaHbPgcGGW21wwJBeKi/w1dNYip+DnSkuS/3i0mdUF3VC2iIRcrMVHZwAdIgi8sBP/bpZ67I2RGgRII5M1Pi4wgi62nbAtRXte2mUgTdD460+oaAi34DYCLfl3A4eQlGp/BOGkvN64Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bmsdh2+j; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=tY4oC5xh3Jod/8tMlUFDEdsEFbCQAy3X7zxLZZa6sRs=; b=bm
	sdh2+joGnkiGwc3Jf7m29omQe20dfCNSsq+PCt5xyWvrykhAHwcesuFIfbIZV//DiIZ0G23fx1ajI
	gXP86UNThUiKb57KHfXOGNjAUIfPNc/PlYjspIdJJWhiEB7ioTUfb2C5nsZ20umMEFGX+cQGnHJGm
	7geqj9K55yyZ7sM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vqAn6-006zts-2k; Wed, 11 Feb 2026 15:02:04 +0100
Date: Wed, 11 Feb 2026 15:02:04 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Teresa Remmet <t.remmet@phytec.de>
Cc: "robh@kernel.org" <robh@kernel.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	Jan Remmet <j.remmet@phytec.de>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"afd@ti.com" <afd@ti.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	Benjamin Hahn <b.hahn@phytec.de>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	Yashwanth Varakala <y.varakala@phytec.de>,
	"upstream@lists.phytec.de" <upstream@lists.phytec.de>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Yannic Moog <y.moog@phytec.de>
Subject: Re: [PATCH 1/2] dt-bindings: dp83867: add binding for
 ti,output-impedance property
Message-ID: <0c021636-5a69-48df-8c13-a320e8f4278f@lunn.ch>
References: <20260129-wip-t-remmet-phytec-de-bspimx95-132_upstream-v1-0-8deccd658d16@phytec.de>
 <20260129-wip-t-remmet-phytec-de-bspimx95-132_upstream-v1-1-8deccd658d16@phytec.de>
 <20260210144849.GB2675838-robh@kernel.org>
 <cfe612e3aa7455d61825d94de627caa384628854.camel@phytec.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cfe612e3aa7455d61825d94de627caa384628854.camel@phytec.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258288-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,phytec.de,davemloft.net,ti.com,redhat.com,armlinux.org.uk,vger.kernel.org,gmail.com,google.com,lists.phytec.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: D417F12509F
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 12:50:13PM +0000, Teresa Remmet wrote:
> Hello Rob,
> 
> Am Dienstag, dem 10.02.2026 um 08:48 -0600 schrieb Rob Herring:
> > On Thu, Jan 29, 2026 at 03:13:33PM +0100, Teresa Remmet wrote:
> > > Add an optional device tree property, "ti,output-impedance", which
> > > specifies the output impedance using a raw register field value
> > > from
> > > 0x0 to 0x1f.
> > > 
> > > 0x0 corresponds to the highest impedance (approximately 70 ohms),
> > > while 0x1f represents the lowest (approximately 35 ohms).
> > > 
> > > This property allows the impedance to be configured through the
> > > device-tree to any required value rather than being limited to
> > > fixed
> > > minimum or maximum settings.
> > > 
> > > Signed-off-by: Teresa Remmet <t.remmet@phytec.de>
> > > ---
> > >  Documentation/devicetree/bindings/net/ti,dp83867.yaml | 19
> > > ++++++++++++++-----
> > >  1 file changed, 14 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/net/ti,dp83867.yaml
> > > b/Documentation/devicetree/bindings/net/ti,dp83867.yaml
> > > index 4bc1f98fd9fe..a8d8bfb68bee 100644
> > > --- a/Documentation/devicetree/bindings/net/ti,dp83867.yaml
> > > +++ b/Documentation/devicetree/bindings/net/ti,dp83867.yaml
> > > @@ -52,11 +52,20 @@ properties:
> > >      description: |
> > >        MAC Interface Impedance control to set the programmable
> > > output impedance
> > >        to a maximum value (70 ohms).
> > > -      Note: Specifying an io_impedance_ctrl nvmem cell or one of
> > > the
> > > -        ti,min-output-impedance, ti,max-output-impedance
> > > properties
> > > -        are mutually exclusive. If more than one is present, an
> > > nvmem
> > > -        cell takes precedence over ti,max-output-impedance, which
> > > in
> > > -        turn takes precedence over ti,min-output-impedance.
> > > +      Note: Specifying an io_impedance_ctrl nvmem cell, ti,output-
> > > impedance
> > > +        or one of the boolean ti,min-output-impedance and ti,max-
> > > output-impedance
> > > +        properties is mutually exclusive.
> > > +        If more than one is present the priority order is nvmem
> > > cell,
> > > +        ti,output-impedance, ti,max-output-impedance and last
> > > +        ti,min-output-impedance.
> > > +
> > > +  ti,output-impedance:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    description:
> > > +      MAC Interface Impedance control to set the raw register
> > > value from 0x0
> > > +      (approx. 70 ohms) to 0x1f (approx. 35 ohms).
> > > +    minimum: 0
> > > +    maximum: 31
> > 
> > How does this compare to 'mac-termination-ohms'? Seems like this
> > should 
> > be a common property whether it's the same or for a different
> > location.
> 
> the difference is that the termination is not passed in ohms but a raw
> register value that can not directly be matched to a resistance value.
> 
> The datasheet says here "Output impedance approximate range from 35-
> 70ohms in 32 steps.
> Lowest being 11111 and highest being 00000. Range and Step size
> will vary with process."
> 
> So using 'mac-termination-ohms' seemed not the right fit here as the
> documentation talks about selecting a resistance value which is not
> possible in this case.

You need a really good argument to use raw register values in DT.

Given real life use case, how important is the "approximate"? Do you
need to tune the value for every single device? Or is one value likely
to work for all instances of a board?

So long as you state the values are approximate, i don't see why you
cannot use ohms, with a range of 34 - 70, and let the driver convert
to register value.

   Andrew

