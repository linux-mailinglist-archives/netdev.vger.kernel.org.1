Return-Path: <netdev+bounces-142622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EB09BFC90
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 03:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83C041F21A7C
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 02:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6528717C60;
	Thu,  7 Nov 2024 02:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="cop609EC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9995B3D64
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 02:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730946681; cv=none; b=YPgO0HOw+4ugyHzYoGiidmHVVz6LZloj2tGj99M0TzGD94fUE2HkCItCa7ayKgw4TbSDdLkYoPVWdvpCXiGbi1DuPhNMmR8DCJOvcKRPWarLPiB+kWxRfTlfG4aovki/YoJHLaqtQ4KxLRa5REFf8RI3vnkl40d8KERoFrf0ih4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730946681; c=relaxed/simple;
	bh=piV854kLEjs0zX5nonkUqYlT6s7E02k+Nyrk8g7YLtg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bw5r+HORpIXGFo3VnID8Kvp9bHH7tTRUMxqecQ0qNyhMvC+fRJaiOXWpwKhA3yhW38lRz9P32oVkcfuFJf1xwZtcw8f9/rrF3T76KlP/RNKTkcFoj/joB0IUSnZdgzBiukDwzpRzZTZheXbOfg13fn0B6BZ8b4VPQYh3zodRPpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=cop609EC; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730946680; x=1762482680;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lC906bayxSJb3xZ8Cy0ZsWoiKAi/8xku873QPtjMOao=;
  b=cop609ECzdmpw8XQGr6MKqxwgIFd/TUXLopba/UIE12H5k3v3fu4eIp9
   9rEBZHTaCBgykbnIWZiggOa8u6kIp9J7VdZBmqnGP30tCUzTqMQtyG2H9
   Alh2OwYo/H0lin1wmop9vvUcfeJyZkF3tHve1BQKSG/dQCyeoLKmWK5Ge
   E=;
X-IronPort-AV: E=Sophos;i="6.11,264,1725321600"; 
   d="scan'208";a="446990133"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 02:31:16 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:56783]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.224:2525] with esmtp (Farcaster)
 id b0b1a6c6-fed5-4a31-8752-4df8c81385f9; Thu, 7 Nov 2024 02:31:15 +0000 (UTC)
X-Farcaster-Flow-ID: b0b1a6c6-fed5-4a31-8752-4df8c81385f9
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 7 Nov 2024 02:31:14 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.101.27) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 7 Nov 2024 02:31:10 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, Marc Kleine-Budde
	<mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Nikolay Aleksandrov <razor@blackwall.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 06/10] veth: Set VETH_INFO_PEER to veth_link_ops.peer_type.
Date: Wed, 6 Nov 2024 18:28:56 -0800
Message-ID: <20241107022900.70287-7-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D038UWC004.ant.amazon.com (10.13.139.229) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

For per-netns RTNL, we need to prefetch the peer device's netns.

Let's set rtnl_link_ops.peer_type and accordingly remove duplicated
validation in ->newlink().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
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


