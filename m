Return-Path: <netdev+bounces-306886-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id b9jGKqRwUmpBPwMAu9opvQ
	(envelope-from <netdev+bounces-306886-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 18:34:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 096197422FB
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 18:34:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=uniroma2.it (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306886-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306886-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B12E303277C
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 16:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147B8391E66;
	Sat, 11 Jul 2026 16:34:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928AA3C9EC2;
	Sat, 11 Jul 2026 16:33:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783787640; cv=none; b=mKxv5Rtbzn8TpPZN5oW/YPLCt4tp3eYLZsD9ZtnlCjoZkVXwvjqVP3aiNvWQqZ8e4y7WnN2cWuCDkGFn42ck/nYcD3QedOK3O0NZqWFYKCX7iTL6EOejX5AhGwciXVsfXH5ZTrOLpebYmS/wdHWmcGFr1GaoDtZVDiz0svH33Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783787640; c=relaxed/simple;
	bh=MQcXSfWJjmbEvksoljPXtGFfKha1lpeX0LdDS3bL770=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sadEKBRNXpQ/kFQzY/2FniF3ZAvRGV9o/yXcM9M6TSOfh99we/zAtskh0waWXdMjty4iRGgWzMwC4pLgbMY7LCNkPbHnFUQkl78vLgTRLLDe803x7u2yNjWTKhjHFlpcytyPa64apdRsGJKcq88BjYRSWuNbgvMpE7JpxQq7TEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; arc=none smtp.client-ip=160.80.4.37
Received: from localhost.localdomain ([160.80.103.126])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 66BGTX4X007834;
	Sat, 11 Jul 2026 18:29:39 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Justin Iurman <justin.iurman@6wind.com>,
        Anthony Doeraene <anthony.doeraene@uclouvain.be>,
        Stefano Salsano <stefano.salsano@uniroma2.it>,
        Ahmed Abdelsalam <ahabdels@cisco.com>,
        Paolo Lungaroni <paolo.lungaroni@uniroma2.it>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: [PATCH net-next 1/2] seg6: add FIB table attribute for post-encap SID route lookup
Date: Sat, 11 Jul 2026 18:29:06 +0200
Message-Id: <20260711162907.6521-2-andrea.mayer@uniroma2.it>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260711162907.6521-1-andrea.mayer@uniroma2.it>
References: <20260711162907.6521-1-andrea.mayer@uniroma2.it>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.14 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[uniroma2.it : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:dsahern@kernel.org,m:horms@kernel.org,m:shuah@kernel.org,m:nicolas.dichtel@6wind.com,m:justin.iurman@6wind.com,m:anthony.doeraene@uclouvain.be,m:stefano.salsano@uniroma2.it,m:ahabdels@cisco.com,m:paolo.lungaroni@uniroma2.it,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrea.mayer@uniroma2.it,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-306886-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[andrea.mayer@uniroma2.it,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrea.mayer@uniroma2.it,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,6wind.com:email,uniroma2.it:from_mime,uniroma2.it:email,uniroma2.it:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 096197422FB

After SRv6 encapsulation the kernel looks up the route for the first SID,
that is the outer IPv6 destination of the encapsulated packet. This
post-encap SID route lookup uses the FIB table of the current routing
context. When the encap route is installed in a VRF, the VRF's table may
not have a route matching the SID. In that case another table should
handle it, e.g. one configured for underlay connectivity.

Add an optional SEG6_IPTUNNEL_TABLE attribute that selects the FIB table
used for this lookup. When set by the user, the attribute is honored on
both the input path (forwarded traffic) and the output path (locally
originated traffic). SRv6 encap routes that do not set the attribute use
the current routing context, as before.

For example:

  # SID route installed in the underlay table 500
  ip -6 route add fc00::100/128 via fd00::1 dev veth0 table 500

  # encap route in vrf-100; the first SID is looked up in table 500
  ip -6 route add cafe::1/128 vrf vrf-100 \
      encap seg6 mode encap segs fc00::100 lookup 500 dev veth0

  # or look up the SID in the main table
  ip -6 route add cafe::1/128 vrf vrf-100 \
      encap seg6 mode encap segs fc00::100 lookup main dev veth0

Suggested-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---
 include/uapi/linux/seg6_iptunnel.h |   1 +
 net/ipv6/seg6_iptunnel.c           | 132 +++++++++++++++++++++++++----
 2 files changed, 117 insertions(+), 16 deletions(-)

diff --git a/include/uapi/linux/seg6_iptunnel.h b/include/uapi/linux/seg6_iptunnel.h
index 485889b19900..e1964b3a4bb0 100644
--- a/include/uapi/linux/seg6_iptunnel.h
+++ b/include/uapi/linux/seg6_iptunnel.h
@@ -21,6 +21,7 @@ enum {
 	SEG6_IPTUNNEL_UNSPEC,
 	SEG6_IPTUNNEL_SRH,
 	SEG6_IPTUNNEL_SRC,	/* struct in6_addr */
+	SEG6_IPTUNNEL_TABLE,	/* __u32 FIB table for post-encap SID lookup */
 	__SEG6_IPTUNNEL_MAX,
 };
 #define SEG6_IPTUNNEL_MAX (__SEG6_IPTUNNEL_MAX - 1)
diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
index 4c45c0a77d75..61c6a27bf202 100644
--- a/net/ipv6/seg6_iptunnel.c
+++ b/net/ipv6/seg6_iptunnel.c
@@ -51,6 +51,7 @@ struct seg6_lwt {
 	struct dst_cache cache_input;
 	struct dst_cache cache_output;
 	struct in6_addr tunsrc;
+	u32 table;
 	struct seg6_iptunnel_encap tuninfo[];
 };
 
@@ -68,6 +69,7 @@ seg6_encap_lwtunnel(struct lwtunnel_state *lwt)
 static const struct nla_policy seg6_iptunnel_policy[SEG6_IPTUNNEL_MAX + 1] = {
 	[SEG6_IPTUNNEL_SRH]	= { .type = NLA_BINARY },
 	[SEG6_IPTUNNEL_SRC]	= NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)),
+	[SEG6_IPTUNNEL_TABLE]	= { .type = NLA_U32 },
 };
 
 static int nla_put_srh(struct sk_buff *skb, int attrtype,
@@ -479,6 +481,73 @@ int seg6_do_srh_inline(struct sk_buff *skb, struct ipv6_sr_hdr *osrh)
 }
 EXPORT_SYMBOL_GPL(seg6_do_srh_inline);
 
+/* look up a route in a specific FIB table.
+ * Returns a refcounted dst, or NULL if the table does not exist.
+ */
+static struct dst_entry *seg6_table_lookup(struct net *net,
+					   struct sk_buff *skb,
+					   struct flowi6 *fl6, u32 tbl_id)
+{
+	struct fib6_table *table;
+	struct rt6_info *rt;
+
+	table = fib6_get_table(net, tbl_id);
+	if (!table)
+		return NULL;
+
+	rt = ip6_pol_route(net, table, 0, fl6, skb, RT6_LOOKUP_F_HAS_SADDR);
+	return &rt->dst;
+}
+
+static void seg6_init_flowi6(struct sk_buff *skb, struct ipv6hdr *hdr,
+			     struct flowi6 *fl6)
+{
+	memset(fl6, 0, sizeof(*fl6));
+
+	fl6->daddr = hdr->daddr;
+	fl6->saddr = hdr->saddr;
+	fl6->flowlabel = ip6_flowinfo(hdr);
+	fl6->flowi6_mark = skb->mark;
+	fl6->flowi6_proto = hdr->nexthdr;
+}
+
+/* look up the route for the first SID on the input path and set it on the skb.
+ * Returns the refcounted dst, or NULL if a reference could not be safely taken.
+ */
+static struct dst_entry *seg6_input_route(struct net *net,
+					  struct sk_buff *skb,
+					  struct seg6_lwt *slwt)
+{
+	u32 table = slwt->table;
+
+	if (table) {
+		struct ipv6hdr *hdr = ipv6_hdr(skb);
+		struct dst_entry *dst;
+		struct flowi6 fl6;
+
+		seg6_init_flowi6(skb, hdr, &fl6);
+		fl6.flowi6_iif = skb->dev->ifindex;
+
+		dst = seg6_table_lookup(net, skb, &fl6, table);
+		if (!dst) {
+			dst = &net->ipv6.ip6_blk_hole_entry->dst;
+			dst_hold(dst);
+		}
+
+		skb_dst_drop(skb);
+		skb_dst_set(skb, dst);
+	} else {
+		ip6_route_input(skb);
+
+		/* ip6_route_input() sets a NOREF dst; force a refcount on it
+		 * before caching or further use.
+		 */
+		skb_dst_force(skb);
+	}
+
+	return skb_dst(skb);
+}
+
 static int seg6_input_finish(struct net *net, struct sock *sk,
 			     struct sk_buff *skb)
 {
@@ -513,15 +582,9 @@ static int seg6_input_core(struct net *net, struct sock *sk,
 		goto drop;
 	}
 
-	if (!dst) {
-		ip6_route_input(skb);
-
-		/* ip6_route_input() sets a NOREF dst; force a refcount on it
-		 * before caching or further use.
-		 */
-		skb_dst_force(skb);
-		dst = skb_dst(skb);
-		if (unlikely(!dst)) {
+	if (unlikely(!dst)) {
+		dst = seg6_input_route(net, skb, slwt);
+		if (!dst) {
 			err = -ENETUNREACH;
 			goto drop;
 		}
@@ -578,6 +641,29 @@ static int seg6_input(struct sk_buff *skb)
 	return seg6_input_core(dev_net(skb->dev), NULL, skb);
 }
 
+/* look up the route for the first SID on the output path. Always returns a
+ * refcounted dst.
+ */
+static struct dst_entry *seg6_output_dst_lookup(struct net *net,
+						struct sk_buff *skb,
+						struct flowi6 *fl6,
+						struct seg6_lwt *slwt)
+{
+	struct dst_entry *dst;
+
+	if (slwt->table) {
+		dst = seg6_table_lookup(net, skb, fl6, slwt->table);
+		if (!dst) {
+			dst = &net->ipv6.ip6_blk_hole_entry->dst;
+			dst_hold(dst);
+		}
+	} else {
+		dst = ip6_route_output(net, NULL, fl6);
+	}
+
+	return dst;
+}
+
 static int seg6_output_core(struct net *net, struct sock *sk,
 			    struct sk_buff *skb)
 {
@@ -600,14 +686,9 @@ static int seg6_output_core(struct net *net, struct sock *sk,
 		struct ipv6hdr *hdr = ipv6_hdr(skb);
 		struct flowi6 fl6;
 
-		memset(&fl6, 0, sizeof(fl6));
-		fl6.daddr = hdr->daddr;
-		fl6.saddr = hdr->saddr;
-		fl6.flowlabel = ip6_flowinfo(hdr);
-		fl6.flowi6_mark = skb->mark;
-		fl6.flowi6_proto = hdr->nexthdr;
+		seg6_init_flowi6(skb, hdr, &fl6);
 
-		dst = ip6_route_output(net, NULL, &fl6);
+		dst = seg6_output_dst_lookup(net, skb, &fl6, slwt);
 		if (dst->error) {
 			err = dst->error;
 			goto drop;
@@ -752,6 +833,15 @@ static int seg6_build_state(struct net *net, struct nlattr *nla,
 		}
 	}
 
+	if (tb[SEG6_IPTUNNEL_TABLE]) {
+		slwt->table = nla_get_u32(tb[SEG6_IPTUNNEL_TABLE]);
+		if (!slwt->table) {
+			NL_SET_ERR_MSG(extack, "invalid lookup table");
+			err = -EINVAL;
+			goto err_destroy_output;
+		}
+	}
+
 	newts->type = LWTUNNEL_ENCAP_SEG6;
 	newts->flags |= LWTUNNEL_STATE_INPUT_REDIRECT;
 
@@ -795,6 +885,10 @@ static int seg6_fill_encap_info(struct sk_buff *skb,
 	    nla_put_in6_addr(skb, SEG6_IPTUNNEL_SRC, &slwt->tunsrc))
 		return -EMSGSIZE;
 
+	if (slwt->table &&
+	    nla_put_u32(skb, SEG6_IPTUNNEL_TABLE, slwt->table))
+		return -EMSGSIZE;
+
 	return 0;
 }
 
@@ -809,6 +903,9 @@ static int seg6_encap_nlsize(struct lwtunnel_state *lwtstate)
 	if (!ipv6_addr_any(&slwt->tunsrc))
 		nlsize += nla_total_size(sizeof(slwt->tunsrc));
 
+	if (slwt->table)
+		nlsize += nla_total_size(sizeof(u32));
+
 	return nlsize;
 }
 
@@ -826,6 +923,9 @@ static int seg6_encap_cmp(struct lwtunnel_state *a, struct lwtunnel_state *b)
 	if (!ipv6_addr_equal(&a_slwt->tunsrc, &b_slwt->tunsrc))
 		return 1;
 
+	if (a_slwt->table != b_slwt->table)
+		return 1;
+
 	return memcmp(a_hdr, b_hdr, len);
 }
 
-- 
2.20.1


