Return-Path: <netdev+bounces-287042-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MF0/C7T3AmqvzAEAu9opvQ
	(envelope-from <netdev+bounces-287042-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 11:49:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCBD51E0AB
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 11:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C1FD3029260
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 09:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5677A46AF3B;
	Tue, 12 May 2026 09:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IS1UyloX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7833B8BA4
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 09:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778579345; cv=none; b=Q4z8WdK2zdHXQ8uzT+qBJIhNfRyCZ/mFDbNt3WzbYMNoHgeRxcjZ6inkOPwlLUSgAU/3A3Otk27pXoaX4i9YNQUsjyiK/pBnI0oxl/iAnJWhk0yHqJrImOxv4nlfvub/Xo8qWCz3of/I4F43hiYJ4f5/AdVbGNwvz9WiJXbgw7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778579345; c=relaxed/simple;
	bh=rcDjbE+o3UVDj4QWFbRbHhYIfbHJRY3Ee8iD+lCHAfc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q3UJcIF1VUeQMv1csMbOvDpIMuNh6rnib0CU4Jsb6tBGtCLPd/N5Y6xcLXj5R+lgzHrO+1+ROgBSZmFdWn6C8BSIMxVAwnjRoNsQvUluCMv61MKOgZBkYie7+wb+0cW11PGnZHatIoEGzExanKNxp0peC3DlXDkr9V5+7vrBAbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IS1UyloX; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-8aca29dcd69so130662096d6.1
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 02:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778579343; x=1779184143; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XDL2VZbUlzG4U5iQAhsiTEGccmcIANjZZBmcS0EyLVo=;
        b=IS1UyloXTY6GBOFTrEwrnxSwQGUFqfewkW+c2Tu1gQRIiaEzqpqprTUtu0SDQnB6us
         F8D/SVvP1I7tXh8oqAVro+F/gGHhh/kYq5XWxKdagC81OgUXvvJHIQk/B6NtkVrlGgyI
         he+19KDW8O+7VNTnwfrMV8MrbRuM6GxGcYn/qf8eFrduTXqXLIoawDp2TD9PzK7mwaYN
         rkTkK0gPPpte6bU0E06fhvOX2DBG3ch7Xg2iNOoK9q+5kNZlAU/3XGH8A1hlVQkbDVgB
         sUxH+YNmbtCRHLi0CHjrh6tG2fNCp8q1zNwzonIuYsjmjJ4QRZ2JQblZpHgXdT83pzHt
         XbCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778579343; x=1779184143;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XDL2VZbUlzG4U5iQAhsiTEGccmcIANjZZBmcS0EyLVo=;
        b=tDU9pNjM9DNUBUVnyy/g7ao1DSeCrdWt8hVzxcrLQWMi1dXPdR1IiNHQlkhBQtvRb2
         rsmodyD8dKPyiHxRa6cKYg3XUYLY/uVxDiL/5k+/nX2luRPm+9LxvvkxhH5SiNEj4j9R
         Q8AjCuOaOb5F8Dc/ErfAwztaWu7S+5k4fPH1lbU4ZimSMEuvPzkcZ0SHqwlXVbEv8BJ7
         SFccrCYNlmiSgvy6fcd41t56sIHjcuOfwk+amRNwzNWWgk6HaDKRW0RHvGbXVZLw3zoL
         jw2D6g4poa2xsntJY64C2iWit1Ksfsd4e+aaAElOiSGY7y87kvgKRH96j0Q8wl0oc+OB
         EeSw==
X-Forwarded-Encrypted: i=1; AFNElJ+xMEsk9qJPX4cVoLM4g7hDDJYJ2dyAF9onwpfkDKaaTwpWAUvNCtJnslJif2F5aUvTNTcR7go=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU2uGW/CNR1sNyefLCLg7PgfDDJIXYogwLgtZyOSS6+keqv6HF
	S+k16m7o475zbf6pBzOkT9hmX8FlWOsNRXBNmea33SzDDth93FPu7OfqjbAAyrd7bVXnvQnp7nH
	3Sta0G+yeIqehcQ==
X-Received: from qvdf5.prod.google.com ([2002:a05:6214:1d25:b0:8a4:3dc7:d461])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a0c:e092:0:b0:8ac:b137:c4f4 with SMTP id 6a1803df08f44-8c1a2a03c87mr171546196d6.6.1778579342388;
 Tue, 12 May 2026 02:49:02 -0700 (PDT)
Date: Tue, 12 May 2026 09:48:58 +0000
In-Reply-To: <20260512094859.3673997-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512094859.3673997-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512094859.3673997-2-edumazet@google.com>
Subject: [PATCH net-next 1/2] net: make is_skb_wmem() available to modules
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@toke.dk>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 8DCBD51E0AB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,toke.dk,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287042-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Following patch will use is_skb_wmem() from fq_codel.

Provide __sock_wfree() only if CONFIG_INET=y

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/sock.h         | 12 +++++++++++-
 include/net/tcp.h          |  1 -
 net/core/skbuff.c          |  2 +-
 net/core/sock.c            |  3 +++
 net/core/sock_destructor.h | 12 ------------
 net/ipv4/inet_fragment.c   |  2 --
 net/ipv4/tcp_output.c      |  1 +
 7 files changed, 16 insertions(+), 17 deletions(-)
 delete mode 100644 net/core/sock_destructor.h

diff --git a/include/net/sock.h b/include/net/sock.h
index dccd3738c3687056b67c8de44fce9842dcc365ec..219917959b54582fdd3d78e8042e1bdfc43decd0 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1850,8 +1850,18 @@ static inline struct sock *sk_clone_lock(const struct sock *sk, const gfp_t prio
 
 struct sk_buff *sock_wmalloc(struct sock *sk, unsigned long size, int force,
 			     gfp_t priority);
-void __sock_wfree(struct sk_buff *skb);
 void sock_wfree(struct sk_buff *skb);
+#ifdef CONFIG_INET
+void __sock_wfree(struct sk_buff *skb);
+void tcp_wfree(struct sk_buff *skb);
+#endif
+static inline bool is_skb_wmem(const struct sk_buff *skb)
+{
+	return skb->destructor == sock_wfree ||
+	       (IS_ENABLED(CONFIG_INET) && skb->destructor == __sock_wfree) ||
+	       (IS_ENABLED(CONFIG_INET) && skb->destructor == tcp_wfree);
+}
+
 struct sk_buff *sock_omalloc(struct sock *sk, unsigned long size,
 			     gfp_t priority);
 void skb_orphan_partial(struct sk_buff *skb);
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 3c4e6adb0dbdcefdfa6c95d1738e2039dede3f32..5715e60c519a79232a3bed6682aa2c9cf97be22a 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -390,7 +390,6 @@ static inline bool tcp_release_cb_cond(struct sock *sk)
 	return false;
 }
 
-void tcp_wfree(struct sk_buff *skb);
 void tcp_write_timer_handler(struct sock *sk);
 void tcp_delack_timer_handler(struct sock *sk);
 int tcp_ioctl(struct sock *sk, int cmd, int *karg);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 7dad68e3b5186cf622a3ed5a6e87c09d46bc3fd6..11871836aa88ea1f16414a94628eb50336cd9653 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -78,6 +78,7 @@
 #include <net/mpls.h>
 #include <net/mptcp.h>
 #include <net/mctp.h>
+#include <net/tcp.h>
 #include <net/can.h>
 #include <net/page_pool/helpers.h>
 #include <net/psp/types.h>
@@ -96,7 +97,6 @@
 #include "devmem.h"
 #include "net-sysfs.h"
 #include "netmem_priv.h"
-#include "sock_destructor.h"
 
 #ifdef CONFIG_SKB_EXTENSIONS
 static struct kmem_cache *skbuff_ext_cache __ro_after_init;
diff --git a/net/core/sock.c b/net/core/sock.c
index b37b664b6eb92f375d6708a5a609f35f07ee2897..f362e3ce1efb672bc463c54b7a1b8f05785cba45 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2708,6 +2708,7 @@ EXPORT_SYMBOL(sock_wfree);
 /* This variant of sock_wfree() is used by TCP,
  * since it sets SOCK_USE_WRITE_QUEUE.
  */
+#ifdef CONFIG_INET
 void __sock_wfree(struct sk_buff *skb)
 {
 	struct sock *sk = skb->sk;
@@ -2715,6 +2716,8 @@ void __sock_wfree(struct sk_buff *skb)
 	if (refcount_sub_and_test(skb->truesize, &sk->sk_wmem_alloc))
 		__sk_free(sk);
 }
+EXPORT_SYMBOL_GPL(__sock_wfree);
+#endif
 
 void skb_set_owner_w(struct sk_buff *skb, struct sock *sk)
 {
diff --git a/net/core/sock_destructor.h b/net/core/sock_destructor.h
deleted file mode 100644
index 2f396e6bfba5a364727f98b160bf2fd3a3731958..0000000000000000000000000000000000000000
--- a/net/core/sock_destructor.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-#ifndef _NET_CORE_SOCK_DESTRUCTOR_H
-#define _NET_CORE_SOCK_DESTRUCTOR_H
-#include <net/tcp.h>
-
-static inline bool is_skb_wmem(const struct sk_buff *skb)
-{
-	return skb->destructor == sock_wfree ||
-	       skb->destructor == __sock_wfree ||
-	       (IS_ENABLED(CONFIG_INET) && skb->destructor == tcp_wfree);
-}
-#endif
diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
index 393770920abd794a47a933f2694afe3e2d08d25a..86b100694659ee51292625216113f9411b98a351 100644
--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -24,8 +24,6 @@
 #include <net/ip.h>
 #include <net/ipv6.h>
 
-#include "../core/sock_destructor.h"
-
 /* Use skb->cb to track consecutive/adjacent fragments coming at
  * the end of the queue. Nodes in the rb-tree queue will
  * contain "runs" of one or more adjacent fragments.
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 75eb18a2ad4e7ee126806e7a7cbf3d27a452cba5..47647a99e32443a3925a9a160a2da58f530e32e1 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1415,6 +1415,7 @@ void tcp_wfree(struct sk_buff *skb)
 out:
 	sk_free(sk);
 }
+EXPORT_SYMBOL_GPL(tcp_wfree);
 
 /* Note: Called under soft irq.
  * We can call TCP stack right away, unless socket is owned by user.
-- 
2.54.0.563.g4f69b47b94-goog


