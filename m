Return-Path: <netdev+bounces-276483-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOOCBdVH1mkFCwgAu9opvQ
	(envelope-from <netdev+bounces-276483-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 14:19:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A383BBE50
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 14:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 468A2305426A
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 12:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4FC3C872E;
	Wed,  8 Apr 2026 12:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OZ5BVkjy"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7A43C7E1E
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 12:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775650472; cv=none; b=ODeGiSWDofqNQkqCYNm4kG2UdVOpxdAGvwwlXSr9qwadZ15JyCP3kY1wg5h7IQfHf0c59Ntw/xHEeUCdJdaMMtVa9y7RgHDqNwKjSsZZDCzloMTipQ39oVmXlNeNhxsjP4GoL7E34fh0+J3Di8xygUI5P9D9bQq4J2Lx02tliC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775650472; c=relaxed/simple;
	bh=E5Ktr5ujZ7VRhGZNliJlSlHfN++85hVgVhq64IAONJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OfRtXLnluqUeAOF2bWFp/TW6BWDqBYQV3V5dM8z7VxLX5awcGqm3rBJSbvVzEvoiScaYkpRfCoUoeFYqt0EKMCcjEGWtH7mKUIB3V8AnvyrcUhffADteCNfLg5GvBDlGYZo03DfFvxaG9R2YjPc3m6aDk35Xa4EkfDS2VEKXa54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OZ5BVkjy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775650470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=svfAwTnHVWeMxDrZSO9dpHkcb5nEFh4Zczxno4SRn7Y=;
	b=OZ5BVkjyHUZqtG/f2J5lCRgX/G68X1iqIk9azsRMeRtjiHhpIkVcHNQ2VlVU8nuTFYk+WR
	k26PJqqsAzm1xxSLTwIDMBzK8K1Kt9xFZqtj86doks+0ffUptNpADtALhU5PqxP5JjWekU
	X4/PeozVlijWblRyA2iHBD14Wkajq/8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-sxm-dZtYOum-Q4iZwHKarQ-1; Wed,
 08 Apr 2026 08:14:26 -0400
X-MC-Unique: sxm-dZtYOum-Q4iZwHKarQ-1
X-Mimecast-MFC-AGG-ID: sxm-dZtYOum-Q4iZwHKarQ_1775650464
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DFCC41956059;
	Wed,  8 Apr 2026 12:14:23 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.32.94])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1AE741800764;
	Wed,  8 Apr 2026 12:14:19 +0000 (UTC)
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
	Keenan Dong <keenanat2000@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Willy Tarreau <w@1wt.eu>,
	stable@kernel.org
Subject: [PATCH net v5 13/21] rxrpc: fix oversized RESPONSE authenticator length check
Date: Wed,  8 Apr 2026 13:12:41 +0100
Message-ID: <20260408121252.2249051-14-dhowells@redhat.com>
In-Reply-To: <20260408121252.2249051-1-dhowells@redhat.com>
References: <20260408121252.2249051-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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
	FREEMAIL_CC(0.00)[redhat.com,auristor.com,kernel.org,davemloft.net,google.com,lists.infradead.org,vger.kernel.org,gmail.com,1wt.eu];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-276483-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,1wt.eu:email,infradead.org:email,davemloft.net:email,auristor.com:email]
X-Rspamd-Queue-Id: 06A383BBE50
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Keenan Dong <keenanat2000@gmail.com>

rxgk_verify_response() decodes auth_len from the packet and is supposed
to verify that it fits in the remaining bytes. The existing check is
inverted, so oversized RESPONSE authenticators are accepted and passed
to rxgk_decrypt_skb(), which can later reach skb_to_sgvec() with an
impossible length and hit BUG_ON(len).

Decoded from the original latest-net reproduction logs with
scripts/decode_stacktrace.sh:

RIP: __skb_to_sgvec()
  [net/core/skbuff.c:5285 (discriminator 1)]
Call Trace:
 skb_to_sgvec() [net/core/skbuff.c:5305]
 rxgk_decrypt_skb() [net/rxrpc/rxgk_common.h:81]
 rxgk_verify_response() [net/rxrpc/rxgk.c:1268]
 rxrpc_process_connection()
   [net/rxrpc/conn_event.c:266 net/rxrpc/conn_event.c:364
    net/rxrpc/conn_event.c:386]
 process_one_work() [kernel/workqueue.c:3281]
 worker_thread()
   [kernel/workqueue.c:3353 kernel/workqueue.c:3440]
 kthread() [kernel/kthread.c:436]
 ret_from_fork() [arch/x86/kernel/process.c:164]

Reject authenticator lengths that exceed the remaining packet payload.

Fixes: 9d1d2b59341f ("rxrpc: rxgk: Implement the yfs-rxgk security class (GSSAPI)")
Signed-off-by: Keenan Dong <keenanat2000@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: Willy Tarreau <w@1wt.eu>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
cc: stable@kernel.org
---
 net/rxrpc/rxgk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rxrpc/rxgk.c b/net/rxrpc/rxgk.c
index 01dbdf0b5cf2..9e4a4ff28913 100644
--- a/net/rxrpc/rxgk.c
+++ b/net/rxrpc/rxgk.c
@@ -1224,7 +1224,7 @@ static int rxgk_verify_response(struct rxrpc_connection *conn,
 
 	auth_offset	= offset;
 	auth_len	= ntohl(xauth_len);
-	if (auth_len < len)
+	if (auth_len > len)
 		goto short_packet;
 	if (auth_len & 3)
 		goto inconsistent;


