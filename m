Return-Path: <netdev+bounces-181796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C92EA867B6
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 22:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3861D4C39D4
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 20:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E4028F93B;
	Fri, 11 Apr 2025 20:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Zzll5eIE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C6A28EA47
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 20:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744404923; cv=none; b=JMoajULCIp6NDlB0vqN0qa6a/Vf9njW8VQOl9KVfD0CjnFqNBw34cfD+rWLyFyZoAo3/4md/RGvJigGjL1P7I2KFVnsplsimUV+y/t0BhCeL/4APYezEFo6TVwNd5pUSBLBoNZcFlcOqFLKVYYPo8GurDmVyXxMjWsS1eDnSJ6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744404923; c=relaxed/simple;
	bh=zaw3gQ8YYKxz9dvd6C0wjXVkkSlLDSt1/CrTUT42y9Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NdFjNOf7qIPnRSZslm79iADHByCptCWzHgeT1l+lb02Qn0VaKBQd0c5VsO8vXa0SELr3L5fVsST4/Yd3srddrEmzEgZJW02TP8TFLg6jOicwoLWcvN3O/uJnfPWcJEL9auYzieWcJAnNglweai5xw4QRckk1qDzmwqmAUQ4lmJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Zzll5eIE; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744404920; x=1775940920;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NpasL9d1heIOStE8miE3p819f1lUsGK/gKfM3bMRpTE=;
  b=Zzll5eIExwrAFHwmIFlFRz8CkfEyEnYFYLDb8OmvBN/6bS3ZQ+EMEVEv
   uGyRSmYcex/7r8BonaS7URjkVPvSJeNFIMSZKScM9/P4c69Pnnuvv3/4s
   Fh6a5rdYz5CYW0E4mZH/Y0ei721axtK1RHLrPqmVf1gX3yDvEkc3DRLIF
   A=;
X-IronPort-AV: E=Sophos;i="6.15,206,1739836800"; 
   d="scan'208";a="734957264"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 20:55:16 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:23732]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.21.195:2525] with esmtp (Farcaster)
 id 4b22e6c3-a2c0-4ec5-bb69-f3e987743122; Fri, 11 Apr 2025 20:55:14 +0000 (UTC)
X-Farcaster-Flow-ID: 4b22e6c3-a2c0-4ec5-bb69-f3e987743122
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 11 Apr 2025 20:55:12 +0000
Received: from 6c7e67bfbae3.amazon.com (10.119.240.29) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 11 Apr 2025 20:55:09 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>, "Nikolay
 Aleksandrov" <razor@blackwall.org>, Andrew Lunn <andrew+netdev@lunn.ch>
Subject: [PATCH v2 net-next 05/14] vxlan: Convert vxlan_exit_batch_rtnl() to ->exit_rtnl().
Date: Fri, 11 Apr 2025 13:52:34 -0700
Message-ID: <20250411205258.63164-6-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250411205258.63164-1-kuniyu@amazon.com>
References: <20250411205258.63164-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB004.ant.amazon.com (10.13.138.57) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

vxlan_exit_batch_rtnl() iterates the dying netns list and
performs the same operations for each.

Let's use ->exit_rtnl().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
---
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
---
 drivers/net/vxlan/vxlan_core.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 9ccc3f09f71b..56aee539c235 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -4966,19 +4966,15 @@ static void __net_exit vxlan_destroy_tunnels(struct vxlan_net *vn,
 		vxlan_dellink(vxlan->dev, dev_to_kill);
 }
 
-static void __net_exit vxlan_exit_batch_rtnl(struct list_head *net_list,
-					     struct list_head *dev_to_kill)
+static void __net_exit vxlan_exit_rtnl(struct net *net,
+				       struct list_head *dev_to_kill)
 {
-	struct net *net;
-
-	ASSERT_RTNL();
-	list_for_each_entry(net, net_list, exit_list) {
-		struct vxlan_net *vn = net_generic(net, vxlan_net_id);
+	struct vxlan_net *vn = net_generic(net, vxlan_net_id);
 
-		__unregister_nexthop_notifier(net, &vn->nexthop_notifier_block);
+	ASSERT_RTNL_NET(net);
 
-		vxlan_destroy_tunnels(vn, dev_to_kill);
-	}
+	__unregister_nexthop_notifier(net, &vn->nexthop_notifier_block);
+	vxlan_destroy_tunnels(vn, dev_to_kill);
 }
 
 static void __net_exit vxlan_exit_net(struct net *net)
@@ -4992,7 +4988,7 @@ static void __net_exit vxlan_exit_net(struct net *net)
 
 static struct pernet_operations vxlan_net_ops = {
 	.init = vxlan_init_net,
-	.exit_batch_rtnl = vxlan_exit_batch_rtnl,
+	.exit_rtnl = vxlan_exit_rtnl,
 	.exit = vxlan_exit_net,
 	.id   = &vxlan_net_id,
 	.size = sizeof(struct vxlan_net),
-- 
2.49.0


