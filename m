Return-Path: <netdev+bounces-58216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EB38158F5
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 13:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17A7E1F2326F
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 12:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4BF210FA;
	Sat, 16 Dec 2023 12:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OmENd/29"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872F32C68C;
	Sat, 16 Dec 2023 12:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1fTVB9sYYSZDswzP8ZR5w94cl2xSjwWVlr0JVBmTllU=; b=OmENd/29KCx0N8en2zQgO4eOWZ
	O9ZsdqUo04tt4tYAR6Pdc9fD+Y4+23nas555EbUIsinjefGi1uiebcyl/DbnNDGMnH0bHsfYX8ztq
	VkQjsVgEBOcx7OBrwMxszgcPlqGPBwdIXxLTuMoVxCMB3VjBch0DkD1+cD8C86wghI3Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rETjw-003668-D2; Sat, 16 Dec 2023 13:25:56 +0100
Date: Sat, 16 Dec 2023 13:25:56 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: 20231214201442.660447-5-tobias@waldekranz.com
Cc: Tobias Waldekranz <tobias@waldekranz.com>, davem@davemloft.net,
	kuba@kernel.org, linux@armlinux.org.uk, kabel@kernel.org,
	hkallweit1@gmail.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 4/4] dt-bindings: net: marvell10g: Document LED
 polarity
Message-ID: <3bc3b802-7575-4f0c-b66b-086a767efdb6@lunn.ch>
References: <657c8e53.050a0220.dd6f2.9aaf@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <657c8e53.050a0220.dd6f2.9aaf@mx.google.com>

On Fri, Dec 15, 2023 at 03:22:11PM +0100, Christian Marangi wrote:
> > > +        properties:
> > > +          marvell,polarity:
> > > +            description: |
> > > +              Electrical polarity and drive type for this LED. In the
> > > +              active state, hardware may drive the pin either low or
> > > +              high. In the inactive state, the pin can either be
> > > +              driven to the opposite logic level, or be tristated.
> > > +            $ref: /schemas/types.yaml#/definitions/string
> > > +            enum:
> > > +              - active-low
> > > +              - active-high
> > > +              - active-low-tristate
> > > +              - active-high-tristate
> > 
> > Christian is working on adding a generic active-low property, which
> > any PHY LED could use. The assumption being if the bool property is
> > not present, it defaults to active-high.
> > 
> 
> Hi, it was pointed out this series sorry for not noticing before.
> 
> > So we should consider, how popular are these two tristate values? Is
> > this a Marvell only thing, or do other PHYs also have them? Do we want
> > to make them part of the generic PHY led binding? Also, is an enum the
> > correct representation? Maybe tristate should be another bool
> > property? Hi/Low and tristate seem to be orthogonal, so maybe two
> > properties would make it cleaner with respect to generic properties?
> 
> For parsing it would make it easier to have the thing split.
> 
> But on DT I feel an enum like it's done here might be more clear.

I took a look at a datasheet for a standalone 1G Marvell PHY. It has
the same capabilities. So this is something which can be reused by a
few devices.

So an enum in DT, and an enum for the API to the PHY driver seems like
a good idea. I doubt there will be too many more variants, but it does
give us an easy way to add more values.

	Andrew

