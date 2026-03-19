Return-Path: <netdev+bounces-269482-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHJUGtYQvGnbrwIAu9opvQ
	(envelope-from <netdev+bounces-269482-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:05:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8DE2CD625
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7781F3039EFB
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 15:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF012DA776;
	Thu, 19 Mar 2026 15:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FHBCrzlS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C404366DD6
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 15:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773932568; cv=none; b=j3/OverMEr0nAKxFnedXGKa1C+nc9QUSAyRbKTa7a1t0ze5hS7xczvuiZTvBoaZUinSkCQkytTaN7UjvtSQ7szLThwNoWoxBTMoEWkjLNV5jZ7knFXWKz5KDpRVS9QzqTxn/+VR6U33i7OwrWePFVAePivmZYbmJ9dZSpo4vUe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773932568; c=relaxed/simple;
	bh=GLd4qfXuiZlmFgoBnEIpAEMmRw0SwUkeo0/6dC1W5Lg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dDYXDvQBHtxcVSroJE4TekuJm37NAqvz8Mbn8oxYrrnW+/dV7Pt/me5rSHqCwzeeu2EIkB1I3YisL2BTpKJ4rMMim6vRpnxxna/wXqcNMEhwP9qPbd/hCr2SKVWrKY8u4WFUim4YYUhSJELa4Ee5cO84PQ498KfbLcB2jFiLe1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FHBCrzlS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773932566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qeCoRrsqHiEQgKw5Tn8Q3ISupxkgu6z3xAFPorUcwac=;
	b=FHBCrzlS9rjGlkRO+TWYRqluTaDelpFVg2HpTr2HKQBfhY6qFCIIFq991XHmNdRay2gmov
	FmH3xnKAjA3FIGBWiCxXEQsFbvSr9sqertNXt/qwlEW5zNLWovuFeDbKGHGbxljvGFpgAs
	Ue29ys9MekScFJj2c1dBwfPHYySZjcY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-9gM4NXuRN8uRQsBEk0ixxQ-1; Thu,
 19 Mar 2026 11:02:43 -0400
X-MC-Unique: 9gM4NXuRN8uRQsBEk0ixxQ-1
X-Mimecast-MFC-AGG-ID: 9gM4NXuRN8uRQsBEk0ixxQ_1773932561
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7C7141800283;
	Thu, 19 Mar 2026 15:02:40 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.45.224.65])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 81A991800107;
	Thu, 19 Mar 2026 15:02:36 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Oleh Konko <security@1seal.org>,
	Jeffrey Altman <jaltman@auristor.com>,
	Simon Horman <horms@kernel.org>,
	stable@kernel.org
Subject: [PATCH net 1/5] rxrpc: Fix RxGK token loading to check bounds
Date: Thu, 19 Mar 2026 15:01:41 +0000
Message-ID: <20260319150150.4189381-2-dhowells@redhat.com>
In-Reply-To: <20260319150150.4189381-1-dhowells@redhat.com>
References: <20260319150150.4189381-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269482-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.977];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,davemloft.net:email,auristor.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,1seal.org:email]
X-Rspamd-Queue-Id: 5C8DE2CD625
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Oleh Konko <security@1seal.org>

rxrpc_preparse_xdr_yfs_rxgk() reads the raw key length and ticket length
from the XDR token as u32 values and passes each through round_up(x, 4)
before using the rounded value for validation and allocation.  When the raw
length is >= 0xfffffffd, round_up() wraps to 0, so the bounds check and
kzalloc both use 0 while the subsequent memcpy still copies the original
~4 GiB value, producing a heap buffer overflow reachable from an
unprivileged add_key() call.

Fix this by:

 (1) Rejecting raw key lengths above AFSTOKEN_GK_KEY_MAX and raw ticket
     lengths above AFSTOKEN_GK_TOKEN_MAX before rounding, consistent with
     the caps that the RxKAD path already enforces via AFSTOKEN_RK_TIX_MAX.

 (2) Sizing the flexible-array allocation from the validated raw key
     length via struct_size_t() instead of the rounded value.

 (3) Caching the raw lengths so that the later field assignments and
     memcpy calls do not re-read from the token, eliminating a class of
     TOCTOU re-parse.

The control path (valid token with lengths within bounds) is unaffected.

Fixes: 0ca100ff4df6 ("rxrpc: Add YFS RxGK (GSSAPI) security class")
Signed-off-by: Oleh Konko <security@1seal.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeffrey Altman <jaltman@auristor.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
cc: stable@kernel.org
---
 net/rxrpc/key.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/net/rxrpc/key.c b/net/rxrpc/key.c
index 85078114b2dd..c96e1d8f4845 100644
--- a/net/rxrpc/key.c
+++ b/net/rxrpc/key.c
@@ -13,6 +13,7 @@
 #include <crypto/skcipher.h>
 #include <linux/module.h>
 #include <linux/net.h>
+#include <linux/overflow.h>
 #include <linux/skbuff.h>
 #include <linux/key-type.h>
 #include <linux/ctype.h>
@@ -171,7 +172,7 @@ static int rxrpc_preparse_xdr_yfs_rxgk(struct key_preparsed_payload *prep,
 	size_t plen;
 	const __be32 *ticket, *key;
 	s64 tmp;
-	u32 tktlen, keylen;
+	size_t raw_keylen, raw_tktlen, keylen, tktlen;
 
 	_enter(",{%x,%x,%x,%x},%x",
 	       ntohl(xdr[0]), ntohl(xdr[1]), ntohl(xdr[2]), ntohl(xdr[3]),
@@ -181,18 +182,22 @@ static int rxrpc_preparse_xdr_yfs_rxgk(struct key_preparsed_payload *prep,
 		goto reject;
 
 	key = xdr + (6 * 2 + 1);
-	keylen = ntohl(key[-1]);
-	_debug("keylen: %x", keylen);
-	keylen = round_up(keylen, 4);
+	raw_keylen = ntohl(key[-1]);
+	_debug("keylen: %zx", raw_keylen);
+	if (raw_keylen > AFSTOKEN_GK_KEY_MAX)
+		goto reject;
+	keylen = round_up(raw_keylen, 4);
 	if ((6 * 2 + 2) * 4 + keylen > toklen)
 		goto reject;
 
 	ticket = xdr + (6 * 2 + 1 + (keylen / 4) + 1);
-	tktlen = ntohl(ticket[-1]);
-	_debug("tktlen: %x", tktlen);
-	tktlen = round_up(tktlen, 4);
+	raw_tktlen = ntohl(ticket[-1]);
+	_debug("tktlen: %zx", raw_tktlen);
+	if (raw_tktlen > AFSTOKEN_GK_TOKEN_MAX)
+		goto reject;
+	tktlen = round_up(raw_tktlen, 4);
 	if ((6 * 2 + 2) * 4 + keylen + tktlen != toklen) {
-		kleave(" = -EKEYREJECTED [%x!=%x, %x,%x]",
+		kleave(" = -EKEYREJECTED [%zx!=%x, %zx,%zx]",
 		       (6 * 2 + 2) * 4 + keylen + tktlen, toklen,
 		       keylen, tktlen);
 		goto reject;
@@ -206,7 +211,7 @@ static int rxrpc_preparse_xdr_yfs_rxgk(struct key_preparsed_payload *prep,
 	if (!token)
 		goto nomem;
 
-	token->rxgk = kzalloc(sizeof(*token->rxgk) + keylen, GFP_KERNEL);
+	token->rxgk = kzalloc(struct_size_t(struct rxgk_key, _key, raw_keylen), GFP_KERNEL);
 	if (!token->rxgk)
 		goto nomem_token;
 
@@ -221,9 +226,9 @@ static int rxrpc_preparse_xdr_yfs_rxgk(struct key_preparsed_payload *prep,
 	token->rxgk->enctype	= tmp = xdr_dec64(xdr + 5 * 2);
 	if (tmp < 0 || tmp > UINT_MAX)
 		goto reject_token;
-	token->rxgk->key.len	= ntohl(key[-1]);
+	token->rxgk->key.len	= raw_keylen;
 	token->rxgk->key.data	= token->rxgk->_key;
-	token->rxgk->ticket.len = ntohl(ticket[-1]);
+	token->rxgk->ticket.len = raw_tktlen;
 
 	if (token->rxgk->endtime != 0) {
 		expiry = rxrpc_s64_to_time64(token->rxgk->endtime);
@@ -236,8 +241,7 @@ static int rxrpc_preparse_xdr_yfs_rxgk(struct key_preparsed_payload *prep,
 	memcpy(token->rxgk->key.data, key, token->rxgk->key.len);
 
 	/* Pad the ticket so that we can use it directly in XDR */
-	token->rxgk->ticket.data = kzalloc(round_up(token->rxgk->ticket.len, 4),
-					   GFP_KERNEL);
+	token->rxgk->ticket.data = kzalloc(tktlen, GFP_KERNEL);
 	if (!token->rxgk->ticket.data)
 		goto nomem_yrxgk;
 	memcpy(token->rxgk->ticket.data, ticket, token->rxgk->ticket.len);


