Return-Path: <netdev+bounces-76062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C7986C2A9
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 08:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 890B1284B91
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 07:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4257481DF;
	Thu, 29 Feb 2024 07:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGBBwT5V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51C947F62
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 07:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709192297; cv=none; b=kLVpfzCgZ7d2rIrwI6iwpElnnIUHSilejYNed0V6pkHV0/qeqzmiokTnk0m62spsebfKE57SpdHJ3xa0jha4k0m9iNAVx0xjZX9yix3pI/EIjDTSOlJGvnL5wjRxz3ql3GG84mE6wpAEzGrXQGU+WT4BfWZQUg/kzbSI0Faxp7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709192297; c=relaxed/simple;
	bh=7nhZ0mts8SvKtOtUPWCX1yKj68lxNuDfy7a4v1OIhkI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sxC9USUhUTkc9W5EXrlp0UXNwJtt1lWC83fsndrn4CCJvpznKOxQ6WXd0dNI1GEzE4DVkaSi0qHjdHyYL1iv4x+Q0aKICzAm/pRDjfxBnHeX7L6tQMr+TqxL1KPKYyeNtaczHPgp5s4K+jnP/pqeLXtvyQirKew1Zg0anqL/1Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGBBwT5V; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d275e63590so6383731fa.2
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 23:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709192293; x=1709797093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T91kWp+mr2HJ12LJOqCpCsPQpVeksUQ5n+ZkaKXmhfs=;
        b=nGBBwT5VL8pPVNdURPLIYKUqiVDE7c/uEFNkOgsYANclcbc9TRIDq8c7joEDRPnKGo
         1hEAEI8aTR8Xlo2WpkyViexMOP2ym5ElzxKilwsa+uCu0OyoYM0PFmhlJ3o2uX4lF9OM
         77+AMY4K5GVq8TnB9Dtg8CmpKnLxT/QAnOl9hNxVy1Dck8Ihf/zDLwoIDIqW36PdNKGu
         BQQ40b/ajNH7/8eG3pWmauhXTwlK9+9c80YVvNMJ6gwslJB6F4YdmA9z4o64CJ9y35qA
         /YY0Pj2YfKqaUEm2fKsJ71198SJHP364hSuWNJEwHTFnXP3hV02h4Bmx3DvIqAeHpwiM
         zgmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709192293; x=1709797093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T91kWp+mr2HJ12LJOqCpCsPQpVeksUQ5n+ZkaKXmhfs=;
        b=pSiHg/MrtmQ4NqfScYqxkZDFxOlZ44V9jBxAhJSiQ4jyw/IJQ5O0QJ8mTHItQZtu1z
         JQlSgwAxmohjYfDbO585GO6VFucG+OeIHSeWw7iwBhkpXvlexOtZQyDK0SLH1kFOF3sk
         jRZSAryFC9awinYSfJeCNf7l2opBRRIOhU/1WYYjglpmxFlngQqbRGq/S9OiHz7EJBzJ
         aGLmIf1ZuSkhTZ7owd7Z/RW48g8rwRwe2kbpNg4J93TMFk/p5evWTYa8WeKLLQr+fqHK
         uTxZybDCD7BEKJg7z0g2PGV0KOAph2/SSfiMX+wgtDX7EPgMNBtM32tRDEx/H9vnRB5D
         ug2Q==
X-Gm-Message-State: AOJu0Yzb9jH/xKWgesJDBed7HuSivuluF0czhLa7avWALOAP3lmrz8jE
	Z7XayheblgGm1y4NEj4F429cnGL+JuLPJTxMVytWEtOmvB+SvMnfMtk9wFc3
X-Google-Smtp-Source: AGHT+IHf/HzOc7gRh1CwoqaNiJPfMiPzUaKy2YjlVKMT3emOWtFu9e5PjoEZIvWeJO9BmWd2+5pRfQ==
X-Received: by 2002:a2e:a40d:0:b0:2d3:9b4:4363 with SMTP id p13-20020a2ea40d000000b002d309b44363mr341106ljn.23.1709192293423;
        Wed, 28 Feb 2024 23:38:13 -0800 (PST)
Received: from localhost.localdomain (92-249-182-64.pool.digikabel.hu. [92.249.182.64])
        by smtp.gmail.com with ESMTPSA id q16-20020a5d6590000000b0033d56aa4f45sm945017wru.112.2024.02.28.23.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 23:38:12 -0800 (PST)
From: Balazs Scheidler <bazsi77@gmail.com>
X-Google-Original-From: Balazs Scheidler <balazs.scheidler@axoflow.com>
To: netdev@vger.kernel.org
Cc: Balazs Scheidler <balazs.scheidler@axoflow.com>
Subject: [PATCH net-next 2/2] net: udp: add IP/port data to the tracepoint udp/udp_fail_queue_rcv_skb
Date: Thu, 29 Feb 2024 08:38:00 +0100
Message-Id: <cb07bca5faf1fe3c3d4f7629cb45dbf2adb520cb.1709191570.git.balazs.scheidler@axoflow.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1709191570.git.balazs.scheidler@axoflow.com>
References: <cover.1709191570.git.balazs.scheidler@axoflow.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The udp_fail_queue_rcv_skb() tracepoint lacks any details on the source
and destination IP/port whereas this information can be critical in case
of UDP/syslog.

Signed-off-by: Balazs Scheidler <balazs.scheidler@axoflow.com>
---
 include/trace/events/udp.h | 33 +++++++++++++++++++++++++++++----
 net/ipv4/udp.c             |  2 +-
 net/ipv6/udp.c             |  3 ++-
 3 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/include/trace/events/udp.h b/include/trace/events/udp.h
index 336fe272889f..cd4ae5c2fad7 100644
--- a/include/trace/events/udp.h
+++ b/include/trace/events/udp.h
@@ -7,24 +7,49 @@
 
 #include <linux/udp.h>
 #include <linux/tracepoint.h>
+#include <trace/events/net_probe_common.h>
 
 TRACE_EVENT(udp_fail_queue_rcv_skb,
 
-	TP_PROTO(int rc, struct sock *sk),
+	TP_PROTO(int rc, struct sock *sk, struct sk_buff *skb),
 
-	TP_ARGS(rc, sk),
+	TP_ARGS(rc, sk, skb),
 
 	TP_STRUCT__entry(
 		__field(int, rc)
 		__field(__u16, lport)
+
+		__field(__u16, sport)
+		__field(__u16, dport)
+		__field(__u16, family)
+		__array(__u8, saddr, sizeof(struct sockaddr_in6))
+		__array(__u8, daddr, sizeof(struct sockaddr_in6))
 	),
 
 	TP_fast_assign(
+		const struct inet_sock *inet = inet_sk(sk);
+		const struct udphdr *uh = (const struct udphdr *)udp_hdr(skb);
+		__be32 *p32;
+
 		__entry->rc = rc;
-		__entry->lport = inet_sk(sk)->inet_num;
+		__entry->lport = inet->inet_num;
+
+		__entry->sport = ntohs(uh->source);
+		__entry->dport = ntohs(uh->dest);
+		__entry->family = sk->sk_family;
+
+		p32 = (__be32 *) __entry->saddr;
+		*p32 = inet->inet_saddr;
+
+		p32 = (__be32 *) __entry->daddr;
+		*p32 =  inet->inet_daddr;
+
+		TP_STORE_ADDR_PORTS_SKB(__entry, skb, uh);
 	),
 
-	TP_printk("rc=%d port=%hu", __entry->rc, __entry->lport)
+	TP_printk("rc=%d port=%hu family=%s src=%pISpc dest=%pISpc", __entry->rc, __entry->lport,
+		  show_family_name(__entry->family),
+		  __entry->saddr, __entry->daddr)
 );
 
 #endif /* _TRACE_UDP_H */
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index a8acea17b4e5..d21a85257367 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2051,8 +2051,8 @@ static int __udp_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
 			drop_reason = SKB_DROP_REASON_PROTO_MEM;
 		}
 		UDP_INC_STATS(sock_net(sk), UDP_MIB_INERRORS, is_udplite);
+		trace_udp_fail_queue_rcv_skb(rc, sk, skb);
 		kfree_skb_reason(skb, drop_reason);
-		trace_udp_fail_queue_rcv_skb(rc, sk);
 		return -1;
 	}
 
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 3f2249b4cd5f..e5a52c4c934c 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -34,6 +34,7 @@
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 #include <linux/indirect_call_wrapper.h>
+#include <trace/events/udp.h>
 
 #include <net/addrconf.h>
 #include <net/ndisc.h>
@@ -661,8 +662,8 @@ static int __udpv6_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
 			drop_reason = SKB_DROP_REASON_PROTO_MEM;
 		}
 		UDP6_INC_STATS(sock_net(sk), UDP_MIB_INERRORS, is_udplite);
+		trace_udp_fail_queue_rcv_skb(rc, sk, skb);
 		kfree_skb_reason(skb, drop_reason);
-		trace_udp_fail_queue_rcv_skb(rc, sk);
 		return -1;
 	}
 
-- 
2.40.1


