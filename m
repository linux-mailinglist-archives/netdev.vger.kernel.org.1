Return-Path: <netdev+bounces-165524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F45A326E9
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 14:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 632713A66EB
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 13:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC5320E31E;
	Wed, 12 Feb 2025 13:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o+M6sD4N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5075120E33E
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 13:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739366668; cv=none; b=PuB00JVaLvsUhfVvv6W9LqKQOcS0wUWKmQ1DyhU9hGIVPOyab5GFf1MNGI8fJGvswcMeAhhH/vUAQCWf2dljVQwO94jGmkMLVG9mp6cDNoMn53K81hGkMpSMWcCeE2BLvr/VpkqxumJRvpMzF+bG5HcVL8gu3ayvPhk0MhJGDvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739366668; c=relaxed/simple;
	bh=Oe+v8At9s2C1E7wJYI22kEdxWfe+fTj8pCsKANruipI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t6PMo8nP2P5272YFXp+Ul8l9+qkwoRSk1wjC8K3ASPfIE4JQGGBHBSbGyMi73C198dp9dyANZsYXbkQUa+a7hns7nYeC6FEuIVWkyg1K6gPkzovz5k7WiORxvgNtlZm+TlKk7sqUxEhbcIYFum+cWPwZNT7xFCG1a7GSsv55Wj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o+M6sD4N; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-6e4576e3817so162607216d6.3
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 05:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739366665; x=1739971465; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vvMlbL9YdQHE3eQG986MAWWKPKiGKl8A9wvxd3iGaAA=;
        b=o+M6sD4NvxOOuzAEISmetW12l+6i3nbp8U6yqQ828uVQ/IhHOgFYmZjtfVkpXkVl4m
         ns3Kw/2/2YxTQL3CvxG7E/BW179mBzy797GLR+TbPya//ih/rhAIsJX8Hf+6JeiS2zjn
         MtkJ5euf7x+FXRBDuuQXpmP7jkSMWcr7Q4S5LeZS0DRQ6Bti5zEs7nhqZk7NmA5ZgyDt
         nLuLXSCTMAS+D/38UwLQJ2EbXGPJaY6HcDXhY1IiDiH0Ead7ee/DKeBY4vTiVei/yb5H
         /bma1guUMdMjqeAxSZU41Eh1GOHPxJM/M1SroTea9a8gLGwhszBCF4c452TEFtkfNFvI
         zGwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739366665; x=1739971465;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vvMlbL9YdQHE3eQG986MAWWKPKiGKl8A9wvxd3iGaAA=;
        b=UydOv36Z8DCfBlvvP7h/mgymRM7jQ6BId7tPlgftVe9IGAy/Cb65iGhdX9WESJYcEI
         CMq4KYZ+UrxaMS3mYNgLJ5LWA6R/js24ACkPRW6E/lRvmYJbauwx5JMppCFDcV14z7k2
         y9EjK2MP9n15PdTiPnBWzs/O5O7mDfEYJ6985rzNcfTamjQJv5vr/80//fgmc/KgX8L3
         MsUDsWMEpa8hzRBwxnBVHXU5ozJ9Z2X+7K5+j48T9Y1B60N6jJNclzpKqhKXJbtpuSr+
         eqNUkIPFrDqKoeXA9Hd5L4o+KFyN4d7fU7aVWCZ9zY1i59GbbMoSiFyp3CSKuCYkihnG
         N6GA==
X-Gm-Message-State: AOJu0YyPXlFzByWi5TZRLDfn0lsVnTOYtZvSKRAhO0BD+kxEI69n5SMV
	LpbASpvwOfU8pt3QnLFgCo0TdjYSUF2Lqx5k7CL5Kw9rQWsgJWc/lIi1bH9hJ5xRsFkUEt5RP7w
	HoLmxhCTPDw==
X-Google-Smtp-Source: AGHT+IHwNHlluHULvR/XXK5+pMOahreKfF8794YmCKc7iBlzPo4MEmRSoj6q9w3oiiSphKhBsJ4EM3mog7JrxQ==
X-Received: from qvbme5.prod.google.com ([2002:a05:6214:5d05:b0:6e4:3a18:c687])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:482:b0:6e4:4484:f358 with SMTP id 6a1803df08f44-6e46edad857mr53371956d6.33.1739366665198;
 Wed, 12 Feb 2025 05:24:25 -0800 (PST)
Date: Wed, 12 Feb 2025 13:24:18 +0000
In-Reply-To: <20250212132418.1524422-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250212132418.1524422-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250212132418.1524422-5-edumazet@google.com>
Subject: [PATCH v2 net-next 4/4] udp: use EXPORT_IPV6_MOD[_GPL]()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Sabrina Dubroca <sd@queasysnail.net>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Use EXPORT_IPV6_MOD[_GPL]() for symbols that don't need
to be exported unless CONFIG_IPV6=m

udp_table is no longer used from any modules, and does not
need to be exported anyway.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/udp.c | 63 +++++++++++++++++++++++++-------------------------
 1 file changed, 31 insertions(+), 32 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index a9bb9ce5438eaa9f9ceede1e4ac080dc6ab74588..3485989cd4bdec96e8cb7ecb28b68a25c3444a96 100644
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
@@ -809,11 +808,11 @@ static inline bool __udp_is_mcast_sock(struct net *net, const struct sock *sk,
 }
 
 DEFINE_STATIC_KEY_FALSE(udp_encap_needed_key);
-EXPORT_SYMBOL(udp_encap_needed_key);
+EXPORT_IPV6_MOD(udp_encap_needed_key);
 
 #if IS_ENABLED(CONFIG_IPV6)
 DEFINE_STATIC_KEY_FALSE(udpv6_encap_needed_key);
-EXPORT_SYMBOL(udpv6_encap_needed_key);
+EXPORT_IPV6_MOD(udpv6_encap_needed_key);
 #endif
 
 void udp_encap_enable(void)
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
@@ -2186,7 +2185,7 @@ int udp_disconnect(struct sock *sk, int flags)
 	release_sock(sk);
 	return 0;
 }
-EXPORT_SYMBOL(udp_disconnect);
+EXPORT_IPV6_MOD(udp_disconnect);
 
 void udp_lib_unhash(struct sock *sk)
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


