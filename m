Return-Path: <netdev+bounces-245074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CABCC6A50
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 09:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3CC33303BE9B
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 08:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D83933AD9B;
	Wed, 17 Dec 2025 08:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PviVbDbv"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FC833AD8F;
	Wed, 17 Dec 2025 08:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765961111; cv=none; b=usC+6gJe39C6UuC3vJOeQbrnZnHURwUJezv7dqyKtPK4xYqkFU7t2Fh0wJJll6iW3P7Pdw3dRQLD9iZ0UUmT0NH6WqeK3T6HkiCLZ7VJ9clvwevxsJKeI/MoSJt0LJ2KAh1KiwD+5VibehlVM0T7WnIVe9cn8QV6vnw6L9NflDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765961111; c=relaxed/simple;
	bh=fLRGywa9lPhsK5X4L0DaM+QrW56GkDiljc/ltUMbkpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dIp+Fu6Re3ghlxofc+Z+XkdEGp1muewXEI0i2aNiTGJ6xXjEvfUwK+d9WyyI5jOAn/hpKD5YYgo5noSICQT2qsiqiiMuMyo+CdYh1+YHanogMBtlBwv65i5qKI8gybpFg6Atxvic/ScFT3/7myX5LbSom26DVIgmWCsCkgxPb+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=PviVbDbv; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=bj
	Gc7j20OGpBJyW3wS6zD2o5aQ0ylaE4phtnrPTERzo=; b=PviVbDbvb8XXMLr6um
	drT++/4jikgjdXakC+v3LETpi5wEmrkKGDSXXJWL9a1FBul7sejFbQW03UoIg3GA
	HW5wZ4O6pGA3X8zA2nC0VGVpJ2Y/jnu/nGl7zAx1TFpDKCLMoUGLNng1IrlFmmV4
	BgQMZatUWdJhNGvJ9pWRwnDFA=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDnwYJnbUJpSC+YAw--.48902S14;
	Wed, 17 Dec 2025 16:44:28 +0800 (CST)
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
Subject: [PATCH 09/14] examples/vhost_user_rdma: implement P_Key query operation with default partition key
Date: Wed, 17 Dec 2025 16:43:35 +0800
Message-ID: <20251217084422.4875-11-15927021679@163.com>
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
X-CM-TRANSID:_____wDnwYJnbUJpSC+YAw--.48902S14
X-Coremail-Antispam: 1Uf129KBjvJXoWxuw13XrW5Kw1xGrykurWrGrg_yoWxtryUpa
	1avr15ur9IgF1UCwnFvw1kuF4jqw4rArZxAFs3KFn7C3W5Jrn8JaykCanYkr47GFWIyFs7
	XF17tF95GFnxA37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnXo7UUUUU=
X-CM-SenderInfo: jprvmjixqsilmxzbiqqrwthudrp/xtbC8wxh6WlCbWwSiAAA3H

From: xiongweimin <xiongweimin@kylinos.cn>

This commit adds support for the IB_QUERY_PKEY command:
1. Implements mandatory InfiniBand partition key query
2. Provides default full-membership P_Key (0xFFFF)
3. Includes I/O vector safety validation
4. Maintains compatibility with standard IB management tools

Key features:
- Hardcoded default P_Key for simplified management
- Buffer size validation using CHK_IOVEC macro
- Zero-copy response writing via iovec
- Minimal overhead for frequent management operations

Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
Change-Id: Ibc7be3488989285da205aff7400be38995a435fd
---
 examples/vhost_user_rdma/meson.build     | 52 ++++++++++++------------
 examples/vhost_user_rdma/vhost_rdma_ib.c | 46 ++++++++++++++-------
 examples/vhost_user_rdma/vhost_rdma_ib.h |  4 ++
 3 files changed, 61 insertions(+), 41 deletions(-)

diff --git a/examples/vhost_user_rdma/meson.build b/examples/vhost_user_rdma/meson.build
index 4948f709d9..89ff4fbbf1 100644
--- a/examples/vhost_user_rdma/meson.build
+++ b/examples/vhost_user_rdma/meson.build
@@ -7,8 +7,8 @@
 # DPDK instance, use 'make'
 
 if not is_linux
-    build = false
-    subdir_done()
+	build = false
+	subdir_done()
 endif
 
 deps += ['vhost', 'timer']
@@ -16,35 +16,35 @@ deps += ['vhost', 'timer']
 allow_experimental_apis = true
 
 cflags_options = [
-        '-std=c11',
-        '-Wno-strict-prototypes',
-        '-Wno-pointer-arith',
-        '-Wno-maybe-uninitialized',
-        '-Wno-discarded-qualifiers',
-        '-Wno-old-style-definition',
-        '-Wno-sign-compare',
-        '-Wno-stringop-overflow',
-        '-O3',
-        '-g',
-        '-DALLOW_EXPERIMENTAL_API',
-        '-DDEBUG_RDMA',
-        '-DDEBUG_RDMA_DP',
+	'-std=c11',
+	'-Wno-strict-prototypes',
+	'-Wno-pointer-arith',
+	'-Wno-maybe-uninitialized',
+	'-Wno-discarded-qualifiers',
+	'-Wno-old-style-definition',
+	'-Wno-sign-compare',
+	'-Wno-stringop-overflow',
+	'-O3',
+	'-g',
+	'-DALLOW_EXPERIMENTAL_API',
+	'-DDEBUG_RDMA',
+	'-DDEBUG_RDMA_DP',
 ]
 
 foreach option:cflags_options
-    if cc.has_argument(option)
-        cflags += option
-    endif
+	if cc.has_argument(option)
+		cflags += option
+	endif
 endforeach
 
 sources = files(
-    'main.c',
-    'vhost_rdma.c',
-    'vhost_rdma_ib.c',
-    'vhost_rdma_queue.c',
-    'vhost_rdma_opcode.c',
-    'vhost_rdma_pkt.c',
-    'vhost_rdma_crc.c',
-    'vhost_rdma_complete.c',
+	'main.c',
+	'vhost_rdma.c',
+	'vhost_rdma_ib.c',
+	'vhost_rdma_queue.c',
+	'vhost_rdma_opcode.c',
+	'vhost_rdma_pkt.c',
+	'vhost_rdma_crc.c',
+	'vhost_rdma_complete.c',
 )
 
diff --git a/examples/vhost_user_rdma/vhost_rdma_ib.c b/examples/vhost_user_rdma/vhost_rdma_ib.c
index aac5c28e9a..437d45c5ce 100644
--- a/examples/vhost_user_rdma/vhost_rdma_ib.c
+++ b/examples/vhost_user_rdma/vhost_rdma_ib.c
@@ -36,7 +36,7 @@
 		tp = iov->iov_base; \
 	} while(0); \
 
-#define DEFINE_VIRTIO_RDMA_CMD(cmd, handler) [cmd] = {handler, #cmd}
+#define DEFINE_VHOST_RDMA_CMD(cmd, handler) [cmd] = {handler, #cmd}
 
 #define CTRL_NO_CMD __rte_unused struct iovec *__in
 #define CTRL_NO_RSP __rte_unused struct iovec *__out
@@ -1089,25 +1089,41 @@ vhost_rdma_destroy_qp(struct vhost_rdma_device *dev, struct iovec *in, CTRL_NO_R
 	return 0;
 }
 
+static int
+vhost_rdma_query_pkey(__rte_unused struct vhost_rdma_device *dev,
+					CTRL_NO_CMD, struct iovec *out)
+{
+	struct vhost_rdma_cmd_query_pkey *pkey_rsp;
+	uint16_t pkey = IB_DEFAULT_PKEY_FULL;
+
+	CHK_IOVEC(pkey_rsp, out);
+
+	pkey_rsp->pkey = pkey;
+
+	return 0;
+
+}
+
 /* Command handler table declaration */
 struct {
 	int (*handler)(struct vhost_rdma_device *dev, struct iovec *in, struct iovec *out);
 	const char *name;  /* Name of the command (for logging) */
 } cmd_tbl[] = {
-	DEFINE_VIRTIO_RDMA_CMD(VHOST_RDMA_CTRL_ROCE_QUERY_DEVICE,			vhost_rdma_query_device),
-	DEFINE_VIRTIO_RDMA_CMD(VHOST_RDMA_CTRL_ROCE_QUERY_PORT,				vhost_rdma_query_port),
-	DEFINE_VIRTIO_RDMA_CMD(VHOST_RDMA_CTRL_ROCE_CREATE_CQ,				vhost_rdma_create_cq),
-	DEFINE_VIRTIO_RDMA_CMD(VHOST_RDMA_CTRL_ROCE_DESTROY_CQ,				vhost_rdma_destroy_cq),
-	DEFINE_VIRTIO_RDMA_CMD(VHOST_RDMA_CTRL_ROCE_CREATE_PD,				vhost_rdma_create_pd),
-	DEFINE_VIRTIO_RDMA_CMD(VHOST_RDMA_CTRL_ROCE_DESTROY_PD,				vhost_rdma_destroy_pd),
-	DEFINE_VIRTIO_RDMA_CMD(VHOST_RDMA_CTRL_ROCE_GET_DMA_MR,				vhost_rdma_get_dma_mr),
-	DEFINE_VIRTIO_RDMA_CMD(VHOST_RDMA_CTRL_ROCE_ALLOC_MR,				vhost_rdma_alloc_mr),
-	DEFINE_VIRTIO_RDMA_CMD(VHOST_RDMA_CTRL_ROCE_REG_USER_MR,			vhost_rdma_reg_user_mr),
-	DEFINE_VIRTIO_RDMA_CMD(VHOST_RDMA_CTRL_ROCE_DEREG_MR,				vhost_rdma_dereg_mr),
-	DEFINE_VIRTIO_RDMA_CMD(VHOST_RDMA_CTRL_ROCE_CREATE_QP,				vhost_rdma_create_qp),
-	DEFINE_VIRTIO_RDMA_CMD(VHOST_RDMA_CTRL_ROCE_MODIFY_QP,				vhost_rdma_modify_qp),
-	DEFINE_VIRTIO_RDMA_CMD(VHOST_RDMA_CTRL_ROCE_QUERY_QP,				vhost_rdma_query_qp),
-	DEFINE_VIRTIO_RDMA_CMD(VHOST_RDMA_CTRL_ROCE_DESTROY_QP,				vhost_rdma_destroy_qp),
+	DEFINE_VHOST_RDMA_CMD(VHOST_RDMA_CTRL_ROCE_QUERY_DEVICE,			vhost_rdma_query_device),
+	DEFINE_VHOST_RDMA_CMD(VHOST_RDMA_CTRL_ROCE_QUERY_PORT,				vhost_rdma_query_port),
+	DEFINE_VHOST_RDMA_CMD(VHOST_RDMA_CTRL_ROCE_CREATE_CQ,				vhost_rdma_create_cq),
+	DEFINE_VHOST_RDMA_CMD(VHOST_RDMA_CTRL_ROCE_DESTROY_CQ,				vhost_rdma_destroy_cq),
+	DEFINE_VHOST_RDMA_CMD(VHOST_RDMA_CTRL_ROCE_CREATE_PD,				vhost_rdma_create_pd),
+	DEFINE_VHOST_RDMA_CMD(VHOST_RDMA_CTRL_ROCE_DESTROY_PD,				vhost_rdma_destroy_pd),
+	DEFINE_VHOST_RDMA_CMD(VHOST_RDMA_CTRL_ROCE_GET_DMA_MR,				vhost_rdma_get_dma_mr),
+	DEFINE_VHOST_RDMA_CMD(VHOST_RDMA_CTRL_ROCE_ALLOC_MR,				vhost_rdma_alloc_mr),
+	DEFINE_VHOST_RDMA_CMD(VHOST_RDMA_CTRL_ROCE_REG_USER_MR,				vhost_rdma_reg_user_mr),
+	DEFINE_VHOST_RDMA_CMD(VHOST_RDMA_CTRL_ROCE_DEREG_MR,				vhost_rdma_dereg_mr),
+	DEFINE_VHOST_RDMA_CMD(VHOST_RDMA_CTRL_ROCE_CREATE_QP,				vhost_rdma_create_qp),
+	DEFINE_VHOST_RDMA_CMD(VHOST_RDMA_CTRL_ROCE_MODIFY_QP,				vhost_rdma_modify_qp),
+	DEFINE_VHOST_RDMA_CMD(VHOST_RDMA_CTRL_ROCE_QUERY_QP,				vhost_rdma_query_qp),
+	DEFINE_VHOST_RDMA_CMD(VHOST_RDMA_CTRL_ROCE_DESTROY_QP,				vhost_rdma_destroy_qp),
+	DEFINE_VHOST_RDMA_CMD(VHOST_RDMA_CTRL_ROCE_QUERY_PKEY,				vhost_rdma_query_pkey),
 };
 
 /**
diff --git a/examples/vhost_user_rdma/vhost_rdma_ib.h b/examples/vhost_user_rdma/vhost_rdma_ib.h
index 79575e735c..5a1787fabe 100644
--- a/examples/vhost_user_rdma/vhost_rdma_ib.h
+++ b/examples/vhost_user_rdma/vhost_rdma_ib.h
@@ -957,6 +957,10 @@ struct vhost_rdma_cmd_destroy_qp {
 	uint32_t qpn;
 };
 
+struct vhost_rdma_cmd_query_pkey{
+	uint16_t pkey;
+};
+
 /**
  * @brief Convert IB MTU enum to byte size
  * @param mtu The MTU enum value
-- 
2.43.0


