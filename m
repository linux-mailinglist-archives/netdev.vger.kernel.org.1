Return-Path: <netdev+bounces-44694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DF97D9486
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 12:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 621B2B209A0
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 10:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DBC171AD;
	Fri, 27 Oct 2023 09:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A02EjYVE"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C5C168D6
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 09:59:55 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B701BD
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 02:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698400792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=TZ0xtpqTEhLFnw9/Pr4Oy+UYb54uDvsk+Fp9NNzZ9YA=;
	b=A02EjYVEA4qTLP4w7mpE/WP4arUpIZmtzYdt/zLDDyRyOrOr8lChXVmbjsACUUvre1BoLP
	a9ziZhXdgz2f/EJjXco4rZscgqGXg2Yx2567SN4aX/em4TiXkmYonvBpkEgTwsgCpWo7ZU
	IiMBw+RRBkCt/f0E2i9U9spvw3q6gYA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-a1feGKiGP7Gl7wRQ1yLo5w-1; Fri, 27 Oct 2023 05:59:46 -0400
X-MC-Unique: a1feGKiGP7Gl7wRQ1yLo5w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 46FD08966A6;
	Fri, 27 Oct 2023 09:59:46 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.76])
	by smtp.corp.redhat.com (Postfix) with SMTP id C5C1F1121319;
	Fri, 27 Oct 2023 09:59:43 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 27 Oct 2023 11:58:45 +0200 (CEST)
Date: Fri, 27 Oct 2023 11:58:42 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, linux-afs@lists.infradead.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rxrpc_find_service_conn_rcu: use read_seqbegin() rather than
 read_seqbegin_or_lock()
Message-ID: <20231027095842.GA30868@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

read_seqbegin_or_lock() makes no sense unless you make "seq" odd
after the lockless access failed. See thread_group_cputime() as
an example, note that it does nextseq = 1 for the 2nd round.

So this code can use read_seqbegin() without changing the current
behaviour.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 net/rxrpc/conn_service.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/rxrpc/conn_service.c b/net/rxrpc/conn_service.c
index 89ac05a711a4..bfafe58681d9 100644
--- a/net/rxrpc/conn_service.c
+++ b/net/rxrpc/conn_service.c
@@ -25,7 +25,7 @@ struct rxrpc_connection *rxrpc_find_service_conn_rcu(struct rxrpc_peer *peer,
 	struct rxrpc_conn_proto k;
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
 	struct rb_node *p;
-	unsigned int seq = 0;
+	unsigned int seq;
 
 	k.epoch	= sp->hdr.epoch;
 	k.cid	= sp->hdr.cid & RXRPC_CIDMASK;
@@ -35,7 +35,7 @@ struct rxrpc_connection *rxrpc_find_service_conn_rcu(struct rxrpc_peer *peer,
 		 * under just the RCU read lock, so we have to check for
 		 * changes.
 		 */
-		read_seqbegin_or_lock(&peer->service_conn_lock, &seq);
+		seq = read_seqbegin(&peer->service_conn_lock);
 
 		p = rcu_dereference_raw(peer->service_conns.rb_node);
 		while (p) {
@@ -49,9 +49,8 @@ struct rxrpc_connection *rxrpc_find_service_conn_rcu(struct rxrpc_peer *peer,
 				break;
 			conn = NULL;
 		}
-	} while (need_seqretry(&peer->service_conn_lock, seq));
+	} while (read_seqretry(&peer->service_conn_lock, seq));
 
-	done_seqretry(&peer->service_conn_lock, seq);
 	_leave(" = %d", conn ? conn->debug_id : -1);
 	return conn;
 }
-- 
2.25.1.362.g51ebf55



