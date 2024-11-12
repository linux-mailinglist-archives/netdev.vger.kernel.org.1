Return-Path: <netdev+bounces-143935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C41759C4CAC
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 03:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18989B21FC6
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 02:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05379204F6C;
	Tue, 12 Nov 2024 02:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJv7aipa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3071433BE;
	Tue, 12 Nov 2024 02:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731378851; cv=none; b=A8aMxX1eR6mhaGD8aPsG9wvVKuqkCD8Gw03qG5Yo7yWHGCIouCnM7mjeNodHtMAgZT77nBKQj5s5iEHVNpQjSVyip9MyfjQk2rQEvSiglMGPhLry9GQtX29B8+O7eaXLjd1q03qZyxJpZM8YNzHvz6JI+r9Rmte8tU0y54BDfyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731378851; c=relaxed/simple;
	bh=HjR7njstQqXMiPKyEOmBtBMEP/t/FitjPb3UmVXYohI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=m3hFtZeqf/pw+ep8+QoVKKs3Hr0I947YopTH3N9AI6y0foERdvJTQuZ+Q8A46n2KAWyUmRg7Yq4Zn4urWnZ8zpWfXUrC+tVYS4kXlVZCOeSoP2aRGKSp8SXveQjvgYiVomfk0BQfUVjSY7XPzSWx4MarHxd9IasJlIf5Gfp5hGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJv7aipa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A172EC4CECF;
	Tue, 12 Nov 2024 02:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731378851;
	bh=HjR7njstQqXMiPKyEOmBtBMEP/t/FitjPb3UmVXYohI=;
	h=Date:From:To:Cc:Subject:From;
	b=NJv7aipaII0EsVY8JaHtJ3nKln7tBBwrCOnwK838sudOQw71AHE/sKtWt2Yowis85
	 tAvLnw58OySex7lke3Wf9HW8U5klOySJ4+37CHL5n3O4EHoYW/5usHrOeQxd1oGHm6
	 WFtjRBC3+e1crFARKfgiqjJSQrUywOgjv/cEn7aRo/+k0ZvNBab/uZvEZgqheOyAIy
	 eYsVWcvOrZjdzTViGSbsmnq+T/DWbTtye+EiVn3bsmhRwhZxasPQkhkf6O3iA8axct
	 St9Gr7vXovYqQ9HYFzXO6zj52QSMEn+xRTiSTMn6umQp4jIkrIKTwH/8V3joE/EYji
	 6MhTx8vjl4A9w==
Date: Mon, 11 Nov 2024 20:34:07 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: [PATCH RFC][next] net: inet_sock.h: Avoid thousands of
 -Wflex-array-member-not-at-end warnings
Message-ID: <ZzK-n_C2yl8mW2Tz@kspp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally

So, in order to avoid ending up with a flexible-array member in the
middle of another struct, we use the `struct_group_tagged()` helper
to create a new tagged `struct ip_options_hdr`. This structure groups
together all the members of the flexible `struct ip_options` except
the flexible array. As a result, the array is effectively separated
from the rest of the members without modifying the memory layout of
the flexible structure.

However, the pattern that triggers the warnings addressed by this patch
differs from the usual case. Typically, the flexible structure is
immediately followed by another object in the composite structure. Here,
however, we have a well-defined composite structure with a flexible
structure right at its end, which is a correct code construct and has
no issues on its own. An instance of this composite structure
(`struct ip_options_rcu`) is then used within another structure
(`struct ip_options_data`) right before a fixed-size array (`char
data[40]`), as below:

/* Modified flexible structure with struct_group_tagged() */
struct ip_options {
	struct_group_tagged(ip_options_hdr, __hdr,
		...
	);
	unsigned char __data[];
};

/* Correct composite struct with flex struct at the end. */
struct ip_options_rcu {
	struct rcu_head rcu;
	struct ip_options opt; /* flexible structure --this is fine. */
};

struct ip_options_data {
        struct ip_options_rcu   opt; /* Conflicting object causing tons
				      * of -Wfamnae warnings --it ends in
				      * flexible-array member `__data`. */
        char                    data[40];
};

In this scenario, we have two levels of indirection before reaching the
flexible array: `p->opt->opt->__data`. As a result, we can't simply
change the type of the conflicting object `opt` to `struct ip_options_hdr`
as we might in a simpler case, because `opt` in `struct ip_options_data`
isn't a flexible structure itself but a composite structure
`struct ip_options_rcu` containing one (flexible structure).

So, we have a couple of alternatives to fix this issue:

a) The complex solution: Create an additional "header type" with the
   help of `struct_group_tagged()`, and introduce another
   flexible-array member, as follows:

   1) Create a new type `struct ip_options_rcu_hdr` using
      `struct_group_tagged()` within `struct ip_options_rcu`.

   2) Change the type of `opt` from `struct ip_options` to `struct
      ip_options_hdr`, removing the flexible array member from the newly
      created `struct ip_options_rcu_hdr`.

   3) Add a flexible-array member directly inside `struct ip_options_rcu`,
      so it still has a flexible-array member at the end --which was
      previously "removed" with the change from `struct ip_options opt;`
      to `struct ip_options_hdr opt;`:

|	 struct ip_options_rcu {
|	-       struct rcu_head rcu;
|	-       struct ip_options opt;
|	+       struct_group_tagged(ip_options_rcu_hdr, hdr,
|	+               struct rcu_head rcu;
|	+               struct ip_options_hdr opt;
|	+       );
|	+       unsigned char   __data[];
|	 };

    4) Now we can change the type of the conflicting object `opt` in
       `struct ip_options_data` from `struct ip_options_rcu` to `struct
       ip_options_rcu_hdr`, and with this silence the -Wfamnae warnings:

|	 struct ip_options_data {
|	-       struct ip_options_rcu   opt;
|	-       char                    data[40];
|	+       struct ip_options_rcu_hdr       opt;
|	+       char                            data[40];
|	 };

    5) Code churn: This approach may (it really does) require more
       adjustments and refactoring than usual due to multiple type
       changes and the extra flexible-array member.

b) A simpler solution: Inline `struct ip_options_rcu` directly into
   `struct ip_options_data` using an anonymous structure. See below:

    1) Expand `struct ip_options_rcu` with an anonymous structure named
       `opt`, preserving access to `struct ip_options_rcu` members via
       `opt`.

    2) Change the type of `opt` in the anonymous structure from `struct
       ip_options` to `struct ip_options_hdr`, excluding the flexible
       array and thus making the warnings go away:

|	 struct ip_options_data {
|	-       struct ip_options_rcu   opt;
|	+       struct {
|	+               struct rcu_head rcu;
|	+               struct ip_options_hdr opt;
|	+       } opt;
|		char                    data[40];
|	 };

    3) Code churn: This solution requires minimal refactoring beyond
       type casting instances of `opt` back to its original type `struct
       ip_options_rcu`, and a couple of `container_of()`s.

So, I've decided to implement solution b) and with this, fix 2554 of the
following warnings:

include/net/inet_sock.h:64:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Additionally, we want to ensure that when new members need to be added
to the flexible structure, they are always included within the newly
created tagged struct. For this, we use `static_assert()`. This ensures
that the memory layout for both the flexible structure and the new tagged
struct is the same after any changes.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 include/net/inet_sock.h | 40 ++++++++++++++++++++++++----------------
 net/ipv4/icmp.c         | 14 ++++++++++----
 net/ipv4/ip_output.c    |  7 +++++--
 net/ipv4/ping.c         |  2 +-
 net/ipv4/raw.c          |  2 +-
 net/ipv4/udp.c          |  2 +-
 6 files changed, 42 insertions(+), 25 deletions(-)

diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
index 56d8bc5593d3..ba4e0e2bbea0 100644
--- a/include/net/inet_sock.h
+++ b/include/net/inet_sock.h
@@ -37,23 +37,28 @@
  * @ts_needaddr - Need to record addr of outgoing dev
  */
 struct ip_options {
-	__be32		faddr;
-	__be32		nexthop;
-	unsigned char	optlen;
-	unsigned char	srr;
-	unsigned char	rr;
-	unsigned char	ts;
-	unsigned char	is_strictroute:1,
-			srr_is_hit:1,
-			is_changed:1,
-			rr_needaddr:1,
-			ts_needtime:1,
-			ts_needaddr:1;
-	unsigned char	router_alert;
-	unsigned char	cipso;
-	unsigned char	__pad2;
+	/* New members MUST be added within the struct_group() macro below. */
+	struct_group_tagged(ip_options_hdr, __hdr,
+		__be32		faddr;
+		__be32		nexthop;
+		unsigned char	optlen;
+		unsigned char	srr;
+		unsigned char	rr;
+		unsigned char	ts;
+		unsigned char	is_strictroute:1,
+				srr_is_hit:1,
+				is_changed:1,
+				rr_needaddr:1,
+				ts_needtime:1,
+				ts_needaddr:1;
+		unsigned char	router_alert;
+		unsigned char	cipso;
+		unsigned char	__pad2;
+	);
 	unsigned char	__data[];
 };
+static_assert(offsetof(struct ip_options, __data) == sizeof(struct ip_options_hdr),
+	      "struct member likely outside of struct_group_tagged()");
 
 struct ip_options_rcu {
 	struct rcu_head rcu;
@@ -61,7 +66,10 @@ struct ip_options_rcu {
 };
 
 struct ip_options_data {
-	struct ip_options_rcu	opt;
+	struct {
+		struct rcu_head rcu;
+		struct ip_options_hdr opt;
+	} opt;
 	char			data[40];
 };
 
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 33eec844a5a0..6a0a38c33cae 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -400,6 +400,9 @@ static void icmp_push_reply(struct sock *sk,
 
 static void icmp_reply(struct icmp_bxm *icmp_param, struct sk_buff *skb)
 {
+	struct ip_options *opt =
+			container_of(&icmp_param->replyopts.opt.opt,
+				     struct ip_options, __hdr);
 	struct ipcm_cookie ipc;
 	struct rtable *rt = skb_rtable(skb);
 	struct net *net = dev_net(rt->dst.dev);
@@ -412,7 +415,7 @@ static void icmp_reply(struct icmp_bxm *icmp_param, struct sk_buff *skb)
 	int type = icmp_param->data.icmph.type;
 	int code = icmp_param->data.icmph.code;
 
-	if (ip_options_echo(net, &icmp_param->replyopts.opt.opt, skb))
+	if (ip_options_echo(net, opt, skb))
 		return;
 
 	/* Needed by both icmpv4_global_allow and icmp_xmit_lock */
@@ -436,7 +439,7 @@ static void icmp_reply(struct icmp_bxm *icmp_param, struct sk_buff *skb)
 	saddr = fib_compute_spec_dst(skb);
 
 	if (icmp_param->replyopts.opt.opt.optlen) {
-		ipc.opt = &icmp_param->replyopts.opt;
+		ipc.opt = (struct ip_options_rcu *)&icmp_param->replyopts.opt;
 		if (ipc.opt->opt.srr)
 			daddr = icmp_param->replyopts.opt.opt.faddr;
 	}
@@ -592,6 +595,7 @@ static struct rtable *icmp_route_lookup(struct net *net, struct flowi4 *fl4,
 void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
 		 const struct ip_options *opt)
 {
+	struct ip_options *opt_aux;
 	struct iphdr *iph;
 	int room;
 	struct icmp_bxm icmp_param;
@@ -605,6 +609,8 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
 	struct net *net;
 	struct sock *sk;
 
+	opt_aux = container_of(&icmp_param.replyopts.opt.opt, struct ip_options, __hdr);
+
 	if (!rt)
 		goto out;
 
@@ -719,7 +725,7 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
 					   iph->tos;
 	mark = IP4_REPLY_MARK(net, skb_in->mark);
 
-	if (__ip_options_echo(net, &icmp_param.replyopts.opt.opt, skb_in, opt))
+	if (__ip_options_echo(net, opt_aux, skb_in, opt))
 		goto out_unlock;
 
 
@@ -736,7 +742,7 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
 	inet_sk(sk)->tos = tos;
 	ipcm_init(&ipc);
 	ipc.addr = iph->saddr;
-	ipc.opt = &icmp_param.replyopts.opt;
+	ipc.opt = (struct ip_options_rcu *)&icmp_param.replyopts.opt;
 	ipc.sockc.mark = mark;
 
 	rt = icmp_route_lookup(net, &fl4, skb_in, iph, saddr,
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 0065b1996c94..17eeb3e09e95 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1604,6 +1604,7 @@ void ip_send_unicast_reply(struct sock *sk, const struct sock *orig_sk,
 			   unsigned int len, u64 transmit_time, u32 txhash)
 {
 	struct ip_options_data replyopts;
+	struct ip_options *opt;
 	struct ipcm_cookie ipc;
 	struct flowi4 fl4;
 	struct rtable *rt = skb_rtable(skb);
@@ -1612,7 +1613,9 @@ void ip_send_unicast_reply(struct sock *sk, const struct sock *orig_sk,
 	int err;
 	int oif;
 
-	if (__ip_options_echo(net, &replyopts.opt.opt, skb, sopt))
+	opt = container_of(&replyopts.opt.opt, struct ip_options, __hdr);
+
+	if (__ip_options_echo(net, opt, skb, sopt))
 		return;
 
 	ipcm_init(&ipc);
@@ -1620,7 +1623,7 @@ void ip_send_unicast_reply(struct sock *sk, const struct sock *orig_sk,
 	ipc.sockc.transmit_time = transmit_time;
 
 	if (replyopts.opt.opt.optlen) {
-		ipc.opt = &replyopts.opt;
+		ipc.opt = (struct ip_options_rcu *)&replyopts.opt;
 
 		if (replyopts.opt.opt.srr)
 			daddr = replyopts.opt.opt.faddr;
diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
index 619ddc087957..ef853dc3948f 100644
--- a/net/ipv4/ping.c
+++ b/net/ipv4/ping.c
@@ -753,7 +753,7 @@ static int ping_v4_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		if (inet_opt) {
 			memcpy(&opt_copy, inet_opt,
 			       sizeof(*inet_opt) + inet_opt->opt.optlen);
-			ipc.opt = &opt_copy.opt;
+			ipc.opt = (struct ip_options_rcu *)&opt_copy.opt;
 		}
 		rcu_read_unlock();
 	}
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index 0e9e01967ec9..cea8a559132f 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -563,7 +563,7 @@ static int raw_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		if (inet_opt) {
 			memcpy(&opt_copy, inet_opt,
 			       sizeof(*inet_opt) + inet_opt->opt.optlen);
-			ipc.opt = &opt_copy.opt;
+			ipc.opt = (struct ip_options_rcu *)&opt_copy.opt;
 		}
 		rcu_read_unlock();
 	}
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 0e24916b39d4..6ff2329aa0fa 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1159,7 +1159,7 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		if (inet_opt) {
 			memcpy(&opt_copy, inet_opt,
 			       sizeof(*inet_opt) + inet_opt->opt.optlen);
-			ipc.opt = &opt_copy.opt;
+			ipc.opt = (struct ip_options_rcu *)&opt_copy.opt;
 		}
 		rcu_read_unlock();
 	}
-- 
2.43.0


