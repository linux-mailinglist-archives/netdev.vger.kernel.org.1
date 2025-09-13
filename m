Return-Path: <netdev+bounces-222744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E04B55A7C
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 02:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A33B55C099A
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 00:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B94C6FC5;
	Sat, 13 Sep 2025 00:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6xa6N1m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E242B4A04;
	Sat, 13 Sep 2025 00:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757721656; cv=none; b=KzYOIz3ubYU/HEj9OYh3/xZjiVNGTTyiWaDpX1rhxS1mCzTV38DrT4Dxe7Y58wAGD+zWwcjIhfPPLwRWW1vf+PNdWx51DnHclMOluBUinI+7IVMwgVTXfMpqkrq3+HQtOnoNhao+qlVuleIVwGv5Epio+w0ULl/OHxSAyRQTu18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757721656; c=relaxed/simple;
	bh=vDd0droX2aKcaau/BNTdQdVX/uMVNYwOAjEVk2x/OR0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TfDgOw2Yb1UTOHwLUPX5QFNak8LBJs7vl6zdpftWUZUnm+D1WZripg4OIsYxeOE6g1nwspzacG3V/Ap7fdi3ktwkDwt5YCq/vo3vIIof9DmZxs49tok280zwkDpkAs9vnA5+YMyWq/hYe3Z5hQjcd2dMFbdvu3gwKssshCPY0so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6xa6N1m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D41C4CEF5;
	Sat, 13 Sep 2025 00:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757721655;
	bh=vDd0droX2aKcaau/BNTdQdVX/uMVNYwOAjEVk2x/OR0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z6xa6N1msn3dWzdap/jTIR6yKJnb3Fq3ylNH5lk/XVgayapDO1QXYB1QNw4GSOTQ3
	 qxb8IIsz7q09LOLU8DAKpXGZDoFAV1wIUuLtx6yMx/NDO8jdghaDTQ5WR8h/9lZJKy
	 D7fGRTgsJpbk2MMmmGm8GjsQ0LTlVpcGtxgIqHIdqrg4dxZfSM6ZauLyKJt7S+Ypzc
	 4hgiUR3niakewJazMQjQGJeLm187U/o08ITsvOKc8S9ZX9NnXWMycFhsPW+cK2y95Z
	 plnVJVOAD6dU/Ks2tJf98EbgErdD2gxChjy4b3wrlUNTRksqdFBatcggH1c8AAMOTS
	 GQ6IZr2AUM02Q==
Date: Fri, 12 Sep 2025 17:00:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Kory Maincent
 <kory.maincent@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Nishanth Menon <nm@ti.com>,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
 linux-doc@vger.kernel.org, Michal Kubecek <mkubecek@suse.cz>, Roan van Dijk
 <roan@protonic.nl>
Subject: Re: [PATCH net-next v5 2/5] ethtool: netlink: add
 ETHTOOL_MSG_MSE_GET and wire up PHY MSE access
Message-ID: <20250912170053.24348da3@kernel.org>
In-Reply-To: <aMPw7kUddvGPJCzx@pengutronix.de>
References: <20250908124610.2937939-1-o.rempel@pengutronix.de>
	<20250908124610.2937939-3-o.rempel@pengutronix.de>
	<20250911193440.1db7c6b4@kernel.org>
	<aMPw7kUddvGPJCzx@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Sep 2025 12:07:42 +0200 Oleksij Rempel wrote:
> > > +      -
> > > +        name: max-average-mse
> > > +        type: u32
> > > +      -
> > > +        name: max-peak-mse
> > > +        type: u32
> > > +      -
> > > +        name: refresh-rate-ps
> > > +        type: u64
> > > +      -
> > > +        name: num-symbols
> > > +        type: u64  
> > 
> > type: uint for all these?  
> 
> I would prefer to keep u64 for refresh-rate-ps and num-symbols.
> 
> My reasoning comes from comparing the design decisions of today's industrial
> hardware to the projected needs of upcoming standards like 800 Gbit/s. This
> analysis shows that future PHYs will require values that exceed the limits of a
> u32.

but u64 may or may not also have some alignment expectations, which uint
explicitly excludes

> > > +      -
> > > +        name: header
> > > +        type: nest
> > > +        nested-attributes: header
> > > +      -
> > > +        name: channel
> > > +        type: u32  
> > 
> > Please annotate attrs which carry enums and flags with
> > 
> > 	enum: $name  
> 
> Sorry, I can't follow here. What do you mean?

The values carried by this attr are from enum phy-mse-channel right?
So you should annotate the attribute, this way C will use an enum
type, and Python will decode the values into a human readable string.

> > > +        enum: phy-mse-channel
> > > +      -
> > > +        name: config
> > > +        type: nest
> > > +        nested-attributes: mse-config  
> > 
> > config sounds like something we'd be able to change
> > Looks like this is more of a capability struct?  
> 
> Yes? mse-config describes haw the measurements in the snapshot should be
> interpreted.

Right. 'capability' is not great either, but as I said 'config' sounds
like something that's tunable by the user. 

> > > +      -
> > > +        name: snapshot
> > > +        type: nest
> > > +        multi-attr: true
> > > +        nested-attributes: mse-snapshot  
> > 
> > This multi-attr feels un-netlinky to me.
> > You define an enum for IDs which are then carried inside
> > snapshot.channel. In netlink IDs should be used as attribute types.
> > Why not add an entry here for all snapshot types?  
> 
> Can you please give me some examples here? I feel under-caffeinated, sorry.

Instead of this attr:

	-
		name: channel-a
		type: nest
		nested-attributes: mse-snapshot	
	        multi-attr: true
	-
		name: channel-b
		type: nest
		nested-attributes: mse-snapshot	
	        multi-attr: true
...
	-
		name: worst-channel
		type: nest
		nested-attributes: mse-snapshot	
	        multi-attr: true
...

