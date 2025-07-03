Return-Path: <netdev+bounces-203573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 192C1AF6763
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 03:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 376891C43994
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 01:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748DE1B415F;
	Thu,  3 Jul 2025 01:51:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFEB15746F;
	Thu,  3 Jul 2025 01:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751507465; cv=none; b=cIIbBA7u4giTvbmbeX/9mWyqy/iR7Yrqgwbph1PJlDmG0BRgC8TIBkmX+aA8Zan2IjXfprynhzRDw91ZwubqgEUMwtFfQCYFNMfb1pHJNFolq30o6/Mwe7IDwW6jmLIE8e6tKoqLE/qJDsh5XcOXlCXiH4nRcKJdJsXTo5kQVDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751507465; c=relaxed/simple;
	bh=dAKh3sy8U2m4jz7eGA6EANeYapH2VNM50Tyl/WurccQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WUdW01ZjgAo6s9HRA04Pgm9MUNeQXQrvwoM6EERwjMcO0QdUXJc/Ur1YnzhwOKC2SA7ojmmApSHu2zL5UnNp7cRU3ed9VTv0IoVSyK+l7aIeMBBobcnQV+4QbCSLpDfCmdOrlJfW0e2VXRj31H3jsY7KL6TMSCE4OcRAOO+/a5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz8t1751507389t87e1356e
X-QQ-Originating-IP: WqNPlsAG6yqfJCbEaL7ZF4GVDSGKNCYuUNJCDi74CrA=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 03 Jul 2025 09:49:46 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 790028881953019986
EX-QQ-RecipientCnt: 22
From: Dong Yibo <dong100@mucse.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	andrew+netdev@lunn.ch,
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
	alexanderduyck@fb.com
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dong100@mucse.com
Subject: [PATCH 08/15] net: rnpgbe: Add irq support
Date: Thu,  3 Jul 2025 09:48:52 +0800
Message-Id: <20250703014859.210110-9-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250703014859.210110-1-dong100@mucse.com>
References: <20250703014859.210110-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: N7IP8+eIyBrZoaQmRCvhXpmfkKEG6c2+taUvBb62RM5IwfB7iRu//x0F
	G+8yIFMgL9pQFwa5MurkDg9Se3cDzObcjMiu4oDBRjQKts8NsLxK2biGi0K8dQ+pSUhqCoe
	bl2Yu4y1uYRvWdvGydLxK4Td0GMMmGuZXpvTdH7elIkmvyvjjRInMFPxOPXoxw9IZHzDgKe
	uyJkFPTU88XtXoZF+RHig/G5vP1R+8OjaXdALu2bvJf7YmAD6HHv2nRpMMwbIyUoHhpfVIp
	iSPRA2cWJLEJJMP2FmZrAcWa1q1Ci5477lm+cL207Uafn/KAnc2rXd05vgZS5tpuSY+nckZ
	qGIAZ8k5uTlb6ez1PMgQwnV818LaeaUAY/C3XyH+8VUKa5tZDScmo8KyCpu1xGq7Nj+pWrQ
	c9m34VIVcA8s8HzgFa6ZYqDoOLMRuV0yuG96DugsdZQkNLmtW2mBArASn9VpalZSnWgaVY6
	wgs0wTkAY382EjyzOnmlSLX0FypeXmFgtB3Cdm8sRaAvLxMgrIdjN1caqeEYHJXqadZgsCY
	U/BvbfVIehyvfy5Hl+jJQh/JDsPwiywCjAAR+XrCXTwKc9REmzvXRT5noLz4YNHV5c6GAnf
	YoQE3c9L5u+cnpSN3ximsYTpgGHs2I952vqt5xXQdJauPhX1vtw/qAL4WyjNw1Fjt7gFPpS
	P9sQ+JecnGtkqkcIqyDlTzgPfLnKHItiMff6NFVex/Aapoe2E4yj7wCyq6M0SfYvUicLBG8
	Tg9akyXGSbBVUxcJeweIb1Su0uRKDGvV0zDsv0MplwR2sN1xKmWjcOrwni+vMlSskF/83o3
	M755HIlijkofXJ7hFu6YV4i1jTxohAOA4otX1Hy+hwY9/w08Ve03aTls4goaLEX1BbcZUF3
	Ef8wMz6rIbl65Il0h0qzElTxWrZ6ixcCiWrfew7zRI1Ur6mkzXArACr1cpnQxgpMr/7mSQ2
	pdn8deqLuxG3DY8zPvQ5MUIREWQ4r01wqQI2M96eJCJxqOwFBh3/Fob109II1t3W9C2Q+nx
	tFRibtfAMz2KaccBRa
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

Initialize irq functions for driver use.

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/rnpgbe/Makefile    |   3 +-
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    | 156 +++++-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |   2 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.c    | 462 ++++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.h    |  26 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 129 ++++-
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c |   6 +-
 7 files changed, 777 insertions(+), 7 deletions(-)
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
index 93c3e8f50a80..82df7f133f10 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -6,6 +6,7 @@
 
 #include <linux/types.h>
 #include <linux/netdevice.h>
+#include <linux/pci.h>
 
 extern const struct rnpgbe_info rnpgbe_n500_info;
 extern const struct rnpgbe_info rnpgbe_n210_info;
@@ -135,7 +136,7 @@ struct mucse_mbx_info {
 	u16 fw_ack;
 	/* lock for only one use mbx */
 	struct mutex lock;
-	bool other_irq_enabled;
+	bool irq_enabled;
 	int mbx_size;
 	int mbx_mem_size;
 #define MBX_FEATURE_NO_ZERO BIT(0)
@@ -233,6 +234,7 @@ struct mucse_hw {
 #define M_HW_SOFT_MASK_OTHER_IRQ ((u32)(1 << 18))
 	u32 feature_flags;
 	u32 flags;
+#define M_FLAG_MSI_CAPABLE ((u32)(1 << 0))
 #define M_FLAGS_INIT_MAC_ADDRESS ((u32)(1 << 27))
 	u32 driver_version;
 	u16 usecstocount;
@@ -255,6 +257,136 @@ enum mucse_state_t {
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
+#define M_RING_FLAG_DELAY_SETUP_RX_LEN ((u32)(1 << 0))
+#define M_RING_FLAG_CHANGE_RX_LEN ((u32)(1 << 1))
+#define M_RING_FLAG_DO_RESET_RX_LEN ((u32)(1 << 2))
+#define M_RING_SKIP_TX_START ((u32)(1 << 3))
+#define M_RING_NO_TUNNEL_SUPPORT ((u32)(1 << 4))
+#define M_RING_SIZE_CHANGE_FIX ((u32)(1 << 5))
+#define M_RING_SCATER_SETUP ((u32)(1 << 6))
+#define M_RING_STAGS_SUPPORT ((u32)(1 << 7))
+#define M_RING_DOUBLE_VLAN_SUPPORT ((u32)(1 << 8))
+#define M_RING_VEB_MULTI_FIX ((u32)(1 << 9))
+#define M_RING_IRQ_MISS_FIX ((u32)(1 << 10))
+#define M_RING_OUTER_VLAN_FIX ((u32)(1 << 11))
+#define M_RING_CHKSM_FIX ((u32)(1 << 12))
+#define M_RING_LOWER_ITR ((u32)(1 << 13))
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
+#define M_QVECTOR_FLAG_IRQ_MISS_CHECK ((u32)(1 << 0))
+#define M_QVECTOR_FLAG_ITR_FEATURE ((u32)(1 << 1))
+#define M_QVECTOR_FLAG_REDUCE_TX_IRQ_MISS ((u32)(1 << 2))
+	char name[IFNAMSIZ + 9];
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
@@ -262,19 +394,37 @@ struct mucse {
 	/* board number */
 	u16 bd_number;
 	u16 tx_work_limit;
+	u32 flags;
+#define M_FLAG_NEED_LINK_UPDATE ((u32)(1 << 0))
+#define M_FLAG_MSIX_ENABLED ((u32)(1 << 1))
+#define M_FLAG_MSI_ENABLED ((u32)(1 << 2))
 	u32 flags2;
 #define M_FLAG2_NO_NET_REG ((u32)(1 << 0))
+#define M_FLAG2_INSMOD ((u32)(1 << 1))
 	u32 priv_flags;
 #define M_PRIV_FLAG_TX_COALESCE ((u32)(1 << 25))
 #define M_PRIV_FLAG_RX_COALESCE ((u32)(1 << 26))
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
 
@@ -320,4 +470,8 @@ struct rnpgbe_info {
 
 /* error codes */
 #define MUCSE_ERR_INVALID_ARGUMENT (-1)
+
+void rnpgbe_service_event_schedule(struct mucse *mucse);
+int rnpgbe_poll(struct napi_struct *napi, int budget);
+
 #endif /* _RNPGBE_H */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
index 5b01ecd641f2..e94a432dd7b6 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
@@ -296,6 +296,8 @@ static void rnpgbe_get_invariants_n500(struct mucse_hw *hw)
 	hw->max_vfs = 7;
 	hw->min_len_cap = RNPGBE_MIN_LEN;
 	hw->max_len_cap = RNPGBE_MAX_LEN;
+	hw->max_msix_vectors = 26;
+	hw->flags |= M_FLAG_MSI_CAPABLE;
 	memcpy(&hw->ops, &hw_ops_n500, sizeof(hw->ops));
 }
 
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
new file mode 100644
index 000000000000..95c913212182
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
@@ -0,0 +1,462 @@
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
+		return -EINVAL;
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
+ **/
+static int rnpgbe_set_interrupt_capability(struct mucse *mucse)
+{
+	struct mucse_hw *hw = &mucse->hw;
+	int vector, v_budget, err = 0;
+	int irq_mode_back = mucse->irq_mode;
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
+			return -EINVAL;
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
+static void mucse_add_ring(struct mucse_ring *ring,
+			   struct mucse_ring_container *head)
+{
+	ring->next = head->ring;
+	head->ring = ring;
+	head->count++;
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
+ * We allocate one q_vector.  If allocation fails we return -ENOMEM.
+ **/
+static int rnpgbe_alloc_q_vector(struct mucse *mucse,
+				 int eth_queue_idx, int v_idx, int r_idx,
+				 int r_count, int step)
+{
+	struct mucse_q_vector *q_vector;
+	struct mucse_ring *ring;
+	struct mucse_hw *hw = &mucse->hw;
+	struct mucse_dma_info *dma = &hw->dma;
+	int node = NUMA_NO_NODE;
+	int cpu = -1;
+	int ring_count, size;
+	int txr_count, rxr_count, idx;
+	int rxr_idx = r_idx, txr_idx = r_idx;
+	int cpu_offset = 0;
+
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
+ * We allocate one q_vector per tx/rx queue pair.  If allocation fails we
+ * return -ENOMEM.
+ **/
+static int rnpgbe_alloc_q_vectors(struct mucse *mucse)
+{
+	int v_idx = mucse->q_vector_off;
+	int ring_idx = 0;
+	int r_remaing = min_t(int, mucse->num_tx_queues,
+			      mucse->num_rx_queues);
+	int ring_step = 1;
+	int err, ring_cnt, v_remaing = mucse->num_q_vectors;
+	int q_vector_nums = 0;
+	int eth_queue_idx = 0;
+
+	/* can support muti rings in one q_vector */
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
+	int i;
+	/* setup here */
+	int ring_step = 1;
+	struct mucse_ring *ring;
+	struct mucse_hw *hw = &mucse->hw;
+	struct mucse_dma_info *dma = &hw->dma;
+
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
+	/* clean msix flags */
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
index 000000000000..ab55c5ae1482
--- /dev/null
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
@@ -0,0 +1,26 @@
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
+#define mucse_for_each_ring(pos, head)  \
+	for (pos = (head).ring; pos; pos = pos->next)
+
+int rnpgbe_init_interrupt_scheme(struct mucse *mucse);
+void rnpgbe_clear_interrupt_scheme(struct mucse *mucse);
+
+#endif /* _RNPGBE_LIB_H */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
index d99da9838e27..bfe7b34be78e 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
@@ -12,6 +12,7 @@
 #include "rnpgbe.h"
 #include "rnpgbe_mbx_fw.h"
 #include "rnpgbe_sfc.h"
+#include "rnpgbe_lib.h"
 
 char rnpgbe_driver_name[] = "rnpgbe";
 static const char rnpgbe_driver_string[] =
@@ -45,6 +46,51 @@ static struct pci_device_id rnpgbe_pci_tbl[] = {
 	{0, },
 };
 
+static struct workqueue_struct *rnpgbe_wq;
+
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
+int rnpgbe_poll(struct napi_struct *napi, int budget)
+{
+	return 0;
+}
+
 /**
  * rnpgbe_check_fw_from_flash - Check chip-id and bin-id
  * @hw: hardware structure
@@ -169,11 +215,67 @@ static int rnpgbe_sw_init(struct mucse *mucse)
 	/* set default ring sizes */
 	mucse->tx_ring_item_count = M_DEFAULT_TXD;
 	mucse->rx_ring_item_count = M_DEFAULT_RXD;
+	mucse->irq_mode = irq_mode_msix;
+	mucse->max_q_vectors = hw->max_msix_vectors;
+	mucse->num_other_vectors = 1;
 	set_bit(__MUCSE_DOWN, &mucse->state);
 
 	return 0;
 }
 
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
  * rnpgbe_add_adpater - add netdev for this pci_dev
  * @pdev: PCI device information structure
@@ -260,7 +362,6 @@ static int rnpgbe_add_adpater(struct pci_dev *pdev,
 	hw->mbx.ops.init_params(hw);
 	/* echo fw driver insmod */
 	hw->ops.driver_status(hw, true, mucse_driver_insmod);
-
 	if (mucse_mbx_get_capability(hw)) {
 		dev_err(&pdev->dev,
 			"mucse_mbx_get_capability failed!\n");
@@ -286,9 +387,20 @@ static int rnpgbe_add_adpater(struct pci_dev *pdev,
 	eth_hw_addr_set(netdev, hw->perm_addr);
 	strscpy(netdev->name, pci_name(pdev), sizeof(netdev->name));
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
@@ -357,7 +469,11 @@ static void rnpgbe_rm_adpater(struct mucse *mucse)
 
 	netdev = mucse->netdev;
 	pr_info("= remove rnpgbe:%s =\n", netdev->name);
+	cancel_work_sync(&mucse->service_task);
+	timer_delete_sync(&mucse->service_timer);
 	hw->ops.driver_status(hw, false, mucse_driver_insmod);
+	remove_mbx_irq(mucse);
+	rnpgbe_clear_interrupt_scheme(mucse);
 	free_netdev(netdev);
 	mucse->netdev = NULL;
 	pr_info("remove complete\n");
@@ -391,6 +507,8 @@ static void __rnpgbe_shutdown(struct pci_dev *pdev, bool *enable_wake)
 
 	*enable_wake = false;
 	netif_device_detach(netdev);
+	remove_mbx_irq(mucse);
+	rnpgbe_clear_interrupt_scheme(mucse);
 	pci_disable_device(pdev);
 }
 
@@ -428,6 +546,12 @@ static int __init rnpgbe_init_module(void)
 	pr_info("%s - version %s\n", rnpgbe_driver_string,
 		rnpgbe_driver_version);
 	pr_info("%s\n", rnpgbe_copyright);
+	rnpgbe_wq = create_singlethread_workqueue(rnpgbe_driver_name);
+	if (!rnpgbe_wq) {
+		pr_err("%s: Failed to create workqueue\n", rnpgbe_driver_name);
+		return -ENOMEM;
+	}
+
 	ret = pci_register_driver(&rnpgbe_driver);
 	if (ret)
 		return ret;
@@ -440,6 +564,7 @@ module_init(rnpgbe_init_module);
 static void __exit rnpgbe_exit_module(void)
 {
 	pci_unregister_driver(&rnpgbe_driver);
+	destroy_workqueue(rnpgbe_wq);
 }
 
 module_exit(rnpgbe_exit_module);
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
index a9c5caa764a0..f86fb81f4db4 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
@@ -231,7 +231,7 @@ int rnpgbe_mbx_lldp_get(struct mucse_hw *hw)
 	memset(&req, 0, sizeof(req));
 	memset(&reply, 0, sizeof(reply));
 	build_get_lldp_req(&req, cookie, hw->nr_lane);
-	if (hw->mbx.other_irq_enabled) {
+	if (hw->mbx.irq_enabled) {
 		err = mucse_mbx_fw_post_req(hw, &req, cookie);
 	} else {
 		err = mucse_fw_send_cmd_wait(hw, &req, &reply);
@@ -332,7 +332,7 @@ int mucse_mbx_fw_reset_phy(struct mucse_hw *hw)
 
 	memset(&req, 0, sizeof(req));
 	memset(&reply, 0, sizeof(reply));
-	if (hw->mbx.other_irq_enabled) {
+	if (hw->mbx.irq_enabled) {
 		struct mbx_req_cookie *cookie = mbx_cookie_zalloc(0);
 
 		if (!cookie)
@@ -376,7 +376,7 @@ int mucse_fw_get_macaddr(struct mucse_hw *hw, int pfvfnum,
 	if (!mac_addr)
 		return -EINVAL;
 
-	if (hw->mbx.other_irq_enabled) {
+	if (hw->mbx.irq_enabled) {
 		struct mbx_req_cookie *cookie =
 			mbx_cookie_zalloc(sizeof(reply.mac_addr));
 		struct mac_addr *mac = (struct mac_addr *)cookie->priv;
-- 
2.25.1


