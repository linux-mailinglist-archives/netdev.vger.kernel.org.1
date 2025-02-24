Return-Path: <netdev+bounces-169243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 222E3A43119
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 00:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2CA516B1F2
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 23:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B8120CCEA;
	Mon, 24 Feb 2025 23:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xw25v1sL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC65B20C479
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 23:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740440533; cv=none; b=stgoypnA/PfoIzkpNyzsVVnNvVZJkLlrkji1vnvlgtSrJST0KTwxdRNxktHymRLcCCfutVpC8vUouACaa+Fcn1butcYI1ZLtQ4GukWp2yKJRbnwC/Zg5ISj87vWqcon30ubKx7MF5xTna1o6GZF+g1YaxB04Rkjy8r0NaygHwAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740440533; c=relaxed/simple;
	bh=LdM6YWJorqkUh0RrJpizFWheSHgWKS3j4SIexQeKkT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LYD3z+VnqESbO6/I3xxrJl0ph/zAMdO6wFjhw808zzWNBUNBQiNHzUysfvHpGHQdi48Um2wFplNWXrLy3mUZIpalwnAdnSFkMdYFT8BdPy/HL5UHTWKUhOGiVGXGaBP8rH1G8/Q872t1lnYPVakZDmYAUajm4YQSYYttTt4fqew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xw25v1sL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740440530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TPX5X0FLbu8i/pSR/GZDg1fvDLeMt1ooWaCQcD/mFIo=;
	b=Xw25v1sL0KgEVjF8AdM5sJwt3INc7RZgAF8mhryYP88k/con3EzoCAoz/PvXMb2nEynoOk
	vX9n5d98D/Ro5tIGp8oUsiKaYWTsz3oE7D5mLsxTkc1d2BkO1MPk6KFMVT2Do1wCmKM3fc
	d5rA2kMTNwnBnZMk8urm25KEXpGYF5E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-670-t6NQHXqbPRK9KrwrBhFdPw-1; Mon,
 24 Feb 2025 18:42:06 -0500
X-MC-Unique: t6NQHXqbPRK9KrwrBhFdPw-1
X-Mimecast-MFC-AGG-ID: t6NQHXqbPRK9KrwrBhFdPw_1740440525
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F02DE180036F;
	Mon, 24 Feb 2025 23:42:04 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.9])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DFA91180035E;
	Mon, 24 Feb 2025 23:42:01 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 01/15] rxrpc: rxperf: Fix missing decoding of terminal magic cookie
Date: Mon, 24 Feb 2025 23:41:38 +0000
Message-ID: <20250224234154.2014840-2-dhowells@redhat.com>
In-Reply-To: <20250224234154.2014840-1-dhowells@redhat.com>
References: <20250224234154.2014840-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The rxperf RPCs seem to have a magic cookie at the end of the request that
was failing to be taken account of by the unmarshalling of the request.
Fix the rxperf code to expect this.

Fixes: 75bfdbf2fca3 ("rxrpc: Implement an in-kernel rxperf server for testing purposes")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/rxperf.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/rxrpc/rxperf.c b/net/rxrpc/rxperf.c
index 7ef93407be83..e848a4777b8c 100644
--- a/net/rxrpc/rxperf.c
+++ b/net/rxrpc/rxperf.c
@@ -478,6 +478,18 @@ static int rxperf_deliver_request(struct rxperf_call *call)
 		call->unmarshal++;
 		fallthrough;
 	case 2:
+		ret = rxperf_extract_data(call, true);
+		if (ret < 0)
+			return ret;
+
+		/* Deal with the terminal magic cookie. */
+		call->iov_len = 4;
+		call->kvec[0].iov_len	= call->iov_len;
+		call->kvec[0].iov_base	= call->tmp;
+		iov_iter_kvec(&call->iter, READ, call->kvec, 1, call->iov_len);
+		call->unmarshal++;
+		fallthrough;
+	case 3:
 		ret = rxperf_extract_data(call, false);
 		if (ret < 0)
 			return ret;


