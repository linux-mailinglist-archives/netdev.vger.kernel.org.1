Return-Path: <netdev+bounces-37626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEE07B660C
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 12:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id E4BE4281607
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 10:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B1419BCB;
	Tue,  3 Oct 2023 10:05:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A02101C7
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 10:05:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0768C433C7;
	Tue,  3 Oct 2023 10:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696327514;
	bh=8m502CALUR1NCPN916HGaWBT0gGqEP8EFmK9inmKPLQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C63hf4q5mw3gjRlkUWGdPeoaF9zDhxjYZ/+buUP4ltnCBkWJvyVjQAPYJrDYvF44x
	 M+c6ObATMFP4tfOtZktbjY3nGNrSsMspUYLAUYJ0ktXHku7R+r6gsQvhXKQoNQuGAM
	 X6bM5VSflq5IlWTmVO8WMgskn97KjJvPasLjYTJpGYyOaW/82vcSaV8NJ/xW5SqsvF
	 PSmqCXna+hQUOL/tKf4QECZ9n7DMtGpMAK9WAy/xSc+J6Jr7z1bo1oTLz+NC+A3tI7
	 qB8nO2p41ere0KTPqr/bTkhiOu4LZ3JCIUz6/zyuNd62qe1TCUBZH83aer6Z+4KFoO
	 qTig+ry9MdO8Q==
Date: Tue, 3 Oct 2023 12:05:10 +0200
From: Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net 2/2] net: dsa: qca8k: fix potential MDIO bus
 conflict when accessing internal PHYs via management frames
Message-ID: <20231003120510.6abd08af@dellmb>
In-Reply-To: <651ab382.df0a0220.e74df.fc51@mx.google.com>
References: <20231002104612.21898-1-kabel@kernel.org>
	<20231002104612.21898-3-kabel@kernel.org>
	<651ab382.df0a0220.e74df.fc51@mx.google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Oct 2023 14:11:43 +0200
Christian Marangi <ansuelsmth@gmail.com> wrote:

> On Mon, Oct 02, 2023 at 12:46:12PM +0200, Marek Beh=C3=BAn wrote:
> > Besides the QCA8337 switch the Turris 1.x device has on it's MDIO bus
> > also Micron ethernet PHY (dedicated to the WAN port).
> >=20
> > We've been experiencing a strange behavior of the WAN ethernet
> > interface, wherein the WAN PHY started timing out the MDIO accesses, for
> > example when the interface was brought down and then back up.
> >=20
> > Bisecting led to commit 2cd548566384 ("net: dsa: qca8k: add support for
> > phy read/write with mgmt Ethernet"), which added support to access the
> > QCA8337 switch's internal PHYs via management ethernet frames.
> >=20
> > Connecting the MDIO bus pins onto an oscilloscope, I was able to see
> > that the MDIO bus was active whenever a request to read/write an
> > internal PHY register was done via an management ethernet frame.
> >=20
> > My theory is that when the switch core always communicates with the
> > internal PHYs via the MDIO bus, even when externally we request the
> > access via ethernet. This MDIO bus is the same one via which the switch
> > and internal PHYs are accessible to the board, and the board may have
> > other devices connected on this bus. An ASCII illustration may give more
> > insight:
> >=20
> >            +---------+
> >       +----|         |
> >       |    | WAN PHY |
> >       | +--|         |
> >       | |  +---------+
> >       | |
> >       | |  +----------------------------------+
> >       | |  | QCA8337                          |
> > MDC   | |  |                        +-------+ |
> > ------o-+--|--------o------------o--|       | |
> > MDIO    |  |        |            |  | PHY 1 |-|--to RJ45
> > --------o--|---o----+---------o--+--|       | |
> >            |   |    |         |  |  +-------+ |
> > 	   | +-------------+  |  o--|       | |
> > 	   | | MDIO MDC    |  |  |  | PHY 2 |-|--to RJ45
> > eth1	   | |             |  o--+--|       | |
> > -----------|-|port0        |  |  |  +-------+ |
> >            | |             |  |  o--|       | |
> > 	   | | switch core |  |  |  | PHY 3 |-|--to RJ45
> >            | +-------------+  o--+--|       | |
> > 	   |                  |  |  +-------+ |
> > 	   |                  |  o--|  ...  | |
> > 	   +----------------------------------+
> >=20
> > When we send a request to read an internal PHY register via an ethernet
> > management frame via eth1, the switch core receives the ethernet frame
> > on port 0 and then communicates with the internal PHY via MDIO. At this
> > time, other potential devices, such as the WAN PHY on Turris 1.x, cannot
> > use the MDIO bus, since it may cause a bus conflict.
> >=20
> > Fix this issue by locking the MDIO bus even when we are accessing the
> > PHY registers via ethernet management frames.
> >=20
> > Fixes: 2cd548566384 ("net: dsa: qca8k: add support for phy read/write w=
ith mgmt Ethernet")
> > Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org> =20
>=20
> Just some comments (micro-optimization) and one question.
>=20
> Wonder if the extra lock would result in a bit of overhead for simple
> implementation where the switch is the only thing connected to the MDIO.
>=20
> It's just an idea and probably not even something to consider (since
> probably the overhead is so little that it's not worth it)
>=20
> But we might consider to add some logic in the MDIO setup function to
> check if the MDIO have other PHY connected and enable this lock (and
> make this optional with an if and a bool like require_mdio_locking)
>=20
> If we don't account for this, yes the lock should have been there from
> the start and this is correct. (we can make it optional only in the case
> where only the switch is connected as it would be the only user and
> everything is already locked by the eth_mgmt lock)

I don't think we should do that. It is possible that a PHY may be
registered during the time that the mutex is locked, even if the PHY is
not defined in device-tree. A driver may be probed that calls
mdiobus_scan, which will cause transactions on the MDIO bus. Currently
there are no such drivers in kernel, but they may be in the future.

Anyway, this is a regression fix, it should be merged. If you want to
optimize it, I think it should be done afterwards in net-next.

> > ---
> >  drivers/net/dsa/qca/qca8k-8xxx.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >=20
> > diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca=
8k-8xxx.c
> > index d2df30640269..4ce68e655a63 100644
> > --- a/drivers/net/dsa/qca/qca8k-8xxx.c
> > +++ b/drivers/net/dsa/qca/qca8k-8xxx.c
> > @@ -666,6 +666,15 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, boo=
l read, int phy,
> >  		goto err_read_skb;
> >  	}
> > =20
> > +	/* It seems that accessing the switch's internal PHYs via management
> > +	 * packets still uses the MDIO bus within the switch internally, and
> > +	 * these accesses can conflict with external MDIO accesses to other
> > +	 * devices on the MDIO bus.
> > +	 * We therefore need to lock the MDIO bus onto which the switch is
> > +	 * connected.
> > +	 */
> > +	mutex_lock(&priv->bus->mdio_lock);
> > + =20
>=20
> Please move this down before the first dev_queue_xmit. (we can save a
> few cycle where locking is not needed)

I put it before the mgmt lock for the following reason: if I first lock
the mgmt_eth_data and only then the MDIO bus mutex, and a MDIO
transaction is being done on another device, the mgmt_eth_data mutex is
unnecessarily locked for a longer time (since MDIO is slow). I thought
that the whole point of register writes via ethernet frames was to make
it faster. If another part of the driver wants to read/write a
switch register, it should not be unnecessarily slowed down because a
MDIO transaction to a unrelated device.

Illustration when MDIO mutex is locked before first skb queue, as you
suggested:

  WAN PHY driver	qca8k PHY read		qca8k reg read

  mdio mutex locked
  reading		eth mutex locked
  reading		mdio mutex lock
  reading		waiting			eth mutex lock
  reading		waiting			waiting
  reading		waiting			waiting
  mdio mutex unlocked	waiting			waiting
			mdio mutex locked	waiting
			reading			waiting
			mdio mutex unlocked	waiting
			eth mutex unlocked	waiting
						eth mutex locked
						reading
						eth mutex unlocked

Illustration when MDIO mutex is locked before eth mutex:

  WAN PHY driver	qca8k PHY read		qca8k reg read

  mdio mutex locked
  reading		mdio mutex lock
  reading		waiting			eth mutex locked
  reading		waiting			reading
  reading		waiting			eth mutex unlocked
  reading		waiting
  mdio mutex unlocked   waiting
			mdio mutex locked
			eth mutex locked
			reading
			eth mutex unlocked
			mdio mutex unlocked

Notice how in the second illustration the qca8k register read is not
slowed by the mdio mutex.

> Also should we use mutex_lock_nested?

That would allow some MDIO bus reads, for example if someone called
mdiobus_read() on the bus. We specifically want to completely avoid=20
this. We are not doing any nested reads on the MDIO bus here, so no,
we should not be using mutex_lock_nested().

Marek

