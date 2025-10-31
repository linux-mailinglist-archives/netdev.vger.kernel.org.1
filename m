Return-Path: <netdev+bounces-234626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBF5C24C22
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 12:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 133F34659FD
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 11:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50CB338599;
	Fri, 31 Oct 2025 11:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tCTb97bn"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010054.outbound.protection.outlook.com [52.101.61.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EB5263F30
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 11:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761909516; cv=fail; b=s4M1xqgw56cC54Ma+vi43nSVOHJugHbwN9At/h0G0Wy+v5uCBNSp6yPeP4SSJYEnAyiwTHvhDvuPAKhclMYksAnoou5d9RnSVD4ukYonMUWeqpwttGN3gA/eQ0dJbQ6UBAD0gJGHe9F0yPwny07N7QrscC/QqpljH1goQiQYRsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761909516; c=relaxed/simple;
	bh=jqPgcRA/3vQ/JA3GjxH1fWkbmob/Rw2vP7rNroWR5VI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n7w846U/ybtfORku04TfgukGGp/SD7Ymbd96Arr5of5skl6La015DyVUzocZ5T9+8BI7Fh+aXYYEzL61LM0WV6wZ9NYo25ohEgJF++v/yLBOIfL5/x/w1dfKOshadEztaDstQBwNDKvjfiEIiEhj8CplpRTq2uIUNbyWEGZpVDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tCTb97bn; arc=fail smtp.client-ip=52.101.61.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QyHbsktYuqd7YPsWxBqXXE3hLhDTtCltrLshdnK2yV/jbgnVdzBXkGz3os10xuN6ZkN8WiOY3n8KymISNgOXv53Prwubok7JkvciVSEItGaw+DAzp4sQmez7GHtQiA9qajF65BKO3BWKf3cMBe8npOc00wy64K20P5pDZNdKJFffeNN39YYp/gnCpz3qxRoagtbI5Nuk5uvItF//daw5kWtg+Fs163LF6i92dh4j/l7SLMHpMXQG6giEhKvcwHR9hCzEgWzVJUGC1AY6lq1GRVvL0KG4bQNo/YXI3XW3XZA7PIPFRETmUBoXupT6uqOjAvEgXi7sHSstGDpsftxekQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tF5upXLKnfYfRDbn38qzTQzEmqM0AW0x4OOHeWZGano=;
 b=Ykho+QuCln6nV4pCjh3Ao7/V6LLIskbBrD3Mmlh6U01E3Urwb3cmWRTlTtu57bT/pamW1yMxM8vNcEUnKLrYDYh/BvMTAy9bewXDh79qB/LGRVb6cY4Y3+EWC1zkh/02FXEmWrW+pD3/tVTs8plXlgarxyBFZLiXsSz9g+194JVRer7/Su/08lviVU/yVEpk/pU7rky6U+C7sgVU8k4QK9f3XDnTYYZk0r2mbZPRKWZBIc83DqDYsceWZb/xSyW2z6olgnpYn05aCJH4hbwYLBaISu/rbnGF1RqJUR5R7K2Gyw/IoVexS+bxpNXL4Y1cC5xSdcGlV6OcQJdF6Sld5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tF5upXLKnfYfRDbn38qzTQzEmqM0AW0x4OOHeWZGano=;
 b=tCTb97bnSsofNyI1jeywy6Z6FW9xcbOQVBiXiR3BxOlGlvetFkFDPG/0f1wBeR5ph4qCZJwJ/hZWJgFrkGmli0eX+R7b/qU3fLUpha3oO7BPZNcBiORMcp3rg4YOKiUQXzhbaEDTWnZGZgOLm2sgKHQOLPCPvAe6Kjl+rqKvFMQ=
Received: from BN0PR08CA0013.namprd08.prod.outlook.com (2603:10b6:408:142::21)
 by DS7PR12MB5960.namprd12.prod.outlook.com (2603:10b6:8:7f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 11:18:31 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:408:142:cafe::9b) by BN0PR08CA0013.outlook.office365.com
 (2603:10b6:408:142::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 11:18:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 11:18:30 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 31 Oct
 2025 04:18:27 -0700
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<maxime.chevallier@bootlin.com>, <horms@kernel.org>,
	<o.rempel@pengutronix.de>, <gerhard@engleder-embedded.com>,
	<Shyam-sundar.S-k@amd.com>, Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH net-next v6 1/5] net: selftests: export packet creation helpers for driver use
Date: Fri, 31 Oct 2025 16:48:11 +0530
Message-ID: <20251031111811.775434-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|DS7PR12MB5960:EE_
X-MS-Office365-Filtering-Correlation-Id: 9995f860-7098-42a2-0a7b-08de186f38d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?De1yEbk6WCRVWBA+FCA4AkchvROON1zumZQt3CGOWiAbzdBB/UOzHDkmCee7?=
 =?us-ascii?Q?348nQ4+dgql1sv4nm8CFC5HeJfalH98g2hrUCTgKhQbsqpcniEbXbejDCqsO?=
 =?us-ascii?Q?Zzbluvj10EzTz/vBXr307YVd+RI6mF+cTNprDULEYKnsZhZkVFvdouozTrpI?=
 =?us-ascii?Q?h3wioL2kJcsFxTOFoQSZqkfgTdR0SQXtdm86rIeSkg+FyCC7vGOedk5HfalI?=
 =?us-ascii?Q?dIGoifBwLwgua8A017mQf15O8kyz9WnTXSv/Y68HvuvlwVqwXDs9goRFhTuk?=
 =?us-ascii?Q?WRejygleZ+doYJI9FpJz/Rv/vB8bapt2hmM8TQgccUw7sf7+12lW4JkL4M5Z?=
 =?us-ascii?Q?fO+/aRsbLQ8iGYOo45SjxvG9853XTtnBzEU6NgDuedljF8xw59+sNcBfxO2Y?=
 =?us-ascii?Q?GmWGNYmj4FyAQqg3QVa9tFkjTR7n5Xqg+pNM+3LAZLftK+bnH7wJ+XXLIgV9?=
 =?us-ascii?Q?t0QaepTpkIaqeEHGAu5akAAVrrkxXeN8SA+WxSOtQBbcKwp2KUvWdLqCu9DZ?=
 =?us-ascii?Q?YMvpWa6ag3JpsAZ5ntocPrwex6zv80X+g7jXP/4wfttkBFGna68DTiK1bm+O?=
 =?us-ascii?Q?1hKQXsnrpRfACtONJCjoyP35KqappCn99zDi/DqK8lXzHJ1lMvw/ki74WZXh?=
 =?us-ascii?Q?CW/PKXB6BSdPZzg7lk1cz51AeBgy4SxVH80a9KseeMoOAKnoF7GNAl8+4YRi?=
 =?us-ascii?Q?PzwYaz3F9lq0z4ourVT4R38FbbT/lruh8v+FnPiQYYFvz4+8iBrPJ7670/Cd?=
 =?us-ascii?Q?A8c6fERarE21tLKjQygLZYcP07Y/I/ZHBygfeHHVXkXkWSVgbHUhVHmfOOf3?=
 =?us-ascii?Q?FIDv+tFNBWAoYYyMdAog0Y7RGeB5HvEVSy94Jy/NOGbaq22ah0XMdIAV7BcO?=
 =?us-ascii?Q?1veo8GSP5K9mntUgjzxgnRPiwx/rHQ/mg4o58iEw4Z1GRxGxEDzzPO1v7ZK/?=
 =?us-ascii?Q?WTWk2xEc2C8O5TtPCnK7NL7iFI2ZOQ2EkO1UdIooL8eZ+BBwDLmcqEdzafdD?=
 =?us-ascii?Q?EKtVedTm/FOxysdpMqdVRIlJ44+Vj7n3CPbQJ0u12ADez+9QYwYbswSmGk6T?=
 =?us-ascii?Q?RFMEv+IQi3QRUcamer7lhU6ULPAaVcTm6XsrswtCxiETstVqbw8tfZiGS/L+?=
 =?us-ascii?Q?Uv+oqNEhzVgS5OYd9yvzKsRPFymeoTWiNBb3w+OgMcoNRGIYTWN8skR44EMD?=
 =?us-ascii?Q?Piv/LWnDdLEq0IhoQ2ehkIQup/GBGVgzemJ9pnHwZSWko/slA+pX/rpN7q7+?=
 =?us-ascii?Q?KXoCryG0+5Qpei2CQuQ0VYycfyhuyT71rwyvmyJDHgHWHTdDiWhQqCMcbVUg?=
 =?us-ascii?Q?c38fJyOZg6Euvw6LlmsEb1iS7VgXxv6tNPPDPKX1ryuvIICOpJejnfsg/DEX?=
 =?us-ascii?Q?C+qqDS43hgVs/uinDcrb2uWotYxVsfOcXekvSQAkhSERPYTwh4gnEIrdCoR/?=
 =?us-ascii?Q?XjrWr4j5hMuVfR6BZtr+2XJOWsvG45ZoXoFvlkSVxE3yCKDBepWVGVtTiLQd?=
 =?us-ascii?Q?jztPfEHtzMSXvXzGeOKJuTm3xBFeToKDymtwtuDsrnJ447BxqTSAwwRmYllV?=
 =?us-ascii?Q?eWmvIgN+nMsAVfuNFak=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 11:18:30.6430
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9995f860-7098-42a2-0a7b-08de186f38d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5960

Export the network selftest packet creation infrastructure to allow
network drivers to reuse the existing selftest framework instead of
duplicating packet creation code.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
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


