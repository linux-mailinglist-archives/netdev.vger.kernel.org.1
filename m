Return-Path: <netdev+bounces-47142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B827E8374
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 21:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2915DB20E54
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 20:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E903B785;
	Fri, 10 Nov 2023 20:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bXuGwuWk"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF0B3B796
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 20:08:41 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332C2ED
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 12:08:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JFS20t1ITJoXYv33JhVAeKXGhY08yYOjCwjzGCMGcf3wEu6ZMO8hASs1Cvwue0UjqXt95aSvWvOUv0T8yw+zLH9rcE+L7TQc0jAUhgpInGADYEmH/rg77kOdyWLb/ysU7n0MBi+O/GnThj4zs6FgeB/6PE1Z6Ye1L+jtAzvOSl+nCmnxlYmAaASdNFr+iGMO2EBD4EDwxqUwFlyuUl08W+T2HVVQ9BAPq8LcdDYkfRMZviwAYdCytaNSJGIFd4IA+nanpSYmL1gLsVPruYPSocLUKrQUdtVX2ywb1ghYJmSCF1ltBUnPbQfOiW1osxSz4l2Nict5t2KSkyGm2+R1iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q4fjNEJXRmyh5foQOkYvR801p1UYqxTar0QMz6EJysc=;
 b=TCX9v5CR3jhJtzIm+akWL5sAo/B7xzPppX2Nn3HcUhsJ+cUXNLwCG3ovXEtOLHitv771I4WAn4LmlDeIvY1CnQX1ArZ98iEPymFH/vaCLGRNlcGiItH8HlPQUETC8d199Za//KU//48C5ZjKQt5ZAuWmmk4atltDxze1+7+OjWoszBzlwh/DZ2LIzxms7bNdakXnnZ2HQbGGzTnImV/mdNMDmpEJ9o2mYIzopsLnd76XToD04KxoYPkhvLdkyxrjpE5Yb+lX6H338Bs5KdL8aIrbRySWx/gSO6XeAcx7Ao+bog8hV+pnld/b6RYx6Lg+eQrMq7+CECCDS/b3Kgc+wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q4fjNEJXRmyh5foQOkYvR801p1UYqxTar0QMz6EJysc=;
 b=bXuGwuWkOcp1bVkdufBX7+VFjY0iEmWOaeBkZOQJ8XUIpk5TuDcbpNnhIjOSoG3JWUA0YkgrbRsl/kZBWDzd27y0RAhpJoynIm2gxvA+pRllRREKosp1bno6sAbVtxktgHs7sb+JurYlL8rnnC7yViv6ab9pattFDpwW1f7LFOo=
Received: from PA7P264CA0131.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:36e::20)
 by CY8PR12MB7291.namprd12.prod.outlook.com (2603:10b6:930:54::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Fri, 10 Nov
 2023 20:08:38 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10a6:102:36e:cafe::8d) by PA7P264CA0131.outlook.office365.com
 (2603:10a6:102:36e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.21 via Frontend
 Transport; Fri, 10 Nov 2023 20:08:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Fri, 10 Nov 2023 20:08:36 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 10 Nov
 2023 14:08:32 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <drivers@pensando.io>, <joao.m.martins@oracle.com>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net 2/2] pds_core: fix up some format-truncation complaints
Date: Fri, 10 Nov 2023 12:07:59 -0800
Message-ID: <20231110200759.56770-3-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231110200759.56770-1-shannon.nelson@amd.com>
References: <20231110200759.56770-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|CY8PR12MB7291:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d6a8c95-fc5a-47a7-997b-08dbe228d2a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VqeWov3uvo5ivTqz2dCOGTWh30TEBy+1xqpdLHgXO8+Zv/ihNoVhH0L/VcmNqS0Sh+1gLpdb99iuetnvIf4eLjqOfRZhnWOCMTmck+IJwaxXEjcD+bMBf0qlSJIzhNUVFWZNOQpaaLKyOS6f0b0qw56pzKolIoBN8ajnzZae7LIYpD0ryt1B1J2aYvjmigPa2/2/PfiFfFTD9TzIVS3G0S0b92fb3PcN2qf4nlOTsa2y8Zm0/hSfIyFFhXNx8wEdVlnWphUaW/aa6wPed2Q2IgYimvjuFpTJupBPoef2mfdORGRMh7xMYrGCu5D90o6jVF+fCplnqbpWMK5BOlENl/ly+VkCm5JSGtKk1Y0OEq70VbIZqh/KbwDS/kqC5BjD+yyeZmdWJy1g92W29Q+0GCChozIWqJZgz7pmFi7YHFJDlsgEHqHRCUG2KoF9JmLMFORz71Ekj2lD+h0Bp+ffSB0NWZicvMs+7u5QVMtXl3r3/jyLp7zciHIvasgvTVXOjDBt4CQlHrKgrrP/Wh0CDd7taxp9X/te7uyLvtbRSgXweLjLx6bWHmCy/iV28GW+jEegic3T86nTMEgD2Sia8fONurlx2PQncAs30EgQpEbD5wknAK/smJKc4y86AhuAkApRZl5fedxMyzO8plDtCQndjxXVbWQKcIt8OBRAAGqjU1Pi3GcrEGw2M5Cw86m14ihB+l6pg0hJ6M9yIS038FWo0LyFq59bkfrUvjChzLxmF8GfBus3Ujh+Q8kaD+98FCFbiKScrfoyWZN40jk7yg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(396003)(136003)(376002)(230922051799003)(1800799009)(186009)(82310400011)(451199024)(64100799003)(46966006)(40470700004)(36840700001)(47076005)(83380400001)(36860700001)(44832011)(478600001)(110136005)(82740400003)(1076003)(54906003)(6666004)(81166007)(356005)(336012)(2616005)(70206006)(26005)(70586007)(426003)(5660300002)(966005)(16526019)(316002)(2906002)(8936002)(41300700001)(8676002)(4326008)(86362001)(36756003)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 20:08:36.3069
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d6a8c95-fc5a-47a7-997b-08dbe228d2a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7291

Our friendly kernel test robot pointed out a couple of potential
string truncation issues.  None of which were we worried about,
but can be relatively easily fixed to quiet the complaints.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202310211736.66syyDpp-lkp@intel.com/
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/amd/pds_core/core.h    | 2 +-
 drivers/net/ethernet/amd/pds_core/dev.c     | 8 ++++++--
 drivers/net/ethernet/amd/pds_core/devlink.c | 2 +-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/core.h b/drivers/net/ethernet/amd/pds_core/core.h
index f3a7deda9972..e35d3e7006bf 100644
--- a/drivers/net/ethernet/amd/pds_core/core.h
+++ b/drivers/net/ethernet/amd/pds_core/core.h
@@ -15,7 +15,7 @@
 #define PDSC_DRV_DESCRIPTION	"AMD/Pensando Core Driver"
 
 #define PDSC_WATCHDOG_SECS	5
-#define PDSC_QUEUE_NAME_MAX_SZ  32
+#define PDSC_QUEUE_NAME_MAX_SZ  16
 #define PDSC_ADMINQ_MIN_LENGTH	16	/* must be a power of two */
 #define PDSC_NOTIFYQ_LENGTH	64	/* must be a power of two */
 #define PDSC_TEARDOWN_RECOVERY	false
diff --git a/drivers/net/ethernet/amd/pds_core/dev.c b/drivers/net/ethernet/amd/pds_core/dev.c
index 7c1b965d61a9..31940b857e0e 100644
--- a/drivers/net/ethernet/amd/pds_core/dev.c
+++ b/drivers/net/ethernet/amd/pds_core/dev.c
@@ -261,10 +261,14 @@ static int pdsc_identify(struct pdsc *pdsc)
 	struct pds_core_drv_identity drv = {};
 	size_t sz;
 	int err;
+	int n;
 
 	drv.drv_type = cpu_to_le32(PDS_DRIVER_LINUX);
-	snprintf(drv.driver_ver_str, sizeof(drv.driver_ver_str),
-		 "%s %s", PDS_CORE_DRV_NAME, utsname()->release);
+	/* Catching the return quiets a Wformat-truncation complaint */
+	n = snprintf(drv.driver_ver_str, sizeof(drv.driver_ver_str),
+		     "%s %s", PDS_CORE_DRV_NAME, utsname()->release);
+	if (n > sizeof(drv.driver_ver_str))
+		dev_dbg(pdsc->dev, "release name truncated, don't care\n");
 
 	/* Next let's get some info about the device
 	 * We use the devcmd_lock at this level in order to
diff --git a/drivers/net/ethernet/amd/pds_core/devlink.c b/drivers/net/ethernet/amd/pds_core/devlink.c
index 57f88c8b37de..e9948ea5bbcd 100644
--- a/drivers/net/ethernet/amd/pds_core/devlink.c
+++ b/drivers/net/ethernet/amd/pds_core/devlink.c
@@ -104,7 +104,7 @@ int pdsc_dl_info_get(struct devlink *dl, struct devlink_info_req *req,
 	struct pds_core_fw_list_info fw_list;
 	struct pdsc *pdsc = devlink_priv(dl);
 	union pds_core_dev_comp comp;
-	char buf[16];
+	char buf[32];
 	int listlen;
 	int err;
 	int i;
-- 
2.17.1


