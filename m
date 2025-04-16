Return-Path: <netdev+bounces-183298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CBDA9041C
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 15:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CE5F8A0E9F
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 13:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3464F1DF265;
	Wed, 16 Apr 2025 13:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="E4TwsWHh"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5B81DED48
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 13:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744809270; cv=none; b=nD6TmjGTpQuqS37vhM4aCXezaVY1RnKTYVu4M/VHt01U9Hbw+QMLvpnk3fJwb245Qh9eLvLVoVYHCYPIAeU6LIo3K6WytgwmHq/0Kai4EUVFJziLgeDPEf07bgeTLyj46LNla51bGvc1ODT/xSGqWzcsGcFbNK+E3pV4mrEyMsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744809270; c=relaxed/simple;
	bh=AVWdr3k/mydjy+dZrAaYEO6Ji+bkva5sveLDPIUeKh8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZtJ2adVZ6HCzJ8NXzuv9hFvqYfkoNV864KZ0PudQEDh5y+Ai2SBV3AHlkooE8vN6d8xfaPToQXQiFaVktp6Npmlv0H1vpjTUyYHuDFH/ahX8Hmew97JKEHXw07NpqoARdhvd+mcg5OjQHcK456qFSsWmEoooJ0Rv9uReXlNj4wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=E4TwsWHh; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 634DA43B0E;
	Wed, 16 Apr 2025 13:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744809266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+VwrtglluGGLNIPtF57y+K82HxiVQjihULDntyzGWU4=;
	b=E4TwsWHhtUskNNiIIDDZH6hdv62UIgXDcDTxG7POxfmGcH5FZNnIKQNGWb6qxcQLtvlMJj
	53jAGaaz65I1NH5B7cT0tW6fBijTQ0PL+RnJljZoOiaOWO17dgjo2nzmMdFgDpIXD9E7BX
	BoKAkm2+lDWHpbcG3FJ0Lhpdf07XR6Z8Kdb/NbLtPe1k+aku3DSSaRLIxNkB20frg4crxQ
	CkrvNKXIKEgM84we4lqnHzme8OOCsv8BI2wwa3wEj8qCeR4TOBuQ+Rwv2kP8BxHm7MMWZ+
	QN8GHZQQt3FME4kr7kFGXm0XKuSnnJ9q6/tN+M1Vh8EnhD/TO5GlsoBpX+P7Zw==
Date: Wed, 16 Apr 2025 15:14:24 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH RFC net-next 2/5] ptp: marvell: add core support for
 Marvell PTP v2.1
Message-ID: <20250416151424.6d4fbe43@kmaincent-XPS-13-7390>
In-Reply-To: <Z_9252w9vWiGysiF@shell.armlinux.org.uk>
References: <Z_mI94gkKkBslWmv@shell.armlinux.org.uk>
	<E1u3LtV-000CP1-2C@rmk-PC.armlinux.org.uk>
	<20250416104849.43374926@kmaincent-XPS-13-7390>
	<Z_9252w9vWiGysiF@shell.armlinux.org.uk>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdeigeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdutdefvedtudegvefgvedtgfdvhfdtueeltefffefffffhgfetkedvfeduieeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddupdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepu
 ggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: kory.maincent@bootlin.com

On Wed, 16 Apr 2025 10:22:47 +0100
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Wed, Apr 16, 2025 at 10:48:49AM +0200, Kory Maincent wrote:
> > On Fri, 11 Apr 2025 22:26:37 +0100
> > Russell King <rmk+kernel@armlinux.org.uk> wrote: =20
> > > Provide core support for the Marvell PTP v2.1 implementations, which
> > > consist of a TAI (time application interface) and timestamping blocks.
> > > This hardware can be found in Marvell 88E151x PHYs, Armada 38x and
> > > Armada 37xx (mvneta), as well as Marvell DSA devices.
> > >=20
> > > Support for both arrival timestamps is supported, we use arrival 1 for
> > > PTP peer delay messages, and arrival 0 for all other messages.
> > >=20
> > > External event capture is also supported.
> > >=20
> > > PPS output and trigger generation is not supported.
> > >=20
> > > This core takes inspiration from the existing Marvell 88E6xxx DSA PTP
> > > code and DP83640 drivers. Like the original 88E6xxx DSA code, we
> > > use a delayed work to keep the cycle counter updated, and a separate
> > > delayed work for event capture.
> > >=20
> > > We expose the ptp clock aux work to allow users to support single and
> > > multi-port designs - where there is one Marvell TAI instance and a
> > > number of Marvell TS instances. =20
> >=20
> > ...
> >  =20
> > > +#define MV_PTP_MSGTYPE_DELAY_RESP	9
> > > +
> > > +/* This defines which incoming or outgoing PTP frames are timestampp=
ed */
> > > +#define MV_PTP_MSD_ID_TS_EN	(BIT(PTP_MSGTYPE_SYNC) | \
> > > +				 BIT(PTP_MSGTYPE_DELAY_REQ) | \
> > > +				 BIT(MV_PTP_MSGTYPE_DELAY_RESP))
> > > +/* Direct Sync messages to Arr0 and delay messages to Arr1 */
> > > +#define MV_PTP_TS_ARR_PTR	(BIT(PTP_MSGTYPE_DELAY_REQ) | \
> > > +				 BIT(MV_PTP_MSGTYPE_DELAY_RESP)) =20
> >=20
> > Why did you have chosen to use two queues with two separate behavior?
> > I have tried using only one queue and the PTP as master behaves correct=
ly
> > without all these overrun. It is way better with one queue.
> > Maybe it was not the best approach if you want to use the two queues.  =
 =20
>=20
> First, both queues have the same behaviour.

Yes, I was not clear I was referring to the message type.
=20
> Second, because they *aren't* queues as they can only stamp one message.
> The sync messages come from the master on a regular basis. The delay
> response messages come from the master in response to a delay request
> message, the timing of which is determined by the local slave.
>=20
> If the local end sends a delay request just at the point that the master
> sends a sync message causing the master to immediately follow the sync
> message with the delay response message, then we could get an overrun
> on a single queue - because we'll stamp the sync message and if we don't
> read the timestamp quickly enough, the stamp registers will be busy
> preventing the timestamp of the delay response being captured.

Have you already seen such cases?

> With the overruns that I've seen, they've always been on the second
> "queue" and have always been for a sequence number several in the past
> beyond the point that the overrun has been reported. However, the
> packet which the sequence number matches had already been received -
> and several others have also been received. I've been wondering if it's
> a hardware bug, or maybe it's something other bits of the kernel is
> doing wrong.

Yes, in any case, using two queues like that prevents the PTP master from
working properly on my board. I will try to investigate the issue.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

