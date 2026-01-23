Return-Path: <netdev+bounces-252818-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Dn9I4tYc2nruwAAu9opvQ
	(envelope-from <netdev+bounces-252818-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 12:16:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C25474E80
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 12:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA618301C11B
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 11:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93595287256;
	Fri, 23 Jan 2026 11:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U/AMaCQj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B73B2E414
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 11:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769166968; cv=none; b=ALR59VuyD+SyzTZ4V/wc2T7X14kb7ic6zzlaun8QPydvqEbrq4wQufsaViNPM/NiW5qXHrw9BkDFXvDYccN0TUkHjAfI/07X1G6LaIpRzzsa5sTHeWFtGrhor015h2Zvnzb2lsU5wdGsin7Y1UwDBFuP63xkbXz2Av1KWjK+q4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769166968; c=relaxed/simple;
	bh=N/CY6pJq1G36Er6zYIOpAVeB0TOP9GZ5Gx3dfPRc3t4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rOjG4vCN1uHoKWmlHov/JYAUUWcSzjdF6n3u29cGJT7UZNi7XL/q8eKqRiw2Iuya7qgt2u93mMrCR4nGiM25zvLdfVCENeKeaDLxnGBjYnvKj0QiV/9al1bGf7yvwZ0dl0wNZDnKk3Qta4CKsftq45N0oiMbYsSrGAXb5mjlVqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U/AMaCQj; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-88a344b86f7so68336346d6.0
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 03:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769166966; x=1769771766; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ixxU3s7qaKIpU1ooiYPj/OAlbfzL9VIdLbuXGZLihXs=;
        b=U/AMaCQjBFSDYF2X2wcDE+r8Jfl9nHnXpQlagd13veenXQcXL/7TDfG3k18m6rDem8
         yF624zUXETnAlbpekn+PQGWlEg9r0Z66IQdTC8g6idzPximaHsD0JaZ6brQ5CjagwvGS
         SQ0Kb6fWnHVYdSdicXOYGHxYVBCJyY8obtkdJZUmpyJD4P4G4pz8ekDsjwXrYe/Pki8b
         3WFY/R0Qm2Hjo1IDHGIepwqA2HGleWnCfjaKYWMvANduD3bvW5vIeuDVfw5JXoX8Qne8
         wYp3hYtmxnTsdG1MvwYGnE5Msd7M/auIKKtBIci+LC8dmEYyCG90gDHmjxsP+Ahv3fLx
         qKBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769166966; x=1769771766;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ixxU3s7qaKIpU1ooiYPj/OAlbfzL9VIdLbuXGZLihXs=;
        b=Fu7S/6/fsG+HzuDJilA9wzR8/Jqtl5NCy9dodqB5u84K9xVYeqIf7se+U9A09hfGxM
         oBQA6wzQyvLm9FYrADhnkTpV031XUuW3Pnz3Zv1duGMgB+uCOyf0i3zIcr0Iqgfl6k7x
         Lvrp36wYE0AzcVOX3EgefqcrLOhtTzHsUhfnBTvANXYMVzRMukRg3Ey+B2vh3qcgzV9t
         V9p9P7VBi8nwAkvBumGpeKQdCd+Js8p7KB91lIayRvapHx2K9CZqNKV404Cf+/m7BRuJ
         4oKUWEKj4F5Y/tchMxnLZUOQ7Fej+gI/4CTA1JR5AbC/kbm+iRIR5o5z+xQP4W+H/bI0
         +uGw==
X-Forwarded-Encrypted: i=1; AJvYcCVl89mtuZJfl3iTFKag4nPiEYGPbdydgbnP89qQrvY2aYBZX83BUim9hQJDhV1GjfDeIDwRY7w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg16whvehwCRuZYyn6lwQywJn+60FEW2cZaxPLGQDtBhBO5RR7
	yoL1A/bnWbuxVb36lL+mMlK2UdHfqFuFTwYz82scSGU0+tzdqlqllD4ceWliMj1KMn3+Qw8agt5
	VXB8/BeuaU1A5lA==
X-Received: from qvbma18.prod.google.com ([2002:a05:6214:5b12:b0:894:9755:2a7f])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:2685:b0:88f:ccba:8f20 with SMTP id 6a1803df08f44-894982db3d2mr6710416d6.48.1769166966058;
 Fri, 23 Jan 2026 03:16:06 -0800 (PST)
Date: Fri, 23 Jan 2026 11:16:05 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260123111605.4089200-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: move sk_forced_mem_schedule() to tcp.c
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252818-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0C25474E80
X-Rspamd-Action: no action

TCP fast path can (auto)inline this helper, instead
of (auto)inling it from tcp_send_fin().

No change of overall code size, but tcp_sendmsg() is faster.

$ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
add/remove: 0/0 grow/shrink: 1/1 up/down: 141/-140 (1)
Function                                     old     new   delta
tcp_stream_alloc_skb                         216     357    +141
tcp_send_fin                                 688     548    -140
Total: Before=22236729, After=22236730, chg +0.00%

BTW, we might change tcp_send_fin() to use tcp_stream_alloc_skb().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp.c        | 27 +++++++++++++++++++++++++++
 net/ipv4/tcp_output.c | 27 ---------------------------
 2 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 148cdf3cd6233add37ea52e273cb4fb3e75fcbcb..87acd01274601eca799e42b8f895fff4c35cf25a 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -902,6 +902,33 @@ ssize_t tcp_splice_read(struct socket *sock, loff_t *ppos,
 }
 EXPORT_IPV6_MOD(tcp_splice_read);
 
+/* We allow to exceed memory limits for FIN packets to expedite
+ * connection tear down and (memory) recovery.
+ * Otherwise tcp_send_fin() could be tempted to either delay FIN
+ * or even be forced to close flow without any FIN.
+ * In general, we want to allow one skb per socket to avoid hangs
+ * with edge trigger epoll()
+ */
+void sk_forced_mem_schedule(struct sock *sk, int size)
+{
+	int delta, amt;
+
+	delta = size - sk->sk_forward_alloc;
+	if (delta <= 0)
+		return;
+
+	amt = sk_mem_pages(delta);
+	sk_forward_alloc_add(sk, amt << PAGE_SHIFT);
+
+	if (mem_cgroup_sk_enabled(sk))
+		mem_cgroup_sk_charge(sk, amt, gfp_memcg_charge() | __GFP_NOFAIL);
+
+	if (sk->sk_bypass_prot_mem)
+		return;
+
+	sk_memory_allocated_add(sk, amt);
+}
+
 struct sk_buff *tcp_stream_alloc_skb(struct sock *sk, gfp_t gfp,
 				     bool force_schedule)
 {
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 256b669e8d3b4a4d191e61e79784e412aaef8965..597e888af36d8697cd696964077b423e79fdb83e 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3767,33 +3767,6 @@ void tcp_xmit_retransmit_queue(struct sock *sk)
 				     inet_csk(sk)->icsk_rto, true);
 }
 
-/* We allow to exceed memory limits for FIN packets to expedite
- * connection tear down and (memory) recovery.
- * Otherwise tcp_send_fin() could be tempted to either delay FIN
- * or even be forced to close flow without any FIN.
- * In general, we want to allow one skb per socket to avoid hangs
- * with edge trigger epoll()
- */
-void sk_forced_mem_schedule(struct sock *sk, int size)
-{
-	int delta, amt;
-
-	delta = size - sk->sk_forward_alloc;
-	if (delta <= 0)
-		return;
-
-	amt = sk_mem_pages(delta);
-	sk_forward_alloc_add(sk, amt << PAGE_SHIFT);
-
-	if (mem_cgroup_sk_enabled(sk))
-		mem_cgroup_sk_charge(sk, amt, gfp_memcg_charge() | __GFP_NOFAIL);
-
-	if (sk->sk_bypass_prot_mem)
-		return;
-
-	sk_memory_allocated_add(sk, amt);
-}
-
 /* Send a FIN. The caller locks the socket for us.
  * We should try to send a FIN packet really hard, but eventually give up.
  */
-- 
2.52.0.457.g6b5491de43-goog


