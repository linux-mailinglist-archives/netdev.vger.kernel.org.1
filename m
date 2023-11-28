Return-Path: <netdev+bounces-51638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 209F17FB8AF
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 11:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE92D282BAE
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 10:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6BB4643C;
	Tue, 28 Nov 2023 10:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="W09VQd8A"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDC0189
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 02:56:28 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 3AS9mTpA022690
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 02:56:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=Abobp1CGthKTOizWSt1MtaOyTTNdb33JSjXBEoWM0sM=;
 b=W09VQd8ACFg06/2yGoJD0AWzNwAyQmdNSm6ql5x5tI+o22WoAZXH7R9GPhz4UQblYO9a
 HxoZr3TyAnB31D1kjstdzm0AA/qydxoioCdiHTj4dvZ2zK+BWRhpRydHr1lz+UmwRgYw
 UjUmj9FSX7GdiAadnU3qH+R1/oNufVlvaoB1ZDGyxds10A07GXB8Ogy8frkpHjXbFdl6
 MmyRBXdBkJvR3fIcGpphFMEtYMvZk40MMZWVT3eR49o1hYfnoxPEczBmNJCBHBA1uEbx
 1os7ZZDOdJY+IjlAZL3Hwkw0ONZH6KMh+V9NS0O6mBKEHsVx7oLdEEXidjtDtzwIHoFB Ig== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by m0001303.ppops.net (PPS) with ESMTPS id 3un1wm43yt-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 02:56:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1fkAQCkYVaeCRdTZNDIWAejcF4T3FUvyY6rN1faReAJ/f7zyMgIGbpiXjwnn/9q/4WdWIR8EeGyOoxUcLA8FBeAQwf3MFvc+liWVXh/6Kcc2bTQx4e6CYgUtPOiqptTJx2iY3YkaC2yevZ19mQhqGRA2/pnMMpr4mhixs3AeFkAM/22RVNRDHn2NBatk44Q43emQz9ZmBh1I2NHBAo5oqG+scwMLmZyGgtzFv1wwf/LyfZ6p671jd9/3IlxYbjEIjh/PhiQUrP5ey3HrEu+Kq9YPnbVG7x5GKYADzorPI/FdBFDSANAp9TBBtr8l4c6j+KWhJ/RpLRbMENCd/p49A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2fMoXkL+XjWaPYtGBsgn05DC4Fk8Oz5Ly9DdUlno1gU=;
 b=Se0TzAgOPnpn/wE4i1yEvBAxw/VExdoTli+QK9A/UkD4nzxvrcO+CDPnMsmW05bOf+qhVNUiurftblRxCFS0ugIm7jAXYiTM1++MUKDf5g2ewzuIVymsFKvm8bbLq88306+ujQYJS7y2fIXv3RjHD4iOslCdqv2dsddorxgIbg+OFvY3k3Jch1ikvYP9ioellGnFLu3YIOodCv68YHVCbyWV/VJyqmzdpGVxkD+6dQrFOM+2HZY0drvktyQ0kupDU94kSAvpotELWVHbYg6+KXieBDCavMb6Iz0L0WClS8XMt9KJaNuosvtmQImwBh6lqWduGpP4ManhzUTeACYqHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5187.namprd15.prod.outlook.com (2603:10b6:806:237::10)
 by PH7PR15MB5740.namprd15.prod.outlook.com (2603:10b6:510:269::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.21; Tue, 28 Nov
 2023 10:56:24 +0000
Received: from SA1PR15MB5187.namprd15.prod.outlook.com
 ([fe80::8e8:f2f9:bb50:328a]) by SA1PR15MB5187.namprd15.prod.outlook.com
 ([fe80::8e8:f2f9:bb50:328a%7]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 10:56:24 +0000
From: Neil Spring <ntspring@meta.com>
To: Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
        Neal
 Cardwell <ncardwell@google.com>, Wei Wang <weiwan@google.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "David S. Miller"
	<davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>,
        David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH net] tcp: fix mid stream window clamp.
Thread-Topic: [PATCH net] tcp: fix mid stream window clamp.
Thread-Index: 
 AQHaHiFAQHaNVihllUWpFda+BDhZWLCII7IAgAASUgCAAAwXy4AA2GcAgAWKzqaAANDXAIAAEKY5
Date: Tue, 28 Nov 2023 10:56:24 +0000
Message-ID: 
 <SA1PR15MB5187A4D321D44A7EB4CBD195A3BCA@SA1PR15MB5187.namprd15.prod.outlook.com>
References: 
 <fab4d0949126683a3b6b4e04a9ec088cf9bfdbb1.1700751622.git.pabeni@redhat.com>
	 <CANn89iJMVCGegZW2JGtfvGJVq1DZsM7dUEOJxfcvWurLSZGvTQ@mail.gmail.com>
	 <ebb26a4a8a80292423c8cfc965c7b16e2aa4e201.camel@redhat.com>
	 <SA1PR15MB5187F56AEFC6B6A581E056C5A3B9A@SA1PR15MB5187.namprd15.prod.outlook.com>
	 <3f549b4f1402ea17d56c292d3a1f85be3e2b7d89.camel@redhat.com>
	 <SA1PR15MB51870B8E934E9132044CE58DA3BDA@SA1PR15MB5187.namprd15.prod.outlook.com>
 <829107c3e007af0b0e040748f39873d838785dce.camel@redhat.com>
In-Reply-To: <829107c3e007af0b0e040748f39873d838785dce.camel@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5187:EE_|PH7PR15MB5740:EE_
x-ms-office365-filtering-correlation-id: 5222b259-4e9b-46db-852c-08dbf000a9de
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 nVWy0KhJCXrQgOXYRBENN4Y38EjDfzTfHBl+TdoACYG3jVQrGRrw0JHw7xcdh0yGCdwT/MeaGnDEBz5BoaRC3YEa3+oXwOHMjZ2hl8GCzkMOZkp661huRhQT8C7CU0aRYu+1kmk2tq7zV0tXvR1/0Gx6Jf/Wwq+erCaEWgOMNX8yUfHnwXTOHhij6PinFIf2SkQ8GC6MA0vqYgD08NYXlVneshmSV9Dm5+eecgwHYXWE0sxc1ShH8XCv4bOkM+5gplUrSzkGkriQaygGZx8tsYYOdTmzfgMAqZvsY59ZgpM7GCcXXgGcJUJtcMRVP6ji4GEvL+RYcdrz3jB0Vkm0O18m3gIUtBmhlhOXyun3bRG8/fWB5kCcOfko9Zt+eI7d61jqfjFp5T02XOdKadA2TCnmZAkf493UhESlrZgjUi+zuHai5ZLBEPdJ667/eamUqvXIOYiot7ziGV3MzWHTQEt3WnpioEZaCrmhIRxTgn5oTz3yPwVcGuWeyPJSqJLNEcyJV8eANrkVUwW2i5D/NcSoCfqw5y2m43e30+zH7JID1vxxXPFUN218fhhdQvv2OSszyUWrICT6V4ahaOiUt4IX+gLWESdOwdy/YnAhwkUAQvUFWmb70H0yRQOjgtSxW44a/+o9r4XgFav0ik6UAg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5187.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(376002)(346002)(366004)(230273577357003)(230922051799003)(230173577357003)(64100799003)(451199024)(186009)(1800799012)(38100700002)(33656002)(38070700009)(122000001)(86362001)(41300700001)(66946007)(66556008)(316002)(66446008)(54906003)(8936002)(64756008)(66476007)(91956017)(76116006)(9686003)(110136005)(55016003)(53546011)(966005)(71200400001)(7696005)(6506007)(478600001)(8676002)(5660300002)(4001150100001)(2906002)(4326008)(52536014)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?vOnahO2x/tlY+/NXqZxnYQSHvk0LI78Ych754+4WI1XLYCLKHHfZNEaEN2?=
 =?iso-8859-1?Q?kvktWWK2VOEOYPPxCtFFjs6hLvZCcdwQirht3+a3TrX+/5fZbWX4pTHSv2?=
 =?iso-8859-1?Q?FT51VRTkhlqJ3gU/QNZQnjH9b4WqBTaWVfzNoXPz27JjbEZL/4OqNOmev6?=
 =?iso-8859-1?Q?g5gUJ0PnLmPmp0ZGb4GYPVBX9A1D4Ay94wSxnA4tmpU787JAR3J0fGcLXz?=
 =?iso-8859-1?Q?kog+dGB+gcxridrRL9+VgGYitTM7wtGVWtmpWb+ubRcnTW7w4FeuxASnWd?=
 =?iso-8859-1?Q?AeZOcSQfL2re92Ycg5k3TH9qgacfzvn4E68auE5+21wA8/nWYHmLH+Lq/9?=
 =?iso-8859-1?Q?nrC7A5JOOxQwhqegVWAY8jG+IwvQBw5R4dB9wuMI3c6Ak4s/DWQ9Fg9Olj?=
 =?iso-8859-1?Q?UrYSc3Q2EmdRR5WU8f4SmerAJFqt1dg/6Z2F/slD4jjNkwCm6BTJFAcxTA?=
 =?iso-8859-1?Q?LKD2uEM/H+ZY1uA3x1rMs9w6GT18eDMKMwyJgglHUnny7/mms7AlvJAmEU?=
 =?iso-8859-1?Q?hI/wHZ4MsHInzCvHy7KbUVFBxOzBP++OTmxzw69fb7cJf4oIlkshBSIPan?=
 =?iso-8859-1?Q?oPY95aKAEJi+ybfXPjKpHx13+LirFliBomTCWE88vxQmJxt2KH4eYmMORV?=
 =?iso-8859-1?Q?5u+zTqxSBgKzNLWjWIL0MSH0z7znexppowyWnof3nfnO3Rss9ghp9A3Qpw?=
 =?iso-8859-1?Q?vSWPa8Fp+BDLX9ChicNikfquSbHBI9n5QbE9dV/mh39VI0o34aF2B69/Yf?=
 =?iso-8859-1?Q?zu4iWESzAJndwndfvq0iuGA7Kxm8eGKQI7f32XO/VdiLw3xo/QT6wo+mdB?=
 =?iso-8859-1?Q?mHwERElhEXxTDscf29yZkACUhSLjMcZp9rZvA0E142NU7zFcFA/hA0qLdu?=
 =?iso-8859-1?Q?XkA4QoriH4pExJp6g5Aetu/NV8yorxRirxc3g1UScIRjuGb9gTfgucPNn6?=
 =?iso-8859-1?Q?CAfim3GaRH8sLj3NNtmphHD+EpQXPZXpbyOza0+xETMG0wVxWTZMuQVfJM?=
 =?iso-8859-1?Q?C3ZV4dS/50MvOhkHgQViqFBHH99rVau497XVe+oE8YgC+3CIrMZqt4+bhd?=
 =?iso-8859-1?Q?Myx2SgxALzC1afTqBrixdRM17N1citgaFnCeT/6gOyze2gueSiRmL5nTmr?=
 =?iso-8859-1?Q?iuxbuSgOrsGIbLfWV2ewSBtm+8/wHZPQuv0vYjuYG5K3RP6PwB4bg02IAs?=
 =?iso-8859-1?Q?C6++nQxmY328ayMgDEMjxRKxqQiivkbYjPmeQYWMWdLNMWxuuOtLrIoi1A?=
 =?iso-8859-1?Q?0JtVbGOXzdinACKczYU9ShlDCloUC7NM8psZHuzbJkOv2cZp8gmwdg25NF?=
 =?iso-8859-1?Q?lzjRWW4+IRTeADqX8scYMOBs6C0xEzl0mvuMM9+40sj6BBPpnCvyj/ySvJ?=
 =?iso-8859-1?Q?DZ7GGhXlP4YS8Awp7aBuuf9XNApRq8ehKlxoNapvGBk7mNX1K9UO6ukyL7?=
 =?iso-8859-1?Q?6DBuK7llOx6/reUeEkm5yLVjbmLpp9eW1asn4EDJ7wIuk0Nt4eYBjS2rYE?=
 =?iso-8859-1?Q?iGl1CeV1w+0v9CFBJxW5v+i0kiCA7CsDEqP0VlxN2zbcxc3rjiEpjumrqR?=
 =?iso-8859-1?Q?+B0iSSfOslK6VsOwCWHHwKUKVlvpJ+S47pAMcUH+RSVqV2AnZ7YzZqALAN?=
 =?iso-8859-1?Q?mNzC9QjJMWhZVZhGrooTCgmx9gM0H2YjLMS+nykfXweebY1sPMqyAAVQ?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5187.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5222b259-4e9b-46db-852c-08dbf000a9de
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2023 10:56:24.3512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QL5ZTL/P5UftCjN3H9kTQ42kekbpd6NSuxa8Me11/DfW/s32qMS1NXS9Gnfr3qRQQDbKyiTDm+ob0ldH1wC2Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB5740
X-Proofpoint-GUID: vU6cQlMBH_PYY30EZEc8QCJgpIyp6-DP
X-Proofpoint-ORIG-GUID: vU6cQlMBH_PYY30EZEc8QCJgpIyp6-DP
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_10,2023-11-27_01,2023-05-22_02

>=20
>=20
> ________________________________________
> From: Paolo Abeni <pabeni@redhat.com>
> Sent: Tuesday, November 28, 2023 12:59 AM
> To: Neil Spring; Eric Dumazet; Neal Cardwell; Wei Wang
> Cc: netdev@vger.kernel.org; David S. Miller; David Ahern; Jakub Kicinski;=
 David Gibson
> Subject: Re: [PATCH net] tcp: fix mid stream window clamp.
>=20
> !-------------------------------------------------------------------|
>   This Message Is From an External Sender
>=20
> |-------------------------------------------------------------------!
>=20
> On Mon, 2023-11-27 at 22:59 +0000, Neil Spring wrote:
> >
> > Would the following address the concern?
> >
> > tp->rcv_ssthresh =3D min(max(tp->rcv_ssthresh, tp->rcv_wnd), tp-
> > >window_clamp);
> >
> > (that is, rcv_sshthresh must be no greater than window_clamp, but
> > otherwise it can keep the larger of its current value or the last
> > advertised window.)
> >
> > I believe this addresses both problem cases (transient tiny clamp;
> > closed window when clamping) and passes (slightly less picky)
> > packetdrill tests.
>=20
> Note that the above is basically the patch I submitted (it yields the
> same values).

Yes!=20

>=20
> Yes, it addresses the issue.
>=20
> But it does not address Eric's concerns reported in this thread.
>=20
> It's unclear to me if the more involved approach proposed here:
>=20
> https://lore.kernel.org/netdev/ebb26a4a8a80292423c8cfc965c7b16e2aa4e201.c=
amel@redhat.com/
>=20
> would be ok?

My understanding of the documentation of TCP_WINDOW_CLAMP is: "Bound the si=
ze of the advertised window to this value. The kernel imposes a minimum siz=
e of SOCK_MIN_RCVBUF/2."   So in my opinion, increasing this value above th=
e application-requested clamp to at least the unused reserved buffer space =
adds complexity and is not correct.  I suspect the result is also not predi=
ctable, since it depends on whether the application has consumed the buffer=
.=20=20

The clamp and allocated buffer space weren't tied like this before - I coul=
d set SO_RCVBUF large and TCP_WINDOW_CLAMP small, perhaps slowing the netwo=
rk transfer to match a slow receiving application, and expect the clamp to =
do as I asked - so I don't quite see what's new here.

I guess Eric has a different perspective and I should let you figure out wh=
at's best for the interaction with reserved memory.

Thanks again for fixing this.=20

-neil

>=20
> Thanks!
>=20
> Paolo
>=20
>=20

