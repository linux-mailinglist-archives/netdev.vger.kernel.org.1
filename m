Return-Path: <netdev+bounces-294627-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xJ8SMH7ZH2pDrAAAu9opvQ
	(envelope-from <netdev+bounces-294627-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 09:36:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 377CF63545E
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 09:36:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b="WysRCuE/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294627-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294627-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C43031102AC
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 07:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9E540242B;
	Wed,  3 Jun 2026 07:25:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DDC3FC5D0
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 07:25:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780471545; cv=none; b=BygVLbIii3EcMAbkD9+9bAJrf1dtAx2tYLFmykGA/AwGLrHn4BZ+rIJm8USlb/Hcyth/nLkxoGaju7CJxO0WKv73ELQj7hkgc4y6dDHjU4oPqUXeO5K8vroxMexKvQltbi+KBQKCuYQlik80/C/D0EynB2ipBQkfEsqIVp7lKs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780471545; c=relaxed/simple;
	bh=wzQqp536YLXmXHByEZ8bL/H/3kS5swylBq6J3leSXeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e/YJYHTuD4N1zGp6AWxc7TTg+BX38az+eY+VhsxErsXGMP71Uav1cP/VwPn1YHEOUMs1kpmLMEZnanKp7Qt3g18/Sr4OJOGUrCdHXJ0gowvwueaIohO4neAP/Rz2Jo8hKiAfVdMgIvHJRZ5/PSOFzHDeql2uU1QITYikeNipHL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=WysRCuE/; arc=none smtp.client-ip=23.88.38.48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1780471535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XDd7iBstPFrzoDlXNApVcDGptfPPpzKcrhVE7m5a8xs=;
	b=WysRCuE/lCuSCZDet6wr0wScaZim41P9zlyTLbQXOsaGwUImeIvwS4CgqmOzfn8otpbKxo
	6xqnA3dXGdOb6WHLFJ2L+WLFKCprewCHGxFE+l71NJr9rcdCr0DnCvJVmRWK0pQJ4w39od
	vMSTsJX+9XE6oJe3pcnG9E72uvD9mu5sbqzjfwyeX+tp6s6MY6I69ytiL6e+cD4yWJFWJt
	ABitpg5y2ysloi8+P6j8z/Hl73CWTNxlgs6+LXFXuxaVPAXYKR8TkJToZ4a8GCPrnW5c4H
	mhcWxpBdi1TDqZbvibmjZE8Jzw/dbh6DEkD+htpz3480UZT1kfNogOz7OaBDng==
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
Subject: [PATCH net-next 09/15] batman-adv: tp_meter: split vars into sender and receiver types
Date: Wed,  3 Jun 2026 09:25:20 +0200
Message-ID: <20260603072527.174487-10-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260603072527.174487-1-sw@simonwunderlich.de>
References: <20260603072527.174487-1-sw@simonwunderlich.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-294627-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:b.a.t.m.a.n@lists.open-mesh.org,m:sven@narfation.org,m:sw@simonwunderlich.de,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[narfation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,simonwunderlich.de:mid,simonwunderlich.de:dkim,simonwunderlich.de:from_mime,simonwunderlich.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 377CF63545E

From: Sven Eckelmann <sven@narfation.org>

The monolithic batadv_tp_vars struct holds fields for both sender and
receiver roles, distinguished only by a runtime enum role. This makes it
easy to accidentally access a field intended for the opposite role, since
neither the compiler nor the type system provide any guard against such
mistakes. The role check also adds unnecessary branching in several code
paths.

Introduce batadv_tp_vars_common to hold fields shared across both roles,
then derive two separate types (sender/receiver) from it. The functions can
operate on them without any ambiguity about the available fields. This also
reduces the memory footprint of receiver sessions, which no longer carry
the substantial sender-only fields.

Care must be taken to prevent concurrent TP sessions between the same two
peers in opposite directions, since sender and receiver sessions are now
tracked in separate lists and a lookup in one list no longer detects a
session in the other.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/main.c     |   3 +-
 net/batman-adv/tp_meter.c | 396 ++++++++++++++++++++++----------------
 net/batman-adv/types.h    | 101 +++++-----
 3 files changed, 281 insertions(+), 219 deletions(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 60d4f60066c80..3c4572284b532 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -194,7 +194,8 @@ int batadv_mesh_init(struct net_device *mesh_iface)
 	INIT_HLIST_HEAD(&bat_priv->tvlv.container_list);
 	INIT_HLIST_HEAD(&bat_priv->tvlv.handler_list);
 	INIT_HLIST_HEAD(&bat_priv->meshif_vlan_list);
-	INIT_HLIST_HEAD(&bat_priv->tp_list);
+	INIT_HLIST_HEAD(&bat_priv->tp_sender_list);
+	INIT_HLIST_HEAD(&bat_priv->tp_receiver_list);
 
 	bat_priv->gw.generation = 0;
 
diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 5498cdc972e98..c088d88804533 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -142,7 +142,7 @@ static u32 batadv_tp_cwnd(u32 base, u32 increment, u32 min)
  * 2) if the session is in Congestion Avoidance, the CWND has to be
  * increased by MSS * MSS / CWND for every unique received ACK
  */
-static void batadv_tp_update_cwnd(struct batadv_tp_vars *tp_vars, u32 mss)
+static void batadv_tp_update_cwnd(struct batadv_tp_sender *tp_vars, u32 mss)
 {
 	spin_lock_bh(&tp_vars->cwnd_lock);
 
@@ -176,7 +176,7 @@ static void batadv_tp_update_cwnd(struct batadv_tp_vars *tp_vars, u32 mss)
  * @tp_vars: the private data of the current TP meter session
  * @new_rtt: new roundtrip time in msec
  */
-static void batadv_tp_update_rto(struct batadv_tp_vars *tp_vars,
+static void batadv_tp_update_rto(struct batadv_tp_sender *tp_vars,
 				 u32 new_rtt)
 {
 	long m = new_rtt;
@@ -255,35 +255,30 @@ static void batadv_tp_batctl_error_notify(enum batadv_tp_meter_reason reason,
 }
 
 /**
- * batadv_tp_list_find() - find a tp_vars object in the global list
+ * batadv_tp_list_find_sender() - find a sender tp_vars object in the global list
  * @bat_priv: the bat priv with all the mesh interface information
  * @dst: the other endpoint MAC address to look for
- * @role: role of the session
  *
  * Look for a tp_vars object matching dst as end_point and return it after
  * having increment the refcounter. Return NULL is not found
  *
  * Return: matching tp_vars or NULL when no tp_vars with @dst was found
  */
-static struct batadv_tp_vars *batadv_tp_list_find(struct batadv_priv *bat_priv,
-						  const u8 *dst,
-						  enum batadv_tp_meter_role role)
+static struct batadv_tp_sender *
+batadv_tp_list_find_sender(struct batadv_priv *bat_priv, const u8 *dst)
 {
-	struct batadv_tp_vars *pos, *tp_vars = NULL;
+	struct batadv_tp_sender *pos, *tp_vars = NULL;
 
 	rcu_read_lock();
-	hlist_for_each_entry_rcu(pos, &bat_priv->tp_list, list) {
-		if (!batadv_compare_eth(pos->other_end, dst))
-			continue;
-
-		if (pos->role != role)
+	hlist_for_each_entry_rcu(pos, &bat_priv->tp_sender_list, common.list) {
+		if (!batadv_compare_eth(pos->common.other_end, dst))
 			continue;
 
 		/* most of the time this function is invoked during the normal
 		 * process..it makes sens to pay more when the session is
 		 * finished and to speed the process up during the measurement
 		 */
-		if (unlikely(!kref_get_unless_zero(&pos->refcount)))
+		if (unlikely(!kref_get_unless_zero(&pos->common.refcount)))
 			continue;
 
 		tp_vars = pos;
@@ -304,10 +299,16 @@ static struct batadv_tp_vars *batadv_tp_list_find(struct batadv_priv *bat_priv,
 static bool batadv_tp_list_active(struct batadv_priv *bat_priv, const u8 *dst)
 	__must_hold(&bat_priv->tp_list_lock)
 {
-	struct batadv_tp_vars *tp_vars;
+	struct batadv_tp_receiver *tp_receiver;
+	struct batadv_tp_sender *tp_sender;
+
+	hlist_for_each_entry_rcu(tp_sender, &bat_priv->tp_sender_list, common.list) {
+		if (batadv_compare_eth(tp_sender->common.other_end, dst))
+			return true;
+	}
 
-	hlist_for_each_entry_rcu(tp_vars, &bat_priv->tp_list, list) {
-		if (batadv_compare_eth(tp_vars->other_end, dst))
+	hlist_for_each_entry_rcu(tp_receiver, &bat_priv->tp_receiver_list, common.list) {
+		if (batadv_compare_eth(tp_receiver->common.other_end, dst))
 			return true;
 	}
 
@@ -315,12 +316,11 @@ static bool batadv_tp_list_active(struct batadv_priv *bat_priv, const u8 *dst)
 }
 
 /**
- * batadv_tp_list_find_session() - find tp_vars session object in the global
- *  list
+ * batadv_tp_list_find_sender_session() - find tp_vars sender session
+ *  object in the global list
  * @bat_priv: the bat priv with all the mesh interface information
  * @dst: the other endpoint MAC address to look for
  * @session: session identifier
- * @role: role of the session
  *
  * Look for a tp_vars object matching dst as end_point, session as tp meter
  * session and return it after having increment the refcounter. Return NULL
@@ -328,28 +328,25 @@ static bool batadv_tp_list_active(struct batadv_priv *bat_priv, const u8 *dst)
  *
  * Return: matching tp_vars or NULL when no tp_vars was found
  */
-static struct batadv_tp_vars *
-batadv_tp_list_find_session(struct batadv_priv *bat_priv, const u8 *dst,
-			    const u8 *session, enum batadv_tp_meter_role role)
+static struct batadv_tp_sender *
+batadv_tp_list_find_sender_session(struct batadv_priv *bat_priv, const u8 *dst,
+				   const u8 *session)
 {
-	struct batadv_tp_vars *pos, *tp_vars = NULL;
+	struct batadv_tp_sender *pos, *tp_vars = NULL;
 
 	rcu_read_lock();
-	hlist_for_each_entry_rcu(pos, &bat_priv->tp_list, list) {
-		if (!batadv_compare_eth(pos->other_end, dst))
+	hlist_for_each_entry_rcu(pos, &bat_priv->tp_sender_list, common.list) {
+		if (!batadv_compare_eth(pos->common.other_end, dst))
 			continue;
 
-		if (memcmp(pos->session, session, sizeof(pos->session)) != 0)
-			continue;
-
-		if (pos->role != role)
+		if (memcmp(pos->common.session, session, sizeof(pos->common.session)) != 0)
 			continue;
 
 		/* most of the time this function is invoked during the normal
 		 * process..it makes sense to pay more when the session is
 		 * finished and to speed the process up during the measurement
 		 */
-		if (unlikely(!kref_get_unless_zero(&pos->refcount)))
+		if (unlikely(!kref_get_unless_zero(&pos->common.refcount)))
 			continue;
 
 		tp_vars = pos;
@@ -361,16 +358,16 @@ batadv_tp_list_find_session(struct batadv_priv *bat_priv, const u8 *dst,
 }
 
 /**
- * batadv_tp_vars_release() - release batadv_tp_vars from lists and queue for
- *  free after rcu grace period
+ * batadv_tp_vars_common_release() - release batadv_tp_vars_common from lists
+ *  and queue for free after rcu grace period
  * @ref: kref pointer of the batadv_tp_vars
  */
-static void batadv_tp_vars_release(struct kref *ref)
+static void batadv_tp_vars_common_release(struct kref *ref)
 {
-	struct batadv_tp_vars *tp_vars;
+	struct batadv_tp_vars_common *tp_vars;
 	struct batadv_tp_unacked *un, *safe;
 
-	tp_vars = container_of(ref, struct batadv_tp_vars, refcount);
+	tp_vars = container_of(ref, struct batadv_tp_vars_common, refcount);
 
 	/* lock should not be needed because this object is now out of any
 	 * context!
@@ -386,23 +383,25 @@ static void batadv_tp_vars_release(struct kref *ref)
 }
 
 /**
- * batadv_tp_vars_put() - decrement the batadv_tp_vars refcounter and possibly
- *  release it
+ * batadv_tp_sender_put() - decrement the batadv_tp_sender
+ *  refcounter and possibly release it
  * @tp_vars: the private data of the current TP meter session to be free'd
  */
-static void batadv_tp_vars_put(struct batadv_tp_vars *tp_vars)
+static void batadv_tp_sender_put(struct batadv_tp_sender *tp_vars)
 {
 	if (!tp_vars)
 		return;
 
-	kref_put(&tp_vars->refcount, batadv_tp_vars_release);
+	kref_put(&tp_vars->common.refcount, batadv_tp_vars_common_release);
 }
 
 /**
- * batadv_tp_list_detach() - remove tp session from mesh session list once
+ * batadv_tp_list_detach() - remove tp receiver session from mesh session list once
  * @tp_vars: the private data of the current TP meter session
+ *
+ * Return: whether tp_vars was detached from list and reference must be freed
  */
-static void batadv_tp_list_detach(struct batadv_tp_vars *tp_vars)
+static bool batadv_tp_list_detach(struct batadv_tp_vars_common *tp_vars)
 {
 	bool detached = false;
 
@@ -414,27 +413,27 @@ static void batadv_tp_list_detach(struct batadv_tp_vars *tp_vars)
 	spin_unlock_bh(&tp_vars->bat_priv->tp_list_lock);
 
 	if (!detached)
-		return;
+		return false;
 
 	atomic_dec(&tp_vars->bat_priv->tp_num);
 
-	/* drop list reference */
-	batadv_tp_vars_put(tp_vars);
+	return true;
 }
 
 /**
  * batadv_tp_sender_cleanup() - cleanup sender data and drop and timer
  * @tp_vars: the private data of the current TP meter session to cleanup
  */
-static void batadv_tp_sender_cleanup(struct batadv_tp_vars *tp_vars)
+static void batadv_tp_sender_cleanup(struct batadv_tp_sender *tp_vars)
 {
 	cancel_delayed_work_sync(&tp_vars->finish_work);
 
-	batadv_tp_list_detach(tp_vars);
+	if (batadv_tp_list_detach(&tp_vars->common))
+		batadv_tp_sender_put(tp_vars);
 
 	/* kill the timer and remove its reference */
-	timer_shutdown_sync(&tp_vars->timer);
-	batadv_tp_vars_put(tp_vars);
+	timer_shutdown_sync(&tp_vars->common.timer);
+	batadv_tp_sender_put(tp_vars);
 }
 
 /**
@@ -443,7 +442,7 @@ static void batadv_tp_sender_cleanup(struct batadv_tp_vars *tp_vars)
  * @tp_vars: the private data of the current TP meter session
  */
 static void batadv_tp_sender_end(struct batadv_priv *bat_priv,
-				 struct batadv_tp_vars *tp_vars)
+				 struct batadv_tp_sender *tp_vars)
 {
 	enum batadv_tp_meter_reason reason;
 	u32 session_cookie;
@@ -452,7 +451,7 @@ static void batadv_tp_sender_end(struct batadv_priv *bat_priv,
 
 	batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
 		   "Test towards %pM finished..shutting down (reason=%d)\n",
-		   tp_vars->other_end, reason);
+		   tp_vars->common.other_end, reason);
 
 	batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
 		   "Last timing stats: SRTT=%ums RTTVAR=%ums RTO=%ums\n",
@@ -462,11 +461,11 @@ static void batadv_tp_sender_end(struct batadv_priv *bat_priv,
 		   "Final values: cwnd=%u ss_threshold=%u\n",
 		   tp_vars->cwnd, tp_vars->ss_threshold);
 
-	session_cookie = batadv_tp_session_cookie(tp_vars->session,
+	session_cookie = batadv_tp_session_cookie(tp_vars->common.session,
 						  tp_vars->icmp_uid);
 
 	batadv_tp_batctl_notify(reason,
-				tp_vars->other_end,
+				tp_vars->common.other_end,
 				bat_priv,
 				tp_vars->start_time,
 				atomic64_read(&tp_vars->tot_sent),
@@ -478,7 +477,7 @@ static void batadv_tp_sender_end(struct batadv_priv *bat_priv,
  * @tp_vars: the private data of the current TP meter session
  * @reason: reason for tp meter session stop
  */
-static void batadv_tp_sender_shutdown(struct batadv_tp_vars *tp_vars,
+static void batadv_tp_sender_shutdown(struct batadv_tp_sender *tp_vars,
 				      enum batadv_tp_meter_reason reason)
 {
 	atomic_cmpxchg(&tp_vars->send_result, 0, reason);
@@ -490,7 +489,7 @@ static void batadv_tp_sender_shutdown(struct batadv_tp_vars *tp_vars,
  *
  * Return: whether stop reason was found
  */
-static bool batadv_tp_sender_stopped(struct batadv_tp_vars *tp_vars)
+static bool batadv_tp_sender_stopped(struct batadv_tp_sender *tp_vars)
 {
 	return atomic_read(&tp_vars->send_result) != 0;
 }
@@ -502,10 +501,10 @@ static bool batadv_tp_sender_stopped(struct batadv_tp_vars *tp_vars)
 static void batadv_tp_sender_finish(struct work_struct *work)
 {
 	struct delayed_work *delayed_work;
-	struct batadv_tp_vars *tp_vars;
+	struct batadv_tp_sender *tp_vars;
 
 	delayed_work = to_delayed_work(work);
-	tp_vars = container_of(delayed_work, struct batadv_tp_vars,
+	tp_vars = container_of(delayed_work, struct batadv_tp_sender,
 			       finish_work);
 
 	batadv_tp_sender_shutdown(tp_vars, BATADV_TP_REASON_COMPLETE);
@@ -517,7 +516,7 @@ static void batadv_tp_sender_finish(struct work_struct *work)
  *
  * Reschedule the timer using tp_vars->rto as delay
  */
-static void batadv_tp_reset_sender_timer(struct batadv_tp_vars *tp_vars)
+static void batadv_tp_reset_sender_timer(struct batadv_tp_sender *tp_vars)
 {
 	/* most of the time this function is invoked while normal packet
 	 * reception...
@@ -526,7 +525,7 @@ static void batadv_tp_reset_sender_timer(struct batadv_tp_vars *tp_vars)
 		/* timer ref will be dropped in batadv_tp_sender_cleanup */
 		return;
 
-	mod_timer(&tp_vars->timer, jiffies + msecs_to_jiffies(tp_vars->rto));
+	mod_timer(&tp_vars->common.timer, jiffies + msecs_to_jiffies(tp_vars->rto));
 }
 
 /**
@@ -539,8 +538,8 @@ static void batadv_tp_reset_sender_timer(struct batadv_tp_vars *tp_vars)
  */
 static void batadv_tp_sender_timeout(struct timer_list *t)
 {
-	struct batadv_tp_vars *tp_vars = timer_container_of(tp_vars, t, timer);
-	struct batadv_priv *bat_priv = tp_vars->bat_priv;
+	struct batadv_tp_sender *tp_vars = timer_container_of(tp_vars, t, common.timer);
+	struct batadv_priv *bat_priv = tp_vars->common.bat_priv;
 
 	if (batadv_tp_sender_stopped(tp_vars))
 		return;
@@ -565,7 +564,7 @@ static void batadv_tp_sender_timeout(struct timer_list *t)
 
 	batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
 		   "Meter: RTO fired during test towards %pM! cwnd=%u new ss_thr=%u, resetting last_sent to %u\n",
-		   tp_vars->other_end, tp_vars->cwnd, tp_vars->ss_threshold,
+		   tp_vars->common.other_end, tp_vars->cwnd, tp_vars->ss_threshold,
 		   atomic_read(&tp_vars->last_acked));
 
 	tp_vars->cwnd = BATADV_TP_PLEN * 3;
@@ -585,7 +584,7 @@ static void batadv_tp_sender_timeout(struct timer_list *t)
  * @buf: Buffer to fill with bytes
  * @nbytes: amount of pseudorandom bytes
  */
-static void batadv_tp_fill_prerandom(struct batadv_tp_vars *tp_vars,
+static void batadv_tp_fill_prerandom(struct batadv_tp_sender *tp_vars,
 				     u8 *buf, size_t nbytes)
 {
 	u32 local_offset;
@@ -628,7 +627,7 @@ static void batadv_tp_fill_prerandom(struct batadv_tp_vars *tp_vars,
  * not reachable, BATADV_TP_REASON_MEMORY_ERROR if the packet couldn't be
  * allocated
  */
-static int batadv_tp_send_msg(struct batadv_tp_vars *tp_vars, const u8 *src,
+static int batadv_tp_send_msg(struct batadv_tp_sender *tp_vars, const u8 *src,
 			      struct batadv_orig_node *orig_node,
 			      u32 seqno, size_t len, const u8 *session,
 			      int uid, u32 timestamp)
@@ -684,7 +683,7 @@ static void batadv_tp_recv_ack(struct batadv_priv *bat_priv,
 	struct batadv_hard_iface *primary_if = NULL;
 	struct batadv_orig_node *orig_node = NULL;
 	const struct batadv_icmp_tp_packet *icmp;
-	struct batadv_tp_vars *tp_vars;
+	struct batadv_tp_sender *tp_vars;
 	const unsigned char *dev_addr;
 	size_t packet_len, mss;
 	u32 rtt, recv_ack, cwnd;
@@ -696,8 +695,8 @@ static void batadv_tp_recv_ack(struct batadv_priv *bat_priv,
 	icmp = (struct batadv_icmp_tp_packet *)skb->data;
 
 	/* find the tp_vars */
-	tp_vars = batadv_tp_list_find_session(bat_priv, icmp->orig,
-					      icmp->session, BATADV_TP_SENDER);
+	tp_vars = batadv_tp_list_find_sender_session(bat_priv, icmp->orig,
+						     icmp->session);
 	if (unlikely(!tp_vars))
 		return;
 
@@ -807,7 +806,7 @@ static void batadv_tp_recv_ack(struct batadv_priv *bat_priv,
 out:
 	batadv_hardif_put(primary_if);
 	batadv_orig_node_put(orig_node);
-	batadv_tp_vars_put(tp_vars);
+	batadv_tp_sender_put(tp_vars);
 }
 
 /**
@@ -817,7 +816,7 @@ static void batadv_tp_recv_ack(struct batadv_priv *bat_priv,
  *
  * Return: true when congestion window is not full, false otherwise
  */
-static bool batadv_tp_avail(struct batadv_tp_vars *tp_vars,
+static bool batadv_tp_avail(struct batadv_tp_sender *tp_vars,
 			    size_t payload_len)
 {
 	u32 last_sent = READ_ONCE(tp_vars->last_sent);
@@ -844,7 +843,7 @@ static bool batadv_tp_avail(struct batadv_tp_vars *tp_vars,
  *  remaining jiffies (at least 1) if the condition evaluated to true before
  *  the timeout elapsed, or -ERESTARTSYS if it was interrupted by a signal.
  */
-static int batadv_tp_wait_available(struct batadv_tp_vars *tp_vars, size_t plen)
+static int batadv_tp_wait_available(struct batadv_tp_sender *tp_vars, size_t plen)
 {
 	int ret;
 
@@ -863,20 +862,14 @@ static int batadv_tp_wait_available(struct batadv_tp_vars *tp_vars, size_t plen)
  */
 static int batadv_tp_send(void *arg)
 {
-	struct batadv_tp_vars *tp_vars = arg;
-	struct batadv_priv *bat_priv = tp_vars->bat_priv;
+	struct batadv_tp_sender *tp_vars = arg;
+	struct batadv_priv *bat_priv = tp_vars->common.bat_priv;
 	struct batadv_hard_iface *primary_if = NULL;
 	struct batadv_orig_node *orig_node = NULL;
 	size_t payload_len, packet_len;
 	int err = 0;
 
-	if (unlikely(tp_vars->role != BATADV_TP_SENDER)) {
-		err = BATADV_TP_REASON_DST_UNREACHABLE;
-		batadv_tp_sender_shutdown(tp_vars, err);
-		goto out;
-	}
-
-	orig_node = batadv_orig_hash_find(bat_priv, tp_vars->other_end);
+	orig_node = batadv_orig_hash_find(bat_priv, tp_vars->common.other_end);
 	if (unlikely(!orig_node)) {
 		err = BATADV_TP_REASON_DST_UNREACHABLE;
 		batadv_tp_sender_shutdown(tp_vars, err);
@@ -919,7 +912,7 @@ static int batadv_tp_send(void *arg)
 		err = batadv_tp_send_msg(tp_vars, primary_if->net_dev->dev_addr,
 					 orig_node, tp_vars->last_sent,
 					 packet_len,
-					 tp_vars->session, tp_vars->icmp_uid,
+					 tp_vars->common.session, tp_vars->icmp_uid,
 					 jiffies_to_msecs(jiffies));
 
 		/* something went wrong during the preparation/transmission */
@@ -947,7 +940,7 @@ static int batadv_tp_send(void *arg)
 	batadv_tp_sender_cleanup(tp_vars);
 	complete(&tp_vars->finished);
 
-	batadv_tp_vars_put(tp_vars);
+	batadv_tp_sender_put(tp_vars);
 
 	return 0;
 }
@@ -957,24 +950,24 @@ static int batadv_tp_send(void *arg)
  *  sender
  * @tp_vars: the private data of the current TP meter session
  */
-static void batadv_tp_start_kthread(struct batadv_tp_vars *tp_vars)
+static void batadv_tp_start_kthread(struct batadv_tp_sender *tp_vars)
 {
 	struct task_struct *kthread;
-	struct batadv_priv *bat_priv = tp_vars->bat_priv;
+	struct batadv_priv *bat_priv = tp_vars->common.bat_priv;
 	u32 session_cookie;
 
-	kref_get(&tp_vars->refcount);
+	kref_get(&tp_vars->common.refcount);
 	kthread = kthread_create(batadv_tp_send, tp_vars, "kbatadv_tp_meter");
 	if (IS_ERR(kthread)) {
-		session_cookie = batadv_tp_session_cookie(tp_vars->session,
+		session_cookie = batadv_tp_session_cookie(tp_vars->common.session,
 							  tp_vars->icmp_uid);
 		pr_err("batadv: cannot create tp meter kthread\n");
 		batadv_tp_batctl_error_notify(BATADV_TP_REASON_MEMORY_ERROR,
-					      tp_vars->other_end,
+					      tp_vars->common.other_end,
 					      bat_priv, session_cookie);
 
 		/* drop reserved reference for kthread */
-		batadv_tp_vars_put(tp_vars);
+		batadv_tp_sender_put(tp_vars);
 
 		/* cleanup of failed tp meter variables */
 		batadv_tp_sender_cleanup(tp_vars);
@@ -995,7 +988,7 @@ static void batadv_tp_start_kthread(struct batadv_tp_vars *tp_vars)
 void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 		     u32 test_length, u32 *cookie)
 {
-	struct batadv_tp_vars *tp_vars;
+	struct batadv_tp_sender *tp_vars;
 	u8 session_id[2];
 	u8 icmp_uid;
 	u32 session_cookie;
@@ -1045,11 +1038,10 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 	}
 
 	/* initialize tp_vars */
-	ether_addr_copy(tp_vars->other_end, dst);
-	kref_init(&tp_vars->refcount);
-	tp_vars->role = BATADV_TP_SENDER;
+	ether_addr_copy(tp_vars->common.other_end, dst);
+	kref_init(&tp_vars->common.refcount);
 	atomic_set(&tp_vars->send_result, 0);
-	memcpy(tp_vars->session, session_id, sizeof(session_id));
+	memcpy(tp_vars->common.session, session_id, sizeof(session_id));
 	tp_vars->icmp_uid = icmp_uid;
 
 	tp_vars->last_sent = BATADV_TP_FIRST_SEQ;
@@ -1079,17 +1071,17 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 
 	atomic64_set(&tp_vars->tot_sent, 0);
 
-	kref_get(&tp_vars->refcount);
-	timer_setup(&tp_vars->timer, batadv_tp_sender_timeout, 0);
+	kref_get(&tp_vars->common.refcount);
+	timer_setup(&tp_vars->common.timer, batadv_tp_sender_timeout, 0);
 
-	tp_vars->bat_priv = bat_priv;
+	tp_vars->common.bat_priv = bat_priv;
 	tp_vars->start_time = jiffies;
 
 	init_waitqueue_head(&tp_vars->more_bytes);
 	init_completion(&tp_vars->finished);
 
-	spin_lock_init(&tp_vars->unacked_lock);
-	INIT_LIST_HEAD(&tp_vars->unacked_list);
+	spin_lock_init(&tp_vars->common.unacked_lock);
+	INIT_LIST_HEAD(&tp_vars->common.unacked_list);
 
 	spin_lock_init(&tp_vars->cwnd_lock);
 
@@ -1103,8 +1095,8 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 	/* init work item for finished tp tests */
 	INIT_DELAYED_WORK(&tp_vars->finish_work, batadv_tp_sender_finish);
 
-	kref_get(&tp_vars->refcount);
-	hlist_add_head_rcu(&tp_vars->list, &bat_priv->tp_list);
+	kref_get(&tp_vars->common.refcount);
+	hlist_add_head_rcu(&tp_vars->common.list, &bat_priv->tp_sender_list);
 	spin_unlock_bh(&bat_priv->tp_list_lock);
 
 	batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
@@ -1117,7 +1109,7 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 	batadv_tp_start_kthread(tp_vars);
 
 	/* don't return reference to new tp_vars */
-	batadv_tp_vars_put(tp_vars);
+	batadv_tp_sender_put(tp_vars);
 }
 
 /**
@@ -1130,7 +1122,7 @@ void batadv_tp_stop(struct batadv_priv *bat_priv, const u8 *dst,
 		    u8 return_value)
 {
 	struct batadv_orig_node *orig_node;
-	struct batadv_tp_vars *tp_vars;
+	struct batadv_tp_sender *tp_vars;
 
 	batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
 		   "Meter: stopping test towards %pM\n", dst);
@@ -1139,7 +1131,7 @@ void batadv_tp_stop(struct batadv_priv *bat_priv, const u8 *dst,
 	if (!orig_node)
 		return;
 
-	tp_vars = batadv_tp_list_find(bat_priv, orig_node->orig, BATADV_TP_SENDER);
+	tp_vars = batadv_tp_list_find_sender(bat_priv, orig_node->orig);
 	if (!tp_vars) {
 		batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
 			   "Meter: trying to interrupt an already over connection\n");
@@ -1147,20 +1139,75 @@ void batadv_tp_stop(struct batadv_priv *bat_priv, const u8 *dst,
 	}
 
 	batadv_tp_sender_shutdown(tp_vars, return_value);
-	batadv_tp_vars_put(tp_vars);
+	batadv_tp_sender_put(tp_vars);
 out_put_orig_node:
 	batadv_orig_node_put(orig_node);
 }
 
+/**
+ * batadv_tp_list_find_receiver_session() - find tp_vars receiver session
+ *  object in the global list
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @dst: the other endpoint MAC address to look for
+ * @session: session identifier
+ *
+ * Look for a tp_vars object matching dst as end_point, session as tp meter
+ * session and return it after having increment the refcounter. Return NULL
+ * is not found
+ *
+ * Return: matching tp_vars or NULL when no tp_vars was found
+ */
+static struct batadv_tp_receiver *
+batadv_tp_list_find_receiver_session(struct batadv_priv *bat_priv, const u8 *dst,
+				     const u8 *session)
+{
+	struct batadv_tp_receiver *pos, *tp_vars = NULL;
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(pos, &bat_priv->tp_receiver_list, common.list) {
+		if (!batadv_compare_eth(pos->common.other_end, dst))
+			continue;
+
+		if (memcmp(pos->common.session, session, sizeof(pos->common.session)) != 0)
+			continue;
+
+		/* most of the time this function is invoked during the normal
+		 * process..it makes sense to pay more when the session is
+		 * finished and to speed the process up during the measurement
+		 */
+		if (unlikely(!kref_get_unless_zero(&pos->common.refcount)))
+			continue;
+
+		tp_vars = pos;
+		break;
+	}
+	rcu_read_unlock();
+
+	return tp_vars;
+}
+
+/**
+ * batadv_tp_receiver_put() - decrement the batadv_tp_receiver
+ *  refcounter and possibly release it
+ * @tp_vars: the private data of the current TP meter session to be free'd
+ */
+static void batadv_tp_receiver_put(struct batadv_tp_receiver *tp_vars)
+{
+	if (!tp_vars)
+		return;
+
+	kref_put(&tp_vars->common.refcount, batadv_tp_vars_common_release);
+}
+
 /**
  * batadv_tp_reset_receiver_timer() - reset the receiver shutdown timer
  * @tp_vars: the private data of the current TP meter session
  *
  * start the receiver shutdown timer or reset it if already started
  */
-static void batadv_tp_reset_receiver_timer(struct batadv_tp_vars *tp_vars)
+static void batadv_tp_reset_receiver_timer(struct batadv_tp_receiver *tp_vars)
 {
-	mod_timer(&tp_vars->timer,
+	mod_timer(&tp_vars->common.timer,
 		  jiffies + msecs_to_jiffies(BATADV_TP_RECV_TIMEOUT));
 }
 
@@ -1171,11 +1218,11 @@ static void batadv_tp_reset_receiver_timer(struct batadv_tp_vars *tp_vars)
  */
 static void batadv_tp_receiver_shutdown(struct timer_list *t)
 {
-	struct batadv_tp_vars *tp_vars = timer_container_of(tp_vars, t, timer);
+	struct batadv_tp_receiver *tp_vars = timer_container_of(tp_vars, t, common.timer);
 	struct batadv_tp_unacked *un, *safe;
 	struct batadv_priv *bat_priv;
 
-	bat_priv = tp_vars->bat_priv;
+	bat_priv = tp_vars->common.bat_priv;
 
 	/* if there is recent activity rearm the timer */
 	if (!batadv_has_timed_out(tp_vars->last_recv_time,
@@ -1187,22 +1234,23 @@ static void batadv_tp_receiver_shutdown(struct timer_list *t)
 
 	batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
 		   "Shutting down for inactivity (more than %dms) from %pM\n",
-		   BATADV_TP_RECV_TIMEOUT, tp_vars->other_end);
+		   BATADV_TP_RECV_TIMEOUT, tp_vars->common.other_end);
 
-	batadv_tp_list_detach(tp_vars);
+	if (batadv_tp_list_detach(&tp_vars->common))
+		batadv_tp_receiver_put(tp_vars);
 
-	spin_lock_bh(&tp_vars->unacked_lock);
-	list_for_each_entry_safe(un, safe, &tp_vars->unacked_list, list) {
+	spin_lock_bh(&tp_vars->common.unacked_lock);
+	list_for_each_entry_safe(un, safe, &tp_vars->common.unacked_list, list) {
 		list_del(&un->list);
 		kfree(un);
 	}
-	spin_unlock_bh(&tp_vars->unacked_lock);
+	spin_unlock_bh(&tp_vars->common.unacked_lock);
 
 	/* drop reference of timer */
 	if (WARN_ON(atomic_xchg(&tp_vars->receiving, 0) != 1))
 		return;
 
-	batadv_tp_vars_put(tp_vars);
+	batadv_tp_receiver_put(tp_vars);
 }
 
 /**
@@ -1286,7 +1334,7 @@ static int batadv_tp_send_ack(struct batadv_priv *bat_priv, const u8 *dst,
  *
  * Return: true if the packed has been successfully processed, false otherwise
  */
-static bool batadv_tp_handle_out_of_order(struct batadv_tp_vars *tp_vars,
+static bool batadv_tp_handle_out_of_order(struct batadv_tp_receiver *tp_vars,
 					  const struct sk_buff *skb)
 {
 	const struct batadv_icmp_tp_packet *icmp;
@@ -1304,10 +1352,10 @@ static bool batadv_tp_handle_out_of_order(struct batadv_tp_vars *tp_vars,
 	payload_len = skb->len - sizeof(struct batadv_unicast_packet);
 	new->len = payload_len;
 
-	spin_lock_bh(&tp_vars->unacked_lock);
+	spin_lock_bh(&tp_vars->common.unacked_lock);
 	/* if the list is empty immediately attach this new object */
-	if (list_empty(&tp_vars->unacked_list)) {
-		list_add(&new->list, &tp_vars->unacked_list);
+	if (list_empty(&tp_vars->common.unacked_list)) {
+		list_add(&new->list, &tp_vars->common.unacked_list);
 		goto out;
 	}
 
@@ -1318,7 +1366,7 @@ static bool batadv_tp_handle_out_of_order(struct batadv_tp_vars *tp_vars,
 	 * the last received packet (the one being processed now) has a bigger
 	 * seqno than all the others already stored.
 	 */
-	list_for_each_entry_reverse(un, &tp_vars->unacked_list, list) {
+	list_for_each_entry_reverse(un, &tp_vars->common.unacked_list, list) {
 		/* check for duplicates */
 		if (new->seqno == un->seqno) {
 			if (new->len > un->len)
@@ -1343,10 +1391,10 @@ static bool batadv_tp_handle_out_of_order(struct batadv_tp_vars *tp_vars,
 
 	/* received packet with smallest seqno out of order; add it to front */
 	if (!added)
-		list_add(&new->list, &tp_vars->unacked_list);
+		list_add(&new->list, &tp_vars->common.unacked_list);
 
 out:
-	spin_unlock_bh(&tp_vars->unacked_lock);
+	spin_unlock_bh(&tp_vars->common.unacked_lock);
 
 	return true;
 }
@@ -1356,7 +1404,7 @@ static bool batadv_tp_handle_out_of_order(struct batadv_tp_vars *tp_vars,
  *  without gaps
  * @tp_vars: the private data of the current TP meter session
  */
-static void batadv_tp_ack_unordered(struct batadv_tp_vars *tp_vars)
+static void batadv_tp_ack_unordered(struct batadv_tp_receiver *tp_vars)
 {
 	struct batadv_tp_unacked *un, *safe;
 	u32 to_ack;
@@ -1364,8 +1412,8 @@ static void batadv_tp_ack_unordered(struct batadv_tp_vars *tp_vars)
 	/* go through the unacked packet list and possibly ACK them as
 	 * well
 	 */
-	spin_lock_bh(&tp_vars->unacked_lock);
-	list_for_each_entry_safe(un, safe, &tp_vars->unacked_list, list) {
+	spin_lock_bh(&tp_vars->common.unacked_lock);
+	list_for_each_entry_safe(un, safe, &tp_vars->common.unacked_list, list) {
 		/* the list is ordered, therefore it is possible to stop as soon
 		 * there is a gap between the last acked seqno and the seqno of
 		 * the packet under inspection
@@ -1381,7 +1429,7 @@ static void batadv_tp_ack_unordered(struct batadv_tp_vars *tp_vars)
 		list_del(&un->list);
 		kfree(un);
 	}
-	spin_unlock_bh(&tp_vars->unacked_lock);
+	spin_unlock_bh(&tp_vars->common.unacked_lock);
 }
 
 /**
@@ -1391,18 +1439,18 @@ static void batadv_tp_ack_unordered(struct batadv_tp_vars *tp_vars)
  *
  * Return: corresponding tp_vars or NULL on errors
  */
-static struct batadv_tp_vars *
+static struct batadv_tp_receiver *
 batadv_tp_init_recv(struct batadv_priv *bat_priv,
 		    const struct batadv_icmp_tp_packet *icmp)
 {
-	struct batadv_tp_vars *tp_vars = NULL;
+	struct batadv_tp_receiver *tp_vars = NULL;
 
 	spin_lock_bh(&bat_priv->tp_list_lock);
 	if (READ_ONCE(bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
 		goto out_unlock;
 
-	tp_vars = batadv_tp_list_find_session(bat_priv, icmp->orig,
-					      icmp->session, BATADV_TP_RECEIVER);
+	tp_vars = batadv_tp_list_find_receiver_session(bat_priv, icmp->orig,
+						       icmp->session);
 	if (tp_vars)
 		goto out_unlock;
 
@@ -1418,22 +1466,21 @@ batadv_tp_init_recv(struct batadv_priv *bat_priv,
 		goto out_unlock;
 	}
 
-	ether_addr_copy(tp_vars->other_end, icmp->orig);
-	tp_vars->role = BATADV_TP_RECEIVER;
+	ether_addr_copy(tp_vars->common.other_end, icmp->orig);
 	atomic_set(&tp_vars->receiving, 1);
-	memcpy(tp_vars->session, icmp->session, sizeof(tp_vars->session));
+	memcpy(tp_vars->common.session, icmp->session, sizeof(tp_vars->common.session));
 	tp_vars->last_recv = BATADV_TP_FIRST_SEQ;
-	tp_vars->bat_priv = bat_priv;
-	kref_init(&tp_vars->refcount);
+	tp_vars->common.bat_priv = bat_priv;
+	kref_init(&tp_vars->common.refcount);
 
-	spin_lock_init(&tp_vars->unacked_lock);
-	INIT_LIST_HEAD(&tp_vars->unacked_list);
+	spin_lock_init(&tp_vars->common.unacked_lock);
+	INIT_LIST_HEAD(&tp_vars->common.unacked_list);
 
-	kref_get(&tp_vars->refcount);
-	timer_setup(&tp_vars->timer, batadv_tp_receiver_shutdown, 0);
+	kref_get(&tp_vars->common.refcount);
+	timer_setup(&tp_vars->common.timer, batadv_tp_receiver_shutdown, 0);
 
-	kref_get(&tp_vars->refcount);
-	hlist_add_head_rcu(&tp_vars->list, &bat_priv->tp_list);
+	kref_get(&tp_vars->common.refcount);
+	hlist_add_head_rcu(&tp_vars->common.list, &bat_priv->tp_receiver_list);
 
 	batadv_tp_reset_receiver_timer(tp_vars);
 
@@ -1454,7 +1501,7 @@ static void batadv_tp_recv_msg(struct batadv_priv *bat_priv,
 			       const struct sk_buff *skb)
 {
 	const struct batadv_icmp_tp_packet *icmp;
-	struct batadv_tp_vars *tp_vars;
+	struct batadv_tp_receiver *tp_vars;
 	size_t packet_size;
 	u32 seqno;
 
@@ -1472,8 +1519,8 @@ static void batadv_tp_recv_msg(struct batadv_priv *bat_priv,
 			goto out;
 		}
 	} else {
-		tp_vars = batadv_tp_list_find_session(bat_priv, icmp->orig,
-						      icmp->session, BATADV_TP_RECEIVER);
+		tp_vars = batadv_tp_list_find_receiver_session(bat_priv, icmp->orig,
+							       icmp->session);
 		if (!tp_vars) {
 			batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
 				   "Unexpected packet from %pM!\n",
@@ -1517,7 +1564,7 @@ static void batadv_tp_recv_msg(struct batadv_priv *bat_priv,
 	batadv_tp_send_ack(bat_priv, icmp->orig, tp_vars->last_recv,
 			   icmp->timestamp, icmp->session, icmp->uid);
 out:
-	batadv_tp_vars_put(tp_vars);
+	batadv_tp_receiver_put(tp_vars);
 }
 
 /**
@@ -1557,45 +1604,58 @@ void batadv_tp_meter_recv(struct batadv_priv *bat_priv, struct sk_buff *skb)
  */
 void batadv_tp_stop_all(struct batadv_priv *bat_priv)
 {
-	struct batadv_tp_vars *tp_vars[BATADV_TP_MAX_NUM];
-	struct batadv_tp_vars *tp_var;
-	size_t count = 0;
+	struct batadv_tp_receiver *tp_receivers[BATADV_TP_MAX_NUM];
+	struct batadv_tp_sender *tp_senders[BATADV_TP_MAX_NUM];
+	struct batadv_tp_receiver *tp_receiver;
+	struct batadv_tp_sender *tp_sender;
+	size_t receiver_count = 0;
+	size_t sender_count = 0;
 	size_t i;
 
 	spin_lock_bh(&bat_priv->tp_list_lock);
-	hlist_for_each_entry(tp_var, &bat_priv->tp_list, list) {
-		if (WARN_ON_ONCE(count >= BATADV_TP_MAX_NUM))
+	hlist_for_each_entry(tp_receiver, &bat_priv->tp_receiver_list, common.list) {
+		if (WARN_ON_ONCE(receiver_count >= BATADV_TP_MAX_NUM))
 			break;
 
-		if (!kref_get_unless_zero(&tp_var->refcount))
+		if (!kref_get_unless_zero(&tp_receiver->common.refcount))
 			continue;
 
-		tp_vars[count++] = tp_var;
+		tp_receivers[receiver_count++] = tp_receiver;
+	}
+
+	hlist_for_each_entry(tp_sender, &bat_priv->tp_sender_list, common.list) {
+		if (WARN_ON_ONCE(sender_count >= BATADV_TP_MAX_NUM))
+			break;
+
+		if (!kref_get_unless_zero(&tp_sender->common.refcount))
+			continue;
+
+		tp_senders[sender_count++] = tp_sender;
 	}
 	spin_unlock_bh(&bat_priv->tp_list_lock);
 
-	for (i = 0; i < count; i++) {
-		tp_var = tp_vars[i];
+	for (i = 0; i < receiver_count; i++) {
+		tp_receiver = tp_receivers[i];
 
-		switch (tp_var->role) {
-		case BATADV_TP_SENDER:
-			batadv_tp_sender_shutdown(tp_var,
-						  BATADV_TP_REASON_CANCEL);
-			wake_up(&tp_var->more_bytes);
-			wait_for_completion(&tp_var->finished);
-			break;
-		case BATADV_TP_RECEIVER:
-			batadv_tp_list_detach(tp_var);
-			timer_shutdown_sync(&tp_var->timer);
+		if (batadv_tp_list_detach(&tp_receiver->common))
+			batadv_tp_receiver_put(tp_receiver);
 
-			if (atomic_xchg(&tp_var->receiving, 0) != 1)
-				break;
+		timer_shutdown_sync(&tp_receiver->common.timer);
 
-			batadv_tp_vars_put(tp_var);
-			break;
-		}
+		if (atomic_xchg(&tp_receiver->receiving, 0) != 0)
+			batadv_tp_receiver_put(tp_receiver);
+
+		batadv_tp_receiver_put(tp_receiver);
+	}
+
+	for (i = 0; i < sender_count; i++) {
+		tp_sender = tp_senders[i];
+
+		batadv_tp_sender_shutdown(tp_sender, BATADV_TP_REASON_CANCEL);
+		wake_up(&tp_sender->more_bytes);
+		wait_for_completion(&tp_sender->finished);
 
-		batadv_tp_vars_put(tp_var);
+		batadv_tp_sender_put(tp_sender);
 	}
 
 	synchronize_net();
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 19c7316889b6e..f7817a68a29ca 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1336,21 +1336,10 @@ struct batadv_tp_unacked {
 };
 
 /**
- * enum batadv_tp_meter_role - Modus in tp meter session
+ * struct batadv_tp_vars_common - common tp meter private variables per session
  */
-enum batadv_tp_meter_role {
-	/** @BATADV_TP_RECEIVER: Initialized as receiver */
-	BATADV_TP_RECEIVER,
-
-	/** @BATADV_TP_SENDER: Initialized as sender */
-	BATADV_TP_SENDER
-};
-
-/**
- * struct batadv_tp_vars - tp meter private variables per session
- */
-struct batadv_tp_vars {
-	/** @list: list node for &bat_priv.tp_list */
+struct batadv_tp_vars_common {
+	/** @list: list node for &bat_priv.tp_sender_list/&bat_priv.tp_receiver_list */
 	struct hlist_node list;
 
 	/** @timer: timer for ack (receiver) and retry (sender) */
@@ -1359,14 +1348,34 @@ struct batadv_tp_vars {
 	/** @bat_priv: pointer to the mesh object */
 	struct batadv_priv *bat_priv;
 
-	/** @start_time: start time in jiffies */
-	unsigned long start_time;
-
 	/** @other_end: mac address of remote */
 	u8 other_end[ETH_ALEN];
 
-	/** @role: receiver/sender modi */
-	enum batadv_tp_meter_role role;
+	/** @session: TP session identifier */
+	u8 session[2];
+
+	/** @unacked_list: list of unacked packets (meta-info only) */
+	struct list_head unacked_list;
+
+	/** @unacked_lock: protect unacked_list */
+	spinlock_t unacked_lock;
+
+	/** @refcount: number of context where the object is used */
+	struct kref refcount;
+
+	/** @rcu: struct used for freeing in an RCU-safe manner */
+	struct rcu_head rcu;
+};
+
+/**
+ * struct batadv_tp_sender - sender tp meter private variables per session
+ */
+struct batadv_tp_sender {
+	/** @common: common batadv_tp_vars (best be first member) */
+	struct batadv_tp_vars_common common;
+
+	/** @start_time: start time in jiffies */
+	unsigned long start_time;
 
 	/**
 	 * @send_result: 0 when sending is ongoing and otherwise
@@ -1374,8 +1383,14 @@ struct batadv_tp_vars {
 	 */
 	atomic_t send_result;
 
-	/** @receiving: receiving binary semaphore: 1 if receiving, 0 is not */
-	atomic_t receiving;
+	/** @last_sent: last sent byte, not yet acked */
+	u32 last_sent;
+
+	/** @fast_recovery: true if in Fast Recovery mode */
+	unsigned char fast_recovery:1;
+
+	/** @recover: last sent seqno when entering Fast Recovery */
+	u32 recover;
 
 	/** @finish_work: work item for the finishing procedure */
 	struct delayed_work finish_work;
@@ -1386,14 +1401,9 @@ struct batadv_tp_vars {
 	/** @test_length: test length in milliseconds */
 	u32 test_length;
 
-	/** @session: TP session identifier */
-	u8 session[2];
-
 	/** @icmp_uid: local ICMP "socket" index */
 	u8 icmp_uid;
 
-	/* sender variables */
-
 	/** @dec_cwnd: decimal part of the cwnd used during linear growth */
 	u16 dec_cwnd;
 
@@ -1412,21 +1422,12 @@ struct batadv_tp_vars {
 	/** @last_acked: last acked byte */
 	atomic_t last_acked;
 
-	/** @last_sent: last sent byte, not yet acked */
-	u32 last_sent;
-
 	/** @tot_sent: amount of data sent/ACKed so far */
 	atomic64_t tot_sent;
 
 	/** @dup_acks: duplicate ACKs counter */
 	atomic_t dup_acks;
 
-	/** @fast_recovery: true if in Fast Recovery mode */
-	unsigned char fast_recovery:1;
-
-	/** @recover: last sent seqno when entering Fast Recovery */
-	u32 recover;
-
 	/** @rto: sender timeout */
 	u32 rto;
 
@@ -1447,26 +1448,23 @@ struct batadv_tp_vars {
 
 	/** @prerandom_lock: spinlock protecting access to prerandom_offset */
 	spinlock_t prerandom_lock;
+};
 
-	/* receiver variables */
+/**
+ * struct batadv_tp_receiver - receiver tp meter private variables per session
+ */
+struct batadv_tp_receiver {
+	/** @common: common batadv_tp_vars (best be first member) */
+	struct batadv_tp_vars_common common;
+
+	/** @receiving: receiving binary semaphore: 1 if receiving, 0 is not */
+	atomic_t receiving;
 
 	/** @last_recv: last in-order received packet */
 	u32 last_recv;
 
-	/** @unacked_list: list of unacked packets (meta-info only) */
-	struct list_head unacked_list;
-
-	/** @unacked_lock: protect unacked_list */
-	spinlock_t unacked_lock;
-
 	/** @last_recv_time: time (jiffies) a msg was received */
 	unsigned long last_recv_time;
-
-	/** @refcount: number of context where the object is used */
-	struct kref refcount;
-
-	/** @rcu: struct used for freeing in an RCU-safe manner */
-	struct rcu_head rcu;
 };
 
 /**
@@ -1643,8 +1641,11 @@ struct batadv_priv {
 	 */
 	struct hlist_head forw_bcast_list;
 
-	/** @tp_list: list of tp sessions */
-	struct hlist_head tp_list;
+	/** @tp_sender_list: list of tp sender sessions */
+	struct hlist_head tp_sender_list;
+
+	/** @tp_receiver_list: list of tp receiver sessions */
+	struct hlist_head tp_receiver_list;
 
 	/** @orig_hash: hash table containing mesh participants (orig nodes) */
 	struct batadv_hashtable *orig_hash;
-- 
2.47.3


