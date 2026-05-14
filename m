Return-Path: <netdev+bounces-287888-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOTBKkSbBWq0YwIAu9opvQ
	(envelope-from <netdev+bounces-287888-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 11:52:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B21A6540003
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 11:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 905643006D70
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 09:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A1738D3FD;
	Thu, 14 May 2026 09:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="py+IrB4O"
X-Original-To: netdev@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA8D396D0D
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 09:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778752313; cv=none; b=PpAwQTpALO1xyNdZLUxuTUZUlP0peurapqZpUt9GkCIB6t6OfeP5IdGPOaxhPHSQknRFpemS24kVo8s3dnT+FP53/ASByuUU1GxNKUjjscvIDJpsSpMo67Z8gYP3iwc+vSu46vi/7CVFqybWFePZAEBC4RjLlqggVJf9FVbgt5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778752313; c=relaxed/simple;
	bh=BqK4dpw+237CWmWgbVfImqTGeZ2bpgpoVfqV2diCmus=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BdMvD8KYgyPmcNmv38KwbXdMwYqx3RSxqICtWZm3oYselwrxM7fQiBY/frbzK9i2pZ0VNM+RWgiAZl1NQNu6KvG+rNHfKeu3Ka9NgFFMHpxSdh0MAj1APqoYld5yQvBjRxxuR+ZwLaad8skVAfZ0Jb+HF84K7xHQ84PEVu7BxUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=py+IrB4O; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778752303; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=MMC45Aa49CcSuAhAaBSmmKJJyW89VgnnOsQuJ+zgfTg=;
	b=py+IrB4O8jjiLa9nJl9GdG8FWwRLT6BrIHmEWK0kcLOW/MJ/GQdCsJu9uyZFBavNOcI+9XY4owWxnfZKtZ8URefDPKnCcX9P9kHA/trGzXrv9IQiY0w/8s2JKh8Kq/TnrneRdFazXLIul8aFmaO4pwIJvxw5eY8MfxgoJKa9LiY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R601e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0X2wXL8v_1778752301;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X2wXL8v_1778752301 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 14 May 2026 17:51:42 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Philo Lu <lulie@linux.alibaba.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Dong Yibo <dong100@mucse.com>,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Dust Li <dust.li@linux.alibaba.com>
Subject: [PATCH net-next v43 3/8] eea: probe the netdevice and create adminq
Date: Thu, 14 May 2026 17:51:33 +0800
Message-Id: <20260514095138.80680-4-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20260514095138.80680-1-xuanzhuo@linux.alibaba.com>
References: <20260514095138.80680-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Git-Hash: 1b215e28dce9
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B21A6540003
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-287888-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linux.alibaba.com,linux.dev,mucse.com,stu.xidian.edu.cn,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuanzhuo@linux.alibaba.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,alibaba.com:email,linux.alibaba.com:mid,linux.alibaba.com:dkim]
X-Rspamd-Action: no action

Add basic driver framework for the Alibaba Elastic Ethernet Adapter(EEA).

This commit creates the netdevice after PCI probe,
and initializes the admin queue to send commands to the device.

Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
Reviewed-by: Philo Lu <lulie@linux.alibaba.com>
Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/ethernet/alibaba/eea/Makefile     |   6 +-
 drivers/net/ethernet/alibaba/eea/eea_adminq.c | 542 ++++++++++++++++++
 drivers/net/ethernet/alibaba/eea/eea_adminq.h |  83 +++
 drivers/net/ethernet/alibaba/eea/eea_net.c    | 249 ++++++++
 drivers/net/ethernet/alibaba/eea/eea_net.h    | 137 +++++
 drivers/net/ethernet/alibaba/eea/eea_pci.c    |  35 +-
 drivers/net/ethernet/alibaba/eea/eea_pci.h    |   3 +
 7 files changed, 1047 insertions(+), 8 deletions(-)
 create mode 100644 drivers/net/ethernet/alibaba/eea/eea_adminq.c
 create mode 100644 drivers/net/ethernet/alibaba/eea/eea_adminq.h
 create mode 100644 drivers/net/ethernet/alibaba/eea/eea_net.c
 create mode 100644 drivers/net/ethernet/alibaba/eea/eea_net.h

diff --git a/drivers/net/ethernet/alibaba/eea/Makefile b/drivers/net/ethernet/alibaba/eea/Makefile
index 7d8e7e8c2f3a..a842ac416ae8 100644
--- a/drivers/net/ethernet/alibaba/eea/Makefile
+++ b/drivers/net/ethernet/alibaba/eea/Makefile
@@ -1,4 +1,6 @@
 
 obj-$(CONFIG_ALIBABA_EEA) += eea.o
-eea-y :=  eea_ring.o \
-	eea_pci.o
+eea-y := eea_ring.o \
+	eea_net.o \
+	eea_pci.o \
+	eea_adminq.o
diff --git a/drivers/net/ethernet/alibaba/eea/eea_adminq.c b/drivers/net/ethernet/alibaba/eea/eea_adminq.c
new file mode 100644
index 000000000000..dfad1bdbc44d
--- /dev/null
+++ b/drivers/net/ethernet/alibaba/eea/eea_adminq.c
@@ -0,0 +1,542 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Driver for Alibaba Elastic Ethernet Adapter.
+ *
+ * Copyright (C) 2025 Alibaba Inc.
+ */
+
+#include <linux/etherdevice.h>
+#include <linux/iopoll.h>
+#include <linux/utsname.h>
+#include <linux/version.h>
+
+#include "eea_adminq.h"
+#include "eea_net.h"
+#include "eea_pci.h"
+#include "eea_ring.h"
+
+#define EEA_AQ_CMD_CFG_QUERY         ((0 << 8) | 0)
+
+#define EEA_AQ_CMD_QUEUE_CREATE      ((1 << 8) | 0)
+#define EEA_AQ_CMD_QUEUE_DESTROY_ALL ((1 << 8) | 1)
+
+#define EEA_AQ_CMD_HOST_INFO         ((2 << 8) | 0)
+
+#define EEA_AQ_CMD_DEV_STATUS        ((3 << 8) | 0)
+
+#define EEA_RING_DESC_F_AQ_PHASE     (BIT(15) | BIT(7))
+
+#define EEA_QUEUE_FLAGS_HW_SPLIT_HDR BIT(0)
+#define EEA_QUEUE_FLAGS_SQCQ         BIT(1)
+#define EEA_QUEUE_FLAGS_HWTS         BIT(2)
+
+struct eea_aq_create {
+	__le32 flags;
+	/* queue index.
+	 * rx: 0 == qidx % 2
+	 * tx: 1 == qidx % 2
+	 */
+	__le16 qidx;
+	/* the depth of the queue */
+	__le16 depth;
+	/*  0: without SPLIT HDR
+	 *  1: 128B
+	 *  2: 256B
+	 *  3: 512B
+	 */
+	u8 hdr_buf_size;
+	u8 sq_desc_size;
+	u8 cq_desc_size;
+	u8 reserve0;
+	/* The vector for the irq. rx,tx share the same vector */
+	__le16 msix_vector;
+	__le16 reserve;
+	/* sq ring cfg. */
+	__le32 sq_addr_low;
+	__le32 sq_addr_high;
+	/* cq ring cfg. Just valid when flags include EEA_QUEUE_FLAGS_SQCQ. */
+	__le32 cq_addr_low;
+	__le32 cq_addr_high;
+};
+
+struct eea_aq_queue_drv_status {
+	__le16 qidx;
+
+	__le16 sq_head;
+	__le16 cq_head;
+	__le16 reserved;
+};
+
+#define EEA_OS_DISTRO		0
+#define EEA_DRV_TYPE		0
+#define EEA_OS_LINUX		1
+#define EEA_SPEC_VER_MAJOR	1
+#define EEA_SPEC_VER_MINOR	0
+
+struct eea_aq_host_info_cfg {
+	__le16	os_type;
+	__le16	os_dist;
+	__le16	drv_type;
+
+	__le16	kern_ver_major;
+	__le16	kern_ver_minor;
+	__le16	kern_ver_sub_minor;
+
+	__le16	drv_ver_major;
+	__le16	drv_ver_minor;
+	__le16	drv_ver_sub_minor;
+
+	__le16	spec_ver_major;
+	__le16	spec_ver_minor;
+	__le16	pci_bdf;
+	__le32	pci_domain;
+
+	u8      os_ver_str[64];
+	u8      isa_str[64];
+};
+
+#define EEA_HINFO_MAX_REP_LEN	1024
+#define EEA_HINFO_REP_BAD	2
+
+struct eea_aq_host_info_rep {
+	u8	op_code;
+	u8	has_reply;
+	u8	reply_str[EEA_HINFO_MAX_REP_LEN];
+};
+
+static struct eea_ring *qid_to_ering(struct eea_net *enet, u32 qid)
+{
+	struct eea_ring *ering;
+
+	if (qid % 2 == 0)
+		ering = enet->rx[qid / 2]->ering;
+	else
+		ering = enet->tx[qid / 2].ering;
+
+	return ering;
+}
+
+#define EEA_AQ_TIMEOUT_US (60 * 1000 * 1000)
+
+static void eea_device_broken(struct eea_net *enet)
+{
+	if (enet->adminq.broken)
+		return;
+
+	eea_device_reset(enet->edev);
+	enet->adminq.broken = true;
+}
+
+static int eea_adminq_submit(struct eea_net *enet, u16 cmd,
+			     dma_addr_t req_addr, dma_addr_t res_addr,
+			     u32 req_size, u32 res_size, u32 *reply_len)
+{
+	struct eea_aq_cdesc *cdesc;
+	struct eea_aq_desc *desc;
+	int ret;
+
+	if (enet->adminq.broken)
+		return -EIO;
+
+	desc = eea_ering_aq_alloc_desc(enet->adminq.ring);
+
+	desc->classid = cmd >> 8;
+	desc->command = cmd & 0xff;
+
+	desc->data_addr = cpu_to_le64(req_addr);
+	desc->data_len = cpu_to_le32(req_size);
+
+	desc->reply_addr = cpu_to_le64(res_addr);
+	desc->reply_len = cpu_to_le32(res_size);
+
+	/* for update flags */
+	dma_wmb();
+
+	desc->flags = cpu_to_le16(enet->adminq.phase);
+
+	eea_ering_sq_commit_desc(enet->adminq.ring);
+
+	eea_ering_kick(enet->adminq.ring);
+
+	++enet->adminq.num;
+
+	if ((enet->adminq.num % enet->adminq.ring->num) == 0)
+		enet->adminq.phase ^= EEA_RING_DESC_F_AQ_PHASE;
+
+	ret = read_poll_timeout(eea_ering_cq_get_desc, cdesc, cdesc, 10,
+				EEA_AQ_TIMEOUT_US, false, enet->adminq.ring);
+	if (ret) {
+		netdev_err(enet->netdev,
+			   "adminq exec timeout. cmd: %d reset device.\n",
+			   cmd);
+		/* The device must be reset before unmapping buffers to avoid
+		 * potential DMA writes after the memory is freed.
+		 */
+		eea_device_broken(enet);
+		return ret;
+	}
+
+	/* Returns 0 on success, or a negative error code on failure. */
+	ret = le32_to_cpu(cdesc->status);
+
+	eea_ering_cq_ack_desc(enet->adminq.ring, 1);
+
+	if (ret)
+		netdev_err(enet->netdev,
+			   "adminq exec failed. cmd: %d ret %d\n", cmd, ret);
+	else
+		*reply_len = le32_to_cpu(cdesc->reply_len);
+
+	return ret;
+}
+
+static int eea_adminq_exec(struct eea_net *enet, u16 cmd,
+			   void *req, u32 req_size,
+			   void *res, u32 res_size,
+			   u32 *reply)
+{
+	dma_addr_t req_addr = 0, res_addr = 0;
+	struct device *dma;
+	u32 reply_len = 0;
+	int ret;
+
+	if (reply)
+		*reply = 0;
+
+	dma = enet->edev->dma_dev;
+
+	if (req) {
+		req_addr = dma_map_single(dma, req, req_size, DMA_TO_DEVICE);
+		if (unlikely(dma_mapping_error(dma, req_addr)))
+			return -ENOMEM;
+	}
+
+	if (res) {
+		res_addr = dma_map_single(dma, res, res_size, DMA_FROM_DEVICE);
+		if (unlikely(dma_mapping_error(dma, res_addr))) {
+			ret = -ENOMEM;
+			goto err_unmap_req;
+		}
+	}
+
+	mutex_lock(&enet->adminq.lock);
+	ret = eea_adminq_submit(enet, cmd, req_addr, res_addr,
+				req_size, res_size, &reply_len);
+	mutex_unlock(&enet->adminq.lock);
+	if (res) {
+		dma_unmap_single(dma, res_addr, res_size, DMA_FROM_DEVICE);
+
+		if (ret)
+			memset(res, 0, res_size);
+		else if (res_size > reply_len)
+			memset(res + reply_len, 0, res_size - reply_len);
+
+		if (reply)
+			*reply = reply_len;
+	}
+
+err_unmap_req:
+	if (req)
+		dma_unmap_single(dma, req_addr, req_size, DMA_TO_DEVICE);
+
+	return ret;
+}
+
+void eea_destroy_adminq(struct eea_net *enet)
+{
+	struct eea_aq *aq;
+
+	aq = &enet->adminq;
+
+	if (aq->ring) {
+		eea_ering_free(aq->ring);
+		aq->ring = NULL;
+		aq->phase = 0;
+	}
+
+	kfree(aq->q_req_buf);
+	kfree(aq->q_res_buf);
+
+	aq->q_req_buf = NULL;
+	aq->q_res_buf = NULL;
+}
+
+int eea_create_adminq(struct eea_net *enet, u32 qid)
+{
+	u32 db_size, q_size, num;
+	struct eea_ring *ering;
+	struct eea_aq *aq;
+	int err = -ENOMEM;
+
+	num = enet->edev->rx_num + enet->edev->tx_num;
+	aq = &enet->adminq;
+
+	ering = eea_ering_alloc(qid, 64, enet->edev, sizeof(struct eea_aq_desc),
+				sizeof(struct eea_aq_cdesc), "adminq");
+	if (!ering)
+		return -ENOMEM;
+
+	aq->ring = ering;
+
+	err = eea_pci_active_aq(ering, qid / 2 + 1);
+	if (err)
+		goto err;
+
+	aq->phase = BIT(7);
+	aq->num = 0;
+
+	q_size = sizeof(*aq->q_req_buf) * num;
+	db_size = sizeof(*aq->q_res_buf) * num;
+
+	aq->q_req_size = q_size;
+	aq->q_res_size = db_size;
+
+	err = -ENOMEM;
+
+	aq->q_req_buf = kzalloc(q_size, GFP_KERNEL);
+	if (!aq->q_req_buf)
+		goto err;
+
+	aq->q_res_buf = kzalloc(db_size, GFP_KERNEL);
+	if (!aq->q_res_buf)
+		goto err;
+
+	/* Before we set up the AQ, the device remains in an inactive state, so
+	 * there will be no DMA operations. If the 'set up AQ' process fails, we
+	 * can safely free the DMA-related memory.
+	 */
+	err = eea_pci_set_aq_up(enet->edev);
+	if (err)
+		goto err;
+
+	aq->broken = false;
+
+	mutex_init(&aq->lock);
+
+	return 0;
+
+err:
+	eea_destroy_adminq(enet);
+	return err;
+}
+
+int eea_adminq_query_cfg(struct eea_net *enet, struct eea_aq_cfg *cfg)
+{
+	return eea_adminq_exec(enet, EEA_AQ_CMD_CFG_QUERY, NULL, 0, cfg,
+			       sizeof(*cfg), NULL);
+}
+
+static void qcfg_fill(struct eea_aq_create *qcfg, struct eea_ring *ering,
+		      u32 flags)
+{
+	qcfg->flags = cpu_to_le32(flags);
+	qcfg->qidx = cpu_to_le16(ering->index);
+	qcfg->depth = cpu_to_le16(ering->num);
+
+	qcfg->hdr_buf_size = flags & EEA_QUEUE_FLAGS_HW_SPLIT_HDR ? 1 : 0;
+	qcfg->sq_desc_size = ering->sq.desc_size;
+	qcfg->cq_desc_size = ering->cq.desc_size;
+	qcfg->msix_vector = cpu_to_le16(ering->msix_vec);
+
+	qcfg->sq_addr_low = cpu_to_le32(lower_32_bits(ering->sq.dma_addr));
+	qcfg->sq_addr_high = cpu_to_le32(upper_32_bits(ering->sq.dma_addr));
+
+	qcfg->cq_addr_low = cpu_to_le32(lower_32_bits(ering->cq.dma_addr));
+	qcfg->cq_addr_high = cpu_to_le32(upper_32_bits(ering->cq.dma_addr));
+}
+
+int eea_adminq_create_q(struct eea_net *enet, u32 num, u32 flags)
+{
+	int i, db_size, q_size, err = -ENOMEM;
+	struct eea_net_cfg *cfg;
+	struct eea_ring *ering;
+	struct eea_aq *aq;
+	u32 reply_len;
+
+	cfg = &enet->cfg;
+	aq = &enet->adminq;
+
+	if (cfg->split_hdr)
+		flags |= EEA_QUEUE_FLAGS_HW_SPLIT_HDR;
+
+	flags |= EEA_QUEUE_FLAGS_SQCQ;
+	flags |= EEA_QUEUE_FLAGS_HWTS;
+
+	q_size = sizeof(*aq->q_req_buf) * num;
+	db_size = sizeof(*aq->q_res_buf) * num;
+
+	for (i = 0; i < num; i++) {
+		ering = qid_to_ering(enet, i);
+		qcfg_fill(aq->q_req_buf + i, ering, flags);
+	}
+
+	err = eea_adminq_exec(enet, EEA_AQ_CMD_QUEUE_CREATE,
+			      aq->q_req_buf, q_size,
+			      aq->q_res_buf, db_size,
+			      &reply_len);
+	if (err)
+		return err;
+
+	if (reply_len != db_size) {
+		eea_adminq_destroy_all_q(enet);
+		netdev_err(enet->netdev, "invalid reply len %u\n", reply_len);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < num; i++) {
+		ering = qid_to_ering(enet, i);
+		ering->db = eea_pci_db_addr(ering->edev,
+					    le32_to_cpu(aq->q_res_buf[i]));
+		if (!ering->db) {
+			netdev_err(enet->netdev, "invalid db off %u\n",
+				   le32_to_cpu(aq->q_res_buf[i]));
+			goto err;
+		}
+	}
+
+	return err;
+
+err:
+	eea_adminq_destroy_all_q(enet);
+	for (i = 0; i < num; i++) {
+		ering = qid_to_ering(enet, i);
+		ering->db = NULL;
+	}
+
+	return -EIO;
+}
+
+int eea_adminq_destroy_all_q(struct eea_net *enet)
+{
+	int err;
+
+	err = eea_adminq_exec(enet, EEA_AQ_CMD_QUEUE_DESTROY_ALL, NULL, 0,
+			      NULL, 0, NULL);
+	if (err) {
+		/* The device must be reset before unmapping buffers to avoid
+		 * potential DMA writes after the memory is freed.
+		 */
+		mutex_lock(&enet->adminq.lock);
+		eea_device_broken(enet);
+		mutex_unlock(&enet->adminq.lock);
+
+		netdev_err(enet->netdev, "QUEUE_DESTROY fail: reset device.\n");
+	}
+
+	return err;
+}
+
+/* The caller must ensure that both the 'rx' and 'tx' arrays are valid. */
+int eea_adminq_dev_status(struct eea_net *enet,
+			  struct eea_aq_dev_status *dstatus)
+{
+	struct eea_aq_queue_drv_status *drv_status;
+	struct __eea_aq_dev_status *dev_status;
+	int err, i, io_num, size, q_num;
+	struct eea_ring *ering;
+	void *rep, *req;
+
+	q_num = enet->cfg.rx_ring_num + enet->cfg.tx_ring_num + 1;
+	io_num = enet->cfg.rx_ring_num + enet->cfg.tx_ring_num;
+
+	req = kcalloc(q_num, sizeof(struct eea_aq_queue_drv_status),
+		      GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	size = struct_size(dev_status, q_status, q_num);
+
+	rep = kzalloc(size, GFP_KERNEL);
+	if (!rep) {
+		kfree(req);
+		return -ENOMEM;
+	}
+
+	drv_status = req;
+	for (i = 0; i < io_num; ++i, ++drv_status) {
+		ering = qid_to_ering(enet, i);
+		drv_status->qidx = cpu_to_le16(i);
+		drv_status->cq_head = cpu_to_le16(ering->cq.head);
+		drv_status->sq_head = cpu_to_le16(ering->sq.head);
+	}
+
+	drv_status->qidx = cpu_to_le16(i);
+	drv_status->cq_head = cpu_to_le16(enet->adminq.ring->cq.head);
+	drv_status->sq_head = cpu_to_le16(enet->adminq.ring->sq.head);
+
+	err = eea_adminq_exec(enet, EEA_AQ_CMD_DEV_STATUS, req,
+			      q_num * sizeof(struct eea_aq_queue_drv_status),
+			      rep, size, NULL);
+	kfree(req);
+	if (err) {
+		kfree(rep);
+		return err;
+	}
+
+	dstatus->num = q_num;
+	dstatus->status = rep;
+
+	return 0;
+}
+
+void eea_adminq_config_host_info(struct eea_net *enet)
+{
+	struct device *dev = enet->edev->dma_dev;
+	struct eea_aq_host_info_cfg *cfg;
+	struct eea_aq_host_info_rep *rep;
+	int rc = -ENOMEM;
+
+	cfg = kzalloc(sizeof(*cfg), GFP_KERNEL);
+	if (!cfg)
+		return;
+
+	rep = kzalloc(sizeof(*rep), GFP_KERNEL);
+	if (!rep)
+		goto err_free_cfg;
+
+	cfg->os_type            = cpu_to_le16(EEA_OS_LINUX);
+	cfg->os_dist            = cpu_to_le16(EEA_OS_DISTRO);
+	cfg->drv_type           = cpu_to_le16(EEA_DRV_TYPE);
+
+	cfg->kern_ver_major     = cpu_to_le16(LINUX_VERSION_MAJOR);
+	cfg->kern_ver_minor     = cpu_to_le16(LINUX_VERSION_PATCHLEVEL);
+	cfg->kern_ver_sub_minor = cpu_to_le16(LINUX_VERSION_SUBLEVEL);
+
+	cfg->drv_ver_major      = cpu_to_le16(EEA_VER_MAJOR);
+	cfg->drv_ver_minor      = cpu_to_le16(EEA_VER_MINOR);
+	cfg->drv_ver_sub_minor  = cpu_to_le16(EEA_VER_SUB_MINOR);
+
+	cfg->spec_ver_major     = cpu_to_le16(EEA_SPEC_VER_MAJOR);
+	cfg->spec_ver_minor     = cpu_to_le16(EEA_SPEC_VER_MINOR);
+
+	cfg->pci_bdf            = cpu_to_le16(eea_pci_bdf(enet->edev));
+	cfg->pci_domain         = cpu_to_le32(eea_pci_domain_nr(enet->edev));
+
+	strscpy(cfg->os_ver_str, utsname()->release, sizeof(cfg->os_ver_str));
+	strscpy(cfg->isa_str, utsname()->machine, sizeof(cfg->isa_str));
+
+	rc = eea_adminq_exec(enet, EEA_AQ_CMD_HOST_INFO,
+			     cfg, sizeof(*cfg), rep, sizeof(*rep), NULL);
+
+	if (!rc) {
+		if (rep->op_code == EEA_HINFO_REP_BAD)
+			dev_warn(dev, "The hardware-driven state validation may be abnormal.\n");
+
+		if (rep->has_reply) {
+			char buf[EEA_HINFO_MAX_REP_LEN] = {0};
+
+			rep->reply_str[EEA_HINFO_MAX_REP_LEN - 1] = '\0';
+
+			string_escape_str(rep->reply_str, buf, sizeof(buf),
+					  ESCAPE_NP, NULL);
+
+			buf[EEA_HINFO_MAX_REP_LEN - 1] = '\0';
+
+			dev_warn(dev, "Device replied: %s\n", buf);
+		}
+	}
+
+	kfree(rep);
+err_free_cfg:
+	kfree(cfg);
+}
diff --git a/drivers/net/ethernet/alibaba/eea/eea_adminq.h b/drivers/net/ethernet/alibaba/eea/eea_adminq.h
new file mode 100644
index 000000000000..0182f5641fcf
--- /dev/null
+++ b/drivers/net/ethernet/alibaba/eea/eea_adminq.h
@@ -0,0 +1,83 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Driver for Alibaba Elastic Ethernet Adapter.
+ *
+ * Copyright (C) 2025 Alibaba Inc.
+ */
+
+#ifndef __EEA_ADMINQ_H__
+#define __EEA_ADMINQ_H__
+
+struct eea_aq_cfg {
+	__le32 rx_depth_max;
+	__le32 rx_depth_def;
+
+	__le32 tx_depth_max;
+	__le32 tx_depth_def;
+
+	__le32 max_tso_size;
+	__le32 max_tso_segs;
+
+	u8 mac[ETH_ALEN];
+	__le16 status;
+
+	__le16 mtu;
+	__le16 reserved0;
+	__le16 reserved1;
+	u8 reserved2;
+	u8 reserved3;
+
+	__le16 reserved4;
+	__le16 reserved5;
+	__le16 reserved6;
+};
+
+struct eea_aq_queue_status {
+	__le16 qidx;
+#define EEA_QUEUE_STATUS_OK 0
+#define EEA_QUEUE_STATUS_NEED_RESET 1
+	__le16 status;
+};
+
+struct __eea_aq_dev_status {
+#define EEA_LINK_DOWN_STATUS  0
+#define EEA_LINK_UP_STATUS    1
+	__le16 link_status;
+	__le16 reserved;
+
+	struct eea_aq_queue_status q_status[];
+};
+
+struct eea_aq_dev_status {
+	u32 num;
+	struct __eea_aq_dev_status *status;
+};
+
+struct eea_aq {
+	struct eea_ring *ring;
+	u32 num;
+	bool broken;
+	u16 phase;
+
+	/* lock for adminq exec */
+	struct mutex lock;
+
+	u32 q_req_size;
+	u32 q_res_size;
+	struct eea_aq_create *q_req_buf;
+	__le32 *q_res_buf;
+};
+
+struct eea_net;
+
+int eea_create_adminq(struct eea_net *enet, u32 qid);
+void eea_destroy_adminq(struct eea_net *enet);
+
+int eea_adminq_query_cfg(struct eea_net *enet, struct eea_aq_cfg *cfg);
+
+int eea_adminq_create_q(struct eea_net *enet, u32 num, u32 flags);
+int eea_adminq_destroy_all_q(struct eea_net *enet);
+int eea_adminq_dev_status(struct eea_net *enet,
+			  struct eea_aq_dev_status *dstatus);
+void eea_adminq_config_host_info(struct eea_net *enet);
+#endif
diff --git a/drivers/net/ethernet/alibaba/eea/eea_net.c b/drivers/net/ethernet/alibaba/eea/eea_net.c
new file mode 100644
index 000000000000..bb8a49f8c6df
--- /dev/null
+++ b/drivers/net/ethernet/alibaba/eea/eea_net.c
@@ -0,0 +1,249 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Driver for Alibaba Elastic Ethernet Adapter.
+ *
+ * Copyright (C) 2025 Alibaba Inc.
+ */
+
+#include <linux/etherdevice.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/rtnetlink.h>
+#include <net/netdev_queues.h>
+
+#include "eea_adminq.h"
+#include "eea_net.h"
+#include "eea_pci.h"
+#include "eea_ring.h"
+
+#define EEA_SPLIT_HDR_SIZE ALIGN(128, L1_CACHE_BYTES)
+
+static int eea_update_cfg(struct eea_net *enet,
+			  struct eea_device *edev,
+			  struct eea_aq_cfg *hwcfg)
+{
+	u32 rx_max = le32_to_cpu(hwcfg->rx_depth_max);
+	u32 tx_max = le32_to_cpu(hwcfg->tx_depth_max);
+	u32 rx_def = le32_to_cpu(hwcfg->rx_depth_def);
+	u32 tx_def = le32_to_cpu(hwcfg->tx_depth_def);
+
+	/* Now, we assert that the rx ring num is equal to the tx ring num. */
+	if (edev->rx_num != edev->tx_num) {
+		dev_err(edev->dma_dev, "Inconsistent ring num: RX %u, TX %u\n",
+			edev->rx_num, edev->tx_num);
+		return -EINVAL;
+	}
+
+	if (rx_max > EEA_NET_IO_HW_RING_DEPTH_MAX ||
+	    rx_max < EEA_NET_IO_HW_RING_DEPTH_MIN ||
+	    tx_max > EEA_NET_IO_HW_RING_DEPTH_MAX ||
+	    tx_max < EEA_NET_IO_HW_RING_DEPTH_MIN) {
+		dev_err(edev->dma_dev, "Invalid HW max depth: RX %u, TX %u\n",
+			rx_max, tx_max);
+		return -EINVAL;
+	}
+
+	if (rx_def > rx_max ||
+	    tx_def > tx_max ||
+	    rx_def < EEA_NET_IO_HW_RING_DEPTH_MIN ||
+	    tx_def < EEA_NET_IO_HW_RING_DEPTH_MIN) {
+		dev_err(edev->dma_dev, "Invalid default depth: RX %u (max %u), TX %u (max %u)\n",
+			rx_def, rx_max, tx_def, tx_max);
+		return -EINVAL;
+	}
+
+	if (!is_power_of_2(rx_max) || !is_power_of_2(tx_max) ||
+	    !is_power_of_2(rx_def) || !is_power_of_2(tx_def)) {
+		dev_err(edev->dma_dev, "Ring depth must be power of 2\n");
+		return -EINVAL;
+	}
+
+	enet->cfg_hw.rx_ring_depth = rx_max;
+	enet->cfg_hw.tx_ring_depth = tx_max;
+	enet->cfg_hw.rx_ring_num = edev->rx_num;
+	enet->cfg_hw.tx_ring_num = edev->tx_num;
+	enet->cfg_hw.split_hdr = EEA_SPLIT_HDR_SIZE;
+
+	enet->cfg.rx_ring_depth = rx_def;
+	enet->cfg.tx_ring_depth = tx_def;
+	enet->cfg.rx_ring_num = edev->rx_num;
+	enet->cfg.tx_ring_num = edev->tx_num;
+
+	return 0;
+}
+
+static int eea_netdev_init_features(struct net_device *netdev,
+				    struct eea_net *enet,
+				    struct eea_device *edev)
+{
+	struct eea_aq_cfg *cfg;
+	int err;
+	u32 mtu;
+
+	cfg = kzalloc(sizeof(*cfg), GFP_KERNEL);
+	if (!cfg)
+		return -ENOMEM;
+
+	err = eea_adminq_query_cfg(enet, cfg);
+	if (err)
+		goto err_free;
+
+	mtu = le16_to_cpu(cfg->mtu);
+	if (mtu < ETH_MIN_MTU) {
+		dev_err(edev->dma_dev, "The device gave us an invalid MTU. Here we can only exit the initialization. %u < %u\n",
+			mtu, ETH_MIN_MTU);
+		err = -EINVAL;
+		goto err_free;
+	}
+
+	err = eea_update_cfg(enet, edev, cfg);
+	if (err)
+		goto err_free;
+
+	netdev->priv_flags |= IFF_UNICAST_FLT;
+	netdev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
+
+	netdev->hw_features |= NETIF_F_HW_CSUM;
+	netdev->hw_features |= NETIF_F_GRO_HW;
+	netdev->hw_features |= NETIF_F_SG;
+	netdev->hw_features |= NETIF_F_TSO;
+	netdev->hw_features |= NETIF_F_TSO_ECN;
+	netdev->hw_features |= NETIF_F_TSO6;
+	netdev->hw_features |= NETIF_F_GSO_UDP_L4;
+
+	netdev->features |= NETIF_F_HIGHDMA;
+	netdev->features |= NETIF_F_HW_CSUM;
+	netdev->features |= NETIF_F_SG;
+	netdev->features |= NETIF_F_GSO_ROBUST;
+	netdev->features |= netdev->hw_features & NETIF_F_ALL_TSO;
+	netdev->features |= NETIF_F_RXCSUM;
+	netdev->features |= NETIF_F_GRO_HW;
+
+	netdev->vlan_features = netdev->features;
+
+	if (!is_valid_ether_addr(cfg->mac)) {
+		dev_err(edev->dma_dev, "The device gave invalid mac %pM\n",
+			cfg->mac);
+		err = -EINVAL;
+		goto err_free;
+	}
+
+	eth_hw_addr_set(netdev, cfg->mac);
+
+	enet->speed = SPEED_UNKNOWN;
+	enet->duplex = DUPLEX_UNKNOWN;
+
+	netdev->min_mtu = ETH_MIN_MTU;
+
+	netdev->mtu = mtu;
+
+	/* If jumbo frames are already enabled, then the returned MTU will be a
+	 * jumbo MTU, and the driver will automatically enable jumbo frame
+	 * support by default.
+	 */
+	netdev->max_mtu = mtu;
+
+err_free:
+	kfree(cfg);
+	return err;
+}
+
+static const struct net_device_ops eea_netdev = {
+	.ndo_validate_addr  = eth_validate_addr,
+	.ndo_features_check = passthru_features_check,
+};
+
+static struct eea_net *eea_netdev_alloc(struct eea_device *edev, u32 pairs)
+{
+	struct net_device *netdev;
+	struct eea_net *enet;
+
+	netdev = alloc_etherdev_mq(sizeof(struct eea_net), pairs);
+	if (!netdev) {
+		dev_err(edev->dma_dev,
+			"alloc_etherdev_mq failed with pairs %d\n", pairs);
+		return NULL;
+	}
+
+	netdev->netdev_ops = &eea_netdev;
+	SET_NETDEV_DEV(netdev, edev->dma_dev);
+
+	enet = netdev_priv(netdev);
+	enet->netdev = netdev;
+	enet->edev = edev;
+	edev->enet = enet;
+
+	return enet;
+}
+
+int eea_net_probe(struct eea_device *edev)
+{
+	struct eea_net *enet;
+	int err = -ENOMEM;
+
+	enet = eea_netdev_alloc(edev, edev->rx_num);
+	if (!enet)
+		return -ENOMEM;
+
+	err = eea_create_adminq(enet, edev->rx_num + edev->tx_num);
+	if (err)
+		goto err_free_netdev;
+
+	eea_adminq_config_host_info(enet);
+
+	err = eea_netdev_init_features(enet->netdev, enet, edev);
+	if (err)
+		goto err_reset_dev;
+
+	netdev_dbg(enet->netdev, "eea probe success.\n");
+
+	/* Queue TX/RX implementation is still in progress. register_netdev is
+	 * deferred until these are completed in subsequent commits.
+	 */
+
+	return 0;
+
+err_reset_dev:
+	eea_device_reset(edev);
+	eea_destroy_adminq(enet);
+
+err_free_netdev:
+	free_netdev(enet->netdev);
+	return err;
+}
+
+void eea_net_remove(struct eea_device *edev)
+{
+	struct net_device *netdev;
+	struct eea_net *enet;
+
+	enet = edev->enet;
+	netdev = enet->netdev;
+
+	netdev_dbg(enet->netdev, "eea removed.\n");
+
+	eea_device_reset(edev);
+
+	eea_destroy_adminq(enet);
+
+	free_netdev(netdev);
+}
+
+void eea_net_shutdown(struct eea_device *edev)
+{
+	struct net_device *netdev;
+	struct eea_net *enet;
+
+	enet = edev->enet;
+	netdev = enet->netdev;
+
+	rtnl_lock();
+
+	netif_device_detach(netdev);
+
+	eea_device_reset(edev);
+
+	eea_destroy_adminq(enet);
+
+	rtnl_unlock();
+}
diff --git a/drivers/net/ethernet/alibaba/eea/eea_net.h b/drivers/net/ethernet/alibaba/eea/eea_net.h
new file mode 100644
index 000000000000..fa0eec8af21b
--- /dev/null
+++ b/drivers/net/ethernet/alibaba/eea/eea_net.h
@@ -0,0 +1,137 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Driver for Alibaba Elastic Ethernet Adapter.
+ *
+ * Copyright (C) 2025 Alibaba Inc.
+ */
+
+#ifndef __EEA_NET_H__
+#define __EEA_NET_H__
+
+#include <linux/ethtool.h>
+#include <linux/netdevice.h>
+
+#include "eea_adminq.h"
+#include "eea_ring.h"
+
+#define EEA_VER_MAJOR		1
+#define EEA_VER_MINOR		0
+#define EEA_VER_SUB_MINOR	0
+
+struct eea_net_tx {
+	struct eea_net *enet;
+
+	struct eea_ring *ering;
+
+	struct eea_tx_meta *meta;
+	struct eea_tx_meta *free;
+
+	struct device *dma_dev;
+
+	u32 index;
+
+	char name[16];
+};
+
+struct eea_rx_meta {
+	struct eea_rx_meta *next;
+
+	struct page *page;
+	dma_addr_t dma;
+	u32 offset;
+	u32 frags;
+
+	struct page *hdr_page;
+	void *hdr_addr;
+	dma_addr_t hdr_dma;
+
+	u32 id;
+
+	u32 truesize;
+	u32 headroom;
+	u32 tailroom;
+
+	u32 len;
+};
+
+struct eea_net_rx_pkt_ctx {
+	u16 idx;
+
+	bool data_valid;
+	bool do_drop;
+
+	struct sk_buff *head_skb;
+};
+
+struct eea_net_rx {
+	struct eea_net *enet;
+
+	struct eea_ring *ering;
+
+	struct eea_rx_meta *meta;
+	struct eea_rx_meta *free;
+
+	struct device *dma_dev;
+
+	u32 index;
+
+	u32 flags;
+
+	u32 headroom;
+
+	struct napi_struct *napi;
+
+	char name[16];
+
+	struct eea_net_rx_pkt_ctx pkt;
+
+	struct page_pool *pp;
+};
+
+struct eea_net_cfg {
+	u32 rx_ring_depth;
+	u32 tx_ring_depth;
+	u32 rx_ring_num;
+	u32 tx_ring_num;
+
+	u8 rx_sq_desc_size;
+	u8 rx_cq_desc_size;
+	u8 tx_sq_desc_size;
+	u8 tx_cq_desc_size;
+
+	u32 split_hdr;
+};
+
+enum {
+	EEA_LINK_ERR_NONE,
+	EEA_LINK_ERR_HA_RESET_DEV,
+	EEA_LINK_ERR_LINK_DOWN,
+};
+
+struct eea_net {
+	struct eea_device *edev;
+	struct net_device *netdev;
+
+	struct eea_aq adminq;
+
+	struct eea_net_tx *tx;
+	struct eea_net_rx **rx;
+
+	struct eea_net_cfg cfg;
+	struct eea_net_cfg cfg_hw;
+
+	u32 link_err;
+
+	bool started;
+
+	u8 duplex;
+	u32 speed;
+
+	u64 hw_ts_offset;
+};
+
+int eea_net_probe(struct eea_device *edev);
+void eea_net_remove(struct eea_device *edev);
+void eea_net_shutdown(struct eea_device *edev);
+
+#endif
diff --git a/drivers/net/ethernet/alibaba/eea/eea_pci.c b/drivers/net/ethernet/alibaba/eea/eea_pci.c
index 65a0ceb73b35..bef0ebd6bb20 100644
--- a/drivers/net/ethernet/alibaba/eea/eea_pci.c
+++ b/drivers/net/ethernet/alibaba/eea/eea_pci.c
@@ -8,6 +8,7 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/iopoll.h>
 
+#include "eea_net.h"
 #include "eea_pci.h"
 
 #define EEA_PCI_DB_OFFSET 4096
@@ -64,7 +65,9 @@ struct eea_pci_device {
 	((void __iomem *)((reg) + offsetof(struct eea_pci_cfg, item)))
 
 #define cfg_write8(reg, item, val) iowrite8(val, cfg_pointer(reg, item))
+#define cfg_write16(reg, item, val) iowrite16(val, cfg_pointer(reg, item))
 #define cfg_write32(reg, item, val) iowrite32(val, cfg_pointer(reg, item))
+#define cfg_write64(reg, item, val) iowrite64_lo_hi(val, cfg_pointer(reg, item))
 
 #define cfg_read8(reg, item) ioread8(cfg_pointer(reg, item))
 #define cfg_read32(reg, item) ioread32(cfg_pointer(reg, item))
@@ -337,6 +340,25 @@ void __iomem *eea_pci_db_addr(struct eea_device *edev, u32 off)
 	return edev->ep_dev->db_base + off;
 }
 
+int eea_pci_active_aq(struct eea_ring *ering, int msix_vec)
+{
+	struct eea_pci_device *ep_dev = ering->edev->ep_dev;
+
+	cfg_write16(ep_dev->reg, aq_size, ering->num);
+	cfg_write16(ep_dev->reg, aq_msix_vector, msix_vec);
+
+	cfg_write64(ep_dev->reg, aq_sq_addr, ering->sq.dma_addr);
+	cfg_write64(ep_dev->reg, aq_cq_addr, ering->cq.dma_addr);
+
+	ering->db = eea_pci_db_addr(ering->edev,
+				    cfg_read32(ep_dev->reg, aq_db_off));
+
+	if (!ering->db)
+		return -EIO;
+
+	return 0;
+}
+
 u64 eea_pci_device_ts(struct eea_device *edev)
 {
 	struct eea_pci_device *ep_dev = edev->ep_dev;
@@ -358,7 +380,9 @@ static int eea_init_device(struct eea_device *edev)
 	if (err)
 		goto err;
 
-	/* do net device probe ... */
+	err = eea_net_probe(edev);
+	if (err)
+		goto err;
 
 	return 0;
 err:
@@ -392,6 +416,9 @@ static void __eea_pci_remove(struct pci_dev *pci_dev)
 {
 	struct eea_pci_device *ep_dev = pci_get_drvdata(pci_dev);
 	struct device *dev = get_device(&ep_dev->pci_dev->dev);
+	struct eea_device *edev = &ep_dev->edev;
+
+	eea_net_remove(edev);
 
 	eea_pci_release_resource(ep_dev);
 
@@ -429,8 +456,6 @@ static void eea_pci_remove(struct pci_dev *pci_dev)
 {
 	struct eea_pci_device *ep_dev = pci_get_drvdata(pci_dev);
 
-	eea_device_reset(&ep_dev->edev);
-
 	__eea_pci_remove(pci_dev);
 
 	pci_set_drvdata(pci_dev, NULL);
@@ -446,9 +471,7 @@ static void eea_pci_shutdown(struct pci_dev *pci_dev)
 
 	ep_dev->shutdown = true;
 
-	/* do net device stop and clear. */
-
-	eea_device_reset(edev);
+	eea_net_shutdown(edev);
 
 	pci_clear_master(pci_dev);
 }
diff --git a/drivers/net/ethernet/alibaba/eea/eea_pci.h b/drivers/net/ethernet/alibaba/eea/eea_pci.h
index 746cce4dd68e..cfd278e2efde 100644
--- a/drivers/net/ethernet/alibaba/eea/eea_pci.h
+++ b/drivers/net/ethernet/alibaba/eea/eea_pci.h
@@ -10,6 +10,8 @@
 
 #include <linux/pci.h>
 
+#include "eea_ring.h"
+
 struct eea_pci_cap {
 	__u8 cap_vndr;
 	__u8 cap_next;
@@ -43,6 +45,7 @@ u16 eea_pci_bdf(struct eea_device *edev);
 
 int eea_device_reset(struct eea_device *dev);
 int eea_pci_set_aq_up(struct eea_device *dev);
+int eea_pci_active_aq(struct eea_ring *ering, int msix_vec);
 
 u64 eea_pci_device_ts(struct eea_device *edev);
 
-- 
2.32.0.3.g01195cf9f


