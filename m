Return-Path: <netdev+bounces-204537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDEFAFB122
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 12:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 851BC17F246
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 10:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FE9294A04;
	Mon,  7 Jul 2025 10:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UidLbdOF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75515293C7E
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 10:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751883905; cv=none; b=IueOMPGOo/P/hmc7aQFqyEGRdwsEqid9FuQUSX36H00Zcc5rxV+ah6wnUnGfbd5E1umYwlvNKo0nVtoIonKf1Yq8okpwQcN2NAzYtnXz98MCZILCgmrevIA+l16SU4TW4mnOnJEi5RDttCpAQP9LBROH0Gk2Xl0MvNRdTQaVboA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751883905; c=relaxed/simple;
	bh=CSkzHkSLZb85ATDXN1XVNRPwM4yhfT0dut0dQqFmWDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aDxVRmoL3TGfkQOzEwlTQUVcCCSnqb+0uWP8+pnZH1OTQgae7uenQZGSdCyExM+AZn/kEjXVWRlslZf8LQueRZ1rcp1LNEWRNRrhxucTWe3s6HPlCAOlX5uxmFQCo0JhdKs4VHr8vY5HYlp13rR4DmH78i7GBm8Qv8aTJgGSEy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UidLbdOF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751883902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c8uLvrdEI8a2tyD8FkZ5ui0XQcinAdyYHyFTkQHvcGo=;
	b=UidLbdOFOtG9fHwzr/8MShac8oWJPGHNr9bDTsoOaTlU2wrbOqBZW4sEhbf+1hrh/3RToB
	sXnMM1RorYJb+F9/8G8ulOacgpdcHiL3fYxuBhPA+PO5qR+yqrGTaHki4+X4QWSxLM4/an
	YWcrIp66zXpT6o1jpm+YoLn17ms5L2c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-438-l6sWfO9qNL2mFig5armnMg-1; Mon,
 07 Jul 2025 06:24:56 -0400
X-MC-Unique: l6sWfO9qNL2mFig5armnMg-1
X-Mimecast-MFC-AGG-ID: l6sWfO9qNL2mFig5armnMg_1751883893
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 89B71180028A;
	Mon,  7 Jul 2025 10:24:53 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.81])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 849661956087;
	Mon,  7 Jul 2025 10:24:49 +0000 (UTC)
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
	Simon Horman <horms@kernel.org>
Subject: [PATCH net 2/2] rxrpc: Fix bug due to prealloc collision
Date: Mon,  7 Jul 2025 11:24:34 +0100
Message-ID: <20250707102435.2381045-3-dhowells@redhat.com>
In-Reply-To: <20250707102435.2381045-1-dhowells@redhat.com>
References: <20250707102435.2381045-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

When userspace is using AF_RXRPC to provide a server, it has to preallocate
incoming calls and assign to them call IDs that will be used to thread
related recvmsg() and sendmsg() together.  The preallocated call IDs will
automatically be attached to calls as they come in until the pool is empty.

To the kernel, the call IDs are just arbitrary numbers, but userspace can
use the call ID to hold a pointer to prepared structs.  In any case, the
user isn't permitted to create two calls with the same call ID (call IDs
become available again when the call ends) and EBADSLT should result from
sendmsg() if an attempt is made to preallocate a call with an in-use call
ID.

However, the cleanup in the error handling will trigger both assertions in
rxrpc_cleanup_call() because the call isn't marked complete and isn't
marked as having been released.

Fix this by setting the call state in rxrpc_service_prealloc_one() and then
marking it as being released before calling the cleanup function.

Fixes: 00e907127e6f ("rxrpc: Preallocate peers, conns and calls for incoming service requests")
Reported-by: Junvyyang, Tencent Zhuque Lab <zhuque@tencent.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: LePremierHomme kwqcheii@proton.me
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/call_accept.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/rxrpc/call_accept.c b/net/rxrpc/call_accept.c
index a4b363b47cca..32af666547f8 100644
--- a/net/rxrpc/call_accept.c
+++ b/net/rxrpc/call_accept.c
@@ -149,6 +149,8 @@ static int rxrpc_service_prealloc_one(struct rxrpc_sock *rx,
 
 id_in_use:
 	write_unlock(&rx->call_lock);
+	rxrpc_prefail_call(call, RXRPC_CALL_LOCAL_ERROR, -EBADSLT);
+	__set_bit(RXRPC_CALL_RELEASED, &call->flags);
 	rxrpc_cleanup_call(call);
 	_leave(" = -EBADSLT");
 	return -EBADSLT;


