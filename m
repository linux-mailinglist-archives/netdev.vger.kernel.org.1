Return-Path: <netdev+bounces-269485-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJdwCtYRvGnbrwIAu9opvQ
	(envelope-from <netdev+bounces-269485-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:10:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABB62CD6F7
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 551983211218
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 15:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFE13E3D9B;
	Thu, 19 Mar 2026 15:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UQhOmS+j"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B36E3E3C71
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 15:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773932583; cv=none; b=F/ctjCS1qw2tXFLLnS4DJ5WbBX9HbDXJEXK9N01+UKnpcH8FSAbpdKT7eQ4dFnqXGeXgkimtNVXDWMKWhy0Zp5+NQgTqcTHd21fr7brMq+NaSvfATTnW480xnsR6LQlAdwrUfgpItmDbI2JPg7470YPX0QgCieN2Ytu9gvxSVM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773932583; c=relaxed/simple;
	bh=I3X9Xgh8JthJcC1AVR46HTecX3GW+jzHyhem1V0naug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GVUbEiQQpQ6cfMZ2wLFOzZwA/S2BPa9/P0FVLpG5XENXGyQdZCkwlG8SYPbq4Crr8fwNOyubz3jPpoab9Out0+qwYiy3ndZ5vflvHzs/fTz1f7oi+X40RL0Xv+v79vCVqvbcNkY6cTuN7Muks6rFRn1qjcov2MXqXPddslj0WCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UQhOmS+j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773932581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AN3SQlsqlhxFhvczjAvAzreHONU16FaElSEWYMuHbwQ=;
	b=UQhOmS+j6XKsG7i/0gKCnIWpVBkuYXDLaCLgKrhBt8HQJ0vPKu3BDnSW//R9NnIUKxcSiL
	CmHMORxVfwHIeap2WP8u3XavB1Sl9ZJOEfqIDuzu+bfsXhODbbqAdQQDYpE3fs704jssqZ
	V9CjsM1uHwnQ3gTji/XMsxGXhCUhH/4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-155-aqR4LBEgMkGQ5ec08alfqQ-1; Thu,
 19 Mar 2026 11:02:59 -0400
X-MC-Unique: aqR4LBEgMkGQ5ec08alfqQ-1
X-Mimecast-MFC-AGG-ID: aqR4LBEgMkGQ5ec08alfqQ_1773932577
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B1E6B1955F18;
	Thu, 19 Mar 2026 15:02:57 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.45.224.65])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D2BEE180035F;
	Thu, 19 Mar 2026 15:02:53 +0000 (UTC)
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
Subject: [PATCH net 4/5] rxrpc: Fix keyring reference count leak in rxrpc_setsockopt()
Date: Thu, 19 Mar 2026 15:01:44 +0000
Message-ID: <20260319150150.4189381-5-dhowells@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269485-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.978];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,auristor.com:email,davemloft.net:email,allelesecurity.com:email,infradead.org:email]
X-Rspamd-Queue-Id: 7ABB62CD6F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Anderson Nascimento <anderson@allelesecurity.com>

In rxrpc_setsockopt(), the code checks 'rx->key' when handling the
RXRPC_SECURITY_KEYRING option.  However, this appears to be a logic error.
The code should be checking 'rx->securities' to determine if a keyring has
already been defined for the socket.

Currently, if a user calls setsockopt(RXRPC_SECURITY_KEYRING) multiple
times on the same socket, the check 'if (rx->key)' fails to block
subsequent calls because 'rx->key' has not been defined by the function.
This results in a reference count leak on the keyring.

This patch changes the check to 'rx->securities' to correctly identify if
the socket security keyring has already been configured, returning -EINVAL
on subsequent attempts.

Before the patch:

It shows the keyring reference counter elevated.

$ cat /proc/keys | grep AFSkeys1
27aca8ae I--Q--- 24469721 perm 3f010000  1000  1000 keyring   AFSkeys1: empty
$

After the patch:

The keyring reference counter remains stable and subsequent calls return an
error:

$ ./poc
setsockopt: Invalid argument
$

Fixes: 17926a79320a ("[AF_RXRPC]: Provide secure RxRPC sockets for use by userspace and kernel both")
Signed-off-by: Anderson Nascimento <anderson@allelesecurity.com>
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
 net/rxrpc/af_rxrpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rxrpc/af_rxrpc.c b/net/rxrpc/af_rxrpc.c
index 0f90272ac254..0b7ed99a3025 100644
--- a/net/rxrpc/af_rxrpc.c
+++ b/net/rxrpc/af_rxrpc.c
@@ -665,7 +665,7 @@ static int rxrpc_setsockopt(struct socket *sock, int level, int optname,
 
 		case RXRPC_SECURITY_KEYRING:
 			ret = -EINVAL;
-			if (rx->key)
+			if (rx->securities)
 				goto error;
 			ret = -EISCONN;
 			if (rx->sk.sk_state != RXRPC_UNBOUND)


