Return-Path: <netdev+bounces-207917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FA2B0902A
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 17:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48F291648A5
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 15:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E862F2F85D8;
	Thu, 17 Jul 2025 15:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hrcAAz7P"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011066.outbound.protection.outlook.com [52.101.70.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6945024EABC;
	Thu, 17 Jul 2025 15:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752764794; cv=fail; b=i2lQGK4yepfktENNKWEQB6m9mEVwkM1jjaYLuLIf4oSXFJEPnPQfEY9DdRsVJjUGoGqzRvasHFow481OjSq0EJCM4ff2nh3Y8WIHBsyW8pY1FwsmJTDIqKq4kuQqIIVY6v7IwA3PoYsAw7mvWrKEpzJyD2XA1xWfRY+ZIYMfSDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752764794; c=relaxed/simple;
	bh=RXY4pT1tB95HSqiWSJF5CUU0kj3DGRBoMMYPFBAQdro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sGxRlc49L7BQJOxYd+sInNr4WQCQM4Xd0O/WvT4U21i2JT59dNZazDEkes0cstCczt4Kz0RN+BKLpDyAnETyIjo0fqa9xMbFdAgeMw8ACWW9RqjJymCRIQ3pqW400NDEqzXc8lntmx9W2XdsFAql5Cf1cP28QyISrjwxk1wUxZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hrcAAz7P; arc=fail smtp.client-ip=52.101.70.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zP1f5w+pRVz/ZBO76RSFHFgeay1m/xqQvKeYmq2UNx0ZMOrjRmhnG99SLq/aUD+OvcPWD5H3u1JM3u+DZ+Zs3OoHgH/uL+KFbScMwuIacJ08tKMmc6joJ5Bwr4JDGd/mTmn5bs0UdplpKq8rJauRSDlA6M4+ldpvZBVJE/Lyv0c94qFMWfrFfujPt9zP5slKVTVLGOYXV4naMsjM5Yb00kP2bXUlyHn+d74GplYzBL0eJBAoq3TQT1Djf+xVVR1cOy7WJiJIlYyMTn8F7LVEt+t5Sws+5HBZo8hczGE7SErgUtqMSXlo1QzwHZ4bip2GwNe9F0SeZcM56bK+am7F6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RXY4pT1tB95HSqiWSJF5CUU0kj3DGRBoMMYPFBAQdro=;
 b=WywmQy+qJQtHsFrDgNPI51Z/oQ2dWpZ1Yose8bD+IZ9kQn5ss0LnfkG+UPQrkKVQdBY0+al6ni5ocuQxBeHnlvpDPOgOm//IySdTLZVJvMoRG4wkc/V685AINmZ8tooPdEqdNb+sG685Kx7T73BYxwiYSJkghnCFP++rHHX4v7bl3NVrky/oV0CSmlGarmwEq0wxacWgJYbx4TDLwPVZcWvF8iHN1mU+v1ezeQVjHpUf+WQ+Y6ikfVwXQrciT/9xahKYPp7z+1mHxd1bwsxvbewI9IJi1PhvZ+p6T23LQYbjNd4+rqt7z2kMuqXIDEWrMZisdPox8xrxvt7c4KS4Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXY4pT1tB95HSqiWSJF5CUU0kj3DGRBoMMYPFBAQdro=;
 b=hrcAAz7PGnbOKbIbwJD9Lepr3BMoLp38G7ph12Pd5VkCrJKMyr6bF1IYJrVAzEeqLVZmkCBvofvP98jikLsTIS9UErHFBkKh/YZPIPP090rPbP+05XD5xWqTU7KOoYBGk2Tb0BAMlB2HgVPSFntpxBUFQkYIki7a6Lx1s89+YsRlww0JijGaVAuOD4nSH1mkIYE0C7tNzVd+OQx1Se4yP6JfErpozeTvbIWz4fPXayTMsUFZGQhWXl5PbNIdjec2TSDXdOawwZqpS+VjuaWE4NmJuDSU6TFQRUGh6PoMNuq6VfejYAv6Cd19xnvlrcfA4e88JY/ZsAs1J3EDpdQgnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9865.eurprd04.prod.outlook.com (2603:10a6:10:4f0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Thu, 17 Jul
 2025 15:06:29 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 15:06:29 +0000
Date: Thu, 17 Jul 2025 11:06:20 -0400
From: Frank Li <Frank.li@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Wei Fang <wei.fang@nxp.com>, Krzysztof Kozlowski <krzk@kernel.org>,
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
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"F.S. Peng" <fushi.peng@nxp.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v2 net-next 01/14] dt-bindings: ptp: add NETC Timer PTP
 clock
Message-ID: <aHkRbNu61h4tgByd@lizhi-Precision-Tower-5810>
References: <20250716073111.367382-1-wei.fang@nxp.com>
 <20250716073111.367382-2-wei.fang@nxp.com>
 <20250717-furry-hummingbird-of-growth-4f5f1d@kuoka>
 <PAXPR04MB8510F642E509E915B85062318851A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20250717090547.f5c46ehp5rzey26b@skbuf>
 <PAXPR04MB851096B3E7F59181C7377A128851A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20250717124241.f4jca65dswas6k47@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717124241.f4jca65dswas6k47@skbuf>
X-ClientProxiedBy: AM8P189CA0014.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::19) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB9865:EE_
X-MS-Office365-Filtering-Correlation-Id: 16c8bf34-1872-4387-107b-08ddc54381e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oAwUto7ZHGviVBsz7QKYbKeHPftF6K/qOwQR/RJG9j3s4f6vgAvDHn8G1AKr?=
 =?us-ascii?Q?GhYt+e0uXeqAXP1/e0bcKfkwN6AyV5P5wzPDZEpwR0HVBveqPxKiPCYmXFw1?=
 =?us-ascii?Q?nAHtX36nN6mFti8UwoYZaXFrR2+a6Awi4mKG07gh4KSWvLSaQX1P9GWWzfX1?=
 =?us-ascii?Q?Nb0c4O63X1Tku+H9+4+1kHUHecUb8MuS3o8DJExlJZc5lb1wY/rOmk+LWgM0?=
 =?us-ascii?Q?h5HMHgryywHjcBR8a0TKSW6mH+z+QVuMVWlBsh49cTbjfYuhwsU8sL+cbNph?=
 =?us-ascii?Q?nobSx2NdAAiB0kfu/c1GhukgZGh4VmtBVvvBdZ+6uekeVe/W2oJR5Z0fmXyP?=
 =?us-ascii?Q?MyUJ122DTt8/SQox+Hcex3lPfHzFz6J3ICnRNz381scptYIrSPoehX0esuFL?=
 =?us-ascii?Q?pJ8ew4BSdVtqNBQW2RP/aaXNWmDovqD0FqYiDG9gvsYUJj4HPWPAl8nHJANK?=
 =?us-ascii?Q?DCdopXZtiCmdUawS5+XWPinPdwnwqOy3Ug63HpLP6oN2INSoe+3mhNn7LA2n?=
 =?us-ascii?Q?pJLljvwQxvk8Ca8xNdNqT6n19feoUfp0tceNzqne0lslOge3vE+gVjQoPevl?=
 =?us-ascii?Q?KgiMonGiAG2zMlJGbc8VLzrSPPs6BQiu9eRsoTPG1TuxF5TWKiJJaqK4Y7lJ?=
 =?us-ascii?Q?z7vDze82j9M6UVCCW5sI+pc/2cCilpFI34T/1C6ivkhFfHJjQ4vTyma5PAMZ?=
 =?us-ascii?Q?9jaiPOBOVsMqKaRs/CxlRJJllhyUlqE0JzmfEaFcu/7Y7rMkESFn7hJHL8/+?=
 =?us-ascii?Q?+VGWqYyoIam4fuRH5YhNCpipgTpKMRc6d9xS4ZHltU5TnXlbg1lfNeUthT6W?=
 =?us-ascii?Q?NVUm69KstbTF0gMbjK4hyCq7XKsyvw63XfUqDhZiUh3/RXOq+M8wgW1aWoEU?=
 =?us-ascii?Q?kPfhhDt6dxkbKnC8kl/tF9z0jRXQZsYFgeOBS1QDSZzOy73t9W1jXX7ZOUDh?=
 =?us-ascii?Q?GVl5E3eccfmpxAcIn3l1weK7Jc4S0UbcYR0ju3U78UuzLEnsLfvpXVk7tI2H?=
 =?us-ascii?Q?MG0O9J0yy2nUtNrnSXse6Lni4Z7Gh3BmnUSVWd3cSItyn+jhTiZDIHYm32vo?=
 =?us-ascii?Q?UQnUFhRokWLfrs0SFV/s4S2scoqG0kla324gRiongFff/GZVY9yjnFmgpL9C?=
 =?us-ascii?Q?Yi5gfGAyo2juSwvfDX0Q/ALAZSXIVYeii9sEVaVxk3julHYFnvC/tzq03d4T?=
 =?us-ascii?Q?9rXxQu1Vc3PTegxnXmuD6DLIQJwmhc8hrvyhrxH+LuaeJ1Br2n6FW8JH+D8f?=
 =?us-ascii?Q?avSNvquPJ961jwJ+Jpu014EtNXhU/iTAHKZH9LaIsPsg86tqfslEH2DIFObO?=
 =?us-ascii?Q?h2W8+vnpG4UkQuvWfradmF11d2+Du0S7/lNxHW28844SYVrbehdH4UHpfSsX?=
 =?us-ascii?Q?rR/eihSJMgDDoJ906Pl53O3Wdj+S8Hoqe7PJ8UOft98bGo6Z2noJ8/XzEQ+A?=
 =?us-ascii?Q?1kjAOqzj70hoNml8Zx51Ex6amRdmq/o6HycY8bCDsVgYu7S1bD8zW5NOYOjU?=
 =?us-ascii?Q?Z9BqFyVki6nxgIc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aNPFWrdjlgp7QLiUZ+4Bc2fy7SWnzhSQ0JTbBPyAoFTyuIYQNtJZQ8IZehvQ?=
 =?us-ascii?Q?QKBKxAErsRnnlOe3msgM6zqWtkaC8HVE8FX5ODDybvzYFQj2C7atWEdEr60/?=
 =?us-ascii?Q?ZOCJW/aY8pdy1VE9xs8OiFOSilmAKlQeqzHMvBPZC5fwfUjtHUMmG7dxeZLV?=
 =?us-ascii?Q?+wBYTj6VTWyPvAWvwbD7HaqE+XW+eFkRsXqU/7mkisd2YCRApGrLSZM9E2xS?=
 =?us-ascii?Q?DM04wXxOQTdxDqLNQuLmhGTN1pT2x2gcYtJy9P7nM+qtgyfumIXuBvyLGdqo?=
 =?us-ascii?Q?16rw/ji9XhNw3vicMpQCfyXI+0JRxZKq9dPYED1fvRZXd0GXLN8ZY2ycIXTa?=
 =?us-ascii?Q?wyn47Fb0ZRg/89CXxrkt+dlsM5Yx/ZwSczr0u1cvkhSP3rk+UrxUkWOiepVJ?=
 =?us-ascii?Q?tnYRvZRmxKg6OmlCrXNrDJWR1s+aNzE/AKiX/xOo2YQWf2CrzxNsTvF7uzrE?=
 =?us-ascii?Q?O56jlLFTsHxs8idvEcCXfsbTurEsBqgGMs5xBjRkSxxOEbchOE5g4zsagp+H?=
 =?us-ascii?Q?Y02ViioJ6Zhq7ZjkbjMrAD73xlBfUOVeA4ZnlEKCBwipvWa/ksxoIi4O/a28?=
 =?us-ascii?Q?pIU6LdaP7tSAmTpPEHtKascuyyPE58Ht7W7wonKEHgvIDY9wuivBgzapQUNM?=
 =?us-ascii?Q?MebrSV8/m/rlLwtTIO+IXLBtoG66iRLdRzPIwzBFOdT5mZiE3I0Yf6hrd8Hn?=
 =?us-ascii?Q?bdKbzg0W7E0UGKlEvVStUcPas6CR2QK6IH5/XSD/RpE1qJ5Kn0Sr6c09KuCB?=
 =?us-ascii?Q?9LiofNFzCLN16IFZ7IJ3quC/+lXOxr8tglz5WM7jvI0EfK4yQSsSuP6iCqmi?=
 =?us-ascii?Q?z/u21gJrWn1t00POleipClNFoqLIaLo9VSN43T95I6183h5xkUNS9oaRK5Jz?=
 =?us-ascii?Q?66d5HLQW0E3cxIIRZqBCmFoWjuENbEFn1BoFetaql4PyKCnxyAIHlofW0VAV?=
 =?us-ascii?Q?RONo1PrYk0dRWVpqDhcJ6NDzlDnGNpOxIB1hVTUwnHBre7ljH4g29pksiLkO?=
 =?us-ascii?Q?6ipRIdRBsnQa5RYWDy/F9KEf/pwWy08WPaPAtMiKPYcaICBINx1yaLsIH495?=
 =?us-ascii?Q?kC7c2DCO8JReVVwEFAoC8kmUuvCWz1EvkKniaDP7dPaX5WuknGzXTlfbSSfZ?=
 =?us-ascii?Q?fVYT4hfApL2upfYRvEB8NHE0JFUG1qVz/KmDctI8hc+GkSx7VYTBHs66uuQW?=
 =?us-ascii?Q?EEpQw/0wtHa1s6SJUKGGNn7qaqlOlynd/M1nBh3P9E/Rb4c3gj0vnuYtLKV6?=
 =?us-ascii?Q?NSa3nfIi0/QX4xlSCK8LFXuW2Fo+ow26zMXvDGzrjWomKGfOqvRzBSyOyB9h?=
 =?us-ascii?Q?+JgF+3L5LU/FqZPlc2apYUMr/Gik65TBBZU73WHIm3kRqglMjAF87KJQB71i?=
 =?us-ascii?Q?5UcpoY+vBfVnkygvvE68kQ9yb7tRVV9k99MasHLYOaBmu2Bt/pb8qz8ZHBNX?=
 =?us-ascii?Q?3MsO4mO9goybayyvLoGYdHiySWrMZhs2HoAQE4Nb4aUl+o6P3XHDWRr30p06?=
 =?us-ascii?Q?Y6u5VGys9EWSvPjNiUZkHtIABAASrd/LVzUVdPVoZlyBYZwLUn+yliVQl2/D?=
 =?us-ascii?Q?KjcL5vXSi97LFSjaRhg4QxApWb+vLW91aDx7iXIQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16c8bf34-1872-4387-107b-08ddc54381e2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 15:06:29.0462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u4Ki4OhxAydnUdKz1GZ3uj4dSzfUR3V0JAfIDqhANuC+lU5DE/IGrNG24X6fVco0i0x3nzDKuVPKmbsBCdV5tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9865

On Thu, Jul 17, 2025 at 03:42:41PM +0300, Vladimir Oltean wrote:
> On Thu, Jul 17, 2025 at 12:55:27PM +0300, Wei Fang wrote:
> > > > "system" is the system clock of the NETC subsystem, we can explicitly specify
> > > > this clock as the PTP reference clock of the Timer in the DT node. Or do not
> > > > add clock properties to the DT node, it implicitly indicates that the reference
> > > > clock of the Timer is the "system" clock.
> > >
> > > It's unusual to name the clock after the source rather than after the
> > > destination. When "clock-names" takes any of the above 3 values, it's
> > > still the same single IP clock, just taken from 3 different sources.
> > >
> > > I see you need to update TMR_CTRL[CK_SEL] depending on where the IP
> > > clock is sourced from. You use the "clock-names" for that. Whereas the
> > > very similar ptp-qoriq uses a separate "fsl,cksel" property. Was that
> > > not an acceptable solution, do we need a new way of achieving the same
> > > thing?
> >
> > This an option, as I also mentioned in v1, either we have to parse the
> > clock-names or we need to add a new property.
>
> I think a new property like "fsl,cksel" is preferable, due to the
> arguments above: already used for ptp_qoriq, and the alternative of
> parsing the clock-names implies going against the established convention
> that the clock name should be from the perspective of this IP, not from
> the perspective of the provider.

The similar problem already was discussed at
https://lore.kernel.org/imx/20250403103346.3064895-2-ciprianmarian.costea@oss.nxp.com/

Actually there are clock mux inside IP, which have some inputs. Only one
was chosen. Rob prefer use clock-names to distingish which one is used.

discuss thread in https://lore.kernel.org/imx/59261ba0-2086-4520-8429-6e3f08107077@oss.nxp.com/

Frank

>
> > > Also, why are "clocks" and "clock-names" not required properties? The
> > > Linux implementation fails probing if they are absent.
> >
> > The current ptp_netc driver will not fail if they are absent, and it will always
> > use the NETC system clock by default, because the system clock of NETC is
> > always available to the Timer.
>
> Ok, sorry`, I misinterpreted the code.

