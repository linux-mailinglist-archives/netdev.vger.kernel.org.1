Return-Path: <netdev+bounces-287530-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFYoEHhZBGozHQIAu9opvQ
	(envelope-from <netdev+bounces-287530-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 12:59:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A318B531C2B
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 12:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A21A310DBB5
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 10:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D603F9F55;
	Wed, 13 May 2026 10:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cvgvUuDZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD7A3F7AA8
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 10:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778669732; cv=none; b=usveUggLf7yVR8GV9bVffXFUk0pz0trFlVq7LwSIfhKlwKKoaScbck8RFU0C6bDGlxvTZY0cDrd686D+guIY0GrB133QCqIdzZugwIFXYtvIh9svF2P4rAF95y5Lm2QSF1M/gKheINB1p6s6AAOQQ7Bgh2dh8Kt1FD6ORlL6jx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778669732; c=relaxed/simple;
	bh=4GcPtw6yzDT+uQnJcBvUSlSFbsL2VlMJq3G4QuXz/kI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E1/TGhO4Ag4XfsdAq4wwDJEiZhZEBdEz9dmKCWNpzDrYihGU/zFzuUkzayE6HEt7GEuGwAeGaKHoBIBDZ5D8moG+XmhulnP1S+OSZz8tSaDWaDDbMK5sRyZRWHsXA3CzVRRDcHeP4fa14dKuS4obD3Du4QiSS07uFsGWmj96dlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cvgvUuDZ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso45192045e9.0
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 03:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778669729; x=1779274529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cnMgQIZVl3j9s1upPLydgLf3EqbcIw1LZyyGapADhuc=;
        b=cvgvUuDZG/D/3UdSHjNj8yyuyqKtgXmSHCM8zhqYQF1M0lI+ZUppWC9VVgtjkJmP4h
         N4it0ypyC74vPDPPIulBAbtKbXXdpgWB3rML/2Z+u+AMfrF/ZlnsQIsAiwK3OssljvVe
         XdepxNGFCn2DXad48DkTH9F6zRSm6Aa6RpOy6PomD0Pmx7iGOQJ7wPS6t0z2K5TSgkEg
         Qlad0fVEdehn8RPuUa62uNi4jVfPbdewZdIagK/YOzzL7FREfdqfKGzUz1ISnie7FsnE
         DLYEVxTY3bqXtKx9jjyDdFnrBE8MzVWyudgOG92+nWvbPgl3A5oI7m8PaODXTRgeQwAR
         T8Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778669729; x=1779274529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cnMgQIZVl3j9s1upPLydgLf3EqbcIw1LZyyGapADhuc=;
        b=X5lrs3CgIYW7ldzDd3R/iK3/uxtkSyYVEaaLo70vQn1rVIaJxMTxKs9d9Y46EFbLKO
         sEX5A/AFFbvLdOS+NJc0G9GU39UDIHIQ1IrGb6bq44is24dgUG7vRB1FyQ17QfGRkTmU
         eK2TahaKwMf0SLYZ/QFaAu087ZjKthm6I3Z67+upAVyRovaym8f4nVID9BZaPm9r/QJG
         pidUjsF5aLWXG4voMXotxlL3AwcWV+zgGm4sNXW5R0dc2s2MrmQ9zIiGTWjtOFc2cnlr
         5f37vUKA9ynYO1JFyOHC9GbmauQr74Eqw//gnLb0eQkpE0JBhfwb43+rtQxjjGREWjuh
         ulKw==
X-Gm-Message-State: AOJu0Yz6uhWqhcAImyqDaRYgfaDxi+2GHr8HNXxW1T79D9kBlATsv/gV
	O//1gEskILiDC4mMbnL0tg3am5AaPyrKp4iv9F7sv/fJXQFYBjRlg0AVYsym4mTn3XY=
X-Gm-Gg: Acq92OHpEqKTln3qW2DN/99PpY2H3nXX/SPy5ObWl0Smo/dbB9P1f7Fa5UXBl9s/2sC
	TPKCYWYWTBwqPZnyTn/VCoZmR3xVeuPVx3iGj3m/CSvHA7RZIlKPngL0GQNbl/kGn4HnDVIFVXQ
	ru8eyPh3gtMTTxhRhVASTsxdYSVs+LOF8rrPxmXbIbJdFiNRX89LurRVlGjnbScOpaQ249AWXCq
	b+A9xdn00xg4Pa9cNKk3hD/MokbsbPqHzEPI1QfsQB8NXACtdsWql99Pv9bveFgWIAdymt/lsDR
	KK4j40amdbgwz7xkTAEtfmkutElRrRqZIN/pB9UggN9SVOLiRh11spNs3kvBZhe47kZnmEfsPrj
	qPYV6clooRR5WAAXnNkGsIYQ43mD8ttWZa9l5MjP5kB0Bxkn745kk5/W9R5BRZVJQP7/GdOz+1k
	XOO6b9irPyAI3dp/424FqxfAIc+Qw86hzw+xuAdQS7Vqxk2flt7AMVVXVq9uGQeIprh6fEJ1D1O
	0kuuZAeEfA=
X-Received: by 2002:a05:600c:3ba8:b0:48a:6798:52e9 with SMTP id 5b1f17b1804b1-48fc99a8bd4mr40049135e9.0.1778669729093;
        Wed, 13 May 2026 03:55:29 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f438890sm46688195e9.23.2026.05.13.03.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 03:55:28 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: netdev@vger.kernel.org
Cc: David Carlier <devnexen@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Antonio Quartulli <antonio@openvpn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] ovpn: respect peer refcount in CMD_NEW_PEER error path
Date: Wed, 13 May 2026 11:55:21 +0100
Message-ID: <20260513105521.21629-3-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512042036.19870-1-devnexen@gmail.com>
References: <20260512042036.19870-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A318B531C2B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,queasysnail.net,openvpn.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287530-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,queasysnail.net:email]
X-Rspamd-Action: no action

ovpn_nl_peer_new_doit()'s error path calls ovpn_peer_release() directly
rather than ovpn_peer_put(), bypassing the kref. The accompanying
comment ("peer was not yet hashed, thus it is not used in any context")
holds for UDP but not for TCP.

For UDP, the ovpn_socket union uses the .ovpn arm and never points back
at a peer; UDP encap_recv looks up peers via the not-yet-populated
hashtables, so the new peer is unreachable until ovpn_peer_add()
publishes it.

For TCP, ovpn_socket_new() sets ovpn_sock->peer and
ovpn_tcp_socket_attach() publishes ovpn_sock via rcu_assign_sk_user_data().
From that moment until ovpn_socket_release() detaches in the error path,
the TCP fd is fully wired: userspace recvmsg / sendmsg / close / poll
on the fd, as well as the strparser-driven ovpn_tcp_rcv() path, can
reach the peer through sk_user_data -> ovpn_sock->peer and bump its
refcount via ovpn_peer_hold().

ovpn_tcp_socket_wait_finish() (called inside ovpn_socket_release())
drains strparser and the tx work, but does not synchronize with
userspace syscall callers that already hold a peer reference. If
ovpn_nl_peer_modify() or ovpn_peer_add() returns an error while such
a caller is in flight - notably an ovpn_tcp_recvmsg() blocked in
__skb_recv_datagram() on peer->tcp.user_queue - the direct
ovpn_peer_release() destroys the peer while the caller still holds
the reference, and the eventual ovpn_peer_put() from that caller
operates on freed memory.

Replace the direct destructor call with ovpn_peer_put() so the kref
correctly defers destruction until the last reference is dropped.
In the common case where no concurrent user is present, behaviour is
unchanged: the kref hits zero immediately and ovpn_peer_release_kref()
runs the same destructor.

With this conversion ovpn_peer_release() has no callers outside peer.c
- ovpn_peer_release_kref() in the same translation unit is the only
remaining user - so make it static and drop its declaration from
peer.h.

Fixes: 11851cbd60ea ("ovpn: implement TCP transport")
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: David Carlier <devnexen@gmail.com>
---

v2:
- Make ovpn_peer_release() static and drop its declaration from
  peer.h, since the netlink callsite was the last external user
  (Sabrina Dubroca, Antonio Quartulli)
- Add Reviewed-by from Sabrina Dubroca

 drivers/net/ovpn/netlink.c | 8 +++++---
 drivers/net/ovpn/peer.c    | 2 +-
 drivers/net/ovpn/peer.h    | 1 -
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 291e2e5bb450..4c66c1ec497e 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -462,10 +462,12 @@ int ovpn_nl_peer_new_doit(struct sk_buff *skb, struct genl_info *info)
 sock_release:
 	ovpn_socket_release(peer);
 peer_release:
-	/* release right away because peer was not yet hashed, thus it is not
-	 * used in any context
+	/* For UDP, the peer is unreachable until added to the hashtables, so
+	 * dropping the initial reference is enough. For TCP, the peer may be
+	 * concurrently reachable via sk_user_data->peer until
+	 * ovpn_socket_release() detaches; rely on the refcount.
 	 */
-	ovpn_peer_release(peer);
+	ovpn_peer_put(peer);
 
 	return ret;
 }
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index c02dfab51a6e..fb10d1fea940 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -354,7 +354,7 @@ static void ovpn_peer_release_rcu(struct rcu_head *head)
  * ovpn_peer_release - release peer private members
  * @peer: the peer to release
  */
-void ovpn_peer_release(struct ovpn_peer *peer)
+static void ovpn_peer_release(struct ovpn_peer *peer)
 {
 	ovpn_crypto_state_release(&peer->crypto);
 	spin_lock_bh(&peer->lock);
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index 328401570cba..86c8cffada6d 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -127,7 +127,6 @@ static inline bool ovpn_peer_hold(struct ovpn_peer *peer)
 	return kref_get_unless_zero(&peer->refcount);
 }
 
-void ovpn_peer_release(struct ovpn_peer *peer);
 void ovpn_peer_release_kref(struct kref *kref);
 
 /**
-- 
2.53.0


