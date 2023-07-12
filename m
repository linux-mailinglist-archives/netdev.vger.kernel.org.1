Return-Path: <netdev+bounces-16988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C30D874FC0E
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 02:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AFD328173A
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 00:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5BC36E;
	Wed, 12 Jul 2023 00:20:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9909360
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 00:20:50 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2BB171C
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 17:20:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XgNV7dM0S7Rcz3/4/pvDRNgtHMfIUP4taZE0b5bKEKVl8ylBx/ewlCUu3MG8Kow/UuR1AtktHAl2fQ6bEEHsEjzlNNmbBh7tKTD76fpnzHJIo53ASndQhli5q+0NzjvxRoudvHzhVMVvKcyVZea0kYTvYY1zOBwdwf5gAldMBgrQ58Al1VpFOKVAqHdQknXKJQ2/tkPJWwhnROB1AgOMjNkx2f9i9YUOlUwEZYy0cpTSHjy6JeWRJpM7oS7A6eTHLIS4RadTIEg25gfFLeRVT/cHQSHViEa3mHsy2hkLdAgfIKSIcqbcDItIJTTwVjXtq5sfmG/BGZ3WxlAcq/o3ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FiKRpcunudOFTbYRCNEIZTvQ0BA8R+g9Wr0JwvBPWEo=;
 b=c5RpMeMdcpF83XOfEpLSya4EEdLjfYGD7QrPk4I6I0HzC2vOh+GgnwEw+tV4HtXPljOPTTW38QZc9wTl2Tlf1M4FIY9Sv5J3UuJxCewsx6fbpJOq2LEnfvaBM6/Hhbm0dgf3W4F7XPZJOsMw5I3OIMXbyVNlYoOZ0178E6OHj6HqJOsedW1sGMil7qfvKAS60M6VwRfm3E3qF4mMPTY3zM4e3om9CiBVSzJ7FJ/Xmx87MlA+uEtUMLDMMLk1bDO3BUa8aH1/OGo+ZADIHeRFvXKV7ogfMv/IwpQiU9rqq2lEv9s+TS63ferfVOMJHKSDHKfJHjd5hRxDzIT19OPpOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FiKRpcunudOFTbYRCNEIZTvQ0BA8R+g9Wr0JwvBPWEo=;
 b=0BPhRl2DJ0W/7s1rgIr1WQ6GnXNNCM2Ni0RvXZpWeZC9d4G/761zRtmFAruvQlcasrjhfyIU5px4sjpGGZjWfhF7ILWwb6TQ9lGdhxoJP3juLsN4Z7wQXnfhSHMoxrG2cRDhyryVLBsHmPDUQ/c9WvcHdFFnkqei9mGUUi4J0x4=
Received: from BN9P222CA0029.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::34)
 by BL3PR12MB6450.namprd12.prod.outlook.com (2603:10b6:208:3b9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Wed, 12 Jul
 2023 00:20:46 +0000
Received: from BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10c:cafe::c4) by BN9P222CA0029.outlook.office365.com
 (2603:10b6:408:10c::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20 via Frontend
 Transport; Wed, 12 Jul 2023 00:20:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT014.mail.protection.outlook.com (10.13.177.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.20 via Frontend Transport; Wed, 12 Jul 2023 00:20:46 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 11 Jul
 2023 19:20:45 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 1/5] ionic: remove dead device fail path
Date: Tue, 11 Jul 2023 17:20:21 -0700
Message-ID: <20230712002025.24444-2-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT014:EE_|BL3PR12MB6450:EE_
X-MS-Office365-Filtering-Correlation-Id: e00ea921-e6b9-4865-d11a-08db826dd6ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fPRjmmWDWpLTOBH+m1Cjm1NOS7xP5HwXF4RAAk8V/yKEwnl7F5gDaziyStkO2njWBuxWA02AaVKzQR9eHDN5Pj1WhHbxfPsCi362657hPvmQiaSCh30FjNZ5XpN+2C+NRbFH1tOvqEabRu87j/CZDDtPFjEfYG8GWdq2r/C5o0NuS+vgLjqTj5fTvqVEVdXXGlnSscPnnOE6zaSGax1AviyfCCnCllmIjofAqK2wPoaplkMFHmPoKeRQ+et9x8XirWi4Ni8FEf4Aes0NdqrVihggU6WJJOr+4YvDLmAZrogYS69bY8Whe7LIo58ImnI53E0dGQQ9HT//A2XMZGjs5mTu83O6T9r+Rq5eP5iro4bT8SGDqJe+kousOS6Ixnxyqdush69aRCGKg19l0ByS0kUrnxn4IsKca5zF6yNdleYoukYlcqyEv70Ytik7tLA72HYlt/IPSULChmbmbJ7QuVSdnU4AFr+I3Uuy8VRB1W+uKrufBdwb8p7BH4RfVr/31sAclAqTmcl+UF0uu2jfsNGcSkU6l7QW8W3cr4rEtm2udUyQybnKZ8mJpGnvj3Pidr3JocxqX/78HN7Ou3MhptcSlTksIhN8p3XFzxX7kF12PkqWTBCUrY/p0z7zJSidJtqcNwxjzcjHwmSMjdIpkrxrlc3pRYKpH3T5p284O7lHXO0dAMWQ02lv2OIwqgZ9z4mWHtO8h0xtMdAU4hD71SiRasGDNLK4FCZShO0kINCP1NeKE2LRZS5oUb7V4CIXGtbSRVr/N9GLvUs4+8PKtA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199021)(46966006)(40470700004)(36840700001)(336012)(82310400005)(316002)(6666004)(44832011)(81166007)(54906003)(4326008)(40480700001)(110136005)(478600001)(40460700003)(36756003)(2906002)(356005)(70586007)(70206006)(82740400003)(2616005)(83380400001)(16526019)(5660300002)(36860700001)(426003)(8676002)(8936002)(47076005)(186003)(26005)(41300700001)(86362001)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 00:20:46.7062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e00ea921-e6b9-4865-d11a-08db826dd6ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6450
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Remove the probe error path code that leaves the driver bound
to the device, but with essentially a dead device.  This was
useful maybe twice early in the driver's life and no longer
makes sense to keep.

Note: This patch is cherry-picked from commit 3a7af34fb6e
      because the following patchset is dependent on this
      change.  This patch can be dropped from this series
      once net-next is updated

Fixes: 30a1e6d0f8e2 ("ionic: keep ionic dev on lif init fail")
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
index b8678da1cce5..ab7d217b98b3 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
@@ -353,12 +353,6 @@ static int ionic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	ionic_reset(ionic);
 err_out_teardown:
 	ionic_dev_teardown(ionic);
-	pci_clear_master(pdev);
-	/* Don't fail the probe for these errors, keep
-	 * the hw interface around for inspection
-	 */
-	return 0;
-
 err_out_unmap_bars:
 	ionic_unmap_bars(ionic);
 err_out_pci_release_regions:
-- 
2.17.1


