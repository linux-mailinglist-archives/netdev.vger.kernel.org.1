Return-Path: <netdev+bounces-233456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C4FC13A10
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 09:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4B2B1AA7969
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 08:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4014626F2BF;
	Tue, 28 Oct 2025 08:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yB7fD++T"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010069.outbound.protection.outlook.com [52.101.85.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94921230BF6
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 08:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761641289; cv=fail; b=mJUtR1e6mEGtsZtiTcyP2XW5gyFUC4Gt6CdqJIE1IIvd2DTIZ1pYBngH9yJsORwpqaye9dVX05chLlns9pEIMjMvu9LYOCHuhUeIUK8YZJ/6UYm85C/iRUHsg2SOfVZD3/CggbUggs8mM2GDxnHe2ipw1HEU4V7ihZbVB5z8Oug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761641289; c=relaxed/simple;
	bh=Mwy4jQbYYTtmLQg+VdUYmocDs0XH0hg+tXgLa6P3pps=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mOySo4cnV7p/C42Gw1FO9haT3eCkK8fnH+PkTEy4d6MXONx0mu6XaT7GGEJIkiM6nFWri8Ap50b2rVGIqQlUpa2HPY5lWblEH+kMCx/r6rnIVthlxQnHZR5G3JgQ5bH9J5EfmX9eEhs6qo5Po5fM9dPq2uX4+6QvegJYCSoGAhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yB7fD++T; arc=fail smtp.client-ip=52.101.85.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rv0Fs0oVMK/s7SWXt7l5rSebXgcejpWYAkAYW5vcIm5eQ5fkdmHC3WgYbt0cBnGlVeOa0ixsPlwJ1Vihjcki3HIlnkxCtnz2paxjhDGko13K6MBoOGcvyfvczBoHc04Be+GFXJ52+iah3qoNXMtyVdWq2MJSVm5XwPSeegr4MdzvI0avWy2u82myLKWqTsM5EQAxv9qmn3RG42S6uLRi7riMOMD7M5/XSvzJ8eqiVobi4iIh2mo2Lqtuht7IfpngJDT4TqrzMRhi9OBTHWTmO1wgv4GVWXHYC9N5jEXuJeVrerWG2itm6NhabELjHP1VRR/ZAbCVEwx5QceykMOR7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QvwVcIGE39G7fatSrxPgP94rmygSG7ik9OqEMB7J3wk=;
 b=yfn1z6wc84JYpSI6FhdG51+0/rdHnfnMke9Q5f11OV8zgZh4cSN4R7lmnPVFtDEd5Zi0WPs9eBzZDqvLyGZT9eteph7ZlFZV2onq80l2Re6Zc0q2NMQJwQv6ibH/ecNhG5Tgj4A4Z2xUcGRTeMGn1ezVtU/Xlo4+HEri9rvetefgpJMYHa5yw33xtcBd7ncezMAUIxfFHgdiOPKwUz10HcMeB8rI3CfZpoqZ3eKKrLEnq7LUhLWRAUV2/WakABq7MWaRzMVoEpmc/p4P1aKf4tNfin4BRznkLA1LkCbtptCC+T/+Lf4TIA5kxJPLbIeYsvM+Du7ZyT0mx13NjiWyvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QvwVcIGE39G7fatSrxPgP94rmygSG7ik9OqEMB7J3wk=;
 b=yB7fD++TllwDTiLW6GnX8hRP7pHnwJUdqk4mJFGbAwT7rH4BE3fkKYCHyIWU2/8uHmUhzeB4jvkvpPiXnJQwi7v5EIZmxOFpQyc6jBRqWm2ayKtQ31TU9Qz1a9dn5DYbr+A1SF0fl0Q/he6B/DlPxK/E8xghiwoGvCVqhF09WiA=
Received: from MW4PR04CA0354.namprd04.prod.outlook.com (2603:10b6:303:8a::29)
 by LV9PR12MB9784.namprd12.prod.outlook.com (2603:10b6:408:2ed::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Tue, 28 Oct
 2025 08:47:59 +0000
Received: from SJ5PEPF0000020A.namprd05.prod.outlook.com
 (2603:10b6:303:8a:cafe::48) by MW4PR04CA0354.outlook.office365.com
 (2603:10b6:303:8a::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.18 via Frontend Transport; Tue,
 28 Oct 2025 08:47:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF0000020A.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Tue, 28 Oct 2025 08:47:58 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Oct
 2025 01:47:55 -0700
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<maxime.chevallier@bootlin.com>, <horms@kernel.org>,
	<o.rempel@pengutronix.de>, <gerhard@engleder-embedded.com>,
	<Shyam-sundar.S-k@amd.com>, Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH net-next v4 1/5] net: selftests: export packet creation helpers for driver use
Date: Tue, 28 Oct 2025 14:17:39 +0530
Message-ID: <20251028084739.1046976-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF0000020A:EE_|LV9PR12MB9784:EE_
X-MS-Office365-Filtering-Correlation-Id: 58866467-67e1-49b8-7427-08de15feb23e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DBFaWNJtegUIdvpPim7UwPyGLg6qrT3fDVbU7bskr1k0kQcrKJd1Qn9jzPFF?=
 =?us-ascii?Q?YPOpVE6E0ip36SLLWa1/FKTk/x4PpjTcKIm5j5cMfgnu2VObTFwtfM0OqSwO?=
 =?us-ascii?Q?DSCRZpmbFk+6XC2Nax+z764BqIS+hNMw8eW0XXv8GFNKsGAeRx/c7oCWcw7b?=
 =?us-ascii?Q?dp3U/63WxmOLb9FDb0oZ+WbytymQXen5EZMmEcFSO4r+6XnPImrv+sgAFii4?=
 =?us-ascii?Q?8UCvIu4CYilUUXn32c2KFJPid4Ax2E8Mnsq3MAQwiYiIK4+21kUEXqjVNgsG?=
 =?us-ascii?Q?MSmy+VRDaV0DtFRIWCaN0ftXYoVN3iTUc21MpteBg2hVy/8EyuNUrSj9xvdm?=
 =?us-ascii?Q?Iqs7tKAlmeI+CLLZzepFBw1h2uY+TzSrsz0s5xzpCpM7Ek49x0hOPRMvLwZo?=
 =?us-ascii?Q?M1S1EDnCb3AUn3aHaNUZYkoNHgKR2jIhxP66R8JXG02fqftPMY3bj2231obl?=
 =?us-ascii?Q?VEeM7YVRbZuh5KtSvUYCc3hV57px/o1LSo9lawn/EUERfqda1lHHVooK8pZp?=
 =?us-ascii?Q?KCx8YXSzS2XEaycc2Mk7I0AJk6d9cquTUM2A1KL5kLOp3kBHNx7az7CjoPnF?=
 =?us-ascii?Q?ubKaRIc+Tru+1DplMWWI75MtTUoSzeW/0NqTN0iS8Z3HWKB40pKuQ6NkgqNq?=
 =?us-ascii?Q?YVkXfp8wmbm4KhTcpo0U2AssbmKTw0Ujfhcp3e8RCzNuLipt+tUHPYC6G7L0?=
 =?us-ascii?Q?rH7c0E4Jgsyb394q5blTD5nkz/HS5CYTPw/XqmyQqj7J3bzaRlZj9oYShqzc?=
 =?us-ascii?Q?gkSHYi6iDhtv4Fjt+tNntEyIZ3QgIY21dT3FcmZ83JnaGGCqij5pCDI+FjeQ?=
 =?us-ascii?Q?CZJKLMAqOraOywnopxZSNh8P68wK3yCXWG+b8lha7foMLsl8LzFE/V6H21ct?=
 =?us-ascii?Q?Fyr7kgbUWuJ2cJ3vmmDKgJzIhYCFIVbaM6ba3zCt6SNZeCdMnJhpOFIOwINt?=
 =?us-ascii?Q?BiwUSVOECAqWNSEtO3cL2KGXBjQuYmvi2kKgyGoYcgs5oclBwSdRlDam17lz?=
 =?us-ascii?Q?sgu88fIp+7nxPcvvpYs8XDysqknth/5tnwCJh4Jp90M6AHuI96taDys0pDat?=
 =?us-ascii?Q?hA4KrOcBB+BzvhV0W8e4RQvCbnCeesP+uWn+KyFaETFvQapLUb/pUk7FOOVz?=
 =?us-ascii?Q?LYARPGY9Sgx/5edsgNKKlWbl89gOb13MuLDmFrttjl1tTvc7N9KRt+qjXjjQ?=
 =?us-ascii?Q?EB2nXPd516D/q7nMDl/igR1lh5K6kvCnILReSfmfr6CDOHP9vOnmn2iPeryO?=
 =?us-ascii?Q?SspUPPmstA7ZiFqIeH9Mp0YJL44Xvwvt/AlwkclpToEwuG+4GA46KvsnYXtz?=
 =?us-ascii?Q?LNuDTjaX02WFGjMG6nxsOpu7Gawj7uJeIapGPvEkIslEPHkwXKfi6YPWk/7c?=
 =?us-ascii?Q?eBNwQnPvCKibBt4NHMoBDyowzXSc1liHjNjj+smdullHCKv3x1TRYKXv/u+w?=
 =?us-ascii?Q?jwE6gDDqBICJ2OfmST0HsYOzAkxKlaivk7lue8KageVhdEDhumDAoi4hKnB8?=
 =?us-ascii?Q?dbp3eZJevysnewp3NgLMBe3cf2pfejjr5+s8MVI9i79TLnnC2CvRvHek0eWW?=
 =?us-ascii?Q?3bvRjKa9gr7OLHWcM+s=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 08:47:58.8173
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58866467-67e1-49b8-7427-08de15feb23e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF0000020A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9784

Export the network selftest packet creation infrastructure to allow
network drivers to reuse the existing selftest framework instead of
duplicating packet creation code.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
Changes since v3:
 - add this patch to expose existing selftest framework for packet creation

 include/net/selftests.h | 44 +++++++++++++++++++++++++++++++++++++
 net/core/selftests.c    | 48 ++++++-----------------------------------
 2 files changed, 51 insertions(+), 41 deletions(-)

diff --git a/include/net/selftests.h b/include/net/selftests.h
index e65e8d230d33..884745c4e285 100644
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
@@ -13,6 +52,11 @@ void net_selftest_get_strings(u8 *data);
 
 #else
 
+static struct sk_buff *net_test_get_skb(struct net_device *ndev, u8 id,
+					struct net_packet_attrs *attr)
+{
+	return NULL;
+}
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


