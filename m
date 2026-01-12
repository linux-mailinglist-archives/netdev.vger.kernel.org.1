Return-Path: <netdev+bounces-249171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F8ED15540
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 21:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D8B130802A6
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 20:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B4A33F8CE;
	Mon, 12 Jan 2026 20:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aJyMj/U1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD9F3382E8
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 20:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768251073; cv=none; b=psyA4291h0TnWMvhqD99pFlkcu2r0fAOkaH00KtMJauhijOkl19N6URm41OMBfSafucz4J67s55yk2kbBAE2Dc20/4wTNwchvbPKclIW5ay3mGIm9FXFON2G3JeL2E8RLW+IdTLXO0B9OlvB6avLGSHg80L2zpRyWLlQZi5qR1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768251073; c=relaxed/simple;
	bh=32gyJBTof7beOS7A0kGCqGT+eOw5nhUEBLKXw1rh+l4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E7UrCslHCIFJeOqMuArm5eT7wTVpv0YJvyvEs/XOyhSi+Ea46Vml5bvhLc52nm6Im53eGZX2cMWZXMak0XXJdRWi95QhjXgH7m06XpsljwF6bN5S7pYCXpyfNbFWwFV/HTjTrj2L52UEOpcxC6JBcHvHWZpkz2/sqsBWYmnmaho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aJyMj/U1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768251071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lzQPChliMgYZWy9bavBhufvwhif7bSLIs3dECz5HYaM=;
	b=aJyMj/U1+Ky0CX9SLkSp27ZVRs82HW56UFPKvDJnZ8hCVysJSDfFYIs0Z5dqJNWHj0diJi
	PRKBQ1TUVN1aT6YYVt8gWRZ1KQq/LpI0387+sY/D0+pppwR0eq/Kmmt5LGhNgMFz1wOwhL
	ftzuADzrjHx07AHlzJGHdEeM/S8E6aM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-550-DJgcNJseOmSmIroFsrtSMQ-1; Mon,
 12 Jan 2026 15:51:08 -0500
X-MC-Unique: DJgcNJseOmSmIroFsrtSMQ-1
X-Mimecast-MFC-AGG-ID: DJgcNJseOmSmIroFsrtSMQ_1768251064
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 677611800342;
	Mon, 12 Jan 2026 20:51:04 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.212])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 849701800577;
	Mon, 12 Jan 2026 20:51:01 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: [PATCH v2 net-next 05/10] geneve: constify geneve_hlen()
Date: Mon, 12 Jan 2026 21:50:21 +0100
Message-ID: <9510d323b0801f3a6297471fb49b3084006a1825.1768250796.git.pabeni@redhat.com>
In-Reply-To: <cover.1768250796.git.pabeni@redhat.com>
References: <cover.1768250796.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Such helper does not modify the argument; constifying it will additionally
simplify later patches.

Additionally move the definition earlier, still for later's patchesi sake.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 drivers/net/geneve.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 8719ad66837e..e99fa8c37486 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -365,6 +365,11 @@ static void geneve_uninit(struct net_device *dev)
 	gro_cells_destroy(&geneve->gro_cells);
 }
 
+static int geneve_hlen(const struct genevehdr *gh)
+{
+	return sizeof(*gh) + gh->opt_len * 4;
+}
+
 /* Callback from net/ipv4/udp.c to receive packets */
 static int geneve_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 {
@@ -497,11 +502,6 @@ static struct socket *geneve_create_sock(struct net *net, bool ipv6,
 	return sock;
 }
 
-static int geneve_hlen(struct genevehdr *gh)
-{
-	return sizeof(*gh) + gh->opt_len * 4;
-}
-
 static struct sk_buff *geneve_gro_receive(struct sock *sk,
 					  struct list_head *head,
 					  struct sk_buff *skb)
-- 
2.52.0


