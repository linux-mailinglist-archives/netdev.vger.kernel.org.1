Return-Path: <netdev+bounces-136710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5329A2B55
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 19:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D3EEB22062
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 17:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D9B1DF960;
	Thu, 17 Oct 2024 17:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="bHEIOM09"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D751DF96A
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 17:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729187267; cv=none; b=q9G25cH2IzzJglOzayf2qWSkTDxQal+AioDqgnLikEQQKdJ9CZ6yR/QWxvBwLGCQphsCMo2xksldH/dDmR0tI7HKiz18uVrJLhoLKr+rKze/D9Qc8lC4YngSB9k23YRvcHjkExUM6cRgo+pRn3IwL6w0uJOZbYdNAg9lrnUcEP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729187267; c=relaxed/simple;
	bh=UnB9BSWnncVLuUctjnZQS4E9CJWdR+cIbMjyJWpZLZw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Cskey/LEf1KTAnnGFQE8aCpWAL+aZmJJBtKFN3xpgq10cxSU0e1D1W7BBCTAoZxLuLYhhRkyaPoUIA08oVfnGem7iGLa+V6LxhNDM5GAN0Ge19n/8/qygiVNzMo+4HqtNFvUIhvxj8WbY9Orm4N7k9x5Dkgu8NWL8rUQJdHpp38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=bHEIOM09; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729187262; x=1760723262;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZsLb0waHRYGZ/ZQTYHHdJ0S0lpbHSoWdLsHGEwObJe4=;
  b=bHEIOM097G/37DEECI7ImBwtUX5o8mhon5f0BbJ2JD4Ft3kKifX6EGXb
   lEMAH/TQgHpCANZItHOr+d4YwkYRjb+K3wT1SDezc/ex+hH1FK0mv82+4
   h5NOZmgDGx5fd+REx7LJI3j8C5ItI9SWm/GNeGDh6V0ptSvJmQDhu0lsB
   A=;
X-IronPort-AV: E=Sophos;i="6.11,211,1725321600"; 
   d="scan'208";a="667019436"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 17:47:39 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:54172]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.37.107:2525] with esmtp (Farcaster)
 id 6d397cec-08aa-40eb-8b47-edd7e85aba5a; Thu, 17 Oct 2024 17:47:38 +0000 (UTC)
X-Farcaster-Flow-ID: 6d397cec-08aa-40eb-8b47-edd7e85aba5a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 17 Oct 2024 17:47:38 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.171.30) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 17 Oct 2024 17:47:35 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, kernel test robot
	<lkp@intel.com>
Subject: [PATCH v1 net-next] ip6mr: Add __init to ip6_mr_cleanup().
Date: Thu, 17 Oct 2024 10:47:32 -0700
Message-ID: <20241017174732.39487-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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

kernel test robot reported a section mismatch in ip6_mr_cleanup().

  WARNING: modpost: vmlinux: section mismatch in reference: ip6_mr_cleanup+0x0 (section: .text) -> 0xffffffff (section: .init.rodata)
  WARNING: modpost: vmlinux: section mismatch in reference: ip6_mr_cleanup+0x14 (section: .text) -> ip6mr_rtnl_msg_handlers (section: .init.rodata)

ip6_mr_cleanup() uses ip6mr_rtnl_msg_handlers[] that has
__initconst_or_module qualifier.

ip6_mr_cleanup() is only called from inet6_init() but does
not have __init qualifier.

Let's add __init to ip6_mr_cleanup().

Fixes: 3ac84e31b33e ("ipmr: Use rtnl_register_many().")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202410180139.B3HeemsC-lkp@intel.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv6/ip6mr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 437a9fdb67f5..8add0f45aa52 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -1411,7 +1411,7 @@ int __init ip6_mr_init(void)
 	return err;
 }
 
-void ip6_mr_cleanup(void)
+void __init ip6_mr_cleanup(void)
 {
 	rtnl_unregister_many(ip6mr_rtnl_msg_handlers);
 #ifdef CONFIG_IPV6_PIMSM_V2
-- 
2.39.5 (Apple Git-154)


