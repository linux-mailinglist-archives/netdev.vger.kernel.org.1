Return-Path: <netdev+bounces-267098-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QM/uCzjNsmmPPwAAu9opvQ
	(envelope-from <netdev+bounces-267098-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 15:27:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE4A273541
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 15:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 818273091B2E
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 14:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7461370D43;
	Thu, 12 Mar 2026 14:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HBBLk43r"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010046.outbound.protection.outlook.com [52.101.69.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097F435C1B1;
	Thu, 12 Mar 2026 14:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773325398; cv=fail; b=YFJY/EeN0e1Cf4B7msMn5YeEGFauZz3iibbrIFFGsq7OhfQKTCVs7NHqtbcujVd0G2ipyc3rDyEsJPqVF346/zNv8U3OE8ZH9q2d8I7ebrtRqQHYutxOOQWk6BILgBFEeBgzKGbk59WCdwLGE26lxyIS6FxVF3okrHF431mvK9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773325398; c=relaxed/simple;
	bh=NlY1ByB6UaZCMJV1yHKcpfxreWEXG7OcyeAuvok71BE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jCmRrqcjQtCa857ANApbChS7oGZ04H/0Y1jKtzPbxg9DJ8oHP1Vdpms+18x10tp5YDLQj0wCFKfaOgZDQM/drPwGFXlg5jgJsICQC5wXxuPNHcQSrMQs6JED1SV/rznDfJ0isuogf0NLG4E4iMM0vffXdKFvOpVr1jAkStLs4pU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HBBLk43r; arc=fail smtp.client-ip=52.101.69.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OK4njMB/YLiPfxShEblx/D+fsGmQQHl4LIbUHw1u6AVhHK9eZvxT+mIA41CfN6KqlocJy9wQ4xzx7cR+N4YL3FH6vTx9JIGs9so+dVPRQnvP6mgocx2B+X9+o1xiwyARxl/lb2f6dxhF7wscSUv5az20NJG/nBCeTc3azeo1N8Fb6HYEUBT0s2l/e0zgIOllusUJarWokniUKyMUSaMaPU1jYDxwxDjIbTSawI7gpDuGpsQZ2j7TmaNNfwwXTprKQ35TUM20yOYCSa38LJNQOjDVMWW8u95F9Zo/Fq83pagDA3cX/g2joKvb0FFTWwmblYTmogFvN0/7yAIqYSthHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R5Jpw5ZpDEo956F0LQvq7+d12hCQudZReGdTmFD4wvA=;
 b=lfkNrwYYgxAAzyJMHbZ6RUZ6HZmXriRnMU1RtrRSZGtKhUGMcusXiKf/nKfIbTOuRXvnXpzDg8VFOIhEAk4BVbMN5AjRS5cBZdM7hm2LalUoTaiz0r8uqTbSZ9Uwx70WsUz8Ky34Aaj1toq6sStJpy3lQA8+qy6V5ljKMQnqcTLdWsm8NKtfqTOfdJBn0Ty6+4D++DHOlWxNNZunZCuOOFGjrS6PfxMlzGd7Nv8izb4/8OXxirtnVXWgQAaclkR4Wf4KhdN9tfFuO7XAzcl7dfu6qL0Cgj/fsjJkL2oiDrDcYCQlsqkWgSJpNR67Vgicy3xfZotos7TLoHVaHwYwjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5Jpw5ZpDEo956F0LQvq7+d12hCQudZReGdTmFD4wvA=;
 b=HBBLk43rTu7/w+AT31utwMPYAFNhijBftjA0/WAj/vz1/qzxbXSLy+0MItubI+tQtIoic9zEYOOsGvK6314tk3dhovZgnNPatEWKJfBEEqR9m0xzOAe+djdWgTonvIB9jz75paq9nRGpVtyeFxxCuRApk2GuolkPaEhfjECXUbfmdtVWKokjHC0929H3FjBBf7KuloSaMNyExy+DxEK4zupQgTPpT+OHluAQujEm26jw3bNkSfJZBGbEhoGPGVLmE2+xmOZrKTnulRjfN0kV/1nLuFuWJMTguzxXALfGTO8T01tDY7uGvzriWBYcthn5nQYaZ0r3pKOhFOedhms2Nw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com (2603:10a6:102:1bf::7)
 by GV4PR04MB11773.eurprd04.prod.outlook.com (2603:10a6:150:2d9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Thu, 12 Mar
 2026 14:23:12 +0000
Received: from PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633]) by PAXPR04MB8253.eurprd04.prod.outlook.com
 ([fe80::2b4e:8130:4419:d633%3]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 14:23:12 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v2 2/3] net: dpaa2-mac: retrieve MAC statistics in one firmware command
Date: Thu, 12 Mar 2026 16:22:48 +0200
Message-Id: <20260312142249.297192-3-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260312142249.297192-1-ioana.ciornei@nxp.com>
References: <20260312142249.297192-1-ioana.ciornei@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0019.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::9) To PAXPR04MB8253.eurprd04.prod.outlook.com
 (2603:10a6:102:1bf::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8253:EE_|GV4PR04MB11773:EE_
X-MS-Office365-Filtering-Correlation-Id: 358b5819-7aa0-457e-c10a-08de8042e49f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|19092799006|1800799024|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	KU1rDkh5QxVBYrlsOJo8l4DLiodBCM6X4X/zAos4gkSkykWOu/MODTpgjcBk4hVY3t0uQx7PYxPIvQ/2yAEImhMu27ZTGZZM7wBQkdxwECmHWlQOs5bFVd3/Jq4rdhgCxq3V6Zu1V0ySg2vCF5FfQaA9leLvPZ7syiM2bbVZ/WP9zuR8r/m40pUWfZiQyxLhwGrwE4g87zoEeDlk75wpCCN1GZjPlsuChoayBNj/LzsA7WTLq2qH8+G7N3cxZ/aN7gAUFDQhWH7HOMmvnQoii251R+PzCisNBK1lffT0/jVVSvwCWME/M5LfcP6FRisdJLwz3J2bC0m6p7S1iEAQui9sbOChZZIJKRfQJBPauBvfcw1iUFvVHELSqyQqeACvBcmp1WNbWMtaf8tVpYp17PVUluXQN4ck97juDSt1KXHA4Yzi3uIhEZazvtq6GKJuc6UqQZU067XShCBqkB7kilEgMqMrfvG7Bu93XhbcYYsUIpOyw2l2gSP/+nLMq6FvRxvIGzGnB+FwvkTF9RQj7t3hE1hsWyYB94o+pcg4gPz7ERaiyC49/baur7egGzw1xJioP6D7uZecR2DvlvzfQVvOmjdKBujOVuBWuhH5R1xC+h4ej/GaaOVxNGxJddsWllz8t8QFlJQEC+BE8l1ksXmx2R6TEfSDaOI2wPglXAqzEN0dhFv/esIHbf8KbovoFiD93oFpddTzV57eCWNIxWjZozSEYU1oRHGwEaXrpG0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8253.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(19092799006)(1800799024)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QEdXGSzCp5sr35S7tvMwgLnb6PBmGTOCVGMTVYMJ5kT1ZbYZc8L7z5l689Wd?=
 =?us-ascii?Q?mFB2zW2ybugNdK3o6542j2MOLi4mlIU1LWxn47cTIaFm2Z/V448uMQ+6R57L?=
 =?us-ascii?Q?3oDHgVzowlQbWW7VWmyMQ/4vOIZFFctuSQtIiSDjk3aQnihfJ9lG4omASRUX?=
 =?us-ascii?Q?b3/PUmSG8GpN6ZyMhyc1FHsvVYQiK1l5v7vp9Tjhpju210hHGEd6cD3LaFkr?=
 =?us-ascii?Q?ma273vQ+T5pFSH/UWMUcD2odxQ1emG/Wq1ycLykY+elUYwixzIFFFy+OtGyz?=
 =?us-ascii?Q?zkuKc/Lc/fcXyFtkmKtrxEuVP6+ZIap4nFLwADjdOI1AQCaMvORQgHwVokCx?=
 =?us-ascii?Q?XBUe9UKLdWPtWQvrqUZTae47RlpveuFaBTBbXVYk8DVV6OmwESs0UrQrzy0M?=
 =?us-ascii?Q?gNAeqsIpcOqUdWNZ7uo1sg2zGk/SJjGYVosxoManEfaD8pYsrZsbn57fcIvT?=
 =?us-ascii?Q?+IrUckNIyX91Du58mrcszO9rRlXYHC8GgWJKu+8CrhugpH1ANrD96GB8e7Sj?=
 =?us-ascii?Q?KwDohEHloBlIklRl5fbR1M6cyqiHf9W+b8OR0CV0ZLRbflp8PKnCMNG5siEH?=
 =?us-ascii?Q?42yBIgEASxeeKVV8EGmHEgqNToEFoJcTw/qtKCdWdGiTIYzVoAU9PjnteP7x?=
 =?us-ascii?Q?V3OKegrOD715aUJmxxGvncGFOWNMLMfLomkqMuCRzrCi3WWOAB6OqjZzTRF8?=
 =?us-ascii?Q?TN0zjqKMp1qNbwPQ6cx1qkKNhJXB4FRs2BLi+fDzzSx/joCOHwO3A8NmYLMj?=
 =?us-ascii?Q?sBlo+4R1JG0XRigvHWcL5qlagz2DgYJQYpM7sjc5jqrP4JCNON993BG/hrcB?=
 =?us-ascii?Q?gRH421mS7fmrZMbMyCXZo94dEhO3B00FPT5TKIVxuCOpKsNIc1nMQ7vMG2GB?=
 =?us-ascii?Q?2go7n25EmVM/BYfIpq+XQKChD8Q/msv2qnacWEJ4aVINScztBqbVSwGot3hd?=
 =?us-ascii?Q?e3g69kVqBBTUfFQorCOZHu1BfkaPVncCNy1nImFErGXXTgFDUIHGRURQqs+c?=
 =?us-ascii?Q?vjptjBdbeVgUfy0NenWk/NrRKfaiBXp6ONHYqdaYJhql3xWuUsJVzGJBiB9c?=
 =?us-ascii?Q?09p08IXBDeq/4TxOUAnRTjoNNRI8AXIZUOKP9VYpXfC60YSVij2K+lmzydyP?=
 =?us-ascii?Q?tmChuJBtUVeVOoGnRAS5ZAb4d+vgQQM8lSCyiqRgwgEZvtCxPeJIZ0ASClMz?=
 =?us-ascii?Q?GiycuSXFazKT+Mfnec8ZKuXT4q/yCHnUKqSwfr7cP8Qe0j7ch72edGldvMtA?=
 =?us-ascii?Q?f/t2pJYFweJWV/9EVoAQZgVMnmtzQr5JwyE75iHiWoCcaONT+FmUBJLYNsXd?=
 =?us-ascii?Q?e2iLLA3ku1rm2hRjy4/65Pjq91/w4FLWElf6HiJC2WRlgEBRslAaz8MNrWdQ?=
 =?us-ascii?Q?veT9n9i9MPS7mEHjDqZZkHhwdgy7H5GJv4AFAj9kZ4CogMOuZjLbrYNUX4mh?=
 =?us-ascii?Q?gNVUEmt5Mau0wrHw+1nXf+5Jk66tePhtyADSayUCYMwXj+oxhiizDyDAPCUd?=
 =?us-ascii?Q?SIiccr8h5Jyhyilqsk+Be78sAoplMW18/kNih5AUmir8E8YpcYK9/qjjCJUt?=
 =?us-ascii?Q?XrOnew9AaGS4NyyDBxKU0FcbyVRjSM0m1L6LOAYEgwhP+ewtAu/VL3FnIEsg?=
 =?us-ascii?Q?HnhQWyH49A/enbLap/h1vzB8f79TEvQJn38iyI/oWwFtIgZei2XkOzdljv0h?=
 =?us-ascii?Q?3oIKfWhbaa4ndg4PK95JKykEJBnenjpa/RtxcK7DAGAg/EjSdaY1sC437vWl?=
 =?us-ascii?Q?eDNxqQ0KHQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 358b5819-7aa0-457e-c10a-08de8042e49f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8253.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 14:23:12.7739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uZCivCZim7/ftI7v4ZvMbbV2MVe9huRErz7mzfNFh0L4o9ewgq04FOYeQ5kxm+oXUaceqm130UI2ndrjb/1GNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11773
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-267098-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ioana.ciornei@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email,nxp.com:mid]
X-Rspamd-Queue-Id: BBE4A273541
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The latest MC firmware version added a new command to retrieve all DPMAC
counters in a single firmware call. Use this new command, when possible,
in dpaa2-mac as well.

In order to use the dpmac_get_statistics() API, two DMA memory areas are
used: one to transmit what counters the driver is requesting and one to
receive the values of those counters. These memory areas are allocated
and DMA mapped at probe time so that we don't waste time at runtime.

And since we are planning to add rmon, eth-ctrl and other standard
statistics using the same infrastructure, make the setup and cleanup
processes as generic as possibile through the dpaa2_mac_setup_stats()
and dpaa2_mac_clear_stats() functions.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v2:
- fix fallback usecase by using dpaa2_mac_ethtool_stats[i].id
- use the __le32/__le64 types for cnt_idx, cnt_values etc

 .../net/ethernet/freescale/dpaa2/dpaa2-mac.c  | 197 ++++++++++++++----
 .../net/ethernet/freescale/dpaa2/dpaa2-mac.h  |  10 +-
 2 files changed, 167 insertions(+), 40 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
index 422ce13a7c94..6e34a77f2757 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
-/* Copyright 2019 NXP */
+/* Copyright 2019, 2024-2026 NXP */
 
 #include <linux/acpi.h>
 #include <linux/pcs-lynx.h>
@@ -15,7 +15,121 @@
 #define DPMAC_PROTOCOL_CHANGE_VER_MAJOR		4
 #define DPMAC_PROTOCOL_CHANGE_VER_MINOR		8
 
+#define DPMAC_STATS_BUNDLE_VER_MAJOR		4
+#define DPMAC_STATS_BUNDLE_VER_MINOR		10
+
 #define DPAA2_MAC_FEATURE_PROTOCOL_CHANGE	BIT(0)
+#define DPAA2_MAC_FEATURE_STATS_BUNDLE		BIT(1)
+
+struct dpmac_counter {
+	enum dpmac_counter_id id;
+	const char *name;
+};
+
+#define DPMAC_UNSTRUCTURED_COUNTER(counter_id, counter_name)	\
+	{							\
+		.id = counter_id,				\
+		.name = counter_name,				\
+	}
+
+static const struct dpmac_counter dpaa2_mac_ethtool_stats[] = {
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_ALL_FRAME,  "[mac] rx all frames"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_GOOD_FRAME,  "[mac] rx frames ok"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_ERR_FRAME, "[mac] rx frame errors"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_FRAME_DISCARD, "[mac] rx frame discards"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_UCAST_FRAME, "[mac] rx u-cast"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_BCAST_FRAME, "[mac] rx b-cast"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_MCAST_FRAME, "[mac] rx m-cast"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_FRAME_64, "[mac] rx 64 bytes"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_FRAME_127, "[mac] rx 65-127 bytes"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_FRAME_255, "[mac] rx 128-255 bytes"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_FRAME_511, "[mac] rx 256-511 bytes"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_FRAME_1023, "[mac] rx 512-1023 bytes"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_FRAME_1518, "[mac] rx 1024-1518 bytes"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_FRAME_1519_MAX, "[mac] rx 1519-max bytes"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_FRAG, "[mac] rx frags"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_JABBER, "[mac] rx jabber"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_ALIGN_ERR, "[mac] rx align errors"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_OVERSIZED, "[mac] rx oversized"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_VALID_PAUSE_FRAME, "[mac] rx pause"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_ING_BYTE, "[mac] rx bytes"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_EGR_GOOD_FRAME, "[mac] tx frames ok"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_EGR_UCAST_FRAME, "[mac] tx u-cast"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_EGR_MCAST_FRAME, "[mac] tx m-cast"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_EGR_BCAST_FRAME, "[mac] tx b-cast"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_EGR_ERR_FRAME, "[mac] tx frame errors"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_EGR_UNDERSIZED, "[mac] tx undersized"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_EGR_VALID_PAUSE_FRAME, "[mac] tx b-pause"),
+	DPMAC_UNSTRUCTURED_COUNTER(DPMAC_CNT_EGR_BYTE, "[mac] tx bytes"),
+};
+
+#define DPAA2_MAC_NUM_ETHTOOL_STATS	ARRAY_SIZE(dpaa2_mac_ethtool_stats)
+
+static void dpaa2_mac_setup_stats(struct dpaa2_mac *mac, struct dpaa2_mac_stats *stats,
+				  size_t num_stats, const struct dpmac_counter *counters)
+{
+	struct device *dev = mac->net_dev->dev.parent;
+	__le32 *cnt_idx;
+
+	stats->idx_dma_mem = kcalloc(num_stats, sizeof(u32), GFP_KERNEL);
+	if (!stats->idx_dma_mem)
+		goto out;
+
+	stats->values_dma_mem = kcalloc(num_stats, sizeof(u64), GFP_KERNEL);
+	if (!stats->values_dma_mem)
+		goto err_alloc_values;
+
+	cnt_idx = stats->idx_dma_mem;
+	for (size_t i = 0; i < num_stats; i++)
+		*cnt_idx++ = cpu_to_le32((u32)(counters[i].id));
+
+	stats->idx_iova = dma_map_single(dev, stats->idx_dma_mem,
+					 num_stats * sizeof(u32),
+					 DMA_TO_DEVICE);
+	if (dma_mapping_error(dev, stats->idx_iova))
+		goto err_dma_map_idx;
+
+	stats->values_iova = dma_map_single(dev, stats->values_dma_mem,
+					    num_stats * sizeof(u64),
+					    DMA_FROM_DEVICE);
+	if (dma_mapping_error(dev, stats->values_iova))
+		goto err_dma_map_values;
+
+	return;
+
+err_dma_map_values:
+	dma_unmap_single(dev, stats->idx_iova, num_stats * sizeof(u32),
+			 DMA_TO_DEVICE);
+err_dma_map_idx:
+	kfree(stats->values_dma_mem);
+err_alloc_values:
+	kfree(stats->idx_dma_mem);
+out:
+	stats->idx_dma_mem = NULL;
+	stats->values_dma_mem = NULL;
+}
+
+static void dpaa2_mac_clear_stats(struct dpaa2_mac *mac, struct dpaa2_mac_stats *stats,
+				  size_t num_stats)
+{
+	struct device *dev = mac->net_dev->dev.parent;
+
+	if (stats->idx_dma_mem) {
+		dma_unmap_single(dev, stats->idx_iova,
+				 num_stats * sizeof(u32),
+				 DMA_TO_DEVICE);
+		kfree(stats->idx_dma_mem);
+		stats->idx_dma_mem = NULL;
+	}
+
+	if (stats->values_dma_mem) {
+		dma_unmap_single(dev, stats->values_iova,
+				 num_stats * sizeof(u64),
+				 DMA_FROM_DEVICE);
+		kfree(stats->values_dma_mem);
+		stats->values_dma_mem = NULL;
+	}
+}
 
 static int dpaa2_mac_cmp_ver(struct dpaa2_mac *mac,
 			     u16 ver_major, u16 ver_minor)
@@ -32,6 +146,10 @@ static void dpaa2_mac_detect_features(struct dpaa2_mac *mac)
 	if (dpaa2_mac_cmp_ver(mac, DPMAC_PROTOCOL_CHANGE_VER_MAJOR,
 			      DPMAC_PROTOCOL_CHANGE_VER_MINOR) >= 0)
 		mac->features |= DPAA2_MAC_FEATURE_PROTOCOL_CHANGE;
+
+	if (dpaa2_mac_cmp_ver(mac, DPMAC_STATS_BUNDLE_VER_MAJOR,
+			      DPMAC_STATS_BUNDLE_VER_MINOR) >= 0)
+		mac->features |= DPAA2_MAC_FEATURE_STATS_BUNDLE;
 }
 
 static int phy_mode(enum dpmac_eth_if eth_if, phy_interface_t *if_mode)
@@ -504,6 +622,10 @@ int dpaa2_mac_open(struct dpaa2_mac *mac)
 	mac->fw_node = fw_node;
 	net_dev->dev.of_node = to_of_node(mac->fw_node);
 
+	if (mac->features & DPAA2_MAC_FEATURE_STATS_BUNDLE)
+		dpaa2_mac_setup_stats(mac, &mac->ethtool_stats,
+				      DPAA2_MAC_NUM_ETHTOOL_STATS, dpaa2_mac_ethtool_stats);
+
 	return 0;
 
 err_close_dpmac:
@@ -515,66 +637,63 @@ void dpaa2_mac_close(struct dpaa2_mac *mac)
 {
 	struct fsl_mc_device *dpmac_dev = mac->mc_dev;
 
+	if (mac->features & DPAA2_MAC_FEATURE_STATS_BUNDLE)
+		dpaa2_mac_clear_stats(mac, &mac->ethtool_stats, DPAA2_MAC_NUM_ETHTOOL_STATS);
+
 	dpmac_close(mac->mc_io, 0, dpmac_dev->mc_handle);
 	if (mac->fw_node)
 		fwnode_handle_put(mac->fw_node);
 }
 
-static char dpaa2_mac_ethtool_stats[][ETH_GSTRING_LEN] = {
-	[DPMAC_CNT_ING_ALL_FRAME]		= "[mac] rx all frames",
-	[DPMAC_CNT_ING_GOOD_FRAME]		= "[mac] rx frames ok",
-	[DPMAC_CNT_ING_ERR_FRAME]		= "[mac] rx frame errors",
-	[DPMAC_CNT_ING_FRAME_DISCARD]		= "[mac] rx frame discards",
-	[DPMAC_CNT_ING_UCAST_FRAME]		= "[mac] rx u-cast",
-	[DPMAC_CNT_ING_BCAST_FRAME]		= "[mac] rx b-cast",
-	[DPMAC_CNT_ING_MCAST_FRAME]		= "[mac] rx m-cast",
-	[DPMAC_CNT_ING_FRAME_64]		= "[mac] rx 64 bytes",
-	[DPMAC_CNT_ING_FRAME_127]		= "[mac] rx 65-127 bytes",
-	[DPMAC_CNT_ING_FRAME_255]		= "[mac] rx 128-255 bytes",
-	[DPMAC_CNT_ING_FRAME_511]		= "[mac] rx 256-511 bytes",
-	[DPMAC_CNT_ING_FRAME_1023]		= "[mac] rx 512-1023 bytes",
-	[DPMAC_CNT_ING_FRAME_1518]		= "[mac] rx 1024-1518 bytes",
-	[DPMAC_CNT_ING_FRAME_1519_MAX]		= "[mac] rx 1519-max bytes",
-	[DPMAC_CNT_ING_FRAG]			= "[mac] rx frags",
-	[DPMAC_CNT_ING_JABBER]			= "[mac] rx jabber",
-	[DPMAC_CNT_ING_ALIGN_ERR]		= "[mac] rx align errors",
-	[DPMAC_CNT_ING_OVERSIZED]		= "[mac] rx oversized",
-	[DPMAC_CNT_ING_VALID_PAUSE_FRAME]	= "[mac] rx pause",
-	[DPMAC_CNT_ING_BYTE]			= "[mac] rx bytes",
-	[DPMAC_CNT_EGR_GOOD_FRAME]		= "[mac] tx frames ok",
-	[DPMAC_CNT_EGR_UCAST_FRAME]		= "[mac] tx u-cast",
-	[DPMAC_CNT_EGR_MCAST_FRAME]		= "[mac] tx m-cast",
-	[DPMAC_CNT_EGR_BCAST_FRAME]		= "[mac] tx b-cast",
-	[DPMAC_CNT_EGR_ERR_FRAME]		= "[mac] tx frame errors",
-	[DPMAC_CNT_EGR_UNDERSIZED]		= "[mac] tx undersized",
-	[DPMAC_CNT_EGR_VALID_PAUSE_FRAME]	= "[mac] tx b-pause",
-	[DPMAC_CNT_EGR_BYTE]			= "[mac] tx bytes",
-};
-
-#define DPAA2_MAC_NUM_STATS	ARRAY_SIZE(dpaa2_mac_ethtool_stats)
-
 int dpaa2_mac_get_sset_count(void)
 {
-	return DPAA2_MAC_NUM_STATS;
+	return DPAA2_MAC_NUM_ETHTOOL_STATS;
 }
 
 void dpaa2_mac_get_strings(u8 **data)
 {
 	int i;
 
-	for (i = 0; i < DPAA2_MAC_NUM_STATS; i++)
-		ethtool_puts(data, dpaa2_mac_ethtool_stats[i]);
+	for (i = 0; i < DPAA2_MAC_NUM_ETHTOOL_STATS; i++)
+		ethtool_puts(data, dpaa2_mac_ethtool_stats[i].name);
 }
 
 void dpaa2_mac_get_ethtool_stats(struct dpaa2_mac *mac, u64 *data)
 {
+	struct device *dev = mac->net_dev->dev.parent;
 	struct fsl_mc_device *dpmac_dev = mac->mc_dev;
+	__le64 *cnt_values;
 	int i, err;
 	u64 value;
 
-	for (i = 0; i < DPAA2_MAC_NUM_STATS; i++) {
+	if (!(mac->features & DPAA2_MAC_FEATURE_STATS_BUNDLE))
+		goto fallback;
+
+	if (!mac->ethtool_stats.idx_dma_mem || !mac->ethtool_stats.values_dma_mem)
+		goto fallback;
+
+	err = dpmac_get_statistics(mac->mc_io, 0, dpmac_dev->mc_handle,
+				   mac->ethtool_stats.idx_iova, mac->ethtool_stats.values_iova,
+				   DPAA2_MAC_NUM_ETHTOOL_STATS);
+	if (err)
+		goto fallback;
+
+	dma_sync_single_for_cpu(dev, mac->ethtool_stats.values_iova,
+				DPAA2_MAC_NUM_ETHTOOL_STATS * sizeof(u64),
+				DMA_FROM_DEVICE);
+
+	cnt_values = mac->ethtool_stats.values_dma_mem;
+	for (i = 0; i < DPAA2_MAC_NUM_ETHTOOL_STATS; i++)
+		*(data + i) = le64_to_cpu(*cnt_values++);
+
+	return;
+
+fallback:
+
+	/* Fallback and retrieve each counter one by one */
+	for (i = 0; i < DPAA2_MAC_NUM_ETHTOOL_STATS; i++) {
 		err = dpmac_get_counter(mac->mc_io, 0, dpmac_dev->mc_handle,
-					i, &value);
+					dpaa2_mac_ethtool_stats[i].id, &value);
 		if (err) {
 			netdev_err_once(mac->net_dev,
 					"dpmac_get_counter error %d\n", err);
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.h b/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.h
index 53f8d106d11e..6f4981627961 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.h
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
-/* Copyright 2019 NXP */
+/* Copyright 2019, 2024-2026 NXP */
 #ifndef DPAA2_MAC_H
 #define DPAA2_MAC_H
 
@@ -11,6 +11,12 @@
 #include "dpmac.h"
 #include "dpmac-cmd.h"
 
+struct dpaa2_mac_stats {
+	__le32 *idx_dma_mem;
+	__le64 *values_dma_mem;
+	dma_addr_t idx_iova, values_iova;
+};
+
 struct dpaa2_mac {
 	struct fsl_mc_device *mc_dev;
 	struct dpmac_link_state state;
@@ -28,6 +34,8 @@ struct dpaa2_mac {
 	struct fwnode_handle *fw_node;
 
 	struct phy *serdes_phy;
+
+	struct dpaa2_mac_stats ethtool_stats;
 };
 
 static inline bool dpaa2_mac_is_type_phy(struct dpaa2_mac *mac)
-- 
2.25.1


