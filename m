Return-Path: <netdev+bounces-274051-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aE9lFZD8zGnRYgYAu9opvQ
	(envelope-from <netdev+bounces-274051-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 13:08:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F28E837918E
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 13:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 89EBE3103015
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 10:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BE34070FB;
	Wed,  1 Apr 2026 10:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J7XN6VX1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C22405ACC
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 10:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775041026; cv=none; b=f6/5FfChRUXEZN4Qsm9RqibBqzrhm0K9eMKxM+Qq6kW8hQ+nF0+vTjtvMfLO+46csfHVm54kgYl6bht7w8DTcKiwY3WHp4sEXjVfnSYD5wkjtF1cjZe7eOsS2Z2zPVt7iMHFwOgkBuWnDEkG7oPPbuY3Hp6YKLEXABBv2euHX/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775041026; c=relaxed/simple;
	bh=i2+6T5laS6iXW24MjsOpSAQSe/11jAwSQhKVgP6EJWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ui7sMXfuSC9UthQ59MVqplq6GXY6pQuqqqrby2Qn1qj/47bvqEJKkQATzwVO2lYSex89mwxiWGnMZMeLvKmfOhsXEqEMyjjiOKXOYj6XdE/zVQo0t3z6MNJANybQhtIXBeU50lGWybbDBf2fz1Q/Fpz+E5AarT/+NztjJLMgzE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J7XN6VX1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775041024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5LLb+kvWly++E+vGdyFSJ+eIakQ89ZsZ0xRogJGUpqc=;
	b=J7XN6VX15WCv8uVVeLfvq/QRNxKS6Y768dPXhtFmpvw3/0rKghAXaMgz/AnDwI89LcoPLi
	ntN1N+KEKZuA05CkjkLYZD/78t3yxAZUf7O03Th4cLgFiWqtnFO6zZNlB+Un4ZVskXrJJF
	Nf088V2b6Nb6frqgbjql6PFtDDWkRoU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-526-VsvuYi-5OBS7jgS8dx7PjA-1; Wed,
 01 Apr 2026 06:56:58 -0400
X-MC-Unique: VsvuYi-5OBS7jgS8dx7PjA-1
X-Mimecast-MFC-AGG-ID: VsvuYi-5OBS7jgS8dx7PjA_1775041017
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E8C611956062;
	Wed,  1 Apr 2026 10:56:56 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.35.245])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E9AAD1954102;
	Wed,  1 Apr 2026 10:56:52 +0000 (UTC)
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
Subject: [PATCH net v4 05/15] rxrpc: Fix RxGK token loading to check bounds
Date: Wed,  1 Apr 2026 11:55:58 +0100
Message-ID: <20260401105614.1696001-6-dhowells@redhat.com>
In-Reply-To: <20260401105614.1696001-1-dhowells@redhat.com>
References: <20260401105614.1696001-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274051-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[auristor.com:email,davemloft.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:email]
X-Rspamd-Queue-Id: F28E837918E
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
index 26d4336a4a02..77237a82be3b 100644
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


