Return-Path: <netdev+bounces-178455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4ECAA77180
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 01:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15EF0188DF79
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 23:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3188521D3ED;
	Mon, 31 Mar 2025 23:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="uaX0lLO2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9188921CA1C
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 23:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743464836; cv=none; b=tR1BsVi7T8Nro2OSQ95h7AG7PzrBGA17jSud/8oLITVuRuklwdKsH/hxTDCBL3pAIZ3zg+MZLI2Z7zJZiGYB1aIhT72tXCGYb8F37tw/K6h43QitFCE42qPOeWmQTC7Af4SJLtPnLETZDnLclWKM1Zi/a7l/cN4zT8h85nAzdXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743464836; c=relaxed/simple;
	bh=HdTf+ewLoLw0nBqD0yvWbYne3iBGF+icpjyWlwHiwL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GLAixTIZjplmpGhVAmNw/YPhekK87LYNQZxQ6p/WVuNLlBgngqS5MUTFHXRuqw3Q/ggNZuWyPbz5UyQD9aGPIap/fvyDpOGh8Z2kY5OzMSog95V1WEAxBlFiklSdrVeKv8YYHHn6h4bJtOKgruvY3iw5eo6PPCYF4wbACRGzJU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=uaX0lLO2; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NPBi4eIQYZZ4RgV3vOPOHprRa+hjcDcvemNTcu2J/7I=; t=1743464834; x=1744328834; 
	b=uaX0lLO2boJXWxtH96b7ewpnyk3ZF+UVQ4GVYHkUnMavbwFw4NnngASvCGDNYxvYA54j2vhOr3o
	RV3t7Vd38nDEAKKdoq2K9qgFpWBfavmcU1m+554l9FXCpn/6eENx79f768+lxTuQvOYYFFbHVqhHn
	OEw43ZXayJxPl1NgEBV81VQW/WM0SocHLmSFuBQ3sB6C6u19OHWqTqTOpngoTCEPIPr+dxEzSz3rK
	9rFnMiMqnTLqhJ903O7XSMx0teqcqDkeNHw7y/+J/aJCtCYK+UCqDT4qZmVhUdBLnS9HmfFlcrlV7
	Qen3usD82Y+paEUvi37sON4MOnnpL3Kqm4ZQ==;
Received: from ouster448.stanford.edu ([172.24.72.71]:55223 helo=localhost.localdomain)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tzOqX-000219-N8; Mon, 31 Mar 2025 16:47:14 -0700
From: John Ousterhout <ouster@cs.stanford.edu>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH net-next v7 10/14] net: homa: create homa_utils.c
Date: Mon, 31 Mar 2025 16:45:43 -0700
Message-ID: <20250331234548.62070-11-ouster@cs.stanford.edu>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250331234548.62070-1-ouster@cs.stanford.edu>
References: <20250331234548.62070-1-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -101.0
X-Scan-Signature: 104fcb84af92cc131bf6e023e43ddbb4

This file contains functions for constructing and destructing
homa structs.

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>

---
Changes for v7:
* Make Homa a pernet subsystem
* Add support for tx memory accounting
* Remove "lock_slow" functions, which don't add functionality in this
  patch series
* Use u64 and __u64 properly
---
 net/homa/homa_utils.c | 118 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 118 insertions(+)
 create mode 100644 net/homa/homa_utils.c

diff --git a/net/homa/homa_utils.c b/net/homa/homa_utils.c
new file mode 100644
index 000000000000..b9d46eeb8274
--- /dev/null
+++ b/net/homa/homa_utils.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: BSD-2-Clause
+
+/* This file contains miscellaneous utility functions for Homa, such
+ * as initializing and destroying homa structs.
+ */
+
+#include "homa_impl.h"
+#include "homa_peer.h"
+#include "homa_rpc.h"
+#include "homa_stub.h"
+
+struct completion homa_pacer_kthread_done;
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
+	init_completion(&homa_pacer_kthread_done);
+	atomic64_set(&homa->next_outgoing_id, 2);
+	atomic64_set(&homa->link_idle_time, sched_clock());
+	spin_lock_init(&homa->pacer_mutex);
+	homa->pacer_fifo_fraction = 50;
+	homa->pacer_fifo_count = 1;
+	spin_lock_init(&homa->throttle_lock);
+	INIT_LIST_HEAD_RCU(&homa->throttled_rpcs);
+	homa->throttle_min_bytes = 200;
+	homa->prev_default_port = HOMA_MIN_DEFAULT_PORT - 1;
+	homa->port_map = kmalloc(sizeof(*homa->port_map), GFP_KERNEL);
+	if (!homa->port_map) {
+		pr_err("%s couldn't create port_map: kmalloc failure",
+		       __func__);
+		return -ENOMEM;
+	}
+	homa_socktab_init(homa->port_map);
+	homa->peers = kmalloc(sizeof(*homa->peers), GFP_KERNEL);
+	if (!homa->peers) {
+		pr_err("%s couldn't create peers: kmalloc failure", __func__);
+		return -ENOMEM;
+	}
+	err = homa_peertab_init(homa->peers);
+	if (err) {
+		pr_err("%s couldn't initialize peer table (errno %d)\n",
+		       __func__, -err);
+		return err;
+	}
+
+	/* Wild guesses to initialize configuration values... */
+	homa->link_mbps = 25000;
+	homa->resend_ticks = 5;
+	homa->resend_interval = 5;
+	homa->timeout_ticks = 100;
+	homa->timeout_resends = 5;
+	homa->request_ack_ticks = 2;
+	homa->reap_limit = 10;
+	homa->dead_buffs_limit = 5000;
+	homa->pacer_kthread = kthread_run(homa_pacer_main, homa,
+					  "homa_pacer");
+	if (IS_ERR(homa->pacer_kthread)) {
+		err = PTR_ERR(homa->pacer_kthread);
+		homa->pacer_kthread = NULL;
+		pr_err("couldn't create homa pacer thread: error %d\n", err);
+		return err;
+	}
+	homa->pacer_exit = false;
+	homa->max_nic_queue_ns = 5000;
+	homa->wmem_max = 100000000;
+	homa->max_gso_size = 10000;
+	homa->bpage_lease_usecs = 10000;
+	return 0;
+}
+
+/**
+ * homa_destroy() -  Destructor for homa objects.
+ * @homa:      Object to destroy.
+ */
+void homa_destroy(struct homa *homa)
+{
+	if (homa->pacer_kthread) {
+		homa_pacer_stop(homa);
+		wait_for_completion(&homa_pacer_kthread_done);
+	}
+
+	/* The order of the following statements matters! */
+	if (homa->port_map) {
+		homa_socktab_destroy(homa->port_map);
+		kfree(homa->port_map);
+		homa->port_map = NULL;
+	}
+	if (homa->peers) {
+		homa_peertab_destroy(homa->peers);
+		kfree(homa->peers);
+		homa->peers = NULL;
+	}
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
+	end = sched_clock() + ns;
+	while (sched_clock() < end)
+		/* Empty loop body.*/
+		;
+}
+
-- 
2.34.1


