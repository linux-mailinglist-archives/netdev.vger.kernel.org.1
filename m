Return-Path: <netdev+bounces-79584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3050879FB9
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 00:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35FB2283261
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 23:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2EF4D11B;
	Tue, 12 Mar 2024 23:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RwWmBRsQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9014482FE
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 23:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710286657; cv=none; b=E3pkv7rdDbgpacLP4ID3H6O2vB5wn6t7joNx+4NDMGOm2F/QFN8RsEyLOlKyhit5gFAxcLoTsFEFJ3TGytwGFw/PyylB/nptUDTpYVrE2Fmf2kGPrnmOhfzYQM/CLKTK3clNXyxHTT1+BN2vx3PJabs1eo13aIGPdsFVBO/0Nak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710286657; c=relaxed/simple;
	bh=w8JCsLSjSA3OkQoV28nEFem36dFCa/7sa9d7M6Kmb8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LPjEJHc0eoB5xXTNNmWyiLBid7m+I3ely3vKvPn7/RuWb5rTqCblRaR57jGwP5LDXdJNffCtDFOVPy4hbJImJd6CqTiQSXB/lW/3yzW9hGp8e/7tZxCImguItpUfeUhv7lWdOtKCLHdRimaLVsOLeNngpVa61YVIFmRk7DvZYHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RwWmBRsQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710286654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9OX7Txmvz9CCuXto10fOD2XvYnGo3IOMbl07Vyopd3Y=;
	b=RwWmBRsQvm4iAsDjYPWINIGLJ8A4fEq3K3KieqexqPNg6hMlvoYa4JNMkzqRRQhanhtZ50
	FS03V9GyqZUjF3JaJZ4tPcufTco8ynnGYagtTZSnbFM9hxeFanlMmZuc+xTDBSKkWOmy/7
	DOyoMf6ELx+jThPbMMEWLV0UPh+qwe4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-uMavIwFdNDGV7jNNc5g8HA-1; Tue, 12 Mar 2024 19:37:33 -0400
X-MC-Unique: uMavIwFdNDGV7jNNc5g8HA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C4527101A552;
	Tue, 12 Mar 2024 23:37:32 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.10])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8C54F10F53;
	Tue, 12 Mar 2024 23:37:31 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/2] rxrpc: Fix error check on ->alloc_txbuf()
Date: Tue, 12 Mar 2024 23:37:18 +0000
Message-ID: <20240312233723.2984928-3-dhowells@redhat.com>
In-Reply-To: <20240312233723.2984928-1-dhowells@redhat.com>
References: <20240312233723.2984928-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

rxrpc_alloc_*_txbuf() and ->alloc_txbuf() return NULL to indicate no
memory, but rxrpc_send_data() uses IS_ERR().

Fix rxrpc_send_data() to check for NULL only and set -ENOMEM if it sees
that.

Fixes: 49489bb03a50 ("rxrpc: Do zerocopy using MSG_SPLICE_PAGES and page frags")
Signed-off-by: David Howells <dhowells@redhat.com>
Reported-by: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/sendmsg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index 6f765768c49c..894b8fa68e5e 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -349,8 +349,8 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 			 */
 			remain = more ? INT_MAX : msg_data_left(msg);
 			txb = call->conn->security->alloc_txbuf(call, remain, sk->sk_allocation);
-			if (IS_ERR(txb)) {
-				ret = PTR_ERR(txb);
+			if (!txb) {
+				ret = -ENOMEM;
 				goto maybe_error;
 			}
 		}


