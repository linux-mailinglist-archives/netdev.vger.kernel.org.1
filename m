Return-Path: <netdev+bounces-275569-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0P5yNuyT02lWjQcAu9opvQ
	(envelope-from <netdev+bounces-275569-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 13:07:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA3F3A3029
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 13:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E68930131F1
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 11:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300BE32B9B6;
	Mon,  6 Apr 2026 11:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="h6KH5i83";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="lvUc7MNo"
X-Original-To: netdev@vger.kernel.org
Received: from mout-y-111.mailbox.org (mout-y-111.mailbox.org [91.198.250.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51570326D51;
	Mon,  6 Apr 2026 11:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775473639; cv=none; b=tF+r7Mvs5IFbNTfLCCP1x7vrQi0qbgq03dGTnWygmEYSebLqO28QoGArIzS8eLoAbDvX0ljMvY9qZTgmDP0J3nQmncBplkI+vaOtb7BZ2vygVdbmKdDrm5UjiOJnTgOWCMlK4WQUha0zwISLZEEfeBvgTmdX5AIn9SQyilrm4kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775473639; c=relaxed/simple;
	bh=Pl7psMzVLBWg6J7a9LAcR93gvmbHLeURT7l9qIIb13g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dAoZCptqQjT62UxYl30UdOelYbosgAyBNRmbuwgiUcRSxsl63J/RDaOmd8pBt3lyvSO+0iLBH7BWaqqVR2h5mxWPcth2H03GHMJ7o5bs1zPGxt41IDLAP90x3J6K1LWVOQkx+Gfk+v0V549fGJ0jNQfwcYYJgjkRnZ6y9I7MTY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=h6KH5i83; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=lvUc7MNo; arc=none smtp.client-ip=91.198.250.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-111.mailbox.org (Postfix) with ESMTPS id 4fq63j0Nx5z9yYb;
	Mon,  6 Apr 2026 13:07:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775473633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MV9ewTCU8yA1OtyEEcEEBGefH6ug2nKUucYsk6u1mbo=;
	b=h6KH5i835qrr17MQBvXpg5BnYeXZ5ZhigHTgL6Ab7Cdt7SGAKx3CEA22C+Tdbh5KcyKHHL
	vstvvHeopOoNwWefYWUF321ueooKdSBzb6Gwuzw6qf9CLfLA5DrEg2zYIfMlNIKj3oTqtf
	8F23Nd3ii1UGVxUxFqMPpMcJpZwBFcNf3CTitoryJNWwG8AxKeh+2f9ntr57PAyhZI+v4/
	SipGsyST6Hd7aioqd7w9uGhKFQn0PYYCevg/lp8y/TXdgA7j657R3u+CJfY97Xk+z5yi7b
	YdUrpdVI9C5+z7Z6sM86/qlooOgW+8ydSDSCRYafqn25VIQT3dCA7r/jdU8lCA==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=lvUc7MNo;
	spf=pass (outgoing_mbo_mout: domain of mashiro.chen@mailbox.org designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=mashiro.chen@mailbox.org
From: Mashiro Chen <mashiro.chen@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775473630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MV9ewTCU8yA1OtyEEcEEBGefH6ug2nKUucYsk6u1mbo=;
	b=lvUc7MNoJyWeolEDDXir3bd6eO2l01ZmNnkVyq02pKPed3JKZzzvsaHrxwIUWipDv5jJr2
	+PJFKJ5/daTAbgKyRu+A3ITJyT3ifL0Qdeji7VpaCzUFSJFKJEfwDOx4s/DW3qAPza9blC
	m0GzxXS7U4IIporyItyxTcS1PTqfC2PY2bG1KCobJt+mkjmImzL3pco1Te8WdQy148pBm0
	aAacIKVukB9Y6kvYJxwuRjiOyAjNujATKWu38fYHXp7gLfdRWD9jx5m0g0MMzWYGISgckV
	g/pJbbx9szTgGbegCZ+ujoJqwjS0w5zbp9HmrZ4nr45E6kFRWlP2HO9vCj/I/Q==
To: netdev@vger.kernel.org
Cc: linux-hams@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+6eb7834837cf6a8db75b@syzkaller.appspotmail.com,
	Mashiro Chen <mashiro.chen@mailbox.org>
Subject: [PATCH net] net: netrom: fix lock order inversion in nr_add_node, nr_del_node and nr_dec_obs
Date: Mon,  6 Apr 2026 19:06:43 +0800
Message-ID: <20260406110643.82577-1-mashiro.chen@mailbox.org>
In-Reply-To: <69694d6f.050a0220.58bed.0028.GAE@google.com>
References: <69694d6f.050a0220.58bed.0028.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 95idu45wsgpu49zizfifrho3rpyazy87
X-MBO-RS-ID: e9666827e3739db0806
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275569-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[mailbox.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mashiro.chen@mailbox.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,6eb7834837cf6a8db75b];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mailbox.org:dkim,mailbox.org:email,mailbox.org:mid,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 3CA3F3A3029
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nr_del_node() and nr_dec_obs() acquire nr_node_list_lock first, then
call nr_remove_neigh() which internally acquires nr_neigh_list_lock.
nr_add_node() acquires node_lock first, then calls nr_remove_neigh()
which acquires nr_neigh_list_lock.

Both are the reverse of the lock order used in nr_rt_device_down() and
nr_rt_free(), which acquire nr_neigh_list_lock before nr_node_list_lock
and node_lock.

The resulting lock order inversions can cause an ABBA deadlock when
concurrently executing:
  - SIOCDELRT or SIOCNRDECOBS ioctl (requires CAP_NET_ADMIN)
  - bringing down a NET/ROM-attached network device

Fix by acquiring nr_neigh_list_lock before nr_node_list_lock and
node_lock in all three functions, following the canonical lock order,
and replacing the internal-locking nr_remove_neigh() with
nr_remove_neigh_locked() which assumes the caller already holds
nr_neigh_list_lock.

Fixes: e03e7f20ebf7 ("netrom: fix possible dead-lock in nr_rt_ioctl()")
Reported-by: syzbot+6eb7834837cf6a8db75b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6eb7834837cf6a8db75b
Signed-off-by: Mashiro Chen <mashiro.chen@mailbox.org>
---
 net/netrom/nr_route.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/netrom/nr_route.c b/net/netrom/nr_route.c
index 9cc29ae85b06f..5bc24644ed544 100644
--- a/net/netrom/nr_route.c
+++ b/net/netrom/nr_route.c
@@ -211,6 +211,7 @@ static int __must_check nr_add_node(ax25_address *nr, const char *mnemonic,
 		nr_neigh_put(nr_neigh);
 		return 0;
 	}
+	spin_lock_bh(&nr_neigh_list_lock);
 	nr_node_lock(nr_node);
 
 	if (quality != 0)
@@ -246,7 +247,7 @@ static int __must_check nr_add_node(ax25_address *nr, const char *mnemonic,
 				nr_neigh_put(nr_node->routes[2].neighbour);
 
 				if (nr_node->routes[2].neighbour->count == 0 && !nr_node->routes[2].neighbour->locked)
-					nr_remove_neigh(nr_node->routes[2].neighbour);
+					nr_remove_neigh_locked(nr_node->routes[2].neighbour);
 
 				nr_node->routes[2].quality   = quality;
 				nr_node->routes[2].obs_count = obs_count;
@@ -281,6 +282,7 @@ static int __must_check nr_add_node(ax25_address *nr, const char *mnemonic,
 
 	nr_neigh_put(nr_neigh);
 	nr_node_unlock(nr_node);
+	spin_unlock_bh(&nr_neigh_list_lock);
 	nr_node_put(nr_node);
 	return 0;
 }
@@ -331,6 +333,7 @@ static int nr_del_node(ax25_address *callsign, ax25_address *neighbour, struct n
 		return -EINVAL;
 	}
 
+	spin_lock_bh(&nr_neigh_list_lock);
 	spin_lock_bh(&nr_node_list_lock);
 	nr_node_lock(nr_node);
 	for (i = 0; i < nr_node->count; i++) {
@@ -339,7 +342,7 @@ static int nr_del_node(ax25_address *callsign, ax25_address *neighbour, struct n
 			nr_neigh_put(nr_neigh);
 
 			if (nr_neigh->count == 0 && !nr_neigh->locked)
-				nr_remove_neigh(nr_neigh);
+				nr_remove_neigh_locked(nr_neigh);
 			nr_neigh_put(nr_neigh);
 
 			nr_node->count--;
@@ -361,6 +364,7 @@ static int nr_del_node(ax25_address *callsign, ax25_address *neighbour, struct n
 			}
 			nr_node_unlock(nr_node);
 			spin_unlock_bh(&nr_node_list_lock);
+			spin_unlock_bh(&nr_neigh_list_lock);
 
 			return 0;
 		}
@@ -368,6 +372,7 @@ static int nr_del_node(ax25_address *callsign, ax25_address *neighbour, struct n
 	nr_neigh_put(nr_neigh);
 	nr_node_unlock(nr_node);
 	spin_unlock_bh(&nr_node_list_lock);
+	spin_unlock_bh(&nr_neigh_list_lock);
 	nr_node_put(nr_node);
 
 	return -EINVAL;
@@ -454,6 +459,7 @@ static int nr_dec_obs(void)
 	struct hlist_node *nodet;
 	int i;
 
+	spin_lock_bh(&nr_neigh_list_lock);
 	spin_lock_bh(&nr_node_list_lock);
 	nr_node_for_each_safe(s, nodet, &nr_node_list) {
 		nr_node_lock(s);
@@ -469,7 +475,7 @@ static int nr_dec_obs(void)
 				nr_neigh_put(nr_neigh);
 
 				if (nr_neigh->count == 0 && !nr_neigh->locked)
-					nr_remove_neigh(nr_neigh);
+					nr_remove_neigh_locked(nr_neigh);
 
 				s->count--;
 
@@ -497,6 +503,7 @@ static int nr_dec_obs(void)
 		nr_node_unlock(s);
 	}
 	spin_unlock_bh(&nr_node_list_lock);
+	spin_unlock_bh(&nr_neigh_list_lock);
 
 	return 0;
 }
-- 
2.53.0


