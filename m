Return-Path: <netdev+bounces-249537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9D4D1AAFF
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 18:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 095263019C62
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 17:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB173933F2;
	Tue, 13 Jan 2026 17:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eIyoa0I2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF5D38A728
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 17:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768326090; cv=none; b=lWaNbcYIMi4kCJnxLPMW9kXz0ZdPGTb4vYnc+aK1iAAiN3ZDfJqjXkEdESmVvDAeaKYOlyhr6bS8o4JAJJkY3ZFWYJyB6vR9wvBFuX3m39O+UTOmJlO5r5i+OZC68Q1v9UGIC8MZdjKewgL22mlML8u2ZBRLbJX26oLBhPgYgLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768326090; c=relaxed/simple;
	bh=qQ0f52JN5/uHLZvfmLsNRAQs0bKe9Q06K1Qab1mrmjU=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=RnU0W/FCZp6k4cavQtwmH0dMmvajKJmTx9t2jdLY9IaddMJbqAq4AkhpOXAe6pCxaN5dF9XHZesu2MimLr9AmwRlsRhBTgwBb2kBGeOaGkoUmTiT1FlrRR1u2XTwaz1AQKw8on8ZCwkOwVP27FlhcV3JTENX+RJUGkyYzDOPYFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eIyoa0I2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768326079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GnHx1xZ/qeVaPJvNMrQ25xIvqfc7ydmJVX2qUkgASNM=;
	b=eIyoa0I21FmZOhJlh06luGhVl6TQrDLpzff2UA+iEIRxWHciMRLECjVskV2yWwtlWRHwpO
	BKppHnMff6402qiJhM86vmlRQyOl2zRg4+1YEZoSpK9OAyQhaXCT70wuVKAxZ7hld/i7aW
	CZ7W4Byu72YzrMQRB7w0NJYTI/GahGM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-466-tG2kSP6nMTC2-p4ruXN7DQ-1; Tue,
 13 Jan 2026 12:41:15 -0500
X-MC-Unique: tG2kSP6nMTC2-p4ruXN7DQ-1
X-Mimecast-MFC-AGG-ID: tG2kSP6nMTC2-p4ruXN7DQ_1768326073
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3BEA71800365;
	Tue, 13 Jan 2026 17:41:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 09E6A30001A2;
	Tue, 13 Jan 2026 17:41:08 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
cc: dhowells@redhat.com, Faith <faith@zellic.io>,
    Pumpkin Chang <pumpkin@devco.re>,
    Marc Dionne <marc.dionne@auristor.com>, Nir Ohfeld <niro@wiz.io>,
    Willy Tarreau <w@1wt.eu>, Eric Dumazet <edumazet@google.com>,
    "David S. Miller" <davem@davemloft.net>,
    Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
    Simon Horman <horms@kernel.org>, linux-afs@lists.infradead.org,
    security@kernel.org, stable@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net] rxrpc: Fix recvmsg() unconditional requeue
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3537105.1768326067.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Jan 2026 17:41:07 +0000
Message-ID: <3537106.1768326067@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

    =

If rxrpc_recvmsg() fails because MSG_DONTWAIT was specified but the call a=
t
the front of the recvmsg queue already has its mutex locked, it requeues
the call - whether or not the call is already queued.  The call may be on
the queue because MSG_PEEK was also passed and so the call was not dequeue=
d
or because the I/O thread requeued it.

The unconditional requeue may then corrupt the recvmsg queue, leading to
things like UAFs or refcount underruns.

Fix this by only requeuing the call if it isn't already on the queue - and
moving it to the front if it is already queued.

Also, MSG_PEEK doesn't dequeue the call so shouldn't call
rxrpc_notify_socket() for the call if we didn't use up all the data on the
queue, so fix that also.

Fixes: 540b1c48c37a ("rxrpc: Fix deadlock between call creation and sendms=
g/recvmsg")
Reported-by: Faith <faith@zellic.io>
Reported-by: Pumpkin Chang <pumpkin@devco.re>
Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Marc Dionne <marc.dionne@auristor.com>
cc: Nir Ohfeld <niro@wiz.io>
cc: Willy Tarreau <w@1wt.eu>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
cc: security@kernel.org
cc: stable@kernel.org
---
 include/trace/events/rxrpc.h |    4 ++++
 net/rxrpc/recvmsg.c          |   15 ++++++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/include/trace/events/rxrpc.h b/include/trace/events/rxrpc.h
index de6f6d25767c..869f97c9bf73 100644
--- a/include/trace/events/rxrpc.h
+++ b/include/trace/events/rxrpc.h
@@ -322,6 +322,7 @@
 	EM(rxrpc_call_put_kernel,		"PUT kernel  ") \
 	EM(rxrpc_call_put_poke,			"PUT poke    ") \
 	EM(rxrpc_call_put_recvmsg,		"PUT recvmsg ") \
+	EM(rxrpc_call_put_recvmsg_peek_nowait,	"PUT peek-nwt") \
 	EM(rxrpc_call_put_release_recvmsg_q,	"PUT rls-rcmq") \
 	EM(rxrpc_call_put_release_sock,		"PUT rls-sock") \
 	EM(rxrpc_call_put_release_sock_tba,	"PUT rls-sk-a") \
@@ -340,6 +341,9 @@
 	EM(rxrpc_call_see_input,		"SEE input   ") \
 	EM(rxrpc_call_see_notify_released,	"SEE nfy-rlsd") \
 	EM(rxrpc_call_see_recvmsg,		"SEE recvmsg ") \
+	EM(rxrpc_call_see_recvmsg_requeue,	"SEE recv-rqu") \
+	EM(rxrpc_call_see_recvmsg_requeue_first, "SEE recv-rqF") \
+	EM(rxrpc_call_see_recvmsg_requeue_move,	"SEE recv-rqM") \
 	EM(rxrpc_call_see_release,		"SEE release ") \
 	EM(rxrpc_call_see_userid_exists,	"SEE u-exists") \
 	EM(rxrpc_call_see_waiting_call,		"SEE q-conn  ") \
diff --git a/net/rxrpc/recvmsg.c b/net/rxrpc/recvmsg.c
index 7fa7e77f6bb9..2c42823f472b 100644
--- a/net/rxrpc/recvmsg.c
+++ b/net/rxrpc/recvmsg.c
@@ -518,7 +518,8 @@ int rxrpc_recvmsg(struct socket *sock, struct msghdr *=
msg, size_t len,
 	if (rxrpc_call_has_failed(call))
 		goto call_failed;
 =

-	if (!skb_queue_empty(&call->recvmsg_queue))
+	if (!(flags & MSG_PEEK) &&
+	    !skb_queue_empty(&call->recvmsg_queue))
 		rxrpc_notify_socket(call);
 	goto not_yet_complete;
 =

@@ -549,11 +550,19 @@ int rxrpc_recvmsg(struct socket *sock, struct msghdr=
 *msg, size_t len,
 error_requeue_call:
 	if (!(flags & MSG_PEEK)) {
 		spin_lock_irq(&rx->recvmsg_lock);
-		list_add(&call->recvmsg_link, &rx->recvmsg_q);
+		if (list_empty(&call->recvmsg_link)) {
+			list_add(&call->recvmsg_link, &rx->recvmsg_q);
+			rxrpc_see_call(call, rxrpc_call_see_recvmsg_requeue);
+		} else if (list_is_first(&call->recvmsg_link, &rx->recvmsg_q)) {
+			rxrpc_see_call(call, rxrpc_call_see_recvmsg_requeue_first);
+		} else {
+			list_move(&call->recvmsg_link, &rx->recvmsg_q);
+			rxrpc_see_call(call, rxrpc_call_see_recvmsg_requeue_move);
+		}
 		spin_unlock_irq(&rx->recvmsg_lock);
 		trace_rxrpc_recvmsg(call_debug_id, rxrpc_recvmsg_requeue, 0);
 	} else {
-		rxrpc_put_call(call, rxrpc_call_put_recvmsg);
+		rxrpc_put_call(call, rxrpc_call_put_recvmsg_peek_nowait);
 	}
 error_no_call:
 	release_sock(&rx->sk);


