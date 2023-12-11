Return-Path: <netdev+bounces-56051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8814A80DA17
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 19:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 926E0B218A6
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 18:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233EA537F7;
	Mon, 11 Dec 2023 18:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NSlHwU6H"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4769DB
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 10:58:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PNwKgkj2vIwR1Bw0U/7ZJPv2IZxwVb7CTxyT0NIL4pS8QoLYpgg52t5cVzpKdNhbWvf4cAl0IbBKX4ZpR6mDI/tSn9NmFJCzH/xosqFSzw7iYJ92B5snYqJjBxi6/eYvafqEK/hu9SorGS46piuY4GXTZzvFuRLzjkc2E6VU9DSOBznmDbv2DIMOCWMOKJj4slHUDukM+IqXHUfmVvbjzzGv8Gx7pbwz6iqlz9j+K0WqkdiTN4r5jOBTy38/AjZtR3+1NaL3/mJtaz+F0r4IiaNL3YwfVBXGhvT+YMrYqpcVuvqaJ3zyvlbeRNbdJYkH8l52zGA97pJs4zlMer2NSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9zJLb1MeZEmq22+DwtJXUd5sfLp66UlF2tspdckrzeQ=;
 b=PxkphozNcKO38i+E9OZ3MLf9poa5hrlRO4AiuhFVoAQ3q0AUJFQvjSDOZwtQiv5HhG3lAG9ZM5JS5JXbA0Hs0YjW8z21ImLZt0krlEhXHCGSoNXbc8X7rJQuM2ZDnRs+8Px2yOfDjrsRZzgq9eRxpY02yjCKiKCPAGHmKxSe5tUwW9oNEYv9HhCKVuOSiHdt2v89WKzTV8ciizvEBAlZff9ktRJumGEaXKAVQZb9FGSoq+Xz2iyH3vAQ3VCwDtTNsyXKcv3RIAsLkm9eb24moxtJukI0LAR92+hAedjnZNmK0MVrDWg7lVKyHSGr+zZsydTK8YSd/lPE9aLVkfstyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zJLb1MeZEmq22+DwtJXUd5sfLp66UlF2tspdckrzeQ=;
 b=NSlHwU6HDki9h71bkLWXCZf1QsQ2yigG3hTylvJfnZLLFu9D/sRvG6BLyZ8lkOoQOWPfSoj1cMEdqYpoS2mNz3HZit0obHC/2iDY71U3fmX2ymJ2Np+1f5WRjKAxdnE+OhZ4mK9OPpuIMEQhCP9/MuMnYFho1OEf86aEi7G/oIo=
Received: from CH5P222CA0009.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::25)
 by MN2PR12MB4333.namprd12.prod.outlook.com (2603:10b6:208:1d3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 18:58:29 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:610:1ee:cafe::a8) by CH5P222CA0009.outlook.office365.com
 (2603:10b6:610:1ee::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32 via Frontend
 Transport; Mon, 11 Dec 2023 18:58:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.18 via Frontend Transport; Mon, 11 Dec 2023 18:58:28 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 11 Dec
 2023 12:58:26 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 8/8] ionic: fill out pci error handlers
Date: Mon, 11 Dec 2023 10:58:04 -0800
Message-ID: <20231211185804.18668-9-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|MN2PR12MB4333:EE_
X-MS-Office365-Filtering-Correlation-Id: ae16e821-8246-46f6-0607-08dbfa7b299d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bho4lzy2aH+3CmqrDGgdDFFV/IqUVz0iG54E4375JJTCrvCpaxJDG9vxSerKwx2z1HFNtbBCHYrbHDlVnU1S3g2DFTW+PM6fHOl/lz0sWf212Bz1R/EqsnSwgVrX54rHB0OFZQTqL76ngMnVsVr2cOeJKPabMlfM5vYTE6IOgp/Z4XRDJ6rMRwfwNf+3EprrVcuQUyeB1lB/EBi7uOfHJcjW/UkdcIen4M37j4omRIoZAGl4B3/yjywXdFnwJHo10ZqO/syai7hW+bzZtcZTFK2x15ovkI7oeRkv1UTE99Sjg1cP/dBnEV4vPHTa1DKOiDbfN7GWZOA/6Qkfj8RlzsMzAHfMm8SDHh/0bjuM1RwJXYooR4hTcZEx3NWLyjruOUMUTokVjanmatYPomYRR7BaOHFFE29J3r316h3d4QcxDrcMb4ojtkP/qXfZK/SzC68B6R1AMrodI0RNEdaNbS9P2fj02f7TnCLIqDrk4QX558Z0wsXGtNy/Ax+nwg2QrlyAuySoxGAtIaODWo0EryfDGs5IJFgxIsVUv6IIMAkbcsk93wtXfHHJWz6vUjZCBPF7klsDvMoLYnhPAfwjlFGp8OPp4vL5M8jovltFv7kvPnBmklbDaD1DHTgDBNXkeMus20sYAPYAOy0nqAM1x8fmCetHW2OMH3BhrXpg4NP9XOW2oL56vb+Rlzbp6I/zB8NTl8wfY/SYv/Fo1pgStd+XhFClfm79nzDeQw9pt5GXf7d11qijjnbqzS7qLUuEK4u8EHtuW0jAhPy4g+aXQQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(39860400002)(346002)(136003)(230922051799003)(186009)(1800799012)(82310400011)(64100799003)(451199024)(46966006)(36840700001)(40470700004)(40460700003)(2906002)(41300700001)(36860700001)(110136005)(36756003)(86362001)(356005)(82740400003)(2616005)(81166007)(1076003)(83380400001)(336012)(426003)(16526019)(26005)(478600001)(47076005)(6666004)(4326008)(5660300002)(44832011)(316002)(70586007)(54906003)(70206006)(8936002)(8676002)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 18:58:28.8353
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae16e821-8246-46f6-0607-08dbfa7b299d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4333

Set up the pci_error_handlers error_detected and resume to be useful in
handling AER events.  If the error detected is pci_channel_io_frozen we
set up to do an FLR at the end of the AER handling - this tends to clear
things up well enough that traffic can continue.  Else, let the AER/PCI
machinery do what is needed for the less serious errors seen.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
---
 .../ethernet/pensando/ionic/ionic_bus_pci.c   | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
index 60e64ef043af..c49aa358e424 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
@@ -469,10 +469,35 @@ static void ionic_reset_done(struct pci_dev *pdev)
 		__func__, err ? "failed" : "done");
 }
 
+static pci_ers_result_t ionic_pci_error_detected(struct pci_dev *pdev,
+						 pci_channel_state_t error)
+{
+	if (error == pci_channel_io_frozen) {
+		ionic_reset_prepare(pdev);
+		return PCI_ERS_RESULT_NEED_RESET;
+	}
+
+	return PCI_ERS_RESULT_NONE;
+}
+
+static void ionic_pci_error_resume(struct pci_dev *pdev)
+{
+	struct ionic *ionic = pci_get_drvdata(pdev);
+	struct ionic_lif *lif = ionic->lif;
+
+	if (lif && test_bit(IONIC_LIF_F_FW_RESET, lif->state))
+		pci_reset_function_locked(pdev);
+}
+
 static const struct pci_error_handlers ionic_err_handler = {
 	/* FLR handling */
 	.reset_prepare      = ionic_reset_prepare,
 	.reset_done         = ionic_reset_done,
+
+	/* PCI bus error detected on this device */
+	.error_detected     = ionic_pci_error_detected,
+	.resume		    = ionic_pci_error_resume,
+
 };
 
 static struct pci_driver ionic_driver = {
-- 
2.17.1


