Return-Path: <netdev+bounces-249902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 859F7D20841
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 18:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA1DE301EFEA
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 17:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB22E2FF679;
	Wed, 14 Jan 2026 17:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="egjGSIgG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC7D2F3621
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 17:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768411303; cv=none; b=IvzY6x/V1QfQPuE/Qf4NDeAZ9KeLb7v7f0Hx27nbUhS5X4z7a1Pd/MZ3MkBE1Z3Shw8cWsafsqqqZowd75pH8UfagcBG8Jytbv4fROOCES7xr30YuRU2ivT4o+po0FSQBR8lqrDXuETUzPqf5gxsOfiaMBRkgpCIkRtFK3KgmfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768411303; c=relaxed/simple;
	bh=32gyJBTof7beOS7A0kGCqGT+eOw5nhUEBLKXw1rh+l4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YDm6xj40B6Uw+rcUSCAiH3HeNazw8WztsNEGzHg1tme4CgvXb9EKKGKZdKtkt6Ba2/qweTW+WfC4/k6nVQK4z/g1q3SAuMY7epbLNVZVN2RtcaJHJ7fWqepvSGSBvElhGLXg3dlwyuUBCeiKq0AV8wu8KNPpEOlgm5yrZnB0aMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=egjGSIgG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768411297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lzQPChliMgYZWy9bavBhufvwhif7bSLIs3dECz5HYaM=;
	b=egjGSIgGdtgASDATNLPuEFTKSnR7F+mxFxzp9lHIa11re5isGsWTUsvUpDgKvoIB2G8jOe
	h4Baox9/VVmnF7Jlrx53M2htFGGjJCxRC7qNTax5p5dKNKxqFPjr4LcEu1HBlwYjRw3nQr
	87FuyKYnMvB8Trb6v1k+tfDe035zD14=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-SmfOycksM7C5K_YHwxWdXQ-1; Wed,
 14 Jan 2026 12:21:32 -0500
X-MC-Unique: SmfOycksM7C5K_YHwxWdXQ-1
X-Mimecast-MFC-AGG-ID: SmfOycksM7C5K_YHwxWdXQ_1768411290
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B3D791800342;
	Wed, 14 Jan 2026 17:21:29 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.130])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D0DB919560A7;
	Wed, 14 Jan 2026 17:21:25 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	sdf@fomichev.me,
	petrm@nvidia.com,
	razor@blackwall.org,
	idosch@nvidia.com
Subject: [PATCH v3 net-next 05/10] geneve: constify geneve_hlen()
Date: Wed, 14 Jan 2026 18:20:38 +0100
Message-ID: <339dc6fa6d3fa7c1cd238b1709dd013f0f0c6ebb.1768410519.git.pabeni@redhat.com>
In-Reply-To: <cover.1768410519.git.pabeni@redhat.com>
References: <cover.1768410519.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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


