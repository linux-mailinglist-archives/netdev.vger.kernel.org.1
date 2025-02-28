Return-Path: <netdev+bounces-170629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 584C5A49668
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 11:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C29716C14A
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 10:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FAE264A76;
	Fri, 28 Feb 2025 10:01:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out198-13.us.a.mail.aliyun.com (out198-13.us.a.mail.aliyun.com [47.90.198.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB9625CC7B;
	Fri, 28 Feb 2025 10:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740736881; cv=none; b=DCYtchYxU/Jtf+qiviP5dH4UmTLn+dGZ1uQQ2Db81dW8Mxq9QAVO9Oyd9Vl8H/koxKeh+tMxu3/uxEYoow4PO/1GxSknLlT3NpgTxrlOBAYIuuUfILLR8F2hxSUaAEa17lb82YJsL/8mIaSO8JBDPX+d36kH8T9alaQ58SfyzHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740736881; c=relaxed/simple;
	bh=P2lD1ssKbjNws6IUxKfowyJUmaSdJ8LXH5cXeIXt+Gg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bgjs9Sn/Ykigc/0a/Rmhv8PzGL19dsEAkyG9rMwFrQ21AmXx7M872PiD4/yA7NCoU/tOAFnefGy8dvM9ZI9hzK8+ba/1WPKhLnPnj7yeDQHKDOeY8o2sULj0zO9KFSrTWeBmo4XBmOueyqw7JJnqHZyT69y1X19rUZOl0LOLtUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=47.90.198.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from sun-VirtualBox..(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.bfyn18w_1740736831 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 28 Feb 2025 18:00:32 +0800
From: Frank Sae <Frank.Sae@motor-comm.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Frank <Frank.Sae@motor-comm.com>,
	netdev@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Parthiban.Veerasooran@microchip.com,
	linux-kernel@vger.kernel.org,
	xiaogang.fan@motor-comm.com,
	fei.zhang@motor-comm.com,
	hua.sun@motor-comm.com
Subject: [PATCH net-next v3 01/14] motorcomm:yt6801: Implement mdio register
Date: Fri, 28 Feb 2025 18:01:04 +0800
Message-Id: <20250228100020.3944-2-Frank.Sae@motor-comm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250228100020.3944-1-Frank.Sae@motor-comm.com>
References: <20250228100020.3944-1-Frank.Sae@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the mdio bus read, write and register function.

Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>
---
 .../net/ethernet/motorcomm/yt6801/yt6801.h    | 379 +++++++
 .../ethernet/motorcomm/yt6801/yt6801_net.c    |  99 ++
 .../ethernet/motorcomm/yt6801/yt6801_type.h   | 967 ++++++++++++++++++
 3 files changed, 1445 insertions(+)
 create mode 100644 drivers/net/ethernet/motorcomm/yt6801/yt6801.h
 create mode 100644 drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
 create mode 100644 drivers/net/ethernet/motorcomm/yt6801/yt6801_type.h

diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801.h b/drivers/net/ethernet/motorcomm/yt6801/yt6801.h
new file mode 100644
index 000000000..eeefd1e12
--- /dev/null
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801.h
@@ -0,0 +1,379 @@
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
+#define FXGMAC_DRV_NAME		"yt6801"
+#define FXGMAC_DRV_DESC		"Motorcomm Gigabit Ethernet Driver"
+
+#define FXGMAC_RX_BUF_ALIGN	64
+#define FXGMAC_TX_MAX_BUF_SIZE	(0x3fff & ~(FXGMAC_RX_BUF_ALIGN - 1))
+#define FXGMAC_RX_MIN_BUF_SIZE	(ETH_FRAME_LEN + ETH_FCS_LEN + VLAN_HLEN)
+
+/* Descriptors required for maximum contiguous TSO/GSO packet */
+#define FXGMAC_TX_MAX_SPLIT	((GSO_MAX_SIZE / FXGMAC_TX_MAX_BUF_SIZE) + 1)
+
+/* Maximum possible descriptors needed for a SKB */
+#define FXGMAC_TX_MAX_DESC_NR	(MAX_SKB_FRAGS + FXGMAC_TX_MAX_SPLIT + 2)
+
+#define FXGMAC_DMA_STOP_TIMEOUT		5
+#define FXGMAC_JUMBO_PACKET_MTU		9014
+#define FXGMAC_MAX_DMA_RX_CHANNELS	4
+#define FXGMAC_MAX_DMA_TX_CHANNELS	1
+#define FXGMAC_MAX_DMA_CHANNELS                                           \
+	(FXGMAC_MAX_DMA_RX_CHANNELS + FXGMAC_MAX_DMA_TX_CHANNELS)
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
+struct fxgmac_tx_desc_data {
+	unsigned int packets;		/* BQL packet count */
+	unsigned int bytes;		/* BQL byte count */
+};
+
+struct fxgmac_rx_desc_data {
+	struct fxgmac_buffer_data hdr;	/* Header locations */
+	struct fxgmac_buffer_data buf;	/* Payload locations */
+	unsigned short hdr_len;		/* Length of received header */
+	unsigned short len;		/* Length of received packet */
+};
+
+struct fxgmac_pkt_info {
+	struct sk_buff *skb;
+#define ATTR_TX_CSUM_ENABLE_POS		0
+#define ATTR_TX_CSUM_ENABLE_LEN		1
+#define ATTR_TX_TSO_ENABLE_POS		1
+#define ATTR_TX_TSO_ENABLE_LEN		1
+#define ATTR_TX_VLAN_CTAG_POS		2
+#define ATTR_TX_VLAN_CTAG_LEN		1
+#define ATTR_TX_PTP_POS			3
+#define ATTR_TX_PTP_LEN			1
+#define ATTR_RX_CSUM_DONE_POS		0
+#define ATTR_RX_CSUM_DONE_LEN		1
+#define ATTR_RX_VLAN_CTAG_POS		1
+#define ATTR_RX_VLAN_CTAG_LEN		1
+#define ATTR_RX_INCOMPLETE_POS		2
+#define ATTR_RX_INCOMPLETE_LEN		1
+#define ATTR_RX_CONTEXT_NEXT_POS	3
+#define ATTR_RX_CONTEXT_NEXT_LEN	1
+#define ATTR_RX_CONTEXT_POS		4
+#define ATTR_RX_CONTEXT_LEN		1
+#define ATTR_RX_RX_TSTAMP_POS		5
+#define ATTR_RX_RX_TSTAMP_LEN		1
+#define ATTR_RX_RSS_HASH_POS		6
+#define ATTR_RX_RSS_HASH_LEN		1
+	unsigned int attr;
+#define ERRORS_RX_CRC_POS		2
+#define ERRORS_RX_CRC_LEN		1
+#define ERRORS_RX_FRAME_POS		3
+#define ERRORS_RX_FRAME_LEN		1
+#define ERRORS_RX_LENGTH_POS		0
+#define ERRORS_RX_LENGTH_LEN		1
+#define ERRORS_RX_OVERRUN_POS		1
+#define ERRORS_RX_OVERRUN_LEN		1
+	unsigned int errors;
+	unsigned int desc_count; /* descriptors needed for this packet */
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
+	struct fxgmac_pkt_info pkt_info;  /* packet related information */
+
+	/* Virtual/DMA addresses of DMA descriptor list */
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
+	 * cur  - Tx: index of descriptor to be used for current transfer
+	 *        Rx: index of descriptor to check for packet availability
+	 * dirty - Tx: index of descriptor to check for transfer complete
+	 *         Rx: index of descriptor to check for buffer reallocation
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
+	struct fxgmac_pdata *priv;
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
+	void __iomem *dma_regs;
+	struct fxgmac_ring *tx_ring;
+	struct fxgmac_ring *rx_ring;
+} ____cacheline_aligned;
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
+struct fxgmac_pdata {
+	struct net_device *netdev;
+	struct device *dev;
+	struct phy_device *phydev;
+
+	struct fxgmac_hw_features hw_feat;	/* Hardware features */
+	void __iomem *hw_addr;			/* Registers base */
+
+	/* Rings for Tx/Rx on a DMA channel */
+	struct fxgmac_channel *channel_head;
+	unsigned int channel_count;
+	unsigned int rx_ring_count;
+	unsigned int rx_desc_count;
+	unsigned int rx_q_count;
+#define FXGMAC_TX_1_RING	1
+#define FXGMAC_TX_1_Q		1
+	unsigned int tx_desc_count;
+
+	unsigned long sysclk_rate;		/* Device clocks */
+	unsigned int pblx8;			/* Tx/Rx common settings */
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
+	/* Flow control settings */
+	unsigned int tx_pause;
+	unsigned int rx_pause;
+
+	unsigned int mtu;
+	unsigned int rx_buf_size;	/* Current Rx buffer size */
+
+	/* Device interrupt */
+	int dev_irq;
+	unsigned int per_channel_irq;
+	u32 channel_irq[FXGMAC_MAX_DMA_CHANNELS];
+	struct msix_entry *msix_entries;
+#define INT_FLAG_INTERRUPT_POS		0
+#define INT_FLAG_INTERRUPT_LEN		5
+#define INT_FLAG_MSI_POS		1
+#define INT_FLAG_MSI_LEN		1
+#define INT_FLAG_MSIX_POS		3
+#define INT_FLAG_MSIX_LEN		1
+#define INT_FLAG_LEGACY_POS		4
+#define INT_FLAG_LEGACY_LEN		1
+#define INT_FLAG_RX_NAPI_POS		18
+#define INT_FLAG_RX_NAPI_LEN		4
+#define INT_FLAG_PER_RX_NAPI_LEN	1
+#define INT_FLAG_RX_IRQ_POS		22
+#define INT_FLAG_RX_IRQ_LEN		4
+#define INT_FLAG_PER_RX_IRQ_LEN		1
+#define INT_FLAG_TX_NAPI_POS		26
+#define INT_FLAG_TX_NAPI_LEN		1
+#define INT_FLAG_TX_IRQ_POS		27
+#define INT_FLAG_TX_IRQ_LEN		1
+#define INT_FLAG_LEGACY_NAPI_POS	30
+#define INT_FLAG_LEGACY_NAPI_LEN	1
+#define INT_FLAG_LEGACY_IRQ_POS		31
+#define INT_FLAG_LEGACY_IRQ_LEN		1
+	u32 int_flag;		/* interrupt flag */
+
+	/* Netdev related settings */
+	unsigned char mac_addr[ETH_ALEN];
+	netdev_features_t netdev_features;
+	struct napi_struct napi;
+
+	int mac_speed;
+	int mac_duplex;
+
+	u32 msg_enable;
+	u32 reg_nonstick[(MSI_PBA - GLOBAL_CTRL0) >> 2];
+
+	struct work_struct restart_work;
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
+extern int fxgmac_net_powerup(struct fxgmac_pdata *priv);
+extern int fxgmac_net_powerdown(struct fxgmac_pdata *priv);
+extern int fxgmac_drv_probe(struct device *dev, struct fxgmac_resources *res);
+extern void fxgmac_phy_reset(struct fxgmac_pdata *priv);
+
+#endif /* YT6801_H */
diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c b/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
new file mode 100644
index 000000000..7cf4d1581
--- /dev/null
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
@@ -0,0 +1,99 @@
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
+#include "yt6801.h"
+
+#define PHY_WR_CONFIG(reg_offset)	(0x8000205 + ((reg_offset) * 0x10000))
+static int fxgmac_phy_write_reg(struct fxgmac_pdata *priv, u32 reg_id, u32 data)
+{
+	u32 val;
+	int ret;
+
+	FXGMAC_MAC_IO_WR(priv, MAC_MDIO_DATA, data);
+	FXGMAC_MAC_IO_WR(priv, MAC_MDIO_ADDRESS, PHY_WR_CONFIG(reg_id));
+	ret = read_poll_timeout_atomic(FXGMAC_MAC_IO_RD, val,
+				       !FXGMAC_GET_BITS(val, MAC_MDIO_ADDR, BUSY),
+				       10, 250, false, priv, MAC_MDIO_ADDRESS);
+	if (ret == -ETIMEDOUT) {
+		yt_err(priv, "%s err, id:%x ctrl:0x%08x, data:0x%08x\n",
+		       __func__, reg_id, PHY_WR_CONFIG(reg_id), data);
+		return ret;
+	}
+
+	return ret;
+}
+
+#define PHY_RD_CONFIG(reg_offset)	(0x800020d + ((reg_offset) * 0x10000))
+static int fxgmac_phy_read_reg(struct fxgmac_pdata *priv, u32 reg_id)
+{
+	u32 val;
+	int ret;
+
+	FXGMAC_MAC_IO_WR(priv, MAC_MDIO_ADDRESS, PHY_RD_CONFIG(reg_id));
+	ret = read_poll_timeout_atomic(FXGMAC_MAC_IO_RD, val,
+				       !FXGMAC_GET_BITS(val, MAC_MDIO_ADDR, BUSY),
+				       10, 250, false, priv, MAC_MDIO_ADDRESS);
+	if (ret == -ETIMEDOUT) {
+		yt_err(priv, "%s err, id:%x, ctrl:0x%08x, val:0x%08x.\n",
+		       __func__, reg_id, PHY_RD_CONFIG(reg_id), val);
+		return ret;
+	}
+
+	return FXGMAC_MAC_IO_RD(priv, MAC_MDIO_DATA); /* Read data */
+}
+
+static int fxgmac_mdio_write_reg(struct mii_bus *mii_bus, int phyaddr,
+				 int phyreg, u16 val)
+{
+	if (phyaddr > 0)
+		return -ENODEV;
+
+	return fxgmac_phy_write_reg(mii_bus->priv, phyreg, val);
+}
+
+static int fxgmac_mdio_read_reg(struct mii_bus *mii_bus, int phyaddr,
+				int phyreg)
+{
+	if (phyaddr > 0)
+		return -ENODEV;
+
+	return fxgmac_phy_read_reg(mii_bus->priv, phyreg);
+}
+
+static int fxgmac_mdio_register(struct fxgmac_pdata *priv)
+{
+	struct pci_dev *pdev = to_pci_dev(priv->dev);
+	struct phy_device *phydev;
+	struct mii_bus *new_bus;
+	int ret;
+
+	new_bus = devm_mdiobus_alloc(&pdev->dev);
+	if (!new_bus)
+		return -ENOMEM;
+
+	new_bus->name = "yt6801";
+	new_bus->priv = priv;
+	new_bus->parent = &pdev->dev;
+	new_bus->read = fxgmac_mdio_read_reg;
+	new_bus->write = fxgmac_mdio_write_reg;
+	snprintf(new_bus->id, MII_BUS_ID_SIZE, "yt6801-%x-%x",
+		 pci_domain_nr(pdev->bus), pci_dev_id(pdev));
+
+	ret = devm_mdiobus_register(&pdev->dev, new_bus);
+	if (ret < 0)
+		return ret;
+
+	phydev = mdiobus_get_phy(new_bus, 0);
+	if (!phydev)
+		return -ENODEV;
+
+	priv->phydev = phydev;
+	return 0;
+}
diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_type.h b/drivers/net/ethernet/motorcomm/yt6801/yt6801_type.h
new file mode 100644
index 000000000..7cc558551
--- /dev/null
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_type.h
@@ -0,0 +1,967 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Copyright (c) 2022 - 2024 Motorcomm Electronic Technology Co.,Ltd. */
+
+#ifndef YT6801_TYPE_H
+#define YT6801_TYPE_H
+
+#include <linux/netdevice.h>
+#include <linux/types.h>
+#include <linux/pci.h>
+#include <linux/mii.h>
+
+/****************  Other configuration register. *********************/
+#define GLOBAL_CTRL0					0x1000
+
+#define EPHY_CTRL					0x1004
+#define EPHY_CTRL_RESET_POS				0
+#define EPHY_CTRL_RESET_LEN				1
+#define EPHY_CTRL_STA_LINKUP_POS			1
+#define EPHY_CTRL_STA_LINKUP_LEN			1
+#define EPHY_CTRL_STA_DUPLEX_POS			2
+#define EPHY_CTRL_STA_DUPLEX_LEN			1
+#define EPHY_CTRL_STA_SPEED_POS				3
+#define EPHY_CTRL_STA_SPEED_LEN				2
+
+#define OOB_WOL_CTRL					0x1010
+#define OOB_WOL_CTRL_DIS_POS				0
+#define OOB_WOL_CTRL_DIS_LEN				1
+
+/* MAC management registers bit positions and sizes */
+#define MGMT_INT_CTRL0					0x1100
+#define MGMT_INT_CTRL0_INT_STATUS_POS			0
+#define MGMT_INT_CTRL0_INT_STATUS_LEN			16
+#define  MGMT_INT_CTRL0_INT_STATUS_RX			0x000f
+#define  MGMT_INT_CTRL0_INT_STATUS_TX			0x0010
+#define  MGMT_INT_CTRL0_INT_STATUS_MISC			0x0020
+#define  MGMT_INT_CTRL0_INT_STATUS_RXTXMISC		0x003f
+#define  MGMT_INT_CTRL0_INT_STATUS_MASK			0xffff
+#define MGMT_INT_CTRL0_INT_MASK_POS			16
+#define MGMT_INT_CTRL0_INT_MASK_LEN			16
+#define  MGMT_INT_CTRL0_INT_MASK_RXCH			0x000f
+#define  MGMT_INT_CTRL0_INT_MASK_TXCH			0x0010
+#define  MGMT_INT_CTRL0_INT_MASK_EX_PMT			0xf7ff
+#define  MGMT_INT_CTRL0_INT_MASK_DISABLE		0xf000
+#define  MGMT_INT_CTRL0_INT_MASK_MASK			0xffff
+
+/* Interrupt Moderation */
+#define INT_MOD					0x1108
+#define INT_MOD_RX_POS				0
+#define INT_MOD_RX_LEN				12
+#define  INT_MOD_200_US				200
+#define INT_MOD_TX_POS				16
+#define INT_MOD_TX_LEN				12
+
+/* LTR_CTRL3, LTR latency message, only for System IDLE Start. */
+#define LTR_IDLE_ENTER				0x113c
+#define LTR_IDLE_ENTER_ENTER_POS		0
+#define LTR_IDLE_ENTER_ENTER_LEN		10
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
+#define LTR_IDLE_EXIT_EXIT_POS			0
+#define LTR_IDLE_EXIT_EXIT_LEN			10
+#define  LTR_IDLE_EXIT_171_US			171
+#define LTR_IDLE_EXIT_SCALE_POS			10
+#define LTR_IDLE_EXIT_SCALE_LEN			5
+#define  LTR_IDLE_EXIT_SCALE			2
+#define LTR_IDLE_EXIT_REQUIRE_POS		15
+#define LTR_IDLE_EXIT_REQUIRE_LEN		1
+#define  LTR_IDLE_EXIT_REQUIRE			1
+
+#define MSIX_TBL_MASK				0x120c
+
+/* msi table */
+#define MSI_ID_RXQ0				0
+#define MSI_ID_RXQ1				1
+#define MSI_ID_RXQ2				2
+#define MSI_ID_RXQ3				3
+#define MSI_ID_TXQ0				4
+#define MSIX_TBL_MAX_NUM			5
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
+#define SYS_RESET_RESET_POS			31
+#define SYS_RESET_RESET_LEN			1
+
+#define PCIE_SERDES_PLL				0x199c
+#define PCIE_SERDES_PLL_AUTOOFF_POS		0
+#define PCIE_SERDES_PLL_AUTOOFF_LEN		1
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
+#define MAC_ISR_PHYIF_STA_LEN		1
+#define MAC_ISR_AN_SR_POS		1
+#define MAC_ISR_AN_SR_LEN		3
+#define MAC_ISR_PMT_STA_POS		4
+#define MAC_ISR_PMT_STA_LEN		1
+#define MAC_ISR_LPI_STA_POS		5
+#define MAC_ISR_LPI_STA_LEN		1
+#define MAC_ISR_MMC_STA_POS		8
+#define MAC_ISR_MMC_STA_LEN		1
+#define MAC_ISR_RX_MMC_STA_POS		9
+#define MAC_ISR_RX_MMC_STA_LEN		1
+#define MAC_ISR_TX_MMC_STA_POS		10
+#define MAC_ISR_TX_MMC_STA_LEN		1
+#define MAC_ISR_IPC_RXINT_POS		11
+#define MAC_ISR_IPC_RXINT_LEN		1
+#define MAC_ISR_TSIS_POS		12
+#define MAC_ISR_TSIS_LEN		1
+#define MAC_ISR_TX_RX_STA_POS		13
+#define MAC_ISR_TX_RX_STA_LEN		2
+#define MAC_ISR_GPIO_SR_POS		15
+#define MAC_ISR_GPIO_SR_LEN		11
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
+#define MAC_PFR_HUC_POS			1 /*  Hash Unicast Mode. */
+#define MAC_PFR_HUC_LEN			1
+#define MAC_PFR_PR_POS			0 /*  Promiscuous Mode. */
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
+#define  MAC_ECR_HDSMS_64B		0
+#define  MAC_ECR_HDSMS_128B		1
+#define  MAC_ECR_HDSMS_256B		2
+#define  MAC_ECR_HDSMS_512B		3
+#define  MAC_ECR_HDSMS_1023B		4
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
+#define MAC_MDIO_ADDR_BUSY_POS		0
+#define MAC_MDIO_ADDR_BUSY_LEN		1
+#define MAC_MDIO_ADDR_GOC_POS		2
+#define MAC_MDIO_ADDR_GOC_LEN		2
+#define MAC_MDIO_ADDR_GB_POS		0
+#define MAC_MDIO_ADDR_GB_LEN		1
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
+#define MMC_IPC_RXINT_MASK		0x0800
+#define MMC_IPC_RXINT			0x0808
+
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
+#define MMC_TIER_ALL_INTERRUPTS_POS		0
+#define MMC_TIER_ALL_INTERRUPTS_LEN		28
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
+/* MTL queue register offsets */
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
+/* MTL traffic class register offsets */
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
+/* DMA channel register offsets */
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
+
+#define RX_NORMAL_DESC0_OVT_POS		0  /* Outer VLAN Tag */
+#define RX_NORMAL_DESC0_OVT_LEN		16
+#define RX_NORMAL_DESC2_HL_POS		0  /* L3/L4 Header Length */
+#define RX_NORMAL_DESC2_HL_LEN		10
+#define RX_NORMAL_DESC3_OWN_POS		31 /* Own Bit */
+#define RX_NORMAL_DESC3_OWN_LEN		1
+#define RX_NORMAL_DESC3_INTE_POS	30
+#define RX_NORMAL_DESC3_INTE_LEN	1
+#define RX_NORMAL_DESC3_FD_POS		29 /* First Descriptor */
+#define RX_NORMAL_DESC3_FD_LEN		1
+#define RX_NORMAL_DESC3_LD_POS		28 /* Last Descriptor */
+#define RX_NORMAL_DESC3_LD_LEN		1
+#define RX_NORMAL_DESC3_BUF2V_POS	25 /* Receive Status RDES2 Valid */
+#define RX_NORMAL_DESC3_BUF2V_LEN	1
+#define RX_NORMAL_DESC3_BUF1V_POS	24 /* Receive Status RDES1 Valid */
+#define RX_NORMAL_DESC3_BUF1V_LEN	1
+#define RX_NORMAL_DESC3_ETLT_POS	16 /* Length/Type Field */
+#define RX_NORMAL_DESC3_ETLT_LEN	3
+#define RX_NORMAL_DESC3_ES_POS		15 /* Error Summary */
+#define RX_NORMAL_DESC3_ES_LEN		1
+#define RX_NORMAL_DESC3_PL_POS		0  /* Packet Length */
+#define RX_NORMAL_DESC3_PL_LEN		15
+
+#define RX_NORMAL_DESC0_WB_IVT_POS		16 /* Inner VLAN Tag. */
+#define RX_NORMAL_DESC0_WB_IVT_LEN		16
+#define RX_NORMAL_DESC0_WB_OVT_POS		0  /* Outer VLAN Tag. */
+#define RX_NORMAL_DESC0_WB_OVT_LEN		16
+#define RX_NORMAL_DESC1_WB_IPCE_POS		7  /* IP Payload Error. */
+#define RX_NORMAL_DESC1_WB_IPCE_LEN		1
+#define RX_NORMAL_DESC1_WB_IPV6_POS		5  /* IPV6 Header Present. */
+#define RX_NORMAL_DESC1_WB_IPV6_LEN		1
+#define RX_NORMAL_DESC1_WB_IPV4_POS		4  /* IPV4 Header Present. */
+#define RX_NORMAL_DESC1_WB_IPV4_LEN		1
+#define RX_NORMAL_DESC1_WB_IPHE_POS		3  /* IP Header Error. */
+#define RX_NORMAL_DESC1_WB_IPHE_LEN		1
+#define RX_NORMAL_DESC1_WB_PT_POS		0  /* Payload Type */
+#define RX_NORMAL_DESC1_WB_PT_LEN		3
+
+#define RX_NORMAL_DESC2_WB_HF_POS		18 /* Hash Filter Status. */
+#define RX_NORMAL_DESC2_WB_HF_LEN		1
+#define RX_NORMAL_DESC2_WB_DAF_POS		17 /* DA Filter Fail */
+#define RX_NORMAL_DESC2_WB_DAF_LEN		1
+#define RX_NORMAL_DESC2_WB_RAPARSER_POS		11  /* Parse error */
+#define RX_NORMAL_DESC2_WB_RAPARSER_LEN		3
+
+#define TX_CONTEXT_DESC2_IVLTV_POS	16 /* Inner VLAN Tag. */
+#define TX_CONTEXT_DESC2_IVLTV_LEN	16
+#define TX_CONTEXT_DESC2_MSS_POS	0  /* Maximum Segment Size */
+#define TX_CONTEXT_DESC2_MSS_LEN	14
+#define TX_CONTEXT_DESC3_CTXT_POS	30 /* Context Type */
+#define TX_CONTEXT_DESC3_CTXT_LEN	1
+#define TX_CONTEXT_DESC3_TCMSSV_POS	26 /* Timestamp correct or MSS Valid */
+#define TX_CONTEXT_DESC3_TCMSSV_LEN	1
+#define TX_CONTEXT_DESC3_IVTIR_POS	18 /* Inner VLAN Tag Insert/Replace */
+#define TX_CONTEXT_DESC3_IVTIR_LEN	2
+#define TX_CONTEXT_DESC3_IVTIR_INSERT	2
+#define TX_CONTEXT_DESC3_IVLTV_POS	17 /* Inner VLAN TAG valid. */
+#define TX_CONTEXT_DESC3_IVLTV_LEN	1
+#define TX_CONTEXT_DESC3_VLTV_POS	16 /* Inner VLAN Tag Valid */
+#define TX_CONTEXT_DESC3_VLTV_LEN	1
+#define TX_CONTEXT_DESC3_VT_POS		0 /* VLAN Tag */
+#define TX_CONTEXT_DESC3_VT_LEN		16
+
+#define TX_NORMAL_DESC2_IC_POS		31 /* Interrupt on Completion. */
+#define TX_NORMAL_DESC2_IC_LEN		1
+#define TX_NORMAL_DESC2_TTSE_POS	30 /* Transmit Timestamp Enable */
+#define TX_NORMAL_DESC2_TTSE_LEN	1
+#define TX_NORMAL_DESC2_VTIR_POS	14 /* VLAN Tag Insertion/Replacement */
+#define TX_NORMAL_DESC2_VTIR_LEN	2
+#define TX_NORMAL_DESC2_VLAN_INSERT	0x2
+#define TX_NORMAL_DESC2_HL_B1L_POS	0 /* Header Length or Buffer 1 Length */
+#define TX_NORMAL_DESC2_HL_B1L_LEN	14
+
+#define TX_NORMAL_DESC3_OWN_POS		31 /* Own Bit */
+#define TX_NORMAL_DESC3_OWN_LEN		1
+#define TX_NORMAL_DESC3_CTXT_POS	30 /* Context Type */
+#define TX_NORMAL_DESC3_CTXT_LEN	1
+#define TX_NORMAL_DESC3_FD_POS		29 /* First Descriptor */
+#define TX_NORMAL_DESC3_FD_LEN		1
+#define TX_NORMAL_DESC3_LD_POS		28 /* Last Descriptor */
+#define TX_NORMAL_DESC3_LD_LEN		1
+#define TX_NORMAL_DESC3_CPC_POS		26 /* CRC Pad Control */
+#define TX_NORMAL_DESC3_CPC_LEN		2
+#define TX_NORMAL_DESC3_TCPHDRLEN_POS	19 /* TCP/UDP Header Length. */
+#define TX_NORMAL_DESC3_TCPHDRLEN_LEN	4
+#define TX_NORMAL_DESC3_TSE_POS		18 /* TCP Segmentation Enable */
+#define TX_NORMAL_DESC3_TSE_LEN		1
+#define TX_NORMAL_DESC3_CIC_POS		16 /* Checksum Insertion Control */
+#define TX_NORMAL_DESC3_CIC_LEN		2
+#define TX_NORMAL_DESC3_FL_POS		0  /* Frame Length */
+#define TX_NORMAL_DESC3_FL_LEN		15
+#define TX_NORMAL_DESC3_TCPPL_POS	0  /* TCP Packet Length.*/
+#define TX_NORMAL_DESC3_TCPPL_LEN	18
+
+/* Bit getting and setting macros
+ *  The get macro will extract the current bit field value from within
+ *  the variable
+ *
+ *  The set macro will clear the current bit field value within the
+ *  variable and then set the bit field of the variable to the
+ *  specified value
+ */
+#define GET_BITS(_var, _index, _width) \
+	(((_var) >> (_index)) & ((0x1U << (_width)) - 1))
+
+#define SET_BITS(_var, _index, _width, _val)                                  \
+	do {                                                                  \
+		(_var) &= ~(((0x1U << (_width)) - 1) << (_index));            \
+		(_var) |= (((_val) & ((0x1U << (_width)) - 1)) << (_index));  \
+	} while (0)
+
+#define GET_BITS_LE(_var, _index, _width) \
+	((le32_to_cpu((_var)) >> (_index)) & ((0x1U << (_width)) - 1))
+
+#define SET_BITS_LE(_var, _index, _width, _val)                               \
+	do {                                                                  \
+		(_var) &=                                                     \
+			cpu_to_le32(~(((0x1U << (_width)) - 1) << (_index))); \
+		(_var) |= cpu_to_le32(                                        \
+			(((_val) & ((0x1U << (_width)) - 1)) << (_index)));   \
+	} while (0)
+
+/* Bit getting and setting macros based on register fields
+ *  The get macro uses the bit field definitions formed using the input
+ *  names to extract the current bit field value from within the
+ *  variable
+ *
+ *  The set macro uses the bit field definitions formed using the input
+ *  names to set the bit field of the variable to the specified value
+ */
+#define FXGMAC_GET_BITS(_var, _prefix, _field)                                \
+	GET_BITS((_var), _prefix##_##_field##_POS, _prefix##_##_field##_LEN)
+
+#define FXGMAC_SET_BITS(_var, _prefix, _field, _val)                          \
+	SET_BITS((_var), _prefix##_##_field##_POS, _prefix##_##_field##_LEN,  \
+		 (_val))
+
+#define FXGMAC_GET_BITS_LE(_var, _prefix, _field)                             \
+	GET_BITS_LE((_var), _prefix##_##_field##_POS, _prefix##_##_field##_LEN)
+
+#define FXGMAC_SET_BITS_LE(_var, _prefix, _field, _val)                       \
+	SET_BITS_LE((_var), _prefix##_##_field##_POS,                         \
+		    _prefix##_##_field##_LEN, (_val))
+
+/* Macros for reading or writing registers
+ *  The ioread macros will get bit fields or full values using the
+ *  register definitions formed using the input names
+ *
+ *  The iowrite macros will set bit fields or full values using the
+ *  register definitions formed using the input names
+ */
+#define FXGMAC_IO_RD(_pdata, _reg) ioread32(((_pdata)->hw_addr) + (_reg))
+
+#define FXGMAC_IO_RD_BITS(_pdata, _reg, _field)                               \
+	GET_BITS(FXGMAC_IO_RD((_pdata), _reg), _reg##_##_field##_POS,         \
+		 _reg##_##_field##_LEN)
+
+#define FXGMAC_IO_WR(_pdata, _reg, _val)                                      \
+	iowrite32((_val), ((_pdata)->hw_addr) + (_reg))
+
+#define FXGMAC_IO_WR_BITS(_pdata, _reg, _field, _val)                         \
+	do {                                                                  \
+		u32 reg_val = FXGMAC_IO_RD((_pdata), _reg);                   \
+		SET_BITS(reg_val, _reg##_##_field##_POS,                      \
+			 _reg##_##_field##_LEN, (_val));                      \
+		FXGMAC_IO_WR((_pdata), _reg, reg_val);                        \
+	} while (0)
+
+/* Macros for reading or writing MAC registers
+ *  Similar to the standard read and write macros except that the
+ *  base register value need add MAC_OFFSET.
+ */
+#define FXGMAC_MAC_IO_RD(_pdata, _reg)                                        \
+	ioread32(((_pdata)->hw_addr) + MAC_OFFSET + (_reg))
+
+#define FXGMAC_MAC_IO_RD_BITS(_pdata, _reg, _field)                           \
+	GET_BITS(FXGMAC_MAC_IO_RD((_pdata), _reg), _reg##_##_field##_POS,     \
+		 _reg##_##_field##_LEN)
+
+#define FXGMAC_MAC_IO_WR(_pdata, _reg, _val)                                  \
+	iowrite32((_val), ((_pdata)->hw_addr) + MAC_OFFSET + (_reg))
+
+#define FXGMAC_MAC_IO_WR_BITS(_pdata, _reg, _field, _val)                     \
+	do {                                                                  \
+		u32 reg_val = FXGMAC_MAC_IO_RD((_pdata), _reg);               \
+		SET_BITS(reg_val, _reg##_##_field##_POS,                      \
+			 _reg##_##_field##_LEN, (_val));                      \
+		FXGMAC_MAC_IO_WR((_pdata), _reg, reg_val);                    \
+	} while (0)
+
+/* Macros for reading or writing MTL queue or traffic class registers
+ *  Similar to the standard read and write macros except that the
+ *  base register value is calculated by the queue or traffic class number
+ */
+#define FXGMAC_MTL_IO_RD(_pdata, _n, _reg)                                    \
+	ioread32(((_pdata)->hw_addr) + MAC_OFFSET + MTL_Q_BASE +              \
+		 ((_n) * MTL_Q_INC) + (_reg))
+
+#define FXGMAC_MTL_IO_RD_BITS(_pdata, _n, _reg, _field)                       \
+	GET_BITS(FXGMAC_MTL_IO_RD((_pdata), (_n), (_reg)),                    \
+		 _reg##_##_field##_POS, _reg##_##_field##_LEN)
+
+#define FXGMAC_MTL_IO_WR(_pdata, _n, _reg, _val)                              \
+	iowrite32((_val), ((_pdata)->hw_addr) + MAC_OFFSET + MTL_Q_BASE +     \
+				  ((_n) * MTL_Q_INC) + (_reg))
+
+#define FXGMAC_MTL_IO_WR_BITS(_pdata, _n, _reg, _field, _val)                 \
+	do {                                                                  \
+		u32 reg_val = FXGMAC_MTL_IO_RD((_pdata), (_n), _reg);         \
+		SET_BITS(reg_val, _reg##_##_field##_POS,                      \
+			 _reg##_##_field##_LEN, (_val));                      \
+		FXGMAC_MTL_IO_WR((_pdata), (_n), _reg, reg_val);              \
+	} while (0)
+
+/* Macros for reading or writing DMA channel registers
+ *  Similar to the standard read and write macros except that the
+ *  base register value is obtained from the ring
+ */
+#define FXGMAC_DMA_IO_RD(_channel, _reg)                                      \
+	ioread32(((_channel)->dma_regs) + (_reg))
+
+#define FXGMAC_DMA_IO_RD_BITS(_channel, _reg, _field)                         \
+	GET_BITS(FXGMAC_DMA_IO_RD((_channel), _reg), _reg##_##_field##_POS,   \
+		 _reg##_##_field##_LEN)
+
+#define FXGMAC_DMA_IO_WR(_channel, _reg, _val)                                \
+	iowrite32((_val), ((_channel)->dma_regs) + (_reg))
+
+#define FXGMAC_DMA_IO_WR_BITS(_channel, _reg, _field, _val)                   \
+	do {                                                                  \
+		u32 reg_val = FXGMAC_DMA_IO_RD((_channel), _reg);             \
+		SET_BITS(reg_val, _reg##_##_field##_POS,                      \
+			 _reg##_##_field##_LEN, (_val));                      \
+		FXGMAC_DMA_IO_WR((_channel), _reg, reg_val);                  \
+	} while (0)
+
+#define yt_err(priv, fmt, arg...)	dev_err((priv)->dev, fmt, ##arg)
+#define yt_dbg(priv, fmt, arg...)	dev_dbg((priv)->dev, fmt, ##arg)
+
+#endif /* YT6801_TYPE_H */
-- 
2.34.1


