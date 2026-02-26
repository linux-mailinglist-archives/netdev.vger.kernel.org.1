Return-Path: <netdev+bounces-261507-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFYhOGOPoGkokwQAu9opvQ
	(envelope-from <netdev+bounces-261507-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 19:22:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7A51AD81D
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 19:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEBC9346BCE7
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 17:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4DD3290A0;
	Thu, 26 Feb 2026 17:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CXqTN/Wf"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010066.outbound.protection.outlook.com [40.93.198.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1399E3126AD;
	Thu, 26 Feb 2026 17:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772125705; cv=fail; b=lszH3f49xNqYCOViFij6533nn5YHqFps78gKradXNrGA8hAGQnswtYgA+hkAK7dcTwQbr3R1zu7N6yWpfATxaSdJ3pLdV2h2kP6T2gHJ514rv5/9epfclm7OlqZ/JpxvbyDveDZcPlF48NwY1dUx0wpDz4wCiG9JurHk50almUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772125705; c=relaxed/simple;
	bh=WHq9Bj9gXMhjtZedu4+H0HFZyRhNtwvuBFkATkX068U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XetfBEq6a4WCW7OLLE27nP1vGlEOVWorN57EQ8kkc7NuYkp3QgvTfvcyJikgIn7N8gezLgtuektfzrQsbq656yYnnZTOstFhYzvB4cRButxlEBaObrmKD8bLQvXxgXT8/b54UVV6JQpqWTEVQEyjcXPEYQyCuE4D+zUjrsUiPZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CXqTN/Wf; arc=fail smtp.client-ip=40.93.198.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RBNdH1sAfAzPTxQOXkpQr440CXGZOHw//aBY4O5Ji3KG1TksP0xetA+R6wwQh01o1qCJYTqkpl1AIXojsCs8o4qon8aiow65L0D2HBjtDmmzpOxL70y6QPltgp//Y+q5DVV9EKrFWC7nb1niXvWdqrY3rkvJVMIyemxxaypRbSuqRE+Wz1p3DaasL64rsY5h3IcIiRLkDLS7wAA8JeGDnSbja5bzWCfk3EvhTStEu6z+E6t4k23CKlHNi3Gft66hXk9Y149yYTP7iq8Z3esCy4/96G0h5szi1famIhbQa5hQrMnY2jBAdi7wswJJxYY07V8zSEmPNftDrCd8kgmBWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kK+d7Mcd0ODuGRPfjbH0dbIQIOAL4c9kwDTLSwGnM38=;
 b=Pk9XcaoNDvN5n+9uC4Krz11rssWRuPAQZH01Eh4y3/o1dOhAAHwtwNpPyBnKRelm5cbbkByETDaaCnSSS5P1B04IHbkbdbss3UGqc2d5IOzW8YaYl/sf4ew0PYbUMiXeiimW+K/MB6P8CNRENFDygBBiwTu1DG55hSTWx7B0qJRaDrXPKe7rlZ4PFO4+sZM5aJ8015aqYokpARkxUvPJDNeQNCRyY+a69k4Op/04QK7GtVZVz9YzBhdjdIR8CwoPeX06SVFT4wJU+mQnHsFcCI9BLZYa5C+qVyZH3FNXHzVkf5+3A1Y9TSUNHKKrXbpm7d9bi+6CKzxsZmf3oJ3YJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kK+d7Mcd0ODuGRPfjbH0dbIQIOAL4c9kwDTLSwGnM38=;
 b=CXqTN/Wf58M25oL4Unn33twPbceKZjy/0ArBwjct1v8NqBKXr2w0nSKOUCShLnEDIg4I0jAgCd9xute6z2+KO4UD7FdQm2p3UX9uQPBbrW/G87a0BeB6xYboNV1cIQMhHTf/jR1Pwz4sY+ihjEQrDmPjjbB7iz7TveV22JTTvLo=
Received: from SJ0PR05CA0036.namprd05.prod.outlook.com (2603:10b6:a03:33f::11)
 by DS7PR12MB8347.namprd12.prod.outlook.com (2603:10b6:8:e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 17:08:15 +0000
Received: from SJ5PEPF000001F6.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::bf) by SJ0PR05CA0036.outlook.office365.com
 (2603:10b6:a03:33f::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Thu,
 26 Feb 2026 17:08:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F6.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 17:08:15 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 26 Feb
 2026 11:08:12 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<Raju.Rangoju@amd.com>, Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>
Subject: [PATCH net] amd-xgbe: fix MAC_TCR_SS register width for 2.5G and 10M speeds
Date: Thu, 26 Feb 2026 22:37:53 +0530
Message-ID: <20260226170753.250312-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F6:EE_|DS7PR12MB8347:EE_
X-MS-Office365-Filtering-Correlation-Id: 91e793c1-b47c-4940-527a-08de7559a142
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	5qRSlvJVekTyG7wjAtPGo6z5v05Kdr/1VQwI2Fe+dzcVIDzC73Cb+Cm742SGQoWNs754Y6bbjOm9faB4zNvbqLlCdgVx4lx3jN3Pw/WQKeEUagySDvGttuqVdQPTbv90fEKZqlv4+U0bPv69dfFmEBZHKl2IwHTfLHTichm5YBWyZ7yYBd3E+oWuO5ZGOgdiZoy43Qq9Kz7y5v1vA4ZMSfL/AerHjaWIjj2tVhzFyRMRPYtWc7QBkmg7n1uu4ipWRq5y6hKp7wES6fMtWkxas73oWH3ctahNyOt3aM52Y4eoxrbYOEsHY5EuOEYFxa7C5vY4Fut611xGTdcfZqrURJ76SQ3GCBCMAJYTYV/UydWlLpPJ5E4/SFDwERDbR5NlAc00ArSoS5FQmsOV/iUbfTreBoD7c3nWl+NNrvsuwiH2CNyWAolMWNSF0524jXpXDfwRxN+PRO9u7Qab4tqrDQrVzQ6NvWpKzZ/3N17Rm7deGnmuX9hvae5fW/NOuIDP3I5O2o6Fj5HIkPbjllJ1xTBfiomrLg4vuUYLshUaataBBjBIUhQ6FJiOGdZHMactVfUGzMLV3pOBnP0WhNolY6euTiG8kubUQmTzRNCTswv9vB/iIcFMBk1KvBSIAF+iZn+/DNxB1ha9xpr8H/xAizEgwHIzcVgSM4lJeENgq6WhWxp2bxWye1bRGr8oKbsgP6vrAUS29oI6JtqDosX7TKzWpWcwyzHf/tmxUO3pkQVhgd1VD1OiJcDTVYcXBeUVPKfI4CKKjVtjoBw1rjsyylDRH/KuHvKelrk7TELWHbCHinPK6Q9FbQJRe8PB580ZN1Z0N/GxsWaZWm5nWsYjXQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MYj7g4qSpbpddNV7CApMX6EY7RmPNU1fXRC62xWlB9gSOaRTT8F+rcEpkuBzxCAeT4Lfo32KPEaq/QQ9uKeDSh2cRnDWhh5axev3aNLGRGRWZ/uvX0XATa+8+oPlyN3xw/IwG6X4rloQRDIwwbsl8twr6TszzKT40axPE+Q5kVapkIHsyzw5NaQocjyj33ne5B8vWUmGCNJUNE6uNPF9nHkNgpsMb9EKt4/BJ6PwjNm2eiBOEvftzwfR9l29KAOiAhHeKggrxiqN8WqdiV9MFYism1IhR2EjFvR7Q1ejY5RRchWNT5JUpVUZ6M8PpQhBS5DZCBr4iHxsa0BwwxomILalnQh4uJobT83jT3flA4dDyugDU2nncIDEB+gQFrB6bgOkwoXmpPKeYDXjU80xnqFxJmESKrgiFiTxWvI4p582olK8o3yGtyV8qLyYFc5s
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 17:08:15.0423
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91e793c1-b47c-4940-527a-08de7559a142
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8347
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261507-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Raju.Rangoju@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:mid,amd.com:dkim,amd.com:email]
X-Rspamd-Queue-Id: 4A7A51AD81D
X-Rspamd-Action: no action

Extend the MAC_TCR_SS (Speed Select) register field width from 2 bits
to 3 bits to properly support all speed settings.

The MAC_TCR register's SS field encoding requires 3 bits to represent
all supported speeds:
  - 0x00: 10Gbps (XGMII)
  - 0x02: 2.5Gbps (GMII) / 100Mbps
  - 0x03: 1Gbps / 10Mbps
  - 0x06: 2.5Gbps (XGMII) - P100a only

With only 2 bits, values 0x04-0x07 cannot be represented, which breaks
2.5G XGMII mode on newer platforms and causes incorrect speed select
values to be programmed.

Fixes: 07445f3c7ca1 ("amd-xgbe: Add support for 10 Mbps speed")
Co-developed-by: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>
Signed-off-by: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-common.h b/drivers/net/ethernet/amd/xgbe/xgbe-common.h
index 711f295eb777..80c2c27ac9dc 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-common.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-common.h
@@ -431,7 +431,7 @@
 #define MAC_SSIR_SSINC_INDEX		16
 #define MAC_SSIR_SSINC_WIDTH		8
 #define MAC_TCR_SS_INDEX		29
-#define MAC_TCR_SS_WIDTH		2
+#define MAC_TCR_SS_WIDTH		3
 #define MAC_TCR_TE_INDEX		0
 #define MAC_TCR_TE_WIDTH		1
 #define MAC_TCR_VNE_INDEX		24
-- 
2.34.1


