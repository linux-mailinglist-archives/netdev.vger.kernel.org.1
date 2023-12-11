Return-Path: <netdev+bounces-56044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 396CD80DA0A
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 19:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC9F4B21957
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 18:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B929524B1;
	Mon, 11 Dec 2023 18:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iUoe/gbv"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2044.outbound.protection.outlook.com [40.107.100.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2929DB8
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 10:58:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EbgnrICXqHw5YEQvv/7cR750ko2Crto7f/wgNYIbaC8yrQM76N3GSMc7PsMxz9mjdc6B9U2CgqXeq+xCex35TeWHApUYJrNIH3AqiXrjUpsLxHX8S9GoId0+F2lO9wihGn8M8elcSoYIyeYqkvNXBNV/64IMHRbn6mKu30hQl2Fjh556gjMzyrqAKlz0hUtJOOw0cbWm1AP7wPpNMMWFZ0uxto7aoSk7NCantKHi+tMAcwdx5/YA1J/20Sg1bN914DhQkdvQ/Ze3WxJmrumBqTfS61OrAZkCgTer0/zInxPUIXSTfmYlK4k4IHtiUkvFpW8ys9+n1jloRuqZ/CI7bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KE5nQREn9eXlhvER4baks25+vrj1+2HU04+1Ev/xi6o=;
 b=H1OPXDRwzHggFW7oJmDBKZXSWdiiy6dDowCzftoTIs4jV4Wj2FKxn+ZH1Vomx6PXOzvNRNfo59IhQksThjTU3t4VaNb66+V9cqAuZIGN3mKR8tq+Hwaz3kq9l/7q+Rw3wpybF5o/0IzOty1+MHUy5Nm6yq/gGvQ0v6BOIW9BRAoSUsqiAyYYDfOnBRfcC/RmvgejdrY6KlTcvNqAcTCpKE+7ht3yhWzrmMKvE+ao8zjw0CgNP7wFX86RmSzPPdvA+aUICqSzvOSY/ecqoDu/bDIB44ddBska5eESi3nJIcaBZyzEPW/Evih4CtHJKAsqxd/bvgQhe8vgJ72XYIrPWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KE5nQREn9eXlhvER4baks25+vrj1+2HU04+1Ev/xi6o=;
 b=iUoe/gbvp1GlkKK1+IJ+Q0eNY1egO4EC66MzjR8qkPPUbTpKHG/Be1dI4bafMLVe0ljSBnY818kQvnTklaUGv+ANmEc4GOHAG8ENQWxRHFfzLtIJQZOpA0egMMtQxbCUVhZGYPSZjYAdcJ99/06juxhhpVbpNSgPdXa+ZQPLVoQ=
Received: from CH5P222CA0020.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::12)
 by MW3PR12MB4347.namprd12.prod.outlook.com (2603:10b6:303:2e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 18:58:21 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:610:1ee:cafe::68) by CH5P222CA0020.outlook.office365.com
 (2603:10b6:610:1ee::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33 via Frontend
 Transport; Mon, 11 Dec 2023 18:58:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.18 via Frontend Transport; Mon, 11 Dec 2023 18:58:21 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 11 Dec
 2023 12:58:20 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 1/8] ionic: pass opcode to devcmd_wait
Date: Mon, 11 Dec 2023 10:57:57 -0800
Message-ID: <20231211185804.18668-2-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231211185804.18668-1-shannon.nelson@amd.com>
References: <20231211185804.18668-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|MW3PR12MB4347:EE_
X-MS-Office365-Filtering-Correlation-Id: ce5f4be7-3393-429c-c763-08dbfa7b250c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wASBB9PH+YcV2HGg4wG4s0ctP1D1ymMHJS+p6gd5UWNTQWgXqh8H8XP8Bc8yAVvNpKL9c/iXz7oF9YdjgkwjIe4+EPeBhfa1n3+FQwzQfKgvU2qX/rFnwXLdfU63ar+SpYKjbHQjrl7RIjyLHqdnErvKbOOIh+vwAGJeSprlvReTmXtD4JthhC923J1BKDk0DYpeQ8T9sEArP6ey8VnNhkvEGWi7etL2S8riuEtO7rqeIg4g216O5els9D0n8CesGUN62Cm+pa8VxI7G9yKOmjyopHMroeJdrma5hzHAtml0T3d1HQziLnTgjYpOGW33XZnnRakRsrIeTyo0WKZzDNOgKDpvwH3O5zt9Jp28c5w+AvJyg1l3jcs3DgBifbeAVMsAJCMvd+ycpjDQKsg2UmS0mZjxGupp4JTyexNAJhtnz/6ivPYuE4kLi+QeH5yjOdit2FnmTmIlg7ikorMX6seOYFg+fCig5if6qzAmLNNEvi0Buqmmffj+XieXEF/Del76jpdokM22qIZAjpG3NNP9zHALOFOa4i183+8daG84EFrcMyKmaLB2QZJRhRjWJ0Xfd6PGrtuEl2eDSZmXTkr+bKlLqoaQee6eHxVPA/3GcbYt9OTcDY4mPpm+CBTaCdW6dNltJ1OEEMyaWoCHxOATvxZqmGlApD5p/Q6Yl4z/lpBF4ApTuOMPGoC6pPMJ7QQ52huLxuDDhwAhmGbENhi9Djs7/TK5HgAIpsxpqcPAojuwp25X/QCTZOTjcwH0LK1wLyVl4QT7ljb6VTU8xg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(396003)(376002)(346002)(230922051799003)(64100799003)(451199024)(82310400011)(186009)(1800799012)(46966006)(40470700004)(36840700001)(40480700001)(41300700001)(40460700003)(2906002)(44832011)(5660300002)(316002)(4326008)(8676002)(8936002)(70586007)(70206006)(54906003)(356005)(82740400003)(2616005)(86362001)(36860700001)(36756003)(110136005)(81166007)(47076005)(26005)(6666004)(478600001)(16526019)(336012)(426003)(1076003)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 18:58:21.1791
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce5f4be7-3393-429c-c763-08dbfa7b250c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4347

Don't rely on the PCI memory for the devcmd opcode because we
read a 0xff value if the PCI bus is broken, which can cause us
to report a bogus dev_cmd opcode later.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_dev.c  | 1 +
 drivers/net/ethernet/pensando/ionic/ionic_dev.h  | 1 +
 drivers/net/ethernet/pensando/ionic/ionic_main.c | 2 +-
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.c b/drivers/net/ethernet/pensando/ionic/ionic_dev.c
index bb9245d933e4..c0b347dd6bae 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.c
@@ -321,6 +321,7 @@ void ionic_dev_cmd_comp(struct ionic_dev *idev, union ionic_dev_cmd_comp *comp)
 
 void ionic_dev_cmd_go(struct ionic_dev *idev, union ionic_dev_cmd *cmd)
 {
+	idev->opcode = cmd->cmd.opcode;
 	memcpy_toio(&idev->dev_cmd_regs->cmd, cmd, sizeof(*cmd));
 	iowrite32(0, &idev->dev_cmd_regs->done);
 	iowrite32(1, &idev->dev_cmd_regs->doorbell);
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.h b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
index cee4e5c3d09a..c5a3a966aef6 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
@@ -153,6 +153,7 @@ struct ionic_dev {
 	bool fw_hb_ready;
 	bool fw_status_ready;
 	u8 fw_generation;
+	u8 opcode;
 
 	u64 __iomem *db_pages;
 	dma_addr_t phy_db_pages;
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_main.c b/drivers/net/ethernet/pensando/ionic/ionic_main.c
index 8d15f9203bd5..873a86010b27 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_main.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_main.c
@@ -443,7 +443,7 @@ static int __ionic_dev_cmd_wait(struct ionic *ionic, unsigned long max_seconds,
 	 */
 	max_wait = jiffies + (max_seconds * HZ);
 try_again:
-	opcode = readb(&idev->dev_cmd_regs->cmd.cmd.opcode);
+	opcode = idev->opcode;
 	start_time = jiffies;
 	for (fw_up = ionic_is_fw_running(idev);
 	     !done && fw_up && time_before(jiffies, max_wait);
-- 
2.17.1


