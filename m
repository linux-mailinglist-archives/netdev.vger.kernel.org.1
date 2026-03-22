Return-Path: <netdev+bounces-270277-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPT5Etoyv2mtygMAu9opvQ
	(envelope-from <netdev+bounces-270277-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 01:07:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F7B2E7B3F
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 01:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B9CB5302B236
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 00:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC2C150997;
	Sun, 22 Mar 2026 00:07:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B865140DFD8;
	Sun, 22 Mar 2026 00:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774138026; cv=none; b=QjeJgXyzlLHXKnOnIhNZAmyBzRymfuPXExwoQuRGhMyBnpJvaRZUdTRSm6OKZTdJ7MaFCRqlfk8DojtWK8mzcluuru/11uOqzVwr7PjJfKQ6tIIIvcT8kdC4YxjAjq5ODRy3J30k/eu2utgdJaWF0Xee0rapS5RCXMLnRiXb4MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774138026; c=relaxed/simple;
	bh=ydZr5tIQVHkCWq3/6Au930Fb1e1Dj1nhBQ13K5iuYlA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s6maN+AVVoG1qIASf7DR/sxK2pFImiP5Gy/fTrPUuQRcTghpDXMXXkaEksy4l7r4rpvvbl0MKpM9WwkmQWfElJ6xJzLFC8elKSvP1Y/s4+nHlMkQ1ByTK0bNkTPatGxb6vF04cBnH63QzwFfrbdOcPyOU6JxUrBfO7mZGNHszGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Received: from localhost.localdomain ([160.80.103.126])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 62M06J54021482;
	Sun, 22 Mar 2026 01:06:25 +0100
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Stefano Salsano <stefano.salsano@uniroma2.it>,
        Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
        Ahmed Abdelsalam <ahabdels@cisco.com>,
        Justin Iurman <justin.iurman@6wind.com>, linux-kernel@vger.kernel.org,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: [RFC PATCH net-next 1/3] seg6: add support for the SRv6 End.DT2U behavior
Date: Sun, 22 Mar 2026 01:05:55 +0100
Message-Id: <20260322000557.12559-2-andrea.mayer@uniroma2.it>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260322000557.12559-1-andrea.mayer@uniroma2.it>
References: <20260322000557.12559-1-andrea.mayer@uniroma2.it>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[uniroma2.it : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-270277-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrea.mayer@uniroma2.it,netdev@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,uniroma2.it:email,uniroma2.it:mid]
X-Rspamd-Queue-Id: 09F7B2E7B3F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Implement the SRv6 End.DT2U (Endpoint with decapsulation and unicast
MAC L2 table lookup) behavior as defined in RFC 8986, Section 4.11.

End.DT2U decapsulates an SRv6 packet carrying an inner Ethernet frame
and delivers it on a user-specified device (l2dev). The l2dev is
expected to be a bridge port, where the Linux bridge provides MAC
learning and L2 forwarding as required by the RFC, or a srl2
Ethernet pseudowire device.

A new netlink attribute SEG6_LOCAL_L2DEV identifies the target device.

Usage:

  ip -6 route add fc00::100/128 encap seg6local action End.DT2U \
      l2dev veth0 dev dum0

  where veth0 is a bridge port.

Co-developed-by: Stefano Salsano <stefano.salsano@uniroma2.it>
Signed-off-by: Stefano Salsano <stefano.salsano@uniroma2.it>
Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
---
 include/uapi/linux/seg6_local.h |   3 +
 net/ipv6/seg6_local.c           | 160 ++++++++++++++++++++++++++++++--
 2 files changed, 157 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/seg6_local.h b/include/uapi/linux/seg6_local.h
index 4fdc424c9cb3..f9aa627be1fd 100644
--- a/include/uapi/linux/seg6_local.h
+++ b/include/uapi/linux/seg6_local.h
@@ -29,6 +29,7 @@ enum {
 	SEG6_LOCAL_VRFTABLE,
 	SEG6_LOCAL_COUNTERS,
 	SEG6_LOCAL_FLAVORS,
+	SEG6_LOCAL_L2DEV,
 	__SEG6_LOCAL_MAX,
 };
 #define SEG6_LOCAL_MAX (__SEG6_LOCAL_MAX - 1)
@@ -67,6 +68,8 @@ enum {
 	SEG6_LOCAL_ACTION_END_BPF	= 15,
 	/* decap and lookup of DA in v4 or v6 table */
 	SEG6_LOCAL_ACTION_END_DT46	= 16,
+	/* decap and unicast MAC L2 table lookup */
+	SEG6_LOCAL_ACTION_END_DT2U	= 17,
 
 	__SEG6_LOCAL_ACTION_MAX,
 };
diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index 2b41e4c0dddd..a766f235c532 100644
--- a/net/ipv6/seg6_local.c
+++ b/net/ipv6/seg6_local.c
@@ -192,6 +192,7 @@ struct seg6_local_lwt {
 	struct in6_addr nh6;
 	int iif;
 	int oif;
+	int l2dev;
 	struct bpf_lwt_prog bpf;
 #ifdef CONFIG_NET_L3_MASTER_DEV
 	struct seg6_end_dt_info dt_info;
@@ -902,6 +903,118 @@ static int input_action_end_dx2(struct sk_buff *skb,
 	return -EINVAL;
 }
 
+static inline bool seg6_is_valid_l2dev(const struct net_device *dev)
+{
+	if (netif_is_bridge_port(dev))
+		return true;
+
+	/* A netif_is_srl2() helper, similar to netif_is_vxlan(), could wrap
+	 * this check.
+	 */
+	if (dev->rtnl_link_ops &&
+	    !strcmp(dev->rtnl_link_ops->kind, "srl2"))
+		return true;
+
+	return false;
+}
+
+/* decapsulate and deliver inner L2 frame locally on specified device.
+ * Implements End.DT2U (RFC 8986, Section 4.11) by delivering the
+ * decapsulated Ethernet frame on a device that provides L2 table
+ * semantics (bridge port) or L2 delivery semantics (srl2 device).
+ */
+static int input_action_end_dt2u(struct sk_buff *skb,
+				 struct seg6_local_lwt *slwt)
+{
+	struct net *net = dev_net(skb->dev);
+	struct net_device *l2dev;
+
+	if (!decap_and_validate(skb, IPPROTO_ETHERNET))
+		goto drop;
+
+	if (!pskb_may_pull(skb, ETH_HLEN))
+		goto drop;
+
+	l2dev = dev_get_by_index_rcu(net, slwt->l2dev);
+	if (!l2dev)
+		goto drop;
+
+	if (l2dev->type != ARPHRD_ETHER)
+		goto drop;
+
+	/* Consistent with the carrier check in input_action_end_dx2(). */
+	if (!(l2dev->flags & IFF_UP) || !netif_carrier_ok(l2dev))
+		goto drop;
+
+	/* RFC 8986 requires L2 forwarding semantics. Only bridge ports
+	 * and srl2 devices satisfy this requirement.
+	 */
+	if (!seg6_is_valid_l2dev(l2dev))
+		goto drop;
+
+	skb_orphan(skb);
+
+	if (skb_warn_if_lro(skb))
+		goto drop;
+
+	/* eth_type_trans() sets skb->dev, skb->pkt_type, pulls ETH_HLEN,
+	 * and returns the protocol. This is required for proper L2
+	 * processing when the device is a bridge port.
+	 */
+	skb->protocol = eth_type_trans(skb, l2dev);
+
+	/* Reset network_header to point to the L3 header (past ethernet).
+	 * eth_type_trans pulled ETH_HLEN, so skb->data is at the L3 header
+	 * now. Without this, network_header still points to the ethernet
+	 * header (set by decap_and_validate), and ip_rcv would read garbage
+	 * when the bridge delivers the frame to the local stack.
+	 */
+	skb_reset_network_header(skb);
+
+	/* Drop the dst inherited from the outer SRv6 packet. Without
+	 * this, when the bridge delivers locally (e.g. to a bridge IP),
+	 * ip_rcv would skip route lookup and use the stale IPv6 lwtunnel
+	 * dst for an IPv4 packet, causing a silent drop.
+	 */
+	skb_dst_drop(skb);
+
+	netif_rx(skb);
+
+	return 0;
+
+drop:
+	kfree_skb(skb);
+	return -EINVAL;
+}
+
+static struct net *fib6_config_get_net(const struct fib6_config *fib6_cfg)
+{
+	const struct nl_info *nli = &fib6_cfg->fc_nlinfo;
+
+	return nli->nl_net;
+}
+
+static int seg6_end_dt2u_build(struct seg6_local_lwt *slwt, const void *cfg,
+			       struct netlink_ext_ack *extack)
+{
+	struct net *net = fib6_config_get_net(cfg);
+	struct net_device *dev;
+
+	dev = __dev_get_by_index(net, slwt->l2dev);
+	if (!dev) {
+		NL_SET_ERR_MSG(extack, "l2dev device not found");
+		return -ENODEV;
+	}
+
+	if (!seg6_is_valid_l2dev(dev)) {
+		NL_SET_ERR_MSG(extack,
+			       "l2dev must be a bridge port or srl2 device");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int input_action_end_dx6_finish(struct net *net, struct sock *sk,
 				       struct sk_buff *skb)
 {
@@ -1004,12 +1117,6 @@ static int input_action_end_dx4(struct sk_buff *skb,
 }
 
 #ifdef CONFIG_NET_L3_MASTER_DEV
-static struct net *fib6_config_get_net(const struct fib6_config *fib6_cfg)
-{
-	const struct nl_info *nli = &fib6_cfg->fc_nlinfo;
-
-	return nli->nl_net;
-}
 
 static int __seg6_end_dt_vrf_build(struct seg6_local_lwt *slwt, const void *cfg,
 				   u16 family, struct netlink_ext_ack *extack)
@@ -1565,6 +1672,15 @@ static struct seg6_action_desc seg6_action_table[] = {
 		.optattrs	= SEG6_F_LOCAL_COUNTERS,
 		.input		= input_action_end_bpf,
 	},
+	{
+		.action		= SEG6_LOCAL_ACTION_END_DT2U,
+		.attrs		= SEG6_F_ATTR(SEG6_LOCAL_L2DEV),
+		.optattrs	= SEG6_F_LOCAL_COUNTERS,
+		.input		= input_action_end_dt2u,
+		.slwt_ops	= {
+					.build_state = seg6_end_dt2u_build,
+				  },
+	},
 
 };
 
@@ -1655,6 +1771,7 @@ static const struct nla_policy seg6_local_policy[SEG6_LOCAL_MAX + 1] = {
 	[SEG6_LOCAL_BPF]	= { .type = NLA_NESTED },
 	[SEG6_LOCAL_COUNTERS]	= { .type = NLA_NESTED },
 	[SEG6_LOCAL_FLAVORS]	= { .type = NLA_NESTED },
+	[SEG6_LOCAL_L2DEV]	= { .type = NLA_U32 },
 };
 
 static int parse_nla_srh(struct nlattr **attrs, struct seg6_local_lwt *slwt,
@@ -1889,6 +2006,30 @@ static int cmp_nla_oif(struct seg6_local_lwt *a, struct seg6_local_lwt *b)
 	return 0;
 }
 
+static int parse_nla_l2dev(struct nlattr **attrs, struct seg6_local_lwt *slwt,
+			   struct netlink_ext_ack *extack)
+{
+	slwt->l2dev = nla_get_u32(attrs[SEG6_LOCAL_L2DEV]);
+
+	return 0;
+}
+
+static int put_nla_l2dev(struct sk_buff *skb, struct seg6_local_lwt *slwt)
+{
+	if (nla_put_u32(skb, SEG6_LOCAL_L2DEV, slwt->l2dev))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
+static int cmp_nla_l2dev(struct seg6_local_lwt *a, struct seg6_local_lwt *b)
+{
+	if (a->l2dev != b->l2dev)
+		return 1;
+
+	return 0;
+}
+
 #define MAX_PROG_NAME 256
 static const struct nla_policy bpf_prog_policy[SEG6_LOCAL_BPF_PROG_MAX + 1] = {
 	[SEG6_LOCAL_BPF_PROG]	   = { .type = NLA_U32, },
@@ -2318,6 +2459,10 @@ static struct seg6_action_param seg6_action_params[SEG6_LOCAL_MAX + 1] = {
 	[SEG6_LOCAL_FLAVORS]	= { .parse = parse_nla_flavors,
 				    .put = put_nla_flavors,
 				    .cmp = cmp_nla_flavors },
+
+	[SEG6_LOCAL_L2DEV]	= { .parse = parse_nla_l2dev,
+				    .put = put_nla_l2dev,
+				    .cmp = cmp_nla_l2dev },
 };
 
 /* call the destroy() callback (if available) for each set attribute in
@@ -2634,6 +2779,9 @@ static int seg6_local_get_encap_size(struct lwtunnel_state *lwt)
 	if (attrs & SEG6_F_ATTR(SEG6_LOCAL_FLAVORS))
 		nlsize += encap_size_flavors(slwt);
 
+	if (attrs & SEG6_F_ATTR(SEG6_LOCAL_L2DEV))
+		nlsize += nla_total_size(4);
+
 	return nlsize;
 }
 
-- 
2.20.1


