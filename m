Return-Path: <netdev+bounces-276473-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sM8eFhdH1mkFCwgAu9opvQ
	(envelope-from <netdev+bounces-276473-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 14:16:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D893BBDE9
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 14:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A9C030A8BD6
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 12:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45863C13E2;
	Wed,  8 Apr 2026 12:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P1KYYCri"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588803BF699
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 12:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775650411; cv=none; b=TJhuYM79HGlcc7DINGWgCjV09ctj88LujYAqxHx5DcqYoanTroU0pJsIxwNiGSHrDXmJODrYlqbqwPTtAjnkJg/8v8ve9Fd60G36sPA5n0lchM3DA7rQe5w53lizYINGuuHCkF5L8wa+i+X0jzQaLU0YDOPdT6QL0cRAa2UZHqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775650411; c=relaxed/simple;
	bh=GTDitVkkmcP3pmQfGjjQNmdx/6Cfdn8ljMrl4GlS00k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ct4ppEItMfj1vPnjeejKg1hWB7ANu/mdJpiTg4BGZMWMsIqqOUVBWElSdhL2uPFwF8TbaWupMmqPJG7T7DfkCiMYCFe4DWayK9Gy0EV+fXvrzxT0rBgg61XuO5X5dEVisZXunTa5jEJTRPuRLbhH5WPpFjfD62/fNhKsyC4Xzsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P1KYYCri; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775650403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P4apLx2lQf8nhrvynIjV3RMW+ZpNX1GtOZdWeDq74IM=;
	b=P1KYYCriCbIOxMgMT4MDez+4BLMPr/d9T5fGvIbKSeh0PYT0Q348U4RLBslWVgqWWGV2Co
	7mJny0W9yCQW1AoByJ95RAbKx5RURyur/hS9Hu70PL3WHt5X2PyHA5lTj2MeG5ahPaCfXH
	LPmOj+69T5nOHQ+/Qjkfe9GMkJSG82s=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-8rqjp-J6NcOG-6kpM2zStg-1; Wed,
 08 Apr 2026 08:13:18 -0400
X-MC-Unique: 8rqjp-J6NcOG-6kpM2zStg-1
X-Mimecast-MFC-AGG-ID: 8rqjp-J6NcOG-6kpM2zStg_1775650396
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7ECF61955D9C;
	Wed,  8 Apr 2026 12:13:16 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.32.94])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D6121300019F;
	Wed,  8 Apr 2026 12:13:12 +0000 (UTC)
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
Subject: [PATCH net v5 03/21] rxrpc: Fix anonymous key handling
Date: Wed,  8 Apr 2026 13:12:31 +0100
Message-ID: <20260408121252.2249051-4-dhowells@redhat.com>
In-Reply-To: <20260408121252.2249051-1-dhowells@redhat.com>
References: <20260408121252.2249051-1-dhowells@redhat.com>
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
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276473-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,auristor.com:email,davemloft.net:email,infradead.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E3D893BBDE9
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


