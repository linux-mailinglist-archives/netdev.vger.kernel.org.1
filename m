Return-Path: <netdev+bounces-199371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7254ADFF5B
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 10:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FDA017CC8A
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 08:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4082609D0;
	Thu, 19 Jun 2025 08:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="DfDopt1M"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D5025E827
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 08:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750320075; cv=none; b=dZf5/aXEn4IStnC9HFMfuJFdIW+3vMB1S4RhtOgRTSODKof0dhyPTtlAf+hx9WCcTTZBv8P/zfrV39cOC/EBYVzBUs4hll1lmalsVyuB48sHCC687iGY7KOCIgPNIyVtEDfFLSN1Kf8CzjNJBf7+N8Y4v7OSCRMt+ynokRFO4qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750320075; c=relaxed/simple;
	bh=fVPJGYpGo13cyVNCyrG7g5sozeL6ZwPRLxhh3YjGUbo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=trviap4Fi9McktvDsvcLHUrOqwwM1G4oOObVsCo9oK3X7/D4cFKeH8gE5jIxSAdtolwshmZy9dOFjfd8cR5aTwTdjdQL3Xfl3HOk21sDJb5kOGHRVSKK/WxK95PX0iibNPNM9lPh104FdkwxyEzxaVNocZSrbZeCoUYFNp+mr7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=DfDopt1M; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1750320063;
	bh=P4MHlClxF4AdcSZDqf76OvwgqgyaPuuaKRTPwiPtVbE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=DfDopt1MxFBm6VA5qXb0zCtKjJRQfKJi8oux70NBRUJLujOie/aqRx+LmL2q0Vchr
	 4JHXp5bjY9HxlU4m6UsFfn4K/2r096E/zzSAUvZeE2kNs7ScLz/sn9hzAkNuJnBFqw
	 lwoNY5ZI5MwYaDcLxDQJKWP9F+ffoFNwNzpDQFeNZhoUr25spJ6R8guKA7nP0Xtufb
	 4mhcMtsYrayDa7Ma/5N5X2G8bRqiboi2ebLKD5I6FoW77LOcHSjezDviDGdbuGZI1b
	 TGExLCtVv35AOd0sEjfrtrzp8tvNV+nE9u6M0uwl8LRQN0N8qCRrOEddTjvpLqTsbO
	 SPVRV6sXW9vug==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 17BA268ECA; Thu, 19 Jun 2025 16:01:03 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Thu, 19 Jun 2025 16:00:44 +0800
Subject: [PATCH net-next v2 09/13] net: mctp: pass net into route creation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250619-dev-forwarding-v2-9-3f81801b06c2@codeconstruct.com.au>
References: <20250619-dev-forwarding-v2-0-3f81801b06c2@codeconstruct.com.au>
In-Reply-To: <20250619-dev-forwarding-v2-0-3f81801b06c2@codeconstruct.com.au>
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


