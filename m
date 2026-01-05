Return-Path: <netdev+bounces-246878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9E9CF217E
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 07:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86D10300E795
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 06:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F8D1C84DE;
	Mon,  5 Jan 2026 06:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DjaBVkgA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B63273F9;
	Mon,  5 Jan 2026 06:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767595533; cv=none; b=Q9OXhDL4QpAWoFLPkJu+gw/t6xna8q3QuzopGgNTtpHqZ7VRAeJiorbJwwc39B+qAW6PV5YS326iVAo3sQxbsUbT9YPai7DL5J8Is0PsgvKeP5yQtz9vHAPtDhPWEWGjxqn0/nAFhaoiwknqfYvNhfrfB0w//XQFU6ozfYk7RVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767595533; c=relaxed/simple;
	bh=39+dp+LyKV9XXcRP1+Darn1hWmdC9rX82dbhenXJ4ik=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hgeQZcn2K38t6HnI2fwloXILhwMgRqPctjFpH/eQxfaVf8H/CB3FFt2k5rKoIRCbMlUD/K+8cVGHA3dIFgkpkpYvGL6JdrtG2hjW/+c6Enwgy1JxcF/r5IN2m9ACfrYX7wa7FEB/G5VVoX5spmwqwC84r6n5G0N7DF1pQt5Wj9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DjaBVkgA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6905CC19421;
	Mon,  5 Jan 2026 06:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767595533;
	bh=39+dp+LyKV9XXcRP1+Darn1hWmdC9rX82dbhenXJ4ik=;
	h=Date:From:To:Cc:Subject:From;
	b=DjaBVkgAKoLplSExx5GK+fkIILn2fyoXuziP/zthkg3qO3Ku5XWdFNiILMjAuesFD
	 ni+SUfq9C7jAT4GKcvBTZZRN5B/EbCmj4Srr9sHpon7yzCzek9rTjP88hCFyMkxPP1
	 V2PosWUUeU59qeUEq0RbWKK0UjKlM/Z30K+R2ZNcQsAFREgrzUVVV8k7F085fvSGEm
	 MXkZ+GfXIu39DY+6eNsdilu2L85Mj1p6mO+1UmRJpYnaqA0A0sW6MeT5o8janyZoId
	 K+1ClpbZZL5PvY3bN/uNCCCzcGXPtZuU0Acn98aoXlZCmXB1dE5Opvss9ANaFFyCrf
	 5uloDS7ggNAEA==
Date: Mon, 5 Jan 2026 15:45:25 +0900
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: [PATCH v2][next] ipv4/inet_sock.h: Avoid thousands of
 -Wflex-array-member-not-at-end warnings
Message-ID: <aVteBadWA6AbTp7X@kspp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Use DEFINE_RAW_FLEX() to avoid thousands of -Wflex-array-member-not-at-end
warnings.

Remove struct ip_options_data, and adjust the rest of the code so that
flexible-array member struct ip_options_rcu::opt.__data[] ends last
in struct icmp_bxm.

Compensate for this by using the DEFINE_RAW_FLEX() helper to define each
on-stack struct instance that contained struct ip_options_data as a member,
and to define struct ip_options_rcu with a fixed on-stack size for its
nested flexible-array member opt.__data[].

Also, add a couple of code comments to prevent people from adding members
to a struct after another member that contains a flexible array.

With these changes, fix 2600 warnings of the following type:

include/net/inet_sock.h:65:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Use the DEFINE_RAW_FLEX() helper.
 - Update subject and changelog text.

 include/net/inet_sock.h |   9 ++--
 net/ipv4/icmp.c         | 108 +++++++++++++++++++++-------------------
 net/ipv4/ip_output.c    |  13 ++---
 net/ipv4/ping.c         |   7 +--
 net/ipv4/raw.c          |   7 +--
 net/ipv4/udp.c          |   7 +--
 6 files changed, 81 insertions(+), 70 deletions(-)

diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
index ac1c75975908..3370159556b8 100644
--- a/include/net/inet_sock.h
+++ b/include/net/inet_sock.h
@@ -26,6 +26,8 @@
 #include <net/tcp_states.h>
 #include <net/l3mdev.h>
 
+#define IP_OPTIONS_DATA_FIXED_SIZE 40
+
 /** struct ip_options - IP Options
  *
  * @faddr - Saved first hop address
@@ -58,12 +60,9 @@ struct ip_options {
 
 struct ip_options_rcu {
 	struct rcu_head rcu;
-	struct ip_options opt;
-};
 
-struct ip_options_data {
-	struct ip_options_rcu	opt;
-	char			data[40];
+	/* Must be last as it ends in a flexible-array member. */
+	struct ip_options opt;
 };
 
 struct inet_request_sock {
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 4abbec2f47ef..19c9c838967f 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -112,7 +112,9 @@ struct icmp_bxm {
 		__be32	       times[3];
 	} data;
 	int head_len;
-	struct ip_options_data replyopts;
+
+	/* Must be last as it ends in a flexible-array member. */
+	struct ip_options_rcu replyopts;
 };
 
 /* An array of errno for error messages from dest unreach. */
@@ -353,9 +355,12 @@ void icmp_out_count(struct net *net, unsigned char type)
 static int icmp_glue_bits(void *from, char *to, int offset, int len, int odd,
 			  struct sk_buff *skb)
 {
-	struct icmp_bxm *icmp_param = from;
+	DEFINE_RAW_FLEX(struct icmp_bxm, icmp_param, replyopts.opt.__data,
+			IP_OPTIONS_DATA_FIXED_SIZE);
 	__wsum csum;
 
+	icmp_param = from;
+
 	csum = skb_copy_and_csum_bits(icmp_param->skb,
 				      icmp_param->offset + offset,
 				      to, len);
@@ -413,7 +418,7 @@ static void icmp_reply(struct icmp_bxm *icmp_param, struct sk_buff *skb)
 	int type = icmp_param->data.icmph.type;
 	int code = icmp_param->data.icmph.code;
 
-	if (ip_options_echo(net, &icmp_param->replyopts.opt.opt, skb))
+	if (ip_options_echo(net, &icmp_param->replyopts.opt, skb))
 		return;
 
 	/* Needed by both icmpv4_global_allow and icmp_xmit_lock */
@@ -435,10 +440,10 @@ static void icmp_reply(struct icmp_bxm *icmp_param, struct sk_buff *skb)
 	daddr = ipc.addr = ip_hdr(skb)->saddr;
 	saddr = fib_compute_spec_dst(skb);
 
-	if (icmp_param->replyopts.opt.opt.optlen) {
-		ipc.opt = &icmp_param->replyopts.opt;
+	if (icmp_param->replyopts.opt.optlen) {
+		ipc.opt = &icmp_param->replyopts;
 		if (ipc.opt->opt.srr)
-			daddr = icmp_param->replyopts.opt.opt.faddr;
+			daddr = icmp_param->replyopts.opt.faddr;
 	}
 	memset(&fl4, 0, sizeof(fl4));
 	fl4.daddr = daddr;
@@ -491,8 +496,8 @@ static struct rtable *icmp_route_lookup(struct net *net, struct flowi4 *fl4,
 	int err;
 
 	memset(fl4, 0, sizeof(*fl4));
-	fl4->daddr = (param->replyopts.opt.opt.srr ?
-		      param->replyopts.opt.opt.faddr : iph->saddr);
+	fl4->daddr = (param->replyopts.opt.srr ?
+		      param->replyopts.opt.faddr : iph->saddr);
 	fl4->saddr = saddr;
 	fl4->flowi4_mark = mark;
 	fl4->flowi4_uid = sock_net_uid(net, NULL);
@@ -775,9 +780,10 @@ icmp_ext_append(struct net *net, struct sk_buff *skb_in, struct icmphdr *icmph,
 void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
 		 const struct inet_skb_parm *parm)
 {
+	DEFINE_RAW_FLEX(struct icmp_bxm, icmp_param, replyopts.opt.__data,
+			IP_OPTIONS_DATA_FIXED_SIZE);
 	struct iphdr *iph;
 	int room;
-	struct icmp_bxm icmp_param;
 	struct rtable *rt = skb_rtable(skb_in);
 	bool apply_ratelimit = false;
 	struct sk_buff *ext_skb;
@@ -906,7 +912,7 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
 					   iph->tos;
 	mark = IP4_REPLY_MARK(net, skb_in->mark);
 
-	if (__ip_options_echo(net, &icmp_param.replyopts.opt.opt, skb_in,
+	if (__ip_options_echo(net, &icmp_param->replyopts.opt, skb_in,
 			      &parm->opt))
 		goto out_unlock;
 
@@ -915,21 +921,21 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
 	 *	Prepare data for ICMP header.
 	 */
 
-	icmp_param.data.icmph.type	 = type;
-	icmp_param.data.icmph.code	 = code;
-	icmp_param.data.icmph.un.gateway = info;
-	icmp_param.data.icmph.checksum	 = 0;
-	icmp_param.skb	  = skb_in;
-	icmp_param.offset = skb_network_offset(skb_in);
+	icmp_param->data.icmph.type	 = type;
+	icmp_param->data.icmph.code	 = code;
+	icmp_param->data.icmph.un.gateway = info;
+	icmp_param->data.icmph.checksum	 = 0;
+	icmp_param->skb	  = skb_in;
+	icmp_param->offset = skb_network_offset(skb_in);
 	ipcm_init(&ipc);
 	ipc.tos = tos;
 	ipc.addr = iph->saddr;
-	ipc.opt = &icmp_param.replyopts.opt;
+	ipc.opt = &icmp_param->replyopts;
 	ipc.sockc.mark = mark;
 
 	rt = icmp_route_lookup(net, &fl4, skb_in, iph, saddr,
 			       inet_dsfield_to_dscp(tos), mark, type, code,
-			       &icmp_param);
+			       icmp_param);
 	if (IS_ERR(rt))
 		goto out_unlock;
 
@@ -942,7 +948,7 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
 	room = dst_mtu(&rt->dst);
 	if (room > 576)
 		room = 576;
-	room -= sizeof(struct iphdr) + icmp_param.replyopts.opt.opt.optlen;
+	room -= sizeof(struct iphdr) + icmp_param->replyopts.opt.optlen;
 	room -= sizeof(struct icmphdr);
 	/* Guard against tiny mtu. We need to include at least one
 	 * IP network header for this message to make any sense.
@@ -950,15 +956,15 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
 	if (room <= (int)sizeof(struct iphdr))
 		goto ende;
 
-	ext_skb = icmp_ext_append(net, skb_in, &icmp_param.data.icmph, room,
+	ext_skb = icmp_ext_append(net, skb_in, &icmp_param->data.icmph, room,
 				  parm->iif);
 	if (ext_skb)
-		icmp_param.skb = ext_skb;
+		icmp_param->skb = ext_skb;
 
-	icmp_param.data_len = icmp_param.skb->len - icmp_param.offset;
-	if (icmp_param.data_len > room)
-		icmp_param.data_len = room;
-	icmp_param.head_len = sizeof(struct icmphdr);
+	icmp_param->data_len = icmp_param->skb->len - icmp_param->offset;
+	if (icmp_param->data_len > room)
+		icmp_param->data_len = room;
+	icmp_param->head_len = sizeof(struct icmphdr);
 
 	/* if we don't have a source address at this point, fall back to the
 	 * dummy address instead of sending out a packet with a source address
@@ -969,7 +975,7 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
 
 	trace_icmp_send(skb_in, type, code);
 
-	icmp_push_reply(sk, &icmp_param, &fl4, &ipc, &rt);
+	icmp_push_reply(sk, icmp_param, &fl4, &ipc, &rt);
 
 	if (ext_skb)
 		consume_skb(ext_skb);
@@ -1206,7 +1212,8 @@ static enum skb_drop_reason icmp_redirect(struct sk_buff *skb)
 
 static enum skb_drop_reason icmp_echo(struct sk_buff *skb)
 {
-	struct icmp_bxm icmp_param;
+	DEFINE_RAW_FLEX(struct icmp_bxm, icmp_param, replyopts.opt.__data,
+			IP_OPTIONS_DATA_FIXED_SIZE);
 	struct net *net;
 
 	net = skb_dst_dev_net_rcu(skb);
@@ -1214,18 +1221,18 @@ static enum skb_drop_reason icmp_echo(struct sk_buff *skb)
 	if (READ_ONCE(net->ipv4.sysctl_icmp_echo_ignore_all))
 		return SKB_NOT_DROPPED_YET;
 
-	icmp_param.data.icmph	   = *icmp_hdr(skb);
-	icmp_param.skb		   = skb;
-	icmp_param.offset	   = 0;
-	icmp_param.data_len	   = skb->len;
-	icmp_param.head_len	   = sizeof(struct icmphdr);
+	icmp_param->data.icmph	   = *icmp_hdr(skb);
+	icmp_param->skb		   = skb;
+	icmp_param->offset	   = 0;
+	icmp_param->data_len	   = skb->len;
+	icmp_param->head_len	   = sizeof(struct icmphdr);
 
-	if (icmp_param.data.icmph.type == ICMP_ECHO)
-		icmp_param.data.icmph.type = ICMP_ECHOREPLY;
-	else if (!icmp_build_probe(skb, &icmp_param.data.icmph))
+	if (icmp_param->data.icmph.type == ICMP_ECHO)
+		icmp_param->data.icmph.type = ICMP_ECHOREPLY;
+	else if (!icmp_build_probe(skb, &icmp_param->data.icmph))
 		return SKB_NOT_DROPPED_YET;
 
-	icmp_reply(&icmp_param, skb);
+	icmp_reply(icmp_param, skb);
 	return SKB_NOT_DROPPED_YET;
 }
 
@@ -1353,7 +1360,8 @@ EXPORT_SYMBOL_GPL(icmp_build_probe);
  */
 static enum skb_drop_reason icmp_timestamp(struct sk_buff *skb)
 {
-	struct icmp_bxm icmp_param;
+	DEFINE_RAW_FLEX(struct icmp_bxm, icmp_param, replyopts.opt.__data,
+			IP_OPTIONS_DATA_FIXED_SIZE);
 	/*
 	 *	Too short.
 	 */
@@ -1363,19 +1371,19 @@ static enum skb_drop_reason icmp_timestamp(struct sk_buff *skb)
 	/*
 	 *	Fill in the current time as ms since midnight UT:
 	 */
-	icmp_param.data.times[1] = inet_current_timestamp();
-	icmp_param.data.times[2] = icmp_param.data.times[1];
-
-	BUG_ON(skb_copy_bits(skb, 0, &icmp_param.data.times[0], 4));
-
-	icmp_param.data.icmph	   = *icmp_hdr(skb);
-	icmp_param.data.icmph.type = ICMP_TIMESTAMPREPLY;
-	icmp_param.data.icmph.code = 0;
-	icmp_param.skb		   = skb;
-	icmp_param.offset	   = 0;
-	icmp_param.data_len	   = 0;
-	icmp_param.head_len	   = sizeof(struct icmphdr) + 12;
-	icmp_reply(&icmp_param, skb);
+	icmp_param->data.times[1] = inet_current_timestamp();
+	icmp_param->data.times[2] = icmp_param->data.times[1];
+
+	BUG_ON(skb_copy_bits(skb, 0, &icmp_param->data.times[0], 4));
+
+	icmp_param->data.icmph	   = *icmp_hdr(skb);
+	icmp_param->data.icmph.type = ICMP_TIMESTAMPREPLY;
+	icmp_param->data.icmph.code = 0;
+	icmp_param->skb		   = skb;
+	icmp_param->offset	   = 0;
+	icmp_param->data_len	   = 0;
+	icmp_param->head_len	   = sizeof(struct icmphdr) + 12;
+	icmp_reply(icmp_param, skb);
 	return SKB_NOT_DROPPED_YET;
 
 out_err:
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index ff11d3a85a36..75fcb58795bb 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1606,7 +1606,8 @@ void ip_send_unicast_reply(struct sock *sk, const struct sock *orig_sk,
 			   const struct ip_reply_arg *arg,
 			   unsigned int len, u64 transmit_time, u32 txhash)
 {
-	struct ip_options_data replyopts;
+	DEFINE_RAW_FLEX(struct ip_options_rcu, replyopts, opt.__data,
+			IP_OPTIONS_DATA_FIXED_SIZE);
 	struct ipcm_cookie ipc;
 	struct flowi4 fl4;
 	struct rtable *rt = skb_rtable(skb);
@@ -1615,18 +1616,18 @@ void ip_send_unicast_reply(struct sock *sk, const struct sock *orig_sk,
 	int err;
 	int oif;
 
-	if (__ip_options_echo(net, &replyopts.opt.opt, skb, sopt))
+	if (__ip_options_echo(net, &replyopts->opt, skb, sopt))
 		return;
 
 	ipcm_init(&ipc);
 	ipc.addr = daddr;
 	ipc.sockc.transmit_time = transmit_time;
 
-	if (replyopts.opt.opt.optlen) {
-		ipc.opt = &replyopts.opt;
+	if (replyopts->opt.optlen) {
+		ipc.opt = replyopts;
 
-		if (replyopts.opt.opt.srr)
-			daddr = replyopts.opt.opt.faddr;
+		if (replyopts->opt.srr)
+			daddr = replyopts->opt.faddr;
 	}
 
 	oif = arg->bound_dev_if;
diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
index ad56588107cc..7e2812668350 100644
--- a/net/ipv4/ping.c
+++ b/net/ipv4/ping.c
@@ -690,6 +690,8 @@ EXPORT_IPV6_MOD_GPL(ping_common_sendmsg);
 
 static int ping_v4_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 {
+	DEFINE_RAW_FLEX(struct ip_options_rcu, opt_copy, opt.__data,
+			IP_OPTIONS_DATA_FIXED_SIZE);
 	struct net *net = sock_net(sk);
 	struct flowi4 fl4;
 	struct inet_sock *inet = inet_sk(sk);
@@ -697,7 +699,6 @@ static int ping_v4_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	struct icmphdr user_icmph;
 	struct pingfakehdr pfh;
 	struct rtable *rt = NULL;
-	struct ip_options_data opt_copy;
 	int free = 0;
 	__be32 saddr, daddr, faddr;
 	u8 scope;
@@ -746,9 +747,9 @@ static int ping_v4_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		rcu_read_lock();
 		inet_opt = rcu_dereference(inet->inet_opt);
 		if (inet_opt) {
-			memcpy(&opt_copy, inet_opt,
+			memcpy(opt_copy, inet_opt,
 			       sizeof(*inet_opt) + inet_opt->opt.optlen);
-			ipc.opt = &opt_copy.opt;
+			ipc.opt = opt_copy;
 		}
 		rcu_read_unlock();
 	}
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index 5998c4cc6f47..e20c41206e29 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -481,6 +481,8 @@ static int raw_getfrag(void *from, char *to, int offset, int len, int odd,
 
 static int raw_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 {
+	DEFINE_RAW_FLEX(struct ip_options_rcu, opt_copy, opt.__data,
+			IP_OPTIONS_DATA_FIXED_SIZE);
 	struct inet_sock *inet = inet_sk(sk);
 	struct net *net = sock_net(sk);
 	struct ipcm_cookie ipc;
@@ -491,7 +493,6 @@ static int raw_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	__be32 daddr;
 	__be32 saddr;
 	int uc_index, err;
-	struct ip_options_data opt_copy;
 	struct raw_frag_vec rfv;
 	int hdrincl;
 
@@ -561,9 +562,9 @@ static int raw_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		rcu_read_lock();
 		inet_opt = rcu_dereference(inet->inet_opt);
 		if (inet_opt) {
-			memcpy(&opt_copy, inet_opt,
+			memcpy(opt_copy, inet_opt,
 			       sizeof(*inet_opt) + inet_opt->opt.optlen);
-			ipc.opt = &opt_copy.opt;
+			ipc.opt = opt_copy;
 		}
 		rcu_read_unlock();
 	}
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index ffe074cb5865..591527ae811c 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1269,6 +1269,8 @@ EXPORT_IPV6_MOD_GPL(udp_cmsg_send);
 
 int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 {
+	DEFINE_RAW_FLEX(struct ip_options_rcu, opt_copy, opt.__data,
+			IP_OPTIONS_DATA_FIXED_SIZE);
 	struct inet_sock *inet = inet_sk(sk);
 	struct udp_sock *up = udp_sk(sk);
 	DECLARE_SOCKADDR(struct sockaddr_in *, usin, msg->msg_name);
@@ -1286,7 +1288,6 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	int corkreq = udp_test_bit(CORK, sk) || msg->msg_flags & MSG_MORE;
 	int (*getfrag)(void *, char *, int, int, int, struct sk_buff *);
 	struct sk_buff *skb;
-	struct ip_options_data opt_copy;
 	int uc_index;
 
 	if (len > 0xFFFF)
@@ -1368,9 +1369,9 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		rcu_read_lock();
 		inet_opt = rcu_dereference(inet->inet_opt);
 		if (inet_opt) {
-			memcpy(&opt_copy, inet_opt,
+			memcpy(opt_copy, inet_opt,
 			       sizeof(*inet_opt) + inet_opt->opt.optlen);
-			ipc.opt = &opt_copy.opt;
+			ipc.opt = opt_copy;
 		}
 		rcu_read_unlock();
 	}
-- 
2.43.0


