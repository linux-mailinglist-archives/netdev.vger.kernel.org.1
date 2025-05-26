Return-Path: <netdev+bounces-193326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98067AC38A4
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 06:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 725C718941A7
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 04:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6DA1C54A2;
	Mon, 26 May 2025 04:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="UjeQotCU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86201B4141
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 04:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748233750; cv=none; b=QwJa2axhl/LXC4xOEvOR2ATu7UD7hPY5PI2biGzmWw/8PvQ7CatRh53PQd/L81sXEtPpXCi2lNna2kTQNJnL/5yZowZ8my43qvgiHWdXBZBAwwpbVlu5mQpOB9dUOSHoNsUF0wNADd/MhdNmTjOFMIfz6okRCrtCH839wWdSfYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748233750; c=relaxed/simple;
	bh=xjhh3ysl0Y0ztNityU6OfaX8rTJOgEezCdgx8CPTQXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CTlbApT78aGGexh4bDDkQT4RtlnxmTuZIXfy/Iug7d3gHVvzIUhDAbZP3HkuCGChrGW8b1Zb1ylYtoopIybf3E/PBL1xPzjmNfXGsGInfPEzCvR9t1eokNS+I5cTVo0MmXCLg9tKZ86xCMbRbvj51XLfMKQba/Pv4YQMwwJP5pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=UjeQotCU; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nQK1VuN9osxnvexKlGz+Ek6mQGdl45PBrk8fYCysi40=; t=1748233748; x=1749097748; 
	b=UjeQotCUWUl9pVMUlhopYrwprqtitET9l4Mfai1UHZXgEuUSsV3S0kUSvh8G8TiQcd/clR90X49
	154mnlPHdGP7ep0CCil3Z3PGD3EygYCMHHSCEoVPk5nDplAJ8Web0kzQSm1Llh0ad8xg9u6KBzdGO
	v0Z35I5ZVR4tG9GN1bK6qd0Hg8SxFm4i8FSHYD2tDwijq1CM71Guc3K0LtP0L34HA2N/C6XiY/401
	DcKLN/zD0vQemKiIP53z7eG+FFGC2bZFDJOyInKO6rSfseqgKdogEGhjnMYxMM7AXU1HfyF5gDafQ
	645kkbsiMNl4zySAJ5MAkLTjLyznCkc7poHQ==;
Received: from 70-228-78-207.lightspeed.sntcca.sbcglobal.net ([70.228.78.207]:54961 helo=localhost.localdomain)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1uJPSV-0006Qy-L8; Sun, 25 May 2025 21:29:08 -0700
From: John Ousterhout <ouster@cs.stanford.edu>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH net-next v9 11/15] net: homa: create homa_utils.c
Date: Sun, 25 May 2025 21:28:13 -0700
Message-ID: <20250526042819.2526-12-ouster@cs.stanford.edu>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250526042819.2526-1-ouster@cs.stanford.edu>
References: <20250526042819.2526-1-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: d35fb6c06066e474e02df1cf6298274e

This file contains functions for constructing and destructing
homa structs.

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>

---
Changes for v9:
* Add support for homa_net objects
* Use new homa_clock abstraction layer
* Various name improvements (e.g. use "alloc" instead of "new" for functions
  that allocate memory)

Changes for v8:
* Accommodate homa_pacer refactoring

Changes for v7:
* Make Homa a pernet subsystem
* Add support for tx memory accounting
* Remove "lock_slow" functions, which don't add functionality in this
  patch series
* Use u64 and __u64 properly
---
 net/homa/homa_impl.h  |   6 ++
 net/homa/homa_utils.c | 124 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 130 insertions(+)
 create mode 100644 net/homa/homa_utils.c

diff --git a/net/homa/homa_impl.h b/net/homa/homa_impl.h
index caf914f08c49..af18ceac2e0d 100644
--- a/net/homa/homa_impl.h
+++ b/net/homa/homa_impl.h
@@ -385,12 +385,18 @@ static inline bool homa_make_header_avl(struct sk_buff *skb)
 
 extern unsigned int homa_net_id;
 
+void     homa_destroy(struct homa *homa);
 int      homa_fill_data_interleaved(struct homa_rpc *rpc,
 				    struct sk_buff *skb, struct iov_iter *iter);
+int      homa_init(struct homa *homa);
 int      homa_message_out_fill(struct homa_rpc *rpc,
 			       struct iov_iter *iter, int xmit);
 void     homa_message_out_init(struct homa_rpc *rpc, int length);
+void     homa_net_destroy(struct homa_net *hnet);
+int      homa_net_init(struct homa_net *hnet, struct net *net,
+		       struct homa *homa);
 void     homa_rpc_handoff(struct homa_rpc *rpc);
+void     homa_spin(int ns);
 struct sk_buff *homa_tx_data_pkt_alloc(struct homa_rpc *rpc,
 				       struct iov_iter *iter, int offset,
 				       int length, int max_seg_data);
diff --git a/net/homa/homa_utils.c b/net/homa/homa_utils.c
new file mode 100644
index 000000000000..da4b69f036bc
--- /dev/null
+++ b/net/homa/homa_utils.c
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: BSD-2-Clause
+
+/* This file contains miscellaneous utility functions for Homa, such
+ * as initializing and destroying homa structs.
+ */
+
+#include "homa_impl.h"
+#include "homa_pacer.h"
+#include "homa_peer.h"
+#include "homa_rpc.h"
+#include "homa_stub.h"
+
+/**
+ * homa_init() - Constructor for homa objects.
+ * @homa:   Object to initialize.
+ *
+ * Return:  0 on success, or a negative errno if there was an error. Even
+ *          if an error occurs, it is safe (and necessary) to call
+ *          homa_destroy at some point.
+ */
+int homa_init(struct homa *homa)
+{
+	int err;
+
+	memset(homa, 0, sizeof(*homa));
+
+	atomic64_set(&homa->next_outgoing_id, 2);
+	homa->pacer = homa_pacer_alloc(homa);
+	if (IS_ERR(homa->pacer)) {
+		err = PTR_ERR(homa->pacer);
+		homa->pacer = NULL;
+		return err;
+	}
+	homa->peertab = homa_peer_alloc_peertab();
+	if (IS_ERR(homa->peertab)) {
+		err = PTR_ERR(homa->peertab);
+		homa->peertab = NULL;
+		return err;
+	}
+	homa->socktab = kmalloc(sizeof(*homa->socktab), GFP_KERNEL);
+	if (!homa->socktab) {
+		pr_err("%s couldn't create socktab: kmalloc failure",
+		       __func__);
+		return -ENOMEM;
+	}
+	homa_socktab_init(homa->socktab);
+
+	/* Wild guesses to initialize configuration values... */
+	homa->resend_ticks = 5;
+	homa->resend_interval = 5;
+	homa->timeout_ticks = 100;
+	homa->timeout_resends = 5;
+	homa->request_ack_ticks = 2;
+	homa->reap_limit = 10;
+	homa->dead_buffs_limit = 5000;
+	homa->max_gso_size = 10000;
+	homa->wmem_max = 100000000;
+	homa->bpage_lease_usecs = 10000;
+	return 0;
+}
+
+/**
+ * homa_destroy() -  Destructor for homa objects.
+ * @homa:      Object to destroy. It is safe if this object has already
+ *             been previously destroyed.
+ */
+void homa_destroy(struct homa *homa)
+{
+	/* The order of the following cleanups matters! */
+	if (homa->socktab) {
+		homa_socktab_destroy(homa->socktab, NULL);
+		kfree(homa->socktab);
+		homa->socktab = NULL;
+	}
+	if (homa->pacer) {
+		homa_pacer_free(homa->pacer);
+		homa->pacer = NULL;
+	}
+	if (homa->peertab) {
+		homa_peer_free_peertab(homa->peertab);
+		homa->peertab = NULL;
+	}
+}
+
+/**
+ * homa_net_init() - Initialize a new struct homa_net as a per-net subsystem.
+ * @hnet:    Struct to initialzie.
+ * @net:     The network namespace the struct will be associated with.
+ * @homa:    The main Homa data structure to use for the net.
+ * Return:  0 on success, otherwise a negative errno.
+ */
+int homa_net_init(struct homa_net *hnet, struct net *net, struct homa *homa)
+{
+	memset(hnet, 0, sizeof(*hnet));
+	hnet->net = net;
+	hnet->homa = homa;
+	hnet->prev_default_port = HOMA_MIN_DEFAULT_PORT - 1;
+	return 0;
+}
+
+/**
+ * homa_net_destroy() - Release any resources associated with a homa_net.
+ * @hnet:    Object to destroy; must not be used again after this function
+ *           returns.
+ */
+void homa_net_destroy(struct homa_net *hnet)
+{
+	homa_socktab_destroy(hnet->homa->socktab, hnet);
+	homa_peer_free_net(hnet);
+}
+
+/**
+ * homa_spin() - Delay (without sleeping) for a given time interval.
+ * @ns:   How long to delay (in nanoseconds)
+ */
+void homa_spin(int ns)
+{
+	u64 end;
+
+	end = homa_clock() + homa_ns_to_cycles(ns);
+	while (homa_clock() < end)
+		/* Empty loop body.*/
+		;
+}
-- 
2.43.0


