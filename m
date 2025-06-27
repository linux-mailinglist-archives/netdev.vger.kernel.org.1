Return-Path: <netdev+bounces-202028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C6BAEC0A1
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 22:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2E813AC6B1
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 20:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491192EE260;
	Fri, 27 Jun 2025 20:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eLIIHoA+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f74.google.com (mail-vs1-f74.google.com [209.85.217.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888882ECE97
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 20:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751054765; cv=none; b=qMNWcU1EpF3hJ/kEvFc4ScFIS0hKk6ktZqBzrTJoex3gAV6LObp/BOv5BoD66t69p2Cl5L7LXNsLn0NKcsbfMABwQyRf8P8ueCJpwgr/viAYEomHhw7OAhFr3uj0CDnqZysvTFcxTk1SvUOFe/WrVUS7iUH3h5BNgZbhqLAcEK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751054765; c=relaxed/simple;
	bh=IbhKnBy46TArLrmISZ0nIri+FZVPNdQJer0NS8MlBHI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J+uFqNTg+KJexjPOhMCZE7tdXKerVSHL1WBbW91SHNFXGvMYlO75+vvwB8GSEvDVzv26hXC/uEao1Mkpjhibcp07KAPpk0Avl1JDJdkmNsi3CNSbsJ0TVgYj68QvN/08te63MgqrD4GIl2OUNISjfip/P9HmFaDN1MAsg6kxCEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eLIIHoA+; arc=none smtp.client-ip=209.85.217.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-vs1-f74.google.com with SMTP id ada2fe7eead31-4e6fa93343dso41979137.3
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 13:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751054762; x=1751659562; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SSVCcux7gELSUHIKgVNruCwCHPoiFTQMftWPyb8b2xY=;
        b=eLIIHoA+sevlJM+P1yRhkxJvbI8bmTlW8t7qRF8vAV5NVSysgRF6W9U/lsUcfkNFki
         MduMvh6DEaOUlkuIO1t494kFRKnH8vjH/sNRaAfD4bTpPpd4wfe9vNGo5oej25sDJn1N
         agtW7zmgUzLn1orlG+/Mar0ozf6+unTgDI60I3f7O0Kq+O6EJ1avgbzfQ9w+x/zpu+o8
         NbV/d8YfqQey/XFfX1UjucQxHhI8COn513xRyE50eV6EgvRMggJD8UAn6qLWiKA9Xehm
         S1m0lWfinewMR85PmDMjupb4SlZUmjW5cwiORXrXA1QLnTmO20ApMXTQWQppzEhLJmhy
         b+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751054762; x=1751659562;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SSVCcux7gELSUHIKgVNruCwCHPoiFTQMftWPyb8b2xY=;
        b=LGcwwk1ZfizpUfYKwLhWKQupsA8nMP6gtRU9vCtw6MDjln+1V4ZqLnK2Du3obHMquG
         nCdF+k/qnPp8tfQ+nlfRKdImXWaJJYgrM9f+BwXk3WgbiDmMLtuOomwHplGzhYbShLyJ
         48JARwYhCSBdg3NSGUr4c9I9ZAQ+WTIM8jhuxpo7NwrY7aJLG+oGmLe/6CMAdOjHsiPs
         xl106TW4mcZxvO+TaeACZ/zCckd79RiX6pEUq81ECGVuF4F1ZK5YbDoMtXyua6mueUQ+
         hZmjrzbMuVnURJiNB57nc2jGEY0tq1jd0iadNvLiYIYWoDrVVxhF2vVcFn949hD5KJrX
         z8vQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8ye35cnTdJjEhj+LYWy1TOybWNPIulvgjWsOEamCjKQoGiVVk7G+NyVmuphmwiI8uox6Y65g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4xMtfR+aqu5UGJT6h7zG9Nvmok8a7lMh0+7YzGe+aMHxzVVHC
	0FMzU7T307AIJYeKDekLkVUJao7KgqvQPjAZ8zxs72lwRLP8i2hkBxx563+0qmUVA36tS6XBn23
	hHD3+JyKd89Vr4A==
X-Google-Smtp-Source: AGHT+IGP+MMbk65iocxCFhVidesaeTPZtuacZernQft2l40rGhNovJ3RKHvEtDlmuvmZ5lze6+6mclMlRIyEhA==
X-Received: from vsbih12.prod.google.com ([2002:a05:6102:2d0c:b0:4e9:3879:4f6])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:dd1:b0:4e7:db33:5725 with SMTP id ada2fe7eead31-4ee4f4f849fmr4542487137.3.1751054762606;
 Fri, 27 Jun 2025 13:06:02 -0700 (PDT)
Date: Fri, 27 Jun 2025 20:05:50 +0000
In-Reply-To: <20250627200551.348096-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250627200551.348096-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250627200551.348096-4-edumazet@google.com>
Subject: [PATCH net-next 3/4] tcp: move tcp_memory_allocated into net_aligned_data
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
index 6538c66efdf90ed51836cf244237ee17019a325d..a60c65a3b370a406b2078f23c3e332f58c84df58 100644
--- a/include/net/aligned_data.h
+++ b/include/net/aligned_data.h
@@ -10,6 +10,9 @@
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
index 429fb34b075e0bdad0e1c55dd6b1101b3dfe78dd..a9e1d19ffae4159fe1d6da4d2e8ee69e64f8dd55 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -59,6 +59,7 @@
 #include <linux/slab.h>
 #include <linux/sched.h>
 
+#include <net/aligned_data.h>
 #include <net/net_namespace.h>
 #include <net/icmp.h>
 #include <net/inet_hashtables.h>
@@ -3391,7 +3392,7 @@ struct proto tcp_prot = {
 	.sockets_allocated	= &tcp_sockets_allocated,
 	.orphan_count		= &tcp_orphan_count,
 
-	.memory_allocated	= &tcp_memory_allocated,
+	.memory_allocated	= &net_aligned_data.tcp_memory_allocated,
 	.per_cpu_fw_alloc	= &tcp_memory_per_cpu_fw_alloc,
 
 	.memory_pressure	= &tcp_memory_pressure,
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index f0ce62549d90d6492b8ab139640cca91e4a9c2c7..20d51941e58ae830ab254c4681cc95fd740b88df 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -41,6 +41,7 @@
 #include <linux/random.h>
 #include <linux/indirect_call_wrapper.h>
 
+#include <net/aligned_data.h>
 #include <net/tcp.h>
 #include <net/ndisc.h>
 #include <net/inet6_hashtables.h>
@@ -2357,7 +2358,7 @@ struct proto tcpv6_prot = {
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


