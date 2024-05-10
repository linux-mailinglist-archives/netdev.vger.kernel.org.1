Return-Path: <netdev+bounces-95264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C45A38C1CB1
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 05:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7981F280CE0
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 03:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF25148FF9;
	Fri, 10 May 2024 03:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XSyFojcd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F56148FED
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 03:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715310286; cv=none; b=iK0ec//M0Z/ArBc19IGkab6YtwC0aqXx5y45zSXwYJtGn88gqaFQonJLlXpOoohp9VrCxwQ9WYKli7/aj5rNVzRQ6sbMrla082VWB1EZN8hee69jgfxgpQWnhl4YMSQMCFdNDfIOnyFRDD7rvL9k0MdfgA6LUsEFwBHwDQcBqzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715310286; c=relaxed/simple;
	bh=DvCxHVlyFlhacfr5ZL0+wOC0lydStxwkNZBk+8RHov8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YNtWVNEDK4dLdeHPShBI32NJul3e5ML69dn87wRPA/Xs/dIx1XGB9hCBJGj66zIAf9DNSaNDvMpXd8yFKUIx21cHxrgGvp7scAGaZ4pZmRKtGjk4f0b5B/aNLTw7zXfXk9aAAf6oU87PVvno7jrm12kxw4u33TExp2cjfbSUhzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XSyFojcd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34421C2BBFC;
	Fri, 10 May 2024 03:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715310286;
	bh=DvCxHVlyFlhacfr5ZL0+wOC0lydStxwkNZBk+8RHov8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XSyFojcdBNkO/C0reChayv+xVLhFOG5t4FyLSy1HNCT4hC3OLHDsG94niMDhkdu3N
	 tQCCA7gELyHHK8Lrj4pR0Zwpwg6ZdM1M/OwzU6DUdEGCdz4z6hQMtvTj6r9PmOfzCa
	 rNhiFCkBPoiH/4jZiiWXqY1yJkyUTmr2dlIllun/qKfGrSB8FWs4x5BtQgnAkY2YiP
	 qJqHjSBgc/AWfrrh46m52JihHNL6or2etUkeOv04xyzQlMtcz7xQ5aHFL2ELtQknJM
	 mSgvQGmKGmi4S+qygRVslK7+Yot7tXfeFI2rT/tzpA2v2NntBD5DQnpFlbeBX6nwqt
	 XJ4zUacJmeJkg==
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com,
	borisp@nvidia.com,
	gal@nvidia.com,
	cratiu@nvidia.com,
	rrameshbabu@nvidia.com,
	steffen.klassert@secunet.com,
	tariqt@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC net-next 03/15] net: modify core data structures for PSP datapath support
Date: Thu,  9 May 2024 20:04:23 -0700
Message-ID: <20240510030435.120935-4-kuba@kernel.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240510030435.120935-1-kuba@kernel.org>
References: <20240510030435.120935-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add pointers to psp data structures to core networking structs,
and an SKB extension to carry the PSP information from the drivers
to the socket layer.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
Split out to a separate patch for ease of review,
I will squash if that's not helpful.
---
 include/linux/skbuff.h          | 3 +++
 include/linux/tcp.h             | 3 +++
 include/net/psp/functions.h     | 5 +++++
 include/net/psp/types.h         | 7 +++++++
 include/net/sock.h              | 4 ++++
 net/core/skbuff.c               | 4 ++++
 net/core/sock.c                 | 2 ++
 net/ipv4/inet_connection_sock.c | 2 ++
 net/ipv4/tcp_minisocks.c        | 6 ++++--
 net/mptcp/protocol.c            | 2 ++
 10 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index c0b97c93a6de..4689255c66d2 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4659,6 +4659,9 @@ enum skb_ext_id {
 #endif
 #if IS_ENABLED(CONFIG_MCTP_FLOWS)
 	SKB_EXT_MCTP,
+#endif
+#if IS_ENABLED(CONFIG_INET_PSP)
+	SKB_EXT_PSP,
 #endif
 	SKB_EXT_NUM, /* must be last */
 };
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 6a5e08b937b3..368ea3a2b338 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -551,6 +551,9 @@ struct tcp_timewait_sock {
 #ifdef CONFIG_TCP_AO
 	struct tcp_ao_info	__rcu *ao_info;
 #endif
+#if IS_ENABLED(CONFIG_INET_PSP)
+	struct psp_assoc __rcu	  *psp_assoc;
+#endif
 };
 
 static inline struct tcp_timewait_sock *tcp_twsk(const struct sock *sk)
diff --git a/include/net/psp/functions.h b/include/net/psp/functions.h
index 074f9df9afc3..9ff0f2b5744f 100644
--- a/include/net/psp/functions.h
+++ b/include/net/psp/functions.h
@@ -5,10 +5,15 @@
 
 #include <net/psp/types.h>
 
+struct tcp_timewait_sock;
+
 /* Driver-facing API */
 struct psp_dev *
 psp_dev_create(struct net_device *netdev, struct psp_dev_ops *psd_ops,
 	       struct psp_dev_caps *psd_caps, void *priv_ptr);
 void psp_dev_unregister(struct psp_dev *psd);
 
+static inline void psp_sk_assoc_free(struct sock *sk) { }
+static inline void psp_twsk_assoc_free(struct tcp_timewait_sock *tw) { }
+
 #endif /* __NET_PSP_HELPERS_H */
diff --git a/include/net/psp/types.h b/include/net/psp/types.h
index dbc5423a53df..a23d9bd9ce96 100644
--- a/include/net/psp/types.h
+++ b/include/net/psp/types.h
@@ -86,6 +86,13 @@ struct psp_dev_caps {
 #define PSP_V1_KEY	32
 #define PSP_MAX_KEY	32
 
+struct psp_skb_ext {
+	__be32 spi;
+	/* generation and version are 8b but we don't want holes */
+	u16 generation;
+	u16 version;
+};
+
 /**
  * struct psp_dev_ops - netdev driver facing PSP callbacks
  */
diff --git a/include/net/sock.h b/include/net/sock.h
index 0450494a1766..dc4c46ac0984 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -249,6 +249,7 @@ struct sk_filter;
   *	@sk_dst_cache: destination cache
   *	@sk_dst_pending_confirm: need to confirm neighbour
   *	@sk_policy: flow policy
+  *	@psp_assoc: PSP association, if socket is PSP-secured
   *	@sk_receive_queue: incoming packets
   *	@sk_wmem_alloc: transmit queue bytes committed
   *	@sk_tsq_flags: TCP Small Queues flags
@@ -436,6 +437,9 @@ struct sock {
 	struct mem_cgroup	*sk_memcg;
 #ifdef CONFIG_XFRM
 	struct xfrm_policy __rcu *sk_policy[2];
+#endif
+#if IS_ENABLED(CONFIG_INET_PSP)
+	struct psp_assoc __rcu	*psp_assoc;
 #endif
 	__cacheline_group_end(sock_read_rxtx);
 
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 466999a7515e..1b6821d8dede 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -77,6 +77,7 @@
 #include <net/mptcp.h>
 #include <net/mctp.h>
 #include <net/page_pool/helpers.h>
+#include <net/psp/types.h>
 #include <net/dropreason.h>
 
 #include <linux/uaccess.h>
@@ -4957,6 +4958,9 @@ static const u8 skb_ext_type_len[] = {
 #if IS_ENABLED(CONFIG_MCTP_FLOWS)
 	[SKB_EXT_MCTP] = SKB_EXT_CHUNKSIZEOF(struct mctp_flow),
 #endif
+#if IS_ENABLED(CONFIG_INET_PSP)
+	[SKB_EXT_PSP] = SKB_EXT_CHUNKSIZEOF(struct psp_skb_ext),
+#endif
 };
 
 static __always_inline unsigned int skb_ext_total_length(void)
diff --git a/net/core/sock.c b/net/core/sock.c
index 8d6e638b5426..24e9113e0417 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -142,6 +142,7 @@
 #include <trace/events/sock.h>
 
 #include <net/tcp.h>
+#include <net/psp.h>
 #include <net/busy_poll.h>
 #include <net/phonet/phonet.h>
 
@@ -3757,6 +3758,7 @@ void sk_common_release(struct sock *sk)
 	sock_orphan(sk);
 
 	xfrm_sk_free_policy(sk);
+	psp_sk_assoc_free(sk);
 
 	sock_put(sk);
 }
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 3b38610958ee..10d4be66046a 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -21,6 +21,7 @@
 #include <net/xfrm.h>
 #include <net/tcp.h>
 #include <net/sock_reuseport.h>
+#include <net/psp.h>
 #include <net/addrconf.h>
 
 #if IS_ENABLED(CONFIG_IPV6)
@@ -1226,6 +1227,7 @@ void inet_csk_destroy_sock(struct sock *sk)
 	sk_stream_kill_queues(sk);
 
 	xfrm_sk_free_policy(sk);
+	psp_sk_assoc_free(sk);
 
 	this_cpu_dec(*sk->sk_prot->orphan_count);
 
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 7d543569a180..660e890f3c74 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -23,6 +23,7 @@
 #include <net/xfrm.h>
 #include <net/busy_poll.h>
 #include <net/rstreason.h>
+#include <net/psp.h>
 
 static bool tcp_in_window(u32 seq, u32 end_seq, u32 s_win, u32 e_win)
 {
@@ -377,15 +378,16 @@ static void tcp_md5_twsk_free_rcu(struct rcu_head *head)
 
 void tcp_twsk_destructor(struct sock *sk)
 {
+	struct tcp_timewait_sock *twsk = tcp_twsk(sk);
+
 #ifdef CONFIG_TCP_MD5SIG
 	if (static_branch_unlikely(&tcp_md5_needed.key)) {
-		struct tcp_timewait_sock *twsk = tcp_twsk(sk);
-
 		if (twsk->tw_md5_key)
 			call_rcu(&twsk->tw_md5_key->rcu, tcp_md5_twsk_free_rcu);
 	}
 #endif
 	tcp_ao_destroy_sock(sk, true);
+	psp_twsk_assoc_free(twsk);
 }
 EXPORT_SYMBOL_GPL(tcp_twsk_destructor);
 
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index bb8f96f2b86f..cd79bcecebc2 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -23,6 +23,7 @@
 #include <net/hotdata.h>
 #include <net/xfrm.h>
 #include <asm/ioctls.h>
+#include <net/psp.h>
 #include "protocol.h"
 #include "mib.h"
 
@@ -3010,6 +3011,7 @@ static void __mptcp_destroy_sock(struct sock *sk)
 	WARN_ON_ONCE(msk->rmem_released);
 	sk_stream_kill_queues(sk);
 	xfrm_sk_free_policy(sk);
+	psp_sk_assoc_free(sk);
 
 	sock_put(sk);
 }
-- 
2.45.0


