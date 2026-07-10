Return-Path: <netdev+bounces-306665-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yxWiIsNGUWryBgMAu9opvQ
	(envelope-from <netdev+bounces-306665-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 21:23:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0B073DB78
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 21:23:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=T8krbo45;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306665-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306665-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A28EF3038D3C
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 19:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28642388E4D;
	Fri, 10 Jul 2026 19:22:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A4338757D
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 19:22:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783711366; cv=none; b=eOUbnMpB8nELYF8t3MvxtQylp1oIT4Ftpb+WBZ8Cr0rerOIbzlanPIQ6cKvvd1sTV1mEBpANUoiRPIPxpDokW+aXH4Ui4PwEKUGSUGj+K5d0+3mA6rcRBduwxVQQ67CyHMgVUByhSy/yShM60TE5+JdyOF6JkRU1gqPTEHTguWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783711366; c=relaxed/simple;
	bh=xyALdxjU1TW9/Ki7zm9C1YzWa0+d5DiMlT8No6I9Mes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fOf2xztZZniRJi0G8JFvkGDz4PhmlKukUvaHjTo81q7GiAC7kl3lXLUG1HBCfzEfGCOf/NoXsP7qFf76J9ajB9ZhJTBB3LmCruB2ypd0vGg4kRJs4dbJwlEFu11dKUuOaNXhPWmsMAkptTxLx4FtgVrrPJOAwFv1qmmOTKd9/L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T8krbo45; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783711363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BOWCDRxNUNYjz7orMFcedmQGQ2BN2L8e1lJ1KDGIQsg=;
	b=T8krbo45E9cctfU5+JKQMmrM/0BuD/pgf8revi9y/ZfCKxu8OCQH/y06u7yhiyNYoIYZlC
	ioYDIy8cI+c5eR5H3WOZzP6Jk2d2LX61mIZKA2/y8FMovD456NxVm6tu7eOLEkYSMBe1xo
	5zL2stdkiYAaySz3PekLCVsYV5zm9qI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-437-r_kZBOwiPCyNTr3ieAe8Mg-1; Fri,
 10 Jul 2026 15:22:40 -0400
X-MC-Unique: r_kZBOwiPCyNTr3ieAe8Mg-1
X-Mimecast-MFC-AGG-ID: r_kZBOwiPCyNTr3ieAe8Mg_1783711358
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 23E061955E7E;
	Fri, 10 Jul 2026 19:22:38 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.159])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 84A571956095;
	Fri, 10 Jul 2026 19:22:34 +0000 (UTC)
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
	Jeffrey Altman <jaltman@auristor.com>
Subject: [PATCH net v2 02/16] rxrpc: Fix sendmsg to not return an error if last packet queued
Date: Fri, 10 Jul 2026 20:22:04 +0100
Message-ID: <20260710192220.1922433-3-dhowells@redhat.com>
In-Reply-To: <20260710192220.1922433-1-dhowells@redhat.com>
References: <20260710192220.1922433-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-306665-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:dhowells@redhat.com,m:marc.dionne@auristor.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-afs@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:jaltman@auristor.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,auristor.com:email,davemloft.net:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1D0B073DB78

Fix AF_RXRPC sendmsg() so that it doesn't return an error if it has
successfully queued the last packet of a call, but the call has seen to
have completed after it did that.  Rather, leave it to recvmsg() to report
the completion (which it will do anyway).

The problem with trying to report the error twice is that the caller may
try to clean up the dead call twice.

Fixes: d41b3f5b9688 ("rxrpc: Wrap accesses to get call state to put the barrier in one place")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
---
 net/rxrpc/sendmsg.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index ed2c9a51005a..4c754f78ece9 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -453,9 +453,6 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 
 success:
 	ret = copied;
-	if (rxrpc_call_is_complete(call) &&
-	    call->error < 0)
-		ret = call->error;
 out:
 	call->tx_pending = txb;
 	_leave(" = %d", ret);
@@ -467,8 +464,14 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 	return call->error;
 
 maybe_error:
-	if (copied)
+	if (copied) {
+		if (rxrpc_call_is_complete(call) &&
+		    call->error < 0) {
+			ret = call->error;
+			goto out;
+		}
 		goto success;
+	}
 	goto out;
 
 efault:


