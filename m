Return-Path: <netdev+bounces-128868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 777EC97C2A9
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 03:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F37801F21CAA
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 01:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C4212E48;
	Thu, 19 Sep 2024 01:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="MyfKdzkH"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9031CD1F
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 01:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.147.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726710234; cv=fail; b=t1wvX3qxPs2uzRvjMVeog/pZ5N2sXHhzsQKSPIq36dLlHKcvyWBLsrc9sra4RwbIwzfVYrA0tzLEFtsSxdNHul1cqHHT//PgdPBKBaUqOxkFi1ml+PHIwPoFFuaaIvBexWbvNehcff/Uo56XIxpjkTHMFnUcUn6E564WxdRDytM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726710234; c=relaxed/simple;
	bh=oCYZ+n0sqJhce3F4wK4shlxbhieAIkDVLi2qBF80X/s=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=o2I4NeC9IdDZfjq5AT/j01FfDHNxAcCYl1v6SdLFcCt0MwWbrPyC3NwqwnNqY5Awp42f3XGlzcezFURO/HQ6C4uE3npjlmY2wdE0R8LtWylJ367QCvXn5zIsDLM7td6P2ExX081RY7TJTW4VxzHDNWBXBQlhx14eTYyIN3LzmQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=MyfKdzkH; arc=fail smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48J02qRB018672
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 01:43:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from
	:to:subject:date:message-id:content-type
	:content-transfer-encoding:mime-version; s=pps0720; bh=SWuuA6HYH
	GTwXDzx+iZfXHiXE4Ylg3X8FKH4+lbt+UI=; b=MyfKdzkHzQ4x6rS8LZj4iuRFL
	7oafc+c29d8BVrhmyWu3WBPtbLO++EKTRL+FR/pXAJjGtrLbmMfruI+8eh3+Oivk
	voxYtB6sp0X68k8U8xkp+wnlAvpv33mnxt5NZBUTiQ2VDtOVvnyX40RGMKWFdh1X
	g2fss8/fBtX1T0XXZAerBaKPaMUvNB2EQLTXcXzQwIRWyu+cwF8sRKDcXqpk14qC
	MnwJb6fBy5/3hwk/6rZcu4H5R6kSyPyAJyl+WL3Anr2vuAcmeNIhkEXi4Tw/0l19
	RlwAFRhS5b7mXFi1tX9bSqhdSItxhtJy0glXVrcVUgexJkhcIqMyue4uCqCmA==
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 41r2q7jsju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 01:43:39 +0000 (GMT)
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id EADE0806B5E
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 01:43:38 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 18 Sep 2024 13:43:04 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Wed, 18 Sep 2024 13:43:02 -1200
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (192.58.206.35)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 18 Sep 2024 13:43:05 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t3Ci4zSfV3FwVA1Il4OyU6u6h+Q+j8b0RvQVgC6ylwr9aFTmjH+mMvaiftwHUadgVjvUaveV/ng9tfch1ES9HbB6pBuZRoZYsPe5hQYPlMQd3Wz9xgyTjT6f2ckPwZHeh416hd09/pATaVOaXj+28nEF1f6Z2n5FEIJkYfgL855nm7etn9pFXqqt8v6oDZSREe95aG3kRq03dUfOB4/rY8jNzjvB/8q8rVqDsToX0IZVuUKE0eUt5r0d7byrbT+2vf82gUN9a2p6n9bsmj9dOcswLF95eJ5K1rGvYXVUlBw2pJY29g577Hq1CssnL6gQNCLBMaO19XO4uQFIhwDejg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SWuuA6HYHGTwXDzx+iZfXHiXE4Ylg3X8FKH4+lbt+UI=;
 b=L51NuEEAc05If+0lDAb7oDxgS6QUUbO2BP/7pSt/HjvH75dZV6K6pff3bt/EO6VZxrU1+D4ghWFn9wNgH36jZpeA0DGceuxCgZRQTPvIpp36kKcgoPVtzmiJiOCjtZy0P4RsO8FEiZc3xkaUlh5PMoEOZf4IgZxbQgjZ/gUTVFo5GFYIWrq6/fupWfiIq/OVt7Z7TNALQJh94Sd/CDGCgGz2PAR4pVNL4gqulNG7KhsvtzLLo1nH+B0FNpc6jdLYwnbwyzR91/NQGTPMdon67ytMLxwU7yZu152W0njpkYIt0qYFa9DDD9zNXucoFgyI83/aOKKHBJBdz/wSOKbfvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:437::8)
 by PH7PR84MB3551.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:303::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.17; Thu, 19 Sep
 2024 01:43:03 +0000
Received: from SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::8cc2:658d:eae8:3d8d]) by SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::8cc2:658d:eae8:3d8d%5]) with mapi id 15.20.7982.012; Thu, 19 Sep 2024
 01:43:03 +0000
From: "Muggeridge, Matt" <matt.muggeridge2@hpe.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: [PATCH net-next] Netlink flag for creating IPv6 Default Routes
Thread-Topic: [PATCH net-next] Netlink flag for creating IPv6 Default Routes
Thread-Index: AdsKNUF2liaLoaBwThKLit56B1cdyQ==
Date: Thu, 19 Sep 2024 01:43:03 +0000
Message-ID: <SJ0PR84MB2088B1B93C75A4AAC5B90490D8632@SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR84MB2088:EE_|PH7PR84MB3551:EE_
x-ms-office365-filtering-correlation-id: ffed73d7-58db-4376-738e-08dcd84c66f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?zPU/d8WuqQaaRPw0s1xL4zKKjHUAMQWt8iDeSg28W09aqtLFPOlOJr87rXoQ?=
 =?us-ascii?Q?QtgQNRbifS7shFiMIMdH5YFEIHTeb54honsPC5E7Pu+61F0Op3M4986qK4LM?=
 =?us-ascii?Q?dPtje9WW8rRJ5DPn2fWLBrBVtT50w5q+Wdu4V15E6Fhh2doQCVamjk3Srm0N?=
 =?us-ascii?Q?6zWakgRksNVhRsA3L2EBXjVrQ1czajir1ZxDy4iLEiwG7z36N7rKH/yW+4ET?=
 =?us-ascii?Q?IT/vJ3sXc8MUs202+dcmqNOFkoCpnoN8agXua5ilMvO/0N0R7VsIqdXf6ahG?=
 =?us-ascii?Q?d3xqVuWSgeKKEz2nKlTyZPFMB8lWmIYHHvPQRFZhXLa0gY0x5LOfh5Lotn3H?=
 =?us-ascii?Q?EOYkvvU+YgPMytEVdeEuc7bVY5gx0Z7NirMfCx3TK3DZaAcpGhkcMI9UQr4U?=
 =?us-ascii?Q?n5Qy7Zm0n13eLFNDrwp+nQ4R0UYGnUBaqhdmkGL6bpYoexzWFgX2/P2DvLIm?=
 =?us-ascii?Q?yCZXNuiAqW3ke+AW7aah/8S+3IvgpsAFgn1WoEnnpU5yK1bSvfQGQbSC5SBi?=
 =?us-ascii?Q?e1exZx7NetJy2i95+nhckDyaPEkfhz5mmsS7F/wPH/wd8yhJJid7c/XUNOxU?=
 =?us-ascii?Q?4ItuZovpUjpQyhdU5UGKIAZTm1+PLr6eVODyTS81B9vCWTzNJ77Up+/V9xgM?=
 =?us-ascii?Q?rmRi8r9zdY/rOeCdtEBzuwntO2kVIDatmhcW5DFpJ+8HBRzCKzI314AMIpn7?=
 =?us-ascii?Q?wDwII4+kFVWFguqZrk+LWxLtqK8Z6lOIuyMJcir4hhxIOdYy9zsYy5IKuVcr?=
 =?us-ascii?Q?zMH6iWAgGaPEfIMTOFUWVmfW+krYKaPBLz6J6V4yszel/lb9y3UjQnAm1jA4?=
 =?us-ascii?Q?beVmTYhSq6C4No5x069UhLZBtJDghyIbrGhS0LUCJV/Tc4pQthMAusZO7KD7?=
 =?us-ascii?Q?i4rV/LfkUbkuxM88yhjZUqYSJicIm1WeynSdSnPD0/wm1SjJLUuNjE+qrpKG?=
 =?us-ascii?Q?wOZsK9Vv3ILAfIN0iF1K+DiXykMCaiRczYf0bbe7DuYGUeByMVLMMMk8lKxk?=
 =?us-ascii?Q?p/b091gx5iRrJ0EvdPot/ElmA2AcyYI4aAqFpJ1zGZjmSkKTDOuNl0PvnujU?=
 =?us-ascii?Q?AK2+2rrDr8WO5h+H9QCbpAI1/cdEyakytzwid8wINm+qDP6mQO8yMsxFxQbC?=
 =?us-ascii?Q?Ywhv8USIrpZ1zfmIATqjzNBX0ijNqGv8j3t+ds1DZxXF3LTADRIZo6o46vIO?=
 =?us-ascii?Q?/U0d+uFNggjltMUWpAyrpbFTJ10g11UD99upoDl1IAG4uqrFZZEs9MXD2/lo?=
 =?us-ascii?Q?3xWcXUaKapOrKeFMTWQFUrpzBLLZ8kVMkOSDRncQ2Bundbn2Ji2XKGOxyxMX?=
 =?us-ascii?Q?Rht+xJ/AO+J7hDAVeYcXJBpdzi/35/t/lOK+WZYDdMoIM2bsDYD5gpf2af7C?=
 =?us-ascii?Q?sQkXcIiKi5me7xzV3iQ7TbUR20xr1/Ks+xbVGd96XnXot3jVtQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gBOBGUXewJ9iAWzu6k4si5+/TxP4t152E1meQ894v/ZfeKhgwHRWbCj2cugz?=
 =?us-ascii?Q?HnzX1Rr8tGvmE7rO/x9sEkyKO/xGfntvkAyecYT//nX049NUc0xo7X+eVOZf?=
 =?us-ascii?Q?F3++qxJHuRM0j2E268pp3Eob3Lh2Om/x12FxKcrBJh2CW8nGvC3rson0Tn7C?=
 =?us-ascii?Q?z+bKO4iYSAEJlZHlyeA0hqMmLE9Lo/3Wuz6XCrMPU9Zp5khaC28ykpeMH3SZ?=
 =?us-ascii?Q?GfniZui776sLLX+BkDjTngo02AcdZwOonEejRYb/vk9BZFN0Cx2yt/nOuA1V?=
 =?us-ascii?Q?qZAwSJUlJB4K5vez8KWb02HjXEyCx7OLWkYZxcfrPIcFAxKTlYCS6y/Ygf4D?=
 =?us-ascii?Q?TSSYbZ5jVcv1e/wVvUFPKwj0iA1toI/NtNczE/J63PDAPI8jH3uwiKju83xp?=
 =?us-ascii?Q?q5o0iH5CNJynBw7CJNkwakPMymDraup/3OeQbQm+lISdKBUN8HiW0VcAOK3J?=
 =?us-ascii?Q?Fx6gVRNkSjtYpn3lUpc5/KDU6ZdBGt6pbiB0o9kdg0Zx1OM/qgDl0RwnQJnL?=
 =?us-ascii?Q?Z59aEFfu6pJ06p39xmvA/RFVpQYHvlu7n6gfCbXIeGqzvJUhrJi3JYNTw8Ck?=
 =?us-ascii?Q?T1oeINpLGAXVlPa28IyDDSk4yqnB8et7ycvXUf1IJhQtj8iBgzr2XjylF42A?=
 =?us-ascii?Q?N9SlwhWUJeOxeXQi63K2qGoozJFyQR/uu1jtprTwZP0y1rOIxtdXK02xNOv/?=
 =?us-ascii?Q?NklUy8jxzPT62DaUyeQ68S1bjZhEkGdROFRGbuRXQD/VFxvCKoDDGpG4Ug9E?=
 =?us-ascii?Q?/b/psfFzNEf0qpAj3Jtc2XFnQoQz5DT7QXKbRjB4M545X1z2RI8pfUFE9xsC?=
 =?us-ascii?Q?WdAFDX4jI0wt86d/O7OaiEbSU4O0REgJHsJ6qhmtOHVDWIAk4EFdFGsU+M53?=
 =?us-ascii?Q?j87LKPBktHBkXHFy/pIP7iUPrvMVHSTRubythq5Wc01EhPT7sYLKT6e8UTJu?=
 =?us-ascii?Q?K0Fr1CtYxSVMdhk4rQMPFuPSzBQdtreOABUqZ0H17T4pUVemSHnVZou+/9h1?=
 =?us-ascii?Q?a+pRgydTXbUHaoUY78s5NJAEfAwQtyOYsF+KRFg4z1x/scHC+ZeNO8cz2x1E?=
 =?us-ascii?Q?AuNejKDdlo1ZrNtozKNlRke1tNXnpD1hX8zp6oahAO/iLBwJmOCkAMCGrCJb?=
 =?us-ascii?Q?b17XCd1F4MpH96F9e5modUtwEg1zsbUbGMKTUccQyGuW6p5utiE0MzxSB0zq?=
 =?us-ascii?Q?m/TJzZbENr984qPZdlycINaiMUE8s1+M7yk2Xbiw+vGy5S/AjbArHi7/16kb?=
 =?us-ascii?Q?bVYRzuyOOQsY2GAj8flkYrwdNyzB7vm+qlNmZTbnDUY/Mq31NKDN3Kt9ZcMh?=
 =?us-ascii?Q?nBTt4qcr0mvtc7Kg9mwrJ5mEm//XOc5FEgv4W4DnUL8vrsPXpNE/0+INKQ6o?=
 =?us-ascii?Q?B3cyucunB2IhmeXm0wRfZpMqEZsGzUQ6D1VeAvgSiR2zOEllJAWL34m5w0UZ?=
 =?us-ascii?Q?A9oA22e4p4j+C/Kx39f3KHdATXejICmROMovsgq7Qzp4rY0bI9j6Xy9pBeHb?=
 =?us-ascii?Q?SYhlFwN+XP1j26wRWmCjZr+vOXYJi8025P/c1ybfyvhQpGPHXS0hVKhrzxfD?=
 =?us-ascii?Q?mwk9TiapWp76AKcUl2qMYveG9sjlMsjQtMjCtn+0?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ffed73d7-58db-4376-738e-08dcd84c66f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2024 01:43:03.5551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VVsBtDUkWlSemFGdpb56FqZ5Nb+4RSZMREnnctGpYthKvoZemHQE0LFqGlCSQ8hPetxC3UDUSswp7i6VzG1QKFUhQs2ovAcLk1NYBlQ0Yew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR84MB3551
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: CB-NLEEvkeWb9eYfICo0qxUczzTenue5
X-Proofpoint-ORIG-GUID: CB-NLEEvkeWb9eYfICo0qxUczzTenue5
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-18_14,2024-09-18_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 adultscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 clxscore=1011 mlxlogscore=999 spamscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2408220000 definitions=main-2409190010

From 95c6e5c898d3eef3e6b37e9b6e238bf6b65cc57b Mon Sep 17 00:00:00 2001
From: Matt Muggeridge <Matt.Muggeridge@hpe.com>
Date: Wed, 18 Sep 2024 21:29:31 -0400
Subject: [PATCH net-next] Netlink flag for creating IPv6 Default Routes

For IPv6, there is an issue where a netlink client is unable to create
default routes in the same manner as the kernel. This led to failures
when there are multiple default routers, as they were being coalesced
into a single ECMP route. When one of the ECMP default routers becomes
UNREACHABLE, it was still being selected as the nexthop.

When the kernel processes the RAs from multiple default routers, it sets
the fib6_flags: RTF_ADDRCONF | RTF_DEFAULT. The RTF_ADDRCONF flag is
checked by rt6_qualify_for_ecmp(), which returns false when ADDRCONF is
set. As such, the kernel creates separate default routes.

E.g. compare the routing tables when RAs are processed by the kernel
versus a netlink client (systemd-networkd in my case).

1) RA Processed by kernel (accept_ra =3D 2)
$ ip -6 route
2001:2:0:1000::/64 dev enp0s9 proto kernel metric 256 expires 65531sec pref=
 medium
fe80::/64 dev enp0s9 proto kernel metric 256 pref medium
default via fe80::200:10ff:fe10:1060 dev enp0s9 proto ra metric 1024 expire=
s 595sec hoplimit 64 pref medium
default via fe80::200:10ff:fe10:1061 dev enp0s9 proto ra metric 1024 expire=
s 596sec hoplimit 64 pref medium

2) RA Processed by netlink client (accept_ra =3D 0)
$ ip -6 route
2001:2:0:1000::/64 dev enp0s9 proto ra metric 1024 expires 65531sec pref me=
dium
fe80::/64 dev enp0s3 proto kernel metric 256 pref medium
fe80::/64 dev enp0s9 proto kernel metric 256 pref medium
default proto ra metric 1024 expires 595sec pref medium
	nexthop via fe80::200:10ff:fe10:1060 dev enp0s9 weight 1
	nexthop via fe80::200:10ff:fe10:1061 dev enp0s9 weight 1

IPv6 Netlink clients need a mechanism to identify a route as coming from
an RA. i.e. a netlink client needs a method to set the kernel flags:

    RTF_ADDRCONF | RTF_DEFAULT

This is needed when there are multiple default routers that each send
an RA. Setting the RTF_ADDRCONF flag ensures their fib entries do not
qualify for ECMP routes, see rt6_qualify_for_ecmp().

To achieve this, introduced a user-level flag RTM_F_RA_ROUTER that a
netlink client can pass to the kernel.

A Netlink user-level network manager, such as systemd-networkd, may set
the RTM_F_RA_ROUTER flag in the Netlink RTM_NEWROUTE rtmsg. When set,
the kernel sets RTF_RA_ROUTER in the fib6_config fc_flags. This causes a
default route to be created in the same way as if the kernel processed
the RA, via rt6add_dflt_router().

This is needed by user-level network managers, like systemd-networkd,
that prefer to do the RA processing themselves. ie. they disable the
kernel's RA processing by setting net.ipv6.conf.<intf>.accept_ra=3D0.

Without this flag, when there are mutliple default routers, the kernel
coalesces multiple default routes into an ECMP route. The ECMP route
ignores per-route REACHABILITY information. If one of the default
routers is unresponsive, with a Neighbor Cache entry of INCOMPLETE, then
it can still be selected as the nexthop for outgoing packets. This
results in an inability to communicate with remote hosts, even though
one of the default routers remains REACHABLE. This violates RFC4861
6.3.6 bullet 1.

Extract from RFC4861 6.3.6 bullet 1:
     1) Routers that are reachable or probably reachable (i.e., in any
        state other than INCOMPLETE) SHOULD be preferred over routers
        whose reachability is unknown or suspect (i.e., in the
        INCOMPLETE state, or for which no Neighbor Cache entry exists).
        Further implementation hints on default router selection when
        multiple equivalent routers are available are discussed in

This fixes the IPv6 Logo conformance test v6LC_2_2_11, and others that
test witth multiple default routers. Also see systemd issue #33470:
https://github.com/systemd/systemd/issues/33470.
---
 include/uapi/linux/rtnetlink.h | 1 +
 net/ipv6/route.c               | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/include/uapi/linux/rtnetlink.h b/include/uapi/linux/rtnetlink.=
h
index 3b687d20c9ed..9d80926316b3 100644
--- a/include/uapi/linux/rtnetlink.h
+++ b/include/uapi/linux/rtnetlink.h
@@ -336,6 +336,7 @@ enum rt_scope_t {
 #define RTM_F_FIB_MATCH	        0x2000	/* return full fib lookup match */
 #define RTM_F_OFFLOAD		0x4000	/* route is offloaded */
 #define RTM_F_TRAP		0x8000	/* route is trapping packets */
+#define RTM_F_RA_ROUTER		0x10000	/* route is a default route from RA */
 #define RTM_F_OFFLOAD_FAILED	0x20000000 /* route offload failed, this valu=
e
 					    * is chosen to avoid conflicts with
 					    * other flags defined in
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index b4251915585f..5b0c16422720 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -5055,6 +5055,9 @@ static int rtm_to_fib6_config(struct sk_buff *skb, st=
ruct nlmsghdr *nlh,
 	if (rtm->rtm_flags & RTM_F_CLONED)
 		cfg->fc_flags |=3D RTF_CACHE;
=20
+	if (rtm->rtm_flags & RTM_F_RA_ROUTER)
+		cfg->fc_flags |=3D RTF_RA_ROUTER;
+
 	cfg->fc_flags |=3D (rtm->rtm_flags & RTNH_F_ONLINK);
=20
 	if (tb[RTA_NH_ID]) {
--=20
2.35.3


