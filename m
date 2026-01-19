Return-Path: <netdev+bounces-251155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84827D3AEA1
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 16:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E83F43095678
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 15:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F9B38736B;
	Mon, 19 Jan 2026 15:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ePHI/7q2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440E9387569
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 15:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768835414; cv=none; b=YUTpqb2BrAG3KG+PAkwhwh6231L6wBRPT5czg9gY0x+ywYYk7sdQcIopjpOCR6h31lJaK/lhx9SMGt4AVh4iV85uGVABqiWbNfjx0qr7LozUucyrn+0+LtfGINHJIQ7DG2m/pzs5clXwNcooCQRQKzMfMddmK88ZdHm454Wy/ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768835414; c=relaxed/simple;
	bh=6M3g81YZSfLYzX5ZTZqxxy74rnPlNJmmTzRr6My2emQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gT06BDiXHaSIOcjmru7KJNUpITZ4d/M4p4LyC050t3J0B0FqjbvRCI0cQKvQ/V3qdbvFY+w2FXrctTY5/6v8lMlYliTPaBU6SGTF0P5u5x8d2Rx4uzv2e0wlB1PvoBb2CjhCPdDPONo/2iXBjhAsq0x2waHj87O+fvQweWEAxHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ePHI/7q2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768835412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tSPU8K2vTOlyXbF9JdKeyVsBUzEeyiygD9NQ70hDYdA=;
	b=ePHI/7q2zg4g3FFNwtF/YccFlSh+nCeNIu/NB287+V5FsKdaef4CxeLzpmJxSAVnpRjYVY
	wcoUv1OZF0KlILS9cHj70FmLoRUv+yI8zf8IydIgzXP7xrnJNaZOVAncZRp03ek0+H6Gl1
	6ZQY4aKYxRQJKwyK3sj0kiMYK9h96B4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-462-aeNJN1WiNii9jvH-HVahAw-1; Mon,
 19 Jan 2026 10:10:08 -0500
X-MC-Unique: aeNJN1WiNii9jvH-HVahAw-1
X-Mimecast-MFC-AGG-ID: aeNJN1WiNii9jvH-HVahAw_1768835407
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BC06119560B1;
	Mon, 19 Jan 2026 15:10:06 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.246])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ABC8019560A7;
	Mon, 19 Jan 2026 15:10:02 +0000 (UTC)
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
Subject: [PATCH v4 net-next 04/10] geneve: add netlink support for GRO hint
Date: Mon, 19 Jan 2026 16:09:26 +0100
Message-ID: <3f3bff8f7fe2c645f644aecd9ddd7197730c426e.1768820066.git.pabeni@redhat.com>
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

Allow configuring and dumping the new device option, and cache its value
into the geneve socket itself.
The new option is not tie to it any code yet.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v1 -> v2:
  - use nla_put_flag() to dump the GRO_HINT nl info
---
 Documentation/netlink/specs/rt-link.yaml |  3 +++
 drivers/net/geneve.c                     | 29 ++++++++++++++++++++----
 include/uapi/linux/if_link.h             |  1 +
 3 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
index 6beeb6ee5adf..df4b56beb818 100644
--- a/Documentation/netlink/specs/rt-link.yaml
+++ b/Documentation/netlink/specs/rt-link.yaml
@@ -1914,6 +1914,9 @@ attribute-sets:
         name: port-range
         type: binary
         struct: ifla-geneve-port-range
+      -
+        name: gro-hint
+        type: flag
   -
     name: linkinfo-hsr-attrs
     name-prefix: ifla-hsr-
diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 64ea4b970376..8719ad66837e 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -56,6 +56,7 @@ struct geneve_config {
 	bool			collect_md;
 	bool			use_udp6_rx_checksums;
 	bool			ttl_inherit;
+	bool			gro_hint;
 	enum ifla_geneve_df	df;
 	bool			inner_proto_inherit;
 	u16			port_min;
@@ -84,6 +85,7 @@ struct geneve_dev {
 
 struct geneve_sock {
 	bool			collect_md;
+	bool			gro_hint;
 	struct list_head	list;
 	struct socket		*sock;
 	struct rcu_head		rcu;
@@ -659,13 +661,15 @@ static void geneve_sock_release(struct geneve_dev *geneve)
 
 static struct geneve_sock *geneve_find_sock(struct geneve_net *gn,
 					    sa_family_t family,
-					    __be16 dst_port)
+					    __be16 dst_port,
+					    bool gro_hint)
 {
 	struct geneve_sock *gs;
 
 	list_for_each_entry(gs, &gn->sock_list, list) {
 		if (inet_sk(gs->sock->sk)->inet_sport == dst_port &&
-		    geneve_get_sk_family(gs) == family) {
+		    geneve_get_sk_family(gs) == family &&
+		    gs->gro_hint == gro_hint) {
 			return gs;
 		}
 	}
@@ -676,12 +680,14 @@ static int geneve_sock_add(struct geneve_dev *geneve, bool ipv6)
 {
 	struct net *net = geneve->net;
 	struct geneve_net *gn = net_generic(net, geneve_net_id);
+	bool gro_hint = geneve->cfg.gro_hint;
 	struct geneve_dev_node *node;
 	struct geneve_sock *gs;
 	__u8 vni[3];
 	__u32 hash;
 
-	gs = geneve_find_sock(gn, ipv6 ? AF_INET6 : AF_INET, geneve->cfg.info.key.tp_dst);
+	gs = geneve_find_sock(gn, ipv6 ? AF_INET6 : AF_INET,
+			      geneve->cfg.info.key.tp_dst, gro_hint);
 	if (gs) {
 		gs->refcnt++;
 		goto out;
@@ -694,6 +700,7 @@ static int geneve_sock_add(struct geneve_dev *geneve, bool ipv6)
 
 out:
 	gs->collect_md = geneve->cfg.collect_md;
+	gs->gro_hint = gro_hint;
 #if IS_ENABLED(CONFIG_IPV6)
 	if (ipv6) {
 		rcu_assign_pointer(geneve->sock6, gs);
@@ -1257,6 +1264,7 @@ static const struct nla_policy geneve_policy[IFLA_GENEVE_MAX + 1] = {
 	[IFLA_GENEVE_DF]		= { .type = NLA_U8 },
 	[IFLA_GENEVE_INNER_PROTO_INHERIT]	= { .type = NLA_FLAG },
 	[IFLA_GENEVE_PORT_RANGE]	= NLA_POLICY_EXACT_LEN(sizeof(struct ifla_geneve_port_range)),
+	[IFLA_GENEVE_GRO_HINT]		= { .type = NLA_FLAG },
 };
 
 static int geneve_validate(struct nlattr *tb[], struct nlattr *data[],
@@ -1607,10 +1615,18 @@ static int geneve_nl2info(struct nlattr *tb[], struct nlattr *data[],
 		cfg->inner_proto_inherit = true;
 	}
 
+	if (data[IFLA_GENEVE_GRO_HINT]) {
+		if (changelink) {
+			attrtype = IFLA_GENEVE_GRO_HINT;
+			goto change_notsup;
+		}
+		cfg->gro_hint = true;
+	}
+
 	return 0;
 change_notsup:
 	NL_SET_ERR_MSG_ATTR(extack, data[attrtype],
-			    "Changing VNI, Port, endpoint IP address family, external, inner_proto_inherit, and UDP checksum attributes are not supported");
+			    "Changing VNI, Port, endpoint IP address family, external, inner_proto_inherit, gro_hint and UDP checksum attributes are not supported");
 	return -EOPNOTSUPP;
 }
 
@@ -1793,6 +1809,7 @@ static size_t geneve_get_size(const struct net_device *dev)
 		nla_total_size(sizeof(__u8)) + /* IFLA_GENEVE_TTL_INHERIT */
 		nla_total_size(0) +	 /* IFLA_GENEVE_INNER_PROTO_INHERIT */
 		nla_total_size(sizeof(struct ifla_geneve_port_range)) + /* IFLA_GENEVE_PORT_RANGE */
+		nla_total_size(0) +	 /* IFLA_GENEVE_GRO_HINT */
 		0;
 }
 
@@ -1865,6 +1882,10 @@ static int geneve_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	if (nla_put(skb, IFLA_GENEVE_PORT_RANGE, sizeof(ports), &ports))
 		goto nla_put_failure;
 
+	if (geneve->cfg.gro_hint &&
+	    nla_put_flag(skb, IFLA_GENEVE_GRO_HINT))
+		goto nla_put_failure;
+
 	return 0;
 
 nla_put_failure:
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 3b491d96e52e..e9b5f79e1ee1 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -1443,6 +1443,7 @@ enum {
 	IFLA_GENEVE_DF,
 	IFLA_GENEVE_INNER_PROTO_INHERIT,
 	IFLA_GENEVE_PORT_RANGE,
+	IFLA_GENEVE_GRO_HINT,
 	__IFLA_GENEVE_MAX
 };
 #define IFLA_GENEVE_MAX	(__IFLA_GENEVE_MAX - 1)
-- 
2.52.0


