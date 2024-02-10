Return-Path: <netdev+bounces-70698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BACD285010E
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 01:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 230861F29DCF
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 00:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4624365;
	Sat, 10 Feb 2024 00:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AWWJJoRg"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261DAA47
	for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 00:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707524448; cv=fail; b=p+GKsIVIGWdvxOr/55F6eb/6vi6iBacwI5VwA9PrBVtZhIlV0COJNKmdzZTPIr2UDuWKPd6v1QNAtO69i1bE0qhfHFcG8knbSxOI3lSfMhau+Ib1ss/JLPypZyaK618/2vKfwWBf+huXqnZCjLFKjpgq9Luw79dYugElJB+UQTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707524448; c=relaxed/simple;
	bh=FUFH61FptUlC16y/qz8BmM5WJQSJw65Rp9T7s9yQBvM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sYeZnTdiw8cX3pLNm7B6/eR5aq7LYEPqUPR/Vynia1lzRFCukjt+zVevoFXIJjpNVtQ5O2Sxg6htsVO6C+jalpqtEXHG5wfMTuNh/wd7814S6aqgbOD3/A73voYJMn6unO1lf8MBsDH+/2l/GA0MzaqDM6ZnhZVIFAYNULJ5LKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AWWJJoRg; arc=fail smtp.client-ip=40.107.243.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gcCopwsxkh3+eCM7jhKWt4w/rhF3TKMjJvo5Y/lsusc4weg8uIbM2mFR6Js2XYU4byyMQjzKSnUuzYkiHXw5PL8dotEYtnId0cpTvPlfXN01W+8j4LYkPP0js4TuIVhH49l6PTNQiuCOjbYMQ5xLbGeYmLFU2B8bvqCSYlf8fmvEbPMu9Sbq2xJuXs9tUHMASqJXlbTZYaXVPtGk0TWe0xY06i2FlYR1wm68GEDDAQQRCO9jNfYUyd1p9dp14UO2MNys5DIs8OMN6AWNtad5BWAs2+6lcsA4pMu0g1Yv7j4NvXXPjeA2fWElczwA779vtgmcpQxMymKlzLf87Irk7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQXrwlw5PO/A+g8rryfuLLGs7rCtEUnAs3D2gk0T7HQ=;
 b=GsJ+nBEkhcj+z5AQuwKWQ0PmgT2m7LIvWSyD7q7pmw0MtKVIqGUSBtVg3aBj1XxLVbQbzRxNDd/59xzhxkhIVCpX1RzBbXDXSCn+rCEFbXT20HDANHvg5kizud996tHs7XtqIAM/10WIe7eJsN6T9d3H6PIzpVA7mqZUbb7m4r4TBIcmtXRqLgX6y1gTc6dobms+5boVwcZ1Uwtip194Yqz5KywHkDEcqpCVBY6fKUS6L6x0QI3lYa5HAwCJggHUlGM2R8B2Vuz/lx+Jh/U/4XtNYrFuDnXky9ict4KFbLW+k6/aQ+r2XkfoHEtDg0mUZ3PCY7zm59NbWbx45yqwxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQXrwlw5PO/A+g8rryfuLLGs7rCtEUnAs3D2gk0T7HQ=;
 b=AWWJJoRgmP6jKXn/BGMKnLsC83icZHJAZP5mM66cHo9YuqBhBX2YNuD+zwa6XwR+2IhcLQigdcqKSL38FXLzlmwHNfithjGteKB+7B9vh8u4zf1l2kcuYSwc2rKEWFUPFDONfjt6Nh+i95YeEcGrVH6zHpXUOo+SNTLdSW1+rLE=
Received: from MW2PR16CA0069.namprd16.prod.outlook.com (2603:10b6:907:1::46)
 by CYYPR12MB8939.namprd12.prod.outlook.com (2603:10b6:930:b8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Sat, 10 Feb
 2024 00:20:44 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:907:1:cafe::13) by MW2PR16CA0069.outlook.office365.com
 (2603:10b6:907:1::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38 via Frontend
 Transport; Sat, 10 Feb 2024 00:20:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7316.0 via Frontend Transport; Sat, 10 Feb 2024 00:20:44 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 9 Feb
 2024 18:20:42 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net] pds_core: no health-thread in VF path
Date: Fri, 9 Feb 2024 16:20:02 -0800
Message-ID: <20240210002002.49483-1-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|CYYPR12MB8939:EE_
X-MS-Office365-Filtering-Correlation-Id: ae956a2a-bc5f-411f-f1a0-08dc29ce1f1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bnWF1+OWVZGzFcNpMfXlV9DET166zgaGgdKT1ooG+EW7gMQkqOVRtxoSfhjPbRv8ID6/dU2C/vtHqqQN/QzzlUKEv3aujTa5b0WH7uvmjHZxPm5haMA3HCSrWEzHMPpz9IncuC8GftqOzPX3hkJfzHc5O3mQ5QIGUgkD4BIhC3Ch/FrZ22eUhyZIBSIDMT7sfKhfM6CCE5pdlLdZz7nrTDPmwvVs0mJMQLwyR6Tx0irLWQ8tUx23SWoCMtjqlAyGLb3wLR8kqJvVypS6lo4DfsUaA0K/ljzE/qO4O/Xseoj0vwQDs7QwKF9VPxWz6g5FflA3+3Hk/OIQVj8mou/nG71wsRPTQGw0VbFb/FzQxaF+TBXs4Zl5Fe7E/Ycn+7EK+S6xml9bCG5N8PNz4kj52u7fyrDaZxLP0WcRx0sSyymFE6XgNkxl5ui6eXLoiDM268M56WSQtGWh2ZI5XywA3cGGfhyasU2isjZBNxG0bybSVlld76bdAgdBvWtbuVzYtYKhAfaLbkbfQjgqi4VVayI1ssRVqcUl6c3OU6fBw/YIrdGrc1BjYgqkvk7UBfR3qk5Hydak/fthieEenIoxAJ8bt+UG40MxBGfyw+mw584=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(396003)(39860400002)(230922051799003)(82310400011)(451199024)(1800799012)(64100799003)(186009)(46966006)(40470700004)(36840700001)(70586007)(41300700001)(2906002)(6666004)(44832011)(5660300002)(356005)(8936002)(4326008)(316002)(8676002)(36756003)(54906003)(110136005)(82740400003)(81166007)(86362001)(70206006)(2616005)(478600001)(1076003)(426003)(336012)(26005)(16526019);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2024 00:20:44.0394
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae956a2a-bc5f-411f-f1a0-08dc29ce1f1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8939

The VFs don't run the health thread, so don't try to
stop or restart the non-existent timer or work item.

Fixes: d9407ff11809 ("pds_core: Prevent health thread from running during reset/remove")
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/amd/pds_core/main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/amd/pds_core/main.c b/drivers/net/ethernet/amd/pds_core/main.c
index cdbf053b5376..0050c5894563 100644
--- a/drivers/net/ethernet/amd/pds_core/main.c
+++ b/drivers/net/ethernet/amd/pds_core/main.c
@@ -451,6 +451,9 @@ static void pdsc_remove(struct pci_dev *pdev)
 
 static void pdsc_stop_health_thread(struct pdsc *pdsc)
 {
+	if (pdsc->pdev->is_virtfn)
+		return;
+
 	timer_shutdown_sync(&pdsc->wdtimer);
 	if (pdsc->health_work.func)
 		cancel_work_sync(&pdsc->health_work);
@@ -458,6 +461,9 @@ static void pdsc_stop_health_thread(struct pdsc *pdsc)
 
 static void pdsc_restart_health_thread(struct pdsc *pdsc)
 {
+	if (pdsc->pdev->is_virtfn)
+		return;
+
 	timer_setup(&pdsc->wdtimer, pdsc_wdtimer_cb, 0);
 	mod_timer(&pdsc->wdtimer, jiffies + 1);
 }
-- 
2.17.1


