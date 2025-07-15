Return-Path: <netdev+bounces-206999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BB7B05257
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 09:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A6923B8A56
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 07:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D3F26CE17;
	Tue, 15 Jul 2025 07:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OXI65/KK"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011045.outbound.protection.outlook.com [40.107.130.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC04258CF2;
	Tue, 15 Jul 2025 07:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752562985; cv=fail; b=C119zESVF6YsaqC06xHP7iV8z08wkb7g2YNJSJ2ULBhCLF6DKuNCu3dfnhqozpt3kn1hpnJhiRkhO4RigzZxQFpibX14TQu/wGN4wuDGl4hICb1aGo/Cfmc5Au6mcwn8sYiA1Vq4gYT8sWTKgWp8fKB/5Imnqyfv/wCxKe4+9SE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752562985; c=relaxed/simple;
	bh=tE87DPPDHp9H/XAd554pRopA087mtyb6eBOCpg3CmWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ORVdW2g6m5ki74olcRDzy4K2n+KRFXWtWaghH9IcviyMA3VzrRQJyVlMXbpLmyBx+j31Tys8NeXsKDFMdXjswu9qclfwkAXUNQGUWXan17zWQi6hkGACymdxQjeK0BBFHlTFIgQmFaAuiSRwSQa/QybyGGHaSl/KeEuPqRa+Xbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OXI65/KK; arc=fail smtp.client-ip=40.107.130.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sBdiR5QA2fryVGHAJLpGMyOI/1QemZo/FniGsyElmWkcgofujU/+uBTvSuBVeUqXA3V0VoaOH2gRGNppy5iXY8OSmJ+41JVJQh4kBYcr+Jyl23fukBvqF8cTuj5Z8xTreGRJwsjxY/8FuVxVT6dWm4IbQuNBJFiyRTtyvIe8VsEVbaEby8SgBvZhyxBpnlCNsgtPIxxhh3ZuQc4xEyMpSJZvC340oIQCy6uPEu1tzE2ao/+b5wV0WPaBaXfmIIqJEgnSj26FqsATXJJuzNSo1o8yRX+dIGaTpg0ytWJJvU9kvRfLuTzdrd6eJkPuPnIFUfWc/ENo0WDKzEnmVBHPag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JO9GBU7gGheTqiaN68fNTk0ICLCgShM1PTeDH1OFLpI=;
 b=TAQWNmkEgfotm7W9Izj7AjZVTIeJ3UCYYnrbJXlc1iyqbs16b+ITgY0vw8fkh6tbqU/9IlcZgFbrvrGLD0gTdVi71NkCgwzFi2BoLa+Cs8FbP7rw2DABE4pRLE2ALQQcOvdjGHCXwGrpEAWtUwGRau//98FQjy7GPhyABtFQJLmdh81cxHwrOu6U6EIyCf+kNBsV3BgwFRBw2AtgeVrEjR/gRfTagpVAOeMjQOTL58q6BntuQHP2EVYDhjEIB7/ZHOSrzOkqdaIth1Xx08WsA4/9245+25asw8dPo5XskYtV7+KZwuS7vgnf2wm4QWfwub/0e5OokuUir/x3sdAyPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JO9GBU7gGheTqiaN68fNTk0ICLCgShM1PTeDH1OFLpI=;
 b=OXI65/KKqlELtJWkLxElRFrFFL8ZKJOZYo6ArUO7SJAtT+Bc1MShUn95vHBF8Yq2Em4q+Zz3SuBnTiDLsX608aIuUhN8kbTWI48EIGLG3ZY9frVarJjAdCUJUnsC5a7KLCq/bh85oepUED8A4pp8wSlIKQbgV/qmquT6/J1fLydVcjvC1SB2pOUFBsseC/O3ZGOti6vDIo144rhtVpOhVzV1EASXqBHyFwIrtTIoUB7uSM3fpDbPb3SprwYfmaQfCn3+w1FD849DUQQpw52wkZDklmIz2c/AQEndsQr2AfW/iMIu20e0iY8muytzIH4oAhjCL88NsGwSn0mFcJb8Pg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DB9PR04MB9915.eurprd04.prod.outlook.com (2603:10a6:10:4ec::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 15 Jul
 2025 07:03:00 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 07:03:00 +0000
Date: Tue, 15 Jul 2025 10:02:56 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, "F.S. Peng" <fushi.peng@nxp.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH net-next 01/12] dt-bindings: ptp: add bindings for NETC
 Timer
Message-ID: <20250715070256.ce6a3insjihjtpzj@skbuf>
References: <169e742f-778e-4d42-b301-c954ecec170a@kernel.org>
 <PAXPR04MB85107A7E7EB7141BC8F2518A8854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <836c9f0b-2b73-4b36-8105-db1ae59b799c@kernel.org>
 <PAXPR04MB8510CCEA719F8A6DADB8566A8854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20250714103104.vyrkxke7cmknxvqj@skbuf>
 <PAXPR04MB85105A933CBD5BE38F08EB018854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20250714113736.cegd3jh5tsb5rprf@skbuf>
 <PAXPR04MB851072E7E1C9F7D5E54440EC8854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20250714135641.uwe3jlcv7hcjyep2@skbuf>
 <PAXPR04MB8510FFE0A5DA2F3A94E9CB7E8857A@PAXPR04MB8510.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB8510FFE0A5DA2F3A94E9CB7E8857A@PAXPR04MB8510.eurprd04.prod.outlook.com>
X-ClientProxiedBy: VI1PR07CA0297.eurprd07.prod.outlook.com
 (2603:10a6:800:130::25) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DB9PR04MB9915:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ed8e1b6-7046-40ee-c300-08ddc36da282
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|19092799006|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZCX7JOmaipzd7TpJuIkhjLGsKL/7WVPvxz7/kSDNrP1M4GO995UILDDPiMem?=
 =?us-ascii?Q?I1DoVcKyku/Box2lLkvkvZ25+UOdFLtLYJdYoGAKPKZgtch5SeSSfFVurHxn?=
 =?us-ascii?Q?a4h+56feRpR0I8XptDXNGvXJFNaRghbBeuGMCHqyiwUQSeocnGKCoI2FSNmt?=
 =?us-ascii?Q?99zwb10PN3LM/jBK0e1mzYuONDNCZV6XQy1X2NMNX2j1AV3DUqFJKuipTwFJ?=
 =?us-ascii?Q?TqT87zmmtXpRHIftHY+1+bSqgs0K/Mqis5DcdL+6fCHQ5aWZLwQHcqDfxhwN?=
 =?us-ascii?Q?MDmImB6lJ8XtYuKj8mLxHcGw9tXVuCRAqXOXmQI9T9EliW//eeBMjAlp2Oac?=
 =?us-ascii?Q?4IeHndZun5fNk07rxuEogHfR4f/EpFbSEVnzSdLOru0FyZwPgikhMDKD7476?=
 =?us-ascii?Q?ub+eWLW6iTgK0WScdrvpzn2vu5LSdQr+nO1+eDMGVA3dzNZkHnii0HLV4Ry4?=
 =?us-ascii?Q?TbnOoHjCKAK6MSdpJg+mgc2TYs3irovacsGDjZTGo3ZJHgjHxFlUReldkuGX?=
 =?us-ascii?Q?ElQvibDPqvmIJ7tJKyyB4WVKSJuEWZyrmDaVfxlnNnPpz/+sSeQOIvsXmKCj?=
 =?us-ascii?Q?GrkaaBK3x1AoWVgAKF39o4k/hAoiK1Wqgoxlw6zGLmUHKjRcCXuKgTZ/fDRW?=
 =?us-ascii?Q?GBO4UQqZqH2A1aPQOw9SWjnRn3yupoGiAay2Df+gFtCFjfShZtOwvwYNUqa5?=
 =?us-ascii?Q?5PKEY70kIcEHvBJCr4PsvwzWfgPG5c+pf9nC8iXEzwM/U/ynpaUWBbZy9UJn?=
 =?us-ascii?Q?LWoF/BIwc+X/1uE2IUKOncH37TcvJqk7O19qs1NOu4lP3o5VF16dCYgTrzdF?=
 =?us-ascii?Q?Xi0wvBbWxNQwQOXLymeKYzMulZYA/mnx6g3z+cudb9pejBP3+MFLPak+xYMX?=
 =?us-ascii?Q?ojYKZ/cT2EhJ4pXIxg04RDSZXAfKlXAgqYtFJYc8ucSm1Yo785/8Po6Qyhe7?=
 =?us-ascii?Q?sx0M6kwHw7s3ISzqbmTrpIv9phb8CxL5IOc8LTZdJczaFofq/aLNtk5RlBjo?=
 =?us-ascii?Q?fWYXIUlyxta9dLoaG73Sf9Exl5yP9lFw+zU5Pq25H74glly+53KTBRXjMR5k?=
 =?us-ascii?Q?JU72wKA7LhDme/Ax4IWO4uuoL01BlQj9XH+6UFnzA1RK0oXFFozcs3wXMk9c?=
 =?us-ascii?Q?LR1D8uhhGdabgOhjzb8y+d2+CRhUHbE+ATarxqWR/FtD2gXXShIfvQhFULNh?=
 =?us-ascii?Q?te5r3X5GKIneI/fFWfcF6PTNbBpV+ghMoiO7TKAbUqZ8Z0Gee98e34j1ORzl?=
 =?us-ascii?Q?FogooGPol/nRyFgGnRWS7nlKFioeO5CPmYax9txhNjGfihC72sGYihl8ASzG?=
 =?us-ascii?Q?6irG6ZJQl5xmZ6Z48+gFKG3o7knrW/JnADT/vTxkRzIAF7B/JrQk6ydIpYcz?=
 =?us-ascii?Q?DnRBA2k8HoenM20AlsKpO3k5WE1VG5eU+76JNrqrVLhg6SzOAw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(19092799006)(376014)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YEpb0VPAHtfww3eXugw1GtLmHu0E1TYcbsxxXs629b5dIsAudyaTK1aoc2mL?=
 =?us-ascii?Q?C+i3GqzmqQCbI+rV2SFXka7MBKiwyX9HJj05qZ6ieZqoR2MHc9HP1uiG/y61?=
 =?us-ascii?Q?YpS4HWkLD1qt1OaomS+SF5svjth3388Xyxjfbq/KGqJulhkgj9ohqrK/DDCl?=
 =?us-ascii?Q?elt00BZSxKX86fKhepAAvoqXw+S8r9IIbHi+u40rHbK55kmOQ10bjTGJYeZ/?=
 =?us-ascii?Q?fb1AM3dBoBo5X/q14GJx2aEolBGXrUPOLch0fngUTe2Mo5CU5zXpzVjBUkTP?=
 =?us-ascii?Q?YrjwkIzAfoXtCETmkG6Fzk78ChMmd0F3q57X1aTrFNJ9AJl95GjLU5Gs7VAD?=
 =?us-ascii?Q?ewxkIUCGK2nS7n0py9qJqPKp9zphB8iAGHBvhDEyPBeCq+f42HTdGUdwL0iD?=
 =?us-ascii?Q?lO6PACWBnl/hP80uEW44yTDXzOVpEl9Iuz67DSI7dgcVr7c/rLcyWmuxppXg?=
 =?us-ascii?Q?XNAB1d+1KNBoeXnexBbQBiOwhEJIaM3qh03JDEEZRL4Mhh/tUxcTZyB1n62o?=
 =?us-ascii?Q?RonfheNZ2K2HRKAeSmWKTVxeYjEz0Nkd2G5z30T7XIHFw8BSTI+dFZisuQVZ?=
 =?us-ascii?Q?pekD6F4HUHiZTrJzKh9M9jz8IGtzIhAUiblu4G0aiYwn0Rr26GUrA8R4+Mgt?=
 =?us-ascii?Q?VRIoffARydyVtlf3eYDsSyMXoyJWkkv8CeJFeEjbIca3Mm45EzE63BXEygf+?=
 =?us-ascii?Q?Vn1B8KdZewPr8tCg655NVsbql+vwWXxLok9/ybou8RBUerREkmP+lQG9FAsa?=
 =?us-ascii?Q?vn7OCrxI1weTkrl5eht+9PVfuuzU5vblhb5mkEp2Z54TIUf6FwJZeAOtzkX0?=
 =?us-ascii?Q?3GCKj4+OvVN5z2Mi4hFL0NxFhQSPHYWSrwTpDwtCEgBkl7r/EY+8kTyOza6h?=
 =?us-ascii?Q?8+tPMSUUeiNY8gMiipGV3FfSyz/Gi5e/OLYWz2xGweZaemS9MplvD6J3dMSZ?=
 =?us-ascii?Q?n8CTv14SUkHmqjycqLdOuciyF0dchFg57wwlBadt29PsgLcEbZ6svQLmiPjc?=
 =?us-ascii?Q?tb3d9yGNSVB1eD0AuGI0LMBYtD5rZy6LLTqgEK0rqQYAT02DsIYcZHSAtxC8?=
 =?us-ascii?Q?fbdgJh23++meBZjsUkfIcNV8TZYKedPs2b2W0CCxpomsAHgtIjehtwlLEHKB?=
 =?us-ascii?Q?V52TvgTSkFf5twiqF/nOxDII/9dRKIGJZIYatWgA9HHLjumRWuHOmvEYdHkk?=
 =?us-ascii?Q?x7PYaGPx+QVbwpDCh+j9aRF8ne2PczvdYlXtPaAFOTMRtji+rN3C5CJuPtip?=
 =?us-ascii?Q?rj2GBYy9Z5o2YC8DVIY2uP3gbcrPryGUGrjydo4j7H9vBC2t86MVb8PvRlIh?=
 =?us-ascii?Q?zbg6FCA+5s1sg2mBHXX+5qLw6DotyDCYX7ErQ3Bb7+NKnQibR23Byf9VRqMm?=
 =?us-ascii?Q?LyVwz4Mm5BQDUh/n9Mvn5U6x79Ng/BTI4lPMycZeLncco1iWxJjyEeQ0SiSK?=
 =?us-ascii?Q?y+AI3vuwcCffN3V4Tqy3VQ+D0O/AUizSD2rNQSUANdqmrVxgbkokSANE8Yaz?=
 =?us-ascii?Q?XfY2a+rcsq9Xz6v5LwqRX5dHKpCOgwQPtNqJzWVOPMMhtXSNZ3jrb7crlrXn?=
 =?us-ascii?Q?RJdn3EuwXJ1HkCYyBn9ykuNz5GNOk3vujDfefcNb0HyBniiMRBjDecLByU8R?=
 =?us-ascii?Q?gWb4V9Kx+verpoRB5R/MFDw9jHrrDLLvKSqBLPzY5E9dUyqBAQPggw50UxcE?=
 =?us-ascii?Q?mxsKfA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ed8e1b6-7046-40ee-c300-08ddc36da282
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 07:03:00.3897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t/AvK9w6HdU3mG04bMQ1Fqe8u6in56TMmnRo+NHQr7cYVRwa9QOC4YavVk8umEnJ4XfXqQkXCzWj2Xg5j2OpXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9915

On Tue, Jul 15, 2025 at 05:52:33AM +0300, Wei Fang wrote:
> > You seem to imply that the "nxp,pps-channel" property affects the
> > function of the SoC pads, which may be connected to the NETC 1588 timer
> > block or to some other IP. Nothing in the code I saw suggested this
> > would be the case, and I still don't see how this is the case - but
> > anyway, my bad.
> > 
> > In this case, echoing Krzysztof's comments: How come it isn't the system
> > pinmux driver the one concerned with connecting the SoC pads to the NETC
> > 1588 timer or to FlexIO, CAN etc? The pinmux driver controls the pads,
> > the NETC timer controls its block's pins, regardless of how they are
> > routed further.
> 
> pinmux can select which device to use this pin for, but this is the
> configuration inside SoC. For the outside, depending on the design
> of the board, for example, pin0 is connected to a CAN-related device,
> then in fact this pin can only be used by CAN.

Ok, but I fail to see the relevance here? Do you just mean to say 'there
are multiple FIPER outputs from the 1588 timer block, and they may not
all be pinmuxed to SoC pads, so I intended "nxp,pps-channel" as a way
for the device tree writer to select one of the FIPER outputs which is
multiplexed to an SoC pad, rather than arbitrarily choosing one of the
FIPER channels in the driver'? If so, I believe the case is settled and
this property will disappear in v2.

