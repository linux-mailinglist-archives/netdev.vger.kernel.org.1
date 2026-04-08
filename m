Return-Path: <netdev+bounces-276480-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mN2kMGtI1mkFCwgAu9opvQ
	(envelope-from <netdev+bounces-276480-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 14:22:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3952B3BBECC
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 14:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 70BCA310C039
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 12:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDFE3C7DE2;
	Wed,  8 Apr 2026 12:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VU8hAhgN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6928E3C73E5
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 12:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775650456; cv=none; b=bEJSExjbVb7dFFiOFS/uU+A0BN+Figl9sV5u7vBrfBzNLyV4daNVrOFhl/WuGgJ/k21yZwDQ4PgJcH2Q+cDbeStbLt7zltvfGUGFx0J4PNuMSAM2WgmoPQH5FYCRvitlhigcNzeFBUN0cgYly9452ciXacZX1FK2qpv0b7jin6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775650456; c=relaxed/simple;
	bh=dETvW09GhXLGNeO1xyDqPkq/bSzSBmA0bRuVutPwoNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gnvdu555yFNMnYY4BqePzlv/BB7SVb9olJB6WPcSgAoIXbaPz2E4FYKNU9YvURvMUH6lGznw/wfBDoOcCPZpgFjWzaasm/kA7VK3xzQwNXbq/SzOz39L5pCTmlpdApHZPTIUf9eL++7/ruorL0sb88YgCg1ncJR7ych9rFGdng8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VU8hAhgN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775650452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IyvzpHLTaSD//xZgQtcTYLO3HI+bGdy75Y+Sf6QrB0M=;
	b=VU8hAhgN0rE7TGODfezAPt1k3b7zrp9eLjNivmTRva9Q8qT4EimB2RzshcoABG/6mSZNaU
	rUPb/uJMmAwgGGmRqcu3fiOC2ZBp9X3aILmm2/OcdFQzCOGGX6sECaYBEXRi46qaxX/pJh
	K51T/Nb5e+sUxMedkdcgXkgEHgIXZUk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-247-GnbRUtTzMsW1BrbqpX05vw-1; Wed,
 08 Apr 2026 08:14:07 -0400
X-MC-Unique: GnbRUtTzMsW1BrbqpX05vw-1
X-Mimecast-MFC-AGG-ID: GnbRUtTzMsW1BrbqpX05vw_1775650445
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 565681800614;
	Wed,  8 Apr 2026 12:14:05 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.32.94])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8D3AA1953944;
	Wed,  8 Apr 2026 12:14:00 +0000 (UTC)
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
Subject: [PATCH net v5 10/21] rxrpc: Only put the call ref if one was acquired
Date: Wed,  8 Apr 2026 13:12:38 +0100
Message-ID: <20260408121252.2249051-11-dhowells@redhat.com>
In-Reply-To: <20260408121252.2249051-1-dhowells@redhat.com>
References: <20260408121252.2249051-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,auristor.com,kernel.org,davemloft.net,google.com,lists.infradead.org,vger.kernel.org,gmail.com,lzu.edu.cn];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-276480-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[auristor.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lzu.edu.cn:email,davemloft.net:email,infradead.org:email]
X-Rspamd-Queue-Id: 3952B3BBECC
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


