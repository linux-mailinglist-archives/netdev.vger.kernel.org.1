Return-Path: <netdev+bounces-178171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9CDA75249
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 23:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 294563AFE9B
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 22:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6421C5489;
	Fri, 28 Mar 2025 22:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="W49BARDK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114551D6DB1
	for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 22:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743199513; cv=none; b=Rpp0j3p3QG37gJ8X/LHtEzBDVJvF0LZb60f4PzcPbnCRCjL0eiMSYc9dT6IMgjN/b+4b1yY+JiX3qpXCNTvChIzznG1bibvbJjKZA6AX67HDfKRVSOJV/TtULgXy0EyhIr4KM8dNW41IQH/QWDDW0tXLVLbWmA5gzl2ai9IVuG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743199513; c=relaxed/simple;
	bh=vj1GR0gbPkAFMhbX4gtr6Ym8wH4JTKQkRP1O/mJjZdA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QhEshDGvDglfWZkMdFrYtbdtUe4ZAs8O5beEVoEHt+1lNPa+Uzr3nn+qEsnOnStqKg9CH4HgiEMZpcmEm1S1NIMGul3rjssB+CibUBW05MyDDF4udeDyxSsvEnMokmOdhnaYxV7VCXgfKkJkztIftQWesk5M+NHyj86nMjSgJ5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=W49BARDK; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1743199512; x=1774735512;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rxno8i/9qhKxECOWNVRAlTauXnd2fcnFmfQmZFn61os=;
  b=W49BARDKBy/Reu9rXrpl74UqiuZRoQJ8h7c6zrQSmWWIoE0wjPhfJ8FY
   cLGi4dgF9yJun9Psyv3xvXGvAQG6Qth6JojyX4jD2H5lj+f8BTFxrNQQt
   GFMJJSCd1uxyyN6Qaj8Uo/eJRs0TR6cnp0/cYe0ehsh2EQZWia4PXXdO0
   k=;
X-IronPort-AV: E=Sophos;i="6.14,284,1736812800"; 
   d="scan'208";a="479213481"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2025 22:05:08 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:25223]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.27.18:2525] with esmtp (Farcaster)
 id 622a05a5-29b6-46c6-9289-9ec517c9c5ef; Fri, 28 Mar 2025 22:05:07 +0000 (UTC)
X-Farcaster-Flow-ID: 622a05a5-29b6-46c6-9289-9ec517c9c5ef
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 28 Mar 2025 22:05:04 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.38) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 28 Mar 2025 22:05:02 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net] rtnetlink: Use register_pernet_subsys() in rtnl_net_debug_init().
Date: Fri, 28 Mar 2025 15:04:48 -0700
Message-ID: <20250328220453.97138-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA001.ant.amazon.com (10.13.139.100) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

rtnl_net_debug_init() registers rtnl_net_debug_net_ops by
register_pernet_device() but calls unregister_pernet_subsys()
in case register_netdevice_notifier() fails.

It corrupts pernet_list because first_device is not updated
in unregister_pernet_device().

Let's fix it by calling register_pernet_subsys() instead.

The _subsys() one fits better for the use case because it keeps
the notifier alive until default_device_exit_net(), giving it
more chance to test NETDEV_UNREGISTER.

Fixes: 03fa53485659 ("rtnetlink: Add ASSERT_RTNL_NET() placeholder for netdev notifier.")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
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


