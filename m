Return-Path: <netdev+bounces-222333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF41BB53E2C
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 23:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5A077A916E
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 21:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0266E29D272;
	Thu, 11 Sep 2025 21:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="WgXaX624"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF961957FC;
	Thu, 11 Sep 2025 21:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757627768; cv=none; b=t9GRT+iwHZQuhLS9Wl4wT7AX5jejPEaPMD7dzkeY4PZkQYuoihaMdRTme2UHy1IYNFXc10U8FIW5FglhTCFTJlFnvIFs30PoZ1bCGUdyd3xPT5nrrAzqoeQ+C03TYW7ZtTVAvY+HlyyJLsu7wbqu2mWV5zWuie87m98sW3f7CDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757627768; c=relaxed/simple;
	bh=n9wAHM5lPDOPUmR7VKGS6+mcXMpPy0ZPrz0jS//RKBI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M1EqsDurn0kfV4PDCQtwVxgUf6wgPcVJkkbNxTnaLGS9lPTg4/W4xD/HWIq10zR6khHzTODXlfvcI9oZIBWc2jzmpLobqOGlQz5FDkMfkaqT9fIa9hGn3ulb+hEzB0ktVbPs/tXIgmOEziMj53U9WGTSKH/EpvtfT1+GNYuvbxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=WgXaX624; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cNBFm4pRxz9tNF;
	Thu, 11 Sep 2025 23:55:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1757627756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OYxotd5wxGpHXgDa/b3MTB+aIwsC4SQo134x/Z4fbgc=;
	b=WgXaX624JAxBLgd6VZnAzr8kfZvrMtM3OricE3FD7BtH9w1kz4yRWvEJMDTvaH2w3z6Vei
	de4n3QjJrLtF/NUYX+fU26RXy7n1qebR7rWB0/hNBq7W3HrIxwWhKyw7hTWJmKsnKJj/lH
	81ZdtljeZ+nYychNBbHs6P4EGh7UMp+LRhtloCF63waSjhfSpfXVLwvqxPzDnR++NI9BM7
	kRyr11gNVFuHxY+PbJ5YG9EgeYytOyoLw5gx0cuaa5QnXGKCItD9G7ZDprxi6dn0PcdV8l
	Y/C/gMUkOQr5AEUX25JTl7fzE7bH5+URNAJAMkyI34oAQYYXcIJU0mhAVdxI7Q==
Date: Thu, 11 Sep 2025 23:55:47 +0200
From: =?UTF-8?B?xYF1a2Fzeg==?= Majewski <lukasz.majewski@mailbox.org>
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: davem@davemloft.net, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Stefan Wahren
 <wahrenst@gmx.net>, Simon Horman <horms@kernel.org>, Vladimir Oltean
 <vladimir.oltean@nxp.com>
Subject: Re: [net-next v19 4/7] net: mtip: Add net_device_ops functions to
 the L2 switch driver
Message-ID: <20250911235547.477460e4@wsk>
In-Reply-To: <20250910172251.072a8d36@kernel.org>
References: <20250824220736.1760482-1-lukasz.majewski@mailbox.org>
	<20250824220736.1760482-5-lukasz.majewski@mailbox.org>
	<20250827082512.438fd68a@kernel.org>
	<20250907183854.06771a13@wsk>
	<20250908180535.4a6490bf@kernel.org>
	<20250910231552.13a5d963@wsk>
	<20250910172251.072a8d36@kernel.org>
Organization: mailbox.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MBO-RS-META: m5n6r7w5b9m9aofnwhgwpk1hacaixifp
X-MBO-RS-ID: 4a733e75a4d374f700e

Hi Jakub,

> On Wed, 10 Sep 2025 23:15:52 +0200 =C5=81ukasz Majewski wrote:
> > > > I do use skb =3D buld_skb() which, "builds" the SKB around the
> > > > memory page (from pool).
> > > >=20
> > > > Then, I "pass" this data (and swap it) to upper layer of the
> > > > network stack.
> > > >=20
> > > > The same approach is used in the fec_main.c driver:
> > > > https://elixir.bootlin.com/linux/v6.17-rc3/source/drivers/net/ether=
net/freescale/fec_main.c#L1853
> > > >     =20
> > >=20
> > > I probably cut out too much context. I think I was quoting from
> > > Tx, indeed on Rx this is not an issue.   =20
> >=20
> > Ok. No adjustments needed then. Good :) =20
>=20
> No, you were talking about build_skb() which is Rx.
> This is the patch that adds Tx. Tx is wrong.

The same approach is taken in fec_main.c (@ fec_enet_txq_submit_skb()
function).

> You can't modify the skb unless you call skb_cow().
> Or just copy the data out to your local buffer.

In the mtip_start_xmit_port() I do assign the address to skb->data to
bufaddr pointer.

If alignment is wrong the we copy it to bounce buffer.
Then we do swap the buffer if needed.

Last step is to dma map this memory and assign the pointer to the
descriptor for L2 switch transmission.

>=20
> > > > You may have port =3D=3D 1 || port =3D=3D 2 when you receive packet=
 from
> > > > ingres ports.
> > > > You may also have port =3D=3D 0xFF when you first time encounter
> > > > the SA on the port and port =3D=3D 0 when you send/receive data
> > > > from the "host" interface.
> > > >=20
> > > > When port 1/2 is "detected" then the net dev for this particular
> > > > port is used. In other cases the one for NAPI is used (which is
> > > > one of those two - please see comment above).
> > > >=20
> > > > This was the approach from original NXP (Freescale) driver. It
> > > > in some way prevents from "starvation" from net devices when L2
> > > > switch is disabled and I need to provide port separation.
> > > >=20
> > > > (port separation in fact is achieved by programming L2 switch
> > > > registers and is realized in HW).     =20
> > >=20
> > > But what if we have mixed traffic from port 1 and 2?
> > > Does the current code correctly Rx the packets from port 1 on the
> > > netdev from port 1 and packets from port 2 on the netdev from
> > > port 2?   =20
> >=20
> > Yes, it does.
> >=20
> > In the mtip_rx_napi() you have call to mtip_switch_rx() which
> > accepts pointer to port variable.
> >=20
> > It sets it according to the information provided by the switch IP
> > block HW and also adjust the skb's ndev.
> >=20
> > I'm just wondering if the snippet from mtip_rx_napi():
> > -------8<--------
> > if ((port =3D=3D 1 || port =3D=3D 2) && fep->ndev[port - 1]
> > 	mtip_switch_tx(fep->ndev[port - 1]);
> > else
> > 	mtip_switch_tx(napi->dev); =20
> > ------->8--------   =20
> >=20
> > could be replaced just with mtip_switch_tx(napi->dev);
> > as TX via napi->dev shall be forward to both ports if required.
> >=20
> > I will check if this can be done in such a way. =20
>=20
> Not napi->dev. You have to attribute sent packets to the right netdev.

And then we do have some issue to solve. To be more specific -
fec_main.c to avoid starvation just from fec_enet_rx_napi() calls
fec_enet_tx() with only one net device (which it supports).

I wanted to mimic such behaviour with L2 switch driver (at
mtip_rx_napi()), but then the question - which network device (from
available two) shall be assigned?

The net device passed to mtip_switch_tx() is only relevant for
"housekeeping/statistical data" as in fact we just provide another
descriptor to the HW to be sent.

Maybe I shall extract the net device pointer from the skb structure?

>=20
> > > > As I said - we do have only ONE queue, which corresponds to
> > > > uDMA0 when the switch is enabled. This single queue is
> > > > responsible for handling transmission for both ports (this is
> > > > how the HW is designed).     =20
> > >=20
> > > Right but kernel has two SW queues.   =20
> >=20
> > You mean a separate SW queues for each devices? This is not
> > supported in the MTIP L2 switch driver. Maybe such high level SW
> > queues management is available in the upper layers? =20
>=20
> Not possible, each netdev has it's own private qdisc tree.

Please correct me if I'm wrong, but aren't packets from those queues
end up with calling ->ndo_start_xmit() function?

>=20
> > > Which can be independently
> > > stopped.   =20
> >=20
> > It supports separate RX and TX HW queues (i.e. ring buffers for
> > descriptors) for the uDMA0 when switch is enabled.
> >=20
> > When you want to send data (no matter from which lan[01] device) the
> > same mtip_start_xmit() is called, the HW TX descriptor is setup and
> > is passed via uDMA0 to L2 switch IP block.
> >=20
> > For next TX transmission (even from different port) we assign
> > another descriptor from the ring buffer.
> >  =20
> > > So my concerns is that for example port 1 is very busy so
> > > the queue is full of packets for port 1, port 1's netdev's queue
> > > gets stopped. Then port 2 tries to Tx, queue is shared, and is
> > > full, so netdev 2's SW queue is also stopped. Then we complete
> > > the packets, because packets were for port 1 we wake the queue
> > > for port 1. But port 2 also got stopped, even tho it never put a
> > > packet on the ring..=20
> >=20
> > As fair as I can tell - both ports call mtip_start_xmit(), their
> > data is serialized to the TX queue (via descriptors).
> >=20
> > Queued descriptors are sent always at some point (or overridden if
> > critical error encountered).
> >  =20
> > > Long story short I think you need to always stop and start queues
> > > from both netdevs.. There's just 2 so not too bad of a hack.   =20
> >=20
> > Maybe there are some peculiarities in for example bridge code (or
> > upper network stack layers in general), but I think, that I don't
> > need any extra "queue" management for TX code of MTIP L2 switch. =20
>=20
> I think I explained this enough times. Next version is v20.
> If it's not significantly better than this one, I'm going to have=20
> to ask you to stop posting this driver.

I don't know how to reply to this comment, really.=20

I've spent many hours of my spare time to upstream this driver.
I'm just disappointed (and maybe I will not say more because of high
level of my frustration).




Could you point me to the driver example which provides such queues
management for switchdev driver? Just to show what you expect from me.

One example.


--=20
Best regards,

=C5=81ukasz Majewski

