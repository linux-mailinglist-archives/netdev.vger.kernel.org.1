Return-Path: <netdev+bounces-193533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F87AC4590
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 01:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94C133BBA3C
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 23:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF184242927;
	Mon, 26 May 2025 23:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yWWKgFek"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A287222D4F3;
	Mon, 26 May 2025 23:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748303104; cv=none; b=EZfK4L5DDXro1LhyW4gPqS/Lq29a5PhJNz5hJgd3u0DIDTtHXM85NbzLDWaXplwIMPInzSuB1XS2SdHA7n5KFJrE8p3KZysWvRMXk4vNdM/fnAw+q9CwILm+YdNF/XfbxLq6aHY7aGNTgZOnlxqFQPAWCpSaaEi8j+o0veV/ObM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748303104; c=relaxed/simple;
	bh=FZSBS27OaAKhhV4whTtVW8ZK3jzD7UI+u09fqhveTBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DOQendXH6pp6QII08uSEWsbrIYablDcRFZ84iSYcYr6aUfNfCK7Lnb++3lvD6r8ngc8FIdaiFB4SW+qeHI6CvKCeGlQVlWUs3lwe0ZkSK1O2LqWHcHhBRpybm9ipX1gO8EjTHunQlkJ+XA/puYVrYFllt7kLEoIXGzEVznc1TxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=yWWKgFek; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=wpx05RwRHHkVRpqjDEcKuQQ8Zth2dvnTm25o9c3BaDo=; b=yW
	WKgFekByTfK2c2ak42pq1t6Q/4epu/H/rih7ndmoBkH4Tfq8mq8RQSW0Ke2Bqjtzc5Y5fk9Q+tu8i
	N1a3VYLjmnICX2YYoqkO72HKmg4sbjT3EfplsuOb4gh/Q8G2uYOajHdjha+xAFKy+rg9Vlkt3L4x7
	5LiRrnzSt2MJTBA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uJhV0-00E27K-Pv; Tue, 27 May 2025 01:44:54 +0200
Date: Tue, 27 May 2025 01:44:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: netdev@vger.kernel.org, linux-sunxi@lists.linux.dev,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] dt-bindings: net: sun8i-emac: Add AC300 EMAC1
 nvmem phy selection
Message-ID: <d9d0881b-12cd-40af-bb22-d84236d2e04d@lunn.ch>
References: <20250526182939.2593553-1-james.hilliard1@gmail.com>
 <20250526182939.2593553-3-james.hilliard1@gmail.com>
 <959e576e-bf36-4d01-9ffb-023931b61574@lunn.ch>
 <CADvTj4oqjCkMeK0p8ZBa8PQmctc77hpiFK2pqgBJaxRFDgQoDQ@mail.gmail.com>
 <d4109cc5-83d5-4acd-b0fb-39a50043060b@lunn.ch>
 <CADvTj4qdoD-mo7CxNW8VitZf+wXTiZ7m28R4JPQ9kQJGhUH7bA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADvTj4qdoD-mo7CxNW8VitZf+wXTiZ7m28R4JPQ9kQJGhUH7bA@mail.gmail.com>

On Mon, May 26, 2025 at 05:22:48PM -0600, James Hilliard wrote:
> On Mon, May 26, 2025 at 4:38 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > On Mon, May 26, 2025 at 03:32:03PM -0600, James Hilliard wrote:
> > > On Mon, May 26, 2025 at 1:36 PM Andrew Lunn <andrew@lunn.ch> wrote:
> > > >
> > > > > +        phy-mode = "rgmii";
> > > >
> > > > Does the PCB have extra long clock lines?
> > >
> > > I'm not sure, it's a copackaged(maybe on-die is the wrong terminology)
> > > PHY I think so I assume the clock lines are internal, in the device specific
> > > dts we set something like this on the emac1 node:
> > > allwinner,rx-delay-ps = <3100>;
> > > allwinner,tx-delay-ps = <700>;
> >
> > Those values are just weird. The RGMII delay should be 2000ps. 3100 is
> > way too big, and 700 is way too small.
> 
> I think these may not actually be required when using the internal
> EPHY's now that I think about it again.
> 
> > I think phy-mode = "internal" would be better, and just hard code the
> > delays either in the MAC or PHY driver.
> 
> Hmm, would that make sense even though the MAC driver also
> supports external PHY's?

If an external PHY is being used, i would not expect a phy-mode of
internal.
 
> > Thanks for the link to the old thread, which was 5 years
> > ago. Hopefully since then, a bit more has been learnt. Quickly reading
> > through that thread, i don't think an MFD is not the correct solution.
> 
> Well the current patches I've been playing around with for the AC200
> phy are pretty similar to those patches still.
> 
> Here's a branch that works on both AC200/AC300 but only if I do
> the PHY initialization in u-boot:
> https://github.com/jameshilliard/linux-h616/commits/acx00

I personally don't like depending on the bootloader. I often replace
the bootloader, because it is a crippled version that does not let me
TFTP boot, does not have flash enabled for saving configuration, and i
want to use barebox etc. I think it is much better when Linux drives
the hardware, not the bootloader.

> 
> > In the last 5 years we have had to deal with more chicken/egg problems
> > with PHYs. It has now become pretty much standard practice to put the
> > ID values in DT, to get the driver probed when the device does not
> > respond on the bus.
> 
> This is what I'm doing right? I mean I'm putting the phy ID in the
> DT for both the AC200 and AC300. When doing the reset driver
> for say the AC200 I would wire that up to only the AC200 phy
> node and not the AC300 node(since the AC300 reset is MDIO
> based while the AC200 is i2c based).
> 
> > The DT node can then use phandles to the reset and
> > clock controller to configure them as needed, the core will probably
> > do that. I2C is a bit messier, you probably want a phandle pointing to
> > the i2c_adapter, so you can use i2c_transfer() on it in the probe()
> > function.
> 
> Without a MFD or some other node that exposes a reset I'm a bit
> confused about what driver would actually issue the reset.
> 
> Yeah, we need a phandle to the i2c_adapter, but since the resets
> would be under the AC200 PHY node I assume there would need
> to be some sort of intermediary driver implementing the i2c reset
> right?

You need an reset controller, yes, but is that an MFD? Or just a reset
controller? Where does this reset controller live?

Question like this show we are missing the big picture. What are all
the different parts, how are they interconnected? Once we see that, we
can give you better advice.

	Andrew

