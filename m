Return-Path: <netdev+bounces-32974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BE079C13F
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 02:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BD9D28162B
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 00:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1E71C04;
	Tue, 12 Sep 2023 00:43:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04F917FC
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 00:43:18 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20616.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::616])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33778172FA3
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 17:11:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BixUlfvJW0ufmE4o6cKgjF/GmV6OcvGzs0dPvDMFmTpjngCLXD3Q8v+BJ7UEcIWzNDROV469QrTBKAx4KH1palFhVCkh/8yE2JTtwfOJ8d+4+Hup1SKFMijBJSuSs6IT3RCV7crTZMeE6d5aBNhC2lMC2iza750MDEaJaCTowewhJ5ggQscAvfF/EbgQikTFtDI7wbSNrh9+0xZILI8P5NelhdO3P5qyNz5sAEHNQkIG6TAAGPIC+S8oX5r0u6BlJ8p7SUT9Fpu7W4AngB8lSMspX7TPrWs675aACO53LTEvR26mqRNie7H+3Hr2vP83lq7BBp+bUxGnvBF9Tiv0lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mkfu1o04vCr8kvLFl2xTueC5ioaW4YOYTn00cIw5cyU=;
 b=WtX/VXwGl7PQ1h5b2WK8fTjEjOj+EHri7pOMBmiA1XH7EI9uLHJpuVq+A8GTrz7rogGwbBNUZWvRR1v5dZ42HJYoiY9ChFy1Ej5Vh744WHeDmlfVkK9NRv+MH0RljxEBF5a9VJoMApXy5jKpKlXjOCEKmuVZmtuNIk7jNHwqkjRXpwxwgOfu1o0ksqQyZ878BVTtvKrEifByhXARc9VCelvQHwAuNbnb2HS/WWR7XnqYuVevkTwwnnpuYrj7/1R0eoiztqQxPNIFhwtbdyFS23yKWa3npVNDvddpLv7mBf8fFWbPs8Gt44lOOEuLttanoyIB9UjLdUxtNbS6uA1QwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mkfu1o04vCr8kvLFl2xTueC5ioaW4YOYTn00cIw5cyU=;
 b=f3hwnXvKZug0wXkdtvwRQuB5pkVju6s9UCxw57NhdDn38cJTxriTjtYLDpyj8+m2kAaCtmsT+oR9ReZkq+dI48CYKq4fJFHnWI/+LHabUeuVPJfuPVz3zRwkd7bN2+X//s5xajzUUX3hjly5VMb3zb/SdTA7/3WE9u41t6UFPhQ=
Received: from MW4PR04CA0194.namprd04.prod.outlook.com (2603:10b6:303:86::19)
 by SJ2PR12MB8063.namprd12.prod.outlook.com (2603:10b6:a03:4d1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Mon, 11 Sep
 2023 21:31:27 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:303:86:cafe::f4) by MW4PR04CA0194.outlook.office365.com
 (2603:10b6:303:86::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35 via Frontend
 Transport; Mon, 11 Sep 2023 21:31:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.1 via Frontend Transport; Mon, 11 Sep 2023 21:31:27 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 16:31:25 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <kuba@kernel.org>, <davem@davemloft.net>, <jasowang@redhat.com>,
	<mst@redhat.com>, <virtualization@lists.linux-foundation.org>,
	<shannon.nelson@amd.com>, <brett.creeley@amd.com>, <netdev@vger.kernel.org>
CC: <simon.horman@corigine.com>, <eperezma@redhat.com>, <drivers@pensando.io>
Subject: [PATCH net-next] virtio: kdoc for struct virtio_pci_modern_device
Date: Mon, 11 Sep 2023 14:31:04 -0700
Message-ID: <20230911213104.14391-1-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|SJ2PR12MB8063:EE_
X-MS-Office365-Filtering-Correlation-Id: c240b2d0-4c49-4c28-d77f-08dbb30e74e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iqsnC0hVH3yrfx+tQ/NPp4cQomv/MkQx+9sf2KdiC+cbpkJNnTtouIXqbHVAZt4u6xW5A5miOdkrapUlGfimypvH1xzqmioOlQfTJZypvbnjvrZv0RI2tjWlMVG5Z+SFUOID8oOabVH4XM+QtEZz6kSOWvsfNCeObsYM/zXb10lHfXPUzgZErwZlUFBZiLtJJjsxs59XZoktIVOR8op397s+o9ARYCVh2u9hNTk7YxvGrEFubtbZOrUnGUFWFltcHw/0rXkwaKP0XCOUEGg5ziks8q2e5OUBxIT9SEV3v+KSZbNU+jcnS1Iu7FAeUIv0fRpv8aAEz8+SP9qpzSJeyyzmWtp7Vwe++/4deS2+xLRK3bs++UdotO6FkFjHDgkT/VCr1wb307rfFqPDFTwfZijVUZ8CELygHU/SWkjQ+2+Mkxgu5tIwyeMFmlQzbJnz5bl+LRXg4GrmBkz25lwiOanxueJS+UcEJyDWbjSjc6UHn+eN3Qh9OhpSXET96oWAsO3hMKqDm0DG3vmswKtmFIBbUAJC8hAPvKR+8RCD6hhDKhaPaumTYDBlKg6buCzGo0zgiGfbrYZbF2c7u2hsNRnEDmcHAtr/svusUqTdsmiEFjoC9wFBfNXQbAtHXRIR7VHSlB9ifGeAcAGbFwXWHCNLSOBG3eDkHhPymZrKOgmSXjZBg2IFRLPlPn18NnJiwnYGzaWL0p/dwclwVU8vXkE7+5BR5Q9Gb3oU6SwaKKuIDpqAAUOIaD/LUp7zkjBWLITJCeV7wdfqqjiYMstp4w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(136003)(346002)(82310400011)(186009)(1800799009)(451199024)(36840700001)(40470700004)(46966006)(426003)(40460700003)(2906002)(336012)(83380400001)(1076003)(16526019)(26005)(36860700001)(66574015)(5660300002)(6666004)(2616005)(8676002)(47076005)(54906003)(316002)(4326008)(70206006)(110136005)(8936002)(44832011)(70586007)(41300700001)(478600001)(966005)(82740400003)(81166007)(356005)(36756003)(86362001)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 21:31:27.3457
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c240b2d0-4c49-4c28-d77f-08dbb30e74e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8063
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Finally following up to Simon's suggestion for some kdoc attention
on struct virtio_pci_modern_device.

Link: https://lore.kernel.org/netdev/ZE%2FQS0lnUvxFacjf@corigine.com/
Cc: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
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


