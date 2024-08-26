Return-Path: <netdev+bounces-122031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB9195F9F3
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 21:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDC781F23C18
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 19:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DB2198E99;
	Mon, 26 Aug 2024 19:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iAtE07PS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295FD12BEBE
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 19:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724701784; cv=none; b=XZh5inSNcjaDwjgPrh1eL4tAvma/tSvdkLanm6+VI91wWsdScjh2lPcOLDXQVpaomjFbYVV2Aa8KMjSf8PB4rEeml72dUGq+mB7Cb7jEhs6xTZoqy7PkD7YcGpqaqfrt+df8nEwNnea5G/Fd1oNtHaTPmxh6pgWogyT8wuuuKBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724701784; c=relaxed/simple;
	bh=/BeTlJPg8NBT/vR3yA1NdbnAkLURXu0qZiv1ywkYIsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gVX7UwqsN2BfuQe4T77tn0pihgoFUpK45fmyGcUEz2vkSL1UvCQ9xEG4ip5EKG/m8synM3ErQ+XMSX+PgsDdTIyA0BGJCk6ITlxcJcik8YDXeG3UfZUKKV0Aa6rPXpAJVO1Lji4Th6N688R0AqCTFNjf/p/FRTKNMtSgOfZxq4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iAtE07PS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724701782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Idv2v9Jm8gc4PffZ6VpAxuYQtppWCkzIJzIQJAInlCY=;
	b=iAtE07PS3NAt7xr9hpSpURy7UOgVc7MEewGYspw5oc1EiLQAXQ2qq8NbOF5IHl+80I2UK8
	oRWsyDaZXD+Oi0lWWrX/JWIlejQJ9AtWgRDXtcOxQlBe3I7FELe4jG6+f+iv/x12nKFur7
	13cl8Fo+UXu04mIpsF94BFHQeqNU1lY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-WYv3nM5VNPGXGZ87v_HvIw-1; Mon,
 26 Aug 2024 15:49:41 -0400
X-MC-Unique: WYv3nM5VNPGXGZ87v_HvIw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9900C1955F08;
	Mon, 26 Aug 2024 19:49:39 +0000 (UTC)
Received: from jmaloy-thinkpadp16vgen1.rmtcaqc.csb (unknown [10.22.8.17])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0458D19560AA;
	Mon, 26 Aug 2024 19:49:36 +0000 (UTC)
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
Subject: [net-next, v2 1/2] tcp: add SO_PEEK_OFF socket option tor TCPv6
Date: Mon, 26 Aug 2024 15:49:31 -0400
Message-ID: <20240826194932.420992-2-jmaloy@redhat.com>
In-Reply-To: <20240826194932.420992-1-jmaloy@redhat.com>
References: <20240826194932.420992-1-jmaloy@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: Jon Maloy <jmaloy@redhat.com>

When we added the SO_PEEK_OFF socket option to TCP we forgot
to add it even for TCP on IPv6.

We do that here.

Fixes: 05ea491641d3 ("tcp: add support for SO_PEEK_OFF socket option")
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Tested-by: Stefano Brivio <sbrivio@redhat.com>
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


