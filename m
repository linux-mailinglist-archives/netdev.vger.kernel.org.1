Return-Path: <netdev+bounces-103816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2473D909A06
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 23:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07A5E1C20DE3
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 21:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2354F881;
	Sat, 15 Jun 2024 21:35:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349BE8F48
	for <netdev@vger.kernel.org>; Sat, 15 Jun 2024 21:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718487343; cv=none; b=eU6lUSISX+nLkKW724lBQbXncokxdyjQjjKEntXkNCcF16UaHaA3EV9AS6tQMNEofrmzVDLAXK95rZXA7beaIOmw0VDmiAT0WeB77Cy20ws7pFudIZ7wF4W1OT77d3ZkY0NzGvU9MmysLNoSTptTRoH/nUcl3bXN6wQtDY33hg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718487343; c=relaxed/simple;
	bh=qmJN1lve7JcoiGFq1UrMKhgHoWc3m9quj0gzt2Le7jk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=m8G+HAI0VM1tRRwspP7rAE+wJ0YdTT/GMgUgqfWuPid+BTY2AZAKIromOjcM0M+s60fftQjuDC4GsdxeNuXrTLkLDhTV0lwEOgq+SUZ0N9y0qqlYjc+swVTSJf/pIw85ufk6t0OFCN1RikSlTxdIdNvYuid+k7W8VH9h2hJleyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-257-WcpmdJxuOlyzpwH8SkS-PQ-1; Sat, 15 Jun 2024 22:35:28 +0100
X-MC-Unique: WcpmdJxuOlyzpwH8SkS-PQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 15 Jun
 2024 22:34:52 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 15 Jun 2024 22:34:52 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Christoph Hellwig' <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
CC: Jakub Kicinski <kuba@kernel.org>, Aurelien Aptel <aaptel@nvidia.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "kbusch@kernel.org"
	<kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>, "chaitanyak@nvidia.com"
	<chaitanyak@nvidia.com>, "davem@davemloft.net" <davem@davemloft.net>
Subject: RE: [PATCH v25 00/20] nvme-tcp receive offloads
Thread-Topic: [PATCH v25 00/20] nvme-tcp receive offloads
Thread-Index: AQHau8pbCx3DyDdCX0iDpwrmm4Yu8LHJXahA
Date: Sat, 15 Jun 2024 21:34:52 +0000
Message-ID: <df4db10f6f3946e29e7e7340cfa82c33@AcuMS.aculab.com>
References: <20240529160053.111531-1-aaptel@nvidia.com>
 <20240530183906.4534c029@kernel.org> <20240531061142.GB17723@lst.de>
 <06d9c3c9-8d27-46bf-a0cf-0c3ea1a0d3ec@grimberg.me>
 <20240610122939.GA21899@lst.de>
 <9a03d3bf-c48f-4758-9d7f-a5e7920ec68f@grimberg.me>
 <20240611064132.GA6727@lst.de>
In-Reply-To: <20240611064132.GA6727@lst.de>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Christoph Hellwig
> Sent: 11 June 2024 07:42
>=20
> On Mon, Jun 10, 2024 at 05:30:34PM +0300, Sagi Grimberg wrote:
> >> efficient header splitting in the NIC, either hard coded or even
> >> better downloadable using something like eBPF.
> >
> > From what I understand, this is what this offload is trying to do. It u=
ses
> > the nvme command_id similar to how the read_stag is used in iwarp,
> > it tracks the NVMe/TCP pdus to split pdus from data transfers, and maps
> > the command_id to an internal MR for dma purposes.
> >
> > What I think you don't like about this is the interface that the offloa=
d
> > exposes
> > to the TCP ulp driver (nvme-tcp in our case)?
>=20
> I don't see why a memory registration is needed at all.
>=20
> The by far biggest painpoint when doing storage protocols (including
> file systems) over IP based storage is the data copy on the receive
> path because the payload is not aligned to a page boundary.

How much does the copy cost anyway?
If the hardware has merged the segments then it should be a single copy.
On x86 (does anyone care about anything else :-) 'rep mosvb' with a
cache-line aligned destination runs at 64 bytes/clock.
(The source alignment doesn't matter at all.)
I guess it loads the source data into the D-cache, the target is probably
required anyway - or you wouldn't be doing a read.

=09David

>=20
> So we need to figure out a way that is as stateless as possible that
> allows aligning the actual data payload on a page boundary in an
> otherwise normal IP receive path.

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


