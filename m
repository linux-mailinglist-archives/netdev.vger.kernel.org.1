Return-Path: <netdev+bounces-138218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0159ACA10
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 14:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27CBF2835A6
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 12:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A751AA795;
	Wed, 23 Oct 2024 12:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcmc8zG+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBA7153BED;
	Wed, 23 Oct 2024 12:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729686833; cv=none; b=hYIr2jqoNv55CpHxRsF+vs2dbI2b4CPMgmSwHD2hoG2ii8Eu4ckUzzElRc5a1kHoP6RfK9qFDNbhYPIuf9rq3cAqy2sIH0KR7d+mJ8SOlp7dZKQbda8X7vnwTg7e2MNWX+rZTolp5J3B71rO9xBVDzCKMCE8f9ZuFhbMd1qFkS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729686833; c=relaxed/simple;
	bh=gKeqeVjhHUZh+ESzvZDJjMrqbNux/iGxBvsEukSEH4I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uFmdAVmAKPJHVDsXBGX4N6VmuUn9WwSdgcyK4FpKZ/hzSLupOYpnu1wOIUkNnQb5V5M+px9pb1E2VjpsxKYPeZ3KTm4UQjGtkgsw0YXbm4x+lXZEdkU00B2dBjKl+KgJeAvXU8NcqmHa4z/bmNAAyXPbittA6XJu5VS2TJrlBL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mcmc8zG+; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20e576dbc42so50167375ad.0;
        Wed, 23 Oct 2024 05:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729686831; x=1730291631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aFMUoRiKams8qBaX6W+JDQ3XrVb5ZlSwxg7abK4rGBY=;
        b=mcmc8zG+v8MWmw7uH+fvAQdacoJrW3O7EZrSoYN1z6q1i9u1cCHxlQsxuRP4t80FX+
         SLVYsBiXC+u96PBIx5UBEhrdTPqeh9BVvutnCcVqTnJTYjyWEl3ec7hsg9W/zMaQbQtr
         VgaByzBIB8H6yKDxzQ0NYvJoC4l3jnw3MdafjrL7eC1RmGC/7QR3ZNzhJNKnMQiKcOvi
         ern2AXNQCbBCKttuLuqzFrrm4x+Kh6H9Fk5pJPZkrzn5TIqUNRltYOHut3CulDdLcc2I
         6yHCbP5crOuaV3CqJlKi2VBx3UH/wHaXKH69iV8KmazOfZZuDgsJnCm3FtH5al4QlrdH
         BFQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729686831; x=1730291631;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aFMUoRiKams8qBaX6W+JDQ3XrVb5ZlSwxg7abK4rGBY=;
        b=bNNMHzO2FYVceZd3UcQyTMAx+/c9uAGksMtc+RfCw4+1XFMVOclBhmspPo7Q53NgZf
         fvOy3SOm+qN8hkBZY3qQXs9Mod5chwrrt0cglb7P9X34llZ97lj3nHQogkc56k8XZr5e
         5vSWN7jSgvNFzg9+yclWunUeCWs9v85eJne7CqSC9qiJ3gktJIhMTFfJyJNUbG0ubhdb
         LCiXxEitERip4Nvcnsij+XHESW+gzpxKB4jwirQjIEUA/GdcycW8hlaXLSMpWxU65iam
         McFjJy18yEZmgKXQMGJpLOGN/lts2JQ9n6LbIFr+QK229KR+04zurjPKYtlHU6/8C2gF
         8OGg==
X-Forwarded-Encrypted: i=1; AJvYcCXh8zZ+6m7Slx7E6YGI8Ip5lTHIh8doGGUAp0HNUL0lc87zHZc1OfbkIdWHnQlvnEF/pbw9uowFEvglZzwN9D+xjWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWsHuD/S8UzHJDqfIt8yd/7jdW2hkW9SJiiKtaBBdDnUwP8H7p
	FC4oZOR3Hjr2BdwYG1Vs19F6e1m6ALIh6d62WYvqhxqt17SsECxI
X-Google-Smtp-Source: AGHT+IEDRB2GOfj0ZvS2PC9NICvNP04PNbT/YtDTesmQlfun1kXwRk8EQ7rEtlg6auTSxxiGEu18bQ==
X-Received: by 2002:a17:902:da8f:b0:20c:a175:b720 with SMTP id d9443c01a7336-20fa9deb65dmr28134295ad.1.1729686831550;
        Wed, 23 Oct 2024 05:33:51 -0700 (PDT)
Received: from localhost.localdomain ([39.144.105.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7ef1330csm56784335ad.86.2024.10.23.05.33.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2024 05:33:51 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: edumazet@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>,
	Menglong Dong <menglong8.dong@gmail.com>
Subject: [PATCH] net: Add tcp_drop_reason tracepoint
Date: Wed, 23 Oct 2024 20:32:12 +0800
Message-Id: <20241023123212.15908-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We previously hooked the tcp_drop_reason() function using BPF to monitor
TCP drop reasons. However, after upgrading our compiler from GCC 9 to GCC
11, tcp_drop_reason() is now inlined, preventing us from hooking into it.
To address this, it would be beneficial to introduce a dedicated tracepoint
for monitoring.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Menglong Dong <menglong8.dong@gmail.com>
---
 include/trace/events/tcp.h | 53 ++++++++++++++++++++++++++++++++++++++
 net/ipv4/tcp_input.c       |  1 +
 2 files changed, 54 insertions(+)

diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index a27c4b619dff..056f7026224c 100644
--- a/include/trace/events/tcp.h
+++ b/include/trace/events/tcp.h
@@ -12,6 +12,7 @@
 #include <net/tcp.h>
 #include <linux/sock_diag.h>
 #include <net/rstreason.h>
+#include <net/dropreason-core.h>
 
 /*
  * tcp event with arguments sk and skb
@@ -728,6 +729,58 @@ DEFINE_EVENT(tcp_ao_event_sne, tcp_ao_rcv_sne_update,
 	TP_ARGS(sk, new_sne)
 );
 
+#undef FN
+#undef FNe
+#define FN(reason)	{ SKB_DROP_REASON_##reason, #reason },
+#define FNe(reason)	{ SKB_DROP_REASON_##reason, #reason }
+
+TRACE_EVENT(tcp_drop_reason,
+
+	TP_PROTO(const struct sock *sk, const struct sk_buff *skb,
+		 const enum skb_drop_reason reason),
+
+	TP_ARGS(sk, skb, reason),
+
+	TP_STRUCT__entry(
+		__field(const void *, skbaddr)
+		__field(const void *, skaddr)
+		__field(int, state)
+		__field(enum skb_drop_reason, reason)
+		__array(__u8, saddr, sizeof(struct sockaddr_in6))
+		__array(__u8, daddr, sizeof(struct sockaddr_in6))
+	),
+
+	TP_fast_assign(
+		__entry->skbaddr = skb;
+		__entry->skaddr = sk;
+		/* Zero means unknown state. */
+		__entry->state = sk ? sk->sk_state : 0;
+
+		memset(__entry->saddr, 0, sizeof(struct sockaddr_in6));
+		memset(__entry->daddr, 0, sizeof(struct sockaddr_in6));
+
+		if (sk && sk_fullsock(sk)) {
+			const struct inet_sock *inet = inet_sk(sk);
+
+			TP_STORE_ADDR_PORTS(__entry, inet, sk);
+		} else {
+			const struct tcphdr *th = (const struct tcphdr *)skb->data;
+
+			TP_STORE_ADDR_PORTS_SKB(skb, th, entry->saddr, entry->daddr);
+		}
+		__entry->reason = reason;
+	),
+
+	TP_printk("skbaddr=%p skaddr=%p src=%pISpc dest=%pISpc state=%s reason=%s",
+		  __entry->skbaddr, __entry->skaddr,
+		  __entry->saddr, __entry->daddr,
+		  __entry->state ? show_tcp_state_name(__entry->state) : "UNKNOWN",
+		  __print_symbolic(__entry->reason, DEFINE_DROP_REASON(FN, FNe)))
+);
+
+#undef FN
+#undef FNe
+
 #endif /* _TRACE_TCP_H */
 
 /* This part must be outside protection */
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index cc05ec1faac8..44795555596a 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4897,6 +4897,7 @@ static bool tcp_ooo_try_coalesce(struct sock *sk,
 static void tcp_drop_reason(struct sock *sk, struct sk_buff *skb,
 			    enum skb_drop_reason reason)
 {
+	trace_tcp_drop_reason(sk, skb, reason);
 	sk_drops_add(sk, skb);
 	sk_skb_reason_drop(sk, skb, reason);
 }
-- 
2.43.5


