Return-Path: <netdev+bounces-164597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 526E3A2E66C
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 09:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71C1916326B
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 08:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374371C07E5;
	Mon, 10 Feb 2025 08:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="smMCQY7G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6F51C1AB6
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 08:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739176097; cv=none; b=ca3DIaULA87owf5LqRKnalgfjMHfHiu4ghkeylu/zycUa0QdgCVQ7ISW7q88h65M1Naz7w/oXW4buIlUiGreEOxlea+J3wGLdkm8PUc1fFIdusKs2GX0NiJo7pPpzuQ1gmHl5MpaczMnB+SScgt1pfEPZbYhix0cTTw/NjasdNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739176097; c=relaxed/simple;
	bh=e9qQnHRdYuVLS5iUnGr75cz8N4MMqHVLH9yJTbI7Pxo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JohmBC4WFO9MOe1x2PVD/505F99zQNy/Zrtt8biTDZbm00Q2kPrVhe9Z3vrpwGzbES1A2YF54YQMB5LnCoJTRe1ety7FZnudWwysvt8qObR/P+oXoioAZnK8S9QsJm24IzrCk0jFuEavGOHy2WFsr3WYCFRkBTWB9nP/pOmPfJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=smMCQY7G; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-47198c965e1so7118681cf.3
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 00:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739176093; x=1739780893; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=z4jrBSPyYZhoVRY/9+Q4NEAy3ygoCC+v+1tVy/is8KQ=;
        b=smMCQY7GDlA8eDsZzUSlOpd1M5mP57N6+8tK1Wk/kpfE3ltFk10SKk/b6g73skIvEQ
         kmHq0GJ17lSChgc6kAhRaUN2s7vJyvYgI0/3UYLQmP9VEr/W+/dfeLHIAUNO3UfLwrMN
         PQlabK6uX0eTKRG8b6PEwSvBprnVdXY+bhM+sYsBMjdPx6IHCr3ki+XL2UuDzL+hgVck
         XoaSgLYts0l8e1nJJvLEH7UkyVsUS8eoovSytiLm72K/BJvkI+wHd0mAurBtqtP45WRD
         G/0QZHuRxirEhwZtXI7uc23lji8IqlojhwCZBu34aN6EdH6L6xxHBG2X4MndXUuq8B0g
         hPVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739176093; x=1739780893;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z4jrBSPyYZhoVRY/9+Q4NEAy3ygoCC+v+1tVy/is8KQ=;
        b=TP90LAVB28Onu9krSLDjx9EXSR5Iht+NxUQo8N9rLco07Vf73dXE8G3bMTkGm8hicU
         BEf9tGvcj2T5bMO7jp967EO4pTgq4CjJGS3sS/WBvMPL92Iw9CPiaTz2Ruh/nSYl7XK3
         VvXg6sn3era7D45rWGAodrSxY/1e8VLersNwlUBg01NReoyiDq+lColFLnsmapa0LE4s
         5n1Jb5HRDg+6eNdVOM0GZpaphLOs9K083IeieKnVahjSPUn8pflveVHwvl0OiZGNgxl9
         X32xvWEho3gGIxSShTW6Xke5s89sqo6L89BW3qsjNklKGeazmgV0awWJUaafDs7AXi4B
         8FcQ==
X-Gm-Message-State: AOJu0Yx9riST2d1YOM8748oXBua+e9oI/dDKJmx1Iy0gp/Bvh8lVCiOR
	wr0v5YTXlF4erUQAMkm5O2q36jnd7tQo20NeNCR6bpJMgaKMFKx287NQ1qV+Ai5QuZ9v0B6q07O
	d8+6/0UD/KA==
X-Google-Smtp-Source: AGHT+IGfRyhhuyZmgZ7f9PlPVgP927IJD9eDjlMcwVGx8PoZR9NLoJ4Lw8QGVWLQ/Bt2n4rfsiZpSKmOtPhSsQ==
X-Received: from qtbge8.prod.google.com ([2002:a05:622a:5c88:b0:471:82cd:8018])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:514a:b0:471:92a3:8031 with SMTP id d75a77b69052e-47192a387d9mr49890991cf.18.1739176092887;
 Mon, 10 Feb 2025 00:28:12 -0800 (PST)
Date: Mon, 10 Feb 2025 08:28:05 +0000
In-Reply-To: <20250210082805.465241-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250210082805.465241-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250210082805.465241-5-edumazet@google.com>
Subject: [PATCH net-next 4/4] udp: use EXPORT_IPV6_MOD[_GPL]()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemb@google.com>, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Use EXPORT_IPV6_MOD[_GPL]() for symbols that don't need
to be exported unless CONFIG_IPV6=m

udp_table is no longer used from any modules, and does not
need to be exported anyway.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/udp.c | 57 +++++++++++++++++++++++++-------------------------
 1 file changed, 28 insertions(+), 29 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index a9bb9ce5438eaa9f9ceede1e4ac080dc6ab74588..73ac614beb109146c5635aeeb10c2e9f77a6ee1c 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -121,13 +121,12 @@
 #endif
 
 struct udp_table udp_table __read_mostly;
-EXPORT_SYMBOL(udp_table);
 
 long sysctl_udp_mem[3] __read_mostly;
-EXPORT_SYMBOL(sysctl_udp_mem);
+EXPORT_IPV6_MOD(sysctl_udp_mem);
 
 atomic_long_t udp_memory_allocated ____cacheline_aligned_in_smp;
-EXPORT_SYMBOL(udp_memory_allocated);
+EXPORT_IPV6_MOD(udp_memory_allocated);
 DEFINE_PER_CPU(int, udp_memory_per_cpu_fw_alloc);
 EXPORT_PER_CPU_SYMBOL_GPL(udp_memory_per_cpu_fw_alloc);
 
@@ -352,7 +351,7 @@ int udp_lib_get_port(struct sock *sk, unsigned short snum,
 fail:
 	return error;
 }
-EXPORT_SYMBOL(udp_lib_get_port);
+EXPORT_IPV6_MOD(udp_lib_get_port);
 
 int udp_v4_get_port(struct sock *sk, unsigned short snum)
 {
@@ -418,7 +417,7 @@ u32 udp_ehashfn(const struct net *net, const __be32 laddr, const __u16 lport,
 	return __inet_ehashfn(laddr, lport, faddr, fport,
 			      udp_ehash_secret + net_hash_mix(net));
 }
-EXPORT_SYMBOL(udp_ehashfn);
+EXPORT_IPV6_MOD(udp_ehashfn);
 
 /**
  * udp4_lib_lookup1() - Simplified lookup using primary hash (destination port)
@@ -653,7 +652,7 @@ void udp_lib_hash4(struct sock *sk, u16 hash)
 
 	spin_unlock_bh(&hslot->lock);
 }
-EXPORT_SYMBOL(udp_lib_hash4);
+EXPORT_IPV6_MOD(udp_lib_hash4);
 
 /* call with sock lock */
 void udp4_hash4(struct sock *sk)
@@ -669,7 +668,7 @@ void udp4_hash4(struct sock *sk)
 
 	udp_lib_hash4(sk, hash);
 }
-EXPORT_SYMBOL(udp4_hash4);
+EXPORT_IPV6_MOD(udp4_hash4);
 #endif /* CONFIG_BASE_SMALL */
 
 /* UDP is nearly always wildcards out the wazoo, it makes no sense to try
@@ -1041,7 +1040,7 @@ void udp_flush_pending_frames(struct sock *sk)
 		ip_flush_pending_frames(sk);
 	}
 }
-EXPORT_SYMBOL(udp_flush_pending_frames);
+EXPORT_IPV6_MOD(udp_flush_pending_frames);
 
 /**
  * 	udp4_hwcsum  -  handle outgoing HW checksumming
@@ -1229,7 +1228,7 @@ int udp_push_pending_frames(struct sock *sk)
 	WRITE_ONCE(up->pending, 0);
 	return err;
 }
-EXPORT_SYMBOL(udp_push_pending_frames);
+EXPORT_IPV6_MOD(udp_push_pending_frames);
 
 static int __udp_cmsg_send(struct cmsghdr *cmsg, u16 *gso_size)
 {
@@ -1266,7 +1265,7 @@ int udp_cmsg_send(struct sock *sk, struct msghdr *msg, u16 *gso_size)
 
 	return need_ip;
 }
-EXPORT_SYMBOL_GPL(udp_cmsg_send);
+EXPORT_IPV6_MOD_GPL(udp_cmsg_send);
 
 int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 {
@@ -1561,7 +1560,7 @@ void udp_splice_eof(struct socket *sock)
 		udp_push_pending_frames(sk);
 	release_sock(sk);
 }
-EXPORT_SYMBOL_GPL(udp_splice_eof);
+EXPORT_IPV6_MOD_GPL(udp_splice_eof);
 
 #define UDP_SKB_IS_STATELESS 0x80000000
 
@@ -1678,7 +1677,7 @@ void udp_skb_destructor(struct sock *sk, struct sk_buff *skb)
 	prefetch(&skb->data);
 	udp_rmem_release(sk, udp_skb_truesize(skb), 1, false);
 }
-EXPORT_SYMBOL(udp_skb_destructor);
+EXPORT_IPV6_MOD(udp_skb_destructor);
 
 /* as above, but the caller held the rx queue lock, too */
 static void udp_skb_dtor_locked(struct sock *sk, struct sk_buff *skb)
@@ -1785,7 +1784,7 @@ int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
 	busylock_release(busy);
 	return err;
 }
-EXPORT_SYMBOL_GPL(__udp_enqueue_schedule_skb);
+EXPORT_IPV6_MOD_GPL(__udp_enqueue_schedule_skb);
 
 void udp_destruct_common(struct sock *sk)
 {
@@ -1801,7 +1800,7 @@ void udp_destruct_common(struct sock *sk)
 	}
 	udp_rmem_release(sk, total, 0, true);
 }
-EXPORT_SYMBOL_GPL(udp_destruct_common);
+EXPORT_IPV6_MOD_GPL(udp_destruct_common);
 
 static void udp_destruct_sock(struct sock *sk)
 {
@@ -1832,7 +1831,7 @@ void skb_consume_udp(struct sock *sk, struct sk_buff *skb, int len)
 		skb_release_head_state(skb);
 	__consume_stateless_skb(skb);
 }
-EXPORT_SYMBOL_GPL(skb_consume_udp);
+EXPORT_IPV6_MOD_GPL(skb_consume_udp);
 
 static struct sk_buff *__first_packet_length(struct sock *sk,
 					     struct sk_buff_head *rcvq,
@@ -1914,7 +1913,7 @@ int udp_ioctl(struct sock *sk, int cmd, int *karg)
 
 	return 0;
 }
-EXPORT_SYMBOL(udp_ioctl);
+EXPORT_IPV6_MOD(udp_ioctl);
 
 struct sk_buff *__skb_recv_udp(struct sock *sk, unsigned int flags,
 			       int *off, int *err)
@@ -2010,7 +2009,7 @@ int udp_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 	WARN_ON_ONCE(!skb_set_owner_sk_safe(skb, sk));
 	return recv_actor(sk, skb);
 }
-EXPORT_SYMBOL(udp_read_skb);
+EXPORT_IPV6_MOD(udp_read_skb);
 
 /*
  * 	This should be easy, if there is something there we
@@ -2137,7 +2136,7 @@ int udp_pre_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 
 	return BPF_CGROUP_RUN_PROG_INET4_CONNECT_LOCK(sk, uaddr, &addr_len);
 }
-EXPORT_SYMBOL(udp_pre_connect);
+EXPORT_IPV6_MOD(udp_pre_connect);
 
 static int udp_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len)
 {
@@ -2216,7 +2215,7 @@ void udp_lib_unhash(struct sock *sk)
 		spin_unlock_bh(&hslot->lock);
 	}
 }
-EXPORT_SYMBOL(udp_lib_unhash);
+EXPORT_IPV6_MOD(udp_lib_unhash);
 
 /*
  * inet_rcv_saddr was changed, we must rehash secondary hash
@@ -2280,7 +2279,7 @@ void udp_lib_rehash(struct sock *sk, u16 newhash, u16 newhash4)
 		}
 	}
 }
-EXPORT_SYMBOL(udp_lib_rehash);
+EXPORT_IPV6_MOD(udp_lib_rehash);
 
 void udp_v4_rehash(struct sock *sk)
 {
@@ -2485,7 +2484,7 @@ bool udp_sk_rx_dst_set(struct sock *sk, struct dst_entry *dst)
 	}
 	return false;
 }
-EXPORT_SYMBOL(udp_sk_rx_dst_set);
+EXPORT_IPV6_MOD(udp_sk_rx_dst_set);
 
 /*
  *	Multicasts and broadcasts go to each listener.
@@ -3041,7 +3040,7 @@ int udp_lib_setsockopt(struct sock *sk, int level, int optname,
 
 	return err;
 }
-EXPORT_SYMBOL(udp_lib_setsockopt);
+EXPORT_IPV6_MOD(udp_lib_setsockopt);
 
 int udp_setsockopt(struct sock *sk, int level, int optname, sockptr_t optval,
 		   unsigned int optlen)
@@ -3112,7 +3111,7 @@ int udp_lib_getsockopt(struct sock *sk, int level, int optname,
 		return -EFAULT;
 	return 0;
 }
-EXPORT_SYMBOL(udp_lib_getsockopt);
+EXPORT_IPV6_MOD(udp_lib_getsockopt);
 
 int udp_getsockopt(struct sock *sk, int level, int optname,
 		   char __user *optval, int __user *optlen)
@@ -3154,7 +3153,7 @@ __poll_t udp_poll(struct file *file, struct socket *sock, poll_table *wait)
 	return mask;
 
 }
-EXPORT_SYMBOL(udp_poll);
+EXPORT_IPV6_MOD(udp_poll);
 
 int udp_abort(struct sock *sk, int err)
 {
@@ -3177,7 +3176,7 @@ int udp_abort(struct sock *sk, int err)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(udp_abort);
+EXPORT_IPV6_MOD_GPL(udp_abort);
 
 struct proto udp_prot = {
 	.name			= "UDP",
@@ -3311,7 +3310,7 @@ void *udp_seq_start(struct seq_file *seq, loff_t *pos)
 
 	return *pos ? udp_get_idx(seq, *pos-1) : SEQ_START_TOKEN;
 }
-EXPORT_SYMBOL(udp_seq_start);
+EXPORT_IPV6_MOD(udp_seq_start);
 
 void *udp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
@@ -3325,7 +3324,7 @@ void *udp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 	++*pos;
 	return sk;
 }
-EXPORT_SYMBOL(udp_seq_next);
+EXPORT_IPV6_MOD(udp_seq_next);
 
 void udp_seq_stop(struct seq_file *seq, void *v)
 {
@@ -3337,7 +3336,7 @@ void udp_seq_stop(struct seq_file *seq, void *v)
 	if (state->bucket <= udptable->mask)
 		spin_unlock_bh(&udptable->hash[state->bucket].lock);
 }
-EXPORT_SYMBOL(udp_seq_stop);
+EXPORT_IPV6_MOD(udp_seq_stop);
 
 /* ------------------------------------------------------------------------ */
 static void udp4_format_sock(struct sock *sp, struct seq_file *f,
@@ -3616,7 +3615,7 @@ const struct seq_operations udp_seq_ops = {
 	.stop		= udp_seq_stop,
 	.show		= udp4_seq_show,
 };
-EXPORT_SYMBOL(udp_seq_ops);
+EXPORT_IPV6_MOD(udp_seq_ops);
 
 static struct udp_seq_afinfo udp4_seq_afinfo = {
 	.family		= AF_INET,
-- 
2.48.1.502.g6dc24dfdaf-goog


