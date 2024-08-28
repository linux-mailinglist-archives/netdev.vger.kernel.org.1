Return-Path: <netdev+bounces-122789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7682962923
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 15:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED09F1C20F61
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 13:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D28187FF0;
	Wed, 28 Aug 2024 13:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5RLLveU7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07521DFE1
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 13:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724852764; cv=fail; b=eWUNRnA3D2UTUXpMGcIRZgE9T2iCk4aBH6ZW5rjf1FpNAfAF0iVVqyWFQlJYSKYLTGJrhc+VGbOIyt7iEH25YyfJT1ghP5dRbPUm72CECdNHMdbfXQIRMsPsBpb5DwQMxjXxwMkaWDY0uCqJz88rYTheAmdK52ddSR8/7JSI9tE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724852764; c=relaxed/simple;
	bh=Eqyb7evNrPzG2LFbcfOgAADGWLbiMaQJyp1/XxhOT6g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mnjQ4FNjkWgsEfWxAxoPaTOsS61SteS7RArDmu9VYafaFtUZ7PUvzCB1/yfpFXdPetWHDRO5q9ynlDlt+KyR3IMHQSSxjkvngPcezei7Kx61OVX0E1epMeEEIkde0k0A/ZqO1jKzVv7OqKD+vOcjUy7PP4rsQqYDT7aPT2qn00s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5RLLveU7; arc=fail smtp.client-ip=40.107.223.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dxnN8ACkU7JckbhVOjMAWqXJIuYhaAfsICQlAKTR00gsnvDJFj+mDmTPVO0lmp1Sr6Nq3MSE4D1bns5Tu0uQMISbTVHQyrEM2OQNNaCT87YijHKG1LZ4rq+fNvQ0cmZYaDX08iNWPKgGLID0BVGl7mGOAOwZRe06m5u+dbEbb8yz4dfIBxJtlYdcYgk+KHx14RnZRYX8I/g5syDaqIn8II1rf2xRvVzO8cfQrD5bwqBzbZN2ruNExkOn8JCcV8cX905l+VkT9hSlbNGzcID+ruRTU168ccRMKisXTIPRLb2u72bpbkh/fw9jh9tQbVzk5/X1dpp+fUVi+FeL09t5SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UswNknTvo3YA5EIxQwUVLwgznB4IOf83B+UnItVPj0k=;
 b=mRFFHxMfx2jqP65h4y8qBN5SDny8uyY58hU8K6O4K43tlpv3Wbtj481OlRz27I4NuUUS4Z682ntgkV7wQnDAnTXeJ/vJwWRILbk2JfrArf62s10sM+MuCgvuIwnOO8hiVPJfHadsd1CY29lb3vU9sgEBdt54uncEkgZ5voKz6V+bNSM/l7qWLbnTZ/xekUc5MTPhw5K9S8Ukd9JlE1OvPDc913qB3udS9lwsnKXbNR9s5W5BS/PpMk5qzHiWdbIR8iG615ZeaEi+LFiR/5GkJifXdp0pu7U6SZCIxibiLPmbxOj48pJ4dWpCVgAcXN2QqeLKCsA0CCJGOZaklviaHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UswNknTvo3YA5EIxQwUVLwgznB4IOf83B+UnItVPj0k=;
 b=5RLLveU7qZ7ip/VLWdWGFL8Zqpv4rkoTM+nSp+ifhqEoR+lqhyTPWlvMJzEPm10KYZPVlDGcBN1DTDd0jYHwdSXG3rG/atXKraNNXu1tuzCtIGWeZmhp/CrzqqUF6bI/k3u9YjsuHwy8cWhEetQNHBDTLmzItkL24W2CS/UMwbg=
Received: from SA1P222CA0065.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::16)
 by MW4PR12MB7359.namprd12.prod.outlook.com (2603:10b6:303:222::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Wed, 28 Aug
 2024 13:45:59 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:806:2c1:cafe::60) by SA1P222CA0065.outlook.office365.com
 (2603:10b6:806:2c1::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27 via Frontend
 Transport; Wed, 28 Aug 2024 13:45:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 28 Aug 2024 13:45:59 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 Aug
 2024 08:45:57 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 Aug
 2024 08:45:57 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 28 Aug 2024 08:45:56 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH net-next 3/6] sfc: add n_rx_overlength to ethtool stats
Date: Wed, 28 Aug 2024 14:45:12 +0100
Message-ID: <e3cdc60663b414d24120cfd2c65b4df500a4037c.1724852597.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1724852597.git.ecree.xilinx@gmail.com>
References: <cover.1724852597.git.ecree.xilinx@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: edward.cree@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|MW4PR12MB7359:EE_
X-MS-Office365-Filtering-Correlation-Id: 9148853d-d2f3-4148-3800-08dcc767bfe6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ebdzwBOI8AiXihC3wxnxLbFZib5ZX7uUOzFUe7VPIqO2+EzS+imR2HJXegeJ?=
 =?us-ascii?Q?J8ECk0aBak1g0rlPk2PMiun5fqen1f/91CBeT5V8WbXBUVNbN40PUD/5Co9h?=
 =?us-ascii?Q?Us/ouoMqwhNg6NGCiRhjyWBE6pW7VjRI5nXfC7hYA7leBy92kIIKJash+MuX?=
 =?us-ascii?Q?OSWIQq1c/rUsA/ZgKcfMUIMQOtTR4kakHCAWTwZbF66yLpEIz6zC0fbjJco2?=
 =?us-ascii?Q?+LsJG8l5VWhn0hs2xn6iowzVmd/oKHL5b2YxvozYMkqFGHdSvZred5B/roHT?=
 =?us-ascii?Q?LWJRvq/mkWyBwmfNDvUgcgEz9hPg0TXYuZEy6UwCXBffAryAUK3oGjQkjGE/?=
 =?us-ascii?Q?sNpGpiWHQ/6oH51UsYbZkPyj8cwok+oo7jCs+TXynsZPnH5ZrAjrKQ4h5qnN?=
 =?us-ascii?Q?1euqHZcYBKaEgHYHYpI2pzZHKpwQdClvv+cQ2x6lpw04ivhUDgZfTwNlJTz6?=
 =?us-ascii?Q?qljjEoympLHhBZyYVJaApzXE54Vm/kc6cJZxLYXMF+T3CtrjgjTprEqQqa/s?=
 =?us-ascii?Q?h7b6v+4LDPSPhi/0Ru+93nFvi1xnrBmPdZXoxRD46vAC0xlle9pkGgDgkYs4?=
 =?us-ascii?Q?gDIugStcB5OSs+qlMd8U8M6HrWDppVQniN0KT4loBQOfvmzgm9uPoBJQ/Aux?=
 =?us-ascii?Q?ms0Y7HTCqQKSlqFdvocMTYNZRfaEFjs/d5Q3cdzemI/X9Lqc7tN5avIGH1eU?=
 =?us-ascii?Q?3iMKvVCNZS1hIOcun1V/GJXor0O6mXfB3EmEXOq3QueR+IFSUOpV5l+7CNZv?=
 =?us-ascii?Q?HBR2mOxuds6o04EbDLWFAYZkDVh1Rltzp2dQfrIcZ9O7HxeX8d85e1pjtxrl?=
 =?us-ascii?Q?4QUyRzuJq1ONns0x+UbldnyLH3kyo6gs1x/FRL/RovHWhGo+bC+VLMBCErO3?=
 =?us-ascii?Q?JbaQRLXIApZ1sljOemu3EE4ltMLOFuiNQI+DTLxmDEq9AykHtz46+Cyf+psn?=
 =?us-ascii?Q?KacZbglyVsGVFlGaItx1S+0NJPYwkirTMasayohu81+i1a5yO/rvkk/VYRyX?=
 =?us-ascii?Q?XbzTwPM0/aiMnASWr9UNMbthHBbZuMgQa6Z53gH27l5dQ/xZ4iS/Ddv2jx6R?=
 =?us-ascii?Q?JRobLI8O2MFYXiCjMd4X4p7uXmblrIlm0JnQUqFk8CT59M1enUJfK94DTMfi?=
 =?us-ascii?Q?xMly59HbHbm5ngQ5RHY7DRj1tHo07FEcmJB21K7Kx+Vei06YS620Z9ryFTRu?=
 =?us-ascii?Q?HUaK68N8BtvHHv2oxbmDsnjdXthDncuIDVJHqJ4Wx3kAC6TgJlc9OLqqzPjR?=
 =?us-ascii?Q?rVg7es04aH2Ae2/VtOgatCHFZOaQbb1dIlQu+rqwB6SJXQawWw1xQ8+EG+Xg?=
 =?us-ascii?Q?skBLoUtAW89AW+M6sQIu451zNdbunkekGeYgmb3APoaeSNPnG6QvX1d4Z49E?=
 =?us-ascii?Q?59eRs2Cc7Xn5EZpXN6828IxK5BdE/+iARlGHX32NX/zGn+ncEFBnB6/lbJAe?=
 =?us-ascii?Q?2M5pYKNt84L5bseTWDSz4QC4Eg1rO7X7?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 13:45:59.4081
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9148853d-d2f3-4148-3800-08dcc767bfe6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7359

From: Edward Cree <ecree.xilinx@gmail.com>

This counter is the main difference between the old and new locations
 of the rx_packets increment (the other is scatter errors which
 produce a WARN_ON).  It previously was not reported anywhere; add it
 to ethtool -S output to ensure users still have this information.

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

