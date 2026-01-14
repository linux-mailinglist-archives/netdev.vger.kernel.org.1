Return-Path: <netdev+bounces-249859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 729B4D1FB5B
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 16:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0CD17300F661
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 15:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207C6396B87;
	Wed, 14 Jan 2026 15:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="H8g9fx5g"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012009.outbound.protection.outlook.com [52.101.66.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0421A38E11C;
	Wed, 14 Jan 2026 15:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768404101; cv=fail; b=Lg75E0qARYhx6uIqysZhuOoPkKvlhYSSbUyE2Gsm1KDItqnV+sONT3hgZH8sQK4cuMfaeFHnLZClo79JRTMN2o4BZ/elAqvJD2W2JlUeLGcXeCSCfPjzRMgh2RQeP/9wXCl1jyyYHxEr2UWLEmVcCI1AGD06liC0HBOwWCZ9FP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768404101; c=relaxed/simple;
	bh=lPBsuZwNitDYMEzGkmHs2wRlfV0RtQzKGYM7hWN/dss=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PcciCgDI5gJE25hE84OTVck9WSbLcsGgW3z5FYkcFUXwGzGdWu3HJvxePBDe89R0cRF50W0pEON1xzlxZWAbpumwnzIYZ3AyS14Kt+C7dgkrqxglGl6DdhxupIvE3LsupGc80wNtOgA6dP7b4vjUM+855lmqVeYoaHz1C+hRtIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=H8g9fx5g; arc=fail smtp.client-ip=52.101.66.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iMtaCAidwjobzWmZzdELA6vE5jxzmJ7TNamBeg/QcaqmsC0joCdKJ7niyv6DBYnCbar4T/xYebjQUeLg1Tey77phFwp/VlEWpAjW555fsQQ2DKr4P50U4uJyPpNysPjAgkeTtGoHVIXZAfXqxk0Xpz5OwK5M62+Ol3AoUk53iiX2zkQlWh+x404iLcboOdQCn7f36XXxbRWrBJZtp8ZNRhb9yA7FBhzuPJMIWson7DNwQH2zMiGFlIz67D1ILw+r/8Kb2im0L6A5upfofzePucCYrqOR24NiPePVht8875N6ozqYAfD3TSds2Uhpy5pIK6mAL98TrJXHR7M9t94qDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bXt94sygG4GDyOK0AIqSkIk1OcVUInQaiYyD523BQfs=;
 b=HORZ5uk/2ZpqQWw8SLSbolPtBI651Kcr+Emha4cLWUUv6IvGNtXP78/tGvPXOiHR159DAewjxc61LslEhsENtn338LlLKSkAR15P5IyIdhPeeGkrnse68SrnSNaZKvEdzJlb2st2XFB98KytpfKFcfiG0UCsitHWa3b6qYdtDJn4ZGli6Z9jjZbIpTXiskluGm7HRA5sH0nvR+Z1IC1f/6r3LZzeqoceyZFiAyTK/YN5TDu1rfkBjeiFbU7khxCamG61oU3Kq8y//xVwMo/V61094p2xxlN/zl1vinK7qFAKGbBqHUut3SxE5Wk38SCIRrJeXzBoqA15TYyf4M1rbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXt94sygG4GDyOK0AIqSkIk1OcVUInQaiYyD523BQfs=;
 b=H8g9fx5ga90i8vuNaUDx2cxjPjJVXldqS2Z3Wu32OmpW9OWkgU/zAS5MUVNmrclJgVNLzaiTE7nmLrEmltEx0sKW6KgdhMOHvY4X4kEsGnfCsj4F6KLT6CdwpJjizFsRnwEtV+QV9g1SFsorcDhCXeB8akvjzccoI5rerPOMf10hn1uk2HDkNbXp5lqBgVXbJe+5E6DAvWMYxS+6HylBPEtsvbC4gMmLpMsw7yuE3zCx88mwgnHOV9P6ap28Os+/cjeismSyuAcH949/SWoP3Y1W1pEG9hrxlJKg3yvZBZgRydXrYlMDAsDX9ct16cZHBDObIFcsLraFy+PNOJ5YDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DB8PR04MB7068.eurprd04.prod.outlook.com (2603:10a6:10:fe::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 15:21:23 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9520.003; Wed, 14 Jan 2026
 15:21:23 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: netdev@vger.kernel.org,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Josua Mayer <josua@solid-run.com>,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH phy 2/8] dt-bindings: phy: lynx-28g: add compatible strings per SerDes and instantiation
Date: Wed, 14 Jan 2026 17:21:05 +0200
Message-Id: <20260114152111.625350-3-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260114152111.625350-1-vladimir.oltean@nxp.com>
References: <20260114152111.625350-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0015.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::20) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DB8PR04MB7068:EE_
X-MS-Office365-Filtering-Correlation-Id: 99a1f504-f607-4517-7cb2-08de53809387
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f84xO0GJOfOq7rC5Kz5LoID6N0YRErTd9QAreouBv/Lng2poklyNB2w+tr2r?=
 =?us-ascii?Q?eqNRPG4Py63Q++KcBzai+/ZH/kNl7RDTWFOe958rrrWS/F06HatWA586BDX8?=
 =?us-ascii?Q?n7yekF2vtUi5ZlmsNQPHGLxdojY9SK8mKt0wBE5b9lvTlzyUi/iZvv1JLsvT?=
 =?us-ascii?Q?R2swWa9Al5rPlfVXQwXFWtiAddilYXZaC9dW6XMkn4nTOC81kTRvY20xEAF3?=
 =?us-ascii?Q?kV+ygVUsBUL6+obAp0KtwDHSHtXs4ZI8575TDMufk8yl7DYceSI1pfCP3r00?=
 =?us-ascii?Q?0issBaAg38Vm9VtznzdVBSw9UMdq5XB7FgZ0FIsDDgNaPgyYuzf3t3NCe2zq?=
 =?us-ascii?Q?LcuGpdwmjbdCw69N8X8kABX0PKjnmqsJgHqFgXm4Zb607WKiHJE23p21zQ9b?=
 =?us-ascii?Q?FEe7WPCxR15A/zUKLzEo1TjUFI7Aa3VvhVX8W4l89rfMiBGFetTLZxCBAWyj?=
 =?us-ascii?Q?IQEj5DDlqh3XAmQnMB6eJCoHkW5MULF7ClLwyvkA5ksURPjAad0RTUltYGDv?=
 =?us-ascii?Q?9lgCo28HS8zouqTpw99OtFr2QtaXbdTEazXSZFa06Ago0c6Ex1En5cFspUtY?=
 =?us-ascii?Q?9vYQmSesbXe+4Kne7kUUlhgoiZpXTzj+bwrBsUgrKEgSLG3V6NvJ6M5B548/?=
 =?us-ascii?Q?6dLO+J4YoClvq5YWFcM4xBhOb18nl/b8fYc4RnULdg2JgfxMXxxQUaoIgkNi?=
 =?us-ascii?Q?kNESBLR4F8NvxAOia0noVEBTy8Gkt4Ge0UEqbkkzLQsB9p8gjHdNFThDG8Le?=
 =?us-ascii?Q?LqTQvUlgazbu1NDgz2Nytra9g5DtBmqA/NF+uF7LOkJJQEo+jug23cWkhUDT?=
 =?us-ascii?Q?0Zr3kofoxODDkwjCN3i7gG5dU9mz+GbPNzsubPOpFhtvDsOfKGDVrmLBZE/C?=
 =?us-ascii?Q?QtKfo2Y+xplGOAX/KLYwBEmkIKTXWpJdFnJtKb71agLyjqCW/KFetwLiGU1X?=
 =?us-ascii?Q?E2a4FfarpXGekIFfygY1SfLMLpNP0oa/1BS5hPrAmQNp0VAtNiVf/TbmDa6l?=
 =?us-ascii?Q?44N2DWsZd6ra7oyFipCckCYsPzlS38lUpGCOpbb+lz1iw8n0hlqNPFKzt11n?=
 =?us-ascii?Q?B1Fsoa/KdXKiwrGWsJ4lS9VKqsLxmD6bhKfcGlY0ytHeL6cf4B+ps+UK7yfv?=
 =?us-ascii?Q?oR7FHWU06uWl7C7MamzqRKU1scRlws+bwsSQqMQctECo5SyDHUMxKBRKAJQ9?=
 =?us-ascii?Q?6/QF/qyY8jnFVNUuz+HV82nEMGkbLlhfCDQrvPvhC22Qdy1YDjzFMPYRylZ0?=
 =?us-ascii?Q?E+2C3VUUi3gEdlzDPKHILdntx5ZsffYtI4+84vC16v6buPO83o1tds/tltpw?=
 =?us-ascii?Q?WffMqlkmVF4i5N2ej4FN3oUuBywn7h2SIBctZPF07WU1s8SKWClM9C1Je3MI?=
 =?us-ascii?Q?uQI6vLq3jwMIy1Gh0ipW9paILKb/HZ30dzJbMD/qIfUQOIoN65Livy7pd2ZM?=
 =?us-ascii?Q?zXzv2OrsSxuK5BsxT8sTwfaIn/roz2Aul5GosYHOq5xaHrsQRvLGxPIT0fcE?=
 =?us-ascii?Q?+eM4+3P8zoFLKh9a9KYSKopJ0jeONEWSqZ+W7PJkeE0o4cPQz1zz8OqnBrc+?=
 =?us-ascii?Q?JqYwgmPYLe9a90s9U/z31BfM9OCy0rClqSlHEK6l22eqBVRvbAM1zxjBDDFx?=
 =?us-ascii?Q?Rl4EzEiXt5fzsO8oyTGXVlAE6dveia0FmTXJEgnWugFV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Za7DvDnjYapARpZYCSc3Id3z1/JqI7QV5LCSLwsYVP6mAwRRlYxpK3OXV0YZ?=
 =?us-ascii?Q?wxlBRRJDDCzALDpdL9wjThl1r0w4BvyJEOHRGwm9ShHID+APhwAoG/EnT095?=
 =?us-ascii?Q?ymWvmMtq+NT5G249W8+Hp7JEl6W+SbZoUW14CPUvNi+6ocKP4jsnEW5uT2or?=
 =?us-ascii?Q?zzysaO4x4nlxvrVADr8vc0Zbx2U79bVCmuGX253X97iaWOWvugHA2oQGYUU8?=
 =?us-ascii?Q?P4riHLdKaZlm/vW3CMai+oFmhCTCbgZQY0FfFZeHMOqSP/ua26pjRQEjSirF?=
 =?us-ascii?Q?M4Zquvvg/UNb3XL12bdXS1S9QFvbsnQv4n+QAjsWi0wugu5wttXUFdsvR3Uw?=
 =?us-ascii?Q?iIEtFy7QLdD/AXvSY2BSWIZFNk76bngAKi9dulx7tWqn/Uh5SkgIyWu+rAaD?=
 =?us-ascii?Q?CjcKhfq23T60DPpnbv6bOPKwu60iwvZpH2kOMlV1Q+Zd492t/8AxIcE00cNT?=
 =?us-ascii?Q?3FSWYpxvuegpbigG4vLLR7W8cZpfoI5NtBbbAPsZr0japm9fMGX1m6311uuE?=
 =?us-ascii?Q?7vjvRQwOClUp5O5Xm/INISuETH/5sMBfH7k1MUBBw4wM4JMZEIW+ovoUEuxs?=
 =?us-ascii?Q?Or6GYIZwMmfqrncd8mXDFOvZHkpyl4qFh6ut/TjXzz9lVhc9vba3kZ8AOStj?=
 =?us-ascii?Q?9dlGc4SB18aYUqn6SaxBNBcHI+pr7AZdZp/tahkLPT5S/cfFECoP+UcILy2X?=
 =?us-ascii?Q?JI/GBZlX6f9PpBT4huziOhK05oMubEdSlIQShwBguW8cI6BKd4GRcopjCq6n?=
 =?us-ascii?Q?DzVYEvRLFGBKekCXLOE3uvXEyyFfbJgHdksnS/fgdiddo86xlQeXbh4SiCHm?=
 =?us-ascii?Q?qSqG38mtQuieWFyyFX0Z4zhpOU9FxKwEz5KoNgTJvAyTxEp414dzVGrz9nnn?=
 =?us-ascii?Q?cQIe7Y6OULBiNDVz2VEQRJ2Z797Iebf0BlMQ/m6bRmgloTi71USl6zqcuauQ?=
 =?us-ascii?Q?MsJ94FHZ9UaIqe50dYef8IeLzlT5sRlHVs2kaSTS1c7QcM/WAVPxOSg+S5K/?=
 =?us-ascii?Q?lkJ35ps41+QQm9F3Vu/H7RbsHHlHnYy6hikoUhZP+hvniknHrWAUPYG0V7S4?=
 =?us-ascii?Q?N7/nLGY6L8Wy6mHc8mPc1TTShE59tkq1pksngjNN+q5/++5UqPLW3LtTjudG?=
 =?us-ascii?Q?BzwODHyHK/ylSjPcwbpfxPetq/bSytRU45dS2nDyBaf2FoBEeE75CZPCbDHy?=
 =?us-ascii?Q?xuDAHslz7Xc/99T4hRPJZyAl+RXXgbrPcC5tSrXLRwmwN97CGfKcC+lYFlim?=
 =?us-ascii?Q?IUhe97lKKPMjeTib7HVlBumsz3j+yWQjprlm7aQEPSCmvuSMjcfznJ5AbeuP?=
 =?us-ascii?Q?nV4lVwk5NU60oDpsR89P5CMKl/FhruRz75wL44sjmnuiYF9SrHxazseTIOjR?=
 =?us-ascii?Q?nxOIPKdkG+Q/BkTKxp91a7wiASc90CJ6evD/Yi7ODMgAaGaeveIa+zJDKDOE?=
 =?us-ascii?Q?he6UzYmQX21I+TofnOVnw/cXus5tV5ShNUWPJG5YAlZBfkXD9HG9MD9CWNFI?=
 =?us-ascii?Q?Pl7u2jra24GA+FURqWgXB/9pWgqWaa2Hcgh05Vg4z567uXtT1M0cbksHuDHO?=
 =?us-ascii?Q?KtMYD/h400r8jPbPGfA0/pnkohFKWNPh3K9wAb/cmkOI7LrR6Myg1EJ1qcBt?=
 =?us-ascii?Q?e2pfxB4KjynRmZfFWZ596OfKF4CJWpUUPIruvqh2Fzap8CBNczZVAjFitkQW?=
 =?us-ascii?Q?4UspMLVXqCtgldrcHQilV8+kSveK0S2ex6K57r4CxVleOaaPnqKA8KLjfYBs?=
 =?us-ascii?Q?FIhUlL3vCkg0YYnWwIWcog+sCYlujtQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99a1f504-f607-4517-7cb2-08de53809387
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 15:21:23.0381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x16R9cujiqDKWHxZWMpc64jTLKlZ8jrhf12GW2NqmJ5PPOu5XkbyJWgLSUq8s3NnqjXfezcpjA6m6OUAoTPSCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7068

The 28G Lynx SerDes is instantiated 3 times in the NXP LX2160A SoC and
twice in the NXP LX2162A. All these instances share the same register
map, but the number of lanes and the protocols supported by each lane
differs in a way that isn't detectable by the programming model.

Going by the generic "fsl,lynx-28g" compatible string and expecting all
SerDes instantiations to use it was a mistake that needs to be fixed.

The two major options considered are
(a) encode the SoC and the SerDes instance in the compatible string,
    everything else is the responsibility of the driver to derive based
    on this sufficient information
(b) add sufficient device tree properties to describe the per-lane
    differences, as well as the different lane count

Another important consideration is that any decision made here should
be consistent with the decisions taken for the yet-to-be-introduced
10G Lynx SerDes (older generation for older SoCs), because of how
similar they are.

I've seen option (b) at play in this unmerged patch set for the 10G Lynx
here, and I didn't like it:
https://lore.kernel.org/linux-phy/20230413160607.4128315-3-sean.anderson@seco.com/

This is because there, we have a higher degree of variability in the
PCCR register values that need to be written per protocol. This makes
that approach more drawn-out and more prone to errors, compared to (a)
which is more succinct and obviously correct.

So I've chosen option (a) through elimination, and this also reflects
how the SoC reference manual provides different tables with protocol
combinations for each SerDes. NXP clearly documents these as not
identical, and refers to them as such (SerDes 1, 2, etc).

The per-SoC compatible string is prepended to the "fsl,lynx-28g" generic
compatible, which is left there for compatibility with old kernels. An
exception would be LX2160A SerDes #3, which at the time of writing is
not described in fsl-lx2160a.dtsi, and is a non-networking SerDes, so
the existing Linux driver is useless for it. So there is no practical
reason to put the "fsl,lynx-28g" fallback for "fsl,lx2160a-serdes3".

The specific compatible strings give us the opportunity to express more
constraints in the schema that we weren't able to express before:
- We allow #phy-cells in the top-level SerDes node only for
  compatibility with old kernels that don't know how to translate
  "phys = <&serdes_1_lane_a>" to a PHY. We don't need that feature for
  the not-yet-introduced LX2160A SerDes #3, so make the presence of
  #phy-cells at the top level be dependent on the presence of the
  "fsl,lynx-28g" fallback compatible.
- The modernization of the compatible string should come together with
  per-lane OF nodes.
- LX2162A SerDes 1 has fewer lanes than the others, and trying to use
  lanes 0-3 would be a mistake that could be caught by the schema.

Cc: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
part 1 -> part 2:
- drop everything having to do with constraints (on #phy-cells,
  #address-cells, #size-cells) based on new compatible strings.

Patch made its last appearance in v4 from part 1:
https://lore.kernel.org/linux-phy/20251110092241.1306838-16-vladimir.oltean@nxp.com/

v3->v4:
- OF nodes per lane broken out as a separate "[PATCH v4 phy 01/16]
  dt-bindings: phy: lynx-28g: permit lane OF PHY providers"
- rewritten commit message
- s|"^phy@[0-9a-f]+$"|"^phy@[0-7]$"|g in patternProperties
- define "#address-cells" and "#size-cells" as part of common
  properties, only leave the part which marks them required in the allOf
  constraints area
v2->v3:
- re-add "fsl,lynx-28g" as fallback compatible, and #phy-cells = <1> in
  top-level "serdes" node
- drop useless description texts
- fix text formatting
- schema is more lax to allow overlaying old and new required properties
v1->v2:
- drop the usage of "fsl,lynx-28g" as a fallback compatible
- mark "fsl,lynx-28g" as deprecated
- implement Josua's request for per-lane OF nodes for the new compatible
  strings

 .../devicetree/bindings/phy/fsl,lynx-28g.yaml | 33 +++++++++++++++++--
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/fsl,lynx-28g.yaml b/Documentation/devicetree/bindings/phy/fsl,lynx-28g.yaml
index e96229c2f8fb..8375bca810cc 100644
--- a/Documentation/devicetree/bindings/phy/fsl,lynx-28g.yaml
+++ b/Documentation/devicetree/bindings/phy/fsl,lynx-28g.yaml
@@ -9,10 +9,37 @@ title: Freescale Lynx 28G SerDes PHY
 maintainers:
   - Ioana Ciornei <ioana.ciornei@nxp.com>
 
+description:
+  The Lynx 28G is a multi-lane, multi-protocol SerDes (PCIe, SATA, Ethernet)
+  present in multiple instances on NXP LX2160A and LX2162A SoCs. All instances
+  share a common register map and programming model, however they differ in
+  supported protocols per lane in a way that is not detectable by said
+  programming model without prior knowledge. The distinction is made through
+  the compatible string.
+
 properties:
   compatible:
-    enum:
-      - fsl,lynx-28g
+    oneOf:
+      - const: fsl,lynx-28g
+        deprecated: true
+        description:
+          Legacy compatibility string for Lynx 28G SerDes. Any assumption
+          regarding whether a certain lane supports a certain protocol may
+          be incorrect. Deprecated except when used as a fallback. Use
+          device-specific strings instead.
+      - items:
+          - const: fsl,lx2160a-serdes1
+          - const: fsl,lynx-28g
+      - items:
+          - const: fsl,lx2160a-serdes2
+          - const: fsl,lynx-28g
+      - items:
+          - const: fsl,lx2162a-serdes1
+          - const: fsl,lynx-28g
+      - items:
+          - const: fsl,lx2162a-serdes2
+          - const: fsl,lynx-28g
+      - const: fsl,lx2160a-serdes3
 
   reg:
     maxItems: 1
@@ -60,7 +87,7 @@ examples:
       #size-cells = <2>;
 
       serdes@1ea0000 {
-        compatible = "fsl,lynx-28g";
+        compatible = "fsl,lx2160a-serdes1", "fsl,lynx-28g";
         reg = <0x0 0x1ea0000 0x0 0x1e30>;
         #address-cells = <1>;
         #size-cells = <0>;
-- 
2.34.1


