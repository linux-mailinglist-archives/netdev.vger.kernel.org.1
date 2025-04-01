Return-Path: <netdev+bounces-178674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 357E9A78298
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 21:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D45F7A4815
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 19:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3E81D79B8;
	Tue,  1 Apr 2025 19:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="NgZEOg9K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048511CB31D
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 19:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743534454; cv=none; b=D1oXIN57vcFF5y3x9+vdv9Dy8iZr3vsPpL7gvtrgzJdLLS9YZLY3jrjHSzi6gkGfFfAaDiaA/8YWXUVW9WyhFQrLsJkz4IRwbTCQUwq/TPRCulYLsVkTrOl2gFPa85fUWbt5byMdCRvg0D0PN5ogYWjW8DyQ56GLrBHMQdN/g5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743534454; c=relaxed/simple;
	bh=YTKsFbTaWmsY/5DvVAZdNcPHrPMZrHiI08i8CirUxeo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Th9QYBroJQ+oZ2068J74/DH/onnNBU+GUrWxhDdUKaqdUCxy36GUqCQU6HwL208b8ZOCTm5dLUC9wxHfgi2EnZQDgVY7ZbyJir+KrAWN2nzNvYLssK20CMHoXX363taf34OZedLW1EXNatc+NQRh5f8BMltD1URZLIzsWGS3fvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=NgZEOg9K; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1743534452; x=1775070452;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qTJwG4uUfXm2fd6wZ1Gskgd4gmr/SOOGZbJjrswcbiI=;
  b=NgZEOg9Km3drSdlZ3u5xOR5EWGgvrwxxHOna6pxtMWpirlw24VQF231F
   hrrpufwhzeb1GiVT/oVlHMhKvMpsiq6rBZHli9qpvvvwve4QqJ2M+LyaH
   MjZOGLJuwdTzzEDjP9MQx+TRatKk4iKT4ZBSto4xh+HNJiIu6934bZFaN
   I=;
X-IronPort-AV: E=Sophos;i="6.14,294,1736812800"; 
   d="scan'208";a="476530480"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 19:07:28 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:44837]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.232:2525] with esmtp (Farcaster)
 id 8dfa94e5-bd14-4163-8b08-bea5320bd91a; Tue, 1 Apr 2025 19:07:28 +0000 (UTC)
X-Farcaster-Flow-ID: 8dfa94e5-bd14-4163-8b08-bea5320bd91a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 1 Apr 2025 19:07:27 +0000
Received: from 6c7e67bfbae3.amazon.com (10.94.43.60) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 1 Apr 2025 19:07:25 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net] rtnetlink: Use register_pernet_subsys() in rtnl_net_debug_init().
Date: Tue, 1 Apr 2025 12:07:08 -0700
Message-ID: <20250401190716.70437-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA002.ant.amazon.com (10.13.139.17) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

rtnl_net_debug_init() registers rtnl_net_debug_net_ops by
register_pernet_device() but calls unregister_pernet_subsys()
in case register_netdevice_notifier() fails.

It corrupts pernet_list because first_device is updated in
register_pernet_device() but not unregister_pernet_subsys().

Let's fix it by calling register_pernet_subsys() instead.

The _subsys() one fits better for the use case because it keeps
the notifier alive until default_device_exit_net(), giving it
more chance to test NETDEV_UNREGISTER.

Fixes: 03fa53485659 ("rtnetlink: Add ASSERT_RTNL_NET() placeholder for netdev notifier.")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
v2: Correct changelog
v1: https://lore.kernel.org/netdev/20250328220453.97138-1-kuniyu@amazon.com/
---
 net/core/rtnl_net_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/rtnl_net_debug.c b/net/core/rtnl_net_debug.c
index 7ecd28cc1c22..f3272b09c255 100644
--- a/net/core/rtnl_net_debug.c
+++ b/net/core/rtnl_net_debug.c
@@ -102,7 +102,7 @@ static int __init rtnl_net_debug_init(void)
 {
 	int ret;
 
-	ret = register_pernet_device(&rtnl_net_debug_net_ops);
+	ret = register_pernet_subsys(&rtnl_net_debug_net_ops);
 	if (ret)
 		return ret;
 
-- 
2.48.1


