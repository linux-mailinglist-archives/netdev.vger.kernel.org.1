Return-Path: <netdev+bounces-169949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 042E3A469A0
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 19:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A719F3A8C3E
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 18:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C4D235C1D;
	Wed, 26 Feb 2025 18:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="PL3gbInk"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F4A1E492
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 18:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740594036; cv=none; b=hrXGVU+8+SnHivwvEdo2uvr1l6sGVT7rSk+ACWW0ot8G8OcOv32rbKYbPefgYTZX66ABM8X66l+lKanqNgwBcWcwxZ9aIo/I8qdQnVfF32XSW3htynb+DnUU7w3LRiAt6F9JhCxIhPxFgtYVkP6wb9gg6qdkTk8bf/xyeIi65do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740594036; c=relaxed/simple;
	bh=mtA2PyZAmkxQd0FrChBDGVoTiYzJannDAvFi72/A9hI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tfmV9ViVjxb4BodsxxcT2FmV24q6C8tNp72oi06WcQPwJ1EroraMLXphmw74/yMmj6SIqU9xAwD+oGznBqO1sIskRSmjX3/L9tOc7TiiTJMcsaBhXaiG+5phbOULEqfLXxrAhIBQREvTsKdAeScvvy89YN1YTR30QMAff+xNmPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=PL3gbInk; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=eLIIkmmGH/5SKa1/Xu8TB2T9xqR+PAPK2yvdWPkrPO0=; b=PL3gbInkjggJV5qXfT9BjQYC4q
	+YsSXsdEROj5O3DQ+s0mJ47VBu3qeLejF3745y7mVb90cj6ZcyVMHH4v0OFtzvkH7WLRiwhtIZHcR
	uVVZYThW/qUCIa3Y2bsq+9bxlPW0VPlfm4I/XQM44uBgy5VXHIIT2p2oZypG+qxDv00HaniPS1xlp
	Eyx0GHWLrIi7/E+/aIwM0BFLhJxYDKQdrH2Hw+2gLQf4msFeXv45A33WW6ClAuFQ9OyW5lHG/2Ch5
	lI+DWenhPFLnpnEFBCdOo5W+wXOc0jQ7rUbGQTGbnUbssuGZYwuwhlKiVRacsDREwgu6nGEKtfIar
	0+axyLSA==;
Received: from 226.206.1.85.dynamic.cust.swisscom.net ([85.1.206.226] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1tnM1H-000BLH-04;
	Wed, 26 Feb 2025 19:20:31 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: kuba@kernel.org
Cc: pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2 1/2] geneve: Allow users to specify source port range
Date: Wed, 26 Feb 2025 19:20:29 +0100
Message-ID: <20250226182030.89440-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 1.0.7/27561/Wed Feb 26 10:36:26 2025)

Recently, in case of Cilium, we run into users on Azure who require to use
tunneling for east/west traffic due to hitting IPAM API limits for Kubernetes
Pods if they would have gone with publicly routable IPs for Pods. In case
of tunneling, Cilium supports the option of vxlan or geneve. In order to
RSS spread flows among remote CPUs both derive a source port hash via
udp_flow_src_port() which takes the inner packet's skb->hash into account.
For clusters with many nodes, this can then hit a new limitation [0]: Today,
the Azure networking stack supports 1M total flows (500k inbound and 500k
outbound) for a VM. [...] Once this limit is hit, other connections are
dropped. [...] Each flow is distinguished by a 5-tuple (protocol, local IP
address, remote IP address, local port, and remote port) information. [...]

For vxlan and geneve, this can create a massive amount of UDP flows which
then run into the limits if stale flows are not evicted fast enough. One
option to mitigate this for vxlan is to narrow the source port range via
IFLA_VXLAN_PORT_RANGE while still being able to benefit from RSS. However,
geneve currently does not have this option and it spreads traffic across
the full source port range of [1, USHRT_MAX]. To overcome this limitation
also for geneve, add an equivalent IFLA_GENEVE_PORT_RANGE setting for users.

Note that struct geneve_config before/after still remains at 2 cachelines
on x86-64. The low/high members of struct ifla_geneve_port_range (which is
uapi exposed) are of type __be16. While they would be perfectly fine to be
of __u16 type, the consensus was that it would be good to be consistent
with the existing struct ifla_vxlan_port_range from a uapi consumer PoV.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://learn.microsoft.com/en-us/azure/virtual-network/virtual-machine-network-throughput [0]
---
 v1->v2:
   - style fixes wrt breaking at 80 columns (Jakub)
   - ifla_geneve_port_range low/high as __be16 (Jakub)

 drivers/net/geneve.c         | 52 +++++++++++++++++++++++++++++++++---
 include/uapi/linux/if_link.h |  6 +++++
 2 files changed, 54 insertions(+), 4 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index fc62b25e0362..2c65f867fd31 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -57,6 +57,8 @@ struct geneve_config {
 	bool			ttl_inherit;
 	enum ifla_geneve_df	df;
 	bool			inner_proto_inherit;
+	u16			port_min;
+	u16			port_max;
 };
 
 /* Pseudo network device */
@@ -835,7 +837,9 @@ static int geneve_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 
 	use_cache = ip_tunnel_dst_cache_usable(skb, info);
 	tos = geneve_get_dsfield(skb, dev, info, &use_cache);
-	sport = udp_flow_src_port(geneve->net, skb, 1, USHRT_MAX, true);
+	sport = udp_flow_src_port(geneve->net, skb,
+				  geneve->cfg.port_min,
+				  geneve->cfg.port_max, true);
 
 	rt = udp_tunnel_dst_lookup(skb, dev, geneve->net, 0, &saddr,
 				   &info->key,
@@ -945,7 +949,9 @@ static int geneve6_xmit_skb(struct sk_buff *skb, struct net_device *dev,
 
 	use_cache = ip_tunnel_dst_cache_usable(skb, info);
 	prio = geneve_get_dsfield(skb, dev, info, &use_cache);
-	sport = udp_flow_src_port(geneve->net, skb, 1, USHRT_MAX, true);
+	sport = udp_flow_src_port(geneve->net, skb,
+				  geneve->cfg.port_min,
+				  geneve->cfg.port_max, true);
 
 	dst = udp_tunnel6_dst_lookup(skb, dev, geneve->net, gs6->sock, 0,
 				     &saddr, key, sport,
@@ -1084,7 +1090,8 @@ static int geneve_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb)
 		use_cache = ip_tunnel_dst_cache_usable(skb, info);
 		tos = geneve_get_dsfield(skb, dev, info, &use_cache);
 		sport = udp_flow_src_port(geneve->net, skb,
-					  1, USHRT_MAX, true);
+					  geneve->cfg.port_min,
+					  geneve->cfg.port_max, true);
 
 		rt = udp_tunnel_dst_lookup(skb, dev, geneve->net, 0, &saddr,
 					   &info->key,
@@ -1110,7 +1117,8 @@ static int geneve_fill_metadata_dst(struct net_device *dev, struct sk_buff *skb)
 		use_cache = ip_tunnel_dst_cache_usable(skb, info);
 		prio = geneve_get_dsfield(skb, dev, info, &use_cache);
 		sport = udp_flow_src_port(geneve->net, skb,
-					  1, USHRT_MAX, true);
+					  geneve->cfg.port_min,
+					  geneve->cfg.port_max, true);
 
 		dst = udp_tunnel6_dst_lookup(skb, dev, geneve->net, gs6->sock, 0,
 					     &saddr, &info->key, sport,
@@ -1234,6 +1242,7 @@ static const struct nla_policy geneve_policy[IFLA_GENEVE_MAX + 1] = {
 	[IFLA_GENEVE_TTL_INHERIT]	= { .type = NLA_U8 },
 	[IFLA_GENEVE_DF]		= { .type = NLA_U8 },
 	[IFLA_GENEVE_INNER_PROTO_INHERIT]	= { .type = NLA_FLAG },
+	[IFLA_GENEVE_PORT_RANGE]	= NLA_POLICY_EXACT_LEN(sizeof(struct ifla_geneve_port_range)),
 };
 
 static int geneve_validate(struct nlattr *tb[], struct nlattr *data[],
@@ -1279,6 +1288,17 @@ static int geneve_validate(struct nlattr *tb[], struct nlattr *data[],
 		}
 	}
 
+	if (data[IFLA_GENEVE_PORT_RANGE]) {
+		const struct ifla_geneve_port_range *p;
+
+		p = nla_data(data[IFLA_GENEVE_PORT_RANGE]);
+		if (ntohs(p->high) < ntohs(p->low)) {
+			NL_SET_ERR_MSG_ATTR(extack, data[IFLA_GENEVE_PORT_RANGE],
+					    "Invalid source port range");
+			return -EINVAL;
+		}
+	}
+
 	return 0;
 }
 
@@ -1506,6 +1526,18 @@ static int geneve_nl2info(struct nlattr *tb[], struct nlattr *data[],
 		info->key.tp_dst = nla_get_be16(data[IFLA_GENEVE_PORT]);
 	}
 
+	if (data[IFLA_GENEVE_PORT_RANGE]) {
+		const struct ifla_geneve_port_range *p;
+
+		if (changelink) {
+			attrtype = IFLA_GENEVE_PORT_RANGE;
+			goto change_notsup;
+		}
+		p = nla_data(data[IFLA_GENEVE_PORT_RANGE]);
+		cfg->port_min = ntohs(p->low);
+		cfg->port_max = ntohs(p->high);
+	}
+
 	if (data[IFLA_GENEVE_COLLECT_METADATA]) {
 		if (changelink) {
 			attrtype = IFLA_GENEVE_COLLECT_METADATA;
@@ -1626,6 +1658,8 @@ static int geneve_newlink(struct net_device *dev,
 		.use_udp6_rx_checksums = false,
 		.ttl_inherit = false,
 		.collect_md = false,
+		.port_min = 1,
+		.port_max = USHRT_MAX,
 	};
 	int err;
 
@@ -1744,6 +1778,7 @@ static size_t geneve_get_size(const struct net_device *dev)
 		nla_total_size(sizeof(__u8)) + /* IFLA_GENEVE_UDP_ZERO_CSUM6_RX */
 		nla_total_size(sizeof(__u8)) + /* IFLA_GENEVE_TTL_INHERIT */
 		nla_total_size(0) +	 /* IFLA_GENEVE_INNER_PROTO_INHERIT */
+		nla_total_size(sizeof(struct ifla_geneve_port_range)) + /* IFLA_GENEVE_PORT_RANGE */
 		0;
 }
 
@@ -1753,6 +1788,10 @@ static int geneve_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	struct ip_tunnel_info *info = &geneve->cfg.info;
 	bool ttl_inherit = geneve->cfg.ttl_inherit;
 	bool metadata = geneve->cfg.collect_md;
+	struct ifla_geneve_port_range ports = {
+		.low	= htons(geneve->cfg.port_min),
+		.high	= htons(geneve->cfg.port_max),
+	};
 	__u8 tmp_vni[3];
 	__u32 vni;
 
@@ -1809,6 +1848,9 @@ static int geneve_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	    nla_put_flag(skb, IFLA_GENEVE_INNER_PROTO_INHERIT))
 		goto nla_put_failure;
 
+	if (nla_put(skb, IFLA_GENEVE_PORT_RANGE, sizeof(ports), &ports))
+		goto nla_put_failure;
+
 	return 0;
 
 nla_put_failure:
@@ -1841,6 +1883,8 @@ struct net_device *geneve_dev_create_fb(struct net *net, const char *name,
 		.use_udp6_rx_checksums = true,
 		.ttl_inherit = false,
 		.collect_md = true,
+		.port_min = 1,
+		.port_max = USHRT_MAX,
 	};
 
 	memset(tb, 0, sizeof(tb));
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index bfe880fbbb24..3b586fb0bc4c 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -1438,6 +1438,7 @@ enum {
 	IFLA_GENEVE_TTL_INHERIT,
 	IFLA_GENEVE_DF,
 	IFLA_GENEVE_INNER_PROTO_INHERIT,
+	IFLA_GENEVE_PORT_RANGE,
 	__IFLA_GENEVE_MAX
 };
 #define IFLA_GENEVE_MAX	(__IFLA_GENEVE_MAX - 1)
@@ -1450,6 +1451,11 @@ enum ifla_geneve_df {
 	GENEVE_DF_MAX = __GENEVE_DF_END - 1,
 };
 
+struct ifla_geneve_port_range {
+	__be16 low;
+	__be16 high;
+};
+
 /* Bareudp section  */
 enum {
 	IFLA_BAREUDP_UNSPEC,
-- 
2.43.0


