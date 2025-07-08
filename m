Return-Path: <netdev+bounces-205145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6305AFD972
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 23:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B1F5486C7A
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 21:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB73224676F;
	Tue,  8 Jul 2025 21:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bHCZu89o"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9970F1FF5F9
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 21:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752009341; cv=none; b=KeOxa9LlwbjXuNV04NdQ/kqVcdbJqeIWBvoP89v+7U/9L5UQPgYJfMOqmv7zYiU5J/XKC78IXfB3yiHDRFZgHIItsi0yzm1VAzBfL+4nHQlTzOLX3ub9WfkT0JSAem48q8IUOtER6I2Y67xKSCbPCVVSxTjSi+co0eGhxk4u3zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752009341; c=relaxed/simple;
	bh=67biF2s7vghpTgu41A1+jjZdbCbNYkcPADl9PPNEn7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qE/1+JUV9/1+Ql1MFLslZyceTlQkmemetFH5xVmfqCdUH2Z9jb2K9pogKyYmYM3G2T1dfzy/lLsv5xlOza+BD2zEmNan1sEkh7JA6jlxOwTQkUAbVGrN1tQBOaTmpQ78kZRkHic8l9F/YzkMspGdVwTxy83ksEEyHX4+3YfXvAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bHCZu89o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752009337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U23alWt7Z8mxTe8Pg7NGMLFn77+q210vRmdrnodIX8s=;
	b=bHCZu89o+mcG2Xg2NndENz8Xpq3tu37j9ZGWYLfW0EezhA/ZnKhVFzy+lex89ZXIANzPjD
	EhBFtaejWng+rUb3IhXkNcESFvc3O5T6SO1vR7mv3gn9XlYXRcH57uNI5owxz3jCFpCiX9
	vq0AKS+ksPFKGXK6neUnG0haTduWRyY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-58-v27iGdYjOZmv7xT3FMipCA-1; Tue,
 08 Jul 2025 17:15:36 -0400
X-MC-Unique: v27iGdYjOZmv7xT3FMipCA-1
X-Mimecast-MFC-AGG-ID: v27iGdYjOZmv7xT3FMipCA_1752009334
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C9BA81944A82;
	Tue,  8 Jul 2025 21:15:27 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.81])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B896519560AB;
	Tue,  8 Jul 2025 21:15:22 +0000 (UTC)
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
	"Junvyyang, Tencent Zhuque Lab" <zhuque@tencent.com>,
	LePremierHomme <kwqcheii@proton.me>,
	Willy Tarreau <w@1wt.eu>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net v2 2/2] rxrpc: Fix oops due to non-existence of prealloc backlog struct
Date: Tue,  8 Jul 2025 22:15:04 +0100
Message-ID: <20250708211506.2699012-3-dhowells@redhat.com>
In-Reply-To: <20250708211506.2699012-1-dhowells@redhat.com>
References: <20250708211506.2699012-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

If an AF_RXRPC service socket is opened and bound, but calls are
preallocated, then rxrpc_alloc_incoming_call() will oops because the
rxrpc_backlog struct doesn't get allocated until the first preallocation is
made.

Fix this by returning NULL from rxrpc_alloc_incoming_call() if there is no
backlog struct.  This will cause the incoming call to be aborted.

Reported-by: Junvyyang, Tencent Zhuque Lab <zhuque@tencent.com>
Suggested-by: Junvyyang, Tencent Zhuque Lab <zhuque@tencent.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: LePremierHomme <kwqcheii@proton.me>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Willy Tarreau <w@1wt.eu>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/call_accept.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/rxrpc/call_accept.c b/net/rxrpc/call_accept.c
index 7271977b1683..49fccee1a726 100644
--- a/net/rxrpc/call_accept.c
+++ b/net/rxrpc/call_accept.c
@@ -255,6 +255,9 @@ static struct rxrpc_call *rxrpc_alloc_incoming_call(struct rxrpc_sock *rx,
 	unsigned short call_tail, conn_tail, peer_tail;
 	unsigned short call_count, conn_count;
 
+	if (!b)
+		return NULL;
+
 	/* #calls >= #conns >= #peers must hold true. */
 	call_head = smp_load_acquire(&b->call_backlog_head);
 	call_tail = b->call_backlog_tail;


