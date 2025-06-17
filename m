Return-Path: <netdev+bounces-198524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDA5ADC90C
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 13:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A170189A5A3
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 11:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DC62C0323;
	Tue, 17 Jun 2025 11:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="tMQJbdKy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33C82DBF4B
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 11:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750158394; cv=none; b=TVYk+aE+2M1HL0SwNs4hz7iwiIYRwx24feoMdHoqMttWzdoOi4GaHrap95OxfYDyxB3AfvpPTbPrOSPao+cG0Dr5ENYMoJile62ET4bXSy9LGziU4NrZxIpYosqyL/rhrty4cveygixMt/8uEU5NoJx7PmGbXixeu2j8gtTCXh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750158394; c=relaxed/simple;
	bh=m5jQhptAnJVcYoF7/8sxBuo5irAQIrvDt3msWEEO/ig=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qb6P1qbd+S8C8a9ZpA0aOnmDB/8AfPZqLDmf7QPzdE3KLxhyK1cGY/TkPU8rDrv04Jyo8OWYE0OqJw6u6K2l0JxNdmVLubohBf0kI7NGgNROQeikMjKSuEGjJKQuHqiOhwKv0ZF4oFzrLHWKtofuntJ/Ptsi+TjO2CBFGxn5qyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=tMQJbdKy; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1750158391; x=1781694391;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/FWr8XBOlE8bmlzgZN7X/zrX8ZfHMoX64wDcuYvq2PY=;
  b=tMQJbdKy7Rt7an1OrCcB6zfaSFbhxZvRw6T5QURWgNUNQ3xi1eIG07kA
   lGXWJmM8xG5R8Si+w8QdiEWd7z/CQO9i6xN35y3w0Z2oBRl4wnPwK613J
   eo/BLOVaOBINrBQ9fn4x4gO2rH0xrzHGmUx+xxQ0YQ7B0agkVgbSsDQiI
   6D5WBLKiiVB3+fbRebPaIcTM/XUld61IXrMN086IiQCdOVB/SOHsw/5qO
   H8ogAg/YJY5IYDLkonlRcy18BIEc2aU/ie6G2dlozFF23FrZHJMzNMr+H
   5Q0rZk/8NCNMaLa4MVTMHaY2sX5HotvMq5tLhPX6W7AdAO/1KdYfqgkU5
   A==;
X-IronPort-AV: E=Sophos;i="6.16,243,1744070400"; 
   d="scan'208";a="734485102"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 11:06:27 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.10.100:53020]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.22.45:2525] with esmtp (Farcaster)
 id a4f841d4-150b-49ef-8ffd-6b268a4719af; Tue, 17 Jun 2025 11:06:26 +0000 (UTC)
X-Farcaster-Flow-ID: a4f841d4-150b-49ef-8ffd-6b268a4719af
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 17 Jun 2025 11:06:26 +0000
Received: from HFA15-G9FV5D3.amazon.com (10.85.143.172) by
 EX19D005EUA002.ant.amazon.com (10.252.50.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 17 Jun 2025 11:06:14 +0000
From: David Arinzon <darinzon@amazon.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>
CC: David Arinzon <darinzon@amazon.com>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, "Richard
 Cochran" <richardcochran@gmail.com>, "Woodhouse, David" <dwmw@amazon.com>,
	"Machulsky, Zorik" <zorik@amazon.com>, "Matushevsky, Alexander"
	<matua@amazon.com>, Saeed Bshara <saeedb@amazon.com>, "Wilson, Matt"
	<msw@amazon.com>, "Liguori, Anthony" <aliguori@amazon.com>, "Bshara, Nafea"
	<nafea@amazon.com>, "Schmeilin, Evgeny" <evgenys@amazon.com>, "Belgazal,
 Netanel" <netanel@amazon.com>, "Saidi, Ali" <alisaidi@amazon.com>,
	"Herrenschmidt, Benjamin" <benh@amazon.com>, "Kiyanovski, Arthur"
	<akiyano@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>, "Bernstein, Amit"
	<amitbern@amazon.com>, "Agroskin, Shay" <shayagr@amazon.com>, "Ostrovsky,
 Evgeny" <evostrov@amazon.com>, "Tabachnik, Ofir" <ofirt@amazon.com>,
	"Machnikowski, Maciek" <maciek@machnikowski.net>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>, Gal Pressman <gal@nvidia.com>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Andrew Lunn <andrew@lunn.ch>, Leon Romanovsky
	<leon@kernel.org>, Jiri Pirko <jiri@resnulli.us>
Subject: [PATCH v13 net-next 1/9] net: ena: Add PHC support in the ENA driver
Date: Tue, 17 Jun 2025 14:05:37 +0300
Message-ID: <20250617110545.5659-2-darinzon@amazon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250617110545.5659-1-darinzon@amazon.com>
References: <20250617110545.5659-1-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA003.ant.amazon.com (10.13.139.105) To
 EX19D005EUA002.ant.amazon.com (10.252.50.11)

The ENA driver will be extended to support the new PHC feature using
ptp_clock interface [1]. this will provide timestamp reference for user
space to allow measuring time offset between the PHC and the system
clock in order to achieve nanosecond accuracy.

[1] - https://www.kernel.org/doc/html/latest/driver-api/ptp.html

Signed-off-by: Amit Bernstein <amitbern@amazon.com>
Signed-off-by: David Arinzon <darinzon@amazon.com>

---
 .../device_drivers/ethernet/amazon/ena.rst    |   1 +
 drivers/net/ethernet/amazon/Kconfig           |   1 +
 drivers/net/ethernet/amazon/ena/Makefile      |   2 +-
 .../net/ethernet/amazon/ena/ena_admin_defs.h  |  74 ++++-
 drivers/net/ethernet/amazon/ena/ena_com.c     | 267 ++++++++++++++++++
 drivers/net/ethernet/amazon/ena/ena_com.h     |  84 ++++++
 drivers/net/ethernet/amazon/ena/ena_ethtool.c |  16 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.c  |  24 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.h  |   4 +
 drivers/net/ethernet/amazon/ena/ena_phc.c     | 223 +++++++++++++++
 drivers/net/ethernet/amazon/ena/ena_phc.h     |  37 +++
 .../net/ethernet/amazon/ena/ena_regs_defs.h   |   8 +
 12 files changed, 736 insertions(+), 5 deletions(-)
 create mode 100644 drivers/net/ethernet/amazon/ena/ena_phc.c
 create mode 100644 drivers/net/ethernet/amazon/ena/ena_phc.h

diff --git a/Documentation/networking/device_drivers/ethernet/amazon/ena.rst b/Documentation/networking/device_drivers/ethernet/amazon/ena.rst
index 4561e8ab..98dc6217 100644
--- a/Documentation/networking/device_drivers/ethernet/amazon/ena.rst
+++ b/Documentation/networking/device_drivers/ethernet/amazon/ena.rst
@@ -56,6 +56,7 @@ ena_netdev.[ch]     Main Linux kernel driver.
 ena_ethtool.c       ethtool callbacks.
 ena_xdp.[ch]        XDP files
 ena_pci_id_tbl.h    Supported device IDs.
+ena_phc.[ch]        PTP hardware clock infrastructure (see `PHC`_ for more info)
 =================   ======================================================
 
 Management Interface:
diff --git a/drivers/net/ethernet/amazon/Kconfig b/drivers/net/ethernet/amazon/Kconfig
index c37fa393..8d61bc62 100644
--- a/drivers/net/ethernet/amazon/Kconfig
+++ b/drivers/net/ethernet/amazon/Kconfig
@@ -19,6 +19,7 @@ if NET_VENDOR_AMAZON
 config ENA_ETHERNET
 	tristate "Elastic Network Adapter (ENA) support"
 	depends on PCI_MSI && !CPU_BIG_ENDIAN
+	depends on PTP_1588_CLOCK_OPTIONAL
 	select DIMLIB
 	help
 	  This driver supports Elastic Network Adapter (ENA)"
diff --git a/drivers/net/ethernet/amazon/ena/Makefile b/drivers/net/ethernet/amazon/ena/Makefile
index 6ab61536..8c874177 100644
--- a/drivers/net/ethernet/amazon/ena/Makefile
+++ b/drivers/net/ethernet/amazon/ena/Makefile
@@ -5,4 +5,4 @@
 
 obj-$(CONFIG_ENA_ETHERNET) += ena.o
 
-ena-y := ena_netdev.o ena_com.o ena_eth_com.o ena_ethtool.o ena_xdp.o
+ena-y := ena_netdev.o ena_com.o ena_eth_com.o ena_ethtool.o ena_xdp.o ena_phc.o
diff --git a/drivers/net/ethernet/amazon/ena/ena_admin_defs.h b/drivers/net/ethernet/amazon/ena/ena_admin_defs.h
index 9d9fa655..562869a0 100644
--- a/drivers/net/ethernet/amazon/ena/ena_admin_defs.h
+++ b/drivers/net/ethernet/amazon/ena/ena_admin_defs.h
@@ -60,6 +60,7 @@ enum ena_admin_aq_feature_id {
 	ENA_ADMIN_AENQ_CONFIG                       = 26,
 	ENA_ADMIN_LINK_CONFIG                       = 27,
 	ENA_ADMIN_HOST_ATTR_CONFIG                  = 28,
+	ENA_ADMIN_PHC_CONFIG                        = 29,
 	ENA_ADMIN_FEATURES_OPCODE_NUM               = 32,
 };
 
@@ -127,6 +128,14 @@ enum ena_admin_get_stats_scope {
 	ENA_ADMIN_ETH_TRAFFIC                       = 1,
 };
 
+enum ena_admin_phc_type {
+	ENA_ADMIN_PHC_TYPE_READLESS                 = 0,
+};
+
+enum ena_admin_phc_error_flags {
+	ENA_ADMIN_PHC_ERROR_FLAG_TIMESTAMP   = BIT(0),
+};
+
 /* ENA SRD configuration for ENI */
 enum ena_admin_ena_srd_flags {
 	/* Feature enabled */
@@ -943,7 +952,9 @@ struct ena_admin_host_info {
 	 * 4 : rss_configurable_function_key
 	 * 5 : reserved
 	 * 6 : rx_page_reuse
-	 * 31:7 : reserved
+	 * 7 : reserved
+	 * 8 : phc
+	 * 31:9 : reserved
 	 */
 	u32 driver_supported_features;
 };
@@ -1023,6 +1034,43 @@ struct ena_admin_queue_ext_feature_desc {
 	};
 };
 
+struct ena_admin_feature_phc_desc {
+	/* PHC type as defined in enum ena_admin_get_phc_type,
+	 * used only for GET command.
+	 */
+	u8 type;
+
+	/* Reserved - MBZ */
+	u8 reserved1[3];
+
+	/* PHC doorbell address as an offset to PCIe MMIO REG BAR,
+	 * used only for GET command.
+	 */
+	u32 doorbell_offset;
+
+	/* Max time for valid PHC retrieval, passing this threshold will
+	 * fail the get-time request and block PHC requests for
+	 * block_timeout_usec, used only for GET command.
+	 */
+	u32 expire_timeout_usec;
+
+	/* PHC requests block period, blocking starts if PHC request expired
+	 * in order to prevent floods on busy device,
+	 * used only for GET command.
+	 */
+	u32 block_timeout_usec;
+
+	/* Shared PHC physical address (ena_admin_phc_resp),
+	 * used only for SET command.
+	 */
+	struct ena_common_mem_addr output_address;
+
+	/* Shared PHC Size (ena_admin_phc_resp),
+	 * used only for SET command.
+	 */
+	u32 output_length;
+};
+
 struct ena_admin_get_feat_resp {
 	struct ena_admin_acq_common_desc acq_common_desc;
 
@@ -1052,6 +1100,8 @@ struct ena_admin_get_feat_resp {
 		struct ena_admin_feature_intr_moder_desc intr_moderation;
 
 		struct ena_admin_ena_hw_hints hw_hints;
+
+		struct ena_admin_feature_phc_desc phc;
 	} u;
 };
 
@@ -1085,6 +1135,9 @@ struct ena_admin_set_feat_cmd {
 
 		/* LLQ configuration */
 		struct ena_admin_feature_llq_desc llq;
+
+		/* PHC configuration */
+		struct ena_admin_feature_phc_desc phc;
 	} u;
 };
 
@@ -1162,6 +1215,23 @@ struct ena_admin_ena_mmio_req_read_less_resp {
 	u32 reg_val;
 };
 
+struct ena_admin_phc_resp {
+	/* Request Id, received from DB register */
+	u16 req_id;
+
+	u8 reserved1[6];
+
+	/* PHC timestamp (nsec) */
+	u64 timestamp;
+
+	u8 reserved2[12];
+
+	/* Bit field of enum ena_admin_phc_error_flags */
+	u32 error_flags;
+
+	u8 reserved3[32];
+};
+
 /* aq_common_desc */
 #define ENA_ADMIN_AQ_COMMON_DESC_COMMAND_ID_MASK            GENMASK(11, 0)
 #define ENA_ADMIN_AQ_COMMON_DESC_PHASE_MASK                 BIT(0)
@@ -1260,6 +1330,8 @@ struct ena_admin_ena_mmio_req_read_less_resp {
 #define ENA_ADMIN_HOST_INFO_RSS_CONFIGURABLE_FUNCTION_KEY_MASK BIT(4)
 #define ENA_ADMIN_HOST_INFO_RX_PAGE_REUSE_SHIFT             6
 #define ENA_ADMIN_HOST_INFO_RX_PAGE_REUSE_MASK              BIT(6)
+#define ENA_ADMIN_HOST_INFO_PHC_SHIFT                       8
+#define ENA_ADMIN_HOST_INFO_PHC_MASK                        BIT(8)
 
 /* aenq_common_desc */
 #define ENA_ADMIN_AENQ_COMMON_DESC_PHASE_MASK               BIT(0)
diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c b/drivers/net/ethernet/amazon/ena/ena_com.c
index 66445617..e67b592e 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_com.c
@@ -41,6 +41,12 @@
 
 #define ENA_MAX_ADMIN_POLL_US 5000
 
+/* PHC definitions */
+#define ENA_PHC_DEFAULT_EXPIRE_TIMEOUT_USEC 10
+#define ENA_PHC_DEFAULT_BLOCK_TIMEOUT_USEC 1000
+#define ENA_PHC_REQ_ID_OFFSET 0xDEAD
+#define ENA_PHC_ERROR_FLAGS (ENA_ADMIN_PHC_ERROR_FLAG_TIMESTAMP)
+
 /*****************************************************************************/
 /*****************************************************************************/
 /*****************************************************************************/
@@ -1641,6 +1647,267 @@ void ena_com_set_admin_polling_mode(struct ena_com_dev *ena_dev, bool polling)
 	ena_dev->admin_queue.polling = polling;
 }
 
+bool ena_com_phc_supported(struct ena_com_dev *ena_dev)
+{
+	return ena_com_check_supported_feature_id(ena_dev, ENA_ADMIN_PHC_CONFIG);
+}
+
+int ena_com_phc_init(struct ena_com_dev *ena_dev)
+{
+	struct ena_com_phc_info *phc = &ena_dev->phc;
+
+	memset(phc, 0x0, sizeof(*phc));
+
+	/* Allocate shared mem used PHC timestamp retrieved from device */
+	phc->virt_addr = dma_alloc_coherent(ena_dev->dmadev,
+					    sizeof(*phc->virt_addr),
+					    &phc->phys_addr,
+					    GFP_KERNEL);
+	if (unlikely(!phc->virt_addr))
+		return -ENOMEM;
+
+	spin_lock_init(&phc->lock);
+
+	phc->virt_addr->req_id = 0;
+	phc->virt_addr->timestamp = 0;
+
+	return 0;
+}
+
+int ena_com_phc_config(struct ena_com_dev *ena_dev)
+{
+	struct ena_com_phc_info *phc = &ena_dev->phc;
+	struct ena_admin_get_feat_resp get_feat_resp;
+	struct ena_admin_set_feat_resp set_feat_resp;
+	struct ena_admin_set_feat_cmd set_feat_cmd;
+	int ret = 0;
+
+	/* Get device PHC default configuration */
+	ret = ena_com_get_feature(ena_dev,
+				  &get_feat_resp,
+				  ENA_ADMIN_PHC_CONFIG,
+				  0);
+	if (unlikely(ret)) {
+		netdev_err(ena_dev->net_device,
+			   "Failed to get PHC feature configuration, error: %d\n",
+			   ret);
+		return ret;
+	}
+
+	/* Supporting only readless PHC retrieval */
+	if (get_feat_resp.u.phc.type != ENA_ADMIN_PHC_TYPE_READLESS) {
+		netdev_err(ena_dev->net_device,
+			   "Unsupported PHC type, error: %d\n",
+			   -EOPNOTSUPP);
+		return -EOPNOTSUPP;
+	}
+
+	/* Update PHC doorbell offset according to device value,
+	 * used to write req_id to PHC bar
+	 */
+	phc->doorbell_offset = get_feat_resp.u.phc.doorbell_offset;
+
+	/* Update PHC expire timeout according to device
+	 * or default driver value
+	 */
+	phc->expire_timeout_usec = (get_feat_resp.u.phc.expire_timeout_usec) ?
+				    get_feat_resp.u.phc.expire_timeout_usec :
+				    ENA_PHC_DEFAULT_EXPIRE_TIMEOUT_USEC;
+
+	/* Update PHC block timeout according to device
+	 * or default driver value
+	 */
+	phc->block_timeout_usec = (get_feat_resp.u.phc.block_timeout_usec) ?
+				   get_feat_resp.u.phc.block_timeout_usec :
+				   ENA_PHC_DEFAULT_BLOCK_TIMEOUT_USEC;
+
+	/* Sanity check - expire timeout must not exceed block timeout */
+	if (phc->expire_timeout_usec > phc->block_timeout_usec)
+		phc->expire_timeout_usec = phc->block_timeout_usec;
+
+	/* Prepare PHC feature command */
+	memset(&set_feat_cmd, 0x0, sizeof(set_feat_cmd));
+	set_feat_cmd.aq_common_descriptor.opcode = ENA_ADMIN_SET_FEATURE;
+	set_feat_cmd.feat_common.feature_id = ENA_ADMIN_PHC_CONFIG;
+	set_feat_cmd.u.phc.output_length = sizeof(*phc->virt_addr);
+	ret = ena_com_mem_addr_set(ena_dev,
+				   &set_feat_cmd.u.phc.output_address,
+				   phc->phys_addr);
+	if (unlikely(ret)) {
+		netdev_err(ena_dev->net_device,
+			   "Failed setting PHC output address, error: %d\n",
+			   ret);
+		return ret;
+	}
+
+	/* Send PHC feature command to the device */
+	ret = ena_com_execute_admin_command(&ena_dev->admin_queue,
+					    (struct ena_admin_aq_entry *)&set_feat_cmd,
+					    sizeof(set_feat_cmd),
+					    (struct ena_admin_acq_entry *)&set_feat_resp,
+					    sizeof(set_feat_resp));
+
+	if (unlikely(ret)) {
+		netdev_err(ena_dev->net_device,
+			   "Failed to enable PHC, error: %d\n",
+			   ret);
+		return ret;
+	}
+
+	phc->active = true;
+	netdev_dbg(ena_dev->net_device, "PHC is active in the device\n");
+
+	return ret;
+}
+
+void ena_com_phc_destroy(struct ena_com_dev *ena_dev)
+{
+	struct ena_com_phc_info *phc = &ena_dev->phc;
+	unsigned long flags = 0;
+
+	/* In case PHC is not supported by the device, silently exiting */
+	if (!phc->virt_addr)
+		return;
+
+	spin_lock_irqsave(&phc->lock, flags);
+	phc->active = false;
+	spin_unlock_irqrestore(&phc->lock, flags);
+
+	dma_free_coherent(ena_dev->dmadev,
+			  sizeof(*phc->virt_addr),
+			  phc->virt_addr,
+			  phc->phys_addr);
+	phc->virt_addr = NULL;
+}
+
+int ena_com_phc_get_timestamp(struct ena_com_dev *ena_dev, u64 *timestamp)
+{
+	volatile struct ena_admin_phc_resp *resp = ena_dev->phc.virt_addr;
+	const ktime_t zero_system_time = ktime_set(0, 0);
+	struct ena_com_phc_info *phc = &ena_dev->phc;
+	ktime_t expire_time;
+	ktime_t block_time;
+	unsigned long flags = 0;
+	int ret = 0;
+
+	if (!phc->active) {
+		netdev_err(ena_dev->net_device, "PHC feature is not active in the device\n");
+		return -EOPNOTSUPP;
+	}
+
+	spin_lock_irqsave(&phc->lock, flags);
+
+	/* Check if PHC is in blocked state */
+	if (unlikely(ktime_compare(phc->system_time, zero_system_time))) {
+		/* Check if blocking time expired */
+		block_time = ktime_add_us(phc->system_time, phc->block_timeout_usec);
+		if (!ktime_after(ktime_get(), block_time)) {
+			/* PHC is still in blocked state, skip PHC request */
+			phc->stats.phc_skp++;
+			ret = -EBUSY;
+			goto skip;
+		}
+
+		/* PHC is in active state, update statistics according
+		 * to req_id and error_flags
+		 */
+		if (READ_ONCE(resp->req_id) != phc->req_id) {
+			/* Device didn't update req_id during blocking time,
+			 * this indicates on a device error
+			 */
+			netdev_err(ena_dev->net_device,
+				   "PHC get time request 0x%x failed (device error)\n",
+				   phc->req_id);
+			phc->stats.phc_err_dv++;
+		} else if (resp->error_flags & ENA_PHC_ERROR_FLAGS) {
+			/* Device updated req_id during blocking time but got
+			 * a PHC error, this occurs if device:
+			 * - exceeded the get time request limit
+			 * - received an invalid timestamp
+			 */
+			netdev_err(ena_dev->net_device,
+				   "PHC get time request 0x%x failed (error 0x%x)\n",
+				   phc->req_id,
+				   resp->error_flags);
+			phc->stats.phc_err_ts += !!(resp->error_flags &
+				ENA_ADMIN_PHC_ERROR_FLAG_TIMESTAMP);
+		} else {
+			/* Device updated req_id during blocking time
+			 * with valid timestamp
+			 */
+			phc->stats.phc_exp++;
+		}
+	}
+
+	/* Setting relative timeouts */
+	phc->system_time = ktime_get();
+	block_time = ktime_add_us(phc->system_time, phc->block_timeout_usec);
+	expire_time = ktime_add_us(phc->system_time, phc->expire_timeout_usec);
+
+	/* We expect the device to return this req_id once
+	 * the new PHC timestamp is updated
+	 */
+	phc->req_id++;
+
+	/* Initialize PHC shared memory with different req_id value
+	 * to be able to identify once the device changes it to req_id
+	 */
+	resp->req_id = phc->req_id + ENA_PHC_REQ_ID_OFFSET;
+
+	/* Writing req_id to PHC bar */
+	writel(phc->req_id, ena_dev->reg_bar + phc->doorbell_offset);
+
+	/* Stalling until the device updates req_id */
+	while (1) {
+		if (unlikely(ktime_after(ktime_get(), expire_time))) {
+			/* Gave up waiting for updated req_id, PHC enters into
+			 * blocked state until passing blocking time,
+			 * during this time any get PHC timestamp will fail with
+			 * device busy error
+			 */
+			ret = -EBUSY;
+			break;
+		}
+
+		/* Check if req_id was updated by the device */
+		if (READ_ONCE(resp->req_id) != phc->req_id) {
+			/* req_id was not updated by the device yet,
+			 * check again on next loop
+			 */
+			continue;
+		}
+
+		/* req_id was updated by the device which indicates that
+		 * PHC timestamp and error_flags are updated too,
+		 * checking errors before retrieving timestamp
+		 */
+		if (unlikely(resp->error_flags & ENA_PHC_ERROR_FLAGS)) {
+			/* Retrieved invalid PHC timestamp, PHC enters into
+			 * blocked state until passing blocking time,
+			 * during this time any get PHC timestamp requests
+			 * will fail with device busy error
+			 */
+			ret = -EBUSY;
+			break;
+		}
+
+		/* PHC timestamp value is returned to the caller */
+		*timestamp = resp->timestamp;
+
+		/* Update statistic on valid PHC timestamp retrieval */
+		phc->stats.phc_cnt++;
+
+		/* This indicates PHC state is active */
+		phc->system_time = zero_system_time;
+		break;
+	}
+
+skip:
+	spin_unlock_irqrestore(&phc->lock, flags);
+
+	return ret;
+}
+
 int ena_com_mmio_reg_read_request_init(struct ena_com_dev *ena_dev)
 {
 	struct ena_com_mmio_read *mmio_read = &ena_dev->mmio_read;
diff --git a/drivers/net/ethernet/amazon/ena/ena_com.h b/drivers/net/ethernet/amazon/ena/ena_com.h
index 9414e93d..64df2c48 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.h
+++ b/drivers/net/ethernet/amazon/ena/ena_com.h
@@ -210,6 +210,14 @@ struct ena_com_stats_admin {
 	u64 no_completion;
 };
 
+struct ena_com_stats_phc {
+	u64 phc_cnt;
+	u64 phc_exp;
+	u64 phc_skp;
+	u64 phc_err_dv;
+	u64 phc_err_ts;
+};
+
 struct ena_com_admin_queue {
 	void *q_dmadev;
 	struct ena_com_dev *ena_dev;
@@ -258,6 +266,47 @@ struct ena_com_mmio_read {
 	spinlock_t lock;
 };
 
+/* PTP hardware clock (PHC) MMIO read data info */
+struct ena_com_phc_info {
+	/* Internal PHC statistics */
+	struct ena_com_stats_phc stats;
+
+	/* PHC shared memory - virtual address */
+	struct ena_admin_phc_resp *virt_addr;
+
+	/* System time of last PHC request */
+	ktime_t system_time;
+
+	/* Spin lock to ensure a single outstanding PHC read */
+	spinlock_t lock;
+
+	/* PHC doorbell address as an offset to PCIe MMIO REG BAR */
+	u32 doorbell_offset;
+
+	/* Shared memory read expire timeout (usec)
+	 * Max time for valid PHC retrieval, passing this threshold will fail
+	 * the get time request and block new PHC requests for block_timeout_usec
+	 * in order to prevent floods on busy device
+	 */
+	u32 expire_timeout_usec;
+
+	/* Shared memory read abort timeout (usec)
+	 * PHC requests block period, blocking starts once PHC request expired
+	 * in order to prevent floods on busy device,
+	 * any PHC requests during block period will be skipped
+	 */
+	u32 block_timeout_usec;
+
+	/* PHC shared memory - physical address */
+	dma_addr_t phys_addr;
+
+	/* Request id sent to the device */
+	u16 req_id;
+
+	/* True if PHC is active in the device */
+	bool active;
+};
+
 struct ena_rss {
 	/* Indirect table */
 	u16 *host_rss_ind_tbl;
@@ -317,6 +366,7 @@ struct ena_com_dev {
 	u32 ena_min_poll_delay_us;
 
 	struct ena_com_mmio_read mmio_read;
+	struct ena_com_phc_info phc;
 
 	struct ena_rss rss;
 	u32 supported_features;
@@ -382,6 +432,40 @@ struct ena_aenq_handlers {
  */
 int ena_com_mmio_reg_read_request_init(struct ena_com_dev *ena_dev);
 
+/* ena_com_phc_init - Allocate and initialize PHC feature
+ * @ena_dev: ENA communication layer struct
+ * @note: This method assumes PHC is supported by the device
+ * @return - 0 on success, negative value on failure
+ */
+int ena_com_phc_init(struct ena_com_dev *ena_dev);
+
+/* ena_com_phc_supported - Return if PHC feature is supported by the device
+ * @ena_dev: ENA communication layer struct
+ * @note: This method must be called after getting supported features
+ * @return - supported or not
+ */
+bool ena_com_phc_supported(struct ena_com_dev *ena_dev);
+
+/* ena_com_phc_config - Configure PHC feature
+ * @ena_dev: ENA communication layer struct
+ * Configure PHC feature in driver and device
+ * @note: This method assumes PHC is supported by the device
+ * @return - 0 on success, negative value on failure
+ */
+int ena_com_phc_config(struct ena_com_dev *ena_dev);
+
+/* ena_com_phc_destroy - Destroy PHC feature
+ * @ena_dev: ENA communication layer struct
+ */
+void ena_com_phc_destroy(struct ena_com_dev *ena_dev);
+
+/* ena_com_phc_get_timestamp - Retrieve PHC timestamp
+ * @ena_dev: ENA communication layer struct
+ * @timestamp: Retrieved PHC timestamp
+ * @return - 0 on success, negative value on failure
+ */
+int ena_com_phc_get_timestamp(struct ena_com_dev *ena_dev, u64 *timestamp);
+
 /* ena_com_set_mmio_read_mode - Enable/disable the indirect mmio reg read mechanism
  * @ena_dev: ENA communication layer struct
  * @readless_supported: readless mode (enable/disable)
diff --git a/drivers/net/ethernet/amazon/ena/ena_ethtool.c b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
index a3c934c3..b442d247 100644
--- a/drivers/net/ethernet/amazon/ena/ena_ethtool.c
+++ b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
@@ -5,9 +5,11 @@
 
 #include <linux/ethtool.h>
 #include <linux/pci.h>
+#include <linux/net_tstamp.h>
 
 #include "ena_netdev.h"
 #include "ena_xdp.h"
+#include "ena_phc.h"
 
 struct ena_stats {
 	char name[ETH_GSTRING_LEN];
@@ -298,6 +300,18 @@ static void ena_get_ethtool_stats(struct net_device *netdev,
 	ena_get_stats(adapter, data, true);
 }
 
+static int ena_get_ts_info(struct net_device *netdev,
+			   struct kernel_ethtool_ts_info *info)
+{
+	struct ena_adapter *adapter = netdev_priv(netdev);
+
+	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE;
+
+	info->phc_index = ena_phc_get_index(adapter);
+
+	return 0;
+}
+
 static int ena_get_sw_stats_count(struct ena_adapter *adapter)
 {
 	return adapter->num_io_queues * (ENA_STATS_ARRAY_TX + ENA_STATS_ARRAY_RX)
@@ -1107,7 +1121,7 @@ static const struct ethtool_ops ena_ethtool_ops = {
 	.set_channels		= ena_set_channels,
 	.get_tunable		= ena_get_tunable,
 	.set_tunable		= ena_set_tunable,
-	.get_ts_info            = ethtool_op_get_ts_info,
+	.get_ts_info		= ena_get_ts_info,
 };
 
 void ena_set_ethtool_ops(struct net_device *netdev)
diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 86fd08f3..14a85916 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -19,6 +19,8 @@
 #include "ena_pci_id_tbl.h"
 #include "ena_xdp.h"
 
+#include "ena_phc.h"
+
 MODULE_AUTHOR("Amazon.com, Inc. or its affiliates");
 MODULE_DESCRIPTION(DEVICE_NAME);
 MODULE_LICENSE("GPL");
@@ -2743,7 +2745,8 @@ static void ena_config_host_info(struct ena_com_dev *ena_dev, struct pci_dev *pd
 		ENA_ADMIN_HOST_INFO_INTERRUPT_MODERATION_MASK |
 		ENA_ADMIN_HOST_INFO_RX_BUF_MIRRORING_MASK |
 		ENA_ADMIN_HOST_INFO_RSS_CONFIGURABLE_FUNCTION_KEY_MASK |
-		ENA_ADMIN_HOST_INFO_RX_PAGE_REUSE_MASK;
+		ENA_ADMIN_HOST_INFO_RX_PAGE_REUSE_MASK |
+		ENA_ADMIN_HOST_INFO_PHC_MASK;
 
 	rc = ena_com_set_host_attributes(ena_dev);
 	if (rc) {
@@ -3188,6 +3191,10 @@ static int ena_device_init(struct ena_adapter *adapter, struct pci_dev *pdev,
 	if (unlikely(rc))
 		goto err_admin_init;
 
+	rc = ena_phc_init(adapter);
+	if (unlikely(rc && (rc != -EOPNOTSUPP)))
+		netdev_err(netdev, "Failed initializing PHC, error: %d\n", rc);
+
 	return 0;
 
 err_admin_init:
@@ -3271,6 +3278,8 @@ static int ena_destroy_device(struct ena_adapter *adapter, bool graceful)
 
 	ena_com_admin_destroy(ena_dev);
 
+	ena_phc_destroy(adapter);
+
 	ena_com_mmio_reg_read_request_destroy(ena_dev);
 
 	/* return reset reason to default value */
@@ -3344,6 +3353,7 @@ err_device_destroy:
 	ena_com_wait_for_abort_completion(ena_dev);
 	ena_com_admin_destroy(ena_dev);
 	ena_com_dev_reset(ena_dev, ENA_REGS_RESET_DRIVER_INVALID_STATE);
+	ena_phc_destroy(adapter);
 	ena_com_mmio_reg_read_request_destroy(ena_dev);
 err:
 	clear_bit(ENA_FLAG_DEVICE_RUNNING, &adapter->flags);
@@ -3932,10 +3942,16 @@ static int ena_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	pci_set_drvdata(pdev, adapter);
 
+	rc = ena_phc_alloc(adapter);
+	if (rc) {
+		netdev_err(netdev, "ena_phc_alloc failed\n");
+		goto err_netdev_destroy;
+	}
+
 	rc = ena_com_allocate_customer_metrics_buffer(ena_dev);
 	if (rc) {
 		netdev_err(netdev, "ena_com_allocate_customer_metrics_buffer failed\n");
-		goto err_netdev_destroy;
+		goto err_free_phc;
 	}
 
 	rc = ena_map_llq_mem_bar(pdev, ena_dev, bars);
@@ -4072,6 +4088,8 @@ err_device_destroy:
 	ena_com_admin_destroy(ena_dev);
 err_metrics_destroy:
 	ena_com_delete_customer_metrics_buffer(ena_dev);
+err_free_phc:
+	ena_phc_free(adapter);
 err_netdev_destroy:
 	free_netdev(netdev);
 err_free_region:
@@ -4112,6 +4130,8 @@ static void __ena_shutoff(struct pci_dev *pdev, bool shutdown)
 	adapter->reset_reason = ENA_REGS_RESET_SHUTDOWN;
 	ena_destroy_device(adapter, true);
 
+	ena_phc_free(adapter);
+
 	if (shutdown) {
 		netif_device_detach(netdev);
 		dev_close(netdev);
diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.h b/drivers/net/ethernet/amazon/ena/ena_netdev.h
index 6e12ae3b..7867cd7f 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.h
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.h
@@ -110,6 +110,8 @@
 
 #define ENA_MMIO_DISABLE_REG_READ	BIT(0)
 
+struct ena_phc_info;
+
 struct ena_irq {
 	irq_handler_t handler;
 	void *data;
@@ -348,6 +350,8 @@ struct ena_adapter {
 
 	char name[ENA_NAME_MAX_LEN];
 
+	struct ena_phc_info *phc_info;
+
 	unsigned long flags;
 	/* TX */
 	struct ena_ring tx_ring[ENA_MAX_NUM_IO_QUEUES]
diff --git a/drivers/net/ethernet/amazon/ena/ena_phc.c b/drivers/net/ethernet/amazon/ena/ena_phc.c
new file mode 100644
index 00000000..612cf45e
--- /dev/null
+++ b/drivers/net/ethernet/amazon/ena/ena_phc.c
@@ -0,0 +1,223 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/*
+ * Copyright 2015-2022 Amazon.com, Inc. or its affiliates. All rights reserved.
+ */
+
+#include <linux/pci.h>
+#include "ena_netdev.h"
+#include "ena_phc.h"
+
+static int ena_phc_adjtime(struct ptp_clock_info *clock_info, s64 delta)
+{
+	return -EOPNOTSUPP;
+}
+
+static int ena_phc_adjfine(struct ptp_clock_info *clock_info, long scaled_ppm)
+{
+	return -EOPNOTSUPP;
+}
+
+static int ena_phc_feature_enable(struct ptp_clock_info *clock_info,
+				  struct ptp_clock_request *rq,
+				  int on)
+{
+	return -EOPNOTSUPP;
+}
+
+static int ena_phc_gettimex64(struct ptp_clock_info *clock_info,
+			      struct timespec64 *ts,
+			      struct ptp_system_timestamp *sts)
+{
+	struct ena_phc_info *phc_info =
+		container_of(clock_info, struct ena_phc_info, clock_info);
+	unsigned long flags;
+	u64 timestamp_nsec;
+	int rc;
+
+	spin_lock_irqsave(&phc_info->lock, flags);
+
+	ptp_read_system_prets(sts);
+
+	rc = ena_com_phc_get_timestamp(phc_info->adapter->ena_dev,
+				       &timestamp_nsec);
+
+	ptp_read_system_postts(sts);
+
+	spin_unlock_irqrestore(&phc_info->lock, flags);
+
+	*ts = ns_to_timespec64(timestamp_nsec);
+
+	return rc;
+}
+
+static int ena_phc_settime64(struct ptp_clock_info *clock_info,
+			     const struct timespec64 *ts)
+{
+	return -EOPNOTSUPP;
+}
+
+static struct ptp_clock_info ena_ptp_clock_info = {
+	.owner		= THIS_MODULE,
+	.n_alarm	= 0,
+	.n_ext_ts	= 0,
+	.n_per_out	= 0,
+	.pps		= 0,
+	.adjtime	= ena_phc_adjtime,
+	.adjfine	= ena_phc_adjfine,
+	.gettimex64	= ena_phc_gettimex64,
+	.settime64	= ena_phc_settime64,
+	.enable		= ena_phc_feature_enable,
+};
+
+/* Enable/Disable PHC by the kernel, affects on the next init flow */
+void ena_phc_enable(struct ena_adapter *adapter, bool enable)
+{
+	struct ena_phc_info *phc_info = adapter->phc_info;
+
+	if (!phc_info) {
+		netdev_err(adapter->netdev, "phc_info is not allocated\n");
+		return;
+	}
+
+	phc_info->enabled = enable;
+}
+
+/* Check if PHC is enabled by the kernel */
+bool ena_phc_is_enabled(struct ena_adapter *adapter)
+{
+	struct ena_phc_info *phc_info = adapter->phc_info;
+
+	return (phc_info && phc_info->enabled);
+}
+
+/* PHC is activated if ptp clock is registered in the kernel */
+bool ena_phc_is_active(struct ena_adapter *adapter)
+{
+	struct ena_phc_info *phc_info = adapter->phc_info;
+
+	return (phc_info && phc_info->clock);
+}
+
+static int ena_phc_register(struct ena_adapter *adapter)
+{
+	struct pci_dev *pdev = adapter->pdev;
+	struct ptp_clock_info *clock_info;
+	struct ena_phc_info *phc_info;
+	int rc = 0;
+
+	phc_info = adapter->phc_info;
+	clock_info = &phc_info->clock_info;
+
+	phc_info->adapter = adapter;
+
+	spin_lock_init(&phc_info->lock);
+
+	/* Fill the ptp_clock_info struct and register PTP clock */
+	*clock_info = ena_ptp_clock_info;
+	snprintf(clock_info->name,
+		 sizeof(clock_info->name),
+		 "ena-ptp-%02x",
+		 PCI_SLOT(pdev->devfn));
+
+	phc_info->clock = ptp_clock_register(clock_info, &pdev->dev);
+	if (IS_ERR(phc_info->clock)) {
+		rc = PTR_ERR(phc_info->clock);
+		netdev_err(adapter->netdev, "Failed registering ptp clock, error: %d\n",
+			   rc);
+		phc_info->clock = NULL;
+	}
+
+	return rc;
+}
+
+static void ena_phc_unregister(struct ena_adapter *adapter)
+{
+	struct ena_phc_info *phc_info = adapter->phc_info;
+
+	if (ena_phc_is_active(adapter)) {
+		ptp_clock_unregister(phc_info->clock);
+		phc_info->clock = NULL;
+	}
+}
+
+int ena_phc_alloc(struct ena_adapter *adapter)
+{
+	/* Allocate driver specific PHC info */
+	adapter->phc_info = vzalloc(sizeof(*adapter->phc_info));
+	if (unlikely(!adapter->phc_info)) {
+		netdev_err(adapter->netdev, "Failed to alloc phc_info\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+void ena_phc_free(struct ena_adapter *adapter)
+{
+	if (adapter->phc_info) {
+		vfree(adapter->phc_info);
+		adapter->phc_info = NULL;
+	}
+}
+
+int ena_phc_init(struct ena_adapter *adapter)
+{
+	struct ena_com_dev *ena_dev = adapter->ena_dev;
+	struct net_device *netdev = adapter->netdev;
+	int rc = -EOPNOTSUPP;
+
+	/* Validate PHC feature is supported in the device */
+	if (!ena_com_phc_supported(ena_dev)) {
+		netdev_dbg(netdev, "PHC feature is not supported by the device\n");
+		goto err_ena_com_phc_init;
+	}
+
+	/* Validate PHC feature is enabled by the kernel */
+	if (!ena_phc_is_enabled(adapter)) {
+		netdev_dbg(netdev, "PHC feature is not enabled by the kernel\n");
+		goto err_ena_com_phc_init;
+	}
+
+	/* Initialize device specific PHC info */
+	rc = ena_com_phc_init(ena_dev);
+	if (unlikely(rc)) {
+		netdev_err(netdev, "Failed to init phc, error: %d\n", rc);
+		goto err_ena_com_phc_init;
+	}
+
+	/* Configure PHC feature in driver and device */
+	rc = ena_com_phc_config(ena_dev);
+	if (unlikely(rc)) {
+		netdev_err(netdev, "Failed to config phc, error: %d\n", rc);
+		goto err_ena_com_phc_config;
+	}
+
+	/* Register to PTP class driver */
+	rc = ena_phc_register(adapter);
+	if (unlikely(rc)) {
+		netdev_err(netdev, "Failed to register phc, error: %d\n", rc);
+		goto err_ena_com_phc_config;
+	}
+
+	return 0;
+
+err_ena_com_phc_config:
+	ena_com_phc_destroy(ena_dev);
+err_ena_com_phc_init:
+	ena_phc_enable(adapter, false);
+	return rc;
+}
+
+void ena_phc_destroy(struct ena_adapter *adapter)
+{
+	ena_phc_unregister(adapter);
+	ena_com_phc_destroy(adapter->ena_dev);
+}
+
+int ena_phc_get_index(struct ena_adapter *adapter)
+{
+	if (ena_phc_is_active(adapter))
+		return ptp_clock_index(adapter->phc_info->clock);
+
+	return -1;
+}
diff --git a/drivers/net/ethernet/amazon/ena/ena_phc.h b/drivers/net/ethernet/amazon/ena/ena_phc.h
new file mode 100644
index 00000000..7364fe71
--- /dev/null
+++ b/drivers/net/ethernet/amazon/ena/ena_phc.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/*
+ * Copyright 2015-2022 Amazon.com, Inc. or its affiliates. All rights reserved.
+ */
+
+#ifndef ENA_PHC_H
+#define ENA_PHC_H
+
+#include <linux/ptp_clock_kernel.h>
+
+struct ena_phc_info {
+	/* PTP hardware capabilities */
+	struct ptp_clock_info clock_info;
+
+	/* Registered PTP clock device */
+	struct ptp_clock *clock;
+
+	/* Adapter specific private data structure */
+	struct ena_adapter *adapter;
+
+	/* PHC lock */
+	spinlock_t lock;
+
+	/* Enabled by kernel */
+	bool enabled;
+};
+
+void ena_phc_enable(struct ena_adapter *adapter, bool enable);
+bool ena_phc_is_enabled(struct ena_adapter *adapter);
+bool ena_phc_is_active(struct ena_adapter *adapter);
+int ena_phc_get_index(struct ena_adapter *adapter);
+int ena_phc_init(struct ena_adapter *adapter);
+void ena_phc_destroy(struct ena_adapter *adapter);
+int ena_phc_alloc(struct ena_adapter *adapter);
+void ena_phc_free(struct ena_adapter *adapter);
+
+#endif /* ENA_PHC_H */
diff --git a/drivers/net/ethernet/amazon/ena/ena_regs_defs.h b/drivers/net/ethernet/amazon/ena/ena_regs_defs.h
index a2efebaf..51068dc1 100644
--- a/drivers/net/ethernet/amazon/ena/ena_regs_defs.h
+++ b/drivers/net/ethernet/amazon/ena/ena_regs_defs.h
@@ -53,6 +53,11 @@ enum ena_regs_reset_reason_types {
 #define ENA_REGS_MMIO_RESP_HI_OFF                           0x64
 #define ENA_REGS_RSS_IND_ENTRY_UPDATE_OFF                   0x68
 
+/* phc_registers offsets */
+
+/* 100 base */
+#define ENA_REGS_PHC_DB_OFF                                 0x100
+
 /* version register */
 #define ENA_REGS_VERSION_MINOR_VERSION_MASK                 0xff
 #define ENA_REGS_VERSION_MAJOR_VERSION_SHIFT                8
@@ -129,4 +134,7 @@ enum ena_regs_reset_reason_types {
 #define ENA_REGS_RSS_IND_ENTRY_UPDATE_CQ_IDX_SHIFT          16
 #define ENA_REGS_RSS_IND_ENTRY_UPDATE_CQ_IDX_MASK           0xffff0000
 
+/* phc_db_req_id register */
+#define ENA_REGS_PHC_DB_REQ_ID_MASK                         0xffff
+
 #endif /* _ENA_REGS_H_ */
-- 
2.47.1


