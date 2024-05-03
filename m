Return-Path: <netdev+bounces-93297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A48B8BAF6D
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 17:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 158E928253D
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 15:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96394156647;
	Fri,  3 May 2024 15:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ul1yg52R"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D26155324
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 15:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714748891; cv=none; b=ppsVcTfQHXP0tYaeAl/1YCoRM8uFMO7BBOxJYQnnsTbQ4JP8GFJEbzU1yIbWK2t4/gKuXIuM3FZM8gXEpX04upDqvzbXgqOPKHchq0YR1ZYi4YiNrQfbAxEKm4IsgqE8RMc/XE3PRSkAx9PZx4v/E/j8m9++maavjvAc9wF6ch8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714748891; c=relaxed/simple;
	bh=xy1Hw4MswExN1OdkiPVvRVbqAuA98A/1etNQTA0FN+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M0N9SqvJfXHA5LxFvNph8qnUPE6EqJHtvSqWnoGqiXY/jq1b46uWYCBC7Cz9uNPMZv7/l3zRheHr95l5wyHLtz3zc7wQTsEGtPggj0JtcvP+MqG2PhYMlB7VUXFBTj5gO5d0fx1Q43eOJkruJjx/cQjJsSH9q9oN668Zc8gwBSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ul1yg52R; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714748886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l9dXy0rv6aK0Lq7IHhwyUaBVQj8j6zmf35k0APaTUmg=;
	b=Ul1yg52RyVRf/Rra6O+6g0Pm/1rBZvnkh//xzhBEszwGaAYb7rWeABFRX94N9mHGXkMf3K
	Fq/BzBBISxUGs8FaVYCIhLIB4xFbxgj/Y18ewloxalOQOwENqNbJ3ZyjTOwd0M3yGdBoxY
	thOv5w5pGrkTNbCifFUR1p/VZl6zQ58=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-MU3OpqwHP4CISLIU_yRTww-1; Fri, 03 May 2024 11:08:03 -0400
X-MC-Unique: MU3OpqwHP4CISLIU_yRTww-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 165818A9149;
	Fri,  3 May 2024 15:08:03 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0236D2031A45;
	Fri,  3 May 2024 15:08:01 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 4/5] rxrpc: Change how the MORE-PACKETS rxrpc wire header flag is driven
Date: Fri,  3 May 2024 16:07:42 +0100
Message-ID: <20240503150749.1001323-5-dhowells@redhat.com>
In-Reply-To: <20240503150749.1001323-1-dhowells@redhat.com>
References: <20240503150749.1001323-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Currently, the MORE-PACKETS rxrpc header flag is set by sendmsg trying to
guess how it should be set by looking to see if there's space in the Tx
window and setting it if there is - long before the packet gets
transmitted (and it gets left in this state).  As a consequence, it's not
very meaningful.

Change this such that it is turned on at the point of transmission if we
have more packets after it in the send buffers and it is left clear if we
don't yet.

Fixes: 17926a79320a ("[AF_RXRPC]: Provide secure RxRPC sockets for use by userspace and kernel both")
cc: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/output.c  | 8 +++++++-
 net/rxrpc/sendmsg.c | 3 ---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index bf2d0f847cdb..4ebd0bd40a02 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -330,7 +330,7 @@ static void rxrpc_prepare_data_subpacket(struct rxrpc_call *call, struct rxrpc_t
 	struct rxrpc_wire_header *whdr = txb->kvec[0].iov_base;
 	enum rxrpc_req_ack_trace why;
 	struct rxrpc_connection *conn = call->conn;
-	bool last;
+	bool more, last;
 	u8 flags;
 
 	_enter("%x,{%d}", txb->seq, txb->len);
@@ -345,6 +345,12 @@ static void rxrpc_prepare_data_subpacket(struct rxrpc_call *call, struct rxrpc_t
 	flags = txb->flags & RXRPC_TXBUF_WIRE_FLAGS;
 	last = txb->flags & RXRPC_LAST_PACKET;
 
+	more = (!last &&
+		(!list_is_last(&txb->call_link, &call->tx_buffer) ||
+		 !list_empty(&call->tx_sendmsg)));
+	if (more)
+		flags |= RXRPC_MORE_PACKETS;
+
 	/* If our RTT cache needs working on, request an ACK.  Also request
 	 * ACKs if a DATA packet appears to have been lost.
 	 *
diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index 894b8fa68e5e..eaf4441a340b 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -384,9 +384,6 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 		    (msg_data_left(msg) == 0 && !more)) {
 			if (msg_data_left(msg) == 0 && !more)
 				txb->flags |= RXRPC_LAST_PACKET;
-			else if (call->tx_top - call->acks_hard_ack <
-				 call->tx_winsize)
-				txb->flags |= RXRPC_MORE_PACKETS;
 
 			ret = call->security->secure_packet(call, txb);
 			if (ret < 0)


