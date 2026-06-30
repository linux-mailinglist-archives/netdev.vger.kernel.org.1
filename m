Return-Path: <netdev+bounces-303226-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dm7SFXzOQ2odiwoAu9opvQ
	(envelope-from <netdev+bounces-303226-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:11:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5414E6E541F
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:11:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=on1N1lpv;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303226-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-303226-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 189DB3029A20
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D657426699;
	Tue, 30 Jun 2026 14:06:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC93425CD8
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 14:06:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782828398; cv=none; b=gzhqFz3OuZrw8s5r6xqUwgCoGIFBsS2mjdEb1aa871D5k2tI8sCmSjbCqF6+So9onTJ2EzifsnLBDEkG43FuW9S6u1qgg5LGNs5Y+wwyCGheEM55nwM4ro/nKEG0sOMt+kqahXcGQUUmTJntc4QJomh/lvVi5XwYUTcB9HUhxzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782828398; c=relaxed/simple;
	bh=+vLUCX7vmL8POGfYhJtY8IImrxHLeyQuZQEniFqN864=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PmEo2Dya45dyTsz300JtE2bGR1xVqntB4YVa43s/h8gpcQnqK4zjqVB7yvjprasAbQnVzFLSJoVPVV4IRDl+hd31AvJI68C/2SzxX54zxeK7sl1flXlCqE9B6cpViu5u2rSsId9bjEk4AFN86WmunqbI08MCevLZHpOrkUkOm8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=on1N1lpv; arc=none smtp.client-ip=23.88.38.48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1782828394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/A/lWkFFxsADNYR6ctfo5FNUgSYXHylU8HbDgM1S/+I=;
	b=on1N1lpv2xC51nr5//XkErI/KoAZiGRGHLIKzzvb8gLvj19cK3pN0Vchfa6k/wUKwJo3Dw
	fjTsoCkmcpYLMkZ/t2Uykwy4MmzUGdus3DSGCIKNDkMTTvWnNJ/srZmINgH/bOrPX0HCGj
	r7gIc4w4YDk77wyrGabne7Po1H69WKRGGANBnoVT11F/7ncU9C8BD5CXwbf3Jcj/Tkqow8
	gkC+YHCdcr7RgH7y0hH8siOxxwykAp80Z7L8eWlMvM/C1G+89iH++LSVdpexo7LceZgtYf
	FTstnYB8EChoJVLOeYRsyxNAcPjJsdR3uOCxje9rYqv+lj37WUBqiSgcsMb6LQ==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 13/15] batman-adv: tp_meter: keep unacked list for receivers
Date: Tue, 30 Jun 2026 16:06:21 +0200
Message-ID: <20260630140623.88431-14-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630140623.88431-1-sw@simonwunderlich.de>
References: <20260630140623.88431-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[simonwunderlich.de,none];
	R_DKIM_ALLOW(-0.20)[simonwunderlich.de:s=09092022];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-303226-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:b.a.t.m.a.n@lists.open-mesh.org,m:sven@narfation.org,m:sw@simonwunderlich.de,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[simonwunderlich.de:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[simonwunderlich.de:dkim,simonwunderlich.de:email,simonwunderlich.de:mid,simonwunderlich.de:from_mime,vger.kernel.org:from_smtp,narfation.org:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5414E6E541F

From: Sven Eckelmann <sven@narfation.org>

There is no need to share the unacked list between sender and receivers.
Only receivers will ever write to and read from it. The initialization in
batadv_tp_start() was therefore never needed. After its removal, it is
enough to just store it in struct batadv_tp_receiver.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/tp_meter.c | 110 +++++++++++++++++++++-----------------
 net/batman-adv/types.h    |  20 +++----
 2 files changed, 71 insertions(+), 59 deletions(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 5cc719c81ea0b..f18ce360839d3 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -358,28 +358,16 @@ batadv_tp_list_find_sender_session(struct batadv_priv *bat_priv, const u8 *dst,
 }
 
 /**
- * batadv_tp_vars_common_release() - release batadv_tp_vars_common from lists
+ * batadv_tp_sender_release() - release batadv_tp_sender
  *  and queue for free after rcu grace period
- * @ref: kref pointer of the batadv_tp_vars_common
+ * @ref: kref pointer of the batadv_tp_sender
  */
-static void batadv_tp_vars_common_release(struct kref *ref)
+static void batadv_tp_sender_release(struct kref *ref)
 {
-	struct batadv_tp_vars_common *tp_vars;
-	struct batadv_tp_unacked *un, *safe;
-
-	tp_vars = container_of(ref, struct batadv_tp_vars_common, refcount);
-
-	/* lock should not be needed because this object is now out of any
-	 * context!
-	 */
-	spin_lock_bh(&tp_vars->unacked_lock);
-	list_for_each_entry_safe(un, safe, &tp_vars->unacked_list, list) {
-		list_del(&un->list);
-		kfree(un);
-	}
-	spin_unlock_bh(&tp_vars->unacked_lock);
+	struct batadv_tp_sender *tp_vars;
 
-	kfree_rcu(tp_vars, rcu);
+	tp_vars = container_of(ref, struct batadv_tp_sender, common.refcount);
+	kfree_rcu(tp_vars, common.rcu);
 }
 
 /**
@@ -392,7 +380,7 @@ static void batadv_tp_sender_put(struct batadv_tp_sender *tp_vars)
 	if (!tp_vars)
 		return;
 
-	kref_put(&tp_vars->common.refcount, batadv_tp_vars_common_release);
+	kref_put(&tp_vars->common.refcount, batadv_tp_sender_release);
 }
 
 /**
@@ -1145,9 +1133,6 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 	init_waitqueue_head(&tp_vars->more_bytes);
 	init_completion(&tp_vars->finished);
 
-	spin_lock_init(&tp_vars->common.unacked_lock);
-	INIT_LIST_HEAD(&tp_vars->common.unacked_list);
-
 	spin_lock_init(&tp_vars->cc_lock);
 
 	tp_vars->prerandom_offset = 0;
@@ -1251,6 +1236,33 @@ batadv_tp_list_find_receiver_session(struct batadv_priv *bat_priv, const u8 *dst
 	return tp_vars;
 }
 
+/**
+ * batadv_tp_receiver_release() - release batadv_tp_receiver
+ *  and queue for free after rcu grace period
+ * @ref: kref pointer of the batadv_tp_receiver
+ */
+static void batadv_tp_receiver_release(struct kref *ref)
+{
+	struct batadv_tp_receiver *tp_vars;
+	struct batadv_tp_unacked *safe;
+	struct batadv_tp_unacked *un;
+
+	tp_vars = container_of(ref, struct batadv_tp_receiver, common.refcount);
+
+	/* lock should not be needed because this object is now out of any
+	 * context!
+	 */
+	spin_lock_bh(&tp_vars->unacked_lock);
+	list_for_each_entry_safe(un, safe, &tp_vars->unacked_list, list) {
+		list_del(&un->list);
+		kfree(un);
+		tp_vars->unacked_count--;
+	}
+	spin_unlock_bh(&tp_vars->unacked_lock);
+
+	kfree_rcu(tp_vars, common.rcu);
+}
+
 /**
  * batadv_tp_receiver_put() - decrement the batadv_tp_receiver
  *  refcounter and possibly release it
@@ -1261,7 +1273,7 @@ static void batadv_tp_receiver_put(struct batadv_tp_receiver *tp_vars)
 	if (!tp_vars)
 		return;
 
-	kref_put(&tp_vars->common.refcount, batadv_tp_vars_common_release);
+	kref_put(&tp_vars->common.refcount, batadv_tp_receiver_release);
 }
 
 /**
@@ -1304,13 +1316,13 @@ static void batadv_tp_receiver_shutdown(struct timer_list *t)
 	if (batadv_tp_list_detach(&tp_vars->common))
 		batadv_tp_receiver_put(tp_vars);
 
-	spin_lock_bh(&tp_vars->common.unacked_lock);
-	list_for_each_entry_safe(un, safe, &tp_vars->common.unacked_list, list) {
+	spin_lock_bh(&tp_vars->unacked_lock);
+	list_for_each_entry_safe(un, safe, &tp_vars->unacked_list, list) {
 		list_del(&un->list);
 		kfree(un);
-		tp_vars->common.unacked_count--;
+		tp_vars->unacked_count--;
 	}
-	spin_unlock_bh(&tp_vars->common.unacked_lock);
+	spin_unlock_bh(&tp_vars->unacked_lock);
 
 	/* drop reference of timer */
 	if (WARN_ON(atomic_xchg(&tp_vars->receiving, 0) != 1))
@@ -1403,7 +1415,7 @@ static int batadv_tp_send_ack(struct batadv_priv *bat_priv, const u8 *dst,
  */
 static bool batadv_tp_handle_out_of_order(struct batadv_tp_receiver *tp_vars,
 					  u32 seqno, u32 payload_len)
-	__must_hold(&tp_vars->common.unacked_lock)
+	__must_hold(&tp_vars->unacked_lock)
 {
 	struct batadv_tp_unacked *un, *new;
 	struct batadv_tp_unacked *safe;
@@ -1417,9 +1429,9 @@ static bool batadv_tp_handle_out_of_order(struct batadv_tp_receiver *tp_vars,
 	new->len = payload_len;
 
 	/* if the list is empty immediately attach this new object */
-	if (list_empty(&tp_vars->common.unacked_list)) {
-		list_add(&new->list, &tp_vars->common.unacked_list);
-		tp_vars->common.unacked_count++;
+	if (list_empty(&tp_vars->unacked_list)) {
+		list_add(&new->list, &tp_vars->unacked_list);
+		tp_vars->unacked_count++;
 		return true;
 	}
 
@@ -1430,7 +1442,7 @@ static bool batadv_tp_handle_out_of_order(struct batadv_tp_receiver *tp_vars,
 	 * the last received packet (the one being processed now) has a bigger
 	 * seqno than all the others already stored.
 	 */
-	list_for_each_entry_reverse(un, &tp_vars->common.unacked_list, list) {
+	list_for_each_entry_reverse(un, &tp_vars->unacked_list, list) {
 		/* look for the right position - an un which is smaller */
 		if (batadv_seq_before(new->seqno, un->seqno))
 			continue;
@@ -1476,19 +1488,19 @@ static bool batadv_tp_handle_out_of_order(struct batadv_tp_receiver *tp_vars,
 		 */
 		list_add(&new->list, &un->list);
 		added = true;
-		tp_vars->common.unacked_count++;
+		tp_vars->unacked_count++;
 		break;
 	}
 
 	/* received packet with smallest seqno out of order; add it to front */
 	if (!added) {
-		list_add(&new->list, &tp_vars->common.unacked_list);
-		tp_vars->common.unacked_count++;
+		list_add(&new->list, &tp_vars->unacked_list);
+		tp_vars->unacked_count++;
 	}
 
 	/* check if new filled the gap to the next list entries */
 	un = new;
-	list_for_each_entry_safe_continue(un, safe, &tp_vars->common.unacked_list, list) {
+	list_for_each_entry_safe_continue(un, safe, &tp_vars->unacked_list, list) {
 		if (batadv_seq_before(new->seqno + new->len, un->seqno))
 			break;
 
@@ -1499,16 +1511,16 @@ static bool batadv_tp_handle_out_of_order(struct batadv_tp_receiver *tp_vars,
 
 		list_del(&un->list);
 		kfree(un);
-		tp_vars->common.unacked_count--;
+		tp_vars->unacked_count--;
 	}
 
 	/* remove the last (biggest) unacked seqno when list is too large */
-	if (tp_vars->common.unacked_count > BATADV_TP_MAX_UNACKED) {
-		un = list_last_entry(&tp_vars->common.unacked_list,
+	if (tp_vars->unacked_count > BATADV_TP_MAX_UNACKED) {
+		un = list_last_entry(&tp_vars->unacked_list,
 				     struct batadv_tp_unacked, list);
 		list_del(&un->list);
 		kfree(un);
-		tp_vars->common.unacked_count--;
+		tp_vars->unacked_count--;
 	}
 
 	return true;
@@ -1520,7 +1532,7 @@ static bool batadv_tp_handle_out_of_order(struct batadv_tp_receiver *tp_vars,
  * @tp_vars: the private data of the current TP meter session
  */
 static void batadv_tp_ack_unordered(struct batadv_tp_receiver *tp_vars)
-	__must_hold(&tp_vars->common.unacked_lock)
+	__must_hold(&tp_vars->unacked_lock)
 {
 	struct batadv_tp_unacked *un, *safe;
 	u32 to_ack;
@@ -1528,7 +1540,7 @@ static void batadv_tp_ack_unordered(struct batadv_tp_receiver *tp_vars)
 	/* go through the unacked packet list and possibly ACK them as
 	 * well
 	 */
-	list_for_each_entry_safe(un, safe, &tp_vars->common.unacked_list, list) {
+	list_for_each_entry_safe(un, safe, &tp_vars->unacked_list, list) {
 		/* the list is ordered, therefore it is possible to stop as soon
 		 * there is a gap between the last acked seqno and the seqno of
 		 * the packet under inspection
@@ -1543,7 +1555,7 @@ static void batadv_tp_ack_unordered(struct batadv_tp_receiver *tp_vars)
 
 		list_del(&un->list);
 		kfree(un);
-		tp_vars->common.unacked_count--;
+		tp_vars->unacked_count--;
 	}
 }
 
@@ -1590,9 +1602,9 @@ batadv_tp_init_recv(struct batadv_priv *bat_priv,
 	tp_vars->common.bat_priv = bat_priv;
 	kref_init(&tp_vars->common.refcount);
 
-	spin_lock_init(&tp_vars->common.unacked_lock);
-	INIT_LIST_HEAD(&tp_vars->common.unacked_list);
-	tp_vars->common.unacked_count = 0;
+	spin_lock_init(&tp_vars->unacked_lock);
+	INIT_LIST_HEAD(&tp_vars->unacked_list);
+	tp_vars->unacked_count = 0;
 
 	kref_get(&tp_vars->common.refcount);
 	timer_setup(&tp_vars->common.timer, batadv_tp_receiver_shutdown, 0);
@@ -1652,7 +1664,7 @@ static void batadv_tp_recv_msg(struct batadv_priv *bat_priv,
 		WRITE_ONCE(tp_vars->last_recv_time, jiffies);
 	}
 
-	spin_lock_bh(&tp_vars->common.unacked_lock);
+	spin_lock_bh(&tp_vars->unacked_lock);
 
 	/* if the packet is a duplicate, it may be the case that an ACK has been
 	 * lost. Resend the ACK
@@ -1668,7 +1680,7 @@ static void batadv_tp_recv_msg(struct batadv_priv *bat_priv,
 		 * not been enqueued correctly
 		 */
 		if (!batadv_tp_handle_out_of_order(tp_vars, seqno, payload_len)) {
-			spin_unlock_bh(&tp_vars->common.unacked_lock);
+			spin_unlock_bh(&tp_vars->unacked_lock);
 			goto out;
 		}
 
@@ -1684,7 +1696,7 @@ static void batadv_tp_recv_msg(struct batadv_priv *bat_priv,
 
 send_ack:
 	to_ack = tp_vars->last_recv;
-	spin_unlock_bh(&tp_vars->common.unacked_lock);
+	spin_unlock_bh(&tp_vars->unacked_lock);
 
 	/* send the ACK. If the received packet was out of order, the ACK that
 	 * is going to be sent is a duplicate (the sender will count them and
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index c2ab00d8ef160..c194d8069774c 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1334,7 +1334,7 @@ struct batadv_tp_unacked {
 	/** @len: length of the packet */
 	u32 len;
 
-	/** @list: list node for &batadv_tp_vars_common.unacked_list */
+	/** @list: list node for &batadv_tp_receiver.unacked_list */
 	struct list_head list;
 };
 
@@ -1357,15 +1357,6 @@ struct batadv_tp_vars_common {
 	/** @session: TP session identifier */
 	u8 session[2];
 
-	/** @unacked_list: list of unacked packets (meta-info only) */
-	struct list_head unacked_list;
-
-	/** @unacked_lock: protect unacked_list + &batadv_tp_receiver.last_recv */
-	spinlock_t unacked_lock;
-
-	/** @unacked_count: number of unacked entries */
-	size_t unacked_count;
-
 	/** @refcount: number of context where the object is used */
 	struct kref refcount;
 
@@ -1479,6 +1470,15 @@ struct batadv_tp_receiver {
 
 	/** @last_recv_time: time (jiffies) a msg was received */
 	unsigned long last_recv_time;
+
+	/** @unacked_list: list of unacked packets (meta-info only) */
+	struct list_head unacked_list;
+
+	/** @unacked_lock: protect unacked_list + &batadv_tp_receiver.last_recv */
+	spinlock_t unacked_lock;
+
+	/** @unacked_count: number of unacked entries */
+	size_t unacked_count;
 };
 
 /**
-- 
2.47.3


