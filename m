Return-Path: <netdev+bounces-42561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 965907CF53B
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 12:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C67911C20E99
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 10:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767A31863C;
	Thu, 19 Oct 2023 10:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VG8UKsWo"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B886D199AC
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 10:28:17 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C36129
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 03:28:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBp1tGLl6aSQMxPMdgo7NcOaoGYF5EUPmfeL1v+bEAb9peXewi96Dc8AOwqEbisPyowB24SRuGma9gznvxicit0bKpMfVRk39KLH5t5iQ3Zm5ZqACe1z0IzTT7pJgnM8/RrNcSBjLquan6uWyKyPjZVOiNEF7Ob464M2PD8k/2CajHiDEU1uEgk9hsjZe0+SvlKcuTpHnAxSGDZgfLzFw6UYOidF7JMjcxejezhF18f5ApiZGEs6wgfXE4nAkB1EUdVuzKk0nVFK+H5taJ7JLThAfYj+34cUGt+Y8JG67pdBtdj+KEEk/fBtQuHNlTRiZXu9GbKvA1Q8PqTxZzv9PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A1AeGYaKjeYvwPZDUIbwKGGxRJpNZx95c4zZ5KnkNFU=;
 b=bASsuS7T/uMgwjuZIEXVQv9zA/yTL6ysiA6kVOcz02rdWuBgdOYA9Fna8VfxfwzkvYLjhohzhiWA0krArR21yyBvbn8Ozen6Eky11Wzk0WNNuhjuFRVIoZ9QvG7CTGhmo1Pe+33woj+8Vl1RzhaIJUbt64gEeVSpawV4fdN74gmwxs3SHYUpAnXF5fxe3WjCpf0nkMMb1MMLnntRNzGCQTD23v8QyJaSxTufmifacJzW/1+M/2QZoI6uNnzdLEfJ1+3ObdQ+m4tMv3CiN/I2fnkdvZyIU3oA2QS6IRXKjXKJKg39xB6iZ2/UxXcAHjWhZNmfPvJDYt0LkYAfTezhFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1AeGYaKjeYvwPZDUIbwKGGxRJpNZx95c4zZ5KnkNFU=;
 b=VG8UKsWoYTHfxIrmpKKRmc12r0LSRRVGMMb44kOAoOdgfyw1gg5UYXCwOTkYBwMYBNOD/C75+XIoPvJUHAqCrqUPrt/hUGQoWSNhuLLfgaWyhLqBs9MGrqEPC4P51L7Jpk74WQSy3t6s6GWqwmDHIxbygcCX/M4nG6DDI8osUQ6IpyfScbaeuJpQqXcpBToPvLdhhsrApW3CTxfxJHVkIFIzyB/hbl4vp0Qg8qGFfoGZU9athcy9XcYffQgIDjh98AS8T1V1qhA7Lj6Og/JeHmAcE8Dqn3G7ElthoDUYqSSanHyXNITl2PRZY+/Wd9rCr++OXlOjDdeyoQeeH+Hhfg==
Received: from SA0PR11CA0210.namprd11.prod.outlook.com (2603:10b6:806:1bc::35)
 by BY5PR12MB4212.namprd12.prod.outlook.com (2603:10b6:a03:202::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Thu, 19 Oct
 2023 10:28:06 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:806:1bc:cafe::ef) by SA0PR11CA0210.outlook.office365.com
 (2603:10b6:806:1bc::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23 via Frontend
 Transport; Thu, 19 Oct 2023 10:28:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.20 via Frontend Transport; Thu, 19 Oct 2023 10:28:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 19 Oct
 2023 03:27:50 -0700
Received: from yaviefel.vdiclient.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 19 Oct 2023 03:27:47 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 05/11] mlxsw: cmd: Add QUERY_FW.lag_mode_support
Date: Thu, 19 Oct 2023 12:27:14 +0200
Message-ID: <eebd39ed3733476285bfac41c487c1a428e780ec.1697710282.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|BY5PR12MB4212:EE_
X-MS-Office365-Filtering-Correlation-Id: fba65098-8721-46f9-0824-08dbd08e14c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wPny9KTuMpVx7qqUBoUikjvm/C1gQx3mciMmNx+BaJwkHf8cz4U1ZcbL3yvuGmW3jGuhqTm8xRBnKyViY6l5uARjvuRohmrvk+LbvB8GfP1dj9ZVw3Z8vVQ09kPmuxp7X3RrFNw8RzXWOfIg9XySStf8DNHT5tnrBjuRGhTH5SXG8tfAgIUDtE+I1J7GISTQJHJCVqxVIVZO2WhhRPqGXVRjY1+Sk9XBqsN9QVdlf1wD+5xrHZHpXV0eaIMtqVziFCTpOyaJzKPM4gCvN6+ElmcEOh9fjS5rDIHoG0xPSy3aqSdQju3dzBrkyYS3zGKlZfUKV68BBSNlx84Q5uc5ee/ut/xttidj8MzG1dDxHX0aZY4XQEmLAdxhrYEBd5nHzv2IjZj3xMm6OJGJ5FV0em2JB4WD6JnQ+qxsF2TtCIIvNzkOCFT3DHcuCcvLq/xPudMDKcei84sw9OOc8cx13U31s+2uOnAlyTn/F+hk/16+MNLaIgN+zapjax8YQbnMfh+Xwr0MFExGgHDJ/WJVS4Uobr3yanArVjIO0S9zbOYaXb4t/Qpbb6KzuS9dwW2RxnCKaEWYHgKNw9fDmmdqHW0BRkMnhM74QD6Sz3fwqi25KR+AYFqn1qqIBau+FNufi7WB1oGnyBICkY4vwh+lI1R7mccdY7n57q5noM5TLP70n0YvttqcmFlYJyNrE8WgZObVgRqDJ1RgdaVKVguD/0Kc/yyXYbgTSQztuliLCrNLY5J3j8QAWMqcOciNmwQN
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(82310400011)(186009)(1800799009)(64100799003)(451199024)(36840700001)(40470700004)(46966006)(107886003)(8936002)(316002)(7636003)(26005)(336012)(2616005)(16526019)(426003)(6666004)(7696005)(41300700001)(70206006)(54906003)(4326008)(4744005)(478600001)(5660300002)(70586007)(110136005)(36756003)(86362001)(82740400003)(40480700001)(356005)(40460700003)(36860700001)(47076005)(8676002)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 10:28:05.3713
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fba65098-8721-46f9-0824-08dbd08e14c0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4212

Add QUERY_FW.lag_mode_support, which determines whether
CONFIG_PROFILE.lag_mode is available.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/cmd.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/cmd.h b/drivers/net/ethernet/mellanox/mlxsw/cmd.h
index cb6e2a9ef03f..e827c78be114 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/cmd.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/cmd.h
@@ -276,6 +276,12 @@ MLXSW_ITEM32(cmd_mbox, query_fw, fw_month, 0x14, 8, 8);
  */
 MLXSW_ITEM32(cmd_mbox, query_fw, fw_day, 0x14, 0, 8);
 
+/* cmd_mbox_query_fw_lag_mode_support
+ * 0: CONFIG_PROFILE.lag_mode is not supported by FW
+ * 1: CONFIG_PROFILE.lag_mode is supported by FW
+ */
+MLXSW_ITEM32(cmd_mbox, query_fw, lag_mode_support, 0x18, 1, 1);
+
 /* cmd_mbox_query_fw_clr_int_base_offset
  * Clear Interrupt register's offset from clr_int_bar register
  * in PCI address space.
-- 
2.41.0


