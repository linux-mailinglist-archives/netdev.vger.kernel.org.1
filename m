Return-Path: <netdev+bounces-33984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1D47A1109
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 00:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A8DB1C20E3B
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 22:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D504BD2EE;
	Thu, 14 Sep 2023 22:32:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49612C8E7
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 22:32:36 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842572700
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 15:32:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jkytwBBhitLRA2seQ2AkFc0TW4a4V/JNa0Ze6PhQ5t/IuOiPmWyYX6htZS6cSil4iDmxXXhfnd7ul3Qjhm2qXvbPmZgV40zL4dJ9Phg3IlRwYUEx94rUHwWr4MsIyod1zfQSOdpEm/eJWSqUJSCg2IMXZDrQ6Ozoaj2gZZYXbLQEjs0TW0tLJsS6onwy2FSq0bqNCKR5TIj//SYEIQVtUYHnvd+mVBbyniuQTlJyq2Ea0ZBip6/1l26apXoAT81PnClqhk1f3SPQpOVBExrWD1q6I+7+q4XQBlZzvi2b8uY5FCascMlwJwtViCo6Dy2BD51LnmArfzhxGgF59UUw7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZPYZLBL3VHUiwKUB2UdSjqrP+TN/LgMUIBerjg8+E8=;
 b=jFeSkpEs3Ageyefr9MEzwL6fbtik9tro18PGeXSXtVPwTPciKFCzfUbG/kfuciP6rJQbc/LKxFChMJ25otWsX0ZQasM2n4JSegSAxQSfCbqt4bJfMByHc3ipKy0YCp0Vn+QY31m3KKpJS3vNMS+HvJ9cJezKgO36IY9lsqTypZs5jL5wqOW7NSOhMzQSWckbqDf7xEa+9KFp0FNXh0gcDVrzD+qlji4QxZ+TA6AIC7ztWeTlcS+F0ntUIpQSHhPduu4Q0jMPqLA9+SgpKZ5l78WpUmSj8T5ww+kILpVmFSMl/hp5uLDsw3HKDKAHPcXIVW/+mWUFfoXw0nd/cKrB9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZPYZLBL3VHUiwKUB2UdSjqrP+TN/LgMUIBerjg8+E8=;
 b=sjj0qreNeD7yyBHMUPwbf4ManPZTD41QG9s11mtjZ7TB3Ooi4QKrFT0gTebu8bT5nSqhcY7dkhp+0u43ttL+z7SXaCRXCDlYc67gHIDve9p55EnxrSvCu7WeAoPcnb4kmMWP0B4VSZOqqhz6jQYkK315xhhNoXzde0GhKE7R2WM=
Received: from DS7PR05CA0095.namprd05.prod.outlook.com (2603:10b6:8:56::29) by
 LV3PR12MB9214.namprd12.prod.outlook.com (2603:10b6:408:1a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Thu, 14 Sep
 2023 22:32:33 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:8:56:cafe::cc) by DS7PR05CA0095.outlook.office365.com
 (2603:10b6:8:56::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21 via Frontend
 Transport; Thu, 14 Sep 2023 22:32:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 14 Sep 2023 22:32:32 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 14 Sep
 2023 17:32:31 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH net-next 1/4] pds_core: check health in devcmd wait
Date: Thu, 14 Sep 2023 15:31:57 -0700
Message-ID: <20230914223200.65533-2-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230914223200.65533-1-shannon.nelson@amd.com>
References: <20230914223200.65533-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|LV3PR12MB9214:EE_
X-MS-Office365-Filtering-Correlation-Id: 818f80c8-9a7a-4bd8-3c2d-08dbb5727cda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ydZmRn+quafw+C17KsJNoy6cPgWnbus9qAU4f/lIXaCmyjrHPfrTQf4gnDhKGqqbHWcoc/PyaG19R47jv94K5YnZGV0hperd2HG/zHo+tH/K7x9qaYbMK4hw1Z1ExxF3j86c4pmN59qm+VlTExHoBvxywf47fVMPgyU157WdMy25XiO/20xnaRPM1EPUJxk9XH7ddO93DgxYMvpEjH3s9CIJ+EeL7BYOUA1BztZ8RlZdhRyFluyL/gacH2byOviTCDO1z3cFxcchSh3Shv7aqQBrGcKeCXzZF7e0mzHcm1C84h/X80CkHn186umKYvun/85AsskGxgaXPwxDdN1wUAUy7IexpfR2JpPQG6xuIbM4Q9KezZKKesutc+oDPfiKOB44FfQsay6LzvpnTc4TjmgUlIRYdsOnkJxNUbWCWVQ44P5S4n88664Y0jELnemNn8tlHQvRLiExUtuRvCqFGUjHwFll+TtwmsjIVguQwO1LE4ZFJDD0N8+WoEBRq5ZZYXEqWS5UX+ave/gNfntbfzhmv/Oym9xlV0QaMSgj2f/070b1jWIO2yDftzS6NAMZtPVfRDPkG5Ll1wEtiku8b396pfz/5T9ryPSmfZu0Yxd+CTnUejGeSbP/DKDf0dyHaGknJobj+VHP2t/OvlvG5CUwvwNYxqUpQ/b5lqup6Dw5TAn94o1drrg7CZryMpldBrWFnyI5srD+Z7uY79Oii8g3EjPykUUqYxd6ql8G6Psytie5TM8TB/e5PVAOX5slC5WU/ZBp277EDyd8yORsuA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(136003)(376002)(39860400002)(186009)(451199024)(1800799009)(82310400011)(46966006)(36840700001)(40470700004)(6666004)(81166007)(40460700003)(356005)(86362001)(36756003)(40480700001)(82740400003)(36860700001)(2616005)(47076005)(426003)(26005)(2906002)(336012)(478600001)(83380400001)(110136005)(1076003)(8676002)(4326008)(5660300002)(44832011)(316002)(8936002)(41300700001)(70206006)(70586007)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 22:32:32.7852
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 818f80c8-9a7a-4bd8-3c2d-08dbb5727cda
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9214

Similar to what we do in the AdminQ, check for devcmd health
while waiting for an answer.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
---
 drivers/net/ethernet/amd/pds_core/dev.c | 11 +++++++++--
 include/linux/pds/pds_core_if.h         |  1 +
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/dev.c b/drivers/net/ethernet/amd/pds_core/dev.c
index f77cd9f5a2fd..7c1b965d61a9 100644
--- a/drivers/net/ethernet/amd/pds_core/dev.c
+++ b/drivers/net/ethernet/amd/pds_core/dev.c
@@ -42,6 +42,8 @@ int pdsc_err_to_errno(enum pds_core_status_code code)
 		return -ERANGE;
 	case PDS_RC_BAD_ADDR:
 		return -EFAULT;
+	case PDS_RC_BAD_PCI:
+		return -ENXIO;
 	case PDS_RC_EOPCODE:
 	case PDS_RC_EINTR:
 	case PDS_RC_DEV_CMD:
@@ -62,7 +64,7 @@ bool pdsc_is_fw_running(struct pdsc *pdsc)
 	/* Firmware is useful only if the running bit is set and
 	 * fw_status != 0xff (bad PCI read)
 	 */
-	return (pdsc->fw_status != 0xff) &&
+	return (pdsc->fw_status != PDS_RC_BAD_PCI) &&
 		(pdsc->fw_status & PDS_CORE_FW_STS_F_RUNNING);
 }
 
@@ -128,6 +130,7 @@ static int pdsc_devcmd_wait(struct pdsc *pdsc, u8 opcode, int max_seconds)
 	unsigned long max_wait;
 	unsigned long duration;
 	int timeout = 0;
+	bool running;
 	int done = 0;
 	int err = 0;
 	int status;
@@ -136,6 +139,10 @@ static int pdsc_devcmd_wait(struct pdsc *pdsc, u8 opcode, int max_seconds)
 	max_wait = start_time + (max_seconds * HZ);
 
 	while (!done && !timeout) {
+		running = pdsc_is_fw_running(pdsc);
+		if (!running)
+			break;
+
 		done = pdsc_devcmd_done(pdsc);
 		if (done)
 			break;
@@ -152,7 +159,7 @@ static int pdsc_devcmd_wait(struct pdsc *pdsc, u8 opcode, int max_seconds)
 		dev_dbg(dev, "DEVCMD %d %s after %ld secs\n",
 			opcode, pdsc_devcmd_str(opcode), duration / HZ);
 
-	if (!done || timeout) {
+	if ((!done || timeout) && running) {
 		dev_err(dev, "DEVCMD %d %s timeout, done %d timeout %d max_seconds=%d\n",
 			opcode, pdsc_devcmd_str(opcode), done, timeout,
 			max_seconds);
diff --git a/include/linux/pds/pds_core_if.h b/include/linux/pds/pds_core_if.h
index e838a2b90440..17a87c1a55d7 100644
--- a/include/linux/pds/pds_core_if.h
+++ b/include/linux/pds/pds_core_if.h
@@ -79,6 +79,7 @@ enum pds_core_status_code {
 	PDS_RC_EVFID	= 31,	/* VF ID does not exist */
 	PDS_RC_BAD_FW	= 32,	/* FW file is invalid or corrupted */
 	PDS_RC_ECLIENT	= 33,   /* No such client id */
+	PDS_RC_BAD_PCI	= 255,  /* Broken PCI when reading status */
 };
 
 /**
-- 
2.17.1


