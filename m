Return-Path: <netdev+bounces-209852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BF7B11110
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 20:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06A6D17FFA2
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 18:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7872EE28D;
	Thu, 24 Jul 2025 18:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="s5NfiJoL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FA32EBDF2
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 18:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753382507; cv=none; b=kTNSlBghlcr2aTpL50fxZnukwzaFvKkbgG9EWZebemJjSitigqZP7uXCkKkMpLKcqvkFWWND3jZ4+I4GmBuziyMtWxO3N0hj3P204rvYnWzQ44F/toEk/JWnLwhD7DZhnhnv6MXZtIW+vARJMY8jNVPSvvAdygFDndUSDVAFi3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753382507; c=relaxed/simple;
	bh=QEkM5Oko2pZYkyAE42Bh+Tlx4NSZZouGnFxIvQbwZAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TXYOq0ciPECyU5S9SDZ97DD2GsHC/Vt7dZI5/mJ1GoHxTDHjj+nZb2Ie4Bp/3sS2Z01DLbh+ek1utZNUyq9psSidzFKe58U6IS6PxiQJLQs7A3b+89q6x1tSwSTuURHg1SUaEL2hpfo+BqZ0oIZccsTy4Smoak7b2lqEB052dWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=s5NfiJoL; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2xg29BqHbks3Jz/Q0pBlq3mu91uBhGyaRbC3it0JMKM=; t=1753382504; x=1754246504; 
	b=s5NfiJoLaMzqTU/wL42JgHnKG+mVLlhHJja3aMt9VqI2oj6GFcFnwYhcYpjX1mzZoVgncHaVo+B
	aIZ/eKy2EfHkohv6PLbgcJ5MtwCFLOIwd441P+FQ7ZfODGuQjFqdaycPPaAVVK+3imQUp8Y0lGZCM
	/NC1xpwhp2s04tOIwcA5B6xVdPcYc2Yq47pz8EXhrA5iLxgiGrRIB14naLrWKVTOpFJjXmPFwcWbk
	GFrF3++NNxOF3jGqSzSntJuDk292sSQqX42MvL9GAOOVlp2qlLRGvh5BLbmYb0G7EgEzzTqWec2Q9
	OSkgPPF9718RvTXp8LkvZ9dZRVab8hJ3EVzQ==;
Received: from 70-228-78-207.lightspeed.sntcca.sbcglobal.net ([70.228.78.207]:55641 helo=localhost.localdomain)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1uf0sx-0006eP-A8; Thu, 24 Jul 2025 11:41:44 -0700
From: John Ousterhout <ouster@cs.stanford.edu>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH net-next v12 11/15] net: homa: create homa_utils.c
Date: Thu, 24 Jul 2025 11:40:44 -0700
Message-ID: <20250724184050.3130-12-ouster@cs.stanford.edu>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250724184050.3130-1-ouster@cs.stanford.edu>
References: <20250724184050.3130-1-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0
X-Scan-Signature: 1d850ab87a3e5a2ab763966491000bbf

This file contains functions for constructing and destructing
homa structs.

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>

---
Changes for v11:
* Move link_mbps variable from struct homa_pacer back to struct homa.

Changes for v10:
* Remove log messages after alloc errors

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
 net/homa/homa_impl.h  |   6 +++
 net/homa/homa_utils.c | 122 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 128 insertions(+)
 create mode 100644 net/homa/homa_utils.c

diff --git a/net/homa/homa_impl.h b/net/homa/homa_impl.h
index a5543e9c64c2..c97bd601e240 100644
--- a/net/homa/homa_impl.h
+++ b/net/homa/homa_impl.h
@@ -413,12 +413,18 @@ static inline bool homa_make_header_avl(struct sk_buff *skb)
 
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
index 000000000000..6f4a714ca7f7
--- /dev/null
+++ b/net/homa/homa_utils.c
@@ -0,0 +1,122 @@
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
+	homa->link_mbps = 25000;
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
+	if (!homa->socktab)
+		return -ENOMEM;
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


