Return-Path: <netdev+bounces-112295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04662938192
	for <lists+netdev@lfdr.de>; Sat, 20 Jul 2024 16:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C160281916
	for <lists+netdev@lfdr.de>; Sat, 20 Jul 2024 14:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6B912C489;
	Sat, 20 Jul 2024 14:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dro/exMM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F7412B62
	for <netdev@vger.kernel.org>; Sat, 20 Jul 2024 14:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721484567; cv=none; b=uHe2JgP0gJptW3fuY9mIs5lxyj7KHv/PpuN+lmygooOtzHMLaXlvmTmnp9KdrTGl/JTyPDxpnp/B7grcKeO82QNNhVVCp4Za6aduvlrxW+EBlSYYIjxix2szqIxYj9BWFLH/sSu9qkptJe6tFnYpLTwI+9+/pPtZ2p5aKXAxnrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721484567; c=relaxed/simple;
	bh=eutLgofeiDc4X/cpPIq+2ED1OnLwYhIDhqA71mdRFN8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tB2KD2vzKJPuWRk4qY33X293bBRJ4CGgiYTRUWybOinCw/PueQqdo3YMC1867D5FBcdeFEP18+dVF70pB0KwDPP3Y80T20usC9PcU9LwD3TNhuiZI0OHaWB5kM7q3VH82IOe4dro9oxfNlTDsqUFBKeRbJM+sLYmlyMv5UznF7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dro/exMM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721484564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=M6QE8UA40LtVG1HZS4ZJtZy6DSMQAzIuEE9/bGs1BZA=;
	b=Dro/exMM0Xq4MhmebGWKvlbfL64spQdhO/+dV4NOm3g+CMPptSl2rS+drtbOOj6qgpBdDR
	hhMreIZcG9RljBmlnFLClrt017HbnbCBee4yoBeq6uZj62oVIhmzOT6o9XL3SP0U6PWP9v
	xROMtIcs5msWmbuW4pSLmJdQAq9cSDc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-600-J7W6qTwtPi2h2f8BOHR9Aw-1; Sat,
 20 Jul 2024 10:09:20 -0400
X-MC-Unique: J7W6qTwtPi2h2f8BOHR9Aw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BEF66195608B;
	Sat, 20 Jul 2024 14:09:18 +0000 (UTC)
Received: from jmaloy-thinkpadp16vgen1.rmtcaqc.csb (unknown [10.22.32.27])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C7C113000188;
	Sat, 20 Jul 2024 14:09:15 +0000 (UTC)
From: jmaloy@redhat.com
To: netdev@vger.kernel.org,
	davem@davemloft.net
Cc: kuba@kernel.org,
	passt-dev@passt.top,
	jmaloy@redhat.com,
	sbrivio@redhat.com,
	lvivier@redhat.com,
	dgibson@redhat.com,
	eric.dumazet@gmail.com,
	edumazet@google.com
Subject: [net] tcp: add SO_PEEK_OFF socket option tor TCPv6
Date: Sat, 20 Jul 2024 10:09:14 -0400
Message-ID: <20240720140914.2772902-1-jmaloy@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: Jon Maloy <jmaloy@redhat.com>

When we added the SO_PEEK_OFF socket option to TCP we forgot
to add it even for TCP on IPv6.

We do that here.

Fixes: 05ea491641d3 ("tcp: add support for SO_PEEK_OFF socket option")

Signed-off-by: Jon Maloy <jmaloy@redhat.com>
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


