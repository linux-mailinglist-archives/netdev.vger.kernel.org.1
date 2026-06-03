Return-Path: <netdev+bounces-294626-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qA5SDnzZH2pCrAAAu9opvQ
	(envelope-from <netdev+bounces-294626-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 09:36:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C3063545B
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 09:36:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=PqTJgpRT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294626-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294626-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 379C5310FC51
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 07:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F13A402426;
	Wed,  3 Jun 2026 07:25:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4533FF1D9
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 07:25:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780471545; cv=none; b=EojRGh6Ojpn+tgMWPVmurWTjUzenKc6PCf+ZhQwnhK81LhVLgkZXyiUXFOMDCBH70XlWSIRu/YBhnMs9h10TsXLBAZqligoG+qPEUyQ9ITgqqHVaskswSJHKBYO1yKWsN7xlUdWZQDtn8uiBIlHSBQ/n21jbQXDaEJlcuNzZkAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780471545; c=relaxed/simple;
	bh=MVP92nb0TuJX8iwUdVVgoPQgzmngGDXMnyQANrasxDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lpx8uWG4dwq3dGDzofDxrVz3Ryt8JzKmt0cORX3QZP1yhPqDYqgiTyJTke7MOvN9HfTtIMLUdMKD1/OJHPc6IRATyZohztGywIFhGQuJgmLf2L2FeNOVQ+mJfuyFW8qx6/t034xrm0d3tPyzDL7/+U4DRNWws2Xk90XEAla3grA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=PqTJgpRT; arc=none smtp.client-ip=23.88.38.48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1780471536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/+tmZFZ4ZG3zm0KZmDyNH0yR4CYfqYO1qwrdz0gNBz4=;
	b=PqTJgpRTrKCsjsCYTTPo+aIyNHTjpPd8US7+2+7Cfs/DzaXVR20cXjlN66MrZv35vuhOYx
	yniMELdEX+iGaauD8hYi1txLMkJIKlMgiiO7TWUFuLwSomXfqpIcnc/2r/k2cowZsuAJ1O
	Y2t+5K11t6KEQ18zoxx0c8ZKKu3wsMiCtwrnhOM4Q4c/+oCZ9919N80CNNDD84+qXcwRO6
	QaMK/C1HjC4bP/tyubnE/fUXDAxYq8hELyzj5XJoMyGT9zeMqi2e6Xbdezc3WOIC80qGmp
	KSnDYMnjyXrEMO+7lHGd3p2rSz/IMU31Y08Y3+zpc+QhpNOf0ZKV/4RK1sDZjQ==
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
Subject: [PATCH net-next 11/15] batman-adv: tp_meter: consolidate congestion control variables
Date: Wed,  3 Jun 2026 09:25:22 +0200
Message-ID: <20260603072527.174487-12-sw@simonwunderlich.de>
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
	TAGGED_FROM(0.00)[bounces-294626-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: C5C3063545B

From: Sven Eckelmann <sven@narfation.org>

Congestion control variables in batadv_tp_sender were scattered across the
struct without clear grouping, making it difficult to reason about which
fields require cwnd_lock (now "cc_lock") protection. These should be
combined in a structure to make it more easily visible which variable
should be read/modified with the cc_lock held.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/tp_meter.c | 170 +++++++++++++++++++-------------------
 net/batman-adv/types.h    |  80 +++++++++---------
 2 files changed, 128 insertions(+), 122 deletions(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index e9ba1c45a285d..978e32d94e6c3 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -143,12 +143,12 @@ static u32 batadv_tp_cwnd(u32 base, u32 increment, u32 min)
  * increased by MSS * MSS / CWND for every unique received ACK
  */
 static void batadv_tp_update_cwnd(struct batadv_tp_sender *tp_vars, u32 mss)
-	__must_hold(&tp_vars->cwnd_lock)
+	__must_hold(&tp_vars->cc_lock)
 {
 	/* slow start... */
-	if (tp_vars->cwnd <= tp_vars->ss_threshold) {
-		tp_vars->dec_cwnd = 0;
-		tp_vars->cwnd = batadv_tp_cwnd(tp_vars->cwnd, mss, mss);
+	if (tp_vars->cc.cwnd <= tp_vars->cc.ss_threshold) {
+		tp_vars->cc.dec_cwnd = 0;
+		tp_vars->cc.cwnd = batadv_tp_cwnd(tp_vars->cc.cwnd, mss, mss);
 		return;
 	}
 
@@ -156,13 +156,13 @@ static void batadv_tp_update_cwnd(struct batadv_tp_sender *tp_vars, u32 mss)
 	mss = min_t(u32, mss, (1U << 14) - 1);
 
 	/* increment CWND at least of 1 (section 3.1 of RFC5681) */
-	tp_vars->dec_cwnd += max_t(u32, 1U << 3,
-				   ((mss * mss) << 3) / tp_vars->cwnd);
-	if (tp_vars->dec_cwnd < (mss << 3))
+	tp_vars->cc.dec_cwnd += max_t(u32, 1U << 3,
+				      ((mss * mss) << 3) / tp_vars->cc.cwnd);
+	if (tp_vars->cc.dec_cwnd < (mss << 3))
 		return;
 
-	tp_vars->cwnd = batadv_tp_cwnd(tp_vars->cwnd, mss, mss);
-	tp_vars->dec_cwnd = 0;
+	tp_vars->cc.cwnd = batadv_tp_cwnd(tp_vars->cc.cwnd, mss, mss);
+	tp_vars->cc.dec_cwnd = 0;
 }
 
 /**
@@ -172,7 +172,7 @@ static void batadv_tp_update_cwnd(struct batadv_tp_sender *tp_vars, u32 mss)
  */
 static void batadv_tp_update_rto(struct batadv_tp_sender *tp_vars,
 				 u32 new_rtt)
-	__must_hold(&tp_vars->cwnd_lock)
+	__must_hold(&tp_vars->cc_lock)
 {
 	long m = new_rtt;
 
@@ -182,24 +182,24 @@ static void batadv_tp_update_rto(struct batadv_tp_sender *tp_vars,
 	 * It's tricky to understand. Don't lose hair please.
 	 * Inspired by tcp_rtt_estimator() tcp_input.c
 	 */
-	if (tp_vars->srtt != 0) {
-		m -= (tp_vars->srtt >> 3); /* m is now error in rtt est */
-		tp_vars->srtt += m; /* rtt = 7/8 srtt + 1/8 new */
+	if (tp_vars->cc.srtt != 0) {
+		m -= (tp_vars->cc.srtt >> 3); /* m is now error in rtt est */
+		tp_vars->cc.srtt += m; /* rtt = 7/8 srtt + 1/8 new */
 		if (m < 0)
 			m = -m;
 
-		m -= (tp_vars->rttvar >> 2);
-		tp_vars->rttvar += m; /* mdev ~= 3/4 rttvar + 1/4 new */
+		m -= (tp_vars->cc.rttvar >> 2);
+		tp_vars->cc.rttvar += m; /* mdev ~= 3/4 rttvar + 1/4 new */
 	} else {
 		/* first measure getting in */
-		tp_vars->srtt = m << 3; /* take the measured time to be srtt */
-		tp_vars->rttvar = m << 1; /* new_rtt / 2 */
+		tp_vars->cc.srtt = m << 3; /* take the measured time to be srtt */
+		tp_vars->cc.rttvar = m << 1; /* new_rtt / 2 */
 	}
 
 	/* rto = srtt + 4 * rttvar.
 	 * rttvar is scaled by 4, therefore doesn't need to be multiplied
 	 */
-	WRITE_ONCE(tp_vars->rto, (tp_vars->srtt >> 3) + tp_vars->rttvar);
+	WRITE_ONCE(tp_vars->cc.rto, (tp_vars->cc.srtt >> 3) + tp_vars->cc.rttvar);
 }
 
 /**
@@ -450,11 +450,11 @@ static void batadv_tp_sender_end(struct batadv_priv *bat_priv,
 
 	batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
 		   "Last timing stats: SRTT=%ums RTTVAR=%ums RTO=%ums\n",
-		   tp_vars->srtt >> 3, tp_vars->rttvar >> 2, tp_vars->rto);
+		   tp_vars->cc.srtt >> 3, tp_vars->cc.rttvar >> 2, tp_vars->cc.rto);
 
 	batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
 		   "Final values: cwnd=%u ss_threshold=%u\n",
-		   tp_vars->cwnd, tp_vars->ss_threshold);
+		   tp_vars->cc.cwnd, tp_vars->cc.ss_threshold);
 
 	session_cookie = batadv_tp_session_cookie(tp_vars->common.session,
 						  tp_vars->icmp_uid);
@@ -521,7 +521,7 @@ static void batadv_tp_reset_sender_timer(struct batadv_tp_sender *tp_vars)
 		return;
 
 	mod_timer(&tp_vars->common.timer,
-		  jiffies + msecs_to_jiffies(READ_ONCE(tp_vars->rto)));
+		  jiffies + msecs_to_jiffies(READ_ONCE(tp_vars->cc.rto)));
 }
 
 /**
@@ -540,11 +540,11 @@ static void batadv_tp_sender_timeout(struct timer_list *t)
 	if (batadv_tp_sender_stopped(tp_vars))
 		return;
 
-	spin_lock_bh(&tp_vars->cwnd_lock);
+	spin_lock_bh(&tp_vars->cc_lock);
 
 	/* if the user waited long enough...shutdown the test */
-	if (unlikely(tp_vars->rto >= BATADV_TP_MAX_RTO)) {
-		spin_unlock_bh(&tp_vars->cwnd_lock);
+	if (unlikely(tp_vars->cc.rto >= BATADV_TP_MAX_RTO)) {
+		spin_unlock_bh(&tp_vars->cc_lock);
 		batadv_tp_sender_shutdown(tp_vars,
 					  BATADV_TP_REASON_DST_UNREACHABLE);
 		return;
@@ -553,22 +553,22 @@ static void batadv_tp_sender_timeout(struct timer_list *t)
 	/* RTO exponential backoff
 	 * Details in Section 5.5 of RFC6298
 	 */
-	WRITE_ONCE(tp_vars->rto, tp_vars->rto * 2);
+	WRITE_ONCE(tp_vars->cc.rto, tp_vars->cc.rto * 2);
 
-	tp_vars->ss_threshold = tp_vars->cwnd >> 1;
-	if (tp_vars->ss_threshold < BATADV_TP_PLEN * 2)
-		tp_vars->ss_threshold = BATADV_TP_PLEN * 2;
+	tp_vars->cc.ss_threshold = tp_vars->cc.cwnd >> 1;
+	if (tp_vars->cc.ss_threshold < BATADV_TP_PLEN * 2)
+		tp_vars->cc.ss_threshold = BATADV_TP_PLEN * 2;
 
 	batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
 		   "Meter: RTO fired during test towards %pM! cwnd=%u new ss_thr=%u, resetting last_sent to %u\n",
-		   tp_vars->common.other_end, tp_vars->cwnd, tp_vars->ss_threshold,
-		   tp_vars->last_acked);
+		   tp_vars->common.other_end, tp_vars->cc.cwnd, tp_vars->cc.ss_threshold,
+		   tp_vars->cc.last_acked);
 
-	tp_vars->cwnd = BATADV_TP_PLEN * 3;
+	tp_vars->cc.cwnd = BATADV_TP_PLEN * 3;
 
-	WRITE_ONCE(tp_vars->last_sent, tp_vars->last_acked);
+	WRITE_ONCE(tp_vars->cc.last_sent, tp_vars->cc.last_acked);
 
-	spin_unlock_bh(&tp_vars->cwnd_lock);
+	spin_unlock_bh(&tp_vars->cc_lock);
 
 	/* resend the non-ACKed packets.. */
 	wake_up(&tp_vars->more_bytes);
@@ -698,81 +698,81 @@ static enum batadv_tp_ack_reaction
 batadv_tp_handle_ack(struct batadv_priv *bat_priv,
 		     struct batadv_tp_sender *tp_vars,
 		     u32 recv_ack, size_t mss)
-	__must_hold(&tp_vars->cwnd_lock)
+	__must_hold(&tp_vars->cc_lock)
 {
 	enum batadv_tp_ack_reaction reaction;
 
-	if (batadv_seq_before(recv_ack, tp_vars->last_acked))
+	if (batadv_seq_before(recv_ack, tp_vars->cc.last_acked))
 		return BATADV_TP_ACK_REACTION_OLD_ACK;
 
 	/* check if this ACK is a duplicate */
-	if (tp_vars->last_acked == recv_ack) {
+	if (tp_vars->cc.last_acked == recv_ack) {
 		/* if this is the third duplicate ACK do Fast Retransmit */
-		if (tp_vars->dup_acks > 3)
+		if (tp_vars->cc.dup_acks > 3)
 			return BATADV_TP_ACK_REACTION_IGNORE;
 
-		tp_vars->dup_acks++;
-		if (tp_vars->dup_acks != 3)
+		tp_vars->cc.dup_acks++;
+		if (tp_vars->cc.dup_acks != 3)
 			return BATADV_TP_ACK_REACTION_IGNORE;
 
-		if (!batadv_seq_before(tp_vars->recover, recv_ack))
+		if (!batadv_seq_before(tp_vars->cc.recover, recv_ack))
 			return BATADV_TP_ACK_REACTION_IGNORE;
 
 		/* Fast Recovery */
-		tp_vars->fast_recovery = true;
+		tp_vars->cc.fast_recovery = true;
 
 		/* Set recover to the last outstanding seqno when Fast Recovery
 		 * is entered. RFC6582, Section 3.2, step 1
 		 */
-		tp_vars->recover = tp_vars->last_sent;
-		tp_vars->ss_threshold = tp_vars->cwnd >> 1;
+		tp_vars->cc.recover = tp_vars->cc.last_sent;
+		tp_vars->cc.ss_threshold = tp_vars->cc.cwnd >> 1;
 		batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
 			   "Meter: Fast Recovery, (cur cwnd=%u) ss_thr=%u last_sent=%u recv_ack=%u\n",
-			   tp_vars->cwnd, tp_vars->ss_threshold,
-			   tp_vars->last_sent, recv_ack);
-		tp_vars->cwnd = batadv_tp_cwnd(tp_vars->ss_threshold, 3 * mss,
-					       mss);
-		tp_vars->dec_cwnd = 0;
-		WRITE_ONCE(tp_vars->last_sent, recv_ack);
+			   tp_vars->cc.cwnd, tp_vars->cc.ss_threshold,
+			   tp_vars->cc.last_sent, recv_ack);
+		tp_vars->cc.cwnd = batadv_tp_cwnd(tp_vars->cc.ss_threshold, 3 * mss,
+						  mss);
+		tp_vars->cc.dec_cwnd = 0;
+		WRITE_ONCE(tp_vars->cc.last_sent, recv_ack);
 
 		return BATADV_TP_ACK_REACTION_RESEND_WAKEUP;
 	}
 
 	/* count the acked data */
-	atomic64_add(recv_ack - tp_vars->last_acked, &tp_vars->tot_sent);
+	atomic64_add(recv_ack - tp_vars->cc.last_acked, &tp_vars->tot_sent);
 
 	/* reset the duplicate ACKs counter */
-	tp_vars->dup_acks = 0;
+	tp_vars->cc.dup_acks = 0;
 
-	if (tp_vars->fast_recovery) {
+	if (tp_vars->cc.fast_recovery) {
 		/* partial ACK */
-		if (batadv_seq_before(recv_ack, tp_vars->recover)) {
+		if (batadv_seq_before(recv_ack, tp_vars->cc.recover)) {
 			/* this is another hole in the window. React
 			 * immediately as specified by NewReno (see
 			 * Section 3.2 of RFC6582 for details)
 			 */
 			reaction = BATADV_TP_ACK_REACTION_RESEND_WAKEUP;
-			tp_vars->cwnd = batadv_tp_cwnd(tp_vars->cwnd,
-						       mss, mss);
+			tp_vars->cc.cwnd = batadv_tp_cwnd(tp_vars->cc.cwnd,
+							  mss, mss);
 		} else {
-			tp_vars->fast_recovery = false;
+			tp_vars->cc.fast_recovery = false;
 			/* set cwnd to the value of ss_threshold at the
 			 * moment that Fast Recovery was entered.
 			 * RFC6582, Section 3.2, step 3
 			 */
-			tp_vars->cwnd = batadv_tp_cwnd(tp_vars->ss_threshold,
-						       0, mss);
+			tp_vars->cc.cwnd = batadv_tp_cwnd(tp_vars->cc.ss_threshold,
+							  0, mss);
 			reaction = BATADV_TP_ACK_REACTION_WAKEUP;
 		}
 	} else {
-		if (recv_ack - tp_vars->last_acked >= mss)
+		if (recv_ack - tp_vars->cc.last_acked >= mss)
 			batadv_tp_update_cwnd(tp_vars, mss);
 
 		reaction = BATADV_TP_ACK_REACTION_WAKEUP;
 	}
 
 	/* move the Transmit Window */
-	WRITE_ONCE(tp_vars->last_acked, recv_ack);
+	WRITE_ONCE(tp_vars->cc.last_acked, recv_ack);
 
 	return reaction;
 }
@@ -814,7 +814,7 @@ static void batadv_tp_recv_ack(struct batadv_priv *bat_priv,
 		goto out;
 
 	/* old ACK? silently drop it.. */
-	if (batadv_seq_before(recv_ack, READ_ONCE(tp_vars->last_acked)))
+	if (batadv_seq_before(recv_ack, READ_ONCE(tp_vars->cc.last_acked)))
 		goto out;
 
 	primary_if = batadv_primary_if_get_selected(bat_priv);
@@ -825,14 +825,14 @@ static void batadv_tp_recv_ack(struct batadv_priv *bat_priv,
 	if (unlikely(!orig_node))
 		goto out;
 
-	spin_lock_bh(&tp_vars->cwnd_lock);
+	spin_lock_bh(&tp_vars->cc_lock);
 	/* update RTO with the new sampled RTT, if any */
 	rtt = jiffies_to_msecs(jiffies) - ntohl(icmp->timestamp);
 	if (icmp->timestamp && rtt)
 		batadv_tp_update_rto(tp_vars, rtt);
 
 	reaction = batadv_tp_handle_ack(bat_priv, tp_vars, recv_ack, mss);
-	spin_unlock_bh(&tp_vars->cwnd_lock);
+	spin_unlock_bh(&tp_vars->cc_lock);
 
 	if (reaction == BATADV_TP_ACK_REACTION_OLD_ACK)
 		goto out;
@@ -873,16 +873,16 @@ static bool batadv_tp_avail(struct batadv_tp_sender *tp_vars,
 {
 	u32 win_left, win_limit;
 
-	spin_lock_bh(&tp_vars->cwnd_lock);
+	spin_lock_bh(&tp_vars->cc_lock);
 
-	win_limit = tp_vars->last_acked + tp_vars->cwnd;
+	win_limit = tp_vars->cc.last_acked + tp_vars->cc.cwnd;
 
-	if (batadv_seq_before(tp_vars->last_sent, win_limit))
-		win_left = win_limit - tp_vars->last_sent;
+	if (batadv_seq_before(tp_vars->cc.last_sent, win_limit))
+		win_left = win_limit - tp_vars->cc.last_sent;
 	else
 		win_left = 0;
 
-	spin_unlock_bh(&tp_vars->cwnd_lock);
+	spin_unlock_bh(&tp_vars->cc_lock);
 
 	return win_left >= payload_len;
 }
@@ -964,7 +964,7 @@ static int batadv_tp_send(void *arg)
 		 * the size of the unicast header
 		 */
 		packet_len = payload_len + sizeof(struct batadv_unicast_packet);
-		last_sent = READ_ONCE(tp_vars->last_sent);
+		last_sent = READ_ONCE(tp_vars->cc.last_sent);
 
 		err = batadv_tp_send_msg(tp_vars, primary_if->net_dev->dev_addr,
 					 orig_node, last_sent, packet_len,
@@ -983,10 +983,10 @@ static int batadv_tp_send(void *arg)
 
 		/* right-shift the TWND */
 		if (!err) {
-			spin_lock_bh(&tp_vars->cwnd_lock);
-			if (tp_vars->last_sent == last_sent)
-				WRITE_ONCE(tp_vars->last_sent, last_sent + payload_len);
-			spin_unlock_bh(&tp_vars->cwnd_lock);
+			spin_lock_bh(&tp_vars->cc_lock);
+			if (tp_vars->cc.last_sent == last_sent)
+				WRITE_ONCE(tp_vars->cc.last_sent, last_sent + payload_len);
+			spin_unlock_bh(&tp_vars->cc_lock);
 		}
 
 		cond_resched();
@@ -1104,30 +1104,30 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 	memcpy(tp_vars->common.session, session_id, sizeof(session_id));
 	tp_vars->icmp_uid = icmp_uid;
 
-	WRITE_ONCE(tp_vars->last_sent, BATADV_TP_FIRST_SEQ);
-	WRITE_ONCE(tp_vars->dup_acks, 0);
-	WRITE_ONCE(tp_vars->last_acked, BATADV_TP_FIRST_SEQ);
-	tp_vars->fast_recovery = false;
-	tp_vars->recover = BATADV_TP_FIRST_SEQ;
+	WRITE_ONCE(tp_vars->cc.last_sent, BATADV_TP_FIRST_SEQ);
+	WRITE_ONCE(tp_vars->cc.dup_acks, 0);
+	WRITE_ONCE(tp_vars->cc.last_acked, BATADV_TP_FIRST_SEQ);
+	tp_vars->cc.fast_recovery = false;
+	tp_vars->cc.recover = BATADV_TP_FIRST_SEQ;
 
 	/* initialise the CWND to 3*MSS (Section 3.1 in RFC5681).
 	 * For batman-adv the MSS is the size of the payload received by the
 	 * mesh_interface, hence its MTU
 	 */
-	tp_vars->cwnd = BATADV_TP_PLEN * 3;
-	tp_vars->dec_cwnd = 0;
+	tp_vars->cc.cwnd = BATADV_TP_PLEN * 3;
+	tp_vars->cc.dec_cwnd = 0;
 
 	/* at the beginning initialise the SS threshold to the biggest possible
 	 * window size, hence the AWND size
 	 */
-	tp_vars->ss_threshold = BATADV_TP_AWND;
+	tp_vars->cc.ss_threshold = BATADV_TP_AWND;
 
 	/* RTO initial value is 3 seconds.
 	 * Details in Section 2.1 of RFC6298
 	 */
-	WRITE_ONCE(tp_vars->rto, 1000);
-	tp_vars->srtt = 0;
-	tp_vars->rttvar = 0;
+	WRITE_ONCE(tp_vars->cc.rto, 1000);
+	tp_vars->cc.srtt = 0;
+	tp_vars->cc.rttvar = 0;
 
 	atomic64_set(&tp_vars->tot_sent, 0);
 
@@ -1143,7 +1143,7 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 	spin_lock_init(&tp_vars->common.unacked_lock);
 	INIT_LIST_HEAD(&tp_vars->common.unacked_list);
 
-	spin_lock_init(&tp_vars->cwnd_lock);
+	spin_lock_init(&tp_vars->cc_lock);
 
 	tp_vars->prerandom_offset = 0;
 	spin_lock_init(&tp_vars->prerandom_lock);
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index c782f04aea9c4..5eb0371def83a 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1367,6 +1367,45 @@ struct batadv_tp_vars_common {
 	struct rcu_head rcu;
 };
 
+/** struct batadv_tp_sender_cc - congestion control variables */
+struct batadv_tp_sender_cc {
+	/** @fast_recovery: true if in Fast Recovery mode */
+	bool fast_recovery:1;
+
+	/** @dup_acks: duplicate ACKs counter */
+	u8 dup_acks;
+
+	/** @dec_cwnd: decimal part of the cwnd used during linear growth */
+	u16 dec_cwnd;
+
+	/** @cwnd: current size of the congestion window */
+	u32 cwnd;
+
+	/**
+	 * @ss_threshold: Slow Start threshold. Once cwnd exceeds this value the
+	 *  connection switches to the Congestion Avoidance state
+	 */
+	u32 ss_threshold;
+
+	/** @last_acked: last acked byte */
+	u32 last_acked;
+
+	/** @last_sent: last sent byte, not yet acked */
+	u32 last_sent;
+
+	/** @recover: last sent seqno when entering Fast Recovery */
+	u32 recover;
+
+	/** @rto: sender timeout */
+	u32 rto;
+
+	/** @srtt: smoothed RTT scaled by 2^3 */
+	u32 srtt;
+
+	/** @rttvar: RTT variation scaled by 2^2 */
+	u32 rttvar;
+};
+
 /**
  * struct batadv_tp_sender - sender tp meter private variables per session
  */
@@ -1383,15 +1422,6 @@ struct batadv_tp_sender {
 	 */
 	atomic_t send_result;
 
-	/** @last_sent: last sent byte, not yet acked */
-	u32 last_sent;
-
-	/** @fast_recovery: true if in Fast Recovery mode */
-	bool fast_recovery:1;
-
-	/** @recover: last sent seqno when entering Fast Recovery */
-	u32 recover;
-
 	/** @finish_work: work item for the finishing procedure */
 	struct delayed_work finish_work;
 
@@ -1404,39 +1434,15 @@ struct batadv_tp_sender {
 	/** @icmp_uid: local ICMP "socket" index */
 	u8 icmp_uid;
 
-	/** @dec_cwnd: decimal part of the cwnd used during linear growth */
-	u16 dec_cwnd;
-
-	/** @cwnd: current size of the congestion window */
-	u32 cwnd;
-
-	/** @cwnd_lock: lock do protect congestion control variables */
-	spinlock_t cwnd_lock;
-
-	/**
-	 * @ss_threshold: Slow Start threshold. Once cwnd exceeds this value the
-	 *  connection switches to the Congestion Avoidance state
-	 */
-	u32 ss_threshold;
+	/** @cc: congestion control variables */
+	struct batadv_tp_sender_cc cc;
 
-	/** @last_acked: last acked byte */
-	u32 last_acked;
+	/** @cc_lock: lock do protect @cc */
+	spinlock_t cc_lock;
 
 	/** @tot_sent: amount of data sent/ACKed so far */
 	atomic64_t tot_sent;
 
-	/** @dup_acks: duplicate ACKs counter */
-	u8 dup_acks;
-
-	/** @rto: sender timeout */
-	u32 rto;
-
-	/** @srtt: smoothed RTT scaled by 2^3 */
-	u32 srtt;
-
-	/** @rttvar: RTT variation scaled by 2^2 */
-	u32 rttvar;
-
 	/**
 	 * @more_bytes: waiting queue anchor when waiting for more ack/retry
 	 *  timeout
-- 
2.47.3


