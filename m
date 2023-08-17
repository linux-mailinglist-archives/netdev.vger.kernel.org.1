Return-Path: <netdev+bounces-28483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CC477F92A
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 16:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 356E91C21475
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 14:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7490134BD;
	Thu, 17 Aug 2023 14:35:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA766125BE
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 14:35:33 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0C22D73
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 07:35:31 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-6-t1ZLIpC4P7uCuSrIMZoxRA-1; Thu, 17 Aug 2023 15:35:27 +0100
X-MC-Unique: t1ZLIpC4P7uCuSrIMZoxRA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 17 Aug
 2023 15:35:23 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 17 Aug 2023 15:35:23 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Przemek Kitszel' <przemyslaw.kitszel@intel.com>, Kees Cook
	<keescook@chromium.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: Jacob Keller <jacob.e.keller@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>, "Steven
 Zou" <steven.zou@intel.com>
Subject: RE: [PATCH net-next v3 1/7] overflow: add DEFINE_FLEX() for on-stack
 allocs
Thread-Topic: [PATCH net-next v3 1/7] overflow: add DEFINE_FLEX() for on-stack
 allocs
Thread-Index: AQHZ0EteSw2XTdntxkSn8fWObNOCVK/uiVWQ
Date: Thu, 17 Aug 2023 14:35:23 +0000
Message-ID: <1f9cb37f21294c31a01af62fd920f070@AcuMS.aculab.com>
References: <20230816140623.452869-1-przemyslaw.kitszel@intel.com>
 <20230816140623.452869-2-przemyslaw.kitszel@intel.com>
In-Reply-To: <20230816140623.452869-2-przemyslaw.kitszel@intel.com>
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

From: Przemek Kitszel
> Sent: Wednesday, August 16, 2023 3:06 PM
>=20
> Using underlying array for on-stack storage lets us to declare
> known-at-compile-time structures without kzalloc().

Isn't DEFINE_FLEX() a bit misleading?
One thing it isn't is 'flexible' since it has a fixed size.

> +#define DEFINE_FLEX(type, name, member, count)=09=09=09=09=09\
> +=09union {=09=09=09=09=09=09=09=09=09\
> +=09=09u8 bytes[struct_size_t(type, member, count)];=09=09=09\
> +=09=09type obj;=09=09=09=09=09=09=09\
> +=09} name##_u __aligned(_Alignof(type)) =3D {};=09=09=09=09\

You shouldn't need the _Alignof() it is the default.
I'm not sure you should be forcing the memset() either.

> +=09type *name =3D (type *)&name##_u

How about?
=09type *const name =3D &name_##_u.obj;

You might want to add:
=09Static_assert(is_constexpr(count), "DEFINE_FLEX: non-constant count " #c=
ount);

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


