Return-Path: <netdev+bounces-80651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F53880289
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 17:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8E5D2854E9
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 16:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B26017556;
	Tue, 19 Mar 2024 16:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdRCSYTG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F73314277
	for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 16:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710866362; cv=none; b=pa304AoX6ofWT+L4pQNjGj5ddfwSbBiU8xGfj+kVNOewa21e9huai5rUci4TsKmWu/VYYrqcTQPPqK+eTTcG7gzgSiGNKYXANeh9Fc/JNdRowDbEKNilfMgIcy5c1WmCBKXdUqfxK8/pOqFcBtQnMXksnIsPDERrCV4bf7MzoYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710866362; c=relaxed/simple;
	bh=LsJZaoWsPF8T5hK//H3L+IxM4cSkLaRJJhR/uXrNauw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R8jmGUsbDzPlT0EEELwZwfMpmJVDB5Pd5eIfPGgool5JncQWpYD+c1R7K6EysKou+8MRkWahPKpMYNgfqQU1BQDPW5H5K+gVvc4OErmhEiZnJzTDVFPJu15WYVV4A78L0NNTLc3c/Sjr1gEE8MuhxizF7CV36CHemNUMyWyNFTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AdRCSYTG; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-413f76fcf41so43382275e9.3
        for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 09:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710866358; x=1711471158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLiXyXqPRoAg2rNwMePWdy+19fkko5dr46sIH+5enIg=;
        b=AdRCSYTGsS3ILCIoXUO1m55IFOL0xNKuz1/Aiogn+oXQQRO9BdOaWRIw16vCxOu2sp
         4Fkh5xjMPWUN3oU9wsoPh1Dl78jUOZZQ6+TLBPcrHVCp+CXJ4WMlzHjKLbmcx28OrTcd
         005Sv3bZoy6rbQ3H3m1q2OuM/5T/x775QB3NoPEhLOibBQq3y3GSMN+9IdCihFc1pjqD
         pZA6aw9GHVaNvdPKVuizRXy94oY7gwgZGeYGAXxMFREOX/iy81QMNeKPRF5U78XgCEOX
         w0gRsJIRbsOq2ZBqEry/2cFkdZVnA3ELcV2j0mYgZvJ9CzOw5r1HXhLa8a5q28u2ZzME
         Kysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710866358; x=1711471158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QLiXyXqPRoAg2rNwMePWdy+19fkko5dr46sIH+5enIg=;
        b=WVtjTXXTfCJD9lbKhNd8TN18hcTQOnJtX5MG+xXvzTiaaI9C3TkRt9lb3YEa+tNh8C
         6K2HP7zXQjY9yRbJYY9wEaT73lBq+2lxfwtswWXt0IfVlsOu3FGEhPCdXfIWtd+AtEcK
         4jGfsfa1IrEjtBGVno+eOSTqgNidGnj213WJpT054ffLZIgfcr0xLSFVBIcMkUko1Pod
         Hrjr3S6JdFK4EPDOGMo9Ger8f2dgx+ViqBEFSfJmT4kqYXqM9E/InYfg4Q+QfdUVQ9Sv
         Y0f6VMbUtLvmrcoCOX5f4uwgQ1l8wRqzBGsAjqxLN9luf8f7qUpL7pkZpv6VS5awVO3i
         aW5A==
X-Gm-Message-State: AOJu0YwWKXAVZXCNfK5m4AoufMzU+TC1ffIHhKfuX7qgeOYsiBGR+DbY
	TLD+Pvop6CLvyT7F+Jn+CXgL8qVl5j9X4Egr2RxeBkltdhgHWJdSK8n7CjWELPY=
X-Google-Smtp-Source: AGHT+IGzg6ZvpBBwOB7ZfNyjtMNjSzx68+W1XUc+9cZv5EJOxqNHnLYhd0PYXCnmGSSo+MuQ7Ol35Q==
X-Received: by 2002:a05:600c:4ecb:b0:414:255:f248 with SMTP id g11-20020a05600c4ecb00b004140255f248mr2603124wmq.23.1710866358104;
        Tue, 19 Mar 2024 09:39:18 -0700 (PDT)
Received: from bzorp2.lan ([2001:861:5870:c460:31fb:df04:125e:e8c8])
        by smtp.gmail.com with ESMTPSA id h15-20020a05600c314f00b0041408e16e6bsm11220179wmo.25.2024.03.19.09.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 09:39:17 -0700 (PDT)
From: Balazs Scheidler <bazsi77@gmail.com>
X-Google-Original-From: Balazs Scheidler <balazs.scheidler@axoflow.com>
To: netdev@vger.kernel.org
Cc: Balazs Scheidler <balazs.scheidler@axoflow.com>
Subject: [PATCH net-next v2 2/2] net: udp: add IP/port data to the tracepoint udp/udp_fail_queue_rcv_skb
Date: Tue, 19 Mar 2024 17:39:08 +0100
Message-Id: <9f083bed8b74cadee2fc5fb3269f502a8f578aae.1710866188.git.balazs.scheidler@axoflow.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1710866188.git.balazs.scheidler@axoflow.com>
References: <cover.1710866188.git.balazs.scheidler@axoflow.com>
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
index 336fe272889f..f04270946180 100644
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
+		*p32 = inet->inet_daddr;
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


