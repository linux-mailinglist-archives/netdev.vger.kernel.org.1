Return-Path: <netdev+bounces-148097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 328399E0555
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 15:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC714286846
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 14:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6FA217670;
	Mon,  2 Dec 2024 14:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cnUSe5x8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F743217661
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 14:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149986; cv=none; b=nq29gR0eCsSMUhKyjoyZ+qJMULJZs7cY4d3Zek2NK4ZVlQ8fx6UZOicT/pA/GA7urkS9yEhCkjdXYKmETigBjqmcylBIg2M2UTnjujU2E2zRL9hZb6GrHkx7xvYvjcU5wsGB5cmkLO1lLblD8h1f3R5ByBHJzfFKw1Ai19LpDH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149986; c=relaxed/simple;
	bh=q8eI2LFlXh5tUytmJruAwYqFJpkoG3KwZN+jS6Rw+WQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gQRUFp9MEynhFeF+oUzgI8t+oWq+Zj/KGbUolmH5DsOqnMh5oPNqqd2KZVdvj9T3Q7F9uk4Bv468QFQPKHcKH5e52lovpp1SsIi2X3v5RcYBv5KzasROXTSOABGx9tK6AZk4BqRXtA/pEwSQOrkIfOVkKA6R6U4fTt8ZyinbKeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cnUSe5x8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733149984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oQgmi9sMCMQxv1vrK3Hj0AIG3gww5bOixPaAJ5ZigAk=;
	b=cnUSe5x8gzTysnKsEoL8mg7cEtoR/yO8ypyPXM1J+0M6nN/2lCXVEfURqOyhO+84tiWwKM
	/KExzYN0YFo6Z1qwp5PSDE/hu+f6jyCR5PyjKH5cbn0bWIW210nIA0lUYektcLGy0RlmiG
	0h7TOH4H0JYpVDo1ruy1IYzw9ri5x+k=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-40iNI6qHPa-yLFEV8y64ag-1; Mon,
 02 Dec 2024 09:33:01 -0500
X-MC-Unique: 40iNI6qHPa-yLFEV8y64ag-1
X-Mimecast-MFC-AGG-ID: 40iNI6qHPa-yLFEV8y64ag
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 034601955DB5;
	Mon,  2 Dec 2024 14:33:00 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5E2DE195605A;
	Mon,  2 Dec 2024 14:32:57 +0000 (UTC)
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
Subject: [PATCH net-next 28/37] rxrpc: Fix initial resend timeout
Date: Mon,  2 Dec 2024 14:30:46 +0000
Message-ID: <20241202143057.378147-29-dhowells@redhat.com>
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


