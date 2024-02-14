Return-Path: <netdev+bounces-71721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAD2854D4F
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 16:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6202B1F29A04
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 15:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D945D8F9;
	Wed, 14 Feb 2024 15:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GUc1u2bR"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4215D917
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 15:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707925778; cv=fail; b=RyDv4i3qgRbdy9/xlKwYajVruXSwDiA1zZ8paFRcyd800UYhcpZPrp4alW+i44awKTBtke8Ns4aEaZTgPWqMFGvnjirXaJ6LFFuyt3q4g195Aqmf86k7jE90zWvKddtAzjJwGOO3sAPM81T6LspbYBQnfSl0CgcS+sOgootNpAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707925778; c=relaxed/simple;
	bh=8x1TB3sGeP/7vUPRPqWKsYe263jxdurxz/iXPKtDmq0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MwVVJbpAImhKOHAmBrRosoN4SZlCPFMrZcdeyExuSm1cJwbIOaixpXzuxbf1vKbP/dHfu3Kxt6gn7iNqNHrjMoEUftAJyuBZh9m06U3f3dBXKZrJEZYTiNJm0RXHiPFkMQA/VJoHZS8SWrLNJ+ihpq3IHRekJzaG3GB7p1EkwDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GUc1u2bR; arc=fail smtp.client-ip=40.107.220.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SzDWj5FaXT0r6/Ef+qxQ/4DjMRrWZPCxbdA+i/KbmgfroE3UcHT4KK2EphIqstNORj17FaZdLlxYLX2lSKDbhppd4FKBqrS0qx+3tAYYJ8yEumQzPWV+78cTmnv5PkgZtqC23SD1KnwUiv4GvhlE5q+WwOcfasJo8/dNwEHLGtWKpGgu8rQqMFgPXjr8D9lX4zgViwgg7d+CG6eEgWHd8zqXQhKSEGK/7joHygOAu37ZBVFE/E4HieSqRe5kY3eIHXFvRGLzx4ReU40lXMgWHuLWGsrWtH/sM5lGTvWvWSGgwUXay332KaJjCq7UxC+PLVYR5dF019liY4B3RhokHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zo2clAxL22uSW2p7XDBoPhzKx0Fpv1wRvalMS9j0grI=;
 b=h/HjONTdmZmPNo9AriSir0YFA8Q4be7WBwbX+P52xluPAIUTi17WXeFmKSa9nFbNI3Qj1odh0LFvY5uq11YnuUGdYZCJ/s1XTVbRmYn9JTDaIhhaul6N+QMTqbGPWeowhw732cqvH5496r60Jbhg13FK/uKeIXdEL2UVkoqIhP6qmm7IjzvNajP8aukRZjuNHQD+F1mH9esI9ut65AwFXvS5jRrmRvYMbmzGjFwgPvKEUmcwRr1PXB/YiO2cP2rcSDY6bkn8614euZTE7YlYEEV5RRuaDyBR2Z6BGx6TYsFVyzIoj2ygzUHj5z4U8pRyBrMXXB1f60+G1L/JsYuELA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zo2clAxL22uSW2p7XDBoPhzKx0Fpv1wRvalMS9j0grI=;
 b=GUc1u2bRHPv+F/wv2fm+VPgjtT4CvY74fQNHepAFFxLC7dt9IIgYhPIYeQHIbPEf1N2xHskLai8eNorCk7hnCS88smrFzsFRNq/G/O3dI82LnHj3i4BwThES+THGcmRrh2Ju3MQvHmwggKUVFBqgjwp3zm/mZJQhTCtEYtoDCJM=
Received: from DS7PR03CA0161.namprd03.prod.outlook.com (2603:10b6:5:3b2::16)
 by IA1PR12MB8494.namprd12.prod.outlook.com (2603:10b6:208:44c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Wed, 14 Feb
 2024 15:49:33 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:5:3b2:cafe::2f) by DS7PR03CA0161.outlook.office365.com
 (2603:10b6:5:3b2::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.40 via Frontend
 Transport; Wed, 14 Feb 2024 15:49:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 14 Feb 2024 15:49:33 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 09:49:30 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <Shyam-sundar.S-k@amd.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH v5 net-next 2/5] amd-xgbe: reorganize the xgbe_pci_probe() code path
Date: Wed, 14 Feb 2024 21:18:39 +0530
Message-ID: <20240214154842.3577628-3-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240214154842.3577628-1-Raju.Rangoju@amd.com>
References: <20240214154842.3577628-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|IA1PR12MB8494:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e1030b9-8951-400c-c464-08dc2d748a17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	T4tIHAzxqP4Drn3thxG1pizIZ40c9stKVbk/Ww3YzNrYzkDAx1iaEZo4N/6F57wvPCV7jmq5qVr5GzXVyN35fN0ICVNRkHF3vBYLKkWuQP8ykBaqe1DO2BTHU6CwXqcMqa+ppAyneEVTzhVB9hsbS/X3WEzAYEbuh4i3prvb4Kb/rAYwiERgMofXXs/Sy0GuPldLGNRDuiIHTLi2EqOXKs7GmEPJn6XG4/8ExrTBo48Q047sr7KvB93H1/liRJPwgmOx/vyajXu74WXLWw6gnDm/04KGYdIbTvgPevcmmDeD5mqqiAxdbBqMZVtBYFQYKLdqU4khkcr64nInC/1Wlou2u+dK+KVm9UqlFIwZsorirWP4CxvpRhcsO1W1PBrDJCovESzzCAG9lUc4NzKMXRDITMupHaBd+HpSNq2tm+99E2i2CdAlmcz/EXpTBvtWHKbdNtiVNJ3caf5RM5fvC4jyWDhyxguPbHg7hhgms35XGQVnrqoL7nQ92+/mF+ARUI7hQnt6Z3EWKOFISbLkFjKgGNhalUpVzQNZrZe1uPR1F1i0GirN6gjGUm07EFseNt7Xah/QJ3MAWf8Ihns8eUUpN9UKsUd2g4z6nihho+E=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(396003)(346002)(230922051799003)(451199024)(186009)(64100799003)(82310400011)(1800799012)(40470700004)(46966006)(36840700001)(2616005)(426003)(8676002)(336012)(26005)(16526019)(36756003)(1076003)(86362001)(2906002)(478600001)(5660300002)(316002)(6916009)(70586007)(4326008)(8936002)(41300700001)(54906003)(70206006)(82740400003)(7696005)(356005)(81166007)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 15:49:33.5099
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e1030b9-8951-400c-c464-08dc2d748a17
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8494

Reorganize the xgbe_pci_probe() code path to convert if/else statements
to switch case to help add future code. This helps code look cleaner.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c | 35 ++++++++++++++----------
 drivers/net/ethernet/amd/xgbe/xgbe.h     |  4 +++
 2 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
index f409d7bd1f1e..18d1cc16c919 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
@@ -274,20 +274,27 @@ static int xgbe_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	/* Set the PCS indirect addressing definition registers */
 	rdev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
-	if (rdev &&
-	    (rdev->vendor == PCI_VENDOR_ID_AMD) && (rdev->device == 0x15d0)) {
-		pdata->xpcs_window_def_reg = PCS_V2_RV_WINDOW_DEF;
-		pdata->xpcs_window_sel_reg = PCS_V2_RV_WINDOW_SELECT;
-	} else if (rdev && (rdev->vendor == PCI_VENDOR_ID_AMD) &&
-		   (rdev->device == 0x14b5)) {
-		pdata->xpcs_window_def_reg = PCS_V2_YC_WINDOW_DEF;
-		pdata->xpcs_window_sel_reg = PCS_V2_YC_WINDOW_SELECT;
-
-		/* Yellow Carp devices do not need cdr workaround */
-		pdata->vdata->an_cdr_workaround = 0;
-
-		/* Yellow Carp devices do not need rrc */
-		pdata->vdata->enable_rrc = 0;
+	if (rdev && rdev->vendor == PCI_VENDOR_ID_AMD) {
+		switch (rdev->device) {
+		case XGBE_RV_PCI_DEVICE_ID:
+			pdata->xpcs_window_def_reg = PCS_V2_RV_WINDOW_DEF;
+			pdata->xpcs_window_sel_reg = PCS_V2_RV_WINDOW_SELECT;
+			break;
+		case XGBE_YC_PCI_DEVICE_ID:
+			pdata->xpcs_window_def_reg = PCS_V2_YC_WINDOW_DEF;
+			pdata->xpcs_window_sel_reg = PCS_V2_YC_WINDOW_SELECT;
+
+			/* Yellow Carp devices do not need cdr workaround */
+			pdata->vdata->an_cdr_workaround = 0;
+
+			/* Yellow Carp devices do not need rrc */
+			pdata->vdata->enable_rrc = 0;
+			break;
+		default:
+			pdata->xpcs_window_def_reg = PCS_V2_WINDOW_DEF;
+			pdata->xpcs_window_sel_reg = PCS_V2_WINDOW_SELECT;
+			break;
+		}
 	} else {
 		pdata->xpcs_window_def_reg = PCS_V2_WINDOW_DEF;
 		pdata->xpcs_window_sel_reg = PCS_V2_WINDOW_SELECT;
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index f01a1e566da6..eda909235d48 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -347,6 +347,10 @@
 		    (_src)->link_modes._sname,		\
 		    __ETHTOOL_LINK_MODE_MASK_NBITS)
 
+/* XGBE PCI device id */
+#define XGBE_RV_PCI_DEVICE_ID	0x15d0
+#define XGBE_YC_PCI_DEVICE_ID	0x14b5
+
 struct xgbe_prv_data;
 
 struct xgbe_packet_data {
-- 
2.34.1


