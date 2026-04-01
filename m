Return-Path: <netdev+bounces-274049-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDr3DJz/zGnRYgYAu9opvQ
	(envelope-from <netdev+bounces-274049-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 13:21:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 02723379472
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 13:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C635C3057AE2
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 10:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED793FF8BF;
	Wed,  1 Apr 2026 10:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UXw6ng+W"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D6A3FEB13
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 10:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775041013; cv=none; b=vFBqzks8XCYjGGHrSGK/aAyiCDZDUV7cDKAnh4Mph9Gt/TvYJukZZ7yOWvTlwUa5+7zqmRbhDPtiE2uvaeUtMufVRiyqTEtwWBx/q5DIrXVFsW9oHmH36TU1+prqtp66+xOS5YBPXAWDMRlGrSU0Lib8vLkf1AFcBL6URFcAURo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775041013; c=relaxed/simple;
	bh=GTDitVkkmcP3pmQfGjjQNmdx/6Cfdn8ljMrl4GlS00k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dp2Sp4pCVx4UATo1dCsm6XfmhBq31uRRHMmXgQHt5MPtbySoBbCTGaHmLvKJpMGPsSUCG9PWbCgKmRsX0Ng3Xwaggyfzq0Nffav2pmVWn1iXSxyATVnO4HUkf3jhlgsZY1G82jP2gYtNROP/CRgS70upgNdEkcxQl2XCSeB5uVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UXw6ng+W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775041010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P4apLx2lQf8nhrvynIjV3RMW+ZpNX1GtOZdWeDq74IM=;
	b=UXw6ng+WxURui5JfAG6GgDfV6pJLMu0TbtHEspnxRnJwozJiwmz3qsHP08ZrBQpPP1A+RZ
	emTpL+71Rm7gJLlgBiB9l5yQJ7Jca+JqE2SUGeHcfgLPSLiBzhoFug2NEUjKq+MmyW1aNF
	RpTKf8qS00ylbw+M6JMG4HDg9uEYKH8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-513-MZn0AyuZOW-G4-J_kOXSZQ-1; Wed,
 01 Apr 2026 06:56:47 -0400
X-MC-Unique: MZn0AyuZOW-G4-J_kOXSZQ-1
X-Mimecast-MFC-AGG-ID: MZn0AyuZOW-G4-J_kOXSZQ_1775041006
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 99E241800464;
	Wed,  1 Apr 2026 10:56:45 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.35.245])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9A35C1953947;
	Wed,  1 Apr 2026 10:56:41 +0000 (UTC)
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
Subject: [PATCH net v4 03/15] rxrpc: Fix anonymous key handling
Date: Wed,  1 Apr 2026 11:55:56 +0100
Message-ID: <20260401105614.1696001-4-dhowells@redhat.com>
In-Reply-To: <20260401105614.1696001-1-dhowells@redhat.com>
References: <20260401105614.1696001-1-dhowells@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274049-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,auristor.com:email,davemloft.net:email,infradead.org:email,sashiko.dev:url]
X-Rspamd-Queue-Id: 02723379472
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In rxrpc_new_client_call_for_sendmsg(), a key with no payload is meant to
be substituted for a NULL key pointer, but the variable this is done with
is subsequently not used.

Fix this by using "key" rather than "rx->key" when filling in the
connection parameters.

Note that this only affects direct use of AF_RXRPC; the kAFS filesystem
doesn't use sendmsg() directly and so bypasses the issue.  Further,
AF_RXRPC passes a NULL key in if no key is set, so using an anonymous key
in that manner works.  Since this hasn't been noticed to this point, it
might be better just to remove the "key" variable and the code that sets it
- and, arguably, rxrpc_init_client_call_security() would be a better place
to handle it.

Fixes: 19ffa01c9c45 ("rxrpc: Use structs to hold connection params and protocol info")
Closes: https://sashiko.dev/#/patchset/20260319150150.4189381-1-dhowells%40redhat.com
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
 net/rxrpc/sendmsg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index 04f9c5f2dc24..c35de4fd75e3 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -637,7 +637,7 @@ rxrpc_new_client_call_for_sendmsg(struct rxrpc_sock *rx, struct msghdr *msg,
 	memset(&cp, 0, sizeof(cp));
 	cp.local		= rx->local;
 	cp.peer			= peer;
-	cp.key			= rx->key;
+	cp.key			= key;
 	cp.security_level	= rx->min_sec_level;
 	cp.exclusive		= rx->exclusive | p->exclusive;
 	cp.upgrade		= p->upgrade;


