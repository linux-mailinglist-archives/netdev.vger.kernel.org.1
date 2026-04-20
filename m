Return-Path: <netdev+bounces-279847-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YICAOuJI5mnSuAEAu9opvQ
	(envelope-from <netdev+bounces-279847-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 17:40:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4754C42E75B
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 17:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C66AE3854F5C
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 15:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2938034BA33;
	Mon, 20 Apr 2026 14:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jSY6Zb1V"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EAB34B661
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 14:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776697176; cv=none; b=aZV7iKPsIUCBH6N1nxye8WPv3nEp7gNDDYZvvNiMGmsmQSa+Mpod/8YkGdLQzMAb9nqgHRbQOQOF5uvS+DwRX9pcqOa1vPIHh+jBv0+hfcn+/TXo3Bss11SgLUbQJLOO2LCjmObM4HO72CA8E98IlwJKWJAFGHI1FNojIg5FhJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776697176; c=relaxed/simple;
	bh=p0W12jB3ALgskZd7ZgPKN4gV+rve7nGSbftbA7m+wk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mWqyI+XQ4YN7jLkF4pbdxmtQsu45LNdQC36keCAZkfrud7JU+WhNrsejk0encvISHrYMXNI9uNGUKLGfL3Padm91VIEjisWPQbpXdMxYvGOYyg3W4bD5skK3O5+vCvoa1FUNO+dimPptZPuOmzNRj+NQ9fAVBejqYu0rP/I/pzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jSY6Zb1V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776697173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iv83NO4YI3DPReeljDl/HkFdk6aqOlDwziKw4as8W48=;
	b=jSY6Zb1VhQmi37w6wKEJQW0LvTTxxHNMtQuO0Dfiv+9JVDqKLcX0KBcbDnxiYMUUK3tIjR
	gt9EX+pIHL6qQEwpzJbMQaUw2bx+D4Jyl5p6cFPH3BpufdlSIaHykVnOLkpK92UXJng/my
	cDDq/8vfbxoNeGvgTTEexXps1GaAfkw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-314-0p-2dpALP_aANnc1ZYTRXQ-1; Mon,
 20 Apr 2026 10:59:31 -0400
X-MC-Unique: 0p-2dpALP_aANnc1ZYTRXQ-1
X-Mimecast-MFC-AGG-ID: 0p-2dpALP_aANnc1ZYTRXQ_1776697170
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D05CD19560BA;
	Mon, 20 Apr 2026 14:59:29 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.48.17])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DA52F19560AB;
	Mon, 20 Apr 2026 14:59:25 +0000 (UTC)
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
Subject: [PATCH net 4/4] rxrpc: Fix rxkad crypto unalignment handling
Date: Mon, 20 Apr 2026 15:58:57 +0100
Message-ID: <20260420145900.1223732-5-dhowells@redhat.com>
In-Reply-To: <20260420145900.1223732-1-dhowells@redhat.com>
References: <20260420145900.1223732-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279847-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.995];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,infradead.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,auristor.com:email,davemloft.net:email]
X-Rspamd-Queue-Id: 4754C42E75B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fix handling of a packet with a misaligned crypto length.  Also handle
non-ENOMEM errors from decryption by aborting.  Further, remove the
WARN_ON_ONCE() so that it can't be remotely triggered (a trace line can
still be emitted).

Fixes: f93af41b9f5f ("rxrpc: Fix missing error checks for rxkad encryption/decryption failure")
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
 include/trace/events/rxrpc.h | 1 +
 net/rxrpc/rxkad.c            | 9 +++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index 578b8038b211..5820d7e41ea0 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -37,6 +37,7 @@
 	EM(rxkad_abort_1_short_encdata,		"rxkad1-short-encdata")	\
 	EM(rxkad_abort_1_short_header,		"rxkad1-short-hdr")	\
 	EM(rxkad_abort_2_short_check,		"rxkad2-short-check")	\
+	EM(rxkad_abort_2_crypto_unaligned,	"rxkad2-crypto-unaligned") \
 	EM(rxkad_abort_2_short_data,		"rxkad2-short-data")	\
 	EM(rxkad_abort_2_short_header,		"rxkad2-short-hdr")	\
 	EM(rxkad_abort_2_short_len,		"rxkad2-short-len")	\
diff --git a/net/rxrpc/rxkad.c b/net/rxrpc/rxkad.c
index 0acdc46f42c2..2c4697063ab2 100644
--- a/net/rxrpc/rxkad.c
+++ b/net/rxrpc/rxkad.c
@@ -510,6 +510,9 @@ static int rxkad_verify_packet_2(struct rxrpc_call *call, struct sk_buff *skb,
 		return rxrpc_abort_eproto(call, skb, RXKADSEALEDINCON,
 					  rxkad_abort_2_short_header);
 
+	/* Don't let the crypto algo see a misaligned length. */
+	sp->len = round_down(sp->len, 8);
+
 	/* Decrypt the skbuff in-place.  TODO: We really want to decrypt
 	 * directly into the target buffer.
 	 */
@@ -543,8 +546,10 @@ static int rxkad_verify_packet_2(struct rxrpc_call *call, struct sk_buff *skb,
 	if (sg != _sg)
 		kfree(sg);
 	if (ret < 0) {
-		WARN_ON_ONCE(ret != -ENOMEM);
-		return ret;
+		if (ret == -ENOMEM)
+			return ret;
+		return rxrpc_abort_eproto(call, skb, RXKADSEALEDINCON,
+					  rxkad_abort_2_crypto_unaligned);
 	}
 
 	/* Extract the decrypted packet length */


