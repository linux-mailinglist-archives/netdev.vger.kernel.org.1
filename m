Return-Path: <netdev+bounces-303224-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kmbrFk3OQ2r2igoAu9opvQ
	(envelope-from <netdev+bounces-303224-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:10:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 188F26E5403
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:10:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=YssNSfpm;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303224-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303224-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7781430286ED
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF84425CF2;
	Tue, 30 Jun 2026 14:06:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61EB423A67
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 14:06:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782828397; cv=none; b=C4pHp1IneFhaEC3gsMqLblX4f2nD+FygPcH3wUQmEOiCfbePM6Mwehhn4zb4zEGRbJX7dyMSjZyOhEKIWrGHx1IU+cMMRo3+VZaq4WaP8IAcxklJd2BGRIxnENlVlEAFlqq6YcnAIOILUBopWM/Vg09BMB+y1LMKlKC4uBxewpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782828397; c=relaxed/simple;
	bh=IVtcpeQulDhFoeyAMRykIR3X5DIGKu3rvKvIsf3NF5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RRVguQmAz8V4Gj/5sxEBnCluyBeYEaIFwvXwIFNsuIWQ6wDgE5hpSKLH53R1e5miBnAJsm/xtBzcanUV3fwWgC0YXM8ivKqblvBCxr6ffClKWtW4uAb3RYA0eFKePXGjo4mRLRK3rTVgmeR3mjxgZeRfxfh5n4CvrJNA/TBwwRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=YssNSfpm; arc=none smtp.client-ip=23.88.38.48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1782828393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MhcjqQ6KyMCxsM73KgBkuwr+9k/iTAvcQoxVAttOCz8=;
	b=YssNSfpmia3UchCW5sl0I7q6j8NZf3LT2shv9134oX7cACrSLYBYQ76SHltA6bn9rrE/Yr
	S2b3SN9MxKYr0DtbWPTMigIeiyUVxF0tRShw9Kw99s/eGoaoW8NY0f7xQNWsU1+4sDkTvS
	uC8gQrDIqo1rpVwrHxU3VRREqRCAgNj8vfHPplEsmALAC3dzrVqpDlZsTS21wR+yu6x707
	cA4tFXyf77NhMZaDc0UR8G+aXyX4B+kbP2Gb1ldNgOzd8vPLxBpe4/HBhUBhawf4A/doXX
	sMTKjpA9hbcXM0jYTmNK6Bzk3YUH7uSbjSsdSXMsDoxs4tzRJWqwSSgLE+zHgQ==
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
Subject: [PATCH net-next 12/15] batman-adv: tp_meter: combine adjacent/overlapping unacked entries
Date: Tue, 30 Jun 2026 16:06:20 +0200
Message-ID: <20260630140623.88431-13-sw@simonwunderlich.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-303224-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:b.a.t.m.a.n@lists.open-mesh.org,m:sven@narfation.org,m:sw@simonwunderlich.de,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,simonwunderlich.de:dkim,simonwunderlich.de:email,simonwunderlich.de:mid,simonwunderlich.de:from_mime,narfation.org:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 188F26E5403

From: Sven Eckelmann <sven@narfation.org>

Right at the point when the receiver gets the first packet with a seqno gap
(due to some packet loss/reordering), entries in the unacked list are
created. They are (besides direct seqno matches) are not combined. A lot
more then necessary entries are therefore created. Not for each gap but for
each packet.

This increases the memory consumption and management overhead. But it is
trivial to handle overlapping or adjacent sequence number ranges during the
insert. Only the handling of closed gaps by a new packets requires an extra
step after the insert.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/tp_meter.c | 61 +++++++++++++++++++++++++++++++++------
 net/batman-adv/types.h    |  2 +-
 2 files changed, 53 insertions(+), 10 deletions(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index b7fee6e55f032..5cc719c81ea0b 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -1406,6 +1406,7 @@ static bool batadv_tp_handle_out_of_order(struct batadv_tp_receiver *tp_vars,
 	__must_hold(&tp_vars->common.unacked_lock)
 {
 	struct batadv_tp_unacked *un, *new;
+	struct batadv_tp_unacked *safe;
 	bool added = false;
 
 	new = kmalloc_obj(*new, GFP_ATOMIC);
@@ -1430,20 +1431,46 @@ static bool batadv_tp_handle_out_of_order(struct batadv_tp_receiver *tp_vars,
 	 * seqno than all the others already stored.
 	 */
 	list_for_each_entry_reverse(un, &tp_vars->common.unacked_list, list) {
-		/* check for duplicates */
-		if (new->seqno == un->seqno) {
-			if (new->len > un->len)
-				un->len = new->len;
+		/* look for the right position - an un which is smaller */
+		if (batadv_seq_before(new->seqno, un->seqno))
+			continue;
+
+		/* smaller/equal seqno was found but they might be directly
+		 * after another or overlapping. keep only a single entry
+		 *
+		 * It is already known that:
+		 *
+		 *	un->seqno <= new->seqno
+		 *
+		 * When establishing that:
+		 *
+		 *	new->seqno <= un->seqno + un->len
+		 *
+		 * Then it is not necessary to add a new entry because the
+		 * smaller/equal seqno of un might already contain the new
+		 * received packet or we only add new data directly after
+		 * the end of un. The latter can be identified using:
+		 *
+		 *	un->seqno + un->len <= new->seqno + new->len
+		 */
+		if (!batadv_seq_before(un->seqno + un->len, new->seqno)) {
+			/* new data directly after un? */
+			if (!batadv_seq_before(new->seqno + new->len,
+					       un->seqno + un->len))
+				un->len = new->seqno + new->len - un->seqno;
+
+			/* un now represents both old un + new */
 			kfree(new);
 			added = true;
+
+			/* un has to be used to check if the gap to the next
+			 * seqno range was closed
+			 */
+			new = un;
 			break;
 		}
 
-		/* look for the right position */
-		if (batadv_seq_before(new->seqno, un->seqno))
-			continue;
-
-		/* as soon as an entry having a bigger seqno is found, the new
+		/* as soon as an entry having a smaller seqno is found, the new
 		 * one is attached _after_ it. In this way the list is kept in
 		 * ascending order
 		 */
@@ -1459,6 +1486,22 @@ static bool batadv_tp_handle_out_of_order(struct batadv_tp_receiver *tp_vars,
 		tp_vars->common.unacked_count++;
 	}
 
+	/* check if new filled the gap to the next list entries */
+	un = new;
+	list_for_each_entry_safe_continue(un, safe, &tp_vars->common.unacked_list, list) {
+		if (batadv_seq_before(new->seqno + new->len, un->seqno))
+			break;
+
+		/* next entry is overlapping or adjacent - combine both */
+		if (batadv_seq_before(new->seqno + new->len,
+				      un->seqno + un->len))
+			new->len = un->seqno + un->len - new->seqno;
+
+		list_del(&un->list);
+		kfree(un);
+		tp_vars->common.unacked_count--;
+	}
+
 	/* remove the last (biggest) unacked seqno when list is too large */
 	if (tp_vars->common.unacked_count > BATADV_TP_MAX_UNACKED) {
 		un = list_last_entry(&tp_vars->common.unacked_list,
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index e1463a029e835..c2ab00d8ef160 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1332,7 +1332,7 @@ struct batadv_tp_unacked {
 	u32 seqno;
 
 	/** @len: length of the packet */
-	u16 len;
+	u32 len;
 
 	/** @list: list node for &batadv_tp_vars_common.unacked_list */
 	struct list_head list;
-- 
2.47.3


