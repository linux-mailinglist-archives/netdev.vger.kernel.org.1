Return-Path: <netdev+bounces-242098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57465C8C3C6
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 23:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09BE93A9640
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 22:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949922FD67C;
	Wed, 26 Nov 2025 22:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRRdj9Ry"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E781096F;
	Wed, 26 Nov 2025 22:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764196948; cv=none; b=Jtf21OGhaihUL0sfaQx+7q1f+lSrFYiyCmEYq+44Yw2uJfrETExdx5l30u+71gVMhFXkslWI5VxDGq/plSvM83ZFFYU3Dfh7gfJMM+uTqhhTUe/WFxd1v1s5cjlHqQ6+a6Gj9OAUPfhwokrB2+FPirduzhrEpy1SWzFvQKoeEwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764196948; c=relaxed/simple;
	bh=PRq4OqG77py5Csrg+wbpeqbxUuRVXQjM6NihQgIDLQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UmCC6cre01RXID9CfX60Q9Or4ncjmNJpXUK1zGh9LAYshB3OW/n5MPdTouDBAA+bzxHgnmkjYzfKMlHsmGQO8GueODcJli3csQVXIVzzpboFcE1uEddfrzTfZfa2v26lH2BA1oZjSwtPZfLjFtkwrXOecHeisQKAGRWmQUKpX5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRRdj9Ry; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9427C4CEF7;
	Wed, 26 Nov 2025 22:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764196947;
	bh=PRq4OqG77py5Csrg+wbpeqbxUuRVXQjM6NihQgIDLQ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gRRdj9Ry7euiVzJR42qeCJTPMBFEq0/suFDUEiu/YLybCoOKwplyit5KlDztPlF4s
	 SBkj2mBoTX20vnSlmKDHl9TyEs7ipw7SmWiDe5e2pHryCD7wbVcb7jT/uGDp8YMRkK
	 9rU05eO8HRc7PMMqp9mpDI976rYWcdBJgvJlUzOMkVCdq4TYz2XJ8wDd2cSgRlcC4Y
	 SgnwNktWnpLfJDlTa1HC75sQm9JzD/XCxVmv4CkqcAAllTPpqiXspsxcT0ymIVAtVR
	 vYipaTvcIYzZYtCSB4L6QnnEUjAEeltXVP1SxW1B0LYmZahfyb8tIOVUrnbPL++T2w
	 BfJKI5eIW0WRw==
Date: Wed, 26 Nov 2025 14:42:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Alexei Starovoitov <ast@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Eric Dumazet <edumazet@google.com>, Rob Herring <robh@kernel.org>, Florian
 Fainelli <f.fainelli@gmail.com>, Donald Hunter <donald.hunter@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Jonathan Corbet <corbet@lwn.net>,
 John Fastabend <john.fastabend@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko
 <jiri@resnulli.us>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Divya.Koppera@microchip.com, Kory Maincent <kory.maincent@bootlin.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org,
 Sabrina Dubroca <sd@queasysnail.net>, linux-kernel@vger.kernel.org,
 kernel@pengutronix.de, Krzysztof Kozlowski <krzk+dt@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net-next v8 1/1] Documentation: net: add flow control
 guide and document ethtool API
Message-ID: <20251126144225.3a91b8cc@kernel.org>
In-Reply-To: <aSa8Gkl1AP1U2C9j@pengutronix.de>
References: <20251119140318.2035340-1-o.rempel@pengutronix.de>
	<20251125181957.5b61bdb3@kernel.org>
	<aSa8Gkl1AP1U2C9j@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Nov 2025 09:36:42 +0100 Oleksij Rempel wrote:
> On Tue, Nov 25, 2025 at 06:19:57PM -0800, Jakub Kicinski wrote:
> > On Wed, 19 Nov 2025 15:03:17 +0100 Oleksij Rempel wrote:  
> > > + * @get_pauseparam: Report the configured policy for link-wide PAUSE
> > > + *      (IEEE 802.3 Annex 31B). Drivers must fill struct ethtool_pauseparam
> > > + *      such that:
> > > + *      @autoneg:
> > > + *              This refers to **Pause Autoneg** (IEEE 802.3 Annex 31B) only
> > > + *              and is part of the link autonegotiation process.
> > > + *              true  -> the device follows the negotiated result of pause
> > > + *                       autonegotiation (Pause/Asym);
> > > + *              false -> the device uses a forced MAC state independent of
> > > + *                       negotiation.
> > > + *      @rx_pause/@tx_pause:
> > > + *              represent the desired policy (preferred configuration).
> > > + *              In autoneg mode they describe what is to be advertised;
> > > + *              in forced mode they describe the MAC state to apply.  
> > 
> > How is the user supposed to know what ended up getting configured?  
> 
> My current understanding is that get_pauseparam() is mainly a
> configuration API. It seems to be designed symmetric to
> set_pauseparam(): it reports the requested policy (autoneg flag and
> rx/tx pause), not the resolved MAC state.
> 
> In autoneg mode this means the user sees what we intend to advertise
> or force, but not necessarily what the MAC actually ended up with
> after resolution.
> 
> The ethtool userspace tool tries to fill this gap by showing
> "RX negotiated" and "TX negotiated" fields, for example:
> 
>   Pause parameters for lan1:
>     Autonegotiate:  on
>     RX:             off
>     TX:             off
>     RX negotiated:  on
>     TX negotiated:  on
> 
> As far as I can see, these "negotiated" values are not read from hardware or
> kernel. They are guessed in userspace from the local and link partner
> advertisements, assuming that the kernel follows the same pause resolution
> rules as ethtool does. If the kernel or hardware behaves differently, these
> values can be wrong.
> 
> So, with the current API, the user gets:
> - the configured policy via get_pauseparam(), and
> - an ethtool-side guess of the resolved state via
>   "RX negotiated"/"TX negotiated",

Again, that's all well and good for autoneg, but in DC use cases with
integrated NICs autoneg is usually off. And in that case having get
report "desired" config of some sort makes much less sense, when we also
recommend that drivers reject unsupported configurations.

> > Why do we need to configure autoneg via this API and not link modes directly?  
> 
> I am not aware of a clear reason. This documentation aims to describe
> the current behavior and capture the rationale of the existing API.

To spell it out more forcefully I think it describes the current
behavior for certain devices. I could be wrong but the expectations
for when autoneg is off should be different.

> Configuring it via link modes directly would likely resolve some of this
> confusion, but for now we focus on documenting how the current API is
> expected to behave.

You say current API - is setting Pause and Asym_Pause via link modes
today rejected? I don't see an explicit check by grepping but I haven't
really tried..

