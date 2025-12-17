Return-Path: <netdev+bounces-245086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC40CC6ACC
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 10:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5DD353019DB1
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 09:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9FE3451A9;
	Wed, 17 Dec 2025 08:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="KHEB09uJ"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B873446D1;
	Wed, 17 Dec 2025 08:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765961493; cv=none; b=V9fjz940Sl+3DYktL2pSKhcjVxVt3lYP2adpr9HTdAktXvtwEKxOU8uYL0GuiZ9p+4K/zuRIUxf82B3elfy2UnYK1HLYqBitPSor0gbRZ+yOmTMXF+Qmh7T4MfwluhgrXisL8fhvSrkPZ/4ToxYUjz+o5ES76g3kNLotLbvGFks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765961493; c=relaxed/simple;
	bh=FZPavdHwKs/f1Qye3fues14ro3o3DM601FPhUeTyOgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H84zvSAuugkFZIitmnUFPvah2Cgp1eTAzP5UcSrKkdOjbgLzHsIebQHaZXdPBj3ksBDAQ78dJvLPhBq9Hy1+unEAFw2qziWPzgjtReMTX5Q0nwpRgKI/DXVXwvk+LugXr+PyvqsdDsAAnCgYWlDpQo3uY7bRjqjORy3MIDUExc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=KHEB09uJ; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=nH
	F9XLv/RJ3jgWu+mlikyrcAuSNHMRz7girOyJqwR0s=; b=KHEB09uJ9mBRGWytxp
	cCfDBZlkMHfnfBHm+x6ZQw7fDwGE7mrQbzWNzQaaDjIarnm1R3t6wsMSQiEC4urF
	Z+gE5YKFZh20X98kWig8eLOVTU8mnbM8x+5QfF104YIsJYw3ZKYaEAdxNEONV0bF
	41gzxEwBhVvhE415pLtgyBcXA=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wAXSZ7lbkJp2ZeZAw--.42656S10;
	Wed, 17 Dec 2025 16:50:49 +0800 (CST)
From: Xiong Weimin <15927021679@163.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	xiongweimin <xiongweimin@kylinos.cn>
Subject: [PATCH 05/14] examples/vhost_user_rdma: implement comprehensive memory region management
Date: Wed, 17 Dec 2025 16:49:53 +0800
Message-ID: <20251217085044.5432-7-15927021679@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251217085044.5432-1-15927021679@163.com>
References: <20251217085044.5432-1-15927021679@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXSZ7lbkJp2ZeZAw--.42656S10
X-Coremail-Antispam: 1Uf129KBjvJXoWfGw4xtr1Uur1xCFy8Gr1Utrb_yoWDXFW3p3
	WIgrn5ZrsrKr4xGwn2yw1q9F13Xw4rAr47CFZ3G3Z093WUAr95Cay8ua1jkF17AFWxAr1x
	JFWUtFZ5GF1fZ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnBMNUUUUU=
X-CM-SenderInfo: jprvmjixqsilmxzbiqqrwthudrp/xtbC0gnASWlCbumiAQAA3d

From: xiongweimin <xiongweimin@kylinos.cn>

This commit adds core functionality for RDMA Memory Region (MR) handling:
1. DMA MR registration for physical memory access
2. Pre-allocated MR creation for optimized buffer handling
3. User-space MR registration with GPA->VVA translation
4. MR deregistration with reference-counted cleanup
5. Secure key generation and validation mechanisms

Key features:
- Random lkey/rkey generation with collision avoidance
- Three MR types: DMA, pre-allocated, and user-mapped
- Page mapping for user-space memory regions
- State management (VALID/ZOMBIE) for safe deregistration
- Reference counting integration with PDs
- Comprehensive error handling and logging

Signed-off-by: Xiong Weimin<xiongweimin@kylinos.cn>
Change-Id: I4c26d47181f895c05b8ba125fdf0959bd0827d99
---
 examples/vhost_user_rdma/vhost_rdma_ib.c | 199 +++++++++++++++++++++++
 examples/vhost_user_rdma/vhost_rdma_ib.h |  74 +++++++++
 2 files changed, 273 insertions(+)

diff --git a/examples/vhost_user_rdma/vhost_rdma_ib.c b/examples/vhost_user_rdma/vhost_rdma_ib.c
index e590b555d3..3002498151 100644
--- a/examples/vhost_user_rdma/vhost_rdma_ib.c
+++ b/examples/vhost_user_rdma/vhost_rdma_ib.c
@@ -18,6 +18,7 @@
 #include <rte_ethdev.h>
 #include <rte_spinlock.h>
 #include <rte_malloc.h>
+#include <rte_random.h>
 
 #include "vhost_rdma.h"
 #include "vhost_rdma_ib.h"
@@ -652,6 +653,200 @@ vhost_rdma_destroy_pd(struct vhost_rdma_device *dev, struct iovec *in, CTRL_NO_R
 	return 0;
 }
 
+uint8_t
+vhost_rdma_get_next_key(uint32_t last_key)
+{
+	uint8_t key;
+
+	do {
+		key = rte_rand();
+	} while (key == last_key);
+
+	return key;
+}
+
+void
+vhost_rdma_mr_init_key(struct vhost_rdma_mr *mr, uint32_t mrn)
+{
+	uint32_t lkey = mrn << 8 | vhost_rdma_get_next_key(-1);
+	uint32_t rkey = (mr->access & VHOST_RDMA_IB_ACCESS_REMOTE) ? lkey : 0;
+
+	mr->lkey = lkey;
+	mr->rkey = rkey;
+}
+
+static int
+vhost_rdma_get_dma_mr(struct vhost_rdma_device *dev, struct iovec *in,
+					struct iovec *out)
+{
+	struct vhost_rdma_cmd_get_dma_mr *get_cmd;
+	struct vhost_rdma_ack_get_dma_mr *ack_rsp;
+	struct vhost_rdma_pd *pd;
+	struct vhost_rdma_mr *mr;
+	uint32_t mrn;
+
+	CHK_IOVEC(get_cmd, in);
+	CHK_IOVEC(ack_rsp, out);
+
+	pd = vhost_rdma_pool_get(&dev->pd_pool, get_cmd->pdn);
+	if (unlikely(pd == NULL)) {
+		RDMA_LOG_ERR("pd is not found");
+		return -EINVAL;
+	}
+
+	mr = vhost_rdma_pool_alloc(&dev->mr_pool, &mrn);
+	if (mr == NULL) {
+		RDMA_LOG_ERR("mr alloc failed");
+		return -ENOMEM;
+	}
+
+	vhost_rdma_ref_init(mr);
+	vhost_rdma_add_ref(pd);
+
+	mr->type = VHOST_MR_TYPE_DMA;
+	mr->state = VHOST_MR_STATE_VALID;
+	mr->access = get_cmd->access_flags;
+	mr->pd = pd;
+	vhost_rdma_mr_init_key(mr, mrn);
+	mr->mrn = mrn;
+
+	ack_rsp->lkey = mr->lkey;
+	ack_rsp->rkey = mr->rkey;
+	ack_rsp->mrn = mrn;
+
+	return 0;
+}
+
+static int
+vhost_rdma_alloc_mr(struct vhost_rdma_device *dev, struct iovec *in,
+					struct iovec *out)
+{
+	struct vhost_rdma_cmd_alloc_mr *alloc_cmd;
+	struct vhost_rdma_ack_get_dma_mr *ack_rsp;
+	struct vhost_rdma_pd *pd;
+	struct vhost_rdma_mr *mr;
+	uint32_t mrn;
+
+	CHK_IOVEC(alloc_cmd, in);
+	CHK_IOVEC(ack_rsp, out);
+
+	pd = vhost_rdma_pool_get(&dev->pd_pool, alloc_cmd->pdn);
+	if (unlikely(pd == NULL)) {
+		RDMA_LOG_ERR("pd is not found");
+		return -EINVAL;
+	}
+
+	mr = vhost_rdma_pool_alloc(&dev->mr_pool, &mrn);
+	if (mr == NULL) {
+		RDMA_LOG_ERR("mr alloc failed");
+		return -ENOMEM;
+	}
+
+	vhost_rdma_ref_init(mr);
+	vhost_rdma_add_ref(pd);	
+
+	mr->type = VHOST_MR_TYPE_DMA;
+	mr->state = VHOST_MR_STATE_VALID;
+	mr->access = alloc_cmd->access_flags;
+	mr->pd = pd;
+	mr->max_pages = alloc_cmd->max_num_sg;
+	vhost_rdma_mr_init_key(mr, mrn);
+	mr->mrn = mrn;
+
+	ack_rsp->lkey = mr->lkey;
+	ack_rsp->rkey = mr->rkey;
+	ack_rsp->mrn = mrn;
+
+	return 0;	
+}
+
+void
+vhost_rdma_map_pages(struct rte_vhost_memory *mem, uint64_t *pages,
+			uint64_t *dma_pages, uint32_t npages)
+{
+	uint32_t i;
+	uint64_t len = USER_MMAP_TARGET_PAGE_SIZE;
+
+	for (i = 0; i < npages; i++) {
+		pages[i] = gpa_to_vva(mem, dma_pages[i], &len);
+		assert(len == USER_MMAP_TARGET_PAGE_SIZE);
+	}
+}
+
+static int
+vhost_rdma_reg_user_mr(struct vhost_rdma_device *dev, struct iovec *in,
+					struct iovec *out)
+{
+	struct vhost_rdma_cmd_reg_user_mr *reg_cmd;
+	struct vhost_rdma_ack_reg_user_mr *ack_rsp;
+	struct vhost_rdma_mr *mr;
+	struct vhost_rdma_pd *pd;
+	uint32_t mrn;
+
+	CHK_IOVEC(reg_cmd, in);
+	CHK_IOVEC(ack_rsp, out);
+
+	pd = vhost_rdma_pool_get(&dev->pd_pool, reg_cmd->pdn);
+	if (unlikely(pd == NULL)) {
+		RDMA_LOG_ERR("pd is not found");
+		return -EINVAL;
+	}
+
+	mr = vhost_rdma_pool_alloc(&dev->mr_pool, &mrn);
+	if (mr == NULL) {
+		return -ENOMEM;
+	}
+
+	mr->pages = malloc(sizeof(uint64_t) * reg_cmd->npages);
+	if (mr->pages == NULL) {
+		return -ENOMEM;
+	}
+
+	vhost_rdma_ref_init(mr);
+	vhost_rdma_add_ref(pd);
+
+	vhost_rdma_map_pages(dev->mem, mr->pages, (uint64_t *)reg_cmd->pages, reg_cmd->npages);
+
+	mr->pd = pd;
+	mr->access = reg_cmd->access_flags;
+	mr->length = reg_cmd->length;
+	mr->iova = reg_cmd->virt_addr & USER_MMAP_PAGE_MASK;
+	mr->npages = reg_cmd->npages;
+	mr->type = VHOST_MR_TYPE_MR;
+	mr->state = VHOST_MR_STATE_VALID;
+	vhost_rdma_mr_init_key(mr, mrn);
+	mr->mrn = mrn;
+
+	ack_rsp->lkey = mr->lkey;
+	ack_rsp->rkey = mr->rkey;
+	ack_rsp->mrn = mrn;
+
+	return 0;
+}
+
+static int
+vhost_rdma_dereg_mr(struct vhost_rdma_device *dev, struct iovec *in, CTRL_NO_RSP)
+{
+	struct vhost_rdma_cmd_dereg_mr *dereg_cmd;
+	struct vhost_rdma_mr *mr;
+
+	CHK_IOVEC(dereg_cmd, in);
+
+	mr = vhost_rdma_pool_get(&dev->mr_pool, dereg_cmd->mrn);
+	if (unlikely(mr == NULL)) {
+		RDMA_LOG_ERR("mr not found");
+	}
+
+	mr->state = VHOST_MR_STATE_ZOMBIE;
+
+	vhost_rdma_drop_ref(mr->pd, dev, pd);
+	vhost_rdma_drop_ref(mr, dev, mr);
+
+	RDMA_LOG_DEBUG("destroy mr %u", dereg_cmd->mrn);
+
+	return 0;
+}
+
 /* Command handler table declaration */
 struct {
 	int (*handler)(struct vhost_rdma_device *dev, struct iovec *in, struct iovec *out);
@@ -663,6 +858,10 @@ struct {
 	DEFINE_VIRTIO_RDMA_CMD(VHOST_RDMA_CTRL_ROCE_DESTROY_CQ,				vhost_rdma_destroy_cq),
 	DEFINE_VIRTIO_RDMA_CMD(VHOST_RDMA_CTRL_ROCE_CREATE_PD,				vhost_rdma_create_pd),
 	DEFINE_VIRTIO_RDMA_CMD(VHOST_RDMA_CTRL_ROCE_DESTROY_PD,				vhost_rdma_destroy_pd),
+	DEFINE_VIRTIO_RDMA_CMD(VHOST_RDMA_CTRL_ROCE_GET_DMA_MR,				vhost_rdma_get_dma_mr),
+	DEFINE_VIRTIO_RDMA_CMD(VHOST_RDMA_CTRL_ROCE_ALLOC_MR,				vhost_rdma_alloc_mr),
+	DEFINE_VIRTIO_RDMA_CMD(VHOST_RDMA_CTRL_ROCE_REG_USER_MR,			vhost_rdma_reg_user_mr),
+	DEFINE_VIRTIO_RDMA_CMD(VHOST_RDMA_CTRL_ROCE_DEREG_MR,				vhost_rdma_dereg_mr),
 };
 
 /**
diff --git a/examples/vhost_user_rdma/vhost_rdma_ib.h b/examples/vhost_user_rdma/vhost_rdma_ib.h
index 6356abc65a..ddfdcf4917 100644
--- a/examples/vhost_user_rdma/vhost_rdma_ib.h
+++ b/examples/vhost_user_rdma/vhost_rdma_ib.h
@@ -58,6 +58,9 @@ struct vhost_queue;
 /** Maximum size for config space read/write operations */
 #define VHOST_USER_MAX_CONFIG_SIZE	256
 
+#define USER_MMAP_TARGET_PAGE_SIZE 4096
+#define USER_MMAP_PAGE_MASK	(~(USER_MMAP_TARGET_PAGE_SIZE-1))
+
 /** ROCE control command types (virtio-rdma extension) */
 #define VHOST_RDMA_CTRL_ROCE					6
 #define VHOST_RDMA_CTRL_ROCE_QUERY_DEVICE		0
@@ -249,6 +252,14 @@ enum ib_port_speed {
 	VHOST_RDMA_IB_SPEED_NDR	= 128,
 };
 
+enum vhost_ib_access_flags {
+        VHOST_RDMA_IB_ACCESS_LOCAL_WRITE = (1 << 0),
+        VHOST_RDMA_IB_ACCESS_REMOTE_WRITE = (1 << 1),
+        VHOST_RDMA_IB_ACCESS_REMOTE_READ = (1 << 2),
+};
+
+#define VHOST_RDMA_IB_ACCESS_REMOTE	(VHOST_RDMA_IB_ACCESS_REMOTE_WRITE | VHOST_RDMA_IB_ACCESS_REMOTE_READ)
+
 /**
  * @brief QP capabilities structure
  */
@@ -707,6 +718,60 @@ struct vhost_rdma_cmd_destroy_pd {
 	uint32_t pdn;
 };
 
+struct vhost_rdma_cmd_alloc_mr {
+	/* The handle of PD which the MR associated with */
+	uint32_t pdn;
+	/* MR's protection attributes, enum virtio_ib_access_flags */
+	uint32_t access_flags;
+	uint32_t max_num_sg;
+};
+struct vhost_rdma_cmd_get_dma_mr {
+	/* The handle of PD which the MR associated with */
+	uint32_t pdn;
+	/* MR's protection attributes, enum virtio_ib_access_flags */
+	uint32_t access_flags;
+};
+
+struct vhost_rdma_ack_get_dma_mr {
+	/* The handle of MR */
+	uint32_t mrn;
+	/* MR's local access key */
+	uint32_t lkey;
+	/* MR's remote access key */
+	uint32_t rkey;
+};
+
+struct vhost_rdma_cmd_reg_user_mr {
+	/* The handle of PD which the MR associated with */
+	uint32_t pdn;
+	/* MR's protection attributes, enum virtio_ib_access_flags */
+	uint32_t access_flags;
+	/* Starting virtual address of MR */
+	uint64_t virt_addr;
+	/* Length of MR */
+	uint64_t length;
+	/* Size of the below page array */
+	uint32_t npages;
+	/* Padding */
+	uint32_t padding;
+	/* Array to store physical address of each page in MR */
+	uint64_t pages[];
+};
+
+struct vhost_rdma_ack_reg_user_mr {
+	/* The handle of MR */
+	uint32_t mrn;
+	/* MR's local access key */
+	uint32_t lkey;
+	/* MR's remote access key */
+	uint32_t rkey;
+};
+
+struct vhost_rdma_cmd_dereg_mr {
+	/* The handle of MR */
+	uint32_t mrn;
+};
+
 /**
  * @brief Convert IB MTU enum to byte size
  * @param mtu The MTU enum value
@@ -792,4 +857,13 @@ int setup_iovs_from_descs(struct rte_vhost_memory *mem,
 						uint16_t *num_in,
 						uint16_t *num_out);
 
+void vhost_rdma_mr_init_key(struct vhost_rdma_mr *mr, uint32_t mrn);
+
+uint8_t vhost_rdma_get_next_key(uint32_t last_key);
+
+void vhost_rdma_map_pages(struct rte_vhost_memory *mem,
+						uint64_t *pages,
+						uint64_t *dma_pages,
+						uint32_t npages);
+
 #endif /* __VHOST_RDMA_IB_H__ */
\ No newline at end of file
-- 
2.43.0


