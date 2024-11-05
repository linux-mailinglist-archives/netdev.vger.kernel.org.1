Return-Path: <netdev+bounces-141754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5799BC2EC
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 03:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F850B22134
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 02:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C1D2C190;
	Tue,  5 Nov 2024 02:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="laZztbSZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B762943F
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 02:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730772447; cv=none; b=Zjb6AePIexWUTOqyQbRtwHFDe+WYFTTtwgtyB34txApdwRBHLZdovQHCZg6pGWRQlJL9OM8RwYIMYrzPLk1WrJuw8sjIeEnKcqmvlLrc5pN/hByM0QQFo/Esf9kjppfBJzK0HRAv84Pi3WF54MqVduCp49S8asG+eDkaZ0OPXIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730772447; c=relaxed/simple;
	bh=6DZXbmxzaEIO9upEJPY0y1ZtbwOhxf0B7WqnJnZNf6U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YBznTSkDWZ1d36nyIh5w6L82dOB+7AN9/oWhYihusmEIi/1ER6nmHs3SOSuqm7GacyS4RIaLhujEY9onxyNDWiIzzkwCOGbLyjYxq9XBwi1f4F6vruHuipdfTqz+eJbRE67Le6jknyx4kxXkf0g6ldH806pvOHLJ7LKR4jghVy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=laZztbSZ; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730772445; x=1762308445;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fRuQmliwozN+6ONMOjnZnx+NpSxHgwMb1SS1V8zPSAE=;
  b=laZztbSZ/msd0iupA6/JETMl4jOpBJpqKzHfsw0M8b14TnL+bzDGGlOo
   CXsGBpkypeaDNDzX464oQO9Wr+cymkzUeUKbLcusCJu62ZCEiagNGzmoV
   +Ho4yHGgb6SfOdV79j2wtHKsIWY1qjle0iqOI1I06xmOIHPGIn1g9Xhk4
   w=;
X-IronPort-AV: E=Sophos;i="6.11,258,1725321600"; 
   d="scan'208";a="382466292"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 02:07:20 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:15491]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.35.102:2525] with esmtp (Farcaster)
 id a1d1079a-ba7e-4657-9d8b-6adadf38a174; Tue, 5 Nov 2024 02:07:19 +0000 (UTC)
X-Farcaster-Flow-ID: a1d1079a-ba7e-4657-9d8b-6adadf38a174
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 5 Nov 2024 02:07:19 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.171.42) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 5 Nov 2024 02:07:16 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, Marc Kleine-Budde
	<mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Nikolay Aleksandrov <razor@blackwall.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 6/8] netkit: Set IFLA_NETKIT_PEER_INFO to netkit_link_ops.peer_type.
Date: Mon, 4 Nov 2024 18:05:12 -0800
Message-ID: <20241105020514.41963-7-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D039UWB001.ant.amazon.com (10.13.138.119) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

For per-netns RTNL, we need to prefetch the peer device's netns.

Let's set rtnl_link_ops.peer_type and accordingly remove duplicated
validation in ->newlink().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
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


