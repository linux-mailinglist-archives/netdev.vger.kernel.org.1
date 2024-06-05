Return-Path: <netdev+bounces-100808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AEA8FC1B0
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 04:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BBE81F25D5A
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 02:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D89161FEF;
	Wed,  5 Jun 2024 02:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ptxVEqqN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213A938DD6;
	Wed,  5 Jun 2024 02:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717554032; cv=none; b=AVLPsH6JBPa3jx9WjUl0xO/sHVUSEqtDRS8b0r/nxeNkxYD82W3NgaB9qqifYVj6/zIDs/R6mmV8d92wh2lrezqCb+4bJmKyGD8xNiZqt+5ggSw7FpmB6fzg07o8LiuTRIgxcWa58pBanoid5gAA3eViYutLh0PsZ6vJljkkQMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717554032; c=relaxed/simple;
	bh=w5wKbNIb23NgQCOfdd8FK1bU/k0e6DZ+HYfImsE5n5U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y7v28vtit1yJj5GvwYMN7MZrfEbkCvZ17rx2676sTislXMEPpT9i1fr0GfPTvRXaahDjj0kArA4Cvs1XBtl0xUQyu7EQ9z4Rnvwc46KPHwUCO3EwgtZYaIGWNGQPvhMigMLD7+x9RkdPjmI+rmyVrRZ1d1meNYk1dmcRKoGPBi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ptxVEqqN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BC72EC4AF0D;
	Wed,  5 Jun 2024 02:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717554031;
	bh=w5wKbNIb23NgQCOfdd8FK1bU/k0e6DZ+HYfImsE5n5U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ptxVEqqNqN88GDyzI1LhYbDOriisxkTaJEnb+o9br0t7Z1o8mKTahBH0cO5CXo2ZF
	 asDkhHhFJrNMNWGsveza4bbPVRnwmIU4IbPvAJfcbRg1EyDwItT3xJBdYf1JUZ9yFd
	 Pk2TnBLo5NGCkr1tlVTYOyXGZpbxTgfdNSAHLsw6pGVQDn4rMjQZ0L5uswh5zVpVQT
	 a8AtskapscGRX0M7ejjFshN9NYRqgOB3zhqqxGQ8mfIqWFkx17DIVvFraVKAU3PX1b
	 +S3Fm/xdFsei6bOwG/G3PC9r3cllTZbX0Ii62fNiWD0mZfTRYIBVUdTVI+34FLZ9L8
	 dkA/zW2AdjriA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B265AC27C50;
	Wed,  5 Jun 2024 02:20:31 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Date: Wed, 05 Jun 2024 03:20:04 +0100
Subject: [PATCH net-next v2 3/6] net/tcp: Move tcp_inbound_hash() from
 headers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240605-tcp_ao-tracepoints-v2-3-e91e161282ef@gmail.com>
References: <20240605-tcp_ao-tracepoints-v2-0-e91e161282ef@gmail.com>
In-Reply-To: <20240605-tcp_ao-tracepoints-v2-0-e91e161282ef@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717554029; l=5458;
 i=0x7f454c46@gmail.com; s=20240410; h=from:subject:message-id;
 bh=5X2MtBvUuT7WeL72gazJlH1Gy0gHMp/AKH4/TTKvFqI=;
 b=/P6ryyMxxnMyTgDOekxh7W3O5Le5HOsMWT9/MocpngSjh2kuMsV+oS9j/u803KNhrhwSgNvJsAw9
 TS6qA1SeADntjBnR+y6WDUBkNo8IQFiVW/AVFZ3iSV8blTsNia/N
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

Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
---
 include/net/tcp.h | 65 ++++---------------------------------------------------
 net/ipv4/tcp.c    | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+), 61 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index f6dd035e0fa9..ba594ef70c2d 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2806,66 +2806,9 @@ static inline bool tcp_ao_required(struct sock *sk, const void *saddr,
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
index 5fa68e7f6ddb..99fea9919b08 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4512,6 +4512,69 @@ EXPORT_SYMBOL(tcp_inbound_md5_hash);
 
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



