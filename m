Return-Path: <netdev+bounces-306670-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5N3bJ+NGUWr4BgMAu9opvQ
	(envelope-from <netdev+bounces-306670-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 21:24:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 320A173DB8E
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 21:24:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=Wng4c+F4;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306670-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-306670-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5175C3021C9E
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 19:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2798838E8CE;
	Fri, 10 Jul 2026 19:23:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C041D3876D6
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 19:23:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783711390; cv=none; b=d5ZqXDeiwBSid7OeJ0lx83mZ858WN8OEc5v+nY0XCN56s7s7WTFcZjafHWo5zBO5IQkZosFKFT0FOOT8067qdq1dPfZ3VSACC8m2cJS0wkYJdV7YyKsdgSoLkDDXWInWpj+j41Ly/RhyZWHxJpMDHwQNq4Mcz+9FPE/ooimmkEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783711390; c=relaxed/simple;
	bh=RqEZ8V3VTBLUYMWessvmE35+orqVW6T6gXuF1INaQHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dHbfhtvKa0WY3oQhzSOlwUYFmVLneFpDPW3TRiTxuyc6P9zAwFNpoH3iWLdoytfaDjOTNzOBJh6GUek4mpDhIRPxyQYrlysxTMX5pfcH6gdYYc6hP4wfOvHOcu23nYcKaZhl1jIdmnFDElvAUoSJNE8uNLSZPl1sEz7jK1uROAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wng4c+F4; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783711385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5tnXvZhH3Uv8RMIWKCx6J8r5QB8JHDWA9/+oQzZb+wc=;
	b=Wng4c+F475NZaTv63y9eziRciey7uj16f6OTiPdR+n0FxPSqt3vuFDblDVwCTSK8yDr+a7
	wVY02IiSvaBODIYHESCHi8W2y5g4vKxZN7LSWAru+R4MpuMJaVfntoldR1s/hh3GlDz+Xg
	no7/711h4+v5pv1f8cV2L3iXJ6YZhCU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-xh74SyEAN1KLSqSNfDz63w-1; Fri,
 10 Jul 2026 15:23:04 -0400
X-MC-Unique: xh74SyEAN1KLSqSNfDz63w-1
X-Mimecast-MFC-AGG-ID: xh74SyEAN1KLSqSNfDz63w_1783711382
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 91CC81955F07;
	Fri, 10 Jul 2026 19:23:02 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.159])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 75CCA1800661;
	Fri, 10 Jul 2026 19:22:59 +0000 (UTC)
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
Subject: [PATCH net v2 07/16] rxrpc: Fix update of call->tx_pending without holding lock
Date: Fri, 10 Jul 2026 20:22:09 +0100
Message-ID: <20260710192220.1922433-8-dhowells@redhat.com>
In-Reply-To: <20260710192220.1922433-1-dhowells@redhat.com>
References: <20260710192220.1922433-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-306670-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:dhowells@redhat.com,m:marc.dionne@auristor.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-afs@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:stable@kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,auristor.com:email,davemloft.net:email,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 320A173DB8E

Currently, rxrpc_send_data() updates call->tx_pending just before it
returns - but it won't be holding the call->lock when it does this if a
wait was interrupted by a signal.  This would allow a parallel sendmsg() to
race.

Further, both the callers of rxrpc_send_data() call it with the lock held,
and then it returns an indication through the parameter list to say whether
it has dropped the lock or not - after which the callers both just drop the
lock if it's still held.

Fix this by:

 (1) Moving the release of call->lock down into rxrpc_send_data() and get
     rid of the indicator parameter.  This makes it easier to see where the
     lock is held.

 (2) Make the wait_for_space path move the value in txb back into
     call->tx_pending before dropping the lock prior to the wait.

 (3) After waiting, if the attempt to reacquire the mutex is interrupted,
     just return directly there rather than going to out_unlock

Fixes: b0f571ecd794 ("rxrpc: Fix locking in rxrpc's sendmsg")
Closes: https://sashiko.dev/#/patchset/20260702144919.172295-1-dhowells%40redhat.com
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
 net/rxrpc/sendmsg.c | 52 +++++++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 23 deletions(-)

diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index d5060fd9631a..71343998b87d 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -320,8 +320,8 @@ static int rxrpc_alloc_txqueue(struct sock *sk, struct rxrpc_call *call)
 static int rxrpc_send_data(struct rxrpc_sock *rx,
 			   struct rxrpc_call *call,
 			   struct msghdr *msg, size_t len,
-			   rxrpc_notify_end_tx_t notify_end_tx,
-			   bool *_dropped_lock)
+			   rxrpc_notify_end_tx_t notify_end_tx)
+	__releases(&call->user_mutex)
 {
 	struct rxrpc_txbuf *txb;
 	struct sock *sk = &rx->sk;
@@ -334,25 +334,27 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 		trace_rxrpc_abort(call->debug_id, rxrpc_sendmsg_late_send,
 				  call->cid, call->call_id, call->rx_consumed,
 				  0, -EPROTO);
-		return -EPROTO;
+		ret = -EPROTO;
+		goto out_unlock;
 	}
 	if (unlikely(test_bit(RXRPC_CALL_TX_ERROR, &call->flags))) {
 		trace_rxrpc_abort(call->debug_id, rxrpc_sendmsg_tx_error,
 				  call->cid, call->call_id, call->rx_consumed,
 				  0, -EIO);
-		return -EIO;
+		ret = -EIO;
+		goto out_unlock;
 	}
 
 	timeo = sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
 
 	ret = rxrpc_wait_to_be_connected(call, &timeo);
 	if (ret < 0)
-		return ret;
+		goto out_unlock;
 
 	if (call->conn->state == RXRPC_CONN_CLIENT_UNSECURED) {
 		ret = rxrpc_init_client_conn_security(call->conn);
 		if (ret < 0)
-			return ret;
+			goto out_unlock;
 	}
 
 	/* this should be in poll */
@@ -456,7 +458,7 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 				if (ret == -ENOMEM)
 					goto maybe_error;
 				set_bit(RXRPC_CALL_TX_ERROR, &call->flags);
-				goto out;
+				goto out_txb;
 			}
 
 			if (msg_data_left(msg) == 0 && !more)
@@ -468,51 +470,58 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 
 success:
 	ret = copied;
-out:
+out_txb:
 	call->tx_pending = txb;
+out_unlock:
+	mutex_unlock(&call->user_mutex);
 	_leave(" = %d", ret);
 	return ret;
 
 call_terminated:
 	rxrpc_put_txbuf(txb, rxrpc_txbuf_put_send_aborted);
-	_leave(" = %d", call->error);
-	return call->error;
+	call->tx_pending = NULL;
+	ret = call->error;
+	goto out_unlock;
 
 maybe_error:
 	if (copied) {
 		if (rxrpc_call_is_complete(call) &&
 		    call->error < 0) {
 			ret = call->error;
-			goto out;
+			goto out_unlock;
 		}
 		goto success;
 	}
-	goto out;
+	goto out_txb;
 
 efault:
 	ret = -EFAULT;
-	goto out;
+	goto out_txb;
 
 wait_for_space:
 	ret = -EAGAIN;
 	if (msg->msg_flags & MSG_DONTWAIT)
 		goto maybe_error;
+	call->tx_pending = txb;
+	txb = NULL;
 	mutex_unlock(&call->user_mutex);
-	*_dropped_lock = true;
+
 	ret = rxrpc_wait_for_tx_window(rx, call, &timeo,
 				       msg->msg_flags & MSG_WAITALL);
 	if (ret < 0)
-		goto maybe_error;
+		goto out_nolock;
 	if (call->interruptibility == RXRPC_INTERRUPTIBLE) {
 		if (mutex_lock_interruptible(&call->user_mutex) < 0) {
 			ret = sock_intr_errno(timeo);
-			goto maybe_error;
+			goto out_nolock;
 		}
 	} else {
 		mutex_lock(&call->user_mutex);
 	}
-	*_dropped_lock = false;
 	goto reload;
+out_nolock:
+	_leave(" = %d [intr]", ret);
+	return copied ?: ret;
 }
 
 /*
@@ -787,8 +796,8 @@ int rxrpc_do_sendmsg(struct rxrpc_sock *rx, struct msghdr *msg, size_t len)
 		ret = 0;
 		break;
 	case RXRPC_CMD_SEND_DATA:
-		ret = rxrpc_send_data(rx, call, msg, len, NULL, &dropped_lock);
-		break;
+		ret = rxrpc_send_data(rx, call, msg, len, NULL);
+		goto error_put;
 	default:
 		ret = -EINVAL;
 		break;
@@ -826,7 +835,6 @@ int rxrpc_kernel_send_data(struct socket *sock, struct rxrpc_call *call,
 			   struct msghdr *msg, size_t len,
 			   rxrpc_notify_end_tx_t notify_end_tx)
 {
-	bool dropped_lock = false;
 	int ret;
 
 	_enter("{%d},", call->debug_id);
@@ -837,12 +845,10 @@ int rxrpc_kernel_send_data(struct socket *sock, struct rxrpc_call *call,
 	mutex_lock(&call->user_mutex);
 
 	ret = rxrpc_send_data(rxrpc_sk(sock->sk), call, msg, len,
-			      notify_end_tx, &dropped_lock);
+			      notify_end_tx);
 	if (ret == -ESHUTDOWN)
 		ret = call->error;
 
-	if (!dropped_lock)
-		mutex_unlock(&call->user_mutex);
 	_leave(" = %d", ret);
 	return ret;
 }


