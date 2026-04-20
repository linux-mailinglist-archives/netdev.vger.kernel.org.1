Return-Path: <netdev+bounces-279845-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOTID+VK5mnSuQEAu9opvQ
	(envelope-from <netdev+bounces-279845-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 17:48:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D6B42E9B3
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 17:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8262C3295BDB
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 15:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C7F346FAE;
	Mon, 20 Apr 2026 14:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f98+hS6P"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383B8346A0C
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 14:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776697165; cv=none; b=GzGuORx49Xvo3FfGlYxtoGkpYhehdxBBFTuatpYUsHV5p8a0WQltMsun4lUZsf0id7A1iLmjRAzCab6YAy1dJcC4ff/iIdseGpswiAXDR/eBlgpOkyXYGITv+ifc73e7K0uQmKlhXFyeXNs55gC3/4wr2RxyWP18OhpUqwoquBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776697165; c=relaxed/simple;
	bh=v2zzwE6VyFTZPkgYuv9Co64r31ktBbRkcw1Qr1LfnPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dn6PYWbFWoybTuTF6cMiAchPz2g+1xv8XDGww31MUjHo4VYl+ZD6xhfYWAPgEKuXeIcbvNtrlcXwIcTUgleso4KWFYfMAHLqFgjbavW/VVTc+/0YxPwIw8sLsKtBTznB8tC/Y/O5U+Pzuxo5fOHDwdGqMnDKoUvqQJy1AizfgLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f98+hS6P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776697163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rmh45SXHj8wUhzhHKXRW6xTk8h2s31Ocg8BsaflyDFE=;
	b=f98+hS6POENjfhibYRAJOMpcfhWFIOV+5Caf3y37FXrha2ublDpKpdm+yzO6nmDlTRGdX3
	MAADLuTyyN28unF+daXnmYkVXcmtQqay9SNc5HgVXjRsK4Rc8mWC6ZgBt8KUZWe5LuWZDw
	/NZxKMr5de/pIJRKRobRTHy9blXU+k4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-144-VNl9UP2ENO2lJW066Xmf6Q-1; Mon,
 20 Apr 2026 10:59:20 -0400
X-MC-Unique: VNl9UP2ENO2lJW066Xmf6Q-1
X-Mimecast-MFC-AGG-ID: VNl9UP2ENO2lJW066Xmf6Q_1776697159
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F19E718001F9;
	Mon, 20 Apr 2026 14:59:18 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.48.17])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4ACDF3000C15;
	Mon, 20 Apr 2026 14:59:15 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jeffrey Altman <jaltman@auristor.com>,
	stable@kernel.org
Subject: [PATCH net 2/4] rxrpc: Fix conn-level packet handling to unshare RESPONSE packets
Date: Mon, 20 Apr 2026 15:58:55 +0100
Message-ID: <20260420145900.1223732-3-dhowells@redhat.com>
In-Reply-To: <20260420145900.1223732-1-dhowells@redhat.com>
References: <20260420145900.1223732-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279845-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.995];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[davemloft.net:email,auristor.com:email,sashiko.dev:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,infradead.org:email]
X-Rspamd-Queue-Id: 76D6B42E9B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The security operations that verify the RESPONSE packets decrypt bits of it
in place - however, the sk_buff may be shared with a packet sniffer, which
would lead to the sniffer seeing an apparently corrupt packet (actually
decrypted).

Fix this by unsharing the skbuff before handing it off to the specific
security handler.

Fixes: 17926a79320a ("[AF_RXRPC]: Provide secure RxRPC sockets for use by userspace and kernel both")
Closes: https://sashiko.dev/#/patchset/20260408121252.2249051-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
cc: stable@kernel.org
---
 net/rxrpc/ar-internal.h |  2 +-
 net/rxrpc/conn_event.c  | 12 ++++++++++--
 net/rxrpc/io_thread.c   | 15 +++------------
 net/rxrpc/skbuff.c      | 26 ++++++++++++++++++++++----
 4 files changed, 36 insertions(+), 19 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 96ecb83c9071..fb04d2ffdb27 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -1486,7 +1486,7 @@ int rxrpc_server_keyring(struct rxrpc_sock *, sockptr_t, int);
 void rxrpc_kernel_data_consumed(struct rxrpc_call *, struct sk_buff *);
 void rxrpc_new_skb(struct sk_buff *, enum rxrpc_skb_trace);
 void rxrpc_see_skb(struct sk_buff *, enum rxrpc_skb_trace);
-void rxrpc_eaten_skb(struct sk_buff *, enum rxrpc_skb_trace);
+struct sk_buff *rxrpc_unshare_skb(struct sk_buff **_old, gfp_t gfp);
 void rxrpc_get_skb(struct sk_buff *, enum rxrpc_skb_trace);
 void rxrpc_free_skb(struct sk_buff *, enum rxrpc_skb_trace);
 void rxrpc_purge_queue(struct sk_buff_head *);
diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
index 9a41ec708aeb..3d56a5d23369 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -244,8 +244,9 @@ static void rxrpc_call_is_secure(struct rxrpc_call *call)
  * connection-level Rx packet processor
  */
 static int rxrpc_process_event(struct rxrpc_connection *conn,
-			       struct sk_buff *skb)
+			       struct sk_buff **_skb)
 {
+	struct sk_buff *skb = *_skb;
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
 	bool secured = false;
 	int ret;
@@ -270,6 +271,13 @@ static int rxrpc_process_event(struct rxrpc_connection *conn,
 		}
 		spin_unlock_irq(&conn->state_lock);
 
+		skb = rxrpc_unshare_skb(_skb, GFP_NOFS);
+		if (!skb)
+			return -ENOMEM;
+
+		/* If unshared, skb will have changed. */
+		sp = rxrpc_skb(skb);
+
 		ret = conn->security->verify_response(conn, skb);
 		if (ret < 0)
 			return ret;
@@ -371,7 +379,7 @@ static void rxrpc_do_process_connection(struct rxrpc_connection *conn)
 	 * connection that each one has when we've finished with it */
 	while ((skb = skb_dequeue(&conn->rx_queue))) {
 		rxrpc_see_skb(skb, rxrpc_skb_see_conn_work);
-		ret = rxrpc_process_event(conn, skb);
+		ret = rxrpc_process_event(conn, &skb);
 		switch (ret) {
 		case -ENOMEM:
 		case -EAGAIN:
diff --git a/net/rxrpc/io_thread.c b/net/rxrpc/io_thread.c
index 697956931925..0592ce644fc3 100644
--- a/net/rxrpc/io_thread.c
+++ b/net/rxrpc/io_thread.c
@@ -249,19 +249,10 @@ static bool rxrpc_input_packet(struct rxrpc_local *local, struct sk_buff **_skb)
 		 * decryption.
 		 */
 		if (sp->hdr.securityIndex != 0) {
-			skb = skb_unshare(skb, GFP_ATOMIC);
-			if (!skb) {
-				rxrpc_eaten_skb(*_skb, rxrpc_skb_eaten_by_unshare_nomem);
-				*_skb = NULL;
+			skb = rxrpc_unshare_skb(_skb, GFP_ATOMIC);
+			if (!skb)
 				return just_discard;
-			}
-
-			if (skb != *_skb) {
-				rxrpc_eaten_skb(*_skb, rxrpc_skb_eaten_by_unshare);
-				*_skb = skb;
-				rxrpc_new_skb(skb, rxrpc_skb_new_unshared);
-				sp = rxrpc_skb(skb);
-			}
+			sp = rxrpc_skb(skb);
 		}
 		break;
 
diff --git a/net/rxrpc/skbuff.c b/net/rxrpc/skbuff.c
index 3bcd6ee80396..0dca9ca163f1 100644
--- a/net/rxrpc/skbuff.c
+++ b/net/rxrpc/skbuff.c
@@ -47,12 +47,30 @@ void rxrpc_get_skb(struct sk_buff *skb, enum rxrpc_skb_trace why)
 }
 
 /*
- * Note the dropping of a ref on a socket buffer by the core.
+ * Do the unsharing of a socket buffer, noting the event in the traces.
  */
-void rxrpc_eaten_skb(struct sk_buff *skb, enum rxrpc_skb_trace why)
+struct sk_buff *rxrpc_unshare_skb(struct sk_buff **_old, gfp_t gfp)
 {
-	int n = atomic_inc_return(&rxrpc_n_rx_skbs);
-	trace_rxrpc_skb(skb, 0, n, why);
+	struct sk_buff *skb, *old = *_old;
+	int n, r = refcount_read(&old->users);
+
+	skb = skb_unshare(old, gfp);
+	if (!skb) {
+		n = atomic_dec_return(&rxrpc_n_rx_skbs);
+		trace_rxrpc_skb(old, r, n, rxrpc_skb_eaten_by_unshare_nomem);
+		*_old = NULL;
+		return skb;
+	}
+
+	if (skb != old) {
+		n = atomic_read(&rxrpc_n_rx_skbs);
+		trace_rxrpc_skb(old, r, n, rxrpc_skb_eaten_by_unshare);
+		trace_rxrpc_skb(skb, refcount_read(&skb->users), n,
+				rxrpc_skb_new_unshared);
+		*_old = skb;
+	}
+
+	return skb;
 }
 
 /*


