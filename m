Return-Path: <netdev+bounces-149760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C92009E74E4
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 16:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 944A1168F71
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 15:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC828207E1A;
	Fri,  6 Dec 2024 15:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DQETk7Ls"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCF120CCF7
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 15:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733500204; cv=none; b=EKpvva/rXrtNrX6hEl9SDr7BNjqjzON06xuCWLOvnVZ6hXm39gwzs+g9uCUY3zv0J4kkPQEq8TkP37VsgN1q/dnNrPBBiVx1vuzFY9rBKKqMGDomVxCNY3XPcF02uJViRCJA06WHWLrgO7EvhOia7jb7di2kfQJ4XHRtOPwJvCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733500204; c=relaxed/simple;
	bh=GwCXwWnhRNW2fTtdkR7nNHEH+5Cs1i6ZTq6paFRWngU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PdIJFvVJmAwfm9/u4TGqitchD4LGO4arCV31KZVyUDXjWphaBXuOhI//YxOzQ79cEJrEdlySmi6weTMpFzOaDHdO8skNktz0EZlPL1n53JS0Gxt1yJsRrhBjy46XRSH+jErXtTddh+nbBM7dlUgoZUrcOHtXmqI/I1UUC4XwKzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DQETk7Ls; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733500202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KxsQonFAR5FheqIhajTKTvYSqFE5QTq9jKE44cahges=;
	b=DQETk7LslNhAlJCUITqripmih+F2NVS39PVFfV9OsdkbrfC9JNau/cX0Mz87eTzqK9+Wo1
	pCZjKIokx3ittsU2TNl0E5DU7mXL+nx1Zp7Qq9V5bG9InIy7WCJTsMisZ27jCP4Q89TZlr
	xYJVDLoi8mP8SgA1xN/gyfWLI3MigR4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-119-aWN0cdc0OvmCHTBJcq9YTw-1; Fri,
 06 Dec 2024 10:49:57 -0500
X-MC-Unique: aWN0cdc0OvmCHTBJcq9YTw-1
X-Mimecast-MFC-AGG-ID: aWN0cdc0OvmCHTBJcq9YTw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ECCD91955F3B;
	Fri,  6 Dec 2024 15:49:54 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.243])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8FB951956095;
	Fri,  6 Dec 2024 15:49:50 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Fred Chen <fred.cc@alibaba-inc.com>,
	Cambda Zhu <cambda@linux.alibaba.com>,
	Willem de Bruijn <willemb@google.com>,
	Philo Lu <lulie@linux.alibaba.com>,
	Stefano Brivio <sbrivio@redhat.com>
Subject: [PATCH net] udp: fix l4 hash after reconnect
Date: Fri,  6 Dec 2024 16:49:14 +0100
Message-ID: <4761e466ab9f7542c68cdc95f248987d127044d2.1733499715.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

After the blamed commit below, udp_rehash() is supposed to be called
with both local and remote addresses set.

Currently that is already the case for IPv6 sockets, but for IPv4 the
destination address is updated after rehashing.

Address the issue moving the destination address and port initialization
before rehashing.

Fixes: 1b29a730ef8b ("ipv6/udp: Add 4-tuple hash for connected socket")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/ipv4/datagram.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/datagram.c b/net/ipv4/datagram.c
index cc6d0bd7b0a9..4aca1f05edd3 100644
--- a/net/ipv4/datagram.c
+++ b/net/ipv4/datagram.c
@@ -61,15 +61,17 @@ int __ip4_datagram_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len
 		err = -EACCES;
 		goto out;
 	}
+
+	/* Update addresses before rehashing */
+	inet->inet_daddr = fl4->daddr;
+	inet->inet_dport = usin->sin_port;
 	if (!inet->inet_saddr)
-		inet->inet_saddr = fl4->saddr;	/* Update source address */
+		inet->inet_saddr = fl4->saddr;
 	if (!inet->inet_rcv_saddr) {
 		inet->inet_rcv_saddr = fl4->saddr;
 		if (sk->sk_prot->rehash)
 			sk->sk_prot->rehash(sk);
 	}
-	inet->inet_daddr = fl4->daddr;
-	inet->inet_dport = usin->sin_port;
 	reuseport_has_conns_set(sk);
 	sk->sk_state = TCP_ESTABLISHED;
 	sk_set_txhash(sk);
-- 
2.45.2


