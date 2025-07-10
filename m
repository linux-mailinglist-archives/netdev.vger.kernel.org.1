Return-Path: <netdev+bounces-205878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98261B00A02
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 19:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FDBC1AA6C0F
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 17:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA31280325;
	Thu, 10 Jul 2025 17:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="L024UipV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9718A280022
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 17:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752168797; cv=fail; b=DMs4MFJxTfzmLMUDeKIiHn7nY1Z8udS39KotILXSIR03HVS2EWXOR6ONdS0vaZwU7+F9PCndi+SDZq5NQdZGWQ/Fponf7S341ACyvoMCN8+iQPpWh/9M+cvdgRSbR/M0rHDO3eOs1RLuLEQbdL79HAZ15O0YHpjRf3/rStHhgzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752168797; c=relaxed/simple;
	bh=NRsnECf7dmQ0G5WKgnuTmpdtdtvF2rIemxmZcBo4Omo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Oe3kw08rxd6vjkvd9+YQqCMD2aWkcGGx6EVUPdt1u5S6xbYMVD/FODk9y5BWiZTb3AtQ/BYaOtU45mN1WXCM//DCg3Codu7bTfNLI0GUdhuq8T0f5YhhZ6ldrA9p49XYLea5a7AllQ3rnzVKdajzQeYt93dHLmfQbiL+6K53vdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=L024UipV; arc=fail smtp.client-ip=40.107.220.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tLGIUff0+FoACJFJHgkhgzDheT170hmF8eZty8OdE3UvCT81Ppl7dLCOB2LuakTTAKWyOf1RQvCcLL+mZpPL+ei+GZWubTG0HnqiwaURRKEDDqlltLaU41HkXSJ2EYzjL7ORzhk7omfolYNJizxleTqBJKITARp4CtSEAmXRIYzx+lhyzRMx0kimuk32E/VPJ8Z4hmv//uSCUpxfbsazukD23+Yq/tRnb0sKAsQnI1qYsnY75qyfiX7Ga6Z8ZX4gJbxMh7R6CQAAsFgAQnJzMlFLyieecop/D0OAd30OQ8Z6jeXMnpvF0eJxYRG+SQv3/YS0M8nYMo1O9P/5ZgR9ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c3CSBEgzZ9K6mboBeJqp0tSgoOLOtavqrL1BgX5YT0o=;
 b=xJLaSF9Lc+yTXkIPT5i5PhYpGBqxgk/9VFi5kSwVuj9tsiGy4s3UU2RyQsRKCJfUdh0TwRy21xCmFx/vh9zAWM2KeMx+idzvkY/APFVcyu3rqepqSzuUUgwL3CxEvZggwQ6ctLpwBksGn/KSMoQoATueiJC48X2McHaBmfNqsaO45gBzBzF+YI4fiZnJAhTrhPbcutHCznpYjUPNHGb9qR7Qb+UApbcPXA0/SmnViarEl2prhBPYsvIOz0qtfiPd+mvFwWWlrECBPPh2bJPkmfstGxDlMQdtof2TXWfXYL13WQhF+Vpnwunp7iAH/v5e1u7l6pG/a+I/IoeBZvh2Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3CSBEgzZ9K6mboBeJqp0tSgoOLOtavqrL1BgX5YT0o=;
 b=L024UipVPevAkJ/uUXi3pSAgt2wj7fLfRclSHGkrE9Ghf9+H5Zvbp6hajRGVC3a7dfBU7+QtPzmpT1BuOD49QbmWx4oNpPyZcNIS73ncPu7vu73tsDn0EntE8aXuQR3/Qg3Bbm5vLGepsODWKuH/Gizf9rlTcVj4uDjz+tRplKk=
Received: from SJ0PR13CA0147.namprd13.prod.outlook.com (2603:10b6:a03:2c6::32)
 by DS0PR12MB6461.namprd12.prod.outlook.com (2603:10b6:8:c7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Thu, 10 Jul
 2025 17:33:13 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::30) by SJ0PR13CA0147.outlook.office365.com
 (2603:10b6:a03:2c6::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.5 via Frontend Transport; Thu,
 10 Jul 2025 17:33:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 17:33:12 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Jul
 2025 12:33:11 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 10 Jul 2025 12:33:10 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH net-next] sfc: falcon: refactor and document ef4_ethtool_get_rxfh_fields
Date: Thu, 10 Jul 2025 18:32:13 +0100
Message-ID: <20250710173213.1638397-1-edward.cree@amd.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: edward.cree@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|DS0PR12MB6461:EE_
X-MS-Office365-Filtering-Correlation-Id: 536fba1c-86ae-4a10-c83c-08ddbfd7d890
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ko1a+kQQ0ejQElL67/XjQ2C7aRrSQRra+zIJFa5OgsuQtDFH0rQs4GZyuywe?=
 =?us-ascii?Q?Nqo4ER3wiii1uGIw6ZNXOC8KxwEJTd5AZMB5nlpnDxHK6pdtUqV5mM08QKiT?=
 =?us-ascii?Q?PkXK2xQBv/sChweNrFr1hMEdV3ePO7sArQ69LEegEBLJd5u2wsBSwjfw9hbf?=
 =?us-ascii?Q?loWOkJ37EIBh6LpEDdKwhWTWYiobRSUc8DOYt+T1eaqT+hNf0mS08AP5EVPp?=
 =?us-ascii?Q?tuQYygyECOczmWx5nq/PvzZw/h3Kdn9cGiC8CSAyyH1tImEBSwI5AdolL3qa?=
 =?us-ascii?Q?1sMgPVw62rRBwar5O/Mj4Q4B9gEUYAVOwBb8t+n6fB5BfUpPhfxDq50u9D2q?=
 =?us-ascii?Q?xnQDixnGIyGik+diU17nKZ0gOjIK7F2/5TZtAjkTGLeP7Rt2OPsyxmEmgylV?=
 =?us-ascii?Q?wl4eWOeFwqkuMNQolH73AQuqi258RJ4yvNXNjZns+t6yB1VNpd1U6ps5Oedw?=
 =?us-ascii?Q?UD/tw/lYNNawbZgX6lDxvwVdQTm6VQdfjCf+GwRAN47ywCcXqBroAG88Ry2t?=
 =?us-ascii?Q?oLqqxGw4kfvAwSpq70Bo84GQFd2ARCQ2g0UcMUvE3pQzW099bRXpw07lfg5a?=
 =?us-ascii?Q?7mFz+//ELstQyTLWx9HZocToiY/1H1Q/Q4VSGdFN0Xv0C0hfkkMWHdx2urfj?=
 =?us-ascii?Q?RmBUojb6CaLKSKxVFUVXxg/7xBmRPiwTqpLnJRlkM/tZUl5bTA4tWnuYF6F7?=
 =?us-ascii?Q?5/7Wj6A/HVcSyrCsT59AxlwEMfIMD3wyMfVqsyWn4qC0BAtrYy+O0rZimXFy?=
 =?us-ascii?Q?cJn3k7PkCBcurMLOiRwPS2evRsx3ZoBVJhfbYdRRXBRFkkf5vksfqcAOQP9D?=
 =?us-ascii?Q?Mw8fTRM18lnBSc1qGi0iu6MEbwU3Gdh2hFJcY1kiFs7R1PNerSk5IdcpyM0l?=
 =?us-ascii?Q?4gICkvZwygoVm+mai2Y8+D2INv2smQZCr/IRRRwQ2Y2FuSqtEAfQOnnXvZJd?=
 =?us-ascii?Q?y3i2VwXc5rPng7qom2gQ9ZbHDDlZdnRLoLCHZbRJZzYfVj7R6OTtpJkAta4a?=
 =?us-ascii?Q?20xmF115NM8FvIXYZoFwxR+ACn16ldrhGwg5nhXA4R+NOp0picivnzdNYtBi?=
 =?us-ascii?Q?VSmgTQoc+UxgJaUTuHGUeXEr3XIm5zoouNN+BEfWHjunPvxsGpjB99Xv8cbu?=
 =?us-ascii?Q?E0fq0Yxe92FCXdcjR5GvQ199YpJVn/x3cQbggIstojP+otb3fcS19hIFs8kw?=
 =?us-ascii?Q?2Ia7j46fOFPypN8RSMYQoumDfY3evnsZEr8CW6qBLY9rskCuvaVvYq5KzqvI?=
 =?us-ascii?Q?rT/oPFRnV451SqV9hJ/Z84JNG1AsfRKDwUnqnXEWocdCgQhk9Btbf3VFq+SQ?=
 =?us-ascii?Q?IzswhAbKf6WLmEe8nwWl83ZQBtHN9VGNp85jdm5ZmE7jPirxX3xniLNzUeVP?=
 =?us-ascii?Q?gxon9r/Oqb1MPOIEeCI4vnRXZtEafSQOFLudEamU35vQxJAlpC99iFUQeTSw?=
 =?us-ascii?Q?xN5vhaqWlWpSuykLtDZoX+/Jz1buOtz1hV/SuoaLk6dFFoX8AC2hNuEknX5b?=
 =?us-ascii?Q?v2MbJQwRTfc/RfZ9YDX1rqTo5muhQC1N3C7p?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 17:33:12.7425
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 536fba1c-86ae-4a10-c83c-08ddbfd7d890
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6461

From: Edward Cree <ecree.xilinx@gmail.com>

The code had some rather odd control flow inherited from when it was
 shared with siena and ef10 before this driver was split out.
Simplify that for easier reading.
Also add a comment explaining why we return the values we do, since
 some Falcon documents and datasheets confusingly mention the part
 supporting 4-tuple UDP hashing.
(I couldn't find any record of exactly what was "broken" about the
 original Falcon A hash, I'm just trusting that falcon_init_rx_cfg()
 had a good reason for not using it.)

Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/falcon/ethtool.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/sfc/falcon/ethtool.c b/drivers/net/ethernet/sfc/falcon/ethtool.c
index 6685e71ab13f..27d1cd6f24ca 100644
--- a/drivers/net/ethernet/sfc/falcon/ethtool.c
+++ b/drivers/net/ethernet/sfc/falcon/ethtool.c
@@ -948,9 +948,16 @@ ef4_ethtool_get_rxfh_fields(struct net_device *net_dev,
 			    struct ethtool_rxfh_fields *info)
 {
 	struct ef4_nic *efx = netdev_priv(net_dev);
-	unsigned int min_revision = 0;
 
 	info->data = 0;
+	/* Falcon A0 and A1 had a 4-tuple hash for TCP and UDP, but it was
+	 * broken so we do not enable it.
+	 * Falcon B0 adds a Toeplitz hash, 4-tuple for TCP and 2-tuple for
+	 * other IPv4, including UDP.
+	 * See falcon_init_rx_cfg().
+	 */
+	if (ef4_nic_rev(efx) < EF4_REV_FALCON_B0)
+		return 0;
 	switch (info->flow_type) {
 	case TCP_V4_FLOW:
 		info->data |= RXH_L4_B_0_1 | RXH_L4_B_2_3;
@@ -960,13 +967,10 @@ ef4_ethtool_get_rxfh_fields(struct net_device *net_dev,
 	case AH_ESP_V4_FLOW:
 	case IPV4_FLOW:
 		info->data |= RXH_IP_SRC | RXH_IP_DST;
-		min_revision = EF4_REV_FALCON_B0;
 		break;
 	default:
 		break;
 	}
-	if (ef4_nic_rev(efx) < min_revision)
-		info->data = 0;
 	return 0;
 }
 

