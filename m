Return-Path: <netdev+bounces-249903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C79D20832
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 18:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2D9383009D5B
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 17:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0051F2FFDC4;
	Wed, 14 Jan 2026 17:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JPu5MUvY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505F82F39D7
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 17:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768411307; cv=none; b=MsBZIsHC1tdvK4MhY0KukcdhMZCYho3WWIgSXDeeD5GcQ+3WIB3b289jY5YkXCE+SifRE3PbRwRiECQDDw5H5/pUokW+6kAOdw+WmDOYOdvSwRwZSCSJZmPhSjQfAhshqPbRJR+KlkB2X7mtfbeAxrF3kaBNvsp9tzaW7b8j3M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768411307; c=relaxed/simple;
	bh=B/3oUYzm3WrUbuK88eN3N+QsmsoERC19BOF3e1wvhMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nQ1HUHPC+gMy9+E8/HBlSh4AKeiep/IX4cGn0cDBEfJtRGiR8dxd7S1WYMRtrVEVVcwh8eV871ZtDIhwjxzAOyd1vzrWkzlFjlf+iVCtY9QOJBkFe7Pre2Ktve2YwHZjsja9NmfKGCTn+mmUKj3FseDyrQ9lh80Bzu6ZWg5C040=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JPu5MUvY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768411300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a+PUKC5Eo434Sp4euB0T5SQCzrI87wOZWHOHhZ2GZPo=;
	b=JPu5MUvYrZUok/EwpvBcmgaKp5JXEswIGbFDUZuaD99Zz6JF2xdJFAjM/BGM/YKpVfCIdS
	zh7r0uOryJSH9DrKlb+qE483aHpVqe88wVpPkXQ8lJn1VLdys58/mn6hdodgh4ixZTW+52
	Lg/7kV0/omP/Te3Y2luDfnZqFGvG51o=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-244-Jq9xgVGLN1aGVdb_CjJT6w-1; Wed,
 14 Jan 2026 12:21:35 -0500
X-MC-Unique: Jq9xgVGLN1aGVdb_CjJT6w-1
X-Mimecast-MFC-AGG-ID: Jq9xgVGLN1aGVdb_CjJT6w_1768411294
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0261918005B3;
	Wed, 14 Jan 2026 17:21:34 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.130])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3867D19560B4;
	Wed, 14 Jan 2026 17:21:29 +0000 (UTC)
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
Subject: [PATCH v3 net-next 06/10] geneve: pass the geneve device ptr to geneve_build_skb()
Date: Wed, 14 Jan 2026 18:20:39 +0100
Message-ID: <1f64c5472917bc500d6eefb45a79add123a58c8e.1768410519.git.pabeni@redhat.com>
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


