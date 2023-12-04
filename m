Return-Path: <netdev+bounces-53667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9D38040C6
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 22:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CF621C20A8F
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 21:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D31364A0;
	Mon,  4 Dec 2023 21:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qhvJVfRR"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5871890
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 13:10:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CkONP+HXjkF5TnMRlMNyN4rKA9V0UYHBPwfN8h61PdULqrMU/kpnIFEEjDcXvtfox1CnKCYInRk1tZcNgqCS3QzjTHUmlbIDOBP7Pvz8dLgQkKdqpwvzG1UO5YzXCC64umkyboJrUO0ooNVYtEsh5GGXyGzdnt7k3HA2OCHvSS8W7fKy1nGMlv1NbFTwBBbwu0qXBJl+wPm2aL+LBVbA/QwIpygxP0eHQlBg+rCxJxTn1DqCTcZEpiWPBfnjpl3liUB9E6kqxUYZ6Z0kG6qdMRpuXCW5Lz/Z2rY51zt6gLtDEvybsNKi6+vgdEstF6HrjLG0P66MyvZcRsDJk030+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1JhT6TBIM5UBKheqpw3w6KqUi1PumLz+nfmrzz+mIJQ=;
 b=nEgrR+tKK5Sx/k2I54mDOoFsM50JPWKGqNyVgEI/hzX468rhC/kfTHVJclObeF4UOY7DsVxK9G+SJCnms6s2f++XOUj3VPyUAdiSvSOK8QVo7qa2UvMgozChFA6pGtiLqZeQKXUx9sBH1XNVnqiJj6rzIkS3yUYBZElc2zAIqkACzwT1aAWhPF9HUULqxiEN+g/jSFd5fRjaK0ClVB34Yhajc/Bgg1f7gopYftdGN/8RUqotRQKSPAfVGeSjPVjUJFincJRhJO294waq6x7oy/pYkMEhXv79I9DhEseqqUrY4srnHgd8WGPXxpg8PCDfg3PwMgMsf+prVr/sjObFUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1JhT6TBIM5UBKheqpw3w6KqUi1PumLz+nfmrzz+mIJQ=;
 b=qhvJVfRRLBMTBqZuc7G0zY02oaq4VcQcGxpe0QO2Cz/VDAfeIfMav8onNVnmRGbrxbHyCIFLEsCR0mnAwh7gRkZOIJO+P61pun6A5w1bySbnC9gFYk1zEJRj3UqFPBsAXPgC+8+KUMWX8pY1vCmxfH29du4AVpyUyWf+Eeg2cZw=
Received: from SJ0PR03CA0361.namprd03.prod.outlook.com (2603:10b6:a03:3a1::6)
 by MN2PR12MB4286.namprd12.prod.outlook.com (2603:10b6:208:199::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 21:10:04 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::1b) by SJ0PR03CA0361.outlook.office365.com
 (2603:10b6:a03:3a1::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33 via Frontend
 Transport; Mon, 4 Dec 2023 21:10:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Mon, 4 Dec 2023 21:10:03 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 4 Dec
 2023 15:10:00 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <f.fainelli@gmail.com>, <brett.creeley@amd.com>, <drivers@pensando.io>,
	Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH net-next 2/5] ionic: set ionic ptr before setting up ethtool ops
Date: Mon, 4 Dec 2023 13:09:33 -0800
Message-ID: <20231204210936.16587-3-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231204210936.16587-1-shannon.nelson@amd.com>
References: <20231204210936.16587-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|MN2PR12MB4286:EE_
X-MS-Office365-Filtering-Correlation-Id: 452219d6-a42a-4250-c9c5-08dbf50d6224
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	69iP4dYrSpGlFThp6PoKAOpj4zHUEEUisfAril4O9Nlp26QAlenyZ7Sw1t1LCjRt2bnTM3tLyhJMxsdS1mQCgBm5wQ2NCBFsUWI+LUKcGUcJxz6B7r4csvN+29vEBcFYSNPXvcrHmAOClRA/tgjNZHRqACuYXUVdIr0qeFlbkGWg+pTZdhlXvlTA7MItDEU6amFKhxSF33QyvKBvXZvS6SpDBa2b5v4JehvhGZqkdKvlbLzHZgonc2UXnCos4coETLjUEZz+Kk1WE2CSAbQrLoDGTlKITpvJpv7jOPaghOHNbkPKq7c5qizYjhpRpS85/Y2GKG14/2+Wd/WESjzvs5lAKWPBXXAaihIeQQZGJgbEqbzwnakTKCnnI2Ha+GCkY/d+PgGaToRxdKVd0dQEOv1WiV8gia4BxX0CbNeWxVNWpJFH1Ui3EA0g9dbnDu47i1GK2cgtITQMP96UI92DS/52eE98ff5nK+Vb/095adAtMwUsx+rDlBBe2aNfRWq6Ce5/gAX85PBmB15pqk6mlPHByF2dXS1wwueyGLCU/NHw7wBAo+bGdvLmrY80KdhS1Q4RowFhV9r418/FArajTiKhYcw2ylrXLOo3EOEdO3RMviH1MZ5j8VmeMq+vB7JLTOJUY9QHfmIRowZT4xJKryzf0wu6wgd7v1P2LS5ok8IC4ojX1pcGnl7LUB70bV1IvP+EUqLdSo46UPv4CTumc2V5GsAHQD2tm63RVvMpezatGWL58VJtFZ3GtOiPvWJb4+vBiWruBLOChEFQ0byl7w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39860400002)(346002)(376002)(230922051799003)(451199024)(64100799003)(186009)(82310400011)(1800799012)(36840700001)(40470700004)(46966006)(5660300002)(40460700003)(44832011)(86362001)(4326008)(8676002)(8936002)(2906002)(41300700001)(36756003)(2616005)(40480700001)(1076003)(426003)(81166007)(356005)(82740400003)(83380400001)(16526019)(478600001)(336012)(26005)(6666004)(47076005)(36860700001)(110136005)(316002)(54906003)(70586007)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 21:10:03.1296
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 452219d6-a42a-4250-c9c5-08dbf50d6224
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4286

Set the lif->ionic value that is used in some ethtool callbacks
before setting ethtool ops.  There really shouldn't be any
race issues before this change since the netdev hasn't been
registered yet, but this seems more correct.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_lif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index afb77e2d04c5..a5e6b1e2f5ee 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -3054,6 +3054,7 @@ int ionic_lif_alloc(struct ionic *ionic)
 	lif = netdev_priv(netdev);
 	lif->netdev = netdev;
 	ionic->lif = lif;
+	lif->ionic = ionic;
 	netdev->netdev_ops = &ionic_netdev_ops;
 	ionic_ethtool_set_ops(netdev);
 
@@ -3076,7 +3077,6 @@ int ionic_lif_alloc(struct ionic *ionic)
 	lif->neqs = ionic->neqs_per_lif;
 	lif->nxqs = ionic->ntxqs_per_lif;
 
-	lif->ionic = ionic;
 	lif->index = 0;
 
 	if (is_kdump_kernel()) {
-- 
2.17.1


