Return-Path: <netdev+bounces-274059-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEukBFz+zGnRYgYAu9opvQ
	(envelope-from <netdev+bounces-274059-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 13:15:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C818379349
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 13:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C1DB7310CC83
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 11:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A87D410D18;
	Wed,  1 Apr 2026 10:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AESbs/Cw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD943F99ED
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 10:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775041075; cv=none; b=ByAeoiO10ejjBEqe9X3oVtHJvyPLCbaFlKFv5vtYk+1yLH0hjaKLO2ZunsLzJXynpLesUN7X5f8EJZD59aK0+YTuI9jIKxpZvOMMaZBeOqolrMhYd+TUbdRqAGzQu28YnPQHwMEG+P6I0hZMy7m4BMgOm6Yf1JoO/SbkzY4qp6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775041075; c=relaxed/simple;
	bh=tvUyRhVMalpubI17pjs0i9TXl4S24YaRmP7WTttQ+xA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AtxEfLcAQzemdu2pkgNfgQvtge9yJ7/K4+4Xq/Me2T8HtCdYnfhxgpeoduLZ9dJ54Ae7YQCJc/8EavNFD2SZxGp9FI3T1vfxeCCm6zXh6V+l4OGIbvOyQnU8qmuNOjcuqwkggv9UtaEOS2haVRP8523Lmnb6xZfMBtQzLMSWHQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AESbs/Cw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775041072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sQYqrHt7oIuaj7mcOONb87DdoY4Fd56NWEpjp2O/8Ag=;
	b=AESbs/Cw53nJF/xWe5S9EctQOej/CGA4lYuYnka/tVsf2GH9bGt2BJXoXGN/4bPKsTlkxB
	tezy3hfgbQ7TJ/oJpHTsqtkbAaY7Yho64QbdLhYw7VqmQe5pvr9AXUa2x/roDSu74KOwXk
	wMo1qhv/64WESJtf0SeUyueaAkxfdYE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-378-59YMH-8-MUmyyDw-YuOLWw-1; Wed,
 01 Apr 2026 06:57:48 -0400
X-MC-Unique: 59YMH-8-MUmyyDw-YuOLWw-1
X-Mimecast-MFC-AGG-ID: 59YMH-8-MUmyyDw-YuOLWw_1775041064
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0418219560A1;
	Wed,  1 Apr 2026 10:57:44 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.35.245])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1B08E180035F;
	Wed,  1 Apr 2026 10:57:39 +0000 (UTC)
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
	Keenan Dong <keenanat2000@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Willy Tarreau <w@1wt.eu>,
	stable@kernel.org
Subject: [PATCH net v4 13/15] rxrpc: fix RESPONSE authenticator parser OOB read
Date: Wed,  1 Apr 2026 11:56:06 +0100
Message-ID: <20260401105614.1696001-14-dhowells@redhat.com>
In-Reply-To: <20260401105614.1696001-1-dhowells@redhat.com>
References: <20260401105614.1696001-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,auristor.com,kernel.org,davemloft.net,google.com,lists.infradead.org,vger.kernel.org,gmail.com,1wt.eu];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274059-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,auristor.com:email,1wt.eu:email,infradead.org:email,davemloft.net:email]
X-Rspamd-Queue-Id: 1C818379349
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Keenan Dong <keenanat2000@gmail.com>

rxgk_verify_authenticator() copies auth_len bytes into a temporary
buffer and then passes p + auth_len as the parser limit to
rxgk_do_verify_authenticator(). Since p is a __be32 *, that inflates the
parser end pointer by a factor of four and lets malformed RESPONSE
authenticators read past the kmalloc() buffer.

Decoded from the original latest-net reproduction logs with
scripts/decode_stacktrace.sh:

BUG: KASAN: slab-out-of-bounds in rxgk_verify_response()
Call Trace:
 dump_stack_lvl() [lib/dump_stack.c:123]
 print_report() [mm/kasan/report.c:379 mm/kasan/report.c:482]
 kasan_report() [mm/kasan/report.c:597]
 rxgk_verify_response()
   [net/rxrpc/rxgk.c:1103 net/rxrpc/rxgk.c:1167
    net/rxrpc/rxgk.c:1274]
 rxrpc_process_connection()
   [net/rxrpc/conn_event.c:266 net/rxrpc/conn_event.c:364
    net/rxrpc/conn_event.c:386]
 process_one_work() [kernel/workqueue.c:3281]
 worker_thread()
   [kernel/workqueue.c:3353 kernel/workqueue.c:3440]
 kthread() [kernel/kthread.c:436]
 ret_from_fork() [arch/x86/kernel/process.c:164]

Allocated by task 54:
 rxgk_verify_response()
   [include/linux/slab.h:954 net/rxrpc/rxgk.c:1155
    net/rxrpc/rxgk.c:1274]
 rxrpc_process_connection()
   [net/rxrpc/conn_event.c:266 net/rxrpc/conn_event.c:364
    net/rxrpc/conn_event.c:386]

Convert the byte count to __be32 units before constructing the parser
limit.

Fixes: 9d1d2b59341f ("rxrpc: rxgk: Implement the yfs-rxgk security class (GSSAPI)")
Signed-off-by: Keenan Dong <keenanat2000@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: Willy Tarreau <w@1wt.eu>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
cc: stable@kernel.org
---
 net/rxrpc/rxgk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/rxrpc/rxgk.c b/net/rxrpc/rxgk.c
index f9f5a2dc62ed..01dbdf0b5cf2 100644
--- a/net/rxrpc/rxgk.c
+++ b/net/rxrpc/rxgk.c
@@ -1164,7 +1164,8 @@ static int rxgk_verify_authenticator(struct rxrpc_connection *conn,
 	}
 
 	p = auth;
-	ret = rxgk_do_verify_authenticator(conn, krb5, skb, p, p + auth_len);
+	ret = rxgk_do_verify_authenticator(conn, krb5, skb, p,
+					   p + auth_len / sizeof(*p));
 error:
 	kfree(auth);
 	return ret;


