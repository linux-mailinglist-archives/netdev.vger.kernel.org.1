Return-Path: <netdev+bounces-142208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AA59BDD03
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 03:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A341B23A7E
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 02:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA951CCB2D;
	Wed,  6 Nov 2024 02:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="iJSdbGAm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD86F190674
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 02:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730859944; cv=none; b=rRpvr/j1QnCU3is2X1T3NO+kpcnF4pjkguoIoleVjjuDJMJYM55OIt9sRk8dzwClNi0XglQ81aI5PvEzg9mIXc/76lEQsz2QL/cOnQfaO+zVHHMnA2MLdWppGmTPvR31PlvWD5MlTJCgq96yUJR+eETGUUnxh7SKaqG/DkuMa78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730859944; c=relaxed/simple;
	bh=eFwrzWghf7lGPktLShPolA+u4vuWcv0xKdROL7AN//8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dsT333c7/BH+Pse07odIO6se2p9AviGgZJhB83r74SeQlh7DLo9KuDzyFyDmwDk2XkxsfG19Ms4pFlhg/N5g+PTd38giHudLDpL2L0Gk+QJKcbHjXw12I3gKfpUZ1XfykPA7Q6uNuJ3eUJ4+R2ByEMRc2PN4tRk7SULtKwv4pQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=iJSdbGAm; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730859943; x=1762395943;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YEnq92+QVWEax9DAqqH/O9jxPuJf3YIV7RIZ7jr1bh0=;
  b=iJSdbGAm+Epe3vMGcRztztEGW8ahMnqNuXcJgiQScn+khxICTM4LG4u6
   vLrecYa3JJVz3EIY3+IMnxQlNDK9EV+PVy9dFOVJYbgoN2336LCgwmpaD
   z3BY23DHssbm4/d6JM/GX9TOtUsCjqUqsUuvqn3Ktb+u8nc46ca1v9TXV
   w=;
X-IronPort-AV: E=Sophos;i="6.11,261,1725321600"; 
   d="scan'208";a="440597576"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 02:25:39 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:31731]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.72:2525] with esmtp (Farcaster)
 id 2535e1fe-af41-4eb1-b3f2-4c691223bc30; Wed, 6 Nov 2024 02:25:38 +0000 (UTC)
X-Farcaster-Flow-ID: 2535e1fe-af41-4eb1-b3f2-4c691223bc30
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 6 Nov 2024 02:25:38 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.170.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 6 Nov 2024 02:25:35 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, Marc Kleine-Budde
	<mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Nikolay Aleksandrov <razor@blackwall.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 3/7] veth: Set VETH_INFO_PEER to veth_link_ops.peer_type.
Date: Tue, 5 Nov 2024 18:24:28 -0800
Message-ID: <20241106022432.13065-4-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D045UWA004.ant.amazon.com (10.13.139.91) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

For per-netns RTNL, we need to prefetch the peer device's netns.

Let's set rtnl_link_ops.peer_type and accordingly remove duplicated
validation in ->newlink().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/veth.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 18148e068aa0..0d6d0d749d44 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1781,19 +1781,11 @@ static int veth_newlink(struct net *src_net, struct net_device *dev,
 	/*
 	 * create and register peer first
 	 */
-	if (data != NULL && data[VETH_INFO_PEER] != NULL) {
-		struct nlattr *nla_peer;
+	if (data && data[VETH_INFO_PEER]) {
+		struct nlattr *nla_peer = data[VETH_INFO_PEER];
 
-		nla_peer = data[VETH_INFO_PEER];
 		ifmp = nla_data(nla_peer);
-		err = rtnl_nla_parse_ifinfomsg(peer_tb, nla_peer, extack);
-		if (err < 0)
-			return err;
-
-		err = veth_validate(peer_tb, NULL, extack);
-		if (err < 0)
-			return err;
-
+		rtnl_nla_parse_ifinfomsg(peer_tb, nla_peer, extack);
 		tbp = peer_tb;
 	} else {
 		ifmp = NULL;
@@ -1809,9 +1801,6 @@ static int veth_newlink(struct net *src_net, struct net_device *dev,
 	}
 
 	net = rtnl_link_get_net(src_net, tbp);
-	if (IS_ERR(net))
-		return PTR_ERR(net);
-
 	peer = rtnl_create_link(net, ifname, name_assign_type,
 				&veth_link_ops, tbp, extack);
 	if (IS_ERR(peer)) {
@@ -1952,6 +1941,7 @@ static struct rtnl_link_ops veth_link_ops = {
 	.newlink	= veth_newlink,
 	.dellink	= veth_dellink,
 	.policy		= veth_policy,
+	.peer_type	= VETH_INFO_PEER,
 	.maxtype	= VETH_INFO_MAX,
 	.get_link_net	= veth_get_link_net,
 	.get_num_tx_queues	= veth_get_num_queues,
-- 
2.39.5 (Apple Git-154)


