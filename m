Return-Path: <netdev+bounces-113318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8F293DC7A
	for <lists+netdev@lfdr.de>; Sat, 27 Jul 2024 02:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1863A1C2365E
	for <lists+netdev@lfdr.de>; Sat, 27 Jul 2024 00:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980DE2868D;
	Sat, 27 Jul 2024 00:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="cUgRSz7+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D5A26AEA
	for <netdev@vger.kernel.org>; Sat, 27 Jul 2024 00:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722039617; cv=none; b=AR4s8T+Rg1EMh0m5yTD/ljhLQ3f+TEYq5VcwtKzdwKSRTxYMBo9dhTrOPeomWlG0u+U3nlKYaG2tQ59Evlm4yVsKCtOm1Xm2UZ//yURLHSqlcrQthpF+AOQNa7UCNflTKs/8hda3f3Ke0uwPSB8Src0sx6oY0+KeGQEmxiiyh3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722039617; c=relaxed/simple;
	bh=2w9XVf1I516UG2J2+Sg/VgRrRXU5lcq8GTWP5azJwWk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OSF4TYHJqvlsIAzmBEg+G1dFSZTJv2/m9tg575Vo+JwJJrqq/tb1hKXrqePVehSFmh3OejdpTog56raEMrhp4Gs7e0QdXotiRHMsoSOkOQ4UNTypSJ2Dwo372HbJN9AY2fUjCni5qpGih7Jfb2Uk/4GDAD6cdK3hASZcfmHQExw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=cUgRSz7+; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1722039613; x=1753575613;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=v076Nm3WJ05al8LtEdGymJpUZKLa5BWKjHC0xPoypvM=;
  b=cUgRSz7+hc/ghEZOnmR6Lt4q0519hUbWVeZXrF8pIb3PlniKHWUFQtFf
   rfUJE6f+XXZreQ/0JTmjnuDoCeLcCIBGkK8TaTtD9BUaYkTXw6tcIhuqm
   OEnTK0cXYISjhgD9By2E8/Gau8/iOrjBpRhFbELUOjrNXhoMiWrbBuQEw
   Q=;
X-IronPort-AV: E=Sophos;i="6.09,240,1716249600"; 
   d="scan'208";a="423346220"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2024 00:20:10 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:60461]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.138:2525] with esmtp (Farcaster)
 id 8b93fc72-e9bf-4ec3-96c9-fa816fcf2947; Sat, 27 Jul 2024 00:20:09 +0000 (UTC)
X-Farcaster-Flow-ID: 8b93fc72-e9bf-4ec3-96c9-fa816fcf2947
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Sat, 27 Jul 2024 00:20:07 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.24) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Sat, 27 Jul 2024 00:20:04 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Jiri Pirko <jiri@resnulli.us>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net] rtnetlink: Don't ignore IFLA_TARGET_NETNSID when ifname is specified in rtnl_dellink().
Date: Fri, 26 Jul 2024 17:19:53 -0700
Message-ID: <20240727001953.13704-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA001.ant.amazon.com (10.13.139.88) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

The cited commit accidentally replaced tgt_net with net in rtnl_dellink().

As a result, IFLA_TARGET_NETNSID is ignored if the interface is specified
with IFLA_IFNAME or IFLA_ALT_IFNAME.

Let's pass tgt_net to rtnl_dev_get().

Fixes: cc6090e985d7 ("net: rtnetlink: introduce helper to get net_device instance by ifname")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/rtnetlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 87e67194f240..73fd7f543fd0 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3288,7 +3288,7 @@ static int rtnl_dellink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (ifm->ifi_index > 0)
 		dev = __dev_get_by_index(tgt_net, ifm->ifi_index);
 	else if (tb[IFLA_IFNAME] || tb[IFLA_ALT_IFNAME])
-		dev = rtnl_dev_get(net, tb);
+		dev = rtnl_dev_get(tgt_net, tb);
 	else if (tb[IFLA_GROUP])
 		err = rtnl_group_dellink(tgt_net, nla_get_u32(tb[IFLA_GROUP]));
 	else
-- 
2.30.2


