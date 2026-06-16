Return-Path: <netdev+bounces-299903-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id o7/jNl95MWoHkQUAu9opvQ
	(envelope-from <netdev+bounces-299903-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 18:27:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D49D369215D
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 18:27:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=MP132H1V;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299903-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-299903-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6C76E304FD95
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 15:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75CA46AEFA;
	Tue, 16 Jun 2026 15:58:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E6B466B74
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 15:58:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625506; cv=none; b=qc92sC3vz2drC44PZf6skRnTqJisogRjqtiPS4dpH1P5HotiRjCGLSvZaTc5Hjyqe8Fouwn6OKWjaMtvzN/mDkuOx4szLQkEaGdSy92TwyTpB7QLbuEih08xdmeSJRkL3pu4Qv2MvT6AF/xa/ug6Qipiz5e5oPIvtMIBfY5R1+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625506; c=relaxed/simple;
	bh=zReoDif8GIHIYA2Hu3YgKhY7lb4ZdfEXUjn0fON4DOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kPyg6hTE6hoG5IGGh3e88eTNdnRK3uLqKMUDx8hdA+XEY2tshQOyOq3RWwx1Hf/MDznFhYzRvNw1i8GuT03v/SJZcGQgSACbo5Xa2tsM4KimcHuJaqu8RyJo4Lgc6mdeCf+YbZqiUSiyWw0uReYKDTk2e20z6kaiu4FQQvxNAIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MP132H1V; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781625504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xg0b+LuRM8nTPjV/Ftm/dukTXV9BKAoWQPj8aMxMSko=;
	b=MP132H1Vm/fejGzTdjcpIwrX8pUWet8GQTsA7v+Wty0QbECx9a3fgtOIEfyWui/ECB68Pe
	RXkleH7PpSZfO8ntZyUZVYZqBQNbJFSacEQojm3LsFISH2kaSGzM3yiIR58zT5y8VeD16q
	gYZCQ/CORZTPA+ur0XYTaWREWg8b4T0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-ywQM3Qp7N4CxrV9BWFueuw-1; Tue,
 16 Jun 2026 11:58:21 -0400
X-MC-Unique: ywQM3Qp7N4CxrV9BWFueuw-1
X-Mimecast-MFC-AGG-ID: ywQM3Qp7N4CxrV9BWFueuw_1781625499
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1A7CA1956094;
	Tue, 16 Jun 2026 15:58:19 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.50.44])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DFAE9195419E;
	Tue, 16 Jun 2026 15:58:14 +0000 (UTC)
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
Subject: [PATCH net 4/5] afs: Fix further netns teardown to cancel the preallocation charger
Date: Tue, 16 Jun 2026 16:57:46 +0100
Message-ID: <20260616155749.2125907-5-dhowells@redhat.com>
In-Reply-To: <20260616155749.2125907-1-dhowells@redhat.com>
References: <20260616155749.2125907-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299903-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,lzu.edu.cn:email,auristor.com:email,infradead.org:email,vger.kernel.org:from_smtp,sashiko.dev:url,davemloft.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D49D369215D

When an afs network namespace is torn down, it cancels and waits for the
work item that keeps the preallocated rxrpc call/conn/peer queue charged
before disabling incoming (i.e. listen 0), but there's a small window in
which it can be requeued by an incoming call wending through the I/O
thread.

Fix this by flushing the workqueue on which the charger runs after reducing
the listen backlog to zero.

Fixes: 47694fbc9d24 ("afs: Fix netns teardown to cancel the preallocation charger")
Reported-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://sashiko.dev/#/patchset/20260609140911.838677-1-dhowells%40redhat.com
cc: Li Daming <d4n.for.sec@gmail.com>
cc: Ren Wei <n05ec@lzu.edu.cn>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: stable@kernel.org
---
 fs/afs/rxrpc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index d5cfd24e815b..fd2d260fb25f 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -130,6 +130,7 @@ void afs_close_socket(struct afs_net *net)
 	cancel_work_sync(&net->charge_preallocation_work);
 	kernel_listen(net->socket, 0);
 	flush_workqueue(afs_async_calls);
+	flush_workqueue(afs_wq);
 
 	if (net->spare_incoming_call) {
 		afs_put_call(net->spare_incoming_call);


