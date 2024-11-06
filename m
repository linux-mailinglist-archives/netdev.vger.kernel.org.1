Return-Path: <netdev+bounces-142210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A948E9BDD05
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 03:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE09B1C231B1
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 02:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849BC6BFCA;
	Wed,  6 Nov 2024 02:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="tBGelBdy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02001D07BA
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 02:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730859961; cv=none; b=aP9YCVvYaUhrqnkCRoH/aOEdMOTdpgNdI6l+z68/3o6kJpM/U/naDXa8zNC11qlxne5iyjBdtIuUS7R17cT+kPtniHMGO/3qgkq31i3fSyTXqAzo0P1//7QMB2o3zBaSHPXGPUCwH4iAsKpZWoVDOURCcf1WYFz3DRTKqdasF9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730859961; c=relaxed/simple;
	bh=yxr2qbDqAJ4Xzdb6xQNlV8ednU+o/lH/xOwvIMiIVeM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dwCnit3P4k1rNm3jWpQYx7c6Pf0fZITycwbxoajq7nRlCV46hkJpwhFKoPuBtDki7ZO7ulzASrj0fdMx26x62bhVsGxDZASbjhNqnAoq5N/QCB04Ch0+wNjrZL9sSqyvZ6d8toAbd/81VOFqfTaOy+YJP2TQrHZCUizDPOjFEOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=tBGelBdy; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730859960; x=1762395960;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5pwsnwiDhBU/WlQ/RecQn5yaBy7yH9gwb9G5l0uejjA=;
  b=tBGelBdy4uGTpbjz2icG1IvoYdFxU1cb3DJZi+XQhXkvwqFGPF/pPhmS
   UynZrxNKldF9v85YqA4Ega3VbfZOZKyRUdX0X5o2wsgP3U3ihxRh47+6e
   pKSPmCYMyvEXEUiNB7UAwc0cSYpKNG+/xPW4hKqjmw6MS1u9QFbUWwWks
   E=;
X-IronPort-AV: E=Sophos;i="6.11,261,1725321600"; 
   d="scan'208";a="2360173"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 02:25:58 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:22032]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.36:2525] with esmtp (Farcaster)
 id f7e9eb38-9c61-4dbd-8fc9-d323a5c532d1; Wed, 6 Nov 2024 02:25:58 +0000 (UTC)
X-Farcaster-Flow-ID: f7e9eb38-9c61-4dbd-8fc9-d323a5c532d1
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 6 Nov 2024 02:25:57 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.170.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 6 Nov 2024 02:25:54 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, Marc Kleine-Budde
	<mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Nikolay Aleksandrov <razor@blackwall.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 4/7] vxcan: Set VXCAN_INFO_PEER to vxcan_link_ops.peer_type.
Date: Tue, 5 Nov 2024 18:24:29 -0800
Message-ID: <20241106022432.13065-5-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241106022432.13065-1-kuniyu@amazon.com>
References: <20241106022432.13065-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWA004.ant.amazon.com (10.13.139.56) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

For per-netns RTNL, we need to prefetch the peer device's netns.

Let's set rtnl_link_ops.peer_type and accordingly remove duplicated
validation in ->newlink().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
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


