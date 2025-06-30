Return-Path: <netdev+bounces-202363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35779AED8DA
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 11:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B59D73B6676
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 09:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6582472BE;
	Mon, 30 Jun 2025 09:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="byvFWkpC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CA9242D6C
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 09:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751276151; cv=none; b=cqPArnlstSTLUAVfJ9LXw7JRUNXnhIfmpeeSZx4DInmcAwlg8EtPvLB+Oevrbl2oN0qz5pbGJb6/0cAbz3nZknRrD7aM1GcHrQnef6UGZILyO2CUsVEPAPmZzTKIp2+B3tbjFWZ5odYn8e6jvEsagWJF/RTLnRV6aT4Chb010No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751276151; c=relaxed/simple;
	bh=FLGfPSZqn04LnVV3fsevUaLr7ZMT+K+1SD2xlrhKkeY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PrIaWKeARi1FqYpIpm32kB4am0XB304SP94BA2bLeWNp/EbjwZMYFPadnF6OTh6H5mLHa/neQR1Nt3uuFqojxuyvtruKasxlsDg+6fW1odtjEwDd3+7gy9zm+2ZSWoQa2ydNQ3erRVbOKayhZPHeI6vk2WtDC0+cJZOfyg1r7rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=byvFWkpC; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-6fad9167e4cso48103116d6.1
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 02:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751276148; x=1751880948; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vePTT8zeRt93uo2AosUtq7UKSw52RpcF3kFVzhseee4=;
        b=byvFWkpCyNIHf7Ni/u5YV1d7xqHMpfwlhxh83ZGryIFR/jdwu8zV5kKZZAVFVeStAB
         ruNrbNuqQ2wRGj7wdSOBxmjpIY26yyYCG5SPOuceTFRT+tlZzyQ+vfPw5aXxGxcTQv1h
         T5QjyGmuJaVLjvJvyTQp/febixUpuqbOX6lc9MMx4fYIManGluCnnC9XkgfW7bZvy4+D
         pbxW3GDXavigPKXwtZfd3NDuOxPztJI3kQgunQJpdkJMUqIC8v0qoKw0oTZYvNc72zal
         pSXGPE5RAIKNRITj+shMQKevQqZi3DTCYZnCNlYfT4pXDKZRBwYbCbEo3HS8ts35pl1w
         MNUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751276148; x=1751880948;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vePTT8zeRt93uo2AosUtq7UKSw52RpcF3kFVzhseee4=;
        b=vHT9ZCCbN/mrKLj/SQ4nTM6K8Jvw5pmsKU6Ypj0BTy4rbwAQOO7G74pUcuK2KptXag
         ABqLsWOhFEovj5rjUh9ivyaRdNkOqS9LTPMavFhg9HsWoT/JcXuAcZUpa3ibPLY8vVoD
         PooE/Z3PM/kn0uxBERpAoRHOXmf50JxUCRX3GFWb0WKHEJBGwN9UCKhZUU3fO8ApMn3R
         cRBF5cMB7Xfq+/XXxPnJSj16/4ZRof7qqjb1v5evN+cXO24Nxjc5u80r52h2RieXhfMQ
         E2BtnSL8tM2L0lZN6vAmcN9uEIW13t5j5ZFZFtlqFeTtZluv6cJMx0YDkKG4stDAtYI2
         HHIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUVpe5SCBBYBKbdGE/pIRgmX8h/wNkRKsgfdoyPZSZWT2wk5ku78sJMzVVhejv64I4LxNDBIo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yztk7NeX5D73rwq7sMFHR0Of7h58mGoLhOrcUqTkJYB1Ne9aAMq
	Lct1RSh43m7ep36jnQXk9c6uI+ldcey3SI6fWMjYx48SlMw+gKvkmJMdkt7wlr+Nyx0hhV2Za69
	VTlqGlwSFMTzFJA==
X-Google-Smtp-Source: AGHT+IHr9Od2bwj2YyBnrHz5x2CNtNoIw5SY1FI81XKnnBpGdfhNZgTFxQCT8sGQKy8JPuvd/SAH+vOdImg0vQ==
X-Received: from qvboo33.prod.google.com ([2002:a05:6214:4521:b0:6fa:ec56:406d])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:300c:b0:6fd:ace:4cfb with SMTP id 6a1803df08f44-7000214f5fcmr261881756d6.27.1751276148279;
 Mon, 30 Jun 2025 02:35:48 -0700 (PDT)
Date: Mon, 30 Jun 2025 09:35:39 +0000
In-Reply-To: <20250630093540.3052835-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250630093540.3052835-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250630093540.3052835-4-edumazet@google.com>
Subject: [PATCH v2 net-next 3/4] tcp: move tcp_memory_allocated into net_aligned_data
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

____cacheline_aligned_in_smp attribute only makes sure to align
a field to a cache line. It does not prevent the linker to use
the remaining of the cache line for other variables, causing
potential false sharing.

Move tcp_memory_allocated into a dedicated cache line.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 include/net/aligned_data.h | 3 +++
 include/net/tcp.h          | 1 -
 net/core/hotdata.c         | 2 ++
 net/ipv4/tcp.c             | 2 --
 net/ipv4/tcp_ipv4.c        | 3 ++-
 net/ipv6/tcp_ipv6.c        | 3 ++-
 net/mptcp/protocol.c       | 3 ++-
 7 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/net/aligned_data.h b/include/net/aligned_data.h
index 5c7badf71f043a2bbc871b0063c9a2d2a4ffbfcb..bedb4f86b0fea1ce13a10895182681c37ef7e904 100644
--- a/include/net/aligned_data.h
+++ b/include/net/aligned_data.h
@@ -11,6 +11,9 @@
  */
 struct net_aligned_data {
 	atomic64_t	net_cookie ____cacheline_aligned_in_smp;
+#if defined(CONFIG_INET)
+	atomic_long_t tcp_memory_allocated ____cacheline_aligned_in_smp;
+#endif
 };
 
 extern struct net_aligned_data net_aligned_data;
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 761c4a0ad386f95f73d72dc013a0952187342b51..bc08de49805cf6fc2ffbec96e42bf12378fd10cf 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -267,7 +267,6 @@ extern long sysctl_tcp_mem[3];
 #define TCP_RACK_STATIC_REO_WND  0x2 /* Use static RACK reo wnd */
 #define TCP_RACK_NO_DUPTHRESH    0x4 /* Do not use DUPACK threshold in RACK */
 
-extern atomic_long_t tcp_memory_allocated;
 DECLARE_PER_CPU(int, tcp_memory_per_cpu_fw_alloc);
 
 extern struct percpu_counter tcp_sockets_allocated;
diff --git a/net/core/hotdata.c b/net/core/hotdata.c
index e9c03491ab001cc85fd60ad28533649b32d8a003..95d0a4df10069e4529fb9e5b58e8391574085cf1 100644
--- a/net/core/hotdata.c
+++ b/net/core/hotdata.c
@@ -4,6 +4,7 @@
 #include <linux/list.h>
 #include <net/aligned_data.h>
 #include <net/hotdata.h>
+#include <net/ip.h>
 #include <net/proto_memory.h>
 
 struct net_hotdata net_hotdata __cacheline_aligned = {
@@ -25,3 +26,4 @@ struct net_hotdata net_hotdata __cacheline_aligned = {
 EXPORT_SYMBOL(net_hotdata);
 
 struct net_aligned_data net_aligned_data;
+EXPORT_IPV6_MOD(net_aligned_data);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 8a3c99246d2ed32ba45849b56830bf128e265763..925b2c572ca23b3f2eba48a38820f6553a2724f4 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -302,8 +302,6 @@ EXPORT_PER_CPU_SYMBOL_GPL(tcp_tw_isn);
 long sysctl_tcp_mem[3] __read_mostly;
 EXPORT_IPV6_MOD(sysctl_tcp_mem);
 
-atomic_long_t tcp_memory_allocated ____cacheline_aligned_in_smp;	/* Current allocated memory. */
-EXPORT_IPV6_MOD(tcp_memory_allocated);
 DEFINE_PER_CPU(int, tcp_memory_per_cpu_fw_alloc);
 EXPORT_PER_CPU_SYMBOL_GPL(tcp_memory_per_cpu_fw_alloc);
 
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 56223338bc0f070179efb2ce9996fa7146782adc..b406fd012b2e6a4f5b0bca9d26298bdf26b7989a 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -59,6 +59,7 @@
 #include <linux/slab.h>
 #include <linux/sched.h>
 
+#include <net/aligned_data.h>
 #include <net/net_namespace.h>
 #include <net/icmp.h>
 #include <net/inet_hashtables.h>
@@ -3390,7 +3391,7 @@ struct proto tcp_prot = {
 	.sockets_allocated	= &tcp_sockets_allocated,
 	.orphan_count		= &tcp_orphan_count,
 
-	.memory_allocated	= &tcp_memory_allocated,
+	.memory_allocated	= &net_aligned_data.tcp_memory_allocated,
 	.per_cpu_fw_alloc	= &tcp_memory_per_cpu_fw_alloc,
 
 	.memory_pressure	= &tcp_memory_pressure,
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 9fb614e17bde99e5806cd56fdbc4d0b0b74a3f57..ed0b891885d848b25667edbaf4e925b3ece46033 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -41,6 +41,7 @@
 #include <linux/random.h>
 #include <linux/indirect_call_wrapper.h>
 
+#include <net/aligned_data.h>
 #include <net/tcp.h>
 #include <net/ndisc.h>
 #include <net/inet6_hashtables.h>
@@ -2356,7 +2357,7 @@ struct proto tcpv6_prot = {
 	.stream_memory_free	= tcp_stream_memory_free,
 	.sockets_allocated	= &tcp_sockets_allocated,
 
-	.memory_allocated	= &tcp_memory_allocated,
+	.memory_allocated	= &net_aligned_data.tcp_memory_allocated,
 	.per_cpu_fw_alloc	= &tcp_memory_per_cpu_fw_alloc,
 
 	.memory_pressure	= &tcp_memory_pressure,
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e7972e633236e0451f0321ff4b0a8d1b37282d5f..5f904fc5ac4c63e8b6c7c9aa79f17e8dcdf1a007 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -11,6 +11,7 @@
 #include <linux/netdevice.h>
 #include <linux/sched/signal.h>
 #include <linux/atomic.h>
+#include <net/aligned_data.h>
 #include <net/sock.h>
 #include <net/inet_common.h>
 #include <net/inet_hashtables.h>
@@ -3729,7 +3730,7 @@ static struct proto mptcp_prot = {
 	.stream_memory_free	= mptcp_stream_memory_free,
 	.sockets_allocated	= &mptcp_sockets_allocated,
 
-	.memory_allocated	= &tcp_memory_allocated,
+	.memory_allocated	= &net_aligned_data.tcp_memory_allocated,
 	.per_cpu_fw_alloc	= &tcp_memory_per_cpu_fw_alloc,
 
 	.memory_pressure	= &tcp_memory_pressure,
-- 
2.50.0.727.gbf7dc18ff4-goog


