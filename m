Return-Path: <netdev+bounces-38610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DFE7BBA99
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 16:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F6951C20A26
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 14:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A031F611;
	Fri,  6 Oct 2023 14:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GXCUuWPB"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CD31BDD8
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 14:44:02 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32889A6
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 07:44:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pxx1BmLlb13m9XKP11DZ1/cTP3GfDVjT8SAkdED4msX3AsDxmbSVx0ytQI/AVFFrvH7fUkJRGH3gBinWdkrObQv6GWWPVgWhqmCnC6bHl4joeyqlDpQVKisZHs2bsITl9Q3KIFpjELRcwF939FgFWvo7DqWVvPiVE31UMpcWeR1/8JDcxPEuDAQQIRCBdjAOzQdseGt+l2CPPs/hiOWuOszF6jFckqdYy4Th3qiVv73TD2W3D62PV3+vobEzUd33sgz0aSlMoSRpMGWXuQuyyvJ3YR8xAlFwDlg91Gt2ORmrfDTRrRwy/1pTkq0D+HYBrsesvH/ucN7u4r+zKB1cpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/kaGVmgQNDaFD5X0l9Yw+Vg4cM0k3IG20W8bmCfjlA=;
 b=kTEBGRX+pk6DkvU2O7cwA3AcKm11gx97X1A99TRSXY6fe/4RiCHTUQPB7FoEcuiR1b4AiPp2v1G3LZxHXZUjwGKMLpRpoJDAwjEYjRH+/AJIlYi8BwX/IDv9mjgtWPQMibKo+dH0G0Et3RxcKr6T/5RY58fbGX57a8zp4LqKTpxDl3jCEPv+DQ4JI2UXx4GOwmwmLtZRw0bGoDmhKT1wcXyZQXcdJU8QGP06wORUxJGWBz/yroNZm8SA1LzWpRJUaJQ9U4tyhw2LyoXfIV3YZT25b3RwAYqJjfRi7+4tXPjJHBq3BPPMdny+7OniggXqFkvoJKp4NoJftbM4bg1L0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/kaGVmgQNDaFD5X0l9Yw+Vg4cM0k3IG20W8bmCfjlA=;
 b=GXCUuWPBK2F+Pw6K30ihYv6kmbNrz2Lc2Yh22INW+KTL0BiSZOlI1q62U+A/MO/rIvnTYA9KAzuFVa/he+rNaLLxRmB20PCd6TNtBNKop5VDF+qgYeiXYFnMB9/vfMc2rO2hWZ6IfAjCPFpG7+0ZjzlQLku1odGGzLIVdbWP/TNVisgBwG3u+oWWKtUNAOkIQF1LoHGkEO6ZWdB6gBAZkQRy0WTpqT2I8Akf3l5JZVrtI+pDQ3Qg6AKB2eL2twjz9xHPZnJeSTZ+Yn6CH2lHTxOGH/X4G2Jw0XMZc15ywx6h/DprT/+OpxmReijngy6Io+u928hYDalxiG1xtENECQ==
Received: from DS7PR05CA0022.namprd05.prod.outlook.com (2603:10b6:5:3b9::27)
 by IA1PR12MB8587.namprd12.prod.outlook.com (2603:10b6:208:450::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Fri, 6 Oct
 2023 14:43:57 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:5:3b9:cafe::26) by DS7PR05CA0022.outlook.office365.com
 (2603:10b6:5:3b9::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.29 via Frontend
 Transport; Fri, 6 Oct 2023 14:43:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.20 via Frontend Transport; Fri, 6 Oct 2023 14:43:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 6 Oct 2023
 07:43:45 -0700
Received: from yaviefel.vdiclient.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 6 Oct 2023 07:43:42 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 1/2] mlxsw: core_thermal: Fix -Wformat-truncation warning
Date: Fri, 6 Oct 2023 16:43:16 +0200
Message-ID: <514fb967f6f875fe7d856f4b91c94e4117e2053c.1696600763.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|IA1PR12MB8587:EE_
X-MS-Office365-Filtering-Correlation-Id: 7acc6acf-4a0a-4291-5b87-08dbc67aabe5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kdBdQfhT/bxHI8YdFB7VkgHIo+dThRsGZI472J6GBOe8ktC1lEgvkv5jLJ5wwPv/d8ySkRrdcJqHbAOBe4y4LsCuyC9wDsPyjJ/D9Cc+aPVGPxZ3BW5gxEtyDnDVF/keJvj7z8MaV3SNXskCuE9Efjpqzqoj/KJIIThxQsyCovwixYvJiyW14M6+lnsCgXgH7I+jUYmK0DyC3WfEDAgxezvkPgKHPYiSiE0ZyVYF+TmZPNej/Dgs1gRpBz3l8GkVdT61QF5o1khZKAjxGbPSFoCZ5B/F8kWcrhmnzX76ejpPM85vONqKZeiKZV3m7PB7gs9wDe26RdY/9S1eUGAamdC3/zCohXQuNMq01hDHALMUmimDkD7RBr5mM6SglH+GFRc0UWrHieSDnh6X172DTinflN1Och/6IDTXDF6D2/LFTGIvFPI3ZxrVDpn5DHxiB6ojmIglM7c9muC+8Z5V/Pim920QfMFP3A33qZYQIf0ZueUIPdA2GtfdZU4kcURHDU6Pp8soeiclXl44okMzhTelDFaR9aUglBxFkuHZgY8TA2DJQXekRUjqswnEaGO8EP4dua1cCUonzu1kp5VxgDJVwMLxUWT0GMc+JCIdJfHNpWRzgni1PAKSUO5V65qQr0zbSZmm38sNM5vUpkfwlsHXgTg5kQgtuwatKqN3nN/8mr4Zacf8nmwopzzs/kGWEFLUe8vWLDZrxV7f6Cy9/9Hm+LtgSG/piJYBPV8M0gjFru0zdEfHWLEuh+dgf16t
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(376002)(396003)(136003)(230922051799003)(451199024)(1800799009)(186009)(82310400011)(64100799003)(36840700001)(46966006)(40470700004)(83380400001)(40480700001)(40460700003)(7696005)(6666004)(478600001)(36860700001)(47076005)(86362001)(7636003)(356005)(82740400003)(2906002)(426003)(16526019)(336012)(26005)(107886003)(2616005)(36756003)(54906003)(70206006)(70586007)(5660300002)(110136005)(41300700001)(4326008)(316002)(8936002)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 14:43:57.4364
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7acc6acf-4a0a-4291-5b87-08dbc67aabe5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8587
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Ido Schimmel <idosch@nvidia.com>

The name of a thermal zone device cannot be longer than 19 characters
('THERMAL_NAME_LENGTH - 1'). The format string 'mlxsw-lc%d-gearbox%d'
can exceed this limitation if the maximum number of line cards and the
maximum number of gearboxes on each line card cannot be represented
using a single digit.

This is not the case with current systems nor future ones. Therefore,
increase the size of the result buffer beyond 'THERMAL_NAME_LENGTH' and
suppress the following build warning [1].

If this limitation is ever exceeded, we will know about it since the
thermal core validates the thermal device's name during registration.

[1]
drivers/net/ethernet/mellanox/mlxsw/core_thermal.c: In function ‘mlxsw_thermal_gearboxes_init.constprop’:
drivers/net/ethernet/mellanox/mlxsw/core_thermal.c:543:71: error: ‘%d’ directive output may be truncated writing between 1 and 3 bytes into a region of size between 1 and 3
[-Werror=format-truncation=]
  543 |                 snprintf(tz_name, sizeof(tz_name), "mlxsw-lc%d-gearbox%d",
      |                                                                       ^~
In function ‘mlxsw_thermal_gearbox_tz_init’,
    inlined from ‘mlxsw_thermal_gearboxes_init.constprop’ at drivers/net/ethernet/mellanox/mlxsw/core_thermal.c:611:9:
drivers/net/ethernet/mellanox/mlxsw/core_thermal.c:543:52: note: directive argument in the range [1, 255]
  543 |                 snprintf(tz_name, sizeof(tz_name), "mlxsw-lc%d-gearbox%d",
      |                                                    ^~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/mellanox/mlxsw/core_thermal.c:543:17: note: ‘snprintf’ output between 19 and 23 bytes into a destination of size 20
  543 |                 snprintf(tz_name, sizeof(tz_name), "mlxsw-lc%d-gearbox%d",
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  544 |                          gearbox_tz->slot_index, gearbox_tz->module + 1);
      |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/core_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c b/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
index f709e44c76a8..f1b48d6615f6 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
@@ -536,7 +536,7 @@ mlxsw_thermal_modules_fini(struct mlxsw_thermal *thermal,
 static int
 mlxsw_thermal_gearbox_tz_init(struct mlxsw_thermal_module *gearbox_tz)
 {
-	char tz_name[THERMAL_NAME_LENGTH];
+	char tz_name[40];
 	int ret;
 
 	if (gearbox_tz->slot_index)
-- 
2.41.0


