Return-Path: <netdev+bounces-19626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDFD75B788
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 21:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EF961C21508
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 19:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C951BE67;
	Thu, 20 Jul 2023 19:08:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F721BE61
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 19:08:47 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B973E75
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 12:08:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MAkWVEaPl8UbHgUplWq744Mrd08RAc7JQmzg5xcDWXvuMpXlsi9JwC+/+iKWgTH0MdsoPVo4gS8TTVCa2OG4h1IhS+xk6DAb0uyIXIK3PV/Ky8ZnNajB7igL7toaqCcl+/C2I7NX7m7L5vHnthGpM+QPT//5XJ7xndxEwIv05ull6YgroKZmRnaZBH3MTrD56FKeGlxOV9dfxQ2yKZPQSL/8IccojGMxctfjaHK8VUStLRhk8CO8kGS/oAjlgCHJwn0RAiWgNYmIbt05CGRh+ZnvH4n2mYna6Yu0BT+RWZSCRAPffz1SXoMOfyLLgJih1MP1aYqb7+EONcp3daUJUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rWsuFpSKKhWHboZt7i1sp8iS/R9/5py/M4I2ag/aK8g=;
 b=cakPNBE9MycClkkPeF3kqsRwWSO6WWrA4EtYru6i6WyHhSXCKACNIdbKfZVj8TtVINY23gaZgDJ2IoZDXicPWoZAAYQ8rwbOEi0xXIIQgJsAKNXAzUgWFr68c3jRhDmXp6xlJbKIA3btKAtku7jpyIXhlONWFKVHaclU37wdBG/6c82rzdaMe+qgPEfYIONuzxXhv5+1wArl7VcnVGXkJp0iqUjtJ+vIPpPFbVrlTDc+Vk1Hj+HSPNo/WT/GzBYJ25aZSqkrwRZpbIm1U1gvy/1rSoqzTTL/OsY7eG3p0vPss38I+WGt/0m/qLGqbIYbxLZeOtWI1OGNjP9Kx41rHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWsuFpSKKhWHboZt7i1sp8iS/R9/5py/M4I2ag/aK8g=;
 b=PEYMe+YL1DQagrVO8ZUXvnc+B/FHlrAiq2GPF/o6uYz4LOSgQQz7dpkAHpgVdFqHCzip6koka9/1DTD870Wyr9md4wuqshBjpSkWBdWTX7DDE3myJevN38yxbnFP1dx9AbWCcpkjB3fA4q4WL3fCoyOL+3ARR0SQO7UrzLUIIcE=
Received: from DS7PR03CA0069.namprd03.prod.outlook.com (2603:10b6:5:3bb::14)
 by IA1PR12MB6066.namprd12.prod.outlook.com (2603:10b6:208:3ee::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Thu, 20 Jul
 2023 19:08:42 +0000
Received: from DM6NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::84) by DS7PR03CA0069.outlook.office365.com
 (2603:10b6:5:3bb::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28 via Frontend
 Transport; Thu, 20 Jul 2023 19:08:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT089.mail.protection.outlook.com (10.13.173.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.34 via Frontend Transport; Thu, 20 Jul 2023 19:08:40 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 20 Jul
 2023 14:08:38 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<simon.horman@corigine.com>, <idosch@idosch.org>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH v4 net-next 3/4] ionic: pull out common bits from fw_up
Date: Thu, 20 Jul 2023 12:08:15 -0700
Message-ID: <20230720190816.15577-4-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230720190816.15577-1-shannon.nelson@amd.com>
References: <20230720190816.15577-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT089:EE_|IA1PR12MB6066:EE_
X-MS-Office365-Filtering-Correlation-Id: aa1ef2e2-8fe0-412a-51f3-08db8954ba93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LSqy9gU6xradepiD0dugHcvorchWXVNjEcxUjKGUcGfkool8NHP+NiEc7Z7a4FYUAtQJfJjnrq1IUv5bh5Gpy8PsXW8SHziVc7BQf3ZQyqjq38wY8M//Zz9AKPcnPUL2DMVNLqQckGiUiH1Ehq/h8mGhhlCGWCI803Aw8DAvO+fs6FV8MM83QSqxqnGwFHb7W/hSwxN5ueQlkuicNBkx2yrqRigXcbJGPfp7g3V7T1ZAHMk8yLrDU4wEl6ZMUn3Hon0l2Y+6zfPKRW9upijnqNSmaJ1XSET2WuV7kS3RqwDAUQNK0Q0gOi2ePg/xUA2oAebF6adthQQdQ3MNegqVvPNegQmyNr952OSYC8LYBJ/jb+zFTV4LJ2co7hW7geVRXtFUqDC3fV/U/qNVlmG311l7E7tR/gzNZBpvq+oRn3oKqqw1OfBWkcwsCK3BLMCMQRvwe9VyTO0Kkg7L2LpKQ/+TgJP4lwLjLNZ8CwFHaTmESng7HNQ3Xl3ASJ4/Ci57KiIXLxY9BI+nQBuxoBMmEz+4DPwLRSnKF7zKu67lB2O98F9jTug7TNWRjm1GSPz3av0S8irxsC2AEYCcTYejQd7fbM8c5+oPvvQDDLThx/Ib7eXHH0P6GBWoCi75a4Vw+pJsmLIMMMfa7fHi4IxHr4rdYWZ6o8QdM2JL3FdCoDf5ktnAJneffIL2cFZtxLQNzhS4f03KN8nWQE5AZggRY2+Cozf6ZnQVRaoZy6QMaGPUWUac0KMIFkCzHxc7aBlyeaxfnSmfry2/mBK43RHmPw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(346002)(136003)(82310400008)(451199021)(36840700001)(46966006)(40470700004)(2906002)(36860700001)(83380400001)(40460700003)(2616005)(426003)(47076005)(356005)(81166007)(86362001)(36756003)(82740400003)(40480700001)(316002)(4326008)(70586007)(70206006)(336012)(26005)(1076003)(186003)(16526019)(41300700001)(110136005)(478600001)(6666004)(54906003)(8936002)(44832011)(8676002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 19:08:40.2751
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa1ef2e2-8fe0-412a-51f3-08db8954ba93
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6066
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Pull out some code from ionic_lif_handle_fw_up() that can be
used in the coming FLR recovery patch.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_lif.c   | 64 ++++++++++++-------
 1 file changed, 42 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index 612b0015dc43..2d03c1b995bc 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -3266,27 +3266,11 @@ static void ionic_lif_handle_fw_down(struct ionic_lif *lif)
 	dev_info(ionic->dev, "FW Down: LIFs stopped\n");
 }
 
-static void ionic_lif_handle_fw_up(struct ionic_lif *lif)
+static int ionic_restart_lif(struct ionic_lif *lif)
 {
 	struct ionic *ionic = lif->ionic;
 	int err;
 
-	if (!test_bit(IONIC_LIF_F_FW_RESET, lif->state))
-		return;
-
-	dev_info(ionic->dev, "FW Up: restarting LIFs\n");
-
-	ionic_init_devinfo(ionic);
-	err = ionic_identify(ionic);
-	if (err)
-		goto err_out;
-	err = ionic_port_identify(ionic);
-	if (err)
-		goto err_out;
-	err = ionic_port_init(ionic);
-	if (err)
-		goto err_out;
-
 	mutex_lock(&lif->queue_lock);
 
 	if (test_and_clear_bit(IONIC_LIF_F_BROKEN, lif->state))
@@ -3322,12 +3306,8 @@ static void ionic_lif_handle_fw_up(struct ionic_lif *lif)
 	clear_bit(IONIC_LIF_F_FW_RESET, lif->state);
 	ionic_link_status_check_request(lif, CAN_SLEEP);
 	netif_device_attach(lif->netdev);
-	dev_info(ionic->dev, "FW Up: LIFs restarted\n");
-
-	/* restore the hardware timestamping queues */
-	ionic_lif_hwstamp_replay(lif);
 
-	return;
+	return 0;
 
 err_txrx_free:
 	ionic_txrx_free(lif);
@@ -3337,6 +3317,46 @@ static void ionic_lif_handle_fw_up(struct ionic_lif *lif)
 	ionic_qcqs_free(lif);
 err_unlock:
 	mutex_unlock(&lif->queue_lock);
+
+	return err;
+}
+
+static void ionic_lif_handle_fw_up(struct ionic_lif *lif)
+{
+	struct ionic *ionic = lif->ionic;
+	int err;
+
+	if (!test_bit(IONIC_LIF_F_FW_RESET, lif->state))
+		return;
+
+	dev_info(ionic->dev, "FW Up: restarting LIFs\n");
+
+	/* This is a little different from what happens at
+	 * probe time because the LIF already exists so we
+	 * just need to reanimate it.
+	 */
+	ionic_init_devinfo(ionic);
+	err = ionic_identify(ionic);
+	if (err)
+		goto err_out;
+	err = ionic_port_identify(ionic);
+	if (err)
+		goto err_out;
+	err = ionic_port_init(ionic);
+	if (err)
+		goto err_out;
+
+	err = ionic_restart_lif(lif);
+	if (err)
+		goto err_out;
+
+	dev_info(ionic->dev, "FW Up: LIFs restarted\n");
+
+	/* restore the hardware timestamping queues */
+	ionic_lif_hwstamp_replay(lif);
+
+	return;
+
 err_out:
 	dev_err(ionic->dev, "FW Up: LIFs restart failed - err %d\n", err);
 }
-- 
2.17.1


