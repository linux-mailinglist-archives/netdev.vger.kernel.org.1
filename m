Return-Path: <netdev+bounces-52734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EABD47FFFDC
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 01:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 197461C20F52
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 00:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA9A59540;
	Fri,  1 Dec 2023 00:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zACbQk7X"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2062.outbound.protection.outlook.com [40.107.101.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA846133
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 16:05:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dvtrv52gbTDX9nzWyl1PpP5+PKyagCEkayCodHEoqvVVQfHONiuKGFpKLZ1vZ7jM+oTnaOeaE+LuCSpQwgyKqD5YhGO6aowbA/69ZrrSPdsPSEZ/u6S9GDWgGIyZpA3GUJJTJ15JT4ODXJn/AYH0w/bSe7fKDPKG6psnQ/A36Ypa+XHfkhAe693OSLHu6ST9ty9QJOFjysezJERlmGd0HXzZQPn73MRgid3Wfm3zA4Dc0Sfn/oYm+uwZIxK71jL7vU3OjjBVc4HTb8MzV8Ssvsr77S9194153LqmXey0YhpZrZc4seLgI7MNN2jaRw7qbs/rKJ65X/KaSKlRbMifVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PcEGX9cVzMQMuUQaPBX8V1PnAG2GUhPynu8O2zJvzC0=;
 b=UYdL8qQ4pSJjm4RSbvdJA4uiW7qczx+7gNALY1LyvSS8SdBaRPbDRPj2W9xBnhOxQBck/+lKCO40rBZ1czv5UWQk7GdF8jxdkZXf4HfzS7TYSL/Qa7VIiC7KQYpKPWCdfrBY/ZWUIVixCBHbygmoT1TJo+ZJlqCD9g953QnIEt2wBAJ/PDjHYLcYi7EJlW8Ze3alfQdqnRYQVDQDb7UUnqdgK9xEGrTWjVUYtDoiB9NYImPLYm6Rcr2yi58EtbAelb2iBnCBIPn+L31vQ6fIVwHjHN/xfEuOrB/bwBTl1j+8ghrCMgl/3mu0pM1OW8ANlxAeXx5Fw/k+/YXtGOonfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PcEGX9cVzMQMuUQaPBX8V1PnAG2GUhPynu8O2zJvzC0=;
 b=zACbQk7XIa+3UW7ToH3bmyHjWfIth04YgMaKmpnEmuAbWzQjVSb06OnC62Q8dj9kq1pPlH7BuePTSMJOQMOwy+Kgjnob2n+lNAwLmg9I4mfA5cZr+j53zzzJbOjHWEsslLov3V0VQrDB9POULp2TPD/QTRD/WdoOuGFCtaoCBtk=
Received: from DS7PR03CA0268.namprd03.prod.outlook.com (2603:10b6:5:3b3::33)
 by DM6PR12MB5008.namprd12.prod.outlook.com (2603:10b6:5:1b7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Fri, 1 Dec
 2023 00:05:40 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:5:3b3:cafe::96) by DS7PR03CA0268.outlook.office365.com
 (2603:10b6:5:3b3::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23 via Frontend
 Transport; Fri, 1 Dec 2023 00:05:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 00:05:39 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 30 Nov
 2023 18:05:38 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net 1/7] ionic: fix snprintf format length warning
Date: Thu, 30 Nov 2023 16:05:13 -0800
Message-ID: <20231201000519.13363-2-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231201000519.13363-1-shannon.nelson@amd.com>
References: <20231201000519.13363-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|DM6PR12MB5008:EE_
X-MS-Office365-Filtering-Correlation-Id: da27a89b-b4a6-42bd-9774-08dbf20140dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	17yb1g3keiz84qwxgPPZk1ps876sYJMxA7MlVhpYEGmABGKfUUBsT1DYfoEaqZFFp8DFrs6tHNmva6bL9QW9VPqLMXcr0Od1qd69SuUUgijYS9rxyMRNp2OJGr9aCI9uaMUuMWl4wpnnH74Ue5w2cildFh1iNBW/ZaxU2L2iRzVpO4GJqEDJ8sqyprpN9bkoxZFYNJjYQVZG6lIQDMqmRi/GvYO78QKsseXgDZO3XI91wbdedH6iXlccLu+zuh53IQGBujwMGs7N7X6Ui89dik0lF+1RSF/53MsgW1ZAiUBUSBk5E/ldjc/ivum1w/lfL7Qur+qNazImt4iTUvHIb2edyTS+WeSxaoi+AfY6gJDZ1FZ4C5BqofvMOF313GYhKk97zAlpjsAkOLSan+NQd4xrQUBDzJf6289gCqcYYV23QfhSAb8CWeZ0vCPfgMraa6/2hhlQHqLAluHRJKAMiuqiRupkwzVLYCu7cKWthbVwFaesKadSrcd30q6SnjQfnQSg+SYGINIdAvRUR7Uf/G5a1jFC6rAnxATkzaxs8N9Qcigx8rnIZgcA67bPdwe9aLoIub9noz87IIQ8DMJwCpjW8AOlLyjXGekjdUEU4bMDoJGVveDX/ysfDianGdgiQaXt490HWYjif4ZQqBtK7XrUk3koGcR243WajlcdM7NrHx3gexzz2YqDArYGMDGQlUcBd9DxheZ3S8jjZKK/91/AbfS3PB8VFgJWNLJ/LwD92F7cY2zqwcJjJtipU5JbOS+jrVBmEldlt6HxFQkeWU1n/kSZiRwtVayg0DGX1so6TfNNSTYoZ4fc6j3l1fN6
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(230173577357003)(230922051799003)(230273577357003)(64100799003)(451199024)(1800799012)(82310400011)(186009)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(36860700001)(356005)(81166007)(47076005)(2906002)(5660300002)(82740400003)(83380400001)(6666004)(16526019)(336012)(426003)(1076003)(2616005)(26005)(70586007)(70206006)(966005)(41300700001)(36756003)(110136005)(8936002)(478600001)(54906003)(4326008)(44832011)(86362001)(316002)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 00:05:39.9051
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da27a89b-b4a6-42bd-9774-08dbf20140dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5008

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


