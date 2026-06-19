Return-Path: <netdev+bounces-300635-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mBWBOHTrNGp1kAYAu9opvQ
	(envelope-from <netdev+bounces-300635-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 09:10:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AF06A4400
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 09:10:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=bEJhaM3t;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300635-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300635-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07DC3301014F
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 07:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FC63546C6;
	Fri, 19 Jun 2026 07:10:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394162F8EA3
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 07:10:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781853032; cv=none; b=D4wHMo5oPv0KOJIlkozk7Ofxt8p6J9wcfwxE/8Wwc+ycfIycp/nlvf/tEGlHEgcEwUBT+BZu87Q7hzmhJStJ48HlFcHdqD2ikXLrypF82Dm493ORofZfRkOLM6WXsnwQ3U0aVUMu4kzwqhOLt7cyvdCiHugKXiVumBvltP4y+HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781853032; c=relaxed/simple;
	bh=deXCpsB86/SQXAVTnAeLzXfKyMTqGUr2u2YP+erNrcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zh1ujGb3AQ1XCI4pKZFaHrtE0rHK4BilF79V8lpJlMu0aKy+wyvcm9H6S9pCJYUMrtW4vHb1MUxyIsr0X0uDj6NnTk78KS62lbzGGRU/etN/PWZpR5VaVpaRYLQSgQl+BZav4vSw9OSybFqyA9zKF7L+QYtBqd1HGTd/W6D8OVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=bEJhaM3t; arc=none smtp.client-ip=23.88.38.48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1781852447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qo0iYtAoCh7dGR3yHCIMed/owbEgbIwKhpDMlELxzWw=;
	b=bEJhaM3tV3Ir745fax8850NlyCjwpARi0UXkyIOjVWuXppiz+t8EinUOx9Ph2rO54kaGgT
	LSe17krS+6Q7q3qHw7VCrw+6KhQv9qMxu++tIzpVvAI99pvf0cMXUE7h1XRyHk91+qIsSB
	NxJQqfiw+pIJa75F9uMOloZcLD4egBGMV3fVlSrrZse197OX9JSyGzKZ/83sB/7jJ0kT6R
	bw7QiDOJ39kO+lmyjLQUpwKqQ9ipBjqiQcEt9bqANLeNffpnWj52eL0W1SYcQjPfE76vMH
	Ow5u3YRSWzy3Qvwy3NTs8DVuZ2Yl+Sej66yAVhgVCzzzwdI+Zd+1oSfiSSl4oA==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	stable@kernel.org,
	Nora Schiffer <neocturne@universe-factory.net>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 01/15] batman-adv: gw: don't deselect gateway with active hardif
Date: Fri, 19 Jun 2026 09:00:31 +0200
Message-ID: <20260619070045.438101-2-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260619070045.438101-1-sw@simonwunderlich.de>
References: <20260619070045.438101-1-sw@simonwunderlich.de>
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
	TAGGED_FROM(0.00)[bounces-300635-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:b.a.t.m.a.n@lists.open-mesh.org,m:sven@narfation.org,m:stable@kernel.org,m:neocturne@universe-factory.net,m:sw@simonwunderlich.de,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[simonwunderlich.de:dkim,simonwunderlich.de:email,simonwunderlich.de:mid,simonwunderlich.de:from_mime,narfation.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,universe-factory.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 44AF06A4400

From: Sven Eckelmann <sven@narfation.org>

The batadv_hardif_cnt() was previously checking if there is an
batadv_hard_iface->mesh_iface which is has the same mesh_iface. And since
batadv_hardif_disable_interface() was resetting the
batadv_hard_iface->mesh_iface after this check, it had to verify whether
*1* interface was still part of the mesh_iface before it started the
gateway deselection.

But after batadv_hardif_cnt() is now checking the lower interfaces of
mesh_iface and batadv_hardif_disable_interface() already removed the
interface via netdev_upper_dev_unlink() earlier in this function, the check
must now make sure that *0* interfaces can be found by batadv_hardif_cnt()
before selected gateway must be deselected. Otherwise the deselection would
already happen one batadv_hard_iface too early.

Because a 0 hardif count from batadv_hardif_cnt() is equal to an empty
list, it is possible to replace the counting with a simple list_empty().

Cc: stable@kernel.org
Fixes: 7dc284702bcd ("batman-adv: store hard_iface as iflink private data")
Reviewed-by: Nora Schiffer <neocturne@universe-factory.net>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/hard-interface.c | 28 ++--------------------------
 1 file changed, 2 insertions(+), 26 deletions(-)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 60cee2c2f2f41..03d01c20a9548 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -814,30 +814,6 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 	return ret;
 }
 
-/**
- * batadv_hardif_cnt() - get number of interfaces enslaved to mesh interface
- * @mesh_iface: mesh interface to check
- *
- * This function is only using RCU for locking - the result can therefore be
- * off when another function is modifying the list at the same time. The
- * caller can use the rtnl_lock to make sure that the count is accurate.
- *
- * Return: number of connected/enslaved hard interfaces
- */
-static size_t batadv_hardif_cnt(struct net_device *mesh_iface)
-{
-	struct batadv_hard_iface *hard_iface;
-	struct list_head *iter;
-	size_t count = 0;
-
-	rcu_read_lock();
-	netdev_for_each_lower_private_rcu(mesh_iface, hard_iface, iter)
-		count++;
-	rcu_read_unlock();
-
-	return count;
-}
-
 /**
  * batadv_hardif_disable_interface() - Remove hard interface from mesh interface
  * @hard_iface: hard interface to be removed
@@ -878,8 +854,8 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface)
 	netdev_upper_dev_unlink(hard_iface->net_dev, hard_iface->mesh_iface);
 	batadv_hardif_recalc_extra_skbroom(hard_iface->mesh_iface);
 
-	/* nobody uses this interface anymore */
-	if (batadv_hardif_cnt(hard_iface->mesh_iface) <= 1)
+	/* nobody uses this mesh interface anymore */
+	if (list_empty(&hard_iface->mesh_iface->adj_list.lower))
 		batadv_gw_check_client_stop(bat_priv);
 
 	hard_iface->mesh_iface = NULL;
-- 
2.47.3


