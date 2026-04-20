Return-Path: <netdev+bounces-279846-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNIvLqpE5ml/twEAu9opvQ
	(envelope-from <netdev+bounces-279846-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 17:22:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A6542E172
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 17:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A59FC30065F9
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 15:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992C6348865;
	Mon, 20 Apr 2026 14:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vr0ROeMq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDC83491C4
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 14:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776697171; cv=none; b=T9KjIMhLKorv6TEiigeY3W2NN+lkUPqFdZVWGIyn00Xgd1SzjhVdJz+JCpWi2KSgOOzMJtiFNJH7wbuVNL4gwdBdprqhaB63Vbru3x70AxPZlLN7pPUioYm5c8OEVYOR5gjJTSclf+anI6hcnE9QpvvGgJy4ivcSwAVMhTWSaYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776697171; c=relaxed/simple;
	bh=VC0xaEp18VE11/4HL93isyezfiB6giE7QUc/XgHBk/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QeUzmICiJYmUWIkmUiU2RzgMmRhh0/dQbqwgCv5UwGrpJOkDYabLh+7EGTyvuqE/BqRfF/5ipiu9KsoeFT5yUjUvkvhd2RPHhA8DHGE1UrGZb1CWLRv5SKcdKctG7L1j1+MbMxPlysqpeND1v7yNJMplM4MlsBjiF6B0wF7TLgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vr0ROeMq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776697169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tg/xm4khmGTMt0O8denk3V8PJT+Q+STOFvsXoz9Lch4=;
	b=Vr0ROeMqJWoaLnOCUQmcbLVctg05HpiTgE7VEmjzB6TlBavRFv9mz/GLYfk1n06GVZ/QZQ
	Y/PTcksUsHNUpCRIWv85kA2AuwnBaZdTJIz3DFVI7ExV7lBKuvIqu9E17E8QPGaO3QtXtn
	biGEdbfz4XeNyUqpaLDCT3sJlBAukhA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-0EbEly_tPTmYfR0DpIyXwQ-1; Mon,
 20 Apr 2026 10:59:25 -0400
X-MC-Unique: 0EbEly_tPTmYfR0DpIyXwQ-1
X-Mimecast-MFC-AGG-ID: 0EbEly_tPTmYfR0DpIyXwQ_1776697164
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3AB2D19560B9;
	Mon, 20 Apr 2026 14:59:24 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.48.17])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AF11B19560B1;
	Mon, 20 Apr 2026 14:59:20 +0000 (UTC)
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
Subject: [PATCH net 3/4] rxgk: Fix potential integer overflow in length check
Date: Mon, 20 Apr 2026 15:58:56 +0100
Message-ID: <20260420145900.1223732-4-dhowells@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279846-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.995];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sashiko.dev:url,auristor.com:email,davemloft.net:email]
X-Rspamd-Queue-Id: 20A6542E172
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fix potential integer overflow in rxgk_extract_token() when checking the
length of the ticket.  Rather than rounding up the value to be tested
(which might overflow), round down the size of the available data.

Fixes: 2429a1976481 ("rxrpc: Fix untrusted unsigned subtract")
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
 net/rxrpc/rxgk_app.c    | 2 +-
 net/rxrpc/rxgk_common.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/rxrpc/rxgk_app.c b/net/rxrpc/rxgk_app.c
index 30275cb5ba3e..5587639d60c5 100644
--- a/net/rxrpc/rxgk_app.c
+++ b/net/rxrpc/rxgk_app.c
@@ -214,7 +214,7 @@ int rxgk_extract_token(struct rxrpc_connection *conn, struct sk_buff *skb,
 	ticket_len	= ntohl(container.token_len);
 	ticket_offset	= token_offset + sizeof(container);
 
-	if (xdr_round_up(ticket_len) > token_len - sizeof(container))
+	if (ticket_len > xdr_round_down(token_len - sizeof(container)))
 		goto short_packet;
 
 	_debug("KVNO %u", kvno);
diff --git a/net/rxrpc/rxgk_common.h b/net/rxrpc/rxgk_common.h
index 80164d89e19c..1e257d7ab8ec 100644
--- a/net/rxrpc/rxgk_common.h
+++ b/net/rxrpc/rxgk_common.h
@@ -34,6 +34,7 @@ struct rxgk_context {
 };
 
 #define xdr_round_up(x) (round_up((x), sizeof(__be32)))
+#define xdr_round_down(x) (round_down((x), sizeof(__be32)))
 #define xdr_object_len(x) (4 + xdr_round_up(x))
 
 /*


