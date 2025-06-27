Return-Path: <netdev+bounces-202030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE18AEC0A3
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 22:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 601CB3A6BD5
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 20:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA272EE5E3;
	Fri, 27 Jun 2025 20:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yO19fb0h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4817A2ED87F
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 20:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751054766; cv=none; b=E92FADqAf42Al1y1NsP5o5/x93aJuN3aDCkTJZTbDsq55ZruE1UPM575O7JmINirGXwXK9cAmBLpA9YuA4iRASHb0Vnz+DgJTipByhB4Km+4HZyXyAZ4mlVfWtWM/C9ZmRNBLrmcxw2TFb1bKA0Jcq26Jsx99LsVbt7PKFMHMlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751054766; c=relaxed/simple;
	bh=gu4bJLqsrsNG/FVvXQw1UElgsHfb8msSMoVaB38GBW4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LR2kDu8fZ0Yqw7HaDti1F8WUOE0P+CUs9nORU2xQVXJw9YpOLZT5U89ADcvaOVeLOyJoLKhysL8OMlIJnuZ9XmOvyeocEPF80nSxmbjJq3555jmBdO8qDYwLDUCR0sG28RFD/zSIvAAW4ltuXlhTY5B9m4gxjA3DfR3KQi1as8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yO19fb0h; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7c790dc38b4so428248085a.0
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 13:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751054764; x=1751659564; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lEjln96qd9+jEjB92feygJnIFnK6nwsdzBJsnE/YCYQ=;
        b=yO19fb0hJc4czdjSOtPRHu3bCOVj0HMRpGtVNBHjya5LeVcoUx352AsAJ2ZstGp44T
         zQMWSHReE0/fiIiKsfS5hVBhuNVWfoTIK55SApkuwNQSXH60Exw3dNrrqXJtN7qsIydM
         ixq/YNqhS0eplnWFlQH5HU/qV+787LiKwuDLRwjAmyFjYu8ryF9CF2VTrYLx9tCuz9vV
         Qp/FNc/P4tD+BJv+T3jfhD2/oJeSJjq/kKo7GBHa9J6ArjQtLx0K7mwsNC/WEGbY9BIp
         6r1OUbOVqJaL1fSpvn6mLyTLxvNRDAVQbAYJK4pjQFQGkFz0XTIqZ5vPsrEv6Q1tAIlO
         wjug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751054764; x=1751659564;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lEjln96qd9+jEjB92feygJnIFnK6nwsdzBJsnE/YCYQ=;
        b=ME+XCF0LEhFmzELLtrVAp35TyFTleKDm4zk5DwgwUakLHsI7bayVFvnelbnh38ICSV
         uCfqcmYy0NLtbIt3rZhGMmINKVSpA/XL5/qOYKpJ9EjjDd3MrRbkKLmRuLpq9wenVPPA
         vIwJKgHbTpHHwbr6Dnq38rkfw0Q2J8M8A3EwSAmjSW2jq5O64uOIh3LjYOBxHqr9Elvg
         L/IChae96MJbAaZ5O6Awa1otDLPneh4Yzn1QYoGIaq1l6pboz+qhqWNa/fA10MOiog0b
         bDW8bcLO77oRmUMoY8sOF8H2Cl+QmvEb1SngM2Zn4txnZCy7GADL2DVldD+tZ5s9scl1
         t1yQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCNCFZxhEDJTyIQzyV/CNGY9ahNSMj3kuVMGelYR3uFkz6Cv71hC6xzncB48gFesKOUMf+YQs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx+rPQMRNgPLi2Pl3fHfuPmVVg4uzZHmGoOFok2qDN0L0LzgYE
	ZPBybT+gp605z1vHoyEcW/ysiA/Emwtr9MiWB8Y789g2ehMksakgi1WGli9UwM891FV2XkSnirW
	s++XGJKNSzWG1bw==
X-Google-Smtp-Source: AGHT+IG1A0hRhMRQ4eE5Y5+rhlggGObPpABHaFvICdi94i0fDMU+0NHagbRp0meeOYFshlNbQZrgmQSh+0y7Qg==
X-Received: from qknpw10.prod.google.com ([2002:a05:620a:63ca:b0:7d4:f7:3ba4])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:24c9:b0:7d0:9a99:1bb1 with SMTP id af79cd13be357-7d4441a40e9mr597678685a.25.1751054764055;
 Fri, 27 Jun 2025 13:06:04 -0700 (PDT)
Date: Fri, 27 Jun 2025 20:05:51 +0000
In-Reply-To: <20250627200551.348096-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250627200551.348096-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250627200551.348096-5-edumazet@google.com>
Subject: [PATCH net-next 4/4] udp: move udp_memory_allocated into net_aligned_data
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

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/aligned_data.h | 1 +
 include/net/udp.h          | 1 -
 net/ipv4/udp.c             | 4 +---
 net/ipv4/udp_impl.h        | 1 +
 net/ipv4/udplite.c         | 2 +-
 net/ipv6/udp.c             | 2 +-
 net/ipv6/udp_impl.h        | 1 +
 net/ipv6/udplite.c         | 2 +-
 8 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/net/aligned_data.h b/include/net/aligned_data.h
index a60c65a3b370a406b2078f23c3e332f58c84df58..fc07461e31352eb757c34867ea9b458fb9e539f4 100644
--- a/include/net/aligned_data.h
+++ b/include/net/aligned_data.h
@@ -12,6 +12,7 @@ struct net_aligned_data {
 	atomic64_t	net_cookie ____cacheline_aligned_in_smp;
 #if defined(CONFIG_INET)
 	atomic_long_t tcp_memory_allocated ____cacheline_aligned_in_smp;
+	atomic_long_t udp_memory_allocated ____cacheline_aligned_in_smp;
 #endif
 };
 
diff --git a/include/net/udp.h b/include/net/udp.h
index a772510b2aa58a922dc4dd5bd7cb7f7f0c1ce0e3..f8ae2c4ade141d27e4af3376f5a177e46d5b39ea 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -205,7 +205,6 @@ static inline void udp_hash4_dec(struct udp_hslot *hslot2)
 
 extern struct proto udp_prot;
 
-extern atomic_long_t udp_memory_allocated;
 DECLARE_PER_CPU(int, udp_memory_per_cpu_fw_alloc);
 
 /* sysctl variables for udp */
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 19573ee64a0f18cf55df34ace1956e9c3e20172c..49f43c54cfb0e3ac85c1a6202f3d6a2f1ca6d0ba 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -127,8 +127,6 @@ struct udp_table udp_table __read_mostly;
 long sysctl_udp_mem[3] __read_mostly;
 EXPORT_IPV6_MOD(sysctl_udp_mem);
 
-atomic_long_t udp_memory_allocated ____cacheline_aligned_in_smp;
-EXPORT_IPV6_MOD(udp_memory_allocated);
 DEFINE_PER_CPU(int, udp_memory_per_cpu_fw_alloc);
 EXPORT_PER_CPU_SYMBOL_GPL(udp_memory_per_cpu_fw_alloc);
 
@@ -3235,7 +3233,7 @@ struct proto udp_prot = {
 #ifdef CONFIG_BPF_SYSCALL
 	.psock_update_sk_prot	= udp_bpf_update_proto,
 #endif
-	.memory_allocated	= &udp_memory_allocated,
+	.memory_allocated	= &net_aligned_data.udp_memory_allocated,
 	.per_cpu_fw_alloc	= &udp_memory_per_cpu_fw_alloc,
 
 	.sysctl_mem		= sysctl_udp_mem,
diff --git a/net/ipv4/udp_impl.h b/net/ipv4/udp_impl.h
index e1ff3a37599614b18a0b621534019a7bd71ea901..c7142213fc2112c9e423caa5e6d84bafeaca9936 100644
--- a/net/ipv4/udp_impl.h
+++ b/net/ipv4/udp_impl.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _UDP4_IMPL_H
 #define _UDP4_IMPL_H
+#include <net/aligned_data.h>
 #include <net/udp.h>
 #include <net/udplite.h>
 #include <net/protocol.h>
diff --git a/net/ipv4/udplite.c b/net/ipv4/udplite.c
index af37af3ab727bffeebe5c41d84cb7c130f49c50d..d3e621a11a1aa4cafb62eb53ddc0ed1ca517a7fe 100644
--- a/net/ipv4/udplite.c
+++ b/net/ipv4/udplite.c
@@ -60,7 +60,7 @@ struct proto 	udplite_prot = {
 	.rehash		   = udp_v4_rehash,
 	.get_port	   = udp_v4_get_port,
 
-	.memory_allocated  = &udp_memory_allocated,
+	.memory_allocated  = &net_aligned_data.udp_memory_allocated,
 	.per_cpu_fw_alloc  = &udp_memory_per_cpu_fw_alloc,
 
 	.sysctl_mem	   = sysctl_udp_mem,
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index ebb95d8bc6819f72842fd1567e73fcef4f1e0ed0..6bbdadbd5fecccfb7de99f05c6fb179393e162f2 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1925,7 +1925,7 @@ struct proto udpv6_prot = {
 	.psock_update_sk_prot	= udp_bpf_update_proto,
 #endif
 
-	.memory_allocated	= &udp_memory_allocated,
+	.memory_allocated	= &net_aligned_data.udp_memory_allocated,
 	.per_cpu_fw_alloc	= &udp_memory_per_cpu_fw_alloc,
 
 	.sysctl_mem		= sysctl_udp_mem,
diff --git a/net/ipv6/udp_impl.h b/net/ipv6/udp_impl.h
index 0590f566379d7d07dfdd1b0ae808b9d8964eb5aa..8a406be25a3a6dee687a6a02ea0b6a28428abb86 100644
--- a/net/ipv6/udp_impl.h
+++ b/net/ipv6/udp_impl.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _UDP6_IMPL_H
 #define _UDP6_IMPL_H
+#include <net/aligned_data.h>
 #include <net/udp.h>
 #include <net/udplite.h>
 #include <net/protocol.h>
diff --git a/net/ipv6/udplite.c b/net/ipv6/udplite.c
index a60bec9b14f14a5b2d271f9965b5fca3d2a440c8..2cec542437f74eba9540fc464ee70d8b0bc0be79 100644
--- a/net/ipv6/udplite.c
+++ b/net/ipv6/udplite.c
@@ -59,7 +59,7 @@ struct proto udplitev6_prot = {
 	.rehash		   = udp_v6_rehash,
 	.get_port	   = udp_v6_get_port,
 
-	.memory_allocated  = &udp_memory_allocated,
+	.memory_allocated  = &net_aligned_data.udp_memory_allocated,
 	.per_cpu_fw_alloc  = &udp_memory_per_cpu_fw_alloc,
 
 	.sysctl_mem	   = sysctl_udp_mem,
-- 
2.50.0.727.gbf7dc18ff4-goog


