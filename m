Return-Path: <netdev+bounces-31124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 670F278BA56
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 23:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F4BB280EDF
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 21:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0B015D5;
	Mon, 28 Aug 2023 21:34:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73DD10F4
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 21:34:44 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F4D1B8
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 14:34:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=in8nkY3QCCDU+hKcRn6VJaaPYDuuSessInYe0XeOm+sf6RsmF0ZHC+KX+1gwwMxeratYjFk4CnssOmG4+9nkEaZLL9rA36my0a1XplmOtBonNAia0n677TEWqWR8ffMJuSEXGXoI6ilYj6EQvMDV/jheEYs9dvVLwly8J4oi+DlmdXSbSqVrQt2Xg4fiJ8GvkEZVvpI7DFQYbph0jODWD8ErRoUkN3oxzAr7yIts+X4kfJgi7fCRSarxTYnstC78jm1Hn47PbtSK/HRD/iwwqAtmeH+6lrtnc5qS0y+IUy7a3iIv9S6N6VoBaXCV4s3Gi0Eye0rTNsCcvrI5MzQCzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bfm1d3+L503ARZOXg7Lh+wOM1Osxvv6PsxROcITxcU0=;
 b=Oyrs5kCHFTStHBnBdo59C17joN5+br2A5uvCOx1Y18iCwm79QtxCiWxCwsl7hrlFHuSZNHZx8zli8uxIa+pTZj2635T1Ls1MhoOBThi37Ww3yVpmwjHG/jMS+t1kQsKAnghvmOvn1e2B1k7s0NLw7BtWbC5nfaXik3wCTh6guxT+7+Z26jzvMJIeU3s09+ZoCHNKC5x1f8T1TP9ufcaqD4AMV8qpQQkrGY8A1n7U8zff+6U7DkxKbTJTo8h+rqxZ6oG1pL+zOhSujYyS+ad71GyzxfusI92tMzotowR+UzcTmkeA0oRGvy71nCKB7rOGEYiAyYjV1kPfzucGhvcBEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bfm1d3+L503ARZOXg7Lh+wOM1Osxvv6PsxROcITxcU0=;
 b=SoZZKsRzcL+f1hKaKIzMpLDzaYCYvZmo0eHu67celWJ9B1deJBTdqz21nq28jABToZBvJuAf5JxgiM/0Uei8nag3Nm1JbWBUKUCJ7BNiHxlj26vFkcRGViydXIUx1KlsqTYddNIzPAA/hFeL1p8CQdxYBvgVNAC8yEN204x+Dhw=
Received: from BYAPR11CA0078.namprd11.prod.outlook.com (2603:10b6:a03:f4::19)
 by IA1PR12MB8537.namprd12.prod.outlook.com (2603:10b6:208:453::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 21:34:32 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:a03:f4:cafe::a2) by BYAPR11CA0078.outlook.office365.com
 (2603:10b6:a03:f4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35 via Frontend
 Transport; Mon, 28 Aug 2023 21:34:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Mon, 28 Aug 2023 21:34:31 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 28 Aug
 2023 16:34:28 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <jasowang@redhat.com>, <mst@redhat.com>,
	<virtualization@lists.linux-foundation.org>, <shannon.nelson@amd.com>,
	<brett.creeley@amd.com>, <netdev@vger.kernel.org>
CC: <simon.horman@corigine.com>, <drivers@pensando.io>
Subject: [PATCH net] virtio: kdoc for struct virtio_pci_modern_device
Date: Mon, 28 Aug 2023 14:34:03 -0700
Message-ID: <20230828213403.45490-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|IA1PR12MB8537:EE_
X-MS-Office365-Filtering-Correlation-Id: 085ec87b-6c25-4110-3323-08dba80e913a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	n9gDyHJf3Kk0ugiXmSRrc5cljEr5PZAyDcPChfeMnXT2aHLL4lZbf8hdynpuVd0ZDuCCsZnsQFtbmrdZvXTLfQu5YRREXXtbRTBq055aQY9hp/Yi/dJuI88oS2GubqEFvS3bPDLfOaYqp65ey8nIKzKVZ2Dvo+GcUSgRUlWsb6yrzpzoJ52nSLJH39ECkwxyK60QFMTInJd5Xm6ZOlMWE6A3PjI1NSV0gIwJRaK/oVUGKtZhBxw4Wf85/fsoCEcKir5o54txViVwaDef0abX4fPzC7X3+oYLhN4U+T047lJt99/7zpJLHbF1FHHtgSH5Yb4E3H2r+pThXwHZJ4eTN91Rz9vqrPvjo0cLSB4NiqC36kBUuNUbLoav5KESY5J93jylfpFY6o2rZxaT6cJOmNY3zFYPuSc0QUSsQhZKK3Wkl4MAbILXvMMzoDAXpTXeCLdmiMIwpjENaOWPtHC9FygoptNDWDOlThhD0YF6uVOBVuTIi30LS45q59nqOcglb715XZp4g2wtMGz6FSyOBQHAKS4yL6kdez1WbBOz2PmfdYaS5jCoDrwuMw2cr9TQqYFjRggjnFNWBaJ3UJbGLKU+NdEYLmU+vIF2JQlojdhkpz5V6PEo+w4SElMxPSN+YWtYvRAQbHlKs4uM+rVjImeL24Z72n5mcX/RTvb2Z2LU1uZXK2xj4cLxGgrJu4i/HBArsyKGFbnB60gXSqNXn7rqPixb45crgEzzaS8QenG7kE9YlEVz9Q9xCzyvzlQGPOrDM/nPhJ8BWEdAvuIU2Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(376002)(39860400002)(1800799009)(82310400011)(186009)(451199024)(40470700004)(46966006)(36840700001)(83380400001)(478600001)(81166007)(356005)(966005)(82740400003)(16526019)(336012)(426003)(36860700001)(47076005)(26005)(1076003)(2616005)(40480700001)(6666004)(86362001)(2906002)(44832011)(316002)(8936002)(5660300002)(4326008)(70586007)(110136005)(8676002)(70206006)(54906003)(41300700001)(36756003)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 21:34:31.6951
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 085ec87b-6c25-4110-3323-08dba80e913a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8537
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Finally following up to Simon's suggestion for some kdoc attention
on struct virtio_pci_modern_device.

Link: https://lore.kernel.org/netdev/ZE%2FQS0lnUvxFacjf@corigine.com/
Cc: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 include/linux/virtio_pci_modern.h | 34 ++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_pci_modern.h
index 067ac1d789bc..a38c729d1973 100644
--- a/include/linux/virtio_pci_modern.h
+++ b/include/linux/virtio_pci_modern.h
@@ -12,37 +12,47 @@ struct virtio_pci_modern_common_cfg {
 	__le16 queue_reset;		/* read-write */
 };
 
+/**
+ * struct virtio_pci_modern_device - info for modern PCI virtio
+ * @pci_dev:	    Ptr to the PCI device struct
+ * @common:	    Position of the common capability in the PCI config
+ * @device:	    Device-specific data (non-legacy mode)
+ * @notify_base:    Base of vq notifications (non-legacy mode)
+ * @notify_pa:	    Physical base of vq notifications
+ * @isr:	    Where to read and clear interrupt
+ * @notify_len:	    So we can sanity-check accesses
+ * @device_len:	    So we can sanity-check accesses
+ * @notify_map_cap: Capability for when we need to map notifications per-vq
+ * @notify_offset_multiplier: Multiply queue_notify_off by this value
+ *                            (non-legacy mode).
+ * @modern_bars:    Bitmask of BARs
+ * @id:		    Device and vendor id
+ * @device_id_check: Callback defined before vp_modern_probe() to be used to
+ *		    verify the PCI device is a vendor's expected device rather
+ *		    than the standard virtio PCI device
+ *		    Returns the found device id or ERRNO
+ * @dma_mask:	    Optional mask instead of the traditional DMA_BIT_MASK(64),
+ *		    for vendor devices with DMA space address limitations
+ */
 struct virtio_pci_modern_device {
 	struct pci_dev *pci_dev;
 
 	struct virtio_pci_common_cfg __iomem *common;
-	/* Device-specific data (non-legacy mode)  */
 	void __iomem *device;
-	/* Base of vq notifications (non-legacy mode). */
 	void __iomem *notify_base;
-	/* Physical base of vq notifications */
 	resource_size_t notify_pa;
-	/* Where to read and clear interrupt */
 	u8 __iomem *isr;
 
-	/* So we can sanity-check accesses. */
 	size_t notify_len;
 	size_t device_len;
 
-	/* Capability for when we need to map notifications per-vq. */
 	int notify_map_cap;
 
-	/* Multiply queue_notify_off by this value. (non-legacy mode). */
 	u32 notify_offset_multiplier;
-
 	int modern_bars;
-
 	struct virtio_device_id id;
 
-	/* optional check for vendor virtio device, returns dev_id or -ERRNO */
 	int (*device_id_check)(struct pci_dev *pdev);
-
-	/* optional mask for devices with limited DMA space */
 	u64 dma_mask;
 };
 
-- 
2.17.1


