Return-Path: <netdev+bounces-148105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A68449E0613
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 15:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25D8816D286
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 14:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA73821C17F;
	Mon,  2 Dec 2024 14:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gRdKLTx3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4812821C169
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 14:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733150021; cv=none; b=gKogsViHf0KgMdThJ+UPAD/ET0lZEoJtRvpWhcPwmeWjk3m6tniLIVaCBpREH43ByY3fs2urpZQwptxCPGBrdMkdarUA8MhO5miPq+zzW8QnG7THuLxPT+17OUcWewCtFIUSo7U935lnNuUwcTsscZblEdnhpbHatprdogM2/Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733150021; c=relaxed/simple;
	bh=4dc+Nkaax4urmXZGQKI75aQvCDUzDWDJU9xnT0gKGJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FQHnWLPy7KpFc1PjyYvJGLXPQ6HAaAqrqS4j63X4bgNbSbJPHNSjVc0w2ShzxXHmu9NKZMetXEez/1O6Di0efRQMhwyIsFU9lZGqO/xnVvVMBXCuOsd//tDzU1pJwwtanlIIJBxriDdV6vF2qSic3s+wVy5M47pn0GNxy/nrqjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gRdKLTx3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733150019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9xQ2xdCLYYlx45F0qwkdxOdotOSCgHYTL3xHslEjIPc=;
	b=gRdKLTx3QFv9d4aLCKszfttEgGIJVxwHlG7IZvq98EzQTUXFAhvEJymwcxW35GGvFED1W6
	Rnqk3l/d97LO4jZkApfvS0eSsTcwZ/TXxDKE6xey9jJq9Ypll+sP+aOVj+zYPO7v86QNdD
	jvHyze7w0PD8FyesNW0SV4sZtA+davg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-103-LsnAEZuCP0mV_DhoqTXxrg-1; Mon,
 02 Dec 2024 09:33:35 -0500
X-MC-Unique: LsnAEZuCP0mV_DhoqTXxrg-1
X-Mimecast-MFC-AGG-ID: LsnAEZuCP0mV_DhoqTXxrg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5149D191007C;
	Mon,  2 Dec 2024 14:33:32 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C5F1C195605A;
	Mon,  2 Dec 2024 14:33:29 +0000 (UTC)
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
Subject: [PATCH net-next 36/37] rxrpc: Fix request for an ACK when cwnd is minimum
Date: Mon,  2 Dec 2024 14:30:54 +0000
Message-ID: <20241202143057.378147-37-dhowells@redhat.com>
In-Reply-To: <20241202143057.378147-1-dhowells@redhat.com>
References: <20241202143057.378147-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

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
index 891b85b3b9e7..c8ae59103c21 100644
--- a/net/rxrpc/output.c
+++ b/net/rxrpc/output.c
@@ -468,7 +468,7 @@ static size_t rxrpc_prepare_data_subpacket(struct rxrpc_call *call,
 		why = rxrpc_reqack_ack_lost;
 	else if (txb->flags & RXRPC_TXBUF_RESENT)
 		why = rxrpc_reqack_retrans;
-	else if (call->cong_ca_state == RXRPC_CA_SLOW_START && call->cong_cwnd <= 2)
+	else if (call->cong_ca_state == RXRPC_CA_SLOW_START && call->cong_cwnd <= RXRPC_MIN_CWND)
 		why = rxrpc_reqack_slow_start;
 	else if (call->tx_winsize <= 2)
 		why = rxrpc_reqack_small_txwin;


