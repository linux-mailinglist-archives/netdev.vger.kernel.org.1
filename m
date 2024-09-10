Return-Path: <netdev+bounces-127033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A921973C03
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 17:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCE441C24060
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 15:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11F319DF58;
	Tue, 10 Sep 2024 15:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VAE0ODZf"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A213F19412D;
	Tue, 10 Sep 2024 15:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725982319; cv=fail; b=aB3ujABSHIplyeZB6rtw59HVvmjpexDQNfjc0/8thDfeeJ11p3rlSYX4x34oonWgBtjx00TAWbyJsi6quLMcK2rVTia5uTmybGZJFBurOZugupPAQKns33A68QtytTpR3s3cXDtfZfqGpyzEU3zJPH8AJL/XqYt+d6s+O/bWiQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725982319; c=relaxed/simple;
	bh=j6z3xWFWufGGYwAHjH2x8HvU1ixTm5wsE330RnA4aYk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Uwvm9VlseQJ9+WZjh1zwHKVzeluURS6NQQo9ZVvh/GlU9T5MTE2gxbHEbFvxUsQFHdhyoCarIfIba3dU3knJj+pp3OHOXjFnEIpWao4szC5vUIzAFeshwCzH50jY3lz2NSTS3ME+NGzjqHAnwK3fGyLzQFtuPmRWjVbS464HzRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VAE0ODZf; arc=fail smtp.client-ip=40.107.237.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=acRQ/ghLqypL8Ve7m02rmGmKHa0TiLoVT9P3q3h1iyJ4hIvlMmn2ItU7nr3plEc+VJq+Lrprl0iiz2GfsnzXHnfbrxmk7jnPQ0LNzV9kMcguyU36CdHIycsVP/LS9qN701WiHQVzokFQu9N8byilpSjprXXMqC/UTVWBFJMOBVGbap+qsZZ4WZucn7lBcGXVexn8goHW5Y5oFAUOdlgJO/OmLBK5K0sV19tHsc3nTxOmXXoUwVTLYEDVR1pmMsnZYS1sS9rHQK9wiK0fu98rZsmjV1QGbmIQTRAHVc9FCQxF2r7w1iJskULW+4PEMgvowScaDuoPA/zeQov4gCPcIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yl3SOU2uXkDzpPj/TGPWxLMTjngs9Qdh7ZnMJYYqVAA=;
 b=vjIdiL6REGFSAK6dtP/9ZzeAKKlOBKTzH+dVnWTj4NioqCJdkROi/MfUL0gKvefXctusyVpVFuLxcKshjL0ijzXxF5qZpv+ApyPI7gkexhJQ+6gKQWPVpK/ZBQEClbrUjlyLX48Ccd5MMDEU0jEkf2fxmIdwn5ILOR+CFfiImMP9BKCzD5HcaLmDjWz7q9sJiwzOGqVOGPTl1lveNceJBYTj8YnX7XzwDSZLKTt+WbYb46W8Kfz/8v9786tR/dJrM97N/kDuBgseq2WovEd8BeMXp5DLFmGGHp1MhtuNp3pCT+jnva6Qcv81iPtxADxf1xenwfVQPTh/yCJ1ljgsgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yl3SOU2uXkDzpPj/TGPWxLMTjngs9Qdh7ZnMJYYqVAA=;
 b=VAE0ODZfXqgH/9ZEKSO8xNAUcwb4XNL7vIU6r+GUdXP2hcucY4aV3dsrfTN2OhKnI7Bx8FxS+wbx58YAlYLQOH8V3rPzWa55eYoEGQhWc+njd5z1LjOghMvp00ic5/JAmFWKXfdcEPLw4CVg2AoRvy9IvEkYPxEkxfmgJVGzSIY=
Received: from SJ0PR05CA0186.namprd05.prod.outlook.com (2603:10b6:a03:330::11)
 by PH0PR12MB7838.namprd12.prod.outlook.com (2603:10b6:510:287::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Tue, 10 Sep
 2024 15:31:52 +0000
Received: from SJ5PEPF00000208.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::20) by SJ0PR05CA0186.outlook.office365.com
 (2603:10b6:a03:330::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Tue, 10 Sep 2024 15:31:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000208.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 10 Sep 2024 15:31:51 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Sep
 2024 10:31:50 -0500
Received: from xcbjco41x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 10 Sep 2024 10:31:49 -0500
From: <jonathan.s.cooper@amd.com>
To: Edward Cree <ecree.xilinx@gmail.com>, Martin Habets
	<habetsm.xilinx@gmail.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>
CC: Jonathan Cooper <jonathan.s.cooper@amd.com>, <netdev@vger.kernel.org>,
	<linux-net-drivers@amd.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] sfc: Add X4 PF support
Date: Tue, 10 Sep 2024 16:30:13 +0100
Message-ID: <20240910153014.12803-1-jonathan.s.cooper@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jonathan.s.cooper@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000208:EE_|PH0PR12MB7838:EE_
X-MS-Office365-Filtering-Correlation-Id: 61e653cf-228b-4c0c-3a35-08dcd1adb196
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9+3RFRSuaASPVHM/9BDNotghk1aq6SQT9y5/pS7ID5vGTUu5p8buzafYv+L1?=
 =?us-ascii?Q?4F8oq0PkG/SGTbpcJxv+PR4fWEpl5tz4nsWDDzvzy8xSWRLn/9syySuFSvUb?=
 =?us-ascii?Q?U5v84wBHGbLZGeO48CHZyVYqcMiKqPu21LmHwdUNTS9RwIjMobH2WDi1g6sl?=
 =?us-ascii?Q?us03tJ37ptPs4FaipZDPn+e6ivX58iVyvWJBA1F5y7RD4OXBAgXDvRd2DGRl?=
 =?us-ascii?Q?kEOo3eAyNGDmYfnZJwi/NcoWy+A4q4Zg83SwgG0cDQD/D1arBa0zKIZSVTab?=
 =?us-ascii?Q?9XOOVQkJNma6iHYgFre5HT4tp67MOH8in0mm6DNGSUQjNLmskOzjd2rn4Abh?=
 =?us-ascii?Q?R2Xd4e0yZN0zwzG2zDjpQ73hGLQnfo6rbGI+HzvwjdT5wiRm4RwAjClwdnWr?=
 =?us-ascii?Q?6RX+WVAKng8OiBb+pteo/H/ZT72nOf+yppbp1cPDtkPorTi4bQQud+DvJ55+?=
 =?us-ascii?Q?kpIVrBGzaxHZ8Xqg7T2kyd0rMEP1s9oUuT28V6K5mEPByqRIjQp3veFMcGWA?=
 =?us-ascii?Q?GgP6Xf5QROYHCqR4AjNnP42Wo588xUXExcMlNwTLm4JbR0StxEsJ2rIvOmTl?=
 =?us-ascii?Q?6zUGZt0k9oFoYlYZ4WQgfKcJ+yfYMTRlxSp3AXv38pqUwAenQGS6C0aymVG7?=
 =?us-ascii?Q?Hc447y7vmeo8abQ44hwE5o2bYTz3NPiO0eGHr54Z9c7cOZj8Bs6h8U1GhCaM?=
 =?us-ascii?Q?J1sQBktTpj8G7bzFT6EFmbwTs3Ax5F1Oh32WVWiLW139VlonwS1iiegLjrFD?=
 =?us-ascii?Q?u3vEY90rL0/sJamdXLDjaSXP2gcHilQnOGYr5WOeDQA6Gxqrkbt2mX6Jo8Ew?=
 =?us-ascii?Q?uzLpdwhNAHIUEt9ol7taerVH/p8P54TnsVPbI+o3cCC9NyfHqpES7qi3ZcqI?=
 =?us-ascii?Q?Z5BtsxSp7/vhLSHqDRD+SlT5Tp2czqL1XIOOuQb6Mw6Z2oAHAZTUfBhR0L4+?=
 =?us-ascii?Q?qwZmvMJnS9SFHzMuR6jCZBJgGEcQURbvU/wRW6ABLbXqAwaUEwjJR/CPVVTb?=
 =?us-ascii?Q?/E8IHgrfqJpa0Dt7f4EZ5kHgXPsTASgsKCW7tDT/rKmm9m1bo/S1vUJfFJLx?=
 =?us-ascii?Q?2RjfSH8MhX+T5mmw5LbSQcJqb9GEibYUvmVtx4XjqMcqNp9q5gnVKA1qaO4B?=
 =?us-ascii?Q?Z0YK3prpSk3GAMNeZGpiTtnD7A+eYi4xjBwC6GRmqnlxJuVA9T07B9uUUbEQ?=
 =?us-ascii?Q?kboLSzBT/ck7ANB9RSTZ4OjQ1BoWMdm2avxe+388gxxmfXanhpsLJRGR2M3G?=
 =?us-ascii?Q?wc2KS/dyMfZLo1rFzi6AiybUhDf0G2mZigK/NDnV5JcYjCV8ae7pNsne87BR?=
 =?us-ascii?Q?cjfzJTZZK84kZTgDneYE+3GCF4WnD301xEOE/T7xiTmHm0gwbA/MheH4jBJu?=
 =?us-ascii?Q?MUY0RIn0HoD3wQ9fLCHpdgtXklSE1AG8x1iOaQco6pPZpyCpgGaChtH28L5h?=
 =?us-ascii?Q?bLhd/SAKl3gsm1LVCbJiayudP4xTBcC9?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 15:31:51.7321
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61e653cf-228b-4c0c-3a35-08dcd1adb196
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7838

From: Jonathan Cooper <jonathan.s.cooper@amd.com>

Add X4 series. Most functionality is the same as previous
EF10 nics but enough is different to warrant a new nic type struct
and revision; for example legacy interrupts and SRIOV are
not supported.

Most removed features will be re-added later as new implementations.

Signed-off-by: Jonathan Cooper <jonathan.s.cooper@amd.com>
---
 drivers/net/ethernet/sfc/ef10.c       | 127 ++++++++++++++++++++++++++
 drivers/net/ethernet/sfc/efx.c        |   4 +
 drivers/net/ethernet/sfc/nic.h        |   2 +
 drivers/net/ethernet/sfc/nic_common.h |   1 +
 4 files changed, 134 insertions(+)

diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/ef10.c
index 7d69302ffa0a..de131fc5fa0b 100644
--- a/drivers/net/ethernet/sfc/ef10.c
+++ b/drivers/net/ethernet/sfc/ef10.c
@@ -4302,3 +4302,130 @@ const struct efx_nic_type efx_hunt_a0_nic_type = {
 	.sensor_event = efx_mcdi_sensor_event,
 	.rx_recycle_ring_size = efx_ef10_recycle_ring_size,
 };
+
+const struct efx_nic_type efx_x4_nic_type = {
+	.is_vf = false,
+	.mem_bar = efx_ef10_pf_mem_bar,
+	.mem_map_size = efx_ef10_mem_map_size,
+	.probe = efx_ef10_probe_pf,
+	.remove = efx_ef10_remove,
+	.dimension_resources = efx_ef10_dimension_resources,
+	.init = efx_ef10_init_nic,
+	.fini = efx_ef10_fini_nic,
+	.map_reset_reason = efx_ef10_map_reset_reason,
+	.map_reset_flags = efx_ef10_map_reset_flags,
+	.reset = efx_ef10_reset,
+	.probe_port = efx_mcdi_port_probe,
+	.remove_port = efx_mcdi_port_remove,
+	.fini_dmaq = efx_fini_dmaq,
+	.prepare_flr = efx_ef10_prepare_flr,
+	.finish_flr = efx_port_dummy_op_void,
+	.describe_stats = efx_ef10_describe_stats,
+	.update_stats = efx_ef10_update_stats_pf,
+	.start_stats = efx_mcdi_mac_start_stats,
+	.pull_stats = efx_mcdi_mac_pull_stats,
+	.stop_stats = efx_mcdi_mac_stop_stats,
+	.push_irq_moderation = efx_ef10_push_irq_moderation,
+	.reconfigure_mac = efx_ef10_mac_reconfigure,
+	.check_mac_fault = efx_mcdi_mac_check_fault,
+	.reconfigure_port = efx_mcdi_port_reconfigure,
+	.get_wol = efx_ef10_get_wol,
+	.set_wol = efx_ef10_set_wol,
+	.resume_wol = efx_port_dummy_op_void,
+	.get_fec_stats = efx_ef10_get_fec_stats,
+	.test_chip = efx_ef10_test_chip,
+	.test_nvram = efx_mcdi_nvram_test_all,
+	.mcdi_request = efx_ef10_mcdi_request,
+	.mcdi_poll_response = efx_ef10_mcdi_poll_response,
+	.mcdi_read_response = efx_ef10_mcdi_read_response,
+	.mcdi_poll_reboot = efx_ef10_mcdi_poll_reboot,
+	.mcdi_reboot_detected = efx_ef10_mcdi_reboot_detected,
+	.irq_enable_master = efx_port_dummy_op_void,
+	.irq_test_generate = efx_ef10_irq_test_generate,
+	.irq_disable_non_ev = efx_port_dummy_op_void,
+	.irq_handle_msi = efx_ef10_msi_interrupt,
+	.tx_probe = efx_ef10_tx_probe,
+	.tx_init = efx_ef10_tx_init,
+	.tx_write = efx_ef10_tx_write,
+	.tx_limit_len = efx_ef10_tx_limit_len,
+	.tx_enqueue = __efx_enqueue_skb,
+	.rx_push_rss_config = efx_mcdi_pf_rx_push_rss_config,
+	.rx_pull_rss_config = efx_mcdi_rx_pull_rss_config,
+	.rx_push_rss_context_config = efx_mcdi_rx_push_rss_context_config,
+	.rx_pull_rss_context_config = efx_mcdi_rx_pull_rss_context_config,
+	.rx_restore_rss_contexts = efx_mcdi_rx_restore_rss_contexts,
+	.rx_probe = efx_mcdi_rx_probe,
+	.rx_init = efx_mcdi_rx_init,
+	.rx_remove = efx_mcdi_rx_remove,
+	.rx_write = efx_ef10_rx_write,
+	.rx_defer_refill = efx_ef10_rx_defer_refill,
+	.rx_packet = __efx_rx_packet,
+	.ev_probe = efx_mcdi_ev_probe,
+	.ev_init = efx_ef10_ev_init,
+	.ev_fini = efx_mcdi_ev_fini,
+	.ev_remove = efx_mcdi_ev_remove,
+	.ev_process = efx_ef10_ev_process,
+	.ev_read_ack = efx_ef10_ev_read_ack,
+	.ev_test_generate = efx_ef10_ev_test_generate,
+	.filter_table_probe = efx_ef10_filter_table_probe,
+	.filter_table_restore = efx_mcdi_filter_table_restore,
+	.filter_table_remove = efx_ef10_filter_table_remove,
+	.filter_insert = efx_mcdi_filter_insert,
+	.filter_remove_safe = efx_mcdi_filter_remove_safe,
+	.filter_get_safe = efx_mcdi_filter_get_safe,
+	.filter_clear_rx = efx_mcdi_filter_clear_rx,
+	.filter_count_rx_used = efx_mcdi_filter_count_rx_used,
+	.filter_get_rx_id_limit = efx_mcdi_filter_get_rx_id_limit,
+	.filter_get_rx_ids = efx_mcdi_filter_get_rx_ids,
+#ifdef CONFIG_RFS_ACCEL
+	.filter_rfs_expire_one = efx_mcdi_filter_rfs_expire_one,
+#endif
+#ifdef CONFIG_SFC_MTD
+	.mtd_probe = efx_ef10_mtd_probe,
+	.mtd_rename = efx_mcdi_mtd_rename,
+	.mtd_read = efx_mcdi_mtd_read,
+	.mtd_erase = efx_mcdi_mtd_erase,
+	.mtd_write = efx_mcdi_mtd_write,
+	.mtd_sync = efx_mcdi_mtd_sync,
+#endif
+	.ptp_write_host_time = efx_ef10_ptp_write_host_time,
+	.ptp_set_ts_sync_events = efx_ef10_ptp_set_ts_sync_events,
+	.ptp_set_ts_config = efx_ef10_ptp_set_ts_config,
+	.vlan_rx_add_vid = efx_ef10_vlan_rx_add_vid,
+	.vlan_rx_kill_vid = efx_ef10_vlan_rx_kill_vid,
+	.udp_tnl_push_ports = efx_ef10_udp_tnl_push_ports,
+	.udp_tnl_has_port = efx_ef10_udp_tnl_has_port,
+#ifdef CONFIG_SFC_SRIOV
+	/* currently set to the VF versions of these functions
+	 * because SRIOV will be reimplemented later.
+	 */
+	.vswitching_probe = efx_ef10_vswitching_probe_vf,
+	.vswitching_restore = efx_ef10_vswitching_restore_vf,
+	.vswitching_remove = efx_ef10_vswitching_remove_vf,
+#endif
+	.get_mac_address = efx_ef10_get_mac_address_pf,
+	.set_mac_address = efx_ef10_set_mac_address,
+	.tso_versions = efx_ef10_tso_versions,
+
+	.get_phys_port_id = efx_ef10_get_phys_port_id,
+	.revision = EFX_REV_X4,
+	.max_dma_mask = DMA_BIT_MASK(ESF_DZ_TX_KER_BUF_ADDR_WIDTH),
+	.rx_prefix_size = ES_DZ_RX_PREFIX_SIZE,
+	.rx_hash_offset = ES_DZ_RX_PREFIX_HASH_OFST,
+	.rx_ts_offset = ES_DZ_RX_PREFIX_TSTAMP_OFST,
+	.can_rx_scatter = true,
+	.always_rx_scatter = true,
+	.option_descriptors = true,
+	.min_interrupt_mode = EFX_INT_MODE_MSIX,
+	.timer_period_max = 1 << ERF_DD_EVQ_IND_TIMER_VAL_WIDTH,
+	.offload_features = EF10_OFFLOAD_FEATURES,
+	.mcdi_max_ver = 2,
+	.max_rx_ip_filters = EFX_MCDI_FILTER_TBL_ROWS,
+	.hwtstamp_filters = 1 << HWTSTAMP_FILTER_NONE |
+			    1 << HWTSTAMP_FILTER_ALL,
+	.check_caps = ef10_check_caps,
+	.print_additional_fwver = efx_ef10_print_additional_fwver,
+	.sensor_event = efx_mcdi_sensor_event,
+	.rx_recycle_ring_size = efx_ef10_recycle_ring_size,
+};
+
diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
index 6f1a01ded7d4..36b3b57e2055 100644
--- a/drivers/net/ethernet/sfc/efx.c
+++ b/drivers/net/ethernet/sfc/efx.c
@@ -821,6 +821,10 @@ static const struct pci_device_id efx_pci_table[] = {
 	 .driver_data = (unsigned long) &efx_hunt_a0_nic_type},
 	{PCI_DEVICE(PCI_VENDOR_ID_SOLARFLARE, 0x1b03),  /* SFC9250 VF */
 	 .driver_data = (unsigned long) &efx_hunt_a0_vf_nic_type},
+	{PCI_DEVICE(PCI_VENDOR_ID_SOLARFLARE, 0x0c03),  /* X4 PF (FF/LL) */
+	 .driver_data = (unsigned long)&efx_x4_nic_type},
+	{PCI_DEVICE(PCI_VENDOR_ID_SOLARFLARE, 0x2c03),  /* X4 PF (FF only) */
+	 .driver_data = (unsigned long)&efx_x4_nic_type},
 	{0}			/* end of list */
 };
 
diff --git a/drivers/net/ethernet/sfc/nic.h b/drivers/net/ethernet/sfc/nic.h
index 1db64fc6e909..9fa5c4c713ab 100644
--- a/drivers/net/ethernet/sfc/nic.h
+++ b/drivers/net/ethernet/sfc/nic.h
@@ -211,4 +211,6 @@ int efx_ef10_tx_tso_desc(struct efx_tx_queue *tx_queue, struct sk_buff *skb,
 extern const struct efx_nic_type efx_hunt_a0_nic_type;
 extern const struct efx_nic_type efx_hunt_a0_vf_nic_type;
 
+extern const struct efx_nic_type efx_x4_nic_type;
+
 #endif /* EFX_NIC_H */
diff --git a/drivers/net/ethernet/sfc/nic_common.h b/drivers/net/ethernet/sfc/nic_common.h
index 466df5348b29..7ec4ac7b7ff5 100644
--- a/drivers/net/ethernet/sfc/nic_common.h
+++ b/drivers/net/ethernet/sfc/nic_common.h
@@ -21,6 +21,7 @@ enum {
 	 */
 	EFX_REV_HUNT_A0 = 4,
 	EFX_REV_EF100 = 5,
+	EFX_REV_X4 = 6,
 };
 
 static inline int efx_nic_rev(struct efx_nic *efx)
-- 
2.17.1


