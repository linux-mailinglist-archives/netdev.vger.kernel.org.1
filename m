Return-Path: <netdev+bounces-196430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8653AD4BC8
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 08:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60BC2189A44C
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 06:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AD5228CA5;
	Wed, 11 Jun 2025 06:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="V8pB8j4Y"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B9022FAF8
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 06:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749623466; cv=none; b=Nv44a3sRBX5jFr+fSKFiZ8jvI1t4IUlXgG3OAvUseD4Hz2z+4bdovR8DtHqLCfYttn5+DvFu4NcBX4wF4OLLicdfvMHDRVTYz0rU4T9yybS9m4uBTcWkIAgkY1IlKV2cWhn31hUx7r8/AxwThZv4XE8+J2azEKt1lM1zRYgD/pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749623466; c=relaxed/simple;
	bh=fVPJGYpGo13cyVNCyrG7g5sozeL6ZwPRLxhh3YjGUbo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S+uAD59DlVKTqzJunMp9nhUyGtizwhjqpglTNF25ao2VIjkc1WHm2WNQ1qn4Nf+jcUAHPwsqnnnmbNqczqYvRNSIItZAVmeM6XuTFmtIftcKlVCeB6bY2+TWtZjAqFz2VMgyYB2uSKSAP59wrUwB47crii+hbW37mEAC2vBVj8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=V8pB8j4Y; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1749623460;
	bh=P4MHlClxF4AdcSZDqf76OvwgqgyaPuuaKRTPwiPtVbE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=V8pB8j4YaExNv5kbcC1hPHQT+sL4RdQ9wiuGDlsFrM3pOWKctFRAYw5176yCCk7W6
	 lKRqKTQ6/FKh44Mf4pqkIua7z3g1ySSbVCCOO22u259Q4bt14ErJ0wKqWHAkNtrZAZ
	 aEOjXcjiPPEDyGGg3QOODzjc+DI2XEuQMZc40Iac5/ucPiXqqgbUdiGltOc1eIwZGb
	 6jpZ7rocJA553r5uqDltJHBEbGn19NKz8u6NEr7TxiWdDhlW3QDpcnMAQTZWY8Ux+X
	 WHmokDYkSfx5X7FbK7iBHB8w2VQ4Y409sDZSRjXZliod4fjh3kviuR48jCm7+dY2px
	 A/wBf8FQWM9EQ==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 7301C67DE6; Wed, 11 Jun 2025 14:31:00 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Wed, 11 Jun 2025 14:30:36 +0800
Subject: [PATCH net-next 09/13] net: mctp: pass net into route creation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-dev-forwarding-v1-9-6b69b1feb37f@codeconstruct.com.au>
References: <20250611-dev-forwarding-v1-0-6b69b1feb37f@codeconstruct.com.au>
In-Reply-To: <20250611-dev-forwarding-v1-0-6b69b1feb37f@codeconstruct.com.au>
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


