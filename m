Return-Path: <netdev+bounces-122898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A09B496302A
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 20:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5633C1F201A0
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 18:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824971AAE1B;
	Wed, 28 Aug 2024 18:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eiJasGVd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845F61AAE2C
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 18:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724870290; cv=none; b=dVzn/M9d7O0kwSjqVOYDZTCPTzwFWkeYAjT8OU2yhcGsUmUG0LpwIBxSxjYSRvtuYO4hC87Lmro83QbnmEimXnT459lIB/kCSQBixCQDlhME9FBVoiSanGfwlGP8y0YE/FrNVu2EmRjQDWeGmcUKXzojSPxvtaXcoaSHjlamhK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724870290; c=relaxed/simple;
	bh=quT+lvmQH1vi/83zz0+8pblgIjoFkaWFfmYdo0BWPL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BkP67RyV3CvFabJtxnLeWh4U6midGRUUKKeoTzRmDPn6wO3JQmnAc0nfrMJAP/cw8qGdxD72sE17ORmzL4tgEJWxN+GvyBGjRgOs53MeQtk9ainsPUvGUVNJttc9PSob2BDYqDDEID3TEviUtm7fEJ/Ow+fU+I7GUat3htwGOcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eiJasGVd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724870287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aLR9kgOQE8wPE7M6lTtSaYXN5bMmdcGyuBU+O0qV3FU=;
	b=eiJasGVdKTL5TrHEIAy9/2BiXvsnHURCV9tvotJ9xwjd3l/jwMIrXPdoa1KJvY0IO3FzRB
	LIpVs9ly9fIokGXuY59PN1d8HTqCFzEm2/xjRvZ0oVtTu7YwcPPX6D+LiiPOWAx2L9VYj6
	2NRdFZDekzF6c8S162XpRymWJhngduQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-354-kdXVPS9SNP6Ebv-6-n2Atw-1; Wed,
 28 Aug 2024 14:38:02 -0400
X-MC-Unique: kdXVPS9SNP6Ebv-6-n2Atw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BEB9B1956048;
	Wed, 28 Aug 2024 18:38:00 +0000 (UTC)
Received: from jmaloy-thinkpadp16vgen1.rmtcaqc.csb (unknown [10.22.8.17])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BD99919560A3;
	Wed, 28 Aug 2024 18:37:57 +0000 (UTC)
From: jmaloy@redhat.com
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	davem@davemloft.net
Cc: kuba@kernel.org,
	passt-dev@passt.top,
	jmaloy@redhat.com,
	sbrivio@redhat.com,
	lvivier@redhat.com,
	dgibson@redhat.com,
	eric.dumazet@gmail.com,
	edumazet@google.com
Subject: [net-next, v3 1/2] tcp: add SO_PEEK_OFF socket option tor TCPv6
Date: Wed, 28 Aug 2024 14:37:51 -0400
Message-ID: <20240828183752.660267-2-jmaloy@redhat.com>
In-Reply-To: <20240828183752.660267-1-jmaloy@redhat.com>
References: <20240828183752.660267-1-jmaloy@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

From: Jon Maloy <jmaloy@redhat.com>

When doing further testing of the recently added SO_PEEK_OFF feature
for TCP I realized I had omitted to add it for TCP/IPv6.

I do that here.

Fixes: 05ea491641d3 ("tcp: add support for SO_PEEK_OFF socket option")
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Tested-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: Jon Maloy <jmaloy@redhat.com>

---
v2: Removed redundant whitespace between "Fixes" and
    "Signed-off-by" lines. Based on feedback from J. Kicinski.
v3: Rephrased commit log to make it clear how the TCP/IPv6 omission
    was discovered. Based on feedback from J. Kicinski.
---
 net/ipv6/af_inet6.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 90d2c7e3f5e9..ba69b86f1c7d 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -708,6 +708,7 @@ const struct proto_ops inet6_stream_ops = {
 	.splice_eof	   = inet_splice_eof,
 	.sendmsg_locked    = tcp_sendmsg_locked,
 	.splice_read	   = tcp_splice_read,
+	.set_peek_off      = sk_set_peek_off,
 	.read_sock	   = tcp_read_sock,
 	.read_skb	   = tcp_read_skb,
 	.peek_len	   = tcp_peek_len,
-- 
2.45.2


