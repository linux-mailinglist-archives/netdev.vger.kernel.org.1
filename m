Return-Path: <netdev+bounces-148558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB1C9E21FD
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 16:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA47A2822DF
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 15:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FA61E3DF9;
	Tue,  3 Dec 2024 15:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YKEGYbIl"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9A21DA3D
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 15:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239155; cv=fail; b=QHWr1lLlvpnec5Dl6PG/FOvzw94krEMOqZ6FjqQmmfR9SSdvszra9+FLQVKTNJ6OE9KegN7WhsmtR8nrjvon/hDBXc19ib7eCpBQ0diuYZdylfDZV3RpYEoJjnBDrMqq8z3VzwfhfYdgVwfcH6Q5bEJ4ncJ4YX/EE3A2JG33nQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239155; c=relaxed/simple;
	bh=QgaKV2QutXk3SW8q/d5Do4wyiV4MqT3UXTWZynnPfbE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DYexdpVwAhIwrrfXYXg6LGJ4W533lB4O4rajzAYfTMqXpYg2PqaL0h8neCFiOXWqROllVSteh5pJhUQYiJfoIdanrr9fVakZakVO39BvxHg+mhzccG+ehd05O1j8uqBI0v962hnkPeQO6oVrrvTaElOSQJQIZrXO9rD11LtKtNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YKEGYbIl; arc=fail smtp.client-ip=40.107.236.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bYp/fevhPd7ZI+wswtuOA5s5vBxw6sR5OYEouuxTVkgCnznCQEHNtuL84KpUooNoVrF0IsEEnE3JVEVVGMsgOTSw7EHMMRo/UKE3tNG27KzMzdjVR3Uzxzjhhv6UHbdR8W/fiXe2sMXaQE9dkw+us2YWPxAINUb6YA35YqxUudLNO2fXgslUTDZ8UK7uldI4B4+ncyBXAQUkW4SPBMP70SO473E+9euKMq8GKc4jjqUxkO8pbi6SczuzDuCerS+Dl/obzBBE31fFPIIjG3TzYgGPkq/IKtikc7QGKqB5cI/9Kk2pvoC162atkrYoZ3uvx9XeKi2j2D6O1eprOU4Bvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PEfoPcWTz6xdfh2d5KIgvJvnuM38uwIfLK/shdMaYaI=;
 b=EPgG0HZ8PFuLDbQVoCUiSehAYKpm9zRb4UxpEwaMOQMcDQHrqi6iafsSzAXtRs8hqprCHU5tw/5Lm2cV0VVN5dQsPqEifq4fjG1gyGn83imBExAUhbsiPlCabqGu8PgeaVKae3tqyye8CSvziPQAPhmntqCH5iqyaIZAuI3qW7kvd8QKwc0D5cTyJOC9/xCzpq5Bc7djf5Bmw4Gubx7IM9KYTlHUCSHwX8XdvfcVNB+me6fVGepzYgGSFd1uhK7M48aQP7hr43ox00uBw02D6OjeFylYwNhXy7ed+87+QAV5srjCEpwRpT4EwOeWCXuAE3hwzlwT+IdRyCLTnVfOBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PEfoPcWTz6xdfh2d5KIgvJvnuM38uwIfLK/shdMaYaI=;
 b=YKEGYbIlI0vecToStX7WM00nZPageZvTKVPgcyF0kF0EJrUsMWR8nX5YBX4Sudlqclf3Ow29MAtvKNGfPx3z5PyvYqheiPALDcaFCDiiWrBFnGZ7vz+4JPWN+FUG4bEiF1yVnZzJ4cVlCA+0uMYyXE/ZO28YjMAEbUiNM8DUaD/3M/CGzH/bxjw0dnJWIQRzQbTMEs4TO2VH0LUbpI+bBtjiImjXHck7MnMZX4E1xujBr5lBSIKjfFJlrofgK01PUbdYI0/hOwz6sP82ISySZAmyIGQieosMLCXo7b8/9N72Yr45Jyv+Y83BJFyedT0tqLLOx47jxFv4uEMUwl77XQ==
Received: from SA9PR13CA0016.namprd13.prod.outlook.com (2603:10b6:806:21::21)
 by MW3PR12MB4491.namprd12.prod.outlook.com (2603:10b6:303:5c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 15:19:04 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:21:cafe::a2) by SA9PR13CA0016.outlook.office365.com
 (2603:10b6:806:21::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.8 via Frontend Transport; Tue, 3
 Dec 2024 15:19:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 15:19:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 07:18:41 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 07:18:36 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Amit Cohen <amcohen@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net] mlxsw: spectrum_acl_flex_keys: Use correct key block on Spectrum-4
Date: Tue, 3 Dec 2024 16:16:05 +0100
Message-ID: <35e72c97bdd3bc414fb8e4d747e5fb5d26c29658.1733237440.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|MW3PR12MB4491:EE_
X-MS-Office365-Filtering-Correlation-Id: da1611e8-c1ce-4021-c9d0-08dd13add2bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X+LIWNnIMe8H1NB1SjZORUAOVt9ugY2R5YLJJuYKQ7K9wqWWCA8q9OwELbpZ?=
 =?us-ascii?Q?P/4H90NgYBqgaQ2z57DU+AIl29G7uYbfcDWpyWSEFiqommgxH0lI5LJgybrh?=
 =?us-ascii?Q?7rATD6B5jg3KBMac9OERdzEs4yr0pDOP3gkCjusrZJCWkqtQZUnqOidFk8Hf?=
 =?us-ascii?Q?3HZPsWFzrJ5coBze0bKl4Y1H3k6KwmqD/FfcBED2F1fOah74VGZSuq2xFwuF?=
 =?us-ascii?Q?/ab4OMzmFG3XyET75blIdqNMZLowyd7gBp8sD67BgtmIhMxr/grhmCo5O/47?=
 =?us-ascii?Q?yNvFg9rm+CzWtzxHa9U11M0aMXieop+rhiRvkW+1/BIpgkNNZGGLTi6uXmIB?=
 =?us-ascii?Q?rTRD79HRjQmiIXGjWp0TN5pUZTDRuChu92Taa/xe1myr5M7eQeKC8njSOrSJ?=
 =?us-ascii?Q?BQVa/UWxwtVVQK+2mz+D3X/RBfZIvbOsztmbqU4qPHg4wqHMZKcaTPga1J4z?=
 =?us-ascii?Q?8cOtQ/4HjMkOPHuNy03hMlyyiAggCPZmN/EmkEwbus2cEbC/R2X3AfvJp7Ql?=
 =?us-ascii?Q?jNaADq1gp7F0EpqQOUs/a0dzWeyXR2ITncCbvGtar4UUKdR2BfpT7SB/XcyX?=
 =?us-ascii?Q?np+ZUGgsEfy32cCOq2hayIT79/ophXq14KQZXdob0pPIex5vuhmbRapet26i?=
 =?us-ascii?Q?BqJ+tAjFMXVC6NTAAr3jQhq7I1MQ0EQbafpKiFMMHvZ43Fj/B6FVKjgpX/W5?=
 =?us-ascii?Q?uEfN9nBcFfxvrV8byEUZaRjjzLH8FjRGVcpYy/lBLGB+1IcxgBInGgUTZQcy?=
 =?us-ascii?Q?L+GiY8kOvJJDt6ZBtSx7srTtGtHZ2zlReN6yxzNXdNlTUuzYRnMNZ+nAv74S?=
 =?us-ascii?Q?eDO0NKntJyBO7a8geEji/AmgholVMOBHJ3SVDA6vvbDSaTJevbUXE1IxIC0P?=
 =?us-ascii?Q?ib2SbcIms7Ieoh9AsgWIU7zd0fnJQNlIg+W1wKW9w07dbLiCabi6xOH+G369?=
 =?us-ascii?Q?7gIinHjMd6PbhXMylDQubuw8sDH8bCoSQzSAOvREQqpMvjKw8S7Cqvd3F/Aa?=
 =?us-ascii?Q?vgjOJhbvdbJnb241gmWFikJh3rQF7cJBm32WLFss+ZwUFpynrhU2Xb3k8d5k?=
 =?us-ascii?Q?dhtOGGYspE4xHIFQI8uvDGh6m3Z/fycHffWaokkuiMLRo71xOdy6kJjjWuYF?=
 =?us-ascii?Q?MJN8qX4Fvu0a18P818NBpKiGwHq8OuwynJoAUhp004Vc9oH3oUirc6MwUml2?=
 =?us-ascii?Q?IK5S30oHuRu8xSYpnDOfg+XyCRYF3orOaL96VSHN8EiSG4ROHtPq+ePk/2rr?=
 =?us-ascii?Q?uCYplY4aPP2KyFdMR+ctVuxmkPqDKgV3IWQEIqiGnuCSkDJTrgdmvSeEChow?=
 =?us-ascii?Q?a50cIuXC2q8d+EY2UndJ38cNqiNL9xB9UZaG/nZUhuBWdnCKIYRvWSHNnI5R?=
 =?us-ascii?Q?t+YWh0oeiz2aUUdo0JHhWv1v/BklchrdOYOko6+RveYcIDXW8OGi51K1Jfpt?=
 =?us-ascii?Q?BWO0d1dNmjSkx46egWmCV0dM64KYlpuj?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 15:19:04.0501
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da1611e8-c1ce-4021-c9d0-08dd13add2bf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4491

From: Ido Schimmel <idosch@nvidia.com>

The driver is currently using an ACL key block that is not supported by
Spectrum-4. This works because the driver is only using a single field
from this key block which is located in the same offset in the
equivalent Spectrum-4 key block.

The issue was discovered when the firmware started rejecting the use of
the unsupported key block. The change has been reverted to avoid
breaking users that only update their firmware.

Nonetheless, fix the issue by using the correct key block.

Fixes: 07ff135958dd ("mlxsw: Introduce flex key elements for Spectrum-4")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.c    | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.c
index 6fe185ea6732..1850a975b380 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.c
@@ -324,6 +324,10 @@ static const struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_mac_5b[] =
 	MLXSW_AFK_ELEMENT_INST_EXT_U32(SRC_SYS_PORT, 0x04, 0, 9, -1, true), /* RX_ACL_SYSTEM_PORT */
 };
 
+static const struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv4_1b[] = {
+	MLXSW_AFK_ELEMENT_INST_BUF(SRC_IP_0_31, 0x04, 4),
+};
+
 static const struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv4_5b[] = {
 	MLXSW_AFK_ELEMENT_INST_U32(VIRT_ROUTER, 0x04, 20, 12),
 };
@@ -341,7 +345,7 @@ static const struct mlxsw_afk_block mlxsw_sp4_afk_blocks[] = {
 	MLXSW_AFK_BLOCK(0x14, mlxsw_sp_afk_element_info_mac_4),
 	MLXSW_AFK_BLOCK_HIGH_ENTROPY(0x1A, mlxsw_sp_afk_element_info_mac_5b),
 	MLXSW_AFK_BLOCK_HIGH_ENTROPY(0x38, mlxsw_sp_afk_element_info_ipv4_0),
-	MLXSW_AFK_BLOCK_HIGH_ENTROPY(0x39, mlxsw_sp_afk_element_info_ipv4_1),
+	MLXSW_AFK_BLOCK_HIGH_ENTROPY(0x3F, mlxsw_sp_afk_element_info_ipv4_1b),
 	MLXSW_AFK_BLOCK(0x3A, mlxsw_sp_afk_element_info_ipv4_2),
 	MLXSW_AFK_BLOCK(0x36, mlxsw_sp_afk_element_info_ipv4_5b),
 	MLXSW_AFK_BLOCK(0x40, mlxsw_sp_afk_element_info_ipv6_0),
-- 
2.47.0


