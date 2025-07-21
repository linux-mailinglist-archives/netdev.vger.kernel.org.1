Return-Path: <netdev+bounces-208579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7463CB0C337
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 13:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF7373B80A6
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 11:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3472D3A89;
	Mon, 21 Jul 2025 11:34:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7622D3722;
	Mon, 21 Jul 2025 11:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753097686; cv=none; b=CBSp0OSEkv80X+VQBKq2aXPijv7kf6xupnSNgjy2hdzVidPN4r/EuSlbvdVfbXORIjcCTyrZpMuHeTk/izC24r/hyYRn+w4G392sSpBWC69tQHdRYCQTkfT+Z1+Il0yFh6o+lf0qJ6WsCDNgK/jZ8hOYFyDLOp73oTXAifT/qpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753097686; c=relaxed/simple;
	bh=cQaC8Nbow4sm5Ce7s7uzhXr9gnoF4fYzoiDAvFFudn0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AdrRsu4bKq8YH1klx79aysM6ZMLw0sDk83HVn2gA+VGI4H72gVOXLmDG6HoMf68lz8sDBDmxtYuwGkcERgP4uJXKyzddhBg0FkpiUr0ZxJNeTgc3B7gSeBGX2Uyir6qBRLSdSnk9p44T89V+JYYKYRFTCFoqVctVTTVDgwRsadc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz18t1753097604tfc7a8ba3
X-QQ-Originating-IP: Unax/578hb1wbtzIY/X7l5HHwbQgTucIdqfrtq2mHXs=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 21 Jul 2025 19:33:20 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14314802722129751210
EX-QQ-RecipientCnt: 23
From: Dong Yibo <dong100@mucse.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	gur.stavi@huawei.com,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	danishanwar@ti.com,
	lee@trager.us,
	gongfan1@huawei.com,
	lorenzo@kernel.org,
	geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com,
	lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com,
	richardcochran@gmail.com
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dong100@mucse.com
Subject: [PATCH v2 08/15] net: rnpgbe: Add irq support
Date: Mon, 21 Jul 2025 19:32:31 +0800
Message-Id: <20250721113238.18615-9-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250721113238.18615-1-dong100@mucse.com>
References: <20250721113238.18615-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OBsd15jA3tvBFcTRQWgS1liArhUIRyGAJTv65DNhBkSUm8A5bg3T4vK5
	p+1+ICA5J8DAPJST4e1hremjC/zzKryd9L7VkrV7HJ730yQBN7xYLsN8UeD0gNKRDruumZL
	SdBRO47gvPy+J2+/7J2HLS710Ti4Y9wQslxMAy/yV8NfUKRlfHEakkvFUiUwtOfobXeItFl
	HU0ELMP95wjzDsGAp1xCJVlzMSgiqFM1JTsHl8OR0f02Duz1PI/cRAURMrAuOxVSYjuo5hm
	iqMAqHE1TT54exq85sPyIes51mKtKy5upztiX0/Yw2ct9YiUZCQT8i7kDYL0wXj+6hcamfX
	Vj4GrNcDNLcAUEnRbPLE1lJ0VQtn8Gv8ldWz2f+MPtQ1h5EX3bCuhFA4mY2vFj/54sY/Ohg
	YvyVQ7yKSbmI/CrQGz7RF8wsSUcmHKQ3Dszy9bPxK4ByQW/N2eAqG0EQ3dlj20mcw2b+Pim
	iaf8bMPkMfTrWGQHbPWjE9uPvPKoKBpWFtYnX955ikJzRJAb1omzS+NQI4TeA+uvcodpf+J
	Qxri+D1gVgIzGqJKttot3WDz3xLJJpMBAFLd0up+Q4QCaDSUBMUXdmrxm3svGvEFGXlFkxg
	cR1Ale7sBeE78+BVeH0U2EhZAYxBihYulDQ5CmE0+fBuccgw5iPA8VC20jFjl0VBZIbPGRb
	r9HUgdDtsx5CmLvioPW++YAHt5nHGArJ5HthluwUBF8lBCoXZ1HnleNGUgT3J8f0rq3qi7o
	lo9nNjTSZ1jHdyMT14FrYUTU7aK8SZV2DV+LvhcGZ56Sn+DNC4WB2VZj5AC8Q20tUHcznz5
	Lf2T1D9JRyDgi+iPKHfR/sGTBYKtb9Deme1PUZtof4+sBalgkPrPdj6wSqoTkHfJE+riwkw
	mJm90LTv4jEgsOPIsQYBo7K4O9N44tdZZ1BXJKbZIBUWQ3SF8t/P7wrevY4YvhpWEC4XtCM
	NlPapYaq4kPMK32BKkswMV4IVrvg1dE8MqrWtT+vRlt34VpPcqzNwLPzXSpy+gES3lP9X/Y
	ihZsgJ0PORPs7IhA4hP33/u/dDaW2L6Lsb9rkSFw==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

Initialize irq functions for driver use.

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/rnpgbe/Makefile    |   3 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    | 152 ++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |   2 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.c    | 500 ++++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.h    |  28 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 145 ++++-
 6 files changed, 827 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h

diff --git a/drivers/net/ethernet/mucse/rnpgbe/Makefile b/drivers/net/ethernet/mucse/rnpgbe/Makefile
index db7d3a8140b2..c5a41406fd60 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/Makefile
+++ b/drivers/net/ethernet/mucse/rnpgbe/Makefile
@@ -9,4 +9,5 @@ rnpgbe-objs := rnpgbe_main.o \
 	       rnpgbe_chip.o \
 	       rnpgbe_mbx.o \
 	       rnpgbe_mbx_fw.o \
-	       rnpgbe_sfc.o
+	       rnpgbe_sfc.o \
+	       rnpgbe_lib.o
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
index 30b5400241c3..212e5b8fd7b4 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -7,6 +7,7 @@
 #include <linux/types.h>
 #include <linux/netdevice.h>
 #include <net/devlink.h>
+#include <linux/pci.h>
 
 extern const struct rnpgbe_info rnpgbe_n500_info;
 extern const struct rnpgbe_info rnpgbe_n210_info;
@@ -234,6 +235,7 @@ struct mucse_hw {
 	struct mucse_addr_filter_info addr_ctrl;
 	u32 feature_flags;
 	u32 flags;
+#define M_FLAG_MSI_CAPABLE BIT(0)
 #define M_FLAGS_INIT_MAC_ADDRESS BIT(27)
 	u32 driver_version;
 	u16 usecstocount;
@@ -256,6 +258,136 @@ enum mucse_state_t {
 	__MUCSE_EEE_REMOVE,
 };
 
+enum irq_mode_enum {
+	irq_mode_legency,
+	irq_mode_msi,
+	irq_mode_msix,
+};
+
+struct mucse_queue_stats {
+	u64 packets;
+	u64 bytes;
+};
+
+struct mucse_tx_queue_stats {
+	u64 restart_queue;
+	u64 tx_busy;
+	u64 tx_done_old;
+	u64 clean_desc;
+	u64 poll_count;
+	u64 irq_more_count;
+	u64 send_bytes;
+	u64 send_bytes_to_hw;
+	u64 todo_update;
+	u64 send_done_bytes;
+	u64 vlan_add;
+	u64 tx_next_to_clean;
+	u64 tx_irq_miss;
+	u64 tx_equal_count;
+	u64 tx_clean_times;
+	u64 tx_clean_count;
+};
+
+struct mucse_rx_queue_stats {
+	u64 driver_drop_packets;
+	u64 rsc_count;
+	u64 rsc_flush;
+	u64 non_eop_descs;
+	u64 alloc_rx_page_failed;
+	u64 alloc_rx_buff_failed;
+	u64 alloc_rx_page;
+	u64 csum_err;
+	u64 csum_good;
+	u64 poll_again_count;
+	u64 vlan_remove;
+	u64 rx_next_to_clean;
+	u64 rx_irq_miss;
+	u64 rx_equal_count;
+	u64 rx_clean_times;
+	u64 rx_clean_count;
+};
+
+struct mucse_ring {
+	struct mucse_ring *next;
+	struct mucse_q_vector *q_vector;
+	struct net_device *netdev;
+	struct device *dev;
+	void *desc;
+	union {
+		struct mucse_tx_buffer *tx_buffer_info;
+		struct mucse_rx_buffer *rx_buffer_info;
+	};
+	unsigned long last_rx_timestamp;
+	unsigned long state;
+	u8 __iomem *ring_addr;
+	u8 __iomem *tail;
+	u8 __iomem *dma_int_stat;
+	u8 __iomem *dma_int_mask;
+	u8 __iomem *dma_int_clr;
+	dma_addr_t dma;
+	unsigned int size;
+	u32 ring_flags;
+#define M_RING_FLAG_DELAY_SETUP_RX_LEN BIT(0)
+#define M_RING_FLAG_CHANGE_RX_LEN BIT(1)
+#define M_RING_FLAG_DO_RESET_RX_LEN BIT(2)
+#define M_RING_SKIP_TX_START BIT(3)
+#define M_RING_NO_TUNNEL_SUPPORT BIT(4)
+#define M_RING_SIZE_CHANGE_FIX BIT(5)
+#define M_RING_SCATER_SETUP BIT(6)
+#define M_RING_STAGS_SUPPORT BIT(7)
+#define M_RING_DOUBLE_VLAN_SUPPORT BIT(8)
+#define M_RING_VEB_MULTI_FIX BIT(9)
+#define M_RING_IRQ_MISS_FIX BIT(10)
+#define M_RING_OUTER_VLAN_FIX BIT(11)
+#define M_RING_CHKSM_FIX BIT(12)
+#define M_RING_LOWER_ITR BIT(13)
+	u8 pfvfnum;
+	u16 count;
+	u16 temp_count;
+	u16 reset_count;
+	u8 queue_index;
+	u8 rnpgbe_queue_idx;
+	u16 next_to_use;
+	u16 next_to_clean;
+	u16 device_id;
+	struct mucse_queue_stats stats;
+	struct u64_stats_sync syncp;
+	union {
+		struct mucse_tx_queue_stats tx_stats;
+		struct mucse_rx_queue_stats rx_stats;
+	};
+} ____cacheline_internodealigned_in_smp;
+
+struct mucse_ring_container {
+	struct mucse_ring *ring;
+	u16 work_limit;
+	u16 count;
+};
+
+struct mucse_q_vector {
+	struct mucse *mucse;
+	int v_idx;
+	u16 itr_rx;
+	u16 itr_tx;
+	struct mucse_ring_container rx, tx;
+	struct napi_struct napi;
+	cpumask_t affinity_mask;
+	struct irq_affinity_notify affinity_notify;
+	int numa_node;
+	struct rcu_head rcu; /* to avoid race with update stats on free */
+	u32 vector_flags;
+#define M_QVECTOR_FLAG_IRQ_MISS_CHECK BIT(0)
+#define M_QVECTOR_FLAG_ITR_FEATURE BIT(1)
+#define M_QVECTOR_FLAG_REDUCE_TX_IRQ_MISS BIT(2)
+	char name[IFNAMSIZ + 17];
+	/* for dynamic allocation of rings associated with this q_vector */
+	struct mucse_ring ring[0] ____cacheline_internodealigned_in_smp;
+};
+
+#define MAX_TX_QUEUES (8)
+#define MAX_RX_QUEUES (8)
+#define MAX_Q_VECTORS (64)
+
 struct mucse {
 	struct net_device *netdev;
 	struct pci_dev *pdev;
@@ -264,19 +396,37 @@ struct mucse {
 	/* board number */
 	u16 bd_number;
 	u16 tx_work_limit;
+	u32 flags;
+#define M_FLAG_NEED_LINK_UPDATE BIT(0)
+#define M_FLAG_MSIX_ENABLED BIT(1)
+#define M_FLAG_MSI_ENABLED BIT(2)
 	u32 flags2;
 #define M_FLAG2_NO_NET_REG BIT(0)
+#define M_FLAG2_INSMOD BIT(1)
 	u32 priv_flags;
 #define M_PRIV_FLAG_TX_COALESCE BIT(25)
 #define M_PRIV_FLAG_RX_COALESCE BIT(26)
+	struct mucse_ring *tx_ring[MAX_TX_QUEUES] ____cacheline_aligned_in_smp;
 	int tx_ring_item_count;
+	int num_tx_queues;
+	struct mucse_ring *rx_ring[MAX_RX_QUEUES] ____cacheline_aligned_in_smp;
 	int rx_ring_item_count;
+	int num_rx_queues;
+	int num_other_vectors;
+	int irq_mode;
+	struct msix_entry *msix_entries;
+	struct mucse_q_vector *q_vector[MAX_Q_VECTORS];
+	int num_q_vectors;
+	int max_q_vectors;
+	int q_vector_off;
 	int napi_budge;
 	u16 rx_usecs;
 	u16 rx_frames;
 	u16 tx_frames;
 	u16 tx_usecs;
 	unsigned long state;
+	struct timer_list service_timer;
+	struct work_struct service_task;
 	char name[60];
 };
 
@@ -320,4 +470,6 @@ struct rnpgbe_info {
 #define mucse_dbg(mucse, fmt, arg...) \
 	dev_dbg(&(mucse)->pdev->dev, fmt, ##arg)
 
+void rnpgbe_service_event_schedule(struct mucse *mucse);
+
 #endif /* _RNPGBE_H */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
index fc179eb8c516..fa8317ae7642 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
@@ -340,6 +340,8 @@ static void rnpgbe_get_invariants_n500(struct mucse_hw *hw)
 	hw->max_vfs = 7;
 	hw->min_len_cap = RNPGBE_MIN_LEN;
 	hw->max_len_cap = RNPGBE_MAX_LEN;
+	hw->max_msix_vectors = 26;
+	hw->flags |= M_FLAG_MSI_CAPABLE;
 	memcpy(&hw->ops, &hw_ops_n500, sizeof(hw->ops));
 }
 
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
new file mode 100644
index 000000000000..2bf8a7f7f303
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
@@ -0,0 +1,500 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2020 - 2025 Mucse Corporation. */
+
+#include "rnpgbe.h"
+#include "rnpgbe_lib.h"
+
+/**
+ * rnpgbe_set_rss_queues - Allocate queues for RSS
+ * @mucse: pointer to private structure
+ *
+ * Try to determine queue num with rss.
+ *
+ * @return: true on success, negative on failure
+ **/
+static bool rnpgbe_set_rss_queues(struct mucse *mucse)
+{
+	return true;
+}
+
+/**
+ * rnpgbe_set_num_queues - Allocate queues for device, feature dependent
+ * @mucse: pointer to private structure
+ *
+ * Determine tx/rx queue nums
+ **/
+static void rnpgbe_set_num_queues(struct mucse *mucse)
+{
+	/* Start with base case */
+	mucse->num_tx_queues = 1;
+	mucse->num_rx_queues = 1;
+
+	rnpgbe_set_rss_queues(mucse);
+}
+
+/**
+ * rnpgbe_acquire_msix_vectors - Allocate msix vectors
+ * @mucse: pointer to private structure
+ * @vectors: number of msix vectors
+ **/
+static int rnpgbe_acquire_msix_vectors(struct mucse *mucse,
+				       int vectors)
+{
+	int err;
+
+	err = pci_enable_msix_range(mucse->pdev, mucse->msix_entries,
+				    vectors, vectors);
+	if (err < 0) {
+		kfree(mucse->msix_entries);
+		mucse->msix_entries = NULL;
+		return err;
+	}
+
+	vectors -= mucse->num_other_vectors;
+	/* setup true q_vectors num */
+	mucse->num_q_vectors = min(vectors, mucse->max_q_vectors);
+
+	return 0;
+}
+
+/**
+ * rnpgbe_set_interrupt_capability - set MSI-X or MSI if supported
+ * @mucse: pointer to private structure
+ *
+ * Attempt to configure the interrupts using the best available
+ * capabilities of the hardware.
+ *
+ * @return: 0 on success, negative on failure
+ **/
+static int rnpgbe_set_interrupt_capability(struct mucse *mucse)
+{
+	int irq_mode_back = mucse->irq_mode;
+	struct mucse_hw *hw = &mucse->hw;
+	int vector, v_budget, err = 0;
+
+	v_budget = min_t(int, mucse->num_tx_queues, mucse->num_rx_queues);
+	v_budget = min_t(int, v_budget, num_online_cpus());
+	v_budget += mucse->num_other_vectors;
+	v_budget = min_t(int, v_budget, hw->max_msix_vectors);
+
+	if (mucse->irq_mode == irq_mode_msix) {
+		mucse->msix_entries = kcalloc(v_budget,
+					      sizeof(struct msix_entry),
+					      GFP_KERNEL);
+
+		if (!mucse->msix_entries)
+			return -ENOMEM;
+
+		for (vector = 0; vector < v_budget; vector++)
+			mucse->msix_entries[vector].entry = vector;
+
+		err = rnpgbe_acquire_msix_vectors(mucse, v_budget);
+		if (!err) {
+			if (mucse->num_other_vectors)
+				mucse->q_vector_off = 1;
+			mucse->flags |= M_FLAG_MSIX_ENABLED;
+			goto out;
+		}
+		kfree(mucse->msix_entries);
+		/* if has msi capability try it */
+		if (hw->flags & M_FLAG_MSI_CAPABLE)
+			mucse->irq_mode = irq_mode_msi;
+	}
+	/* if has msi capability or set irq_mode */
+	if (mucse->irq_mode == irq_mode_msi) {
+		err = pci_enable_msi(mucse->pdev);
+		/* msi mode use only 1 irq */
+		if (!err)
+			mucse->flags |= M_FLAG_MSI_ENABLED;
+	}
+	/* write back origin irq_mode for next time */
+	mucse->irq_mode = irq_mode_back;
+	/* legacy and msi only 1 vectors */
+	mucse->num_q_vectors = 1;
+	err = 0;
+out:
+	return err;
+}
+
+/**
+ * update_ring_count - update ring num
+ * @mucse: pointer to private structure
+ *
+ * update_ring_count only update ring num when driver insmod
+ **/
+static void update_ring_count(struct mucse *mucse)
+{
+	if (mucse->flags2 & M_FLAG2_INSMOD)
+		return;
+
+	mucse->flags2 |= M_FLAG2_INSMOD;
+	/* limit ring count if in msi or legacy mode */
+	if (!(mucse->flags & M_FLAG_MSIX_ENABLED)) {
+		mucse->num_tx_queues = 1;
+		mucse->num_rx_queues = 1;
+	}
+}
+
+/**
+ * mucse_add_ring - add ring to ring container
+ * @ring: ring to be added
+ * @head: ring container
+ **/
+static void mucse_add_ring(struct mucse_ring *ring,
+			   struct mucse_ring_container *head)
+{
+	ring->next = head->ring;
+	head->ring = ring;
+	head->count++;
+}
+
+/**
+ * rnpgbe_poll - NAPI polling RX/TX cleanup routine
+ * @napi: napi struct with our devices info in it
+ * @budget: amount of work driver is allowed to do this pass, in packets
+ *
+ * Clean all queues associated with a q_vector
+ *
+ * @return: amount of work done in this call
+ **/
+static int rnpgbe_poll(struct napi_struct *napi, int budget)
+{
+	return 0;
+}
+
+/**
+ * rnpgbe_alloc_q_vector - Allocate memory for a single interrupt vector
+ * @mucse: pointer to private structure
+ * @eth_queue_idx: queue_index idx for this q_vector
+ * @v_idx: index of vector used for this q_vector
+ * @r_idx: total number of rings to allocate
+ * @r_count: ring count
+ * @step: ring step
+ *
+ * @return: 0 on success. If allocation fails we return -ENOMEM.
+ **/
+static int rnpgbe_alloc_q_vector(struct mucse *mucse,
+				 int eth_queue_idx, int v_idx, int r_idx,
+				 int r_count, int step)
+{
+	int rxr_idx = r_idx, txr_idx = r_idx;
+	struct mucse_hw *hw = &mucse->hw;
+	struct mucse_q_vector *q_vector;
+	int txr_count, rxr_count, idx;
+	struct mucse_dma_info *dma;
+	struct mucse_ring *ring;
+	int node = NUMA_NO_NODE;
+	int ring_count, size;
+	int cpu_offset = 0;
+	int cpu = -1;
+
+	dma = &hw->dma;
+	txr_count = r_count;
+	rxr_count = r_count;
+	ring_count = txr_count + rxr_count;
+	size = sizeof(struct mucse_q_vector) +
+	       (sizeof(struct mucse_ring) * ring_count);
+
+	/* should minis mucse->q_vector_off */
+	if (cpu_online(cpu_offset + v_idx - mucse->q_vector_off)) {
+		cpu = cpu_offset + v_idx - mucse->q_vector_off;
+		node = cpu_to_node(cpu);
+	}
+
+	/* allocate q_vector and rings */
+	q_vector = kzalloc_node(size, GFP_KERNEL, node);
+	if (!q_vector)
+		q_vector = kzalloc(size, GFP_KERNEL);
+	if (!q_vector)
+		return -ENOMEM;
+
+	/* setup affinity mask and node */
+	if (cpu != -1)
+		cpumask_set_cpu(cpu, &q_vector->affinity_mask);
+	q_vector->numa_node = node;
+
+	netif_napi_add_weight(mucse->netdev, &q_vector->napi, rnpgbe_poll,
+			      mucse->napi_budge);
+	/* tie q_vector and mucse together */
+	mucse->q_vector[v_idx - mucse->q_vector_off] = q_vector;
+	q_vector->mucse = mucse;
+	q_vector->v_idx = v_idx;
+	/* initialize pointer to rings */
+	ring = q_vector->ring;
+
+	for (idx = 0; idx < txr_count; idx++) {
+		/* assign generic ring traits */
+		ring->dev = &mucse->pdev->dev;
+		ring->netdev = mucse->netdev;
+		/* configure backlink on ring */
+		ring->q_vector = q_vector;
+		/* update q_vector Tx values */
+		mucse_add_ring(ring, &q_vector->tx);
+
+		/* apply Tx specific ring traits */
+		ring->count = mucse->tx_ring_item_count;
+		ring->queue_index = eth_queue_idx + idx;
+		/* it is used to location hw reg */
+		ring->rnpgbe_queue_idx = txr_idx;
+		ring->ring_addr = dma->dma_ring_addr + RING_OFFSET(txr_idx);
+		ring->dma_int_stat = ring->ring_addr + DMA_INT_STAT;
+		ring->dma_int_mask = ring->ring_addr + DMA_INT_MASK;
+		ring->dma_int_clr = ring->ring_addr + DMA_INT_CLR;
+		ring->device_id = mucse->pdev->device;
+		ring->pfvfnum = hw->pfvfnum;
+		/* not support tunnel */
+		ring->ring_flags |= M_RING_NO_TUNNEL_SUPPORT;
+		/* assign ring to mucse */
+		mucse->tx_ring[ring->queue_index] = ring;
+		/* update count and index */
+		txr_idx += step;
+		/* push pointer to next ring */
+		ring++;
+	}
+
+	for (idx = 0; idx < rxr_count; idx++) {
+		/* assign generic ring traits */
+		ring->dev = &mucse->pdev->dev;
+		ring->netdev = mucse->netdev;
+		/* configure backlink on ring */
+		ring->q_vector = q_vector;
+		/* update q_vector Rx values */
+		mucse_add_ring(ring, &q_vector->rx);
+		/* apply Rx specific ring traits */
+		ring->count = mucse->rx_ring_item_count;
+		/* rnpgbe_queue_idx can be changed after */
+		ring->queue_index = eth_queue_idx + idx;
+		ring->rnpgbe_queue_idx = rxr_idx;
+		ring->ring_addr = dma->dma_ring_addr + RING_OFFSET(rxr_idx);
+		ring->dma_int_stat = ring->ring_addr + DMA_INT_STAT;
+		ring->dma_int_mask = ring->ring_addr + DMA_INT_MASK;
+		ring->dma_int_clr = ring->ring_addr + DMA_INT_CLR;
+		ring->device_id = mucse->pdev->device;
+		ring->pfvfnum = hw->pfvfnum;
+
+		ring->ring_flags |= M_RING_NO_TUNNEL_SUPPORT;
+		ring->ring_flags |= M_RING_STAGS_SUPPORT;
+		/* assign ring to mucse */
+		mucse->rx_ring[ring->queue_index] = ring;
+		/* update count and index */
+		rxr_idx += step;
+		/* push pointer to next ring */
+		ring++;
+	}
+
+	q_vector->vector_flags |= M_QVECTOR_FLAG_ITR_FEATURE;
+	q_vector->itr_rx = mucse->rx_usecs;
+
+	return 0;
+}
+
+/**
+ * rnpgbe_free_q_vector - Free memory allocated for specific interrupt vector
+ * @mucse: pointer to private structure
+ * @v_idx: Index of vector to be freed
+ *
+ * This function frees the memory allocated to the q_vector.  In addition if
+ * NAPI is enabled it will delete any references to the NAPI struct prior
+ * to freeing the q_vector.
+ **/
+static void rnpgbe_free_q_vector(struct mucse *mucse, int v_idx)
+{
+	struct mucse_q_vector *q_vector = mucse->q_vector[v_idx];
+	struct mucse_ring *ring;
+
+	mucse_for_each_ring(ring, q_vector->tx)
+		mucse->tx_ring[ring->queue_index] = NULL;
+
+	mucse_for_each_ring(ring, q_vector->rx)
+		mucse->rx_ring[ring->queue_index] = NULL;
+
+	mucse->q_vector[v_idx] = NULL;
+	netif_napi_del(&q_vector->napi);
+	kfree_rcu(q_vector, rcu);
+}
+
+/**
+ * rnpgbe_alloc_q_vectors - Allocate memory for interrupt vectors
+ * @mucse: pointer to private structure
+ *
+ * @return: 0 if success. if allocation fails we return -ENOMEM.
+ **/
+static int rnpgbe_alloc_q_vectors(struct mucse *mucse)
+{
+	int err, ring_cnt, v_remaing = mucse->num_q_vectors;
+	int r_remaing = min_t(int, mucse->num_tx_queues,
+			      mucse->num_rx_queues);
+	int v_idx = mucse->q_vector_off;
+	int q_vector_nums = 0;
+	int eth_queue_idx = 0;
+	int ring_step = 1;
+	int ring_idx = 0;
+
+	/* can support multi rings in one q_vector */
+	for (; r_remaing > 0 && v_remaing > 0; v_remaing--) {
+		ring_cnt = DIV_ROUND_UP(r_remaing, v_remaing);
+		err = rnpgbe_alloc_q_vector(mucse, eth_queue_idx,
+					    v_idx, ring_idx, ring_cnt,
+					    ring_step);
+		if (err)
+			goto err_out;
+		ring_idx += ring_step * ring_cnt;
+		r_remaing -= ring_cnt;
+		v_idx++;
+		q_vector_nums++;
+		eth_queue_idx += ring_cnt;
+	}
+	/* should fix the real used q_vectors_nums */
+	mucse->num_q_vectors = q_vector_nums;
+
+	return 0;
+
+err_out:
+	mucse->num_tx_queues = 0;
+	mucse->num_rx_queues = 0;
+	mucse->num_q_vectors = 0;
+
+	while (v_idx--)
+		rnpgbe_free_q_vector(mucse, v_idx);
+
+	return -ENOMEM;
+}
+
+/**
+ * rnpgbe_cache_ring_rss - Descriptor ring to register mapping for RSS
+ * @mucse: pointer to private structure
+ *
+ * Cache the descriptor ring offsets for RSS to the assigned rings.
+ *
+ **/
+static void rnpgbe_cache_ring_rss(struct mucse *mucse)
+{
+	struct mucse_hw *hw = &mucse->hw;
+	struct mucse_dma_info *dma;
+	struct mucse_ring *ring;
+	int ring_step = 1;
+	int i;
+
+	dma = &hw->dma;
+	/* some ring alloc rules can be added here */
+	for (i = 0; i < mucse->num_rx_queues; i++) {
+		ring = mucse->tx_ring[i];
+		ring->rnpgbe_queue_idx = i * ring_step;
+		ring->ring_addr = dma->dma_ring_addr +
+				  RING_OFFSET(ring->rnpgbe_queue_idx);
+
+		ring->dma_int_stat = ring->ring_addr + DMA_INT_STAT;
+		ring->dma_int_mask = ring->ring_addr + DMA_INT_MASK;
+		ring->dma_int_clr = ring->ring_addr + DMA_INT_CLR;
+	}
+
+	for (i = 0; i < mucse->num_tx_queues; i++) {
+		ring = mucse->rx_ring[i];
+		ring->rnpgbe_queue_idx = i * ring_step;
+		ring->ring_addr = dma->dma_ring_addr +
+				  RING_OFFSET(ring->rnpgbe_queue_idx);
+		ring->dma_int_stat = ring->ring_addr + DMA_INT_STAT;
+		ring->dma_int_mask = ring->ring_addr + DMA_INT_MASK;
+		ring->dma_int_clr = ring->ring_addr + DMA_INT_CLR;
+	}
+}
+
+/**
+ * rnpgbe_cache_ring_register - Descriptor ring to register mapping
+ * @mucse: pointer to private structure
+ *
+ * Reset ring reg here to satisfy feature.
+ **/
+static void rnpgbe_cache_ring_register(struct mucse *mucse)
+{
+	rnpgbe_cache_ring_rss(mucse);
+}
+
+/**
+ * rnpgbe_free_q_vectors - Free memory allocated for interrupt vectors
+ * @mucse: pointer to private structure
+ *
+ * This function frees the memory allocated to the q_vectors.  In addition if
+ * NAPI is enabled it will delete any references to the NAPI struct prior
+ * to freeing the q_vector.
+ **/
+static void rnpgbe_free_q_vectors(struct mucse *mucse)
+{
+	int v_idx = mucse->num_q_vectors;
+
+	mucse->num_rx_queues = 0;
+	mucse->num_tx_queues = 0;
+	mucse->num_q_vectors = 0;
+
+	while (v_idx--)
+		rnpgbe_free_q_vector(mucse, v_idx);
+}
+
+/**
+ * rnpgbe_reset_interrupt_capability - Reset irq capability setup
+ * @mucse: pointer to private structure
+ **/
+static void rnpgbe_reset_interrupt_capability(struct mucse *mucse)
+{
+	if (mucse->flags & M_FLAG_MSIX_ENABLED)
+		pci_disable_msix(mucse->pdev);
+	else if (mucse->flags & M_FLAG_MSI_CAPABLE)
+		pci_disable_msi(mucse->pdev);
+
+	kfree(mucse->msix_entries);
+	mucse->msix_entries = NULL;
+	mucse->q_vector_off = 0;
+	mucse->flags &= (~M_FLAG_MSIX_ENABLED);
+	mucse->flags &= (~M_FLAG_MSI_ENABLED);
+}
+
+/**
+ * rnpgbe_init_interrupt_scheme - Determine proper interrupt scheme
+ * @mucse: pointer to private structure
+ *
+ * We determine which interrupt scheme to use based on...
+ * - Hardware queue count
+ * - cpu numbers
+ * - irq mode (msi/legacy force 1)
+ *
+ * @return: 0 on success, negative on failure
+ **/
+int rnpgbe_init_interrupt_scheme(struct mucse *mucse)
+{
+	int err;
+
+	/* Number of supported queues */
+	rnpgbe_set_num_queues(mucse);
+	/* Set interrupt mode */
+	err = rnpgbe_set_interrupt_capability(mucse);
+	if (err)
+		goto err_set_interrupt;
+	/* update ring num only init */
+	update_ring_count(mucse);
+	err = rnpgbe_alloc_q_vectors(mucse);
+	if (err)
+		goto err_alloc_q_vectors;
+	rnpgbe_cache_ring_register(mucse);
+	set_bit(__MUCSE_DOWN, &mucse->state);
+
+	return 0;
+
+err_alloc_q_vectors:
+	rnpgbe_reset_interrupt_capability(mucse);
+err_set_interrupt:
+	return err;
+}
+
+/**
+ * rnpgbe_clear_interrupt_scheme - Clear the current interrupt scheme settings
+ * @mucse: pointer to private structure
+ *
+ * Clear interrupt specific resources and reset the structure
+ **/
+void rnpgbe_clear_interrupt_scheme(struct mucse *mucse)
+{
+	mucse->num_tx_queues = 0;
+	mucse->num_rx_queues = 0;
+	rnpgbe_free_q_vectors(mucse);
+	rnpgbe_reset_interrupt_capability(mucse);
+}
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
new file mode 100644
index 000000000000..0df519a50185
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2020 - 2025 Mucse Corporation. */
+
+#ifndef _RNPGBE_LIB_H
+#define _RNPGBE_LIB_H
+
+#include "rnpgbe.h"
+
+#define RING_OFFSET(n) (0x100 * (n))
+#define DMA_RX_START (0x10)
+#define DMA_RX_READY (0x14)
+#define DMA_TX_START (0x18)
+#define DMA_TX_READY (0x1c)
+#define DMA_INT_MASK (0x24)
+#define TX_INT_MASK (0x02)
+#define RX_INT_MASK (0x01)
+#define DMA_INT_CLR (0x28)
+#define DMA_INT_STAT (0x20)
+
+#define mucse_for_each_ring(pos, head)\
+	for (typeof((head).ring) __pos = (head).ring;\
+		__pos ? ({ pos = __pos; 1; }) : 0;\
+		__pos = __pos->next)
+
+int rnpgbe_init_interrupt_scheme(struct mucse *mucse);
+void rnpgbe_clear_interrupt_scheme(struct mucse *mucse);
+
+#endif /* _RNPGBE_LIB_H */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
index 1338ef01f545..8fc1af1c00bc 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
@@ -12,6 +12,7 @@
 #include "rnpgbe.h"
 #include "rnpgbe_mbx_fw.h"
 #include "rnpgbe_sfc.h"
+#include "rnpgbe_lib.h"
 
 char rnpgbe_driver_name[] = "rnpgbe";
 static const struct rnpgbe_info *rnpgbe_info_tbl[] = {
@@ -38,6 +39,50 @@ static struct pci_device_id rnpgbe_pci_tbl[] = {
 	{0, },
 };
 
+static struct workqueue_struct *rnpgbe_wq;
+
+/**
+ * rnpgbe_service_event_schedule - schedule task
+ * @mucse: pointer to private structure
+ **/
+void rnpgbe_service_event_schedule(struct mucse *mucse)
+{
+	if (!test_bit(__MUCSE_DOWN, &mucse->state) &&
+	    !test_and_set_bit(__MUCSE_SERVICE_SCHED, &mucse->state))
+		queue_work(rnpgbe_wq, &mucse->service_task);
+}
+
+/**
+ * rnpgbe_service_timer - Timer Call-back
+ * @t: pointer to timer_list
+ **/
+static void rnpgbe_service_timer(struct timer_list *t)
+{
+	struct mucse *mucse = timer_container_of(mucse, t, service_timer);
+	unsigned long next_event_offset;
+	bool ready = true;
+
+	/* poll faster when waiting for link */
+	if (mucse->flags & M_FLAG_NEED_LINK_UPDATE)
+		next_event_offset = HZ / 10;
+	else
+		next_event_offset = HZ;
+	/* Reset the timer */
+	if (!test_bit(__MUCSE_REMOVE, &mucse->state))
+		mod_timer(&mucse->service_timer, next_event_offset + jiffies);
+
+	if (ready)
+		rnpgbe_service_event_schedule(mucse);
+}
+
+/**
+ * rnpgbe_service_task - manages and runs subtasks
+ * @work: pointer to work_struct containing our data
+ **/
+static void rnpgbe_service_task(struct work_struct *work)
+{
+}
+
 /**
  * rnpgbe_sw_init - Init driver private status
  * @mucse: pointer to private structure
@@ -65,11 +110,84 @@ static int rnpgbe_sw_init(struct mucse *mucse)
 	/* set default ring sizes */
 	mucse->tx_ring_item_count = M_DEFAULT_TXD;
 	mucse->rx_ring_item_count = M_DEFAULT_RXD;
+	mucse->irq_mode = irq_mode_msix;
+	mucse->max_q_vectors = hw->max_msix_vectors;
+	mucse->num_other_vectors = 1;
 	set_bit(__MUCSE_DOWN, &mucse->state);
 
 	return 0;
 }
 
+/**
+ * remove_mbx_irq - Remove mbx Routine
+ * @mucse: pointer to private structure
+ **/
+static void remove_mbx_irq(struct mucse *mucse)
+{
+	struct mucse_hw *hw = &mucse->hw;
+
+	if (mucse->num_other_vectors == 0)
+		return;
+	/* only msix use indepented intr */
+	if (mucse->flags & M_FLAG_MSIX_ENABLED) {
+		hw->mbx.ops.configure(hw,
+				      mucse->msix_entries[0].entry,
+				      false);
+		if (hw->mbx.irq_enabled) {
+			free_irq(mucse->msix_entries[0].vector, mucse);
+			hw->mbx.irq_enabled = false;
+		}
+	}
+}
+
+/**
+ * rnpgbe_msix_other - Other irq handler
+ * @irq: irq num
+ * @data: private data
+ *
+ * @return: IRQ_HANDLED
+ **/
+static irqreturn_t rnpgbe_msix_other(int irq, void *data)
+{
+	struct mucse *mucse = (struct mucse *)data;
+
+	set_bit(__MUCSE_IN_IRQ, &mucse->state);
+	clear_bit(__MUCSE_IN_IRQ, &mucse->state);
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * register_mbx_irq - Regist mbx Routine
+ * @mucse: pointer to private structure
+ *
+ * @return: 0 on success, negative on failure
+ **/
+static int register_mbx_irq(struct mucse *mucse)
+{
+	struct mucse_hw *hw = &mucse->hw;
+	struct net_device *netdev = mucse->netdev;
+	int err = 0;
+
+	/* for mbx:vector0 */
+	if (mucse->num_other_vectors == 0)
+		return err;
+	/* only do this in msix mode */
+	if (mucse->flags & M_FLAG_MSIX_ENABLED) {
+		err = request_irq(mucse->msix_entries[0].vector,
+				  rnpgbe_msix_other, 0, netdev->name,
+				  mucse);
+		if (err)
+			goto err_mbx;
+		hw->mbx.ops.configure(hw,
+				      mucse->msix_entries[0].entry,
+				      true);
+		hw->mbx.irq_enabled = true;
+	}
+err_mbx:
+	return err;
+}
+
 /**
  * rnpgbe_add_adapter - add netdev for this pci_dev
  * @pdev: PCI device information structure
@@ -165,7 +283,6 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
 	hw->mbx.ops.init_params(hw);
 	/* echo fw driver insmod */
 	hw->ops.driver_status(hw, true, mucse_driver_insmod);
-
 	err = mucse_mbx_get_capability(hw);
 	if (err) {
 		dev_err(&pdev->dev,
@@ -190,9 +307,20 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
 	netdev->priv_flags |= IFF_SUPP_NOFCS;
 	eth_hw_addr_set(netdev, hw->perm_addr);
 	memcpy(netdev->perm_addr, hw->perm_addr, netdev->addr_len);
+	ether_addr_copy(hw->addr, hw->perm_addr);
+	timer_setup(&mucse->service_timer, rnpgbe_service_timer, 0);
+	INIT_WORK(&mucse->service_task, rnpgbe_service_task);
+	clear_bit(__MUCSE_SERVICE_SCHED, &mucse->state);
+	err = rnpgbe_init_interrupt_scheme(mucse);
+	if (err)
+		goto err_free_net;
+	err = register_mbx_irq(mucse);
+	if (err)
+		goto err_free_irq;
 
 	return 0;
-
+err_free_irq:
+	rnpgbe_clear_interrupt_scheme(mucse);
 err_free_net:
 	free_netdev(netdev);
 	return err;
@@ -261,7 +389,11 @@ static void rnpgbe_rm_adapter(struct mucse *mucse)
 
 	rnpgbe_devlink_unregister(mucse);
 	netdev = mucse->netdev;
+	cancel_work_sync(&mucse->service_task);
+	timer_delete_sync(&mucse->service_timer);
 	hw->ops.driver_status(hw, false, mucse_driver_insmod);
+	remove_mbx_irq(mucse);
+	rnpgbe_clear_interrupt_scheme(mucse);
 	free_netdev(netdev);
 	mucse->netdev = NULL;
 }
@@ -300,6 +432,8 @@ static void rnpgbe_dev_shutdown(struct pci_dev *pdev,
 
 	*enable_wake = false;
 	netif_device_detach(netdev);
+	remove_mbx_irq(mucse);
+	rnpgbe_clear_interrupt_scheme(mucse);
 	pci_disable_device(pdev);
 }
 
@@ -341,6 +475,12 @@ static int __init rnpgbe_init_module(void)
 {
 	int ret;
 
+	rnpgbe_wq = create_singlethread_workqueue(rnpgbe_driver_name);
+	if (!rnpgbe_wq) {
+		pr_err("%s: Failed to create workqueue\n", rnpgbe_driver_name);
+		return -ENOMEM;
+	}
+
 	ret = pci_register_driver(&rnpgbe_driver);
 	if (ret)
 		return ret;
@@ -358,6 +498,7 @@ module_init(rnpgbe_init_module);
 static void __exit rnpgbe_exit_module(void)
 {
 	pci_unregister_driver(&rnpgbe_driver);
+	destroy_workqueue(rnpgbe_wq);
 }
 
 module_exit(rnpgbe_exit_module);
-- 
2.25.1


