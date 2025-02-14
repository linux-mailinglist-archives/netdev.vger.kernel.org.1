Return-Path: <netdev+bounces-166291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05873A355F8
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 05:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2810718923CD
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 04:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC39A189F5C;
	Fri, 14 Feb 2025 04:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="kFj9OtWt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB9C172BB9
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 04:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739508881; cv=none; b=TekdOTMyxMg5cUVCwCfQo5rk7Aikfyrtb/Z0CxPHJgiREExHVBUHP89/7YeFPAE2LK1cqVBR91yJSUcqOrINIQ1RYDmbt7zD8bmEudJUBnqLzzZVqEfV/0kpxcwKs9Nkawu0yOddfeRiqGjSc5lYn7gS5shvEdQXr+VNYmRNQHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739508881; c=relaxed/simple;
	bh=SivAQXvyEJDUy05F1KlehL5YLn8i/AmSKgo3e3WwYqc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tKSVcXN1dS2d/BfE/zbn3ZICgpqNalkzMUDaCGgJZZTY9rxmTnV6MCHeSd2CZEJWZ2kPmGsaqVh5yTJk/ZRCqdqMDRo/hBd43ynFpqGVTYVcwvkThpDBGcBmSbe2NwKh54XxdZQSkZt7kBNv5aZpUHjn86B7DG8di4zq9LK8S4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=kFj9OtWt; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739508880; x=1771044880;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1j43PY77UHCzr3MgVU0slx/WqTV1fKlIBSRbwR+gH84=;
  b=kFj9OtWt+gQC/ykOCbVWDejoG/jCq65yg2xYYr37IQ3CuotgOGdWRK5v
   cIgXwJXOJ6bH/McMgkgVX/XASQcUtI4VupBdxXPoAR4JRaauHha/xzdaW
   KN8A/MjVaaPIKzevSiFVYrPuFOYVcv89x5BYHPIduCe4CBwdoV750ecFo
   w=;
X-IronPort-AV: E=Sophos;i="6.13,284,1732579200"; 
   d="scan'208";a="466762139"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 04:54:36 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:31682]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.73:2525] with esmtp (Farcaster)
 id 572d323f-54f5-44a2-a735-47f59be413e8; Fri, 14 Feb 2025 04:54:36 +0000 (UTC)
X-Farcaster-Flow-ID: 572d323f-54f5-44a2-a735-47f59be413e8
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 14 Feb 2025 04:54:35 +0000
Received: from 6c7e67bfbae3.amazon.com (10.118.254.117) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 14 Feb 2025 04:54:31 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn
	<lukas.bulwahn@gmail.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, "Kuniyuki
 Iwashima" <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next] checkpatch: Discourage a new use of rtnl_lock() variants.
Date: Fri, 14 Feb 2025 13:54:14 +0900
Message-ID: <20250214045414.56291-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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

rtnl_lock() is a "Big Kernel Lock" in the networking slow path
and still serialises most of RTM_(NEW|DEL|SET)* rtnetlink requests.

Commit 76aed95319da ("rtnetlink: Add per-netns RTNL.") started a
very large, in-progress, effort to make the RTNL lock scope per
network namespace.

However, there are still some patches that newly use rtnl_lock(),
which is now discouraged, and we need to revisit it later.

Let's warn about the case by checkpatch.

The target functions are as follows:

  * rtnl_lock()
  * rtnl_trylock()
  * rtnl_lock_interruptible()
  * rtnl_lock_killable()

and the warning will be like:

  WARNING: A new use of rtnl_lock() variants is discouraged, try to use rtnl_net_lock(net) variants
  #18: FILE: net/core/rtnetlink.c:79:
  +	rtnl_lock();

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
v2:
  * Remove unnecessary "^\+.*"
  * Match "rtnl_lock	 ()"

v1: https://lore.kernel.org/netdev/20250211070447.25001-1-kuniyu@amazon.com/
---
 scripts/checkpatch.pl | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7b28ad331742..eca4f082ac3f 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6995,6 +6995,12 @@ sub process {
 #			}
 #		}
 
+# A new use of rtnl_lock() is discouraged as it's being converted to rtnl_net_lock(net).
+		if ($line =~ /\brtnl_(try)?lock(_interruptible|_killable)?\s*\(\)/) {
+			WARN("rtnl_lock()",
+			     "A new use of rtnl_lock() variants is discouraged, try to use rtnl_net_lock(net) variants\n" . $herecurr);
+		}
+
 # strcpy uses that should likely be strscpy
 		if ($line =~ /\bstrcpy\s*\(/) {
 			WARN("STRCPY",
-- 
2.39.5 (Apple Git-154)


