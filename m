Return-Path: <netdev+bounces-52054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5087FD24F
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 10:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75B60282D8E
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 09:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AAC1401E;
	Wed, 29 Nov 2023 09:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D907C1BE1
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 01:20:48 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-74-amRDmBUvP_G8wy38RWpp2g-1; Wed, 29 Nov 2023 09:20:45 +0000
X-MC-Unique: amRDmBUvP_G8wy38RWpp2g-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 29 Nov
 2023 09:20:48 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 29 Nov 2023 09:20:48 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Jakub Kicinski' <kuba@kernel.org>, Kent Overstreet
	<kent.overstreet@linux.dev>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Thomas Graf
	<tgraf@suug.ch>, Herbert Xu <herbert@gondor.apana.org.au>
Subject: RE: [PATCH] rhashtable: Better error message on allocation failure
Thread-Topic: [PATCH] rhashtable: Better error message on allocation failure
Thread-Index: AQHaImnu8lfoNsJ1T0CBXnMobWGrXLCRAwSw
Date: Wed, 29 Nov 2023 09:20:48 +0000
Message-ID: <bc3b04ef968647a789431f482cc8246f@AcuMS.aculab.com>
References: <20231123235949.421106-1-kent.overstreet@linux.dev>
	<36bcdab2dae7429d9c2162879d0a3f9a@AcuMS.aculab.com>
	<20231128173536.35ff7e9c@kernel.org>
	<20231129015705.54zmp3xpqxfmo2fx@moria.home.lan>
 <20231128181520.6245fa88@kernel.org>
In-Reply-To: <20231128181520.6245fa88@kernel.org>
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

From: Jakub Kicinski
> Sent: 29 November 2023 02:15
>=20
> On Tue, 28 Nov 2023 20:57:05 -0500 Kent Overstreet wrote:
> > > Yes, that's problematic :(
> > > Let's leave out the GFP_NOWARN and add a pr_warn() instead of
> > > the WARN()?
> >
> > pr_warn() instead of WARN() is fine, but the stack trace from
> > warn_alloc() will be entirely useless.
> >
> > Perhaps if we had a GFP flag to just suppress the backtrace in
> > warn_alloc() - we could even stash a backtrace in the rhashtable at
> > rhashtable_init() time, if we want to print out a more useful one.
>=20
> Interesting idea, up to you how far down the rabbit hole you're
> willing to go, really :)
>=20
> Stating the obvious but would be good to add to the commit message,
> if you decide to implement this, how many rht instances there are
> on a sample system, IOW how much memory we expect the stacks to burn.

It's not really memory, just 'junk' in the console buffer.
But completely supressing the traceback from warn_alloc() (et al)
would give absolutely no indication of what failed.
You wouldn't even know it was a call from rhashtable().

Actually I'd have thought the traceback would show where the hash table
was being allocated - which would (mostly) tell you which one.
(Unless they were being allocated by a worker thread - which seems unlikely=
.)

IIRC the traceback includes the cpu registers (and code??) they probably
are noise for 'controlled' errors like kmalloc failing.

Is the whole extra trace really worthwhile at all?
How often does kmalloc() really fail?
Although if the code recovers by using a smaller table then maybe
that might be worth a trace instead of the one from kmalloc().

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


