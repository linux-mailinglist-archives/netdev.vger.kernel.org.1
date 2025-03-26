Return-Path: <netdev+bounces-177770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF98A71AFC
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 16:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CEEC3A4F54
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 15:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03EF1F4190;
	Wed, 26 Mar 2025 15:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="p4E8bHGK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064301EFF98
	for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 15:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743003560; cv=none; b=gp5tL8EdgwvHACa3m737Kqi+4b/U7RI/q4tq8a7Y6ETOVQNYVFGZqYq7g6B4+RqoPnElq17OWNjO564jewgddZIfDxPyOVETYr3DDFN4zw+NgNUFLFRYVCrciyIkjZ2bOdpljwHtvCvLP+LsocrbMFLKdiukCNNmQrH/yB9K8+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743003560; c=relaxed/simple;
	bh=81FZnYYs/VvonlFj0okNWFQ8GorB5pcIkY23pRWB+6k=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I0YgGiZMSmTZfbI+gyk7oyssLCDZ+4EPi0sbeMQLb/MrI5TTDkLyV2IGxnxmCEeM8hhgTAwXazhM2pLkKCBPN+NgIRWphVwTk7N/EGcIwhFtmrD6anzmpz90kRjrI7rOlyHYbYMLiM9WXoqHsk5SVBZbT2ytTNJA0lQdThNypMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=p4E8bHGK; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1743003560; x=1774539560;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=bXx+uFlipcSCMWdpiiJ2n2iYXbFmAsQA9+VCibLw6Ds=;
  b=p4E8bHGK/S5Gw1NSpMD4V4R57vByIHz6hw4Av/xU3Ah7UYMBqYXJBR2h
   cLE7Mu39DiJ5k4HDa+3SybIvWmadXDIwZfkoPMy1Kp6q0TgqnooRi7b3y
   3+Yx/OSfofhDN2ICjwJ5xZNACkcjqTJ3P8/gRRfpoRCnu/TR57ZLj+r8D
   M=;
X-IronPort-AV: E=Sophos;i="6.14,278,1736812800"; 
   d="scan'208";a="478450230"
Subject: RE: [PATCH v8 net-next 4/5] net: ena: PHC stats through sysfs
Thread-Topic: [PATCH v8 net-next 4/5] net: ena: PHC stats through sysfs
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 15:39:16 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.10.100:12554]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.10.171:2525] with esmtp (Farcaster)
 id 2cd13d36-3003-434e-90c8-e3a56244396c; Wed, 26 Mar 2025 15:39:14 +0000 (UTC)
X-Farcaster-Flow-ID: 2cd13d36-3003-434e-90c8-e3a56244396c
Received: from EX19D004EUA002.ant.amazon.com (10.252.50.81) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 26 Mar 2025 15:39:14 +0000
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19D004EUA002.ant.amazon.com (10.252.50.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 26 Mar 2025 15:39:14 +0000
Received: from EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9]) by
 EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9%3]) with mapi id
 15.02.1544.014; Wed, 26 Mar 2025 15:39:14 +0000
From: "Arinzon, David" <darinzon@amazon.com>
To: Leon Romanovsky <leon@kernel.org>, Andrew Lunn <andrew@lunn.ch>
CC: Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Richard Cochran <richardcochran@gmail.com>, "Woodhouse,
 David" <dwmw@amazon.co.uk>, "Machulsky, Zorik" <zorik@amazon.com>,
	"Matushevsky, Alexander" <matua@amazon.com>, "Bshara, Saeed"
	<saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>, "Liguori, Anthony"
	<aliguori@amazon.com>, "Bshara, Nafea" <nafea@amazon.com>, "Schmeilin,
 Evgeny" <evgenys@amazon.com>, "Belgazal, Netanel" <netanel@amazon.com>,
	"Saidi, Ali" <alisaidi@amazon.com>, "Herrenschmidt, Benjamin"
	<benh@amazon.com>, "Kiyanovski, Arthur" <akiyano@amazon.com>, "Dagan, Noam"
	<ndagan@amazon.com>, "Bernstein, Amit" <amitbern@amazon.com>, "Allen, Neil"
	<shayagr@amazon.com>, "Ostrovsky, Evgeny" <evostrov@amazon.com>, "Tabachnik,
 Ofir" <ofirt@amazon.com>, "Machnikowski, Maciek" <maciek@machnikowski.net>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Thread-Index: AQHbjThuiJPiz2SQ3UqXrvl4494FJbNjeHuAgAAfGYCAARXHAIAAuV6AgADbIoCAAB7zAIAfS7KQ
Date: Wed, 26 Mar 2025 15:39:14 +0000
Message-ID: <d3bd72e06fbb42698458c8d0ab81e6cd@amazon.com>
References: <20250304190504.3743-1-darinzon@amazon.com>
 <20250304190504.3743-5-darinzon@amazon.com>
 <21fe01f0-7882-46b8-8e7c-8884f4e803f6@lunn.ch>
 <20250304145857.61a3bd6e@kernel.org>
 <89b4ceae-c2c8-4a7b-9f1b-39b6bce17d34@lunn.ch>
 <20250305183637.2e0f6a9f@kernel.org>
 <ed0fb5d8-5cd7-446a-9637-493224af4fb3@lunn.ch>
 <20250306173142.GU1955273@unreal>
In-Reply-To: <20250306173142.GU1955273@unreal>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> > > > > > I've not been following previous versions of this patch, so i c=
ould=20
> > > > > > be repeating questions already asked....
> > > > > >
> > > > > > ena_adapter represents a netdev?
> > > > > >

Yes, ena_adapter represents a netdev.

> > > > > > /* adapter specific private data structure */ struct ena_adapte=
r {
> > > > > >     struct ena_com_dev *ena_dev;
> > > > > >     /* OS defined structs */
> > > > > >     struct net_device *netdev;
> > > > > >
> > > > > > So why are you not using the usual statistics interface for a n=
etdev?
> > > > >
> > > > > I asked them to do this.
> > > > > They are using a PTP device as a pure clock. The netdev doesn't
> > > > > support any HW timestamping, so none of the stats are related to =
packets.
> > > >
> > > > So how intertwined is the PHC with the network device? Can it be
> > > > separated into a different driver? Moved into drivers/ptp?
> > > >

The PHC device is not a HW timestamping device but rather a PTP clock
that is integrated with the networking device under the same PCI device.
Enabling or disabling the ENA PHC requires reconfiguring the ENA network de=
vice.

> > > > We have already been asked if this means network drivers can be
> > > > configured via sysfs. Clearly we don't want that, so we want to
> > > > get this code out of drivers/net if possible.
> > >
> > > Is it good enough to move the relevant code to a ptp/ or phc/ dir
> > > under ...thernet/amazon/ena/ ? Moving it to ptp/ proper would
> > > require some weird abstractions, not sure if it's warranted?

We agree that relocating the PHC code to drivers/ptp would introduce unnece=
ssary
abstractions and require synchronization mechanisms between drivers.

As with other ENA features, the PHC-related code is contained within
a dedicated file in the ethernet/amazon/ena/ directory.
Would this be an acceptable approach?

Thanks,
David

> > mtd devices have been doing this for decades. And the auxiliary bus
> > seems to be a reinvention of the mtd concepts.
>=20
> No, it is not. MTD concepts are no different from standard
> register_to_other_subsystem practice, where driver stays in one subsystem
> to be used by another.
>=20
> Auxillary bus is different in that it splits drivers to their logical par=
ts and places
> them in right subsystems.
>=20
> Thanks

