Return-Path: <netdev+bounces-296619-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XIxxJWraJmp3lwIAu9opvQ
	(envelope-from <netdev+bounces-296619-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 17:06:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7782657CF5
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 17:06:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=QSATk8po;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296619-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296619-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3017B3259C86
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 14:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F113ED10F;
	Mon,  8 Jun 2026 14:42:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF023EBF18;
	Mon,  8 Jun 2026 14:42:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780929723; cv=none; b=E3Ih00j3R1BGXf5Rfwt+oGcgdCT4DbdxE+WZ34xbNIhDE8sK5lILRchjhZTT0m+yniuyGFJ6PwrpbSQZFqd7REpNnZwpP9gDXKbj/+EaIWv09tv5BKOSJJcL3kS44jm7DpzjomaNcV50eOj5Khkk3F3wkkeeK0BSCpb/EQLPePY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780929723; c=relaxed/simple;
	bh=m8/w/U13MclaCYbwlsS0Ekm/1rYCyEAYjCXsu8506IY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OxlsnG5NV/bcDvZD40Enyz3SbdjybjOERr+WrI7RkJhzRJfsdKQHNTy/ee3ebaolJLztATTYC/qhBqI8qvZToy20nLxHDADuJD3sYcMFZ+5wNtxjD2F3ZmiI1zA7bSCB6myzFXWFrMZ08017SApCiMZv/MOvenmjJyH/fiVZQo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QSATk8po; arc=none smtp.client-ip=198.175.65.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780929722; x=1812465722;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m8/w/U13MclaCYbwlsS0Ekm/1rYCyEAYjCXsu8506IY=;
  b=QSATk8poTdi7C3a+PaSvE8TzGF4aT5XUvyE/kBLSqTN2se0O7uTNLKsx
   /ChaurZNmqCbpmG4Brjz4gpu6i91x430mLDywaaF4mFdw86YiRcIviOhD
   HBJ8vL1aZEJEAVJYWkqmC3SDoV16vNxPXx5pLzJ2LUJRvve7L8y1/vBVm
   3iphSAOQPg0z2xQF2kNG7tfjoCFKdG64DdSmMw+63OK8zgy7s6usVdihB
   dxljh1B14dU4WqGVZkLPlROd4SirntUH0cCXbamEn0vwUd+Nweu+kSsos
   JK8B3xYXQiuGhxKlbyIHSANCmLd7JygJzMXOrU9O8cgRip7K3Igj0kd05
   g==;
X-CSE-ConnectionGUID: jE8WAvvhSZO0y2Cs62bwQw==
X-CSE-MsgGUID: vlPsyvzgRcK1S8PoftnwKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="81642058"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="81642058"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 07:42:02 -0700
X-CSE-ConnectionGUID: hKkiQUZlShidtARTWI7ywQ==
X-CSE-MsgGUID: nmyj0EevTLaV1XPHvfLOwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="249489768"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa003.jf.intel.com with ESMTP; 08 Jun 2026 07:41:57 -0700
Received: from mglak.igk.intel.com (mglak.igk.intel.com [10.237.112.146])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 3FCDE2878C;
	Mon,  8 Jun 2026 15:41:54 +0100 (IST)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: aleksander.lobakin@intel.com,
	sridhar.samudrala@intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
	Emil Tantilov <emil.s.tantilov@intel.com>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Josh Hay <joshua.a.hay@intel.com>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>,
	jayaprakash.shanmugam@intel.com,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Richard Cochran <richardcochran@gmail.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bharath R <Bharath.r@intel.com>
Subject: [PATCH iwl-next v8 14/15] ixd: add the core initialization
Date: Mon,  8 Jun 2026 16:41:19 +0200
Message-ID: <20260608144127.2751230-15-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260608144127.2751230-1-larysa.zaremba@intel.com>
References: <20260608144127.2751230-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296619-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[26];
	FREEMAIL_CC(0.00)[intel.com,linux.intel.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,gmail.com,lunn.ch,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:intel-wired-lan@lists.osuosl.org,m:anthony.l.nguyen@intel.com,m:aleksander.lobakin@intel.com,m:sridhar.samudrala@intel.com,m:michal.swiatkowski@linux.intel.com,m:larysa.zaremba@intel.com,m:maciej.fijalkowski@intel.com,m:emil.s.tantilov@intel.com,m:madhu.chittim@intel.com,m:joshua.a.hay@intel.com,m:jacob.e.keller@intel.com,m:jayaprakash.shanmugam@intel.com,m:jiri@resnulli.us,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:corbet@lwn.net,m:richardcochran@gmail.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:Bharath.r@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mbx_task.work:url,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E7782657CF5

As the mailbox is setup, initialize the core. This makes use of the send
and receive mailbox message framework for virtchnl communication between
the driver and device Control Plane (CP).

To start with, driver confirms the virtchnl version with the CP. Once that
is done, it requests and gets the required capabilities and resources
needed such as max vectors, queues, vports etc.

Use a unified way of handling the virtchnl messages, where a single
function handles all related memory management and the caller only provides
the callbacks to fill the send buffer and to handle the response.

Place generic control queue message handling separately to facilitate the
addition of protocols other than virtchannel in the future.

Co-developed-by: Amritha Nambiar <amritha.nambiar@intel.com>
Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Tested-by: Bharath R <Bharath.r@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/ixd/Makefile       |   2 +
 drivers/net/ethernet/intel/ixd/ixd.h          |  10 +
 drivers/net/ethernet/intel/ixd/ixd_ctlq.c     | 147 +++++++++++++++
 drivers/net/ethernet/intel/ixd/ixd_ctlq.h     |  34 ++++
 drivers/net/ethernet/intel/ixd/ixd_lib.c      |  29 ++-
 drivers/net/ethernet/intel/ixd/ixd_main.c     |   3 +
 drivers/net/ethernet/intel/ixd/ixd_virtchnl.c | 178 ++++++++++++++++++
 drivers/net/ethernet/intel/ixd/ixd_virtchnl.h |  12 ++
 8 files changed, 414 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd_ctlq.c
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd_ctlq.h
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd_virtchnl.c
 create mode 100644 drivers/net/ethernet/intel/ixd/ixd_virtchnl.h

diff --git a/drivers/net/ethernet/intel/ixd/Makefile b/drivers/net/ethernet/intel/ixd/Makefile
index 164b2c86952f..90abf231fb16 100644
--- a/drivers/net/ethernet/intel/ixd/Makefile
+++ b/drivers/net/ethernet/intel/ixd/Makefile
@@ -6,5 +6,7 @@
 obj-$(CONFIG_IXD) += ixd.o
 
 ixd-y := ixd_main.o
+ixd-y += ixd_ctlq.o
 ixd-y += ixd_dev.o
 ixd-y += ixd_lib.o
+ixd-y += ixd_virtchnl.o
diff --git a/drivers/net/ethernet/intel/ixd/ixd.h b/drivers/net/ethernet/intel/ixd/ixd.h
index c86c2b05c5b4..8e3cd5bc5a84 100644
--- a/drivers/net/ethernet/intel/ixd/ixd.h
+++ b/drivers/net/ethernet/intel/ixd/ixd.h
@@ -10,19 +10,29 @@
  * struct ixd_adapter - Data structure representing a CPF
  * @cp_ctx: Control plane communication context
  * @init_task: Delayed initialization after reset
+ * @mbx_task: Control queue Rx handling
  * @xnm: virtchnl transaction manager
  * @asq: Send control queue info
  * @arq: Receive control queue info
+ * @vc_ver: Negotiated virtchnl version
+ * @caps: Negotiated virtchnl capabilities
  */
 struct ixd_adapter {
 	struct libie_ctlq_ctx cp_ctx;
 	struct {
 		struct delayed_work init_work;
 		u8 reset_retries;
+		u8 vc_retries;
 	} init_task;
+	struct delayed_work mbx_task;
 	struct libie_ctlq_xn_manager *xnm;
 	struct libie_ctlq_info *asq;
 	struct libie_ctlq_info *arq;
+	struct {
+		u32 major;
+		u32 minor;
+	} vc_ver;
+	struct virtchnl2_get_capabilities caps;
 };
 
 /**
diff --git a/drivers/net/ethernet/intel/ixd/ixd_ctlq.c b/drivers/net/ethernet/intel/ixd/ixd_ctlq.c
new file mode 100644
index 000000000000..c36ab8390c4c
--- /dev/null
+++ b/drivers/net/ethernet/intel/ixd/ixd_ctlq.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2025 Intel Corporation */
+
+#include "ixd.h"
+#include "ixd_ctlq.h"
+#include "ixd_virtchnl.h"
+
+/**
+ * ixd_ctlq_clean_sq - Clean the send control queue after sending the message
+ * @adapter: The adapter that sent the messages
+ * @force: Clean regardless of send status
+ *
+ * Free the libie send resources after sending the message and handling
+ * the response.
+ */
+void ixd_ctlq_clean_sq(struct ixd_adapter *adapter, bool force)
+{
+	struct libie_ctlq_xn_clean_params params = {
+		.ctlq = adapter->asq,
+		.ctx = &adapter->cp_ctx,
+		.force = force,
+		.num_msgs = adapter->asq->ring_len,
+		.rel_tx_buf = kfree,
+	};
+
+	libie_ctlq_xn_send_clean(&params);
+}
+
+/**
+ * ixd_ctlq_init_sparams - Initialize control queue send parameters
+ * @adapter: The adapter with initialized mailbox
+ * @sparams: Parameters to initialize
+ * @msg_buf: DMA-mappable pointer to the message being sent
+ * @msg_size: Message size
+ */
+static void ixd_ctlq_init_sparams(struct ixd_adapter *adapter,
+				  struct libie_ctlq_xn_send_params *sparams,
+				  void *msg_buf, size_t msg_size)
+{
+	*sparams = (struct libie_ctlq_xn_send_params) {
+		.rel_tx_buf = kfree,
+		.xnm = adapter->xnm,
+		.ctlq = adapter->asq,
+		.timeout_ms = IXD_CTLQ_TIMEOUT,
+		.send_buf = (struct kvec) {
+			.iov_base = msg_buf,
+			.iov_len = msg_size,
+		},
+	};
+}
+
+/**
+ * ixd_ctlq_do_req - Perform a standard virtchnl request
+ * @adapter: The adapter with initialized mailbox
+ * @req: virtchnl request description
+ *
+ * Return: %0 if a message was sent and received a response
+ * that was successfully handled by the custom callback,
+ * negative error otherwise.
+ */
+int ixd_ctlq_do_req(struct ixd_adapter *adapter, const struct ixd_ctlq_req *req)
+{
+	u8 onstack_send_buff[LIBIE_CP_TX_COPYBREAK] __aligned_largest = {};
+	struct libie_ctlq_xn_send_params send_params = {};
+	struct kvec *recv_mem;
+	void *send_buff;
+	int err;
+
+	send_buff = libie_cp_can_send_onstack(req->send_size) ?
+		    &onstack_send_buff : kzalloc(req->send_size, GFP_KERNEL);
+	if (!send_buff)
+		return -ENOMEM;
+
+	ixd_ctlq_init_sparams(adapter, &send_params, send_buff,
+			      req->send_size);
+
+	send_params.chnl_opcode = req->opcode;
+
+	if (req->send_buff_init)
+		req->send_buff_init(adapter, send_buff, req->ctx);
+
+	ixd_ctlq_clean_sq(adapter, false);
+	err = libie_ctlq_xn_send(&send_params);
+	if (err)
+		return err;
+
+	recv_mem = &send_params.recv_mem;
+	if (req->recv_process)
+		err = req->recv_process(adapter, recv_mem->iov_base,
+					recv_mem->iov_len, req->ctx);
+
+	libie_ctlq_release_rx_buf(recv_mem);
+
+	return err;
+}
+
+/**
+ * ixd_ctlq_handle_msg - Default control queue message handler
+ * @ctx: Control plane communication context
+ * @msg: Message received
+ */
+static void ixd_ctlq_handle_msg(struct libie_ctlq_ctx *ctx,
+				struct libie_ctlq_msg *msg)
+{
+	struct ixd_adapter *adapter = pci_get_drvdata(ctx->mmio_info.pdev);
+
+	if (ixd_vc_can_handle_msg(msg))
+		ixd_vc_recv_event_msg(adapter, msg);
+	else
+		dev_dbg_ratelimited(ixd_to_dev(adapter),
+				    "Received an unsupported opcode 0x%x from the CP\n",
+				    msg->chnl_opcode);
+
+	libie_ctlq_release_rx_buf(&msg->recv_mem);
+}
+
+/**
+ * ixd_ctlq_recv_mb_msg - Receive a potential message over mailbox periodically
+ * @adapter: The adapter with initialized mailbox
+ */
+static void ixd_ctlq_recv_mb_msg(struct ixd_adapter *adapter)
+{
+	struct libie_ctlq_xn_recv_params xn_params = {
+		.xnm = adapter->xnm,
+		.ctlq = adapter->arq,
+		.ctlq_msg_handler = ixd_ctlq_handle_msg,
+		.budget = LIBIE_CTLQ_MAX_XN_ENTRIES,
+	};
+
+	libie_ctlq_xn_recv(&xn_params);
+}
+
+/**
+ * ixd_ctlq_rx_task - Periodically check for mailbox responses and events
+ * @work: work handle
+ */
+void ixd_ctlq_rx_task(struct work_struct *work)
+{
+	struct ixd_adapter *adapter;
+
+	adapter = container_of(work, struct ixd_adapter, mbx_task.work);
+
+	queue_delayed_work(system_unbound_wq, &adapter->mbx_task,
+			   msecs_to_jiffies(300));
+
+	ixd_ctlq_recv_mb_msg(adapter);
+}
diff --git a/drivers/net/ethernet/intel/ixd/ixd_ctlq.h b/drivers/net/ethernet/intel/ixd/ixd_ctlq.h
new file mode 100644
index 000000000000..8839f9f8f6d5
--- /dev/null
+++ b/drivers/net/ethernet/intel/ixd/ixd_ctlq.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) 2025 Intel Corporation */
+
+#ifndef _IXD_CTLQ_H_
+#define _IXD_CTLQ_H_
+
+#include <linux/net/intel/virtchnl2.h>
+
+#define IXD_CTLQ_TIMEOUT 2000
+
+/**
+ * struct ixd_ctlq_req - Standard virtchnl request description
+ * @opcode: protocol opcode, only virtchnl2 is needed for now
+ * @send_size: required length of the send buffer
+ * @send_buff_init: function to initialize the allocated send buffer
+ * @recv_process: function to handle the CP response
+ * @ctx: additional context for callbacks
+ */
+struct ixd_ctlq_req {
+	enum virtchnl2_op opcode;
+	size_t send_size;
+	void (*send_buff_init)(struct ixd_adapter *adapter, void *send_buff,
+			       void *ctx);
+	int (*recv_process)(struct ixd_adapter *adapter, void *recv_buff,
+			    size_t recv_size, void *ctx);
+	void *ctx;
+};
+
+void ixd_ctlq_clean_sq(struct ixd_adapter *adapter, bool force);
+int ixd_ctlq_do_req(struct ixd_adapter *adapter,
+		    const struct ixd_ctlq_req *req);
+void ixd_ctlq_rx_task(struct work_struct *work);
+
+#endif /* _IXD_CTLQ_H_ */
diff --git a/drivers/net/ethernet/intel/ixd/ixd_lib.c b/drivers/net/ethernet/intel/ixd/ixd_lib.c
index afc413d3650f..17f4aae594ca 100644
--- a/drivers/net/ethernet/intel/ixd/ixd_lib.c
+++ b/drivers/net/ethernet/intel/ixd/ixd_lib.c
@@ -2,6 +2,8 @@
 /* Copyright (C) 2025 Intel Corporation */
 
 #include "ixd.h"
+#include "ixd_ctlq.h"
+#include "ixd_virtchnl.h"
 
 #define IXD_DFLT_MBX_Q_LEN 64
 
@@ -67,6 +69,11 @@ static void ixd_adapter_fill_dflt_ctlqs(struct ixd_adapter *adapter)
  */
 void ixd_deinit_dflt_mbx(struct ixd_adapter *adapter)
 {
+	cancel_delayed_work_sync(&adapter->mbx_task);
+
+	if (adapter->asq)
+		ixd_ctlq_clean_sq(adapter, true);
+
 	if (adapter->xnm)
 		libie_ctlq_xn_deinit(adapter->xnm, &adapter->cp_ctx);
 
@@ -108,6 +115,8 @@ int ixd_init_dflt_mbx(struct ixd_adapter *adapter)
 		return -ENOENT;
 	}
 
+	queue_delayed_work(system_unbound_wq, &adapter->mbx_task, 0);
+
 	return 0;
 }
 
@@ -136,8 +145,26 @@ void ixd_init_task(struct work_struct *work)
 
 	adapter->init_task.reset_retries = 0;
 	err = ixd_init_dflt_mbx(adapter);
-	if (err)
+	if (err) {
 		dev_err(ixd_to_dev(adapter),
 			"Failed to initialize the default mailbox: %pe\n",
 			ERR_PTR(err));
+		return;
+	}
+
+	if (!ixd_vc_dev_init(adapter)) {
+		adapter->init_task.vc_retries = 0;
+		return;
+	}
+
+	ixd_deinit_dflt_mbx(adapter);
+	if (++adapter->init_task.vc_retries > 5) {
+		dev_err(ixd_to_dev(adapter),
+			"Failed to establish mailbox communications with the hardware\n");
+		return;
+	}
+
+	ixd_trigger_reset(adapter);
+	queue_delayed_work(system_unbound_wq, &adapter->init_task.init_work,
+			   msecs_to_jiffies(500));
 }
diff --git a/drivers/net/ethernet/intel/ixd/ixd_main.c b/drivers/net/ethernet/intel/ixd/ixd_main.c
index b4d4000b63ed..6d5e6aca77df 100644
--- a/drivers/net/ethernet/intel/ixd/ixd_main.c
+++ b/drivers/net/ethernet/intel/ixd/ixd_main.c
@@ -2,6 +2,7 @@
 /* Copyright (C) 2025 Intel Corporation */
 
 #include "ixd.h"
+#include "ixd_ctlq.h"
 #include "ixd_lan_regs.h"
 
 MODULE_DESCRIPTION("Intel(R) Control Plane Function Device Driver");
@@ -19,6 +20,7 @@ static void ixd_remove(struct pci_dev *pdev)
 
 	/* Do not mix removal with (re)initialization */
 	cancel_delayed_work_sync(&adapter->init_task.init_work);
+
 	/* Leave the device clean on exit */
 	ixd_trigger_reset(adapter);
 	ixd_deinit_dflt_mbx(adapter);
@@ -110,6 +112,7 @@ static int ixd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	INIT_DELAYED_WORK(&adapter->init_task.init_work,
 			  ixd_init_task);
+	INIT_DELAYED_WORK(&adapter->mbx_task, ixd_ctlq_rx_task);
 
 	ixd_trigger_reset(adapter);
 	queue_delayed_work(system_unbound_wq, &adapter->init_task.init_work,
diff --git a/drivers/net/ethernet/intel/ixd/ixd_virtchnl.c b/drivers/net/ethernet/intel/ixd/ixd_virtchnl.c
new file mode 100644
index 000000000000..66049d1b1d15
--- /dev/null
+++ b/drivers/net/ethernet/intel/ixd/ixd_virtchnl.c
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2025 Intel Corporation */
+
+#include "ixd.h"
+#include "ixd_ctlq.h"
+#include "ixd_virtchnl.h"
+
+/**
+ * ixd_vc_recv_event_msg - Handle virtchnl event message
+ * @adapter: The adapter handling the message
+ * @ctlq_msg: Message received
+ */
+void ixd_vc_recv_event_msg(struct ixd_adapter *adapter,
+			   struct libie_ctlq_msg *ctlq_msg)
+{
+	int payload_size = ctlq_msg->data_len;
+	struct virtchnl2_event *v2e;
+
+	if (payload_size < sizeof(*v2e)) {
+		dev_warn_ratelimited(ixd_to_dev(adapter),
+				     "Failed to receive valid payload for event msg (op 0x%X len %u)\n",
+				     ctlq_msg->chnl_opcode,
+				     payload_size);
+		return;
+	}
+
+	v2e = (struct virtchnl2_event *)ctlq_msg->recv_mem.iov_base;
+
+	dev_dbg(ixd_to_dev(adapter), "Got event 0x%X from the CP\n",
+		le32_to_cpu(v2e->event));
+}
+
+/**
+ * ixd_vc_can_handle_msg - Decide if an event has to be handled by virtchnl code
+ * @ctlq_msg: Message received
+ *
+ * Return: %true if virtchnl code can handle the event, %false otherwise
+ */
+bool ixd_vc_can_handle_msg(struct libie_ctlq_msg *ctlq_msg)
+{
+	return ctlq_msg->chnl_opcode == VIRTCHNL2_OP_EVENT;
+}
+
+/**
+ * ixd_handle_caps - Handle VIRTCHNL2_OP_GET_CAPS response
+ * @adapter: The adapter for which the capabilities are being updated
+ * @recv_buff: Buffer containing the response
+ * @recv_size: Response buffer size
+ * @ctx: unused
+ *
+ * Return: %0 if the response format is correct and was handled as expected,
+ * negative error otherwise.
+ */
+static int ixd_handle_caps(struct ixd_adapter *adapter, void *recv_buff,
+			   size_t recv_size, void *ctx)
+{
+	if (recv_size < sizeof(adapter->caps))
+		return -EBADMSG;
+
+	adapter->caps = *(typeof(adapter->caps) *)recv_buff;
+
+	return 0;
+}
+
+/**
+ * ixd_req_vc_caps - Request and save device capability
+ * @adapter: The adapter to get the capabilities for
+ *
+ * Return: success or error if sending the get capability message fails
+ */
+static int ixd_req_vc_caps(struct ixd_adapter *adapter)
+{
+	const struct ixd_ctlq_req req = {
+		.opcode = VIRTCHNL2_OP_GET_CAPS,
+		.send_size = sizeof(struct virtchnl2_get_capabilities),
+		.ctx = NULL,
+		.send_buff_init = NULL,
+		.recv_process = ixd_handle_caps,
+	};
+
+	return ixd_ctlq_do_req(adapter, &req);
+}
+
+/**
+ * ixd_get_vc_ver - Get version info from adapter
+ *
+ * Return: filled in virtchannel2 version info, ready for sending
+ */
+static struct virtchnl2_version_info ixd_get_vc_ver(void)
+{
+	return (struct virtchnl2_version_info) {
+		.major = cpu_to_le32(VIRTCHNL2_VERSION_MAJOR_2),
+		.minor = cpu_to_le32(VIRTCHNL2_VERSION_MINOR_0),
+	};
+}
+
+static void ixd_fill_vc_ver(struct ixd_adapter *adapter, void *send_buff,
+			    void *ctx)
+{
+	*(struct virtchnl2_version_info *)send_buff = ixd_get_vc_ver();
+}
+
+/**
+ * ixd_handle_vc_ver - Handle VIRTCHNL2_OP_VERSION response
+ * @adapter: The adapter for which the version is being updated
+ * @recv_buff: Buffer containing the response
+ * @recv_size: Response buffer size
+ * @ctx: Unused
+ *
+ * Return: %0 if the response format is correct and was handled as expected,
+ * negative error otherwise.
+ */
+static int ixd_handle_vc_ver(struct ixd_adapter *adapter, void *recv_buff,
+			     size_t recv_size, void *ctx)
+{
+	struct virtchnl2_version_info need_ver = ixd_get_vc_ver();
+	struct virtchnl2_version_info *recv_ver;
+
+	if (recv_size < sizeof(need_ver))
+		return -EBADMSG;
+
+	recv_ver = recv_buff;
+	if (le32_to_cpu(need_ver.major) > le32_to_cpu(recv_ver->major))
+		return -EOPNOTSUPP;
+
+	adapter->vc_ver.major = le32_to_cpu(recv_ver->major);
+	adapter->vc_ver.minor = le32_to_cpu(recv_ver->minor);
+
+	return 0;
+}
+
+/**
+ * ixd_req_vc_version - Request and save Virtchannel2 version
+ * @adapter: The adapter to get the version for
+ *
+ * Return: success or error if sending fails or the response was not as expected
+ */
+static int ixd_req_vc_version(struct ixd_adapter *adapter)
+{
+	const struct ixd_ctlq_req req = {
+		.opcode = VIRTCHNL2_OP_VERSION,
+		.send_size = sizeof(struct virtchnl2_version_info),
+		.ctx = NULL,
+		.send_buff_init = ixd_fill_vc_ver,
+		.recv_process = ixd_handle_vc_ver,
+	};
+
+	return ixd_ctlq_do_req(adapter, &req);
+}
+
+/**
+ * ixd_vc_dev_init - virtchnl device core initialization
+ * @adapter: device information
+ *
+ * Return: %0 on success or error if any step of the initialization fails
+ */
+int ixd_vc_dev_init(struct ixd_adapter *adapter)
+{
+	int err;
+
+	err = ixd_req_vc_version(adapter);
+	if (err) {
+		dev_warn(ixd_to_dev(adapter),
+			 "Getting virtchnl version failed, error=%pe\n",
+			 ERR_PTR(err));
+		return err;
+	}
+
+	err = ixd_req_vc_caps(adapter);
+	if (err) {
+		dev_warn(ixd_to_dev(adapter),
+			 "Getting virtchnl capabilities failed, error=%pe\n",
+			 ERR_PTR(err));
+		return err;
+	}
+
+	return err;
+}
diff --git a/drivers/net/ethernet/intel/ixd/ixd_virtchnl.h b/drivers/net/ethernet/intel/ixd/ixd_virtchnl.h
new file mode 100644
index 000000000000..1a53da8b545c
--- /dev/null
+++ b/drivers/net/ethernet/intel/ixd/ixd_virtchnl.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (C) 2025 Intel Corporation */
+
+#ifndef _IXD_VIRTCHNL_H_
+#define _IXD_VIRTCHNL_H_
+
+int ixd_vc_dev_init(struct ixd_adapter *adapter);
+bool ixd_vc_can_handle_msg(struct libie_ctlq_msg *ctlq_msg);
+void ixd_vc_recv_event_msg(struct ixd_adapter *adapter,
+			   struct libie_ctlq_msg *ctlq_msg);
+
+#endif /* _IXD_VIRTCHNL_H_ */
-- 
2.47.0


