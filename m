Return-Path: <netdev+bounces-40303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B29337C6970
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 11:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BA312828E5
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 09:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEBB421114;
	Thu, 12 Oct 2023 09:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72FA210EA
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 09:26:12 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D629D
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 02:26:10 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-136-Kc7dHQ4TNP2tqTu0Kz4tzg-1; Thu, 12 Oct 2023 10:26:07 +0100
X-MC-Unique: Kc7dHQ4TNP2tqTu0Kz4tzg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 12 Oct
 2023 10:26:06 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 12 Oct 2023 10:26:06 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Stephen Hemminger' <stephen@networkplumber.org>, Johannes Berg
	<johannes@sipsolutions.net>
CC: Jakub Kicinski <kuba@kernel.org>, Nicolas Dichtel
	<nicolas.dichtel@6wind.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "fw@strlen.de" <fw@strlen.de>,
	"pablo@netfilter.org" <pablo@netfilter.org>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "mkubecek@suse.cz" <mkubecek@suse.cz>,
	"aleksander.lobakin@intel.com" <aleksander.lobakin@intel.com>, Thomas Haller
	<thaller@redhat.com>
Subject: RE: [RFC] netlink: add variable-length / auto integers
Thread-Topic: [RFC] netlink: add variable-length / auto integers
Thread-Index: AQHZ/GJtGLGzNn8MkE21q6VfKdfF4LBF4v0A
Date: Thu, 12 Oct 2023 09:26:06 +0000
Message-ID: <e55db83d221d4b5c9fce899cc60cb378@AcuMS.aculab.com>
References: <20231011003313.105315-1-kuba@kernel.org>
	<f75851720c356fe43771a5c452d113ca25d43f0f.camel@sipsolutions.net>
	<6ec63a78-b0cc-452e-9946-0acef346cac2@6wind.com>
	<20231011085230.2d3dc1ab@kernel.org>
	<30be757c7a0bbe50b37e9f2e6f93c8cf4219bbc1.camel@sipsolutions.net>
 <20231011094550.7837d43a@hermes.local>
In-Reply-To: <20231011094550.7837d43a@hermes.local>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Stephen Hemminger
> Sent: 11 October 2023 17:46
>=20
> On Wed, 11 Oct 2023 18:01:49 +0200
> Johannes Berg <johannes@sipsolutions.net> wrote:
>=20
> > On Wed, 2023-10-11 at 08:52 -0700, Jakub Kicinski wrote:
> >
> > > > > > Even for arches which don't have good unaligned access - I'd th=
ink
> > > > > > that access aligned to 4B *is* pretty efficient, and that's all
> > > > > > we need. Plus kernel deals with unaligned input. Why can't user=
 space?
> > > > >
> > > > > Hmm. I have a vague recollection that it was related to just not =
doing
> > > > > it - the kernel will do get_unaligned() or similar, but userspace=
 if it
> > > > > just accesses it might take a trap on some architectures?
> > > > >
> > > > > But I can't find any record of this in public discussions, so ...
> > > > If I remember well, at this time, we had some (old) architectures t=
hat triggered
> > > > traps (in kernel) when a 64-bit field was accessed and unaligned. M=
aybe a mix
> > > > between 64-bit kernel / 32-bit userspace, I don't remember exactly.=
 The goal was
> > > > to align u64 fields on 8 bytes.
> > >
> > > Reading the discussions I think we can chalk the alignment up
> > > to "old way of doing things". Discussion was about stats64,
> > > if someone wants to access stats directly in the message then yes,
> > > they care a lot about alignment.
> > >
> > > Today we try to steer people towards attr-per-field, rather than
> > > dumping structs. Instead of doing:
> > >
> > > =09struct stats *stats =3D nla_data(attr);
> > > =09print("A: %llu", stats->a);
> > >
> > > We will do:
> > >
> > > =09print("A: %llu", nla_get_u64(attrs[NLA_BLA_STAT_A]));
> >
> > Well, yes, although the "struct stats" part _still_ even exists in the
> > kernel, we never fixed that with the nla_put_u64_64bit() stuff, that wa=
s
> > only for something that does
> >
> > =09print("A: %" PRIu64, *(uint64_t *)nla_data(attrs[NLA_BLA_STAT_A]));
> >
> > > Assuming nla_get_u64() is unalign-ready the problem doesn't exist.
> >
> > Depends on the library, but at least for libnl that's true since ever.
> > Same for libmnl and libnl-tiny. So I guess it only ever hit hand-coded
> > implementations.
>=20
> Quick check of iproute2 shows places where stats are directly
> mapped without accessors. One example is print_mpls_stats().

You 'just' need to use the 64bit type that has __attribute__((aligned(4))).
The same is true for the code that reads/writes the value.
Better than passing by address and using memcpy();

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


