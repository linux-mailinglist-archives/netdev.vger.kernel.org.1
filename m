Return-Path: <netdev+bounces-143007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8442F9C0DEA
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 19:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFFC1B22F35
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 18:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D672170D3;
	Thu,  7 Nov 2024 18:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rN5a6AWp"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2052.outbound.protection.outlook.com [40.107.212.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B0B217308
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 18:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731004611; cv=fail; b=mFnPqpjqmPplxZwEVb2jmGaoJGzrTirUw+j9UHsJ5SAL3k6aRV+aBHmV4VP6T91ewaBHJowx/N1xMUgCYuN394q85iRIpLmnfFZblDm/ux3fDz0CvCMyGi0WoC9iubOZMp+tGjpHx2x4e3S51XR6muvjlJwI+hKduRvIbDdt07c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731004611; c=relaxed/simple;
	bh=1/5sqU9zzNhBCDD8an25vm5+Cv5EudXTeTTn99G828c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qdsx1NDzV/QXSb4QzwNFrv5PhuByZYV72IxBNhBq190sMYwa6qmrr0i3pp+ZBAqw+5ZFJlb3qNszPnyK/EEuYbKZIMM/RPoTtqHF3++1z5cAdOQ1lmjGZ19wEdeefItAJIZdQKF5v5iNbv2mDvXb5FIXUOCGPLfYM0YUZXK/rwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rN5a6AWp; arc=fail smtp.client-ip=40.107.212.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uLkKHP06dEl37N1LzzCQPYKAhaIry0hzyQ+iv6tkvF1KFKACW4O/laIJszQRfvrbFbyAHqF22glBEZf02Sbs3oIBbWuxBYmrZhjcXOpXN2tjiewKd30wrYa/BjmHm9NSwPYqSmDMBIs9U9JFeAYlk8DS1y/vi8AwRu55ms850KkrzVeb7mEgdykRksr4nJ5II/Smid3FiRkt0GtJGM+U/dG5sg54Oq3ogcy+ybI4hdvDSh95KuX7qrYQuRumaIX12SSNN1ANmilaaZiIrvPE61f569sEepYWir3pfaTSp7FMG0D8oQ4cWNj/haqt3FM4puTLetGkNlCDPchMIwyyZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+Q/OD7YGr9j0sqMg90Gsz/ZHjpyVhaGMkCNKIs93Z8=;
 b=o+d/kQnVuYIMsjusyPvS5H+tbArO9g+55QNC90bBVZtTG6ymJycs+4+9UJnsX471aDPAsu26Cy28HGprJCOcgRKoj553we2MHjdah2zXJZYupEDR3tkKeZ5P4PTm1Rw2nQNMBXrYZQMrHmMiLAw88Ynw42/ODYTHxTRq9hmZQh7LZSwInVzrrZhheQWg2O3gVKVMwU22j8TpQjnMvYxZ45o/9jGn1DHKIwfKNpJro/N4LBa3c6jYhQ+QC0mJFEDX9LLLN0k81xtq3TvSU3wbSYoHxaKAhh6vaWQ95iutmue1hCvKtgKDNf3vLYEszygMN5VjxU6ox0Hq421B1cPlUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+Q/OD7YGr9j0sqMg90Gsz/ZHjpyVhaGMkCNKIs93Z8=;
 b=rN5a6AWpgli4e8XoJb7qCm4VxiIWBkduWzpym24Ee1aVBB1tZxeP5a2/gVb1mwS/zo1VnMk4Puyk2BPfWpZe4LXVrdA3oLy5QQxisVH4VTUPCLrhY/7db6skbChyjA4EXVJzmYbfgnvU6J6iV3TszlukdJOZiMwWaI6ytG/D7eOkpl60ShuGVgb+zNnCf1bNrHGlxzWojscNoEEv0gBJmlHANJEF4ue9uqOd9vswJlxUzowtzUa03PVF9h8WISOwln7++oOXF8ZBQZ6aKz2teLCnxHn8fH439klxbMpUzDeBDRIdLltwo+Sunzm0kC0fnhCo9UDwfUp0Plhx4D21mQ==
Received: from SA1P222CA0141.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c2::8)
 by DM4PR12MB6326.namprd12.prod.outlook.com (2603:10b6:8:a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Thu, 7 Nov
 2024 18:36:44 +0000
Received: from SA2PEPF00003AEB.namprd02.prod.outlook.com
 (2603:10b6:806:3c2:cafe::c4) by SA1P222CA0141.outlook.office365.com
 (2603:10b6:806:3c2::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20 via Frontend
 Transport; Thu, 7 Nov 2024 18:36:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00003AEB.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 18:36:43 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 7 Nov 2024
 10:36:29 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 7 Nov 2024 10:36:29 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 7 Nov 2024 10:36:26 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net 6/7] net/mlx5e: CT: Fix null-ptr-deref in add rule err flow
Date: Thu, 7 Nov 2024 20:35:26 +0200
Message-ID: <20241107183527.676877-7-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241107183527.676877-1-tariqt@nvidia.com>
References: <20241107183527.676877-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEB:EE_|DM4PR12MB6326:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ef1ba58-dd5f-4446-0cfa-08dcff5b20dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2c2TFBtSCtwV1R0bnZ2bXlJVkFBLzh5Rkl6OGtKMUgyLzJRQzNCTlUza3RW?=
 =?utf-8?B?LzB0bjdQTmdWMExKY202YnByK3RObkpZaE5pZDZ0elhJV3krQkNuU093VXN4?=
 =?utf-8?B?VEdmUjRESkVyMy94TjY3b0NobENwN3dIUS9NYzVpY09uNzJoNjM0aUZLY2Nt?=
 =?utf-8?B?WjQ1b1VKbXBQYjJ2QTRIbFZzcnBaaHg2RzBmR3ovam1QRThVd1M0UElxZWox?=
 =?utf-8?B?d0p5R0s3UjJYaDhzbDE1MmxHSVFBdGJVVVYwVXV4UTNSbmw3RzZQUmlIa3V0?=
 =?utf-8?B?MGE5bmcyZ0YwUWFERGUzS1hUeVcwVkEwMm9UNG41TjNWSDcvWkNHRVpPVGJF?=
 =?utf-8?B?WWVZUDZhSHg5UlA0V3RGQTlGRnJkYW9ZTWlUc1kwZmhRMUZhU3dWZUdvR0tr?=
 =?utf-8?B?TnJ3N28wNUQ4dS82MUp6OEtReStSR0lhOHRESmYzQzdRWUs2STh1ekd2bHlj?=
 =?utf-8?B?Yk0rUVkwdUpmQ1NwaHo5REFzUFZoYzdlRTh5UnBvdW82dGxzWlhJQlJDTDNH?=
 =?utf-8?B?ZnBsSGgzY05mNXlJY1FCWG8vNEIyNGpxc3pPZ2FHUTlpUjN0TDNjZ09DQ0NE?=
 =?utf-8?B?alRxK1N3NUs0SXpIbFFaMUk4WHdrNWcrY1pRRDVnZ1RYQnhtY2tQbCs0OWJv?=
 =?utf-8?B?UlNmMjZXQWhnNTczK1BOLzEwV29xbDViZ0Zibi9Pd09lWTJ1YVU1aUV4eGhS?=
 =?utf-8?B?VzRYWHo5NGJuSW1xbm9hMGltdUs5a1VDSy9YNGxVN3U1YUNkdzB4TGlNK2Ji?=
 =?utf-8?B?MVJEREQ0RXhKMXNncWgzdmt0RERpZDVsUmkxMmE2UmpFbC9UYTdBMWFQK3Q0?=
 =?utf-8?B?WkRvZzEwcmVqM244WkVuMnBwWkpMcmpCa1prUEMzMmljRkxaRk40OXhGL1A4?=
 =?utf-8?B?VDNqMW5MRkUzVFdzYW5WcHhqQ005am14c1VJdWMzR3c1d3ZZNVgzOHRGcjdw?=
 =?utf-8?B?UTJkYXA2d2paZ2MrMmxFaDVrMmI1R1NzV1NVc0JNK2NySUIvb0l1TVpaQVd2?=
 =?utf-8?B?NUtLTXBBTTdnUExLZjBsVkV6TjcwOG5TZW56ZDBMV1F4MG9YT0RzRW9QU1Vs?=
 =?utf-8?B?REpUOGJ0NGoySldPK2NCeU5XTVpSTVVjUkEzNTNnbWxYZHRQQXpsVXIzWDZJ?=
 =?utf-8?B?aTBtakorQXhtVk9IZVBJcDIxeFJuY29sK1FEQnRMWmtxNTZYNGZiUVBEVnE4?=
 =?utf-8?B?blEyTHVza0IvbWdMYjA3M2pYblpxcGxlRDB6RkVTcUIwSVUrN2wvWTl5VjZs?=
 =?utf-8?B?ZE5jNGF1TnN4UWQwc0pmVVdKcjV1NlFWaERNUWhZWGI1d09zcVR4Z1lwb0dm?=
 =?utf-8?B?Y245M3ZhMWFBOTVwUlBhSnZVenlTekx6Q0NPODcvY1JFeEE4QTJZZm5SaFlE?=
 =?utf-8?B?SkZUeVJteVRmRThsdlJqbDJ4d053ZnBaOCtEUlhYYzlUVjhQS3RPREQ4RWlR?=
 =?utf-8?B?MlJrSzVVZFRBVHB2dGlQT1BLbktjUjA4UmhKUHE5Z3JzTnFuRlk1UjNid2Vq?=
 =?utf-8?B?UWNtZnBqaGcveElJL05iNW5CWmlKZ0JKQjdXVWZBUHl1a2Z0T1FpajVIVFRV?=
 =?utf-8?B?cE5Ec3FkdjBRemJlK212Vm1BT0hBUmJjcjAvUlQzYUZlY1ZTTVUyaHB5V1Ja?=
 =?utf-8?B?OHo4UlU4VVdSaithRFFySDNUT1g0WHVkcjBOQ1NjaUd3QmJaMU5KdGo5WEJh?=
 =?utf-8?B?NmpOc2lBc2RVdTc0ZytOQzhIUStmWG9pdkZiYzdZeE05N2VBZ01GdmRCempC?=
 =?utf-8?B?R3JONlFlVThqRG1zTlBxWmZIZXhldVh1dGhiNkVNaitHaWxzU1dxNEZlTU9i?=
 =?utf-8?B?UVlibHI3c3hKQWoraURSQ2Q0Smp5dElCM2JadmZ5Z296S1dreU1nZ1FURVgv?=
 =?utf-8?B?Y1lHaXhGUUo0aUZTUDB2TXlkWE92bHppT1Jmdml1NHU3YkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 18:36:43.6916
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ef1ba58-dd5f-4446-0cfa-08dcff5b20dc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6326

From: Moshe Shemesh <moshe@nvidia.com>

In error flow of mlx5_tc_ct_entry_add_rule(), in case ct_rule_add()
callback returns error, zone_rule->attr is used uninitiated. Fix it to
use attr which has the needed pointer value.

Kernel log:
 BUG: kernel NULL pointer dereference, address: 0000000000000110
 RIP: 0010:mlx5_tc_ct_entry_add_rule+0x2b1/0x2f0 [mlx5_core]
…
 Call Trace:
  <TASK>
  ? __die+0x20/0x70
  ? page_fault_oops+0x150/0x3e0
  ? exc_page_fault+0x74/0x140
  ? asm_exc_page_fault+0x22/0x30
  ? mlx5_tc_ct_entry_add_rule+0x2b1/0x2f0 [mlx5_core]
  ? mlx5_tc_ct_entry_add_rule+0x1d5/0x2f0 [mlx5_core]
  mlx5_tc_ct_block_flow_offload+0xc6a/0xf90 [mlx5_core]
  ? nf_flow_offload_tuple+0xd8/0x190 [nf_flow_table]
  nf_flow_offload_tuple+0xd8/0x190 [nf_flow_table]
  flow_offload_work_handler+0x142/0x320 [nf_flow_table]
  ? finish_task_switch.isra.0+0x15b/0x2b0
  process_one_work+0x16c/0x320
  worker_thread+0x28c/0x3a0
  ? __pfx_worker_thread+0x10/0x10
  kthread+0xb8/0xf0
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x2d/0x50
  ? __pfx_kthread+0x10/0x10
  ret_from_fork_asm+0x1a/0x30
  </TASK>

Fixes: 7fac5c2eced3 ("net/mlx5: CT: Avoid reusing modify header context for natted entries")
Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
index dcfccaaa8d91..92d5cfec3dc0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
@@ -866,7 +866,7 @@ mlx5_tc_ct_entry_add_rule(struct mlx5_tc_ct_priv *ct_priv,
 	return 0;
 
 err_rule:
-	mlx5_tc_ct_entry_destroy_mod_hdr(ct_priv, zone_rule->attr, zone_rule->mh);
+	mlx5_tc_ct_entry_destroy_mod_hdr(ct_priv, attr, zone_rule->mh);
 	mlx5_put_label_mapping(ct_priv, attr->ct_attr.ct_labels_id);
 err_mod_hdr:
 	kfree(attr);
-- 
2.44.0


