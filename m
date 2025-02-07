Return-Path: <netdev+bounces-163812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E54A2BA5E
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 05:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0C937A3C01
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 04:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FAF233133;
	Fri,  7 Feb 2025 04:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="BOS3AWkh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC7E233125
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 04:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738903455; cv=none; b=ex9rAzjjN8+L3iVmduoFi3iCymXx1ld9Ty2a3/pySqB2gh64H5NVKnZeeFQHCeog0y3sRIGQ1MKpekMeaCowMfEYkwZ/NmBz104D6MPgfFzAauxOb0jwEnHgvP8vLCigGJJ6zPj2Xn4td3q7fCHnGFlH9zcRu1OneCsHZanHFsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738903455; c=relaxed/simple;
	bh=YXRtwM2ySr1CsLtde2/gzlh+uLGINtTUg5AyKya3NRc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dyFopeV21WkjYgsUVfS3z94fWB5y1ccsTmrrdIalmMJQV+TFqI9GctnvMZu4RtZxwaUVU+8gVPhS8K1GtWKAWVeAFGQn5cReCskSDn7LEG1h4sVmebEhq6umfgqbPyx8ElrJQWMxYioUSfQD9e7nLG59GHkFTKrj0izWp5CCbvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=BOS3AWkh; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738903455; x=1770439455;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LaJaCr4KnS+N8fYt+eyM7xNo8AqWb7z0q7W0mwfZGhM=;
  b=BOS3AWkhBx03yqfkPFVCffDq/K1z/9x/0yvFxtsrkVPnGQfA48PjtKRi
   ioagP5RiXI7gUlKC12ZdiVHJjOvydP1hNWCtNGHl03AiwUinsEWa52S4p
   0hUQ2UjQJ3uQj9BOwLoFDQpXONNeDQNocrjuxdZko5eJTfhC+jII2kTS0
   U=;
X-IronPort-AV: E=Sophos;i="6.13,266,1732579200"; 
   d="scan'208";a="63887316"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 04:44:04 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:9685]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.32.120:2525] with esmtp (Farcaster)
 id b99c0d2b-949a-4f04-bede-4e5ddd910939; Fri, 7 Feb 2025 04:44:02 +0000 (UTC)
X-Farcaster-Flow-ID: b99c0d2b-949a-4f04-bede-4e5ddd910939
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 7 Feb 2025 04:43:57 +0000
Received: from 6c7e67bfbae3.amazon.com (10.118.243.9) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 7 Feb 2025 04:43:53 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net 2/2] dev: Use rtnl_net_dev_lock() in unregister_netdev().
Date: Fri, 7 Feb 2025 13:42:51 +0900
Message-ID: <20250207044251.65421-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250207044251.65421-1-kuniyu@amazon.com>
References: <20250207044251.65421-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWA004.ant.amazon.com (10.13.139.41) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

The following sequence is basically illegal when dev was fetched
without lookup because dev_net(dev) might be different after holding
rtnl_net_lock():

  net = dev_net(dev);
  rtnl_net_lock(net);

Let's use rtnl_net_dev_lock() in unregister_netdev().

Note that there is no real bug in unregister_netdev() for now
because RTNL protects the scope even if dev_net(dev) is changed
before/after RTNL.

Fixes: 00fb9823939e ("dev: Hold per-netns RTNL in (un)?register_netdev().")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/dev.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index f7430c9d9bc3..385f307291d0 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11917,11 +11917,9 @@ EXPORT_SYMBOL(unregister_netdevice_many);
  */
 void unregister_netdev(struct net_device *dev)
 {
-	struct net *net = dev_net(dev);
-
-	rtnl_net_lock(net);
+	rtnl_net_dev_lock(dev);
 	unregister_netdevice(dev);
-	rtnl_net_unlock(net);
+	rtnl_net_dev_unlock(dev);
 }
 EXPORT_SYMBOL(unregister_netdev);
 
-- 
2.39.5 (Apple Git-154)


