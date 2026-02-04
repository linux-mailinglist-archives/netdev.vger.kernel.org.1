Return-Path: <netdev+bounces-256732-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDyUD55lg2nAmAMAu9opvQ
	(envelope-from <netdev+bounces-256732-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 16:28:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6F6E8A64
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 16:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2F17E30E180C
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 15:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E3242668B;
	Wed,  4 Feb 2026 15:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xLZz438i"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011002.outbound.protection.outlook.com [52.101.52.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547A32D8771;
	Wed,  4 Feb 2026 15:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770217586; cv=fail; b=aweRD6+GthQp5w+JqeMpB6j29rVbGuy5ln5wVr48cab+bug9qcyQM6n2ggjT+y+iJXSBNFCVX0mmuQMtSZSvOuC/KlWNttW0DO2nEwEDLN2mErlYd42NRPfsu3iDwk7v+PQrIE8BnS6nPXTH7xisHB5WFosG8qH2Ejf+U6f7M6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770217586; c=relaxed/simple;
	bh=I/X2qypG5vCaKrjHSVXiPbArAuPXT3TMUX7P1b7KSXg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KE6rL70BZgKxXXTUnA4i+y0B6ubnknlKzJ6svmBxZI3Ab6uoSrlgmwUHqOijEO+v+oo5DZvT+h97cSCeK26ViwBHOFOhbM2M3UlnB5UGFGsjT4Cc5i81tbRhubUQG0CWXuijYAgcBDYerMvgfycw1mp/UqdRHQpKMRMrKWVv/A4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xLZz438i; arc=fail smtp.client-ip=52.101.52.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iT5WmpFaosLVXXjG6XNoLWHERz2iMoDRKEQ85Fi5lv866aZ6I996L5IT+nsGwHLepM879Y17CLTWqt9xwKAtnYYSWPbdaaXEfmRZb80i4lBjNukLOGnDhHWjitI/LQ6sbnZqXtXhkgrfdNAbXNRN4MCX+yKLZ9mfet0VDO3sc63XQ/gG7Y8hF105X2O8+KUQzI910HZKYfpZ9wfELD9jNJQAiYptRS9pYxODG1B8AdkPGQGwDbemLchNQgsTxcEv3nGj3EObyf0nJAP0It8C8aSX2PShI/LUULOWULO856+qc/F8p+iiCHlmmd3h9iU4Kd1XVjZykoQoCXb3gNOFrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vLQc9wJR3uOzYvHylEddo86/VjkdfFmnsuXWmORwx2Y=;
 b=vxN9FlXLM0AuMe0Zr918nCX36wcZqbhlCogdiLObPcxWshOFYXD/PHa3gziN8Iew8Y5BA8oT2Zy8GiGp5vRNHUp4kXzD+HTiv+bHeGc+9mIoch1VZzyVmS8eXimY9S4FNorEHOKD+K2HpFpaM5F0gDQ1IZEH5C9LUplUZS1daE9lxefZfoAblIzsFIH/rPQWv1whkPWBgfMvVZN07MQgBSkgHR3TadWQS9maeyYGVwq8Dleea+M1LlRbmEBuH9ZHkjqmO/RizHf1gtKQ8wPWmvesnKFBUri+JVoDKCb0fwGVjv2DiN6JAz2WofHmJjtw+4KwyLMbgeW7mqSaJ4HlvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLQc9wJR3uOzYvHylEddo86/VjkdfFmnsuXWmORwx2Y=;
 b=xLZz438iBssw6K+N5nb0b9821G2MCwi1jrbgbkOVQJAEUbGDv1usBqqpJVl2qSI+eZHgHZZvnqMxDibtMBBI2h2Y4+axSc/n1KNyq5OQinRL9XXGbbV6KS1S8J58TeI8kYjHWOlsD0wbTT52Kq5JDhAekSa5DJdKdE/9CGpKA3E=
Received: from MW4PR04CA0170.namprd04.prod.outlook.com (2603:10b6:303:85::25)
 by LV9PR12MB9829.namprd12.prod.outlook.com (2603:10b6:408:2eb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 15:06:21 +0000
Received: from CO1PEPF00012E83.namprd03.prod.outlook.com
 (2603:10b6:303:85:cafe::ae) by MW4PR04CA0170.outlook.office365.com
 (2603:10b6:303:85::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.13 via Frontend Transport; Wed,
 4 Feb 2026 15:06:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E83.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 15:06:20 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 4 Feb
 2026 09:06:17 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <horms@kernel.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<linux-kernel@vger.kernel.org>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH net-next v3 4/4] amd-xgbe: add RSS ethtool self-test
Date: Wed, 4 Feb 2026 20:36:01 +0530
Message-ID: <20260204150601.885845-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E83:EE_|LV9PR12MB9829:EE_
X-MS-Office365-Filtering-Correlation-Id: 77f04dbc-36b3-4b6c-747a-08de63fef43b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iLRYPzbUfwBa4E06g/F43Spmi5EJamuSENppDQlwLbcqn+3/75+8ctp61++z?=
 =?us-ascii?Q?lANl7XhNyBb97LRR1x89vrCySDIH7Oi/iP+fNW4wRwI6NiYq0KjJiR0eRahg?=
 =?us-ascii?Q?UrDcVwTVCT2vd9iM3zRzyTNuf85RWNpwxKh3xPS4Xsyb+Opf+uuAb7UujJ59?=
 =?us-ascii?Q?pYVKWeHjZRVmfDJbWdnYd7Fsp/1F133+rfAN2xQt0MI9JzjIUEcogvpUlIpG?=
 =?us-ascii?Q?YECVJID6oRUznp5SrQsv+NpjMrMS6Q2l0Ksj0TIi4n+UMuFLM5kxrvpWu1+v?=
 =?us-ascii?Q?5kiPcF4I9FlfxKFhj6CBzpMKHfDNDTIU9h7o3um7ULgDZTYpyQ1+4sablGsW?=
 =?us-ascii?Q?ncf/BITnxo2VMe9zqSXE0eQaB5HRzWLkx+J9MN3xxh44Tv9TvHbRXwDYNSFo?=
 =?us-ascii?Q?nA27sxMC5WGYR2m2bL1TciyEmZi5JRB3g06SGzIaWq4Fu4gzO9XqQQ7WXr5f?=
 =?us-ascii?Q?athxQpRRkYSTVO7nP5y1dWhFkpUZwXG9ZEhx1G++4WN4YQ/lWrbtWP1XrQbN?=
 =?us-ascii?Q?UEN+ARUasetU4k2c8TMb1Y4UA0FUPu5V4Etn5MDTcGjNdBdb6J+X7gj0MJuu?=
 =?us-ascii?Q?H3pDDwjX9QiTJjHATXCc9uw1oaBKM8JsEB3+9nLzoj6LNgWeyZuJBos6UVY+?=
 =?us-ascii?Q?8RSFN2/EylG5FEv93YfmWRgCIZNJ0UJ87q1BNgcEyssuUbqldlRZvUz+efkq?=
 =?us-ascii?Q?cOH9tlCCWENJJe5nJZAgglEty6EQv2HX0XygLVRcn7dmfnGAdhKDUW4M4duy?=
 =?us-ascii?Q?hnFtwuQdjPYKk5IHzSzkkQGkxeouEuy6/y205I68b24DTw3TdI5oRgztsZTp?=
 =?us-ascii?Q?B+MovtNJaAG0tVwKmbJZdIIUhWv1sg4u1WFPfFabOff1dmHrX3vDlB5ofU14?=
 =?us-ascii?Q?El6Vv1Hi883SdJL+f4YQQTaFRICRDu4QITthX+TKIK/9J4O8ROWmgfg2QpVD?=
 =?us-ascii?Q?ka6YWhDlPZsGnQcNpkYs+NUK41D406eb/aPwiLSFDF49dhQ9ADJRQhX6Hmo9?=
 =?us-ascii?Q?QUMEaKQNnrSoxCt4QpRPpYyxV94tgvRqJmxQAQ7ZzWNIxjnkpki41V6jYQpF?=
 =?us-ascii?Q?ouDvnI1JVr5ZxsiHmb1IXZxaO94L2AiAgHhAOuZ8BT7nlAm55zOEK69bU0ma?=
 =?us-ascii?Q?zWXJOKQ0qpj8KRmubyimfJVJhx1ioHGI/LRqk4s4BgYF04ee0/vjhQHjO/zJ?=
 =?us-ascii?Q?OBKBMvl6cGe2AbArLKZkrWmyc7RX0JvjTWLX07o8UdynJIarBn3oLDWC+KGW?=
 =?us-ascii?Q?2IPf/p6/Xko5moR/tunt2hdwUxaTulsGPwXKM3Rnp5UkhLB7TBvhx1P/AnQr?=
 =?us-ascii?Q?1JtOg9qxWScT4Xbvxezqo/V4SIb2knigkA9n7uV9cUZo41lwSdk/jjkYZLCy?=
 =?us-ascii?Q?JlL2swDz7QVHHh61wzNpy9UYN7f22GYAF+ucVzCJeAo0EPV7K2VDEeUuwhvV?=
 =?us-ascii?Q?rokfMoBP7U1MJXUYKCM41NhJ86YCeO7xd5RpgPWHpKlz5wo06yRXlEqyovUb?=
 =?us-ascii?Q?+VWyOQuQVloZAbqvCdvc1L9A70QSRNF5lmorzhTADCuqj9TEH14YsoTKiS6v?=
 =?us-ascii?Q?9WskL7kHvvC6IBhel8afC1/66DAlQvxQDCNAVmp5O8Wsx6hWWEWX2Ha2CoaJ?=
 =?us-ascii?Q?8UugOTM46Bt+QjSLftvBgUSzqzv20ev/38F2ypcsJAGuatI75nT1gFgMCqPN?=
 =?us-ascii?Q?8IVrMw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(7142099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lUQWbFFstoqFBolioeqwYaFOghMYiYqAdYDXV8hHz3ptv0G7OwFSGkcSkHsNoy1VGfMugcMoyjEcbsnaVfK2JB3JwBATQk6o4bzKmZAewp1RfYyJg/0vCY4qlkAzviYSPSYKAb+YS75KDz5Plh5uTDrTxT30RZRinDm4ZaKnajWG3K7sSVZFrHJ2Pfm1Zp0YwBXygGimjq9x1gxrtZg1bm6U1hvlaKkwV/FD8es7W7ZBL1Ms8JZDg8AXQPWm5ZjSPg8cOPGKoTujiBqG0ves5MQwOxWi+Fayv+TLS9ERJkIKUmEvNlhn/ITu/V/6AhaJB2FiL+Hi3Ov2yc2hxMeS0rwSSjs/YpigyHeRQ9qcYZVFe0oLMDZgchw6BqNtZXlrEnQJQNHG1GAsXUHah52aK+WHalV81SohMwomnwItELBVhJVlrLanirW7a1b2qvc8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 15:06:20.2468
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77f04dbc-36b3-4b6c-747a-08de63fef43b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E83.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9829
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
	TAGGED_FROM(0.00)[bounces-256732-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[attr.sport:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:email,amd.com:dkim,amd.com:mid];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Raju.Rangoju@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: AA6F6E8A64
X-Rspamd-Action: no action

Add a Receive Side Scaling (RSS) self-test to the ethtool diagnostic
suite to verify that the hardware correctly computes hash values for
incoming packets.

The test validates RSS functionality by:
1. Checking for RSS hardware feature support (rss bit in MAC_HWF1R)
2. Sending a test packet with specific TCP/UDP ports to trigger
   hash computation
3. Verifying that the received packet has a non-zero hash value
   computed by the hardware

The test uses the existing loopback infrastructure and requires
PHY loopback mode. It uses specific port values (sport=0xabc,
dport=0xdef) to generate a deterministic hash that exercises
the RSS hash computation logic.

This test helps users verify that RSS is properly configured and
functioning, which is essential for multi-queue performance on
multi-core systems.

Usage:
  $ ethtool -t <interface>

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-selftest.c | 32 +++++++++++++++++++
 include/net/selftests.h                       |  1 +
 2 files changed, 33 insertions(+)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c b/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
index 6cb73ff7cf37..296c45d2bb3c 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-selftest.c
@@ -214,8 +214,13 @@ static int xgbe_test_loopback_validate(struct sk_buff *skb,
 	if (tdata->packet->id != hdr->id)
 		goto out;
 
+	/* Validate RSS hash if expected */
+	if (tdata->packet->exp_hash && !skb->hash)
+		goto out;
+
 	tdata->ok = true;
 	complete(&tdata->comp);
+
 out:
 	kfree_skb(skb);
 	return 0;
@@ -268,6 +273,29 @@ static int __xgbe_test_loopback(struct xgbe_prv_data *pdata,
 	return ret;
 }
 
+static int xgbe_test_rss(struct xgbe_prv_data *pdata)
+{
+	struct net_packet_attrs attr = {};
+	int ret;
+
+	/* Check for RSS hardware support */
+	if (!pdata->hw_feat.rss)
+		return -EOPNOTSUPP;
+
+	attr.dst = pdata->netdev->dev_addr;
+	/*
+	 * Use specific port values to generate a hash.
+	 * The asymmetric port values ensure the hash computation
+	 * produces a non-zero result for test validation.
+	 */
+	attr.sport = 0xabc;
+	attr.dport = 0xdef;
+	attr.exp_hash = true;
+	ret = __xgbe_test_loopback(pdata, &attr);
+
+	return ret;
+}
+
 static int xgbe_test_mac_loopback(struct xgbe_prv_data *pdata)
 {
 	struct net_packet_attrs attr = {};
@@ -371,6 +399,10 @@ static const struct xgbe_test xgbe_selftests[] = {
 		.name = "ARP Offload    ",
 		.lb = XGBE_LOOPBACK_PHY,
 		.fn = xgbe_test_arpoffload,
+	}, {
+		.name = "RSS           ",
+		.lb = XGBE_LOOPBACK_PHY,
+		.fn = xgbe_test_rss,
 	}
 };
 
diff --git a/include/net/selftests.h b/include/net/selftests.h
index c36e07406ad4..18a9b4830dfc 100644
--- a/include/net/selftests.h
+++ b/include/net/selftests.h
@@ -19,6 +19,7 @@ struct net_packet_attrs {
 	u8 id;
 	u16 queue_mapping;
 	bool bad_csum;
+	u32 exp_hash;
 };
 
 struct net_test_priv {
-- 
2.34.1


