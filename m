Return-Path: <netdev+bounces-299902-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id i+yoEU15MWoDkQUAu9opvQ
	(envelope-from <netdev+bounces-299902-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 18:26:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A797692149
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 18:26:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=i66Bm0oO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299902-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-299902-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C5A7530D9286
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 15:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCEA477E4D;
	Tue, 16 Jun 2026 15:58:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D396F46AEE8
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 15:58:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625500; cv=none; b=hp1sRE9QlU3iaK01WifKMvFMnGnP0aJo8LZYT/TMXmB08eO1ZEaNTSDAdi4Dc5LHxrnTSELXyengLl6y2SeL2Tfr0rl+WETTS4vmwUGtbi/RBTif/2+HKi1zPTMbZr7wbI3P+bf9+8bdBJFJVC/6oH1oXanaIiyq/WtmqOviZYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625500; c=relaxed/simple;
	bh=+c1v171ucIGcreUIBx1KLvMMgikORNXIoAjyt2dWcEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KyUaIOadcJw/AG+DU63LEWfQ/kGSahIazLq9OQS+HF1qCUqXrF6VwW+JtHGEd8nikX0DN98xlDh35jolEJhRNPGNYXs0rw35BDfzm6fj9vEu+iUqRU4By1Z2/zsSiEDBG8H8FG4KG6KHW+9yTLR/ebjXhP9LPO0WnSLppZB+jQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i66Bm0oO; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781625498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2pelT1Ehf1aADqvzwY1SZp6RYyze5Ju/7z85Yx5jL4A=;
	b=i66Bm0oOSpUCI50oznCsbz8lZobjmuy+QvcvAusLPXTw195HFe1p/oiXbGWkYwPkVBdfTe
	8XfJ0RElgQWJrPFc/0fxbWXLR2hVF+YSAcg5sFgbdIvvWy8N1USRjR+XLOaQYz86iIZiBc
	d9Cj8ZSD84TdTslk3MxKIIjbmqstyxg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-237-orGmwrNUNa2uTrxXFllo1w-1; Tue,
 16 Jun 2026 11:58:14 -0400
X-MC-Unique: orGmwrNUNa2uTrxXFllo1w-1
X-Mimecast-MFC-AGG-ID: orGmwrNUNa2uTrxXFllo1w_1781625493
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2C7991955F68;
	Tue, 16 Jun 2026 15:58:13 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.50.44])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C3DBF3008B3E;
	Tue, 16 Jun 2026 15:58:09 +0000 (UTC)
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
	stable@kernel.org
Subject: [PATCH net 3/5] rxrpc: Fix double unlock in rxrpc_recvmsg()
Date: Tue, 16 Jun 2026 16:57:45 +0100
Message-ID: <20260616155749.2125907-4-dhowells@redhat.com>
In-Reply-To: <20260616155749.2125907-1-dhowells@redhat.com>
References: <20260616155749.2125907-1-dhowells@redhat.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-299902-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:dhowells@redhat.com,m:marc.dionne@auristor.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-afs@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:stable@kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,auristor.com:email,vger.kernel.org:from_smtp,sashiko.dev:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,davemloft.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5A797692149

Fix a double unlock in rxrpc_recvmsg() when dealing with OOB messages.

Fixes: 5800b1cf3fd8 ("rxrpc: Allow CHALLENGEs to the passed to the app for a RESPONSE")
Link: https://sashiko.dev/#/patchset/20260609140911.838677-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: stable@kernel.org
---
 net/rxrpc/recvmsg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rxrpc/recvmsg.c b/net/rxrpc/recvmsg.c
index 82614cbdb60f..39a03684432d 100644
--- a/net/rxrpc/recvmsg.c
+++ b/net/rxrpc/recvmsg.c
@@ -471,7 +471,7 @@ int rxrpc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		release_sock(&rx->sk);
 		if (ret == -EAGAIN)
 			goto try_again;
-		goto error_no_call;
+		goto error_trace;
 	}
 
 	/* Find the next call and dequeue it if we're not just peeking.  If we


