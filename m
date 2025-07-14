Return-Path: <netdev+bounces-206622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A9BB03BEC
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 12:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C40FD189D487
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 10:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A492624397B;
	Mon, 14 Jul 2025 10:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gSMnOtsY"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011050.outbound.protection.outlook.com [52.101.70.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF10E17A2E8;
	Mon, 14 Jul 2025 10:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752489073; cv=fail; b=qL5SZYIE+ko498ABxmDC9Ez+VLPWqWwiFys98M8maePt5mmaWnN14w+s/XHPC1a7MsGsHD+fIF7Oh5oF/eXrMtQVOArVTPkKbNnLmJr89T1/ri1wwtWzelkBffy/tuOP2r+eLJ6r28UptZrmweQMVfDKTQN0e3Yo8JzVkQ65RNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752489073; c=relaxed/simple;
	bh=Ez91sGVs7GwM+oV2bKmn6k1VyWSY4193mtI/JTvBt58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DxE09eyn9hGuJb5Qc+FvPUlP6aSULIKBehHXY/Nhr7B054Q54CnF4R6sXBimbVtHeMt+tODlMTol3HHECh+XQrcQlEZUWYXJy/Fut456fUFKPYLZq5VnYBOSuwVe/9ZdFVGHITDf/gZpDdPg2oulksKLNGcJsKlOapl+HL22TLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gSMnOtsY; arc=fail smtp.client-ip=52.101.70.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ltJlq4+cBgOxk7xWmmPfG6QCBmb3dwSi1KJyQD6HRPUpfCIJFSmeP6P32Mc6v9gd76RIsa3bRvKHKIz2968f1/EcUP4ZKVJvT8Um0zB7oZenhGkA9wRQd0+VzhznG91ysj90uw9yLLtUj2ZX91iaFzwqjIn8r7wNpRpNbSYnK1UGY3Ham/jO7cnVOWw2KBmbNxMK0OoUmmyoHCV/uNOfqGBWz9Fjo952oudhF6Aro128aRUq8xUZ/Gm7YlEwddyScDFx6+eZ1tlaCkO1Ri19hFZ7JHkGh7diGLJdpxLCZtuu0++OqHKBLSSTp/MguDtSYbA7PXLbG/KFPDK66u7A6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ez91sGVs7GwM+oV2bKmn6k1VyWSY4193mtI/JTvBt58=;
 b=y6OssTkdmGWViTm8W87qUnrwDdpvawJHF/X7jN/obBPWFq6BUDz/Lyjgh2tFT+oRz3T9CiGDHRoATc9qr7S1Q0ySxAxO7/MgRUCqcxNjQHesFCAJ8fn6ZmeVL2aAx5pd4IYG208b6WIlW2+FPM9FrBqZy3N2x01/NbyOROC87bAqL0N6ieEA3uk+DdQ5JnwLWE8Af6MQUpxe1g9fq/RnLKwqzwIGCSgXQXInV8lu2OAIC+qU9/+Ap9Cid2eaKoc5+r6PGiQESAECdRRgxyAe6wBrN6PuFfLeHR9HYpbELp6omUR89cO68kgn/JlBIhmbtFcBZVPkdKGWN2+kcYWNMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ez91sGVs7GwM+oV2bKmn6k1VyWSY4193mtI/JTvBt58=;
 b=gSMnOtsYyVvvjHv+4EK7IDgwWnRFrr174pxEuUQbsPjH3kRsCcu43n3TcpI0Qnr7V3qzht4TIiKFA1YLjm5GZLk67j9ZdQqDGCd5PA7snsnopzbHgvtmKKo40aX2Vj1SeH0nIZvgb0HctWGdy9JHV8kSk4WCoYSnu91tw7vv+qP1KBKWuxN6SLcZH6eqZHKjHWRUoLKI2g/iOwf8PD81BH0t/K4Eh0SR3dA8opp/Bplfip0xfiraxbEq02lwbQHOZQibRf2UNJNXO5+iVxaI5LDUnPknUflDwDZrf4oDOuqqXunuxgNqY5ZHTa58WBWzK1F4qKAB/CnC65WUEXgZ8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DB8PR04MB7049.eurprd04.prod.outlook.com (2603:10a6:10:fc::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 10:31:07 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 10:31:07 +0000
Date: Mon, 14 Jul 2025 13:31:04 +0300
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
Message-ID: <20250714103104.vyrkxke7cmknxvqj@skbuf>
References: <20250711065748.250159-1-wei.fang@nxp.com>
 <20250711065748.250159-2-wei.fang@nxp.com>
 <ce7e7889-f76b-461f-8c39-3317bcbdb0b3@kernel.org>
 <PAXPR04MB8510C8823F5F229BC78EB4B38854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <61e6c90d-3811-41c2-853d-d93d9db38f21@kernel.org>
 <PAXPR04MB85109EE6F29A1D80CF3F367A8854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <169e742f-778e-4d42-b301-c954ecec170a@kernel.org>
 <PAXPR04MB85107A7E7EB7141BC8F2518A8854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <836c9f0b-2b73-4b36-8105-db1ae59b799c@kernel.org>
 <PAXPR04MB8510CCEA719F8A6DADB8566A8854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB8510CCEA719F8A6DADB8566A8854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
X-ClientProxiedBy: VI1PR07CA0237.eurprd07.prod.outlook.com
 (2603:10a6:802:58::40) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DB8PR04MB7049:EE_
X-MS-Office365-Filtering-Correlation-Id: 306cf907-18f6-420c-690c-08ddc2c18b2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|19092799006|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j/g8TY5lMvtp+eAtnhK1elmJywtUbiBdjg5Nqu1WWpW8Bz20zDdI4TnnhK1g?=
 =?us-ascii?Q?19WTT46YkYsfFF4dSY0vtZ1Xd5zObtxeuqaLv2LgTjPhX++fpw31b2iX4sQH?=
 =?us-ascii?Q?Y194xltMOA3zmA7LcbMhXwaTYwn/7kKwA8ovKyjN76hawjkh8y5GfCjZehL6?=
 =?us-ascii?Q?FtKk2THKv+lK2fwtRLnw6Lua54a7nIsoCMXY3/knLqozqgkj99rN2vC++2rH?=
 =?us-ascii?Q?J7vE2veBVy0S2QXtv8RXel8RnOYUZEAXFLT4nWYpsrHmBgr0Fmkud3M8LtKo?=
 =?us-ascii?Q?nVrhIciA/F0Ik+1hQO4FDAGt4laKEy9yvhmGOXGpD7BiKW4s4PfJECjZCxat?=
 =?us-ascii?Q?zZRQ6B62fi6c2lpvEhyo2BLmUrY4laEFiQgLPgTDZdiOMW8fUcg9ovYihIM5?=
 =?us-ascii?Q?2gxr1rpS89lduxfgmxwGS/oA+7fV5s+6yjNe3HRY1EqhGGd0pWrx8rfLKiLj?=
 =?us-ascii?Q?qrpoude2pEmM9AEUKaZeSZx4Hx3ULBBsyYOCgCgy0SlzLwpuv+6dCkZua2wq?=
 =?us-ascii?Q?XGk60eFJdiMbCDnyzUlfrH9Ke4hQxY0JGLCIxFWI06soHLAzCmHZwziVaGzl?=
 =?us-ascii?Q?n8ejmAi+7wVXVLjrJYoR5WoLcnjILnm1gfMzNUBEbNMVedqtEApAnRJranU5?=
 =?us-ascii?Q?60MPTrFApPT7X+6ZX7NN7GEXCuhDWGQ8HwyYDU7LUit+AmTD2DyY9uz0eyzT?=
 =?us-ascii?Q?O6k39x4HB5q6pF1lkpZUU0p0zN1ttN71VFW2E4pCivVOAvesey93CXlf5w/a?=
 =?us-ascii?Q?A2nEuJeWOV19/Z0VedQMWkPPw87FxeXIaHlCNvW7ZK74R0B5I/nb5LzZoFlP?=
 =?us-ascii?Q?xtr0oQmigHOQP4HWhp2u5or70kPMy+okg4aOD4qO2zCX4/h0prdMuyfUvXqv?=
 =?us-ascii?Q?5mi7KwZ3m1N7sSThZY8OHmgXnVjWZInjY8ocHD8SS/Fa7OphNiw4Srg/iZP0?=
 =?us-ascii?Q?J73ncgpY7Yt7iasx6kL1wmf4fQnHGpoNNyKv3j99d7Nsl1T/67N4RXMIiPGY?=
 =?us-ascii?Q?Gb2tTnC/0XP0nDIM73Xi9atQqqnEhf83tMT/BUDNBY85E0Q5nlG57hnQUHLJ?=
 =?us-ascii?Q?9n8HXb4pqIg8B6uTu+nDgy+JfB4eVvGYZU5qliHxJEk9qL/UGgC44OgDaKor?=
 =?us-ascii?Q?qB20dsP70esrLUmuyqyG4/Q4jAtTbEamqIoFy1yf9BY3iYNdiwC0k5N1Wjkh?=
 =?us-ascii?Q?qX/KZN7Gf8yGLSPLKwG0GosHKl72W1EpLSF7hnUGKSiY596VdsCunrHdm0sk?=
 =?us-ascii?Q?vbQ0eZV5wYExK7J02yvmg8Hj88Q1ryjBisMLYA/2l+qE49A4MFtDNp1Nbzou?=
 =?us-ascii?Q?vGDXw3gGouvGbNs0O0YHIMrNF1fRQEZl5BMokNux34FsEmommyYKyR1FbcsK?=
 =?us-ascii?Q?4+N8C1kwv/0hJRjxZrn8cyF+QSu6YNNPIvWIr1pvTnro/1dXtNqu+7buMsQv?=
 =?us-ascii?Q?Ag0dmC9az+U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(19092799006)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BTlPkOCjhbzpZMkocwM+IDar62og47xt+FpKrcS8e4rtcjY6e5+iLAcwKS33?=
 =?us-ascii?Q?4qsI5lMX/2SG6nB4AL3EtKZF6TpcwIJNZx4AF7a2rywkAzsgPMuWx0Bf4V64?=
 =?us-ascii?Q?BaCHp8UDBQW/MY5PmZknE+fLxRZ1v0x5vnJEMPK0mOTG3HdasWNugCQzFDi/?=
 =?us-ascii?Q?b9mZqR8dKwvKr0WgfPcK/Kdve2sFeOEVtyUFF0SVFVFzfjX+AFyse/hqebM6?=
 =?us-ascii?Q?fxhktdQuXjF88vWaeTpQjnbUxIw8+3V7RYnd5BtE+5TR0476ev6KU6OWvjdu?=
 =?us-ascii?Q?Y1WOdE7Mxwy7Fu8G7hfqvH+rZ5E0AB8aYDYkaEhikBHZ9xVp90MPYA3Ci2T0?=
 =?us-ascii?Q?n/wLAQuNe25zgyA74lnR9vTL/inUTQJFDyd82soxH6/LuyyTI8y877z7jkPg?=
 =?us-ascii?Q?IRzLP8sD5SSVeuYbVH9Q9A51P6AEpEKtAJ0UU96HabAraLefb+lUYs01TVrz?=
 =?us-ascii?Q?Xs5wOhwXJqMwoSTXhAm8vWfBoZ8q0xeqGQQuxXK8pii6NNwnbekedShQPXqf?=
 =?us-ascii?Q?x3mWyfPe9X7LZg97+heNg5Kkg1rzcxkSV/qFRK0kE8CZolJAbOhfOtyxWz3+?=
 =?us-ascii?Q?lLGrHYN+nGlUYews6MggYTP4ANWkp0HjhndgxFBZct+KHyoN7Igxx251Mw9q?=
 =?us-ascii?Q?gFylAY/iHSG3STeGENGhmHQlR6CuSMwxF6PE62f2jywMYcWXj6YUx5zJKC4J?=
 =?us-ascii?Q?aeMPjp72gehJTQjw7IX784/pM6lH3JcXpGWp2OFOhxAR8OUDyusfzXNxu56l?=
 =?us-ascii?Q?/S/ggr2QJuyL1zLw5njfRvbjIzvWKgVmxJhRCN35mKEcr4oTfxDI39wcH5f2?=
 =?us-ascii?Q?zGLXhqfumsFTb4n85BUcJ0SZqCqudp3DvFdiffQOb4i3EpOJe3OWbnNxF6Po?=
 =?us-ascii?Q?K2NObVqFuH7lcBdvEMsvkfdA2ClV9y+mqa/UdrGTH8VTHbNtVjifAgezarGF?=
 =?us-ascii?Q?tsrJH4YJzit53gk0p2GUWeBMT+Zcjh+3QeBsb/Cn6k5PwQ3cZFg3FszffV2b?=
 =?us-ascii?Q?VGGHl1vhp7cz700MzqLR/dpcotcygmM5rFEU5Nass4lyzE1+myzigWjFQBJZ?=
 =?us-ascii?Q?Lr4nS3oyB7nQM10Z5kGms4Q2+NO9LHyxGlqNtpi41ci3qJpHsY7JtxYsmB26?=
 =?us-ascii?Q?ythBpiYvNtbYvprzj9nznSjZFGCw/Ag7BDBF9n1uwQuXT1DCxYatKims62vd?=
 =?us-ascii?Q?FGsePgkyd4S+3renawfA50UY5/tUH7Nzyo636OvKbqDsIOCinQo9Ezw80peo?=
 =?us-ascii?Q?bslUR4OLgzM+qdBqtkrlDRzLiMmZAddOerwGwyPd9QtuUrf598pBA1P22GkY?=
 =?us-ascii?Q?zdKz7nwodrvQLLIkytuyrSiqpDZKKZefasxy2F6ItymqXCKUavkN+lyspl1m?=
 =?us-ascii?Q?AGQeH4d1LeCaWvqTjD62C5GsabcND/a73K/x45a/7sEhGyvF7DYvcEXoLClT?=
 =?us-ascii?Q?pQUfEpizf7BhY6csQj4RHPF/YEO5ublD8o4PT5PD4RJyd2fJkSp1GZ3pVgZX?=
 =?us-ascii?Q?ZZBD93G5OlduQwZsZdYT7mXO7xzJGWr5UgeA6wdOXd+xP91nXY19od386alz?=
 =?us-ascii?Q?22ta25ERl9ma4P8WW/1BdEWoOjQeV6cQAW48gXOzP9DjQKToDuQW1RHJmxb2?=
 =?us-ascii?Q?OIHDtcrUNpiGPj7ZDscuJP2BbMbTJT7AC2azxWphBclmE2ti+sR5+wYMCQcP?=
 =?us-ascii?Q?ZRXRmg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 306cf907-18f6-420c-690c-08ddc2c18b2e
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 10:31:07.7850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BjKXqsAk9NtpaAapXfeStpgoe/sWkbjnLhopK4RBQycKjX0wnyghjo8BuKFhNyWRdcN54N5gRI2i3uFhxn2LzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7049

On Mon, Jul 14, 2025 at 01:28:04PM +0300, Wei Fang wrote:
> I do not understand, the property is to indicate which pin the board is
> used to out PPS signal, as I said earlier, these pins are multiplexed with
> other devices, so different board design may use different pins to out
> this PPS signal.

Did you look at the 'pins' API in ptp, as used by other drivers, to set
a function per pin?

> The PPS interface (echo x > /sys/class/ptp/ptp0/pps_enable) provided
> by the current PTP framework only supports enabling or disabling the
> PPS signal. This is obviously limited for PTP devices with multiple channels.

For what we call "PPS" I think you should be looking at the periodic
output (perout) function. "PPS" is to emit events towards the local
system.

