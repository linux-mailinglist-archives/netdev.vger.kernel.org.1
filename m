Return-Path: <netdev+bounces-17631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E33F752746
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 17:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76326281E37
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 15:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953F61ED54;
	Thu, 13 Jul 2023 15:34:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8812D182CD
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 15:34:36 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE192D45
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 08:34:29 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-96-72mzMEKxMcawh9IWZJu5jg-1; Thu, 13 Jul 2023 16:34:27 +0100
X-MC-Unique: 72mzMEKxMcawh9IWZJu5jg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 13 Jul
 2023 16:34:26 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 13 Jul 2023 16:34:26 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Leon Romanovsky' <leon@kernel.org>, Krister Johansen
	<kjlx@templeofstupid.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Shay Agroskin
	<shayagr@amazon.com>, Arthur Kiyanovski <akiyano@amazon.com>, David Arinzon
	<darinzon@amazon.com>, Noam Dagan <ndagan@amazon.com>, Saeed Bishara
	<saeedb@amazon.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
Subject: RE: [PATCH net] net: ena: fix shift-out-of-bounds in exponential
 backoff
Thread-Topic: [PATCH net] net: ena: fix shift-out-of-bounds in exponential
 backoff
Thread-Index: AQHZs8j5z2bF0RP/C0e6CLHv2DmaRK+310mw
Date: Thu, 13 Jul 2023 15:34:25 +0000
Message-ID: <20412c4fb06147c3b2e4ae90ed26fdb7@AcuMS.aculab.com>
References: <20230711013621.GE1926@templeofstupid.com>
 <20230711072603.GI41919@unreal>
In-Reply-To: <20230711072603.GI41919@unreal>
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
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Leon Romanovsky
> Sent: 11 July 2023 08:26
...
> > +#define ENA_MAX_BACKOFF_DELAY_EXP 16U
> > +
> >  #define ENA_MIN_ADMIN_POLL_US 100
> >
> >  #define ENA_MAX_ADMIN_POLL_US 5000
> > @@ -536,6 +538,7 @@ static int ena_com_comp_status_to_errno(struct ena_=
com_admin_queue *admin_queue,
> >
> >  static void ena_delay_exponential_backoff_us(u32 exp, u32 delay_us)
> >  {
> > +=09exp =3D min_t(u32, exp, ENA_MAX_BACKOFF_DELAY_EXP);

This shouldn't need to be a min_t()

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


