Return-Path: <netdev+bounces-245079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2DCCC6A74
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 09:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15F993098F95
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 08:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227A833D6FE;
	Wed, 17 Dec 2025 08:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gZYuz1ic"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9D41ADC7E;
	Wed, 17 Dec 2025 08:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765961121; cv=none; b=hNynx/PfBwgJQCUiuhEGZeSd/a3pfknKcAF5BpuRxn5YrUjNRI9AnNYbs44Fme93+pVzKMzscOMrcQ47GgPZDJ8M6Gu0BTI+XmBcIBGlfWJLxZT0HbIFmboFqkc7tdtBZD2gpH4CgJIcwaoeaIUToZ3WGXUnS1D82dVPRU9kxU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765961121; c=relaxed/simple;
	bh=z0lgb7rgJbm1RfigLdTLISdPsQ8KwEbEx2rsk2Pfm3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cyy1OYRMCKqHqdQen7KV5mtbwAe1VP4pNw2F+3Eyq+y04kmxfsHmAWfbCfNgjEpJAQD5HhuQ8SmyyeS0ZFtiy5PYERdt2Vp+/cgmcAXmLieFqdl6M8AMHvmQ7GTK59OJHXelM/r6yBp7LKGs+b5g0CzpEgf/9K1kbxuVyzwbetI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gZYuz1ic; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=m1
	LFrB3NFOeqkema1TABlsZ/L66lOJECpIbkhit4Npk=; b=gZYuz1icpqf4/Ex4on
	2QklVHglBmJu0vc0o5hSHj/o9iX2kYNrYUxt0ZBjig9PI+vkuOGkCwB7KhB15dXA
	gUZGOvggvKd5igE7RiCW7+oyM8n0pDPFFDsAHZwqBy8WUJ+zf+nmRucoT5cUl4Dl
	FOTLWr1uFizW1+6OPsx6Y3YHA=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDnwYJnbUJpSC+YAw--.48902S11;
	Wed, 17 Dec 2025 16:44:27 +0800 (CST)
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
Subject: [PATCH 06/14] examples/vhost_user_rdma: implement comprehensive queue pair lifecycle management
Date: Wed, 17 Dec 2025 16:43:32 +0800
Message-ID: <20251217084422.4875-8-15927021679@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251217084422.4875-1-15927021679@163.com>
References: <20251217084422.4875-1-15927021679@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnwYJnbUJpSC+YAw--.48902S11
X-Coremail-Antispam: 1Uf129KBjvAXoWkGryfJrykZw4DXF4DGF1xXwb_yoWkKFyrAo
	Z5Ja4UtFWvywsrCw1jkryDta9Fyw1qgF48ZF1Fy3y2kFZxJw4DXr1FkFWUWw15Ar1Sya47
	CrnxJ34fKr48ZFn8n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU2db1UUUUU
X-CM-SenderInfo: jprvmjixqsilmxzbiqqrwthudrp/xtbC0gtg6GlCbWtyowAA3t

From: xiongweimin <xiongweimin@kylinos.cn>

This commit adds core functionality for managing RDMA Queue Pairs (QPs):
1. QP creation with type-specific handling (RC/UC/UD/GSI)
2. QP state modification and validation
3. QP attribute querying
4. QP destruction with resource cleanup
5. Address vector to attribute conversion

Key features:
- Special handling for General Service Interface (GSI) QPs
- Detailed QP state tracking (RESET, INIT, RTR, RTS, SQD, ERROR)
- Timer management for reliable connections (retransmit, RNR NAK)
- Virtual queue initialization and cleanup
- Atomic reference counting for lifecycle management
- Comprehensive attribute reporting for QP query

Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
Change-Id: I6bc5d82867e49ac1bfd83993b28620f91f17ce4f
---
 examples/vhost_user_rdma/meson.build         |    2 +
 examples/vhost_user_rdma/vhost_rdma.h        |   70 +-
 examples/vhost_user_rdma/vhost_rdma_ib.c     |  284 ++++-
 examples/vhost_user_rdma/vhost_rdma_ib.h     |  255 ++++-
 examples/vhost_user_rdma/vhost_rdma_opcode.c |  894 +++++++++++++++
 examples/vhost_user_rdma/vhost_rdma_opcode.h |  330 ++++++
 examples/vhost_user_rdma/vhost_rdma_pkt.h    |  238 ----
 examples/vhost_user_rdma/vhost_rdma_queue.c  | 1056 ++++++++++++++++++
 examples/vhost_user_rdma/vhost_rdma_queue.h  |  338 ++++++
 9 files changed, 3169 insertions(+), 298 deletions(-)
 create mode 100644 examples/vhost_user_rdma/vhost_rdma_opcode.c
 create mode 100644 examples/vhost_user_rdma/vhost_rdma_opcode.h
 create mode 100644 examples/vhost_user_rdma/vhost_rdma_queue.c
 create mode 100644 examples/vhost_user_rdma/vhost_rdma_queue.h

diff --git a/examples/vhost_user_rdma/meson.build b/examples/vhost_user_rdma/meson.build
index d6ccaf32a4..a032a27767 100644
--- a/examples/vhost_user_rdma/meson.build
+++ b/examples/vhost_user_rdma/meson.build
@@ -41,5 +41,7 @@ sources = files(
     'main.c',
     'vhost_rdma.c',
     'vhost_rdma_ib.c',
+    'vhost_rdma_queue.c',
+    'vhost_rdma_opcode.c',
 )
 
diff --git a/examples/vhost_user_rdma/vhost_rdma.h b/examples/vhost_user_rdma/vhost_rdma.h
index c1531d1a7a..980bb74beb 100644
--- a/examples/vhost_user_rdma/vhost_rdma.h
+++ b/examples/vhost_user_rdma/vhost_rdma.h
@@ -16,6 +16,7 @@
 
 #include <stdint.h>
 #include <stdbool.h>
+#include <netinet/in.h>
 
 #include <rte_byteorder.h>
 #include <rte_common.h>
@@ -26,6 +27,7 @@
 #include <rte_mempool.h>
 #include <rte_ring.h>
 #include <rte_bitmap.h>
+#include <rte_mbuf.h>
 
 #include "vhost_rdma_ib.h"
 #include "eal_interrupts.h"
@@ -106,6 +108,25 @@ enum vhost_rdma_counters {
 	VHOST_RDMA_NUM_OF_COUNTERS
 };
 
+enum vhost_rdma_network_type {
+	VHOST_RDMA_NETWORK_IB,
+	VHOST_RDMA_NETWORK_ROCE_V1,
+	VHOST_RDMA_NETWORK_IPV4,
+	VHOST_RDMA_NETWORK_IPV6
+};
+
+enum {
+	VHOST_NETWORK_TYPE_IPV4 = 1,
+	VHOST_NETWORK_TYPE_IPV6 = 2,
+};
+
+enum vhost_rdma_ib_gid_type {
+	VHOST_RDMA_IB_GID_TYPE_IB,
+	VHOST_RDMA_IB_GID_TYPE_ROCE,
+	VHOST_RDMA_IB_GID_TYPE_ROCE_UDP_ENCAP,
+	VHOST_RDMA_IB_GID_TYPE_SIZE
+};
+
 struct vhost_rdma_net_dev {
 	int vid;
 	uint64_t features;
@@ -299,21 +320,6 @@ vhost_rdma_vq_is_avail(struct vhost_user_queue *vq)
 	return vq->vring.avail->idx != vq->last_avail_idx;
 }
 
-/**
- * @brief Get pointer to element at given index in a generic data ring.
- *
- * Used for accessing pre-allocated memory pools where each element has fixed size.
- *
- * @param queue	 Pointer to the queue containing data buffer.
- * @param idx	   Index of the desired element.
- * @return		  Pointer to the data at position idx.
- */
-static __rte_always_inline void *
-vhost_rdma_queue_get_data(struct vhost_rdma_queue *queue, size_t idx)
-{
-	return queue->data + queue->elem_size * idx;
-}
-
 /**
  * @brief Retrieve the next available descriptor index from the avail ring.
  *
@@ -417,6 +423,40 @@ gpa_to_vva(struct rte_vhost_memory *mem, uint64_t gpa, uint64_t *len)
 	return rte_vhost_va_from_guest_pa(mem, gpa, len);
 }
 
+static inline bool ipv6_addr_v4mapped(const struct in6_addr *a)
+{
+	return IN6_IS_ADDR_V4MAPPED(a);
+}
+
+static inline void rdma_gid2ip(struct sockaddr *out, uint8_t *gid)
+{
+	if (ipv6_addr_v4mapped((struct in6_addr *)gid)) {
+		struct sockaddr_in *out_in = (struct sockaddr_in *)out;
+		memset(out_in, 0, sizeof(*out_in));
+		out_in->sin_family = AF_INET;
+		rte_memcpy(&out_in->sin_addr.s_addr, gid + 12, 4);
+	} else {
+		struct sockaddr_in6 *out_in = (struct sockaddr_in6 *)out;
+		memset(out_in, 0, sizeof(*out_in));
+		out_in->sin6_family = AF_INET6;
+		rte_memcpy(&out_in->sin6_addr.s6_addr, gid, 16);
+	}
+}
+
+static inline enum vhost_rdma_network_type rdma_gid_attr_network_type(const struct vhost_rdma_gid *attr)
+{
+	if (attr->type == VHOST_RDMA_IB_GID_TYPE_IB)
+		return VHOST_RDMA_NETWORK_IB;
+
+	if (attr->type == VHOST_RDMA_IB_GID_TYPE_ROCE)
+		return VHOST_RDMA_NETWORK_ROCE_V1;
+
+	if (ipv6_addr_v4mapped((struct in6_addr *)&attr->gid))
+		return VHOST_RDMA_NETWORK_IPV4;
+	else
+		return VHOST_RDMA_NETWORK_IPV6;
+}
+
 int vhost_rdma_construct(struct vhost_rdma_device *dev, const char *path, int idx);
 void vhost_rdma_net_construct(struct vhost_user_queue *queues, int idx);
 void vs_vhost_rdma_net_setup(int vid);
diff --git a/examples/vhost_user_rdma/vhost_rdma_ib.c b/examples/vhost_user_rdma/vhost_rdma_ib.c
index 3002498151..aac5c28e9a 100644
--- a/examples/vhost_user_rdma/vhost_rdma_ib.c
+++ b/examples/vhost_user_rdma/vhost_rdma_ib.c
@@ -1,5 +1,5 @@
 /*
- * Vhost-user RDMA device : init and packets forwarding
+ * Vhost-user RDMA device : Main function of rdma device
  *
  * Copyright (C) 2025 KylinSoft Inc. and/or its affiliates. All rights reserved.
  *
@@ -24,6 +24,8 @@
 #include "vhost_rdma_ib.h"
 #include "vhost_rdma_log.h"
 #include "vhost_rdma_pkt.h"
+#include "vhost_rdma_queue.h"
+#include "vhost_rdma_opcode.h"
 
 #define CHK_IOVEC(tp, iov) \
 	do { \
@@ -39,6 +41,22 @@
 #define CTRL_NO_CMD __rte_unused struct iovec *__in
 #define CTRL_NO_RSP __rte_unused struct iovec *__out
 
+int alloc_rd_atomic_resources(struct vhost_rdma_qp *qp, unsigned int n)
+{
+	qp->resp.res_head = 0;
+	qp->resp.res_tail = 0;
+
+	if (n == 0) {
+		qp->resp.resources = NULL;
+	} else {
+		qp->resp.resources = rte_zmalloc(NULL, sizeof(struct vhost_rdma_resp_res) * n, 0);
+		if (!qp->resp.resources)
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
 /**
  * @brief Free resources held by a response entry in the RDMA responder path.
  *
@@ -134,23 +152,6 @@ free_rd_atomic_resources(struct vhost_rdma_qp *qp)
 	RDMA_LOG_DEBUG("Successfully freed response resource array for QP %u", qp->qpn);
 }
 
-
-/**
- * @brief Clean up a vhost RDMA queue.
- */
-void
-vhost_rdma_queue_cleanup(struct vhost_rdma_qp *qp, struct vhost_rdma_queue *queue)
-{
-	if (!queue)
-		return;
-
-	if (queue->cb && qp)
-		rte_intr_callback_unregister(&queue->intr_handle, queue->cb, qp);
-
-	rte_free(queue->data);
-	queue->data = NULL;
-}
-
 /**
  * @brief Cleanup callback for MR: reset type.
  */
@@ -493,7 +494,7 @@ setup_iovs_from_descs(struct rte_vhost_memory *mem,
 			out++; /* Descriptor allows read (output) */
 		}
 
-		/* Translate payload (address + length) into iovec(s) */
+		/* Translate payload (address length) into iovec(s) */
 		if (desc_payload_to_iovs(mem, iovs, 
 							&iovs_idx, 
 							desc->addr, 
@@ -847,6 +848,247 @@ vhost_rdma_dereg_mr(struct vhost_rdma_device *dev, struct iovec *in, CTRL_NO_RSP
 	return 0;
 }
 
+/**
+* vhost_rdma_create_qp - Create a Queue Pair (QP) for vhost RDMA device
+* @dev:      Pointer to the vhost RDMA device
+* @in:       Input iovec containing command from userspace
+* @out:      Output iovec for returning response to userspace
+*
+* This function handles the creation of a QP based on the requested type.
+* It allocates resources, initializes the QP, and returns the assigned QPN.
+*
+* Returns 0 on success, or a negative error code on failure.
+*/
+static int
+vhost_rdma_create_qp(struct vhost_rdma_device *dev,
+					struct iovec *in,
+					struct iovec *out)
+{
+	struct vhost_rdma_cmd_create_qp *create_cmd;
+	struct vhost_rdma_ack_create_qp *ack_rsp;
+	struct vhost_rdma_qp *qp = NULL;
+	uint32_t qpn;
+	int ret = 0;
+
+	/* Validate input parameters */
+	if (!dev || !in || !out) {
+	RDMA_LOG_ERR("Invalid argument: null pointer detected");
+	return -EINVAL;
+	}
+
+	/* Safely map iovec buffers to command and response structures */
+	CHK_IOVEC(create_cmd, in);
+	CHK_IOVEC(ack_rsp, out);
+
+	/* Handle different QP types */
+	switch (create_cmd->qp_type) {
+	case VHOST_RDMA_IB_QPT_GSI:
+	/* Only one GSI QP is allowed, check if already created */
+	if (dev->qp_gsi->valid) {
+	    RDMA_LOG_ERR("GSI QP already exists, cannot create duplicate");
+	    return -EINVAL;
+	}
+	qp = dev->qp_gsi;          /* Use pre-allocated GSI QP */
+	qpn = VHOST_RDMA_GSI_QPN;  /* Assign well-known QPN (e.g., 1) */
+	break;
+
+	case VHOST_RDMA_IB_QPT_RC:
+	case VHOST_RDMA_IB_QPT_UD:
+	case VHOST_RDMA_IB_QPT_UC:
+	/* Allocate QP from pool for reliable/unordered connection types */
+	qp = vhost_rdma_pool_alloc(&dev->qp_pool, &qpn);
+	if (!qp) {
+	    RDMA_LOG_ERR("Failed to allocate QP from pool for type %d",
+		    create_cmd->qp_type);
+	    return -ENOMEM;
+	}
+	break;
+
+	default:
+	/* Unsupported QP type */
+	RDMA_LOG_ERR("Unsupported QP type %d", create_cmd->qp_type);
+	return -EINVAL;
+	}
+
+	/* Initialize reference counter for the newly acquired QP */
+	vhost_rdma_ref_init(qp);
+
+	/* Set QP number */
+	qp->qpn = qpn;
+
+	/* Initialize QP internal state (queues, CQ bindings, etc.) */
+	if (vhost_rdma_qp_init(dev, qp, create_cmd)) {
+	RDMA_LOG_ERR("Failed to initialize QP %u", qpn);
+	ret = -EINVAL;
+	goto err_qp_init;
+	}
+
+	/* Populate acknowledgment response with allocated QPN */
+	ack_rsp->qpn = qpn;
+
+	/* Log successful QP creation with key attributes */
+	RDMA_LOG_INFO("Created QP %u | Type=%d | SQ_VQ_ID=%u | RQ_VQ_ID=%u | "
+	          "Send_CQN=%u | Recv_CQN=%u",
+	          qp->qpn, create_cmd->qp_type,
+	          qp->sq.queue.vq->id,
+	          qp->rq.queue.vq->id,
+	          create_cmd->send_cqn,
+	          create_cmd->recv_cqn);
+
+	return 0;
+
+err_qp_init:
+	/* Clean up reference on initialization failure */
+	vhost_rdma_drop_ref(qp, dev, qp);
+	return ret;
+}
+
+static int
+vhost_rdma_modify_qp(struct vhost_rdma_device *dev, struct iovec *in, CTRL_NO_RSP)
+{
+	struct vhost_rdma_cmd_modify_qp *cmd;
+	struct vhost_rdma_qp *qp;
+	int err;
+
+	CHK_IOVEC(cmd, in);
+
+	qp = vhost_rdma_pool_get(&dev->qp_pool, cmd->qpn);
+	if (unlikely(qp == NULL)) {
+		RDMA_LOG_ERR("qp not found");
+	}
+
+	// FIXME: check in driver?
+	err = vhost_rdma_qp_validate(dev, qp, cmd);
+	if (err)
+		goto err;
+
+	err = vhost_rdma_qp_modify(dev, qp, cmd);
+	if (err)
+		goto err;
+
+	return 0;
+
+err:
+	return err;
+}
+
+void vhost_rdma_av_to_attr(struct vhost_rdma_av *av,
+				  struct vhost_rdma_ah_attr *attr)
+{
+	struct vhost_rdma_global_route *grh = &attr->grh;
+
+	rte_memcpy(grh->dgid, av->grh.dgid, sizeof(av->grh.dgid));
+	grh->flow_label = av->grh.flow_label;
+	grh->sgid_index = av->grh.sgid_index;
+	grh->hop_limit = av->grh.hop_limit;
+	grh->traffic_class = av->grh.traffic_class;
+	rte_memcpy(attr->dmac, av->dmac, ETH_ALEN);
+}
+
+int vhost_rdma_qp_query(struct vhost_rdma_qp *qp,
+						struct vhost_rdma_ack_query_qp *rsp)
+{
+	rsp->qp_state = qp->attr.qp_state;
+	rsp->path_mtu = qp->attr.path_mtu;
+	rsp->max_rd_atomic = qp->attr.max_rd_atomic;
+	rsp->max_dest_rd_atomic = qp->attr.max_dest_rd_atomic;
+	rsp->min_rnr_timer = qp->attr.min_rnr_timer;
+	rsp->timeout = qp->attr.timeout;
+	rsp->retry_cnt = qp->attr.retry_cnt;
+	rsp->rnr_retry = qp->attr.rnr_retry;
+	rsp->qkey = qp->attr.qkey;
+	rsp->dest_qp_num = qp->attr.dest_qp_num;
+	rsp->qp_access_flags = qp->attr.qp_access_flags;
+	rsp->rate_limit = qp->attr.rate_limit;
+
+	rsp->rq_psn = qp->resp.psn;
+	rsp->sq_psn = qp->req.psn;
+
+	rsp->cap.max_send_wr = qp->attr.cap.max_send_wr;
+	rsp->cap.max_send_sge = qp->attr.cap.max_send_sge;
+	rsp->cap.max_inline_data = qp->attr.cap.max_inline_data;
+	rsp->cap.max_recv_wr = qp->attr.cap.max_recv_wr;
+	rsp->cap.max_recv_sge = qp->attr.cap.max_recv_sge;
+
+	vhost_rdma_av_to_attr(&qp->av, &rsp->ah_attr);
+
+	if (qp->req.state == QP_STATE_DRAIN) {
+		rsp->sq_draining = 1;
+	} else {
+		rsp->sq_draining = 0;
+	}
+	return 0;	
+}
+
+static int
+vhost_rdma_query_qp(struct vhost_rdma_device *dev, 
+					struct iovec *in,
+					struct iovec *out)
+{
+	struct vhost_rdma_cmd_query_qp *cmd;
+	struct vhost_rdma_ack_query_qp *rsp;
+	struct vhost_rdma_qp *qp;
+
+	CHK_IOVEC(cmd, in);
+	CHK_IOVEC(rsp, out);
+
+	qp = vhost_rdma_pool_get(&dev->qp_pool, cmd->qpn);
+	vhost_rdma_qp_query(qp, rsp);
+
+	return 0;
+}
+
+void vhost_rdma_qp_destroy(struct vhost_rdma_qp *qp)
+{
+	qp->valid = 0;
+	qp->qp_timeout_ticks = 0;
+	vhost_rdma_cleanup_task(&qp->resp.task);
+
+	if (qp->type == VHOST_RDMA_IB_QPT_RC) {
+		rte_timer_stop_sync(&qp->retrans_timer);
+		rte_timer_stop_sync(&qp->rnr_nak_timer);
+	}
+
+	vhost_rdma_cleanup_task(&qp->req.task);
+	vhost_rdma_cleanup_task(&qp->comp.task);
+
+	/* flush out any receive wr's or pending requests */
+	__vhost_rdma_do_task(&qp->req.task);
+	if (qp->sq.queue.vq) {
+		__vhost_rdma_do_task(&qp->comp.task);
+		__vhost_rdma_do_task(&qp->req.task);
+	}
+
+	vhost_rdma_queue_cleanup(qp, &qp->sq.queue);
+	vhost_rdma_queue_cleanup(qp, &qp->rq.queue);
+
+	qp->sq.queue.vq->last_avail_idx = 0;
+	qp->sq.queue.vq->last_used_idx = 0;
+	qp->rq.queue.vq->last_avail_idx = 0;
+	qp->rq.queue.vq->last_used_idx = 0;
+
+	rte_free(qp->req_pkts);
+	rte_free(qp->resp_pkts);    
+}
+
+static int
+vhost_rdma_destroy_qp(struct vhost_rdma_device *dev, struct iovec *in, CTRL_NO_RSP)
+{
+	struct vhost_rdma_cmd_destroy_qp *cmd;
+	struct vhost_rdma_qp* qp;
+
+	CHK_IOVEC(cmd, in);
+
+	qp = vhost_rdma_pool_get(&dev->qp_pool, cmd->qpn);
+
+	vhost_rdma_qp_destroy(qp);
+
+	if (qp->type != VHOST_RDMA_IB_QPT_GSI)
+		vhost_rdma_drop_ref(qp, dev, qp);
+
+	return 0;
+}
+
 /* Command handler table declaration */
 struct {
 	int (*handler)(struct vhost_rdma_device *dev, struct iovec *in, struct iovec *out);
@@ -862,6 +1104,10 @@ struct {
 	DEFINE_VIRTIO_RDMA_CMD(VHOST_RDMA_CTRL_ROCE_ALLOC_MR,				vhost_rdma_alloc_mr),
 	DEFINE_VIRTIO_RDMA_CMD(VHOST_RDMA_CTRL_ROCE_REG_USER_MR,			vhost_rdma_reg_user_mr),
 	DEFINE_VIRTIO_RDMA_CMD(VHOST_RDMA_CTRL_ROCE_DEREG_MR,				vhost_rdma_dereg_mr),
+	DEFINE_VIRTIO_RDMA_CMD(VHOST_RDMA_CTRL_ROCE_CREATE_QP,				vhost_rdma_create_qp),
+	DEFINE_VIRTIO_RDMA_CMD(VHOST_RDMA_CTRL_ROCE_MODIFY_QP,				vhost_rdma_modify_qp),
+	DEFINE_VIRTIO_RDMA_CMD(VHOST_RDMA_CTRL_ROCE_QUERY_QP,				vhost_rdma_query_qp),
+	DEFINE_VIRTIO_RDMA_CMD(VHOST_RDMA_CTRL_ROCE_DESTROY_QP,				vhost_rdma_destroy_qp),
 };
 
 /**
diff --git a/examples/vhost_user_rdma/vhost_rdma_ib.h b/examples/vhost_user_rdma/vhost_rdma_ib.h
index ddfdcf4917..79575e735c 100644
--- a/examples/vhost_user_rdma/vhost_rdma_ib.h
+++ b/examples/vhost_user_rdma/vhost_rdma_ib.h
@@ -20,6 +20,7 @@
 
 #include <netinet/in.h>
 #include <linux/virtio_net.h>
+#include <linux/vhost_types.h>
 
 #include <rte_spinlock.h>
 #include <rte_atomic.h>
@@ -27,7 +28,7 @@
 #include <rte_mbuf.h>
 #include <rte_ring.h>
 #include <rte_vhost.h>
-#include <linux/vhost_types.h>
+#include <rte_interrupts.h>
 
 #include "eal_interrupts.h"
 
@@ -61,6 +62,8 @@ struct vhost_queue;
 #define USER_MMAP_TARGET_PAGE_SIZE 4096
 #define USER_MMAP_PAGE_MASK	(~(USER_MMAP_TARGET_PAGE_SIZE-1))
 
+#define VHOST_RDMA_GSI_QPN 1
+
 /** ROCE control command types (virtio-rdma extension) */
 #define VHOST_RDMA_CTRL_ROCE					6
 #define VHOST_RDMA_CTRL_ROCE_QUERY_DEVICE		0
@@ -121,6 +124,14 @@ struct vhost_rdma_ack_query_device {
 		uint32_t reserved[14];
 };
 
+enum vhost_rdma_qp_state {
+	QP_STATE_RESET,
+	QP_STATE_INIT,
+	QP_STATE_READY,
+	QP_STATE_DRAIN,		/* req only */
+	QP_STATE_DRAINED,	/* req only */
+	QP_STATE_ERROR
+};
 
 /**
  * @defgroup qp_states Queue Pair States
@@ -252,25 +263,43 @@ enum ib_port_speed {
 	VHOST_RDMA_IB_SPEED_NDR	= 128,
 };
 
+enum vhost_rdma_ib_qp_attr_mask {
+	VHOST_RDMA_IB_QP_STATE			= 1,
+	VHOST_RDMA_IB_QP_CUR_STATE			= (1<<1),
+	VHOST_RDMA_IB_QP_EN_SQD_ASYNC_NOTIFY	= (1<<2),
+	VHOST_RDMA_IB_QP_ACCESS_FLAGS		= (1<<3),
+	VHOST_RDMA_IB_QP_PKEY_INDEX		= (1<<4),
+	VHOST_RDMA_IB_QP_PORT			= (1<<5),
+	VHOST_RDMA_IB_QP_QKEY			= (1<<6),
+	VHOST_RDMA_IB_QP_AV			= (1<<7),
+	VHOST_RDMA_IB_QP_PATH_MTU			= (1<<8),
+	VHOST_RDMA_IB_QP_TIMEOUT			= (1<<9),
+	VHOST_RDMA_IB_QP_RETRY_CNT			= (1<<10),
+	VHOST_RDMA_IB_QP_RNR_RETRY			= (1<<11),
+	VHOST_RDMA_IB_QP_RQ_PSN			= (1<<12),
+	VHOST_RDMA_IB_QP_MAX_QP_RD_ATOMIC		= (1<<13),
+	VHOST_RDMA_IB_QP_ALT_PATH			= (1<<14),
+	VHOST_RDMA_IB_QP_MIN_RNR_TIMER		= (1<<15),
+	VHOST_RDMA_IB_QP_SQ_PSN			= (1<<16),
+	VHOST_RDMA_IB_QP_MAX_DEST_RD_ATOMIC	= (1<<17),
+	VHOST_RDMA_IB_QP_PATH_MIG_STATE		= (1<<18),
+	VHOST_RDMA_IB_QP_CAP			= (1<<19),
+	VHOST_RDMA_IB_QP_DEST_QPN			= (1<<20),
+	VHOST_RDMA_IB_QP_RESERVED1			= (1<<21),
+	VHOST_RDMA_IB_QP_RESERVED2			= (1<<22),
+	VHOST_RDMA_IB_QP_RESERVED3			= (1<<23),
+	VHOST_RDMA_IB_QP_RESERVED4			= (1<<24),
+	VHOST_RDMA_IB_QP_RATE_LIMIT		= (1<<25),
+};
+
 enum vhost_ib_access_flags {
-        VHOST_RDMA_IB_ACCESS_LOCAL_WRITE = (1 << 0),
-        VHOST_RDMA_IB_ACCESS_REMOTE_WRITE = (1 << 1),
-        VHOST_RDMA_IB_ACCESS_REMOTE_READ = (1 << 2),
+	VHOST_RDMA_IB_ACCESS_LOCAL_WRITE = (1 << 0),
+	VHOST_RDMA_IB_ACCESS_REMOTE_WRITE = (1 << 1),
+	VHOST_RDMA_IB_ACCESS_REMOTE_READ = (1 << 2),
 };
 
 #define VHOST_RDMA_IB_ACCESS_REMOTE	(VHOST_RDMA_IB_ACCESS_REMOTE_WRITE | VHOST_RDMA_IB_ACCESS_REMOTE_READ)
 
-/**
- * @brief QP capabilities structure
- */
-struct vhost_rdma_qp_cap {
-	uint32_t max_send_wr;			/**< Max work requests in send queue */
-	uint32_t max_send_sge;			/**< Max scatter-gather elements per send WR */
-	uint32_t max_recv_wr;			/**< Max work requests in receive queue */
-	uint32_t max_recv_sge;			/**< Max SGEs per receive WR */
-	uint32_t max_inline_data;		/**< Max inline data size supported */
-};
-
 /**
  * @brief Global route attributes (used in AH/GRH)
  */
@@ -292,7 +321,20 @@ struct vhost_rdma_ah_attr {
 	uint8_t port_num;					/**< Physical port number */
 	uint8_t ah_flags;					/**< Flags (e.g., GRH present) */
 	uint8_t dmac[6];					/**< Destination MAC address (for RoCE) */
-} __rte_packed;
+};
+
+struct vhost_rdma_qp_cap {
+	/* Maximum number of outstanding WRs in SQ */
+	uint32_t max_send_wr;
+	/* Maximum number of s/g elements per WR in SQ */
+	uint32_t max_send_sge; 
+	/* Maximum number of outstanding WRs in RQ */
+	uint32_t max_recv_wr;
+	/* Maximum number of s/g elements per WR in RQ */
+	uint32_t max_recv_sge;      
+	/* Maximum number of data (bytes) that can be posted inline to SQ */
+	uint32_t max_inline_data;
+};
 
 /**
  * @brief Queue Pair attributes
@@ -387,7 +429,7 @@ struct vhost_user_rdma_msg {
  * @brief Completion Queue (CQ)
  */
 struct vhost_rdma_cq {
-	struct vhost_user_queue *vq;         /**< Notification V-ring */
+	struct vhost_user_queue *vq;	 /**< Notification V-ring */
 	rte_spinlock_t cq_lock;			/**< Protect CQ operations */
 	uint8_t notify;					/**< Notify pending flag */
 	bool is_dying;					/**< Being destroyed */
@@ -446,7 +488,7 @@ struct vhost_rdma_task {
  * @brief Requester-side operation tracking
  */
 struct vhost_rdma_req_info {
-	enum vhost_rdma_ib_qp_state state;
+	enum vhost_rdma_qp_state state;
 	int wqe_index;					/**< Current WQE index */
 	uint32_t psn;					/**< Packet Sequence Number */
 	int opcode;						/**< Operation type */
@@ -509,6 +551,28 @@ struct vhost_rdma_recv_wqe {
 	struct vhost_rdma_dma_info dma;	/**< DMA context */
 };
 
+/**
+ * @brief Internal representation of a Send Work Queue Entry (WQE)
+ *
+ * Created from a user-space WR; used during processing and retransmission.
+ */
+struct vhost_rdma_send_wqe {
+	struct vhost_rdma_sq_req *wr;	/**< Original WR pointer (from ring) */
+	struct vhost_rdma_av av;		/**< Address vector (path info) */
+	__u32 status;					/**< Execution status (see ib_wc_status) */
+	__u32 state;					/**< Processing state (e.g., active, done) */
+	__aligned_u64 iova;				/**< IOVA base for DMA mapping */
+	__u32 mask;						/**< Bitmask for PSN handling */
+	__u32 first_psn;				/**< First Packet Sequence Number */
+	__u32 last_psn;					/**< Last Packet Sequence Number */
+	__u32 ack_length;				/**< Bytes acknowledged so far */
+	__u32 ssn;						/**< Send Sequence Number */
+	__u32 has_rd_atomic;			/**< Flag indicating RDMA read or atomic op */
+
+	/* DMA transfer progress */
+	struct vhost_rdma_dma_info dma;
+};
+
 /**
  * @brief Memory Region (MR) types
  */
@@ -582,7 +646,7 @@ struct vhost_rdma_resp_res {
  * @brief Response processing context (responder side)
  */
 struct vhost_rdma_resp_info {
-	enum vhost_rdma_ib_qp_state state;
+	enum vhost_rdma_qp_state state;
 	uint32_t msn;					/**< Message sequence number */
 	uint32_t psn;					/**< Current PSN */
 	uint32_t ack_psn;				/**< Acknowledged PSN */
@@ -772,6 +836,127 @@ struct vhost_rdma_cmd_dereg_mr {
 	uint32_t mrn;
 };
 
+struct vhost_rdma_cmd_create_qp {
+	/* The handle of PD which the QP associated with */
+	uint32_t pdn;
+#define VHOST_RDMA_IB_QPT_SMI    0
+#define VHOST_RDMA_IB_QPT_GSI    1
+#define VHOST_RDMA_IB_QPT_RC     2
+#define VHOST_RDMA_IB_QPT_UC     3
+#define VHOST_RDMA_IB_QPT_UD     4
+	/* QP's type */
+	uint8_t qp_type;
+	/* If set, each WR submitted to the SQ generates a completion entry */
+	uint8_t sq_sig_all;
+	uint32_t max_send_wr;
+	uint32_t max_send_sge;
+	uint32_t send_cqn;
+	uint32_t max_recv_wr;
+	uint32_t max_recv_sge;
+	uint32_t recv_cqn;
+
+	uint32_t max_inline_data;
+	/* Reserved for future */
+	//uint32_t reserved[4];
+};
+
+struct vhost_rdma_ack_create_qp {
+	/* The index of QP */
+	uint32_t qpn;
+};
+
+struct vhost_rdma_ack_query_qp {
+	/* Move the QP to this state, enum virtio_ib_qp_state */
+	uint8_t qp_state;
+	/* Path MTU (valid only for RC/UC QPs), enum virtio_ib_mtu */
+	uint8_t path_mtu;
+	/* Is the SQ draining */
+	uint8_t sq_draining;
+	/* Number of outstanding RDMA read operations on destination QP (valid only for RC QPs) */
+	uint8_t max_rd_atomic;
+	/* Number of responder resources for handling incoming RDMA read operations (valid only for RC QPs) */
+	uint8_t max_dest_rd_atomic;
+	/* Minimum RNR NAK timer (valid only for RC QPs) */
+	uint8_t min_rnr_timer;
+	/* Local ack timeout (valid only for RC QPs) */
+	uint8_t timeout;
+	/* Retry count (valid only for RC QPs) */
+	uint8_t retry_cnt;
+	/* RNR retry (valid only for RC QPs) */
+	uint8_t rnr_retry;
+	/* Padding */
+	uint8_t padding[7];
+	/* Q_Key for the QP (valid only for UD QPs) */
+	uint32_t qkey;
+	/* PSN for RQ (valid only for RC/UC QPs) */
+	uint32_t rq_psn;
+	/* PSN for SQ */
+	uint32_t sq_psn;
+	/* Destination QP number (valid only for RC/UC QPs) */
+	uint32_t dest_qp_num;
+	/* Mask of enabled remote access operations (valid only for RC/UC QPs), enum virtio_ib_access_flags */
+	uint32_t qp_access_flags;
+	/* Rate limit in kbps for packet pacing */
+	uint32_t rate_limit;
+	/* QP capabilities */
+	struct vhost_rdma_qp_cap cap;
+	/* Address Vector (valid only for RC/UC QPs) */
+	struct vhost_rdma_ah_attr ah_attr;
+	/* Reserved for future */
+	uint32_t reserved[4];
+};
+
+enum vhost_rdma_ib_mig_state {
+	VHOST_RDMA_IB_MIG_MIGRATED,
+	VHOST_RDMA_IB_MIG_REARM,
+	VHOST_RDMA_IB_MIG_ARMED
+};
+
+struct vhost_rdma_cmd_modify_qp {
+    /* The index of QP */
+    uint32_t qpn;
+
+    uint32_t attr_mask;
+	enum vhost_rdma_ib_qp_state	qp_state;
+	enum vhost_rdma_ib_qp_state	cur_qp_state;
+	enum vhost_rdma_ib_mtu		path_mtu;
+	enum vhost_rdma_ib_mig_state	path_mig_state;
+	uint32_t			qkey;
+	uint32_t			rq_psn;
+	uint32_t			sq_psn;
+	uint32_t			dest_qp_num;
+	uint32_t			qp_access_flags;
+	uint16_t			pkey_index;
+	uint16_t			alt_pkey_index;
+	uint8_t			en_sqd_async_notify;
+	uint8_t			sq_draining;
+	uint8_t			max_rd_atomic;
+	uint8_t			max_dest_rd_atomic;
+	uint8_t			min_rnr_timer;
+	uint8_t			port_num;
+	uint8_t			timeout;
+	uint8_t			retry_cnt;
+	uint8_t			rnr_retry;
+	uint8_t			alt_port_num;
+	uint8_t			alt_timeout;
+	uint32_t			rate_limit;
+	struct vhost_rdma_qp_cap	cap;
+	struct vhost_rdma_ah_attr	ah_attr;
+	struct vhost_rdma_ah_attr	alt_ah_attr;
+};
+
+struct vhost_rdma_cmd_query_qp {
+	/* The index of QP */
+	uint32_t qpn;
+	/* The mask of attributes need to be queried, enum virtio_ib_qp_attr_mask */
+	uint32_t attr_mask;
+};
+
+struct vhost_rdma_cmd_destroy_qp {
+	/* The index of QP */
+	uint32_t qpn;
+};
+
 /**
  * @brief Convert IB MTU enum to byte size
  * @param mtu The MTU enum value
@@ -790,6 +975,16 @@ ib_mtu_enum_to_int(enum vhost_rdma_ib_mtu mtu)
 	}
 }
 
+static __rte_always_inline int
+__vhost_rdma_do_task(struct vhost_rdma_task *task)
+
+{
+	int ret;
+	while ((ret = task->func(task->arg)) == 0);
+	task->ret = ret;
+	return ret;
+}
+
 /* Function declarations */
 
 /**
@@ -829,13 +1024,6 @@ void vhost_rdma_mr_cleanup(void *arg);
  */
 void vhost_rdma_qp_cleanup(void *arg);
 
-/**
- * @brief Clean up a vhost_rdma_queue (drain rings, unregister interrupts)
- * @param qp Owning QP
- * @param queue Queue to clean
- */
-void vhost_rdma_queue_cleanup(struct vhost_rdma_qp *qp, struct vhost_rdma_queue *queue);
-
 /**
  * @brief Release one RDMA read/atomic responder resource
  * @param qp QP owning the resource
@@ -843,6 +1031,8 @@ void vhost_rdma_queue_cleanup(struct vhost_rdma_qp *qp, struct vhost_rdma_queue
  */
 void free_rd_atomic_resource(struct vhost_rdma_qp *qp, struct vhost_rdma_resp_res *res);
 
+int alloc_rd_atomic_resources(struct vhost_rdma_qp *qp, unsigned int n);
+
 /**
  * @brief Release all RDMA read/atomic responder resources
  * @param qp QP whose resources to free
@@ -866,4 +1056,17 @@ void vhost_rdma_map_pages(struct rte_vhost_memory *mem,
 						uint64_t *dma_pages,
 						uint32_t npages);
 
+int vhost_rdma_qp_query(struct vhost_rdma_qp *qp,
+				struct vhost_rdma_ack_query_qp *rsp);
+
+int vhost_rdma_qp_modify(struct vhost_rdma_device *dev, struct vhost_rdma_qp *qp,
+				struct vhost_rdma_cmd_modify_qp *cmd);
+int vhost_rdma_qp_init(struct vhost_rdma_device *dev,
+				struct vhost_rdma_qp *qp,
+				struct vhost_rdma_cmd_create_qp *cmd);
+void vhost_rdma_av_to_attr(struct vhost_rdma_av *av,
+				struct vhost_rdma_ah_attr *attr);
+
+void vhost_rdma_cleanup_task(struct vhost_rdma_task *task);
+
 #endif /* __VHOST_RDMA_IB_H__ */
\ No newline at end of file
diff --git a/examples/vhost_user_rdma/vhost_rdma_opcode.c b/examples/vhost_user_rdma/vhost_rdma_opcode.c
new file mode 100644
index 0000000000..4284a405f5
--- /dev/null
+++ b/examples/vhost_user_rdma/vhost_rdma_opcode.c
@@ -0,0 +1,894 @@
+/*
+ * Vhost-user RDMA device : rdma opcode
+ *
+ * Copyright (C) 2025 KylinSoft Inc. and/or its affiliates. All rights reserved.
+ *
+ * Author: Xiong Weimin <xiongweimin@kylinos.cn>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include "vhost_rdma_opcode.h"
+#include "vhost_rdma_queue.h"
+#include "vhost_rdma_ib.h"
+
+struct vhost_rdma_wr_opcode_info vhost_rdma_wr_opcode_info[] = {
+	[VHOST_RDMA_IB_WR_RDMA_WRITE]				= {
+		.name	= "VHOST_RDMA_IB_WR_RDMA_WRITE",
+		.mask	= {
+			[VHOST_RDMA_IB_QPT_RC]	= WR_INLINE_MASK | WR_WRITE_MASK,
+			[VHOST_RDMA_IB_QPT_UC]	= WR_INLINE_MASK | WR_WRITE_MASK,
+		},
+	},
+	[VHOST_RDMA_IB_WR_RDMA_WRITE_WITH_IMM]			= {
+		.name	= "VHOST_RDMA_IB_WR_RDMA_WRITE_WITH_IMM",
+		.mask	= {
+			[VHOST_RDMA_IB_QPT_RC]	= WR_INLINE_MASK | WR_WRITE_MASK,
+			[VHOST_RDMA_IB_QPT_UC]	= WR_INLINE_MASK | WR_WRITE_MASK,
+		},
+	},
+	[VHOST_RDMA_IB_WR_SEND]					= {
+		.name	= "VHOST_RDMA_IB_WR_SEND",
+		.mask	= {
+			[VHOST_RDMA_IB_QPT_SMI]	= WR_INLINE_MASK | WR_SEND_MASK,
+			[VHOST_RDMA_IB_QPT_GSI]	= WR_INLINE_MASK | WR_SEND_MASK,
+			[VHOST_RDMA_IB_QPT_RC]	= WR_INLINE_MASK | WR_SEND_MASK,
+			[VHOST_RDMA_IB_QPT_UC]	= WR_INLINE_MASK | WR_SEND_MASK,
+			[VHOST_RDMA_IB_QPT_UD]	= WR_INLINE_MASK | WR_SEND_MASK,
+		},
+	},
+	[VHOST_RDMA_IB_WR_SEND_WITH_IMM]				= {
+		.name	= "VHOST_RDMA_IB_WR_SEND_WITH_IMM",
+		.mask	= {
+			[VHOST_RDMA_IB_QPT_SMI]	= WR_INLINE_MASK | WR_SEND_MASK,
+			[VHOST_RDMA_IB_QPT_GSI]	= WR_INLINE_MASK | WR_SEND_MASK,
+			[VHOST_RDMA_IB_QPT_RC]	= WR_INLINE_MASK | WR_SEND_MASK,
+			[VHOST_RDMA_IB_QPT_UC]	= WR_INLINE_MASK | WR_SEND_MASK,
+			[VHOST_RDMA_IB_QPT_UD]	= WR_INLINE_MASK | WR_SEND_MASK,
+		},
+	},
+	[VHOST_RDMA_IB_WR_RDMA_READ]				= {
+		.name	= "VHOST_RDMA_IB_WR_RDMA_READ",
+		.mask	= {
+			[VHOST_RDMA_IB_QPT_RC]	= WR_READ_MASK,
+		},
+	},
+};
+
+struct vhost_rdma_opcode_info vhost_rdma_opcode[VHOST_NUM_OPCODE] = {
+	[IB_OPCODE_RC_SEND_FIRST]			= {
+		.name	= "IB_OPCODE_RC_SEND_FIRST",
+		.mask	= VHOST_PAYLOAD_MASK | VHOST_REQ_MASK | VHOST_RWR_MASK
+				| VHOST_SEND_MASK | VHOST_START_MASK,
+		.length = VHOST_BTH_BYTES,
+		.offset = {
+			[VHOST_RDMA_BTH]	= 0,
+			[VHOST_RDMA_PAYLOAD]	= VHOST_BTH_BYTES,
+		}
+	},
+	[IB_OPCODE_RC_SEND_MIDDLE]		= {
+		.name	= "IB_OPCODE_RC_SEND_MIDDLE",
+		.mask	= VHOST_PAYLOAD_MASK | VHOST_REQ_MASK | VHOST_SEND_MASK
+				| VHOST_MIDDLE_MASK,
+		.length = VHOST_BTH_BYTES,
+		.offset = {
+			[VHOST_RDMA_BTH]	= 0,
+			[VHOST_RDMA_PAYLOAD]	= VHOST_BTH_BYTES,
+		}
+	},
+	[IB_OPCODE_RC_SEND_LAST]			= {
+		.name	= "IB_OPCODE_RC_SEND_LAST",
+		.mask	= VHOST_PAYLOAD_MASK | VHOST_REQ_MASK | VHOST_COMP_MASK
+				| VHOST_SEND_MASK | VHOST_END_MASK,
+		.length = VHOST_BTH_BYTES,
+		.offset = {
+			[VHOST_RDMA_BTH]	= 0,
+			[VHOST_RDMA_PAYLOAD]	= VHOST_BTH_BYTES,
+		}
+	},
+	[IB_OPCODE_RC_SEND_LAST_WITH_IMMEDIATE]		= {
+		.name	= "IB_OPCODE_RC_SEND_LAST_WITH_IMMEDIATE",
+		.mask	= VHOST_IMMDT_MASK | VHOST_PAYLOAD_MASK | VHOST_REQ_MASK
+				| VHOST_COMP_MASK | VHOST_SEND_MASK | VHOST_END_MASK,
+		.length = VHOST_BTH_BYTES + VHOST_IMMDT_BYTES,
+		.offset = {
+			[VHOST_RDMA_BTH]	= 0,
+			[VHOST_RDMA_IMMDT]	= VHOST_BTH_BYTES,
+			[VHOST_RDMA_PAYLOAD]	= VHOST_BTH_BYTES
+						+ VHOST_IMMDT_BYTES,
+		}
+	},
+	[IB_OPCODE_RC_SEND_ONLY]			= {
+		.name	= "IB_OPCODE_RC_SEND_ONLY",
+		.mask	= VHOST_PAYLOAD_MASK | VHOST_REQ_MASK | VHOST_COMP_MASK
+				| VHOST_RWR_MASK | VHOST_SEND_MASK
+				| VHOST_START_MASK | VHOST_END_MASK,
+		.length = VHOST_BTH_BYTES,
+		.offset = {
+			[VHOST_RDMA_BTH]	= 0,
+			[VHOST_RDMA_PAYLOAD]	= VHOST_BTH_BYTES,
+		}
+	},
+	[IB_OPCODE_RC_SEND_ONLY_WITH_IMMEDIATE]		= {
+		.name	= "IB_OPCODE_RC_SEND_ONLY_WITH_IMMEDIATE",
+		.mask	= VHOST_IMMDT_MASK | VHOST_PAYLOAD_MASK | VHOST_REQ_MASK
+				| VHOST_COMP_MASK | VHOST_RWR_MASK | VHOST_SEND_MASK
+				| VHOST_START_MASK | VHOST_END_MASK,
+		.length = VHOST_BTH_BYTES + VHOST_IMMDT_BYTES,
+		.offset = {
+			[VHOST_RDMA_BTH]	= 0,
+			[VHOST_RDMA_IMMDT]	= VHOST_BTH_BYTES,
+			[VHOST_RDMA_PAYLOAD]	= VHOST_BTH_BYTES
+						+ VHOST_IMMDT_BYTES,
+		}
+	},
+	[IB_OPCODE_RC_RDMA_WRITE_FIRST]		= {
+		.name	= "IB_OPCODE_RC_RDMA_WRITE_FIRST",
+		.mask	= VHOST_RETH_MASK | VHOST_PAYLOAD_MASK | VHOST_REQ_MASK
+				| VHOST_WRITE_MASK | VHOST_START_MASK,
+		.length = VHOST_BTH_BYTES + VHOST_RETH_BYTES,
+		.offset = {
+			[VHOST_RDMA_BTH]	= 0,
+			[VHOST_RDMA_RETH]	= VHOST_BTH_BYTES,
+			[VHOST_RDMA_PAYLOAD]	= VHOST_BTH_BYTES
+						+ VHOST_RETH_BYTES,
+		}
+	},
+	[IB_OPCODE_RC_RDMA_WRITE_MIDDLE]		= {
+		.name	= "IB_OPCODE_RC_RDMA_WRITE_MIDDLE",
+		.mask	= VHOST_PAYLOAD_MASK | VHOST_REQ_MASK | VHOST_WRITE_MASK
+				| VHOST_MIDDLE_MASK,
+		.length = VHOST_BTH_BYTES,
+		.offset = {
+			[VHOST_RDMA_BTH]	= 0,
+			[VHOST_RDMA_PAYLOAD]	= VHOST_BTH_BYTES,
+		}
+	},
+	[IB_OPCODE_RC_RDMA_WRITE_LAST]			= {
+		.name	= "IB_OPCODE_RC_RDMA_WRITE_LAST",
+		.mask	= VHOST_PAYLOAD_MASK | VHOST_REQ_MASK | VHOST_WRITE_MASK
+				| VHOST_END_MASK,
+		.length = VHOST_BTH_BYTES,
+		.offset = {
+			[VHOST_RDMA_BTH]	= 0,
+			[VHOST_RDMA_PAYLOAD]	= VHOST_BTH_BYTES,
+		}
+	},
+	[IB_OPCODE_RC_RDMA_WRITE_LAST_WITH_IMMEDIATE]		= {
+		.name	= "IB_OPCODE_RC_RDMA_WRITE_LAST_WITH_IMMEDIATE",
+		.mask	= VHOST_IMMDT_MASK | VHOST_PAYLOAD_MASK | VHOST_REQ_MASK
+				| VHOST_WRITE_MASK | VHOST_COMP_MASK | VHOST_RWR_MASK
+				| VHOST_END_MASK,
+		.length = VHOST_BTH_BYTES + VHOST_IMMDT_BYTES,
+		.offset = {
+			[VHOST_RDMA_BTH]	= 0,
+			[VHOST_RDMA_IMMDT]	= VHOST_BTH_BYTES,
+			[VHOST_RDMA_PAYLOAD]	= VHOST_BTH_BYTES
+						+ VHOST_IMMDT_BYTES,
+		}
+	},
+	[IB_OPCODE_RC_RDMA_WRITE_ONLY]			= {
+		.name	= "IB_OPCODE_RC_RDMA_WRITE_ONLY",
+		.mask	= VHOST_RETH_MASK | VHOST_PAYLOAD_MASK | VHOST_REQ_MASK
+				| VHOST_WRITE_MASK | VHOST_START_MASK
+				| VHOST_END_MASK,
+		.length = VHOST_BTH_BYTES + VHOST_RETH_BYTES,
+		.offset = {
+			[VHOST_RDMA_BTH]	= 0,
+			[VHOST_RDMA_RETH]	= VHOST_BTH_BYTES,
+			[VHOST_RDMA_PAYLOAD]	= VHOST_BTH_BYTES
+						+ VHOST_RETH_BYTES,
+		}
+	},
+	[IB_OPCODE_RC_RDMA_WRITE_ONLY_WITH_IMMEDIATE]		= {
+		.name	= "IB_OPCODE_RC_RDMA_WRITE_ONLY_WITH_IMMEDIATE",
+		.mask	= VHOST_RETH_MASK | VHOST_IMMDT_MASK | VHOST_PAYLOAD_MASK
+				| VHOST_REQ_MASK | VHOST_WRITE_MASK
+				| VHOST_COMP_MASK | VHOST_RWR_MASK
+				| VHOST_START_MASK | VHOST_END_MASK,
+		.length = VHOST_BTH_BYTES + VHOST_IMMDT_BYTES + VHOST_RETH_BYTES,
+		.offset = {
+			[VHOST_RDMA_BTH]	= 0,
+			[VHOST_RDMA_RETH]	= VHOST_BTH_BYTES,
+			[VHOST_RDMA_IMMDT]	= VHOST_BTH_BYTES
+						+ VHOST_RETH_BYTES,
+			[VHOST_RDMA_PAYLOAD]	= VHOST_BTH_BYTES
+						+ VHOST_RETH_BYTES
+						+ VHOST_IMMDT_BYTES,
+		}
+	},
+	[IB_OPCODE_RC_RDMA_READ_REQUEST]			= {
+		.name	= "IB_OPCODE_RC_RDMA_READ_REQUEST",
+		.mask	= VHOST_RETH_MASK | VHOST_REQ_MASK | VHOST_READ_MASK
+				| VHOST_START_MASK | VHOST_END_MASK,
+		.length = VHOST_BTH_BYTES + VHOST_RETH_BYTES,
+		.offset = {
+			[VHOST_RDMA_BTH]	= 0,
+			[VHOST_RDMA_RETH]	= VHOST_BTH_BYTES,
+			[VHOST_RDMA_PAYLOAD]	= VHOST_BTH_BYTES
+						+ VHOST_RETH_BYTES,
+		}
+	},
+	[IB_OPCODE_RC_RDMA_READ_RESPONSE_FIRST]		= {
+		.name	= "IB_OPCODE_RC_RDMA_READ_RESPONSE_FIRST",
+		.mask	= VHOST_AETH_MASK | VHOST_PAYLOAD_MASK | VHOST_ACK_MASK
+				| VHOST_START_MASK,
+		.length = VHOST_BTH_BYTES + VHOST_AETH_BYTES,
+		.offset = {
+			[VHOST_RDMA_BTH]	= 0,
+			[VHOST_RDMA_AETH]	= VHOST_BTH_BYTES,
+			[VHOST_RDMA_PAYLOAD]	= VHOST_BTH_BYTES
+						+ VHOST_AETH_BYTES,
+		}
+	},
+	[IB_OPCODE_RC_RDMA_READ_RESPONSE_MIDDLE]		= {
+		.name	= "IB_OPCODE_RC_RDMA_READ_RESPONSE_MIDDLE",
+		.mask	= VHOST_PAYLOAD_MASK | VHOST_ACK_MASK | VHOST_MIDDLE_MASK,
+		.length = VHOST_BTH_BYTES,
+		.offset = {
+			[VHOST_RDMA_BTH]	= 0,
+			[VHOST_RDMA_PAYLOAD]	= VHOST_BTH_BYTES,
+		}
+	},
+	[IB_OPCODE_RC_RDMA_READ_RESPONSE_LAST]		= {
+		.name	= "IB_OPCODE_RC_RDMA_READ_RESPONSE_LAST",
+		.mask	= VHOST_AETH_MASK | VHOST_PAYLOAD_MASK | VHOST_ACK_MASK
+				| VHOST_END_MASK,
+		.length = VHOST_BTH_BYTES + VHOST_AETH_BYTES,
+		.offset = {
+			[VHOST_RDMA_BTH]	= 0,
+			[VHOST_RDMA_AETH]	= VHOST_BTH_BYTES,
+			[VHOST_RDMA_PAYLOAD]	= VHOST_BTH_BYTES
+						+ VHOST_AETH_BYTES,
+		}
+	},
+	[IB_OPCODE_RC_RDMA_READ_RESPONSE_ONLY]		= {
+		.name	= "IB_OPCODE_RC_RDMA_READ_RESPONSE_ONLY",
+		.mask	= VHOST_AETH_MASK | VHOST_PAYLOAD_MASK | VHOST_ACK_MASK
+				| VHOST_START_MASK | VHOST_END_MASK,
+		.length = VHOST_BTH_BYTES + VHOST_AETH_BYTES,
+		.offset = {
+			[VHOST_RDMA_BTH]	= 0,
+			[VHOST_RDMA_AETH]	= VHOST_BTH_BYTES,
+			[VHOST_RDMA_PAYLOAD]	= VHOST_BTH_BYTES
+						+ VHOST_AETH_BYTES,
+		}
+	},
+	[IB_OPCODE_RC_ACKNOWLEDGE]			= {
+		.name	= "IB_OPCODE_RC_ACKNOWLEDGE",
+		.mask	= VHOST_AETH_MASK | VHOST_ACK_MASK | VHOST_START_MASK
+				| VHOST_END_MASK,
+		.length = VHOST_BTH_BYTES + VHOST_AETH_BYTES,
+		.offset = {
+			[VHOST_RDMA_BTH]	= 0,
+			[VHOST_RDMA_AETH]	= VHOST_BTH_BYTES,
+			[VHOST_RDMA_PAYLOAD]	= VHOST_BTH_BYTES
+						+ VHOST_AETH_BYTES,
+		}
+	},
+	[IB_OPCODE_RC_ATOMIC_ACKNOWLEDGE]			= {
+		.name	= "IB_OPCODE_RC_ATOMIC_ACKNOWLEDGE",
+		.mask	= VHOST_AETH_MASK | VHOST_ATMACK_MASK | VHOST_ACK_MASK
+				| VHOST_START_MASK | VHOST_END_MASK,
+		.length = VHOST_BTH_BYTES + VHOST_ATMACK_BYTES + VHOST_AETH_BYTES,
+		.offset = {
+			[VHOST_RDMA_BTH]	= 0,
+			[VHOST_RDMA_AETH]	= VHOST_BTH_BYTES,
+			[VHOST_RDMA_ATMACK]	= VHOST_BTH_BYTES
+						+ VHOST_AETH_BYTES,
+			[VHOST_RDMA_PAYLOAD]	= VHOST_BTH_BYTES
+					+ VHOST_ATMACK_BYTES + VHOST_AETH_BYTES,
+		}
+	},
+	[IB_OPCODE_RC_COMPARE_SWAP]			= {
+		.name	= "IB_OPCODE_RC_COMPARE_SWAP",
+		.mask	= VHOST_ATMETH_MASK | VHOST_REQ_MASK | VHOST_ATOMIC_MASK
+				| VHOST_START_MASK | VHOST_END_MASK,
+		.length = VHOST_BTH_BYTES + VHOST_ATMETH_BYTES,
+		.offset = {
+			[VHOST_RDMA_BTH]	= 0,
+			[VHOST_RDMA_ATMETH]	= VHOST_BTH_BYTES,
+			[VHOST_RDMA_PAYLOAD]	= VHOST_BTH_BYTES
+						+ VHOST_ATMETH_BYTES,
+		}
+	},
+	[IB_OPCODE_RC_FETCH_ADD]			= {
+		.name	= "IB_OPCODE_RC_FETCH_ADD",
+		.mask	= VHOST_ATMETH_MASK | VHOST_REQ_MASK | VHOST_ATOMIC_MASK
+				| VHOST_START_MASK | VHOST_END_MASK,
+		.length = VHOST_BTH_BYTES + VHOST_ATMETH_BYTES,
+		.offset = {
+			[VHOST_RDMA_BTH]	= 0,
+			[VHOST_RDMA_ATMETH]	= VHOST_BTH_BYTES,
+			[VHOST_RDMA_PAYLOAD]	= VHOST_BTH_BYTES
+						+ VHOST_ATMETH_BYTES,
+		}
+	},
+	[IB_OPCODE_RC_SEND_LAST_WITH_INVALIDATE]		= {
+		.name	= "IB_OPCODE_RC_SEND_LAST_WITH_INVALIDATE",
+		.mask	= VHOST_IETH_MASK | VHOST_PAYLOAD_MASK | VHOST_REQ_MASK
+				| VHOST_COMP_MASK | VHOST_SEND_MASK | VHOST_END_MASK,
+		.length = VHOST_BTH_BYTES + VHOST_IETH_BYTES,
+		.offset = {
+			[VHOST_RDMA_BTH]	= 0,
+			[VHOST_RDMA_IETH]	= VHOST_BTH_BYTES,
+			[VHOST_RDMA_PAYLOAD]	= VHOST_BTH_BYTES
+						+ VHOST_IETH_BYTES,
+		}
+	},
+	[IB_OPCODE_RC_SEND_ONLY_WITH_INVALIDATE]		= {
+		.name	= "IB_OPCODE_RC_SEND_ONLY_INV",
+		.mask	= VHOST_IETH_MASK | VHOST_PAYLOAD_MASK | VHOST_REQ_MASK
+				| VHOST_COMP_MASK | VHOST_RWR_MASK | VHOST_SEND_MASK
+				| VHOST_END_MASK  | VHOST_START_MASK,
+		.length = VHOST_BTH_BYTES + VHOST_IETH_BYTES,
+		.offset = {
+			[VHOST_RDMA_BTH]	= 0,
+			[VHOST_RDMA_IETH]	= VHOST_BTH_BYTES,
+			[VHOST_RDMA_PAYLOAD]	= VHOST_BTH_BYTES
+						+ VHOST_IETH_BYTES,
+		}
+	},
+
+	/* UC */
+	[IB_OPCODE_UC_SEND_FIRST]			= {
+		.name	= "IB_OPCODE_UC_SEND_FIRST",
+		.mask	= VHOST_PAYLOAD_MASK | VHOST_REQ_MASK | VHOST_RWR_MASK
+				| VHOST_SEND_MASK | VHOST_START_MASK,
+		.length = VHOST_BTH_BYTES,
+		.offset = {
+			[VHOST_RDMA_BTH]	= 0,
+			[VHOST_RDMA_PAYLOAD]	= VHOST_BTH_BYTES,
+		}
+	},
+	[IB_OPCODE_UC_SEND_MIDDLE]		= {
+		.name	= "IB_OPCODE_UC_SEND_MIDDLE",
+		.mask	= VHOST_PAYLOAD_MASK | VHOST_REQ_MASK | VHOST_SEND_MASK
+				| VHOST_MIDDLE_MASK,
+		.length = VHOST_BTH_BYTES,
+		.offset = {
+			[VHOST_RDMA_BTH]	= 0,
+			[VHOST_RDMA_PAYLOAD]	= VHOST_BTH_BYTES,
+		}
+	},
+	[IB_OPCODE_UC_SEND_LAST]			= {
+		.name	= "IB_OPCODE_UC_SEND_LAST",
+		.mask	= VHOST_PAYLOAD_MASK | VHOST_REQ_MASK | VHOST_COMP_MASK
+				| VHOST_SEND_MASK | VHOST_END_MASK,
+		.length = VHOST_BTH_BYTES,
+		.offset = {
+			[VHOST_RDMA_BTH]	= 0,
+			[VHOST_RDMA_PAYLOAD]	= VHOST_BTH_BYTES,
+		}
+	},
+	[IB_OPCODE_UC_SEND_LAST_WITH_IMMEDIATE]		= {
+		.name	= "IB_OPCODE_UC_SEND_LAST_WITH_IMMEDIATE",
+		.mask	= VHOST_IMMDT_MASK | VHOST_PAYLOAD_MASK | VHOST_REQ_MASK
+				| VHOST_COMP_MASK | VHOST_SEND_MASK | VHOST_END_MASK,
+		.length = VHOST_BTH_BYTES + VHOST_IMMDT_BYTES,
+		.offset = {
+			[VHOST_RDMA_BTH]	= 0,
+			[VHOST_RDMA_IMMDT]	= VHOST_BTH_BYTES,
+			[VHOST_RDMA_PAYLOAD]	= VHOST_BTH_BYTES
+						+ VHOST_IMMDT_BYTES,
+		}
+	},
+	[IB_OPCODE_UC_SEND_ONLY]			= {
+		.name	= "IB_OPCODE_UC_SEND_ONLY",
+		.mask	= VHOST_PAYLOAD_MASK | VHOST_REQ_MASK | VHOST_COMP_MASK
+				| VHOST_RWR_MASK | VHOST_SEND_MASK
+				| VHOST_START_MASK | VHOST_END_MASK,
+		.length = VHOST_BTH_BYTES,
+		.offset = {
+			[VHOST_RDMA_BTH]	= 0,
+			[VHOST_RDMA_PAYLOAD]	= VHOST_BTH_BYTES,
+		}
+	},
+	[IB_OPCODE_UC_SEND_ONLY_WITH_IMMEDIATE]		= {
+		.name	= "IB_OPCODE_UC_SEND_ONLY_WITH_IMMEDIATE",
+		.mask	= VHOST_IMMDT_MASK | VHOST_PAYLOAD_MASK | VHOST_REQ_MASK
+				| VHOST_COMP_MASK | VHOST_RWR_MASK | VHOST_SEND_MASK
+				| VHOST_START_MASK | VHOST_END_MASK,
+		.length = VHOST_BTH_BYTES + VHOST_IMMDT_BYTES,
+		.offset = {
+			[VHOST_RDMA_BTH]	= 0,
+			[VHOST_RDMA_IMMDT]	= VHOST_BTH_BYTES,
+			[VHOST_RDMA_PAYLOAD]	= VHOST_BTH_BYTES
+						+ VHOST_IMMDT_BYTES,
+		}
+	},
+	[IB_OPCODE_UC_RDMA_WRITE_FIRST]		= {
+		.name	= "IB_OPCODE_UC_RDMA_WRITE_FIRST",
+		.mask	= VHOST_RETH_MASK | VHOST_PAYLOAD_MASK | VHOST_REQ_MASK
+				| VHOST_WRITE_MASK | VHOST_START_MASK,
+		.length = VHOST_BTH_BYTES + VHOST_RETH_BYTES,
+		.offset = {
+			[VHOST_RDMA_BTH]	= 0,
+			[VHOST_RDMA_RETH]	= VHOST_BTH_BYTES,
+			[VHOST_RDMA_PAYLOAD]	= VHOST_BTH_BYTES
+						+ VHOST_RETH_BYTES,
+		}
+	},
+	[IB_OPCODE_UC_RDMA_WRITE_MIDDLE]		= {
+		.name	= "IB_OPCODE_UC_RDMA_WRITE_MIDDLE",
+		.mask	= VHOST_PAYLOAD_MASK | VHOST_REQ_MASK | VHOST_WRITE_MASK
+				| VHOST_MIDDLE_MASK,
+		.length = VHOST_BTH_BYTES,
+		.offset = {
+			[VHOST_RDMA_BTH]	= 0,
+			[VHOST_RDMA_PAYLOAD]	= VHOST_BTH_BYTES,
+		}
+	},
+	[IB_OPCODE_UC_RDMA_WRITE_LAST]			= {
+		.name	= "IB_OPCODE_UC_RDMA_WRITE_LAST",
+		.mask	= VHOST_PAYLOAD_MASK | VHOST_REQ_MASK | VHOST_WRITE_MASK
+				| VHOST_END_MASK,
+		.length = VHOST_BTH_BYTES,
+		.offset = {
+			[VHOST_RDMA_BTH]	= 0,
+			[VHOST_RDMA_PAYLOAD]	= VHOST_BTH_BYTES,
+		}
+	},
+	[IB_OPCODE_UC_RDMA_WRITE_LAST_WITH_IMMEDIATE]		= {
+		.name	= "IB_OPCODE_UC_RDMA_WRITE_LAST_WITH_IMMEDIATE",
+		.mask	= VHOST_IMMDT_MASK | VHOST_PAYLOAD_MASK | VHOST_REQ_MASK
+				| VHOST_WRITE_MASK | VHOST_COMP_MASK | VHOST_RWR_MASK
+				| VHOST_END_MASK,
+		.length = VHOST_BTH_BYTES + VHOST_IMMDT_BYTES,
+		.offset = {
+			[VHOST_RDMA_BTH]	= 0,
+			[VHOST_RDMA_IMMDT]	= VHOST_BTH_BYTES,
+			[VHOST_RDMA_PAYLOAD]	= VHOST_BTH_BYTES
+						+ VHOST_IMMDT_BYTES,
+		}
+	},
+	[IB_OPCODE_UC_RDMA_WRITE_ONLY]			= {
+		.name	= "IB_OPCODE_UC_RDMA_WRITE_ONLY",
+		.mask	= VHOST_RETH_MASK | VHOST_PAYLOAD_MASK | VHOST_REQ_MASK
+				| VHOST_WRITE_MASK | VHOST_START_MASK
+				| VHOST_END_MASK,
+		.length = VHOST_BTH_BYTES + VHOST_RETH_BYTES,
+		.offset = {
+			[VHOST_RDMA_BTH]	= 0,
+			[VHOST_RDMA_RETH]	= VHOST_BTH_BYTES,
+			[VHOST_RDMA_PAYLOAD]	= VHOST_BTH_BYTES
+						+ VHOST_RETH_BYTES,
+		}
+	},
+	[IB_OPCODE_UC_RDMA_WRITE_ONLY_WITH_IMMEDIATE]		= {
+		.name	= "IB_OPCODE_UC_RDMA_WRITE_ONLY_WITH_IMMEDIATE",
+		.mask	= VHOST_RETH_MASK | VHOST_IMMDT_MASK | VHOST_PAYLOAD_MASK
+				| VHOST_REQ_MASK | VHOST_WRITE_MASK
+				| VHOST_COMP_MASK | VHOST_RWR_MASK
+				| VHOST_START_MASK | VHOST_END_MASK,
+		.length = VHOST_BTH_BYTES + VHOST_IMMDT_BYTES + VHOST_RETH_BYTES,
+		.offset = {
+			[VHOST_RDMA_BTH]	= 0,
+			[VHOST_RDMA_RETH]	= VHOST_BTH_BYTES,
+			[VHOST_RDMA_IMMDT]	= VHOST_BTH_BYTES
+						+ VHOST_RETH_BYTES,
+			[VHOST_RDMA_PAYLOAD]	= VHOST_BTH_BYTES
+						+ VHOST_RETH_BYTES
+						+ VHOST_IMMDT_BYTES,
+		}
+	},
+
+	/* RD */
+	[IB_OPCODE_RD_SEND_FIRST]			= {
+		.name	= "IB_OPCODE_RD_SEND_FIRST",
+		.mask	= VHOST_RDETH_MASK | VHOST_DETH_MASK | VHOST_PAYLOAD_MASK
+				| VHOST_REQ_MASK | VHOST_RWR_MASK | VHOST_SEND_MASK
+				| VHOST_START_MASK,
+		.length = VHOST_BTH_BYTES + VHOST_DETH_BYTES + VHOST_RDETH_BYTES,
+		.offset = {
+			[VHOST_RDMA_BTH]	= 0,
+			[VHOST_RDMA_RDETH]	= VHOST_BTH_BYTES,
+			[VHOST_RDMA_DETH]	= VHOST_BTH_BYTES
+						+ VHOST_RDETH_BYTES,
+			[VHOST_RDMA_PAYLOAD]	= VHOST_BTH_BYTES
+						+ VHOST_RDETH_BYTES
+						+ VHOST_DETH_BYTES,
+		}
+	},
+	[IB_OPCODE_RD_SEND_MIDDLE]		= {
+		.name	= "IB_OPCODE_RD_SEND_MIDDLE",
+		.mask	= VHOST_RDETH_MASK | VHOST_DETH_MASK | VHOST_PAYLOAD_MASK
+				| VHOST_REQ_MASK | VHOST_SEND_MASK
+				| VHOST_MIDDLE_MASK,
+		.length = VHOST_BTH_BYTES + VHOST_DETH_BYTES + VHOST_RDETH_BYTES,
+		.offset = {
+			[VHOST_RDMA_BTH]	= 0,
+			[VHOST_RDMA_RDETH]	= VHOST_BTH_BYTES,
+			[VHOST_RDMA_DETH]	= VHOST_BTH_BYTES
+						+ VHOST_RDETH_BYTES,
+			[VHOST_RDMA_PAYLOAD]	= VHOST_BTH_BYTES
+						+ VHOST_RDETH_BYTES
+						+ VHOST_DETH_BYTES,
+		}
+	},
+	[IB_OPCODE_RD_SEND_LAST]			= {
+		.name	= "IB_OPCODE_RD_SEND_LAST",
+		.mask	= VHOST_RDETH_MASK | VHOST_DETH_MASK | VHOST_PAYLOAD_MASK
+				| VHOST_REQ_MASK | VHOST_COMP_MASK | VHOST_SEND_MASK
+				| VHOST_END_MASK,
+		.length = VHOST_BTH_BYTES + VHOST_DETH_BYTES + VHOST_RDETH_BYTES,
+		.offset = {
+			[VHOST_RDMA_BTH]	= 0,
+			[VHOST_RDMA_RDETH]	= VHOST_BTH_BYTES,
+			[VHOST_RDMA_DETH]	= VHOST_BTH_BYTES
+						+ VHOST_RDETH_BYTES,
+			[VHOST_RDMA_PAYLOAD]	= VHOST_BTH_BYTES
+						+ VHOST_RDETH_BYTES
+						+ VHOST_DETH_BYTES,
+		}
+	},
+	[IB_OPCODE_RD_SEND_LAST_WITH_IMMEDIATE]		= {
+		.name	= "IB_OPCODE_RD_SEND_LAST_WITH_IMMEDIATE",
+		.mask	= VHOST_RDETH_MASK | VHOST_DETH_MASK | VHOST_IMMDT_MASK
+				| VHOST_PAYLOAD_MASK | VHOST_REQ_MASK
+				| VHOST_COMP_MASK | VHOST_SEND_MASK
+				| VHOST_END_MASK,
+		.length = VHOST_BTH_BYTES + VHOST_IMMDT_BYTES + VHOST_DETH_BYTES
+				+ VHOST_RDETH_BYTES,
+		.offset = {
+			[VHOST_RDMA_BTH]	= 0,
+			[VHOST_RDMA_RDETH]	= VHOST_BTH_BYTES,
+			[VHOST_RDMA_DETH]	= VHOST_BTH_BYTES
+						+ VHOST_RDETH_BYTES,
+			[VHOST_RDMA_IMMDT]	= VHOST_BTH_BYTES
+						+ VHOST_RDETH_BYTES
+						+ VHOST_DETH_BYTES,
+			[VHOST_RDMA_PAYLOAD]	= VHOST_BTH_BYTES
+						+ VHOST_RDETH_BYTES
+						+ VHOST_DETH_BYTES
+						+ VHOST_IMMDT_BYTES,
+		}
+	},
+	[IB_OPCODE_RD_SEND_ONLY]			= {
+		.name	= "IB_OPCODE_RD_SEND_ONLY",
+		.mask	= VHOST_RDETH_MASK | VHOST_DETH_MASK | VHOST_PAYLOAD_MASK
+				| VHOST_REQ_MASK | VHOST_COMP_MASK | VHOST_RWR_MASK
+				| VHOST_SEND_MASK | VHOST_START_MASK | VHOST_END_MASK,
+		.length = VHOST_BTH_BYTES + VHOST_DETH_BYTES + VHOST_RDETH_BYTES,
+		.offset = {
+			[VHOST_RDMA_BTH]	= 0,
+			[VHOST_RDMA_RDETH]	= VHOST_BTH_BYTES,
+			[VHOST_RDMA_DETH]	= VHOST_BTH_BYTES
+						+ VHOST_RDETH_BYTES,
+			[VHOST_RDMA_PAYLOAD]	= VHOST_BTH_BYTES
+						+ VHOST_RDETH_BYTES
+						+ VHOST_DETH_BYTES,
+		}
+	},
+	[IB_OPCODE_RD_SEND_ONLY_WITH_IMMEDIATE]		= {
+		.name	= "IB_OPCODE_RD_SEND_ONLY_WITH_IMMEDIATE",
+		.mask	= VHOST_RDETH_MASK | VHOST_DETH_MASK | VHOST_IMMDT_MASK
+				| VHOST_PAYLOAD_MASK | VHOST_REQ_MASK
+				| VHOST_COMP_MASK | VHOST_RWR_MASK | VHOST_SEND_MASK
+				| VHOST_START_MASK | VHOST_END_MASK,
+		.length = VHOST_BTH_BYTES + VHOST_IMMDT_BYTES + VHOST_DETH_BYTES
+				+ VHOST_RDETH_BYTES,
+		.offset = {
+			[VHOST_RDMA_BTH]	= 0,
+			[VHOST_RDMA_RDETH]	= VHOST_BTH_BYTES,
+			[VHOST_RDMA_DETH]	= VHOST_BTH_BYTES
+						+ VHOST_RDETH_BYTES,
+			[VHOST_RDMA_IMMDT]	= VHOST_BTH_BYTES
+						+ VHOST_RDETH_BYTES
+						+ VHOST_DETH_BYTES,
+			[VHOST_RDMA_PAYLOAD]	= VHOST_BTH_BYTES
+						+ VHOST_RDETH_BYTES
+						+ VHOST_DETH_BYTES
+						+ VHOST_IMMDT_BYTES,
+		}
+	},
+	[IB_OPCODE_RD_RDMA_WRITE_FIRST]		= {
+		.name	= "IB_OPCODE_RD_RDMA_WRITE_FIRST",
+		.mask	= VHOST_RDETH_MASK | VHOST_DETH_MASK | VHOST_RETH_MASK
+				| VHOST_PAYLOAD_MASK | VHOST_REQ_MASK
+				| VHOST_WRITE_MASK | VHOST_START_MASK,
+		.length = VHOST_BTH_BYTES + VHOST_RETH_BYTES + VHOST_DETH_BYTES
+				+ VHOST_RDETH_BYTES,
+		.offset = {
+			[VHOST_RDMA_BTH]	= 0,
+			[VHOST_RDMA_RDETH]	= VHOST_BTH_BYTES,
+			[VHOST_RDMA_DETH]	= VHOST_BTH_BYTES
+						+ VHOST_RDETH_BYTES,
+			[VHOST_RDMA_RETH]	= VHOST_BTH_BYTES
+						+ VHOST_RDETH_BYTES
+						+ VHOST_DETH_BYTES,
+			[VHOST_RDMA_PAYLOAD]	= VHOST_BTH_BYTES
+						+ VHOST_RDETH_BYTES
+						+ VHOST_DETH_BYTES
+						+ VHOST_RETH_BYTES,
+		}
+	},
+	[IB_OPCODE_RD_RDMA_WRITE_MIDDLE]		= {
+		.name	= "IB_OPCODE_RD_RDMA_WRITE_MIDDLE",
+		.mask	= VHOST_RDETH_MASK | VHOST_DETH_MASK | VHOST_PAYLOAD_MASK
+				| VHOST_REQ_MASK | VHOST_WRITE_MASK
+				| VHOST_MIDDLE_MASK,
+		.length = VHOST_BTH_BYTES + VHOST_DETH_BYTES + VHOST_RDETH_BYTES,
+		.offset = {
+			[VHOST_RDMA_BTH]	= 0,
+			[VHOST_RDMA_RDETH]	= VHOST_BTH_BYTES,
+			[VHOST_RDMA_DETH]	= VHOST_BTH_BYTES
+						+ VHOST_RDETH_BYTES,
+			[VHOST_RDMA_PAYLOAD]	= VHOST_BTH_BYTES
+						+ VHOST_RDETH_BYTES
+						+ VHOST_DETH_BYTES,
+		}
+	},
+	[IB_OPCODE_RD_RDMA_WRITE_LAST]			= {
+		.name	= "IB_OPCODE_RD_RDMA_WRITE_LAST",
+		.mask	= VHOST_RDETH_MASK | VHOST_DETH_MASK | VHOST_PAYLOAD_MASK
+				| VHOST_REQ_MASK | VHOST_WRITE_MASK
+				| VHOST_END_MASK,
+		.length = VHOST_BTH_BYTES + VHOST_DETH_BYTES + VHOST_RDETH_BYTES,
+		.offset = {
+			[VHOST_RDMA_BTH]	= 0,
+			[VHOST_RDMA_RDETH]	= VHOST_BTH_BYTES,
+			[VHOST_RDMA_DETH]	= VHOST_BTH_BYTES
+						+ VHOST_RDETH_BYTES,
+			[VHOST_RDMA_PAYLOAD]	= VHOST_BTH_BYTES
+						+ VHOST_RDETH_BYTES
+						+ VHOST_DETH_BYTES,
+		}
+	},
+	[IB_OPCODE_RD_RDMA_WRITE_LAST_WITH_IMMEDIATE]		= {
+		.name	= "IB_OPCODE_RD_RDMA_WRITE_LAST_WITH_IMMEDIATE",
+		.mask	= VHOST_RDETH_MASK | VHOST_DETH_MASK | VHOST_IMMDT_MASK
+				| VHOST_PAYLOAD_MASK | VHOST_REQ_MASK
+				| VHOST_WRITE_MASK | VHOST_COMP_MASK | VHOST_RWR_MASK
+				| VHOST_END_MASK,
+		.length = VHOST_BTH_BYTES + VHOST_IMMDT_BYTES + VHOST_DETH_BYTES
+				+ VHOST_RDETH_BYTES,
+		.offset = {
+			[VHOST_RDMA_BTH]	= 0,
+			[VHOST_RDMA_RDETH]	= VHOST_BTH_BYTES,
+			[VHOST_RDMA_DETH]	= VHOST_BTH_BYTES
+						+ VHOST_RDETH_BYTES,
+			[VHOST_RDMA_IMMDT]	= VHOST_BTH_BYTES
+						+ VHOST_RDETH_BYTES
+						+ VHOST_DETH_BYTES,
+			[VHOST_RDMA_PAYLOAD]	= VHOST_BTH_BYTES
+						+ VHOST_RDETH_BYTES
+						+ VHOST_DETH_BYTES
+						+ VHOST_IMMDT_BYTES,
+		}
+	},
+	[IB_OPCODE_RD_RDMA_WRITE_ONLY]			= {
+		.name	= "IB_OPCODE_RD_RDMA_WRITE_ONLY",
+		.mask	= VHOST_RDETH_MASK | VHOST_DETH_MASK | VHOST_RETH_MASK
+				| VHOST_PAYLOAD_MASK | VHOST_REQ_MASK
+				| VHOST_WRITE_MASK | VHOST_START_MASK
+				| VHOST_END_MASK,
+		.length = VHOST_BTH_BYTES + VHOST_RETH_BYTES + VHOST_DETH_BYTES
+				+ VHOST_RDETH_BYTES,
+		.offset = {
+			[VHOST_RDMA_BTH]	= 0,
+			[VHOST_RDMA_RDETH]	= VHOST_BTH_BYTES,
+			[VHOST_RDMA_DETH]	= VHOST_BTH_BYTES
+						+ VHOST_RDETH_BYTES,
+			[VHOST_RDMA_RETH]	= VHOST_BTH_BYTES
+						+ VHOST_RDETH_BYTES
+						+ VHOST_DETH_BYTES,
+			[VHOST_RDMA_PAYLOAD]	= VHOST_BTH_BYTES
+						+ VHOST_RDETH_BYTES
+						+ VHOST_DETH_BYTES
+						+ VHOST_RETH_BYTES,
+		}
+	},
+	[IB_OPCODE_RD_RDMA_WRITE_ONLY_WITH_IMMEDIATE]		= {
+		.name	= "IB_OPCODE_RD_RDMA_WRITE_ONLY_WITH_IMMEDIATE",
+		.mask	= VHOST_RDETH_MASK | VHOST_DETH_MASK | VHOST_RETH_MASK
+				| VHOST_IMMDT_MASK | VHOST_PAYLOAD_MASK
+				| VHOST_REQ_MASK | VHOST_WRITE_MASK
+				| VHOST_COMP_MASK | VHOST_RWR_MASK
+				| VHOST_START_MASK | VHOST_END_MASK,
+		.length = VHOST_BTH_BYTES + VHOST_IMMDT_BYTES + VHOST_RETH_BYTES
+				+ VHOST_DETH_BYTES + VHOST_RDETH_BYTES,
+		.offset = {
+			[VHOST_RDMA_BTH]	= 0,
+			[VHOST_RDMA_RDETH]	= VHOST_BTH_BYTES,
+			[VHOST_RDMA_DETH]	= VHOST_BTH_BYTES
+						+ VHOST_RDETH_BYTES,
+			[VHOST_RDMA_RETH]	= VHOST_BTH_BYTES
+						+ VHOST_RDETH_BYTES
+						+ VHOST_DETH_BYTES,
+			[VHOST_RDMA_IMMDT]	= VHOST_BTH_BYTES
+						+ VHOST_RDETH_BYTES
+						+ VHOST_DETH_BYTES
+						+ VHOST_RETH_BYTES,
+			[VHOST_RDMA_PAYLOAD]	= VHOST_BTH_BYTES
+						+ VHOST_RDETH_BYTES
+						+ VHOST_DETH_BYTES
+						+ VHOST_RETH_BYTES
+						+ VHOST_IMMDT_BYTES,
+		}
+	},
+	[IB_OPCODE_RD_RDMA_READ_REQUEST]			= {
+		.name	= "IB_OPCODE_RD_RDMA_READ_REQUEST",
+		.mask	= VHOST_RDETH_MASK | VHOST_DETH_MASK | VHOST_RETH_MASK
+				| VHOST_REQ_MASK | VHOST_READ_MASK
+				| VHOST_START_MASK | VHOST_END_MASK,
+		.length = VHOST_BTH_BYTES + VHOST_RETH_BYTES + VHOST_DETH_BYTES
+				+ VHOST_RDETH_BYTES,
+		.offset = {
+			[VHOST_RDMA_BTH]	= 0,
+			[VHOST_RDMA_RDETH]	= VHOST_BTH_BYTES,
+			[VHOST_RDMA_DETH]	= VHOST_BTH_BYTES
+						+ VHOST_RDETH_BYTES,
+			[VHOST_RDMA_RETH]	= VHOST_BTH_BYTES
+						+ VHOST_RDETH_BYTES
+						+ VHOST_DETH_BYTES,
+			[VHOST_RDMA_PAYLOAD]	= VHOST_BTH_BYTES
+						+ VHOST_RETH_BYTES
+						+ VHOST_DETH_BYTES
+						+ VHOST_RDETH_BYTES,
+		}
+	},
+	[IB_OPCODE_RD_RDMA_READ_RESPONSE_FIRST]		= {
+		.name	= "IB_OPCODE_RD_RDMA_READ_RESPONSE_FIRST",
+		.mask	= VHOST_RDETH_MASK | VHOST_AETH_MASK
+				| VHOST_PAYLOAD_MASK | VHOST_ACK_MASK
+				| VHOST_START_MASK,
+		.length = VHOST_BTH_BYTES + VHOST_AETH_BYTES + VHOST_RDETH_BYTES,
+		.offset = {
+			[VHOST_RDMA_BTH]	= 0,
+			[VHOST_RDMA_RDETH]	= VHOST_BTH_BYTES,
+			[VHOST_RDMA_AETH]	= VHOST_BTH_BYTES
+						+ VHOST_RDETH_BYTES,
+			[VHOST_RDMA_PAYLOAD]	= VHOST_BTH_BYTES
+						+ VHOST_RDETH_BYTES
+						+ VHOST_AETH_BYTES,
+		}
+	},
+	[IB_OPCODE_RD_RDMA_READ_RESPONSE_MIDDLE]		= {
+		.name	= "IB_OPCODE_RD_RDMA_READ_RESPONSE_MIDDLE",
+		.mask	= VHOST_RDETH_MASK | VHOST_PAYLOAD_MASK | VHOST_ACK_MASK
+				| VHOST_MIDDLE_MASK,
+		.length = VHOST_BTH_BYTES + VHOST_RDETH_BYTES,
+		.offset = {
+			[VHOST_RDMA_BTH]	= 0,
+			[VHOST_RDMA_RDETH]	= VHOST_BTH_BYTES,
+			[VHOST_RDMA_PAYLOAD]	= VHOST_BTH_BYTES
+						+ VHOST_RDETH_BYTES,
+		}
+	},
+	[IB_OPCODE_RD_RDMA_READ_RESPONSE_LAST]		= {
+		.name	= "IB_OPCODE_RD_RDMA_READ_RESPONSE_LAST",
+		.mask	= VHOST_RDETH_MASK | VHOST_AETH_MASK | VHOST_PAYLOAD_MASK
+				| VHOST_ACK_MASK | VHOST_END_MASK,
+		.length = VHOST_BTH_BYTES + VHOST_AETH_BYTES + VHOST_RDETH_BYTES,
+		.offset = {
+			[VHOST_RDMA_BTH]	= 0,
+			[VHOST_RDMA_RDETH]	= VHOST_BTH_BYTES,
+			[VHOST_RDMA_AETH]	= VHOST_BTH_BYTES
+						+ VHOST_RDETH_BYTES,
+			[VHOST_RDMA_PAYLOAD]	= VHOST_BTH_BYTES
+						+ VHOST_RDETH_BYTES
+						+ VHOST_AETH_BYTES,
+		}
+	},
+	[IB_OPCODE_RD_RDMA_READ_RESPONSE_ONLY]		= {
+		.name	= "IB_OPCODE_RD_RDMA_READ_RESPONSE_ONLY",
+		.mask	= VHOST_RDETH_MASK | VHOST_AETH_MASK | VHOST_PAYLOAD_MASK
+				| VHOST_ACK_MASK | VHOST_START_MASK | VHOST_END_MASK,
+		.length = VHOST_BTH_BYTES + VHOST_AETH_BYTES + VHOST_RDETH_BYTES,
+		.offset = {
+			[VHOST_RDMA_BTH]	= 0,
+			[VHOST_RDMA_RDETH]	= VHOST_BTH_BYTES,
+			[VHOST_RDMA_AETH]	= VHOST_BTH_BYTES
+						+ VHOST_RDETH_BYTES,
+			[VHOST_RDMA_PAYLOAD]	= VHOST_BTH_BYTES
+						+ VHOST_RDETH_BYTES
+						+ VHOST_AETH_BYTES,
+		}
+	},
+	[IB_OPCODE_RD_ACKNOWLEDGE]			= {
+		.name	= "IB_OPCODE_RD_ACKNOWLEDGE",
+		.mask	= VHOST_RDETH_MASK | VHOST_AETH_MASK | VHOST_ACK_MASK
+				| VHOST_START_MASK | VHOST_END_MASK,
+		.length = VHOST_BTH_BYTES + VHOST_AETH_BYTES + VHOST_RDETH_BYTES,
+		.offset = {
+			[VHOST_RDMA_BTH]	= 0,
+			[VHOST_RDMA_RDETH]	= VHOST_BTH_BYTES,
+			[VHOST_RDMA_AETH]	= VHOST_BTH_BYTES
+						+ VHOST_RDETH_BYTES,
+		}
+	},
+	[IB_OPCODE_RD_ATOMIC_ACKNOWLEDGE]			= {
+		.name	= "IB_OPCODE_RD_ATOMIC_ACKNOWLEDGE",
+		.mask	= VHOST_RDETH_MASK | VHOST_AETH_MASK | VHOST_ATMACK_MASK
+				| VHOST_ACK_MASK | VHOST_START_MASK | VHOST_END_MASK,
+		.length = VHOST_BTH_BYTES + VHOST_ATMACK_BYTES + VHOST_AETH_BYTES
+				+ VHOST_RDETH_BYTES,
+		.offset = {
+			[VHOST_RDMA_BTH]	= 0,
+			[VHOST_RDMA_RDETH]	= VHOST_BTH_BYTES,
+			[VHOST_RDMA_AETH]	= VHOST_BTH_BYTES
+						+ VHOST_RDETH_BYTES,
+			[VHOST_RDMA_ATMACK]	= VHOST_BTH_BYTES
+						+ VHOST_RDETH_BYTES
+						+ VHOST_AETH_BYTES,
+		}
+	},
+	[IB_OPCODE_RD_COMPARE_SWAP]			= {
+		.name	= "RD_COMPARE_SWAP",
+		.mask	= VHOST_RDETH_MASK | VHOST_DETH_MASK | VHOST_ATMETH_MASK
+				| VHOST_REQ_MASK | VHOST_ATOMIC_MASK
+				| VHOST_START_MASK | VHOST_END_MASK,
+		.length = VHOST_BTH_BYTES + VHOST_ATMETH_BYTES + VHOST_DETH_BYTES
+				+ VHOST_RDETH_BYTES,
+		.offset = {
+			[VHOST_RDMA_BTH]	= 0,
+			[VHOST_RDMA_RDETH]	= VHOST_BTH_BYTES,
+			[VHOST_RDMA_DETH]	= VHOST_BTH_BYTES
+						+ VHOST_RDETH_BYTES,
+			[VHOST_RDMA_ATMETH]	= VHOST_BTH_BYTES
+						+ VHOST_RDETH_BYTES
+						+ VHOST_DETH_BYTES,
+			[VHOST_RDMA_PAYLOAD]	= VHOST_BTH_BYTES +
+						+ VHOST_ATMETH_BYTES
+						+ VHOST_DETH_BYTES +
+						+ VHOST_RDETH_BYTES,
+		}
+	},
+	[IB_OPCODE_RD_FETCH_ADD]			= {
+		.name	= "IB_OPCODE_RD_FETCH_ADD",
+		.mask	= VHOST_RDETH_MASK | VHOST_DETH_MASK | VHOST_ATMETH_MASK
+				| VHOST_REQ_MASK | VHOST_ATOMIC_MASK
+				| VHOST_START_MASK | VHOST_END_MASK,
+		.length = VHOST_BTH_BYTES + VHOST_ATMETH_BYTES + VHOST_DETH_BYTES
+				+ VHOST_RDETH_BYTES,
+		.offset = {
+			[VHOST_RDMA_BTH]	= 0,
+			[VHOST_RDMA_RDETH]	= VHOST_BTH_BYTES,
+			[VHOST_RDMA_DETH]	= VHOST_BTH_BYTES
+						+ VHOST_RDETH_BYTES,
+			[VHOST_RDMA_ATMETH]	= VHOST_BTH_BYTES
+						+ VHOST_RDETH_BYTES
+						+ VHOST_DETH_BYTES,
+			[VHOST_RDMA_PAYLOAD]	= VHOST_BTH_BYTES +
+						+ VHOST_ATMETH_BYTES
+						+ VHOST_DETH_BYTES +
+						+ VHOST_RDETH_BYTES,
+		}
+	},
+
+	/* UD */
+	[IB_OPCODE_UD_SEND_ONLY]			= {
+		.name	= "IB_OPCODE_UD_SEND_ONLY",
+		.mask	= VHOST_DETH_MASK | VHOST_PAYLOAD_MASK | VHOST_REQ_MASK
+				| VHOST_COMP_MASK | VHOST_RWR_MASK | VHOST_SEND_MASK
+				| VHOST_START_MASK | VHOST_END_MASK,
+		.length = VHOST_BTH_BYTES + VHOST_DETH_BYTES,
+		.offset = {
+			[VHOST_RDMA_BTH]	= 0,
+			[VHOST_RDMA_DETH]	= VHOST_BTH_BYTES,
+			[VHOST_RDMA_PAYLOAD]	= VHOST_BTH_BYTES
+						+ VHOST_DETH_BYTES,
+		}
+	},
+	[IB_OPCODE_UD_SEND_ONLY_WITH_IMMEDIATE]		= {
+		.name	= "IB_OPCODE_UD_SEND_ONLY_WITH_IMMEDIATE",
+		.mask	= VHOST_DETH_MASK | VHOST_IMMDT_MASK | VHOST_PAYLOAD_MASK
+				| VHOST_REQ_MASK | VHOST_COMP_MASK | VHOST_RWR_MASK
+				| VHOST_SEND_MASK | VHOST_START_MASK | VHOST_END_MASK,
+		.length = VHOST_BTH_BYTES + VHOST_IMMDT_BYTES + VHOST_DETH_BYTES,
+		.offset = {
+			[VHOST_RDMA_BTH]	= 0,
+			[VHOST_RDMA_DETH]	= VHOST_BTH_BYTES,
+			[VHOST_RDMA_IMMDT]	= VHOST_BTH_BYTES
+						+ VHOST_DETH_BYTES,
+			[VHOST_RDMA_PAYLOAD]	= VHOST_BTH_BYTES
+						+ VHOST_DETH_BYTES
+						+ VHOST_IMMDT_BYTES,
+		}
+	},
+
+};
\ No newline at end of file
diff --git a/examples/vhost_user_rdma/vhost_rdma_opcode.h b/examples/vhost_user_rdma/vhost_rdma_opcode.h
new file mode 100644
index 0000000000..b8f48bcdf5
--- /dev/null
+++ b/examples/vhost_user_rdma/vhost_rdma_opcode.h
@@ -0,0 +1,330 @@
+/**
+ * @file vhost_rdma_opcode.h
+ * @brief Vhost-user RDMA packet format and opcode definitions.
+ *
+ * This header defines the internal packet representation, InfiniBand/RoCE header layout,
+ * opcode mapping, and control flags used during packet parsing and transmission
+ * in the vhost-user RDMA backend.
+ *
+ * Copyright (C) 2025 KylinSoft Inc. and/or its affiliates. All rights reserved.
+ *
+ * Author: Xiong Weimin <xiongweimin@kylinos.cn>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+#ifndef __VHOST_RDMA_OPCODE_H__
+#define __VHOST_RDMA_OPCODE_H__
+
+#include <stdint.h>
+
+#include <rte_byteorder.h>
+#include <rte_interrupts.h>
+
+#include "vhost_rdma_ib.h"
+
+/** Maximum number of QP types supported for WR mask dispatching */
+#define WR_MAX_QPT                  8
+
+/** Total number of defined opcodes (must be power-of-2 >= 256) */
+#define VHOST_NUM_OPCODE            256
+
+#ifndef BIT
+	#define BIT(x)	(1 << (x))
+#endif
+
+/* Invalid opcode marker */
+#define OPCODE_NONE                 (-1)
+
+struct vhost_bth {
+	uint8_t			opcode;
+	uint8_t			flags;
+	rte_be16_t		pkey;
+	rte_be32_t		qpn;
+	rte_be32_t		apsn;
+};
+
+struct vhost_deth {
+	rte_be32_t			qkey;
+	rte_be32_t			sqp;
+};
+
+struct vhost_immdt {
+	rte_be32_t			imm;
+};
+
+struct vhost_reth {
+	rte_be64_t			va;
+	rte_be32_t			rkey;
+	rte_be32_t			len;
+};
+
+struct vhost_aeth {
+	rte_be32_t			smsn;
+};
+
+struct vhost_atmack {
+	rte_be64_t			orig;
+};
+
+struct vhost_atmeth {
+	rte_be64_t			va;
+	rte_be32_t			rkey;
+	rte_be64_t			swap_add;
+	rte_be64_t			comp;
+} __rte_packed;
+
+struct vhost_ieth {
+	rte_be32_t			rkey;
+};
+
+struct vhost_rdeth {
+	rte_be32_t			een;
+};
+
+enum vhost_rdma_hdr_length {
+	VHOST_BTH_BYTES	    	= sizeof(struct vhost_bth),
+	VHOST_DETH_BYTES		= sizeof(struct vhost_deth),
+	VHOST_IMMDT_BYTES		= sizeof(struct vhost_immdt),
+	VHOST_RETH_BYTES		= sizeof(struct vhost_reth),
+	VHOST_AETH_BYTES		= sizeof(struct vhost_aeth),
+	VHOST_ATMACK_BYTES	    = sizeof(struct vhost_atmack),
+	VHOST_ATMETH_BYTES  	= sizeof(struct vhost_atmeth),
+	VHOST_IETH_BYTES		= sizeof(struct vhost_ieth),
+	VHOST_RDETH_BYTES		= sizeof(struct vhost_rdeth),
+};
+
+/**
+ * @brief Helper macro to define IB opcodes by transport and operation
+ *
+ * Expands to e.g.: `IB_OPCODE_RC_SEND_FIRST = IB_OPCODE_RC + IB_OPCODE_SEND_FIRST`
+ */
+#define IB_OPCODE(transport, op) \
+    IB_OPCODE_ ## transport ## _ ## op = \
+        (IB_OPCODE_ ## transport + IB_OPCODE_ ## op)
+
+/**
+ * @defgroup ib_opcodes InfiniBand OpCode Definitions
+ *
+ * Based on IBTA Vol 1 Table 38 and extended for RoCE semantics.
+ * @{
+ */
+
+enum {
+    /* Transport types (base values) */
+    IB_OPCODE_RC                                = 0x00,  /**< Reliable Connection */
+    IB_OPCODE_UC                                = 0x20,  /**< Unreliable Connection */
+    IB_OPCODE_RD                                = 0x40,  /**< Reliable Datagram */
+    IB_OPCODE_UD                                = 0x60,  /**< Unreliable Datagram */
+    IB_OPCODE_CNP                               = 0x80,  /**< Congestion Notification Packet */
+    IB_OPCODE_MSP                               = 0xe0,  /**< Manufacturer Specific Protocol */
+
+    /* Operation subtypes */
+    IB_OPCODE_SEND_FIRST                        = 0x00,
+    IB_OPCODE_SEND_MIDDLE                       = 0x01,
+    IB_OPCODE_SEND_LAST                         = 0x02,
+    IB_OPCODE_SEND_LAST_WITH_IMMEDIATE          = 0x03,
+    IB_OPCODE_SEND_ONLY                         = 0x04,
+    IB_OPCODE_SEND_ONLY_WITH_IMMEDIATE          = 0x05,
+    IB_OPCODE_RDMA_WRITE_FIRST                  = 0x06,
+    IB_OPCODE_RDMA_WRITE_MIDDLE                 = 0x07,
+    IB_OPCODE_RDMA_WRITE_LAST                   = 0x08,
+    IB_OPCODE_RDMA_WRITE_LAST_WITH_IMMEDIATE    = 0x09,
+    IB_OPCODE_RDMA_WRITE_ONLY                   = 0x0a,
+    IB_OPCODE_RDMA_WRITE_ONLY_WITH_IMMEDIATE    = 0x0b,
+    IB_OPCODE_RDMA_READ_REQUEST                 = 0x0c,
+    IB_OPCODE_RDMA_READ_RESPONSE_FIRST          = 0x0d,
+    IB_OPCODE_RDMA_READ_RESPONSE_MIDDLE         = 0x0e,
+    IB_OPCODE_RDMA_READ_RESPONSE_LAST           = 0x0f,
+    IB_OPCODE_RDMA_READ_RESPONSE_ONLY           = 0x10,
+    IB_OPCODE_ACKNOWLEDGE                       = 0x11,
+    IB_OPCODE_ATOMIC_ACKNOWLEDGE                = 0x12,
+    IB_OPCODE_COMPARE_SWAP                      = 0x13,
+    IB_OPCODE_FETCH_ADD                         = 0x14,
+    /* 0x15 is reserved */
+    IB_OPCODE_SEND_LAST_WITH_INVALIDATE         = 0x16,
+    IB_OPCODE_SEND_ONLY_WITH_INVALIDATE         = 0x17,
+
+    /* Real opcodes generated via IB_OPCODE() macro */
+    IB_OPCODE(RC, SEND_FIRST),
+    IB_OPCODE(RC, SEND_MIDDLE),
+    IB_OPCODE(RC, SEND_LAST),
+    IB_OPCODE(RC, SEND_LAST_WITH_IMMEDIATE),
+    IB_OPCODE(RC, SEND_ONLY),
+    IB_OPCODE(RC, SEND_ONLY_WITH_IMMEDIATE),
+    IB_OPCODE(RC, RDMA_WRITE_FIRST),
+    IB_OPCODE(RC, RDMA_WRITE_MIDDLE),
+    IB_OPCODE(RC, RDMA_WRITE_LAST),
+    IB_OPCODE(RC, RDMA_WRITE_LAST_WITH_IMMEDIATE),
+    IB_OPCODE(RC, RDMA_WRITE_ONLY),
+    IB_OPCODE(RC, RDMA_WRITE_ONLY_WITH_IMMEDIATE),
+    IB_OPCODE(RC, RDMA_READ_REQUEST),
+    IB_OPCODE(RC, RDMA_READ_RESPONSE_FIRST),
+    IB_OPCODE(RC, RDMA_READ_RESPONSE_MIDDLE),
+    IB_OPCODE(RC, RDMA_READ_RESPONSE_LAST),
+    IB_OPCODE(RC, RDMA_READ_RESPONSE_ONLY),
+    IB_OPCODE(RC, ACKNOWLEDGE),
+    IB_OPCODE(RC, ATOMIC_ACKNOWLEDGE),
+    IB_OPCODE(RC, COMPARE_SWAP),
+    IB_OPCODE(RC, FETCH_ADD),
+    IB_OPCODE(RC, SEND_LAST_WITH_INVALIDATE),
+    IB_OPCODE(RC, SEND_ONLY_WITH_INVALIDATE),
+
+    /* UC opcodes */
+    IB_OPCODE(UC, SEND_FIRST),
+    IB_OPCODE(UC, SEND_MIDDLE),
+    IB_OPCODE(UC, SEND_LAST),
+    IB_OPCODE(UC, SEND_LAST_WITH_IMMEDIATE),
+    IB_OPCODE(UC, SEND_ONLY),
+    IB_OPCODE(UC, SEND_ONLY_WITH_IMMEDIATE),
+    IB_OPCODE(UC, RDMA_WRITE_FIRST),
+    IB_OPCODE(UC, RDMA_WRITE_MIDDLE),
+    IB_OPCODE(UC, RDMA_WRITE_LAST),
+    IB_OPCODE(UC, RDMA_WRITE_LAST_WITH_IMMEDIATE),
+    IB_OPCODE(UC, RDMA_WRITE_ONLY),
+    IB_OPCODE(UC, RDMA_WRITE_ONLY_WITH_IMMEDIATE),
+
+    /* RD opcodes */
+    IB_OPCODE(RD, SEND_FIRST),
+    IB_OPCODE(RD, SEND_MIDDLE),
+    IB_OPCODE(RD, SEND_LAST),
+    IB_OPCODE(RD, SEND_LAST_WITH_IMMEDIATE),
+    IB_OPCODE(RD, SEND_ONLY),
+    IB_OPCODE(RD, SEND_ONLY_WITH_IMMEDIATE),
+    IB_OPCODE(RD, RDMA_WRITE_FIRST),
+    IB_OPCODE(RD, RDMA_WRITE_MIDDLE),
+    IB_OPCODE(RD, RDMA_WRITE_LAST),
+    IB_OPCODE(RD, RDMA_WRITE_LAST_WITH_IMMEDIATE),
+    IB_OPCODE(RD, RDMA_WRITE_ONLY),
+    IB_OPCODE(RD, RDMA_WRITE_ONLY_WITH_IMMEDIATE),
+    IB_OPCODE(RD, RDMA_READ_REQUEST),
+    IB_OPCODE(RD, RDMA_READ_RESPONSE_FIRST),
+    IB_OPCODE(RD, RDMA_READ_RESPONSE_MIDDLE),
+    IB_OPCODE(RD, RDMA_READ_RESPONSE_LAST),
+    IB_OPCODE(RD, RDMA_READ_RESPONSE_ONLY),
+    IB_OPCODE(RD, ACKNOWLEDGE),
+    IB_OPCODE(RD, ATOMIC_ACKNOWLEDGE),
+    IB_OPCODE(RD, COMPARE_SWAP),
+    IB_OPCODE(RD, FETCH_ADD),
+
+    /* UD opcodes */
+    IB_OPCODE(UD, SEND_ONLY),
+    IB_OPCODE(UD, SEND_ONLY_WITH_IMMEDIATE)
+};
+/** @} */
+
+/**
+ * @defgroup wr_masks Work Request Type Masks
+ * @{
+ */
+enum vhost_rdma_wr_mask {
+    WR_INLINE_MASK              = BIT(0),   /**< WR contains inline data */
+    WR_ATOMIC_MASK              = BIT(1),   /**< WR is an atomic operation */
+    WR_SEND_MASK                = BIT(2),   /**< WR is a send-type operation */
+    WR_READ_MASK                = BIT(3),   /**< WR initiates RDMA read */
+    WR_WRITE_MASK               = BIT(4),   /**< WR performs RDMA write */
+    WR_LOCAL_OP_MASK            = BIT(5),   /**< WR triggers local memory op */
+
+    WR_READ_OR_WRITE_MASK       = WR_READ_MASK | WR_WRITE_MASK,
+    WR_READ_WRITE_OR_SEND_MASK  = WR_READ_OR_WRITE_MASK | WR_SEND_MASK,
+    WR_WRITE_OR_SEND_MASK       = WR_WRITE_MASK | WR_SEND_MASK,
+    WR_ATOMIC_OR_READ_MASK      = WR_ATOMIC_MASK | WR_READ_MASK,
+};
+
+/**
+ * @brief Metadata about each Work Request (WR) opcode
+ *
+ * Used to determine which operations are valid per QP type.
+ */
+struct vhost_rdma_wr_opcode_info {
+    const char *name;                         /**< Human-readable name */
+    enum vhost_rdma_wr_mask mask[WR_MAX_QPT]; /**< Validity per QP type */
+};
+
+/* Extern declaration of global opcode metadata table */
+extern struct vhost_rdma_wr_opcode_info vhost_rdma_wr_opcode_info[];
+
+/* vhost_rdma_opcode */
+static inline unsigned int wr_opcode_mask(int opcode, struct vhost_rdma_qp *qp)
+{
+	return vhost_rdma_wr_opcode_info[opcode].mask[qp->type];
+}
+
+/**
+ * @defgroup hdr_types Header Types (for offset tracking)
+ * @{
+ */
+enum vhost_rdma_hdr_type {
+    VHOST_RDMA_LRH,           /**< Link Layer Header (InfiniBand only) */
+    VHOST_RDMA_GRH,           /**< Global Route Header (IPv6-style GIDs) */
+    VHOST_RDMA_BTH,           /**< Base Transport Header */
+    VHOST_RDMA_RETH,          /**< RDMA Extended Transport Header */
+    VHOST_RDMA_AETH,          /**< Acknowledge/Error Header */
+    VHOST_RDMA_ATMETH,        /**< Atomic Operation Request Header */
+    VHOST_RDMA_ATMACK,        /**< Atomic Operation Response Header */
+    VHOST_RDMA_IETH,          /**< Immediate Data + Error Code Header */
+    VHOST_RDMA_RDETH,         /**< Reliable Datagram Extended Transport Header */
+    VHOST_RDMA_DETH,          /**< Datagram Endpoint Identifier Header */
+    VHOST_RDMA_IMMDT,         /**< Immediate Data Header */
+    VHOST_RDMA_PAYLOAD,       /**< Payload section */
+    NUM_HDR_TYPES             /**< Number of known header types */
+};
+
+/**
+ * @defgroup hdr_masks Header Presence and Semantic Flags
+ * @{
+ */
+enum vhost_rdma_hdr_mask {
+    VHOST_LRH_MASK            = BIT(VHOST_RDMA_LRH),
+    VHOST_GRH_MASK            = BIT(VHOST_RDMA_GRH),
+    VHOST_BTH_MASK            = BIT(VHOST_RDMA_BTH),
+    VHOST_IMMDT_MASK          = BIT(VHOST_RDMA_IMMDT),
+    VHOST_RETH_MASK           = BIT(VHOST_RDMA_RETH),
+    VHOST_AETH_MASK           = BIT(VHOST_RDMA_AETH),
+    VHOST_ATMETH_MASK         = BIT(VHOST_RDMA_ATMETH),
+    VHOST_ATMACK_MASK         = BIT(VHOST_RDMA_ATMACK),
+    VHOST_IETH_MASK           = BIT(VHOST_RDMA_IETH),
+    VHOST_RDETH_MASK          = BIT(VHOST_RDMA_RDETH),
+    VHOST_DETH_MASK           = BIT(VHOST_RDMA_DETH),
+    VHOST_PAYLOAD_MASK        = BIT(VHOST_RDMA_PAYLOAD),
+
+    /* Semantic packet type flags */
+    VHOST_REQ_MASK            = BIT(NUM_HDR_TYPES + 0),  /**< Request packet */
+    VHOST_ACK_MASK            = BIT(NUM_HDR_TYPES + 1),  /**< ACK/NACK packet */
+    VHOST_SEND_MASK           = BIT(NUM_HDR_TYPES + 2),  /**< Send operation */
+    VHOST_WRITE_MASK          = BIT(NUM_HDR_TYPES + 3),  /**< RDMA Write */
+    VHOST_READ_MASK           = BIT(NUM_HDR_TYPES + 4),  /**< RDMA Read */
+    VHOST_ATOMIC_MASK         = BIT(NUM_HDR_TYPES + 5),  /**< Atomic operation */
+
+    /* Packet fragmentation flags */
+    VHOST_RWR_MASK            = BIT(NUM_HDR_TYPES + 6),  /**< RDMA with Immediate + Invalidate */
+    VHOST_COMP_MASK           = BIT(NUM_HDR_TYPES + 7),  /**< Completion required */
+
+    VHOST_START_MASK          = BIT(NUM_HDR_TYPES + 8),  /**< First fragment */
+    VHOST_MIDDLE_MASK         = BIT(NUM_HDR_TYPES + 9),  /**< Middle fragment */
+    VHOST_END_MASK            = BIT(NUM_HDR_TYPES + 10), /**< Last fragment */
+
+    VHOST_LOOPBACK_MASK       = BIT(NUM_HDR_TYPES + 12), /**< Loopback within host */
+
+    /* Composite masks */
+    VHOST_READ_OR_ATOMIC      = (VHOST_READ_MASK | VHOST_ATOMIC_MASK),
+    VHOST_WRITE_OR_SEND       = (VHOST_WRITE_MASK | VHOST_SEND_MASK),
+};
+/** @} */
+
+/**
+ * @brief Per-opcode metadata for parsing and validation
+ */
+struct vhost_rdma_opcode_info {
+    const char *name;                             /**< Opcode name (e.g., "RC SEND_FIRST") */
+    int length;                                   /**< Fixed payload length (if any) */
+    int offset[NUM_HDR_TYPES];                    /**< Offset of each header within packet */
+    enum vhost_rdma_hdr_mask mask;                /**< Header presence and semantic flags */
+};
+
+/* Global opcode info table (indexed by IB opcode byte) */
+extern struct vhost_rdma_opcode_info vhost_rdma_opcode[VHOST_NUM_OPCODE];
+
+#endif
\ No newline at end of file
diff --git a/examples/vhost_user_rdma/vhost_rdma_pkt.h b/examples/vhost_user_rdma/vhost_rdma_pkt.h
index 2bbc030e0a..e6a605f574 100644
--- a/examples/vhost_user_rdma/vhost_rdma_pkt.h
+++ b/examples/vhost_user_rdma/vhost_rdma_pkt.h
@@ -39,244 +39,6 @@ struct vhost_rdma_send_wqe;
  * @{
  */
 
-/** Maximum number of QP types supported for WR mask dispatching */
-#define WR_MAX_QPT					8
-
-/** Invalid opcode marker */
-#define OPCODE_NONE					(-1)
-
-/** Total number of defined opcodes (must be power-of-2 >= 256) */
-#define VHOST_NUM_OPCODE			256
-
-/** @} */
-
-/**
- * @defgroup wr_masks Work Request Type Masks
- * @{
- */
-enum vhost_rdma_wr_mask {
-	WR_INLINE_MASK				= BIT(0),	 /**< WR contains inline data */
-	WR_ATOMIC_MASK				= BIT(1),	 /**< WR is an atomic operation */
-	WR_SEND_MASK				= BIT(2),	 /**< WR is a send-type operation */
-	WR_READ_MASK				= BIT(3),	 /**< WR initiates RDMA read */
-	WR_WRITE_MASK				= BIT(4),	 /**< WR performs RDMA write */
-	WR_LOCAL_OP_MASK			= BIT(5),	 /**< WR triggers local memory op */
-
-	WR_READ_OR_WRITE_MASK		= WR_READ_MASK | WR_WRITE_MASK,
-	WR_READ_WRITE_OR_SEND_MASK	= WR_READ_OR_WRITE_MASK | WR_SEND_MASK,
-	WR_WRITE_OR_SEND_MASK		= WR_WRITE_MASK | WR_SEND_MASK,
-	WR_ATOMIC_OR_READ_MASK		= WR_ATOMIC_MASK | WR_READ_MASK,
-};
-/** @} */
-
-/**
- * @brief Metadata about each Work Request (WR) opcode
- *
- * Used to determine which operations are valid per QP type.
- */
-struct vhost_rdma_wr_opcode_info {
-	const char *name;							/**< Human-readable name */
-	enum vhost_rdma_wr_mask mask[WR_MAX_QPT];	/**< Validity per QP type */
-};
-
-/* Extern declaration of global opcode metadata table */
-extern struct vhost_rdma_wr_opcode_info vhost_rdma_wr_opcode_info[];
-
-/**
- * @defgroup hdr_types Header Types (for offset tracking)
- * @{
- */
-enum vhost_rdma_hdr_type {
-	VHOST_RDMA_LRH,			/**< Link Layer Header (InfiniBand only) */
-	VHOST_RDMA_GRH,			/**< Global Route Header (IPv6-style GIDs) */
-	VHOST_RDMA_BTH,			/**< Base Transport Header */
-	VHOST_RDMA_RETH,		/**< RDMA Extended Transport Header */
-	VHOST_RDMA_AETH,		/**< Acknowledge/Error Header */
-	VHOST_RDMA_ATMETH,		/**< Atomic Operation Request Header */
-	VHOST_RDMA_ATMACK,		/**< Atomic Operation Response Header */
-	VHOST_RDMA_IETH,		/**< Immediate Data + Error Code Header */
-	VHOST_RDMA_RDETH,		/**< Reliable Datagram Extended Transport Header */
-	VHOST_RDMA_DETH,		/**< Datagram Endpoint Identifier Header */
-	VHOST_RDMA_IMMDT,		/**< Immediate Data Header */
-	VHOST_RDMA_PAYLOAD,		/**< Payload section */
-	NUM_HDR_TYPES			/**< Number of known header types */
-};
-/** @} */
-
-/**
- * @defgroup hdr_masks Header Presence and Semantic Flags
- * @{
- */
-enum vhost_rdma_hdr_mask {
-	VHOST_LRH_MASK			= BIT(VHOST_RDMA_LRH),
-	VHOST_GRH_MASK			= BIT(VHOST_RDMA_GRH),
-	VHOST_BTH_MASK			= BIT(VHOST_RDMA_BTH),
-	VHOST_IMMDT_MASK		= BIT(VHOST_RDMA_IMMDT),
-	VHOST_RETH_MASK			= BIT(VHOST_RDMA_RETH),
-	VHOST_AETH_MASK			= BIT(VHOST_RDMA_AETH),
-	VHOST_ATMETH_MASK		= BIT(VHOST_RDMA_ATMETH),
-	VHOST_ATMACK_MASK		= BIT(VHOST_RDMA_ATMACK),
-	VHOST_IETH_MASK			= BIT(VHOST_RDMA_IETH),
-	VHOST_RDETH_MASK		= BIT(VHOST_RDMA_RDETH),
-	VHOST_DETH_MASK			= BIT(VHOST_RDMA_DETH),
-	VHOST_PAYLOAD_MASK		= BIT(VHOST_RDMA_PAYLOAD),
-
-	/* Semantic packet type flags */
-	VHOST_REQ_MASK			= BIT(NUM_HDR_TYPES + 0),	/**< Request packet */
-	VHOST_ACK_MASK			= BIT(NUM_HDR_TYPES + 1),	/**< ACK/NACK packet */
-	VHOST_SEND_MASK			= BIT(NUM_HDR_TYPES + 2),	/**< Send operation */
-	VHOST_WRITE_MASK		= BIT(NUM_HDR_TYPES + 3),	/**< RDMA Write */
-	VHOST_READ_MASK			= BIT(NUM_HDR_TYPES + 4),	/**< RDMA Read */
-	VHOST_ATOMIC_MASK		= BIT(NUM_HDR_TYPES + 5),	/**< Atomic operation */
-
-	/* Packet fragmentation flags */
-	VHOST_RWR_MASK			= BIT(NUM_HDR_TYPES + 6),	/**< RDMA with Immediate + Invalidate */
-	VHOST_COMP_MASK			= BIT(NUM_HDR_TYPES + 7),	/**< Completion required */
-
-	VHOST_START_MASK		= BIT(NUM_HDR_TYPES + 8),	/**< First fragment */
-	VHOST_MIDDLE_MASK		= BIT(NUM_HDR_TYPES + 9),	/**< Middle fragment */
-	VHOST_END_MASK			= BIT(NUM_HDR_TYPES + 10), /**< Last fragment */
-
-	VHOST_LOOPBACK_MASK		= BIT(NUM_HDR_TYPES + 12), /**< Loopback within host */
-
-	/* Composite masks */
-	VHOST_READ_OR_ATOMIC	= (VHOST_READ_MASK | VHOST_ATOMIC_MASK),
-	VHOST_WRITE_OR_SEND		= (VHOST_WRITE_MASK | VHOST_SEND_MASK),
-};
-/** @} */
-
-/**
- * @brief Per-opcode metadata for parsing and validation
- */
-struct vhost_rdma_opcode_info {
-	const char *name;							/**< Opcode name (e.g., "RC SEND_FIRST") */
-	int length;									/**< Fixed payload length (if any) */
-	int offset[NUM_HDR_TYPES];					/**< Offset of each header within packet */
-	enum vhost_rdma_hdr_mask mask;				/**< Header presence and semantic flags */
-};
-
-/* Global opcode info table (indexed by IB opcode byte) */
-extern struct vhost_rdma_opcode_info vhost_rdma_opcode[VHOST_NUM_OPCODE];
-
-/**
- * @brief Helper macro to define IB opcodes by transport and operation
- *
- * Expands to e.g.: `IB_OPCODE_RC_SEND_FIRST = IB_OPCODE_RC + IB_OPCODE_SEND_FIRST`
- */
-#define IB_OPCODE(transport, op) \
-	IB_OPCODE_ ## transport ## _ ## op = \
-		(IB_OPCODE_ ## transport + IB_OPCODE_ ## op)
-
-/**
- * @defgroup ib_opcodes InfiniBand OpCode Definitions
- *
- * Based on IBTA Vol 1 Table 38 and extended for RoCE semantics.
- * @{
- */
-
-enum {
-	/* Transport types (base values) */
-	IB_OPCODE_RC								= 0x00,	/**< Reliable Connection */
-	IB_OPCODE_UC								= 0x20,	/**< Unreliable Connection */
-	IB_OPCODE_RD								= 0x40,	/**< Reliable Datagram */
-	IB_OPCODE_UD								= 0x60,	/**< Unreliable Datagram */
-	IB_OPCODE_CNP								= 0x80,	/**< Congestion Notification Packet */
-	IB_OPCODE_MSP								= 0xe0,	/**< Manufacturer Specific Protocol */
-
-	/* Operation subtypes */
-	IB_OPCODE_SEND_FIRST						= 0x00,
-	IB_OPCODE_SEND_MIDDLE						= 0x01,
-	IB_OPCODE_SEND_LAST							= 0x02,
-	IB_OPCODE_SEND_LAST_WITH_IMMEDIATE			= 0x03,
-	IB_OPCODE_SEND_ONLY							= 0x04,
-	IB_OPCODE_SEND_ONLY_WITH_IMMEDIATE			= 0x05,
-	IB_OPCODE_RDMA_WRITE_FIRST					= 0x06,
-	IB_OPCODE_RDMA_WRITE_MIDDLE					= 0x07,
-	IB_OPCODE_RDMA_WRITE_LAST					= 0x08,
-	IB_OPCODE_RDMA_WRITE_LAST_WITH_IMMEDIATE	= 0x09,
-	IB_OPCODE_RDMA_WRITE_ONLY					= 0x0a,
-	IB_OPCODE_RDMA_WRITE_ONLY_WITH_IMMEDIATE	= 0x0b,
-	IB_OPCODE_RDMA_READ_REQUEST					= 0x0c,
-	IB_OPCODE_RDMA_READ_RESPONSE_FIRST			= 0x0d,
-	IB_OPCODE_RDMA_READ_RESPONSE_MIDDLE			= 0x0e,
-	IB_OPCODE_RDMA_READ_RESPONSE_LAST			= 0x0f,
-	IB_OPCODE_RDMA_READ_RESPONSE_ONLY			= 0x10,
-	IB_OPCODE_ACKNOWLEDGE						= 0x11,
-	IB_OPCODE_ATOMIC_ACKNOWLEDGE				= 0x12,
-	IB_OPCODE_COMPARE_SWAP						= 0x13,
-	IB_OPCODE_FETCH_ADD							= 0x14,
-	/* 0x15 is reserved */
-	IB_OPCODE_SEND_LAST_WITH_INVALIDATE			= 0x16,
-	IB_OPCODE_SEND_ONLY_WITH_INVALIDATE			= 0x17,
-
-	/* Real opcodes generated via IB_OPCODE() macro */
-	IB_OPCODE(RC, SEND_FIRST),
-	IB_OPCODE(RC, SEND_MIDDLE),
-	IB_OPCODE(RC, SEND_LAST),
-	IB_OPCODE(RC, SEND_LAST_WITH_IMMEDIATE),
-	IB_OPCODE(RC, SEND_ONLY),
-	IB_OPCODE(RC, SEND_ONLY_WITH_IMMEDIATE),
-	IB_OPCODE(RC, RDMA_WRITE_FIRST),
-	IB_OPCODE(RC, RDMA_WRITE_MIDDLE),
-	IB_OPCODE(RC, RDMA_WRITE_LAST),
-	IB_OPCODE(RC, RDMA_WRITE_LAST_WITH_IMMEDIATE),
-	IB_OPCODE(RC, RDMA_WRITE_ONLY),
-	IB_OPCODE(RC, RDMA_WRITE_ONLY_WITH_IMMEDIATE),
-	IB_OPCODE(RC, RDMA_READ_REQUEST),
-	IB_OPCODE(RC, RDMA_READ_RESPONSE_FIRST),
-	IB_OPCODE(RC, RDMA_READ_RESPONSE_MIDDLE),
-	IB_OPCODE(RC, RDMA_READ_RESPONSE_LAST),
-	IB_OPCODE(RC, RDMA_READ_RESPONSE_ONLY),
-	IB_OPCODE(RC, ACKNOWLEDGE),
-	IB_OPCODE(RC, ATOMIC_ACKNOWLEDGE),
-	IB_OPCODE(RC, COMPARE_SWAP),
-	IB_OPCODE(RC, FETCH_ADD),
-	IB_OPCODE(RC, SEND_LAST_WITH_INVALIDATE),
-	IB_OPCODE(RC, SEND_ONLY_WITH_INVALIDATE),
-
-	/* UC opcodes */
-	IB_OPCODE(UC, SEND_FIRST),
-	IB_OPCODE(UC, SEND_MIDDLE),
-	IB_OPCODE(UC, SEND_LAST),
-	IB_OPCODE(UC, SEND_LAST_WITH_IMMEDIATE),
-	IB_OPCODE(UC, SEND_ONLY),
-	IB_OPCODE(UC, SEND_ONLY_WITH_IMMEDIATE),
-	IB_OPCODE(UC, RDMA_WRITE_FIRST),
-	IB_OPCODE(UC, RDMA_WRITE_MIDDLE),
-	IB_OPCODE(UC, RDMA_WRITE_LAST),
-	IB_OPCODE(UC, RDMA_WRITE_LAST_WITH_IMMEDIATE),
-	IB_OPCODE(UC, RDMA_WRITE_ONLY),
-	IB_OPCODE(UC, RDMA_WRITE_ONLY_WITH_IMMEDIATE),
-
-	/* RD opcodes */
-	IB_OPCODE(RD, SEND_FIRST),
-	IB_OPCODE(RD, SEND_MIDDLE),
-	IB_OPCODE(RD, SEND_LAST),
-	IB_OPCODE(RD, SEND_LAST_WITH_IMMEDIATE),
-	IB_OPCODE(RD, SEND_ONLY),
-	IB_OPCODE(RD, SEND_ONLY_WITH_IMMEDIATE),
-	IB_OPCODE(RD, RDMA_WRITE_FIRST),
-	IB_OPCODE(RD, RDMA_WRITE_MIDDLE),
-	IB_OPCODE(RD, RDMA_WRITE_LAST),
-	IB_OPCODE(RD, RDMA_WRITE_LAST_WITH_IMMEDIATE),
-	IB_OPCODE(RD, RDMA_WRITE_ONLY),
-	IB_OPCODE(RD, RDMA_WRITE_ONLY_WITH_IMMEDIATE),
-	IB_OPCODE(RD, RDMA_READ_REQUEST),
-	IB_OPCODE(RD, RDMA_READ_RESPONSE_FIRST),
-	IB_OPCODE(RD, RDMA_READ_RESPONSE_MIDDLE),
-	IB_OPCODE(RD, RDMA_READ_RESPONSE_LAST),
-	IB_OPCODE(RD, RDMA_READ_RESPONSE_ONLY),
-	IB_OPCODE(RD, ACKNOWLEDGE),
-	IB_OPCODE(RD, ATOMIC_ACKNOWLEDGE),
-	IB_OPCODE(RD, COMPARE_SWAP),
-	IB_OPCODE(RD, FETCH_ADD),
-
-	/* UD opcodes */
-	IB_OPCODE(UD, SEND_ONLY),
-	IB_OPCODE(UD, SEND_ONLY_WITH_IMMEDIATE)
-};
-/** @} */
-
 /**
  * @brief Runtime packet context used during processing
  */
diff --git a/examples/vhost_user_rdma/vhost_rdma_queue.c b/examples/vhost_user_rdma/vhost_rdma_queue.c
new file mode 100644
index 0000000000..abce651fa5
--- /dev/null
+++ b/examples/vhost_user_rdma/vhost_rdma_queue.c
@@ -0,0 +1,1056 @@
+/*
+ * Vhost-user RDMA device : QP,SQ,RQ function
+ *
+ * Copyright (C) 2025 KylinSoft Inc. and/or its affiliates. All rights reserved.
+ *
+ * Author: Xiong Weimin <xiongweimin@kylinos.cn>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+#include <rte_interrupts.h>
+#include <rte_malloc.h>
+#include <rte_vhost.h>
+
+#include "vhost_rdma_queue.h"
+#include "vhost_rdma_pkt.h"
+#include "vhost_rdma_log.h"
+#include "vhost_rdma.h"
+#include "vhost_rdma_ib.h"
+#include "vhost_rdma_opcode.h"
+
+static const struct {
+	int			valid;
+	enum vhost_rdma_ib_qp_attr_mask	req_param[VHOST_RDMA_IB_QPT_UD + 1];
+	enum vhost_rdma_ib_qp_attr_mask	opt_param[VHOST_RDMA_IB_QPT_UD + 1];
+} qp_state_table[VHOST_RDMA_IB_QPS_ERR + 1][VHOST_RDMA_IB_QPS_ERR + 1] = 
+{
+	[VHOST_RDMA_IB_QPS_RESET] = {
+		[VHOST_RDMA_IB_QPS_RESET] = { .valid = 1 },
+		[VHOST_RDMA_IB_QPS_INIT]  = {
+			.valid = 1,
+			.req_param = {
+				[VHOST_RDMA_IB_QPT_UD] = VHOST_RDMA_IB_QP_QKEY | VHOST_RDMA_IB_QP_PKEY_INDEX | VHOST_RDMA_IB_QP_PORT,
+				[VHOST_RDMA_IB_QPT_UC] = VHOST_RDMA_IB_QP_ACCESS_FLAGS  | VHOST_RDMA_IB_QP_PKEY_INDEX | VHOST_RDMA_IB_QP_PORT,
+				[VHOST_RDMA_IB_QPT_RC]  = VHOST_RDMA_IB_QP_ACCESS_FLAGS  | VHOST_RDMA_IB_QP_PKEY_INDEX | VHOST_RDMA_IB_QP_PORT,
+				[VHOST_RDMA_IB_QPT_SMI] = VHOST_RDMA_IB_QP_QKEY | VHOST_RDMA_IB_QP_PKEY_INDEX,
+				[VHOST_RDMA_IB_QPT_GSI] = VHOST_RDMA_IB_QP_QKEY | VHOST_RDMA_IB_QP_PKEY_INDEX,
+			}
+		},
+	},
+	[VHOST_RDMA_IB_QPS_INIT]  = {
+		[VHOST_RDMA_IB_QPS_RESET] = { .valid = 1 },
+		[VHOST_RDMA_IB_QPS_ERR] =   { .valid = 1 },
+		[VHOST_RDMA_IB_QPS_INIT]  = {
+			.valid = 1,
+			.opt_param = {
+				[VHOST_RDMA_IB_QPT_UD] = VHOST_RDMA_IB_QP_QKEY  | VHOST_RDMA_IB_QP_PKEY_INDEX | VHOST_RDMA_IB_QP_PORT,
+				[VHOST_RDMA_IB_QPT_UC] = VHOST_RDMA_IB_QP_ACCESS_FLAGS | VHOST_RDMA_IB_QP_PKEY_INDEX | VHOST_RDMA_IB_QP_PORT,
+				[VHOST_RDMA_IB_QPT_RC]  = VHOST_RDMA_IB_QP_ACCESS_FLAGS | VHOST_RDMA_IB_QP_PKEY_INDEX | VHOST_RDMA_IB_QP_PORT,
+				[VHOST_RDMA_IB_QPT_SMI] = VHOST_RDMA_IB_QP_QKEY | VHOST_RDMA_IB_QP_PKEY_INDEX,
+				[VHOST_RDMA_IB_QPT_GSI] = VHOST_RDMA_IB_QP_QKEY | VHOST_RDMA_IB_QP_PKEY_INDEX,
+			}
+		},
+		[VHOST_RDMA_IB_QPS_RTR]   = {
+			.valid = 1,
+			.req_param = {
+				[VHOST_RDMA_IB_QPT_UC] = (VHOST_RDMA_IB_QP_AV			|
+						VHOST_RDMA_IB_QP_PATH_MTU			|
+						VHOST_RDMA_IB_QP_DEST_QPN			|
+						VHOST_RDMA_IB_QP_RQ_PSN),
+				[VHOST_RDMA_IB_QPT_RC] = (VHOST_RDMA_IB_QP_AV			|
+						VHOST_RDMA_IB_QP_PATH_MTU			|
+						VHOST_RDMA_IB_QP_DEST_QPN			|
+						VHOST_RDMA_IB_QP_RQ_PSN			|
+						VHOST_RDMA_IB_QP_MAX_DEST_RD_ATOMIC	|
+						VHOST_RDMA_IB_QP_MIN_RNR_TIMER),
+			},
+			.opt_param = {
+				[VHOST_RDMA_IB_QPT_UD] = VHOST_RDMA_IB_QP_QKEY | VHOST_RDMA_IB_QP_PKEY_INDEX,
+				[VHOST_RDMA_IB_QPT_UC] = VHOST_RDMA_IB_QP_ACCESS_FLAGS | VHOST_RDMA_IB_QP_PKEY_INDEX,
+				[VHOST_RDMA_IB_QPT_RC] = VHOST_RDMA_IB_QP_ACCESS_FLAGS | VHOST_RDMA_IB_QP_PKEY_INDEX,
+				[VHOST_RDMA_IB_QPT_SMI] = VHOST_RDMA_IB_QP_QKEY | VHOST_RDMA_IB_QP_PKEY_INDEX,
+				[VHOST_RDMA_IB_QPT_GSI] = VHOST_RDMA_IB_QP_QKEY | VHOST_RDMA_IB_QP_PKEY_INDEX,
+			 },
+		},
+	},
+	[VHOST_RDMA_IB_QPS_RTR]   = {
+		[VHOST_RDMA_IB_QPS_RESET] = { .valid = 1 },
+		[VHOST_RDMA_IB_QPS_ERR] =   { .valid = 1 },
+		[VHOST_RDMA_IB_QPS_RTS]   = {
+			.valid = 1,
+			.req_param = {
+				[VHOST_RDMA_IB_QPT_UD]  = VHOST_RDMA_IB_QP_SQ_PSN,
+				[VHOST_RDMA_IB_QPT_UC]  = VHOST_RDMA_IB_QP_SQ_PSN,
+				[VHOST_RDMA_IB_QPT_RC]  = (VHOST_RDMA_IB_QP_TIMEOUT			|
+						VHOST_RDMA_IB_QP_RETRY_CNT			|
+						VHOST_RDMA_IB_QP_RNR_RETRY			|
+						VHOST_RDMA_IB_QP_SQ_PSN			|
+						VHOST_RDMA_IB_QP_MAX_QP_RD_ATOMIC),
+				[VHOST_RDMA_IB_QPT_SMI] = VHOST_RDMA_IB_QP_SQ_PSN,
+				[VHOST_RDMA_IB_QPT_GSI] = VHOST_RDMA_IB_QP_SQ_PSN,
+			},
+			.opt_param = {
+				[VHOST_RDMA_IB_QPT_UD]  = (VHOST_RDMA_IB_QP_CUR_STATE		|
+						VHOST_RDMA_IB_QP_QKEY),
+				[VHOST_RDMA_IB_QPT_UC]  = (VHOST_RDMA_IB_QP_CUR_STATE		|
+						VHOST_RDMA_IB_QP_ACCESS_FLAGS),
+				 [VHOST_RDMA_IB_QPT_RC]  = (VHOST_RDMA_IB_QP_CUR_STATE		|
+						VHOST_RDMA_IB_QP_ACCESS_FLAGS		|
+						VHOST_RDMA_IB_QP_MIN_RNR_TIMER),
+				 [VHOST_RDMA_IB_QPT_SMI] = (VHOST_RDMA_IB_QP_CUR_STATE		|
+						VHOST_RDMA_IB_QP_QKEY),
+				 [VHOST_RDMA_IB_QPT_GSI] = (VHOST_RDMA_IB_QP_CUR_STATE		|
+						VHOST_RDMA_IB_QP_QKEY),
+			 }
+		}
+	},
+	[VHOST_RDMA_IB_QPS_RTS]   = {
+		[VHOST_RDMA_IB_QPS_RESET] = { .valid = 1 },
+		[VHOST_RDMA_IB_QPS_ERR] =   { .valid = 1 },
+		[VHOST_RDMA_IB_QPS_RTS]   = {
+			.valid = 1,
+			.opt_param = {
+				[VHOST_RDMA_IB_QPT_UD]  = (VHOST_RDMA_IB_QP_CUR_STATE			|
+						VHOST_RDMA_IB_QP_QKEY),
+				[VHOST_RDMA_IB_QPT_UC]  = (VHOST_RDMA_IB_QP_CUR_STATE			|
+						VHOST_RDMA_IB_QP_ACCESS_FLAGS),
+				[VHOST_RDMA_IB_QPT_RC]  = (VHOST_RDMA_IB_QP_CUR_STATE			|
+						VHOST_RDMA_IB_QP_ACCESS_FLAGS		|
+						VHOST_RDMA_IB_QP_MIN_RNR_TIMER),
+				[VHOST_RDMA_IB_QPT_SMI] = (VHOST_RDMA_IB_QP_CUR_STATE			|
+						VHOST_RDMA_IB_QP_QKEY),
+				[VHOST_RDMA_IB_QPT_GSI] = (VHOST_RDMA_IB_QP_CUR_STATE			|
+						VHOST_RDMA_IB_QP_QKEY),
+			}
+		},
+		[VHOST_RDMA_IB_QPS_SQD]   = {
+			.valid = 1,
+		},
+	},
+	[VHOST_RDMA_IB_QPS_SQD]   = {
+		[VHOST_RDMA_IB_QPS_RESET] = { .valid = 1 },
+		[VHOST_RDMA_IB_QPS_ERR] =   { .valid = 1 },
+		[VHOST_RDMA_IB_QPS_RTS]   = {
+			.valid = 1,
+			.opt_param = {
+				[VHOST_RDMA_IB_QPT_UD]  = (VHOST_RDMA_IB_QP_CUR_STATE			|
+						VHOST_RDMA_IB_QP_QKEY),
+				[VHOST_RDMA_IB_QPT_UC]  = (VHOST_RDMA_IB_QP_CUR_STATE			|
+						VHOST_RDMA_IB_QP_ACCESS_FLAGS),
+				[VHOST_RDMA_IB_QPT_RC]  = (VHOST_RDMA_IB_QP_CUR_STATE			|
+						VHOST_RDMA_IB_QP_ACCESS_FLAGS		|
+						VHOST_RDMA_IB_QP_MIN_RNR_TIMER),
+				[VHOST_RDMA_IB_QPT_SMI] = (VHOST_RDMA_IB_QP_CUR_STATE			|
+						VHOST_RDMA_IB_QP_QKEY),
+				[VHOST_RDMA_IB_QPT_GSI] = (VHOST_RDMA_IB_QP_CUR_STATE			|
+						VHOST_RDMA_IB_QP_QKEY),
+			}
+		},
+		[VHOST_RDMA_IB_QPS_SQD]   = {
+			.valid = 1,
+			.opt_param = {
+				[VHOST_RDMA_IB_QPT_UD]  = VHOST_RDMA_IB_QP_QKEY,
+				[VHOST_RDMA_IB_QPT_UC]  = (VHOST_RDMA_IB_QP_AV			|
+						VHOST_RDMA_IB_QP_ACCESS_FLAGS),
+				[VHOST_RDMA_IB_QPT_RC]  = (VHOST_RDMA_IB_QP_AV			|
+						VHOST_RDMA_IB_QP_TIMEOUT			|
+						VHOST_RDMA_IB_QP_RETRY_CNT			|
+						VHOST_RDMA_IB_QP_RNR_RETRY			|
+						VHOST_RDMA_IB_QP_MAX_QP_RD_ATOMIC		|
+						VHOST_RDMA_IB_QP_MAX_DEST_RD_ATOMIC	|
+						VHOST_RDMA_IB_QP_ACCESS_FLAGS		|
+						VHOST_RDMA_IB_QP_MIN_RNR_TIMER),
+				[VHOST_RDMA_IB_QPT_SMI] = VHOST_RDMA_IB_QP_QKEY,
+				[VHOST_RDMA_IB_QPT_GSI] = VHOST_RDMA_IB_QP_QKEY,
+			}
+		}
+	},
+	[VHOST_RDMA_IB_QPS_SQE]   = {
+		[VHOST_RDMA_IB_QPS_RESET] = { .valid = 1 },
+		[VHOST_RDMA_IB_QPS_ERR] =   { .valid = 1 },
+		[VHOST_RDMA_IB_QPS_RTS]   = {
+			.valid = 1,
+			.opt_param = {
+				[VHOST_RDMA_IB_QPT_UD]  = (VHOST_RDMA_IB_QP_CUR_STATE			|
+						VHOST_RDMA_IB_QP_QKEY),
+				[VHOST_RDMA_IB_QPT_UC]  = (VHOST_RDMA_IB_QP_CUR_STATE			|
+						VHOST_RDMA_IB_QP_ACCESS_FLAGS),
+				[VHOST_RDMA_IB_QPT_SMI] = (VHOST_RDMA_IB_QP_CUR_STATE			|
+						VHOST_RDMA_IB_QP_QKEY),
+				[VHOST_RDMA_IB_QPT_GSI] = (VHOST_RDMA_IB_QP_CUR_STATE			|
+						VHOST_RDMA_IB_QP_QKEY),
+			}
+		}
+	},
+	[VHOST_RDMA_IB_QPS_ERR] = {
+		[VHOST_RDMA_IB_QPS_RESET] = { .valid = 1 },
+		[VHOST_RDMA_IB_QPS_ERR] =   { .valid = 1 }
+	}	
+};
+
+void
+init_av_from_vhost_rdma(struct vhost_rdma_device *dev, struct vhost_rdma_av *dst,
+						uint32_t ah)
+{
+	struct vhost_rdma_av *av;
+
+	av = vhost_rdma_pool_get(&dev->ah_pool, ah);
+
+	assert(av);
+
+	rte_memcpy(dst, av, sizeof(*dst));
+}
+
+void vhost_rdma_init_send_wqe(struct vhost_rdma_qp *qp,
+						struct vhost_rdma_sq_req *wr,
+						unsigned int mask,
+						unsigned int length,
+						struct vhost_rdma_send_wqe *wqe)
+{
+	int num_sge = wr->num_sge;
+
+	wqe->wr = wr;
+	wqe->mask = mask;
+
+	/* local operation */
+	if (unlikely(mask & WR_LOCAL_OP_MASK)) {
+		wqe->state = WQE_STATE_POSTED;
+		return;
+	}
+
+	if (qp->type == VHOST_RDMA_IB_QPT_UD ||
+		qp->type == VHOST_RDMA_IB_QPT_SMI ||
+		qp->type == VHOST_RDMA_IB_QPT_GSI)
+		init_av_from_vhost_rdma(qp->dev, &wqe->av, wr->ud.ah);
+
+	wqe->iova = mask & WR_READ_OR_WRITE_MASK ? wr->rdma.remote_addr : 0;
+	wqe->dma.length		= length;
+	wqe->dma.resid		= length;
+	wqe->dma.num_sge	= num_sge;
+	wqe->dma.cur_sge	= 0;
+	wqe->dma.sge_offset	= 0;
+
+	wqe->dma.sge = wr->sg_list;
+	wqe->state		= WQE_STATE_POSTED;
+	wqe->ssn		= rte_atomic32_add_return(&qp->ssn, 1);
+}
+
+int
+vhost_rdma_init_task(struct vhost_rdma_task *task, struct rte_ring *task_ring,
+					void *arg, int (*func)(void *), const char *name)
+{
+	task->arg	= arg;
+	task->func	= func;
+	rte_strscpy(task->name, name, 8);
+	task->destroyed	= false;
+	task->task_ring	= task_ring;
+
+	task->state = TASK_STATE_START;
+	rte_atomic16_clear(&task->sched);
+	rte_spinlock_init(&task->state_lock);
+
+	return 0;
+}
+
+void
+vhost_rdma_do_task(struct vhost_rdma_task *task)
+{
+	int cont;
+	int ret;
+
+	rte_spinlock_lock(&task->state_lock);
+	switch (task->state) {
+	case TASK_STATE_START:
+		task->state = TASK_STATE_BUSY;
+		rte_spinlock_unlock(&task->state_lock);
+		break;
+
+	case TASK_STATE_BUSY:
+		task->state = TASK_STATE_ARMED;
+		// fallthrough
+	case TASK_STATE_ARMED:
+		rte_spinlock_unlock(&task->state_lock);
+		return;
+
+	default:
+		rte_spinlock_unlock(&task->state_lock);
+		RDMA_LOG_INFO("%s failed with bad state %d\n", __func__, task->state);
+		return;
+	}
+
+	do {
+		cont = 0;
+		ret = task->func(task->arg);
+		rte_spinlock_lock(&task->state_lock);
+		switch (task->state) {
+		case TASK_STATE_BUSY:
+			if (ret)
+				task->state = TASK_STATE_START;
+			else
+				cont = 1;
+			break;
+
+		/* soneone tried to run the task since the last time we called
+		 * func, so we will call one more time regardless of the
+		 * return value
+		 */
+		case TASK_STATE_ARMED:
+			task->state = TASK_STATE_BUSY;
+			cont = 1;
+			break;
+
+		default:
+			RDMA_LOG_INFO("Failed with bad state %d\n", task->state);
+		}
+		rte_spinlock_unlock(&task->state_lock);
+	} while (cont);
+
+	task->ret = ret;
+}
+
+void
+vhost_rdma_run_task(struct vhost_rdma_task *task, int sched)
+{
+	if (task->destroyed)
+		return;
+	RDMA_LOG_DEBUG("run task %s sched %d", task->name, sched);
+	if (sched) {
+		if (rte_atomic16_test_and_set(&task->sched)) {
+			rte_ring_enqueue(task->task_ring, task);
+		}
+	} else {
+		vhost_rdma_do_task(task);
+	}
+}
+
+void
+vhost_rdma_cleanup_task(struct vhost_rdma_task *task)
+{
+	bool idle;
+
+	task->destroyed = true;
+	rte_atomic16_clear(&task->sched);
+
+	do {
+		rte_spinlock_lock(&task->state_lock);
+		idle = (task->state == TASK_STATE_START);
+		rte_spinlock_unlock(&task->state_lock);
+	} while (!idle);
+}
+
+void vhost_rdma_handle_sq(void *arg)
+{
+	struct vhost_rdma_qp *qp = (struct vhost_rdma_qp *)arg;
+	struct vhost_rdma_queue *queue = &qp->sq.queue;
+	struct rte_vhost_vring *vring = &queue->vq->vring;
+	int kick_fd;
+	eventfd_t kick_data;
+
+	kick_fd = queue->vq->vring.kickfd;
+	eventfd_read(kick_fd, &kick_data);
+
+	while(queue->producer_index != vring->avail->idx) {
+		uint16_t last_avail_idx = queue->producer_index & (vring->size - 1);
+		uint16_t desc_idx = vring->avail->ring[last_avail_idx];
+		struct iovec iov;
+		uint16_t num_in, num_out;
+		struct vhost_rdma_sq_req *wr;
+		unsigned int mask, length;
+
+		setup_iovs_from_descs(qp->dev->mem, queue->vq, desc_idx, 
+						&iov, 1, &num_in, &num_out);
+
+		assert(num_in == 0);
+		assert(num_out == 1);
+
+		if (iov.iov_len < sizeof(*wr)) {
+			RDMA_LOG_ERR("got bad send wqe");
+			continue;
+		}
+		wr = iov.iov_base;
+
+		mask = wr_opcode_mask(wr->opcode, qp);
+
+		RDMA_LOG_DEBUG_DP("got send wqe qpn: %u type: %d wr_id: %llu opcode: %d mask: %u",
+							qp->qpn, qp->type, wr->wr_id, wr->opcode, mask);
+
+		length = 0;
+		if (unlikely(wr->send_flags & VHOST_RDMA_IB_SEND_INLINE)) {
+			length = wr->inline_len;
+		} else {
+			struct vhost_rdma_sge *sg_list = wr->sg_list;
+			for (uint32_t i = 0; i < wr->num_sge; i++)
+				length += sg_list[i].length;
+		}
+
+		vhost_rdma_init_send_wqe(qp, wr, mask, length,
+				vhost_rdma_queue_get_data(queue, desc_idx));
+
+		queue->producer_index++;
+	}
+
+	vhost_rdma_run_task(&qp->req.task, 1);
+	if (unlikely(qp->req.state == QP_STATE_ERROR))
+		vhost_rdma_run_task(&qp->comp.task, 1);
+}
+
+void vhost_rdma_handle_rq(__rte_unused void *arg)
+{
+	struct vhost_rdma_qp *qp = (struct vhost_rdma_qp *)arg;
+	struct vhost_rdma_queue *queue = &qp->rq.queue;
+	struct rte_vhost_vring *vring = &queue->vq->vring;
+	int kick_fd;
+	eventfd_t kick_data;
+
+	kick_fd = queue->vq->vring.kickfd;
+	eventfd_read(kick_fd, &kick_data);
+
+	while(queue->producer_index != vring->avail->idx) {
+		uint16_t last_avail_idx = queue->producer_index & (vring->size - 1);
+		uint16_t desc_idx = vring->avail->ring[last_avail_idx];
+		struct iovec iov;
+		uint16_t num_in, num_out;
+				unsigned int length;
+				struct vhost_rdma_rq_req *wr;
+				struct vhost_rdma_sge *sg_list;
+				struct vhost_rdma_recv_wqe *recv_wqe;
+
+		setup_iovs_from_descs(qp->dev->mem, 
+						queue->vq, 
+						desc_idx, &iov, 1,
+								      &num_in, &num_out);
+
+		assert(num_in == 0);
+		assert(num_out == 1);
+
+		if (iov.iov_len < sizeof(*wr)) {
+			RDMA_LOG_ERR("got bad recv wqe");
+			continue;
+		}
+		wr = iov.iov_base;
+
+		length = 0;
+		sg_list = wr->sg_list;
+
+		for (uint32_t i = 0; i < wr->num_sge; i++)
+		{
+			length += sg_list[i].length;
+			RDMA_LOG_DEBUG(" length: %d %d", sg_list[i].length, length);
+		}				
+
+		recv_wqe = vhost_rdma_queue_get_data(queue, desc_idx);
+
+		recv_wqe->wr_id = wr->wr_id;
+		recv_wqe->num_sge = wr->num_sge;
+		recv_wqe->dma.length		= length;
+		recv_wqe->dma.resid		= length;
+		recv_wqe->dma.num_sge		= wr->num_sge;
+		recv_wqe->dma.cur_sge		= 0;
+		recv_wqe->dma.sge_offset	= 0;
+		recv_wqe->dma.raw = sg_list;
+
+				queue->producer_index++;
+	}
+
+	if (qp->resp.state == QP_STATE_ERROR)
+		vhost_rdma_run_task(&qp->resp.task, 1);    
+}
+
+int vhost_rdma_cq_post(struct vhost_rdma_device *dev,
+					struct vhost_rdma_cq *cq,
+					struct vhost_rdma_cq_req *cqe,
+					int solicited)
+{
+	bool avail;
+	uint16_t desc_idx;
+	struct iovec iovs[1];
+	uint16_t num_in, num_out;
+
+	rte_spinlock_lock(&cq->cq_lock);
+
+	avail = vhost_rdma_vq_is_avail(cq->vq);
+
+	if (unlikely(!avail)) {
+		rte_spinlock_unlock(&cq->cq_lock);
+		return -EBUSY;
+	}
+
+	desc_idx = vhost_rdma_vq_get_desc_idx(cq->vq);
+
+	if (setup_iovs_from_descs(dev->mem, cq->vq, desc_idx, iovs, 1,
+			&num_in, &num_out) < 0) {
+		rte_spinlock_unlock(&cq->cq_lock);
+		RDMA_LOG_ERR("get from cq failed");
+		return -EBUSY;
+	}
+
+	if (iovs[0].iov_len < sizeof(*cqe)) {
+		RDMA_LOG_ERR_DP("cqe size is too small");
+		return -EIO;
+	}
+	rte_memcpy(iovs[0].iov_base, cqe, sizeof(*cqe));
+
+	RDMA_LOG_DEBUG("poll cqe cqn: %u wr_id: %llu opcode: %d status: %d",
+			  cq->cqn, cqe->wr_id, cqe->opcode, cqe->status);
+
+	vhost_rdma_queue_push(cq->vq, desc_idx, sizeof(*cqe));
+
+	rte_spinlock_unlock(&cq->cq_lock);
+
+	if ((cq->notify == VHOST_RDMA_IB_CQ_NEXT_COMP) ||
+		(cq->notify == VHOST_RDMA_IB_NOTIFY_SOLICITED && solicited)) {
+		cq->notify = 0;
+		vhost_rdma_queue_notify(dev->vid, cq->vq);
+	}
+
+	return 0;				     
+}
+
+int vhost_rdma_queue_init(struct vhost_rdma_qp *qp,
+						struct vhost_rdma_queue *queue,
+						const char *name,
+						struct vhost_user_queue *vq,
+						size_t elem_size,
+						enum vhost_rdma_queue_type type)
+{
+	queue->data = rte_zmalloc(name, elem_size * vq->vring.size, RTE_CACHE_LINE_SIZE);
+	if (queue->data == NULL)
+		return -ENOMEM;
+
+	queue->vq = vq;
+	queue->num_elems = vq->vring.size;
+	queue->elem_size = elem_size;
+	queue->consumer_index = vq->last_avail_idx;
+	queue->producer_index = vq->last_avail_idx;
+
+	switch (type) {
+	case VHOST_RDMA_QUEUE_SQ:
+		queue->cb = vhost_rdma_handle_sq;
+		break;
+	case VHOST_RDMA_QUEUE_RQ:
+		queue->cb = vhost_rdma_handle_rq;
+		break;
+	default:
+		RDMA_LOG_ERR("Unknown queue type");
+	}
+
+	queue->intr_handle.fd = vq->vring.kickfd;
+	queue->intr_handle.type = RTE_INTR_HANDLE_EXT;
+	rte_intr_callback_register(&queue->intr_handle, queue->cb, qp);
+
+	return 0;
+}
+
+/**
+ * @brief Clean up a vhost RDMA queue.
+ */
+void 
+vhost_rdma_queue_cleanup(struct vhost_rdma_qp *qp, struct vhost_rdma_queue *queue)
+{
+	if (!queue)
+				return;
+
+	if (queue->cb && qp)
+		rte_intr_callback_unregister(&queue->intr_handle, queue->cb, qp);
+
+	rte_free(queue->data);
+	queue->data = NULL;
+}
+
+int vhost_rdma_requester(void *arg)
+{
+	//TODO: handle request
+	return 0;
+}
+
+int vhost_rdma_completer(void* arg)
+{
+	//TODO: handle complete
+	return 0;
+}
+
+int vhost_rdma_responder(void* arg)
+{
+	//TODO: handle response
+	return 0;
+}
+
+static int vhost_rdma_qp_init_req(__rte_unused struct vhost_rdma_device *dev,
+								struct vhost_rdma_qp *qp,
+								struct vhost_rdma_cmd_create_qp *cmd)
+{
+	int wqe_size;
+
+	qp->src_port = 0xc000;
+
+	wqe_size = RTE_MAX(cmd->max_send_sge * sizeof(struct vhost_rdma_sge),
+					cmd->max_inline_data);
+
+	vhost_rdma_queue_init(qp, 
+						&qp->sq.queue, 
+						"sq_queue",
+						&dev->qp_vqs[qp->qpn * 2], 
+						sizeof(struct vhost_rdma_send_wqe) + wqe_size, 
+						VHOST_RDMA_QUEUE_SQ);
+
+	qp->req.state		= QP_STATE_RESET;
+	qp->req.opcode		= QP_OPCODE_INVAILD;
+	qp->comp.opcode		= QP_OPCODE_INVAILD;
+
+	qp->req_pkts = rte_zmalloc(NULL, rte_ring_get_memsize(512), RTE_CACHE_LINE_SIZE);
+	if (qp->req_pkts == NULL) {
+		RDMA_LOG_ERR("req_pkts malloc failed");
+		return -ENOMEM;
+	}
+
+	if (rte_ring_init(qp->req_pkts, "req_pkts", 512, RING_F_MP_HTS_ENQ | RING_F_MC_HTS_DEQ) != 0) {
+		RDMA_LOG_ERR("req_pkts init failed");
+		rte_free(qp->req_pkts);
+		return -ENOMEM;
+	}
+
+	qp->req_pkts_head = NULL;
+
+	vhost_rdma_init_task(&qp->req.task, dev->task_ring, qp,
+						vhost_rdma_requester, "vhost_rdma_req");
+	vhost_rdma_init_task(&qp->comp.task, dev->task_ring, qp,
+						vhost_rdma_completer, "vhost_rdma_comp");
+
+	qp->qp_timeout_ticks = 0; /* Can't be set for UD/UC in modify_qp */
+	if (cmd->qp_type == VHOST_RDMA_IB_QPT_RC) {
+		rte_timer_init(&qp->rnr_nak_timer); // req_task
+		rte_timer_init(&qp->retrans_timer); // comp_task
+	}
+	return 0;
+}
+
+static int vhost_rdma_qp_init_resp(struct vhost_rdma_device *dev,
+								struct vhost_rdma_qp *qp)
+{
+	if (!qp->srq) {
+		vhost_rdma_queue_init(qp, &qp->rq.queue, "rq_queue",
+							&dev->qp_vqs[qp->qpn * 2 + 1], 
+							sizeof(struct vhost_rdma_recv_wqe), 
+							VHOST_RDMA_QUEUE_RQ);
+	}
+
+	qp->resp_pkts = rte_zmalloc(NULL, rte_ring_get_memsize(512), RTE_CACHE_LINE_SIZE);
+	if (qp->resp_pkts == NULL) {
+		RDMA_LOG_ERR("resp_pkts malloc failed");
+		return -ENOMEM;
+	}
+
+	if (rte_ring_init(qp->resp_pkts, "resp_pkts", 512, RING_F_MP_HTS_ENQ | RING_F_MC_HTS_DEQ) != 0) {
+		RDMA_LOG_ERR("resp_pkts init failed");
+		rte_free(qp->resp_pkts);
+		return -ENOMEM;
+	}
+
+	vhost_rdma_init_task(&qp->resp.task, dev->task_ring, qp,
+						vhost_rdma_responder, "resp");
+
+	qp->resp.opcode		= OPCODE_NONE;
+	qp->resp.msn		= 0;
+	qp->resp.state		= QP_STATE_RESET;
+
+	return 0;
+}
+
+static void vhost_rdma_qp_init_misc(__rte_unused struct vhost_rdma_device *dev,
+								struct vhost_rdma_qp *qp,
+								struct vhost_rdma_cmd_create_qp *cmd)
+{
+	qp->sq_sig_all		= cmd->sq_sig_all;
+	qp->attr.path_mtu	= DEFAULT_IB_MTU;
+	qp->mtu				= ib_mtu_enum_to_int(qp->attr.path_mtu);
+
+	qp->attr.cap.max_send_wr		= cmd->max_send_wr;
+	qp->attr.cap.max_recv_wr		= cmd->max_recv_wr;
+	qp->attr.cap.max_send_sge		= cmd->max_send_sge;
+	qp->attr.cap.max_recv_sge		= cmd->max_recv_sge;
+	qp->attr.cap.max_inline_data	= cmd->max_inline_data;
+
+	rte_spinlock_init(&qp->state_lock);
+
+	rte_atomic32_set(&qp->ssn, 0);
+	rte_atomic32_set(&qp->mbuf_out, 0);
+}
+
+int vhost_rdma_qp_init(struct vhost_rdma_device *dev, 
+					struct vhost_rdma_qp *qp,
+					struct vhost_rdma_cmd_create_qp *cmd)
+{
+	int err;
+
+	qp->pd = vhost_rdma_pool_get(&dev->pd_pool, cmd->pdn);
+	qp->scq = vhost_rdma_pool_get(&dev->cq_pool, cmd->send_cqn);
+	qp->rcq = vhost_rdma_pool_get(&dev->cq_pool, cmd->recv_cqn);
+	vhost_rdma_add_ref(qp->pd);
+	vhost_rdma_add_ref(qp->rcq);
+	vhost_rdma_add_ref(qp->scq);
+
+	vhost_rdma_qp_init_misc(dev, qp, cmd);
+
+	err = vhost_rdma_qp_init_req(dev, qp, cmd);
+	if (err)
+		goto err;
+
+	err = vhost_rdma_qp_init_resp(dev, qp);
+	if (err)
+		goto err;
+
+	qp->attr.qp_state = VHOST_RDMA_IB_QPS_RESET;
+	qp->valid = 1;
+	qp->type = cmd->qp_type;
+	qp->dev = dev;
+
+	return 0;
+
+err:
+	qp->pd = NULL;
+	qp->rcq = NULL;
+	qp->scq = NULL;
+	vhost_rdma_drop_ref(qp->pd, dev, pd);
+	vhost_rdma_drop_ref(qp->rcq, dev, cq);
+	vhost_rdma_drop_ref(qp->scq, dev, cq);
+
+	return err;		
+}
+
+bool vhost_rdma_ib_modify_qp_is_ok(enum vhost_rdma_ib_qp_state cur_state,
+								enum vhost_rdma_ib_qp_state next_state,
+								uint8_t type, 
+								enum vhost_rdma_ib_qp_attr_mask mask)
+{
+	enum vhost_rdma_ib_qp_attr_mask req_param, opt_param;
+
+	if (mask & VHOST_RDMA_IB_QP_CUR_STATE  &&
+		cur_state != VHOST_RDMA_IB_QPS_RTR && cur_state != VHOST_RDMA_IB_QPS_RTS &&
+		cur_state != VHOST_RDMA_IB_QPS_SQD && cur_state != VHOST_RDMA_IB_QPS_SQE)
+		return false;
+
+	if (!qp_state_table[cur_state][next_state].valid)
+		return false;
+
+	req_param = qp_state_table[cur_state][next_state].req_param[type];
+	opt_param = qp_state_table[cur_state][next_state].opt_param[type];
+
+	if ((mask & req_param) != req_param)
+		return false;
+
+	if (mask & ~(req_param | opt_param | VHOST_RDMA_IB_QP_STATE))
+		return false;
+
+	return true;				
+}
+
+static int vhost_rdma_qp_chk_cap(struct vhost_rdma_device *dev,
+								struct vhost_rdma_qp_cap *cap)
+{
+	if (cap->max_send_wr > dev->attr.max_qp_wr) {
+		RDMA_LOG_ERR("invalid send wr = %d > %d",
+			cap->max_send_wr, dev->attr.max_qp_wr);
+		return -EINVAL;
+	}
+
+	if (cap->max_send_sge > dev->attr.max_send_sge) {
+		RDMA_LOG_ERR("invalid send sge = %d > %d",
+			cap->max_send_sge, dev->attr.max_send_sge);
+		return -EINVAL;
+	}
+
+	if (cap->max_recv_wr > dev->attr.max_qp_wr) {
+		RDMA_LOG_ERR("invalid recv wr = %d > %d",
+			cap->max_recv_wr, dev->attr.max_qp_wr);
+		return -EINVAL;
+	}
+
+	if (cap->max_recv_sge > dev->attr.max_recv_sge) {
+		RDMA_LOG_ERR("invalid recv sge = %d > %d",
+			cap->max_recv_sge, dev->attr.max_recv_sge);
+		return -EINVAL;
+	}
+
+	if (cap->max_inline_data > dev->max_inline_data) {
+		RDMA_LOG_ERR("invalid max inline data = %d > %d",
+			cap->max_inline_data, dev->max_inline_data);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+int
+vhost_rdma_av_chk_attr(struct vhost_rdma_device *dev,
+						struct vhost_rdma_ah_attr *attr)
+{
+	struct vhost_rdma_global_route *grh = &attr->grh;
+	int type;
+
+	// uint8 sgid_index is always smaller than VHOST_MAX_GID_TBL_LEN
+	type = rdma_gid_attr_network_type(&dev->gid_tbl[grh->sgid_index]);
+	if (type < VHOST_RDMA_NETWORK_IPV4 ||
+		type > VHOST_RDMA_NETWORK_IPV6) {
+		RDMA_LOG_ERR("invalid network type = %d", type);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int vhost_rdma_qp_validate(struct vhost_rdma_device *dev, 
+						struct vhost_rdma_qp *qp,
+						struct vhost_rdma_cmd_modify_qp *cmd)
+{
+	int mask = cmd->attr_mask;
+	enum vhost_rdma_ib_qp_state cur_state = (mask & VHOST_RDMA_IB_QP_CUR_STATE) ?
+											cmd->cur_qp_state : qp->attr.qp_state;
+	enum vhost_rdma_ib_qp_state new_state = (mask & VHOST_RDMA_IB_QP_STATE) ?
+											cmd->qp_state : cur_state;
+
+	if (!vhost_rdma_ib_modify_qp_is_ok(cur_state, new_state, qp->type, mask)){
+		RDMA_LOG_ERR("invalid mask or state for qp");
+		return -EINVAL;
+	}
+
+	if (mask & VHOST_RDMA_IB_QP_STATE) {
+		if (cur_state == VHOST_RDMA_IB_QPS_SQD) {
+			if (qp->req.state == QP_STATE_DRAIN &&
+				new_state != VHOST_RDMA_IB_QPS_ERR)
+				return -EINVAL;
+		}
+	}
+
+	if (mask & VHOST_RDMA_IB_QP_CAP && vhost_rdma_qp_chk_cap(dev, &cmd->cap))
+		return -EINVAL;
+
+	if (mask & VHOST_RDMA_IB_QP_AV && vhost_rdma_av_chk_attr(dev, &cmd->ah_attr))
+		return -EINVAL;
+
+	if (mask & VHOST_RDMA_IB_QP_MAX_QP_RD_ATOMIC) {
+		if (cmd->max_rd_atomic > dev->attr.max_qp_rd_atom) {
+			RDMA_LOG_ERR("invalid max_rd_atomic %d > %d",
+						cmd->max_rd_atomic,
+						dev->attr.max_qp_rd_atom);
+			return -EINVAL;
+		}
+	}
+
+	if (mask & VHOST_RDMA_IB_QP_TIMEOUT) {
+		if (cmd->timeout > 31) {
+			RDMA_LOG_ERR("invalid QP timeout %d > 31",
+						cmd->timeout);
+			return -EINVAL;
+		}
+	}
+	return 0;
+}
+
+void vhost_rdma_av_from_attr(struct vhost_rdma_av *av,
+							struct vhost_rdma_ah_attr *attr)
+{
+	const struct vhost_rdma_global_route *grh = &attr->grh;
+
+	memset(av, 0, sizeof(*av));
+	rte_memcpy(av->grh.dgid, grh->dgid, sizeof(grh->dgid));
+	av->grh.flow_label = grh->flow_label;
+	av->grh.sgid_index = grh->sgid_index;
+	av->grh.hop_limit = grh->hop_limit;
+	av->grh.traffic_class = grh->traffic_class;
+	rte_memcpy(av->dmac, attr->dmac, ETH_ALEN);
+}
+
+static void vhost_rdma_av_fill_ip_info(struct vhost_rdma_device *dev,
+									struct vhost_rdma_av *av, 
+									struct vhost_rdma_ah_attr *attr)
+{
+	const struct vhost_rdma_gid *sgid_attr;
+	int ibtype;
+	int type;
+
+	sgid_attr = &dev->gid_tbl[attr->grh.sgid_index];
+
+	rdma_gid2ip((struct sockaddr *)&av->sgid_addr, &sgid_attr->gid[0]);
+	rdma_gid2ip((struct sockaddr *)&av->dgid_addr, attr->grh.dgid);
+
+	ibtype = rdma_gid_attr_network_type(sgid_attr);
+
+	switch (ibtype) {
+	case VHOST_RDMA_NETWORK_IPV4:
+		type = VHOST_NETWORK_TYPE_IPV4;
+		break;
+	case VHOST_RDMA_NETWORK_IPV6:
+		type = VHOST_NETWORK_TYPE_IPV6;
+		break;
+	default:
+		/* not reached - checked in av_chk_attr */
+		type = 0;
+		break;
+	}
+
+	av->network_type = type;	
+}
+
+void vhost_rdma_init_av(struct vhost_rdma_device *dev,
+						struct vhost_rdma_ah_attr *attr, 
+						struct vhost_rdma_av *av)
+{
+	vhost_rdma_av_from_attr(av, attr);
+	vhost_rdma_av_fill_ip_info(dev, av, attr);
+	rte_memcpy(av->dmac, attr->dmac, ETH_ALEN);
+}
+
+void vhost_rdma_qp_error(struct vhost_rdma_qp *qp)
+{
+	qp->req.state = QP_STATE_ERROR;
+	qp->resp.state = QP_STATE_ERROR;
+	qp->attr.qp_state = VHOST_RDMA_IB_QPS_ERR;
+
+	/* drain work and packet queues */
+	vhost_rdma_run_task(&qp->resp.task, 1);
+
+	if (qp->type == VHOST_RDMA_IB_QPT_RC)
+		vhost_rdma_run_task(&qp->comp.task, 1);
+	else
+		__vhost_rdma_do_task(&qp->comp.task);
+	vhost_rdma_run_task(&qp->req.task, 1);
+}
+
+int vhost_rdma_qp_modify(struct vhost_rdma_device *dev, 
+						struct vhost_rdma_qp *qp,
+						struct vhost_rdma_cmd_modify_qp *cmd)
+{
+	int err, mask = cmd->attr_mask;
+
+	if (mask & VHOST_RDMA_IB_QP_MAX_QP_RD_ATOMIC) {
+		int max_rd_atomic = cmd->max_rd_atomic ?
+			roundup_pow_of_two(cmd->max_rd_atomic) : 0;
+
+		qp->attr.max_rd_atomic = max_rd_atomic;
+		rte_atomic32_set(&qp->req.rd_atomic, max_rd_atomic);
+	}
+
+	if (mask & VHOST_RDMA_IB_QP_MAX_DEST_RD_ATOMIC) {
+		int max_dest_rd_atomic = cmd->max_dest_rd_atomic ?
+			roundup_pow_of_two(cmd->max_dest_rd_atomic) : 0;
+
+		qp->attr.max_dest_rd_atomic = max_dest_rd_atomic;
+
+		free_rd_atomic_resources(qp);
+
+		err = alloc_rd_atomic_resources(qp, max_dest_rd_atomic);
+		if (err)
+			return err;
+	}
+
+	if (mask & VHOST_RDMA_IB_QP_CUR_STATE)
+		qp->attr.cur_qp_state = cmd->qp_state;
+
+	if (mask & VHOST_RDMA_IB_QP_ACCESS_FLAGS)
+		qp->attr.qp_access_flags = cmd->qp_access_flags;
+
+	if (mask & VHOST_RDMA_IB_QP_QKEY)
+		qp->attr.qkey = cmd->qkey;
+
+	if (mask & VHOST_RDMA_IB_QP_AV)
+		vhost_rdma_init_av(dev, &cmd->ah_attr, &qp->av);
+
+	if (mask & VHOST_RDMA_IB_QP_PATH_MTU) {
+		qp->attr.path_mtu = cmd->path_mtu;
+		qp->mtu = ib_mtu_enum_to_int(cmd->path_mtu);
+	}
+
+	if (mask & VHOST_RDMA_IB_QP_TIMEOUT) {
+		qp->attr.timeout = cmd->timeout;
+		if (cmd->timeout == 0) {
+			qp->qp_timeout_ticks = 0;
+		} else {
+			uint64_t ticks_per_us = rte_get_timer_hz() / 1000000;
+			uint64_t j = (4096ULL << cmd->timeout) / 1000 * ticks_per_us;
+			qp->qp_timeout_ticks = j ? j : 1;
+		}
+	}
+
+	if (mask & VHOST_RDMA_IB_QP_RETRY_CNT) {
+		qp->attr.retry_cnt = cmd->retry_cnt;
+		qp->comp.retry_cnt = cmd->retry_cnt;
+		RDMA_LOG_INFO("qp#%d set retry count = %d", qp->qpn,
+			cmd->retry_cnt);
+	}
+
+	if (mask & VHOST_RDMA_IB_QP_RNR_RETRY) {
+		qp->attr.rnr_retry = cmd->rnr_retry;
+		qp->comp.rnr_retry = cmd->rnr_retry;
+		RDMA_LOG_INFO("qp#%d set rnr retry count = %d", qp->qpn,
+			cmd->rnr_retry);
+	}
+
+	if (mask & VHOST_RDMA_IB_QP_RQ_PSN) {
+		qp->attr.rq_psn = (cmd->rq_psn & VHOST_RDMA_PSN_MASK);
+		qp->resp.psn = qp->attr.rq_psn;
+		RDMA_LOG_INFO("qp#%d set resp psn = 0x%x", qp->qpn,
+			 qp->resp.psn);
+	}
+
+	if (mask & VHOST_RDMA_IB_QP_MIN_RNR_TIMER) {
+		qp->attr.min_rnr_timer = cmd->min_rnr_timer;
+		RDMA_LOG_INFO("qp#%d set min rnr timer = 0x%x", qp->qpn,
+			cmd->min_rnr_timer);
+	}
+
+	if (mask & VHOST_RDMA_IB_QP_SQ_PSN) {
+		qp->attr.sq_psn = (cmd->sq_psn & VHOST_RDMA_PSN_MASK);
+		qp->req.psn = qp->attr.sq_psn;
+		qp->comp.psn = qp->attr.sq_psn;
+		RDMA_LOG_INFO("qp#%d set req psn = 0x%x", qp->qpn, qp->req.psn);
+	}
+
+	if (mask & VHOST_RDMA_IB_QP_DEST_QPN)
+		qp->attr.dest_qp_num = cmd->dest_qp_num;
+
+	if (mask & VHOST_RDMA_IB_QP_STATE) {
+		qp->attr.qp_state = cmd->qp_state;
+
+		switch (cmd->qp_state) {
+		case VHOST_RDMA_IB_QPS_RESET:
+			RDMA_LOG_INFO("qp#%d state -> RESET", qp->qpn);
+			// TODO: rxe_qp_reset(qp);
+			break;
+
+		case VHOST_RDMA_IB_QPS_INIT:
+			RDMA_LOG_INFO("qp#%d state -> INIT", qp->qpn);
+			qp->req.state = QP_STATE_INIT;
+			qp->resp.state = QP_STATE_INIT;
+			break;
+
+		case VHOST_RDMA_IB_QPS_RTR:
+			RDMA_LOG_INFO("qp#%d state -> RTR", qp->qpn);
+			qp->resp.state = QP_STATE_READY;
+			break;
+
+		case VHOST_RDMA_IB_QPS_RTS:
+			RDMA_LOG_INFO("qp#%d state -> RTS", qp->qpn);
+			qp->req.state = QP_STATE_READY;
+			break;
+
+		case VHOST_RDMA_IB_QPS_SQD:
+			RDMA_LOG_INFO("qp#%d state -> SQD", qp->qpn);
+			// TODO: rxe_qp_drain(qp);
+			break;
+
+		case VHOST_RDMA_IB_QPS_SQE:
+			RDMA_LOG_INFO("qp#%d state -> SQE !!?", qp->qpn);
+			/* Not possible from modify_qp. */
+			break;
+
+		case VHOST_RDMA_IB_QPS_ERR:
+			RDMA_LOG_INFO("qp#%d state -> ERR", qp->qpn);
+			vhost_rdma_qp_error(qp);
+			break;
+		}
+	}
+
+	return 0;
+}
diff --git a/examples/vhost_user_rdma/vhost_rdma_queue.h b/examples/vhost_user_rdma/vhost_rdma_queue.h
new file mode 100644
index 0000000000..260eea51f8
--- /dev/null
+++ b/examples/vhost_user_rdma/vhost_rdma_queue.h
@@ -0,0 +1,338 @@
+/*
+ * Vhost-user RDMA device: Queue management and work request handling
+ *
+ * Copyright (C) 2025 KylinSoft Inc. and/or its affiliates. All rights reserved.
+ *
+ * Author: Xiong Weimin <xiongweimin@kylinos.cn>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef VHOST_RDMA_QUEUE_H_
+#define VHOST_RDMA_QUEUE_H_
+
+#include <stdint.h>
+#include <stdbool.h>
+#include <linux/types.h>
+
+#include "vhost_rdma_ib.h"
+
+#define QP_OPCODE_INVAILD (-1)
+
+/******************************************************************************
+ * Base Transport Header
+ ******************************************************************************/
+struct vhost_rdma_bth {
+	uint8_t			opcode;
+	uint8_t			flags;
+	rte_be16_t		pkey;
+	rte_be32_t		qpn;
+	rte_be32_t		apsn;
+};
+
+#define VHOST_RDMA_TVER		(0)
+#define VHOST_RDMA_DEF_PKEY		(0xffff)
+
+#define VHOST_RDMA_SE_MASK		(0x80)
+#define VHOST_RDMA_MIG_MASK		(0x40)
+#define VHOST_RDMA_PAD_MASK		(0x30)
+#define VHOST_RDMA_TVER_MASK		(0x0f)
+#define VHOST_RDMA_FECN_MASK		(0x80000000)
+#define VHOST_RDMA_BECN_MASK		(0x40000000)
+#define VHOST_RDMA_RESV6A_MASK		(0x3f000000)
+#define VHOST_RDMA_QPN_MASK		(0x00ffffff)
+#define VHOST_RDMA_ACK_MASK		(0x80000000)
+#define VHOST_RDMA_RESV7_MASK		(0x7f000000)
+#define VHOST_RDMA_PSN_MASK		(0x00ffffff)
+
+/**
+ * @brief Operation codes for Work Completions (WC)
+ *
+ * These represent the type of operation that has completed on a QP.
+ */
+enum vhost_rdma_ib_wc_opcode {
+	VHOST_RDMA_IB_WC_SEND,					/**< SEND operation completed */
+	VHOST_RDMA_IB_WC_RDMA_WRITE,			/**< RDMA Write operation completed */
+	VHOST_RDMA_IB_WC_RDMA_READ,				/**< RDMA Read operation completed */
+	VHOST_RDMA_IB_WC_RECV,					/**< Receive operation completed */
+	VHOST_RDMA_IB_WC_RECV_RDMA_WITH_IMM,	/**< RECV with immediate data */
+};
+
+/**
+ * @brief Operation codes for Work Requests (WR) posted to Send Queue (SQ)
+ */
+enum vhost_rdma_ib_wr_opcode {
+	VHOST_RDMA_IB_WR_RDMA_WRITE,			/**< RDMA Write request */
+	VHOST_RDMA_IB_WR_RDMA_WRITE_WITH_IMM,	/**< RDMA Write with immediate data */
+	VHOST_RDMA_IB_WR_SEND,					/**< Send message */
+	VHOST_RDMA_IB_WR_SEND_WITH_IMM,			/**< Send with immediate data */
+	VHOST_RDMA_IB_WR_RDMA_READ,				/**< RDMA Read request */
+};
+
+/**
+ * @brief Types of queues in a QP
+ */
+enum vhost_rdma_queue_type {
+	VHOST_RDMA_QUEUE_SQ,  /**< Send Queue */
+	VHOST_RDMA_QUEUE_RQ   /**< Receive Queue */
+};
+
+enum vhost_rdma_wqe_state {
+	WQE_STATE_POSTED,
+	WQE_STATE_PROCESSING,
+	WQE_STATE_PENDING,
+	WQE_STATE_DONE,
+	WQE_STATE_ERROR,
+};
+
+enum {
+	TASK_STATE_START = 0,
+	TASK_STATE_BUSY = 1,
+	TASK_STATE_ARMED = 2,
+};
+
+/**
+ * @brief Send Queue Work Request (WR) structure from userspace
+ *
+ * Represents a single WR submitted via the SQ. Contains metadata and SGE list.
+ */
+struct vhost_rdma_sq_req {
+	union {
+		__le32 num_sge;		/**< Number of scatter-gather entries */
+		__le16 inline_len;	/**< Length of inline data (if SEND_INLINE flag set) */
+	};
+	__u8 send_flags;	/**< Flags: FENCE, SIGNALED, SOLICITED, INLINE */
+	__u32 opcode;		/**< Operation code (from vhost_rdma_ib_wr_opcode) */
+	__le64 wr_id;		/**< User-defined WR identifier (passed back in CQE) */
+
+	/* Send flags definitions */
+#define VHOST_RDMA_IB_SEND_FENCE		(1 << 0)  /**< Fence: must wait for prior sends to complete */
+#define VHOST_RDMA_IB_SEND_SIGNALED		(1 << 1)  /**< Generate completion event if CQ is solicited */
+#define VHOST_RDMA_IB_SEND_SOLICITED	(1 << 2)  /**< Solicited event (used for reliable signaling) */
+#define VHOST_RDMA_IB_SEND_INLINE		(1 << 3)  /**< Data is inlined, not in MR */
+
+	__le32 imm_data;		/**< Immediate data (network byte order), used in WRITE/SEND_WITH_IMM */
+
+	union {
+		__le32 imm_data;		/**< Reuse field for immediate data */
+		__u32 invalidate_rkey;	/**< For fast memory registration invalidation */
+	} ex;
+
+	union {
+		struct {
+			__le64 remote_addr; /**< Target address in remote memory */
+			__le32 rkey;		/**< Remote key for memory region access */
+		} rdma;					/**< Used by RDMA_WRITE/READ operations */
+
+		struct {
+			__u64 remote_addr;	/**< Address for atomic target */
+			__u64 compare_add;	/**< Compare value in CMP-and-SWAP */
+			__u64 swap;			/**< Swap value in atomic operations */
+			__u32 rkey;			/**< Remote key */
+		} atomic;				/**< Atomic operations (not yet fully supported) */
+
+		struct {
+			__le32 remote_qpn;	/**< Destination QPN (for UD QPs) */
+			__le32 remote_qkey;	/**< Q_Key for UD packet validation */
+			__le32 ah;			/**< Address Handle index (pre-configured path info) */
+		} ud;					/**< Used only in UD (Unreliable Datagram) mode */
+
+		__le64 reserved[4];		/**< Reserved for future extensions */
+	};
+
+	__le32 reserved2[3];		/**< Padding/reserved fields */
+
+	/*
+	 * Scatter/Gather Element list follows this structure.
+	 * Actual number determined by num_sge.
+	 * Inline data may also follow for SEND_INLINE requests.
+	 */
+	struct vhost_rdma_sge sg_list[];	/**< Flexible array of SGEs */
+};
+
+/**
+ * @brief Receive Queue Work Request (RQ) structure
+ *
+ * Posted by consumers to indicate where incoming messages should be written.
+ */
+struct vhost_rdma_rq_req {
+	__le32 qpn;			/**< Local QP number (for multi-qp support) */
+	__le32 num_sge;		/**< Number of valid SGEs in sg_list */
+	__le64 wr_id;		/**< User-provided WR ID returned upon receive completion */
+
+	/*
+	 * Scatter/Gather Element list for receiving incoming payload.
+	 * Memory regions must already be registered.
+	 */
+	struct vhost_rdma_sge sg_list[];  /**< Flexible array of receive buffers */
+};
+
+/**
+ * @brief Work Completion Entry (CQE) format
+ *
+ * Populated when a WR completes and posted to the Completion Queue (CQ).
+ */
+struct vhost_rdma_cq_req {
+	__le64 wr_id;				/**< Echoed from the original WR */
+	__u8 status;				/**< Completion status (from vhost_rdma_ib_wc_status) */
+	__u8 opcode;				/**< Completed operation type (from vhost_rdma_ib_wc_opcode) */
+	__le16 padding;				/**< Align to 32-bit boundary */
+	__le32 vendor_err;			/**< Vendor-specific error code (if any) */
+	__le32 byte_len;			/**< Number of bytes transferred */
+	__le32 imm_data;			/**< Immediate data received (for SEND_WITH_IMM) */
+	__le32 qp_num;				/**< Local QP number where WR was executed */
+	__le32 src_qp;				/**< Source QP (valid only for UD receives) */
+#define VHOST_RDMA_IB_WC_GRH	(1 << 0)	/**< GRH header present in received packet */
+#define VHOST_RDMA_WC_WITH_IMM	(1 << 1)	/**< Immediate data is valid */
+	__le32 wc_flags;			/**< Additional flags (e.g., GRH, IMM) */
+	__le32 reserved[3];			/**< Future use */
+};
+
+struct vhost_rdma_cmd_req_notify {
+				/* The index of CQ */
+				uint32_t cqn;
+#define VHOST_RDMA_IB_NOTIFY_SOLICITED (1 << 0)
+#define VHOST_RDMA_IB_NOTIFY_NEXT_COMPLETION (1 << 1)
+#define VHOST_RDMA_IB_CQ_NEXT_COMP (1 << 2)
+#define VHOST_RDMA_IB_CQ_SOLICITED (1 << 3)
+				/* Notify flags */
+				uint32_t flags;
+};
+
+static __rte_always_inline void*
+vhost_rdma_queue_get_data(struct vhost_rdma_queue *queue, size_t idx)
+{
+	return queue->data + queue->elem_size * idx;
+}
+
+/*
+ * Function declarations
+ */
+
+/**
+ * @brief Initialize an internal Send WQE from a user WR
+ *
+ * @param qp		Pointer to the QP owning the WQE
+ * @param wr		User-submitted SQ request (source WR)
+ * @param mask		PSN mask for sequence handling
+ * @param length	Total data length of the request
+ * @param wqe		Output: initialized internal WQE
+ */
+void vhost_rdma_init_send_wqe(struct vhost_rdma_qp *qp,
+							struct vhost_rdma_sq_req *wr,
+							unsigned int mask,
+							unsigned int length,
+							struct vhost_rdma_send_wqe *wqe);
+
+/**
+ * @brief Process pending work requests on the Send Queue (SQ)
+ *
+ * Runs in datapath context; handles posting RDMA ops, sending packets, etc.
+ *
+ * @param arg       Pointer to QP (passed as void*)
+ */
+void vhost_rdma_handle_sq(void *arg);
+
+/**
+ * @brief Process incoming packets destined for Receive Queue (RQ)
+ *
+ * Currently stubbed; will handle packet delivery into pre-posted RQ buffers.
+ *
+ * @param arg       Unused placeholder (for compatibility with callback signature)
+ */
+void vhost_rdma_handle_rq(__rte_unused void *arg);
+
+/**
+ * @brief Post a completion entry to a Completion Queue (CQ)
+ *
+ * @param dev			Pointer to the vhost RDMA device
+ * @param cq			Target CQ to post to
+ * @param cqe			Completion entry to post
+ * @param solicited		Whether this is a solicited completion (triggers interrupt)
+ *
+ * @return 0 on success, negative errno on failure (e.g., CQ full)
+ */
+int vhost_rdma_cq_post(struct vhost_rdma_device *dev,
+					struct vhost_rdma_cq *cq,
+					struct vhost_rdma_cq_req *cqe,
+					int solicited);
+
+/**
+ * @brief Initialize a queue (SQ or RQ) associated with a QP
+ *
+ * Allocates and maps the virtqueue, sets up callbacks, and prepares for I/O.
+ *
+ * @param qp				Owning QP
+ * @param queue     Queue structure to initialize
+ * @param name      Human-readable name (e.g., "sq", "rq")
+ * @param vq				Underlying vhost_user_queue (from backend)
+ * @param elem_size Size of each element (WR size)
+ * @param type      Queue type: SQ or RQ
+ *
+ * @return 0 on success, negative error code on failure
+ */
+int vhost_rdma_queue_init(struct vhost_rdma_qp *qp,
+						struct vhost_rdma_queue *queue,
+						const char *name,
+						struct vhost_user_queue *vq,
+						size_t elem_size,
+						enum vhost_rdma_queue_type type);
+
+/**
+ * @brief Clean up resources associated with a queue
+ *
+ * Frees allocated WRs, resets pointers, and prepares for QP destruction.
+ *
+ * @param qp      Owning QP
+ * @param queue   Queue to clean up
+ */
+void vhost_rdma_queue_cleanup(struct vhost_rdma_qp *qp,
+												      struct vhost_rdma_queue *queue);
+
+void init_av_from_vhost_rdma(struct vhost_rdma_device *dev, 
+							struct vhost_rdma_av *dst,
+							uint32_t ah);
+
+int vhost_rdma_init_task(struct vhost_rdma_task *task, 
+						struct rte_ring *task_ring,
+						void *arg, int (*func)(void *), 
+						const char *name);
+
+void vhost_rdma_run_task(struct vhost_rdma_task *task, int sched);
+
+void vhost_rdma_do_task(struct vhost_rdma_task *task);
+
+void vhost_rdma_qp_destroy(struct vhost_rdma_qp *qp);
+
+int vhost_rdma_qp_validate(struct vhost_rdma_device *dev, 
+						struct vhost_rdma_qp *qp,
+						struct vhost_rdma_cmd_modify_qp *cmd);
+
+void vhost_rdma_qp_error(struct vhost_rdma_qp *qp);
+void vhost_rdma_qp_cleanup(void* arg);
+
+int vhost_rdma_requester(void* arg);
+int vhost_rdma_completer(void* arg);
+int vhost_rdma_responder(void* arg);
+
+bool vhost_rdma_ib_modify_qp_is_ok(enum vhost_rdma_ib_qp_state cur_state,
+								enum vhost_rdma_ib_qp_state next_state,
+								uint8_t type, 
+								enum vhost_rdma_ib_qp_attr_mask mask);
+
+void vhost_rdma_init_av(struct vhost_rdma_device *dev,
+						struct vhost_rdma_ah_attr *attr, 
+						struct vhost_rdma_av *av);
+
+void vhost_rdma_av_from_attr(struct vhost_rdma_av *av,
+		     				struct vhost_rdma_ah_attr *attr);
+
+void vhost_rdma_qp_destroy(struct vhost_rdma_qp *qp);
+
+int vhost_rdma_av_chk_attr(struct vhost_rdma_device *dev,
+						struct vhost_rdma_ah_attr *attr);
+
+#endif /* VHOST_RDMA_QUEUE_H_ */
\ No newline at end of file
-- 
2.43.0


