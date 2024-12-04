Return-Path: <netdev+bounces-148876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FB39E351B
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 09:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0733EB31B1E
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 07:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91E81EE01B;
	Wed,  4 Dec 2024 07:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X6NbV12S"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20461DF997
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 07:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733298569; cv=none; b=q01oiRc0mX+yiKSpG3jLrOS5NYLSmlGnMp0eMYvxSAi1kE54cg77M8Fv3XV7W/6v1cgDigU90sYbYci+I/pIe/SxfoAvPrClwbcp8ZcVdksocBlqMClUeHE+jiGTXC1huOeiKIOB2CZCNVF7Pv/NqKMqfem4J+CI1Ch/jWpehbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733298569; c=relaxed/simple;
	bh=q8eI2LFlXh5tUytmJruAwYqFJpkoG3KwZN+jS6Rw+WQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DC+JddJ6AV4M+j1wpP07G915+9qg41j/P9OS3cHl9yINi58lnqKSX0mxnsne+upmRNzgTufGInlntj46vQGm59EhugYTs+EmMNDubo7/gQ63q+EoRflIGKAAXnOQ52IGzqztpJ3dTF1Q3n/3K74yL5a3y3Tu10sbOEi13uVzB/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X6NbV12S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733298567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oQgmi9sMCMQxv1vrK3Hj0AIG3gww5bOixPaAJ5ZigAk=;
	b=X6NbV12SZz8rdhU1ojhHeg21IG036+BbeLCxnV9v/3dQN2BG33V4/YYNoYFoz1IngH8VLO
	jljRK2gLvMmCSH0g8vR8vOzjmopj5bgirBXYnuUQTxx56CTrtUGv9ys4Pnw4jyT9Fkz0ka
	Bfi+d3bFeOivdNZN261wWPlacqvnI2A=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-272-aZVkxZFGPmSVjevHovESwg-1; Wed,
 04 Dec 2024 02:49:23 -0500
X-MC-Unique: aZVkxZFGPmSVjevHovESwg-1
X-Mimecast-MFC-AGG-ID: aZVkxZFGPmSVjevHovESwg
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5791B19560A2;
	Wed,  4 Dec 2024 07:49:22 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E210E1956048;
	Wed,  4 Dec 2024 07:49:18 +0000 (UTC)
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
Subject: [PATCH net-next v2 30/39] rxrpc: Fix initial resend timeout
Date: Wed,  4 Dec 2024 07:46:58 +0000
Message-ID: <20241204074710.990092-31-dhowells@redhat.com>
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

The constant for the initial resend timeout is in milliseconds, but the
variable it's assigned to is in microseconds.  Fix the constant to be in
microseconds.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/rtt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rxrpc/rtt.c b/net/rxrpc/rtt.c
index 3f1ec8e420a6..aff75e168de8 100644
--- a/net/rxrpc/rtt.c
+++ b/net/rxrpc/rtt.c
@@ -12,7 +12,7 @@
 #include "ar-internal.h"
 
 #define RXRPC_RTO_MAX	(120 * USEC_PER_SEC)
-#define RXRPC_TIMEOUT_INIT ((unsigned int)(1 * MSEC_PER_SEC)) /* RFC6298 2.1 initial RTO value */
+#define RXRPC_TIMEOUT_INIT ((unsigned int)(1 * USEC_PER_SEC)) /* RFC6298 2.1 initial RTO value */
 #define rxrpc_jiffies32 ((u32)jiffies)		/* As rxrpc_jiffies32 */
 
 static u32 rxrpc_rto_min_us(struct rxrpc_peer *peer)


