Return-Path: <netdev+bounces-158496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E376A122DE
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 12:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08E297A3383
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 11:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA9F236ED0;
	Wed, 15 Jan 2025 11:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MDd4FMis"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA14324169E
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 11:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736941288; cv=fail; b=GhxDIm1hGBBX0/K+hVhPKmiCr1vt6BFHgBEgjmTmZmUMhDC5JmSMbJkOpPC+eNdAzdjYgpz3dJrYell9f1EmWX4HWNTv98VyKovKEbbQbBOku+Mo5w92BOfIG+OsCq5FygNu1Gc77X6edSqjlf1NfGvi28OTmgdRHWmpSq9Vasw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736941288; c=relaxed/simple;
	bh=rM1en+7yA+hB1OBF8P1c1w3Kpj5fQMw/fIOLlVizw1A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hpyTfXLMuS5lU1fU1YefWdulRODo2joB8iqClmyhIBnq0mg8BOlAG5RRu5UKRyIe6bjVNubcPNassvvLIPrAoukiDpAAmlHMJ7MPVLOxSNuuxHtlX6oPhCMjfYSBKDVlOMzdsqJ/OXXD4J0ALEqW/FFBR1A3RP+nGmp+lV9gVN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MDd4FMis; arc=fail smtp.client-ip=40.107.223.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iv8YurL63lPUyWtyVenf55pSADK+SOIacweHf/Blz3SV9B2OXdxDAxVwMBrS0e2g4Ae3YiXoebW+DXdH+rSC00M3v2yQ/3TuQFXqT2bf6Tw3bMW/h46xbCUwlFeTte/nDHk8QLSbsbXlwRUzoEy77DMUqm/IV9tpX2DbVzL9RkBIgjYzBbqFMsQWmzzEc2zM3VBTcI7EwurfMiC2u57INlOgSYUd5u4aVoh9HHOh8gunzClT8N2fjmktHxEctOrgbWxN2/gA/j1+CPLXHQG3DB0ruGMK5gD52+PkmBq+IcxhsyXD93YlxSmJA3JY6Cq1EU9RzNQcMTjXF3UiBnkUgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hOpJDs0iwABTQx8ZS7h9wnldFlBkGWqxgGT5WugSHpo=;
 b=RrntXL4bsReC0kV1PEYDcLbdMEXcLCW3IMnQd2Py+iOw1AJgM1c1TxLleTCkJrhjx+ftdcsJaLRclE2qcPJ4O3gcylrR7GhuMssL8JJ+GfUqF9CwnPOCgfyQajuS0gfRxAy1FK9bxbdMMwEOwiV2qTmWX/p4d01vpG18LNw+8s3dsoC7pVtsizFjUYu1yHZr7Vnbi59hrFtzCQ95WIQ0bwSUhqxChtHj/h+KbFXdIEQY8zJl/bHwacvY86PXFPZKFoCDBiiNWsiH/kpSFBE7orkYRoXkocVsrGW6ECbra3TPSlGn7SoF1yhl8pSWe8BAGXEHf3NBvokjGDvvXqpiCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hOpJDs0iwABTQx8ZS7h9wnldFlBkGWqxgGT5WugSHpo=;
 b=MDd4FMis1/7sOfIpEn+LW197e+J7yfPtrpEayQVD16PJLbQZD2zdurXySncmem9X3XC6BkMyyF07JHLmWAE1QPit6KC9T74VX+lm6RUEhw1paICm0qjGn0NTHCMM1hwYnxETtB29jY7qGKGSA9kUfpVDMfT5nI7Gio56LiCV7coY8wBeeQS9vPcQ5f3AmT2IOqdnHLeYs7o6vDR+g1yt/3hPmdrhcl4zMg6NQrxdkqCafWOAmUFZoaE35PnSHH4Y3Q0iIP1d+EDe32fK0NfndjOP9FpjpRpTvM+66O4pJVLLJQAZdyhBNxcBnHYcCiBdwy1ppVIJ9OERafK7+LOGjQ==
Received: from BYAPR07CA0059.namprd07.prod.outlook.com (2603:10b6:a03:60::36)
 by SA1PR12MB7318.namprd12.prod.outlook.com (2603:10b6:806:2b3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Wed, 15 Jan
 2025 11:41:22 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:a03:60:cafe::f1) by BYAPR07CA0059.outlook.office365.com
 (2603:10b6:a03:60::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.12 via Frontend Transport; Wed,
 15 Jan 2025 11:41:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Wed, 15 Jan 2025 11:41:21 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 15 Jan
 2025 03:41:07 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 15 Jan
 2025 03:41:06 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 15 Jan
 2025 03:41:03 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Mark Zhang
	<markzhang@nvidia.com>, Jacob Keller <jacob.e.keller@intel.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net V2 4/7] net/mlx5: Clear port select structure when fail to create
Date: Wed, 15 Jan 2025 13:39:07 +0200
Message-ID: <20250115113910.1990174-5-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250115113910.1990174-1-tariqt@nvidia.com>
References: <20250115113910.1990174-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|SA1PR12MB7318:EE_
X-MS-Office365-Filtering-Correlation-Id: f863d475-54bc-480c-e235-08dd35598868
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Gg7XpujvReSZmjxtRATdV09AEIIpt8Z7uuY5wvjFkWK8JXrUW2SIJZg3KDEy?=
 =?us-ascii?Q?Z7kIxeBuY3U/U181sQLR++06VkXdzgjpcHf5ttjF6Ei8hyGTVjEFybokvNdZ?=
 =?us-ascii?Q?FfP9jo/e5on0brAYgBImye/u1mRbTIRW93PYwf0JYS2tXNrzsFMkj0L5Etov?=
 =?us-ascii?Q?UZrUoU/4KWmBpquChiJlYZqP1qwbBjbJWFHjZIr9aE5mHMxPMhrJtfZshtGz?=
 =?us-ascii?Q?GMMfVvO0Z0EvK47fJJHS80qR1+3aj5r4xe3GTS6MMgIl36EqiyIsLoPzLbs7?=
 =?us-ascii?Q?kuWGvbbJpXaMKS1WStQ9vhqDiMKDf3lTq586TQaQh7yvleyiOMdLhUf0tzhf?=
 =?us-ascii?Q?1P3f7Xpwur/cbxYstdV3zxToUPjmBenTzXlUiZiiC66ofury0D/sH8d/kEny?=
 =?us-ascii?Q?KfpgTvj1qZokUNnhHu+66+y5Ooq5D3zKyitl8dYxhFYeGOxHuBI3rbeWc1OT?=
 =?us-ascii?Q?Z2Amc+PmTxfYJoHXx8Adtb42tQ1lkPuZty5WYIXqrKeFnnbkau5NS5iLX0pK?=
 =?us-ascii?Q?+B4SgpKEImTze5TeudEGYFJU0o9H9nnLNEml9noAfiheNN2ozdQwy2X7G+pU?=
 =?us-ascii?Q?nh7+hWuctmsWbgx0jKDPTxvfyxTPLrkGXZ2bCl2LXk+xs+DDfXnjlVoZ26Rd?=
 =?us-ascii?Q?4K4nrieerWudkU48ZIAIpxHfVWzGG3qnlGASiMXLC4EtvcdzLlZiBSIjAm/7?=
 =?us-ascii?Q?1JLePGdiI3E1cjiX0JK5QNSJ7bTEhOym3ez0Re8PeMUaVAV2zxaZnMh645sH?=
 =?us-ascii?Q?aU+ImrxyE1AVQq2v/DF6llokMxGutYG1daETcGSDxE3Q947d9DooYHiFTDHB?=
 =?us-ascii?Q?TXm6Xc3ObiCDGXf/safwLXNhIifhJWKD3ZFhGUQbZUrpoZAj5UJEcXFCgZKC?=
 =?us-ascii?Q?aVYTvWJaS1SF+mYohwf6aPEHWrQL5F4ZOfBNSnMEgxe6i2jz+poULeRE5B5e?=
 =?us-ascii?Q?zRI+h6JgN3ILi7h2h76CTHhi09ADpquYoiHnWx4CQhm0j6VWD/sUj9JddxEQ?=
 =?us-ascii?Q?GI6a2Uf6UGPWp6xpl5NfwyrggALAWvIdNpPYqv2DfF21knDRCJ7oqGSUUhl5?=
 =?us-ascii?Q?St1ysTVPOyOdcI9uGSSU/+1Rab5e9qCKANJTwN+4xrYrFjI3+b3DjowYjPvH?=
 =?us-ascii?Q?xW0PMPkW0Z4KDnlyF/L1AY27QRujmA8t7C7iHDNvUOiZFYyLgLX+VvoT55MS?=
 =?us-ascii?Q?Ve0jWNwmqYYzEqjhl1hsxh3d2wBoWTJYCFoQ42Kyw6Jtp3O65cUJHtterSBu?=
 =?us-ascii?Q?KzAfTaAZRYa0CGmcJO8p1SmswdfpzJ45HfGXUkmD0I8r/o/U5ae27wWcsUnO?=
 =?us-ascii?Q?k81ayjgo8uTZVQRCusgvwzEP3VYZXVUqbh2d0dr3VXXH7PBh7L+sBRL39BEh?=
 =?us-ascii?Q?YMcAGuX559TLZe9Az1dRWPA6UhN8yQCHZWepKJVBcuOx19q6sEG7QRz9f8Ks?=
 =?us-ascii?Q?1CecqwwBvoAIogeel1kFz4uRH5w43NLJeW+D5LReJZYHOpDaXcEsTZuIPKxH?=
 =?us-ascii?Q?nXW7fS29OhN1SrQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 11:41:21.2164
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f863d475-54bc-480c-e235-08dd35598868
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7318

From: Mark Zhang <markzhang@nvidia.com>

Clear the port select structure on error so no stale values left after
definers are destroyed. That's because the mlx5_lag_destroy_definers()
always try to destroy all lag definers in the tt_map, so in the flow
below lag definers get double-destroyed and cause kernel crash:

  mlx5_lag_port_sel_create()
    mlx5_lag_create_definers()
      mlx5_lag_create_definer()     <- Failed on tt 1
        mlx5_lag_destroy_definers() <- definers[tt=0] gets destroyed
  mlx5_lag_port_sel_create()
    mlx5_lag_create_definers()
      mlx5_lag_create_definer()     <- Failed on tt 0
        mlx5_lag_destroy_definers() <- definers[tt=0] gets double-destroyed

 Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
 Mem abort info:
   ESR = 0x0000000096000005
   EC = 0x25: DABT (current EL), IL = 32 bits
   SET = 0, FnV = 0
   EA = 0, S1PTW = 0
   FSC = 0x05: level 1 translation fault
 Data abort info:
   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
 user pgtable: 64k pages, 48-bit VAs, pgdp=0000000112ce2e00
 [0000000000000008] pgd=0000000000000000, p4d=0000000000000000, pud=0000000000000000
 Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
 Modules linked in: iptable_raw bonding ip_gre ip6_gre gre ip6_tunnel tunnel6 geneve ip6_udp_tunnel udp_tunnel ipip tunnel4 ip_tunnel rdma_ucm(OE) rdma_cm(OE) iw_cm(OE) ib_ipoib(OE) ib_cm(OE) ib_umad(OE) mlx5_ib(OE) ib_uverbs(OE) mlx5_fwctl(OE) fwctl(OE) mlx5_core(OE) mlxdevm(OE) ib_core(OE) mlxfw(OE) memtrack(OE) mlx_compat(OE) openvswitch nsh nf_conncount psample xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink xfrm_user xfrm_algo xt_addrtype iptable_filter iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 br_netfilter bridge stp llc netconsole overlay efi_pstore sch_fq_codel zram ip_tables crct10dif_ce qemu_fw_cfg fuse ipv6 crc_ccitt [last unloaded: mlx_compat(OE)]
  CPU: 3 UID: 0 PID: 217 Comm: kworker/u53:2 Tainted: G           OE      6.11.0+ #2
  Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
  Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
  Workqueue: mlx5_lag mlx5_do_bond_work [mlx5_core]
  pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  pc : mlx5_del_flow_rules+0x24/0x2c0 [mlx5_core]
  lr : mlx5_lag_destroy_definer+0x54/0x100 [mlx5_core]
  sp : ffff800085fafb00
  x29: ffff800085fafb00 x28: ffff0000da0c8000 x27: 0000000000000000
  x26: ffff0000da0c8000 x25: ffff0000da0c8000 x24: ffff0000da0c8000
  x23: ffff0000c31f81a0 x22: 0400000000000000 x21: ffff0000da0c8000
  x20: 0000000000000000 x19: 0000000000000001 x18: 0000000000000000
  x17: 0000000000000000 x16: 0000000000000000 x15: 0000ffff8b0c9350
  x14: 0000000000000000 x13: ffff800081390d18 x12: ffff800081dc3cc0
  x11: 0000000000000001 x10: 0000000000000b10 x9 : ffff80007ab7304c
  x8 : ffff0000d00711f0 x7 : 0000000000000004 x6 : 0000000000000190
  x5 : ffff00027edb3010 x4 : 0000000000000000 x3 : 0000000000000000
  x2 : ffff0000d39b8000 x1 : ffff0000d39b8000 x0 : 0400000000000000
  Call trace:
   mlx5_del_flow_rules+0x24/0x2c0 [mlx5_core]
   mlx5_lag_destroy_definer+0x54/0x100 [mlx5_core]
   mlx5_lag_destroy_definers+0xa0/0x108 [mlx5_core]
   mlx5_lag_port_sel_create+0x2d4/0x6f8 [mlx5_core]
   mlx5_activate_lag+0x60c/0x6f8 [mlx5_core]
   mlx5_do_bond_work+0x284/0x5c8 [mlx5_core]
   process_one_work+0x170/0x3e0
   worker_thread+0x2d8/0x3e0
   kthread+0x11c/0x128
   ret_from_fork+0x10/0x20
  Code: a9025bf5 aa0003f6 a90363f7 f90023f9 (f9400400)
  ---[ end trace 0000000000000000 ]---

Fixes: dc48516ec7d3 ("net/mlx5: Lag, add support to create definers for LAG")
Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
index ab2717012b79..39e80704b1c4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
@@ -530,7 +530,7 @@ int mlx5_lag_port_sel_create(struct mlx5_lag *ldev,
 	set_tt_map(port_sel, hash_type);
 	err = mlx5_lag_create_definers(ldev, hash_type, ports);
 	if (err)
-		return err;
+		goto clear_port_sel;
 
 	if (port_sel->tunnel) {
 		err = mlx5_lag_create_inner_ttc_table(ldev);
@@ -549,6 +549,8 @@ int mlx5_lag_port_sel_create(struct mlx5_lag *ldev,
 		mlx5_destroy_ttc_table(port_sel->inner.ttc);
 destroy_definers:
 	mlx5_lag_destroy_definers(ldev);
+clear_port_sel:
+	memset(port_sel, 0, sizeof(*port_sel));
 	return err;
 }
 
-- 
2.45.0


