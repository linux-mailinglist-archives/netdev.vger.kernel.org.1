Return-Path: <netdev+bounces-189397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 770A7AB1FD7
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 00:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF8EB178F65
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 22:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708F8242D61;
	Fri,  9 May 2025 22:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ufv86kez"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D7623A57F;
	Fri,  9 May 2025 22:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746829104; cv=fail; b=E7iEHv5YLXIWuO0/YoCz+GjgZYe7vPvFoAtoEEqP67yQeoS/5lhhCh4Dc6Vj3zgCpBynAIdPiXKrVoYGVwGdD7Kd1uR9RDZZwucC6gP7LNi1XJd+N5dzm61uk9v2NlL6ntkT+7EoKysY3InuAUV/vkQbzWkdl6eSoeT85eInBwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746829104; c=relaxed/simple;
	bh=XxLv8xWz5JrL2d8sbfvsbMBLXapr+qIlQWkboFapjG4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sDMXif3+sijjDKy+VRZoIpD15dTrIEYB3cte8AcB2EoQxH7hFVavZ6EaBAKaVa30OBVVYe8RL4uflFuhNIEnxBgBzA0ZK2GWALhzUiGsIZe/evN8lx5K1VeQiyM61CrH/I/A2LRDKNnkptOmOc/gnCQflimv40/Be42USVEgDd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ufv86kez; arc=fail smtp.client-ip=40.107.92.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QAaABdQOrxDbxYbbimNl2OGbjxmseQ82DVFxEz9W/kgg229ZYznVkeEKY8vdDXyeETY8a9oJaVEzOxd6GbAc7g9WGG5PC/5dVibLFt3O5P/cAaNZa0CBH7SabXQmx9LHJ12O1Gct526d8vFc4BHUGIADOu4nqzN1mYSWOyuJrdMlgqSEKtHTs9CcEM/+dAIRT/ZcUiw8id1/i1zAVHurLghmFT5Eg/6UKjDji4AlwaTcCaUIg/5OyLSi1LZYsit9b8JHzoOriRCZtczM5z47dNjCozZMgBgkckwG4eYTXlDLVeeA76/C3I1JzOtNw61jNWgbZv7RuWhyIRNV+Fwo0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJ3+lG+T/28nrK4tyYLeYmP9HihAJyFSAojF7UP35qE=;
 b=obZznFku6NCeE60thYUWaQ9Yu0NLdwDLI4rosQPT4V5uzR/b0WQDxdkei3iTTJ4a0YhGdjgxbswLc5nSebNl5mntO+4KmkZl5lt9CycxX4+u3qUdkAT3ESt1Ql9zxmltoH2zNEUxmW4C3mS9FGwXsoGC19Vyz4wtubor58oVJ3W1IkDZFzJKSx5E5gu2eD+uOEKqVZjHD9BXtGoO2LLhZbxiM9UkUKx9gyf/9UaaWUW8S2tkkMfs86ugx4WymwIvuL5TnloN181Ka+e5Kzrq8ETq33gX6ly+qK2oxb9broJTtTLtIXklboP6DDFqBaPgaCsn7j2qOiYE0F2xTEErlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJ3+lG+T/28nrK4tyYLeYmP9HihAJyFSAojF7UP35qE=;
 b=ufv86kezaCrU9MMuall3s9NwRxpi/MhPWD1yk7JJIDHikC+COiV8umxPWGemtinQqgHNZKXy59NvKy3EtD1ED0wuh/+ly5V94PAn2AWOPBQGQW6ZUMENsuuDxD11ZMEVzU0VGtMdBnu556zWHLvW3vojEqe9bsrMZbDeD2Xhd/VKAZUMXuBbBbPKGoCBdpPxv6+FuCeqpEclrZLsrJxxq3JdaRTpdXc2//OTJwZkPUUEdQDRN8MO4sP/d5PXCN80cxKUc2eIs/xI084ptInO0R2dxldhzWtY4VLDebURL0X/iIRMZ/zwS2q4+uB89qr52VDM9gWq4BcERdwBImFx2g==
Received: from DM3PR11MB8736.namprd11.prod.outlook.com (2603:10b6:0:47::9) by
 CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.21; Fri, 9 May 2025 22:18:18 +0000
Received: from DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0]) by DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0%7]) with mapi id 15.20.8699.024; Fri, 9 May 2025
 22:18:17 +0000
From: <Tristram.Ha@microchip.com>
To: <jakobunt@gmail.com>
CC: <quentin.schulz@cherry.de>, <jakob.unterwurzacher@cherry.de>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Woojung.Huh@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>
Subject: RE: [PATCH] net: dsa: microchip: linearize skb for tail-tagging
 switches
Thread-Topic: [PATCH] net: dsa: microchip: linearize skb for tail-tagging
 switches
Thread-Index: AQHbwLKjSVEChZvy1U6ShYH9qCnFdrPK3WQg
Date: Fri, 9 May 2025 22:18:17 +0000
Message-ID:
 <DM3PR11MB8736CCEC9ADD424FEE973E1DEC8AA@DM3PR11MB8736.namprd11.prod.outlook.com>
References: <20250509071820.4100022-1-jakob.unterwurzacher@cherry.de>
In-Reply-To: <20250509071820.4100022-1-jakob.unterwurzacher@cherry.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR11MB8736:EE_|CY5PR11MB6392:EE_
x-ms-office365-filtering-correlation-id: 546d65f1-f1d6-40d2-eb8f-08dd8f47664d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?6BO4Ah1Pi9YGXiVkHcQMc6YUJ77+8uJ9nVFtDOf7ztubqsBjVNZP0PQ+Vfwg?=
 =?us-ascii?Q?aRyp7RLD/89t0rkj7+eWCaIc/dYUOzdCK+O3bJZZecxmDvVwZ3370o2hw4oY?=
 =?us-ascii?Q?8pCT2hufDN/yWpfFC/I/NT5C7PCrtOqjVMaCJ3kJo8NVJq3y43jfkMDZJoDr?=
 =?us-ascii?Q?bxx1hDvZ/E5x3Pz0vFSp8CbWuktAnKBo81W30SPWQyCviz1Ql0RA3CTWjj6S?=
 =?us-ascii?Q?qe2sW6en7nwqUk2DLtkkFGiQGekNuuj5zAfYkC1qeiBmNuhpF2w4cL8En7JC?=
 =?us-ascii?Q?ezaaoHW95Kyp7TUNq0bBKLWWhLRDsomVSjuS6vGe1slZrAqH7opur9J8d1Oh?=
 =?us-ascii?Q?WusNYPywryVAHyCb0zZktkjWH459ZUSQLuOpCttvVrrZR5YGa94lXCOtrK8r?=
 =?us-ascii?Q?BzePvtD+V1ARPrbBLBPrLxwZfUcWIx8P3cHoMvzr+wg1Vn+tTLKU03B8ki8v?=
 =?us-ascii?Q?NFotlRonByfjVlSk4nEyZLh9ypsKOGtmLIp2Q4hiIhFZYoUhet/jDaYb+ZJX?=
 =?us-ascii?Q?pr9xYnDm3VMBKDtnkBPlEOCNm+Dkk2uUVq6h4QydPzD5THD2IaTS25ATJFvC?=
 =?us-ascii?Q?uywkl+G7uuoXc6Tn7qV12U/nRy+jMi+lfFk4mLEH++WzOlbtKwaRHNqlz28H?=
 =?us-ascii?Q?rx0ym24h6Qe0HuBpOM7DIwM8cZSkckYved10KDQNtJVc00eRswRTzg1CVsve?=
 =?us-ascii?Q?S/Ljp3qXpBzbAjNMN0VVkYXHVNDoMGKKtvOn+Xx7iitJ8KdYvMUTVGA2qum/?=
 =?us-ascii?Q?R3ebDuuwPpnKJcyJTaZ4h7JDcnzNjg0Rc4V+beSbnX1I9j6+PsoJpM7hTSIl?=
 =?us-ascii?Q?/zpvC7Cu2a4pZ3NYxP2sBvXlgJ9QpHIaDFJOnm+Xxglt3BZKBRv9lE6qqtNL?=
 =?us-ascii?Q?66Qv9zNiQ4839yhHNyScrP16OWU9fIdazwr/nj6Hr7j00+gmAdu2r4VuCk1c?=
 =?us-ascii?Q?SGvPw5LfPob7SHERCSJCAb6C/XMnPQmIjJX+EdUGnBLzqJaTN1AjMSHL4hvv?=
 =?us-ascii?Q?DuSuBalcecucxi7Z2SFIQdxrBEeREMQ/gsq5nOX7/V+sVA1i02rF+vXxZbbM?=
 =?us-ascii?Q?aeTjtixlEg0Q1ULMWNIrZoresQ7En7Y9eCdcUGsMJZKURnn+6Pa6cprDAN+H?=
 =?us-ascii?Q?kMYuOEUdR3DkeKAiJYaSwZZba9sjKMdzqumWIKL4hlE7O888NhF9PwzoeSCd?=
 =?us-ascii?Q?s7OZpizv4XTckoppanfW8g1m9v+ovPd5or+OeWBPokzEHFJPMYL1IQ51XpTJ?=
 =?us-ascii?Q?PtSl7queWJbVd6yKbaIzMZlBeRmorhJyxMpydH6fLBG2Hhq01eBamzofJczN?=
 =?us-ascii?Q?GhA9wVhFgQ8ZiyqnULd8n1XEqnbx4PGfdDkKqBoIaKywnIayutw0sNkqa6mM?=
 =?us-ascii?Q?e2344MFiPj5pAM2t8ztvVQPkW1JbOJdnaNVd/5IrnS9e4D8iqS1ZDrW9kOqr?=
 =?us-ascii?Q?OTCLTP6vGyoD6zLwYPbLRKlwBz+kIsvgUW9p81quubwSw1Y4gYicZA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Ya5w/U44qaCkCrNEC15U2LRanzT7hP+hzrQ+ghiGAB35E24IGS3zm29nTAGd?=
 =?us-ascii?Q?wssGJQeChZUhAs05ldjzoJ2AM9ZFfvJcWF0AplzEWNLewVGJe8RApQrYNVbM?=
 =?us-ascii?Q?2BKUZnQ74Lvc+Jeh/HGdrGPg7L3lHurI1XgBUrHjLVbjZQYtievhwg9pkhuQ?=
 =?us-ascii?Q?AubVLHumGbijpoFfWJHjxDrwyMLVcj62L4WcDvVE4PXTKNWig1pqyVPBaRK7?=
 =?us-ascii?Q?XBz5hg47CfbA7vVtXEaU2HJKX59OdK5wEZtsaCYaFIz+r8prcdFZw7ius9XS?=
 =?us-ascii?Q?gx3ofkU0VtgkuhYdrnsSl2e6paLaHk9In/EdlpU2fBQBxODkRRK4mIazuian?=
 =?us-ascii?Q?a3UAdUD4lIHYv1VRWlS7biupsNM9nXIfYOrg96ygPFZ0JjQ8UbdfuQ0vtcFI?=
 =?us-ascii?Q?fuw+reXIh9Sl2Zni/c0dUlYzG63uvKtTQgBGCWqzdGtZazzGV3wXL+EEwFV1?=
 =?us-ascii?Q?2jMAXdqmOHKIFekAW0tvCzrnDwyC5VOra5rmUpTrYNUZUfamYIkJujzRdD7X?=
 =?us-ascii?Q?t+PvyySJiBu25PgoXRcVw/PzIq6UfGEujM1fhppvCPjBL2PkT+31gelpEjlt?=
 =?us-ascii?Q?cP6+1wNT7LibGvODwTF5W4nPi9VkzuD0YHzdxVi+bVYrexTZENNfj5Ku5bXT?=
 =?us-ascii?Q?Llz9C8cbxdUQeZiymDvXkBjYOYnnUpagPDbYStdQa3VL/Sq7w2DegyQpkIZE?=
 =?us-ascii?Q?+gYo9hhVrYSexe2QhDKD+QQ5fH5yyD9rtQUAE6arxWSFskj9iKTagaRm4v2o?=
 =?us-ascii?Q?namVfA23ORUKZip9GfQrGC7P5Om6AxeN+CB0iE9QZX23Qw2ok9CxJWVcfsG3?=
 =?us-ascii?Q?VehbSKCZttDB9HawzGL7aOFBzldZQ9yfTB6Ps+OWGsTP64z5+T+aqwXIM7e6?=
 =?us-ascii?Q?TK0MV7/U3gTFtjjbdMoG8HpqkYLWECkP06xBQ7gWYG0zTD+fJQnsxFRrmjQW?=
 =?us-ascii?Q?3aga5Jhl1QjVltWyMRWqDEFb6LIGYpYc4uTZTKUOue4pXb218Amj7FVjGFwS?=
 =?us-ascii?Q?4OC3WrjWRWKsvbEfxiWv3dW4CvAmtYl1syA0HumhFNxMShw6Uk99REY1e89t?=
 =?us-ascii?Q?bQworbpxd2kZci0fljWw8KIHNnv2eqi6UzmytGMQjaUM0s98xdia+IoEsczY?=
 =?us-ascii?Q?IvrQO0QH4XzhBRTZGKAwBkOQT9q/FZ7N2Ci2aZxqvJiw09x4x2TKk/Rdipa3?=
 =?us-ascii?Q?EV2087ZdK8RBQcJPH67oXvgWf+Azfh/oOmkSFHeGVcNK1Iwr3ujVSB1xqI8i?=
 =?us-ascii?Q?SjB9YXBhQZcnTfA32CRD1kEteWn34ai36ZXlKqLZexo7vDCMomI0EgFpfV8v?=
 =?us-ascii?Q?edEfB4cCy36Cq7giTs2JZkELHisHF9cOTsCDRUZGkIxBrVWf7TrZ5OUc57FK?=
 =?us-ascii?Q?Rmega4febdhYKBsdpY8h8B3HjWskW5liyyQMimwLDvGCx8A0xDVfF/M1nJmF?=
 =?us-ascii?Q?gwULngtQDtYgXLis17WqDD9XQLFwoN7S6KbcgKKv7Efe8v0MoQr8ICABPDPO?=
 =?us-ascii?Q?pPEV3sKUEe6FJa4HjvqP7PqwQMQ7gQLNMo5GXht4xrZAEMTmM4+ojVNwuhLu?=
 =?us-ascii?Q?iQOufFSZzBA+xErFlw8DCaLlavtgS9OTYdlRDR1o?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8736.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 546d65f1-f1d6-40d2-eb8f-08dd8f47664d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2025 22:18:17.8150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S0+sHTPW7VxFJkLj4HYlBmHrxOoKK4A44OmkobhxOHBy15fx6ns1So8sGCbUEwxS29YCAKb43Ur6mMvVCqWsTXsXEop7+VY3eu6aTBd+mYU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6392

> The pointer arithmentic for accessing the tail tag does not
> seem to handle nonlinear skbs.
>=20
> For nonlinear skbs, it reads uninitialized memory inside the
> skb headroom, essentially randomizing the tag, breaking user
> traffic.
>=20
> Example where ksz9477_rcv thinks that the packet from port 1 comes
> from port 6 (which does not exist for the ksz9896 that's in use),
> dropping the packet. Debug prints added by me (not included in
> this patch):
>=20
>         [  256.645337] ksz9477_rcv:323 tag0=3D6
>         [  256.645349] skb len=3D47 headroom=3D78 headlen=3D0 tailroom=3D=
0
>                        mac=3D(64,14) mac_len=3D14 net=3D(78,0) trans=3D78
>                        shinfo(txflags=3D0 nr_frags=3D1 gso(size=3D0 type=
=3D0 segs=3D0))
>                        csum(0x0 start=3D0 offset=3D0 ip_summed=3D0 comple=
te_sw=3D0 valid=3D0
> level=3D0)
>                        hash(0x0 sw=3D0 l4=3D0) proto=3D0x00f8 pkttype=3D1=
 iif=3D3
>                        priority=3D0x0 mark=3D0x0 alloc_cpu=3D0 vlan_all=
=3D0x0
>                        encapsulation=3D0 inner(proto=3D0x0000, mac=3D0, n=
et=3D0, trans=3D0)
>         [  256.645377] dev name=3Dend1 feat=3D0x0002e10200114bb3
>         [  256.645386] skb headroom: 00000000: 00 00 00 00 00 00 00 00 00=
 00 00 00 00
> 00 00 00
>         [  256.645395] skb headroom: 00000010: 00 00 00 00 00 00 00 00 00=
 00 00 00 00
> 00 00 00
>         [  256.645403] skb headroom: 00000020: 00 00 00 00 00 00 00 00 00=
 00 00 00 00
> 00 00 00
>         [  256.645411] skb headroom: 00000030: 00 00 00 00 00 00 00 00 00=
 00 00 00 00
> 00 00 00
>         [  256.645420] skb headroom: 00000040: ff ff ff ff ff ff 00 1c 19=
 f2 e2 db 08 06
>         [  256.645428] skb frag:     00000000: 00 01 08 00 06 04 00 01 00=
 1c 19 f2 e2 db
> 0a 02
>         [  256.645436] skb frag:     00000010: 00 83 00 00 00 00 00 00 0a=
 02 a0 2f 00 00
> 00 00
>         [  256.645444] skb frag:     00000020: 00 00 00 00 00 00 00 00 00=
 00 00 00 00 00
> 01
>         [  256.645452] ksz_common_rcv:92 dsa_conduit_find_user returned N=
ULL
>=20
> Call skb_linearize before trying to access the tag.
>=20
> This patch fixes ksz9477_rcv which is used by the ksz9896 I have at
> hand, and also applies the same fix to ksz8795_rcv which seems to have
> the same problem.
>=20
> Tested on v6.12.19 and today's master (d76bb1ebb5587f66b).
>=20
> Signed-off-by: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
> ---
>  net/dsa/tag_ksz.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>=20
> diff --git a/net/dsa/tag_ksz.c b/net/dsa/tag_ksz.c
> index c33d4bf17929..7fbcdb7f152a 100644
> --- a/net/dsa/tag_ksz.c
> +++ b/net/dsa/tag_ksz.c
> @@ -140,7 +140,12 @@ static struct sk_buff *ksz8795_xmit(struct sk_buff *=
skb,
> struct net_device *dev)
>=20
>  static struct sk_buff *ksz8795_rcv(struct sk_buff *skb, struct net_devic=
e *dev)
>  {
> -       u8 *tag =3D skb_tail_pointer(skb) - KSZ_EGRESS_TAG_LEN;
> +       u8 *tag;
> +
> +       if (skb_linearize(skb))
> +               return NULL;
> +
> +       tag =3D skb_tail_pointer(skb) - KSZ_EGRESS_TAG_LEN;
>=20
>         return ksz_common_rcv(skb, dev, tag[0] & KSZ8795_TAIL_TAG_EG_PORT=
_M,
>                               KSZ_EGRESS_TAG_LEN);
> @@ -311,8 +316,13 @@ static struct sk_buff *ksz9477_xmit(struct sk_buff *=
skb,
>=20
>  static struct sk_buff *ksz9477_rcv(struct sk_buff *skb, struct net_devic=
e *dev)
>  {
> +       u8 *tag;
> +
> +       if (skb_linearize(skb))
> +               return NULL;
> +
>         /* Tag decoding */
> -       u8 *tag =3D skb_tail_pointer(skb) - KSZ_EGRESS_TAG_LEN;
> +       tag =3D skb_tail_pointer(skb) - KSZ_EGRESS_TAG_LEN;
>         unsigned int port =3D tag[0] & KSZ9477_TAIL_TAG_EG_PORT_M;
>         unsigned int len =3D KSZ_EGRESS_TAG_LEN;
>=20

I am curious about what MAC controller are you using to return socket
buffer with fragments?

I thought DSA already disables most advanced hardware acceleration
features so that the tag manipulation functions do not need to worry
about accessing the socket buffer incorrectly.

Now that the socket buffer has fragment is it better to remove the tail
tag inside the fragment to preserve the performance of receiving such
socket buffer?

I know using skb_linearize() is an easy fix, but is it worthwhile to
check the receive performance?

This is out of topic.

The transmit performance can be improved by keeping the fragments while
adding the tail tag.  At one time there is an API in the kernel to do
that, but it was removed as nobody used it.  I see the hardware checksum
generation feature is now preserved so the tag manipulation functions
need to handle it.  Is there a way to allocate a few more bytes in the
fragments so that the socket buffer does not need to be consolidated to
add tail tag?


