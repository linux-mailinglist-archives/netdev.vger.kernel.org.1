Return-Path: <netdev+bounces-167479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69180A3A746
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 20:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AB9D188D726
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 19:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7A61B6CE8;
	Tue, 18 Feb 2025 19:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QgN7mJhJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106071E832B
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 19:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739906587; cv=none; b=WZTGft94JUrsZZkh6Va/puwpN4hqJLGYIqAhAkvJDBv6z5fA/1vJ4fvFcim5v5pEX1cPOjGVki6uOZWO4ZFvPf1SEaveOv2b6j31J047vB8kY8+rfsZYGThDj/PgWnsP2w3P3X5TZjoS1p888vVKyr9s4wHq39yTYDPpT6g+Kfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739906587; c=relaxed/simple;
	bh=LdM6YWJorqkUh0RrJpizFWheSHgWKS3j4SIexQeKkT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K2F5nI6v65+av25Wb5ZBYaIn+Lq4KtKmoO/iksnebdXBZDftSNvnx6fCSDxvFK5FpEXoeRIzUEN85zxPpQjBgJaTUMhw/D1/GDr35+1JUGO8xX8ON8WFua1J1pM3PEt/Zb5QNf8mmchmgUfxa1RLGBi0mPeRQTeK8TjgHO4Qv9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QgN7mJhJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739906585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TPX5X0FLbu8i/pSR/GZDg1fvDLeMt1ooWaCQcD/mFIo=;
	b=QgN7mJhJu9zmESwvzc0h04dTfmuvL7EOI7dCIgK/IdGKiMqTjjLRviWt/2ev+c2dIbMkzv
	JF2I0TrccWvWEATLBUKYyF8mMbijm4rRRVdPt4xOneL+rON8dwoV9tS9YhWxd0AjyJtq1+
	cEcEqFPDNOc6NY925iqYoh+03Sf7eIQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-2VyI0uHRP2Cv18UI9ndGCw-1; Tue,
 18 Feb 2025 14:23:01 -0500
X-MC-Unique: 2VyI0uHRP2Cv18UI9ndGCw-1
X-Mimecast-MFC-AGG-ID: 2VyI0uHRP2Cv18UI9ndGCw_1739906580
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 585651800984;
	Tue, 18 Feb 2025 19:23:00 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.9])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A010D1956094;
	Tue, 18 Feb 2025 19:22:57 +0000 (UTC)
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
	Simon Horman <horms@kernel.org>
Subject: [PATCH net 1/5] rxrpc: rxperf: Fix missing decoding of terminal magic cookie
Date: Tue, 18 Feb 2025 19:22:44 +0000
Message-ID: <20250218192250.296870-2-dhowells@redhat.com>
In-Reply-To: <20250218192250.296870-1-dhowells@redhat.com>
References: <20250218192250.296870-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

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


