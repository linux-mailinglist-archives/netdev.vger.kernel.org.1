Return-Path: <netdev+bounces-134347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B3B998E46
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 19:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C61381F24BE4
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 17:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEFD19C567;
	Thu, 10 Oct 2024 17:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="QuOps7zF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159AE1990B3
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 17:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728581086; cv=none; b=OZyHiQcTvaZST9ymY2JVyT4+52C3LHNGI6h981tSxkHrLVRSfGlFA6el/MfoR3yFeNt7xTRjZaDpBkUay0Axu4ucKyd52LSxyuTkDkwwTnhZHTh6xEianyd1/pr+nxAG5n3UKwc15F1pmbvdbc7Z7fAGDIC3GLtLVQgBZRNcZkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728581086; c=relaxed/simple;
	bh=6gGd1F92zNXsKYamnmJwNYBDyjcMO72oXifCPrK2vys=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jNN+G566Q1P6HuMYsZZ0G1EXRSJgSloic9hozrfnafvCvK0HuF7nH3hb0KIAqX0/OOFKiDnEY6a4C0kwkzOAFpAPK09tw+H+zuzIO39qAQONM4tyy6BUlwpimS6Tc2XHu+CFjR0YoSooEevLdJWzu4S645XaAoy5WX8q4TYF8SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=QuOps7zF; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728581086; x=1760117086;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Vf5T/C2qTPF4BzOF3VnQS+F5WNSj7rWSfqwFyVHCO9Y=;
  b=QuOps7zFprS3j1tlAHQO94GL91NTAjhvwXF9iTf4kH3QKfIqdnYPc/7q
   BjHCTL3P18lBU0MuHht+LrR3l/Mh92h9cjVHgIIVumPOMds8AFbVVPyBd
   ogMevs29XLcEhNP1DA6UBip2gPBuGmRkIL7D4a6giJDMV3ZW4V+iPLz6U
   M=;
X-IronPort-AV: E=Sophos;i="6.11,193,1725321600"; 
   d="scan'208";a="665249658"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 17:24:43 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:34285]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.7.250:2525] with esmtp (Farcaster)
 id 16e94c16-7f0c-45ba-98e0-1a84d2b46987; Thu, 10 Oct 2024 17:24:41 +0000 (UTC)
X-Farcaster-Flow-ID: 16e94c16-7f0c-45ba-98e0-1a84d2b46987
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 10 Oct 2024 17:24:41 +0000
Received: from 6c7e67c6786f.amazon.com (10.88.181.15) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 10 Oct 2024 17:24:38 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, kernel test robot
	<lkp@intel.com>
Subject: [PATCH v1 net-next] rtnl_net_debug: Remove rtnl_net_debug_exit().
Date: Thu, 10 Oct 2024 10:24:33 -0700
Message-ID: <20241010172433.67694-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWB004.ant.amazon.com (10.13.138.104) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

kernel test robot reported section mismatch in rtnl_net_debug_exit().

  WARNING: modpost: vmlinux: section mismatch in reference: rtnl_net_debug_exit+0x20 (section: .exit.text) -> rtnl_net_debug_net_ops (section: .init.data)

rtnl_net_debug_exit() uses rtnl_net_debug_net_ops() that is annotated
as __net_initdata, but this file is always built-in.

Let's remove rtnl_net_debug_exit().

Fixes: 03fa53485659 ("rtnetlink: Add ASSERT_RTNL_NET() placeholder for netdev notifier.")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202410101854.i0vQCaDz-lkp@intel.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/rtnl_net_debug.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/net/core/rtnl_net_debug.c b/net/core/rtnl_net_debug.c
index e90a32242e22..f406045cbd0e 100644
--- a/net/core/rtnl_net_debug.c
+++ b/net/core/rtnl_net_debug.c
@@ -122,10 +122,4 @@ static int __init rtnl_net_debug_init(void)
 	return ret;
 }
 
-static void __exit rtnl_net_debug_exit(void)
-{
-	unregister_netdevice_notifier(&rtnl_net_debug_block);
-	unregister_pernet_device(&rtnl_net_debug_net_ops);
-}
-
 subsys_initcall(rtnl_net_debug_init);
-- 
2.39.5 (Apple Git-154)


