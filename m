Return-Path: <netdev+bounces-90193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA6E8AD0C0
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 17:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71B821C21DBF
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 15:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F290E153596;
	Mon, 22 Apr 2024 15:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GM6WVdkF"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAF7153579
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 15:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713799778; cv=fail; b=GGZLyKnzmheYwL03Levu0j+y2Lt3LSBfISR5kwaOid0JYCo2UQb9LE62QQYQ8RjJgsjo4jwHX+80JaxF6UVjntcAiZzFucQGWmnlMJSFxQQMQ6TXgfi7YHkHz1isdeKrR8GmY1KGl7WefdaYgfK61t+u59YDsdLy92z+Bv0ihY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713799778; c=relaxed/simple;
	bh=WPVMaZgf0c1BhE/LdBWGLOuVxLDiuow5XbgmFVSyBjw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EZCO5YU9tP8rqZNxiHK9LbHljiLoee9bSCJxlAW1SiIueTywCjb4ELGbS2Gplx9E26MMN0f7ChHPdEWqoJZ8SwzYuf/oIT1iodeztK+np5m0Kl7aovHi6o7eLOzAaWwiRAuqTt5NFiYkD+YjC3mTH7pseLiG59qnXApGogflVRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GM6WVdkF; arc=fail smtp.client-ip=40.107.244.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gnml+WWAndGvdwMIZmvxISyXhPPGLLFFeBu5uG4IsuH0Olsvtp2oHQjKzh8AuCFFQd9ZDj6sdaj1sBygu9okIeTHoDgAa6KncjmNz9yY3xGZSlg+4zRoasDFyE9YvgeaLXTdNGWiWFMTLIhGtXL/YTxLLKNtKFV7hOA1EMLJLr/QaT4ShY3IZ0K6DeMgs9olXuwX1CQ42XdLaQq4Hx/iQL2L2va1NOb2o2KPgSJGrwcM+j38h5n+ZucvQPEP1JxenOvRjd7hCYJ47GHP2fqqjDXiZG2iiiO4wUalmm7KNlwOWWX1cJgXqTbwTLwNIb0Mj9NaUR+vsQApLdndULOZkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wwGWOuZbaFXS1D54uDpK2b9x0Mhjqyng+VGkHzJV0sk=;
 b=AqGptBbux3jPG321M88RY+LeQaQJmiOwQHYhmQcsU6mUpGZfztusiji5+ADuLFSoafISPDPyoQTEQ7kNGMgdbChZTOELfgi83siKp1neIbdpv0D8EvxtGR0251mloftSSp69ss1mshFKlFfi42eRc63ca9W+uT+foaGTCWfePyKh83WUEYaQxrEQl/ShAU6hT+aJGDXB0cgs76t5TZGGcLGH9qwaiFxzUO6tB1smMTc6lQnapB1mk5mVMlgWMUZS1PVPbM0G/BugJqkMfRQgyG12wVfQBcuj4nLwNUcKY2t+WOMxUWctmnvW4YDK7l7ftEA1IJ+/Cb2vSFeC44N4dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wwGWOuZbaFXS1D54uDpK2b9x0Mhjqyng+VGkHzJV0sk=;
 b=GM6WVdkFC7pirLxT3gagy08p5oA9q2XubripDGgDs5wxlBGOeB9r2lmImhCLiR0jNtPy1cexySvkaPrHsa/YGHUj5ABE22yt1YDqWVc4b39Td6ruQc+2VkVgZe/ujmhVEDNDnFThFNKFD3eDqFk678bb/q7BMY1oNOnU2lL71+pTvNEYuK+ob0zpvUCIJmnpRFmERcYI79Rlnc3RRXAqZJ182NZNKMkSRJg/H/DOowCyFAATmlseLjtFfbo/dWz/OfaiQOacITsGJf+ZR+ILNgQ93bp5Bn8A65G2hfE5mwZbD/zy2GNQD9eJdoK2K1r4m6uuYB4fOotQJnBz1k63LA==
Received: from BN0PR08CA0016.namprd08.prod.outlook.com (2603:10b6:408:142::35)
 by IA0PR12MB8207.namprd12.prod.outlook.com (2603:10b6:208:401::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 15:29:30 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:408:142:cafe::39) by BN0PR08CA0016.outlook.office365.com
 (2603:10b6:408:142::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.33 via Frontend
 Transport; Mon, 22 Apr 2024 15:29:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 15:29:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 22 Apr
 2024 08:29:04 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 22 Apr
 2024 08:29:00 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@resnulli.us>, "Petr
 Machata" <petrm@nvidia.com>, Alexander Zubkov <green@qrator.net>,
	<mlxsw@nvidia.com>
Subject: [PATCH net 4/9] mlxsw: spectrum_acl_tcam: Fix possible use-after-free during rehash
Date: Mon, 22 Apr 2024 17:25:57 +0200
Message-ID: <3e412b5659ec2310c5c615760dfe5eac18dd7ebd.1713797103.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|IA0PR12MB8207:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f37392a-1868-43e4-ddb8-08dc62e0ff79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kJOMXnxSglffEQKOTD9BVko3iz19pwx/12Mb8WfPXnqRVzodxNLnZHUB4vSZ?=
 =?us-ascii?Q?eGqGCA6MRrvaRWDaJu2TSyoTX7z17QfmLjEa0MCPDucYcCQ6a4XtGIlBGt/+?=
 =?us-ascii?Q?q+xvT/9MTuBmpFKE/oZS6pT08AjDRzcjcrBJvZaml7xVAo0/c0xzb8/kNnl3?=
 =?us-ascii?Q?5I7gpwKCcbqq8vCjdh+iL/wMEdm/sGEn/QGzeGAcaY7NB1lX92iuZb0yVu4o?=
 =?us-ascii?Q?8LLrS/LqapMZnNCDz8oNRGQLV+Ci0kfPz4vBD/swFiN7ybCVZ96vgGS2vt4B?=
 =?us-ascii?Q?eE6lxGHtwFWOJ2asVr3Vo9M9ctFXlmFmYH0Gw0ZAP76ODQP4PfBoW20zh4yc?=
 =?us-ascii?Q?SfkUkNy/8n38V4DXk/RQibg+xGKJgKlwLWbE7RPLooNa309rSt6tmsjb6otv?=
 =?us-ascii?Q?jUDMTUS8buzsGlHqNLSy1bBCT80zog+C76ugg+A/nOi4ZGQag0fpBKHh8qCZ?=
 =?us-ascii?Q?esskxoP8LSUjgmgb/UbfSNeg0dTrid+5JydFmO4hTAEDYYUvOB8I6MVCCmlM?=
 =?us-ascii?Q?chfPHZnj4R2XnpXWdmfx4SbxszoRiTuS0XZczAFD3blNVWqtTt2JIzD6kF8b?=
 =?us-ascii?Q?ACGnDGltGd2ttYHWMqFTKkN7BI4LHKaVpPuakIlsDMEePnfEGZfm+LyR72Tl?=
 =?us-ascii?Q?UCGuMUC8YZgvpq05BYV6AIb8/fUt1fjQ8FF1pwAzkmlxy+xCGycN9W8YPjpn?=
 =?us-ascii?Q?ZWeGuiL3lb2t7pET3cLbUu/L+2im/5UcfHrdF2AkK/+ZVKj5y2DbFW9zIw8g?=
 =?us-ascii?Q?FCZcHn4aQJ+Ize2bowGHzq6EQ3LXWDCfu2dua3sp76cHRI+yDJDl5RwlgOek?=
 =?us-ascii?Q?hgPDCnNEpSR+raJm+yX053A6tDLvhEMKQPi9KdJ9heskD6WjCwthryujcWPI?=
 =?us-ascii?Q?xzsJuTkh7NXykwu7LasMDoZs71we2XLmhu8X3sKWXCI+d8aEU0sIl/pI1gtn?=
 =?us-ascii?Q?xWIhzZzOTvkM4vrFcE2aqI3+ZkVyjLqv6yvOjLt216i6c6W7h2RUwZflAida?=
 =?us-ascii?Q?sbNcixtdivsunrrgtuaJ3dQaPQ5FsIJevV7LiN86yYcaA+4g+rDvI8krMds2?=
 =?us-ascii?Q?GY+7t5qnamvo823abrycGyWxkHDmvGInOajgR+a8iSkqVvv2DJpUTGNSuvl9?=
 =?us-ascii?Q?HJ53choKZTFLET2mt82gZcnzJXW9f8xQscSgeP+XpuKBMzyaNXCzQb0fqvuB?=
 =?us-ascii?Q?Lwnpt9wAynOKUd3lZaLL+88rFoqJCCSyxU3WryPLXRTt7AdKWSaCkM0E0FeL?=
 =?us-ascii?Q?tyFU51m9Nuhw3xBCTRhqYhWyBOJ1ZDzyC/1zmsSrDgP9S+IBQbHiJItQkU47?=
 =?us-ascii?Q?XVB/pMtPBbXD8YC7MjvNoYWL6nSmqds0Cd2WwvlMQJic9dtghzoQDh7jzX37?=
 =?us-ascii?Q?2Dx4/E2sk46z8PknvJCJtFqNTwZy?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 15:29:27.5953
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f37392a-1868-43e4-ddb8-08dc62e0ff79
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8207

From: Ido Schimmel <idosch@nvidia.com>

The rehash delayed work migrates filters from one region to another
according to the number of available credits.

The migrated from region is destroyed at the end of the work if the
number of credits is non-negative as the assumption is that this is
indicative of migration being complete. This assumption is incorrect as
a non-negative number of credits can also be the result of a failed
migration.

The destruction of a region that still has filters referencing it can
result in a use-after-free [1].

Fix by not destroying the region if migration failed.

[1]
BUG: KASAN: slab-use-after-free in mlxsw_sp_acl_ctcam_region_entry_remove+0x21d/0x230
Read of size 8 at addr ffff8881735319e8 by task kworker/0:31/3858

CPU: 0 PID: 3858 Comm: kworker/0:31 Tainted: G        W          6.9.0-rc2-custom-00782-gf2275c2157d8 #5
Hardware name: Mellanox Technologies Ltd. MSN3700/VMOD0005, BIOS 5.11 01/06/2019
Workqueue: mlxsw_core mlxsw_sp_acl_tcam_vregion_rehash_work
Call Trace:
 <TASK>
 dump_stack_lvl+0xc6/0x120
 print_report+0xce/0x670
 kasan_report+0xd7/0x110
 mlxsw_sp_acl_ctcam_region_entry_remove+0x21d/0x230
 mlxsw_sp_acl_ctcam_entry_del+0x2e/0x70
 mlxsw_sp_acl_atcam_entry_del+0x81/0x210
 mlxsw_sp_acl_tcam_vchunk_migrate_all+0x3cd/0xb50
 mlxsw_sp_acl_tcam_vregion_rehash_work+0x157/0x1300
 process_one_work+0x8eb/0x19b0
 worker_thread+0x6c9/0xf70
 kthread+0x2c9/0x3b0
 ret_from_fork+0x4d/0x80
 ret_from_fork_asm+0x1a/0x30
 </TASK>

Allocated by task 174:
 kasan_save_stack+0x33/0x60
 kasan_save_track+0x14/0x30
 __kasan_kmalloc+0x8f/0xa0
 __kmalloc+0x19c/0x360
 mlxsw_sp_acl_tcam_region_create+0xdf/0x9c0
 mlxsw_sp_acl_tcam_vregion_rehash_work+0x954/0x1300
 process_one_work+0x8eb/0x19b0
 worker_thread+0x6c9/0xf70
 kthread+0x2c9/0x3b0
 ret_from_fork+0x4d/0x80
 ret_from_fork_asm+0x1a/0x30

Freed by task 7:
 kasan_save_stack+0x33/0x60
 kasan_save_track+0x14/0x30
 kasan_save_free_info+0x3b/0x60
 poison_slab_object+0x102/0x170
 __kasan_slab_free+0x14/0x30
 kfree+0xc1/0x290
 mlxsw_sp_acl_tcam_region_destroy+0x272/0x310
 mlxsw_sp_acl_tcam_vregion_rehash_work+0x731/0x1300
 process_one_work+0x8eb/0x19b0
 worker_thread+0x6c9/0xf70
 kthread+0x2c9/0x3b0
 ret_from_fork+0x4d/0x80
 ret_from_fork_asm+0x1a/0x30

Fixes: c9c9af91f1d9 ("mlxsw: spectrum_acl: Allow to interrupt/continue rehash work")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Alexander Zubkov <green@qrator.net>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
index 7e69225c057d..1ff0b2c7c11d 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
@@ -1451,6 +1451,7 @@ mlxsw_sp_acl_tcam_vregion_rehash(struct mlxsw_sp *mlxsw_sp,
 						ctx, credits);
 	if (err) {
 		dev_err(mlxsw_sp->bus_info->dev, "Failed to migrate vregion\n");
+		return;
 	}
 
 	if (*credits >= 0)
-- 
2.43.0


