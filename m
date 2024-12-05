Return-Path: <netdev+bounces-149350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F859E5346
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 12:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5818A167990
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 11:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243441DB924;
	Thu,  5 Dec 2024 11:02:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107911DD87D
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 11:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733396543; cv=none; b=tfvwzgIQOxRirdhFH5gNxmw0OCHvULEqhstkFra2MC5wwe2WRXysN3AEYIHaSTlZLs4htJnKM6jAc4T5eInMk28O9cPsuWERyPkihWEdQMes6viC/CZmv1EhVTtxw/S7SfdiJ9nsYDosf6PtMGeZTqA/lB2045gCDeR6VhtF+jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733396543; c=relaxed/simple;
	bh=1JXHICbLubrrPzAiD36/7f4WwirzHepM8WRrclSlmrE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=QMFT94vq3xF3Gv/mkzjP81GlUUJuKExydCeB5FpO2qRoCEama2H3NsELJIzym+m/nzWGnm3L4GIuJhdAffmhQSo0sDvyT7QIp1giUBdyLvRS8sSxIr7ts4KVXIn/4AxxSzGmSwbqHzsZB+9hvNmRwTMEhKDRzW6UYfBKNm/QrZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mtapsc-5-yrpZNFbUOxOUAdmBBR9Lbw-1; Thu, 05 Dec 2024 11:02:18 +0000
X-MC-Unique: yrpZNFbUOxOUAdmBBR9Lbw-1
X-Mimecast-MFC-AGG-ID: yrpZNFbUOxOUAdmBBR9Lbw
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 5 Dec
 2024 11:01:37 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 5 Dec 2024 11:01:37 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'David Howells' <dhowells@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Marc Dionne
	<marc.dionne@auristor.com>, Yunsheng Lin <linyunsheng@huawei.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"linux-afs@lists.infradead.org" <linux-afs@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 02/37] rxrpc: Use umin() and umax() rather than
 min_t()/max_t() where possible
Thread-Topic: [PATCH net-next 02/37] rxrpc: Use umin() and umax() rather than
 min_t()/max_t() where possible
Thread-Index: AQHbRMbh0C4h7ofUKUqfMucF4fVa+LLW8I5ggACM0QCAAAFxUA==
Date: Thu, 5 Dec 2024 11:01:37 +0000
Message-ID: <9f8c979a7a2c4b78961297ee2fae380e@AcuMS.aculab.com>
References: <35033e7d707b4c68ae125820230d3cd3@AcuMS.aculab.com>
 <20241202143057.378147-1-dhowells@redhat.com>
 <20241202143057.378147-3-dhowells@redhat.com>
 <1760515.1733395814@warthog.procyon.org.uk>
In-Reply-To: <1760515.1733395814@warthog.procyon.org.uk>
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
X-Mimecast-MFC-PROC-ID: LYRA5oK7bALqONEaAy301mBtzkFxPDPp0JpYPOCUu0o_1733396537
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: David Howells
> Sent: 05 December 2024 10:50
>=20
> David Laight <David.Laight@ACULAB.COM> wrote:
>=20
> > > Use umin() and umax() rather than min_t()/max_t() where the type spec=
ified
> > > is an unsigned type.
> >
> > You are also changing some max() to umax().
>=20
> Good point.  If I have to respin my patches again, I'll update that.
>=20
> > Presumably they have always passed the type check so max() is fine.
> > And max(foo, 1) would have required that 'foo' be 'signed int' and coul=
d
> > potentially be negative when max(-1, 1) will be 1 but umax(-1, 1) is
> > undefined.
>=20
> There have been cases like this:
>=20
> =09unsigned long timeout;
> =09...
> =09timeout =3D max(timeout, 1);
>=20
> where the macro would complain because it thought "timeout" and "1" were
> different sizes, so "1UL" had to be used.  Using umax() deals with that i=
ssue.

The current version of max() won't complain if you use "1".
It uses statically_true((x) >=3D 0) to decide whether values are valid
for an unsigned compare.

So even:
=09int r =3D fn();
=09unsigned int u =3D fu();
=09if (r < 0)
=09=09return r;
=09return max(r, u);

is fine since modern compilers do limited domain tracking.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


