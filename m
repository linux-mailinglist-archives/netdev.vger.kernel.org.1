Return-Path: <netdev+bounces-18368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C98A7569CB
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 19:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D42A1C20B5E
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 17:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF02BA4F;
	Mon, 17 Jul 2023 17:01:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9FABE57
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 17:01:23 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061e.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::61e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1FCF7
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 10:01:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kzo5w3u7LnZ9g4KMGuHIu+L7ttNGSTwj20mfZjGM+jgwD40LNZUQgv4foIa+sg1oN38JYLrr2dMFPJgJVZS1xznalDPuCaqUfl2VAXc3I8Hkz90Md33pRHBAMAyF3Qzfbp8FbxcSN4n1qv8OaKN39AAOYFS+bqe7TU5tdlAHY9BHmOhc9XuUNk3y4ANLgUFnGFOaIIaQyZ+tS4mbMF9uTNLGG1WYQCwfWcPp45fAcUqSX9naZ1gzxP3qRLGKhkr+wyppWQamJeiWjitmmjtjh6TU3w0Zt6Z+7YDZmdTQjC7OTxmjQj05Azd0A3xmFa3UYVPWVZwEahblXWg7XjTfBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iI8OnGXBlH4qKmwk9YCKeJJ6M3Fn4PPmJo6gYQb6X4I=;
 b=Tpj8x+NrP5czRRohuVoJ5Lji+r+pI4n64DcbTFkKqOFn2UP34TGB4IrD/5MCVfz0puDL9XxEJ+J03mcbsN3gHy/t3ZMwy0ZK+qxuikJX6KjGsdOHLHNwXJg36R4l+rD4IIa/XtQJeF9G8VwhHHpsruHwYojjUSOs5Z0R7vInzAJFeVYtYJRq6XI2AhuDpudFJUS4xd1ITyQthHLcMZ2YZ8ARP0jj3lwU+49be7lEYSfxV2XTvnYTqLiXpNkGirOcx0Y+3AesgzR9+L+M/7NeyGZil5VPIIqRBsOKfRis9rOl9dehsuVRWsAsEHS7NfGg01jlHGjS/s8s6xgyjtS4Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iI8OnGXBlH4qKmwk9YCKeJJ6M3Fn4PPmJo6gYQb6X4I=;
 b=lCoNNYqKC9KHsDbEIuBW8umf8oiAXTVkg94YfgqmPiYyb3+CJ4knofvYZ+bPPAyLq6vrzjbTo0oU/u1bidIVHclN/xfGiPfPBJnyQJaB5ymidvmNJrNV5X+qM77IPNMQ1IZkNIWP/P0WGUvks0xKe0eLYd7QCGfyFIk+BFIDmek=
Received: from MW4PR03CA0298.namprd03.prod.outlook.com (2603:10b6:303:b5::33)
 by DM3PR12MB9327.namprd12.prod.outlook.com (2603:10b6:0:42::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 17:01:16 +0000
Received: from CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::97) by MW4PR03CA0298.outlook.office365.com
 (2603:10b6:303:b5::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Mon, 17 Jul 2023 17:01:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT057.mail.protection.outlook.com (10.13.174.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.33 via Frontend Transport; Mon, 17 Jul 2023 17:01:16 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 17 Jul
 2023 12:01:14 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<idosch@idosch.org>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH v3  net-next 3/4] ionic: pull out common bits from fw_up
Date: Mon, 17 Jul 2023 10:00:00 -0700
Message-ID: <20230717170001.30539-4-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230717170001.30539-1-shannon.nelson@amd.com>
References: <20230717170001.30539-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT057:EE_|DM3PR12MB9327:EE_
X-MS-Office365-Filtering-Correlation-Id: be3dbfa0-6975-4d34-6f33-08db86e76f5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gMRjib8zIp96Q7LUM1WVG/lOvu+De3VvUmxktFK6+JoouDQSzUmLRDY7HcUlTMCQxhlF1kOodq6jZB9yF+yNReSFNKD2RIPaK0JhJmssX5P0mz2vt//Jyz2X5dQwgiP8DElfcAWVqb43WlGgOuVujXq4ctiMpGQCklqMq3N8wxS3YJ16OSjcMeBKpP2hysSuyTS/dqbpwbaHBFgusUmOo2iJw2+XWEeXehhq4JDR8RAfxoVTbUKamVSwOHQJFRm0R5m+zztkYB2d+A8i2b3VTXi9OgyfUsCY9/+5C6gIBXKih0HSLmdo5552jW5rqrGb8JT3weIRxV440zgz9njsI0PfDDZnj9S1ze2IVXvteh4y7ownpbVTvTSlPFxXTaX8f0UvouxqWdQOYyrhbT/ziKuuZJHF4YKhdAWV9hc/wLi+Sxqi6ulEbtFStd9cWBwVkNIV+mA8n8KD81V/+l9ztJ+KVEkXNWT1Dl7XsXinVQRGZwgP3MLbNSO+Z8cUPS0uVU/PK+XpaQh3r4YPHzSAC6iWMOAKasY4WkKG/x+6vUv84U+NG1Va+GLvUNY7VmBT4TcGNgz9XaglQxK1Wa8vWvkDx+SCn62mgbK8fpG2jjkqgaXYDB67tFpyRW46aKJvzBgw2OuxwLEqLAsyIOgWAqxq//IxKlK/rmrFaHfSJjl1CXNnUj6Jt39qDV2dhVFlu5mpdA4VRYUT64FavwRWrGKJ9M1qy3AdZFwKPsXVNBUew9qiU1AG1cq9GxWpDTpYVlHBt92BpLysQ4n215kv4A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(396003)(136003)(451199021)(82310400008)(36840700001)(40470700004)(46966006)(2616005)(6666004)(82740400003)(478600001)(356005)(36860700001)(47076005)(16526019)(186003)(426003)(336012)(83380400001)(26005)(40460700003)(1076003)(40480700001)(8676002)(8936002)(4326008)(41300700001)(2906002)(316002)(86362001)(70206006)(110136005)(36756003)(44832011)(5660300002)(54906003)(70586007)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 17:01:16.5234
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be3dbfa0-6975-4d34-6f33-08db86e76f5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9327
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
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
index 612b0015dc43..94b14ea6ffee 100644
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
@@ -3317,17 +3301,13 @@ static void ionic_lif_handle_fw_up(struct ionic_lif *lif)
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


