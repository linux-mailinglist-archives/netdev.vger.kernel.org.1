Return-Path: <netdev+bounces-228820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D79BD4CAB
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 18:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2DA342678A
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 15:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847C630FF27;
	Mon, 13 Oct 2025 15:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eon7fckd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA2F30FF01
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 15:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760368968; cv=none; b=nMC4zQsmH450QXoqYpMlhCkfo8bUYjTFvHxedYvjFj32VajXAUkuhOEYwFK5j1GFCnGaMbkICoa7OGQn2WYuyGLW7tXhIRtugWDADMY9I/TG6+YxcnhdIgcwQ7S5ozttEZWB+H4CyYW+2pj5PHAahdcWELsNhQnHqAicCxGoUnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760368968; c=relaxed/simple;
	bh=iMqi7+vQdSOqT2QFcw1OAEvKxDfVV0RORaYooVR2mUY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KRn87NULTilJzzCx10xPz1piW8RtsgHsj/Ab3vdFg0hc/YBmnDEftDqToT19N2IlT5yoVoDoS5emISf87xUmtp1CrYvRN+DkdRjL6C13XBjxnglHvzGWX5BSdnh3UKox0+SDUI2D/9m3J/l6fLWityE9btgXmL7I9qPu0fFLm/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eon7fckd; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-87561645c1cso2464824485a.1
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 08:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760368965; x=1760973765; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WjEMsK/WXBv5smd1M4nIYwVusvxPG/+QHjWHVP8Bf3k=;
        b=eon7fckdC5wcNZtiN0EYlZtJn+Q53G87bzZ9tfqxSrIaQWZNK2uwmOWx1G9//zyNb0
         i2B5JaddJvOuoKcqZlJIFBGjTrDEd705bCV4V4DNqsCEIv9dtdiAofSPqPoo3iOA9ohB
         Q/II+oxtAcyL2XbuJCIUi4bzi0QNMIs2mna8pBLpuBVRgc+V9Boihk5Xj3/d/BTTjKao
         2v7WB89mRDVakUMy7dCHEHREeNvvAtTLtsRccasz5CNAy73c25bfhqLxOAzUBn7csZvB
         bTuU6/6eIHrCySJzcCB7tdqEn7AzIZ+1mXmOGSgbFtNIuB3EZGMlP0JOolth8B3utDAi
         DeCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760368965; x=1760973765;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WjEMsK/WXBv5smd1M4nIYwVusvxPG/+QHjWHVP8Bf3k=;
        b=rAiUBre5cyE0hTIkwZ4FBpkkFixi46BGuS6vDL54b9IyWpYw3RxQw6775AjFkCvSa8
         nnYlD1//t7V1FHngudUb1LcZ4VlDHLv7OSNMtnDAf9bjfdbQfX+O5IKt4lR7EB99b+cQ
         PcF15Of7ZiBJoLCqMwg8LHtrHzv9bu4w1Y/XNDgXwVPMH1GcM49vLS2kC1Kw3h+PsCnW
         KoSc4i97yBv2t6FPl2MVJTjhX40azH9zZzz5QWnkpXSL9Bl3Zfh8Jvijs32wVJtRmJjK
         5F78DK0/uxVdrSpAGP89/7PvMuahuHGBv5l1LF4N7LJaoCZlPmU4+5Lk+cNSfujf1FkQ
         zkYg==
X-Forwarded-Encrypted: i=1; AJvYcCUCJuU4HQxlv0oLYG9yxX8m5FYCoalbTo3/KPmEK3JCNGHpSNtocwWO0MnhjeN5TWL0qfcBIIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNasZ1/QFV/R8GRs+vvi02z64YX8kD0od5i0Z+Jij8GjiR6KjN
	4gLTSY84ESBKHm7upnGzmDzA1LPBrDPvsAK3E08QgPLQfa8w+bF/K5EZIJw73LaI9WQe+KlKKjB
	gcphLPxskVshHXA==
X-Google-Smtp-Source: AGHT+IG2mwZcc6I5Afac648ugdwWI9tdsR9pPpPO8+kkE6qpkDysxcFA/kZmoiJHFceVkAm4JvcdKRcHLFXYDg==
X-Received: from qkhn19.prod.google.com ([2002:a05:620a:2233:b0:862:855f:a6ef])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:2947:b0:888:f40a:256 with SMTP id af79cd13be357-888f40a0418mr641367085a.65.1760368965486;
 Mon, 13 Oct 2025 08:22:45 -0700 (PDT)
Date: Mon, 13 Oct 2025 15:22:34 +0000
In-Reply-To: <20251013152234.842065-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251013152234.842065-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.740.g6adb054d12-goog
Message-ID: <20251013152234.842065-5-edumazet@google.com>
Subject: [PATCH v1 net-next 4/4] net: allow busy connected flows to switch tx queues
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This is a followup of commit 726e9e8b94b9 ("tcp: refine
skb->ooo_okay setting") and of prior commit in this series
("net: control skb->ooo_okay from skb_set_owner_w()")

skb->ooo_okay might never be set for bulk flows that always
have at least one skb in a qdisc queue of NIC queue,
especially if TX completion is delayed because of a stressed cpu.

The so-called "strange attractors" has caused many performance
issues (see for instance 9b462d02d6dd ("tcp: TCP Small Queues
and strange attractors")), we need to do better.

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

Note for later:

1) move sk->sk_tx_queue_mapping closer
to sk_tx_queue_mapping_jiffies for better cache locality.

2) Study if 9b462d02d6dd ("tcp: TCP Small Queues
and strange attractors") could be revised.

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
 include/net/sock.h | 26 ++++++++++++--------------
 net/core/dev.c     | 29 +++++++++++++++++++++++++++--
 2 files changed, 39 insertions(+), 16 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 2794bc5c565424491a064049d3d76c3fb7ba1ed8..f0d00928db9e9241a2f2b9f193725bda9f5c0b69 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -313,6 +313,7 @@ struct sk_filter;
   *	@sk_bind_phc: SO_TIMESTAMPING bind PHC index of PTP virtual clock
   *	              for timestamping
   *	@sk_tskey: counter to disambiguate concurrent tstamp requests
+  *	@sk_tx_queue_mapping_jiffies: time in jiffies of last @sk_tx_queue_mapping refresh.
   *	@sk_zckey: counter to order MSG_ZEROCOPY notifications
   *	@sk_socket: Identd and reporting IO signals
   *	@sk_user_data: RPC layer private data. Write-protected by @sk_callback_lock.
@@ -485,6 +486,7 @@ struct sock {
 	unsigned long		sk_pacing_rate; /* bytes per second */
 	atomic_t		sk_zckey;
 	atomic_t		sk_tskey;
+	unsigned long		sk_tx_queue_mapping_jiffies;
 	__cacheline_group_end(sock_write_tx);
 
 	__cacheline_group_begin(sock_read_tx);
@@ -1992,7 +1994,15 @@ static inline void sk_tx_queue_set(struct sock *sk, int tx_queue)
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
@@ -2005,19 +2015,7 @@ static inline void sk_tx_queue_clear(struct sock *sk)
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
diff --git a/net/core/dev.c b/net/core/dev.c
index a64cef2c537e98ee87776e6f8d3ca3d98f0711b3..33e6101dbc4546aafec627c38cbebb222ea67196 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4591,6 +4591,32 @@ u16 dev_pick_tx_zero(struct net_device *dev, struct sk_buff *skb,
 }
 EXPORT_SYMBOL(dev_pick_tx_zero);
 
+int sk_tx_queue_get(const struct sock *sk)
+{
+	int resel, val;
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
+	if (!sk_fullsock(sk))
+		return val;
+
+	resel = READ_ONCE(sock_net(sk)->core.sysctl_txq_reselection);
+	if (resel && time_is_before_jiffies(
+			READ_ONCE(sk->sk_tx_queue_mapping_jiffies) + resel))
+		return -1;
+
+	return val;
+}
+EXPORT_SYMBOL(sk_tx_queue_get);
+
 u16 netdev_pick_tx(struct net_device *dev, struct sk_buff *skb,
 		     struct net_device *sb_dev)
 {
@@ -4606,8 +4632,7 @@ u16 netdev_pick_tx(struct net_device *dev, struct sk_buff *skb,
 		if (new_index < 0)
 			new_index = skb_tx_hash(dev, sb_dev, skb);
 
-		if (queue_index != new_index && sk &&
-		    sk_fullsock(sk) &&
+		if (sk && sk_fullsock(sk) &&
 		    rcu_access_pointer(sk->sk_dst_cache))
 			sk_tx_queue_set(sk, new_index);
 
-- 
2.51.0.740.g6adb054d12-goog


