Return-Path: <netdev+bounces-146564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E57A9D4592
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 02:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EFCFB22756
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 01:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA8154727;
	Thu, 21 Nov 2024 01:53:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-219.mail.aliyun.com (out28-219.mail.aliyun.com [115.124.28.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C3B4500E;
	Thu, 21 Nov 2024 01:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732153994; cv=none; b=sIVqXF++wU9Fn7I4wefW39z5/AZbPbB6SD0QGvvZnuR1AGpBFl+lJ6SlnLSlT+Ww+0R5YRL71OA+M8WjLa+ztXKutq17tAnC7vB6oH6UOGA+NosgxHohtBL3dZ/XTpHloYTOiQFAQGAes5hxK3OARNWsIA2mVu4FVawJGi1cBA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732153994; c=relaxed/simple;
	bh=fK72vnLNdTS+gDJ3hky6FhZGvPQ3Ti7TpizZUi5tAxc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qQJejj3NOmjIQolZMgbvdU87i5iOn711WQ0iTCfM4UZqDiRZkqqoIMwjVPZRBGNkEmZDT3D+1WtTbEbd9t5H+WtP762Xw+gS2QtUAFDEYS/59pwbXunV+Jml7wO/9SJChuwNo2HD4o64KfPNBlbtS7DWfZCe5G7oShBWqMSfc5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from sun-VirtualBox..(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.aGmppUb_1732100199 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 20 Nov 2024 18:56:40 +0800
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
Subject: [PATCH net-next v2 02/21] motorcomm:yt6801: Implement pci_driver shutdown
Date: Thu, 21 Nov 2024 09:53:06 +0800
Message-Id: <20241120105625.22508-3-Frank.Sae@motor-comm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241120105625.22508-1-Frank.Sae@motor-comm.com>
References: <20241120105625.22508-1-Frank.Sae@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the pci_driver shutdown function to shutdown this driver.

Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>
---
 .../net/ethernet/motorcomm/yt6801/yt6801.h    | 617 ++++++++++++++++++
 .../ethernet/motorcomm/yt6801/yt6801_desc.c   |  49 ++
 .../ethernet/motorcomm/yt6801/yt6801_desc.h   |  39 ++
 .../ethernet/motorcomm/yt6801/yt6801_net.c    | 251 +++++++
 .../ethernet/motorcomm/yt6801/yt6801_net.h    |  32 +
 .../ethernet/motorcomm/yt6801/yt6801_pci.c    |  26 +
 6 files changed, 1014 insertions(+)
 create mode 100644 drivers/net/ethernet/motorcomm/yt6801/yt6801.h
 create mode 100644 drivers/net/ethernet/motorcomm/yt6801/yt6801_desc.c
 create mode 100644 drivers/net/ethernet/motorcomm/yt6801/yt6801_desc.h
 create mode 100644 drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
 create mode 100644 drivers/net/ethernet/motorcomm/yt6801/yt6801_net.h

diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801.h b/drivers/net/ethernet/motorcomm/yt6801/yt6801.h
new file mode 100644
index 000000000..d06457f57
--- /dev/null
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801.h
@@ -0,0 +1,617 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Copyright (c) 2022 - 2024 Motorcomm Electronic Technology Co.,Ltd. */
+
+#ifndef YT6801_H
+#define YT6801_H
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
+/* WOL pattern settings */
+#define MAX_PATTERN_SIZE		128	/* pattern length */
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
+enum _wake_reason {
+	WAKE_REASON_NONE = 0,
+	WAKE_REASON_MAGIC,
+	WAKE_REASON_PATTERNMATCH,
+	WAKE_REASON_LINK,
+	WAKE_REASON_TCPSYNV4,
+	WAKE_REASON_TCPSYNV6,
+	/* For wake up method like Link-change, GMAC cannot
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
+	u32 dma_reg_offset;
+	struct fxgmac_ring *tx_ring;
+	struct fxgmac_ring *rx_ring;
+} ____cacheline_aligned;
+
+struct fxgmac_hw_ops {
+	void (*pcie_init)(struct fxgmac_pdata *pdata);
+	int (*init)(struct fxgmac_pdata *pdata);
+	void (*exit)(struct fxgmac_pdata *pdata);
+	void (*save_nonstick_reg)(struct fxgmac_pdata *pdata);
+	void (*restore_nonstick_reg)(struct fxgmac_pdata *pdata);
+
+	void (*enable_tx)(struct fxgmac_pdata *pdata);
+	void (*disable_tx)(struct fxgmac_pdata *pdata);
+	void (*enable_rx)(struct fxgmac_pdata *pdata);
+	void (*disable_rx)(struct fxgmac_pdata *pdata);
+	int (*dev_read)(struct fxgmac_channel *channel);
+	void (*dev_xmit)(struct fxgmac_channel *channel);
+
+	void (*enable_channel_irq)(struct fxgmac_channel *channel,
+				   enum fxgmac_int int_id);
+	void (*disable_channel_irq)(struct fxgmac_channel *channel,
+				    enum fxgmac_int int_id);
+	void (*set_interrupt_moderation)(struct fxgmac_pdata *pdata);
+	void (*enable_msix_one_irq)(struct fxgmac_pdata *pdata, u32 intid);
+	void (*disable_msix_one_irq)(struct fxgmac_pdata *pdata, u32 intid);
+	void (*enable_mgm_irq)(struct fxgmac_pdata *pdata);
+	void (*disable_mgm_irq)(struct fxgmac_pdata *pdata);
+
+	void (*dismiss_all_int)(struct fxgmac_pdata *pdata);
+	void (*clear_misc_int_status)(struct fxgmac_pdata *pdata);
+
+	void (*set_mac_address)(struct fxgmac_pdata *pdata, u8 *addr);
+	void (*set_mac_hash)(struct fxgmac_pdata *pdata);
+	void (*config_rx_mode)(struct fxgmac_pdata *pdata);
+	void (*enable_rx_csum)(struct fxgmac_pdata *pdata);
+	void (*disable_rx_csum)(struct fxgmac_pdata *pdata);
+	void (*config_tso)(struct fxgmac_pdata *pdata);
+	u32 (*calculate_max_checksum_size)(struct fxgmac_pdata *pdata);
+	void (*config_mac_speed)(struct fxgmac_pdata *pdata);
+
+	/* PHY Control */
+	void (*reset_phy)(struct fxgmac_pdata *pdata);
+	void (*release_phy)(struct fxgmac_pdata *pdata);
+	int (*write_phy_reg)(struct fxgmac_pdata *pdata, u32 val, u32 data);
+	int (*read_phy_reg)(struct fxgmac_pdata *pdata, u32 val);
+
+	/* Vlan related config */
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
+	void (*read_mmc_stats)(struct fxgmac_pdata *pdata);
+
+	/* Receive Side Scaling */
+	void (*enable_rss)(struct fxgmac_pdata *pdata);
+	void (*disable_rss)(struct fxgmac_pdata *pdata);
+	u32 (*get_rss_options)(struct fxgmac_pdata *pdata);
+	void (*set_rss_options)(struct fxgmac_pdata *pdata);
+	void (*set_rss_hash_key)(struct fxgmac_pdata *pdata, const u8 *key);
+	void (*write_rss_lookup_table)(struct fxgmac_pdata *pdata);
+
+	/* Wake */
+	void (*enable_wake_pattern)(struct fxgmac_pdata *pdata);
+	void (*disable_wake_pattern)(struct fxgmac_pdata *pdata);
+	void (*disable_arp_offload)(struct fxgmac_pdata *pdata);
+	void (*disable_wake_magic_pattern)(struct fxgmac_pdata *pdata);
+	int (*set_wake_pattern)(struct fxgmac_pdata *pdata,
+				struct wol_bitmap_pattern *wol_pattern,
+				u32 pattern_cnt);
+	void (*enable_wake_magic_pattern)(struct fxgmac_pdata *pdata);
+	void (*enable_wake_link_change)(struct fxgmac_pdata *pdata);
+	void (*disable_wake_link_change)(struct fxgmac_pdata *pdata);
+
+	/* Power management */
+	int (*pre_power_down)(struct fxgmac_pdata *pdata);
+	void (*config_power_down)(struct fxgmac_pdata *pdata, bool wake_en);
+	void (*config_power_up)(struct fxgmac_pdata *pdata);
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
+	FXGMAC_TASK_FLAG_LINK_CHG,
+	FXGMAC_TASK_FLAG_MAX
+};
+
+struct fxgmac_pdata {
+	struct net_device *netdev;
+	struct device *dev;
+	struct phy_device *phydev;
+
+	struct fxgmac_hw_features hw_feat;	/* Hardware features */
+	struct fxgmac_hw_ops hw_ops;
+	void __iomem *hw_addr;			/* Registers base */
+	struct fxgmac_stats stats;		/* Device statistics */
+
+	/* Rings for Tx/Rx on a DMA channel */
+	struct fxgmac_channel *channel_head;
+	unsigned int channel_count;
+	unsigned int rx_ring_count;
+	unsigned int rx_desc_count;
+	unsigned int rx_q_count;
+#define FXGMAC_TX_1_RING	1
+#define FXGMAC_TX_1_Q	1
+	unsigned int tx_desc_count;
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
+	bool phy_link;
+
+	u32 msg_enable;
+	u32 reg_nonstick[(MSI_PBA - GLOBAL_CTRL0) >> 2];
+
+	u32 wol;
+	struct wol_bitmap_pattern pattern[MAX_PATTERN_COUNT];
+
+	struct work_struct restart_work;
+	DECLARE_BITMAP(task_flags, FXGMAC_TASK_FLAG_MAX);
+
+	enum fxgmac_dev_state dev_state;
+#define FXGMAC_POWER_STATE_DOWN			0
+#define FXGMAC_POWER_STATE_UP			1
+	unsigned long powerstate;
+	struct mutex mutex; /* Driver lock */
+
+	char drv_name[32];
+	char drv_ver[32];
+};
+
+void fxgmac_hw_ops_init(struct fxgmac_hw_ops *hw_ops);
+int fxgmac_phy_irq_enable(struct fxgmac_pdata *pdata, bool clear_phy_interrupt);
+const struct ethtool_ops *fxgmac_get_ethtool_ops(void);
+
+#endif /* YT6801_H */
diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_desc.c b/drivers/net/ethernet/motorcomm/yt6801/yt6801_desc.c
new file mode 100644
index 000000000..476cf6633
--- /dev/null
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_desc.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (c) 2022 - 2024 Motorcomm Electronic Technology Co.,Ltd. */
+
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
diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_desc.h b/drivers/net/ethernet/motorcomm/yt6801/yt6801_desc.h
new file mode 100644
index 000000000..24e3d9b85
--- /dev/null
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_desc.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Copyright (c) 2022 - 2024 Motorcomm Electronic Technology Co.,Ltd. */
+
+#ifndef YT6801_DESC_H
+#define YT6801_DESC_H
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
+void fxgmac_desc_tx_reset(struct fxgmac_desc_data *desc_data);
+void fxgmac_desc_rx_reset(struct fxgmac_desc_data *desc_data);
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
+int fxgmac_is_tx_complete(struct fxgmac_dma_desc *dma_desc);
+int fxgmac_is_last_desc(struct fxgmac_dma_desc *dma_desc);
+
+#endif /* YT6801_DESC_H */
diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c b/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
new file mode 100644
index 000000000..925bc1e7d
--- /dev/null
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
@@ -0,0 +1,251 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (c) 2022 - 2024 Motorcomm Electronic Technology Co.,Ltd. */
+
+#include <linux/inetdevice.h>
+#include <linux/netdevice.h>
+#include <linux/interrupt.h>
+#include <net/addrconf.h>
+#include <linux/inet.h>
+#include <linux/tcp.h>
+
+#include "yt6801_desc.h"
+#include "yt6801_net.h"
+
+#define FXGMAC_NAPI_ENABLE			0x1
+#define FXGMAC_NAPI_DISABLE			0x0
+static void fxgmac_napi_disable(struct fxgmac_pdata *pdata)
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
+		netif_napi_del(&pdata->napi);
+		fxgmac_set_bits(flags, FXGMAC_FLAG_LEGACY_NAPI_POS,
+				FXGMAC_FLAG_LEGACY_NAPI_LEN,
+				FXGMAC_NAPI_DISABLE);
+		return;
+	}
+
+	channel = pdata->channel_head;
+	for (i = 0; i < pdata->channel_count; i++, channel++) {
+		if (FXGMAC_GET_BITS(rx, i, FXGMAC_FLAG_PER_RX_NAPI_LEN)) {
+			napi_disable(&channel->napi_rx);
+			netif_napi_del(&channel->napi_rx);
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
+			       "napi_disable, msix ch%d, napi disabled done. ",
+			       i);
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
+	for (u32 i = 0; i < pdata->channel_count; i++, channel++) {
+		ring = channel->tx_ring;
+		if (!ring)
+			break;
+
+		for (u32 j = 0; j < ring->dma_desc_count; j++) {
+			desc_data = FXGMAC_GET_DESC_DATA(ring, j);
+			fxgmac_desc_data_unmap(pdata, desc_data);
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
+	for (u32 i = 0; i < pdata->channel_count; i++, channel++) {
+		ring = channel->rx_ring;
+		if (!ring)
+			break;
+
+		for (u32 j = 0; j < ring->dma_desc_count; j++) {
+			desc_data = FXGMAC_GET_DESC_DATA(ring, j);
+			fxgmac_desc_data_unmap(pdata, desc_data);
+		}
+	}
+}
+
+static void fxgmac_disable_msix_irqs(struct fxgmac_pdata *pdata)
+{
+	struct fxgmac_hw_ops *hw_ops = &pdata->hw_ops;
+
+	for (u32 intid = 0; intid < MSIX_TBL_MAX_NUM; intid++)
+		hw_ops->disable_msix_one_irq(pdata, intid);
+}
+
+void fxgmac_stop(struct fxgmac_pdata *pdata)
+{
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
+		fxgmac_disable_msix_irqs(pdata);
+	else
+		hw_ops->disable_mgm_irq(pdata);
+
+	pdata->phy_link = false;
+	netif_carrier_off(netdev);
+	netif_tx_stop_all_queues(netdev);
+	hw_ops->disable_tx(pdata);
+	hw_ops->disable_rx(pdata);
+	fxgmac_free_irqs(pdata);
+	fxgmac_napi_disable(pdata);
+	phy_stop(pdata->phydev);
+
+	txq = netdev_get_tx_queue(netdev, pdata->channel_head->queue_index);
+	netdev_tx_reset_queue(txq);
+}
+
+int fxgmac_net_powerdown(struct fxgmac_pdata *pdata, bool wake_en)
+{
+	struct fxgmac_hw_ops *hw_ops = &pdata->hw_ops;
+	struct net_device *netdev = pdata->netdev;
+	int ret;
+
+	/* Signal that we are down to the interrupt handler */
+	if (__test_and_set_bit(FXGMAC_POWER_STATE_DOWN, &pdata->powerstate))
+		return 0; /* do nothing if already down */
+
+	if (netif_msg_drv(pdata))
+		yt_dbg(pdata, "%s, continue with down process.\n", __func__);
+
+	__clear_bit(FXGMAC_POWER_STATE_UP, &pdata->powerstate);
+	netif_tx_stop_all_queues(netdev); /* Shut off incoming Tx traffic */
+
+	/* Call carrier off first to avoid false dev_watchdog timeouts */
+	netif_carrier_off(netdev);
+	netif_tx_disable(netdev);
+	hw_ops->disable_rx(pdata); /* Disable Rx */
+
+	/* Synchronize_rcu() needed for pending XDP buffers to drain */
+	synchronize_rcu();
+
+	fxgmac_stop(pdata);
+	ret = hw_ops->pre_power_down(pdata);
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
+	/* Set mac to lowpower mode and enable wol accordingly */
+	hw_ops->disable_tx(pdata);
+	hw_ops->disable_rx(pdata);
+	fxgmac_config_wol(pdata, wake_en);
+	hw_ops->config_power_down(pdata, wake_en);
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
diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.h b/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.h
new file mode 100644
index 000000000..adcad045b
--- /dev/null
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Copyright (c) 2022 - 2024 Motorcomm Electronic Technology Co.,Ltd. */
+
+#ifndef YT6801_NET_H
+#define YT6801_NET_H
+
+#include "yt6801.h"
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
+int fxgmac_config_wol(struct fxgmac_pdata *pdata, bool en);
+int fxgmac_net_powerup(struct fxgmac_pdata *pdata);
+int fxgmac_net_powerdown(struct fxgmac_pdata *pdata, bool wake_en);
+int fxgmac_drv_probe(struct device *dev, struct fxgmac_resources *res);
+
+#endif /* YT6801_NET_H */
diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_pci.c b/drivers/net/ethernet/motorcomm/yt6801/yt6801_pci.c
index c93698586..b2cd75b5c 100644
--- a/drivers/net/ethernet/motorcomm/yt6801/yt6801_pci.c
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_pci.c
@@ -8,6 +8,8 @@
 #include <linux/pci.h>
 #endif
 
+#include "yt6801_net.h"
+
 static int fxgmac_probe(struct pci_dev *pcidev, const struct pci_device_id *id)
 {
 	struct device *dev = &pcidev->dev;
@@ -79,6 +81,29 @@ static int __fxgmac_shutdown(struct pci_dev *pcidev, bool *wake_en)
 	return 0;
 }
 
+static void fxgmac_shutdown(struct pci_dev *pcidev)
+{
+	struct fxgmac_pdata *pdata = dev_get_drvdata(&pcidev->dev);
+	struct device *dev = &pcidev->dev;
+	bool wake;
+	int ret;
+
+	mutex_lock(&pdata->mutex);
+	ret = __fxgmac_shutdown(pcidev, &wake);
+	if (ret < 0)
+		goto unlock;
+
+	if (system_state == SYSTEM_POWER_OFF) {
+		pci_wake_from_d3(pcidev, wake);
+		pci_set_power_state(pcidev, PCI_D3hot);
+	}
+unlock:
+	mutex_unlock(&pdata->mutex);
+
+	dev_dbg(dev, "%s, system power off=%d\n", __func__,
+		(system_state == SYSTEM_POWER_OFF) ? 1 : 0);
+}
+
 #define MOTORCOMM_PCI_ID			0x1f0a
 #define YT6801_PCI_DEVICE_ID			0x6801
 
@@ -94,6 +119,7 @@ static struct pci_driver fxgmac_pci_driver = {
 	.id_table	= fxgmac_pci_tbl,
 	.probe		= fxgmac_probe,
 	.remove		= fxgmac_remove,
+	.shutdown	= fxgmac_shutdown,
 };
 
 module_pci_driver(fxgmac_pci_driver);
-- 
2.34.1


