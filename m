Return-Path: <netdev+bounces-30442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D846787518
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 18:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBB5F280DA3
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 16:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E57914263;
	Thu, 24 Aug 2023 16:19:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0C715485
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 16:19:29 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4F91FF2
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 09:19:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mk6jjm2iWxPE78qVZ2RaVKtp4JOdXJN4QzFxGk4GQRHKIczqo7o8Xbz1payleVCOx/nfpqwCQFZy/DSdZr8LbI4PqfP/nDxl6jaD5cu+uol66T0tVeWJm3yd3Pikq68u7hKi9n/D3h7OJFV6kCfdPu8M4xGA32h2GN6msVWKtIIr4d4ITaYqzsln++Pk67T0o2IY8TtHhsc7WvpEqCZBshJLF1vcfvQYO9qk+0H8nNFy2gORJkzlkFoks4I4C88yQxEJp5WE2CCXkpI1KQx1wiZRkEVyoXY3m3l5iO19t4zziyXCVvuj3nR9y/Tcz7Pjiv1tOiAG8gyPxgj6RWiQlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=niR3r3Gw8pojuFj35INxRgs/LRghEwUq9MSpjBp44Xs=;
 b=WO1InAO7toFg+n1HWhwf2RPQr6P5///7Lc3pD6ZpKhm9tzMjRy+sNr/lu5cdjMUUR6P0SDcKbv1FkdSEf8o1nZdR72/bvO3lpbswWkbKdo7LNaX15kGunCAJWAQAZArdyQ+UO4QjxFebwBYLoj5vsILIw2hYSHaTsgz3gW4MaqGcTlplVcR5SU5MnW5+Oktka4zqO6sPrEnbCgThjmg40cOXI/f9GofEwvJjThiizoqcqrEUjO5llSHoPwVrriwY65Lpbg3VllQ5TExLWi7IAtiP/I0oJL1k3dBUzLTdDfTg4LUzh0+1AaQRNOEI4NlNfwyVTvmxvyPfIRTASw8fPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=niR3r3Gw8pojuFj35INxRgs/LRghEwUq9MSpjBp44Xs=;
 b=RT2fTaPN1MiGLcDU3aWc7eIQLUV9TVQLnVzZ8gFnob252BPTs+FwcsYgCgKZHKtuURIGC55CO+DhJpLn0y1hYFI4C1Zl8yH9TS52x2xxt64yeG4L7DOogvyrwfQXnPVjSSGBmleHdad5pH3X7Blsj47tq17ytv3632LGqiRGhbo=
Received: from SA9PR13CA0047.namprd13.prod.outlook.com (2603:10b6:806:22::22)
 by BL1PR12MB5900.namprd12.prod.outlook.com (2603:10b6:208:398::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Thu, 24 Aug
 2023 16:18:23 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:806:22:cafe::bb) by SA9PR13CA0047.outlook.office365.com
 (2603:10b6:806:22::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6723.17 via Frontend
 Transport; Thu, 24 Aug 2023 16:18:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 24 Aug 2023 16:18:23 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 11:18:22 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <shannon.nelson@amd.com>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<netdev@vger.kernel.org>, <kuba@kernel.org>
CC: <drivers@pensando.io>
Subject: [PATCH net 2/5] pds_core: no health reporter in VF
Date: Thu, 24 Aug 2023 09:17:51 -0700
Message-ID: <20230824161754.34264-3-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230824161754.34264-1-shannon.nelson@amd.com>
References: <20230824161754.34264-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|BL1PR12MB5900:EE_
X-MS-Office365-Filtering-Correlation-Id: c4afe625-c426-4b1c-07c7-08dba4bdbd2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kJNgHuvMQWTMB51VJmVXpUtHpiG89o8ixH5OuJYStCVWj9kBAGXSKsBRSyH2ohUtov3d9tPnGHH5LOBGQMyihj7cv/2Gg+AghDLHQjVAM8W06h52OPokxII6Zs0so6OGIlAIfgWzHFVW71z4QHVo2tvIUPQDhFeEws2wmnFhCKgKHMhKkr6qpsQLjZeHaIxX9TjAIHTCOGofefJqRc/UfJkWjsBywV+gCTemekclAecNpsgx0WzEpjgemA8apb1jzVbMFj8Iu2WhF+FDTF4jrjmgzaflPO3HZfQqFIi9fp0R9S2fWEHNbrVHs0dFarmWQVISdr91XfEAXIR+/uM7zOqvXjJVwn7PgX/BuJnEB008Qx/4ry5y5uDlS7DDfUo98P4thX+Gv70+LzOw1nPVcVteG9GDnHhKMp4tEl+qjXGCJLjQdURrYCvZ1ge7FwWzkZqOk3gjUuZId2TDJdVOxsG3EWQeQFnMhPEjgdsXyb8hC6Q3jdueKbfNFfGJDCXZXn96A2uLEoF8nGhuzci/wyMSMSuUk86bUBzv33mRHAWcqb8FQxTJwKFQxzG0y/zjX+vjIrEjipCmp9PitgNwe2YY6TV89A/gC8sp+4HhExSH4NStvKjwA41R/yzJiZsQ0/c0wadju6HT/P97P2eBOf41BjtKVfNI3oGRhZWOHtwZz4f+kDbaRUACeZ6hc5uG+PoMx/qG2aWJzb1b0RVKe7CmnzkrV7V6uU8kBGTcp5QQP37VWtc1o9MPkRlwm+YX19uE98VMThIO3A2Hvhl6BQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(136003)(346002)(376002)(82310400011)(186009)(1800799009)(451199024)(36840700001)(46966006)(40470700004)(6666004)(40460700003)(83380400001)(336012)(426003)(82740400003)(356005)(86362001)(81166007)(36860700001)(36756003)(47076005)(40480700001)(26005)(16526019)(2906002)(2616005)(70206006)(70586007)(316002)(41300700001)(110136005)(5660300002)(44832011)(8676002)(8936002)(4326008)(1076003)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 16:18:23.1179
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4afe625-c426-4b1c-07c7-08dba4bdbd2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5900
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Make sure the health reporter is set up before we use it in
our devlink health updates, especially since the VF doesn't
set up the health reporter.

Fixes: 25b450c05a49 ("pds_core: add devlink health facilities")
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
---
 drivers/net/ethernet/amd/pds_core/core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
index f2c79456d745..383e3311a52c 100644
--- a/drivers/net/ethernet/amd/pds_core/core.c
+++ b/drivers/net/ethernet/amd/pds_core/core.c
@@ -524,7 +524,8 @@ static void pdsc_fw_down(struct pdsc *pdsc)
 	}
 
 	/* Notify clients of fw_down */
-	devlink_health_report(pdsc->fw_reporter, "FW down reported", pdsc);
+	if (pdsc->fw_reporter)
+		devlink_health_report(pdsc->fw_reporter, "FW down reported", pdsc);
 	pdsc_notify(PDS_EVENT_RESET, &reset_event);
 
 	pdsc_stop(pdsc);
@@ -554,8 +555,9 @@ static void pdsc_fw_up(struct pdsc *pdsc)
 
 	/* Notify clients of fw_up */
 	pdsc->fw_recoveries++;
-	devlink_health_reporter_state_update(pdsc->fw_reporter,
-					     DEVLINK_HEALTH_REPORTER_STATE_HEALTHY);
+	if (pdsc->fw_reporter)
+		devlink_health_reporter_state_update(pdsc->fw_reporter,
+						     DEVLINK_HEALTH_REPORTER_STATE_HEALTHY);
 	pdsc_notify(PDS_EVENT_RESET, &reset_event);
 
 	return;
-- 
2.17.1


