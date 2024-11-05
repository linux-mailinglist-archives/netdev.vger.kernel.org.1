Return-Path: <netdev+bounces-141753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE409BC2E9
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 03:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A6821C21E91
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 02:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5E23B784;
	Tue,  5 Nov 2024 02:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="fIdSwGA0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510F42C190
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 02:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730772426; cv=none; b=oPS229ZnX4mM+RCwmJ2GQmHxtwYhOkaYN32r+3wV0s1GYwLmaGJD4m8eg4QjfBt9b8NyFrnVJPzE0n7CCWV/LXsDhSYtq3DcX+EYUeKNEhgz016dU2mHvJ/36xpbPaU7pqxxp8/aN/DNVxVmN/ZnM/ug5VsdyDuOuzX0medyV6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730772426; c=relaxed/simple;
	bh=+dYTXvFM0m+GJ4bNPfsfMh+016PKWrL5rhncGkIcgTw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JUyRKlAuf3jU9wxx3WY3HfUZXeBxm9+ZMus8vpNVTodj/GnhcdWjKPz1Rt6bQ8cWSfojpAN63+u/p0gd2vSIWagGbf6tkH+ngX1id3SO/liv8lKV81esTR0lbU6/pQ0bXfKxmM42aXRnJCzZmv9FOgvimukBbG8AyBl7mGx102I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=fIdSwGA0; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730772424; x=1762308424;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HzwLg/FTOsOq82qYcqbKjZ7cSFgOyBeOAzcJaaDKdJA=;
  b=fIdSwGA0uyKCi5qcOpqz/h8oWrUymxMeSwzcTOXlfAxjQ12hhbHxxznJ
   LvscAvdb7pOP474EgYzeZk2oLp9Wy6YlF7Zokvf01OQK+K5YWaLfDOVR1
   YFB8YdpN5QOS8+YzqrRZPLf9oTKKFOpaIIHbz+57J/NDo06wUcPHp0QEE
   A=;
X-IronPort-AV: E=Sophos;i="6.11,258,1725321600"; 
   d="scan'208";a="437215404"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 02:07:01 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:19869]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.36:2525] with esmtp (Farcaster)
 id 07c728ba-7d8f-402b-9887-ed0dcbf288c2; Tue, 5 Nov 2024 02:07:00 +0000 (UTC)
X-Farcaster-Flow-ID: 07c728ba-7d8f-402b-9887-ed0dcbf288c2
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 5 Nov 2024 02:06:59 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.171.42) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 5 Nov 2024 02:06:56 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, Marc Kleine-Budde
	<mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Nikolay Aleksandrov <razor@blackwall.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 5/8] vxcan: Set VXCAN_INFO_PEER to vxcan_link_ops.peer_type.
Date: Mon, 4 Nov 2024 18:05:11 -0800
Message-ID: <20241105020514.41963-6-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241105020514.41963-1-kuniyu@amazon.com>
References: <20241105020514.41963-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWA004.ant.amazon.com (10.13.139.93) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

For per-netns RTNL, we need to prefetch the peer device's netns.

Let's set rtnl_link_ops.peer_type and accordingly remove duplicated
validation in ->newlink().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
Note for CAN maintainers, this patch needs to go through net-next
directly as the later patch depends on this.
---
 drivers/net/can/vxcan.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
index 9e1b7d41005f..da7c72105fb6 100644
--- a/drivers/net/can/vxcan.c
+++ b/drivers/net/can/vxcan.c
@@ -188,14 +188,10 @@ static int vxcan_newlink(struct net *net, struct net_device *dev,
 
 	/* register peer device */
 	if (data && data[VXCAN_INFO_PEER]) {
-		struct nlattr *nla_peer;
+		struct nlattr *nla_peer = data[VXCAN_INFO_PEER];
 
-		nla_peer = data[VXCAN_INFO_PEER];
 		ifmp = nla_data(nla_peer);
-		err = rtnl_nla_parse_ifinfomsg(peer_tb, nla_peer, extack);
-		if (err < 0)
-			return err;
-
+		rtnl_nla_parse_ifinfomsg(peer_tb, nla_peer, extack);
 		tbp = peer_tb;
 	}
 
@@ -208,9 +204,6 @@ static int vxcan_newlink(struct net *net, struct net_device *dev,
 	}
 
 	peer_net = rtnl_link_get_net(net, tbp);
-	if (IS_ERR(peer_net))
-		return PTR_ERR(peer_net);
-
 	peer = rtnl_create_link(peer_net, ifname, name_assign_type,
 				&vxcan_link_ops, tbp, extack);
 	if (IS_ERR(peer)) {
@@ -302,6 +295,7 @@ static struct rtnl_link_ops vxcan_link_ops = {
 	.newlink	= vxcan_newlink,
 	.dellink	= vxcan_dellink,
 	.policy		= vxcan_policy,
+	.peer_type	= VXCAN_INFO_PEER,
 	.maxtype	= VXCAN_INFO_MAX,
 	.get_link_net	= vxcan_get_link_net,
 };
-- 
2.39.5 (Apple Git-154)


