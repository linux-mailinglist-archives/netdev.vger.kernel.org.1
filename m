Return-Path: <netdev+bounces-16991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0745374FC11
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 02:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5998281737
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 00:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89558362;
	Wed, 12 Jul 2023 00:20:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740A87F2
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 00:20:56 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2088.outbound.protection.outlook.com [40.107.101.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CA4FB
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 17:20:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=boIc/GoZFTIDYn7vm2lxQ6L1AyPrQpcP3dPwZoeF4m+kxi0nVVYsClqW2XrDFgSBdp7X/dgXAfR+2eLaLD9I0hP3HaOusTXvGj2H7buIbiViTx7Bs8q4bh0yOGE/bc7znUytGWMZfw28Tboi1unNAQA0ztdFEa0kEChAgBDnvKdlKRFkO9WO+W4+p9PNAePQLAFpVo/I7E5D0+KSXBr1JOcHaXAOCpuoOTGi8Hg2pjKOLbNktHzdXgADUQo7Rsf9peNv1LNqqy3Mq8ecVNo6l1R7Q6mk0hOPFYmhSjbgjTPsniJB3WujvtquZVCKwEbq/XHnrYhjOrqghPk89f4uLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p69culPUvzbyPeOVzWaL6Zyka4UZbEMtewwAIyNc0Bg=;
 b=iqCBGF5GAsTfyfyGxbz+RTS6Qv+jUOP93kMTSlE5wm/wHkgsGtVpkYgtYz7u+YaLi6VOEmYGyTKI0awbW1bkqZarkgs5kTSzVz6aLWbcZe8xmDOx6vOKV/EQ1PIFE4yzhj7VOCf2efvWwZcYhO0TKaFOquzZa/UbvjUDcG6jCbrnZECzi4m7QUebYjUvVadE/nOvzOL0bRHPQmbbv3H/tNgnq9fxKbhxqkL7FK5U4JsWPxamK/Qvxb28bgD49uRCNU0KwgY7blruRANei4IBGlSC3ezk8pSBe5k1TPfsYX5CRR8yVJzRPez572qnBpunsRq/p5Vmlxc6PWTrpIsOAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p69culPUvzbyPeOVzWaL6Zyka4UZbEMtewwAIyNc0Bg=;
 b=tPUaHCBFafYzC4I9D+OPDFA8hXDtbQOUZYrcX6YNBuLjDccbhKeJ8DEFZXeijXyN8IZ2L72JavG00e2nYyJWJ7JTSkc3wrUHJZ9W22AHSn9D69kizdn/XTEqK1znAJAj7uPi0ykzd/evanX7vBEQQ1XRX8mldA8n8oeWiENmlMw=
Received: from BN1PR12CA0013.namprd12.prod.outlook.com (2603:10b6:408:e1::18)
 by CH2PR12MB4118.namprd12.prod.outlook.com (2603:10b6:610:a4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Wed, 12 Jul
 2023 00:20:49 +0000
Received: from BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::ee) by BN1PR12CA0013.outlook.office365.com
 (2603:10b6:408:e1::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20 via Frontend
 Transport; Wed, 12 Jul 2023 00:20:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT066.mail.protection.outlook.com (10.13.177.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.20 via Frontend Transport; Wed, 12 Jul 2023 00:20:49 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 11 Jul
 2023 19:20:48 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 4/5] ionic: pull out common bits from fw_up
Date: Tue, 11 Jul 2023 17:20:24 -0700
Message-ID: <20230712002025.24444-5-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230712002025.24444-1-shannon.nelson@amd.com>
References: <20230712002025.24444-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT066:EE_|CH2PR12MB4118:EE_
X-MS-Office365-Filtering-Correlation-Id: 4414c958-36e8-48df-0258-08db826dd837
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oZXprCJ8bhP6dj1AkcZHqnoU4msv8TGf0C8x8qwUUcVOF0iQsez7LGCWCEE57Kvuh4ydt014jNlGg8zPE1Ul9j9t4cz6KHLdnbxH7QUP7XdmvWBJSgEPz8zDZ6yf0+v6OWqgj0LvSXomAjyIqOTvUKXdoqupAOvEu49UXEjfWZ6235RWzzgnsyKILdx9UDzIFztSJGURflNA9C8G9ruv4pfkVJXGudte1D1yZcUDFAWlw+/KTlZA8pB9aryNP+s5TRgwafKUfReI6fytTZ9mHdw7v2NNWNzrWr9FT4XNflPP2mU9ukHPaBwfQ8d+GwiJ23d8Kq9NL3eGsDky3caXbJD95d3KhVmWxNJRHfP6HczKjbMFxsJMi2KFsvGaRN5/LTkT8/YkEonPAXl3T9b9hZ2JtkuAvCEzxZsUEYDigRaF35DZZ9JQIPyPPTu6kvxyCAXPnq8wgGXPlrvWjBMmkbxi/RyOhtjLjXu+xNAYJt5fW+i+QL5RNplkNoDigNfTl2kiHgb1C1g3gTacV8KJW3GL99HVoPrJ6h6j0jWJLXPQWZfJWiGiuEJhF0xuN3ICk1jwEXPzSHgvKM2PE3+6WHLwjI+CMwoUh3BcqImP9tz1S2+TRXEw553M6KTvgYflL1exz7InOiCBSjq67xGTwHP5kGbzfIgvjcxs5ZqglMeeh2Ts/ke3Bq3aU2aKguL0rKC363ohsZD7wtROXw6X871nzkgzdxJ6dWDvAVCqumCNgto8JI5NFlDgt3vNjz6Ce6Lgz/+o9M2OPHUpX/9boQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199021)(40470700004)(36840700001)(46966006)(82740400003)(356005)(81166007)(426003)(336012)(1076003)(2616005)(16526019)(47076005)(26005)(83380400001)(186003)(40480700001)(36860700001)(44832011)(8936002)(2906002)(40460700003)(8676002)(5660300002)(36756003)(70586007)(6666004)(478600001)(4326008)(70206006)(110136005)(54906003)(316002)(86362001)(41300700001)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 00:20:49.3118
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4414c958-36e8-48df-0258-08db826dd837
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4118
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Pull out some code from ionic_lif_handle_fw_up() that can be
used in the coming FLR recovery patch.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_lif.c   | 66 ++++++++++++-------
 1 file changed, 43 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index 7c20a44e549b..57ab25b9108e 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -3271,27 +3271,11 @@ static void ionic_lif_handle_fw_down(struct ionic_lif *lif)
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
@@ -3322,17 +3306,13 @@ static void ionic_lif_handle_fw_up(struct ionic_lif *lif)
 			goto err_txrx_free;
 	}
 
+	clear_bit(IONIC_LIF_F_FW_RESET, lif->state);
 	mutex_unlock(&lif->queue_lock);
 
-	clear_bit(IONIC_LIF_F_FW_RESET, lif->state);
 	ionic_link_status_check_request(lif, CAN_SLEEP);
 	netif_device_attach(lif->netdev);
-	dev_info(ionic->dev, "FW Up: LIFs restarted\n");
 
-	/* restore the hardware timestamping queues */
-	ionic_lif_hwstamp_replay(lif);
-
-	return;
+	return 0;
 
 err_txrx_free:
 	ionic_txrx_free(lif);
@@ -3342,6 +3322,46 @@ static void ionic_lif_handle_fw_up(struct ionic_lif *lif)
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


