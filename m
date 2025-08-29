Return-Path: <netdev+bounces-218326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75701B3BF3E
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 17:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8AB87AA1CC
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 15:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3331DFD8F;
	Fri, 29 Aug 2025 15:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gpj+FF+1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF2B3218A1
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 15:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756481467; cv=none; b=YNChPyfN+XEp9hjHJH8Y3V8KmZInKtlx8Fq5aWHO5CP8J8Sx9LxhT0adg+PuPQ8pGaavDKbmilVJPegXE/4wrO/rFXaKChG/PQY0mtBVEiWhYG/+zeDpCDtPkr66T7DAMn6fVR6Fibo8wESYncrRVBtBkrT5T8/0fVBiIgpDt2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756481467; c=relaxed/simple;
	bh=1hcRPk1i6D4WXWV1QXI13yPoQdLUktytM4rgtVd8uHU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZLe60iS1MF9VjEKCqiHfy6ooQ3NTjA07VWG74prQYj8ZinHFaHnceMV0/DQYwlnZAV6yCgwr8Y+90NinniI0EkrqzVP9b+2r6/IxKBskkr1NW4e0PBKDfVT3kokrBAfuESI//y3xUkc93SL0jGZRvXWISXtS52uJLS03smrLTho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gpj+FF+1; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4b30fadc974so15032141cf.3
        for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 08:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756481465; x=1757086265; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lr31YsQoaumMO8piNS8KLxamhAFr8Dc/oO7xxuADh0A=;
        b=gpj+FF+16E4X34ZrrXFnbNuLki2vrRQCgdE4drQCL9XLlCmJUxU9PDXjxWSCBp9PUY
         KWP6Cuh2svBo64WauVL05hDMEUAKFB4I07CU7Hcuu+mAghSa7wJn2KFEnbIfEhEeq579
         HWECiAQX3C9/2K8fZg9b0Ks6ExuWnlx+uOaXzMHPL3Bps2XKXwdFMIJtFGuIpMF7LiBp
         qyqg3wzTO7XL3gInw/bkdo4qx8B/40tRHnWWaDgq74KGw/hde20hUP9aSKhie204hp9X
         gcUwRe+UtQfIAl1NowIjV9pJNYI0oylKHv7aw5GJ7TJq9mRvqAZuSROEshY9EXIo127H
         hg6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756481465; x=1757086265;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lr31YsQoaumMO8piNS8KLxamhAFr8Dc/oO7xxuADh0A=;
        b=nXoMqfPToRDrG+4immgI14C7lKbJCQJCRkIDKIt18JJ5ZYHFz2yOaYrpTf0tmiIHOy
         SQWbSMbsUGHWkOZsJ5jXsADauB+iB/gtNbY/7PJnEYModnS5B3h9axNroPuzWqh/j3TR
         fIJN7R+ubvtMDGVTG4Qyz0+6x1IyBG+POJRyDpreaMU84Gk+i/tVrhypOQvZ+VcaAgTd
         evp976OnruhvGcI83fzPKQLjtQuZ1pmPw6AISiXi/6ambK2R9uropouRIHkuupuhCqKM
         fHAv1pHrozHqI396mlWYOFYPZsTulmQ8EzsiEqZtSplfesdIXMjzDyD9qnxOMhgUhZAW
         rn7A==
X-Forwarded-Encrypted: i=1; AJvYcCVWxgJN9QUkc7aVc2KzgzmARcr8G5nOUr61RT9xx0l1WN1WCe32hEpJ5ouK3PqwQrg/tefkHys=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEf5eK+XB64KNovxke2D6E7rtrj1JflzRK3yDAAHTD4b9P7K+g
	eT1CfgyxA0UFMsdvIV5SAatV3ig6pMOY4KQabEkqRSg8zYQ0ieAjzLTFCJEdj9xTyWvo31vr0G0
	uT6A//bh6Pdejcw==
X-Google-Smtp-Source: AGHT+IH6aq5mYLx2r9g58eFe2P6onGPcZxRYo6YYYqR7HLUBZ9Qv0bNP+N6ISGtG+j9fi0c38WVwXmMELA896g==
X-Received: from qknqf10.prod.google.com ([2002:a05:620a:660a:b0:7fa:c1b0:4f8])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:4c14:b0:4b3:138b:a3c6 with SMTP id d75a77b69052e-4b3138bacd0mr20083501cf.11.1756481464850;
 Fri, 29 Aug 2025 08:31:04 -0700 (PDT)
Date: Fri, 29 Aug 2025 15:30:54 +0000
In-Reply-To: <20250829153054.474201-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829153054.474201-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829153054.474201-5-edumazet@google.com>
Subject: [PATCH v3 net-next 4/4] inet: ping: use EXPORT_IPV6_MOD[_GPL]()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

There is no neeed to export ping symbols when CONFIG_IPV6=y

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/ping.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
index 98ccd4f9ed657d2bb9c013932d0c678f2b38a746..5321c5801c64dd2c20ba94fdcb5a677da4be02d7 100644
--- a/net/ipv4/ping.c
+++ b/net/ipv4/ping.c
@@ -56,7 +56,7 @@ struct ping_table {
 
 static struct ping_table ping_table;
 struct pingv6_ops pingv6_ops;
-EXPORT_SYMBOL_GPL(pingv6_ops);
+EXPORT_IPV6_MOD_GPL(pingv6_ops);
 
 static inline u32 ping_hashfn(const struct net *net, u32 num, u32 mask)
 {
@@ -139,7 +139,7 @@ int ping_get_port(struct sock *sk, unsigned short ident)
 	spin_unlock(&ping_table.lock);
 	return -EADDRINUSE;
 }
-EXPORT_SYMBOL_GPL(ping_get_port);
+EXPORT_IPV6_MOD_GPL(ping_get_port);
 
 void ping_unhash(struct sock *sk)
 {
@@ -154,7 +154,7 @@ void ping_unhash(struct sock *sk)
 	}
 	spin_unlock(&ping_table.lock);
 }
-EXPORT_SYMBOL_GPL(ping_unhash);
+EXPORT_IPV6_MOD_GPL(ping_unhash);
 
 /* Called under rcu_read_lock() */
 static struct sock *ping_lookup(struct net *net, struct sk_buff *skb, u16 ident)
@@ -274,7 +274,7 @@ int ping_init_sock(struct sock *sk)
 	put_group_info(group_info);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(ping_init_sock);
+EXPORT_IPV6_MOD_GPL(ping_init_sock);
 
 void ping_close(struct sock *sk, long timeout)
 {
@@ -284,7 +284,7 @@ void ping_close(struct sock *sk, long timeout)
 
 	sk_common_release(sk);
 }
-EXPORT_SYMBOL_GPL(ping_close);
+EXPORT_IPV6_MOD_GPL(ping_close);
 
 static int ping_pre_connect(struct sock *sk, struct sockaddr *uaddr,
 			    int addr_len)
@@ -462,7 +462,7 @@ int ping_bind(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 	pr_debug("ping_v4_bind -> %d\n", err);
 	return err;
 }
-EXPORT_SYMBOL_GPL(ping_bind);
+EXPORT_IPV6_MOD_GPL(ping_bind);
 
 /*
  * Is this a supported type of ICMP message?
@@ -595,7 +595,7 @@ void ping_err(struct sk_buff *skb, int offset, u32 info)
 out:
 	return;
 }
-EXPORT_SYMBOL_GPL(ping_err);
+EXPORT_IPV6_MOD_GPL(ping_err);
 
 /*
  *	Copy and checksum an ICMP Echo packet from user space into a buffer
@@ -625,7 +625,7 @@ int ping_getfrag(void *from, char *to,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(ping_getfrag);
+EXPORT_IPV6_MOD_GPL(ping_getfrag);
 
 static int ping_v4_push_pending_frames(struct sock *sk, struct pingfakehdr *pfh,
 				       struct flowi4 *fl4)
@@ -686,7 +686,7 @@ int ping_common_sendmsg(int family, struct msghdr *msg, size_t len,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(ping_common_sendmsg);
+EXPORT_IPV6_MOD_GPL(ping_common_sendmsg);
 
 static int ping_v4_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 {
@@ -931,7 +931,7 @@ int ping_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags,
 	pr_debug("ping_recvmsg -> %d\n", err);
 	return err;
 }
-EXPORT_SYMBOL_GPL(ping_recvmsg);
+EXPORT_IPV6_MOD_GPL(ping_recvmsg);
 
 static enum skb_drop_reason __ping_queue_rcv_skb(struct sock *sk,
 						 struct sk_buff *skb)
@@ -952,7 +952,7 @@ int ping_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
 {
 	return __ping_queue_rcv_skb(sk, skb) ? -1 : 0;
 }
-EXPORT_SYMBOL_GPL(ping_queue_rcv_skb);
+EXPORT_IPV6_MOD_GPL(ping_queue_rcv_skb);
 
 
 /*
@@ -980,7 +980,7 @@ enum skb_drop_reason ping_rcv(struct sk_buff *skb)
 	kfree_skb_reason(skb, SKB_DROP_REASON_NO_SOCKET);
 	return SKB_DROP_REASON_NO_SOCKET;
 }
-EXPORT_SYMBOL_GPL(ping_rcv);
+EXPORT_IPV6_MOD_GPL(ping_rcv);
 
 struct proto ping_prot = {
 	.name =		"PING",
@@ -1002,7 +1002,7 @@ struct proto ping_prot = {
 	.put_port =	ping_unhash,
 	.obj_size =	sizeof(struct inet_sock),
 };
-EXPORT_SYMBOL(ping_prot);
+EXPORT_IPV6_MOD(ping_prot);
 
 #ifdef CONFIG_PROC_FS
 
@@ -1067,7 +1067,7 @@ void *ping_seq_start(struct seq_file *seq, loff_t *pos, sa_family_t family)
 
 	return *pos ? ping_get_idx(seq, *pos-1) : SEQ_START_TOKEN;
 }
-EXPORT_SYMBOL_GPL(ping_seq_start);
+EXPORT_IPV6_MOD_GPL(ping_seq_start);
 
 static void *ping_v4_seq_start(struct seq_file *seq, loff_t *pos)
 {
@@ -1086,14 +1086,14 @@ void *ping_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 	++*pos;
 	return sk;
 }
-EXPORT_SYMBOL_GPL(ping_seq_next);
+EXPORT_IPV6_MOD_GPL(ping_seq_next);
 
 void ping_seq_stop(struct seq_file *seq, void *v)
 	__releases(ping_table.lock)
 {
 	spin_unlock(&ping_table.lock);
 }
-EXPORT_SYMBOL_GPL(ping_seq_stop);
+EXPORT_IPV6_MOD_GPL(ping_seq_stop);
 
 static void ping_v4_format_sock(struct sock *sp, struct seq_file *f,
 		int bucket)
-- 
2.51.0.318.gd7df087d1a-goog


