Return-Path: <netdev+bounces-256330-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NsPA50NgmkKOwMAu9opvQ
	(envelope-from <netdev+bounces-256330-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 16:00:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CB91DDAF50
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 16:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DEAF730493B5
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 14:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58ECF3AEF2F;
	Tue,  3 Feb 2026 14:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gbfEhzMM"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012024.outbound.protection.outlook.com [52.101.43.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6323AE71C;
	Tue,  3 Feb 2026 14:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770130664; cv=fail; b=lN8WQu7cdLO7pFW4yhKq7q4dJO8zWS893nX59x5EE+IeRuSMbJhoom45/D2F06T7g1QNR4yW9xPSKwqvvTq9y5SxPeNp6vVgRI4x7oKCgVY77Hi4QJPMvjpwg/7f+k4MANa2Qww3rR1C6dOyxTTO8CS9ZtfMu4sL9PNHoFPonmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770130664; c=relaxed/simple;
	bh=kO6ef33M51YT9rDY4YmFArc3UUGe5Gu887Z+pcgmL/o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sb/wl8uEiY9MKF6/gzBYvQKhRVJJF6QLw1/1W/QpxEL0+OspEEtui0EtF+1E09NCJxouBf3+6jByGInqcIXER4v/zsQenj5L974XSkd8F51wpuJtWFMd2LwNuNhoosw64+rBp0WAvz8kmlIqUet8EtQzPQOm8wwbj0duuQz8xhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gbfEhzMM; arc=fail smtp.client-ip=52.101.43.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ib3EOheWP5mnuUmg2+KuyQ8SRVGbYxPxJERyD8pOHxko2s2jF8hDXAD32mT1zbCpJP1tGLUqVzhavehcpv2higE1XYS2z6hObcm7CWp8mdD4+fIOPqRYsQF60vYtuUNb/MMxr0tWpd+pcOsmNpXeJ/pwxpEwlGxQRJHmYvCwzey1v+ps5jWyvPxKTCk5QMY2QDaRTHtcGGp/1LRWpsGP0j/fqIeRU05d0yNPGhiFsAXSvA6FQOKhDJcSoz1+h8C9WJwt24/YTgV9BUNImRfTPoC12s+GrLUyw9K8FGY0IQgoIZarKG/hjYFGvm4u3nP2DOKKZTUTAQavWt6Jswow8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWXlxgRc+uSyrnjAoY5z+tf3p33Kz/wqtWR84z58TA0=;
 b=kFN5201AIcHXbZQnjnNNagrOho6D4IRYOKmaT8eBrJrvWtW0y1ss5Bjg1/x3U89UOMXL2L3U5zG9QcOx0a8GAQTS9OhkROqfZnQCY92g5f/kiSYoBdxRDyQBmqrM87+zIpHpgFr/oKjClM+VlMQmKCw3aWiT8O0j6alqeFnryfmlL93Q/x8Wit9RzQ55UcDZ2Qc8vtdwpQl/1GaTuw3sFyM5WdIJFX8m9B/2xR0nZzuPGOGkCSIgsyRroR+mA1sIBEfAa9rFzQBALPU/foCZxIZk9kh90l5g4C2vDWL1NcFqgTYR4MeVwnJA6S9MACaeoQsC2IMogi0XWQNAZkKD4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWXlxgRc+uSyrnjAoY5z+tf3p33Kz/wqtWR84z58TA0=;
 b=gbfEhzMMOZzDLhwppXAmnS8ue9Pv5YqbZdGzaJZ4BK4qUHfqGMW3NuR7ko7SWYxmxiz0NEp8imuxL0jfKWsTPHsaZf/Vje8hX2BLX9eoH/cSX4FLtUfJ2vuX2UjNo1SMENsVEy97agECop8X/RWwbxcvmDQFvmlpNVoyIHbigwk=
Received: from PH7PR17CA0026.namprd17.prod.outlook.com (2603:10b6:510:323::19)
 by CH3PR12MB8331.namprd12.prod.outlook.com (2603:10b6:610:12f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 14:57:37 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:510:323:cafe::d4) by PH7PR17CA0026.outlook.office365.com
 (2603:10b6:510:323::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 14:57:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 14:57:36 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 08:57:26 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <horms@kernel.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<linux-kernel@vger.kernel.org>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH net-next v2 2/4] amd-xgbe: add hardware ARP offload support
Date: Tue, 3 Feb 2026 20:26:56 +0530
Message-ID: <20260203145658.2936778-3-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260203145658.2936778-1-Raju.Rangoju@amd.com>
References: <20260203145658.2936778-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|CH3PR12MB8331:EE_
X-MS-Office365-Filtering-Correlation-Id: 73cd8953-5c7d-4fbd-5e84-08de633491d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/NI+6Ax6ir0RnNifp9yy4DiF7fuLxifkQCPV6d11Mjmn6O1tOqMu5zjBBx7J?=
 =?us-ascii?Q?3DeHRVT0ZbLuefcy1Pkyv4P3rRn2NSe6tOPthydkInunlG2z2pZxTdmlrORl?=
 =?us-ascii?Q?rH9TURnahvPnLwwokbSlWM83N/UDi2Gv8SNDpuoD42ODetRJbxM17RSKfKma?=
 =?us-ascii?Q?C49BrLgAjYMX7KPXuAQnzdDbT/YtzST3i2q0oA0Mrex7XjCFsefqMv2e20dw?=
 =?us-ascii?Q?qAa2/qttsBSoEz6DV+KPLmt2w+5Jm3yS+jsyABEe+AwxFsD2K/Ml8Ar8xyKB?=
 =?us-ascii?Q?DGGk1wWf7E7BG9nOyTA3a5wOolJsa4a8fR7sSYcm02/gmJMv3DyHKD4twPDv?=
 =?us-ascii?Q?nnn26JRgcF7CXbzrn2Gcew4g7wpFP91U4E+ToNqcdGfkTzyRizA7N/O7HW7K?=
 =?us-ascii?Q?LJMeHrWlYeg61m7VqrGGoEv3/nfWbRYAVXfnn5njhfsUy7YZhtJYvAgLzX+r?=
 =?us-ascii?Q?urA9/F750OUv9fDa9FONnkNYd69A36b1VnTroG3IcWnLml8jQhSjkd/e1WnR?=
 =?us-ascii?Q?8YwPLu/v0PX5xL3JmE4SEXb5+AZdAyghVR5dY6QkQ7WtxK8GJeP5xXFvjACs?=
 =?us-ascii?Q?EoqDG99BAXumuTf924N9FMG7i4QHy4NQwRQt4gwy66FppRLXtZ6ZL2JtFii1?=
 =?us-ascii?Q?yr2gv3yVm1GG33Tp7b2r4qu1d5lsYN++Q/fsiJ9QkP7K2UkCy+/lDKriKzII?=
 =?us-ascii?Q?Jx2DNGTUn/hbvroOuXspTdCw6rJxRp9Px20CwVNd9K1Kl1qbyVJ9XlMTkWvn?=
 =?us-ascii?Q?nuVKrTpkMpE4CXD4u+oSEUBlJk+Ph1kChv/pywajwCCmXfP7Zc9R3Ur0Czrd?=
 =?us-ascii?Q?0lsWP0nN6Pqv5eho2PLs50NmXfai2Dg8hYomBrIGOMyJmYuCoJEYgyLbKXzq?=
 =?us-ascii?Q?GkoK6bipLzMaP7cESGkhNQMy5mnHK1vVltNFTt/Mz77nND2IJHNZ8oEE+xjr?=
 =?us-ascii?Q?++irwvI+t9PNh8ZVr3i5HQJo/JtvehSgJXRRYYhOx4H3QQSirKYRoS1OMADD?=
 =?us-ascii?Q?aKGMC5eoQHsQIRxYu2qkC2y5QvnlSMOV+y6mpvyYog1M6TkrbQNQlcQAvBM/?=
 =?us-ascii?Q?yguByGDRguXQyfU35oPnPT1y+O8w4W/2K2ygmeBdkUj47CBfwBf7m+uYgkrj?=
 =?us-ascii?Q?R5/ehl+MyZ7Fe/5BXsbmzP4USuWXFbfG3FYRN8uMBB8+662ZFwS0Ka2e/lP5?=
 =?us-ascii?Q?W904HmuJeF8aTdoyjouO3rGctu4mZulcJPeP1rX7mRm49lhrw4cd1UwMKdpC?=
 =?us-ascii?Q?yBk+rhNQq4ASfvbNa6XO2ORCWpdM2OhhogbW54aR3k71GIb2Gp+x0Otl0UEo?=
 =?us-ascii?Q?XZOL2vlnUuiTTyj/pHbKezyXS5qHcuZjNU92Eee+lC6wj3+dgBglz7tXkKDs?=
 =?us-ascii?Q?HqpT7cJjRwjNZmkPWpnQWPep3u5RPpY9lSXpv7R6f4mEGfrl8NT38xeYV6/s?=
 =?us-ascii?Q?oziA8IGyuLXAXUmkmF07IQBIsxYKRUFi9bcwvqCbIyy51ncxqY6t+VA8ebin?=
 =?us-ascii?Q?buDblcBKtJdi8JqR+YYcEnnSJmxt+n+hL1HEsQDRKrE7PrlNR8WN+qfTRdtt?=
 =?us-ascii?Q?7bwxWlOwWbPjrAjvjPwOezCHJwi6PNWhYckyb4D4qw2oAuthQ3515K6lw4OL?=
 =?us-ascii?Q?RI2xwtsb8SYf3FYZBupDopQeS4ZIy/wcTOA16vgZrkubxEpjcY2Ux9Wfxvhn?=
 =?us-ascii?Q?1lS4Bw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	46PwPOnj8EDlZSsxeTOSIsnV/ZanufZtuYZJn6dnq70/K3uyGbwQAfDzuPYFDCJ46Fx9hmdCiyjtcq2+BfXpNBJzyE1SvaKo0V7O1c3vYdlFxu1M1Ejg8m/GVVx6wHS89RsP5tPtmPFdJrHrLPoFmEnotTLpUOLlw5X1oi6xn4krKRxiaiKfaA6wTT1SRPWmLqTyd1EgeXidcqy9e3w0Ijrz0Wk9GIoQ0hOevtsm3jBQ5bnagfnYzFP+JqzHqNMebF/AZ+VgVWTbXIHF4Y61YJeIxGiUosCZhqZpZNbonc28zzsxFS86hemPRXyKevxkxwvuPraCXoxBctsEXV2gqnWXFXywYryd/qFJ3dvDNQNw4fBlCI/CcZs2vndlggd7a4cfNJWi7G58a7n95X/4p5LvC9N6T9KKpF5sNMIKL6AwcXZF12BYj1nR3n384K42
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 14:57:36.8361
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73cd8953-5c7d-4fbd-5e84-08de633491d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8331
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256330-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:dkim,amd.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Raju.Rangoju@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CB91DDAF50
X-Rspamd-Action: no action

Add ARP offload functionality to the XGBE driver that enables the MAC
hardware to automatically respond to ARP requests without CPU
intervention, reducing system latency and power consumption.

The XGBE MAC supports ARP offloading through:
- MAC_ARP_ADDR register (offset 0x0c10): stores the IPv4 address for
  which the hardware should respond to ARP requests
- ARPEN bit in MAC_RCR register (bit 31): enables/disables the ARP
  offload feature

When enabled, the MAC hardware will automatically generate ARP replies
for requests targeting the configured IP address, without involving
the host CPU.

The feature requires the aoe (ARP Offload Engine) hardware capability
bit (ARPOFFSEL) to be set in the MAC_HWF0R register, which is checked
before enabling.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-common.h |  3 +++
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c    | 24 +++++++++++++++++++++
 drivers/net/ethernet/amd/xgbe/xgbe.h        |  4 ++++
 3 files changed, 31 insertions(+)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-common.h b/drivers/net/ethernet/amd/xgbe/xgbe-common.h
index 711f295eb777..522e71f2d6e1 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-common.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-common.h
@@ -210,6 +210,7 @@
 #define MAC_MACA0LR			0x0304
 #define MAC_MACA1HR			0x0308
 #define MAC_MACA1LR			0x030c
+#define MAC_ARP_ADDR			0x0c10
 #define MAC_RSSCR			0x0c80
 #define MAC_RSSAR			0x0c88
 #define MAC_RSSDR			0x0c8c
@@ -400,6 +401,8 @@
 #define MAC_RCR_RE_WIDTH		1
 #define MAC_RCR_GPSL_INDEX		16
 #define MAC_RCR_GPSL_WIDTH		14
+#define MAC_RCR_ARPEN_INDEX		31
+#define MAC_RCR_ARPEN_WIDTH		1
 #define MAC_RFCR_PFCE_INDEX		8
 #define MAC_RFCR_PFCE_WIDTH		1
 #define MAC_RFCR_RFE_INDEX		0
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
index c04a9c76bd40..c9243b4d7682 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
@@ -3605,3 +3605,27 @@ void xgbe_disable_mac_loopback(struct xgbe_prv_data *pdata)
 	/* Disable MAC loopback mode */
 	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, LM, 0);
 }
+
+/**
+ * xgbe_enable_arp_offload - Enable hardware ARP offload
+ * @pdata: pointer to driver private data
+ * @ip_addr: IPv4 address (in host byte order) to respond to ARP requests
+ *
+ * Configures the MAC to automatically respond to ARP requests for the
+ * specified IP address without CPU intervention.
+ */
+void xgbe_enable_arp_offload(struct xgbe_prv_data *pdata, u32 ip_addr)
+{
+	XGMAC_IOWRITE(pdata, MAC_ARP_ADDR, ip_addr);
+	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, ARPEN, 1);
+}
+
+/**
+ * xgbe_disable_arp_offload - Disable hardware ARP offload
+ * @pdata: pointer to driver private data
+ */
+void xgbe_disable_arp_offload(struct xgbe_prv_data *pdata)
+{
+	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, ARPEN, 0);
+	XGMAC_IOWRITE(pdata, MAC_ARP_ADDR, 0);
+}
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index 1269b8ce9249..a44973ae21a2 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -1334,6 +1334,10 @@ int xgbe_selftest_get_count(struct xgbe_prv_data *pdata);
 int xgbe_enable_mac_loopback(struct xgbe_prv_data *pdata);
 void xgbe_disable_mac_loopback(struct xgbe_prv_data *pdata);
 
+/* ARP offload */
+void xgbe_enable_arp_offload(struct xgbe_prv_data *pdata, u32 ip_addr);
+void xgbe_disable_arp_offload(struct xgbe_prv_data *pdata);
+
 #ifdef CONFIG_DEBUG_FS
 void xgbe_debugfs_init(struct xgbe_prv_data *);
 void xgbe_debugfs_exit(struct xgbe_prv_data *);
-- 
2.34.1


