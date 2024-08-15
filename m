Return-Path: <netdev+bounces-118745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A17EA9529C0
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 09:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DC9B1F21DB5
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 07:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F410C17A5A6;
	Thu, 15 Aug 2024 07:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FbDF3woV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2074.outbound.protection.outlook.com [40.107.96.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D9C17A5A4
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 07:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723706316; cv=fail; b=KzsqZrbzSY7jCB/B/KuXnHpL04UG5hQOP7gy8HIowuyuffV0bsWU84KoTxTosgzvLcpNIYC2DPSzqIpFRdlA95HIs9n87GUdIAg9M1fsBeVAQ9t3no/LRYYZ3HILyWeYG9cQGji6+bvCU6Q5CvmP6gf9hSml48fJHtOmbadTjnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723706316; c=relaxed/simple;
	bh=pjJvFNxJ/EZZLlTYAOKFJvP4aV4uMQ/0zQv+CuKPhjo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ezRqPVGT/ZYzctCA+gMDpbb3mAkVQJJERp/hWxfkgDb+Ht/zbziS5I5ZzeyoFnMEmABDWqtvOFjNRo3jPrUiCsu2ApImzteO4tvRU/W4XEheEqTcmISVinrF2ogHDXNZQ6huWI1Bi5vSmGmikgimMy3Fpk/NDvduntwXwLytRBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FbDF3woV; arc=fail smtp.client-ip=40.107.96.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=De5BjwKh97gg1buti4kZhWyW4vfjtEdPsag9tBDEJeUkFxOIrKNFFWBM14TTbrfLT+gWJdfNWD5SRL6aUf9J0yA5YPkfF9eVVVJ+Cg7uALpOt2ltBGZcqiJj/f0SGlvMb9YKOKqB1w1fwRRDQb1KAu+RZ7YfZffHB5iskinFEHL6OLQJZnlCbgVFoNdVwwLZJNDtqjvp8w3ATfMKsDFefokLqElhWOFqrZpjvxNK2z9CuIEYfbpkIEhRROCyHK5MCaGEpGRebJVOo44mEsraUpxZfMPulAN0Y+Fmx34lBGjxv9c7S5Kpw65CkOYvB4IIALK6IMuS6vXbgecDUH4Dgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7ff58liXOM93rg18aSeGqkMbGP/0DI2D6nk5GBzYC0=;
 b=piTn0pTghM5Qyany3PMv8mb3wcICnDnymlNuLUH/gjHwOLByp+ByMdthQebz4u5FqeCkCCcQNE9t0oVMALGVvYVsG6HKGA32ecB/D9fhvTB4aB2MYZqmezob8IfzOgtBmfZnP2+2uO9vPFVZcg+klZXAhbD7kn7Ityh2kjh55fuc32VtmKw0r/lmYoH6Vz7lX0rpwQj7GxR57JJIyxUZysIZwzfWmLDjxIlc4WFvMLGjejU2BxbjmL/YCeDUlFkeQ6SYMTvFf6PH03E/5B83LbqcVYAVNPO6nI0aoYdvl9duDz3TzZrF6mKT6EBbxwPOQwcTgyU+ds8oDvZuEAQjMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7ff58liXOM93rg18aSeGqkMbGP/0DI2D6nk5GBzYC0=;
 b=FbDF3woVTIIyfMCJ3gDTgm50HvyI5oZqhhfM4SxmqvAsbdh8z+zEs7TU3M7eUpfLc8phmbcWEUz0FNLAGWzk6GGl+ikUdfMFgTSKu6fklVwY8mxVWRMDMsP4VE+MAXg8R35Ch8jFMijqaUgz1agNIKg5WGuWbsMjB1iBz3ExgpLsgzyfB6Z0bkVqZoeyWYOVEiaAlKzLV6uVK3oiCr+BIvAOlzVZuQwGB5cTncBPzBMeGTT9kat8/bRO9ka/Ah1Jfae4aXQQ0xSBBxwbfpwAE+VTbryNdiWK4vQHj7A7h2MzHaqfr4WIvyYp9e3jprVocT/Nh9TVt3mej8mLtGpJ1g==
Received: from SN6PR01CA0002.prod.exchangelabs.com (2603:10b6:805:b6::15) by
 SA3PR12MB8024.namprd12.prod.outlook.com (2603:10b6:806:312::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Thu, 15 Aug
 2024 07:18:31 +0000
Received: from SA2PEPF00003AEA.namprd02.prod.outlook.com
 (2603:10b6:805:b6:cafe::7e) by SN6PR01CA0002.outlook.office365.com
 (2603:10b6:805:b6::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22 via Frontend
 Transport; Thu, 15 Aug 2024 07:18:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003AEA.mail.protection.outlook.com (10.167.248.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 07:18:31 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 Aug
 2024 00:18:19 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 Aug
 2024 00:18:19 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 15 Aug
 2024 00:18:16 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Patrisious Haddad
	<phaddad@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net 4/4] net/mlx5: Fix IPsec RoCE MPV trace call
Date: Thu, 15 Aug 2024 10:16:11 +0300
Message-ID: <20240815071611.2211873-5-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240815071611.2211873-1-tariqt@nvidia.com>
References: <20240815071611.2211873-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEA:EE_|SA3PR12MB8024:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b45cb3d-5dcc-45f1-3ce9-08dcbcfa777e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cqUEwxkWAcqxjHZ9vXI4m/OBrv3eLwp8GwqwGI2SVrgqxeTilrUbzKQktt0y?=
 =?us-ascii?Q?zRfme92RxSKs14SiPPZs+KttcrWKX+EfzTMcEjggsJmUPln2CYVIAIz1MVky?=
 =?us-ascii?Q?+YUIQrc41F369mCd1dfQFvWDILVqxtp+CmtOaEU5Fnan8kyMCWsbAwciW1cU?=
 =?us-ascii?Q?fd5W6o/qIlV1sRaBbtgUOUY8cSXKgMHySU6CzcojK8RAw6FnMMsVywhkXkF8?=
 =?us-ascii?Q?MI8dD1iiE3XC9AOpW6KSQZVwiud8z8baQgH/iCSZTr/hBmTwtqq9glajzj+X?=
 =?us-ascii?Q?NQFRW3IJG7nbpoix0dCMIOFfyIQxPp5dGMXXz1WmwK3zIMamnAkrm7AWvQ3x?=
 =?us-ascii?Q?5RPlxyn8dFlXKbnD4pBijOkVmbetOpfa5SLo58Yaqx8IexhmU0FY27NjbNEE?=
 =?us-ascii?Q?4X/8NgpJWmAFuxKFS8J8FMVaC/vF2QYZJU8XeOJ7h5jqqSedIe9sdHBYoj5w?=
 =?us-ascii?Q?wuXi5j9ptzgnwzKuk48tiOYsy0sqzuvRlcbbCkrYaFleP6p9ODu4l7bqoRFP?=
 =?us-ascii?Q?A+A7gVnt1HTpuTjdDJMph/D4pPCJxqzu5cxkwWRr/u7+QkYFg3tEIr9xtnO0?=
 =?us-ascii?Q?ARoVzDm9HTtD7llkJrsOSeDgnMoUXN+pkkSaLEKEmQzTfGs+dcPcC19yXQUE?=
 =?us-ascii?Q?UkKs06eqHIg/LucAtAVGeyHPM/olAC12cY9dzJv6ukQJLGtIfRnQu4ajV83i?=
 =?us-ascii?Q?BRvtZ42eeh0R+yzDtcCuyb573wKf2ObsNWQ27IFT7EcsEQiNR6ru1xMtew0p?=
 =?us-ascii?Q?rZRSRk80/+UcKS1AV2NL2CpxMhQYD4BEg8O3t6orJaG39/WB2gE2varY3o0r?=
 =?us-ascii?Q?//u4m5AdEZB7QwW9bp4IuwMKslVPOc69/DqieL7WZSLYdizPfT9K6Hcx/H7Z?=
 =?us-ascii?Q?EbgSooFxBZ9IL+AeqjJbRLIp9CZ9TRovywpC6r2pPTyFbOKMJSLQ/Xl7VH9S?=
 =?us-ascii?Q?QF86LBxiRjgXxvQ/AvdPlyYNv0Lswx33S9t2UtKS9WV+3FctGa77HEX5XjPV?=
 =?us-ascii?Q?ySVDQM6o/onE6EHElIkk1PGmOHDryXwz+k/ppSJhkFsdVekBpobZqSI/VQXv?=
 =?us-ascii?Q?P9M7nFJd6Sg03hFOwtQ9t3h1pr/nf04cmcNBbj2Q5bifZyHuDfwVZVEzzeWC?=
 =?us-ascii?Q?Waicqy/H5hjSbXLWguWI4Af4CKNhoTFdg0U+VNzJ3EKw+rEDgMySBxCnf6fw?=
 =?us-ascii?Q?kXPtGTJwlWeLtso6ClKK4hAvjgQPKz99+KNFZ10NKjuEHLLpqw6MgnT2y8Zl?=
 =?us-ascii?Q?TuWsLJkQ36oQGXHQb+GuSjC5hTFx6IQ21yOxXxCMZfqeeUERL7qEn1p2t8eT?=
 =?us-ascii?Q?D4bDVlZJwQSCq7hGoNPvwANGj3k0Vc/vghNHd6sdWdaVgz1eI+JbnxPqCiT1?=
 =?us-ascii?Q?HFFOA6Zcb3vhtVYLmg39VX+7Z84/wWELDuSxBU75/nTKA4EBFnQzNtiqX743?=
 =?us-ascii?Q?mY1OgauUj1BjR6n1jWVp3pYC7gBASC4S?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 07:18:31.0969
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b45cb3d-5dcc-45f1-3ce9-08dcbcfa777e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8024

From: Patrisious Haddad <phaddad@nvidia.com>

Prevent the call trace below from happening, by not allowing IPsec
creation over a slave, if master device doesn't support IPsec.

WARNING: CPU: 44 PID: 16136 at kernel/locking/rwsem.c:240 down_read+0x75/0x94
Modules linked in: esp4_offload esp4 act_mirred act_vlan cls_flower sch_ingress mlx5_vdpa vringh vhost_iotlb vdpa mst_pciconf(OE) nfsv3 nfs_acl nfs lockd grace fscache netfs xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_reject_ipv4 nft_compat nft_counter nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 rfkill cuse fuse rpcrdma sunrpc rdma_ucm ib_srpt ib_isert iscsi_target_mod target_core_mod ib_umad ib_iser libiscsi scsi_transport_iscsi rdma_cm ib_ipoib iw_cm ib_cm ipmi_ssif intel_rapl_msr intel_rapl_common amd64_edac edac_mce_amd kvm_amd kvm irqbypass crct10dif_pclmul crc32_pclmul mlx5_ib ghash_clmulni_intel sha1_ssse3 dell_smbios ib_uverbs aesni_intel crypto_simd dcdbas wmi_bmof dell_wmi_descriptor cryptd pcspkr ib_core acpi_ipmi sp5100_tco ccp i2c_piix4 ipmi_si ptdma k10temp ipmi_devintf ipmi_msghandler acpi_power_meter acpi_cpufreq ext4 mbcache jbd2 sd_mod t10_pi sg mgag200 drm_kms_helper syscopyarea sysfillrect mlx5_core sysimgblt fb_sys_fops cec
 ahci libahci mlxfw drm pci_hyperv_intf libata tg3 sha256_ssse3 tls megaraid_sas i2c_algo_bit psample wmi dm_mirror dm_region_hash dm_log dm_mod [last unloaded: mst_pci]
CPU: 44 PID: 16136 Comm: kworker/44:3 Kdump: loaded Tainted: GOE 5.15.0-20240509.el8uek.uek7_u3_update_v6.6_ipsec_bf.x86_64 #2
Hardware name: Dell Inc. PowerEdge R7525/074H08, BIOS 2.0.3 01/15/2021
Workqueue: events xfrm_state_gc_task
RIP: 0010:down_read+0x75/0x94
Code: 00 48 8b 45 08 65 48 8b 14 25 80 fc 01 00 83 e0 02 48 09 d0 48 83 c8 01 48 89 45 08 5d 31 c0 89 c2 89 c6 89 c7 e9 cb 88 3b 00 <0f> 0b 48 8b 45 08 a8 01 74 b2 a8 02 75 ae 48 89 c2 48 83 ca 02 f0
RSP: 0018:ffffb26387773da8 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffffa08b658af900 RCX: 0000000000000001
RDX: 0000000000000000 RSI: ff886bc5e1366f2f RDI: 0000000000000000
RBP: ffffa08b658af940 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffa0a9bfb31540
R13: ffffa0a9bfb37900 R14: 0000000000000000 R15: ffffa0a9bfb37905
FS:  0000000000000000(0000) GS:ffffa0a9bfb00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055a45ed814e8 CR3: 000000109038a000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 ? show_trace_log_lvl+0x1d6/0x2f9
 ? show_trace_log_lvl+0x1d6/0x2f9
 ? mlx5_devcom_for_each_peer_begin+0x29/0x60 [mlx5_core]
 ? down_read+0x75/0x94
 ? __warn+0x80/0x113
 ? down_read+0x75/0x94
 ? report_bug+0xa4/0x11d
 ? handle_bug+0x35/0x8b
 ? exc_invalid_op+0x14/0x75
 ? asm_exc_invalid_op+0x16/0x1b
 ? down_read+0x75/0x94
 ? down_read+0xe/0x94
 mlx5_devcom_for_each_peer_begin+0x29/0x60 [mlx5_core]
 mlx5_ipsec_fs_roce_tx_destroy+0xb1/0x130 [mlx5_core]
 tx_destroy+0x1b/0xc0 [mlx5_core]
 tx_ft_put+0x53/0xc0 [mlx5_core]
 mlx5e_xfrm_free_state+0x45/0x90 [mlx5_core]
 ___xfrm_state_destroy+0x10f/0x1a2
 xfrm_state_gc_task+0x81/0xa9
 process_one_work+0x1f1/0x3c6
 worker_thread+0x53/0x3e4
 ? process_one_work.cold+0x46/0x3c
 kthread+0x127/0x144
 ? set_kthread_struct+0x60/0x52
 ret_from_fork+0x22/0x2d
 </TASK>
---[ end trace 5ef7896144d398e1 ]---

Fixes: dfbd229abeee ("net/mlx5: Configure IPsec steering for egress RoCEv2 MPV traffic")
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/lib/ipsec_fs_roce.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/ipsec_fs_roce.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/ipsec_fs_roce.c
index 234cd00f71a1..b7d4b1a2baf2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/ipsec_fs_roce.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/ipsec_fs_roce.c
@@ -386,7 +386,8 @@ static int ipsec_fs_roce_tx_mpv_create(struct mlx5_core_dev *mdev,
 		return -EOPNOTSUPP;
 
 	peer_priv = mlx5_devcom_get_next_peer_data(*ipsec_roce->devcom, &tmp);
-	if (!peer_priv) {
+	if (!peer_priv || !peer_priv->ipsec) {
+		mlx5_core_err(mdev, "IPsec not supported on master device\n");
 		err = -EOPNOTSUPP;
 		goto release_peer;
 	}
@@ -455,7 +456,8 @@ static int ipsec_fs_roce_rx_mpv_create(struct mlx5_core_dev *mdev,
 		return -EOPNOTSUPP;
 
 	peer_priv = mlx5_devcom_get_next_peer_data(*ipsec_roce->devcom, &tmp);
-	if (!peer_priv) {
+	if (!peer_priv || !peer_priv->ipsec) {
+		mlx5_core_err(mdev, "IPsec not supported on master device\n");
 		err = -EOPNOTSUPP;
 		goto release_peer;
 	}
-- 
2.44.0


