Return-Path: <netdev+bounces-53609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AD4803E47
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 20:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED8582810D9
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 19:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AC6315A3;
	Mon,  4 Dec 2023 19:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eZbU++f1"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0D9E6
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 11:22:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J1EGpc+7itTOU2gK+gbNpd8zDzvGdYgWO6ikvJfCN3Nzg8rhIBsDpVYFwuqn740ND/6wr81ldK2TDGIPtvjcfpHttO/cGo+qjBqM4MEvV0NDeGWQfXpCCwqgaWxRnVHyXAdPjPz1B08ZA0WZHSgG18IJ3J3gCzVItds3t6DD9MPvXHxCsxJ/G+0ieG9SiANWKqzOOCmcuSG8OzK1gjOWgQiDOh7IeD85cc3e4sgMADTZLvafvGyszBAUIHMFtC59wnKVNLFQ5PNFdsexCV/hQg491DfOi+Huj/IndcpgxfWO2RXez+pxLJAPiIo2U/fQO7s9nzvL2GHPfRRgWKoI/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0Q+LTZ1gaXnm6HcpwOzeh/v+KY5H55WLwiguXj4OEU=;
 b=JeoyxCnQNU+FptC/VYvfHBPT5y/VxnsJcQAfqREkvXO6zXVAaCvLqyEaQgRUG6sguhNUpcpLRa5kIOj03lRfg1jMC+s1JzmDo4Xff2Og6NZgxR7BMmRHo+dhEgtdMNUEJDa6k3Rxeti64wz0VR0Ya75b0rahtQEVvfZ9ZiGc/SmHfw6XHaZ+slFspvuOVQJ3syqjq6GSMUZyl/TN+0sic1FIcoez3NCIFSyzTPE2JNcjjy1F4MtuTPHGESt8y1L/QTG9GI9Sn16GxEksI1djgZ3rvnUZkcdRTag+sMavO8LCJPvr5GhRyJLmzI9GE+SPRCqvLA4p2COB7i7+OP+l0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0Q+LTZ1gaXnm6HcpwOzeh/v+KY5H55WLwiguXj4OEU=;
 b=eZbU++f1BXHxTGNO8xrCubYalhAVVts/VOgCErnK2Yar1HRXEUd5xlUCOXd9FSCO1qBWCqPwyx3wA2r3C8uIvYAcRPJKWAryY/dawPeyPTKMik7o4TiK2HpQ+0iuEuHMmMgBsDefWeDK5wArdbjo5KQeDyEpJxbWbprPcgKc1yk=
Received: from SJ0PR05CA0183.namprd05.prod.outlook.com (2603:10b6:a03:330::8)
 by CYXPR12MB9338.namprd12.prod.outlook.com (2603:10b6:930:e5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 19:22:53 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:a03:330:cafe::d9) by SJ0PR05CA0183.outlook.office365.com
 (2603:10b6:a03:330::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.23 via Frontend
 Transport; Mon, 4 Dec 2023 19:22:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Mon, 4 Dec 2023 19:22:53 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 4 Dec
 2023 13:22:52 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <f.fainelli@gmail.com>, <brett.creeley@amd.com>, <drivers@pensando.io>,
	Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH v2 net 1/2] ionic: fix snprintf format length warning
Date: Mon, 4 Dec 2023 11:22:33 -0800
Message-ID: <20231204192234.21017-2-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231204192234.21017-1-shannon.nelson@amd.com>
References: <20231204192234.21017-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|CYXPR12MB9338:EE_
X-MS-Office365-Filtering-Correlation-Id: d378b0fa-5fb4-4d42-3ed9-08dbf4fe69c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sDTyh/t1kq9PT3LJTyXGVr8btPlBuZS1M9YBUDJqSOB2RGYz3IGuOcUF7iwb2YlmyPJZNZzRrMUwpVhfXblYFBhSoi1TwPwPr/9zrsSKnTOnzOjUfIDqYtDV5shjfQmLpXyjCzPQ1PbR8V1LSgRNEPnIMjk5n2OpDps3/GKFCR70Y5RKzUGMqzHPE9o+W1dJkTpJmYwI1/7Dkuli+T+n/DRUg3I10qoC+QeuqJeDTTq3PN06A0nuSKTNzq2zvmpCQ4/+kodUmXHhTxxmutsP+oszXqAMQwj5a8UADtDdkt5mHI3Ik1jqShghjx+lRccyz+AD7kmyk5nsg9HorizbAnbbgS0EGMbjSZsvjn4mojmtpdUpbAU53lKzolGIgbhP55ojOTp4ZzGL2ArEKH08B42Fhjj2YLeSzkdcS7LxbM7ZkCIUf9GeNdTDzNvxXKGQ8oqXpmfvRjJ6ciLqCrgl/G4oa6tG4F0Uq6tFmkXFUAAtQC8fN4GlxUvCWRB72R7YgsOcdc/Drp9HP1ckiX5ZZVG4D8/IZkUqZd8lgqwtDIeFeh6wDknbQ92imAvkMSvHnNSZlAqI8J2YvV5ohaSFUAFedWPhhiXh5AhvbrwHUv+s4l15lYLscVDrsHnHW2Z9tEMiVom0AT4RsVWIcsn6RakMgwTLa8g50H4SZZtDck7cipluBBZ+HMAuGA52zt14uBrdDPzzvaSefMx08e44/KgspQStGzJKwyeL6Tq3b4QHkH4prJggWR+QNGPseMHkNXREMDSd0e87oQkqesYexfG34vrZZQDTxTFoqnEaqlv9nDJd1Hf25mic5Fp5yRgD
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(230273577357003)(230173577357003)(230922051799003)(82310400011)(1800799012)(64100799003)(451199024)(186009)(46966006)(40470700004)(36840700001)(336012)(966005)(478600001)(26005)(83380400001)(16526019)(47076005)(6666004)(81166007)(356005)(40480700001)(426003)(1076003)(82740400003)(36756003)(2616005)(316002)(110136005)(54906003)(70586007)(70206006)(36860700001)(5660300002)(86362001)(4326008)(8936002)(8676002)(2906002)(40460700003)(44832011)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 19:22:53.5655
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d378b0fa-5fb4-4d42-3ed9-08dbf4fe69c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9338

Our friendly kernel test robot has reminded us that with a new
check we have a warning about a potential string truncation.
In this case it really doesn't hurt anything, but it is worth
addressing especially since there really is no reason to reserve
so many bytes for our queue names.  It seems that cutting the
queue name buffer length in half stops the complaint.

Fixes: c06107cabea3 ("ionic: more ionic name tweaks")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311300201.lO8v7mKU-lkp@intel.com/
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_dev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.h b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
index 1dbc3cb50b1d..9b5463040075 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
@@ -223,7 +223,7 @@ struct ionic_desc_info {
 	void *cb_arg;
 };
 
-#define IONIC_QUEUE_NAME_MAX_SZ		32
+#define IONIC_QUEUE_NAME_MAX_SZ		16
 
 struct ionic_queue {
 	struct device *dev;
-- 
2.17.1


