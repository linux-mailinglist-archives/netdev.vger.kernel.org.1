Return-Path: <netdev+bounces-241565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BD9C85E4B
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 17:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 25E453526B7
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 16:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1165F2566DD;
	Tue, 25 Nov 2025 16:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V4XMByHN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E4E236437
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 16:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764087115; cv=none; b=p7pIxe491P786Q5P0GN41YrofGhxOsTO/YOucRBFrKiB5o1U6dTZ3XapnYseJ5o5DZ1GpYOUOZATYM7cI3Ez1f7zSzZIFKWKU/ZWwKBKcNnHgsVP3t1Ia9bgd6+MqRDksuZxoLZ2RopdMcTD3KfpwZ2ybDbF4kaspeGSQGIO+Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764087115; c=relaxed/simple;
	bh=Lij6iR5JSrHT8CP8WPIxsXDWL7eBePXcCOCAhXB7nv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dtE9p4uhRQn8PGZXR59kNObWzKl9GvK75q/h3vcl7wGltsrWpOKSvEvZgNz4n3YqgHlXoqiqbLCQyzYfjVN/9QEVE0PaQDMfNuURTV0O+DTjqQ7CYylLom3+kqsmTtbpij9uHkvaWimQxW1pL3SOoT9VYSBfuvR/M9kiGAAQQuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V4XMByHN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764087112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9IvMqWNcYlJ3BWsMw4jpl2KYI2od1QYZTrogFraycz0=;
	b=V4XMByHN8xP+L20D33Sl+k35kOJxienBqHThT+VW/yVfRnS/JaWu1Jbh4bWZguqbNVblVh
	pA0IXAKX63B7RKcNxVAHdueHNA3b3yUlfEH1iFhktoU3wqWnCC88DhbU13+ELKuE2qXm7n
	h4nKuHQYkZ3SpFS/z1OrEHrrq24bzqc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-578-g-_MxpTAOx6DpNQH01lOIg-1; Tue,
 25 Nov 2025 11:11:49 -0500
X-MC-Unique: g-_MxpTAOx6DpNQH01lOIg-1
X-Mimecast-MFC-AGG-ID: g-_MxpTAOx6DpNQH01lOIg_1764087108
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 173531800372;
	Tue, 25 Nov 2025 16:11:48 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.183])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 499681800298;
	Tue, 25 Nov 2025 16:11:45 +0000 (UTC)
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
Subject: [PATCH net-next 06/10] geneve: pass the geneve device ptr to geneve_build_skb()
Date: Tue, 25 Nov 2025 17:11:11 +0100
Message-ID: <197b8b2681e28e42d79d2f9763a08d5447fd40c9.1764056123.git.pabeni@redhat.com>
In-Reply-To: <cover.1764056123.git.pabeni@redhat.com>
References: <cover.1764056123.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Instead of handing to it the geneve configuration in multiple arguments.
This already avoids some code duplication and we are going to pass soon
more arguments to such function.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 drivers/net/geneve.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index fc8c41221eb6..3287a24ccfc1 100644
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


