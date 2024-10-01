Return-Path: <netdev+bounces-130880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 709E998BD7D
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 15:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 207A91F2386E
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 13:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90631C6898;
	Tue,  1 Oct 2024 13:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EjsHcyVd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516251C6881
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 13:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727789244; cv=none; b=iRoFHLRdN4LDObFBW8e6OM/8oRU9HdIMshxm4t6Bs+JS49gd/sAPS0jhj559VHeqDcS9K8oJFGnCUPH1UgAPwBS70gRz6+pIqtHMe64/Of5TwQpEz8c50XlB9QX7HB+/fF3u9e8h7zklB2+KaaLE32BCf5LLd+luh+o5q9kaf2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727789244; c=relaxed/simple;
	bh=JNzAp1yMKbV8lpc6uCr8lJxmSscW4K2GTVrGuzAx3SQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZJE1dAEKC/YL1lzFR3iGd8cOoCyhC7pvYywcU8MiO2xdzbh6yWVlRxc1VNSPPc/xPtRfT9i3ZQkjD8WJDJnQ+RERCQyNHlnX+RKON+fKaSP+GV4j+oqj3pnaKXS/mB7WIpnU1P05dHlij8dreLlSCbJLx+O600jVXWsX8sZTRYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EjsHcyVd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727789242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+K/uFnjY9rI4dQD1VXRi5j3BHKaMNfn7A9yy5gGESz4=;
	b=EjsHcyVdtlRQaIAKDLOuU14dsDJyN0lRVkJbUXGwpvzN7OF8/PhHs/rj8K7JKHjg9sUqwD
	cfK6ZzmXp1CO6rSRx3lLK9mToofG6fajp/8GGy4IM0JD3Uh6XlC/KnBoFXya+BlWnnE22w
	5j9gkPhHVEHiA9tlFc54G/vaYgvW2SA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-aMLXcemqPdW0D3y3Ac5Upg-1; Tue,
 01 Oct 2024 09:27:17 -0400
X-MC-Unique: aMLXcemqPdW0D3y3Ac5Upg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 214941943CDC;
	Tue,  1 Oct 2024 13:27:16 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.145])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1AD113003DEC;
	Tue,  1 Oct 2024 13:27:12 +0000 (UTC)
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
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH net 2/2] rxrpc: Fix uninitialised variable in rxrpc_send_data()
Date: Tue,  1 Oct 2024 14:26:59 +0100
Message-ID: <20241001132702.3122709-3-dhowells@redhat.com>
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

Fix the uninitialised txb variable in rxrpc_send_data() by moving the code
that loads it above all the jumps to maybe_error, txb being stored back
into call->tx_pending right before the normal return.

Fixes: b0f571ecd794 ("rxrpc: Fix locking in rxrpc's sendmsg")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lists.infradead.org/pipermail/linux-afs/2024-October/008896.html
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/sendmsg.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index 894b8fa68e5e..23d18fe5de9f 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -303,6 +303,11 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 	sk_clear_bit(SOCKWQ_ASYNC_NOSPACE, sk);
 
 reload:
+	txb = call->tx_pending;
+	call->tx_pending = NULL;
+	if (txb)
+		rxrpc_see_txbuf(txb, rxrpc_txbuf_see_send_more);
+
 	ret = -EPIPE;
 	if (sk->sk_shutdown & SEND_SHUTDOWN)
 		goto maybe_error;
@@ -329,11 +334,6 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 			goto maybe_error;
 	}
 
-	txb = call->tx_pending;
-	call->tx_pending = NULL;
-	if (txb)
-		rxrpc_see_txbuf(txb, rxrpc_txbuf_see_send_more);
-
 	do {
 		if (!txb) {
 			size_t remain;


