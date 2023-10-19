Return-Path: <netdev+bounces-42557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C062D7CF52C
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 12:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 370EBB210B6
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 10:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70E118B07;
	Thu, 19 Oct 2023 10:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Cvf+M7n2"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F6E18B1B
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 10:28:06 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C1A119
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 03:28:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mfzj1BCZCqhRSvbhvZain7BZcp8FxVBl+j24AmpM8PXTkVMkxH8VHrudD556f19vazooTrignzOzLXCpB7jcj8UklWMBkivOTrgtpm02uImhxWaYLCo7LekuhYATsalivMHPIN1vWyV5usjCKBxVGAoGbVcj+BCICYi4VJPIPjiJFlb6JQ+x8Z8x+5T74zP3ydwQtiNDLk2xFyiIin3RNqpacp671/8r7egxXN23DXAXg59jTq48+mJsHSuj8Bg3xS8JzfG8gLzLVeLv3J8nErxOHGeocmDSSF+YoXHmvtsg03nS1a85sc6AbJmMp24mv5fFoa1cHriL9fYnhcWNtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJH/9jktZ0x9+sL1TIsncrqYKonpqcgemXCybNeUA/0=;
 b=MpysXE1tl/uLO4et5J8T3qoIDUL7DToN9clYYq+RhG1ndzGHqjzVBXkdLFWPbgUqVpkQ9mgp/PSXVNjXCVnekSBYC5t9zF92eqPyxnFw0jgSLKikCpbm51IpTyrZ0H6WYklJLolNU0OiAQwW08Xaj7cYjSxspzuB2T4Ff4JsvDSCrhrqonc7wRo2reip7NWt8DxqomCH5DnXLL5UnAsqiQiDQrQRDO9/ofo2866aBzQdXnDATK+/7vsWdo4MyIhkiVmIv8m4zmaRdKgNc3HWTtrZpcP4vGFgscnkoyzeqXE4fCgRROUt6QIZx9pfbEonQM5UxgaykVEVX5//y8ggrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJH/9jktZ0x9+sL1TIsncrqYKonpqcgemXCybNeUA/0=;
 b=Cvf+M7n2QSb76x0pUERFlFSS3Kc35vv0hAyOUfCHkFRN3Eo/X5W0yYdcFi6oc8tPmPZubCpLBx0PW7R1cqaEHHv/znnjJmzO8i/9sI7o26Dsx7f8VerxKKkn0EJ+IHs0IGO8J6ryCR9Ae6QR+LMdIGCADtqW9rZmqCuUMqwJ8Se30pJwrL0I3mCvm97vAGgEqZNBUxW3EtN/PEBbfl/O1EqAqZSMzxiqoXrb4QIF2yOnEj6y8ATrAycBFk7iwF8j0gCbEMamytaEJY7or90uLdJskFCNbPvp5ZcEhJ7hDk9npESxCXAsVChpyR5aifrdRLlnunQbLfR4wD7wSIStRQ==
Received: from PH0PR07CA0099.namprd07.prod.outlook.com (2603:10b6:510:4::14)
 by SJ2PR12MB9006.namprd12.prod.outlook.com (2603:10b6:a03:540::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 19 Oct
 2023 10:28:03 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:510:4:cafe::a8) by PH0PR07CA0099.outlook.office365.com
 (2603:10b6:510:4::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24 via Frontend
 Transport; Thu, 19 Oct 2023 10:28:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.20 via Frontend Transport; Thu, 19 Oct 2023 10:28:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 19 Oct
 2023 03:27:47 -0700
Received: from yaviefel.vdiclient.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 19 Oct 2023 03:27:45 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 04/11] mlxsw: cmd: Add CONFIG_PROFILE.{set_, }lag_mode
Date: Thu, 19 Oct 2023 12:27:13 +0200
Message-ID: <1f60d9697693fbf7ab886aeca2dea678178f6e6e.1697710282.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|SJ2PR12MB9006:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e77521c-ac71-4531-517b-08dbd08e1355
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tmOxCQhSOdqspoP2/l9JPJfj4asWoa4G2vXw48Jc2uiMZO2ttSSPogdOqdL+8CzmVmDI7wr83EDFXIde2Ns7ITyeXndN/1dPv2RhcscoQr57g8pJ3FN0cEhYgbyDwV/NR5deurNXswu8f9ZR2i20p60+xN2QYdUt5u7gGD1SzGZ6lotxI1CFqu6D1bjVfOZ1OyiWkBwP/CMq5KRrVPl1GRcla2FarpIPDgNcRWkbR1U5NZq9jdTvpT17cLoCIUiHle6f8iZ23URUHeE5KxV5N9dVF1ZfwArnOYFZxhDwOX42WlXgtToP/10KNehqLgJLFu3T62OupEGTRmD8Hp1XlUgI9Y/im8R9FaCUXf8kMxOF9dzhFWFtNXcWq4bb422IwQZ12Hjng09oPj6+4bSTZBu27ThinD+0rj4exAD+tHgwrq5N2fssb2zC4cu8I3tFFGutHqo9TwDhP87pywAXph7NzMu3afKFsNOyTeMD8iDQIztC/9vQPvO/riF3EsIXQ0ejPlkae46qK7R7le4FfMjdofrHiwlQdvgWPFLBlvR2wWf0Szx4Ps/GjftO9nDH82I1DqFXlFZhVThwHo5Mgbg6exwJ7vd7jwE4NPbOc5rr+6KpHoy0cQ8lMuCmcxBPK3zn22N46nU224HLiDLWDTcJMCXEX/pudH0Is2+XTb3OdyLUrfXrbylo3D/G+f6fSqznLBqF5LGzDvrIqFVUlnFuu/bxqOztpRAVsL54bYtFQ505NzOXQ1/8oTRDlxUZ
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(82310400011)(46966006)(40470700004)(36840700001)(47076005)(26005)(110136005)(2616005)(16526019)(426003)(82740400003)(36860700001)(336012)(40480700001)(70206006)(54906003)(7696005)(36756003)(316002)(83380400001)(7636003)(107886003)(356005)(86362001)(70586007)(478600001)(40460700003)(6666004)(2906002)(5660300002)(8936002)(4326008)(41300700001)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 10:28:02.9942
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e77521c-ac71-4531-517b-08dbd08e1355
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9006

Add CONFIG_PROFILE.lag_mode, which serves for moving responsibility for
placement of the LAG table from FW to SW. Whether lag_mode should be
configured is determined by CONFIG_PROFILE.set_lag_mode, which also add.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/cmd.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/cmd.h b/drivers/net/ethernet/mellanox/mlxsw/cmd.h
index a181ca4b764e..cb6e2a9ef03f 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/cmd.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/cmd.h
@@ -695,6 +695,12 @@ MLXSW_ITEM32(cmd_mbox, config_profile, set_cqe_version, 0x08, 0, 1);
  */
 MLXSW_ITEM32(cmd_mbox, config_profile, set_cqe_time_stamp_type, 0x08, 2, 1);
 
+/* cmd_mbox_config_profile_set_lag_mode
+ * Capability bit. Setting a bit to 1 configures the lag_mode
+ * according to the mailbox contents.
+ */
+MLXSW_ITEM32(cmd_mbox, config_profile, set_lag_mode, 0x08, 7, 1);
+
 /* cmd_mbox_config_profile_max_vepa_channels
  * Maximum number of VEPA channels per port (0 through 16)
  * 0 - multi-channel VEPA is disabled
@@ -840,6 +846,21 @@ MLXSW_ITEM32(cmd_mbox, config_profile, arn, 0x50, 31, 1);
  */
 MLXSW_ITEM32(cmd_mbox, config_profile, ubridge, 0x50, 4, 1);
 
+enum mlxsw_cmd_mbox_config_profile_lag_mode {
+	/* FW manages PGT LAG table */
+	MLXSW_CMD_MBOX_CONFIG_PROFILE_LAG_MODE_FW,
+	/* SW manages PGT LAG table */
+	MLXSW_CMD_MBOX_CONFIG_PROFILE_LAG_MODE_SW,
+};
+
+/* cmd_mbox_config_profile_lag_mode
+ * LAG mode
+ * Configured if set_lag_mode is set
+ * Supported from Spectrum-2 and above.
+ * Supported only when ubridge = 1
+ */
+MLXSW_ITEM32(cmd_mbox, config_profile, lag_mode, 0x50, 3, 1);
+
 /* cmd_mbox_config_kvd_linear_size
  * KVD Linear Size
  * Valid for Spectrum only
-- 
2.41.0


