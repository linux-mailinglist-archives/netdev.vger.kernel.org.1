Return-Path: <netdev+bounces-251156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C66AD3AE81
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 16:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C8F230194CC
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 15:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF74366DDC;
	Mon, 19 Jan 2026 15:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wp8/Cp50"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E65387376
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 15:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768835419; cv=none; b=pxa11+lgYp1/7UAVwaHAUIbJDiBZSMuSkIkoY3O1tUgUsc962Mo8O/48ewtgX9xlHgpF5gRN6xS5uBQWSU9Mqh+FxRmKrcS+DQ6Kwh9jZZN5bz4qJ5EyMOT58d7IVcJZ6hrw3XGejc/5c3lGYEfWHylilOvISS2+Ixa1SNzKibA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768835419; c=relaxed/simple;
	bh=32gyJBTof7beOS7A0kGCqGT+eOw5nhUEBLKXw1rh+l4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FN2RytVar8tLNoZYGXuURuxksURvgm/28zwphZt1ZY6hWHVZ5t0Y/X1efnZgFiP1wcipnf+0KFW0QWjGKTqSMYTika62d1qx/PnBsocpBEnqlG3PfdhPRyUoktbgWLGtnMwAP/MeypDqqk9uBkcERYs2g3XDrF6kWpw0ZlNnFTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wp8/Cp50; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768835417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lzQPChliMgYZWy9bavBhufvwhif7bSLIs3dECz5HYaM=;
	b=Wp8/Cp502u5Ys+5sq1i1XmhUKaHIjqft07J3PH06XTTvJqXnVxp/eBCzQkT27Td6f2LUan
	G8DFcDKp9VHiQV6DHP0PUeTh/Wv01B/ztSwSZ+DuLsGv7nJhq/N+6AzzkqPscDzU4WI6GM
	jPxn04fUDGczryPlTwBq2KLEikvKBns=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-247-9B7l97lfM0W3tzX3156Scw-1; Mon,
 19 Jan 2026 10:10:12 -0500
X-MC-Unique: 9B7l97lfM0W3tzX3156Scw-1
X-Mimecast-MFC-AGG-ID: 9B7l97lfM0W3tzX3156Scw_1768835411
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0BF991954B06;
	Mon, 19 Jan 2026 15:10:11 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.246])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3A92F19560A2;
	Mon, 19 Jan 2026 15:10:06 +0000 (UTC)
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
Subject: [PATCH v4 net-next 05/10] geneve: constify geneve_hlen()
Date: Mon, 19 Jan 2026 16:09:27 +0100
Message-ID: <bbbb7da798eb2cb6251331b31d5d65f70b119d80.1768820066.git.pabeni@redhat.com>
In-Reply-To: <cover.1768820066.git.pabeni@redhat.com>
References: <cover.1768820066.git.pabeni@redhat.com>
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


