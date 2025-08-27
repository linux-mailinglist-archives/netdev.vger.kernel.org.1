Return-Path: <netdev+bounces-217185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B58BFB37B0B
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 08:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 822073660AF
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 06:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED908320CAB;
	Wed, 27 Aug 2025 06:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GWBXSttI"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011064.outbound.protection.outlook.com [52.101.70.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E843203BB;
	Wed, 27 Aug 2025 06:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756277770; cv=fail; b=PDf7zHfOSJaxNdEQTOpPu8x58yiT8ulxtDVz+ZwBiamf7PLhev/VK2JGMWx64M/GkCpRnC2EGF41BvhxmyjK16TYUAyFMcNaJ62/M2ZbyEav+Rj6YrstON5vuQBtsun4fHqopnEbgdF6alU0cvaDCwB8l4/sf9P3sEnCG8HRajc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756277770; c=relaxed/simple;
	bh=UTJojxAfJgGXQCOwb3TK5Rtk/qCsTObezhIbI0siTzc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ATRJGM5/8rQ9bUwb+GOzoZlLlxueJdL63sTE45UHQykxwP2+K//ImZNstZJEb6mW3aggOwbjMz6eFl20H9phLeNP7kHC040SdgciEcMHUUuaRHk9zm1VSxXqEpObWrm5EplA4W+0rsbZ74fvz3tm1U7xkEZQF82qdrx1N02xYOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GWBXSttI; arc=fail smtp.client-ip=52.101.70.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pbQSzhAN16hgKIc/GA7XbGt4JPE6nvTWPMckYJ44k3EHyDn4eHPNOkXEwI0/VaChKPYRCkK3Xev4wD3eWPC/BHkWLGznk5L+ZvSmBJsu+ZDKD+SoVV3mO2W6iqT5I4pjRRbTcq9D8AM7hAq7isPNy3itV3NS5bK1+I5uzdBJ5zrUwS85b8bpYodiqhFAU0Ot/YtjDSaO+3RxRGabogHzAUFSsqN41ubhlwUe6g1RYXQHE+7PLfxu0787RhPs1Ac9AYmCAG1l5B0IWYE4Yyg2znnVp4lWG2kaCUoyLvLpy8TPV35DTsghOUkOAi3KhG4+BUwXBzZHjNPlkxqOctxlaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ucfHascZUdMHPH12RzZxkEiFjr/60Mx9pgVPaAAU4ok=;
 b=PpKOvnUH1AKt2nQIBp8nlv7fMn6X+jvRx7ks+zvRheFgXyqXa6GuYXspyfTDMew9kejCMAxqdzL4Or37lHlhUeYu7OY3262swm9U5mmTtAZeXnGevJH2jJ0PSF7wSZR01RDOBB4/AIO+2xdGCDkRkgicXqnzMJkAZybAMwPSTbTkHK4owuUT5HnSsdfnO2UYUyOq9exNYYfW6S7Wy4BKWyemkISbZR3iGZ4ZkJxvkMJsS5zLutfEkGwGtaM4OUOHkSIK+pG6pTB+keew//SOBEEqW7WysMvEmsEwluMuOS+wpM+06xDv5jQeZTXWuJxIrz+EN31NhagITIJhqwO8zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ucfHascZUdMHPH12RzZxkEiFjr/60Mx9pgVPaAAU4ok=;
 b=GWBXSttIsQkm0wD4lQ4o0F4epa9nh8+YAX9LBa/wSiGyucmOVhCSixk+8ZIcimckEx9GYqkXmmorIGhEylflmIv3wZ5BVFSUoJBhcf3qvuYl/g+vapFn1/5ypNAzbdQGYLWYYjalOskXc+6RIaHdSXeOQcR8bwvIVZnO06o/xavpeokuZY2vD0qrWLruN9bsfURzdUr8OTP1+NxHS+Oag6JSX+RO9nFzqmSeXjVeHYpXtULnbJ7Z6Y8Maxp+b3FJRmKfS/YXfQOoteFQvk1EXNvhfNDYXSTEbGaFSj1rLOQlv4Ip5ZNFl//TpNQf1jlj8LVtzJbrPYdcUN1fvYqUBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB9PR04MB9676.eurprd04.prod.outlook.com (2603:10a6:10:308::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Wed, 27 Aug
 2025 06:56:06 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 06:56:06 +0000
From: Wei Fang <wei.fang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	richardcochran@gmail.com,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	Frank.Li@nxp.com,
	shawnguo@kernel.org
Cc: fushi.peng@nxp.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v6 net-next 12/17] net: enetc: extract enetc_update_ptp_sync_msg() to handle PTP Sync packets
Date: Wed, 27 Aug 2025 14:33:27 +0800
Message-Id: <20250827063332.1217664-13-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250827063332.1217664-1-wei.fang@nxp.com>
References: <20250827063332.1217664-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0111.apcprd02.prod.outlook.com
 (2603:1096:4:92::27) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DB9PR04MB9676:EE_
X-MS-Office365-Filtering-Correlation-Id: 993c396a-28ad-491c-06ef-08dde536cb15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?arIpYXU8lMRWWRkrHjrzvgZzLJbc/3Vj/wUH8Zd340cADW20ztDrCsPQCM8g?=
 =?us-ascii?Q?AYIphfIaDOusClUFDI0HaTEuv1XtsJw2xhOZa5W9zO+jPha8MmPcjDapViyL?=
 =?us-ascii?Q?WoOuvCKVtUq3QDt6nSB/aV7lT4BEVUqXXOb+wnCFMaHf9XoooTgLNEps/LIs?=
 =?us-ascii?Q?hKBsHf5WwpNdtYa9a1+Z+LqK7k7gjcUpGnwMG9jylMQSRXUL9KzfcHQlFXvw?=
 =?us-ascii?Q?qhrXg9trVGbPkVvU/+wr7MuJ67D+h+L0ureaFsaUkhKW1QRoIRUfNGU5pePp?=
 =?us-ascii?Q?Gqkr1FK6Gydpg69ShUVfbFWlT+LJxJ+vfhaZX+cYtdyQ+63XBcCNF1nvdsgu?=
 =?us-ascii?Q?v/LXE4usNfZ48lIAUphQZcqpeuDbjXKQKfOnYN2m/TyiRRDuK/Ue+XZzIYII?=
 =?us-ascii?Q?gkbcHlYar1j5Q5x9EWGO98Dz2zFZJJQOWRdyCQc1n3kuo9VNhmAV/tGSq9l4?=
 =?us-ascii?Q?c4Kuw88g6AGFvkp9dXVwBr3fMycbZU/9BMeGHj7lspPwMFOdSNbQQgI24rvG?=
 =?us-ascii?Q?3xViy0Oi9Vrpzc0KgcoFPqL86AL5DzGwRmMJxpqXZTaOSLMUCssquxgPwczL?=
 =?us-ascii?Q?lHOofn7zgMnaDn6cE00K6WmUwwNNF4zwDtGr6RXWB6jaRwundJ9hysNvBDYC?=
 =?us-ascii?Q?GWXTpRVRcgW5Vm6LqHsjjE2E7podEGm2RnrZI6ohwPWqP5YMceqDSy9q56S8?=
 =?us-ascii?Q?2f/XYP1RsVcvQPaf/Cs+lH0OvLNTZHWl2PZ/UTN5FB6yRf/7JNmv1PWBboak?=
 =?us-ascii?Q?w5P5Wl04EQ+tdflxkN0eiAY3vY3poKp6+yfGyuYru5JSVn9RqmrvPopZPN9r?=
 =?us-ascii?Q?k63alkkSHyEhgxCLbKEgVHlDWjO8CSVSfb1lkrzYiFMYYMFxAz2J/QxZC1v9?=
 =?us-ascii?Q?IYHDEZIH1BCgIKhadSJhIsvFuAHqzY+Ig9NBCvusaXJjH4O66w3XkMhvgbcK?=
 =?us-ascii?Q?AYf+rIv0+zszavpAKylC/3HWYtnxmk6DjWUk05D86MnGO9qHDNK1m3aN3GvO?=
 =?us-ascii?Q?QkryiuMJnXaNmigB50E/3VfSvABvX3DbvXHXzRJxLYwK0Kr1dPz65dHScfq2?=
 =?us-ascii?Q?ikjzvaKaU6UMl+D3J+POWSYEH0v6jhSxIM0IE0OmQCPQKo2x3OdAssllKvoT?=
 =?us-ascii?Q?zszSqhYIoY19EJKYnXTvhf8bJCPf4Mv61D8+PKQKhJBWWVKdEN+PexpiJRwC?=
 =?us-ascii?Q?LIOr0AlVwXhT+U1+dPBj4eLITiObBzqqmXewSf0XlWBDaM98s5at7weerERa?=
 =?us-ascii?Q?Hc7MVB9JQaosus6v5JPR2OOo71EZy0ES9ziA8TNV2jD2QnJIfUI+J5MMcZsT?=
 =?us-ascii?Q?hX+AWxQX2rNrDTfwBBzroLbgpmLe8ak2aublCOgX+FQrvrxrV54h/nhDu8Xk?=
 =?us-ascii?Q?dnT2OhBgkMa54msjrhqLHDomqwzU3MpvTLFm1igZgq0XS8QZboSw7/VM4Va2?=
 =?us-ascii?Q?iZ0c1QW2CZY5nlmvsqSDXAhOyJ85xTx/5fU4GNJhMhcRalwsFQzFk6SL1gKE?=
 =?us-ascii?Q?6JICg3R9/SsplhE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m8gvmvnpDcRXvG3yEFgdhh9/O8DasVqHDm/YR3o6CmrR+7Hf33m5XP06JEhE?=
 =?us-ascii?Q?SaR84iWuSTkVMw/2GoCfBBWarmQ8DqVXUUxWgCd+6IdIN2hbu5n0XrhaIa4i?=
 =?us-ascii?Q?oYs4oExWAng443DYRTr3dGZ7sPNcc9LUbhwfDYAnZiExb0z8b5DlGyjtqPdu?=
 =?us-ascii?Q?VYDv1gZdW1gVCwhiw5IhQtA7yUI+fOd3eLVL8bKC3A9/9o6ywhs3AXgsbAEF?=
 =?us-ascii?Q?SiQ3XfvMekm+cMnnTRYD2FHZ78g8b3Ju/nN4yjdGahdMRTIrUioSTyZzxA6X?=
 =?us-ascii?Q?lnIUUafHtRqLhawdCWDx1saZ+WT9/NbX05wPZWzairRw/Oxz2DSDGVyxU579?=
 =?us-ascii?Q?JZwCZ1r7GTa/tDLHwaJBTml/QQ/3xKnKGHcOkStyeZqQdACTL7QswZeHW8wK?=
 =?us-ascii?Q?Z9EOWMmZvn2DESxWV63z+jmiaKwgmwcv2WAMgGk9YRg0V4xMYEEl0JA3cqjz?=
 =?us-ascii?Q?3nW7OoOheQk5zPIzAgU6Shf4W3HB7AD7KIe1dL0N49xp7PyFOXp+TQQ2bJmA?=
 =?us-ascii?Q?1x6xjZysRx/Sj0L9fHqS/odcSqnluojphx6xd3uNcoL2KZAgrkACMlTPnHVi?=
 =?us-ascii?Q?RNha7xvk8jp9g+YxA9EyN55jIva4TtfWiYs23OdNnMU1BemtTF0SvQbHiaTr?=
 =?us-ascii?Q?kAOweYgYzhkmPUei3U+yLhiM5VN9kOrlt/fi4p2zSB4bee750Pl6MdUZBqrR?=
 =?us-ascii?Q?PUpU3hTI76gdqfLgfWvjpqce7dAIFtwme7vNKsq27ZXW6m5Xxu05zLoydFsK?=
 =?us-ascii?Q?JeClYA7Dv8H8GV0zAEjBMsWSlk7NsW7A4kBjGXUVoDrUWGsKHQGOS7r/ORiT?=
 =?us-ascii?Q?LUhLJCnD5p49rI/T0lmLKGn5TPJXVaFBnjVQRbFoAJzWPRa2Qy0PRi2J3x0M?=
 =?us-ascii?Q?CxFaBka3XzHM/AzW5gOeKCI1vjvV6V5TsWpmvm2YfOGrzSZC0JOZUGxhCkf6?=
 =?us-ascii?Q?8Tdk4WOb7IoEj1i/PlYFfCtqfQJbrI5PNALvS8EpeqkQilpN3iu5mytMtWfn?=
 =?us-ascii?Q?F6nQxHCkZFqHglOUEwlzaQroqOPg8eQHKr1VjAwoWqWP42EcHL0nx71BJHVD?=
 =?us-ascii?Q?jWPYVM/tAZw7R1MzmOJ9K4cAsJGnU88NUbUCBqiTpAbX05IlKqKfLonZVGN1?=
 =?us-ascii?Q?/GCMOpGyUtNdOUrD9r4lmoJ5asfsCUWt28lQgqT+oRtEkTrUH2OWJxBahI1F?=
 =?us-ascii?Q?W/1XVvsSQQItJ92ngkBTiVD/0mC+5wc2vo3lX4CISIYbys8pEagciNqIT8NW?=
 =?us-ascii?Q?qmpTN6IIAydPNrE/2zXW463tGaHRgh1jJHgWbZHrJUJZV2C4WqvP5jLSMHvV?=
 =?us-ascii?Q?4zTpjLD4m2K3qmOJZaRl6jPzv7RgSHidcnPr/F9ji5QxGI9BKyYjz2QRUiJO?=
 =?us-ascii?Q?gdI2XVx/lIWITdHJeBBa9TBPfodV1Zn+i2Ol+eAHb0kM6u35DuTJTgHfvSm6?=
 =?us-ascii?Q?prDWvo6sNAPZyLuNkPyPiOg2NjT0vJ15Jmwem3mGxUv9nIWJdMtW925d8KOm?=
 =?us-ascii?Q?UfZbw0q2Xt+vtguzLm6Hg2M4O0wgoZa7ZLnAtzRf+LB2K83yYWH7Tak0Ew9S?=
 =?us-ascii?Q?xG/OZ2CBCkzCiJQy1TFoeNoEFV73WjZZ6YO57jCw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 993c396a-28ad-491c-06ef-08dde536cb15
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 06:56:06.0859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PqtR7GKs2KfQKWaxkl/jEm1gncxwO99aT/HlWUJnX9hZn7AcPigC9N2at/09o9mKJwuqxGbbVtXw4Pbms1n3Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9676

Move PTP Sync packet processing from enetc_map_tx_buffs() to a new helper
function enetc_update_ptp_sync_msg() to simplify the original function.
Prepare for upcoming ENETC v4 one-step support. There is no functional
change. It is worth mentioning that ENETC_TXBD_TSTAMP is added to replace
0x3fffffff.

Prepare for upcoming ENETC v4 one-step support.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>

---
v4: Add ENETC_TXBD_TSTAMP to the commit message
v3: Change the subject and improve the commit message
v2: no changes
---
 drivers/net/ethernet/freescale/enetc/enetc.c  | 129 ++++++++++--------
 .../net/ethernet/freescale/enetc/enetc_hw.h   |   1 +
 2 files changed, 71 insertions(+), 59 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 54ccd7c57961..ef002ed2fdb9 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -221,12 +221,79 @@ static void enetc_unwind_tx_frame(struct enetc_bdr *tx_ring, int count, int i)
 	}
 }
 
+static u32 enetc_update_ptp_sync_msg(struct enetc_ndev_priv *priv,
+				     struct sk_buff *skb)
+{
+	struct enetc_skb_cb *enetc_cb = ENETC_SKB_CB(skb);
+	u16 tstamp_off = enetc_cb->origin_tstamp_off;
+	u16 corr_off = enetc_cb->correction_off;
+	struct enetc_si *si = priv->si;
+	struct enetc_hw *hw = &si->hw;
+	__be32 new_sec_l, new_nsec;
+	__be16 new_sec_h;
+	u32 lo, hi, nsec;
+	u8 *data;
+	u64 sec;
+	u32 val;
+
+	lo = enetc_rd_hot(hw, ENETC_SICTR0);
+	hi = enetc_rd_hot(hw, ENETC_SICTR1);
+	sec = (u64)hi << 32 | lo;
+	nsec = do_div(sec, 1000000000);
+
+	/* Update originTimestamp field of Sync packet
+	 * - 48 bits seconds field
+	 * - 32 bits nanseconds field
+	 *
+	 * In addition, the UDP checksum needs to be updated
+	 * by software after updating originTimestamp field,
+	 * otherwise the hardware will calculate the wrong
+	 * checksum when updating the correction field and
+	 * update it to the packet.
+	 */
+
+	data = skb_mac_header(skb);
+	new_sec_h = htons((sec >> 32) & 0xffff);
+	new_sec_l = htonl(sec & 0xffffffff);
+	new_nsec = htonl(nsec);
+	if (enetc_cb->udp) {
+		struct udphdr *uh = udp_hdr(skb);
+		__be32 old_sec_l, old_nsec;
+		__be16 old_sec_h;
+
+		old_sec_h = *(__be16 *)(data + tstamp_off);
+		inet_proto_csum_replace2(&uh->check, skb, old_sec_h,
+					 new_sec_h, false);
+
+		old_sec_l = *(__be32 *)(data + tstamp_off + 2);
+		inet_proto_csum_replace4(&uh->check, skb, old_sec_l,
+					 new_sec_l, false);
+
+		old_nsec = *(__be32 *)(data + tstamp_off + 6);
+		inet_proto_csum_replace4(&uh->check, skb, old_nsec,
+					 new_nsec, false);
+	}
+
+	*(__be16 *)(data + tstamp_off) = new_sec_h;
+	*(__be32 *)(data + tstamp_off + 2) = new_sec_l;
+	*(__be32 *)(data + tstamp_off + 6) = new_nsec;
+
+	/* Configure single-step register */
+	val = ENETC_PM0_SINGLE_STEP_EN;
+	val |= ENETC_SET_SINGLE_STEP_OFFSET(corr_off);
+	if (enetc_cb->udp)
+		val |= ENETC_PM0_SINGLE_STEP_CH;
+
+	enetc_port_mac_wr(priv->si, ENETC_PM0_SINGLE_STEP, val);
+
+	return lo & ENETC_TXBD_TSTAMP;
+}
+
 static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 {
 	bool do_vlan, do_onestep_tstamp = false, do_twostep_tstamp = false;
 	struct enetc_ndev_priv *priv = netdev_priv(tx_ring->ndev);
 	struct enetc_skb_cb *enetc_cb = ENETC_SKB_CB(skb);
-	struct enetc_hw *hw = &priv->si->hw;
 	struct enetc_tx_swbd *tx_swbd;
 	int len = skb_headlen(skb);
 	union enetc_tx_bd temp_bd;
@@ -326,67 +393,11 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 		}
 
 		if (do_onestep_tstamp) {
-			u16 tstamp_off = enetc_cb->origin_tstamp_off;
-			u16 corr_off = enetc_cb->correction_off;
-			__be32 new_sec_l, new_nsec;
-			u32 lo, hi, nsec, val;
-			__be16 new_sec_h;
-			u8 *data;
-			u64 sec;
-
-			lo = enetc_rd_hot(hw, ENETC_SICTR0);
-			hi = enetc_rd_hot(hw, ENETC_SICTR1);
-			sec = (u64)hi << 32 | lo;
-			nsec = do_div(sec, 1000000000);
+			u32 tstamp = enetc_update_ptp_sync_msg(priv, skb);
 
 			/* Configure extension BD */
-			temp_bd.ext.tstamp = cpu_to_le32(lo & 0x3fffffff);
+			temp_bd.ext.tstamp = cpu_to_le32(tstamp);
 			e_flags |= ENETC_TXBD_E_FLAGS_ONE_STEP_PTP;
-
-			/* Update originTimestamp field of Sync packet
-			 * - 48 bits seconds field
-			 * - 32 bits nanseconds field
-			 *
-			 * In addition, the UDP checksum needs to be updated
-			 * by software after updating originTimestamp field,
-			 * otherwise the hardware will calculate the wrong
-			 * checksum when updating the correction field and
-			 * update it to the packet.
-			 */
-			data = skb_mac_header(skb);
-			new_sec_h = htons((sec >> 32) & 0xffff);
-			new_sec_l = htonl(sec & 0xffffffff);
-			new_nsec = htonl(nsec);
-			if (enetc_cb->udp) {
-				struct udphdr *uh = udp_hdr(skb);
-				__be32 old_sec_l, old_nsec;
-				__be16 old_sec_h;
-
-				old_sec_h = *(__be16 *)(data + tstamp_off);
-				inet_proto_csum_replace2(&uh->check, skb, old_sec_h,
-							 new_sec_h, false);
-
-				old_sec_l = *(__be32 *)(data + tstamp_off + 2);
-				inet_proto_csum_replace4(&uh->check, skb, old_sec_l,
-							 new_sec_l, false);
-
-				old_nsec = *(__be32 *)(data + tstamp_off + 6);
-				inet_proto_csum_replace4(&uh->check, skb, old_nsec,
-							 new_nsec, false);
-			}
-
-			*(__be16 *)(data + tstamp_off) = new_sec_h;
-			*(__be32 *)(data + tstamp_off + 2) = new_sec_l;
-			*(__be32 *)(data + tstamp_off + 6) = new_nsec;
-
-			/* Configure single-step register */
-			val = ENETC_PM0_SINGLE_STEP_EN;
-			val |= ENETC_SET_SINGLE_STEP_OFFSET(corr_off);
-			if (enetc_cb->udp)
-				val |= ENETC_PM0_SINGLE_STEP_CH;
-
-			enetc_port_mac_wr(priv->si, ENETC_PM0_SINGLE_STEP,
-					  val);
 		} else if (do_twostep_tstamp) {
 			skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
 			e_flags |= ENETC_TXBD_E_FLAGS_TWO_STEP_PTP;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index 73763e8f4879..377c96325814 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -614,6 +614,7 @@ enum enetc_txbd_flags {
 #define ENETC_TXBD_STATS_WIN	BIT(7)
 #define ENETC_TXBD_TXSTART_MASK GENMASK(24, 0)
 #define ENETC_TXBD_FLAGS_OFFSET 24
+#define ENETC_TXBD_TSTAMP	GENMASK(29, 0)
 
 static inline __le32 enetc_txbd_set_tx_start(u64 tx_start, u8 flags)
 {
-- 
2.34.1


