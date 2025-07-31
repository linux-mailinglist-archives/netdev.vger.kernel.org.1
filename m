Return-Path: <netdev+bounces-211220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BC8B1735B
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 16:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3D62165F3B
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 14:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7AA19E826;
	Thu, 31 Jul 2025 14:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VCLBC1sH"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2085.outbound.protection.outlook.com [40.107.95.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182AE1991D4
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 14:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753972934; cv=fail; b=gxET47d/al6KoQS6nUhzp3Fer9sf9Z5mUSHp7kXD0RbP8LpfubEn4mcfQQIVUmbuIzpRhNl6Wu+PyeTPmH3IeSxkKl75vAKe8DXHx5XwaD9b1hiFbKmSSEQeGgXcgLgyQOzRDhfHeijlknIwxzD7S1dvy/lw8gSWVvPBSa5ruWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753972934; c=relaxed/simple;
	bh=ZdigmclPq7QVVTBmbIZ4thNwkJI6V3g0xb2HNCGQuYs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gJ0Lw74y9gos9VTmpcr1xr7XdDda0RwSOSn1qnLmUBPyWLAmxB+izCKxo3VcgnRW5B1c3zdQuCNVW8Vhuo8NFuJpu6udRB7QnZw2fI744zpLqnS1eIzuozDMls9xdtpvSAVH3Mp5+rIbG6mJcEPWc5/avJIkPea8Heakv4DM/7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VCLBC1sH; arc=fail smtp.client-ip=40.107.95.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SXc2+peLoG8aa3zW9ND344uBfZuVYZnCLcWZ68tp+P89A7llqlniyCsZfTkXMTQ2tEXGopjj3sVmiX8Je5hk+e+ohYVs4eXZ7OiVOY77XcuXCjiEc6xtiH7QJA7Btp9f2d27wTXqK2JvgJ3vXEWQ48DDW+/i+Pl9YUwfFJQ9P2tNIVpEWGGIEgc1K91jLCGAgnWlvpeZZK9z0FY3zyI7Flg+pTzNRV7cIkV1/O+yuhhKdq2jiYn6OUXBn4veEYAjhWhCXzOdeCVrdVAU33OYW6Mfl3kqTlMndqq12ZG9Jis3tUN73a+GFDUoMIMC+5iR4Dr2tW00PsvXTPjCEs8QBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tBw7nySosrBuozW9T6ZyVimRXwb+xgRPQhfhSsm4Qc4=;
 b=mHdClpJ+jvahtjAmFI+j0QtBX5/guRf9ARsEAJmHf97J8isTrS0axCUZ/eLHnLVt3DhHdd3LeGVo6wJ/k+nTpyO2R3DfxVLVhvno0At6BilAvSHzzRuMWVVVWK8v4h/sf+hw3glZpxZ45LVv/eEDAXNcL2dDltHqwu9LdYhxgKgiG1HGjeyRasb1W70vS24ynyzo04lYgbmSRYnoYjgvMyGdKrgun+q/1u1OKsEne/Mcgtz3WmWg3kYSiEQ6CBjtraHqJA1QP/IUvyG6lQIeB93JKXhYFKKTjCo4LvP9033joFhforHCBT0zR/crskog4WiWlzbs+bVO9eb/I1q/vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tBw7nySosrBuozW9T6ZyVimRXwb+xgRPQhfhSsm4Qc4=;
 b=VCLBC1sHBJO4lj9QsMQR+hgg/h+3zUGOzi+gx3cnVd5fuHzwQpqQht2Pjc0PSYA8zlJut724wXcgbhw7IxWWkg+UNZXRz6BVswEAl+7bBWLbjeG7oB425MMbMG+SrkAbAxaxpN5ueUuiq/Q+UeDTZI4sloXajuKequMb//E9aIw=
Received: from SJ0PR05CA0138.namprd05.prod.outlook.com (2603:10b6:a03:33d::23)
 by BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.25; Thu, 31 Jul
 2025 14:42:10 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:a03:33d:cafe::df) by SJ0PR05CA0138.outlook.office365.com
 (2603:10b6:a03:33d::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.5 via Frontend Transport; Thu,
 31 Jul 2025 14:42:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Thu, 31 Jul 2025 14:42:10 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 31 Jul
 2025 09:42:07 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 31 Jul
 2025 09:42:07 -0500
Received: from xcbecree50x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 31 Jul 2025 09:42:06 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<bhelgaas@google.com>
Subject: [PATCH net-next] sfc: unfix not-a-typo in comment
Date: Thu, 31 Jul 2025 15:41:38 +0100
Message-ID: <20250731144138.2637949-1-edward.cree@amd.com>
X-Mailer: git-send-email 2.27.0
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|BY5PR12MB4130:EE_
X-MS-Office365-Filtering-Correlation-Id: 708066c3-f25c-4fff-29cc-08ddd0406e2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pieQ+3av4FrzotnYD7tSL5f6KxGbWnLLMWjYXLHcZMo15E1LS2TvWE5fnQh7?=
 =?us-ascii?Q?5lDFMYcYQozoRRYP4cGP1Wea83QIs4T6MT0bIhxFC07Y7R+3Af3biydBgSwE?=
 =?us-ascii?Q?XaNqhxcsKLQ6FJmKw4GQC8piW/6gXRAYpGPXCAnJJOAWbCw5lrQHmzbh4dHn?=
 =?us-ascii?Q?2S5jm2+x8SzPm9AjC5c77D5dVEjytnyunybgdTUWoFfpeqkTwzggvr+QR69j?=
 =?us-ascii?Q?uppy7Dk5Y9a+ESCUukn0K3IU5ZtpUlyhbGvKQIVjb4U7XOaoiYOKLH8CEf+R?=
 =?us-ascii?Q?gKR9VpwDlcRpY42czaUPcUYddLzruP+ayykeQ6B/QTWzg09PON8DMpA22H/6?=
 =?us-ascii?Q?9/xd75z2NNDNNN22w2vJRjyW7qm6L2t+6o00L8L226uCSqMlswcT2r5RtYFL?=
 =?us-ascii?Q?LKLGWaWhHjLZiY84NVSbUnMNO902Gw7UdgvDlDxHpcaPzTBUm9z7Pw4cyi5/?=
 =?us-ascii?Q?GPfAogCJ+MtJBlclfzEzF1GBrKdu4T04f+59Yeq3WbpZw9PN1n6fh+HwERjx?=
 =?us-ascii?Q?UOKsTV8h+XGjkhxFbD3BRFktKdKXLITDxq/GjtYof0x1zLgMQMxvTTC8wAqf?=
 =?us-ascii?Q?4nQKOX3uAtBJq9zrVBwrJ44dgoYZGfzk+JWJ69MVb+vI/h7Ym/DUJ/HgCXaR?=
 =?us-ascii?Q?lcNdQop4kTnqFY306PvtKFLiegHBTdNB9SMo6ZF+0WXZt1ojfjsNVx5QqR69?=
 =?us-ascii?Q?IzARjbpMUynaiXU+UZGcIkA2Zot/CSaTXWC/0LlmdXYYpWdpRCrV6WoHypvv?=
 =?us-ascii?Q?XthNGCgiESgpdRvtKVps8WPpR/SHCMl4bd4hqyMNiPoVytoUnFR6GuahLjb2?=
 =?us-ascii?Q?NWe3RnTeijPMxt4A2+PWUgY+4eog05YSSpYrHzCga/lFnMwu19iahL3gTbTN?=
 =?us-ascii?Q?IhNy+xAX3K7ca9Vrb+9ripPlRdZas++yn82DSh06U6B8RgvxCXhBZOdYmhJn?=
 =?us-ascii?Q?UXDwlGZXAbvUslPeL909U+ErKsayQufkj3LZ+fnzV7hT7dVb+UHP+rlmRB1f?=
 =?us-ascii?Q?kMxA/ZV2CcUi3gIeOBXToObMySqtBAbvKTHlH6ce2ImSTDRLmsCsjmPAE0iP?=
 =?us-ascii?Q?ugj5LSG5/vby9Nr25XYxzhgGODTrar0VHCtmGNtk4nG3xht+PtTHKYHvv84K?=
 =?us-ascii?Q?kNLBmi5rKU//SQO6ar5zkq+qG2YlnRbA13haSLUMT6yWyvj129GzgC2/qm8P?=
 =?us-ascii?Q?lRkeEfbf2kgKoHDudnt6hq/0z1q7N6co6Y+5g784Rs9hAT0XSO95VJ5wUG0I?=
 =?us-ascii?Q?eFsTZvlZSWA7RowJ8zMwAPNBdut6tEQUPlC3aluN/ZpMHx0SnDhEYzJyJQ1l?=
 =?us-ascii?Q?t/k8T4kXtYbj2CYzzWPLuXse9jAUOVQacR7BPJFCNAVBGGSSnUkRLg3Csbug?=
 =?us-ascii?Q?r9sLLRzmksBl/pIhUVzzYLXhki/vmZMtCL9fyi9aETPWAhCTHrKIGpIdbSLV?=
 =?us-ascii?Q?VygAcVudnbbC4dCMdwATdajHLCkTDoMW6Pb48gWw+rBFQNiGmED9A/z0dmkH?=
 =?us-ascii?Q?trNBzy6GPSTpE5HR+sSmeR1fAl3SSo3u4o8l?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 14:42:10.0194
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 708066c3-f25c-4fff-29cc-08ddd0406e2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4130

From: Edward Cree <ecree.xilinx@gmail.com>

Cited commit removed duplicated word 'fallback', but this was not a
 typo and change altered the semantic meaning of the comment.
Partially revert, using the phrase 'fallback of the fallback' to make
 the meaning more clear to future readers so that they won't try to
 change it again.

Fixes: fe09560f8241 ("net: Fix typos")
Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/tc_encap_actions.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sfc/tc_encap_actions.c b/drivers/net/ethernet/sfc/tc_encap_actions.c
index 2258f854e5be..e872f926e438 100644
--- a/drivers/net/ethernet/sfc/tc_encap_actions.c
+++ b/drivers/net/ethernet/sfc/tc_encap_actions.c
@@ -442,7 +442,7 @@ static void efx_tc_update_encap(struct efx_nic *efx,
 			rule = container_of(acts, struct efx_tc_flow_rule, acts);
 			if (rule->fallback)
 				fallback = rule->fallback;
-			else /* fallback: deliver to PF */
+			else /* fallback of the fallback: deliver to PF */
 				fallback = &efx->tc->facts.pf;
 			rc = efx_mae_update_rule(efx, fallback->fw_id,
 						 rule->fw_id);

