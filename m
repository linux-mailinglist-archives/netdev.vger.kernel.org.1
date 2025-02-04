Return-Path: <netdev+bounces-162800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3D4A27F43
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 00:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 285331617C0
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 23:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BB021CFE2;
	Tue,  4 Feb 2025 23:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RtCEUzE8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51BF21C19C
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 23:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738710384; cv=none; b=pbApQ0VxJyiHEA0Hx2cDP7BFuEc47Sea1GfTS1QOCgwXX0WdAWcuIJNf4riLqnAqdSV1fWAvAGwopNkUr7rNdZht6nUnecRb1UYOWrODxb1eEr20s5l8WELLRPBsVcj233JKhNXe8KVGAddeO+jmca9Y4dv5VNqKWnd9xfNl4YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738710384; c=relaxed/simple;
	bh=qEkY7XxGkCEF3AQi0Io9Bkec/bioDvlbYZUzk1M5kXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AjE0pmArXex9z5i9zI3NX4cA81Z1lR/FwspSNBXNBAlHdy9nPLqldJsTZuRe2kKaQOfX5xIY55RaADCrpgKt+FqmZaBWx8lamlS9GT9tA4Djf9EtDnvDu5GBpicNzYTG/b2lL7hDEssaIDBMJcOImupO95+4+Oo32B/VmqlSxCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RtCEUzE8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738710381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DELYEXA2VKqOYRUxHLcWM9e56mfc29fREdOPg/Pa7pY=;
	b=RtCEUzE8XGE8qQDtSAPu52SOqKqM9o9g1WFmP1OUgFPn7Vem33f5uxhizM6NWZ8C0jcHPu
	O4JtyygxGLhLU+mUcVsErI1Rsd7RIU/K5U3B1eR+sCZwjsWC1wkkqcf7G6CZT9Ly3J5r57
	SBvKQS4enOj3MIDPnHiIsrwDhBWwW0g=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-sov7j0r1Pdq9ABy25wv7FA-1; Tue,
 04 Feb 2025 18:06:19 -0500
X-MC-Unique: sov7j0r1Pdq9ABy25wv7FA-1
X-Mimecast-MFC-AGG-ID: sov7j0r1Pdq9ABy25wv7FA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 07AB11955DCB;
	Tue,  4 Feb 2025 23:06:18 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.92])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2D2E630001BE;
	Tue,  4 Feb 2025 23:06:14 +0000 (UTC)
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
	Simon Horman <horms@kernel.org>
Subject: [PATCH net v2 2/2] rxrpc: Fix race in call state changing vs recvmsg()
Date: Tue,  4 Feb 2025 23:05:54 +0000
Message-ID: <20250204230558.712536-3-dhowells@redhat.com>
In-Reply-To: <20250204230558.712536-1-dhowells@redhat.com>
References: <20250204230558.712536-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

There's a race in between the rxrpc I/O thread recording the end of the
receive phase of a call and recvmsg() examining the state of the call to
determine whether it has completed.

The problem is that call->_state records the I/O thread's view of the call,
not the application's view (which may lag), so that alone is not
sufficient.  To this end, the application also checks whether there is
anything left in call->recvmsg_queue for it to pick up.  The call must be
in state RXRPC_CALL_COMPLETE and the recvmsg_queue empty for the call to be
considered fully complete.

In rxrpc_input_queue_data(), the latest skbuff is added to the queue and
then, if it was marked as LAST_PACKET, the state is advanced...  But this
is two separate operations with no locking around them.

As a consequence, the lack of locking means that sendmsg() can jump into
the gap on a service call and attempt to send the reply - but then get
rejected because the I/O thread hasn't advanced the state yet.

Simply flipping the order in which things are done isn't an option as that
impacts the client side, causing the checks in rxrpc_kernel_check_life() as
to whether the call is still alive to race instead.

Fix this by moving the update of call->_state inside the skb queue
spinlocked section where the packet is queued on the I/O thread side.

rxrpc's recvmsg() will then automatically sync against this because it has
to take the call->recvmsg_queue spinlock in order to dequeue the last
packet.

rxrpc's sendmsg() doesn't need amending as the app shouldn't be calling it
to send a reply until recvmsg() indicates it has returned all of the
request.

Fixes: 93368b6bd58a ("rxrpc: Move call state changes from recvmsg to I/O thread")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/input.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index 4a152f3c831f..9047ba13bd31 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -448,11 +448,19 @@ static void rxrpc_input_queue_data(struct rxrpc_call *call, struct sk_buff *skb,
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
 	bool last = sp->hdr.flags & RXRPC_LAST_PACKET;
 
-	skb_queue_tail(&call->recvmsg_queue, skb);
+	spin_lock_irq(&call->recvmsg_queue.lock);
+
+	__skb_queue_tail(&call->recvmsg_queue, skb);
 	rxrpc_input_update_ack_window(call, window, wtop);
 	trace_rxrpc_receive(call, last ? why + 1 : why, sp->hdr.serial, sp->hdr.seq);
 	if (last)
+		/* Change the state inside the lock so that recvmsg syncs
+		 * correctly with it and using sendmsg() to send a reply
+		 * doesn't race.
+		 */
 		rxrpc_end_rx_phase(call, sp->hdr.serial);
+
+	spin_unlock_irq(&call->recvmsg_queue.lock);
 }
 
 /*


