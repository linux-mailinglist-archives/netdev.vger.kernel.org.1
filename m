Return-Path: <netdev+bounces-38611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 803D57BBA9C
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 16:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ADC728276B
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 14:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FA21CAA2;
	Fri,  6 Oct 2023 14:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U02chbh0"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8587A1F922
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 14:44:04 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2069.outbound.protection.outlook.com [40.107.96.69])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA0ECA
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 07:44:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SVyzmqkn5zaClcZGvD89XtiSdaV0d3QEF9CEkKAbckI0h7BK96pztQ7oykU7os18eYjHrN52yiKRBfoC029nsA5+ze26tlbGwWTpwd20XTjtvUafShi0NOlRapIqSgDd+WkBk03kLm3/qW0LtgN48CN3uB0NxwFSAn0PvQQ6Nd8K3Y0JtlHRs3fId0SvuMDoIZv/IvbEhzIZ3rCWiUj7/ukyvY2cjVG+dtOduAZYcM04BaTiko0ObtJrYO1PFqkzhb99wvL7WHv/RbO6FrLT+b1sj+sd+lJBBOIQc4NPX8Ny3d7UJDd1R4mH0tF5Zocg8zoLg+2j3Zr+Do0TSatIFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gSoh0Be9hrDrv4LnkpLlQWjMj+AgKkHHdLG5uR1JpGo=;
 b=Jhr7xHIlaVG91ziWoRFO2inyjbsXfXpLvvZxzF+khEOEzJuag85LeYNGe1XhQDt1y7F/g3OB79m+z1sK3nXKQvw8o6zzP8Z/gZ6O+g+1E8mvxcVu0w4oTRqVg1t7wPh8ZDrS9S8pTOQVoTUrsMmzKeIZaU/TmiPsqttt13gKI0IEphdDBIwuJ6Dd7KABxSYSu+C4Ez7joM4yJjRr4j3pFRZkbHeiDaTFNq+Kk2x0Lip7tttaB9qk4q6bns5UqfP1IlxW02dDaAsLtuC0sjmhC27HMA4zvNodQ282FG61gNnfPc0sDmJQiBEJHb0sUi4a+DHE9oP/gamoz7un9vTHXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gSoh0Be9hrDrv4LnkpLlQWjMj+AgKkHHdLG5uR1JpGo=;
 b=U02chbh0VyqQ4F1LSfdb+EKLhk69ojmfoPDEs95Gp3z/ZPtDmf3fouRlTc9boNYati3PSa5y5GPL5/OK2k2F6FoRgeRUjz6JSzpt0XH9O1gM8Rxt99OwVX8HVNZo1Obx9DpMeKEQAgyit/hRC5GvCFQQUOBMOVBjvSPwK6GEDnujCgyFWQGTYGEurSnRlq0SQknZiEXHpbUVZfL4joylm8VRIhrlLJ370rwwXhcqdNsjHLubqR2Epc1pjFTfzkNulVnDhTkNs8jI2QNgNAK5FHHSEWnrrFaPH2fdhJQwVP7z4FWer/XaXbghidqMsLt3Q3cZHBaETUz9G+ogp19Wqw==
Received: from DS7PR05CA0009.namprd05.prod.outlook.com (2603:10b6:5:3b9::14)
 by PH7PR12MB7116.namprd12.prod.outlook.com (2603:10b6:510:1ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Fri, 6 Oct
 2023 14:44:00 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:5:3b9:cafe::c9) by DS7PR05CA0009.outlook.office365.com
 (2603:10b6:5:3b9::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.29 via Frontend
 Transport; Fri, 6 Oct 2023 14:44:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.20 via Frontend Transport; Fri, 6 Oct 2023 14:44:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 6 Oct 2023
 07:43:47 -0700
Received: from yaviefel.vdiclient.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 6 Oct 2023 07:43:45 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 2/2] mlxsw: spectrum_ethtool: Fix -Wformat-truncation warning
Date: Fri, 6 Oct 2023 16:43:17 +0200
Message-ID: <e7779667560002877280bd0b9d99cc23677ee293.1696600763.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1696600763.git.petrm@nvidia.com>
References: <cover.1696600763.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|PH7PR12MB7116:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a68e4a0-2a8b-4b4d-70d9-08dbc67aad7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2xhx1bf9fWiPo8HcIuLZgIrNdDAaOmlYAFq+b+FyNl/rwgVzdKJIRjWR5j6vdTEm2ZSF7jNy2Ji7JEithy3uLgdWfptPWDiJmradYxtwaRG7vOOsee8t7L/BDLj9F+aGyJZBkNp7eBBv3ym0d/QPrDKl9c7Xe3PFwN85t+21Q8sGN5zf7paxNG/tD3RR/p3Sf4VLKzLeGr4zFvmkApLYpW6h9qCaqQn5ZWZo0CVyZ4KKvGOZXbw+ev0iCM9gcaCRXiqhnE7P6pN0b2fZYD+eXr1EGSbt2GAcWy6VMeoirZBJMVTzqyhMxoRToskx3Nj3m/rSbHzdSlDfc8Y85mGYZdV4ZEvVx1pCD/35ggNyMimvNGwglsFCQR127d/clzyawfV5UpHFwG4Ucm4Iyq6xcboZ8NoinCM7iiVC9IfrIsUKPkAjOao05bWPi/RpoQxDW8cV+vn3QSUvYON/nQUYbZEkxlh3soo5I5Gy0ttvlVAwc4W29ofoYCAemVeVectZEpuos2kfTZ/grW48MZzsHw90Fi0dSiKqcOvDR8+zIeGtKZVf9pniLIH9h/jdKw6Huv1tsQ+TLNfvwJXtrmmS8p81GV7XIACWapanNieGXB2o+g87tpvE/hIt7zxP/mwZ0jU1aT1Y+zARlE1fSzT8GIdvV1vhNBwn1LigkpxSAU1DyZTREIhKnO5Hx77se9vMhopUENZAgH7An1hqW1wtvevVNrWzVmWaqruv7L0OOlFCECLJMgtiXBEBVxI6KdCo
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(396003)(136003)(376002)(230922051799003)(64100799003)(1800799009)(451199024)(82310400011)(186009)(46966006)(36840700001)(40470700004)(26005)(36860700001)(2616005)(107886003)(336012)(426003)(16526019)(82740400003)(356005)(7636003)(83380400001)(36756003)(86362001)(47076005)(6666004)(7696005)(54906003)(70206006)(478600001)(70586007)(8676002)(110136005)(316002)(5660300002)(4326008)(8936002)(2906002)(40460700003)(40480700001)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 14:44:00.1239
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a68e4a0-2a8b-4b4d-70d9-08dbc67aad7f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7116
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Ido Schimmel <idosch@nvidia.com>

Ethtool stats strings cannot be longer than 32 characters
('ETH_GSTRING_LEN'), including the terminating null byte. The format
string '%.29s_%.1d' can exceed this limitation if the per-TC counter
name exceeds 28 characters. Together with the underscore, the two digits
of the TC (bounded at 16) and the terminating null byte, more than 32
characters will be used.

Fix this by bounding the counter name at 28 characters which suppresses
the following build warning [1]. This does not affect ethtool output
since the longest counter name does not exceed this limitation.

[1]
drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c: In function ‘mlxsw_sp_port_get_strings’:
drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c:622:58: error: ‘snprintf’ output may be truncated before the last format character [-Werror=format-truncation=]
  622 |                 snprintf(*p, ETH_GSTRING_LEN, "%.29s_%.1d",
      |                                                          ^
In function ‘mlxsw_sp_port_get_tc_strings’,
    inlined from ‘mlxsw_sp_port_get_strings’ at drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c:677:4:
drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c:622:17: note: ‘snprintf’ output between 3 and 33 bytes into a destination of size 32
  622 |                 snprintf(*p, ETH_GSTRING_LEN, "%.29s_%.1d",
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  623 |                          mlxsw_sp_port_hw_tc_stats[i].str, tc);
      |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c: In function ‘mlxsw_sp_port_get_strings’:
drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c:622:58: error: ‘snprintf’ output may be truncated before the last format character [-Werror=format-truncation=]
  622 |                 snprintf(*p, ETH_GSTRING_LEN, "%.29s_%.1d",
      |                                                          ^
In function ‘mlxsw_sp_port_get_tc_strings’,
    inlined from ‘mlxsw_sp_port_get_strings’ at drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c:677:4:
drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c:622:17: note: ‘snprintf’ output between 3 and 33 bytes into a destination of size 32
  622 |                 snprintf(*p, ETH_GSTRING_LEN, "%.29s_%.1d",
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  623 |                          mlxsw_sp_port_hw_tc_stats[i].str, tc);
      |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c
index 472830d07ac1..0f29e9c19411 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ethtool.c
@@ -619,7 +619,7 @@ static void mlxsw_sp_port_get_tc_strings(u8 **p, int tc)
 	int i;
 
 	for (i = 0; i < MLXSW_SP_PORT_HW_TC_STATS_LEN; i++) {
-		snprintf(*p, ETH_GSTRING_LEN, "%.29s_%.1d",
+		snprintf(*p, ETH_GSTRING_LEN, "%.28s_%d",
 			 mlxsw_sp_port_hw_tc_stats[i].str, tc);
 		*p += ETH_GSTRING_LEN;
 	}
-- 
2.41.0


