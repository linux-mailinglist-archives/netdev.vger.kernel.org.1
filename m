Return-Path: <netdev+bounces-300450-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NAGBHk/3M2qaJwYAu9opvQ
	(envelope-from <netdev+bounces-300450-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 15:49:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA7F6A0B38
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 15:49:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=TEy9CJuK;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300450-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300450-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8CD0F300AD69
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 13:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F1E2D9ECA;
	Thu, 18 Jun 2026 13:48:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C14A3EB106
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 13:48:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781790530; cv=none; b=L8/B8UpudXgu8lgZPAwcZ4V4UKCjHsujLtsNaC8GN8rxOfVkB8WWCsgNdVjEsvqGokBXoXpabsuGrsdWnMWeJ4k2i7RToLQsVskjmsPJlDeFPLU4TaRDkgG0+4h15WPR6FXaJf07eYGmC5R8NFMjpzP5KGlqsoonT0PZUfFZ1RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781790530; c=relaxed/simple;
	bh=rotCMyiMX3ntk5IOsLiEVZzu/SI6r8sqcrQ1Bsncrbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lEivM0cnqnBOazYlpWsCwf8A+oCN7Aexffu7Kurwe4jJ9M34qzzDG2gEgBzPf/JDbvELOJ3upmXFqqc4+5xv4x3GuE2aTUWy2FvPHPQKV16JaQUbjeIHM3Cv/lABlS77F4b0qWLxz36W34Pi4dPMUvZPMd5OFmVlmN09b8PNPVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TEy9CJuK; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781790528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=awuaPknAwPjwJON1sB0uE4nSVnyNtBONJoAg7/XoWrg=;
	b=TEy9CJuKpXRl5ezUzrX5htg/XZPxGcCB+nlb9dA23aHvF/ct+lcbznA9zh4rMA0Nzj+XFS
	5WsX5zN774HSUpDqYswtrjM9wBXGAF3jABuYlylIIyuKaQWJ3QYx2ZDGze9yN2a8mimT6u
	j80mxSaTCE1T6C8AcGDYZKkLddHLCW8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-439-yCwp4GV3NGqOaTaXclFMEw-1; Thu,
 18 Jun 2026 09:48:45 -0400
X-MC-Unique: yCwp4GV3NGqOaTaXclFMEw-1
X-Mimecast-MFC-AGG-ID: yCwp4GV3NGqOaTaXclFMEw_1781790523
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 86E52195DBAE;
	Thu, 18 Jun 2026 13:48:43 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.50.44])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5D7463000235;
	Thu, 18 Jun 2026 13:48:39 +0000 (UTC)
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
Subject: [PATCH net v2 06/10] rxrpc: Fix the reception of a reply packet before data transmission
Date: Thu, 18 Jun 2026 14:47:57 +0100
Message-ID: <20260618134802.2477777-7-dhowells@redhat.com>
In-Reply-To: <20260618134802.2477777-1-dhowells@redhat.com>
References: <20260618134802.2477777-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300450-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:dhowells@redhat.com,m:marc.dionne@auristor.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-afs@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:jaltman@auristor.com,m:stable@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[auristor.com:email,vger.kernel.org:from_smtp,davemloft.net:email,sashiko.dev:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ABA7F6A0B38

Fix rxrpc_receiving_reply() to handle the reception of an apparent reply
DATA packet before rxrpc has had a chance to send any request DATA packets
on a client call by checking to see if the call has been exposed yet by
sending the first packet.

Without this, rxrpc_rotate_tx_window() might oops.

Also fix rxrpc_rotate_tx_window() to handle the Tx queue being empty by
changing the do...while loop into a while loop, just in case a call is
abnormally terminated by an early reply before the last request packet is
transmitted.

Fixes: b341a0263b1b ("rxrpc: Implement progressive transmission queue struct")
Link: https://sashiko.dev/#/patchset/20260616155749.2125907-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: stable@kernel.org
---
 net/rxrpc/input.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 37881dffa898..01ccd2d2fe92 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -247,7 +247,7 @@ static bool rxrpc_rotate_tx_window(struct rxrpc_call *call, rxrpc_seq_t to,
 		tq = call->tx_queue;
 	}
 
-	do {
+	while (before_eq(seq, to)) {
 		unsigned int ix = seq - call->tx_qbase;
 
 		_debug("tq=%x seq=%x i=%d f=%x", tq->qbase, seq, ix, tq->bufs[ix]->flags);
@@ -317,8 +317,7 @@ static bool rxrpc_rotate_tx_window(struct rxrpc_call *call, rxrpc_seq_t to,
 				break;
 			}
 		}
-
-	} while (before_eq(seq, to));
+	}
 
 	if (trace)
 		trace_rxrpc_rack_update(call, summary);
@@ -392,6 +391,14 @@ static bool rxrpc_receiving_reply(struct rxrpc_call *call)
 		trace_rxrpc_timer_can(call, rxrpc_timer_trace_delayed_ack);
 	}
 
+	/* Deal with an apparent reply coming in before we've got the request
+	 * queued or transmitted.
+	 */
+	if (!test_bit(RXRPC_CALL_EXPOSED, &call->flags)) {
+		rxrpc_proto_abort(call, top, rxrpc_eproto_early_reply);
+		return false;
+	}
+
 	if (!test_bit(RXRPC_CALL_TX_LAST, &call->flags)) {
 		if (!rxrpc_rotate_tx_window(call, top, &summary)) {
 			rxrpc_proto_abort(call, top, rxrpc_eproto_early_reply);


