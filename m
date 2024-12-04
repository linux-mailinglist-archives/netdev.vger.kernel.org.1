Return-Path: <netdev+bounces-148884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6604F9E34BB
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 09:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E3A3167B62
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 08:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAD420C481;
	Wed,  4 Dec 2024 07:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NW54JPho"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8476C20C472
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 07:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733298603; cv=none; b=F031UaH0no1VvZRC9UqDnoDiyunF8Y3nqCAxG/wBg6dEJYHlAVsA6VukmYpHCqIsIhyypx52AjgoXEJdGix1tERVlkX4wtmEqgqSCMFfyYMKWGdEGbCD7osVcQ5Syzcq0rD0jKDfiN1+G3v+UDHkzVHChmUKH76sTJXeFULBxic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733298603; c=relaxed/simple;
	bh=Adu58XXV9H5+J/t7envvVjBnaMNTj02DjDWWugq+ZwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kcpPOraf77GBilZgVJX8Jubk3sksZndA51leAkGHQlOSWVGPUzgo2tjGCnPMutBbHHQauD3p6ZZG4OCYpd2jOUJXOekCYvG366yukrErb18ENxsCamxs4Ea+IgxL3ZsjPPncbidNiK2UXDYzLOGB3kjtfA3yZx1BYqJ3NuYBAx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NW54JPho; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733298600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U66dxHSg4iIqCI5/yRyoDqAI42q40uNW9nKzWmZRf5M=;
	b=NW54JPhoAjlyUKF7JtxUrS2rXOmuXeLyohe1L9nBC1D/VRY1TuVohTluq3kMCQc+0t5drN
	GXvxB66V+SPxoApf1q/mYOo398KbA5igcF6iehjMN0e5zH4e52Y3p1UaEikF1QLvyQiTuH
	B/LYVjixN4TrFVwamVEaYpNiLWvUEto=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-JbIjREoxN760gDkNz5qZUQ-1; Wed,
 04 Dec 2024 02:49:55 -0500
X-MC-Unique: JbIjREoxN760gDkNz5qZUQ-1
X-Mimecast-MFC-AGG-ID: JbIjREoxN760gDkNz5qZUQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2BAAE19560B6;
	Wed,  4 Dec 2024 07:49:54 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A20CD1956048;
	Wed,  4 Dec 2024 07:49:51 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 38/39] rxrpc: Fix request for an ACK when cwnd is minimum
Date: Wed,  4 Dec 2024 07:47:06 +0000
Message-ID: <20241204074710.990092-39-dhowells@redhat.com>
In-Reply-To: <20241204074710.990092-1-dhowells@redhat.com>
References: <20241204074710.990092-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

rxrpc_prepare_data_subpacket() sets the REQUEST-ACK flag on the outgoing
DATA packet under a number of circumstances, including, theoretically, when
the cwnd is at minimum (or less).  However, the minimum in this function is
hard-coded as 2, but the actual minimum is RXRPC_MIN_CWND (which is
currently 4) and so this never occurs.

Without this, we will miss the request of some ACKs, potentially leading to
a transmission stall until a timeout occurs on one side or the other that
leads to an ACK being generated.

Fix the function to use RXRPC_MIN_CWND rather than a hard-coded number.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/output.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rxrpc/output.c b/net/rxrpc/output.c
index ecaf3becee40..f934551a9b1c 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -469,7 +469,7 @@ static size_t rxrpc_prepare_data_subpacket(struct rxrpc_call *call,
 		why = rxrpc_reqack_ack_lost;
 	else if (txb->flags & RXRPC_TXBUF_RESENT)
 		why = rxrpc_reqack_retrans;
-	else if (call->cong_ca_state == RXRPC_CA_SLOW_START && call->cong_cwnd <= 2)
+	else if (call->cong_ca_state == RXRPC_CA_SLOW_START && call->cong_cwnd <= RXRPC_MIN_CWND)
 		why = rxrpc_reqack_slow_start;
 	else if (call->tx_winsize <= 2)
 		why = rxrpc_reqack_small_txwin;


