Return-Path: <netdev+bounces-205143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5762FAFD96C
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 23:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0A68483728
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 21:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA1B246787;
	Tue,  8 Jul 2025 21:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ARIie/WY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0A61E22FC
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 21:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752009329; cv=none; b=D3sr70d6Q5roD+RA+dHTxZdKs9CvPFKqWHqTMAAproGBU4acus7+ExRiTZHAKoLZ8PkaDXYYwCp2NoHHig3Dn25EbC4cP7Gt8QEtfaMWAeXI2lcwr9EZe/lJO16+LBT68dEwXLLrvLwrG2h+827MR2/BjviqU5gEzaFDKqwGWh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752009329; c=relaxed/simple;
	bh=oIwauWBitCHoTQ9VMTbdy7XKVlt9XvjiqRagcK4xxak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DOM9jpHVZJcEhxB4WnvouiNzcTC6JbYn/Kp7WoMXi9ibJg+u5WJabkLpdDJnCVXYFMkVq/gNc+OWUwj7z55mWDi50u0zThvCkuBrdXUkn+nnTeaucLeK22i4vbIU1OC8g6KJ0HIs3Q7eGe2c0/DRmzGPsbNQmkOy9z0s3Ix7xqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ARIie/WY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752009326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8rYMXhzORJFtpiFuOgBAdQlsclkOyaJAFhe4UXEpjmE=;
	b=ARIie/WYEPQYOvb+vnX/vpXq1lJTyvrmPSt1yUMf7T3JRbbbK6T5fajbTeWQeygd/ZdZpX
	gOOtxxAJVK3jFdhZ+ZAT8wHQbacqPmJabwpDFi669tEgYv4Khxgkn9rJSLpmVGEwdU75po
	Mcv+pdiExxE2m++9hcRqmVZMVlYMrug=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-D5YAJfLiMmGaZhcGEkH-Uw-1; Tue,
 08 Jul 2025 17:15:23 -0400
X-MC-Unique: D5YAJfLiMmGaZhcGEkH-Uw-1
X-Mimecast-MFC-AGG-ID: D5YAJfLiMmGaZhcGEkH-Uw_1752009321
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9FECC193F057;
	Tue,  8 Jul 2025 21:15:20 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.81])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DACEF19560AB;
	Tue,  8 Jul 2025 21:15:15 +0000 (UTC)
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
	Simon Horman <horms@kernel.org>
Subject: [PATCH net v2 1/2] rxrpc: Fix bug due to prealloc collision
Date: Tue,  8 Jul 2025 22:15:03 +0100
Message-ID: <20250708211506.2699012-2-dhowells@redhat.com>
In-Reply-To: <20250708211506.2699012-1-dhowells@redhat.com>
References: <20250708211506.2699012-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

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
cc: LePremierHomme <kwqcheii@proton.me>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---

Notes:
    Changes
    =======
    ver #2)
     - Don't need to double-set RXRPC_CALL_RELEASED.

 net/rxrpc/call_accept.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/rxrpc/call_accept.c b/net/rxrpc/call_accept.c
index a4b363b47cca..7271977b1683 100644
--- a/net/rxrpc/call_accept.c
+++ b/net/rxrpc/call_accept.c
@@ -149,6 +149,7 @@ static int rxrpc_service_prealloc_one(struct rxrpc_sock *rx,
 
 id_in_use:
 	write_unlock(&rx->call_lock);
+	rxrpc_prefail_call(call, RXRPC_CALL_LOCAL_ERROR, -EBADSLT);
 	rxrpc_cleanup_call(call);
 	_leave(" = -EBADSLT");
 	return -EBADSLT;


