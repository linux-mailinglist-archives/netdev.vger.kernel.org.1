Return-Path: <netdev+bounces-251158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5869BD3AEA9
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 16:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0EB030BBDE3
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 15:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB7038944E;
	Mon, 19 Jan 2026 15:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LysO04kv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A743876B7
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 15:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768835426; cv=none; b=WzLKOy9pFVI6wCozgrt4nn1LsvVJF4Y+nyXtMOFai/lMDXyJTNsU2J5+SjJYaFHzRL+816UiNhC1+2QCHNApeV9c6KDdXOPjdLZWy0xR9Rj5q5+/JzHI1MxFe1ChIK9e+dCZBMDxQ8rlkYX2UI0NPr9xZsbQsS3ms9tG5cUMtnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768835426; c=relaxed/simple;
	bh=B/3oUYzm3WrUbuK88eN3N+QsmsoERC19BOF3e1wvhMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QR2sSvR2EWQtx5Zv9aAywk5YmxYRTlXcInacSCYemSfYKxaztPNvcHIx0l6KPVLcri1uHBZcJQQGJkf+RkIAYWYX1PtmCId8q23Q5o5QTwd+V/ThDQZ61ZxFDFRAC/GSxbl9PuM3vpM/P5Kk7WSVNRDQljmq8hs4fXqTuPtkiWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LysO04kv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768835423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a+PUKC5Eo434Sp4euB0T5SQCzrI87wOZWHOHhZ2GZPo=;
	b=LysO04kvNoU87+oGycHe0pn0fU0oMw2XxscA7yUGL2rLwFYhOxeDTrfKmVZ1MvUNvNhzWV
	wOrVFZL6L4yvDr0W4IIqTXbw9A8vGy+kl76P9ZTjpQ80NCyQEvy43By/eP5bT2rLYWp7bL
	B1lQMgcHR/KxNKdDzER+BUCZZ6qtrG8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-362-FQf53_AEPAy0yBYz_OJAtw-1; Mon,
 19 Jan 2026 10:10:18 -0500
X-MC-Unique: FQf53_AEPAy0yBYz_OJAtw-1
X-Mimecast-MFC-AGG-ID: FQf53_AEPAy0yBYz_OJAtw_1768835415
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 53FF01956054;
	Mon, 19 Jan 2026 15:10:15 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.246])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 81B4319560A2;
	Mon, 19 Jan 2026 15:10:11 +0000 (UTC)
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
Subject: [PATCH v4 net-next 06/10] geneve: pass the geneve device ptr to geneve_build_skb()
Date: Mon, 19 Jan 2026 16:09:28 +0100
Message-ID: <a7a88a99d274441114f64a9314ac2e444dbe29f6.1768820066.git.pabeni@redhat.com>
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

Instead of handing to it the geneve configuration in multiple arguments.
This already avoids some code duplication and we are going to pass soon
more arguments to such function.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 drivers/net/geneve.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index e99fa8c37486..780cc6611f00 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -775,10 +775,11 @@ static void geneve_build_header(struct genevehdr *geneveh,
 
 static int geneve_build_skb(struct dst_entry *dst, struct sk_buff *skb,
 			    const struct ip_tunnel_info *info,
-			    bool xnet, int ip_hdr_len,
-			    bool inner_proto_inherit)
+			    const struct geneve_dev *geneve, int ip_hdr_len)
 {
 	bool udp_sum = test_bit(IP_TUNNEL_CSUM_BIT, info->key.tun_flags);
+	bool inner_proto_inherit = geneve->cfg.inner_proto_inherit;
+	bool xnet = !net_eq(geneve->net, dev_net(geneve->dev));
 	struct genevehdr *gnvh;
 	__be16 inner_proto;
 	bool double_encap;
@@ -830,8 +831,6 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 			   struct geneve_dev *geneve,
 			   const struct ip_tunnel_info *info)
 {
-	bool inner_proto_inherit = geneve->cfg.inner_proto_inherit;
-	bool xnet = !net_eq(geneve->net, dev_net(geneve->dev));
 	struct geneve_sock *gs4 = rcu_dereference(geneve->sock4);
 	const struct ip_tunnel_key *key = &info->key;
 	struct rtable *rt;
@@ -842,7 +841,7 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	__be16 sport;
 	int err;
 
-	if (skb_vlan_inet_prepare(skb, inner_proto_inherit))
+	if (skb_vlan_inet_prepare(skb, geneve->cfg.inner_proto_inherit))
 		return -EINVAL;
 
 	if (!gs4)
@@ -925,8 +924,8 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 		}
 	}
 
-	err = geneve_build_skb(&rt->dst, skb, info, xnet, sizeof(struct iphdr),
-			       inner_proto_inherit);
+	err = geneve_build_skb(&rt->dst, skb, info, geneve,
+			       sizeof(struct iphdr));
 	if (unlikely(err))
 		return err;
 
@@ -943,8 +942,6 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 			    struct geneve_dev *geneve,
 			    const struct ip_tunnel_info *info)
 {
-	bool inner_proto_inherit = geneve->cfg.inner_proto_inherit;
-	bool xnet = !net_eq(geneve->net, dev_net(geneve->dev));
 	struct geneve_sock *gs6 = rcu_dereference(geneve->sock6);
 	const struct ip_tunnel_key *key = &info->key;
 	struct dst_entry *dst = NULL;
@@ -954,7 +951,7 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 	__be16 sport;
 	int err;
 
-	if (skb_vlan_inet_prepare(skb, inner_proto_inherit))
+	if (skb_vlan_inet_prepare(skb, geneve->cfg.inner_proto_inherit))
 		return -EINVAL;
 
 	if (!gs6)
@@ -1017,8 +1014,7 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 			ttl = key->ttl;
 		ttl = ttl ? : ip6_dst_hoplimit(dst);
 	}
-	err = geneve_build_skb(dst, skb, info, xnet, sizeof(struct ipv6hdr),
-			       inner_proto_inherit);
+	err = geneve_build_skb(dst, skb, info, geneve, sizeof(struct ipv6hdr));
 	if (unlikely(err))
 		return err;
 
-- 
2.52.0


