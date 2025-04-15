Return-Path: <netdev+bounces-182755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 084ECA89D45
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 14:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C15FF189F7FD
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 12:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7AB2951C5;
	Tue, 15 Apr 2025 12:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y4Vr+1/A"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CEB2951AA
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 12:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744719171; cv=fail; b=Afcc9Hw/LnY8XnqjotowTVQVEiPElniw58Vpx8XRT+GPn1An3zOTQuypWj17tH97yVvrezuO3OISZ05dAcsnyPsrQbde4W0uaYSNjkoDU6teWxwjmzKMySSqd3F1byAq/fBue2UrvRYiyfVUqAVRWYi93oDDKSeiBk8JVHKTJnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744719171; c=relaxed/simple;
	bh=3Pbpi/1W3gO9E9iCbwz47BTZhfna+AtkhqBALdORMts=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GxvXX1dd1qmTN1R2nMl3SlwfNfkYOLuDY+5qfgC0/SC8h3uBoyj1ihkhWhUbAUoDJ9Rwztj/KOX6dXcSIYusSNNmD+OTR4W55N8iC9dUIaG+34h1dxpXxPW9/1VB4/+RuFNL6QIrCDZRKmWm9cHxHY3tBePKswzf987BseP+xAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y4Vr+1/A; arc=fail smtp.client-ip=40.107.94.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HE4NM9zKdXc41B/APYYwjdN+kcrX3WzZL6CkCjSCkgG144GLKpNZ9f+oYvv1eKXqsJzOdYugq/C3PhmYcjz+M8ikj0muf/F2CrvPWbVrBpLTeiatbg+QrDxv38taqB1qQYHd6R+CgqAKRXOiDGKs/p9jZXTyNhLqkq8N4DfTbqSkS1b0xowGG46EQPP2jiIywDIem6A8UrnDvh+Qtman9BeiAqdu0q1kBSQf7UpeANjQ4gEGG4o/nFlJjhW1/HUBSzRl82oHyMHf5A43mAdoHsWVVLw/aDtIP2f77lfwyIGvhYOhd4WYI9UW5+AAJTWnZdQbgUhdOpn224lV53n9JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DieetaDohmAZgFza4+jwcu7hk/qd1wEFzMTlz4HR/+0=;
 b=jRotvoqoEC6GFKDvWV+qBXfbWni9L89ZPRXHvosepERXIyrYVXvT7CbTUSOJp6SMLPlnpVx0Pa6lIDl0vLBQ+YSMkIIKgNRoBkqy7TUEcZS6xJFxyRjGXhUw+j++GUrzsKC7hqk5FwbncXNn/EE6KkoOHjPyKPHAv0j3zx4CxqNe1LMLNxfyhT7u8NMsG/2inp4vAaAGBNOwdm5D9iN8Smtmnrz6aevg75KuGi8R1gyxy714PHYkzWNkM+t44GTQhhXxt0TZkPHH1d+ienzAnkAit+aaHpQtVMsTRPxuOQ5a9E+FPEYmAM/yjv/YBkrxHzLNOIxnj7UtPhVDUaIuuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DieetaDohmAZgFza4+jwcu7hk/qd1wEFzMTlz4HR/+0=;
 b=Y4Vr+1/AHZ7s/NM9hsI7++xgb6CmH7lgDxiWPfJr/Aqn3XmVRGQBcWAM1NG42+TRDpysMRlNs9czJ5jjFSMtP/lQxkmFaXlF4DbWE+/2ejORUM7mUIdqBL71kN0QUDO1lJpn6wWBXcYJ+6Tuyd+d+YLY39rbY2/TkCZhJui2x9Surh6mLKvd1b8H9sX+AKJUbmHYEL4zAXpWxkwRznDkklNBjudStQKcdTrVVq3gQzgQ+FotyUFnJp9eucDkUnwbX4TYmHcltnLIRMI0IycSCzbG1H+BlcCCdxATT7+3uYH1rSEnrIymx63pPKSuPvwNtfoe5mBZUseypW9v+Cingw==
Received: from BN9PR03CA0226.namprd03.prod.outlook.com (2603:10b6:408:f8::21)
 by IA1PR12MB6529.namprd12.prod.outlook.com (2603:10b6:208:3a6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.21; Tue, 15 Apr
 2025 12:12:42 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:408:f8:cafe::44) by BN9PR03CA0226.outlook.office365.com
 (2603:10b6:408:f8::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Tue,
 15 Apr 2025 12:12:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 12:12:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Apr
 2025 05:12:30 -0700
Received: from shredder.lan (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 15 Apr
 2025 05:12:26 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<petrm@nvidia.com>, <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 08/15] vxlan: Use linked list to traverse FDB entries
Date: Tue, 15 Apr 2025 15:11:36 +0300
Message-ID: <20250415121143.345227-9-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|IA1PR12MB6529:EE_
X-MS-Office365-Filtering-Correlation-Id: e6ed1a83-d281-4d05-6b6a-08dd7c16d2be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m8xXqMf2096aACmFb6isHT2IuCzDTSsJaRiLjktgQSaO5iqElwFoeB7Agut8?=
 =?us-ascii?Q?S60cvBhzMK9/56t1Y5+D4A+xZ/a+A8haOsNIQ3sGYoQlthO2vY4U2sq0x9Ar?=
 =?us-ascii?Q?hB1nl1NpW26mJPFT+76cNjYBIrqqpKJxrW/S/14t6wVFAL8Hn0zsZdPFhKTK?=
 =?us-ascii?Q?HmSKj9iLsSk5YSb1NxcKburxpou92p6h+hh6BN9Ay2g8LHWh39j+/X9T+not?=
 =?us-ascii?Q?CkM8MYN4md4LI+Uhs2aQCyHIvVF2CjThvq3Dm1f3UDsptrJPbObBEkIIbEa5?=
 =?us-ascii?Q?e5Lb3mw9hYTR4gVo1tvs9C6NBP3hfEOkV4WxM0zfHcYLVPhgnCeRP2KqXfsI?=
 =?us-ascii?Q?e8ucYmCWEugfbS/8MnIgo1U/iw4kYP834McykO27zYpfHH7a/U68COoQtpyp?=
 =?us-ascii?Q?DFSYZkXGIlIhbzwSBkKZFb0cPtMzsvFQDc62LSJI7RZYdXwMYDkd15LpfVSk?=
 =?us-ascii?Q?DSTlQymY3rR3WsqNudipx+7PQDkN8jsU3SXMwVnTZgrXq3nye4ZxskltrGZy?=
 =?us-ascii?Q?uCPxCBW5YTtxL/wIao7lCI1hUcd8R/zzpvb2MsNNelqjBolz46aRcUsBp40i?=
 =?us-ascii?Q?5hehW261fQDKsTGcRmQ59q/lQ0cSsb+Qtz9i2/+Rwr6fseNMqV3pQpJkJhLL?=
 =?us-ascii?Q?NGeWwac/94M6HfSfAYb5ztmj6KRORzpTP6LjgBFsI3O4w8zUM1E7Pr3rIiN/?=
 =?us-ascii?Q?KfSRM56xkCEvahFVciICJfaFTDryHIdrLMM6cQq+TRkbXXliVpb+2sJ23slr?=
 =?us-ascii?Q?v82wkZA1bqM4u62AJ2im/ofEz1bLyAVkCFtpMMij4AFL91LOSpDy0qOKc/n8?=
 =?us-ascii?Q?cKZsZ8gwsvoE5S0oJP6VJ1q4QhxYYI5aoE/KkrYJzJZ30gAYtxhb1jOxRCRp?=
 =?us-ascii?Q?HbyYXP8uiWEuJk7Z1S0IWbUgrs5NQer+b2dO+WTsSxYDwPTA6yE9l6R7wJDW?=
 =?us-ascii?Q?iCs6Bjd0UXn+TqHHeSLGcXAGnxZbu1Rffqqifls2Pe2HnC5SkG5nUfqV+F4O?=
 =?us-ascii?Q?HoOAq0dc5aXkEoY1xH1vhPfYCTBBl09tLg8rCXXxFr7OtYCKPkEKnbtvRAbc?=
 =?us-ascii?Q?t1MTSPpYTdB5DOrjkNCQyPQRMA3mVQ/569dWfT0Ml6Q5VQ/OeSc40/b7ZhLT?=
 =?us-ascii?Q?dnYEhdt03imez+2fc/PdV8Id61U2QODqGpaY1u78f6zeJKLgDidebbG9jfRE?=
 =?us-ascii?Q?ybbWKlNNwHTKXdC9xnpj+GUlfnB5OaAjypkMW4iaaIpD87/T1Ga+Ex9n08sp?=
 =?us-ascii?Q?DRtvfops/MWMMk7+OFFj7BR0//ZKHMJZ0WJJo3n/qs8wM5eYx1NkW7mpT8Tc?=
 =?us-ascii?Q?dsN/qm9D+mQrVyxBW825aNTCp5HDayV35XmKN2YqnoGT/h7xS+aMLLUvBPiQ?=
 =?us-ascii?Q?UQGZ4x09LIhoAZDSs8bTscUHY/Avjhpg0B2Y94m432iUj28Gm90wHYYc/7EZ?=
 =?us-ascii?Q?g/aAamJChJI0nD3DzEF212qaJd7zYKXms0iRJ+oqZ6DFy0UlSTa+ir7jz2wD?=
 =?us-ascii?Q?NH/cjo33rDey4dJySe4a1v7jJPIF1XICSTs6?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 12:12:42.1266
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6ed1a83-d281-4d05-6b6a-08dd7c16d2be
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6529

In preparation for removing the fixed size hash table, convert FDB entry
traversal to use the newly added FDB linked list.

No functional changes intended.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/vxlan/vxlan_core.c | 172 ++++++++++++++-------------------
 1 file changed, 75 insertions(+), 97 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 511c24e29d45..f9840a4b6e44 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -517,7 +517,6 @@ int vxlan_fdb_replay(const struct net_device *dev, __be32 vni,
 	struct vxlan_dev *vxlan;
 	struct vxlan_rdst *rdst;
 	struct vxlan_fdb *f;
-	unsigned int h;
 	int rc = 0;
 
 	if (!netif_is_vxlan(dev))
@@ -525,16 +524,13 @@ int vxlan_fdb_replay(const struct net_device *dev, __be32 vni,
 	vxlan = netdev_priv(dev);
 
 	spin_lock_bh(&vxlan->hash_lock);
-	for (h = 0; h < FDB_HASH_SIZE; ++h) {
-		hlist_for_each_entry(f, &vxlan->fdb_head[h], hlist) {
-			if (f->vni == vni) {
-				list_for_each_entry(rdst, &f->remotes, list) {
-					rc = vxlan_fdb_notify_one(nb, vxlan,
-								  f, rdst,
-								  extack);
-					if (rc)
-						goto unlock;
-				}
+	hlist_for_each_entry(f, &vxlan->fdb_list, fdb_node) {
+		if (f->vni == vni) {
+			list_for_each_entry(rdst, &f->remotes, list) {
+				rc = vxlan_fdb_notify_one(nb, vxlan, f, rdst,
+							  extack);
+				if (rc)
+					goto unlock;
 			}
 		}
 	}
@@ -552,18 +548,17 @@ void vxlan_fdb_clear_offload(const struct net_device *dev, __be32 vni)
 	struct vxlan_dev *vxlan;
 	struct vxlan_rdst *rdst;
 	struct vxlan_fdb *f;
-	unsigned int h;
 
 	if (!netif_is_vxlan(dev))
 		return;
 	vxlan = netdev_priv(dev);
 
 	spin_lock_bh(&vxlan->hash_lock);
-	for (h = 0; h < FDB_HASH_SIZE; ++h) {
-		hlist_for_each_entry(f, &vxlan->fdb_head[h], hlist)
-			if (f->vni == vni)
-				list_for_each_entry(rdst, &f->remotes, list)
-					rdst->offloaded = false;
+	hlist_for_each_entry(f, &vxlan->fdb_list, fdb_node) {
+		if (f->vni == vni) {
+			list_for_each_entry(rdst, &f->remotes, list)
+				rdst->offloaded = false;
+		}
 	}
 	spin_unlock_bh(&vxlan->hash_lock);
 
@@ -1351,52 +1346,46 @@ static int vxlan_fdb_dump(struct sk_buff *skb, struct netlink_callback *cb,
 {
 	struct ndo_fdb_dump_context *ctx = (void *)cb->ctx;
 	struct vxlan_dev *vxlan = netdev_priv(dev);
-	unsigned int h;
+	struct vxlan_fdb *f;
 	int err = 0;
 
-	for (h = 0; h < FDB_HASH_SIZE; ++h) {
-		struct vxlan_fdb *f;
-
-		rcu_read_lock();
-		hlist_for_each_entry_rcu(f, &vxlan->fdb_head[h], hlist) {
-			struct vxlan_rdst *rd;
-
-			if (rcu_access_pointer(f->nh)) {
-				if (*idx < ctx->fdb_idx)
-					goto skip_nh;
-				err = vxlan_fdb_info(skb, vxlan, f,
-						     NETLINK_CB(cb->skb).portid,
-						     cb->nlh->nlmsg_seq,
-						     RTM_NEWNEIGH,
-						     NLM_F_MULTI, NULL);
-				if (err < 0) {
-					rcu_read_unlock();
-					goto out;
-				}
-skip_nh:
-				*idx += 1;
-				continue;
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(f, &vxlan->fdb_list, fdb_node) {
+		struct vxlan_rdst *rd;
+
+		if (rcu_access_pointer(f->nh)) {
+			if (*idx < ctx->fdb_idx)
+				goto skip_nh;
+			err = vxlan_fdb_info(skb, vxlan, f,
+					     NETLINK_CB(cb->skb).portid,
+					     cb->nlh->nlmsg_seq,
+					     RTM_NEWNEIGH, NLM_F_MULTI, NULL);
+			if (err < 0) {
+				rcu_read_unlock();
+				goto out;
 			}
+skip_nh:
+			*idx += 1;
+			continue;
+		}
 
-			list_for_each_entry_rcu(rd, &f->remotes, list) {
-				if (*idx < ctx->fdb_idx)
-					goto skip;
-
-				err = vxlan_fdb_info(skb, vxlan, f,
-						     NETLINK_CB(cb->skb).portid,
-						     cb->nlh->nlmsg_seq,
-						     RTM_NEWNEIGH,
-						     NLM_F_MULTI, rd);
-				if (err < 0) {
-					rcu_read_unlock();
-					goto out;
-				}
-skip:
-				*idx += 1;
+		list_for_each_entry_rcu(rd, &f->remotes, list) {
+			if (*idx < ctx->fdb_idx)
+				goto skip;
+
+			err = vxlan_fdb_info(skb, vxlan, f,
+					     NETLINK_CB(cb->skb).portid,
+					     cb->nlh->nlmsg_seq,
+					     RTM_NEWNEIGH, NLM_F_MULTI, rd);
+			if (err < 0) {
+				rcu_read_unlock();
+				goto out;
 			}
+skip:
+			*idx += 1;
 		}
-		rcu_read_unlock();
 	}
+	rcu_read_unlock();
 out:
 	return err;
 }
@@ -2830,35 +2819,30 @@ static void vxlan_cleanup(struct timer_list *t)
 {
 	struct vxlan_dev *vxlan = from_timer(vxlan, t, age_timer);
 	unsigned long next_timer = jiffies + FDB_AGE_INTERVAL;
-	unsigned int h;
+	struct hlist_node *n;
+	struct vxlan_fdb *f;
 
 	if (!netif_running(vxlan->dev))
 		return;
 
 	spin_lock(&vxlan->hash_lock);
-	for (h = 0; h < FDB_HASH_SIZE; ++h) {
-		struct hlist_node *p, *n;
-
-		hlist_for_each_safe(p, n, &vxlan->fdb_head[h]) {
-			struct vxlan_fdb *f
-				= container_of(p, struct vxlan_fdb, hlist);
-			unsigned long timeout;
+	hlist_for_each_entry_safe(f, n, &vxlan->fdb_list, fdb_node) {
+		unsigned long timeout;
 
-			if (f->state & (NUD_PERMANENT | NUD_NOARP))
-				continue;
+		if (f->state & (NUD_PERMANENT | NUD_NOARP))
+			continue;
 
-			if (f->flags & NTF_EXT_LEARNED)
-				continue;
+		if (f->flags & NTF_EXT_LEARNED)
+			continue;
 
-			timeout = READ_ONCE(f->updated) + vxlan->cfg.age_interval * HZ;
-			if (time_before_eq(timeout, jiffies)) {
-				netdev_dbg(vxlan->dev,
-					   "garbage collect %pM\n",
-					   f->eth_addr);
-				f->state = NUD_STALE;
-				vxlan_fdb_destroy(vxlan, f, true, true);
-			} else if (time_before(timeout, next_timer))
-				next_timer = timeout;
+		timeout = READ_ONCE(f->updated) + vxlan->cfg.age_interval * HZ;
+		if (time_before_eq(timeout, jiffies)) {
+			netdev_dbg(vxlan->dev, "garbage collect %pM\n",
+				   f->eth_addr);
+			f->state = NUD_STALE;
+			vxlan_fdb_destroy(vxlan, f, true, true);
+		} else if (time_before(timeout, next_timer)) {
+			next_timer = timeout;
 		}
 	}
 	spin_unlock(&vxlan->hash_lock);
@@ -3050,31 +3034,25 @@ static void vxlan_flush(struct vxlan_dev *vxlan,
 			const struct vxlan_fdb_flush_desc *desc)
 {
 	bool match_remotes = vxlan_fdb_flush_should_match_remotes(desc);
-	unsigned int h;
+	struct hlist_node *n;
+	struct vxlan_fdb *f;
 
 	spin_lock_bh(&vxlan->hash_lock);
-	for (h = 0; h < FDB_HASH_SIZE; ++h) {
-		struct hlist_node *p, *n;
-
-		hlist_for_each_safe(p, n, &vxlan->fdb_head[h]) {
-			struct vxlan_fdb *f
-				= container_of(p, struct vxlan_fdb, hlist);
-
-			if (!vxlan_fdb_flush_matches(f, vxlan, desc))
-				continue;
-
-			if (match_remotes) {
-				bool destroy_fdb = false;
+	hlist_for_each_entry_safe(f, n, &vxlan->fdb_list, fdb_node) {
+		if (!vxlan_fdb_flush_matches(f, vxlan, desc))
+			continue;
 
-				vxlan_fdb_flush_match_remotes(f, vxlan, desc,
-							      &destroy_fdb);
+		if (match_remotes) {
+			bool destroy_fdb = false;
 
-				if (!destroy_fdb)
-					continue;
-			}
+			vxlan_fdb_flush_match_remotes(f, vxlan, desc,
+						      &destroy_fdb);
 
-			vxlan_fdb_destroy(vxlan, f, true, true);
+			if (!destroy_fdb)
+				continue;
 		}
+
+		vxlan_fdb_destroy(vxlan, f, true, true);
 	}
 	spin_unlock_bh(&vxlan->hash_lock);
 }
@@ -4860,7 +4838,7 @@ static void vxlan_fdb_nh_flush(struct nexthop *nh)
 		vxlan = rcu_dereference(fdb->vdev);
 		WARN_ON(!vxlan);
 		spin_lock_bh(&vxlan->hash_lock);
-		if (!hlist_unhashed(&fdb->hlist))
+		if (!hlist_unhashed(&fdb->fdb_node))
 			vxlan_fdb_destroy(vxlan, fdb, false, false);
 		spin_unlock_bh(&vxlan->hash_lock);
 	}
-- 
2.49.0


