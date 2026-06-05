Return-Path: <netdev+bounces-295677-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bW64H255Imo3YAEAu9opvQ
	(envelope-from <netdev+bounces-295677-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 09:23:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7D7645EC6
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 09:23:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=w1GDLF2t;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295677-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295677-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AF9263047CBE
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 07:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8640478E5F;
	Fri,  5 Jun 2026 07:20:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34ED341C31B
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 07:20:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780644020; cv=none; b=SKDKxOx9x6hjjZAn64CDp9ZPxOWsHBsLyrg/yngP5N4cr+tU1DDf73WhDJQqe9/SgBzxq90yueksCOSL+4WExcXkklTwDqcOAZYRR01sD1MktQAgw6jwXR+e72l9A5/ddUmSjZ0GKIPehr8zSL7MFxMNPdO2oD0KWhtMTFgXCcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780644020; c=relaxed/simple;
	bh=Obsha1/QLQjEyGmsc+3yvBUqvXx+6H5BtGwJmefMfP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iwqpb2LGgbLGiHywIK2P/sG+afIUDvJPygeFM7WD3AB77bIl58lUJs4jkx1Lo1WnszHe3Q5ovBsYidyM7CAt1/CsZoDuQ1Xt6Xb8KGlZWuePC9fJH/3RbDrIU60AeDPEGxKRfGmD8p1BRSUioJ0nlxCrnmIFx6VPusKolXBBIcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=w1GDLF2t; arc=none smtp.client-ip=23.88.38.48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1780644016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8JwYgpPGj+vXgN7oOZfclO+SwAYin1aQSzciPTokuxk=;
	b=w1GDLF2t3VGcrkDgrUcMHn2iQelb6ktbar4gRzbMv1qeJ3xZ87vMuWkwnEyNdgVmpqpHD0
	6IgHjKUg7eSYtyEO0Wc9mnbFAj+L413hsR2k5UyO145iJMc7O4DQzCWJrungqSNcp2Rxir
	eJKACQRtPpNFZsqxMHEZHt1Oxa6PKQgvPe5DtKoJKWby8/AINHyqmRlhh21HFbDaJk9+oz
	zkYbjyszIQYiosW+8JUY4ALUC42B5jtJ6j8nKn5Lpjy8chE33phzHxrHfh8mclGdfbb1CR
	2aDcevlC9rKC0+CgpW5mk8NMGmbwEyPLrwWidXHC7nJL6CtxatPzvsTntEcrAA==
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
Subject: [PATCH net-next 07/11] batman-adv: tp_meter: update stale kernel-doc after refactoring
Date: Fri,  5 Jun 2026 09:20:01 +0200
Message-ID: <20260605072005.490368-8-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260605072005.490368-1-sw@simonwunderlich.de>
References: <20260605072005.490368-1-sw@simonwunderlich.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-295677-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:b.a.t.m.a.n@lists.open-mesh.org,m:sven@narfation.org,m:sw@simonwunderlich.de,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,simonwunderlich.de:mid,simonwunderlich.de:dkim,simonwunderlich.de:from_mime,simonwunderlich.de:email,narfation.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1A7D7645EC6

From: Sven Eckelmann <sven@narfation.org>

The tp_meter codebase was recently refactored:

* throughput meter sender and receiver variables were split into
  two different structures
* the congestion control variables were extracted in a separate structure

But the kernel-doc was not updated everywhere to reflect these changes.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/tp_meter.c | 16 ++++++++--------
 net/batman-adv/types.h    | 14 ++++++++------
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index a404d70e053e2..7e98cbfbbb70d 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -289,7 +289,7 @@ batadv_tp_list_find_sender(struct batadv_priv *bat_priv, const u8 *dst)
  * @bat_priv: the bat priv with all the mesh interface information
  * @dst: the other endpoint MAC address to look for
  *
- * Return: if matching session with @dst was found
+ * Return: true if a matching session with @dst was found, false otherwise
  */
 static bool batadv_tp_list_active(struct batadv_priv *bat_priv, const u8 *dst)
 	__must_hold(&bat_priv->tp_list_lock)
@@ -355,7 +355,7 @@ batadv_tp_list_find_sender_session(struct batadv_priv *bat_priv, const u8 *dst,
 /**
  * batadv_tp_vars_common_release() - release batadv_tp_vars_common from lists
  *  and queue for free after rcu grace period
- * @ref: kref pointer of the batadv_tp_vars
+ * @ref: kref pointer of the batadv_tp_vars_common
  */
 static void batadv_tp_vars_common_release(struct kref *ref)
 {
@@ -391,7 +391,7 @@ static void batadv_tp_sender_put(struct batadv_tp_sender *tp_vars)
 }
 
 /**
- * batadv_tp_list_detach() - remove tp receiver session from mesh session list once
+ * batadv_tp_list_detach() - remove tp session from mesh session list once
  * @tp_vars: the private data of the current TP meter session
  *
  * Return: whether tp_vars was detached from list and reference must be freed
@@ -509,7 +509,7 @@ static void batadv_tp_sender_finish(struct work_struct *work)
  * batadv_tp_reset_sender_timer() - reschedule the sender timer
  * @tp_vars: the private TP meter data for this session
  *
- * Reschedule the timer using tp_vars->rto as delay
+ * Reschedule the timer using tp_vars->cc.rto as delay
  */
 static void batadv_tp_reset_sender_timer(struct batadv_tp_sender *tp_vars)
 {
@@ -621,9 +621,9 @@ static void batadv_tp_fill_prerandom(struct batadv_tp_sender *tp_vars,
  *
  * Create and send a single TP Meter message.
  *
- * Return: 0 on success, BATADV_TP_REASON_DST_UNREACHABLE if the destination is
- * not reachable, BATADV_TP_REASON_MEMORY_ERROR if the packet couldn't be
- * allocated
+ * Return: 0 on success, BATADV_TP_REASON_MEMORY_ERROR if the packet couldn't
+ * be allocated, BATADV_TP_REASON_CANT_SEND if the packet could not be
+ * transmitted
  */
 static int batadv_tp_send_msg(struct batadv_tp_sender *tp_vars, const u8 *src,
 			      struct batadv_orig_node *orig_node,
@@ -913,7 +913,7 @@ static int batadv_tp_wait_available(struct batadv_tp_sender *tp_vars, size_t ple
  * batadv_tp_send() - main sending thread of a tp meter session
  * @arg: address of the related tp_vars
  *
- * Return: nothing, this function never returns
+ * Return: 0
  */
 static int batadv_tp_send(void *arg)
 {
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 5eb0371def83a..a7fa0d9e09288 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1331,7 +1331,7 @@ struct batadv_tp_unacked {
 	/** @len: length of the packet */
 	u16 len;
 
-	/** @list: list node for &batadv_tp_vars.unacked_list */
+	/** @list: list node for &batadv_tp_vars_common.unacked_list */
 	struct list_head list;
 };
 
@@ -1367,7 +1367,9 @@ struct batadv_tp_vars_common {
 	struct rcu_head rcu;
 };
 
-/** struct batadv_tp_sender_cc - congestion control variables */
+/**
+ * struct batadv_tp_sender_cc - congestion control variables
+ */
 struct batadv_tp_sender_cc {
 	/** @fast_recovery: true if in Fast Recovery mode */
 	bool fast_recovery:1;
@@ -1410,7 +1412,7 @@ struct batadv_tp_sender_cc {
  * struct batadv_tp_sender - sender tp meter private variables per session
  */
 struct batadv_tp_sender {
-	/** @common: common batadv_tp_vars (best be first member) */
+	/** @common: common batadv_tp_vars_common (must be first member) */
 	struct batadv_tp_vars_common common;
 
 	/** @start_time: start time in jiffies */
@@ -1437,7 +1439,7 @@ struct batadv_tp_sender {
 	/** @cc: congestion control variables */
 	struct batadv_tp_sender_cc cc;
 
-	/** @cc_lock: lock do protect @cc */
+	/** @cc_lock: lock to protect @cc */
 	spinlock_t cc_lock;
 
 	/** @tot_sent: amount of data sent/ACKed so far */
@@ -1460,7 +1462,7 @@ struct batadv_tp_sender {
  * struct batadv_tp_receiver - receiver tp meter private variables per session
  */
 struct batadv_tp_receiver {
-	/** @common: common batadv_tp_vars (best be first member) */
+	/** @common: common batadv_tp_vars_common (must be first member) */
 	struct batadv_tp_vars_common common;
 
 	/** @receiving: receiving binary semaphore: 1 if receiving, 0 is not */
@@ -1662,7 +1664,7 @@ struct batadv_priv {
 	/** @forw_bcast_list_lock: lock protecting forw_bcast_list */
 	spinlock_t forw_bcast_list_lock;
 
-	/** @tp_list_lock: spinlock protecting @tp_list */
+	/** @tp_list_lock: spinlock protecting @tp_sender_list + @tp_receiver_list */
 	spinlock_t tp_list_lock;
 
 	/** @tp_num: number of currently active tp sessions */
-- 
2.47.3


