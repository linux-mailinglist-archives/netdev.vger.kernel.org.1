Return-Path: <netdev+bounces-196429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D82AD4BC6
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 08:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2498189A27C
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 06:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C585230BFC;
	Wed, 11 Jun 2025 06:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="MGmqLo7T"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7634822FDE2
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 06:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749623466; cv=none; b=AuYZs3+x7HUBlRvfczpEQANUhmchORezbhpxhgBDUtpvoRGu4+VzawYslm+CE6+1LyQ8m5Vy/zysBGxx+7W3KGNgJcUcJXbfnKOYP+5OekylqGcMS3drdKJGhY8Z/Z/4n9L1gLOhn0NPg73CW2SOsNz/fQX192uCPG3gMOoxdFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749623466; c=relaxed/simple;
	bh=TsCEVJSbAG4Ui9UU7KbJEf0wpBgmVpLIPdk5MB9uO+Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m/GCRDmBzGvdkH+EOTDOtWjrdypSWT+qWm0HCfpcjCrhRU74cuJ+lXduH573YG9qyzUCzCd5XcGszHXf6ZcfYfHTGQWDVg1xRiotJLRlZnPK1lKSYJWV0/Ud0MuVoJuaqy7EL7OnYBGbnLcqaqBTDzifwIhSa2cbPBSAPJlhApU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=MGmqLo7T; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1749623460;
	bh=R/iBcO0Na5B85cl0hG3FHnOdxLFLdGi9Q11jSvY6nw4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=MGmqLo7TpaAf5ih52710ISzlVbAzhzuz0ur8i+uWT7wMBT7cCUBRdk3CMB3DWisoK
	 MtLeowNbNzcU2PW8niFIZANKR3La9bU+S80gSA+yW7U31p7cA69oSRurqxkl4X84as
	 GighLEVr3HVEFThb2fwqjznUTq4OvxOOiKVM19Q4Cxv+3pknfdfbzZapDfIDlGOadt
	 EP4N4DX+IE/2eU7/AVJnZ6u2KKu/RoFaM2dKLB7mKQA1QxqfYQN3hKu0mnooyLFuLX
	 EIh6yobUoFVmUdeskgvOxMbnSwFTUiQqBF9suYiDjd68YsPZDbeq3g4kPeR0qQggp6
	 dMNqMd09D7IGg==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id B885167DE9; Wed, 11 Jun 2025 14:31:00 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Wed, 11 Jun 2025 14:30:37 +0800
Subject: [PATCH net-next 10/13] net: mctp: remove routes by netid, not by
 device
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-dev-forwarding-v1-10-6b69b1feb37f@codeconstruct.com.au>
References: <20250611-dev-forwarding-v1-0-6b69b1feb37f@codeconstruct.com.au>
In-Reply-To: <20250611-dev-forwarding-v1-0-6b69b1feb37f@codeconstruct.com.au>
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


