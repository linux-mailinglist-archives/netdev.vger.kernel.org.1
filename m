Return-Path: <netdev+bounces-250297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F190BD2814B
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 20:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 86C20300FD41
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 19:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2893093AD;
	Thu, 15 Jan 2026 19:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5fROcFT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE5C306B0A
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 19:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768505282; cv=none; b=TxSlI18sqFbi5uWmKDQQB4WAbvNd8jCpL6TS3n+2XZR0NUEmqceixXAoMuObgaNXyyZzVjFM6ntq/5Q0IvQMSGrMoaUuC1+tNVYSBGelk8E7BbpNWd7lHsm7fBZ/s6AeK91BhrP8AJRFfPF4F/bPxSYX2bEMGvH+6Yrwc6uFyTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768505282; c=relaxed/simple;
	bh=olTg6hXy2UOIs/E5+FMogUgEqTdZDvxa+0gcsxXuKm8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TeqAv/RmM6VCAYVJe6tQfzF4GI6n5fKgGcW1gfZBGhlUrd3/kz6qmvlo9QSVA8met/aPybcbKmPson3eoeO25RoIxe1z65X0Te/dQd37HWUR+A0wt1qLmQ+rm5whWvjBHSiP16r6VkQRy1Mmzdx3msu3kpGoOdbO7shptTRWvCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A5fROcFT; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a0c20ee83dso11134385ad.2
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 11:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768505273; x=1769110073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iXMZV8D4SK0rj+49FcmchxTVbQT7E5LzQd3mS1H/yrc=;
        b=A5fROcFT4ugnWFn7VcPpmuIFySL0wglwKOTUfYWBSEGEW7ur/KO5vtIul98gLYLQKU
         HkS6i2exCI4IiA2mVLjeU+btKns3pu9e4oSBiqYv4olQE+CjG+Xigc3AF0iOe7tfZ1vZ
         wuqnmwtNGvBsa4LBmK8nA1HDMG3zEhxS/Q25dhiEOnn++xLI+Di3neIiUfb1Q3ccARD1
         BGNwDuEPA+DExGDTWGS2vQ7SLOVrOiio6hhPtzySNkVGKK/EirwrL2GOj7DYmRTqr1Eo
         qAJFemfOQyRjFCs7dr7DjkjwcgQWqCzfmS9OqMM6z1Ut7XzmiMk9VgUxWg1wN12ADSno
         RCKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768505273; x=1769110073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iXMZV8D4SK0rj+49FcmchxTVbQT7E5LzQd3mS1H/yrc=;
        b=KJMA9D4YKBURibXmC0aFtEjeb6ZK5/5006k0IBOCDsaVOcr4/EYMxeV+TyQr4aUw7g
         bpb1/VOCEZ1B67+5NhUvh8m3em+LSsFnEf8gSWicH4KHH2sX3mLTGO2QrfGVemKFvNar
         Ud/jmmbaqhEj+yNvmuUY4/KmJklr28Il4K2Ze54xBK6bvtfeLsrB15RWfbjXODn4zCaf
         TWhkZPoZ5ZeE0s9DTgMpAkK9oSO9C6QystPE9Bju+EgoB42hjd9QC7NnDPjzyA0P8NCa
         EqkNQ0WeFAL/YZwpWTLo8RgU/fYNMq6ghOQeiFAsxbHUHCopthQmXzBc50Qlq34DhB9l
         DKPw==
X-Gm-Message-State: AOJu0YzfDaVjea+U47Ynt/2tecRSzDlioLU1K9zJJ8/fTObLSmTAdDUU
	rPtEoTEVHv2Vi1KCEGT2Y7tgVAcfWtVDFmzguzDbJAFXVdNkqukCqRazfFne4A==
X-Gm-Gg: AY/fxX5a6xAtjk8FrMwKxxnq0N4J6jCcrnQIKl7nZIWxU9U6zdmLPTHxwWvJJlCL8WH
	JZ3O2EiJuVZfjIowY6CV+P7fTatjpdkYKh27QEv6nDWXLs62jwoj9jWS5iw9Bmo3PfXOJon6Gz4
	C0Atz9xQcxFVhrv3ska5XFUxtIq0QXL6sYHBMFk46z4fRv90hGw1ONwtCtvmbXmBMYRzn0HILHA
	QbzRehRyG5W9sASSASZ93F2rfy1U9AblZssjYovsNqoK7H/yt8L3cJGyrls0Ea0haxvP91Ftao8
	KoPUWtDYrPtzZtqqRiapwNxDSSmjFssUXPVWq6xFNYQynKtxZhRw2/b0KB/bnjXmqgMoEF/2aGX
	wsPXZk1/kIh0aZQpjbPYxN7B8h7cXPFlGjq2bpHetLNUWCfIvsNlqFNvZjtU0krWB8E3XEx5rMO
	IgtbnNw5/YhlKd/BRt
X-Received: by 2002:a17:902:c951:b0:2a0:de4f:ca7 with SMTP id d9443c01a7336-2a7174efc8amr5602905ad.1.1768505272756;
        Thu, 15 Jan 2026 11:27:52 -0800 (PST)
Received: from pop-os.. ([2601:647:6802:dbc0:3874:1cf7:603f:ecef])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190ce692sm876115ad.36.2026.01.15.11.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 11:27:52 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: hemanthmalla@gmail.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	zijianzhang@bytedance.com,
	bpf@vger.kernel.org,
	Cong Wang <cong.wang@bytedance.com>
Subject: [Patch bpf-next v6 2/4] skmsg: implement slab allocator cache for sk_msg
Date: Thu, 15 Jan 2026 11:27:35 -0800
Message-Id: <20260115192737.743857-3-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260115192737.743857-1-xiyou.wangcong@gmail.com>
References: <20260115192737.743857-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zijian Zhang <zijianzhang@bytedance.com>

Optimizing redirect ingress performance requires frequent allocation and
deallocation of sk_msg structures. Introduce a dedicated kmem_cache for
sk_msg to reduce memory allocation overhead and improve performance.

Acked-by: John Fastabend <john.fastabend@gmail.com>
Reviewed-by: Cong Wang <cong.wang@bytedance.com>
Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
---
 include/linux/skmsg.h | 21 ++++++++++++---------
 net/core/skmsg.c      | 28 +++++++++++++++++++++-------
 net/ipv4/tcp_bpf.c    |  9 ++++-----
 3 files changed, 37 insertions(+), 21 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index 84ec69568bb7..61e2c2e6840b 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -121,6 +121,7 @@ struct sk_psock {
 	struct rcu_work			rwork;
 };
 
+struct sk_msg *sk_msg_alloc(gfp_t gfp);
 int sk_msg_expand(struct sock *sk, struct sk_msg *msg, int len,
 		  int elem_first_coalesce);
 int sk_msg_clone(struct sock *sk, struct sk_msg *dst, struct sk_msg *src,
@@ -143,6 +144,8 @@ int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
 		   int len, int flags);
 bool sk_msg_is_readable(struct sock *sk);
 
+extern struct kmem_cache *sk_msg_cachep;
+
 static inline void sk_msg_check_to_free(struct sk_msg *msg, u32 i, u32 bytes)
 {
 	WARN_ON(i == msg->sg.end && bytes);
@@ -319,6 +322,13 @@ static inline void sock_drop(struct sock *sk, struct sk_buff *skb)
 	kfree_skb(skb);
 }
 
+static inline void kfree_sk_msg(struct sk_msg *msg)
+{
+	if (msg->skb)
+		consume_skb(msg->skb);
+	kmem_cache_free(sk_msg_cachep, msg);
+}
+
 static inline bool sk_psock_queue_msg(struct sk_psock *psock,
 				      struct sk_msg *msg)
 {
@@ -330,7 +340,7 @@ static inline bool sk_psock_queue_msg(struct sk_psock *psock,
 		ret = true;
 	} else {
 		sk_msg_free(psock->sk, msg);
-		kfree(msg);
+		kfree_sk_msg(msg);
 		ret = false;
 	}
 	spin_unlock_bh(&psock->ingress_lock);
@@ -378,13 +388,6 @@ static inline bool sk_psock_queue_empty(const struct sk_psock *psock)
 	return psock ? list_empty(&psock->ingress_msg) : true;
 }
 
-static inline void kfree_sk_msg(struct sk_msg *msg)
-{
-	if (msg->skb)
-		consume_skb(msg->skb);
-	kfree(msg);
-}
-
 static inline void sk_psock_report_error(struct sk_psock *psock, int err)
 {
 	struct sock *sk = psock->sk;
@@ -441,7 +444,7 @@ static inline void sk_psock_cork_free(struct sk_psock *psock)
 {
 	if (psock->cork) {
 		sk_msg_free(psock->sk, psock->cork);
-		kfree(psock->cork);
+		kfree_sk_msg(psock->cork);
 		psock->cork = NULL;
 	}
 }
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 0812e01e3171..45ff311ccf49 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -10,6 +10,8 @@
 #include <net/tls.h>
 #include <trace/events/sock.h>
 
+struct kmem_cache *sk_msg_cachep;
+
 static bool sk_msg_try_coalesce_ok(struct sk_msg *msg, int elem_first_coalesce)
 {
 	if (msg->sg.end > msg->sg.start &&
@@ -503,16 +505,17 @@ bool sk_msg_is_readable(struct sock *sk)
 }
 EXPORT_SYMBOL_GPL(sk_msg_is_readable);
 
-static struct sk_msg *alloc_sk_msg(gfp_t gfp)
+struct sk_msg *sk_msg_alloc(gfp_t gfp)
 {
 	struct sk_msg *msg;
 
-	msg = kzalloc(sizeof(*msg), gfp | __GFP_NOWARN);
+	msg = kmem_cache_zalloc(sk_msg_cachep, gfp | __GFP_NOWARN);
 	if (unlikely(!msg))
 		return NULL;
 	sg_init_marker(msg->sg.data, NR_MSG_FRAG_IDS);
 	return msg;
 }
+EXPORT_SYMBOL_GPL(sk_msg_alloc);
 
 static struct sk_msg *sk_psock_create_ingress_msg(struct sock *sk,
 						  struct sk_buff *skb)
@@ -523,7 +526,7 @@ static struct sk_msg *sk_psock_create_ingress_msg(struct sock *sk,
 	if (!sk_rmem_schedule(sk, skb, skb->truesize))
 		return NULL;
 
-	return alloc_sk_msg(GFP_KERNEL);
+	return sk_msg_alloc(GFP_KERNEL);
 }
 
 static int sk_psock_skb_ingress_enqueue(struct sk_buff *skb,
@@ -598,7 +601,7 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
 	skb_set_owner_r(skb, sk);
 	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg, true);
 	if (err < 0)
-		kfree(msg);
+		kfree_sk_msg(msg);
 	return err;
 }
 
@@ -609,7 +612,7 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
 static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb,
 				     u32 off, u32 len, bool take_ref)
 {
-	struct sk_msg *msg = alloc_sk_msg(GFP_ATOMIC);
+	struct sk_msg *msg = sk_msg_alloc(GFP_ATOMIC);
 	struct sock *sk = psock->sk;
 	int err;
 
@@ -618,7 +621,7 @@ static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb
 	skb_set_owner_r(skb, sk);
 	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg, take_ref);
 	if (err < 0)
-		kfree(msg);
+		kfree_sk_msg(msg);
 	return err;
 }
 
@@ -802,7 +805,7 @@ static void __sk_psock_purge_ingress_msg(struct sk_psock *psock)
 		if (!msg->skb)
 			atomic_sub(msg->sg.size, &psock->sk->sk_rmem_alloc);
 		sk_msg_free(psock->sk, msg);
-		kfree(msg);
+		kfree_sk_msg(msg);
 	}
 }
 
@@ -1287,3 +1290,14 @@ void sk_psock_stop_verdict(struct sock *sk, struct sk_psock *psock)
 	sk->sk_data_ready = psock->saved_data_ready;
 	psock->saved_data_ready = NULL;
 }
+
+static int __init sk_msg_cachep_init(void)
+{
+	sk_msg_cachep = kmem_cache_create("sk_msg_cachep",
+					  sizeof(struct sk_msg),
+					  0,
+					  SLAB_HWCACHE_ALIGN | SLAB_ACCOUNT,
+					  NULL);
+	return 0;
+}
+late_initcall(sk_msg_cachep_init);
diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index a0a385e07094..e4dd5d098a31 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -38,7 +38,7 @@ static int bpf_tcp_ingress(struct sock *sk, struct sk_psock *psock,
 	struct sk_msg *tmp;
 	int i, ret = 0;
 
-	tmp = kzalloc(sizeof(*tmp), __GFP_NOWARN | GFP_KERNEL);
+	tmp = sk_msg_alloc(GFP_KERNEL);
 	if (unlikely(!tmp))
 		return -ENOMEM;
 
@@ -80,7 +80,7 @@ static int bpf_tcp_ingress(struct sock *sk, struct sk_psock *psock,
 		sk_psock_data_ready(sk, psock);
 	} else {
 		sk_msg_free(sk, tmp);
-		kfree(tmp);
+		kfree_sk_msg(tmp);
 	}
 
 	release_sock(sk);
@@ -406,8 +406,7 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 	    msg->cork_bytes > msg->sg.size && !enospc) {
 		psock->cork_bytes = msg->cork_bytes - msg->sg.size;
 		if (!psock->cork) {
-			psock->cork = kzalloc(sizeof(*psock->cork),
-					      GFP_ATOMIC | __GFP_NOWARN);
+			psock->cork = sk_msg_alloc(GFP_ATOMIC);
 			if (!psock->cork) {
 				sk_msg_free(sk, msg);
 				*copied = 0;
@@ -466,7 +465,7 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 		}
 		if (cork) {
 			sk_msg_free(sk, msg);
-			kfree(msg);
+			kfree_sk_msg(msg);
 			msg = NULL;
 			ret = 0;
 		}
-- 
2.34.1


