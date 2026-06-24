Return-Path: <netdev+bounces-301726-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id c3MdOk4IPGq6iwgAu9opvQ
	(envelope-from <netdev+bounces-301726-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 18:39:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9EC6C0069
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 18:39:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=BpkJ6l3B;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301726-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301726-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 55E6D3053F31
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 16:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF83C3264D8;
	Wed, 24 Jun 2026 16:39:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F1B3290B8
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 16:39:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782319144; cv=none; b=fn/oZ2tUXbL3+XPta/+b2NTmtYHxvatWMZtjiLjciAW3Id4JME60EWZ3kh6mThYorfHvRsHNbPjqhoxcnrRWopIrPJhr/M//+eEZxf4kNzicxvFbhionHATTz+zdkEQgZHOK/n+fbAQy9JBcDvYyZJjtJTD+xQ7wd+jboHkXmmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782319144; c=relaxed/simple;
	bh=SzjOURCd1MQth/JNRCVkoDuaoxuorLH+N2voqWcFUCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iv+pazWIa2myaZ2nyprL02bv3MlcKhixODmTCP0Xveu6NvfZF+b4OWJFF6mwKIZJhSV8R1oHyBqzq3gtEMyTPHBj3n6mvdHZz7UU8vcVa8C9alWjVvguCnMmvqdIANS5rzbQRJNeZn5rItd4nCDBwwPgtyKryhv+uAiuG25c4xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BpkJ6l3B; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782319142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3P3BcIc02S0TPRYHtQPnA7qWSj0ny0Ev22elMIXUaCI=;
	b=BpkJ6l3B/YbWrb9aMmQqFVI1Fei55xV137vz2AHulRbioBHw709SZfl+DRzgS6jXRJj0gy
	DgkOo1Ur+cw7NtPgMOEjg/yF2AbG5ZNgXTTt3weAWwLBkz6CPf9LxMDYlIMacTLB5DrJV5
	NO3Z41X27kkA991O/t8TZdVsczHLLCk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-676-jLqsjudkPvGlFPPFFNkdog-1; Wed,
 24 Jun 2026 12:38:57 -0400
X-MC-Unique: jLqsjudkPvGlFPPFFNkdog-1
X-Mimecast-MFC-AGG-ID: jLqsjudkPvGlFPPFFNkdog_1782319135
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9244C1800365;
	Wed, 24 Jun 2026 16:38:55 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.49.152])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CEEF91800361;
	Wed, 24 Jun 2026 16:38:51 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Li Daming <d4n.for.sec@gmail.com>,
	Ren Wei <n05ec@lzu.edu.cn>,
	Jeffrey Altman <jaltman@auristor.com>,
	stable@kernel.org
Subject: [PATCH net v3 05/11] afs: Fix uncancelled rxrpc OOB message handler
Date: Wed, 24 Jun 2026 17:38:12 +0100
Message-ID: <20260624163819.3017002-6-dhowells@redhat.com>
In-Reply-To: <20260624163819.3017002-1-dhowells@redhat.com>
References: <20260624163819.3017002-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[redhat.com,auristor.com,kernel.org,davemloft.net,google.com,lists.infradead.org,vger.kernel.org,gmail.com,lzu.edu.cn];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-301726-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:dhowells@redhat.com,m:marc.dionne@auristor.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-afs@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:d4n.for.sec@gmail.com,m:n05ec@lzu.edu.cn,m:jaltman@auristor.com,m:stable@kernel.org,m:d4nforsec@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2F9EC6C0069

Fix AFS to cancel its OOB message processing (typically to respond to
security challenges).  Also move OOB message processing to afs_wq so that
it's also waited for and make the OOB handler just return if the net
namespace is no longer live.

Fixes: 5800b1cf3fd8 ("rxrpc: Allow CHALLENGEs to the passed to the app for a RESPONSE")
Link: https://sashiko.dev/#/patchset/20260609140911.838677-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Li Daming <d4n.for.sec@gmail.com>
cc: Ren Wei <n05ec@lzu.edu.cn>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: stable@kernel.org
---
 fs/afs/cm_security.c | 3 ++-
 fs/afs/rxrpc.c       | 5 ++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/afs/cm_security.c b/fs/afs/cm_security.c
index edcbd249d202..103168c70dd4 100644
--- a/fs/afs/cm_security.c
+++ b/fs/afs/cm_security.c
@@ -101,7 +101,8 @@ void afs_process_oob_queue(struct work_struct *work)
 	struct sk_buff *oob;
 	enum rxrpc_oob_type type;
 
-	while ((oob = rxrpc_kernel_dequeue_oob(net->socket, &type))) {
+	while (READ_ONCE(net->live) &&
+	       (oob = rxrpc_kernel_dequeue_oob(net->socket, &type))) {
 		switch (type) {
 		case RXRPC_OOB_CHALLENGE:
 			afs_respond_to_challenge(oob);
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index 6714a189d58f..d82916657a3d 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -128,6 +128,7 @@ void afs_close_socket(struct afs_net *net)
 	_enter("");
 
 	cancel_work_sync(&net->charge_preallocation_work);
+	cancel_work_sync(&net->rx_oob_work);
 	/* Future work items should now see ->live is false. */
 
 	kernel_listen(net->socket, 0);
@@ -148,6 +149,7 @@ void afs_close_socket(struct afs_net *net)
 
 	kernel_sock_shutdown(net->socket, SHUT_RDWR);
 	flush_workqueue(afs_async_calls);
+	cancel_work_sync(&net->rx_oob_work);
 	net->socket->sk->sk_user_data = NULL;
 	sock_release(net->socket);
 	key_put(net->fs_cm_token_key);
@@ -989,5 +991,6 @@ static void afs_rx_notify_oob(struct sock *sk, struct sk_buff *oob)
 {
 	struct afs_net *net = sk->sk_user_data;
 
-	schedule_work(&net->rx_oob_work);
+	if (READ_ONCE(net->live))
+		queue_work(afs_wq, &net->rx_oob_work);
 }


