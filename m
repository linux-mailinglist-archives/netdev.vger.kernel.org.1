Return-Path: <netdev+bounces-262486-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIbdHGQWpWmL2QUAu9opvQ
	(envelope-from <netdev+bounces-262486-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 05:47:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D508B1D2FED
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 05:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EF8E3011584
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 04:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BE6277035;
	Mon,  2 Mar 2026 04:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="p0k3hT++"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013063.outbound.protection.outlook.com [40.107.201.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A3F1339B1;
	Mon,  2 Mar 2026 04:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772426840; cv=fail; b=cfB7mITKmOQh3dD6AoQRiZiMcbtmkfApLXzMUvIEyU86JY10IFR8jdT14FzmDxJnUJQ6Fd2sqgpE6EyztKigKAtP5pPkFsp3FLiQpDJEuWZY3RYaDDo2JFveE8M2xNHb9q+LnT/CNIueN2Nm0xdQKWPEDc+Rh4lyLs8EDg+beg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772426840; c=relaxed/simple;
	bh=azlDjEWNHBOpl35Nrk9B7Ru4x332CiGqOqSNfIFwT50=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=toKkXgjvmnhwTQJc4uiwkr2QQbYpd7W1wUytMsrd01LgSnmlMjIgFQPhi7sICw0xRy/KTutfkLg7BpRGGWKLo/b6WQiC7C98E8rjvfE7tYxn4vyBqYlZfgY3ZLcB0ATD/iXAruQGhcuZfHTJfegYg250gNoOqjVQBwrKPyFeyG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=p0k3hT++; arc=fail smtp.client-ip=40.107.201.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OUQoQIicVW+mlIvOhQEAFtTGqL0tPkhNJFrqzPSdAIgaqBl/uc1N2jgPlh4k0QbA7Dd2y3Zdpi2N+seUqVF2GSSfMctX+Xm3bkjcyUnCTasp8f7nzHMTx7eH1pX/TlJdSLD1v1TAYRbgAb69rIeaavIKeSxAAnx7qsIQgR6x7PasyxKgz5R/6xGCuxW4iy+QCw4Gw3fa8o+OS2gvBcKf35712+WES5pKbS5mc1EF4atfU+I7w6TtTqHPpO1hV0Psuq4TfqcTOr3x2eAhwZs1IxLC/qgJ+utGZprcgB48mEChPpQARTC1u+steIDx9unh4LxgIfgn81cpnydnQW5Z3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rj82vWHvJbJHaHuLq0XNea57RJp9Mh+lXz/zg70NeXk=;
 b=u/DixH5dpcItvUA8ZCjLk7TwHEv3k5R6PYOW3nMCzfGHFxCLRtz9z2Oa8FOpw2x8TG8sL2qtuDSNOcccgc/qR6AMD6kILu9/0dak20qBQ/bJ0cW9DlPPdKvBIYjP6aM/iTXUb+fIn/z4dr0LsBFjCofSkoBcxSsA4VbtBd3vDQBeAl7LvzCRNijeJNAg0fedY57DKc5zHhBcF09tRorfcK46O++F0WpMOPp/xpICyUiRy+l+2HrZA7QKMAU2tBq1WWlw+GoYS+UoFcPXOiVmbhJ8DZKmlZHvJB345MNSibBSoTBFY0w7vHQdGzYUXaTT/wKqHOBMBWeDlCPOlztc9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rj82vWHvJbJHaHuLq0XNea57RJp9Mh+lXz/zg70NeXk=;
 b=p0k3hT++wR9uh7JEcGhFMDZyHmjr/ZfN2c4xSqH1iNyj6Un+3DWIa6gkOtiQEsA8+z6BbU4uoyyqs9JTuhBl6abBB+gbhI+sOAMMwvG//+uTS3lFYVH/XlDykgeOPo1Sw9VbcBzPuMTgqtoVx3c9ErxzeC2ew22j9s/AVPHau5U=
Received: from BL1PR13CA0134.namprd13.prod.outlook.com (2603:10b6:208:2bb::19)
 by DS0PR12MB8443.namprd12.prod.outlook.com (2603:10b6:8:126::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Mon, 2 Mar
 2026 04:47:15 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:2bb:cafe::37) by BL1PR13CA0134.outlook.office365.com
 (2603:10b6:208:2bb::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.20 via Frontend Transport; Mon,
 2 Mar 2026 04:47:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Mon, 2 Mar 2026 04:47:15 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 1 Mar
 2026 22:47:12 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>, "Raju
 Rangoju" <Raju.Rangoju@amd.com>
Subject: [PATCH net-next 1/2] amd-xgbe: define macros for MAC versions and speed select values
Date: Mon, 2 Mar 2026 10:16:33 +0530
Message-ID: <20260302044634.1388661-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|DS0PR12MB8443:EE_
X-MS-Office365-Filtering-Correlation-Id: 0259b3ad-7bad-463f-7f82-08de7816c6dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	IqLFTFQPA2wFwIYeYcXMMDC3etieOHpzUmfrCLS1J34HXIBHNAhcnsDBsLTBsqkbYc1pBlKBD0REaAeg6IJLU2CBROMTWHE0FOSkULxwlBFSri4qxba3/jOvZNQGY17RyPJoFFd7nlEhLcAQq8aG3EMUYKo23MpFJ+Jr+ySAZut/qUhovcxp+UPSaGheq3GJ6bdTtpjgk46EdAf9qSaDA3/y/ybKmJMY9swSMp6zDC83DOqFkO3RAV4/9UgD7RbCZg0FB3VknO8W+P7Ssb4JzECD00CwyVSEPrKs+tvcF3TdHzTUkOlIdTdW8L4ZeJrxDlRB77a3Mv4nYzj9lkvHrMOZ/xFL90AONg3Ou3zs5m1yogJKddakpRZJTJjkzBxCNursSeBv92z5unvYNDuMM9EcCm+bcwOyPnTRg/xmUT3MIrgo68zrxTY8582OdQLHI4bZxrs6NgSPUVeprV+hX81xVG1yssNmQFUCgy3aR4gO9Jkk9D4Dr/VZwD3thNec217K8iiPKtX3Sp3o4mMOm/5LgGZsoMHLMZxaO5ooFDFqueIVLdzbcCZeav1QS1nNVQXNbw2keyZl4R0tAom6fNDeg0g4gm/h+cy0bYgqSsiJuINtKtkd3g92zeFL3/NUY2VfMzaOvVYan7m14qYrV7pCXeeEfS1PdoNWw2DzsXyv4oiOs0fDUR5yLo9vQ+RETqLxVARGFPfpiu3rQ3JW+JL0OiNTcmaBV3bqb6D5/I3ixw/ZJsjC0ju4JKG+VYn2EOAUEFm6EgkHWVK7UzYaK2YQyN+8N8uolb6KxULmH3OL3IZ4X1mOmGl+K2PbSBbjnoIpn1TsuzWdUr+sYToyZQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WzIY56ON66dk+jn8KrLnNNTCMG24O/EziLR/yf3nfj2mC0wFsqm5bgU3W2UlSVc1nkqOTOo9RQS5PVKx9oO83PuPpzKxAX3HMKz6YuS8USoaBEuZEyAJ9gpbanDhMLujCGxQzgQRtxBdS7zezd3WP9IxOSKD4yc+uxcWxgFv8N68qb+/QNY9Gydj7fh+ym4DijkzNb9GnQd/as3RQvrcYlz0/a6+HrfjHBF2Ol+JzaWc0QbV0TuONmNWhxmrTfQwteLgPXbSf42fWrZ+3EdfMUdEECPmRV30VrJA5QPnYzGb/kF7pepNkkY9FSLXi6CjIt2H4XY4VqzKgOtZVqdzpqByy384EcWYyn4y35fdlRXaV7WfkQZxa4owOfwo0V1E4vkGHUz/eaYAC+uLj19UhyQp5EQMfgBGOFR+1YZTS9p7Wbb4em6cOxdtSNY2Cwzu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 04:47:15.3771
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0259b3ad-7bad-463f-7f82-08de7816c6dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8443
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262486-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Raju.Rangoju@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D508B1D2FED
X-Rspamd-Action: no action

Define symbolic constants for MAC hardware version numbers and speed
select register values to improve code readability and maintainability.

This replaces magic numbers like 0x30, 0x33, 0x07, 0x06, etc. with
descriptive macro names that indicate their purpose:

MAC versions:
- XGBE_MAC_VER_30: Baseline version supporting Rx adaptation
- XGBE_MAC_VER_33: P100a platform version

Speed select values for MAC_TCR_SS register:
- XGBE_MAC_SS_10G: 10Gbps XGMII mode
- XGBE_MAC_SS_2_5G_GMII: 2.5Gbps GMII mode (older platforms)
- XGBE_MAC_SS_2_5G_XGMII: 2.5Gbps XGMII mode (P100a)
- XGBE_MAC_SS_1G: 1Gbps mode
- XGBE_MAC_SS_100M: 100Mbps mode
- XGBE_MAC_SS_10M: 10Mbps mode

No functional changes.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c |  8 ++++----
 drivers/net/ethernet/amd/xgbe/xgbe.h     | 19 +++++++++++++++++++
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
index c04a9c76bd40..1a91ec455bee 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
@@ -722,16 +722,16 @@ static int xgbe_set_speed(struct xgbe_prv_data *pdata, int speed)
 
 	switch (speed) {
 	case SPEED_10:
-		ss = 0x07;
+		ss = XGBE_MAC_SS_10M;
 		break;
 	case SPEED_1000:
-		ss = 0x03;
+		ss = XGBE_MAC_SS_1G;
 		break;
 	case SPEED_2500:
-		ss = 0x02;
+		ss = XGBE_MAC_SS_2_5G_GMII;
 		break;
 	case SPEED_10000:
-		ss = 0x00;
+		ss = XGBE_MAC_SS_10G;
 		break;
 	default:
 		return -EINVAL;
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index 1269b8ce9249..32cab96e013c 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -267,6 +267,25 @@
 #define XGBE_GEN_HI_MASK	GENMASK(31, 16)
 #define XGBE_GEN_LO_MASK	GENMASK(15, 0)
 
+/* MAC hardware version numbers (SNPSVER field in MAC_VR register) */
+#define XGBE_MAC_VER_30		0x30	/* Baseline Rx adaptation support */
+#define XGBE_MAC_VER_33		0x33	/* P100a platform */
+
+/* MAC Speed Select (SS) values for MAC_TCR register
+ * These values are written to the SS field to configure link speed.
+ * Note: P100a uses XGMII mode (0x06) for 2.5G instead of GMII (0x02)
+ */
+/* Note: 100M and 2.5G GMII share the same value (0x02) but are
+ * differentiated by the mode/interface type at the PHY level
+ */
+
+#define XGBE_MAC_SS_10G		0x00	/* 10Gbps - XGMII mode */
+#define XGBE_MAC_SS_2_5G_GMII	0x02	/* 2.5Gbps - GMII mode (YC) */
+#define XGBE_MAC_SS_2_5G_XGMII	0x06	/* 2.5Gbps - XGMII mode (P100a) */
+#define XGBE_MAC_SS_1G		0x03	/* 1Gbps */
+#define XGBE_MAC_SS_100M	0x02	/* 100Mbps */
+#define XGBE_MAC_SS_10M		0x07	/* 10Mbps */
+
 struct xgbe_prv_data;
 
 struct xgbe_packet_data {
-- 
2.34.1


