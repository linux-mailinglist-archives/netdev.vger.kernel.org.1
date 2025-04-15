Return-Path: <netdev+bounces-182759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DABEA89D4A
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 14:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13C7D189CD05
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 12:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576772957DF;
	Tue, 15 Apr 2025 12:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hkp65WNK"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B2C2949F8
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 12:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744719179; cv=fail; b=slmJN3LO7Uscwwi7kdkn1mlhCZCq7nu5tcpkhJVpkyufIbkJG87ivRREUotzYPwMolUNhpTT7Tce67R7pcpom9po5hp0WH3IxLmeos7qOWkZw7cFF+M/NB4/0QVNo45VceLe+LiLozLww0aiohJqUzH4ZHZdFtGxvGPQv5DqrV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744719179; c=relaxed/simple;
	bh=Qz9uSWQ0oPoAJoqAT1n2RGxEmYphWobEdhkrDApl8uM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UbmEcGoIybae/kfdb7I9Wg3H/56SldJu2uwRboDNH4S29eqByYymzNena+hm67d66DFbg2JuDlzETOBK2Wx03oD8K1kn7GYlBxCliHKSzXEz6GpcJMpReyBGHR6GUy0Yas+fsMCC0FLXVt26eUTfN2lEPz9LHKT8q3PMBVNjDZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hkp65WNK; arc=fail smtp.client-ip=40.107.93.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LAPeD+gqn5H65IVbco8Z6inRineSYw4+NgDRK22k3VktTn8TBlNo4OPoAkMgEyLABygsiUdcHc8k4w4kRv37QSAs+Zip0MemC7edzSd9tv5/vb9oD9wD7cFHdUBHMY8eKq5j2HgcgDae54kyPXHWNRoiJTFBHQyspFZ7t6B7qwzwDMxLhXoJEu3RD5D84Xn9TPz1IBmdOLroOXSmX5KNI5DSb7a/sfyVvhl+6zbxHhST2ms2n0AHd3NttZLSVfHhP0HLKN8KsugUCJgU6EarfjaA/r+ocAMZyxTJm9vFtMWpKr/4Sgu++r+Oi2nojzj5EWdmNEQIPCroqcgPXsArMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=emjXgq01wcIPHoof2pbP5u9W5cFoL1DqycRexAB/X0k=;
 b=CtF1BeWIkQo4GQvRKfnR97ojy9OGuTe4OwAnKH+C99cUeCpiLfSJGYqdsp+MHG6/X84jDDW0fLdeFN99yy8NqIF2NNdl+Il9DeEJJxpm7tIxf38s/t2K0FQFmvabDFkwEPBdvYfze5EbyrE1+wT51cw6a1BuHR2HgpRdfGusPRvxbtknzCPo1v+c/poZHQK1y5JOB8hBL4JbM+mIKlErXHs9usocyevB53PjY1Apqo4sQKmZQOOgSoqKBAoFytdcsvmeYW2vu56/IVx9cGVsidqP5xqLXR/CJCvD7cHBkWBrYRVFq2oL7iFo+uf4m69v7Pwp33RM+oP1NvPsQcxLrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=emjXgq01wcIPHoof2pbP5u9W5cFoL1DqycRexAB/X0k=;
 b=hkp65WNK25Eh9MtY49N53oHtw0STazFg7pTjVBoUFMCvxrXwAaaU6Li8NEYni1hSELn52uZAS66X2DFdcJLeVEFm0vuJK/jm9NsSpVmAwRMDU6Uq2ksKHHeMs3fCk+k9GeJ1PDZz13C+sIz9vvMtktlXQNeJBemIpvSsJsl83x4cdvxUueEEmg5hCYUkbNDJNy7of8AAObYrutMwBG7k9iO+am+d6KTUq1hBY+lsjkuz3ud4jr6oYJRnjGOSu6DqgqXT3n4QEvzkFMfjpxNDXZAKhgNzU3lWbbr9eBtKKDEXdmdfML8MDyGWt4UVXWD3OkT8SYrb7V3sHA2D0sg5gA==
Received: from PH8PR07CA0011.namprd07.prod.outlook.com (2603:10b6:510:2cd::19)
 by MN2PR12MB4389.namprd12.prod.outlook.com (2603:10b6:208:262::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Tue, 15 Apr
 2025 12:12:53 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:510:2cd:cafe::49) by PH8PR07CA0011.outlook.office365.com
 (2603:10b6:510:2cd::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.15 via Frontend Transport; Tue,
 15 Apr 2025 12:12:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 12:12:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Apr
 2025 05:12:43 -0700
Received: from shredder.lan (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 15 Apr
 2025 05:12:40 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<petrm@nvidia.com>, <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 12/15] vxlan: Create wrappers for FDB lookup
Date: Tue, 15 Apr 2025 15:11:40 +0300
Message-ID: <20250415121143.345227-13-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|MN2PR12MB4389:EE_
X-MS-Office365-Filtering-Correlation-Id: ebf04395-f939-4e82-9a33-08dd7c16d8e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NlfGswJBio/FeqmPRj8ukV46DkV5dGcoSGOHG6E/5+7nPHCwPh5db9Ai4XA6?=
 =?us-ascii?Q?xiJ8/8YETNxcqOQ+1tAyO9SijbOmqtIH9BTfi3ccNnRaB/oC2VgXVl+mD0vq?=
 =?us-ascii?Q?PS9njklZZDuFPvJzVtO+6v8mP3YUpKsdD0Z8dkFbrJR9LdVPgw8R442BzQ98?=
 =?us-ascii?Q?IO/PrT75NXKnvdVvHdjVl1bDdD7zM+WDhkkw8AWWsdS7ysSI9uTiArLOwpOs?=
 =?us-ascii?Q?21+k6isFHQecDrBDDccjfJ5STP/GRHclt0BbeaD8JEbA//h1QZuZG+e0mFz6?=
 =?us-ascii?Q?KiLerY9ehejaYLF7c65YvTJJ5682ge5+kzkVmybG/YCk83LgZDDc9Kt0UvMl?=
 =?us-ascii?Q?Vtdga6n6n6rgNMYNADQMVen4DGN9lQ9j5BmXnyuHL95bFhEw69jievnwxBLZ?=
 =?us-ascii?Q?hmPZV8jlpBacA3UtOacVQOkJB+3tHabz5qPRcYBn2i4rC0hsyRRKYMinxNvL?=
 =?us-ascii?Q?F9cA65Gb0Ky73/zH62sbgtqCYuXtDIUVwi8ylnox/4jBq7O0bdMq1z6oD25H?=
 =?us-ascii?Q?pesVWOp75RWlc12wu9/gJA1G32yOmQuF6naFyIazu2rCo9I9BUXrq905wcyy?=
 =?us-ascii?Q?pScVm+/yBkQyafbblESLzB4km7wrLmK1w5vvRiqaAW4h0E/LgbEjZao5ZzBa?=
 =?us-ascii?Q?ZArUFP7CeprcU2HWwL3qUSAwqdFTlYWv9+/jzCTLXi3ryFUXb/eQZyGZNABY?=
 =?us-ascii?Q?CgX3yG722CViL6NceXonXZeKkKaI5HHId007df/IaUhC8EcJvuS9WhT0LVl8?=
 =?us-ascii?Q?se840y50bRsldE70AiC0W8IXGUrEj+XF/vPDq/Bav7a44GSWOBWAEd4IWPEq?=
 =?us-ascii?Q?DQPpC1VVwDvgNwEu0xpP3p22CUoucSHEWi+gWIX7g3KPngUDD2brU6aUiFN3?=
 =?us-ascii?Q?EOWzq/odGjPxSITVvD+MX0dvPmqvB/jcMP+j0NgmBU1w/Myn+orYlJCaBzU/?=
 =?us-ascii?Q?2Y1UWKiSbhjn1teYd/F+5yHFFVkK1c24iCrSWbRjxlStY4GP/fHytLBmowqy?=
 =?us-ascii?Q?dOEjio5jVCC7T84xwzG/SWWulajkM0v9qqUFxGFA8uVHgS1K/hxkpC7/cWr0?=
 =?us-ascii?Q?YnImhcsLj4skVpzEeehA2g0Y8TyRYx5yrKFO3zoDaFUfT+WBXRsaraM5YZ6s?=
 =?us-ascii?Q?Ufh9BWxde3v3tm20CQJWL9q3Ha4UJAzfLIBAESNwO7fL8i19COgQxQgtr5e/?=
 =?us-ascii?Q?ECtSYr79qEC2tou4frfnYlRlAW7X1JYD/OVbIy8TbPJjnbE7j4Hr2fMXxct4?=
 =?us-ascii?Q?7bsbMCJBpfwOqlCkJwN+4OpuuZ3UBJdZNbIvbxghoy0mfJLXW7zyaKBRUk01?=
 =?us-ascii?Q?Hzlg4Q5kKXVMjxPxy5PvGZYBsk6B5N4jQ5VzqcxygTb8vZWD95qlyoVKaZ7m?=
 =?us-ascii?Q?VU+Dwi6R+ZZ43gbXBb/0YVUybPZjsap4UdUS4pM+6+d/RkcGaBslTQno6ork?=
 =?us-ascii?Q?TppFZhZk9AyDNjJpE/vEmEzn/9gs3nRL873AEuL7HBnvsyAODn0KCoPzaaXn?=
 =?us-ascii?Q?hB8MI21sFx9BM/tL9cTF6SqphKbOFcA/mXKZ?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 12:12:52.5107
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebf04395-f939-4e82-9a33-08dd7c16d8e0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4389

__vxlan_find_mac() is called from both the data path (e.g., during
learning) and the control path (e.g., when replacing an entry). The
function is missing lockdep annotations to make sure that the FDB hash
lock is held during FDB updates.

Rename __vxlan_find_mac() to vxlan_find_mac_rcu() to reflect the fact
that it should be called from an RCU read-side critical section and call
it from vxlan_find_mac() which checks that the FDB hash lock is held.
Change callers to invoke the appropriate function.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/vxlan/vxlan_core.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 397b1691ab06..2846c8c5234e 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -409,8 +409,8 @@ static inline struct hlist_head *vxlan_fdb_head(struct vxlan_dev *vxlan,
 }
 
 /* Look up Ethernet address in forwarding table */
-static struct vxlan_fdb *__vxlan_find_mac(struct vxlan_dev *vxlan,
-					  const u8 *mac, __be32 vni)
+static struct vxlan_fdb *vxlan_find_mac_rcu(struct vxlan_dev *vxlan,
+					    const u8 *mac, __be32 vni)
 {
 	struct hlist_head *head = vxlan_fdb_head(vxlan, mac, vni);
 	struct vxlan_fdb *f;
@@ -434,7 +434,7 @@ static struct vxlan_fdb *vxlan_find_mac_tx(struct vxlan_dev *vxlan,
 {
 	struct vxlan_fdb *f;
 
-	f = __vxlan_find_mac(vxlan, mac, vni);
+	f = vxlan_find_mac_rcu(vxlan, mac, vni);
 	if (f) {
 		unsigned long now = jiffies;
 
@@ -445,6 +445,20 @@ static struct vxlan_fdb *vxlan_find_mac_tx(struct vxlan_dev *vxlan,
 	return f;
 }
 
+static struct vxlan_fdb *vxlan_find_mac(struct vxlan_dev *vxlan,
+					const u8 *mac, __be32 vni)
+{
+	struct vxlan_fdb *f;
+
+	lockdep_assert_held_once(&vxlan->hash_lock);
+
+	rcu_read_lock();
+	f = vxlan_find_mac_rcu(vxlan, mac, vni);
+	rcu_read_unlock();
+
+	return f;
+}
+
 /* caller should hold vxlan->hash_lock */
 static struct vxlan_rdst *vxlan_fdb_find_rdst(struct vxlan_fdb *f,
 					      union vxlan_addr *ip, __be16 port,
@@ -480,7 +494,7 @@ int vxlan_fdb_find_uc(struct net_device *dev, const u8 *mac, __be32 vni,
 
 	rcu_read_lock();
 
-	f = __vxlan_find_mac(vxlan, eth_addr, vni);
+	f = vxlan_find_mac_rcu(vxlan, eth_addr, vni);
 	if (!f) {
 		rc = -ENOENT;
 		goto out;
@@ -1117,7 +1131,7 @@ int vxlan_fdb_update(struct vxlan_dev *vxlan,
 {
 	struct vxlan_fdb *f;
 
-	f = __vxlan_find_mac(vxlan, mac, src_vni);
+	f = vxlan_find_mac(vxlan, mac, src_vni);
 	if (f) {
 		if (flags & NLM_F_EXCL) {
 			netdev_dbg(vxlan->dev,
@@ -1286,7 +1300,7 @@ int __vxlan_fdb_delete(struct vxlan_dev *vxlan,
 	struct vxlan_fdb *f;
 	int err = -ENOENT;
 
-	f = __vxlan_find_mac(vxlan, addr, src_vni);
+	f = vxlan_find_mac(vxlan, addr, src_vni);
 	if (!f)
 		return err;
 
@@ -1409,7 +1423,7 @@ static int vxlan_fdb_get(struct sk_buff *skb,
 
 	rcu_read_lock();
 
-	f = __vxlan_find_mac(vxlan, addr, vni);
+	f = vxlan_find_mac_rcu(vxlan, addr, vni);
 	if (!f) {
 		NL_SET_ERR_MSG(extack, "Fdb entry not found");
 		err = -ENOENT;
@@ -1445,7 +1459,7 @@ static enum skb_drop_reason vxlan_snoop(struct net_device *dev,
 		ifindex = src_ifindex;
 #endif
 
-	f = __vxlan_find_mac(vxlan, src_mac, vni);
+	f = vxlan_find_mac_rcu(vxlan, src_mac, vni);
 	if (likely(f)) {
 		struct vxlan_rdst *rdst = first_remote_rcu(f);
 		unsigned long now = jiffies;
@@ -4727,7 +4741,7 @@ vxlan_fdb_offloaded_set(struct net_device *dev,
 
 	spin_lock_bh(&vxlan->hash_lock);
 
-	f = __vxlan_find_mac(vxlan, fdb_info->eth_addr, fdb_info->vni);
+	f = vxlan_find_mac(vxlan, fdb_info->eth_addr, fdb_info->vni);
 	if (!f)
 		goto out;
 
@@ -4779,7 +4793,7 @@ vxlan_fdb_external_learn_del(struct net_device *dev,
 
 	spin_lock_bh(&vxlan->hash_lock);
 
-	f = __vxlan_find_mac(vxlan, fdb_info->eth_addr, fdb_info->vni);
+	f = vxlan_find_mac(vxlan, fdb_info->eth_addr, fdb_info->vni);
 	if (!f)
 		err = -ENOENT;
 	else if (f->flags & NTF_EXT_LEARNED)
-- 
2.49.0


