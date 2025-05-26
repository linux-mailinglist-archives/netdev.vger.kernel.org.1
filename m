Return-Path: <netdev+bounces-193330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA15AAC38A5
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 06:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 258CD7A8C47
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 04:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC001A3161;
	Mon, 26 May 2025 04:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="TZuhipZb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176A11D90DF
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 04:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748233762; cv=none; b=CojrH5/mK/76g3FhcSLwqXckiZZhEMmiFionuO60BCmYqdB7x36T2WoZDq1sOByWri1X0VHWU0E+GaGZoC2wm0CZBvPAIiX2uuLc0CmICTyYwGKtGvLfQKLSek2ppLK0zL6qC9IktLlWM7sw4jI1ER0QaEwB/GsypqA5gaU1aAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748233762; c=relaxed/simple;
	bh=4/5HMkUOvjXRYZBhOJneKonTa8GPJ59Gm6IZeAzzPHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=luz+wLpQMfEjMW9ro0KO+jxaI/cE+BcTG9Z8FNVDE77IQSxLMdDqTNOT5fOxgAdR7W7PnyzkQL/7QMT5kYIm3pAxmp7/uy6egnRsNg92HT1d81g5dmC8NFU0s8A2Q/c7lR1fBNljPFVIwJEjxSE/XZRrsFPWjZo+8bNjEgFh0i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=TZuhipZb; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=F8GgnehVkWRbCfFm8Swm+COjD4ngvXxpeDMzUa12PQQ=; t=1748233759; x=1749097759; 
	b=TZuhipZbmTcLTN3mRD58eRIoCMlKOkoY31Z8FmO5ADyrJdxuOI0AIHNa+8Woafofxrd2TLtsCP4
	hQiIMAVyzZSHCMPKIA9BAdvenaYfXn1zMWXW7dNb90thIY5UQmkZsKBw1sOB+3zX4uVYdyn/oemwK
	FzrKRM3Dri0IrjwI+n9V3re9hX1LZ/SN/HmOozrmAtXs217bqRiyyfZncjVp+1ubd3GRcJyTVPJyI
	50e6jld4FgLxjDi5/5IRy7uy7bYeG0u89gjexYgDFVito+UlGyTNgDQwq82HkSvfv04qeupzY62wy
	B1e2E8c4gMyvqMJYD1UeYqKuHP8eaCPYcrZg==;
Received: from 70-228-78-207.lightspeed.sntcca.sbcglobal.net ([70.228.78.207]:54961 helo=localhost.localdomain)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1uJPSd-0006Qy-Gz; Sun, 25 May 2025 21:29:18 -0700
From: John Ousterhout <ouster@cs.stanford.edu>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	John Ousterhout <ouster@cs.stanford.edu>
Subject: [PATCH net-next v9 14/15] net: homa: create homa_plumbing.c
Date: Sun, 25 May 2025 21:28:16 -0700
Message-ID: <20250526042819.2526-15-ouster@cs.stanford.edu>
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
X-Scan-Signature: 7ccef97a5dbb3287230375d9f1c30c5d

homa_plumbing.c contains functions that connect Homa to the rest of
the Linux kernel, such as dispatch tables used by Linux and the
top-level functions that Linux invokes from those dispatch tables.

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>

---
Changes for v9:
* Add support for homa_net objects
* Various name improvements (e.g. use "alloc" instead of "new" for functions
  that allocate memory)
* Add BUILD_BUG_ON statements to replace _Static_asserts removed from
  header files
* Remove unnecessary/unused functions such as homa_get_port, homa_disconnect,
  and homa_backlog_rcv.

Changes for v8:
* Accommodate homa_pacer and homa_pool refactorings

Changes for v7:
* Remove extraneous code
* Make Homa a pernet subsystem
* Block Homa senders if insufficient tx buffer memory
* Check for missing buffer pool in homa_recvmsg
* Refactor waiting mechanism for incoming packets: simplify wait
  criteria and use standard Linux mechanisms for waiting
* Implement SO_HOMA_SERVER option for setsockopt
* Rename UNKNOWN packet type to RPC_UNKNOWN
* Remove locker argument from locking functions
* Use u64 and __u64 properly
* Use new homa_make_header_avl functionnet: homa: create homa_plumbing.c

homa_plumbing.c contains functions that connect Homa to the rest of
the Linux kernel, such as dispatch tables used by Linux and the
top-level functions that Linux invokes from those dispatch tables.

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>

---
Changes for v9:
* Add support for homa_net objects
* Various name improvements (e.g. use "alloc" instead of "new" for
  functions
  that allocate memory)
* Add BUILD_BUG_ON statements to replace _Static_asserts removed from
  header files
* Remove unnecessary/unused functions such as homa_get_port,
  homa_disconnect,
  and homa_backlog_rcv.

Changes for v8:
* Accommodate homa_pacer and homa_pool refactorings

Changes for v7:
* Remove extraneous code
* Make Homa a pernet subsystem
* Block Homa senders if insufficient tx buffer memory
* Check for missing buffer pool in homa_recvmsg
* Refactor waiting mechanism for incoming packets: simplify wait
  criteria and use standard Linux mechanisms for waiting
* Implement SO_HOMA_SERVER option for setsockopt
* Rename UNKNOWN packet type to RPC_UNKNOWN
* Remove locker argument from locking functions
* Use u64 and __u64 properly
* Use new homa_make_header_avl functionnet: homa: create homa_plumbing.c

homa_plumbing.c contains functions that connect Homa to the rest of
the Linux kernel, such as dispatch tables used by Linux and the
top-level functions that Linux invokes from those dispatch tables.

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>

---
Changes for v9:
* Add support for homa_net objects
* Various name improvements (e.g. use "alloc" instead of "new" for
  functions
  that allocate memory)
* Add BUILD_BUG_ON statements to replace _Static_asserts removed from
  header files
* Remove unnecessary/unused functions such as homa_get_port,
  homa_disconnect,
  and homa_backlog_rcv.

Changes for v8:
* Accommodate homa_pacer and homa_pool refactorings

Changes for v7:
* Remove extraneous code
* Make Homa a pernet subsystem
* Block Homa senders if insufficient tx buffer memory
* Check for missing buffer pool in homa_recvmsg
* Refactor waiting mechanism for incoming packets: simplify wait
  criteria and use standard Linux mechanisms for waiting
* Implement SO_HOMA_SERVER option for setsockopt
* Rename UNKNOWN packet type to RPC_UNKNOWN
* Remove locker argument from locking functions
* Use u64 and __u64 properly
* Use new homa_make_header_avl functionnet: homa: create homa_plumbing.c

homa_plumbing.c contains functions that connect Homa to the rest of
the Linux kernel, such as dispatch tables used by Linux and the
top-level functions that Linux invokes from those dispatch tables.

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>

---
Changes for v9:
* Add support for homa_net objects
* Various name improvements (e.g. use "alloc" instead of "new" for
  functions
  that allocate memory)
* Add BUILD_BUG_ON statements to replace _Static_asserts removed from
  header files
* Remove unnecessary/unused functions such as homa_get_port,
  homa_disconnect,
  and homa_backlog_rcv.

Changes for v8:
* Accommodate homa_pacer and homa_pool refactorings

Changes for v7:
* Remove extraneous code
* Make Homa a pernet subsystem
* Block Homa senders if insufficient tx buffer memory
* Check for missing buffer pool in homa_recvmsg
* Refactor waiting mechanism for incoming packets: simplify wait
  criteria and use standard Linux mechanisms for waiting
* Implement SO_HOMA_SERVER option for setsockopt
* Rename UNKNOWN packet type to RPC_UNKNOWN
* Remove locker argument from locking functions
* Use u64 and __u64 properly
* Use new homa_make_header_avl functionnet: homa: create homa_plumbing.c

homa_plumbing.c contains functions that connect Homa to the rest of
the Linux kernel, such as dispatch tables used by Linux and the
top-level functions that Linux invokes from those dispatch tables.

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>

---
Changes for v9:
* Add support for homa_net objects
* Various name improvements (e.g. use "alloc" instead of "new" for
  functions
  that allocate memory)
* Add BUILD_BUG_ON statements to replace _Static_asserts removed from
  header files
* Remove unnecessary/unused functions such as homa_get_port,
  homa_disconnect,
  and homa_backlog_rcv.

Changes for v8:
* Accommodate homa_pacer and homa_pool refactorings

Changes for v7:
* Remove extraneous code
* Make Homa a pernet subsystem
* Block Homa senders if insufficient tx buffer memory
* Check for missing buffer pool in homa_recvmsg
* Refactor waiting mechanism for incoming packets: simplify wait
  criteria and use standard Linux mechanisms for waiting
* Implement SO_HOMA_SERVER option for setsockopt
* Rename UNKNOWN packet type to RPC_UNKNOWN
* Remove locker argument from locking functions
* Use u64 and __u64 properly
* Use new homa_make_header_avl functionnet: homa: create homa_plumbing.c

homa_plumbing.c contains functions that connect Homa to the rest of
the Linux kernel, such as dispatch tables used by Linux and the
top-level functions that Linux invokes from those dispatch tables.

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>

---
Changes for v9:
* Add support for homa_net objects
* Various name improvements (e.g. use "alloc" instead of "new" for
  functions
  that allocate memory)
* Add BUILD_BUG_ON statements to replace _Static_asserts removed from
  header files
* Remove unnecessary/unused functions such as homa_get_port,
  homa_disconnect,
  and homa_backlog_rcv.

Changes for v8:
* Accommodate homa_pacer and homa_pool refactorings

Changes for v7:
* Remove extraneous code
* Make Homa a pernet subsystem
* Block Homa senders if insufficient tx buffer memory
* Check for missing buffer pool in homa_recvmsg
* Refactor waiting mechanism for incoming packets: simplify wait
  criteria and use standard Linux mechanisms for waiting
* Implement SO_HOMA_SERVER option for setsockopt
* Rename UNKNOWN packet type to RPC_UNKNOWN
* Remove locker argument from locking functions
* Use u64 and __u64 properly
* Use new homa_make_header_avl functionnet: homa: create homa_plumbing.c

homa_plumbing.c contains functions that connect Homa to the rest of
the Linux kernel, such as dispatch tables used by Linux and the
top-level functions that Linux invokes from those dispatch tables.

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>

---
Changes for v9:
* Add support for homa_net objects
* Various name improvements (e.g. use "alloc" instead of "new" for
  functions
  that allocate memory)
* Add BUILD_BUG_ON statements to replace _Static_asserts removed from
  header files
* Remove unnecessary/unused functions such as homa_get_port,
  homa_disconnect,
  and homa_backlog_rcv.

Changes for v8:
* Accommodate homa_pacer and homa_pool refactorings

Changes for v7:
* Remove extraneous code
* Make Homa a pernet subsystem
* Block Homa senders if insufficient tx buffer memory
* Check for missing buffer pool in homa_recvmsg
* Refactor waiting mechanism for incoming packets: simplify wait
  criteria and use standard Linux mechanisms for waiting
* Implement SO_HOMA_SERVER option for setsockopt
* Rename UNKNOWN packet type to RPC_UNKNOWN
* Remove locker argument from locking functions
* Use u64 and __u64 properly
* Use new homa_make_header_avl functionnet: homa: create homa_plumbing.c

homa_plumbing.c contains functions that connect Homa to the rest of
the Linux kernel, such as dispatch tables used by Linux and the
top-level functions that Linux invokes from those dispatch tables.

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>

---
Changes for v9:
* Add support for homa_net objects
* Various name improvements (e.g. use "alloc" instead of "new" for
  functions
  that allocate memory)
* Add BUILD_BUG_ON statements to replace _Static_asserts removed from
  header files
* Remove unnecessary/unused functions such as homa_get_port,
  homa_disconnect,
  and homa_backlog_rcv.

Changes for v8:
* Accommodate homa_pacer and homa_pool refactorings

Changes for v7:
* Remove extraneous code
* Make Homa a pernet subsystem
* Block Homa senders if insufficient tx buffer memory
* Check for missing buffer pool in homa_recvmsg
* Refactor waiting mechanism for incoming packets: simplify wait
  criteria and use standard Linux mechanisms for waiting
* Implement SO_HOMA_SERVER option for setsockopt
* Rename UNKNOWN packet type to RPC_UNKNOWN
* Remove locker argument from locking functions
* Use u64 and __u64 properly
* Use new homa_make_header_avl functionnet: homa: create homa_plumbing.c

homa_plumbing.c contains functions that connect Homa to the rest of
the Linux kernel, such as dispatch tables used by Linux and the
top-level functions that Linux invokes from those dispatch tables.

Signed-off-by: John Ousterhout <ouster@cs.stanford.edu>

---
Changes for v9:
* Add support for homa_net objects
* Various name improvements (e.g. use "alloc" instead of "new" for
  functions
  that allocate memory)
* Add BUILD_BUG_ON statements to replace _Static_asserts removed from
  header files
* Remove unnecessary/unused functions such as homa_get_port,
  homa_disconnect,
  and homa_backlog_rcv.

Changes for v8:
* Accommodate homa_pacer and homa_pool refactorings

Changes for v7:
* Remove extraneous code
* Make Homa a pernet subsystem
* Block Homa senders if insufficient tx buffer memory
* Check for missing buffer pool in homa_recvmsg
* Refactor waiting mechanism for incoming packets: simplify wait
  criteria and use standard Linux mechanisms for waiting
* Implement SO_HOMA_SERVER option for setsockopt
* Rename UNKNOWN packet type to RPC_UNKNOWN
* Remove locker argument from locking functions
* Use u64 and __u64 properly
* Use new homa_make_header_avl function
---
 net/homa/homa_impl.h     |   27 +
 net/homa/homa_plumbing.c | 1071 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 1098 insertions(+)
 create mode 100644 net/homa/homa_plumbing.c

diff --git a/net/homa/homa_impl.h b/net/homa/homa_impl.h
index b3243b4b3669..ff0b1e35569a 100644
--- a/net/homa/homa_impl.h
+++ b/net/homa/homa_impl.h
@@ -388,26 +388,51 @@ extern unsigned int homa_net_id;
 void     homa_ack_pkt(struct sk_buff *skb, struct homa_sock *hsk,
 		      struct homa_rpc *rpc);
 void     homa_add_packet(struct homa_rpc *rpc, struct sk_buff *skb);
+int      homa_bind(struct socket *sk, struct sockaddr *addr,
+		   int addr_len);
+void     homa_close(struct sock *sock, long timeout);
 int      homa_copy_to_user(struct homa_rpc *rpc);
 void     homa_data_pkt(struct sk_buff *skb, struct homa_rpc *rpc);
 void     homa_destroy(struct homa *homa);
 void     homa_dispatch_pkts(struct sk_buff *skb);
+int      homa_err_handler_v4(struct sk_buff *skb, u32 info);
+int      homa_err_handler_v6(struct sk_buff *skb,
+			     struct inet6_skb_parm *opt, u8 type,  u8 code,
+			     int offset, __be32 info);
 int      homa_fill_data_interleaved(struct homa_rpc *rpc,
 				    struct sk_buff *skb, struct iov_iter *iter);
 struct homa_gap *homa_gap_alloc(struct list_head *next, int start, int end);
 void     homa_gap_retry(struct homa_rpc *rpc);
+int      homa_getsockopt(struct sock *sk, int level, int optname,
+			 char __user *optval, int __user *optlen);
+int      homa_hash(struct sock *sk);
+enum hrtimer_restart homa_hrtimer(struct hrtimer *timer);
 int      homa_init(struct homa *homa);
+int      homa_ioctl(struct sock *sk, int cmd, int *karg);
+int      homa_load(void);
 int      homa_message_out_fill(struct homa_rpc *rpc,
 			       struct iov_iter *iter, int xmit);
 void     homa_message_out_init(struct homa_rpc *rpc, int length);
 void     homa_need_ack_pkt(struct sk_buff *skb, struct homa_sock *hsk,
 			   struct homa_rpc *rpc);
 void     homa_net_destroy(struct homa_net *hnet);
+void     homa_net_exit(struct net *net);
 int      homa_net_init(struct homa_net *hnet, struct net *net,
 		       struct homa *homa);
+int      homa_net_start(struct net *net);
+__poll_t homa_poll(struct file *file, struct socket *sock,
+		   struct poll_table_struct *wait);
+int      homa_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
+		      int flags, int *addr_len);
 void     homa_resend_pkt(struct sk_buff *skb, struct homa_rpc *rpc,
 			 struct homa_sock *hsk);
 void     homa_rpc_handoff(struct homa_rpc *rpc);
+int      homa_sendmsg(struct sock *sk, struct msghdr *msg, size_t len);
+int      homa_setsockopt(struct sock *sk, int level, int optname,
+			 sockptr_t optval, unsigned int optlen);
+int      homa_shutdown(struct socket *sock, int how);
+int      homa_socket(struct sock *sk);
+int      homa_softirq(struct sk_buff *skb);
 void     homa_spin(int ns);
 void     homa_timer(struct homa *homa);
 void     homa_timer_check_rpc(struct homa_rpc *rpc);
@@ -415,7 +440,9 @@ int      homa_timer_main(void *transport);
 struct sk_buff *homa_tx_data_pkt_alloc(struct homa_rpc *rpc,
 				       struct iov_iter *iter, int offset,
 				       int length, int max_seg_data);
+void     homa_unhash(struct sock *sk);
 void     homa_rpc_unknown_pkt(struct sk_buff *skb, struct homa_rpc *rpc);
+void     homa_unload(void);
 int      homa_wait_private(struct homa_rpc *rpc, int nonblocking);
 struct homa_rpc *homa_wait_shared(struct homa_sock *hsk, int nonblocking);
 int      homa_xmit_control(enum homa_packet_type type, void *contents,
diff --git a/net/homa/homa_plumbing.c b/net/homa/homa_plumbing.c
new file mode 100644
index 000000000000..0825e1ef9a76
--- /dev/null
+++ b/net/homa/homa_plumbing.c
@@ -0,0 +1,1071 @@
+// SPDX-License-Identifier: BSD-2-Clause
+
+/* This file consists mostly of "glue" that hooks Homa into the rest of
+ * the Linux kernel. The guts of the protocol are in other files.
+ */
+
+#include "homa_impl.h"
+#include "homa_pacer.h"
+#include "homa_peer.h"
+#include "homa_pool.h"
+
+/* Identifier for retrieving Homa-specific data for a struct net. */
+unsigned int homa_net_id;
+
+/* This structure defines functions that allow Homa to be used as a
+ * pernet subsystem.
+ */
+static struct pernet_operations homa_net_ops = {
+	.init = homa_net_start,
+	.exit = homa_net_exit,
+	.id = &homa_net_id,
+	.size = sizeof(struct homa_net)
+};
+
+/* Global data for Homa. Never reference homa_data directly. Always use
+ * the global_homa variable instead (or, even better, a homa pointer
+ * stored in a struct or passed via a parameter); this allows overriding
+ * during unit tests.
+ */
+static struct homa homa_data;
+
+/* This variable contains the address of the statically-allocated struct homa
+ * used throughout Homa. This variable should almost never be used directly:
+ * it should be passed as a parameter to functions that need it. This
+ * variable is used only by a few functions called from Linux where there
+ * is no struct homa* available.
+ */
+struct homa *global_homa = &homa_data;
+
+/* This structure defines functions that handle various operations on
+ * Homa sockets. These functions are relatively generic: they are called
+ * to implement top-level system calls. Many of these operations can
+ * be implemented by PF_INET6 functions that are independent of the
+ * Homa protocol.
+ */
+static const struct proto_ops homa_proto_ops = {
+	.family		   = PF_INET,
+	.owner		   = THIS_MODULE,
+	.release	   = inet_release,
+	.bind		   = homa_bind,
+	.connect	   = inet_dgram_connect,
+	.socketpair	   = sock_no_socketpair,
+	.accept		   = sock_no_accept,
+	.getname	   = inet_getname,
+	.poll		   = homa_poll,
+	.ioctl		   = inet_ioctl,
+	.listen		   = sock_no_listen,
+	.shutdown	   = homa_shutdown,
+	.setsockopt	   = sock_common_setsockopt,
+	.getsockopt	   = sock_common_getsockopt,
+	.sendmsg	   = inet_sendmsg,
+	.recvmsg	   = inet_recvmsg,
+	.mmap		   = sock_no_mmap,
+	.set_peek_off	   = sk_set_peek_off,
+};
+
+static const struct proto_ops homav6_proto_ops = {
+	.family		   = PF_INET6,
+	.owner		   = THIS_MODULE,
+	.release	   = inet6_release,
+	.bind		   = homa_bind,
+	.connect	   = inet_dgram_connect,
+	.socketpair	   = sock_no_socketpair,
+	.accept		   = sock_no_accept,
+	.getname	   = inet6_getname,
+	.poll		   = homa_poll,
+	.ioctl		   = inet6_ioctl,
+	.listen		   = sock_no_listen,
+	.shutdown	   = homa_shutdown,
+	.setsockopt	   = sock_common_setsockopt,
+	.getsockopt	   = sock_common_getsockopt,
+	.sendmsg	   = inet_sendmsg,
+	.recvmsg	   = inet_recvmsg,
+	.mmap		   = sock_no_mmap,
+	.set_peek_off	   = sk_set_peek_off,
+};
+
+/* This structure also defines functions that handle various operations
+ * on Homa sockets. However, these functions are lower-level than those
+ * in homa_proto_ops: they are specific to the PF_INET or PF_INET6
+ * protocol family, and in many cases they are invoked by functions in
+ * homa_proto_ops. Most of these functions have Homa-specific implementations.
+ */
+static struct proto homa_prot = {
+	.name		   = "HOMA",
+	.owner		   = THIS_MODULE,
+	.close		   = homa_close,
+	.connect	   = ip4_datagram_connect,
+	.ioctl		   = homa_ioctl,
+	.init		   = homa_socket,
+	.destroy	   = NULL,
+	.setsockopt	   = homa_setsockopt,
+	.getsockopt	   = homa_getsockopt,
+	.sendmsg	   = homa_sendmsg,
+	.recvmsg	   = homa_recvmsg,
+	.hash		   = homa_hash,
+	.unhash		   = homa_unhash,
+	.obj_size	   = sizeof(struct homa_sock),
+	.no_autobind       = 1,
+};
+
+static struct proto homav6_prot = {
+	.name		   = "HOMAv6",
+	.owner		   = THIS_MODULE,
+	.close		   = homa_close,
+	.connect	   = ip6_datagram_connect,
+	.ioctl		   = homa_ioctl,
+	.init		   = homa_socket,
+	.destroy	   = NULL,
+	.setsockopt	   = homa_setsockopt,
+	.getsockopt	   = homa_getsockopt,
+	.sendmsg	   = homa_sendmsg,
+	.recvmsg	   = homa_recvmsg,
+	.hash		   = homa_hash,
+	.unhash		   = homa_unhash,
+	.obj_size	   = sizeof(struct homa_v6_sock),
+	.ipv6_pinfo_offset = offsetof(struct homa_v6_sock, inet6),
+
+	.no_autobind       = 1,
+};
+
+/* Top-level structure describing the Homa protocol. */
+static struct inet_protosw homa_protosw = {
+	.type              = SOCK_DGRAM,
+	.protocol          = IPPROTO_HOMA,
+	.prot              = &homa_prot,
+	.ops               = &homa_proto_ops,
+	.flags             = INET_PROTOSW_REUSE,
+};
+
+static struct inet_protosw homav6_protosw = {
+	.type              = SOCK_DGRAM,
+	.protocol          = IPPROTO_HOMA,
+	.prot              = &homav6_prot,
+	.ops               = &homav6_proto_ops,
+	.flags             = INET_PROTOSW_REUSE,
+};
+
+/* This structure is used by IP to deliver incoming Homa packets to us. */
+static struct net_protocol homa_protocol = {
+	.handler =	homa_softirq,
+	.err_handler =	homa_err_handler_v4,
+	.no_policy =     1,
+};
+
+static struct inet6_protocol homav6_protocol = {
+	.handler =	homa_softirq,
+	.err_handler =	homa_err_handler_v6,
+	.flags =        INET6_PROTO_NOPOLICY | INET6_PROTO_FINAL,
+};
+
+/* Sizes of the headers for each Homa packet type, in bytes. */
+static __u16 header_lengths[] = {
+	sizeof(struct homa_data_hdr),
+	0,
+	sizeof(struct homa_resend_hdr),
+	sizeof(struct homa_rpc_unknown_hdr),
+	sizeof(struct homa_busy_hdr),
+	0,
+	0,
+	sizeof(struct homa_need_ack_hdr),
+	sizeof(struct homa_ack_hdr)
+};
+
+/* Thread that runs timer code to detect lost packets and crashed peers. */
+static struct task_struct *timer_kthread;
+static DECLARE_COMPLETION(timer_thread_done);
+
+/* Used to wakeup timer_kthread at regular intervals. */
+static struct hrtimer hrtimer;
+
+/* Nonzero is an indication to the timer thread that it should exit. */
+static int timer_thread_exit;
+
+/**
+ * homa_load() - invoked when this module is loaded into the Linux kernel
+ * Return: 0 on success, otherwise a negative errno.
+ */
+int __init homa_load(void)
+{
+	struct homa *homa = global_homa;
+	int status;
+
+	/* Compile-time validations that no packet header is longer
+	 * than HOMA_MAX_HEADER.
+	 */
+	BUILD_BUG_ON(sizeof(struct homa_data_hdr) > HOMA_MAX_HEADER);
+	BUILD_BUG_ON(sizeof(struct homa_resend_hdr) > HOMA_MAX_HEADER);
+	BUILD_BUG_ON(sizeof(struct homa_rpc_unknown_hdr) > HOMA_MAX_HEADER);
+	BUILD_BUG_ON(sizeof(struct homa_busy_hdr) > HOMA_MAX_HEADER);
+	BUILD_BUG_ON(sizeof(struct homa_need_ack_hdr) > HOMA_MAX_HEADER);
+	BUILD_BUG_ON(sizeof(struct homa_ack_hdr) > HOMA_MAX_HEADER);
+
+	/* Extra constraints on data packets:
+	 * - Ensure minimum header length so Homa doesn't have to worry about
+	 *   padding data packets.
+	 * - Make sure data packet headers are a multiple of 4 bytes (needed
+	 *   for TCP/TSO compatibility).
+	 */
+	BUILD_BUG_ON(sizeof(struct homa_data_hdr) < HOMA_MIN_PKT_LENGTH);
+	BUILD_BUG_ON((sizeof(struct homa_data_hdr) -
+		      sizeof(struct homa_seg_hdr)) & 0x3);
+
+	/* Detect size changes in uAPI structs. */
+	BUILD_BUG_ON(sizeof(struct homa_sendmsg_args) != 24);
+	BUILD_BUG_ON(sizeof(struct homa_recvmsg_args) != 88);
+
+	pr_err("Homa module loading\n");
+	status = proto_register(&homa_prot, 1);
+	if (status != 0) {
+		pr_err("proto_register failed for homa_prot: %d\n", status);
+		goto proto_register_err;
+	}
+	status = proto_register(&homav6_prot, 1);
+	if (status != 0) {
+		pr_err("proto_register failed for homav6_prot: %d\n", status);
+		goto proto_register_v6_err;
+	}
+	inet_register_protosw(&homa_protosw);
+	status = inet6_register_protosw(&homav6_protosw);
+	if (status != 0) {
+		pr_err("inet6_register_protosw failed in %s: %d\n", __func__,
+		       status);
+		goto register_protosw_v6_err;
+	}
+	status = inet_add_protocol(&homa_protocol, IPPROTO_HOMA);
+	if (status != 0) {
+		pr_err("inet_add_protocol failed in %s: %d\n", __func__,
+		       status);
+		goto add_protocol_err;
+	}
+	status = inet6_add_protocol(&homav6_protocol, IPPROTO_HOMA);
+	if (status != 0) {
+		pr_err("inet6_add_protocol failed in %s: %d\n",  __func__,
+		       status);
+		goto add_protocol_v6_err;
+	}
+	status = homa_init(homa);
+	if (status)
+		goto homa_init_err;
+
+	status = register_pernet_subsys(&homa_net_ops);
+	if (status != 0) {
+		pr_err("Homa got error from register_pernet_subsys: %d\n",
+		       status);
+		goto net_err;
+	}
+	timer_kthread = kthread_run(homa_timer_main, homa, "homa_timer");
+	if (IS_ERR(timer_kthread)) {
+		status = PTR_ERR(timer_kthread);
+		pr_err("couldn't create Homa pacer thread: error %d\n",
+		       status);
+		timer_kthread = NULL;
+		goto timer_err;
+	}
+
+	return 0;
+
+timer_err:
+	unregister_pernet_subsys(&homa_net_ops);
+net_err:
+	homa_destroy(homa);
+homa_init_err:
+	inet6_del_protocol(&homav6_protocol, IPPROTO_HOMA);
+add_protocol_v6_err:
+	inet_del_protocol(&homa_protocol, IPPROTO_HOMA);
+add_protocol_err:
+	inet6_unregister_protosw(&homav6_protosw);
+register_protosw_v6_err:
+	inet_unregister_protosw(&homa_protosw);
+	proto_unregister(&homav6_prot);
+proto_register_v6_err:
+	proto_unregister(&homa_prot);
+proto_register_err:
+	return status;
+}
+
+/**
+ * homa_unload() - invoked when this module is unloaded from the Linux kernel.
+ */
+void __exit homa_unload(void)
+{
+	struct homa *homa = global_homa;
+
+	pr_notice("Homa module unloading\n");
+
+	unregister_pernet_subsys(&homa_net_ops);
+	homa_destroy(homa);
+	inet_del_protocol(&homa_protocol, IPPROTO_HOMA);
+	inet_unregister_protosw(&homa_protosw);
+	inet6_del_protocol(&homav6_protocol, IPPROTO_HOMA);
+	inet6_unregister_protosw(&homav6_protosw);
+	proto_unregister(&homa_prot);
+	proto_unregister(&homav6_prot);
+}
+
+module_init(homa_load);
+module_exit(homa_unload);
+
+/**
+ * homa_net_start() - Initialize Homa for a new network namespace.
+ * @net:    The net that Homa will be associated with.
+ * Return:  0 on success, otherwise a negative errno.
+ */
+int homa_net_start(struct net *net)
+{
+	pr_notice("Homa attaching to net namespace\n");
+	return homa_net_init(homa_net_from_net(net), net, global_homa);
+}
+
+/**
+ * homa_net_exit() - Perform Homa cleanup needed when a network namespace
+ * is destroyed.
+ * @net:    The net from which Homa should be removed.
+ */
+void homa_net_exit(struct net *net)
+{
+	pr_notice("Homa detaching from net namespace\n");
+	homa_net_destroy(homa_net_from_net(net));
+}
+
+/**
+ * homa_bind() - Implements the bind system call for Homa sockets: associates
+ * a well-known service port with a socket. Unlike other AF_INET6 protocols,
+ * there is no need to invoke this system call for sockets that are only
+ * used as clients.
+ * @sock:     Socket on which the system call was invoked.
+ * @addr:    Contains the desired port number.
+ * @addr_len: Number of bytes in uaddr.
+ * Return:    0 on success, otherwise a negative errno.
+ */
+int homa_bind(struct socket *sock, struct sockaddr *addr, int addr_len)
+{
+	union sockaddr_in_union *addr_in = (union sockaddr_in_union *)addr;
+	struct homa_sock *hsk = homa_sk(sock->sk);
+	int port = 0;
+
+	if (unlikely(addr->sa_family != sock->sk->sk_family))
+		return -EAFNOSUPPORT;
+	if (addr_in->in6.sin6_family == AF_INET6) {
+		if (addr_len < sizeof(struct sockaddr_in6))
+			return -EINVAL;
+		port = ntohs(addr_in->in4.sin_port);
+	} else if (addr_in->in4.sin_family == AF_INET) {
+		if (addr_len < sizeof(struct sockaddr_in))
+			return -EINVAL;
+		port = ntohs(addr_in->in6.sin6_port);
+	}
+	return homa_sock_bind(hsk->hnet, hsk, port);
+}
+
+/**
+ * homa_close() - Invoked when close system call is invoked on a Homa socket.
+ * @sk:      Socket being closed
+ * @timeout: ??
+ */
+void homa_close(struct sock *sk, long timeout)
+{
+	struct homa_sock *hsk = homa_sk(sk);
+
+	homa_sock_destroy(hsk);
+	sk_common_release(sk);
+}
+
+/**
+ * homa_shutdown() - Implements the shutdown system call for Homa sockets.
+ * @sock:    Socket to shut down.
+ * @how:     Ignored: for other sockets, can independently shut down
+ *           sending and receiving, but for Homa any shutdown will
+ *           shut down everything.
+ *
+ * Return: 0 on success, otherwise a negative errno.
+ */
+int homa_shutdown(struct socket *sock, int how)
+{
+	homa_sock_shutdown(homa_sk(sock->sk));
+	return 0;
+}
+
+/**
+ * homa_ioctl() - Implements the ioctl system call for Homa sockets.
+ * @sk:    Socket on which the system call was invoked.
+ * @cmd:   Identifier for a particular ioctl operation.
+ * @karg:  Operation-specific argument; typically the address of a block
+ *         of data in user address space.
+ *
+ * Return: 0 on success, otherwise a negative errno.
+ */
+int homa_ioctl(struct sock *sk, int cmd, int *karg)
+{
+	return -EINVAL;
+}
+
+/**
+ * homa_socket() - Implements the socket(2) system call for sockets.
+ * @sk:    Socket on which the system call was invoked. The non-Homa
+ *         parts have already been initialized.
+ *
+ * Return: always 0 (success).
+ */
+int homa_socket(struct sock *sk)
+{
+	struct homa_sock *hsk = homa_sk(sk);
+	int result;
+
+	result = homa_sock_init(hsk);
+	if (result != 0)
+		homa_sock_destroy(hsk);
+	return result;
+}
+
+/**
+ * homa_setsockopt() - Implements the getsockopt system call for Homa sockets.
+ * @sk:      Socket on which the system call was invoked.
+ * @level:   Level at which the operation should be handled; will always
+ *           be IPPROTO_HOMA.
+ * @optname: Identifies a particular setsockopt operation.
+ * @optval:  Address in user space of information about the option.
+ * @optlen:  Number of bytes of data at @optval.
+ * Return:   0 on success, otherwise a negative errno.
+ */
+int homa_setsockopt(struct sock *sk, int level, int optname,
+		    sockptr_t optval, unsigned int optlen)
+{
+	struct homa_sock *hsk = homa_sk(sk);
+	int ret;
+
+	if (level != IPPROTO_HOMA)
+		return -ENOPROTOOPT;
+
+	if (optname == SO_HOMA_RCVBUF) {
+		struct homa_rcvbuf_args args;
+
+		if (optlen != sizeof(struct homa_rcvbuf_args))
+			return -EINVAL;
+
+		if (copy_from_sockptr(&args, optval, optlen))
+			return -EFAULT;
+
+		/* Do a trivial test to make sure we can at least write the
+		 * first page of the region.
+		 */
+		if (copy_to_user(u64_to_user_ptr(args.start), &args,
+				 sizeof(args)))
+			return -EFAULT;
+
+		ret = homa_pool_set_region(hsk, u64_to_user_ptr(args.start),
+					   args.length);
+	} else if (optname == SO_HOMA_SERVER) {
+		int arg;
+
+		if (optlen != sizeof(arg))
+			return -EINVAL;
+
+		if (copy_from_sockptr(&arg, optval, optlen))
+			return -EFAULT;
+
+		if (arg)
+			hsk->is_server = true;
+		else
+			hsk->is_server = false;
+		ret = 0;
+	} else {
+		ret = -ENOPROTOOPT;
+	}
+	return ret;
+}
+
+/**
+ * homa_getsockopt() - Implements the getsockopt system call for Homa sockets.
+ * @sk:      Socket on which the system call was invoked.
+ * @level:   Selects level in the network stack to handle the request;
+ *           must be IPPROTO_HOMA.
+ * @optname: Identifies a particular setsockopt operation.
+ * @optval:  Address in user space where the option's value should be stored.
+ * @optlen:  Number of bytes available at optval; will be overwritten with
+ *           actual number of bytes stored.
+ * Return:   0 on success, otherwise a negative errno.
+ */
+int homa_getsockopt(struct sock *sk, int level, int optname,
+		    char __user *optval, int __user *optlen)
+{
+	struct homa_sock *hsk = homa_sk(sk);
+	struct homa_rcvbuf_args rcvbuf_args;
+	void *result;
+	int is_server;
+	int len;
+
+	if (copy_from_sockptr(&len, USER_SOCKPTR(optlen), sizeof(int)))
+		return -EFAULT;
+
+	if (level != IPPROTO_HOMA)
+		return -ENOPROTOOPT;
+	if (optname == SO_HOMA_RCVBUF) {
+		if (len < sizeof(rcvbuf_args))
+			return -EINVAL;
+
+		homa_sock_lock(hsk);
+		homa_pool_get_rcvbuf(hsk->buffer_pool, &rcvbuf_args);
+		homa_sock_unlock(hsk);
+		len = sizeof(rcvbuf_args);
+		result = &rcvbuf_args;
+	} else if (optname == SO_HOMA_SERVER) {
+		if (len < sizeof(is_server))
+			return -EINVAL;
+
+		is_server = hsk->is_server;
+		len = sizeof(is_server);
+		result = &is_server;
+	} else {
+		return -ENOPROTOOPT;
+	}
+
+	if (copy_to_sockptr(USER_SOCKPTR(optlen), &len, sizeof(int)))
+		return -EFAULT;
+
+	if (copy_to_sockptr(USER_SOCKPTR(optval), result, len))
+		return -EFAULT;
+
+	return 0;
+}
+
+/**
+ * homa_sendmsg() - Send a request or response message on a Homa socket.
+ * @sk:     Socket on which the system call was invoked.
+ * @msg:    Structure describing the message to send; the msg_control
+ *          field points to additional information.
+ * @length: Number of bytes of the message.
+ * Return: 0 on success, otherwise a negative errno.
+ */
+int homa_sendmsg(struct sock *sk, struct msghdr *msg, size_t length)
+{
+	struct homa_sock *hsk = homa_sk(sk);
+	struct homa_sendmsg_args args;
+	union sockaddr_in_union *addr;
+	struct homa_rpc *rpc = NULL;
+	int result = 0;
+
+	addr = (union sockaddr_in_union *)msg->msg_name;
+	if (!addr) {
+		result = -EINVAL;
+		goto error;
+	}
+
+	if (unlikely(!msg->msg_control_is_user)) {
+		result = -EINVAL;
+		goto error;
+	}
+	if (unlikely(copy_from_user(&args, (void __user *)msg->msg_control,
+				    sizeof(args)))) {
+		result = -EFAULT;
+		goto error;
+	}
+	if (args.flags & ~HOMA_SENDMSG_VALID_FLAGS ||
+	    args.reserved != 0) {
+		result = -EINVAL;
+		goto error;
+	}
+
+	if (!homa_sock_wmem_avl(hsk)) {
+		result = homa_sock_wait_wmem(hsk,
+					     msg->msg_flags & MSG_DONTWAIT);
+		if (result != 0)
+			goto error;
+	}
+
+	if (addr->sa.sa_family != sk->sk_family) {
+		result = -EAFNOSUPPORT;
+		goto error;
+	}
+	if (msg->msg_namelen < sizeof(struct sockaddr_in) ||
+	    (msg->msg_namelen < sizeof(struct sockaddr_in6) &&
+	     addr->in6.sin6_family == AF_INET6)) {
+		result = -EINVAL;
+		goto error;
+	}
+
+	if (!args.id) {
+		/* This is a request message. */
+		rpc = homa_rpc_alloc_client(hsk, addr);
+		if (IS_ERR(rpc)) {
+			result = PTR_ERR(rpc);
+			rpc = NULL;
+			goto error;
+		}
+		if (args.flags & HOMA_SENDMSG_PRIVATE)
+			atomic_or(RPC_PRIVATE, &rpc->flags);
+		rpc->completion_cookie = args.completion_cookie;
+		result = homa_message_out_fill(rpc, &msg->msg_iter, 1);
+		if (result)
+			goto error;
+		args.id = rpc->id;
+		homa_rpc_unlock(rpc); /* Locked by homa_rpc_alloc_client. */
+		rpc = NULL;
+
+		if (unlikely(copy_to_user((void __user *)msg->msg_control,
+					  &args, sizeof(args)))) {
+			rpc = homa_rpc_find_client(hsk, args.id);
+			result = -EFAULT;
+			goto error;
+		}
+	} else {
+		/* This is a response message. */
+		struct in6_addr canonical_dest;
+
+		if (args.completion_cookie != 0) {
+			result = -EINVAL;
+			goto error;
+		}
+		canonical_dest = canonical_ipv6_addr(addr);
+
+		rpc = homa_rpc_find_server(hsk, &canonical_dest, args.id);
+		if (!rpc)
+			/* Return without an error if the RPC doesn't exist;
+			 * this could be totally valid (e.g. client is
+			 * no longer interested in it).
+			 */
+			return 0;
+		if (rpc->error) {
+			result = rpc->error;
+			goto error;
+		}
+		if (rpc->state != RPC_IN_SERVICE) {
+			/* Locked by homa_rpc_find_server. */
+			homa_rpc_unlock(rpc);
+			rpc = NULL;
+			result = -EINVAL;
+			goto error;
+		}
+		rpc->state = RPC_OUTGOING;
+
+		result = homa_message_out_fill(rpc, &msg->msg_iter, 1);
+		if (result && rpc->state != RPC_DEAD)
+			goto error;
+		homa_rpc_unlock(rpc); /* Locked by homa_rpc_find_server. */
+	}
+	return 0;
+
+error:
+	if (rpc) {
+		homa_rpc_end(rpc);
+		homa_rpc_unlock(rpc); /* Locked by homa_rpc_find_server. */
+	}
+	return result;
+}
+
+/**
+ * homa_recvmsg() - Receive a message from a Homa socket.
+ * @sk:          Socket on which the system call was invoked.
+ * @msg:         Controlling information for the receive.
+ * @len:         Total bytes of space available in msg->msg_iov; not used.
+ * @flags:       Flags from system call; only MSG_DONTWAIT is used.
+ * @addr_len:    Store the length of the sender address here
+ * Return:       The length of the message on success, otherwise a negative
+ *               errno.
+ */
+int homa_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags,
+		 int *addr_len)
+{
+	struct homa_sock *hsk = homa_sk(sk);
+	struct homa_recvmsg_args control;
+	struct homa_rpc *rpc;
+	int nonblocking;
+	int result;
+
+	if (unlikely(!msg->msg_control)) {
+		/* This test isn't strictly necessary, but it provides a
+		 * hook for testing kernel call times.
+		 */
+		return -EINVAL;
+	}
+	if (msg->msg_controllen != sizeof(control))
+		return -EINVAL;
+	if (unlikely(copy_from_user(&control, (void __user *)msg->msg_control,
+				    sizeof(control))))
+		return -EFAULT;
+	control.completion_cookie = 0;
+
+	if (control.num_bpages > HOMA_MAX_BPAGES) {
+		result = -EINVAL;
+		goto done;
+	}
+	if (!hsk->buffer_pool) {
+		result = -EINVAL;
+		goto done;
+	}
+	result = homa_pool_release_buffers(hsk->buffer_pool, control.num_bpages,
+					   control.bpage_offsets);
+	control.num_bpages = 0;
+	if (result != 0)
+		goto done;
+
+	nonblocking = flags & MSG_DONTWAIT;
+	if (control.id != 0) {
+		rpc = homa_rpc_find_client(hsk, control.id); /* Locks RPC. */
+		if (!rpc) {
+			result = -EINVAL;
+			goto done;
+		}
+		result = homa_wait_private(rpc, nonblocking);
+		if (result != 0) {
+			homa_rpc_unlock(rpc);
+			control.id = 0;
+			goto done;
+		}
+	} else {
+		rpc = homa_wait_shared(hsk, nonblocking);
+		if (IS_ERR(rpc)) {
+			/* If we get here, it means there was an error that
+			 * prevented us from finding an RPC to return. Errors
+			 * in the RPC itself are handled below.
+			 */
+			result = PTR_ERR(rpc);
+			goto done;
+		}
+	}
+	result = rpc->error ? rpc->error : rpc->msgin.length;
+
+	/* Collect result information. */
+	control.id = rpc->id;
+	control.completion_cookie = rpc->completion_cookie;
+	if (likely(rpc->msgin.length >= 0)) {
+		control.num_bpages = rpc->msgin.num_bpages;
+		memcpy(control.bpage_offsets, rpc->msgin.bpage_offsets,
+		       sizeof(rpc->msgin.bpage_offsets));
+	}
+	if (sk->sk_family == AF_INET6) {
+		struct sockaddr_in6 *in6 = msg->msg_name;
+
+		in6->sin6_family = AF_INET6;
+		in6->sin6_port = htons(rpc->dport);
+		in6->sin6_addr = rpc->peer->addr;
+		*addr_len = sizeof(*in6);
+	} else {
+		struct sockaddr_in *in4 = msg->msg_name;
+
+		in4->sin_family = AF_INET;
+		in4->sin_port = htons(rpc->dport);
+		in4->sin_addr.s_addr = ipv6_to_ipv4(rpc->peer->addr);
+		*addr_len = sizeof(*in4);
+	}
+
+	/* This indicates that the application now owns the buffers, so
+	 * we won't free them in homa_rpc_end.
+	 */
+	rpc->msgin.num_bpages = 0;
+
+	/* Must release the RPC lock (and potentially free the RPC) before
+	 * copying the results back to user space.
+	 */
+	if (homa_is_client(rpc->id)) {
+		homa_peer_add_ack(rpc);
+		homa_rpc_end(rpc);
+	} else {
+		if (result < 0)
+			homa_rpc_end(rpc);
+		else
+			rpc->state = RPC_IN_SERVICE;
+	}
+	homa_rpc_unlock(rpc); /* Locked by homa_wait_shared/private. */
+
+	if (test_bit(SOCK_NOSPACE, &hsk->sock.sk_socket->flags)) {
+		/* There are tasks waiting for tx memory, so reap
+		 * immediately.
+		 */
+		homa_rpc_reap(hsk, true);
+	}
+
+done:
+	if (unlikely(copy_to_user((__force void __user *)msg->msg_control,
+				  &control, sizeof(control))))
+		result = -EFAULT;
+
+	return result;
+}
+
+/**
+ * homa_hash() - Not needed for Homa.
+ * @sk:    Socket for the operation
+ * Return: ??
+ */
+int homa_hash(struct sock *sk)
+{
+	return 0;
+}
+
+/**
+ * homa_unhash() - Not needed for Homa.
+ * @sk:    Socket for the operation
+ */
+void homa_unhash(struct sock *sk)
+{
+}
+
+/**
+ * homa_softirq() - This function is invoked at SoftIRQ level to handle
+ * incoming packets.
+ * @skb:   The incoming packet.
+ * Return: Always 0
+ */
+int homa_softirq(struct sk_buff *skb)
+{
+	struct sk_buff *packets, *other_pkts, *next;
+	struct sk_buff **prev_link, **other_link;
+	struct homa_common_hdr *h;
+	int header_offset;
+
+	/* skb may actually contain many distinct packets, linked through
+	 * skb_shinfo(skb)->frag_list by the Homa GRO mechanism. Make a
+	 * pass through the list to process all of the short packets,
+	 * leaving the longer packets in the list. Also, perform various
+	 * prep/cleanup/error checking functions.
+	 */
+	skb->next = skb_shinfo(skb)->frag_list;
+	skb_shinfo(skb)->frag_list = NULL;
+	packets = skb;
+	prev_link = &packets;
+	for (skb = packets; skb; skb = next) {
+		next = skb->next;
+
+		/* Make the header available at skb->data, even if the packet
+		 * is fragmented. One complication: it's possible that the IP
+		 * header hasn't yet been removed (this happens for GRO packets
+		 * on the frag_list, since they aren't handled explicitly by IP.
+		 */
+		if (!homa_make_header_avl(skb))
+			goto discard;
+		header_offset = skb_transport_header(skb) - skb->data;
+		if (header_offset)
+			__skb_pull(skb, header_offset);
+
+		/* Reject packets that are too short or have bogus types. */
+		h = (struct homa_common_hdr *)skb->data;
+		if (unlikely(skb->len < sizeof(struct homa_common_hdr) ||
+			     h->type < DATA || h->type > MAX_OP ||
+			     skb->len < header_lengths[h->type - DATA]))
+			goto discard;
+
+		/* Process the packet now if it is a control packet or
+		 * if it contains an entire short message.
+		 */
+		if (h->type != DATA || ntohl(((struct homa_data_hdr *)h)
+				->message_length) < 1400) {
+			*prev_link = skb->next;
+			skb->next = NULL;
+			homa_dispatch_pkts(skb);
+		} else {
+			prev_link = &skb->next;
+		}
+		continue;
+
+discard:
+		*prev_link = skb->next;
+		kfree_skb(skb);
+	}
+
+	/* Now process the longer packets. Each iteration of this loop
+	 * collects all of the packets for a particular RPC and dispatches
+	 * them (batching the packets for an RPC allows more efficient
+	 * generation of grants).
+	 */
+	while (packets) {
+		struct in6_addr saddr, saddr2;
+		struct homa_common_hdr *h2;
+		struct sk_buff *skb2;
+
+		skb = packets;
+		prev_link = &skb->next;
+		saddr = skb_canonical_ipv6_saddr(skb);
+		other_pkts = NULL;
+		other_link = &other_pkts;
+		h = (struct homa_common_hdr *)skb->data;
+		for (skb2 = skb->next; skb2; skb2 = next) {
+			next = skb2->next;
+			h2 = (struct homa_common_hdr *)skb2->data;
+			if (h2->sender_id == h->sender_id) {
+				saddr2 = skb_canonical_ipv6_saddr(skb2);
+				if (ipv6_addr_equal(&saddr, &saddr2)) {
+					*prev_link = skb2;
+					prev_link = &skb2->next;
+					continue;
+				}
+			}
+			*other_link = skb2;
+			other_link = &skb2->next;
+		}
+		*prev_link = NULL;
+		*other_link = NULL;
+		homa_dispatch_pkts(packets);
+		packets = other_pkts;
+	}
+
+	return 0;
+}
+
+/**
+ * homa_err_handler_v4() - Invoked by IP to handle an incoming error
+ * packet, such as ICMP UNREACHABLE.
+ * @skb:   The incoming packet.
+ * @info:  Information about the error that occurred?
+ *
+ * Return: zero, or a negative errno if the error couldn't be handled here.
+ */
+int homa_err_handler_v4(struct sk_buff *skb, u32 info)
+{
+	const struct icmphdr *icmp = icmp_hdr(skb);
+	struct homa *homa = homa_from_skb(skb);
+	struct in6_addr daddr;
+	int type = icmp->type;
+	int code = icmp->code;
+	struct iphdr *iph;
+	int error = 0;
+	int port = 0;
+
+	iph = (struct iphdr *)(skb->data);
+	ipv6_addr_set_v4mapped(iph->daddr, &daddr);
+	if (type == ICMP_DEST_UNREACH && code == ICMP_PORT_UNREACH) {
+		struct homa_common_hdr *h = (struct homa_common_hdr *)(skb->data
+				+ iph->ihl * 4);
+
+		port = ntohs(h->dport);
+		error = -ENOTCONN;
+	} else if (type == ICMP_DEST_UNREACH) {
+		if (code == ICMP_PROT_UNREACH)
+			error = -EPROTONOSUPPORT;
+		else
+			error = -EHOSTUNREACH;
+	} else {
+		pr_notice("%s invoked with info %x, ICMP type %d, ICMP code %d\n",
+			  __func__, info, type, code);
+	}
+	if (error != 0)
+		homa_abort_rpcs(homa, &daddr, port, error);
+	return 0;
+}
+
+/**
+ * homa_err_handler_v6() - Invoked by IP to handle an incoming error
+ * packet, such as ICMP UNREACHABLE.
+ * @skb:    The incoming packet.
+ * @opt:    Not used.
+ * @type:   Type of ICMP packet.
+ * @code:   Additional information about the error.
+ * @offset: Not used.
+ * @info:   Information about the error that occurred?
+ *
+ * Return: zero, or a negative errno if the error couldn't be handled here.
+ */
+int homa_err_handler_v6(struct sk_buff *skb, struct inet6_skb_parm *opt,
+			u8 type,  u8 code,  int offset,  __be32 info)
+{
+	const struct ipv6hdr *iph = (const struct ipv6hdr *)skb->data;
+	struct homa *homa = homa_from_skb(skb);
+	int error = 0;
+	int port = 0;
+
+	if (type == ICMPV6_DEST_UNREACH && code == ICMPV6_PORT_UNREACH) {
+		const struct homa_common_hdr *h;
+
+		h = (struct homa_common_hdr *)(skb->data + sizeof(*iph));
+		port = ntohs(h->dport);
+		error = -ENOTCONN;
+	} else if (type == ICMPV6_DEST_UNREACH && code == ICMPV6_ADDR_UNREACH) {
+		error = -EHOSTUNREACH;
+	} else if (type == ICMPV6_PARAMPROB && code == ICMPV6_UNK_NEXTHDR) {
+		error = -EPROTONOSUPPORT;
+	}
+	if (error != 0)
+		homa_abort_rpcs(homa, &iph->daddr, port, error);
+	return 0;
+}
+
+/**
+ * homa_poll() - Invoked by Linux as part of implementing select, poll,
+ * epoll, etc.
+ * @file:  Open file that is participating in a poll, select, etc.
+ * @sock:  A Homa socket, associated with @file.
+ * @wait:  This table will be registered with the socket, so that it
+ *         is notified when the socket's ready state changes.
+ *
+ * Return: A mask of bits such as EPOLLIN, which indicate the current
+ *         state of the socket.
+ */
+__poll_t homa_poll(struct file *file, struct socket *sock,
+		   struct poll_table_struct *wait)
+{
+	struct homa_sock *hsk = homa_sk(sock->sk);
+	__poll_t mask;
+
+	mask = 0;
+	sock_poll_wait(file, sock, wait);
+	if (homa_sock_wmem_avl(hsk))
+		mask |= EPOLLOUT | EPOLLWRNORM;
+	else
+		set_bit(SOCK_NOSPACE, &hsk->sock.sk_socket->flags);
+
+	if (hsk->shutdown)
+		mask |= EPOLLIN;
+
+	if (!list_empty(&hsk->ready_rpcs))
+		mask |= EPOLLIN | EPOLLRDNORM;
+	return mask;
+}
+
+/**
+ * homa_hrtimer() - This function is invoked by the hrtimer mechanism to
+ * wake up the timer thread. Runs at IRQ level.
+ * @timer:   The timer that triggered; not used.
+ *
+ * Return:   Always HRTIMER_RESTART.
+ */
+enum hrtimer_restart homa_hrtimer(struct hrtimer *timer)
+{
+	wake_up_process(timer_kthread);
+	return HRTIMER_NORESTART;
+}
+
+/**
+ * homa_timer_main() - Top-level function for the timer thread.
+ * @transport:  Pointer to struct homa.
+ *
+ * Return:         Always 0.
+ */
+int homa_timer_main(void *transport)
+{
+	struct homa *homa = (struct homa *)transport;
+	ktime_t tick_interval;
+	u64 nsec;
+
+	hrtimer_setup(&hrtimer, homa_hrtimer, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
+	nsec = 1000000;                   /* 1 ms */
+	tick_interval = ns_to_ktime(nsec);
+	while (1) {
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		if (!timer_thread_exit) {
+			hrtimer_start(&hrtimer, tick_interval,
+				      HRTIMER_MODE_REL);
+			schedule();
+		}
+		__set_current_state(TASK_RUNNING);
+		if (timer_thread_exit)
+			break;
+		homa_timer(homa);
+	}
+	hrtimer_cancel(&hrtimer);
+	kthread_complete_and_exit(&timer_thread_done, 0);
+	return 0;
+}
+
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_AUTHOR("John Ousterhout <ouster@cs.stanford.edu>");
+MODULE_DESCRIPTION("Homa transport protocol");
+MODULE_VERSION("1.0");
+
+/* Arrange for this module to be loaded automatically when a Homa socket is
+ * opened. Apparently symbols don't work in the macros below, so must use
+ * numeric values for IPPROTO_HOMA (146) and SOCK_DGRAM(2).
+ */
+MODULE_ALIAS_NET_PF_PROTO_TYPE(PF_INET, 146, 2);
+MODULE_ALIAS_NET_PF_PROTO_TYPE(PF_INET6, 146, 2);
-- 
2.43.0


