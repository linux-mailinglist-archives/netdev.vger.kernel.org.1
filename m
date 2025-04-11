Return-Path: <netdev+bounces-181748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59055A8656A
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 20:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B93A29A75A5
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 18:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D544025C702;
	Fri, 11 Apr 2025 18:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kOxaV7hA"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B76425A34F;
	Fri, 11 Apr 2025 18:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744395729; cv=fail; b=CmBlRcZM/3Dkcfu7ue9w5ZKAuOwZ2hz/PDTA7I1iN8qRn/4I8N53Bmld73Yqa4REtRl+jYOebAo+0UMlL/YU98g3l+VtDsEC4pB2Pm1wHgBrxYc1AxZSV+iApwOARzIAmWJzgiJidPhItupPGcKS6CUZQH7ifE9lSm/jEND8mY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744395729; c=relaxed/simple;
	bh=MyEQr0pqNroTIuiiVHylHmJz8gNp9nghrUJuP6YbpWI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hUyjqUgyjMFsRqfz0mLgE3/izIA9r9cb6Dvegxcwj3VWL/RLBCEw53RjPbEAHuQGb7Hdp16uMqc3jl657+MqlhEPuqTEb2ldl36IuOaq4tNFJcE8PhmhDeAnWdMjA3v65Kr1RPK+3CDs0gHZbr8K4B97YX6uRgGo79rBS/bxYw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kOxaV7hA; arc=fail smtp.client-ip=40.107.94.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CuaAjIc8JB9k8zVCxDT0sTyZnTEnjazE/+PKo1GMiZJy+bqwSumNR+r/WS/qplY0q7hJRIA++/2+7X3I9kBd6Jh+0d5aWpHtbJvyVgh6sXnh//ifahAngQX3j8xv/7fvIh7BsWvyC/QoEOSxtUriuSXUvmF7RGmK+lb2Wr0LF2Juqy2fkKkgFRi/byjxz37nnPWfMQzTCj3EvoojkwOMkwT7wWgKTc/DfpqM1m48wgB9m7s4P823LRwymHyWH6BsbG4c8W9Yh+5ODE7z+v/QlvD7Cd+Q7Ed4qJ2ZFRAIjpPqGE+AEQBp981j8yhmoPaG+SGF2ZvzxYvlM1emehWjSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ff/w18+f1OseMFSch/LRK3Va+WXFnn0aguc/A3dbxmM=;
 b=EQNnRAQapkC/CMJcuwF09pxQVLHcucVR15Wg8IwFF4OouEr4j1m4RtV04CZ8HuC0cprQ2rmtlal2lqfIVmuWyoJstAnT/lgYO0auG5d9li7zGjCtSS+6HegLH73jb/9R+aGl939F215yXOBvZaQRgRPoDBNNoIdAKpAjnrK9tJudUus0Yp9+dHdmhL5tNq5ID4IwBcei+seTmymMDOrvfj+yWz+azDMSsaTHcJAPQFh/n2FpG26chjVYUMp3UxiGTrMOoj+k00ASzsU9NphDqaqkLRUQuSsgru3nsD2kQntSnAyt3cfhgcS6M6UYzGe5+EaauNCq5HEznc0Y9lksPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ff/w18+f1OseMFSch/LRK3Va+WXFnn0aguc/A3dbxmM=;
 b=kOxaV7hAEdnDkS8hMniP/ArX5D9ksRoXpFnWm3VPhiuROpnGS2Xtvl1X0DLOoFF/9ndyy5CuDOXc7WoIignBS6nMivx0FbdFOp/VFvOMgzpApDtaVmjVamcfg9wu6MKaIcg/7NvapiEkaAZmlavlA+IGkP/AiMLeIA3KD99mRVM=
Received: from DS7P222CA0028.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::21) by
 SA1PR12MB8117.namprd12.prod.outlook.com (2603:10b6:806:334::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 18:22:04 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:8:2e:cafe::a8) by DS7P222CA0028.outlook.office365.com
 (2603:10b6:8:2e::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Fri,
 11 Apr 2025 18:22:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 11 Apr 2025 18:22:04 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Apr
 2025 13:22:00 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <brett.creeley@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH net-next 3/3] ionic: add module eeprom channel data to ionic_if and ethtool
Date: Fri, 11 Apr 2025 11:21:40 -0700
Message-ID: <20250411182140.63158-4-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250411182140.63158-1-shannon.nelson@amd.com>
References: <20250411182140.63158-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|SA1PR12MB8117:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e5b43f3-926f-4cc7-c3d7-08dd7925c28b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BGUJ/6roLzch/b41PAYfIXQME8avxkwDDWxNBKSRn41I3627MPQo1av6yuRd?=
 =?us-ascii?Q?v3leGnrrfMx0yiJRNrCrzWnmZjrs3IGEu3Dr02Le6PxgHMAE97gWR2oE6rm4?=
 =?us-ascii?Q?rhnvvZ+xoSnQYx0SvnitjCZ/5FT+T0ONF1YNTNsF3LNV/5GLY11UgXn5E3YW?=
 =?us-ascii?Q?yMfWqwMCiCjdv50wWkT6JV74Kd+1O7BALeLcCDwi/KZNV7gB3xTknRgkVufX?=
 =?us-ascii?Q?ClJYQdsnNeG4ddUP8WgsjbXvFHATnKBxqvUmUy9FY3WJp9dYkphSlklWWb0f?=
 =?us-ascii?Q?iOP6puGs6bHU4afsy5d5ujpR8WVvxx787kxNUOKKfq4SS1qZtI6Qnxin++JI?=
 =?us-ascii?Q?/udxJxpzPkqtpyDj/bZqC/6kHnN8+sq/qt32vLnvpq9l1ts6UG8+xRGj0HdZ?=
 =?us-ascii?Q?Cfvb8MSjIOYwXNUlpZ+pAcX23igSkqqtvTsDMOwHo3EK3380bvtiDS5PoJHe?=
 =?us-ascii?Q?9sdsH8ZPHLRaAJHiA/2TYlUCro1jj+zonKgg3YvlZDkX1T/ClFLq5ue03IYg?=
 =?us-ascii?Q?tI94FdBRaQm+D45+UA99dNlf90TSWOR98gxttPDPaqEe4VBZU4MWIlz46hnI?=
 =?us-ascii?Q?PGsFLbgslBvPGkxIRfS0HoxkS76/sOeoo72Y2vfS4bjyO3qkFomXhztgW7NF?=
 =?us-ascii?Q?UHt/AhKDm5xG5qxvrHyEAdc/OxDW+KW67TrvKPxLlxVmzWww91nzT/LBc6u5?=
 =?us-ascii?Q?msOtuWSJ1H8uWAbdMmlVapKgWa3igdrKIxqTLsHQn4R63BdYf4rZTrlEOycl?=
 =?us-ascii?Q?R9n7BLpWSQ8blZFauTvN34tLNK4SsimvkWTBb3r00I01+u6zFbXWudKycZ/m?=
 =?us-ascii?Q?YVhc8pCKK4wSLiLThDan0pJs2pl/A6pBgVLw7N2stzGvLFz3+x0gmmHwJzso?=
 =?us-ascii?Q?Ru6bqG3g01CVjx5bFU0L+ZZTZ077BgGhgtc/nJAYnQyG4ef+bqxP7qtMjFnH?=
 =?us-ascii?Q?Jgr8BNn37l3Ou5psX8qFtwD9HWyuT1XOOsCEBMWKooFTVVqeQ6Vv9qGSjwsq?=
 =?us-ascii?Q?uKkfj1tKWKpt32AaQraTNFmpDlRnKu4PRtTCfUO3qHmnEqgmCT4+Jtl0xXff?=
 =?us-ascii?Q?mrjF7jGeOyd++qZMgwQDe56sqBhba6/f5Lpt/JR/MlXXv1/nXDb5UWGLZQG1?=
 =?us-ascii?Q?FW4Qm9qfZm3N/1u63eJiz5iwwMSBpeSSo2VqXtNMbPbCRsMmUNCfAqUVOVvS?=
 =?us-ascii?Q?EWDgxIT8C4ZaatLCOvquLMTtlZvAaORcARcJL5Ct62gQ2io7uEf8dRed7Xbx?=
 =?us-ascii?Q?vVjhfMOKfX6HqWwjcmNBt66lknofIX8rfAeBj4RzXLisdVaRn6424Ur5r3j0?=
 =?us-ascii?Q?z++bJVUcunrrd7xfN1Zr4U1UzNKdUQ5PAVYdY+SOkLo8IrMcKMaNNUnMQLDm?=
 =?us-ascii?Q?C85LF2dCXmJwFKSIFFe04e025B64atGOI4dDqSHZB3dEXDNgG6liKtcjfo9u?=
 =?us-ascii?Q?mVlmdi7b1bphA41XgFlqSlkGU6cFslfzCH9eJP7dY6HHzv8ZxMyCwv38iaCA?=
 =?us-ascii?Q?NUXmfOqzLZPMgQsT7OQRyltKWrBDx0wB6Ll7?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 18:22:04.0231
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e5b43f3-926f-4cc7-c3d7-08dd7925c28b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8117

Make the CMIS module type's page 17 channel data available for
ethtool to request.  As done previously, carve space for this
data from the port_info reserved space.

In the future, if additional pages are needed, a new firmware
AdminQ command will be added for accessing random pages.

Reviewed-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_ethtool.c | 3 +++
 drivers/net/ethernet/pensando/ionic/ionic_if.h      | 6 ++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
index 25dca4b36bcf..66685cfb3571 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
@@ -1089,6 +1089,9 @@ static int ionic_get_module_eeprom_by_page(struct net_device *netdev,
 	case 2:
 		src = &idev->port_info->sprom_page2[page_data->offset - 128];
 		break;
+	case 17:
+		src = &idev->port_info->sprom_page17[page_data->offset - 128];
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_if.h b/drivers/net/ethernet/pensando/ionic/ionic_if.h
index 23218208b711..f1ddbe9994a3 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_if.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_if.h
@@ -2842,6 +2842,7 @@ union ionic_port_identity {
  * @sprom_epage:     Extended Transceiver sprom
  * @sprom_page1:     Extended Transceiver sprom, page 1
  * @sprom_page2:     Extended Transceiver sprom, page 2
+ * @sprom_page17:    Extended Transceiver sprom, page 17
  * @rsvd:            reserved byte(s)
  * @pb_stats:        uplink pb drop stats
  */
@@ -2853,13 +2854,14 @@ struct ionic_port_info {
 		struct ionic_mgmt_port_stats mgmt_stats;
 	};
 	union {
-		u8     sprom_epage[256];
+		u8     sprom_epage[384];
 		struct {
 			u8 sprom_page1[128];
 			u8 sprom_page2[128];
+			u8 sprom_page17[128];
 		};
 	};
-	u8     rsvd[504];
+	u8     rsvd[376];
 
 	/* pb_stats must start at 2k offset */
 	struct ionic_port_pb_stats  pb_stats;
-- 
2.17.1


