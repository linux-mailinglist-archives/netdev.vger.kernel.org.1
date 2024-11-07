Return-Path: <netdev+bounces-142623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 858AA9BFC91
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 03:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1140FB20E6C
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 02:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69ECF17C60;
	Thu,  7 Nov 2024 02:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="TvTeJEp7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55863D64
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 02:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730946699; cv=none; b=fPn4TsxJdKG1uol8anggeXDpgv6+qlm54bOBIjLyrVh3USMWZ8egcKg4M5pH4vfltVSLaEF7BZFyYomJcdYeg19PZmV5ksFBlcwi70jDyZZB4VPFMKny3fxgLFyF4q1Zr2Ji17R+GDs1Y+l5R4sq+JtKdQIsmV7RvyWBv3k8XBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730946699; c=relaxed/simple;
	bh=uCkJIOSbT5Z/Z4EG5WjP5jW7tBAuoKG5ypmNp8Fi8K0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ePSjC0lK/TEuIayD/hgQPF5AUq6k+CndJtIcprn4juJRkucmgByKTadSiCfRwowLMBAXcN0ssILL4tpTYsascoqz4CQwA2ctKBtcafB4N8lixhewaieCOtbfyBmYZzInLcQAwAvl8kIh1BTtZFXQh57+mBPAvlMQstis0bPHVAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=TvTeJEp7; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730946698; x=1762482698;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a8XBjXXLlxCEB0GXnyq34/w9BAVrQP5ltvZv/yCsyhk=;
  b=TvTeJEp7FxSKviDfEsLO/ZWQuK9h5DbOfkUSSRn6wXNIFZPZ/hNJKu++
   57RZt4AI2RGNkdHRfZ2tMoePTEX4EfpciSa8Lsrz8UZb3dob0q8kF7ddP
   e+M5yxlSUfp2wBC4EnfEcHBWSJs+KFolMwgglY5ZPt59X3papqPap4YUB
   k=;
X-IronPort-AV: E=Sophos;i="6.11,264,1725321600"; 
   d="scan'208";a="437827659"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 02:31:36 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:44476]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.17.195:2525] with esmtp (Farcaster)
 id 13dbab45-3baf-48e3-90ce-b66568070f0c; Thu, 7 Nov 2024 02:31:35 +0000 (UTC)
X-Farcaster-Flow-ID: 13dbab45-3baf-48e3-90ce-b66568070f0c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 7 Nov 2024 02:31:34 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.101.27) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 7 Nov 2024 02:31:31 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, Marc Kleine-Budde
	<mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Nikolay Aleksandrov <razor@blackwall.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 07/10] vxcan: Set VXCAN_INFO_PEER to vxcan_link_ops.peer_type.
Date: Wed, 6 Nov 2024 18:28:57 -0800
Message-ID: <20241107022900.70287-8-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D044UWA002.ant.amazon.com (10.13.139.11) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

For per-netns RTNL, we need to prefetch the peer device's netns.

Let's set rtnl_link_ops.peer_type and accordingly remove duplicated
validation in ->newlink().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
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


