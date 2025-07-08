Return-Path: <netdev+bounces-205023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8E3AFCE3E
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 16:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9258216427A
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 14:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A83220F59;
	Tue,  8 Jul 2025 14:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QxJ/Vm6v"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E010E226D0A;
	Tue,  8 Jul 2025 14:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751986349; cv=fail; b=Oart4XJocKrg44AISj7gFZnaeEx06xpu7FedOtQ5E7FgKGmiDZxu1+6GIPNoH2FnFy0UehbwmyOJIZBbaXWSYyY3/47EYuz84IX5mO64xEKwmcnXypKtI6CYkJ+9/hRUIGT7i1ZAs5hwtxDZ3R+naLLwBdZXnh1ZnnDNDreBcn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751986349; c=relaxed/simple;
	bh=34IF7P6zn0r0gn07NKwbxTI1FGYDz0ubbMS0PCfMlg4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SXqUrj/oRrEmpkRMCkMxezLSRmW8FOzLoV+HMkRR0gYS3xg9fpizuAbbla3E1dpo1zpnowSypbDfLYD/Nak2RHae4Na0Ej4BNID+b66xvi7gaDP7OLYLpCFkINHIGtShowNd2zIc+/w/cN6mIfxWOiSOZ3epYGndcIEAnqJa5H0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QxJ/Vm6v; arc=fail smtp.client-ip=40.107.237.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p2AEndhV0dOlSEc7p4aENh2fvAqOC/4M+94WAQTWRW5o/AkKwQLoTNpUx6Vb8hYbl5flWo6msXuk0H6u2CfcjMrsUD0NU6No7oHCcgOnylm3OPezjnFPter/nYJH9IK2Lycxvp/vvIEzsnfK2yjunb4F6i0sR2f+VjOihZ1bg6V/Adlalz0OfWCQfz2lAEsMG1raIJL+MvwXpo0T75rc8QNoEmvWaIU0xYqnXLkyp/U6VEklUMlbPy+C7bQEk/XGDcGcw6SRK0jR40+SWw6/Vx67ehX7ys0xTE1donImMzcLDpS0PN4BHuZCl7dzVBLu0+mTEBsIU7ikgUkTMM5/0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3HExSqWpF8pkiFCpzZt2X4jpM5HYGB5HsxLMd1GodB4=;
 b=W2afUxhsgjRjoutvA4GKuptZoBK+5QYsTA0whFKcl/+OrruWd4laSOT9zAs/irUm5vwavOo9ud8occ0lz+djJFHziFixGO/Xkgq4E4QFDMXw9BD5k4FQ1iLxAK/6/yqx+A1ti0DGoDsyBiieJlMnPQ4NypDJrbo+bvt/Zwr6G0pxNaaBJIUH6KnaNLGRZVmmm+4r5ngnCdE1aeMUMgdMx2pcuCx2NYr0/EjQij+51u6j7bEmEnmlBjMtdJWAxw7RxU2rS5AH+yjZ8lYfRL1kR2gGN/uo55ndnev14QkajKp3DX+A5CFQemJTUiqnVfazCnCSFzu0Zf0Op1oSxLclPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3HExSqWpF8pkiFCpzZt2X4jpM5HYGB5HsxLMd1GodB4=;
 b=QxJ/Vm6v5HdmG8jwEBTAVIZSddPMU0TztegoB31sHSoFkkFUD9D+y61K0NCcWR0STV0/Oj169HZ/e+tdAAUjXSqkP3O54/GZw6GldITzMHGchXaluIpgh4vmy4p5RRznPzI/4czPhL+z2X4Kckfz+6qYKf1+r5/3pa8YUGvsdMwTnenhPcrUSa/D+FoqQQw/v+E9WtL+YWvmyUQL5Jhz5tTQ48+Ox2PFtr90G1AhFyaW9Gu8vEir/ct38YCDzJMfw87xH8SrO4urIUmSvy2bIDqyYwCSLHSLBb8cCauj4B4cXDCWmz7SDuVwUxRaflfVXLbZlbaLcVr8LOqfxQQh7A==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by DS0PR12MB7510.namprd12.prod.outlook.com (2603:10b6:8:132::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 8 Jul
 2025 14:52:24 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8%4]) with mapi id 15.20.8880.029; Tue, 8 Jul 2025
 14:52:23 +0000
From: Parav Pandit <parav@nvidia.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?iso-8859-1?Q?Eugenio_P=E9rez?=
	<eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Minggang(Gavin) Li"
	<gavinl@nvidia.com>, Gavi Teitz <gavi@nvidia.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net v2] virtio-net: fix received length check in big
 packets
Thread-Topic: [PATCH net v2] virtio-net: fix received length check in big
 packets
Thread-Index: AQHb8BaFBu1w02sktE+ob1pW2b3NzrQoTvtQ
Date: Tue, 8 Jul 2025 14:52:22 +0000
Message-ID:
 <CY8PR12MB7195AC4C23690D748ABAD675DC4EA@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250708144206.95091-1-minhquangbui99@gmail.com>
In-Reply-To: <20250708144206.95091-1-minhquangbui99@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|DS0PR12MB7510:EE_
x-ms-office365-filtering-correlation-id: c7ffd53a-48bf-49a2-e07c-08ddbe2f0bfa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?DdMQRmLPh/pACXmUmuCAWADZdaJEsYP1Si+XRH59gB5MbLSbL0cBcxabtk?=
 =?iso-8859-1?Q?w/IpEI9gRIRILHgw5oRFo+LiePPqiGyFT2jzPOXDe5yR++OJqQ6nLvSeWk?=
 =?iso-8859-1?Q?L/YgTCIZzvJCpMx8830ijOib4vIrVDRtFeObnxqVlcGMNjzwKcNE8ds9xJ?=
 =?iso-8859-1?Q?QVkEdlLNgyjAwljR2i+ieNgbFVN6Wwru/M5uPXUlKhtXvAFBrsd8eZOdEF?=
 =?iso-8859-1?Q?CQGsSolavlnBcC3wcG7KESjKUf6umvcg1eV67cjd8J2z3XVlJk+fS9Inn2?=
 =?iso-8859-1?Q?qOy0FSD6r6i9aoylvnP1dMSn/pXXH2kRgKk1wRqZktC4VodM5H/KYt7KKO?=
 =?iso-8859-1?Q?k42ir1gIIRS9PXEZ5OR5wGycasasP7zEyXBFan+QNm4LjYVAV7rimgW56b?=
 =?iso-8859-1?Q?8IcOp6K5EHE1en/0aCTHCPalfaFZOR6RiKzwTYHXjzvmuODhZq5IbxyKvK?=
 =?iso-8859-1?Q?2cCyBP0Bfzuw/r49lCbegNDDtRNFDCzeCfX6XoRUC8Nl0u0I1e9ZxLlm1w?=
 =?iso-8859-1?Q?EL3bk+mW1xtP+Y9k3tHb6j4N+r4ryaC9lbk+/+R6S9YN68awU0v1Xe4Y3W?=
 =?iso-8859-1?Q?TEcsyUAja8FyndWbPL84UvUf9zbjbPj0J7TdQrIE9PTgBVELoGbeGlj71o?=
 =?iso-8859-1?Q?V/ALIcOZb8xJWsjaZqoYr47WzG3PnK/T0Vzs1VUmXvmdhUTWbEPwegu8JN?=
 =?iso-8859-1?Q?AAxd2tSgs685B4RCiCtzn30EPfRSywWj5tw9tuxYDqXllLqGc2rTGqzoYW?=
 =?iso-8859-1?Q?daIEV9XVfr1R2d2ZvsKdCtC8poKhXnbdILRanoGMBge5bbol8MkF+bB9Zf?=
 =?iso-8859-1?Q?gW7Pk6GZooCCL7FTHy90LftyVOn/lN8I9qh3TsGaHoIfxVuaHtdY9q02OZ?=
 =?iso-8859-1?Q?rj3/pBchMb79pOweVNrGjcIx+dUoq0pLUyJA+BIu2iwZVYmFv6e09gMpxl?=
 =?iso-8859-1?Q?RI+WBjGOaFIwyaTSJwcNFeMxJOyRJIKuE2vDjmQ52424IZpSF7DcFmNGs5?=
 =?iso-8859-1?Q?8/U6NAHM5EjDC4pRMH36HfMd1Mw1nqXxSSNUA/TJpzn42OoqJMAbzsHPPv?=
 =?iso-8859-1?Q?z8p4iVKURNqb1QdENBBXLX3nNpje9lHCMJlUedMLIlHqrhq05dksFcbFjH?=
 =?iso-8859-1?Q?6CCK+x9IzHInHvO/Ie0Mzne+gRxZQHG+rPmYvVMtnKDzOXtrBY6dbSzcLm?=
 =?iso-8859-1?Q?WO4UepDWsZKpISZ3nORjZabC55qw/LfCyoYOiX0xdiSDDJp1d47eQ2YB8Q?=
 =?iso-8859-1?Q?JfSzd5F/4bIyPkkxHtf/xzb8tp/WKnhbxMsuh9G40dRBVD1H/qDKcFKA6G?=
 =?iso-8859-1?Q?MAdvxaF9ywGYOXJSDd5ipTg76QQXL8EQBCGCrzpO6Daf8rDd7vJzL+uZgf?=
 =?iso-8859-1?Q?n7x8BVmypdxp2ivGvAh6dSwHGYM9hMvvKeoJ0EeeLyDtXf2hRYBM5owLDx?=
 =?iso-8859-1?Q?nA/IUygDkvzX+XTVDTxoC2gRryo+a7u8Etpiql9t/MGTo8mwzaFBuMeFIS?=
 =?iso-8859-1?Q?ZSVCiTHZ8cjRBJj08GWwsN2xZFJI38nl1Wk2mrdE4Oqg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?lSvaavW+t11L9cEq9W0MPvdPnuUCkRlTrV8FaoT7Wyh+mCdQWhWDnOan1/?=
 =?iso-8859-1?Q?iEONxy8tsjLEzghJVFedXthsK2RPsnsKYol6pOcdOChKjTCiZuLA/qKMfq?=
 =?iso-8859-1?Q?nfeVNs1boD0MEPXgJKmfbfHdxo+DRU/Os83Y825w7St02ftvoLPUxSfg6H?=
 =?iso-8859-1?Q?40DBJOv9pAAYLRHODN1ooXq4XMP/u07re9KTBO14i8HpPUge1Dow3PXUXz?=
 =?iso-8859-1?Q?EhCPJ+42gLk0Wz7kBTDa+HZ/9OayACbLuyXOePiqVwn62M4ojk/UXVtTya?=
 =?iso-8859-1?Q?CcdpCPj0kCYmHmx2JE8yuVr3ndvx51faeciAk1ssgvv+Znyg6IAq5Ginp8?=
 =?iso-8859-1?Q?GhTlCQz2IduoTbiiVWrvCeo247RyvBbePaAjIZfWXlO8tp3Ln3oianCAVL?=
 =?iso-8859-1?Q?i5eBEwUjYM2MvaHdBVYv/f09GwUh14u9BZ+kytl4QPWnfAtmgOz9npMzSY?=
 =?iso-8859-1?Q?OV+czJ2vKDp0in4It47x7KGBd6GVRQ0tUJXoQmybyMT0lUxqf95OxwMfuP?=
 =?iso-8859-1?Q?jvO+lnm9DQZ/Ba1qNswzY7eiMHyzEaJtBVEADSsaGouNUz5WBeXKJlCpwr?=
 =?iso-8859-1?Q?92MDeWmsW+XDCvXt5wMxSV8FvKkYWHuAwmHl3skg7KwViFtFObcz10yJSn?=
 =?iso-8859-1?Q?fpmQAQ+NagRUMuEsJI6f9p5jCaCPdy8349yxiR1PmNXBw0Ps7lrMUCJ0FQ?=
 =?iso-8859-1?Q?XH39eNuyLwbUd5gjnXS5SAg2w1jHAfXuigRFjcsyhMbvG0/ajZWuU11xvn?=
 =?iso-8859-1?Q?L/7IUCAb6QQu7JLMP4zMSrkC3tl5gTOlxPqqYDb5gGQeyhRYgGqLSDCiVH?=
 =?iso-8859-1?Q?5xO4bzVz1MldddYoQ5lWWFzRNxSgo9GoO9OtPw9oIadEL/NG8p5lxyceyg?=
 =?iso-8859-1?Q?KQdwH8C95qVoNcJ3lioerxSfFt0JWoZrYVES2A+ZtBjh//bSFQ9iSFbEjk?=
 =?iso-8859-1?Q?qNrfJEfVjbkSulnp8cRB1fC9yl0oNoM9ZhWAmyNDB7rPFTxKugPqBtMqvr?=
 =?iso-8859-1?Q?Cs4zOTXWUtY6e07Ml7anEXcL7QjOTjTTO0NuP0kRz97evMOSZQDpprmyx5?=
 =?iso-8859-1?Q?a1/J5QRRImWWFlzoyFMeQldmH2/23OkDdODx5NKePACL1fJZWYOBYBDfJ4?=
 =?iso-8859-1?Q?Fj5jD+y8zLOhucnWreyQV5k9hr54+nsFASrztzRWecDg3SUWd1aRM0dDsz?=
 =?iso-8859-1?Q?hVIAycHF+c774dBlaUcKRnpA26KxcVZGSHloxuAVf/T6OSxCXv3vOUq9Sn?=
 =?iso-8859-1?Q?B268HSVpI6FxkrS3sDrUTNM25Z1i/fkJ6TO83Ab+CSk6EryYoxaEJbC9Xl?=
 =?iso-8859-1?Q?f2MSnKpsRXt6k4P07xH+Clhdzykca6XwdiPt2JOSAlM9dOFvDBbtGaM6GD?=
 =?iso-8859-1?Q?DQ+0UPRX+iRASR9NHizUKjh3FsDNEQfZTNWwHd/qX6lEoAvY0Qvc2O87UD?=
 =?iso-8859-1?Q?jcUwETXCbyIKhqQpEDsfhUGX5+k1rG/bsmi+soJjbMmm7ga91DIJtbgvwf?=
 =?iso-8859-1?Q?Wzs/O0W/sjta9epMTHFwM81SN+BGl8p5inuD4kgmPi/tBMRte5FZFVsEC6?=
 =?iso-8859-1?Q?k+m6mLyuhtJky3B+RNvPn89ZAujMjDmxXruG9tq+Eu2VXeOLqRP1h0/NCk?=
 =?iso-8859-1?Q?xmkVolHKbih8g=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7195.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7ffd53a-48bf-49a2-e07c-08ddbe2f0bfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2025 14:52:22.9620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FZVr33YAW51yrkheAMOHLNw410ValVF7qwZ7dVyMZK6zeEKYlFcCNYpPTaWf7+2milO8GOuihtOj7iemlGTQiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7510


> From: Bui Quang Minh <minhquangbui99@gmail.com>
> Sent: 08 July 2025 08:12 PM
>=20
> Since commit 4959aebba8c0 ("virtio-net: use mtu size as buffer length for=
 big
> packets"), the allocated size for big packets is not MAX_SKB_FRAGS *
> PAGE_SIZE anymore but depends on negotiated MTU. The number of
> allocated frags for big packets is stored in
> vi->big_packets_num_skbfrags. This commit fixes the received length
> check corresponding to that change. The current incorrect check can lead =
to
> NULL page pointer dereference in the below while loop when erroneous
> length is received.
Do you mean a device has copied X bytes in receive buffer but device report=
s X+Y bytes in the ring?

>=20
> Fixes: 4959aebba8c0 ("virtio-net: use mtu size as buffer length for big
> packets")
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
> Changes in v2:
> - Remove incorrect give_pages call
> ---
>  drivers/net/virtio_net.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c index
> 5d674eb9a0f2..3a7f435c95ae 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -823,7 +823,7 @@ static struct sk_buff *page_to_skb(struct virtnet_inf=
o
> *vi,  {
>  	struct sk_buff *skb;
>  	struct virtio_net_common_hdr *hdr;
> -	unsigned int copy, hdr_len, hdr_padded_len;
> +	unsigned int copy, hdr_len, hdr_padded_len, max_remaining_len;
>  	struct page *page_to_free =3D NULL;
>  	int tailroom, shinfo_size;
>  	char *p, *hdr_p, *buf;
> @@ -887,12 +887,15 @@ static struct sk_buff *page_to_skb(struct
> virtnet_info *vi,
>  	 * tries to receive more than is possible. This is usually
>  	 * the case of a broken device.
>  	 */
> -	if (unlikely(len > MAX_SKB_FRAGS * PAGE_SIZE)) {
> +	BUG_ON(offset >=3D PAGE_SIZE);
> +	max_remaining_len =3D (unsigned int)PAGE_SIZE - offset;
> +	max_remaining_len +=3D vi->big_packets_num_skbfrags * PAGE_SIZE;
> +	if (unlikely(len > max_remaining_len)) {
>  		net_dbg_ratelimited("%s: too much data\n", skb->dev-
> >name);
>  		dev_kfree_skb(skb);
>  		return NULL;
>  	}
> -	BUG_ON(offset >=3D PAGE_SIZE);
> +
>  	while (len) {
>  		unsigned int frag_size =3D min((unsigned)PAGE_SIZE - offset,
> len);
>  		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page, offset,
> --
> 2.43.0


