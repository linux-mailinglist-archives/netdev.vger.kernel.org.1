Return-Path: <netdev+bounces-299904-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3AlqCy53MWoZkAUAu9opvQ
	(envelope-from <netdev+bounces-299904-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 18:17:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 925B5691E77
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 18:17:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=EjQPJ9bO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299904-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-299904-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E7DA930FA079
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 16:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D647D47A0BC;
	Tue, 16 Jun 2026 15:58:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815BD472777
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 15:58:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625512; cv=none; b=Akhe3zzvEJQxd6YjBnS2IZhxukTE8+70N7vQ7+Z1lu3WXO6IW4BRZUhzG5IZgtvAy3F0PrBUDt7DNbZpHJrVsoHHX2XpVm+pysVlTjBeNjsYFCgbu8219WvigipLZAVsJ+6NEnAc3DOW17mRWLXonaB8LU4VgLKVhH4vnMCKEcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625512; c=relaxed/simple;
	bh=bTnvTFFFFY62l2HFmtVOmjXAIxHkXojJrFLLPB9r3og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nuJG9Otl1xPGqOvUkLHprnZ8yR/MM3+MeZZGa82fmsgLABZzq9eLwvvQ5LtF1dv6Qc6BN5J1mgx1wja2jcKUPv2obFP3/LsqZkFFjL9eh2hFFkP9vellXcZTaHqoqnaWculr8J5ikWQr8x/i1F9gFv+f3hgJgmQzsNF18C66VME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EjQPJ9bO; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781625510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=clfUMkZwNDhEMD6LuBSozXbo25+2c6eTF48CzWS2CCM=;
	b=EjQPJ9bOod+XKhM/fdjgLxjk0BMUpq/x8l+osEtg23QqAtrSLzTURVUK1RzQiSKmTRnBMh
	/wburXO0x/J1qdA8xI0ruDkoBx/TsNbpogLrtWL1IvXmJ0YSPAChUR5NlOTi7QWAjBTKoj
	9ZQ2sL/mtyJ8DQaBy4wa6917qe0+Mu4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-141-SFtgIypHNwCma3ebomIlqQ-1; Tue,
 16 Jun 2026 11:58:27 -0400
X-MC-Unique: SFtgIypHNwCma3ebomIlqQ-1
X-Mimecast-MFC-AGG-ID: SFtgIypHNwCma3ebomIlqQ_1781625505
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 05C7518005BD;
	Tue, 16 Jun 2026 15:58:25 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.50.44])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AA4DB1954B08;
	Tue, 16 Jun 2026 15:58:20 +0000 (UTC)
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
Subject: [PATCH net 5/5] afs: Fix uncancelled rxrpc OOB message handler
Date: Tue, 16 Jun 2026 16:57:47 +0100
Message-ID: <20260616155749.2125907-6-dhowells@redhat.com>
In-Reply-To: <20260616155749.2125907-1-dhowells@redhat.com>
References: <20260616155749.2125907-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299904-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[redhat.com,auristor.com,kernel.org,davemloft.net,google.com,lists.infradead.org,vger.kernel.org,gmail.com,lzu.edu.cn];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:dhowells@redhat.com,m:marc.dionne@auristor.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-afs@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:d4n.for.sec@gmail.com,m:n05ec@lzu.edu.cn,m:jaltman@auristor.com,m:stable@kernel.org,m:d4nforsec@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,davemloft.net:email,sashiko.dev:url,lzu.edu.cn:email,auristor.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 925B5691E77

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
 fs/afs/rxrpc.c       | 4 +++-
 2 files changed, 5 insertions(+), 2 deletions(-)

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
index fd2d260fb25f..6241f9349f6b 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -128,6 +128,7 @@ void afs_close_socket(struct afs_net *net)
 	_enter("");
 
 	cancel_work_sync(&net->charge_preallocation_work);
+	cancel_work_sync(&net->rx_oob_work);
 	kernel_listen(net->socket, 0);
 	flush_workqueue(afs_async_calls);
 	flush_workqueue(afs_wq);
@@ -985,5 +986,6 @@ static void afs_rx_notify_oob(struct sock *sk, struct sk_buff *oob)
 {
 	struct afs_net *net = sk->sk_user_data;
 
-	schedule_work(&net->rx_oob_work);
+	if (net->live)
+		queue_work(afs_wq, &net->rx_oob_work);
 }


