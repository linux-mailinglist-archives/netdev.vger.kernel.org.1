Return-Path: <netdev+bounces-228198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1B0BC46DB
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 12:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 61392351767
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 10:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047492F60A7;
	Wed,  8 Oct 2025 10:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NXLt1khm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A9E2F656E
	for <netdev@vger.kernel.org>; Wed,  8 Oct 2025 10:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759920384; cv=none; b=rIcpIwnsKQuriyvL7VtO0uSPuIILKyy7uRG5tVKkhgSFCI8qctxKoWBvD3btnAqR/3NidbsXJKXqqTJXtbOCqwwtZPUXjosrlWXWB6D2m7o4IzxtMcA/ba7ftA87SVu/ysMp0LVX90cSdk7maiIaa97RjBylwfSaPMfGDuWSAQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759920384; c=relaxed/simple;
	bh=0ra8nXlbd6UdV389/p9UZr5B6CEsoMEc9ZPTtsQrqis=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A5FviRACd56QkmXYoQUhwVUykZcoRPj8rxFylKRavHV/DOt2IoUuLanXQrrE8ixZB4pPJuccIQzrnhtn7nuZkszZbaMsuWL3ofwQPJeCbKK6m5aHtMrlJvem1kVrkUzgn4fabSdfM81iTJ2spbLJNwpHbLGbspokfUnJi9mun5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NXLt1khm; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8217df6d44cso1476168685a.2
        for <netdev@vger.kernel.org>; Wed, 08 Oct 2025 03:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759920382; x=1760525182; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yJMLCa+1UuMu+557ljbA1I+kjOJa9OtlmtoC19Uca10=;
        b=NXLt1khmBkSJYfTp/RKqIWuYyYk45xAhTp2tijcLJ3yTddHpOtVqIBKsYue2oBEp+Z
         vedpxfyJSGZOey+CzQ49z9o8RFRdj4bbyFiwTHR9VSb9AN9gQZL1mKWkAK/AEs/0Bf49
         Ob26FMfQDPi06v1pu27M0/YBIp2euGl3QdXpzRSmy0TFktp7iyInBRSAHlG2Eesf/DJ1
         4RPgrqkKDwwN1vB13zEcX2RcaZn7JzaEjGS8VPzVwZbxKi3YpkZcWzlVYhVUqTKkOapC
         1SGHKZzm3FwmkM9f0R84rx39tODI4S9C1EXFJBuiSY3M8JztnnrkhXpAuxQ2YTFVKsvg
         lOvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759920382; x=1760525182;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yJMLCa+1UuMu+557ljbA1I+kjOJa9OtlmtoC19Uca10=;
        b=CidyR4CGFY7Zd16+uUQ5iggHkwZN5VsSC1iCvL6ohk+nyA0lFlYZZ7+zU4GekgUqI8
         zLd5iJexEDMCXvj2EcRDrknn9dZPilU9QmVGTdKIOru6VxhFjRGoKJ/dgHRTZRbtgJ1H
         u5TNdt4u0Y8gTgD7axKCuGXlmlqeRuGzUQuRWrYuv94hM8Z8+8hSwLfNn3fQdSMHD9j6
         +Dr6mCBGOVylE69Q1nV1U9Nqymwo5CisjqNm9T1OMomJUrt2Yi6vZCZD3dIV7/oH9vLN
         4g7vACKkzycuchds/Ij/JEn9eeBM9rz2GxGE8Xt2CSoQ9UpnCkpuyinrQTRI8PPjalpd
         ltjw==
X-Forwarded-Encrypted: i=1; AJvYcCXtv4Tj2370McWMJcdPmm3GM2Wk8YlU5/MSsO8vXH0nC5rNZBGcT7yxDjH3keJ19p06G2XSMF0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2x6vYQoGzMwfzrlpEFHRTGRsONz/7ifQbEX0BTqwdNo/CkzEm
	ZY3skJ5ni9hcqQ59uOSjhr3vV9avLhUm4q6fJQOe+MJPMGBy87XIrfp1qMnN0lg6PFHRRNKpV2x
	SfHhcV7MDuxP7SQ==
X-Google-Smtp-Source: AGHT+IFNu4OBwpUDaMAdJdpdI6CltW8IyL9Cxbe7u//pS/uyZzDVGi/aV3V8T+elqX6E6CsufFfjkiXpVDGO7Q==
X-Received: from qknov1.prod.google.com ([2002:a05:620a:6281:b0:85a:48d9:f929])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:1993:b0:810:44f8:7b3b with SMTP id af79cd13be357-88350a7d47fmr412642785a.33.1759920381997;
 Wed, 08 Oct 2025 03:46:21 -0700 (PDT)
Date: Wed,  8 Oct 2025 10:46:11 +0000
In-Reply-To: <20251008104612.1824200-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251008104612.1824200-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.710.ga91ca5db03-goog
Message-ID: <20251008104612.1824200-5-edumazet@google.com>
Subject: [PATCH RFC net-next 4/4] net: allow busy connected flows to switch tx queues
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This is a followup of commit 726e9e8b94b9 ("tcp: refine
skb->ooo_okay setting") and to the prior commit in this series
("net: control skb->ooo_okay from skb_set_owner_w()")

skb->ooo_okay might never be set for bulk flows that always
have at least one skb in a qdisc queue of NIC queue,
especially if TX completion is delayed because of a stressed cpu.

The so-called "strange attractors" has caused many performance
issues, we need to do better.

We have tried very hard to avoid reorders because TCP was
not dealing with them nicely a decade ago.

Use the new net.core.txq_reselection_ms sysctl to let
flows follow XPS and select a more efficient queue.

After this patch, we no longer have to make sure threads
are pinned to cpus, they now can be migrated without
adding too much spinlock/qdisc/TX completion pressure anymore.

TX completion part was problematic, because it added false sharing
on various socket fields, but also added false sharing and spinlock
contention in mm layers. Calling skb_orphan() from ndo_start_xmit()
is not an option unfortunately.

Note for later: move sk->sk_tx_queue_mapping closer
to sk_tx_queue_mapping_jiffies for better cache locality.

Tested:

Used a host with 32 TX queues, shared by groups of 8 cores.
XPS setup :

echo ff >/sys/class/net/eth1/queue/tx-0/xps_cpus
echo ff00 >/sys/class/net/eth1/queue/tx-1/xps_cpus
echo ff0000 >/sys/class/net/eth1/queue/tx-2/xps_cpus
echo ff000000 >/sys/class/net/eth1/queue/tx-3/xps_cpus
echo ff,00000000 >/sys/class/net/eth1/queue/tx-4/xps_cpus
echo ff00,00000000 >/sys/class/net/eth1/queue/tx-5/xps_cpus
echo ff0000,00000000 >/sys/class/net/eth1/queue/tx-6/xps_cpus
echo ff000000,00000000 >/sys/class/net/eth1/queue/tx-7/xps_cpus
...

Launched a tcp_stream with 15 threads and 1000 flows, initially affined to core 0-15

taskset -c 0-15 tcp_stream -T15 -F1000 -l1000 -c -H target_host

Checked that only queues 0 and 1 are used as instructed by XPS :
tc -s qdisc show dev eth1|grep backlog|grep -v "backlog 0b 0p"
 backlog 123489410b 1890p
 backlog 69809026b 1064p
 backlog 52401054b 805p

Then force each thread to run on cpu 1,9,17,25,33,41,49,57,65,73,81,89,97,105,113,121

C=1;PID=`pidof tcp_stream`;for P in `ls /proc/$PID/task`; do taskset -pc $C $P; C=$(($C + 8));done

Set txq_reselection_ms to 1000
echo 1000 > /proc/sys/net/core/txq_reselection_ms

Check that the flows have migrated nicely:

tc -s qdisc show dev eth1|grep backlog|grep -v "backlog 0b 0p"
 backlog 130508314b 1916p
 backlog 8584380b 126p
 backlog 8584380b 126p
 backlog 8379990b 123p
 backlog 8584380b 126p
 backlog 8487484b 125p
 backlog 8584380b 126p
 backlog 8448120b 124p
 backlog 8584380b 126p
 backlog 8720640b 128p
 backlog 8856900b 130p
 backlog 8584380b 126p
 backlog 8652510b 127p
 backlog 8448120b 124p
 backlog 8516250b 125p
 backlog 7834950b 115p

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/sock.h | 40 +++++++++++++++++++---------------------
 net/core/dev.c     | 27 +++++++++++++++++++++++++--
 2 files changed, 44 insertions(+), 23 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 2794bc5c565424491a064049d3d76c3fb7ba1ed8..61f92bb03e00d7167cccfe70da16174f2b40f6de 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -485,6 +485,7 @@ struct sock {
 	unsigned long		sk_pacing_rate; /* bytes per second */
 	atomic_t		sk_zckey;
 	atomic_t		sk_tskey;
+	unsigned long		sk_tx_queue_mapping_jiffies;
 	__cacheline_group_end(sock_write_tx);
 
 	__cacheline_group_begin(sock_read_tx);
@@ -1984,6 +1985,14 @@ static inline int sk_receive_skb(struct sock *sk, struct sk_buff *skb,
 	return __sk_receive_skb(sk, skb, nested, 1, true);
 }
 
+/* This helper checks if a socket is a full socket,
+ * ie _not_ a timewait or request socket.
+ */
+static inline bool sk_fullsock(const struct sock *sk)
+{
+	return (1 << sk->sk_state) & ~(TCPF_TIME_WAIT | TCPF_NEW_SYN_RECV);
+}
+
 static inline void sk_tx_queue_set(struct sock *sk, int tx_queue)
 {
 	/* sk_tx_queue_mapping accept only upto a 16-bit value */
@@ -1992,7 +2001,15 @@ static inline void sk_tx_queue_set(struct sock *sk, int tx_queue)
 	/* Paired with READ_ONCE() in sk_tx_queue_get() and
 	 * other WRITE_ONCE() because socket lock might be not held.
 	 */
-	WRITE_ONCE(sk->sk_tx_queue_mapping, tx_queue);
+	if (READ_ONCE(sk->sk_tx_queue_mapping) != tx_queue) {
+		WRITE_ONCE(sk->sk_tx_queue_mapping, tx_queue);
+		WRITE_ONCE(sk->sk_tx_queue_mapping_jiffies, jiffies);
+		return;
+	}
+
+	/* Refresh sk_tx_queue_mapping_jiffies if too old. */
+	if (time_is_before_jiffies(READ_ONCE(sk->sk_tx_queue_mapping_jiffies) + HZ))
+		WRITE_ONCE(sk->sk_tx_queue_mapping_jiffies, jiffies);
 }
 
 #define NO_QUEUE_MAPPING	USHRT_MAX
@@ -2005,19 +2022,7 @@ static inline void sk_tx_queue_clear(struct sock *sk)
 	WRITE_ONCE(sk->sk_tx_queue_mapping, NO_QUEUE_MAPPING);
 }
 
-static inline int sk_tx_queue_get(const struct sock *sk)
-{
-	if (sk) {
-		/* Paired with WRITE_ONCE() in sk_tx_queue_clear()
-		 * and sk_tx_queue_set().
-		 */
-		int val = READ_ONCE(sk->sk_tx_queue_mapping);
-
-		if (val != NO_QUEUE_MAPPING)
-			return val;
-	}
-	return -1;
-}
+int sk_tx_queue_get(const struct sock *sk);
 
 static inline void __sk_rx_queue_set(struct sock *sk,
 				     const struct sk_buff *skb,
@@ -2945,13 +2950,6 @@ skb_sk_is_prefetched(struct sk_buff *skb)
 #endif /* CONFIG_INET */
 }
 
-/* This helper checks if a socket is a full socket,
- * ie _not_ a timewait or request socket.
- */
-static inline bool sk_fullsock(const struct sock *sk)
-{
-	return (1 << sk->sk_state) & ~(TCPF_TIME_WAIT | TCPF_NEW_SYN_RECV);
-}
 
 static inline bool
 sk_is_refcounted(struct sock *sk)
diff --git a/net/core/dev.c b/net/core/dev.c
index a64cef2c537e98ee87776e6f8d3ca3d98f0711b3..c302fd5bb57894c6e5651b7adc8d033ac719070a 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4591,6 +4591,30 @@ u16 dev_pick_tx_zero(struct net_device *dev, struct sk_buff *skb,
 }
 EXPORT_SYMBOL(dev_pick_tx_zero);
 
+int sk_tx_queue_get(const struct sock *sk)
+{
+	int val;
+
+	if (!sk)
+		return -1;
+	/* Paired with WRITE_ONCE() in sk_tx_queue_clear()
+	 * and sk_tx_queue_set().
+	 */
+	val = READ_ONCE(sk->sk_tx_queue_mapping);
+
+	if (val == NO_QUEUE_MAPPING)
+		return -1;
+
+	if (sk_fullsock(sk) &&
+	    time_is_before_jiffies(
+			READ_ONCE(sk->sk_tx_queue_mapping_jiffies) +
+			READ_ONCE(sock_net(sk)->core.sysctl_txq_reselection)))
+		return -1;
+
+	return val;
+}
+EXPORT_SYMBOL(sk_tx_queue_get);
+
 u16 netdev_pick_tx(struct net_device *dev, struct sk_buff *skb,
 		     struct net_device *sb_dev)
 {
@@ -4606,8 +4630,7 @@ u16 netdev_pick_tx(struct net_device *dev, struct sk_buff *skb,
 		if (new_index < 0)
 			new_index = skb_tx_hash(dev, sb_dev, skb);
 
-		if (queue_index != new_index && sk &&
-		    sk_fullsock(sk) &&
+		if (sk && sk_fullsock(sk) &&
 		    rcu_access_pointer(sk->sk_dst_cache))
 			sk_tx_queue_set(sk, new_index);
 
-- 
2.51.0.710.ga91ca5db03-goog


