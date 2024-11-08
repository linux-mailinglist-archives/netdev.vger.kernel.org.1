Return-Path: <netdev+bounces-143118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E165F9C134E
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 01:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88F98B217D1
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 00:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92891BD9F8;
	Fri,  8 Nov 2024 00:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ORkE1YpH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724D5EBE
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 00:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731027050; cv=none; b=qxjQYCHnb3NgVMAQ8sqTCg0o+T84tP0WOCA8FFWwby/Ks9nxgETWPkHvamhAGo71qqj1bay2Hye9kLl84rbvRvWEvzDLDP/Dz6jTD74F47PmFz5vAJ4hmcDivTxRuzkXdluYr/5L8/AvHSqE+90CDeYTr2LR/WalP3Pli2OEgDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731027050; c=relaxed/simple;
	bh=uCkJIOSbT5Z/Z4EG5WjP5jW7tBAuoKG5ypmNp8Fi8K0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kz5vQ4hSPdQ10hsClbXiG2pXT1mpUDG+XwzbpVSkKD17046v9DrbfQMvZA0BfyEn4MigNCQBZ7vTWSMi+/3Uj69zEPW0R9MpK6tawQwsEIvaPpOv56HAbmdLvnmYgJRk9sf7lnw4tQ41Wg2qwwWx5yVrjebc1DLpHahmL7IuA4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ORkE1YpH; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1731027050; x=1762563050;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a8XBjXXLlxCEB0GXnyq34/w9BAVrQP5ltvZv/yCsyhk=;
  b=ORkE1YpH83GRWmsEUAmZaHVvImmnG3N8KkJqqweIE5oxj1rT5ghcUiBZ
   j2FHiMWmCbpke6CPkj4m9npWRluH+PlAfWtls2yxlSQIKMzxeDZNsYlnC
   +ZJCDAqMfLWcvZBXK+3R241nKmm43vuCdr8THJMvgVco1xRtsLpsgCgiz
   Q=;
X-IronPort-AV: E=Sophos;i="6.12,136,1728950400"; 
   d="scan'208";a="350433610"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 00:50:49 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:36911]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.1.168:2525] with esmtp (Farcaster)
 id f773c652-28fc-4272-a349-1f545b2bef1e; Fri, 8 Nov 2024 00:50:48 +0000 (UTC)
X-Farcaster-Flow-ID: f773c652-28fc-4272-a349-1f545b2bef1e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 8 Nov 2024 00:50:48 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.170.59) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 8 Nov 2024 00:50:45 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, Marc Kleine-Budde
	<mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Nikolay Aleksandrov <razor@blackwall.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH RESEND v3 net-next 07/10] vxcan: Set VXCAN_INFO_PEER to vxcan_link_ops.peer_type.
Date: Thu, 7 Nov 2024 16:48:20 -0800
Message-ID: <20241108004823.29419-8-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D046UWB004.ant.amazon.com (10.13.139.164) To
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


