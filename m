Return-Path: <netdev+bounces-264381-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKreMOt8qWkg8gAAu9opvQ
	(envelope-from <netdev+bounces-264381-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 13:54:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 93861212281
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 13:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 29B08300372E
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 12:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB0539D6C2;
	Thu,  5 Mar 2026 12:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HYJwYU1E"
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011033.outbound.protection.outlook.com [52.101.57.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD1C371054;
	Thu,  5 Mar 2026 12:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772715182; cv=fail; b=L/Q5EQj6ywSjVrTF0ngS3LPBubo2M0051qMNvGsr+FeeVN2bqQekd2BGfxWBtGUcutvEDhYGO2CYkvlmDiPqNvWCOnNUb0ryFgplQXmTfEfzMMM3awfl9cIs/DSU8WyPe+JRiNXhKa1p19szYpYKBOL9qheCaLvoc7wsMIjza8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772715182; c=relaxed/simple;
	bh=htU8fsHSjva6dQv0h2WCLZ/BAcN9JMqq6HlskR3dc5M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HprEMsllTUSfpqeGDGLx8AhIQj13FxkwHqIlHdLn+9c6XwvAsr7I9WmuIGm5fLu55ua1V/EKdHsIQLvAlwMEUIL6EtSz4samhDJ+gVKJxXuh3+s0Fvo35PB/16ECnmVCgRVEQQmHRiK2nj3kcZfdujJFiwOU89rix5VXdkxEurQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HYJwYU1E; arc=fail smtp.client-ip=52.101.57.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JJLIWilPsfUpbv45KeSLWSUra4fMQUJjMzhKlybUqqgAldL1mZ2Uc+gcEkJyUDdSA3BX+1rYQWq3EeIBJScrLA1EcLnNN2hHUy1t46W6ouj1eoGG5cqlUOdy4Y6ipmTCwtQ6LsGC2Q0rOmwgtPtqbvBsoPFJxSo6LZCiLQ/q1cBf3OZF8cM+hHYJsh1mYHWae2D8halfnCrfCZMF5SuP4r0+fUelBT+x21t9DbjDbSFEnrN5Z/tCY/P0o3f8/H3ZuR6QpdNHJjzEUPtPrAeLpH1gk3Z3K+zI6Nb+3m8XdWkgapW8w9z7uTXisBIPQAARtM1DiU74K7+sMruB3i4FJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VuJX8kQYPV8451BZkD//NEdBc7/mcuz13s5BfHDhRTU=;
 b=TRlaPgVBahq/Cx6lzGFavWQoWitSROW6r4l/+/MnvetiUjbqI4E1td5J/9ZMjM36g5QgHxxaeX3IvCi+jwbbNkbNTWskl9ojbxLO9OBJktc0a4NkfPtBTlkeZNVCJz+kb5WLhUpTAi/QVdjzxwxHDACjD6X2VuPjw3j1mHmV2k4olUGuZ5ezONhNc0v+GaZgbweJot6koVa+064Ynk16cKKTmW4qLjP8juXy/v6oaaDycNbM+TycUku7mBZX6Iy0+tllBJv81syWbFXfi+cK9DfFkfYc8jgaOabtY1f8Ww/4ZK7rS+UAe07NbV8u+3VbbBkBSr8/+fCYFe5YKVHzCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lunn.ch smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VuJX8kQYPV8451BZkD//NEdBc7/mcuz13s5BfHDhRTU=;
 b=HYJwYU1EO2DQL/yK7WQ6S5cLfkJ9dxU8hY45YTLB6wYKKFbiWusaAzCRzqBkpnLo8Vzrbb50IgWE3229vuUdp73gLwnBvBxyM5nVAX5zux2eMAs0Np/Fr3YNkRjqwQjhpNmxqPUo8h0csa/qn9suIB5iafT2j50q73s+mvyZ8+k=
Received: from MW4PR03CA0280.namprd03.prod.outlook.com (2603:10b6:303:b5::15)
 by DS0PR10MB6270.namprd10.prod.outlook.com (2603:10b6:8:d2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 12:52:57 +0000
Received: from CO1PEPF000075F0.namprd03.prod.outlook.com
 (2603:10b6:303:b5:cafe::d4) by MW4PR03CA0280.outlook.office365.com
 (2603:10b6:303:b5::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Thu,
 5 Mar 2026 12:52:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CO1PEPF000075F0.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 5 Mar 2026 12:52:55 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Mar
 2026 06:52:54 -0600
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Mar
 2026 06:52:54 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 5 Mar 2026 06:52:54 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 625CqsOj1868857;
	Thu, 5 Mar 2026 06:52:54 -0600
Received: from localhost (dhcp-172-24-231-152.dhcp.ti.com [172.24.231.152])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 625CqreY002163;
	Thu, 5 Mar 2026 06:52:53 -0600
From: MD Danish Anwar <danishanwar@ti.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Meghana Malladi
	<m-malladi@ti.com>, Jacob Keller <jacob.e.keller@intel.com>
CC: <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>, "Roger
 Quadros" <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net-next] net: ti: icssg-prueth: Add HSR multicast FDB port membership management
Date: Thu, 5 Mar 2026 18:22:51 +0530
Message-ID: <20260305125251.1828326-1-danishanwar@ti.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F0:EE_|DS0PR10MB6270:EE_
X-MS-Office365-Filtering-Correlation-Id: fcf83e49-d2d9-457f-40ae-08de7ab61eec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700016|34020700016|1800799024;
X-Microsoft-Antispam-Message-Info:
	o5tbOnCzGcg6kGrlQ9muX4VUr91YUYNIryvpu/f+lmf8sUlxzHBkfnuvDzVlgSKMsiOBmC7JJUn/DBjlxSplSSnkCf8r0IAmtvWApkJ6U8KwEMlcczfPrxkOSitI3hY+G6/sIBWRhfmQQSH/LKYHPcwfgggiIDcIrkALzCG+eFNxeo6x/WjmT2DGR00xG+DTmz0zWzWrCrGIBIBP50DJtSpbQOkS4x92mCVu91tyLbwlHKtQTwOhTaKF393Zmuw1rGwa65zl/n5xeev8aTyz3eNFsuOkYA5fEBD14yTGT0gWhQlJoz67RWWvXJZ+aeLbA8U1VHPizOPwvJ3myqVWdWUYV89w5eEFyl9RSCtivoc9tXo9yfjkat8mSGXMfPLWsfJRPCjkT+vKBRUBKCjjHLrlvJhn6cVrhQKUPjEi9n2AHulETTvjFC4fTw3qVqKBBfu0zJeuwZfB4pLxYqvsC0JbKsaAqrwSjxanAyCpIzS+h713BuylHz3L89ZP+xbh+r5uIt0a5iYGXw6lnlEL6h/+oSEfCZt++w39wjuV9bKjKgSG/e9v71r8Z0pBAsFhdt/ZUn0ywUwQBktJRUwBAMl1LzYVuxR5Nrq9JFjMdgM+M85uFaCeRiYigGu3C3Q8x9wCBrqLJQ/vMw8PCo/5+/KtR1erpncmPcSxQBR8sYQ9urVq5Xyl31ucd0iiYTWdwxBtYCCEWGBZdp//X8UvyrThvQf2V4vphUa8ECm+s1wqNRq06/ZAvEH9JM8GwSchT3m7uj/7aL8Yx59meMxRpw==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700016)(34020700016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XThIQq33xZGb+eHD/Mo1qru9YyATVrecJmRWLpQ2pjXxMNKJKelj9d18S/K5rPtmra7vfnvG4uB0JAywmOBJp/3E+L2Fc3mOBVYaYDRt9WttaatSaMqR6ctgblmPxsV5ygIDYNfdPImJPpbh/WB0NNEctWzvBwS8adV1y3wmaM31XOzUR00thO7pDV7ffC+J2ISD+tKXxBvXNU1X/PrEFlL+I0e8fjl8eD9VYb88YPoScAVOTcmW251MOiHCqdZQmdQpgH03v+xAgczgCRAnn18KkbOEHEgmmAYiVPBVx6sPdgvaV45/P8RWgxmhK1m1286mF1U5x3DKktOWnaAPnU2eiDC48c8GsQfV6LXtbZ583yGEmghNpUR3Q6pTPoLiugVGFLfeqOIHCbeE2K/+hMSlEPNi8Ke1tOz0hDcO8+vEvITxVzshu2WK8kiM0H6W
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 12:52:55.3342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf83e49-d2d9-457f-40ae-08de7ab61eec
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6270
X-Rspamd-Queue-Id: 93861212281
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264381-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danishanwar@ti.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 233 +++++++++++++++++--
 1 file changed, 217 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 9efa39069c8c..1366e8e3abbe 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -661,28 +661,133 @@ static int icssg_prueth_del_mcast(struct net_device *ndev, const u8 *addr)
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
@@ -693,12 +798,14 @@ static int icssg_prueth_hsr_add_mcast(struct net_device *ndev, const u8 *addr)
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
@@ -707,11 +814,16 @@ static int icssg_prueth_hsr_add_mcast(struct net_device *ndev, const u8 *addr)
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
@@ -722,12 +834,14 @@ static int icssg_prueth_hsr_del_mcast(struct net_device *ndev, const u8 *addr)
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
@@ -1077,8 +1191,95 @@ static void emac_ndo_set_rx_mode_work(struct work_struct *work)
 	}
 
 	if (emac->prueth->is_hsr_offload_mode) {
+		struct hsr_mcast_update {
+			struct list_head list;
+			u8 addr[ETH_ALEN];
+			bool synced;
+			int refcount;
+		};
+		struct hsr_mcast_update *update, *tmp;
+		u8 vlan_id = PRUETH_DFLT_VLAN_HSR;
+		struct netdev_hw_addr *ha;
+		int existing_membership;
+		LIST_HEAD(update_list);
+		u8 port_membership;
+
+		/* Track basic add/delete via callbacks */
 		__dev_mc_sync(ndev, icssg_prueth_hsr_add_mcast,
 			      icssg_prueth_hsr_del_mcast);
+
+		/* Handle overlapping memberships: When the same address
+		 * is added from multiple paths (hsr0 + eth1), kernel
+		 * increments refcount without triggering callbacks.
+		 * Manually check refcount to detect:
+		 * - refcount=2 + synced: HSR only, membership = P0
+		 * - refcount>=3 + synced: HSR + direct, membership = P0|Px
+		 * - !synced but P0 set: HSR removed, clean up orphaned P0
+		 *
+		 * Collect addresses to update while holding the lock, then
+		 * process them after releasing the lock to avoid sleeping
+		 * while atomic (icssg_fdb_lookup/update can sleep).
+		 */
+		netif_addr_lock_bh(ndev);
+		netdev_for_each_mc_addr(ha, ndev) {
+			/* Queue this address for processing.
+			 * We need to check existing_membership via FDB lookup
+			 * (which can sleep), so defer that until after unlock.
+			 * Save synced/refcount to reproduce original logic.
+			 */
+			update = kmalloc_obj(*update, GFP_ATOMIC);
+			if (!update)
+				continue;
+
+			ether_addr_copy(update->addr, ha->addr);
+			update->synced = ha->synced;
+			update->refcount = ha->refcount;
+			list_add_tail(&update->list, &update_list);
+		}
+		netif_addr_unlock_bh(ndev);
+
+		/* Process collected addresses outside spinlock */
+		list_for_each_entry_safe(update, tmp, &update_list, list) {
+			existing_membership = icssg_fdb_lookup(emac,
+							       update->addr,
+							       vlan_id);
+			if (existing_membership < 0) {
+				netdev_dbg(ndev,
+					   "FDB lookup failed for %pM: %d, skipping\n",
+					   update->addr, existing_membership);
+				list_del(&update->list);
+				kfree(update);
+				continue;
+			}
+
+			port_membership = existing_membership;
+			if (update->synced) {
+				port_membership |=
+					ICSSG_FDB_ENTRY_P0_MEMBERSHIP;
+				if (update->refcount >= 3)
+					port_membership |= BIT(emac->port_id);
+				else
+					port_membership &= ~BIT(emac->port_id);
+			} else if (existing_membership &
+				   ICSSG_FDB_ENTRY_P0_MEMBERSHIP) {
+				port_membership &=
+					~ICSSG_FDB_ENTRY_P0_MEMBERSHIP;
+			}
+
+			if (existing_membership != port_membership) {
+				netdev_dbg(ndev, "Update %pM: 0x%x -> 0x%x\n",
+					   update->addr, existing_membership,
+					   port_membership);
+
+				icssg_hsr_fdb_update(emac, update->addr,
+						     vlan_id, port_membership,
+						     true);
+			}
+
+			list_del(&update->list);
+			kfree(update);
+		}
+
 		if (rtnl_trylock()) {
 			vlan_for_each(emac->prueth->hsr_dev,
 				      icssg_update_vlan_mcast, emac);

base-commit: 70836c8d0fe046400de8cdcf0613b2f1f6bddde3
-- 
2.34.1


