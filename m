Return-Path: <netdev+bounces-201812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E83AEB1B5
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 10:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D96E71BC6E3B
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 08:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED11283141;
	Fri, 27 Jun 2025 08:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="Hb3pe8jM"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10733281532
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 08:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751014373; cv=none; b=BBGNvZXTtsp9xYQ4MeOwr7qzp8HpfwY26wVyvvJqclQlhTZa0zztcL4v7t1dowCzhNQHMJLcS2eVDVHWmgKiWCu5coEZ84oQoBSEfp9u86gQJJDQyNH7uaktyaYTnAsTnWQh39Zc3Fh1xkdeNGKALdKeT6+/vYXK27fSmEUVDvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751014373; c=relaxed/simple;
	bh=fVPJGYpGo13cyVNCyrG7g5sozeL6ZwPRLxhh3YjGUbo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NFtbeZGqfe5vV5B73auxChj9kEyzAJxFen/y3o97E6bNJcHi4I/l45HIJQjnN0xUdItP49zt2O0gbsoDzlCJ9ljM0yNAb2gcqgNerL6xR5SVxMs0wd4FxNwTnn176xSH3cFv9K2MFGI1ywFqXYTmqJKWka7nRkdta0a6vCbZocQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=Hb3pe8jM; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1751014368;
	bh=P4MHlClxF4AdcSZDqf76OvwgqgyaPuuaKRTPwiPtVbE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Hb3pe8jML1gPBIgF0cCGieiBD8PQZCiwzqminFe/XeFY4JailJ53s8lJkoaKVlqb3
	 ZIaTCgVXeOp5KFGXfOIz+kMxXzpazZaSiM5WZr9Mf5R+8FsfWt1qn+lMQZvJ/50M9t
	 O4CYgHGb04TSjVXh+AWBdVXgGLO1LSGNUss7Fsg4u4Fctnp8q2x3PqlOkf82K0UsNg
	 eJKXV6P2WILQ8IvrhkE2sFqz++3kq1uGzpPV1ib54lhsB6R5ZP6Lk96UJE8qqFvxmh
	 hV/zAb2WwXoQQeF+WTEkf0rSuli6qftvT3Q8UnrRN5CQE+8m6eB/YrS8k1PRvjDz4d
	 YS76oMMBbC2Qw==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id A06FD69E28; Fri, 27 Jun 2025 16:52:48 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Fri, 27 Jun 2025 16:52:26 +0800
Subject: [PATCH net-next v4 10/14] net: mctp: pass net into route creation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-dev-forwarding-v4-10-72bb3cabc97c@codeconstruct.com.au>
References: <20250627-dev-forwarding-v4-0-72bb3cabc97c@codeconstruct.com.au>
In-Reply-To: <20250627-dev-forwarding-v4-0-72bb3cabc97c@codeconstruct.com.au>
To: Matt Johnston <matt@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
X-Mailer: b4 0.14.2

We may not have a mdev pointer, from which we currently extract the net.

Instead, pass the net directly.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 net/mctp/route.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/net/mctp/route.c b/net/mctp/route.c
index 23158f6d2d6e63a8a51adfde52a62d374bc23545..c2495e2073c6946c3517b525b5d49b93fbfdd81f 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -1081,12 +1081,11 @@ int mctp_local_output(struct sock *sk, struct mctp_dst *dst,
 }
 
 /* route management */
-static int mctp_route_add(struct mctp_dev *mdev, mctp_eid_t daddr_start,
-			  unsigned int daddr_extent, unsigned int mtu,
-			  unsigned char type)
+static int mctp_route_add(struct net *net, struct mctp_dev *mdev,
+			  mctp_eid_t daddr_start, unsigned int daddr_extent,
+			  unsigned int mtu, unsigned char type)
 {
 	int (*rtfn)(struct mctp_dst *dst, struct sk_buff *skb);
-	struct net *net = dev_net(mdev->dev);
 	struct mctp_route *rt, *ert;
 
 	if (!mctp_address_unicast(daddr_start))
@@ -1133,10 +1132,10 @@ static int mctp_route_add(struct mctp_dev *mdev, mctp_eid_t daddr_start,
 	return 0;
 }
 
-static int mctp_route_remove(struct mctp_dev *mdev, mctp_eid_t daddr_start,
-			     unsigned int daddr_extent, unsigned char type)
+static int mctp_route_remove(struct net *net, struct mctp_dev *mdev,
+			     mctp_eid_t daddr_start, unsigned int daddr_extent,
+			     unsigned char type)
 {
-	struct net *net = dev_net(mdev->dev);
 	struct mctp_route *rt, *tmp;
 	mctp_eid_t daddr_end;
 	bool dropped;
@@ -1165,12 +1164,12 @@ static int mctp_route_remove(struct mctp_dev *mdev, mctp_eid_t daddr_start,
 
 int mctp_route_add_local(struct mctp_dev *mdev, mctp_eid_t addr)
 {
-	return mctp_route_add(mdev, addr, 0, 0, RTN_LOCAL);
+	return mctp_route_add(dev_net(mdev->dev), mdev, addr, 0, 0, RTN_LOCAL);
 }
 
 int mctp_route_remove_local(struct mctp_dev *mdev, mctp_eid_t addr)
 {
-	return mctp_route_remove(mdev, addr, 0, RTN_LOCAL);
+	return mctp_route_remove(dev_net(mdev->dev), mdev, addr, 0, RTN_LOCAL);
 }
 
 /* removes all entries for a given device */
@@ -1279,12 +1278,11 @@ static const struct nla_policy rta_mctp_policy[RTA_MAX + 1] = {
 /* Common part for RTM_NEWROUTE and RTM_DELROUTE parsing.
  * tb must hold RTA_MAX+1 elements.
  */
-static int mctp_route_nlparse(struct sk_buff *skb, struct nlmsghdr *nlh,
+static int mctp_route_nlparse(struct net *net, struct nlmsghdr *nlh,
 			      struct netlink_ext_ack *extack,
 			      struct nlattr **tb, struct rtmsg **rtm,
 			      struct mctp_dev **mdev, mctp_eid_t *daddr_start)
 {
-	struct net *net = sock_net(skb->sk);
 	struct net_device *dev;
 	unsigned int ifindex;
 	int rc;
@@ -1338,6 +1336,7 @@ static const struct nla_policy rta_metrics_policy[RTAX_MAX + 1] = {
 static int mctp_newroute(struct sk_buff *skb, struct nlmsghdr *nlh,
 			 struct netlink_ext_ack *extack)
 {
+	struct net *net = sock_net(skb->sk);
 	struct nlattr *tb[RTA_MAX + 1];
 	struct nlattr *tbx[RTAX_MAX + 1];
 	mctp_eid_t daddr_start;
@@ -1346,7 +1345,7 @@ static int mctp_newroute(struct sk_buff *skb, struct nlmsghdr *nlh,
 	unsigned int mtu;
 	int rc;
 
-	rc = mctp_route_nlparse(skb, nlh, extack, tb,
+	rc = mctp_route_nlparse(net, nlh, extack, tb,
 				&rtm, &mdev, &daddr_start);
 	if (rc < 0)
 		return rc;
@@ -1366,7 +1365,7 @@ static int mctp_newroute(struct sk_buff *skb, struct nlmsghdr *nlh,
 			mtu = nla_get_u32(tbx[RTAX_MTU]);
 	}
 
-	rc = mctp_route_add(mdev, daddr_start, rtm->rtm_dst_len, mtu,
+	rc = mctp_route_add(net, mdev, daddr_start, rtm->rtm_dst_len, mtu,
 			    rtm->rtm_type);
 	return rc;
 }
@@ -1374,13 +1373,14 @@ static int mctp_newroute(struct sk_buff *skb, struct nlmsghdr *nlh,
 static int mctp_delroute(struct sk_buff *skb, struct nlmsghdr *nlh,
 			 struct netlink_ext_ack *extack)
 {
+	struct net *net = sock_net(skb->sk);
 	struct nlattr *tb[RTA_MAX + 1];
 	mctp_eid_t daddr_start;
 	struct mctp_dev *mdev;
 	struct rtmsg *rtm;
 	int rc;
 
-	rc = mctp_route_nlparse(skb, nlh, extack, tb,
+	rc = mctp_route_nlparse(net, nlh, extack, tb,
 				&rtm, &mdev, &daddr_start);
 	if (rc < 0)
 		return rc;
@@ -1389,7 +1389,8 @@ static int mctp_delroute(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (rtm->rtm_type != RTN_UNICAST)
 		return -EINVAL;
 
-	rc = mctp_route_remove(mdev, daddr_start, rtm->rtm_dst_len, RTN_UNICAST);
+	rc = mctp_route_remove(net, mdev, daddr_start, rtm->rtm_dst_len,
+			       RTN_UNICAST);
 	return rc;
 }
 

-- 
2.39.5


