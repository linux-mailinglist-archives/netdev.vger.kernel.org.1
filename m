Return-Path: <netdev+bounces-69970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B3784D247
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 20:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 142D51C22E77
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 19:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C061B85947;
	Wed,  7 Feb 2024 19:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jT/v4Ek2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D3385954
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 19:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707334678; cv=none; b=K7/P3bq/bM30qEHAc9C04CwSd++06WJrZ1OK5cZspdPx7j8s9LvBNOVNpYXbeN6jzUs7Q0r3iF1huKasJHx/cPCU5dhlT4gj9ru/7lsKR7FrNyU0Fx34RbwRCXP3k6a8sURdRerG3OCuuqxkb82T0E9e+pcZqXgpJWCXKuDVm64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707334678; c=relaxed/simple;
	bh=QyA6UKluX3jkxr8NCHrO9ZErbMJXdVQVd0R9eCNrYoE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FLd6j7Oa993V2lcUDecdDQ6tRE1rf3tFDNKHPEmdsPr1FZQhOIQ0scNOO0/joIeg28qms3f7Qu0IVQ0xzSUi/LQd/C9yKi3DnWV29JD6l+QDKgVvnUDWI7c8AoY7dtmIr6KiMCA5/En7Gb634cWJa25kSwZiGSyKAR8xhWkKtB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jT/v4Ek2; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a29c4bbb2f4so136039166b.1
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 11:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707334675; x=1707939475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gHeMkiErZ2Il5EQnYZZmRCGbM4o7rILbjhYodaCOJzs=;
        b=jT/v4Ek2rQvSkS0gZPZHe913ho7pU58GWnCNeFP+bhMOaGSbOG/rdCVMqEh5Iyl8MC
         I5eEpNHDmcPFjjruYh/GRICSnKtU/aeaGaNgTqM0fwAPB2k9gcPJiyWeI7sSiNquanOb
         kI/jRiWPwSYGSGmS5pmSmSu/UJJmHtLyophqcY1g4v3dxz1LJ4t/KUNCrqe3h/8wqLJD
         L6fkbfXR/Gycnpc0nCsUQp0s3ZaOFjhvcnL4MOAOVRZhZwoHW29yBai+iJR5i5Xpu9er
         fW+VyCNvfbHzUtkEXun5riHt7OJ0x0MdFn/nmk5nME1bj53li59VCgcVMJ/DWYUvWsCK
         UIaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707334675; x=1707939475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gHeMkiErZ2Il5EQnYZZmRCGbM4o7rILbjhYodaCOJzs=;
        b=n4vg3tzF8SruK/etwXGqKg+vUbjf7MH+8bHks7iFlcO9+MOVlHHeQKsPcspCswHq5O
         Dt3FnL8eOTcegPG3FPySK3mdE5pI062aUav+KuuemIHwR9B55XY4iOxFVqkbyhyjmuNn
         6lpMjbt1CLTNWL8xSYTCyXRyOykLcRG6cqx2QMu2InEB0xex1tEMhmhWmMWOTGmZGlXe
         nSPgfo3q7TwNkj1VBI5OBjuWQlfMSsVcc1uMtipVDzKIQmIknro5S3X76zyqAvLRyPbR
         jZJE23+stJv3cJKlJgaxRWUAwBR5qUrdVjJinaLPGfSdtx5pkOiYnUwTrwxbzsJgYc2Z
         to4g==
X-Gm-Message-State: AOJu0Yy8CWgG+xWxJWKvMKCQVP7idWJPDQbO3sQohclWmB4jVCJJae1e
	tRDnjDIhbh1fT8j2aF/alxmISds20prM/dDrA7QEWvp9d6CH5zSOWuzB/MeM
X-Google-Smtp-Source: AGHT+IE/yBsvqOm1VfwLsTJYwFqbIwlSWFtdkXHwMrfQX5zebbQr7g3gBPs1t5tFBY8ILQCj5+Seiw==
X-Received: by 2002:a17:906:2818:b0:a36:f314:d8be with SMTP id r24-20020a170906281800b00a36f314d8bemr4897493ejc.38.1707334674681;
        Wed, 07 Feb 2024 11:37:54 -0800 (PST)
Received: from localhost.localdomain (178-164-213-103.pool.digikabel.hu. [178.164.213.103])
        by smtp.gmail.com with ESMTPSA id vw1-20020a170907a70100b00a3896ef417dsm483815ejc.180.2024.02.07.11.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 11:37:54 -0800 (PST)
From: Balazs Scheidler <bazsi77@gmail.com>
X-Google-Original-From: Balazs Scheidler <balazs.scheidler@axoflow.com>
To: netdev@vger.kernel.org
Cc: Balazs Scheidler <balazs.scheidler@axoflow.com>
Subject: [RFC net-next 2/2] net: udp: add IP/port data to the tracepoint udp/udp_fail_queue_rcv_skb
Date: Wed,  7 Feb 2024 20:37:16 +0100
Message-Id: <a40921456a1d38855aa3e87e3b5da133b5adb36d.1707334523.git.balazs.scheidler@axoflow.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1707334523.git.balazs.scheidler@axoflow.com>
References: <cover.1707334523.git.balazs.scheidler@axoflow.com>
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
index 89e5a806b82e..35bbf0a525b3 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2055,8 +2055,8 @@ static int __udp_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
 			drop_reason = SKB_DROP_REASON_PROTO_MEM;
 		}
 		UDP_INC_STATS(sock_net(sk), UDP_MIB_INERRORS, is_udplite);
+		trace_udp_fail_queue_rcv_skb(rc, sk, skb);
 		kfree_skb_reason(skb, drop_reason);
-		trace_udp_fail_queue_rcv_skb(rc, sk);
 		return -1;
 	}
 
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 622b10a549f7..1da659f8928b 100644
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


