Return-Path: <netdev+bounces-97857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FA78CD881
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 18:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40B6BB21095
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 16:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F5C17C8B;
	Thu, 23 May 2024 16:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="syqnMX1r"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4556E18643;
	Thu, 23 May 2024 16:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716482179; cv=fail; b=KTvEfjocCKS6qVw/FIO8tn2ZfgPZdIVrAzJ1Kq72eB8k6NKEgsP5OggUz2v3l2tFPwZtLYr3S8Cup63/FkntVUofXXPr/5XxGOI258DAdF2fRAAabKU/iR6eEKDROKyk5Ox/S5KS1cifwsYq4MQ1ZseajyHx1ppQOZjBZn624lY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716482179; c=relaxed/simple;
	bh=HLA3/bIg9SmEUIpIYcgixz9dc0e03C+7VkYP4o0r/IA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ByduiFJSgi5gByFM3m2q49nWUZJb/bxgGSCLjSTBsy9VARCHvbshFcvN+Y6mErCPMrGgGZpdOJnb62R/gkDl1cLd15012AZac+imtZFFjJcP8Xap0RIi3yjNnuqpp1mv0vjbvMx+ZL7GqjsjXF2qQajMxaZqoG/bU83xx2hzJOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=syqnMX1r; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44NG3ACG004520;
	Thu, 23 May 2024 09:35:57 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3y9xy7tcsj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 May 2024 09:35:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aWipO7k9GzVgZbEpyrbiDhqI4bFCBz9XjCJOwX3SKO2/r8M5t2DV1TXBOSfoaeQst8zeDgYYQFtsNTWsB/EBEkBWQG9zQek+IBJV0V0jb6Bq4Kl0jGNZe7ob5dnU8fWvIprsxOzAm6VN/Fp3lKkqLyFHidrgrQEp8YAP2YZT4teDs5fEkW1kA78X3EcdGceEsk8RgQTdHDTzPgEkEz4sP1lRQnDtq93HOSpUT8epMENdEUB5udPK/yv4RGLDz72lpK5EeSKRLPbOYyHkU+0C++08rM1HfqUZEndpbFck6iFSjwJM1i+eT0IgPdngp5ihMpKPH6SpFK4Ht9QeGWqeuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uo++/ZwhY/TaX2WKuVp6O2BUWTMUthltJHG/wRZfxHQ=;
 b=lzmwnIeyXQV/zaM/GIVSuQfNmp7zZj9FRQN4vnT5o1+ijrGC4Frsfrw60Rp7gWSTKp2/L4f6VAGGn0PpYH8ZgtNiNsqJte4dg/97el1bgpbjhW0CHEWXCUAsnZeIa9aqv1Hl/OoVyrd2O+CX51GGI4iWDyzsY489tYst1EdNHGMECzk5c6KloI1MAusRPCbN67ZmJH347/bMBsWE25p3yB/mE5rRV9Cl0mcQSDGzskr7jhRwor03AWYRjbpnMZPGDV/XkULU6KoXE+Nx5HVgEcbHE17zJsAsKApvVDELuU8ejei3IfLVjUXzNoLGZzgp2QxCo7CFceo9h1JT0on+dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uo++/ZwhY/TaX2WKuVp6O2BUWTMUthltJHG/wRZfxHQ=;
 b=syqnMX1rfyjgmx7iQmmqWlOe5zz0WFAbeazfRvUK0EOoG8gdE8c+w7WXI7FYXiK6Zj2Lesqp1FrT8VtjcpFDZ6UrAhUBfflm7skUJX3QUrMTNuVe2dIpaLtnHdamvW06JyFjo3KPF95RGCMUIXp2y7adFeOSisuGK5Cy0w2iR3g=
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com (2603:10b6:a03:430::6)
 by DS1PR18MB6147.namprd18.prod.outlook.com (2603:10b6:8:1f0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Thu, 23 May
 2024 16:35:52 +0000
Received: from SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::2bf5:960a:a348:fad1]) by SJ0PR18MB5216.namprd18.prod.outlook.com
 ([fe80::2bf5:960a:a348:fad1%5]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 16:35:51 +0000
From: Suman Ghosh <sumang@marvell.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>,
        "andrew@lunn.ch"
	<andrew@lunn.ch>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH net] net: micrel: Fix lan8841_config_intr after
 getting out of sleep mode
Thread-Topic: [EXTERNAL] [PATCH net] net: micrel: Fix lan8841_config_intr
 after getting out of sleep mode
Thread-Index: AQHarOT3UyOxKcfaoUSXaQoYOaBJMbGlBGjw
Date: Thu, 23 May 2024 16:35:51 +0000
Message-ID: 
 <SJ0PR18MB52169D42D6D26244E003BCC8DBF42@SJ0PR18MB5216.namprd18.prod.outlook.com>
References: <20240523074226.3540332-1-horatiu.vultur@microchip.com>
In-Reply-To: <20240523074226.3540332-1-horatiu.vultur@microchip.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR18MB5216:EE_|DS1PR18MB6147:EE_
x-ms-office365-filtering-correlation-id: 3ee369ca-9ea4-4021-b89a-08dc7b4668e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|7416005|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?l4sJLEWtCNEp0nUpZZoB8uK4YiB5xrWeDEmnzTevTLNfZDwgLxGE/SxzHHcj?=
 =?us-ascii?Q?z9bUsu8k6E9rgppzLT/Bq2lRGDP5rsyXZyBJJQyXDqCawGRlhDJBBT9E7lWv?=
 =?us-ascii?Q?Oe7G2wmTfQc9i6Cc404qBxabT6mk9WhMamPme7VRNtYVg084QxR5WJn8IzhA?=
 =?us-ascii?Q?XwdOTHybvoc7t2WbUCeQxjGk0fQiNeWZnr5XvjlokCqr3P5CAYFm0gLFAXcP?=
 =?us-ascii?Q?sS3MIQoTWJozixycWNMzN97DMU8HjEtgZH7A1QyxsF9e2Dw6+/Y2GY/SABeq?=
 =?us-ascii?Q?P0vg0v1CtWDik4DikY9lhPSpYJ/pZV+oYlyYUzeFGnN3uf5mNAt0XiXVyZ3X?=
 =?us-ascii?Q?djmlmfRva/VKkPFo33tcUHvlEfKaM1ZXrmai8fZo5a4SMFZOzhWZyV948+53?=
 =?us-ascii?Q?cgIJXMUJMKZNNHYBqA2+OpmNyg5pogeDYEPQipLwp7lbNoo/pbHptYkp87on?=
 =?us-ascii?Q?vri7pdYdHeVfOCwVxlM/Ng2/AuUVXdOEW7fB1J9BejnS136slconQUc8YZWR?=
 =?us-ascii?Q?Iy4K51ZB8GaRaZRlh7JBscZxq8CN90Y2QwSdIdP6xNPBG1CVjrkeEwhsiVqr?=
 =?us-ascii?Q?CEGkjWs7Ea8Mm6tAHzDn+840J4Gmk97NVWsXrsiDBkxzEzSFHznBJdhZUOHV?=
 =?us-ascii?Q?Q/DHiL7zIDaK84Z9aO//dymAKE3Km7KFqKtyiHddJ2cxli7NS54cxCzs720F?=
 =?us-ascii?Q?R9kdih7ciRhyH804xMykuRlQS8LLx5bI1hfh7PDpvahqoZKSaVUeluOm3BtQ?=
 =?us-ascii?Q?SBE8f7B/eJDZIfhUryLFR57VK32Kk2YmSUekH2hVHeSdzn9+fgfFV1Dbilqi?=
 =?us-ascii?Q?KQmVfbhCp5UUz5CrHcCK7LwQBP05S/7p+gQBLqPeTCBfKqvd3TLoPsdN+Efb?=
 =?us-ascii?Q?99g93ug2yYawMg8hYO4WKpLbRl1PyXOeC76fnX3ZB95TWpsaSUUtUD8yBtrk?=
 =?us-ascii?Q?hDmU0n3ElLFIYAb0VmL3Y/eCLnMzzfQmK/uW6et/bBtf4PSWZQyNuV7Vu4lG?=
 =?us-ascii?Q?aegFyezjv3UdIWCPGfc3d/dTThv0fd+0nsJq7wdFQD+qUk/gkaPwlNKcmvcm?=
 =?us-ascii?Q?TvNNWi0KmEEhAF13LNR1oJ+wqPpS2g1D+yhD2EGXjp4NaIBSzLKTecq9k8t/?=
 =?us-ascii?Q?/PITx+e78uvHBEezioaM23aJ5b/7abI25OV6pDiSiudeTRENeoGgPOEkO7R3?=
 =?us-ascii?Q?00IH3Emyick1QbLyCZ1PmAuUESDGGUPzmbH3aDRGgChaYzXVgcnV074RMYnd?=
 =?us-ascii?Q?XpFdp2vI/4WxWlfzcf8cxuTpqbiaDf9wb4ggc1PjoJl7NoR6wFeOErFHXX5x?=
 =?us-ascii?Q?tOEub2iM9g1a4YxIA4AYG0KmF2PZTZf9sQoX/5wAJv28SQ=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR18MB5216.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?qIcxO1n4uCvVdQbvSqylrgZr/FWe5wENwCPr9Kpy360nSZKQeh180wi6HgFB?=
 =?us-ascii?Q?8gjhFN5vLU6IEIrriS+UucFpP8ys6dr/OrcTWUIg6g3FwgLv1ReN333yO6xl?=
 =?us-ascii?Q?JrNRGa5Ypvh7qtMa+4M5Hl1vn3AF1Ut3xCkVSRvW3doEg/uUAzpEvA3E5gEk?=
 =?us-ascii?Q?WAei/dj0QBvROCacfZHu3ImoRaUkruvsqXJsekkpWBTFiiCQe284vDKFfBtI?=
 =?us-ascii?Q?d0UJBRCsqyux1fXnwUbg6gL1s5espW2ohO2k/SO5w1SCVFJ91TBAOkf0BTZk?=
 =?us-ascii?Q?RyRjpvrACqqAAcI8t4wo0ElcwAAvOI1y2dxG/pF11MziGzCBn34GZ89dNGh6?=
 =?us-ascii?Q?WpMHfo6HzHmHZbommnuoUwCXFCyTTEHlx/9hlsxPPZNX61UbpatVxDVcR9P7?=
 =?us-ascii?Q?ya2mvWTXsmLUapVfgoYH+PtWlg6YHVKtwTmeA9GLlB48yFH+Hz723emiABXJ?=
 =?us-ascii?Q?SpLbMVQEouQ4tIGyxPI+8FfuNdBicqKnRTnMssKO+pxfccWYdXP7kTXWwj4m?=
 =?us-ascii?Q?vQdzqyc2U4caURP/3we8t5u9jbu4BzOWLtUle0ErN2XAFWngvkoTppArEDQS?=
 =?us-ascii?Q?ZkWG8HzYAKUn8kkzPemslxoiP2X6uqo3bkT4WJntzdFUrPMm5cM940lFd2dH?=
 =?us-ascii?Q?Ac9wi7FCPoTaLXy3FbYmLlUqG2JLP8J8/1r82RGpCVvJiyGNmCjB5iT7NhP2?=
 =?us-ascii?Q?EDCSBZhbxxTArkPHH80n1wRFqnonQUg34/KVGl5XYzCzXL+wJ7qe0Milz//u?=
 =?us-ascii?Q?DC1Hd3n5EY7+GUXiABT5j+YPeAnsvhXt3UVMPxr5915Zt4/IwTRxmNNQi2N8?=
 =?us-ascii?Q?DvWMyzPTcCZrae0LQc+jXCGhkzDG44Fgm8VMZRVm2wsiIrlE2bZn31wFot55?=
 =?us-ascii?Q?fQJsS6+Vl1NPrVAqDsxlWbepqqkvTmCk2BiQ2cYQomRfJsn6TXWTAfkxO1ch?=
 =?us-ascii?Q?VkgLPhOaPWcVuZ4E70Cdqq0Y78YNn+VsFPK/XKnO2cVTqg65lnKWFuGUYCmq?=
 =?us-ascii?Q?oE+9lvzhepuxL7P7mBQdxxN409lZiHVWRV4BqV77UBw/jTfqF8BBZ+JyATA5?=
 =?us-ascii?Q?m40N2jYOwwcTW89ULNfWMJR2rVmrx2Pn1u61bTv8kJuE0wEjOCnFnQywNLcb?=
 =?us-ascii?Q?DZIOfSzU27OsvD192Go9FjSFCCs6lqsotOZXUODQz6uqE/zNRQKo9Cvtf4wV?=
 =?us-ascii?Q?fShVq23L83maKFhRs/kZmD5pjYqhBD5N2Um0EixcC+34ly189ud4Y1zswWdy?=
 =?us-ascii?Q?dRv4dEaxoidB6KVW//NAPOK7QbWZjelK+73Y+O/T0Nh7OqOrsN5EuxtWLxAV?=
 =?us-ascii?Q?AG2ZiakgTDvM/Bb5/L4/lcCjgajt9WNLqnSJvDw6ZgesVnvhw+usSxMyQb9m?=
 =?us-ascii?Q?wfOmeo7IngIm5QUQmW3bb3k6YMkoa2nORtoxpHBeqGCh1NekFcpEiDTTJtgx?=
 =?us-ascii?Q?UuLh7N13C8EjL4l3n/OdsM+S3Pyj4vEYXDu4h9GM0J1n67FEsoGynlX/ASwF?=
 =?us-ascii?Q?D10XVeNHwQrbRVdcTg1xkHml36WFckjfLIsLfh71tuAvn8ebwlp6Il4svE2T?=
 =?us-ascii?Q?xfqxTM+BIG52csi/VmoXQD8/ZAfBuWDqx/RScgYM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB5216.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ee369ca-9ea4-4021-b89a-08dc7b4668e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 16:35:51.7064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H0wyflwBrAV3r2+LnHqSfdki23qI/cBQJt+kymgBE9UHGW7li/S4heUPeWL3QeMYUveFeP20gK0/LCbpwv9bpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR18MB6147
X-Proofpoint-ORIG-GUID: qHt802B7hr6AFEscS8AHbHNbXqP9uxoQ
X-Proofpoint-GUID: qHt802B7hr6AFEscS8AHbHNbXqP9uxoQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_09,2024-05-23_01,2024-05-17_01

> 	if (phydev->interrupts =3D=3D PHY_INTERRUPT_ENABLED) {
> 		err =3D phy_read(phydev, LAN8814_INTS);
>-		if (err)
>+		if (err < 0)
[Suman] Hi Horatiu,
Should we modify this check for phy_write() as well?
> 			return err;
>
> 		/* Enable / disable interrupts. It is OK to enable PTP
>interrupt
>--
>2.34.1
>


