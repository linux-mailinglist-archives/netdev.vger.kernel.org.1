Return-Path: <netdev+bounces-92162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8068E8B5A4B
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 15:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A40801C2142D
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 13:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E18B74E09;
	Mon, 29 Apr 2024 13:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QnBtrArz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A9871B24
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 13:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714398038; cv=none; b=oRsbjgNCNP8HSVe0OsZfYAcJDlGdVq3oEYqrv2vV3TlbqFRkNKTqO1nrYtUOqEMX09VfNU34nhgNhVK8yJnD/8889Fij+tnK4cFxjpz2V0ZQUlp3U+tTbjHXcuFLzu1gbGhf8ZpK7g28nOeQUkJ6B4ri5ohhkjW5HvLq+G//vLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714398038; c=relaxed/simple;
	bh=MwuL9saMcsxuN5t8MgQHJjZ9a+aXsBlVFjFqmMbXOyg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TNIrCQiN7hwOg50br9Hpu84h0yDR8PjeRvxrGUqNHOxRV1/9puOx0WOCsfc/mfUmY2ZTZUvbODomy4qx6fe8JXRfK0U4q4Qth6UawRjOa9yraaqg+jP4bqj9MJJ+MM4z9y+4mkWTEitiAvqD0xizZCG2/HwY4TfRicF7qVvqKIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QnBtrArz; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61be3f082b0so2437387b3.1
        for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 06:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714398035; x=1715002835; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=S8D+tPGJTNwcjeDHkLETwaAeOK4SR/aOrJPXXPh0beA=;
        b=QnBtrArzw3JW4eveHh3B0Frt/sf5L2VQ3VqCjTUYKbr7VZXV1IIrj8DtjVtygkeGNg
         s02Tq39M+yJfAh4pmwfbBYkgV2pCWXRC7dt4+BDGaKBpXkwXU1fOV0O7gSEnljHlz4Le
         hOSrmWlrrxNndAjwag7eUn6FhtJS2Jvlh/tyvtU1Dp7mZUbAPI3qenp/gCyLFj8Vklrw
         zfH8gQzS6IHFT4EoaiVKYN3H80METLZ6r8y5PEF3Oy0wJ+nUrmXGUj9ixOt+/535HU1+
         OjcyQ3emoEhnM47EAib0h4AFVK8u1Mm+qPfTwgDtQPa6mPd7JXV/MhDTdjTaNRSh4Lg3
         uEdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714398035; x=1715002835;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S8D+tPGJTNwcjeDHkLETwaAeOK4SR/aOrJPXXPh0beA=;
        b=myKdSFMXhehdILKE2uBpeNz8WrdOxBEhMBMI2itvk3qaMByBi1jQl497s8Vkg3tXlg
         9oL8ApDNFL450E8yaNjAhcciZQzexEPf1OsS8U23Gcuk9BSjpeonOJqzNCiik1idG+pF
         hN+uAbDMJB+RfJFbtNa03HoBu0zL9akviFSig39zS1dbmQyuiuG7kORHaKyPZEgg1o3q
         Su+8nbaPp/ecYWdrx5srJ65riHYkVaJDWAzTnfrsGLw2wV8zdFGkow1hUC3O0tJnJxNL
         Cp3IslWhUqhrTdQ4tpCZ6He2iMRknpNSyUYHiCrazEfeOaBbYL8Wuslw2Q/oLRu+NtBz
         HaQA==
X-Gm-Message-State: AOJu0Yzn9NF99tRuSnY49HDa0bvs6WbPLB70IqzhaOmtl6+6JUvYB/o8
	nwRc7ilf0JeOEZGuGYRC5aRPYPWafQ+WhPAq3aQntzhNIqjK76S9AcGSmD7V+y/Yyx80+u3SRiy
	1fVaqRj58JQ==
X-Google-Smtp-Source: AGHT+IGJe8B/eVy58+Qkx3V0fzkpbhzwkswcQPJNNy/SyULjyyczjleFxOkO0fEQN1+RzDjfgpMsW16dqFicXQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1509:b0:dce:30f5:6bc5 with SMTP
 id q9-20020a056902150900b00dce30f56bc5mr617087ybu.4.1714398035517; Mon, 29
 Apr 2024 06:40:35 -0700 (PDT)
Date: Mon, 29 Apr 2024 13:40:25 +0000
In-Reply-To: <20240429134025.1233626-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240429134025.1233626-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240429134025.1233626-6-edumazet@google.com>
Subject: [PATCH net-next 5/5] net: move sysctl_mem_pcpu_rsv to net_hotdata
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

sysctl_mem_pcpu_rsv is used in TCP fast path,
move it to net_hodata for better cache locality.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/hotdata.h      | 1 +
 include/net/proto_memory.h | 6 +++---
 net/core/hotdata.c         | 5 +++--
 net/core/sock.c            | 1 -
 net/core/sysctl_net_core.c | 2 +-
 5 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/net/hotdata.h b/include/net/hotdata.h
index 290499f72e18d45a8ed7bd9e8880a51f7ef2b94c..30e9570beb2afbcb4ece641d6042bdc0de80bd38 100644
--- a/include/net/hotdata.h
+++ b/include/net/hotdata.h
@@ -40,6 +40,7 @@ struct net_hotdata {
 	int			dev_rx_weight;
 	int			sysctl_max_skb_frags;
 	int			sysctl_skb_defer_max;
+	int			sysctl_mem_pcpu_rsv;
 };
 
 #define inet_ehash_secret	net_hotdata.tcp_protocol.secret
diff --git a/include/net/proto_memory.h b/include/net/proto_memory.h
index 41404d4bb6f08e84030838f0e63ef240587f65dd..a6ab2f4f5e28a21ab63acb38caf157f6a7415a0b 100644
--- a/include/net/proto_memory.h
+++ b/include/net/proto_memory.h
@@ -3,10 +3,10 @@
 #define _PROTO_MEMORY_H
 
 #include <net/sock.h>
+#include <net/hotdata.h>
 
 /* 1 MB per cpu, in page units */
 #define SK_MEMORY_PCPU_RESERVE (1 << (20 - PAGE_SHIFT))
-extern int sysctl_mem_pcpu_rsv;
 
 static inline bool sk_has_memory_pressure(const struct sock *sk)
 {
@@ -65,7 +65,7 @@ sk_memory_allocated_add(const struct sock *sk, int val)
 
 	val = this_cpu_add_return(*proto->per_cpu_fw_alloc, val);
 
-	if (unlikely(val >= READ_ONCE(sysctl_mem_pcpu_rsv)))
+	if (unlikely(val >= READ_ONCE(net_hotdata.sysctl_mem_pcpu_rsv)))
 		proto_memory_pcpu_drain(proto);
 }
 
@@ -76,7 +76,7 @@ sk_memory_allocated_sub(const struct sock *sk, int val)
 
 	val = this_cpu_sub_return(*proto->per_cpu_fw_alloc, val);
 
-	if (unlikely(val <= -READ_ONCE(sysctl_mem_pcpu_rsv)))
+	if (unlikely(val <= -READ_ONCE(net_hotdata.sysctl_mem_pcpu_rsv)))
 		proto_memory_pcpu_drain(proto);
 }
 
diff --git a/net/core/hotdata.c b/net/core/hotdata.c
index a359ff160d54ad379eac7e56e1810a7e840f9275..d0aaaaa556f229ded4e1997bf814a2b690b46920 100644
--- a/net/core/hotdata.c
+++ b/net/core/hotdata.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-#include <net/hotdata.h>
 #include <linux/cache.h>
 #include <linux/jiffies.h>
 #include <linux/list.h>
-
+#include <net/hotdata.h>
+#include <net/proto_memory.h>
 
 struct net_hotdata net_hotdata __cacheline_aligned = {
 	.offload_base = LIST_HEAD_INIT(net_hotdata.offload_base),
@@ -20,5 +20,6 @@ struct net_hotdata net_hotdata __cacheline_aligned = {
 	.dev_rx_weight = 64,
 	.sysctl_max_skb_frags = MAX_SKB_FRAGS,
 	.sysctl_skb_defer_max = 64,
+	.sysctl_mem_pcpu_rsv = SK_MEMORY_PCPU_RESERVE
 };
 EXPORT_SYMBOL(net_hotdata);
diff --git a/net/core/sock.c b/net/core/sock.c
index e0692b752369cc1cbf34253a40c06d18dcf350fe..8d6e638b5426daf84ff71d22101252943f9c5466 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -284,7 +284,6 @@ __u32 sysctl_rmem_max __read_mostly = SK_RMEM_MAX;
 EXPORT_SYMBOL(sysctl_rmem_max);
 __u32 sysctl_wmem_default __read_mostly = SK_WMEM_MAX;
 __u32 sysctl_rmem_default __read_mostly = SK_RMEM_MAX;
-int sysctl_mem_pcpu_rsv __read_mostly = SK_MEMORY_PCPU_RESERVE;
 
 int sysctl_tstamp_allow_data __read_mostly = 1;
 
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index a452a330d0ed649a2d1b8e65c81aaa3ff3d826f8..6da5995ac86a08a58e63af9a1e62c7a136c08dc9 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -416,7 +416,7 @@ static struct ctl_table net_core_table[] = {
 	},
 	{
 		.procname	= "mem_pcpu_rsv",
-		.data		= &sysctl_mem_pcpu_rsv,
+		.data		= &net_hotdata.sysctl_mem_pcpu_rsv,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-- 
2.44.0.769.g3c40516874-goog


