Return-Path: <netdev+bounces-269483-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPJOKvMQvGnbrwIAu9opvQ
	(envelope-from <netdev+bounces-269483-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:06:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A59B32CD63C
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E2F703023ABC
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 15:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD0C3E0257;
	Thu, 19 Mar 2026 15:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O9vFM5d2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FB73E1D05
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 15:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773932574; cv=none; b=TNnhioY1ogqreRPSf2hHrUW0tNbWAVvEb58RkRu2WKe/HSjU4OY1oVorVPmq1cAO9Yq8Y0c/fmfz1BtOTyOjFeAuNujhEGRYdL4U9Vu9WcykVBO1mCDwNIGnCmZWcjKuwWbX2OVLyrK+cdk/YzlkxVohxP7KODKtFM1gimTD5ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773932574; c=relaxed/simple;
	bh=yYt2ZZrom4OBrOckOQ2uDB2KRzi+ygnnBnUBMule74s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YUsfkXrNG3w0+lms31EJEzyzrYVNQciXugL/1qTk8yPQAGtmeXBGmMWDT90Ta+rYDLxLzPn1d0iKsT6AGOKcndD7gDrPXeWx3a5YxdzgND3+rTBJPLEdBP1yhckal2TnVn+aaMxAYH9pPxfGO2clSyyTLku01HbKAsl+ndb1840=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O9vFM5d2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773932572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qe8BjP28NMw5ykXz64SRH/WFS1bGGID3gMz6oA2YqQM=;
	b=O9vFM5d2ghhgu9Eu9DaCkQeCOhl1BFQVUjGsQXGXxKiGw9KwRTxEZYIMmrQxaxGPgoKfEQ
	yXRqvpI3MhEp+dnMejgYeJIeFyekBzBTch+dvIL7qq8eTBtbWn2W6ZPsMmpQBqjSyzxUOf
	Olc3Dhq7O1jgUcLZF8BVOzIZfdN+CfQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-222-0q5b5iDpMMqukYlXRLNv8Q-1; Thu,
 19 Mar 2026 11:02:48 -0400
X-MC-Unique: 0q5b5iDpMMqukYlXRLNv8Q-1
X-Mimecast-MFC-AGG-ID: 0q5b5iDpMMqukYlXRLNv8Q_1773932566
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4278A18002F4;
	Thu, 19 Mar 2026 15:02:46 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.45.224.65])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 226F91800576;
	Thu, 19 Mar 2026 15:02:41 +0000 (UTC)
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
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	Jeffrey Altman <jaltman@auristor.com>,
	Simon Horman <horms@kernel.org>,
	stable@kernel.org
Subject: [PATCH net 2/5] rxrpc: Fix use of wrong skb when comparing queued RESP challenge serial
Date: Thu, 19 Mar 2026 15:01:42 +0000
Message-ID: <20260319150150.4189381-3-dhowells@redhat.com>
In-Reply-To: <20260319150150.4189381-1-dhowells@redhat.com>
References: <20260319150150.4189381-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269483-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.979];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,davemloft.net:email,oracle.com:email,auristor.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A59B32CD63C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alok Tiwari <alok.a.tiwari@oracle.com>

In rxrpc_post_response(), the code should be comparing the challenge serial
number from the cached response before deciding to switch to a newer
response, but looks at the newer packet private data instead, rendering the
comparison always false.

Fix this by switching to look at the older packet.

Fixes: 5800b1cf3fd8 ("rxrpc: Allow CHALLENGEs to the passed to the app for a RESPONSE")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeffrey Altman <jaltman@auristor.com>
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
 net/rxrpc/conn_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
index 98ad9b51ca2c..2c27f47951f9 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -557,7 +557,7 @@ void rxrpc_post_response(struct rxrpc_connection *conn, struct sk_buff *skb)
 	spin_lock_irq(&local->lock);
 	old = conn->tx_response;
 	if (old) {
-		struct rxrpc_skb_priv *osp = rxrpc_skb(skb);
+		struct rxrpc_skb_priv *osp = rxrpc_skb(old);
 
 		/* Always go with the response to the most recent challenge. */
 		if (after(sp->resp.challenge_serial, osp->resp.challenge_serial))


