Return-Path: <netdev+bounces-200966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF222AE78C0
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 09:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99DE83AD39D
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 07:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00CB21CA08;
	Wed, 25 Jun 2025 07:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="OPmdXB3P"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A79C21771B
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 07:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750836913; cv=none; b=R/+NJ7BZKIlf99QmJKJ0ZXiSxKi+P8tHZtrKSvy9AudhPSoBoGvziQArAufuhfvbgF2YraOjXiVkv9aL77R3tqtDr19lusbzrSFJTxWyJ62M2FooGWl06KwWag5EbyxT8yMRB4EgGYYHcEzquuK3K1IVJPO/D+6c+z3mGfnsyKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750836913; c=relaxed/simple;
	bh=fVPJGYpGo13cyVNCyrG7g5sozeL6ZwPRLxhh3YjGUbo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TGv4CiyGT8AeuS2/I9ABXr9dcoFMw3+2SJddvOnIQMTMJTPxg/CckEVNlCv7r2cmY+lDZ9wNjtLHamyvWQKie0HVKgicfAyouq4/NJ0ZUT2ImrOMbnGhrCLfezRhtwXFaLUtdbAnVRj3hVqr8rhJOz8D7a/Hexm6iwXu8xzLFA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=OPmdXB3P; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1750836907;
	bh=P4MHlClxF4AdcSZDqf76OvwgqgyaPuuaKRTPwiPtVbE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OPmdXB3P8GBZz1+yi/NJnW9YUjANWzIom1bUHgRpJSZd0bKS5Xw6I5SgLU+pwHARo
	 HQ66s3SkJC5nAUBhidgQmku9i+cTvUMriO+e8yncyTKR4BGKsm8pj1euPE3ErIgomX
	 7m7iLiz5VMOAdFDpxphL71LQWyf+PAXk8LbBZRAcpwxBAWNHvz4MkTJw3kgleTmBMq
	 AGht9pjFE/sED31271UyFv+GWd6LgOxWaa1ftq2eXyJDEKQSlbnz12Ar33TFPvYRrq
	 pykQVLEJ/tkV3AxNteIlSfgemBmWvB2USA7Lw3uG0vFd3RKyiAOtt+jFoaVSGyIILK
	 bQj3lmTyGbGoQ==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 7701169A44; Wed, 25 Jun 2025 15:35:07 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Wed, 25 Jun 2025 15:34:48 +0800
Subject: [PATCH net-next v3 10/14] net: mctp: pass net into route creation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-dev-forwarding-v3-10-2061bd3013b3@codeconstruct.com.au>
References: <20250625-dev-forwarding-v3-0-2061bd3013b3@codeconstruct.com.au>
In-Reply-To: <20250625-dev-forwarding-v3-0-2061bd3013b3@codeconstruct.com.au>
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


