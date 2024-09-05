Return-Path: <netdev+bounces-125613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E37696DEA2
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 17:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A391A1C23A64
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 15:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE5719F46D;
	Thu,  5 Sep 2024 15:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jw8ENd43"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9FF19E96D
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 15:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725550958; cv=fail; b=VdNZtdqvHeeNGylohTV7fwYKPp4aceWGgr7u4lR7SMHaTcshWM6jLiDOlABrpse+oP1Hk3JXmXBG7WAy87EHx5zNtYxXYvl1im12YN0BZ6hvg2iKSVOAqDno+Z26Pcu2Ony6TKiQSZ/LYQCaToiOuEDkcjaXiPP7n2vO775UDWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725550958; c=relaxed/simple;
	bh=Sv2mycHhzFpVHsrctE7MCekDFFjNnnCL3dK4OGEkgkQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ixIwhwlAyP5q34m/5gCLGdMuzDf7CfWY9Iq7sTtW5e4qAuZAh1Kd0jM8OEA6ddRDHZ5P1A2DPWM6t0D+O3pUBH3Mq7CslXaZeZIi9TQq8ghSGkKuW0WQq43xgldIba6E4sbmXTzv/26bJs79+ZUgp/qf5OAM20BHgax45OJZhsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jw8ENd43; arc=fail smtp.client-ip=40.107.243.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QJD3kjZ3sHxf1d/IDYT67qSjrDWyql6XT+4q8ZNCXtEfqD8HGIbntdZ78Yz9DVZYZHqAy3Cor8NPBinDlvoxIEZ1Dk2LIYwKpD84FcLkrRKOFSxtqayyretGjjdbjsO97AbELB4ljQDjWeYhSTcOEj6EJffTDctFWGsxOf1c1ZPRh02cRBfm4Kq3rVeONFPFAHeGnk1Ile4bISWxwUEvn3MWm/YPGNO+lBUr5A8HAPpH5bbHv/qlJT3si2zT+93SbedDiFUzH11j+QKER0ei7ERqKu8ua5gEp0/PW1xV2YIvTtxoezNr71R5/zi4+N8PQ15LWy/Nzqopi2Iaius1CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9zISJWpQ2SpzB5m7k/RMqxVfAEusBDzbIBbzcmBv56k=;
 b=nh8BOpbanVKImvwjZqqGxAStICpplVB5k9/A1MBNtLDXebSl23KqRPe2h5Mf/EHcVW5rPweH4fBpZqKYN6vmuql0nhjLwfGUsNJs/BxZ9qJ27AOnhQhb6Umfb4JO7Xyi5f8CB2HT40IoIfVPsGYInza5kiLOAcpqrdBfBfnzcBeU6lYe78bM3/FEV9QOT7rm5p8NBloFB7soWNltb16dsYn/UKAVIkcHstZzJdcGjLoQwd48BxM4eGffJShssXohQEzrcZqXN65TXIsz7tIWlCLajFmtHjJTjRVO70kzls2DCEhKpXBKwnItwSfwAh4fdbgLlnT/90YjEY4F391DQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zISJWpQ2SpzB5m7k/RMqxVfAEusBDzbIBbzcmBv56k=;
 b=jw8ENd43kCp1i+AIw9Ln83dMe6hao67JcibZx5NzBLICQkqDLBsqlmeuhgmppmKuudB3DMmFTKgo7uwpyMaXHefePIFLSe84pykO0yP22oWbGWvzOeCg8nzPwv2ld62ruzv9qVru87NUlifb8GdX262fKvqQ/8EIuEN/PhPiQXE=
Received: from PH7P220CA0044.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::22)
 by MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 15:42:32 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:510:32b:cafe::d6) by PH7P220CA0044.outlook.office365.com
 (2603:10b6:510:32b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13 via Frontend
 Transport; Thu, 5 Sep 2024 15:42:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 5 Sep 2024 15:42:27 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Sep
 2024 10:42:26 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Sep
 2024 10:42:26 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 5 Sep 2024 10:42:25 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <jacob.e.keller@intel.com>
Subject: [PATCH v2 net-next 3/6] sfc: add n_rx_overlength to ethtool stats
Date: Thu, 5 Sep 2024 16:41:32 +0100
Message-ID: <45db8b32bfb5e92a63d32a6482c1234d42481a5d.1725550155.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1725550154.git.ecree.xilinx@gmail.com>
References: <cover.1725550154.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|MW4PR12MB5667:EE_
X-MS-Office365-Filtering-Correlation-Id: bf54099e-729e-4cae-e6c0-08dccdc158a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xwnHzxu9+EWbN0P91CGPucWtTfolvYDAOnEFlqCDmZDPY3Ew101/ZUVoNNO+?=
 =?us-ascii?Q?t3M4L1dICQiPlPe2Y5ablLuzNPkz+6R4cBiLQIB2b49GB8Luhw1GHX9HRk92?=
 =?us-ascii?Q?G680hFbQGw4wh1EfkX0YiSC9aVwH7GdmaJDsHL1ffWINWSqf8WQSPHm/ZwXZ?=
 =?us-ascii?Q?zGWFfLUnkxG5uehdOgQOuml3a0IvYGk5HHheAxZcXtBt5wJIbej2EO+w9sof?=
 =?us-ascii?Q?W9SDeSpHYDrsA+w7OyClUsxkfXYdUhsysMVeDn6lhxD1dhFaxewAbF8jgDRA?=
 =?us-ascii?Q?LiNTjWGW2QMMOYzLfC0wEEv2zP03yOG4yxXruqAJ90Fi89Ib9pK9KNStneVP?=
 =?us-ascii?Q?yC+cd34oZJ4cs0jfmMDlkAMe/0cWmL5AEKwVEvJr41MFDlA+u1FlORMI0AAp?=
 =?us-ascii?Q?kc3hQ32IZnCEhjHMFE3sx9USYhuK2OnxYz3SfUc3bUwUcTquQfmGs/uGtCrb?=
 =?us-ascii?Q?emPUkfqibm4C0c98RdxADI83eVg7PnbGlX5bQcJAvI4VxxwpJPhfKDllsV1f?=
 =?us-ascii?Q?mrldxWaqtHR5A4BbGc+p2zHlvPM+nut6RP0VltR6O2EhHvPbXSf0/f5vycIa?=
 =?us-ascii?Q?RC4SXx/DCz3cz5Y/I2lsWmBlaD6diySYBIsHWIRyQDyHwbGUaZDFRqjZeh8h?=
 =?us-ascii?Q?C9yBCw8crO1pZqFdu+E52ja/lGcxbTOATQ9Gl9LhKYU8JsUwlnzzWcRgUJHu?=
 =?us-ascii?Q?08lLNINHwaQHM0VQpeRP8M5/LkVNZOz+Tu9QbLYTx9wQM2u+jmib6KBb7yg2?=
 =?us-ascii?Q?HgVfueB+3ffLFVGuT3jfQ64W75AbHclKxfR2SBwm3gVhS70/Sd4F1id+csGQ?=
 =?us-ascii?Q?+Tb/SND3PoiV7f2i2skqU/bAO5xRWab+sNzX69p+amXUA4XA3XDxvDgjUj82?=
 =?us-ascii?Q?hg7JpbMNYuVMNjHIF0WuKXO351+A7L+YUyjs8nkQZ1q5K8w3n58auRngwMxw?=
 =?us-ascii?Q?aTSphAzvub0i/uLDuufNytw28RHSS0Jxx9828LzEzfEnwlYhdGSYrTgipeRM?=
 =?us-ascii?Q?4BUk1DWHvkt0A8eeSehzUqZ/nkF4YgFhaPi6APmZywKJB32isZz5aPwsPIXB?=
 =?us-ascii?Q?8rn39+MhEYtB97MqXeY23PtpUB/tVdhnzwOICwCnRn212GTWnqkbsBiEn1Yj?=
 =?us-ascii?Q?hJFMCIIjy33d/PVopY/usjzG8Wgrq93K7DAJuaGNqGkz9TZMwrV5yOd87jRW?=
 =?us-ascii?Q?axExUI9kmCDvpNYE94fRAq5xztHI38snnhZexr++Fizm6ulLYWwpXJKSpHYf?=
 =?us-ascii?Q?xwGuyQ51mZ+pJfhc93h/GZf3RDa8FaNtx/ImHKUXSwb2XSmjmOkd5ueyrPbe?=
 =?us-ascii?Q?uQqzq0yXK4peX6TEgubkcgkNRSYPVNgsaHsU3mSeEwfnkbLc9sMhzmGPXa1e?=
 =?us-ascii?Q?WWORrUw4VniWYxrAQcodf/F1YjxoASxbrw+P0Smv68cYBqrUygTTeeKvQkx3?=
 =?us-ascii?Q?1Aj/ZQ7Ia0Iv+cfNxnw5FuIIvdwvUKUd?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 15:42:27.7895
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf54099e-729e-4cae-e6c0-08dccdc158a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5667

From: Edward Cree <ecree.xilinx@gmail.com>

The previous patch changed when we increment the RX queue's rx_packets
 counter, to match the semantics of netdev per-queue stats.  The
 differences between the old and new counts are scatter errors (which
 produce a WARN_ON) and this counter, which is incremented by
 efx_rx_packet__check_len() when an RX packet (which was placed in a
 single buffer by SG, i.e. n_frags == 1) has a length (from the RX
 event) which is too long to fit in the RX buffer.  If this occurs, we
 drop the packet and fire a ratelimited netif_err().
The counter previously was not reported anywhere; add it to ethtool -S
 output to ensure users still have this information.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/ethtool_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/sfc/ethtool_common.c b/drivers/net/ethernet/sfc/ethtool_common.c
index a8baeacd83c0..ae32e08540fa 100644
--- a/drivers/net/ethernet/sfc/ethtool_common.c
+++ b/drivers/net/ethernet/sfc/ethtool_common.c
@@ -83,6 +83,7 @@ static const struct efx_sw_stat_desc efx_sw_stat_desc[] = {
 	EFX_ETHTOOL_UINT_CHANNEL_STAT(rx_outer_tcp_udp_chksum_err),
 	EFX_ETHTOOL_UINT_CHANNEL_STAT(rx_eth_crc_err),
 	EFX_ETHTOOL_UINT_CHANNEL_STAT(rx_frm_trunc),
+	EFX_ETHTOOL_UINT_CHANNEL_STAT(rx_overlength),
 	EFX_ETHTOOL_UINT_CHANNEL_STAT(rx_merge_events),
 	EFX_ETHTOOL_UINT_CHANNEL_STAT(rx_merge_packets),
 	EFX_ETHTOOL_UINT_CHANNEL_STAT(rx_xdp_drops),

