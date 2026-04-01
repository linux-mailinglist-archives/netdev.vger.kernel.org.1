Return-Path: <netdev+bounces-274057-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFKkAOT7zGnRYgYAu9opvQ
	(envelope-from <netdev+bounces-274057-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 13:05:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 858293790BC
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 13:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E584C3070C6F
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 11:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B643F8806;
	Wed,  1 Apr 2026 10:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="db47G0l3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66473F8805
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 10:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775041059; cv=none; b=XBjEs5FVo308KxVW3jnpRai0ViyxZhZUWs1DG2wDjtIh88ZqFynkkxSoHbAgkHv8ZCSKg5iqztUCmpjlJv8NxgsgLGgCZlu9Z7pTJYrk4pqYJg9bbibTWzDZL5I/ipJfQ87+htmGz55eGz2q0mhvyu/wXrqoWxFe928Pod3mVV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775041059; c=relaxed/simple;
	bh=dETvW09GhXLGNeO1xyDqPkq/bSzSBmA0bRuVutPwoNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aX9AL38GTQuNFhZgkq2Ap3kwPeMgENaWFWIj/SD3iia+tq34oLpgbslEVtvdiWmJcxn7q/SQMFcD9GQXMMFOwEmZS12JlTLWNcAKbZS6LQCwmSodBR8IzV28JQvijPqD+C9D5wgCgnGZauI6g1Mh1jwBzExRrY7cYF0pGMmhD1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=db47G0l3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775041057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IyvzpHLTaSD//xZgQtcTYLO3HI+bGdy75Y+Sf6QrB0M=;
	b=db47G0l3ggluRXFxWWW6YH22v8LnS8QVq95P9cbm7L7N/QXlhSovVDJnSZdxa5AA5vN5II
	zmos8nTSERN0e1bXjn45VTEuGcy2GYqiFM1jBBnHB0cKko+i1YjgpoaM/XEdRxf0qN2b0K
	JknWEww8AN628uS3Z5C5ASevDvoWfas=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-nmXir3hmOnmwrU3GiVMbDw-1; Wed,
 01 Apr 2026 06:57:33 -0400
X-MC-Unique: nmXir3hmOnmwrU3GiVMbDw-1
X-Mimecast-MFC-AGG-ID: nmXir3hmOnmwrU3GiVMbDw_1775041051
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4553E18005B0;
	Wed,  1 Apr 2026 10:57:31 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.35.245])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8923119560AB;
	Wed,  1 Apr 2026 10:57:26 +0000 (UTC)
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
	Douya Le <ldy3087146292@gmail.com>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Yuan Tan <tanyuan98@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Ao Zhou <n05ec@lzu.edu.cn>,
	Simon Horman <horms@kernel.org>,
	stable@kernel.org
Subject: [PATCH net v4 11/15] rxrpc: Only put the call ref if one was acquired
Date: Wed,  1 Apr 2026 11:56:04 +0100
Message-ID: <20260401105614.1696001-12-dhowells@redhat.com>
In-Reply-To: <20260401105614.1696001-1-dhowells@redhat.com>
References: <20260401105614.1696001-1-dhowells@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,auristor.com,kernel.org,davemloft.net,google.com,lists.infradead.org,vger.kernel.org,gmail.com,lzu.edu.cn];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274057-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,auristor.com:email,davemloft.net:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 858293790BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Douya Le <ldy3087146292@gmail.com>

rxrpc_input_packet_on_conn() can process a to-client packet after the
current client call on the channel has already been torn down.  In that
case chan->call is NULL, rxrpc_try_get_call() returns NULL and there is
no reference to drop.

The client-side implicit-end error path does not account for that and
unconditionally calls rxrpc_put_call().  This turns a protocol error
path into a kernel crash instead of rejecting the packet.

Only drop the call reference if one was actually acquired.  Keep the
existing protocol error handling unchanged.

Fixes: 5e6ef4f1017c ("rxrpc: Make the I/O thread take over the call and local processor work")
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Signed-off-by: Douya Le <ldy3087146292@gmail.com>
Co-developed-by: Yuan Tan <tanyuan98@gmail.com>
Signed-off-by: Yuan Tan <tanyuan98@gmail.com>
Suggested-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Ao Zhou <n05ec@lzu.edu.cn>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
cc: stable@kernel.org
---
 net/rxrpc/io_thread.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/rxrpc/io_thread.c b/net/rxrpc/io_thread.c
index e939ecf417c4..697956931925 100644
--- a/net/rxrpc/io_thread.c
+++ b/net/rxrpc/io_thread.c
@@ -419,7 +419,8 @@ static int rxrpc_input_packet_on_conn(struct rxrpc_connection *conn,
 
 	if (sp->hdr.callNumber > chan->call_id) {
 		if (rxrpc_to_client(sp)) {
-			rxrpc_put_call(call, rxrpc_call_put_input);
+			if (call)
+				rxrpc_put_call(call, rxrpc_call_put_input);
 			return rxrpc_protocol_error(skb,
 						    rxrpc_eproto_unexpected_implicit_end);
 		}


