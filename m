Return-Path: <netdev+bounces-259955-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDuhI/cdnGkZ/wMAu9opvQ
	(envelope-from <netdev+bounces-259955-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 10:29:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A37173E8F
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 10:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 657783004204
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 09:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C4434D904;
	Mon, 23 Feb 2026 09:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QGmIoGXg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FEA18FDBD
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 09:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771838839; cv=none; b=typuCwvyAyzchSb2tFQ/LJyKEM/CCP0fpJ6V5i6iDXsFK+QkgFhxRrikicZKrMksUE9WC/iH4avcqzjYupd/7yM3uusA86NkhwsVsjMjfEeYSl0dhLYjPV2sTMb6C5N10kXhfFnnAn/CWiDpZ/5MClzW13ayBnzle/QO/Yc2C2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771838839; c=relaxed/simple;
	bh=yku+G3kt/JHAGiQJKEgDB9VRXFKphLGwCwHs6Ajj72A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mMnaaQcGUYGIdJT8Tx7BNZW/k2gAif1wICMLL7e6CSkz8kbldQHr7rYPEdtZIiQGmzVTeubcvOG1/p9FnMfknmFkPGOaFS1N2aWivqDK1QFro74MnaD+2kKxQVDpzMZncF60OqvNeWMUl78VUk+KJ/rU7fYZ4mySOPcDnb5TYgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QGmIoGXg; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8c70e610242so4144859585a.2
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 01:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771838837; x=1772443637; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=75tlsOUcfVxhv7eEx3nQAr7K2PqBN9t7hv5MNG8BuEY=;
        b=QGmIoGXgcibpllU6/V53zAaTCQXB6ogL00i9bhaO7FpGUtO9SIzE3G6WrQAIjtRZir
         wpGx/+d14Myfpvzg62aNBxg8n5h/mLc+/+VFvPnQ1igljFag3L76rixtTnbk0IjhuPTr
         j8nXxXTPaieI9oory1t/235IHxHBnYo/4M0Po2vS/L4zKpbKra2FqPuEeCSesgTlX+rc
         7qbTtjQ26GrC9iqME/uoJjaovYnqzeBntWfGmcQ2G+TqHQMJEdJ1JBSJHpg3mL7Nn9fu
         NBn6dJ78W0uzyvQ1LHNJLn/cqYQCLzMLMDUntm1DcRh6v40m6Rxg9eoaQ7xWBadBnWcC
         H35g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771838837; x=1772443637;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=75tlsOUcfVxhv7eEx3nQAr7K2PqBN9t7hv5MNG8BuEY=;
        b=co+rb/+L75X0lD5clOkzyFGcMjT03CJA0FbQ2/QTw9ovWxuBdq8SsdnXqyjJO2BN9E
         +dNPir7RXqSD+7qcQR8d5O+fYmc8/S/ub/PSo37wEWL1U4+sHxjCa5lfo3BLSw55513i
         C7frLKL+VleaFJIzUPNSZnlievcy84WxbjKWcyVGELuDINQDtxyNFWOam5sU0HlIxGgh
         zbSIM3V3dYknO/FKMYL/+Eo5JUAaQtNQUtgEJCflfbBA7kX0Mql120hbSKuuxzMNrkRw
         qoZpmkzLa45ksHd9dNg3FWaeSM2O1eYIgLNybMnhBg3orAoGZh/ZjaYGHlS2i6UdDqIC
         SpDw==
X-Forwarded-Encrypted: i=1; AJvYcCV4DG7Jt3LqdNmBoNTg/R4neTAnkPcL1LxStoa/0RqDdwtGlaYCtBywvvfIHmi0gYVg1BZaKkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZdzsPY+UD6MSFzKEQxrFr7v5bhdnCxPxVzeSU/e0eESaGmYqm
	yTLf8Hn8hKwAoOdYOaqccBt65jlSu5D0ZujFKomHmPyl/hG6qV3GoT7k0nLE/h1kHG2RLKWutZi
	H7uK2J3rOGj//Pw==
X-Received: from qknwd20.prod.google.com ([2002:a05:620a:7294:b0:8c6:5c81:fec1])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:269a:b0:8b2:e6b1:a9a6 with SMTP id af79cd13be357-8cb8c9cc15emr946327485a.17.1771838837123;
 Mon, 23 Feb 2026 01:27:17 -0800 (PST)
Date: Mon, 23 Feb 2026 09:27:15 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.345.g96ddfc5eaa-goog
Message-ID: <20260223092716.3673939-1-edumazet@google.com>
Subject: [PATCH net-next] net: __lock_sock() can be static
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259955-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 16A37173E8F
X-Rspamd-Action: no action

After commit 6511882cdd82 ("mptcp: allocate fwd memory separately
on the rx and tx path") __lock_sock() can be static again.

Make sure __lock_sock() is not inlined, so that lock_sock_nested()
no longer needs a stack canary.

Add a noinline attribute on lock_sock_nested() so that calls
to lock_sock() from net/core/sock.c are not inlined,
none of them are fast path to deserve that:

 - sockopt_lock_sock()
 - sock_set_reuseport()
 - sock_set_reuseaddr()
 - sock_set_mark()
 - sock_set_keepalive()
 - sock_no_linger()
 - sock_bindtoindex()
 - sk_wait_data()
 - sock_set_rcvbuf()

$ scripts/bloat-o-meter -t vmlinux.old vmlinux
add/remove: 0/0 grow/shrink: 0/3 up/down: 0/-312 (-312)
Function                                     old     new   delta
__lock_sock                                  192     188      -4
__lock_sock_fast                             239      86    -153
lock_sock_nested                             227      72    -155
Total: Before=24888707, After=24888395, chg -0.00%

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/sock.h | 1 -
 net/core/sock.c    | 8 ++++----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 66b56288c1d3850439b2a0bed00be801d5770efa..55b61e4b0d8318887d527e919fc1103d78ac6d14 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1709,7 +1709,6 @@ static inline void lock_sock(struct sock *sk)
 	lock_sock_nested(sk, 0);
 }
 
-void __lock_sock(struct sock *sk);
 void __release_sock(struct sock *sk);
 void release_sock(struct sock *sk);
 
diff --git a/net/core/sock.c b/net/core/sock.c
index 693e6d80f501ef552aa58928f28b78a578169536..cfb2a6209946089669882cdbd5d1b36c53838989 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3175,7 +3175,7 @@ bool sk_page_frag_refill(struct sock *sk, struct page_frag *pfrag)
 }
 EXPORT_SYMBOL(sk_page_frag_refill);
 
-void __lock_sock(struct sock *sk)
+static void __lock_sock(struct sock *sk)
 	__releases(&sk->sk_lock.slock)
 	__acquires(&sk->sk_lock.slock)
 {
@@ -3774,14 +3774,14 @@ void sock_init_data(struct socket *sock, struct sock *sk)
 }
 EXPORT_SYMBOL(sock_init_data);
 
-void lock_sock_nested(struct sock *sk, int subclass)
+void noinline lock_sock_nested(struct sock *sk, int subclass)
 {
 	/* The sk_lock has mutex_lock() semantics here. */
 	mutex_acquire(&sk->sk_lock.dep_map, subclass, 0, _RET_IP_);
 
 	might_sleep();
 	spin_lock_bh(&sk->sk_lock.slock);
-	if (sock_owned_by_user_nocheck(sk))
+	if (unlikely(sock_owned_by_user_nocheck(sk)))
 		__lock_sock(sk);
 	sk->sk_lock.owned = 1;
 	spin_unlock_bh(&sk->sk_lock.slock);
@@ -3810,7 +3810,7 @@ bool __lock_sock_fast(struct sock *sk) __acquires(&sk->sk_lock.slock)
 	might_sleep();
 	spin_lock_bh(&sk->sk_lock.slock);
 
-	if (!sock_owned_by_user_nocheck(sk)) {
+	if (likely(!sock_owned_by_user_nocheck(sk))) {
 		/*
 		 * Fast path return with bottom halves disabled and
 		 * sock::sk_lock.slock held.
-- 
2.53.0.345.g96ddfc5eaa-goog


