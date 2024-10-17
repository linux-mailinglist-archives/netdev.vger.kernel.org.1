Return-Path: <netdev+bounces-136658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FF69A29B6
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 18:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDEF7282B75
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 16:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B851E102F;
	Thu, 17 Oct 2024 16:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MHSQvDuh"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2055.outbound.protection.outlook.com [40.107.21.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B762A1E0B82;
	Thu, 17 Oct 2024 16:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729183988; cv=fail; b=jn9ONk20Z2wzfQV82umVqF/if9ayvdKVopWqeocXGgVrvKzpgDykA2V/7MLvHA/bHIbCFcdN/Wqd+Zujf/GKxfOZTHJvxrpDdaPIWGsyVlDhXT/vlfE5irziTph1AodL9IZd9Vb0uwgjE+8LiGbwc+pienAYDcliycpGhu0bGr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729183988; c=relaxed/simple;
	bh=PntiEBqexw0QfEoQA6A3oK0bsZq5itXTlRG1cvsDOTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rmZJ7IpiLh5Ay/knARPaU7bAbi22gyM2y930ModzqMjxC7tg8VPoE5TsGW59mdYZq+MDa1BTuQ/Ox4Qx4lhxnuI7VwTEs97aIG0HpuTyBeNO8Kw1+6XGe3/wZhDuru2RwA52Ma9nhOLUTmZuvpWz5Cf73ZB8tRDBn2B8zBUJdmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MHSQvDuh; arc=fail smtp.client-ip=40.107.21.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pHvfftrhYIuypu2J2CCS2V5Gnub9y6lAngeqVI8VQvcGobk0dek7rChQfK4QW9xrLqm8AYoXwy7NQ8GRHkD7n5TEwR7PD2LrFk3mp1a0Y6+8+adQ9x/Ge0bEf/GEruPTwAKXkZunLOkD+pKEtme+XGRtvZuGyskgd0KTEYIdTy12dEpbdWWZM+KsKMfyya5typ25AM7rb5a1tmzrtu6/5z9cL+BqbJbWkBWlnSq4KXUzlkldgzc9MCXvszRZH0bolDVUy0Cr91cmkoIosXHpzITgZVp/2iZn9w06uY6INQuG4llKWid8MuHOY/lMQ3kNRwufkMtssDluWMA4tMZg2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gGYLQ0WHKOepT8HqoJkQzEoU2goA8RE8A0SaxCVq3Ak=;
 b=fQUfEPtcMwVm1lx677lLzrwkRYkHtd4PS/gSqvAIMToCEtFV5S4s/zenzulLu5CWY+kiLJYXrjxumSX+dPwzTcTFDr7Up/MvinUNRqb8l+O/RD9IWfgPPtod1thLY5qkHAjYyu+2XdXn40+sg0S2Zl144x74O0BoDVlx9thzzaGP49+9byM28u9jiV26F3qGvRvdmjPcC9qBtsts7HjgSpnMGFO933tkjXs1gR8GiFJVGwYJMmdT0J6UcuYn2bbeMIM8opE9abv3knHxhpp2ggTcP0nxKhGgwDnN6Rd2OSS3YnKuOqeUnBQ+9HWk6giFmw1kMrVTbxKzp8rPC7ETCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGYLQ0WHKOepT8HqoJkQzEoU2goA8RE8A0SaxCVq3Ak=;
 b=MHSQvDuh592Y7KYQHvYrKsaIrmt/fyDyeii4ZXszVqvkn4sd9D8pRmX56KTSePSoUAKVKS/kXao/1/fqjSK91OsyiP23UpP0FkF3CzAb0aOR8S7n7U78fL4tJbXm3gfjm1f/THJopcYZwmdsgRLWsMR/oNCYpkUmKfna5Gw2Twy7REX8wPvXZZc8e3fAXmnBNNDHcg+RyuPcu4J783yyq8lMLJgU8stN+uYTsaN+Ydb/9DjqGN1Yf+YIku35nKS2u+PPQlX1ovKi2CcdcEymoaZAh/+Bj+MKt4uG5m84FJgKEOwiWQg4l8s+/c1SGaC2AMk2Iyj1WHkd6iCnjhmrgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VE1PR04MB7456.eurprd04.prod.outlook.com (2603:10a6:800:1ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.22; Thu, 17 Oct
 2024 16:52:46 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 16:52:46 +0000
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
	Vlad Buslov <vladbu@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	=?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 net-next 4/6] net: dsa: add more extack messages in dsa_user_add_cls_matchall_mirred()
Date: Thu, 17 Oct 2024 19:52:13 +0300
Message-ID: <20241017165215.3709000-5-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241017165215.3709000-1-vladimir.oltean@nxp.com>
References: <20241017165215.3709000-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0259.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::26) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VE1PR04MB7456:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ac8c848-78bb-4ea4-b410-08dceecc208c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZWHDjk1MaeQOtJUjzJumCn6n1dUgziDk648F1TgmSO5iTgfxGBLIUMlZ9k65?=
 =?us-ascii?Q?XjpqmeGEzOpCvk0+j2Q5TnPb5aMhFwY7yN5KZrRGkMN4lAj+1sHayybjqOZB?=
 =?us-ascii?Q?i0XuidXjM1ryH30Rly2awQCdhF6PIQZ767MPjJM1qn7JOqnFO4ZD6hovLlL3?=
 =?us-ascii?Q?I9M2OCjuhn9fmnU7PEvLoMCFDPWQeJuHmrc0VeCcWQoq0MvL20Vdb23jBjIR?=
 =?us-ascii?Q?GGiyw5L8gqcE6GK9wfr3wPtPZujrZ8qNn4KcoEmBxBBrdTy9uGuvOR0sIr4l?=
 =?us-ascii?Q?xbfAolki+MIz4Yobg2nL3HWwxCtr7VaaH9lq1+JrTdlzldsPfRmQ5pzq6cJd?=
 =?us-ascii?Q?FIVq7Azm1I6URM6tTxo56/ctlzWKiBnEKVSYa9Am9W5OlOjaUeEH4Hb2kvfz?=
 =?us-ascii?Q?H4M0v+hOP3skdG0INjNAZTr126c85u9tR9JYB7beDr8y0NHZmPndYZaTxwoa?=
 =?us-ascii?Q?TBKAg9iOQrxut32DOvVTiXIm6NFbzLeeKv2SvHf/rnzPjLFF0cn/YxTBct2g?=
 =?us-ascii?Q?r50XIoThuu6CMkle9QGCH7qBTh1XmovO1LR8wQjFS5j53Bv/89lX/JqWNNsG?=
 =?us-ascii?Q?Du3IJPqkKLdNhuW3tzZr5P5EPbAeiDOqFKS3iw6jp/GkIhvvnZX1fFNplFBi?=
 =?us-ascii?Q?9pOX0E08tEcpcPPG9ipESqt6cBYYi8YVjmLB30DRBUC1oWh1vbeWFvtzMJyT?=
 =?us-ascii?Q?unSIhA3gkOKtlq2QQNg1xkH1EaiXkepG8QQeB2GSa4+hYOk2qK1FOLogSD4w?=
 =?us-ascii?Q?ReNJ5SIzHb6co+VvEKDXxH4kN+/zKHTFOdhabvw+WduqxsnEkBEy+GOK377U?=
 =?us-ascii?Q?aMFIvIz8gTPY9quzh16gfqKarmxsJ045eF/2IsNeRqFUR16EzmnGq4v4EqlP?=
 =?us-ascii?Q?hAxqB96Mrb6vmW1aGjVzFjHUyxrOkG88PQebPfONjIjcsI1uRMjwJ/wjPBHR?=
 =?us-ascii?Q?OSIe/HCjcTrv4IKTFyrukTRm4Xe1jGquBuCJJR2z8dgK2lUInzqn6Aoeczh9?=
 =?us-ascii?Q?gOWfwQOXifm7KD0m7XjKCk2+q6OVyo7DeyJc9PILVvJwK7Ag1fJnVz3PwNK5?=
 =?us-ascii?Q?qdkk16J56+an7D+zxRouyB6wRxReSPSos9G4sy5NLQyjUacnqho21MeQ6WXN?=
 =?us-ascii?Q?wGsNJEWatS1smocJTpWzdQGAb5CFskLiNw9EJu02/mxKPMHW//MoRU/oWmFX?=
 =?us-ascii?Q?1S8y0H0h8zwkFuppbPz1SlSRv5E1Ib1BrEMcfds1Mmte6LCxhRa4Q3gQJXDv?=
 =?us-ascii?Q?pxBnGgMuibrcYYRaKjU5wj2gMYhV5ou2aEuuzZrl6nKF0sUIxijDOjEoU4TZ?=
 =?us-ascii?Q?b+hzf9vBg6mvwVYiM6ubSysDDItkoxHCZZvg1KsmSFN2oZ3zSHYFvhyr/mrM?=
 =?us-ascii?Q?ijdH4jA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nU2YwVH2QkEbFxF+B6nnP7WG/29p5d4YQec9eSVD8+dpq722NQfGG1gGq7Xt?=
 =?us-ascii?Q?HDRaaHfwlORtNMaAs8x+l2YgDZwgscRlo6It/anHspr8/ytXdOYgi0M1cdBg?=
 =?us-ascii?Q?wVv4hgt0goI/0U29/FNxnHBAcUAGLiEFrv/7y7Wyd30JReP+zMIs5hZVVvBh?=
 =?us-ascii?Q?N/b9Dp3qLpHf6utSqNxGtiTF0eVYoTwZDW001F34NG6yE7SXorLBS6QQd97g?=
 =?us-ascii?Q?G4VLPU7hGHe77hDGtcQGq5O493/viLWII0tLrZzlmCvMmMw1VtlsIfdTl532?=
 =?us-ascii?Q?x35NB7yE8/0SSx/ecPwwNidiNgdJhDeFKsUR8MrS5/bmljjwhK3QMySpCF0/?=
 =?us-ascii?Q?XvcoL/PPxQMnb5MqKazZM9B8Xo/w/iITDNG7W2MsJzZJY8ODxsMK8VlMez/q?=
 =?us-ascii?Q?z7oLgk4T5gQYecowGFZYnAbHpnRMeeMZd8HeGEvs5lV/Uok9zTuaE1Q0vkxZ?=
 =?us-ascii?Q?fcbQumQGnvsPzXUIf/iM9y8d3i8yTDAvhNzKVGRtDIJhXGx78KxtHXlU89m5?=
 =?us-ascii?Q?cV23B/qLg2onBBF4YKn6vIcRxiGVZn6Czi1Pnzk1NtyEnKKOMH5xNalYBLVz?=
 =?us-ascii?Q?QVhcjDA2NMvfw7XsCarmfs8xsEd9k/DXqthBt3/HRCzU3mHXogi3PoxDiRXV?=
 =?us-ascii?Q?LYMWpDUm1WkOu26LbIAnSc9sOZZI/YhjApd+Zd3HLMambnqv5Wc8K/cI4/YP?=
 =?us-ascii?Q?q5XqPK1ZvA5efD7XAhqJEUVg8rm1ll9ZqP3gidU+t07EWLRzJ5EZBfs8aI9e?=
 =?us-ascii?Q?mKXcwMVWwuixTTVX7wvKaOhBgXBh4wi95WgFXPb+Drle8e7f3jgEDirGWwtX?=
 =?us-ascii?Q?WBBUMd6nDzTxANYYilBxGUXnKQjduVmAj+8c6vP+MspA6CE34gr6Tz37pvx5?=
 =?us-ascii?Q?FC9jyQRlm2oXujPU3+WdMm2RwMHgzrIx3DuJ5BCDhfJ7kOhIOr4dOTd6BFEO?=
 =?us-ascii?Q?6r3RNPWox9MI3nrMLJMUEnxpJw3FrDlv2+X69FEhqe+gtsk+h5580R32yNWN?=
 =?us-ascii?Q?gfGxrK1l8G/uSDH2texn7snsuDX+3rOb1a6wBd+iBgC6zM4kTWMxZgivSl+N?=
 =?us-ascii?Q?j3ThusdiRveaMyAelVVHvqCzN1azMD3GAzZKFd1LVZmiFBeB3TW83kU810ew?=
 =?us-ascii?Q?DTNgu1+EnqvSEC+3JsscfU1ZefxOreKfbigHLWv2NCwgXR2AN96vc72EgLKO?=
 =?us-ascii?Q?fpTicApE9iK4wM2KUFRVfjwRGQi/DKo1l+M3F2g3d1j656Czjqb48pbqNTuX?=
 =?us-ascii?Q?7B/9j0tQZhVU12g4CA5Q50UG2E7SIH7oFwvS0qQah6xuSJ8nDGgUctj1DwG/?=
 =?us-ascii?Q?yhdeNU4akY1VBK40xR4MwdwB6ImyUTWHGhPCHEhrjonoNKqC0W9rlo4JETuV?=
 =?us-ascii?Q?U1YbrVDyV8xXBp6Bmm9RSAQTwzuDxF0Yne2PcgwzVXuUqfjL72bWXqXYkp5R?=
 =?us-ascii?Q?XJK0TtGoeLHu3aTd6neQgF2fzMMpfjitmKihenN4sEWiBML4bLLTaqsXRIah?=
 =?us-ascii?Q?K4cP4AM3NlCD5+QGqAi8N6EHQamYtFSv/gXhgq+b+P22l80Ex/TMWpv6B7nz?=
 =?us-ascii?Q?OlznNPoK+R0usssdIdDkoUTo0AiczOQ7kFI38pfxMlKCfcfojn2lH3hOxs/t?=
 =?us-ascii?Q?OQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ac8c848-78bb-4ea4-b410-08dceecc208c
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:52:46.7754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FVIU66MNl/GCCqSbyBnJFyaQxNVyO9AygsZFxFs712gFdcwgLHqQBF9DTAALgw9diqGY3bqnbsWxNjHxJ/ntjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7456

Do not leave -EOPNOTSUPP errors without an explanation. It is confusing
for the user to figure out what is wrong otherwise.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2: none

 net/dsa/user.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/net/dsa/user.c b/net/dsa/user.c
index c398a4479b36..2fead3a4fa84 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -1377,11 +1377,17 @@ dsa_user_add_cls_matchall_mirred(struct net_device *dev,
 	struct dsa_port *to_dp;
 	int err;
 
-	if (cls->common.protocol != htons(ETH_P_ALL))
+	if (cls->common.protocol != htons(ETH_P_ALL)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Can only offload \"protocol all\" matchall filter");
 		return -EOPNOTSUPP;
+	}
 
-	if (!ds->ops->port_mirror_add)
+	if (!ds->ops->port_mirror_add) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Switch does not support mirroring operation");
 		return -EOPNOTSUPP;
+	}
 
 	if (!flow_action_basic_hw_stats_check(&cls->rule->action, extack))
 		return -EOPNOTSUPP;
@@ -1488,9 +1494,13 @@ static int dsa_user_add_cls_matchall(struct net_device *dev,
 				     bool ingress)
 {
 	const struct flow_action *action = &cls->rule->action;
+	struct netlink_ext_ack *extack = cls->common.extack;
 
-	if (!flow_offload_has_one_action(action))
+	if (!flow_offload_has_one_action(action)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Cannot offload matchall filter with more than one action");
 		return -EOPNOTSUPP;
+	}
 
 	switch (action->entries[0].id) {
 	case FLOW_ACTION_MIRRED:
@@ -1498,6 +1508,7 @@ static int dsa_user_add_cls_matchall(struct net_device *dev,
 	case FLOW_ACTION_POLICE:
 		return dsa_user_add_cls_matchall_police(dev, cls, ingress);
 	default:
+		NL_SET_ERR_MSG_MOD(extack, "Unknown action");
 		break;
 	}
 
-- 
2.43.0


