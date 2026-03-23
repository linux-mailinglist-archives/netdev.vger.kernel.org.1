Return-Path: <netdev+bounces-270585-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDGDNE9bwWlKSgQAu9opvQ
	(envelope-from <netdev+bounces-270585-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 16:25:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D00F72F63E5
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 16:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 55D6B30D5917
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 15:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547073B4E96;
	Mon, 23 Mar 2026 15:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FFXjVOSp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70D03B38A0
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 15:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278350; cv=none; b=D9uSmK5ZvPypu0KOFhX0X0Pn3FvccdbJQjW9TGDIVbwsfmApU61/WvaXWBbOPZWDdLG6kjUNQHtaR3SULACg+K1r2uiv0oWWxY8RTd2HMJTEa+kVZ/svoaQJ/68D1QISOc98fo+ERkuFIjvoO8pdw2x5aa1P7sNGRguSETW2g/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278350; c=relaxed/simple;
	bh=2w2X5/keWSYIEq5kP0enuQqtU6bjbD/nwb96pNy227I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VB3Tqmu7B8zq+ogEfxvIsBUVj1/vH7kxl70HboMoWrCOiAr1CcTkdjHev5yTc4rYoJzza+EjiAkhnBhH/aQmCQkEifxFFh+lEsC84ltzLm2uLAE/JdMGqVhZ0wLIDh79XcDfbRsW3UH39fd0B3deuiiqIf3LMydqVKiWaNnf7/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FFXjVOSp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774278348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fc4Dc9rhjFkx+bfczLiQwRPtyzYqEhuP7T8AhY5Spp4=;
	b=FFXjVOSpQVbV/6MmX08AH9YIyh+LaAwFwj81DuESR/O31lXi8AXZ8wXa4+k+YF1vxlVigK
	sTsYoiFVS9Yo0OsxvVcTbCr//7QK1Uu9UqZP+KLH+K2KOuk12MgY+R1TfXdhjYNQ4ePdMA
	QgZYmkvpsOeLwH5ldpHqPMAh+vxpcWs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-546-8EXRhOFmMGyzePDbTZRciQ-1; Mon,
 23 Mar 2026 11:05:44 -0400
X-MC-Unique: 8EXRhOFmMGyzePDbTZRciQ-1
X-Mimecast-MFC-AGG-ID: 8EXRhOFmMGyzePDbTZRciQ_1774278342
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4518019560B4;
	Mon, 23 Mar 2026 15:05:42 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.121])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9AABB300019F;
	Mon, 23 Mar 2026 15:05:38 +0000 (UTC)
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
Subject: [PATCH net v2 05/10] rxrpc: Fix call removal to use RCU safe deletion
Date: Mon, 23 Mar 2026 15:04:56 +0000
Message-ID: <20260323150505.3513839-6-dhowells@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270585-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D00F72F63E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fix rxrpc call removal from the rxnet->calls list to use list_del_rcu()
rather than list_del_init() to prevent stuffing up reading
/proc/net/rxrpc/calls from potentially getting into an infinite loop.

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
 net/rxrpc/call_object.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
index 918f41d97a2f..0e47751d5937 100644
--- a/net/rxrpc/call_object.c
+++ b/net/rxrpc/call_object.c
@@ -654,9 +654,9 @@ void rxrpc_put_call(struct rxrpc_call *call, enum rxrpc_call_trace why)
 	if (dead) {
 		ASSERTCMP(__rxrpc_call_state(call), ==, RXRPC_CALL_COMPLETE);
 
-		if (!list_empty(&call->link)) {
+		if (on_list_rcu(&call->link)) {
 			spin_lock(&rxnet->call_lock);
-			list_del_init(&call->link);
+			list_del_rcu(&call->link);
 			spin_unlock(&rxnet->call_lock);
 		}
 
@@ -738,7 +738,7 @@ void rxrpc_destroy_all_calls(struct rxrpc_net *rxnet)
 			_debug("Zapping call %p", call);
 
 			rxrpc_see_call(call, rxrpc_call_see_zap);
-			list_del_init(&call->link);
+			list_del_rcu(&call->link);
 
 			pr_err("Call %p still in use (%d,%s,%lx,%lx)!\n",
 			       call, refcount_read(&call->ref),


