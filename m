Return-Path: <netdev+bounces-130879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE2E98BD78
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 15:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59EE5B21653
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 13:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3071C579F;
	Tue,  1 Oct 2024 13:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WwJoZjzg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044901C579E
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 13:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727789239; cv=none; b=inqzzyeKw44VoXUG9Q83vgjDg5JIvmNNaO19oEvVx2jHHypSlQ31ulc2GWyXMgLCWlZzl5PMRT23tR207Adimc6nkAcZIDpZAy/2ZmV9Dtibkfi/8ZiDJAIKIgqGMtg8lnb8LhrH7OqmZKfaN8ZABeIMIlvuvnDPhSGIVdnNPgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727789239; c=relaxed/simple;
	bh=vs+8a8RBHdEbbPO140pEJLtA7dPw90dKDnxZhk3Dau4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BpHYJvTJDdXZD/LtN7RKd0v234FFcD3rj8OssTxgUnbl5IMQJYwM2n16Nt00LndwVPQxoj4zOf0f2/6cNML9Gr5oyuFBW2LBknXH/Dvsr1JX/P/u+iODbyOX9hNOPJ7ni+JWW7kFMY9dQIPw+91BhqBhnHMXZbbgMIMhCJr5rxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WwJoZjzg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727789236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JEqhIvaP79zPkuiYDFnhoiphOYDN3GkfqESEaY0OOX4=;
	b=WwJoZjzgYrivUlDzzjDOmcg3QrDqQ/evvg2eeVBGDMuv1EpM+81N0WUxaZvaGFfQyk1pwu
	i3Mi4rpXrXHyt+dpBX2IfOrFopmmX+84lEFmHZBF2Owr+R5SUMbcf4Z563iHvxYKMIA8dA
	+SK3WSmmpMFOwQZFHO9c3U9a2UILNz0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-381-OlPc42_BPPKQTK-8u2HGvw-1; Tue,
 01 Oct 2024 09:27:13 -0400
X-MC-Unique: OlPc42_BPPKQTK-8u2HGvw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ACA121944DC4;
	Tue,  1 Oct 2024 13:27:11 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.145])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F0D113003DEC;
	Tue,  1 Oct 2024 13:27:08 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	yuxuanzhe@outlook.com,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net 1/2] rxrpc: Fix a race between socket set up and I/O thread creation
Date: Tue,  1 Oct 2024 14:26:58 +0100
Message-ID: <20241001132702.3122709-2-dhowells@redhat.com>
In-Reply-To: <20241001132702.3122709-1-dhowells@redhat.com>
References: <20241001132702.3122709-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

In rxrpc_open_socket(), it sets up the socket and then sets up the I/O
thread that will handle it.  This is a problem, however, as there's a gap
between the two phases in which a packet may come into rxrpc_encap_rcv()
from the UDP packet but we oops when trying to wake the not-yet created I/O
thread.

As a quick fix, just make rxrpc_encap_rcv() discard the packet if there's
no I/O thread yet.

A better, but more intrusive fix would perhaps be to rearrange things such
that the socket creation is done by the I/O thread.

Fixes: a275da62e8c1 ("rxrpc: Create a per-local endpoint receive queue and I/O thread")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: yuxuanzhe@outlook.com
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/ar-internal.h  |  2 +-
 net/rxrpc/io_thread.c    | 10 ++++++++--
 net/rxrpc/local_object.c |  2 +-
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 80d682f89b23..d0fd37bdcfe9 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -1056,7 +1056,7 @@ bool rxrpc_direct_abort(struct sk_buff *skb, enum rxrpc_abort_reason why,
 int rxrpc_io_thread(void *data);
 static inline void rxrpc_wake_up_io_thread(struct rxrpc_local *local)
 {
-	wake_up_process(local->io_thread);
+	wake_up_process(READ_ONCE(local->io_thread));
 }
 
 static inline bool rxrpc_protocol_error(struct sk_buff *skb, enum rxrpc_abort_reason why)
diff --git a/net/rxrpc/io_thread.c b/net/rxrpc/io_thread.c
index 0300baa9afcd..07c74c77d802 100644
--- a/net/rxrpc/io_thread.c
+++ b/net/rxrpc/io_thread.c
@@ -27,11 +27,17 @@ int rxrpc_encap_rcv(struct sock *udp_sk, struct sk_buff *skb)
 {
 	struct sk_buff_head *rx_queue;
 	struct rxrpc_local *local = rcu_dereference_sk_user_data(udp_sk);
+	struct task_struct *io_thread;
 
 	if (unlikely(!local)) {
 		kfree_skb(skb);
 		return 0;
 	}
+	io_thread = READ_ONCE(local->io_thread);
+	if (!io_thread) {
+		kfree_skb(skb);
+		return 0;
+	}
 	if (skb->tstamp == 0)
 		skb->tstamp = ktime_get_real();
 
@@ -47,7 +53,7 @@ int rxrpc_encap_rcv(struct sock *udp_sk, struct sk_buff *skb)
 #endif
 
 	skb_queue_tail(rx_queue, skb);
-	rxrpc_wake_up_io_thread(local);
+	wake_up_process(io_thread);
 	return 0;
 }
 
@@ -565,7 +571,7 @@ int rxrpc_io_thread(void *data)
 	__set_current_state(TASK_RUNNING);
 	rxrpc_see_local(local, rxrpc_local_stop);
 	rxrpc_destroy_local(local);
-	local->io_thread = NULL;
+	WRITE_ONCE(local->io_thread, NULL);
 	rxrpc_see_local(local, rxrpc_local_stopped);
 	return 0;
 }
diff --git a/net/rxrpc/local_object.c b/net/rxrpc/local_object.c
index 504453c688d7..f9623ace2201 100644
--- a/net/rxrpc/local_object.c
+++ b/net/rxrpc/local_object.c
@@ -232,7 +232,7 @@ static int rxrpc_open_socket(struct rxrpc_local *local, struct net *net)
 	}
 
 	wait_for_completion(&local->io_thread_ready);
-	local->io_thread = io_thread;
+	WRITE_ONCE(local->io_thread, io_thread);
 	_leave(" = 0");
 	return 0;
 


