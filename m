Return-Path: <netdev+bounces-201814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDD1AEB1BA
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 10:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D7C05611E8
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 08:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CC4283C91;
	Fri, 27 Jun 2025 08:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="CPYhv9dw"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598ED28153D
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 08:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751014374; cv=none; b=qS5gUaqYb01SJGksbNMAYtmrpxp5BCJ+uAsjoQG3it+hoRXx1OC3iJw6wsMF0SNlTJ6tbYL7dgPp9vI9IWIaT1kIEnovJuFNH3xC0fnHzGuO6w7XjOx5bduFSdsNb0U29ier54CmbcHslbMrl/hAz3HAClqLZ2KdgvXll7mjKlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751014374; c=relaxed/simple;
	bh=TsCEVJSbAG4Ui9UU7KbJEf0wpBgmVpLIPdk5MB9uO+Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oV8z4K7GboJeH1P1l/59XEmUZWZXCBwIM14xrtbuo2jFBEObCffeFuH/o+rOpyysAhC30XX/5Q6+sjFr0tduaXyyFCSx17TnBd+tU8NmU2Ctp0GvWvuhPMeU5lApuopnll08MZXiWVRHA9rJOARBmVwgAJ2IlqyiZdM6ZCtdapY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=CPYhv9dw; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1751014369;
	bh=R/iBcO0Na5B85cl0hG3FHnOdxLFLdGi9Q11jSvY6nw4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=CPYhv9dwA0LgLpQj9SQLLdLIalxTTXXbBIQKzNOS6VjymNdNErYfCmzGFIRg3tF7Y
	 R/sq3znCaGPxL+4AktHWopWklAzxSDorZdsNS4iOlWSYe26WY9uOYCvPDXwip8Zb5F
	 /5elUUlBd1ewQqG2RPeXoiTLvl756Lz3t11Vqn4LfaKmA7eUdsk+TpBSyFRcjvii1X
	 ZvzUZBkjX21+QdeAJtf0Vc94KeZR2IzDaxQb3Ct2HHngiEdiLWExm9lJnrmGtXEUlO
	 U3oY/MDetHYs1Q1ZUYO9fm2LjSbL97hM57L5y739oyrAcYj7dmeDXxjQfxrC8NkJFJ
	 61b6OOpxwGxOQ==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 0070569E29; Fri, 27 Jun 2025 16:52:48 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Fri, 27 Jun 2025 16:52:27 +0800
Subject: [PATCH net-next v4 11/14] net: mctp: remove routes by netid, not
 by device
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-dev-forwarding-v4-11-72bb3cabc97c@codeconstruct.com.au>
References: <20250627-dev-forwarding-v4-0-72bb3cabc97c@codeconstruct.com.au>
In-Reply-To: <20250627-dev-forwarding-v4-0-72bb3cabc97c@codeconstruct.com.au>
To: Matt Johnston <matt@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
X-Mailer: b4 0.14.2

In upcoming changes, a route may not have a device associated. Since the
route is matched on the (network, eid) tuple, pass the netid itself into
mctp_route_remove.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 net/mctp/route.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/mctp/route.c b/net/mctp/route.c
index c2495e2073c6946c3517b525b5d49b93fbfdd81f..1731cabcc30780226d39e6e0716346f7acb5bd7e 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -1080,6 +1080,11 @@ int mctp_local_output(struct sock *sk, struct mctp_dst *dst,
 	return rc;
 }
 
+static unsigned int mctp_route_netid(struct mctp_route *rt)
+{
+	return rt->dev->net;
+}
+
 /* route management */
 static int mctp_route_add(struct net *net, struct mctp_dev *mdev,
 			  mctp_eid_t daddr_start, unsigned int daddr_extent,
@@ -1132,7 +1137,7 @@ static int mctp_route_add(struct net *net, struct mctp_dev *mdev,
 	return 0;
 }
 
-static int mctp_route_remove(struct net *net, struct mctp_dev *mdev,
+static int mctp_route_remove(struct net *net, unsigned int netid,
 			     mctp_eid_t daddr_start, unsigned int daddr_extent,
 			     unsigned char type)
 {
@@ -1149,7 +1154,7 @@ static int mctp_route_remove(struct net *net, struct mctp_dev *mdev,
 	ASSERT_RTNL();
 
 	list_for_each_entry_safe(rt, tmp, &net->mctp.routes, list) {
-		if (rt->dev == mdev &&
+		if (mctp_route_netid(rt) == netid &&
 		    rt->min == daddr_start && rt->max == daddr_end &&
 		    rt->type == type) {
 			list_del_rcu(&rt->list);
@@ -1169,7 +1174,8 @@ int mctp_route_add_local(struct mctp_dev *mdev, mctp_eid_t addr)
 
 int mctp_route_remove_local(struct mctp_dev *mdev, mctp_eid_t addr)
 {
-	return mctp_route_remove(dev_net(mdev->dev), mdev, addr, 0, RTN_LOCAL);
+	return mctp_route_remove(dev_net(mdev->dev), mdev->net,
+				 addr, 0, RTN_LOCAL);
 }
 
 /* removes all entries for a given device */
@@ -1389,7 +1395,7 @@ static int mctp_delroute(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (rtm->rtm_type != RTN_UNICAST)
 		return -EINVAL;
 
-	rc = mctp_route_remove(net, mdev, daddr_start, rtm->rtm_dst_len,
+	rc = mctp_route_remove(net, mdev->net, daddr_start, rtm->rtm_dst_len,
 			       RTN_UNICAST);
 	return rc;
 }

-- 
2.39.5


