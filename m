Return-Path: <netdev+bounces-282320-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPCxERXO8WlrkgEAu9opvQ
	(envelope-from <netdev+bounces-282320-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 11:23:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E462491D19
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 11:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 48CA930B47C9
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 09:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E033B95E3;
	Wed, 29 Apr 2026 09:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="wmTXEC7c"
X-Original-To: netdev@vger.kernel.org
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1DB3BED0C
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 09:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777454208; cv=none; b=PyT6t2CHcpxkx63lC07VuzjTWg093jT99ho3P6tm/eRF3fkd6NNNOTVikjWBKv8CbSQEiaL7/5yZBGLXnEQVlTbIS0rlNv5HFwIs509IPNpFrmSUR4PcmcVKvRheyKuZD1Ntb3854gMDf0gjskz6NI0Mz6eSsGZB/kkbsKWzzao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777454208; c=relaxed/simple;
	bh=BtyKV9NZOconOnomTH/UMSFkP7SG9aItrYg4CEfxGwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EZDAmXmKfuwI1vhmQDwmSkwTk4EApUVejhzTgFj7hJoDhuDsG6X250w/yMdrm/Tzqr1AYpPexiHyKTCatt9tRpQnoLj+jfuKHOr6mTlVKqSqqOF5fU2/VLd6jBm/CEzujATcu9GwVoVmu6cDemaQQIsfeI1Gn/S90L5YaId9TMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=wmTXEC7c; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Received: from ms-a2 (197.87.13.160.dy.iij4u.or.jp [160.13.87.197])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 63T9GcJs043714
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 29 Apr 2026 18:16:39 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=w8mHdSft4ki0M+uNQDu5TQHCbUgfsD+iSWwxpqDgs9c=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20251215; t=1777454200; v=1;
        b=wmTXEC7cpp7Ca0gt6WK9uo9tXUItXXhKHWUVBLxeNx9aWDQrFJwTaDd8ymbCVWeI
         XE06nR2U6ho8PWHt7eQ8ehP7jPwtfh6EU3YKs7otu1d2nKgJ/TYagtszEapkEGVi
         Y7oLoHhaqERCAhT+W7y3jCmAthua3Owp7k5AkUWWWxwJZ8FMJa/rBLBFbeOfPe3h
         LF+1Hf+0eRIQrckIrP3ggcCWaW9fDfmewxAW56tUJnzob9ZWi58Ov7zaXaky7OY8
         bvpwUzuZ6u99LRZ0v7iZc9bfxKcija4HZwgZYqnVx6SCAtBjVHHOWfL/mMEkbxxp
         3ObqEedZxyb5Kj9Y2WAxQw==
From: Kohei Enju <kohei@enjuk.jp>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Kuniyuki Iwashima <kuniyu@google.com>,
        Willem de Bruijn <willemb@google.com>,
        David Ahern <dsahern@kernel.org>, Neal Cardwell <ncardwell@google.com>,
        Gerhard Engleder <gerhard@engleder-embedded.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Kohei Enju <kohei@enjuk.jp>
Subject: [PATCH net v1 1/3] net: introduce helper to resolve hardware timestamps from skb
Date: Wed, 29 Apr 2026 09:16:17 +0000
Message-ID: <20260429091632.26509-2-kohei@enjuk.jp>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429091632.26509-1-kohei@enjuk.jp>
References: <20260429091632.26509-1-kohei@enjuk.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9E462491D19
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[enjuk.jp,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[enjuk.jp:s=rs20251215];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,engleder-embedded.com,gmail.com,enjuk.jp];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-282320-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kohei@enjuk.jp,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[enjuk.jp:+];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,enjuk.jp:email,enjuk.jp:dkim,enjuk.jp:mid]

Move the logic that resolves a hardware timestamp from an skb, including
late timestamp resolution via netdev_get_tstamp(), from net/socket.c to
a common helper.

Let's allow other networking code to reuse the same resolution path.

Signed-off-by: Kohei Enju <kohei@enjuk.jp>
---
 include/linux/skbuff.h | 11 +++++++++++
 net/core/skbuff.c      | 27 +++++++++++++++++++++++++++
 net/socket.c           | 27 +++------------------------
 3 files changed, 41 insertions(+), 24 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 2bcf78a4de7b..651a5ae8b11c 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4731,6 +4731,17 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb, const struct sk_buff *ack_skb,
 void skb_tstamp_tx(struct sk_buff *orig_skb,
 		   struct skb_shared_hwtstamps *hwtstamps);
 
+/**
+ * skb_get_hwtstamp - resolve a hardware timestamp from an skb
+ * @skb:	skb carrying the timestamp
+ * @cycles:	true to request the free-running cycle-based timestamp
+ * @if_index:	optional return pointer for the originating netdev ifindex
+ *
+ * Return: resolved hardware timestamp, or the stored skb hwtstamp when no
+ * device-specific late timestamp resolution is needed.
+ */
+ktime_t skb_get_hwtstamp(struct sk_buff *skb, bool cycles, int *if_index);
+
 /**
  * skb_tx_timestamp() - Driver hook for transmit timestamping
  *
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 7dad68e3b518..d11f4e2e9391 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5729,6 +5729,33 @@ void skb_tstamp_tx(struct sk_buff *orig_skb,
 }
 EXPORT_SYMBOL_GPL(skb_tstamp_tx);
 
+ktime_t skb_get_hwtstamp(struct sk_buff *skb, bool cycles, int *if_index)
+{
+	struct skb_shared_hwtstamps *shhwtstamps = skb_hwtstamps(skb);
+	struct net_device *orig_dev;
+	ktime_t hwtstamp;
+
+	if (if_index)
+		*if_index = 0;
+
+	if (!(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP_NETDEV))
+		return shhwtstamps->hwtstamp;
+
+	rcu_read_lock();
+	orig_dev = dev_get_by_napi_id(skb_napi_id(skb));
+	if (orig_dev) {
+		if (if_index)
+			*if_index = orig_dev->ifindex;
+		hwtstamp = netdev_get_tstamp(orig_dev, shhwtstamps, cycles);
+	} else {
+		hwtstamp = shhwtstamps->hwtstamp;
+	}
+	rcu_read_unlock();
+
+	return hwtstamp;
+}
+EXPORT_SYMBOL_GPL(skb_get_hwtstamp);
+
 #ifdef CONFIG_WIRELESS
 void skb_complete_wifi_ack(struct sk_buff *skb, bool acked)
 {
diff --git a/net/socket.c b/net/socket.c
index 22a412fdec07..95b21b16a0fc 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -876,21 +876,7 @@ static bool skb_is_swtx_tstamp(const struct sk_buff *skb, int false_tstamp)
 static ktime_t get_timestamp(struct sock *sk, struct sk_buff *skb, int *if_index)
 {
 	bool cycles = READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_BIND_PHC;
-	struct skb_shared_hwtstamps *shhwtstamps = skb_hwtstamps(skb);
-	struct net_device *orig_dev;
-	ktime_t hwtstamp;
-
-	rcu_read_lock();
-	orig_dev = dev_get_by_napi_id(skb_napi_id(skb));
-	if (orig_dev) {
-		*if_index = orig_dev->ifindex;
-		hwtstamp = netdev_get_tstamp(orig_dev, shhwtstamps, cycles);
-	} else {
-		hwtstamp = shhwtstamps->hwtstamp;
-	}
-	rcu_read_unlock();
-
-	return hwtstamp;
+	return skb_get_hwtstamp(skb, cycles, if_index);
 }
 
 static void put_ts_pktinfo(struct msghdr *msg, struct sk_buff *skb,
@@ -940,7 +926,6 @@ int skb_get_tx_timestamp(struct sk_buff *skb, struct sock *sk,
 {
 	u32 tsflags = READ_ONCE(sk->sk_tsflags);
 	ktime_t hwtstamp;
-	int if_index = 0;
 
 	if ((tsflags & SOF_TIMESTAMPING_SOFTWARE) &&
 	    ktime_to_timespec64_cond(skb->tstamp, ts))
@@ -950,10 +935,7 @@ int skb_get_tx_timestamp(struct sk_buff *skb, struct sock *sk,
 	    skb_is_swtx_tstamp(skb, false))
 		return -ENOENT;
 
-	if (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP_NETDEV)
-		hwtstamp = get_timestamp(sk, skb, &if_index);
-	else
-		hwtstamp = skb_hwtstamps(skb)->hwtstamp;
+	hwtstamp = get_timestamp(sk, skb, NULL);
 
 	if (tsflags & SOF_TIMESTAMPING_BIND_PHC)
 		hwtstamp = ptp_convert_timestamp(&hwtstamp,
@@ -1033,10 +1015,7 @@ void __sock_recv_timestamp(struct msghdr *msg, struct sock *sk,
 	      !(tsflags & SOF_TIMESTAMPING_OPT_RX_FILTER))) &&
 	    !skb_is_swtx_tstamp(skb, false_tstamp)) {
 		if_index = 0;
-		if (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP_NETDEV)
-			hwtstamp = get_timestamp(sk, skb, &if_index);
-		else
-			hwtstamp = shhwtstamps->hwtstamp;
+		hwtstamp = get_timestamp(sk, skb, &if_index);
 
 		if (tsflags & SOF_TIMESTAMPING_BIND_PHC)
 			hwtstamp = ptp_convert_timestamp(&hwtstamp,
-- 
2.53.0


