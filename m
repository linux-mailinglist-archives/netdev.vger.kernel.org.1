Return-Path: <netdev+bounces-190406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4FAAB6BC9
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 14:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD10A1B67E22
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 12:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DCC2797A0;
	Wed, 14 May 2025 12:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VgPWNM+F"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD4C2798EF
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 12:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747227073; cv=fail; b=D9oiotwtYdhPnvAyaz8aDTXBBa5qPWyGYpe6y2DZenTFHx4QxSWtC6e5bbu9MEeBYC8NON7EQfWdj8WEhvPAwyO4+ijl8+6kyY9iTOZm+Ted0OC4zfWRAvjDSsMcEn21yFUBZsyXVOTo7SwdzISc2dFg1TWeYyfB4OaVXRqJuvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747227073; c=relaxed/simple;
	bh=bGY/wng07a7ILQL0tLABmjRPkdDz2tmIGGqRD6Dx61k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mY7x/M9evEcNPtgNtldFFvlZeZWoRf+0o6Alzigp1NIJ0EepofZHZj+QqoMFeMB5tXSWy/FMoxk4EIZWBvdSjQZOB9mXVHmpozYqjCvqwiweRQuSjjpR7Nf+2BCwcSqP3nnMTl070dNzgJKONK0FlHPaxonO8DKNoBlRNtGTqNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VgPWNM+F; arc=fail smtp.client-ip=40.107.244.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ayenk0UkXMm8FoNAeDxwKOoiO1eUmL3WAxQ/3zmZiu2ggdCJ8kj+ARVSQc1R8Z4NWKxl+P26XdFzpzMspCILFektQgfNt0yscODAjYUMtCj7YDXblpqb+0C4OezuLWYTjHNkeYM2kfBR/n91qbHiaWbTN+KLkD0jmzRx1OO1aWmTmVsiQNBFbD9H5Wp+LyHLU4TD3xMkoV53z84CZ2hMoDZGnEOdUaV4cuR60qu+e+ijDHlNZ2FCFc3VKROZ3TyWZE6lZmcl9I1xX70Gy7P5cEH2c8xroiZy3KcZ2BNgzWqMttrVGUx4LufLiSc7JpUA+R3Hz+HGojBLZEi6vlZ7Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TDKQdZM4Z5qKbt5EJ4mFETT0iqPmVJM+DvrNJvUEr+0=;
 b=F+u0adU/OTmdS/Wqd/1cGRV0txUSsT+fe4w82CECDLJSNy6p/v/gjSfMidJHgo42817w0MMzvUMEseC2ggjy76p7GqibwA1uin7Ce6x9GDRL7Gnss9HIt57VUoDiPJBgAYXQ1Ieq5Z8ekhyUeaVcOM1p8LLFdjPzYj1jQ/xxUOfcS6ftSqW2w+zJCvPKz52nPmzHTjnq36m1+SHodDg6KcFfuW5tcbZ5PGlBt7DywmbgyV2M81FErXsMtf3cN0AT+64xpYrPxelj1gVAfaRXa4D/6gavGrJluX7sfXHTIkeAfJ7NfGnF3wJPaToOixeawCDtGGuFWj0gtIuYaRzzkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TDKQdZM4Z5qKbt5EJ4mFETT0iqPmVJM+DvrNJvUEr+0=;
 b=VgPWNM+FWwSG7RBP42CEnKQG5eVz0lUUxr65nIjeY8Agf+LkYCUCE5+s3Gzqw1IUcqaOncHBjhuChj+IVSpuPuSlmIWNP7y/CgG2aEEEXx1RsfKHul06NjRXRXuTXR+AT5NNdFQbfuRIRc1CWz183Us/RUCFbNhzZ8enKaX7565IW5FnatoYKkWaXo9pIg5R7LJEekl1BCZpFi1Ultklol2ooyxxwpSF1/KBE8ue1hJHanosuGH5HBGF9ZknRGrEmG8rlrXUPOX1QSt8ENNz2zT/vKPrmmrKQeTyMmIb5Se+/DkLI35MtLGXYDUyD+PCo8hhhdvZCDKJ5KFG6U+jUQ==
Received: from MW4PR02CA0015.namprd02.prod.outlook.com (2603:10b6:303:16d::6)
 by CH2PR12MB4247.namprd12.prod.outlook.com (2603:10b6:610:7c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Wed, 14 May
 2025 12:51:05 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:303:16d:cafe::8b) by MW4PR02CA0015.outlook.office365.com
 (2603:10b6:303:16d::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Wed,
 14 May 2025 12:51:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Wed, 14 May 2025 12:51:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 14 May
 2025 05:50:39 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 14 May
 2025 05:50:35 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net] mlxsw: spectrum_router: Fix use-after-free when deleting GRE net devices
Date: Wed, 14 May 2025 14:48:05 +0200
Message-ID: <c53c02c904fde32dad484657be3b1477884e9ad6.1747225701.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|CH2PR12MB4247:EE_
X-MS-Office365-Filtering-Correlation-Id: 243718de-eaaa-4505-1b90-08dd92e5fcd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i+IAjpAkL/WVciUAIcXK2PXR1x1xGIupFpxMO2EAf/cmVkufgSKgFy94pBV9?=
 =?us-ascii?Q?tGKYSAWg6ZAOb/EejuXyJUJAFgpisr785cy8xl87yikw2nuBVzAlQ2RZI1sI?=
 =?us-ascii?Q?7+fypl7CtAVK6YPK46TWi3rFMY9POWcNWdreLUHA0jMOWw7Ko9q2/N2iKVhk?=
 =?us-ascii?Q?cVl9AIFGLpilAB48TfBD8wto8C/bejOIgyCLaE3SwUnSi60vUO5UoVxew3so?=
 =?us-ascii?Q?KiCLZ2od6V/skMBB29mMWDlNc05Psa+9PPlrjj/nQgDPJ8zafSLiBPWmgrmn?=
 =?us-ascii?Q?9hF6KSxV6oLP6EkQCxUyq/2+ENbJdVJnzGM6cCLBOsWdOY/seoW9vceiH2dc?=
 =?us-ascii?Q?suP/iGzI01cvbT2xOBk6d/IOXsGzTd2HUuj7iRvQ2nuhmnTTnBKT33CC4ay3?=
 =?us-ascii?Q?wBOna/e1Dlj+VMBMDVcVP/JpBs0oJyoIB5KDYlVD9oqUO1KB6ZLnYlmX2hMK?=
 =?us-ascii?Q?Rd04E8dhk/MvzxgZIFOk1TOtGdCCmBrR6m0CMU5J1pra+dfz6BVaZqnWQw6R?=
 =?us-ascii?Q?Z581PNNBhDOAhd9HE2HxF7rwV1BsrFTIoXMR44TkDbILlkMj2uppXx7zJFfc?=
 =?us-ascii?Q?AgZFM6ZrnbGbX//+zcHgza3+zHjxjQ91g8MBXEUAbgR2alhyd3rx/6CF106K?=
 =?us-ascii?Q?1eKSBlQ4wG4C9/H2nl0KwAe4I/0yDKUsolhaRdnftuFz7Ms+rDKw8FSm5b7m?=
 =?us-ascii?Q?09E6xi5TPP9d1okxJJGwHM6ecnIR4p8c9GCNhtd3Nd04aHA6ym6V26W+sOl1?=
 =?us-ascii?Q?5HWccEDm2+iggwTjOlBvORnpVAtbb3CJuUv6OU2sUEKMWIAu1wgZJI1Q+ePh?=
 =?us-ascii?Q?TCLdUEe+S8l/5fPSGE9mx/QVQP8QRACrtNU/B+jgY89wjvXQqzKuTVT+qzD8?=
 =?us-ascii?Q?ryNI8fVBOyt3cCdFkHHBSdJx1PXwKTR+CtSjABQ/WWK1MDRof/W/xeILWc6V?=
 =?us-ascii?Q?Leyma5MXRtL0SSRaPD36j/ScLSGDJ4RJtHxRsebwp/DkDHJ0A9OTn2rPGAhz?=
 =?us-ascii?Q?ug7Fk+WJAxgI6gzWfy4htkSxFlD8VDUTKGZvuAKkFuS74kAn925+oe+q1dhw?=
 =?us-ascii?Q?Crs+UQXTyTBamkuk6u5kxfl0Hm2eOXGq80ifhA65uRqJa/4VUhDol3J0PREC?=
 =?us-ascii?Q?h4YzVHQ7uFhpnRfIHojRHSZ1KiRMnnreKZWw8yaswftC76EKxHuyIjhPmPvF?=
 =?us-ascii?Q?8ULumwrpJFuPhr2Sfbvew0dsPpUuUGBgb8rcbDSGOEb9tToVfOrjKxpirnS1?=
 =?us-ascii?Q?c72fETIcSQKwg61nduQ0lPTQCKrX6JtDlofOPwR2JYyIW588ka6OcJ9UcVTQ?=
 =?us-ascii?Q?hegPreLYrz5j4rMDshlpe1C0bGltaDh+1zg+eIkBK6OlROd5hWX/r3t4uJ+o?=
 =?us-ascii?Q?CM5QK3ld3KwLE/dFXrT8JsYD5o61vzd0FtcENNH24Xlg2EEOe5HFMCZ7bFJ+?=
 =?us-ascii?Q?MXphDjoc0P5vqo/eiM3+6DNycBnRjFj+UWhCkpku0PAcoDoypeNklNXgCzE8?=
 =?us-ascii?Q?+kHqBAUVLjOFg2VfobPhbk7DMRVIWHethrGU?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 12:51:04.3322
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 243718de-eaaa-4505-1b90-08dd92e5fcd6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4247

From: Ido Schimmel <idosch@nvidia.com>

The driver only offloads neighbors that are constructed on top of net
devices registered by it or their uppers (which are all Ethernet). The
device supports GRE encapsulation and decapsulation of forwarded
traffic, but the driver will not offload dummy neighbors constructed on
top of GRE net devices as they are not uppers of its net devices:

 # ip link add name gre1 up type gre tos inherit local 192.0.2.1 remote 198.51.100.1
 # ip neigh add 0.0.0.0 lladdr 0.0.0.0 nud noarp dev gre1
 $ ip neigh show dev gre1 nud noarp
 0.0.0.0 lladdr 0.0.0.0 NOARP

(Note that the neighbor is not marked with 'offload')

When the driver is reloaded and the existing configuration is replayed,
the driver does not perform the same check regarding existing neighbors
and offloads the previously added one:

 # devlink dev reload pci/0000:01:00.0
 $ ip neigh show dev gre1 nud noarp
 0.0.0.0 lladdr 0.0.0.0 offload NOARP

If the neighbor is later deleted, the driver will ignore the
notification (given the GRE net device is not its upper) and will
therefore keep referencing freed memory, resulting in a use-after-free
[1] when the net device is deleted:

 # ip neigh del 0.0.0.0 lladdr 0.0.0.0 dev gre1
 # ip link del dev gre1

Fix by skipping neighbor replay if the net device for which the replay
is performed is not our upper.

[1]
BUG: KASAN: slab-use-after-free in mlxsw_sp_neigh_entry_update+0x1ea/0x200
Read of size 8 at addr ffff888155b0e420 by task ip/2282
[...]
Call Trace:
 <TASK>
 dump_stack_lvl+0x6f/0xa0
 print_address_description.constprop.0+0x6f/0x350
 print_report+0x108/0x205
 kasan_report+0xdf/0x110
 mlxsw_sp_neigh_entry_update+0x1ea/0x200
 mlxsw_sp_router_rif_gone_sync+0x2a8/0x440
 mlxsw_sp_rif_destroy+0x1e9/0x750
 mlxsw_sp_netdevice_ipip_ol_event+0x3c9/0xdc0
 mlxsw_sp_router_netdevice_event+0x3ac/0x15e0
 notifier_call_chain+0xca/0x150
 call_netdevice_notifiers_info+0x7f/0x100
 unregister_netdevice_many_notify+0xc8c/0x1d90
 rtnl_dellink+0x34e/0xa50
 rtnetlink_rcv_msg+0x6fb/0xb70
 netlink_rcv_skb+0x131/0x360
 netlink_unicast+0x426/0x710
 netlink_sendmsg+0x75a/0xc20
 __sock_sendmsg+0xc1/0x150
 ____sys_sendmsg+0x5aa/0x7b0
 ___sys_sendmsg+0xfc/0x180
 __sys_sendmsg+0x121/0x1b0
 do_syscall_64+0xbb/0x1d0
 entry_SYSCALL_64_after_hwframe+0x4b/0x53

Fixes: 8fdb09a7674c ("mlxsw: spectrum_router: Replay neighbours when RIF is made")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index 464821dd492d..a2033837182e 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -3014,6 +3014,9 @@ static int mlxsw_sp_neigh_rif_made_sync(struct mlxsw_sp *mlxsw_sp,
 		.rif = rif,
 	};
 
+	if (!mlxsw_sp_dev_lower_is_port(mlxsw_sp_rif_dev(rif)))
+		return 0;
+
 	neigh_for_each(&arp_tbl, mlxsw_sp_neigh_rif_made_sync_each, &rms);
 	if (rms.err)
 		goto err_arp;
-- 
2.49.0


