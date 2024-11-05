Return-Path: <netdev+bounces-141752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7E79BC2E7
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 03:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0765280993
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 02:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C391A2A1CF;
	Tue,  5 Nov 2024 02:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="rdmqXzxC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01413C139
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 02:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730772406; cv=none; b=b+Bo8D5m4cK7RletNFCmTVUW/YEzGU2RxQxflnyS9NI/Q2FVDgT7UrywbjhO+SvakYiZjjJqevdOAD+LdeJkwKErGkE5hyN6WcYmOv9oNchdAZ0JoqSZk12yp1s1eo6pir1Npt0Eo6qIEa14impepzvaL45/kG0Wm2komUaLXOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730772406; c=relaxed/simple;
	bh=JufFSkpBOx+/KYCxkaXwUSN+moy9357FZF0IDh/2Mc8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bwizRWZEEAx/4Yyr91bvBmA1ne1Tay5zAtsaPIKeTk8UGjygOpHEEeWWtmlko49gxm3A1MTuS+yr/dtyQW50zEsR9rfUpqIc4ZN8OGKi7UUX3cKRSWUvbAr3kxvaos3h9Tqxe5UdoBV+BpDsgY7eXmu+kKRycFFnmj1JsIYVhCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=rdmqXzxC; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730772405; x=1762308405;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2i1Vu6eU+h6RuVV+rEzTaOOh0RDrehhnAF1MRyntSXw=;
  b=rdmqXzxCJxSD58d2T+XNprBgSLSMOmzReu97RZ5EZnAkcoq76XDnJA5u
   ZpwndvvFEppRTDrYzmblNFO4WclcuP9TaSOrVUtz1ZHfAYuVt1Li4FUDJ
   JAQN4pQen3x6J0h6iquC6axfZpZRGCNONbkrVt4a91lI/hHmY0wZJQfrj
   k=;
X-IronPort-AV: E=Sophos;i="6.11,258,1725321600"; 
   d="scan'208";a="446396250"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 02:06:41 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:23748]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.37:2525] with esmtp (Farcaster)
 id c82e869f-9de5-4ea3-ad29-b660db045905; Tue, 5 Nov 2024 02:06:40 +0000 (UTC)
X-Farcaster-Flow-ID: c82e869f-9de5-4ea3-ad29-b660db045905
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 5 Nov 2024 02:06:40 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.171.42) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 5 Nov 2024 02:06:37 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, Marc Kleine-Budde
	<mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Nikolay Aleksandrov <razor@blackwall.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 4/8] veth: Set VETH_INFO_PEER to veth_link_ops.peer_type.
Date: Mon, 4 Nov 2024 18:05:10 -0800
Message-ID: <20241105020514.41963-5-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D038UWB004.ant.amazon.com (10.13.139.177) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

For per-netns RTNL, we need to prefetch the peer device's netns.

Let's set rtnl_link_ops.peer_type and accordingly remove duplicated
validation in ->newlink().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
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


