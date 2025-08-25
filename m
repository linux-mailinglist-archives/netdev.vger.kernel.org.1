Return-Path: <netdev+bounces-216611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E78DB34B4A
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 22:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A54D2049C4
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 20:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B732877D0;
	Mon, 25 Aug 2025 19:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qsO2n7uE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0798287512
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 19:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756151997; cv=none; b=m8TMZsvFLosq2u+ToeeiWrUEiNFp82YYz1g7CnXvC9xuRMeBGXmAU+x6wI8DJx4Xp22+N2jjfEDQt9JKwrvkfjOCXB0pWDo/Usb/yY6E3H+awlWoDZLxqhoC004p4UxrEYvjWVOWhKOe4gzx+g9/ZAL37BHf49rRzAcAr0uiwTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756151997; c=relaxed/simple;
	bh=IP0xYqJikMMV9OwiNaWycClcyuLEFEka8WXILSfJzkA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gNXAIRnvlDYivrpoAbWMEcWjPKLHgWcyAIqQ1tniD2cTTEz02lgPFx5/7v1YAwfUKEPQ97o+rOi34Z1nTC78iGTomZEub8dL7DyOxBYi1e2j+lJuf+H9wU05pHlCPQd8pmhj4brXqTgoAgmi5BE6qCRC6tsWhI2ruZB38qhZ7fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qsO2n7uE; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7e8702f4cf9so1193559385a.0
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 12:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756151995; x=1756756795; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JOuZlZnm1KFj0imYDJhWewPNdB4E+pfDyE+uoBphV5o=;
        b=qsO2n7uE1Ic6CJbxEfd0mZ2TNH0lDQ44jZiw8Ac/+KFd+HnOy/bkOEW5VXK5XFxrO9
         JqumM4Hxh8ledyqWl9iL8J/USLaf9vkJQHRY4ulZ/AC4gQMh5KukqH4pHv0NJqLfj2rD
         7ZJCtXj45pJwzeCmJeBjZ7qA7bFTKqeCQZLauxpwuujCg0rL3ITLMJj2iUXylT1Ch536
         sCUSCu9AFtm8lb1rY8Yt4bPV9u7Gqol+g6u7HilKEhCx2woFsR3jcCb5CoNCDZci1xyg
         zau36TM2tPvOeD5jYBRKukyrPWLGO+mkzSE0iWdH8zxnOAhEeXuDhKsXrPTIR8TNB44Z
         ghpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756151995; x=1756756795;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JOuZlZnm1KFj0imYDJhWewPNdB4E+pfDyE+uoBphV5o=;
        b=e9+D7EdltVvvuDVuo7dUSjeVgZNFU9fkUt1ay7Vdyl1taK9Nrb2YkkYVFt7u1B/136
         MQDW1Hh6G6xlnufKgtd0tgY0CtRtQGkPBaoR39Mb6dP4+7qku05g9QELkh1uvVerY8/6
         IYo8pr80iHj6hDfXOxiEKYXHVhC0QcUKooHfgAzfhmIdyLBwODebpbu6o8+BJbFHYfZf
         13TXCWOUWjjHeE/E99Dx/GYS6BbP/fxnt1wG/4Lkj5ya2n8pC/awduqZ2WfxmVOqQwjS
         tKByXVPZ9Y4pMreIewm96ub9fqgvoKj/b4tDXypemZg7sNGnM9jV/n068O2EiTdfxLW9
         haVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEqX0yyVqXPMH6sUCyQM/cRJWkqYndp3Y3c4imzjmR9+1mOaV8SF8koFLfYNTa6XDRq2IS8EU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5q1VOkLt4JAHwl/dm85/i6PJAZMyWOTrs/hIonU2l1Ca0n3HD
	xTwEcX8MnRVz6QPmjtW24X4T934EJnxF3e77W9+h05VMdmZ7zzHaWL62PtEKaqbbpXYaAe3PDjS
	ewXKfYGYlaqDe1w==
X-Google-Smtp-Source: AGHT+IFRf4v5vUQNv2kkjt9EQMy5M5pG3kuQcHA73uheTn/YK+IP6pl0pO+TBHUHPZH9vTJEi5W1My1jsKL8MA==
X-Received: from qkpo3.prod.google.com ([2002:a05:620a:2a03:b0:7f0:88e2:5f5c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:aa02:b0:7e9:f81f:cea4 with SMTP id af79cd13be357-7ea110a5f3fmr1418669785a.82.1756151994660;
 Mon, 25 Aug 2025 12:59:54 -0700 (PDT)
Date: Mon, 25 Aug 2025 19:59:46 +0000
In-Reply-To: <20250825195947.4073595-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250825195947.4073595-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250825195947.4073595-3-edumazet@google.com>
Subject: [PATCH net-next 2/3] net: move sk_drops out of sock_write_rx group
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Move sk_drops into a dedicated cache line.

When a packet flood hits one or more sockets, many cpus
have to update sk->sk_drops.

This slows down consumers, because currently
sk_drops is in sock_write_rx group.

Moving sk->sk_drops into a dedicated cache line
makes sure that consumers no longer suffer from
false sharing if/when producers only change sk->sk_drops.

Tested with the following stress test, sending about 11 Mpps:

super_netperf 20 -t UDP_STREAM -H DUT -l10 -- -n -P,1000 -m 120
Note: due to socket lookup, only one UDP socket will receive
packets on DUT.

Then measure receiver (DUT) behavior. We can see both
consumer and BH handlers can process more packets per second.

Before:

nstat -n ; sleep 1 ; nstat | grep Udp
Udp6InDatagrams                 615091             0.0
Udp6InErrors                    3904277            0.0
Udp6RcvbufErrors                3904277            0.0

After:
nstat -n ; sleep 1 ; nstat | grep Udp
Udp6InDatagrams                 855592             0.0
Udp6InErrors                    5621467            0.0
Udp6RcvbufErrors                5621467            0.0

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/sock.h | 6 +++---
 net/core/sock.c    | 1 -
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 34d7029eb622773e40e7c4ebd422d33b1c0a7836..f40e3c4883be32c8282694ab215bcf79eb87cbd7 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -390,7 +390,6 @@ struct sock {
 
 	__cacheline_group_begin(sock_write_rx);
 
-	atomic_t		sk_drops;
 	__s32			sk_peek_off;
 	struct sk_buff_head	sk_error_queue;
 	struct sk_buff_head	sk_receive_queue;
@@ -564,13 +563,14 @@ struct sock {
 #ifdef CONFIG_BPF_SYSCALL
 	struct bpf_local_storage __rcu	*sk_bpf_storage;
 #endif
-	struct rcu_head		sk_rcu;
-	netns_tracker		ns_tracker;
 	struct xarray		sk_user_frags;
 
 #if IS_ENABLED(CONFIG_PROVE_LOCKING) && IS_ENABLED(CONFIG_MODULES)
 	struct module		*sk_owner;
 #endif
+	atomic_t		sk_drops ____cacheline_aligned_in_smp;
+	struct rcu_head		sk_rcu;
+	netns_tracker		ns_tracker;
 };
 
 struct sock_bh_locked {
diff --git a/net/core/sock.c b/net/core/sock.c
index 75368823969a7992a55a6f40d87ffb8886de2f39..cd7c7ed7ff51070d20658684ff796c58c8c09995 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -4436,7 +4436,6 @@ EXPORT_SYMBOL(sk_ioctl);
 
 static int __init sock_struct_check(void)
 {
-	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_rx, sk_drops);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_rx, sk_peek_off);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_rx, sk_error_queue);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct sock, sock_write_rx, sk_receive_queue);
-- 
2.51.0.261.g7ce5a0a67e-goog


