Return-Path: <netdev+bounces-155134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75ACCA01344
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 09:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1620188475A
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 08:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8410148FF0;
	Sat,  4 Jan 2025 08:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="pp1A7jNZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366D2EC5
	for <netdev@vger.kernel.org>; Sat,  4 Jan 2025 08:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735978934; cv=none; b=nDuvKIRFPspwqWrKQYgLzNOrrgCX8aa0Gkz/Cw61Tg0pOBPmvQLkgbSjjTz/cXHcGDVENrJ47tGY/Y51dAZwgHXS3mP64uMnX0Be+cIJetKRn9ywYXa8aEpytrD5sXbh9iO3//y81GKe9EFVuiz3qcFK8IXaCuOfUdansgNXNa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735978934; c=relaxed/simple;
	bh=bi4qQ2OI0GOGI+0aGj3Ymki/e6wEpcV/tBsrx9YXDxw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I6S2iCebWeuQ3zTDAFmuWSurrXRG9+pPLuWYVySg0y74m0qTkmlBJxfVS86+QLET0Hwa0NNfcbQdZ3Hm9pkapjkYNkpx/dRpWgGKZLF4PX5uZIuEOvdWcnL7VTUiywKP88hT/+eZL44oVzKrStotmaL8wFb3sgguXv6mTGcGiJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=pp1A7jNZ; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1735978933; x=1767514933;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=j2vGS58VBqEFMotBQSpGN5438eenApeISvjtSK4iFXE=;
  b=pp1A7jNZ+X8qCJx65Fywsym2jKA2NZ5MnXIYDC8Bjy7NP9XqKsCqAL5r
   /6grwWGLhY7zrN+b/KbnjbhDueXHZFIJlGFDcH2r/vnJZeOlUanL1uZ0L
   AM/5ekgQNg33nMzMP40pHFIZMhOduOwS0EkdqDBHukqUtyZ87EwIblfbf
   U=;
X-IronPort-AV: E=Sophos;i="6.12,288,1728950400"; 
   d="scan'208";a="366555638"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2025 08:22:11 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:40494]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.39.3:2525] with esmtp (Farcaster)
 id 25907d71-fb93-4aa3-9934-d5e609629084; Sat, 4 Jan 2025 08:22:10 +0000 (UTC)
X-Farcaster-Flow-ID: 25907d71-fb93-4aa3-9934-d5e609629084
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sat, 4 Jan 2025 08:22:10 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.9.250) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sat, 4 Jan 2025 08:22:07 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 0/2] dev: Hold per-netns RTNL in register_netdev().
Date: Sat, 4 Jan 2025 17:21:47 +0900
Message-ID: <20250104082149.48493-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA002.ant.amazon.com (10.13.139.10) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Patch 1 adds rtnl_net_lock_killable() and Patch 2 uses it in
register_netdev() and converts it and unregister_netdev() to
per-netns RTNL.

With this and the netdev notifier series [0], ASSERT_RTNL_NET()
for NETDEV_REGISTER [1] wasn't fired on a simplest QEMU setup
like e1000 + x86_64_defconfig + CONFIG_DEBUG_NET_SMALL_RTNL.

[0]: https://lore.kernel.org/netdev/20250104063735.36945-1-kuniyu@amazon.com/

[1]:
---8<---
diff --git a/net/core/rtnl_net_debug.c b/net/core/rtnl_net_debug.c
index f406045cbd0e..c0c30929002e 100644
--- a/net/core/rtnl_net_debug.c
+++ b/net/core/rtnl_net_debug.c
@@ -21,7 +21,6 @@ static int rtnl_net_debug_event(struct notifier_block *nb,
 	case NETDEV_DOWN:
 	case NETDEV_REBOOT:
 	case NETDEV_CHANGE:
-	case NETDEV_REGISTER:
 	case NETDEV_UNREGISTER:
 	case NETDEV_CHANGEMTU:
 	case NETDEV_CHANGEADDR:
@@ -60,19 +59,10 @@ static int rtnl_net_debug_event(struct notifier_block *nb,
 		ASSERT_RTNL();
 		break;
 
-	/* Once an event fully supports RTNL_NET, move it here
-	 * and remove "if (0)" below.
-	 *
-	 * case NETDEV_XXX:
-	 *	ASSERT_RTNL_NET(net);
-	 *	break;
-	 */
-	}
-
-	/* Just to avoid unused-variable error for dev and net. */
-	if (0)
+	case NETDEV_REGISTER:
 		ASSERT_RTNL_NET(net);
+		break;
+	}
 
 	return NOTIFY_DONE;
 }
---8<---


Kuniyuki Iwashima (2):
  rtnetlink: Add rtnl_net_lock_killable().
  dev: Hold per-netns RTNL in (un)?register_netdev().

 include/linux/rtnetlink.h |  6 ++++++
 net/core/dev.c            | 14 ++++++++++----
 net/core/rtnetlink.c      | 11 ++++++++++-
 3 files changed, 26 insertions(+), 5 deletions(-)

-- 
2.39.5 (Apple Git-154)


