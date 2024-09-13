Return-Path: <netdev+bounces-128113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6944E9780DF
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 15:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF16A28805F
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 13:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC951DC065;
	Fri, 13 Sep 2024 13:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YwK3Hk0G"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013046.outbound.protection.outlook.com [52.101.67.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089A81DB945;
	Fri, 13 Sep 2024 13:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726233348; cv=fail; b=hcp3OmjozWkzdC7n0xPfEsQifzZvTySVmWGVAGOfAV9IF5RcsFJX1yntXJlofql9KdfsTm9RMr9I3RIp7l2zGVSmHQl+SgTtXB0wgE/7Jy+yEBESR7O4VtM+0vqJWJrLnEDNZHeUpJ1mXznHLjMdNaUujHmBRSrLw6CNamw2at4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726233348; c=relaxed/simple;
	bh=Y8jAcM0DwmNS+pYme63HMI063Wr6n8TpzOt7T0+tN6k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ngPV92ZOuRd+ZMyrRpJlvw8HrhhQrK8Es9iG8Qq0Arlsn7KYVvjbiB/7RTG1cbU3w0/MWAAsNHbMDHhqbx69SKOs2/TJ6YMgeuWrVKP4GYw8bnfCaATTc2moSESDAERRtUublLyzGO5rTo2USKj7JPtYS2ZTfU1U1N74ggGiG8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YwK3Hk0G; arc=fail smtp.client-ip=52.101.67.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OR6JubokfeTq3GOjOixHZFIPrTmlV18D/733mbeQw2Wdk+3FWcE5e8ZHzfVsxeaQjEW6cb4gGeiLTuMmwzp0+pojVzq9gS0MTT6ritXT4yzcMlMwwWwYdvnuMiLSyrtEa/bY+FPUJ5iQB5VtV4yPKy08gh1e8Udw4go75JnqLCTWE+Mwn1f015mGZ7lvpzCQ6J64LLaU81pjylEZs+7Psl6mjsNToy7iIfywFr7+gYwdJLLibEEO9FMHwViNduqc82l0aY1IkFxKHrjc5lu5dUiuyhGX0tGVw58TSX2ayUntek72UYKI4Z3xtN2fJOEN9lZ5/1AtlFG4fvFCtz4wqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iOPu78po+cq5e+bR7gG85KCvZtieG9JQiuIfcPzNtUw=;
 b=qi43/++8sijj05vcxFOdza8B6N14PHRuBD2idp9S5y6efc0fRRvGcaNZ/QqwI9nIA0h0Npi/xwHBoR6KH4L1dHNW+KXYduwB9ts8kIGy6tt8gI8ocSdM4aercdS0hyjwIlY07hc5LoP1KjEOgiRf3UUFN9BAotSWkCNe2jqbzfTUo42Sngva0TCbD5X6+cqFIvjFjFeZQN05HieiKGBOe0wPJsiaQF+WFCyUntM8ViRcMNte4J88vU9NbD+BqC9Iw/HkYkhQ+iD8IEKT4yi5AdfMBsyzq1styot6BIe8v8VcZbgAgH36kjVvXAZy/L/TXO29L1pEe/zhM9SDRVavJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iOPu78po+cq5e+bR7gG85KCvZtieG9JQiuIfcPzNtUw=;
 b=YwK3Hk0Gy04kOUFoEmGoKuvdwdOCBGph0FduX9x9QJ33AMe8PNiWJlDyRTLBVU4Yk7navt+RrmgW8C3B/ZOudjQu3l5elkF/bxtOgYbKZzwbYLweQYkRfr3HE3KK4BKAB0pHVKfzgOR2FhOYbL8pbk1UY+yN5LhscTVRrEGNWxzhcR1haIOlcA/gXJIaOPPIDkr24LuDyOFxK5ou0QS03IpNXwuWZQsq1yFPPyWagWL7pHH0lQF1ZZQ1c3IyKZ9JgaGFNC4vLornw5/MAkJCa8r1DyDiNUlocSeEA5gs/icdWSWHZg/2S9DwsufFO2whQR5xSGjIvliuphJ3eMWJIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI1PR04MB6815.eurprd04.prod.outlook.com (2603:10a6:803:130::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Fri, 13 Sep
 2024 13:15:42 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.7962.017; Fri, 13 Sep 2024
 13:15:42 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 4/4] net: dsa: sja1105: implement management routes for cascaded switches
Date: Fri, 13 Sep 2024 16:15:07 +0300
Message-Id: <20240913131507.2760966-5-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240913131507.2760966-1-vladimir.oltean@nxp.com>
References: <20240913131507.2760966-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7b::12) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VI1PR04MB6815:EE_
X-MS-Office365-Filtering-Correlation-Id: 790c0f2d-14ab-4877-378f-08dcd3f62a00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fync746b7aZ19z/eEPaMyYIaIE0IFPFDWSu+G7eSmRk539eA1iTQ7XYvoFVp?=
 =?us-ascii?Q?wSg7mXWWbkwQ4QMMEoBcdmOyhhtRarCdICrTk+VVkVUwzGw/OL71d3cA4AFP?=
 =?us-ascii?Q?pUHi52t6z5HqZswb5VrlwZcZaXgha5OoDkF2O30V694M3SPNxLD2F4YkLm1N?=
 =?us-ascii?Q?8yY1SO5PR+PAh/mDBiDk42MUxDlBedRkBCVxi0DSl0rGVkm08LMW2y9WmSo2?=
 =?us-ascii?Q?/+luK/Sv+KYSRiHwGx2PnP0OkRLn0BW9blxHLyUpI+STmd8ubF5vCHAwf+pi?=
 =?us-ascii?Q?wHZ1DyFc3EhoYNI6hF9fRQSoCauE1m/GZyes/BA0D+zKzG0qfS1k3hDfNT4K?=
 =?us-ascii?Q?TRvwRHax/3za72tnue+N0sQVU8pC9D+xBxTFimFBnAlpD2Cyf0MaYhRCs+79?=
 =?us-ascii?Q?2UcEKXQFC2ItVLSwym4Zu/MVx4Qa3WGPfdyTZZPw5AnJ8AXS9M+vbYs3Xcrx?=
 =?us-ascii?Q?rALdxZ1RBi2OPhC1kjAM1eqT6feNBn43MuAsCW8bUMHrQH46eX+ayZwLjwV3?=
 =?us-ascii?Q?/lj7BjDiv6v5YMUTLeoIDR9Gsu1mfYaF4NKr+jzC3G1DBnKIR+ph8Jjp7Lt3?=
 =?us-ascii?Q?dvL0n/JmMNxrm8+wzitA27MQ/76nbGoWKU2YH/h8k3DRn3Yo8ce2yoe0pWDf?=
 =?us-ascii?Q?O7OXJ5YAj9SNb9RBXVXnSDidzmSrJ8tDlRDJAOTYJAL1KITY7XBhhUtDAc31?=
 =?us-ascii?Q?UYns+V0NNNNLy+7JawqStYl2R8ASZ0QDSCFkakNaIB0eXyAKYWIm5lbJOZ8T?=
 =?us-ascii?Q?EmyLAKWxmFqx050Tp+71UhIiFsZgn4Jijtn9tgvbaHfjTIozuzdQ9o2+5/F6?=
 =?us-ascii?Q?NmLrUy7bauTr8f2ynTBgiO1xrWKGihutExZG5hYQYTKu8phW4S8OrL5QmQnG?=
 =?us-ascii?Q?mcRBo2HVaU/EsiNFagsPo+Ub4eF8DDldRYoWaXn0ZI6d867s5R1sRjoXpREx?=
 =?us-ascii?Q?SuSi31ZXItqRmIDOdXu4RVpZI7QCSd8+ON99raqvHeRNc0MzFJzRoAjfv+/t?=
 =?us-ascii?Q?/WFMCbYuhBX+/pZL4KgnMsVWgfzymw3asP+J/Ny9dKTeTZubUFh2ICOOwN3X?=
 =?us-ascii?Q?QhIb9mkMAWlhSL/G2SGqwQj03NYkpZbmn84zCBe2+dmnpHgqvbH8IapEpzlU?=
 =?us-ascii?Q?BWQqjm+/0MUzLQgWu9bcS+BVyeJpmHgv1McT7QxUA1+er7OMNBBvLVFvSttR?=
 =?us-ascii?Q?W19tM97LjK3+qF/mKccsIJGvAsOHPH2g6HFia89on0MFe1Vv+nv+azLSk55U?=
 =?us-ascii?Q?Sf6Q55n6XUR/vOVdw6roLyRgsdMbUrUA3vXi+tXXmK4ic4i84U/iQ1p9nrD2?=
 =?us-ascii?Q?bwnVQ2A0gI9Mstne4LLGML3V5K6brMn5TgEllZgHdVE4JO8xzr+tAT85u/uZ?=
 =?us-ascii?Q?QfM+jROOmKrlJm2X+RQZ90+qa8tHrxE2la+BR5hi45VICkPn6A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3n2YGvYGd3cf9s42by6UBQwqFcKXP09S13GKZPY5RhHxQ7X8G5Ci9+YwAL8D?=
 =?us-ascii?Q?T/Z3Giif32cBlfXY+6qDJ4ZFau6AwQpUrlVyvqgqXDmxOTp+Cj61Whn+AnKH?=
 =?us-ascii?Q?h5Sc8EIID38wd4DtJRmyNssUpoyirdsEDQc6HH7l1HoQzbmHyYL6XpMZ87GH?=
 =?us-ascii?Q?71Pm0ogscR5kNu4o5eLrIuKsTbDAXoRf9GuEXdZTTPjZofIDlnmARbKRwyvd?=
 =?us-ascii?Q?3pTbaX+/esOYgJB6QN8MwJJ3TCFRx5hVpHXpa+xtKoyH02l6nmcNaOoel3bu?=
 =?us-ascii?Q?L0nWCly7P3TvXv6SxBplPxwuCDP/bjwj+ixqGUtio4TpcaC4Hge+Or8wgIE5?=
 =?us-ascii?Q?UlKPc1oy0p0LnBpgPgpVBpFT/xq6uPAG3Ll0HOl0YSZS0mqvKVfsdtvT+M3y?=
 =?us-ascii?Q?iNYLDqF/OtoILOxnnd9qPN16clwbc5ODIuSV2/OgtxbMq1IFykaDqpj84xsh?=
 =?us-ascii?Q?vtQN5/m2pRWD1woaDobJG+DSg4hsU45eJemQzrdLWEV3GbO70xJZUXb3QAO6?=
 =?us-ascii?Q?VWIwWTe8zgNRjD60GTD+lU0O2CffKzIenxklsuVAQLD5Gp9uJI3Aaa1Q4aEG?=
 =?us-ascii?Q?wZw+GG0WdGyYvb7MY/pUXHm/TU7V5xw6V1tfWlhWcIYi4hMbWQp+ekdH4plF?=
 =?us-ascii?Q?ZDi0Nu/JXggAnAzOydd8a2sWCwZsA56fd8m8uFsSbXYcgj3HpB5qpwKY4aDM?=
 =?us-ascii?Q?wkqlPzZXg/yI2lt9F5LO2IKvLhyCkZrhBVl2uC4CwvhYE9qRRlBhOsr0GtgN?=
 =?us-ascii?Q?a2p8LW1ymk5q3+rNODZhye9kByAMDacovEAd4vYJh3f6LnzD+50xhwSF0zNJ?=
 =?us-ascii?Q?lQ4AIORkwGxbz0bMT/VMEcSTgPM4R05cjtXG8mLrvJVu64WQvW4HWYc+KLEd?=
 =?us-ascii?Q?LXjIk/CW7AFBlGr2eyIFKzAUwrSZrcpLxkCYaz7f72/9+VKKUWHntvSloBcL?=
 =?us-ascii?Q?UZxIt7fVXEpN4vFvRPXDEW494RsSkSK4G9bScafibCuv7r2mARTYbUpA2xhj?=
 =?us-ascii?Q?1+goR9S1oIiR5dW9hqma1abh+ydMW04zaZf67TzfMWOkz4zfNJbdZf0QgXvE?=
 =?us-ascii?Q?gzutp338AV6Bjb2qHJVv1hh2WXvH//moorAjghuQ0RBaS0oNsnjHYZPO5tJM?=
 =?us-ascii?Q?UcE45j55x2wy/ikQLwkkbpYyEY1OewvZ10Ms0pLlASWFPNo4kmQeXG0pItr6?=
 =?us-ascii?Q?plfg+gQlXgPcm0LpO+LvQZA3XW+IiCVZ9ksmjQ8x0exQCL0aZj9lbk/OiJ5L?=
 =?us-ascii?Q?JtPameDzJOF06b+CCVwI5yy6v4ONjETbx2XY+dRXmjthhbgAm5FlpjARnFtW?=
 =?us-ascii?Q?0jtQUQtPCNmOhK0CY7GIelzgT5sYyflG1ovxFCssqKVenOyynBRr6juERR/w?=
 =?us-ascii?Q?lP0PPecCEGAAT0Cvn86hkJ5qAnLkSSgRIh/J/D6wzUUUawJtMXg7vPomvCSA?=
 =?us-ascii?Q?vRj3z7+Xt24v+KyiEZ+FZT4TbL9oKKUEk+N/IyPIJfx6TVGRFfBzvAZPEJ9W?=
 =?us-ascii?Q?Tpxa+qGSEEzoNuSyzp4w+QUkCKN4e+HVa47rUYJQ1ga5tz+h4n8ErsGbRefE?=
 =?us-ascii?Q?b/k1CyGXB463qVQGD9fIMTorpGARo6BwDw+QwnXIF6JB9QV6GhLS+oCaE0o4?=
 =?us-ascii?Q?wA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 790c0f2d-14ab-4877-378f-08dcd3f62a00
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 13:15:40.0968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BtuubBZz9VaYDTnFxstipijO/M0vyYJZjA4a4Ab/pC5nzGp7hhpGxsR3SYtcte5NNUmoPy3VN5QFBdvOIAwCVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6815

The SJA1105 management route concept was previously explained in commits
227d07a07ef1 ("net: dsa: sja1105: Add support for traffic through
standalone ports") and 0a51826c6e05 ("net: dsa: sja1105: Always send
through management routes in slot 0").

In a daisy chained topology with at least 2 switches, sending link-local
frames belonging to the downstream switch should program 2 management
routes: one on the upstream switch and one on the leaf switch. In the
general case, each switch along the TX path of the packet, starting from
the CPU, need a one-shot management route installed over SPI.

The driver currently does not handle this, but instead limits link-local
traffic support to a single switch, due to 2 major blockers:

1. There was no way up until now to calculate the path (the management
   route itself) between the CPU and a leaf user port. Sure, we can start
   with dp->cpu_dp and use dsa_routing_port() to figure out the cascade
   port that targets the next switch. But we cannot make the jump from
   one switch to the next. The dst->rtable is fundamentally flawed by
   construction. It contains not only directly-connected link_dp entries,
   but links to _all_ other cascade ports in the tree. For trees with 3
   or more switches, this means that we don't know, by following
   dst->rtable, if the link_dp that we pick is really one hop away, or
   more than one hop away. So we might skip programming some switches
   along the packet's path.

2. The current priv->mgmt_lock does not serialize enough code to work in
   a cross-chip scenario. When sending a packet across a tree, we want
   to block updates to the management route tables for all switches
   along that path, not just for the leaf port (because link-local
   traffic might be transmitted concurrently towards other ports).
   Keeping this lock where it is (in struct sja1105_private, which is
   per switch) will not work, because sja1105_port_deferred_xmit() would
   have to acquire and then release N locks, and that's simply
   impossible to do without risking AB/BA deadlocks.

To solve 1, recent changes have introduced struct dsa_port :: link_dp in
the DSA core, to make the hop-by-hop traversal of the DSA tree possible.
Using that information, we statically compute management routes for each
user port at switch setup time.

To solve 2, we go for the much more complex scheme of allocating a
tree-wide structure for managing the management routes, which holds a
single lock.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/sja1105/sja1105.h      |  43 ++++-
 drivers/net/dsa/sja1105/sja1105_main.c | 253 ++++++++++++++++++++++---
 2 files changed, 263 insertions(+), 33 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105.h b/drivers/net/dsa/sja1105/sja1105.h
index 8c66d3bf61f0..7753b4d62bc6 100644
--- a/drivers/net/dsa/sja1105/sja1105.h
+++ b/drivers/net/dsa/sja1105/sja1105.h
@@ -245,6 +245,43 @@ struct sja1105_flow_block {
 	int num_virtual_links;
 };
 
+/**
+ * sja1105_mgmt_route_port: Representation of one port in a management route
+ * @dp: DSA user or cascade port
+ * @list: List node element for the mgmt_route->ports list membership
+ */
+struct sja1105_mgmt_route_port {
+	struct dsa_port *dp;
+	struct list_head list;
+};
+
+/**
+ * sja1105_mgmt_route: Structure to represent a SJA1105 management route
+ * @ports: List of ports on which the management route needs to be installed,
+ *	   starting with the downstream-facing cascade port of the switch which
+ *	   has the CPU connection, and ending with the user port of the leaf
+ *	   switch.
+ * @list: List node element for the mgmt_tree->routes list membership.
+ */
+struct sja1105_mgmt_route {
+	struct list_head ports;
+	struct list_head list;
+};
+
+/**
+ * sja1105_mgmt_tree: DSA switch tree-level structure for management routes
+ * @lock: Serializes transmission of management frames across the tree, so that
+ *	  the switches don't confuse them with one another.
+ * @routes: List of sja1105_mgmt_route structures, one for each user port in
+ *	    the tree.
+ * @refcount: Reference count.
+ */
+struct sja1105_mgmt_tree {
+	struct mutex lock;
+	struct list_head routes;
+	refcount_t refcount;
+};
+
 struct sja1105_private {
 	struct sja1105_static_config static_config;
 	int rgmii_rx_delay_ps[SJA1105_MAX_NUM_PORTS];
@@ -259,13 +296,11 @@ struct sja1105_private {
 	size_t max_xfer_len;
 	struct spi_device *spidev;
 	struct dsa_switch *ds;
+	struct sja1105_mgmt_tree *mgmt_tree;
+	struct sja1105_mgmt_route **mgmt_routes;
 	u16 bridge_pvid[SJA1105_MAX_NUM_PORTS];
 	u16 tag_8021q_pvid[SJA1105_MAX_NUM_PORTS];
 	struct sja1105_flow_block flow_block;
-	/* Serializes transmission of management frames so that
-	 * the switch doesn't confuse them with one another.
-	 */
-	struct mutex mgmt_lock;
 	/* Serializes accesses to the FDB */
 	struct mutex fdb_lock;
 	/* PTP two-step TX timestamp ID, and its serialization lock */
diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index bc7e50dcb57c..81e380ff8a56 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -2302,8 +2302,8 @@ int sja1105_static_config_reload(struct sja1105_private *priv,
 	int rc, i;
 	s64 now;
 
+	mutex_lock(&priv->mgmt_tree->lock);
 	mutex_lock(&priv->fdb_lock);
-	mutex_lock(&priv->mgmt_lock);
 
 	mac = priv->static_config.tables[BLK_IDX_MAC_CONFIG].entries;
 
@@ -2414,8 +2414,8 @@ int sja1105_static_config_reload(struct sja1105_private *priv,
 	if (rc < 0)
 		goto out;
 out:
-	mutex_unlock(&priv->mgmt_lock);
 	mutex_unlock(&priv->fdb_lock);
+	mutex_unlock(&priv->mgmt_tree->lock);
 
 	return rc;
 }
@@ -2668,39 +2668,41 @@ static int sja1105_prechangeupper(struct dsa_switch *ds, int port,
 	return 0;
 }
 
-static int sja1105_mgmt_xmit(struct dsa_switch *ds, int port, int slot,
-			     struct sk_buff *skb, bool takets)
+static int sja1105_mgmt_route_install(struct dsa_port *dp, const u8 *addr,
+				      bool takets, int slot)
 {
-	struct sja1105_mgmt_entry mgmt_route = {0};
-	struct sja1105_private *priv = ds->priv;
-	struct ethhdr *hdr;
-	int timeout = 10;
-	int rc;
-
-	hdr = eth_hdr(skb);
+	struct sja1105_mgmt_entry mgmt_route = {};
+	struct dsa_switch *ds = dp->ds;
+	int port = dp->index;
 
-	mgmt_route.macaddr = ether_addr_to_u64(hdr->h_dest);
+	mgmt_route.macaddr = ether_addr_to_u64(addr);
 	mgmt_route.destports = BIT(port);
 	mgmt_route.enfport = 1;
 	mgmt_route.tsreg = 0;
-	mgmt_route.takets = takets;
+	/* Only the leaf port takes the TX timestamp, the cascade ports just
+	 * route the packet towards the leaf switch
+	 */
+	mgmt_route.takets = dsa_port_is_user(dp) ? takets : false;
 
-	rc = sja1105_dynamic_config_write(priv, BLK_IDX_MGMT_ROUTE,
-					  slot, &mgmt_route, true);
-	if (rc < 0) {
-		kfree_skb(skb);
-		return rc;
-	}
+	return sja1105_dynamic_config_write(ds->priv, BLK_IDX_MGMT_ROUTE,
+					    slot, &mgmt_route, true);
+}
 
-	/* Transfer skb to the host port. */
-	dsa_enqueue_skb(skb, dsa_to_port(ds, port)->user);
+static void sja1105_mgmt_route_poll(struct dsa_port *dp, int slot)
+{
+	struct sja1105_mgmt_entry mgmt_route = {};
+	struct dsa_switch *ds = dp->ds;
+	struct sja1105_private *priv;
+	int timeout = 10;
+	int rc;
+
+	priv = ds->priv;
 
-	/* Wait until the switch has processed the frame */
 	do {
 		rc = sja1105_dynamic_config_read(priv, BLK_IDX_MGMT_ROUTE,
 						 slot, &mgmt_route);
 		if (rc < 0) {
-			dev_err_ratelimited(priv->ds->dev,
+			dev_err_ratelimited(ds->dev,
 					    "failed to poll for mgmt route\n");
 			continue;
 		}
@@ -2720,8 +2722,36 @@ static int sja1105_mgmt_xmit(struct dsa_switch *ds, int port, int slot,
 		 */
 		sja1105_dynamic_config_write(priv, BLK_IDX_MGMT_ROUTE,
 					     slot, &mgmt_route, false);
-		dev_err_ratelimited(priv->ds->dev, "xmit timed out\n");
+		dev_err_ratelimited(ds->dev, "xmit timed out\n");
 	}
+}
+
+static int sja1105_mgmt_xmit(struct dsa_switch *ds, int port, int slot,
+			     struct sk_buff *skb, bool takets)
+{
+	struct sja1105_mgmt_route_port *route_port;
+	struct sja1105_private *priv = ds->priv;
+	struct ethhdr *hdr = eth_hdr(skb);
+	struct sja1105_mgmt_route *route;
+	int rc;
+
+	route = priv->mgmt_routes[port];
+
+	list_for_each_entry(route_port, &route->ports, list) {
+		rc = sja1105_mgmt_route_install(route_port->dp, hdr->h_dest,
+						takets, slot);
+		if (rc) {
+			kfree_skb(skb);
+			return rc;
+		}
+	}
+
+	/* Transfer skb to the host port. */
+	dsa_enqueue_skb(skb, dsa_to_port(ds, port)->user);
+
+	/* Wait until the switches have processed the frame */
+	list_for_each_entry(route_port, &route->ports, list)
+		sja1105_mgmt_route_poll(route_port->dp, slot);
 
 	return NETDEV_TX_OK;
 }
@@ -2743,7 +2773,7 @@ static void sja1105_port_deferred_xmit(struct kthread_work *work)
 
 	clone = SJA1105_SKB_CB(skb)->clone;
 
-	mutex_lock(&priv->mgmt_lock);
+	mutex_lock(&priv->mgmt_tree->lock);
 
 	sja1105_mgmt_xmit(ds, port, 0, skb, !!clone);
 
@@ -2751,7 +2781,7 @@ static void sja1105_port_deferred_xmit(struct kthread_work *work)
 	if (clone)
 		sja1105_ptp_txtstamp_skb(ds, port, clone);
 
-	mutex_unlock(&priv->mgmt_lock);
+	mutex_unlock(&priv->mgmt_tree->lock);
 
 	kfree(xmit_work);
 }
@@ -3078,6 +3108,165 @@ static int sja1105_port_bridge_flags(struct dsa_switch *ds, int port,
 	return 0;
 }
 
+static struct sja1105_mgmt_tree *sja1105_mgmt_tree_find(struct dsa_switch *ds)
+{
+	struct dsa_switch_tree *dst = ds->dst;
+	struct sja1105_private *priv;
+	struct dsa_port *dp;
+
+	list_for_each_entry(dp, &dst->ports, list) {
+		priv = dp->ds->priv;
+		if (priv->mgmt_tree)
+			return priv->mgmt_tree;
+	}
+
+	return NULL;
+}
+
+static struct sja1105_mgmt_tree *sja1105_mgmt_tree_get(struct dsa_switch *ds)
+{
+	struct sja1105_mgmt_tree *mgmt_tree = sja1105_mgmt_tree_find(ds);
+
+	if (mgmt_tree) {
+		refcount_inc(&mgmt_tree->refcount);
+		return mgmt_tree;
+	}
+
+	mgmt_tree = kzalloc(sizeof(*mgmt_tree), GFP_KERNEL);
+	if (!mgmt_tree)
+		return NULL;
+
+	INIT_LIST_HEAD(&mgmt_tree->routes);
+	refcount_set(&mgmt_tree->refcount, 1);
+	mutex_init(&mgmt_tree->lock);
+
+	return mgmt_tree;
+}
+
+static void sja1105_mgmt_tree_put(struct sja1105_mgmt_tree *mgmt_tree)
+{
+	if (!refcount_dec_and_test(&mgmt_tree->refcount))
+		return;
+
+	WARN_ON(!list_empty(&mgmt_tree->routes));
+	kfree(mgmt_tree);
+}
+
+static void sja1105_mgmt_route_destroy(struct sja1105_mgmt_route *mgmt_route)
+{
+	struct sja1105_mgmt_route_port *mgmt_route_port, *next;
+
+	list_for_each_entry_safe(mgmt_route_port, next, &mgmt_route->ports,
+				 list) {
+		list_del(&mgmt_route_port->list);
+		kfree(mgmt_route_port);
+	}
+
+	kfree(mgmt_route);
+}
+
+static int sja1105_mgmt_route_create(struct dsa_port *dp)
+{
+	struct sja1105_mgmt_route_port *mgmt_route_port;
+	struct sja1105_mgmt_route *mgmt_route;
+	struct dsa_switch *ds = dp->ds;
+	struct sja1105_private *priv;
+	struct dsa_port *upstream_dp;
+	int upstream, rc;
+
+	priv = ds->priv;
+
+	mgmt_route = kzalloc(sizeof(*mgmt_route), GFP_KERNEL);
+	if (!mgmt_route)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&mgmt_route->ports);
+
+	priv->mgmt_routes[dp->index] = mgmt_route;
+
+	while (dp) {
+		mgmt_route_port = kzalloc(sizeof(*mgmt_route_port), GFP_KERNEL);
+		if (!mgmt_route_port) {
+			rc = -ENOMEM;
+			goto err_free_route;
+		}
+
+		mgmt_route_port->dp = dp;
+		list_add(&mgmt_route_port->list, &mgmt_route->ports);
+
+		upstream = dsa_upstream_port(dp->ds, dp->index);
+		upstream_dp = dsa_to_port(dp->ds, upstream);
+		if (dsa_port_is_cpu(upstream_dp))
+			break;
+
+		/* upstream_dp is a cascade port. Jump hop by hop towards the
+		 * CPU port using the dp->link_dp adjacency information.
+		 */
+		dp = upstream_dp->link_dp;
+	}
+
+	list_add_tail(&mgmt_route->list, &priv->mgmt_tree->routes);
+
+	return 0;
+
+err_free_route:
+	sja1105_mgmt_route_destroy(mgmt_route);
+
+	return rc;
+}
+
+static int sja1105_mgmt_setup(struct dsa_switch *ds)
+{
+	struct sja1105_private *priv = ds->priv;
+	struct dsa_port *dp;
+	int rc;
+
+	if (priv->info->tag_proto != DSA_TAG_PROTO_SJA1105)
+		return 0;
+
+	priv->mgmt_tree = sja1105_mgmt_tree_get(ds);
+	if (!priv->mgmt_tree)
+		return -ENOMEM;
+
+	priv->mgmt_routes = kcalloc(ds->num_ports, sizeof(*priv->mgmt_routes),
+				    GFP_KERNEL);
+	if (!priv->mgmt_routes) {
+		rc = -ENOMEM;
+		goto err_put_tree;
+	}
+
+	dsa_switch_for_each_user_port(dp, ds) {
+		rc = sja1105_mgmt_route_create(dp);
+		if (rc)
+			goto err_destroy_routes;
+	}
+
+	return 0;
+
+err_destroy_routes:
+	dsa_switch_for_each_user_port_continue_reverse(dp, ds)
+		sja1105_mgmt_route_destroy(priv->mgmt_routes[dp->index]);
+err_put_tree:
+	sja1105_mgmt_tree_put(priv->mgmt_tree);
+
+	return rc;
+}
+
+static void sja1105_mgmt_teardown(struct dsa_switch *ds)
+{
+	struct sja1105_private *priv = ds->priv;
+	struct dsa_port *dp;
+
+	if (priv->info->tag_proto != DSA_TAG_PROTO_SJA1105)
+		return;
+
+	dsa_switch_for_each_user_port(dp, ds)
+		sja1105_mgmt_route_destroy(priv->mgmt_routes[dp->index]);
+
+	kfree(priv->mgmt_routes);
+	sja1105_mgmt_tree_put(priv->mgmt_tree);
+}
+
 /* The programming model for the SJA1105 switch is "all-at-once" via static
  * configuration tables. Some of these can be dynamically modified at runtime,
  * but not the xMII mode parameters table.
@@ -3095,13 +3284,17 @@ static int sja1105_setup(struct dsa_switch *ds)
 	struct sja1105_private *priv = ds->priv;
 	int rc;
 
+	rc = sja1105_mgmt_setup(ds);
+	if (rc)
+		return rc;
+
 	if (priv->info->disable_microcontroller) {
 		rc = priv->info->disable_microcontroller(priv);
 		if (rc < 0) {
 			dev_err(ds->dev,
 				"Failed to disable microcontroller: %pe\n",
 				ERR_PTR(rc));
-			return rc;
+			goto out_mgmt_teardown;
 		}
 	}
 
@@ -3109,7 +3302,7 @@ static int sja1105_setup(struct dsa_switch *ds)
 	rc = sja1105_static_config_load(priv);
 	if (rc < 0) {
 		dev_err(ds->dev, "Failed to load static config: %d\n", rc);
-		return rc;
+		goto out_mgmt_teardown;
 	}
 
 	/* Configure the CGU (PHY link modes and speeds) */
@@ -3181,6 +3374,8 @@ static int sja1105_setup(struct dsa_switch *ds)
 	sja1105_tas_teardown(ds);
 out_static_config_free:
 	sja1105_static_config_free(&priv->static_config);
+out_mgmt_teardown:
+	sja1105_mgmt_teardown(ds);
 
 	return rc;
 }
@@ -3199,6 +3394,7 @@ static void sja1105_teardown(struct dsa_switch *ds)
 	sja1105_flower_teardown(ds);
 	sja1105_tas_teardown(ds);
 	sja1105_static_config_free(&priv->static_config);
+	sja1105_mgmt_teardown(ds);
 }
 
 static const struct phylink_mac_ops sja1105_phylink_mac_ops = {
@@ -3388,7 +3584,6 @@ static int sja1105_probe(struct spi_device *spi)
 
 	mutex_init(&priv->ptp_data.lock);
 	mutex_init(&priv->dynamic_config_lock);
-	mutex_init(&priv->mgmt_lock);
 	mutex_init(&priv->fdb_lock);
 	spin_lock_init(&priv->ts_id_lock);
 
-- 
2.34.1


