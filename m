Return-Path: <netdev+bounces-185184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E76A98E36
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 16:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A35B5447E45
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 14:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163D827A12D;
	Wed, 23 Apr 2025 14:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lwYNfYdx"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599D618DB17
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 14:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745419952; cv=fail; b=UuASXqS0sUarvg0uxjCHfgG313UALTs+xOhAXmQvGLy48vQWsYbldLgzp1AwF8NyPq3ODc00d7aJcNyA36/eWOHQHxxEqy4AV2+j1+PjTh6kwt1nPkFQvrpLeWkRPGPhcGrsqfbdsWw+jQMZl62mQnwzmbytSWDjhdWTcMHvD1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745419952; c=relaxed/simple;
	bh=OpPC+PJG9d+s0zxGATqk2d8A8LpWWnsdGtYWbQuc71w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Dim34J2DZ7kkWcKJO5QLskqxNZuzkYaR6AB/1WfINqUimSnxwH0NSzaJOFZb2XKCIM4RqxxiTsXxY+C1WguG07hFRTLty3ClwjFIBUwMbfHKwmSuSMHh8K0W81uLGl6BLe8C+grMwXp4le9lMZw++81mua1TAFFHjRkF+mnhE24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lwYNfYdx; arc=fail smtp.client-ip=40.107.236.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=paV+yFOb6lfzwe9oY+IUlGjD2z8SDE8PgYidHRqURlCQqz8+7+BpCOfX/2GQGdbqd+utuRpDXeKKSiJ8nHgrSbbVYLUhinA/vmhuAq1ttd440Hz9XfGiM/bTFWyT9o223uvUxaGRfwL7e2wWuq0a+HVuLvZDX+FuNV6VyeEWJqLL2kujVcZygDFNKuhteRqW1ExCiFFgS3CUzaYZMI3vZKlsuxU9p7Dps/JiqCzrt271cb5mOSby3UWBnF/jl5qGxo/oqccDEq2OdEyxtaDSOZLMzrLiaSE+TbzMe7s6inRYcCMbQOuMWThtViXkE0Z7eH/JQXzL4tZIIRkH7IVLoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Heej36mRUmSqEoZZc6pAYiqSKflMoOuNJF2kihLems4=;
 b=d9DBUZvDCVkrjq7SXG8DwVUKWDMuX5Qz408VF3YzlfB8acpdOPk0AYizsE7cYVdgBkTm010QNl6OqesHtrCgprJ6UyA36I/sly8nJjO2vfSkUbPot+cAx+XcZsi2lVTyxJHAPSDcnBjMpWoH6haI8QCo5xz6ATaBeQdqp1+GWu8usYET4EG8kDCL/ylBo8USDb+k+FC/zJHzi/8giDCzSSssOZxaZsuoIVNm3wtpq+ydf80DVSGjzMlFyjn7R/y0qH7ILo7MFSD9+rQ20YLAsqumQdbaRI/d+rnakS+bz6XjpIz7GX1Weza+ESzK1FQmM9IykZ+KBDMjuRZZSGC9kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Heej36mRUmSqEoZZc6pAYiqSKflMoOuNJF2kihLems4=;
 b=lwYNfYdx1B6p9A3QVnVRiFvFUrR/xbbHgwDYhlJcLC4eiq1mOGNWwKM6erhEmnXOJezRFkfv8jkG0fOyDzqnCeOVPsfcWTsrlLM6wZXfvaD6Xz5xtkpvv4MTd2ION47h66ugS9n84PUIng6tp1/F37lNVG2UWm+61hKy5J+CxW2OgRmoXLsMK0uDgF/53opc/9DECY6pGRC2FT1yEy4LmWfMqgGDN8WmaC1ZknpoWj8oiEdr6cJuaWqcMAr1NeGEwD8+h/ReTQxheCW8Es8Ht3Sd76smv6b4b2dojZbpzK34Y3jwUvLsSueCtFye+pNd3ltMMbxFP93p3lw8gkyCrA==
Received: from SJ0PR13CA0037.namprd13.prod.outlook.com (2603:10b6:a03:2c2::12)
 by DM4PR12MB5769.namprd12.prod.outlook.com (2603:10b6:8:60::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.33; Wed, 23 Apr 2025 14:52:26 +0000
Received: from SN1PEPF00036F43.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::13) by SJ0PR13CA0037.outlook.office365.com
 (2603:10b6:a03:2c2::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.15 via Frontend Transport; Wed,
 23 Apr 2025 14:52:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF00036F43.mail.protection.outlook.com (10.167.248.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Wed, 23 Apr 2025 14:52:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 23 Apr
 2025 07:52:11 -0700
Received: from shredder.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 23 Apr
 2025 07:52:08 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <razor@blackwall.org>,
	<petrm@nvidia.com>, <roopa@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net] vxlan: vnifilter: Fix unlocked deletion of default FDB entry
Date: Wed, 23 Apr 2025 17:51:31 +0300
Message-ID: <20250423145131.513029-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.49.0
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F43:EE_|DM4PR12MB5769:EE_
X-MS-Office365-Filtering-Correlation-Id: e71244d7-bf47-42c7-8687-08dd8276767b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wf8ZhUScmxt43yNJ7Et2Ddh6AOFDYxC3XGetq+lZjxYyYItDelJRCFJbQjaL?=
 =?us-ascii?Q?pjkIBwHHqbtvxXjN8hEcZL0Bkwrm+REGjbhelSOfR+C7j9SThXj48H7F20Tc?=
 =?us-ascii?Q?m964d2SHD+s7U0G850iaruIhttjKEDQr5zBZ7VmCIWF9POi5gZUoq+Zg2NS2?=
 =?us-ascii?Q?JK4c2emD3+qnmLn5qTOHAcXxXCh3xd4yKlwtHkITHTf0uuPkhTy0CsjTzjdO?=
 =?us-ascii?Q?m2grHdjYxmQ0zun345kWtr8D05D4Ue6XJVK1tr8p5LsUvUF0apZRUXF1LL3m?=
 =?us-ascii?Q?v9eonvLjZnCGl7xo5NlCwBf6Vmf61zg8nvvPZ5ZMKzW/628/t0JYNOjS0fk/?=
 =?us-ascii?Q?+cVvGaqr2yz9EG7VpfYGVUUUdMZpPLpkZDsD8IjqvnqhE2siCEVO3qNM/kta?=
 =?us-ascii?Q?nWHXggXpX7g15lsp2AxOPIx36tpQ2wN1AYbyAPQSibHTZt+cyjGz7i/nCVd+?=
 =?us-ascii?Q?HVcWWFO72hp2wgbFc3U6gFx/3UAVRXDBaWCuixVlmG271lL/xydtVGWB7e66?=
 =?us-ascii?Q?WMv66xPdYIh6iKNdFgwLBvbDDZ8C9y1cssonB3ivvL7AZFi29R0FJrQBIW9J?=
 =?us-ascii?Q?tcoNVSrl4TCOZmd+5iAzE9C1zP7HGlHyeo8YRrx05B4fgnxgQykFRsi03Zhp?=
 =?us-ascii?Q?k7ArTH2flsifDBnDkXuy/tMN257BCb6gTaYNiytrj5Xid9WWMFQfbH6j/mz9?=
 =?us-ascii?Q?9CLOhppnN7rGOAVQ3KfpEgw+/92yYcEIPD+N4RNTMfFJTQM0ajXGzAx7recN?=
 =?us-ascii?Q?VE+zSrVd5XNeQK7r5lVGhax3iFdWbLwYa1akneNBlghnLxwRzHT8q+rh5srQ?=
 =?us-ascii?Q?0A5nA/3CXAQxEy0C0GB5RQanEROSh0wK2OxG0UeZb0MkCFHTi/foW5oTpd6m?=
 =?us-ascii?Q?2Oqfs8qBFiuxN/fuw8qTESlHxq9YmOH2L1upa4KrPOWEmS13y+c/lPXHErJM?=
 =?us-ascii?Q?NrFrQobTkzy4MQUGQJonq2bPlKP4vsoLTyO0o1xpeECUqyRyD4bvXlGCF2jv?=
 =?us-ascii?Q?QK/AjDgQAWkGYBgs47iSZJvCk10b8YwdpKH1UmnOJ4jE4RWMWzRDcsvLC9SV?=
 =?us-ascii?Q?owPPfT+zCBXAztIqSUUrTyiLpDaheL131MEtQJfzqqrtk1HeO64PkuLqYPdo?=
 =?us-ascii?Q?AMWatLwaIo0LGd6Ws8MkQslAIXOTHxpwwl0jAS7BqbvFErI3BAe26OJiiJGW?=
 =?us-ascii?Q?7SITxQRuNLF0Fq0v0muT9ifkgRtXLJFrewe7YMw38NertmRC/z3grC25omp1?=
 =?us-ascii?Q?QVPPWNVCZuUJlsH3/R8IIYdv6sIfpz1pXutAZR419N3yBP/9WoLzEVx0IBFm?=
 =?us-ascii?Q?zishpKVY7S3sSocf/aTdkdbas5QKYug/M1Drgm3NFMSaDasloIDde3SGRqz3?=
 =?us-ascii?Q?1vg5BZFJqV1iHkT0+0B1wYZP1dXDPzOXcy+A9jvmSLWs2scduaFemuLwnA/x?=
 =?us-ascii?Q?oZXDvkSlhmfXjUx3Ca2tTEELJDGzRw0i1v7nsavVN3+ejEYOK/DFh3mfQlZA?=
 =?us-ascii?Q?khKGBfL2sd/THFx9w+7+c+oT0vj6pUfN5SvafBVGeA4dmkg+FYpjQwvOxg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 14:52:26.0630
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e71244d7-bf47-42c7-8687-08dd8276767b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F43.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5769

When a VNI is deleted from a VXLAN device in 'vnifilter' mode, the FDB
entry associated with the default remote (assuming one was configured)
is deleted without holding the hash lock. This is wrong and will result
in a warning [1] being generated by the lockdep annotation that was
added by commit ebe642067455 ("vxlan: Create wrappers for FDB lookup").

Reproducer:

 # ip link add vx0 up type vxlan dstport 4789 external vnifilter local 192.0.2.1
 # bridge vni add vni 10010 remote 198.51.100.1 dev vx0
 # bridge vni del vni 10010 dev vx0

Fix by acquiring the hash lock before the deletion and releasing it
afterwards. Blame the original commit that introduced the issue rather
than the one that exposed it.

[1]
WARNING: CPU: 3 PID: 392 at drivers/net/vxlan/vxlan_core.c:417 vxlan_find_mac+0x17f/0x1a0
[...]
RIP: 0010:vxlan_find_mac+0x17f/0x1a0
[...]
Call Trace:
 <TASK>
 __vxlan_fdb_delete+0xbe/0x560
 vxlan_vni_delete_group+0x2ba/0x940
 vxlan_vni_del.isra.0+0x15f/0x580
 vxlan_process_vni_filter+0x38b/0x7b0
 vxlan_vnifilter_process+0x3bb/0x510
 rtnetlink_rcv_msg+0x2f7/0xb70
 netlink_rcv_skb+0x131/0x360
 netlink_unicast+0x426/0x710
 netlink_sendmsg+0x75a/0xc20
 __sock_sendmsg+0xc1/0x150
 ____sys_sendmsg+0x5aa/0x7b0
 ___sys_sendmsg+0xfc/0x180
 __sys_sendmsg+0x121/0x1b0
 do_syscall_64+0xbb/0x1d0
 entry_SYSCALL_64_after_hwframe+0x4b/0x53

Fixes: f9c4bb0b245c ("vxlan: vni filtering support on collect metadata device")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
I'm sorry, but I only noticed this issue after the recent VXLAN patches
were applied to net-next. There will be a conflict when merging net into
net-next, but resolution is trivial. Reference:
https://github.com/idosch/linux/commit/ed95370ec89cccbf784d5ef5ea4b6fb6fa0daf47.patch
---
 drivers/net/vxlan/vxlan_vnifilter.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
index 6e6e9f05509a..06d19e90eadb 100644
--- a/drivers/net/vxlan/vxlan_vnifilter.c
+++ b/drivers/net/vxlan/vxlan_vnifilter.c
@@ -627,7 +627,11 @@ static void vxlan_vni_delete_group(struct vxlan_dev *vxlan,
 	 * default dst remote_ip previously added for this vni
 	 */
 	if (!vxlan_addr_any(&vninode->remote_ip) ||
-	    !vxlan_addr_any(&dst->remote_ip))
+	    !vxlan_addr_any(&dst->remote_ip)) {
+		u32 hash_index = fdb_head_index(vxlan, all_zeros_mac,
+						vninode->vni);
+
+		spin_lock_bh(&vxlan->hash_lock[hash_index]);
 		__vxlan_fdb_delete(vxlan, all_zeros_mac,
 				   (vxlan_addr_any(&vninode->remote_ip) ?
 				   dst->remote_ip : vninode->remote_ip),
@@ -635,6 +639,8 @@ static void vxlan_vni_delete_group(struct vxlan_dev *vxlan,
 				   vninode->vni, vninode->vni,
 				   dst->remote_ifindex,
 				   true);
+		spin_unlock_bh(&vxlan->hash_lock[hash_index]);
+	}
 
 	if (vxlan->dev->flags & IFF_UP) {
 		if (vxlan_addr_multicast(&vninode->remote_ip) &&
-- 
2.49.0


