Return-Path: <netdev+bounces-118980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 975C7953C66
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 23:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C992E1C21CDD
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 21:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02452149E15;
	Thu, 15 Aug 2024 21:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="l2ONfXhc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCABB13C677
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 21:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723756368; cv=none; b=bOnbmuUwGDPg+6srEOLw4efoEommu29OzDgdqGogilJ9ZaILUCYqvivHnUm6ZrdlvZ+Iv/VgC4pi05EIzwwOlnz6d0ZG/l9NS656O4z2VOst+uvaTsrEz/kmxpORBQKvdquBaymsCDghfVgTu9afs/AjQsbqcUzX/sxNQ2/3M18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723756368; c=relaxed/simple;
	bh=y6nBb/P8lI74CWqs3c4CHK5bCS/zPfz1qdvaS1iZTuE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rbfNVa6wJ11nabJYVfKCiFKM+QJKCLPgD9T+cUo8BT0j60AqhhsE2sHgrYTH62CtCD1b6ctgU6e7XUQ+n7XNEVx96YateBDl5/A45Pn0xLpOZYebosvKCxtqL2xzIG8ITTk9hNUntcSNiT8517L+BkMGx5wGApxIaltdvunU4c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=l2ONfXhc; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1723756367; x=1755292367;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eB5vKI/54pLfPF/zJk0JlG20z25oWeIx0xbvzxX7bHo=;
  b=l2ONfXhcCUzdgdzr5yLXEnYMG0wEkmM30D7tuyXkNpdrIiSZSbnaY99e
   vp3R2Djg3JSDAf9q509zuMdkRWgXYIbNmJCGJjZ/zyLpdcxK53MqIuxWU
   2mxoPTiA/fNVXw0xyY0pORR3Fc1wWlmikGfE+5K1UAA24SW7jSmAEP+kj
   Y=;
X-IronPort-AV: E=Sophos;i="6.10,150,1719878400"; 
   d="scan'208";a="427171748"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 21:12:43 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:35333]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.3.1:2525] with esmtp (Farcaster)
 id 7935a9a6-5346-4b9a-968c-f8b049098ad8; Thu, 15 Aug 2024 21:12:42 +0000 (UTC)
X-Farcaster-Flow-ID: 7935a9a6-5346-4b9a-968c-f8b049098ad8
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 15 Aug 2024 21:12:42 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.33) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 15 Aug 2024 21:12:39 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, Roopa Prabhu
	<roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 2/2] net: bridge: Remove rcu_read_lock() in br_get_link_af_size_filtered().
Date: Thu, 15 Aug 2024 14:11:37 -0700
Message-ID: <20240815211137.62280-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240815211137.62280-1-kuniyu@amazon.com>
References: <20240815211137.62280-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWA003.ant.amazon.com (10.13.139.49) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Since commit 5fa85a09390c ("net: core: rcu-ify rtnl af_ops"),
af_ops->get_link_af_size() is called under RCU.

Let's remove unnecessary rcu_read_lock() in br_get_link_af_size_filtered().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/bridge/br_netlink.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index f17dbac7d828..c386a8ec370f 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -101,7 +101,6 @@ static size_t br_get_link_af_size_filtered(const struct net_device *dev,
 	size_t vinfo_sz = 0;
 	int num_vlan_infos;
 
-	rcu_read_lock();
 	if (netif_is_bridge_port(dev)) {
 		p = br_port_get_check_rcu(dev);
 		if (p)
@@ -111,7 +110,6 @@ static size_t br_get_link_af_size_filtered(const struct net_device *dev,
 		vg = br_vlan_group_rcu(br);
 	}
 	num_vlan_infos = br_get_num_vlan_infos(vg, filter_mask);
-	rcu_read_unlock();
 
 	if (p && (p->flags & BR_VLAN_TUNNEL))
 		vinfo_sz += br_get_vlan_tunnel_info_size(vg);
-- 
2.30.2


