Return-Path: <netdev+bounces-46436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A23A7E3C44
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 13:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A9611C20B0A
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 12:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E182B2E418;
	Tue,  7 Nov 2023 12:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDGq/55Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79F82DF9A
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 12:13:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47469C433C8;
	Tue,  7 Nov 2023 12:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699359228;
	bh=AUl7jYydCqr3LoSvgRlVv9TK/v/85hEFIr2yHKUBj9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CDGq/55ZriKV5zzP+pijmQ1HgneGkRw+Jj/y/YnSx7GnWGFyw4fi7c2mDKc/vmys7
	 bAOS30Aray+sO2u+8KufkerrFetL+RbNnEUkH78h2R6i43ylnmEgTlWFYGaYH/enl0
	 Z2kJ39ZlBf73eyUT06PU/voAxM/M4IM+ekApmvhT+Ad76fdhjiHV+Mc9xKCdl3Wsml
	 zf2gowGUV3mRdregrj0qqYG+adl+0bYLYU/zVqfZRuPpVs7ubZRcyglS5oQsl2xXvW
	 PI5twBlxeCcQ89/qC7+nXcPMKsoYeIAdUNVg46AgpAFYcGcJQZbsVnvWhuXXZNeTPq
	 Wn1Y3Br95EXjw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	kuniyu@amazon.com,
	wuyun.abel@bytedance.com,
	leitao@debian.org,
	alexander@mihalicyn.com,
	dhowells@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 4/4] net: annotate data-races around sk->sk_dst_pending_confirm
Date: Tue,  7 Nov 2023 07:13:34 -0500
Message-ID: <20231107121337.3759240-4-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107121337.3759240-1-sashal@kernel.org>
References: <20231107121337.3759240-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.328
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit eb44ad4e635132754bfbcb18103f1dcb7058aedd ]

This field can be read or written without socket lock being held.

Add annotations to avoid load-store tearing.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/sock.h    | 6 +++---
 net/core/sock.c       | 2 +-
 net/ipv4/tcp_output.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 7b42ddca4decb..f974b548e1199 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1804,7 +1804,7 @@ static inline void dst_negative_advice(struct sock *sk)
 		if (ndst != dst) {
 			rcu_assign_pointer(sk->sk_dst_cache, ndst);
 			sk_tx_queue_clear(sk);
-			sk->sk_dst_pending_confirm = 0;
+			WRITE_ONCE(sk->sk_dst_pending_confirm, 0);
 		}
 	}
 }
@@ -1815,7 +1815,7 @@ __sk_dst_set(struct sock *sk, struct dst_entry *dst)
 	struct dst_entry *old_dst;
 
 	sk_tx_queue_clear(sk);
-	sk->sk_dst_pending_confirm = 0;
+	WRITE_ONCE(sk->sk_dst_pending_confirm, 0);
 	old_dst = rcu_dereference_protected(sk->sk_dst_cache,
 					    lockdep_sock_is_held(sk));
 	rcu_assign_pointer(sk->sk_dst_cache, dst);
@@ -1828,7 +1828,7 @@ sk_dst_set(struct sock *sk, struct dst_entry *dst)
 	struct dst_entry *old_dst;
 
 	sk_tx_queue_clear(sk);
-	sk->sk_dst_pending_confirm = 0;
+	WRITE_ONCE(sk->sk_dst_pending_confirm, 0);
 	old_dst = xchg((__force struct dst_entry **)&sk->sk_dst_cache, dst);
 	dst_release(old_dst);
 }
diff --git a/net/core/sock.c b/net/core/sock.c
index 5b9f51a27dc0d..e8b5742d91492 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -534,7 +534,7 @@ struct dst_entry *__sk_dst_check(struct sock *sk, u32 cookie)
 
 	if (dst && dst->obsolete && dst->ops->check(dst, cookie) == NULL) {
 		sk_tx_queue_clear(sk);
-		sk->sk_dst_pending_confirm = 0;
+		WRITE_ONCE(sk->sk_dst_pending_confirm, 0);
 		RCU_INIT_POINTER(sk->sk_dst_cache, NULL);
 		dst_release(dst);
 		return NULL;
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 8b2d49120ce23..67636017f275a 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1059,7 +1059,7 @@ static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb,
 	skb_set_hash_from_sk(skb, sk);
 	refcount_add(skb->truesize, &sk->sk_wmem_alloc);
 
-	skb_set_dst_pending_confirm(skb, sk->sk_dst_pending_confirm);
+	skb_set_dst_pending_confirm(skb, READ_ONCE(sk->sk_dst_pending_confirm));
 
 	/* Build TCP header and checksum it. */
 	th = (struct tcphdr *)skb->data;
-- 
2.42.0


