Return-Path: <netdev+bounces-143117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B4D9C134D
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 01:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 065251C21916
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 00:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDC0EBE;
	Fri,  8 Nov 2024 00:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ZlpP91OQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329BD1C36
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 00:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731027034; cv=none; b=aMFOlpVg2NwJEIdZCGlZNm+KlglL7D3sMRjFISv1BjpeiTwx4k+ybL9qRK48Wmp3EGupkJfxHsCNYtAm7+7ZNBWR053OHVoDNwDMlk8xXAUJMIj+SNXudybuNaZTnKQ+IzZ2Odn2FGei95tdmOZ9sraYA0SW9Tv4sgZMHQnBHqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731027034; c=relaxed/simple;
	bh=piV854kLEjs0zX5nonkUqYlT6s7E02k+Nyrk8g7YLtg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BG68zwacJdMff7nb6PoGCd/NDdaMO1CS/cIgbFGGSuOJ1/zZYjntq++1kCJT8Be2RRlN9ZhJSLDSbiHV/qdiO7BaAGwonyFN/Dlf0oOHY9tb3AYyGTIPdB+O1KeLVPTCzvK8txc7tBKIIPVK7IISV7j6zOoh4Jyf+XrcDJ+o60s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ZlpP91OQ; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1731027033; x=1762563033;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lC906bayxSJb3xZ8Cy0ZsWoiKAi/8xku873QPtjMOao=;
  b=ZlpP91OQ9z0MY1P8IjuYhzzknnUHr2Mm6lAW5mZ333LZGrLtHlqimAPv
   20dnXh0pWAryNtyezb5vGgkLM6OQEpFZTtdz2bd+5WmnNX32Rk7UNbZ5+
   wMCS/1NpXoy96RGIgsHOi4roYtkQJkzZweWt4v7oTKgdyOKViSS0TJpZ8
   c=;
X-IronPort-AV: E=Sophos;i="6.12,136,1728950400"; 
   d="scan'208";a="693920697"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.124.125.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 00:50:30 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:4559]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.44.86:2525] with esmtp (Farcaster)
 id b68bf4e2-b5fa-4a2f-a401-a289b54756e9; Fri, 8 Nov 2024 00:50:29 +0000 (UTC)
X-Farcaster-Flow-ID: b68bf4e2-b5fa-4a2f-a401-a289b54756e9
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 8 Nov 2024 00:50:29 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.170.59) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 8 Nov 2024 00:50:26 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, Marc Kleine-Budde
	<mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Nikolay Aleksandrov <razor@blackwall.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH RESEND v3 net-next 06/10] veth: Set VETH_INFO_PEER to veth_link_ops.peer_type.
Date: Thu, 7 Nov 2024 16:48:19 -0800
Message-ID: <20241108004823.29419-7-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D033UWC002.ant.amazon.com (10.13.139.196) To
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


