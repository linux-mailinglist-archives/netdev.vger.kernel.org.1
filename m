Return-Path: <netdev+bounces-158876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A51A139FE
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 13:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58F653A67F0
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 12:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBCB1DE4D3;
	Thu, 16 Jan 2025 12:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kXK5xmlg"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1581DD0E7
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 12:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737030863; cv=fail; b=CxYQrYw3lfPirOMa34GYC0/ZhGbyp4hWZxzkEPHYWW7sym2/zAQDENWqn6K3bxtjjpW3/x/ZXfCUOZP9pfYnfeFUeRK7gmTdC+qpjSwB68+vEMFXQn/a9a2ldUg7Z2Z91Y4YJb1g0nAW5xtFEOFMyLRcChX90AQXb4fjR7Ppxs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737030863; c=relaxed/simple;
	bh=8o9UtHMEdTeIT40+BWOZwUilM9VcfW9M+UeedMdTkkk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JfC4qqpouVCgaQqSifvkZYqolbP4yPcJIk6zoJi9U4Oy3kCD9mAVrd86XiAghGlAr2RHP/AFOc4F658EHLJ/pRSFSmGRjM3z88Pc+OQD5a1rMwhDpnPEjWdxW9aGcWBR5j6CJCmSRiX+xTXo06wfhkW5X/LkX5XnHF+cJOxhQHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kXK5xmlg; arc=fail smtp.client-ip=40.107.93.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LDOeP/yhVO91UKA6Sn6FxerZhBWQ5PnmDIhW7pZuJsidcnZa8fBSN3rRQ5KmkjMsyPSn7gspTYQzhal77Tct6m1/YepEFwZkHg46nfX1itw+EDEybudFcOFhX9uWPJ8+lWmW6xJ2Id0VRNYT5vWmH38RL803UaaqoypN+Bb2sYf3GmPRyRDKikaEiD5vGbWMfAgQsv5IuorXWI1Nc0TzPKs6rsRGCvYJuvD5hEgaOw9UgZxy2Gs2eC5Wm5oND6D3fq3AGViEZl24zlUeGNRHQSuzYqI2b+QZuyHXezNB8kmpV+fX2i3CjLFj6ZybbeEVmLArQLCKEt4Oh11iVaaJmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0dSD+QM5ZiyvEBJQRFdiXZ0CWZ1jDK+xvzNSqLf+iw=;
 b=oVfB44SSMZu+0NeTrx3qWo4WbI2Vq6LWZsV/O1k6APymG4bIHu6XEf+ZvSF/8uWre+MnzQA0nq6Gj7yyXRgNtCuRh+E5A8I6sc/9jTCsbn4ohwRF5rR6WBynVpDBf1GxihP0922c/ww9fPUJkChYN6gXG/B8FyYaFRFauvvfKux9KxGnV5cDtO3O+Gdr0Mr2vNowMi1eLox8QTU5jJXXJGcPDPT/HdBKiWEkhhVYfYvWk1KTssopTwTMYx/W5J+MDmKk+ZCnpwmi+MK4xGFEqqBahl+aYH7F28BCiIFChCv8Ib8opkUwPScesVxfzbbil5cucUCPymeflcXGW2U/gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0dSD+QM5ZiyvEBJQRFdiXZ0CWZ1jDK+xvzNSqLf+iw=;
 b=kXK5xmlgN9M55MZbpqqtB7KxpLdb3gc7xREliH12bAGPICrG1bIJzYchMh5nXpnboAsQlkdvpENNyaWpS+4b74qppUh75ym5PUz45LgFU7u3J0/0uundRnCTt/gunghpg/HfHfbbzzqgNrziewXdQMXn6VobD1t2ROP3bdC8Em336xJOgank3zt+ronswRtNjCDs42EHrwTSXi5qTkjoSSJrcT2GD4PIGhm8DiIw1jDoegGHnkRY0bEhmET2GL2KF1DM7120y/PTjrl2UG1sfxINaIcPKYeh/K9MVWNqlYz36RGbP7M9wON78WH5yooYUQyzM2/MEEYaT0buqV/1kg==
Received: from DS7PR03CA0033.namprd03.prod.outlook.com (2603:10b6:5:3b5::8) by
 DS0PR12MB7852.namprd12.prod.outlook.com (2603:10b6:8:147::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.13; Thu, 16 Jan 2025 12:34:17 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:5:3b5:cafe::77) by DS7PR03CA0033.outlook.office365.com
 (2603:10b6:5:3b5::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.13 via Frontend Transport; Thu,
 16 Jan 2025 12:34:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Thu, 16 Jan 2025 12:34:16 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 16 Jan
 2025 04:34:01 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 16 Jan
 2025 04:34:00 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 16 Jan
 2025 04:33:58 -0800
From: Moshe Shemesh <moshe@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Moshe
 Shemesh" <moshe@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>
Subject: [PATCH net] net/mlxfw: Drop hard coded max FW flash image size
Date: Thu, 16 Jan 2025 14:33:16 +0200
Message-ID: <1737030796-1441634-1-git-send-email-moshe@nvidia.com>
X-Mailer: git-send-email 1.8.4.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|DS0PR12MB7852:EE_
X-MS-Office365-Filtering-Correlation-Id: 050eaa40-83b2-4ee3-fa08-08dd362a1762
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E6CS/IGynRbwwk5b/f4E3sr0iqN23Y+gPN5PVjxTzIwHt6pwwQxEqHLga1ki?=
 =?us-ascii?Q?8gx2LaQY9cEB/RiJ3JRdWyae5Uii6qScFWXJx5Jo2WtWwHjXHmKR1hvX/6cP?=
 =?us-ascii?Q?CNao1taKVEP08PWXGwzmlPxHafrL13claA3x2+IC5KFyWjAWPzVOGPzTIz5r?=
 =?us-ascii?Q?hPYzrAymFplJ9Slmk4BARGrhPQoor0WpBxaDsWEF0DTH7RDDlTvzgsadZuFK?=
 =?us-ascii?Q?+KxPrL1GZIxwjto/DTVTBGK32kemWHM9fPDjcgHvIHJ6yeUlBaDNZGMg3lPt?=
 =?us-ascii?Q?56UxW+cW5m5g5icGF3h6Coy8IZB5crioaf+yIZeamYdfOaGjpZ3hiMzhZILW?=
 =?us-ascii?Q?6eYKgA83R6kE5KZ2QxskLFJZtV0Oc32WitehnMlnLgGT+nZLJymXEmZjlDJx?=
 =?us-ascii?Q?wXauQSUefSZpektFRN6P7l0nY1pO29QM7I7ywj8WPJifd5aWt4CxIirkjpdT?=
 =?us-ascii?Q?j6muK7yHC674/1c5bJKlKqhH9PBiEXZYoHTX2gcKubXhCx+WSZ2OsCcgReNy?=
 =?us-ascii?Q?5GoVTmdki9VG2qhHLdBVWeONi1yYL93ke6BRu1fwBkQizy04cGjor410iunZ?=
 =?us-ascii?Q?ApyTfoNZCtYyz4sYAgq5d49mkIwcLFcI2PvQlE6pgt84JTQWeP6ObfR0X/Kt?=
 =?us-ascii?Q?Nw2WaPkq0zjgHwqQlQh8EHjN046rF7GvCEkOFg88/IOsII5+CasAAMSHTXu6?=
 =?us-ascii?Q?Givu0m5ePlt1zk9HKyq1vA+eg6xEMt3Kp2I5tMZXzSeMVy4VRRZ3u2ZLr3tu?=
 =?us-ascii?Q?ThUVCGnTvyb4E9IqS0YsWZSWffXW8Ri8jr7wv35P1SwTCaAl0v/o+jecTAgF?=
 =?us-ascii?Q?CyxjCvhgRFjMMK4xpnnPHJrtGU79EcFpYZLXFDbnIPuzajJlA4qqqFDqcRX7?=
 =?us-ascii?Q?yOCHUgCcylV12mIXjthi08Py+QFalvmfSLfVTjojQ7XAuq+vgo0iPQSYCRlh?=
 =?us-ascii?Q?h0ALcS5vBaZ0726fyIkousetVRxYBN8p8wApy+QyMP+jElbfaYF4ab7fjR32?=
 =?us-ascii?Q?zNrqzmDs0exY7jTxDwK6vvAxkO0BkNmqRuU7kvs5VwXqt0fF9ge/IK5oxmmk?=
 =?us-ascii?Q?KJcx50b6f5bmyNDttMIoTxnvfkFclHbP2yU2EOxnON0YF9fOiMxHupJ3WjPt?=
 =?us-ascii?Q?uxKYohC6jyYlxTIDaVtwi420L81Rcz6lTrB10sAuKJYclkVbuVFIn1DuYLxC?=
 =?us-ascii?Q?bCxG/xt/ubNjHj+9Yrm8kQ0nB3W+7ioNRQtxCmVy3jNWZGneBNUiyz0n0ad6?=
 =?us-ascii?Q?IkC3LIRMONOTN3JiZK335KgdSlSDStFhiwEni5k7uDbS/cQSqTsq9eCzTRGb?=
 =?us-ascii?Q?hZ6fOI6xdCYkpIQOLvXZEk53OwF0qlvg60+XEwd/mDXPhKg1KZWov+uzaK/f?=
 =?us-ascii?Q?d4h1NsQzFY0dwQ/zcvPollD7eGZ3m0K8B5Rz9VIqV3FDoSTGEnv3GnVPfg+9?=
 =?us-ascii?Q?XJECI4xNFRN2vbsT/1Y2QCiX880O0Z9TrLVSckoeMyboloyLUFDX4w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 12:34:16.4273
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 050eaa40-83b2-4ee3-fa08-08dd362a1762
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7852

From: Maher Sanalla <msanalla@nvidia.com>

Currently, mlxfw kernel module limits FW flash image size to be
10MB at most, preventing the ability to burn recent BlueField-3
FW that exceeds the said size limit.

Thus, drop the hard coded limit. Instead, rely on FW's
max_component_size threshold that is reported in MCQI register
as the size limit for FW image.

Fixes: 410ed13cae39 ("Add the mlxfw module for Mellanox firmware flash process")
Cc: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxfw/mlxfw_fsm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxfw/mlxfw_fsm.c b/drivers/net/ethernet/mellanox/mlxfw/mlxfw_fsm.c
index 46245e0b2462..43c84900369a 100644
--- a/drivers/net/ethernet/mellanox/mlxfw/mlxfw_fsm.c
+++ b/drivers/net/ethernet/mellanox/mlxfw/mlxfw_fsm.c
@@ -14,7 +14,6 @@
 #define MLXFW_FSM_STATE_WAIT_TIMEOUT_MS 30000
 #define MLXFW_FSM_STATE_WAIT_ROUNDS \
 	(MLXFW_FSM_STATE_WAIT_TIMEOUT_MS / MLXFW_FSM_STATE_WAIT_CYCLE_MS)
-#define MLXFW_FSM_MAX_COMPONENT_SIZE (10 * (1 << 20))
 
 static const int mlxfw_fsm_state_errno[] = {
 	[MLXFW_FSM_STATE_ERR_ERROR] = -EIO,
@@ -229,7 +228,6 @@ static int mlxfw_flash_component(struct mlxfw_dev *mlxfw_dev,
 		return err;
 	}
 
-	comp_max_size = min_t(u32, comp_max_size, MLXFW_FSM_MAX_COMPONENT_SIZE);
 	if (comp->data_size > comp_max_size) {
 		MLXFW_ERR_MSG(mlxfw_dev, extack,
 			      "Component size is bigger than limit", -EINVAL);
-- 
2.18.2


