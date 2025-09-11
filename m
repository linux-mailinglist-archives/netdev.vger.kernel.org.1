Return-Path: <netdev+bounces-221901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9D0B524F4
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 02:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07FE07AD649
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 00:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B4F170826;
	Thu, 11 Sep 2025 00:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i52ZFODY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12CF13AD05;
	Thu, 11 Sep 2025 00:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757550173; cv=none; b=KOpCVLNBu+76ms4u5dLu8OHjHF1eabxjb0pZerw8h0+yvhSvVXjHs9SQJwye7MhDF5sY140LplDLB7E3SOKSBqxgQTgTYrv11jhXYjqyhcYo5N0g660/h5lOhPPjBet4rw148yfw5gzxc3VAHMdJrbzut17RvafRWy5jcxUpng8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757550173; c=relaxed/simple;
	bh=3jhXISuBePjdRc28QV10bEyxfZW++/4+rnhlfaFG4TQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NLwv0uoltSpMMW0TqcaQCLDe4hhLj7z34p5uENl/l1ciLZvPh0UC+DS7svKk/kR4WTrso1cRPhXUddQNvN3IgzonE7A6Jpg+XthcRWHZptvbp/BNvnAP0t4KsIhFoJ1r7i+YC3knUiM50L62UnIgtj2CWs/crQ/6TjlQhsWQRzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i52ZFODY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5974C4CEEB;
	Thu, 11 Sep 2025 00:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757550173;
	bh=3jhXISuBePjdRc28QV10bEyxfZW++/4+rnhlfaFG4TQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i52ZFODYMHww4ukoSCYBB0gKhmjOdv13UwWd/T2dMkrFLDRdbz+wXLy0QDuA11pNZ
	 nMJjH5kGv1IMZtdlU756ENaoseb6TyMpt2PWVbdkpvIdLBJhcULyypP+/rq5wk4n2a
	 CwQ09Y0DsLJgb8sQ2alPWPsNUxLEIFbzxgOHcw5rBhEaSrH1KAd9vXkcanro4XJ33w
	 KpFMcVr+iCU2Z/Ax1JVehK/0fdXfiKrjbMKc9apyuh7h+HTtazKx7YSBzl4fKyfVSt
	 wkm1pklByS/tk6PcmH1t2uL+7OZr/NwBTptVWA0Fd4acws5ZWTgYPSpoWhMTVsIqhj
	 q7gHm3gx6v+0g==
Date: Wed, 10 Sep 2025 17:22:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?xYF1a2Fzeg==?= Majewski <lukasz.majewski@mailbox.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Richard Cochran
 <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Stefan Wahren
 <wahrenst@gmx.net>, Simon Horman <horms@kernel.org>
Subject: Re: [net-next v19 4/7] net: mtip: Add net_device_ops functions to
 the L2 switch driver
Message-ID: <20250910172251.072a8d36@kernel.org>
In-Reply-To: <20250910231552.13a5d963@wsk>
References: <20250824220736.1760482-1-lukasz.majewski@mailbox.org>
	<20250824220736.1760482-5-lukasz.majewski@mailbox.org>
	<20250827082512.438fd68a@kernel.org>
	<20250907183854.06771a13@wsk>
	<20250908180535.4a6490bf@kernel.org>
	<20250910231552.13a5d963@wsk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Sep 2025 23:15:52 +0200 =C5=81ukasz Majewski wrote:
> > > I do use skb =3D buld_skb() which, "builds" the SKB around the memory
> > > page (from pool).
> > >=20
> > > Then, I "pass" this data (and swap it) to upper layer of the network
> > > stack.
> > >=20
> > > The same approach is used in the fec_main.c driver:
> > > https://elixir.bootlin.com/linux/v6.17-rc3/source/drivers/net/etherne=
t/freescale/fec_main.c#L1853
> > >   =20
> >=20
> > I probably cut out too much context. I think I was quoting from Tx,
> > indeed on Rx this is not an issue. =20
>=20
> Ok. No adjustments needed then. Good :)

No, you were talking about build_skb() which is Rx.
This is the patch that adds Tx. Tx is wrong.
You can't modify the skb unless you call skb_cow().
Or just copy the data out to your local buffer.

> > > You may have port =3D=3D 1 || port =3D=3D 2 when you receive packet f=
rom
> > > ingres ports.
> > > You may also have port =3D=3D 0xFF when you first time encounter the =
SA
> > > on the port and port =3D=3D 0 when you send/receive data from the "ho=
st"
> > > interface.
> > >=20
> > > When port 1/2 is "detected" then the net dev for this particular
> > > port is used. In other cases the one for NAPI is used (which is one
> > > of those two - please see comment above).
> > >=20
> > > This was the approach from original NXP (Freescale) driver. It in
> > > some way prevents from "starvation" from net devices when L2 switch
> > > is disabled and I need to provide port separation.
> > >=20
> > > (port separation in fact is achieved by programming L2 switch
> > > registers and is realized in HW).   =20
> >=20
> > But what if we have mixed traffic from port 1 and 2?
> > Does the current code correctly Rx the packets from port 1 on the
> > netdev from port 1 and packets from port 2 on the netdev from port 2? =
=20
>=20
> Yes, it does.
>=20
> In the mtip_rx_napi() you have call to mtip_switch_rx() which accepts
> pointer to port variable.
>=20
> It sets it according to the information provided by the switch IP block
> HW and also adjust the skb's ndev.
>=20
> I'm just wondering if the snippet from mtip_rx_napi():
> -------8<--------
> if ((port =3D=3D 1 || port =3D=3D 2) && fep->ndev[port - 1]
> 	mtip_switch_tx(fep->ndev[port - 1]);
> else
> 	mtip_switch_tx(napi->dev);
> ------->8-------- =20
>=20
> could be replaced just with mtip_switch_tx(napi->dev);
> as TX via napi->dev shall be forward to both ports if required.
>=20
> I will check if this can be done in such a way.

Not napi->dev. You have to attribute sent packets to the right netdev.

> > > As I said - we do have only ONE queue, which corresponds to uDMA0
> > > when the switch is enabled. This single queue is responsible for
> > > handling transmission for both ports (this is how the HW is
> > > designed).   =20
> >=20
> > Right but kernel has two SW queues. =20
>=20
> You mean a separate SW queues for each devices? This is not supported
> in the MTIP L2 switch driver. Maybe such high level SW queues
> management is available in the upper layers?

Not possible, each netdev has it's own private qdisc tree.

> > Which can be independently
> > stopped. =20
>=20
> It supports separate RX and TX HW queues (i.e. ring buffers for
> descriptors) for the uDMA0 when switch is enabled.
>=20
> When you want to send data (no matter from which lan[01] device) the
> same mtip_start_xmit() is called, the HW TX descriptor is setup and is
> passed via uDMA0 to L2 switch IP block.
>=20
> For next TX transmission (even from different port) we assign another
> descriptor from the ring buffer.
>=20
> > So my concerns is that for example port 1 is very busy so
> > the queue is full of packets for port 1, port 1's netdev's queue gets
> > stopped. Then port 2 tries to Tx, queue is shared, and is full, so
> > netdev 2's SW queue is also stopped. Then we complete the packets,
> > because packets were for port 1 we wake the queue for port 1. But
> > port 2 also got stopped, even tho it never put a packet on the ring..
> >  =20
>=20
> As fair as I can tell - both ports call mtip_start_xmit(), their data
> is serialized to the TX queue (via descriptors).
>=20
> Queued descriptors are sent always at some point (or overridden if
> critical error encountered).
>=20
> > Long story short I think you need to always stop and start queues from
> > both netdevs.. There's just 2 so not too bad of a hack. =20
>=20
> Maybe there are some peculiarities in for example bridge code (or upper
> network stack layers in general), but I think, that I don't need any
> extra "queue" management for TX code of MTIP L2 switch.

I think I explained this enough times. Next version is v20.
If it's not significantly better than this one, I'm going to have=20
to ask you to stop posting this driver.

