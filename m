Return-Path: <netdev+bounces-213448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B1BB24FE9
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 18:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CF857B15E9
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 16:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A2A2882B4;
	Wed, 13 Aug 2025 16:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eESVvMlu"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC88286424;
	Wed, 13 Aug 2025 16:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755102881; cv=fail; b=hYlh/TjPlI1mpCp49eO1918P3hVfbAicCkHV6gUks6rPyJbkyGtAbCGz3kMhRrGPjMHkDZdEZMUjSOiMv2zG4HMuZExtz60bOxUnZTDFFxCyuQ+eBz9Nvkjp1pl4G8t1p+JjAa7bnaZZUlamWCB0ViCFI9w4jk5I/FKKwf7QX5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755102881; c=relaxed/simple;
	bh=3i1ouHLhiVbYxAUtRJoYsJUdN7mZWujsWV9JAPmExh8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lMBGO8ZslTKyWfQwEH8YwPGMXaJDuvJuoQrSsCCRsljR5o8aHbrCQLUEwfV0eCeOTbAm8n9r7NR6jCERBnANdHyq/+P7Odc+RV5SORPp3PSvg4RSsEU7idfPcuxvgEsSvl51itbXUMq7cjoaC32+NRxPoK2ergM/xqJey1uJsSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eESVvMlu; arc=fail smtp.client-ip=40.107.92.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q6AhW237M0bpd+ZWV/ZedFGDk+vvwvjb9UDh9BNyZl2G3Fp7J9UUvC/j/ehEc3FNaYJrgCoCQvuvuRCQY2GXGLNplnFeeDb+VCAtdPEvQQPZ/QcI+x8jTXcSd9aq8rOjDRLkW0uxP0GLL9Zi+i/1bN2jW8PLC+C7nmuugN5b8ZR3TskIpdYpA3BAG4giQ9XlU5sR4DkHilurPTdBIxs4olDS+C7a47Ru313lJbEGHBw5U/TiUhjmzZcRau+81nt1wkEd+Z4bjaa1UZQeZ9eyTsIk6Rv/8WCZ3mCY+ovjqTJfSX+rmVyFIiV2S56ljK5nXRXsMgSk3xDwSFGLEtit6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4DKr1uaSNOnGosufZHujfpm/NEgPz3T8FAwp59rLdy0=;
 b=Dawb6G0H9pdliB84j+azWoik4ygREr1BvnYl3eDw5U5eCFSr5gssfYE6r8E212EsLsnH0cKiC0XQ3xaF2ELzFlg7Gl9F/O+EXFIdY8A6j+SjpauAubUBuMoAnQrT94K9NYlTGVZAPl32VBuqXemevXFsuNJm2oljnx6G+zf3HLUu8nCpVH1efDh+3nMXQy/MAXwP0mm4JVw8V3iEqGbMOt4/b/LYUj3aColRwKbJU2uXgVceUzeFLnAYH5kSuW8dLKPOySyG4WM7mrAQEjA+b9Ld2hVngZq4iGnIUQpMxCJSPnVYYMe7+/tyVLZPESw10g8K2CKNSPLvO7Ht6RoKsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4DKr1uaSNOnGosufZHujfpm/NEgPz3T8FAwp59rLdy0=;
 b=eESVvMluDE1fJz9AWwLWDkoVYvvgeS3tRPcDBnsW+TEtc3X8nLXGR9NUvk7cli1vfKg3ksjnDSK34ZDIEEDZxpWgTlrCh+BchlEUsniE+C2p8Tsm3v89pGmVxC1KIYTiEXdIVwqVI1gYiuIg9g4MRdUR+HytSvIkX+sWs119/Dcy6w9zI3xDmXt15yPF7e48Qcyco6I8cCzbgu3cGhPmZRTuHqm//V5qBjRLdXSTGdj4/9v61BgaU1l9b25n6vuZfyVJ7fbpf2uI7aioyLeECjPRmYls0LNbMm9vIvY+tp9wEQrCmWSnmIgwlgEG3KUcu3e0VFkA/WwsS725oX0/sQ==
Received: from BN7PR06CA0052.namprd06.prod.outlook.com (2603:10b6:408:34::29)
 by IA1PR12MB7541.namprd12.prod.outlook.com (2603:10b6:208:42f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 16:34:36 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:408:34:cafe::1c) by BN7PR06CA0052.outlook.office365.com
 (2603:10b6:408:34::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.15 via Frontend Transport; Wed,
 13 Aug 2025 16:34:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 16:34:35 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 13 Aug
 2025 09:34:15 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 13 Aug
 2025 09:34:14 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 13
 Aug 2025 09:34:13 -0700
From: Chris Babroski <cbabroski@nvidia.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <davthompson@nvidia.com>, <cbabroski@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v1] mlxbf_gige: report unknown speed and duplex when link is down
Date: Wed, 13 Aug 2025 12:33:46 -0400
Message-ID: <20250813163346.302186-1-cbabroski@nvidia.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|IA1PR12MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e37fe09-e06d-4c44-2082-08ddda874a1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UBd74nXGNyxGxc3lJzg3qm84YinkVa6z+A4uG4bhIMZqgpfg8znJrpYF+p1H?=
 =?us-ascii?Q?qxk8KN9MA+af4KQ+RN7BbVnMeZ8Vnoqrm23c1sCDi8xefvCKDIAvDTRNOooI?=
 =?us-ascii?Q?5C9Oy3gaZmadUt6mYT5JB5I49PXzXXF5NnBSMRRDjTugUwHs3mOs3+4snCty?=
 =?us-ascii?Q?PXiN4PU26oAiG8czaE+gVYyo+chHULdPK3iR83OHK8DW2glARmQSybYPZR5O?=
 =?us-ascii?Q?49fPf2YL5VqS6pNWg/xDW76RAQaIOLCyS4vzBGSPSGhXxtWDR+XLc5uL3T2l?=
 =?us-ascii?Q?8xiMPHaR8vruZcrlj3o/oysgrputbXrZ7iD8lLoOv8URd6etl0YGsG3G1T8z?=
 =?us-ascii?Q?t4ATR47JhpKezM9HXJ1597vf4F/l5ZtvXUXV6zX7JQiFqkWoNKMun/K2clc8?=
 =?us-ascii?Q?ThES6C29ouYAQVelVQMK0pLRJzbpDHrfvi9LiAcqzDj6IlsHZj3kY0w90VMw?=
 =?us-ascii?Q?qI0OyFyNpAGFICMoUf5h5w/9iCePpcLWxjCBQlQQ9XPK6wmfhN17H+KLnsyc?=
 =?us-ascii?Q?aNGoYPcWfpLrC71J0OpGwdZrHWY2CZrAzCQT91ovaLhcNI7tsCvm8BYSQtI4?=
 =?us-ascii?Q?Q1NitzQDaFHiuXehq0slhtZ/Gj4tkdWGapCZ0WnFcMiU916wzU36paP+m7NC?=
 =?us-ascii?Q?aKgDS2obcmx3ZlQ36StrMU3l0BRzlzIJmDAWio4rZgH1ndg0j8KW2HyWnh0J?=
 =?us-ascii?Q?s2DGM9gdW8R5Zym70leYs3HHS3ao0+egSH0ZqjPhUAunArIBxIZ4iv6Ilu8C?=
 =?us-ascii?Q?TVvPZ4uc1skAFOF+xLbYEeyMdtWAb0jA/k6dVEQguBrx8RHbYAct9kojjn6/?=
 =?us-ascii?Q?AB37CDW9u1IeL9h0ZRiW1znpZKI2qqJwplqPtNaX+n5IPuS0BgTxjwhxNR3b?=
 =?us-ascii?Q?BBh4UCVUsJmB8z2sfpexORe0eSQAWdGRkVBsqNDTRRRdGL37scfEaMVsVtoW?=
 =?us-ascii?Q?sj2QR//wGLhdbBYu9otgsVwxL9+UtmZJ1IPNS1QyiijjVYMAu+ql7GcIQOEA?=
 =?us-ascii?Q?paLRhf8nTcUMG5Hwzv47UIDypgghbIa/9Ry+Ymfhv6NIJ8mnzwDQGs9HvrX8?=
 =?us-ascii?Q?a9JHdVpmNMEr5XgL70sbCx+ofWpUfsobcs3g9Cbs9KRTg1q71VVolsI5684U?=
 =?us-ascii?Q?CzYSCDR+R7SbSSdggpf/gKZh51JbVbk5EB6GfNtHQn2zkamEtq3AaPNukxoH?=
 =?us-ascii?Q?v7y/BcKzsjltf+OY/dEhzRcWQNN7e8YD63SRDlmzarTUoWjUHJH8fOdOgn+z?=
 =?us-ascii?Q?nzLi64/1MfbWTYsoqedYLzLF198wXw37pzO85dxjMCqSMz1n1/VYaCgsAneI?=
 =?us-ascii?Q?++5Bpp0eUsPB0h/mfdPzyXSHqJAkP4lQqOP8/nmXDB0WSMzKeDSFgJDgKFne?=
 =?us-ascii?Q?MtN/j9lBKf6wiW55jx9go7fbsrCNhVyf8/Ipp8ZOrBuxWBjTYoClqFFrTXOp?=
 =?us-ascii?Q?/tRtAfEphFXr3kFwVl5nQ4KYmYNgckKcd/swyTo6JgmmXvDyITuoTZWlon1b?=
 =?us-ascii?Q?bp4mYVXbpcX43LFg8mpx7b82PFsy6JF8X4jI?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 16:34:35.3367
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e37fe09-e06d-4c44-2082-08ddda874a1e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7541

The "Speed" and "Duplex" fields displayed by ethtool should report
"Unknown" when the link is down. Currently, the driver always reports
the initially configured link speed and duplex, regardless of the actual
link state.

Implement a get_link_ksettings() callback to update the values reported
to ethtool based on the link state. When the link is down, the driver
now reports unknown speed and duplex as expected.

Signed-off-by: Chris Babroski <cbabroski@nvidia.com>
---
 .../mellanox/mlxbf_gige/mlxbf_gige_ethtool.c  | 26 ++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_ethtool.c b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_ethtool.c
index 8b63968bbee9..c519eeb8ec48 100644
--- a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_ethtool.c
@@ -159,6 +159,30 @@ static void mlxbf_gige_get_pause_stats(struct net_device *netdev,
 	}
 }
 
+static int mlxbf_gige_get_link_ksettings(struct net_device *ndev,
+					 struct ethtool_link_ksettings *cmd)
+{
+	struct phy_device *phydev;
+	int ret;
+
+	ret = phy_ethtool_get_link_ksettings(ndev, cmd);
+	if (ret)
+		return ret;
+
+	phydev = ndev->phydev;
+	if (!phydev)
+		return -ENODEV;
+
+	mutex_lock(&phydev->lock);
+	if (!phydev->link) {
+		cmd->base.speed = SPEED_UNKNOWN;
+		cmd->base.duplex = DUPLEX_UNKNOWN;
+	}
+	mutex_unlock(&phydev->lock);
+
+	return 0;
+}
+
 const struct ethtool_ops mlxbf_gige_ethtool_ops = {
 	.get_link		= ethtool_op_get_link,
 	.get_ringparam		= mlxbf_gige_get_ringparam,
@@ -170,6 +194,6 @@ const struct ethtool_ops mlxbf_gige_ethtool_ops = {
 	.nway_reset		= phy_ethtool_nway_reset,
 	.get_pauseparam		= mlxbf_gige_get_pauseparam,
 	.get_pause_stats	= mlxbf_gige_get_pause_stats,
-	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
+	.get_link_ksettings	= mlxbf_gige_get_link_ksettings,
 	.set_link_ksettings	= phy_ethtool_set_link_ksettings,
 };

base-commit: d9104cec3e8fe4b458b74709853231385779001f
-- 
2.34.1


