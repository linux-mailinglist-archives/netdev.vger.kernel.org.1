Return-Path: <netdev+bounces-221024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DF9B49E86
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 03:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3FB37A9845
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 01:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DAF22154B;
	Tue,  9 Sep 2025 01:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQbBUUZO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8020F209F43;
	Tue,  9 Sep 2025 01:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757379937; cv=none; b=axHL4MF/PhbfLnH8CRu9g289yxqLtkf9qv9Fg8H2vgY+t1DOuAxLeq51tmBrrzp6M/aX19PnpjaEFKD7PDzbJTLK5JrBzwPw74OWya2ejNh+43f8D3wRaPOUeIJc9LAdotulLZOP5svGVvylMmABTSOwkjphCwxla1cYOZfi1IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757379937; c=relaxed/simple;
	bh=lOMpq9HD8ZJq2w0ihl+zDHfmveKIJThydH7VNjKRaeo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F17gbTWAu0TROt2f7nxLcAmnxtiGHY9zrShBPFIPceUQMnCYpG1ol3aY6w+TWNPFl7aFNocNxc2XEMiF1dViaMb7cpI/Bh24JbuVTasp1KsEijXJWsSptsfGqZhqMVWVDdq9EaeR8H8UvWPAfNoZW49G4nLoR0swjJDenuKtCgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQbBUUZO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F907C4CEF1;
	Tue,  9 Sep 2025 01:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757379936;
	bh=lOMpq9HD8ZJq2w0ihl+zDHfmveKIJThydH7VNjKRaeo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QQbBUUZOEKmgcyR1PIp+AIKCcwn8fPT8bMELctKOeIciHM8ykBO4tFcJ3NYKG2ylm
	 M1jxFnADvYk6FZIvi6lSOKzJL0YiuJkMMFKSXZshklN94Uy9IOvXD9dcPop+KGwwvm
	 P1kzpVbIka7Cg/zuycgcpr91a3iXXncT16Iwd2YCsKS++LsFuOv6NhHNFxewmBt0t0
	 C1fB1BHQ/z2a/UxdxfLOzMkR0gioVk5kfbUcD9q2/2DTFHImi8s0xncgbEDz6umetX
	 0R+SgapDsxKYnG8EmRean8vT6oZfwIGm8el7SfSu17WZjVBR7Szo31squJU28nW0dl
	 Se2KrausOUZkQ==
Date: Mon, 8 Sep 2025 18:05:35 -0700
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
Message-ID: <20250908180535.4a6490bf@kernel.org>
In-Reply-To: <20250907183854.06771a13@wsk>
References: <20250824220736.1760482-1-lukasz.majewski@mailbox.org>
	<20250824220736.1760482-5-lukasz.majewski@mailbox.org>
	<20250827082512.438fd68a@kernel.org>
	<20250907183854.06771a13@wsk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 7 Sep 2025 18:38:54 +0200 =C5=81ukasz Majewski wrote:
> > On Mon, 25 Aug 2025 00:07:33 +0200 Lukasz Majewski wrote: =20
> > > +	/* Set buffer length and buffer pointer */
> > > +	bufaddr =3D skb->data;   =20
> >=20
> > You can't write (swap) skb->data if the skb is a clone.. =20
>=20
> I do use skb =3D buld_skb() which, "builds" the SKB around the memory
> page (from pool).
>=20
> Then, I "pass" this data (and swap it) to upper layer of the network
> stack.
>=20
> The same approach is used in the fec_main.c driver:
> https://elixir.bootlin.com/linux/v6.17-rc3/source/drivers/net/ethernet/fr=
eescale/fec_main.c#L1853

I probably cut out too much context. I think I was quoting from Tx,
indeed on Rx this is not an issue.

> What I'm trying to do - is to model the HW which I do have...
>=20
> When switch is enabled I do have ONE uDMA0 which works for both eth
> ports (lan0 and lan1).
>=20
> That is why I do have only one NAPI queue.
>=20
> > What makes my head spin is that you seem to record which
> > netdev/port was doing Rx _last_ and then pass that netdev to
> > mtip_switch_tx(). Why? =20
>=20
> You may have port =3D=3D 1 || port =3D=3D 2 when you receive packet from =
ingres
> ports.
> You may also have port =3D=3D 0xFF when you first time encounter the SA on
> the port and port =3D=3D 0 when you send/receive data from the "host"
> interface.
>=20
> When port 1/2 is "detected" then the net dev for this particular port
> is used. In other cases the one for NAPI is used (which is one of those
> two - please see comment above).
>=20
> This was the approach from original NXP (Freescale) driver. It in some
> way prevents from "starvation" from net devices when L2 switch is
> disabled and I need to provide port separation.
>=20
> (port separation in fact is achieved by programming L2 switch registers
> and is realized in HW).

But what if we have mixed traffic from port 1 and 2?
Does the current code correctly Rx the packets from port 1 on the
netdev from port 1 and packets from port 2 on the netdev from port 2?

> > Isn't the dev that we're completing Tx for is
> > best read from skb->dev packet by packet? =20
>=20
> It may be worth to try.... I think that the code, which we do have now,
> tries to reuse some kind of "locality".
>=20
> > Also this wake up logic
> > looks like it will wake up _one_ netdev's queue and then set tx_full
> > =3D 0, so presumably it will not wake the other port if both ports
> > queues were stopped. Why keep tx_full state in the first place? Just
> > check if the queues is stopped..? =20
>=20
> As I said - we do have only ONE queue, which corresponds to uDMA0 when
> the switch is enabled. This single queue is responsible for handling
> transmission for both ports (this is how the HW is designed).

Right but kernel has two SW queues. Which can be independently stopped.
So my concerns is that for example port 1 is very busy so the queue is
full of packets for port 1, port 1's netdev's queue gets stopped.
Then port 2 tries to Tx, queue is shared, and is full, so netdev 2's
SW queue is also stopped. Then we complete the packets, because packets
were for port 1 we wake the queue for port 1. But port 2 also got
stopped, even tho it never put a packet on the ring..

Long story short I think you need to always stop and start queues from
both netdevs.. There's just 2 so not too bad of a hack.

