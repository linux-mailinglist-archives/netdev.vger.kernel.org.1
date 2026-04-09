Return-Path: <netdev+bounces-277036-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMwIEJe+12mdSQgAu9opvQ
	(envelope-from <netdev+bounces-277036-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 16:58:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCA83CC488
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 16:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84BC43017268
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 14:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295E539023C;
	Thu,  9 Apr 2026 14:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hPmliW1z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F493B47E7
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 14:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775746598; cv=none; b=P6mkxwj9ixoG+1mgHVt7P2Zu8mEnpp4BTJYo+Yt28VvrIlfxji0cmEx2RJgPph9VJ/L153BFFTaCwumZRoJrCJbo+a5Hu8tstAapoQKfmC3Hyu8oiS2s+jnKXZCehphxDPrDgx0YsLC5LOrb7gDGCrX4wK4lHWBV7ioCQM4jjCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775746598; c=relaxed/simple;
	bh=EKLcDrfJDCdLu9wOUgKS8fcgQOFqI7VVlslhE+oQvpo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dc/r2PGoPT0jp8Qug/qth8F6tOTmGZx91En8VHI/fbufQ07+7C2NIbFsj3PxCC8uH9U47Uqfdi1eQDUDQQNhkI1Eu20hzNXnn6Mosp2HBXfkarPW2PLsUVcizf9lOtbmNj7EfO1911mx462e1H91dPNQ1dAzf4VyYo/dt8npm6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hPmliW1z; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-50d5aa81907so27661431cf.0
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 07:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775746595; x=1776351395; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lb8s+I5gAkaKAV+5DqwuLTzF7/S/2P4CuxGALyM15sk=;
        b=hPmliW1z+/PJoi5T/CDY5fIvL5CWXIDBrsLyanyqhvJioCQR0KhDAropD3f37HqSwE
         /Bnr/vClzJVHOSXLYk5Xe0+PxTuxi5lIuEaTTR13mw0n8G3PxaSZR4KR4Uldd1rVk+MR
         Q0PzEFdo8VdohrgFa/RgvSykI4mvIvGC/H++U8DFDFTAkG1QFT3hv3IL+Sg7tWdhBuL6
         Mxlo87znQ/soRxb/+uIHRW4PH5GlWjnHrdOSJxSOhbQ2igCn9CxWUQ++B0oH8dy5T0VQ
         Dx98tXWlbw2xFMeNlyWB3Ak9OxkC6wjS6rK64LJWnvHfBGTUp8PhKfIT1ruxL9OiwrzN
         l2Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775746595; x=1776351395;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lb8s+I5gAkaKAV+5DqwuLTzF7/S/2P4CuxGALyM15sk=;
        b=WOF1/1t+ey2+uu5tyz0T/6gr0h2cA+flNAgGDv+/AIkxa8VgWgIWUsLlYqJ0xg2t2Y
         H9H+tpvfn7cxYFCJUfCaN8vx9ydZk2iQJFPOS6QbX/ql0SKSb3mDCDfZDKunJ1JF9h5u
         pj4YK47Jdvp2umZW1PdAZ5OAX8uvIuZ6SDdVEySi8KNob1W99Wu2REVAng5+U0i4gBOU
         Hr4ZK9xiT/hAA10VEpv9YDlKXPuVUv9Hc3Tj6/LLpJYs3ehreKc5XXMC5HKSpzOrcG0B
         4/qoxJv7wqRTQU91VqMbbND0M47Rt2C1l1T7EkyrZG5f/jRKafhj9Tfv58jHCArlQKku
         SXNA==
X-Forwarded-Encrypted: i=1; AJvYcCXzYaCIg0Y+Ac0K2pnIlBywz5H82oXC/8t5mXZm0ncWCMjBoE0TmaTD7lr1aikh9FQbbcBgu5w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4LD3hfsTTiryomg0S7E2fWVL41r7sdWEJhPCfpaif+Gq7EYny
	rEP5nBnU4jiD4yvHmiEiY4WNdfKC0jhPfYTfi8z86yYOj/VoW/IOAal87l+h+1dEL7Jv/YU78jF
	bCkXuUQIATzzl+w==
X-Received: from qtyf4.prod.google.com ([2002:a05:622a:1144:b0:50b:294c:1a4e])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:8c0b:b0:509:2eca:c156 with SMTP id d75a77b69052e-50d628ac780mr375745641cf.25.1775746595284;
 Thu, 09 Apr 2026 07:56:35 -0700 (PDT)
Date: Thu,  9 Apr 2026 14:56:24 +0000
In-Reply-To: <20260409145625.2306224-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409145625.2306224-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260409145625.2306224-6-edumazet@google.com>
Subject: [PATCH net-next 5/5] net: change sk_filter_trim_cap() to return a
 drop_reason by value
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277036-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vmlinux.new:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8CCA83CC488
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Current return value can be replaced with the drop_reason,
reducing kernel bloat:

$ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
add/remove: 0/2 grow/shrink: 1/11 up/down: 32/-603 (-571)
Function                                     old     new   delta
tcp_v6_rcv                                  3135    3167     +32
unix_dgram_sendmsg                          1731    1726      -5
netlink_unicast                              957     945     -12
netlink_dump                                1372    1359     -13
sk_filter_trim_cap                           882     858     -24
tcp_v4_rcv                                  3143    3111     -32
__pfx_tcp_filter                              32       -     -32
netlink_broadcast_filtered                  1633    1595     -38
sock_queue_rcv_skb_reason                    126      76     -50
tun_net_xmit                                1127    1074     -53
__sk_receive_skb                             690     632     -58
udpv6_queue_rcv_one_skb                      935     869     -66
udp_queue_rcv_one_skb                        919     853     -66
tcp_filter                                   154       -    -154
Total: Before=29722783, After=29722212, chg -0.00%

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/filter.h | 14 ++++++--------
 include/net/tcp.h      |  4 +---
 net/core/filter.c      | 31 ++++++++++++++-----------------
 net/core/sock.c        |  5 +++--
 net/ipv4/udp.c         |  3 ++-
 net/ipv6/udp.c         |  3 ++-
 net/rose/rose_in.c     |  3 +--
 7 files changed, 29 insertions(+), 34 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 59931e5810b4fcff5788616a3875767421dba3bc..5ac08aa70123cf97ab91dea7e11e47b210a42d4a 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1092,23 +1092,21 @@ bpf_jit_binary_lock_ro(struct bpf_binary_header *hdr)
 	return set_memory_rox((unsigned long)hdr, hdr->size >> PAGE_SHIFT);
 }
 
-int sk_filter_trim_cap(struct sock *sk, struct sk_buff *skb, unsigned int cap,
-		       enum skb_drop_reason *reason);
+enum skb_drop_reason
+sk_filter_trim_cap(struct sock *sk, struct sk_buff *skb, unsigned int cap);
 
 static inline int sk_filter(struct sock *sk, struct sk_buff *skb)
 {
-	enum skb_drop_reason ignore_reason;
+	enum skb_drop_reason drop_reason;
 
-	return sk_filter_trim_cap(sk, skb, 1, &ignore_reason);
+	drop_reason = sk_filter_trim_cap(sk, skb, 1);
+	return drop_reason ? -EPERM : 0;
 }
 
 static inline enum skb_drop_reason
 sk_filter_reason(struct sock *sk, struct sk_buff *skb)
 {
-	enum skb_drop_reason drop_reason;
-
-	sk_filter_trim_cap(sk, skb, 1, &drop_reason);
-	return drop_reason;
+	return sk_filter_trim_cap(sk, skb, 1);
 }
 
 struct bpf_prog *bpf_prog_select_runtime(struct bpf_prog *fp, int *err);
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 098e52269a04cb8938812a8f43caf11f9d5c68a3..49f45bcff917942e993c627dd3d0017369186f67 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1687,10 +1687,8 @@ static inline enum skb_drop_reason
 tcp_filter(struct sock *sk, struct sk_buff *skb)
 {
 	const struct tcphdr *th = (const struct tcphdr *)skb->data;
-	enum skb_drop_reason reason;
 
-	sk_filter_trim_cap(sk, skb, __tcp_hdrlen(th), &reason);
-	return reason;
+	return sk_filter_trim_cap(sk, skb, __tcp_hdrlen(th));
 }
 
 void tcp_set_state(struct sock *sk, int state);
diff --git a/net/core/filter.c b/net/core/filter.c
index 5569d83b8be06dc1fe64ddff2ae338acd1622ed7..bf9c37b27646943e3a6fdad2fadf00f5e1ea8244 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -121,20 +121,20 @@ EXPORT_SYMBOL_GPL(copy_bpf_fprog_from_user);
  *	@sk: sock associated with &sk_buff
  *	@skb: buffer to filter
  *	@cap: limit on how short the eBPF program may trim the packet
- *	@reason: record drop reason
  *
  * Run the eBPF program and then cut skb->data to correct size returned by
  * the program. If pkt_len is 0 we toss packet. If skb->len is smaller
  * than pkt_len we keep whole skb->data. This is the socket level
  * wrapper to bpf_prog_run. It returns 0 if the packet should
- * be accepted or -EPERM if the packet should be tossed.
+ * be accepted or a drop_reason if the packet should be tossed.
  *
  */
-int sk_filter_trim_cap(struct sock *sk, struct sk_buff *skb,
-		       unsigned int cap, enum skb_drop_reason *reason)
+enum skb_drop_reason
+sk_filter_trim_cap(struct sock *sk, struct sk_buff *skb, unsigned int cap)
 {
-	int err;
+	enum skb_drop_reason drop_reason;
 	struct sk_filter *filter;
+	int err;
 
 	/*
 	 * If the skb was allocated from pfmemalloc reserves, only
@@ -143,21 +143,17 @@ int sk_filter_trim_cap(struct sock *sk, struct sk_buff *skb,
 	 */
 	if (skb_pfmemalloc(skb) && !sock_flag(sk, SOCK_MEMALLOC)) {
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_PFMEMALLOCDROP);
-		*reason = SKB_DROP_REASON_PFMEMALLOC;
-		return -ENOMEM;
+		return SKB_DROP_REASON_PFMEMALLOC;
 	}
 	err = BPF_CGROUP_RUN_PROG_INET_INGRESS(sk, skb);
-	if (err) {
-		*reason = SKB_DROP_REASON_SOCKET_FILTER;
-		return err;
-	}
+	if (err)
+		return SKB_DROP_REASON_SOCKET_FILTER;
 
 	err = security_sock_rcv_skb(sk, skb);
-	if (err) {
-		*reason = SKB_DROP_REASON_SECURITY_HOOK;
-		return err;
-	}
+	if (err)
+		return SKB_DROP_REASON_SECURITY_HOOK;
 
+	drop_reason = 0;
 	rcu_read_lock();
 	filter = rcu_dereference(sk->sk_filter);
 	if (filter) {
@@ -168,11 +164,12 @@ int sk_filter_trim_cap(struct sock *sk, struct sk_buff *skb,
 		pkt_len = bpf_prog_run_save_cb(filter->prog, skb);
 		skb->sk = save_sk;
 		err = pkt_len ? pskb_trim(skb, max(cap, pkt_len)) : -EPERM;
+		if (err)
+			drop_reason = SKB_DROP_REASON_SOCKET_FILTER;
 	}
 	rcu_read_unlock();
 
-	*reason = err ? SKB_DROP_REASON_SOCKET_FILTER : 0;
-	return err;
+	return drop_reason;
 }
 EXPORT_SYMBOL(sk_filter_trim_cap);
 
diff --git a/net/core/sock.c b/net/core/sock.c
index 1ffcb15d0fc5e39201aab24616d40a37aa41c823..367fd7bad4ac2e6557dc73519ac0c04debb43cb3 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -544,11 +544,12 @@ EXPORT_SYMBOL(sock_queue_rcv_skb_reason);
 int __sk_receive_skb(struct sock *sk, struct sk_buff *skb,
 		     const int nested, unsigned int trim_cap, bool refcounted)
 {
-	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
+	enum skb_drop_reason reason;
 	int rc = NET_RX_SUCCESS;
 	int err;
 
-	if (sk_filter_trim_cap(sk, skb, trim_cap, &reason))
+	reason = sk_filter_trim_cap(sk, skb, trim_cap);
+	if (reason)
 		goto discard_and_relse;
 
 	skb->dev = NULL;
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index ab415de32443c5d32eedca5f093d5d96681f6b48..2fddc7b6b7172045286a8a0902f8bcf41aaca7c4 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2392,7 +2392,8 @@ static int udp_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
 	    udp_lib_checksum_complete(skb))
 			goto csum_error;
 
-	if (sk_filter_trim_cap(sk, skb, sizeof(struct udphdr), &drop_reason))
+	drop_reason = sk_filter_trim_cap(sk, skb, sizeof(struct udphdr));
+	if (drop_reason)
 		goto drop;
 
 	udp_csum_pull_header(skb);
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index d7cf4c9508b2c5c92753eddf8de1717f52347fbf..3fac9cb47ae00fe26c60ba2aee61748b4a241221 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -853,7 +853,8 @@ static int udpv6_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
 	    udp_lib_checksum_complete(skb))
 		goto csum_error;
 
-	if (sk_filter_trim_cap(sk, skb, sizeof(struct udphdr), &drop_reason))
+	drop_reason = sk_filter_trim_cap(sk, skb, sizeof(struct udphdr));
+	if (drop_reason)
 		goto drop;
 
 	udp_csum_pull_header(skb);
diff --git a/net/rose/rose_in.c b/net/rose/rose_in.c
index 0276b393f0e530ea2d8f689a3dd95364849910ac..3aff3c2d45a956a5c791beb5c2d5c4e4d7063d6a 100644
--- a/net/rose/rose_in.c
+++ b/net/rose/rose_in.c
@@ -101,7 +101,6 @@ static int rose_state2_machine(struct sock *sk, struct sk_buff *skb, int framety
  */
 static int rose_state3_machine(struct sock *sk, struct sk_buff *skb, int frametype, int ns, int nr, int q, int d, int m)
 {
-	enum skb_drop_reason dr; /* ignored */
 	struct rose_sock *rose = rose_sk(sk);
 	int queued = 0;
 
@@ -163,7 +162,7 @@ static int rose_state3_machine(struct sock *sk, struct sk_buff *skb, int framety
 		rose_frames_acked(sk, nr);
 		if (ns == rose->vr) {
 			rose_start_idletimer(sk);
-			if (!sk_filter_trim_cap(sk, skb, ROSE_MIN_LEN, &dr) &&
+			if (!sk_filter_trim_cap(sk, skb, ROSE_MIN_LEN) &&
 			    __sock_queue_rcv_skb(sk, skb) == 0) {
 				rose->vr = (rose->vr + 1) % ROSE_MODULUS;
 				queued = 1;
-- 
2.53.0.1213.gd9a14994de-goog


