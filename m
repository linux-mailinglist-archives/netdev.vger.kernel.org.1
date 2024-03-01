Return-Path: <netdev+bounces-76616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AE286E5E6
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 17:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66C091C22CF9
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 16:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277D53CF7E;
	Fri,  1 Mar 2024 16:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FE+199JX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E603C470
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 16:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709311128; cv=none; b=jK+RDLulxsbKtfdd5rY+h+L1ExLuXbKPeS69sSai+N0eyYX74CbGw8FmIv4tD9z6nCHjeUvk7YWhL4GmXOcdZxMHNvNNBHOhgA9/v+6kAX6LDBUF91kuP51scB9jruHzi+3nkCIkqPD7HRaXgDmarwXcQ0c11B0DUjY9otXnFa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709311128; c=relaxed/simple;
	bh=xqU7TdJ6uMoTB6NE2LCdz37Pqfl01I9/rlA/Td1pBIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kg3D86BpAOcQuSRBz6R0qfMXB0THVGq8Ou9bfHSKLi+JPd7Zs3j9KMxZx8nKIvgmUNxmJNxcqZiepqlE1uhG3V0wPSBKzwVBVEiJLkLa+hUq4k/KXR3KkM1SxGhwdckvVOT7mat1wJlYa0+WbhrutZ+i+Vvr+2MacYtOeFQNdvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FE+199JX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709311125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dFZQL0DrD/luJDZ0nEKBrlgAEZrrkxfF6eLg9CJqo1A=;
	b=FE+199JXDWCJ+cD/J1gtshVCXCwcHIB1/+PLDAAjg1fo0fP7VaGWxQRjoneWiafERuBFUM
	LkCD8Um6lshlCArvyqqgUVm5SYqYLEWt5XNI+7ksC2mfZdBO0nZjuQaYGeEGytE+IsvV21
	wh6uU4+yb8XYssVaAl3hO8mJFrwF/z0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-508-SutcDLVMOKOwhF-oDdjF8Q-1; Fri,
 01 Mar 2024 11:38:41 -0500
X-MC-Unique: SutcDLVMOKOwhF-oDdjF8Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C9AD73C2E0A5;
	Fri,  1 Mar 2024 16:38:40 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AA063F96E8;
	Fri,  1 Mar 2024 16:38:39 +0000 (UTC)
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
Subject: [PATCH net-next 16/21] rxrpc: Don't permit resending after all Tx packets acked
Date: Fri,  1 Mar 2024 16:37:48 +0000
Message-ID: <20240301163807.385573-17-dhowells@redhat.com>
In-Reply-To: <20240301163807.385573-1-dhowells@redhat.com>
References: <20240301163807.385573-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Once all the packets transmitted as part of a call have been acked, don't
permit any resending.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/call_event.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index 58826710322d..ef28ebf37c7d 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -450,7 +450,9 @@ bool rxrpc_input_call_event(struct rxrpc_call *call, struct sk_buff *skb)
 		rxrpc_send_ACK(call, RXRPC_ACK_PING, 0,
 			       rxrpc_propose_ack_ping_for_lost_ack);
 
-	if (resend && __rxrpc_call_state(call) != RXRPC_CALL_CLIENT_RECV_REPLY)
+	if (resend &&
+	    __rxrpc_call_state(call) != RXRPC_CALL_CLIENT_RECV_REPLY &&
+	    !test_bit(RXRPC_CALL_TX_ALL_ACKED, &call->flags))
 		rxrpc_resend(call, NULL);
 
 	if (test_and_clear_bit(RXRPC_CALL_RX_IS_IDLE, &call->flags))


