Return-Path: <netdev+bounces-95974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC248C3EFB
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 12:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB98E1C20319
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 10:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8592548E1;
	Mon, 13 May 2024 10:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="qw1m6Ges"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B265C31A67;
	Mon, 13 May 2024 10:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715596568; cv=fail; b=lWSel7L9pAZ/HocKiTemZzGywBNJrV7P6LsYQ9wTbaoABmYZdAER1mzc9jGtHsPCOcSCIEYYZtpbeVwu1R2F/91B45Gb4sKv3iCCkdOYHyZIrUzAy7kVysgeNEH7jROsQ77okKTb2z+7fBycy3S/EUfoQzrY9W8Er9lKtnntkew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715596568; c=relaxed/simple;
	bh=xtTKNCYQumbA/s9LZTl+mP/YNdRCn07e/UJyIOyAWQs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qKbTadYW9GKgeAKm+aDL2RPrgioGpq+V+mpwGjFRRdDzuQubRijZEzCDYQKUCiMnbkbsnXjvOziIc6wzoBsINWw+kIjxgqFyw5QQVT8leliLLWff/0EPYYIxFqhn//8EPOMyR10cj7rrSdDal5WSNZTI/0W/eV00djPaLWZ8+rM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=qw1m6Ges; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44D8XwuD003295;
	Mon, 13 May 2024 03:35:55 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3y286jbx25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 03:35:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iNM2r4RK8g3CeSY4AnDd8rf+qvaYL7j47aBvjxclh/bOunTdqHNyor76JXedhJUJmSiCzgCRh05Y0Zj18Z7+S11HhVJfLB7MDXUMdWGr3zH8qIHSjxON8Y6LpV7zFQ6bV/Rx1VXt/kEyfJr47suD+M43ioVsm9K4NVDb2KwKQI+vq9PXX9UT0KDQekErTEulclHg0cvtHpLtja7znPRVfOwiAm/VCCCQEORE2tFIWvqqT1HzXMHCjH1CQyZ/XzKULl5hqFXVXDdsIlnpsDiZuzM+kMwuXRcbpf4zuTTykoJQHXfvlgIz0/TYQhZdnatw6MQt0TWehmXhhnxG6I53kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+0deL7tHa3A2m/LaUPmW5IaBSF4w2WbnluHdUsjNcI0=;
 b=IToTe2CD8wf8qGBg3dT613IzK0ixf4ZkfMiHXFSPqEjkFSgc0ZYSSFo2IC1o6PzOk5Jew/Qox+nGDDy2d7wfmLXxX3TYgAKbVGjHfiBCViop41EsXyJa2FDfjTHCdP/q2l8kUhI3zhUjiizoevjdTOlu6nKcEQ84b0mXogqqKNwbG08cKWXJ6qpJKYN7HgTthi4oQEekFgWdiA/A+CAIWk4Vv5cZAIU8U0G8+K/XdI9gOBCmV65WZL3hgXlFXe1YdG0elmh4Ke7TL3yuUpgiHFdo5vBfSLaw+7DR+wNVuG/qRpdI81fL43NbuQhjiwnN2wyhO9A0Pk0p8s2qM6le9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0deL7tHa3A2m/LaUPmW5IaBSF4w2WbnluHdUsjNcI0=;
 b=qw1m6Ges06/GJvbDnXCdmltw7vJe/ySgVWExggNqrr98bcfepA0wd1N3bKDeoNhhuJOmCPZMNUbKjdib/rSskP3Rh3HElkw3urCPTspoZSKo8s9/20wtqYST4nJECVwyAClVostldFJiO065LA0fa/OdnR4sf06mmlO0HuTK4pI=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by MW4PR18MB5082.namprd18.prod.outlook.com (2603:10b6:303:1a5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 10:35:53 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af%5]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 10:35:53 +0000
From: Geethasowjanya Akula <gakula@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "pabeni@redhat.com"
	<pabeni@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        Sunil
 Kovvuri Goutham <sgoutham@marvell.com>,
        Subbaraya Sundeep Bhatta
	<sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>
Subject: RE: [EXTERNAL] Re: [net-next PATCH v4 03/10] octeontx2-pf: Create
 representor netdev
Thread-Topic: [EXTERNAL] Re: [net-next PATCH v4 03/10] octeontx2-pf: Create
 representor netdev
Thread-Index: AQHaoJ0n31dqKn1PqEi4BSrztzCWvrGP0u0AgAUtwVA=
Date: Mon, 13 May 2024 10:35:53 +0000
Message-ID: 
 <CH0PR18MB4339EF84925BFC6ABEEB69DDCDE22@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20240507163921.29683-1-gakula@marvell.com>
	<20240507163921.29683-4-gakula@marvell.com>
 <20240509202808.26e960a7@kernel.org>
In-Reply-To: <20240509202808.26e960a7@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|MW4PR18MB5082:EE_
x-ms-office365-filtering-correlation-id: d5897df9-7125-4911-cb9d-08dc73387713
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?y0LNW5NA+Nv+V/jrMMOQU0lyGx+KxJDcv4q54a9N8Prj4AnU7S+8+v4SaKN6?=
 =?us-ascii?Q?oZg8VA5tiPelDhU8OwYRLA8SifaXPNjMdbhsxI1aXYtJK0yOJRKLYkez7Omt?=
 =?us-ascii?Q?EteRCIuDjfSwB4jkm6sdDBILs9GL9ENoWwcb2Xr0yNcgj06lw59Q/02Bss5R?=
 =?us-ascii?Q?CIBmhuKXDcnQ+peUyczcHiJtW+EeHJV2bye3qheBA9bQJMRZKL3+9Wwe+9rP?=
 =?us-ascii?Q?jd2Xk0pac6ifgUwLT29LXK0Fb8ix8JSXY0yq/RT5a8IhfNKOcqnQhr5G52WS?=
 =?us-ascii?Q?IQF136sJ1mUu7cFKcrRknMJJay6KUVfKF8DjU/Tz4UN+aAVYTHlpSQ9dkmMX?=
 =?us-ascii?Q?CCN3mdor64x8h89Y0fg7uuHqTBxWyK9eULhYeeriegRRa2x5HSIKtcIoAAfX?=
 =?us-ascii?Q?h9fiP1FbSpz70bkrwp7mKnVGnuO5kvUPmJTljCGV03mn/qIwZQSns6gCI6h/?=
 =?us-ascii?Q?/4L0tkIQLP5TK6yH0tQaiK5nPEtpqMhjYI0e7a2Y/jf2AU3s7phISbyef3y3?=
 =?us-ascii?Q?dA/TybaBTPq5JK+UxszRX7fBrXJhOX9xHKVlBGcsnrM50RSJ7VjiY39u7AwH?=
 =?us-ascii?Q?zCfeGevqk1ew3RR6Gl/X9Hnc3L37q9EFVqjbaKkFfG1JToiC7a6mTOKU87wr?=
 =?us-ascii?Q?vJ2Nwz8HT1/WJ2eofcM+fWgh2HX4s9Jg/bWBsfsU5pXi1XfpehegZ0wOSKRi?=
 =?us-ascii?Q?2VM7ImRiOhRzYXHQ6VVlAzM5yTnwTReA+pID31ukWJidNnKKV8HxDjta/2by?=
 =?us-ascii?Q?EQqaqdI2QUYYRY1ylzs7Nk9aaa1QUHvxdZG0DGuIxMs5N7uHz+TzDgF3iR5J?=
 =?us-ascii?Q?uYJWn3UHtZmG042ZgLTaDStXxK1QFAW/GxF7241xOoTsB1McB1CHy+FExbF6?=
 =?us-ascii?Q?dbAT8SJwWEUzxOJzlAb7bliehMAYvqhw4Gx7R4w+AW9AODUeLxA4fomw7rC7?=
 =?us-ascii?Q?n0BX4pzTO88SkUXe/MYJto50PQ+sot/O7iFBWA0H0UyJR4O9liXzPCNTzo0q?=
 =?us-ascii?Q?bZXc6QDC9tN/t3KUXRaU3paz+LZ5mio4ZxrQe2A96JWaivQmWu207eO2XZ/P?=
 =?us-ascii?Q?4AFAtGBdvYX8GZIIfdet4Fen9c36zKv8HfhQx53pAGchixQ8dTtI/t3rjoe8?=
 =?us-ascii?Q?TRKKfnhcVEdFi51k/HRb56IFD7BJnCj4XvrXkPAEpxoVmou2V0ywivdtTLeC?=
 =?us-ascii?Q?/YyWgn7wmF0Eqx5J0h41O4fbvk0PpGCXA6XfG9lta9FHtF1KLhO/rq7w5gBB?=
 =?us-ascii?Q?Oib/sX6/UJgeJRzMhZqVBrBM/ofAyaIuWU+h3Go+NYe1RkOdTx7/UzIbAN5U?=
 =?us-ascii?Q?xyAg/XZjgsVvqrBHpHyNqKGsaXxUDdBG+5+x5DX/AL7vQw=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?WqxfyNWLvrwS0aSxOnUc5zHIjlz3JKONR9KbPjWBlELdPHs4X+XMdMzq11AA?=
 =?us-ascii?Q?bnmQwUmFzBkRtWRHxaSaXZUPlqskcbkHn1JaSy+jwnLL/5aD5sqhrhP1r5ex?=
 =?us-ascii?Q?+8K+8rXz4gHKSgzsSsZbwcL0j+dwVQutba57PSqSu3Nl2OSt+PB+oGOn61hp?=
 =?us-ascii?Q?aAGf9JGJbl1CexCbwKxwjCZ+ptB7lXrpwfTsKxkiLlvgWT48vOaZPmPj5Bqu?=
 =?us-ascii?Q?AsZFhqjiTEaMTheyi0O/ps+3WSpas5M5ChPjTB8ZnttP/48c3uOMecZSt2ZY?=
 =?us-ascii?Q?hvQwk+ux/Q3l/yibn/407xIu+vbpFZoZ9F99GcUoHMYld6j3ez94BVcUkLKg?=
 =?us-ascii?Q?d2ELDRw0aodLRySIGlsegSQpjvBZrkZ+GT2icVG5IE35H98QtRyqcsM1Drqq?=
 =?us-ascii?Q?PiRzasIxXWZpmbU11DoRInBJ50uZXHP0tLpECHvRoeqx7ylMbFiyc/jCPEhL?=
 =?us-ascii?Q?SS3Q24tKwYNunhHUilYXod4WCIiry+JAMk3qJpD8Mxns3grOT/u2Tx91Y2Wk?=
 =?us-ascii?Q?EIoTOht4pjLxDfw1cUKMAHs2SssprtHeSoM9rz1s2BPNyg5bnewqQW0vh4zU?=
 =?us-ascii?Q?ai8sdZ3VN2gN6OIPrU8YD6T6uzWrfT/WtfUO5G4GTs6dPUDEiSo+4vzB1gvX?=
 =?us-ascii?Q?m2IFT7eEoaQm+sEap7syOAMxh5gJPnGFPSZ1KvtEQpqQsYco8n7tJ1aq7HZf?=
 =?us-ascii?Q?E0PG357fvnPSW49SgVCJjm7649q58jKzmKJCMmE8DM0giWOQYywWhFryU8qz?=
 =?us-ascii?Q?O+cowOWxJccpSsH9qSg/K5W7YgoN7j+gGVmxl6NYt1waBIvF5usOZA/xTCaK?=
 =?us-ascii?Q?fMzbaKEO4y6xC6bTqj2EiuF3N3cB/FFy9+5AQe8KuwYZQleRWKCIHpeijg7i?=
 =?us-ascii?Q?UsQITlJUegYyhWmchYJysaa4sYqyf21mTSHu8FUqoAN2S52Qut71EXIx64UM?=
 =?us-ascii?Q?eXN/kgANT/g6vlbDuh7ePMY7IOppsluMTFrwBEvdveGmKCFF4tPA7R4PefPi?=
 =?us-ascii?Q?Y09psjeZd9mThkoOIJNuYdb+5f6ETtxjNxzhK3UNtwhHIFGt1DjCdjkqJUJS?=
 =?us-ascii?Q?3gCZgvq/8yD/EapP9oC1FwpeYpP0Kid39yTF1IS4G1ntTCg7BGpPYmcewwC2?=
 =?us-ascii?Q?9k1hq6xKMiwocJUnKJE1uM2F6DLVaRogJHBkGoS9a8PdDqMMZPObvVf2ZNPW?=
 =?us-ascii?Q?w84v9KxWElH8dcHrCjqS3S+yfQRB6xl66UNAS4btXQrMt7aXO+D/CBTTwco1?=
 =?us-ascii?Q?TddQivjTWhkyFJAIp16g1w/+UqjDD8Nl+Kf3EA1b/pi56cy37TYaP70t0ZVD?=
 =?us-ascii?Q?cd8iviH2Gu2xIxUSX92GMjjQJerKeOm3G66V5t0GLq9pDJ3Urx2SJH5BgrKW?=
 =?us-ascii?Q?vzHSnmua05QgNT1gYa4FnDVIvZ2BC8RieHPJ1DPx/4z//ajbfaJ1OWxWCW1A?=
 =?us-ascii?Q?+nOqR08JIz4uaFJbnmt+DtPPpTs+/jM1pfT6KV8SHU6R2G8fKK0rs68xmO32?=
 =?us-ascii?Q?dWwo8lEhLKxj1NFvvES+tpcF978gKjLQS1lw+ppszUqzdyIrDEefvvodp0A3?=
 =?us-ascii?Q?wXKr+562RNgBtHXoN1o=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CH0PR18MB4339.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5897df9-7125-4911-cb9d-08dc73387713
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2024 10:35:53.2773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gAgsjuv/X6W1ZpvCo3y0XUz/M6yH5BIbS5Z2Zqp+yA1PhgknqQ2u5paeD+b5Mo/MifRVJF1qDERT751+aSG+5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR18MB5082
X-Proofpoint-GUID: xvtyoyAspJYekUIYkSE9-n0AMxme-EVj
X-Proofpoint-ORIG-GUID: xvtyoyAspJYekUIYkSE9-n0AMxme-EVj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_07,2024-05-10_02,2023-05-22_02



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Friday, May 10, 2024 8:58 AM
> To: Geethasowjanya Akula <gakula@marvell.com>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> davem@davemloft.net; pabeni@redhat.com; edumazet@google.com; Sunil
> Kovvuri Goutham <sgoutham@marvell.com>; Subbaraya Sundeep Bhatta
> <sbhatta@marvell.com>; Hariprasad Kelam <hkelam@marvell.com>
> Subject: [EXTERNAL] Re: [net-next PATCH v4 03/10] octeontx2-pf: Create
> representor netdev>=20
> ----------------------------------------------------------------------
> On Tue, 7 May 2024 22:09:14 +0530 Geetha sowjanya wrote:
> > +	priv->reps =3D devm_kcalloc(priv->dev, rep_cnt, sizeof(struct rep_dev=
 *),
> > +				  GFP_KERNEL);
> > +	if (!priv->reps)
> > +		return -ENOMEM;
>=20
> using devm_ here is pointless, the objects are not tied to the lifetime o=
f the
> device (there can be created multiple times) and you have to unregister t=
he
> netdevs manually, anyway.
Will fix it next version.

