Return-Path: <netdev+bounces-108301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D333791EBB5
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 02:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53518282B24
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 00:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCED64D;
	Tue,  2 Jul 2024 00:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="HTcKCd+m"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203EE63B
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 00:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719879336; cv=fail; b=qQ0IfHJjAvwRv3qNb4V8jGxBo8uP9QDvPBJiFzaqCzto6Vnp9UCIg9a/IPhiO26BMVjHxy5iAA0WbEO6dLGG+LzOPXlqOWwu6cfbmkNqUp5Ov1Iy4GNwoqycRTesXcax3b20UhLu9DZW7B/vfU8aPx8VxdQcQGB3qWbvJYm6czI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719879336; c=relaxed/simple;
	bh=LWgx0RIkXAyzJhFJlgXhYmDBrUCLG6kOqqLr53BoIIQ=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=YrBNUBYgZz8HX7hBauky77zmS3Lvo+N49O3Yvu7htZbctpq6PLAadRMWT+4/+OSXpWRlNFgAUpQoj8YVeCYxwW7r+PrbGMEee/BOfX/eJfyqMm3w0DqzQEmHC8A0Q4EgarShYUCxzjJvDpWsJy2742fDZgyeYpvqmwK3QIqJ/kg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=HTcKCd+m; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 461M3UA0030630
	for <netdev@vger.kernel.org>; Tue, 2 Jul 2024 00:15:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from
	:to:subject:date:message-id:content-type
	:content-transfer-encoding:mime-version; s=pps0720; bh=GfIFm6lpi
	K4i1HzopHVNtnj2pcMlQa1/OjS7QR2wWww=; b=HTcKCd+m9if5w3JDCiZacLd5w
	9ynEpMTI9KsJPB+rVedDxoJq2/4vwCuiVsjCOrZIBXEUv573UI1w6swXF2QDYpYt
	Jp65K3Bs+InKpiq523z65nkTTgvSkb/qde39enRvO8ch9rN1JJF/IFnVv62juKCV
	VO0WWr3Ni4XkHPF30PTW5KFbvJ3GQ0dDaiiXgxKGnRJwZMKaV0DQodibIfGdp4a5
	jQlbfTYOpzPDSYatdecOZ2g5sEDWYCQm8tWUXZ+x77cuRgfQo5AV/rlDtsoJDmKu
	ROjQQcY8epnSS/+Yr2SUhKKESOIKJXu4s/GJZRKDk0fLpk30wNfoSMLvW/8SQ==
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 403y8naw7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 02 Jul 2024 00:15:28 +0000 (GMT)
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 61A00147A9
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 00:15:28 +0000 (UTC)
Received: from p1wg14926.americas.hpqcorp.net (10.119.18.115) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 1 Jul 2024 12:15:02 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Mon, 1 Jul 2024 12:15:02 -1200
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (192.58.206.35)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 1 Jul 2024 12:15:02 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBYOIfeeggj83e60g19RZ7QVSuTzMES2vtUpAkIRti8mDeSrGTQiRGoX1tkcDUxdZR9cLdBeAZLMgKrbp/Vh8+raBSDLyZ3xslb+FMjO2R+aSrnMbc+vr+L2sPks4yLmgW2hH2UHxK+BeDxKQWWuxonm7gwPIsnGh1SCyk1BaGBzyefCzjqepplOX9pGiBzCMnRWRkitcHGie68dH2r6q44IDiHBwwXYOLKXLvr9MxyOs+M0Tz8mWJXYHbvpPt0FRBmvf3w3SXVqOC/MfwD4yGpr5tsZ6ZjATqqrsT4g4eM8n9q34qIwruo95Ne3XHncAjlIkMx9f2Q2BluEjJASlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GfIFm6lpiK4i1HzopHVNtnj2pcMlQa1/OjS7QR2wWww=;
 b=XCD1zoKKcAqdE8JW5r7ssViyPztspTki/Yu87nD2LvzRxA0WXf0H27CR0RafWy1yGk7kgg89JJAL92JO4eH+WSmj8/ohoDEhUEOK8fq8d33LV61Ee7WC9xN0jRD9FEBu+eWcj2RkpOMNZ+vDbK2XvYo/h9f7FuEWW+zNOUYuZomd9nDNfJtwXVNzGFjcVvTMKovOr2Ar7uYJIpV3j1r16uuRSwndJj8Q157RcJqXrljXfJm6cvB0FiAxM1rV5rVw8H5abbulI/7dG8PMudtZBNuHGCo+D0iz0aMwxr/xs2ffG6HkD/mhVhvBnKfAtULpCsu3iHkhxR1Dqs89QmrzEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:437::8)
 by MN0PR84MB3963.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:208:4bf::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Tue, 2 Jul
 2024 00:15:00 +0000
Received: from SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::8cc2:658d:eae8:3d8d]) by SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::8cc2:658d:eae8:3d8d%5]) with mapi id 15.20.7719.028; Tue, 2 Jul 2024
 00:15:00 +0000
From: "Muggeridge, Matt" <matt.muggeridge2@hpe.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: ip route expiry time goes negative
Thread-Topic: ip route expiry time goes negative
Thread-Index: AdrME5EbAyydEhA6T2ucdQxdm19k+A==
Date: Tue, 2 Jul 2024 00:14:59 +0000
Message-ID: <SJ0PR84MB20885CF60E04730DDB30358CD8DC2@SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR84MB2088:EE_|MN0PR84MB3963:EE_
x-ms-office365-filtering-correlation-id: b5e504c5-b853-467f-82c6-08dc9a2c0311
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?IAYxqZfagjYE3tqP3NxnGBoEIiEjoTsV5A6SEoe0nrlsL/r3bq7mzEIzQGE6?=
 =?us-ascii?Q?G36Kf878TcR4glvZt/zSTT/QgXynCEm2x4Z+lK8/bJa5oVrGDrjXue3la/xM?=
 =?us-ascii?Q?IwZkr/5BVRJAj00r87iIFRHfbYZ+LZXR2v6HBFoL/MpP7iwYQLe5EGLivCWQ?=
 =?us-ascii?Q?n7RE1aj4DLf+VKzvHfXON1n/InVBZeHLjepQWwAHxg+8PoSxm3VvPDQ1jvLK?=
 =?us-ascii?Q?jglQqxhuxM4b8vHEKtZTDjIKsrOhuiie/uhTbhQRTj6dNKWYin/p1FMnhdJ2?=
 =?us-ascii?Q?1K5/3djGIzMg8ASSts4PHYpTpQsY22rq7fQZzCIBAbUJLOb3z69YK0FlXjLc?=
 =?us-ascii?Q?jJtNz+spsbqdG3XD0IYLZYaoibROi/ZjnAi5acV47DvUWq/5CcPOrIjk9sK7?=
 =?us-ascii?Q?StU14WBBJmWs3fnNJGNN+T33Ygq0yku90ORtP170Mz+pm6TG+3fIav1uBls1?=
 =?us-ascii?Q?wOf4Q6p/p3byUBmfF7Sbfi5hsE9fG7dwubycVQ9njR7a0ijASiq4Dg+Tuc3m?=
 =?us-ascii?Q?wcFSfUg6hXk2l7nwrIs1bzYiRe5XQlXPfZr3pRD9GbVbDCKjY1sFqBNa9ZuC?=
 =?us-ascii?Q?Kcseq1f59lCLJx/WwWiwuZMFOmdSFfpLvSv8X8NsbL0o5zDWggPXEAXjV6kw?=
 =?us-ascii?Q?ZBIaHnIUJ/Kbuwq4DXZbktVRXKirFVddwrMtC7xPZoIsyVYgS5WYiDuJ5VjK?=
 =?us-ascii?Q?oXuQoq18Q+Td+X1UBmILAiHeMiiEaa31YTMOQqlt2TgHSK8LdAS3duD+2cZJ?=
 =?us-ascii?Q?ek4cQHq2QpLedPvb1ZrhLxap7mZP82zpCX6LTFzZhIDgHZJs2v0AaAdIHLN8?=
 =?us-ascii?Q?uqDNXnkBF8aKCD1nBvipMPZXFlUCshyFVJXdUpZBKs7HRxi9NwgKveY9Qw62?=
 =?us-ascii?Q?OLyRMDmghPwoNd2T75yIkYI8fiPSO11tdtQ/gF6gwgg3sLwd/rTgukI6RxB3?=
 =?us-ascii?Q?w0DJQyhuHOKxfGDJHuteSlaELJR1xZpGeWdjFq14lIR42KhJ1jvUz57F2h07?=
 =?us-ascii?Q?A4PYU8HgCsgTG+tqxqbFqm4jef718uWnaNER3otY57Kg5VDYE8EUxYzgKLhU?=
 =?us-ascii?Q?r/UO7k7NceQHGl0G6ORoJsiYGjdBIUtfe9d6RkBK6Q1XrjSJi7E+x7VgpFOC?=
 =?us-ascii?Q?4+acEO8u9uQ8eIHqu9vlyCZu6ptkALBafpCMPJPOexhvcPjSwf08mdbEcJrs?=
 =?us-ascii?Q?2b3FTu006180x87Oe8Ap+YITHUlkNGiRH9nmFkNCvXPXj1B/JGXystXiLnZh?=
 =?us-ascii?Q?QSpbONedtBD46f1SbV6GFSLm1653rXyhDP+JRyGzzbkgBPzDqB3YIcf5kUGJ?=
 =?us-ascii?Q?f9qjnC0gvp/ZEp2SIsflXR1hzaJDLCAnnGK9RlAIycub3tYHG5bBl7EBWz+X?=
 =?us-ascii?Q?fptzusx3CIAFmj8JhjB6RMc5RWM06BK6RMNxWaKeRJ+rEBtMMA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8T8pqtxb6Dr32Kev5hmJ4VCWRYdvoTRVhRLdJxCTjwnr++dqalBPBl9IoVv5?=
 =?us-ascii?Q?WhUyAs2Hh0f45Qy03GZGBD3ZyoKXLKXe+XzVntT9XhCELB/0OFQWK7fesiQz?=
 =?us-ascii?Q?PTXA7ITW0LwJnV5i+yZOzw+Qwwk+rGa/JlQUJMNGLxSaWnjNGUjffRa6kHqW?=
 =?us-ascii?Q?i8rih+p8n86A+OICJT8s6l/ael3pkLdfYlIPBftPP15H+BDqZi6QL6gWVIV/?=
 =?us-ascii?Q?JlVf2qZwUbKc7WxvgW8EqgEe8Rz33TtunRw0FA5DD75IDG9KrQ4HGQpBTuKg?=
 =?us-ascii?Q?LP+vMCIVrbtnKhgG5JE87D3oYpqr84q+TJEQOfxCD4JQVsvij0Ji9SwbCYwS?=
 =?us-ascii?Q?6VdZi7Mhx6qSDAeoI/bJDFVkAZ9CmXj0WD6jRFbo2WjIzd8SKIMejKq3Vicb?=
 =?us-ascii?Q?tpOVuJMuUIGMsrOo6oFbuIfZNP0drA+sLaaJ2VNpQIpSVDsQan5Iw0a4Us7F?=
 =?us-ascii?Q?Au3XAnwhNQz3SSsI9ar6CzBJqef0qCR2+YPfCBfvNSK/5AOQ47te+KLtblNi?=
 =?us-ascii?Q?Ea2lNTgeVuYqSEA0LJjjDaFyLD7/3/5m+onO5hmi5OhVd0X41jNU8qMtRAGL?=
 =?us-ascii?Q?0bmUlMWVeiJ7iZ/amQEfMZre3GYp0Ik5dorYRKQ3OH5zA9onWBmYZ0lnTywS?=
 =?us-ascii?Q?+JH3i4ROTY3xflWQLZMHcSe63yvbQzzOrtEJKLw3+2zhN5Nb3jLoNArXWrHC?=
 =?us-ascii?Q?cgRcJDczLPy7PqSBGLWeCpuGrP46zn+EK9MoVT4gw7uL6gK65NqeYwAikbxu?=
 =?us-ascii?Q?HXTBtbUBopIoSJfxhXxh1FcCn9XdM8aif7ZP47ECIeflX+kZVlVqDV5V0OGL?=
 =?us-ascii?Q?IjnWgXZMV6+Y9Q6GBdjX2UojRUe4BI31Rn+Rp9X72l44BF9P3IBSQ/Nt2ib/?=
 =?us-ascii?Q?Q+1IsytFsl1gck86v5FG9ukLtkLNkXdZmo78EYD8gcka1VXcbSml8wz8V5qm?=
 =?us-ascii?Q?K6Ikpq5tcZpQPZNnUkyE5xRSvfAMe0vTePrnf2PEH7++AI+4KAdtbJEdbhOb?=
 =?us-ascii?Q?x+i7qz3yw/Y7J1yc5XnFZagO9uQuzoO224peijwPNdMd0QAa4lGilCdTSdOf?=
 =?us-ascii?Q?Bf3X1Pok3kd9EuPW5L0tfJNB1X6J8w/1KlSxVV284urJjjOZxMv8X19c4sfz?=
 =?us-ascii?Q?CQlkT5mZfK74zNTBkQlqqEuB+uPOtEgM6YLJz8apVN+BtSGZM6VpfbNuv5HF?=
 =?us-ascii?Q?vRgG3HMa64y56hNuaPCiCAQwsSxxZNpKe/NkmoXRu4Qv53TAJ0ikSv98Srlh?=
 =?us-ascii?Q?2L2SSJ/TNM0AHkgT+178KPcOVpaXOyKBwFL0auCBRqr9n1TIgcb0Mc1vnyY2?=
 =?us-ascii?Q?QD47uFvzFugYGqFIoSWp9JOOnMsIqNPDUxdNuCq3GbzTgSKCUIhoPbLLntSF?=
 =?us-ascii?Q?VKZWhIVt6KqvgmsvM6gwo+pUdST7riWsIu2MURO6CnQ0dC9Sdbc890LMHr6Q?=
 =?us-ascii?Q?Kide1+7/+SJ71yBeNxGuRLWXvHTAZYD3A9SxPd4xY7bHFa8ltSYysZLFW9Ee?=
 =?us-ascii?Q?KqLnDHsRByuss8/C3Lw+LFb3fiDjxe0B2JnKORbGEGrtBu4nyjV3PU/pgWWD?=
 =?us-ascii?Q?InadhgjrBI2A4bi0xheIuWhxAleuR44wWYaQK7hN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b5e504c5-b853-467f-82c6-08dc9a2c0311
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 00:15:00.0152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X+FLxAQJHRTyXXPBEtSzI71UZgEeel+8wdWvfPxeOJ2jxaTNkpBypGfsq+GPcFwJf5fP89MHd3EyOX8hPG+LUR5F0K67RA+2yCj1MZnPxiQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR84MB3963
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: szLlWxNZDbOxhU7BhoYOQ15pEJT2X58o
X-Proofpoint-GUID: szLlWxNZDbOxhU7BhoYOQ15pEJT2X58o
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_22,2024-07-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxscore=0 adultscore=0 malwarescore=0 clxscore=1031 lowpriorityscore=0
 impostorscore=0 suspectscore=0 spamscore=0 mlxlogscore=426
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407010180

This seems to only be a display problem, though I don't know if it's the
kernel or iproute2 that needs attention here...

$ ip -6 route add 2001:789::/64 dev eth1 expires 5
$ watch ip -6 route show dev eth1
Every 2.0s: ip -6 route show dev enp0s9  myhost: Tue Jul  2 10:07:33 2024

2001:2:0:1000::/64 proto ra metric 2048 pref medium
2001:789::/64 metric 1024 expires -15sec pref medium <<< negative expiry!
fe80::/64 proto kernel metric 256 pref medium

Notice the -15sec expiration time.

The route really does become unavailable when it reaches zero, so this
seems to be a display problem only, as can be demonstrated with:

$ watch ip -6 route get 2001:789::1

After 5s, the route becomes UNREACHABLE.

Matt.


