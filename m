Return-Path: <netdev+bounces-182761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F59A89D4B
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 14:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0013217B83C
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 12:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B832951D9;
	Tue, 15 Apr 2025 12:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aFPhHCzX"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EC627A934
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 12:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744719192; cv=fail; b=XEp5rA8BOD+2KpGPb7LpzwZvDdpfcsBBLJINeyfldAOM5yYCUc+Xr6mCSY4qfV5Jd2B/4FlAe7QweQ1a5CWIh1GFR5SjfXxJG+fCxhOt/gPuAGGMBOxiEHoW8wAGzHwHur42IbXLrNxzhv1k67oA3qyhZhNjogCX7vtzJ6u//YQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744719192; c=relaxed/simple;
	bh=Rath+f3+g8e8CNW9Yl+NqHiic77bxbRAjXyOxx7hG9s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sUSZd0Spjqf7Po4G673+2toMOzWVMqMlc7XVlIousDoAsNSJIDsIA3Vn5hRUnkv7gzyy8mElTfl2LUnvDnFsQuPvFVXEvWvrlzrJLKO35M55fYG4xlyghXxLQW437OlcRSGTsER09tOZ8fEnXHEj+tpDejiSyVg3M8fTei+ThEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aFPhHCzX; arc=fail smtp.client-ip=40.107.244.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I5rCek1UgQ8xjxaVvoyTa/RoVY5BKSWuV43fE99D3XaITvUhu63THwAZpdJ7mOCo0dMuI6Joe1qsDRKpjNseN0C0VvEAU27e1f0fl4Pl5erLcvwDt8GiBEhp5ba43eK7ANZqTZFQxuAy/wehp3lTrVKnGmgDsIhcSlfHE36PilK/Aiqe35cR7ibE11ahfkDX8W9qxxm74UofXQzLr7qOligRL8NkjHEqc4VTnyEo8ieNKK0xyWa/8HYglKc47isT3LIPwbk/wPNPcf1ml/JVJuz+w5XDvPTroe3BNKzFJx+3dG0I3fr1UMKvbtj5E6XVV1+7MriBZ5hbW4V785Vgyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+wRzE1PYBsjNwu1jepbYSoBTjFeuJfJ6cTCKMR3t8Bk=;
 b=lyGHMupGl+so/dwd7oGScXra9o08jJIk4vsYWcyzmaCblTxf6E96eFsJ0Jn6g00u0q0rilalLshCfE2ZRfQxwbI5Vw5ZgYg1mc2L7o5wJ5boGLgcIekJwU6EGB2OXObL+zXfUgLxIVeGqttGPKx3zFnG7mdpIlG+BENt7jZuOVkAk0aspsM7pKW1LWLwUEeq2chRkvvUjp3PYnU/HmC9LVrV62AHPxIqiPf7Z1S8+R+iEw1CoQw76TPQpQjl4P3V/om1XWMvL0BGxBkCmh+8MzME8o0L0E3ruQxrwhT01dJO3y+9DGETMNrVNZ9ypLQZY7G8VQbiwHlReJ3PTQbDGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+wRzE1PYBsjNwu1jepbYSoBTjFeuJfJ6cTCKMR3t8Bk=;
 b=aFPhHCzXWmityTxLKPsPuWZdNWO2I5idI9YSUlOnIlpwO6o3tDvR8fkPFaKFG6kqC5vCnAp+tKBj6ROZOHCjp7qV15suzr+XE+aW7FeaEdhJ4fkWqlc8uIjg6XliGhGBfLBIvIsIrrLEt+h6CXUFpne9kxEqXdLzoFviGgZ5O5HiMACvErqVoZoQHY72UfK0fzSi+Fi98aCYWkZ0scK1/nX2Lg4nk4uDnu1I+vdQ31Czr8yYKyO76X4fpPgsjghVQzS9p7BqWCFwT0NrorIPFyey6B6RP4nmPGE0ERZZEv0PCD4khdksOx+GVRdpsgdvNr3Lts0F57WXOVRimZgTqA==
Received: from BL1PR13CA0004.namprd13.prod.outlook.com (2603:10b6:208:256::9)
 by CH3PR12MB8353.namprd12.prod.outlook.com (2603:10b6:610:12c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Tue, 15 Apr
 2025 12:13:07 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:208:256:cafe::44) by BL1PR13CA0004.outlook.office365.com
 (2603:10b6:208:256::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.11 via Frontend Transport; Tue,
 15 Apr 2025 12:13:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 12:13:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Apr
 2025 05:12:53 -0700
Received: from shredder.lan (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 15 Apr
 2025 05:12:50 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<petrm@nvidia.com>, <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 15/15] vxlan: Convert FDB table to rhashtable
Date: Tue, 15 Apr 2025 15:11:43 +0300
Message-ID: <20250415121143.345227-16-idosch@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250415121143.345227-1-idosch@nvidia.com>
References: <20250415121143.345227-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|CH3PR12MB8353:EE_
X-MS-Office365-Filtering-Correlation-Id: fc1d74d4-ac1f-4f95-13e9-08dd7c16e155
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gVhlrjRFAfwtchm9kRo5NzDD5vHyrys2eYQPCLn7Jt6dVsjvBXTedMdSKn9M?=
 =?us-ascii?Q?3GIMQBMwnwQRR/iIlIopPBdGOdECSiRkrWVwh7zzXb8VmEtbP5U5r3sYk2v4?=
 =?us-ascii?Q?8LU2yB3H9iwBUwQbaDCmD3cfIQ15My4EnsKfl21OP7pWVWrtM0roiW2a6nrN?=
 =?us-ascii?Q?qMNpgJ2onOmPlnTZIt0w7sXdWSdB1ZC7u56NaqZ9AERupYBAHu/74aPcSs4y?=
 =?us-ascii?Q?FTOiVK2peIXcKq6eIHG5LPjYpUQ+8Zm91L5YF+SvHuFe2ZBvnS9wbSTE7ry5?=
 =?us-ascii?Q?OlTyVp5uBZupfF3CQ1DkuJm2F4ERMTLlnePrQK86wgIuRk7r2kQRa78hNvrW?=
 =?us-ascii?Q?0vNu4Gd5eagh4HP17N+506s31Vel+sdDnqqpyoKy387u1+0W8p0tKYlozXCO?=
 =?us-ascii?Q?1EYFzannPwvTN/uNZOdRwT2Vskh12y7NQ/elJIU2DFy/UzrzPiJ3USmzuzwD?=
 =?us-ascii?Q?NgzcilXZqgWQ1wzyCv3S6311FcRV6n5GZmT6Aql6hnCWME5NRftXTcfqZE4O?=
 =?us-ascii?Q?Z94sSUQlVBBKR8ZTF4WGuKzgYigOcxY3zAqxaBUIwXf7CLban8CryvjyUr8/?=
 =?us-ascii?Q?Qz7MPEjX57Wo7RR8z3rXamnvPF1kiw04odlc9XCwoXshiNbTZLjlWFRnsAEL?=
 =?us-ascii?Q?i1x92gDUvPzQS6twpFGI7+jKwOh0d0Tmym8HcRoe7gP4OnUYu+goQgLcK1U5?=
 =?us-ascii?Q?53eiT9y8lC/GxNNW/5boS4lR9LK/gxz2/GgIyGVunOuTvOQydvABHw7xAqwL?=
 =?us-ascii?Q?+j0ac5PV1O4/nU0AJLeRe8FPj49eIJiVYFSVT/hlBRc3sIlOSAP39jLWtTit?=
 =?us-ascii?Q?XaIL+FEUWpxqKJdYSbVC3Fttmq9EzE9Aeu9UHwDpuD0YYM7TmpWkFLowq/o6?=
 =?us-ascii?Q?wyvrFvlJZZ++YBdkfPfggjIz34X6/6R5Osxot4zPn3vmzyCsD5K5tqzwOA9o?=
 =?us-ascii?Q?g1l7dfJdbRt0Sm3jZP2C0fz4/BNpVzfeR/+tRF4c2GR3yNc+5doHZZJ39gc+?=
 =?us-ascii?Q?pX/4WCc1hNxqSsXYBAw9oXOD4QptyWk15lF0j1GTG5Fw3Ck4ZBLQquulFmvv?=
 =?us-ascii?Q?S08u0oUSczzYMcpe3P/zx51OSQDaZHZjawYlqP5wRSxoFuq3YgYo3XzgJk5O?=
 =?us-ascii?Q?yFS3BKsOvnHPiP3gBhl+U9WvvmLPHzGXKhyie/GxG4cV03lAoVOnUN856+Ab?=
 =?us-ascii?Q?gcaigBKwbTOrPFO4Kp5TPRTDf+1ZjarxZNUDEMgXE5orGOGapFU54f3nZ1TM?=
 =?us-ascii?Q?5OQmipUeHfREwa9RSkTxeRR6YE3TXmsja/vYBPEaLQLyXo7wTvTYYf1trs5u?=
 =?us-ascii?Q?Q+EwBkx2SutDIQRbtl7Sj4QlmHH5EJggvonlMQ4WXLMef4fr8rzQcw2x92Qk?=
 =?us-ascii?Q?zZm1S6e2ydJMHAHpJZJOnWbMbv3VX0qMh136+qTCklr4+snHS65EmSCBWXsJ?=
 =?us-ascii?Q?8ylVaBb4MDr8aYrThXrFFyTbPHERDi8GA2CXcCR7WbVeQbq8biDKuKlUfb+a?=
 =?us-ascii?Q?1RPvJMOTx54XCpTs9SgjNfwmMBWCrG0pTBXy?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 12:13:06.6021
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc1d74d4-ac1f-4f95-13e9-08dd7c16e155
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8353

FDB entries are currently stored in a hash table with a fixed number of
buckets (256), resulting in performance degradation as the number of
entries grows. Solve this by converting the driver to use rhashtable
which maintains more or less constant performance regardless of the
number of entries.

Measured transmitted packets per second using a single pktgen thread
with varying number of entries when the transmitted packet always hits
the default entry (worst case):

Number of entries | Improvement
------------------|------------
1k                | +1.12%
4k                | +9.22%
16k               | +55%
64k               | +585%
256k              | +2460%

In addition, the change reduces the size of the VXLAN device structure
from 2584 bytes to 672 bytes.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/vxlan/vxlan_core.c    | 102 ++++++++++++------------------
 drivers/net/vxlan/vxlan_private.h |   2 +-
 include/net/vxlan.h               |   2 +-
 3 files changed, 43 insertions(+), 63 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 8e359cf8dbbd..a56d7239b127 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -15,6 +15,7 @@
 #include <linux/igmp.h>
 #include <linux/if_ether.h>
 #include <linux/ethtool.h>
+#include <linux/rhashtable.h>
 #include <net/arp.h>
 #include <net/ndisc.h>
 #include <net/gro.h>
@@ -63,8 +64,12 @@ static int vxlan_sock_add(struct vxlan_dev *vxlan);
 
 static void vxlan_vs_del_dev(struct vxlan_dev *vxlan);
 
-/* salt for hash table */
-static u32 vxlan_salt __read_mostly;
+static const struct rhashtable_params vxlan_fdb_rht_params = {
+	.head_offset = offsetof(struct vxlan_fdb, rhnode),
+	.key_offset = offsetof(struct vxlan_fdb, key),
+	.key_len = sizeof(struct vxlan_fdb_key),
+	.automatic_shrinking = true,
+};
 
 static inline bool vxlan_collect_metadata(struct vxlan_sock *vs)
 {
@@ -371,62 +376,21 @@ static void vxlan_fdb_miss(struct vxlan_dev *vxlan, const u8 eth_addr[ETH_ALEN])
 	vxlan_fdb_notify(vxlan, &f, &remote, RTM_GETNEIGH, true, NULL);
 }
 
-/* Hash Ethernet address */
-static u32 eth_hash(const unsigned char *addr)
-{
-	u64 value = get_unaligned((u64 *)addr);
-
-	/* only want 6 bytes */
-#ifdef __BIG_ENDIAN
-	value >>= 16;
-#else
-	value <<= 16;
-#endif
-	return hash_64(value, FDB_HASH_BITS);
-}
-
-u32 eth_vni_hash(const unsigned char *addr, __be32 vni)
-{
-	/* use 1 byte of OUI and 3 bytes of NIC */
-	u32 key = get_unaligned((u32 *)(addr + 2));
-
-	return jhash_2words(key, vni, vxlan_salt) & (FDB_HASH_SIZE - 1);
-}
-
-u32 fdb_head_index(struct vxlan_dev *vxlan, const u8 *mac, __be32 vni)
-{
-	if (vxlan->cfg.flags & VXLAN_F_COLLECT_METADATA)
-		return eth_vni_hash(mac, vni);
-	else
-		return eth_hash(mac);
-}
-
-/* Hash chain to use given mac address */
-static inline struct hlist_head *vxlan_fdb_head(struct vxlan_dev *vxlan,
-						const u8 *mac, __be32 vni)
-{
-	return &vxlan->fdb_head[fdb_head_index(vxlan, mac, vni)];
-}
-
 /* Look up Ethernet address in forwarding table */
 static struct vxlan_fdb *vxlan_find_mac_rcu(struct vxlan_dev *vxlan,
 					    const u8 *mac, __be32 vni)
 {
-	struct hlist_head *head = vxlan_fdb_head(vxlan, mac, vni);
-	struct vxlan_fdb *f;
+	struct vxlan_fdb_key key;
 
-	hlist_for_each_entry_rcu(f, head, hlist) {
-		if (ether_addr_equal(mac, f->key.eth_addr)) {
-			if (vxlan->cfg.flags & VXLAN_F_COLLECT_METADATA) {
-				if (vni == f->key.vni)
-					return f;
-			} else {
-				return f;
-			}
-		}
-	}
+	memset(&key, 0, sizeof(key));
+	memcpy(key.eth_addr, mac, sizeof(key.eth_addr));
+	if (!(vxlan->cfg.flags & VXLAN_F_COLLECT_METADATA))
+		key.vni = vxlan->default_dst.remote_vni;
+	else
+		key.vni = vni;
 
-	return NULL;
+	return rhashtable_lookup(&vxlan->fdb_hash_tbl, &key,
+				 vxlan_fdb_rht_params);
 }
 
 static struct vxlan_fdb *vxlan_find_mac_tx(struct vxlan_dev *vxlan,
@@ -915,15 +879,27 @@ int vxlan_fdb_create(struct vxlan_dev *vxlan,
 	if (rc < 0)
 		goto errout;
 
+	rc = rhashtable_lookup_insert_fast(&vxlan->fdb_hash_tbl, &f->rhnode,
+					   vxlan_fdb_rht_params);
+	if (rc)
+		goto destroy_remote;
+
 	++vxlan->addrcnt;
-	hlist_add_head_rcu(&f->hlist,
-			   vxlan_fdb_head(vxlan, mac, src_vni));
 	hlist_add_head_rcu(&f->fdb_node, &vxlan->fdb_list);
 
 	*fdb = f;
 
 	return 0;
 
+destroy_remote:
+	if (rcu_access_pointer(f->nh)) {
+		list_del_rcu(&f->nh_list);
+		nexthop_put(rtnl_dereference(f->nh));
+	} else {
+		list_del(&rd->list);
+		dst_cache_destroy(&rd->dst_cache);
+		kfree(rd);
+	}
 errout:
 	kfree(f);
 	return rc;
@@ -974,7 +950,8 @@ static void vxlan_fdb_destroy(struct vxlan_dev *vxlan, struct vxlan_fdb *f,
 	}
 
 	hlist_del_init_rcu(&f->fdb_node);
-	hlist_del_rcu(&f->hlist);
+	rhashtable_remove_fast(&vxlan->fdb_hash_tbl, &f->rhnode,
+			       vxlan_fdb_rht_params);
 	list_del_rcu(&f->nh_list);
 	call_rcu(&f->rcu, vxlan_fdb_free);
 }
@@ -2898,10 +2875,14 @@ static int vxlan_init(struct net_device *dev)
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 	int err;
 
+	err = rhashtable_init(&vxlan->fdb_hash_tbl, &vxlan_fdb_rht_params);
+	if (err)
+		return err;
+
 	if (vxlan->cfg.flags & VXLAN_F_VNIFILTER) {
 		err = vxlan_vnigroup_init(vxlan);
 		if (err)
-			return err;
+			goto err_rhashtable_destroy;
 	}
 
 	err = gro_cells_init(&vxlan->gro_cells, dev);
@@ -2920,6 +2901,8 @@ static int vxlan_init(struct net_device *dev)
 err_vnigroup_uninit:
 	if (vxlan->cfg.flags & VXLAN_F_VNIFILTER)
 		vxlan_vnigroup_uninit(vxlan);
+err_rhashtable_destroy:
+	rhashtable_destroy(&vxlan->fdb_hash_tbl);
 	return err;
 }
 
@@ -2933,6 +2916,8 @@ static void vxlan_uninit(struct net_device *dev)
 		vxlan_vnigroup_uninit(vxlan);
 
 	gro_cells_destroy(&vxlan->gro_cells);
+
+	rhashtable_destroy(&vxlan->fdb_hash_tbl);
 }
 
 /* Start ageing timer and join group when device is brought up */
@@ -3329,7 +3314,6 @@ static void vxlan_offload_rx_ports(struct net_device *dev, bool push)
 static void vxlan_setup(struct net_device *dev)
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
-	unsigned int h;
 
 	eth_hw_addr_random(dev);
 	ether_setup(dev);
@@ -3362,8 +3346,6 @@ static void vxlan_setup(struct net_device *dev)
 
 	vxlan->dev = dev;
 
-	for (h = 0; h < FDB_HASH_SIZE; ++h)
-		INIT_HLIST_HEAD(&vxlan->fdb_head[h]);
 	INIT_HLIST_HEAD(&vxlan->fdb_list);
 }
 
@@ -4944,8 +4926,6 @@ static int __init vxlan_init_module(void)
 {
 	int rc;
 
-	get_random_bytes(&vxlan_salt, sizeof(vxlan_salt));
-
 	rc = register_pernet_subsys(&vxlan_net_ops);
 	if (rc)
 		goto out1;
diff --git a/drivers/net/vxlan/vxlan_private.h b/drivers/net/vxlan/vxlan_private.h
index 3ca19e7167c9..d328aed9feef 100644
--- a/drivers/net/vxlan/vxlan_private.h
+++ b/drivers/net/vxlan/vxlan_private.h
@@ -31,7 +31,7 @@ struct vxlan_fdb_key {
 
 /* Forwarding table entry */
 struct vxlan_fdb {
-	struct hlist_node hlist;	/* linked list of entries */
+	struct rhash_head rhnode;
 	struct rcu_head	  rcu;
 	unsigned long	  updated;	/* jiffies */
 	unsigned long	  used;
diff --git a/include/net/vxlan.h b/include/net/vxlan.h
index 96a6c6f45c2e..e2f7ca045d3e 100644
--- a/include/net/vxlan.h
+++ b/include/net/vxlan.h
@@ -304,7 +304,7 @@ struct vxlan_dev {
 
 	struct vxlan_vni_group  __rcu *vnigrp;
 
-	struct hlist_head fdb_head[FDB_HASH_SIZE];
+	struct rhashtable fdb_hash_tbl;
 
 	struct rhashtable mdb_tbl;
 	struct hlist_head fdb_list;
-- 
2.49.0


