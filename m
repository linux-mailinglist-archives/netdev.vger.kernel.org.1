Return-Path: <netdev+bounces-151520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7689EFE4F
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 22:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A74518891BF
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 21:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE3A1D89FA;
	Thu, 12 Dec 2024 21:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hXQ5dR5D"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93BB1DACB8
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 21:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734039151; cv=fail; b=gb2H+p6/qx9rbJpMapBPSRWII7kQo1ixXRqF9WcwKvt7+FsKm8mi030JPQ/ytsvqcoKNzICVFE7eT7+/Sx4wgSI5hRadG6gVIy8tKiLCqprA/Tfjia8SKPLmcDJ8x6xDyiXlaUfGVBzd24/9PvxOxQv/KbhwkbeosRDd01W/fWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734039151; c=relaxed/simple;
	bh=DPNIGcAc+3LhRDqfYIZUcTgC2YHkvIDjg21iJQ72TPc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HMuGkR7LMzsKcpAcoB/nG/zv+mcQSGtJeo9v+YijaK/2/4wgqIvn4ffnL/EjkhtqtBGNdblk4af2NOzlmQJCU6eYsXk2Js6thIGS6itEOe+q5+B7xRCNkrOoAkjgUDHtbedUNPUgKD/VYtNZC1l5HDHSiJNNd2uCI1XkQ6XRdW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hXQ5dR5D; arc=fail smtp.client-ip=40.107.223.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DqzVhDjqJGg1jOyccFfJk5NxBQe31pFAY1u/X6WUhXpb3puzJGrdQePSzZensc5cg2cJOlUHLFyLhiDUZqc+XzL2rPcph3J14RNSYn9sEzHR8szSGIH1ZgerXpN3fjeZkH+kivdXiLLkjRcjQJdg7xgBKEp0d/EfiJ7hlq5YKNFuuM30WUS9eKEgLnA/rvrtzebdH7O7DD+8YWK1MONslwo6TbjnyaHhmkANUPimj1g7xZ5XIUAadfXJ9OwoFMuwUM6rdRWLlbO/JKtHE3GdpmMsUpISNxEsSSidZ+3icM1SKiqDDEwPf3S8YgAM/Ye+T3m3l/3z5RNEHC9tALFP8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X3RMp/Vwl9TWyV0qH2rvA43NfPkKob0EAqsDD3EzHsI=;
 b=mRkwvTrD6micYP4xvs5dmEqSiYh7ZvC0PgUWT3xSSsU7qz/sCX6QUEaYDCaopeSdKUj9RB0sFdo3lF/qn3l5uZE/D3KbINCXZqmeFOxZkEXLPyu1FWcivIhgjXxTMRHi9N8CGW5G/qa4Tvu+EdxPpMRaKMGpEyeQKmIjgivHdQMZrbizdlyB/ZTMYeYLM+quAyG9VBCKnq8aqTHjlvDiqCokiy4nV9M4p1fxz6SpdGywYKY3jj+DODv1qr3QlNnlR3uFOghClKihg1y5DNs0DyIJk+IugIEp8x4NdzMIW2eT9c04qveWuMV0KrGnbofwlsg1IhnJm1z7bNU5oNZVoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3RMp/Vwl9TWyV0qH2rvA43NfPkKob0EAqsDD3EzHsI=;
 b=hXQ5dR5DTFVlpgeoFaQpndEhDQa0/zZiWFc9//wEjPWPgbkJiht2YkJBKg5viaKassxr+YSsORGYG4MBxxa08caebARbehYIR3fCCNJ6t2UKlrPF8osf4q+NYZ/NDgF5CNGxewQVlRoNd+jAX0vuY/sO17eDPVjNegeksjHS7ik=
Received: from MW2PR2101CA0025.namprd21.prod.outlook.com (2603:10b6:302:1::38)
 by PH0PR12MB7010.namprd12.prod.outlook.com (2603:10b6:510:21c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Thu, 12 Dec
 2024 21:32:21 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:302:1:cafe::15) by MW2PR2101CA0025.outlook.office365.com
 (2603:10b6:302:1::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.6 via Frontend Transport; Thu,
 12 Dec 2024 21:32:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 21:32:20 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Dec
 2024 15:32:18 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<jacob.e.keller@intel.com>
CC: <brett.creeley@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH v2 net 2/3] ionic: no double destroy workqueue
Date: Thu, 12 Dec 2024 13:31:56 -0800
Message-ID: <20241212213157.12212-3-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241212213157.12212-1-shannon.nelson@amd.com>
References: <20241212213157.12212-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|PH0PR12MB7010:EE_
X-MS-Office365-Filtering-Correlation-Id: 615c7c59-68a3-4e89-20a7-08dd1af475db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o+d3U+8vStd/xMbvjp1qmci8pxjJPQ2KthE2m+MlXjrgTqyCK+ssM6DA6LFg?=
 =?us-ascii?Q?5qSEjp3EsWs3eEKeA6nQ50cZebTOA3evTHJiAVF9oHVghdR2Mz1E4uCPQ7sR?=
 =?us-ascii?Q?fWaA5zP7BRrJE2ml6VliOQB5k3yk9JxMzLURw/X5s23bVxxJe2zbovJSvxoC?=
 =?us-ascii?Q?Z8d3NJlKudvux7mN1Rwn7qcc+bRGhhlX8K5+8DeD9kHciEK5bXnS9K7vMTlt?=
 =?us-ascii?Q?OMq7BQNQEJg1t69qbqGtONRcnUZRgs98gfRhKcWh7Xbm3Ypq1x4G3qjSFrdy?=
 =?us-ascii?Q?euIMnhAXvVWbPY5NiORqndCPVMgQv4F/wf0w/8k6CPTcJm3pDlMEcI+Mv6jy?=
 =?us-ascii?Q?MsqbT6ifBKUwpRB9snSPsQJwDj4tdJ6DYjugcEURdJ0y1Q1AYkRclEXRG/KY?=
 =?us-ascii?Q?A0RzkERnoNmfysuCfNWIrOnC7WVwLZTRknqKI1UicNpJUU0lBiWjs/ZzOxNz?=
 =?us-ascii?Q?NL3mPbjFUJkqgrpxHlZiui7jFRUf0a/uV3F/e0CuqX2wKms89TAx3jnZlHwV?=
 =?us-ascii?Q?2YGN44RHiauXpauIndSR3EyJ+KNV4erSLkeH2JNesmQakfTo4VusopQ/jIG8?=
 =?us-ascii?Q?A7l8+i070C/VQ8koE8j0U0a3N/R7+x3KcCiJd37asLg9Qer/Zb5A8pIQFs0n?=
 =?us-ascii?Q?2sMx+pppr6aba7ME3GZLC3nNKL+Ad+OITA+gisW8I8I/2EGGggI4Ud3+jewv?=
 =?us-ascii?Q?bOgjSNcuyxVJ2HMxXHxmzTYaCLYHoa7zPP/nKDqQJ2wdz0citUsBBXvIaw91?=
 =?us-ascii?Q?KVR242mDEutMXyaV1i7DmXt5y/ac6aeQpQl2pHLSWvVuqjIQV7w+5+LXjdhn?=
 =?us-ascii?Q?9iOAAspNkqpImsp9ZGaDtpJokw32WvTpL6wnHgdpTm3BBdnGAgH2lT7h04UQ?=
 =?us-ascii?Q?IynZoL3javc4Cvo2kTFuCGQN3AC/zW9rTL+laCxtU8feIW0cw8NySMipfxZ6?=
 =?us-ascii?Q?CpqjhDxD74mgVYVe5G8lnavL4ABM+S52ON4c69gWX00KbWyeRh+FAV6EqfuL?=
 =?us-ascii?Q?52qNuxJJMkm9HZbWXKin9PvKoC+VzWgV+Q+guK2E4nwPGwv8VQ3c6qUsCeid?=
 =?us-ascii?Q?t1Y6HBQCo/KEkG15IvF1VgJqtaTMeThDMm5ROLfDnwBYesYu7bQ9bJ/loDdg?=
 =?us-ascii?Q?XLL/tyhMt49WzMnyqUP2xkFFRdma2KhTtKmfhwiTv8CMb56jIsMvOvRq1EvA?=
 =?us-ascii?Q?psk+pF+BVUhzRRMPeh+NEc5aQhn12Q/fKmeDyS/BevM9m8h8uznBiHqQmDeZ?=
 =?us-ascii?Q?0qJc4TcIW+m1SJYdLk0Ja9GoAPEgFliSHpkmhmQZIcRz5QOPOljVyIxGagfN?=
 =?us-ascii?Q?IEdnQhan3wAFz7ny+beT6Kwkdixk158OfzAcIWjZninhZ0Cj4WZsG5Rx1tEd?=
 =?us-ascii?Q?wxuEaS/lF/ohh240UQymh7ix7/9QRDltLbK0blyKwROeiaNHuJLyB8LaxYUt?=
 =?us-ascii?Q?Cjz2ahEooyfzk7wa5ThZAnHeljwxpN5N?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 21:32:20.6397
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 615c7c59-68a3-4e89-20a7-08dd1af475db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7010

There are some FW error handling paths that can cause us to
try to destroy the workqueue more than once, so let's be sure
we're checking for that.

The case where this popped up was in an AER event where the
handlers got called in such a way that ionic_reset_prepare()
and thus ionic_dev_teardown() got called twice in a row.
The second time through the workqueue was already destroyed,
and destroy_workqueue() choked on the bad wq pointer.

We didn't hit this in AER handler testing before because at
that time we weren't using a private workqueue.  Later we
replaced the use of the system workqueue with our own private
workqueue but hadn't rerun the AER handler testing since then.

Fixes: 9e25450da700 ("ionic: add private workqueue per-device")
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_dev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.c b/drivers/net/ethernet/pensando/ionic/ionic_dev.c
index 9e42d599840d..57edcde9e6f8 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.c
@@ -277,7 +277,10 @@ void ionic_dev_teardown(struct ionic *ionic)
 	idev->phy_cmb_pages = 0;
 	idev->cmb_npages = 0;
 
-	destroy_workqueue(ionic->wq);
+	if (ionic->wq) {
+		destroy_workqueue(ionic->wq);
+		ionic->wq = NULL;
+	}
 	mutex_destroy(&idev->cmb_inuse_lock);
 }
 
-- 
2.17.1


