Return-Path: <netdev+bounces-306703-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id i0ZmBiVqUWpSEQMAu9opvQ
	(envelope-from <netdev+bounces-306703-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 23:54:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA8673F348
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 23:54:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=g1Y12XU0;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306703-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306703-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8332303A241
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 21:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1133CFF79;
	Fri, 10 Jul 2026 21:53:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A9B3CF680;
	Fri, 10 Jul 2026 21:53:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783720406; cv=none; b=XR2FOO+DldMrejqh6Dpux0YtZFNxZQ71jr373Tjf2bu+VK7MOqYfBd4wyP1Kycn5yuGfjQyYBqrytHxggeoLd93IEu8mDVz4QAr9dyTqZQUhh2HFdrQhoNkCWZNXTdFAoIBoi1KfE6s0wmlR74h/zMtuU4jNOY/zBEXevr1qx7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783720406; c=relaxed/simple;
	bh=x7bYhMoi6BvuxqRF6+sjrytgxuwdmN+XqP8Api+ayxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jG2BtOTdNtNQzACjVfzxlUX/xTf5Fy7z0IWrDLT+81iHiMM4P4S+fpKmQwv54yBVm0kpvuxLVtyHL39tJuVT+UpyNV7DqaV8Ad+NW08BbRLpagBdOnxr6hV8UwsHVqWctvY585ADtK8WPFbXNGzvDylkbbrdueMFWwy4MA6A/7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g1Y12XU0; arc=none smtp.client-ip=198.175.65.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783720405; x=1815256405;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x7bYhMoi6BvuxqRF6+sjrytgxuwdmN+XqP8Api+ayxQ=;
  b=g1Y12XU0GpSKDvekw//6YFMpG4c+Bz2dZizNRfKv4+tb1pBk8XNKyn8s
   t5a5xn3IPIGyeN4qAQvFVqUiAnxSWmwEn53Co7MLoP6JkzdmJMejLr2sU
   QfwzqJ260BWbv1UDHa6YynfBenUa49iTVyeL9o+G2xdJ0Qy6PRg/U9wFF
   b78aPXf1AEhJBvypZqTBdU/5ngNBx2OpZdLd0jy4SllrbiajDSecvowON
   +E16m8oNPd6Qwk+BEOn+AP1FMZ75TADWVe8VyYqjs2dmMmjeczoxpItvR
   GMCYere373ajeXOFZ9KJhrgwacswglc/nmq4OUKYdJr+/F/xtoMh8vQki
   A==;
X-CSE-ConnectionGUID: bgRM5v/bQ5WCnISyC1lbwA==
X-CSE-MsgGUID: 1sFOUNOWTKyoSRKPpVYpUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="107220731"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="107220731"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 14:53:22 -0700
X-CSE-ConnectionGUID: pMOFdl70QamvKmy6sUDPXA==
X-CSE-MsgGUID: 1bDEzfISRQSCKGGuGK8wjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="254494622"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa008.jf.intel.com with ESMTP; 10 Jul 2026 14:53:21 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Phani R Burra <phani.r.burra@intel.com>,
	anthony.l.nguyen@intel.com,
	larysa.zaremba@intel.com,
	przemyslaw.kitszel@intel.com,
	aleksander.lobakin@intel.com,
	sridhar.samudrala@intel.com,
	anjali.singhai@intel.com,
	michal.swiatkowski@linux.intel.com,
	maciej.fijalkowski@intel.com,
	emil.s.tantilov@intel.com,
	madhu.chittim@intel.com,
	joshua.a.hay@intel.com,
	jacob.e.keller@intel.com,
	jayaprakash.shanmugam@intel.com,
	jiri@resnulli.us,
	horms@kernel.org,
	corbet@lwn.net,
	richardcochran@gmail.com,
	linux-doc@vger.kernel.org,
	Samuel Salin <Samuel.salin@intel.com>,
	Bharath R <bharath.r@intel.com>
Subject: [PATCH net-next v4 04/15] libie: add control queue support
Date: Fri, 10 Jul 2026 14:53:01 -0700
Message-ID: <20260710215313.1475803-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260710215313.1475803-1-anthony.l.nguyen@intel.com>
References: <20260710215313.1475803-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306703-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:phani.r.burra@intel.com,m:anthony.l.nguyen@intel.com,m:larysa.zaremba@intel.com,m:przemyslaw.kitszel@intel.com,m:aleksander.lobakin@intel.com,m:sridhar.samudrala@intel.com,m:anjali.singhai@intel.com,m:michal.swiatkowski@linux.intel.com,m:maciej.fijalkowski@intel.com,m:emil.s.tantilov@intel.com,m:madhu.chittim@intel.com,m:joshua.a.hay@intel.com,m:jacob.e.keller@intel.com,m:jayaprakash.shanmugam@intel.com,m:jiri@resnulli.us,m:horms@kernel.org,m:corbet@lwn.net,m:richardcochran@gmail.com,m:linux-doc@vger.kernel.org,m:Samuel.salin@intel.com,m:bharath.r@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[intel.com,linux.intel.com,resnulli.us,kernel.org,lwn.net,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,intel.com:from_mime,intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9EA8673F348

From: Phani R Burra <phani.r.burra@intel.com>

Libie will now support control queue setup and configuration APIs. These
are mainly used for mailbox communication between drivers and control
plane.

Make use of the libeth_rx page pool support for managing controlq buffers.

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Phani R Burra <phani.r.burra@intel.com>
Co-developed-by: Victor Raj <victor.raj@intel.com>
Signed-off-by: Victor Raj <victor.raj@intel.com>
Co-developed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Co-developed-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Tested-by: Bharath R <bharath.r@intel.com>
Co-developed-by: Larysa Zaremba <larysa.zaremba@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/libie/Kconfig    |   8 +
 drivers/net/ethernet/intel/libie/Makefile   |   4 +
 drivers/net/ethernet/intel/libie/controlq.c | 616 ++++++++++++++++++++
 include/linux/net/intel/libie/controlq.h    | 249 ++++++++
 4 files changed, 877 insertions(+)
 create mode 100644 drivers/net/ethernet/intel/libie/controlq.c
 create mode 100644 include/linux/net/intel/libie/controlq.h

diff --git a/drivers/net/ethernet/intel/libie/Kconfig b/drivers/net/ethernet/intel/libie/Kconfig
index 500a95c944a8..9c5fdebb6766 100644
--- a/drivers/net/ethernet/intel/libie/Kconfig
+++ b/drivers/net/ethernet/intel/libie/Kconfig
@@ -15,6 +15,14 @@ config LIBIE_ADMINQ
 	  Helper functions used by Intel Ethernet drivers for administration
 	  queue command interface (aka adminq).
 
+config LIBIE_CP
+	tristate
+	select LIBETH
+	select LIBIE_PCI
+	help
+	  Common helper routines to communicate with the device Control Plane
+	  using virtchnl2 or related mailbox protocols.
+
 config LIBIE_FWLOG
 	tristate
 	select LIBIE_ADMINQ
diff --git a/drivers/net/ethernet/intel/libie/Makefile b/drivers/net/ethernet/intel/libie/Makefile
index a28509cb9086..3065aa057798 100644
--- a/drivers/net/ethernet/intel/libie/Makefile
+++ b/drivers/net/ethernet/intel/libie/Makefile
@@ -9,6 +9,10 @@ obj-$(CONFIG_LIBIE_ADMINQ) 	+= libie_adminq.o
 
 libie_adminq-y			:= adminq.o
 
+obj-$(CONFIG_LIBIE_CP)		+= libie_cp.o
+
+libie_cp-y			:= controlq.o
+
 obj-$(CONFIG_LIBIE_FWLOG) 	+= libie_fwlog.o
 
 libie_fwlog-y			:= fwlog.o
diff --git a/drivers/net/ethernet/intel/libie/controlq.c b/drivers/net/ethernet/intel/libie/controlq.c
new file mode 100644
index 000000000000..5d5ccf0dedcc
--- /dev/null
+++ b/drivers/net/ethernet/intel/libie/controlq.c
@@ -0,0 +1,616 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2025 Intel Corporation */
+
+#include <linux/bitfield.h>
+#include <net/libeth/rx.h>
+
+#include <linux/net/intel/libie/controlq.h>
+
+#define LIBIE_CTLQ_DESC_QWORD0(sz)			\
+	(LIBIE_CTLQ_DESC_FLAG_BUF |			\
+	 LIBIE_CTLQ_DESC_FLAG_RD |			\
+	 FIELD_PREP(LIBIE_CTLQ_DESC_DATA_LEN, sz))
+
+/**
+ * libie_ctlq_free_fq - free fill queue resources, including buffers
+ * @ctlq: Rx control queue whose resources need to be freed
+ */
+static void libie_ctlq_free_fq(struct libie_ctlq_info *ctlq)
+{
+	struct libeth_fq fq = {
+		.fqes		= ctlq->rx_fqes,
+		.pp		= ctlq->pp,
+	};
+
+	for (u32 ntc = ctlq->next_to_clean; ntc != ctlq->next_to_post; ) {
+		page_pool_put_full_netmem(fq.pp, fq.fqes[ntc].netmem, false);
+
+		if (++ntc >= ctlq->ring_len)
+			ntc = 0;
+	}
+
+	libeth_rx_fq_destroy(&fq);
+}
+
+/**
+ * libie_ctlq_init_fq - initialize fill queue for an Rx controlq
+ * @ctlq: control queue that needs a Rx buffer allocation
+ *
+ * Return: %0 on success, -%errno on failure
+ */
+static int libie_ctlq_init_fq(struct libie_ctlq_info *ctlq)
+{
+	struct libeth_fq fq = {
+		.count		= ctlq->ring_len,
+		.truesize	= LIBIE_CTLQ_MAX_BUF_LEN,
+		.nid		= NUMA_NO_NODE,
+		.type		= LIBETH_FQE_SHORT,
+		.hsplit		= true,
+		.no_napi	= true,
+	};
+	int err;
+
+	err = libeth_rx_fq_create(&fq, ctlq->dev);
+	if (err)
+		return err;
+
+	ctlq->pp = fq.pp;
+	ctlq->rx_fqes = fq.fqes;
+	ctlq->truesize = fq.truesize;
+
+	return 0;
+}
+
+/**
+ * libie_ctlq_prep_rx_desc - prepare the descriptor with a new address
+ * @desc: descriptor to (re)initialize
+ * @addr: physical address to put into descriptor
+ * @mem_truesize: size of the accessible memory
+ */
+static void libie_ctlq_prep_rx_desc(struct libie_ctlq_desc *desc,
+				    dma_addr_t addr, u32 mem_truesize)
+{
+	u64 qword;
+
+	qword = LIBIE_CTLQ_DESC_QWORD0(mem_truesize);
+	desc->qword0 = cpu_to_le64(qword);
+
+	qword = FIELD_PREP(LIBIE_CTLQ_DESC_DATA_ADDR_HIGH,
+			   upper_32_bits(addr)) |
+		FIELD_PREP(LIBIE_CTLQ_DESC_DATA_ADDR_LOW,
+			   lower_32_bits(addr));
+	desc->qword3 = cpu_to_le64(qword);
+}
+
+/**
+ * libie_ctlq_post_rx_buffs - post buffers to descriptor ring
+ * @ctlq: control queue that requires Rx descriptor ring to be initialized with
+ *	  new Rx buffers
+ *
+ * The caller must make sure that calls to libie_ctlq_post_rx_buffs()
+ * and libie_ctlq_recv() for each queue are either serialized
+ * or used under ctlq->lock.
+ *
+ * Return: %0 on success, -%ENOMEM if any buffer could not be allocated
+ */
+int libie_ctlq_post_rx_buffs(struct libie_ctlq_info *ctlq)
+{
+	u32 ntp = ctlq->next_to_post, ntc = ctlq->next_to_clean, num_to_post;
+	const struct libeth_fq_fp fq = {
+		.pp		= ctlq->pp,
+		.fqes		= ctlq->rx_fqes,
+		.truesize	= ctlq->truesize,
+		.count		= ctlq->ring_len,
+	};
+	int ret = 0;
+
+	num_to_post = (ntc > ntp ? 0 : ctlq->ring_len) + ntc - ntp - 1;
+
+	while (num_to_post--) {
+		dma_addr_t addr;
+
+		ctlq->descs[ntp] = (struct libie_ctlq_desc) {};
+
+		addr = libeth_rx_alloc(&fq, ntp);
+		if (unlikely(addr == DMA_MAPPING_ERROR)) {
+			ret = -ENOMEM;
+			goto post_bufs;
+		}
+
+		libie_ctlq_prep_rx_desc(&ctlq->descs[ntp], addr, fq.truesize);
+
+		if (unlikely(++ntp == ctlq->ring_len))
+			ntp = 0;
+	}
+
+post_bufs:
+	if (likely(ctlq->next_to_post != ntp)) {
+		ctlq->next_to_post = ntp;
+
+		writel(ntp, ctlq->reg.tail);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(libie_ctlq_post_rx_buffs, "LIBIE_CP");
+
+/**
+ * libie_ctlq_free_tx_msgs - Free Tx control queue messages
+ * @ctlq: Tx control queue being destroyed
+ * @num_msgs: number of messages allocated so far
+ */
+static void libie_ctlq_free_tx_msgs(struct libie_ctlq_info *ctlq,
+				    u32 num_msgs)
+{
+	for (u32 i = 0; i < num_msgs; i++)
+		kfree(ctlq->tx_msg[i]);
+
+	kvfree(ctlq->tx_msg);
+}
+
+/**
+ * libie_ctlq_alloc_tx_msgs - Allocate Tx control queue messages
+ * @ctlq: Tx control queue being created
+ *
+ * Return: %0 on success, -%ENOMEM on allocation error
+ */
+static int libie_ctlq_alloc_tx_msgs(struct libie_ctlq_info *ctlq)
+{
+	ctlq->tx_msg = kvzalloc_objs(*ctlq->tx_msg, ctlq->ring_len,
+				     GFP_KERNEL);
+	if (!ctlq->tx_msg)
+		return -ENOMEM;
+
+	for (u32 i = 0; i < ctlq->ring_len; i++) {
+		ctlq->tx_msg[i] = kzalloc_obj(*ctlq->tx_msg[i]);
+		if (!ctlq->tx_msg[i]) {
+			libie_ctlq_free_tx_msgs(ctlq, i);
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * libie_cp_free_dma_mem - Free the previously allocated DMA memory
+ * @dev: device information
+ * @mem: DMA memory information
+ */
+static void libie_cp_free_dma_mem(struct device *dev,
+				  struct libie_cp_dma_mem *mem)
+{
+	dma_free_coherent(dev, mem->size, mem->va, mem->pa);
+	mem->va = NULL;
+}
+
+/**
+ * libie_ctlq_dealloc_ring_res - Free memory allocated for control queue
+ * @ctlq: control queue that requires its ring memory to be freed
+ *
+ * Free the memory used by the ring, buffers and other related structures.
+ */
+static void libie_ctlq_dealloc_ring_res(struct libie_ctlq_info *ctlq)
+{
+	struct libie_cp_dma_mem *dma = &ctlq->ring_mem;
+
+	if (ctlq->type == LIBIE_CTLQ_TYPE_TX)
+		libie_ctlq_free_tx_msgs(ctlq, ctlq->ring_len);
+	else
+		libie_ctlq_free_fq(ctlq);
+
+	libie_cp_free_dma_mem(ctlq->dev, dma);
+}
+
+/**
+ * libie_cp_alloc_dma_mem - Allocate a DMA memory
+ * @dev: device information
+ * @mem: memory for DMA information to be stored
+ * @size: size of the memory to allocate
+ *
+ * Return: virtual address of DMA memory or NULL.
+ */
+static void *libie_cp_alloc_dma_mem(struct device *dev,
+				    struct libie_cp_dma_mem *mem, u32 size)
+{
+	size = ALIGN(size, SZ_4K);
+
+	mem->va = dma_alloc_coherent(dev, size, &mem->pa, GFP_KERNEL);
+	mem->size = size;
+
+	return mem->va;
+}
+
+/**
+ * libie_ctlq_alloc_queue_res - allocate memory for descriptor ring and bufs
+ * @ctlq: control queue that requires its ring resources to be allocated
+ *
+ * Return: %0 on success, -%errno on failure
+ */
+static int libie_ctlq_alloc_queue_res(struct libie_ctlq_info *ctlq)
+{
+	size_t size = array_size(ctlq->ring_len, sizeof(*ctlq->descs));
+	struct libie_cp_dma_mem *dma = &ctlq->ring_mem;
+	int err = -ENOMEM;
+
+	if (!libie_cp_alloc_dma_mem(ctlq->dev, dma, size))
+		return -ENOMEM;
+
+	ctlq->descs = dma->va;
+
+	if (ctlq->type == LIBIE_CTLQ_TYPE_TX) {
+		if (libie_ctlq_alloc_tx_msgs(ctlq))
+			goto free_dma_mem;
+	} else {
+		err = libie_ctlq_init_fq(ctlq);
+		if (err)
+			goto free_dma_mem;
+
+		err = libie_ctlq_post_rx_buffs(ctlq);
+		if (err) {
+			libie_ctlq_free_fq(ctlq);
+			goto free_dma_mem;
+		}
+	}
+
+	return 0;
+
+free_dma_mem:
+	libie_cp_free_dma_mem(ctlq->dev, dma);
+
+	return err;
+}
+
+/**
+ * libie_ctlq_init_regs - Initialize control queue registers
+ * @ctlq: control queue that needs to be initialized
+ *
+ * Initialize registers. The caller is expected to have already initialized the
+ * descriptor ring memory and buffer memory.
+ */
+static void libie_ctlq_init_regs(struct libie_ctlq_info *ctlq)
+{
+	u32 dword;
+
+	if (ctlq->type == LIBIE_CTLQ_TYPE_RX)
+		writel(ctlq->ring_len - 1, ctlq->reg.tail);
+
+	writel(0, ctlq->reg.head);
+	writel(lower_32_bits(ctlq->ring_mem.pa), ctlq->reg.addr_low);
+	writel(upper_32_bits(ctlq->ring_mem.pa), ctlq->reg.addr_high);
+
+	dword = FIELD_PREP(LIBIE_CTLQ_MBX_ATQ_LEN, ctlq->ring_len) |
+		ctlq->reg.len_ena_mask;
+	writel(dword, ctlq->reg.len);
+}
+
+/**
+ * libie_find_ctlq - find the controlq for the given id and type
+ * @ctx: controlq context structure
+ * @type: type of controlq to find
+ * @id: controlq id to find
+ *
+ * Return: control queue info pointer on success, NULL on failure
+ */
+struct libie_ctlq_info *libie_find_ctlq(struct libie_ctlq_ctx *ctx,
+					enum virtchnl2_queue_type type,
+					  int id)
+{
+	struct libie_ctlq_info *cq;
+
+	guard(spinlock)(&ctx->ctlqs_lock);
+
+	list_for_each_entry(cq, &ctx->ctlqs, list)
+		if (cq->qid == id && cq->type == type)
+			return cq;
+
+	return NULL;
+}
+EXPORT_SYMBOL_NS_GPL(libie_find_ctlq, "LIBIE_CP");
+
+/**
+ * libie_ctlq_add - add one control queue
+ * @ctx: controlq context information
+ * @qinfo: information that requires for queue creation
+ *
+ * Allocate and initialize a control queue and add it to the control queue list.
+ * The ctlq parameter will be allocated/initialized and passed back to the
+ * caller if no errors occur.
+ *
+ * Note: libie_ctlq_init must be called prior to any calls to libie_ctlq_add.
+ *
+ * Return: added control queue info pointer on success, error pointer on failure
+ */
+static struct libie_ctlq_info *
+libie_ctlq_add(struct libie_ctlq_ctx *ctx,
+	       const struct libie_ctlq_create_info *qinfo)
+{
+	struct libie_ctlq_info *ctlq;
+
+	if (qinfo->id != LIBIE_CTLQ_MBX_ID)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	/* libie_ctlq_init was not called */
+	scoped_guard(spinlock, &ctx->ctlqs_lock)
+		if (!ctx->ctlqs.next)
+			return ERR_PTR(-EINVAL);
+
+	ctlq = kvzalloc_obj(*ctlq);
+	if (!ctlq)
+		return ERR_PTR(-ENOMEM);
+
+	ctlq->type = qinfo->type;
+	ctlq->qid = qinfo->id;
+	ctlq->ring_len = qinfo->len;
+	ctlq->dev = &ctx->mmio_info.pdev->dev;
+	ctlq->reg = qinfo->reg;
+
+	if (libie_ctlq_alloc_queue_res(ctlq)) {
+		kvfree(ctlq);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	libie_ctlq_init_regs(ctlq);
+
+	spin_lock_init(&ctlq->lock);
+
+	scoped_guard(spinlock, &ctx->ctlqs_lock)
+		list_add(&ctlq->list, &ctx->ctlqs);
+
+	return ctlq;
+}
+
+/**
+ * libie_ctlq_remove - deallocate and remove specified control queue
+ * @ctx: libie context information
+ * @ctlq: specific control queue that needs to be removed
+ */
+static void libie_ctlq_remove(struct libie_ctlq_ctx *ctx,
+			      struct libie_ctlq_info *ctlq)
+{
+	scoped_guard(spinlock, &ctx->ctlqs_lock)
+		list_del(&ctlq->list);
+
+	libie_ctlq_dealloc_ring_res(ctlq);
+	kvfree(ctlq);
+}
+
+/**
+ * libie_ctlq_init - main initialization routine for all control queues
+ * @ctx: libie context information
+ * @qinfo: array of structs containing info for each queue to be initialized
+ * @numq: number of queues to initialize
+ *
+ * This initializes queue list and adds any number and any type of control
+ * queues. This is an all or nothing routine; if one fails, all previously
+ * allocated queues will be destroyed. This must be called prior to using
+ * the individual add/remove APIs.
+ *
+ * Return: %0 on success, -%errno on failure
+ */
+int libie_ctlq_init(struct libie_ctlq_ctx *ctx,
+		    const struct libie_ctlq_create_info *qinfo,
+		     u32 numq)
+{
+	INIT_LIST_HEAD(&ctx->ctlqs);
+	spin_lock_init(&ctx->ctlqs_lock);
+
+	for (u32 i = 0; i < numq; i++) {
+		struct libie_ctlq_info *ctlq;
+
+		ctlq = libie_ctlq_add(ctx, &qinfo[i]);
+		if (IS_ERR(ctlq)) {
+			libie_ctlq_deinit(ctx);
+			return PTR_ERR(ctlq);
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(libie_ctlq_init, "LIBIE_CP");
+
+/**
+ * libie_ctlq_deinit - destroy all control queues
+ * @ctx: libie CP context information
+ */
+void libie_ctlq_deinit(struct libie_ctlq_ctx *ctx)
+{
+	struct libie_ctlq_info *ctlq, *tmp;
+
+	list_for_each_entry_safe(ctlq, tmp, &ctx->ctlqs, list)
+		libie_ctlq_remove(ctx, ctlq);
+}
+EXPORT_SYMBOL_NS_GPL(libie_ctlq_deinit, "LIBIE_CP");
+
+/**
+ * libie_ctlq_tx_desc_from_msg - initialize a Tx descriptor from a message
+ * @desc: descriptor to be initialized
+ * @msg: filled control queue message
+ */
+static void libie_ctlq_tx_desc_from_msg(struct libie_ctlq_desc *desc,
+					const struct libie_ctlq_msg *msg)
+{
+	const struct libie_cp_dma_mem *dma = &msg->send_mem;
+	u64 qword;
+
+	qword = FIELD_PREP(LIBIE_CTLQ_DESC_FLAGS, msg->flags) |
+		FIELD_PREP(LIBIE_CTLQ_DESC_INFRA_OPCODE, msg->opcode) |
+		FIELD_PREP(LIBIE_CTLQ_DESC_PFID_VFID, msg->func_id);
+	desc->qword0 = cpu_to_le64(qword);
+
+	qword = FIELD_PREP(LIBIE_CTLQ_DESC_VIRTCHNL_OPCODE,
+			   msg->chnl_opcode) |
+		FIELD_PREP(LIBIE_CTLQ_DESC_VIRTCHNL_MSG_RET_VAL,
+			   msg->chnl_retval);
+	desc->qword1 = cpu_to_le64(qword);
+
+	qword = FIELD_PREP(LIBIE_CTLQ_DESC_MSG_PARAM0, msg->param0) |
+		FIELD_PREP(LIBIE_CTLQ_DESC_SW_COOKIE,
+			   msg->sw_cookie) |
+		FIELD_PREP(LIBIE_CTLQ_DESC_VIRTCHNL_FLAGS,
+			   msg->virt_flags);
+	desc->qword2 = cpu_to_le64(qword);
+
+	if (likely(msg->data_len)) {
+		desc->qword0 |=
+			cpu_to_le64(LIBIE_CTLQ_DESC_QWORD0(msg->data_len));
+		qword = FIELD_PREP(LIBIE_CTLQ_DESC_DATA_ADDR_HIGH,
+				   upper_32_bits(dma->pa)) |
+			FIELD_PREP(LIBIE_CTLQ_DESC_DATA_ADDR_LOW,
+				   lower_32_bits(dma->pa));
+	} else {
+		qword = msg->addr_param;
+	}
+
+	desc->qword3 = cpu_to_le64(qword);
+}
+
+/**
+ * libie_ctlq_send_desc_avail - get number of free descriptors on a Tx ctlq
+ * @ctlq: specific control queue which is going be used for sending messages
+ *
+ * The caller must hold ctlq->lock. Any dependent sending must be done
+ * in the same critical section.
+ *
+ * Return: number of available descriptors/messages on a given control queue.
+ */
+u32 libie_ctlq_send_desc_avail(const struct libie_ctlq_info *ctlq)
+{
+	u32 ntu = ctlq->next_to_use, ntc = ctlq->next_to_clean;
+
+	return (ntc > ntu ? 0 : ctlq->ring_len) + ntc - ntu - 1;
+}
+EXPORT_SYMBOL_NS_GPL(libie_ctlq_send_desc_avail, "LIBIE_CP");
+
+/**
+ * libie_ctlq_send - send a message to Control Plane or Peer
+ * @ctlq: specific control queue which is used for sending a message
+ * @num_q_msg: number of messages present to send on @ctlq,
+ *	       positive and no greater than the number of available descriptors
+ *
+ * The caller must fill in @num_q_msg Tx messages staring at ntu beforehand.
+ *
+ * The caller must hold ctlq->lock. The intended pattern is to first check
+ * the number of descriptors available, then fill in the messages and perform
+ * send within a single critical section.
+ *
+ * Return: %0 on success, -%errno on failure.
+ */
+void libie_ctlq_send(struct libie_ctlq_info *ctlq, u32 num_q_msg)
+{
+	u32 ntu = ctlq->next_to_use;
+
+	for (int i = 0; i < num_q_msg; i++) {
+		struct libie_ctlq_msg *msg = ctlq->tx_msg[ntu];
+		struct libie_ctlq_desc *desc;
+
+		desc = &ctlq->descs[ntu];
+		libie_ctlq_tx_desc_from_msg(desc, msg);
+
+		if (unlikely(++ntu == ctlq->ring_len))
+			ntu = 0;
+	}
+	writel(ntu, ctlq->reg.tail);
+	ctlq->next_to_use = ntu;
+}
+EXPORT_SYMBOL_NS_GPL(libie_ctlq_send, "LIBIE_CP");
+
+/**
+ * libie_ctlq_fill_rx_msg - fill in a message from Rx descriptor and buffer
+ * @msg: message to be filled in
+ * @desc: received descriptor
+ * @rx_buf: fill queue buffer associated with the descriptor
+ */
+static void libie_ctlq_fill_rx_msg(struct libie_ctlq_msg *msg,
+				   const struct libie_ctlq_desc *desc,
+				    struct libeth_fqe *rx_buf)
+{
+	u64 qword = le64_to_cpu(desc->qword0);
+
+	msg->flags = FIELD_GET(LIBIE_CTLQ_DESC_FLAGS, qword);
+	msg->opcode = FIELD_GET(LIBIE_CTLQ_DESC_INFRA_OPCODE, qword);
+	msg->data_len = FIELD_GET(LIBIE_CTLQ_DESC_DATA_LEN, qword);
+	msg->hw_retval = FIELD_GET(LIBIE_CTLQ_DESC_HW_RETVAL, qword);
+
+	qword = le64_to_cpu(desc->qword1);
+	msg->chnl_opcode =
+		FIELD_GET(LIBIE_CTLQ_DESC_VIRTCHNL_OPCODE, qword);
+	msg->chnl_retval =
+		FIELD_GET(LIBIE_CTLQ_DESC_VIRTCHNL_MSG_RET_VAL, qword);
+
+	qword = le64_to_cpu(desc->qword2);
+	msg->param0 =
+		FIELD_GET(LIBIE_CTLQ_DESC_MSG_PARAM0, qword);
+	msg->sw_cookie =
+		FIELD_GET(LIBIE_CTLQ_DESC_SW_COOKIE, qword);
+	msg->virt_flags =
+		FIELD_GET(LIBIE_CTLQ_DESC_VIRTCHNL_FLAGS, qword);
+
+	if (likely(msg->data_len)) {
+		if (unlikely(msg->data_len > LIBIE_CTLQ_MAX_BUF_LEN)) {
+			msg->data_len = LIBIE_CTLQ_MAX_BUF_LEN;
+			msg->chnl_retval = U32_MAX;
+		}
+		msg->recv_mem = (struct kvec) {
+			.iov_base = netmem_address(rx_buf->netmem) +
+				    rx_buf->offset,
+			.iov_len = msg->data_len,
+		};
+		libeth_rx_sync_for_cpu(rx_buf, msg->data_len);
+	} else {
+		msg->recv_mem = (struct kvec) {};
+		msg->addr_param = le64_to_cpu(desc->qword3);
+		page_pool_put_full_netmem(netmem_get_pp(rx_buf->netmem),
+					  rx_buf->netmem, false);
+	}
+}
+
+/**
+ * libie_ctlq_recv - receive control queue message call back
+ * @ctlq: control queue that needs to processed for receive
+ * @msg: array of received control queue messages on this q;
+ * needs to be pre-allocated by caller for as many messages as requested
+ * @num_q_msg: number of messages that can be stored in msg buffer
+ *
+ * Called by interrupt handler or polling mechanism. Caller is expected
+ * to free buffers.
+ *
+ * The caller must make sure that calls to libie_ctlq_post_rx_buffs()
+ * and libie_ctlq_recv() for each queue are either serialized
+ * or used under ctlq->lock.
+ *
+ * Return: number of messages received
+ */
+u32 libie_ctlq_recv(struct libie_ctlq_info *ctlq, struct libie_ctlq_msg *msg,
+		    u32 num_q_msg)
+{
+	u32 ntc, i;
+
+	ntc = ctlq->next_to_clean;
+
+	for (i = 0; i < num_q_msg; i++) {
+		const struct libie_ctlq_desc *desc = &ctlq->descs[ntc];
+		struct libeth_fqe *rx_buf = &ctlq->rx_fqes[ntc];
+		u64 qword;
+
+		qword = le64_to_cpu(desc->qword0);
+		if (!FIELD_GET(LIBIE_CTLQ_DESC_FLAG_DD, qword))
+			break;
+
+		dma_rmb();
+
+		libie_ctlq_fill_rx_msg(&msg[i], desc, rx_buf);
+
+		if (unlikely(++ntc == ctlq->ring_len))
+			ntc = 0;
+	}
+
+	ctlq->next_to_clean = ntc;
+
+	return i;
+}
+EXPORT_SYMBOL_NS_GPL(libie_ctlq_recv, "LIBIE_CP");
+
+MODULE_DESCRIPTION("Control Plane communication API");
+MODULE_IMPORT_NS("LIBETH");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/net/intel/libie/controlq.h b/include/linux/net/intel/libie/controlq.h
new file mode 100644
index 000000000000..a176a0d2ba33
--- /dev/null
+++ b/include/linux/net/intel/libie/controlq.h
@@ -0,0 +1,249 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) 2025 Intel Corporation */
+
+#ifndef __LIBIE_CONTROLQ_H
+#define __LIBIE_CONTROLQ_H
+
+#include <net/libeth/rx.h>
+
+#include <linux/net/intel/libie/pci.h>
+#include <linux/net/intel/virtchnl2.h>
+
+/* Default mailbox control queue */
+#define LIBIE_CTLQ_MBX_ID			-1
+#define LIBIE_CTLQ_MAX_BUF_LEN			SZ_4K
+
+#define LIBIE_CTLQ_TYPE_TX			0
+#define LIBIE_CTLQ_TYPE_RX			1
+
+/* Opcode used to send controlq message to the control plane */
+#define LIBIE_CTLQ_SEND_MSG_TO_CP		0x801
+#define LIBIE_CTLQ_SEND_MSG_TO_PEER		0x804
+
+/**
+ * struct libie_ctlq_ctx - contains controlq info and MMIO region info
+ * @mmio_info: MMIO region info structure
+ * @ctlqs: list that stores all the control queues
+ * @ctlqs_lock: lock for control queue list
+ */
+struct libie_ctlq_ctx {
+	struct libie_mmio_info	mmio_info;
+	struct list_head	ctlqs;
+	spinlock_t		ctlqs_lock;	/* protects the ctlqs list */
+};
+
+/**
+ * struct libie_ctlq_reg - structure representing virtual addresses of the
+ *			    controlq registers and masks
+ * @head: controlq head register address
+ * @tail: controlq tail register address
+ * @len: register address to write controlq length and enable bit
+ * @addr_high: register address to write the upper 32b of ring physical address
+ * @addr_low: register address to write the lower 32b of ring physical address
+ * @len_mask: mask to read the controlq length
+ * @len_ena_mask: mask to write the controlq enable bit
+ * @head_mask: mask to read the head value
+ */
+struct libie_ctlq_reg {
+	void __iomem	*head;
+	void __iomem	*tail;
+	void __iomem	*len;
+	void __iomem	*addr_high;
+	void __iomem	*addr_low;
+	u32		len_mask;
+	u32		len_ena_mask;
+	u32		head_mask;
+};
+
+/**
+ * struct libie_cp_dma_mem - structure for DMA memory
+ * @va: virtual address
+ * @pa: physical address
+ * @size: memory size
+ */
+struct libie_cp_dma_mem {
+	void		*va;
+	dma_addr_t	pa;
+	size_t		size;
+};
+
+/**
+ * struct libie_ctlq_msg - control queue message data
+ * @flags: refer to 'Flags sub-structure' definitions
+ * @opcode: infrastructure message opcode
+ * @data_len: size of the payload
+ * @func_id: queue id for the secondary mailbox queue, 0 for default mailbox
+ * @hw_retval: execution status from the HW
+ * @chnl_opcode: virtchnl message opcode
+ * @chnl_retval: virtchnl return value
+ * @param0: indirect message raw parameter0
+ * @sw_cookie: used to verify the response of the sent virtchnl message
+ * @virt_flags: virtchnl capability flags
+ * @addr_param: additional parameters in place of the address, given no buffer
+ * @recv_mem: virtual address and size of the buffer that contains
+ *	      the indirect response
+ * @send_mem: physical and virtual address of the DMA buffer,
+ *	      used for sending
+ */
+struct libie_ctlq_msg {
+	u16			flags;
+	u16			opcode;
+	u16			data_len;
+	union {
+		u16		func_id;
+		u16		hw_retval;
+	};
+	u32			chnl_opcode;
+	u32			chnl_retval;
+	u32			param0;
+	u16			sw_cookie;
+	u16			virt_flags;
+	u64			addr_param;
+	union {
+		struct kvec	recv_mem;
+		struct	libie_cp_dma_mem send_mem;
+	};
+};
+
+/**
+ * struct libie_ctlq_create_info - control queue create information
+ * @type: control queue type (Rx or Tx)
+ * @id: queue offset passed as input, -1 for default mailbox
+ * @reg: registers accessed by control queue
+ * @len: controlq length
+ */
+struct libie_ctlq_create_info {
+	enum virtchnl2_queue_type	type;
+	int				id;
+	struct libie_ctlq_reg		reg;
+	u16				len;
+};
+
+/**
+ * struct libie_ctlq_info - control queue information
+ * @list: used to add a controlq to the list of queues in libie_ctlq_ctx
+ * @type: control queue type
+ * @qid: queue identifier
+ * @lock: control queue lock
+ * @ring_mem: descriptor ring DMA memory
+ * @descs: array of descriptors
+ * @rx_fqes: array of controlq Rx buffers
+ * @tx_msg: Tx messages sent to hardware
+ * @reg: registers used by control queue
+ * @dev: device that owns this control queue
+ * @pp: page pool for controlq Rx buffers
+ * @truesize: size to allocate per buffer
+ * @next_to_use: next available slot to send buffer
+ * @next_to_clean: next descriptor to be cleaned
+ * @next_to_post: next available slot to post buffers to after receive
+ * @ring_len: length of the descriptor ring
+ */
+struct libie_ctlq_info {
+	struct list_head		list;
+	enum virtchnl2_queue_type	type;
+	int				qid;
+	spinlock_t			lock;	/* for concurrent processing */
+	struct libie_cp_dma_mem	ring_mem;
+	struct libie_ctlq_desc		*descs;
+	union {
+		struct libeth_fqe		*rx_fqes;
+		struct libie_ctlq_msg		**tx_msg;
+	};
+	struct libie_ctlq_reg		reg;
+	struct device			*dev;
+	struct page_pool		*pp;
+	u32				truesize;
+	u32				next_to_clean;
+	union {
+		u32			next_to_use;
+		u32			next_to_post;
+	};
+	u32				ring_len;
+};
+
+#define LIBIE_CTLQ_MBX_ATQ_LEN			GENMASK(9, 0)
+
+/* Flags sub-structure
+ * |0  |1  |2  |3  |4  |5  |6  |7  |8  |9  |10 |11 |12 |13 |14 |15 |
+ * |DD |CMP|ERR|  * RSV *  |FTYPE  | *RSV* |RD |VFC|BUF|  HOST_ID  |
+ */
+ /* libie controlq descriptor qword0 details */
+#define LIBIE_CTLQ_DESC_FLAG_DD		BIT(0)
+#define LIBIE_CTLQ_DESC_FLAG_CMP		BIT(1)
+#define LIBIE_CTLQ_DESC_FLAG_ERR		BIT(2)
+#define LIBIE_CTLQ_DESC_FLAG_FTYPE_VM		BIT(6)
+#define LIBIE_CTLQ_DESC_FLAG_FTYPE_PF		BIT(7)
+#define LIBIE_CTLQ_DESC_FLAG_FTYPE		GENMASK(7, 6)
+#define LIBIE_CTLQ_DESC_FLAG_RD		BIT(10)
+#define LIBIE_CTLQ_DESC_FLAG_VFC		BIT(11)
+#define LIBIE_CTLQ_DESC_FLAG_BUF		BIT(12)
+#define LIBIE_CTLQ_DESC_FLAG_HOST_ID		GENMASK(15, 13)
+
+#define LIBIE_CTLQ_DESC_FLAGS			GENMASK(15, 0)
+#define LIBIE_CTLQ_DESC_INFRA_OPCODE		GENMASK_ULL(31, 16)
+#define LIBIE_CTLQ_DESC_DATA_LEN		GENMASK_ULL(47, 32)
+#define LIBIE_CTLQ_DESC_HW_RETVAL		GENMASK_ULL(63, 48)
+
+#define LIBIE_CTLQ_DESC_PFID_VFID		GENMASK_ULL(63, 48)
+
+/* libie controlq descriptor qword1 details */
+#define LIBIE_CTLQ_DESC_VIRTCHNL_OPCODE	GENMASK(27, 0)
+#define LIBIE_CTLQ_DESC_VIRTCHNL_DESC_TYPE	GENMASK_ULL(31, 28)
+#define LIBIE_CTLQ_DESC_VIRTCHNL_MSG_RET_VAL	GENMASK_ULL(63, 32)
+
+/* libie controlq descriptor qword2 details */
+#define LIBIE_CTLQ_DESC_MSG_PARAM0		GENMASK_ULL(31, 0)
+#define LIBIE_CTLQ_DESC_SW_COOKIE		GENMASK_ULL(47, 32)
+#define LIBIE_CTLQ_DESC_VIRTCHNL_FLAGS		GENMASK_ULL(63, 48)
+
+/* libie controlq descriptor qword3 details */
+#define LIBIE_CTLQ_DESC_DATA_ADDR_HIGH		GENMASK_ULL(31, 0)
+#define LIBIE_CTLQ_DESC_DATA_ADDR_LOW		GENMASK_ULL(63, 32)
+
+/**
+ * struct libie_ctlq_desc - control queue descriptor format
+ * @qword0: flags, message opcode, data length etc
+ * @qword1: virtchnl opcode, descriptor type and return value
+ * @qword2: indirect message parameters
+ * @qword3: indirect message buffer address
+ */
+struct libie_ctlq_desc {
+	__le64			qword0;
+	__le64			qword1;
+	__le64			qword2;
+	__le64			qword3;
+};
+
+/**
+ * libie_ctlq_release_rx_buf - Release Rx buffer for a specific control queue
+ * @rx_buf: Rx buffer to be freed
+ *
+ * Driver uses this function to post back the Rx buffer after the usage.
+ */
+static inline void libie_ctlq_release_rx_buf(struct kvec *rx_buf)
+{
+	netmem_ref netmem;
+
+	if (!rx_buf->iov_base)
+		return;
+
+	netmem = virt_to_netmem(rx_buf->iov_base);
+	page_pool_put_full_netmem(netmem_get_pp(netmem), netmem, false);
+}
+
+int libie_ctlq_init(struct libie_ctlq_ctx *ctx,
+		    const struct libie_ctlq_create_info *qinfo,  u32 numq);
+void libie_ctlq_deinit(struct libie_ctlq_ctx *ctx);
+
+struct libie_ctlq_info *libie_find_ctlq(struct libie_ctlq_ctx *ctx,
+					enum virtchnl2_queue_type type,
+					  int id);
+
+u32 libie_ctlq_send_desc_avail(const struct libie_ctlq_info *ctlq);
+void libie_ctlq_send(struct libie_ctlq_info *ctlq, u32 num_q_msg);
+u32 libie_ctlq_recv(struct libie_ctlq_info *ctlq, struct libie_ctlq_msg *msg,
+		    u32 num_q_msg);
+
+int libie_ctlq_post_rx_buffs(struct libie_ctlq_info *ctlq);
+
+#endif /* __LIBIE_CONTROLQ_H */
-- 
2.47.1


