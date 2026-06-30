Return-Path: <netdev+bounces-303227-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hz5UNgHQQ2omjAoAu9opvQ
	(envelope-from <netdev+bounces-303227-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:17:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 518FF6E5518
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:17:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=F6hpwTmy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303227-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303227-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 318F730802E7
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD7F37C0F9;
	Tue, 30 Jun 2026 14:06:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D210426689
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 14:06:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782828398; cv=none; b=s79XAF+f73vUFu96iBIhKP+AW89hIQOSibBCz5mU+6IDzCAZvLEjl7ynNWZCL3tlZY4zORBhnAaY2332g1l57txQ1Fc9wJuhDnh3TkpTKhu77vi9MhozDVQ5ro004/390a+vdOFyW1Q7R7ZBY9XSMkY5ZBZzeTHAKX8fuLDq6mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782828398; c=relaxed/simple;
	bh=Q4SPLV33loiEjhUATj5WSg/i9CaMKzBVi8hMH8x4Eqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kTy/O8XKAaueejPd83kONMXZbrq+ThyJP4gvtYOOcXwwweJR2Hw9S9YHqCHINGzcj8+t7Obt+UYZzq/yIhoaWoYAqvCfVBmeas9SkB62BfeQjEvC2iGsrrw8lkro47loX5E9W9tsVQQ9JQKsu/vl/Gxgi44iwGONPNwo/+G2IB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=F6hpwTmy; arc=none smtp.client-ip=23.88.38.48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1782828395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aTEJtpajRVR1xlAcD16Paemh1ljeVO533G4fz7VgnPI=;
	b=F6hpwTmypsiDwCIokCMHp0WgVCgt864zdfUmB7xYBBrfosdGUyOKAUZ/I4ketNKXquo4lH
	NadtepDvONS7FQwV8fIpBsmHbKwIqvpn4C1YRIRrQe9LY3YbWGN+tl2Vhi0mgojNCEHGHq
	uVFKbYcPNKIhFEv4k6PjN4m7YXGkl3+hDsuUS4UDztMCn/vPCqrqOSbiNdoiYr5fR9w72d
	D5SGaUpnfkD79JDXLV8ivb+zRegiVYW3xe8U1H5NVzSHrgj9+VZP5CH5Qrt5WYAj5GJhxl
	1Lg1DkF5Prau1Fi9yYyVpjB2Zh4114B9Mi8vZSIOgFTSLKvY0Q88TV9GqkJNQQ==
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
Subject: [PATCH net-next 15/15] batman-adv: tp_meter: delay allocation of unacked entry
Date: Tue, 30 Jun 2026 16:06:23 +0200
Message-ID: <20260630140623.88431-16-sw@simonwunderlich.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-303227-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:b.a.t.m.a.n@lists.open-mesh.org,m:sven@narfation.org,m:sw@simonwunderlich.de,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,simonwunderlich.de:dkim,simonwunderlich.de:email,simonwunderlich.de:mid,simonwunderlich.de:from_mime,narfation.org:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 518FF6E5518

From: Sven Eckelmann <sven@narfation.org>

When batadv_tp_handle_out_of_order() searches the already existing list of
unacked packets, it can often find an entry to merge with. In this case, it
would be a waste of time and resources to allocate a batadv_tp_unacked
which is then immediately freed again.

Instead, search first through the list. Only when no mergeable entry could
be found, it is necessary to record the place to allocate+store the new
entry.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/tp_meter.c | 88 ++++++++++++++++++---------------------
 1 file changed, 41 insertions(+), 47 deletions(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index ffd3171d4b992..00467aa79de9d 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -1417,26 +1417,15 @@ static bool batadv_tp_handle_out_of_order(struct batadv_tp_receiver *tp_vars,
 					  u32 seqno, u32 payload_len)
 	__must_hold(&tp_vars->ack_seqno_lock)
 {
-	struct batadv_tp_unacked *un, *new;
+	struct list_head *pos = &tp_vars->unacked_list;
+	struct batadv_tp_unacked *new = NULL;
+	u32 end_seqno = seqno + payload_len;
 	struct batadv_tp_unacked *safe;
-	bool added = false;
-
-	new = kmalloc_obj(*new, GFP_ATOMIC);
-	if (unlikely(!new))
-		return false;
-
-	new->seqno = seqno;
-	new->len = payload_len;
-
-	/* if the list is empty immediately attach this new object */
-	if (list_empty(&tp_vars->unacked_list)) {
-		list_add(&new->list, &tp_vars->unacked_list);
-		tp_vars->unacked_count++;
-		return true;
-	}
+	struct batadv_tp_unacked *un;
 
-	/* otherwise loop over the list and either drop the packet because this
-	 * is a duplicate or store it at the right position.
+	/* loop over the list to find either an existing entry which the new
+	 * seqno range can be merged with or the position at which a new entry
+	 * has to be inserted.
 	 *
 	 * The iteration is done in the reverse way because it is likely that
 	 * the last received packet (the one being processed now) has a bigger
@@ -1444,7 +1433,7 @@ static bool batadv_tp_handle_out_of_order(struct batadv_tp_receiver *tp_vars,
 	 */
 	list_for_each_entry_reverse(un, &tp_vars->unacked_list, list) {
 		/* look for the right position - an un which is smaller */
-		if (batadv_seq_before(new->seqno, un->seqno))
+		if (batadv_seq_before(seqno, un->seqno))
 			continue;
 
 		/* smaller/equal seqno was found but they might be directly
@@ -1452,62 +1441,67 @@ static bool batadv_tp_handle_out_of_order(struct batadv_tp_receiver *tp_vars,
 		 *
 		 * It is already known that:
 		 *
-		 *	un->seqno <= new->seqno
+		 *	un->seqno <= seqno
 		 *
 		 * When establishing that:
 		 *
-		 *	new->seqno <= un->seqno + un->len
+		 *	seqno <= un->seqno + un->len
 		 *
 		 * Then it is not necessary to add a new entry because the
 		 * smaller/equal seqno of un might already contain the new
 		 * received packet or we only add new data directly after
 		 * the end of un. The latter can be identified using:
 		 *
-		 *	un->seqno + un->len <= new->seqno + new->len
+		 *	un->seqno + un->len <= end_seqno
 		 */
-		if (!batadv_seq_before(un->seqno + un->len, new->seqno)) {
+		if (!batadv_seq_before(un->seqno + un->len, seqno)) {
 			/* new data directly after un? */
-			if (!batadv_seq_before(new->seqno + new->len,
-					       un->seqno + un->len))
-				un->len = new->seqno + new->len - un->seqno;
+			if (!batadv_seq_before(end_seqno, un->seqno + un->len))
+				un->len = end_seqno - un->seqno;
 
-			/* un now represents both old un + new */
-			kfree(new);
-			added = true;
-
-			/* un has to be used to check if the gap to the next
-			 * seqno range was closed
+			/* un now represents both old un + new range and has to
+			 * be used to check if the gap to the next seqno range
+			 * was closed
 			 */
 			new = un;
-			break;
+		} else {
+			/* as soon as an entry having a smaller seqno is found,
+			 * the new one is attached _after_ it. In this way the
+			 * list is kept in ascending order
+			 */
+			pos = &un->list;
 		}
 
-		/* as soon as an entry having a smaller seqno is found, the new
-		 * one is attached _after_ it. In this way the list is kept in
-		 * ascending order
-		 */
-		list_add(&new->list, &un->list);
-		added = true;
-		tp_vars->unacked_count++;
 		break;
 	}
 
-	/* received packet with smallest seqno out of order; add it to front */
-	if (!added) {
-		list_add(&new->list, &tp_vars->unacked_list);
+	/* no entry to merge with was found; insert a new one after the entry
+	 * with the next smaller seqno (or at the front of the list when the
+	 * new seqno is the smallest or the list is empty)
+	 */
+	if (!new) {
+		new = kmalloc_obj(*new, GFP_ATOMIC);
+		if (unlikely(!new))
+			return false;
+
+		new->seqno = seqno;
+		new->len = payload_len;
+
+		list_add(&new->list, pos);
 		tp_vars->unacked_count++;
 	}
 
 	/* check if new filled the gap to the next list entries */
 	un = new;
 	list_for_each_entry_safe_continue(un, safe, &tp_vars->unacked_list, list) {
-		if (batadv_seq_before(new->seqno + new->len, un->seqno))
+		if (batadv_seq_before(end_seqno, un->seqno))
 			break;
 
 		/* next entry is overlapping or adjacent - combine both */
-		if (batadv_seq_before(new->seqno + new->len,
-				      un->seqno + un->len))
-			new->len = un->seqno + un->len - new->seqno;
+		if (batadv_seq_before(end_seqno, un->seqno + un->len)) {
+			end_seqno = un->seqno + un->len;
+			new->len = end_seqno - new->seqno;
+		}
 
 		list_del(&un->list);
 		kfree(un);
-- 
2.47.3


