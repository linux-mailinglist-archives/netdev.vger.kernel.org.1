Return-Path: <netdev+bounces-84026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8327389556D
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 15:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38B062838C1
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 13:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF9684A58;
	Tue,  2 Apr 2024 13:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KShbrcBP"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2703B81742
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 13:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712064733; cv=fail; b=lOeY8FpKujON6Nrl4BtnKuxxUa6q06fHosqwKKqlJn2huhK1/E19Qqs+YCZ7AdaKDYjaWqvsruxyjPKrh6gXs8G43phLimr+Muc7mpqkiFZles7uMJdPrd7f1pYsNlrADPCDWn4BA3eaMCDP0MDc0tqnutaMNvgrBtsIeTacoW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712064733; c=relaxed/simple;
	bh=P8dGs+wRJLtGDNZhbb27iIuJQQRJb3bd3XslW85JCJc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c+Z8G3LX4CXpiMRfciT7AcwOdsVAWFZM36S5M9OBw3r5z9M7DhQLjcTcVSuUp84f4kW9qb21g4epXKOlYKHWBzSTbqM2pXtQBLcQHcwqJ2sh3z16lWgIfnyPttjAKIcl9ZsRvzricWJnmK8a1kFjCmDORBMCdjrsLqTZVkZes5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KShbrcBP; arc=fail smtp.client-ip=40.107.220.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bHj6RINoF8YKJceiy6I3GIFKvMrJAaK4P/+WgP/gBfvU7EfEJo8KLxjWhAUKm1u8sZwLS7cbmeD4gEMMNK0NG2VBip5GJqxQc4TD/HVFY6xLIkaCkpC42qP0QdsXVLr2DdMK2EBu2lYQNMlIiDcQFaFCCk62WGivkVezrfaEyBXq+ezaAiv+qXpf/pzWIR2JNZhcXHeSy2OQWLTXZEdI7yNdKBIaJdYGdR5Ixn6FxR6qCU8SGJ2q1eKUJu6wfJfvbaXhuZMDaw1RD+htO+wJ7xTD2sJV90NFgdnbiDHPfLektBDmFaDh1SxbuDZUm05C1xI2EyXnB/FuXDoQFYTMmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w2HMRsa9A0A2KgvO6WWxzkiP62nQlHotJVNsXhay768=;
 b=frLTyv/ihXESIiTNpF1BISOKLoAtASOAc1PhYvVVnraqQa6qO9WbiUeD7S6wO4aIJfs37q708s//mFCLev+IUZ6euHzynydk3blFYnIrgelh2uMdY2ikWRBqvwWcX0gRJD7UNvklYbGuy4Zn4H0Bor1bHyOXRs8f9ilVx5Vor5vtS4NryZieDcgHJmNuWMX0pC0ShKbIUjYorKLcQqIAQfaO6QkSb/357yC772AEKZLK/5QafhfLAS/oWoSQN6/NTAIM7SjE6SARpwkcDaabLIhU9R+230vkzekqduwCEIrVYMwgBhm9dvBUJikESeS16+LpIoOV6KfHviZUe0Rp9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2HMRsa9A0A2KgvO6WWxzkiP62nQlHotJVNsXhay768=;
 b=KShbrcBPvy5ZOazQUqvzCQm2Z0KTQKilzkqmlCAP34JOOQ78TG4sLaZ2rBrGf2hADUEJNPENa1QidHyhrfV0S0dFxYQGNUOF8BlUj1NUlupKzxyZwdHJP9mHWm9+BeUntfOkWJCudP7Z/otxWM5HRJjCXuk0Td/CheBpp/CRiYi6Esnm37OhHNFMZO2gQ3PErlC45ZzWUJCYg/q7KViSvIIzOSwhflaZfUYMXmBnPL8eV/5ghREo1R8dfonkpQzkLZ65Ccp+z9zM8/A+TeRzZaEgIcl1aS4/oMg1UPanATQfWZ7IkpHJP06fPyNZ8ao0Wz08LGt4mgoxuCl1vYB9sQ==
Received: from DM6PR03CA0079.namprd03.prod.outlook.com (2603:10b6:5:333::12)
 by CY8PR12MB7147.namprd12.prod.outlook.com (2603:10b6:930:5d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 13:32:09 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:5:333:cafe::5a) by DM6PR03CA0079.outlook.office365.com
 (2603:10b6:5:333::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Tue, 2 Apr 2024 13:32:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 2 Apr 2024 13:32:08 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 2 Apr 2024
 06:31:39 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 2 Apr
 2024 06:31:39 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Tue, 2 Apr
 2024 06:31:36 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH net-next V2 01/11] net/mlx5e: Use ethtool_sprintf/puts() to fill priv flags strings
Date: Tue, 2 Apr 2024 16:30:33 +0300
Message-ID: <20240402133043.56322-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402133043.56322-1-tariqt@nvidia.com>
References: <20240402133043.56322-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|CY8PR12MB7147:EE_
X-MS-Office365-Filtering-Correlation-Id: d891c7fe-bfcd-4a60-c1e4-08dc53194b8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6JV8w8IUqpkrDVl156Pzw1rIx/l7Ab0y1x1zBbLGyBzPav9GwGKod79QPIomNbmd5boW+mzrB2D18j+2iAgR46XOlhvsyqveyz4OlywYQ28Op/S0s0OKBQABZn3ASbhxwNm2AbUrddBi3+7S+/YQkPe7S0NakuR6/Y4uch5AFc2sddoUlH3K80dFgVNyt68Yp9dKp5QYl2ktntc2mtrc5ZibsPA7HkRakov+nIP92Q7R3putv58PaWRuZoXiBooEeboNDSNDrKku3NxsaniuW8Es4/V6H4ixI0OccQHwHNE+gmRHNJX2SO1tRicLBiftaH28GoCg/LtlRY8NPnO9fklMUdrF84rgqjD2iHKQJ6uQo3qoK+AifFl2BjHUWNxdsLDG/6KQsRgGVTQ/pZ4tjf2EHcGkQlCiLqR2ZrCRyk3MqmFcCxCd+lEzQ63g9HjD67lWYdF1gF2aPp8Q06jo5ejXXIl2c4ZCgPVY34al01A8rOIKOaaVbaUJBku14auKf7NEGLxR5gGaWDb3qRjsivnYiD7omL1ibypmdr0ZyodJes/cWO1kmjxS0HPSGUWYhqW2kasavJMhtur7LHnY8IDcgdciQ04oU+/cqP8+YG0lWN6FVMAXgchfO6/tX0FD39wmG27ak+uFc2ce7cOmnkRyWKoky/ldYlg2OAqoUNbiOXhrGJbioW32SJGHYuSD+b7LFskP+G0XJErh57dUV17a263csMsANVQFm5C8EMrS9wsVDePFC9W/DMXxFVoX
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 13:32:08.5361
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d891c7fe-bfcd-4a60-c1e4-08dc53194b8f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7147

From: Gal Pressman <gal@nvidia.com>

Use ethtool_sprintf/puts() helper functions which handle the common
pattern of printing a string into the ethtool strings interface and
incrementing the string pointer by ETH_GSTRING_LEN.

Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index cc51ce16df14..b58367909e2c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -269,8 +269,7 @@ void mlx5e_ethtool_get_strings(struct mlx5e_priv *priv, u32 stringset, u8 *data)
 	switch (stringset) {
 	case ETH_SS_PRIV_FLAGS:
 		for (i = 0; i < MLX5E_NUM_PFLAGS; i++)
-			strcpy(data + i * ETH_GSTRING_LEN,
-			       mlx5e_priv_flags[i].name);
+			ethtool_puts(&data, mlx5e_priv_flags[i].name);
 		break;
 
 	case ETH_SS_TEST:
-- 
2.31.1


