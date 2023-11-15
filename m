Return-Path: <netdev+bounces-47978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA1D7EC21A
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 13:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8598281588
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 12:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D4D1A5BA;
	Wed, 15 Nov 2023 12:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oTt8NwOm"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544711A5A3
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 12:20:09 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDC611D
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 04:20:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IeGTt/gr+F5k5IV1nFddeT1zdlGKf5PViQyVOMcYnzJQPNav5quJ95TLdX34gCGpCHP2eGaz4C1wb8dfUAxlvN6aukJmGDHjGtsrICQkyVVN6fknWjWjeD3y0t8/ZUcCIwFG8NAiChnu8pm1cubSOVCutdY+oZy0u66veGZPl58MyHlZtmJtxz0QHLVfX3vwX2AGTq4RdFFUw0eDQFJ02Yf8GBBUgKpgXiTonkbrcOiuqiiAHy36hQhA8OiQE6vTpH5ScG9VdcJY2RFFzgla+EQBjWT+r/HBmpN+IWF+uhex9G6sxnHWajl8GbaGajEVSEasnUw1coIqa0HiiRgJkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oZDBsOs053nfj7VFMTzqGyyvhd66R/kr8YbTB/Xw8Ow=;
 b=mnvasamUhGofg5aE/5/m8m8FL/sWyjSg/uxGuKINjAjZCwQ1eGK1Oc3r/Buf04oKNCJjh+0SBeFaaIVU4DAzkk+wmWJlmzS+EnDf1XOISmc/vaFFkkUdV/oIxfrh9mcEb00ihgsTmEdAJAnjv0a0EByQR0t/rR83p9j+DzwqshAqt6XLFMa58mUBfMkTWcAVmhHvE04tqws9FWYrhUNqTSbqMCuu8XyE5NRcBHXkDfKrau0LwvnjxEFI4KXPccvD10wNuEUUzwzX6inEclsHBkxM5XYrRuFIqAtBq6Ogy3vc2MplM3aMqYZbAYZU3LNHKfx8LhESpAl56rfp5hWSVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZDBsOs053nfj7VFMTzqGyyvhd66R/kr8YbTB/Xw8Ow=;
 b=oTt8NwOmw0CVfuw6zIyPZl3YIn8V+dWwF3k+GVOsF8wFIHuI9lJR/P4KL1DahcohGAUTuEMgGO6jSHwevA21N0X9w0PvY0FAcE0/7diRc3K5/7LCBHxnilWrh3i5aucSHELRAfqId9vV/wmWkSJhPqAqYmYwVCtZdY5R+izYnXHftvfUsa9HDQRan5tL4TN3bUs8o2YwvOnbg8bNzUs7YNvrvQJK5fx6iz16Vcd0M9SbGbLnA5WDE+zfqdeGFYr4QaMYstf2560qlxF782uu+ga2YUeH0BIlw1xM2Gp6MTqav74WYjND5j5UNuPQrApXsa9pdupZ1OQmRWayM30bUw==
Received: from BL1PR13CA0419.namprd13.prod.outlook.com (2603:10b6:208:2c2::34)
 by CY5PR12MB6058.namprd12.prod.outlook.com (2603:10b6:930:2d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.36; Wed, 15 Nov
 2023 12:20:05 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:2c2:cafe::bf) by BL1PR13CA0419.outlook.office365.com
 (2603:10b6:208:2c2::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17 via Frontend
 Transport; Wed, 15 Nov 2023 12:20:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.20 via Frontend Transport; Wed, 15 Nov 2023 12:20:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 15 Nov
 2023 04:19:50 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 15 Nov
 2023 04:19:47 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 09/14] mlxsw: Extend MRSR pack() function to support new commands
Date: Wed, 15 Nov 2023 13:17:18 +0100
Message-ID: <07ddefc8ba97f401402ba2e43a7d37677b26cc16.1700047319.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1700047319.git.petrm@nvidia.com>
References: <cover.1700047319.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|CY5PR12MB6058:EE_
X-MS-Office365-Filtering-Correlation-Id: aee02fe4-c16a-4ee2-1f62-08dbe5d532e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4XO97t7LOuQb0pxuq1M9AmhRuiFCCzwM30qFM3quOGDdv84I/1/FvUCbVLbNpf07Djab4j5Yj09Mszy4xha4g9vMk2BQmcXQ4IJR8tBIXOBnJp76OCdRgvVYqmWzOi7nhIvyQ8CE2sPmZmwx0jfmy8UG9eC00Le0QgV8V9J3TBpRo6d7PQVLCddHrFnKBBwmlpTjAvIPciAbVrC3Jf1MGApKbKjUWi0iaxfxI0sYWpHYe1AbrWwrYpPTAUEEKy8orcOzCqilG27ufZ9iMM5MSsXJObCW7+ZT+7FCucWyFso2TVTq8+7J4z+f1qzqM04c/H1Dx+SbIxXYyYb68BdWLjoKB+jivUCiy4HMq15ig8HzNL33fLL3YgKrNu2VjqTQwrxv4BxUkK4u4Z7TIuBnHSHZJok3WyTmgJ4YPPsu6lHtEOeDHxVsY4/+qh39b94BI/n9s3HOAttjZLgsZ3xtL70bgi3RWem5gbiE8rsklXl1FtSEJJR6ZO8AzJxQ1HbVuOTdrleWNCjvlBflSHAu+x3HRZTTynNSVWPyf/ih4OcUIgbpi8YQwGyqnqKMDrUQsIlvgLzF7RSC5cw8roGb4EuQaIOBoEAKZM51BK4aReptBrAsY7JqiBh58WVq6K+g+e9FWNTY8aXf8d6acfqAQZnNYhbgoZwLSOSBXJI0oB2WvSMQ+BkjWKyudy+BwKIhfYFXwBHT8BHlwT1pg8cnyF3k0JNX88Y0lpQJmk/tK0c=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(39860400002)(346002)(230922051799003)(64100799003)(186009)(1800799009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(47076005)(36860700001)(36756003)(5660300002)(8676002)(41300700001)(336012)(83380400001)(426003)(82740400003)(356005)(7636003)(40480700001)(2616005)(16526019)(26005)(6666004)(40460700003)(86362001)(107886003)(54906003)(70206006)(70586007)(4326008)(2906002)(478600001)(8936002)(110136005)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 12:20:04.5853
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aee02fe4-c16a-4ee2-1f62-08dbe5d532e5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6058

From: Amit Cohen <amcohen@nvidia.com>

Currently mlxsw_reg_mrsr_pack() always sets 'command=1'. As preparation for
support of new reset flow, pass the command as an argument to the
function and add an enum for this field.

For now, always pass 'command=1' to the pack() function.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/pci.c |  2 +-
 drivers/net/ethernet/mellanox/mlxsw/reg.h | 14 ++++++++++++--
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index e4b25e187467..7af37f78ed1a 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -1491,7 +1491,7 @@ static int mlxsw_pci_sw_reset(struct mlxsw_pci *mlxsw_pci,
 		return err;
 	}
 
-	mlxsw_reg_mrsr_pack(mrsr_pl);
+	mlxsw_reg_mrsr_pack(mrsr_pl, MLXSW_REG_MRSR_COMMAND_SOFTWARE_RESET);
 	err = mlxsw_reg_write(mlxsw_pci->core, MLXSW_REG(mrsr), mrsr_pl);
 	if (err)
 		return err;
diff --git a/drivers/net/ethernet/mellanox/mlxsw/reg.h b/drivers/net/ethernet/mellanox/mlxsw/reg.h
index 25b294fdeb3d..13c0ff994537 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/reg.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/reg.h
@@ -10122,6 +10122,15 @@ mlxsw_reg_mgir_unpack(char *payload, u32 *hw_rev, char *fw_info_psid,
 
 MLXSW_REG_DEFINE(mrsr, MLXSW_REG_MRSR_ID, MLXSW_REG_MRSR_LEN);
 
+enum mlxsw_reg_mrsr_command {
+	/* Switch soft reset, does not reset PCI firmware. */
+	MLXSW_REG_MRSR_COMMAND_SOFTWARE_RESET = 1,
+	/* Reset will be done when PCI link will be disabled.
+	 * This command will reset PCI firmware also.
+	 */
+	MLXSW_REG_MRSR_COMMAND_RESET_AT_PCI_DISABLE = 6,
+};
+
 /* reg_mrsr_command
  * Reset/shutdown command
  * 0 - do nothing
@@ -10130,10 +10139,11 @@ MLXSW_REG_DEFINE(mrsr, MLXSW_REG_MRSR_ID, MLXSW_REG_MRSR_LEN);
  */
 MLXSW_ITEM32(reg, mrsr, command, 0x00, 0, 4);
 
-static inline void mlxsw_reg_mrsr_pack(char *payload)
+static inline void mlxsw_reg_mrsr_pack(char *payload,
+				       enum mlxsw_reg_mrsr_command command)
 {
 	MLXSW_REG_ZERO(mrsr, payload);
-	mlxsw_reg_mrsr_command_set(payload, 1);
+	mlxsw_reg_mrsr_command_set(payload, command);
 }
 
 /* MLCR - Management LED Control Register
-- 
2.41.0


