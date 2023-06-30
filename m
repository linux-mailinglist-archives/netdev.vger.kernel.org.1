Return-Path: <netdev+bounces-14684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5FF7431C5
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 02:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38DA2280BE5
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 00:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD0AEBE;
	Fri, 30 Jun 2023 00:36:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B0E15BE
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 00:36:49 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E931FCB
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 17:36:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTgV6s1t+Oeuzlfy6x1qIuhZlTkRLGyeQuMvA6QxKPG7hXHpkiMC0O3o4Cct28wLsnpvceH/qc7aaMIBLK91A47mbQ5ZPVwWIVz3G5YnQ7CCS4knPVnIKqDkhig9KVI5/ITUltPd8T8SLfhXpc1wgmUmJsme0E7+9RR9KeqXI2nTvrf2yBdF+1S9vLuRJ4p/BeCdtdseDH00fCWNR/RXYUDGbV/2v822k5sNvGHUGbSG9DLGqs8GNgEDgNuczj7Zb641/ZKPa9gPwyDQFsWbT7E44QYp5bpgl3f/yQq+ZtsM7TOa6HPDcLjZ6H8TOk/+47EK7G6zJ4+QJveimtmGSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9I5jrwUis/YC3PN2qOEaCCoTlcM/eS+vKQqW1LCYxI=;
 b=feuisYyVUDQRmOt9iGJXE9IeB7r+0ZRlQ1xc1/MEkoV+OeFmMwNVAGIUzv6Q+4Xt4yUovnsiTPskwbf2CPTFkWg2LqebHIFraovM0+NCfPR+MzruVfhRPLL3W1OJmJpRetipbdgr+TQ2hJZesi0W+bju+z6jas816/Zcut+9XfP6b6Y+9LLWr38qUKlmS1cxtYTprmoBAIz4H1caqgFyTBflKvUUHfxYnEpQn9DoXg/fiv5o3absLSw1K4JPeN/OWOroBMWxsJAe0x3RGKe0ZM3KlxqukJ9vhokAkXr31XY2YDoDYa4ZmeXMn76RdctaYvZPFyfIoTsYpp5i2lFcsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9I5jrwUis/YC3PN2qOEaCCoTlcM/eS+vKQqW1LCYxI=;
 b=Ew2+S6uHmiQ6SU+igAOWWSIkTcWN4Kd+SQDhiWE9sOIgg/tApB85SaUEIVVtYciK7aaNbKA/af4HA8vWytOOz3dO5zZzJfIVVGx98qRrsMUyYRIa7qaYd3cuUwkdfNgFxr/dplbho+jd8FJCeSFSgWCpjmRVozsKdQQDpRiR8RY=
Received: from MW4PR03CA0266.namprd03.prod.outlook.com (2603:10b6:303:b4::31)
 by BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.15; Fri, 30 Jun
 2023 00:36:41 +0000
Received: from CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::e9) by MW4PR03CA0266.outlook.office365.com
 (2603:10b6:303:b4::31) with Microsoft SMTP Server (version=TLS1_2,
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
 15.20.6521.33 via Frontend Transport; Fri, 30 Jun 2023 00:36:40 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 29 Jun
 2023 19:36:38 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <jasowang@redhat.com>, <mst@redhat.com>,
	<virtualization@lists.linux-foundation.org>, <shannon.nelson@amd.com>,
	<brett.creeley@amd.com>, <netdev@vger.kernel.org>
CC: <drivers@pensando.io>, Allen Hubbe <allen.hubbe@amd.com>
Subject: [PATCH virtio 1/4] pds_vdpa: reset to vdpa specified mac
Date: Thu, 29 Jun 2023 17:36:06 -0700
Message-ID: <20230630003609.28527-2-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT040:EE_|BL1PR12MB5349:EE_
X-MS-Office365-Filtering-Correlation-Id: 9846b489-6f7b-4480-7193-08db7902128e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qs1ykkHHuy04WrzfX/0c2ZGK5IK+z8CmkeFKu8HPJoHI6jvxlPmH62SqBA/amTN2RusqNLzjKJAa1zo3olHXGCSBaIRZS6S/O7ZXdli9C9oS0qJgeTc4KplG1xCET8Eb6JiifxdbdRL/Pxk/O8BNtOEKIi+ikY3gsfiFu2p+ifOwanRPQeOGyCBSufLQ7zIBNn1XltenC7GUNeQosQ9TK3V12/DpVgIxgoDTcYup62KiLXqD3HlYAQYFvWE6qiMTkivSJwmeTU062dKGwL7rnJLRfhBYVuBMAa2n9GBU7tj+RRul7s6unbSLBLRoH1Mia8lDmP471zYza3oTlu94BvgYy/G0Yun9EP6+SEbE+MLj/4Vu3AQK35i85XBTQJ5XdBI6K03xwwtm/kxv2kVv+YIYzUtRvjMcNPbaZH24yAnOvYPpfMHfWlJL8QCStjOH9kKdD8ZVSOh6xWe5xMHZUN89wq/hrZkWi5Mqh4kGC1wq5jvc/kg1Kfjm5Bco2iDw/JY1Su4QTM/+3qWTa1xraCxNffBxvgftdyIIPnzagERiqtclSR0hjw8Tef6fAko2KWoQCw9X2xGUWLHYXnHd2a4ry8PhYBJNLlBZ5XaQ7l9yIifYZrTN2TCWNpCutuEX4O78bRhiQUv759fRhOANVCvpy97LVQxqnKskSecTP6r0Vw24wi7dfu7G4t+1nSaW4GJ8ucLrappf8vwpsiDGh+jsls65+T9/nvcOboaqbwfhYWOUqFfDen4h2A/MLKc0aAAHUJiHDyj9JC1eqtkpZg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(376002)(346002)(451199021)(36840700001)(46966006)(40470700004)(70206006)(70586007)(40480700001)(40460700003)(4326008)(426003)(2906002)(336012)(47076005)(186003)(2616005)(16526019)(83380400001)(316002)(36860700001)(54906003)(110136005)(6666004)(1076003)(44832011)(5660300002)(478600001)(26005)(8936002)(8676002)(41300700001)(356005)(82740400003)(82310400005)(36756003)(86362001)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 00:36:40.9715
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9846b489-6f7b-4480-7193-08db7902128e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5349
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Allen Hubbe <allen.hubbe@amd.com>

When the vdpa device is reset, also reinitialize it with the mac address
that was assigned when the device was added.

Fixes: 151cc834f3dd ("pds_vdpa: add support for vdpa and vdpamgmt interfaces")
Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
---
 drivers/vdpa/pds/vdpa_dev.c | 16 ++++++++--------
 drivers/vdpa/pds/vdpa_dev.h |  1 +
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/vdpa/pds/vdpa_dev.c b/drivers/vdpa/pds/vdpa_dev.c
index 5071a4d58f8d..e2e99bb0be2b 100644
--- a/drivers/vdpa/pds/vdpa_dev.c
+++ b/drivers/vdpa/pds/vdpa_dev.c
@@ -409,6 +409,8 @@ static void pds_vdpa_set_status(struct vdpa_device *vdpa_dev, u8 status)
 			pdsv->vqs[i].avail_idx = 0;
 			pdsv->vqs[i].used_idx = 0;
 		}
+
+		pds_vdpa_cmd_set_mac(pdsv, pdsv->mac);
 	}
 
 	if (status & ~old_status & VIRTIO_CONFIG_S_FEATURES_OK) {
@@ -532,7 +534,6 @@ static int pds_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 	struct device *dma_dev;
 	struct pci_dev *pdev;
 	struct device *dev;
-	u8 mac[ETH_ALEN];
 	int err;
 	int i;
 
@@ -617,19 +618,18 @@ static int pds_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 	 * or set a random mac if default is 00:..:00
 	 */
 	if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
-		ether_addr_copy(mac, add_config->net.mac);
-		pds_vdpa_cmd_set_mac(pdsv, mac);
+		ether_addr_copy(pdsv->mac, add_config->net.mac);
 	} else {
 		struct virtio_net_config __iomem *vc;
 
 		vc = pdsv->vdpa_aux->vd_mdev.device;
-		memcpy_fromio(mac, vc->mac, sizeof(mac));
-		if (is_zero_ether_addr(mac)) {
-			eth_random_addr(mac);
-			dev_info(dev, "setting random mac %pM\n", mac);
-			pds_vdpa_cmd_set_mac(pdsv, mac);
+		memcpy_fromio(pdsv->mac, vc->mac, sizeof(pdsv->mac));
+		if (is_zero_ether_addr(pdsv->mac)) {
+			eth_random_addr(pdsv->mac);
+			dev_info(dev, "setting random mac %pM\n", pdsv->mac);
 		}
 	}
+	pds_vdpa_cmd_set_mac(pdsv, pdsv->mac);
 
 	for (i = 0; i < pdsv->num_vqs; i++) {
 		pdsv->vqs[i].qid = i;
diff --git a/drivers/vdpa/pds/vdpa_dev.h b/drivers/vdpa/pds/vdpa_dev.h
index a1bc37de9537..cf02df287fc4 100644
--- a/drivers/vdpa/pds/vdpa_dev.h
+++ b/drivers/vdpa/pds/vdpa_dev.h
@@ -39,6 +39,7 @@ struct pds_vdpa_device {
 	u64 req_features;		/* features requested by vdpa */
 	u8 vdpa_index;			/* rsvd for future subdevice use */
 	u8 num_vqs;			/* num vqs in use */
+	u8 mac[ETH_ALEN];		/* mac selected when the device was added */
 	struct vdpa_callback config_cb;
 	struct notifier_block nb;
 };
-- 
2.17.1


