Return-Path: <netdev+bounces-103980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1453A90AAE7
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 12:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B065E1F21C90
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 10:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC4C194083;
	Mon, 17 Jun 2024 10:19:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A0817B413
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 10:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718619551; cv=none; b=K7SzJbg5JNQGlf+Sg5sFrsythRdlSy2Mk7MTCPgQlbhTkYp8idrJQKQV74ZbzbXKHOZABr82sfwV+dywWDGWaWnlNGcepZZ4RVy6X0URS6XqkkuwYXCaaglSdbUTmhUjI1T8QCffmBdJqSebl/dGxh07rFRRk/7oTN2MrA3gg2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718619551; c=relaxed/simple;
	bh=Mp1RjHMU3/RVbL4rUjYPB+tCdG1+8HIZNgK/uAPxw7Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=GYejqTqtwgeOBqGmG9orpfXwHZrUHU+dKJHkqQfxm4j5khcu+mhGzv8Vvlki213ZavKNQtX4XrrIIqTH02u0f+MDroHBeb3GxN0bdIIKcE7JPfSk8JVExXA4izUiZ6pE+JC4+lI7cVgF2mTCA96KqrkviwMp2u1PNUJq02Vu0Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-55-XgXb84H0Pvqbn7RJYgkCXg-1; Mon, 17 Jun 2024 11:19:01 +0100
X-MC-Unique: XgXb84H0Pvqbn7RJYgkCXg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 17 Jun
 2024 11:18:18 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 17 Jun 2024 11:18:18 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Matthew Wilcox' <willy@infradead.org>
CC: 'Sagi Grimberg' <sagi@grimberg.me>, kernel test robot
	<oliver.sang@intel.com>, "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
	"lkp@intel.com" <lkp@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>
Subject: RE: [PATCH] net: micro-optimize skb_datagram_iter
Thread-Topic: [PATCH] net: micro-optimize skb_datagram_iter
Thread-Index: AQHav87vWshbN1FSGkaaeddPsMjEkbHK7lSQ///wfgCAAN/H4A==
Date: Mon, 17 Jun 2024 10:18:18 +0000
Message-ID: <e6a1eb41578c46609aa862b8f9148665@AcuMS.aculab.com>
References: <202406161539.b5ff7b20-oliver.sang@intel.com>
 <4937ffd4-f30a-4bdb-9166-6aebb19ca950@grimberg.me>
 <e2bce6704b20491e8eb2edd822ae6404@AcuMS.aculab.com>
 <Zm9e0OpCaucP4836@casper.infradead.org>
In-Reply-To: <Zm9e0OpCaucP4836@casper.infradead.org>
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

From: Matthew Wilcox
> Sent: 16 June 2024 22:53
>=20
> On Sun, Jun 16, 2024 at 09:51:05PM +0000, David Laight wrote:
> > From: Sagi Grimberg
> > > Sent: 16 June 2024 10:24
> > ...
> > > > [ 13.498663][ T189] EIP: usercopy_abort (mm/usercopy.c:102 (discrim=
inator 12))
> > > > [   13.499424][  T194] usercopy: Kernel memory exposure attempt det=
ected from kmap (offset 0,
> size
> > > 8192)!
> > >
> > > Hmm, not sure I understand exactly why changing kmap() to
> > > kmap_local_page() expose this,
> > > but it looks like mm/usercopy does not like size=3D8192 when copying =
for
> > > the skb frag.
> >
> > Can't a usercopy fault and have to read the page from swap?
> > So the process can sleep and then be rescheduled on a different cpu?
> > So you can't use kmap_local_page() here at all.
>=20
> I don't think you understand how kmap_local_page() works.

Quite likely :-)

But I thought it was a cheap way of temporarily mapping a physical memory
page into the current cpu's page tables without having to do any IPI to
tell other cpu about the insert or removal?
Which would require that the process not be migrated, which pretty much
implies that pre-emption be disabled.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


