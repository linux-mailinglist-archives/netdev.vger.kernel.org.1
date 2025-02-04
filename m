Return-Path: <netdev+bounces-162605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64317A274F7
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 15:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB1943A3E99
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAC32144DF;
	Tue,  4 Feb 2025 14:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I0DcDfco"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293BC21420F
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 14:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738681027; cv=fail; b=aXWyz4Ptq8OrYlk/xsoUDFsg3ntRmmr8BXhhYKwnS8Uf8InAg7fh/vQ3fqn3Q88QYn1lOB2ur3c3sHxwEdG7zZiriGdbfYe4hxV2bFtYdi87XHjNTBDrbasAkyto7dI/1Uj9BgoHSPFW8B2eibZiIIwtZOlk5tXkAfX8WIPRMMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738681027; c=relaxed/simple;
	bh=NJnnbfyFc0vc6uwtQ+6cn8avIkT7rvrrQItpAVS1hCQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=liYtjmH45oqSCG0LEnvAuSQm1K2sk3fYe9rScJLM21TZwRa/5Aze30X74yy+JeArOQ/aoknJYkdcR/Xco6URv5ccLQNUxkbSZPfw6LEhA42gifvywtNL4yBH94LiL1mv+EuqWb89mc9hW7OCbxTUDn8y2rux5lNnaaNrO60D6sE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I0DcDfco; arc=fail smtp.client-ip=40.107.236.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rQKjlvr5r84a6xdW+VjJ4xDPm+r7kcm2YrZMqlZRU6LwFJIdqb321tphrSra0Fg5lcgcr53RXxnyA28TWanMSYTlAJtuoZZziD97FBTcStrPoR5Wa5+dLq31UY6XtHGj64+VgRr+rNOtEBD0M0Z8G/DuK9mCmotSBLT3deTY1QjmGtDkEG+2+zr49rjSugb/D3XJE8zTcSZLmS1dE/TWh14F3guoqvpYGPsRz71rGf6MCo0Zdzl9xaiocy8Ylw1DJ4/zeZNrfzOD2CGhMenN5cTLaUwMNmz02XhvpqVvnzriFloJAEdGOOy7egE/LgM8TIkTVmSuZso0RGBL/yLf0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9qFzGoDNwPDR3gUi9neDjzjiu8Sy3gSEHDSHfgjyE9o=;
 b=KmWMH8+fQmCE8GEN8qlad3orVTccWEhYopc18CsQbsRkLyHqXrnAlJBZr2J9e9e8OQR4GbfJoXntr7qPJ8NknKRSgSZxuyxqnaS9mI7bSrI7yhyf5HyBdqgnuUDBBjjGB9TGD76LWcM66W3tnkd1SyzjZIC8xXJocdGEaRE0454Y5I9miVp9wAaSLv/lP+DeQY4IvsD0RKH2CdmSecyL4Lid1vTdt6YSgmYUnmMy1q3iIC6dQl9cdgx3HaB4fhyiHltuBhlM3Rh0wL6zzzoqG1Q81IrO9EmystU1iGJgqzKLMAcsKfDC8u99m7hqQYlyBeD5fqXDYr8tuN4Adar2zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9qFzGoDNwPDR3gUi9neDjzjiu8Sy3gSEHDSHfgjyE9o=;
 b=I0DcDfcofGqnH58kMsQE2Y/Mdw6juAg+go+ugwLsCDbPQB+4PdHzdDzBQqVxOPScBw1OXnByNncwjYk8HofJnny5ZQhwM0tXYSARBiI43njjgiDrZ3WOzT766K9wyFBpLMmsXMMKU2i/o7TKXuPBidm9Oqq2VmXufIXB8go6sOTRAR5vDmklQ2Ggg+M0OTf+N6i9FFRwpg7V3aqcKrZk5h0WwLppV7xy3hTQoGoZLWBaTCZT45VF2u9TFYauP9Ayx4wbLbbeB6ppDlJ9BNI4xDzVxynqH6Jnb+gaElFm3UQN4aTXUMfbGyD3bqaDCj3BoN3wzVp4YJweWPGWlmR20w==
Received: from DS7PR03CA0071.namprd03.prod.outlook.com (2603:10b6:5:3bb::16)
 by MW3PR12MB4380.namprd12.prod.outlook.com (2603:10b6:303:5a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Tue, 4 Feb
 2025 14:57:02 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:5:3bb:cafe::35) by DS7PR03CA0071.outlook.office365.com
 (2603:10b6:5:3bb::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Tue,
 4 Feb 2025 14:57:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Tue, 4 Feb 2025 14:57:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 4 Feb 2025
 06:56:38 -0800
Received: from shredder.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 4 Feb
 2025 06:56:34 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<petrm@nvidia.com>, <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 7/8] vxlan: Avoid unnecessary updates to FDB 'used' time
Date: Tue, 4 Feb 2025 16:55:48 +0200
Message-ID: <20250204145549.1216254-8-idosch@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250204145549.1216254-1-idosch@nvidia.com>
References: <20250204145549.1216254-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|MW3PR12MB4380:EE_
X-MS-Office365-Filtering-Correlation-Id: e3f469ed-aa49-4c11-95af-08dd452c2ed1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SPCYt4Tl60U8SILuBuBvZwD5tf9LJgILp/ryS9f+FYqpK7KQREvaXvjVgfGY?=
 =?us-ascii?Q?kAB8ceq8U44ajnrSn/SE0VP5pyCDHQ7ooGtoBMzq/E19Zn+FAJDaPSwzHbI1?=
 =?us-ascii?Q?BP2zJs0I5+Z7mYWW+oNWgPF0jYLvQVvbnBhJIONr9XiH+btQmPXJqN54jNlN?=
 =?us-ascii?Q?6/6NNNOM+RtYzI/vRW09CcqwjVHIqdY2nnihLi69yOvWLeVKdPp4GaOS8VpL?=
 =?us-ascii?Q?kL1hZRdaWNptoi3/PmLYoPdfKpHFTqmTDq870iRRQ/Z8iWvublcvn/MLzJ7l?=
 =?us-ascii?Q?OcRApgPsd15hmmMzYMj5gHCDfCfAVZgZuLMp8HoNbwtAm0OJjyBoJrw2DEuk?=
 =?us-ascii?Q?oh2JAs9F5FRUaAeoViUifvBJqHuI8Uru25j/CcFEzj7jrO+QARVr3jqOl6LQ?=
 =?us-ascii?Q?euAL6oyhtoAgF32VP2GMQOTZ2RQblu7zY+GZJGJvqqgLuYRQZ1raZz2nYMFf?=
 =?us-ascii?Q?8+pqFsvdEqzg/yJL4Lvq7DXj1DYJgqzi2s2EhUGYqqSes9Qqb/MMkGSfYLO6?=
 =?us-ascii?Q?y6BVaIeMm6XxbqMvjdCD4aOKBTnH+XQgNFtaLc7golIbSlAAWnytcePK3+5i?=
 =?us-ascii?Q?0hmUYmAFaSmCpfdemQb2yeDYvbqXJCFGimW2+Y31V0xmYzZue5PDrdLo7iIr?=
 =?us-ascii?Q?ZnkTPBMgKc4EL2rpQGNWYdkkbb0NQ2bayagcKI2qQq3i1IB2LlAKnNx/KL7y?=
 =?us-ascii?Q?ZTN7rCPPT66vdv5IdyJRbN7hu3G1Y0mlsvHQhqJYSw1G9bZtAXl9vOusHpKZ?=
 =?us-ascii?Q?XT6948IKjcp881qT7d7FgPXiCHmJ5oOfKe/qOHDe/cF+vp0zHPt8XXPUvXXP?=
 =?us-ascii?Q?11HD78lhUAk/OKE1k6Au6K3Ih41nzJrbAfz7OZ+bftzyyPS2vN+CD2NDXNlM?=
 =?us-ascii?Q?a404a9oIavyqlWiU4genn540IaLcGcVAk2prqzli0WJUV+3BaTDKu+cn6gik?=
 =?us-ascii?Q?N9HGfVnASPiFFmNYzFY1BYuykq0jic8LMjcfbubGRcZQDtjmo5hcfdbtY/eN?=
 =?us-ascii?Q?LNLYD4tZZ3Ik+7aKTUhYxhl3qh1s4mn85s7CUyK9uzV2Q+tjVAuGU/JWkPV+?=
 =?us-ascii?Q?6Yf2xxVccCEPNibeIbAYtewtUJCa9ZbXtEFmE0PGA/FlLiZXsDrXWgkM6cKx?=
 =?us-ascii?Q?JP08XtMDBjlvv4rGpJoRl7pn036ZOTNUbXSq/M3vlWpVX1szJN56BvN7ItZq?=
 =?us-ascii?Q?KGjB79S5wH3DWfVATmvMkAwh5L6psrng37eKRKoryFwPCp73an9Doq5muckx?=
 =?us-ascii?Q?i35a28CWwcwMnJkZAS5QhS1lFTmRQWrQwLz77dGvEEjSzjlZ6rO3y+2Q4n+p?=
 =?us-ascii?Q?rs6amJPZPF+sjf+LanTOHbIWLT3S1qZ7v1FHjrXbT0+haxeAeIRPPHa5qV4C?=
 =?us-ascii?Q?IunLK2CjSV70cYlSbGhilNdScle4Jy0wgURCpO1N/pUAueHrfjbO+uU0dBE+?=
 =?us-ascii?Q?Tj0577UAOKVch3VY8wpiKAtDUaQ5IOiNFPmo1ZyjpSmy9NceYU8fOg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 14:57:02.1593
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3f469ed-aa49-4c11-95af-08dd452c2ed1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4380

Now that the VXLAN driver ages out FDB entries based on their 'updated'
time we can remove unnecessary updates of the 'used' time from the Rx
path and the control path, so that the 'used' time is only updated by
the Tx path.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/vxlan/vxlan_core.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 01797becae09..ece5415f9013 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1049,10 +1049,8 @@ static int vxlan_fdb_update_existing(struct vxlan_dev *vxlan,
 		notify |= rc;
 	}
 
-	if (ndm_flags & NTF_USE) {
-		WRITE_ONCE(f->used, jiffies);
+	if (ndm_flags & NTF_USE)
 		WRITE_ONCE(f->updated, jiffies);
-	}
 
 	if (notify) {
 		if (rd == NULL)
@@ -1297,7 +1295,7 @@ int __vxlan_fdb_delete(struct vxlan_dev *vxlan,
 	struct vxlan_fdb *f;
 	int err = -ENOENT;
 
-	f = vxlan_find_mac(vxlan, addr, src_vni);
+	f = __vxlan_find_mac(vxlan, addr, src_vni);
 	if (!f)
 		return err;
 
@@ -1464,7 +1462,7 @@ static enum skb_drop_reason vxlan_snoop(struct net_device *dev,
 		ifindex = src_ifindex;
 #endif
 
-	f = vxlan_find_mac(vxlan, src_mac, vni);
+	f = __vxlan_find_mac(vxlan, src_mac, vni);
 	if (likely(f)) {
 		struct vxlan_rdst *rdst = first_remote_rcu(f);
 		unsigned long now = jiffies;
@@ -4773,7 +4771,7 @@ vxlan_fdb_offloaded_set(struct net_device *dev,
 
 	spin_lock_bh(&vxlan->hash_lock[hash_index]);
 
-	f = vxlan_find_mac(vxlan, fdb_info->eth_addr, fdb_info->vni);
+	f = __vxlan_find_mac(vxlan, fdb_info->eth_addr, fdb_info->vni);
 	if (!f)
 		goto out;
 
@@ -4829,7 +4827,7 @@ vxlan_fdb_external_learn_del(struct net_device *dev,
 	hash_index = fdb_head_index(vxlan, fdb_info->eth_addr, fdb_info->vni);
 	spin_lock_bh(&vxlan->hash_lock[hash_index]);
 
-	f = vxlan_find_mac(vxlan, fdb_info->eth_addr, fdb_info->vni);
+	f = __vxlan_find_mac(vxlan, fdb_info->eth_addr, fdb_info->vni);
 	if (!f)
 		err = -ENOENT;
 	else if (f->flags & NTF_EXT_LEARNED)
-- 
2.48.1


