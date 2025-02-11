Return-Path: <netdev+bounces-165060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D33A30421
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 08:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21A81188844B
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 07:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D571D5CCD;
	Tue, 11 Feb 2025 07:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="U6sgb5+N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B0026BDB6
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 07:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739257515; cv=none; b=T5VZqzYf4AGHbN2KQoNk7oN6Q4KmTGlM0liLVhX7Co8EKa03hV5w12YsMbAvtG+ly3WpdIq2qAF2tquyoXtKjQQtQqhiYHlDA15zYS/RpQ2LewPjcBLJKthvFZgD+GGXp6qiuUg+9GAVeMj4nNIOqYVL3RQMBBcPQj37TeL/3+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739257515; c=relaxed/simple;
	bh=c/3NARD47thG928r4JEDuOuj1PWVXEKcZ6WYzerY8Zc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gOIFeyNqPvm9H+Y6Hm9MVruRfefJ/+Cx+LiH2H2nv4OVHmKtmakfEozdaYvzySrz5qVR2NcLE+bDfPmnQv6Bi0NRuZUmAHT+/a0Ac8b4V01MpkHbStVLcgYYZ3II4uwzoYSV0f1wBhurp3IxPtbXo3ee3fva4IW36rFBu+kqDxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=U6sgb5+N; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739257513; x=1770793513;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=atsfQ+TUSkNYHjgSbto7nTfuyQYB1flml3P/OMxmCA0=;
  b=U6sgb5+N22DJFDeuOw+6eRa9Vdyts4a5yLyhTaD4at7BLQ529/Cng35r
   WHJv0bEpnRJHIvOVYiteAIKRQ4ZV8s28YrzlEQa1B4EWkUHN6aDC5CsjP
   8gMhFjP7qDFmwIP5OdM4AorD52DLmUhoeXjnRp4WTlBLwqhikRh/NDbyh
   g=;
X-IronPort-AV: E=Sophos;i="6.13,276,1732579200"; 
   d="scan'208";a="168607293"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 07:05:11 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:48011]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.59:2525] with esmtp (Farcaster)
 id 018353bb-46f5-4c87-b73a-8c47e6e80ec8; Tue, 11 Feb 2025 07:05:11 +0000 (UTC)
X-Farcaster-Flow-ID: 018353bb-46f5-4c87-b73a-8c47e6e80ec8
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 11 Feb 2025 07:05:02 +0000
Received: from 6c7e67bfbae3.amazon.com (10.119.10.138) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 11 Feb 2025 07:04:57 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn
	<lukas.bulwahn@gmail.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, "Kuniyuki
 Iwashima" <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next] checkpatch: Discourage a new use of rtnl_lock() variants.
Date: Tue, 11 Feb 2025 16:04:47 +0900
Message-ID: <20250211070447.25001-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA004.ant.amazon.com (10.13.139.9) To
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
---
It would be nice if this patch goes through net-next.git to catch
new rtnl_lock() users by netdev CI.
---
 scripts/checkpatch.pl | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7b28ad331742..09d5420436cc 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6995,6 +6995,12 @@ sub process {
 #			}
 #		}
 
+# A new use of rtnl_lock() is discouraged as it's being converted to rtnl_net_lock(net).
+		if ($line =~ /^\+.*\brtnl_(try)?lock(_interruptible|_killable)?\(\)/) {
+			WARN("rtnl_lock()",
+			     "A new use of rtnl_lock() variants is discouraged, try to use rtnl_net_lock(net) variants\n" . $herecurr);
+		}
+
 # strcpy uses that should likely be strscpy
 		if ($line =~ /\bstrcpy\s*\(/) {
 			WARN("STRCPY",
-- 
2.39.5 (Apple Git-154)


