Return-Path: <netdev+bounces-245087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CCACC6B6F
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 10:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA68D311A614
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 09:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900FC3451BA;
	Wed, 17 Dec 2025 08:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mPDouCnB"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169663446D2;
	Wed, 17 Dec 2025 08:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765961493; cv=none; b=jQCwOOfNIj8T1gfMq/tHys55IkKn/fKuMYOFwPp7AdAs0xk6EYYxXAKb9ZzAw+xpauSZW2GLun2KHbjdpmHKKvM22CoZkvRQpINjM6To88dPpIWfQ62lAaHmJKZ4nHfngNFqknGT4LJhKzl7bmY12hobGi5bucRDNCTEvV5L9HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765961493; c=relaxed/simple;
	bh=uyE2FB3W0UUHglg+Lbzoo++q97wFy5hvhxjHDXmhHrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UgnBKXXMYNVPk9khoI7ND2tv9sYnrEOnkXBbLHRyi8Zv1zNq9O5Bm55LfO4KeVbeERDgHa0OQ/st3hgEkMgzxyfOI1K4EZ+NdVp/0DcRH420Vh0XV17nxG8cvvtBAUqVBDgj6caX8/AqphNNfkdPHkc/eyrjmoo5JDeLlIvklB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=mPDouCnB; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Ke
	jZjpTs2z1nHnBhKeAa5cYW+32jLZLXvvWN/3sqCvU=; b=mPDouCnBzHMvhsrtt2
	Lfd0nArL9PId13YKTwWVMtHvAO5UJz5/Cc/9yJ29txY83VRA3LveZnYg/YD0T3Fr
	GMhNxVw1OKmQJwG1TErJcG9I0j8tW90nHVLRnCnsGzavVg/awCCDmHKxUiExQgw0
	PA+HWNYqmWMhAHRrs8LN7v/is=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wAXSZ7lbkJp2ZeZAw--.42656S9;
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
Subject: [PATCH 04/14] examples/vhost_user_rdma: implement protection domain create/destroy commands
Date: Wed, 17 Dec 2025 16:49:52 +0800
Message-ID: <20251217085044.5432-6-15927021679@163.com>
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
X-CM-TRANSID:_____wAXSZ7lbkJp2ZeZAw--.42656S9
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF1xKr1DKF1ruFyfZF43KFg_yoWrCFy8pF
	1Igw13WrZrtr17GwsFkw4DZF1fWr4rAry7GFs3G3Z5tF1jyrn5Aa1kCa1jkF4UGFW7Arn7
	X3WUtFyrCF13Z37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnl19UUUUU=
X-CM-SenderInfo: jprvmjixqsilmxzbiqqrwthudrp/xtbC9AnASWlCbuk+4gAA3E

From: xiongweimin <xiongweimin@kylinos.cn>

Added core functionality for managing RDMA Protection Domains (PDs):
1. CREATE_PD command for resource allocation and initialization
2. DESTROY_PD command with reference-counted teardown
3. Integration with device-specific PD resource pool
4. Minimalist state management for security domains
5. Robust input validation and error handling

Key features:
- PD identifier (pdn) generation and return to guest
- Atomic reference counting for lifecycle management
- Device association for resource tracking
- Memory-safe buffer handling with CHK_IOVEC
- ENOMEM handling for allocation failures

Signed-off-by: Xiong Weimin<xiongweimin@kylinos.cn>
Change-Id: I36d841a76067813c1880069c71b2eba90337609b
---
 examples/vhost_user_rdma/vhost_rdma_ib.c | 38 ++++++++++++++++++++++++
 examples/vhost_user_rdma/vhost_rdma_ib.h | 30 +++++++++----------
 2 files changed, 53 insertions(+), 15 deletions(-)

diff --git a/examples/vhost_user_rdma/vhost_rdma_ib.c b/examples/vhost_user_rdma/vhost_rdma_ib.c
index 5ec0de8ae7..e590b555d3 100644
--- a/examples/vhost_user_rdma/vhost_rdma_ib.c
+++ b/examples/vhost_user_rdma/vhost_rdma_ib.c
@@ -616,6 +616,42 @@ vhost_rdma_destroy_cq(struct vhost_rdma_device *dev, struct iovec *in, CTRL_NO_R
 	return 0;
 }
 
+static int
+vhost_rdma_create_pd(struct vhost_rdma_device *dev, CTRL_NO_CMD, struct iovec *out)
+{
+	struct vhost_rdma_ack_create_pd *create_rsp;
+	struct vhost_rdma_pd *pd;
+	uint32_t idx;
+
+	CHK_IOVEC(create_rsp, out);
+
+	pd = vhost_rdma_pool_alloc(&dev->pd_pool, &idx);
+	if(pd == NULL) {
+		return -ENOMEM;
+	}
+	vhost_rdma_ref_init(pd);
+
+	pd->dev = dev;
+	pd->pdn = idx;
+	create_rsp->pdn = idx;
+
+	return 0;
+}
+
+static int
+vhost_rdma_destroy_pd(struct vhost_rdma_device *dev, struct iovec *in, CTRL_NO_RSP)
+{
+	struct vhost_rdma_cmd_destroy_pd *create_cmd;
+	struct vhost_rdma_pd *pd;
+
+	CHK_IOVEC(create_cmd, in);
+
+	pd = vhost_rdma_pool_get(&dev->pd_pool, create_cmd->pdn);
+	vhost_rdma_drop_ref(pd, dev, pd);
+
+	return 0;
+}
+
 /* Command handler table declaration */
 struct {
 	int (*handler)(struct vhost_rdma_device *dev, struct iovec *in, struct iovec *out);
@@ -625,6 +661,8 @@ struct {
 	DEFINE_VIRTIO_RDMA_CMD(VHOST_RDMA_CTRL_ROCE_QUERY_PORT,				vhost_rdma_query_port),
 	DEFINE_VIRTIO_RDMA_CMD(VHOST_RDMA_CTRL_ROCE_CREATE_CQ,				vhost_rdma_create_cq),
 	DEFINE_VIRTIO_RDMA_CMD(VHOST_RDMA_CTRL_ROCE_DESTROY_CQ,				vhost_rdma_destroy_cq),
+	DEFINE_VIRTIO_RDMA_CMD(VHOST_RDMA_CTRL_ROCE_CREATE_PD,				vhost_rdma_create_pd),
+	DEFINE_VIRTIO_RDMA_CMD(VHOST_RDMA_CTRL_ROCE_DESTROY_PD,				vhost_rdma_destroy_pd),
 };
 
 /**
diff --git a/examples/vhost_user_rdma/vhost_rdma_ib.h b/examples/vhost_user_rdma/vhost_rdma_ib.h
index 6420c8c7e2..6356abc65a 100644
--- a/examples/vhost_user_rdma/vhost_rdma_ib.h
+++ b/examples/vhost_user_rdma/vhost_rdma_ib.h
@@ -667,44 +667,44 @@ struct vhost_rdma_ctrl_hdr {
 
 struct vhost_rdma_ack_query_port {
 	enum vhost_rdma_ib_port_state	state;
-	enum vhost_rdma_ib_mtu		    max_mtu;
-	enum vhost_rdma_ib_mtu		    active_mtu;
+	enum vhost_rdma_ib_mtu			max_mtu;
+	enum vhost_rdma_ib_mtu			active_mtu;
 	uint32_t			phys_mtu;
-	int			        gid_tbl_len;
+	int					gid_tbl_len;
 	uint32_t			port_cap_flags;
 	uint32_t			max_msg_sz;
 	uint32_t			bad_pkey_cntr;
 	uint32_t			qkey_viol_cntr;
 	uint16_t			pkey_tbl_len;
 	uint16_t			active_speed;
-	uint8_t			    active_width;
-	uint8_t			    phys_state;
+	uint8_t				active_width;
+	uint8_t				phys_state;
 	uint32_t			reserved[32];	/* For future extensions */
 }__rte_packed;
 
 struct vhost_rdma_cmd_create_cq {
-        /* Size of CQ */
-        uint32_t cqe;
+	/* Size of CQ */
+	uint32_t cqe;
 };
 
 struct vhost_rdma_ack_create_cq {
-        /* The index of CQ */
-        uint32_t cqn;
+	/* The index of CQ */
+	uint32_t cqn;
 };
 
 struct vhost_rdma_cmd_destroy_cq {
-        /* The index of CQ */
-        uint32_t cqn;
+	/* The index of CQ */
+	uint32_t cqn;
 };
 
 struct vhost_rdma_ack_create_pd {
-        /* The handle of PD */
-        uint32_t pdn;
+	/* The handle of PD */
+	uint32_t pdn;
 };
 
 struct vhost_rdma_cmd_destroy_pd {
-        /* The handle of PD */
-        uint32_t pdn;
+	/* The handle of PD */
+	uint32_t pdn;
 };
 
 /**
-- 
2.43.0


