Return-Path: <netdev+bounces-111872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E728C933D00
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 14:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 168461C2241E
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 12:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2CD180A60;
	Wed, 17 Jul 2024 12:31:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E79B1802A7
	for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 12:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721219485; cv=none; b=uySd06SBj/oTRLt2TooY9f08U1UHbpuVBn23jP9NQkdCFeBt1k15SdqaZncrBZuA2zJKnc1wv2Qe2ctWc/s68hkW5wQlwKC5FQQsAus789cn2zQede8xK00Cw3TR2wjVYTMikFVNFlWdWW8Isnn0ITHtZt3DApCHj+np9n1SFA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721219485; c=relaxed/simple;
	bh=UNszfCjChXTTd/rpztGRz0i9zU7cMX073/88o9O5mgE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=MOYLCMOmzPmpnyjXFxokQVEURHs1P+3kJsC0noSXrr5Ey65tG1mV6qxXDL8gcYErcWiSa8aLHGd8uM8XDyOI6T4DMHp8G6owob5fAl3WurMhYXr9J2BdAJpbXUERK0OgV4a6SBy4OtOO59xlVg8tEX1pRRb3szW8AB212NIsUFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-321-dz86oElmNVWuwStxJxcuUw-1; Wed, 17 Jul 2024 13:31:14 +0100
X-MC-Unique: dz86oElmNVWuwStxJxcuUw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 17 Jul
 2024 13:30:35 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 17 Jul 2024 13:30:35 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Thorsten Blum' <thorsten.blum@toblux.com>, "Russell King (Oracle)"
	<linux@armlinux.org.uk>
CC: "marcin.s.wojtas@gmail.com" <marcin.s.wojtas@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next] net: mvpp2: Improve data types and use min()
Thread-Topic: [PATCH net-next] net: mvpp2: Improve data types and use min()
Thread-Index: AQHa16hWNoGlAe16mU2xD580+EMHA7H61/pA
Date: Wed, 17 Jul 2024 12:30:35 +0000
Message-ID: <3f8d78d6b539465c8040888409eb35a7@AcuMS.aculab.com>
References: <20240711154741.174745-1-thorsten.blum@toblux.com>
 <ZpVDVHXh4FTZnmUv@shell.armlinux.org.uk>
 <D2AAC5AF-59D0-4985-A3DD-EC9E72324CD7@toblux.com>
In-Reply-To: <D2AAC5AF-59D0-4985-A3DD-EC9E72324CD7@toblux.com>
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

From: Thorsten Blum
> Sent: 16 July 2024 18:49
>=20
> On 15. Jul 2024, at 17:44, Russell King (Oracle) <linux@armlinux.org.uk> =
wrote:
> > On Thu, Jul 11, 2024 at 05:47:43PM +0200, Thorsten Blum wrote:
> >> Change the data type of the variable freq in mvpp2_rx_time_coal_set()
> >> and mvpp2_tx_time_coal_set() to u32 because port->priv->tclk also has
> >> the data type u32.
> >>
> >> Change the data type of the function parameter clk_hz in
> >> mvpp2_usec_to_cycles() and mvpp2_cycles_to_usec() to u32 accordingly
> >> and remove the following Coccinelle/coccicheck warning reported by
> >> do_div.cocci:
> >>
> >>  WARNING: do_div() does a 64-by-32 division, please consider using div=
64_ul instead
> >>
> >> Use min() to simplify the code and improve its readability.
> >>
> >> Compile-tested only.
> >>
> >> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> >
> > I'm still on holiday, but it's a wet day today. Don't expect replies
> > from me to be regular.
> >
> > I don't think this is a good idea.
> >
> > priv->tclk comes from clk_get_rate() which returns an unsigned long.
> > tclk should _also_ be an unsigned long, not a u32, so that the range
> > of values clk_get_rate() returns can be represented without being
> > truncted.
> >
> > Thus the use of unsigned long elsewhere where tclk is passed into is
> > actually correct.
>=20
> I don't think tclk should be an unsigned long.
>=20
> In [1] Eric Dumazet wrote:
>=20
>   "This is silly, clk_hz fits in a u32, why pretends it is 64bit ?"
>=20
> and all functions in mvpp2_main.c (mvpp2_write(), do_div(),
> device_property_read_u32(), and mvpp22_gop_fca_set_timer()), which have
> tclk as a direct or indirect argument, assume tclk is a u32.
>=20
> Although mvpp2_cycles_to_usec() suggests it can be called with an
> unsigned long clk_hz, do_div() then immediately casts it to a u32
> anyway.
>=20
> Yes, the function clk_get_rate() returns an unsigned long according to
> its signature, but tclk is always used as a u32 afterwards.
>=20
> I'm not familiar with the hardware, but I guess the clock rate always
> fits into 32 bits (just like Eric wrote)?

'long' can't be correct - it is 32bit on 32bit systems.
They are just as likely to have a clock that is faster than 4GHz than a 64b=
it system.

The type should either be u64 or u32 (or just unsigned int - Linux isn't go=
ing to
get far if int is 16 bits).
This is true of a lot of the uses of 'long'.

There are cases where 'long' will generate better code than 'int' on 64bit =
systems.
In particular it can save sign/zero extension (and maybe masking) of functi=
on
parameters and results.
But that is only likely to matter on very hot paths - and particularly for =
array indexes.
(OTOH the masking for char/short is likely to be really horrid on anything =
except x86.)

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


