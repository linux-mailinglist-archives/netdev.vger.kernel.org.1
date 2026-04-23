Return-Path: <netdev+bounces-280870-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YN7oLbF86mmqzwIAu9opvQ
	(envelope-from <netdev+bounces-280870-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 22:10:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0318045729F
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 22:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC11C305E1E9
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 20:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9E639A807;
	Thu, 23 Apr 2026 20:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dK3cyV1m"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432F339937B
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 20:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776974972; cv=none; b=oFODa504Szpy1LGtpTdryZJZNzlAOdYVKlgSe1nN3K5YvEuOs8vJom+xahIvlRfVJfmM1ZbAE4O5wsM/Fao9/N4i2aTEsbnt1+ERki/M8vwE2fIOAQ47GyCvaQGjaakkaXAQUTVBINGO6CylCZn16BGaLuU5Ah/DyaWzz8mzB6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776974972; c=relaxed/simple;
	bh=8b097pGVlLpicxOfklhtJM6qr4pxy93q90H1xn64sI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dubszS5mQf9bJHe7RlFgoyc78abXMcl3RSnr5xVHpbvwjvMeU7IEgYZ5RnGylbAjHGEpbBorpf1O/diQ5y+MQDprm/dNendalvE5qGEkUVu8sq4wJOfdu/PZ+lXqdlUhXq+Cww9s9kR9cg3iRtiWnWSv5trQYvnLYHCnsiEKRhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dK3cyV1m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776974970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h8HSPM0JrqW66DgR41+khbZToa3dNgnSV86p/wrsjnw=;
	b=dK3cyV1mLjIVodFM0Qa7Vpj72zhIATT5HlQ2xhu0GBKe0ye5kTPEof6uvtNy8rzxmNrPa1
	cANXsELwSLtK1PdnshMpmKX36xOdmn93VhDasd6mlD1jMP4AsavQ9EhL33W+PBb6uJmgJP
	XFPopqXY2Q11MlF2/fK3DTh6cuOgGU0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-173-GjX7cyx1OuCCT7fVw0uCiw-1; Thu,
 23 Apr 2026 16:09:24 -0400
X-MC-Unique: GjX7cyx1OuCCT7fVw0uCiw-1
X-Mimecast-MFC-AGG-ID: GjX7cyx1OuCCT7fVw0uCiw_1776974962
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 964891956050;
	Thu, 23 Apr 2026 20:09:22 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.48.17])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 519FF19560AB;
	Thu, 23 Apr 2026 20:09:18 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Anderson Nascimento <anderson@allelesecurity.com>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jeffrey Altman <jaltman@auristor.com>,
	stable@kernel.org
Subject: [PATCH net 1/3] rxrpc: Fix rxrpc_input_call_event() to only unshare DATA packets
Date: Thu, 23 Apr 2026 21:09:06 +0100
Message-ID: <20260423200909.3049438-2-dhowells@redhat.com>
In-Reply-To: <20260423200909.3049438-1-dhowells@redhat.com>
References: <20260423200909.3049438-1-dhowells@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280870-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[auristor.com:email,davemloft.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:email,sashiko.dev:url]
X-Rspamd-Queue-Id: 0318045729F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fix rxrpc_input_call_event() to only unshare DATA packets and not ACK,
ABORT, etc..

And with that, rxrpc_input_packet() doesn't need to take a pointer to the
pointer to the packet, so change that to just a pointer.

Fixes: 1f2740150f90 ("rxrpc: Fix potential UAF after skb_unshare() failure")
Closes: https://sashiko.dev/#/patchset/20260422161438.2593376-4-dhowells@redhat.com
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
 net/rxrpc/call_event.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
index cc8f9dfa44e8..fdd683261226 100644
--- a/net/rxrpc/call_event.c
+++ b/net/rxrpc/call_event.c
@@ -332,7 +332,8 @@ bool rxrpc_input_call_event(struct rxrpc_call *call)
 
 			saw_ack |= sp->hdr.type == RXRPC_PACKET_TYPE_ACK;
 
-			if (sp->hdr.securityIndex != 0 &&
+			if (sp->hdr.type == RXRPC_PACKET_TYPE_DATA &&
+			    sp->hdr.securityIndex != 0 &&
 			    skb_cloned(skb)) {
 				/* Unshare the packet so that it can be
 				 * modified by in-place decryption.


