Return-Path: <netdev+bounces-175948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A4DA680C1
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 00:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AC3116C569
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 23:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54312080CB;
	Tue, 18 Mar 2025 23:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="lc8aImgz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B86A207649
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 23:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742340920; cv=none; b=V/Q7GuWPsw/YZP5h0zhKiIiFfnkdtQhXLMpRG3sQCSjK114LoujjOM60jyc9jOkra/mJbzdHJtKbqzTsBwJh5of5EtAe+h63wYBStRZJcJ3tcaAe/OpNS1CPEYRQmq6FpQsDJi6DwS3pB192d22/Dj9qyFUeaLZ8LaavYh4vCr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742340920; c=relaxed/simple;
	bh=ddUSUo6k/KwRkL6XKbIbIvMULYgm2LOTl/6DJtFMpC4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oRq7LAiOgU6yLfmYQeuhKrzWj87mXcmAxZagsOkQ/Pj5Kd+VTOsaqZcj1wGMRoSdqxINYb48qtIamx4Xh6zbT2Oc6wYSeDAvGHkoYYboh/ODGzGKpHdHtHUH1C7Vp+S65vbKkSYaG9XdaxpwK0AVIph9mzPoAQD/MqI/DvSg2d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=lc8aImgz; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742340919; x=1773876919;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1QJUdUvB0Zqw8+oT2He2sFBsFvqtkfTr0kewt07t1H8=;
  b=lc8aImgzfR70Uwlq4CI8vKiEJhINuijkXY0ZpuYdos5zULNl0RzOS7in
   e1p/GVM9ax4+1Fy7tx3h5A83K+lHZiX7Soxp4ewbNBC7wjQAnLnpWhuHQ
   uEVd+MGA3M5kocZfOifCM0Lt4YViY+rS8r0XR5td3q6iII6jvE8R0hFUI
   Q=;
X-IronPort-AV: E=Sophos;i="6.14,258,1736812800"; 
   d="scan'208";a="179801682"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 23:35:16 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:29127]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.40.40:2525] with esmtp (Farcaster)
 id 9d6e4900-ed01-4137-ab6e-ccac72378cd4; Tue, 18 Mar 2025 23:35:16 +0000 (UTC)
X-Farcaster-Flow-ID: 9d6e4900-ed01-4137-ab6e-ccac72378cd4
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 18 Mar 2025 23:35:16 +0000
Received: from 6c7e67bfbae3.amazon.com (10.135.212.115) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 18 Mar 2025 23:35:13 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: David Ahern <dsahern@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 6/7] nexthop: Convert RTM_NEWNEXTHOP to per-netns RTNL.
Date: Tue, 18 Mar 2025 16:31:49 -0700
Message-ID: <20250318233240.53946-7-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250318233240.53946-1-kuniyu@amazon.com>
References: <20250318233240.53946-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA004.ant.amazon.com (10.13.139.16) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

If we pass false to the rtnl_held param of lwtunnel_valid_encap_type(),
we can move RTNL down before rtm_to_nh_config_rtnl().

Let's use rtnl_net_lock() in rtm_new_nexthop().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/nexthop.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 409f13d64ed4..ea62454e0a0c 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -3169,7 +3169,7 @@ static int rtm_to_nh_config(struct net *net, struct sk_buff *skb,
 
 		cfg->nh_encap_type = nla_get_u16(tb[NHA_ENCAP_TYPE]);
 		err = lwtunnel_valid_encap_type(cfg->nh_encap_type,
-						extack, true);
+						extack, false);
 		if (err < 0)
 			goto out;
 
@@ -3245,13 +3245,18 @@ static int rtm_new_nexthop(struct sk_buff *skb, struct nlmsghdr *nlh,
 		goto out;
 	}
 
+	rtnl_net_lock(net);
+
 	err = rtm_to_nh_config_rtnl(net, tb, &cfg, extack);
 	if (!err)
-		goto out;
+		goto unlock;
 
 	nh = nexthop_add(net, &cfg, extack);
 	if (IS_ERR(nh))
 		err = PTR_ERR(nh);
+
+unlock:
+	rtnl_net_unlock(net);
 out:
 	return err;
 }
@@ -4067,18 +4072,19 @@ static struct pernet_operations nexthop_net_ops = {
 };
 
 static const struct rtnl_msg_handler nexthop_rtnl_msg_handlers[] __initconst = {
-	{.msgtype = RTM_NEWNEXTHOP, .doit = rtm_new_nexthop},
+	{.msgtype = RTM_NEWNEXTHOP, .doit = rtm_new_nexthop,
+	 .flags = RTNL_FLAG_DOIT_PERNET},
 	{.msgtype = RTM_DELNEXTHOP, .doit = rtm_del_nexthop},
 	{.msgtype = RTM_GETNEXTHOP, .doit = rtm_get_nexthop,
 	 .dumpit = rtm_dump_nexthop},
 	{.msgtype = RTM_GETNEXTHOPBUCKET, .doit = rtm_get_nexthop_bucket,
 	 .dumpit = rtm_dump_nexthop_bucket},
 	{.protocol = PF_INET, .msgtype = RTM_NEWNEXTHOP,
-	 .doit = rtm_new_nexthop},
+	 .doit = rtm_new_nexthop, .flags = RTNL_FLAG_DOIT_PERNET},
 	{.protocol = PF_INET, .msgtype = RTM_GETNEXTHOP,
 	 .dumpit = rtm_dump_nexthop},
 	{.protocol = PF_INET6, .msgtype = RTM_NEWNEXTHOP,
-	 .doit = rtm_new_nexthop},
+	 .doit = rtm_new_nexthop, .flags = RTNL_FLAG_DOIT_PERNET},
 	{.protocol = PF_INET6, .msgtype = RTM_GETNEXTHOP,
 	 .dumpit = rtm_dump_nexthop},
 };
-- 
2.48.1


