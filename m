Return-Path: <netdev+bounces-101587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2D18FF822
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 01:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E26F41C265D9
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 23:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F8813F43C;
	Thu,  6 Jun 2024 23:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="feWMJnMI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D06C13C3F6;
	Thu,  6 Jun 2024 23:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717716374; cv=none; b=gpTf8HV6KzF6Pi+Prxz72xKmDO4cyCRkPcPzdH8cfzDOdH7iMVGWzZcAEbXzFMXV3rWwGIQnDoe/r1F55lmEeSB2t1Qoj5LAyQ9F9BHvyTXcuLHgONb5rCbwsDesMZ5EB9oELuM42Gk/WZq9jJMUlV2rEkpKATsZXtY8ns/Mdcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717716374; c=relaxed/simple;
	bh=yLUQd9kDt9LtaEhdg8XdIedu01kPhg8wpAZffv0TQzk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZdsYdro0ywlN6Bw7v9Wf8NwI7/FocmHxBCKhAMNOUWVEnioo/WO/irIkXNA1HOw7f8KMvaiGUDPS/RCgjOpMeotG8kbuEzpuMP08hXpGDWHXdix0aPGDDBBg/Trz1OQ5zHlyw1GwTzyr56liNQ0g4NlD1D+N/FoYQyHotRjyqec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=feWMJnMI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 35E77C4AF0C;
	Thu,  6 Jun 2024 23:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717716374;
	bh=yLUQd9kDt9LtaEhdg8XdIedu01kPhg8wpAZffv0TQzk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=feWMJnMIpT7t3flztcffrOd9ch19x5crhXiQUt8x/k8s/7NtkeOuswoXMe5/rlCgw
	 +grZ+TFQ6H7wKihoUTpmxqCxpROILHcCSTeHcby44/WpaU1o9q+D/QQmSi08o0swfi
	 43mDof33k0TW3S3mZWMOQer428fe+RVbzANwgyx9Y+vV8HhV+M2nrUGjdta+JpsaP5
	 80UebWw8W6gNQLm8gFoAqDVNKfs8SXpDp9iRE+lY3SD9VTXKuyJv8a1IHaZEJyUgsa
	 tKtY6raYNmxI9iWrLMgO1D2swghkyePuGJmDtJBOoe1d3usMblQj9zzN0kMsTAwvPi
	 d21F3zRPm04IA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F11C27C52;
	Thu,  6 Jun 2024 23:26:14 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Date: Fri, 07 Jun 2024 00:25:57 +0100
Subject: [PATCH net-next v4 3/6] net/tcp: Move tcp_inbound_hash() from
 headers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-tcp_ao-tracepoints-v4-3-88dc245c1f39@gmail.com>
References: <20240607-tcp_ao-tracepoints-v4-0-88dc245c1f39@gmail.com>
In-Reply-To: <20240607-tcp_ao-tracepoints-v4-0-88dc245c1f39@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: Mohammad Nassiri <mnassiri@ciena.com>, Simon Horman <horms@kernel.org>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Dmitry Safonov <0x7f454c46@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717716372; l=7187;
 i=0x7f454c46@gmail.com; s=20240410; h=from:subject:message-id;
 bh=fSgaLj9RcD4LldAhS9J1+qpbBogdrXedjmE5b/VoFPI=;
 b=Ymichd4x8l8sOS6nqDzv/+6nSobLyj9sxu1l+FFMHhCCkdFWrzpq881eWhvQE5i7FhJb0CJQ9Qfa
 p5K5cQ+/ClJLqy0+k0tAVP2fVSOoRUVyi6Z51B7o2RrKwyBd37zq
X-Developer-Key: i=0x7f454c46@gmail.com; a=ed25519;
 pk=cFSWovqtkx0HrT5O9jFCEC/Cef4DY8a2FPeqP4THeZQ=
X-Endpoint-Received: by B4 Relay for 0x7f454c46@gmail.com/20240410 with
 auth_id=152
X-Original-From: Dmitry Safonov <0x7f454c46@gmail.com>
Reply-To: 0x7f454c46@gmail.com

From: Dmitry Safonov <0x7f454c46@gmail.com>

Two reasons:
1. It's grown up enough
2. In order to not do header spaghetti by including
   <trace/events/tcp.h>, which is necessary for TCP tracepoints.

While at it, unexport and make static tcp_inbound_ao_hash().

Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
---
 include/net/tcp.h | 78 +++----------------------------------------------------
 net/ipv4/tcp.c    | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 76 insertions(+), 76 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index e5427b05129b..2aac11e7e1cc 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1863,12 +1863,6 @@ tcp_md5_do_lookup_any_l3index(const struct sock *sk,
 	return __tcp_md5_do_lookup(sk, 0, addr, family, true);
 }
 
-enum skb_drop_reason
-tcp_inbound_md5_hash(const struct sock *sk, const struct sk_buff *skb,
-		     const void *saddr, const void *daddr,
-		     int family, int l3index, const __u8 *hash_location);
-
-
 #define tcp_twsk_md5_key(twsk)	((twsk)->tw_md5_key)
 #else
 static inline struct tcp_md5sig_key *
@@ -1885,13 +1879,6 @@ tcp_md5_do_lookup_any_l3index(const struct sock *sk,
 	return NULL;
 }
 
-static inline enum skb_drop_reason
-tcp_inbound_md5_hash(const struct sock *sk, const struct sk_buff *skb,
-		     const void *saddr, const void *daddr,
-		     int family, int l3index, const __u8 *hash_location)
-{
-	return SKB_NOT_DROPPED_YET;
-}
 #define tcp_twsk_md5_key(twsk)	NULL
 #endif
 
@@ -2806,66 +2793,9 @@ static inline bool tcp_ao_required(struct sock *sk, const void *saddr,
 	return false;
 }
 
-/* Called with rcu_read_lock() */
-static inline enum skb_drop_reason
-tcp_inbound_hash(struct sock *sk, const struct request_sock *req,
-		 const struct sk_buff *skb,
-		 const void *saddr, const void *daddr,
-		 int family, int dif, int sdif)
-{
-	const struct tcphdr *th = tcp_hdr(skb);
-	const struct tcp_ao_hdr *aoh;
-	const __u8 *md5_location;
-	int l3index;
-
-	/* Invalid option or two times meet any of auth options */
-	if (tcp_parse_auth_options(th, &md5_location, &aoh)) {
-		tcp_hash_fail("TCP segment has incorrect auth options set",
-			      family, skb, "");
-		return SKB_DROP_REASON_TCP_AUTH_HDR;
-	}
-
-	if (req) {
-		if (tcp_rsk_used_ao(req) != !!aoh) {
-			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPAOBAD);
-			tcp_hash_fail("TCP connection can't start/end using TCP-AO",
-				      family, skb, "%s",
-				      !aoh ? "missing AO" : "AO signed");
-			return SKB_DROP_REASON_TCP_AOFAILURE;
-		}
-	}
-
-	/* sdif set, means packet ingressed via a device
-	 * in an L3 domain and dif is set to the l3mdev
-	 */
-	l3index = sdif ? dif : 0;
-
-	/* Fast path: unsigned segments */
-	if (likely(!md5_location && !aoh)) {
-		/* Drop if there's TCP-MD5 or TCP-AO key with any rcvid/sndid
-		 * for the remote peer. On TCP-AO established connection
-		 * the last key is impossible to remove, so there's
-		 * always at least one current_key.
-		 */
-		if (tcp_ao_required(sk, saddr, family, l3index, true)) {
-			tcp_hash_fail("AO hash is required, but not found",
-					family, skb, "L3 index %d", l3index);
-			return SKB_DROP_REASON_TCP_AONOTFOUND;
-		}
-		if (unlikely(tcp_md5_do_lookup(sk, l3index, saddr, family))) {
-			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5NOTFOUND);
-			tcp_hash_fail("MD5 Hash not found",
-				      family, skb, "L3 index %d", l3index);
-			return SKB_DROP_REASON_TCP_MD5NOTFOUND;
-		}
-		return SKB_NOT_DROPPED_YET;
-	}
-
-	if (aoh)
-		return tcp_inbound_ao_hash(sk, skb, family, req, l3index, aoh);
-
-	return tcp_inbound_md5_hash(sk, skb, saddr, daddr, family,
-				    l3index, md5_location);
-}
+enum skb_drop_reason tcp_inbound_hash(struct sock *sk,
+		const struct request_sock *req, const struct sk_buff *skb,
+		const void *saddr, const void *daddr,
+		int family, int dif, int sdif);
 
 #endif	/* _TCP_H */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 6553221694ec..17a4a8e4855d 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4463,7 +4463,7 @@ int tcp_md5_hash_key(struct tcp_sigpool *hp,
 EXPORT_SYMBOL(tcp_md5_hash_key);
 
 /* Called with rcu_read_lock() */
-enum skb_drop_reason
+static enum skb_drop_reason
 tcp_inbound_md5_hash(const struct sock *sk, const struct sk_buff *skb,
 		     const void *saddr, const void *daddr,
 		     int family, int l3index, const __u8 *hash_location)
@@ -4517,10 +4517,80 @@ tcp_inbound_md5_hash(const struct sock *sk, const struct sk_buff *skb,
 	}
 	return SKB_NOT_DROPPED_YET;
 }
-EXPORT_SYMBOL(tcp_inbound_md5_hash);
+#else
+static inline enum skb_drop_reason
+tcp_inbound_md5_hash(const struct sock *sk, const struct sk_buff *skb,
+		     const void *saddr, const void *daddr,
+		     int family, int l3index, const __u8 *hash_location)
+{
+	return SKB_NOT_DROPPED_YET;
+}
 
 #endif
 
+/* Called with rcu_read_lock() */
+enum skb_drop_reason
+tcp_inbound_hash(struct sock *sk, const struct request_sock *req,
+		 const struct sk_buff *skb,
+		 const void *saddr, const void *daddr,
+		 int family, int dif, int sdif)
+{
+	const struct tcphdr *th = tcp_hdr(skb);
+	const struct tcp_ao_hdr *aoh;
+	const __u8 *md5_location;
+	int l3index;
+
+	/* Invalid option or two times meet any of auth options */
+	if (tcp_parse_auth_options(th, &md5_location, &aoh)) {
+		tcp_hash_fail("TCP segment has incorrect auth options set",
+			      family, skb, "");
+		return SKB_DROP_REASON_TCP_AUTH_HDR;
+	}
+
+	if (req) {
+		if (tcp_rsk_used_ao(req) != !!aoh) {
+			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPAOBAD);
+			tcp_hash_fail("TCP connection can't start/end using TCP-AO",
+				      family, skb, "%s",
+				      !aoh ? "missing AO" : "AO signed");
+			return SKB_DROP_REASON_TCP_AOFAILURE;
+		}
+	}
+
+	/* sdif set, means packet ingressed via a device
+	 * in an L3 domain and dif is set to the l3mdev
+	 */
+	l3index = sdif ? dif : 0;
+
+	/* Fast path: unsigned segments */
+	if (likely(!md5_location && !aoh)) {
+		/* Drop if there's TCP-MD5 or TCP-AO key with any rcvid/sndid
+		 * for the remote peer. On TCP-AO established connection
+		 * the last key is impossible to remove, so there's
+		 * always at least one current_key.
+		 */
+		if (tcp_ao_required(sk, saddr, family, l3index, true)) {
+			tcp_hash_fail("AO hash is required, but not found",
+				      family, skb, "L3 index %d", l3index);
+			return SKB_DROP_REASON_TCP_AONOTFOUND;
+		}
+		if (unlikely(tcp_md5_do_lookup(sk, l3index, saddr, family))) {
+			NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMD5NOTFOUND);
+			tcp_hash_fail("MD5 Hash not found",
+				      family, skb, "L3 index %d", l3index);
+			return SKB_DROP_REASON_TCP_MD5NOTFOUND;
+		}
+		return SKB_NOT_DROPPED_YET;
+	}
+
+	if (aoh)
+		return tcp_inbound_ao_hash(sk, skb, family, req, l3index, aoh);
+
+	return tcp_inbound_md5_hash(sk, skb, saddr, daddr, family,
+				    l3index, md5_location);
+}
+EXPORT_SYMBOL_GPL(tcp_inbound_hash);
+
 void tcp_done(struct sock *sk)
 {
 	struct request_sock *req;

-- 
2.42.0



