Return-Path: <netdev+bounces-16690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE05974E5CC
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 06:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFF0F1C20C57
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 04:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602A815491;
	Tue, 11 Jul 2023 04:25:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E6846BE
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 04:25:07 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB591BC
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 21:25:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ev5N62qwZvl/VKhrK4PvVns3VL9Obm1wY19MMYmJx+VoRgcYS99u4a7BaPpcItiUpiVi7FAxGCiX/qnooDLWpEBgInbSAlUsTBRzb5qM4UwKr5GqNZwei9blMWFktjgbueYsbDeo2WeM1Ph5bLlakJzHgP/IzDA5Q1sq53trSkaoTvFNZxzIyu+Af/++RZu0jh3CcYkh1uEhF4BwtjMVo5LjGAIRH+Wrfq4mdZhk1Fdqf/iBfHv2Eli8CLmDiXRsJJmLv7ZRPGgXXMD+JoMjxsEt87Ggbt9vLiI0r3QiZ8iIec2wALEG5WrvZyTpwWO32PlQRP20l9Q9Vd8YoLyCGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+3TQlmrXJU2KeTxVrzsXAsRY5pVZhPvVe2EI3Sm5Ko=;
 b=dIEkrVapWfWBD3zUHkXez00sqypv2gvkOzsAPuzDsD7rAWNCHIvrtTDxlllTuYHiHG6bNlKNj9ZTyjpZ7CnESz05KhYMtfmWRBoL69xrnoJpSxQYvN9besYeJWNfbgD4QYO3EtijelXwWYzvruzZtKjgQRhdvlSgAdAy9PTbEAKBMGtfENyxoWlV6eQt/k4fxBpHzmzHDC3eCE5FZVqdRx/1gdk+XIDnEa+Q5WMUPX9zP4QKBWvTw1BPhPUQkTjdKhQrdhjZlcHysSinUYLfTSULNH66eYpncVR/dSYG1rPLJz5/TJRt8qkoyN1DWv5zOmUWAOYcC9lsalILS+51Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+3TQlmrXJU2KeTxVrzsXAsRY5pVZhPvVe2EI3Sm5Ko=;
 b=lNmvs/YiRiZLW9IDklQvLCkum0M1Z1W/2pUu9LMIPgEApJ2Us8WEidYFzm/jIuKaJ61G96srciW6C/Hd2uLeD0FC9utWCgIWP+OXMiK/cbTT3i3+qD+gyvYskifY65cF4IvcJHupXFYZXF3O9EpwPNd7UDIztcwW/WDKoQsr1nE=
Received: from BN9PR03CA0926.namprd03.prod.outlook.com (2603:10b6:408:107::31)
 by PH7PR12MB8014.namprd12.prod.outlook.com (2603:10b6:510:27c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Tue, 11 Jul
 2023 04:25:03 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::35) by BN9PR03CA0926.outlook.office365.com
 (2603:10b6:408:107::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31 via Frontend
 Transport; Tue, 11 Jul 2023 04:25:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.18 via Frontend Transport; Tue, 11 Jul 2023 04:25:02 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 10 Jul
 2023 23:25:01 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <jasowang@redhat.com>, <mst@redhat.com>,
	<virtualization@lists.linux-foundation.org>, <shannon.nelson@amd.com>,
	<brett.creeley@amd.com>, <netdev@vger.kernel.org>
CC: <drivers@pensando.io>
Subject: [PATCH v2 virtio 2/5] pds_vdpa: always allow offering VIRTIO_NET_F_MAC
Date: Mon, 10 Jul 2023 21:24:34 -0700
Message-ID: <20230711042437.69381-3-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230711042437.69381-1-shannon.nelson@amd.com>
References: <20230711042437.69381-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT067:EE_|PH7PR12MB8014:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e081e2c-cf82-49e9-a620-08db81c6cbcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	41NtDlbdqMkQlbYSBR5Bx+bD76MIdsqw/90qddXPAtMthPalzjx/Q7lYluvJ63euDf9tvZpLc7bpaWjzLx7A5ZAJn8y/OAI2dJVavagOTOCaB4eAI4lruV2OSRZiqds854I4KBYrvhG89jFO/VYcHzqvWpT9H18Deg2rjC12ZD9ZtGxvk5Xxrxe7UzUm3xh5bZhDGieLUirDVkYHVSF5x2moYXXJNWT+uG/jjkEALDVSHz8KQLmGztlqDXL/66aPAJW9b/ElGSxU4Hhui0kOW39pKsqxIqR+/id6vd3Hw0+b3fvCLr7Iau1TRPWMYb75eaAIgeBgyTobjxOp5yJkrS/JnbjwSSngcdVFJHiTAm2r1zTqCLRcwROAjB9GU0YQ0e85ic0Yniagz7r27LzLZXTcJQcKBK6QFBapXDP8EUAEvmOHhRoQWbCKUNOXQUa+z03D9wnbPHRYBeGAk0Wq3Sih+gEisq1lmNvO4Hl1w7yIeuAy0tyPKB0P2mfZc7IQp4x4KLQK/O279CpR0kkIqXzXQL8Kie/SOrvfmCzcAb28mkhFHB3kyTJzTwhrYA1GSPW90myaYPlfJwsPKedZWZ8ZdCPW2Tga0q4OvjfgXP2ON6TdX80uI8ZCA2c9zaWq2foTWNgOyWRSMfhryCTTqVyRIPU9Sw+dQLLtwW3x1LqImkgM9QOkuLl7IyRrsmpjEBu0DOmnthwcc7fJ0VaCahI+i2b/1AmkZCDf+nOO26a6PpcHhdyNFvbs4gW/AJke3a4Q+RAtXgZ3HE/3HJYdaQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(6666004)(478600001)(110136005)(26005)(1076003)(336012)(16526019)(70586007)(186003)(70206006)(2906002)(82310400005)(41300700001)(4326008)(5660300002)(316002)(44832011)(8936002)(81166007)(8676002)(82740400003)(356005)(40460700003)(86362001)(36756003)(47076005)(36860700001)(83380400001)(426003)(40480700001)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 04:25:02.5439
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e081e2c-cf82-49e9-a620-08db81c6cbcc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8014
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Our driver sets a mac if the HW is 00:..:00 so we need to be sure to
advertise VIRTIO_NET_F_MAC even if the HW doesn't.  We also need to be
sure that virtio_net sees the VIRTIO_NET_F_MAC and doesn't rewrite the
mac address that a user may have set with the vdpa utility.

After reading the hw_feature bits, add the VIRTIO_NET_F_MAC to the driver's
supported_features and use that for reporting what is available.  If the
HW is not advertising it, be sure to strip the VIRTIO_NET_F_MAC before
finishing the feature negotiation.  If the user specifies a device_features
bitpattern in the vdpa utility without the VIRTIO_NET_F_MAC set, then
don't set the mac.

Fixes: 151cc834f3dd ("pds_vdpa: add support for vdpa and vdpamgmt interfaces")
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/vdpa/pds/debugfs.c  |  2 --
 drivers/vdpa/pds/vdpa_dev.c | 30 +++++++++++++++++++++---------
 drivers/vdpa/pds/vdpa_dev.h |  4 ++--
 3 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/vdpa/pds/debugfs.c b/drivers/vdpa/pds/debugfs.c
index 21a0dc0cb607..754ccb7a6666 100644
--- a/drivers/vdpa/pds/debugfs.c
+++ b/drivers/vdpa/pds/debugfs.c
@@ -224,8 +224,6 @@ static int config_show(struct seq_file *seq, void *v)
 	seq_printf(seq, "dev_status:           %#x\n", status);
 	print_status_bits(seq, status);
 
-	seq_printf(seq, "req_features:         %#llx\n", pdsv->req_features);
-	print_feature_bits_all(seq, pdsv->req_features);
 	driver_features = vp_modern_get_driver_features(&pdsv->vdpa_aux->vd_mdev);
 	seq_printf(seq, "driver_features:      %#llx\n", driver_features);
 	print_feature_bits_all(seq, driver_features);
diff --git a/drivers/vdpa/pds/vdpa_dev.c b/drivers/vdpa/pds/vdpa_dev.c
index e2e99bb0be2b..5b566e0eef0a 100644
--- a/drivers/vdpa/pds/vdpa_dev.c
+++ b/drivers/vdpa/pds/vdpa_dev.c
@@ -318,6 +318,7 @@ static int pds_vdpa_set_driver_features(struct vdpa_device *vdpa_dev, u64 featur
 	struct device *dev = &pdsv->vdpa_dev.dev;
 	u64 driver_features;
 	u64 nego_features;
+	u64 hw_features;
 	u64 missing;
 
 	if (!(features & BIT_ULL(VIRTIO_F_ACCESS_PLATFORM)) && features) {
@@ -325,21 +326,26 @@ static int pds_vdpa_set_driver_features(struct vdpa_device *vdpa_dev, u64 featur
 		return -EOPNOTSUPP;
 	}
 
-	pdsv->req_features = features;
-
 	/* Check for valid feature bits */
-	nego_features = features & le64_to_cpu(pdsv->vdpa_aux->ident.hw_features);
-	missing = pdsv->req_features & ~nego_features;
+	nego_features = features & pdsv->supported_features;
+	missing = features & ~nego_features;
 	if (missing) {
 		dev_err(dev, "Can't support all requested features in %#llx, missing %#llx features\n",
-			pdsv->req_features, missing);
+			features, missing);
 		return -EOPNOTSUPP;
 	}
 
+	pdsv->negotiated_features = nego_features;
+
 	driver_features = pds_vdpa_get_driver_features(vdpa_dev);
 	dev_dbg(dev, "%s: %#llx => %#llx\n",
 		__func__, driver_features, nego_features);
 
+	/* if we're faking the F_MAC, strip it before writing to device */
+	hw_features = le64_to_cpu(pdsv->vdpa_aux->ident.hw_features);
+	if (!(hw_features & BIT_ULL(VIRTIO_NET_F_MAC)))
+		nego_features &= ~BIT_ULL(VIRTIO_NET_F_MAC);
+
 	if (driver_features == nego_features)
 		return 0;
 
@@ -352,7 +358,7 @@ static u64 pds_vdpa_get_driver_features(struct vdpa_device *vdpa_dev)
 {
 	struct pds_vdpa_device *pdsv = vdpa_to_pdsv(vdpa_dev);
 
-	return vp_modern_get_driver_features(&pdsv->vdpa_aux->vd_mdev);
+	return pdsv->negotiated_features;
 }
 
 static void pds_vdpa_set_config_cb(struct vdpa_device *vdpa_dev,
@@ -564,7 +570,7 @@ static int pds_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 
 	if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
 		u64 unsupp_features =
-			add_config->device_features & ~mgmt->supported_features;
+			add_config->device_features & ~pdsv->supported_features;
 
 		if (unsupp_features) {
 			dev_err(dev, "Unsupported features: %#llx\n", unsupp_features);
@@ -615,7 +621,8 @@ static int pds_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 	}
 
 	/* Set a mac, either from the user config if provided
-	 * or set a random mac if default is 00:..:00
+	 * or use the device's mac if not 00:..:00
+	 * or set a random mac
 	 */
 	if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
 		ether_addr_copy(pdsv->mac, add_config->net.mac);
@@ -624,7 +631,8 @@ static int pds_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 
 		vc = pdsv->vdpa_aux->vd_mdev.device;
 		memcpy_fromio(pdsv->mac, vc->mac, sizeof(pdsv->mac));
-		if (is_zero_ether_addr(pdsv->mac)) {
+		if (is_zero_ether_addr(pdsv->mac) &&
+		    (pdsv->supported_features & BIT_ULL(VIRTIO_NET_F_MAC))) {
 			eth_random_addr(pdsv->mac);
 			dev_info(dev, "setting random mac %pM\n", pdsv->mac);
 		}
@@ -752,6 +760,10 @@ int pds_vdpa_get_mgmt_info(struct pds_vdpa_aux *vdpa_aux)
 	mgmt->id_table = pds_vdpa_id_table;
 	mgmt->device = dev;
 	mgmt->supported_features = le64_to_cpu(vdpa_aux->ident.hw_features);
+
+	/* advertise F_MAC even if the device doesn't */
+	mgmt->supported_features |= BIT_ULL(VIRTIO_NET_F_MAC);
+
 	mgmt->config_attr_mask = BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR);
 	mgmt->config_attr_mask |= BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP);
 	mgmt->config_attr_mask |= BIT_ULL(VDPA_ATTR_DEV_FEATURES);
diff --git a/drivers/vdpa/pds/vdpa_dev.h b/drivers/vdpa/pds/vdpa_dev.h
index cf02df287fc4..d984ba24a7da 100644
--- a/drivers/vdpa/pds/vdpa_dev.h
+++ b/drivers/vdpa/pds/vdpa_dev.h
@@ -35,8 +35,8 @@ struct pds_vdpa_device {
 	struct pds_vdpa_aux *vdpa_aux;
 
 	struct pds_vdpa_vq_info vqs[PDS_VDPA_MAX_QUEUES];
-	u64 supported_features;		/* specified device features */
-	u64 req_features;		/* features requested by vdpa */
+	u64 supported_features;		/* supported device features */
+	u64 negotiated_features;	/* negotiated features */
 	u8 vdpa_index;			/* rsvd for future subdevice use */
 	u8 num_vqs;			/* num vqs in use */
 	u8 mac[ETH_ALEN];		/* mac selected when the device was added */
-- 
2.17.1


