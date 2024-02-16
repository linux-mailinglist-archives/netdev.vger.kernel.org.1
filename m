Return-Path: <netdev+bounces-72564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1483785887F
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 23:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9637228C6BB
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 22:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B20F13AA57;
	Fri, 16 Feb 2024 22:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k/29ns/8"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695452C6AE
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 22:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708122620; cv=fail; b=gjO5oz1G5S5y17KDLRhUqGuQQd3OTw6SO0P5NdHihY1xuSfxyhMeiqsea9XynV0LRS4BJVInFZZ28RB8DHb62jQ6l+z9dCUwChOIOVMuY/NPrWiBcgmawLnqBsCL37TqwwDzmdCIq4YOOLilbkRv5lQfCHx5iVOd8MTHPUFmxDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708122620; c=relaxed/simple;
	bh=3CtwUo1NoKyCsw5yWtjDxZV+KCL8ezL4fR3kSpokZBY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eX8Xtp9YzA9oMjs3CjPTafua93C5bnduihET/RS9j5uX1LSrEXDimaSxaT4GzHRLbLHxNqWlkaLhfl+JJvpcDhyw54R26FseCb4mUVF+fJM6ydJzdHoypAqi6oOtt0cho6MPi8ZmjeLM8TwlitCKgBu2pFvK4nIIKZDSGxuTFUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=k/29ns/8; arc=fail smtp.client-ip=40.107.237.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNdUeggnyUOLy42jlvWo+LraikrSnD0CqMmgbiuz7xKofmPFKwqOMkp+KKKx9PeOno2eqduhJC1+pFcrEfXfZvnSKni13OK63Uh5IehbA1hEmdhviy5fFBFLGeUuCuznJ5U7QkXWDzyEi3r7QccRdEq/Aeuq4u8c3ON43oJA59cj4vGWbY2tqTikyTDOvMJW3JD5BPI4Pk5ldtP/BM0A2Ip217edhNn9F5oqAnbqw/pd7cQI+Io0l9moFjscQNHloQiBD8q4W+YVz/X6H6otZTqy7DbYzcFSSPQP3oNdmQ3wRzYLbGt94mRY9CDU5k5uFCmMHu+wVXhNrbppIYkcBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJL0SmrekaiSAnENeCnXka3PPqBd0Z4UZrFXDgUqedQ=;
 b=Gd0tVPxGJqmOnEfTdvVDnb4ZtOyZBnXz9je4LHv0EjqNX3QoAhYpc0Re5Lm6LD/amPxhbFEvl8PPDHkXSVAZVdzM8+KQAtqEndh4497pwc8ctkLRGv7ljW1zDibrwpKYcyHrAPj7uOGObNChIf/ookGrLKd6kWNwJIjxpYojc6/nyQMiF51rjVM1RhqJ2l3abq6qwzypH3YizzsYSfKaCUQ7AsMX29mp/VjgMix8WQESEM9nF80vzbPRS9iR7HP8kT7+3uw9uvU0k7Hw74cjQfygtUBXuOKjsFU9UG2JfOPfAoRMV3corbcHRtP5TbkQXxJOif6eNtdPQn+WLUPckA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJL0SmrekaiSAnENeCnXka3PPqBd0Z4UZrFXDgUqedQ=;
 b=k/29ns/8EoOrtwK1su4ehRmnXeweizQPx4x2q+JrvJgcoT+gw+t2W+/QTNl4N3j0S804dSg4mRK0nrMMZqCSMQrj/jshf7pxwqnnwCac0hgFAVBvBhCDCOFy3ceJpjobaQ/ohGvT2SZ6HAO0auDJ9G2TOQNQXROon9Yo0OT370A=
Received: from DM6PR03CA0081.namprd03.prod.outlook.com (2603:10b6:5:333::14)
 by SA1PR12MB6822.namprd12.prod.outlook.com (2603:10b6:806:25d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.15; Fri, 16 Feb
 2024 22:30:15 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:5:333:cafe::80) by DM6PR03CA0081.outlook.office365.com
 (2603:10b6:5:333::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.40 via Frontend
 Transport; Fri, 16 Feb 2024 22:30:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Fri, 16 Feb 2024 22:30:15 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 16 Feb
 2024 16:30:13 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 1/3] pds_core: add simple AER handler
Date: Fri, 16 Feb 2024 14:29:50 -0800
Message-ID: <20240216222952.72400-2-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240216222952.72400-1-shannon.nelson@amd.com>
References: <20240216222952.72400-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|SA1PR12MB6822:EE_
X-MS-Office365-Filtering-Correlation-Id: 385ba61c-c30a-4a76-356b-08dc2f3ed90a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Vv1i4B2j83/6igEF0Pq+VftvCx7ctbjzMC4SyX1a/HpuH0vCiVI9XYQrSl2xMJsos+Lej5e6U0Xn4Xj/hdMoQL2cmNl+WuGrAt3RTx2B6Od4++y40Memnn+BSkNw2VCVfMiP7U/YZX/tLBV03p4FXGg/RITPA/F7HelWyzTLwyGPIQG7kwMz4GmktRY5GEZLqr1ITTjjyE6IwmiPgxTy5R9QE818IvUxAe2CTn41TDoI8+gN/t3MkB0K2ZPJvI4w+3dpWydAe/5MukvdrZeDWCA9e8VC+l00b6KFcgRg5s0KbuuDgSAfp4loW+Llj6B+yDZnj2RJkuMgNJWPR0dMn5zOic6c6FXhJrDacHbrxaS2nvBoFvMOQEHmkIgdUNPNTSCBlqFhn1kMXzZAsATvF6PBuBmLkgOB4y2OY2vXRqi2jt6tg+QLMbRU207U6r0LNTiP+/fSYuyJ3plGdNJw1Kf8/h7Nogf0F06VsrXVv1z3wyV/+vcA7tD++NKqpY1T5th8jnPgoPYqrnEw020Mz6jBsbreUHjqBefo6g9WvAMLKh1e2fHTpW07GnIlwXXpIHvVQYaa0m1aX5Y9EDhi3xLVujyX9d6uKJQemrXzeASwKqkjwHWpFTG99Ey2OS2SWS3LjvrOqwYFbqsUZ6nF9w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(36860700004)(451199024)(82310400011)(1800799012)(186009)(64100799003)(40470700004)(46966006)(316002)(54906003)(110136005)(6666004)(44832011)(8676002)(8936002)(4326008)(2906002)(5660300002)(36756003)(86362001)(70586007)(70206006)(26005)(1076003)(41300700001)(2616005)(83380400001)(81166007)(82740400003)(478600001)(16526019)(336012)(426003)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 22:30:15.4008
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 385ba61c-c30a-4a76-356b-08dc2f3ed90a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6822

Set up the pci_error_handlers error_detected and resume to be
useful in handling AER events.

Reviewed-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/amd/pds_core/main.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/net/ethernet/amd/pds_core/main.c b/drivers/net/ethernet/amd/pds_core/main.c
index 0050c5894563..e10451a5a89b 100644
--- a/drivers/net/ethernet/amd/pds_core/main.c
+++ b/drivers/net/ethernet/amd/pds_core/main.c
@@ -45,6 +45,7 @@ static void pdsc_unmap_bars(struct pdsc *pdsc)
 	for (i = 0; i < PDS_CORE_BARS_MAX; i++) {
 		if (bars[i].vaddr)
 			pci_iounmap(pdsc->pdev, bars[i].vaddr);
+		bars[i].vaddr = NULL;
 	}
 }
 
@@ -512,10 +513,33 @@ void pdsc_reset_done(struct pci_dev *pdev)
 	pdsc_restart_health_thread(pdsc);
 }
 
+static pci_ers_result_t pdsc_pci_error_detected(struct pci_dev *pdev,
+						pci_channel_state_t error)
+{
+	if (error == pci_channel_io_frozen) {
+		pdsc_reset_prepare(pdev);
+		return PCI_ERS_RESULT_NEED_RESET;
+	}
+
+	return PCI_ERS_RESULT_NONE;
+}
+
+static void pdsc_pci_error_resume(struct pci_dev *pdev)
+{
+	struct pdsc *pdsc = pci_get_drvdata(pdev);
+
+	if (test_bit(PDSC_S_FW_DEAD, &pdsc->state))
+		pci_reset_function_locked(pdev);
+}
+
 static const struct pci_error_handlers pdsc_err_handler = {
 	/* FLR handling */
 	.reset_prepare      = pdsc_reset_prepare,
 	.reset_done         = pdsc_reset_done,
+
+	/* AER handling */
+	.error_detected     = pdsc_pci_error_detected,
+	.resume             = pdsc_pci_error_resume,
 };
 
 static struct pci_driver pdsc_driver = {
-- 
2.17.1


