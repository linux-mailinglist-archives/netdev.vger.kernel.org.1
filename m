Return-Path: <netdev+bounces-183046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F38FA8ABEC
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 01:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 974B217BC01
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 23:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5055A2D92E9;
	Tue, 15 Apr 2025 23:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="G4dwv6VU"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2085.outbound.protection.outlook.com [40.107.100.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918AA2D92CB;
	Tue, 15 Apr 2025 23:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744758827; cv=fail; b=LUI9e9mLyibHRqsyqzNdg3e2ldlCMEXpXCIvOt6W059rJT4Fkl2Lswj4bqH8Qbw8XvVDX8TE+DNo1myx+Bk7CZDAy8YQnMdmE4xZKxU83w7XP7mgJy/2GDd6oQPIcFvt8QnkQop6I9x+EJhwpQ6QJR2G0X3T3RL44NKVGGu0qM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744758827; c=relaxed/simple;
	bh=HELZUF/HiqBcwEcZT8oQCIuGkMtSYQWFWcpKMqidgcA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E2CQxm8VG2KR/eT7Wx21qZ52RW1gC4gStkIsN4YTm69miH+7iUqR9duyvKSHG2HSXX4WovP8q+fChs7Xgtrz+WlvQKnFHTBCA3WvP91zCsgL4TCP/XtuMyFcvVhl9EXVqM6AKb6QAMLFabVSnR1P2Oae/mgyHWoCzvcagfwoV1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=G4dwv6VU; arc=fail smtp.client-ip=40.107.100.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pzGmNhmcrwe+++u1Ftj+CW65Ua8KufK/UYInJmzr1daSekKVBFzW1KGrLrsevhnHx7n4yqaUDprNTBWZKbT6I8dEZGyARnHMp2XJGct/Zw2rQoS2LQhYXyF2LY3YVCXdOziQfbH+LWtkBvBTFCdFMrd+0r612ZHKszWyO2auPkJrCYymF9EuBBhuFFvhWqmMEiQpnn8mP2zqaQbPvVycMe/aDr61foqeB9qMRaBSl4IEVnw5FyBkaX1sJnYUpJitCoCIJ4iE+/Dv0+gNWFJyU2hBY+c6el3dW3yThfyFR9FM/0nRSvWeOrPLZMYseYB9OMliJBABABZNiMrJqrS/+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BG+tYFTQ+62KnMAXcMBSSdy3yJGTixXznloeyg0BVaU=;
 b=O0lQ4//qqhA5GrvaZcV2pc05CtAVKkcDO71CiQA92BHPs4eEH7ZwEqHjdlU/TYVJ4WXRNsUyU15VSSPOn4kyo9OyGvzrl17sHnJoZt28rdbvXPnuAOI682Z6z//Cz/c6p4PiCXYw5gLknzsJPHG/hrjmCMlXI6D/NZq6lqTUgKSjlz14KXtOVnmJqCLwd6U3sP2tARmimruT8FXlsBdlCEOdpEzvaYLYdh/Pw2w0qb0PKYiOLyyxX4omWI7lH2UJ7mhF8wFrt/BcmsagKaBw5wmw2rt2XeUUEH4DdzoAAMs3N02mOl6OE2Rwb9aIWDGkdM5Huz1aN4ss2irwS0KGeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BG+tYFTQ+62KnMAXcMBSSdy3yJGTixXznloeyg0BVaU=;
 b=G4dwv6VU3HUL8LfJ753qvpVJgexg742P/T9Em29fJN12zElJQyZeLAEcaIPk3MEeixu7/FXdQMQQBFZDf6LZPqkXzmCMPjmkh391cQFETkjgz/ju1FSuNzfvtxRVyEhmy33GJsVZDzl5xsRHmglraxf+ny7M1dScVXJ0xL80fHA=
Received: from SA0PR11CA0099.namprd11.prod.outlook.com (2603:10b6:806:d1::14)
 by BN7PPF521FFE181.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Tue, 15 Apr
 2025 23:13:40 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:806:d1:cafe::c0) by SA0PR11CA0099.outlook.office365.com
 (2603:10b6:806:d1::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Tue,
 15 Apr 2025 23:13:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 23:13:39 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Apr
 2025 18:13:38 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <brett.creeley@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH v2 net-next 3/3] ionic: add module eeprom channel data to ionic_if and ethtool
Date: Tue, 15 Apr 2025 16:13:16 -0700
Message-ID: <20250415231317.40616-4-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250415231317.40616-1-shannon.nelson@amd.com>
References: <20250415231317.40616-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|BN7PPF521FFE181:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b714306-11d1-4b9b-3eb3-08dd7c732827
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2PlPPLWC+haWKwwN8POgsP/2vB77oCZB2jzFJJVxiEM4H4OQ72Pc732wIGfz?=
 =?us-ascii?Q?iRQSSDL0prb+YBS6PR2E4y5CXbUVK0ISAMH68cOeBHj6oRLJqvj9dsJ2ODr7?=
 =?us-ascii?Q?z9iTx6l2QxRpETFzrpfVkpW4cULE6xQMH/IWQreq6bDNed13/9uPcsU0xPHr?=
 =?us-ascii?Q?RO3eJ0URxdtMwWKz5LKZkqF4VAYfnfeUMwa+waGBeIhby6bWw+oX2QiWzy5b?=
 =?us-ascii?Q?Nl8M2n/MzEj+PACbG38ZKt+84SHHf3N0YGXT+TSwg5r2Lwe4RCGI8sExjHeN?=
 =?us-ascii?Q?UhY+8SVaWnvyuuhA7d5dMwr8sccy3V0vV+mA69UJzc4qzGwyK0hsJm9tTeRS?=
 =?us-ascii?Q?b1rv+lP+zE/961tfigQ0sRanCeEdqAYnaSPcEmJfwaMI/6oPeZYPs/g9503A?=
 =?us-ascii?Q?Cs9Igo2PWobRjMp3g8YNtN+G6s+Hf477Z067rjN/N8JimMNi9DajnzDi/pse?=
 =?us-ascii?Q?MuhaNTdHOMiea80n7eL26/2TbHdY2NmixSPrS+YD9VEb1uLKGCrfY7T3XJed?=
 =?us-ascii?Q?Tt/pL5JUN/aHeA6wYAFHA/eWkZ+EN4JxHCYkv8thEDpOhPLXUCfNbnFLVuI5?=
 =?us-ascii?Q?0UytuY5W0+83hMC1dWhnWSE50HBT5etsL+0bHrH6P2tFXLNQN75CZqNUYmxc?=
 =?us-ascii?Q?vT/zC+IQTh+pGbKMEDJMUXRA+SYgE0h11raw8qP70STSJ2bJAT6fWwrSd9E9?=
 =?us-ascii?Q?oUKkILyStf9/6oLRVcSoXWnIwaNJRA2lgV2vUpT6vg+6a0UBhjngeb4rSRSY?=
 =?us-ascii?Q?Vn7FlmQjCWFVPCFOnHzwqdUme0nT7rkaFjhn2jk6LurOkSpPzYeqiQrCSSRC?=
 =?us-ascii?Q?mLvItLQNB12XF6AiBOVMI9q1DmmLUix6UiVi7m7I59nELwYVBZkRjrYDmzPv?=
 =?us-ascii?Q?/v5jyCtiV+EjCTghG13fbQCwXdhRDwh7dl8cq1bv9+FlRTFZtg7R2hHKHu7t?=
 =?us-ascii?Q?m/rR7X1tuC7wFBEVDmUgY/JpZ3FmuiYz+AlVByfnUE0wVU2+zgPS8MoHDMxb?=
 =?us-ascii?Q?shnZBtuPgQYk1On7g/kPTQuU1oWfIM0JF9/Q201/AyZS1KLJriwS/D2F8Gaf?=
 =?us-ascii?Q?mgiY3YTNKHkXn4SsVCYhLAZj+qs00mnR0eRVjsTje56qDCD4bAFKNlRr459R?=
 =?us-ascii?Q?TtJm6hhGL8UzmFk/8ATK2BsyCHe/bHzNj3WlNYbolJQbsOtk/46CLwZ+yEJW?=
 =?us-ascii?Q?4g+a94bNqsP1eBrEgm5Amb6+J8Ut8wXOwnQrxVcO6amlcZfdtLoJ4gbihdq1?=
 =?us-ascii?Q?ESvDcHidvniAMSzsUuSdPExxYXebFISEzubLdkFnom29abldf+cIZHruD/1y?=
 =?us-ascii?Q?Pyzd/jsqqLcGp8hMxTGRGFPOnMjVtzGcwGGNlZ8wRm0Rv/dPa5B89WmuAv70?=
 =?us-ascii?Q?ZhsU23tEhjZcxyrQR/dFYAJrfNLTXXGuJ+wXzkBaSKrT6KYf3bHefmZbheA/?=
 =?us-ascii?Q?7TIqI780HXfp1lA3W0ITvKwgrqU3o3xe/k0ZDTCzRip5H4CzIx8nmSTClBSd?=
 =?us-ascii?Q?UgG/tfxnB1euyNLH8Od8497zSyWMDDzeJHCp?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 23:13:39.2441
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b714306-11d1-4b9b-3eb3-08dd7c732827
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF521FFE181

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
index 0d2ef808237b..92f30ff2d631 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
@@ -999,6 +999,9 @@ static int ionic_get_module_eeprom_by_page(struct net_device *netdev,
 	case 2:
 		src = &idev->port_info->sprom_page2[page_data->offset - 128];
 		break;
+	case 17:
+		src = &idev->port_info->sprom_page17[page_data->offset - 128];
+		break;
 	default:
 		return -EOPNOTSUPP;
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


