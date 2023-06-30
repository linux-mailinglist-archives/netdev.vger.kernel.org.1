Return-Path: <netdev+bounces-14685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8277431C6
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 02:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2D721C20382
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 00:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7FE15BE;
	Fri, 30 Jun 2023 00:36:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43E417FA
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 00:36:51 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060f.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::60f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972D21FF9
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 17:36:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/2bIBUQib5OTtW74C+WZ0rIkgoLMSf5QHR7Ltp5O5Bz5VIaDlUbxEUVyU82Kp99wrr30NtKlfAhjnsnwp5vVmBOe8qBsOpaZ7+pFRJUoXDMwqP6So0iU/Ux0pt8DpW/h5QT0wjHczCBsnQotDAXhQqZddAVdFPMsQw4MBwOUy7EIPstopshE0jYTNnTpquGXxtMLBx28sq4IBH5lH2k4rtfttMCRNUH3e9UCYmv3Rb1THIN9CEjM1kkmQQKdWaeqamDPnp4HStpUYFjOXCv5v1xbDccZgoJX6THGX4hT/O0NkIdjetV3vjbQcgJpKGhQ3f8goz1Ug4gLsVXfTmpMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gt5gynslWs1EVfWnc+SaQynIl+rLUBbPJozpWajxZeA=;
 b=IuGquVieX9TnRe4ZSle1ORVK8rXjVhCBRvgCOqQicW/CPh1FiGNURFDMExW6xorTcmftjbH7I5K6VG78b0NzAndYGNzB1tgQQyMC7IJAgNniCsKlFsh2riF5rawyeMM4faD4qQeQpQ7xDBMkK/MNNGUjO71mRpihewAbKnMhU94ARHtE3hDZrmwpnNIjmeOVFYgAAEml9rt5dFQ6NpDsTkr/38NHD+KFP7evxvI9ospImr4z+Erlu8NP3Du6Z5V7epflzQwo+Y5PVIcAm13J8Y4k1Nry/udbXGXXwak8g9BmtshN2BJMHj3EkvQoovagewofhYP83Z7fUTOR9vSsCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gt5gynslWs1EVfWnc+SaQynIl+rLUBbPJozpWajxZeA=;
 b=WXxiWA1JO0xBc8AfCix9YwvQS3qQTgA1lXVb9kerRz5FVoz4KG4X/VcRz8y/kFYUpEuGRqoEu/BFzjR6LZeKE+VlU6KyrPZV6MuQzBhGIau/IClA9BCEbs4NUf3KVS7CLAOssmJ/spVLLPLc3GbYkPXsdhJbc76bU3Q5+7G78AU=
Received: from MW4PR03CA0259.namprd03.prod.outlook.com (2603:10b6:303:b4::24)
 by BL1PR12MB5921.namprd12.prod.outlook.com (2603:10b6:208:398::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 30 Jun
 2023 00:36:42 +0000
Received: from CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::1e) by MW4PR03CA0259.outlook.office365.com
 (2603:10b6:303:b4::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Fri, 30 Jun 2023 00:36:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT040.mail.protection.outlook.com (10.13.174.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.33 via Frontend Transport; Fri, 30 Jun 2023 00:36:41 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 29 Jun
 2023 19:36:39 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <jasowang@redhat.com>, <mst@redhat.com>,
	<virtualization@lists.linux-foundation.org>, <shannon.nelson@amd.com>,
	<brett.creeley@amd.com>, <netdev@vger.kernel.org>
CC: <drivers@pensando.io>
Subject: [PATCH virtio 2/4] pds_vdpa: always allow offering VIRTIO_NET_F_MAC
Date: Thu, 29 Jun 2023 17:36:07 -0700
Message-ID: <20230630003609.28527-3-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230630003609.28527-1-shannon.nelson@amd.com>
References: <20230630003609.28527-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT040:EE_|BL1PR12MB5921:EE_
X-MS-Office365-Filtering-Correlation-Id: 03cda1fb-3c60-47b0-f4f2-08db790212f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PyjQhUnqgFNrYK6/pqsUOiZJ7mK4fcKJLTBaEYLwJTGKEZzpvJPJEvhJzSLyPQ50dJdzI1U1OXibQ7xD9kdaabBa82pamLfsPSHYfHTMeyTmuK6xBRS2z7J4UQxM2bmeDu1dyqhCjXQldaxK/2ibpfdE95waB2t0KMvCaFLAVC9LIpR3B0pwXzwQX28jmk0Br8vX82SbloPm+s6uRTk6s8KMUtNPpq/wOEeenpS6uyhDu+oA0pxQ9vlJq6TTlcvyBiNLbjdcDp+ztc6qAow6Eqol/g1TVJjApwoROBb5aQWgk4rsNk8IDHdbfwPaFLQ6/vGNRsylFl8VmB2GgaAiH055K8RmgoUFswcZEb30tAyIktQ2naFv2ePt12HhU4y2B4wVFBMpBjmM1KghbQo69kwMxWYDq2be6g+ZUSVKJSSNLaiBRTydNpEprLYvFPcIUGgXdTd4oYnxaLablgOeIIPb0atkbxpf/KnOvPKhTCvYo8/17CNreJUQAQv2+Me4IPJyH6sYJoKfMBEVUqbPmYDjJbLV6vbRhmPXY986t9TpWiYhCHq4vmR9ws2+i6KddbvrzMPevR0RElqre3Ku2fLJbrlb3JXsbCLV/adpxz5PBb11MO8XnQmm9u0yFZSIPPq9zULEwefUAJrX8mRUuJvm22k/lxjiq0ZzqfsClyFBqh8eM/qHXk1VEtRgA6GETYBOQsA44EKysqADcA/se/Vfcm7WTTVD9bL/NOGyGJ74t2IerpxQHm6DD9BEwIHiaeRxvFrcMaQt6vYUx7SdPg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199021)(40470700004)(36840700001)(46966006)(8676002)(316002)(70206006)(426003)(16526019)(186003)(4326008)(26005)(1076003)(336012)(8936002)(110136005)(41300700001)(6666004)(40460700003)(70586007)(82310400005)(44832011)(5660300002)(2906002)(40480700001)(478600001)(2616005)(81166007)(356005)(82740400003)(36860700001)(86362001)(36756003)(83380400001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 00:36:41.6589
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03cda1fb-3c60-47b0-f4f2-08db790212f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5921
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
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
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
---
 drivers/vdpa/pds/vdpa_dev.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/vdpa/pds/vdpa_dev.c b/drivers/vdpa/pds/vdpa_dev.c
index e2e99bb0be2b..5e761d625ef3 100644
--- a/drivers/vdpa/pds/vdpa_dev.c
+++ b/drivers/vdpa/pds/vdpa_dev.c
@@ -316,6 +316,7 @@ static int pds_vdpa_set_driver_features(struct vdpa_device *vdpa_dev, u64 featur
 {
 	struct pds_vdpa_device *pdsv = vdpa_to_pdsv(vdpa_dev);
 	struct device *dev = &pdsv->vdpa_dev.dev;
+	u64 requested_features;
 	u64 driver_features;
 	u64 nego_features;
 	u64 missing;
@@ -325,18 +326,24 @@ static int pds_vdpa_set_driver_features(struct vdpa_device *vdpa_dev, u64 featur
 		return -EOPNOTSUPP;
 	}
 
+	/* save original request for debugfs */
 	pdsv->req_features = features;
+	requested_features = features;
+
+	/* if we're faking the F_MAC, strip it from features to be negotiated */
+	driver_features = pds_vdpa_get_driver_features(vdpa_dev);
+	if (!(driver_features & BIT_ULL(VIRTIO_NET_F_MAC)))
+		requested_features &= ~BIT_ULL(VIRTIO_NET_F_MAC);
 
 	/* Check for valid feature bits */
-	nego_features = features & le64_to_cpu(pdsv->vdpa_aux->ident.hw_features);
-	missing = pdsv->req_features & ~nego_features;
+	nego_features = requested_features & le64_to_cpu(pdsv->vdpa_aux->ident.hw_features);
+	missing = requested_features & ~nego_features;
 	if (missing) {
 		dev_err(dev, "Can't support all requested features in %#llx, missing %#llx features\n",
 			pdsv->req_features, missing);
 		return -EOPNOTSUPP;
 	}
 
-	driver_features = pds_vdpa_get_driver_features(vdpa_dev);
 	dev_dbg(dev, "%s: %#llx => %#llx\n",
 		__func__, driver_features, nego_features);
 
@@ -564,7 +571,7 @@ static int pds_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 
 	if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
 		u64 unsupp_features =
-			add_config->device_features & ~mgmt->supported_features;
+			add_config->device_features & ~pdsv->supported_features;
 
 		if (unsupp_features) {
 			dev_err(dev, "Unsupported features: %#llx\n", unsupp_features);
@@ -615,7 +622,8 @@ static int pds_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 	}
 
 	/* Set a mac, either from the user config if provided
-	 * or set a random mac if default is 00:..:00
+	 * or use the device's mac if not 00:..:00
+	 * or set a random mac
 	 */
 	if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
 		ether_addr_copy(pdsv->mac, add_config->net.mac);
@@ -624,7 +632,8 @@ static int pds_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 
 		vc = pdsv->vdpa_aux->vd_mdev.device;
 		memcpy_fromio(pdsv->mac, vc->mac, sizeof(pdsv->mac));
-		if (is_zero_ether_addr(pdsv->mac)) {
+		if (is_zero_ether_addr(pdsv->mac) &&
+		    (pdsv->supported_features & BIT_ULL(VIRTIO_NET_F_MAC))) {
 			eth_random_addr(pdsv->mac);
 			dev_info(dev, "setting random mac %pM\n", pdsv->mac);
 		}
@@ -752,6 +761,10 @@ int pds_vdpa_get_mgmt_info(struct pds_vdpa_aux *vdpa_aux)
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
-- 
2.17.1


