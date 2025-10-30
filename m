Return-Path: <netdev+bounces-234309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E33C1F391
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 10:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53EDA1A209EE
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 09:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E1B2F6938;
	Thu, 30 Oct 2025 09:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BYfiCClA"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012036.outbound.protection.outlook.com [40.93.195.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1775F3358A2
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 09:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761815591; cv=fail; b=ju9wp6GjOVp4NtmBoGPLZaoydeij/nt/hokRiGjiQ6KqOtIAIKae1a8VHEa8u6Tj7F1XWf/Prn7gKNj5m19M5emLuUUjBgpg+mbLWeemhboyc8lhSpfUb75HgqiRnNFTW8LYtXXgAjTnGrUtW3T76hJt4jgk34F56oPfWoR26JE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761815591; c=relaxed/simple;
	bh=FjjQoDCdPKhaAftDaTSFJpIkEYDvXcrvmq53RfHDIZs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UbrqKyjTe0dQFTF8SlSesJWYm2wRxU/1rsi+lXDDRyW6JyZOb7EiRWRtjKlOk2FPnVpq9MkUxGuurD1drdTtTxDn2kYGbY2S8Xozttx8/JYGiMvT31ZoxEwOg++617sCvdngZEzN6uz3JY9d0NwsSza+qgOGxeTQEBm5vFvqGTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BYfiCClA; arc=fail smtp.client-ip=40.93.195.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J/SLXCLemX4N2Lv0wSwSsj3b2ifEbCcO3kL7n6v3kDQG80S1nZQI38AMvoxH9ofDBHhUdvg2w+q8YH/sMPca0k3oFBL8CasHTNvwIcNfVIf8NBH0pezS345aRth07Yl6KMSMoZJAbPh02VeHyEZF0ilA7te+w2cDcdpQwTGxWT3CD8WKa8BEBelc4etqpt0uUWAknwv7od0axnT+8L2lgFWISeOkPsDvlQgiJ6gZ8pY4aOPeA6s7Ygt1MOPkrvVnBT0TsY8dPrbbqpL50szOXO81d7chldUsUiaJ41snZ0jx80PgDf60yOI+az9Qh01EijOZ7xla3ki62kjsJ5aeKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96ELShoeWw8oERdD5e/bVLuIeS9KCmLsimewmAT2Jk8=;
 b=tUgewU4ZwyASIh5kGmvq+IiAU611PEGNHTozt57fFxPTy9+3yJjFVyChdO4fc2KNBauJFklvoPWp9zsn6YskKW6dv9MvafWHcxp1v/n3yYHqeIA2vpPd818oTUxpR8cyoxiI00WwJlknr3DLEeZH3mCOkp7Sex9jTP0YBLISOd3NjCS90MCmK8Kp0UtPWOReK6FvdL2hDUGnLkUNOtuLPnNxxUleHjOtlR6W+V+RwEbxd3acGfGCKMP5IaJzTFjT0ziamPRW4FDq7TC922xivwlOOi2/joE0scrptdicQ3gq9yaQB5g6wZbves/sWJwLT1b/ruScxc+rm058iVNfiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96ELShoeWw8oERdD5e/bVLuIeS9KCmLsimewmAT2Jk8=;
 b=BYfiCClAMfJHZZtVbKGoGa6Nc4tSnAHBj9KA/7hmZlwlKTpsaFVHaRqWstZ7N9B8uZM9t9JBmHGgQIm/yUuA0YsAaEid/23GDTaCiB0hq1Q9H3Enefgbt2AQB05GDTdram2wxyYUlR9kNoQH5Y62dpWsVsLgnICMX0p9+HrqvLI=
Received: from BL1PR13CA0437.namprd13.prod.outlook.com (2603:10b6:208:2c3::22)
 by MN2PR12MB4110.namprd12.prod.outlook.com (2603:10b6:208:1dd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 09:13:05 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:2c3:cafe::ce) by BL1PR13CA0437.outlook.office365.com
 (2603:10b6:208:2c3::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.4 via Frontend Transport; Thu,
 30 Oct 2025 09:13:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 09:13:05 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Oct
 2025 02:12:58 -0700
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<maxime.chevallier@bootlin.com>, <horms@kernel.org>,
	<o.rempel@pengutronix.de>, <gerhard@engleder-embedded.com>,
	<Shyam-sundar.S-k@amd.com>, Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH RESEND net-next v5 1/5] net: selftests: export packet creation helpers for driver use
Date: Thu, 30 Oct 2025 14:42:45 +0530
Message-ID: <20251030091245.3496610-1-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|MN2PR12MB4110:EE_
X-MS-Office365-Filtering-Correlation-Id: a8c2fd23-362d-440a-be5f-08de179488d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KMZCCyHpsaloVOhkCWkszlIBStnb6yNRJM3dQ2iTE5mszAH3NWwdaK8tvwq0?=
 =?us-ascii?Q?GvilgE1phjd6cFAuNzckagZSu7aGf5nHcUOoVfhFtSZfaULd69WiB/mZbgO2?=
 =?us-ascii?Q?xeClp/NCZOJwu1H0h+bQ4pzjxZptvj1vhp95sKS0xdfy1/IbJ67WPu74n9FU?=
 =?us-ascii?Q?OENn5pCyXKthjzhyIFDKDkIFx3EROAHwu+PYOyFbBUGe0AH7en0hNZt936LD?=
 =?us-ascii?Q?YseU0Lv2q5LsQ1Z/CPubczumSLx355CJv7y48wPzf5ValNdAitfwtTyeLGYl?=
 =?us-ascii?Q?umGTnAwM3RmsjxhHcQZd9Imp9hiBmcxtzEHV8IYhrRijwPOYNi9MDsZycpJH?=
 =?us-ascii?Q?+KsUO9LI3RH1pohWoQYhs/pXVkv9+2ryPT+nbLHqM9ilI4W3IHkWfCJX9hEc?=
 =?us-ascii?Q?z6fTYti9S4ZIdiIklQmZx858uqi/w9M2honT0t2OxXoYShzvCYAq/7ikOWGp?=
 =?us-ascii?Q?1etjlcc2COBjJoASjogHf1fSY25eqgbCIcoyp8jPv4Og0zkN64b0wQ87/LGR?=
 =?us-ascii?Q?vgF5d7MPFRw3Z3sBjyvNCPuJCWnmvttUdF6Wrro5fZV2+ftLsNmr1x/dAmxj?=
 =?us-ascii?Q?vN3AfGbm4y8TIHdouP4kyYD67fviDkWmfwyK7J7noxGlazlqo6TOqn2G8Reh?=
 =?us-ascii?Q?XEkCICjo9Eu2b/dN7T8AilGw9fgOB4qeV9PTtrhQzVkvHnSIyuJZ4sSYp1C+?=
 =?us-ascii?Q?S8xe+JsgoQVbGAVZuJviRGNGoV8AbGd3vTgjp1y6RzomQxPZKre8GL+7jHU/?=
 =?us-ascii?Q?uSWqgmgYBfuQ4r/ZHSn/vJHM595S79R9mjdqB62yroFHxgRji0p2Jao9NjEH?=
 =?us-ascii?Q?Q3RI3u/SmJ6JWfgp4VNT97BpmToTd63ILgJ79Kg2OP9DXhqiVHw4A26dRBYw?=
 =?us-ascii?Q?KEBxFavePR6V5Au9XIpjMmotI3DycEsYUrmVbxHJU40Zp99Ppuo8w/Ba+GOf?=
 =?us-ascii?Q?epHEnGsefXDTOxuv/wE3AZZv1kV1XlNFmFnP9/jNKRKYdRF3AeXFpAc8GOus?=
 =?us-ascii?Q?tsIxQGmy0mEs3Fd/EhAib8UY9jxAPJH17Kpz3GfmQH9yHdFaYyesjG7e6Yiq?=
 =?us-ascii?Q?hIUogKNHK0ZKCT6rAslFJsQ+zE3uppYjYtjRqsznONdXulSevFL4YA6HX6Gp?=
 =?us-ascii?Q?VBBTSH0UQybryIODYQstdZO72uAkfk7DdZ7lpigrw4ZaM+uOlIHu1pqkcVjQ?=
 =?us-ascii?Q?a+9/1DIca/V8Rx3eZQ8O4l30IacL1Rb/0Qllw2e+J+sKlmyEgWiin2tnvAQl?=
 =?us-ascii?Q?qEl+evEqLwBrJFw69fngKq2Wxp0oqefPkkB2zq55YDPx1kvPIOPX/53Bv2qe?=
 =?us-ascii?Q?KRIkV9AivzB7AZEE5TqddPkfHxtTFJTJ2ohJU7fYEr9JQRUDCcM+Qf/P5ImC?=
 =?us-ascii?Q?wQDLj6z8Gnzn9MmNV3DfNP4IZhyg7HSa8NuAh9vQktaVixlyEBvwfiL+vUXZ?=
 =?us-ascii?Q?+5IxMfpfNdNcKCCBmNRQsFc1/2I54EMK6x1G1PMsPH0fe+tbLoQgfy7Mydnn?=
 =?us-ascii?Q?FHUaQ339ZsSnby/4JwIsGkSBqrXsk6Z1pguJd/Bn0+RmK37FARo/dzfHQ2yQ?=
 =?us-ascii?Q?K8gIniv9PxnaOW5YKNU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 09:13:05.0727
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8c2fd23-362d-440a-be5f-08de179488d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4110

Export the network selftest packet creation infrastructure to allow
network drivers to reuse the existing selftest framework instead of
duplicating packet creation code.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
Changes since v4:
 - add inline keyword to static function in header file

Changes since v3:
 - add this patch to expose existing selftest framework for packet creation

 include/net/selftests.h | 45 ++++++++++++++++++++++++++++++++++++++
 net/core/selftests.c    | 48 ++++++-----------------------------------
 2 files changed, 52 insertions(+), 41 deletions(-)

diff --git a/include/net/selftests.h b/include/net/selftests.h
index e65e8d230d33..c36e07406ad4 100644
--- a/include/net/selftests.h
+++ b/include/net/selftests.h
@@ -3,9 +3,48 @@
 #define _NET_SELFTESTS
 
 #include <linux/ethtool.h>
+#include <linux/netdevice.h>
+
+struct net_packet_attrs {
+	const unsigned char *src;
+	const unsigned char *dst;
+	u32 ip_src;
+	u32 ip_dst;
+	bool tcp;
+	u16 sport;
+	u16 dport;
+	int timeout;
+	int size;
+	int max_size;
+	u8 id;
+	u16 queue_mapping;
+	bool bad_csum;
+};
+
+struct net_test_priv {
+	struct net_packet_attrs *packet;
+	struct packet_type pt;
+	struct completion comp;
+	int double_vlan;
+	int vlan_id;
+	int ok;
+};
+
+struct netsfhdr {
+	__be32 version;
+	__be64 magic;
+	u8 id;
+} __packed;
+
+#define NET_TEST_PKT_SIZE (sizeof(struct ethhdr) + sizeof(struct iphdr) + \
+			   sizeof(struct netsfhdr))
+#define NET_TEST_PKT_MAGIC	0xdeadcafecafedeadULL
+#define NET_LB_TIMEOUT		msecs_to_jiffies(200)
 
 #if IS_ENABLED(CONFIG_NET_SELFTESTS)
 
+struct sk_buff *net_test_get_skb(struct net_device *ndev, u8 id,
+				 struct net_packet_attrs *attr);
 void net_selftest(struct net_device *ndev, struct ethtool_test *etest,
 		  u64 *buf);
 int net_selftest_get_count(void);
@@ -13,6 +52,12 @@ void net_selftest_get_strings(u8 *data);
 
 #else
 
+static inline struct sk_buff *net_test_get_skb(struct net_device *ndev, u8 id,
+					       struct net_packet_attrs *attr)
+{
+	return NULL;
+}
+
 static inline void net_selftest(struct net_device *ndev, struct ethtool_test *etest,
 				u64 *buf)
 {
diff --git a/net/core/selftests.c b/net/core/selftests.c
index 3d79133a91a6..8b81feb82c4a 100644
--- a/net/core/selftests.c
+++ b/net/core/selftests.c
@@ -14,46 +14,10 @@
 #include <net/tcp.h>
 #include <net/udp.h>
 
-struct net_packet_attrs {
-	const unsigned char *src;
-	const unsigned char *dst;
-	u32 ip_src;
-	u32 ip_dst;
-	bool tcp;
-	u16 sport;
-	u16 dport;
-	int timeout;
-	int size;
-	int max_size;
-	u8 id;
-	u16 queue_mapping;
-	bool bad_csum;
-};
-
-struct net_test_priv {
-	struct net_packet_attrs *packet;
-	struct packet_type pt;
-	struct completion comp;
-	int double_vlan;
-	int vlan_id;
-	int ok;
-};
-
-struct netsfhdr {
-	__be32 version;
-	__be64 magic;
-	u8 id;
-} __packed;
-
 static u8 net_test_next_id;
 
-#define NET_TEST_PKT_SIZE (sizeof(struct ethhdr) + sizeof(struct iphdr) + \
-			   sizeof(struct netsfhdr))
-#define NET_TEST_PKT_MAGIC	0xdeadcafecafedeadULL
-#define NET_LB_TIMEOUT		msecs_to_jiffies(200)
-
-static struct sk_buff *net_test_get_skb(struct net_device *ndev,
-					struct net_packet_attrs *attr)
+struct sk_buff *net_test_get_skb(struct net_device *ndev, u8 id,
+				 struct net_packet_attrs *attr)
 {
 	struct sk_buff *skb = NULL;
 	struct udphdr *uhdr = NULL;
@@ -142,8 +106,8 @@ static struct sk_buff *net_test_get_skb(struct net_device *ndev,
 	shdr = skb_put(skb, sizeof(*shdr));
 	shdr->version = 0;
 	shdr->magic = cpu_to_be64(NET_TEST_PKT_MAGIC);
-	attr->id = net_test_next_id;
-	shdr->id = net_test_next_id++;
+	attr->id = id;
+	shdr->id = id;
 
 	if (attr->size) {
 		void *payload = skb_put(skb, attr->size);
@@ -190,6 +154,7 @@ static struct sk_buff *net_test_get_skb(struct net_device *ndev,
 
 	return skb;
 }
+EXPORT_SYMBOL_GPL(net_test_get_skb);
 
 static int net_test_loopback_validate(struct sk_buff *skb,
 				      struct net_device *ndev,
@@ -286,12 +251,13 @@ static int __net_test_loopback(struct net_device *ndev,
 	tpriv->packet = attr;
 	dev_add_pack(&tpriv->pt);
 
-	skb = net_test_get_skb(ndev, attr);
+	skb = net_test_get_skb(ndev, net_test_next_id, attr);
 	if (!skb) {
 		ret = -ENOMEM;
 		goto cleanup;
 	}
 
+	net_test_next_id++;
 	ret = dev_direct_xmit(skb, attr->queue_mapping);
 	if (ret < 0) {
 		goto cleanup;
-- 
2.34.1


