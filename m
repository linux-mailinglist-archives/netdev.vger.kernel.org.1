Return-Path: <netdev+bounces-234262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B943C1E500
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 04:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCAC53AD08B
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 03:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF68293C4E;
	Thu, 30 Oct 2025 03:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="M3Y4eYZM"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E36285406
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 03:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761796701; cv=fail; b=DNaImK8l+sfh+dAS0kBjitEOUcGDOmEVgQM9WJosEEph7LXm3oy0b2oylqCQIU130FWQ4JfGYyiMOGo1F53blQmJq7NaAa0HT89wrqWkrt//7ENeqFhd8j/gtPhYkurrojE3+3e6nDxfjoqqbuj3YIAAJxfLLy5ostrwvX4BAAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761796701; c=relaxed/simple;
	bh=qx8xVCpYg3O+I4ijyltlsbrsTxrqKZnuPUCVfNG8NmI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=a8Y7rrC7SqpWM4fJraFjuXGTKAi+/QTrukd5aIOk5xXorwEv/eHECseOeknk8Jkrt1giJ1Dqit9b97TfteQlwevnKyl7zA3T4fgf4T+GI/e9tHBZsTc0tT68156meJI4DwpX8Rf+JwbFLc/L6tltJk4IHv5Io/kv5mK2Y1w2RyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=M3Y4eYZM; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59U00I4C4123342;
	Wed, 29 Oct 2025 20:58:18 -0700
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11021142.outbound.protection.outlook.com [52.101.52.142])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4a3nru2sn6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 29 Oct 2025 20:58:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KOSbl+jmrlJ+yt25kdrgTGb8WjvdE1T5IzDGH4wuGLFj7R//Abnc83uPtl4dxbzTiXrQc4joki+T64OWestH6PdU6EMwPBKFtrhlJLj4YAeBxzTaWr5SUjs2jbbGxW6nr4stQi1n0daoAtUfvd2MbOqG8Lzx8nPX3mT4WWWRQDIdS50oqYYyMw/UwVmQXWypbu2R6/VWzUvat17fLUckKpELec/iTQm/f0qQlkTToQHzpugMKTlocFyV+bre+x6JzNV2sQZLy6oC5V8Q3K8i8SHDOYwol6GAUyDpWV6gVnewiESZg1TYSx+4sj3r0UmctMZGjVFwGJhjuunUEhdNfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DVJEFUO465h15OoNubu5wBWkDuHCz3YQxzaaSDbOcOk=;
 b=zTjX1Z4B/ncMWl50ss5R8mhQmQkP/zJ3Y9awvvgiqE5dzB0jFjeOvPGi8xOYWoEUXo2AlaUjUL9wNEOEHcCAXO9LRfbtK8CuWgQ2b0lm/Y5Wwi+fxEfY7rCkSZyU1Mrw9K10tVSqttccMc20Qnj0jqXYTtWsKgTE1s0Pie6UiM2R6JJ33gWszfQZM6l/dFnjdaeE5KFjW1Vd6j+zP9x/P1TYf4GCw6Sf28SdquW/yUSUqY/lvWMmQQBnIEN32koJS1LcDRgSWr4lMvNvVClYoU83o1d9HA0XCIbOLztVCdLavNSO5NrNqY9GyFCQ+HZv5iPh9meXvrdRw6MzrUajLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVJEFUO465h15OoNubu5wBWkDuHCz3YQxzaaSDbOcOk=;
 b=M3Y4eYZMt4i9px307Y5msARQnvxZTfX2OET9edLzjyEK3SgNhAEAjBvkSH2qD1c+bZFBSEUPIpyE5er/UA8y8geW5KWjZCJAV4wvRTaaCvg1RGdT7NSMSgQzZY616XRPxBOZWQkLh14URGye4DamZ7ZRHWzihorcHbnDfBv8WSc=
Received: from MN0PR18MB5847.namprd18.prod.outlook.com (2603:10b6:208:4c4::12)
 by SA1PR18MB6036.namprd18.prod.outlook.com (2603:10b6:806:3de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Thu, 30 Oct
 2025 03:58:13 +0000
Received: from MN0PR18MB5847.namprd18.prod.outlook.com
 ([fe80::15ae:f628:1ae0:65c0]) by MN0PR18MB5847.namprd18.prod.outlook.com
 ([fe80::15ae:f628:1ae0:65c0%5]) with mapi id 15.20.9253.017; Thu, 30 Oct 2025
 03:58:13 +0000
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "donald.hunter@gmail.com" <donald.hunter@gmail.com>
Subject: ynl with nftables.yaml 
Thread-Topic: ynl with nftables.yaml 
Thread-Index: AdxJUTbPPYqs0Vh+SH26mK43xU4J9w==
Date: Thu, 30 Oct 2025 03:58:12 +0000
Message-ID:
 <MN0PR18MB58472AF35605FF6FC96EE6DDD3FBA@MN0PR18MB5847.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR18MB5847:EE_|SA1PR18MB6036:EE_
x-ms-office365-filtering-correlation-id: cdd255e5-352d-4604-7ad0-08de17688c4d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?bK2cdJRqiK81c8I20bJOsC/luIXjjUwJkacFFVcy0GLM8Sy+zkxdclrmDe19?=
 =?us-ascii?Q?SpTcuJRfmevT7KeDAiI9abpedMHFEBd5lxNWTUWhpJPC28pmaRi8rfmAxq5+?=
 =?us-ascii?Q?5aPkeX8btHdpx9XHFvsjESHKhdVUAm1lblChtmB9vy4TjFEZTGfqYsOUGh/3?=
 =?us-ascii?Q?pDzTkVQH55/ykXif1grrqHiJKU/CmJbLY1tNjoVf6725YwchwevIsPk98r5i?=
 =?us-ascii?Q?vwHDKgQTs7ZxgxsjUemwYPm7CGYJEfxt0jGOckOYy4dUZWs8selYlkpgq5gI?=
 =?us-ascii?Q?LgP91xbaAeDkEKtaVJZaR7YR8SCLNtJCzBBXmS54OfaJR8sp6eRv2J5vexxQ?=
 =?us-ascii?Q?Ks2zWt7diVp1oHEI7WbgVoXgDj78jPiStOwq6phZauzCedYW7OWnhePZF3yf?=
 =?us-ascii?Q?PEHsApXiEFi/SyptiEbyWmftAF6K7Gh1ZKnRO1AqtPFBBgVs3bKOou6fP46u?=
 =?us-ascii?Q?b6jwZenEY0OyHhr3aQlXgkzfFLDnbnj0Fbb6omHHY8TxXqVf6D/ufWau9IJm?=
 =?us-ascii?Q?jX78UP/S+N2co/v979gfUasnOfvJdShOFju2J3SlLEssuiM6arpaqJzcTCAY?=
 =?us-ascii?Q?6QDUGQuur4mxnQatm6O5UvMnlgvwky5eMvA79k0LCw4aicpwqpLbnIIPrTZe?=
 =?us-ascii?Q?REHJi+XMJxf9+ymxSf4MW47FQ3X+JCBf90APr/hZb9bpGRNHsQliQQ18GX4J?=
 =?us-ascii?Q?5oNHZl2XHk1/RfcomUQJeVKpM6Iura6fH+bULitdksKiCr+mhVVkuuipg1Sc?=
 =?us-ascii?Q?ckSHzk1qkUsHK7UnaRDOa+hrt4vN3vhve2T7RSaVlEUAlgvEsn9CtdewOTWS?=
 =?us-ascii?Q?AI1g62K5dkeNysEEZeoL6qUZ88obEe7uMdLxAFLERyO7+PnYeg9weCKBT3Xm?=
 =?us-ascii?Q?n4t2MtsJYnrm1vD/QiSQ/qvjyqTjqGrd4PD7sA+bW1FqVPF5Bbx+okT64tmI?=
 =?us-ascii?Q?5jwdiOj2tuXFE9vH6QkPtYzuKG3XQqUTBXZBDB8fWEyZ2hO2Su3haZiIV9p0?=
 =?us-ascii?Q?GlUiJPTgHae3Krbnt98hOt2ak83A+ZqR8HICbvAG8wsux63MYHkBrqUwLB+l?=
 =?us-ascii?Q?ebcnAhx/9OszYRx2PcU//bHF+DSDBoqwS30WaDNJ5Kj4ctSHbpBEjE6a11ij?=
 =?us-ascii?Q?fOVRytAJcAkJp7hrkFeaodX1Ep8fqRVlBaduJU7YOxv9DSxfitPmVeLwrbjO?=
 =?us-ascii?Q?ZzYhngHHI8kA2lznyyJz+C7xIg8l2EKlYs4HGMq9W8WnX7IWGdp8pKgrj61C?=
 =?us-ascii?Q?TcxTuMeafgCfFZ3dJytYFRT+5S+nzyyVAZEIzOuejcIc8Oc6WI+GCCs1ra6a?=
 =?us-ascii?Q?1nY9h1Z4BO1v5C8LxuO0qLyoWH/PfKCPQ/ZS4WFTQoxGnrNzLr6x9bx0mz1O?=
 =?us-ascii?Q?1U12Drk8itIPo558/e02Hyp0qyAkVq2U1FuWnypzOfDwv9141/zkFxchf01W?=
 =?us-ascii?Q?MM8/ng47Co7ZTAk1J4y7JD0DahZpfegw3FcrOy10kIN6rS0htXg+Et6Ikjka?=
 =?us-ascii?Q?2MkZ45/pxfkc79M6eZZjH8/1TNMxvslA3RuU?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR18MB5847.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?VdH3RdVy0652ZXLLK0II3nuv/gdAut5mzoQcadVjR2zV/YJWa4rwFNCctq1O?=
 =?us-ascii?Q?yIMz6shMGjopMI/sE3/tfqIMwqUYWZ5eqwJ/z3T0smKtVqYP4lkDRzkGftfP?=
 =?us-ascii?Q?aUxHJZIuSCvp0yenjsQJiYfq0Pf3Dfdm5P8zBRfuyEAJf/6VSDv1mr67Fifz?=
 =?us-ascii?Q?gAVs3P3xKxVEdUoF2xFrBNv5+VuPGj9YpKgz7itCSAm8xjp2qtYIaYyecigK?=
 =?us-ascii?Q?ERytbObfaU1p3nQJRgTl3xsBnBKLWX4gkBWuK0pqrs6cKAPdcttJ9lq0knpx?=
 =?us-ascii?Q?M9yGc4uTBMCAF9F4t/jKnirDaJ/DY44Cnd09gMoCKa7cm/5H7RY3/yx7Y2Kv?=
 =?us-ascii?Q?U9RBttpCaYlMj7ElJo7Pp9wJWq2Q1M2i0UiyBjUs7wuAajV+Wkd3XquYma2L?=
 =?us-ascii?Q?m95DgPNb0q87Lw2v8ySv/9Ab4v4m7AFzhyzL/3va/YByq0LYRZkz98DeF+/6?=
 =?us-ascii?Q?kTqk0VFOUg+eoYo+Fn6gamrY3ZHzhmzeX7mWqxndn+BPY6RK19hZonQyLoTG?=
 =?us-ascii?Q?QLqUozzHi2UToxL7wsEcw/TrI1Dnhtrw/z4LlhRtvhE9x9KTgjsen5ilxvSP?=
 =?us-ascii?Q?w7ObX8VPfDmPsmLNUm7H3ReAcwe55UISKEyGbsWX49yPdY4+6udu1J5iarlP?=
 =?us-ascii?Q?y8YT7IlH88lGQykoGUH3mcMGGUR8S4slunROAXzSyaqPGIL2tyhMhpE/c8+8?=
 =?us-ascii?Q?oQicopVKzVQG22u86p/z+APmu3IpMV0+Dmb9icoccluENNyFFQgJv00pVA+V?=
 =?us-ascii?Q?qeAwCTrKT+ZnAYaDQZDPvBy1T5xj9Jm9L2+6jaI8AO/v7chLRj/cgL7b8KjV?=
 =?us-ascii?Q?U4uO6XvQvAT67E9KFq6mkfh2yjlPOloXTxkr2d/Q4J1hqKc5cqli/IzQfwQ7?=
 =?us-ascii?Q?f9fJJyASaCPID6Os9GUuMdgRscgO4VKbK/OgtyissSLzj7ww4hm2cvGcYpfR?=
 =?us-ascii?Q?Es0/dHQR4A4JH976ufn/VJtEx1KaPTRa6K9eOUqfAEjGwSWPt4KoFOWLKw/F?=
 =?us-ascii?Q?cp18YEyC6leX+foSMHn4NzYnors4hKX7JYzm5ueke/gv9fX8VEw1WCq9l+wn?=
 =?us-ascii?Q?yQQpA0eSe+mcdm7EZ3yelcc6o+x7Bq+UE+Lu7d7wg8RST343AyEFcWy3aIzl?=
 =?us-ascii?Q?s0TcU0IhppkcpRIlXtTZjkO57KC+AijvlwwUftoNyZLdzUB69TRWiGOCOIKW?=
 =?us-ascii?Q?jFXEEJfjOU1kswktuTxcQNSzJnrq088d7grf9SdXc6EFFUkb88i9pTg0yKHA?=
 =?us-ascii?Q?4qx0P0mc/8x0npe8e355rVCLNhLmvm53q+DXew9QQ+hR051mxU4V1hH4TPm9?=
 =?us-ascii?Q?JZR9liqNqNa8aVgBRo/rVpQ0+NIWav6HNlObIpxyd0yszKpuoBDuU2NokEsK?=
 =?us-ascii?Q?2ehtI0m3UsqdhPF5o37n64fAMPklXLxAJ5Ws3hq2oXAnrnQzX9fHIuND6KWO?=
 =?us-ascii?Q?nHQxEQLZ+l9GRsed80rTfuk87sraGJxoWRpox9N4Ec6gpTi7HI9s/EY05ZfG?=
 =?us-ascii?Q?YBzDz0Vl+YNpuE+i3O9H8cHA5ERIcLEcFdRcdUWIN/Wh4lrFHfRvC8BrH238?=
 =?us-ascii?Q?ShFB/vHt8crN4ZTevIfj3Kr1PBGpvrumZ6nnnOzl?=
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
X-MS-Exchange-CrossTenant-AuthSource: MN0PR18MB5847.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdd255e5-352d-4604-7ad0-08de17688c4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2025 03:58:13.0593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MD0G5x6pe//uzgrtNIJKLW6dmO+IzSA2F8lD47NktYdUTTu8fe91Sznwn9bqyd+8TAMh2QfU5dMRwbmBrT1xBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB6036
X-Authority-Analysis: v=2.4 cv=XuH3+FF9 c=1 sm=1 tr=0 ts=6902e25a cx=c_pps
 a=QL+v0huyu2hsXc0KYGjVrw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=07d9gI8wAAAA:8 a=NEAV23lmAAAA:8 a=DQUO3vvkAAAA:8 a=b8q15n7n-p8k0vGq2-IA:9
 a=CjuIK1q_8ugA:10 a=e2CUPOnPG4QKp8I52DXD:22 a=g3ZX12hWzXE4PBjzIDYh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDAyOSBTYWx0ZWRfX9AFCOzqOLOMx
 xevqRJcJVuYuTVvXmr/wzJpjpweHdo4aiRNwws/KrVC7w3F8Pyhv9n+//AquYZAltk5EQXNHpPe
 CbzEXCKueBNXGGux+dU08g9/tTrzoER3RjwE8O8gQKrGD8zUJ49cajJ5gKDGAXoxPnL4tO3TCyx
 oyJGeCv8wX9pobD0RCRB8m/2NLPIbUXqAYj/lL4rDGrCv+RsngiA647FIE2faJaZwJfk3TLXzax
 3E55h4cl59HobdyHZAwl18Ar5XGuuINCL2uCw3dwV8vgNKPDQxXgpEkrsY7HohrGn7+V7y8Z2Wf
 cTOQSs2XzXMT9rpMigM5pNPzCWUgpuXMEnftAevbrInCfpO7Gd6p/ILbZXzxk02T5JDlz8O8Pe9
 FMwfa4olRRoTYyG34YZU5bE4yPj+Iw==
X-Proofpoint-GUID: TobR-p0rWVyHgaITaW0dkDU0ESl-3ob1
X-Proofpoint-ORIG-GUID: TobR-p0rWVyHgaITaW0dkDU0ESl-3ob1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_01,2025-10-29_03,2025-10-01_01

Hi List,


When I get below error, when I execute the example command mentioned in htt=
ps://lwn.net/Articles/970364/ . =20


####################
root@localhost:~/linux# ./tools/net/ynl/pyynl/cli.py  --spec Documentation/=
netlink/specs/nftables.yaml  --multi batch-begin '{"res-id": 10}'  --multi =
newtable '{"name": "test", "nfgen-family": 1}'  --multi newchain '{"name": =
"chain", "table": "test", "nfgen-family": 1}'  --multi batch-end '{"res-id"=
: 10}'
Traceback (most recent call last):
  File "/root/linux/./tools/net/ynl/pyynl/cli.py", line 163, in <module>
    main()
    ~~~~^^
  File "/root/linux/./tools/net/ynl/pyynl/cli.py", line 123, in main
    ynl =3D YnlFamily(spec, args.schema, args.process_unknown,
                    recv_size=3Dargs.dbg_small_recv)
  File "/root/linux/tools/net/ynl/pyynl/lib/ynl.py", line 468, in __init__
    super().__init__(def_path, schema)
    ~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^
  File "/root/linux/tools/net/ynl/pyynl/lib/nlspec.py", line 462, in __init=
__
    jsonschema.validate(self.yaml, schema)
    ~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.13/site-packages/jsonschema/validators.py", =
line 1332, in validate
    raise error
jsonschema.exceptions.ValidationError: 'set id' does not match '^[0-9a-z-]+=
$'

Failed validating 'pattern' in schema['properties']['attribute-sets']['item=
s']['properties']['attributes']['items']['properties']['name']:
    {'type': 'string', 'pattern': '^[0-9a-z-]+$'}

On instance['attribute-sets'][34]['attributes'][1]['name']:
    'set id'
########################




root@localhost:~/linux# pip show jsonschema
WARNING: The directory '/root/.cache/pip' or its parent directory is not ow=
ned or is not writable by the current user. The cache has been disabled. Ch=
eck the permissions and owner of that directory. If executing pip with sudo=
, you should use sudo's -H flag.
Name: jsonschema
Version: 4.25.1
Summary: An implementation of JSON Schema validation for Python
Home-page: https://github.com/python-jsonschema/jsonschema
Author:
Author-email: Julian Berman <Julian+jsonschema@GrayVines.com>
License-Expression: MIT
Location: /usr/local/lib/python3.13/site-packages
Requires: attrs, jsonschema-specifications, referencing, rpds-py
Required-by:


root@localhost:~/linux# python3 -V
Python 3.13.9






