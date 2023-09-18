Return-Path: <netdev+bounces-34827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7252E7A55B2
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 00:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AB4F1C20B35
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 22:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198C4328BC;
	Mon, 18 Sep 2023 22:22:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B015450EB
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 22:22:01 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DFD9B0
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 15:22:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ELrkEAlWTqL7m6nwO0tAfBLuEzEXNVIy2L46Er4sm22K38sDpr08e+GnGamhau0q3RluCtLgU9oodAxdsBPhrIKcR9iT8gy42aNeElg1grZ5JhRHQibwhk9TZLhemei5O/lRUSGiy1uI5RjVxsJDqfu0HFjMkQx8/UzgT3UiIYQFuglDjETS/HX3bPzqsx9mQ2Q5Q7Ww9dB4eu3NtfCIWKuP+QxkiQj9RvUH7F79EtnBdk5sIY/GBYtS6gcQyyWJeUBB/A8y17H4ozEbgdvvdyhs7Dq3ZeBlLUX77yDYpCaJlwNMjRSSgKfSJN3xR9zPjNfxAseuKdBtWRNtcu2S0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g6ZFstsRJnJ1vQDEOd8lFEn+xyYW7eT80+CEpd6TjVo=;
 b=XuTOBVLzsyogl9vxX0xzifIbEJybLV4Zm9otcztAUrNPzTNiD/LCOdslRkcqqWIfy9TWHq2qmTemp3YO28aCAwnNtaOsoz/lTnKSRw/E5+ksDmpjbADtUpjQ2qiMANgqwDCQ2Py+T38Uhv+aMGAn/PqCjpjw2bsuaa7fBLht1Hl6WfM1du4Ug6WBcJ7dOX1YEpRJ6gzm6Op1yBjhndu6grw+zDNGnxM9f8MAfWqcAzE7jSPnyXeb7z1XUuaPMddLtKTQtL66sYmCrGdf5zr7Mc74r0N0hM6111XqKmtqSnmoVMBvv4UUZITAovOzA12njkvTuCXMLIsOnHBOeYnMLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6ZFstsRJnJ1vQDEOd8lFEn+xyYW7eT80+CEpd6TjVo=;
 b=LLsDmeWasacmgb0T+n9Y1suA+xM6YH70dItAzFy0t708MJGAWDyDdJ+NkSm2xM9P5zcmHt74ZT7qGwBQ2BUhfhMe/oKsHuT5EO3ORavDawE8ixsMEti2ZEsm+3JoyEfT4XBDl/FXRxpltv8rKAl+b24ejH2K1yLRpbMibzf97Go=
Received: from MN2PR14CA0013.namprd14.prod.outlook.com (2603:10b6:208:23e::18)
 by SA0PR12MB4399.namprd12.prod.outlook.com (2603:10b6:806:98::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Mon, 18 Sep
 2023 22:21:58 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:23e:cafe::76) by MN2PR14CA0013.outlook.office365.com
 (2603:10b6:208:23e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26 via Frontend
 Transport; Mon, 18 Sep 2023 22:21:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Mon, 18 Sep 2023 22:21:57 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 18 Sep
 2023 17:21:56 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 2/3] ionic: add a check for max SGs and SKB frags
Date: Mon, 18 Sep 2023 15:21:35 -0700
Message-ID: <20230918222136.40251-3-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230918222136.40251-1-shannon.nelson@amd.com>
References: <20230918222136.40251-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|SA0PR12MB4399:EE_
X-MS-Office365-Filtering-Correlation-Id: 841c0b20-acb2-4c77-ad92-08dbb895abe6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MAmWLF992GZlx8qEkSZEO0LQ3QxdZ7DpKP/rIuQ3FMtVxNXe9cNDpKl12K6GXoIBUS7yc9W4Yir+Ctu+jJhjsqDMkCWbU+imTEE0ttKahrqNONrnSZo/kiTwd5XIySK4uly3iiCHFEFev1UkQZNESIy1boeDUHIR/qgPF/P17g40E0QQXWb5JwU2M5kThh4MlXes04UmaO1S+dxSDjX3IvQlsCZpSqUiF+fKJ67dHgYrK4jFtqiL/NZEdguBmCBo4KKL8cId6e6x80q1Zv7Ab92SKXBDxR3k3CySkdNlUCso23pKo9lHT2NTuF5KiV1A/oH6msakjg3oaYAQxyFU6TPui0iYZEq5wD7o6walf6jErs//p5GGnfYvBBLdw0Pa4R/nv4J/uKOROaJ5naeKht4PVsV6paAE704l4IrT83kKLbALc6Y+APy9T3BZcBbAKrF7wIh3mfyDuCPmsv1IpZdjExKll8EsZlMoBmDCRX5Tf4ewoGQmgkflNkPHIBB8THqHyqwevLs6qwapdUFiTJcne4m4FEaRf6ZaQyJ0PM/gcT41XL+b+eY8oqWUy0pXJQpxqTFqjk/w/MgDKVka5T7OQ4sZdoyEvOVXU0+HC2T/O4ZJDFEUY7Ip8/BNWnjh2B1IRtsOPDpKK/MqmA4OkNjIm2YqDGh/At/cBGo0scBvNSb0DxtD9h419yhjZtuvVfsv7Z+oGbXq59VilEbIQ2pq3sgDKSz1oAW8DYJm+hVnoC0xAEFkAx6CyzUfvpBeT0bZj4bBJM0s7aasscia+w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(346002)(376002)(396003)(1800799009)(451199024)(82310400011)(186009)(40470700004)(46966006)(36840700001)(4326008)(2906002)(8936002)(8676002)(316002)(41300700001)(16526019)(426003)(1076003)(26005)(336012)(40480700001)(478600001)(110136005)(70586007)(70206006)(54906003)(44832011)(5660300002)(40460700003)(36756003)(36860700001)(47076005)(2616005)(83380400001)(6666004)(356005)(81166007)(86362001)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 22:21:57.6247
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 841c0b20-acb2-4c77-ad92-08dbb895abe6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4399
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add a check of the queue's max_sg_elems against the maximum frags we
expect to see per SKB and take the smaller of the two as our max for
the queues' descriptor buffer allocations.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_lif.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index 2c3e36b2dd7f..edc14730ce88 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -3831,6 +3831,18 @@ static void ionic_lif_queue_identify(struct ionic_lif *lif)
 			qtype, qti->max_sg_elems);
 		dev_dbg(ionic->dev, " qtype[%d].sg_desc_stride = %d\n",
 			qtype, qti->sg_desc_stride);
+
+		if (qti->max_sg_elems >= IONIC_MAX_FRAGS) {
+			qti->max_sg_elems = IONIC_MAX_FRAGS - 1;
+			dev_dbg(ionic->dev, "limiting qtype %d max_sg_elems to IONIC_MAX_FRAGS-1 %d\n",
+				qtype, qti->max_sg_elems);
+		}
+
+		if (qti->max_sg_elems > MAX_SKB_FRAGS) {
+			qti->max_sg_elems = MAX_SKB_FRAGS;
+			dev_dbg(ionic->dev, "limiting qtype %d max_sg_elems to MAX_SKB_FRAGS %d\n",
+				qtype, qti->max_sg_elems);
+		}
 	}
 }
 
-- 
2.17.1


