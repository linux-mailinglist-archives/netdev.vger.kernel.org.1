Return-Path: <netdev+bounces-147187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 654B49D8224
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 10:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB083162708
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 09:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C3B1917CE;
	Mon, 25 Nov 2024 09:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QDY5l7rM"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2080.outbound.protection.outlook.com [40.107.104.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D3F19005F;
	Mon, 25 Nov 2024 09:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732526609; cv=fail; b=X7DcuymdD4FwXz+a+aiiT7UogoHB12sX5smkcpj3xyU6fmX4lRfh82C7SaSpCrj0x9ugT46sXAc1Auyr7Y/5IeWTIE3lBg0KLBSNrxvWuHLkYoWGD2H+p945jMMdg/wge09k0SyaD7l51i/rtAa0YgYY27TklgEi5LzGjqvXbks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732526609; c=relaxed/simple;
	bh=yTJh7ddvPD6/cc6FdX1PrQpJgzcTiV+NAkmm8MVPOmw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NRNqm0iPgvSF4hh/smGEzVR5CBA1Rv+IteUW3I5SMkN01NeZvRlJgnEr2ZqhlmJxh7QmeaQItCPY3ZJmvJX0uZLkIO8A3lvjY6+eZEiE8q4ljMhMZgFxwoza6MOVOel7IwVHG7ltTI/qkGaAJOOsedmYU50jxFl6M2kvSALmmF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QDY5l7rM; arc=fail smtp.client-ip=40.107.104.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KpUGYC+ykKiumaO0dsnukI/aUVvcFl8N9BAf34ZB6i7gTmFXSQzkPu/RzyM6AICJdI0Lv3QMzUMeByjzc0lvKDZxO+G9tmYbrejNXhjhuqS/4h5MTgfYK3DW9/XWTDHxZTh1Q3G8EuOMdgByu9gs7tlqfLTiZVE0y3F+DsKH9BWmYiaMZTrmI3xl0NiQRHwAG35mxjDS5Ec3iWAnspCWAaS84aZ8iRniiqNnxQcfPflUWebe0cBQWmtTUbVOoemS9E36tzXCtQmvrSoBv06sfCjd2/kXiOzZ06hidPnLSaeU4FZ1hjFmy44WkyfwI8WOo3WgdZRHfDD5OWGZNaf/kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BMFcLnf3+nh21wurkg8u622bfIPqfM6yXHnyuz6Of+o=;
 b=yTZ3FscwVHipvsi998ixpK7Y+KkLhpUY0eVAZFlVihrhkWi+ANBBjYz4g/b4/xmHY/x9dYeE6qX5sDIJN+akIBRJV1o+RkuUEK/omyqnp991rGDT2Pd750BIwGCJG+f7j5Xn7Hr6vNlc2LEEht+bXwwY74YVN3KMs8EK89eA8LPZrDmGMWdesch5/5mC1DzMmG7TLQVOkEaRXpSvq2AAy2VlVsoxIzgroD9fK1lxYTHujWK0n81Abm6qLnq1aPul3qlDavvG6k7YsC50SRsQbS1BTAuih0pVDHj87q+mmFShlQ5IF+vr5i4GltxAGp3M9vvf7sr0VNdI48fbaQdszw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMFcLnf3+nh21wurkg8u622bfIPqfM6yXHnyuz6Of+o=;
 b=QDY5l7rML72/h1LuVv07RtJbVpusMlfWVAVsINwqrReryfSiVqTNi9o+9OCvbF9p6Hck+dENmROqoVopa6iFiYLC8gVEM8JlinZdYKBM041YFvKfJwz/75vSCG+wWkTGU0HlMXprdK2CB5AuyONBr2ElEleuJwO9rsP+xcvF1u3sXXWP8c2V6Pot16Jc2wpRQOhbYTX1WIgIQ7xLakkvuu5NXR2zAJ5H7A/Z/JgQW5DbUwRYGLY4Pzpr9ypDBF1LR0CQST5VtqaQNTBMiMIqTyzY76KN/PtlrReFn2AHdw75dbSc3Gh2WyK+3Bd+7m11DVVAV2sx6opSth95rehPYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM7PR04MB6773.eurprd04.prod.outlook.com (2603:10a6:20b:dc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Mon, 25 Nov
 2024 09:23:24 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 09:23:24 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v3 net 1/2] net: enetc: read TSN capabilities from port register, not SI
Date: Mon, 25 Nov 2024 17:07:18 +0800
Message-Id: <20241125090719.2159124-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241125090719.2159124-1-wei.fang@nxp.com>
References: <20241125090719.2159124-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0041.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::10)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM7PR04MB6773:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a6c8734-5c6c-41db-2273-08dd0d32cfeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9bOby1a3ngap3gNA+jwkPaDKF4hTmUFtnfhMYLvhvUXRxczES2vHhaOFdRIE?=
 =?us-ascii?Q?S9A3COcHlxK7AXpZDMtWkkEJxtvZQXBPgUVfY9nIZPZHD7CQ6N7F8rzU5BKd?=
 =?us-ascii?Q?i34AiNbO61o2tc3QmoDE37JUsWQ1zB2yOXfHKtx9AEgNJZTFErxPTTHh3+b4?=
 =?us-ascii?Q?9uGaTMkr4uzYH3QtOKP2YcfXkrcIcdkZImwiOuFBMEOCzwUuYztqWfkwFv1C?=
 =?us-ascii?Q?WSWyNlwuBqvH4e1EpGRBKFv+qJP3l6VvksBxr3r6Gu5KUt0aBh7qDCSBDb8y?=
 =?us-ascii?Q?lkakEjB5UdeNdt9IN7GRueAeGk+EqNunEqnKAAaUaZx1r2PoQOGdoVa7f3Db?=
 =?us-ascii?Q?jomA1JbUJNwsLXHl6ixb+7qVjn2BosmSCo15pKCWIA9F1P/p6jWEnez8l7V3?=
 =?us-ascii?Q?pBnZS+cJZpOAb0CHB4b65+fwdI/BlIx91uscNbvC3BtCarrY92PUUEv+GGlQ?=
 =?us-ascii?Q?Oq5FNXeTM4ZJ99SQ9n6+1T3Jkqx1zCSOsgMXGtNC2n0dYxD+HKPgHwqg2IdT?=
 =?us-ascii?Q?HerFIg3pqHAFJ3jEBu5o/XjnwLI28Do3E3qraMb71yT8qfP6QYJyIaNI3or1?=
 =?us-ascii?Q?cDxfDMhI8BoCnFy9Gd3NwP+0z/KMoDhtdo+Iv8vEIuHH3ACBT+26CCjsJ/PQ?=
 =?us-ascii?Q?RbLCp43FyHZpaxxT8vxA/3HIP5Ha/MQ1BH0jAQ1JFe1IQT70HKS+h9N0YnzV?=
 =?us-ascii?Q?KYWELgAaJxWlq0EK2299q44+18Itaqjw14pVvnz3VsJLgX2AaPSseC5GEmro?=
 =?us-ascii?Q?27fu+K2RItpDa3F1trBwjDrYS9l5H04BxDcFMwsuAXVnlVfm+XnYtgObKaLS?=
 =?us-ascii?Q?4iC0ze4XGFTf1xcVLQGrA0TnxO0TZCEI1SrRNsv07rRmc4jlxtXdsN0GoLH4?=
 =?us-ascii?Q?WSyaOIq6ObaHrmSf8S+VzJ/28efVg2vDn9+ExG1x+YELnlblhUvBXxi4/hZF?=
 =?us-ascii?Q?STaacCkGEbGHkkepb3FeGZRScW0xa9c+IFbRa1K8P1wZpt+jMoAqR/Ew+KWK?=
 =?us-ascii?Q?GgY1utVlsBXsAdKzc1RSzAr+VTl21VplrPQYCjLa3jifBxcYu1HBXVYp5e6z?=
 =?us-ascii?Q?kG5yKR326YR8ApjUZbtuW44sCKOxhwLHyIxERhZuFFADGPygMOOOPbTQi027?=
 =?us-ascii?Q?eU+4Gr7PlcIBgg9+l0Q1FRNo9oWtCWIfggUBLuCxWTwhxikVpEnTyldMHW/a?=
 =?us-ascii?Q?rNJXBQkhImmxbJN0DTwf91OwAktnOANsWfvRHVCYD/HF4gbYDtW28Ah2vM1o?=
 =?us-ascii?Q?81ccdO5ZkJoG8c3ywNKVjLGWukEOBSS6d79z0YSB1gUDgHnmTWGg2v6xtg9b?=
 =?us-ascii?Q?k0aqCb8LXmZANmJMe1ebuMoIlIWHn55Aeu9oFErf27QIPuVMFLGbnR+Q1pEa?=
 =?us-ascii?Q?zoeQ8aH+SD/r/O+l4cyBwVk/CFQZX6o//oq2K9vBa2z+CQKz/g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m6Vbpxf86IvfKx67hMqir3KaiCSOCcN0YLGEJhsSZWElPV/tEKvzkGfgo0Mn?=
 =?us-ascii?Q?H52dORxTeL3FTAw9YbchkjWL8brFt6yW2Hd5t8B1OLzIUTMonOfVbM1DHUPX?=
 =?us-ascii?Q?1WPcMdKT5fJdeAQfrwy/QWjMFXljGXBM6zdeD0mTfdGT+tAMhiSVW1oRCI2k?=
 =?us-ascii?Q?oBkYMcrPbZyPOI4EkyPlzUHaGB03+sIIXgbWYwnqZIcSmn6a3eC70dOg4iRC?=
 =?us-ascii?Q?WnRCwQiDJ6Qynp2DY1q6LAB96WkcuJTG4gdDSlJ6SRQnE5fg5ytem33IWv+s?=
 =?us-ascii?Q?BhtlT7D7uXOigqqvEoYBlfJDu9u3Jyj/HpI1DZ34ULDDoJfCFYly8/ZmA/IA?=
 =?us-ascii?Q?bvpDriYIeFmIPv6ewzEhjfa9otWkUxUx5gOYTr1kvsrKbIV71pnAJsq7LzDM?=
 =?us-ascii?Q?1a7eHWoMJyH+a9u1fkEM721BIkcwaqozo5Faaw0eSAyIWsu+oXrJ4qraa2Eh?=
 =?us-ascii?Q?dDj5ddZucZSXaowH4+fJffRUH7i3HWJHVamwPFLzSgAL5yagReErTq2SkwQk?=
 =?us-ascii?Q?x1o2SSB2wQnfmIPunexTJu0cqO91TW/aaB2M/IpGNN5POAe1vsNjaqkAkA5o?=
 =?us-ascii?Q?7GaC+TjAe2xcKXi/Z/q1eaFHEkrmwTAX4nmUzWVmbz0s5gnyVywbTcVuzIsR?=
 =?us-ascii?Q?fJAzlN+Ndsh1a4aoWLvEnHapEnMk0a+H3AFvzpFCLfYT+y7Ipu63y5zVUxQ7?=
 =?us-ascii?Q?c9eCv89KP52worvA8nYM/ZQUhAAZFGP8/0Dmqp78QzFGUPsPMnGD1McKO2Qc?=
 =?us-ascii?Q?/7mnqYgEcXCd01f31mFijCc3sMiJWL9u195AKNnU7OTgXHk5Q8QWXJsarkV+?=
 =?us-ascii?Q?BYTnILFhIljJgUHWzrW8SgqMawhU6GIGV6EVS+P5tQbIsSDpbDS+BgURhfsT?=
 =?us-ascii?Q?gT/NyQhU7rlWAxGJOXB0NgaED3Cd9FippVZ47pViMIft+S4movxdnco4myEU?=
 =?us-ascii?Q?5G3r8rgvIxl1my5k1OSw8yVkU+LaxTEtDJ2IgPc/0y9nJQbUI5gF7LBxzLVd?=
 =?us-ascii?Q?UpJj49ExE4FRxy2X3ibS4rOyjF08ph47y13guzqk3fZjeXnTQCyxY8OTXJn+?=
 =?us-ascii?Q?0qBrt9mDoeGCtf4fzwbipEkXq31nrOAZsMNc4bw6zp2hGsfbU7rrPrQwOGDy?=
 =?us-ascii?Q?4weBaW5lldVR+RDN7++bN7IWVbBH3J/93ze/NeoFNRl/HLn8gfBq+ko3rrwZ?=
 =?us-ascii?Q?i0qJLHlFEjO2nCmVVb+z3II9vmiCsHYiCgXlh4cYsXRxfmqDvxSIPuyWPK/k?=
 =?us-ascii?Q?yJUb79kcBZ0/dZWW3rNgu6Dq2JUOp9UU5JYOoFVqBk09s0jvnBlfnRfoft1I?=
 =?us-ascii?Q?mnQ9IxzKiKisgF7UYjT+/dEYYrhjYmcYT/rQ9zO1EouN1BNriUq8M9zkaUvm?=
 =?us-ascii?Q?tsSZt0JnQmQGXMboBz0mIqSGw/rSXYVp+si/dPVjM4L5mc8HQuYAkzeEqnuR?=
 =?us-ascii?Q?OGLh58j7i9jjWm5HmWXHi5IHINT07MIdA59Q2b4vZVYdo7veImhHPInGTX/p?=
 =?us-ascii?Q?ISEQXYMIsrK7tCYi1kjDjXyDBPMuPMtqfLYEtwQYZn/LLbgA9V+wuMIei9uy?=
 =?us-ascii?Q?1zA+yWhtF5hX4gq7PWR31CnT0pMfdbS6NHtxBwWW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a6c8734-5c6c-41db-2273-08dd0d32cfeb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 09:23:24.6366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 18zGTgn3OpMuddrGZ0QkQz0j8Hk2Mx70Ar2R5RDi/qCBKD+xqmNMFmojgWA/b/mYyNLDhBfRmeLYEI1GQZwhFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6773

From: Vladimir Oltean <vladimir.oltean@nxp.com>

Configuring TSN (Qbv, Qbu, PSFP) capabilities requires access to port
registers, which are available to the PSI but not the VSI.

Yet, the SI port capability register 0 (PSICAPR0), exposed to both PSIs
and VSIs, presents the same capabilities to the VF as to the PF, thus
leading the VF driver into thinking it can configure these features.

In the case of ENETC_SI_F_QBU, having it set in the VF leads to a crash:

root@ls1028ardb:~# tc qdisc add dev eno0vf0 parent root handle 100: \
mqprio num_tc 4 map 0 0 1 1 2 2 3 3 queues 1@0 1@1 1@2 1@3 hw 1
[  187.290775] Unable to handle kernel paging request at virtual address 0000000000001f00
[  187.424831] pc : enetc_mm_commit_preemptible_tcs+0x1c4/0x400
[  187.430518] lr : enetc_mm_commit_preemptible_tcs+0x30c/0x400
[  187.511140] Call trace:
[  187.513588]  enetc_mm_commit_preemptible_tcs+0x1c4/0x400
[  187.518918]  enetc_setup_tc_mqprio+0x180/0x214
[  187.523374]  enetc_vf_setup_tc+0x1c/0x30
[  187.527306]  mqprio_enable_offload+0x144/0x178
[  187.531766]  mqprio_init+0x3ec/0x668
[  187.535351]  qdisc_create+0x15c/0x488
[  187.539023]  tc_modify_qdisc+0x398/0x73c
[  187.542958]  rtnetlink_rcv_msg+0x128/0x378
[  187.547064]  netlink_rcv_skb+0x60/0x130
[  187.550910]  rtnetlink_rcv+0x18/0x24
[  187.554492]  netlink_unicast+0x300/0x36c
[  187.558425]  netlink_sendmsg+0x1a8/0x420
[  187.606759] ---[ end trace 0000000000000000 ]---

while the other TSN features in the VF are harmless, because the
net_device_ops used for the VF driver do not expose entry points for
these other features.

These capability bits are in the process of being defeatured from the SI
registers. We should read them from the port capability register, where
they are also present, and which is naturally only exposed to the PF.

The change to blame (relevant for stable backports) is the one where
this started being a problem, aka when the kernel started to crash due
to the wrong capability seen by the VF driver.

Fixes: 827145392a4a ("net: enetc: only commit preemptible TCs to hardware when MM TX is active")
Reported-by: Wei Fang <wei.fang@nxp.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v3: new patch.
---
 drivers/net/ethernet/freescale/enetc/enetc.c  |  9 ---------
 .../net/ethernet/freescale/enetc/enetc_hw.h   |  6 +++---
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 19 +++++++++++++++++++
 3 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 35634c516e26..bece220535a1 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1756,15 +1756,6 @@ void enetc_get_si_caps(struct enetc_si *si)
 		rss = enetc_rd(hw, ENETC_SIRSSCAPR);
 		si->num_rss = ENETC_SIRSSCAPR_GET_NUM_RSS(rss);
 	}
-
-	if (val & ENETC_SIPCAPR0_QBV)
-		si->hw_features |= ENETC_SI_F_QBV;
-
-	if (val & ENETC_SIPCAPR0_QBU)
-		si->hw_features |= ENETC_SI_F_QBU;
-
-	if (val & ENETC_SIPCAPR0_PSFP)
-		si->hw_features |= ENETC_SI_F_PSFP;
 }
 EXPORT_SYMBOL_GPL(enetc_get_si_caps);
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index 7c3285584f8a..55ba949230ff 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -23,10 +23,7 @@
 #define ENETC_SICTR0	0x18
 #define ENETC_SICTR1	0x1c
 #define ENETC_SIPCAPR0	0x20
-#define ENETC_SIPCAPR0_PSFP	BIT(9)
 #define ENETC_SIPCAPR0_RSS	BIT(8)
-#define ENETC_SIPCAPR0_QBV	BIT(4)
-#define ENETC_SIPCAPR0_QBU	BIT(3)
 #define ENETC_SIPCAPR0_RFS	BIT(2)
 #define ENETC_SIPCAPR1	0x24
 #define ENETC_SITGTGR	0x30
@@ -194,6 +191,9 @@ enum enetc_bdr_type {TX, RX};
 #define ENETC_PCAPR0		0x0900
 #define ENETC_PCAPR0_RXBDR(val)	((val) >> 24)
 #define ENETC_PCAPR0_TXBDR(val)	(((val) >> 16) & 0xff)
+#define ENETC_PCAPR0_PSFP	BIT(9)
+#define ENETC_PCAPR0_QBV	BIT(4)
+#define ENETC_PCAPR0_QBU	BIT(3)
 #define ENETC_PCAPR1		0x0904
 #define ENETC_PSICFGR0(n)	(0x0940 + (n) * 0xc)  /* n = SI index */
 #define ENETC_PSICFGR0_SET_TXBDR(val)	((val) & 0xff)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index c47b4a743d93..203862ec1114 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -409,6 +409,23 @@ static void enetc_port_assign_rfs_entries(struct enetc_si *si)
 	enetc_port_wr(hw, ENETC_PRFSMR, ENETC_PRFSMR_RFSE);
 }
 
+static void enetc_port_get_caps(struct enetc_si *si)
+{
+	struct enetc_hw *hw = &si->hw;
+	u32 val;
+
+	val = enetc_port_rd(hw, ENETC_PCAPR0);
+
+	if (val & ENETC_PCAPR0_QBV)
+		si->hw_features |= ENETC_SI_F_QBV;
+
+	if (val & ENETC_PCAPR0_QBU)
+		si->hw_features |= ENETC_SI_F_QBU;
+
+	if (val & ENETC_PCAPR0_PSFP)
+		si->hw_features |= ENETC_SI_F_PSFP;
+}
+
 static void enetc_port_si_configure(struct enetc_si *si)
 {
 	struct enetc_pf *pf = enetc_si_priv(si);
@@ -416,6 +433,8 @@ static void enetc_port_si_configure(struct enetc_si *si)
 	int num_rings, i;
 	u32 val;
 
+	enetc_port_get_caps(si);
+
 	val = enetc_port_rd(hw, ENETC_PCAPR0);
 	num_rings = min(ENETC_PCAPR0_RXBDR(val), ENETC_PCAPR0_TXBDR(val));
 
-- 
2.34.1


