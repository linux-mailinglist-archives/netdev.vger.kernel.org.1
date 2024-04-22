Return-Path: <netdev+bounces-90195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1038AD0C4
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 17:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FFC91C21EAA
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 15:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BED15358A;
	Mon, 22 Apr 2024 15:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RLNGok/F"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2059.outbound.protection.outlook.com [40.107.95.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA7C153810
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 15:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713799788; cv=fail; b=FI4DDpFrFdIfgnApqU4wNd7GkjxPlmHVplLkZtbon971dp7QAYAQoufavkDZ6C53BB0MQ2z5rkcZf0vsnz68vU3rsQT21puNZr+UtVJgd+xOaRPTn8S1CqnOwr9VQ9y86BHr+f0pRlkqL6Ti0BfY+SZ7X4pY5sZeR4rBKYBIPmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713799788; c=relaxed/simple;
	bh=gUVrZvQDXnXucZiRSrCtcJ+DObdZST7dTwrT3+d2q5o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MoB5UApZl4QRZfvBLUwuBaxUpP0oJWVr9W9tNCc3JrY4dRQgUEsXR7ExvgzvIDx3Z4dfym53QBwKpCvM2jB+c78Z85bLqEMLhhm4beD9np2P7VYNguYEmciT6hhJHYH3wtcEwMfadPU8OiNoLCdgxoWqPnDMWxuneQY/mY4PlZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RLNGok/F; arc=fail smtp.client-ip=40.107.95.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FaEpu0V7BOT2a6SzQUyx6bpejNoScmdat3C1fTuCOTiQ4Ux3VWwF+1ivV26qNs1aEz/ZCpuJ3DF/pwChODh7VIZtaZsYQYCbr5TAX4kx9q+RvqTa7E1wONHeqNHGGLp/gDmDPkuCEZ4i2td81sRjLrEIn6t+4QSPTdYhmv1oIH5oEO2th6jqgkklbkd/M23k/W6iBYlb/ssBE05Y6LNYg3KgzR37zroJeK9xEJFTd5aO5FKDW0+1L34a/IF07pQr0ZeZp36Rn4GqAvIekgRmR7ks9xYf9cOj7iZxh19EBKzuJa0FoZfGZ+WjQdDNEambzLb0Hz/7pboo9gZEDLHKDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xul+xZ1OnAj39+584nWmWL7301ymeXai1i3cUjK/0Ak=;
 b=BcyuWI+Hm2HV9Lt8lQr0Yg/nMenJzmJ5gRcrOhi29pVtjSgWYHIexN9kt4BMNb2bE1Euzzk5y5CXZhy92K3/DJ7449FVGuW1ica+e0Jno01DfuSXH/L4StvD1XDUsJbhOf6oc9XrdCnBrV0GRBMBu3eBO/hVgt9CVKjxeYkKURPyut9CBYZCQUZ2OxlRpnOKexvlEHKGvKEyqyKGhLPgCTo50YdDJ87bNkAHzqckpdGTgOa78jZZpWj88Mdj4M2Kp9ZX8LpoIHhGoUXb16dhg5t95e+3UwMOL7LB/FM0S5sIMW7yDoZGcG6GfCOOW5uMRk/YVD+kDfCx6uimONMVoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xul+xZ1OnAj39+584nWmWL7301ymeXai1i3cUjK/0Ak=;
 b=RLNGok/FtlrTsjR75ANZQAhgV8aW5t/c1slkSuVomLrZajY1A4Tsf30Wpuue1vzkbXRK+y+sOlldge98saYFcu8TbRA5QX6tJM1ksYwMjxNb6E20zHVqv5OAvfSmVGIYozRptsGp+NXZdurbuUc1pZf/t+U0e8VVJTqRv+D0dAGu6+8zL4CEuADIF0LnaSxh5300OF/vlVwBiGOm7qXeL3bdD0Tpwg6XVV5hHvN+SkOR31Vtrby/f3uFtfxSgM3q5/7zOe9ZZwaKOnNiMyP0VmUJ92c5E9nGKAl1p1Pq9XAmmvuJx7uPteJ1C2vPoUEg48SN6vBTSFkanKSuk6VPFQ==
Received: from CH2PR03CA0018.namprd03.prod.outlook.com (2603:10b6:610:59::28)
 by CY5PR12MB6407.namprd12.prod.outlook.com (2603:10b6:930:3c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 15:29:40 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:59:cafe::d5) by CH2PR03CA0018.outlook.office365.com
 (2603:10b6:610:59::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Mon, 22 Apr 2024 15:29:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 15:29:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 22 Apr
 2024 08:29:22 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 22 Apr
 2024 08:29:18 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@resnulli.us>, "Petr
 Machata" <petrm@nvidia.com>, Alexander Zubkov <green@qrator.net>,
	<mlxsw@nvidia.com>
Subject: [PATCH net 8/9] mlxsw: spectrum_acl_tcam: Fix incorrect list API usage
Date: Mon, 22 Apr 2024 17:26:01 +0200
Message-ID: <4628e9a22d1d84818e28310abbbc498e7bc31bc9.1713797103.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1713797103.git.petrm@nvidia.com>
References: <cover.1713797103.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|CY5PR12MB6407:EE_
X-MS-Office365-Filtering-Correlation-Id: 011a38dd-e0d4-4893-09a3-08dc62e106dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D1UtyFqeEjY6q7D8BLNprJDrXqIo6q3ginvszae7G+ivjp30OtlbWq+l8J0p?=
 =?us-ascii?Q?MilhfRkv4DW0bCEGqXjwYAb8detyKlHzu2jR/3+P3YkWuj6/EyuTdgqZS9Ig?=
 =?us-ascii?Q?zFlVcT0B4Bon+yw8F7JNXlmkLhjqzpyTiTwpac6LXEyTy5gj4jQ9QxiGmZnL?=
 =?us-ascii?Q?HFE1xGUZqFh80IAWX6hVFJarUazjnvOeX0PPFDi1JIG0wvztt+pr5+NB9dvY?=
 =?us-ascii?Q?9r98Ab8brptK+/5WXmBxKdWo1GypJ/E30T9nJAQeAtcKZRpYedzbP8wl4RoV?=
 =?us-ascii?Q?/bL3LBImOJi+ac2woBZbhy6Gsm9tlDM2m5TD0XgAzG3vzDBkHH8oRD1eKLSs?=
 =?us-ascii?Q?sOQX7G+edJ+aVfZIItgrJquqxe3JbOasbtk780+qT+/JECJD6BChp8CjOcK3?=
 =?us-ascii?Q?fp+IjCt0AjmP++STVwM1dgggvT+fdV7kuHW30g5DSbi4v3+oO5I8Zidg0JjI?=
 =?us-ascii?Q?5aTT+sc5uiP+rhQi3OWp3Ivnv5lMM5Xg08thF7Ln3/KkZc2FP/Po+dn3OrAJ?=
 =?us-ascii?Q?tGH5brpGhhPkeXLwuTcvopDaBZ8SUw9Nwp91L8olbxhuIfD9xDQdIM85b+Ju?=
 =?us-ascii?Q?3GalOTyihyk3bQ2EajfZB7V1ga7G0xRQO+MRuuK4R2uU+jDFvuF0xdayXkfp?=
 =?us-ascii?Q?TDwQprPvQPZik1qnyb0Hs70bKu+5zJuz1xUVKDMbsAN3AQHmB48ZYWEbXZI5?=
 =?us-ascii?Q?Kwb6o9xR/QTEpCFt+44cxYhBVzLxC7/BG5utqMN/OY3aVLl7shfoXeBsvbKu?=
 =?us-ascii?Q?TeTLEcshWyaSrxOPIOmLUSurkmHqIfjkwhymbl8EsgUuHZ1nAc4zDDKRF3aO?=
 =?us-ascii?Q?UByzrHiHfroCaIju8zpDLFKZziUhfbY8I+Mfsc96uOGWpOY9+PfRU3dLdKou?=
 =?us-ascii?Q?yxEJJ5aeNKQtilk9YHnP5Jlpmt/30xsvfwXbG3i9qF0DiLbtJJ0JEvAHoVIp?=
 =?us-ascii?Q?d8xLK4McjDyGnLz06WlpC3TDLeN4zeaS7EZggbI1r5FW8OTKUQJDiolGHHXa?=
 =?us-ascii?Q?Q7hDoQos72jMaILFphVei3+S9GXosbHSPWYC+cJ3/9uFXo3leOhEGQ7L8Ict?=
 =?us-ascii?Q?apMdRAD0dCBlvSWA5k0jeU+osPK5UF/+S3aj2VrqqBRUZxps3/Th+qZ+3QKq?=
 =?us-ascii?Q?TOVHu2rmQsQ+HyfWmbvIFylLvt7cxt3G+mdEtFfM4iRXdeB7S6nL9Ajr1TyN?=
 =?us-ascii?Q?9auosLvkNKIotZub/Ora+j2zvAcnPYJUX5LciUmpvJIkIfNtbanK14P/Ze8l?=
 =?us-ascii?Q?co2XkBNr16HHECzmp/8A5b51pjhOsNh1zTSrUD+FdrWS9aUynJ5AY7kaFULr?=
 =?us-ascii?Q?u/5odCAHljL22wPSX4veN2s8xIp2uxqiicDeyolxjCVsu7hZLHKhkRgtle+q?=
 =?us-ascii?Q?7ZO5PUjP0C1J5qLdA9uEJ/SaWGZb?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 15:29:40.0361
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 011a38dd-e0d4-4893-09a3-08dc62e106dd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6407

From: Ido Schimmel <idosch@nvidia.com>

Both the function that migrates all the chunks within a region and the
function that migrates all the entries within a chunk call
list_first_entry() on the respective lists without checking that the
lists are not empty. This is incorrect usage of the API, which leads to
the following warning [1].

Fix by returning if the lists are empty as there is nothing to migrate
in this case.

[1]
WARNING: CPU: 0 PID: 6437 at drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c:1266 mlxsw_sp_acl_tcam_vchunk_migrate_all+0x1f1/0>
Modules linked in:
CPU: 0 PID: 6437 Comm: kworker/0:37 Not tainted 6.9.0-rc3-custom-00883-g94a65f079ef6 #39
Hardware name: Mellanox Technologies Ltd. MSN3700/VMOD0005, BIOS 5.11 01/06/2019
Workqueue: mlxsw_core mlxsw_sp_acl_tcam_vregion_rehash_work
RIP: 0010:mlxsw_sp_acl_tcam_vchunk_migrate_all+0x1f1/0x2c0
[...]
Call Trace:
 <TASK>
 mlxsw_sp_acl_tcam_vregion_rehash_work+0x6c/0x4a0
 process_one_work+0x151/0x370
 worker_thread+0x2cb/0x3e0
 kthread+0xd0/0x100
 ret_from_fork+0x34/0x50
 ret_from_fork_asm+0x1a/0x30
 </TASK>

Fixes: 6f9579d4e302 ("mlxsw: spectrum_acl: Remember where to continue rehash migration")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Alexander Zubkov <green@qrator.net>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
index e8c607886621..89a5ebc3463f 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
@@ -1254,6 +1254,9 @@ mlxsw_sp_acl_tcam_vchunk_migrate_one(struct mlxsw_sp *mlxsw_sp,
 		return 0;
 	}
 
+	if (list_empty(&vchunk->ventry_list))
+		goto out;
+
 	/* If the migration got interrupted, we have the ventry to start from
 	 * stored in context.
 	 */
@@ -1305,6 +1308,7 @@ mlxsw_sp_acl_tcam_vchunk_migrate_one(struct mlxsw_sp *mlxsw_sp,
 		}
 	}
 
+out:
 	mlxsw_sp_acl_tcam_vchunk_migrate_end(mlxsw_sp, vchunk, ctx);
 	return 0;
 }
@@ -1318,6 +1322,9 @@ mlxsw_sp_acl_tcam_vchunk_migrate_all(struct mlxsw_sp *mlxsw_sp,
 	struct mlxsw_sp_acl_tcam_vchunk *vchunk;
 	int err;
 
+	if (list_empty(&vregion->vchunk_list))
+		return 0;
+
 	/* If the migration got interrupted, we have the vchunk
 	 * we are working on stored in context.
 	 */
-- 
2.43.0


