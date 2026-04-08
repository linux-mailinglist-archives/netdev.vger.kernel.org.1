Return-Path: <netdev+bounces-276489-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eB6dHIJJ1mkFDQgAu9opvQ
	(envelope-from <netdev+bounces-276489-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 14:26:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBAC03BC001
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 14:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BDAAE313931A
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 12:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658E83CBE9F;
	Wed,  8 Apr 2026 12:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WvQ7kXp3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1864D3CB2E6
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 12:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775650507; cv=none; b=dCOxvILUIOWPUJ2Jwd+/aTlxsiMDAhlD7zdSgSS8SxqIK7AdBF9xFA5C0VtQjEXfs7j+yk/bl1o5aQ0pV3y45da9X6UyYUu3v3rDWTjk98ZKbwBusI+Fx7XcVIARMVXZr7i5GymsegMPI6S3TPmran41bttq0qFiXUloeM+zwSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775650507; c=relaxed/simple;
	bh=T6TilaaPcQx10cZAsNBHZzVvjhKcJMP/qPlWI6udbkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EoETFb5C8DdbKJsYWdExnWC33y7/1EMuIfpkwknqOUg4qSBJ1V9LSjq0T4ir+0gyQtpa8w/42TeIo2ReH9AssyTYLs24qXyF11mGBzLWyy2PO+UFHvkFqthY9lpJSFxxtQ9EPljpmr9jUagMUroMF5vC6rz7mek3NvgDOlSSH7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WvQ7kXp3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775650505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NNFmcPNUgneo4XuRXgzehK/i+zm2EVaFKz9uL41HpS8=;
	b=WvQ7kXp3GXJXnh0sDppIxwgjdknypS6pvA1X/+YllbpddIcWENIbWavk2/FtKvDWhhz8Hw
	6qC6xB5GV5V8bnUnc8XoG7vwRR39Xbyq+u0h91mYLAn8NkZPY0Cns3bbG8+UhvtMyUZVF+
	Ubdd/rXG9O+IqUPKElc5rl13IJwFRQ4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-6-mVKjSYyOMYGezGe01-pe8w-1; Wed,
 08 Apr 2026 08:15:00 -0400
X-MC-Unique: mVKjSYyOMYGezGe01-pe8w-1
X-Mimecast-MFC-AGG-ID: mVKjSYyOMYGezGe01-pe8w_1775650498
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 46AD01800616;
	Wed,  8 Apr 2026 12:14:58 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.32.94])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BBAB119560A6;
	Wed,  8 Apr 2026 12:14:54 +0000 (UTC)
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
	Jeffrey Altman <jaltman@auristor.com>,
	Simon Horman <horms@kernel.org>,
	stable@kernel.org
Subject: [PATCH net v5 19/21] rxrpc: Fix buffer overread in rxgk_do_verify_authenticator()
Date: Wed,  8 Apr 2026 13:12:47 +0100
Message-ID: <20260408121252.2249051-20-dhowells@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276489-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[davemloft.net:email,sashiko.dev:url,infradead.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,auristor.com:email]
X-Rspamd-Queue-Id: DBAC03BC001
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fix rxgk_do_verify_authenticator() to check the buffer size before checking
the nonce.

Fixes: 9d1d2b59341f ("rxrpc: rxgk: Implement the yfs-rxgk security class (GSSAPI)")
Closes: https://sashiko.dev/#/patchset/20260401105614.1696001-10-dhowells@redhat.com
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
 net/rxrpc/rxgk.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/rxrpc/rxgk.c b/net/rxrpc/rxgk.c
index c67e3c2ca871..0d5e654da918 100644
--- a/net/rxrpc/rxgk.c
+++ b/net/rxrpc/rxgk.c
@@ -1085,6 +1085,9 @@ static int rxgk_do_verify_authenticator(struct rxrpc_connection *conn,
 
 	_enter("");
 
+	if ((end - p) * sizeof(__be32) < 24)
+		return rxrpc_abort_conn(conn, skb, RXGK_NOTAUTH, -EPROTO,
+					rxgk_abort_resp_short_auth);
 	if (memcmp(p, conn->rxgk.nonce, 20) != 0)
 		return rxrpc_abort_conn(conn, skb, RXGK_NOTAUTH, -EPROTO,
 					rxgk_abort_resp_bad_nonce);
@@ -1098,7 +1101,7 @@ static int rxgk_do_verify_authenticator(struct rxrpc_connection *conn,
 	p += xdr_round_up(app_len) / sizeof(__be32);
 	if (end - p < 4)
 		return rxrpc_abort_conn(conn, skb, RXGK_NOTAUTH, -EPROTO,
-					rxgk_abort_resp_short_applen);
+					rxgk_abort_resp_short_auth);
 
 	level	= ntohl(*p++);
 	epoch	= ntohl(*p++);


