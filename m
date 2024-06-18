Return-Path: <netdev+bounces-104478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE1B90CA7B
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 13:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B8111F218F5
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 11:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B9A158DB1;
	Tue, 18 Jun 2024 11:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OLe0ZZNA"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800D9158DA7
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 11:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718710544; cv=fail; b=HaMd2A3hyd4oDzfNB6UK+m+q4uD6PlB+fbxmHOYdxQgXNDzdT3K6LHB+wkLNZesWvnVl3KmbiUlRnEhrnysqDrdMrS/89vxOZg1IVnNXdhsDFusHPO5R1KgWQTdXTn+YgkBOHMimQb8vEoIC0vVdDZs+HHintOSJ4CEPbXsaMLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718710544; c=relaxed/simple;
	bh=T/XnFuVGi/xageUcIdWqVxjJKT9H37fmuuYBwsgzg/A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V6+/zrN/6V/D5HjRg8IE3+ABo1GPF9WBuOCDAyn5lkCJRho+pXTtRPUJT4FiWxw43q3vXz+4a24fsdaXgxz0+O9aQG1d3xbiKG89+lrkRrslnYRHd6umG6S5ZMZL64ljoy9FJ4HkzuD7XC3UsEH0C3wymVsNlwK4jGtbIxFqn4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OLe0ZZNA; arc=fail smtp.client-ip=40.107.94.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNBP61G2qhpGTvYOY+6xtMfe0uoJjOATB3AbxA4W7Q7PKrhad6EjiJ4RKq+3as0LSFuFC5KrZPHv4gMxzLIoEQnIm1Zk3dE+grOnH4HdLE4xKtnhFl++k5BrB+pfeb26yZZDTLiMeWGEjaR+h0+B0Or4iIi7eG7hqtsJEE6uAukIf1JiiH62kUKHCj7q/nnJwWYztkfxNJGrE/L6iKVwi9VM8G9O7N5bdptSO+mJ1Z1JalopBefn8dqEDlQgo5indVE0V7nbxDg+bEP5oMnI+2hPiw9xTwwXkrwIlMPX+0LujnHykwGNxA4t1RQXhWlMuaNoEJDASePWQGbxsQqEnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HNf42HmRXzWG8vyJtZtnlHH1ePAdViTnb99M/I/PtTI=;
 b=mVunaefqz8eWZP0QUQl4aZs/YNcYlSx+wsTUOCLSYioNE+NXOzwew+AoMMS0r+iqI8b+CQocBxTtHmVrbZXvToApTzZswmn65qcAVJEKvj+prX1wyWp2qxfG5QGpCwstqCZxp6jmOjbq1WA/RPnmKl08mxbJLNBygw3BwWbrpbcYTMVb4L2Wi9sFH28tRWrNoynloFKYfP9GQdVCV0RI6DsmITq6pqIHUDQWFUCv+Fuxq9iaYpQkv4yjNoxM/BwWKuxRlqWt1KYaAa70efQBNlZwYYeANFriwpTp+lVd8o+Ap7J6W6DHhbFWN6Jdy4600Ty79HAyVNM2MfFrVS1zyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNf42HmRXzWG8vyJtZtnlHH1ePAdViTnb99M/I/PtTI=;
 b=OLe0ZZNATNp/M1QaYGx9VT3IkjfvFhPZywYu/Sz3QQkCPNih3LqpcE9hv+T9NjOUN1PcRVK2ezDlHv0GTWGiFwkyuW+f1fZgEGpnrRq3Eqx7Q81hChpAcDuH2Xe6o2I/KwNQYw2jXOIrfNDHhvYFGx5Yxb2YCID42pxRIxLTvmT5UJ87OIZvd6AVL/dSmMFifdMdcGCXnn46p8dqDGh/aLODCuQP65AFs+PmH1DEE/m9n7EkhiVEzCihF8bVk8+0Xn4kIGJJKWlsJ1COiKFonh8UuyQXnP8oxJkUlZAdg+oKWnHPuko1QNs/p7h7wm+RAV54fCLoRGjsHD7uLrWzjA==
Received: from BN9PR03CA0874.namprd03.prod.outlook.com (2603:10b6:408:13c::9)
 by MW4PR12MB6778.namprd12.prod.outlook.com (2603:10b6:303:1e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Tue, 18 Jun
 2024 11:35:39 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:408:13c:cafe::b9) by BN9PR03CA0874.outlook.office365.com
 (2603:10b6:408:13c::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Tue, 18 Jun 2024 11:35:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Tue, 18 Jun 2024 11:35:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Jun
 2024 04:35:21 -0700
Received: from yaviefel.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Jun
 2024 04:35:16 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 2/7] mlxsw: pci: Store CQ pointer as part of RDQ structure
Date: Tue, 18 Jun 2024 13:34:41 +0200
Message-ID: <d60918ca1e142a554af1df9c1152cdac83854a3b.1718709196.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1718709196.git.petrm@nvidia.com>
References: <cover.1718709196.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|MW4PR12MB6778:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fe50768-8b80-400a-cd2d-08dc8f8ac6d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|82310400023|376011|1800799021|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tMdr5ueB/2YbAqZDwP+UMZOcwcZMV23W9519Czekcx2GYmeeYhE/NUQszq6K?=
 =?us-ascii?Q?Zbhg/eCSVNvM+wl4vHM70V1dGSROIBh0mMYAuDM/9VNMWQpUH3Ks0DpjPVve?=
 =?us-ascii?Q?ob35pCxx71RTDO00S6Wd9y3mbNsUtZ1NhLgZuH/BmjgHwEoae18kzb59ZuEH?=
 =?us-ascii?Q?f8ToYNofUcFFHitUlzmzOKvvFMz4mBFPeC2534+h0U8HOyZeJRHqZ8445BkP?=
 =?us-ascii?Q?OUXj91ZQf0yc5YI7e+OpgSqYP8vJnX00yN4s7+iSgxKRm87elsO8nLWBvaE4?=
 =?us-ascii?Q?BRD59ykDzxzR51/+ltDq9HV8t9cmHlgP0T0azIn0YJFWbeCLWiiJQ0tif9H9?=
 =?us-ascii?Q?gipoAZx/LOkKw2v1vuf309TH0xc93i12ydR34Imi7KYrzcd2vPS3nctFmyAt?=
 =?us-ascii?Q?zAE3K7c4IxtGVzb2Oo82IlKH1jK2DFKwLoX1WkOMZn+gTPnXHHLnj2TtJD9q?=
 =?us-ascii?Q?FdVZOe95NZfZdlAX77JCebmDhS1DziQbmqrXT1TogtFAnUjB6G3eK9qqwPnB?=
 =?us-ascii?Q?fyisHw3k9qqeFfBRHuVusQ42FtPAz9U0s5Dc6DJVWtJGHR0Uaa1JEpuslcUV?=
 =?us-ascii?Q?W0aKIcrTDyXlDNUSMoNXsDcauYLV77N0pCjEd0lWQbCj+tvdcNx81QvU+hwU?=
 =?us-ascii?Q?x8i7LStj61vjJ0aWhcgtQ9RGZZQg+nLpNKDmnB6/6s0xF6jcx1KU73LF8t/m?=
 =?us-ascii?Q?fVN/atspBRCL7bmEetILRXNkKBWYH8ijRqNougSVHQsuL8F2z/wIGGV7CO+m?=
 =?us-ascii?Q?vDki4vd9Y6bp27wkK6/w4z/XzscesyekGV2sv5qtukzuZuuiKxkAyepMsF6J?=
 =?us-ascii?Q?hxQeNaowpWCIV2m8pfMjZouod96RDrQWXbQPhx1xx4dU4fJUXl1c8Oz6MpCd?=
 =?us-ascii?Q?ntAG87e/A2QEHyHW7lJJtOuNJD2qq54Sfh99NrBLUUOPl8VibIlPNA2CV45O?=
 =?us-ascii?Q?LRoxRQq4rotLLi8mIx8u4JhLivjzctPKaY8/82jifuwZJjtHizRkvkb40/4v?=
 =?us-ascii?Q?hL/BI9Zdx3vbiFtXFeX/7C6eJnPfRS7hB1gJQ7kHUUdpAjZnDEOQp0VvWKnJ?=
 =?us-ascii?Q?15/eakYANyVtSPp0f4GspOVxqvcVkMDZDv8m5INDP/0SLlHkz4gRiUsEhtIf?=
 =?us-ascii?Q?hDbZP3pvTYQwSTQW6w78pa0trGG88Wo0d+rmI80fp2peyhyHJCeg09yVlllP?=
 =?us-ascii?Q?TklHlMwkUinY012GKBdQPxbVr/oxXQQg+wKdXntOEIH++NLqh0TcRSVl0mQo?=
 =?us-ascii?Q?MYQyfPhf9MV5KHGxSMux0q/knrTJw5R4W/cUv0OADXszxt9XGPbDlx7Jhcfv?=
 =?us-ascii?Q?/RYGEM9zxmg2avR/ae1M5TwkUyVm1kwhTGBStoaTWlGn6JmZgX5BFT+j0pUw?=
 =?us-ascii?Q?5cbPTRKBvgAdOroZ/VsLSjCIxrUAWn9vsy9hkO/hqzwnCPPmqQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230037)(82310400023)(376011)(1800799021)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 11:35:38.1961
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fe50768-8b80-400a-cd2d-08dc8f8ac6d6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6778

From: Amit Cohen <amcohen@nvidia.com>

Next patches will add support for page pool in mlxsw driver. Page pool will
be used to allocate buffers for RDQ and will use NAPI instance of the
appropriate CQ (RDQ is mapped 1:1 to CQ).

To allow pool initialization as part of CQ init, when NAPI is initialized,
page_pool structure will be as part of CQ structure. Later, the allocations
for RDQ will be done from the pool in the appropriate CQ. To allow access
to the appropriate pool, set CQ pointer as part of RDQ initialization.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/pci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index 3b6afe3aa2a1..400c7af80404 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -92,6 +92,9 @@ struct mlxsw_pci_queue {
 		struct {
 			struct tasklet_struct tasklet;
 		} eq;
+		struct {
+			struct mlxsw_pci_queue *cq;
+		} rdq;
 	} u;
 };
 
@@ -434,6 +437,7 @@ static int mlxsw_pci_rdq_init(struct mlxsw_pci *mlxsw_pci, char *mbox,
 
 	cq = mlxsw_pci_cq_get(mlxsw_pci, cq_num);
 	cq->u.cq.dq = q;
+	q->u.rdq.cq = cq;
 
 	mlxsw_pci_queue_doorbell_producer_ring(mlxsw_pci, q);
 
@@ -455,6 +459,7 @@ static int mlxsw_pci_rdq_init(struct mlxsw_pci *mlxsw_pci, char *mbox,
 		elem_info = mlxsw_pci_queue_elem_info_get(q, i);
 		mlxsw_pci_rdq_skb_free(mlxsw_pci, elem_info);
 	}
+	q->u.rdq.cq = NULL;
 	cq->u.cq.dq = NULL;
 	mlxsw_cmd_hw2sw_rdq(mlxsw_pci->core, q->num);
 
-- 
2.45.0


