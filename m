Return-Path: <netdev+bounces-91688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 246FC8B3762
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 14:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1BF71F214E8
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 12:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD72146A6D;
	Fri, 26 Apr 2024 12:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JGhQUQM1"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81946144D3E
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 12:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714135510; cv=fail; b=NkbhSOF0Nc8YrPxyUTGKWmp46kw1w9rhkFVqyMxd3QuO5+Kj/12jqjUSAKkN1VibXAMmv2KgI31A3L9uxh7UZBAimQYu5b1fmezCwJmBkJebFMAafxvflLrFLMFJMhX+0L8ICEiNWyjPkqd4F9ULvR2dI5SFvY4+dYxdwQM+qig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714135510; c=relaxed/simple;
	bh=hqO+JFWgLgPNFSMlvvAmT0NVOfhDZ7hrXCZAl7lAGfo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hwUMUwhqqkzvoiQSkyLTp81Hq5t63d/0RjZdj76qKwLzR83Ujlg5IIUz3afM1YAFxS4fCh8/Jy41JCczZv5UUKEPjcdt5OqSlx2GnJX16ODcojNECdei56p99qOujNRcrwHUNkeP68CIvUy2QekwExdd2Ev/9OnLrH3KGANElow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JGhQUQM1; arc=fail smtp.client-ip=40.107.93.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G1d+vSHsEgKTpJ0XvR6yAbITuVPMoQF315Li7aG/diNqjxdPv8SHOwWSrzEnli6nJxBBJelh1Vca8+MMwrNW8y3paovFBP/PvMdBMzHZazj238bNTMzKS+NweFxjblAtEKVRDwasc3sqRJ0bJPEothkzyf7SQDXk93m0vqWafDIrMH4d3F6qVawWF9ZAIuJFC5rVMMbQGm9BfcrlesDHNU4RLEvvjjSAEt/rlzC5SGi8yT8fsZHwYIILD/8MQiTUHTt+et0AhSyRlvWCtQI2GkNZZSNFGwsOJhDlWzYZL1eKlOfyTfxnQCzjNOjUzdH3j8d7KQrrzkwyPKXZu+QW6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eRcnLGHqMK3tALLYnNtnQN8usEwqYZ12lSD2nA0MdOc=;
 b=eQFXXqWsnQ9Gwut9BRWoCEsDlXKITarhrjzhDZFz/fhAJElG4Cx4VlLixkhigu/5xCBqpILRBykLn8oekcTiohzh36BDLeLXT/sudu9roZwjNn4edf+xQd5P6v0wuxhuHbbtmLlehHBgIKr/PKmp4ZnO/SrMPTKMJA/XWBbDgejXkxTCrCnNZhuDg2jEKQUCT6ZU9jGax7QsQEUCFqOXK6oXMiz919JV7qSQGiV7lrICVs7M1ZDeu29VTwUvPbZ8IoWSbPGNqRqo1SyseC2cDOJ+4NEOImthEsN2TnEbErRb8ECaljSwu0dlQ0GMxMYSkZ24xirKoYtAZs/5e2msEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eRcnLGHqMK3tALLYnNtnQN8usEwqYZ12lSD2nA0MdOc=;
 b=JGhQUQM1OVxjvtRtekvIyLGRXHUy/CapEJGS4Jaso2EqVdifBjn0td7bPmCT2IPsDTwJUSX9WyHiEB0gNcxsG8FZYAEx7zOfnDMlMAzZbA/QeD3Jm+eA8weciO29/rwDxP1fycd6MTEczm462OkbC8MjFXuekJ0sCtpxQxZpDe3EoC4bUUCKSDaEsEol7PhLbrOj9OH7wP5kM5OENJAA/KU8ZmUM5NntbOyV8Gl4rmOutGdhS/fXkY6X9kVaniBwzvtKZbbQINe91chkyEkl2GoSl5Tqedb4L/QPJQedyWNpOHlW/2jHCuWD28SSBLo5BvdHAxrSKIub7lcghVBONA==
Received: from CY5PR18CA0009.namprd18.prod.outlook.com (2603:10b6:930:5::24)
 by DM6PR12MB4042.namprd12.prod.outlook.com (2603:10b6:5:215::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Fri, 26 Apr
 2024 12:45:06 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:930:5:cafe::46) by CY5PR18CA0009.outlook.office365.com
 (2603:10b6:930:5::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.31 via Frontend
 Transport; Fri, 26 Apr 2024 12:45:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.19 via Frontend Transport; Fri, 26 Apr 2024 12:45:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 26 Apr
 2024 05:44:53 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 26 Apr
 2024 05:44:48 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 1/5] mlxsw: pci: Handle up to 64 Rx completions in tasklet
Date: Fri, 26 Apr 2024 14:42:22 +0200
Message-ID: <5381c00c284ddc62d90dc88f3b080bf701544d94.1714134205.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1714134205.git.petrm@nvidia.com>
References: <cover.1714134205.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|DM6PR12MB4042:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e69572b-4c9f-4532-4a73-08dc65eeb2fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|1800799015|82310400014|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kIeAquW/XoeahTwGb/PFRUCf0VflQf6cX4o7/FwVY75IqcfuW5tZbw/ULFyB?=
 =?us-ascii?Q?UEkqsm7tDX4UDAwtCl8dBCtddZEtSAqPQDT9P/8/P+q+5mrnNgBC10S0TGm0?=
 =?us-ascii?Q?47lRX1dF7+VYluXX7nA+ccME0/PZLoDppO7VyLKXwW2T/rCutI7kCJ/kWe4d?=
 =?us-ascii?Q?JKU7ox4ZK9WEfcb/5m0L6ocOqzHBENr/emCh/1HODD9QgxklfHi8dilDEPNt?=
 =?us-ascii?Q?y2sv6vZwajsLHQE5RaH80XGFQBqtdjEkVkpT9WTQq1p8vxUCvv6OiQx9Oh8d?=
 =?us-ascii?Q?X9tTp+4p62uWJP619fZMZlUinqRggMHbTGSSTOqwnGZDXZGI/RQGBUsSd7Iy?=
 =?us-ascii?Q?Y7H+yGBFW4HKpTX7Vy5FNL3uyYiLSOjwvXuMi4Up7CADCBxmDzVzcn9GPuvX?=
 =?us-ascii?Q?Bh2o83SBbRdEktf2QdxsbeyMt/O3KXVAxmEBmrjbyX0D2/+UuRJ6gCGLu0ru?=
 =?us-ascii?Q?VravDqUjNEYrH2hWj6topaSYJMLV70sv6C75CnyC8VLpkQAoeYp/kWsRAPZd?=
 =?us-ascii?Q?IjeIo1yqFCIo5vNyOfUUiaxS2zL0XeeHTvpA0r7qT4C/ucecol/nNOyAd5bM?=
 =?us-ascii?Q?lAB6LwQNV9epV/CMZzUn2/1WCWmWIQ9ld3dzj/EnAYStcQTiM36+BGKUDQ0y?=
 =?us-ascii?Q?kKQcKFz70X6AwezG0JNpZpQ0g84jjIQSb63OnM0dfHZymth+BhsPzn9DIUGk?=
 =?us-ascii?Q?5XoJn6jmFbUpE15FOUpRdJtNg+XXK9GARrozNAwWo6ZWDxO1nLguQnXkBr9n?=
 =?us-ascii?Q?ue3T2djT5epJq22epXt84joHQN11S2d47yKRV4i3v+d3bN5houfOzDutJCDy?=
 =?us-ascii?Q?S2qkAP9tpoGaUijz7XU50Cep8wVC1Rh17oUO9HuNZ2TrW45MzeQ80o0nJ34I?=
 =?us-ascii?Q?iMkpdPAaw5rmU4a+i/6yovCGFNKsYFuHzatd/tmAIERn5IWqTgP2b16q7Ky7?=
 =?us-ascii?Q?851jNR2bWGMlHciAY8j86jYzJ1o9weRCwKImsOa26GlhfzbB82QCfe2l0dE9?=
 =?us-ascii?Q?DM1Ibyd0l3KhocXZTXe0gBuKeBXt1E29rWCwDu1lYBeA6HZXsfOt00rFLM6/?=
 =?us-ascii?Q?6zFjDDpbc7SD4YJhDhOFYKFwQFPSp/P/niCYfVTJKASQgkiGpaTMxoNpXW3N?=
 =?us-ascii?Q?4E5OTLAPQBgeZ/x5GlVzOmw9DG+8xMOh42Oecc3N3im9y0tqtgLnHH5e1FFT?=
 =?us-ascii?Q?TlFPV9ZuXK/6KPH8V9Qrl/hHnE526cvCaTtqxO+4sGduPzSGD3Juz/WXN6Ci?=
 =?us-ascii?Q?MECqPML2q7omsbxodm3IBA4bpVkw+qymSmydpgZuW6BVhhgC+yM89UF4d2N/?=
 =?us-ascii?Q?tWVaBAaIYDXQaB0Ermoyi9yQexQqEaBrJK+vXWDfQcotshwUEzH2wQVFV2UC?=
 =?us-ascii?Q?mOUylzjyPvVLrayPQOqc5FU7PwQ+?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 12:45:05.8305
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e69572b-4c9f-4532-4a73-08dc65eeb2fe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4042

From: Amit Cohen <amcohen@nvidia.com>

We can get many completions in one interrupt. Currently, the CQ tasklet
handles up to half queue size completions, and then arms the hardware to
generate additional events, which means that in case that there were
additional completions that we did not handle, we will get immediately an
additional interrupt to handle the rest.

The decision to handle up to half of the queue size is arbitrary and was
determined in 2015, when mlxsw driver was added to the kernel. One
additional fact that should be taken into account is that while WQEs
from RDQ are handled, the CPU that handles the tasklet is dedicated for
this task, which means that we might hold the CPU for a long time.

Handle WQEs in smaller chucks, then arm CQ doorbell to notify the hardware
to send additional notifications. Set the chunk size to 64 as this number
is recommended using NAPI and the driver will use NAPI in a next patch.
Note that for now we use ARM doorbell to retrigger CQ tasklet, but with
NAPI it will be more efficient as software will reschedule the poll
method and we will not involve hardware for that.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/pci.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index 13fd067c39ed..8668947400ab 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -652,12 +652,13 @@ static char *mlxsw_pci_cq_sw_cqe_get(struct mlxsw_pci_queue *q)
 	return elem;
 }
 
+#define MLXSW_PCI_CQ_MAX_HANDLE 64
+
 static void mlxsw_pci_cq_rx_tasklet(struct tasklet_struct *t)
 {
 	struct mlxsw_pci_queue *q = from_tasklet(q, t, tasklet);
 	struct mlxsw_pci_queue *rdq = q->cq.dq;
 	struct mlxsw_pci *mlxsw_pci = q->pci;
-	int credits = q->count >> 1;
 	int items = 0;
 	char *cqe;
 
@@ -683,7 +684,7 @@ static void mlxsw_pci_cq_rx_tasklet(struct tasklet_struct *t)
 		mlxsw_pci_cqe_rdq_handle(mlxsw_pci, rdq,
 					 wqe_counter, q->cq.v, ncqe);
 
-		if (++items == credits)
+		if (++items == MLXSW_PCI_CQ_MAX_HANDLE)
 			break;
 	}
 
-- 
2.43.0


