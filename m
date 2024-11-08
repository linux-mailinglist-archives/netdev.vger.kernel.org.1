Return-Path: <netdev+bounces-143120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 288949C1350
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 01:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A2001C21B98
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 00:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9713D3D6D;
	Fri,  8 Nov 2024 00:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="qhs3Z0/2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA3A1C36
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 00:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731027072; cv=none; b=WYDFcjStYlgbFkNTATdqZhrVixXgh4XkkDqSWDIILwjrFLrr+oSCf0MGfgeTL7b4f3mG2+Dp+0cZpMrEgMVhViUbPF78Ly1bqV4DrH1XObFuCFEkCQOjaf3IAdY+xsGkqgVx5m+Ki1V6G5WS0qNtwM3ANcmXUqTHu/nMeh5tQ1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731027072; c=relaxed/simple;
	bh=TipeN/Zwk+vqXfiwTMHk+ohfesChlz1qMgMCwG0qgCI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RB1VvdiskYGQvacwswA/YpFCkfAvPvc3qDJzLBTxjI25FniVdhPqNcLv4NdFEkxhet6MBEmSFufRTMa5QaqUb80iPds3H6p/fctR1n61R1BTZThnWIVJQThRa4awnSOLLTPBvgwqGLe8PJtpgd3DOBXbinPdecwrR6VtW4FTVg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=qhs3Z0/2; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1731027072; x=1762563072;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aGI/kgULl8F92GmH6o8NgXptxFo5MZCAVjnjSbjhhz4=;
  b=qhs3Z0/2gDQsK4GtcHwrkXNgM9pQOeB93rbdaNcorIZtVo1X/7dFDvFt
   2/IXa0MW+Q3GrhuNeCrXNfYZMb+tc2jKwUY9gzOjzqKaQeHGgQWlW5YG9
   xsKmfDpfBpICrlZhj/aEw5OWxScwpOMoUeiebLni2Nn4+EpZBojPRrwhH
   8=;
X-IronPort-AV: E=Sophos;i="6.12,136,1728950400"; 
   d="scan'208";a="39875554"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.124.125.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 00:51:10 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:7242]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.1.168:2525] with esmtp (Farcaster)
 id 96dfa6a4-5b6d-40a3-ac22-efe39daf5528; Fri, 8 Nov 2024 00:51:08 +0000 (UTC)
X-Farcaster-Flow-ID: 96dfa6a4-5b6d-40a3-ac22-efe39daf5528
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 8 Nov 2024 00:51:08 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.170.59) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 8 Nov 2024 00:51:05 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, Marc Kleine-Budde
	<mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Nikolay Aleksandrov <razor@blackwall.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH RESEND v3 net-next 08/10] netkit: Set IFLA_NETKIT_PEER_INFO to netkit_link_ops.peer_type.
Date: Thu, 7 Nov 2024 16:48:21 -0800
Message-ID: <20241108004823.29419-9-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241108004823.29419-1-kuniyu@amazon.com>
References: <20241108004823.29419-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB003.ant.amazon.com (10.13.138.8) To
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


