Return-Path: <netdev+bounces-248713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC34D0D96B
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 18:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5799330049C1
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 17:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F432877D2;
	Sat, 10 Jan 2026 17:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ix4EAMUv"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010027.outbound.protection.outlook.com [52.101.56.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA5F23C4F4
	for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 17:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768064696; cv=fail; b=KW7NxqvXdn7QyeH47DavqqDY/blOaqeh3yCCRk3dAu9YoLzze7lvT+G9/te/WmGDlfnsMQP5PhV+asuucT3CT8OjNY59lkIAR2BdGjG0HgmmwKopU8IjmMjOl1pEPaGhVXem2kkMg19a9cNnqnLqnXcw6um3ltmLGyIv24Vy4bU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768064696; c=relaxed/simple;
	bh=leOxaDdU+os+s2iFOLFWKNP9qxAcgRZ8Da66capLTkQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hf/ULjTbpQgyUPuG3OMH/8NWxjEuRXMN4HmTZlG/GqmgJTwYknF59nZL/iJKHuWSubDQCUDDT789So76lPrqvZnjEuaE1FP7q4lJYMu66b9JrxFQK8TBkQ5NKGWFtG6dRitAw2oXEWgfwTKBvTJG75yU898jps3rrdYvmV6W+kQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ix4EAMUv; arc=fail smtp.client-ip=52.101.56.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f5UkbI0JJCGDnoe1WF9EwG50OYUcrALjZLFVDofcht7pFZcn46eL3Qj/trGh2XpWJfAAB86ZJmWdmhRPDHil7v2vxTS0C0NDsyju8ncXrx3slsjSaxMnjpjHKWHDwge0mjXdBxal8t9t4ho9psfgczvAFnS6VRWImQuyXTbHArK3ijcRusLY1vPRRKqAZETn7E16EQtMBrMYp5SliPQWP3wbPF8Jx57/RuqBrhRGOqeQCwadRL1z3hy3D7DY0KF9EYS2pSwKNqYJmzHky8pO09pukDqr6K1CEjs/FPkXzW8ucWGdA5u3PC9Z0R/gbZCkSqM+E8ofiph4/2BZSRvsdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7EhNh2dUTgh5BienM8MBV52GiFnEOreuVVEqZTAcM4=;
 b=po6FexvcUAsRiEggcy38GluVgAy60MM0Z8YBFDcns86K11nteNRzYc3KLqtSKdBZcVsS8ZnyQ62anUIItTJx6d8enlIKxyEyq9JWdhGExB7PQv61j00ciz63U+cjF8vjvBdi/6bWGRvC3jpZAfnE5J9BCRO9I1ZHRBR4o5f8TlDwYwOTLL6I/JcLV6a9Q30cSlyHU4mvZciPGB0B/ZXyAB+5Y2D+Fr+Mjq3OJBLzqwLhh2bHGVgNnYaxInbs72qEUTyliNhFsT2e4mHZauV6Z+Njr2HTeL5jt0cPCiKg0pMdnpE7VepRo58LDCIkNkEtMUGxFsw0At2LCcvm2f/hHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7EhNh2dUTgh5BienM8MBV52GiFnEOreuVVEqZTAcM4=;
 b=Ix4EAMUvsNic5rF42xhZmIsek1DTH3Oa0D8fc1wTT/WBVg61Q9Fyj5lTMHcq2joSGjyqs+SzifW2MLX6XbSb+lwOit8/9NuCQyq+GbU5pd1NhsUSlm+sWK+esm+SUNKfRl09bsDGG0QrY9pRq7wsaTFVBrmJ8oFWVLxJwBlF8zE=
Received: from SA9P223CA0005.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::10)
 by SJ0PR12MB6734.namprd12.prod.outlook.com (2603:10b6:a03:478::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Sat, 10 Jan
 2026 17:04:50 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:806:26:cafe::4b) by SA9P223CA0005.outlook.office365.com
 (2603:10b6:806:26::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Sat,
 10 Jan 2026 17:04:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Sat, 10 Jan 2026 17:04:50 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 10 Jan
 2026 11:04:46 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>, <Thomas.Lendacky@amd.com>,
	<Shyam-sundar.S-k@amd.com>, Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH net] amd-xgbe: avoid misleading per-packet error log
Date: Sat, 10 Jan 2026 22:34:22 +0530
Message-ID: <20260110170422.3996690-1-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|SJ0PR12MB6734:EE_
X-MS-Office365-Filtering-Correlation-Id: 97cb6cb9-bdf9-43d8-76e1-08de506a5dad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kmSxQXjuYgOc0wEE8qKqQFb88NOizqk9BvZryPBM1Ch9DaS8bryX9cuGFxfP?=
 =?us-ascii?Q?1VUv4zWnpf9oL38U75rVxWkiom2iSV7gN9icCtkf4z/JZCLtyNrL3ACIZ1A9?=
 =?us-ascii?Q?oSb6jPG/O+CAyMNh6hbkRufN9P/2hWOsZBiUgYucRhZQVT859I9dL40sGptW?=
 =?us-ascii?Q?34FLroha2NTtTn+KH4Ktz+run4yOgdI7TWUqzzyELv+XDU9zhS+Oe91oYtZE?=
 =?us-ascii?Q?t/5Q0cSxZf/rxUXjGsLLei500UkAVwRn/oXlvzB2orU/6I94e34IyvZxw6Tm?=
 =?us-ascii?Q?Bol6mqu8OpJEfX4BjMdFOBEk/KaSUcL9/0fT71BfXe/sRsUnrK3gAGUqlZPq?=
 =?us-ascii?Q?WsrRYCEqeUhCCtOgVaLmn5Sh7tHCPfGci3gzK1P36j3ceGFY1PQOcBYWhhny?=
 =?us-ascii?Q?4ekeNeST2tR6OWu7lge7uKkiJw/cqC1/+DirAeiJzRPn0/OnO9UthH2j/jcQ?=
 =?us-ascii?Q?g3heKamUKXK15PJ/AVtScBDm0wj/CeA0Au2XVoCSpn9ZxD1zCWEw/PHgRTXU?=
 =?us-ascii?Q?LdhHV9PVBxvlzFHEno6TjFtKio9eWQoxYUPhEJeRMZgfL1hVVxhomSasM6NB?=
 =?us-ascii?Q?OyGMWf1YpVp/jlldF8KcOx7c1SHrMmBSlinVG+kyJ4wBR5ErbWrQoR9TMmvy?=
 =?us-ascii?Q?ONWx7oerTL0R1ajZ9EYjjSx3wigAGYmTvytuKvnY2JnoJEMzg39+PK52c/60?=
 =?us-ascii?Q?F4UcuFD8BDP9uEVbcnouQUlz9K96kzevUE/mPVW98mdlEVvZhOMTzorxCO7o?=
 =?us-ascii?Q?yU2QiWCHo3IMhhZGXioZO8Ri5dVAekfYfprsd7olPnbJJobcbHZGMBGUndIL?=
 =?us-ascii?Q?Khca53QwvvgwgqtULz+quPJNAgzoImrW9u8ld98wB+KocPh1syFJNfCjXDUi?=
 =?us-ascii?Q?zvF92hu9T3xvtKxmTacL6NjWCfoQV/JCHJCLbgHOyMAS6wjluSCnXSknqMmp?=
 =?us-ascii?Q?qBwQmdq0QGfupmBfl996v99QX3S5kAx2MaHHue6zxY2Cfj6jzWttfPwE4FOL?=
 =?us-ascii?Q?zpL2nAlReX8DSau3YbzZZsypcwEFK/3qVC66I/rwqDBaBl8pFgqR32sM7NR7?=
 =?us-ascii?Q?FOu1dOllJ40s1NltgtP879dk9L2jGW4At0xVaJrIemzA9bHRgooJBudZCoQE?=
 =?us-ascii?Q?kRfE17EUtWFb85XRYwaNPJjntivTR/IUlc3buyAEPcyPJ9/Ltt6I/Bu9rG3z?=
 =?us-ascii?Q?oeaKGmM+3Q4Tk2BmHPJH8o1zv2V2ejWr35F6iz6ZevpMYNqgh1uQTqimAgqr?=
 =?us-ascii?Q?Kysucr5+EmBHB6j7UdAml7F7dsxJj+lYm88YsW0fn02fKwZW+msB5Z95PdQH?=
 =?us-ascii?Q?JCBwo+s9iWbD9+v4ED5kfjbnmc/3iwWZbiO93Dq4VrkC/pazcGNSOJMzjN1x?=
 =?us-ascii?Q?PONVQ3P7szg5/WkkJGMJ/MVxiwjErPLpyXtyFqBFKUau1t0ca6KPynEXYUUT?=
 =?us-ascii?Q?pa0Il6iyZirFGjWYvzYj8pBqq9m2El92O9+z0iq3mce3Izu0ayIp0i5HpgQH?=
 =?us-ascii?Q?UiEcmUKY0FLLdLopgXMadD0fJz8JLVvegA7YX2LLRp886TUqqBTWxvRD5Lim?=
 =?us-ascii?Q?I4Xv3o3PuZF+abtt1hA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2026 17:04:50.0938
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97cb6cb9-bdf9-43d8-76e1-08de506a5dad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6734

On the receive path, packet can be damaged because of buffer
overflow in Rx FIFO. Avoid misleading per-packet error log when
packet->errors is set, which could spam logs and confuse users.
Instead, rely on the stats.

Fixes: c5aa9e3b8156 ("amd-xgbe: Initial AMD 10GbE platform driver")
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-common.h  | 3 +++
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c     | 5 +++++
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c     | 6 +++---
 drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c | 2 ++
 drivers/net/ethernet/amd/xgbe/xgbe.h         | 2 ++
 5 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-common.h b/drivers/net/ethernet/amd/xgbe/xgbe-common.h
index 62b01de93db4..4a0548e0cbaf 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-common.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-common.h
@@ -1134,6 +1134,9 @@
 #define RX_NORMAL_DESC3_RSV_INDEX		26
 #define RX_NORMAL_DESC3_RSV_WIDTH		1
 
+/* RX normal DESC3 values */
+#define RX_NORMAL_DESC3_ETLT_FIFO_OVERFLOW	0x7
+
 #define RX_DESC3_L34T_IPV4_TCP			1
 #define RX_DESC3_L34T_IPV4_UDP			2
 #define RX_DESC3_L34T_IPV4_ICMP			3
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
index b646ae575e6a..9cb57e0b26bc 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
@@ -1968,9 +1968,14 @@ static int xgbe_dev_read(struct xgbe_channel *channel)
 			XGMAC_SET_BITS(packet->attributes, RX_PACKET_ATTRIBUTES,
 				       TNPCSUM_DONE, 0);
 			pdata->ext_stats.rx_vxlan_csum_errors++;
+		} else if (etlt == RX_NORMAL_DESC3_ETLT_FIFO_OVERFLOW) {
+			XGMAC_SET_BITS(packet->errors, RX_PACKET_ERRORS,
+				       OVERRUN, 1);
+			pdata->ext_stats.rx_buffer_overflow++;
 		} else {
 			XGMAC_SET_BITS(packet->errors, RX_PACKET_ERRORS,
 				       FRAME, 1);
+			pdata->ext_stats.rx_pkt_errors++;
 		}
 	}
 
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
index 3ddd896d6987..132a2e1368ed 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
@@ -2292,9 +2292,9 @@ static int xgbe_rx_poll(struct xgbe_channel *channel, int budget)
 			goto read_again;
 
 		if (error || packet->errors) {
-			if (packet->errors)
-				netif_err(pdata, rx_err, netdev,
-					  "error in received packet\n");
+			/* packet->errors may indicate RX FIFO overflow;
+			 * drop without per-packet log
+			 */
 			dev_kfree_skb(skb);
 			goto next_packet;
 		}
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
index 0d19b09497a0..c8797a338542 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
@@ -75,6 +75,8 @@ static const struct xgbe_stats xgbe_gstring_stats[] = {
 	XGMAC_MMC_STAT("rx_pause_frames", rxpauseframes),
 	XGMAC_EXT_STAT("rx_split_header_packets", rx_split_header_packets),
 	XGMAC_EXT_STAT("rx_buffer_unavailable", rx_buffer_unavailable),
+	XGMAC_EXT_STAT("rx_buffer_overflow", rx_buffer_overflow),
+	XGMAC_EXT_STAT("rx_pkt_errors", rx_pkt_errors),
 };
 
 #define XGBE_STATS_COUNT	ARRAY_SIZE(xgbe_gstring_stats)
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index 03ef0f548483..735c757e1603 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -675,6 +675,8 @@ struct xgbe_ext_stats {
 	u64 rx_vxlan_packets;
 	u64 rx_csum_errors;
 	u64 rx_vxlan_csum_errors;
+	u64 rx_buffer_overflow;
+	u64 rx_pkt_errors;
 };
 
 struct xgbe_pps_config {
-- 
2.34.1


