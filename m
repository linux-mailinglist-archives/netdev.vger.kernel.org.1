Return-Path: <netdev+bounces-266537-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4ImCDj0psWkBrgIAu9opvQ
	(envelope-from <netdev+bounces-266537-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 09:35:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3561E25F6AA
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 09:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D89853053DCE
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 08:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C6C3B635E;
	Wed, 11 Mar 2026 08:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tOzrAUYM"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012002.outbound.protection.outlook.com [52.101.53.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781393B4EBA;
	Wed, 11 Mar 2026 08:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773217785; cv=fail; b=ikqePRBl1rLvQSZyQvuG7Qq6BdcdidAsOWOLsJX7Kkpi3KYYBI/DEPMnk03sqQ9vM5HA+24dcocJZOEjjrL/rSCFoJJSYM5C+rTZ+s5m8L4wHWwIqI8PZJmMM40baPrrp2SGfDqNsZGhPNgquPIrOLiEKaLlSLDwMH7G+XNP2Zo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773217785; c=relaxed/simple;
	bh=KsrYyV2SVIIWNtCS3TTClUfNal/ac+XerxYxG/HX4jM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WMe4D1RYBNIKdiQWtv16LWXVPiRFOQbgO8cjD9gh5yd+cOzmPrKRXkJi4QQVGvL5hvCI9L11hFDy5AD+3VKey28msnr27eZUU7WNE4F5H8mEgtYIuCjFU2C60w/3BurI8HYjnyuL/HOPdB2/az2Kc1+feUZFnPoS3YY+72Po+KE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tOzrAUYM; arc=fail smtp.client-ip=52.101.53.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eC7wzMJmK7IUTZ6vCcN22xIVzlXpLyq/v08SoNZJGGfarNiLJTbrdVAG/GNYekl7Daa0T1JvQp9cgDR/PN4MpDy5fvMzcAjqv9E5rNovLO2VZZtEiBhDKKF8ugBRXu+Y+dxbHY6kXy0EamAJjWdPFLS7FhIz4Zd2Ig6Wfih1M+2X3MYuQd1IVav2gVboIt12zCHrQGaIY6t3aV28yhva6Cgg+vuuPygsu2t4wAgKybJNMY4FqDQqrKdxCz6cTnHij6G7gY7D9kzR4KoGHMfeHyN/BdHZLHnK+5izXaoCFBIFYOFYtRk3snchwvGPSCwN4jZ7GA0R5/LCFaTE2hBTOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJ2M3bRps9S808zgxOPJDGhJ442gDnGi2fsU/Kk5Rzs=;
 b=yvnhz/y/axiQZhv3FwV/FwAf8AEcJA3qNG4r22pdXYFRywP/pe56/ln2hdKIGSNLM1GPJUSou06Ghj5zd635KyZ4/WrNPjPpldvcbwfPOjDhx+qJiMR6VueDXx68twYiJBBYT4SkrE52GDjsEDlnPYLugsIgd4sUoD0r1w4kDpjM3pBK0CmsXoD8tlyu/okMKGhIn8RtgcFMhV+lKHfs+0FsJ/FmERXWQIryEA1xXQgRE9WsjFsvTsyYTzpPjne71+oU4EVo0xyfT9iMj86+GaZAZEiB0CC42AQ70/H2jRM11CBfdOBkcbQtTpsw30zS6vb9FFQIGtKLxQFjkskbHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lunn.ch smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJ2M3bRps9S808zgxOPJDGhJ442gDnGi2fsU/Kk5Rzs=;
 b=tOzrAUYMtTl2rdOjxIu/4Ht35ziGeV/Lgxx7gzALG9wu0+oDnT4Ouin4XVD17oFS4h+ChbX6xqdHL/TeX0AblFQ388SLuGmbS7qKF7ywx8nmFg6KBjBMbG6jXn97bYOhC3qLmHH5jv7RZEuL2sB70u3iAUnTxIedrn1V1NVFjyo=
Received: from BN0PR04CA0179.namprd04.prod.outlook.com (2603:10b6:408:eb::34)
 by BN0PR10MB4887.namprd10.prod.outlook.com (2603:10b6:408:124::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.13; Wed, 11 Mar
 2026 08:29:36 +0000
Received: from BN1PEPF00004681.namprd03.prod.outlook.com
 (2603:10b6:408:eb:cafe::a7) by BN0PR04CA0179.outlook.office365.com
 (2603:10b6:408:eb::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Wed,
 11 Mar 2026 08:29:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN1PEPF00004681.mail.protection.outlook.com (10.167.243.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 08:29:35 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Mar
 2026 03:29:26 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Mar
 2026 03:29:26 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 11 Mar 2026 03:29:26 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62B8TQ16509014;
	Wed, 11 Mar 2026 03:29:26 -0500
Received: from localhost (dhcp-172-24-231-152.dhcp.ti.com [172.24.231.152])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 62B8TPuu018584;
	Wed, 11 Mar 2026 03:29:25 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Meghana Malladi
	<m-malladi@ti.com>, Jacob Keller <jacob.e.keller@intel.com>
CC: <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@kernel.org>,
	<danishanwar@ti.com>
Subject: [PATCH net-next v2] net: ti: icssg-prueth: Add HSR multicast FDB port membership management
Date: Wed, 11 Mar 2026 13:59:23 +0530
Message-ID: <20260311082923.2962937-1-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004681:EE_|BN0PR10MB4887:EE_
X-MS-Office365-Filtering-Correlation-Id: b6d95eae-33e3-4819-a9d2-08de7f4853af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|36860700016|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	UT12ob0TM9wzQCwAFnxkqC5Tn9Q8QIshQdsULg7hItyF+hgogTYo//sbqNbfoR63OlO7j+oO9o4v//noFqkyuJx0gt976YNuPBSjMbRbwlvVA5Y1HL2tRWEBf9pwL+O80z1fJ+axQvbLsH0PtQEAcPdLqZn+Fp6lSMMRQgRPElBK+0yLXYxP/gye5O37ZCvfPwtTc83/nMAJ0zGTY2uMkV50X9+Nw4U10vv9JIlGs6dFoB4aQ0MwRSwnsFppGpCzQuSMUAnpNIZ3roK/lc37UrirafqZ2Ixi8wK6sAZeTPXwpkalowhZYU9GNABqGGM5QA4GJJRgAP7axrVmPj3ggxtofezChaal1trKQCs+nKOBGqsvoRgzorYUybtC2/zQl6xOoJtNfcJt+9oqsw7zfTpNA5lbakVTZW4TN26SnOBSbukXHdFgbXKV0vf3FgZXMVTbBaigiCjzLpS13Hvt9JZcnq07DpfLIJ8oghBG6eBqdgTdALvyS1xa4SFJVwvpCzkWDM3naw+LTeQD1RgBGfrgZxqLjqOfJqxE8QU3QAZiWCvwqOKLdWm7mIklHsjieTcFHfxYfwbEirw1oZ561QLYnNwQpy1jmezIY6TmuOf6QbB8hMG9CpUUcuin6WtEaaqEN6iPwEhvC8Hs1qXoF1CKy6o6OQr0j2/1l9w18/sz9sqYQLni+hr119K9jECgRVGdXo0iMm/Q3VbkWTL6h9cqygjx1/YDHFs+2Ns/hrGuk/ts+QhnhwIvFcdIMU0YWfhHaufWjGV/hDw/DMBE5Q==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(36860700016)(376014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	O3dnueoMbKSAFyDZHlsIAAs5R/LoWPkG6J86i0pDTzN/YNkt0jbHIirnJnbogTNEUlUN2RSD8ajl6l+10j7XEoNzw7EgLlGrQwuNQxExkvRrnE8WaD0eFO9v8In6px5e39UCUNymmNmbFxMhuqXxOP+kdgWdGxcnyZrCSiYdL7yu5pOfzOIDWgo17yR3MWxh9cgYe6hAoucKkuQMnjZh3dmXOGKhzljFJmLEQGHgCaqGmW5gwyEbkVOx3Ky3S/RVJ+RNm4qLvevvNst2hHH2Du3qNidMTH27NdlgVeHkqH+oUQcjPDRu5kuChRO99nFRdkVffnZFoBU2i4MjjYtGeGzsOMNjbU9Wbq3WmSR4+1rgkbY7rr7vBtYHGYH/zQl/PXfP5IdEfriJM7SfoZyNxGJNrP0obLZt1AtQ72G2wuc9bbpUe8SRGVOlXW23T/yY
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 08:29:35.0474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6d95eae-33e3-4819-a9d2-08de7f4853af
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4887
X-Rspamd-Queue-Id: 3561E25F6AA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266537-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[ti.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danishanwar@ti.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action

In HSR offload mode, multicast addresses can be added via HSR master
(hsr0) or directly to slave ports (eth1/eth2). The FDB must track port
membership: P0 (0x1) for HSR master, P1 (0x2) for slave port 1, and P2
(0x4) for slave port 2. When the same address is added from multiple
paths, memberships must accumulate.

Implement a hybrid approach using __dev_mc_sync() callbacks to track
basic add/delete operations, checking netdev_hw_addr->synced to
distinguish HSR-synced addresses from direct additions. Post-process
to handle overlapping memberships by checking refcount:
- refcount=2 with synced=1: HSR only (P0)
- refcount>=3 with synced=1: HSR + direct (P0|P1/P2)
- synced=0 with P0 set: HSR removed, clean up orphaned P0

On add operations, accumulate new membership with existing ports. On
delete operations, remove only the specific port and clean up orphaned
P0 bits if needed.

Add error handling for icssg_fdb_lookup() which can return negative
error codes (e.g., -ETIMEDOUT). On lookup failure in add/delete path,
default to no existing membership. In the post-processing path, skip
the address update to avoid corrupting FDB entries with garbage values.

VLAN Interface Handling:
Add support for multicast addresses added to VLAN interfaces on the HSR
master (e.g., hsr0.7). These addresses require P0 (HSR master) bit to be
set along with the port bits, since VLAN-tagged packets use separate FDB
entries per VLAN ID. Without P0, the HSR master would not receive
multicast packets on VLAN interfaces.

Track whether the add/del operation came from a VLAN interface path and
set P0 when in HSR offload mode with VLAN interfaces. Update orphaned P0
cleanup logic to preserve P0 for VLAN interfaces.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
v1 -> v2: 
   Added a helper function as suggested by Simon Horman <horms@kernel.org>

 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 249 +++++++++++++++++--
 1 file changed, 233 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 372e55803168..591be5c8056b 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -669,28 +669,133 @@ static int icssg_prueth_del_mcast(struct net_device *ndev, const u8 *addr)
 	return 0;
 }
 
+/**
+ * icssg_is_addr_synced - Check if address is synced from HSR master
+ * @ndev: network device
+ * @addr: multicast MAC address
+ *
+ * Checks if the address is synced from HSR master (hsr0) via
+ * dev_mc_sync_multiple() or added directly to the slave port.
+ *
+ * Return: true if synced from HSR master, false if added directly
+ */
+static bool icssg_is_addr_synced(struct net_device *ndev, const u8 *addr)
+{
+	struct netdev_hw_addr *ha;
+	bool is_synced = false;
+
+	netif_addr_lock_bh(ndev);
+	netdev_for_each_mc_addr(ha, ndev) {
+		if (ether_addr_equal(ha->addr, addr)) {
+			is_synced = ha->synced;
+			break;
+		}
+	}
+	netif_addr_unlock_bh(ndev);
+
+	return is_synced;
+}
+
+/**
+ * icssg_hsr_fdb_update - Update FDB and VLAN table for HSR multicast
+ * @emac: PRUETH EMAC private data
+ * @addr: multicast MAC address
+ * @vid: VLAN ID
+ * @port_membership: port membership bitmap (P0=0x1, P1=0x2, P2=0x4)
+ * @add: true to add entry, false to delete
+ *
+ * Updates both FDB and VLAN table entries for the given address.
+ */
+static void icssg_hsr_fdb_update(struct prueth_emac *emac, const u8 *addr,
+				 u8 vid, u8 port_membership, bool add)
+{
+	icssg_fdb_add_del(emac, addr, vid, port_membership, add);
+	icssg_vtbl_modify(emac, vid, BIT(emac->port_id),
+			  BIT(emac->port_id), add);
+}
+
+/**
+ * icssg_prueth_hsr_fdb_add_del - Manage FDB port membership for HSR multicast
+ * @emac: PRUETH EMAC private data
+ * @addr: multicast MAC address
+ * @vid: VLAN ID
+ * @is_synced: true if synced from HSR master, false if added directly
+ * @is_vlan_path: true if called from VLAN interface path, false for direct path
+ * @add: true to add/update, false to remove
+ *
+ * Manages FDB port membership bits (P0/P1/P2) for multicast addresses.
+ * On add: accumulates membership with existing ports.
+ * On delete: removes only the specific port, cleans up orphaned P0 if needed.
+ */
 static void icssg_prueth_hsr_fdb_add_del(struct prueth_emac *emac,
-					 const u8 *addr, u8 vid, bool add)
+					 const u8 *addr, u8 vid,
+					 bool is_synced, bool is_vlan_path,
+					 bool add)
 {
-	icssg_fdb_add_del(emac, addr, vid,
-			  ICSSG_FDB_ENTRY_P0_MEMBERSHIP |
-			  ICSSG_FDB_ENTRY_P1_MEMBERSHIP |
-			  ICSSG_FDB_ENTRY_P2_MEMBERSHIP |
-			  ICSSG_FDB_ENTRY_BLOCK, add);
-
-	if (add)
-		icssg_vtbl_modify(emac, vid, BIT(emac->port_id),
-				  BIT(emac->port_id), add);
+	int existing_membership, other_port_membership;
+	u8 port_membership;
+
+	/* Set P0 (HSR master) bit when:
+	 * - Address is synced from HSR master (is_synced=true), OR
+	 * - In HSR offload mode AND it's a VLAN interface (is_vlan_path=true)
+	 * This ensures VLAN interfaces on HSR master (hsr0.X) also get P0 set.
+	 */
+	if (is_synced || (emac->prueth->is_hsr_offload_mode && is_vlan_path))
+		port_membership = ICSSG_FDB_ENTRY_P0_MEMBERSHIP | BIT(emac->port_id);
+	else
+		port_membership = BIT(emac->port_id);
+	existing_membership = icssg_fdb_lookup(emac, addr, vid);
+	if (existing_membership < 0) {
+		netdev_dbg(emac->ndev,
+			   "FDB lookup failed for %pM: %d, assuming no existing entry\n",
+			   addr, existing_membership);
+		existing_membership = 0;
+	}
+
+	if (add) {
+		/* Accumulate with existing membership */
+		port_membership |= existing_membership;
+
+		netdev_dbg(emac->ndev,
+			   "FDB add %pM: P%d%s -> membership 0x%x\n",
+			   addr, emac->port_id, is_synced ? "+P0" : "",
+			   port_membership);
+
+		icssg_hsr_fdb_update(emac, addr, vid, port_membership, true);
+	} else {
+		other_port_membership = existing_membership & ~port_membership;
+
+		/* Clean up orphaned P0 if neither HSR synced nor VLAN path */
+		if (!is_synced && !is_vlan_path &&
+		    (existing_membership & ICSSG_FDB_ENTRY_P0_MEMBERSHIP))
+			other_port_membership &=
+				~ICSSG_FDB_ENTRY_P0_MEMBERSHIP;
+
+		netdev_dbg(emac->ndev,
+			   "FDB del %pM: 0x%x -> 0x%x\n",
+			   addr, existing_membership, other_port_membership);
+
+		icssg_hsr_fdb_update(emac, addr, vid, port_membership, false);
+
+		if (other_port_membership)
+			icssg_hsr_fdb_update(emac, addr, vid,
+					     other_port_membership, true);
+	}
 }
 
 static int icssg_prueth_hsr_add_mcast(struct net_device *ndev, const u8 *addr)
 {
 	struct net_device *real_dev, *port_dev;
+	bool is_synced, is_vlan_path;
 	struct prueth_emac *emac;
 	u8 vlan_id, i;
 
-	vlan_id = is_vlan_dev(ndev) ? vlan_dev_vlan_id(ndev) : PRUETH_DFLT_VLAN_HSR;
-	real_dev = is_vlan_dev(ndev) ? vlan_dev_real_dev(ndev) : ndev;
+	is_vlan_path = is_vlan_dev(ndev);
+	vlan_id = is_vlan_path ? vlan_dev_vlan_id(ndev) : PRUETH_DFLT_VLAN_HSR;
+	real_dev = is_vlan_path ? vlan_dev_real_dev(ndev) : ndev;
+
+	/* Check if this address is synced from HSR master */
+	is_synced = icssg_is_addr_synced(ndev, addr);
 
 	if (is_hsr_master(real_dev)) {
 		for (i = HSR_PT_SLAVE_A; i < HSR_PT_INTERLINK; i++) {
@@ -701,12 +806,14 @@ static int icssg_prueth_hsr_add_mcast(struct net_device *ndev, const u8 *addr)
 				return -EINVAL;
 			}
 			icssg_prueth_hsr_fdb_add_del(emac, addr, vlan_id,
+						     is_synced, is_vlan_path,
 						     true);
 			dev_put(port_dev);
 		}
 	} else {
 		emac = netdev_priv(real_dev);
-		icssg_prueth_hsr_fdb_add_del(emac, addr, vlan_id, true);
+		icssg_prueth_hsr_fdb_add_del(emac, addr, vlan_id,
+					     is_synced, is_vlan_path, true);
 	}
 
 	return 0;
@@ -715,11 +822,16 @@ static int icssg_prueth_hsr_add_mcast(struct net_device *ndev, const u8 *addr)
 static int icssg_prueth_hsr_del_mcast(struct net_device *ndev, const u8 *addr)
 {
 	struct net_device *real_dev, *port_dev;
+	bool is_synced, is_vlan_path;
 	struct prueth_emac *emac;
 	u8 vlan_id, i;
 
-	vlan_id = is_vlan_dev(ndev) ? vlan_dev_vlan_id(ndev) : PRUETH_DFLT_VLAN_HSR;
-	real_dev = is_vlan_dev(ndev) ? vlan_dev_real_dev(ndev) : ndev;
+	is_vlan_path = is_vlan_dev(ndev);
+	vlan_id = is_vlan_path ? vlan_dev_vlan_id(ndev) : PRUETH_DFLT_VLAN_HSR;
+	real_dev = is_vlan_path ? vlan_dev_real_dev(ndev) : ndev;
+
+	/* Check if this address was synced from HSR master */
+	is_synced = icssg_is_addr_synced(ndev, addr);
 
 	if (is_hsr_master(real_dev)) {
 		for (i = HSR_PT_SLAVE_A; i < HSR_PT_INTERLINK; i++) {
@@ -730,12 +842,14 @@ static int icssg_prueth_hsr_del_mcast(struct net_device *ndev, const u8 *addr)
 				return -EINVAL;
 			}
 			icssg_prueth_hsr_fdb_add_del(emac, addr, vlan_id,
+						     is_synced, is_vlan_path,
 						     false);
 			dev_put(port_dev);
 		}
 	} else {
 		emac = netdev_priv(real_dev);
-		icssg_prueth_hsr_fdb_add_del(emac, addr, vlan_id, false);
+		icssg_prueth_hsr_fdb_add_del(emac, addr, vlan_id,
+					     is_synced, is_vlan_path, false);
 	}
 
 	return 0;
@@ -1059,6 +1173,104 @@ static int emac_ndo_stop(struct net_device *ndev)
 	return 0;
 }
 
+/**
+ * icssg_hsr_handle_multicast_sync() - Handle HSR multicast overlapping memberships
+ * @emac: PRUETH EMAC private structure
+ *
+ * Post-process multicast addresses to handle overlapping memberships where
+ * the same address is added from multiple paths (hsr0 + eth1). The kernel
+ * increments refcount without triggering callbacks, so manually check refcount
+ * to detect and update FDB port membership accordingly.
+ */
+static void icssg_hsr_handle_multicast_sync(struct prueth_emac *emac)
+{
+	struct hsr_mcast_update {
+		struct list_head list;
+		u8 addr[ETH_ALEN];
+		int refcount;
+		bool synced;
+	};
+	struct hsr_mcast_update *update, *tmp;
+	struct net_device *ndev = emac->ndev;
+	u8 vlan_id = PRUETH_DFLT_VLAN_HSR;
+	struct netdev_hw_addr *ha;
+	int existing_membership;
+	LIST_HEAD(update_list);
+	u8 port_membership;
+
+	/* Handle overlapping memberships: When the same address
+	 * is added from multiple paths (hsr0 + eth1), kernel
+	 * increments refcount without triggering callbacks.
+	 * Manually check refcount to detect:
+	 * - refcount=2 + synced: HSR only, membership = P0
+	 * - refcount>=3 + synced: HSR + direct, membership = P0|Px
+	 * - !synced but P0 set: HSR removed, clean up orphaned P0
+	 *
+	 * Collect addresses to update while holding the lock, then
+	 * process them after releasing the lock to avoid sleeping
+	 * while atomic (icssg_fdb_lookup/update can sleep).
+	 */
+	netif_addr_lock_bh(ndev);
+	netdev_for_each_mc_addr(ha, ndev) {
+		/* Queue this address for processing.
+		 * We need to check existing_membership via FDB lookup
+		 * (which can sleep), so defer that until after unlock.
+		 * Save synced/refcount to reproduce original logic.
+		 */
+		update = kmalloc_obj(*update, GFP_ATOMIC);
+		if (!update)
+			continue;
+
+		ether_addr_copy(update->addr, ha->addr);
+		update->synced = ha->synced;
+		update->refcount = ha->refcount;
+		list_add_tail(&update->list, &update_list);
+	}
+	netif_addr_unlock_bh(ndev);
+
+	/* Process collected addresses outside spinlock */
+	list_for_each_entry_safe(update, tmp, &update_list, list) {
+		existing_membership = icssg_fdb_lookup(emac,
+						       update->addr,
+						       vlan_id);
+		if (existing_membership < 0) {
+			netdev_dbg(ndev,
+				   "FDB lookup failed for %pM: %d, skipping\n",
+				   update->addr, existing_membership);
+			list_del(&update->list);
+			kfree(update);
+			continue;
+		}
+
+		port_membership = existing_membership;
+		if (update->synced) {
+			port_membership |=
+				ICSSG_FDB_ENTRY_P0_MEMBERSHIP;
+			if (update->refcount >= 3)
+				port_membership |= BIT(emac->port_id);
+			else
+				port_membership &= ~BIT(emac->port_id);
+		} else if (existing_membership &
+			   ICSSG_FDB_ENTRY_P0_MEMBERSHIP) {
+			port_membership &=
+				~ICSSG_FDB_ENTRY_P0_MEMBERSHIP;
+		}
+
+		if (existing_membership != port_membership) {
+			netdev_dbg(ndev, "Update %pM: 0x%x -> 0x%x\n",
+				   update->addr, existing_membership,
+				   port_membership);
+
+			icssg_hsr_fdb_update(emac, update->addr,
+					     vlan_id, port_membership,
+					     true);
+		}
+
+		list_del(&update->list);
+		kfree(update);
+	}
+}
+
 static void emac_ndo_set_rx_mode_work(struct work_struct *work)
 {
 	struct prueth_emac *emac = container_of(work, struct prueth_emac, rx_mode_work);
@@ -1085,8 +1297,13 @@ static void emac_ndo_set_rx_mode_work(struct work_struct *work)
 	}
 
 	if (emac->prueth->is_hsr_offload_mode) {
+		/* Track basic add/delete via callbacks */
 		__dev_mc_sync(ndev, icssg_prueth_hsr_add_mcast,
 			      icssg_prueth_hsr_del_mcast);
+
+		/* Handle overlapping memberships */
+		icssg_hsr_handle_multicast_sync(emac);
+
 		if (rtnl_trylock()) {
 			vlan_for_each(emac->prueth->hsr_dev,
 				      icssg_update_vlan_mcast, emac);

base-commit: 482aac8b56ca21d06c588517970579474d56736e
-- 
2.34.1


