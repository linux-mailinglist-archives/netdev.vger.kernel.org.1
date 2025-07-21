Return-Path: <netdev+bounces-208673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C30BBB0CAF2
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 21:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 754381AA7EDA
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 19:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B78222DFB6;
	Mon, 21 Jul 2025 19:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T8qeUudL"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1BB202F8B
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 19:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753125814; cv=fail; b=slunOhhGR4pb2csci2jFL9vhJDD8Lq98KXZzmfwXFCralILv6St+IkB5T0CSMG4owRQhrX06ynCBeFyqOp7dzUv5TWj6no6I/JWcZTvzZbUWYpBquL7n5VZJbprAk6J7BMf/UF33Djb01EEYDmUCbbfWTujZIw3hFr4szuFCCcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753125814; c=relaxed/simple;
	bh=EPEma6kfEIX/QcjJHZO2cVM2mBkt3LDt6QyZRQF4YRk=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=BZtG6F97kGU8UN1QbE1fjvbJ+X36/WHod5CQyWcJw6JC9YlSQoRmjJqlX4xfB2GvZTg89fxOQI/Mo/8eSX+fnTljATbKjX/st+EsXMgVdMkRVX64HByb4EZxzi38NFUhNePgONKh0hFpRnDJ9NCQVtB8hX/gDXOs6r6ZfA7QT1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=pass smtp.mailfrom=us.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=T8qeUudL; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=us.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LBCUe8012916;
	Mon, 21 Jul 2025 19:23:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=yZ1lhs
	mOepCOA5jJncPBFhO3PMa9QSVOwJcn6T9XKUU=; b=T8qeUudLXMUXYZjJ0CBfss
	VHnN5MB40IGKN2yctqedt3LReoA9Z0ODVMqsSMoZFzQGdgVu01TOXAYDgNY6vfoi
	gWZTGbgEf2sDbwQcKxjZNs2YuH+W3rksITypoMIUoto3/g9g4OtGU0A9m+qb0WYa
	1cm42tgaH09V/kwCSC7PeeqPcvPbMaKPlJ6dp2HQDDjrTU4fvhfb5k36EYgRfcbU
	6zWkz7YXh3CB5CtbReBjaurwgclAcIZEQrzqxCfNse0h2qOV6Oo7zhRYSg3siDis
	30gjZOxvdPJ6JrOQBopQxh8OU6ez5N+U96SmrBS/N6P/21cH7iwRt1EP28UdneBA
	==
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04on2072.outbound.protection.outlook.com [40.107.101.72])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4805ut2dvh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 19:23:22 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C+9tUUzOCZqFd69yHFdmd4rYkdjY2DHaM7rSCT6UlsPCi8e53gg9irMIxR1FPrHpJDuLJGH57Cg0Rc3f6QONcj6d9xORwqy2zy2ZC1BUS5x3XSdi15DugDBG7fQosO3mBU/KBOE85vT5DML8nGCgc5aKvVA64GAbX55cmwtJXg7lP/IWQsq72p+uk9KQZO+V+MTag3ub6jOqWWgMjDrTLnXsrp10OpegnmODxoWjsz+s+jfJJqOOOI6tgCfHTayNq38iNQ+veW5hnjwC3yLYhvJS163t/GUK4RPp8OYOMtGaSnZc205bsCK2QNKmw3G92I6duoysuqiSxDHZXKgKIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yZ1lhsmOepCOA5jJncPBFhO3PMa9QSVOwJcn6T9XKUU=;
 b=J6W1bZQ4fTxrT/ue73Fdqtk11mtAFaPSvbtzzhHa21uQGs67LPcKZxejsJ9eVBfSqINQYDn0q1b0r+W9XX/VXB47MOyw183qXYnc4iZKOqn6UQWWaDihCPpwkbvqJrZ7Sa4QVNlxdcqAqBXeQD+S3tf+VfSAQsOKX7e+zQlU5Ihy7qREJFWoa7fTUqkJijoJyxlyqPk9mYKKP4l5ngkQtTKvv3Hk57XRMBtdypYVIOvlYk73NUNbifZR1ZJzlrY02WnNpUwMWUUnxe12bQXQ7biiQQg0XI/Nyt32b7NhCuzWAieFsMNHiqnIMYnpreTSLS1zywlcYN9nn5hIBCNkSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=us.ibm.com; dmarc=pass action=none header.from=us.ibm.com;
 dkim=pass header.d=us.ibm.com; arc=none
Received: from MW3PR15MB3913.namprd15.prod.outlook.com (2603:10b6:303:42::22)
 by DM6PR15MB3751.namprd15.prod.outlook.com (2603:10b6:5:294::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 19:23:19 +0000
Received: from MW3PR15MB3913.namprd15.prod.outlook.com
 ([fe80::a1f8:4258:a99:3490]) by MW3PR15MB3913.namprd15.prod.outlook.com
 ([fe80::a1f8:4258:a99:3490%4]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 19:23:19 +0000
From: David Wilder <wilder@us.ibm.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "jv@jvosburgh.net"
	<jv@jvosburgh.net>,
        "pradeeps@linux.vnet.ibm.com"
	<pradeeps@linux.vnet.ibm.com>,
        Pradeep Satyanarayana <pradeep@us.ibm.com>,
        "i.maximets@ovn.org" <i.maximets@ovn.org>,
        Adrian Moreno Zapata
	<amorenoz@redhat.com>,
        Hangbin Liu <haliu@redhat.com>,
        "stephen@networkplumber.org" <stephen@networkplumber.org>,
        "horms@kernel.org"
	<horms@kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v6 7/7] bonding: Selftest and
 documentation for the arp_ip_target parameter.
Thread-Index: AQHb+CplwNRQMj38hkSi0WfLDuwVmrQ4qdqAgARPRPE=
Date: Mon, 21 Jul 2025 19:23:19 +0000
Message-ID:
 <MW3PR15MB3913774256A62C63A607245EFA5DA@MW3PR15MB3913.namprd15.prod.outlook.com>
References: <20250718212430.1968853-1-wilder@us.ibm.com>
	<20250718212430.1968853-8-wilder@us.ibm.com>
 <20250718183313.227c00f4@kernel.org>
In-Reply-To: <20250718183313.227c00f4@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR15MB3913:EE_|DM6PR15MB3751:EE_
x-ms-office365-filtering-correlation-id: 7262e356-03c7-49ff-e57c-08ddc88c0cb8
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?xQDDjVoTOrrm3kkmZ1k0Fh68aU0gjeuOvcXc7B8hY1s4RzobsQaxVMxJJZ?=
 =?iso-8859-1?Q?CA97PPrucx00RIsqY6WLFqh7kHksq3mMIdMNf+i7jI6KzTiTKf30QpgodO?=
 =?iso-8859-1?Q?AEXDBU2AAteFPc0pcmGySABhsrm0k09xLhK3EY9QHa3M/fot3ojVElSr8g?=
 =?iso-8859-1?Q?WGbpE3iIqs33mauzDxQUAWnV2y8bgeJzWCu7Xx+WaB920ZkIG0B+YY9V58?=
 =?iso-8859-1?Q?YN8+Fv/LNbKdBLMsV7VXgrn4CgVruBsUcpUXumSbP7TMjynSjjkw1p/MmO?=
 =?iso-8859-1?Q?vI9No3+7RDr4ICbtgGwXP+uxwH79P+HJaypFoN66+sT0/qlzvgx9Urodq9?=
 =?iso-8859-1?Q?MiEWUZPPTW+9LGzVCJ23YOpXiYCqWxKzXAx05JTOfv0ObFhPJcByvmQcek?=
 =?iso-8859-1?Q?cqUck7vx/WvJGimrx3NjXj9kt4D+bv0FdngJfmIHd6Nd6diKVmfvJ4dssF?=
 =?iso-8859-1?Q?v//iCYO7aBP72XFmPMX1nSRkz3wU8uRKxGbgCB5Qy7rIPtkcxLDoBne8sl?=
 =?iso-8859-1?Q?tOPfqMzoLzWeaBD/r177XVZLTz1Kk1Nm7q6ADMgR7LDNXexHPR/f+hyHNP?=
 =?iso-8859-1?Q?BBoxZc2gZkBtgEO3u8fcXCqFTRfPLEtaclNxMeqe09GIVZe8Aj8oEC7xae?=
 =?iso-8859-1?Q?jbTnwoofKg6e4TOV+3Ppkp9mZjkxjL0XeVS4voaYnr3vgQLmrV0KmcuO5L?=
 =?iso-8859-1?Q?PXpWYmdYdfvOwyTy1HDBJZB3Gqwac6NDoZnCxs0VD6/b3TtgtHmVoZy+C3?=
 =?iso-8859-1?Q?xjgPpKtmjrX1zJOlYg+Pyr0IKOfRFkZH4TG4uCRjooqIV2pepd7YZ0ZgP2?=
 =?iso-8859-1?Q?WZ0J9bvJZ5XHCbjcSiu3GlClnh/hMUXMgOXn/kVjKyO8phg15AlXeJFOZo?=
 =?iso-8859-1?Q?lnr2hwdgFuQib3BEwH4mvKi5IcB4xniAmaEVcFtmX5Y3HDES2i6sL8XOde?=
 =?iso-8859-1?Q?4xxGudycQvOmrslxepzXhajgZANTL2FmfQehjHXx+hD+6fNdeJ1MRxo/Rl?=
 =?iso-8859-1?Q?ZI8srSoDRAsXrAINrfTv+hLFdjm2ZByGI+XFeFK1LQml5R5k8R0KJozVqe?=
 =?iso-8859-1?Q?sdyVK4BXdQmEIwp07x/DMWT7Fjh0rxFnvGH/l0l5Vf0MtZB6eBzUkX9Ljq?=
 =?iso-8859-1?Q?2oIBLLo31+/icXG89SPkAPppj+PXFwKyLaEPHxEfYBTx9hlPqLpEI+gRIh?=
 =?iso-8859-1?Q?t0kFF8MwJql8yYVO8lArvOkDtvDSuOVK9CrH+QSjH4s2pY4y5odtQ755is?=
 =?iso-8859-1?Q?KN9MWFRHt+ybDpqCtaGwuhQpFmb1ziABniPp4YZ01/LHU65VkXQ3N4J6fg?=
 =?iso-8859-1?Q?Mledbk1GyJb4AxyczhTDb6VDkKKAX7OiplYVNX3MRD0lxPOOZB6BUbwEus?=
 =?iso-8859-1?Q?6hygfJHGoAHN2gpAcz/qx5tRoN9hnMYdDmpC1maWe8kNGYMNpAlXCor/u5?=
 =?iso-8859-1?Q?eDGOnlJ4ovAmo6QXDGEBZWMne5h5T7AZZWe8WJ3zcdUIFwnqY96GTTEKgE?=
 =?iso-8859-1?Q?mt8a2I/VaYR3hGHP9EyO3yEFc0js6sXIMOoVVq/lIPFQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR15MB3913.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?prCSATnweCGVvMxAvKzX97yezkLusPX5y8/1uio+yQKOq/qQHs5QPhltjf?=
 =?iso-8859-1?Q?9TdmV3P/ZaFtVyaEAmHuhu9+Y+PBlgimNqTxzP+iWf30k5IrjqO35MYDcf?=
 =?iso-8859-1?Q?UdZaUDXmxm3gBTsJvVC/5uXQv0oqXb9slwWJOwczAFk/DsY2tF7yVt85u2?=
 =?iso-8859-1?Q?xNI2S1p41Lai62DyzbbT3wLFb7LM8Bsuu/4AAq1ExjETKIPXmsbL3xcPK4?=
 =?iso-8859-1?Q?Nyu2x81Cbo5uDfcOclfGD4dNwdCpJeAHs8aGwHtvQHH7A88cW82AQ8Hbr+?=
 =?iso-8859-1?Q?e8eWwYVXvCv4NTVDTrGhVd+jfUz+oY0rqb5fAXULK2YIzFfM/CqnjO/59a?=
 =?iso-8859-1?Q?p5mPbc+zMyxHZLPCb9hysAXNKD1IYKkqOVmYxrFQm9yijz/tNkQ7wGSmXG?=
 =?iso-8859-1?Q?RFkPSfoxkzigu/aTcyt77yrN4C1kW8UeQnh1wsTExGbYh8ZnP/0aX5RGt8?=
 =?iso-8859-1?Q?5TwivK63HSVv9EWF+AuXSVM20HDyap3x6vrse5Aj/9428PL7HXrz1KQJJO?=
 =?iso-8859-1?Q?ic9P1Yax627GO1Nk+Rq0YBLf7BCPA8eyiQriU/yDE92l9885Fgdm5KogA5?=
 =?iso-8859-1?Q?JBVyqhVM9DmfyCtR6QswmhV4qd4UrHri4Cdf1d+sfcxMr/X1042wvys2vY?=
 =?iso-8859-1?Q?XmdQ1GpT5HaW74/v/8nzSz1AjiPK8sT2+yPA996HiIJ4pJ/dTlL3u+5ohW?=
 =?iso-8859-1?Q?+/yaPnaw2sa164PPQhvGQf2kH7AsDckwV3NPS/79KL9hjYuEJjiSLqrXtD?=
 =?iso-8859-1?Q?YI3yT2IK6Ex3t/M3sjqcQGsx9QxKHxQMgXtbJ2HaRLFWen0miNjlkda0xD?=
 =?iso-8859-1?Q?2BvFd/DUgj1cxfiwOWeNywarWRoJWDUPuTsJZwjb5ie1iTmZ8TfLT833ZX?=
 =?iso-8859-1?Q?3+mB/aJQ1K8CeLPEiLD7tDHwmgR6NcZqcNy2m7LcKcH1jG4/ZrRjuVQRV7?=
 =?iso-8859-1?Q?31XKLLXU1nSeMRNjzmhUCWN2t/1re7MIGNJari/CIC5AjuGzPXhFTgS//w?=
 =?iso-8859-1?Q?aIpZ8514Uie2b3S9Elu9VXOiQ+oNt0pS68oqPNZL1JpH2XSiT1VHVPALVm?=
 =?iso-8859-1?Q?niGx/KQ1SmloUCG4YeyIA15JwhgS2TRbm073fAx4Q51MSix88IHSAFGqTg?=
 =?iso-8859-1?Q?HLrlW6YkwHYt9Wzr3TyeYz/GC4jdm5n0ATEXBkl6umdA3mtD6UfHAeel1F?=
 =?iso-8859-1?Q?GC+OIBNa56ULJn7ZrfEbu3fjIzdzhO66teyEm3PB0l8CScNJjPWgAXAXAh?=
 =?iso-8859-1?Q?5IQBNWYW3rub3piw5m6Ng7x5P4+HJYG2Jh8DFa/sfNV6aHX55wAoNPuYz4?=
 =?iso-8859-1?Q?DBIY+7vWMyNBrw3H7WIy43vyoTv7rNMseIBrEHuyZVHxv1y038J5fRm5hx?=
 =?iso-8859-1?Q?Wrv2XjhiS/j/cbNWhYUe76CkfQqSPw8rA83wba0nfDbj04xdVuvHWHUmze?=
 =?iso-8859-1?Q?SnimFgHaRHetxUH33pu+UdUXnYmWELY3Ktpt/m6+ld282gmvWveT8c1w5W?=
 =?iso-8859-1?Q?PXS2I73qXSshby9n2seEZRUruZktaPGlSaE9C0NxucyGh4k6EWOplBhuTG?=
 =?iso-8859-1?Q?2qk5ysYQ7FYFN8KiVsbWUUjvIiyiju5f5a+Kz6jx15FfjLHspQOXPiO3oP?=
 =?iso-8859-1?Q?p7rVFvWC1eVUU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: us.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR15MB3913.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7262e356-03c7-49ff-e57c-08ddc88c0cb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2025 19:23:19.0486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kQRXlIJPUZI2+X0mVU9pQlSg+tqjJJH1jjFziZb4R3IgLauuVASo/B1IAA0gUBs+cL/YOtDTMBm/Rkm6n3gmIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3751
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDE3MCBTYWx0ZWRfX929XIbdiv2QU
 z6UoJ2RWksYYQ4KetiNd9nZFjj1bixFY+qboziGsT7cl5D0ycWloX3ohFPeEcyTSwxwnGN0NDIB
 o/SVvnxazENOFaJSc61tyli2vwUEGWECMFUd9Kdi9yfaUqBK0KRddfyBiLFmzJX7OgEPlkiQ6WQ
 7teMmtIMKwWk8a98kHSqZx5XFPrkTkIB2hzKuqTZjmYvSn+BE3lHbjbHyX+ussU17fAc5JgUCDH
 8UdTs+A6NuM51KyTFSz9c343hAGY2CbuROsW4WrvENkn7ShFS8+eTXyrfTiXpcBBepzAGtCaf2U
 XF8GfkdpaLQGUlNiytV5TyDrdpuxeukMiYzgdYDWG7ceCzGDH7U+EbW76/Nw5aVDgXg7WV9G+pt
 /wfFPX9/SaOxqhv9VGX4sfU1iWthVlcuDO8ibIghvXItR0QbLqDE7Fh0WE4pOTz0J5Jqe581
X-Proofpoint-ORIG-GUID: RJvi8xNWrOyHXWMiP-o5MiXEsXg6mon4
X-Authority-Analysis: v=2.4 cv=cIDgskeN c=1 sm=1 tr=0 ts=687e93aa cx=c_pps
 a=l8vyuyoHTbRxBAwLcDSn/Q==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=QtvRY4xpf1MSlWN2:21 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=Wb1JkmetP80A:10
 a=VwQbUJbxAAAA:8 a=2OjVGFKQAAAA:8 a=VnNF1IyMAAAA:8 a=P8mRVJMrAAAA:8
 a=jZVsG21pAAAA:8 a=Bk4mzNKvKqzS6DuQ4OcA:9 a=wPNLvfGTeEIA:10
 a=IYbNqeBGBecwsX3Swn6O:22 a=Vc1QvrjMcIoGonisw6Ob:22 a=3Sh2lD0sZASs_lUdrUhf:22
X-Proofpoint-GUID: RJvi8xNWrOyHXWMiP-o5MiXEsXg6mon4
Subject: RE: [PATCH net-next v6 7/7] bonding: Selftest and documentation for
 the arp_ip_target parameter.
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_05,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0
 adultscore=0 phishscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1011 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507210170

=0A=
=0A=
=0A=
________________________________________=0A=
From: Jakub Kicinski <kuba@kernel.org>=0A=
Sent: Friday, July 18, 2025 6:33 PM=0A=
To: David Wilder=0A=
Cc: netdev@vger.kernel.org; jv@jvosburgh.net; pradeeps@linux.vnet.ibm.com; =
Pradeep Satyanarayana; i.maximets@ovn.org; Adrian Moreno Zapata; Hangbin Li=
u; stephen@networkplumber.org; horms@kernel.org=0A=
Subject: [EXTERNAL] Re: [PATCH net-next v6 7/7] bonding: Selftest and docum=
entation for the arp_ip_target parameter.=0A=
=0A=
>On Fri, 18 Jul 2025 14:23:43 -0700 David Wilder wrote:=0A=
>> This selftest provided a functional test for the arp_ip_target parameter=
=0A=
>> both with and without user supplied vlan tags.=0A=
>>=0A=
>> and=0A=
>>=0A=
>=0A=
>=0A=
>Looks like something ate part of the commit message?=0A=
=0A=
That is odd, not sure what happened.=0A=
=0A=
>> Updates to the bonding documentation.=0A=
=0A=
>This test seems to reliably trigger a crash in our CI. Not sure if=0A=
>something is different in our build... or pebkac?=0A=
>=0A=
>[   17.977269] RIP: 0010:bond_fill_info+0x21b/0x890=0A=
>[   17.977325] Code: b3 38 0b 00 00 31 d2 41 8b 06 85 c0 0f 84 2a 06 00 00=
 89 44 24 0c 41 f6 46 10 02 74 5c 49 8b 4e 08 31 c0 ba 04 00 00 00 eb 16 <8=
b> 34 01 83 c2 04 89 74 04 10 48 83 c0 04 66 83 7c 01 fc ff 74 3e=0A=
=0A=
Hi Jakub=0A=
=0A=
What version of iproute2 is running in your CI?=0A=
Has my iproute2 change been applied? it's ok if not.=0A=
=0A=
Send:=0A=
ip -V (please)=0A=
=0A=
Can I access the logs from the CI run?=0A=
=0A=
Is there a way I can debug in you CI environment?=0A=
=0A=
Can I submit debug patches?=0A=
=0A=
David Wilder=0A=
=0A=

