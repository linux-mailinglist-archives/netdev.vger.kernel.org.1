Return-Path: <netdev+bounces-293272-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QH5KM2gAGmpu0ggAu9opvQ
	(envelope-from <netdev+bounces-293272-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 23:08:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3977D608C9F
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 23:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECC96301CCD8
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 21:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D664218A0;
	Fri, 29 May 2026 21:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="omps71a1"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013023.outbound.protection.outlook.com [40.93.201.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AB337C902;
	Fri, 29 May 2026 21:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780088608; cv=fail; b=NtA1bn73X7MfpHnb47UBagEyA2yt1d72fvN1x3FJ6UxigtMtGTCa/UemXHNhlvlsdULeCF9j5gZehi7EDhEApV2VyT/qlByQ2h3VBbI6/gGKIOtjTKMGA1H1oS5Hl4Uz3zjL9aiwt2NTHNAQjfViKllva8eZC441VWtU0luqOZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780088608; c=relaxed/simple;
	bh=D44Ope8vawjr2UNziYpBn/E0bfawEpuAp7Dyv/lHIZY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Mg7h2+PWIVP4D74EJWnS6OecNH8qLLxjfpvw0hfnFcituRXoZbKTx8xkF986L0yRGPyUVa43I27LZZz7sQ1qDlPpoDBRRMcy3TCLtqmd2NPNf6Sb7lAPKkhSThvquxtHHZEuBFmxPL4KrYePz+3oV6GQk+R/d97iQLVD+XCvW/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=omps71a1; arc=fail smtp.client-ip=40.93.201.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l+QhFMQscltH8uyWaM1avN9YqqwJZdJJBekKWmAnP9PNVYcXMMsYLluMR4MKTP1DDqF8+vXgwIIIhrZH+a0WHcOiyZVU1hNruxYqRgMx/4YC3rM/q+mYC4qi/iUIZq4kQCtWlNxWkK16NdlqL8n21XzU3JxxdurB/fe5Zxv/k2AhCGWp2PuiD04TzSGLzyJlCDXEcG3Uh5bewhzE3jcpxDVVgkdyq0VY+zNtuo4Eti+xZ6gvGmBCgLCkmFiSl6IBbEP/lN+nRFKwTOG5RwCVAeeYZpPCfPfpxbblPKN9g9Om+XQUYNVjMxm76rW9PEpVpydMUDvc3olyj8ka/ym9SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5G2ht0bDLW7eIJ54LnkSmrks+g1lLhtOz+mCJaVyq1I=;
 b=aXyvQ7NJyXn4R4NmBdOwARQiKcJQUC1EXBykGumg7pkFx4qhR/fl6iAUKumY75fUwyB+J6jj39ytLKj8QbjNFb73x3SKYHCbSt1ycAJCvvHlhM+WWkGX6MZrkA7o83AlGZAamGPRULd6Fx8+Xd+JUGS8JjE+cmD/mCE3zvGHiY/0F4W/F29mfDOTsJnHQvqO6PVKPkO2rJ/Ewv0+bA3XGzHFU/1zligS5Y9KRYtsFdqbLjfiZAZzePnFBcBn5t6x3JivCKn7IXBIdq81JYzdk1nrsdE3G65k6ZXVCytIasL9sRJIRQFn9lQoTw7PKMPUrQQxOL6JkiljZJd44yUzIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=microchip.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5G2ht0bDLW7eIJ54LnkSmrks+g1lLhtOz+mCJaVyq1I=;
 b=omps71a1fFqz4J9BQR6CYbXcFKK4UsUvlWsiaFDCR8X9/KI7ip1DhUcPYeJ0VNDEpJyqIa0xDVh1KZSxlKlBRZmkPmxY4trra4nEj6nfM49IY3ZyUkzpkV79a4o5NPwiw0ols52l11z294P4grHFROr1FVi1YvJSIP3quUFOZJtMKx0EKLKcP8EbVF06+JakHYBhTLDjSEIHELe+abglfFOpsqaj0N3lj4taVLJhEGvAu09FOjvi6ZKyWx4EwzA8i2jHTpF+pQ3ZG5o+WegfYlGt26lKxvp0eJqDVLF345x6Z3VbG+TaP0ZsJHyKC/pSlXFH+F+GXmn1URxstTHzGA==
Received: from CY5PR22CA0090.namprd22.prod.outlook.com (2603:10b6:930:65::12)
 by DS7PR12MB5791.namprd12.prod.outlook.com (2603:10b6:8:76::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Fri, 29 May
 2026 21:03:21 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:930:65:cafe::25) by CY5PR22CA0090.outlook.office365.com
 (2603:10b6:930:65::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Fri, 29
 May 2026 21:03:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 29 May 2026 21:03:21 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 29 May
 2026 14:03:06 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 29 May 2026 14:03:06 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Fri, 29
 May 2026 14:03:06 -0700
From: David Thompson <davthompson@nvidia.com>
To: <bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, David Thompson
	<davthompson@nvidia.com>
Subject: [PATCH net v2] net: lan743x: permit VLAN-tagged packets up to configured MTU
Date: Fri, 29 May 2026 21:03:00 +0000
Message-ID: <20260529210300.433135-1-davthompson@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|DS7PR12MB5791:EE_
X-MS-Office365-Filtering-Correlation-Id: ee966030-ebca-43a0-57cb-08debdc5b77c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	OSmFLZP4a4Q3JEgdKUPj6pJAgaRaecTCsU7oywAQJ7ic9+30mhaqIg2QQx2oSeCQs3LS9VWge0cTj35hYDCcW4oc5HgsT2EhX1hBHftAjQrze/YvAh6FRggLtn913XiJEsUfkKrU5Gh2i8IivS1wBulnxC0MIdCBEO/XGJtgBw9+8upDtjGTVZa7xi39AIhQI21Fo6Zv5SEFJtR47BjhvnzkAY6RmtBUm24SJzvY3A/ojNFnZAVvVutunF0RdbkJR5vZediCBBCAsgHA+W8BVxsVEFBiYnYd2ui5huNUgrGaRAfbAm5lz37Jv3G6HQFX4F2hQQnwVW35m5DkgsSDwLE5KO1hRyMDpLCna1kkod3Ko/RgAwf1zdNXASjnElYxxvPFRYbU1G3sDGPRIcAfsYT0J9KoQCv9o3etWZe6Wd2Rhcmgeqwm1ABv4IicI1COFVHGR6x9S7MYkrzsYkN3oLbOkqjYxY7meSc7Tc0WZ6mam4+xx4bNzDxpN0GbhNww/UprQrKYN3Ngqev1RcpgjpngKhynBa6fqXQVPUOshxfM4oHvdfOOT+lc8x6O/Mhog8WloaSbqvxmKAxAsdY7eKfwkqZ/+LwlcNkyLgK1GYriEuF4082CIzD7/VxX+aD9C4aROHBTFD6CmVz98A6luj2JCN3fsadoUw895q6bEpgBjt1y1jKICvqNB6zD7TvmiQU+0XH9LAMFM2+tM2iOpOCR5T8QvsLWUxn0BgQcDww=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ygVMPz2CxMXGwLZqA1u5Sd19c8tr91QVoAuT+mLUSGrdB4dHDGR5rQre5B/PobgL5rcL2gA8dbt21tXL1KhxL5z3PfFLCHTw2HcE5F2GfhZDIoudJueDkEL6ONow88PMI9QdZNnzXwy/ft7/qcb0S9R2n7Yl5HNNmBbmvUmm0nViNg1dZQ5lJfG6xzlqEeyGZXhDzarTbaFkZUQiQnJbqviTf8pApaW9ry4uRf8heosAI6zN/q4kfkS5EweKP6vMt3H5D+qKsXsENr7Sps4A8+qnLR2UzNhqkXzKsCb436/etrX/ei8pI6XNjlLQYUmA0rUrLZLZT14LdswRao21hPaCVjpWOf4kcLjBD0IzPrynV7NtjZ4xCg2zUxSJWV2gURGoYo6vv6AfoQn7c4h5Ygv9bisafH8uXqbRRXpr58tAcK9gk3+0AEV8D4y2S5Zi
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 21:03:21.6344
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee966030-ebca-43a0-57cb-08debdc5b77c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5791
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293272-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davthompson@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 3977D608C9F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

VLAN-tagged interfaces on lan743x devices were previously unreachable via
SSH and failed to respond to large ping packets (e.g. "ping -s 1469" given
MTU=1500). In these scenarios, "ethtool -S" reports non-zero "RX Oversize
Frame Errors". According to Microchip AN2948, the MAC_RX FSE (VLAN field
size enforcement) bit determines whether frames with VLAN tags exceeding
the base MTU plus tag length are discarded.

The driver must set the MAC_RX.FSE bit before setting MAC_RX.RXEN to allow
VLAN-tagged frames up to the interface MTU, preventing them from being
treated as oversized. As a result, both the base and VLAN-tagged interfaces
can use the same MTU without receive errors.

Fixes: 23f0703c125b ("lan743x: Add main source files for new lan743x driver")
Signed-off-by: David Thompson <davthompson@nvidia.com>
---
v2:
- Added helper function, lan743x_mac_rx_enable_fse(), to set FSE bit properly
- Added explicit comment about use of distinct write cycle to set FSE bit
- Moved setting of FSE from lan743x_mac_open() to lan743x_mac_init(), allowing FSE
  bit to be set upon probe() path or suspend/resume path. This change fixes an
  issue raised by Sashiko
---
 drivers/net/ethernet/microchip/lan743x_main.c | 32 +++++++++++++++++++
 drivers/net/ethernet/microchip/lan743x_main.h |  1 +
 2 files changed, 33 insertions(+)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index f3332417162e..ffac22883e49 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -1219,6 +1219,36 @@ static void lan743x_mac_set_address(struct lan743x_adapter *adapter,
 		   "MAC address set to %pM\n", addr);
 }
 
+static void lan743x_mac_rx_enable_fse(struct lan743x_adapter *adapter)
+{
+	u32 mac_rx;
+	bool rxen;
+
+	mac_rx = lan743x_csr_read(adapter, MAC_RX);
+	if (mac_rx & MAC_RX_FSE_)
+		return;
+
+	rxen = mac_rx & MAC_RX_RXEN_;
+	if (rxen) {
+		mac_rx &= ~MAC_RX_RXEN_;
+		lan743x_csr_write(adapter, MAC_RX, mac_rx);
+		lan743x_csr_wait_for_bit(adapter, MAC_RX, MAC_RX_RXD_,
+					 1, 1000, 20000, 100);
+	}
+
+	/* Per AN2948, hardware prevents modification of the FSE bit while the
+	 * MAC receiver is enabled (RXEN bit set). Use separate register write
+	 * to assert the FSE bit before enabling the RXEN bit in MAC_RX
+	 */
+	mac_rx |= MAC_RX_FSE_;
+	lan743x_csr_write(adapter, MAC_RX, mac_rx);
+
+	if (rxen) {
+		mac_rx |= MAC_RX_RXEN_;
+		lan743x_csr_write(adapter, MAC_RX, mac_rx);
+	}
+}
+
 static int lan743x_mac_init(struct lan743x_adapter *adapter)
 {
 	bool mac_address_valid = true;
@@ -1258,6 +1288,8 @@ static int lan743x_mac_init(struct lan743x_adapter *adapter)
 	lan743x_mac_set_address(adapter, adapter->mac_address);
 	eth_hw_addr_set(netdev, adapter->mac_address);
 
+	lan743x_mac_rx_enable_fse(adapter);
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/microchip/lan743x_main.h b/drivers/net/ethernet/microchip/lan743x_main.h
index 160d94a7cee6..1573c8f9c993 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.h
+++ b/drivers/net/ethernet/microchip/lan743x_main.h
@@ -182,6 +182,7 @@
 #define MAC_RX				(0x104)
 #define MAC_RX_MAX_SIZE_SHIFT_		(16)
 #define MAC_RX_MAX_SIZE_MASK_		(0x3FFF0000)
+#define MAC_RX_FSE_			BIT(2)
 #define MAC_RX_RXD_			BIT(1)
 #define MAC_RX_RXEN_			BIT(0)
 
-- 
2.43.0


