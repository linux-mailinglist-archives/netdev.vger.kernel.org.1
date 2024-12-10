Return-Path: <netdev+bounces-150781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0189EB89F
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 18:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 099A81630B2
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 17:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2B61C2DB0;
	Tue, 10 Dec 2024 17:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Uic1ejgb"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8755F23ED5F
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 17:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733852932; cv=fail; b=bgY9NYrg8ypU5+x0Li5HffY4EmNbiaeG/LmWmhif5+motwL/Cdrg//rovRC7oGA9qfFpoI1UfW6ILHe4/SOM/xWmPuXbzPZSQAQDQ4mZ2h9CG/N4E6E1fizFF5BQgW3FL3LK442ucnuu5/7DgJ/A9hzFeIxgZ4P1kIhTT1Y994k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733852932; c=relaxed/simple;
	bh=tE8gG33Sam1o0mejRjG3sf4rpYS8VA4sqGoF6ctNEJA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RlgL1SndPd3L+oSgW6LEt67iFz+42HIOh9lbiY5DkCQ7go9F2EXGhSomU9/r6cFSfWcCRh5Mu2qF7pCYv0Ew8P8VwQWzUh184HysE/HfN3SMnhxBoYE8hvogoWZfLotqX4iuYNNoyLtjcSxJUfGdJRvORXBzg1TCW/KuxSqo+QY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Uic1ejgb; arc=fail smtp.client-ip=40.107.94.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CuWsv0WX14X8MTFwZTreR7gOh3Pdt6Gjb///lIKOsmrk+xSxOlTzvFHSWQCAh4yZK3ygJUzhfm+MLsr1BY+r2uQ55AUL10gsXCZ3BWdiM7QA8+sNvO11LTnHZl5Y7yxbcXhWyAG3DrxMmRlzys1sUax5GfgHWFNyd/mLlkF71LjgBmaLyppq37/aBfa/IzhT3vvXyKEjgjuHlsuNx4hIKuU/SCF8yTEY47Vqk9ALHN57d1sy5jbEaLnFypuULngDvrDSJE9iL56EkyW1PqICgBRkA8QOdy5TVGTPd/QUmvfZ+RRlUpNejWgN8/iDkIHe9V+J560FKPA7gnVbKaX89Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6Z1MERl8MCyA0ms7zfQr51MixZL12E01uZNiXeimuM=;
 b=d/OidwRBq9GkjZ3U/lB+4YL+EKc9ISuwwKykUgqGw9x9gJkwkBkmfivQOBFbrbJhdfTGbfrwjKXq00XcH2/NJ5kXPT0ojINRmRgcJlGFxJ4eN8Cd6NZ6+kxQBryqS1lSvgerf20vFQK5LOH4PCCLdAH/UfsHDC5R1tPZSFbTRXk42N72fkPLBULcJDanAccRejJCOqkwCripl76uONqCUznEAeYOlXVxGdudo+9S4kUb8MWKpC1W91NInIHqURgGyim2UF9WVKlNrF6Oo/+5rJJYjziAHPfdnAHaNTKPwW9ytZv6dIS5+OQhIndyG6R8eoXoShjT1zbbiSpEFzlxoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6Z1MERl8MCyA0ms7zfQr51MixZL12E01uZNiXeimuM=;
 b=Uic1ejgbbJAWd7Y3TXW2XMD8TU7bNEDQ2BCREkmWEhPBCQ/6sIozl96Zu8+ouZW6P/NpIvZGtfgaDCSb4jGJ9mJci0CUuDUlO4dXQZJp1/TAEAwhIsHuIvqu+yLOPUaV1TgA57xmJmxPI5tS3i31ou+x8PH/2jG1mdHHo7nYE54=
Received: from BN0PR07CA0006.namprd07.prod.outlook.com (2603:10b6:408:141::23)
 by MN6PR12MB8490.namprd12.prod.outlook.com (2603:10b6:208:470::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Tue, 10 Dec
 2024 17:48:47 +0000
Received: from BL02EPF0002992B.namprd02.prod.outlook.com
 (2603:10b6:408:141:cafe::1c) by BN0PR07CA0006.outlook.office365.com
 (2603:10b6:408:141::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.15 via Frontend Transport; Tue,
 10 Dec 2024 17:48:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0002992B.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 10 Dec 2024 17:48:46 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 11:48:45 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<jacob.e.keller@intel.com>
CC: <brett.creeley@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH net 2/3] ionic: no double destroy workqueue
Date: Tue, 10 Dec 2024 09:48:27 -0800
Message-ID: <20241210174828.69525-3-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241210174828.69525-1-shannon.nelson@amd.com>
References: <20241210174828.69525-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992B:EE_|MN6PR12MB8490:EE_
X-MS-Office365-Filtering-Correlation-Id: b1a95862-3745-4e0d-9688-08dd1942e5b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Sj04RKvwiCpvT6DIM5tNd6Wf+Bam1P9XW1coEeJdKk8CeqesUdU95vzrLrUl?=
 =?us-ascii?Q?G+ItNTtTK7IM8bI++M+WngISLwBMPxEdnvci7YYcF9A0urZGycRxvN4d40xw?=
 =?us-ascii?Q?giC1pfc4+uHLQ4Jy4+VsYjeFpUbS1sDp/CqIbnXWG3lbpGXCpbazp2T9hVWz?=
 =?us-ascii?Q?btHURHhniQC46oEIu68OUOTc/njymva3FDVHosIPK7uzyBWb5rItyEj6XD88?=
 =?us-ascii?Q?rC90SwdPEKVoPaE7EiMxa3yFdOIVehk6A80DxMyzkZ6UyOyEXWN4Webyjp+2?=
 =?us-ascii?Q?uCfjZXP0KXAHOkEfrocJv6/O7khOV70H8DnGW/t6pif8PaIjLqe5BX9bBTgc?=
 =?us-ascii?Q?6b/f7wy3GSGoBSPNkyvxjue/P2dS+VkmN3sVl4TpUaWHb4B89SxFizjPz6Xv?=
 =?us-ascii?Q?O5xqKNAbGbiilNfjZklwiNkQEEKHv3ybvC0kcgZQMxOhlfyRt+h1S/A2gxrI?=
 =?us-ascii?Q?gG5JiF9992AkIdySixTNKA1eWoTUrVXpv0q8fkNRdeZKzCg9LLfiYji9Pbqs?=
 =?us-ascii?Q?rr+ZfrCx0iAWbW34bv0YebKfU8LbZv2qPvGcPcB293rKj1BXbkag6n90MclF?=
 =?us-ascii?Q?nQMjit7Sg+ZqagWDOG8DSYABar9r/5gE6/baFyLTeXTJxPU0VCGbogBMcQ9A?=
 =?us-ascii?Q?cAhG6eXLxtkyF4/2bw2Jmsm3gp0N+VeNDBCRgvV2fU66La+PvLYINLUQeMFY?=
 =?us-ascii?Q?HyhNS9fkqLmh9+iHudRsiWhjydRZd9SBRIMNlFBhEz+oTuCBP41AQnWSwE0g?=
 =?us-ascii?Q?IiDSz0OEm3g4RQM3DvtLAlToPcZwH1XvGyJ8XfP4A4V90lxR2QOod9SArKxQ?=
 =?us-ascii?Q?/czS8VVoayI+HPOAJ6ecF+jCv2t7Jl8S1BxCjVWLCY8gwsMe5tqP8gbAOb4k?=
 =?us-ascii?Q?gx8uGFgtdbf/Jrj0cWpjur5G5N6kWxVtJw3XpsdVfbEre4nxaYnswUTbRVbF?=
 =?us-ascii?Q?Of0ffdWEnbCK/oz3ldFb3BvuM9FK/JXuFjc5npl9kvyEG0tv3EgyjQQ5GyLa?=
 =?us-ascii?Q?SCzMKONnyq47a/VJv9QyBveeh64RFxmZ771CXsIZhibWYwgO5fNQ4NpQqkfR?=
 =?us-ascii?Q?rUqBNpHAZM3+3F7D6kR+C01MYklg+iKgY4yClUYcjtpTJlQzZrjRbgksQlKi?=
 =?us-ascii?Q?OH6s/mRMtA5szXisxYmiqBLx55kZJTqPVgzxjbAUo8WeFtoHBJixb2cehPvc?=
 =?us-ascii?Q?Mhe9IM3EawXPNWKTwFNvENrOM7LNRGNUJzfAUA6uTb2Wl4rjq7sVkshzTE0O?=
 =?us-ascii?Q?EqNaObFsoAGqfa2OqskB+pjmaj/H9ja+o5zpPI4HyMTSOaKLida4F75eAE+2?=
 =?us-ascii?Q?5mfI3Ft0vYpM+b2G7if5XdZObmFXfHspyK+nsQridrqQdaoAa0aePtPsG0jN?=
 =?us-ascii?Q?Vpyg4+V9goPJo3pZWe983UexmrOiHeFb/7DVqn4f9l/JGy5SF+58cfkokV44?=
 =?us-ascii?Q?t5uQCqOPs4WDNOdTcxph3M1liLRNrrAo?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 17:48:46.8337
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a95862-3745-4e0d-9688-08dd1942e5b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8490

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


