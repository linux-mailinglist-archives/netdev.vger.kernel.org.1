Return-Path: <netdev+bounces-128105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA219780A7
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 15:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CD421C20B85
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 13:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDE21DA2F5;
	Fri, 13 Sep 2024 13:05:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-5.mail.aliyun.com (out28-5.mail.aliyun.com [115.124.28.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD781C2DBA;
	Fri, 13 Sep 2024 13:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726232748; cv=none; b=QBghAFjRBWZa/o3wJdWdxBMQexvaGeC25RlvtVJzgh110jzS4HxcICT4exPUGC4t1P6NLhMUBx2OKEZmrfgWXSQhdhwq7kq0MG1mgMJSRNpLr4k2vkq6Z8uyAtqeuVuYC3KIw2aPTa9XX9TDrG30DB8Thjt51n8SMSWLzCIZKVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726232748; c=relaxed/simple;
	bh=Yl8h4AYOhbBcMn1FiMawuYicn/p5oJGx+kIGrICFKbQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rAkEjAYH3Z7kR/vWpzGmB0MDnDCrNMFes79BiPGcBLbt8TSWVLQ0VOrxpFR/XJBkRNThGt6mPIMTsE5z6UHsPHJyFCD5kw5kxbXUGkJQo2wfuyACm4tPvnpaKMVXBLuqCoP71bpef+XySJzEB1Ht/Kb5FlDbCeF6tgtCHjaqecw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from sun-VirtualBox..(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.ZIMvdsH_1726231273)
          by smtp.aliyun-inc.com;
          Fri, 13 Sep 2024 20:41:24 +0800
From: Frank Sae <Frank.Sae@motor-comm.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xiaogang.fan@motor-comm.com,
	fei.zhang@motor-comm.com,
	hua.sun@motor-comm.com,
	Frank.Sae@motor-comm.com
Subject: [RFC] net:yt6801: Add Motorcomm yt6801 PCIe driver
Date: Fri, 13 Sep 2024 21:00:04 +0800
Message-Id: <20240913124113.9174-1-Frank.Sae@motor-comm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch is to add the ethernet device driver for the PCIe interface of
Motorcomm YT6801 Gigabit Ethernet.

We tested this driver on an Ubuntu x86 PC with YT6801 network card.

Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>
---
 .../device_drivers/ethernet/index.rst         |    1 +
 .../ethernet/motorcomm/yt6801.rst             |   20 +
 MAINTAINERS                                   |    8 +
 drivers/net/ethernet/Kconfig                  |    1 +
 drivers/net/ethernet/Makefile                 |    1 +
 drivers/net/ethernet/motorcomm/Kconfig        |   27 +
 drivers/net/ethernet/motorcomm/Makefile       |    6 +
 .../net/ethernet/motorcomm/yt6801/Makefile    |   11 +
 .../net/ethernet/motorcomm/yt6801/yt6801.h    |  698 ++++
 .../ethernet/motorcomm/yt6801/yt6801_common.c |  787 ++++
 .../ethernet/motorcomm/yt6801/yt6801_desc.c   |  739 ++++
 .../ethernet/motorcomm/yt6801/yt6801_desc.h   |   40 +
 .../ethernet/motorcomm/yt6801/yt6801_efuse.c  |  214 ++
 .../ethernet/motorcomm/yt6801/yt6801_efuse.h  |   16 +
 .../motorcomm/yt6801/yt6801_ethtool.c         | 1143 ++++++
 .../net/ethernet/motorcomm/yt6801/yt6801_hw.c | 3344 +++++++++++++++++
 .../ethernet/motorcomm/yt6801/yt6801_net.c    | 2476 ++++++++++++
 .../ethernet/motorcomm/yt6801/yt6801_net.h    |   33 +
 .../ethernet/motorcomm/yt6801/yt6801_pci.c    |  250 ++
 .../ethernet/motorcomm/yt6801/yt6801_phy.c    |  292 ++
 .../ethernet/motorcomm/yt6801/yt6801_phy.h    |   48 +
 .../ethernet/motorcomm/yt6801/yt6801_type.h   | 1567 ++++++++
 22 files changed, 11722 insertions(+)
 create mode 100755 Documentation/networking/device_drivers/ethernet/motorcomm/yt6801.rst
 create mode 100644 drivers/net/ethernet/motorcomm/Kconfig
 create mode 100644 drivers/net/ethernet/motorcomm/Makefile
 create mode 100644 drivers/net/ethernet/motorcomm/yt6801/Makefile
 create mode 100644 drivers/net/ethernet/motorcomm/yt6801/yt6801.h
 create mode 100644 drivers/net/ethernet/motorcomm/yt6801/yt6801_common.c
 create mode 100644 drivers/net/ethernet/motorcomm/yt6801/yt6801_desc.c
 create mode 100644 drivers/net/ethernet/motorcomm/yt6801/yt6801_desc.h
 create mode 100644 drivers/net/ethernet/motorcomm/yt6801/yt6801_efuse.c
 create mode 100644 drivers/net/ethernet/motorcomm/yt6801/yt6801_efuse.h
 create mode 100644 drivers/net/ethernet/motorcomm/yt6801/yt6801_ethtool.c
 create mode 100644 drivers/net/ethernet/motorcomm/yt6801/yt6801_hw.c
 create mode 100644 drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
 create mode 100644 drivers/net/ethernet/motorcomm/yt6801/yt6801_net.h
 create mode 100644 drivers/net/ethernet/motorcomm/yt6801/yt6801_pci.c
 create mode 100644 drivers/net/ethernet/motorcomm/yt6801/yt6801_phy.c
 create mode 100644 drivers/net/ethernet/motorcomm/yt6801/yt6801_phy.h
 create mode 100644 drivers/net/ethernet/motorcomm/yt6801/yt6801_type.h

diff --git a/Documentation/networking/device_drivers/ethernet/index.rst b/Documentation/networking/device_drivers/ethernet/index.rst
index 6932d8c..7b9a245 100644
--- a/Documentation/networking/device_drivers/ethernet/index.rst
+++ b/Documentation/networking/device_drivers/ethernet/index.rst
@@ -45,6 +45,7 @@ Contents:
    marvell/octeon_ep_vf
    mellanox/mlx5/index
    microsoft/netvsc
+   motorcomm/yt6801
    neterion/s2io
    netronome/nfp
    pensando/ionic
diff --git a/Documentation/networking/device_drivers/ethernet/motorcomm/yt6801.rst b/Documentation/networking/device_drivers/ethernet/motorcomm/yt6801.rst
new file mode 100755
index 0000000..dd1e59c
--- /dev/null
+++ b/Documentation/networking/device_drivers/ethernet/motorcomm/yt6801.rst
@@ -0,0 +1,20 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+================================================================
+Linux Base Driver for Motorcomm(R) Gigabit PCI Express Adapters
+================================================================
+
+Motorcomm Gigabit Linux driver.
+Copyright (c) 2021 - 2024 Motor-comm Co., Ltd.
+
+
+Contents
+========
+
+- Support
+
+
+Support
+=======
+If you got any problem, contact Motorcomm support team via support@motor-comm.com
+and Cc: netdev.
diff --git a/MAINTAINERS b/MAINTAINERS
index 1043077..1a13027 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15505,6 +15505,14 @@ F:	drivers/most/
 F:	drivers/staging/most/
 F:	include/linux/most.h
 
+MOTORCOMM ETHERNET DRIVER
+M:	Frank <Frank.Sae@motor-comm.com>
+L:	netdev@vger.kernel.org
+S:	Maintained
+W:	https://www.motor-comm.com/
+F:	Documentation/networking/device_drivers/ethernet/motorcomm/*
+F:	drivers/net/ethernet/motorcomm/*
+
 MOTORCOMM PHY DRIVER
 M:	Frank <Frank.Sae@motor-comm.com>
 L:	netdev@vger.kernel.org
diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
index 0baac25..cd5bb66 100644
--- a/drivers/net/ethernet/Kconfig
+++ b/drivers/net/ethernet/Kconfig
@@ -127,6 +127,7 @@ source "drivers/net/ethernet/micrel/Kconfig"
 source "drivers/net/ethernet/microchip/Kconfig"
 source "drivers/net/ethernet/mscc/Kconfig"
 source "drivers/net/ethernet/microsoft/Kconfig"
+source "drivers/net/ethernet/motorcomm/Kconfig"
 source "drivers/net/ethernet/moxa/Kconfig"
 source "drivers/net/ethernet/myricom/Kconfig"
 
diff --git a/drivers/net/ethernet/Makefile b/drivers/net/ethernet/Makefile
index c032034..1a96beb 100644
--- a/drivers/net/ethernet/Makefile
+++ b/drivers/net/ethernet/Makefile
@@ -63,6 +63,7 @@ obj-$(CONFIG_NET_VENDOR_META) += meta/
 obj-$(CONFIG_NET_VENDOR_MICREL) += micrel/
 obj-$(CONFIG_NET_VENDOR_MICROCHIP) += microchip/
 obj-$(CONFIG_NET_VENDOR_MICROSEMI) += mscc/
+obj-$(CONFIG_NET_VENDOR_MOTORCOMM) += motorcomm/
 obj-$(CONFIG_NET_VENDOR_MOXART) += moxa/
 obj-$(CONFIG_NET_VENDOR_MYRI) += myricom/
 obj-$(CONFIG_FEALNX) += fealnx.o
diff --git a/drivers/net/ethernet/motorcomm/Kconfig b/drivers/net/ethernet/motorcomm/Kconfig
new file mode 100644
index 0000000..e85d116
--- /dev/null
+++ b/drivers/net/ethernet/motorcomm/Kconfig
@@ -0,0 +1,27 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Motorcomm network device configuration
+#
+
+config NET_VENDOR_MOTORCOMM
+	bool "Motorcomm devices"
+	default y
+	help
+	  If you have a network (Ethernet) device belonging to this class,
+	  say Y.
+
+	  Note that the answer to this question doesn't directly affect the
+	  kernel: saying N will just cause the configurator to skip all
+	  the questions about Synopsys devices. If you say Y, you will be asked
+	  for your specific device in the following questions.
+
+if NET_VENDOR_MOTORCOMM
+
+config YT6801
+	tristate "Motorcomm(R) 6801 PCI-Express Gigabit Ethernet support"
+	depends on PCI && NET
+	help
+	  This driver supports Motorcomm(R) 6801 gigabit ethernet family of
+	  adapters.
+
+endif # NET_VENDOR_MOTORCOMM
diff --git a/drivers/net/ethernet/motorcomm/Makefile b/drivers/net/ethernet/motorcomm/Makefile
new file mode 100644
index 0000000..5119406
--- /dev/null
+++ b/drivers/net/ethernet/motorcomm/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for the Motorcomm network device drivers.
+#
+
+obj-$(CONFIG_YT6801) += yt6801/
diff --git a/drivers/net/ethernet/motorcomm/yt6801/Makefile b/drivers/net/ethernet/motorcomm/yt6801/Makefile
new file mode 100644
index 0000000..5a23bcb
--- /dev/null
+++ b/drivers/net/ethernet/motorcomm/yt6801/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2021 Motor-comm Corporation.
+#
+# Makefile for the Motorcomm(R) 6801 PCI-Express ethernet driver
+#
+
+obj-$(CONFIG_YT6801) += yt6801.o
+yt6801-objs :=  yt6801_common.o yt6801_desc.o \
+		yt6801_ethtool.o yt6801_hw.o \
+		yt6801_net.o yt6801_pci.o \
+		yt6801_phy.o yt6801_efuse.o \
diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801.h b/drivers/net/ethernet/motorcomm/yt6801/yt6801.h
new file mode 100644
index 0000000..0ed065f
--- /dev/null
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801.h
@@ -0,0 +1,698 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Copyright (c) 2022 - 2024 Motorcomm Electronic Technology Co.,Ltd. */
+
+#ifndef _YT6801_H_
+#define _YT6801_H_
+
+#include <linux/dma-mapping.h>
+#include <linux/timecounter.h>
+#include <linux/pm_wakeup.h>
+#include <linux/workqueue.h>
+#include <linux/crc32poly.h>
+#include <linux/if_vlan.h>
+#include <linux/bitrev.h>
+#include <linux/bitops.h>
+#include <linux/mdio.h>
+#include <linux/phy.h>
+
+#ifdef CONFIG_PCI_MSI
+#include <linux/pci.h>
+#endif
+
+#include "yt6801_type.h"
+
+#define FXGMAC_DRV_VERSION		"1.0.29"
+#define FXGMAC_DRV_NAME			"yt6801"
+#define FXGMAC_DRV_DESC			"Motorcomm Gigabit Ethernet Driver"
+
+#define FXGMAC_RX_BUF_ALIGN		64
+#define FXGMAC_TX_MAX_BUF_SIZE		(0x3fff & ~(FXGMAC_RX_BUF_ALIGN - 1))
+#define FXGMAC_RX_MIN_BUF_SIZE		(ETH_FRAME_LEN + ETH_FCS_LEN + VLAN_HLEN)
+
+/* Descriptors required for maximum contiguous TSO/GSO packet */
+#define FXGMAC_TX_MAX_SPLIT		((GSO_MAX_SIZE / FXGMAC_TX_MAX_BUF_SIZE) + 1)
+
+/* Maximum possible descriptors needed for a SKB */
+#define FXGMAC_TX_MAX_DESC_NR	(MAX_SKB_FRAGS + FXGMAC_TX_MAX_SPLIT + 2)
+
+#define FXGMAC_DMA_STOP_TIMEOUT			5
+#define FXGMAC_MAX_FLOW_CONTROL_QUEUES		8 /* Flow control queue count */
+
+/* Receive Side Scaling */
+#define FXGMAC_RSS_HASH_KEY_SIZE		40
+#define FXGMAC_RSS_MAX_TABLE_SIZE		128
+#define FXGMAC_RSS_LOOKUP_TABLE_TYPE		0
+#define FXGMAC_RSS_HASH_KEY_TYPE		1
+
+#define FXGMAC_JUMBO_PACKET_MTU			9014
+#define FXGMAC_DATA_WIDTH			128
+
+#define FXGMAC_MAX_DMA_RX_CHANNELS		4
+#define FXGMAC_MAX_DMA_TX_CHANNELS		1
+#define FXGMAC_MAX_DMA_CHANNELS                                                \
+	(FXGMAC_MAX_DMA_RX_CHANNELS + FXGMAC_MAX_DMA_TX_CHANNELS)
+
+#define FXGMAC_PHY_INT_NUM	1
+#define FXGMAC_MSIX_INT_NUMS	(FXGMAC_MAX_DMA_CHANNELS + FXGMAC_PHY_INT_NUM)
+
+/* wol pattern settings */
+#define MAX_PATTERN_SIZE		128	/* PATTERN length */
+#define MAX_PATTERN_COUNT		16	/* pattern count */
+
+struct wol_bitmap_pattern {
+	u32 flags;
+	u32 pattern_size;
+	u32 mask_size;
+	u8 mask_info[MAX_PATTERN_SIZE / 8];
+	u8 pattern_info[MAX_PATTERN_SIZE];
+	u8 pattern_offset;
+	u16 pattern_crc;
+};
+
+struct led_setting {
+#define LED_CFG_LEN	5
+	u32 disable[LED_CFG_LEN];	/* disable */
+	u32 s5[LED_CFG_LEN];		/* shutdown */
+	u32 s3[LED_CFG_LEN];		/* sleep */
+	u32 s0[LED_CFG_LEN];		/* active */
+};
+
+enum _wake_reason {
+	WAKE_REASON_NONE = 0,
+	WAKE_REASON_MAGIC,
+	WAKE_REASON_PATTERNMATCH,
+	WAKE_REASON_LINK,
+	WAKE_REASON_TCPSYNV4,
+	WAKE_REASON_TCPSYNV6,
+	/* for wake up method like Link-change, GMAC cannot
+	 * identify and need more checking.
+	 */
+	WAKE_REASON_TBD,
+	WAKE_REASON_HW_ERR,
+};
+
+enum fxgmac_int {
+	FXGMAC_INT_DMA_CH_SR_TI,
+	FXGMAC_INT_DMA_CH_SR_TPS,
+	FXGMAC_INT_DMA_CH_SR_TBU,
+	FXGMAC_INT_DMA_CH_SR_RI,
+	FXGMAC_INT_DMA_CH_SR_RBU,
+	FXGMAC_INT_DMA_CH_SR_RPS,
+	FXGMAC_INT_DMA_CH_SR_TI_RI,
+	FXGMAC_INT_DMA_CH_SR_FBE,
+	FXGMAC_INT_DMA_ALL,
+};
+
+struct fxgmac_stats {
+	/* MMC TX counters */
+	u64 txoctetcount_gb;
+	u64 txframecount_gb;
+	u64 txbroadcastframes_g;
+	u64 txmulticastframes_g;
+	u64 tx64octets_gb;
+	u64 tx65to127octets_gb;
+	u64 tx128to255octets_gb;
+	u64 tx256to511octets_gb;
+	u64 tx512to1023octets_gb;
+	u64 tx1024tomaxoctets_gb;
+	u64 txunicastframes_gb;
+	u64 txmulticastframes_gb;
+	u64 txbroadcastframes_gb;
+	u64 txunderflowerror;
+	u64 txsinglecollision_g;
+	u64 txmultiplecollision_g;
+	u64 txdeferredframes;
+	u64 txlatecollisionframes;
+	u64 txexcessivecollisionframes;
+	u64 txcarriererrorframes;
+	u64 txoctetcount_g;
+	u64 txframecount_g;
+	u64 txexcessivedeferralerror;
+	u64 txpauseframes;
+	u64 txvlanframes_g;
+	u64 txoversize_g;
+
+	/* MMC RX counters */
+	u64 rxframecount_gb;
+	u64 rxoctetcount_gb;
+	u64 rxoctetcount_g;
+	u64 rxbroadcastframes_g;
+	u64 rxmulticastframes_g;
+	u64 rxcrcerror;
+	u64 rxalignerror;
+	u64 rxrunterror;
+	u64 rxjabbererror;
+	u64 rxundersize_g;
+	u64 rxoversize_g;
+	u64 rx64octets_gb;
+	u64 rx65to127octets_gb;
+	u64 rx128to255octets_gb;
+	u64 rx256to511octets_gb;
+	u64 rx512to1023octets_gb;
+	u64 rx1024tomaxoctets_gb;
+	u64 rxunicastframes_g;
+	u64 rxlengtherror;
+	u64 rxoutofrangetype;
+	u64 rxpauseframes;
+	u64 rxfifooverflow;
+	u64 rxvlanframes_gb;
+	u64 rxwatchdogerror;
+	u64 rxreceiveerrorframe;
+	u64 rxcontrolframe_g;
+
+	/* Extra counters */
+	u64 tx_tso_packets;
+	u64 rx_split_header_packets;
+	u64 tx_process_stopped;
+	u64 rx_process_stopped;
+	u64 tx_buffer_unavailable;
+	u64 rx_buffer_unavailable;
+	u64 fatal_bus_error;
+	u64 tx_vlan_packets;
+	u64 rx_vlan_packets;
+	u64 napi_poll_isr;
+	u64 napi_poll_txtimer;
+	u64 cnt_alive_txtimer;
+	u64 ephy_poll_timer_cnt;
+	u64 mgmt_int_isr;
+};
+
+struct fxgmac_ring_buf {
+	struct sk_buff *skb;
+	dma_addr_t skb_dma;
+	unsigned int skb_len;
+};
+
+/* Common Tx and Rx DMA hardware descriptor */
+struct fxgmac_dma_desc {
+	__le32 desc0;
+	__le32 desc1;
+	__le32 desc2;
+	__le32 desc3;
+};
+
+/* Page allocation related values */
+struct fxgmac_page_alloc {
+	struct page *pages;
+	unsigned int pages_len;
+	unsigned int pages_offset;
+	dma_addr_t pages_dma;
+};
+
+/* Ring entry buffer data */
+struct fxgmac_buffer_data {
+	struct fxgmac_page_alloc pa;
+	struct fxgmac_page_alloc pa_unmap;
+
+	dma_addr_t dma_base;
+	unsigned long dma_off;
+	unsigned int dma_len;
+};
+
+/* Tx-related desc data */
+struct fxgmac_tx_desc_data {
+	unsigned int packets;		/* BQL packet count */
+	unsigned int bytes;		/* BQL byte count */
+};
+
+/* Rx-related desc data */
+struct fxgmac_rx_desc_data {
+	struct fxgmac_buffer_data hdr;	/* Header locations */
+	struct fxgmac_buffer_data buf;	/* Payload locations */
+	unsigned short hdr_len;		/* Length of received header */
+	unsigned short len;		/* Length of received packet */
+};
+
+struct fxgmac_pkt_info {
+	struct sk_buff *skb;
+	unsigned int attributes;
+	unsigned int errors;
+
+	/* descriptors needed for this packet */
+	unsigned int desc_count;
+	unsigned int length;
+	unsigned int tx_packets;
+	unsigned int tx_bytes;
+
+	unsigned int header_len;
+	unsigned int tcp_header_len;
+	unsigned int tcp_payload_len;
+	unsigned short mss;
+	unsigned short vlan_ctag;
+
+	u64 rx_tstamp;
+	u32 rss_hash;
+	enum pkt_hash_types rss_hash_type;
+};
+
+struct fxgmac_desc_data {
+	struct fxgmac_dma_desc *dma_desc;  /* Virtual address of descriptor */
+	dma_addr_t dma_desc_addr;          /* DMA address of descriptor */
+	struct sk_buff *skb;               /* Virtual address of SKB */
+	dma_addr_t skb_dma;                /* DMA address of SKB data */
+	unsigned int skb_dma_len;          /* Length of SKB DMA area */
+
+	/* Tx/Rx -related data */
+	struct fxgmac_tx_desc_data tx;
+	struct fxgmac_rx_desc_data rx;
+
+	unsigned int mapped_as_page;
+};
+
+struct fxgmac_ring {
+	struct fxgmac_pkt_info pkt_info;  /* Per packet related information */
+
+	/* Virtual/DMA addresses of DMA descriptor list and the total count */
+	struct fxgmac_dma_desc *dma_desc_head;
+	dma_addr_t dma_desc_head_addr;
+	unsigned int dma_desc_count;
+
+	/* Array of descriptor data corresponding the DMA descriptor
+	 * (always use the FXGMAC_GET_DESC_DATA macro to access this data)
+	 */
+	struct fxgmac_desc_data *desc_data_head;
+
+	/* Page allocation for RX buffers */
+	struct fxgmac_page_alloc rx_hdr_pa;
+	struct fxgmac_page_alloc rx_buf_pa;
+
+	/* Ring index values
+	 *  cur   - Tx: index of descriptor to be used for current transfer
+	 *          Rx: index of descriptor to check for packet availability
+	 *  dirty - Tx: index of descriptor to check for transfer complete
+	 *          Rx: index of descriptor to check for buffer reallocation
+	 */
+	unsigned int cur;
+	unsigned int dirty;
+
+	struct {
+		unsigned int xmit_more;
+		unsigned int queue_stopped;
+		unsigned short cur_mss;
+		unsigned short cur_vlan_ctag;
+	} tx;
+} ____cacheline_aligned;
+
+struct fxgmac_channel {
+	char name[16];
+
+	/* Address of private data area for device */
+	struct fxgmac_pdata *pdata;
+
+	/* Queue index and base address of queue's DMA registers */
+	unsigned int queue_index;
+
+	/* Per channel interrupt irq number */
+	u32 dma_irq_rx;
+	char dma_irq_rx_name[IFNAMSIZ + 32];
+	u32 dma_irq_tx;
+	char dma_irq_tx_name[IFNAMSIZ + 32];
+
+	/* Netdev related settings */
+	struct napi_struct napi_tx;
+	struct napi_struct napi_rx;
+
+	unsigned int saved_ier;
+	unsigned int tx_timer_active;
+	struct timer_list tx_timer;
+
+	void __iomem *dma_regs;
+	struct fxgmac_ring *tx_ring;
+	struct fxgmac_ring *rx_ring;
+} ____cacheline_aligned;
+
+struct fxgmac_hw_ops {
+	int (*init)(struct fxgmac_pdata *pdata);
+	void (*exit)(struct fxgmac_pdata *pdata);
+	void (*save_nonstick_reg)(struct fxgmac_pdata *pdata);
+	void (*restore_nonstick_reg)(struct fxgmac_pdata *pdata);
+	void (*esd_restore_pcie_cfg)(struct fxgmac_pdata *pdata);
+
+	void (*enable_tx)(struct fxgmac_pdata *pdata);
+	void (*disable_tx)(struct fxgmac_pdata *pdata);
+	void (*enable_rx)(struct fxgmac_pdata *pdata);
+	void (*disable_rx)(struct fxgmac_pdata *pdata);
+	void (*enable_channel_irq)(struct fxgmac_channel *channel,
+				   enum fxgmac_int int_id);
+	void (*disable_channel_irq)(struct fxgmac_channel *channel,
+				    enum fxgmac_int int_id);
+	void (*set_interrupt_moderation)(struct fxgmac_pdata *pdata);
+	void (*disable_msix_irqs)(struct fxgmac_pdata *pdata);
+	void (*enable_msix_irqs)(struct fxgmac_pdata *pdata);
+	void (*enable_msix_one_irq)(struct fxgmac_pdata *pdata, u32 intid);
+	void (*disable_msix_one_irq)(struct fxgmac_pdata *pdata, u32 intid);
+	void (*enable_mgm_irq)(struct fxgmac_pdata *pdata);
+	void (*disable_mgm_irq)(struct fxgmac_pdata *pdata);
+	void (*dismiss_all_int)(struct fxgmac_pdata *pdata);
+	void (*clear_misc_int_status)(struct fxgmac_pdata *pdata);
+	void (*enable_wake_pattern)(struct fxgmac_pdata *pdata);
+	void (*disable_wake_pattern)(struct fxgmac_pdata *pdata);
+	void (*set_mac_address)(struct fxgmac_pdata *pdata, u8 *addr);
+	void (*set_mac_hash)(struct fxgmac_pdata *pdata);
+	void (*config_rx_mode)(struct fxgmac_pdata *pdata);
+	void (*enable_rx_csum)(struct fxgmac_pdata *pdata);
+	void (*disable_rx_csum)(struct fxgmac_pdata *pdata);
+	void (*config_tso)(struct fxgmac_pdata *pdata);
+
+	/* MII speed configuration */
+	void (*config_mac_speed)(struct fxgmac_pdata *pdata);
+
+	/* descriptor related operation */
+	int (*is_tx_complete)(struct fxgmac_dma_desc *dma_desc);
+	int (*is_last_desc)(struct fxgmac_dma_desc *dma_desc);
+
+	/* Flow Control */
+	void (*config_tx_flow_control)(struct fxgmac_pdata *pdata);
+	void (*config_rx_flow_control)(struct fxgmac_pdata *pdata);
+
+	/* Jumbo Frames */
+	void (*config_mtu)(struct fxgmac_pdata *pdata);
+
+	/* Vlan related config */
+	void (*enable_tx_vlan)(struct fxgmac_pdata *pdata);
+	void (*disable_tx_vlan)(struct fxgmac_pdata *pdata);
+	void (*enable_rx_vlan_stripping)(struct fxgmac_pdata *pdata);
+	void (*disable_rx_vlan_stripping)(struct fxgmac_pdata *pdata);
+	void (*enable_rx_vlan_filtering)(struct fxgmac_pdata *pdata);
+	void (*disable_rx_vlan_filtering)(struct fxgmac_pdata *pdata);
+	void (*update_vlan_hash_table)(struct fxgmac_pdata *pdata);
+
+	/* RX coalescing */
+	void (*config_rx_coalesce)(struct fxgmac_pdata *pdata);
+	unsigned int (*usec_to_riwt)(struct fxgmac_pdata *pdata,
+				     unsigned int usec);
+
+	/* MMC statistics */
+	void (*rx_mmc_int)(struct fxgmac_pdata *pdata);
+	void (*tx_mmc_int)(struct fxgmac_pdata *pdata);
+	void (*read_mmc_stats)(struct fxgmac_pdata *pdata);
+	void (*update_stats_counters)(struct fxgmac_pdata *pdata,
+				      bool ephy_check_en);
+
+	/* Receive Side Scaling */
+	void (*enable_rss)(struct fxgmac_pdata *pdata);
+	void (*disable_rss)(struct fxgmac_pdata *pdata);
+	u32 (*get_rss_options)(struct fxgmac_pdata *pdata);
+	void (*set_rss_options)(struct fxgmac_pdata *pdata);
+	void (*set_rss_hash_key)(struct fxgmac_pdata *pdata, const u8 *key);
+
+	/* Offload */
+	void (*disable_arp_offload)(struct fxgmac_pdata *pdata);
+	void (*disable_wake_magic_pattern)(struct fxgmac_pdata *pdata);
+	int (*set_wake_pattern)(struct fxgmac_pdata *pdata,
+				struct wol_bitmap_pattern *wol_pattern,
+				u32 pattern_cnt);
+	void (*enable_wake_magic_pattern)(struct fxgmac_pdata *pdata);
+	void (*enable_wake_link_change)(struct fxgmac_pdata *pdata);
+	void (*disable_wake_link_change)(struct fxgmac_pdata *pdata);
+
+	void (*reset_phy)(struct fxgmac_pdata *pdata);
+	int (*release_phy)(struct fxgmac_pdata *pdata);
+	int (*write_ephy_reg)(struct fxgmac_pdata *pdata, u32 val, u32 data);
+	int (*read_ephy_reg)(struct fxgmac_pdata *pdata, u32 val, u32 *data);
+	int (*phy_config)(struct fxgmac_pdata *pdata);
+	u32 (*get_ephy_state)(struct fxgmac_pdata *pdata);
+
+	/* Power management */
+	int (*pre_power_down)(struct fxgmac_pdata *pdata, bool phyloopback);
+	void (*diag_sanity_check)(struct fxgmac_pdata *pdata);
+	void (*write_rss_lookup_table)(struct fxgmac_pdata *pdata);
+	void (*get_rss_hash_key)(struct fxgmac_pdata *pdata, u8 *key_buf);
+
+	u32 (*calculate_max_checksum_size)(struct fxgmac_pdata *pdata);
+	void (*config_power_down)(struct fxgmac_pdata *pdata, unsigned int wol);
+	int (*config_power_up)(struct fxgmac_pdata *pdata);
+	int (*set_suspend_txrx)(struct fxgmac_pdata *pdata);
+
+	void (*pcie_init)(struct fxgmac_pdata *pdata, bool ltr_en,
+			  bool aspm_l1ss_en, bool aspm_l1_en, bool aspm_l0s_en);
+};
+
+/* This structure contains flags that indicate what hardware features
+ * or configurations are present in the device.
+ */
+struct fxgmac_hw_features {
+	unsigned int version;		/* HW Version */
+
+	/* HW Feature Register0 */
+	unsigned int phyifsel;		/* PHY interface support */
+	unsigned int vlhash;		/* VLAN Hash Filter */
+	unsigned int sma;		/* SMA(MDIO) Interface */
+	unsigned int rwk;		/* PMT remote wake-up packet */
+	unsigned int mgk;		/* PMT magic packet */
+	unsigned int mmc;		/* RMON module */
+	unsigned int aoe;		/* ARP Offload */
+	unsigned int ts;		/* IEEE 1588-2008 Advanced Timestamp */
+	unsigned int eee;		/* Energy Efficient Ethernet */
+	unsigned int tx_coe;		/* Tx Checksum Offload */
+	unsigned int rx_coe;		/* Rx Checksum Offload */
+	unsigned int addn_mac;		/* Additional MAC Addresses */
+	unsigned int ts_src;		/* Timestamp Source */
+	unsigned int sa_vlan_ins;	/* Source Address or VLAN Insertion */
+
+	/* HW Feature Register1 */
+	unsigned int rx_fifo_size;	/* MTL Receive FIFO Size */
+	unsigned int tx_fifo_size;	/* MTL Transmit FIFO Size */
+	unsigned int adv_ts_hi;		/* Advance Timestamping High Word */
+	unsigned int dma_width;		/* DMA width */
+	unsigned int dcb;		/* DCB Feature */
+	unsigned int sph;		/* Split Header Feature */
+	unsigned int tso;		/* TCP Segmentation Offload */
+	unsigned int dma_debug;		/* DMA Debug Registers */
+	unsigned int rss;		/* Receive Side Scaling */
+	unsigned int tc_cnt;		/* Number of Traffic Classes */
+	unsigned int avsel;		/* AV Feature Enable */
+	unsigned int ravsel;		/* Rx Side Only AV Feature Enable */
+	unsigned int hash_table_size;	/* Hash Table Size */
+	unsigned int l3l4_filter_num;	/* Number of L3-L4 Filters */
+
+	/* HW Feature Register2 */
+	unsigned int rx_q_cnt;		/* Number of MTL Receive Queues */
+	unsigned int tx_q_cnt;		/* Number of MTL Transmit Queues */
+	unsigned int rx_ch_cnt;		/* Number of DMA Receive Channels */
+	unsigned int tx_ch_cnt;		/* Number of DMA Transmit Channels */
+	unsigned int pps_out_num;	/* Number of PPS outputs */
+	unsigned int aux_snap_num;	/* Number of Aux snapshot inputs */
+
+	u32 hwfr3;			/* HW Feature Register3 */
+};
+
+struct fxgmac_resources {
+	void __iomem *addr;
+	int irq;
+};
+
+struct fxgmac_pci_cfg {
+	u32 pci_cmd;
+	u32 pci_link_ctrl;
+	u32 mem_base;
+	u32 mem_base_hi;
+	u32 io_base;
+	u32 cache_line_size;
+	u32 int_line;
+	u32 device_ctrl1;
+	u32 device_ctrl2;
+	u32 msix_capability;
+};
+
+struct fxgmac_esd_stats {
+	u32 tx_deferred_frames;
+	u32 tx_abort_excess_collisions;
+	u32 tx_dma_underrun;
+	u32 tx_lost_crs;
+	u32 tx_late_collisions;
+	u32 rx_crc_errors;
+	u32 rx_align_errors;
+	u32 rx_runt_errors;
+	u32 single_collisions;
+	u32 multi_collisions;
+};
+
+enum fxgmac_dev_state {
+	FXGMAC_DEV_OPEN		= 0x0,
+	FXGMAC_DEV_CLOSE	= 0x1,
+	FXGMAC_DEV_STOP		= 0x2,
+	FXGMAC_DEV_START	= 0x3,
+	FXGMAC_DEV_SUSPEND	= 0x4,
+	FXGMAC_DEV_RESUME	= 0x5,
+	FXGMAC_DEV_PROBE	= 0xFF,
+};
+
+enum fxgmac_task_flag {
+	FXGMAC_TASK_FLAG_DOWN = 0,
+	FXGMAC_TASK_FLAG_RESET,
+	FXGMAC_TASK_FLAG_ESD_CHECK,
+	FXGMAC_TASK_FLAG_LINK_CHG,
+	FXGMAC_TASK_FLAG_MAX
+};
+
+struct fxgmac_pdata {
+	struct net_device *netdev;
+	struct device *dev;
+
+	struct fxgmac_hw_features hw_feat;	/* Hardware features */
+	struct fxgmac_hw_ops hw_ops;
+	void __iomem *hw_addr;			/* registers base */
+	struct fxgmac_stats stats;		/* Device statistics */
+
+	/* Rings for Tx/Rx on a DMA channel */
+	struct fxgmac_channel *channel_head;
+	unsigned int channel_count;
+	unsigned int tx_ring_count;
+	unsigned int rx_ring_count;
+	unsigned int tx_desc_count;
+	unsigned int rx_desc_count;
+	unsigned int tx_q_count;
+	unsigned int rx_q_count;
+
+	unsigned long sysclk_rate;		/* Device clocks */
+	unsigned int pblx8;			/* Tx/Rx common settings */
+	unsigned int crc_check;
+
+	/* Tx settings */
+	unsigned int tx_sf_mode;
+	unsigned int tx_threshold;
+	unsigned int tx_pbl;
+	unsigned int tx_osp_mode;
+	unsigned int tx_hang_restart_queuing;
+
+	/* Rx settings */
+	unsigned int rx_sf_mode;
+	unsigned int rx_threshold;
+	unsigned int rx_pbl;
+
+	/* Tx coalescing settings */
+	unsigned int tx_usecs;
+	unsigned int tx_frames;
+
+	/* Rx coalescing settings */
+	unsigned int rx_riwt;
+	unsigned int rx_usecs;
+	unsigned int rx_frames;
+
+	unsigned int rx_buf_size;		/* Current Rx buffer size */
+
+	/* Flow control settings */
+	unsigned int tx_pause;
+	unsigned int rx_pause;
+
+	/* Jumbo frames */
+	unsigned int mtu;
+	unsigned int jumbo;
+
+	/* vlan */
+	unsigned int vlan;
+	unsigned int vlan_exist;
+	unsigned int vlan_filter;
+	unsigned int vlan_strip;
+
+	/* Device interrupt */
+	int dev_irq;
+	unsigned int per_channel_irq;
+	u32 channel_irq[FXGMAC_MAX_DMA_CHANNELS];
+	int misc_irq;
+	char misc_irq_name[IFNAMSIZ + 32];
+	struct msix_entry *msix_entries;
+#define FXGMAC_FLAG_INTERRUPT_POS		0
+#define FXGMAC_FLAG_INTERRUPT_LEN		5
+#define FXGMAC_FLAG_MSI_CAPABLE			BIT(0)
+#define FXGMAC_FLAG_MSI_ENABLED			BIT(1)
+#define FXGMAC_FLAG_MSIX_CAPABLE		BIT(2)
+#define FXGMAC_FLAG_MSIX_ENABLED		BIT(3)
+#define FXGMAC_FLAG_LEGACY_ENABLED		BIT(4)
+#define FXGMAC_FLAG_RX_NAPI_POS			18
+#define FXGMAC_FLAG_RX_NAPI_LEN			4
+#define FXGMAC_FLAG_PER_RX_NAPI_LEN		1
+#define FXGMAC_FLAG_RX_IRQ_POS			22
+#define FXGMAC_FLAG_RX_IRQ_LEN			4
+#define FXGMAC_FLAG_PER_RX_IRQ_LEN		1
+#define FXGMAC_FLAG_TX_NAPI_POS			26
+#define FXGMAC_FLAG_TX_NAPI_LEN			1
+#define FXGMAC_FLAG_TX_IRQ_POS			27
+#define FXGMAC_FLAG_TX_IRQ_LEN			1
+#define FXGMAC_FLAG_MISC_NAPI_POS		28
+#define FXGMAC_FLAG_MISC_NAPI_LEN		1
+#define FXGMAC_FLAG_MISC_IRQ_POS		29
+#define FXGMAC_FLAG_MISC_IRQ_LEN		1
+#define FXGMAC_FLAG_LEGACY_NAPI_POS		30
+#define FXGMAC_FLAG_LEGACY_NAPI_LEN		1
+#define FXGMAC_FLAG_LEGACY_IRQ_POS		31
+#define FXGMAC_FLAG_LEGACY_IRQ_LEN		1
+	u32 int_flags;
+
+	/* Interrupt Moderation */
+	unsigned int intr_mod;
+	unsigned int intr_mod_timer;
+
+	/* Netdev related settings */
+	unsigned char mac_addr[ETH_ALEN];
+	netdev_features_t netdev_features;
+	struct napi_struct napi;
+	struct napi_struct napi_misc;
+
+	/* Filtering support */
+	unsigned long active_vlans[BITS_TO_LONGS(VLAN_N_VID)];
+
+	/* Receive Side Scaling settings */
+	unsigned int rss;
+	u8 rss_key[FXGMAC_RSS_HASH_KEY_SIZE];
+	u32 rss_table[FXGMAC_RSS_MAX_TABLE_SIZE];
+#define FXGMAC_RSS_IP4TE		BIT(0)
+#define FXGMAC_RSS_TCP4TE		BIT(1)
+#define FXGMAC_RSS_UDP4TE		BIT(2)
+#define FXGMAC_RSS_IP6TE		BIT(3)
+#define FXGMAC_RSS_TCP6TE		BIT(4)
+#define FXGMAC_RSS_UDP6TE		BIT(5)
+	u32 rss_options;
+
+	int phy_speed;
+	int phy_duplex;
+	int phy_autoeng;
+	int pre_phy_speed;
+	int pre_phy_duplex;
+	int pre_phy_autoneg;
+	bool phy_link;
+	struct timer_list phy_poll_tm;
+
+	u32 msg_enable;
+	struct fxgmac_pci_cfg pci_cfg;
+	u32 reg_nonstick[(MSI_PBA - GLOBAL_CTRL0) >> 2];
+	u32 pcie_link_status;
+
+	u32 wol;
+	struct wol_bitmap_pattern pattern[MAX_PATTERN_COUNT];
+	struct led_setting led;
+
+	struct work_struct restart_work;
+	struct delayed_work esd_work;
+	struct fxgmac_esd_stats esd_stats;
+	DECLARE_BITMAP(task_flags, FXGMAC_TASK_FLAG_MAX);
+
+	enum fxgmac_dev_state dev_state;
+#define FXGMAC_POWER_STATE_DOWN			0
+#define FXGMAC_POWER_STATE_UP			1
+	unsigned long powerstate;
+	struct mutex mutex; /* driver lock */
+
+	char drv_name[32];
+	char drv_ver[32];
+};
+
+void fxgmac_hw_ops_init(struct fxgmac_hw_ops *hw_ops);
+int fxgmac_config_wol(struct fxgmac_pdata *pdata, int en);
+int fxgmac_phy_cfg_led(struct fxgmac_pdata *pdata, u32 cfg[LED_CFG_LEN]);
+bool fxgmac_efuse_is_led_common(struct fxgmac_pdata *pdata);
+int fxgmac_drv_probe(struct device *dev, struct fxgmac_resources *res);
+void fxgmac_drv_remove(struct device *dev);
+const struct ethtool_ops *fxgmac_get_ethtool_ops(void);
+const struct net_device_ops *fxgmac_get_netdev_ops(void);
+int fxgmac_net_powerup(struct fxgmac_pdata *pdata);
+int fxgmac_net_powerdown(struct fxgmac_pdata *pdata, unsigned int wol);
+inline void fxgmac_lock(struct fxgmac_pdata *pdata);
+inline void fxgmac_unlock(struct fxgmac_pdata *pdata);
+void fxgmac_get_all_hw_features(struct fxgmac_pdata *pdata);
+void fxgmac_print_all_hw_features(struct fxgmac_pdata *pdata);
+void fxgmac_dbg_pkt(struct fxgmac_pdata *pdata, struct sk_buff *skb,
+		    bool tx_rx);
+
+#endif /* _YT6801_H_ */
diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_common.c b/drivers/net/ethernet/motorcomm/yt6801/yt6801_common.c
new file mode 100644
index 0000000..600e4b0
--- /dev/null
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_common.c
@@ -0,0 +1,787 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (c) 2022 - 2024 Motorcomm Electronic Technology Co.,Ltd. */
+
+#include "yt6801_efuse.h"
+#include "yt6801_type.h"
+#include "yt6801_desc.h"
+#include "yt6801_phy.h"
+#include "yt6801.h"
+
+static int fxgmac_read_mac_addr(struct fxgmac_pdata *pdata)
+{
+	u8 default_addr[ETH_ALEN] = { 0, 0x55, 0x7b, 0xb5, 0x7d, 0xf7 };
+	struct net_device *netdev = pdata->netdev;
+	int ret;
+
+	/* if efuse have mac addr, use it. if not, use static mac address. */
+	ret = fxgmac_efuse_read_mac_subsys(pdata, pdata->mac_addr, NULL, NULL);
+	if (!ret)
+		return -1;
+
+	if (is_zero_ether_addr(pdata->mac_addr))
+		/* Use a static mac address for test */
+		memcpy(pdata->mac_addr, default_addr, netdev->addr_len);
+
+	return 0;
+}
+
+#define FXGMAC_SYSCLOCK 125000000 /* System clock is 125 MHz */
+
+static void fxgmac_default_config(struct fxgmac_pdata *pdata)
+{
+	pdata->tx_threshold = MTL_TX_THRESHOLD_128;
+	pdata->rx_threshold = MTL_RX_THRESHOLD_128;
+	pdata->tx_osp_mode = DMA_OSP_ENABLE;
+	pdata->tx_sf_mode = MTL_TSF_ENABLE;
+	pdata->rx_sf_mode = MTL_RSF_ENABLE;
+	pdata->pblx8 = DMA_PBL_X8_ENABLE;
+	pdata->tx_pbl = DMA_PBL_16;
+	pdata->rx_pbl = DMA_PBL_4;
+	pdata->crc_check = 1;
+	pdata->tx_pause = 1;	/* enable tx pause */
+	pdata->rx_pause = 1;	/* enable rx pause */
+	pdata->intr_mod = 1;
+	pdata->intr_mod_timer = INT_MOD_200_US;
+	pdata->vlan_strip = 1;
+	pdata->rss = 1;
+
+	pdata->phy_autoeng = AUTONEG_ENABLE;
+	pdata->phy_duplex = DUPLEX_FULL;
+	pdata->phy_speed = SPEED_1000;
+	pdata->phy_link = false;
+	pdata->pre_phy_speed = pdata->phy_speed;
+	pdata->pre_phy_duplex = pdata->phy_duplex;
+	pdata->pre_phy_autoneg = pdata->phy_autoeng;
+
+	pdata->sysclk_rate = FXGMAC_SYSCLOCK;
+	pdata->wol = WAKE_MAGIC;
+
+	strscpy(pdata->drv_name, FXGMAC_DRV_NAME, sizeof(pdata->drv_name));
+	strscpy(pdata->drv_ver, FXGMAC_DRV_VERSION, sizeof(pdata->drv_ver));
+	yt_dbg(pdata, "drv_name:%s, drv_ver:%s\n", FXGMAC_DRV_NAME,
+	       FXGMAC_DRV_VERSION);
+}
+
+static int fxgmac_init(struct fxgmac_pdata *pdata, bool save_private_reg)
+{
+	struct fxgmac_hw_ops *hw_ops = &pdata->hw_ops;
+	struct net_device *netdev = pdata->netdev;
+	unsigned int i;
+	int ret;
+
+	fxgmac_hw_ops_init(hw_ops);	/* Set hw the function pointers */
+	fxgmac_default_config(pdata);	/* Set default configuration data */
+
+	/* Set irq, base_addr, MAC address */
+	netdev->irq = pdata->dev_irq;
+	netdev->base_addr = (unsigned long)pdata->hw_addr;
+
+	ret = fxgmac_read_mac_addr(pdata);
+	if (ret) {
+		yt_err(pdata, "fxgmac_read_mac_addr err:%d\n", ret);
+		return ret;
+	}
+	eth_hw_addr_set(netdev, pdata->mac_addr);
+
+	if (save_private_reg)
+		hw_ops->save_nonstick_reg(pdata);
+
+	hw_ops->exit(pdata);	/* reset here to get hw features correctly */
+
+	/* Populate the hardware features */
+	fxgmac_get_all_hw_features(pdata);
+	fxgmac_print_all_hw_features(pdata);
+
+	/* Set the DMA mask */
+	ret = dma_set_mask_and_coherent(pdata->dev,
+					DMA_BIT_MASK(pdata->hw_feat.dma_width));
+	if (ret) {
+		yt_err(pdata, "dma_set_mask_and_coherent err:%d\n", ret);
+		return ret;
+	}
+
+	BUILD_BUG_ON_NOT_POWER_OF_2(FXGMAC_TX_DESC_CNT);
+	pdata->tx_desc_count = FXGMAC_TX_DESC_CNT;
+	BUILD_BUG_ON_NOT_POWER_OF_2(FXGMAC_RX_DESC_CNT);
+	pdata->rx_desc_count = FXGMAC_RX_DESC_CNT;
+	pdata->tx_ring_count = min_t(unsigned int, num_online_cpus(),
+				     pdata->hw_feat.tx_ch_cnt);
+	pdata->tx_ring_count = min_t(unsigned int, pdata->tx_ring_count,
+				     pdata->hw_feat.tx_q_cnt);
+	pdata->tx_q_count = pdata->tx_ring_count;
+
+	ret = netif_set_real_num_tx_queues(netdev, pdata->tx_q_count);
+	yt_dbg(pdata,
+	       "num_online_cpus:%u, tx:ch_cnt:%u, q_cnt:%u, ring_count:%u\n",
+	       num_online_cpus(), pdata->hw_feat.tx_ch_cnt,
+	       pdata->hw_feat.tx_q_cnt, pdata->tx_ring_count);
+	if (ret) {
+		yt_err(pdata, "error setting real tx queue count\n");
+		return ret;
+	}
+
+	pdata->rx_ring_count = min_t(unsigned int,
+				     netif_get_num_default_rss_queues(),
+				     pdata->hw_feat.rx_ch_cnt);
+	pdata->rx_ring_count = min_t(unsigned int, pdata->rx_ring_count,
+				     pdata->hw_feat.rx_q_cnt);
+	pdata->rx_q_count = pdata->rx_ring_count;
+	ret = netif_set_real_num_rx_queues(netdev, pdata->rx_q_count);
+	if (ret) {
+		yt_err(pdata, "error setting real rx queue count\n");
+		return ret;
+	}
+
+	pdata->channel_count =
+		max_t(unsigned int, pdata->tx_ring_count, pdata->rx_ring_count);
+
+	yt_dbg(pdata,
+	       "default rss queues:%u, rx:ch_cnt:%u, q_cnt:%u, ring_count:%u, channel_count:%u, netdev tx channel_num=%u\n",
+	       netif_get_num_default_rss_queues(), pdata->hw_feat.rx_ch_cnt,
+	       pdata->hw_feat.rx_q_cnt, pdata->rx_ring_count,
+	       pdata->channel_count, netdev->real_num_tx_queues);
+
+	/* Initialize RSS hash key and lookup table */
+	netdev_rss_key_fill(pdata->rss_key, sizeof(pdata->rss_key));
+
+	for (i = 0; i < FXGMAC_RSS_MAX_TABLE_SIZE; i++) {
+		fxgmac_set_bits(&pdata->rss_table[i], MAC_RSSDR_DMCH_POS,
+				MAC_RSSDR_DMCH_LEN, i % pdata->rx_ring_count);
+	}
+
+	pdata->rss_options |= FXGMAC_RSS_IP4TE | FXGMAC_RSS_TCP4TE |
+			      FXGMAC_RSS_UDP4TE;
+
+	netdev->min_mtu = ETH_MIN_MTU;
+	netdev->max_mtu =
+		FXGMAC_JUMBO_PACKET_MTU + (ETH_HLEN + VLAN_HLEN + ETH_FCS_LEN);
+
+	yt_dbg(pdata, "rss_options:0x%x\n", pdata->rss_options);
+
+	/* Set device operations */
+	netdev->netdev_ops = fxgmac_get_netdev_ops();
+	netdev->ethtool_ops = fxgmac_get_ethtool_ops();
+
+	/* Set device features */
+	if (pdata->hw_feat.tso) {
+		netdev->hw_features = NETIF_F_TSO;
+		netdev->hw_features |= NETIF_F_TSO6;
+		netdev->hw_features |= NETIF_F_SG;
+		netdev->hw_features |= NETIF_F_IP_CSUM;
+		netdev->hw_features |= NETIF_F_IPV6_CSUM;
+	} else if (pdata->hw_feat.tx_coe) {
+		netdev->hw_features = NETIF_F_IP_CSUM;
+		netdev->hw_features |= NETIF_F_IPV6_CSUM;
+	}
+
+	if (pdata->hw_feat.rx_coe) {
+		netdev->hw_features |= NETIF_F_RXCSUM;
+		netdev->hw_features |= NETIF_F_GRO;
+	}
+
+	netdev->hw_features |= NETIF_F_RXHASH;
+	netdev->vlan_features |= netdev->hw_features;
+
+	netdev->hw_features |= NETIF_F_HW_VLAN_CTAG_RX;
+
+	if (pdata->hw_feat.sa_vlan_ins)
+		netdev->hw_features |= NETIF_F_HW_VLAN_CTAG_TX;
+
+	netdev->features |= netdev->hw_features;
+	pdata->netdev_features = netdev->features;
+
+	netdev->priv_flags |= IFF_UNICAST_FLT;
+	netdev->watchdog_timeo = msecs_to_jiffies(5000);
+
+#define NIC_MAX_TCP_OFFLOAD_SIZE 7300
+
+	netif_set_tso_max_size(netdev, NIC_MAX_TCP_OFFLOAD_SIZE);
+
+/* Default coalescing parameters */
+#define FXGMAC_INIT_DMA_TX_USECS INT_MOD_200_US
+#define FXGMAC_INIT_DMA_TX_FRAMES 25
+#define FXGMAC_INIT_DMA_RX_USECS INT_MOD_200_US
+#define FXGMAC_INIT_DMA_RX_FRAMES 25
+
+	/* Tx coalesce parameters initialization */
+	pdata->tx_usecs = FXGMAC_INIT_DMA_TX_USECS;
+	pdata->tx_frames = FXGMAC_INIT_DMA_TX_FRAMES;
+
+	/* Rx coalesce parameters initialization */
+	pdata->rx_riwt = hw_ops->usec_to_riwt(pdata, FXGMAC_INIT_DMA_RX_USECS);
+	pdata->rx_usecs = FXGMAC_INIT_DMA_RX_USECS;
+	pdata->rx_frames = FXGMAC_INIT_DMA_RX_FRAMES;
+
+	mutex_init(&pdata->mutex);
+	yt_dbg(pdata, "%s ok.\n", __func__);
+
+	return 0;
+}
+
+#ifdef CONFIG_PCI_MSI
+static void fxgmac_init_interrupt_scheme(struct fxgmac_pdata *pdata)
+{
+	struct pci_dev *pdev = to_pci_dev(pdata->dev);
+	u32 i, *flags = &pdata->int_flags;
+	int vectors, rc, req_vectors;
+
+	/* since we have 4 channels, we must ensure the number of cpu core > 4
+	 * otherwise, just roll back to legacy
+	 *  0-3 for rx, 4 for tx, 5 for misc
+	 */
+	vectors = num_online_cpus();
+	if (vectors < FXGMAC_MAX_DMA_RX_CHANNELS)
+		goto enable_msi_interrupt;
+
+	req_vectors = FXGMAC_MSIX_INT_NUMS;
+	pdata->msix_entries =
+		kcalloc(req_vectors, sizeof(struct msix_entry), GFP_KERNEL);
+	if (!pdata->msix_entries)
+		goto enable_msi_interrupt;
+
+	for (i = 0; i < req_vectors; i++)
+		pdata->msix_entries[i].entry = i;
+
+	rc = pci_enable_msix_range(pdev, pdata->msix_entries, req_vectors,
+				   req_vectors);
+	if (rc < 0) {
+		yt_err(pdata, "enable MSIx err :%d.\n", rc);
+		req_vectors = 0;
+	} else {
+		req_vectors = rc;
+	}
+
+	if (req_vectors >= FXGMAC_MAX_DMA_CHANNELS) {
+		yt_dbg(pdata, "enable MSIx ok, cpu=%d,vectors=%d.\n", vectors,
+		       req_vectors);
+		fxgmac_set_bits(flags, FXGMAC_FLAG_INTERRUPT_POS,
+				FXGMAC_FLAG_INTERRUPT_LEN,
+				FXGMAC_FLAG_MSIX_ENABLED);
+		pdata->per_channel_irq = 1;
+		pdata->misc_irq = pdata->msix_entries[MSI_ID_PHY_OTHER].vector;
+		return;
+	} else if (req_vectors) {
+		yt_err(pdata, "enable MSIx only %d vector, but we need %d\n",
+		       req_vectors, vectors);
+		/* roll back to msi */
+		pci_disable_msix(pdev);
+		kfree(pdata->msix_entries);
+		pdata->msix_entries = NULL;
+		req_vectors = 0;
+	} else {
+		yt_err(pdata, "enable MSIx err, clear msix entries.\n");
+		/* roll back to msi */
+		kfree(pdata->msix_entries);
+		pdata->msix_entries = NULL;
+		req_vectors = 0;
+	}
+
+enable_msi_interrupt:
+	rc = pci_enable_msi(pdev);
+	if (rc < 0) {
+		fxgmac_set_bits(flags, FXGMAC_FLAG_INTERRUPT_POS,
+				FXGMAC_FLAG_INTERRUPT_LEN,
+				FXGMAC_FLAG_LEGACY_ENABLED);
+		yt_err(pdata, "MSI err, rollback to LEGACY.\n");
+	} else {
+		fxgmac_set_bits(flags, FXGMAC_FLAG_INTERRUPT_POS,
+				FXGMAC_FLAG_INTERRUPT_LEN,
+				FXGMAC_FLAG_MSI_ENABLED);
+		pdata->dev_irq = pdev->irq;
+		yt_dbg(pdata, "enable MSI ok, cpu=%d, irq=%d.\n", vectors,
+		       pdev->irq);
+	}
+}
+#endif
+
+int fxgmac_drv_probe(struct device *dev, struct fxgmac_resources *res)
+{
+	struct fxgmac_pdata *pdata;
+	struct net_device *netdev;
+	int ret;
+
+	netdev = alloc_etherdev_mq(sizeof(struct fxgmac_pdata),
+				   FXGMAC_MAX_DMA_RX_CHANNELS);
+	if (!netdev) {
+		dev_err(dev, "alloc_etherdev_mq err\n");
+		return -ENOMEM;
+	}
+
+	SET_NETDEV_DEV(netdev, dev);
+	dev_set_drvdata(dev, netdev);
+	pdata = netdev_priv(netdev);
+
+	pdata->dev = dev;
+	pdata->netdev = netdev;
+	pdata->dev_irq = res->irq;
+	pdata->hw_addr = res->addr;
+	pdata->msg_enable = NETIF_MSG_DRV;
+	pdata->dev_state = FXGMAC_DEV_PROBE;
+
+	/* default to legacy interrupt */
+	fxgmac_set_bits(&pdata->int_flags, FXGMAC_FLAG_INTERRUPT_POS,
+			FXGMAC_FLAG_INTERRUPT_LEN, FXGMAC_FLAG_LEGACY_ENABLED);
+	pdata->misc_irq = pdata->dev_irq;
+
+#ifdef CONFIG_PCI_MSI
+	fxgmac_init_interrupt_scheme(pdata);
+#endif
+
+	ret = fxgmac_init(pdata, true);
+	if (ret < 0) {
+		yt_err(pdata, "fxgmac_init err:%d\n", ret);
+		goto err_free_netdev;
+	}
+
+	ret = fxgmac_efuse_load_led_cfg(pdata);
+	if (!ret) {
+		yt_err(pdata, "fxgmac_efuse_load_led_cfg err:%d\n", ret);
+		goto err_free_netdev;
+	}
+
+	netif_carrier_off(netdev);
+	ret = register_netdev(netdev);
+	if (ret) {
+		yt_err(pdata, "register_netdev err:%d\n", ret);
+		goto err_free_netdev;
+	}
+	if (netif_msg_drv(pdata))
+		yt_dbg(pdata, "%s, netdev num_tx_q=%u\n", __func__,
+		       netdev->real_num_tx_queues);
+
+	return 0;
+
+err_free_netdev:
+	free_netdev(netdev);
+	yt_err(pdata, "%s err\n", __func__);
+
+	return ret;
+}
+
+void fxgmac_drv_remove(struct device *dev)
+{
+	struct net_device *netdev = dev_get_drvdata(dev);
+	struct fxgmac_pdata *pdata = netdev_priv(netdev);
+	int ret;
+
+	ret = fxgmac_phy_cfg_led(pdata, pdata->led.s5);
+	if (ret < 0)
+		yt_err(pdata, "fxgmac_phy_cfg_led err:%d\n", ret);
+
+	unregister_netdev(netdev);
+	free_netdev(netdev);
+}
+
+void fxgmac_dump_tx_desc(struct fxgmac_pdata *pdata, struct fxgmac_ring *ring,
+			 unsigned int idx, unsigned int count,
+			 unsigned int flag)
+{
+	struct fxgmac_desc_data *desc_data;
+
+	while (count--) {
+		desc_data = FXGMAC_GET_DESC_DATA(ring, idx);
+		yt_dbg(pdata,
+		       "TX: dma_desc=%p, dma_desc_addr=%pad, TX_NORMAL_DESC[%d %s] = %08x:%08x:%08x:%08x\n",
+		       desc_data->dma_desc, &desc_data->dma_desc_addr, idx,
+		       (flag == 1) ? "QUEUED FOR TX" : "TX BY DEVICE",
+		       le32_to_cpu(desc_data->dma_desc->desc0),
+		       le32_to_cpu(desc_data->dma_desc->desc1),
+		       le32_to_cpu(desc_data->dma_desc->desc2),
+		       le32_to_cpu(desc_data->dma_desc->desc3));
+
+		idx++;
+	}
+}
+
+void fxgmac_dump_rx_desc(struct fxgmac_pdata *pdata, struct fxgmac_ring *ring,
+			 unsigned int idx)
+{
+	struct fxgmac_desc_data *desc_data;
+	struct fxgmac_dma_desc *dma_desc;
+
+	desc_data = FXGMAC_GET_DESC_DATA(ring, idx);
+	dma_desc = desc_data->dma_desc;
+	yt_dbg(pdata,
+	       "RX: dma_desc=%p, dma_desc_addr=%pad, RX_NORMAL_DESC[%d RX BY DEVICE] = %08x:%08x:%08x:%08x\n\n",
+	       dma_desc, &desc_data->dma_desc_addr, idx,
+	       le32_to_cpu(dma_desc->desc0), le32_to_cpu(dma_desc->desc1),
+	       le32_to_cpu(dma_desc->desc2), le32_to_cpu(dma_desc->desc3));
+}
+
+void fxgmac_dbg_pkt(struct fxgmac_pdata *pdata, struct sk_buff *skb, bool tx_rx)
+{
+	struct ethhdr *eth = (struct ethhdr *)skb->data;
+	unsigned char buffer[128];
+
+	yt_dbg(pdata, "\n************** SKB dump ****************\n");
+	yt_dbg(pdata, "%s, packet of %d bytes\n", (tx_rx ? "TX" : "RX"),
+	       skb->len);
+	yt_dbg(pdata, "Dst MAC addr: %pM\n", eth->h_dest);
+	yt_dbg(pdata, "Src MAC addr: %pM\n", eth->h_source);
+	yt_dbg(pdata, "Protocol: %#06x\n", ntohs(eth->h_proto));
+
+	for (u32 i = 0; i < skb->len; i += 32) {
+		unsigned int len = min(skb->len - i, 32U);
+
+		hex_dump_to_buffer(&skb->data[i], len, 32, 1, buffer,
+				   sizeof(buffer), false);
+		yt_dbg(pdata, "  %#06x: %s\n", i, buffer);
+	}
+
+	yt_dbg(pdata, "\n************** SKB dump ****************\n");
+}
+
+void fxgmac_get_all_hw_features(struct fxgmac_pdata *pdata)
+{
+	struct fxgmac_hw_features *hw_feat = &pdata->hw_feat;
+	unsigned int mac_hfr0, mac_hfr1, mac_hfr2, mac_hfr3;
+
+	mac_hfr0 = rd32_mac(pdata, MAC_HWF0R);
+	mac_hfr1 = rd32_mac(pdata, MAC_HWF1R);
+	mac_hfr2 = rd32_mac(pdata, MAC_HWF2R);
+	mac_hfr3 = rd32_mac(pdata, MAC_HWF3R);
+	memset(hw_feat, 0, sizeof(*hw_feat));
+	hw_feat->version = rd32_mac(pdata, MAC_VR);
+	if (netif_msg_drv(pdata))
+		yt_dbg(pdata, "Mac ver=%#x\n", hw_feat->version);
+
+	/* Hardware feature register 0 */
+	hw_feat->phyifsel = FXGMAC_GET_BITS(mac_hfr0, MAC_HWF0R_ACTPHYIFSEL_POS,
+					    MAC_HWF0R_ACTPHYIFSEL_LEN);
+	hw_feat->vlhash = FXGMAC_GET_BITS(mac_hfr0, MAC_HWF0R_VLHASH_POS,
+					  MAC_HWF0R_VLHASH_LEN);
+	hw_feat->sma = FXGMAC_GET_BITS(mac_hfr0, MAC_HWF0R_SMASEL_POS,
+				       MAC_HWF0R_SMASEL_LEN);
+	hw_feat->rwk = FXGMAC_GET_BITS(mac_hfr0, MAC_HWF0R_RWKSEL_POS,
+				       MAC_HWF0R_RWKSEL_LEN);
+	hw_feat->mgk = FXGMAC_GET_BITS(mac_hfr0, MAC_HWF0R_MGKSEL_POS,
+				       MAC_HWF0R_MGKSEL_LEN);
+	hw_feat->mmc = FXGMAC_GET_BITS(mac_hfr0, MAC_HWF0R_MMCSEL_POS,
+				       MAC_HWF0R_MMCSEL_LEN);
+	hw_feat->aoe = FXGMAC_GET_BITS(mac_hfr0, MAC_HWF0R_ARPOFFSEL_POS,
+				       MAC_HWF0R_ARPOFFSEL_LEN);
+	hw_feat->ts = FXGMAC_GET_BITS(mac_hfr0, MAC_HWF0R_TSSEL_POS,
+				      MAC_HWF0R_TSSEL_LEN);
+	hw_feat->eee = FXGMAC_GET_BITS(mac_hfr0, MAC_HWF0R_EEESEL_POS,
+				       MAC_HWF0R_EEESEL_LEN);
+	hw_feat->tx_coe = FXGMAC_GET_BITS(mac_hfr0, MAC_HWF0R_TXCOESEL_POS,
+					  MAC_HWF0R_TXCOESEL_LEN);
+	hw_feat->rx_coe = FXGMAC_GET_BITS(mac_hfr0, MAC_HWF0R_RXCOESEL_POS,
+					  MAC_HWF0R_RXCOESEL_LEN);
+	hw_feat->addn_mac = FXGMAC_GET_BITS(mac_hfr0,
+					    MAC_HWF0R_ADDMACADRSEL_POS,
+					    MAC_HWF0R_ADDMACADRSEL_LEN);
+	hw_feat->ts_src = FXGMAC_GET_BITS(mac_hfr0, MAC_HWF0R_TSSTSSEL_POS,
+					  MAC_HWF0R_TSSTSSEL_LEN);
+	hw_feat->sa_vlan_ins = FXGMAC_GET_BITS(mac_hfr0,
+					       MAC_HWF0R_SAVLANINS_POS,
+					       MAC_HWF0R_SAVLANINS_LEN);
+
+	/* Hardware feature register 1 */
+	hw_feat->rx_fifo_size = FXGMAC_GET_BITS(mac_hfr1,
+						MAC_HWF1R_RXFIFOSIZE_POS,
+						MAC_HWF1R_RXFIFOSIZE_LEN);
+	hw_feat->tx_fifo_size = FXGMAC_GET_BITS(mac_hfr1,
+						MAC_HWF1R_TXFIFOSIZE_POS,
+						MAC_HWF1R_TXFIFOSIZE_LEN);
+	hw_feat->adv_ts_hi = FXGMAC_GET_BITS(mac_hfr1,
+					     MAC_HWF1R_ADVTHWORD_POS,
+					     MAC_HWF1R_ADVTHWORD_LEN);
+	hw_feat->dma_width = FXGMAC_GET_BITS(mac_hfr1, MAC_HWF1R_ADDR64_POS,
+					     MAC_HWF1R_ADDR64_LEN);
+	hw_feat->dcb = FXGMAC_GET_BITS(mac_hfr1, MAC_HWF1R_DCBEN_POS,
+				       MAC_HWF1R_DCBEN_LEN);
+	hw_feat->sph = FXGMAC_GET_BITS(mac_hfr1, MAC_HWF1R_SPHEN_POS,
+				       MAC_HWF1R_SPHEN_LEN);
+	hw_feat->tso = FXGMAC_GET_BITS(mac_hfr1, MAC_HWF1R_TSOEN_POS,
+				       MAC_HWF1R_TSOEN_LEN);
+	hw_feat->dma_debug = FXGMAC_GET_BITS(mac_hfr1, MAC_HWF1R_DBGMEMA_POS,
+					     MAC_HWF1R_DBGMEMA_LEN);
+	hw_feat->avsel = FXGMAC_GET_BITS(mac_hfr1, MAC_HWF1R_RAVSEL_POS,
+					 MAC_HWF1R_RAVSEL_LEN);
+	hw_feat->ravsel = FXGMAC_GET_BITS(mac_hfr1, MAC_HWF1R_RAVSEL_POS,
+					  MAC_HWF1R_RAVSEL_LEN);
+	hw_feat->hash_table_size = FXGMAC_GET_BITS(mac_hfr1,
+						   MAC_HWF1R_HASHTBLSZ_POS,
+						   MAC_HWF1R_HASHTBLSZ_LEN);
+	hw_feat->l3l4_filter_num = FXGMAC_GET_BITS(mac_hfr1,
+						   MAC_HWF1R_L3L4FNUM_POS,
+						   MAC_HWF1R_L3L4FNUM_LEN);
+	hw_feat->tx_q_cnt = FXGMAC_GET_BITS(mac_hfr2, MAC_HWF2R_TXQCNT_POS,
+					    MAC_HWF2R_TXQCNT_LEN);
+	hw_feat->rx_ch_cnt = FXGMAC_GET_BITS(mac_hfr2, MAC_HWF2R_RXCHCNT_POS,
+					     MAC_HWF2R_RXCHCNT_LEN);
+	hw_feat->tx_ch_cnt = FXGMAC_GET_BITS(mac_hfr2, MAC_HWF2R_TXCHCNT_POS,
+					     MAC_HWF2R_TXCHCNT_LEN);
+	hw_feat->pps_out_num = FXGMAC_GET_BITS(mac_hfr2,
+					       MAC_HWF2R_PPSOUTNUM_POS,
+					       MAC_HWF2R_PPSOUTNUM_LEN);
+	hw_feat->aux_snap_num = FXGMAC_GET_BITS(mac_hfr2,
+						MAC_HWF2R_AUXSNAPNUM_POS,
+						MAC_HWF2R_AUXSNAPNUM_LEN);
+
+	/* Translate the Hash Table size into actual number */
+	switch (hw_feat->hash_table_size) {
+	case 0:
+		break;
+	case 1:
+		hw_feat->hash_table_size = 64;
+		break;
+	case 2:
+		hw_feat->hash_table_size = 128;
+		break;
+	case 3:
+		hw_feat->hash_table_size = 256;
+		break;
+	}
+
+	/* Translate the address width setting into actual number */
+	switch (hw_feat->dma_width) {
+	case 0:
+		hw_feat->dma_width = 32;
+		break;
+	case 1:
+		hw_feat->dma_width = 40;
+		break;
+	case 2:
+		hw_feat->dma_width = 48;
+		break;
+	default:
+		hw_feat->dma_width = 32;
+	}
+
+	/* The Queue, Channel are zero based so increment them
+	 * to get the actual number
+	 */
+	hw_feat->tx_q_cnt++;
+	hw_feat->rx_ch_cnt++;
+	hw_feat->tx_ch_cnt++;
+
+	/* hw implement 1 rx fifo, 4 dma channel.  but from software
+	 * we see 4 logical queues. hardcode to 4 queues.
+	 */
+	hw_feat->rx_q_cnt = 4;
+
+	hw_feat->hwfr3 = mac_hfr3;
+}
+
+void fxgmac_print_all_hw_features(struct fxgmac_pdata *pdata)
+{
+	char *str;
+
+	yt_dbg(pdata, "\n");
+	yt_dbg(pdata, "====================================================\n");
+	yt_dbg(pdata, "\n");
+	yt_dbg(pdata, "HW support following feature\n");
+	yt_dbg(pdata, "\n");
+
+	/* HW Feature Register0 */
+	yt_dbg(pdata, "VLAN Hash Filter Selected                        : %s\n",
+	       pdata->hw_feat.vlhash ? "YES" : "NO");
+	yt_dbg(pdata, "SMA (MDIO) Interface                             : %s\n",
+	       pdata->hw_feat.sma ? "YES" : "NO");
+	yt_dbg(pdata, "PMT Remote Wake-up Packet Enable                 : %s\n",
+	       pdata->hw_feat.rwk ? "YES" : "NO");
+	yt_dbg(pdata, "PMT Magic Packet Enable                          : %s\n",
+	       pdata->hw_feat.mgk ? "YES" : "NO");
+	yt_dbg(pdata, "RMON/MMC Module Enable                           : %s\n",
+	       pdata->hw_feat.mmc ? "YES" : "NO");
+	yt_dbg(pdata, "ARP Offload Enabled                              : %s\n",
+	       pdata->hw_feat.aoe ? "YES" : "NO");
+	yt_dbg(pdata, "IEEE 1588-2008 Timestamp Enabled                 : %s\n",
+	       pdata->hw_feat.ts ? "YES" : "NO");
+	yt_dbg(pdata, "Energy Efficient Ethernet Enabled                : %s\n",
+	       pdata->hw_feat.eee ? "YES" : "NO");
+	yt_dbg(pdata, "Transmit Checksum Offload Enabled                : %s\n",
+	       pdata->hw_feat.tx_coe ? "YES" : "NO");
+	yt_dbg(pdata, "Receive Checksum Offload Enabled                 : %s\n",
+	       pdata->hw_feat.rx_coe ? "YES" : "NO");
+	yt_dbg(pdata, "Additional MAC Addresses 1-31 Selected           : %s\n",
+	       pdata->hw_feat.addn_mac ? "YES" : "NO");
+
+	switch (pdata->hw_feat.ts_src) {
+	case 0:
+		str = "RESERVED";
+		break;
+	case 1:
+		str = "INTERNAL";
+		break;
+	case 2:
+		str = "EXTERNAL";
+		break;
+	case 3:
+		str = "BOTH";
+		break;
+	}
+	yt_dbg(pdata, "Timestamp System Time Source                     : %s\n",
+	       str);
+	yt_dbg(pdata, "Source Address or VLAN Insertion Enable          : %s\n",
+	       pdata->hw_feat.sa_vlan_ins ? "YES" : "NO");
+
+	/* HW Feature Register1 */
+	switch (pdata->hw_feat.rx_fifo_size) {
+	case 0:
+		str = "128 bytes";
+		break;
+	case 1:
+		str = "256 bytes";
+		break;
+	case 2:
+		str = "512 bytes";
+		break;
+	case 3:
+		str = "1 KBytes";
+		break;
+	case 4:
+		str = "2 KBytes";
+		break;
+	case 5:
+		str = "4 KBytes";
+		break;
+	case 6:
+		str = "8 KBytes";
+		break;
+	case 7:
+		str = "16 KBytes";
+		break;
+	case 8:
+		str = "32 kBytes";
+		break;
+	case 9:
+		str = "64 KBytes";
+		break;
+	case 10:
+		str = "128 KBytes";
+		break;
+	case 11:
+		str = "256 KBytes";
+		break;
+	default:
+		str = "RESERVED";
+	}
+	yt_dbg(pdata, "MTL Receive FIFO Size                            : %s\n",
+	       str);
+
+	switch (pdata->hw_feat.tx_fifo_size) {
+	case 0:
+		str = "128 bytes";
+		break;
+	case 1:
+		str = "256 bytes";
+		break;
+	case 2:
+		str = "512 bytes";
+		break;
+	case 3:
+		str = "1 KBytes";
+		break;
+	case 4:
+		str = "2 KBytes";
+		break;
+	case 5:
+		str = "4 KBytes";
+		break;
+	case 6:
+		str = "8 KBytes";
+		break;
+	case 7:
+		str = "16 KBytes";
+		break;
+	case 8:
+		str = "32 kBytes";
+		break;
+	case 9:
+		str = "64 KBytes";
+		break;
+	case 10:
+		str = "128 KBytes";
+		break;
+	case 11:
+		str = "256 KBytes";
+		break;
+	default:
+		str = "RESERVED";
+	}
+	yt_dbg(pdata, "MTL Transmit FIFO Size                           : %s\n",
+	       str);
+	yt_dbg(pdata, "IEEE 1588 High Word Register Enable              : %s\n",
+	       pdata->hw_feat.adv_ts_hi ? "YES" : "NO");
+	yt_dbg(pdata, "Address width                                    : %u\n",
+	       pdata->hw_feat.dma_width);
+	yt_dbg(pdata, "DCB Feature Enable                               : %s\n",
+	       pdata->hw_feat.dcb ? "YES" : "NO");
+	yt_dbg(pdata, "Split Header Feature Enable                      : %s\n",
+	       pdata->hw_feat.sph ? "YES" : "NO");
+	yt_dbg(pdata, "TCP Segmentation Offload Enable                  : %s\n",
+	       pdata->hw_feat.tso ? "YES" : "NO");
+	yt_dbg(pdata, "DMA Debug Registers Enabled                      : %s\n",
+	       pdata->hw_feat.dma_debug ? "YES" : "NO");
+	yt_dbg(pdata, "RSS Feature Enabled                              : %s\n",
+	       "YES");
+	yt_dbg(pdata, "AV Feature Enabled                               : %s\n",
+	       pdata->hw_feat.avsel ? "YES" : "NO");
+	yt_dbg(pdata, "Rx Side Only AV Feature Enabled                  : %s\n",
+	       (pdata->hw_feat.ravsel ? "YES" : "NO"));
+	yt_dbg(pdata, "Hash Table Size                                  : %u\n",
+	       pdata->hw_feat.hash_table_size);
+	yt_dbg(pdata, "Total number of L3 or L4 Filters                 : %u\n",
+	       pdata->hw_feat.l3l4_filter_num);
+
+	/* HW Feature Register2 */
+	yt_dbg(pdata, "Number of MTL Receive Queues                     : %u\n",
+	       pdata->hw_feat.rx_q_cnt);
+	yt_dbg(pdata, "Number of MTL Transmit Queues                    : %u\n",
+	       pdata->hw_feat.tx_q_cnt);
+	yt_dbg(pdata, "Number of DMA Receive Channels                   : %u\n",
+	       pdata->hw_feat.rx_ch_cnt);
+	yt_dbg(pdata, "Number of DMA Transmit Channels                  : %u\n",
+	       pdata->hw_feat.tx_ch_cnt);
+
+	switch (pdata->hw_feat.pps_out_num) {
+	case 0:
+		str = "No PPS output";
+		break;
+	case 1:
+		str = "1 PPS output";
+		break;
+	case 2:
+		str = "2 PPS output";
+		break;
+	case 3:
+		str = "3 PPS output";
+		break;
+	case 4:
+		str = "4 PPS output";
+		break;
+	default:
+		str = "RESERVED";
+	}
+	yt_dbg(pdata, "Number of PPS Outputs                            : %s\n",
+	       str);
+
+	switch (pdata->hw_feat.aux_snap_num) {
+	case 0:
+		str = "No auxiliary input";
+		break;
+	case 1:
+		str = "1 auxiliary input";
+		break;
+	case 2:
+		str = "2 auxiliary input";
+		break;
+	case 3:
+		str = "3 auxiliary input";
+		break;
+	case 4:
+		str = "4 auxiliary input";
+		break;
+	default:
+		str = "RESERVED";
+	}
+	yt_dbg(pdata, "Number of Auxiliary Snapshot Inputs              : %s\n",
+	       str);
+
+	yt_dbg(pdata, "\n");
+	yt_dbg(pdata, "====================================================\n");
+	yt_dbg(pdata, "\n");
+}
diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_desc.c b/drivers/net/ethernet/motorcomm/yt6801/yt6801_desc.c
new file mode 100644
index 0000000..7378d7d
--- /dev/null
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_desc.c
@@ -0,0 +1,739 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (c) 2022 - 2024 Motorcomm Electronic Technology Co.,Ltd. */
+
+#include "yt6801_type.h"
+#include "yt6801_desc.h"
+
+void fxgmac_desc_data_unmap(struct fxgmac_pdata *pdata,
+			    struct fxgmac_desc_data *desc_data)
+{
+	if (desc_data->skb_dma) {
+		if (desc_data->mapped_as_page) {
+			dma_unmap_page(pdata->dev, desc_data->skb_dma,
+				       desc_data->skb_dma_len, DMA_TO_DEVICE);
+		} else {
+			dma_unmap_single(pdata->dev, desc_data->skb_dma,
+					 desc_data->skb_dma_len, DMA_TO_DEVICE);
+		}
+		desc_data->skb_dma = 0;
+		desc_data->skb_dma_len = 0;
+	}
+
+	if (desc_data->skb) {
+		dev_kfree_skb_any(desc_data->skb);
+		desc_data->skb = NULL;
+	}
+
+	if (desc_data->rx.hdr.pa.pages)
+		put_page(desc_data->rx.hdr.pa.pages);
+
+	if (desc_data->rx.hdr.pa_unmap.pages) {
+		dma_unmap_page(pdata->dev, desc_data->rx.hdr.pa_unmap.pages_dma,
+			       desc_data->rx.hdr.pa_unmap.pages_len,
+			       DMA_FROM_DEVICE);
+		put_page(desc_data->rx.hdr.pa_unmap.pages);
+	}
+
+	if (desc_data->rx.buf.pa.pages)
+		put_page(desc_data->rx.buf.pa.pages);
+
+	if (desc_data->rx.buf.pa_unmap.pages) {
+		dma_unmap_page(pdata->dev, desc_data->rx.buf.pa_unmap.pages_dma,
+			       desc_data->rx.buf.pa_unmap.pages_len,
+			       DMA_FROM_DEVICE);
+		put_page(desc_data->rx.buf.pa_unmap.pages);
+	}
+	memset(&desc_data->tx, 0, sizeof(desc_data->tx));
+	memset(&desc_data->rx, 0, sizeof(desc_data->rx));
+
+	desc_data->mapped_as_page = 0;
+}
+
+static void fxgmac_ring_free(struct fxgmac_pdata *pdata,
+			     struct fxgmac_ring *ring)
+{
+	if (!ring)
+		return;
+
+	if (ring->desc_data_head) {
+		for (u32 i = 0; i < ring->dma_desc_count; i++)
+			fxgmac_desc_data_unmap(pdata,
+					       FXGMAC_GET_DESC_DATA(ring, i));
+
+		kfree(ring->desc_data_head);
+		ring->desc_data_head = NULL;
+	}
+
+	if (ring->rx_hdr_pa.pages) {
+		dma_unmap_page(pdata->dev, ring->rx_hdr_pa.pages_dma,
+			       ring->rx_hdr_pa.pages_len, DMA_FROM_DEVICE);
+		put_page(ring->rx_hdr_pa.pages);
+
+		ring->rx_hdr_pa.pages = NULL;
+		ring->rx_hdr_pa.pages_len = 0;
+		ring->rx_hdr_pa.pages_offset = 0;
+		ring->rx_hdr_pa.pages_dma = 0;
+	}
+
+	if (ring->rx_buf_pa.pages) {
+		dma_unmap_page(pdata->dev, ring->rx_buf_pa.pages_dma,
+			       ring->rx_buf_pa.pages_len, DMA_FROM_DEVICE);
+		put_page(ring->rx_buf_pa.pages);
+
+		ring->rx_buf_pa.pages = NULL;
+		ring->rx_buf_pa.pages_len = 0;
+		ring->rx_buf_pa.pages_offset = 0;
+		ring->rx_buf_pa.pages_dma = 0;
+	}
+	if (ring->dma_desc_head) {
+		dma_free_coherent(pdata->dev, (sizeof(struct fxgmac_dma_desc) *
+				  ring->dma_desc_count), ring->dma_desc_head,
+				  ring->dma_desc_head_addr);
+		ring->dma_desc_head = NULL;
+	}
+}
+
+static int fxgmac_ring_init(struct fxgmac_pdata *pdata,
+			    struct fxgmac_ring *ring,
+			    unsigned int dma_desc_count)
+{
+	if (!ring)
+		return 0;
+
+	/* Descriptors */
+	ring->dma_desc_count = dma_desc_count;
+	ring->dma_desc_head =
+		dma_alloc_coherent(pdata->dev, (sizeof(struct fxgmac_dma_desc) *
+				   dma_desc_count),
+				   &ring->dma_desc_head_addr, GFP_KERNEL);
+	if (!ring->dma_desc_head)
+		return -ENOMEM;
+
+	/* Array of descriptor data */
+	ring->desc_data_head = kcalloc(dma_desc_count,
+				       sizeof(struct fxgmac_desc_data),
+				       GFP_KERNEL);
+	if (!ring->desc_data_head)
+		return -ENOMEM;
+
+	yt_dbg(pdata,
+	       "dma_desc_head=%p, dma_desc_head_addr=%pad, desc_data_head=%p\n",
+	       ring->dma_desc_head, &ring->dma_desc_head_addr,
+	       ring->desc_data_head);
+	return 0;
+}
+
+static void fxgmac_rings_free(struct fxgmac_pdata *pdata)
+{
+	struct fxgmac_channel *channel = pdata->channel_head;
+
+	if (!channel)
+		return;
+
+	for (u32 i = 0; i < pdata->channel_count; i++, channel++) {
+		fxgmac_ring_free(pdata, channel->tx_ring);
+		fxgmac_ring_free(pdata, channel->rx_ring);
+	}
+}
+
+static int fxgmac_rings_alloc(struct fxgmac_pdata *pdata)
+{
+	struct fxgmac_channel *channel = pdata->channel_head;
+	int ret;
+
+	for (u32 i = 0; i < pdata->channel_count; i++, channel++) {
+		yt_dbg(pdata, "%s - Tx ring:\n", channel->name);
+
+		if (i < pdata->tx_ring_count) {
+			ret = fxgmac_ring_init(pdata, channel->tx_ring,
+					       pdata->tx_desc_count);
+
+			if (ret < 0) {
+				yt_err(pdata, "error initializing Tx ring");
+				goto err_init_ring;
+			}
+		}
+
+		yt_dbg(pdata, "%s - Rx ring:\n", channel->name);
+
+		ret = fxgmac_ring_init(pdata, channel->rx_ring,
+				       pdata->rx_desc_count);
+		if (ret < 0) {
+			yt_err(pdata, "error initializing Rx ring\n");
+			goto err_init_ring;
+		}
+		if (netif_msg_drv(pdata))
+			yt_dbg(pdata,
+			       "%s, ch=%u,tx_desc_cnt=%u,rx_desc_cnt=%u\n",
+			       __func__, i, pdata->tx_desc_count,
+			       pdata->rx_desc_count);
+	}
+	if (netif_msg_drv(pdata))
+		yt_dbg(pdata, "%s ok\n", __func__);
+
+	return 0;
+
+err_init_ring:
+	fxgmac_rings_free(pdata);
+
+	yt_err(pdata, "%s err:%d\n", __func__, ret);
+	return ret;
+}
+
+static void fxgmac_channels_free(struct fxgmac_pdata *pdata)
+{
+	struct fxgmac_channel *channel = pdata->channel_head;
+
+	if (!channel)
+		return;
+
+	if (netif_msg_drv(pdata))
+		yt_dbg(pdata, "free_channels,tx_ring=%p\n", channel->tx_ring);
+
+	kfree(channel->tx_ring);
+	channel->tx_ring = NULL;
+	if (netif_msg_drv(pdata))
+		yt_dbg(pdata, "free_channels,rx_ring=%p\n", channel->rx_ring);
+
+	kfree(channel->rx_ring);
+	channel->rx_ring = NULL;
+	if (netif_msg_drv(pdata))
+		yt_dbg(pdata, "free_channels,channel=%p\n", channel);
+
+	kfree(channel);
+	pdata->channel_head = NULL;
+}
+
+#ifdef CONFIG_PCI_MSI
+static void fxgmac_set_msix_tx_irq(struct fxgmac_pdata *pdata,
+				   struct fxgmac_channel *channel, u32 i)
+{
+	pdata->channel_irq[i] = pdata->msix_entries[i].vector;
+
+	if (!FXGMAC_IS_CHANNEL_WITH_TX_IRQ(i))
+		return;
+
+	/*  add why  FXGMAC_MAX_DMA_RX_CHANNELS*/
+	pdata->channel_irq[FXGMAC_MAX_DMA_RX_CHANNELS] =
+		pdata->msix_entries[FXGMAC_MAX_DMA_RX_CHANNELS].vector;
+	channel->dma_irq_tx = pdata->channel_irq[FXGMAC_MAX_DMA_RX_CHANNELS];
+
+	yt_dbg(pdata, "%s, for MSIx, channel %d dma_irq_tx=%u\n", __func__, i,
+	       channel->dma_irq_tx);
+}
+#endif
+
+static int fxgmac_channels_alloc(struct fxgmac_pdata *pdata)
+{
+	struct fxgmac_channel *channel_head, *channel;
+	struct fxgmac_ring *tx_ring, *rx_ring;
+	int ret = -ENOMEM;
+
+	channel_head = kcalloc(pdata->channel_count,
+			       sizeof(struct fxgmac_channel), GFP_KERNEL);
+	if (netif_msg_drv(pdata))
+		yt_dbg(pdata, "alloc_channels,channel_head=%p,size=%d*%ld\n",
+		       channel_head, pdata->channel_count,
+		       sizeof(struct fxgmac_channel));
+
+	if (!channel_head)
+		return ret;
+
+	tx_ring = kcalloc(pdata->tx_ring_count, sizeof(struct fxgmac_ring),
+			  GFP_KERNEL);
+	if (!tx_ring)
+		goto err_tx_ring;
+
+	if (netif_msg_drv(pdata))
+		yt_dbg(pdata, "alloc_channels,tx_ring=%p,size=%d*%ld\n",
+		       tx_ring, pdata->tx_ring_count,
+		       sizeof(struct fxgmac_ring));
+
+	rx_ring = kcalloc(pdata->rx_ring_count, sizeof(struct fxgmac_ring),
+			  GFP_KERNEL);
+	if (!rx_ring)
+		goto err_rx_ring;
+
+	if (netif_msg_drv(pdata))
+		yt_dbg(pdata, "alloc_channels,rx_ring=%p,size=%d*%ld\n",
+		       rx_ring, pdata->rx_ring_count,
+		       sizeof(struct fxgmac_ring));
+
+	channel = channel_head;
+	for (u32 i = 0; i < pdata->channel_count; i++, channel++) {
+		snprintf(channel->name, sizeof(channel->name), "channel-%u", i);
+		channel->pdata = pdata;
+		channel->queue_index = i;
+		channel->dma_regs = pdata->hw_addr + MAC_OFFSET + DMA_CH_BASE +
+				    (DMA_CH_INC * i);
+
+		if (pdata->per_channel_irq) {
+#ifdef CONFIG_PCI_MSI
+			fxgmac_set_msix_tx_irq(pdata, channel, i);
+#endif
+
+			/* Get the per DMA rx interrupt */
+			ret = pdata->channel_irq[i];
+			if (ret < 0) {
+				yt_err(pdata, "get_irq %u err\n", i + 1);
+				goto err_irq;
+			}
+
+			channel->dma_irq_rx = ret;
+			yt_dbg(pdata,
+			       "%s, for MSIx, channel %d dma_irq_rx=%u\n",
+			       __func__, i, channel->dma_irq_rx);
+		}
+
+		if (i < pdata->tx_ring_count)
+			channel->tx_ring = tx_ring++;
+
+		if (i < pdata->rx_ring_count)
+			channel->rx_ring = rx_ring++;
+	}
+
+	pdata->channel_head = channel_head;
+
+	if (netif_msg_drv(pdata))
+		yt_dbg(pdata, "%s ok\n", __func__);
+	return 0;
+
+err_irq:
+	kfree(rx_ring);
+
+err_rx_ring:
+	kfree(tx_ring);
+
+err_tx_ring:
+	kfree(channel_head);
+
+	yt_err(pdata, "%s err:%d\n", __func__, ret);
+	return ret;
+}
+
+void fxgmac_channels_rings_free(struct fxgmac_pdata *pdata)
+{
+	fxgmac_rings_free(pdata);
+	fxgmac_channels_free(pdata);
+}
+
+int fxgmac_channels_rings_alloc(struct fxgmac_pdata *pdata)
+{
+	int ret;
+
+	ret = fxgmac_channels_alloc(pdata);
+	if (ret < 0)
+		goto err_alloc;
+
+	ret = fxgmac_rings_alloc(pdata);
+	if (ret < 0)
+		goto err_alloc;
+
+	return 0;
+
+err_alloc:
+	fxgmac_channels_rings_free(pdata);
+
+	return ret;
+}
+
+static void fxgmac_set_buffer_data(struct fxgmac_buffer_data *bd,
+				   struct fxgmac_page_alloc *pa,
+				   unsigned int len)
+{
+	get_page(pa->pages);
+	bd->pa = *pa;
+
+	bd->dma_base = pa->pages_dma;
+	bd->dma_off = pa->pages_offset;
+	bd->dma_len = len;
+
+	pa->pages_offset += len;
+	if ((pa->pages_offset + len) > pa->pages_len) {
+		/* This data descriptor is responsible for unmapping page(s) */
+		bd->pa_unmap = *pa;
+
+		/* Get a new allocation next time */
+		pa->pages = NULL;
+		pa->pages_len = 0;
+		pa->pages_offset = 0;
+		pa->pages_dma = 0;
+	}
+}
+
+static int fxgmac_alloc_pages(struct fxgmac_pdata *pdata,
+			      struct fxgmac_page_alloc *pa, gfp_t gfp,
+			      int order)
+{
+	struct page *pages = NULL;
+	dma_addr_t pages_dma;
+
+	/* Try to obtain pages, decreasing order if necessary */
+	gfp |= __GFP_COMP | __GFP_NOWARN;
+	while (order >= 0) {
+		pages = alloc_pages(gfp, order);
+		if (pages)
+			break;
+
+		order--;
+	}
+
+	if (!pages)
+		return -ENOMEM;
+
+	/* Map the pages */
+	pages_dma = dma_map_page(pdata->dev, pages, 0, PAGE_SIZE << order,
+				 DMA_FROM_DEVICE);
+	if (dma_mapping_error(pdata->dev, pages_dma)) {
+		put_page(pages);
+		return -ENOMEM;
+	}
+
+	pa->pages = pages;
+	pa->pages_len = PAGE_SIZE << order;
+	pa->pages_offset = 0;
+	pa->pages_dma = pages_dma;
+
+	return 0;
+}
+
+#define FXGMAC_SKB_ALLOC_SIZE 512
+
+int fxgmac_rx_buffe_map(struct fxgmac_pdata *pdata, struct fxgmac_ring *ring,
+			struct fxgmac_desc_data *desc_data)
+{
+	int ret;
+
+	if (!ring->rx_hdr_pa.pages) {
+		ret = fxgmac_alloc_pages(pdata, &ring->rx_hdr_pa, GFP_ATOMIC,
+					 0);
+		if (ret)
+			return ret;
+	}
+	/* Set up the header page info */
+	fxgmac_set_buffer_data(&desc_data->rx.hdr, &ring->rx_hdr_pa,
+			       pdata->rx_buf_size);
+
+	return 0;
+}
+
+void fxgmac_desc_tx_reset(struct fxgmac_desc_data *desc_data)
+{
+	struct fxgmac_dma_desc *dma_desc = desc_data->dma_desc;
+
+	/* Reset the Tx descriptor
+	 * Set buffer 1 (lo) address to zero
+	 * Set buffer 1 (hi) address to zero
+	 * Reset all other control bits (IC, TTSE, B2L & B1L)
+	 * Reset all other control bits (OWN, CTXT, FD, LD, CPC, CIC, etc)
+	 */
+	dma_desc->desc0 = 0;
+	dma_desc->desc1 = 0;
+	dma_desc->desc2 = 0;
+	dma_desc->desc3 = 0;
+
+	/* Make sure ownership is written to the descriptor */
+	dma_wmb();
+}
+
+static void fxgmac_desc_tx_channel_init(struct fxgmac_channel *channel)
+{
+	struct fxgmac_ring *ring = channel->tx_ring;
+	struct fxgmac_desc_data *desc_data;
+	int start_index = ring->cur;
+
+	/* Initialize all descriptors */
+	for (u32 i = 0; i < ring->dma_desc_count; i++) {
+		desc_data = FXGMAC_GET_DESC_DATA(ring, i);
+		fxgmac_desc_tx_reset(desc_data); /* Initialize Tx descriptor */
+	}
+
+	/* Update the total number of Tx descriptors */
+	writel(channel->pdata->tx_desc_count - 1,
+	       FXGMAC_DMA_REG(channel, DMA_CH_TDRLR));
+
+	/* Update the starting address of descriptor ring */
+	desc_data = FXGMAC_GET_DESC_DATA(ring, start_index);
+	writel(upper_32_bits(desc_data->dma_desc_addr),
+	       FXGMAC_DMA_REG(channel, DMA_CH_TDLR_HI));
+	writel(lower_32_bits(desc_data->dma_desc_addr),
+	       FXGMAC_DMA_REG(channel, DMA_CH_TDLR_LO));
+}
+
+void fxgmac_desc_tx_init(struct fxgmac_pdata *pdata)
+{
+	struct fxgmac_desc_data *desc_data;
+	struct fxgmac_dma_desc *dma_desc;
+	struct fxgmac_channel *channel;
+	dma_addr_t dma_desc_addr;
+	struct fxgmac_ring *ring;
+
+	channel = pdata->channel_head;
+	for (u32 i = 0; i < pdata->channel_count; i++, channel++) {
+		ring = channel->tx_ring;
+		if (!ring)
+			break;
+
+		channel->tx_timer_active = 0; /* reset the tx timer status. */
+		dma_desc = ring->dma_desc_head;
+		dma_desc_addr = ring->dma_desc_head_addr;
+
+		for (u32 j = 0; j < ring->dma_desc_count; j++) {
+			desc_data = FXGMAC_GET_DESC_DATA(ring, j);
+			desc_data->dma_desc = dma_desc;
+			desc_data->dma_desc_addr = dma_desc_addr;
+
+			dma_desc++;
+			dma_desc_addr += sizeof(struct fxgmac_dma_desc);
+		}
+
+		ring->cur = 0;
+		ring->dirty = 0;
+		memset(&ring->tx, 0, sizeof(ring->tx));
+
+		fxgmac_desc_tx_channel_init(channel);
+	}
+}
+
+void fxgmac_desc_rx_reset(struct fxgmac_pdata *pdata,
+			  struct fxgmac_desc_data *desc_data,
+			  unsigned int index)
+{
+	struct fxgmac_dma_desc *dma_desc = desc_data->dma_desc;
+	dma_addr_t hdr_dma;
+
+	/* Reset the Rx descriptor
+	 * Set buffer 1 (lo) address to header dma address (lo)
+	 * Set buffer 1 (hi) address to header dma address (hi)
+	 * set control bits OWN and INTE
+	 */
+	hdr_dma = desc_data->rx.hdr.dma_base + desc_data->rx.hdr.dma_off;
+	dma_desc->desc0 = cpu_to_le32(lower_32_bits(hdr_dma));
+	dma_desc->desc1 = cpu_to_le32(upper_32_bits(hdr_dma));
+	dma_desc->desc2 = 0;
+	dma_desc->desc3 = 0;
+	dma_desc->desc3 = FXGMAC_SET_BITS_LE(dma_desc->desc3,
+					     RX_NORMAL_DESC3_INTE_POS,
+					     RX_NORMAL_DESC3_INTE_LEN, 1);
+	dma_desc->desc3 = FXGMAC_SET_BITS_LE(dma_desc->desc3,
+					     RX_NORMAL_DESC3_BUF2V_POS,
+					     RX_NORMAL_DESC3_BUF2V_LEN, 0);
+	dma_desc->desc3 = FXGMAC_SET_BITS_LE(dma_desc->desc3,
+					     RX_NORMAL_DESC3_BUF1V_POS,
+					     RX_NORMAL_DESC3_BUF1V_LEN, 1);
+
+	/* Since the Rx DMA engine is likely running, make sure everything
+	 * is written to the descriptor(s) before setting the OWN bit
+	 * for the descriptor
+	 */
+	dma_wmb();
+
+	dma_desc->desc3 = FXGMAC_SET_BITS_LE(dma_desc->desc3,
+					     RX_NORMAL_DESC3_OWN_POS,
+					     RX_NORMAL_DESC3_OWN_LEN, 1);
+
+	/* Make sure ownership is written to the descriptor */
+	dma_wmb();
+}
+
+static void fxgmac_desc_rx_channel_init(struct fxgmac_channel *channel)
+{
+	struct fxgmac_pdata *pdata = channel->pdata;
+	struct fxgmac_ring *ring = channel->rx_ring;
+	unsigned int start_index = ring->cur;
+	struct fxgmac_desc_data *desc_data;
+
+	/* Initialize all descriptors */
+	for (u32 i = 0; i < ring->dma_desc_count; i++) {
+		desc_data = FXGMAC_GET_DESC_DATA(ring, i);
+
+		/* Initialize Rx descriptor */
+		fxgmac_desc_rx_reset(pdata, desc_data, i);
+	}
+
+	/* Update the total number of Rx descriptors */
+	writel(ring->dma_desc_count - 1, FXGMAC_DMA_REG(channel, DMA_CH_RDRLR));
+
+	/* Update the starting address of descriptor ring */
+	desc_data = FXGMAC_GET_DESC_DATA(ring, start_index);
+	writel(upper_32_bits(desc_data->dma_desc_addr),
+	       FXGMAC_DMA_REG(channel, DMA_CH_RDLR_HI));
+	writel(lower_32_bits(desc_data->dma_desc_addr),
+	       FXGMAC_DMA_REG(channel, DMA_CH_RDLR_LO));
+
+	/* Update the Rx Descriptor Tail Pointer */
+	desc_data =
+		FXGMAC_GET_DESC_DATA(ring,
+				     start_index + ring->dma_desc_count - 1);
+	writel(lower_32_bits(desc_data->dma_desc_addr),
+	       FXGMAC_DMA_REG(channel, DMA_CH_RDTR_LO));
+}
+
+void fxgmac_desc_rx_init(struct fxgmac_pdata *pdata)
+{
+	struct fxgmac_desc_data *desc_data;
+	struct fxgmac_dma_desc *dma_desc;
+	struct fxgmac_channel *channel;
+	dma_addr_t dma_desc_addr;
+	struct fxgmac_ring *ring;
+
+	channel = pdata->channel_head;
+	for (u32 i = 0; i < pdata->channel_count; i++, channel++) {
+		ring = channel->rx_ring;
+		if (!ring)
+			break;
+
+		dma_desc = ring->dma_desc_head;
+		dma_desc_addr = ring->dma_desc_head_addr;
+
+		for (u32 j = 0; j < ring->dma_desc_count; j++) {
+			desc_data = FXGMAC_GET_DESC_DATA(ring, j);
+			desc_data->dma_desc = dma_desc;
+			desc_data->dma_desc_addr = dma_desc_addr;
+
+			if (fxgmac_rx_buffe_map(pdata, ring, desc_data))
+				break;
+
+			dma_desc++;
+			dma_desc_addr += sizeof(struct fxgmac_dma_desc);
+		}
+
+		ring->cur = 0;
+		ring->dirty = 0;
+
+		fxgmac_desc_rx_channel_init(channel);
+	}
+}
+
+int fxgmac_tx_skb_map(struct fxgmac_channel *channel, struct sk_buff *skb)
+{
+	struct fxgmac_pdata *pdata = channel->pdata;
+	struct fxgmac_ring *ring = channel->tx_ring;
+	struct fxgmac_desc_data *desc_data;
+	unsigned int start_index, cur_index;
+	unsigned int offset, datalen, len;
+	struct fxgmac_pkt_info *pkt_info;
+	unsigned int tso, vlan;
+	dma_addr_t skb_dma;
+	skb_frag_t *frag;
+
+	offset = 0;
+	start_index = ring->cur;
+	cur_index = ring->cur;
+	pkt_info = &ring->pkt_info;
+	pkt_info->desc_count = 0;
+	pkt_info->length = 0;
+
+	tso = FXGMAC_GET_BITS(pkt_info->attributes, TX_PKT_ATTR_TSO_ENABLE_POS,
+			      TX_PKT_ATTR_TSO_ENABLE_LEN);
+	vlan = FXGMAC_GET_BITS(pkt_info->attributes, TX_PKT_ATTR_VLAN_CTAG_POS,
+			       TX_PKT_ATTR_VLAN_CTAG_LEN);
+
+	/* Save space for a context descriptor if needed */
+	if ((tso && pkt_info->mss != ring->tx.cur_mss) ||
+	    (vlan && pkt_info->vlan_ctag != ring->tx.cur_vlan_ctag))
+		cur_index = FXGMAC_GET_ENTRY(cur_index, ring->dma_desc_count);
+
+	desc_data = FXGMAC_GET_DESC_DATA(ring, cur_index);
+
+	if (tso) {
+		/* Map the TSO header */
+		skb_dma = dma_map_single(pdata->dev, skb->data,
+					 pkt_info->header_len, DMA_TO_DEVICE);
+		if (dma_mapping_error(pdata->dev, skb_dma)) {
+			yt_err(pdata, "dma_map_single err\n");
+			goto err_out;
+		}
+		desc_data->skb_dma = skb_dma;
+		desc_data->skb_dma_len = pkt_info->header_len;
+		yt_dbg(pdata, "skb header: index=%u, dma=%pad, len=%u\n",
+		       cur_index, &skb_dma, pkt_info->header_len);
+
+		offset = pkt_info->header_len;
+		pkt_info->length += pkt_info->header_len;
+
+		cur_index = FXGMAC_GET_ENTRY(cur_index, ring->dma_desc_count);
+		desc_data = FXGMAC_GET_DESC_DATA(ring, cur_index);
+	}
+
+	/* Map the (remainder of the) packet */
+	for (datalen = skb_headlen(skb) - offset; datalen;) {
+		len = min_t(unsigned int, datalen, FXGMAC_TX_MAX_BUF_SIZE);
+		skb_dma = dma_map_single(pdata->dev, skb->data + offset, len,
+					 DMA_TO_DEVICE);
+		if (dma_mapping_error(pdata->dev, skb_dma)) {
+			yt_err(pdata, "dma_map_single err\n");
+			goto err_out;
+		}
+		desc_data->skb_dma = skb_dma;
+		desc_data->skb_dma_len = len;
+		yt_dbg(pdata, "skb data: index=%u, dma=%pad, len=%u\n",
+		       cur_index, &skb_dma, len);
+
+		datalen -= len;
+		offset += len;
+		pkt_info->length += len;
+
+		cur_index = FXGMAC_GET_ENTRY(cur_index, ring->dma_desc_count);
+		desc_data = FXGMAC_GET_DESC_DATA(ring, cur_index);
+	}
+
+	for (u32 i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
+		yt_dbg(pdata, "mapping frag %u\n", i);
+
+		frag = &skb_shinfo(skb)->frags[i];
+		offset = 0;
+
+		for (datalen = skb_frag_size(frag); datalen;) {
+			len = min_t(unsigned int, datalen,
+				    FXGMAC_TX_MAX_BUF_SIZE);
+			skb_dma = skb_frag_dma_map(pdata->dev, frag, offset,
+						   len, DMA_TO_DEVICE);
+			if (dma_mapping_error(pdata->dev, skb_dma)) {
+				yt_err(pdata, "skb_frag_dma_map err\n");
+				goto err_out;
+			}
+			desc_data->skb_dma = skb_dma;
+			desc_data->skb_dma_len = len;
+			desc_data->mapped_as_page = 1;
+
+			yt_dbg(pdata, "skb frag: index=%u, dma=%pad, len=%u\n",
+			       cur_index, &skb_dma, len);
+
+			datalen -= len;
+			offset += len;
+			pkt_info->length += len;
+
+			cur_index = FXGMAC_GET_ENTRY(cur_index,
+						     ring->dma_desc_count);
+			desc_data = FXGMAC_GET_DESC_DATA(ring, cur_index);
+		}
+	}
+
+	/* Save the skb address in the last entry. We always have some data
+	 * that has been mapped so desc_data is always advanced past the last
+	 * piece of mapped data - use the entry pointed to by cur_index - 1.
+	 */
+	desc_data = FXGMAC_GET_DESC_DATA(ring, (cur_index - 1) &
+					 (ring->dma_desc_count - 1));
+	desc_data->skb = skb;
+
+	/* Save the number of descriptor entries used */
+	if (start_index <= cur_index)
+		pkt_info->desc_count = cur_index - start_index;
+	else
+		pkt_info->desc_count =
+			ring->dma_desc_count - start_index + cur_index;
+
+	return pkt_info->desc_count;
+
+err_out:
+	while (start_index < cur_index) {
+		desc_data = FXGMAC_GET_DESC_DATA(ring, start_index);
+		start_index =
+			FXGMAC_GET_ENTRY(start_index, ring->dma_desc_count);
+		fxgmac_desc_data_unmap(pdata, desc_data);
+	}
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_desc.h b/drivers/net/ethernet/motorcomm/yt6801/yt6801_desc.h
new file mode 100644
index 0000000..e070a70
--- /dev/null
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_desc.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Copyright (c) 2022 - 2024 Motorcomm Electronic Technology Co.,Ltd. */
+
+#ifndef _YT6801_DESC_H_
+#define _YT6801_DESC_H_
+
+#include "yt6801.h"
+
+#define FXGMAC_TX_DESC_CNT		256
+#define FXGMAC_TX_DESC_MIN_FREE		(FXGMAC_TX_DESC_CNT >> 3)
+#define FXGMAC_TX_DESC_MAX_PROC		(FXGMAC_TX_DESC_CNT >> 1)
+#define FXGMAC_RX_DESC_CNT		1024
+#define FXGMAC_RX_DESC_MAX_DIRTY	(FXGMAC_RX_DESC_CNT >> 3)
+
+#define FXGMAC_GET_DESC_DATA(ring, idx)	((ring)->desc_data_head + (idx))
+#define FXGMAC_GET_ENTRY(x, size)	(((x) + 1) & ((size) - 1))
+
+#define FXGMAC_IS_CHANNEL_WITH_TX_IRQ(chid) (0 == (chid) ? 1 : 0)
+
+void fxgmac_desc_tx_init(struct fxgmac_pdata *pdata);
+void fxgmac_desc_rx_init(struct fxgmac_pdata *pdata);
+void fxgmac_desc_tx_reset(struct fxgmac_desc_data *desc_data);
+void fxgmac_desc_rx_reset(struct fxgmac_pdata *pdata,
+			  struct fxgmac_desc_data *desc_data,
+			  unsigned int index);
+void fxgmac_desc_data_unmap(struct fxgmac_pdata *pdata,
+			    struct fxgmac_desc_data *desc_data);
+
+int fxgmac_channels_rings_alloc(struct fxgmac_pdata *pdata);
+void fxgmac_channels_rings_free(struct fxgmac_pdata *pdata);
+int fxgmac_tx_skb_map(struct fxgmac_channel *channel, struct sk_buff *skb);
+int fxgmac_rx_buffe_map(struct fxgmac_pdata *pdata, struct fxgmac_ring *ring,
+			struct fxgmac_desc_data *desc_data);
+void fxgmac_dump_tx_desc(struct fxgmac_pdata *pdata, struct fxgmac_ring *ring,
+			 unsigned int idx, unsigned int count,
+			 unsigned int flag);
+void fxgmac_dump_rx_desc(struct fxgmac_pdata *pdata, struct fxgmac_ring *ring,
+			 unsigned int idx);
+
+#endif /* _YT6801_DESC_H_ */
diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_efuse.c b/drivers/net/ethernet/motorcomm/yt6801/yt6801_efuse.c
new file mode 100644
index 0000000..1491a1c
--- /dev/null
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_efuse.c
@@ -0,0 +1,214 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (c) 2022 - 2024 Motorcomm Electronic Technology Co.,Ltd. */
+
+#include "yt6801_efuse.h"
+#include "yt6801_type.h"
+
+#define EFUSE_FISRT_UPDATE_ADDR				255
+#define EFUSE_SECOND_UPDATE_ADDR			209
+#define EFUSE_MAX_ENTRY					39
+#define EFUSE_PATCH_ADDR_START				0
+#define EFUSE_PATCH_DATA_START				2
+#define EFUSE_PATCH_SIZE				6
+#define EFUSE_REGION_A_B_LENGTH				18
+
+static bool fxgmac_efuse_read_data(struct fxgmac_pdata *pdata, u32 offset,
+				   u8 *value)
+{
+	bool ret = false;
+	u32 wait = 1000;
+	u32 val = 0;
+
+	fxgmac_set_bits(&val, EFUSE_OP_ADDR_POS, EFUSE_OP_ADDR_LEN, offset);
+	fxgmac_set_bits(&val, EFUSE_OP_START_POS, EFUSE_OP_START_LEN, 1);
+	fxgmac_set_bits(&val, EFUSE_OP_MODE_POS, EFUSE_OP_MODE_LEN,
+			EFUSE_OP_MODE_ROW_READ);
+	wr32_mem(pdata, val, EFUSE_OP_CTRL_0);
+
+	while (wait--) {
+		usleep_range(20, 50);
+		val = rd32_mem(pdata, EFUSE_OP_CTRL_1);
+		if (FXGMAC_GET_BITS(val, EFUSE_OP_DONE_POS,
+				    EFUSE_OP_DONE_LEN)) {
+			ret = true;
+			break;
+		}
+	}
+
+	if (!ret) {
+		yt_err(pdata, "Fail to reading efuse Byte%d\n", offset);
+		return ret;
+	}
+
+	if (value)
+		*value = FXGMAC_GET_BITS(val, EFUSE_OP_RD_DATA_POS,
+					 EFUSE_OP_RD_DATA_LEN) & 0xff;
+
+	return ret;
+}
+
+bool fxgmac_efuse_read_index_patch(struct fxgmac_pdata *pdata, u8 index,
+				   u32 *offset, u32 *value)
+{
+	u8 tmp[EFUSE_PATCH_SIZE - EFUSE_PATCH_DATA_START];
+	u32 addr, i;
+	bool ret;
+
+	if (index >= EFUSE_MAX_ENTRY) {
+		yt_err(pdata, "Reading efuse out of range, index %d\n", index);
+		return false;
+	}
+
+	for (i = EFUSE_PATCH_ADDR_START; i < EFUSE_PATCH_DATA_START; i++) {
+		addr = EFUSE_REGION_A_B_LENGTH + index * EFUSE_PATCH_SIZE + i;
+		ret = fxgmac_efuse_read_data(pdata, addr,
+					     tmp + i - EFUSE_PATCH_ADDR_START);
+		if (!ret) {
+			yt_err(pdata, "Fail to reading efuse Byte%d\n", addr);
+			return ret;
+		}
+	}
+	if (offset) {
+		/* tmp[0] is low 8bit date, tmp[1] is high 8bit date */
+		*offset = tmp[0] | (tmp[1] << 8);
+	}
+
+	for (i = EFUSE_PATCH_DATA_START; i < EFUSE_PATCH_SIZE; i++) {
+		addr = EFUSE_REGION_A_B_LENGTH + index * EFUSE_PATCH_SIZE + i;
+		ret = fxgmac_efuse_read_data(pdata, addr,
+					     tmp + i - EFUSE_PATCH_DATA_START);
+		if (!ret) {
+			yt_err(pdata, "Fail to reading efuse Byte%d\n", addr);
+			return ret;
+		}
+	}
+	if (value) {
+		/* tmp[0] is low 8bit date, tmp[1] is low 8bit date
+		 * ...  tmp[3] is highest 8bit date
+		 */
+		*value = tmp[0] | (tmp[1] << 8) | (tmp[2] << 16) |
+			 (tmp[3] << 24);
+	}
+
+	return ret;
+}
+
+bool fxgmac_efuse_read_mac_subsys(struct fxgmac_pdata *pdata, u8 *mac_addr,
+				  u32 *subsys, u32 *revid)
+{
+	u32 machr = 0, maclr = 0;
+	u32 offset = 0, val = 0;
+	bool ret = true;
+	u8 index;
+
+	for (index = 0;; index++) {
+		if (!fxgmac_efuse_read_index_patch(pdata, index, &offset, &val))
+			return false;
+
+		if (offset == 0x00)
+			break; /* reach the blank. */
+
+		if (offset == MACA0LR_FROM_EFUSE)
+			maclr = val;
+
+		if (offset == MACA0HR_FROM_EFUSE)
+			machr = val;
+
+		if (offset == PCI_REVISION_ID && revid)
+			*revid = val;
+
+		if (offset == PCI_SUBSYSTEM_VENDOR_ID && subsys)
+			*subsys = val;
+	}
+
+	if (mac_addr) {
+		mac_addr[5] = (u8)(maclr & 0xFF);
+		mac_addr[4] = (u8)((maclr >> 8) & 0xFF);
+		mac_addr[3] = (u8)((maclr >> 16) & 0xFF);
+		mac_addr[2] = (u8)((maclr >> 24) & 0xFF);
+		mac_addr[1] = (u8)(machr & 0xFF);
+		mac_addr[0] = (u8)((machr >> 8) & 0xFF);
+	}
+
+	return ret;
+}
+
+bool fxgmac_efuse_is_led_common(struct fxgmac_pdata *pdata)
+{
+	u8 val;
+
+	if (!fxgmac_efuse_read_data(pdata, EFUSE_LED_ADDR, &val))
+		return false;
+
+	val = FXGMAC_GET_BITS(val, EFUSE_LED_POS, EFUSE_LED_LEN);
+	return (val == EFUSE_LED_COMMON_SOLUTION) ? true : false;
+}
+
+static bool fxgmac_read_led_efuse_config_part(struct fxgmac_pdata *pdata,
+					      u32 addr, u32 cfg[LED_CFG_LEN])
+{
+	u8 val_high, val_low;
+
+	for (u32 i = 0; i < LED_CFG_LEN; i++) {
+		if (!fxgmac_efuse_read_data(pdata, addr - 2 * i, &val_high))
+			return false;
+		if (!fxgmac_efuse_read_data(pdata, (addr - 2 * i - 1),
+					    &val_low))
+			return false;
+
+		/* Reverse order storage */
+		cfg[LED_CFG_LEN - 1 - i] = ((val_high << 8) + val_low);
+	}
+
+	return true;
+}
+
+static bool fxgmac_read_led_efuse_config(struct fxgmac_pdata *pdata,
+					 struct led_setting *pfirst,
+					 struct led_setting *psecond)
+{
+	u32 cnt = sizeof(struct led_setting) / sizeof(pfirst->s0);
+	u32 i, addr, *cfg;
+	bool ret;
+
+	for (i = 0; i < cnt; i++) {
+		/* one part is LED_CFG_LEN * 2 address */
+		addr = EFUSE_FISRT_UPDATE_ADDR - LED_CFG_LEN * 2 * i;
+		cfg = ((u32 *)pfirst) + LED_CFG_LEN * i;
+		ret = fxgmac_read_led_efuse_config_part(pdata, addr, cfg);
+		if (!ret)
+			return false;
+	}
+
+	for (i = 0; i < cnt; i++) {
+		addr = EFUSE_SECOND_UPDATE_ADDR - LED_CFG_LEN * 2 * i;
+		cfg = ((u32 *)psecond) + LED_CFG_LEN * i;
+		ret = fxgmac_read_led_efuse_config_part(pdata, addr, cfg);
+		if (!ret)
+			return false;
+	}
+
+	return true;
+}
+
+bool fxgmac_efuse_load_led_cfg(struct fxgmac_pdata *pdata)
+{
+	struct led_setting first_cfg, second_cfg;
+	u16 cfg_sz = sizeof(struct led_setting);
+	struct led_setting zero = { 0 };
+
+	if (!fxgmac_read_led_efuse_config(pdata, &first_cfg, &second_cfg))
+		return false;
+
+	if (memcpy((void *)&first_cfg, (void *)&zero, cfg_sz) != 0) {
+		memcpy(&pdata->led, &first_cfg, cfg_sz);
+		return true;
+	}
+
+	if (memcpy((void *)&second_cfg, (void *)&zero, cfg_sz) == 0) {
+		memcpy(&pdata->led, &second_cfg, cfg_sz);
+		return true;
+	}
+
+	return false;
+}
diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_efuse.h b/drivers/net/ethernet/motorcomm/yt6801/yt6801_efuse.h
new file mode 100644
index 0000000..b30aab9
--- /dev/null
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_efuse.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Copyright (c) 2022 - 2024 Motorcomm Electronic Technology Co.,Ltd. */
+
+#ifndef _YT6801_EFUSE_H_
+#define _YT6801_EFUSE_H_
+
+#include "yt6801.h"
+
+/* read patch per 0-based index. */
+bool fxgmac_efuse_read_index_patch(struct fxgmac_pdata *pdata, u8 index,
+				   u32 *offset, u32 *value);
+bool fxgmac_efuse_read_mac_subsys(struct fxgmac_pdata *pdata, u8 *mac_addr,
+				  u32 *subsys, u32 *revid);
+bool fxgmac_efuse_load_led_cfg(struct fxgmac_pdata *pdata);
+
+#endif /* _YT6801_EFUSE_H_ */
diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_ethtool.c b/drivers/net/ethernet/motorcomm/yt6801/yt6801_ethtool.c
new file mode 100644
index 0000000..fc58ea6
--- /dev/null
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_ethtool.c
@@ -0,0 +1,1143 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (c) 2022 - 2024 Motorcomm Electronic Technology Co.,Ltd. */
+
+#include <linux/netdevice.h>
+#include <linux/ethtool.h>
+#include <linux/kernel.h>
+
+#include "yt6801_type.h"
+#include "yt6801_desc.h"
+#include "yt6801_phy.h"
+#include "yt6801_net.h"
+#include "yt6801.h"
+
+struct fxgmac_stats_desc {
+	char stat_string[ETH_GSTRING_LEN];
+	int stat_offset;
+};
+
+#define FXGMAC_STAT(str, var)                                                  \
+	{                                                                      \
+		str, offsetof(struct fxgmac_pdata, stats.var),                 \
+	}
+
+static const struct fxgmac_stats_desc fxgmac_gstring_stats[] = {
+	/* MMC TX counters */
+	FXGMAC_STAT("tx_bytes", txoctetcount_gb),
+	FXGMAC_STAT("tx_bytes_good", txoctetcount_g),
+	FXGMAC_STAT("tx_packets", txframecount_gb),
+	FXGMAC_STAT("tx_packets_good", txframecount_g),
+	FXGMAC_STAT("tx_unicast_packets", txunicastframes_gb),
+	FXGMAC_STAT("tx_broadcast_packets", txbroadcastframes_gb),
+	FXGMAC_STAT("tx_broadcast_packets_good", txbroadcastframes_g),
+	FXGMAC_STAT("tx_multicast_packets", txmulticastframes_gb),
+	FXGMAC_STAT("tx_multicast_packets_good", txmulticastframes_g),
+	FXGMAC_STAT("tx_vlan_packets_good", txvlanframes_g),
+	FXGMAC_STAT("tx_64_byte_packets", tx64octets_gb),
+	FXGMAC_STAT("tx_65_to_127_byte_packets", tx65to127octets_gb),
+	FXGMAC_STAT("tx_128_to_255_byte_packets", tx128to255octets_gb),
+	FXGMAC_STAT("tx_256_to_511_byte_packets", tx256to511octets_gb),
+	FXGMAC_STAT("tx_512_to_1023_byte_packets", tx512to1023octets_gb),
+	FXGMAC_STAT("tx_1024_to_max_byte_packets", tx1024tomaxoctets_gb),
+	FXGMAC_STAT("tx_underflow_errors", txunderflowerror),
+	FXGMAC_STAT("tx_pause_frames", txpauseframes),
+	FXGMAC_STAT("tx_single_collision", txsinglecollision_g),
+	FXGMAC_STAT("tx_multiple_collision", txmultiplecollision_g),
+	FXGMAC_STAT("tx_deferred_frames", txdeferredframes),
+	FXGMAC_STAT("tx_late_collision_frames", txlatecollisionframes),
+	FXGMAC_STAT("tx_excessive_collision_frames",
+		    txexcessivecollisionframes),
+	FXGMAC_STAT("tx_carrier_error_frames", txcarriererrorframes),
+	FXGMAC_STAT("tx_excessive_deferral_error", txexcessivedeferralerror),
+	FXGMAC_STAT("tx_oversize_frames_good", txoversize_g),
+
+	/* MMC RX counters */
+	FXGMAC_STAT("rx_bytes", rxoctetcount_gb),
+	FXGMAC_STAT("rx_bytes_good", rxoctetcount_g),
+	FXGMAC_STAT("rx_packets", rxframecount_gb),
+	FXGMAC_STAT("rx_unicast_packets_good", rxunicastframes_g),
+	FXGMAC_STAT("rx_broadcast_packets_good", rxbroadcastframes_g),
+	FXGMAC_STAT("rx_multicast_packets_good", rxmulticastframes_g),
+	FXGMAC_STAT("rx_vlan_packets_mac", rxvlanframes_gb),
+	FXGMAC_STAT("rx_64_byte_packets", rx64octets_gb),
+	FXGMAC_STAT("rx_65_to_127_byte_packets", rx65to127octets_gb),
+	FXGMAC_STAT("rx_128_to_255_byte_packets", rx128to255octets_gb),
+	FXGMAC_STAT("rx_256_to_511_byte_packets", rx256to511octets_gb),
+	FXGMAC_STAT("rx_512_to_1023_byte_packets", rx512to1023octets_gb),
+	FXGMAC_STAT("rx_1024_to_max_byte_packets", rx1024tomaxoctets_gb),
+	FXGMAC_STAT("rx_undersize_packets_good", rxundersize_g),
+	FXGMAC_STAT("rx_oversize_packets_good", rxoversize_g),
+	FXGMAC_STAT("rx_crc_errors", rxcrcerror),
+	FXGMAC_STAT("rx_align_error", rxalignerror),
+	FXGMAC_STAT("rx_crc_errors_small_packets", rxrunterror),
+	FXGMAC_STAT("rx_crc_errors_giant_packets", rxjabbererror),
+	FXGMAC_STAT("rx_length_errors", rxlengtherror),
+	FXGMAC_STAT("rx_out_of_range_errors", rxoutofrangetype),
+	FXGMAC_STAT("rx_fifo_overflow_errors", rxfifooverflow),
+	FXGMAC_STAT("rx_watchdog_errors", rxwatchdogerror),
+	FXGMAC_STAT("rx_pause_frames", rxpauseframes),
+	FXGMAC_STAT("rx_receive_error_frames", rxreceiveerrorframe),
+	FXGMAC_STAT("rx_control_frames_good", rxcontrolframe_g),
+
+	/* Extra counters */
+	FXGMAC_STAT("tx_tso_packets", tx_tso_packets),
+	FXGMAC_STAT("rx_split_header_packets", rx_split_header_packets),
+	FXGMAC_STAT("tx_process_stopped", tx_process_stopped),
+	FXGMAC_STAT("rx_process_stopped", rx_process_stopped),
+	FXGMAC_STAT("tx_buffer_unavailable", tx_buffer_unavailable),
+	FXGMAC_STAT("rx_buffer_unavailable", rx_buffer_unavailable),
+	FXGMAC_STAT("fatal_bus_error", fatal_bus_error),
+	FXGMAC_STAT("tx_vlan_packets_net", tx_vlan_packets),
+	FXGMAC_STAT("rx_vlan_packets_net", rx_vlan_packets),
+	FXGMAC_STAT("napi_poll_isr", napi_poll_isr),
+	FXGMAC_STAT("napi_poll_txtimer", napi_poll_txtimer),
+	FXGMAC_STAT("alive_cnt_txtimer", cnt_alive_txtimer),
+	FXGMAC_STAT("ephy_poll_timer", ephy_poll_timer_cnt),
+	FXGMAC_STAT("mgmt_int_isr", mgmt_int_isr),
+};
+
+#define FXGMAC_STATS_COUNT ARRAY_SIZE(fxgmac_gstring_stats)
+
+static void fxgmac_ethtool_get_drvinfo(struct net_device *netdev,
+				       struct ethtool_drvinfo *drvinfo)
+{
+	struct fxgmac_pdata *pdata = netdev_priv(netdev);
+	u32 ver = pdata->hw_feat.version;
+	u32 sver, devid, userver;
+
+	strscpy(drvinfo->driver, pdata->drv_name, sizeof(drvinfo->driver));
+	strscpy(drvinfo->version, pdata->drv_ver, sizeof(drvinfo->version));
+	strscpy(drvinfo->bus_info, dev_name(pdata->dev),
+		sizeof(drvinfo->bus_info));
+
+	/* S|SVER: MAC Version
+	 * D|DEVID: Indicates the Device family
+	 * U|USERVER: User-defined Version
+	 */
+	sver = FXGMAC_GET_BITS(ver, MAC_VR_SVER_POS, MAC_VR_SVER_LEN);
+	devid = FXGMAC_GET_BITS(ver, MAC_VR_DEVID_POS, MAC_VR_DEVID_LEN);
+	userver = FXGMAC_GET_BITS(ver, MAC_VR_USERVER_POS, MAC_VR_USERVER_LEN);
+
+	snprintf(drvinfo->fw_version, sizeof(drvinfo->fw_version),
+		 "S.D.U: %x.%x.%x", sver, devid, userver);
+}
+
+static u32 fxgmac_ethtool_get_msglevel(struct net_device *netdev)
+{
+	struct fxgmac_pdata *pdata = netdev_priv(netdev);
+
+	return pdata->msg_enable;
+}
+
+static void fxgmac_ethtool_set_msglevel(struct net_device *netdev, u32 msglevel)
+{
+	struct fxgmac_pdata *pdata = netdev_priv(netdev);
+
+	yt_dbg(pdata, "set msglvl from %08x to %08x\n", pdata->msg_enable,
+	       msglevel);
+	pdata->msg_enable = msglevel;
+}
+
+static void fxgmac_ethtool_get_channels(struct net_device *netdev,
+					struct ethtool_channels *channel)
+{
+	struct fxgmac_pdata *pdata = netdev_priv(netdev);
+
+	/* report maximum channels */
+	channel->max_rx = FXGMAC_MAX_DMA_RX_CHANNELS;
+	channel->max_tx = FXGMAC_MAX_DMA_TX_CHANNELS;
+	channel->max_other = 0;
+	channel->max_combined =
+		channel->max_rx + channel->max_tx + channel->max_other;
+
+	yt_dbg(pdata, "channels max rx:%d, tx:%d, other:%d, combined:%d\n",
+	       channel->max_rx, channel->max_tx, channel->max_other,
+	       channel->max_combined);
+
+	channel->rx_count = pdata->rx_q_count;
+	channel->tx_count = pdata->tx_q_count;
+	channel->other_count = 0;
+	/* record RSS queues */
+	channel->combined_count =
+		channel->rx_count + channel->tx_count + channel->other_count;
+
+	yt_dbg(pdata, "channels count rx:%d, tx:%d, other:%d, combined:%d\n",
+	       channel->rx_count, channel->tx_count, channel->other_count,
+	       channel->combined_count);
+}
+
+static int
+fxgmac_ethtool_get_coalesce(struct net_device *netdev,
+			    struct ethtool_coalesce *ec,
+			    struct kernel_ethtool_coalesce *kernel_coal,
+			    struct netlink_ext_ack *extack)
+
+{
+	struct fxgmac_pdata *pdata = netdev_priv(netdev);
+
+	memset(ec, 0, sizeof(struct ethtool_coalesce));
+	ec->rx_coalesce_usecs = pdata->rx_usecs;
+	ec->tx_coalesce_usecs = pdata->tx_usecs;
+
+	return 0;
+}
+
+#define FXGMAC_MAX_DMA_RIWT 0xff
+#define FXGMAC_MIN_DMA_RIWT 0x01
+
+static int
+fxgmac_ethtool_set_coalesce(struct net_device *netdev,
+			    struct ethtool_coalesce *ec,
+			    struct kernel_ethtool_coalesce *kernel_coal,
+			    struct netlink_ext_ack *extack)
+{
+	struct fxgmac_pdata *pdata = netdev_priv(netdev);
+	struct fxgmac_hw_ops *hw_ops = &pdata->hw_ops;
+	unsigned int rx_frames, rx_riwt, rx_usecs;
+	unsigned int tx_frames;
+
+	/* Check for not supported parameters */
+	if (ec->rx_coalesce_usecs_irq || ec->rx_max_coalesced_frames_irq ||
+	    ec->tx_coalesce_usecs_high || ec->tx_max_coalesced_frames_irq ||
+	    ec->tx_coalesce_usecs_irq || ec->stats_block_coalesce_usecs ||
+	    ec->pkt_rate_low || ec->use_adaptive_rx_coalesce ||
+	    ec->use_adaptive_tx_coalesce || ec->rx_max_coalesced_frames_low ||
+	    ec->rx_coalesce_usecs_low || ec->tx_coalesce_usecs_low ||
+	    ec->tx_max_coalesced_frames_low || ec->pkt_rate_high ||
+	    ec->rx_coalesce_usecs_high || ec->rx_max_coalesced_frames_high ||
+	    ec->tx_max_coalesced_frames_high || ec->rate_sample_interval)
+		return -EOPNOTSUPP;
+
+	rx_usecs = ec->rx_coalesce_usecs;
+	rx_riwt = hw_ops->usec_to_riwt(pdata, rx_usecs);
+	rx_frames = ec->rx_max_coalesced_frames;
+	tx_frames = ec->tx_max_coalesced_frames;
+
+	if (rx_riwt > FXGMAC_MAX_DMA_RIWT || rx_riwt < FXGMAC_MIN_DMA_RIWT ||
+	    rx_frames > pdata->rx_desc_count)
+		return -EINVAL;
+
+	if (tx_frames > pdata->tx_desc_count)
+		return -EINVAL;
+
+	pdata->rx_usecs = rx_usecs;
+	pdata->rx_frames = rx_frames;
+	pdata->rx_riwt = rx_riwt;
+	hw_ops->config_rx_coalesce(pdata);
+
+	pdata->tx_frames = tx_frames;
+	pdata->tx_usecs = ec->tx_coalesce_usecs;
+	hw_ops->set_interrupt_moderation(pdata);
+
+	return 0;
+}
+
+static u32 fxgmac_get_rxfh_key_size(struct net_device *netdev)
+{
+	return FXGMAC_RSS_HASH_KEY_SIZE;
+}
+
+static u32 fxgmac_rss_indir_size(struct net_device *netdev)
+{
+	return FXGMAC_RSS_MAX_TABLE_SIZE;
+}
+
+static void fxgmac_get_reta(struct fxgmac_pdata *pdata, u32 *indir)
+{
+	int reta_size = FXGMAC_RSS_MAX_TABLE_SIZE;
+	u16 rss_m = FXGMAC_MAX_DMA_RX_CHANNELS - 1;
+
+	for (u32 i = 0; i < reta_size; i++)
+		indir[i] = pdata->rss_table[i] & rss_m;
+}
+
+static int fxgmac_get_rxfh(struct net_device *netdev,
+			   struct ethtool_rxfh_param *rxfh)
+{
+	struct fxgmac_pdata *pdata = netdev_priv(netdev);
+
+	if (rxfh->hfunc) {
+		rxfh->hfunc = ETH_RSS_HASH_TOP;
+		yt_dbg(pdata, "%s, hash function\n", __func__);
+	}
+
+	if (rxfh->indir) {
+		fxgmac_get_reta(pdata, rxfh->indir);
+		yt_dbg(pdata, "%s, indirection tab\n", __func__);
+	}
+
+	if (rxfh->key) {
+		memcpy(rxfh->key, pdata->rss_key,
+		       fxgmac_get_rxfh_key_size(netdev));
+		yt_dbg(pdata, "%s, hash key\n", __func__);
+	}
+
+	return 0;
+}
+
+static int fxgmac_set_rxfh(struct net_device *netdev,
+			   struct ethtool_rxfh_param *rxfh,
+			   struct netlink_ext_ack *ack)
+{
+	u32 i, reta_entries = fxgmac_rss_indir_size(netdev);
+	struct fxgmac_pdata *pdata = netdev_priv(netdev);
+	struct fxgmac_hw_ops *hw_ops = &pdata->hw_ops;
+
+	yt_dbg(pdata, "%s, indir=%lx, key=%lx, func=%02x\n", __func__,
+	       (unsigned long)rxfh->indir, (unsigned long)rxfh->key,
+	       rxfh->hfunc);
+
+	if (rxfh->hfunc)
+		return -EINVAL;
+
+	/* Fill out the redirection table */
+	if (rxfh->indir) {
+		/* double check user input. */
+		for (i = 0; i < reta_entries; i++)
+			if (rxfh->indir[i] >= FXGMAC_MAX_DMA_RX_CHANNELS)
+				return -EINVAL;
+
+		for (i = 0; i < reta_entries; i++)
+			pdata->rss_table[i] = rxfh->indir[i];
+
+		hw_ops->write_rss_lookup_table(pdata);
+	}
+
+	/* Fill out the rss hash key */
+	if (rxfh->key)
+		hw_ops->set_rss_hash_key(pdata, rxfh->key);
+
+	return 0;
+}
+
+static int fxgmac_get_rss_hash_opts(struct fxgmac_pdata *pdata,
+				    struct ethtool_rxnfc *cmd)
+{
+	struct fxgmac_hw_ops *hw_ops = &pdata->hw_ops;
+	u32 reg_opt;
+
+	cmd->data = 0;
+	reg_opt = hw_ops->get_rss_options(pdata);
+	yt_dbg(pdata, "%s, hw=%02x, %02x\n", __func__, reg_opt,
+	       pdata->rss_options);
+
+	if (reg_opt != pdata->rss_options)
+		yt_dbg(pdata, "warning, options are not consistent\n");
+
+	/* Report default options for RSS */
+	switch (cmd->flow_type) {
+	case TCP_V4_FLOW:
+	case UDP_V4_FLOW:
+		if ((cmd->flow_type == TCP_V4_FLOW &&
+		     (pdata->rss_options & FXGMAC_RSS_TCP4TE)) ||
+		    (cmd->flow_type == UDP_V4_FLOW &&
+		     (pdata->rss_options & FXGMAC_RSS_UDP4TE))) {
+			cmd->data |= RXH_L4_B_0_1 | RXH_L4_B_2_3;
+		}
+		fallthrough;
+	case SCTP_V4_FLOW:
+	case AH_ESP_V4_FLOW:
+	case AH_V4_FLOW:
+	case ESP_V4_FLOW:
+	case IPV4_FLOW:
+		if ((cmd->flow_type == TCP_V4_FLOW &&
+		     (pdata->rss_options & FXGMAC_RSS_TCP4TE)) ||
+		    (cmd->flow_type == UDP_V4_FLOW &&
+		     (pdata->rss_options & FXGMAC_RSS_UDP4TE)) ||
+		    (pdata->rss_options & BIT(FXGMAC_RSS_IP4TE))) {
+			cmd->data |= RXH_IP_SRC | RXH_IP_DST;
+		}
+		break;
+	case TCP_V6_FLOW:
+	case UDP_V6_FLOW:
+		if ((cmd->flow_type == TCP_V6_FLOW &&
+		     (pdata->rss_options & FXGMAC_RSS_TCP6TE)) ||
+		    (cmd->flow_type == UDP_V6_FLOW &&
+		     (pdata->rss_options & FXGMAC_RSS_UDP6TE))) {
+			cmd->data |= RXH_L4_B_0_1 | RXH_L4_B_2_3;
+		}
+		fallthrough;
+	case SCTP_V6_FLOW:
+	case AH_ESP_V6_FLOW:
+	case AH_V6_FLOW:
+	case ESP_V6_FLOW:
+	case IPV6_FLOW:
+		if ((cmd->flow_type == TCP_V6_FLOW &&
+		     (pdata->rss_options & FXGMAC_RSS_TCP6TE)) ||
+		    (cmd->flow_type == UDP_V6_FLOW &&
+		     (pdata->rss_options & FXGMAC_RSS_UDP6TE)) ||
+		    (pdata->rss_options & FXGMAC_RSS_IP6TE)) {
+			cmd->data |= RXH_IP_SRC | RXH_IP_DST;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int fxgmac_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
+			    u32 *rule_locs)
+{
+	struct fxgmac_pdata *pdata = netdev_priv(dev);
+	int ret = 0;
+
+	switch (cmd->cmd) {
+	case ETHTOOL_GRXRINGS:
+		cmd->data = pdata->rx_q_count;
+		yt_dbg(pdata, "%s, rx ring cnt\n", __func__);
+		break;
+	case ETHTOOL_GRXCLSRLCNT:
+		cmd->rule_cnt = 0;
+		yt_dbg(pdata, "%s, classify rule cnt\n", __func__);
+		break;
+	case ETHTOOL_GRXCLSRULE:
+		yt_dbg(pdata, "%s, classify rules\n", __func__);
+		break;
+	case ETHTOOL_GRXCLSRLALL:
+		cmd->rule_cnt = 0;
+		yt_dbg(pdata, "%s, classify both cnt and rules\n", __func__);
+		break;
+	case ETHTOOL_GRXFH:
+		ret = fxgmac_get_rss_hash_opts(pdata, cmd);
+		yt_dbg(pdata, "%s, hash options\n", __func__);
+		break;
+	default:
+		ret = -EOPNOTSUPP;
+		break;
+	}
+
+	return ret;
+}
+
+#define UDP_RSS_FLAGS (FXGMAC_RSS_UDP4TE | FXGMAC_RSS_UDP6TE)
+
+static int fxgmac_set_rss_hash_opt(struct fxgmac_pdata *pdata,
+				   struct ethtool_rxnfc *nfc)
+{
+	struct fxgmac_hw_ops *hw_ops = &pdata->hw_ops;
+	__u64 data = nfc->data;
+	u32 rssopt = 0;
+
+	yt_dbg(pdata, "%s nfc_data=%llx,cur opt=%x\n", __func__, data,
+	       pdata->rss_options);
+
+	/* For RSS, it does not support anything other than hashing
+	 * to queues on src,dst IPs and L4 ports
+	 */
+	if (data & ~(RXH_IP_SRC | RXH_IP_DST | RXH_L4_B_0_1 | RXH_L4_B_2_3))
+		return -EINVAL;
+
+	switch (nfc->flow_type) {
+	case TCP_V4_FLOW:
+	case TCP_V6_FLOW:
+		/* default to TCP flow and do nothting */
+		if (!(data &
+		      (RXH_IP_SRC | RXH_IP_DST | RXH_L4_B_0_1 | RXH_L4_B_2_3)))
+			return -EINVAL;
+		if (nfc->flow_type == TCP_V4_FLOW)
+			rssopt |= BIT(FXGMAC_RSS_IP4TE) | FXGMAC_RSS_TCP4TE;
+		if (nfc->flow_type == TCP_V6_FLOW)
+			rssopt |= FXGMAC_RSS_IP6TE | FXGMAC_RSS_TCP6TE;
+		break;
+	case UDP_V4_FLOW:
+		if (!(data & (RXH_IP_SRC | RXH_IP_DST)))
+			return -EINVAL;
+		rssopt |= BIT(FXGMAC_RSS_IP4TE);
+		switch (data & (RXH_L4_B_0_1 | RXH_L4_B_2_3)) {
+		case 0:
+			break;
+		case (RXH_L4_B_0_1 | RXH_L4_B_2_3):
+			rssopt |= FXGMAC_RSS_UDP4TE;
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+	case UDP_V6_FLOW:
+		if (!(data & (RXH_IP_SRC | RXH_IP_DST)))
+			return -EINVAL;
+		rssopt |= FXGMAC_RSS_IP6TE;
+
+		switch (data & (RXH_L4_B_0_1 | RXH_L4_B_2_3)) {
+		case 0:
+			break;
+		case (RXH_L4_B_0_1 | RXH_L4_B_2_3):
+			rssopt |= FXGMAC_RSS_UDP6TE;
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+	case AH_ESP_V4_FLOW:
+	case AH_V4_FLOW:
+	case ESP_V4_FLOW:
+	case SCTP_V4_FLOW:
+	case AH_ESP_V6_FLOW:
+	case AH_V6_FLOW:
+	case ESP_V6_FLOW:
+	case SCTP_V6_FLOW:
+		if (!(data &
+		      (RXH_IP_SRC | RXH_IP_DST | RXH_L4_B_0_1 | RXH_L4_B_2_3)))
+			return -EINVAL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* if options are changed, then update to hw */
+	if (rssopt != pdata->rss_options) {
+		if ((rssopt & UDP_RSS_FLAGS) &&
+		    !(pdata->rss_options & UDP_RSS_FLAGS))
+			yt_dbg(pdata,
+			       "enabling UDP RSS: fragmented packets may arrive out of order to the stack above.");
+
+		yt_dbg(pdata, "rss option changed from %x to %x\n",
+		       pdata->rss_options, rssopt);
+		pdata->rss_options = rssopt;
+		hw_ops->set_rss_options(pdata);
+	}
+
+	return 0;
+}
+
+static int fxgmac_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd)
+{
+	struct fxgmac_pdata *pdata = netdev_priv(dev);
+	int ret = -EOPNOTSUPP;
+
+	switch (cmd->cmd) {
+	case ETHTOOL_SRXCLSRLINS:
+		yt_dbg(pdata, "%s, rx cls rule insert-n\\a\n", __func__);
+		break;
+	case ETHTOOL_SRXCLSRLDEL:
+		yt_dbg(pdata, "%s, rx cls rule del-n\\a\n", __func__);
+		break;
+	case ETHTOOL_SRXFH:
+		yt_dbg(pdata, "%s, rx rss option\n", __func__);
+		ret = fxgmac_set_rss_hash_opt(pdata, cmd);
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+static void fxgmac_get_ringparam(struct net_device *netdev,
+				 struct ethtool_ringparam *ring,
+				 struct kernel_ethtool_ringparam *kernel_ring,
+				 struct netlink_ext_ack *exact)
+{
+	struct fxgmac_pdata *pdata = netdev_priv(netdev);
+
+	ring->rx_max_pending = FXGMAC_RX_DESC_CNT;
+	ring->tx_max_pending = FXGMAC_TX_DESC_CNT;
+	ring->rx_mini_max_pending = 0;
+	ring->rx_jumbo_max_pending = 0;
+	ring->rx_pending = pdata->rx_desc_count;
+	ring->tx_pending = pdata->tx_desc_count;
+	ring->rx_mini_pending = 0;
+	ring->rx_jumbo_pending = 0;
+}
+
+static int fxgmac_set_ringparam(struct net_device *netdev,
+				struct ethtool_ringparam *ring,
+				struct kernel_ethtool_ringparam *kernel_ring,
+				struct netlink_ext_ack *exact)
+
+{
+	struct fxgmac_pdata *pdata = netdev_priv(netdev);
+	int ret;
+
+	if (pdata->dev_state != FXGMAC_DEV_START)
+		return 0;
+
+	fxgmac_lock(pdata);
+	pdata->tx_desc_count = ring->tx_pending;
+	pdata->rx_desc_count = ring->rx_pending;
+
+	fxgmac_stop(pdata);
+	fxgmac_free_tx_data(pdata);
+	fxgmac_free_rx_data(pdata);
+	ret = fxgmac_channels_rings_alloc(pdata);
+	if (ret < 0)
+		goto unlock;
+
+	ret = fxgmac_start(pdata);
+	if (ret < 0)
+		goto unlock;
+
+	fxgmac_unlock(pdata);
+
+	return 0;
+unlock:
+	fxgmac_unlock(pdata);
+
+	return ret;
+}
+
+static void fxgmac_get_wol(struct net_device *netdev,
+			   struct ethtool_wolinfo *wol)
+{
+	struct fxgmac_pdata *pdata = netdev_priv(netdev);
+
+	wol->supported = WAKE_UCAST | WAKE_MCAST | WAKE_BCAST | WAKE_MAGIC |
+			 WAKE_ARP | WAKE_PHY;
+
+	wol->wolopts = 0;
+	if (!(pdata->hw_feat.rwk) || !device_can_wakeup(pdata->dev)) {
+		yt_err(pdata, "%s, pci does not support wakeup.\n", __func__);
+		return;
+	}
+
+	wol->wolopts = pdata->wol;
+}
+
+static int fxgmac_set_pattern_data(struct fxgmac_pdata *pdata)
+{
+	struct fxgmac_hw_ops *hw_ops = &pdata->hw_ops;
+	u8 type_offset, tip_offset, op_offset;
+	struct wol_bitmap_pattern pattern[4];
+	struct pattern_packet packet;
+	u32 ip_addr, i = 0;
+
+	memset(pattern, 0, sizeof(struct wol_bitmap_pattern) * 4);
+
+	/* config ucast */
+	if (pdata->wol & WAKE_UCAST) {
+		pattern[i].mask_info[0] = 0x3F;
+		pattern[i].mask_size = sizeof(pattern[0].mask_info);
+		memcpy(pattern[i].pattern_info, pdata->mac_addr, ETH_ALEN);
+		pattern[i].pattern_offset = 0;
+		i++;
+	}
+
+	/* config bcast */
+	if (pdata->wol & WAKE_BCAST) {
+		pattern[i].mask_info[0] = 0x3F;
+		pattern[i].mask_size = sizeof(pattern[0].mask_info);
+		memset(pattern[i].pattern_info, 0xFF, ETH_ALEN);
+		pattern[i].pattern_offset = 0;
+		i++;
+	}
+
+	/* config mcast */
+	if (pdata->wol & WAKE_MCAST) {
+		pattern[i].mask_info[0] = 0x7;
+		pattern[i].mask_size = sizeof(pattern[0].mask_info);
+		pattern[i].pattern_info[0] = 0x1;
+		pattern[i].pattern_info[1] = 0x0;
+		pattern[i].pattern_info[2] = 0x5E;
+		pattern[i].pattern_offset = 0;
+		i++;
+	}
+
+	/* config arp */
+	if (pdata->wol & WAKE_ARP) {
+		memset(pattern[i].mask_info, 0, sizeof(pattern[0].mask_info));
+		type_offset = offsetof(struct pattern_packet, ar_pro);
+		pattern[i].mask_info[type_offset / 8] |= 1 << type_offset % 8;
+		type_offset++;
+		pattern[i].mask_info[type_offset / 8] |= 1 << type_offset % 8;
+		op_offset = offsetof(struct pattern_packet, ar_op);
+		pattern[i].mask_info[op_offset / 8] |= 1 << op_offset % 8;
+		op_offset++;
+		pattern[i].mask_info[op_offset / 8] |= 1 << op_offset % 8;
+		tip_offset = offsetof(struct pattern_packet, ar_tip);
+		pattern[i].mask_info[tip_offset / 8] |= 1 << tip_offset % 8;
+		tip_offset++;
+		pattern[i].mask_info[tip_offset / 8] |= 1 << type_offset % 8;
+		tip_offset++;
+		pattern[i].mask_info[tip_offset / 8] |= 1 << type_offset % 8;
+		tip_offset++;
+		pattern[i].mask_info[tip_offset / 8] |= 1 << type_offset % 8;
+
+		packet.ar_pro = 0x0 << 8 | 0x08;
+		/* arp type is 0x0800, notice that ar_pro and ar_op is
+		 * big endian
+		 */
+		packet.ar_op = 0x1 << 8;
+		/* 1 is arp request,2 is arp replay, 3 is rarp request,
+		 * 4 is rarp replay
+		 */
+		ip_addr = fxgmac_get_netdev_ip4addr(pdata);
+		packet.ar_tip[0] = ip_addr & 0xFF;
+		packet.ar_tip[1] = (ip_addr >> 8) & 0xFF;
+		packet.ar_tip[2] = (ip_addr >> 16) & 0xFF;
+		packet.ar_tip[3] = (ip_addr >> 24) & 0xFF;
+		memcpy(pattern[i].pattern_info, &packet, MAX_PATTERN_SIZE);
+		pattern[i].mask_size = sizeof(pattern[0].mask_info);
+		pattern[i].pattern_offset = 0;
+		i++;
+	}
+
+	return hw_ops->set_wake_pattern(pdata, pattern, i);
+}
+
+int fxgmac_config_wol(struct fxgmac_pdata *pdata, int en)
+{
+	struct fxgmac_hw_ops *hw_ops = &pdata->hw_ops;
+
+	if (!pdata->hw_feat.rwk) {
+		yt_err(pdata, "error configuring WOL - not supported.\n");
+		return -EOPNOTSUPP;
+	}
+
+	hw_ops->disable_wake_magic_pattern(pdata);
+	hw_ops->disable_wake_pattern(pdata);
+	hw_ops->disable_wake_link_change(pdata);
+
+	if (en) {
+		/* config mac address for rx of magic or ucast */
+		hw_ops->set_mac_address(pdata, (u8 *)(pdata->netdev->dev_addr));
+
+		/* Enable Magic packet */
+		if (pdata->wol & WAKE_MAGIC)
+			hw_ops->enable_wake_magic_pattern(pdata);
+
+		/* Enable global unicast packet */
+		if (pdata->wol &
+		    (WAKE_UCAST | WAKE_MCAST | WAKE_BCAST | WAKE_ARP))
+			hw_ops->enable_wake_pattern(pdata);
+
+		/* Enable ephy link change */
+		if (pdata->wol & WAKE_PHY)
+			hw_ops->enable_wake_link_change(pdata);
+	}
+	device_set_wakeup_enable((pdata->dev), en);
+
+	return 0;
+}
+
+static int fxgmac_set_wol(struct net_device *netdev,
+			  struct ethtool_wolinfo *wol)
+{
+	struct fxgmac_pdata *pdata = netdev_priv(netdev);
+	int ret;
+
+	if (wol->wolopts & (WAKE_MAGICSECURE | WAKE_FILTER)) {
+		yt_err(pdata, "%s, not supported wol options, 0x%x\n", __func__,
+		       wol->wolopts);
+		return -EOPNOTSUPP;
+	}
+
+	if (!(pdata->hw_feat.rwk)) {
+		yt_err(pdata, "%s, hw wol feature is n/a\n", __func__);
+		return wol->wolopts ? -EOPNOTSUPP : 0;
+	}
+
+	pdata->wol = 0;
+	if (wol->wolopts & WAKE_UCAST)
+		pdata->wol |= WAKE_UCAST;
+
+	if (wol->wolopts & WAKE_MCAST)
+		pdata->wol |= WAKE_MCAST;
+
+	if (wol->wolopts & WAKE_BCAST)
+		pdata->wol |= WAKE_BCAST;
+
+	if (wol->wolopts & WAKE_MAGIC)
+		pdata->wol |= WAKE_MAGIC;
+
+	if (wol->wolopts & WAKE_PHY)
+		pdata->wol |= WAKE_PHY;
+
+	if (wol->wolopts & WAKE_ARP)
+		pdata->wol |= WAKE_ARP;
+
+	ret = fxgmac_set_pattern_data(pdata);
+	if (ret < 0)
+		return ret;
+
+	ret = fxgmac_config_wol(pdata, (!!(pdata->wol)));
+	yt_dbg(pdata, "%s, opt=0x%x, wol=0x%x\n", __func__, wol->wolopts,
+	       pdata->wol);
+
+	return ret;
+}
+
+static int fxgmac_get_regs_len(struct net_device __always_unused *netdev)
+{
+	return FXGMAC_PHY_REG_CNT * sizeof(u32);
+}
+
+static void fxgmac_get_regs(struct net_device *netdev,
+			    struct ethtool_regs *regs, void *p)
+{
+	struct fxgmac_pdata *pdata = netdev_priv(netdev);
+	u32 *regs_buff = p;
+
+	memset(p, 0, FXGMAC_PHY_REG_CNT * sizeof(u32));
+	for (u32 i = MII_BMCR; i < FXGMAC_PHY_REG_CNT; i++)
+		fxgmac_phy_read_reg(pdata, i, (unsigned int *)&regs_buff[i]);
+
+	regs->version = regs_buff[MII_PHYSID1] << 16 | regs_buff[MII_PHYSID2];
+}
+
+static int fxgmac_get_link_ksettings(struct net_device *netdev,
+				     struct ethtool_link_ksettings *cmd)
+{
+	struct fxgmac_pdata *pdata = netdev_priv(netdev);
+	u32 duplex, val, adv = ~0;
+	int ret;
+
+	ethtool_link_ksettings_zero_link_mode(cmd, supported);
+	ethtool_link_ksettings_zero_link_mode(cmd, advertising);
+
+	/* set the supported link speeds */
+	ethtool_link_ksettings_add_link_mode(cmd, supported, 1000baseT_Full);
+	ethtool_link_ksettings_add_link_mode(cmd, supported, 100baseT_Full);
+	ethtool_link_ksettings_add_link_mode(cmd, supported, 100baseT_Half);
+	ethtool_link_ksettings_add_link_mode(cmd, supported, 10baseT_Full);
+	ethtool_link_ksettings_add_link_mode(cmd, supported, 10baseT_Half);
+
+	/* Indicate pause support */
+	ethtool_link_ksettings_add_link_mode(cmd, supported, Pause);
+	ethtool_link_ksettings_add_link_mode(cmd, supported, Asym_Pause);
+
+	ret = fxgmac_phy_read_reg(pdata, MII_ADVERTISE, &val);
+	if (ret < 0)
+		return ret;
+
+	if (val & ADVERTISE_PAUSE_CAP)
+		ethtool_link_ksettings_add_link_mode(cmd, advertising, Pause);
+
+	if (val & ADVERTISE_PAUSE_ASYM)
+		ethtool_link_ksettings_add_link_mode(cmd, advertising,
+						     Asym_Pause);
+
+	set_bit(ETHTOOL_LINK_MODE_MII_BIT, cmd->link_modes.supported);
+	cmd->base.port = PORT_MII;
+	ethtool_link_ksettings_add_link_mode(cmd, supported, MII);
+
+	ret = fxgmac_phy_read_reg(pdata, MII_BMCR, &val);
+	if (ret < 0)
+		return ret;
+
+	if (val & BMCR_ANENABLE) {
+		if (pdata->phy_autoeng)
+			ethtool_link_ksettings_add_link_mode(cmd, advertising,
+							     Autoneg);
+		else
+			clear_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
+				  cmd->link_modes.advertising);
+
+		ret = fxgmac_phy_read_reg(pdata, MII_ADVERTISE, &adv);
+		if (ret < 0)
+			return ret;
+
+		if (adv & ADVERTISE_10HALF)
+			ethtool_link_ksettings_add_link_mode(cmd, advertising,
+							     10baseT_Half);
+		if (adv & ADVERTISE_10FULL)
+			ethtool_link_ksettings_add_link_mode(cmd, advertising,
+							     10baseT_Full);
+		if (adv & ADVERTISE_100HALF)
+			ethtool_link_ksettings_add_link_mode(cmd, advertising,
+							     100baseT_Half);
+		if (adv & ADVERTISE_100FULL)
+			ethtool_link_ksettings_add_link_mode(cmd, advertising,
+							     100baseT_Full);
+
+		ret = fxgmac_phy_read_reg(pdata, MII_CTRL1000, &adv);
+		if (ret < 0)
+			return ret;
+
+		if (adv & ADVERTISE_1000FULL)
+			ethtool_link_ksettings_add_link_mode(cmd, advertising,
+							     1000baseT_Full);
+	} else {
+		clear_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
+			  cmd->link_modes.advertising);
+		switch (pdata->phy_speed) {
+		case SPEED_1000:
+			if (pdata->phy_duplex)
+				ethtool_link_ksettings_add_link_mode(
+					cmd, advertising, 1000baseT_Full);
+			else
+				ethtool_link_ksettings_add_link_mode(
+					cmd, advertising, 1000baseT_Half);
+
+			break;
+		case SPEED_100:
+			if (pdata->phy_duplex)
+				ethtool_link_ksettings_add_link_mode(
+					cmd, advertising, 100baseT_Full);
+			else
+				ethtool_link_ksettings_add_link_mode(
+					cmd, advertising, 100baseT_Half);
+
+			break;
+		case SPEED_10:
+			if (pdata->phy_duplex)
+				ethtool_link_ksettings_add_link_mode(
+					cmd, advertising, 10baseT_Full);
+			else
+				ethtool_link_ksettings_add_link_mode(
+					cmd, advertising, 10baseT_Half);
+
+			break;
+		default:
+			break;
+		}
+	}
+	cmd->base.autoneg = pdata->phy_autoeng ? val : 0;
+
+	ret = fxgmac_phy_read_reg(pdata, PHY_SPEC_STATUS, &val);
+	if (ret < 0)
+		return ret;
+
+	if (val & PHY_SPEC_STATUS_LINK) {
+		duplex = !!(val & PHY_SPEC_STATUS_DUPLEX);
+		cmd->base.duplex = duplex;
+		cmd->base.speed = pdata->phy_speed;
+	} else {
+		cmd->base.duplex = DUPLEX_UNKNOWN;
+		cmd->base.speed = SPEED_UNKNOWN;
+	}
+
+	return 0;
+}
+
+static int fxgmac_set_link_ksettings(struct net_device *netdev,
+				     const struct ethtool_link_ksettings *cmd)
+{
+	struct fxgmac_pdata *pdata = netdev_priv(netdev);
+	u32 advertising, support;
+	int ret;
+
+	if (cmd->base.speed == SPEED_1000 && cmd->base.duplex == DUPLEX_HALF)
+		return -EINVAL;
+
+	pdata->phy_autoeng = cmd->base.autoneg;
+	ethtool_convert_link_mode_to_legacy_u32(&advertising,
+						cmd->link_modes.advertising);
+	ethtool_convert_link_mode_to_legacy_u32(&support,
+						cmd->link_modes.supported);
+	advertising &= support;
+
+	if (pdata->phy_autoeng || cmd->base.speed == SPEED_1000) {
+		ret = fxgmac_phy_modify_reg(pdata, MII_ADVERTISE,
+					    FXGMAC_ADVERTISE_100_10_CAP,
+					    ethtool_adv_to_mii_adv_t(advertising));
+		if (ret < 0)
+			return ret;
+
+		ret = fxgmac_phy_modify_reg(pdata, MII_CTRL1000,
+					    FXGMAC_ADVERTISE_1000_CAP,
+					    ethtool_adv_to_mii_ctrl1000_t(advertising));
+		if (ret < 0)
+			return ret;
+
+		ret = fxgmac_phy_modify_reg(pdata, MII_BMCR, BMCR_ANENABLE,
+					    BMCR_ANENABLE);
+		if (ret < 0)
+			return ret;
+
+		ret = fxgmac_phy_modify_reg(pdata, MII_BMCR, BMCR_ANRESTART,
+					    BMCR_ANRESTART);
+		if (ret < 0)
+			return ret;
+	} else {
+		pdata->phy_duplex = cmd->base.duplex;
+		pdata->phy_speed = cmd->base.speed;
+		ret = fxgmac_phy_force_mode(pdata);
+		if (ret < 0)
+			return ret;
+	}
+
+	/* Save speed is used to restore it when resuming */
+	pdata->pre_phy_speed = cmd->base.speed;
+	pdata->pre_phy_autoneg = cmd->base.autoneg;
+	pdata->pre_phy_duplex = cmd->base.duplex;
+
+	return 0;
+}
+
+static void fxgmac_get_pauseparam(struct net_device *netdev,
+				  struct ethtool_pauseparam *pause)
+{
+	struct fxgmac_pdata *pdata = netdev_priv(netdev);
+
+	pause->autoneg = pdata->phy_autoeng;
+	pause->rx_pause = pdata->rx_pause;
+	pause->tx_pause = pdata->tx_pause;
+
+	yt_dbg(pdata, "%s, rx=%d, tx=%d\n", __func__, pdata->rx_pause,
+	       pdata->tx_pause);
+}
+
+static int fxgmac_set_pauseparam(struct net_device *netdev,
+				 struct ethtool_pauseparam *pause)
+{
+	struct fxgmac_pdata *pdata = netdev_priv(netdev);
+	struct fxgmac_hw_ops *hw_ops = &pdata->hw_ops;
+	unsigned int pre_rx_pause = pdata->rx_pause;
+	unsigned int pre_tx_pause = pdata->tx_pause;
+	int enable_pause = 0;
+	u32 adv = 0;
+
+	pdata->rx_pause = pause->rx_pause;
+	pdata->tx_pause = pause->tx_pause;
+
+	if (pdata->rx_pause || pdata->tx_pause)
+		enable_pause = 1;
+
+	if (pre_rx_pause != pdata->rx_pause) {
+		hw_ops->config_rx_flow_control(pdata);
+		yt_dbg(pdata, "%s, rx from %d to %d\n", __func__, pre_rx_pause,
+		       pdata->rx_pause);
+	}
+	if (pre_tx_pause != pdata->tx_pause) {
+		hw_ops->config_tx_flow_control(pdata);
+		yt_dbg(pdata, "%s, tx from %d to %d\n", __func__, pre_tx_pause,
+		       pdata->tx_pause);
+	}
+
+	if (pause->autoneg) {
+		if (enable_pause)
+			adv |= ADVERTISE_PAUSE_CAP | ADVERTISE_PAUSE_ASYM;
+
+		if (fxgmac_phy_modify_reg(pdata, MII_ADVERTISE,
+					  ADVERTISE_PAUSE_CAP |
+						  ADVERTISE_PAUSE_ASYM,
+					  adv) < 0)
+			return -ETIMEDOUT;
+
+		if (fxgmac_phy_modify_reg(pdata, MII_BMCR, BMCR_ANRESTART,
+					  BMCR_ANRESTART) < 0)
+			return -ETIMEDOUT;
+	} else {
+		yt_dbg(pdata, "Can't set phy pause because autoneg is off.\n");
+	}
+
+	yt_dbg(pdata, "%s, autoneg=%d, rx=%d, tx=%d\n", __func__,
+	       pause->autoneg, pause->rx_pause, pause->tx_pause);
+
+	return 0;
+}
+
+static void fxgmac_ethtool_get_strings(struct net_device *netdev, u32 stringset,
+				       u8 *data)
+{
+	switch (stringset) {
+	case ETH_SS_STATS:
+		for (u32 i = 0; i < FXGMAC_STATS_COUNT; i++) {
+			memcpy(data, fxgmac_gstring_stats[i].stat_string,
+			       strlen(fxgmac_gstring_stats[i].stat_string));
+			data += ETH_GSTRING_LEN;
+		}
+		break;
+	default:
+		WARN_ON(1);
+		break;
+	}
+}
+
+static int fxgmac_ethtool_get_sset_count(struct net_device *netdev,
+					 int stringset)
+{
+	int ret;
+
+	switch (stringset) {
+	case ETH_SS_STATS:
+		ret = FXGMAC_STATS_COUNT;
+		break;
+
+	default:
+		ret = -EOPNOTSUPP;
+	}
+
+	return ret;
+}
+
+static void fxgmac_ethtool_get_ethtool_stats(struct net_device *netdev,
+					     struct ethtool_stats *stats,
+					     u64 *data)
+{
+	struct fxgmac_pdata *pdata = netdev_priv(netdev);
+
+	if (!test_bit(FXGMAC_POWER_STATE_DOWN, &pdata->powerstate))
+		pdata->hw_ops.read_mmc_stats(pdata);
+
+	for (u32 i = 0; i < FXGMAC_STATS_COUNT; i++)
+		*data++ = *(u64 *)((u8 *)pdata +
+				   fxgmac_gstring_stats[i].stat_offset);
+}
+
+static int fxgmac_ethtool_reset(struct net_device *netdev, u32 *flag)
+{
+	struct fxgmac_pdata *pdata = netdev_priv(netdev);
+	int ret = 0;
+	u32 val;
+
+	val = *flag & (ETH_RESET_ALL | ETH_RESET_PHY);
+	if (!val) {
+		yt_err(pdata, "Operation not support.\n");
+		return -EOPNOTSUPP;
+	}
+
+	switch (*flag) {
+	case ETH_RESET_ALL:
+		fxgmac_restart(pdata);
+		*flag = 0;
+		break;
+	case ETH_RESET_PHY:
+		/* power off and on the phy in order to properly
+		 * configure the MAC timing
+		 */
+		ret = fxgmac_phy_modify_reg(pdata, MII_BMCR, BMCR_PDOWN,
+					    BMCR_PDOWN);
+		if (ret < 0)
+			return ret;
+		usleep_range(9000, 10000);
+
+		ret = fxgmac_phy_modify_reg(pdata, MII_BMCR, BMCR_PDOWN, 0);
+		if (ret < 0)
+			return ret;
+		*flag = 0;
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static const struct ethtool_ops fxgmac_ethtool_ops = {
+	.get_drvinfo			= fxgmac_ethtool_get_drvinfo,
+	.get_link			= ethtool_op_get_link,
+	.get_msglevel			= fxgmac_ethtool_get_msglevel,
+	.set_msglevel			= fxgmac_ethtool_set_msglevel,
+	.get_channels			= fxgmac_ethtool_get_channels,
+	.get_coalesce			= fxgmac_ethtool_get_coalesce,
+	.set_coalesce			= fxgmac_ethtool_set_coalesce,
+	.reset				= fxgmac_ethtool_reset,
+	.supported_coalesce_params	= ETHTOOL_COALESCE_USECS,
+	.get_strings			= fxgmac_ethtool_get_strings,
+	.get_sset_count			= fxgmac_ethtool_get_sset_count,
+	.get_ethtool_stats		= fxgmac_ethtool_get_ethtool_stats,
+	.get_regs_len			= fxgmac_get_regs_len,
+	.get_regs			= fxgmac_get_regs,
+	.get_ringparam			= fxgmac_get_ringparam,
+	.set_ringparam			= fxgmac_set_ringparam,
+	.get_rxnfc			= fxgmac_get_rxnfc,
+	.set_rxnfc			= fxgmac_set_rxnfc,
+	.get_rxfh_indir_size		= fxgmac_rss_indir_size,
+	.get_rxfh_key_size		= fxgmac_get_rxfh_key_size,
+	.get_rxfh			= fxgmac_get_rxfh,
+	.set_rxfh			= fxgmac_set_rxfh,
+	.get_wol			= fxgmac_get_wol,
+	.set_wol			= fxgmac_set_wol,
+	.get_link_ksettings		= fxgmac_get_link_ksettings,
+	.set_link_ksettings		= fxgmac_set_link_ksettings,
+	.get_pauseparam			= fxgmac_get_pauseparam,
+	.set_pauseparam			= fxgmac_set_pauseparam,
+};
+
+const struct ethtool_ops *fxgmac_get_ethtool_ops(void)
+{
+	return &fxgmac_ethtool_ops;
+}
diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_hw.c b/drivers/net/ethernet/motorcomm/yt6801/yt6801_hw.c
new file mode 100644
index 0000000..3ca2f1a
--- /dev/null
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_hw.c
@@ -0,0 +1,3344 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (c) 2022 - 2024 Motorcomm Electronic Technology Co.,Ltd. */
+
+#include "yt6801_type.h"
+#include "yt6801_desc.h"
+#include "yt6801_phy.h"
+#include "yt6801_net.h"
+
+static int fxgmac_is_tx_complete(struct fxgmac_dma_desc *dma_desc)
+{
+	return !FXGMAC_GET_BITS_LE(dma_desc->desc3, TX_NORMAL_DESC3_OWN_POS,
+				   TX_NORMAL_DESC3_OWN_LEN);
+}
+
+static void fxgmac_disable_rx_csum(struct fxgmac_pdata *pdata)
+{
+	u32 val;
+
+	val = rd32_mac(pdata, MAC_CR);
+	fxgmac_set_bits(&val, MAC_CR_IPC_POS, MAC_CR_IPC_LEN, 0);
+	wr32_mac(pdata, val, MAC_CR);
+
+	yt_dbg(pdata, "fxgmac disable rx checksum.\n");
+}
+
+static void fxgmac_enable_rx_csum(struct fxgmac_pdata *pdata)
+{
+	u32 val;
+
+	val = rd32_mac(pdata, MAC_CR);
+	fxgmac_set_bits(&val, MAC_CR_IPC_POS, MAC_CR_IPC_LEN, 1);
+	wr32_mac(pdata, val, MAC_CR);
+
+	yt_dbg(pdata, "fxgmac enable rx checksum.\n");
+}
+
+static void fxgmac_set_mac_address(struct fxgmac_pdata *pdata, u8 *addr)
+{
+	unsigned int mac_addr_hi, mac_addr_lo;
+
+/* MAC_MACA0HR is high 32 bits of mac,bit0:7 is mac[4], bit8:15 is mac[5]
+ * MAC_MACA0LR is low 32 bits of mac,
+ * bit0:7 is mac[0], bit8:15 is mac[1], bit16:23 is mac[2], bit24:32 is mac[3]
+ */
+	mac_addr_hi = (addr[5] << 8) | (addr[4] << 0);
+	mac_addr_lo = (addr[3] << 24) | (addr[2] << 16) | (addr[1] << 8) |
+		      (addr[0] << 0);
+
+	wr32_mac(pdata, mac_addr_hi, MAC_MACA0HR);
+	wr32_mac(pdata, mac_addr_lo, MAC_MACA0LR);
+}
+
+static void fxgmac_set_mac_reg(struct fxgmac_pdata *pdata,
+			       struct netdev_hw_addr *ha, unsigned int *mac_reg)
+{
+	unsigned int mac_addr_hi, mac_addr_lo;
+	u8 *mac_addr;
+
+	mac_addr_lo = 0;
+	mac_addr_hi = 0;
+
+	if (ha) {
+		mac_addr = (u8 *)&mac_addr_lo;
+		mac_addr[0] = ha->addr[0];
+		mac_addr[1] = ha->addr[1];
+		mac_addr[2] = ha->addr[2];
+		mac_addr[3] = ha->addr[3];
+
+		mac_addr = (u8 *)&mac_addr_hi;
+		mac_addr[0] = ha->addr[4];
+		mac_addr[1] = ha->addr[5];
+
+		yt_dbg(pdata, "adding mac address %pM at %#x\n", ha->addr,
+		       *mac_reg);
+
+		fxgmac_set_bits(&mac_addr_hi, MAC_MACA1HR_AE_POS,
+				MAC_MACA1HR_AE_LEN, 1);
+	}
+
+	wr32_mac(pdata, mac_addr_hi, *mac_reg);
+	*mac_reg += MAC_MACA_INC;
+	wr32_mac(pdata, mac_addr_lo, *mac_reg);
+	*mac_reg += MAC_MACA_INC;
+}
+
+static void fxgmac_enable_tx_vlan(struct fxgmac_pdata *pdata)
+{
+	u32 val, en = pdata->vlan;
+
+	val = rd32_mac(pdata, MAC_VLANIR);
+	fxgmac_set_bits(&val, MAC_VLANIR_VLTI_POS, MAC_VLANIR_VLTI_LEN, 0);
+	fxgmac_set_bits(&val, MAC_VLANIR_CSVL_POS, MAC_VLANIR_CSVL_LEN, 0);
+	fxgmac_set_bits(&val, MAC_VLANIR_VLP_POS, MAC_VLANIR_VLP_LEN, 1);
+	fxgmac_set_bits(&val, MAC_VLANIR_VLC_POS, MAC_VLANIR_VLC_LEN, 2);
+	fxgmac_set_bits(&val, MAC_VLANIR_VLT_POS, MAC_VLANIR_VLT_LEN, en);
+	wr32_mac(pdata, val, MAC_VLANIR);
+
+	val = rd32_mac(pdata, MAC_VLANTR);
+	fxgmac_set_bits(&val, MAC_VLANTR_VL_POS, MAC_VLANTR_VL_LEN, en);
+	wr32_mac(pdata, val, MAC_VLANTR);
+}
+
+static void fxgmac_disable_tx_vlan(struct fxgmac_pdata *pdata)
+{
+	u32 val;
+
+	val = rd32_mac(pdata, MAC_VLANIR);
+	/* Set VLAN Tag input enable */
+	fxgmac_set_bits(&val, MAC_VLANIR_CSVL_POS, MAC_VLANIR_CSVL_LEN, 0);
+	fxgmac_set_bits(&val, MAC_VLANIR_VLTI_POS, MAC_VLANIR_VLTI_LEN, 1);
+	/* Set VLAN priority control disable */
+	fxgmac_set_bits(&val, MAC_VLANIR_VLP_POS, MAC_VLANIR_VLP_LEN, 0);
+	fxgmac_set_bits(&val, MAC_VLANIR_VLC_POS, MAC_VLANIR_VLC_LEN, 0);
+	wr32_mac(pdata, val, MAC_VLANIR);
+}
+
+static void fxgmac_enable_rx_vlan_stripping(struct fxgmac_pdata *pdata)
+{
+	u32 val;
+
+	val = rd32_mac(pdata, MAC_VLANTR);
+	/* Put the VLAN tag in the Rx descriptor */
+	fxgmac_set_bits(&val, MAC_VLANTR_EVLRXS_POS, MAC_VLANTR_EVLRXS_LEN, 1);
+	/* Don't check the VLAN type */
+	fxgmac_set_bits(&val, MAC_VLANTR_DOVLTC_POS, MAC_VLANTR_DOVLTC_LEN, 1);
+	/* Check only C-TAG (0x8100) packets */
+	fxgmac_set_bits(&val, MAC_VLANTR_ERSVLM_POS, MAC_VLANTR_ERSVLM_LEN, 0);
+	/* Don't consider an S-TAG (0x88A8) packet as a VLAN packet */
+	fxgmac_set_bits(&val, MAC_VLANTR_ESVL_POS, MAC_VLANTR_ESVL_LEN, 0);
+	/* Enable VLAN tag stripping */
+	fxgmac_set_bits(&val, MAC_VLANTR_EVLS_POS, MAC_VLANTR_EVLS_LEN, 3);
+	wr32_mac(pdata, val, MAC_VLANTR);
+	yt_dbg(pdata, "fxgmac enable MAC rx vlan stripping.\n");
+}
+
+static void fxgmac_disable_rx_vlan_stripping(struct fxgmac_pdata *pdata)
+{
+	u32 val;
+
+	val = rd32_mac(pdata, MAC_VLANTR);
+	fxgmac_set_bits(&val, MAC_VLANTR_EVLS_POS, MAC_VLANTR_EVLS_LEN, 0);
+	wr32_mac(pdata, val, MAC_VLANTR);
+
+	yt_dbg(pdata, "fxgmac disable MAC rx vlan stripping.\n");
+}
+
+static void fxgmac_enable_rx_vlan_filtering(struct fxgmac_pdata *pdata)
+{
+	u32 val;
+
+	val = rd32_mac(pdata, MAC_PFR);
+	/* Enable VLAN filtering */
+	fxgmac_set_bits(&val, MAC_PFR_VTFE_POS, MAC_PFR_VTFE_LEN, 1);
+	wr32_mac(pdata, val, MAC_PFR);
+
+	val = rd32_mac(pdata, MAC_VLANTR);
+	/* Enable VLAN Hash Table filtering */
+	fxgmac_set_bits(&val, MAC_VLANTR_VTHM_POS, MAC_VLANTR_VTHM_LEN, 1);
+	/* Disable VLAN tag inverse matching */
+	fxgmac_set_bits(&val, MAC_VLANTR_VTIM_POS, MAC_VLANTR_VTIM_LEN, 0);
+	/* Only filter on the lower 12-bits of the VLAN tag */
+	fxgmac_set_bits(&val, MAC_VLANTR_ETV_POS, MAC_VLANTR_ETV_LEN, 1);
+}
+
+static void fxgmac_disable_rx_vlan_filtering(struct fxgmac_pdata *pdata)
+{
+	u32 val;
+
+	val = rd32_mac(pdata, MAC_PFR);
+	fxgmac_set_bits(&val, MAC_PFR_VTFE_POS, MAC_PFR_VTFE_LEN, 0);
+	wr32_mac(pdata, val, MAC_PFR);
+}
+
+static u32 fxgmac_vid_crc32_le(__le16 vid_le)
+{
+	unsigned char *data = (unsigned char *)&vid_le;
+	unsigned char data_byte = 0;
+	u32 crc = ~0;
+	u32 temp = 0;
+	int i, bits;
+
+	bits = get_bitmask_order(VLAN_VID_MASK);
+	for (i = 0; i < bits; i++) {
+		if ((i % 8) == 0)
+			data_byte = data[i / 8];
+
+		temp = ((crc & 1) ^ data_byte) & 1;
+		crc >>= 1;
+		data_byte >>= 1;
+
+		if (temp)
+			crc ^= CRC32_POLY_LE;
+	}
+
+	return crc;
+}
+
+static void fxgmac_update_vlan_hash_table(struct fxgmac_pdata *pdata)
+{
+	u16 vid, vlan_hash_table = 0;
+	__le16 vid_le;
+	u32 val, crc;
+
+	/* Generate the VLAN Hash Table value */
+	for_each_set_bit(vid, pdata->active_vlans, VLAN_N_VID) {
+		/* Get the CRC32 value of the VLAN ID */
+		vid_le = cpu_to_le16(vid);
+		crc = bitrev32(~fxgmac_vid_crc32_le(vid_le)) >> 28;
+
+		vlan_hash_table |= (1 << crc);
+	}
+
+	/* Set the VLAN Hash Table filtering register */
+	val = rd32_mac(pdata, MAC_VLANHTR);
+	fxgmac_set_bits(&val, MAC_VLANHTR_VLHT_POS, MAC_VLANHTR_VLHT_LEN,
+			vlan_hash_table);
+	wr32_mac(pdata, val, MAC_VLANHTR);
+
+	yt_dbg(pdata, "fxgmac_update_vlan_hash_tabl done,hash tbl=%08x.\n",
+	       vlan_hash_table);
+}
+
+static void fxgmac_set_promiscuous_mode(struct fxgmac_pdata *pdata,
+					unsigned int enable)
+{
+	u32 val, en = enable ? 1 : 0;
+
+	val = rd32_mac(pdata, MAC_PFR);
+	if (FXGMAC_GET_BITS(val, MAC_PFR_PR_POS, MAC_PFR_PR_LEN) == en)
+		return;
+
+	yt_dbg(pdata, " %s  promiscuous mode\n",
+	       enable ? "entering" : "leaving");
+
+	fxgmac_set_bits(&val, MAC_PFR_PR_POS, MAC_PFR_PR_LEN, en);
+	wr32_mac(pdata, val, MAC_PFR);
+
+	yt_dbg(pdata, "fxgmac set promisc mode=%d\n", enable);
+
+	/* Hardware will still perform VLAN filtering in promiscuous mode */
+	if (enable) {
+		fxgmac_disable_rx_vlan_filtering(pdata);
+		return;
+	}
+	if (pdata->netdev->features & NETIF_F_HW_VLAN_CTAG_FILTER)
+		fxgmac_enable_rx_vlan_filtering(pdata);
+}
+
+static void fxgmac_enable_rx_broadcast(struct fxgmac_pdata *pdata,
+				       unsigned int enable)
+{
+	u32 val, en = enable ? 0 : 1;
+
+	val = rd32_mac(pdata, MAC_PFR);
+	if (FXGMAC_GET_BITS(val, MAC_PFR_DBF_POS, MAC_PFR_DBF_LEN) == en)
+		return;
+
+	fxgmac_set_bits(&val, MAC_PFR_DBF_POS, MAC_PFR_DBF_LEN, en);
+	wr32_mac(pdata, val, MAC_PFR);
+
+	yt_dbg(pdata, "%s, bcast en=%d, bit-val=%d, reg=%x.\n", __func__,
+	       enable, val, val);
+}
+
+static void fxgmac_set_all_multicast_mode(struct fxgmac_pdata *pdata,
+					  unsigned int enable)
+{
+	u32 val, en = enable ? 1 : 0;
+
+	val = rd32_mac(pdata, MAC_PFR);
+	if (FXGMAC_GET_BITS(val, MAC_PFR_PM_POS, MAC_PFR_PM_LEN) == en)
+		return;
+
+	fxgmac_set_bits(&val, MAC_PFR_PM_POS, MAC_PFR_PM_LEN, en);
+	wr32_mac(pdata, val, MAC_PFR);
+
+	yt_dbg(pdata, " %s  - Enable all Multicast=%d, val=%#x.", __func__,
+	       enable, val);
+}
+
+static void fxgmac_set_mac_addn_addrs(struct fxgmac_pdata *pdata)
+{
+	struct net_device *netdev = pdata->netdev;
+	unsigned int addn_macs, mac_reg;
+	struct netdev_hw_addr *ha;
+
+	mac_reg = MAC_MACA1HR;
+	addn_macs = pdata->hw_feat.addn_mac;
+
+	if (netdev_uc_count(netdev) > addn_macs) {
+		fxgmac_set_promiscuous_mode(pdata, 1);
+	} else {
+		netdev_for_each_uc_addr(ha, netdev) {
+			fxgmac_set_mac_reg(pdata, ha, &mac_reg);
+			addn_macs--;
+		}
+
+		if (netdev_mc_count(netdev) > addn_macs) {
+			fxgmac_set_all_multicast_mode(pdata, 1);
+		} else {
+			netdev_for_each_mc_addr(ha, netdev) {
+				fxgmac_set_mac_reg(pdata, ha, &mac_reg);
+				addn_macs--;
+			}
+		}
+	}
+
+	/* Clear remaining additional MAC address entries */
+	while (addn_macs--)
+		fxgmac_set_mac_reg(pdata, NULL, &mac_reg);
+}
+
+#define GET_REG_AND_BIT_POS(reversalval, regout, bitout)                       \
+	do {                                                                   \
+		typeof(reversalval)(_reversalval) = (reversalval);             \
+		regout = (((_reversalval) >> 5) & 0x7);                        \
+		bitout = ((_reversalval) & 0x1f);                              \
+	} while (0)
+
+/* Maximum MAC address hash table size (256 bits = 8 bytes) */
+#define FXGMAC_MAC_HASH_TABLE_SIZE 8
+
+static u32 fxgmac_crc32(unsigned char *data, int length)
+{
+	u32 crc = ~0;
+
+	while (--length >= 0) {
+		unsigned char byte = *data++;
+		int bit;
+
+		for (bit = 8; --bit >= 0; byte >>= 1) {
+			if ((crc ^ byte) & 1) {
+				crc >>= 1;
+				crc ^= CRC32_POLY_LE;
+			} else {
+				crc >>= 1;
+			}
+		}
+	}
+
+	return ~crc;
+}
+
+static void fxgmac_config_multicast_mac_hash_table(struct fxgmac_pdata *pdata,
+						   unsigned char *pmc_mac,
+						   int b_add)
+{
+	unsigned int j, hash_reg, reg_bit;
+	u32 val, crc, reversal_crc;
+
+	if (!pmc_mac) {
+		for (j = 0; j < FXGMAC_MAC_HASH_TABLE_SIZE; j++) {
+			hash_reg = j;
+			hash_reg = (MAC_HTR0 + hash_reg * MAC_HTR_INC);
+			wr32_mac(pdata, 0, hash_reg);
+		}
+		yt_dbg(pdata, "%s, clear all mcast mac hash table\n", __func__);
+		return;
+	}
+
+	crc = fxgmac_crc32(pmc_mac, ETH_ALEN);
+
+	/* reverse the crc */
+	for (j = 0, reversal_crc = 0; j < 32; j++) {
+		if (crc & ((u32)1 << j))
+			reversal_crc |= 1 << (31 - j);
+	}
+
+	GET_REG_AND_BIT_POS((reversal_crc >> 24), hash_reg, reg_bit);
+	/* Set the MAC Hash Table registers */
+	hash_reg = (MAC_HTR0 + hash_reg * MAC_HTR_INC);
+
+	val = rd32_mac(pdata, hash_reg);
+	fxgmac_set_bits(&val, reg_bit, 1, (b_add ? 1 : 0));
+	wr32_mac(pdata, val, hash_reg);
+}
+
+static void fxgmac_set_mac_hash_table(struct fxgmac_pdata *pdata)
+{
+	struct net_device *netdev = pdata->netdev;
+	struct netdev_hw_addr *ha;
+
+	fxgmac_config_multicast_mac_hash_table(pdata, NULL, 1);
+	netdev_for_each_mc_addr(ha, netdev) {
+		fxgmac_config_multicast_mac_hash_table(pdata, ha->addr, 1);
+	}
+}
+
+static void fxgmac_set_mc_addresses(struct fxgmac_pdata *pdata)
+{
+	if (pdata->hw_feat.hash_table_size)
+		fxgmac_set_mac_hash_table(pdata);
+	else
+		fxgmac_set_mac_addn_addrs(pdata);
+}
+
+static void fxgmac_set_multicast_mode(struct fxgmac_pdata *pdata,
+				      unsigned int enable)
+{
+	if (enable)
+		fxgmac_set_mc_addresses(pdata);
+	else
+		fxgmac_config_multicast_mac_hash_table(pdata, NULL, 1);
+}
+
+static void fxgmac_config_mac_address(struct fxgmac_pdata *pdata)
+{
+	u32 val;
+
+	fxgmac_set_mac_address(pdata, pdata->mac_addr);
+
+	/* Filtering is done using perfect filtering and hash filtering */
+	if (pdata->hw_feat.hash_table_size == 0)
+		return;
+
+	val = rd32_mac(pdata, MAC_PFR);
+	fxgmac_set_bits(&val, MAC_PFR_HPF_POS, MAC_PFR_HPF_LEN, 1);
+	fxgmac_set_bits(&val, MAC_PFR_HUC_POS, MAC_PFR_HUC_LEN, 1);
+	fxgmac_set_bits(&val, MAC_PFR_HMC_POS, MAC_PFR_HMC_LEN, 1);
+	wr32_mac(pdata, val, MAC_PFR);
+}
+
+static void fxgmac_config_crc_check(struct fxgmac_pdata *pdata)
+{
+	u32 val, en = pdata->crc_check ? 0 : 1;
+
+	val = rd32_mac(pdata, MAC_ECR);
+	fxgmac_set_bits(&val, MAC_ECR_DCRCC_POS, MAC_ECR_DCRCC_LEN, en);
+	wr32_mac(pdata, val, MAC_ECR);
+}
+
+static void fxgmac_config_jumbo(struct fxgmac_pdata *pdata)
+{
+	u32 val;
+
+	val = rd32_mac(pdata, MAC_CR);
+	fxgmac_set_bits(&val, MAC_CR_JE_POS, MAC_CR_JE_LEN, pdata->jumbo);
+	wr32_mac(pdata, val, MAC_CR);
+}
+
+static void fxgmac_config_checksum_offload(struct fxgmac_pdata *pdata)
+{
+	if (pdata->netdev->features & NETIF_F_RXCSUM)
+		fxgmac_enable_rx_csum(pdata);
+	else
+		fxgmac_disable_rx_csum(pdata);
+}
+
+static void fxgmac_config_vlan_support(struct fxgmac_pdata *pdata)
+{
+	/*  configure dynamical vlanID from TX Context. */
+	fxgmac_disable_tx_vlan(pdata);
+
+	/* Set the current VLAN Hash Table register value */
+	fxgmac_update_vlan_hash_table(pdata);
+
+	if (pdata->vlan_filter)
+		fxgmac_enable_rx_vlan_filtering(pdata);
+	else
+		fxgmac_disable_rx_vlan_filtering(pdata);
+
+	if (pdata->vlan_strip)
+		fxgmac_enable_rx_vlan_stripping(pdata);
+	else
+		fxgmac_disable_rx_vlan_stripping(pdata);
+}
+
+static void fxgmac_config_rx_mode(struct fxgmac_pdata *pdata)
+{
+	unsigned int pr_mode, am_mode, mu_mode, bd_mode;
+
+	pr_mode = ((pdata->netdev->flags & IFF_PROMISC) != 0);
+	am_mode = ((pdata->netdev->flags & IFF_ALLMULTI) != 0);
+	mu_mode = ((pdata->netdev->flags & IFF_MULTICAST) != 0);
+	bd_mode = ((pdata->netdev->flags & IFF_BROADCAST) != 0);
+
+	fxgmac_enable_rx_broadcast(pdata, bd_mode);
+	fxgmac_set_promiscuous_mode(pdata, pr_mode);
+	fxgmac_set_all_multicast_mode(pdata, am_mode);
+	fxgmac_set_multicast_mode(pdata, mu_mode);
+}
+
+static void fxgmac_prepare_tx_stop(struct fxgmac_pdata *pdata,
+				   struct fxgmac_channel *channel)
+{
+	unsigned int tx_qidx, tx_status;
+	unsigned int tx_dsr, tx_pos;
+	unsigned long tx_timeout;
+
+	/* Calculate the status register to read and the position within */
+	if (channel->queue_index < DMA_DSRX_FIRST_QUEUE) {
+		tx_dsr = DMA_DSR0;
+		tx_pos = (channel->queue_index * DMA_DSR_Q_LEN) +
+			 DMA_DSR0_TPS_START;
+	} else {
+		tx_qidx = channel->queue_index - DMA_DSRX_FIRST_QUEUE;
+
+		tx_dsr = DMA_DSR1 + ((tx_qidx / DMA_DSRX_QPR) * DMA_DSRX_INC);
+		tx_pos = ((tx_qidx % DMA_DSRX_QPR) * DMA_DSR_Q_LEN) +
+			 DMA_DSRX_TPS_START;
+	}
+
+	/* The Tx engine cannot be stopped if it is actively processing
+	 * descriptors. Wait for the Tx engine to enter the stopped or
+	 * suspended state.
+	 */
+	tx_timeout = jiffies + (FXGMAC_DMA_STOP_TIMEOUT * HZ);
+
+	while (time_before(jiffies, tx_timeout)) {
+		tx_status = rd32_mac(pdata, tx_dsr);
+		tx_status = FXGMAC_GET_BITS(tx_status, tx_pos, DMA_DSR_TPS_LEN);
+		if (tx_status == DMA_TPS_STOPPED ||
+		    tx_status == DMA_TPS_SUSPENDED)
+			break;
+
+		usleep_range(500, 1000);
+	}
+
+	if (!time_before(jiffies, tx_timeout))
+		yt_dbg(pdata,
+		       "timed out waiting for Tx DMA channel %u to stop\n",
+		       channel->queue_index);
+}
+
+static void fxgmac_enable_tx(struct fxgmac_pdata *pdata)
+{
+	struct fxgmac_channel *channel = pdata->channel_head;
+	u32 val, i;
+
+	/* Enable each Tx DMA channel */
+	for (i = 0; i < pdata->channel_count; i++, channel++) {
+		if (!channel->tx_ring)
+			break;
+		val = readl(FXGMAC_DMA_REG(channel, DMA_CH_TCR));
+		fxgmac_set_bits(&val, DMA_CH_TCR_ST_POS, DMA_CH_TCR_ST_LEN, 1);
+		writel(val, FXGMAC_DMA_REG(channel, DMA_CH_TCR));
+	}
+
+	/* Enable each Tx queue */
+	for (i = 0; i < pdata->tx_q_count; i++) {
+		val = readl(FXGMAC_MTL_REG(pdata, i, MTL_Q_TQOMR));
+		fxgmac_set_bits(&val, MTL_Q_TQOMR_TXQEN_POS,
+				MTL_Q_TQOMR_TXQEN_LEN, MTL_Q_ENABLED);
+		writel(val, FXGMAC_MTL_REG(pdata, i, MTL_Q_TQOMR));
+	}
+
+	/* Enable MAC Tx */
+	val = rd32_mac(pdata, MAC_CR);
+	fxgmac_set_bits(&val, MAC_CR_TE_POS, MAC_CR_TE_LEN, 1);
+	wr32_mac(pdata, val, MAC_CR);
+}
+
+static void fxgmac_disable_tx(struct fxgmac_pdata *pdata)
+{
+	struct fxgmac_channel *channel = pdata->channel_head;
+	u32 val, i;
+
+	/* Prepare for Tx DMA channel stop */
+	if (channel) {
+		for (i = 0; i < pdata->channel_count; i++, channel++) {
+			if (!channel->tx_ring)
+				break;
+
+			fxgmac_prepare_tx_stop(pdata, channel);
+		}
+	}
+
+	/* Disable MAC Tx */
+	val = rd32_mac(pdata, MAC_CR);
+	fxgmac_set_bits(&val, MAC_CR_TE_POS, MAC_CR_TE_LEN, 0);
+	wr32_mac(pdata, val, MAC_CR);
+
+	/* Disable each Tx queue */
+	for (i = 0; i < pdata->tx_q_count; i++) {
+		val = readl(FXGMAC_MTL_REG(pdata, i, MTL_Q_TQOMR));
+		fxgmac_set_bits(&val, MTL_Q_TQOMR_TXQEN_POS,
+				MTL_Q_TQOMR_TXQEN_LEN, 0);
+		writel(val, FXGMAC_MTL_REG(pdata, i, MTL_Q_TQOMR));
+	}
+
+	channel = pdata->channel_head;
+	if (channel) {
+		/* Disable each Tx DMA channel */
+		for (i = 0; i < pdata->channel_count; i++, channel++) {
+			if (!channel->tx_ring)
+				break;
+
+			val = readl(FXGMAC_DMA_REG(channel, DMA_CH_TCR));
+			fxgmac_set_bits(&val, DMA_CH_TCR_ST_POS,
+					DMA_CH_TCR_ST_LEN, 0);
+			writel(val, FXGMAC_DMA_REG(channel, DMA_CH_TCR));
+		}
+	}
+}
+
+static void fxgmac_prepare_rx_stop(struct fxgmac_pdata *pdata,
+				   unsigned int queue)
+{
+	unsigned int rx_status, prxq, rxqsts;
+	unsigned long rx_timeout;
+
+	/* The Rx engine cannot be stopped if it is actively processing
+	 * packets. Wait for the Rx queue to empty the Rx fifo.
+	 */
+	rx_timeout = jiffies + (FXGMAC_DMA_STOP_TIMEOUT * HZ);
+
+	while (time_before(jiffies, rx_timeout)) {
+		rx_status = readl(FXGMAC_MTL_REG(pdata, queue, MTL_Q_RQDR));
+		prxq = FXGMAC_GET_BITS(rx_status, MTL_Q_RQDR_PRXQ_POS,
+				       MTL_Q_RQDR_PRXQ_LEN);
+		rxqsts = FXGMAC_GET_BITS(rx_status, MTL_Q_RQDR_RXQSTS_POS,
+					 MTL_Q_RQDR_RXQSTS_LEN);
+		if (prxq == 0 && rxqsts == 0)
+			break;
+
+		usleep_range(500, 1000);
+	}
+
+	if (!time_before(jiffies, rx_timeout))
+		yt_dbg(pdata, "timed out waiting for Rx queue %u to empty\n",
+		       queue);
+}
+
+static void fxgmac_enable_rx(struct fxgmac_pdata *pdata)
+{
+	struct fxgmac_channel *channel = pdata->channel_head;
+	unsigned int val, i;
+
+	/* Enable each Rx DMA channel */
+	for (i = 0; i < pdata->channel_count; i++, channel++) {
+		if (!channel->rx_ring)
+			break;
+
+		val = readl(FXGMAC_DMA_REG(channel, DMA_CH_RCR));
+		fxgmac_set_bits(&val, DMA_CH_RCR_SR_POS, DMA_CH_RCR_SR_LEN, 1);
+		writel(val, FXGMAC_DMA_REG(channel, DMA_CH_RCR));
+	}
+
+	/* Enable each Rx queue */
+	val = 0;
+	for (i = 0; i < pdata->rx_q_count; i++)
+		val |= (0x02 << (i << 1));
+
+	wr32_mac(pdata, val, MAC_RQC0R);
+
+	/* Enable MAC Rx */
+	val = rd32_mac(pdata, MAC_CR);
+	fxgmac_set_bits(&val, MAC_CR_CST_POS, MAC_CR_CST_LEN, 1);
+	fxgmac_set_bits(&val, MAC_CR_ACS_POS, MAC_CR_ACS_LEN, 1);
+	fxgmac_set_bits(&val, MAC_CR_RE_POS, MAC_CR_RE_LEN, 1);
+	wr32_mac(pdata, val, MAC_CR);
+}
+
+static void fxgmac_disable_rx(struct fxgmac_pdata *pdata)
+{
+	struct fxgmac_channel *channel = pdata->channel_head;
+	u32 val, i;
+
+	/* Disable MAC Rx */
+	val = rd32_mac(pdata, MAC_CR);
+	fxgmac_set_bits(&val, MAC_CR_CST_POS, MAC_CR_CST_LEN, 0);
+	fxgmac_set_bits(&val, MAC_CR_ACS_POS, MAC_CR_ACS_LEN, 0);
+	fxgmac_set_bits(&val, MAC_CR_RE_POS, MAC_CR_RE_LEN, 0);
+	wr32_mac(pdata, val, MAC_CR);
+
+	/* Prepare for Rx DMA channel stop */
+	for (i = 0; i < pdata->rx_q_count; i++)
+		fxgmac_prepare_rx_stop(pdata, i);
+
+	wr32_mac(pdata, 0, MAC_RQC0R); /* Disable each Rx queue */
+
+	if (!channel)
+		return;
+
+	/* Disable each Rx DMA channel */
+	for (i = 0; i < pdata->channel_count; i++, channel++) {
+		if (!channel->rx_ring)
+			break;
+
+		val = readl(FXGMAC_DMA_REG(channel, DMA_CH_RCR));
+		fxgmac_set_bits(&val, DMA_CH_RCR_SR_POS, DMA_CH_RCR_SR_LEN, 0);
+		writel(val, FXGMAC_DMA_REG(channel, DMA_CH_RCR));
+	}
+}
+
+static int fxgmac_is_last_desc(struct fxgmac_dma_desc *dma_desc)
+{
+	/* Rx and Tx share LD bit, so check TDES3.LD bit */
+	return FXGMAC_GET_BITS_LE(dma_desc->desc3, TX_NORMAL_DESC3_LD_POS,
+				  TX_NORMAL_DESC3_LD_LEN);
+}
+
+static void fxgmac_config_tx_flow_control(struct fxgmac_pdata *pdata)
+{
+	unsigned int max_q_count, q_count;
+	unsigned int reg, val, i;
+
+	/* Set MTL flow control */
+	for (i = 0; i < pdata->rx_q_count; i++) {
+		val = readl(FXGMAC_MTL_REG(pdata, i, MTL_Q_RQOMR));
+		fxgmac_set_bits(&val, MTL_Q_RQOMR_EHFC_POS,
+				MTL_Q_RQOMR_EHFC_LEN, pdata->tx_pause);
+		writel(val, FXGMAC_MTL_REG(pdata, i, MTL_Q_RQOMR));
+	}
+
+	/* Set MAC flow control */
+	max_q_count = FXGMAC_MAX_FLOW_CONTROL_QUEUES;
+	q_count = min_t(unsigned int, pdata->tx_q_count, max_q_count);
+
+	reg = MAC_Q0TFCR;
+	for (i = 0; i < q_count; i++) {
+		val = rd32_mac(pdata, reg);
+
+		fxgmac_set_bits(&val, MAC_Q0TFCR_TFE_POS, MAC_Q0TFCR_TFE_LEN,
+				pdata->tx_pause);
+		if (pdata->tx_pause == 1)
+			/* Set pause time */
+			fxgmac_set_bits(&val, MAC_Q0TFCR_PT_POS,
+					MAC_Q0TFCR_PT_LEN, 0xffff);
+
+		wr32_mac(pdata, val, reg);
+		reg += MAC_QTFCR_INC;
+	}
+}
+
+static void fxgmac_config_rx_flow_control(struct fxgmac_pdata *pdata)
+{
+	u32 val;
+
+	val = rd32_mac(pdata, MAC_RFCR);
+	fxgmac_set_bits(&val, MAC_RFCR_RFE_POS, MAC_RFCR_RFE_LEN,
+			pdata->rx_pause);
+	wr32_mac(pdata, val, MAC_RFCR);
+}
+
+static void fxgmac_config_rx_coalesce(struct fxgmac_pdata *pdata)
+{
+	struct fxgmac_channel *channel = pdata->channel_head;
+	u32 val;
+
+	if (!channel)
+		return;
+
+	for (u32 i = 0; i < pdata->channel_count; i++, channel++) {
+		if (!channel->rx_ring)
+			break;
+
+		val = readl(FXGMAC_DMA_REG(channel, DMA_CH_RIWT));
+		fxgmac_set_bits(&val, DMA_CH_RIWT_RWT_POS, DMA_CH_RIWT_RWT_LEN,
+				pdata->rx_riwt);
+		writel(val, FXGMAC_DMA_REG(channel, DMA_CH_RIWT));
+	}
+}
+
+static void fxgmac_config_rx_fep_disable(struct fxgmac_pdata *pdata)
+{
+	u32 val;
+
+	for (u32 i = 0; i < pdata->rx_q_count; i++) {
+		val = readl(FXGMAC_MTL_REG(pdata, i, MTL_Q_RQOMR));
+		/* enable the rx queue forward packet with error status
+		 * (crc error,gmii_er, watch dog timeout.or overflow)
+		 */
+		fxgmac_set_bits(&val, MTL_Q_RQOMR_FEP_POS, MTL_Q_RQOMR_FEP_LEN,
+				MTL_FEP_ENABLE);
+		writel(val, FXGMAC_MTL_REG(pdata, i, MTL_Q_RQOMR));
+	}
+}
+
+static void fxgmac_config_rx_fup_enable(struct fxgmac_pdata *pdata)
+{
+	u32 val;
+
+	for (u32 i = 0; i < pdata->rx_q_count; i++) {
+		val = readl(FXGMAC_MTL_REG(pdata, i, MTL_Q_RQOMR));
+		fxgmac_set_bits(&val, MTL_Q_RQOMR_FUP_POS, MTL_Q_RQOMR_FUP_LEN,
+				1);
+		writel(val, FXGMAC_MTL_REG(pdata, i, MTL_Q_RQOMR));
+	}
+}
+
+static void fxgmac_config_rx_buffer_size(struct fxgmac_pdata *pdata)
+{
+	struct fxgmac_channel *channel = pdata->channel_head;
+	u32 val;
+
+	if (!channel)
+		return;
+
+	for (u32 i = 0; i < pdata->channel_count; i++, channel++) {
+		if (!channel->rx_ring)
+			break;
+
+		val = readl(FXGMAC_DMA_REG(channel, DMA_CH_RCR));
+		fxgmac_set_bits(&val, DMA_CH_RCR_RBSZ_POS, DMA_CH_RCR_RBSZ_LEN,
+				pdata->rx_buf_size);
+		writel(val, FXGMAC_DMA_REG(channel, DMA_CH_RCR));
+	}
+}
+
+static void fxgmac_config_tso_mode(struct fxgmac_pdata *pdata)
+{
+	struct fxgmac_channel *channel = pdata->channel_head;
+	u32 val, tso;
+
+	tso = pdata->hw_feat.tso;
+
+	if (!channel)
+		return;
+
+	for (u32 i = 0; i < pdata->channel_count; i++, channel++) {
+		if (!channel->tx_ring)
+			break;
+
+		val = readl(FXGMAC_DMA_REG(channel, DMA_CH_TCR));
+		fxgmac_set_bits(&val, DMA_CH_TCR_TSE_POS, DMA_CH_TCR_TSE_LEN,
+				tso);
+		writel(val, FXGMAC_DMA_REG(channel, DMA_CH_TCR));
+	}
+}
+
+static void fxgmac_config_sph_mode(struct fxgmac_pdata *pdata)
+{
+	struct fxgmac_channel *channel = pdata->channel_head;
+	u32 val;
+
+	for (u32 i = 0; i < pdata->channel_count; i++, channel++) {
+		if (!channel->rx_ring)
+			break;
+
+		val = readl(FXGMAC_DMA_REG(channel, DMA_CH_CR));
+		fxgmac_set_bits(&val, DMA_CH_CR_SPH_POS, DMA_CH_CR_SPH_LEN, 0);
+		writel(val, FXGMAC_DMA_REG(channel, DMA_CH_CR));
+	}
+
+	val = rd32_mac(pdata, MAC_ECR);
+	fxgmac_set_bits(&val, MAC_ECR_HDSMS_POS, MAC_ECR_HDSMS_LEN,
+			FXGMAC_SPH_HDSMS_SIZE);
+	wr32_mac(pdata, val, MAC_ECR);
+}
+
+static unsigned int fxgmac_usec_to_riwt(struct fxgmac_pdata *pdata,
+					unsigned int usec)
+{
+	/* Convert the input usec value to the watchdog timer value. Each
+	 * watchdog timer value is equivalent to 256 clock cycles.
+	 * Calculate the required value as:
+	 *  ( usec * ( system_clock_mhz / 10^6) / 256
+	 */
+	return (usec * (pdata->sysclk_rate / 1000000)) / 256;
+}
+
+static void fxgmac_config_rx_threshold(struct fxgmac_pdata *pdata,
+				       unsigned int set_val)
+{
+	u32 val;
+
+	for (u32 i = 0; i < pdata->rx_q_count; i++) {
+		val = readl(FXGMAC_MTL_REG(pdata, i, MTL_Q_RQOMR));
+		fxgmac_set_bits(&val, MTL_Q_RQOMR_RTC_POS, MTL_Q_RQOMR_RTC_LEN,
+				set_val);
+		writel(val, FXGMAC_MTL_REG(pdata, i, MTL_Q_RQOMR));
+	}
+}
+
+static void fxgmac_config_mtl_mode(struct fxgmac_pdata *pdata)
+{
+	u32 val;
+
+	/* Set Tx to weighted round robin scheduling algorithm */
+	val = rd32_mac(pdata, MTL_OMR);
+	fxgmac_set_bits(&val, MTL_OMR_ETSALG_POS, MTL_OMR_ETSALG_LEN,
+			MTL_ETSALG_WRR);
+	wr32_mac(pdata, val, MTL_OMR);
+
+	/* Set Tx traffic classes to use WRR algorithm with equal weights */
+	for (u32 i = 0; i < pdata->tx_q_count; i++) {
+		val = readl(FXGMAC_MTL_REG(pdata, i, MTL_TC_QWR));
+		fxgmac_set_bits(&val, MTL_TC_QWR_QW_POS, MTL_TC_QWR_QW_LEN, 1);
+		writel(val, FXGMAC_MTL_REG(pdata, i, MTL_TC_QWR));
+	}
+	/* Set Rx to strict priority algorithm */
+	val = rd32_mac(pdata, MTL_OMR);
+	fxgmac_set_bits(&val, MTL_OMR_RAA_POS, MTL_OMR_RAA_LEN, MTL_RAA_SP);
+	wr32_mac(pdata, val, MTL_OMR);
+}
+
+static void fxgmac_config_queue_mapping(struct fxgmac_pdata *pdata)
+{
+	unsigned int ppq, ppq_extra, prio_queues;
+	unsigned int __maybe_unused prio;
+	unsigned int reg, val, mask;
+
+	/* Map the 8 VLAN priority values to available MTL Rx queues */
+	prio_queues =
+		min_t(unsigned int, IEEE_8021QAZ_MAX_TCS, pdata->rx_q_count);
+	ppq = IEEE_8021QAZ_MAX_TCS / prio_queues;
+	ppq_extra = IEEE_8021QAZ_MAX_TCS % prio_queues;
+
+	reg = MAC_RQC2R;
+	val = 0;
+	for (u32 i = 0, prio = 0; i < prio_queues;) {
+		mask = 0;
+		for (u32 j = 0; j < ppq; j++) {
+			yt_dbg(pdata, "PRIO%u mapped to RXq%u\n", prio, i);
+			mask |= (1 << prio);
+			prio++;
+		}
+
+		if (i < ppq_extra) {
+			yt_dbg(pdata, "PRIO%u mapped to RXq%u\n", prio, i);
+			mask |= (1 << prio);
+			prio++;
+		}
+
+		val |= (mask << ((i++ % MAC_RQC2_Q_PER_REG) << 3));
+
+		if ((i % MAC_RQC2_Q_PER_REG) && i != prio_queues)
+			continue;
+
+		wr32_mac(pdata, val, reg);
+		reg += MAC_RQC2_INC;
+		val = 0;
+	}
+
+	/* Configure one to one, MTL Rx queue to DMA Rx channel mapping
+	 * ie Q0 <--> CH0, Q1 <--> CH1 ... Q11 <--> CH11
+	 */
+	val = rd32_mac(pdata, MTL_RQDCM0R);
+	val |= (MTL_RQDCM0R_Q0MDMACH | MTL_RQDCM0R_Q1MDMACH |
+		MTL_RQDCM0R_Q2MDMACH | MTL_RQDCM0R_Q3MDMACH);
+
+	/* Selection to let RSS work, * ie, bit4,12,20,28 for
+	 * Q0,1,2,3 individual
+	 */
+	if (pdata->rss)
+		val |= (MTL_RQDCM0R_Q0DDMACH | MTL_RQDCM0R_Q1DDMACH |
+			MTL_RQDCM0R_Q2DDMACH | MTL_RQDCM0R_Q3DDMACH);
+
+	wr32_mac(pdata, val, MTL_RQDCM0R);
+
+	val = rd32_mac(pdata, MTL_RQDCM0R + MTL_RQDCM_INC);
+	val |= (MTL_RQDCM1R_Q4MDMACH | MTL_RQDCM1R_Q5MDMACH |
+		MTL_RQDCM1R_Q6MDMACH | MTL_RQDCM1R_Q7MDMACH);
+	wr32_mac(pdata, val, MTL_RQDCM0R + MTL_RQDCM_INC);
+}
+
+#define FXGMAC_MAX_FIFO 81920
+
+static unsigned int fxgmac_calculate_per_queue_fifo(unsigned int fifo_size,
+						    unsigned int queue_count)
+{
+	unsigned int q_fifo_size, p_fifo;
+
+	/* Calculate the configured fifo size */
+	q_fifo_size = 1 << (fifo_size + 7);
+
+	/* The configured value may not be the actual amount of fifo RAM */
+	q_fifo_size = min_t(unsigned int, FXGMAC_MAX_FIFO, q_fifo_size);
+	q_fifo_size = q_fifo_size / queue_count;
+
+	/* Each increment in the queue fifo size represents 256 bytes of
+	 * fifo, with 0 representing 256 bytes. Distribute the fifo equally
+	 * between the queues.
+	 */
+	p_fifo = q_fifo_size / 256;
+	if (p_fifo)
+		p_fifo--;
+
+	return p_fifo;
+}
+
+static u32 fxgmac_calculate_max_checksum_size(struct fxgmac_pdata *pdata)
+{
+	u32 fifo_size;
+
+	fifo_size = fxgmac_calculate_per_queue_fifo(pdata->hw_feat.tx_fifo_size,
+						    pdata->tx_q_count);
+
+	/* Each increment in the queue fifo size represents 256 bytes of
+	 * fifo, with 0 representing 256 bytes. Distribute the fifo equally
+	 * between the queues.
+	 */
+	fifo_size = (fifo_size + 1) * 256;
+
+	/* Packet size < TxQSize - (PBL + N)*(DATAWIDTH/8),
+	 * Datawidth = 128
+	 * If Datawidth = 32, N = 7, elseif Datawidth != 32, N = 5.
+	 * TxQSize is indicated by TQS field of MTL_TxQ#_Operation_Mode register
+	 * PBL = TxPBL field in the DMA_CH#_TX_Control register in all
+	 * DMA configurations.
+	 */
+	fifo_size -= (pdata->tx_pbl * (pdata->pblx8 ? 8 : 1) + 5) *
+		     (FXGMAC_DATA_WIDTH / 8);
+	fifo_size -= 256;
+
+	return fifo_size;
+}
+
+static void fxgmac_config_tx_fifo_size(struct fxgmac_pdata *pdata)
+{
+	unsigned int fifo_size;
+	u32 val;
+
+	fifo_size = fxgmac_calculate_per_queue_fifo(pdata->hw_feat.tx_fifo_size,
+						    pdata->tx_q_count);
+
+	for (u32 i = 0; i < pdata->tx_q_count; i++) {
+		val = readl(FXGMAC_MTL_REG(pdata, i, MTL_Q_TQOMR));
+		fxgmac_set_bits(&val, MTL_Q_TQOMR_TQS_POS, MTL_Q_TQOMR_TQS_LEN,
+				fifo_size);
+		writel(val, FXGMAC_MTL_REG(pdata, i, MTL_Q_TQOMR));
+	}
+
+	yt_dbg(pdata, "%d Tx hardware queues, %d byte fifo per queue\n",
+	       pdata->tx_q_count, ((fifo_size + 1) * 256));
+}
+
+static void fxgmac_config_rx_fifo_size(struct fxgmac_pdata *pdata)
+{
+	unsigned int fifo_size;
+	u32 val;
+
+	fifo_size = fxgmac_calculate_per_queue_fifo(pdata->hw_feat.rx_fifo_size,
+						    pdata->rx_q_count);
+
+	for (u32 i = 0; i < pdata->rx_q_count; i++) {
+		val = readl(FXGMAC_MTL_REG(pdata, i, MTL_Q_RQOMR));
+		fxgmac_set_bits(&val, MTL_Q_RQOMR_RQS_POS, MTL_Q_RQOMR_RQS_LEN,
+				fifo_size);
+		writel(val, FXGMAC_MTL_REG(pdata, i, MTL_Q_RQOMR));
+	}
+
+	yt_dbg(pdata, "%d Rx hardware queues, %d byte fifo per queue\n",
+	       pdata->rx_q_count, ((fifo_size + 1) * 256));
+}
+
+static void fxgmac_config_flow_control_threshold(struct fxgmac_pdata *pdata)
+{
+	u32 val;
+
+	for (u32 i = 0; i < pdata->rx_q_count; i++) {
+		val = readl(FXGMAC_MTL_REG(pdata, i, MTL_Q_RQOMR));
+		/* Activate flow control when less than 4k left in fifo */
+		fxgmac_set_bits(&val, MTL_Q_RQOMR_RFA_POS, MTL_Q_RQOMR_RFA_LEN,
+				6);
+		/* De-activate flow control when more than 6k left in fifo */
+		fxgmac_set_bits(&val, MTL_Q_RQOMR_RFD_POS, MTL_Q_RQOMR_RFD_LEN,
+				10);
+		writel(val, FXGMAC_MTL_REG(pdata, i, MTL_Q_RQOMR));
+	}
+}
+
+static void fxgmac_config_tx_threshold(struct fxgmac_pdata *pdata,
+				       unsigned int set_val)
+{
+	u32 val;
+
+	for (u32 i = 0; i < pdata->tx_q_count; i++) {
+		val = readl(FXGMAC_MTL_REG(pdata, i, MTL_Q_TQOMR));
+		fxgmac_set_bits(&val, MTL_Q_TQOMR_TTC_POS, MTL_Q_TQOMR_TTC_LEN,
+				set_val);
+		writel(val, FXGMAC_MTL_REG(pdata, i, MTL_Q_TQOMR));
+	}
+}
+
+static void fxgmac_config_rsf_mode(struct fxgmac_pdata *pdata,
+				   unsigned int set_val)
+{
+	u32 val;
+
+	for (u32 i = 0; i < pdata->rx_q_count; i++) {
+		val = readl(FXGMAC_MTL_REG(pdata, i, MTL_Q_RQOMR));
+		fxgmac_set_bits(&val, MTL_Q_RQOMR_RSF_POS, MTL_Q_RQOMR_RSF_LEN,
+				set_val);
+		writel(val, FXGMAC_MTL_REG(pdata, i, MTL_Q_RQOMR));
+	}
+}
+
+static void fxgmac_config_tsf_mode(struct fxgmac_pdata *pdata,
+				   unsigned int set_val)
+{
+	u32 val;
+
+	for (u32 i = 0; i < pdata->tx_q_count; i++) {
+		val = readl(FXGMAC_MTL_REG(pdata, i, MTL_Q_TQOMR));
+		fxgmac_set_bits(&val, MTL_Q_TQOMR_TSF_POS, MTL_Q_TQOMR_TSF_LEN,
+				set_val);
+		writel(val, FXGMAC_MTL_REG(pdata, i, MTL_Q_TQOMR));
+	}
+}
+
+static void fxgmac_config_osp_mode(struct fxgmac_pdata *pdata)
+{
+	struct fxgmac_channel *channel = pdata->channel_head;
+	u32 val;
+
+	if (!channel)
+		return;
+
+	for (u32 i = 0; i < pdata->channel_count; i++, channel++) {
+		if (!channel->tx_ring)
+			break;
+
+		val = readl(FXGMAC_DMA_REG(channel, DMA_CH_TCR));
+		fxgmac_set_bits(&val, DMA_CH_TCR_OSP_POS, DMA_CH_TCR_OSP_LEN,
+				pdata->tx_osp_mode);
+		writel(val, FXGMAC_DMA_REG(channel, DMA_CH_TCR));
+	}
+}
+
+static void fxgmac_config_pblx8(struct fxgmac_pdata *pdata)
+{
+	struct fxgmac_channel *channel = pdata->channel_head;
+	u32 val;
+
+	if (!channel)
+		return;
+
+	for (u32 i = 0; i < pdata->channel_count; i++, channel++) {
+		val = readl(FXGMAC_DMA_REG(channel, DMA_CH_CR));
+		fxgmac_set_bits(&val, DMA_CH_CR_PBLX8_POS, DMA_CH_CR_PBLX8_LEN,
+				pdata->pblx8);
+		writel(val, FXGMAC_DMA_REG(channel, DMA_CH_CR));
+	}
+}
+
+static void fxgmac_config_tx_pbl_val(struct fxgmac_pdata *pdata)
+{
+	struct fxgmac_channel *channel = pdata->channel_head;
+	u32 val;
+
+	if (!channel)
+		return;
+
+	for (u32 i = 0; i < pdata->channel_count; i++, channel++) {
+		if (!channel->tx_ring)
+			break;
+
+		val = readl(FXGMAC_DMA_REG(channel, DMA_CH_TCR));
+		fxgmac_set_bits(&val, DMA_CH_TCR_PBL_POS, DMA_CH_TCR_PBL_LEN,
+				pdata->tx_pbl);
+		writel(val, FXGMAC_DMA_REG(channel, DMA_CH_TCR));
+	}
+}
+
+static void fxgmac_config_rx_pbl_val(struct fxgmac_pdata *pdata)
+{
+	struct fxgmac_channel *channel = pdata->channel_head;
+	u32 val;
+
+	if (!channel)
+		return;
+
+	for (u32 i = 0; i < pdata->channel_count; i++, channel++) {
+		if (!channel->rx_ring)
+			break;
+
+		val = readl(FXGMAC_DMA_REG(channel, DMA_CH_RCR));
+		fxgmac_set_bits(&val, DMA_CH_RCR_PBL_POS, DMA_CH_RCR_PBL_LEN,
+				pdata->rx_pbl);
+		writel(val, FXGMAC_DMA_REG(channel, DMA_CH_RCR));
+	}
+}
+
+static void fxgmac_tx_mmc_int(struct fxgmac_pdata *yt)
+{
+	unsigned int mmc_isr = rd32_mac(yt, MMC_TISR);
+	struct fxgmac_stats *stats = &yt->stats;
+
+	if (mmc_isr & BIT(MMC_TISR_TXOCTETCOUNT_GB_POS))
+		stats->txoctetcount_gb += rd32_mac(yt, MMC_TXOCTETCOUNT_GB_LO);
+
+	if (mmc_isr & BIT(MMC_TISR_TXFRAMECOUNT_GB_POS))
+		stats->txframecount_gb += rd32_mac(yt, MMC_TXFRAMECOUNT_GB_LO);
+
+	if (mmc_isr & BIT(MMC_TISR_TXBROADCASTFRAMES_G_POS))
+		stats->txbroadcastframes_g +=
+			rd32_mac(yt, MMC_TXBROADCASTFRAMES_G_LO);
+
+	if (mmc_isr & BIT(MMC_TISR_TXMULTICASTFRAMES_G_POS))
+		stats->txmulticastframes_g +=
+			rd32_mac(yt, MMC_TXMULTICASTFRAMES_G_LO);
+
+	if (mmc_isr & BIT(MMC_TISR_TX64OCTETS_GB_POS))
+		stats->tx64octets_gb += rd32_mac(yt, MMC_TX64OCTETS_GB_LO);
+
+	if (mmc_isr & BIT(MMC_TISR_TX65TO127OCTETS_GB_POS))
+		stats->tx65to127octets_gb +=
+			rd32_mac(yt, MMC_TX65TO127OCTETS_GB_LO);
+
+	if (mmc_isr & BIT(MMC_TISR_TX128TO255OCTETS_GB_POS))
+		stats->tx128to255octets_gb +=
+			rd32_mac(yt, MMC_TX128TO255OCTETS_GB_LO);
+
+	if (mmc_isr & BIT(MMC_TISR_TX256TO511OCTETS_GB_POS))
+		stats->tx256to511octets_gb +=
+			rd32_mac(yt, MMC_TX256TO511OCTETS_GB_LO);
+
+	if (mmc_isr & BIT(MMC_TISR_TX512TO1023OCTETS_GB_POS))
+		stats->tx512to1023octets_gb +=
+			rd32_mac(yt, MMC_TX512TO1023OCTETS_GB_LO);
+
+	if (mmc_isr & BIT(MMC_TISR_TX1024TOMAXOCTETS_GB_POS))
+		stats->tx1024tomaxoctets_gb +=
+			rd32_mac(yt, MMC_TX1024TOMAXOCTETS_GB_LO);
+
+	if (mmc_isr & BIT(MMC_TISR_TXUNICASTFRAMES_GB_POS))
+		stats->txunicastframes_gb +=
+			rd32_mac(yt, MMC_TXUNICASTFRAMES_GB_LO);
+
+	if (mmc_isr & BIT(MMC_TISR_TXMULTICASTFRAMES_GB_POS))
+		stats->txmulticastframes_gb +=
+			rd32_mac(yt, MMC_TXMULTICASTFRAMES_GB_LO);
+
+	if (mmc_isr & BIT(MMC_TISR_TXBROADCASTFRAMES_GB_POS))
+		stats->txbroadcastframes_g +=
+			rd32_mac(yt, MMC_TXBROADCASTFRAMES_GB_LO);
+
+	if (mmc_isr & BIT(MMC_TISR_TXUNDERFLOWERROR_POS))
+		stats->txunderflowerror +=
+			rd32_mac(yt, MMC_TXUNDERFLOWERROR_LO);
+
+	if (mmc_isr & BIT(MMC_TISR_TXSINGLECOLLISION_G_POS))
+		stats->txsinglecollision_g +=
+			rd32_mac(yt, MMC_TXSINGLECOLLISION_G);
+
+	if (mmc_isr & BIT(MMC_TISR_TXMULTIPLECOLLISION_G_POS))
+		stats->txmultiplecollision_g +=
+			rd32_mac(yt, MMC_TXMULTIPLECOLLISION_G);
+
+	if (mmc_isr & BIT(MMC_TISR_TXDEFERREDFRAMES_POS))
+		stats->txdeferredframes += rd32_mac(yt, MMC_TXDEFERREDFRAMES);
+
+	if (mmc_isr & BIT(MMC_TISR_TXLATECOLLISIONFRAMES_POS))
+		stats->txlatecollisionframes +=
+			rd32_mac(yt, MMC_TXLATECOLLISIONFRAMES);
+
+	if (mmc_isr & BIT(MMC_TISR_TXEXCESSIVECOLLISIONFRAMES_POS))
+		stats->txexcessivecollisionframes +=
+			rd32_mac(yt, MMC_TXEXCESSIVECOLLSIONFRAMES);
+
+	if (mmc_isr & BIT(MMC_TISR_TXCARRIERERRORFRAMES_POS))
+		stats->txcarriererrorframes +=
+			rd32_mac(yt, MMC_TXCARRIERERRORFRAMES);
+
+	if (mmc_isr & BIT(MMC_TISR_TXOCTETCOUNT_G_POS))
+		stats->txoctetcount_g += rd32_mac(yt, MMC_TXOCTETCOUNT_G_LO);
+
+	if (mmc_isr & BIT(MMC_TISR_TXFRAMECOUNT_G_POS))
+		stats->txframecount_g += rd32_mac(yt, MMC_TXFRAMECOUNT_G_LO);
+
+	if (mmc_isr & BIT(MMC_TISR_TXEXCESSIVEDEFERRALFRAMES_POS))
+		stats->txexcessivedeferralerror +=
+			rd32_mac(yt, MMC_TXEXCESSIVEDEFERRALERROR);
+
+	if (mmc_isr & BIT(MMC_TISR_TXPAUSEFRAMES_POS))
+		stats->txpauseframes += rd32_mac(yt, MMC_TXPAUSEFRAMES_LO);
+
+	if (mmc_isr & BIT(MMC_TISR_TXVLANFRAMES_G_POS))
+		stats->txvlanframes_g += rd32_mac(yt, MMC_TXVLANFRAMES_G_LO);
+
+	if (mmc_isr & BIT(MMC_TISR_TXOVERSIZE_G_POS))
+		stats->txoversize_g += rd32_mac(yt, MMC_TXOVERSIZEFRAMES);
+}
+
+static void fxgmac_rx_mmc_int(struct fxgmac_pdata *yt)
+{
+	unsigned int mmc_isr = rd32_mac(yt, MMC_RISR);
+	struct fxgmac_stats *stats = &yt->stats;
+
+	if (mmc_isr & BIT(MMC_RISR_RXFRAMECOUNT_GB_POS))
+		stats->rxframecount_gb += rd32_mac(yt, MMC_RXFRAMECOUNT_GB_LO);
+
+	if (mmc_isr & BIT(MMC_RISR_RXOCTETCOUNT_GB_POS))
+		stats->rxoctetcount_gb += rd32_mac(yt, MMC_RXOCTETCOUNT_GB_LO);
+
+	if (mmc_isr & BIT(MMC_RISR_RXOCTETCOUNT_G_POS))
+		stats->rxoctetcount_g += rd32_mac(yt, MMC_RXOCTETCOUNT_G_LO);
+
+	if (mmc_isr & BIT(MMC_RISR_RXBROADCASTFRAMES_G_POS))
+		stats->rxbroadcastframes_g +=
+			rd32_mac(yt, MMC_RXBROADCASTFRAMES_G_LO);
+
+	if (mmc_isr & BIT(MMC_RISR_RXMULTICASTFRAMES_G_POS))
+		stats->rxmulticastframes_g +=
+			rd32_mac(yt, MMC_RXMULTICASTFRAMES_G_LO);
+
+	if (mmc_isr & BIT(MMC_RISR_RXCRCERROR_POS))
+		stats->rxcrcerror += rd32_mac(yt, MMC_RXCRCERROR_LO);
+
+	if (mmc_isr & BIT(MMC_RISR_RXALIGNERROR_POS))
+		stats->rxalignerror += rd32_mac(yt, MMC_RXALIGNERROR);
+
+	if (mmc_isr & BIT(MMC_RISR_RXRUNTERROR_POS))
+		stats->rxrunterror += rd32_mac(yt, MMC_RXRUNTERROR);
+
+	if (mmc_isr & BIT(MMC_RISR_RXJABBERERROR_POS))
+		stats->rxjabbererror += rd32_mac(yt, MMC_RXJABBERERROR);
+
+	if (mmc_isr & BIT(MMC_RISR_RXUNDERSIZE_G_POS))
+		stats->rxundersize_g += rd32_mac(yt, MMC_RXUNDERSIZE_G);
+
+	if (mmc_isr & BIT(MMC_RISR_RXOVERSIZE_G_POS))
+		stats->rxoversize_g += rd32_mac(yt, MMC_RXOVERSIZE_G);
+
+	if (mmc_isr & BIT(MMC_RISR_RX64OCTETS_GB_POS))
+		stats->rx64octets_gb += rd32_mac(yt, MMC_RX64OCTETS_GB_LO);
+
+	if (mmc_isr & BIT(MMC_RISR_RX65TO127OCTETS_GB_POS))
+		stats->rx65to127octets_gb +=
+			rd32_mac(yt, MMC_RX65TO127OCTETS_GB_LO);
+
+	if (mmc_isr & BIT(MMC_RISR_RX128TO255OCTETS_GB_POS))
+		stats->rx128to255octets_gb +=
+			rd32_mac(yt, MMC_RX128TO255OCTETS_GB_LO);
+
+	if (mmc_isr & BIT(MMC_RISR_RX256TO511OCTETS_GB_POS))
+		stats->rx256to511octets_gb +=
+			rd32_mac(yt, MMC_RX256TO511OCTETS_GB_LO);
+
+	if (mmc_isr & BIT(MMC_RISR_RX512TO1023OCTETS_GB_POS))
+		stats->rx512to1023octets_gb +=
+			rd32_mac(yt, MMC_RX512TO1023OCTETS_GB_LO);
+
+	if (mmc_isr & BIT(MMC_RISR_RX1024TOMAXOCTETS_GB_POS))
+		stats->rx1024tomaxoctets_gb +=
+			rd32_mac(yt, MMC_RX1024TOMAXOCTETS_GB_LO);
+
+	if (mmc_isr & BIT(MMC_RISR_RXUNICASTFRAMES_G_POS))
+		stats->rxunicastframes_g +=
+			rd32_mac(yt, MMC_RXUNICASTFRAMES_G_LO);
+
+	if (mmc_isr & BIT(MMC_RISR_RXLENGTHERROR_POS))
+		stats->rxlengtherror += rd32_mac(yt, MMC_RXLENGTHERROR_LO);
+
+	if (mmc_isr & BIT(MMC_RISR_RXOUTOFRANGETYPE_POS))
+		stats->rxoutofrangetype +=
+			rd32_mac(yt, MMC_RXOUTOFRANGETYPE_LO);
+
+	if (mmc_isr & BIT(MMC_RISR_RXPAUSEFRAMES_POS))
+		stats->rxpauseframes += rd32_mac(yt, MMC_RXPAUSEFRAMES_LO);
+
+	if (mmc_isr & BIT(MMC_RISR_RXFIFOOVERFLOW_POS))
+		stats->rxfifooverflow += rd32_mac(yt, MMC_RXFIFOOVERFLOW_LO);
+
+	if (mmc_isr & BIT(MMC_RISR_RXVLANFRAMES_GB_POS))
+		stats->rxvlanframes_gb += rd32_mac(yt, MMC_RXVLANFRAMES_GB_LO);
+
+	if (mmc_isr & BIT(MMC_RISR_RXWATCHDOGERROR_POS))
+		stats->rxwatchdogerror += rd32_mac(yt, MMC_RXWATCHDOGERROR);
+
+	if (mmc_isr & BIT(MMC_RISR_RXERRORFRAMES_POS))
+		stats->rxreceiveerrorframe +=
+			rd32_mac(yt, MMC_RXRECEIVEERRORFRAME);
+
+	if (mmc_isr & BIT(MMC_RISR_RXERRORCONTROLFRAMES_POS))
+		stats->rxcontrolframe_g += rd32_mac(yt, MMC_RXCONTROLFRAME_G);
+}
+
+static void fxgmac_read_mmc_stats(struct fxgmac_pdata *yt)
+{
+	struct fxgmac_stats *stats = &yt->stats;
+	u32 val;
+
+	/* Freeze counters */
+	val = rd32_mac(yt, MMC_CR);
+	fxgmac_set_bits(&val, MMC_CR_MCF_POS, MMC_CR_MCF_LEN, 1);
+	wr32_mac(yt, val, MMC_CR);
+
+	stats->txoctetcount_gb += rd32_mac(yt, MMC_TXOCTETCOUNT_GB_LO);
+	stats->txframecount_gb += rd32_mac(yt, MMC_TXFRAMECOUNT_GB_LO);
+	stats->txbroadcastframes_g += rd32_mac(yt, MMC_TXBROADCASTFRAMES_G_LO);
+	stats->txmulticastframes_g += rd32_mac(yt, MMC_TXMULTICASTFRAMES_G_LO);
+	stats->tx64octets_gb += rd32_mac(yt, MMC_TX64OCTETS_GB_LO);
+	stats->tx65to127octets_gb += rd32_mac(yt, MMC_TX65TO127OCTETS_GB_LO);
+	stats->tx128to255octets_gb += rd32_mac(yt, MMC_TX128TO255OCTETS_GB_LO);
+	stats->tx256to511octets_gb += rd32_mac(yt, MMC_TX256TO511OCTETS_GB_LO);
+	stats->tx512to1023octets_gb +=
+		rd32_mac(yt, MMC_TX512TO1023OCTETS_GB_LO);
+	stats->tx1024tomaxoctets_gb +=
+		rd32_mac(yt, MMC_TX1024TOMAXOCTETS_GB_LO);
+	stats->txunicastframes_gb += rd32_mac(yt, MMC_TXUNICASTFRAMES_GB_LO);
+	stats->txmulticastframes_gb +=
+		rd32_mac(yt, MMC_TXMULTICASTFRAMES_GB_LO);
+	stats->txbroadcastframes_g += rd32_mac(yt, MMC_TXBROADCASTFRAMES_GB_LO);
+	stats->txunderflowerror += rd32_mac(yt, MMC_TXUNDERFLOWERROR_LO);
+	stats->txsinglecollision_g += rd32_mac(yt, MMC_TXSINGLECOLLISION_G);
+	stats->txmultiplecollision_g += rd32_mac(yt, MMC_TXMULTIPLECOLLISION_G);
+	stats->txdeferredframes += rd32_mac(yt, MMC_TXDEFERREDFRAMES);
+	stats->txlatecollisionframes += rd32_mac(yt, MMC_TXLATECOLLISIONFRAMES);
+	stats->txexcessivecollisionframes +=
+		rd32_mac(yt, MMC_TXEXCESSIVECOLLSIONFRAMES);
+	stats->txcarriererrorframes += rd32_mac(yt, MMC_TXCARRIERERRORFRAMES);
+	stats->txoctetcount_g += rd32_mac(yt, MMC_TXOCTETCOUNT_G_LO);
+	stats->txframecount_g += rd32_mac(yt, MMC_TXFRAMECOUNT_G_LO);
+	stats->txexcessivedeferralerror +=
+		rd32_mac(yt, MMC_TXEXCESSIVEDEFERRALERROR);
+	stats->txpauseframes += rd32_mac(yt, MMC_TXPAUSEFRAMES_LO);
+	stats->txvlanframes_g += rd32_mac(yt, MMC_TXVLANFRAMES_G_LO);
+	stats->txoversize_g += rd32_mac(yt, MMC_TXOVERSIZEFRAMES);
+	stats->rxframecount_gb += rd32_mac(yt, MMC_RXFRAMECOUNT_GB_LO);
+	stats->rxoctetcount_gb += rd32_mac(yt, MMC_RXOCTETCOUNT_GB_LO);
+	stats->rxoctetcount_g += rd32_mac(yt, MMC_RXOCTETCOUNT_G_LO);
+	stats->rxbroadcastframes_g += rd32_mac(yt, MMC_RXBROADCASTFRAMES_G_LO);
+	stats->rxmulticastframes_g += rd32_mac(yt, MMC_RXMULTICASTFRAMES_G_LO);
+	stats->rxcrcerror += rd32_mac(yt, MMC_RXCRCERROR_LO);
+	stats->rxalignerror += rd32_mac(yt, MMC_RXALIGNERROR);
+	stats->rxrunterror += rd32_mac(yt, MMC_RXRUNTERROR);
+	stats->rxjabbererror += rd32_mac(yt, MMC_RXJABBERERROR);
+	stats->rxundersize_g += rd32_mac(yt, MMC_RXUNDERSIZE_G);
+	stats->rxoversize_g += rd32_mac(yt, MMC_RXOVERSIZE_G);
+	stats->rx64octets_gb += rd32_mac(yt, MMC_RX64OCTETS_GB_LO);
+	stats->rx65to127octets_gb += rd32_mac(yt, MMC_RX65TO127OCTETS_GB_LO);
+	stats->rx128to255octets_gb += rd32_mac(yt, MMC_RX128TO255OCTETS_GB_LO);
+	stats->rx256to511octets_gb += rd32_mac(yt, MMC_RX256TO511OCTETS_GB_LO);
+	stats->rx512to1023octets_gb +=
+		rd32_mac(yt, MMC_RX512TO1023OCTETS_GB_LO);
+	stats->rx1024tomaxoctets_gb +=
+		rd32_mac(yt, MMC_RX1024TOMAXOCTETS_GB_LO);
+	stats->rxunicastframes_g += rd32_mac(yt, MMC_RXUNICASTFRAMES_G_LO);
+	stats->rxlengtherror += rd32_mac(yt, MMC_RXLENGTHERROR_LO);
+	stats->rxoutofrangetype += rd32_mac(yt, MMC_RXOUTOFRANGETYPE_LO);
+	stats->rxpauseframes += rd32_mac(yt, MMC_RXPAUSEFRAMES_LO);
+	stats->rxfifooverflow += rd32_mac(yt, MMC_RXFIFOOVERFLOW_LO);
+	stats->rxvlanframes_gb += rd32_mac(yt, MMC_RXVLANFRAMES_GB_LO);
+	stats->rxwatchdogerror += rd32_mac(yt, MMC_RXWATCHDOGERROR);
+	stats->rxreceiveerrorframe += rd32_mac(yt, MMC_RXRECEIVEERRORFRAME);
+	stats->rxcontrolframe_g += rd32_mac(yt, MMC_RXCONTROLFRAME_G);
+
+	/* Un-freeze counters */
+	val = rd32_mac(yt, MMC_CR);
+	fxgmac_set_bits(&val, MMC_CR_MCF_POS, MMC_CR_MCF_LEN, 0);
+	wr32_mac(yt, val, MMC_CR);
+}
+
+static void fxgmac_config_mmc(struct fxgmac_pdata *pdata)
+{
+	u32 val;
+
+	/* Set counters to reset on read, Reset the counters */
+	val = rd32_mac(pdata, MMC_CR);
+	fxgmac_set_bits(&val, MMC_CR_ROR_POS, MMC_CR_ROR_LEN, 1);
+	fxgmac_set_bits(&val, MMC_CR_CR_POS, MMC_CR_CR_LEN, 1);
+	wr32_mac(pdata, val, MMC_CR);
+
+	wr32_mac(pdata, 0xffffffff, MMC_IPCRXINTMASK);
+}
+
+static u32 fxgmac_read_rss_options(struct fxgmac_pdata *pdata)
+{
+	u32 val;
+
+	val = rd32_mem(pdata, MGMT_RSS_CTRL);
+	val = FXGMAC_GET_BITS(val, MGMT_RSS_CTRL_OPT_POS,
+			      MGMT_RSS_CTRL_OPT_LEN);
+
+	return val;
+}
+
+static void fxgmac_write_rss_options(struct fxgmac_pdata *pdata)
+{
+	u32 val;
+
+	val = rd32_mem(pdata, MGMT_RSS_CTRL);
+	fxgmac_set_bits(&val, MGMT_RSS_CTRL_OPT_POS, MGMT_RSS_CTRL_OPT_LEN,
+			pdata->rss_options);
+	wr32_mem(pdata, val, MGMT_RSS_CTRL);
+}
+
+static void fxgmac_write_rss_hash_key(struct fxgmac_pdata *pdata)
+{
+	unsigned int key_regs = sizeof(pdata->rss_key) / sizeof(u32);
+	u32 *key = (u32 *)&pdata->rss_key;
+
+	while (key_regs--) {
+		wr32_mem(pdata, cpu_to_be32(*key),
+			 MGMT_RSS_KEY0 + key_regs * MGMT_RSS_KEY_INC);
+		key++;
+	}
+}
+
+static void fxgmac_write_rss_lookup_table(struct fxgmac_pdata *pdata)
+{
+	u32 i, j, val = 0;
+
+	for (i = 0, j = 0; i < ARRAY_SIZE(pdata->rss_table); i++, j++) {
+		if (j < MGMT_RSS_IDT_ENTRY_SIZE) {
+			val |= ((pdata->rss_table[i] & MGMT_RSS_IDT_ENTRY_MASK)
+				<< (j * 2));
+			continue;
+		}
+
+		wr32_mem(pdata, val,
+			 MGMT_RSS_IDT + (i / MGMT_RSS_IDT_ENTRY_SIZE - 1) *
+						MGMT_RSS_IDT_INC);
+		val = pdata->rss_table[i];
+		j = 0;
+	}
+
+	if (j != MGMT_RSS_IDT_ENTRY_SIZE)
+		return;
+
+	/* last IDT */
+	wr32_mem(pdata, val,
+		 MGMT_RSS_IDT +
+			 (i / MGMT_RSS_IDT_ENTRY_SIZE - 1) * MGMT_RSS_IDT_INC);
+}
+
+static void fxgmac_set_rss_hash_key(struct fxgmac_pdata *pdata, const u8 *key)
+{
+	memcpy(pdata->rss_key, key, sizeof(pdata->rss_key));
+	fxgmac_write_rss_hash_key(pdata);
+}
+
+static u32 log2ex(u32 value)
+{
+	u32 i = 31;
+
+	while (i > 0) {
+		if (value & 0x80000000)
+			break;
+
+		value <<= 1;
+		i--;
+	}
+	return i;
+}
+
+static void fxgmac_enable_rss(struct fxgmac_pdata *pdata)
+{
+	u32 size = 0;
+	u32 val;
+
+	fxgmac_write_rss_hash_key(pdata);
+	fxgmac_write_rss_lookup_table(pdata);
+
+	/* Set RSS IDT table size, Enable RSS, Set the RSS options */
+	val = rd32_mem(pdata, MGMT_RSS_CTRL);
+	size = log2ex(FXGMAC_RSS_MAX_TABLE_SIZE) - 1;
+	fxgmac_set_bits(&val, MGMT_RSS_CTRL_TBL_SIZE_POS,
+			MGMT_RSS_CTRL_TBL_SIZE_LEN, size);
+	fxgmac_set_bits(&val, MGMT_RSS_CTRL_RSSE_POS, MGMT_RSS_CTRL_RSSE_LEN,
+			1);
+	fxgmac_set_bits(&val, MGMT_RSS_CTRL_OPT_POS, MGMT_RSS_CTRL_OPT_LEN,
+			pdata->rss_options);
+	wr32_mem(pdata, val, MGMT_RSS_CTRL);
+
+	yt_dbg(pdata, "%s, rss ctrl reg=0x%08x\n", __func__, val);
+}
+
+static void fxgmac_disable_rss(struct fxgmac_pdata *pdata)
+{
+	u32 val;
+
+	val = rd32_mem(pdata, MGMT_RSS_CTRL);
+	fxgmac_set_bits(&val, MGMT_RSS_CTRL_RSSE_POS, MGMT_RSS_CTRL_RSSE_LEN,
+			0);
+	wr32_mem(pdata, val, MGMT_RSS_CTRL);
+
+	yt_dbg(pdata, "%s, rss ctrl reg=0x%08x\n", __func__, val);
+}
+
+static void fxgmac_config_rss(struct fxgmac_pdata *pdata)
+{
+	if (pdata->rss)
+		fxgmac_enable_rss(pdata);
+	else
+		fxgmac_disable_rss(pdata);
+}
+
+static void fxgmac_update_aoe_ipv4addr(struct fxgmac_pdata *pdata, u8 *ip_addr)
+{
+	unsigned int val, ipval = 0;
+
+	/* enable or disable ARP offload engine. */
+	if (!pdata->hw_feat.aoe) {
+		yt_err(pdata,
+		       "error update ip addr - arp offload not supported.\n");
+		return;
+	}
+
+	if (ip_addr) {
+		ipval = (ip_addr[0] << 24) | (ip_addr[1] << 16) |
+			(ip_addr[2] << 8) | (ip_addr[3] << 0);
+		yt_dbg(pdata,
+		       "%s, covert IP dotted-addr %s to binary 0x%08x ok.\n",
+		       __func__, ip_addr, cpu_to_be32(ipval));
+	} else {
+		/* get ipv4 addr from net device */
+		ipval = fxgmac_get_netdev_ip4addr(pdata);
+		yt_dbg(pdata, "%s, Get net device binary IP ok, 0x%08x\n",
+		       __func__, cpu_to_be32(ipval));
+
+		ipval = cpu_to_be32(ipval);
+	}
+
+	val = rd32_mac(pdata, MAC_ARP_PROTO_ADDR);
+	if (val != (ipval)) {
+		wr32_mac(pdata, ipval, MAC_ARP_PROTO_ADDR);
+		yt_dbg(pdata,
+		       "%s, update arp ipaddr reg from 0x%08x to 0x%08x\n",
+		       __func__, val, ipval);
+	}
+}
+
+static void fxgmac_enable_arp_offload(struct fxgmac_pdata *pdata)
+{
+	u32 val;
+
+	if (!pdata->hw_feat.aoe) {
+		yt_err(pdata,
+		       "error update ip addr - arp offload not supported.\n");
+		return;
+	}
+
+	val = rd32_mac(pdata, MAC_CR);
+	fxgmac_set_bits(&val, MAC_CR_ARPEN_POS, MAC_CR_ARPEN_LEN, 1);
+	wr32_mac(pdata, val, MAC_CR);
+}
+
+static void fxgmac_disable_arp_offload(struct fxgmac_pdata *pdata)
+{
+	u32 val;
+
+	if (!pdata->hw_feat.aoe) {
+		yt_err(pdata,
+		       "error update ip addr - arp offload not supported.\n");
+		return;
+	}
+
+	val = rd32_mac(pdata, MAC_CR);
+	fxgmac_set_bits(&val, MAC_CR_ARPEN_POS, MAC_CR_ARPEN_LEN, 0);
+	wr32_mac(pdata, val, MAC_CR);
+}
+
+/**
+ * fxgmac_set_ns_offload - config register for NS offload function
+ * @pdata: board private structure
+ * @index: 0~1, index to NS look up table. one entry of the lut is like
+ *   this |remote|solicited|target0|target1|
+ * @remote_addr: ipv6 addr where yt6801 gets the NS solicitation pkt(request).
+ *   in common, it is 0 to match any remote machine.
+ * @solicited_addr: the solicited node multicast group address which
+ *   yt6801 computes and joins.
+ * @target_addr1: it is the target address in NS solicitation pkt.
+ * @target_addr2:second target address, any address (with ast 6B same with
+ *  target address)
+ * @mac_addr: it is the target address in NS solicitation pkt.
+ */
+static void
+fxgmac_set_ns_offload(struct fxgmac_pdata *pdata, unsigned int index,
+		      unsigned char *remote_addr, unsigned char *solicited_addr,
+		      unsigned char *target_addr1, unsigned char *target_addr2,
+		      unsigned char *mac_addr)
+{
+	u32 base = (NS_LUT_MAC_ADDR_CTL - NS_LUT_ROMOTE0 + 4) * index;
+	u32 address[4], mac_addr_hi, mac_addr_lo;
+	u8 remote_not_zero = 0;
+	u32 val;
+
+	val = rd32_mem(pdata, NS_TPID_PRO);
+	fxgmac_set_bits(&val, NS_TPID_PRO_STPID_POS, NS_TPID_PRO_STPID_LEN,
+			0X8100);
+	fxgmac_set_bits(&val, NS_TPID_PRO_CTPID_POS, NS_TPID_PRO_CTPID_LEN,
+			0X9100);
+	wr32_mem(pdata, val, NS_TPID_PRO);
+
+	val = rd32_mem(pdata, base + NS_LUT_MAC_ADDR_CTL);
+	fxgmac_set_bits(&val, NS_LUT_DST_CMP_TYPE_POS, NS_LUT_DST_CMP_TYPE_LEN,
+			1);
+	fxgmac_set_bits(&val, NS_LUT_DST_IGNORED_POS, NS_LUT_DST_IGNORED_LEN,
+			1);
+	fxgmac_set_bits(&val, NS_LUT_REMOTE_AWARED_POS,
+			NS_LUT_REMOTE_AWARED_LEN, 1);
+	fxgmac_set_bits(&val, NS_LUT_TARGET_ISANY_POS, NS_LUT_TARGET_ISANY_LEN,
+			0);
+	wr32_mem(pdata, val, base + NS_LUT_MAC_ADDR_CTL);
+
+	for (u32 i = 0; i < 16 / 4; i++) {
+		address[i] = (remote_addr[i * 4 + 0] << 24) |
+			     (remote_addr[i * 4 + 1] << 16) |
+			     (remote_addr[i * 4 + 2] << 8) |
+			     (remote_addr[i * 4 + 3] << 0);
+		wr32_mem(pdata, address[i], base + NS_LUT_ROMOTE0 + 4 * i);
+		if (address[i])
+			remote_not_zero = 1;
+
+		address[i] = (target_addr1[i * 4 + 0] << 24) |
+			     (target_addr1[i * 4 + 1] << 16) |
+			     (target_addr1[i * 4 + 2] << 8) |
+			     (target_addr1[i * 4 + 3] << 0);
+		wr32_mem(pdata, address[i], base + NS_LUT_TARGET0 + 4 * i);
+		address[i] = (solicited_addr[i * 4 + 0] << 24) |
+			     (solicited_addr[i * 4 + 1] << 16) |
+			     (solicited_addr[i * 4 + 2] << 8) |
+			     (solicited_addr[i * 4 + 3] << 0);
+		wr32_mem(pdata, address[i], base + NS_LUT_SOLICITED0 + 4 * i);
+		address[i] = (target_addr2[i * 4 + 0] << 24) |
+			     (target_addr2[i * 4 + 1] << 16) |
+			     (target_addr2[i * 4 + 2] << 8) |
+			     (target_addr2[i * 4 + 3] << 0);
+		wr32_mem(pdata, address[i],
+			 0X10 * index + NS_LUT_TARGET4 + 4 * i);
+	}
+	mac_addr_hi = (mac_addr[0] << 24) | (mac_addr[1] << 16) |
+		      (mac_addr[2] << 8) | (mac_addr[3] << 0);
+	mac_addr_lo = (mac_addr[4] << 8) | (mac_addr[5] << 0);
+	wr32_mem(pdata, mac_addr_hi, base + NS_LUT_MAC_ADDR);
+
+	val = rd32_mem(pdata, base + NS_LUT_MAC_ADDR_CTL);
+	fxgmac_set_bits(&val, NS_LUT_MAC_ADDR_LOW_POS, NS_LUT_MAC_ADDR_LOW_LEN,
+			mac_addr_lo);
+	if (remote_not_zero == 0)
+		fxgmac_set_bits(&val, NS_LUT_REMOTE_AWARED_POS,
+				NS_LUT_REMOTE_AWARED_LEN, 0);
+	else
+		fxgmac_set_bits(&val, NS_LUT_REMOTE_AWARED_POS,
+				NS_LUT_REMOTE_AWARED_LEN, 1);
+	wr32_mem(pdata, val, base + NS_LUT_MAC_ADDR_CTL);
+}
+
+#define NS_OFFLOAD_TAB_MAX_IDX	2
+
+static void fxgmac_update_ns_offload_ipv6addr(struct fxgmac_pdata *pdata,
+					      unsigned int param)
+{
+	struct net_device *netdev = pdata->netdev;
+	unsigned char addr_buf[5][16];
+	static u8 ns_offload_tab_idx;
+	unsigned char *solicited_addr;
+	unsigned char *target_addr1;
+	unsigned char *remote_addr;
+	unsigned char *mac_addr;
+
+	remote_addr = (unsigned char *)&addr_buf[0][0];
+	solicited_addr = (unsigned char *)&addr_buf[1][0];
+	target_addr1 = (unsigned char *)&addr_buf[2][0];
+	mac_addr = (unsigned char *)&addr_buf[4][0];
+
+	param &= (FXGMAC_NS_IFA_LOCAL_LINK | FXGMAC_NS_IFA_GLOBAL_UNICAST);
+	/* get ipv6 addr from net device */
+	if (fxgmac_get_netdev_ip6addr(pdata, target_addr1, solicited_addr,
+				      param) == NULL) {
+		yt_err(pdata,
+		       "%s, get ipv6 addr with err and ignore NS offload.\n",
+		       __func__);
+		return;
+	}
+
+	yt_dbg(pdata, "%s, IPv6 local-link=%pI6, solicited =%pI6\n", __func__,
+	       target_addr1, solicited_addr);
+
+	memcpy(mac_addr, netdev->dev_addr, netdev->addr_len);
+	yt_dbg(pdata, "ns_tab idx=%d, %02x:%02x:%02x:%02x:%02x:%02x\n",
+	       ns_offload_tab_idx, mac_addr[0], mac_addr[1], mac_addr[2],
+	       mac_addr[3], mac_addr[4], mac_addr[5]);
+
+	memset(remote_addr, 0, 16);
+	fxgmac_set_ns_offload(pdata, ns_offload_tab_idx++, remote_addr,
+			      solicited_addr, target_addr1, target_addr1,
+			      mac_addr);
+
+	if (ns_offload_tab_idx >= NS_OFFLOAD_TAB_MAX_IDX)
+		ns_offload_tab_idx = 0;
+}
+
+static inline void fxgmac_enable_ns_offload(struct fxgmac_pdata *pdata)
+{
+	wr32_mem(pdata, 0X00000011, NS_OF_GLB_CTL);
+}
+
+static int fxgmac_check_wake_pattern_fifo_pointer(struct fxgmac_pdata *pdata)
+{
+	int ret = 0;
+	u32 val;
+
+	val = rd32_mac(pdata, MAC_PMT_STA);
+	fxgmac_set_bits(&val, MAC_PMT_STA_RWKFILTERST_POS,
+			MAC_PMT_STA_RWKFILTERST_LEN, 1);
+	wr32_mac(pdata, val, MAC_PMT_STA);
+
+	val = rd32_mac(pdata, MAC_PMT_STA);
+	val = FXGMAC_GET_BITS(val, MAC_PMT_STA_RWKPTR_POS,
+			      MAC_PMT_STA_RWKPTR_LEN);
+	if (val != 0) {
+		yt_err(pdata, "Remote fifo pointer is not 0\n");
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static int fxgmac_set_wake_pattern_mask(struct fxgmac_pdata *pdata,
+					u32 filter_index, u8 register_index,
+					u32 data)
+{
+	const u16 address_offset[16][3] = {
+		{0x1020, 0x1024, 0x1028},
+		{0x102c, 0x1030, 0x1034},
+		{0x1038, 0x103c, 0x1040},
+		{0x1044, 0x1050, 0x1054},
+		{0x1058, 0x105c, 0x1060},
+		{0x1064, 0x1068, 0x106c},
+		{0x1070, 0x1074, 0x1078},
+		{0x107c, 0x1080, 0x1084},
+		{0x1088, 0x108c, 0x1090},
+		{0x1134, 0x113c, 0x1140},
+		{0x1208, 0x1200, 0x1204},
+		{0x1218, 0x1210, 0x1214},
+		{0x1228, 0x1220, 0x1224},
+		{0x1238, 0x1230, 0x1234},
+		{0x1248, 0x1240, 0x1244},
+		{0x1258, 0x1250, 0x1254},
+	};
+	if (filter_index > 15 || register_index > 2) {
+		yt_err(pdata,
+		       "%s, xx is over range, filter:%d, register:0x%x\n",
+		       __func__, filter_index, register_index);
+		return -EINVAL;
+	}
+	wr32_mem(pdata, data, address_offset[filter_index][register_index]);
+	return 0;
+}
+
+union type16 {
+	u16 raw;
+	struct {
+		u16 bit_0 : 1;
+		u16 bit_1 : 1;
+		u16 bit_2 : 1;
+		u16 bit_3 : 1;
+		u16 bit_4 : 1;
+		u16 bit_5 : 1;
+		u16 bit_6 : 1;
+		u16 bit_7 : 1;
+		u16 bit_8 : 1;
+		u16 bit_9 : 1;
+		u16 bit_10 : 1;
+		u16 bit_11 : 1;
+		u16 bit_12 : 1;
+		u16 bit_13 : 1;
+		u16 bit_14 : 1;
+		u16 bit_15 : 1;
+	} bits;
+};
+
+union type8 {
+	u16 raw;
+	struct {
+		u16 bit_0 : 1;
+		u16 bit_1 : 1;
+		u16 bit_2 : 1;
+		u16 bit_3 : 1;
+		u16 bit_4 : 1;
+		u16 bit_5 : 1;
+		u16 bit_6 : 1;
+		u16 bit_7 : 1;
+	} bits;
+};
+
+static u16 wol_crc16(u8 *pucframe, u16 uslen)
+{
+	union type16 crc, crc_comb;
+	union type8 next_crc, rrpe_data;
+
+	next_crc.raw = 0;
+	crc.raw = 0xffff;
+	for (u32 i = 0; i < uslen; i++) {
+		rrpe_data.raw = pucframe[i];
+		next_crc.bits.bit_0 = crc.bits.bit_15 ^ rrpe_data.bits.bit_0;
+		next_crc.bits.bit_1 = crc.bits.bit_14 ^ next_crc.bits.bit_0 ^
+				      rrpe_data.bits.bit_1;
+		next_crc.bits.bit_2 = crc.bits.bit_13 ^ next_crc.bits.bit_1 ^
+				      rrpe_data.bits.bit_2;
+		next_crc.bits.bit_3 = crc.bits.bit_12 ^ next_crc.bits.bit_2 ^
+				      rrpe_data.bits.bit_3;
+		next_crc.bits.bit_4 = crc.bits.bit_11 ^ next_crc.bits.bit_3 ^
+				      rrpe_data.bits.bit_4;
+		next_crc.bits.bit_5 = crc.bits.bit_10 ^ next_crc.bits.bit_4 ^
+				      rrpe_data.bits.bit_5;
+		next_crc.bits.bit_6 = crc.bits.bit_9 ^ next_crc.bits.bit_5 ^
+				      rrpe_data.bits.bit_6;
+		next_crc.bits.bit_7 = crc.bits.bit_8 ^ next_crc.bits.bit_6 ^
+				      rrpe_data.bits.bit_7;
+
+		crc_comb.bits.bit_15 = crc.bits.bit_7 ^ next_crc.bits.bit_7;
+		crc_comb.bits.bit_14 = crc.bits.bit_6;
+		crc_comb.bits.bit_13 = crc.bits.bit_5;
+		crc_comb.bits.bit_12 = crc.bits.bit_4;
+		crc_comb.bits.bit_11 = crc.bits.bit_3;
+		crc_comb.bits.bit_10 = crc.bits.bit_2;
+		crc_comb.bits.bit_9 = crc.bits.bit_1 ^ next_crc.bits.bit_0;
+		crc_comb.bits.bit_8 = crc.bits.bit_0 ^ next_crc.bits.bit_1;
+		crc_comb.bits.bit_7 = next_crc.bits.bit_0 ^ next_crc.bits.bit_2;
+		crc_comb.bits.bit_6 = next_crc.bits.bit_1 ^ next_crc.bits.bit_3;
+		crc_comb.bits.bit_5 = next_crc.bits.bit_2 ^ next_crc.bits.bit_4;
+		crc_comb.bits.bit_4 = next_crc.bits.bit_3 ^ next_crc.bits.bit_5;
+		crc_comb.bits.bit_3 = next_crc.bits.bit_4 ^ next_crc.bits.bit_6;
+		crc_comb.bits.bit_2 = next_crc.bits.bit_5 ^ next_crc.bits.bit_7;
+		crc_comb.bits.bit_1 = next_crc.bits.bit_6;
+		crc_comb.bits.bit_0 = next_crc.bits.bit_7;
+		crc.raw = crc_comb.raw;
+	}
+	return crc.raw;
+}
+
+static inline void __write_filter(struct fxgmac_pdata *pdata, u8 i, u8 n)
+{
+	u8 *mask = &pdata->pattern[i * 4 + n].mask_info[0];
+	u32 val;
+
+	val = (mask[3] & 0x7f << 24) | (mask[2] << 16) | (mask[1] << 8) |
+	      (mask[0] << 0);
+
+	wr32_mac(pdata, val, MAC_RWK_PAC);
+}
+
+static inline u32 __set_filter_addr_type(struct fxgmac_pdata *pdata, u8 i, u8 n,
+					 u32 total_cnt, u32 pattern_cnt)
+{
+	struct wol_bitmap_pattern *pattern = &pdata->pattern[i * 4 + n];
+	u32 val;
+
+	/* Set filter enable bit. */
+	val = ((i * 4 + n) < total_cnt) ? (0x1 << 8 * n) : 0x0;
+
+	/* Set filter address type, 0- unicast, 1 - multicast. */
+	val |= (i * 4 + n >= total_cnt)		 ? 0x0 :
+	       (i * 4 + n >= pattern_cnt)	 ? (0x1 << (3 + 8 * n)) :
+	       pattern->pattern_offset		 ? 0x0 :
+	       !(pattern->mask_info[0] & 0x01)	 ? 0x0 :
+	       (pattern->pattern_info[0] & 0x01) ? (0x1 << (3 + 8 * n)) :
+							 0x0;
+	return val;
+}
+
+static inline u32 __wake_pattern_mask_val(struct wol_bitmap_pattern *pattern,
+					  u8 n)
+{
+	u8 *mask = &pattern->mask_info[n * 4];
+	u32 val;
+
+	val = ((mask[7] & 0x7f) << (24 + 1)) | (mask[6] << (16 + 1)) |
+	      (mask[5] << (8 + 1)) | (mask[4] << (0 + 1)) |
+	      ((mask[3] & 0x80) >> 7);
+
+	return val;
+}
+
+static int fxgmac_set_wake_pattern(struct fxgmac_pdata *pdata,
+				   struct wol_bitmap_pattern *wol_pattern,
+				   u32 pattern_cnt)
+{
+	u32 total_cnt = 0, inherited_cnt = 0, val;
+	struct wol_bitmap_pattern *pattern;
+	u16 map_index, mask_index;
+	u8 mask[MAX_PATTERN_SIZE];
+	u32 i, j, z;
+
+	if (pattern_cnt > MAX_PATTERN_COUNT) {
+		yt_err(pdata, "%s, %d patterns exceed %d, not supported!\n",
+		       __func__, pattern_cnt, MAX_PATTERN_COUNT);
+		return -EINVAL;
+	}
+
+	/* Reset the FIFO head pointer. */
+	if (fxgmac_check_wake_pattern_fifo_pointer(pdata)) {
+		yt_err(pdata, "%s, remote pattern array pointer is not be 0\n",
+		       __func__);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < pattern_cnt; i++) {
+		pattern = &pdata->pattern[i];
+		memcpy(pattern, wol_pattern + i, sizeof(wol_pattern[0]));
+
+		if (pattern_cnt + inherited_cnt >= MAX_PATTERN_COUNT)
+			continue;
+
+		if (wol_pattern[i].pattern_offset ||
+		    !(wol_pattern[i].mask_info[0] & 0x01)) {
+			pattern = &pdata->pattern[pattern_cnt + inherited_cnt];
+			memcpy(pattern, wol_pattern + i,
+			       sizeof(wol_pattern[0]));
+			inherited_cnt++;
+		}
+	}
+	total_cnt = pattern_cnt + inherited_cnt;
+
+	/* calculate the crc-16 of the mask pattern */
+	for (i = 0; i < total_cnt; i++) {
+		/* Please program pattern[i] to NIC for pattern match wakeup.
+		 * pattern_size, pattern_info, mask_info
+		 */
+		mask_index = 0;
+		map_index = 0;
+		pattern = &pdata->pattern[i];
+		for (j = 0; j < pattern->mask_size; j++) {
+			for (z = 0;
+			     z < ((j == (MAX_PATTERN_SIZE / 8 - 1)) ? 7 : 8);
+			     z++) {
+				if (pattern->mask_info[j] & (0x01 << z)) {
+					mask[map_index] =
+						pattern->pattern_info
+							[pattern->pattern_offset +
+							 mask_index];
+					map_index++;
+				}
+				mask_index++;
+			}
+		}
+		/* calculate  the crc-16 of the mask pattern */
+		pattern->pattern_crc = wol_crc16(mask, map_index);
+		memset(mask, 0, sizeof(mask));
+	}
+
+	/* Write patterns by FIFO block. */
+	for (i = 0; i < (total_cnt + 3) / 4; i++) {
+		/* 1. Write the first 4Bytes of Filter. */
+		__write_filter(pdata, i, 0);
+		__write_filter(pdata, i, 1);
+		__write_filter(pdata, i, 2);
+		__write_filter(pdata, i, 3);
+
+		/* 2. Write the Filter Command. */
+		val = 0;
+		val |= __set_filter_addr_type(pdata, i, 0, total_cnt,
+					      pattern_cnt);
+		val |= __set_filter_addr_type(pdata, i, 1, total_cnt,
+					      pattern_cnt);
+		val |= __set_filter_addr_type(pdata, i, 2, total_cnt,
+					      pattern_cnt);
+		val |= __set_filter_addr_type(pdata, i, 3, total_cnt,
+					      pattern_cnt);
+		wr32_mac(pdata, val, MAC_RWK_PAC);
+
+		/* 3. Write the mask offset. */
+		val = (pdata->pattern[i * 4 + 3].pattern_offset << 24) |
+		      (pdata->pattern[i * 4 + 2].pattern_offset << 16) |
+		      (pdata->pattern[i * 4 + 1].pattern_offset << 8) |
+		      (pdata->pattern[i * 4 + 0].pattern_offset << 0);
+		wr32_mac(pdata, val, MAC_RWK_PAC);
+
+		/* 4. Write the masked data CRC. */
+		val = (pdata->pattern[i * 4 + 1].pattern_crc << 16) |
+		      (pdata->pattern[i * 4 + 0].pattern_crc << 0);
+		wr32_mac(pdata, val, MAC_RWK_PAC);
+		val = (pdata->pattern[i * 4 + 3].pattern_crc << 16) |
+		      (pdata->pattern[i * 4 + 2].pattern_crc << 0);
+		wr32_mac(pdata, val, MAC_RWK_PAC);
+	}
+
+	for (i = 0; i < total_cnt; i++) {
+		/* global  manager  regitster  mask bit 31~62 */
+		pattern = &pdata->pattern[i];
+		val = __wake_pattern_mask_val(pattern, 0);
+		fxgmac_set_wake_pattern_mask(pdata, i, 0, val);
+
+		/* global  manager  regitster  mask bit 63~94 */
+		val = __wake_pattern_mask_val(pattern, 1);
+		fxgmac_set_wake_pattern_mask(pdata, i, 1, val);
+
+		/* global  manager regitster  mask bit 95~126 */
+		val = __wake_pattern_mask_val(pattern, 2);
+		fxgmac_set_wake_pattern_mask(pdata, i, 2, val);
+	}
+
+	return 0;
+}
+
+static void fxgmac_enable_wake_pattern(struct fxgmac_pdata *pdata)
+{
+	u32 val;
+
+	val = rd32_mac(pdata, MAC_PMT_STA);
+	fxgmac_set_bits(&val, MAC_PMT_STA_RWKFILTERST_POS,
+			MAC_PMT_STA_RWKFILTERST_LEN, 1);
+	fxgmac_set_bits(&val, MAC_PMT_STA_RWKPKTEN_POS,
+			MAC_PMT_STA_RWKPKTEN_LEN, 1);
+	wr32_mac(pdata, val, MAC_PMT_STA);
+
+	val = rd32_mem(pdata, WOL_CTRL);
+	fxgmac_set_bits(&val, WOL_PKT_EN_POS, WOL_PKT_EN_LEN, 1);
+	wr32_mem(pdata, val, WOL_CTRL);
+}
+
+static void fxgmac_disable_wake_pattern(struct fxgmac_pdata *pdata)
+{
+	u32 val;
+
+	val = rd32_mac(pdata, MAC_PMT_STA);
+	fxgmac_set_bits(&val, MAC_PMT_STA_RWKFILTERST_POS,
+			MAC_PMT_STA_RWKFILTERST_LEN, 1);
+	fxgmac_set_bits(&val, MAC_PMT_STA_RWKPKTEN_POS,
+			MAC_PMT_STA_RWKPKTEN_LEN, 0);
+	wr32_mac(pdata, val, MAC_PMT_STA);
+
+	val = rd32_mem(pdata, WOL_CTRL);
+	fxgmac_set_bits(&val, WOL_PKT_EN_POS, WOL_PKT_EN_LEN, 0);
+	wr32_mem(pdata, val, WOL_CTRL);
+}
+
+static void fxgmac_enable_wake_magic_pattern(struct fxgmac_pdata *pdata)
+{
+	struct pci_dev *pdev = to_pci_dev(pdata->dev);
+	u32 val;
+
+	val = rd32_mac(pdata, MAC_PMT_STA);
+	fxgmac_set_bits(&val, MAC_PMT_STA_MGKPKTEN_POS,
+			MAC_PMT_STA_MGKPKTEN_LEN, 1);
+	wr32_mac(pdata, val, MAC_PMT_STA);
+
+	val = rd32_mem(pdata, WOL_CTRL);
+	fxgmac_set_bits(&val, WOL_PKT_EN_POS, WOL_PKT_EN_LEN, 1);
+	wr32_mem(pdata, val, WOL_CTRL);
+
+	/* Enable PME Enable Bit. */
+	pci_read_config_dword(pdev, PCI_PM_STATCTRL, &val);
+	fxgmac_set_bits(&val, PM_CTRLSTAT_PME_EN_POS, PM_CTRLSTAT_PME_EN_LEN,
+			1);
+	pci_write_config_dword(pdev, PCI_PM_STATCTRL, val);
+}
+
+static void fxgmac_disable_wake_magic_pattern(struct fxgmac_pdata *pdata)
+{
+	u32 val;
+
+	val = rd32_mem(pdata, WOL_CTRL);
+	fxgmac_set_bits(&val, WOL_PKT_EN_POS, WOL_PKT_EN_LEN, 0);
+	wr32_mem(pdata, val, WOL_CTRL);
+
+	val = rd32_mac(pdata, MAC_PMT_STA);
+	fxgmac_set_bits(&val, MAC_PMT_STA_MGKPKTEN_POS,
+			MAC_PMT_STA_MGKPKTEN_LEN, 0);
+	wr32_mac(pdata, val, MAC_PMT_STA);
+}
+
+static void fxgmac_enable_wake_packet_indication(struct fxgmac_pdata *pdata,
+						 int en)
+{
+	u32 val_wpi_crtl0;
+
+	rd32_mem(pdata, MGMT_WOL_CTRL); /* read-clear WoL event. */
+
+	/* prepare to write packet data by write wpi_mode to 1 */
+	val_wpi_crtl0 = rd32_mem(pdata, MGMT_WPI_CTRL0);
+	fxgmac_set_bits(&val_wpi_crtl0, MGMT_WPI_CTRL0_WPI_MODE_POS,
+			MGMT_WPI_CTRL0_WPI_MODE_LEN,
+			(en ? MGMT_WPI_CTRL0_WPI_MODE_WR :
+				    MGMT_WPI_CTRL0_WPI_MODE_NORMAL));
+	wr32_mem(pdata, val_wpi_crtl0, MGMT_WPI_CTRL0);
+
+	yt_dbg(pdata, "%s - WPI pkt enable=%d, reg=%08x.\n", __func__, en,
+	       val_wpi_crtl0);
+}
+
+static void fxgmac_enable_wake_link_change(struct fxgmac_pdata *pdata)
+{
+	u32 val;
+
+	val = rd32_mem(pdata, WOL_CTRL);
+	fxgmac_set_bits(&val, WOL_LINKCHG_EN_POS, WOL_LINKCHG_EN_LEN, 1);
+	wr32_mem(pdata, val, WOL_CTRL);
+}
+
+static void fxgmac_disable_wake_link_change(struct fxgmac_pdata *pdata)
+{
+	u32 val;
+
+	val = rd32_mem(pdata, WOL_CTRL);
+	fxgmac_set_bits(&val, WOL_LINKCHG_EN_POS, WOL_LINKCHG_EN_LEN, 0);
+	wr32_mem(pdata, val, WOL_CTRL);
+}
+
+static void fxgmac_enable_dma_interrupts(struct fxgmac_pdata *pdata)
+{
+	struct fxgmac_channel *channel = pdata->channel_head;
+	unsigned int dma_ch;
+
+	for (u32 i = 0; i < pdata->channel_count; i++, channel++) {
+		/* Clear all the interrupts which are set */
+		dma_ch = readl(FXGMAC_DMA_REG(channel, DMA_CH_SR));
+		writel(dma_ch, FXGMAC_DMA_REG(channel, DMA_CH_SR));
+
+		dma_ch = 0; /* Clear all interrupt enable bits */
+
+		/* Enable following interrupts
+		 * NIE  - Normal Interrupt Summary Enable
+		 * FBEE - Fatal Bus Error Enable
+		 */
+		fxgmac_set_bits(&dma_ch, DMA_CH_IER_NIE_POS, DMA_CH_IER_NIE_LEN,
+				1);
+		fxgmac_set_bits(&dma_ch, DMA_CH_IER_FBEE_POS,
+				DMA_CH_IER_FBEE_LEN, 1);
+
+		if (channel->tx_ring) {
+			/* Enable the following Tx interrupts
+			 * TIE  - Transmit Interrupt Enable (unless using
+			 * per channel interrupts)
+			 */
+			if (!pdata->per_channel_irq)
+				fxgmac_set_bits(&dma_ch, DMA_CH_IER_TIE_POS,
+						DMA_CH_IER_TIE_LEN, 1);
+			if (FXGMAC_IS_CHANNEL_WITH_TX_IRQ(i) &&
+			    pdata->per_channel_irq) {
+				fxgmac_set_bits(&dma_ch, DMA_CH_IER_TIE_POS,
+						DMA_CH_IER_TIE_LEN, 1);
+			}
+		}
+		if (channel->rx_ring) {
+			/* Enable following Rx interrupts
+			 * RBUE - Receive Buffer Unavailable Enable
+			 * RIE  - Receive Interrupt Enable (unless using
+			 * per channel interrupts)
+			 */
+			fxgmac_set_bits(&dma_ch, DMA_CH_IER_RBUE_POS,
+					DMA_CH_IER_RBUE_LEN, 1);
+			fxgmac_set_bits(&dma_ch, DMA_CH_IER_RIE_POS,
+					DMA_CH_IER_RIE_LEN, 1);
+		}
+
+		writel(dma_ch, FXGMAC_DMA_REG(channel, DMA_CH_IER));
+	}
+}
+
+static void fxgmac_enable_mtl_interrupts(struct fxgmac_pdata *pdata)
+{
+	unsigned int mtl_q_isr, q_count;
+
+	q_count = max(pdata->hw_feat.tx_q_cnt, pdata->hw_feat.rx_q_cnt);
+	for (u32 i = 0; i < q_count; i++) {
+		/* Clear all the interrupts which are set */
+		mtl_q_isr = readl(FXGMAC_MTL_REG(pdata, i, MTL_Q_ISR));
+		writel(mtl_q_isr, FXGMAC_MTL_REG(pdata, i, MTL_Q_ISR));
+
+		/* No MTL interrupts to be enabled */
+		writel(0, FXGMAC_MTL_REG(pdata, i, MTL_Q_IER));
+	}
+}
+
+#define FXGMAC_MMC_IER_ALL_DEFAULT 0
+
+static void fxgmac_enable_mac_interrupts(struct fxgmac_pdata *pdata)
+{
+	unsigned int ier = 0;
+	u32 val;
+
+	/* Enable Timestamp interrupt */
+	fxgmac_set_bits(&ier, MAC_IER_TSIE_POS, MAC_IER_TSIE_LEN, 1);
+	wr32_mac(pdata, ier, MAC_IER);
+
+	val = rd32_mac(pdata, MMC_RIER);
+	fxgmac_set_bits(&val, MMC_RIER_ALL_INTERRUPTS_POS,
+			MMC_RIER_ALL_INTERRUPTS_LEN,
+			FXGMAC_MMC_IER_ALL_DEFAULT);
+	wr32_mac(pdata, val, MMC_RIER);
+
+	val = rd32_mac(pdata, MMC_TIER);
+	fxgmac_set_bits(&val, MMC_TIER_ALL_INTERRUPTS_POS,
+			MMC_TIER_ALL_INTERRUPTS_LEN,
+			FXGMAC_MMC_IER_ALL_DEFAULT);
+	wr32_mac(pdata, val, MMC_TIER);
+}
+
+static void fxgmac_set_fxgmii_1000_speed(struct fxgmac_pdata *pdata)
+{
+	u32 val;
+
+	val = rd32_mac(pdata, MAC_CR);
+	fxgmac_set_bits(&val, MAC_CR_PS_POS, MAC_CR_PS_LEN, 0);
+	fxgmac_set_bits(&val, MAC_CR_FES_POS, MAC_CR_FES_LEN, 0);
+	fxgmac_set_bits(&val, MAC_CR_DM_POS, MAC_CR_DM_LEN, pdata->phy_duplex);
+	wr32_mac(pdata, val, MAC_CR);
+}
+
+static void fxgmac_set_fxgmii_100_speed(struct fxgmac_pdata *pdata)
+{
+	u32 val;
+
+	val = rd32_mac(pdata, MAC_CR);
+	fxgmac_set_bits(&val, MAC_CR_PS_POS, MAC_CR_PS_LEN, 1);
+	fxgmac_set_bits(&val, MAC_CR_FES_POS, MAC_CR_FES_LEN, 1);
+	fxgmac_set_bits(&val, MAC_CR_DM_POS, MAC_CR_DM_LEN, pdata->phy_duplex);
+	wr32_mac(pdata, val, MAC_CR);
+}
+
+static void fxgmac_set_fxgmii_10_speed(struct fxgmac_pdata *pdata)
+{
+	u32 val;
+
+	val = rd32_mac(pdata, MAC_CR);
+	fxgmac_set_bits(&val, MAC_CR_PS_POS, MAC_CR_PS_LEN, 1);
+	fxgmac_set_bits(&val, MAC_CR_FES_POS, MAC_CR_FES_LEN, 0);
+	fxgmac_set_bits(&val, MAC_CR_DM_POS, MAC_CR_DM_LEN, pdata->phy_duplex);
+	wr32_mac(pdata, val, MAC_CR);
+}
+
+static void fxgmac_config_mac_speed(struct fxgmac_pdata *pdata)
+{
+	switch (pdata->phy_speed) {
+	case SPEED_1000:
+		fxgmac_set_fxgmii_1000_speed(pdata);
+		break;
+	case SPEED_100:
+		fxgmac_set_fxgmii_100_speed(pdata);
+		break;
+	case SPEED_10:
+		fxgmac_set_fxgmii_10_speed(pdata);
+		break;
+	}
+}
+
+#define PHY_WR_BASE	0x8000205
+#define PHY_RD_BASE	0x800020d
+#define PHY_REG_BIT	16
+int fxgmac_phy_write_reg(struct fxgmac_pdata *pdata, u32 reg_id, u32 data)
+{
+	u32 val, mdioctrl = PHY_WR_BASE + (reg_id << PHY_REG_BIT);
+	int try_cnt = PHY_MDIO_MAX_TRY;
+
+	wr32_mac(pdata, data, MAC_MDIO_DATA);
+	wr32_mac(pdata, mdioctrl, MAC_MDIO_ADDRESS);
+	do {
+		val = rd32_mac(pdata, MAC_MDIO_ADDRESS);
+		try_cnt--;
+	} while ((val & MAC_MDIO_ADDR_BUSY) && (try_cnt));
+
+	yt_dbg(pdata, "%s, id:%d %s, ctrl:0x%08x, data:0x%08x\n", __func__,
+	       reg_id, (val & 0x1) ? "err" : "ok", val, data);
+
+	return (val & MAC_MDIO_ADDR_BUSY) ? -ETIMEDOUT : 0;
+}
+
+int fxgmac_phy_read_reg(struct fxgmac_pdata *pdata, u32 reg_id, u32 *data)
+{
+	u32 val, mdioctrl = PHY_RD_BASE + (reg_id << PHY_REG_BIT);
+	int try_cnt = PHY_MDIO_MAX_TRY;
+
+	wr32_mac(pdata, mdioctrl, MAC_MDIO_ADDRESS);
+	do {
+		val = rd32_mac(pdata, MAC_MDIO_ADDRESS);
+		try_cnt--;
+	} while ((val & MAC_MDIO_ADDR_BUSY) && (try_cnt));
+
+	if (0 == (val & MAC_MDIO_ADDR_BUSY)) {
+		val = rd32_mac(pdata, MAC_MDIO_DATA);
+		if (data)
+			*data = val;
+		return 0;
+	}
+
+	yt_err(pdata, "%s, id:0x%02x err, try_cnt:%d, ctrl:0x%08x.\n", __func__,
+	       reg_id, try_cnt, mdioctrl);
+
+	return -ETIMEDOUT;
+}
+
+static int fxgmac_config_flow_control(struct fxgmac_pdata *pdata)
+{
+	u32 val = 0;
+	int ret;
+
+	fxgmac_config_tx_flow_control(pdata);
+	fxgmac_config_rx_flow_control(pdata);
+
+	/* set auto negotiation advertisement pause ability */
+
+	if (pdata->tx_pause || pdata->rx_pause)
+		val |= ADVERTISE_PAUSE_CAP | ADVERTISE_PAUSE_ASYM;
+
+	ret = fxgmac_phy_modify_reg(pdata, MII_ADVERTISE,
+				    ADVERTISE_PAUSE_CAP | ADVERTISE_PAUSE_ASYM,
+				    val);
+	if (ret < 0)
+		return ret;
+
+	return fxgmac_phy_modify_reg(pdata, MII_BMCR, BMCR_RESET, BMCR_RESET);
+}
+
+int fxgmac_phy_config(struct fxgmac_pdata *pdata)
+{
+	struct fxphy_ag_adv phy_ag_adv;
+
+	if (pdata->phy_autoeng)
+		phy_ag_adv.auto_neg_en = 1;
+	else
+		phy_ag_adv.auto_neg_en = 0;
+
+	switch (pdata->phy_speed) {
+	case SPEED_1000:
+		phy_ag_adv.full_1000m = 1, phy_ag_adv.half_1000m = 0,
+		phy_ag_adv.full_100m = 1, phy_ag_adv.half_100m = 1,
+		phy_ag_adv.full_10m = 1, phy_ag_adv.half_10m = 1;
+		break;
+	case SPEED_100:
+		phy_ag_adv.full_1000m = 0, phy_ag_adv.half_1000m = 0;
+		if (pdata->phy_duplex)
+			phy_ag_adv.full_100m = 1;
+		else
+			phy_ag_adv.full_100m = 0;
+
+		phy_ag_adv.half_100m = 1, phy_ag_adv.full_10m = 1,
+		phy_ag_adv.half_10m = 1;
+		break;
+	case SPEED_10:
+		phy_ag_adv.full_1000m = 0;
+		phy_ag_adv.half_1000m = 0;
+		phy_ag_adv.full_100m = 0;
+		phy_ag_adv.half_100m = 0;
+		if (pdata->phy_duplex)
+			phy_ag_adv.full_10m = 1;
+		else
+			phy_ag_adv.full_10m = 0;
+
+		phy_ag_adv.half_10m = 1;
+		break;
+	default:
+		break;
+	}
+	return fxgmac_phy_set_autoneg_advertise(pdata, phy_ag_adv);
+}
+
+void fxgmac_phy_reset(struct fxgmac_pdata *pdata)
+{
+	u32 val = 0;
+
+	fxgmac_set_bits(&val, EPHY_CTRL_RESET_POS, EPHY_CTRL_RESET_LEN,
+			EPHY_CTRL_STA_RESET);
+	wr32_mem(pdata, val, EPHY_CTRL);
+	usleep_range(1500, 1600);
+}
+
+int fxgmac_phy_release(struct fxgmac_pdata *pdata)
+{
+	u32 val = 0;
+	int ret;
+
+	fxgmac_set_bits(&val, EPHY_CTRL_RESET_POS, EPHY_CTRL_RESET_LEN,
+			EPHY_CTRL_STA_RELEASE);
+	wr32_mem(pdata, val, EPHY_CTRL);
+	usleep_range(100, 150);
+	val = rd32_mem(pdata, EPHY_CTRL);
+	yt_dbg(pdata, "EPHY_CTRL: 0x%x\n", val);
+
+	ret = fxgmac_phy_modify_reg(pdata, PHY_SPEC_CTRL, PHY_SPEC_CTRL_CRS_ON,
+				    PHY_SPEC_CTRL_CRS_ON);
+	if (ret < 0)
+		return ret;
+
+	ret = fxgmac_phy_modify_ext_reg(pdata, PHY_EXT_ANALOG_CFG3,
+					PHY_EXT_ANALOG_CFG3_ADC_START_CFG, 0);
+	if (ret < 0)
+		return ret;
+
+	ret = fxgmac_phy_write_ext_reg(pdata, PHY_EXT_ANALOG_CFG2,
+				       PHY_EXT_ANALOG_CFG2_VAL);
+	if (ret < 0)
+		return ret;
+
+	return fxgmac_phy_write_ext_reg(pdata, PHY_EXT_ANALOG_CFG8,
+					PHY_EXT_ANALOG_CFG8_VAL);
+}
+
+static void fxgmac_enable_channel_irq(struct fxgmac_channel *channel,
+				      enum fxgmac_int int_id)
+{
+	unsigned int dma_ch_ier = readl(FXGMAC_DMA_REG(channel, DMA_CH_IER));
+
+	switch (int_id) {
+	case FXGMAC_INT_DMA_CH_SR_TI:
+		fxgmac_set_bits(&dma_ch_ier, DMA_CH_IER_TIE_POS,
+				DMA_CH_IER_TIE_LEN, 1);
+		break;
+	case FXGMAC_INT_DMA_CH_SR_TPS:
+		fxgmac_set_bits(&dma_ch_ier, DMA_CH_IER_TXSE_POS,
+				DMA_CH_IER_TXSE_LEN, 1);
+		break;
+	case FXGMAC_INT_DMA_CH_SR_TBU:
+		fxgmac_set_bits(&dma_ch_ier, DMA_CH_IER_TBUE_POS,
+				DMA_CH_IER_TBUE_LEN, 1);
+		break;
+	case FXGMAC_INT_DMA_CH_SR_RI:
+		fxgmac_set_bits(&dma_ch_ier, DMA_CH_IER_RIE_POS,
+				DMA_CH_IER_RIE_LEN, 1);
+		break;
+	case FXGMAC_INT_DMA_CH_SR_RBU:
+		fxgmac_set_bits(&dma_ch_ier, DMA_CH_IER_RBUE_POS,
+				DMA_CH_IER_RBUE_LEN, 1);
+		break;
+	case FXGMAC_INT_DMA_CH_SR_RPS:
+		fxgmac_set_bits(&dma_ch_ier, DMA_CH_IER_RSE_POS,
+				DMA_CH_IER_RSE_LEN, 1);
+		break;
+	case FXGMAC_INT_DMA_CH_SR_TI_RI:
+		fxgmac_set_bits(&dma_ch_ier, DMA_CH_IER_TIE_POS,
+				DMA_CH_IER_TIE_LEN, 1);
+		fxgmac_set_bits(&dma_ch_ier, DMA_CH_IER_RIE_POS,
+				DMA_CH_IER_RIE_LEN, 1);
+		fxgmac_set_bits(&dma_ch_ier, DMA_CH_IER_NIE_POS,
+				DMA_CH_IER_NIE_LEN, 1);
+		break;
+	case FXGMAC_INT_DMA_CH_SR_FBE:
+		fxgmac_set_bits(&dma_ch_ier, DMA_CH_IER_FBEE_POS,
+				DMA_CH_IER_FBEE_LEN, 1);
+		break;
+	case FXGMAC_INT_DMA_ALL:
+		dma_ch_ier |= channel->saved_ier;
+		break;
+	default:
+		return;
+	}
+
+	writel(dma_ch_ier, FXGMAC_DMA_REG(channel, DMA_CH_IER));
+}
+
+static void fxgmac_disable_channel_irq(struct fxgmac_channel *channel,
+				       enum fxgmac_int int_id)
+{
+	unsigned int dma_ch_ier = readl(FXGMAC_DMA_REG(channel, DMA_CH_IER));
+
+	switch (int_id) {
+	case FXGMAC_INT_DMA_CH_SR_TI:
+		fxgmac_set_bits(&dma_ch_ier, DMA_CH_IER_TIE_POS,
+				DMA_CH_IER_TIE_LEN, 0);
+		break;
+	case FXGMAC_INT_DMA_CH_SR_TPS:
+		fxgmac_set_bits(&dma_ch_ier, DMA_CH_IER_TXSE_POS,
+				DMA_CH_IER_TXSE_LEN, 0);
+		break;
+	case FXGMAC_INT_DMA_CH_SR_TBU:
+		fxgmac_set_bits(&dma_ch_ier, DMA_CH_IER_TBUE_POS,
+				DMA_CH_IER_TBUE_LEN, 0);
+		break;
+	case FXGMAC_INT_DMA_CH_SR_RI:
+		fxgmac_set_bits(&dma_ch_ier, DMA_CH_IER_RIE_POS,
+				DMA_CH_IER_RIE_LEN, 0);
+		break;
+	case FXGMAC_INT_DMA_CH_SR_RBU:
+		fxgmac_set_bits(&dma_ch_ier, DMA_CH_IER_RBUE_POS,
+				DMA_CH_IER_RBUE_LEN, 0);
+		break;
+	case FXGMAC_INT_DMA_CH_SR_RPS:
+		fxgmac_set_bits(&dma_ch_ier, DMA_CH_IER_RSE_POS,
+				DMA_CH_IER_RSE_LEN, 0);
+		break;
+	case FXGMAC_INT_DMA_CH_SR_TI_RI:
+		fxgmac_set_bits(&dma_ch_ier, DMA_CH_IER_TIE_POS,
+				DMA_CH_IER_TIE_LEN, 0);
+		fxgmac_set_bits(&dma_ch_ier, DMA_CH_IER_RIE_POS,
+				DMA_CH_IER_RIE_LEN, 0);
+		fxgmac_set_bits(&dma_ch_ier, DMA_CH_IER_NIE_POS,
+				DMA_CH_IER_NIE_LEN, 0);
+		break;
+	case FXGMAC_INT_DMA_CH_SR_FBE:
+		fxgmac_set_bits(&dma_ch_ier, DMA_CH_IER_FBEE_POS,
+				DMA_CH_IER_FBEE_LEN, 0);
+		break;
+	case FXGMAC_INT_DMA_ALL:
+#define FXGMAC_DMA_INTERRUPT_MASK 0x31c7
+		channel->saved_ier = dma_ch_ier & FXGMAC_DMA_INTERRUPT_MASK;
+		dma_ch_ier &= ~FXGMAC_DMA_INTERRUPT_MASK;
+		break;
+	default:
+		return;
+	}
+
+	writel(dma_ch_ier, FXGMAC_DMA_REG(channel, DMA_CH_IER));
+}
+
+static void fxgmac_dismiss_all_int(struct fxgmac_pdata *pdata)
+{
+	struct fxgmac_channel *channel = pdata->channel_head;
+	unsigned int q_count;
+	u32 val, i;
+
+	for (i = 0; i < pdata->channel_count; i++, channel++) {
+		/* Clear all the interrupts which are set */
+		val = readl(FXGMAC_DMA_REG(channel, DMA_CH_SR));
+		writel(val, FXGMAC_DMA_REG(channel, DMA_CH_SR));
+	}
+
+	q_count = max(pdata->hw_feat.tx_q_cnt, pdata->hw_feat.rx_q_cnt);
+	for (i = 0; i < q_count; i++) {
+		/* Clear all the interrupts which are set */
+		val = readl(FXGMAC_MTL_REG(pdata, i, MTL_Q_ISR));
+		writel(val, FXGMAC_MTL_REG(pdata, i, MTL_Q_ISR));
+	}
+
+	rd32_mac(pdata, MAC_ISR); /* clear all MAC interrupts*/
+	/* clear MAC tx/rx error interrupts*/
+	rd32_mac(pdata, MAC_TX_RX_STA);
+	rd32_mac(pdata, MAC_PMT_STA);
+	rd32_mac(pdata, MAC_LPI_STA);
+
+	val = rd32_mac(pdata, MAC_DBG_STA);
+	wr32_mac(pdata, val, MAC_DBG_STA); /* write clear */
+}
+
+static void fxgmac_set_interrupt_moderation(struct fxgmac_pdata *pdata)
+{
+	u32 val = 0, time;
+
+	time = (pdata->intr_mod) ? pdata->tx_usecs : 0;
+	fxgmac_set_bits(&val, INT_MOD_TX_POS, INT_MOD_TX_LEN, time);
+
+	time = (pdata->intr_mod) ? pdata->rx_usecs : 0;
+	fxgmac_set_bits(&val, INT_MOD_RX_POS, INT_MOD_RX_LEN, time);
+	wr32_mem(pdata, val, INT_MOD);
+}
+
+static void fxgmac_enable_msix_one_irq(struct fxgmac_pdata *pdata, u32 intid)
+{
+	wr32_mem(pdata, 0, MSIX_TBL_MASK + intid * 16);
+}
+
+static void fxgmac_disable_msix_one_irq(struct fxgmac_pdata *pdata, u32 intid)
+{
+	wr32_mem(pdata, 1, MSIX_TBL_MASK + intid * 16);
+}
+
+static void fxgmac_disable_msix_irqs(struct fxgmac_pdata *pdata)
+{
+	for (u32 intid = 0; intid < MSIX_TBL_MAX_NUM; intid++)
+		fxgmac_disable_msix_one_irq(pdata, intid);
+}
+
+static void fxgmac_enable_msix_irqs(struct fxgmac_pdata *pdata)
+{
+	for (u32 intid = 0; intid < MSIX_TBL_MAX_NUM; intid++)
+		fxgmac_enable_msix_one_irq(pdata, intid);
+}
+
+static void fxgmac_enable_mgm_irq(struct fxgmac_pdata *pdata)
+{
+	u32 val = 0;
+
+	fxgmac_set_bits(&val, MGMT_INT_CTRL0_INT_MASK_POS,
+			MGMT_INT_CTRL0_INT_MASK_LEN,
+			MGMT_INT_CTRL0_INT_MASK_DISABLE);
+	wr32_mem(pdata, val, MGMT_INT_CTRL0);
+}
+
+static void fxgmac_disable_mgm_irq(struct fxgmac_pdata *pdata)
+{
+	u32 val = 0;
+
+	fxgmac_set_bits(&val, MGMT_INT_CTRL0_INT_MASK_POS,
+			MGMT_INT_CTRL0_INT_MASK_LEN,
+			MGMT_INT_CTRL0_INT_MASK_MASK);
+	wr32_mem(pdata, val, MGMT_INT_CTRL0);
+}
+
+static int fxgmac_flush_tx_queues(struct fxgmac_pdata *pdata)
+{
+	u32 val, i, count;
+
+	for (i = 0; i < pdata->tx_q_count; i++) {
+		val = readl(FXGMAC_MTL_REG(pdata, i, MTL_Q_TQOMR));
+		fxgmac_set_bits(&val, MTL_Q_TQOMR_FTQ_POS, MTL_Q_TQOMR_FTQ_LEN,
+				1);
+		writel(val, FXGMAC_MTL_REG(pdata, i, MTL_Q_TQOMR));
+		yt_dbg(pdata, "%s, reg=0x%p, val=0x%08x\n", __func__,
+		       FXGMAC_MTL_REG(pdata, i, MTL_Q_TQOMR), val);
+	}
+
+	for (i = 0; i < pdata->tx_q_count; i++) {
+		count = 2000;
+		do {
+			usleep_range(40, 50);
+			val = readl(FXGMAC_MTL_REG(pdata, i, MTL_Q_TQOMR));
+			val = FXGMAC_GET_BITS(val, MTL_Q_TQOMR_FTQ_POS,
+					      MTL_Q_TQOMR_FTQ_LEN);
+
+		} while (--count && val);
+		yt_dbg(pdata, "%s, wait... reg=0x%p, val=0x%08x\n", __func__,
+		       FXGMAC_MTL_REG(pdata, i, MTL_Q_TQOMR), val);
+
+		if (val)
+			return -EBUSY;
+	}
+
+	return 0;
+}
+
+static void fxgmac_config_dma_bus(struct fxgmac_pdata *pdata)
+{
+	u32 val;
+
+	val = rd32_mac(pdata, DMA_SBMR);
+	/* Set enhanced addressing mode */
+	fxgmac_set_bits(&val, DMA_SBMR_EAME_POS, DMA_SBMR_EAME_LEN, 1);
+
+	/* Out standing read/write requests*/
+	fxgmac_set_bits(&val, DMA_SBMR_RD_OSR_LMT_POS, DMA_SBMR_RD_OSR_LMT_LEN,
+			0x7);
+	fxgmac_set_bits(&val, DMA_SBMR_WR_OSR_LMT_POS, DMA_SBMR_WR_OSR_LMT_LEN,
+			0x7);
+
+	/* Set the System Bus mode */
+	fxgmac_set_bits(&val, DMA_SBMR_FB_POS, DMA_SBMR_FB_LEN, 0);
+	fxgmac_set_bits(&val, DMA_SBMR_BLEN_4_POS, DMA_SBMR_BLEN_4_LEN, 1);
+	fxgmac_set_bits(&val, DMA_SBMR_BLEN_8_POS, DMA_SBMR_BLEN_8_LEN, 1);
+	fxgmac_set_bits(&val, DMA_SBMR_BLEN_16_POS, DMA_SBMR_BLEN_16_LEN, 1);
+	fxgmac_set_bits(&val, DMA_SBMR_BLEN_32_POS, DMA_SBMR_BLEN_32_LEN, 1);
+	wr32_mac(pdata, val, DMA_SBMR);
+}
+
+static int fxgmac_legacy_link_speed_setting(struct fxgmac_pdata *pdata)
+{
+	unsigned int __maybe_unused val;
+	int ret;
+
+	ret = fxgmac_phy_config(pdata);
+	if (ret < 0) {
+		yt_err(pdata, "fxgmac_phy_config err.\n");
+		return ret;
+	}
+	for (u32 i = 0; i < PHY_LINK_TIMEOUT; i++) {
+		val = fxgmac_phy_get_state(pdata);
+		if ((val & EPHY_CTRL_STA_RELEASE) &&
+		    (val & EPHY_CTRL_STA_LINKUP))
+			break;
+
+		usleep_range(2000, 2100);
+	}
+
+	return fxgmac_phy_clear_interrupt(pdata);
+}
+
+static int fxgmac_pre_powerdown(struct fxgmac_pdata *pdata, bool phyloopback)
+{
+	int link, ret, speed = SPEED_10;
+	u32 val = 0;
+
+	fxgmac_disable_rx(pdata);
+
+	yt_dbg(pdata, "%s, phy and mac status update\n", __func__);
+
+	if (!phyloopback) {
+		ret = fxgmac_phy_read_reg(pdata, MII_LPA, &val);
+		if (ret < 0) {
+			yt_err(pdata, "fxgmac_phy_read_reg err.\n");
+			return ret;
+		}
+
+		if (!(val & LPA_10FULL) && !(val & LPA_10HALF))
+			speed = SPEED_100;
+
+	/* When the Linux platform enters the s4 state, it goes through the
+	 * suspend->resume->suspend process. The process of suspending again
+	 * after resume is fast, and PHY auto-negotiation is not yet complete,
+	 * so the auto-negotiation of PHY must be carried out again.
+	 */
+		val = fxgmac_phy_get_state(pdata);
+		link = FXGMAC_GET_BITS(val, EPHY_CTRL_STA_LINKUP_POS,
+				       EPHY_CTRL_STA_LINKUP_LEN);
+		if (link && speed != pdata->phy_speed) {
+			pdata->phy_speed = speed;
+			ret = fxgmac_legacy_link_speed_setting(pdata);
+			if (ret < 0) {
+				yt_err(pdata,
+				       "fxgmac_legacy_link_speed_setting err.\n");
+				return ret;
+			}
+		}
+	}
+
+	fxgmac_config_mac_speed(pdata);
+
+	/* After enable OOB_WOL from efuse, mac will loopcheck phy status,
+	 * and lead to panic sometimes. So we should disable it from powerup,
+	 * enable it from power down.
+	 */
+	val = rd32_mem(pdata, OOB_WOL_CTRL);
+	fxgmac_set_bits(&val, OOB_WOL_CTRL_DIS_POS, OOB_WOL_CTRL_DIS_LEN, 0);
+	wr32_mem(pdata, val, OOB_WOL_CTRL);
+	usleep_range(2000, 2100);
+
+	fxgmac_set_mac_address(pdata, pdata->mac_addr);
+
+	return 0;
+}
+
+static void fxgmac_config_powerdown(struct fxgmac_pdata *pdata,
+				    unsigned int wol)
+{
+	u32 val = 0;
+
+	fxgmac_disable_tx(pdata);
+	fxgmac_disable_rx(pdata);
+	fxgmac_config_wol(pdata, wol);
+
+	/* use default arp offloading feature */
+	fxgmac_update_aoe_ipv4addr(pdata, (u8 *)NULL);
+	fxgmac_enable_arp_offload(pdata);
+	fxgmac_update_ns_offload_ipv6addr(pdata, FXGMAC_NS_IFA_GLOBAL_UNICAST);
+	fxgmac_update_ns_offload_ipv6addr(pdata, FXGMAC_NS_IFA_LOCAL_LINK);
+	fxgmac_enable_ns_offload(pdata);
+	fxgmac_enable_wake_packet_indication(pdata, 1);
+
+	/* Enable MAC Rx TX */
+	val = rd32_mac(pdata, MAC_CR);
+	fxgmac_set_bits(&val, MAC_CR_RE_POS, MAC_CR_RE_LEN, 1);
+	if (pdata->hw_feat.aoe)
+		fxgmac_set_bits(&val, MAC_CR_TE_POS, MAC_CR_TE_LEN, 1);
+	wr32_mac(pdata, val, MAC_CR);
+
+	val = rd32_mem(pdata, LPW_CTRL);
+	fxgmac_set_bits(&val, LPW_CTRL_ASPM_LPW_EN_POS,
+			LPW_CTRL_ASPM_LPW_EN_LEN, 1);
+	wr32_mem(pdata, val, LPW_CTRL);
+
+	/* set gmac power down */
+	val = rd32_mac(pdata, MAC_PMT_STA);
+	fxgmac_set_bits(&val, MAC_PMT_STA_PWRDWN_POS, MAC_PMT_STA_PWRDWN_LEN,
+			1);
+	wr32_mac(pdata, val, MAC_PMT_STA);
+
+	val = rd32_mem(pdata, MGMT_SIGDET);
+	fxgmac_set_bits(&val, MGMT_SIGDET_POS, MGMT_SIGDET_LEN,
+			MGMT_SIGDET_55MV);
+	wr32_mem(pdata, val, MGMT_SIGDET);
+
+	yt_dbg(pdata, "%s, reg=0x%08x\n", __func__, val);
+}
+
+static int fxgmac_config_powerup(struct fxgmac_pdata *pdata)
+{
+	struct pci_dev *pdev = to_pci_dev(pdata->dev);
+	u32 val = 0;
+
+	/* After enable OOB_WOL from efuse, mac will loopcheck phy status,
+	 * and lead to panic sometimes.
+	 * So we should disable it from powerup, enable it from power down.
+	 */
+	val = rd32_mem(pdata, OOB_WOL_CTRL);
+	fxgmac_set_bits(&val, OOB_WOL_CTRL_DIS_POS, OOB_WOL_CTRL_DIS_LEN, 1);
+	wr32_mem(pdata, val, OOB_WOL_CTRL);
+
+	/* clear wpi mode whether or not waked by WOL, write reset value */
+	val = rd32_mem(pdata, MGMT_WPI_CTRL0);
+	fxgmac_set_bits(&val, MGMT_WPI_CTRL0_WPI_MODE_POS,
+			MGMT_WPI_CTRL0_WPI_MODE_LEN, 0);
+	wr32_mem(pdata, val, MGMT_WPI_CTRL0);
+
+	/* read pmt_status register to De-assert the pmt_intr_o */
+	val = rd32_mac(pdata, MAC_PMT_STA);
+	/* whether or not waked up by WOL, write reset value */
+	fxgmac_set_bits(&val, MAC_PMT_STA_PWRDWN_POS, MAC_PMT_STA_PWRDWN_LEN,
+			0);
+	/* write register to synchronized always-on block */
+	wr32_mac(pdata, val, MAC_PMT_STA);
+
+	/* Disable fast link mode*/
+	pci_read_config_dword(pdev, PCI_POWER_EIOS, &val);
+	fxgmac_set_bits(&val, POWER_EIOS_POS, POWER_EIOS_LEN, 0);
+	pci_write_config_dword(pdev, PCI_POWER_EIOS, val);
+
+	/* close pll in sleep mode */
+	return fxgmac_phy_modify_ext_reg(pdata, PHY_EXT_SLEEP_CONTROL1,
+					 PHY_EXT_SLEEP_CONTROL1_PLLON_IN_SLP,
+					 0);
+}
+
+static int fxgmac_suspend_txrx(struct fxgmac_pdata *pdata)
+{
+	struct fxgmac_channel *channel = pdata->channel_head;
+	int try_cnt = PHY_MDIO_MAX_TRY;
+	u32 val, i;
+
+	/* Prepare for Tx DMA channel stop */
+	for (i = 0; i < pdata->channel_count; i++, channel++) {
+		if (!channel->tx_ring)
+			break;
+
+		fxgmac_prepare_tx_stop(pdata, channel);
+	}
+
+	/* Disable each Tx DMA channel */
+	channel = pdata->channel_head;
+	for (i = 0; i < pdata->channel_count; i++, channel++) {
+		if (!channel->tx_ring)
+			break;
+
+		val = readl(FXGMAC_DMA_REG(channel, DMA_CH_TCR));
+		fxgmac_set_bits(&val, DMA_CH_TCR_ST_POS, DMA_CH_TCR_ST_LEN, 0);
+		writel(val, FXGMAC_DMA_REG(channel, DMA_CH_TCR));
+		yt_dbg(pdata, "%s, disable tx dma", __func__);
+	}
+
+	do {
+		val = rd32_mac(pdata, MAC_DBG_STA);
+		try_cnt--;
+	} while ((val & MAC_DBG_STA_TX_BUSY) && (try_cnt));
+
+	if (0 != (val & MAC_DBG_STA_TX_BUSY)) {
+		val = rd32_mac(pdata, MAC_DBG_STA);
+		yt_dbg(pdata,
+		       "warning !!! timed out waiting for Tx MAC to stop\n");
+		return -ETIMEDOUT;
+	}
+
+	/* wait empty Tx queue */
+	for (i = 0; i < pdata->tx_q_count; i++) {
+		try_cnt = PHY_MDIO_MAX_TRY;
+		do {
+			val = readl(FXGMAC_MTL_REG(pdata, i, MTL_TXQ_DEG));
+			try_cnt--;
+		} while ((val & MTL_TXQ_DEG_TX_BUSY) && (try_cnt));
+		if (0 != (val & MTL_TXQ_DEG_TX_BUSY)) {
+			val = rd32_mac(pdata, MTL_TXQ_DEG);
+			yt_err(pdata,
+			       "timed out waiting tx queue %u to empty\n", i);
+			return -ETIMEDOUT;
+		}
+	}
+
+	/* Disable MAC TxRx */
+	val = rd32_mac(pdata, MAC_CR);
+	fxgmac_set_bits(&val, MAC_CR_TE_POS, MAC_CR_TE_LEN, 0);
+	fxgmac_set_bits(&val, MAC_CR_RE_POS, MAC_CR_RE_LEN, 0);
+	wr32_mac(pdata, val, MAC_CR);
+
+	/* Prepare for Rx DMA channel stop */
+	for (i = 0; i < pdata->rx_q_count; i++)
+		fxgmac_prepare_rx_stop(pdata, i);
+
+	/* Disable each Rx DMA channel */
+	channel = pdata->channel_head;
+	for (i = 0; i < pdata->channel_count; i++, channel++) {
+		if (!channel->rx_ring)
+			break;
+
+		val = readl(FXGMAC_DMA_REG(channel, DMA_CH_RCR));
+		fxgmac_set_bits(&val, DMA_CH_RCR_SR_POS, DMA_CH_RCR_SR_LEN, 0);
+		writel(val, FXGMAC_DMA_REG(channel, DMA_CH_RCR));
+		yt_dbg(pdata, "%s, disable rx dma", __func__);
+	}
+
+	return 0;
+}
+
+#define FXGMAC_WOL_WAIT_TIME 2 /*  unit 1ms */
+
+static void fxgmac_config_wol_wait_time(struct fxgmac_pdata *pdata)
+{
+	u32 val;
+
+	val = rd32_mem(pdata, WOL_CTRL);
+	fxgmac_set_bits(&val, WOL_WAIT_TIME_POS, WOL_WAIT_TIME_LEN,
+			FXGMAC_WOL_WAIT_TIME);
+	wr32_mem(pdata, val, WOL_CTRL);
+}
+
+static int fxgmac_hw_init(struct fxgmac_pdata *pdata)
+{
+	int ret;
+
+	/* Flush Tx queues */
+	ret = fxgmac_flush_tx_queues(pdata);
+	if (ret < 0) {
+		yt_err(pdata, "%s, flush tx queue err:%d\n", __func__, ret);
+		return ret;
+	}
+
+	/* Initialize DMA related features */
+	fxgmac_config_dma_bus(pdata);
+	fxgmac_config_osp_mode(pdata);
+	fxgmac_config_pblx8(pdata);
+	fxgmac_config_tx_pbl_val(pdata);
+	fxgmac_config_rx_pbl_val(pdata);
+	fxgmac_config_rx_coalesce(pdata);
+	fxgmac_config_rx_buffer_size(pdata);
+	fxgmac_config_tso_mode(pdata);
+	fxgmac_config_sph_mode(pdata);
+	fxgmac_config_rss(pdata);
+
+	fxgmac_desc_tx_init(pdata);
+	fxgmac_desc_rx_init(pdata);
+	fxgmac_enable_dma_interrupts(pdata);
+
+	/* Initialize MTL related features */
+	fxgmac_config_mtl_mode(pdata);
+	fxgmac_config_queue_mapping(pdata);
+	fxgmac_config_tsf_mode(pdata, pdata->tx_sf_mode);
+	fxgmac_config_rsf_mode(pdata, pdata->rx_sf_mode);
+	fxgmac_config_tx_threshold(pdata, pdata->tx_threshold);
+	fxgmac_config_rx_threshold(pdata, pdata->rx_threshold);
+	fxgmac_config_tx_fifo_size(pdata);
+	fxgmac_config_rx_fifo_size(pdata);
+	fxgmac_config_flow_control_threshold(pdata);
+	fxgmac_config_rx_fep_disable(pdata);
+	fxgmac_config_rx_fup_enable(pdata);
+	fxgmac_enable_mtl_interrupts(pdata);
+
+	/* Initialize MAC related features */
+	fxgmac_config_mac_address(pdata);
+	fxgmac_config_crc_check(pdata);
+	fxgmac_config_rx_mode(pdata);
+	fxgmac_config_jumbo(pdata);
+	ret = fxgmac_config_flow_control(pdata);
+	if (ret < 0) {
+		yt_err(pdata, "%s, fxgmac_config_flow_control err:%d\n",
+		       __func__, ret);
+		return ret;
+	}
+
+	fxgmac_config_mac_speed(pdata);
+	fxgmac_config_checksum_offload(pdata);
+	fxgmac_config_vlan_support(pdata);
+	fxgmac_config_mmc(pdata);
+	fxgmac_enable_mac_interrupts(pdata);
+	fxgmac_config_wol_wait_time(pdata);
+
+	ret = fxgmac_phy_irq_enable(pdata, true);
+
+	if (netif_msg_drv(pdata))
+		yt_dbg(pdata, "%s ok\n", __func__);
+
+	return ret;
+}
+
+static void fxgmac_save_nonstick_reg(struct fxgmac_pdata *pdata)
+{
+	struct fxgmac_pci_cfg *pci_cfg = &pdata->pci_cfg;
+	struct pci_dev *pdev = to_pci_dev(pdata->dev);
+
+	for (u32 i = GLOBAL_CTRL0; i < MSI_PBA; i += 4) {
+		pdata->reg_nonstick[(i - GLOBAL_CTRL0) >> 2] =
+			rd32_mem(pdata, i);
+	}
+
+	pci_read_config_dword(pdev, PCI_COMMAND, &pci_cfg->pci_cmd);
+	pci_read_config_dword(pdev, PCI_CACHE_LINE_SIZE,
+			      &pci_cfg->cache_line_size);
+	pci_read_config_dword(pdev, YT6801_MEM_BASE, &pci_cfg->mem_base);
+	pci_read_config_dword(pdev, YT6801_MEM_BASE_HI, &pci_cfg->mem_base_hi);
+	pci_read_config_dword(pdev, YT6801_IO_BASE, &pci_cfg->io_base);
+	pci_read_config_dword(pdev, PCI_INTERRUPT_LINE, &pci_cfg->int_line);
+	pci_read_config_dword(pdev, PCI_DEVICE_CTRL1, &pci_cfg->device_ctrl1);
+	pci_read_config_dword(pdev, PCI_LINK_CTRL, &pci_cfg->pci_link_ctrl);
+	pci_read_config_dword(pdev, PCI_DEVICE_CTRL2, &pci_cfg->device_ctrl2);
+	pci_read_config_dword(pdev, PCI_MSIX_CAPABILITY,
+			      &pci_cfg->msix_capability);
+}
+
+static void fxgmac_restore_nonstick_reg(struct fxgmac_pdata *pdata)
+{
+	for (u32 i = GLOBAL_CTRL0; i < MSI_PBA; i += 4)
+		wr32_mem(pdata, pdata->reg_nonstick[(i - GLOBAL_CTRL0) >> 2],
+			 i);
+}
+
+static void fxgmac_esd_restore_pcie_cfg(struct fxgmac_pdata *pdata)
+{
+	struct fxgmac_pci_cfg *pci_cfg = &pdata->pci_cfg;
+	struct pci_dev *pdev = to_pci_dev(pdata->dev);
+
+	pci_write_config_dword(pdev, PCI_COMMAND, pci_cfg->pci_cmd);
+	pci_write_config_dword(pdev, PCI_CACHE_LINE_SIZE,
+			       pci_cfg->cache_line_size);
+	pci_write_config_dword(pdev, YT6801_MEM_BASE, pci_cfg->mem_base);
+	pci_write_config_dword(pdev, YT6801_MEM_BASE_HI, pci_cfg->mem_base_hi);
+	pci_write_config_dword(pdev, YT6801_IO_BASE, pci_cfg->io_base);
+	pci_write_config_dword(pdev, PCI_INTERRUPT_LINE, pci_cfg->int_line);
+	pci_write_config_dword(pdev, PCI_DEVICE_CTRL1, pci_cfg->device_ctrl1);
+	pci_write_config_dword(pdev, PCI_LINK_CTRL, pci_cfg->pci_link_ctrl);
+	pci_write_config_dword(pdev, PCI_DEVICE_CTRL2, pci_cfg->device_ctrl2);
+	pci_write_config_dword(pdev, PCI_MSIX_CAPABILITY,
+			       pci_cfg->msix_capability);
+}
+
+static void fxgmac_hw_exit(struct fxgmac_pdata *pdata)
+{
+	struct pci_dev *pdev = to_pci_dev(pdata->dev);
+	u32 val = 0;
+
+	pci_read_config_dword(pdev, PCI_LINK_CTRL, &val);
+	pdata->pcie_link_status =
+		FXGMAC_GET_BITS(val, LINK_CTRL_ASPM_CONTROL_POS,
+				LINK_CTRL_ASPM_CONTROL_LEN);
+
+	if (FIELD_GET(LINK_CTRL_L1_STATUS, pdata->pcie_link_status)) {
+		fxgmac_set_bits(&val, LINK_CTRL_ASPM_CONTROL_POS,
+				LINK_CTRL_ASPM_CONTROL_LEN, 0);
+		pci_write_config_dword(pdev, PCI_LINK_CTRL, val);
+	}
+
+	/* Issue a CHIP reset,
+	 * it will reset trigger circuit and reload efuse patch
+	 */
+	val = rd32_mem(pdata, SYS_RESET);
+	yt_dbg(pdata, "CHIP_RESET 0x%x\n", val);
+	fxgmac_set_bits(&val, SYS_RESET_POS, SYS_RESET_LEN, 1);
+	wr32_mem(pdata, val, SYS_RESET);
+	usleep_range(9000, 10000);
+
+	/* release ephy reset again */
+	fxgmac_set_bits(&val, EPHY_CTRL_RESET_POS, EPHY_CTRL_RESET_LEN,
+			EPHY_CTRL_STA_RELEASE);
+	wr32_mem(pdata, val, EPHY_CTRL);
+	usleep_range(100, 150);
+
+	/* reset will clear nonstick registers. */
+	fxgmac_restore_nonstick_reg(pdata);
+}
+
+static void fxgmac_pcie_init(struct fxgmac_pdata *pdata, bool ltr_en,
+			     bool aspm_l1ss_en, bool aspm_l1_en,
+			     bool aspm_l0s_en)
+{
+	struct pci_dev *pdev = to_pci_dev(pdata->dev);
+	u16 deviceid = 0;
+	u8 revid = 0;
+	u32 val = 0;
+
+	pci_read_config_dword(pdev, PCI_LINK_CTRL, &val);
+	if ((FIELD_GET(LINK_CTRL_L1_STATUS, pdata->pcie_link_status)) &&
+	    0x00 == FXGMAC_GET_BITS(val, LINK_CTRL_ASPM_CONTROL_POS,
+				    LINK_CTRL_ASPM_CONTROL_LEN)) {
+		fxgmac_set_bits(&val, LINK_CTRL_ASPM_CONTROL_POS,
+				LINK_CTRL_ASPM_CONTROL_LEN,
+				pdata->pcie_link_status);
+		pci_write_config_dword(pdev, PCI_LINK_CTRL, val);
+	}
+	val = 0;
+	fxgmac_set_bits(&val, LTR_IDLE_ENTER_REQUIRE_POS,
+			LTR_IDLE_ENTER_REQUIRE_LEN, LTR_IDLE_ENTER_REQUIRE);
+	fxgmac_set_bits(&val, LTR_IDLE_ENTER_SCALE_POS,
+			LTR_IDLE_ENTER_SCALE_LEN, LTR_IDLE_ENTER_SCALE_1024_NS);
+	fxgmac_set_bits(&val, LTR_IDLE_ENTER_POS, LTR_IDLE_ENTER_LEN,
+			LTR_IDLE_ENTER_900_US);
+	val = (val << 16) + val; /* snoopy + non-snoopy */
+	wr32_mem(pdata, val, LTR_IDLE_ENTER);
+
+	val = 0;
+	fxgmac_set_bits(&val, LTR_IDLE_EXIT_REQUIRE_POS,
+			LTR_IDLE_EXIT_REQUIRE_LEN, LTR_IDLE_EXIT_REQUIRE);
+	fxgmac_set_bits(&val, LTR_IDLE_EXIT_SCALE_POS, LTR_IDLE_EXIT_SCALE_LEN,
+			LTR_IDLE_EXIT_SCALE);
+	fxgmac_set_bits(&val, LTR_IDLE_EXIT_POS, LTR_IDLE_EXIT_LEN,
+			LTR_IDLE_EXIT_171_US);
+	val = (val << 16) + val; /* snoopy + non-snoopy */
+	wr32_mem(pdata, val, LTR_IDLE_EXIT);
+
+	val = rd32_mem(pdata, LTR_CTRL);
+	if (ltr_en) {
+		fxgmac_set_bits(&val, LTR_CTRL_EN_POS, LTR_CTRL_EN_LEN, 1);
+		fxgmac_set_bits(&val, LTR_CTRL_IDLE_THRE_TIMER_POS,
+				LTR_CTRL_IDLE_THRE_TIMER_LEN,
+				LTR_CTRL_IDLE_THRE_TIMER_VAL);
+	} else {
+		fxgmac_set_bits(&val, LTR_CTRL_EN_POS, LTR_CTRL_EN_LEN, 0);
+	}
+	wr32_mem(pdata, val, LTR_CTRL);
+
+	val = rd32_mem(pdata, LPW_CTRL);
+	fxgmac_set_bits(&val, LPW_CTRL_ASPM_L0S_EN_POS,
+			LPW_CTRL_ASPM_L0S_EN_LEN, aspm_l0s_en ? 1 : 0);
+	fxgmac_set_bits(&val, LPW_CTRL_ASPM_L1_EN_POS, LPW_CTRL_ASPM_L1_EN_LEN,
+			aspm_l1_en ? 1 : 0);
+	fxgmac_set_bits(&val, LPW_CTRL_L1SS_EN_POS, LPW_CTRL_L1SS_EN_LEN,
+			aspm_l1ss_en ? 1 : 0);
+	wr32_mem(pdata, val, LPW_CTRL);
+
+	pci_read_config_dword(pdev, PCI_ASPM_CONTROL, &val);
+	fxgmac_set_bits(&val, ASPM_L1_IDLE_THRESHOLD_POS,
+			ASPM_L1_IDLE_THRESHOLD_LEN, ASPM_L1_IDLE_THRESHOLD_1US);
+	pci_write_config_dword(pdev, PCI_ASPM_CONTROL, val);
+
+	val = 0;
+	fxgmac_set_bits(&val, PCIE_SERDES_PLL_AUTOOFF_POS,
+			PCIE_SERDES_PLL_AUTOOFF_LEN, 1);
+	wr32_mem(pdata, val, PCIE_SERDES_PLL);
+
+	pci_read_config_byte(pdev, PCI_REVISION_ID, &revid);
+	pci_read_config_word(pdev, PCI_DEVICE_ID, &deviceid);
+	/* yt6801 rev 01 adjust sigdet threshold to 55 mv*/
+	if (YT6801_REV_01 == revid && YT6801_PCI_DEVICE_ID == deviceid) {
+		val = rd32_mem(pdata, MGMT_SIGDET);
+		fxgmac_set_bits(&val, MGMT_SIGDET_POS, MGMT_SIGDET_LEN,
+				MGMT_SIGDET_55MV);
+		wr32_mem(pdata, val, MGMT_SIGDET);
+	}
+}
+
+static void fxgmac_clear_misc_int_status(struct fxgmac_pdata *pdata)
+{
+	struct fxgmac_hw_ops *hw_ops = &pdata->hw_ops;
+	u32 val, i, q_count;
+
+	fxgmac_phy_clear_interrupt(pdata);
+
+	/* clear other interrupt status  */
+	val = rd32_mac(pdata, MAC_ISR);
+	if (val) {
+		if (val & BIT(MAC_ISR_PHYIF_STA_POS))
+			rd32_mac(pdata, MAC_PHYIF_STA);
+
+		if (val & (BIT(MAC_ISR_AN_SR0_POS) | BIT(MAC_ISR_AN_SR1_POS) |
+			   BIT(MAC_ISR_AN_SR2_POS)))
+			rd32_mac(pdata, MAC_AN_SR);
+
+		if (val & BIT(MAC_ISR_PMT_STA_POS))
+			rd32_mac(pdata, MAC_PMT_STA);
+
+		if (val & BIT(MAC_ISR_LPI_STA_POS))
+			rd32_mac(pdata, MAC_LPI_STA);
+
+		if (val & BIT(MAC_ISR_MMC_STA_POS)) {
+			if (val & BIT(MAC_ISR_RX_MMC_STA_POS))
+				hw_ops->rx_mmc_int(pdata);
+
+			if (val & BIT(MAC_ISR_TX_MMC_STA_POS))
+				hw_ops->tx_mmc_int(pdata);
+
+			if (val & BIT(MAC_ISR_IPCRXINT_POS))
+				rd32_mac(pdata, MMC_IPCRXINT);
+		}
+
+		if (val &
+		    (BIT(MAC_ISR_TX_RX_STA0_POS) | BIT(MAC_ISR_TX_RX_STA1_POS)))
+			rd32_mac(pdata, MAC_TX_RX_STA);
+
+		if (val & BIT(MAC_ISR_GPIO_SR_POS))
+			rd32_mac(pdata, MAC_GPIO_SR);
+	}
+
+	/* MTL_Interrupt_Status, write 1 clear */
+	val = rd32_mac(pdata, MTL_INT_SR);
+	wr32_mac(pdata, val, MTL_INT_SR);
+
+	/* MTL_Q(#i)_Interrupt_Control_Status, write 1 clear */
+	q_count = max(pdata->hw_feat.tx_q_cnt, pdata->hw_feat.rx_q_cnt);
+	for (i = 0; i < q_count; i++) {
+		/* Clear all the interrupts which are set */
+		val = rd32_mac(pdata, MTL_Q_INT_CTL_SR + i * MTL_Q_INC);
+		wr32_mac(pdata, val, MTL_Q_INT_CTL_SR + i * MTL_Q_INC);
+	}
+
+	/* MTL_ECC_Interrupt_Status, write 1 clear */
+	val = rd32_mac(pdata, MTL_ECC_INT_SR);
+	wr32_mac(pdata, val, MTL_ECC_INT_SR);
+
+	/* DMA_ECC_Interrupt_Status, write 1 clear */
+	val = rd32_mac(pdata, DMA_ECC_INT_SR);
+	wr32_mac(pdata, val, DMA_ECC_INT_SR);
+}
+
+void fxgmac_hw_ops_init(struct fxgmac_hw_ops *hw_ops)
+{
+	hw_ops->init = fxgmac_hw_init;
+	hw_ops->exit = fxgmac_hw_exit;
+	hw_ops->save_nonstick_reg = fxgmac_save_nonstick_reg;
+	hw_ops->restore_nonstick_reg = fxgmac_restore_nonstick_reg;
+	hw_ops->esd_restore_pcie_cfg = fxgmac_esd_restore_pcie_cfg;
+
+	hw_ops->enable_tx = fxgmac_enable_tx;
+	hw_ops->disable_tx = fxgmac_disable_tx;
+	hw_ops->enable_rx = fxgmac_enable_rx;
+	hw_ops->disable_rx = fxgmac_disable_rx;
+
+	hw_ops->enable_channel_irq = fxgmac_enable_channel_irq;
+	hw_ops->disable_channel_irq = fxgmac_disable_channel_irq;
+	hw_ops->set_interrupt_moderation = fxgmac_set_interrupt_moderation;
+	hw_ops->disable_msix_irqs = fxgmac_disable_msix_irqs;
+	hw_ops->enable_msix_irqs = fxgmac_enable_msix_irqs;
+	hw_ops->enable_msix_one_irq = fxgmac_enable_msix_one_irq;
+	hw_ops->disable_msix_one_irq = fxgmac_disable_msix_one_irq;
+	hw_ops->enable_mgm_irq = fxgmac_enable_mgm_irq;
+	hw_ops->disable_mgm_irq = fxgmac_disable_mgm_irq;
+	hw_ops->dismiss_all_int = fxgmac_dismiss_all_int;
+	hw_ops->clear_misc_int_status = fxgmac_clear_misc_int_status;
+
+	hw_ops->set_mac_address = fxgmac_set_mac_address;
+	hw_ops->set_mac_hash = fxgmac_set_mc_addresses;
+	hw_ops->config_rx_mode = fxgmac_config_rx_mode;
+	hw_ops->enable_rx_csum = fxgmac_enable_rx_csum;
+	hw_ops->disable_rx_csum = fxgmac_disable_rx_csum;
+	hw_ops->config_tso = fxgmac_config_tso_mode;
+
+	/* MII speed configuration */
+	hw_ops->config_mac_speed = fxgmac_config_mac_speed;
+
+	/* Descriptor related operation */
+	hw_ops->is_tx_complete = fxgmac_is_tx_complete;
+	hw_ops->is_last_desc = fxgmac_is_last_desc;
+
+	/* Flow Control */
+	hw_ops->config_tx_flow_control = fxgmac_config_tx_flow_control;
+	hw_ops->config_rx_flow_control = fxgmac_config_rx_flow_control;
+
+	/* Vlan related config */
+	hw_ops->enable_tx_vlan = fxgmac_enable_tx_vlan;
+	hw_ops->disable_tx_vlan = fxgmac_disable_tx_vlan;
+	hw_ops->enable_rx_vlan_stripping = fxgmac_enable_rx_vlan_stripping;
+	hw_ops->disable_rx_vlan_stripping = fxgmac_disable_rx_vlan_stripping;
+	hw_ops->enable_rx_vlan_filtering = fxgmac_enable_rx_vlan_filtering;
+	hw_ops->disable_rx_vlan_filtering = fxgmac_disable_rx_vlan_filtering;
+	hw_ops->update_vlan_hash_table = fxgmac_update_vlan_hash_table;
+
+	/* RX coalescing */
+	hw_ops->config_rx_coalesce = fxgmac_config_rx_coalesce;
+	hw_ops->usec_to_riwt = fxgmac_usec_to_riwt;
+
+	hw_ops->calculate_max_checksum_size =
+		fxgmac_calculate_max_checksum_size;
+	/* MMC statistics support */
+	hw_ops->tx_mmc_int = fxgmac_tx_mmc_int;
+	hw_ops->rx_mmc_int = fxgmac_rx_mmc_int;
+	hw_ops->read_mmc_stats = fxgmac_read_mmc_stats;
+
+	/* Receive Side Scaling */
+	hw_ops->enable_rss = fxgmac_enable_rss;
+	hw_ops->disable_rss = fxgmac_disable_rss;
+	hw_ops->get_rss_options = fxgmac_read_rss_options;
+	hw_ops->set_rss_options = fxgmac_write_rss_options;
+	hw_ops->set_rss_hash_key = fxgmac_set_rss_hash_key;
+
+	/* Power Management*/
+	hw_ops->disable_arp_offload = fxgmac_disable_arp_offload;
+	hw_ops->enable_wake_magic_pattern = fxgmac_enable_wake_magic_pattern;
+	hw_ops->disable_wake_magic_pattern = fxgmac_disable_wake_magic_pattern;
+	hw_ops->enable_wake_link_change = fxgmac_enable_wake_link_change;
+	hw_ops->disable_wake_link_change = fxgmac_disable_wake_link_change;
+	hw_ops->set_wake_pattern = fxgmac_set_wake_pattern;
+	hw_ops->enable_wake_pattern = fxgmac_enable_wake_pattern;
+	hw_ops->disable_wake_pattern = fxgmac_disable_wake_pattern;
+
+	/*For phy write /read*/
+	hw_ops->reset_phy = fxgmac_phy_reset;
+	hw_ops->release_phy = fxgmac_phy_release;
+	hw_ops->get_ephy_state = fxgmac_phy_get_state;
+	hw_ops->write_ephy_reg = fxgmac_phy_write_reg;
+	hw_ops->read_ephy_reg = fxgmac_phy_read_reg;
+	/* power management */
+	hw_ops->pre_power_down = fxgmac_pre_powerdown;
+	hw_ops->config_power_down = fxgmac_config_powerdown;
+	hw_ops->config_power_up = fxgmac_config_powerup;
+	hw_ops->set_suspend_txrx = fxgmac_suspend_txrx;
+
+	hw_ops->pcie_init = fxgmac_pcie_init;
+}
diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c b/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
new file mode 100644
index 0000000..e6c159b
--- /dev/null
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
@@ -0,0 +1,2476 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (c) 2022 - 2024 Motorcomm Electronic Technology Co.,Ltd. */
+
+#include <linux/netdevice.h>
+#include <linux/interrupt.h>
+#include <linux/inetdevice.h>
+#include <net/addrconf.h>
+#include <linux/inet.h>
+#include <linux/tcp.h>
+
+#include "yt6801_type.h"
+#include "yt6801_desc.h"
+#include "yt6801_phy.h"
+#include "yt6801_net.h"
+
+static int fxgmac_one_poll_rx(struct napi_struct *, int);
+static int fxgmac_one_poll_tx(struct napi_struct *, int);
+static int fxgmac_all_poll(struct napi_struct *, int);
+static int fxgmac_dev_read(struct fxgmac_channel *channel);
+static void fxgmac_dev_xmit(struct fxgmac_channel *channel);
+
+inline void fxgmac_lock(struct fxgmac_pdata *pdata)
+{
+	mutex_lock(&pdata->mutex);
+}
+
+inline void fxgmac_unlock(struct fxgmac_pdata *pdata)
+{
+	mutex_unlock(&pdata->mutex);
+}
+
+#define FXGMAC_ESD_INTERVAL (5 * HZ)
+static inline void fxgmac_schedule_esd_work(struct fxgmac_pdata *pdata)
+{
+	set_bit(FXGMAC_TASK_FLAG_ESD_CHECK, pdata->task_flags);
+	schedule_delayed_work(&pdata->esd_work, FXGMAC_ESD_INTERVAL);
+}
+
+static void fxgmac_update_esd_stats(struct fxgmac_pdata *pdata)
+{
+	struct fxgmac_esd_stats *stats = &pdata->esd_stats;
+
+	stats->tx_abort_excess_collisions +=
+		rd32_mac(pdata, MMC_TXEXCESSIVECOLLSIONFRAMES);
+	stats->tx_dma_underrun += rd32_mac(pdata, MMC_TXUNDERFLOWERROR_LO);
+	stats->tx_lost_crs += rd32_mac(pdata, MMC_TXCARRIERERRORFRAMES);
+	stats->tx_late_collisions += rd32_mac(pdata, MMC_TXLATECOLLISIONFRAMES);
+	stats->rx_crc_errors += rd32_mac(pdata, MMC_RXCRCERROR_LO);
+	stats->rx_align_errors += rd32_mac(pdata, MMC_RXALIGNERROR);
+	stats->rx_runt_errors += rd32_mac(pdata, MMC_RXRUNTERROR);
+	stats->single_collisions += rd32_mac(pdata, MMC_TXSINGLECOLLISION_G);
+	stats->multi_collisions += rd32_mac(pdata, MMC_TXMULTIPLECOLLISION_G);
+	stats->tx_deferred_frames += rd32_mac(pdata, MMC_TXDEFERREDFRAMES);
+}
+
+#define FXGMAC_ESD_ERROR_THRESHOLD		((u64)4000000000)
+#define FXGMAC_PCIE_LINK_DOWN			0xFFFFFFFF
+#define FXGMAC_PCIE_RECOVER_TIMES		5000
+#define FXGMAC_PCIE_IO_MEM_MASTER_ENABLE	0x7
+
+static void fxgmac_check_esd_work(struct fxgmac_pdata *pdata)
+{
+	struct fxgmac_esd_stats *stats = &pdata->esd_stats;
+	struct pci_dev *pdev = to_pci_dev(pdata->dev);
+	u32 val, i = 0;
+
+	/* ESD test make recv crc errors more than 4294967xxx in one second. */
+	if (stats->rx_crc_errors > FXGMAC_ESD_ERROR_THRESHOLD ||
+	    stats->rx_align_errors > FXGMAC_ESD_ERROR_THRESHOLD ||
+	    stats->rx_runt_errors > FXGMAC_ESD_ERROR_THRESHOLD ||
+	    stats->tx_abort_excess_collisions > FXGMAC_ESD_ERROR_THRESHOLD ||
+	    stats->tx_dma_underrun > FXGMAC_ESD_ERROR_THRESHOLD ||
+	    stats->tx_lost_crs > FXGMAC_ESD_ERROR_THRESHOLD ||
+	    stats->tx_late_collisions > FXGMAC_ESD_ERROR_THRESHOLD ||
+	    stats->single_collisions > FXGMAC_ESD_ERROR_THRESHOLD ||
+	    stats->multi_collisions > FXGMAC_ESD_ERROR_THRESHOLD ||
+	    stats->tx_deferred_frames > FXGMAC_ESD_ERROR_THRESHOLD) {
+		yt_dbg(pdata,
+		       "rx_crc_errors:%ul, rx_align_errors:%ul, rx_runt_errors:%ul, tx_abort_excess_collisions:%ul, tx_dma_underrun:%ul, tx_lost_crs:%ul, tx_late_collisions:%ul, single_collisions:%ul, multi_collisions:%ul, tx_deferred_frames:%ul\n",
+		       stats->rx_crc_errors, stats->rx_align_errors,
+		       stats->rx_runt_errors, stats->tx_abort_excess_collisions,
+		       stats->tx_dma_underrun, stats->tx_lost_crs,
+		       stats->tx_late_collisions, stats->single_collisions,
+		       stats->multi_collisions, stats->tx_deferred_frames);
+
+		yt_err(pdata, "%s, esd error, restart NIC...\n", __func__);
+
+		pci_read_config_dword(pdev, PCI_COMMAND, &val);
+		while ((val == FXGMAC_PCIE_LINK_DOWN) &&
+		       (i++ < FXGMAC_PCIE_RECOVER_TIMES)) {
+			usleep_range(200, 210);
+			pci_read_config_dword(pdev, PCI_COMMAND, &val);
+			yt_dbg(pdata, "pcie recovery link cost %d(200us)\n", i);
+		}
+
+		if (val == FXGMAC_PCIE_LINK_DOWN) {
+			yt_err(pdata, "pcie link down, recovery err.\n");
+			return;
+		}
+
+		if (val & FXGMAC_PCIE_IO_MEM_MASTER_ENABLE) {
+			pdata->hw_ops.esd_restore_pcie_cfg(pdata);
+			pci_read_config_dword(pdev, PCI_COMMAND, &val);
+			yt_dbg(pdata,
+			       "pci command reg is %x after restoration.\n",
+			       val);
+			fxgmac_restart(pdata);
+		}
+	}
+
+	memset(stats, 0, sizeof(struct fxgmac_esd_stats));
+}
+
+static void fxgmac_esd_work(struct work_struct *work)
+{
+	struct fxgmac_pdata *pdata;
+
+	pdata = container_of(work, struct fxgmac_pdata, esd_work.work);
+
+	rtnl_lock();
+	if (!netif_running(pdata->netdev) ||
+	    !test_and_clear_bit(FXGMAC_TASK_FLAG_ESD_CHECK, pdata->task_flags))
+		goto out_unlock;
+
+	fxgmac_update_esd_stats(pdata);
+	fxgmac_check_esd_work(pdata);
+	fxgmac_schedule_esd_work(pdata);
+
+out_unlock:
+	rtnl_unlock();
+}
+
+static void fxgmac_cancel_esd_work(struct fxgmac_pdata *pdata)
+{
+	struct work_struct *work = &pdata->esd_work.work;
+
+	if (!work->func) {
+		yt_err(pdata, "work func is NULL.\n");
+		return;
+	}
+
+	cancel_delayed_work_sync(&pdata->esd_work);
+}
+
+unsigned int fxgmac_get_netdev_ip4addr(struct fxgmac_pdata *pdata)
+{
+	unsigned int ipval = 0xc0a801ca; /* 192.168.1.202 */
+	struct net_device *netdev = pdata->netdev;
+	struct in_ifaddr *ifa;
+
+	rcu_read_lock();
+
+	/* we only get the first IPv4 addr. */
+	ifa = rcu_dereference(netdev->ip_ptr->ifa_list);
+	if (ifa) {
+		ipval = (unsigned int)ifa->ifa_address;
+		yt_dbg(pdata, "%s, netdev %s IPv4 address %pI4, mask: %pI4\n",
+		       __func__, ifa->ifa_label, &ifa->ifa_address,
+		       &ifa->ifa_mask);
+	}
+
+	rcu_read_unlock();
+
+	return ipval;
+}
+
+unsigned char *fxgmac_get_netdev_ip6addr(struct fxgmac_pdata *pdata,
+					 unsigned char *ipval,
+					 unsigned char *ip6addr_solicited,
+					 unsigned int ifa_flag)
+{
+	struct net_device *netdev = pdata->netdev;
+	unsigned char solicited_ipval[16] = { 0 };
+	unsigned char local_ipval[16] = { 0 };
+	struct in6_addr *addr_ip6_solicited;
+	int err = -EADDRNOTAVAIL;
+	struct in6_addr *addr_ip6;
+	struct inet6_dev *i6dev;
+	struct inet6_ifaddr *ifp;
+
+	if (!(ifa_flag &
+	      (FXGMAC_NS_IFA_GLOBAL_UNICAST | FXGMAC_NS_IFA_LOCAL_LINK))) {
+		yt_err(pdata, "%s, ifa_flag :%d is err.\n", __func__, ifa_flag);
+		return NULL;
+	}
+
+	addr_ip6 = (struct in6_addr *)local_ipval;
+	addr_ip6_solicited = (struct in6_addr *)solicited_ipval;
+
+	if (ipval)
+		addr_ip6 = (struct in6_addr *)ipval;
+
+	if (ip6addr_solicited)
+		addr_ip6_solicited = (struct in6_addr *)ip6addr_solicited;
+
+	in6_pton("fe80::4808:8ffb:d93e:d753", -1, (u8 *)addr_ip6, -1, NULL);
+
+	rcu_read_lock();
+	i6dev = __in6_dev_get(netdev);
+	if (!i6dev)
+		goto err;
+
+	read_lock_bh(&i6dev->lock);
+	list_for_each_entry(ifp, &i6dev->addr_list, if_list) {
+		if (((ifa_flag & FXGMAC_NS_IFA_GLOBAL_UNICAST) &&
+		     ifp->scope != IFA_LINK) ||
+		    ((ifa_flag & FXGMAC_NS_IFA_LOCAL_LINK) &&
+		     ifp->scope == IFA_LINK)) {
+			memcpy(addr_ip6, &ifp->addr, 16);
+			addrconf_addr_solict_mult(addr_ip6, addr_ip6_solicited);
+			err = 0;
+			break;
+		}
+	}
+	read_unlock_bh(&i6dev->lock);
+
+	if (err)
+		goto err;
+
+	rcu_read_unlock();
+
+	return ipval;
+err:
+	rcu_read_unlock();
+	yt_err(pdata, "%s, get ipv6 addr err, use default.\n", __func__);
+	return NULL;
+}
+
+static inline unsigned int fxgmac_desc_tx_avail(struct fxgmac_ring *ring)
+{
+	unsigned int avail;
+
+	if (ring->dirty > ring->cur)
+		avail = ring->dirty - ring->cur;
+	else
+		avail = ring->dma_desc_count - ring->cur + ring->dirty;
+
+	return avail;
+}
+
+static inline unsigned int fxgmac_desc_rx_dirty(struct fxgmac_ring *ring)
+{
+	unsigned int dirty;
+
+	if (ring->dirty <= ring->cur)
+		dirty = ring->cur - ring->dirty;
+	else
+		dirty = ring->dma_desc_count - ring->dirty + ring->cur;
+
+	return dirty;
+}
+
+static netdev_tx_t fxgmac_maybe_stop_tx_queue(struct fxgmac_channel *channel,
+					      struct fxgmac_ring *ring,
+					      unsigned int count)
+{
+	struct fxgmac_pdata *pdata = channel->pdata;
+
+	if (count > fxgmac_desc_tx_avail(ring)) {
+		/* Avoid wrongly optimistic queue wake-up: tx poll thread must
+		 * not miss a ring update when it notices a stopped queue.
+		 */
+		smp_wmb();
+		netif_stop_subqueue(pdata->netdev, channel->queue_index);
+		ring->tx.queue_stopped = 1;
+
+		/* Sync with tx poll:
+		 * - publish queue status and cur ring index (write barrier)
+		 * - refresh dirty ring index (read barrier).
+		 * May the current thread have a pessimistic view of the ring
+		 * status and forget to wake up queue, a racing tx poll thread
+		 * can't.
+		 */
+		smp_mb();
+		if (count <= fxgmac_desc_tx_avail(ring)) {
+			ring->tx.queue_stopped = 0;
+			netif_start_subqueue(pdata->netdev,
+					     channel->queue_index);
+			fxgmac_tx_start_xmit(channel, ring);
+		} else {
+			/* If we haven't notified the hardware because of
+			 * xmit_more support, tell it now
+			 */
+			if (ring->tx.xmit_more)
+				fxgmac_tx_start_xmit(channel, ring);
+			if (netif_msg_tx_done(pdata))
+				yt_dbg(pdata, "about stop tx q, ret BUSY\n");
+			return NETDEV_TX_BUSY;
+		}
+	}
+
+	return NETDEV_TX_OK;
+}
+
+static inline void fxgmac_prep_vlan(struct sk_buff *skb,
+				    struct fxgmac_pkt_info *pkt_info)
+{
+	if (skb_vlan_tag_present(skb))
+		pkt_info->vlan_ctag = skb_vlan_tag_get(skb);
+}
+
+static int fxgmac_prep_tso(struct fxgmac_pdata *pdata, struct sk_buff *skb,
+			   struct fxgmac_pkt_info *pkt_info)
+{
+	int ret;
+
+	if (!FXGMAC_GET_BITS(pkt_info->attributes, TX_PKT_ATTR_TSO_ENABLE_POS,
+			     TX_PKT_ATTR_TSO_ENABLE_LEN))
+		return 0;
+
+	ret = skb_cow_head(skb, 0);
+	if (ret)
+		return ret;
+
+	pkt_info->header_len = skb_transport_offset(skb) + tcp_hdrlen(skb);
+	pkt_info->tcp_header_len = tcp_hdrlen(skb);
+	pkt_info->tcp_payload_len = skb->len - pkt_info->header_len;
+	pkt_info->mss = skb_shinfo(skb)->gso_size;
+
+	if (netif_msg_tx_done(pdata))
+		yt_dbg(pdata,
+		       "header_len=%u, tcp_header_len=%u, tcp_payload_len=%u, mss=%u\n",
+		       pkt_info->header_len, pkt_info->tcp_header_len,
+		       pkt_info->tcp_payload_len, pkt_info->mss);
+
+	/* Update the number of packets that will ultimately be transmitted
+	 * along with the extra bytes for each extra packet
+	 */
+	pkt_info->tx_packets = skb_shinfo(skb)->gso_segs;
+	pkt_info->tx_bytes += (pkt_info->tx_packets - 1) * pkt_info->header_len;
+
+	return 0;
+}
+
+static inline int fxgmac_is_tso(struct sk_buff *skb)
+{
+	if (skb->ip_summed != CHECKSUM_PARTIAL)
+		return 0;
+
+	if (!skb_is_gso(skb))
+		return 0;
+
+	return 1;
+}
+
+static void fxgmac_prep_tx_pkt(struct fxgmac_pdata *pdata,
+			       struct fxgmac_ring *ring, struct sk_buff *skb,
+			       struct fxgmac_pkt_info *pkt_info)
+{
+	unsigned int *attr = &pkt_info->attributes;
+	unsigned int context_desc = 0;
+	unsigned int len;
+
+	pkt_info->skb = skb;
+	pkt_info->desc_count = 0;
+	pkt_info->tx_packets = 1;
+	pkt_info->tx_bytes = skb->len;
+
+	if (netif_msg_tx_done(pdata))
+		yt_dbg(pdata, "%s, pkt desc cnt=%d,skb len=%d, skbheadlen=%d\n",
+		       __func__, pkt_info->desc_count, skb->len,
+		       skb_headlen(skb));
+
+	if (fxgmac_is_tso(skb)) {
+		/* TSO requires an extra descriptor if mss is different */
+		if (skb_shinfo(skb)->gso_size != ring->tx.cur_mss) {
+			context_desc = 1;
+			pkt_info->desc_count++;
+		}
+		if (netif_msg_tx_done(pdata))
+			yt_dbg(pdata,
+			       "fxgmac_is_tso=%d, ip_summed=%d,skb gso=%d\n",
+			       ((skb->ip_summed == CHECKSUM_PARTIAL) &&
+				(skb_is_gso(skb))) ? 1 : 0,
+			       skb->ip_summed, skb_is_gso(skb) ? 1 : 0);
+
+		/* TSO requires an extra descriptor for TSO header */
+		pkt_info->desc_count++;
+		fxgmac_set_bits(attr, TX_PKT_ATTR_TSO_ENABLE_POS,
+				TX_PKT_ATTR_TSO_ENABLE_LEN, 1);
+		fxgmac_set_bits(attr, TX_PKT_ATTR_CSUM_ENABLE_POS,
+				TX_PKT_ATTR_CSUM_ENABLE_LEN, 1);
+		if (netif_msg_tx_done(pdata))
+			yt_dbg(pdata, "%s,tso, pkt desc cnt=%d\n", __func__,
+			       pkt_info->desc_count);
+	} else if (skb->ip_summed == CHECKSUM_PARTIAL)
+		fxgmac_set_bits(attr, TX_PKT_ATTR_CSUM_ENABLE_POS,
+				TX_PKT_ATTR_CSUM_ENABLE_LEN, 1);
+
+	if (skb_vlan_tag_present(skb)) {
+		/* VLAN requires an extra descriptor if tag is different */
+		if (skb_vlan_tag_get(skb) != ring->tx.cur_vlan_ctag)
+			/* We can share with the TSO context descriptor */
+			if (!context_desc) {
+				context_desc = 1;
+				pkt_info->desc_count++;
+			}
+
+		fxgmac_set_bits(attr, TX_PKT_ATTR_VLAN_CTAG_POS,
+				TX_PKT_ATTR_VLAN_CTAG_LEN, 1);
+		if (netif_msg_tx_done(pdata))
+			yt_dbg(pdata, "%s,VLAN, pkt desc cnt=%d,vlan=0x%04x\n",
+			       __func__, pkt_info->desc_count,
+			       skb_vlan_tag_get(skb));
+	}
+
+	for (len = skb_headlen(skb); len;) {
+		pkt_info->desc_count++;
+		len -= min_t(unsigned int, len, FXGMAC_TX_MAX_BUF_SIZE);
+	}
+
+	for (u32 i = 0; i < skb_shinfo(skb)->nr_frags; i++)
+		for (len = skb_frag_size(&skb_shinfo(skb)->frags[i]); len;) {
+			pkt_info->desc_count++;
+			len -= min_t(unsigned int, len, FXGMAC_TX_MAX_BUF_SIZE);
+		}
+
+	if (netif_msg_tx_done(pdata))
+		yt_dbg(pdata,
+		       "%s,pkt desc cnt%d,skb len%d, skbheadlen=%d,frags=%d\n",
+		       __func__, pkt_info->desc_count, skb->len,
+		       skb_headlen(skb), skb_shinfo(skb)->nr_frags);
+}
+
+static int fxgmac_calc_rx_buf_size(struct fxgmac_pdata *pdata, unsigned int mtu)
+{
+	unsigned int rx_buf_size, max_mtu;
+
+	max_mtu = FXGMAC_JUMBO_PACKET_MTU - ETH_HLEN;
+	if (mtu > max_mtu) {
+		yt_err(pdata, "MTU exceeds maximum supported value\n");
+		return -EINVAL;
+	}
+
+	rx_buf_size = mtu + ETH_HLEN + ETH_FCS_LEN + VLAN_HLEN;
+	rx_buf_size =
+		clamp_val(rx_buf_size, FXGMAC_RX_MIN_BUF_SIZE, PAGE_SIZE * 4);
+
+	rx_buf_size = (rx_buf_size + FXGMAC_RX_BUF_ALIGN - 1) &
+		      ~(FXGMAC_RX_BUF_ALIGN - 1);
+
+	return rx_buf_size;
+}
+
+static void fxgmac_enable_rx_tx_ints(struct fxgmac_pdata *pdata)
+{
+	struct fxgmac_channel *channel = pdata->channel_head;
+	struct fxgmac_hw_ops *hw_ops = &pdata->hw_ops;
+	enum fxgmac_int int_id;
+
+	for (u32 i = 0; i < pdata->channel_count; i++, channel++) {
+		if (channel->tx_ring && channel->rx_ring)
+			int_id = FXGMAC_INT_DMA_CH_SR_TI_RI;
+		else if (channel->tx_ring)
+			int_id = FXGMAC_INT_DMA_CH_SR_TI;
+		else if (channel->rx_ring)
+			int_id = FXGMAC_INT_DMA_CH_SR_RI;
+		else
+			continue;
+
+		hw_ops->enable_channel_irq(channel, int_id);
+	}
+}
+
+static int fxgmac_misc_poll(struct napi_struct *napi, int budget)
+{
+	struct fxgmac_pdata *pdata =
+		container_of(napi, struct fxgmac_pdata, napi_misc);
+	struct fxgmac_hw_ops *hw_ops = &pdata->hw_ops;
+
+	if (napi_complete_done(napi, 0))
+		hw_ops->enable_msix_one_irq(pdata, MSI_ID_PHY_OTHER);
+
+	return 0;
+}
+
+static irqreturn_t fxgmac_misc_isr(int irq, void *data)
+{
+	struct fxgmac_pdata *pdata = data;
+	struct fxgmac_hw_ops *hw_ops;
+	u32 val;
+
+	val = rd32_mem(pdata, MGMT_INT_CTRL0);
+	if (!(val & MGMT_INT_CTRL0_INT_STATUS_MISC))
+		return IRQ_HANDLED;
+
+	hw_ops = &pdata->hw_ops;
+	hw_ops->disable_msix_one_irq(pdata, MSI_ID_PHY_OTHER);
+	hw_ops->clear_misc_int_status(pdata);
+
+	napi_schedule_irqoff(&pdata->napi_misc);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t fxgmac_isr(int irq, void *data)
+{
+	struct fxgmac_pdata *pdata = data;
+	struct fxgmac_hw_ops *hw_ops;
+	u32 val, mgm_intctrl_val;
+	unsigned int isr;
+
+	val = rd32_mem(pdata, MGMT_INT_CTRL0);
+	if (!(val &
+	      (MGMT_INT_CTRL0_INT_STATUS_RX | MGMT_INT_CTRL0_INT_STATUS_TX |
+	       MGMT_INT_CTRL0_INT_STATUS_MISC)))
+		return IRQ_HANDLED;
+
+	hw_ops = &pdata->hw_ops;
+	hw_ops->disable_mgm_irq(pdata);
+	mgm_intctrl_val = val;
+	pdata->stats.mgmt_int_isr++;
+
+	/* Handle dma channel isr */
+	for (u32 i = 0; i < pdata->channel_count; i++) {
+		isr = readl(FXGMAC_DMA_REG(pdata->channel_head + i, DMA_CH_SR));
+
+		if (isr & BIT(DMA_CH_SR_TPS_POS))
+			pdata->stats.tx_process_stopped++;
+
+		if (isr & BIT(DMA_CH_SR_RPS_POS))
+			pdata->stats.rx_process_stopped++;
+
+		if (isr & BIT(DMA_CH_SR_TBU_POS))
+			pdata->stats.tx_buffer_unavailable++;
+
+		if (isr & BIT(DMA_CH_SR_RBU_POS))
+			pdata->stats.rx_buffer_unavailable++;
+
+		/* Restart the device on a Fatal Bus Error */
+		if (isr & BIT(DMA_CH_SR_FBE_POS)) {
+			pdata->stats.fatal_bus_error++;
+			schedule_work(&pdata->restart_work);
+		}
+
+		/* Clear all interrupt signals */
+		writel(isr, FXGMAC_DMA_REG(pdata->channel_head + i, DMA_CH_SR));
+	}
+
+	if (mgm_intctrl_val & MGMT_INT_CTRL0_INT_STATUS_MISC)
+		hw_ops->clear_misc_int_status(pdata);
+
+	if (napi_schedule_prep(&pdata->napi)) {
+		pdata->stats.napi_poll_isr++;
+		__napi_schedule_irqoff(&pdata->napi); /* Turn on polling */
+	}
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t fxgmac_dma_isr(int irq, void *data)
+{
+	struct fxgmac_channel *channel = data;
+	struct fxgmac_hw_ops *hw_ops;
+	struct fxgmac_pdata *pdata;
+	int message_id;
+	u32 val = 0;
+
+	pdata = channel->pdata;
+	hw_ops = &pdata->hw_ops;
+
+	if (irq == channel->dma_irq_tx) {
+		message_id = MSI_ID_TXQ0;
+		hw_ops->disable_msix_one_irq(pdata, message_id);
+		fxgmac_set_bits(&val, DMA_CH_SR_TI_POS, DMA_CH_SR_TI_LEN, 1);
+		writel(val, FXGMAC_DMA_REG(channel, DMA_CH_SR));
+		napi_schedule_irqoff(&channel->napi_tx);
+
+		return IRQ_HANDLED;
+	}
+
+	message_id = channel->queue_index;
+	hw_ops->disable_msix_one_irq(pdata, message_id);
+	val = readl(FXGMAC_DMA_REG(channel, DMA_CH_SR));
+	fxgmac_set_bits(&val, DMA_CH_SR_RI_POS, DMA_CH_SR_RI_LEN, 1);
+	writel(val, FXGMAC_DMA_REG(channel, DMA_CH_SR));
+	napi_schedule_irqoff(&channel->napi_rx);
+
+	return IRQ_HANDLED;
+}
+
+static void fxgmac_napi_enable(struct fxgmac_pdata *pdata, unsigned int add)
+{
+	u32 i, *flags = &pdata->int_flags;
+	struct fxgmac_channel *channel;
+	u32 misc_napi, tx, rx;
+
+	misc_napi = FIELD_GET(BIT(FXGMAC_FLAG_MISC_NAPI_POS), *flags);
+	tx = FXGMAC_GET_BITS(*flags, FXGMAC_FLAG_TX_NAPI_POS,
+			     FXGMAC_FLAG_TX_NAPI_LEN);
+	rx = FXGMAC_GET_BITS(*flags, FXGMAC_FLAG_RX_NAPI_POS,
+			     FXGMAC_FLAG_RX_NAPI_LEN);
+
+	if (!pdata->per_channel_irq) {
+		i = FIELD_GET(BIT(FXGMAC_FLAG_LEGACY_NAPI_POS), *flags);
+		if (i)
+			return;
+
+		if (add) {
+			netif_napi_add_weight(pdata->netdev, &pdata->napi,
+					      fxgmac_all_poll,
+					      NAPI_POLL_WEIGHT);
+		}
+
+		napi_enable(&pdata->napi);
+		fxgmac_set_bits(flags, FXGMAC_FLAG_LEGACY_NAPI_POS,
+				FXGMAC_FLAG_LEGACY_NAPI_LEN,
+				FXGMAC_NAPI_ENABLE);
+		return;
+	}
+
+	channel = pdata->channel_head;
+
+	for (i = 0; i < pdata->channel_count; i++, channel++) {
+		if (!FXGMAC_GET_BITS(rx, i, FXGMAC_FLAG_PER_RX_NAPI_LEN)) {
+			if (add) {
+				netif_napi_add_weight(pdata->netdev,
+						      &channel->napi_rx,
+						      fxgmac_one_poll_rx,
+						      NAPI_POLL_WEIGHT);
+			}
+			napi_enable(&channel->napi_rx);
+			fxgmac_set_bits(flags, FXGMAC_FLAG_RX_NAPI_POS + i,
+					FXGMAC_FLAG_PER_RX_NAPI_LEN,
+					FXGMAC_NAPI_ENABLE);
+		}
+
+		if (FXGMAC_IS_CHANNEL_WITH_TX_IRQ(i) && !tx) {
+			netif_napi_add_weight(pdata->netdev, &channel->napi_tx,
+					      fxgmac_one_poll_tx,
+					      NAPI_POLL_WEIGHT);
+			napi_enable(&channel->napi_tx);
+			fxgmac_set_bits(flags, FXGMAC_FLAG_TX_NAPI_POS,
+					FXGMAC_FLAG_TX_NAPI_LEN,
+					FXGMAC_NAPI_ENABLE);
+		}
+		if (netif_msg_drv(pdata))
+			yt_dbg(pdata, "msix ch%d napi enabled done,add=%d\n", i,
+			       add);
+	}
+
+	/* for misc */
+	if (!misc_napi) {
+		netif_napi_add_weight(pdata->netdev, &pdata->napi_misc,
+				      fxgmac_misc_poll, NAPI_POLL_WEIGHT);
+
+		napi_enable(&pdata->napi_misc);
+		fxgmac_set_bits(flags, FXGMAC_FLAG_MISC_NAPI_POS,
+				FXGMAC_FLAG_MISC_NAPI_LEN, FXGMAC_NAPI_ENABLE);
+	}
+}
+
+static void fxgmac_napi_disable(struct fxgmac_pdata *pdata, unsigned int del)
+{
+	u32 i, *flags = &pdata->int_flags;
+	struct fxgmac_channel *channel;
+	u32 misc_napi, tx, rx, val;
+
+	misc_napi = FIELD_GET(BIT(FXGMAC_FLAG_MISC_NAPI_POS), *flags);
+	tx = FXGMAC_GET_BITS(*flags, FXGMAC_FLAG_TX_NAPI_POS,
+			     FXGMAC_FLAG_TX_NAPI_LEN);
+	rx = FXGMAC_GET_BITS(*flags, FXGMAC_FLAG_RX_NAPI_POS,
+			     FXGMAC_FLAG_RX_NAPI_LEN);
+
+	if (!pdata->per_channel_irq) {
+		val = FIELD_GET(BIT(FXGMAC_FLAG_LEGACY_NAPI_POS), *flags);
+		if (val == 0)
+			return;
+
+		napi_disable(&pdata->napi);
+
+		if (del)
+			netif_napi_del(&pdata->napi);
+
+		fxgmac_set_bits(flags, FXGMAC_FLAG_LEGACY_NAPI_POS,
+				FXGMAC_FLAG_LEGACY_NAPI_LEN,
+				FXGMAC_NAPI_DISABLE);
+
+		return;
+	}
+
+	channel = pdata->channel_head;
+	if (!channel)
+		return;
+
+	for (i = 0; i < pdata->channel_count; i++, channel++) {
+		if (FXGMAC_GET_BITS(rx, i, FXGMAC_FLAG_PER_RX_NAPI_LEN)) {
+			napi_disable(&channel->napi_rx);
+
+			if (del)
+				netif_napi_del(&channel->napi_rx);
+
+			fxgmac_set_bits(flags, FXGMAC_FLAG_RX_NAPI_POS + i,
+					FXGMAC_FLAG_PER_RX_NAPI_LEN,
+					FXGMAC_NAPI_DISABLE);
+		}
+
+		if (FXGMAC_IS_CHANNEL_WITH_TX_IRQ(i) && tx) {
+			napi_disable(&channel->napi_tx);
+			netif_napi_del(&channel->napi_tx);
+			fxgmac_set_bits(flags, FXGMAC_FLAG_TX_NAPI_POS,
+					FXGMAC_FLAG_TX_NAPI_LEN,
+					FXGMAC_NAPI_DISABLE);
+		}
+
+		if (netif_msg_drv(pdata))
+			yt_dbg(pdata,
+			       "napi_disable, msix ch%d, napi disabled done,del=%d",
+			       i, del);
+	}
+
+	if (misc_napi) {
+		napi_disable(&pdata->napi_misc);
+		netif_napi_del(&pdata->napi_misc);
+		fxgmac_set_bits(flags, FXGMAC_FLAG_MISC_NAPI_POS,
+				FXGMAC_FLAG_MISC_NAPI_LEN, FXGMAC_NAPI_DISABLE);
+	}
+}
+
+static int fxgmac_request_irqs(struct fxgmac_pdata *pdata)
+{
+	struct net_device *netdev = pdata->netdev;
+	u32 *flags = &pdata->int_flags;
+	struct fxgmac_channel *channel;
+	u32 misc, tx, rx, need_free;
+	u32 i, msix, msi;
+	int ret;
+
+	msi = FIELD_GET(FXGMAC_FLAG_MSI_ENABLED, *flags);
+	msix = FIELD_GET(FXGMAC_FLAG_MSIX_ENABLED, *flags);
+	need_free = FIELD_GET(BIT(FXGMAC_FLAG_LEGACY_IRQ_POS), *flags);
+
+	if (!msix && !need_free) {
+		ret = devm_request_irq(pdata->dev, pdata->dev_irq, fxgmac_isr,
+				       msi ? 0 : IRQF_SHARED, netdev->name,
+				       pdata);
+		if (ret) {
+			yt_err(pdata, "error requesting irq %d, ret = %d\n",
+			       pdata->dev_irq, ret);
+			return ret;
+		}
+
+		fxgmac_set_bits(flags, FXGMAC_FLAG_LEGACY_IRQ_POS,
+				FXGMAC_FLAG_LEGACY_IRQ_LEN, FXGMAC_IRQ_ENABLE);
+	}
+
+	if (!pdata->per_channel_irq)
+		return 0;
+
+	channel = pdata->channel_head;
+	if (!channel)
+		return 0;
+
+	tx = FXGMAC_GET_BITS(*flags, FXGMAC_FLAG_TX_IRQ_POS,
+			     FXGMAC_FLAG_TX_IRQ_LEN);
+	rx = FXGMAC_GET_BITS(*flags, FXGMAC_FLAG_RX_IRQ_POS,
+			     FXGMAC_FLAG_RX_IRQ_LEN);
+	misc = FXGMAC_GET_BITS(*flags, FXGMAC_FLAG_MISC_IRQ_POS,
+			       FXGMAC_FLAG_MISC_IRQ_LEN);
+	for (i = 0; i < pdata->channel_count; i++, channel++) {
+		snprintf(channel->dma_irq_rx_name,
+			 sizeof(channel->dma_irq_rx_name) - 1, "%s-ch%d-Rx-%u",
+			 netdev_name(netdev), i, channel->queue_index);
+
+		if (FXGMAC_IS_CHANNEL_WITH_TX_IRQ(i) && !tx) {
+			snprintf(channel->dma_irq_tx_name,
+				 sizeof(channel->dma_irq_tx_name) - 1,
+				 "%s-ch%d-Tx-%u", netdev_name(netdev), i,
+				 channel->queue_index);
+			ret = devm_request_irq(pdata->dev, channel->dma_irq_tx,
+					       fxgmac_dma_isr, 0,
+					       channel->dma_irq_tx_name,
+					       channel);
+			if (ret) {
+				yt_err(pdata,
+				       "%s, err with MSIx irq, request for ch %d tx, ret=%d\n",
+				       __func__, i, ret);
+				goto err_irq;
+			}
+
+			fxgmac_set_bits(flags, FXGMAC_FLAG_TX_IRQ_POS,
+					FXGMAC_FLAG_TX_IRQ_LEN,
+					FXGMAC_IRQ_ENABLE);
+
+			if (netif_msg_drv(pdata)) {
+				yt_dbg(pdata,
+				       "%s, MSIx irq_tx request ok, ch=%d, irq=%d,%s\n",
+				       __func__, i, channel->dma_irq_tx,
+				       channel->dma_irq_tx_name);
+			}
+		}
+
+		if (!FXGMAC_GET_BITS(rx, i, FXGMAC_FLAG_PER_RX_IRQ_LEN)) {
+			ret = devm_request_irq(pdata->dev, channel->dma_irq_rx,
+					       fxgmac_dma_isr, 0,
+					       channel->dma_irq_rx_name,
+					       channel);
+			if (ret) {
+				yt_err(pdata, "error requesting irq %d\n",
+				       channel->dma_irq_rx);
+				goto err_irq;
+			}
+			fxgmac_set_bits(flags, FXGMAC_FLAG_RX_IRQ_POS + i,
+					FXGMAC_FLAG_PER_RX_IRQ_LEN,
+					FXGMAC_IRQ_ENABLE);
+		}
+	}
+
+	if (!misc) {
+		snprintf(pdata->misc_irq_name, sizeof(pdata->misc_irq_name) - 1,
+			 "%s-misc", netdev_name(netdev));
+		ret = devm_request_irq(pdata->dev, pdata->misc_irq,
+				       fxgmac_misc_isr, 0, pdata->misc_irq_name,
+				       pdata);
+		if (ret) {
+			yt_err(pdata,
+			       "error requesting misc irq %d, ret = %d\n",
+			       pdata->misc_irq, ret);
+			goto err_irq;
+		}
+		fxgmac_set_bits(flags, FXGMAC_FLAG_MISC_IRQ_POS,
+				FXGMAC_FLAG_MISC_IRQ_LEN, FXGMAC_IRQ_ENABLE);
+	}
+
+	if (netif_msg_drv(pdata))
+		yt_dbg(pdata, "%s, MSIx irq request ok, total=%d,%d~%d\n",
+		       __func__, i, (pdata->channel_head)[0].dma_irq_rx,
+		       (pdata->channel_head)[i - 1].dma_irq_rx);
+
+	return 0;
+
+err_irq:
+	yt_err(pdata, "%s, err with MSIx irq request at %d,ret=%d\n", __func__,
+	       i, ret);
+
+	for (i--, channel--; i < pdata->channel_count; i--, channel--) {
+		if (FXGMAC_IS_CHANNEL_WITH_TX_IRQ(i) && tx) {
+			fxgmac_set_bits(flags, FXGMAC_FLAG_TX_IRQ_POS,
+					FXGMAC_FLAG_TX_IRQ_LEN,
+					FXGMAC_IRQ_DISABLE);
+			devm_free_irq(pdata->dev, channel->dma_irq_tx, channel);
+		}
+
+		if (FXGMAC_GET_BITS(rx, i, FXGMAC_FLAG_PER_RX_IRQ_LEN)) {
+			fxgmac_set_bits(flags, FXGMAC_FLAG_RX_IRQ_POS + i,
+					FXGMAC_FLAG_PER_RX_IRQ_LEN,
+					FXGMAC_IRQ_DISABLE);
+
+			devm_free_irq(pdata->dev, channel->dma_irq_rx, channel);
+		}
+	}
+
+	if (misc) {
+		fxgmac_set_bits(flags, FXGMAC_FLAG_MISC_IRQ_POS,
+				FXGMAC_FLAG_MISC_IRQ_LEN, FXGMAC_IRQ_DISABLE);
+		devm_free_irq(pdata->dev, pdata->misc_irq, pdata);
+	}
+
+	return ret;
+}
+
+static void fxgmac_free_irqs(struct fxgmac_pdata *pdata)
+{
+	u32 i, need_free, misc, tx, rx, msix;
+	u32 *flags = &pdata->int_flags;
+	struct fxgmac_channel *channel;
+
+	msix = FIELD_GET(FXGMAC_FLAG_MSIX_ENABLED, *flags);
+	need_free = FIELD_GET(BIT(FXGMAC_FLAG_LEGACY_IRQ_POS), *flags);
+	if (!msix && need_free) {
+		devm_free_irq(pdata->dev, pdata->dev_irq, pdata);
+		fxgmac_set_bits(flags, FXGMAC_FLAG_LEGACY_IRQ_POS,
+				FXGMAC_FLAG_LEGACY_IRQ_LEN, FXGMAC_IRQ_DISABLE);
+	}
+
+	if (!pdata->per_channel_irq)
+		return;
+
+	channel = pdata->channel_head;
+	if (!channel)
+		return;
+
+	misc = FIELD_GET(BIT(FXGMAC_FLAG_MISC_IRQ_POS), *flags);
+	tx = FXGMAC_GET_BITS(*flags, FXGMAC_FLAG_TX_IRQ_POS,
+			     FXGMAC_FLAG_TX_IRQ_LEN);
+	rx = FXGMAC_GET_BITS(*flags, FXGMAC_FLAG_RX_IRQ_POS,
+			     FXGMAC_FLAG_RX_IRQ_LEN);
+	for (i = 0; i < pdata->channel_count; i++, channel++) {
+		if (FXGMAC_IS_CHANNEL_WITH_TX_IRQ(i) && tx) {
+			fxgmac_set_bits(flags, FXGMAC_FLAG_TX_IRQ_POS,
+					FXGMAC_FLAG_TX_IRQ_LEN,
+					FXGMAC_IRQ_DISABLE);
+			devm_free_irq(pdata->dev, channel->dma_irq_tx, channel);
+			if (netif_msg_drv(pdata))
+				yt_dbg(pdata,
+				       "%s, MSIx irq_tx clear done ch=%d\n",
+				       __func__, i);
+		}
+
+		if (FXGMAC_GET_BITS(rx, i, FXGMAC_FLAG_PER_RX_IRQ_LEN)) {
+			fxgmac_set_bits(flags, FXGMAC_FLAG_RX_IRQ_POS + i,
+					FXGMAC_FLAG_PER_RX_IRQ_LEN,
+					FXGMAC_IRQ_DISABLE);
+			devm_free_irq(pdata->dev, channel->dma_irq_rx, channel);
+		}
+	}
+
+	if (misc) {
+		fxgmac_set_bits(flags, FXGMAC_FLAG_MISC_IRQ_POS,
+				FXGMAC_FLAG_MISC_IRQ_LEN, FXGMAC_IRQ_DISABLE);
+		devm_free_irq(pdata->dev, pdata->misc_irq, pdata);
+	}
+	if (netif_msg_drv(pdata))
+		yt_dbg(pdata, "%s, MSIx rx irq clear done, total=%d\n",
+		       __func__, i);
+}
+
+void fxgmac_free_tx_data(struct fxgmac_pdata *pdata)
+{
+	struct fxgmac_channel *channel = pdata->channel_head;
+	struct fxgmac_desc_data *desc_data;
+	struct fxgmac_ring *ring;
+
+	if (channel) {
+		for (u32 i = 0; i < pdata->channel_count; i++, channel++) {
+			ring = channel->tx_ring;
+			if (!ring)
+				break;
+
+			for (u32 j = 0; j < ring->dma_desc_count; j++) {
+				desc_data = FXGMAC_GET_DESC_DATA(ring, j);
+				fxgmac_desc_data_unmap(pdata, desc_data);
+			}
+		}
+	}
+}
+
+void fxgmac_free_rx_data(struct fxgmac_pdata *pdata)
+{
+	struct fxgmac_channel *channel = pdata->channel_head;
+	struct fxgmac_desc_data *desc_data;
+	struct fxgmac_ring *ring;
+
+	if (channel) {
+		for (u32 i = 0; i < pdata->channel_count; i++, channel++) {
+			ring = channel->rx_ring;
+			if (!ring)
+				break;
+
+			for (u32 j = 0; j < ring->dma_desc_count; j++) {
+				desc_data = FXGMAC_GET_DESC_DATA(ring, j);
+				fxgmac_desc_data_unmap(pdata, desc_data);
+			}
+		}
+	}
+}
+
+#define PCI_CAP_ID_MSI_ENABLE_POS   0x10
+#define PCI_CAP_ID_MSI_ENABLE_LEN   0x1
+#define PCI_CAP_ID_MSIX_ENABLE_POS   0x1F
+#define PCI_CAP_ID_MSIX_ENABLE_LEN   0x1
+
+static int fxgmac_disable_pci_msi_config(struct fxgmac_pdata *pdata)
+{
+	u32 pcie_msi_mask_bits = 0, pcie_cap_offset = 0;
+	struct pci_dev *pdev = to_pci_dev(pdata->dev);
+	int ret = 0;
+
+	pcie_cap_offset = pci_find_capability(pdev, PCI_CAP_ID_MSI);
+	if (pcie_cap_offset) {
+		ret = pci_read_config_dword(pdev, pcie_cap_offset,
+					    &pcie_msi_mask_bits);
+		if (ret) {
+			yt_err(pdata,
+			       "read pci config space MSI cap. err :%d\n", ret);
+			return -EFAULT;
+		}
+	}
+
+	fxgmac_set_bits(&pcie_msi_mask_bits, PCI_CAP_ID_MSI_ENABLE_POS,
+			PCI_CAP_ID_MSI_ENABLE_LEN, 0);
+	ret = pci_write_config_dword(pdev, pcie_cap_offset, pcie_msi_mask_bits);
+	if (ret) {
+		yt_err(pdata, "write pci config space MSI mask err :%d\n", ret);
+		return -EFAULT;
+	}
+
+	return ret;
+}
+
+static int fxgmac_disable_pci_msix_config(struct fxgmac_pdata *pdata)
+{
+	u32 pcie_msi_mask_bits = 0;
+	u16 pcie_cap_offset = 0;
+	struct pci_dev *pdev = to_pci_dev(pdata->dev);
+	int ret = 0;
+
+	pcie_cap_offset = pci_find_capability(pdev, PCI_CAP_ID_MSIX);
+	if (pcie_cap_offset) {
+		ret = pci_read_config_dword(pdev, pcie_cap_offset,
+					    &pcie_msi_mask_bits);
+		if (ret) {
+			yt_err(pdata,
+			       "read pci config space MSIX cap. err: %d\n",
+			       ret);
+			return -EFAULT;
+		}
+	}
+
+	fxgmac_set_bits(&pcie_msi_mask_bits, PCI_CAP_ID_MSIX_ENABLE_POS,
+			PCI_CAP_ID_MSIX_ENABLE_LEN, 0);
+	ret = pci_write_config_dword(pdev, pcie_cap_offset, pcie_msi_mask_bits);
+	if (ret) {
+		yt_err(pdata, "write pci config space MSIX mask err:%d\n", ret);
+		return -EFAULT;
+	}
+
+	return ret;
+}
+
+int fxgmac_start(struct fxgmac_pdata *pdata)
+{
+	struct fxgmac_hw_ops *hw_ops = &pdata->hw_ops;
+	unsigned int pcie_low_power = 0;
+	u32 val;
+	int ret;
+
+	if (pdata->dev_state != FXGMAC_DEV_OPEN &&
+	    pdata->dev_state != FXGMAC_DEV_STOP &&
+	    pdata->dev_state != FXGMAC_DEV_RESUME)
+		return 0;
+
+	/* must reset software again here, to avoid flushing tx queue error
+	 * caused by the system only run probe
+	 * when installing driver on the arm platform.
+	 */
+	hw_ops->exit(pdata);
+
+	if (pdata->int_flags & FXGMAC_FLAG_LEGACY_ENABLED) {
+		/* we should disable msi and msix here when we use legacy
+		 * interrupt,for two reasons:
+		 * 1. Exit will restore msi and msix config regisiter,
+		 * that may enable them.
+		 * 2. When the driver that uses the msix interrupt by default
+		 * is compiled into the OS, uninstall the driver through rmmod,
+		 * and then install the driver that uses the legacy interrupt,
+		 * at which time the msix enable will be turned on again by
+		 * default after waking up from S4 on some
+		 * platform. such as UOS platform.
+		 */
+		ret = fxgmac_disable_pci_msi_config(pdata);
+		if (ret < 0)
+			return ret;
+
+		ret = fxgmac_disable_pci_msix_config(pdata);
+		if (ret < 0)
+			return ret;
+	}
+
+	fxgmac_phy_reset(pdata);
+	ret = fxgmac_phy_release(pdata);
+	if (ret < 0)
+		return ret;
+
+#define PCIE_LP_ASPM_L0S		1
+#define PCIE_LP_ASPM_L1			2
+#define PCIE_LP_ASPM_L1SS		4
+#define PCIE_LP_ASPM_LTR		8
+	hw_ops->pcie_init(pdata, pcie_low_power & PCIE_LP_ASPM_LTR,
+			  pcie_low_power & PCIE_LP_ASPM_L1SS,
+			  pcie_low_power & PCIE_LP_ASPM_L1,
+			  pcie_low_power & PCIE_LP_ASPM_L0S);
+	if (test_bit(FXGMAC_POWER_STATE_DOWN, &pdata->powerstate)) {
+		yt_err(pdata,
+		       "fxgmac powerstate is %lu when config power up.\n",
+		       pdata->powerstate);
+	}
+
+	ret = hw_ops->config_power_up(pdata);
+	if (ret < 0)
+		goto dis_napi;
+
+	hw_ops->dismiss_all_int(pdata);
+
+	rd32_mem(pdata, MGMT_INT_CTRL0); /* control module int to PCIe slot */
+
+	ret = hw_ops->init(pdata);
+	if (ret < 0) {
+		yt_err(pdata, "fxgmac hw init error.\n");
+		return ret;
+	}
+
+	fxgmac_napi_enable(pdata, 1);
+	ret = fxgmac_request_irqs(pdata);
+	if (ret < 0)
+		goto dis_napi;
+
+	hw_ops->enable_tx(pdata);
+	hw_ops->enable_rx(pdata);
+
+	/* config interrupt to level signal */
+	val = rd32_mac(pdata, DMA_MR);
+	fxgmac_set_bits(&val, DMA_MR_INTM_POS, DMA_MR_INTM_LEN, 1);
+	fxgmac_set_bits(&val, DMA_MR_QUREAD_POS, DMA_MR_QUREAD_LEN, 1);
+	wr32_mac(pdata, val, DMA_MR);
+
+	hw_ops->enable_mgm_irq(pdata);
+	hw_ops->set_interrupt_moderation(pdata);
+
+	if (pdata->per_channel_irq) {
+		hw_ops->enable_msix_irqs(pdata);
+		ret = fxgmac_phy_irq_enable(pdata, true);
+		if (ret < 0)
+			goto dis_napi;
+	}
+
+	fxgmac_enable_rx_tx_ints(pdata);
+	fxgmac_schedule_esd_work(pdata);
+	ret = fxgmac_phy_set_link_ksettings(pdata);
+	if (ret < 0) {
+		yt_err(pdata, "fxgmac_phy_set_link_ksettings error.\n");
+		goto dis_napi;
+	}
+	ret = fxgmac_phy_cfg_led(pdata, pdata->led.s0);
+	if (ret < 0) {
+		yt_err(pdata, "fxgmac_phy_cfg_led error.\n");
+		goto dis_napi;
+	}
+
+	pdata->dev_state = FXGMAC_DEV_START;
+	fxgmac_phy_timer_init(pdata);
+
+	return 0;
+
+dis_napi:
+	fxgmac_phy_timer_destroy(pdata);
+	fxgmac_napi_disable(pdata, 1);
+	hw_ops->exit(pdata);
+	yt_err(pdata, "%s irq err.\n", __func__);
+	return ret;
+}
+
+void fxgmac_stop(struct fxgmac_pdata *pdata)
+{
+	struct fxgmac_channel *channel = pdata->channel_head;
+	struct fxgmac_hw_ops *hw_ops = &pdata->hw_ops;
+	struct net_device *netdev = pdata->netdev;
+	struct netdev_queue *txq;
+
+	if (pdata->dev_state != FXGMAC_DEV_START)
+		return;
+
+	pdata->dev_state = FXGMAC_DEV_STOP;
+
+	if (pdata->per_channel_irq)
+		hw_ops->disable_msix_irqs(pdata);
+	else
+		hw_ops->disable_mgm_irq(pdata);
+
+	pdata->phy_link = false;
+	netif_carrier_off(netdev);
+	netif_tx_stop_all_queues(netdev);
+	hw_ops->disable_tx(pdata);
+	hw_ops->disable_rx(pdata);
+	fxgmac_free_irqs(pdata);
+	fxgmac_napi_disable(pdata, 1);
+
+	if (channel) {
+		for (u32 i = 0; i < pdata->channel_count; i++, channel++) {
+			if (!channel->tx_ring)
+				continue;
+
+			txq = netdev_get_tx_queue(netdev, channel->queue_index);
+			netdev_tx_reset_queue(txq);
+		}
+	}
+	fxgmac_phy_timer_destroy(pdata);
+}
+
+void fxgmac_restart(struct fxgmac_pdata *pdata)
+{
+	int ret;
+
+	/* If not running, "restart" will happen on open */
+	if (!netif_running(pdata->netdev) &&
+	    pdata->dev_state != FXGMAC_DEV_START)
+		return;
+
+	fxgmac_lock(pdata);
+	fxgmac_stop(pdata);
+	ret = fxgmac_phy_cfg_led(pdata, pdata->led.s5);
+	if (ret < 0)
+		yt_err(pdata, "%s, fxgmac_phy_cfg_led err.\n", __func__);
+
+	fxgmac_free_tx_data(pdata);
+	fxgmac_free_rx_data(pdata);
+	ret = fxgmac_start(pdata);
+	if (ret < 0)
+		yt_err(pdata, "%s, fxgmac_start err.\n", __func__);
+
+	fxgmac_unlock(pdata);
+}
+
+static void fxgmac_restart_work(struct work_struct *work)
+{
+	struct fxgmac_pdata *pdata =
+		container_of(work, struct fxgmac_pdata, restart_work);
+
+	rtnl_lock();
+	fxgmac_restart(pdata);
+	rtnl_unlock();
+}
+
+int fxgmac_net_powerup(struct fxgmac_pdata *pdata)
+{
+	struct fxgmac_hw_ops *hw_ops = &pdata->hw_ops;
+	int ret;
+
+	/* signal that we are up now */
+	pdata->powerstate = 0;
+	if (__test_and_set_bit(FXGMAC_POWER_STATE_UP, &pdata->powerstate))
+		return 0; /* do nothing if already up */
+
+	ret = fxgmac_start(pdata);
+	if (ret < 0) {
+		yt_err(pdata, "%s: fxgmac_start err: %d\n", __func__, ret);
+		return ret;
+	}
+
+	/* must call it after fxgmac_start,because it will be
+	 * enable in fxgmac_start
+	 */
+	hw_ops->disable_arp_offload(pdata);
+
+	if (netif_msg_drv(pdata))
+		yt_dbg(pdata, "%s, powerstate :%ld.\n", __func__,
+		       pdata->powerstate);
+
+	return 0;
+}
+
+int fxgmac_net_powerdown(struct fxgmac_pdata *pdata, unsigned int wol)
+{
+	struct fxgmac_hw_ops *hw_ops = &pdata->hw_ops;
+	struct net_device *netdev = pdata->netdev;
+	int ret;
+
+	/* signal that we are down to the interrupt handler */
+	if (__test_and_set_bit(FXGMAC_POWER_STATE_DOWN, &pdata->powerstate))
+		return 0; /* do nothing if already down */
+
+	if (netif_msg_drv(pdata))
+		yt_dbg(pdata, "%s, continue with down process.\n", __func__);
+
+	__clear_bit(FXGMAC_POWER_STATE_UP, &pdata->powerstate);
+	netif_tx_stop_all_queues(netdev); /* Shut off incoming Tx traffic */
+
+	/* call carrier off first to avoid false dev_watchdog timeouts */
+	netif_carrier_off(netdev);
+	netif_tx_disable(netdev);
+	hw_ops->disable_rx(pdata); /* Disable Rx */
+
+	/* synchronize_rcu() needed for pending XDP buffers to drain */
+	synchronize_rcu();
+
+	fxgmac_cancel_esd_work(pdata);
+	fxgmac_stop(pdata);
+	ret = hw_ops->pre_power_down(pdata, false);
+	if (ret < 0) {
+		yt_err(pdata, "pre_power_down err.\n");
+		return ret;
+	}
+
+	if (!test_bit(FXGMAC_POWER_STATE_DOWN, &pdata->powerstate)) {
+		yt_err(pdata,
+		       "fxgmac powerstate is %lu when config powe down.\n",
+		       pdata->powerstate);
+	}
+
+	/* set mac to lowpower mode and enable wol accordingly */
+	hw_ops->config_power_down(pdata, wol);
+
+	fxgmac_free_tx_data(pdata);
+	fxgmac_free_rx_data(pdata);
+
+	if (netif_msg_drv(pdata))
+		yt_dbg(pdata, "%s, powerstate :%ld.\n", __func__,
+		       pdata->powerstate);
+
+	return 0;
+}
+
+static int fxgmac_open(struct net_device *netdev)
+{
+	struct fxgmac_pdata *pdata = netdev_priv(netdev);
+	int ret;
+
+	fxgmac_lock(pdata);
+	pdata->dev_state = FXGMAC_DEV_OPEN;
+
+	/* Calculate the Rx buffer size before allocating rings */
+	ret = fxgmac_calc_rx_buf_size(pdata, netdev->mtu);
+	if (ret < 0)
+		goto unlock;
+	pdata->rx_buf_size = ret;
+
+	/* Allocate the channels and rings */
+	ret = fxgmac_channels_rings_alloc(pdata);
+	if (ret < 0)
+		goto unlock;
+
+	INIT_WORK(&pdata->restart_work, fxgmac_restart_work);
+	INIT_DELAYED_WORK(&pdata->esd_work, fxgmac_esd_work);
+	ret = fxgmac_start(pdata);
+	if (ret < 0)
+		goto err_channels_and_rings;
+
+	fxgmac_unlock(pdata);
+
+	if (netif_msg_drv(pdata))
+		yt_dbg(pdata, "%s ok\n", __func__);
+
+	return 0;
+
+err_channels_and_rings:
+	fxgmac_channels_rings_free(pdata);
+	yt_dbg(pdata, "%s, channel alloc err\n", __func__);
+unlock:
+	fxgmac_unlock(pdata);
+	return ret;
+}
+
+static int fxgmac_close(struct net_device *netdev)
+{
+	struct fxgmac_pdata *pdata = netdev_priv(netdev);
+
+	fxgmac_lock(pdata);
+	fxgmac_stop(pdata);		/* Stop the device */
+	pdata->dev_state = FXGMAC_DEV_CLOSE;
+	fxgmac_cancel_esd_work(pdata);
+	fxgmac_channels_rings_free(pdata); /* Free the channels and rings */
+	fxgmac_phy_reset(pdata);
+	fxgmac_unlock(pdata);
+
+	if (netif_msg_drv(pdata))
+		yt_dbg(pdata, "%s ok\n", __func__);
+
+	return 0;
+}
+
+static inline void fxgmac_tx_timeout(struct net_device *netdev,
+				     unsigned int unused)
+{
+	struct fxgmac_pdata *pdata = netdev_priv(netdev);
+
+	yt_dbg(pdata, "tx timeout, device restarting.\n");
+	schedule_work(&pdata->restart_work);
+}
+
+static netdev_tx_t fxgmac_xmit(struct sk_buff *skb, struct net_device *netdev)
+{
+	struct fxgmac_pdata *pdata = netdev_priv(netdev);
+	struct fxgmac_pkt_info *tx_pkt_info;
+	struct fxgmac_channel *channel;
+	struct netdev_queue *txq;
+	struct fxgmac_ring *ring;
+	int ret;
+
+	if (netif_msg_tx_done(pdata))
+		yt_dbg(pdata, "%s, skb->len=%d,q=%d\n", __func__, skb->len,
+		       skb->queue_mapping);
+
+	channel = pdata->channel_head + skb->queue_mapping;
+	txq = netdev_get_tx_queue(netdev, channel->queue_index);
+	ring = channel->tx_ring;
+	tx_pkt_info = &ring->pkt_info;
+
+	if (skb->len == 0) {
+		yt_err(pdata, "empty skb received from stack\n");
+		dev_kfree_skb_any(skb);
+		return NETDEV_TX_OK;
+	}
+
+	/* Prepare preliminary packet info for TX */
+	memset(tx_pkt_info, 0, sizeof(*tx_pkt_info));
+	fxgmac_prep_tx_pkt(pdata, ring, skb, tx_pkt_info);
+
+	/* Check that there are enough descriptors available */
+	ret = fxgmac_maybe_stop_tx_queue(channel, ring,
+					 tx_pkt_info->desc_count);
+	if (ret == NETDEV_TX_BUSY)
+		return ret;
+
+	ret = fxgmac_prep_tso(pdata, skb, tx_pkt_info);
+	if (ret < 0) {
+		yt_err(pdata, "error processing TSO packet\n");
+		dev_kfree_skb_any(skb);
+		return NETDEV_TX_OK;
+	}
+	fxgmac_prep_vlan(skb, tx_pkt_info);
+
+	if (!fxgmac_tx_skb_map(channel, skb)) {
+		dev_kfree_skb_any(skb);
+		yt_err(pdata, "xmit, map tx skb err\n");
+		return NETDEV_TX_OK;
+	}
+
+	/* Report on the actual number of bytes (to be) sent */
+	netdev_tx_sent_queue(txq, tx_pkt_info->tx_bytes);
+	if (netif_msg_tx_done(pdata))
+		yt_dbg(pdata, "xmit,before hw_xmit, byte len=%d\n",
+		       tx_pkt_info->tx_bytes);
+
+	/* Configure required descriptor fields for transmission */
+	fxgmac_dev_xmit(channel);
+
+	if (netif_msg_pktdata(pdata))
+		fxgmac_dbg_pkt(pdata, skb, true);
+
+	/* Stop the queue in advance if there may not be enough descriptors */
+	fxgmac_maybe_stop_tx_queue(channel, ring, FXGMAC_TX_MAX_DESC_NR);
+
+	return NETDEV_TX_OK;
+}
+
+static void fxgmac_get_stats64(struct net_device *netdev,
+			       struct rtnl_link_stats64 *s)
+{
+	struct fxgmac_pdata *pdata = netdev_priv(netdev);
+	struct fxgmac_stats *pstats = &pdata->stats;
+
+	if (test_bit(FXGMAC_POWER_STATE_DOWN, &pdata->powerstate))
+		return;
+
+	pdata->hw_ops.read_mmc_stats(pdata);
+
+	s->rx_packets = pstats->rxframecount_gb;
+	s->rx_bytes = pstats->rxoctetcount_gb;
+	s->rx_errors = pstats->rxframecount_gb - pstats->rxbroadcastframes_g -
+		       pstats->rxmulticastframes_g - pstats->rxunicastframes_g;
+
+	s->rx_length_errors = pstats->rxlengtherror;
+	s->rx_crc_errors = pstats->rxcrcerror;
+	s->rx_fifo_errors = pstats->rxfifooverflow;
+
+	s->tx_packets = pstats->txframecount_gb;
+	s->tx_bytes = pstats->txoctetcount_gb;
+	s->tx_errors = pstats->txframecount_gb - pstats->txframecount_g;
+	s->tx_dropped = netdev->stats.tx_dropped;
+}
+
+static int fxgmac_set_mac_address(struct net_device *netdev, void *addr)
+{
+	struct fxgmac_pdata *pdata = netdev_priv(netdev);
+	struct fxgmac_hw_ops *hw_ops = &pdata->hw_ops;
+	struct sockaddr *saddr = addr;
+
+	if (!is_valid_ether_addr(saddr->sa_data))
+		return -EADDRNOTAVAIL;
+
+	eth_hw_addr_set(netdev, saddr->sa_data);
+	memcpy(pdata->mac_addr, saddr->sa_data, netdev->addr_len);
+	hw_ops->set_mac_address(pdata, saddr->sa_data);
+	hw_ops->set_mac_hash(pdata);
+
+	yt_dbg(pdata, "fxgmac,set mac addr to %02x:%02x:%02x:%02x:%02x:%02x\n",
+	       netdev->dev_addr[0], netdev->dev_addr[1], netdev->dev_addr[2],
+	       netdev->dev_addr[3], netdev->dev_addr[4], netdev->dev_addr[5]);
+
+	return 0;
+}
+
+static int fxgmac_change_mtu(struct net_device *netdev, int mtu)
+{
+	struct fxgmac_pdata *pdata = netdev_priv(netdev);
+	int old_mtu = netdev->mtu;
+	int ret, max_mtu;
+
+	max_mtu = FXGMAC_JUMBO_PACKET_MTU - ETH_HLEN;
+	if (mtu > max_mtu) {
+		yt_err(pdata, "MTU exceeds maximum supported value\n");
+		return -EINVAL;
+	}
+
+	fxgmac_lock(pdata);
+	fxgmac_stop(pdata);
+	fxgmac_free_tx_data(pdata);
+
+	/* We must unmap rx desc's dma before we change rx_buf_size.
+	 * Becaues the size of the unmapped DMA is set according to rx_buf_size
+	 */
+	fxgmac_free_rx_data(pdata);
+	pdata->jumbo = mtu > ETH_DATA_LEN ? 1 : 0;
+	ret = fxgmac_calc_rx_buf_size(pdata, mtu);
+	if (ret < 0)
+		return ret;
+
+	pdata->rx_buf_size = ret;
+	netdev->mtu = mtu;
+
+	if (netif_running(netdev))
+		fxgmac_start(pdata);
+
+	netdev_update_features(netdev);
+
+	fxgmac_unlock(pdata);
+
+	yt_dbg(pdata, "fxgmac,set MTU from %d to %d. min, max=(%d,%d)\n",
+	       old_mtu, netdev->mtu, netdev->min_mtu, netdev->max_mtu);
+
+	return 0;
+}
+
+static int fxgmac_vlan_rx_add_vid(struct net_device *netdev, __be16 proto,
+				  u16 vid)
+{
+	struct fxgmac_pdata *pdata = netdev_priv(netdev);
+	struct fxgmac_hw_ops *hw_ops = &pdata->hw_ops;
+
+	set_bit(vid, pdata->active_vlans);
+	hw_ops->update_vlan_hash_table(pdata);
+
+	yt_dbg(pdata, "fxgmac,add rx vlan %d\n", vid);
+
+	return 0;
+}
+
+static int fxgmac_vlan_rx_kill_vid(struct net_device *netdev, __be16 proto,
+				   u16 vid)
+{
+	struct fxgmac_pdata *pdata = netdev_priv(netdev);
+	struct fxgmac_hw_ops *hw_ops = &pdata->hw_ops;
+
+	clear_bit(vid, pdata->active_vlans);
+	hw_ops->update_vlan_hash_table(pdata);
+
+	yt_dbg(pdata, "fxgmac,del rx vlan %d\n", vid);
+
+	return 0;
+}
+
+#ifdef CONFIG_NET_POLL_CONTROLLER
+static void fxgmac_poll_controller(struct net_device *netdev)
+{
+	struct fxgmac_pdata *pdata = netdev_priv(netdev);
+	struct fxgmac_channel *channel;
+
+	if (pdata->per_channel_irq) {
+		channel = pdata->channel_head;
+		for (u32 i = 0; i < pdata->channel_count; i++, channel++)
+			fxgmac_dma_isr(channel->dma_irq_rx, channel);
+	} else {
+		disable_irq(pdata->dev_irq);
+		fxgmac_isr(pdata->dev_irq, pdata);
+		enable_irq(pdata->dev_irq);
+	}
+}
+#endif /* CONFIG_NET_POLL_CONTROLLER */
+
+static netdev_features_t fxgmac_fix_features(struct net_device *netdev,
+					     netdev_features_t features)
+{
+	struct fxgmac_pdata *pdata = netdev_priv(netdev);
+	u32 fifo_size;
+
+	fifo_size = pdata->hw_ops.calculate_max_checksum_size(pdata);
+	if (netdev->mtu > fifo_size) {
+		features &= ~NETIF_F_IP_CSUM;
+		features &= ~NETIF_F_IPV6_CSUM;
+	}
+
+	return features;
+}
+
+static int fxgmac_set_features(struct net_device *netdev,
+			       netdev_features_t features)
+{
+	netdev_features_t rxhash, rxcsum, rxvlan, rxvlan_filter, tso;
+	struct fxgmac_pdata *pdata = netdev_priv(netdev);
+	struct fxgmac_hw_ops *hw_ops;
+
+	hw_ops = &pdata->hw_ops;
+	rxhash = pdata->netdev_features & NETIF_F_RXHASH;
+	rxcsum = pdata->netdev_features & NETIF_F_RXCSUM;
+	rxvlan = pdata->netdev_features & NETIF_F_HW_VLAN_CTAG_RX;
+	rxvlan_filter = pdata->netdev_features & NETIF_F_HW_VLAN_CTAG_FILTER;
+	tso = pdata->netdev_features & (NETIF_F_TSO | NETIF_F_TSO6);
+
+	if ((features & (NETIF_F_TSO | NETIF_F_TSO6)) && !tso) {
+		yt_dbg(pdata, "enable tso.\n");
+		pdata->hw_feat.tso = 1;
+		hw_ops->config_tso(pdata);
+	} else if (!(features & (NETIF_F_TSO | NETIF_F_TSO6)) && tso) {
+		yt_dbg(pdata, "disable tso.\n");
+		pdata->hw_feat.tso = 0;
+		hw_ops->config_tso(pdata);
+	}
+
+	if ((features & NETIF_F_RXHASH) && !rxhash)
+		hw_ops->enable_rss(pdata);
+	else if (!(features & NETIF_F_RXHASH) && rxhash)
+		hw_ops->disable_rss(pdata);
+
+	if ((features & NETIF_F_RXCSUM) && !rxcsum)
+		hw_ops->enable_rx_csum(pdata);
+	else if (!(features & NETIF_F_RXCSUM) && rxcsum)
+		hw_ops->disable_rx_csum(pdata);
+
+	if ((features & NETIF_F_HW_VLAN_CTAG_RX) && !rxvlan)
+		hw_ops->enable_rx_vlan_stripping(pdata);
+	else if (!(features & NETIF_F_HW_VLAN_CTAG_RX) && rxvlan)
+		hw_ops->disable_rx_vlan_stripping(pdata);
+
+	if ((features & NETIF_F_HW_VLAN_CTAG_FILTER) && !rxvlan_filter)
+		hw_ops->enable_rx_vlan_filtering(pdata);
+	else if (!(features & NETIF_F_HW_VLAN_CTAG_FILTER) && rxvlan_filter)
+		hw_ops->disable_rx_vlan_filtering(pdata);
+
+	pdata->netdev_features = features;
+
+	yt_dbg(pdata, "fxgmac,set features done,%llx\n", (u64)features);
+	return 0;
+}
+
+static void fxgmac_set_rx_mode(struct net_device *netdev)
+{
+	struct fxgmac_pdata *pdata = netdev_priv(netdev);
+	struct fxgmac_hw_ops *hw_ops = &pdata->hw_ops;
+
+	hw_ops->config_rx_mode(pdata);
+}
+
+static const struct net_device_ops fxgmac_netdev_ops = {
+	.ndo_open		= fxgmac_open,
+	.ndo_stop		= fxgmac_close,
+	.ndo_start_xmit		= fxgmac_xmit,
+	.ndo_tx_timeout		= fxgmac_tx_timeout,
+	.ndo_get_stats64	= fxgmac_get_stats64,
+	.ndo_change_mtu		= fxgmac_change_mtu,
+	.ndo_set_mac_address	= fxgmac_set_mac_address,
+	.ndo_validate_addr	= eth_validate_addr,
+	.ndo_vlan_rx_add_vid	= fxgmac_vlan_rx_add_vid,
+	.ndo_vlan_rx_kill_vid	= fxgmac_vlan_rx_kill_vid,
+#ifdef CONFIG_NET_POLL_CONTROLLER
+	.ndo_poll_controller	= fxgmac_poll_controller,
+#endif
+	.ndo_set_features	= fxgmac_set_features,
+	.ndo_fix_features	= fxgmac_fix_features,
+	.ndo_set_rx_mode	= fxgmac_set_rx_mode,
+};
+
+const struct net_device_ops *fxgmac_get_netdev_ops(void)
+{
+	return &fxgmac_netdev_ops;
+}
+
+static void fxgmac_rx_refresh(struct fxgmac_channel *channel)
+{
+	struct fxgmac_pdata *pdata = channel->pdata;
+	struct fxgmac_ring *ring = channel->rx_ring;
+	struct fxgmac_desc_data *desc_data;
+
+	while (ring->dirty != ring->cur) {
+		desc_data = FXGMAC_GET_DESC_DATA(ring, ring->dirty);
+
+		/* Reset desc_data values */
+		fxgmac_desc_data_unmap(pdata, desc_data);
+
+		if (fxgmac_rx_buffe_map(pdata, ring, desc_data))
+			break;
+
+		fxgmac_desc_rx_reset(pdata, desc_data, ring->dirty);
+		ring->dirty =
+			FXGMAC_GET_ENTRY(ring->dirty, ring->dma_desc_count);
+	}
+
+	/* Make sure everything is written before the register write */
+	wmb();
+
+	/* Update the Rx Tail Pointer Register with address of
+	 * the last cleaned entry
+	 */
+	desc_data =
+		FXGMAC_GET_DESC_DATA(ring,
+				     (ring->dirty - 1) &
+				     (ring->dma_desc_count - 1));
+	writel(lower_32_bits(desc_data->dma_desc_addr),
+	       FXGMAC_DMA_REG(channel, DMA_CH_RDTR_LO));
+}
+
+static struct sk_buff *fxgmac_create_skb(struct fxgmac_pdata *pdata,
+					 struct napi_struct *napi,
+					 struct fxgmac_desc_data *desc_data,
+					 unsigned int len)
+{
+	unsigned int copy_len;
+	struct sk_buff *skb;
+	u8 *packet;
+
+	skb = napi_alloc_skb(napi, desc_data->rx.hdr.dma_len);
+	if (!skb)
+		return NULL;
+
+	/* Start with the header buffer which may contain just the header
+	 * or the header plus data
+	 */
+	dma_sync_single_range_for_cpu(pdata->dev, desc_data->rx.hdr.dma_base,
+				      desc_data->rx.hdr.dma_off,
+				      desc_data->rx.hdr.dma_len,
+				      DMA_FROM_DEVICE);
+
+	packet = page_address(desc_data->rx.hdr.pa.pages) +
+		 desc_data->rx.hdr.pa.pages_offset;
+	copy_len = min(desc_data->rx.hdr.dma_len, len);
+	skb_copy_to_linear_data(skb, packet, copy_len);
+	skb_put(skb, copy_len);
+
+	return skb;
+}
+
+static int fxgmac_tx_poll(struct fxgmac_channel *channel)
+{
+	struct fxgmac_pdata *pdata = channel->pdata;
+	unsigned int cur, tx_packets = 0, tx_bytes = 0;
+	struct fxgmac_ring *ring = channel->tx_ring;
+	struct net_device *netdev = pdata->netdev;
+	struct fxgmac_desc_data *desc_data;
+	struct fxgmac_dma_desc *dma_desc;
+	struct fxgmac_hw_ops *hw_ops;
+	struct netdev_queue *txq;
+	int processed = 0;
+
+	hw_ops = &pdata->hw_ops;
+
+	/* Nothing to do if there isn't a Tx ring for this channel */
+	if (!ring) {
+		if (netif_msg_tx_done(pdata) &&
+		    channel->queue_index < pdata->tx_q_count)
+			yt_dbg(pdata, "%s, null point to ring %d\n", __func__,
+			       channel->queue_index);
+		return 0;
+	}
+	if (ring->cur != ring->dirty && (netif_msg_tx_done(pdata)))
+		yt_dbg(pdata, "%s, ring_cur=%d,ring_dirty=%d,qIdx=%d\n",
+		       __func__, ring->cur, ring->dirty, channel->queue_index);
+
+	cur = ring->cur;
+
+	/* Be sure we get ring->cur before accessing descriptor data */
+	smp_rmb();
+
+	txq = netdev_get_tx_queue(netdev, channel->queue_index);
+	while (ring->dirty != cur) {
+		desc_data = FXGMAC_GET_DESC_DATA(ring, ring->dirty);
+		dma_desc = desc_data->dma_desc;
+
+		if (!hw_ops->is_tx_complete(dma_desc))
+			break;
+
+		/* Make sure descriptor fields are read after reading
+		 * the OWN bit
+		 */
+		dma_rmb();
+
+		if (netif_msg_tx_done(pdata))
+			fxgmac_dump_tx_desc(pdata, ring, ring->dirty, 1, 0);
+
+		if (hw_ops->is_last_desc(dma_desc)) {
+			tx_packets += desc_data->tx.packets;
+			tx_bytes += desc_data->tx.bytes;
+		}
+
+		/* Free the SKB and reset the descriptor for re-use */
+		fxgmac_desc_data_unmap(pdata, desc_data);
+		fxgmac_desc_tx_reset(desc_data);
+
+		processed++;
+		ring->dirty =
+			FXGMAC_GET_ENTRY(ring->dirty, ring->dma_desc_count);
+	}
+
+	if (!processed)
+		return 0;
+
+	netdev_tx_completed_queue(txq, tx_packets, tx_bytes);
+
+	/* Make sure ownership is written to the descriptor */
+	smp_wmb();
+	if (ring->tx.queue_stopped == 1 &&
+	    (fxgmac_desc_tx_avail(ring) > FXGMAC_TX_DESC_MIN_FREE)) {
+		ring->tx.queue_stopped = 0;
+		netif_tx_wake_queue(txq);
+	}
+
+	if (netif_msg_tx_done(pdata))
+		yt_dbg(pdata, "%s, processed=%d\n", __func__, processed);
+
+	return processed;
+}
+
+static int fxgmac_rx_poll(struct fxgmac_channel *channel, int budget)
+{
+	struct fxgmac_pdata *pdata = channel->pdata;
+	struct fxgmac_ring *ring = channel->rx_ring;
+	struct net_device *netdev = pdata->netdev;
+	struct fxgmac_desc_data *desc_data;
+	unsigned int context_next, context;
+	struct fxgmac_pkt_info *pkt_info;
+	unsigned int len, attr, max_len;
+	unsigned int incomplete;
+	struct napi_struct *napi;
+	int packet_count = 0;
+
+	struct sk_buff *skb;
+
+	/* Nothing to do if there isn't a Rx ring for this channel */
+	if (!ring)
+		return 0;
+
+	incomplete = 0;
+	context_next = 0;
+	napi = (pdata->per_channel_irq) ? &channel->napi_rx : &pdata->napi;
+	pkt_info = &ring->pkt_info;
+
+	while (packet_count < budget) {
+		memset(pkt_info, 0, sizeof(*pkt_info));
+		skb = NULL;
+		len = 0;
+
+read_again:
+		desc_data = FXGMAC_GET_DESC_DATA(ring, ring->cur);
+
+		if (fxgmac_desc_rx_dirty(ring) > FXGMAC_RX_DESC_MAX_DIRTY)
+			fxgmac_rx_refresh(channel);
+
+		if (fxgmac_dev_read(channel))
+			break;
+
+		ring->cur = FXGMAC_GET_ENTRY(ring->cur, ring->dma_desc_count);
+		attr = pkt_info->attributes;
+		incomplete = FXGMAC_GET_BITS(attr, RX_PKT_ATTR_INCOMPLETE_POS,
+					     RX_PKT_ATTR_INCOMPLETE_LEN);
+		context_next = FXGMAC_GET_BITS(attr,
+					       RX_PKT_ATTR_CONTEXT_NEXT_POS,
+					       RX_PKT_ATTR_CONTEXT_NEXT_LEN);
+		context = FXGMAC_GET_BITS(attr, RX_PKT_ATTR_CONTEXT_POS,
+					  RX_PKT_ATTR_CONTEXT_LEN);
+
+		if (incomplete || context_next)
+			goto read_again;
+
+		if (pkt_info->errors) {
+			yt_err(pdata, "error in received packet\n");
+			dev_kfree_skb(skb);
+			pdata->netdev->stats.rx_dropped++;
+			goto next_packet;
+		}
+
+		if (!context) {
+			len = desc_data->rx.len;
+			if (len == 0) {
+				if (net_ratelimit())
+					yt_err(pdata,
+					       "A packet of length 0 was received\n");
+				pdata->netdev->stats.rx_length_errors++;
+				pdata->netdev->stats.rx_dropped++;
+				goto next_packet;
+			}
+
+			if (len && !skb) {
+				skb = fxgmac_create_skb(pdata, napi, desc_data,
+							len);
+				if (unlikely(!skb)) {
+					if (net_ratelimit())
+						yt_err(pdata,
+						       "create skb err\n");
+					pdata->netdev->stats.rx_dropped++;
+					goto next_packet;
+				}
+			}
+			max_len = netdev->mtu + ETH_HLEN;
+			if (!(netdev->features & NETIF_F_HW_VLAN_CTAG_RX) &&
+			    skb->protocol == htons(ETH_P_8021Q))
+				max_len += VLAN_HLEN;
+
+			if (len > max_len) {
+				if (net_ratelimit())
+					yt_err(pdata,
+					       "len %d larger than max size %d\n",
+					       len, max_len);
+				pdata->netdev->stats.rx_length_errors++;
+				pdata->netdev->stats.rx_dropped++;
+				dev_kfree_skb(skb);
+				goto next_packet;
+			}
+		}
+
+		if (!skb) {
+			pdata->netdev->stats.rx_dropped++;
+			goto next_packet;
+		}
+
+		if (netif_msg_pktdata(pdata))
+			fxgmac_dbg_pkt(pdata, skb, false);
+
+		skb_checksum_none_assert(skb);
+		if (netdev->features & NETIF_F_RXCSUM)
+			skb->ip_summed = CHECKSUM_UNNECESSARY;
+
+		if (FXGMAC_GET_BITS(attr, RX_PKT_ATTR_VLAN_CTAG_POS,
+				    RX_PKT_ATTR_VLAN_CTAG_LEN)) {
+			__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q),
+					       pkt_info->vlan_ctag);
+			pdata->stats.rx_vlan_packets++;
+		}
+
+		if (FXGMAC_GET_BITS(attr, RX_PKT_ATTR_RSS_HASH_POS,
+				    RX_PKT_ATTR_RSS_HASH_LEN))
+			skb_set_hash(skb, pkt_info->rss_hash,
+				     pkt_info->rss_hash_type);
+
+		skb->dev = netdev;
+		skb->protocol = eth_type_trans(skb, netdev);
+		skb_record_rx_queue(skb, channel->queue_index);
+
+		napi_gro_receive(napi, skb);
+
+next_packet:
+		packet_count++;
+
+		pdata->netdev->stats.rx_packets++;
+		pdata->netdev->stats.rx_bytes += len;
+	}
+
+	return packet_count;
+}
+
+static int fxgmac_one_poll_tx(struct napi_struct *napi, int budget)
+{
+	struct fxgmac_channel *channel =
+		container_of(napi, struct fxgmac_channel, napi_tx);
+	struct fxgmac_pdata *pdata = channel->pdata;
+	struct fxgmac_hw_ops *hw_ops;
+	int ret;
+
+	hw_ops = &pdata->hw_ops;
+	ret = fxgmac_tx_poll(channel);
+	if (napi_complete_done(napi, 0))
+		hw_ops->enable_msix_one_irq(pdata, MSI_ID_TXQ0);
+
+	return ret;
+}
+
+static int fxgmac_one_poll_rx(struct napi_struct *napi, int budget)
+{
+	struct fxgmac_channel *channel =
+		container_of(napi, struct fxgmac_channel, napi_rx);
+
+	struct fxgmac_pdata *pdata = channel->pdata;
+	struct fxgmac_hw_ops *hw_ops;
+	int processed = 0;
+
+	hw_ops = &pdata->hw_ops;
+	processed = fxgmac_rx_poll(channel, budget);
+	if (processed < budget) {
+		if (napi_complete_done(napi, processed)) {
+			hw_ops->enable_msix_one_irq(pdata,
+						    channel->queue_index);
+		}
+	}
+
+	return processed;
+}
+
+static int fxgmac_all_poll(struct napi_struct *napi, int budget)
+{
+	struct fxgmac_pdata *pdata =
+		container_of(napi, struct fxgmac_pdata, napi);
+	struct fxgmac_channel *channel;
+	int processed;
+
+	if (netif_msg_rx_status(pdata))
+		yt_dbg(pdata, "%s, budget=%d\n", __func__, budget);
+
+	processed = 0;
+	do {
+		channel = pdata->channel_head;
+		/*since only 1 tx channel supported in this version, poll
+		 * ch 0 always.
+		 */
+		fxgmac_tx_poll(pdata->channel_head + 0);
+		for (u32 i = 0; i < pdata->channel_count; i++, channel++)
+			processed += fxgmac_rx_poll(channel, budget);
+	} while (false);
+
+	/* If we processed everything, we are done */
+	if (processed < budget) {
+		/* Turn off polling */
+		if (napi_complete_done(napi, processed))
+			pdata->hw_ops.enable_mgm_irq(pdata);
+	}
+
+	if ((processed) && (netif_msg_rx_status(pdata)))
+		yt_dbg(pdata, "%s, received : %d\n", __func__, processed);
+
+	return processed;
+}
+
+void fxgmac_tx_start_xmit(struct fxgmac_channel *channel,
+			  struct fxgmac_ring *ring)
+{
+	struct fxgmac_pdata *pdata = channel->pdata;
+	struct fxgmac_desc_data *desc_data;
+
+	/* Make sure everything is written before the register write */
+	wmb();
+
+	/* Issue a poll command to Tx DMA by writing address
+	 * of next immediate free descriptor
+	 */
+	desc_data = FXGMAC_GET_DESC_DATA(ring, ring->cur);
+	writel(lower_32_bits(desc_data->dma_desc_addr),
+	       FXGMAC_DMA_REG(channel, DMA_CH_TDTR_LO));
+
+	if (netif_msg_tx_done(pdata)) {
+		yt_dbg(pdata,
+		       "tx_start_xmit: dump before wr reg, dma base=0x%016llx,reg=0x%08x,",
+		       desc_data->dma_desc_addr,
+		       readl(FXGMAC_DMA_REG(channel, DMA_CH_TDTR_LO)));
+
+		yt_dbg(pdata, "tx timer usecs=%u,tx_timer_active=%u\n",
+		       pdata->tx_usecs, channel->tx_timer_active);
+	}
+
+	ring->tx.xmit_more = 0;
+}
+
+static void fxgmac_dev_xmit(struct fxgmac_channel *channel)
+{
+	struct fxgmac_pdata *pdata = channel->pdata;
+	struct fxgmac_ring *ring = channel->tx_ring;
+	unsigned int tso_context, vlan_context;
+	struct fxgmac_desc_data *desc_data;
+	struct fxgmac_dma_desc *dma_desc;
+	unsigned int csum, tso, vlan, attr;
+	struct fxgmac_pkt_info *pkt_info;
+	int start_index = ring->cur;
+	int cur_index = ring->cur;
+	int i;
+
+	if (netif_msg_tx_done(pdata))
+		yt_dbg(pdata, "%s, desc cur=%d\n", __func__, cur_index);
+
+	pkt_info = &ring->pkt_info;
+	attr = pkt_info->attributes;
+	csum = FXGMAC_GET_BITS(attr, TX_PKT_ATTR_CSUM_ENABLE_POS,
+			       TX_PKT_ATTR_CSUM_ENABLE_LEN);
+	tso = FXGMAC_GET_BITS(attr, TX_PKT_ATTR_TSO_ENABLE_POS,
+			      TX_PKT_ATTR_TSO_ENABLE_LEN);
+	vlan = FXGMAC_GET_BITS(attr, TX_PKT_ATTR_VLAN_CTAG_POS,
+			       TX_PKT_ATTR_VLAN_CTAG_LEN);
+
+	if (tso && pkt_info->mss != ring->tx.cur_mss)
+		tso_context = 1;
+	else
+		tso_context = 0;
+
+	if ((tso_context) && (netif_msg_tx_done(pdata))) {
+		yt_dbg(pdata, "%s, tso_%s tso=0x%x,pkt_mss=%d,cur_mss=%d\n",
+		       __func__, (pkt_info->mss) ? "start" : "stop", tso,
+		       pkt_info->mss, ring->tx.cur_mss);
+	}
+
+	if (vlan && pkt_info->vlan_ctag != ring->tx.cur_vlan_ctag)
+		vlan_context = 1;
+	else
+		vlan_context = 0;
+
+	if (vlan && (netif_msg_tx_done(pdata)))
+		yt_dbg(pdata,
+		       "%s, pkt vlan=%d, ring vlan=%d, vlan_context=%d\n",
+		       __func__, pkt_info->vlan_ctag, ring->tx.cur_vlan_ctag,
+		       vlan_context);
+
+	desc_data = FXGMAC_GET_DESC_DATA(ring, cur_index);
+	dma_desc = desc_data->dma_desc;
+
+	/* Create a context descriptor if this is a TSO pkt_info */
+	if (tso_context) {
+		if (netif_msg_tx_done(pdata))
+			yt_dbg(pdata, "tso context descriptor,mss=%u\n",
+			       pkt_info->mss);
+
+		/* Set the MSS size */
+		dma_desc->desc2 = FXGMAC_SET_BITS_LE(dma_desc->desc2,
+						     TX_CONTEXT_DESC2_MSS_POS,
+						     TX_CONTEXT_DESC2_MSS_LEN,
+						     pkt_info->mss);
+
+		/* Mark it as a CONTEXT descriptor */
+		dma_desc->desc3 = FXGMAC_SET_BITS_LE(dma_desc->desc3,
+						     TX_CONTEXT_DESC3_CTXT_POS,
+						     TX_CONTEXT_DESC3_CTXT_LEN,
+						     1);
+
+		/* Indicate this descriptor contains the MSS */
+		dma_desc->desc3 =
+			FXGMAC_SET_BITS_LE(dma_desc->desc3,
+					   TX_CONTEXT_DESC3_TCMSSV_POS,
+					   TX_CONTEXT_DESC3_TCMSSV_LEN, 1);
+
+		ring->tx.cur_mss = pkt_info->mss;
+	}
+
+	if (vlan_context) {
+		yt_dbg(pdata, "VLAN context descriptor, ctag=%u\n",
+		       pkt_info->vlan_ctag);
+
+		/* Mark it as a CONTEXT descriptor */
+		dma_desc->desc3 = FXGMAC_SET_BITS_LE(dma_desc->desc3,
+						     TX_CONTEXT_DESC3_CTXT_POS,
+						     TX_CONTEXT_DESC3_CTXT_LEN,
+						     1);
+
+		/* Set the VLAN tag */
+		dma_desc->desc3 = FXGMAC_SET_BITS_LE(dma_desc->desc3,
+						     TX_CONTEXT_DESC3_VT_POS,
+						     TX_CONTEXT_DESC3_VT_LEN,
+						     pkt_info->vlan_ctag);
+
+		/* Indicate this descriptor contains the VLAN tag */
+		dma_desc->desc3 = FXGMAC_SET_BITS_LE(dma_desc->desc3,
+						     TX_CONTEXT_DESC3_VLTV_POS,
+						     TX_CONTEXT_DESC3_VLTV_LEN,
+						     1);
+
+		ring->tx.cur_vlan_ctag = pkt_info->vlan_ctag;
+	}
+	if (tso_context || vlan_context) {
+		cur_index = FXGMAC_GET_ENTRY(cur_index, ring->dma_desc_count);
+		desc_data = FXGMAC_GET_DESC_DATA(ring, cur_index);
+		dma_desc = desc_data->dma_desc;
+	}
+
+	/* Update buffer address (for TSO this is the header) */
+	dma_desc->desc0 = cpu_to_le32(lower_32_bits(desc_data->skb_dma));
+	dma_desc->desc1 = cpu_to_le32(upper_32_bits(desc_data->skb_dma));
+
+	/* Update the buffer length */
+	dma_desc->desc2 = FXGMAC_SET_BITS_LE(dma_desc->desc2,
+					     TX_NORMAL_DESC2_HL_B1L_POS,
+					     TX_NORMAL_DESC2_HL_B1L_LEN,
+					     desc_data->skb_dma_len);
+
+	/* VLAN tag insertion check */
+	if (vlan) {
+		dma_desc->desc2 =
+			FXGMAC_SET_BITS_LE(dma_desc->desc2, TX_NORMAL_DESC2_VTIR_POS,
+					   TX_NORMAL_DESC2_VTIR_LEN,
+					   TX_NORMAL_DESC2_VLAN_INSERT);
+		pdata->stats.tx_vlan_packets++;
+	}
+
+	/* Timestamp enablement check */
+	if (FXGMAC_GET_BITS(attr, TX_PKT_ATTR_PTP_POS, TX_PKT_ATTR_PTP_LEN))
+		dma_desc->desc2 = FXGMAC_SET_BITS_LE(dma_desc->desc2,
+						     TX_NORMAL_DESC2_TTSE_POS,
+						     TX_NORMAL_DESC2_TTSE_LEN,
+						     1);
+
+	/* Mark it as First Descriptor */
+	dma_desc->desc3 = FXGMAC_SET_BITS_LE(dma_desc->desc3,
+					     TX_NORMAL_DESC3_FD_POS,
+					     TX_NORMAL_DESC3_FD_LEN, 1);
+
+	/* Mark it as a NORMAL descriptor */
+	dma_desc->desc3 = FXGMAC_SET_BITS_LE(dma_desc->desc3,
+					     TX_NORMAL_DESC3_CTXT_POS,
+					     TX_NORMAL_DESC3_CTXT_LEN, 0);
+
+	/* Set OWN bit if not the first descriptor */
+	if (cur_index != start_index)
+		dma_desc->desc3 = FXGMAC_SET_BITS_LE(dma_desc->desc3,
+						     TX_NORMAL_DESC3_OWN_POS,
+						     TX_NORMAL_DESC3_OWN_LEN,
+						     1);
+
+	if (tso) {
+		/* Enable TSO */
+		dma_desc->desc3 = FXGMAC_SET_BITS_LE(dma_desc->desc3,
+						     TX_NORMAL_DESC3_TSE_POS,
+						     TX_NORMAL_DESC3_TSE_LEN,
+						     1);
+		dma_desc->desc3 = FXGMAC_SET_BITS_LE(dma_desc->desc3,
+						     TX_NORMAL_DESC3_TCPPL_POS,
+						     TX_NORMAL_DESC3_TCPPL_LEN,
+						     pkt_info->tcp_payload_len);
+		dma_desc->desc3 =
+			FXGMAC_SET_BITS_LE(dma_desc->desc3,
+					   TX_NORMAL_DESC3_TCPHDRLEN_POS,
+					   TX_NORMAL_DESC3_TCPHDRLEN_LEN,
+					   pkt_info->tcp_header_len / 4);
+
+		pdata->stats.tx_tso_packets++;
+	} else {
+		/* Enable CRC and Pad Insertion */
+		dma_desc->desc3 = FXGMAC_SET_BITS_LE(dma_desc->desc3,
+						     TX_NORMAL_DESC3_CPC_POS,
+						     TX_NORMAL_DESC3_CPC_LEN,
+						     0);
+
+		/* Enable HW CSUM */
+		if (csum)
+			dma_desc->desc3 =
+				FXGMAC_SET_BITS_LE(dma_desc->desc3,
+						   TX_NORMAL_DESC3_CIC_POS,
+						   TX_NORMAL_DESC3_CIC_LEN,
+						   0x3);
+
+		/* Set the total length to be transmitted */
+		dma_desc->desc3 = FXGMAC_SET_BITS_LE(dma_desc->desc3,
+						     TX_NORMAL_DESC3_FL_POS,
+						     TX_NORMAL_DESC3_FL_LEN,
+						     pkt_info->length);
+	}
+	if (netif_msg_tx_done(pdata))
+		yt_dbg(pdata,
+		       "%s, before more descs, desc cur=%d, start=%d, desc=%#x,%#x,%#x,%#x\n",
+		       __func__, cur_index, start_index, dma_desc->desc0,
+		       dma_desc->desc1, dma_desc->desc2, dma_desc->desc3);
+
+	if (start_index <= cur_index)
+		i = cur_index - start_index + 1;
+	else
+		i = ring->dma_desc_count - start_index + cur_index;
+
+	for (; i < pkt_info->desc_count; i++) {
+		cur_index = FXGMAC_GET_ENTRY(cur_index, ring->dma_desc_count);
+		desc_data = FXGMAC_GET_DESC_DATA(ring, cur_index);
+		dma_desc = desc_data->dma_desc;
+
+		/* Update buffer address */
+		dma_desc->desc0 =
+			cpu_to_le32(lower_32_bits(desc_data->skb_dma));
+		dma_desc->desc1 =
+			cpu_to_le32(upper_32_bits(desc_data->skb_dma));
+
+		/* Update the buffer length */
+		dma_desc->desc2 = FXGMAC_SET_BITS_LE(dma_desc->desc2,
+						     TX_NORMAL_DESC2_HL_B1L_POS,
+						     TX_NORMAL_DESC2_HL_B1L_LEN,
+						     desc_data->skb_dma_len);
+
+		/* Set OWN bit */
+		dma_desc->desc3 = FXGMAC_SET_BITS_LE(dma_desc->desc3,
+						     TX_NORMAL_DESC3_OWN_POS,
+						     TX_NORMAL_DESC3_OWN_LEN,
+						     1);
+
+		/* Mark it as NORMAL descriptor */
+		dma_desc->desc3 = FXGMAC_SET_BITS_LE(dma_desc->desc3,
+						     TX_NORMAL_DESC3_CTXT_POS,
+						     TX_NORMAL_DESC3_CTXT_LEN,
+						     0);
+
+		/* Enable HW CSUM */
+		if (csum)
+			dma_desc->desc3 =
+				FXGMAC_SET_BITS_LE(dma_desc->desc3,
+						   TX_NORMAL_DESC3_CIC_POS,
+						   TX_NORMAL_DESC3_CIC_LEN, 0x3);
+	}
+
+	/* Set LAST bit for the last descriptor */
+	dma_desc->desc3 = FXGMAC_SET_BITS_LE(dma_desc->desc3,
+					     TX_NORMAL_DESC3_LD_POS,
+					     TX_NORMAL_DESC3_LD_LEN, 1);
+
+	dma_desc->desc2 = FXGMAC_SET_BITS_LE(dma_desc->desc2,
+					     TX_NORMAL_DESC2_IC_POS,
+					     TX_NORMAL_DESC2_IC_LEN, 1);
+
+	/* Save the Tx info to report back during cleanup */
+	desc_data->tx.packets = pkt_info->tx_packets;
+	desc_data->tx.bytes = pkt_info->tx_bytes;
+
+	if (netif_msg_tx_done(pdata))
+		yt_dbg(pdata,
+		       "%s, last descs, desc cur=%d, desc=%#x,%#x,%#x,%#x\n",
+		       __func__, cur_index, dma_desc->desc0, dma_desc->desc1,
+		       dma_desc->desc2, dma_desc->desc3);
+
+	/* In case the Tx DMA engine is running, make sure everything
+	 * is written to the descriptor(s) before setting the OWN bit
+	 * for the first descriptor
+	 */
+	dma_wmb();
+
+	/* Set OWN bit for the first descriptor */
+	desc_data = FXGMAC_GET_DESC_DATA(ring, start_index);
+	dma_desc = desc_data->dma_desc;
+	dma_desc->desc3 = FXGMAC_SET_BITS_LE(dma_desc->desc3,
+					     TX_NORMAL_DESC3_OWN_POS,
+					     TX_NORMAL_DESC3_OWN_LEN, 1);
+
+	if (netif_msg_tx_done(pdata))
+		yt_dbg(pdata,
+		       "%s, first descs, start=%d, desc=%#x,%#x,%#x,%#x\n",
+		       __func__, start_index, dma_desc->desc0, dma_desc->desc1,
+		       dma_desc->desc2, dma_desc->desc3);
+
+	if (netif_msg_tx_queued(pdata))
+		fxgmac_dump_tx_desc(pdata, ring, start_index,
+				    pkt_info->desc_count, 1);
+
+	/* Make sure ownership is written to the descriptor */
+	smp_wmb();
+
+	ring->cur = FXGMAC_GET_ENTRY(cur_index, ring->dma_desc_count);
+	fxgmac_tx_start_xmit(channel, ring);
+
+	if (netif_msg_tx_done(pdata)) {
+		yt_dbg(pdata, "%s, %s: descriptors %u to %u written\n",
+		       __func__, channel->name,
+		       start_index & (ring->dma_desc_count - 1),
+		       (ring->cur - 1) & (ring->dma_desc_count - 1));
+	}
+}
+
+static void fxgmac_get_rx_tstamp(struct fxgmac_pkt_info *pkt_info,
+				 struct fxgmac_dma_desc *dma_desc)
+{
+	u64 nsec;
+
+	nsec = le32_to_cpu(dma_desc->desc1);
+	nsec <<= 32;
+	nsec |= le32_to_cpu(dma_desc->desc0);
+	if (nsec != 0xffffffffffffffffULL) {
+		pkt_info->rx_tstamp = nsec;
+		fxgmac_set_bits(&pkt_info->attributes,
+				RX_PKT_ATTR_RX_TSTAMP_POS,
+				RX_PKT_ATTR_RX_TSTAMP_LEN, 1);
+	}
+}
+
+static int fxgmac_dev_read(struct fxgmac_channel *channel)
+{
+	struct fxgmac_pdata *pdata = channel->pdata;
+	struct fxgmac_ring *ring = channel->rx_ring;
+	struct net_device *netdev = pdata->netdev;
+	struct fxgmac_desc_data *desc_data;
+	struct fxgmac_dma_desc *dma_desc;
+	static unsigned int cnt_incomplete;
+	struct fxgmac_pkt_info *pkt_info;
+	u32 ipce, iphe, rxparser;
+	unsigned int err, etlt;
+	unsigned int *attr;
+
+	desc_data = FXGMAC_GET_DESC_DATA(ring, ring->cur);
+	dma_desc = desc_data->dma_desc;
+	pkt_info = &ring->pkt_info;
+	attr = &pkt_info->attributes;
+
+	/* Check for data availability */
+	if (FXGMAC_GET_BITS_LE(dma_desc->desc3, RX_NORMAL_DESC3_OWN_POS,
+			       RX_NORMAL_DESC3_OWN_LEN))
+		return 1;
+
+	/* Make sure descriptor fields are read after reading the OWN bit */
+	dma_rmb();
+
+	if (netif_msg_rx_status(pdata))
+		fxgmac_dump_rx_desc(pdata, ring, ring->cur);
+
+	if (FXGMAC_GET_BITS_LE(dma_desc->desc3, RX_NORMAL_DESC3_CTXT_POS,
+			       RX_NORMAL_DESC3_CTXT_LEN)) {
+		/* Timestamp Context Descriptor */
+		fxgmac_get_rx_tstamp(pkt_info, dma_desc);
+
+		fxgmac_set_bits(attr, RX_PKT_ATTR_CONTEXT_POS,
+				RX_PKT_ATTR_CONTEXT_LEN, 1);
+		fxgmac_set_bits(attr, RX_PKT_ATTR_CONTEXT_NEXT_POS,
+				RX_PKT_ATTR_CONTEXT_NEXT_LEN, 0);
+		if (netif_msg_rx_status(pdata))
+			yt_dbg(pdata, "%s, context desc ch=%s\n", __func__,
+			       channel->name);
+		return 0;
+	}
+
+	/* Normal Descriptor, be sure Context Descriptor bit is off */
+	fxgmac_set_bits(attr, RX_PKT_ATTR_CONTEXT_POS, RX_PKT_ATTR_CONTEXT_LEN,
+			0);
+
+	/* Indicate if a Context Descriptor is next */
+	/* Get the header length */
+	if (FXGMAC_GET_BITS_LE(dma_desc->desc3, RX_NORMAL_DESC3_FD_POS,
+			       RX_NORMAL_DESC3_FD_LEN)) {
+		desc_data->rx.hdr_len =
+			FXGMAC_GET_BITS_LE(dma_desc->desc2,
+					   RX_NORMAL_DESC2_HL_POS,
+					   RX_NORMAL_DESC2_HL_LEN);
+		if (desc_data->rx.hdr_len)
+			pdata->stats.rx_split_header_packets++;
+	}
+
+	/* Get the pkt_info length */
+	desc_data->rx.len = FXGMAC_GET_BITS_LE(dma_desc->desc3,
+					       RX_NORMAL_DESC3_PL_POS,
+					       RX_NORMAL_DESC3_PL_LEN);
+
+	if (!FXGMAC_GET_BITS_LE(dma_desc->desc3, RX_NORMAL_DESC3_LD_POS,
+				RX_NORMAL_DESC3_LD_LEN)) {
+		/* Not all the data has been transferred for this pkt_info */
+		fxgmac_set_bits(attr, RX_PKT_ATTR_INCOMPLETE_POS,
+				RX_PKT_ATTR_INCOMPLETE_LEN, 1);
+		cnt_incomplete++;
+		if (cnt_incomplete < 2 && netif_msg_rx_status(pdata))
+			yt_dbg(pdata,
+			       "%s, not last desc,pkt incomplete yet,%u\n",
+			       __func__, cnt_incomplete);
+
+		return 0;
+	}
+	if ((cnt_incomplete) && netif_msg_rx_status(pdata))
+		yt_dbg(pdata, "%s, rx back to normal and incomplete cnt=%u\n",
+		       __func__, cnt_incomplete);
+	cnt_incomplete = 0;
+
+	/* This is the last of the data for this pkt_info */
+	fxgmac_set_bits(attr, RX_PKT_ATTR_INCOMPLETE_POS,
+			RX_PKT_ATTR_INCOMPLETE_LEN, 0);
+
+	/* Set checksum done indicator as appropriate */
+	if (netdev->features & NETIF_F_RXCSUM) {
+		ipce = FXGMAC_GET_BITS_LE(dma_desc->desc1,
+					  RX_NORMAL_DESC1_WB_IPCE_POS,
+					  RX_NORMAL_DESC1_WB_IPCE_LEN);
+		iphe = FXGMAC_GET_BITS_LE(dma_desc->desc1,
+					  RX_NORMAL_DESC1_WB_IPHE_POS,
+					  RX_NORMAL_DESC1_WB_IPHE_LEN);
+		if (!ipce && !iphe)
+			fxgmac_set_bits(attr, RX_PKT_ATTR_CSUM_DONE_POS,
+					RX_PKT_ATTR_CSUM_DONE_LEN, 1);
+		else
+			return 0;
+	}
+
+	/* Check for errors (only valid in last descriptor) */
+	err = FXGMAC_GET_BITS_LE(dma_desc->desc3, RX_NORMAL_DESC3_ES_POS,
+				 RX_NORMAL_DESC3_ES_LEN);
+
+	/* b111: Incomplete parsing due to ECC error */
+	rxparser = FXGMAC_GET_BITS_LE(dma_desc->desc2,
+				      RX_NORMAL_DESC2_WB_RAPARSER_POS,
+				      RX_NORMAL_DESC2_WB_RAPARSER_LEN);
+	if (err || rxparser == 0x7) {
+		fxgmac_set_bits(&pkt_info->errors, RX_PACKET_ERRORS_FRAME_POS,
+				RX_PACKET_ERRORS_FRAME_LEN, 1);
+		return 0;
+	}
+
+	etlt = FXGMAC_GET_BITS_LE(dma_desc->desc3, RX_NORMAL_DESC3_ETLT_POS,
+				  RX_NORMAL_DESC3_ETLT_LEN);
+
+	if (etlt == 0x4 && (netdev->features & NETIF_F_HW_VLAN_CTAG_RX)) {
+		fxgmac_set_bits(attr, RX_PKT_ATTR_VLAN_CTAG_POS,
+				RX_PKT_ATTR_VLAN_CTAG_LEN, 1);
+		pkt_info->vlan_ctag =
+			FXGMAC_GET_BITS_LE(dma_desc->desc0,
+					   RX_NORMAL_DESC0_OVT_POS,
+					   RX_NORMAL_DESC0_OVT_LEN);
+		yt_dbg(pdata, "vlan-ctag=%#06x\n", pkt_info->vlan_ctag);
+	}
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.h b/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.h
new file mode 100644
index 0000000..badc3f7
--- /dev/null
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Copyright (c) 2022 - 2024 Motorcomm Electronic Technology Co.,Ltd. */
+
+#ifndef _YT6801_NET_H_
+#define _YT6801_NET_H_
+
+#include "yt6801.h"
+
+#define FXGMAC_IRQ_ENABLE			0x1
+#define FXGMAC_IRQ_DISABLE			0x0
+#define FXGMAC_NAPI_ENABLE			0x1
+#define FXGMAC_NAPI_DISABLE			0x0
+
+/* flags for ipv6 NS offload address, local link or Global unicast */
+#define FXGMAC_NS_IFA_LOCAL_LINK	1
+#define FXGMAC_NS_IFA_GLOBAL_UNICAST	2
+
+unsigned int fxgmac_get_netdev_ip4addr(struct fxgmac_pdata *pdata);
+unsigned char *fxgmac_get_netdev_ip6addr(struct fxgmac_pdata *pdata,
+					 unsigned char *ipval,
+					 unsigned char *ip6addr_solicited,
+					 unsigned int ifa_flag);
+int fxgmac_start(struct fxgmac_pdata *pdata);
+void fxgmac_stop(struct fxgmac_pdata *pdata);
+void fxgmac_restart(struct fxgmac_pdata *pdata);
+void fxgmac_dbg_pkt(struct fxgmac_pdata *pdata, struct sk_buff *skb,
+		    bool tx_rx);
+void fxgmac_tx_start_xmit(struct fxgmac_channel *channel,
+			  struct fxgmac_ring *ring);
+void fxgmac_free_tx_data(struct fxgmac_pdata *pdata);
+void fxgmac_free_rx_data(struct fxgmac_pdata *pdata);
+
+#endif /* _YT6801_NET_H_ */
diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_pci.c b/drivers/net/ethernet/motorcomm/yt6801/yt6801_pci.c
new file mode 100644
index 0000000..bcabfa7
--- /dev/null
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_pci.c
@@ -0,0 +1,250 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (c) 2022 - 2024 Motorcomm Electronic Technology Co.,Ltd. */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+#ifdef CONFIG_PCI_MSI
+#include <linux/pci.h>
+#endif
+
+#include "yt6801_type.h"
+#include "yt6801.h"
+
+static int fxgmac_probe(struct pci_dev *pcidev, const struct pci_device_id *id)
+{
+	struct device *dev = &pcidev->dev;
+	struct fxgmac_resources res;
+	int i, ret;
+
+	ret = pcim_enable_device(pcidev);
+	if (ret) {
+		dev_err(dev, "%s pcim_enable_device err:%d\n", __func__, ret);
+		return ret;
+	}
+
+	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
+		if (pci_resource_len(pcidev, i) == 0)
+			continue;
+
+		ret = pcim_iomap_regions(pcidev, BIT(i), FXGMAC_DRV_NAME);
+		if (ret) {
+			dev_err(dev, "%s, pcim_iomap_regions err:%d\n",
+				__func__, ret);
+			return ret;
+		}
+		break;
+	}
+
+	pci_set_master(pcidev);
+
+	memset(&res, 0, sizeof(res));
+	res.irq = pcidev->irq;
+	res.addr = pcim_iomap_table(pcidev)[i];
+
+	return fxgmac_drv_probe(&pcidev->dev, &res);
+}
+
+static void fxgmac_remove(struct pci_dev *pcidev)
+{
+	struct net_device *netdev = dev_get_drvdata(&pcidev->dev);
+#ifdef CONFIG_PCI_MSI
+	struct fxgmac_pdata *pdata = netdev_priv(netdev);
+#endif
+	struct device *dev = &pcidev->dev;
+
+	fxgmac_drv_remove(dev);
+
+#ifdef CONFIG_PCI_MSI
+	if (FIELD_GET(FXGMAC_FLAG_MSIX_ENABLED, pdata->int_flags)) {
+		pci_disable_msix(pcidev);
+		kfree(pdata->msix_entries);
+		pdata->msix_entries = NULL;
+	}
+#endif
+
+	dev_dbg(dev, "%s has been removed\n", netdev->name);
+}
+
+static int __fxgmac_shutdown(struct pci_dev *pcidev, bool *enable_wake)
+{
+	struct net_device *netdev = dev_get_drvdata(&pcidev->dev);
+	struct fxgmac_pdata *pdata = netdev_priv(netdev);
+	struct device *dev = &pcidev->dev;
+	bool wake = !!pdata->wol;
+#ifdef CONFIG_PM
+	int ret;
+#endif
+
+	rtnl_lock();
+	fxgmac_net_powerdown(pdata, wake);
+	netif_device_detach(netdev);
+	rtnl_unlock();
+
+#ifdef CONFIG_PM
+	ret = pci_save_state(pcidev);
+	if (ret < 0) {
+		dev_err(dev, "%s, pci_save_state err:%d.\n", __func__, ret);
+		return ret;
+	}
+#endif
+
+	dev_dbg(dev, "%s, save pci state done.\n", __func__);
+
+	pci_wake_from_d3(pcidev, wake);
+	*enable_wake = wake;
+	pci_disable_device(pcidev);
+
+	dev_dbg(dev, "%s, enable wake=%d.\n", __func__, wake);
+
+	return 0;
+}
+
+static void fxgmac_shutdown(struct pci_dev *pcidev)
+{
+	struct net_device *netdev = dev_get_drvdata(&pcidev->dev);
+	struct fxgmac_pdata *pdata = netdev_priv(netdev);
+	struct device *dev = &pcidev->dev;
+	bool wake;
+	int ret;
+
+	fxgmac_lock(pdata);
+	ret = __fxgmac_shutdown(pcidev, &wake);
+	if (ret < 0)
+		goto unlock;
+
+	ret = fxgmac_phy_cfg_led(pdata, pdata->led.s5);
+	if (ret < 0)
+		goto unlock;
+
+	if (system_state == SYSTEM_POWER_OFF) {
+		pci_wake_from_d3(pcidev, wake);
+		pci_set_power_state(pcidev, PCI_D3hot);
+	}
+unlock:
+	fxgmac_unlock(pdata);
+
+	dev_dbg(dev, "%s, system power off=%d\n", __func__,
+		(system_state == SYSTEM_POWER_OFF) ? 1 : 0);
+}
+
+#ifdef CONFIG_PM
+static int fxgmac_suspend(struct pci_dev *pcidev,
+			  pm_message_t __always_unused state)
+{
+	struct net_device *netdev = dev_get_drvdata(&pcidev->dev);
+	struct fxgmac_pdata *pdata = netdev_priv(netdev);
+	struct device *dev = &pcidev->dev;
+	int ret = 0;
+	bool wake;
+
+	fxgmac_lock(pdata);
+	if (pdata->dev_state != FXGMAC_DEV_START)
+		goto unlock;
+
+	if (netif_running(netdev)) {
+		ret = __fxgmac_shutdown(pcidev, &wake);
+		if (ret < 0)
+			goto unlock;
+	} else {
+		wake = !!(pdata->wol);
+	}
+	ret = fxgmac_phy_cfg_led(pdata, pdata->led.s3);
+	if (ret < 0)
+		goto unlock;
+
+	if (wake) {
+		pci_prepare_to_sleep(pcidev);
+	} else {
+		pci_wake_from_d3(pcidev, false);
+		pci_set_power_state(pcidev, PCI_D3hot);
+	}
+
+	pdata->dev_state = FXGMAC_DEV_SUSPEND;
+unlock:
+	fxgmac_unlock(pdata);
+	dev_dbg(dev, "%s, set to %s\n", __func__, wake ? "sleep" : "D3hot");
+
+	return ret;
+}
+
+static int fxgmac_resume(struct pci_dev *pcidev)
+{
+	struct net_device *netdev = dev_get_drvdata(&pcidev->dev);
+	struct fxgmac_pdata *pdata = netdev_priv(netdev);
+	struct device *dev = &pcidev->dev;
+	int ret = 0;
+
+	fxgmac_lock(pdata);
+	if (pdata->dev_state != FXGMAC_DEV_SUSPEND)
+		goto unlock;
+
+	pdata->dev_state = FXGMAC_DEV_RESUME;
+
+	pci_set_power_state(pcidev, PCI_D0);
+	pci_restore_state(pcidev);
+
+	/* pci_restore_state clears dev->state_saved so call
+	 * pci_save_state to restore it.
+	 */
+	pci_save_state(pcidev);
+
+	ret = pci_enable_device_mem(pcidev);
+	if (ret < 0) {
+		dev_err(dev, "%s, pci_enable_device_mem err:%d\n", __func__,
+			ret);
+		goto unlock;
+	}
+
+	/* flush memory to make sure state is correct */
+	smp_mb__before_atomic();
+	__clear_bit(FXGMAC_POWER_STATE_DOWN, &pdata->powerstate);
+	pci_set_master(pcidev);
+	pci_wake_from_d3(pcidev, false);
+
+	rtnl_lock();
+	if (netif_running(netdev)) {
+		ret = fxgmac_net_powerup(pdata);
+		if (ret < 0) {
+			dev_err(dev, "%s, fxgmac_net_powerup err:%d\n",
+				__func__, ret);
+			goto unlock;
+		}
+	}
+
+	netif_device_attach(netdev);
+	rtnl_unlock();
+
+	dev_dbg(dev, "%s ok\n", __func__);
+unlock:
+	fxgmac_unlock(pdata);
+
+	return ret;
+}
+#endif
+
+static const struct pci_device_id fxgmac_pci_tbl[] = {
+	{ PCI_DEVICE(MOTORCOMM_PCI_ID, YT6801_PCI_DEVICE_ID) },
+	{ 0 }
+};
+
+MODULE_DEVICE_TABLE(pci, fxgmac_pci_tbl);
+
+static struct pci_driver fxgmac_pci_driver = {
+	.name		= FXGMAC_DRV_NAME,
+	.id_table	= fxgmac_pci_tbl,
+	.probe		= fxgmac_probe,
+	.remove		= fxgmac_remove,
+#ifdef CONFIG_PM
+	.suspend	= fxgmac_suspend,
+	.resume		= fxgmac_resume,
+#endif
+	.shutdown	= fxgmac_shutdown,
+};
+
+module_pci_driver(fxgmac_pci_driver);
+
+MODULE_DESCRIPTION(FXGMAC_DRV_DESC);
+MODULE_VERSION(FXGMAC_DRV_VERSION);
+MODULE_AUTHOR("Motorcomm Electronic Tech. Co., Ltd.");
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_phy.c b/drivers/net/ethernet/motorcomm/yt6801/yt6801_phy.c
new file mode 100644
index 0000000..5da104c
--- /dev/null
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_phy.c
@@ -0,0 +1,292 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (c) 2022 - 2024 Motorcomm Electronic Technology Co.,Ltd. */
+
+#include <linux/module.h>
+#include <linux/timer.h>
+
+#include "yt6801_type.h"
+#include "yt6801_phy.h"
+
+int fxgmac_phy_modify_reg(struct fxgmac_pdata *pdata, u32 reg_id, u32 mask,
+			  u32 set)
+{
+	int new, ret;
+
+	ret = fxgmac_phy_read_reg(pdata, reg_id, &new);
+	if (ret < 0)
+		return ret;
+
+	new = (new & ~mask) | set;
+
+	return fxgmac_phy_write_reg(pdata, reg_id, new);
+}
+
+int fxgmac_phy_write_ext_reg(struct fxgmac_pdata *pdata, u32 reg_id, u32 data)
+{
+	int ret;
+
+	ret = fxgmac_phy_write_reg(pdata, PHY_DBG_ADDR, reg_id);
+	if (ret < 0)
+		return ret;
+
+	return fxgmac_phy_write_reg(pdata, PHY_DBG_DATA, data);
+}
+
+int fxgmac_phy_read_ext_reg(struct fxgmac_pdata *pdata, u32 reg_id, u32 *data)
+{
+	int ret;
+
+	ret = fxgmac_phy_write_reg(pdata, PHY_DBG_ADDR, reg_id);
+	if (ret < 0)
+		return ret;
+
+	return fxgmac_phy_read_reg(pdata, PHY_DBG_DATA, data);
+}
+
+int fxgmac_phy_modify_ext_reg(struct fxgmac_pdata *pdata, u32 reg_id, u32 mask,
+			      u32 set)
+{
+	int new, ret;
+
+	ret = fxgmac_phy_read_ext_reg(pdata, reg_id, &new);
+	if (ret < 0)
+		return ret;
+
+	new = (new & ~mask) | set;
+
+	return fxgmac_phy_write_reg(pdata, PHY_DBG_DATA, new);
+}
+
+int fxgmac_phy_set_autoneg_advertise(struct fxgmac_pdata *pdata,
+				     struct fxphy_ag_adv phy_ag_adv)
+{
+	u32 mask, val = 0;
+	int ret;
+
+	if (phy_ag_adv.auto_neg_en)
+		val |= BMCR_ANENABLE;
+
+	ret = fxgmac_phy_modify_reg(pdata, MII_BMCR, BMCR_ANENABLE, val);
+	if (ret < 0)
+		return ret;
+
+	val = 0;
+	if (phy_ag_adv.full_1000m)
+		val |= ADVERTISE_1000FULL;
+
+	if (phy_ag_adv.half_1000m)
+		val |= ADVERTISE_1000HALF;
+
+	mask = ADVERTISE_1000FULL | ADVERTISE_1000HALF;
+	ret = fxgmac_phy_modify_reg(pdata, MII_CTRL1000, mask, val);
+	if (ret < 0)
+		return ret;
+
+	val = 0;
+	if (phy_ag_adv.full_100m)
+		val |= ADVERTISE_100FULL;
+
+	if (phy_ag_adv.half_100m)
+		val |= ADVERTISE_100HALF;
+
+	if (phy_ag_adv.full_10m)
+		val |= ADVERTISE_10FULL;
+
+	if (phy_ag_adv.half_10m)
+		val |= ADVERTISE_10HALF;
+
+	mask = ADVERTISE_100FULL | ADVERTISE_100HALF | ADVERTISE_10FULL |
+	       ADVERTISE_10HALF;
+	ret = fxgmac_phy_modify_reg(pdata, MII_ADVERTISE, mask, val);
+	if (ret < 0)
+		return ret;
+
+	return fxgmac_phy_modify_reg(pdata, MII_BMCR, BMCR_RESET, BMCR_RESET);
+}
+
+int fxgmac_phy_force_mode(struct fxgmac_pdata *pdata)
+{
+	unsigned int high_bit = 0, low_bit = 0;
+	u32 mask, val = 0;
+
+	switch (pdata->phy_speed) {
+	case SPEED_1000:
+		high_bit = 1, low_bit = 0;
+		break;
+	case SPEED_100:
+		high_bit = 0, low_bit = 1;
+		break;
+	case SPEED_10:
+		high_bit = 0, low_bit = 0;
+		break;
+	default:
+		break;
+	}
+
+	mask = BMCR_ANENABLE | BMCR_SPEED1000 | BMCR_SPEED100 | BMCR_FULLDPLX;
+
+	if (pdata->phy_autoeng)
+		val |= BMCR_ANENABLE;
+
+	if (pdata->phy_duplex)
+		val |= BMCR_FULLDPLX;
+
+	if (high_bit)
+		val |= BMCR_SPEED1000;
+
+	if (low_bit)
+		val |= BMCR_SPEED100;
+
+	return fxgmac_phy_modify_reg(pdata, MII_BMCR, mask, val);
+}
+
+int fxgmac_phy_set_link_ksettings(struct fxgmac_pdata *pdata)
+{
+	pdata->phy_speed = pdata->pre_phy_speed;
+	pdata->phy_duplex = pdata->pre_phy_duplex;
+	pdata->phy_autoeng = pdata->pre_phy_autoneg;
+
+	if (pdata->phy_autoeng)
+		return fxgmac_phy_config(pdata);
+	else
+		return fxgmac_phy_force_mode(pdata);
+
+	return 0;
+}
+
+void fxgmac_phy_update_link(struct net_device *netdev)
+{
+	struct fxgmac_pdata *pdata = netdev_priv(netdev);
+	struct fxgmac_hw_ops *hw_ops = &pdata->hw_ops;
+	u32 val, cur_link, cur_speed;
+
+	val = fxgmac_phy_get_state(pdata);
+	/*  We should make sure that PHY is done with the reset */
+	if (!(val & BIT(EPHY_CTRL_RESET_POS))) {
+		pdata->phy_link = false;
+		return;
+	}
+
+	cur_link = FXGMAC_GET_BITS(val, EPHY_CTRL_STA_LINKUP_POS,
+				   EPHY_CTRL_STA_LINKUP_LEN);
+
+	if (pdata->phy_link == cur_link)
+		return;
+
+	fxgmac_phy_clear_interrupt(pdata);
+	fxgmac_phy_clear_interrupt(pdata);
+
+	pdata->phy_link = cur_link;
+	if (pdata->phy_link) {
+		cur_speed = FXGMAC_GET_BITS(val, EPHY_CTRL_STA_SPEED_POS,
+					    EPHY_CTRL_STA_SPEED_LEN);
+		pdata->phy_speed = (cur_speed == 2) ? SPEED_1000 :
+				   (cur_speed == 1) ? SPEED_100 :
+							    SPEED_10;
+		pdata->phy_duplex = FXGMAC_GET_BITS(val,
+						    EPHY_CTRL_STA_DUPLEX_POS,
+						    EPHY_CTRL_STA_DUPLEX_LEN);
+		hw_ops->config_mac_speed(pdata);
+		hw_ops->enable_rx(pdata);
+		hw_ops->enable_tx(pdata);
+		netif_carrier_on(pdata->netdev);
+		if (netif_running(pdata->netdev)) {
+			netif_tx_wake_all_queues(pdata->netdev);
+			yt_dbg(pdata, "%s now is link up, mac_speed=%d.\n",
+			       netdev_name(pdata->netdev), pdata->phy_speed);
+		}
+	} else {
+		netif_carrier_off(pdata->netdev);
+		netif_tx_stop_all_queues(pdata->netdev);
+		pdata->phy_speed = SPEED_UNKNOWN;
+		pdata->phy_duplex = DUPLEX_UNKNOWN;
+		hw_ops->disable_rx(pdata);
+		hw_ops->disable_tx(pdata);
+		yt_dbg(pdata, "%s now is link down\n",
+		       netdev_name(pdata->netdev));
+	}
+}
+
+void fxgmac_phy_link_poll(struct timer_list *t)
+{
+	struct fxgmac_pdata *pdata = from_timer(pdata, t, phy_poll_tm);
+
+	if (!pdata->netdev) {
+		yt_err(pdata, "polling with NULL netdev\n");
+		return;
+	}
+
+	pdata->stats.ephy_poll_timer_cnt++;
+
+	if (!test_bit(FXGMAC_POWER_STATE_DOWN, &pdata->powerstate)) {
+		mod_timer(&pdata->phy_poll_tm, jiffies + HZ / 2);
+		fxgmac_phy_update_link(pdata->netdev);
+		return;
+	}
+
+	yt_dbg(pdata, "polling, powerstate changed, %ld, netdev=%lx, tm=%lx\n",
+	       pdata->powerstate, (unsigned long)(pdata->netdev),
+	       (unsigned long)&pdata->phy_poll_tm);
+}
+
+int fxgmac_phy_timer_init(struct fxgmac_pdata *pdata)
+{
+	init_timer_key(&pdata->phy_poll_tm, NULL, 0,
+		       "fxgmac_phy_link_update_timer", NULL);
+
+	pdata->phy_poll_tm.expires = jiffies + HZ / 2;
+	pdata->phy_poll_tm.function = (void *)(fxgmac_phy_link_poll);
+	add_timer(&pdata->phy_poll_tm);
+
+	yt_dbg(pdata, "fxgmac_phy_timer started, %lx\n", jiffies);
+	return 0;
+}
+
+void fxgmac_phy_timer_destroy(struct fxgmac_pdata *pdata)
+{
+	del_timer_sync(&pdata->phy_poll_tm);
+	yt_dbg(pdata, "fxgmac_phy_timer removed\n");
+}
+
+int fxgmac_phy_cfg_led(struct fxgmac_pdata *pdata, u32 cfg[LED_CFG_LEN])
+{
+	if (!cfg)
+		return -EINVAL;
+
+	if (fxgmac_efuse_is_led_common(pdata) != true) {
+		yt_dbg(pdata, "Efuse is not led common, do nothing!\n");
+		return 0;
+	}
+
+	for (u32 i = 0; i < LED_CFG_LEN; i++) {
+		if (fxgmac_phy_write_ext_reg(pdata, PHY_EXT_COMMON_LED_CFG + i,
+					     cfg[i]) < 0)
+			return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+int fxgmac_phy_clear_interrupt(struct fxgmac_pdata *pdata)
+{
+	if (fxgmac_phy_read_reg(pdata, PHY_INT_STATUS, NULL) < 0)
+		return -ETIMEDOUT;
+
+	if (fxgmac_phy_read_reg(pdata, PHY_INT_STATUS, NULL) < 0)
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+int fxgmac_phy_irq_enable(struct fxgmac_pdata *pdata, bool clear_phy_interrupt)
+{
+	if (clear_phy_interrupt &&
+	    fxgmac_phy_read_reg(pdata, PHY_INT_STATUS, NULL) < 0)
+		return -ETIMEDOUT;
+
+	return fxgmac_phy_modify_reg(pdata, PHY_INT_MASK,
+				     PHY_INT_MASK_LINK_UP |
+					     PHY_INT_MASK_LINK_DOWN,
+				     PHY_INT_MASK_LINK_UP |
+					     PHY_INT_MASK_LINK_DOWN);
+}
diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_phy.h b/drivers/net/ethernet/motorcomm/yt6801/yt6801_phy.h
new file mode 100644
index 0000000..a543e0d
--- /dev/null
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_phy.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Copyright (c) 2022 - 2024 Motorcomm Electronic Technology Co.,Ltd. */
+
+#ifndef _YT6801_PHY_H_
+#define _YT6801_PHY_H_
+
+#include "yt6801.h"
+
+struct fxphy_ag_adv {
+	u8 auto_neg_en : 1;
+	u8 full_1000m : 1;
+	u8 half_1000m : 1;
+	u8 full_100m : 1;
+	u8 half_100m : 1;
+	u8 full_10m : 1;
+	u8 half_10m : 1;
+};
+
+#define PHY_LINK_TIMEOUT		3000
+#define PHY_MDIO_MAX_TRY		15
+
+int fxgmac_phy_write_reg(struct fxgmac_pdata *pdata, u32 reg_id, u32 data);
+int fxgmac_phy_read_reg(struct fxgmac_pdata *pdata, u32 reg_id, u32 *data);
+int fxgmac_phy_modify_reg(struct fxgmac_pdata *pdata, u32 reg_id, u32 mask,
+			  u32 set);
+int fxgmac_phy_write_ext_reg(struct fxgmac_pdata *pdata, u32 reg_id, u32 data);
+int fxgmac_phy_read_ext_reg(struct fxgmac_pdata *pdata, u32 reg_id, u32 *data);
+int fxgmac_phy_modify_ext_reg(struct fxgmac_pdata *pdata, u32 reg_id, u32 mask,
+			      u32 set);
+int fxgmac_phy_set_autoneg_advertise(struct fxgmac_pdata *pdata,
+				     struct fxphy_ag_adv phy_ag_adv);
+int fxgmac_phy_config(struct fxgmac_pdata *pdata);
+void fxgmac_phy_reset(struct fxgmac_pdata *pdata);
+int fxgmac_phy_release(struct fxgmac_pdata *pdata);
+int fxgmac_phy_force_mode(struct fxgmac_pdata *pdata);
+int fxgmac_phy_set_link_ksettings(struct fxgmac_pdata *pdata);
+void fxgmac_phy_update_link(struct net_device *netdev);
+void fxgmac_phy_link_poll(struct timer_list *t);
+int fxgmac_phy_irq_enable(struct fxgmac_pdata *pdata, bool clear_phy_interrupt);
+int fxgmac_phy_timer_init(struct fxgmac_pdata *pdata);
+void fxgmac_phy_timer_destroy(struct fxgmac_pdata *pdata);
+int fxgmac_phy_clear_interrupt(struct fxgmac_pdata *pdata);
+static inline u32 fxgmac_phy_get_state(struct fxgmac_pdata *pdata)
+{
+	return rd32_mem(pdata, EPHY_CTRL);
+}
+
+#endif /* _YT6801_PHY_H_ */
diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_type.h b/drivers/net/ethernet/motorcomm/yt6801/yt6801_type.h
new file mode 100644
index 0000000..9faf3c6
--- /dev/null
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_type.h
@@ -0,0 +1,1567 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Copyright (c) 2022 - 2024 Motorcomm Electronic Technology Co.,Ltd. */
+
+#ifndef _YT6801_TYPE_H_
+#define _YT6801_TYPE_H_
+
+#include <linux/netdevice.h>
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/mii.h>
+
+#define MOTORCOMM_PCI_ID			0x1f0a
+#define YT6801_PCI_DEVICE_ID			0x6801
+#define YT6801_REV_01				0x01
+#define YT6801_REV_03				0x03
+
+/****************  pcie configuration register. *********************/
+#define YT6801_MEM_BASE				PCI_BASE_ADDRESS_0
+#define YT6801_MEM_BASE_HI			PCI_BASE_ADDRESS_1
+#define YT6801_IO_BASE				PCI_BASE_ADDRESS_4
+
+#define PCI_PM_STATCTRL				0x44 /* WORD reg */
+#define PM_STATCTRL_PWR_STAT_POS		0
+#define PM_STATCTRL_PWR_STAT_LEN		2
+#define  PM_STATCTRL_PWR_STAT_D0		0
+#define  PM_STATCTRL_PWR_STAT_D3		3
+#define PM_CTRLSTAT_PME_EN_POS			8
+#define PM_CTRLSTAT_PME_EN_LEN			1
+#define PM_CTRLSTAT_DATA_SEL_POS		9
+#define PM_CTRLSTAT_DATA_SEL_LEN		4
+#define PM_CTRLSTAT_DATA_SCAL_POS		13
+#define PM_CTRLSTAT_DATA_SCAL_LEN		2
+#define PM_CTRLSTAT_PME_STAT_POS		15
+#define PM_CTRLSTAT_PME_STAT_LEN		1
+
+#define PCI_DEVICE_CTRL1			0x78
+#define DEVICE_CTRL1_CONTROL_POS		0
+#define DEVICE_CTRL1_CONTROL_LEN		16
+#define DEVICE_CTRL1_STATUS_POS			16
+#define DEVICE_CTRL1_STATUS_LEN			16
+
+#define PCI_LINK_CTRL				0x80
+#define LINK_CTRL_ASPM_CONTROL_POS		0
+#define LINK_CTRL_ASPM_CONTROL_LEN		2
+#define  LINK_CTRL_L1_STATUS			2
+#define LINK_CTRL_CONTROL_CPM_POS		8
+#define LINK_CTRL_CONTROL_CPM_LEN		1
+#define LINK_CTRL_STATUS_POS			16
+#define LINK_CTRL_STATUS_LEN			16
+
+#define PCI_DEVICE_CTRL2			0x98 /* WORD reg */
+#define DEVICE_CTRL2_LTR_EN_POS			10 /* Enable from BIOS side. */
+#define DEVICE_CTRL2_LTR_EN_LEN			1
+
+#define PCI_MSIX_CAPABILITY			0xb0
+
+#define PCI_ASPM_CONTROL			0x70c
+#define ASPM_L1_IDLE_THRESHOLD_POS		27
+#define ASPM_L1_IDLE_THRESHOLD_LEN		3
+#define  ASPM_L1_IDLE_THRESHOLD_1US		0
+#define  ASPM_L1_IDLE_THRESHOLD_2US		1
+#define  ASPM_L1_IDLE_THRESHOLD_4US		2
+#define  ASPM_L1_IDLE_THRESHOLD_8US		3 /* default value. */
+#define  ASPM_L1_IDLE_THRESHOLD_16US		4
+#define  ASPM_L1_IDLE_THRESHOLD_32US		5
+#define  ASPM_L1_IDLE_THRESHOLD_64US		6
+
+#define PCI_POWER_EIOS				0x710
+#define POWER_EIOS_POS				7
+#define POWER_EIOS_LEN				1
+
+#define PCIE_CFG_CTRL				0x8bc
+#define CFG_CTRL_CS_EN_POS			0
+#define CFG_CTRL_CS_EN_LEN			1
+#define CFG_CTRL_DEFAULT_VAL			0x7ff40
+
+/****************  other configuration register. *********************/
+#define GLOBAL_CTRL0					0x1000
+
+#define EPHY_CTRL					0x1004
+#define EPHY_CTRL_RESET_POS				0
+#define EPHY_CTRL_RESET_LEN				1
+#define  EPHY_CTRL_STA_RESET				(0 << 0)
+#define  EPHY_CTRL_STA_RELEASE				BIT(0)
+#define EPHY_CTRL_STA_LINKUP_POS			1
+#define EPHY_CTRL_STA_LINKUP_LEN			1
+#define  EPHY_CTRL_STA_LINKDOWN				(0 << 1)
+#define  EPHY_CTRL_STA_LINKUP				BIT(1)
+#define EPHY_CTRL_STA_DUPLEX_POS			2
+#define EPHY_CTRL_STA_DUPLEX_LEN			1
+#define EPHY_CTRL_STA_SPEED_POS				3
+#define EPHY_CTRL_STA_SPEED_LEN				2
+
+#define WOL_CTRL					0x100c
+#define WOL_LINKCHG_EN_POS				0
+#define WOL_LINKCHG_EN_LEN				1
+#define WOL_PKT_EN_POS					1
+#define WOL_PKT_EN_LEN					1
+#define WOL_WAIT_TIME_POS				2
+#define WOL_WAIT_TIME_LEN				13
+
+#define OOB_WOL_CTRL					0x1010
+#define OOB_WOL_CTRL_DIS_POS				0
+#define OOB_WOL_CTRL_DIS_LEN				1
+
+/* RSS implementation registers */
+
+/* 10 RSS key registers */
+#define MGMT_RSS_KEY0					0x1020
+#define MGMT_RSS_KEY9					0x1044
+#define MGMT_RSS_KEY_INC				0x4
+
+/* RSS control register */
+#define MGMT_RSS_CTRL					0x1048
+#define MGMT_RSS_CTRL_OPT_POS				0
+#define MGMT_RSS_CTRL_OPT_LEN				8
+#define  MGMT_RSS_CTRL_IPV4_EN				0x01
+#define  MGMT_RSS_CTRL_TCPV4_EN				0x02
+#define  MGMT_RSS_CTRL_UDPV4_EN				0x04
+#define  MGMT_RSS_CTRL_IPV6_EN				0x08
+#define  MGMT_RSS_CTRL_TCPV6_EN				0x10
+#define  MGMT_RSS_CTRL_UDPV6_EN				0x20
+#define  MGMT_RSS_CTRL_OPT_MASK				0xff
+#define MGMT_RSS_CTRL_DEFAULT_Q_POS			8
+#define MGMT_RSS_CTRL_DEFAULT_Q_LEN			2
+#define  MGMT_RSS_CTRL_DEFAULT_Q_MASK			0x3
+#define MGMT_RSS_CTRL_TBL_SIZE_POS			10
+#define MGMT_RSS_CTRL_TBL_SIZE_LEN			3
+#define  MGMT_RSS_CTRL_TBL_SIZE_MASK			0x7
+#define MGMT_RSS_CTRL_RSSE_POS				31
+#define MGMT_RSS_CTRL_RSSE_LEN				1
+
+/* rss indirection table (IDT) */
+#define MGMT_RSS_IDT					0x1050
+/* b0:1 entry0
+ * b2:3 entry1
+ * ...
+ */
+#define MGMT_RSS_IDT_INC				4
+#define MGMT_RSS_IDT_ENTRY_SIZE				16
+#define MGMT_RSS_IDT_ENTRY_MASK				0x3
+
+/* MAC management registers bit positions and sizes */
+#define MGMT_INT_CTRL0					0x1100
+#define MGMT_INT_CTRL0_INT_STATUS_POS			0
+#define MGMT_INT_CTRL0_INT_STATUS_LEN			16
+#define  MGMT_INT_CTRL0_INT_STATUS_RX			0x000f
+#define  MGMT_INT_CTRL0_INT_STATUS_TX			0x0010
+#define  MGMT_INT_CTRL0_INT_STATUS_MISC			0x0020
+#define  MGMT_INT_CTRL0_INT_STATUS_MASK			0xffff
+
+#define MGMT_INT_CTRL0_INT_MASK_POS			16
+#define MGMT_INT_CTRL0_INT_MASK_LEN			16
+#define  MGMT_INT_CTRL0_INT_MASK_RXCH			0x000f
+#define  MGMT_INT_CTRL0_INT_MASK_TXCH			0x0010
+#define  MGMT_INT_CTRL0_INT_MASK_EX_PMT			0xf7ff
+#define  MGMT_INT_CTRL0_INT_MASK_DISABLE		0xf000
+#define  MGMT_INT_CTRL0_INT_MASK_MASK			0xffff
+
+/* Interrupt Ctrl1 */
+#define INT_CTRL1				0x1104
+#define INT_CTRL1_TMR_CNT_CFG_MAX_POS		0
+#define INT_CTRL1_TMR_CNT_CFG_MAX_LEN		10
+#define INT_CTRL1_MSI_AIO_EN_POS		16
+#define INT_CTRL1_MSI_AIO_EN_LEN		1
+
+/* Interrupt Moderation */
+#define INT_MOD					0x1108
+#define INT_MOD_RX_POS				0
+#define INT_MOD_RX_LEN				12
+#define  INT_MOD_200_US				200
+#define INT_MOD_TX_POS				16
+#define INT_MOD_TX_LEN				12
+
+#define LTR_CTRL				0x1130
+#define LTR_CTRL_EN_POS				0
+#define LTR_CTRL_EN_LEN				1
+#define LTR_CTRL_IDLE_THRE_TIMER_POS		16
+#define LTR_CTRL_IDLE_THRE_TIMER_LEN		14 /* in 8ns units*/
+#define  LTR_CTRL_IDLE_THRE_TIMER_VAL		0x3fff
+
+/* LTR latency message, only for SW enable. */
+#define LTR_CTRL1				0x1134
+#define LTR_CTRL1_LTR_MSG_POS			0
+#define LTR_CTRL1_LTR_MSG_LEN			32
+
+#define LTR_CTRL2				0x1138
+#define LTR_CTRL2_DBG_DATA_POS			0
+#define LTR_CTRL2_DBG_DATA_LEN			32
+
+/* LTR_CTRL3, LTR latency message, only for System IDLE Start. */
+#define LTR_IDLE_ENTER				0x113c
+#define LTR_IDLE_ENTER_POS			0
+#define LTR_IDLE_ENTER_LEN			10
+#define  LTR_IDLE_ENTER_900_US			900
+#define LTR_IDLE_ENTER_SCALE_POS		10
+#define LTR_IDLE_ENTER_SCALE_LEN		5
+#define  LTR_IDLE_ENTER_SCALE_1_NS		0
+#define  LTR_IDLE_ENTER_SCALE_32_NS		1
+#define  LTR_IDLE_ENTER_SCALE_1024_NS		2
+#define  LTR_IDLE_ENTER_SCALE_32768_NS		3
+#define  LTR_IDLE_ENTER_SCALE_1048576_NS	4
+#define  LTR_IDLE_ENTER_SCALE_33554432_NS	5
+#define LTR_IDLE_ENTER_REQUIRE_POS		15
+#define LTR_IDLE_ENTER_REQUIRE_LEN		1
+#define  LTR_IDLE_ENTER_REQUIRE			1
+
+/* LTR_CTRL4, LTR latency message, only for System IDLE End. */
+#define LTR_IDLE_EXIT				0x1140
+#define LTR_IDLE_EXIT_POS			0
+#define LTR_IDLE_EXIT_LEN			10
+#define  LTR_IDLE_EXIT_171_US			171
+#define LTR_IDLE_EXIT_SCALE_POS			10
+#define LTR_IDLE_EXIT_SCALE_LEN			5
+#define  LTR_IDLE_EXIT_SCALE			2
+#define LTR_IDLE_EXIT_REQUIRE_POS		15
+#define LTR_IDLE_EXIT_REQUIRE_LEN		1
+#define  LTR_IDLE_EXIT_REQUIRE			1
+
+/* osc_ctrl */
+#define MGMT_XST_OSC_CTRL			 0x1158
+#define MGMT_XST_OSC_CTRL_EN_XST_POS		0
+#define MGMT_XST_OSC_CTRL_EN_XST_LEN		1
+#define MGMT_XST_OSC_CTRL_EN_OSC_POS		1
+#define MGMT_XST_OSC_CTRL_EN_OSC_LEN		1
+#define MGMT_XST_OSC_CTRL_XST_OSC_SEL_POS	2
+#define MGMT_XST_OSC_CTRL_XST_OSC_SEL_LEN	1
+
+#define MGMT_WPI_CTRL0				0x1160
+#define MGMT_WPI_CTRL0_WPI_MODE_POS		0
+#define MGMT_WPI_CTRL0_WPI_MODE_LEN		2
+#define  MGMT_WPI_CTRL0_WPI_MODE_NORMAL		0x00
+#define  MGMT_WPI_CTRL0_WPI_MODE_WR		0x01
+#define  MGMT_WPI_CTRL0_WPI_MODE_RD		0x02
+#define  MGMT_WPI_CTRL0_RAM_OP_DONE		0x04
+#define  MGMT_WPI_CTRL0_WPI_OP_DONE		0x08
+#define MGMT_WPI_CTRL0_WPI_PKT_LEN_POS		4
+#define MGMT_WPI_CTRL0_WPI_PKT_LEN_LEN		14
+#define MGMT_WPI_CTRL0_WPI_FAIL			BIT(31)
+
+#define MGMT_WPI_CTRL1_DATA			0x1164
+
+#define LPW_CTRL				0x1188
+/* Turn on before SW OTP operation, default 1. */
+#define LPW_CTRL_OTP_CLK_ON_POS			0
+#define LPW_CTRL_OTP_CLK_ON_LEN			1
+/* clock gating enable bit of MDIO2APB, default 1. enable clock gating feature*/
+#define LPW_CTRL_MDIO2APB_CG_EN_POS		1
+#define LPW_CTRL_MDIO2APB_CG_EN_LEN		1
+/* clock gating enable bit of GMAC AXI clock. Default 1; enable gating.*/
+#define LPW_CTRL_GMAC_AXI_CG_EN_POS		2
+#define LPW_CTRL_GMAC_AXI_CG_EN_LEN		1
+/* clock gating enable bit of PCIe AXI clock.Default 1; enable gating.*/
+#define LPW_CTRL_PCIE_AXI_CG_EN_POS		3
+#define LPW_CTRL_PCIE_AXI_CG_EN_LEN		1
+/* clock gating enable bit of PCIe Core clock. Default 1; enable gating.*/
+#define LPW_CTRL_PCIE_CORE_CG_EN_POS		4
+#define LPW_CTRL_PCIE_CORE_CG_EN_LEN		1
+/* clock gating enable bit of PCIe Radm clock. Default 1; enable gating.*/
+#define LPW_CTRL_PCIE_RADM_CG_EN_POS		5
+#define LPW_CTRL_PCIE_RADM_CG_EN_LEN		1
+/* system 125M select: 125M or 62.5MHz. Default: 125MHz.*/
+#define LPW_CTRL_SYS_CLK_125_SEL_POS		8
+#define LPW_CTRL_SYS_CLK_125_SEL_LEN		1
+#define LPW_CTRL_ASPM_LPW_EN_POS		9
+#define LPW_CTRL_ASPM_LPW_EN_LEN		1
+#define LPW_CTRL_ASPM_L1_EN_POS			16
+#define LPW_CTRL_ASPM_L1_EN_LEN			1
+#define LPW_CTRL_ASPM_L0S_EN_POS		17
+#define LPW_CTRL_ASPM_L0S_EN_LEN		1
+#define LPW_CTRL_ASPM_L1_CPM_POS		19
+#define LPW_CTRL_ASPM_L1_CPM_LEN		1
+#define LPW_CTRL_L1SS_SEL_POS			21
+#define LPW_CTRL_L1SS_SEL_LEN			1
+#define LPW_CTRL_L1SS_EN_POS			22
+#define LPW_CTRL_L1SS_EN_LEN			1
+
+#define MSIX_TBL_BASE				0x1200
+#define MSIX_TBL_MASK				0x120c
+
+/* msi table */
+#define MSI_ID_RXQ0				0
+#define MSI_ID_RXQ1				1
+#define MSI_ID_RXQ2				2
+#define MSI_ID_RXQ3				3
+#define MSI_ID_TXQ0				4
+#define MSI_ID_PHY_OTHER			5
+#define MSIX_TBL_RXTX_NUM			5
+#define MSIX_TBL_MAX_NUM			6
+
+#define MSI_PBA					0x1300
+
+#define EFUSE_OP_CTRL_0				0x1500
+#define EFUSE_OP_MODE_POS			0
+#define EFUSE_OP_MODE_LEN			2
+#define  EFUSE_OP_MODE_ROW_WRITE		0x0
+#define  EFUSE_OP_MODE_ROW_READ			0x1
+#define  EFUSE_OP_MODE_AUTO_LOAD		0x2
+#define  EFUSE_OP_MODE_READ_BLANK		0x3
+#define EFUSE_OP_START_POS			2
+#define EFUSE_OP_START_LEN			1
+#define EFUSE_OP_ADDR_POS			8
+#define EFUSE_OP_ADDR_LEN			8
+#define EFUSE_OP_WR_DATA_POS			16
+#define EFUSE_OP_WR_DATA_LEN			8
+
+#define EFUSE_OP_CTRL_1				0x1504
+#define EFUSE_OP_DONE_POS			1
+#define EFUSE_OP_DONE_LEN			1
+#define EFUSE_OP_PGM_PASS_POS			2
+#define EFUSE_OP_PGM_PASS_LEN			1
+#define EFUSE_OP_BIST_ERR_CNT_POS		8
+#define EFUSE_OP_BIST_ERR_CNT_LEN		8
+#define EFUSE_OP_BIST_ERR_ADDR_POS		16
+#define EFUSE_OP_BIST_ERR_ADDR_LEN		8
+#define EFUSE_OP_RD_DATA_POS			24
+#define EFUSE_OP_RD_DATA_LEN			8
+
+/* MAC addr can be configured through effuse */
+#define MACA0LR_FROM_EFUSE			0x1520
+#define MACA0HR_FROM_EFUSE			0x1524
+
+#define SYS_RESET				0x152c
+#define SYS_RESET_POS				31
+#define SYS_RESET_LEN				1
+
+#define EFUSE_LED_ADDR				0x00
+#define EFUSE_LED_POS				0
+#define EFUSE_LED_LEN				5
+#define EFUSE_OOB_ADDR				0x07
+#define EFUSE_OOB_POS				2
+#define EFUSE_OOB_LEN				1
+#define EFUSE_LED_SOLUTION0			0
+#define EFUSE_LED_SOLUTION1			1
+#define EFUSE_LED_SOLUTION2			2
+#define EFUSE_LED_SOLUTION3			3
+#define EFUSE_LED_SOLUTION4			4
+#define EFUSE_LED_COMMON_SOLUTION		0x1f
+
+#define MGMT_WOL_CTRL				0x1530
+#define MGMT_WOL_CTRL_WPI_LINK_CHG		BIT(0) /* waken by link-change */
+#define MGMT_WOL_CTRL_WPI_MGC_PKT		BIT(1) /* waken by magic-packet */
+#define MGMT_WOL_CTRL_WPI_RWK_PKT		BIT(2) /* waken by remote patten packet */
+#define MGMT_WOL_CTRL_WPI_RWK_PKT_NUMBER	BIT(16)
+
+#define MGMT_SIGDET_DEGLITCH			0x17f0
+/* sigdet deglitch disable ,active low */
+#define MGMT_SIGDET_DEGLITCH_DISABLE_POS	2
+#define MGMT_SIGDET_DEGLITCH_DISABLE_LEN	1
+/* sigdet deglitch time windows filter seltion */
+#define MGMT_SIGDET_DEGLITCH_TIME_WIN_POS	3
+#define MGMT_SIGDET_DEGLITCH_TIME_WIN_LEN	2
+#define  MGMT_SIGDET_DEGLITCH_TIME_WIN_10ns	0
+#define  MGMT_SIGDET_DEGLITCH_TIME_WIN_20ns	1
+#define  MGMT_SIGDET_DEGLITCH_TIME_WIN_30ns	2
+#define  MGMT_SIGDET_DEGLITCH_TIME_WIN_40ns	3
+
+#define MGMT_SIGDET				0x17f8
+#define MGMT_SIGDET_POS				13
+#define MGMT_SIGDET_LEN				3
+#define  MGMT_SIGDET_20MV			0
+#define  MGMT_SIGDET_25MV			1
+#define  MGMT_SIGDET_30MV			2
+#define  MGMT_SIGDET_35MV			3
+#define  MGMT_SIGDET_40MV			4
+#define  MGMT_SIGDET_45MV			5 /* default value */
+#define  MGMT_SIGDET_50MV			6
+#define  MGMT_SIGDET_55MV			7
+
+#define PCIE_SERDES_PLL				0x199c
+#define PCIE_SERDES_PLL_AUTOOFF_POS		0
+#define PCIE_SERDES_PLL_AUTOOFF_LEN		1
+
+#define NS_OF_GLB_CTL				0x1B00
+
+#define NS_TPID_PRO				0x1B04
+#define NS_TPID_PRO_CTPID_POS			0
+#define NS_TPID_PRO_CTPID_LEN			16
+#define NS_TPID_PRO_STPID_POS			16
+#define NS_TPID_PRO_STPID_LEN			16
+
+#define NS_LUT_ROMOTE0				0x1B08
+#define NS_LUT_ROMOTE1				0X1B0C
+#define NS_LUT_ROMOTE2				0X1B10
+#define NS_LUT_ROMOTE3				0X1B14
+#define NS_LUT_TARGET0				0X1B18
+#define NS_LUT_TARGET1				0X1B1C
+#define NS_LUT_TARGET2				0X1B20
+#define NS_LUT_TARGET3				0X1B24
+#define NS_LUT_SOLICITED0			0X1B28
+#define NS_LUT_SOLICITED1			0X1B2C
+#define NS_LUT_SOLICITED2			0X1B30
+#define NS_LUT_SOLICITED3			0X1B34
+#define NS_LUT_MAC_ADDR				0X1B38
+#define NS_LUT_MAC_ADDR_CTL			0X1B3C
+#define NS_LUT_MAC_ADDR_LOW_POS			0
+#define NS_LUT_MAC_ADDR_LOW_LEN			16
+#define NS_LUT_TARGET_ISANY_POS			16
+#define NS_LUT_TARGET_ISANY_LEN			1
+#define NS_LUT_REMOTE_AWARED_POS		17
+#define NS_LUT_REMOTE_AWARED_LEN		1
+#define NS_LUT_DST_IGNORED_POS			18
+#define NS_LUT_DST_IGNORED_LEN			1
+#define NS_LUT_DST_CMP_TYPE_POS			19
+#define NS_LUT_DST_CMP_TYPE_LEN			1
+#define NS_LUT_REMOTE_AWARED_POS		17
+#define NS_LUT_REMOTE_AWARED_LEN		1
+#define NS_LUT_DST_IGNORED_POS			18
+#define NS_LUT_DST_IGNORED_LEN			1
+#define NS_LUT_DST_CMP_TYPE_POS			19
+#define NS_LUT_DST_CMP_TYPE_LEN			1
+
+#define NS_LUT_TARGET4				0X1B78
+#define NS_LUT_TARGET5				0X1B7c
+#define NS_LUT_TARGET6				0X1B80
+#define NS_LUT_TARGET7				0X1B84
+
+/****************  GMAC register. *********************/
+/* MAC register offsets */
+#define MAC_OFFSET			0x2000
+#define MAC_CR				0x0000
+#define MAC_ECR				0x0004
+#define MAC_PFR				0x0008
+#define MAC_WTR				0x000c
+#define MAC_HTR0			0x0010
+#define MAC_VLANTR			0x0050
+#define MAC_VLANHTR			0x0058
+#define MAC_VLANIR			0x0060
+#define MAC_IVLANIR			0x0064
+#define MAC_Q0TFCR			0x0070
+#define MAC_RFCR			0x0090
+#define MAC_RQC0R			0x00a0
+#define MAC_RQC1R			0x00a4
+#define MAC_RQC2R			0x00a8
+#define MAC_RQC3R			0x00ac
+#define MAC_ISR				0x00b0
+#define MAC_IER				0x00b4
+#define MAC_TX_RX_STA			0x00b8
+#define MAC_PMT_STA			0x00c0
+#define MAC_RWK_PAC			0x00c4
+#define MAC_LPI_STA			0x00d0
+#define MAC_LPI_CONTROL			0x00d4
+#define MAC_LPI_TIMER			0x00d8
+#define MAC_MS_TIC_COUNTER		0x00dc
+#define MAC_AN_CR			0x00e0
+#define MAC_AN_SR			0x00e4
+#define MAC_AN_ADV			0x00e8
+#define MAC_AN_LPA			0x00ec
+#define MAC_AN_EXP			0x00f0
+#define MAC_PHYIF_STA			0x00f8
+#define MAC_VR				0x0110
+#define MAC_DBG_STA			0x0114
+#define MAC_HWF0R			0x011c
+#define MAC_HWF1R			0x0120
+#define MAC_HWF2R			0x0124
+#define MAC_HWF3R			0x0128
+#define MAC_MDIO_ADDRESS		0x0200
+#define MAC_MDIO_DATA			0x0204
+#define MAC_GPIOCR			0x0208
+#define MAC_GPIO_SR			0x020c
+#define MAC_ARP_PROTO_ADDR		0x0210
+#define MAC_CSR_SW_CTRL			0x0230
+#define MAC_MACA0HR			0x0300
+#define MAC_MACA0LR			0x0304
+#define MAC_MACA1HR			0x0308
+#define MAC_MACA1LR			0x030c
+
+#define MAC_QTFCR_INC			4
+#define MAC_MACA_INC			4
+#define MAC_HTR_INC			4
+#define MAC_RQC2_INC			4
+#define MAC_RQC2_Q_PER_REG		4
+
+/* MAC register entry bit positions and sizes */
+#define MAC_HWF0R_ADDMACADRSEL_POS	18
+#define MAC_HWF0R_ADDMACADRSEL_LEN	5
+#define MAC_HWF0R_ARPOFFSEL_POS		9
+#define MAC_HWF0R_ARPOFFSEL_LEN		1
+#define MAC_HWF0R_EEESEL_POS		13
+#define MAC_HWF0R_EEESEL_LEN		1
+#define MAC_HWF0R_ACTPHYIFSEL_POS	28
+#define MAC_HWF0R_ACTPHYIFSEL_LEN	3
+#define MAC_HWF0R_MGKSEL_POS		7
+#define MAC_HWF0R_MGKSEL_LEN		1
+#define MAC_HWF0R_MMCSEL_POS		8
+#define MAC_HWF0R_MMCSEL_LEN		1
+#define MAC_HWF0R_RWKSEL_POS		6
+#define MAC_HWF0R_RWKSEL_LEN		1
+#define MAC_HWF0R_RXCOESEL_POS		16
+#define MAC_HWF0R_RXCOESEL_LEN		1
+#define MAC_HWF0R_SAVLANINS_POS		27
+#define MAC_HWF0R_SAVLANINS_LEN		1
+#define MAC_HWF0R_SMASEL_POS		5
+#define MAC_HWF0R_SMASEL_LEN		1
+#define MAC_HWF0R_TSSEL_POS		12
+#define MAC_HWF0R_TSSEL_LEN		1
+#define MAC_HWF0R_TSSTSSEL_POS		25
+#define MAC_HWF0R_TSSTSSEL_LEN		2
+#define MAC_HWF0R_TXCOESEL_POS		14
+#define MAC_HWF0R_TXCOESEL_LEN		1
+#define MAC_HWF0R_VLHASH_POS		4
+#define MAC_HWF0R_VLHASH_LEN		1
+#define MAC_HWF1R_ADDR64_POS		14
+#define MAC_HWF1R_ADDR64_LEN		2
+#define MAC_HWF1R_ADVTHWORD_POS		13
+#define MAC_HWF1R_ADVTHWORD_LEN		1
+#define MAC_HWF1R_DBGMEMA_POS		19
+#define MAC_HWF1R_DBGMEMA_LEN		1
+#define MAC_HWF1R_DCBEN_POS		16
+#define MAC_HWF1R_DCBEN_LEN		1
+#define MAC_HWF1R_HASHTBLSZ_POS		24
+#define MAC_HWF1R_HASHTBLSZ_LEN		2
+#define MAC_HWF1R_L3L4FNUM_POS		27
+#define MAC_HWF1R_L3L4FNUM_LEN		4
+#define MAC_HWF1R_RAVSEL_POS		21
+#define MAC_HWF1R_RAVSEL_LEN		1
+#define MAC_HWF1R_AVSEL_POS		20
+#define MAC_HWF1R_AVSEL_LEN		1
+#define MAC_HWF1R_RXFIFOSIZE_POS	0
+#define MAC_HWF1R_RXFIFOSIZE_LEN	5
+#define MAC_HWF1R_SPHEN_POS		17
+#define MAC_HWF1R_SPHEN_LEN		1
+#define MAC_HWF1R_TSOEN_POS		18
+#define MAC_HWF1R_TSOEN_LEN		1
+#define MAC_HWF1R_TXFIFOSIZE_POS	6
+#define MAC_HWF1R_TXFIFOSIZE_LEN	5
+#define MAC_HWF2R_AUXSNAPNUM_POS	28
+#define MAC_HWF2R_AUXSNAPNUM_LEN	3
+#define MAC_HWF2R_PPSOUTNUM_POS		24
+#define MAC_HWF2R_PPSOUTNUM_LEN		3
+#define MAC_HWF2R_RXCHCNT_POS		12
+#define MAC_HWF2R_RXCHCNT_LEN		4
+#define MAC_HWF2R_RXQCNT_POS		0
+#define MAC_HWF2R_RXQCNT_LEN		4
+#define MAC_HWF2R_TXCHCNT_POS		18
+#define MAC_HWF2R_TXCHCNT_LEN		4
+#define MAC_HWF2R_TXQCNT_POS		6
+#define MAC_HWF2R_TXQCNT_LEN		4
+#define MAC_IER_TSIE_POS		12
+#define MAC_IER_TSIE_LEN		1
+
+#define MAC_ISR_PHYIF_STA_POS		0
+#define MAC_ISR_AN_SR0_POS		1
+#define MAC_ISR_AN_SR1_POS		2
+#define MAC_ISR_AN_SR2_POS		3
+#define MAC_ISR_PMT_STA_POS		4
+#define MAC_ISR_LPI_STA_POS		5
+#define MAC_ISR_MMC_STA_POS		8
+#define MAC_ISR_RX_MMC_STA_POS		9
+#define MAC_ISR_TX_MMC_STA_POS		10
+#define MAC_ISR_IPCRXINT_POS		11
+#define MAC_ISR_TX_RX_STA0_POS		13
+#define MAC_ISR_TSIS_POS		12
+#define MAC_ISR_TX_RX_STA1_POS		14
+#define MAC_ISR_GPIO_SR_POS		15
+
+#define MAC_MACA1HR_AE_POS		31
+#define MAC_MACA1HR_AE_LEN		1
+#define MAC_PFR_HMC_POS			2
+#define MAC_PFR_HMC_LEN			1
+#define MAC_PFR_HPF_POS			10
+#define MAC_PFR_HPF_LEN			1
+#define MAC_PFR_PM_POS			4 /* Pass all Multicast. */
+#define MAC_PFR_PM_LEN			1
+#define MAC_PFR_DBF_POS			5 /* Disable Broadcast Packets. */
+#define MAC_PFR_DBF_LEN			1
+#define MAC_PFR_HUC_POS			1
+/* Hash Unicast. 0x0 (DISABLE). compares the DA field with the values
+ * programmed in DA registers.
+ */
+#define MAC_PFR_HUC_LEN			1
+#define MAC_PFR_PR_POS			0 /* Enable Promiscuous Mode. */
+#define MAC_PFR_PR_LEN			1
+#define MAC_PFR_VTFE_POS		16
+#define MAC_PFR_VTFE_LEN		1
+#define MAC_Q0TFCR_PT_POS		16
+#define MAC_Q0TFCR_PT_LEN		16
+#define MAC_Q0TFCR_TFE_POS		1
+#define MAC_Q0TFCR_TFE_LEN		1
+#define MAC_CR_ARPEN_POS		31
+#define MAC_CR_ARPEN_LEN		1
+#define MAC_CR_ACS_POS			20
+#define MAC_CR_ACS_LEN			1
+#define MAC_CR_CST_POS			21
+#define MAC_CR_CST_LEN			1
+#define MAC_CR_IPC_POS			27
+#define MAC_CR_IPC_LEN			1
+#define MAC_CR_JE_POS			16
+#define MAC_CR_JE_LEN			1
+#define MAC_CR_LM_POS			12
+#define MAC_CR_LM_LEN			1
+#define MAC_CR_RE_POS			0
+#define MAC_CR_RE_LEN			1
+#define MAC_CR_PS_POS			15
+#define MAC_CR_PS_LEN			1
+#define MAC_CR_FES_POS			14
+#define MAC_CR_FES_LEN			1
+#define MAC_CR_DM_POS			13
+#define MAC_CR_DM_LEN			1
+#define MAC_CR_TE_POS			1
+#define MAC_CR_TE_LEN			1
+#define MAC_ECR_DCRCC_POS		16
+#define MAC_ECR_DCRCC_LEN		1
+#define MAC_ECR_HDSMS_POS		20
+#define MAC_ECR_HDSMS_LEN		3
+/* Maximum Size for Splitting the Header Data: 512 bytes */
+#define  FXGMAC_SPH_HDSMS_SIZE		3
+#define MAC_RFCR_PFCE_POS		8
+#define MAC_RFCR_PFCE_LEN		1
+#define MAC_RFCR_RFE_POS		0
+#define MAC_RFCR_RFE_LEN		1
+#define MAC_RFCR_UP_POS			1
+#define MAC_RFCR_UP_LEN			1
+#define MAC_RQC0R_RXQ0EN_POS		0
+#define MAC_RQC0R_RXQ0EN_LEN		2
+#define MAC_LPIIE_POS			5
+#define MAC_LPIIE_LEN			1
+#define MAC_LPIATE_POS			20
+#define MAC_LPIATE_LEN			1
+#define MAC_LPITXA_POS			19
+#define MAC_LPITXA_LEN			1
+#define MAC_PLS_POS			17
+#define MAC_PLS_LEN			1
+#define MAC_LPIEN_POS			16
+#define MAC_LPIEN_LEN			1
+#define MAC_LPI_ENTRY_TIMER		8
+#define MAC_LPIET_POS			3
+#define MAC_LPIET_LEN			17
+#define MAC_TWT_TIMER			0x10
+#define MAC_TWT_POS			0
+#define MAC_TWT_LEN			16
+#define MAC_LST_TIMER			2
+#define MAC_LST_POS			16
+#define MAC_LST_LEN			10
+#define MAC_MS_TIC			24
+#define MAC_MS_TIC_POS			0
+#define MAC_MS_TIC_LEN			12
+
+/* RSS table */
+#define MAC_RSSAR_ADDRT_POS		2
+#define MAC_RSSAR_ADDRT_LEN		1
+#define MAC_RSSAR_CT_POS		1
+#define MAC_RSSAR_CT_LEN		1
+#define MAC_RSSAR_OB_POS		0
+#define MAC_RSSAR_OB_LEN		1
+#define MAC_RSSAR_RSSIA_POS		8
+#define MAC_RSSAR_RSSIA_LEN		8
+
+/* RSS indirection table */
+#define MAC_RSSDR_DMCH_POS		0
+#define MAC_RSSDR_DMCH_LEN		2
+
+#define MAC_VLANHTR_VLHT_POS		0
+#define MAC_VLANHTR_VLHT_LEN		16
+#define MAC_VLANIR_VLTI_POS		20
+#define MAC_VLANIR_VLTI_LEN		1
+#define MAC_VLANIR_CSVL_POS		19
+#define MAC_VLANIR_CSVL_LEN		1
+#define MAC_VLANIR_VLP_POS		18
+#define MAC_VLANIR_VLP_LEN		1
+#define MAC_VLANIR_VLC_POS		16
+#define MAC_VLANIR_VLC_LEN		2
+#define MAC_VLANIR_VLT_POS		0
+#define MAC_VLANIR_VLT_LEN		16
+#define MAC_VLANTR_DOVLTC_POS		20
+#define MAC_VLANTR_DOVLTC_LEN		1
+#define MAC_VLANTR_ERSVLM_POS		19
+#define MAC_VLANTR_ERSVLM_LEN		1
+#define MAC_VLANTR_ESVL_POS		18
+#define MAC_VLANTR_ESVL_LEN		1
+#define MAC_VLANTR_ETV_POS		16
+#define MAC_VLANTR_ETV_LEN		1
+#define MAC_VLANTR_EVLS_POS		21
+#define MAC_VLANTR_EVLS_LEN		2
+#define MAC_VLANTR_EVLRXS_POS		24
+#define MAC_VLANTR_EVLRXS_LEN		1
+#define MAC_VLANTR_VL_POS		0
+#define MAC_VLANTR_VL_LEN		16
+#define MAC_VLANTR_VTHM_POS		25
+#define MAC_VLANTR_VTHM_LEN		1
+#define MAC_VLANTR_VTIM_POS		17
+#define MAC_VLANTR_VTIM_LEN		1
+#define MAC_VR_DEVID_POS		16
+#define MAC_VR_DEVID_LEN		16
+#define MAC_VR_SVER_POS			0
+#define MAC_VR_SVER_LEN			8
+#define MAC_VR_USERVER_POS		8
+#define MAC_VR_USERVER_LEN		8
+
+#define MAC_DBG_STA_TX_BUSY		0x70000
+#define MTL_TXQ_DEG_TX_BUSY		0x10
+
+#define MAC_MDIO_ADDR_BUSY		1
+#define MAC_MDIO_ADDR_GOC_POS		2
+#define MAC_MDIO_ADDR_GOC_LEN		2
+#define MAC_MDIO_ADDR_GB_POS		0
+#define MAC_MDIO_ADDR_GB_LEN		1
+
+#define MAC_MDIO_DATA_RA_POS		16
+#define MAC_MDIO_DATA_RA_LEN		16
+#define MAC_MDIO_DATA_GD_POS		0
+#define MAC_MDIO_DATA_GD_LEN		16
+
+/* bit definitions for PMT and WOL */
+#define MAC_PMT_STA_PWRDWN_POS		0
+#define MAC_PMT_STA_PWRDWN_LEN		1
+#define MAC_PMT_STA_MGKPKTEN_POS	1
+#define MAC_PMT_STA_MGKPKTEN_LEN	1
+#define MAC_PMT_STA_RWKPKTEN_POS	2
+#define MAC_PMT_STA_RWKPKTEN_LEN	1
+#define MAC_PMT_STA_MGKPRCVD_POS	5
+#define MAC_PMT_STA_MGKPRCVD_LEN	1
+#define MAC_PMT_STA_RWKPRCVD_POS	6
+#define MAC_PMT_STA_RWKPRCVD_LEN	1
+#define MAC_PMT_STA_GLBLUCAST_POS	9
+#define MAC_PMT_STA_GLBLUCAST_LEN	1
+#define MAC_PMT_STA_RWKPTR_POS		24
+#define MAC_PMT_STA_RWKPTR_LEN		4
+#define MAC_PMT_STA_RWKFILTERST_POS	31
+#define MAC_PMT_STA_RWKFILTERST_LEN	1
+
+/* MMC register offsets */
+#define MMC_CR				0x0700
+#define MMC_RISR			0x0704
+#define MMC_TISR			0x0708
+#define MMC_RIER			0x070c
+#define MMC_TIER			0x0710
+#define MMC_TXOCTETCOUNT_GB_LO		0x0714
+#define MMC_TXFRAMECOUNT_GB_LO		0x0718
+#define MMC_TXBROADCASTFRAMES_G_LO	0x071c
+#define MMC_TXMULTICASTFRAMES_G_LO	0x0720
+#define MMC_TX64OCTETS_GB_LO		0x0724
+#define MMC_TX65TO127OCTETS_GB_LO	0x0728
+#define MMC_TX128TO255OCTETS_GB_LO	0x072c
+#define MMC_TX256TO511OCTETS_GB_LO	0x0730
+#define MMC_TX512TO1023OCTETS_GB_LO	0x0734
+#define MMC_TX1024TOMAXOCTETS_GB_LO	0x0738
+#define MMC_TXUNICASTFRAMES_GB_LO	0x073c
+#define MMC_TXMULTICASTFRAMES_GB_LO	0x0740
+#define MMC_TXBROADCASTFRAMES_GB_LO	0x0744
+#define MMC_TXUNDERFLOWERROR_LO		0x0748
+#define MMC_TXSINGLECOLLISION_G		0x074c
+#define MMC_TXMULTIPLECOLLISION_G	0x0750
+#define MMC_TXDEFERREDFRAMES		0x0754
+#define MMC_TXLATECOLLISIONFRAMES	0x0758
+#define MMC_TXEXCESSIVECOLLSIONFRAMES	0x075c
+#define MMC_TXCARRIERERRORFRAMES	0x0760
+#define MMC_TXOCTETCOUNT_G_LO		0x0764
+#define MMC_TXFRAMECOUNT_G_LO		0x0768
+#define MMC_TXEXCESSIVEDEFERRALERROR	0x076c
+#define MMC_TXPAUSEFRAMES_LO		0x0770
+#define MMC_TXVLANFRAMES_G_LO		0x0774
+#define MMC_TXOVERSIZEFRAMES		0x0778
+#define MMC_RXFRAMECOUNT_GB_LO		0x0780
+#define MMC_RXOCTETCOUNT_GB_LO		0x0784
+#define MMC_RXOCTETCOUNT_G_LO		0x0788
+#define MMC_RXBROADCASTFRAMES_G_LO	0x078c
+#define MMC_RXMULTICASTFRAMES_G_LO	0x0790
+#define MMC_RXCRCERROR_LO		0x0794
+#define MMC_RXALIGNERROR		0x0798
+#define MMC_RXRUNTERROR			0x079c
+#define MMC_RXJABBERERROR		0x07a0
+#define MMC_RXUNDERSIZE_G		0x07a4
+#define MMC_RXOVERSIZE_G		0x07a8
+#define MMC_RX64OCTETS_GB_LO		0x07ac
+#define MMC_RX65TO127OCTETS_GB_LO	0x07b0
+#define MMC_RX128TO255OCTETS_GB_LO	0x07b4
+#define MMC_RX256TO511OCTETS_GB_LO	0x07b8
+#define MMC_RX512TO1023OCTETS_GB_LO	0x07bc
+#define MMC_RX1024TOMAXOCTETS_GB_LO	0x07c0
+#define MMC_RXUNICASTFRAMES_G_LO	0x07c4
+#define MMC_RXLENGTHERROR_LO		0x07c8
+#define MMC_RXOUTOFRANGETYPE_LO		0x07cc
+#define MMC_RXPAUSEFRAMES_LO		0x07d0
+#define MMC_RXFIFOOVERFLOW_LO		0x07d4
+#define MMC_RXVLANFRAMES_GB_LO		0x07d8
+#define MMC_RXWATCHDOGERROR		0x07dc
+#define MMC_RXRECEIVEERRORFRAME		0x07e0
+#define MMC_RXCONTROLFRAME_G		0x07e4
+#define MMC_IPCRXINTMASK		0x0800
+#define MMC_IPCRXINT			0x0808
+
+/* MMC register entry bit positions and sizes */
+#define MMC_CR_CR_POS				0
+#define MMC_CR_CR_LEN				1
+#define MMC_CR_CSR_POS				1
+#define MMC_CR_CSR_LEN				1
+#define MMC_CR_ROR_POS				2
+#define MMC_CR_ROR_LEN				1
+#define MMC_CR_MCF_POS				3
+#define MMC_CR_MCF_LEN				1
+#define MMC_RIER_ALL_INTERRUPTS_POS		0
+#define MMC_RIER_ALL_INTERRUPTS_LEN		28
+#define MMC_RISR_RXFRAMECOUNT_GB_POS		0
+#define MMC_RISR_RXFRAMECOUNT_GB_LEN		1
+#define MMC_RISR_RXOCTETCOUNT_GB_POS		1
+#define MMC_RISR_RXOCTETCOUNT_GB_LEN		1
+#define MMC_RISR_RXOCTETCOUNT_G_POS		2
+#define MMC_RISR_RXOCTETCOUNT_G_LEN		1
+#define MMC_RISR_RXBROADCASTFRAMES_G_POS	3
+#define MMC_RISR_RXBROADCASTFRAMES_G_LEN	1
+#define MMC_RISR_RXMULTICASTFRAMES_G_POS	4
+#define MMC_RISR_RXMULTICASTFRAMES_G_LEN	1
+#define MMC_RISR_RXCRCERROR_POS			5
+#define MMC_RISR_RXCRCERROR_LEN			1
+#define MMC_RISR_RXALIGNERROR_POS		6
+#define MMC_RISR_RXALIGNERROR_LEN		1
+#define MMC_RISR_RXRUNTERROR_POS		7
+#define MMC_RISR_RXRUNTERROR_LEN		1
+#define MMC_RISR_RXJABBERERROR_POS		8
+#define MMC_RISR_RXJABBERERROR_LEN		1
+#define MMC_RISR_RXUNDERSIZE_G_POS		9
+#define MMC_RISR_RXUNDERSIZE_G_LEN		1
+#define MMC_RISR_RXOVERSIZE_G_POS		10
+#define MMC_RISR_RXOVERSIZE_G_LEN		1
+#define MMC_RISR_RX64OCTETS_GB_POS		11
+#define MMC_RISR_RX64OCTETS_GB_LEN		1
+#define MMC_RISR_RX65TO127OCTETS_GB_POS		12
+#define MMC_RISR_RX65TO127OCTETS_GB_LEN		1
+#define MMC_RISR_RX128TO255OCTETS_GB_POS	13
+#define MMC_RISR_RX128TO255OCTETS_GB_LEN	1
+#define MMC_RISR_RX256TO511OCTETS_GB_POS	14
+#define MMC_RISR_RX256TO511OCTETS_GB_LEN	1
+#define MMC_RISR_RX512TO1023OCTETS_GB_POS	15
+#define MMC_RISR_RX512TO1023OCTETS_GB_LEN	1
+#define MMC_RISR_RX1024TOMAXOCTETS_GB_POS	16
+#define MMC_RISR_RX1024TOMAXOCTETS_GB_LEN	1
+#define MMC_RISR_RXUNICASTFRAMES_G_POS		17
+#define MMC_RISR_RXUNICASTFRAMES_G_LEN		1
+#define MMC_RISR_RXLENGTHERROR_POS		18
+#define MMC_RISR_RXLENGTHERROR_LEN		1
+#define MMC_RISR_RXOUTOFRANGETYPE_POS		19
+#define MMC_RISR_RXOUTOFRANGETYPE_LEN		1
+#define MMC_RISR_RXPAUSEFRAMES_POS		20
+#define MMC_RISR_RXPAUSEFRAMES_LEN		1
+#define MMC_RISR_RXFIFOOVERFLOW_POS		21
+#define MMC_RISR_RXFIFOOVERFLOW_LEN		1
+#define MMC_RISR_RXVLANFRAMES_GB_POS		22
+#define MMC_RISR_RXVLANFRAMES_GB_LEN		1
+#define MMC_RISR_RXWATCHDOGERROR_POS		23
+#define MMC_RISR_RXWATCHDOGERROR_LEN		1
+#define MMC_RISR_RXERRORFRAMES_POS		24
+#define MMC_RISR_RXERRORFRAMES_LEN		1
+#define MMC_RISR_RXERRORCONTROLFRAMES_POS	25
+#define MMC_RISR_RXERRORCONTROLFRAMES_LEN	1
+#define MMC_RISR_RXLPIMICROSECOND_POS		26
+#define MMC_RISR_RXLPIMICROSECOND_LEN		1
+#define MMC_RISR_RXLPITRANSITION_POS		27
+#define MMC_RISR_RXLPITRANSITION_LEN		1
+
+#define MMC_TIER_ALL_INTERRUPTS_POS		0
+#define MMC_TIER_ALL_INTERRUPTS_LEN		28
+#define MMC_TISR_TXOCTETCOUNT_GB_POS		0
+#define MMC_TISR_TXOCTETCOUNT_GB_LEN		1
+#define MMC_TISR_TXFRAMECOUNT_GB_POS		1
+#define MMC_TISR_TXFRAMECOUNT_GB_LEN		1
+#define MMC_TISR_TXBROADCASTFRAMES_G_POS	2
+#define MMC_TISR_TXBROADCASTFRAMES_G_LEN	1
+#define MMC_TISR_TXMULTICASTFRAMES_G_POS	3
+#define MMC_TISR_TXMULTICASTFRAMES_G_LEN	1
+#define MMC_TISR_TX64OCTETS_GB_POS		4
+#define MMC_TISR_TX64OCTETS_GB_LEN		1
+#define MMC_TISR_TX65TO127OCTETS_GB_POS		5
+#define MMC_TISR_TX65TO127OCTETS_GB_LEN		1
+#define MMC_TISR_TX128TO255OCTETS_GB_POS	6
+#define MMC_TISR_TX128TO255OCTETS_GB_LEN	1
+#define MMC_TISR_TX256TO511OCTETS_GB_POS	7
+#define MMC_TISR_TX256TO511OCTETS_GB_LEN	1
+#define MMC_TISR_TX512TO1023OCTETS_GB_POS	8
+#define MMC_TISR_TX512TO1023OCTETS_GB_LEN	1
+#define MMC_TISR_TX1024TOMAXOCTETS_GB_POS	9
+#define MMC_TISR_TX1024TOMAXOCTETS_GB_LEN	1
+#define MMC_TISR_TXUNICASTFRAMES_GB_POS		10
+#define MMC_TISR_TXUNICASTFRAMES_GB_LEN		1
+#define MMC_TISR_TXMULTICASTFRAMES_GB_POS	11
+#define MMC_TISR_TXMULTICASTFRAMES_GB_LEN	1
+#define MMC_TISR_TXBROADCASTFRAMES_GB_POS	12
+#define MMC_TISR_TXBROADCASTFRAMES_GB_LEN	1
+#define MMC_TISR_TXUNDERFLOWERROR_POS		13
+#define MMC_TISR_TXUNDERFLOWERROR_LEN		1
+#define MMC_TISR_TXSINGLECOLLISION_G_POS	14
+#define MMC_TISR_TXSINGLECOLLISION_G_LEN	1
+#define MMC_TISR_TXMULTIPLECOLLISION_G_POS	15
+#define MMC_TISR_TXMULTIPLECOLLISION_G_LEN	1
+#define MMC_TISR_TXDEFERREDFRAMES_POS		16
+#define MMC_TISR_TXDEFERREDFRAMES_LEN		1
+#define MMC_TISR_TXLATECOLLISIONFRAMES_POS	17
+#define MMC_TISR_TXLATECOLLISIONFRAMES_LEN	1
+#define MMC_TISR_TXEXCESSIVECOLLISIONFRAMES_POS 18
+#define MMC_TISR_TXEXCESSIVECOLLISIONFRAMES_LEN 1
+#define MMC_TISR_TXCARRIERERRORFRAMES_POS	19
+#define MMC_TISR_TXCARRIERERRORFRAMES_LEN	1
+#define MMC_TISR_TXOCTETCOUNT_G_POS		20
+#define MMC_TISR_TXOCTETCOUNT_G_LEN		1
+#define MMC_TISR_TXFRAMECOUNT_G_POS		21
+#define MMC_TISR_TXFRAMECOUNT_G_LEN		1
+#define MMC_TISR_TXEXCESSIVEDEFERRALFRAMES_POS	22
+#define MMC_TISR_TXEXCESSIVEDEFERRALFRAMES_LEN	1
+#define MMC_TISR_TXPAUSEFRAMES_POS		23
+#define MMC_TISR_TXPAUSEFRAMES_LEN		1
+#define MMC_TISR_TXVLANFRAMES_G_POS		24
+#define MMC_TISR_TXVLANFRAMES_G_LEN		1
+#define MMC_TISR_TXOVERSIZE_G_POS		25
+#define MMC_TISR_TXOVERSIZE_G_LEN		1
+#define MMC_TISR_TXLPIMICROSECOND_POS		26
+#define MMC_TISR_TXLPIMICROSECOND_LEN		1
+#define MMC_TISR_TXLPITRANSITION_POS		27
+#define MMC_TISR_TXLPITRANSITION_LEN		1
+
+/* MTL register offsets */
+#define MTL_OMR					0x0c00
+#define MTL_FDCR				0x0c08
+#define MTL_FDSR				0x0c0c
+#define MTL_FDDR				0x0c10
+#define MTL_INT_SR				0x0c20
+#define MTL_RQDCM0R				0x0c30
+#define MTL_ECC_INT_SR				0x0ccc
+
+#define MTL_RQDCM_INC				4
+#define MTL_RQDCM_Q_PER_REG			4
+
+/* MTL register entry bit positions and sizes */
+#define MTL_OMR_ETSALG_POS			5
+#define MTL_OMR_ETSALG_LEN			2
+#define MTL_OMR_RAA_POS				2
+#define MTL_OMR_RAA_LEN				1
+
+/* MTL queue register offsets
+ *   Multiple queues can be active. The first queue has registers
+ *   that begin at 0x0d00. Each subsequent queue has registers that
+ *   are accessed using an offset of 0x40 from the previous queue.
+ */
+#define MTL_Q_BASE				0x0d00
+#define MTL_Q_INC				0x40
+#define MTL_Q_INT_CTL_SR			0x0d2c
+
+#define MTL_Q_TQOMR				0x00
+#define MTL_Q_TQUR				0x04
+#define MTL_Q_RQOMR				0x30
+#define MTL_Q_RQMPOCR				0x34
+#define MTL_Q_RQDR				0x38
+#define MTL_Q_RQCR				0x3c
+#define MTL_Q_IER				0x2c
+#define MTL_Q_ISR				0x2c
+#define MTL_TXQ_DEG				0x08 /* transmit debug */
+
+/* MTL queue register entry bit positions and sizes */
+#define MTL_Q_RQDR_PRXQ_POS			16
+#define MTL_Q_RQDR_PRXQ_LEN			14
+#define MTL_Q_RQDR_RXQSTS_POS			4
+#define MTL_Q_RQDR_RXQSTS_LEN			2
+#define MTL_Q_RQOMR_RFA_POS			8
+#define MTL_Q_RQOMR_RFA_LEN			6
+#define MTL_Q_RQOMR_RFD_POS			14
+#define MTL_Q_RQOMR_RFD_LEN			6
+#define MTL_Q_RQOMR_EHFC_POS			7
+#define MTL_Q_RQOMR_EHFC_LEN			1
+#define MTL_Q_RQOMR_RQS_POS			20
+#define MTL_Q_RQOMR_RQS_LEN			9
+#define MTL_Q_RQOMR_RSF_POS			5
+#define MTL_Q_RQOMR_RSF_LEN			1
+#define MTL_Q_RQOMR_FEP_POS			4
+#define MTL_Q_RQOMR_FEP_LEN			1
+#define MTL_Q_RQOMR_FUP_POS			3
+#define MTL_Q_RQOMR_FUP_LEN			1
+#define MTL_Q_RQOMR_RTC_POS			0
+#define MTL_Q_RQOMR_RTC_LEN			2
+#define MTL_Q_TQOMR_FTQ_POS			0
+#define MTL_Q_TQOMR_FTQ_LEN			1
+#define MTL_Q_TQOMR_TQS_POS			16
+#define MTL_Q_TQOMR_TQS_LEN			7
+#define MTL_Q_TQOMR_TSF_POS			1
+#define MTL_Q_TQOMR_TSF_LEN			1
+#define MTL_Q_TQOMR_TTC_POS			4
+#define MTL_Q_TQOMR_TTC_LEN			3
+#define MTL_Q_TQOMR_TXQEN_POS			2
+#define MTL_Q_TQOMR_TXQEN_LEN			2
+
+/* MTL queue register value */
+#define MTL_RSF_DISABLE				0x00
+#define MTL_RSF_ENABLE				0x01
+#define MTL_TSF_DISABLE				0x00
+#define MTL_TSF_ENABLE				0x01
+#define MTL_FEP_DISABLE				0x00
+#define MTL_FEP_ENABLE				0x01
+
+#define MTL_RX_THRESHOLD_64			0x00
+#define MTL_RX_THRESHOLD_32			0x01
+#define MTL_RX_THRESHOLD_96			0x02
+#define MTL_RX_THRESHOLD_128			0x03
+#define MTL_TX_THRESHOLD_32			0x00
+#define MTL_TX_THRESHOLD_64			0x01
+#define MTL_TX_THRESHOLD_96			0x02
+#define MTL_TX_THRESHOLD_128			0x03
+#define MTL_TX_THRESHOLD_192			0x04
+#define MTL_TX_THRESHOLD_256			0x05
+#define MTL_TX_THRESHOLD_384			0x06
+#define MTL_TX_THRESHOLD_512			0x07
+
+#define MTL_ETSALG_WRR				0x00
+#define MTL_ETSALG_WFQ				0x01
+#define MTL_ETSALG_DWRR				0x02
+#define MTL_ETSALG_SP				0x03
+
+#define MTL_RAA_SP				0x00
+#define MTL_RAA_WSP				0x01
+
+#define MTL_Q_DISABLED				0x00
+#define MTL_Q_EN_IF_AV				0x01
+#define MTL_Q_ENABLED				0x02
+
+#define MTL_RQDCM0R_Q0MDMACH			0x0
+#define MTL_RQDCM0R_Q1MDMACH			0x00000100
+#define MTL_RQDCM0R_Q2MDMACH			0x00020000
+#define MTL_RQDCM0R_Q3MDMACH			0x03000000
+#define MTL_RQDCM1R_Q4MDMACH			0x00000004
+#define MTL_RQDCM1R_Q5MDMACH			0x00000500
+#define MTL_RQDCM1R_Q6MDMACH			0x00060000
+#define MTL_RQDCM1R_Q7MDMACH			0x07000000
+#define MTL_RQDCM2R_Q8MDMACH			0x00000008
+#define MTL_RQDCM2R_Q9MDMACH			0x00000900
+#define MTL_RQDCM2R_Q10MDMACH			0x000A0000
+#define MTL_RQDCM2R_Q11MDMACH			0x0B000000
+
+#define MTL_RQDCM0R_Q0DDMACH			0x10
+#define MTL_RQDCM0R_Q1DDMACH			0x00001000
+#define MTL_RQDCM0R_Q2DDMACH			0x00100000
+#define MTL_RQDCM0R_Q3DDMACH			0x10000000
+#define MTL_RQDCM1R_Q4DDMACH			0x00000010
+#define MTL_RQDCM1R_Q5DDMACH			0x00001000
+#define MTL_RQDCM1R_Q6DDMACH			0x00100000
+#define MTL_RQDCM1R_Q7DDMACH			0x10000000
+
+/* MTL traffic class register offsets
+ * Multiple traffic classes can be active.The first class has registers
+ * that begin at 0x1100. Each subsequent queue has registers that
+ * are accessed using an offset of 0x80 from the previous queue.
+ */
+#define MTL_TC_BASE				MTL_Q_BASE
+#define MTL_TC_INC				MTL_Q_INC
+
+#define MTL_TC_TQDR				0x08
+#define MTL_TC_ETSCR				0x10
+#define MTL_TC_ETSSR				0x14
+#define MTL_TC_QWR				0x18
+
+#define MTL_TC_TQDR_TRCSTS_POS			1
+#define MTL_TC_TQDR_TRCSTS_LEN			2
+#define MTL_TC_TQDR_TXQSTS_POS			4
+#define MTL_TC_TQDR_TXQSTS_LEN			1
+
+/* MTL traffic class register entry bit positions and sizes */
+#define MTL_TC_ETSCR_TSA_POS			0
+#define MTL_TC_ETSCR_TSA_LEN			2
+#define MTL_TC_QWR_QW_POS			0
+#define MTL_TC_QWR_QW_LEN			21
+
+/* MTL traffic class register value */
+#define MTL_TSA_SP				0x00
+#define MTL_TSA_ETS				0x02
+
+/* DMA register offsets */
+#define DMA_MR					0x1000
+#define DMA_SBMR				0x1004
+#define DMA_ISR					0x1008
+#define DMA_DSR0				0x100c
+#define DMA_DSR1				0x1010
+#define DMA_DSR2				0x1014
+#define DMA_AXIARCR				0x1020
+#define DMA_AXIAWCR				0x1024
+#define DMA_AXIAWRCR				0x1028
+#define DMA_SAFE_ISR				0x1080
+#define DMA_ECC_IE				0x1084
+#define DMA_ECC_INT_SR				0x1088
+
+/* DMA register entry bit positions and sizes */
+#define DMA_ISR_MACIS_POS			17
+#define DMA_ISR_MACIS_LEN			1
+#define DMA_ISR_MTLIS_POS			16
+#define DMA_ISR_MTLIS_LEN			1
+#define DMA_MR_SWR_POS				0
+#define DMA_MR_SWR_LEN				1
+#define DMA_MR_TXPR_POS				11
+#define DMA_MR_TXPR_LEN				1
+#define DMA_MR_INTM_POS				16
+#define DMA_MR_INTM_LEN				2
+#define DMA_MR_QUREAD_POS			19
+#define DMA_MR_QUREAD_LEN			1
+#define DMA_MR_TNDF_POS				20
+#define DMA_MR_TNDF_LEN				2
+#define DMA_MR_RNDF_POS				22
+#define DMA_MR_RNDF_LEN				2
+
+#define DMA_SBMR_EN_LPI_POS			31
+#define DMA_SBMR_EN_LPI_LEN			1
+#define DMA_SBMR_LPI_XIT_PKT_POS		30
+#define DMA_SBMR_LPI_XIT_PKT_LEN		1
+#define DMA_SBMR_WR_OSR_LMT_POS			24
+#define DMA_SBMR_WR_OSR_LMT_LEN			6
+#define DMA_SBMR_RD_OSR_LMT_POS			16
+#define DMA_SBMR_RD_OSR_LMT_LEN			8
+#define DMA_SBMR_AAL_POS			12
+#define DMA_SBMR_AAL_LEN			1
+#define DMA_SBMR_EAME_POS			11
+#define DMA_SBMR_EAME_LEN			1
+#define DMA_SBMR_AALE_POS			10
+#define DMA_SBMR_AALE_LEN			1
+#define DMA_SBMR_BLEN_4_POS			1
+#define DMA_SBMR_BLEN_4_LEN			1
+#define DMA_SBMR_BLEN_8_POS			2
+#define DMA_SBMR_BLEN_8_LEN			1
+#define DMA_SBMR_BLEN_16_POS			3
+#define DMA_SBMR_BLEN_16_LEN			1
+#define DMA_SBMR_BLEN_32_POS			4
+#define DMA_SBMR_BLEN_32_LEN			1
+#define DMA_SBMR_BLEN_64_POS			5
+#define DMA_SBMR_BLEN_64_LEN			1
+#define DMA_SBMR_BLEN_128_POS			6
+#define DMA_SBMR_BLEN_128_LEN			1
+#define DMA_SBMR_BLEN_256_POS			7
+#define DMA_SBMR_BLEN_256_LEN			1
+#define DMA_SBMR_FB_POS				0
+#define DMA_SBMR_FB_LEN				1
+
+/* DMA register values */
+#define DMA_DSR_RPS_LEN			4
+#define DMA_DSR_TPS_LEN			4
+#define DMA_DSR_Q_LEN			(DMA_DSR_RPS_LEN + DMA_DSR_TPS_LEN)
+#define DMA_DSR0_TPS_START		12
+#define DMA_DSRX_FIRST_QUEUE		3
+#define DMA_DSRX_INC			4
+#define DMA_DSRX_QPR			4
+#define DMA_DSRX_TPS_START		4
+#define DMA_TPS_STOPPED			0x00
+#define DMA_TPS_SUSPENDED		0x06
+
+/* DMA channel register offsets
+ *   Multiple channels can be active. The first channel has registers
+ *   that begin at 0x1100.  Each subsequent channel has registers that
+ *   are accessed using an offset of 0x80 from the previous channel.
+ */
+#define DMA_CH_BASE			0x1100
+#define DMA_CH_INC			0x80
+
+#define DMA_CH_CR			0x00
+#define DMA_CH_TCR			0x04
+#define DMA_CH_RCR			0x08
+#define DMA_CH_TDLR_HI			0x10
+#define DMA_CH_TDLR_LO			0x14
+#define DMA_CH_RDLR_HI			0x18
+#define DMA_CH_RDLR_LO			0x1c
+#define DMA_CH_TDTR_LO			0x20
+#define DMA_CH_RDTR_LO			0x28
+#define DMA_CH_TDRLR			0x2c
+#define DMA_CH_RDRLR			0x30
+#define DMA_CH_IER			0x34
+#define DMA_CH_RIWT			0x38
+#define DMA_CH_CATDR_LO			0x44
+#define DMA_CH_CARDR_LO			0x4c
+#define DMA_CH_CATBR_HI			0x50
+#define DMA_CH_CATBR_LO			0x54
+#define DMA_CH_CARBR_HI			0x58
+#define DMA_CH_CARBR_LO			0x5c
+#define DMA_CH_SR			0x60
+
+/* DMA channel register entry bit positions and sizes */
+#define DMA_CH_CR_PBLX8_POS			16
+#define DMA_CH_CR_PBLX8_LEN			1
+#define DMA_CH_CR_SPH_POS			24
+#define DMA_CH_CR_SPH_LEN			1
+#define DMA_CH_IER_AIE_POS			14
+#define DMA_CH_IER_AIE_LEN			1
+#define DMA_CH_IER_FBEE_POS			12
+#define DMA_CH_IER_FBEE_LEN			1
+#define DMA_CH_IER_NIE_POS			15
+#define DMA_CH_IER_NIE_LEN			1
+#define DMA_CH_IER_RBUE_POS			7
+#define DMA_CH_IER_RBUE_LEN			1
+#define DMA_CH_IER_RIE_POS			6
+#define DMA_CH_IER_RIE_LEN			1
+#define DMA_CH_IER_RSE_POS			8
+#define DMA_CH_IER_RSE_LEN			1
+#define DMA_CH_IER_TBUE_POS			2
+#define DMA_CH_IER_TBUE_LEN			1
+#define DMA_CH_IER_TIE_POS			0
+#define DMA_CH_IER_TIE_LEN			1
+#define DMA_CH_IER_TXSE_POS			1
+#define DMA_CH_IER_TXSE_LEN			1
+#define DMA_CH_RCR_PBL_POS			16
+#define DMA_CH_RCR_PBL_LEN			6
+#define DMA_CH_RCR_RBSZ_POS			1
+#define DMA_CH_RCR_RBSZ_LEN			14
+#define DMA_CH_RCR_SR_POS			0
+#define DMA_CH_RCR_SR_LEN			1
+#define DMA_CH_RIWT_RWT_POS			0
+#define DMA_CH_RIWT_RWT_LEN			8
+#define DMA_CH_SR_FBE_POS			12
+#define DMA_CH_SR_FBE_LEN			1
+#define DMA_CH_SR_RBU_POS			7
+#define DMA_CH_SR_RBU_LEN			1
+#define DMA_CH_SR_RI_POS			6
+#define DMA_CH_SR_RI_LEN			1
+#define DMA_CH_SR_RPS_POS			8
+#define DMA_CH_SR_RPS_LEN			1
+#define DMA_CH_SR_TBU_POS			2
+#define DMA_CH_SR_TBU_LEN			1
+#define DMA_CH_SR_TI_POS			0
+#define DMA_CH_SR_TI_LEN			1
+#define DMA_CH_SR_TPS_POS			1
+#define DMA_CH_SR_TPS_LEN			1
+#define DMA_CH_TCR_OSP_POS			4
+#define DMA_CH_TCR_OSP_LEN			1
+#define DMA_CH_TCR_PBL_POS			16
+#define DMA_CH_TCR_PBL_LEN			6
+#define DMA_CH_TCR_ST_POS			0
+#define DMA_CH_TCR_ST_LEN			1
+#define DMA_CH_TCR_TSE_POS			12
+#define DMA_CH_TCR_TSE_LEN			1
+
+/* DMA channel register values */
+#define DMA_OSP_DISABLE				0x00
+#define DMA_OSP_ENABLE				0x01
+#define DMA_PBL_1				1
+#define DMA_PBL_2				2
+#define DMA_PBL_4				4
+#define DMA_PBL_8				8
+#define DMA_PBL_16				16
+#define DMA_PBL_32				32
+#define DMA_PBL_64				64
+#define DMA_PBL_128				128
+#define DMA_PBL_256				256
+#define DMA_PBL_X8_DISABLE			0x00
+#define DMA_PBL_X8_ENABLE			0x01
+
+/* Descriptor/Packet entry bit positions and sizes */
+#define RX_PACKET_ERRORS_CRC_POS		2
+#define RX_PACKET_ERRORS_CRC_LEN		1
+#define RX_PACKET_ERRORS_FRAME_POS		3
+#define RX_PACKET_ERRORS_FRAME_LEN		1
+#define RX_PACKET_ERRORS_LENGTH_POS		0
+#define RX_PACKET_ERRORS_LENGTH_LEN		1
+#define RX_PACKET_ERRORS_OVERRUN_POS		1
+#define RX_PACKET_ERRORS_OVERRUN_LEN		1
+
+#define RX_PKT_ATTR_CSUM_DONE_POS		0
+#define RX_PKT_ATTR_CSUM_DONE_LEN		1
+#define RX_PKT_ATTR_VLAN_CTAG_POS		1
+#define RX_PKT_ATTR_VLAN_CTAG_LEN		1
+#define RX_PKT_ATTR_INCOMPLETE_POS		2
+#define RX_PKT_ATTR_INCOMPLETE_LEN		1
+#define RX_PKT_ATTR_CONTEXT_NEXT_POS		3
+#define RX_PKT_ATTR_CONTEXT_NEXT_LEN		1
+#define RX_PKT_ATTR_CONTEXT_POS			4
+#define RX_PKT_ATTR_CONTEXT_LEN			1
+#define RX_PKT_ATTR_RX_TSTAMP_POS		5
+#define RX_PKT_ATTR_RX_TSTAMP_LEN		1
+#define RX_PKT_ATTR_RSS_HASH_POS		6
+#define RX_PKT_ATTR_RSS_HASH_LEN		1
+
+#define RX_NORMAL_DESC0_OVT_POS			0
+#define RX_NORMAL_DESC0_OVT_LEN			16
+#define RX_NORMAL_DESC2_HL_POS			0
+#define RX_NORMAL_DESC2_HL_LEN			10
+#define RX_NORMAL_DESC3_CDA_LEN			1
+#define RX_NORMAL_DESC3_CTXT_POS		30
+#define RX_NORMAL_DESC3_CTXT_LEN		1
+#define RX_NORMAL_DESC3_ES_POS			15
+#define RX_NORMAL_DESC3_ES_LEN			1
+#define RX_NORMAL_DESC3_ETLT_POS		16
+#define RX_NORMAL_DESC3_ETLT_LEN		3
+#define RX_NORMAL_DESC3_FD_POS			29
+#define RX_NORMAL_DESC3_FD_LEN			1
+#define RX_NORMAL_DESC3_INTE_POS		30
+#define RX_NORMAL_DESC3_INTE_LEN		1
+#define RX_NORMAL_DESC3_L34T_LEN		4
+#define RX_NORMAL_DESC3_RSV_POS			26
+#define RX_NORMAL_DESC3_RSV_LEN			1
+#define RX_NORMAL_DESC3_LD_POS			28
+#define RX_NORMAL_DESC3_LD_LEN			1
+#define RX_NORMAL_DESC3_OWN_POS			31
+#define RX_NORMAL_DESC3_OWN_LEN			1
+#define RX_NORMAL_DESC3_BUF2V_POS		25
+#define RX_NORMAL_DESC3_BUF2V_LEN		1
+#define RX_NORMAL_DESC3_BUF1V_POS		24
+#define RX_NORMAL_DESC3_BUF1V_LEN		1
+#define RX_NORMAL_DESC3_PL_POS			0
+#define RX_NORMAL_DESC3_PL_LEN			15
+#define RX_NORMAL_DESC0_WB_IVT_POS		16
+/* Inner VLAN Tag. Valid only when Double VLAN tag processing and VLAN tag
+ * stripping are enabled.
+ */
+#define RX_NORMAL_DESC0_WB_IVT_LEN		16
+#define RX_NORMAL_DESC0_WB_OVT_POS		0  /* Outer VLAN Tag. */
+#define RX_NORMAL_DESC0_WB_OVT_LEN		16
+#define RX_NORMAL_DESC0_WB_OVT_VLANID_POS	0  /* Outer VLAN ID. */
+#define RX_NORMAL_DESC0_WB_OVT_VLANID_LEN	12
+#define RX_NORMAL_DESC0_WB_OVT_CFI_POS		12 /* Outer VLAN CFI. */
+#define RX_NORMAL_DESC0_WB_OVT_CFI_LEN		1
+#define RX_NORMAL_DESC0_WB_OVT_PRIO_POS		13 /* Outer VLAN Priority. */
+#define RX_NORMAL_DESC0_WB_OVT_PRIO_LEN		3
+
+#define RX_NORMAL_DESC1_WB_IPCE_POS		7  /* IP Payload Error. */
+#define RX_NORMAL_DESC1_WB_IPCE_LEN		1
+#define RX_NORMAL_DESC1_WB_IPV6_POS		5  /* IPV6 Header Present. */
+#define RX_NORMAL_DESC1_WB_IPV6_LEN		1
+#define RX_NORMAL_DESC1_WB_IPV4_POS		4  /* IPV4 Header Present. */
+#define RX_NORMAL_DESC1_WB_IPV4_LEN		1
+#define RX_NORMAL_DESC1_WB_IPHE_POS		3  /* IP Header Error. */
+#define RX_NORMAL_DESC1_WB_IPHE_LEN		1
+#define RX_NORMAL_DESC1_WB_PT_POS		0
+#define RX_NORMAL_DESC1_WB_PT_LEN		3
+
+#define RX_NORMAL_DESC2_WB_HF_POS		18
+/* Hash Filter Status. When this bit is set, it indicates that the packet
+ * passed the MAC address hash filter
+ */
+#define RX_NORMAL_DESC2_WB_HF_LEN		1
+
+/* Destination Address Filter Fail. When Flexible RX Parser is disabled, and
+ * this bit is set, it indicates that the packet err
+ * the DA Filter in the MAC.
+ */
+#define RX_NORMAL_DESC2_WB_DAF_POS		17
+#define RX_NORMAL_DESC2_WB_DAF_LEN		1
+
+#define RX_NORMAL_DESC2_WB_RAPARSER_POS		11
+#define RX_NORMAL_DESC2_WB_RAPARSER_LEN		3
+
+#define RX_NORMAL_DESC3_WB_LD_POS		28
+#define RX_NORMAL_DESC3_WB_LD_LEN		1
+#define RX_NORMAL_DESC3_WB_RS0V_POS		25
+/* When this bit is set, it indicates that the status in RDES0 is valid and
+ * it is written by the DMA.
+ */
+#define RX_NORMAL_DESC3_WB_RS0V_LEN		1
+
+/* When this bit is set, it indicates that a Cyclic Redundancy Check (CRC)
+ * Error occurred on the received packet.This field is valid only when
+ * the LD bit of RDES3 is set.
+ */
+#define RX_NORMAL_DESC3_WB_CE_POS		24
+#define RX_NORMAL_DESC3_WB_CE_LEN		1
+
+#define RX_DESC3_L34T_IPV4_TCP			1
+#define RX_DESC3_L34T_IPV4_UDP			2
+#define RX_DESC3_L34T_IPV4_ICMP			3
+#define RX_DESC3_L34T_IPV6_TCP			9
+#define RX_DESC3_L34T_IPV6_UDP			10
+#define RX_DESC3_L34T_IPV6_ICMP			11
+
+#define RX_DESC1_PT_UDP				1
+#define RX_DESC1_PT_TCP				2
+#define RX_DESC1_PT_ICMP			3
+#define RX_DESC1_PT_AV_TAG_DATA			6
+#define RX_DESC1_PT_AV_TAG_CTRL			7
+#define RX_DESC1_PT_AV_NOTAG_CTRL		5
+
+#define RX_CONTEXT_DESC3_TSA_LEN		1
+#define RX_CONTEXT_DESC3_TSD_LEN		1
+
+#define TX_PKT_ATTR_CSUM_ENABLE_POS		0
+#define TX_PKT_ATTR_CSUM_ENABLE_LEN		1
+#define TX_PKT_ATTR_TSO_ENABLE_POS		1
+#define TX_PKT_ATTR_TSO_ENABLE_LEN		1
+#define TX_PKT_ATTR_VLAN_CTAG_POS		2
+#define TX_PKT_ATTR_VLAN_CTAG_LEN		1
+#define TX_PKT_ATTR_PTP_POS			3
+#define TX_PKT_ATTR_PTP_LEN			1
+
+#define TX_CONTEXT_DESC2_MSS_POS		0
+#define TX_CONTEXT_DESC2_MSS_LEN		14
+#define TX_CONTEXT_DESC2_IVLTV_POS		16 /* Inner VLAN Tag. */
+#define TX_CONTEXT_DESC2_IVLTV_LEN		16
+
+#define TX_CONTEXT_DESC3_CTXT_POS		30
+#define TX_CONTEXT_DESC3_CTXT_LEN		1
+#define TX_CONTEXT_DESC3_TCMSSV_POS		26
+#define TX_CONTEXT_DESC3_TCMSSV_LEN		1
+#define TX_CONTEXT_DESC3_IVTIR_POS		18
+#define TX_CONTEXT_DESC3_IVTIR_LEN		2
+#define TX_CONTEXT_DESC3_IVTIR_INSERT		2
+
+/* Insert an inner VLAN tag with the tag value programmed in the
+ * MAC_Inner_VLAN_Incl register or context descriptor.
+ */
+/* Indicates that the Inner VLAN TAG, IVLTV field of context TDES2 is valid. */
+#define TX_CONTEXT_DESC3_IVLTV_POS		17
+#define TX_CONTEXT_DESC3_IVLTV_LEN		1
+/* Indicates that the VT field of context TDES3 is valid. */
+#define TX_CONTEXT_DESC3_VLTV_POS		16
+#define TX_CONTEXT_DESC3_VLTV_LEN		1
+#define TX_CONTEXT_DESC3_VT_POS			0
+#define TX_CONTEXT_DESC3_VT_LEN			16
+
+/* Header Length or Buffer 1 Length. */
+#define TX_NORMAL_DESC2_HL_B1L_POS		0
+#define TX_NORMAL_DESC2_HL_B1L_LEN		14
+#define TX_NORMAL_DESC2_IC_POS			31 /* Interrupt on Completion.*/
+#define TX_NORMAL_DESC2_IC_LEN			1
+/* Transmit Timestamp Enable or External TSO Memory Write Enable. */
+#define TX_NORMAL_DESC2_TTSE_POS		30
+#define TX_NORMAL_DESC2_TTSE_LEN		1
+/* LAN Tag Insertion or Replacement. */
+#define TX_NORMAL_DESC2_VTIR_POS		14
+#define TX_NORMAL_DESC2_VTIR_LEN		2
+#define TX_NORMAL_DESC2_VLAN_INSERT		0x2
+
+#define TX_NORMAL_DESC3_TCPPL_POS		0
+#define TX_NORMAL_DESC3_TCPPL_LEN		18
+/* Frame Length or TCP Payload Length. */
+#define TX_NORMAL_DESC3_FL_POS			0
+#define TX_NORMAL_DESC3_FL_LEN			15
+#define TX_NORMAL_DESC3_CIC_POS			16
+
+/* Checksum Insertion Control or TCP Payload Length.
+ * 2'b00: Checksum Insertion Disabled.
+ * 2'b01: Only IP header checksum calculation and insertion are enabled.
+ * 2'b10: IP header checksum and payload checksum calculation and insertion are
+ * enabled, but pseudo-header checksum is not calculated in hardware.
+ * 2'b11: IP Header checksum and payload checksum calculation and insertion are
+ * enabled, and pseudo - header checksum is calculated in hardware.
+ */
+#define TX_NORMAL_DESC3_CIC_LEN			2
+#define TX_NORMAL_DESC3_TSE_POS			18 /* TCP Segmentation Enable.*/
+#define TX_NORMAL_DESC3_TSE_LEN			1
+#define TX_NORMAL_DESC3_TCPHDRLEN_POS		19
+
+/* THL: TCP/UDP Header Length.If the TSE bit is set, this field contains
+ * the length of the TCP / UDP header.The minimum value of this field must
+ * be 5 for TCP header.The value must be equal to 2 for UDP header. This
+ * field is valid only for the first descriptor.
+ */
+#define TX_NORMAL_DESC3_TCPHDRLEN_LEN		4
+#define TX_NORMAL_DESC3_CPC_POS			26 /* CRC Pad Control. */
+#define TX_NORMAL_DESC3_CPC_LEN			2
+#define TX_NORMAL_DESC3_LD_POS			28 /* Last Descriptor. */
+#define TX_NORMAL_DESC3_LD_LEN			1
+#define TX_NORMAL_DESC3_FD_POS			29 /* First Descriptor. */
+#define TX_NORMAL_DESC3_FD_LEN			1
+/* Context Type.This bit should be set to 1'b0 for normal descriptor. */
+#define TX_NORMAL_DESC3_CTXT_POS		30
+#define TX_NORMAL_DESC3_CTXT_LEN		1
+#define TX_NORMAL_DESC3_OWN_POS			31 /* Own Bit. */
+#define TX_NORMAL_DESC3_OWN_LEN			1
+
+/* for phy generic register definitions */
+#define FXGMAC_PHY_REG_CNT		32
+
+#define PHY_SPEC_CTRL			0x10  /* PHY specific func control */
+#define PHY_SPEC_STATUS			0x11  /* PHY specific status */
+#define PHY_INT_MASK			0x12  /* Interrupt mask register */
+#define PHY_INT_STATUS			0x13  /* Interrupt status register */
+#define PHY_DBG_ADDR			0x1e  /* Extended reg's address*/
+#define PHY_DBG_DATA			0x1f  /* Extended reg's date */
+
+#define PHY_SPEC_CTRL_CRS_ON		0x0008 /* PHY specific func control */
+
+/* PHY specific status */
+#define PHY_SPEC_STATUS_DUPLEX		0x2000
+#define PHY_SPEC_STATUS_LINK		0x0400
+
+/* Interrupt mask register */
+#define PHY_INT_MASK_LINK_UP		0x0400
+#define PHY_INT_MASK_LINK_DOWN		0x0800
+
+#define PHY_EXT_SLEEP_CONTROL1			0x27
+#define PHY_EXT_ANALOG_CFG2			0x51
+#define PHY_EXT_ANALOG_CFG3			0x52
+#define PHY_EXT_ANALOG_CFG8			0x57
+#define PHY_EXT_COMMON_LED_CFG			0xa00b
+#define PHY_EXT_COMMON_LED0_CFG			0xa00c
+#define PHY_EXT_COMMON_LED1_CFG			0xa00d
+#define PHY_EXT_COMMON_LED2_CFG			0xa00e
+#define PHY_EXT_COMMON_LED_BLINK_CFG		0xa00f
+
+#define PHY_EXT_SLEEP_CONTROL1_PLLON_IN_SLP	0x4000
+
+#define PHY_EXT_ANALOG_CFG2_VAL			0x4a9
+
+#define PHY_EXT_ANALOG_CFG3_ADC_START_CFG	GENMASK(15, 14)
+
+#define PHY_EXT_ANALOG_CFG8_VAL			0x274c
+
+#define FXGMAC_ADVERTISE_1000_CAP (ADVERTISE_1000FULL | ADVERTISE_1000HALF)
+#define FXGMAC_ADVERTISE_100_10_CAP                                            \
+	(ADVERTISE_100FULL | ADVERTISE_100HALF | ADVERTISE_10FULL | \
+	 ADVERTISE_10HALF)
+
+#define FXGMAC_GET_BITS(var, pos, len)                                         \
+	({                                                                     \
+		typeof(pos) _pos = (pos);                                      \
+		typeof(len) _len = (len);                                      \
+		((var) & GENMASK(_pos + _len - 1, _pos)) >> (_pos);            \
+	})
+
+#define FXGMAC_GET_BITS_LE(var, pos, len)                                      \
+	({                                                                     \
+		typeof(pos) _pos = (pos);                                      \
+		typeof(len) _len = (len);                                      \
+		typeof(var) _var = le32_to_cpu((var));                         \
+		((_var) & GENMASK(_pos + _len - 1, _pos)) >> (_pos);           \
+	})
+
+#define __FXGMAC_SET_BITS(var, pos, len, val)                                  \
+	({                                                                     \
+		typeof(var) _var = (var);                                      \
+		typeof(pos) _pos = (pos);                                      \
+		typeof(len) _len = (len);                                      \
+		typeof(val) _val = (val);                                      \
+		_val = (_val << _pos) & GENMASK(_pos + _len - 1, _pos);        \
+		_var = (_var & ~GENMASK(_pos + _len - 1, _pos)) | _val;        \
+	})
+
+static inline void fxgmac_set_bits(u32 *val, u32 pos, u32 len, u32 set_val)
+{
+	*(val) = __FXGMAC_SET_BITS(*(val), pos, len, set_val);
+}
+
+#define FXGMAC_SET_BITS_LE(var, pos, len, val)                               \
+	({                                                                     \
+		typeof(var) _var = (var);                                      \
+		typeof(pos) _pos = (pos);                                      \
+		typeof(len) _len = (len);                                      \
+		typeof(val) _val = (val);                                      \
+		_val = (_val << _pos) & GENMASK(_pos + _len - 1, _pos);        \
+		_var = (_var & ~GENMASK(_pos + _len - 1, _pos)) | _val;        \
+		cpu_to_le32(_var);                                             \
+	})
+
+#define FXGMAC_MTL_REG(pdata, n, reg)                                          \
+	((pdata)->hw_addr + MAC_OFFSET + MTL_Q_BASE + ((n) * MTL_Q_INC) + (reg))
+
+#define FXGMAC_DMA_REG(channel, reg) ((channel)->dma_regs + (reg))
+
+#define rd32_mac(pdata, addr) (readl((pdata)->hw_addr + MAC_OFFSET + (addr)))
+#define wr32_mac(pdata, val, addr)                                             \
+	(writel(val, (pdata)->hw_addr + MAC_OFFSET + (addr)))
+
+#define rd32_mem(pdata, addr) (readl((pdata)->hw_addr + (addr)))
+#define wr32_mem(pdata, val, addr) (writel(val, (pdata)->hw_addr + (addr)))
+
+#define yt_err(yt, fmt, arg...)		dev_err((yt)->dev, fmt, ##arg)
+#define yt_dbg(yt, fmt, arg...)		dev_dbg((yt)->dev, fmt, ##arg)
+
+#pragma pack(1)
+/* it's better to make this struct's size to 128byte. */
+struct pattern_packet {
+	u8 ether_daddr[ETH_ALEN];
+	u8 ether_saddr[ETH_ALEN];
+	u16 ether_type;
+
+	__be16 ar_hrd;		/* format of hardware address  */
+	__be16 ar_pro;		/* format of protocol          */
+	u8 ar_hln;		/* length of hardware address  */
+	u8 ar_pln;		/* length of protocol address  */
+	__be16 ar_op;		/* ARP opcode (command)        */
+	u8 ar_sha[ETH_ALEN];	/* sender hardware address     */
+	u8 ar_sip[4];		/* sender IP address           */
+	u8 ar_tha[ETH_ALEN];	/* target hardware address     */
+	u8 ar_tip[4];		/* target IP address           */
+
+	u8 reverse[86];
+};
+
+#pragma pack()
+
+#endif /* _YT6801_TYPE_H_ */
-- 
2.34.1


