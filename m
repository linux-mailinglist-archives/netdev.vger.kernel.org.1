Return-Path: <netdev+bounces-203198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B19AF0B88
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 08:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 673BE484509
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 06:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6CA22A4CC;
	Wed,  2 Jul 2025 06:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="CtMfIxCi"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F50224B01
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 06:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751437223; cv=none; b=Fto0nYcAgR3jUHXemwq0TUBc/nsUIxYNE1Mj0NUgXtnI+DmH44pyAa46UkyrWYPFcM9XVpSZLuQdwqwYzBE4sCiktosF8RBlyPxVGBGuz53IlHKDFO8XCaN8Fwl3RljwYR7GIq/4wDkvDZikddCs5UASEqSbxaowXT6r8xozoMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751437223; c=relaxed/simple;
	bh=fc9UaJ+S0flYVv5lJGrng7whu7POEeP+ASfDOlToMfA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ebgGVKSMiDCYhk3KF+QuxA5QxBbuxyHZAi1z6OzbadbfbzUWylUBTWudMCRK13pKrqHJcgMT9Gm0KtKtaTPhNASGd7DZS19OhJwkjiKeBpEMfgRytMejXBXtqyt4S1OwS0PrXVEU7xHWQ21oTDS4VF9SxXNmmLrCYPMfcBs2zXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=CtMfIxCi; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1751437218;
	bh=ED/eZzEiT+yM8lx/xq7ENBQCaeYyjdEOWRercGh3TsY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=CtMfIxCivhrPnd6ccroxHILIgerFv2LExlkrPqDINVkOHgYg8AUxWRdKIAysddxKl
	 1grqcRF/tiV9dsCluWZamDZM6Fx2mfHJFbYQC1DGF0wFDl+J7jCAHdz7b4xQP7rdSH
	 Adwz/caaO1UIsEtPMArTiMSV8DhP0sQTXr9xcN5KfYvaP65QIz32doofCORrp2ouS7
	 etlrvoZ5OoncVpJOu105MNCwurB36iJA8wNnMv+Lt/PPSIKAFqkh+1rEZXxaYjBEO3
	 +CGGZG7FEptYLhHSKXF87ZRNY37ueUtm0ZmCHIWfLVzimfp7Xw857imZeoJtcg4A0N
	 39QeYOLsZ/N3A==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 47F1D6A718; Wed,  2 Jul 2025 14:20:18 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Wed, 02 Jul 2025 14:20:11 +0800
Subject: [PATCH net-next v5 11/14] net: mctp: remove routes by netid, not
 by device
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-dev-forwarding-v5-11-1468191da8a4@codeconstruct.com.au>
References: <20250702-dev-forwarding-v5-0-1468191da8a4@codeconstruct.com.au>
In-Reply-To: <20250702-dev-forwarding-v5-0-1468191da8a4@codeconstruct.com.au>
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
index 66395f782759b6a2131342fda099fe5d7cdc4c38..f96265acf16f4ecedad7a3edf2367cfc7f56be7f 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -1085,6 +1085,11 @@ int mctp_local_output(struct sock *sk, struct mctp_dst *dst,
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
@@ -1137,7 +1142,7 @@ static int mctp_route_add(struct net *net, struct mctp_dev *mdev,
 	return 0;
 }
 
-static int mctp_route_remove(struct net *net, struct mctp_dev *mdev,
+static int mctp_route_remove(struct net *net, unsigned int netid,
 			     mctp_eid_t daddr_start, unsigned int daddr_extent,
 			     unsigned char type)
 {
@@ -1154,7 +1159,7 @@ static int mctp_route_remove(struct net *net, struct mctp_dev *mdev,
 	ASSERT_RTNL();
 
 	list_for_each_entry_safe(rt, tmp, &net->mctp.routes, list) {
-		if (rt->dev == mdev &&
+		if (mctp_route_netid(rt) == netid &&
 		    rt->min == daddr_start && rt->max == daddr_end &&
 		    rt->type == type) {
 			list_del_rcu(&rt->list);
@@ -1174,7 +1179,8 @@ int mctp_route_add_local(struct mctp_dev *mdev, mctp_eid_t addr)
 
 int mctp_route_remove_local(struct mctp_dev *mdev, mctp_eid_t addr)
 {
-	return mctp_route_remove(dev_net(mdev->dev), mdev, addr, 0, RTN_LOCAL);
+	return mctp_route_remove(dev_net(mdev->dev), mdev->net,
+				 addr, 0, RTN_LOCAL);
 }
 
 /* removes all entries for a given device */
@@ -1394,7 +1400,7 @@ static int mctp_delroute(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (rtm->rtm_type != RTN_UNICAST)
 		return -EINVAL;
 
-	rc = mctp_route_remove(net, mdev, daddr_start, rtm->rtm_dst_len,
+	rc = mctp_route_remove(net, mdev->net, daddr_start, rtm->rtm_dst_len,
 			       RTN_UNICAST);
 	return rc;
 }

-- 
2.39.5


