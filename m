Return-Path: <netdev+bounces-245073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8BBCC6A57
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 09:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 149683019BCB
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 08:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D187D33B6D2;
	Wed, 17 Dec 2025 08:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="okNe3fen"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712BD271A7B;
	Wed, 17 Dec 2025 08:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765961110; cv=none; b=YybDgCYeQJ+7/4m7DK2tk537/4sFp6/6/6PrY349tHMbIwm3yANDLwfMaApf05fs+ywEdeS7eSfy3zMKwuTndtrMLlYTc/e0+LaWI/lw682VbUmcfW7V+v0sICVR//HnJKiSpDpJaLmEfmO0eH+WH7CxZ9RJjrw4YGPKzQe8Yrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765961110; c=relaxed/simple;
	bh=o/w3owZuG+CxQo+msQdq071q//SHp4ra6FMBF+UNC2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hJXBjo3UYih1Y6Ldx2xloRaCNyHmI9XnTUx41nFYOjzBAy6FwFI/QdoKAyNTBXcxiz3ZiSS9T8pYkDpZBXJQCfqZ08KieMLH0qP7rnlRwbT7dzum6CCYozfCusZ9meO5B2j5B34JmnRiuMDGnPUwHRKKPkBW7OUqWObpxmpuJdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=okNe3fen; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=a0
	daBDYGRYqdbsbo55Y/5vbulZQ8GSPXdvblgAof10s=; b=okNe3fenktW1mXoz0A
	+hL7gPBGRDWaCHZVLwHXb1u9dwAojXVm/Fh/oP19Ejg4gMPkhEgx5utGrPsggmir
	SgRNbpFXPXqMF6ZAGJHGL4XeJJYuPCkoGeEk2lKlWm4yM+954/s6NudeGboyqfEz
	V+1gHT5yUeGCeCiQOXT/k8Am4=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDnwYJnbUJpSC+YAw--.48902S8;
	Wed, 17 Dec 2025 16:44:26 +0800 (CST)
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
Subject: [PATCH 03/14] examples/vhost_user_rdma: implement create and destroy completion queue commands
Date: Wed, 17 Dec 2025 16:43:29 +0800
Message-ID: <20251217084422.4875-5-15927021679@163.com>
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
X-CM-TRANSID:_____wDnwYJnbUJpSC+YAw--.48902S8
X-Coremail-Antispam: 1Uf129KBjvJXoWxWrykKFyrJry3KF1kGw4kWFg_yoW7JF18pa
	1Igw13WrW2qr17C3sFyw4Du3W3X3yrAry7JrZ3K3Z8tF15Krn5AaykC3Wjyr43tFW7Jr1x
	XFyUtFyrCF13A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnZ2-UUUUU=
X-CM-SenderInfo: jprvmjixqsilmxzbiqqrwthudrp/xtbC9Apg6GlCbWoPLQAA34

From: xiongweimin <xiongweimin@kylinos.cn>

This commit adds core functionality for managing RDMA Completion Queues (CQs):
1. CREATE_CQ command handler with resource allocation and initialization
2. DESTROY_CQ command with safe teardown procedures
3. Reference counting for lifecycle management
4. Concurrency control via spinlocks
5. Integration with device resource pools

Key features:
- Strict validation of CQ size against device capabilities
- Atomic state management with `is_dying` flag
- Virtual queue index reset during destruction
- Error logging for allocation failures
- Memory-safe buffer handling with CHK_IOVEC

Signed-off-by: xiongweimin <xiongweimin@kylinos.cn>
Change-Id: Ie4b51c90f36a1ceadfe4dbc622dc6fcaaaaf4261
---
 examples/vhost_user_rdma/vhost_rdma_ib.c | 59 +++++++++++++++++++++++-
 examples/vhost_user_rdma/vhost_rdma_ib.h | 33 ++++++++++++-
 2 files changed, 89 insertions(+), 3 deletions(-)

diff --git a/examples/vhost_user_rdma/vhost_rdma_ib.c b/examples/vhost_user_rdma/vhost_rdma_ib.c
index edb6e3fea3..5ec0de8ae7 100644
--- a/examples/vhost_user_rdma/vhost_rdma_ib.c
+++ b/examples/vhost_user_rdma/vhost_rdma_ib.c
@@ -563,13 +563,68 @@ vhost_rdma_query_port(__rte_unused struct vhost_rdma_device *dev,
 	return 0;
 }
 
+static int
+vhost_rdma_create_cq(struct vhost_rdma_device *dev,
+					struct iovec *in,
+					struct iovec *out)
+{
+	struct vhost_rdma_cmd_create_cq *create_cmd;
+	struct vhost_rdma_ack_create_cq *create_rsp;
+	struct vhost_rdma_cq *cq;
+	uint32_t cqn;
+
+	CHK_IOVEC(create_cmd, in);
+	if (create_cmd->cqe > dev->attr.max_cqe)
+		return -EINVAL;
+
+	CHK_IOVEC(create_rsp, out);
+
+	cq = vhost_rdma_pool_alloc(&dev->cq_pool, &cqn);
+	if (cq == NULL) {
+		RDMA_LOG_ERR("cq alloc failed");
+	}
+	vhost_rdma_ref_init(cq);
+
+	rte_spinlock_init(&cq->cq_lock);
+	cq->is_dying = false;
+	cq->notify = 0;
+	cq->vq = &dev->cq_vqs[cqn];
+	cq->cqn = cqn;
+	create_rsp->cqn = cqn;
+
+	return 0;
+}
+
+static int
+vhost_rdma_destroy_cq(struct vhost_rdma_device *dev, struct iovec *in, CTRL_NO_RSP)
+{
+	struct vhost_rdma_cmd_destroy_cq *destroy_cmd;
+	struct vhost_rdma_cq *cq;
+
+	CHK_IOVEC(destroy_cmd, in);
+
+	cq = vhost_rdma_pool_get(&dev->cq_pool, destroy_cmd->cqn);
+
+	rte_spinlock_lock(&cq->cq_lock);
+	cq->is_dying = true;
+	cq->vq->last_avail_idx = 0;
+	cq->vq->last_used_idx = 0;
+	rte_spinlock_unlock(&cq->cq_lock);
+
+	vhost_rdma_drop_ref(cq, dev, cq);
+
+	return 0;
+}
+
 /* Command handler table declaration */
 struct {
 	int (*handler)(struct vhost_rdma_device *dev, struct iovec *in, struct iovec *out);
 	const char *name;  /* Name of the command (for logging) */
 } cmd_tbl[] = {
-	DEFINE_VIRTIO_RDMA_CMD(VHOST_RDMA_CTRL_ROCE_QUERY_DEVICE, vhost_rdma_query_device),
-	DEFINE_VIRTIO_RDMA_CMD(VHOST_RDMA_CTRL_ROCE_QUERY_PORT, vhost_rdma_query_port),
+	DEFINE_VIRTIO_RDMA_CMD(VHOST_RDMA_CTRL_ROCE_QUERY_DEVICE,			vhost_rdma_query_device),
+	DEFINE_VIRTIO_RDMA_CMD(VHOST_RDMA_CTRL_ROCE_QUERY_PORT,				vhost_rdma_query_port),
+	DEFINE_VIRTIO_RDMA_CMD(VHOST_RDMA_CTRL_ROCE_CREATE_CQ,				vhost_rdma_create_cq),
+	DEFINE_VIRTIO_RDMA_CMD(VHOST_RDMA_CTRL_ROCE_DESTROY_CQ,				vhost_rdma_destroy_cq),
 };
 
 /**
diff --git a/examples/vhost_user_rdma/vhost_rdma_ib.h b/examples/vhost_user_rdma/vhost_rdma_ib.h
index 664067b024..6420c8c7e2 100644
--- a/examples/vhost_user_rdma/vhost_rdma_ib.h
+++ b/examples/vhost_user_rdma/vhost_rdma_ib.h
@@ -31,6 +31,12 @@
 
 #include "eal_interrupts.h"
 
+#define vhost_rdma_ref_init(obj) \
+	do{\
+		rte_atomic32_init(&(obj)->refcnt); \
+		rte_atomic32_inc(&(obj)->refcnt); \
+	}while(0)
+
 /* Forward declarations */
 struct vhost_rdma_device;
 struct vhost_queue;
@@ -370,7 +376,7 @@ struct vhost_user_rdma_msg {
  * @brief Completion Queue (CQ)
  */
 struct vhost_rdma_cq {
-	struct vhost_queue *vq;			/**< Notification V-ring */
+	struct vhost_user_queue *vq;         /**< Notification V-ring */
 	rte_spinlock_t cq_lock;			/**< Protect CQ operations */
 	uint8_t notify;					/**< Notify pending flag */
 	bool is_dying;					/**< Being destroyed */
@@ -676,6 +682,31 @@ struct vhost_rdma_ack_query_port {
 	uint32_t			reserved[32];	/* For future extensions */
 }__rte_packed;
 
+struct vhost_rdma_cmd_create_cq {
+        /* Size of CQ */
+        uint32_t cqe;
+};
+
+struct vhost_rdma_ack_create_cq {
+        /* The index of CQ */
+        uint32_t cqn;
+};
+
+struct vhost_rdma_cmd_destroy_cq {
+        /* The index of CQ */
+        uint32_t cqn;
+};
+
+struct vhost_rdma_ack_create_pd {
+        /* The handle of PD */
+        uint32_t pdn;
+};
+
+struct vhost_rdma_cmd_destroy_pd {
+        /* The handle of PD */
+        uint32_t pdn;
+};
+
 /**
  * @brief Convert IB MTU enum to byte size
  * @param mtu The MTU enum value
-- 
2.43.0


