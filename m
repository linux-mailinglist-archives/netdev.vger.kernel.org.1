Return-Path: <netdev+bounces-24574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6110770A29
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 22:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F86B282612
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 20:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2C21DA43;
	Fri,  4 Aug 2023 20:56:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92441DA40
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 20:56:54 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A784ECA
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 13:56:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jBCQcgkP/3XrXKni/oHL1CJtmnfjK+OMMIwP5TClsA4jgFw/31PiBUnaJF1evoJuipA0lDLAln2lJHH4tSGFyvgxtZ+m62L8aaaHnXi/fpr6r8CmCdsmtltCs6Urz73fQytSw24NDl/jLDlVhzoxUbfBKKpP1rqCCyKAq++6IIBVkspvZZwjONOP8p0RPo9PA2COKMACnX7vit4hO5wooJhhBtb4ZM+ifgL8cCxZFSI8ZQ6n5keNfsDFiSC6u1EMNSEQy/8P2V8zkgQ1TAIo6yTwG1sa12G/eyRihDwR+zbIwl34mm5GdktkgOXXVAmihbyz0a+clrDZQAB7DWOV8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eGTLZ7yJpysv7EZCTbiDJ3vRrNCtpNWesdBKivLTn6U=;
 b=RZoHSuCYXN/FOypDpjwzLGGqSHL3J+mOzBuJXygRYMO5FTx+07Fv2xpCWWEB2E2pyZMwMPylrfnoWfmfnzTtJtXyuVCxuqsy7i+Iogq81f+IM8UOysfy+mgT3tj0YrOXnbHVBc78LAudHqRIMol3kFtIuGveQBe03Ipduv5I4l2YQLf2oxrrPgfd+rJtUkgVu41TKaU1D7G3V/GeL3eXCygBzuEmevKcVBe0XIAkyXpAam3HrNkNha8FoU5sbLORo+9EggLQw4xlkqnpAqcY1skkPqIGFQq+l4w/qiw9IzOnws8EAFQQjDR5N9PXSoY0DBqPLmb/HiEMTpe8Mbeezg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGTLZ7yJpysv7EZCTbiDJ3vRrNCtpNWesdBKivLTn6U=;
 b=O7Cjd8CnAAGAIWhQWNV/fPFicZQRRmWD+aQLKsbRUYRqaKmKFhHlN4WbznysP5Gdbrr6SVtJn5IpRCwhiVeilkn76PznVvecX6/bA8UnEHRIMLtbCW7TGTTTfWCmmfQfpIc0q6XXwzjdAQrz2l77sdPZolBl5mrZo5LNhaT1c2s=
Received: from MW4PR04CA0246.namprd04.prod.outlook.com (2603:10b6:303:88::11)
 by PH7PR12MB7306.namprd12.prod.outlook.com (2603:10b6:510:20a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Fri, 4 Aug
 2023 20:56:49 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:303:88:cafe::96) by MW4PR04CA0246.outlook.office365.com
 (2603:10b6:303:88::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21 via Frontend
 Transport; Fri, 4 Aug 2023 20:56:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Fri, 4 Aug 2023 20:56:48 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 15:56:47 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Nitya Sunkad
	<nitya.sunkad@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH net] ionic: Add missing err handling for queue reconfig
Date: Fri, 4 Aug 2023 13:56:22 -0700
Message-ID: <20230804205622.73306-1-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|PH7PR12MB7306:EE_
X-MS-Office365-Filtering-Correlation-Id: 11b67557-746e-4f12-f1eb-08db952d5257
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gDc//ehABy3d0qun9eIvl0/v7v4bCWs1yM1Qf+Zp5sj+xQ4Av+jdIFr6AD2GD76tl34EekOq5DtCAPFYzG0r9Vk60Ym/QkUcKszphlwtAZBL8p660WY97ZOUCX/9y0Cu2vFoFgJdjb/U7aqxbHlX6rz4On5lH0t3nius5U3GIibQSGsLBWnQJFxoerA0pfkNPomDrMCYOSg2sE/3YA8CAxRrlQfYNNUOoqUZ5Xb90XhwXEVJusISiwS/6FYMj2k3iwDLBLeZivQV3GwClKMzS2GYVkEEo1WgdeXlkD2PMzReG+J0UhQhCx7DRyXB4+lerNn7ai3rdldSY7pJTx+YAkM+PiXCi7gCjGZ6oqW05V8EpSwXZvkmKGOsMj4vVDOht44ncic5FKbI/RO/HynNhNb0KytOBZdkmXYl/2z9EOKUxzIDkfdwRxySd+5jwbPZK3MvhHK9rNkkIPMqod6m6MnKkzeF33uvprqdBHqIp8+fZHxAKAqC9we63haNJXmpsp/sTkDzkXORRQ8is9JMApadwJz992hzqq1hpyQNoNgudF/oNSs4uKTloZ+Fidlk7FgHo0G4wuuMScaXk+H5ZMwftDwcFONGi8PHsKHjVZgQwVMmjvjHyqFxRxbcyTFw3Biho3EB2AFrrPjVt3aK/rE8UD5hp5kUfnn5maMdis073y1KD99a+JHSrktvyd89kIdReZjx8kDgF7woSjB9Bs6NjMhWV6eLjC/gtrew7ZlecTX+oeRwzWWIQuik48hRnRErMWoY8PwIfE4ArA7Qpg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(82310400008)(1800799003)(451199021)(186006)(36840700001)(46966006)(40470700004)(83380400001)(82740400003)(40460700003)(16526019)(2616005)(1076003)(26005)(8676002)(47076005)(4326008)(2906002)(36860700001)(316002)(426003)(70586007)(5660300002)(70206006)(44832011)(8936002)(41300700001)(6666004)(110136005)(478600001)(40480700001)(54906003)(356005)(81166007)(36756003)(86362001)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 20:56:48.9056
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b67557-746e-4f12-f1eb-08db952d5257
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7306
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Nitya Sunkad <nitya.sunkad@amd.com>

ionic_start_queues_reconfig returns an error code if txrx_init fails.
Handle this error code in the relevant places.

This fixes a corner case where the device could get left in a detached
state if the CMB reconfig fails and the attempt to clean up the mess
also fails. Note that calling netif_device_attach when the netdev is
already attached does not lead to unexpected behavior.

Change goto name "errout" to "err_out" to maintain consistency across
goto statements.

Fixes: 40bc471dc714 ("ionic: add tx/rx-push support with device Component Memory Buffers")
Fixes: 6f7d6f0fd7a3 ("ionic: pull reset_queues into tx_timeout handler")
Signed-off-by: Nitya Sunkad <nitya.sunkad@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_lif.c   | 23 +++++++++++++------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index 612b0015dc43..432fb93aa801 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -1817,6 +1817,7 @@ static int ionic_change_mtu(struct net_device *netdev, int new_mtu)
 static void ionic_tx_timeout_work(struct work_struct *ws)
 {
 	struct ionic_lif *lif = container_of(ws, struct ionic_lif, tx_timeout_work);
+	int err;
 
 	if (test_bit(IONIC_LIF_F_FW_RESET, lif->state))
 		return;
@@ -1829,8 +1830,11 @@ static void ionic_tx_timeout_work(struct work_struct *ws)
 
 	mutex_lock(&lif->queue_lock);
 	ionic_stop_queues_reconfig(lif);
-	ionic_start_queues_reconfig(lif);
+	err = ionic_start_queues_reconfig(lif);
 	mutex_unlock(&lif->queue_lock);
+
+	if (err)
+		dev_err(lif->ionic->dev, "%s: Restarting queues failed\n", __func__);
 }
 
 static void ionic_tx_timeout(struct net_device *netdev, unsigned int txqueue)
@@ -2800,17 +2804,22 @@ static int ionic_cmb_reconfig(struct ionic_lif *lif,
 			if (err) {
 				dev_err(lif->ionic->dev,
 					"CMB restore failed: %d\n", err);
-				goto errout;
+				goto err_out;
 			}
 		}
 
-		ionic_start_queues_reconfig(lif);
-	} else {
-		/* This was detached in ionic_stop_queues_reconfig() */
-		netif_device_attach(lif->netdev);
+		err = ionic_start_queues_reconfig(lif);
+		if (err) {
+			dev_err(lif->ionic->dev,
+				"CMB reconfig failed: %d\n", err);
+			goto err_out;
+		}
 	}
 
-errout:
+err_out:
+	/* This was detached in ionic_stop_queues_reconfig() */
+	netif_device_attach(lif->netdev);
+
 	return err;
 }
 
-- 
2.17.1


