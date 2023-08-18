Return-Path: <netdev+bounces-28728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDB078062B
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 09:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9943282302
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 07:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A349314F83;
	Fri, 18 Aug 2023 07:14:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D65812
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 07:14:18 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DF430D6
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 00:14:16 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-74-ikIsBU2DMkidrrqivs1qkQ-1; Fri, 18 Aug 2023 08:14:14 +0100
X-MC-Unique: ikIsBU2DMkidrrqivs1qkQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 18 Aug
 2023 08:14:12 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 18 Aug 2023 08:14:12 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Kees Cook' <keescook@chromium.org>
CC: 'Przemek Kitszel' <przemyslaw.kitszel@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Jacob Keller <jacob.e.keller@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>, "Steven
 Zou" <steven.zou@intel.com>
Subject: RE: [PATCH net-next v3 1/7] overflow: add DEFINE_FLEX() for on-stack
 allocs
Thread-Topic: [PATCH net-next v3 1/7] overflow: add DEFINE_FLEX() for on-stack
 allocs
Thread-Index: AQHZ0EteSw2XTdntxkSn8fWObNOCVK/uiVWQgAAd6ICAAP4u4A==
Date: Fri, 18 Aug 2023 07:14:11 +0000
Message-ID: <e8e109712a1b42288951c958d2f503a5@AcuMS.aculab.com>
References: <20230816140623.452869-1-przemyslaw.kitszel@intel.com>
 <20230816140623.452869-2-przemyslaw.kitszel@intel.com>
 <1f9cb37f21294c31a01af62fd920f070@AcuMS.aculab.com>
 <202308170957.F511E69@keescook>
In-Reply-To: <202308170957.F511E69@keescook>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Kees Cook
> Sent: Thursday, August 17, 2023 6:00 PM
>=20
> On Thu, Aug 17, 2023 at 02:35:23PM +0000, David Laight wrote:
> > From: Przemek Kitszel
> > > Sent: Wednesday, August 16, 2023 3:06 PM
...
> > > +#define DEFINE_FLEX(type, name, member, count)=09=09=09=09=09\
> > > +=09union {=09=09=09=09=09=09=09=09=09\
> > > +=09=09u8 bytes[struct_size_t(type, member, count)];=09=09=09\
> > > +=09=09type obj;=09=09=09=09=09=09=09\
> > > +=09} name##_u __aligned(_Alignof(type)) =3D {};=09=09=09=09\
> >
> > You shouldn't need the _Alignof() it is the default.
>=20
> In the sense that since "type" is in the union, it's okay?

The alignment of the union is the larger of the alignments
of all its members.
Which is what you want.

> > I'm not sure you should be forcing the memset() either.
>=20
> This already got discussed: better to fail safe.

Perhaps call it DEFINE_FLEX_Z() to make this clear and
give the option for a non-zeroing version later.
Not everyone wants the expense of zeroing everything.

..
> > You might want to add:
> > =09Static_assert(is_constexpr(count), "DEFINE_FLEX: non-constant count =
" #count);
>=20
> That would be nice, though can Static_assert()s live in the middle of
> variable definitions?

I checked and it is fine.
(I double-checked by adding a statement and getting an error.)

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


