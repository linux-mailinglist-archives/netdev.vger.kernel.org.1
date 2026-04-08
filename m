Return-Path: <netdev+bounces-276490-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGnFLOlI1mkFDQgAu9opvQ
	(envelope-from <netdev+bounces-276490-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 14:24:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCF93BBF57
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 14:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7759B307D44E
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 12:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF05B37F8CF;
	Wed,  8 Apr 2026 12:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XXGb9dV0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423B23CCFA7
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 12:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775650513; cv=none; b=EHNt1IJCwadh9MkYsTtzXf+IKZ7ZF1RvARm6H4r33SdBXRVm1WL+oFMJG9RjtzCBHL15GV7fuNUm/yoeXpG/9jfRKj1n34jCca2k3XDTzRC3itzvCQ1A4X58o4NFqI8gYTbFZcVRfUPCsk+lXPAl4A5NCJvsrkbOjLV1oUAu52g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775650513; c=relaxed/simple;
	bh=wEzSkK7Crlc3chEp2Nz/wl2pXtl4IbkDnHmIcED4Q9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qpnLf3hiCjIPshIM4Mq08/9aFF3TQagU0/+gbaz3i+UTUPZrPkWb+JcNAhEwOUI5ps8YseojAfVugAo4gyD8ZANmzw+a1AyZo0P8HMKIuqKjKZIfW/oz8KTCWxOhScEKqwOWe5Yj8iK3nm50byzFfaB+ClkKP9PNd/uklI213yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XXGb9dV0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775650511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q5N4y8rajQ0IsNQ9scqfoNcTpHF8JV0bgLhkEwi8KvI=;
	b=XXGb9dV0fxjE4n+CpDyspCsWEe0euNvSe3aM3PHLPHpv428bFLhZyt9s+tfVhSUjXGHE1K
	9PFKvn1o6OrI7/4ve+mb0/ur0VN3TCUdRWtqUf1P2OXUc6J0l6zCGpX0GqxdIo0PfBWiNe
	Cs7J1G6Bx/Y9lK5OBpXjYYMqDYQLix4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-331-Vpg1D1fGP1OSuZldGj6XMA-1; Wed,
 08 Apr 2026 08:15:08 -0400
X-MC-Unique: Vpg1D1fGP1OSuZldGj6XMA-1
X-Mimecast-MFC-AGG-ID: Vpg1D1fGP1OSuZldGj6XMA_1775650505
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EAE9618002DD;
	Wed,  8 Apr 2026 12:15:04 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.32.94])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EF41619560A6;
	Wed,  8 Apr 2026 12:14:59 +0000 (UTC)
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
	Wang Jie <jiewang2024@lzu.edu.cn>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Yuan Tan <yuantan098@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Yang Yang <n05ec@lzu.edu.cn>,
	Jeffrey Altman <jaltman@auristor.com>,
	Simon Horman <horms@kernel.org>,
	stable@kernel.org
Subject: [PATCH net v5 20/21] rxrpc: only handle RESPONSE during service challenge
Date: Wed,  8 Apr 2026 13:12:48 +0100
Message-ID: <20260408121252.2249051-21-dhowells@redhat.com>
In-Reply-To: <20260408121252.2249051-1-dhowells@redhat.com>
References: <20260408121252.2249051-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,auristor.com,kernel.org,davemloft.net,google.com,lists.infradead.org,vger.kernel.org,lzu.edu.cn,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-276490-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[auristor.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lzu.edu.cn:email,infradead.org:email,davemloft.net:email]
X-Rspamd-Queue-Id: ABCF93BBF57
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Wang Jie <jiewang2024@lzu.edu.cn>

Only process RESPONSE packets while the service connection is still in
RXRPC_CONN_SERVICE_CHALLENGING. Check that state under state_lock before
running response verification and security initialization, then use a local
secured flag to decide whether to queue the secured-connection work after
the state transition. This keeps duplicate or late RESPONSE packets from
re-running the setup path and removes the unlocked post-transition state
test.

Fixes: 17926a79320a ("net: AF_RXRPC: Provide secure RxRPC sockets for use by userspace and kernel both")
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Co-developed-by: Yuan Tan <yuantan098@gmail.com>
Signed-off-by: Yuan Tan <yuantan098@gmail.com>
Suggested-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Jie Wang <jiewang2024@lzu.edu.cn>
Signed-off-by: Yang Yang <n05ec@lzu.edu.cn>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
cc: stable@kernel.org
---
 net/rxrpc/conn_event.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
index c50cbfc5a313..9a41ec708aeb 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -247,6 +247,7 @@ static int rxrpc_process_event(struct rxrpc_connection *conn,
 			       struct sk_buff *skb)
 {
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
+	bool secured = false;
 	int ret;
 
 	if (conn->state == RXRPC_CONN_ABORTED)
@@ -262,6 +263,13 @@ static int rxrpc_process_event(struct rxrpc_connection *conn,
 		return ret;
 
 	case RXRPC_PACKET_TYPE_RESPONSE:
+		spin_lock_irq(&conn->state_lock);
+		if (conn->state != RXRPC_CONN_SERVICE_CHALLENGING) {
+			spin_unlock_irq(&conn->state_lock);
+			return 0;
+		}
+		spin_unlock_irq(&conn->state_lock);
+
 		ret = conn->security->verify_response(conn, skb);
 		if (ret < 0)
 			return ret;
@@ -272,11 +280,13 @@ static int rxrpc_process_event(struct rxrpc_connection *conn,
 			return ret;
 
 		spin_lock_irq(&conn->state_lock);
-		if (conn->state == RXRPC_CONN_SERVICE_CHALLENGING)
+		if (conn->state == RXRPC_CONN_SERVICE_CHALLENGING) {
 			conn->state = RXRPC_CONN_SERVICE;
+			secured = true;
+		}
 		spin_unlock_irq(&conn->state_lock);
 
-		if (conn->state == RXRPC_CONN_SERVICE) {
+		if (secured) {
 			/* Offload call state flipping to the I/O thread.  As
 			 * we've already received the packet, put it on the
 			 * front of the queue.


