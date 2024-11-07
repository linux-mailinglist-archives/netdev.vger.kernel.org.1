Return-Path: <netdev+bounces-142624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 737219BFC92
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 03:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A9721F21EFA
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 02:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7487B182BC;
	Thu,  7 Nov 2024 02:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="N07W1maP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7D93D64
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 02:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730946721; cv=none; b=ql3TXLRlCjnEauSHBqD9r7Z9t6RJITw+J6ch65vPJRHuhIIISvtOShAG56D+DUV/M7Kh8i2tcYh9DFwxvMxho5n7GCjg6z4l3NGlWZG65p7okv5AXe4GwFBXbCgoV2SDqcfeIJN6Bk6HrBd8+T3NSHxw8fj6EoFRETUm+a7Yq0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730946721; c=relaxed/simple;
	bh=TipeN/Zwk+vqXfiwTMHk+ohfesChlz1qMgMCwG0qgCI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BOsyhF1RE3xNzhRL+jBkDaHUNl0sgwR6pex3DCOv8gKkb4WS8uTy9edrPq6DRM1r42nqTQeZgQFVE+SST/qyPFoCfb/QmqFv7TPfXruvHNNBfhOpmwcO6j0ytnjjwvGJuB4+MAmiosdsF2L5O5vGOvZrt/zCB3GJUb/Lnid9P44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=N07W1maP; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730946720; x=1762482720;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aGI/kgULl8F92GmH6o8NgXptxFo5MZCAVjnjSbjhhz4=;
  b=N07W1maPbL8XqVJ7u2LBtxX+yuMY2sVRAcOrv48xf7lPnkMKen8Cquvh
   DK66UIuRhicHgiptEFOZm70TIfgzB10Quaf2NAGFjUiIOkPLgP/dBCULs
   ozmvJE6hcIbj3xVjgYFxdY0VGMu1cWN5i26/yxUBjQkc1vIn4C/MdlGyW
   c=;
X-IronPort-AV: E=Sophos;i="6.11,264,1725321600"; 
   d="scan'208";a="693652274"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 02:31:56 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:55378]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.54.53:2525] with esmtp (Farcaster)
 id f697c952-0f93-490c-a608-70b4ede9be9b; Thu, 7 Nov 2024 02:31:55 +0000 (UTC)
X-Farcaster-Flow-ID: f697c952-0f93-490c-a608-70b4ede9be9b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 7 Nov 2024 02:31:55 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.101.27) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 7 Nov 2024 02:31:51 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, Marc Kleine-Budde
	<mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Nikolay Aleksandrov <razor@blackwall.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 08/10] netkit: Set IFLA_NETKIT_PEER_INFO to netkit_link_ops.peer_type.
Date: Wed, 6 Nov 2024 18:28:58 -0800
Message-ID: <20241107022900.70287-9-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241107022900.70287-1-kuniyu@amazon.com>
References: <20241107022900.70287-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB001.ant.amazon.com (10.13.138.119) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

For per-netns RTNL, we need to prefetch the peer device's netns.

Let's set rtnl_link_ops.peer_type and accordingly remove duplicated
validation in ->newlink().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 drivers/net/netkit.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index cd8360b9bbde..bb07725d1c72 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -351,12 +351,7 @@ static int netkit_new_link(struct net *src_net, struct net_device *dev,
 		if (data[IFLA_NETKIT_PEER_INFO]) {
 			attr = data[IFLA_NETKIT_PEER_INFO];
 			ifmp = nla_data(attr);
-			err = rtnl_nla_parse_ifinfomsg(peer_tb, attr, extack);
-			if (err < 0)
-				return err;
-			err = netkit_validate(peer_tb, NULL, extack);
-			if (err < 0)
-				return err;
+			rtnl_nla_parse_ifinfomsg(peer_tb, attr, extack);
 			tbp = peer_tb;
 		}
 		if (data[IFLA_NETKIT_SCRUB])
@@ -391,9 +386,6 @@ static int netkit_new_link(struct net *src_net, struct net_device *dev,
 		return -EOPNOTSUPP;
 
 	net = rtnl_link_get_net(src_net, tbp);
-	if (IS_ERR(net))
-		return PTR_ERR(net);
-
 	peer = rtnl_create_link(net, ifname, ifname_assign_type,
 				&netkit_link_ops, tbp, extack);
 	if (IS_ERR(peer)) {
@@ -978,6 +970,7 @@ static struct rtnl_link_ops netkit_link_ops = {
 	.fill_info	= netkit_fill_info,
 	.policy		= netkit_policy,
 	.validate	= netkit_validate,
+	.peer_type	= IFLA_NETKIT_PEER_INFO,
 	.maxtype	= IFLA_NETKIT_MAX,
 };
 
-- 
2.39.5 (Apple Git-154)


