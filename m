Return-Path: <netdev+bounces-187550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 661B2AA7D63
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 01:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBF6C4E2699
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 23:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E3123182C;
	Fri,  2 May 2025 23:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="N9ApBULY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023D822F77F
	for <netdev@vger.kernel.org>; Fri,  2 May 2025 23:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746229100; cv=none; b=iEtqBm31HmslSOpGuUnYoi9E9vmT7AaDlXCSKvKTYeRc7eHvGLwHC6uo7G6pWXtjDSzhNJNsnue6YdIvA0iqgOUixVfbjF+cbeqHqVJZI+3MZRQ6w8dyYbOLuVwAJNcUcJjxWFeXi+lzuqInmJuiFXhcwD2K6BpBoTRj5gV1IYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746229100; c=relaxed/simple;
	bh=Kq1iDNgh/5EccG5SCgNb0UUqYBx6+4Lr3WD+AfV2CYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gKQ/oVF05inr2Jvb4R8ayGsNjTGVKr/QPkhOaF4jLRXBq/2yMen6uWJtbhldQpCijoDwkvc/CUVXH/BGaWiBtuGMXb23mqzE8bugmLO89pejEgD6EAPkDwg/foqozob4nWEF7hkD5fEmwpNOYeFxYy6bEeNEvfHfNwRDC/WyVcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=N9ApBULY; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0S/RYLRmm68qUeRHXGrMvUwLMghP/IVrguboouBfNEc=; t=1746229099; x=1747093099; 
	b=N9ApBULYCZEDQ+DyPlUpkhcnvHC74yWBuyZ2hNIgdFotQCTVPivOZd/D8AfCVdl3oa2R1KDMl2z
	lqmkWumVeI1DNPUfZvThW1epcwzo9PEbRfm/UY5fAKWCPZ/xBBmDTIv9gBP07uXVNy31S6fF3NSlZ
	4VYf0zZ+T91Z+u4jBvk4CgdozVCdq4dooQpszPnro2aqul3qSlmw/AZ7lTOmrz8TISIiPcP+pzUTa
	3bJ85kG9+SMQOr1G93iqQVEgBnB9PGQA3ij64EIQWTTeZe7itVDznW4eW3c8emyptuWb/4x8JTvC+
	4MKqwizFLohq8qbEmallZbqv4LwzMo8gD9Fw==;
Received: from ouster448.stanford.edu ([172.24.72.71]:64199 helo=localhost.localdomain)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1uAzxR-0007if-QD; Fri, 02 May 2025 16:38:18 -0700
From: John Ousterhout <ouster@cs.stanford.edu>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH net-next v8 11/15] net: homa: create homa_utils.c
Date: Fri,  2 May 2025 16:37:24 -0700
Message-ID: <20250502233729.64220-12-ouster@cs.stanford.edu>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250502233729.64220-1-ouster@cs.stanford.edu>
References: <20250502233729.64220-1-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -101.0
X-Scan-Signature: b34415b11b396f6021f8c280aedacb6a

This file contains functions for constructing and destructing
homa structs.

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>

---
Changes for v8:
* Accommodate homa_pacer refactoring

Changes for v7:
* Make Homa a pernet subsystem
* Add support for tx memory accounting
* Remove "lock_slow" functions, which don't add functionality in this
  patch series
* Use u64 and __u64 properly
---
 net/homa/homa_utils.c | 103 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)
 create mode 100644 net/homa/homa_utils.c

diff --git a/net/homa/homa_utils.c b/net/homa/homa_utils.c
new file mode 100644
index 000000000000..01716014afaa
--- /dev/null
+++ b/net/homa/homa_utils.c
@@ -0,0 +1,103 @@
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
+ * @net:    Network namespace that @homa is associated with.
+ *
+ * Return:  0 on success, or a negative errno if there was an error. Even
+ *          if an error occurs, it is safe (and necessary) to call
+ *          homa_destroy at some point.
+ */
+int homa_init(struct homa *homa, struct net *net)
+{
+	int err;
+
+	memset(homa, 0, sizeof(*homa));
+	atomic64_set(&homa->next_outgoing_id, 2);
+	homa->pacer = homa_pacer_new(homa, net);
+	if (IS_ERR(homa->pacer)) {
+		err = PTR_ERR(homa->pacer);
+		homa->pacer = NULL;
+		return err;
+	}
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
+ * @homa:      Object to destroy.
+ */
+void homa_destroy(struct homa *homa)
+{
+	/* The order of the following statements matters! */
+	if (homa->port_map) {
+		homa_socktab_destroy(homa->port_map);
+		kfree(homa->port_map);
+		homa->port_map = NULL;
+	}
+	if (homa->pacer) {
+		homa_pacer_destroy(homa->pacer);
+		homa->pacer = NULL;
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
-- 
2.43.0


