Return-Path: <netdev+bounces-175584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A90D6A667D0
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 04:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 011E3164809
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 03:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B427185B4C;
	Tue, 18 Mar 2025 03:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="D+/u4n8d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A1A15B554
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 03:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742269843; cv=none; b=o+n65wPzZThGMEuk1XvVJlQXbIcfULjtXl27ROUXCb/td2e2Qm3MyqG2/5UkWdkjXh6uZIhL95RgXtjfER5+TML9WUYc0RnZWnTTneLyYnWFiRhzm9NEmz5ffpyBWv1mNRVMAnQ5L5C+lzP7BEwDDdIReuUZdyqHRVb7IysFpj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742269843; c=relaxed/simple;
	bh=9/YczA+5fdPmoKSSJaQ/C7CkILXFP6KFFQij3phiTNw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IpuGYegBsuCME4Y/geLsHft8cbh5WMH0cQtWu32MWsL3HL9AXIYZd84hZpJMYArIQ+xq8HTCy30dh2QZQHM3Hfp89RogRd+LJLTzvedsXCEBpnK4gQOO0/78NWu7W/8lLef0hyUVyNtNTQ6sNrWPw3qDMRvUDjGOt8+o2Sqsucs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=D+/u4n8d; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742269842; x=1773805842;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CQVBWGEyQJrSVYtaKncanOCytSsNrmEHkLoRjsX3sUw=;
  b=D+/u4n8dIRU3nUBEnSWTPOH7pSYV3BWG8vvoH0APQmiYmGElf/Dn+ifr
   Q6X32PYMs9hVhIxFFgMxw9yTkT/hfVwrODi3woxnm7zBePJxJyOgE9gEs
   ims9CZOS5fdZDhATI8WtcneqQ2yFpisp2Ysdn+NopEw00FTuM/aeKajMf
   M=;
X-IronPort-AV: E=Sophos;i="6.14,255,1736812800"; 
   d="scan'208";a="387548331"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 03:50:40 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:21480]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.127:2525] with esmtp (Farcaster)
 id c974e175-0df1-49b2-8311-f43287835b80; Tue, 18 Mar 2025 03:50:39 +0000 (UTC)
X-Farcaster-Flow-ID: c974e175-0df1-49b2-8311-f43287835b80
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 18 Mar 2025 03:50:39 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.54) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 18 Mar 2025 03:50:36 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 2/4] af_unix: Move internal definitions to net/unix/.
Date: Mon, 17 Mar 2025 20:48:49 -0700
Message-ID: <20250318034934.86708-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250318034934.86708-1-kuniyu@amazon.com>
References: <20250318034934.86708-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

net/af_unix.h is included by core and some LSMs, but most definitions
need not be.

Let's move struct unix_{vertex,edge} to net/unix/garbage.c and other
definitions to net/unix/af_unix.h.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/af_unix.h      | 76 +-------------------------------------
 net/unix/af_unix.c         |  2 +
 net/unix/af_unix.h         | 75 +++++++++++++++++++++++++++++++++++++
 net/unix/diag.c            |  2 +
 net/unix/garbage.c         | 18 +++++++++
 net/unix/sysctl_net_unix.c |  2 +
 net/unix/unix_bpf.c        |  2 +
 7 files changed, 102 insertions(+), 75 deletions(-)
 create mode 100644 net/unix/af_unix.h

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index c8dfdb41916d..b5d70baba52b 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -17,61 +17,17 @@ static inline struct unix_sock *unix_get_socket(struct file *filp)
 }
 #endif
 
-extern unsigned int unix_tot_inflight;
-void unix_add_edges(struct scm_fp_list *fpl, struct unix_sock *receiver);
-void unix_del_edges(struct scm_fp_list *fpl);
-void unix_update_edges(struct unix_sock *receiver);
-int unix_prepare_fpl(struct scm_fp_list *fpl);
-void unix_destroy_fpl(struct scm_fp_list *fpl);
-void unix_gc(void);
-void wait_for_unix_gc(struct scm_fp_list *fpl);
-
-struct unix_vertex {
-	struct list_head edges;
-	struct list_head entry;
-	struct list_head scc_entry;
-	unsigned long out_degree;
-	unsigned long index;
-	unsigned long scc_index;
-};
-
-struct unix_edge {
-	struct unix_sock *predecessor;
-	struct unix_sock *successor;
-	struct list_head vertex_entry;
-	struct list_head stack_entry;
-};
-
-struct sock *unix_peer_get(struct sock *sk);
-
-#define UNIX_HASH_MOD	(256 - 1)
-#define UNIX_HASH_SIZE	(256 * 2)
-#define UNIX_HASH_BITS	8
-
 struct unix_address {
 	refcount_t	refcnt;
 	int		len;
 	struct sockaddr_un name[];
 };
 
-struct unix_skb_parms {
-	struct pid		*pid;		/* Skb credentials	*/
-	kuid_t			uid;
-	kgid_t			gid;
-	struct scm_fp_list	*fp;		/* Passed files		*/
-#ifdef CONFIG_SECURITY_NETWORK
-	u32			secid;		/* Security ID		*/
-#endif
-	u32			consumed;
-} __randomize_layout;
-
 struct scm_stat {
 	atomic_t nr_fds;
 	unsigned long nr_unix_fds;
 };
 
-#define UNIXCB(skb)	(*(struct unix_skb_parms *)&((skb)->cb))
-
 /* The AF_UNIX socket */
 struct unix_sock {
 	/* WARNING: sk has to be the first member */
@@ -84,6 +40,7 @@ struct unix_sock {
 	struct unix_vertex	*vertex;
 	spinlock_t		lock;
 	struct socket_wq	peer_wq;
+#define peer_wait		peer_wq.wait
 	wait_queue_entry_t	peer_wake;
 	struct scm_stat		scm_stat;
 #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
@@ -94,35 +51,4 @@ struct unix_sock {
 #define unix_sk(ptr) container_of_const(ptr, struct unix_sock, sk)
 #define unix_peer(sk) (unix_sk(sk)->peer)
 
-#define unix_state_lock(s)	spin_lock(&unix_sk(s)->lock)
-#define unix_state_unlock(s)	spin_unlock(&unix_sk(s)->lock)
-
-#define peer_wait peer_wq.wait
-
-long unix_inq_len(struct sock *sk);
-long unix_outq_len(struct sock *sk);
-
-int __unix_dgram_recvmsg(struct sock *sk, struct msghdr *msg, size_t size,
-			 int flags);
-int __unix_stream_recvmsg(struct sock *sk, struct msghdr *msg, size_t size,
-			  int flags);
-#ifdef CONFIG_SYSCTL
-int unix_sysctl_register(struct net *net);
-void unix_sysctl_unregister(struct net *net);
-#else
-static inline int unix_sysctl_register(struct net *net) { return 0; }
-static inline void unix_sysctl_unregister(struct net *net) {}
-#endif
-
-#ifdef CONFIG_BPF_SYSCALL
-extern struct proto unix_dgram_proto;
-extern struct proto unix_stream_proto;
-
-int unix_dgram_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore);
-int unix_stream_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore);
-void __init unix_bpf_build_proto(void);
-#else
-static inline void __init unix_bpf_build_proto(void)
-{}
-#endif
 #endif
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 1ff0ac99f3f3..6390e04fe916 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -118,6 +118,8 @@
 #include <net/sock.h>
 #include <net/tcp_states.h>
 
+#include "af_unix.h"
+
 static atomic_long_t unix_nr_socks;
 static struct hlist_head bsd_socket_buckets[UNIX_HASH_SIZE / 2];
 static spinlock_t bsd_socket_locks[UNIX_HASH_SIZE / 2];
diff --git a/net/unix/af_unix.h b/net/unix/af_unix.h
new file mode 100644
index 000000000000..ed4aedc42813
--- /dev/null
+++ b/net/unix/af_unix.h
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __AF_UNIX_H
+#define __AF_UNIX_H
+
+#include <linux/uidgid.h>
+
+#define UNIX_HASH_MOD	(256 - 1)
+#define UNIX_HASH_SIZE	(256 * 2)
+#define UNIX_HASH_BITS	8
+
+#define unix_state_lock(s)	spin_lock(&unix_sk(s)->lock)
+#define unix_state_unlock(s)	spin_unlock(&unix_sk(s)->lock)
+
+struct sock *unix_peer_get(struct sock *sk);
+
+struct unix_skb_parms {
+	struct pid		*pid;		/* skb credentials	*/
+	kuid_t			uid;
+	kgid_t			gid;
+	struct scm_fp_list	*fp;		/* Passed files		*/
+#ifdef CONFIG_SECURITY_NETWORK
+	u32			secid;		/* Security ID		*/
+#endif
+	u32			consumed;
+} __randomize_layout;
+
+#define UNIXCB(skb)	(*(struct unix_skb_parms *)&((skb)->cb))
+
+/* GC for SCM_RIGHTS */
+extern unsigned int unix_tot_inflight;
+void unix_add_edges(struct scm_fp_list *fpl, struct unix_sock *receiver);
+void unix_del_edges(struct scm_fp_list *fpl);
+void unix_update_edges(struct unix_sock *receiver);
+int unix_prepare_fpl(struct scm_fp_list *fpl);
+void unix_destroy_fpl(struct scm_fp_list *fpl);
+void unix_gc(void);
+void wait_for_unix_gc(struct scm_fp_list *fpl);
+
+/* SOCK_DIAG */
+long unix_inq_len(struct sock *sk);
+long unix_outq_len(struct sock *sk);
+
+/* sysctl */
+#ifdef CONFIG_SYSCTL
+int unix_sysctl_register(struct net *net);
+void unix_sysctl_unregister(struct net *net);
+#else
+static inline int unix_sysctl_register(struct net *net)
+{
+	return 0;
+}
+
+static inline void unix_sysctl_unregister(struct net *net)
+{
+}
+#endif
+
+/* BPF SOCKMAP */
+int __unix_dgram_recvmsg(struct sock *sk, struct msghdr *msg, size_t size, int flags);
+int __unix_stream_recvmsg(struct sock *sk, struct msghdr *msg, size_t size, int flags);
+
+#ifdef CONFIG_BPF_SYSCALL
+extern struct proto unix_dgram_proto;
+extern struct proto unix_stream_proto;
+
+int unix_dgram_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore);
+int unix_stream_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore);
+void __init unix_bpf_build_proto(void);
+#else
+static inline void __init unix_bpf_build_proto(void)
+{
+}
+#endif
+
+#endif
diff --git a/net/unix/diag.c b/net/unix/diag.c
index ba715507556a..c7e8c7d008f6 100644
--- a/net/unix/diag.c
+++ b/net/unix/diag.c
@@ -12,6 +12,8 @@
 #include <net/sock.h>
 #include <net/tcp_states.h>
 
+#include "af_unix.h"
+
 static int sk_diag_dump_name(struct sock *sk, struct sk_buff *nlskb)
 {
 	/* might or might not have a hash table lock */
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 6a641d4b5542..8c8c7360349d 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -80,6 +80,24 @@
 #include <net/sock.h>
 #include <net/tcp_states.h>
 
+#include "af_unix.h"
+
+struct unix_vertex {
+	struct list_head edges;
+	struct list_head entry;
+	struct list_head scc_entry;
+	unsigned long out_degree;
+	unsigned long index;
+	unsigned long scc_index;
+};
+
+struct unix_edge {
+	struct unix_sock *predecessor;
+	struct unix_sock *successor;
+	struct list_head vertex_entry;
+	struct list_head stack_entry;
+};
+
 struct unix_sock *unix_get_socket(struct file *filp)
 {
 	struct inode *inode = file_inode(filp);
diff --git a/net/unix/sysctl_net_unix.c b/net/unix/sysctl_net_unix.c
index 55118ae897d6..236b7faa9254 100644
--- a/net/unix/sysctl_net_unix.c
+++ b/net/unix/sysctl_net_unix.c
@@ -10,6 +10,8 @@
 #include <linux/sysctl.h>
 #include <net/af_unix.h>
 
+#include "af_unix.h"
+
 static struct ctl_table unix_table[] = {
 	{
 		.procname	= "max_dgram_qlen",
diff --git a/net/unix/unix_bpf.c b/net/unix/unix_bpf.c
index 86598a959eaa..979dd4c4261a 100644
--- a/net/unix/unix_bpf.c
+++ b/net/unix/unix_bpf.c
@@ -6,6 +6,8 @@
 #include <net/af_unix.h>
 #include <net/sock.h>
 
+#include "af_unix.h"
+
 #define unix_sk_has_data(__sk, __psock)					\
 		({	!skb_queue_empty(&__sk->sk_receive_queue) ||	\
 			!skb_queue_empty(&__psock->ingress_skb) ||	\
-- 
2.48.1


