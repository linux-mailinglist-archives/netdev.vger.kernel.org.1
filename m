Return-Path: <netdev+bounces-42559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EB77CF533
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 12:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45FB428204C
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 10:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AF018C0A;
	Thu, 19 Oct 2023 10:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PIdCqBr+"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2572199A8
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 10:28:15 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67665119
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 03:28:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SzX6IxP3thUVf8oay3mg57gfHZ/HmuXx5RXBAXjPxyxnMZy6DCSwTcn+u2h1E2MzVdTZ7yJIGf8ZANQ4KpSzYDNYLE3HpxEh54vd1HrS7sSvdUX+x1H7olIwTQRgwGwQWi7CtKU0XgXmj+wlbNlAWdRgfBQi15TtFlXCwlc0VPgxeMTrKeR0PaREMlUIeyqMHfVffmK5BxmKlzhIReWywFPvpgsA/Yxzr9szKXmOPPFZNWIap4DjlFBL7yO5ifhAd+in6hB4ljNTbnkh1So550r3AHCpNsNSjE4tsAVeqlGM1QEdAaoQ8CgqtQJ32Y3mOvfiT2je4Q0965phe7Kotg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G1+hiBRJbjuHXhyCd4Lp+6duLUW4ST5GyxVuEXrdvCU=;
 b=DGSul5uaeS0nBgyVUgLquD6geL5BVXil6Tewj5778OkkkrzyG/2YNyQ5hgHyRhIRgiLdXOMlVNqCYFXmlgBSYcAE+zHUfE7Rh5RM58TfamFPTVohtX6yGuE7AJzPncZlIDq13vcyZCZN9HTttKxkW7PYgRhiJIPJuMtfDsCeW5VE7PiSYDb1HpJ59W1qqYFFRSVS5ulUkUJQxTGK9+nwzB3NhnmCqwj9GYqmLwYICvxyJeUv25qb4jNZ7Fkqr/HX7ThhItbvgSwmTEbLTcusHZovWGs9vUw45T681wUS9r11ZQXtV3gbri7cNCFejBD7VNgS5gojhtDOdYgQnOQ/zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G1+hiBRJbjuHXhyCd4Lp+6duLUW4ST5GyxVuEXrdvCU=;
 b=PIdCqBr+R000eve3ZcmYAGKXeUhSj7ucnsHDPis0fD2G/RMkuD+Za5LNaxyMJasMfeRv94buy6QPfaWs8+rmK/xHfE5EnnI29THeY0PF0CXpqfkiWwrc1K3XXAEnZk0PzpnpWe50GZZbB+Sd3XsU9QWeJbB8rrncW4fwsrFukuqkinTfppKhPgCO7ZPGn+L4aeWZF9fBaCZvsHGH+W2ci3Fwqfw61/pAc3Rd7pUJW+ODVLgqWODHXkT7Z/m5YWLnkyk82n5G0IDGqbTi+pO9+H8oBv4W55gyfEbvnifbSf1xXBBkZm/Ar2gphhhPBFo36PlnDB9d3Dj+yUJxZ1la5A==
Received: from MN2PR12CA0016.namprd12.prod.outlook.com (2603:10b6:208:a8::29)
 by BY5PR12MB4051.namprd12.prod.outlook.com (2603:10b6:a03:20c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Thu, 19 Oct
 2023 10:28:12 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:208:a8:cafe::51) by MN2PR12CA0016.outlook.office365.com
 (2603:10b6:208:a8::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24 via Frontend
 Transport; Thu, 19 Oct 2023 10:28:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Thu, 19 Oct 2023 10:28:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 19 Oct
 2023 03:27:55 -0700
Received: from yaviefel.vdiclient.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 19 Oct 2023 03:27:52 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 07/11] mlxsw: pci: Permit toggling LAG mode
Date: Thu, 19 Oct 2023 12:27:16 +0200
Message-ID: <8ecead4979d95abbbfc69be4e80c0514fdbc024f.1697710282.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1697710282.git.petrm@nvidia.com>
References: <cover.1697710282.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|BY5PR12MB4051:EE_
X-MS-Office365-Filtering-Correlation-Id: 83caee40-b94e-4cb2-1447-08dbd08e1876
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	noSwqgYEqxN1YMEbaBD+ID/fNkPcaTx7Xm5mGUFzJ+w2fZ6oMNvWsGVlcY2oRXimA5VWQX0Pwciz8NIGU3PS7iQSceqorcSlSm5YyAYIq89cnX+yF3AgWG7Yj55L01o3lXfIE2lwrIgi5ZBt4KC/bl5GN7LzjrjJkjt0/YxSoVjggBR2wxPTp8xZfEEp82ssGBlrzQ/xsVFoKSP0zlE6MCSEIBMPjvMwykLcC+hrlKDSV8WHTteLFGA0wdPm8Aw91Bp2E0RIUOE76DJkouPOYHIRsKTXo7Uj78SFq2F56kOrBB6PS6cx5FaceODMWnHqiUNPSIKc7Pe5R6a5ChwV6+ACG5mXKgXey0fMgAxSJ/ETGFX7p1gCC3/JtDvmZwuhS3k5YYmDugjEvTBfjpr4wnudy0L/3C9B5p0+/UffhZRAsD4gY6NP+cZvsxZ7mDAwXtrKU+ClUTK709lMlYUTKr3BVn85rQFWke7VB7cPcVQFmjKiET0xt47/22lzCFo/A2CWh/+QdEjq31hdegQ8vwXfku2Y567reCc/VSKskgoGZZgTzLpvcNWsl/bEZA+cbj3nV5kQYdSGoTYyeXgfblFKoNq191XOqF9y0T4Jgehz2OVKEbtfPcmqUSyDKV/i3/h20JYtlI8MxdbeVIOz7MJWHq1nXMuOmKX/rKuCRRSkY0hisZ7N5+L+Q72OSm4KDSYI5T6gyJrcnTzogiOC6PETvaABap91FDYpyvCiPp0ZXR8npWKGgB+tkTYnt66E
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(82310400011)(64100799003)(1800799009)(451199024)(186009)(40470700004)(46966006)(36840700001)(54906003)(6666004)(110136005)(107886003)(5660300002)(26005)(336012)(16526019)(426003)(8676002)(70586007)(2616005)(8936002)(316002)(7696005)(41300700001)(83380400001)(2906002)(356005)(36860700001)(4326008)(70206006)(7636003)(478600001)(47076005)(82740400003)(86362001)(40460700003)(36756003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 10:28:11.5350
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83caee40-b94e-4cb2-1447-08dbd08e1876
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4051

Add to struct mlxsw_config_profile a field lag_mode_prefer_sw for the
driver to indicate that SW LAG mode should be configured if possible. Add
to the PCI module code to set lag_mode as appropriate.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/core.h |  1 +
 drivers/net/ethernet/mellanox/mlxsw/pci.c  | 16 ++++++++++++----
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core.h b/drivers/net/ethernet/mellanox/mlxsw/core.h
index 5692f34b2a63..764d14bd5bc0 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/core.h
@@ -337,6 +337,7 @@ struct mlxsw_config_profile {
 	u8	kvd_hash_single_parts;
 	u8	kvd_hash_double_parts;
 	u8	cqe_time_stamp_type;
+	bool	lag_mode_prefer_sw;
 	struct mlxsw_swid_config swid_config[MLXSW_CONFIG_PROFILE_SWID_COUNT];
 };
 
diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index 3e8347585e42..5b1f2483a3cc 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -1315,7 +1315,16 @@ static int mlxsw_pci_config_profile(struct mlxsw_pci *mlxsw_pci, char *mbox,
 					profile->cqe_time_stamp_type);
 	}
 
-	mlxsw_pci->lag_mode = MLXSW_CMD_MBOX_CONFIG_PROFILE_LAG_MODE_FW;
+	if (profile->lag_mode_prefer_sw && mlxsw_pci->lag_mode_support) {
+		enum mlxsw_cmd_mbox_config_profile_lag_mode lag_mode =
+			MLXSW_CMD_MBOX_CONFIG_PROFILE_LAG_MODE_SW;
+
+		mlxsw_cmd_mbox_config_profile_set_lag_mode_set(mbox, 1);
+		mlxsw_cmd_mbox_config_profile_lag_mode_set(mbox, lag_mode);
+		mlxsw_pci->lag_mode = lag_mode;
+	} else {
+		mlxsw_pci->lag_mode = MLXSW_CMD_MBOX_CONFIG_PROFILE_LAG_MODE_FW;
+	}
 	return mlxsw_cmd_config_profile_set(mlxsw_pci->core, mbox);
 }
 
@@ -1677,9 +1686,8 @@ static int mlxsw_pci_init(void *bus_priv, struct mlxsw_core *mlxsw_core,
 	if (err)
 		goto err_config_profile;
 
-	/* Some resources depend on unified bridge model, which is configured
-	 * as part of config_profile. Query the resources again to get correct
-	 * values.
+	/* Some resources depend on details of config_profile, such as unified
+	 * bridge model. Query the resources again to get correct values.
 	 */
 	err = mlxsw_core_resources_query(mlxsw_core, mbox, res);
 	if (err)
-- 
2.41.0


