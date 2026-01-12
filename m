Return-Path: <netdev+bounces-249173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 689FBD1554C
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 21:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1FCF3030396
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 20:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921EF334C05;
	Mon, 12 Jan 2026 20:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IGfTjNw3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90DD33C192
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 20:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768251084; cv=none; b=m9PY31yYBkc6BcJmjzm4n7s7Ql++4ouKhlVitmSM0Z4rBUPRPSYRLB14idhXbWgvmfJv+B8cwjZGK+wSWTcysB/mosOZohDfIunC+bjeo0K63WpxS79z8e/fmVwKD7tsHU8Ts5dWXK+AzbX/2EXQ+AlwOk197ZWNJib3YzZEMMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768251084; c=relaxed/simple;
	bh=u5S7gT+I2S58njugUKd9mwjGAbDiVS0D8+PUPniensU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EEwognkGU6+1T4PNkmlgEMALPPwq7WBAvKXN3CyXJNSUVLUeGxbIewzYeFK1ZndLcl14FbKBJdTzkywOGMNf2IIBJ5BF0guDLeIEN1a6CA/hCy690J8Rq+2Ikbs+UpbDw4K38G91KSgoZtwjaqo42p9yyJNwuZNETOZpECmDpgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IGfTjNw3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768251077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yBldK4onEn5FAw/dtvW08c30k9D5YQ5PA2mb7elNEcU=;
	b=IGfTjNw3AIoum4WwRR8wD0YQjoBNZZ3yR9IURI7U4VTu2dR/JWpgjIz380GWkBZlGNmst0
	L8KC186V0+RU8+OGaoiR43krK7Mg4p6WQhjo0SYPy0RdpMaen8TcEVdnRvKe7eY7kupjBB
	NmVxkmZAHMYeXw/a/W0XnWCda8pYmQU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-519-b5LpxUpBO9C98MU4iEcFQA-1; Mon,
 12 Jan 2026 15:51:12 -0500
X-MC-Unique: b5LpxUpBO9C98MU4iEcFQA-1
X-Mimecast-MFC-AGG-ID: b5LpxUpBO9C98MU4iEcFQA_1768251071
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D6997195605B;
	Mon, 12 Jan 2026 20:51:10 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.212])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 22A2318001D5;
	Mon, 12 Jan 2026 20:51:07 +0000 (UTC)
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
Subject: [PATCH v2 net-next 07/10] geneve: add GRO hint output path
Date: Mon, 12 Jan 2026 21:50:23 +0100
Message-ID: <b2c52d1457e8de4d039bfe04067a8d0888adc796.1768250796.git.pabeni@redhat.com>
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

If a geneve egress packet contains nested UDP encap headers, add a geneve
option including the information necessary on the RX side to perform GRO
aggregation of the whole packets: the nested network and transport headers,
and the nested protocol type.

Use geneve option class `netdev`, already registered in the Network
Virtualization Overlay (NVO3) IANA registry:

https://www.iana.org/assignments/nvo3/nvo3.xhtml#Linux-NetDev.

To pass the GRO hint information across the different xmit path functions,
store them in the skb control buffer, to avoid adding additional arguments.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 drivers/net/geneve.c | 124 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 120 insertions(+), 4 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 780cc6611f00..12b382da3caa 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -38,6 +38,26 @@ MODULE_PARM_DESC(log_ecn_error, "Log packets received with corrupted ECN");
 #define GENEVE_IPV4_HLEN (ETH_HLEN + sizeof(struct iphdr) + GENEVE_BASE_HLEN)
 #define GENEVE_IPV6_HLEN (ETH_HLEN + sizeof(struct ipv6hdr) + GENEVE_BASE_HLEN)
 
+#define GENEVE_OPT_NETDEV_CLASS		0x100
+#define GENEVE_OPT_GRO_HINT_SIZE	8
+#define GENEVE_OPT_GRO_HINT_TYPE	1
+#define GENEVE_OPT_GRO_HINT_LEN		1
+
+struct geneve_opt_gro_hint {
+	u8	inner_proto_id:2,
+		nested_is_v6:1;
+	u8	nested_nh_offset;
+	u8	nested_tp_offset;
+	u8	nested_hdr_len;
+};
+
+struct geneve_skb_cb {
+	unsigned int	gro_hint_len;
+	struct geneve_opt_gro_hint gro_hint;
+};
+
+#define GENEVE_SKB_CB(__skb)	((struct geneve_skb_cb *)&((__skb)->cb[0]))
+
 /* per-network namespace private data for this module */
 struct geneve_net {
 	struct list_head	geneve_list;
@@ -93,6 +113,21 @@ struct geneve_sock {
 	struct hlist_head	vni_list[VNI_HASH_SIZE];
 };
 
+static const __be16 proto_id_map[] = { htons(ETH_P_TEB),
+				       htons(ETH_P_IPV6),
+				       htons(ETH_P_IP) };
+
+static int proto_to_id(__be16 proto)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(proto_id_map); i++)
+		if (proto_id_map[i] == proto)
+			return i;
+
+	return ARRAY_SIZE(proto_id_map);
+}
+
 static inline __u32 geneve_net_vni_hash(u8 vni[3])
 {
 	__u32 vnid;
@@ -773,6 +808,78 @@ static void geneve_build_header(struct genevehdr *geneveh,
 		ip_tunnel_info_opts_get(geneveh->options, info);
 }
 
+static int geneve_build_gro_hint_opt(const struct geneve_dev *geneve,
+				     struct sk_buff *skb)
+{
+	struct geneve_skb_cb *cb = GENEVE_SKB_CB(skb);
+	struct geneve_opt_gro_hint *hint;
+	unsigned int nhlen;
+	bool nested_is_v6;
+	int id;
+
+	BUILD_BUG_ON(sizeof(skb->cb) < sizeof(struct geneve_skb_cb));
+	cb->gro_hint_len = 0;
+
+	/* Try to add the GRO hint only in case of double encap. */
+	if (!geneve->cfg.gro_hint || !skb->encapsulation)
+		return 0;
+
+	/*
+	 * The nested headers must fit the geneve opt len fields and the
+	 * nested encap must carry a nested transport (UDP) header.
+	 */
+	nhlen = skb_inner_mac_header(skb) - skb->data;
+	if (nhlen > 255 || !skb_transport_header_was_set(skb) ||
+	    skb->inner_protocol_type != ENCAP_TYPE_ETHER ||
+	    (skb_transport_offset(skb) + sizeof(struct udphdr) > nhlen))
+		return 0;
+
+	id = proto_to_id(skb->inner_protocol);
+	if (id < 0)
+		return 0;
+
+	nested_is_v6 = skb->protocol == htons(ETH_P_IPV6);
+	if (nested_is_v6) {
+		int start = skb_network_offset(skb) + sizeof(struct ipv6hdr);
+		u8 proto = ipv6_hdr(skb)->nexthdr;
+		__be16 foff;
+
+		if (ipv6_skip_exthdr(skb, start, &proto, &foff) < 0 ||
+		    proto != IPPROTO_UDP)
+			return 0;
+	} else {
+		if (ip_hdr(skb)->protocol != IPPROTO_UDP)
+			return 0;
+	}
+
+	hint = &cb->gro_hint;
+	memset(hint, 0, sizeof(*hint));
+	hint->inner_proto_id = id;
+	hint->nested_is_v6 = skb->protocol == htons(ETH_P_IPV6);
+	hint->nested_nh_offset = skb_network_offset(skb);
+	hint->nested_tp_offset = skb_transport_offset(skb);
+	hint->nested_hdr_len = nhlen;
+	cb->gro_hint_len = GENEVE_OPT_GRO_HINT_SIZE;
+	return GENEVE_OPT_GRO_HINT_SIZE;
+}
+
+static void geneve_put_gro_hint_opt(struct genevehdr *gnvh, int opt_size,
+				    const struct geneve_opt_gro_hint *hint)
+{
+	struct geneve_opt *gro_opt;
+
+	/* geneve_build_header() did not took in account the GRO hint. */
+	gnvh->opt_len = (opt_size + GENEVE_OPT_GRO_HINT_SIZE) >> 2;
+
+	gro_opt = (void *)(gnvh + 1) + opt_size;
+	memset(gro_opt, 0, sizeof(*gro_opt));
+
+	gro_opt->opt_class = htons(GENEVE_OPT_NETDEV_CLASS);
+	gro_opt->type = GENEVE_OPT_GRO_HINT_TYPE;
+	gro_opt->length = GENEVE_OPT_GRO_HINT_LEN;
+	memcpy(gro_opt + 1, hint, sizeof(*hint));
+}
+
 static int geneve_build_skb(struct dst_entry *dst, struct sk_buff *skb,
 			    const struct ip_tunnel_info *info,
 			    const struct geneve_dev *geneve, int ip_hdr_len)
@@ -780,17 +887,20 @@ static int geneve_build_skb(struct dst_entry *dst, struct sk_buff *skb,
 	bool udp_sum = test_bit(IP_TUNNEL_CSUM_BIT, info->key.tun_flags);
 	bool inner_proto_inherit = geneve->cfg.inner_proto_inherit;
 	bool xnet = !net_eq(geneve->net, dev_net(geneve->dev));
+	struct geneve_skb_cb *cb = GENEVE_SKB_CB(skb);
 	struct genevehdr *gnvh;
 	__be16 inner_proto;
 	bool double_encap;
 	int min_headroom;
+	int opt_size;
 	int err;
 
 	skb_reset_mac_header(skb);
 	skb_scrub_packet(skb, xnet);
 
+	opt_size =  info->options_len + cb->gro_hint_len;
 	min_headroom = LL_RESERVED_SPACE(dst->dev) + dst->header_len +
-		       GENEVE_BASE_HLEN + info->options_len + ip_hdr_len;
+		       GENEVE_BASE_HLEN + opt_size + ip_hdr_len;
 	err = skb_cow_head(skb, min_headroom);
 	if (unlikely(err))
 		goto free_dst;
@@ -800,9 +910,13 @@ static int geneve_build_skb(struct dst_entry *dst, struct sk_buff *skb,
 	if (err)
 		goto free_dst;
 
-	gnvh = __skb_push(skb, sizeof(*gnvh) + info->options_len);
+	gnvh = __skb_push(skb, sizeof(*gnvh) + opt_size);
 	inner_proto = inner_proto_inherit ? skb->protocol : htons(ETH_P_TEB);
 	geneve_build_header(gnvh, info, inner_proto);
+
+	if (cb->gro_hint_len)
+		geneve_put_gro_hint_opt(gnvh, info->options_len, &cb->gro_hint);
+
 	udp_tunnel_set_inner_protocol(skb, double_encap, inner_proto);
 	return 0;
 
@@ -862,7 +976,8 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 		return PTR_ERR(rt);
 
 	err = skb_tunnel_check_pmtu(skb, &rt->dst,
-				    GENEVE_IPV4_HLEN + info->options_len,
+				    GENEVE_IPV4_HLEN + info->options_len +
+				    geneve_build_gro_hint_opt(geneve, skb),
 				    netif_is_any_bridge_port(dev));
 	if (err < 0) {
 		dst_release(&rt->dst);
@@ -972,7 +1087,8 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 		return PTR_ERR(dst);
 
 	err = skb_tunnel_check_pmtu(skb, dst,
-				    GENEVE_IPV6_HLEN + info->options_len,
+				    GENEVE_IPV6_HLEN + info->options_len +
+				    geneve_build_gro_hint_opt(geneve, skb),
 				    netif_is_any_bridge_port(dev));
 	if (err < 0) {
 		dst_release(dst);
-- 
2.52.0


