Return-Path: <netdev+bounces-85860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A12D89C9C9
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 18:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1186428A632
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 16:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802B7143890;
	Mon,  8 Apr 2024 16:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EXeTgOyK"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA651428F3
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 16:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712594160; cv=fail; b=FOtKT6xj3U2vUYP4GJiL96ZLr1UL0XW1RC9x2iT30Jv+uOH6izVGrH+igc5YX8ZQJiC7VGwX1ljqP2zjsDe9CfF4OXt+pIyrNIwpE9i5XJ86BuSMTH/Cd5jfE2e+N2yjJC0z0Npke+DDYCuXFEDvKhTaS7RfQkXJhMYnwDPhaW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712594160; c=relaxed/simple;
	bh=/uAcm8iW2m7VXkeep1uc5nKCS76TDL5MgJZmao7GzPI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sNd26I7mUMkiE8Ddq7KoSCWOwOvmP94PvnLG+fDP6APxoQgF+kMaVYNjvmzxMa7wjbWyP/jqIgf4Ia2fsisObLlv0Zk3cWC759uxVlBWF1+7Hl6Iq8YzsvbhEglvJq3a5ZWDbUKPyw2JFRe4qSWt6r5uq8MaxnKkWZXJb+kDLsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EXeTgOyK; arc=fail smtp.client-ip=40.107.223.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dqg6TND/KgBGnvPZ8WLCnffPckQFq3WnAC1k2LUwnKJH4Fz3XfrUgvxvMgFtGaUhCkQpKsgCT69Rjvan0TzosxsvooxwVINek5j9g22AnBu5XLeiSQRXwQeD9l73ONSn63DcxVIbn7E+WW2rq7Y2+c6UC/TBZYaH+P8/5ZbjQK3fJ81UIX+nAF3DimrDuzswbzs63GNPnJV8fWLA7Y6qS6LHfuabuUs59lXQpKh7BTYIvzr18mn9zGctm9OUTWUDmtZLQMyHsZ2Gg/aMgLB2x9iiA+d2RL8225SvDTVfkggTxRC4ZZtjZdmmAegoJR7SLKUXEADhy5xAfGPEXLm36A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=udhFyDH1Cy+QyQ0oOC5aQIU1JmNJb+y42HSU+Hb+JFE=;
 b=U19uFjZKdh23MwMKoYaqMXW6jD9hB4ssIW4rJJvxB7eGBe1oamd6+qVPdMBE6dM8iRDpxV0MHJA5heYCoLeYNXTsE9s7XFGURGh6uRq2P1pjiMrKKs/I1fHKdi/pji1z7+uOx/YLnApujeWE+cZgpFTcT7wRltgBPPYzWlL5xkZpuXPdfwcPfKo5SXmIigDJte1wo4itB8pfR37NhxhXnex26qv/j099KMkrbd7Yytvg/a8wcvo5wmJQNuV4vrTDADv2WMhd7LKXWVNO5XPnMOfkj62NXMvfmyzzpyQCGZPHr99OwtXItIrNi+UenjGOfWNagkrIPhpfkNaHWoTQfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udhFyDH1Cy+QyQ0oOC5aQIU1JmNJb+y42HSU+Hb+JFE=;
 b=EXeTgOyKVIy/A5ZRza/OJaEh4mpvSzaQg0+r/bJUwa8y7zifS/gipGJEF9Uh8UUHcKBdwEaGzFGnZ72IrfxvePkMvvwOcHI7BsCFpxjV+P9b4oLABRcttZHJL0QhUn095s3vh0rYGMqnPBrVQm3hNDuywfIH4OSicN5BAHJ623s=
Received: from MW4PR03CA0005.namprd03.prod.outlook.com (2603:10b6:303:8f::10)
 by PH7PR12MB7209.namprd12.prod.outlook.com (2603:10b6:510:204::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 16:35:55 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:303:8f:cafe::fe) by MW4PR03CA0005.outlook.office365.com
 (2603:10b6:303:8f::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.35 via Frontend
 Transport; Mon, 8 Apr 2024 16:35:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Mon, 8 Apr 2024 16:35:54 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 8 Apr
 2024 11:35:51 -0500
From: Brett Creeley <brett.creeley@amd.com>
To: <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>
CC: <shannon.nelson@amd.com>, <brett.creeley@amd.com>
Subject: [PATCH v2 net] pds_core: Fix pdsc_check_pci_health function to use work thread
Date: Mon, 8 Apr 2024 09:35:40 -0700
Message-ID: <20240408163540.15664-1-brett.creeley@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|PH7PR12MB7209:EE_
X-MS-Office365-Filtering-Correlation-Id: 7becc4d2-d7a7-4af9-d6b1-08dc57e9f645
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7FQ6e8Q1sk8fcoJN0LYwOlXHloaStN9a+A+Dcikn3RvnYXPMWgk6rfDscHLDfBojBq9/4Y1XCowkG/k9Mo2xP37IE8dwDnjzdj7SiTend+NhvAMXXOXU1vKPDdcN+z+XaGEvlDPVsUnlys04esota9RhkfkxRQ1ZXffyOxZzyCl/X2lsTRq2S620mnxmPk4ASMY7u+OzdS2FEnCk7bhEXGrM4xT0U3rWubW/w4KFl5hSR/8hD1yop3GFAaaACJiwNsyM+S7mwk4mS05DCPbcMriWDodEX8h1bEdK7TtJkwt4F2n+y4CyDkSw0y5wDXilAVxFhgj/dEiPKk+wBvEafpEztg40eCrMn7ae2nSJ7SnAeHVmbVkDom/Enl9kMNSWyfLM0vba9MWt7K/yfA/JX1262oM6WSO8kYT/WEnwW5iS1yCkJ7YBnrUtj/8IrYAAdO9PzfN/VPkHUvdbqW0P+ijA0lLtqMI7PlK5mh5QsG+WJN9x5E5JbMcr++DgOoxF126DP2ivYlbtvIvkJVREONFMFu+ZZVoAfXl7dcmwPUvhpECbf1/XUbGXjN8e+kjrd02K2fXL4xnM3lcggdY25K4fBlYViQ7MniPPLRjRo7ym6OjgYTa8aX/HSmp4uy1XIvm9RD3VvesT/vlgFFTr7HZqGsmQBc4BVR+mRVyqgj7R24EffREPfUYD6+/xfxPNiVIivnEbBBF+McY3us86aA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 16:35:54.8505
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7becc4d2-d7a7-4af9-d6b1-08dc57e9f645
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7209

When the driver notices fw_status == 0xff it tries to perform a PCI
reset on itself via pci_reset_function() in the context of the driver's
health thread. However, pdsc_reset_prepare calls
pdsc_stop_health_thread(), which attempts to stop/flush the health
thread. This results in a deadlock because the stop/flush will never
complete since the driver called pci_reset_function() from the health
thread context. Fix by changing the pdsc_check_pci_health_function()
to queue a newly introduced pdsc_pci_reset_thread() on the pdsc's
work queue.

Unloading the driver in the fw_down/dead state uncovered another issue,
which can be seen in the following trace:

WARNING: CPU: 51 PID: 6914 at kernel/workqueue.c:1450 __queue_work+0x358/0x440
[...]
RIP: 0010:__queue_work+0x358/0x440
[...]
Call Trace:
 <TASK>
 ? __warn+0x85/0x140
 ? __queue_work+0x358/0x440
 ? report_bug+0xfc/0x1e0
 ? handle_bug+0x3f/0x70
 ? exc_invalid_op+0x17/0x70
 ? asm_exc_invalid_op+0x1a/0x20
 ? __queue_work+0x358/0x440
 queue_work_on+0x28/0x30
 pdsc_devcmd_locked+0x96/0xe0 [pds_core]
 pdsc_devcmd_reset+0x71/0xb0 [pds_core]
 pdsc_teardown+0x51/0xe0 [pds_core]
 pdsc_remove+0x106/0x200 [pds_core]
 pci_device_remove+0x37/0xc0
 device_release_driver_internal+0xae/0x140
 driver_detach+0x48/0x90
 bus_remove_driver+0x6d/0xf0
 pci_unregister_driver+0x2e/0xa0
 pdsc_cleanup_module+0x10/0x780 [pds_core]
 __x64_sys_delete_module+0x142/0x2b0
 ? syscall_trace_enter.isra.18+0x126/0x1a0
 do_syscall_64+0x3b/0x90
 entry_SYSCALL_64_after_hwframe+0x72/0xdc
RIP: 0033:0x7fbd9d03a14b
[...]

Fix this by preventing the devcmd reset if the FW is not running.

Fixes: d9407ff11809 ("pds_core: Prevent health thread from running during reset/remove")
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
---
v2: Queue a pci reset worker on the driver workqueue to prevent the
    deadlock situation.

v1: https://lore.kernel.org/netdev/20240321063954.18711-1-brett.creeley@amd.com/

 drivers/net/ethernet/amd/pds_core/core.c | 13 ++++++++++++-
 drivers/net/ethernet/amd/pds_core/core.h |  2 ++
 drivers/net/ethernet/amd/pds_core/dev.c  |  3 +++
 drivers/net/ethernet/amd/pds_core/main.c |  1 +
 4 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
index 9662ee72814c..536635e57727 100644
--- a/drivers/net/ethernet/amd/pds_core/core.c
+++ b/drivers/net/ethernet/amd/pds_core/core.c
@@ -593,6 +593,16 @@ void pdsc_fw_up(struct pdsc *pdsc)
 	pdsc_teardown(pdsc, PDSC_TEARDOWN_RECOVERY);
 }
 
+void pdsc_pci_reset_thread(struct work_struct *work)
+{
+	struct pdsc *pdsc = container_of(work, struct pdsc, pci_reset_work);
+	struct pci_dev *pdev = pdsc->pdev;
+
+	pci_dev_get(pdev);
+	pci_reset_function(pdev);
+	pci_dev_put(pdev);
+}
+
 static void pdsc_check_pci_health(struct pdsc *pdsc)
 {
 	u8 fw_status;
@@ -607,7 +617,8 @@ static void pdsc_check_pci_health(struct pdsc *pdsc)
 	if (fw_status != PDS_RC_BAD_PCI)
 		return;
 
-	pci_reset_function(pdsc->pdev);
+	/* prevent deadlock between pdsc_reset_prepare and pdsc_health_thread */
+	queue_work(pdsc->wq, &pdsc->pci_reset_work);
 }
 
 void pdsc_health_thread(struct work_struct *work)
diff --git a/drivers/net/ethernet/amd/pds_core/core.h b/drivers/net/ethernet/amd/pds_core/core.h
index 92d7657dd614..a3e17a0c187a 100644
--- a/drivers/net/ethernet/amd/pds_core/core.h
+++ b/drivers/net/ethernet/amd/pds_core/core.h
@@ -197,6 +197,7 @@ struct pdsc {
 	struct pdsc_qcq notifyqcq;
 	u64 last_eid;
 	struct pdsc_viftype *viftype_status;
+	struct work_struct pci_reset_work;
 };
 
 /** enum pds_core_dbell_bits - bitwise composition of dbell values.
@@ -313,5 +314,6 @@ int pdsc_firmware_update(struct pdsc *pdsc, const struct firmware *fw,
 
 void pdsc_fw_down(struct pdsc *pdsc);
 void pdsc_fw_up(struct pdsc *pdsc);
+void pdsc_pci_reset_thread(struct work_struct *work);
 
 #endif /* _PDSC_H_ */
diff --git a/drivers/net/ethernet/amd/pds_core/dev.c b/drivers/net/ethernet/amd/pds_core/dev.c
index e494e1298dc9..495ef4ef8c10 100644
--- a/drivers/net/ethernet/amd/pds_core/dev.c
+++ b/drivers/net/ethernet/amd/pds_core/dev.c
@@ -229,6 +229,9 @@ int pdsc_devcmd_reset(struct pdsc *pdsc)
 		.reset.opcode = PDS_CORE_CMD_RESET,
 	};
 
+	if (!pdsc_is_fw_running(pdsc))
+		return 0;
+
 	return pdsc_devcmd(pdsc, &cmd, &comp, pdsc->devcmd_timeout);
 }
 
diff --git a/drivers/net/ethernet/amd/pds_core/main.c b/drivers/net/ethernet/amd/pds_core/main.c
index ab6133e7db42..660268ff9562 100644
--- a/drivers/net/ethernet/amd/pds_core/main.c
+++ b/drivers/net/ethernet/amd/pds_core/main.c
@@ -239,6 +239,7 @@ static int pdsc_init_pf(struct pdsc *pdsc)
 	snprintf(wq_name, sizeof(wq_name), "%s.%d", PDS_CORE_DRV_NAME, pdsc->uid);
 	pdsc->wq = create_singlethread_workqueue(wq_name);
 	INIT_WORK(&pdsc->health_work, pdsc_health_thread);
+	INIT_WORK(&pdsc->pci_reset_work, pdsc_pci_reset_thread);
 	timer_setup(&pdsc->wdtimer, pdsc_wdtimer_cb, 0);
 	pdsc->wdtimer_period = PDSC_WATCHDOG_SECS * HZ;
 
-- 
2.17.1


