Return-Path: <netdev+bounces-234128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D09C1CDDC
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 20:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 34B514E0615
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 19:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A072C21DD;
	Wed, 29 Oct 2025 19:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Hk4RwRhv"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010004.outbound.protection.outlook.com [52.101.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6D6305E37
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 19:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761764463; cv=fail; b=moTwGgGqySTeAAkNzMILJc+qZvc1lzWMzaVi+Q/FJDY5FG47K3Oq1OI3yj/84/QZ7z0qFWUcdlHejpv1hwi0ENQHixsToRchp+XhOApK0UPIea4hox6W/Jrt/O2tgKGQvFwHoFWmmSvJ/vzkUV6xhyK9KnB6T0QVTrwFWodYNEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761764463; c=relaxed/simple;
	bh=FjjQoDCdPKhaAftDaTSFJpIkEYDvXcrvmq53RfHDIZs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j+TA5kL7oidq/XLfLFmlgSUxecAXEzO0sMAmrbLdY2FrhuEfACdxcfY8HbIVK42WtMhc+WejwxjYM13N7D/aM7MsgmW5TngPVa+CRKvlmEa/fN6RCnXekHmQVlPR4XNLipP7/EZSNxIcuImhWwRZE4+Mu+ppW17ihd4+5cm7h10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Hk4RwRhv; arc=fail smtp.client-ip=52.101.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gGtaqMnBfHy5VwHlEnhca+o+Lmno2fXreqzt/a0glgwM+3f4e8AQNYZxaL3ybfCYlPsvNy+vyk9G2ye8MPfvHiMoOf8e3fLLWmQjLfJr81JVDr7vipgWcpBu55riGhh+4pnzcQgkIZZfgOv6Rc0OGPuxPdCLlurogoY6hBZzq5e46Eoje5iOnWp3++xZoPMo4DlTK/sYgjbnIiMfjNgohJ2d48p/oa+WQFUz/hNclZvHzmEIFuc+N7vxgIr6jgwuypNRUyPJvnHqrnQpMu8iiLZZDErBaN0drpO5ZHuO7zmuIPLOUvHR13sOtpZvgFsO818R+4kTrGKTUMz45AeMzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96ELShoeWw8oERdD5e/bVLuIeS9KCmLsimewmAT2Jk8=;
 b=i1j4RM1ZuPwNCkOzXWsZG89Ld1BfWPZSzJRbkXT+plQPk7XckucH21x5VgGBjBIanHev4cxej7zWHdAGlIX3j0Cd7zkh7qBUndJk0sBJMrXuaWqiq0zeJZNHZSi9rg1NPJPeBFUy8mrtFhQk8oWYHJnM2TZ/XxJHK54BYxfHp9lRJmnlZxX+ZnOO5n0BHedLTAN9gUWatLAccBOk5mYVXZTVpdnTmsTz0dR1sRm4pqeoN1zQ4ivEbfd7koq6L3wmyZZwlJ/q4FS1UH7nUcSENm3/Tv07rvWhmlqQ+glz8bE7FvDWlQRQaHRas2rpLu1m7qKog7V8Li7etOrxmILsFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96ELShoeWw8oERdD5e/bVLuIeS9KCmLsimewmAT2Jk8=;
 b=Hk4RwRhvOEq+jwa14segKWNBI6qx9DmfZw844cyhl9TjrvEeoaaM2yLfNMDnWhlbXOqz80AuAmyliLp5ek47WbcCw32yTal/EjCHvN0Ld2Si8Gg2qSsmHMz8iOzCVi7zhO55SWw023LNHhVnOgrQ8xt4uh0bG0ZjJDl3iZQ5NtQ=
Received: from CH5PR02CA0023.namprd02.prod.outlook.com (2603:10b6:610:1ed::24)
 by MN2PR12MB4423.namprd12.prod.outlook.com (2603:10b6:208:24f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Wed, 29 Oct
 2025 19:00:46 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::95) by CH5PR02CA0023.outlook.office365.com
 (2603:10b6:610:1ed::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Wed,
 29 Oct 2025 19:00:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 19:00:45 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Oct
 2025 12:00:41 -0700
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<maxime.chevallier@bootlin.com>, <horms@kernel.org>,
	<o.rempel@pengutronix.de>, <gerhard@engleder-embedded.com>,
	<Shyam-sundar.S-k@amd.com>, Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH net-next v5 1/5] net: selftests: export packet creation helpers for driver use
Date: Thu, 30 Oct 2025 00:30:23 +0530
Message-ID: <20251029190023.3220775-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|MN2PR12MB4423:EE_
X-MS-Office365-Filtering-Correlation-Id: aee8e7e8-9bd4-433e-1b28-08de171d7754
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KOvfD2KT4BES9mylydlUw+NumTbIE92WE6TPoGx5lh4F0KXHT4mnPLC2oRBg?=
 =?us-ascii?Q?nWE6ZSPFyq6D/FhTqgACTtJLaaV1DO+lnf0/nN1X3eXKi+TAfaUJwmaimq54?=
 =?us-ascii?Q?M3Q8zpJu5Y9VYJmn+DnM3HUk2PYAsY7+ywhEjliimOfVDyhmIkOI+jynZ2d3?=
 =?us-ascii?Q?rST9RSa4e98hqP/CC9vb28KBXpVxxWp2qkKNse9F3SqUIsQs49EofzT5E/qw?=
 =?us-ascii?Q?mGXz6x8/0eJLcgJrjrzkk8fA6+DDVCZmYlF/aO7PJg3F/7dSclC7MW/BayKn?=
 =?us-ascii?Q?cnuHnUxRFVA67DjUqXybVLLFdFZZd9lkkLdqgm+h/bSUUlQQH7GSu2ucSPXT?=
 =?us-ascii?Q?ZV5Wxb/DdlFS5MwUp2GlqNQt25uU4BCguvWfETTNH3rOEPFalRUpHCBGyiNT?=
 =?us-ascii?Q?vvQl54fYG0vjTCp8kSvIEUdKp0IfhaVbOx1/LqUS2V88VHj86Gu0EL78V0Dt?=
 =?us-ascii?Q?iZEY8zBOq/z5hMJ02YEqbtLCCwzHVpVp3vmoH4VumcL379OLMzcSe8L5jl0b?=
 =?us-ascii?Q?0gNyd0hjy0+wPi7Uw0KmP8tOcK/n0eDA9Cxp7gtVwUIQycOp/EqwfpjAb07b?=
 =?us-ascii?Q?OVTv3STpwFEYDHSbJjMiNdCv7oML4amaJZ/hvp6v0Oc7IaI/W2AAAmiqh0JW?=
 =?us-ascii?Q?aS4Aceku+2rw8UWUZ/1D6dBUfseNTl/21udo3LUdj6l8Oc9JC89oVSnI8GY8?=
 =?us-ascii?Q?lmkGOWmAKCSk+QG241BWBLaeF+hWYvgGBw+7ynhPKsNv41ijEwsKv/mua0YG?=
 =?us-ascii?Q?qv+E/0TtCs7akSBer3Gr3j4Fqr2s92thJQUqoBOMh/9WtVqwdXVwluk5iZbK?=
 =?us-ascii?Q?owgqRjzjzSUNAGQH7WEnqDHG+slvPKxlyqBfYLlc7uGqFdrMqwYB1hCiRXbW?=
 =?us-ascii?Q?LDj3Okila4yDT6VgWzCnJD9qgdIQpVPTjRh1R4WUXzuK58TFTmPMVr6xXsEl?=
 =?us-ascii?Q?tvQWRFXMnNpqo3++LLwWwLC+iYH6PvK0XJM/Q80CDClCZ19Zgifg9ZqmxitH?=
 =?us-ascii?Q?VB1XTI+pQvhMC2zt4dxW9C9hrRG898IctZnC9zmI+1p5h13Fehlhg4N0Qphi?=
 =?us-ascii?Q?NU0NKTyvuSaQJIDVNQ0eEtBFaG5Nn9dRutRBaUcgi6NckQNxJe3po3UnL6tg?=
 =?us-ascii?Q?YCwHwka+9fYjcTotXgSwNfIKBDVitxt+Xysqx/tpw+PTvZFcT3OaLj7Zdk1r?=
 =?us-ascii?Q?hLJrPmkEgu9ZgmGPr8RD1fkyGKxhIiJdjI1nGOPxi4VjqY8Ci+aHLcuQkFQc?=
 =?us-ascii?Q?JC0CdTYFiM2flYrdIMRMxOcPP7ocRUwv9i0HEx09HJ0y2AwT9JZYajQmS/wG?=
 =?us-ascii?Q?R9fczLBpCHyAMbMuiEPcOsX5biwFVhFRuYjvKdFOpn7VjcnZibDOhI/zQFNn?=
 =?us-ascii?Q?gknv1PTGjk44ub/u66lrEg89/ZtVi1XL3pZ2LfeD2GhiVyZ2GcPzq8cJQvb+?=
 =?us-ascii?Q?xKEIe+zpMP6wAk1teL9kbXxTvb4yN53MODW3mT2XHJmm4bcyxk4WvU1OcXpk?=
 =?us-ascii?Q?irZRBLM8iFTPzd/yzcDK/YhkOEXIP4mW1uAHySIR0AAUi20HFXQhm1/f9UKQ?=
 =?us-ascii?Q?I0FxbV6a3v6IbMBb9b8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 19:00:45.5887
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aee8e7e8-9bd4-433e-1b28-08de171d7754
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4423

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


