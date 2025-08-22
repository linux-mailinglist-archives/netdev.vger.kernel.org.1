Return-Path: <netdev+bounces-216033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB35BB319F0
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 15:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 593513BCCF0
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 13:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC093054D4;
	Fri, 22 Aug 2025 13:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ujquw01f"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013009.outbound.protection.outlook.com [40.107.162.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B966A3009C1;
	Fri, 22 Aug 2025 13:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755869595; cv=fail; b=OHowl4mmfdu90+aTkW7T1u5L3UGb2gGIS5S2xbaVXWtfBBN9PXzCIt6uD2tc3unWXe9OPtXUNKQHDMlffYIM4X4XjdZGMkUktksLJHnBkUDm5xsG+7uQir+4FQokxBpmnHcWTzM/EHduK8AW1W01FJ+4KOfbXJcfkBN3YTwoniM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755869595; c=relaxed/simple;
	bh=BpDvkdPAYu6JdbOzt7+ZTFSw4m9VT9KDvlHJQbUr66g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cQUjMIwQV+y7KOkDgMP9kTnBj/u4WJvTfoNXagvtT3az2uCckBGoSkozSdYlJxuFZOQk1/wlB6MMXBiV3xpLAgCfJry15yY+U5VFEX1hvhXStM98OMColCWDpKIphmVp9BRz7n/vfAYmeR5foNIDO8Wdb7E7FzEB02u0kon3el0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ujquw01f; arc=fail smtp.client-ip=40.107.162.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ABrlGYIZ7BjXLPbogDz3IFZOF/6VwU3GN/j2NhnQvt1KwcVgWvEkvrqBdd86drTWl0wxrO+JYGVTK+Dm2JIOVt1GGY0qBuRVCm1F95nA5Zq0FK1UWF7Qs08vs0Y+3z3aHo7pBfbyTXwYcH+hq74EWbv8NT1jtDNugQhyaBD8ZBMZtfBkYd+fbHHBjrVneL47Cz8Xe60h7mv1+xAV+nILRhfS5httC3PlGZoPxL4YkyEaH6mF5L0gHaDiXzH7NCwwjUo6B5MZiOX2e8V7LLOEzauqijzR18dBEf2x0b3DsWQr4QnhcCGPIel6BGb+ztJLE01udnQ0b6r9GLxa7bSZgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0XDerur7CHXoy8KzumcFntGsFQSHU2yDaBQM6zdwzeM=;
 b=xQdWcoiTJ1cnYFBo8X6wQBxd3Xs3T13d08pxRBL4HhcVHv4hERTcm8JjLorZri7YB/9bhbpDpU8PgkFeie8lFsf9OFdc/gU+ZzSQ582puhtMVUzxCo68FGw+3SwCXllD+5TP4PeboC9PTAvb3VhhvKlHD24sYw4nmMiW1Du1FCvv75KuwDrRK3TEYDfu2Cqz3L3n2X5b5JLvvvqjiymVwevfrqchaeIrq9wmfJQ1tie5P+N0S7qylqlEdyibLWQ/Be4esisIJSBXPmWOyK2Zwj3JRUWey08IVZ0oFLQO9uHRs6MmfCs4tkQdZArotmLAA1obpwj/GrBkZDynOAOqUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0XDerur7CHXoy8KzumcFntGsFQSHU2yDaBQM6zdwzeM=;
 b=Ujquw01f007AuJ4Xc8E7XgmrbdIqUcD+0IpDPDrAL0KJilF+n+EqfHqhE24AOK8VCYOIFAYoD7zAXkN+QUBRut5WJ+T53HwHZphBcwwXjUdjQFDFR58xIacsumUrF/hZyZQvVhPfdBuv+o3nyKvlm9rAeoUoCTlIBcdQxj1quZGcMFeEvdkdycYx7Btjcr2e2aXfLzLxGkHtCtPpkDnZUEZ8sTfIL6weKahnMIiNW5zBjX0Z86nbRUGfNO1Jhjry7e+MrC/oa2gNmawHbiCTcLxMjd70JBSfOap9Re8FMqkbco1EEEw78PSNwnyGrTE+MiQ5/t6D4lCa/Cya41Uv2A==
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by GV4PR04MB11305.eurprd04.prod.outlook.com (2603:10a6:150:297::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Fri, 22 Aug
 2025 13:33:09 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%7]) with mapi id 15.20.9052.011; Fri, 22 Aug 2025
 13:33:09 +0000
From: Shenwei Wang <shenwei.wang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
CC: Clark Wang <xiaoning.wang@nxp.com>, Stanislav Fomichev <sdf@fomichev.me>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>
Subject: RE: [PATCH v2 net-next 3/5] et: fec: add rx_frame_size to support
 configurable RX length
Thread-Topic: [PATCH v2 net-next 3/5] et: fec: add rx_frame_size to support
 configurable RX length
Thread-Index: AQHcEsoxXGKzYnBdLUK9f8noPKEV4bRudCcAgAA2o3A=
Date: Fri, 22 Aug 2025 13:33:09 +0000
Message-ID:
 <PAXPR04MB918588241A96C60E7E7E4FE2893DA@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20250821183336.1063783-1-shenwei.wang@nxp.com>
 <20250821183336.1063783-4-shenwei.wang@nxp.com>
 <PAXPR04MB85106B9BAA426968D0C08678883DA@PAXPR04MB8510.eurprd04.prod.outlook.com>
In-Reply-To:
 <PAXPR04MB85106B9BAA426968D0C08678883DA@PAXPR04MB8510.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|GV4PR04MB11305:EE_
x-ms-office365-filtering-correlation-id: e116a605-99c5-4c85-ad79-08dde1806f51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?p+5pjaMxX9ERF7vT4Y5ZX7YL590UYHh5UCubfPMaTmvHYRbsd9IfKWNWkFGV?=
 =?us-ascii?Q?lc1qKMAc4AFupdefRXboQ/bjGM0xv7qzoVGqTuVNBTbF+eaQ8cMqjy0atb9z?=
 =?us-ascii?Q?4+1KOTiMZqZNjGYS+1WXDQfDogeopI89rX6j7nLjjCj2t54jNRxkSQdkZl4E?=
 =?us-ascii?Q?ro9C61VC0e677/tAQ5nXpNiNeLj+YRuPmzEbr4/zJW6+HHFaBsk3Nb6ORrqP?=
 =?us-ascii?Q?gbiVYNvF5LULMtudXxv7DwJyopCcWj9ml0zIp9W1RIsnwSNAIm+9+E9lgrZI?=
 =?us-ascii?Q?iyJPcRhuS+yOU7XU7hnUX8nIEFemgDKcC5myrUb1HMSt34Sppo2I1fs+oAC2?=
 =?us-ascii?Q?JKSAT9Ib2kAKig13fODxTCkMSdydyFoJzmhhlWpPNsQ4XiWYgDLgJCeo97of?=
 =?us-ascii?Q?mEEd7+vJPdQYfDHep35ytaep56tDj1JaEIxIrOrYczGgRu1X3jRBHD/w22mZ?=
 =?us-ascii?Q?TogzFJXrpnHj1d2Edu3bYDuZrNAWAm2E08qDr42yChPRKJwEa+cALO/IwHmr?=
 =?us-ascii?Q?iwMlkolLDXesqDoIYV13CljMEEPqHQ3BnJ4nvSlN+qOWPsmhaOKP5uS0nYXs?=
 =?us-ascii?Q?kO5UluyBvfJ7hXk4wjWUxsOa4hN3mL+1nNN8O3T+k/gasFzF6dOuB4Lohfqz?=
 =?us-ascii?Q?+HjFlKS0VMlHogKgSLk0VD2gwEqEvQLe1X2BV10ixiuDrKDFBftVXBNe42GR?=
 =?us-ascii?Q?/nXpeadAAdHbmYMtm9p70I22u/o3zuIaA0zEqyKaven/YBj8mN4qb0UipcLi?=
 =?us-ascii?Q?qiqTb+r3uJNEnf+XlSyPWWP8X/A2q6qyP6wudt7SIYAOHrmJNn4oAvbFfb2P?=
 =?us-ascii?Q?HcjF0Q+OK67enXK26vBw7UU55c2cU+/a6BxtJ5tMSQ8TemtJzwzfjsojBpIQ?=
 =?us-ascii?Q?xzemBKL1DVXSYC9npVWWcgKrJRpxiQlAVGhFGFu34UvWoRzGvkS1hZGzEeNa?=
 =?us-ascii?Q?4PPg4Nj7U8DglLVbARvTX3dl2RQP1dyoVEHyVeTEJldkc3KWBZXDo2Xkb02X?=
 =?us-ascii?Q?y3+fpDsSroOYTHKJHyQRvECfLyoj1XRqtNeeZOnm9B2oQ3/QSVV+jcEnz01y?=
 =?us-ascii?Q?+wCx/A0+D2M920vfyBV9QpzGxsLa1M1FamWlkseHo/glwnjVvwtMtTeTY1mY?=
 =?us-ascii?Q?N0F/VPxd0crKsRv4HWpEAZHVFoYuzOuQbdv9jOcWovwHC1ple6ClxD+Ckfk5?=
 =?us-ascii?Q?oQv/D3xDLB6s3rYD3NmMaAHQNjx7WgcvkIKODB+BY6/UbKNVtbljjIYy68O2?=
 =?us-ascii?Q?CmrKYyfXZRTJUea1GaFQly/VXQvLj6gvUR7XnBOr2QJ/dx8u1tWmWmkqG6IE?=
 =?us-ascii?Q?cRco6DNNyXw8boa88EaxevC3TyhUIEG058dLrpweyZckZ2eoIILrFeAgztin?=
 =?us-ascii?Q?KQCuGx8KLwABhwWZdgUzuuPXfJVgNELZWEZod5fQlJ2q/UlNnwHKSG9Eonyp?=
 =?us-ascii?Q?McU0uVOtJuEWxTS8nuwbuKB1wg6iFF8VAHZzbB4ouiEowr136OeewQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?arh4aGUXkzyFXBD/TLfBfPlfcfHpew6j1vBjml72eo17x7eUDAZ2iuCTHJHD?=
 =?us-ascii?Q?BgZE2GBYM/A0gksWez1yYN3d7HluC841+A2ph2wTm9TIIcVMvMXNoN+e4Zo9?=
 =?us-ascii?Q?88mBn/CAIw+NrDKBIuiQAg2tKJl6iy9Ybj/AJBRbl0h7zLtiF0xC+MuZnMKM?=
 =?us-ascii?Q?j5ojif2pcaTuZK04fLwU5Vy4GPoWSQqUr9zlYGnKUKdJjgMi+ndB3F/Ga2EJ?=
 =?us-ascii?Q?ulK3K7Bs+pDuG6b27qppWyJ5+JbMrw7ONE3oDZK+6/kbOxl8qemuKQ/UpCQ7?=
 =?us-ascii?Q?tsUWrBFGpXZCq1AlecEAY0Ao1IhqrjrVGc644cQEmA+oy7vGJ+1iCb4Q97ZQ?=
 =?us-ascii?Q?msjIOZ1L0++EKESUljkHZc5QMx+ZOg6XfvurI9NUJK6ywmLTtzzptA4k8LB8?=
 =?us-ascii?Q?SmqwSnz9mTIz+1Dn2zE3Oai3UJNpG2aNq1bEUEQu3NWlodKv1yesmLyejA2Q?=
 =?us-ascii?Q?7wxIZqYEbK8+dn/Jm52vFE4CIGeYHhzWa1cjBQ8O/6PWZnKL1VaEBWhQI+Gn?=
 =?us-ascii?Q?azL/qyVGz+cgHBYmnp4J5nir6lNgt9SyU+o0ZyVdo/4Ez8FoXqmQmCuCT+JA?=
 =?us-ascii?Q?qSpbRWgxKVCRMgDGsL/naSYrbX02t8NpcycbW0QSXtGjMl1kaykdrZitiQ+P?=
 =?us-ascii?Q?7INWt4IbnVFhvTAVn4PKMOF5+3QNM0leoHnxYkStF5ObyfeQOB8i9vQQDJwU?=
 =?us-ascii?Q?dcbgD1SALE9OduTLrjSj8gEnMcaEvzJyOubBuQLpg21pSefruSDYIGJPyAiE?=
 =?us-ascii?Q?Jg9r3S/bZtQYLwAY2gCLxfK2Fli4rABsbAM8Vuvm6dttpltsH2GOopCqwY1N?=
 =?us-ascii?Q?AQlMXy1A05RZKcRFVQQlRsXg2yejP0oaHt2nWNEoX2MNdFNE9+JYjN3PVkFe?=
 =?us-ascii?Q?ET3lJOJbHpeqkamc3ON8qmbFJIq282MHMpl8HYuum9NgHPJR0NPxPkcdvfXi?=
 =?us-ascii?Q?JVyxsVsnWWvYSRF+6YtD2x7t751JSvFB3hPg37VX9U2k4LT7DzLMqf+H5COi?=
 =?us-ascii?Q?xT6C3Cg0rxYCTv/cA05CHuwG3bp9PkQI30xhz3og4vqzVSX0vPAw8ShXX78i?=
 =?us-ascii?Q?Wt+bDHDU94lhbKZI4koEX5kTvhDx7l+DP+nH0tx/hhPBCQeiBvK5U/J7GFV1?=
 =?us-ascii?Q?pFxQ/KDoS5PdTDza08+ap0HA4q3bXZSjf2z7PeaLzG/Gx/ojeaVSj94Jr8Pi?=
 =?us-ascii?Q?SQcKzmiHwU0owC+akdiQ48jv6WCe8yy+I+4lXgNxaQyxFyt1PZVreDgLfsWu?=
 =?us-ascii?Q?NWc1W7vtwy4H3L+sIT8YCPmWciWvv4vJOI8l6NSbYLKSm6ajxp5gAIo8FC0p?=
 =?us-ascii?Q?EBSBZwmlvS3XqMrWSmjRp50xQMGTtHQh3gxARnefS9TksI8jFJtJ5jJtN+sZ?=
 =?us-ascii?Q?EjIq/aiIYckeplE193Z6KqtbX5xFZQinxY9+2pgV6w3NbCBjLQp1nZ1v01Qy?=
 =?us-ascii?Q?TlK+pxVvGbHB967HwA8iFUEpc4QxBYJhZFmQxE1WLPnjYWVeMZiIsBzIavUM?=
 =?us-ascii?Q?tOl3WLNcaDIyAC8jHg+1X3dssPsmyetPDv59YhQDvE3YXnZBraRFbYDrw59C?=
 =?us-ascii?Q?s+an/yRTeXn4p780Rds=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e116a605-99c5-4c85-ad79-08dde1806f51
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 13:33:09.5730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OL2PXrBsT0VLOw3BQNNx4XU6Q4wjX+zIHUDXhATdKJDynWLwLQ1cYLHEv1kT5rShllAxmaNShGCQmAgXhTLq/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11305



> -----Original Message-----
> From: Wei Fang <wei.fang@nxp.com>
> Sent: Friday, August 22, 2025 5:10 AM
> To: Shenwei Wang <shenwei.wang@nxp.com>
> Cc: Clark Wang <xiaoning.wang@nxp.com>; Stanislav Fomichev
> <sdf@fomichev.me>; imx@lists.linux.dev; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Alexei Starovoitov <ast@kernel.org>; Daniel
> Borkmann <daniel@iogearbox.net>; Jesper Dangaard Brouer
> <hawk@kernel.org>; John Fastabend <john.fastabend@gmail.com>
> Subject: RE: [PATCH v2 net-next 3/5] et: fec: add rx_frame_size to suppor=
t
> configurable RX length
>=20
> > @@ -4563,6 +4563,7 @@ fec_probe(struct platform_device *pdev)
> >  	pinctrl_pm_select_sleep_state(&pdev->dev);
> >
> >  	fep->pagepool_order =3D 0;
> > +	fep->rx_frame_size =3D FEC_ENET_RX_FRSIZE;
>=20
> According to the RM, to allow one maximum size frame per buffer,
> FEC_R_BUFF_SIZE must be set to FEC_R_CNTRL [MAX_FL] or larger.
> FEC_ENET_RX_FRSIZE is greater than PKT_MAXBUF_SIZE, I'm not sure whether =
it
> will cause some unknown issues.

MAX_FL defines the maximum allowable frame length, while TRUNC_FL specifies=
 the threshold beyond=20
which frames are truncated. Based on this logic, the documentation appears =
to be incorrect-TRUNC_FL=20
should never exceed MAX_FL, as doing so would make the truncation mechanism=
 ineffective.=20

This has been confirmed through testing data.

Regards,
Shenwei

>=20
> >  	fep->max_buf_size =3D PKT_MAXBUF_SIZE;
> >  	ndev->max_mtu =3D fep->max_buf_size - ETH_HLEN - ETH_FCS_LEN;


