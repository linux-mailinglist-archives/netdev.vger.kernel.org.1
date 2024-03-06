Return-Path: <netdev+bounces-78179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7EF8743F1
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 00:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 130BD287CA2
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 23:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96C01CAB9;
	Wed,  6 Mar 2024 23:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AfdPyC42"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2040.outbound.protection.outlook.com [40.107.212.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12618241E2
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 23:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709767831; cv=fail; b=VlBdjl6M3f/IPC8K3qHdnH1V6ud2XMf0KvWeU4ja6XT8VgkB0RYBl5HcczBLzTOZ6socpQx70dK1baTKlKC8AwJBJnh8LkUy+0i49Lb7kz8liPzTt3aHvvmYlcdEH/Wd4ygQC3uQ+Cu9WfbUdDyz94TnnCGT/N6eM7xZdfyuKVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709767831; c=relaxed/simple;
	bh=fCGwMxQOKKjEKVW5YEZjpm4tRrbPrS8gJiDXJsbrwgA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fkCfyqtBxDfw75vAWGeUTp1Yh9TgWPPBS7L/Sx1ZPDiLVa8yBLP+kUn2xYFLLfFAgzsGDmSKhPFiBKYr9TXnMcqADwfD7gxbqMQeSZMGK4Sh0PJyxuSMtBLRn4vTpN4UH5CYbdcxsI40B3ByQAfvmun5lYASd/HocWsNuzVlejk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AfdPyC42; arc=fail smtp.client-ip=40.107.212.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YolCDon539v4vjOkIXvu6RSKylT8gubTvxa5xkDMfG7HOpf//QwmgizE9uRt5ogixGMPXfrgySiutgy3GHe3XqEeCJui8PiAqkteqjxgV0+2Bx+Bkg+MqfVrYROrD91+2jKfdUPXUhp4J3sySvsPbBE2oG1+BFCiaI1M1j0JsFXri7WnrnRriwBUs23zwoy86n64n6VbvxqaFBp+fKqwifeYJaIBIBI6izdVfIh1GQ79C9b7A5XKkciicdXkE0kt9X8TdjBX8/KHkIBUPTLWV2SlacCaoABct6DccIXSApj31Mw6JUvNAEAw+RmW2Ex2afK46H+5Bhjl42pDK3VXIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGPRLwkYvWGKO/8y80OfnGr1KnXcVQb4tiPmGqfVxqk=;
 b=Qetin8SvdeHSV4mpQRlfL8beN01Slzcp1qAqm0HcvAaFIQijrhsO4HSnb2CGiRQIQUAgLDf0ikF35r9mbXRbczFbv+xtA9ottu6eX7ZW40ZR+0bzHgkTVjOvzBVrwJPIoHasilbEIrNj+zBhRXXsi3U777Y7XI6wuoDYQyjr79f5/MHhWbnPi3O7LN0udHiOyJY9aNukIZk7ud3JTddWDLWOW1G2Bxz9Gv1v8q2eBPWLlXMyUGrvB/RbEpZatGM5zudpuIgyqCO+J2xtxnkcuqUM+PLYQDFpW7+msPtp2aLVTA0sGvRwzMlP4rIERphMQc9dk046L7f19EJOoONzyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGPRLwkYvWGKO/8y80OfnGr1KnXcVQb4tiPmGqfVxqk=;
 b=AfdPyC42ZAgRw9TIj1YPgrx3KvIioTTGPi6EzLLOyS2OsOodfRU/aQBN25yPvOJD83cZK6cUHEfndc/luhxasCJKqf/aUkvIR5m4s4swQ71cgHLlbAN2rFAP+OQKTwQFF5MLRhP7nepeJ7iBvhfqoJJCrb0UUHxxLPEQLJYejUk=
Received: from SN7PR04CA0155.namprd04.prod.outlook.com (2603:10b6:806:125::10)
 by CYYPR12MB8991.namprd12.prod.outlook.com (2603:10b6:930:b9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 23:30:28 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:806:125:cafe::f6) by SN7PR04CA0155.outlook.office365.com
 (2603:10b6:806:125::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26 via Frontend
 Transport; Wed, 6 Mar 2024 23:30:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Wed, 6 Mar 2024 23:30:27 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 6 Mar
 2024 17:30:26 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 12/14] ionic: remove unnecessary NULL test
Date: Wed, 6 Mar 2024 15:29:57 -0800
Message-ID: <20240306232959.17316-13-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240306232959.17316-1-shannon.nelson@amd.com>
References: <20240306232959.17316-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|CYYPR12MB8991:EE_
X-MS-Office365-Filtering-Correlation-Id: fc02759e-a780-4a97-069a-08dc3e3567f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jgSW1crRqvUPPgID/QxI9fZ1b0Za4VHgeA0lwtEeBlZklmOoXNgzxPw+8QYHQeweRKyT8al5nP3DQI+MJs3+gadJrkEIBn/K95vgvLBCLYJYHqn4T6EX5udjeRGBfIpQWlcK4Cq/he9o7LsVoHhPaltd8KTaPUoUu5vVxcanZETc1C3F/W1Q3wyDGGv33wPsPiM/kkoOl/ywoxwRG+tvUkSpwhZlJzuhUPey/Y1H7tQASLRhLJGIFKqXLn3q2s/fDFSY+NyPTfu37YzbKHRlIiLtiNt0Wekzp/K3J+t2Ik1bpFSi0zKTKXkBIh1WeEgT08YCGEzu7b/q0b99lAa5Jq5OAMv7jxS/ApdsQ8aOy7WM1OSCq+REWd02YLTWXBdwN5tk7AZ2Q7Eov4qS9iV1UsWvKJvht93UtLCYeCnHX03WqtBtVw7Ef2Mxre4IeBXzLey7ZWwLU+Hg0Cbwam3SN2kivioVSKmGQnkl+sBv2+v/DUP3tCpX6nnWcq25ELwTmj00FX35uuvIkIlUyxjL3w9fmCWDW0PnfxB87xS7b3z9yxkskIJCqHdlU/Q7juyam/iaLFGjB4eCEmyG7gfNJhz6m1H1yVl2cClE94UdUV53kq5mebBKeNjS5KyVxL9ocMTsHVT0cOZxZKmQ6NFOjQUjxP3KhC1FcXUeEbEIQbk5XbSl24Df8TI2TXn/MRFD7jBRWTZ+1tw1rH5U22nQg4RurvgC3VjsXCIyBkO956mtggLbDJ0O+vR7BMmaRNuG
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 23:30:27.7705
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc02759e-a780-4a97-069a-08dc3e3567f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8991

We call ionic_rx_page_alloc() only on existing buf_info structs from
ionic_rx_fill().  There's no need for the additional NULL test.

Reviewed-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index af414707d614..3bb3534b3d25 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -135,12 +135,6 @@ static int ionic_rx_page_alloc(struct ionic_queue *q,
 	dev = q->dev;
 	stats = q_to_rx_stats(q);
 
-	if (unlikely(!buf_info)) {
-		net_err_ratelimited("%s: %s invalid buf_info in alloc\n",
-				    dev_name(dev), q->name);
-		return -EINVAL;
-	}
-
 	page = alloc_pages(IONIC_PAGE_GFP_MASK, 0);
 	if (unlikely(!page)) {
 		net_err_ratelimited("%s: %s page alloc failed\n",
-- 
2.17.1


