Return-Path: <netdev+bounces-101463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEF68FF034
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 17:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5A5D1C25DBD
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 15:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2830C1A38E5;
	Thu,  6 Jun 2024 14:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L6zoDsm5"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FC61A38D2
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 14:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717685561; cv=fail; b=ilR/2tgntaH4U54AOPG2zK0qpPgFlO8zecJ74N6ESvJM2gkksq1hc31lT3wHgbFLwEPZsCwRMVCmVFfj1muZSt/qYChy4P+eIj5h8Hb2HBmF/nH1kZFxpDwGOsabeanc19ZyULYEu8HrZgoeQKntGgvco+oqe0YV0y61lXOg8yY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717685561; c=relaxed/simple;
	bh=VmUiT8ve4nqHHs5iJN6bred2pUOS8BpmzfP1wyn9E8g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W5/HECIYb4AWR7r6vFtntuIUJdyGZqxARBpbcHFkSgJJnzbEo4FzFYf/6eVteRsZidVT54Ma3B7xrRCN+lpnwlRUHp3cxLBnmGuJLzo0mItHhy+xr2raaeNb5NmDvBIRJ8iJsWwhJsuvLtDmKrTTmSWD2+IxRJhG5oKt9NHghlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L6zoDsm5; arc=fail smtp.client-ip=40.107.243.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DE5re/L1XPEHuXs3J/yxgCe55Ip0o4JsTn7LOdRk1t9Vbm6jMAXZjX38DNsb5MzjNfj7mhqShL3Cs63Ilg9RvnqmKNSwCGcvoiV6WGPwbtjYe3HAq3OOcgSOEaCRm3ZDD53e6n91uV/6p/BCC8+VGyQSFqfYMKJ0ytrcPkuXMBtPv714oQIvQpGz6ubaLp+QKtItrz+tkX46UMTgW2kB3Kq3svD9MXPyNYwoXYKdHJdA08b897mmc8Ct9C7R5KEaiECop13k1NA0PdM4PQnpIw+cgSwbBdVTvU+Tfuvokm5ugWnkGY7AxURPpMEaowuzSeajvBb7kE8YZw3yPQ7ZwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N6cUjbTVb5tEjGbOQOLhcX5aIGiWLSnYjHVbIolRJeQ=;
 b=mB8KqgR6PaqQUucAc5Ur+zo5K4UieIjjGOf3FVMdfXGBczB/eRIDrwCkp3MJ30biFHVgqtz9KDih22UF51qrG5uTdDc9RBZOI9Q+X1Bb5cveXKwIGrgAl2dO7Utdx7hhBhCCUNNwDWIKMcqxo44EIvQxX6kbxhF2IoDRrPUXJ+PXiKvW6epU5ipdhsvkr+FzFdQiRXxUTLW4Fb+MpaZSU7Y+dke+4QeQ2TnjmArNzytFbbE6tEmBw8OZqqhuE94etbhkmSET1BD90R5NvpbuYWkeUhuXekmgdKLixYWSFLXhaWYP1EJaFT43/0FlVJm6CWYuys3U+9oXDsoNetaewA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N6cUjbTVb5tEjGbOQOLhcX5aIGiWLSnYjHVbIolRJeQ=;
 b=L6zoDsm5ADWj39DKlDyKG3ytog5QX1OE1yEXu7Ih9rveZaUQC74i5+paiLEJXSvRvpnAC3DwOTO8U+hUJKXr9mtxrV95Mb9oyldJeswP/kTnFkDnUS3BZ/gxvsTWzY07Ndz/b//fyNWUFgQA+LElT1YqQARTJu5W5Fm72VF+m9Wr37SXouiSE0M8bzFRvSKuz4W5KAzZMYSIHPbOC+799bO1dVRnIOlTVFLKjvhaWU00rXejxRtIvqUb1miumzzYypZD4xuA83HINLG5X1+ekPYzInQTnpjPdZEcoWCFwOx0bLWjF1fhloQ7bCwuLckY5pX12pmMlqhFSZOG1jLl1Q==
Received: from BN9PR03CA0927.namprd03.prod.outlook.com (2603:10b6:408:107::32)
 by SJ2PR12MB9241.namprd12.prod.outlook.com (2603:10b6:a03:57b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 14:52:35 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:408:107:cafe::30) by BN9PR03CA0927.outlook.office365.com
 (2603:10b6:408:107::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31 via Frontend
 Transport; Thu, 6 Jun 2024 14:52:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.0 via Frontend Transport; Thu, 6 Jun 2024 14:52:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 6 Jun 2024
 07:52:21 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 6 Jun 2024
 07:52:16 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Amit Cohen <amcohen@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, Jiri Pirko <jiri@resnulli.us>, Alexander Zubkov
	<green@qrator.net>, <mlxsw@nvidia.com>
Subject: [PATCH net 3/6] mlxsw: spectrum_acl_atcam: Fix wrong comment
Date: Thu, 6 Jun 2024 16:49:40 +0200
Message-ID: <2df6368e0908d4e752ab9c74556bf2835762f330.1717684365.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1717684365.git.petrm@nvidia.com>
References: <cover.1717684365.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|SJ2PR12MB9241:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fd05d44-9f07-4161-4267-08dc86384cc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|1800799015|376005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zoUOYhajicBS06xEH74Hf8H/c37pVQBLu3ayf2oJyMVpuwozTtbNWmn4uTvr?=
 =?us-ascii?Q?eE2ieZ3816Qf+z++6w01jjTDba93ex3TbBbje64vdsiMxBjA9EHqv8T5IQnk?=
 =?us-ascii?Q?XBzxBT6wSnIiULgesiMgPK2if4FuFFDc0LMiq7+YCAFJFMqXEqaoOfDRMxB5?=
 =?us-ascii?Q?fsP7Ko7m3HkmVR9zbbXIGgYKiEwxeW+x495mjns2Px/Yzo/u7IffiWxS+HaZ?=
 =?us-ascii?Q?wEROwErfOLF9pjF6irhfgv0PzBhIIe/7UAdpoAgc0qRh4Kba9apUXqQGjnH+?=
 =?us-ascii?Q?jAeleU37/0oldggtuV9v5ZXmZrk449smGnYAawI9MqmBJmBVbHoMl/SX/b/r?=
 =?us-ascii?Q?RcTISf04AmXdmhFdER+CFL76sV7VHnzOZcjyCOAUIWU3wCjdsxyAFrTBjvVT?=
 =?us-ascii?Q?rey/sNX3G7UVxujwYzVq+9O9Zy+63D5Pm7RuAYfWBy7ua0ThQw6vrDazr4NO?=
 =?us-ascii?Q?qltru2PtGO8XyZzDBH7gP6QaMbJAHKuMfQSncmvI4psBZ08m9IIO+tCdD+U2?=
 =?us-ascii?Q?UglXW3cAUiwSnsOJEVGOM6uPc/Z0YoVNilh3rBUR83hqjrxBkzRwIQ9eHr+g?=
 =?us-ascii?Q?06q2t9IFEDbfWvtGDu7cOseMSXMQczLXB+0VNCvl8M9U5k+9/7SIPbpCj5Nb?=
 =?us-ascii?Q?wHXmT7KqNsQKz1Ag8EpnH6jJJe5BUi4iggwNMeL/qd36a5TQxE87UrX8ncHs?=
 =?us-ascii?Q?y8zF4nlUyw1y5xVaRhvU8DKoClENN+9vDOhjOFQV40rUlQGwb69lM/3st90P?=
 =?us-ascii?Q?0lEld4ktyo5BVoehpmnyM7T9x7wake7sOzdZUbVFDQEtWRBfYI/EdK97RDDO?=
 =?us-ascii?Q?ItD7iKlRPyN/EMIOsxc3+ef5nxhKoh2BVexi+i1PO3C0f+xLBpqvi3MOL9fm?=
 =?us-ascii?Q?fNw8AK9g2OQGE5Nu7mdgEyIUauRcG//rNwE4d42ZIff3fmLUfSBPo8OKfZcQ?=
 =?us-ascii?Q?gc+cTZug9yJLL45JbVJIufcyYkt3Y5AGZZgYTxpDpTHc4UTG4d3U9AkEPsAI?=
 =?us-ascii?Q?/LpLyPKkDufkttgfziHuh8skJuY7x3E3ZzYZqeHdcUSTPXEXL+f8IULPHm/X?=
 =?us-ascii?Q?MYc55p4c1rAvJeDdM3Kca2wCXbQyRU8E/8V88kRgahQyOiDCuaHfepFOhRf6?=
 =?us-ascii?Q?/p2iBCqQZAgJQLw3VXau/hVL9F5X6hUBqlETlfC8BRz0/+yVfdLAlpD9C3UI?=
 =?us-ascii?Q?OnY5NCjrwU1GDBRw3R7vCy05imS97mpdxAWhdI+u2PzbNWpKn+wPiyn/UjDi?=
 =?us-ascii?Q?D9jRSSkR+EfVGGFtEL4u5LAwOzaxTpPOFu1T9GP/dLkdoSQAtSRNeimNShWO?=
 =?us-ascii?Q?YZKw22EFrpGcbFNkl3mLFp8jMPcCrfEQJ4mxhP/OKongF0/C2sGvDaGHjCrR?=
 =?us-ascii?Q?heeEyv7L74N1T2DezEmyeVkLSvQRg6YOnfSSsK/4gUmt6lyt7A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(376005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 14:52:34.2023
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fd05d44-9f07-4161-4267-08dc86384cc5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9241

From: Ido Schimmel <idosch@nvidia.com>

The key is encoded, not encrypted.

Fixes: c22291f7cf45 ("mlxsw: spectrum: acl: Implement delta for ERP")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Amit Cohen <amcohen@nvidia.com>
Tested-by: Alexander Zubkov <green@qrator.net>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_atcam.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_atcam.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_atcam.c
index 4b713832fdd5..a7473e782b56 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_atcam.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_atcam.c
@@ -491,7 +491,7 @@ __mlxsw_sp_acl_atcam_entry_add(struct mlxsw_sp *mlxsw_sp,
 	       sizeof(aentry->enc_key));
 
 	/* Compute all needed delta information and clear the delta bits
-	 * from the encrypted key.
+	 * from the encoded key.
 	 */
 	delta = mlxsw_sp_acl_erp_delta(aentry->erp_mask);
 	aentry->delta_info.start = mlxsw_sp_acl_erp_delta_start(delta);
-- 
2.45.0


