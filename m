Return-Path: <netdev+bounces-107498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0CB91B32E
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 02:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D1861F228B0
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 00:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6847E191;
	Fri, 28 Jun 2024 00:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="nO+xhaYv"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61791193
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 00:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719533349; cv=fail; b=SgyZwommmFx3kObx8KmoudMo7obDWIR+zRg3gsBOKbYBfzA5sme/HBQ1EEIfVE6vkRULenLwRcWAHvTxJ16thaLcVIi/GxUZfE154ObRuYHckSlin1xXbRjREpY7+KVGxyZptZBrBaYSJHTS2nj8rixcb3YEHXgiQkj7xY8XDL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719533349; c=relaxed/simple;
	bh=SJTvhDnF4l9CVrAU/FlqEumHAhUucByL/syzsvHfRGU=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=i18OiuKl77aYQKnDC7VKauq2pfqKOcqqrnCdK2x8/YHEd6M0Afan6g8Ph8UpgsNCsTo/l8O/uC70rNGpRT3iTTAjWQgfpEtsBFmBnzXhLDGg0BSd0Qj4PmAWneyOuKJEfU6ulOWjISa+tQXxodkKFqo1qXPxJgxTRQMZHvFWQpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=nO+xhaYv; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45RFRl0s030553
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 00:02:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from
	:to:subject:date:message-id:content-type
	:content-transfer-encoding:mime-version; s=pps0720; bh=mxMCXfs7v
	6EbdKw7/oHX4aNRBqh9PSOnq8SI/wcLPNk=; b=nO+xhaYvbPpKYQ6A2w1JamsIp
	3Qr9b102RLavQEE8fT5X9RKXGrh3zgjfIjEUOBimylb2DQBc8vichfuURrc2LSrJ
	f4tzVPkV+FmQjcQhBib8PVmKu5aobyr1l/ElWrvdMvZJdtorpDVaVsIzr22ZlJUc
	nm9sf9Qqjhg3oLulLn8PqE69SgJAzsMhCLhFQEKd9jABMnvbuwTb13v09/kO0iR2
	BuvABiE586ycUQSD/Pu9RAb5BvJub31RbX75CQLp2F+3DEuz8PnkFRTeOQfn9k6c
	DPnR6NKcgozccXKOhGrid1rCN0SDdAudbe8rw95vB7khVzaIekgkO86T7MJow==
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 401ar9u4k3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 00:02:15 +0000 (GMT)
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 93D2CD25C
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 00:02:14 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 27 Jun 2024 12:01:50 -1200
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 27 Jun 2024 12:01:50 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Thu, 27 Jun 2024 12:01:50 -1200
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (192.58.206.35)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 27 Jun 2024 12:01:50 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OSGY0ACcoDc0PrO+9Pi+OKsjqZM+kl7rAZycayXFgEvMD40uBP7rG1sR0exUvH6kFtWnrgCerH1XywNSwbY7DiunQlZ5uVZFJIBSKbxukKrkglpwPTioaGpcRI/okB/43sgzWYAmz+LhFMzDmimZeUk05UacQduEiWYDaglTwtxxLaX/wZX+nHpoWQF892V+gbUsoCeJ9ST7WOzxK23iKsxOVW8rvRnfD2bw7sdvFuRrgb3GJBlX/vxZXiBC8/fQ2LFgsI859T4qXEy7/IaVoY/xVZFqp8JIvRmV/5DKMFU+LJt5RyxYyr8oRa6Wvx0ZFkH9/BAjnrLGT1bp10guag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mxMCXfs7v6EbdKw7/oHX4aNRBqh9PSOnq8SI/wcLPNk=;
 b=JLmhC48jxXLnpXwvSGbELkxJ2hUVAE6kc89731+m3s1sJADM7XIpdykXNd085xbLSHWQdU3REwW94VBBdd8klJ+1+QPS6xRnp3NDXsFCyM6y1qGD6q5etWlHXWpN0FVXT/J/g7LUpDRTYy9A3d4mR5vE3p7HBT8QyFaJlET4hVzQlffWD47cXMTF5h2Z+PLbmtpReh+ll2Ffnn8R7AI7FgTWCeoK76L7kkOOCgZCS8xN4WDjzLEDUg4AGgJDwATPNwkDHgoPrkGYDSFdxSxUqxq2GCzRLiEsHCJC1w7drXO+mx//mMKFj2nzvpcxr5GqBb+whzjrpCftIA9CU1sCOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:437::8)
 by PH0PR84MB1383.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:16c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.34; Fri, 28 Jun
 2024 00:01:47 +0000
Received: from SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::8cc2:658d:eae8:3d8d]) by SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::8cc2:658d:eae8:3d8d%5]) with mapi id 15.20.7698.025; Fri, 28 Jun 2024
 00:01:47 +0000
From: "Muggeridge, Matt" <matt.muggeridge2@hpe.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: "ip route show dev enp0s9" does not show all routes for enp0s9
Thread-Topic: "ip route show dev enp0s9" does not show all routes for enp0s9
Thread-Index: AdrI67U2JlB2LTGbTXydBH/G1qpcpw==
Date: Fri, 28 Jun 2024 00:01:47 +0000
Message-ID: <SJ0PR84MB2088DCBDCCCD49FFB9DFFBAAD8D02@SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR84MB2088:EE_|PH0PR84MB1383:EE_
x-ms-office365-filtering-correlation-id: b9314974-592c-4310-c88a-08dc9705813b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?6dM9dADREsL42bjQZH4zLETKdhBXj4kuIKtpBf+JI4rT/CjckHJZRx/6lbF/?=
 =?us-ascii?Q?YX5qFMvugJTac/Tbp2UmMiFItS/Nk1dkPkTkDx8zvCh1hNMKzYycrpGbKimO?=
 =?us-ascii?Q?ZaCqWGMH78YSpzCoTGr1eaBO2lR+WmbNvEyeyiOpBvw2BteNrtMMFk29vvkO?=
 =?us-ascii?Q?yVP7sp9vT3p0MA2tPh9ZDGGcY/9fHklH32LNvSl5DUTvXhy6plGrAZhD6/VA?=
 =?us-ascii?Q?Xa3BFal33wfdGCn0hEbuRBh37edbIJkk3aJNM7gUp/8Lm5GtWvmmiJ9e2ipq?=
 =?us-ascii?Q?v/jmQyz3xtuX/HjwPuMtwIa5wo4H+OTmoXIwvfDtNSNAV9ogQnfonCRaXmoD?=
 =?us-ascii?Q?6yMXR5sasdrwo3REebJBMdr7SfY14ueqGqHnFVV89xsKoThp5/vYlE0ZoGyT?=
 =?us-ascii?Q?ODlGESaPqHEKRoniW9yTBW3tin/SiWrFxcd4oAUaG6nUK7JXRtnZCXshTax7?=
 =?us-ascii?Q?/w8TgRfzhDfwmRvuKvqesvHMB6CKAID83MhAud0gDbcnVuios2AQ0CNKt6WK?=
 =?us-ascii?Q?1XjamJ/3mUBW7mIkfuU3Q5srHDxDUc1NzZHYmZISmwMtnoWg9Q4EdoasknQ7?=
 =?us-ascii?Q?kUadzi8yEW8jY5379orzAG5I52aOdCYQpG0Rp3evJ3dIuoeDx4aJdfLn7JST?=
 =?us-ascii?Q?SSRENoOob8ImjWyT2L6uXheaWezGSVe7M4TqBa6FrExXut7ZFHeTAFREZzmv?=
 =?us-ascii?Q?eKMSBvXSsjcaC9kWxhqaFcMU5GBYat1yk4TICWdZiVsJJg4svqPJ4AaI7vly?=
 =?us-ascii?Q?6TmQLrArEOHo5octhCgbm+b96dl6StC/Ib/cj87d7c2pu8aGoO/72ns6fZWs?=
 =?us-ascii?Q?e56013m2B+nXCx9FvQXD1VP/+F16akMLNMU5oByWfC241F1mr7R1st0zqG/Z?=
 =?us-ascii?Q?vobHVWPcdEMtthDIc2zyNIxJP3V8qFScA9GB2DmSzAec3Oc93F0xHj6wVswi?=
 =?us-ascii?Q?QCpzl3EsrvbncXpxnqXfLnkgW/y6Ko8dl1A3SP6Gj+kvJ3xwllEEoYVXptPV?=
 =?us-ascii?Q?0PzBH4Fj6aEZcnqVZTHjYwdeY5109T+XMhea5hsKXVeh+NgRUpDDpK4D3zvw?=
 =?us-ascii?Q?sayq8AZtP8DkkHgMfazojewM/r1A5VlNUTMLEs3lGbsNjzeN9q8mAKxgzdu5?=
 =?us-ascii?Q?Wfd/m5uXaDjU6UvtjlWFFel/5FZ0tUpu49af7Aj8Q5QiOfyN4+GEdGUtztLK?=
 =?us-ascii?Q?s/UskubJDmKveFgAUJb1rJAUHgY8NR3kkZlH6lmGpwmY+8KaEDG1nIg0bop5?=
 =?us-ascii?Q?oUgCveoUQiINivwQc0xAxgamuBFYJ9unZlp5VpoAJVxLMf/yWsV5BirAkr1m?=
 =?us-ascii?Q?w7PK+x1qgO5CFbLUTkRos75CENmxlcvvVJTggampwDUivvrlPC033/owPfCT?=
 =?us-ascii?Q?CqDvqKw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fHnTCQs1cT4BGc5Gx87SVec9Q88A/NC3brhC9OJEiBNiZgldKOouFrz0Uvc2?=
 =?us-ascii?Q?/CkK/mhsr/p9hCFSsw3Omb6lhdLcnEkJ3FyPYcMfdL/9YEtlAu5L0MFJwATR?=
 =?us-ascii?Q?shFGb2LhBDVbxtK0XpZifcCCFHyVm1y3JkcTH2CxlHjm4beTHNINr12kb8MC?=
 =?us-ascii?Q?BIVOVi5i7YEVFN+Zv3oYyMWWQypNkYoB4S6ox1tOAOk+fj2Re/eBmTRYUmDR?=
 =?us-ascii?Q?feH/3QRk9Kc4cZ9Gj1hHTzbpsNQP5Gb92GbD5NnqhkBnUP+ZXp1W1MFSLXU+?=
 =?us-ascii?Q?yxGxmGOXTRaItzFqBRpMLzXTtmyulXr9IuA2InBv7Y5gk9s38vgDW1UPoGuO?=
 =?us-ascii?Q?pQ9hVh4V+ZTkIf2Y+REEztI8h3ldICEcc8auoyVg6dXAkxAUsgXWchE1yVVt?=
 =?us-ascii?Q?Cn4iVBEuCTIUuKAMjMLV1/bf7/HIfKP4BrzhLw0IN1pl1O7+9aPpdF3WQJUA?=
 =?us-ascii?Q?ox/v9F+F2xY57SMylKGCfKt4m1qhXZuJOFq325og9VQwtJIij8SPYHuygAqS?=
 =?us-ascii?Q?tWjRzT/MU9bnYYFmxm6TfBSG/+xTI8ubFdoLmkE+jeZF54LKmVdCuNTmm79n?=
 =?us-ascii?Q?+R9Pj4HZBckRsd7L5EdlbfNXJFzX+pzEEACgh9MlkpoLS7KDCBhrxPXD3T9D?=
 =?us-ascii?Q?7OxFHPtRflVM7CKhI0edj/j2GGhF4vNi76lQflbD239kSCLiX09uSVF+p7KP?=
 =?us-ascii?Q?KTIgCV7takMTQ1d9o0+t1JbFlbBZBsEKnHHzAzUzcEvoNgSdgOXj5W5JvI+L?=
 =?us-ascii?Q?YCNXk9W2Cj8Cjgdq6q5799mOOGG6NBKVmKnwC0SFXJal7J8VIH1LMD5q2Cdu?=
 =?us-ascii?Q?ndOhpIH5+/5fxyit6IzTOuKvSwPmHViDpW+MbCAGQdYfnz0mJk+u8E1Vi3Ru?=
 =?us-ascii?Q?tSZ1x+jn9xoSOC5+MYO1LU3Rf9oSJ5OWII3PduT7aQjHPT51E0LHw+3Jsx46?=
 =?us-ascii?Q?/T6uhYDwb7WeYyD0Ia37rhr9wrGPkDnIUQpILV0xafapE6ROnF2+k06YMxFr?=
 =?us-ascii?Q?i+jkrYEB7AE81TXvJO/H+6w3jMmLgxuIfm/WsGhebp+aFejh2Wh+/AOXeiG7?=
 =?us-ascii?Q?O+gaoG/n7VVNRqc0wxIVfInInj1FyJvSjBkRNclevqBNaFXVr3J88Gg3Cnyb?=
 =?us-ascii?Q?VDXLCDx9lu70qSCz65PnW7Ru/7ppkc6BT6H+1y9E93o1pgunndzqrjrhLJPe?=
 =?us-ascii?Q?zYAUR3yYEERSenZv7F5vsIRtTRS/RKivqNRZyYV+/rT4U0cbBYAgIZEMNDsH?=
 =?us-ascii?Q?nHWPtVy4VZZsBa4tqthwz+WN0Xk0voWtYUKXDDzABlerkr6O53OLGRFCRpRO?=
 =?us-ascii?Q?dW5SmlVQLxs3kLFUvLkkd2xvfjaDuMDn8xsA7rKKsgtRT9+bVe5w8K5jf6wU?=
 =?us-ascii?Q?aT+u6ZNcyTDy7DrIvKWJguXbjys1bTxmId+KwbDd1f7vOHr43Tl9FRwZPiV/?=
 =?us-ascii?Q?YTEh0bE6e+guQ80WA0j4O2vgHFTNtWkp86X+VcUypAhQM0C2fNVtbkgeDwev?=
 =?us-ascii?Q?YaS6ZQJ3oRVtpx2nVaZyeaio+/lgsEsIvfXNlOdOXwveU/jnuZ8arDwfE9HI?=
 =?us-ascii?Q?OQ1vHyuMQrL/SS2soScprQOKiMTd6GXrAgARCFOM?=
Content-Type: text/plain; charset="us-ascii"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b9314974-592c-4310-c88a-08dc9705813b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2024 00:01:47.8251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lQHgvJXJYkeebMLdlsb16Up15+aEROKWetDR0VMV70g8o54BuFqLcznAlapFBP2yqbIvH8i60iX17algqNdPbEI+3M1/i9g8e5h8XaB4FkM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR84MB1383
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: v7PAYnGsGXqkUYmM3OMJ29BkA_ckIsa2
X-Proofpoint-GUID: v7PAYnGsGXqkUYmM3OMJ29BkA_ckIsa2
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_14,2024-06-27_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0
 clxscore=1031 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406270178

Hi,

This looks like a problem in "iproute2".  This was observed on a fresh inst=
all of Ubuntu 24.04, with Linux 6.8.0-36-generic.

NOTE: I first raised this in https://bugs.launchpad.net/ubuntu/+source/ipro=
ute2/+bug/2070412, then later found https://github.com/iproute2/iproute2/bl=
ob/main/README.devel.

* PROBLEM
Compare the outputs:

$ ip -6 route show dev enp0s9
2001:2:0:1000::/64 proto ra metric 1024 expires 65518sec pref medium
fe80::/64 proto kernel metric 256 pref medium

$ ip -6 route
2001:2:0:1000::/64 dev enp0s9 proto ra metric 1024 expires 65525sec pref me=
dium
fe80::/64 dev enp0s3 proto kernel metric 256 pref medium
fe80::/64 dev enp0s9 proto kernel metric 256 pref medium
default proto ra metric 1024 expires 589sec pref medium
 nexthop via fe80::200:10ff:fe10:1060 dev enp0s9 weight 1
 nexthop via fe80::200:10ff:fe10:1061 dev enp0s9 weight 1

The default route is associated with enp0s9, yet the first command above do=
es not show it.

FWIW, the two default route entries were created by two separate routers on=
 the network, each sending their RA.

* REPRODUCER
Statically Configure systemd-networkd with two route entries, similar to th=
e following:

$ networkctl cat 10-enp0s9.network
# /etc/systemd/network/10-enp0s9.network
[Match]
Name=3Denp0s9

[Link]
RequiredForOnline=3Dno

[Network]
Description=3D"Internal Network: Private VM-to-VM IPv6 interface"
DHCP=3Dno
LLDP=3Dno
EmitLLDP=3Dno


# /etc/systemd/network/10-enp0s9.network.d/address.conf
[Network]
Address=3D2001:2:0:1000:a00:27ff:fe5f:f72d/64


# /etc/systemd/network/10-enp0s9.network.d/route-1060.conf
[Route]
Gateway=3Dfe80::200:10ff:fe10:1060
GatewayOnLink=3Dtrue


# /etc/systemd/network/10-enp0s9.network.d/route-1061.conf
[Route]
Gateway=3Dfe80::200:10ff:fe10:1061
GatewayOnLink=3Dtrue



Now reload and reconfigure the interface and you will see two routes.

$ networkctl reload
$ networkctl reconfigure enp0s9
$ ip -6 r
$ ip -6 r show dev enp0s9 # the routes are not shown

Matt.


