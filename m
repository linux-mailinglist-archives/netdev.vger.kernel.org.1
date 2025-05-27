Return-Path: <netdev+bounces-193684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0704AAC517B
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 17:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C001A16605E
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 15:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F824253F1E;
	Tue, 27 May 2025 15:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ftH8O/xZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B3219D092
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 15:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748358117; cv=none; b=VJUe45vZ9p3QEScbzwNS6DSsE0q47943GCgcsp4xlEVjVsyHSS74E+7BPJCXEpNPI898XR7wtemZXlxYJqxFqmK/jrF9rzPKX/zPNxZI50KjVHlfWNwCVwl0huKDwHuAa2r3847Gf22cJDRl6gQDv945KO7rMG03LQMShHEPtrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748358117; c=relaxed/simple;
	bh=9D2OPRUcMa6qohnWPOW08gHPDYq89lsMGvZC3HHSSm8=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=D9WF/i3l1wf38GcM4uPJjRraazpIaZ3jRW059BNfbAufQ/LAsxy7/GffcJYukMh14q038JFnYvl1JN9Qogjetml1jy5FQa8pBCFgVZ2i+NRvmsMWjZmneOfsA5vwWAVg32+V2uaR45rpwpn1Hb3Urf5xeszuz5d8vmezZyyDxQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ftH8O/xZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748358114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=mvX6nMx4p6rrL49+qOZnYNrmMIAGaYChSHFY25SBKn8=;
	b=ftH8O/xZsBG5BL+ETgq+l52Uu+aTjzhz4W41b7yYJV4YhbxEufa9B8eA+TRmJFpdVVbK2I
	vU6gCR+9YAEb3fqt0+U55GNfXy4wYl/L+FOiUZFiyMl1iwQE4RDvN0lETbL3wikq0zwOz8
	9ch8l+mAHVKVCohxI0fxViEMks8l9fU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-q_56KyA5Pnyhfi4_pnLOXQ-1; Tue,
 27 May 2025 11:01:51 -0400
X-MC-Unique: q_56KyA5Pnyhfi4_pnLOXQ-1
X-Mimecast-MFC-AGG-ID: q_56KyA5Pnyhfi4_pnLOXQ_1748358108
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 67A0319560BB;
	Tue, 27 May 2025 15:01:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.2])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2F5C030001B0;
	Tue, 27 May 2025 15:01:44 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
cc: dhowells@redhat.com, Dan Carpenter <dan.carpenter@linaro.org>,
    Marc Dionne <marc.dionne@auristor.com>,
    Jakub Kicinski <kuba@kernel.org>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
    Simon Horman <horms@kernel.org>, linux-afs@lists.infradead.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH net-next] rxrpc: Fix return from none_validate_challenge()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <10719.1748358103.1@warthog.procyon.org.uk>
Date: Tue, 27 May 2025 16:01:43 +0100
Message-ID: <10720.1748358103@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Fix the return value of none_validate_challenge() to be explicitly true
(which indicates the source packet should simply be discarded) rather than
implicitly true (because rxrpc_abort_conn() always returns -EPROTO which
gets converted to true).

Note that this change doesn't change the behaviour of the code (which is
correct by accident) and, in any case, we *shouldn't* get a CHALLENGE
packet to an rxnull connection (ie. no security).

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lists.infradead.org/pipermail/linux-afs/2025-April/009738.html
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
 net/rxrpc/insecure.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/rxrpc/insecure.c b/net/rxrpc/insecure.c
index 1f7c136d6d0e..0a260df45d25 100644
--- a/net/rxrpc/insecure.c
+++ b/net/rxrpc/insecure.c
@@ -45,8 +45,9 @@ static void none_free_call_crypto(struct rxrpc_call *call)
 static bool none_validate_challenge(struct rxrpc_connection *conn,
 				    struct sk_buff *skb)
 {
-	return rxrpc_abort_conn(conn, skb, RX_PROTOCOL_ERROR, -EPROTO,
-				rxrpc_eproto_rxnull_challenge);
+	rxrpc_abort_conn(conn, skb, RX_PROTOCOL_ERROR, -EPROTO,
+			 rxrpc_eproto_rxnull_challenge);
+	return true;
 }
 
 static int none_sendmsg_respond_to_challenge(struct sk_buff *challenge,


