Return-Path: <netdev+bounces-126114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 220C296FE73
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 01:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D16A8289B76
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 23:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5833D15C12A;
	Fri,  6 Sep 2024 23:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JcIAo96E"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2085.outbound.protection.outlook.com [40.107.95.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B900C15B559
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 23:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725665201; cv=fail; b=HxSS9l6AUxP9orOUCGjepWsPRerYanEYK9M7YJH0neAvpFONJSkhsR5g0L+iv9TPivx+gueZZTt6GMNIb3I2Xe6Un1hR9U3bS1shQJZz9dLzkFbwR+qM7IAqzTpz+TFvLQ0XEISUzz5pUayrQrKpWqt2TqKxxBCNRl76bjAGaZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725665201; c=relaxed/simple;
	bh=xygfFePx6C38dTuDIxq1Ea+gYpmBGE6BYC2sShPAaHw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nv9xyuUdg+/Ud/4D4Njti2No1CUDK733u/M8uxA4CvAGaFQfPlIot35SKkfM6gyi9MLPwhvp7be+Q0rdAHczE1PDgecTcKuRiMRROHSWiwj5TEFAPkQCRSJfFx9wOkM7FXvfWsjqQJKh1O9jhbo+teBwgOWcxOzGiONPuAP6tBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JcIAo96E; arc=fail smtp.client-ip=40.107.95.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hC1mRsIYtenOwDg4p2n4efytkD81DwVPUOL0YslMydt9tuX0tmbdYWtJjGT92s1R/1hJZq6DDKwCBCBQE/41MFQIEtNFPDLe1a2PzxFUf3fHGRu62vu6MRptScwhe6ih9AVW3vVoH4S/Oqqfm2Q9Qu7MHp2Zsa0AcVgtHu16GijkWm/S5D/7E/CBBiC1Ex2oTcj0vvLyCrgqcaZnBqVyjzgsfYPigCFe4fKvR3dkUjqJVvPRbc9noJ5H+iWbHL/gPWSdqcpIUxKk1rZ9IgF8ONCWytCvrgUSBO/T96wwOBGpe8iqNKLzEMIW+2GXpxRuXHJUmQ+70kseZ9GNqlDNwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+eL95GQjVFHwYMPzNnHcgUwc5a3KthXmWL6tGRm1P0=;
 b=WXeIgS0B9VhURiGao4CYE5/Qy0VGw6Qo8dk1UqR5j4DcfHUtdwwH5VvLnFqJNdZChU2rlPjSIvKpzqWh4llgprl6cDaUh92bsb7kqMJN5mV0b7bmXKmVLUxZ4HX4orZIfq73NLCmrP3JIlYVZUw2b8W6mrz22pHBYZoeJKc+EaaD1DbeWSaXE2gJP8jX8AB1Gi4HKpNeS81kp4p7SxY+MqEHQfgSSxX+2EYxAVlCpg2/a+3nGPvtN2JaDMf+UqWIF/u3Ese2zwHgZEHQTf1vgeuSgWx71PYD3JTP0sYj/+WNE6JoZaKsg3rdIUMyAgHBkV8Oe5+mVFwDuW9yZcARLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+eL95GQjVFHwYMPzNnHcgUwc5a3KthXmWL6tGRm1P0=;
 b=JcIAo96EbA5D9dP6AH9YIqiORYYiJWXYrB4IfdSVmwVrTAudXY5j6vkWPYcrm51bi6+jdItwNhLEN3i6N6QopJSL1oTQvqXmhUnq++ekIXdbtWOwqw8B71Aum9UEy3QfZxZqzkfVLSL+7eLyGhXmGNbkPcqJsMoiqjk5i1ZKd8E=
Received: from PH7PR17CA0070.namprd17.prod.outlook.com (2603:10b6:510:325::10)
 by DS0PR12MB7655.namprd12.prod.outlook.com (2603:10b6:8:11e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Fri, 6 Sep
 2024 23:26:36 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:510:325:cafe::cd) by PH7PR17CA0070.outlook.office365.com
 (2603:10b6:510:325::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.20 via Frontend
 Transport; Fri, 6 Sep 2024 23:26:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 6 Sep 2024 23:26:36 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Sep
 2024 18:26:34 -0500
From: Brett Creeley <brett.creeley@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <shannon.nelson@amd.com>, <brett.creeley@amd.com>
Subject: [PATCH v3 net-next 2/7] ionic: rename ionic_xdp_rx_put_bufs
Date: Fri, 6 Sep 2024 16:26:18 -0700
Message-ID: <20240906232623.39651-3-brett.creeley@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240906232623.39651-1-brett.creeley@amd.com>
References: <20240906232623.39651-1-brett.creeley@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|DS0PR12MB7655:EE_
X-MS-Office365-Filtering-Correlation-Id: 74e3fb8d-0c76-4e0b-2730-08dccecb59fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pG7IaVmrm/XoLZ8DrK2ln89520V8ijC40TN6XMgR0hxEhWe/PTI4oPrxIu7f?=
 =?us-ascii?Q?psEcp9na+36mnXaOOKRrl+p26fq6wfVkHN7r1m+2qXueV7FMRFrq8aLiuwQM?=
 =?us-ascii?Q?yO3V+X8YH9ojYUVaa0CujylNEqtbTQ7HCScvoqY8tppnhu8x08zJ0drtzFK6?=
 =?us-ascii?Q?ze694ocGZn7XrLFMLwtr24mRzjhrYuybmj4WzlF+0s89E47SL4cgCmMYpMbt?=
 =?us-ascii?Q?IyxIL5T4GjyhhC5/kc4Kpm3ZOfwP1ukXUMvNPKnuMEn6aiJ525r78BivBGPu?=
 =?us-ascii?Q?8qpGywLey2k0abZQCC4KTNrjpRJbRytetICZfH/GKRYmRrKEBwjzm3Dq91B2?=
 =?us-ascii?Q?9gsZ92igqJjED/Adcx5oYcbQ/D6+j3XraB8WM0/XFcGevpLIm/ViX1x6z6YR?=
 =?us-ascii?Q?QN1fqCYo27FY3c/n0jKIgVGiyJMWubZQQ4R8jWbIu7iKBmFSalBNVtBPkxST?=
 =?us-ascii?Q?x3d+YvCRGP66qiwgcH7oQTCFrSvzNELhB8jgkBxObDpFDfGCl/8u1d4p8vKA?=
 =?us-ascii?Q?txzAceLYu5M7SMEO92A5GhRmloE5ferYe+5GWbUNMTtv46IW39IyRjUMLGji?=
 =?us-ascii?Q?Ddmj8vSspmdxsmic7hEVuKJ0SrykwEW7uP1XJxg7R2frHwM2Q8E5JgJIzGg5?=
 =?us-ascii?Q?mYB+k5CIqWJjSI9CA4rS9gm991tmBpMGASXY3Ln6zwcGXMhs0QS+sQRzdWLd?=
 =?us-ascii?Q?DIHihwgfqbpo3gy5sSG3KdTGbBMxpay9GeLZLzBCryWmlhK8207rhzaYrbUU?=
 =?us-ascii?Q?Fvpyv61P+3NfUZgT3WQl41/3CnAIzTiNhBx1RFvM728QkjwoAyCoS5WXJncM?=
 =?us-ascii?Q?FmQf8Cm97KaeNFrC4WjgSwpiHCOTCtRBUKw50y41nVk0Jnv1l7DaVVkNL3EI?=
 =?us-ascii?Q?epc2F8j+C2k5V3WQJQb0yVjYwhhSjDKGkP2KgNTQ8pnprGW5s/0jPDBrdNhH?=
 =?us-ascii?Q?D1Gl+HCJ4ryg3JA0FPMW8wG0l3PbaV0b5bXl0LgrefwfpeD1pECgNsCIIuFE?=
 =?us-ascii?Q?irDri5BlQ+7660gMArUy18y387IM07v5a+7BepdawZiuf4sTsxNG64vztCo9?=
 =?us-ascii?Q?P2xyUk4N4Y4dwBi7Y1rhRas4fUjOcWF02+TkTd9yinwXp5A0VB5BtAanTU/J?=
 =?us-ascii?Q?Zr53Iol4NtqzsVORl6QsZm6uA6mUuderB2g62pcp9pkI467aOxB6QSZx2ePf?=
 =?us-ascii?Q?ffWRJCjL5MvFI4wjoE6yhPKCg7AsfTO2nlJxc8kBmiGWs60vNuUPTYVLpouy?=
 =?us-ascii?Q?joCv9aKTDZLltR2rrP16cP3St1XIglgAPLPlJx6JTXz6vCIKmEp27mobnzWD?=
 =?us-ascii?Q?34Kt9yEWkmNetGTV2JAmYbTMbJpdFbwvcN6kAaln4qtIMfJpjsaMqCW5umpU?=
 =?us-ascii?Q?MZHSFMt4XK4FPSCwgIatKyORs6g+DHOa1k0qd9FEe375My9YRpvWoDoNeYO6?=
 =?us-ascii?Q?sqx8z8OKF9h4oH4q69LGTTcANCT7/GPU?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 23:26:36.2366
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74e3fb8d-0c76-4e0b-2730-08dccecb59fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7655

From: Shannon Nelson <shannon.nelson@amd.com>

We aren't "putting" buf, we're just unlinking them from our tracking in
order to let the XDP_TX and XDP_REDIRECT tx clean paths take care of the
pages when they are done with them.  This rename clears up the intent.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index ccdc0eefabe4..d62b2b60b133 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -481,9 +481,9 @@ int ionic_xdp_xmit(struct net_device *netdev, int n,
 	return nxmit;
 }
 
-static void ionic_xdp_rx_put_bufs(struct ionic_queue *q,
-				  struct ionic_buf_info *buf_info,
-				  int nbufs)
+static void ionic_xdp_rx_unlink_bufs(struct ionic_queue *q,
+				     struct ionic_buf_info *buf_info,
+				     int nbufs)
 {
 	int i;
 
@@ -600,7 +600,7 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
 			netdev_dbg(netdev, "tx ionic_xdp_post_frame err %d\n", err);
 			goto out_xdp_abort;
 		}
-		ionic_xdp_rx_put_bufs(rxq, buf_info, nbufs);
+		ionic_xdp_rx_unlink_bufs(rxq, buf_info, nbufs);
 		stats->xdp_tx++;
 
 		/* the Tx completion will free the buffers */
@@ -612,7 +612,7 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
 			netdev_dbg(netdev, "xdp_do_redirect err %d\n", err);
 			goto out_xdp_abort;
 		}
-		ionic_xdp_rx_put_bufs(rxq, buf_info, nbufs);
+		ionic_xdp_rx_unlink_bufs(rxq, buf_info, nbufs);
 		rxq->xdp_flush = true;
 		stats->xdp_redirect++;
 		break;
-- 
2.17.1


