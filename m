Return-Path: <netdev+bounces-270590-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJwKEQhbwWnbSQQAu9opvQ
	(envelope-from <netdev+bounces-270590-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 16:23:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D681E2F635A
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 16:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A09E8309C049
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 15:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4473BBA15;
	Mon, 23 Mar 2026 15:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C8ogW37E"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF101277C88
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 15:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278376; cv=none; b=PlSHXNu/C/kCX4Gm8yf7sR/0c3Ei08732dtApGBXf5r45tsuHDz409pxZSMQZH9heV8SxUL5cuVkrOsoX/OqIY0Dn3m6MQ7kwhMW1Ih8WSgTVD+cYkk1aVSy9Irv5NHdfACS29VOl275Eu7dY72ZcQRyPAjByl29H6A1kMYOHck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278376; c=relaxed/simple;
	bh=+qHAnkIsqP997RWJ6s4umVeu9sIbTOhEQRZ3NRgBWrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u41FrTrjjxB9xPEOSBBaeEmMKqxuRO0SqRSDP7dY0asRbVcCwGZ+EBZqKaviy6xlBJYEZ2yh2YDogBrzG28NeQPEI2510Q3rFA1rnG5Vpas4SffXMayEb+X8rahvIYaIFnJjvfxLCuyNy9EPJ8Xv2bwGlqYzwuCzBCFzUxyKH44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C8ogW37E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774278373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VeYaAx0dAJ4NEayyI0atPURUWeMa5ddyG3Tx/cyMm4w=;
	b=C8ogW37Ez15IAcvwCYGMMxyc38AjcZi5olY+VB+b5RvKYRkJx3rUWKEpJOMcCDvC/1Tr8I
	htkx/60dPSSZJYMBMKJTQod0PJwi4R0HLPpsBCqUqjQFNXVQAfgTGCD3yciLMcKaqZ+5mZ
	Qdao9/wJxx/X36kYvcKQSpmXKC2gQqQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-577-Nj5H2jTqPACnoLggokpyxA-1; Mon,
 23 Mar 2026 11:06:12 -0400
X-MC-Unique: Nj5H2jTqPACnoLggokpyxA-1
X-Mimecast-MFC-AGG-ID: Nj5H2jTqPACnoLggokpyxA_1774278370
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 25AEC1800359;
	Mon, 23 Mar 2026 15:06:10 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.121])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E7AD3300019F;
	Mon, 23 Mar 2026 15:06:05 +0000 (UTC)
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
	Anderson Nascimento <anderson@allelesecurity.com>,
	Jeffrey Altman <jaltman@auristor.com>,
	Simon Horman <horms@kernel.org>,
	stable@kernel.org
Subject: [PATCH net v2 10/10] rxrpc: Fix key reference count leak from call->key
Date: Mon, 23 Mar 2026 15:05:01 +0000
Message-ID: <20260323150505.3513839-11-dhowells@redhat.com>
In-Reply-To: <20260323150505.3513839-1-dhowells@redhat.com>
References: <20260323150505.3513839-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270590-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D681E2F635A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Anderson Nascimento <anderson@allelesecurity.com>

When creating a client call in rxrpc_alloc_client_call(), the code obtains
a reference to the key.  This is never cleaned up and gets leaked when the
call is destroyed.

Fix this by freeing call->key in rxrpc_destroy_call().

Before the patch, it shows the key reference counter elevated:

$ cat /proc/keys | grep afs@54321
1bffe9cd I--Q--i 8053480 4169w 3b010000  1000  1000 rxrpc     afs@54321: ka
$

After the patch, the invalidated key is removed when the code exits:

$ cat /proc/keys | grep afs@54321
$

Fixes: f3441d4125fc ("rxrpc: Copy client call parameters into rxrpc_call earlier")
Signed-off-by: Anderson Nascimento <anderson@allelesecurity.com>
Co-developed-by: David Howells <dhowells@redhat.com>
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
 net/rxrpc/call_object.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
index 0e47751d5937..57c15aa1e9b5 100644
--- a/net/rxrpc/call_object.c
+++ b/net/rxrpc/call_object.c
@@ -694,6 +694,7 @@ static void rxrpc_destroy_call(struct work_struct *work)
 	rxrpc_put_bundle(call->bundle, rxrpc_bundle_put_call);
 	rxrpc_put_peer(call->peer, rxrpc_peer_put_call);
 	rxrpc_put_local(call->local, rxrpc_local_put_call);
+	key_put(call->key);
 	call_rcu(&call->rcu, rxrpc_rcu_free_call);
 }
 


