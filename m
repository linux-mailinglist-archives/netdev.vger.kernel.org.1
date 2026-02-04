Return-Path: <netdev+bounces-256730-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CEuA4tkg2nAmAMAu9opvQ
	(envelope-from <netdev+bounces-256730-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 16:23:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B24E8702
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 16:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 55A353175AF3
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 15:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33360421F14;
	Wed,  4 Feb 2026 15:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5gHp87iI"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010047.outbound.protection.outlook.com [52.101.61.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AEF2D879A;
	Wed,  4 Feb 2026 15:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770217491; cv=fail; b=m6UrBvbAYngH0On7Sjg2e66h+ajSv5OO//6/9DjawVyBAQOgwsh1jJsOyD1CX2aATLiLj03KxMJQvzxZdRkmNdgIf1i6XLuqz3EsAXM2vjVc7eBX7HI/2w0evJVIVmqgjSMoaRX+wAV8urh2T28aJeeS4klPJsxh7ws8WzypV5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770217491; c=relaxed/simple;
	bh=4R12ONYHgzUf14GOZ+ib3e/55TdEUp3J1aiZ7EL4soo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QCh/6yIf/mFc6GeNj+uZ9OBboSL/Y5K8djvFhdaGK1oDMY1V/eqUuPKe01Zh/K7bjNG6Rd592ldQfF5tINqkHwgcQflbUiqfhD1theTrAKf6tBLbOK87a7L/l/ZFBEOT9t/6++Cm/M84r/sTvHqSSD7EwImcHJIwdjS85khNCUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5gHp87iI; arc=fail smtp.client-ip=52.101.61.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ht1snRx4nbxf1G67QRCM0gKyY49pVqyc5BloQJ3mz38y7ZBcqBvcSJ+QYBMNmiEkTDAMnnaEST2UHr1E5WmSEvwHsSnECauohhzakIQ9EYNsjT5OUkz5EZzfX2Lp7BpqZVM4gYo02F8hw9LQHyzr6X8fFi+6asjZfchFVjhjGK22TS8t9qHPbi81Cna40b0L45wNsWQMqgbBWlFq+mjHW8FG+wkVPCV8D8hyEk+ztIA4IINcf95AiUVZ21Hh2YUvyGhw7T0XPhE4uJ4VTxMQxN5IUBXUTqD71+RMsc7GkfcysscAAYZJx4Pqnq5ZoA+Bid9IUNnp33VDvKw4Wpr+wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XkwpkP43HJYNMHgUDBgXLNs5qUyGS9Td+1LoLsMFkSo=;
 b=lxjTwFGlcimo0zSk4q1Ej6MgTv1FUSqrVtC1gQlZLIM3aSpOfx8fCUz0XHLaph0WNvGdHZ7yXr4XmPshmIPnqK+4Qszwjj6p81W2et9mm2Kqxr+8hVWDrgjgqNJ2SzCD0aK8DeugGnj8K1CdBJtgPZY7cy8Yv5fQxZWIc9wUaz+Qcbj55hM01xNKEsAsVIV2qIoLJd5sPCS6dlr3yNt47WMW5NPNeyw2QIY4UFSa6LFFdOQXubiVLnqMTiekSGn2H2pvMRyMyHxauI6kvIO7beUS5XgC/regPPCrU3WZnE6TyDtCqcy6WquH6A1YjMrNFS+vh8mXBjBcnuPq5KhW4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XkwpkP43HJYNMHgUDBgXLNs5qUyGS9Td+1LoLsMFkSo=;
 b=5gHp87iIpx9qWnDmWhrnTpqzouBViUeFw4Xfs1i4dPqQzpzC5Ov0WZs/9ex0y1n9TPa5cPipUcpstX5TWeUqZYWiQ2CCajCMNQBDxntjsSHe7v5m/PfgjL8L2occrbG4ulOiXzSf7dePTd4ZcsktSfxDbKb0J+TqqnJ7ag4M/QA=
Received: from MW4PR04CA0167.namprd04.prod.outlook.com (2603:10b6:303:85::22)
 by IA1PR12MB8190.namprd12.prod.outlook.com (2603:10b6:208:3f2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 15:04:46 +0000
Received: from CO1PEPF00012E83.namprd03.prod.outlook.com
 (2603:10b6:303:85:cafe::60) by MW4PR04CA0167.outlook.office365.com
 (2603:10b6:303:85::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.13 via Frontend Transport; Wed,
 4 Feb 2026 15:04:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E83.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 15:04:46 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 4 Feb
 2026 09:04:43 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<linux-kernel@vger.kernel.org>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH net-next v3 3/4] amd-xgbe: add ARP offload ethtool self-test
Date: Wed, 4 Feb 2026 20:34:30 +0530
Message-ID: <20260204150430.885239-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E83:EE_|IA1PR12MB8190:EE_
X-MS-Office365-Filtering-Correlation-Id: 02b53c78-f2be-4a76-6edd-08de63febc14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|18082099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vNUv45LczKZ1PZGqZfJBR6W0eTZl/N/aKLrYPALF9MpUbfyBoHQibjpDLGhl?=
 =?us-ascii?Q?ZTV0LGNO2IJJXUc8umb8qTTtxNpCA7/fyWtMap75R3uL9y5L401bKZcgxc9N?=
 =?us-ascii?Q?tp9bg6bzJAud+45cG7TfxW1CccAb77GbgPcJnsMM7oJVd+CzVPzF56MzRsWG?=
 =?us-ascii?Q?2yRlhW3YZy6DsdDE7b00zQXB9TCYGvsF+dvpenQcHpSJ1YTgQAi5ybvhbzbL?=
 =?us-ascii?Q?vdF2N74m7hr7Ac2fTWbWHYLYNwdXuScOWuaPvE1qeGTTFLBnYbwVLiNOm9/n?=
 =?us-ascii?Q?MGSD5Qiyd5569wOr4aL3iq15lHuA9k/tQRBIbVC+qRYN2Yrx2jsR6qf6aNBS?=
 =?us-ascii?Q?u4whunJ7VvTaenD0Mbpr1lIoRbF9FhKGrP+ARUQqHw2Yme63NnImfZVguLRJ?=
 =?us-ascii?Q?4hZYP9dhfXaVtsNswepIunEpC/+vfydTbPjLK+nch6gCDpsW0Eea4m9B8i3M?=
 =?us-ascii?Q?/OgAUqxl+T5WbXZF7NbtXv9Wz6ijgMaELpc/QSHPqcCMpPfsSKwdi/kEZqVb?=
 =?us-ascii?Q?8bQeKD00Jd9WeJfK/RgRTWgesV6eLB44LiO0F4vo/j3q5nRpDBjnd88KLfjx?=
 =?us-ascii?Q?wm6SHroqseBU5LODjv1pV+e3JFmeq4Jv4LMgq1qBk2345y84DTN5ApmVaWcy?=
 =?us-ascii?Q?N32FXO7TSEg/hBoNVdErS81cdYmC9yv36OrkRdKObeqb86XViDiaNtWnnCPN?=
 =?us-ascii?Q?OUM9LsvaoCH9O7MVz8rZFclNQ1XIdlGtRTXi+8lBi1zUWdY3QMMUvpVHWIVy?=
 =?us-ascii?Q?msK53JFUN4C//Kwm7NLYjRNOp6kMenLm0Uj8XQGj0NEGpqk+5VAo9G5tQT6U?=
 =?us-ascii?Q?ymKSiduSWtEKOCeC1xaQAyL1paOThbwfN5uLV6681Bb8l1OtGvGZVv+DEuEN?=
 =?us-ascii?Q?6HUp1KphqyFiQpFttNOG2wI6r+/tPIyizYqPmGjuo9MRH0TpzVFHvPkhI41v?=
 =?us-ascii?Q?7Yd5DqCzkORkzoxstekR+n80qCGgwdRTb1AGkoTGu1FbvMCyyKZUAm4EwZQl?=
 =?us-ascii?Q?Yq1wozPu0kt3x6+BSexnX/mYcaSZA0eCDr0e/BlP3hA7pYY+MvVYkDQQI34C?=
 =?us-ascii?Q?MfGH4wEW8yDCgFwCSAttPPRJuKt0zQo7z0gBfi+VG55mnEoSrQ6w/VwcW+ft?=
 =?us-ascii?Q?xrt161jQBnncypvrmmpvgN1ooKdrwyNCtM7x54FapBUAdNEEU95wCcB3hY2Y?=
 =?us-ascii?Q?chw3MQf5GygpPhMJw13H0NPnYF2n6fhk5NEjAn0xcJjM6DfGLrJU7OB3vRBn?=
 =?us-ascii?Q?CTVNYn0KgrFEotZzbgaZxuiqMqXhn4YWjfuqBMB/1JLCSWDMUhrtx4/h63JL?=
 =?us-ascii?Q?2sxW/IbMH25zsnuFSlOeLYVze3MSYObWEKeaXP2lyLodWby7jjgORisI3fbJ?=
 =?us-ascii?Q?x2a/ZvVJ3wwMREpLg5WFEM7q2be/OTyT4EdApTQMYXKVhnVaxcipDSj7r4Y2?=
 =?us-ascii?Q?F/ZsKzOjodqJmw7QDMe9CP6mrlIC2XrVkMzsuTjqrML/gK1DLjvdx+VBpzvh?=
 =?us-ascii?Q?8yN4zG13w0VQ7qFjVnghqMymsrYYjCzUffCkIm0NXiCdT/d5iZXwQGLrLcQE?=
 =?us-ascii?Q?BOfPNGXFd6aoFWadLw0tV/cUg2QsshkzyYm+qail+9axS9kJ937H7E8WBDwr?=
 =?us-ascii?Q?P9GuNl0E+LTiHP78TikaCDGxmFV6e+kO4OLxDlAH6DEEpGdX1oeHuz63+58l?=
 =?us-ascii?Q?epVs3g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(18082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TsqnKTxu469SRT2k43A0AwAUeNqNSPW5Hw1muAXQY1sPYd40keSBVN8u30U9ePtQZRjPXHfe2tvtTywa0r/J9IJZilaqndEAQRQnGHzOO+dkBssf0HF8OVTwBPWEkLUoVWRCLsM2ZQLfg/ap2AGIboFOxT45Ri5ZkCKg1isaZphj0WidHS+6Z62d8FLQqFJJZZurZcKzk01n30YTLrIXNk3L6B6ANJ1IdiNKLz0Y0jz4u9ylIHUgKYrxovYo5jTIwr18JDOTr917JkuJefkgXazBCicMgsR0/UZ7Myw16lyBRSiTmeLhVb4jGjtUgWTRuA+cT1t8ZY6UC7garGOeeZR7UdzkKhzWMX+dX768G6DHk8KtAxlkQE+/KJn+257tJfzdqi9nf4Z8ABCtVs9o5ZnmaECBdRG+1fLFOD7T4mnCQsInNFoeLWxm+deLJyOq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 15:04:46.0392
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02b53c78-f2be-4a76-6edd-08de63febc14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E83.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8190
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256730-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Raju.Rangoju@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 97B24E8702
X-Rspamd-Action: no action

Add an ethtool self-test to verify the hardware ARP offload
functionality. The test validates that the MAC correctly responds
to ARP requests without CPU intervention.

Test procedure:
1. Check for aoe (ARP Offload Engine) hardware capability
2. Create an ARP request packet with test IP addresses
3. Enable ARP offload with the target IP address
4. Transmit the ARP request in PHY loopback mode
5. Verify that an ARP reply is received from the hardware
6. Clean up and restore configuration

The test requires the device to be in PHY loopback mode and runs as part
of offline ethtool self-test suite.

Usage:
  $ ethtool -t <interface>

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
Changes since v2:
- Fix warnings about line length
- Use kfree_skb() instead of kfree() for skb cleanup in self-tests

Changes since v1:
- Use link-local IPs (169.254.x.x) for ARP test to avoid
  interfering with real network configuration.
- Improved error handling and resource cleanup.

 drivers/net/ethernet/amd/xgbe/xgbe-selftest.c | 122 +++++++++++++++++-
 1 file changed, 121 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c b/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
index 55e5e467facd..6cb73ff7cf37 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
@@ -29,6 +29,122 @@ struct xgbe_test {
 
 static u8 xgbe_test_id;
 
+/* Link-local test IPs to avoid interfering with real network config */
+#define XGBE_TEST_ARP_SRC_IP   htonl(0xa9fe0101) /* 169.254.1.1 */
+#define XGBE_TEST_ARP_DST_IP   htonl(0xa9fe0102) /* 169.254.1.2 */
+
+static int xgbe_test_arp_validate(struct sk_buff *skb,
+				  struct net_device *ndev,
+				  struct packet_type *pt,
+				  struct net_device *orig_ndev)
+{
+	struct net_test_priv *tdata = pt->af_packet_priv;
+	struct ethhdr *eth_hdr;
+	struct arphdr *ah;
+
+	skb = skb_unshare(skb, GFP_ATOMIC);
+	if (!skb)
+		goto out;
+
+	if (skb_linearize(skb))
+		goto out;
+
+	eth_hdr = (struct ethhdr *)skb_mac_header(skb);
+
+	/* Verify the reply is destined to our test source MAC */
+	if (!ether_addr_equal_unaligned(eth_hdr->h_dest, tdata->packet->src))
+		goto out;
+
+	/* Verify this is an ARP reply */
+	if (eth_hdr->h_proto != htons(ETH_P_ARP))
+		goto out;
+
+	ah = arp_hdr(skb);
+
+	/* Verify the ARP operation is a reply */
+	if (ah->ar_op != htons(ARPOP_REPLY))
+		goto out;
+
+	tdata->ok = true;
+	complete(&tdata->comp);
+out:
+	kfree_skb(skb);
+	return 0;
+}
+
+static int xgbe_test_arpoffload(struct xgbe_prv_data *pdata)
+{
+	unsigned char bcast[ETH_ALEN] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
+	unsigned char src[ETH_ALEN] = { 0x00, 0x01, 0x02, 0x03, 0x04, 0x05 };
+	struct net_packet_attrs attr = {};
+	struct net_test_priv *tdata;
+	bool pt_added = false;
+	struct sk_buff *skb;
+	int ret;
+
+	/* Check if ARP offload is supported */
+	if (!pdata->hw_feat.aoe)
+		return -EOPNOTSUPP;
+
+	tdata = kzalloc(sizeof(*tdata), GFP_KERNEL);
+	if (!tdata)
+		return -ENOMEM;
+
+	tdata->ok = false;
+	init_completion(&tdata->comp);
+
+	attr.src = src;
+	tdata->packet = &attr;
+
+	/* Build ARP request: who-has DST tell SRC */
+	skb = arp_create(ARPOP_REQUEST, ETH_P_ARP, XGBE_TEST_ARP_DST_IP,
+			 pdata->netdev, XGBE_TEST_ARP_SRC_IP, NULL, src, bcast);
+	if (!skb) {
+		ret = -ENOMEM;
+		goto out_free;
+	}
+
+	tdata->pt.type = htons(ETH_P_ARP);
+	tdata->pt.func = xgbe_test_arp_validate;
+	tdata->pt.dev = pdata->netdev;
+	tdata->pt.af_packet_priv = tdata;
+	dev_add_pack(&tdata->pt);
+	pt_added = true;
+
+	/* Enable ARP offload */
+	xgbe_enable_arp_offload(pdata, ntohl(XGBE_TEST_ARP_DST_IP));
+
+	/* Set device to promiscuous to receive the ARP reply */
+	ret = dev_set_promiscuity(pdata->netdev, 1);
+	if (ret) {
+		netdev_err(pdata->netdev, "Failed to set promiscuous mode\n");
+		kfree_skb(skb);
+		goto out_disable;
+	}
+
+	ret = dev_direct_xmit(skb, 0);
+	skb = NULL;
+	if (ret)
+		goto disable_promisc;
+
+	/* Wait for ARP reply */
+	wait_for_completion_timeout(&tdata->comp, NET_LB_TIMEOUT);
+	ret = tdata->ok ? 0 : -ETIMEDOUT;
+	if (ret)
+		netdev_err(pdata->netdev,
+			   "ARP Offload test timed out: ret %d\n", ret);
+
+disable_promisc:
+	dev_set_promiscuity(pdata->netdev, -1);
+out_disable:
+	xgbe_disable_arp_offload(pdata);
+	if (pt_added)
+		dev_remove_pack(&tdata->pt);
+out_free:
+	kfree(tdata);
+	return ret;
+}
+
 static int xgbe_test_loopback_validate(struct sk_buff *skb,
 				       struct net_device *ndev,
 				       struct packet_type *pt,
@@ -251,7 +367,11 @@ static const struct xgbe_test xgbe_selftests[] = {
 		.name = "Jumbo Frame    ",
 		.lb = XGBE_LOOPBACK_PHY,
 		.fn = xgbe_test_jumbo,
-	},
+	}, {
+		.name = "ARP Offload    ",
+		.lb = XGBE_LOOPBACK_PHY,
+		.fn = xgbe_test_arpoffload,
+	}
 };
 
 void xgbe_selftest_run(struct net_device *dev,
-- 
2.34.1


