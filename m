Return-Path: <netdev+bounces-181800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4087BA867C0
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 22:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25E918C69E1
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 20:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9AB293B4D;
	Fri, 11 Apr 2025 20:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="CtGjvKyW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBF028FFE7
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 20:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744405017; cv=none; b=hi+ZuliQ8QjbuP9f9mSGvAGRTpV+Q9u/cAtUXf7C2MBVPVvo46YTp1lWfjlR/d26e8R12fF2OVXYkKkW1ubr+cmzGSL7PI3AXReGWEB8L/ucDGscZP72XJ1jDGsPzOoTuRunM6WByVxzJlzHOJpkS51zltFCnxbbKQ47sBSznMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744405017; c=relaxed/simple;
	bh=tPoljvsKHjRVyIIc7Ykdmq8+bI1BvgJt0eWK95RdPr8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fegC/gJZsF0v9CCmXhDupBiAgqfzvLn56VW3uJorgQGTkmwZ/vPJdB3oHRs468qJArcX3FqwIm5JtSP86T84x1/8Kpm0N+AnvuX245MZXccfPJuUhsNvp5KerVwESzg7S8yqGOM9aH0o7aM7cxf04jq+GhxNyR01H6DwLUn+DTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=CtGjvKyW; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744405016; x=1775941016;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PsEd4bgSCVWB1kDkfAmdvVxV1QTICD1fDl8yOSzlars=;
  b=CtGjvKyWTpdTGQMm0+M/mXZZosmArhoOReu0MK0gwI9xU70UgE5GKOHj
   5/lljbHMUYH7sxVpMG4K5GhoMsz3dldHdIqiLz01ny344eQwg9doZ4Fe0
   SLbF2rEJApZZ3MVeNsZ3FKtiaDk1LesEyLkgEVouo3aUYbXonZ3QbbDuq
   4=;
X-IronPort-AV: E=Sophos;i="6.15,206,1739836800"; 
   d="scan'208";a="713172144"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 20:56:52 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:5044]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.43.57:2525] with esmtp (Farcaster)
 id fac18cdf-e86f-4afd-9558-94a1d0dd8739; Fri, 11 Apr 2025 20:56:51 +0000 (UTC)
X-Farcaster-Flow-ID: fac18cdf-e86f-4afd-9558-94a1d0dd8739
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 11 Apr 2025 20:56:51 +0000
Received: from 6c7e67bfbae3.amazon.com (10.119.240.29) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 11 Apr 2025 20:56:48 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>, "Ido
 Schimmel" <idosch@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH v2 net-next 09/14] bridge: Convert br_net_exit_batch_rtnl() to ->exit_rtnl().
Date: Fri, 11 Apr 2025 13:52:38 -0700
Message-ID: <20250411205258.63164-10-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D035UWB001.ant.amazon.com (10.13.138.33) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

br_net_exit_batch_rtnl() iterates the dying netns list and
performs the same operation for each.

Let's use ->exit_rtnl().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/net/bridge/br.c b/net/bridge/br.c
index 183fcb362f9e..c16913aac84c 100644
--- a/net/bridge/br.c
+++ b/net/bridge/br.c
@@ -363,21 +363,20 @@ void br_opt_toggle(struct net_bridge *br, enum net_bridge_opts opt, bool on)
 		clear_bit(opt, &br->options);
 }
 
-static void __net_exit br_net_exit_batch_rtnl(struct list_head *net_list,
-					      struct list_head *dev_to_kill)
+static void __net_exit br_net_exit_rtnl(struct net *net,
+					struct list_head *dev_to_kill)
 {
 	struct net_device *dev;
-	struct net *net;
 
-	ASSERT_RTNL();
-	list_for_each_entry(net, net_list, exit_list)
-		for_each_netdev(net, dev)
-			if (netif_is_bridge_master(dev))
-				br_dev_delete(dev, dev_to_kill);
+	ASSERT_RTNL_NET(net);
+
+	for_each_netdev(net, dev)
+		if (netif_is_bridge_master(dev))
+			br_dev_delete(dev, dev_to_kill);
 }
 
 static struct pernet_operations br_net_ops = {
-	.exit_batch_rtnl = br_net_exit_batch_rtnl,
+	.exit_rtnl = br_net_exit_rtnl,
 };
 
 static const struct stp_proto br_stp_proto = {
-- 
2.49.0


