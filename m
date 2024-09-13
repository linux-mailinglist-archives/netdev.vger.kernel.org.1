Return-Path: <netdev+bounces-128150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9F19784DC
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 17:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5E60284998
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 15:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A94502B5;
	Fri, 13 Sep 2024 15:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZaG1hD+6"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013057.outbound.protection.outlook.com [52.101.67.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2E039FD0;
	Fri, 13 Sep 2024 15:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726241394; cv=fail; b=IoaNBVtp4aO1jXfTKSEnOypj/5TXHbsi0pjhoB9uqgyJfArTD4b14rggNKqsUOiTIh8iSwXST3p9dOk/G37jE/9FiZ0qOy04P65ZNaGPD+zXvYtIVi6nIB9jiy9zK+h5eXQe3i+9DU8SqVkJuKOycTE8i7rEBJg51fBPhHaiXP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726241394; c=relaxed/simple;
	bh=TW7bC+EMo8EM2a/+zS+vxFKaYPJ0w7WjonrQ9anwBzI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZmxPF011Cuufm9KFgcSGGfeUQAzADDqN+f8h3nxUX4lxb4v+CBQxWUyGqOAu9cBNB+DEn51WTMzJpdo/N94BVAS2qLnrKJakyhAzKLOas2o0CuoXtdp65YH5+STZ5Q7HOgCo9NFkMoJomWot/+Fg3EDEVKpk0E3mn23orkHJLNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZaG1hD+6; arc=fail smtp.client-ip=52.101.67.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L2IhJc/X45MsIQ/CftXpzatTJBVo4+0olmxKrabshWG/R2BAfP1hKdAIGZewLLDZkDAdb7ItyEItGUO3roiSmPHqtV5Fld9Ce07oPd2mUVXr5FvN0zxIs7YBnY+k9V3oQJR9eEozpqHgQ8wUPsCZ+tYilz6kt+DNSyvudZhQa4rSoeVUrEYtVnSOfjMixl72CuifR0hjXwFHaSJg5cgXV2t7fYVav14r1Fp60+jFD6HP70Cfb+SmPMseftXr2CN1lNqvBuomFLHRp9ug/zcHzOAOujGi6wwBV7fV1E8YB2ltNUm0ujLfL1dG3XduLrFabhCryiOxW2EK9Mk+KhJbMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tq5vjG75ICKRqDau+yV+so5BrH4xQQBHKSvjhBIyuUc=;
 b=OmZPf6yZ51F/hDiDMAfoSFG1GxYp9BKYz+Um3xy93KFtwtJyIAhmerBxTOhPhJQvXlAOnWPRMuewfCM20JK7HYe5Kpmg/X8Nf2tXU8mmFt4iNwqJm0HIDM6ZH3CPRVDYPLZDfdk5oPgzdqYxxLzMzhwZUHzy6ETkQRlxnnt+oYHsuxQTB4ztZwHq4tdpxttIgDYeF/4pffsYKZT6oIcjATH/fcJr85TKwQo4/duSYCFMohV81O5GDJJD95CfaJ4y/ZDi1gVote90EbdO+uIh5JbzXbxdI9TvI0ttXtW5FCjfQ9tBCsRWIreRrK57IDMny4tyGjnnLYm6WlygjLHtzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tq5vjG75ICKRqDau+yV+so5BrH4xQQBHKSvjhBIyuUc=;
 b=ZaG1hD+6lvjzRgWbYKlPM3mXKTAZPLCQsyPaoBgeWCIYkQk0hSyUgnqAeKYRcfx24vlB+zyhC75tTNqNZBhBA3OrgNmJIAQzl2riv+c6RZnifMd2IB5R3acjrDLT9ESS0YVhH7xpArurBxjZgObgu9FVMM8r/gCVG/PZPVEDnAxMTFTaoQHgnEMeANYQWxlJT5xyxGC/eZi/AGcVPI5U1Ds7VOThixD2pSIW8E6/LfSm4QeLkRWl3A5qjCgaKE8RHmm/r+zNHrIOXa6kR1cIH7oS9o8T0vVM7arRQ+cRPDaUP6pynhEjGNCu6H61bZalK8zQPCXvGlwK1h1kSFcz2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI2PR04MB10859.eurprd04.prod.outlook.com (2603:10a6:800:278::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.19; Fri, 13 Sep
 2024 15:29:47 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.7962.017; Fri, 13 Sep 2024
 15:29:47 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Petr Machata <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next 1/6] net: sched: propagate "skip_sw" flag to offload for flower and matchall
Date: Fri, 13 Sep 2024 18:29:10 +0300
Message-Id: <20240913152915.2981126-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240913152915.2981126-1-vladimir.oltean@nxp.com>
References: <20240913152915.2981126-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0005.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::18) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VI2PR04MB10859:EE_
X-MS-Office365-Filtering-Correlation-Id: 77f70d8c-28bd-42ea-7d80-08dcd408e6a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g4Ls7s574TlQGwdbWMWhdHhLOA8ODsItgHCxZ5KMkiqp2ZxeIqJ8pCwEPc0o?=
 =?us-ascii?Q?4DePSaLUeREAmvoyjB1uyBvp/BCbmeI4oJ9b9BJuKC1NGg8jXvohEhj59107?=
 =?us-ascii?Q?wcGbnt5fcZ34+2QPIJTcjO5hqB7A11ISi/YZl6wjzyJgMiok50joQNjR3Rs8?=
 =?us-ascii?Q?/A1vDKGqXrKbc4xw2ALXj+vdGwbCqqwlFB0O764agB9vBYlW0K2YvbGWYXXV?=
 =?us-ascii?Q?qj1YXIyM1rRuxJqn91ArtDgrBFpAiAyDJCIOWa6U95IKda9H/LYqf+pmRVfh?=
 =?us-ascii?Q?E6B4KvzeYRQjju+KiZMgwsRjcJXrM5whKj6vXFO4/OltnHnUFGf/1OqljC+G?=
 =?us-ascii?Q?9moXS7t9T6I3eflS7VK/wKTewgoLuZvSYScYaMcztJWvuO/r7JPJHFxNztr4?=
 =?us-ascii?Q?zNDYQseTTG35/vpNqKG+Ofa662VOUzKXtq87FadqYOcMpzQ+5EQoqxEgqnth?=
 =?us-ascii?Q?SNLR1niKEUnEVPuq3JzrE9H0uoAmjgT6UY1zG/aBSz/8ZQV5wW9HswIW56pJ?=
 =?us-ascii?Q?WykVLHB/+EfI/4Yv3NIMf4qXQbv0psJKDCQJeHpSCLCSK2T03eK5T0fjejH7?=
 =?us-ascii?Q?WFrCO9+2yGNAm/oUs4MBGIdXbr6aYnM9uExKDgYBaXzXARvnCwkDi5hA9Lkk?=
 =?us-ascii?Q?dg69QZhV5i7vVa5R9iBn6UnuNVK6rNUWbjUPjkrpvoDUBEkeDqhd7HNNT7/+?=
 =?us-ascii?Q?hG46iop36qiRrcn3Am5rIEZv0D5pWojrvSwjzd8LBuSPRtprTkdD3ksaOJ2g?=
 =?us-ascii?Q?M3fB69RRJ7DhfAGU/5W7T44DHdN0nKXfk5DX1xZ3pYvj4LNdyfqf35EYkNLL?=
 =?us-ascii?Q?0zXvniBTcWTHBrKKAr91DpJRZBs1D0Q05rwrEsssmEtO3ZBCeeDKMG09s2Hz?=
 =?us-ascii?Q?tCgjsbB628xbd9H1e3uxox/klWZQ6gUJP1I+nX7+m/s6BGsmnbNb/Vveb0YY?=
 =?us-ascii?Q?VjkxRpc9LU4GHgMDTanzXaXscFmk13yihB1Bnji/X8m2SlLJoq1GXNLQeDzk?=
 =?us-ascii?Q?sncdL5GLiBfvLGCGT4W3sFEMCbdzgh2GYcQV7XtC9XFFGkmw1HIDDoNtIvHv?=
 =?us-ascii?Q?IFx2mA7B3zbwRi76EYXmEBoUkS5fpL3xvXicGi+7vx1cCAtTLG4o5SIlOAjN?=
 =?us-ascii?Q?wnHjb5b5Nnw8mEd6KrpFooTGC3XFqjAJ/JgmF1jIN+493YlwTGjYFdbM4hIr?=
 =?us-ascii?Q?lQyux+EtUbdwN61+DDjffmCHyAYDHKirAgSQQJEZ9LKC2EaWlfC9H97p/Ri5?=
 =?us-ascii?Q?4NdeNGpchslgKnix3i7ROXnU2OcUj2Vr1cds9EFf65BDsT40NWRKv0Qux7Ys?=
 =?us-ascii?Q?hYEtbodUhHubcygh93XtLkwswPeUoK/LoggRDaj3QoNcnGgGpx1TC1CxYTUB?=
 =?us-ascii?Q?HkdQoli1DdmEMOm+sJ19fbPAY7YvRc4Wnb461nEwK+qtFf14Mw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4lk/0bc+L3fqXbOa1Wn+xEQnN69LTtHvVma8j2hU6M3sM0GRsWWnsyclqOcT?=
 =?us-ascii?Q?YtneoJLQAcoGZpsR5TjrHx3LGBDUYg89RXDYwSfW1KyxSZjvGjMW8qZp5Z6/?=
 =?us-ascii?Q?6sD17pI6j9LhYATqU0nkNNo7wQF7mMNB653eIWuNEkr+KT9cDDQHvI8ss2ta?=
 =?us-ascii?Q?hBmXBrGKmJpiA4MG/ZbUqlyZQMCtU1d9pqrE30NUI1uC249OlE8QiBGWsx6y?=
 =?us-ascii?Q?SQQiUSRQlOtVb7Wi/a2MtjWOonOTIpQs8PxOyCHFqYROiPYR1N68jS3G6vsr?=
 =?us-ascii?Q?PzpAyxrT9YL6R75O5Er14EF0MW3lS/duv03XWoSEdkqoM1vGzxP+MSCbrgLl?=
 =?us-ascii?Q?wBylVlLi31aia1vYNjPky/2u9/nz1Wu+F820B5NkTfAAzWBcuhK9pDvuI+S6?=
 =?us-ascii?Q?BuQdVIPFSVkyrlZx2M7RSdTGg8PHPNQVg9ZjHvT2bSn55+TfxtVGyie8f019?=
 =?us-ascii?Q?k3rC1k+dxvZFCaxHdy268CN4pPOWOfTI7Fh7gIf2sox1ZdjJyxD04TDu7vFo?=
 =?us-ascii?Q?alUTO11ahI9Q/5uO7DAZSdUQRWtoxlkSObXXRtZ8i2KrywpP+IzPkL9I9Qcn?=
 =?us-ascii?Q?45pkKYO1FiKAG8nnCoEfs19RPzsjtbZJ5uekv2x+AvWSRbdiaSaWZuHtUaEd?=
 =?us-ascii?Q?cgzQBhdu2WdHrXyD03xDZmiUqgPjy82kQ/CudSQIU7LKC2aVen4xQ3lcpFQx?=
 =?us-ascii?Q?7CxBiXqM1ttNZWLtddX3+ZSC3Wqo6tSrxUSzkVW8S1cJvV53JvaOEe3L3pYz?=
 =?us-ascii?Q?ys4KlAeZizsBi4eiRXQB/3J9HJDxsIGGYxA2MUwDeZet8hFUae48Ic8IKfyo?=
 =?us-ascii?Q?EywU0R+RyRBycbvSsF03v6N3YnjLMH2BQq1fGchSUHaeDLRQxpciTBVDFCn8?=
 =?us-ascii?Q?ajaICHOau1GqmIb53GIDZtmC4cgkt7tL2VX4/GACb6U5UDDpXjHdZbQSdcJa?=
 =?us-ascii?Q?d72AHotFXJSYU+DPSDnRE8f8OY1e1QL5UfVRrGDQaZ2lo4deA79TND1lzxW3?=
 =?us-ascii?Q?412DpoG1+Z/gyWze47TtiE6HZiL2qDv1H6THUbpmci7BC5z9Y1A6YCy/pHRU?=
 =?us-ascii?Q?Tt96rjw0Ekb6AURTky+WvEHLJ1gzSze7AwEVVCSOJhAVzDnWagYo25jW2ahj?=
 =?us-ascii?Q?Ev13GSTn7u7gxxiXf+AknAr4yYNJyZoYgyTiww05WAemTIU2Oq0gPXP9OGgP?=
 =?us-ascii?Q?xeZ8pFF2bLg4wOXDmZ8HUaUEnLsGSnNIFyPl4bU0D4CY81LRg+rAuq0bZAmg?=
 =?us-ascii?Q?1Zxh1dW6gQP/L/6AfbTKD1FKVGhGqLnRjajTeE5JZ9jmMAvPEhK1PIlAzhBP?=
 =?us-ascii?Q?i2xxRx/ff6/ssP6EhD5+61UyNfd7ND6j5kjx+6sXtmnK/uDmADUBoHNdGRsL?=
 =?us-ascii?Q?TPiW8tWl4HblNAc5pWkojelgcZUatcdKUnqeIeOafHDOt+W1Pr8mlOM/S775?=
 =?us-ascii?Q?uRTdDgdBR5RwvJH1VhGOt5V3YeadnZzT2fQnEPPauexyvZLg6Y9g61eUiv6v?=
 =?us-ascii?Q?DoOrrb/qkDFHYHJJJJUd/sRZpPRHolbBfSX7WH358D4B1Aed0x54x8ZUX+FF?=
 =?us-ascii?Q?WCnJXsJpegg6h8k9sYqbEr8mbmTjvs2mfJB1jLWdlGSdHVK6QNZ5/sdWPawD?=
 =?us-ascii?Q?3w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77f70d8c-28bd-42ea-7d80-08dcd408e6a1
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 15:29:47.6573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ofde0l30xObtNm6+Soy47LGZaR88SZYv8AjTDG8ZF0rl2DlDh5oBye2t558zAeMzP+uwjwr1Ug8H12g++gghTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10859

In some cases, an offloaded filter can only do half the work, and the
rest must be handled by software.

For example, redirecting/mirroring from the ingress of a switchdev port
towards a virtual interface like veth/dummy/etc that is completely
foreign to said switchdev port. The most that the switchdev port can do
is to extract the matching packets from its data path and send them to
the CPU. From there on, the software filter runs (a second time) on the
packet and performs the mirred.

It makes sense for switchdev drivers which allow this kind of "half
offloading" to sense the "skip_sw" flag of the filter/action, and deny
attempts from the user to install a filter that does not run in
software, because that simply won't work.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 include/net/flow_offload.h | 1 +
 include/net/pkt_cls.h      | 1 +
 net/sched/cls_flower.c     | 1 +
 net/sched/cls_matchall.c   | 1 +
 4 files changed, 4 insertions(+)

diff --git a/include/net/flow_offload.h b/include/net/flow_offload.h
index 292cd8f4b762..a2f688dd0447 100644
--- a/include/net/flow_offload.h
+++ b/include/net/flow_offload.h
@@ -692,6 +692,7 @@ struct flow_cls_offload {
 	struct flow_cls_common_offload common;
 	enum flow_cls_command command;
 	bool use_act_stats;
+	bool skip_sw;
 	unsigned long cookie;
 	struct flow_rule *rule;
 	struct flow_stats stats;
diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
index 4880b3a7aced..7b9f41f33c33 100644
--- a/include/net/pkt_cls.h
+++ b/include/net/pkt_cls.h
@@ -782,6 +782,7 @@ struct tc_cls_matchall_offload {
 	struct flow_rule *rule;
 	struct flow_stats stats;
 	bool use_act_stats;
+	bool skip_sw;
 	unsigned long cookie;
 };
 
diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index e280c27cb9f9..8f7c60805f85 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -480,6 +480,7 @@ static int fl_hw_replace_filter(struct tcf_proto *tp,
 	cls_flower.rule->match.mask = &f->mask->key;
 	cls_flower.rule->match.key = &f->mkey;
 	cls_flower.classid = f->res.classid;
+	cls_flower.skip_sw = skip_sw;
 
 	err = tc_setup_offload_action(&cls_flower.rule->action, &f->exts,
 				      cls_flower.common.extack);
diff --git a/net/sched/cls_matchall.c b/net/sched/cls_matchall.c
index 9f1e62ca508d..9bd598f8a46c 100644
--- a/net/sched/cls_matchall.c
+++ b/net/sched/cls_matchall.c
@@ -98,6 +98,7 @@ static int mall_replace_hw_filter(struct tcf_proto *tp,
 	tc_cls_common_offload_init(&cls_mall.common, tp, head->flags, extack);
 	cls_mall.command = TC_CLSMATCHALL_REPLACE;
 	cls_mall.cookie = cookie;
+	cls_mall.skip_sw = skip_sw;
 
 	err = tc_setup_offload_action(&cls_mall.rule->action, &head->exts,
 				      cls_mall.common.extack);
-- 
2.34.1


