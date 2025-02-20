Return-Path: <netdev+bounces-168100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCD5A3D7D6
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 12:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77D46189CBE9
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 11:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1831DE2D8;
	Thu, 20 Feb 2025 11:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tXN6T/bO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348F21DA10C;
	Thu, 20 Feb 2025 11:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740049677; cv=none; b=DK+IScL0RPFFdAL6MvqsyykMKWktNEofiQ23aN3lKz/PzJM06T3xyBUap6T1l+ftHZgpvtbd5OesnrJKAvVTrTi3mcIb524AWjyvD8Z0A55SdlPPI1mtNV94u8Vlhk/N54iuCfVF/ixvfQCNJ47n/l1lSLU3cWZSuBWSigji7rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740049677; c=relaxed/simple;
	bh=dAOMnkWM48ceYbBeCq/KlkjRsHjtl1h9WRQVQqfvtZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=niIJz9FReumCiYCkUeBAsN0F+Qn3j9WbloPKm55tVXhLRdDCvX+sr1HMwS7zi5F+Ail7LVBLNqQDuFpo1JnSffgz8yY5n9FNFHC2zukPNmHDEKtneFJZE0B0bA3uPsu3H3c9kisyL01ri9BEh9v0T9i7q1+qqvoYsKUh2YgDQJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tXN6T/bO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72118C4CED1;
	Thu, 20 Feb 2025 11:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740049676;
	bh=dAOMnkWM48ceYbBeCq/KlkjRsHjtl1h9WRQVQqfvtZ4=;
	h=From:To:Cc:Subject:Date:From;
	b=tXN6T/bO2IjYq/nkfp+mmiBNhdPL9VdR+tsFySJNtsEg5XMq2UBD3kpt83/dadFtQ
	 2hbPJU7ltSoPM35sXf6XY2uYCUlC55M/sPqZvX6534rChiAnORAd7fCDm1f00iaxBI
	 c0/o4/xabwJzQVm5tHgCGO+m/S6u5HEDAXjYGJh4xWQ/oeFR30LHSlbLa3kVXr9StQ
	 M9GMgyZCM5xmLxf8fgmkMqykU9ymmMv9vIW95qf+DrukU9O+3vrrFR0OKeITL0kkYb
	 7pV6kmPsu21FWI3p51DxPt2h3VRBuYlu1cFh4YnaJpXR9qsVVWIFp3o6/dSE/867do
	 +sy7UED9bCXBA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: kuba@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Dmitry Yakunin <zeil@yandex-team.ru>,
	Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Subject: [PATCH] net: set the minimum for net_hotdata.netdev_budget_usecs
Date: Thu, 20 Feb 2025 12:07:52 +0100
Message-ID: <20250220110752.137639-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 7acf8a1e8a28 ("Replace 2 jiffies with sysctl netdev_budget_usecs
to enable softirq tuning") added a possibility to set
net_hotdata.netdev_budget_usecs, but added no lower bound checking.

Commit a4837980fd9f ("net: revert default NAPI poll timeout to 2 jiffies")
made the *initial* value HZ-dependent, so the initial value is at least
2 jiffies even for lower HZ values (2 ms for 1000 Hz, 8ms for 250 Hz, 20
ms for 100 Hz).

But a user still can set improper values by a sysctl. Set .extra1
(the lower bound) for net_hotdata.netdev_budget_usecs to the same value
as in the latter commit. That is to 2 jiffies.

Fixes: a4837980fd9f ("net: revert default NAPI poll timeout to 2 jiffies")
Fixes: 7acf8a1e8a28 ("Replace 2 jiffies with sysctl netdev_budget_usecs to enable softirq tuning")
Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Dmitry Yakunin <zeil@yandex-team.ru>
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: David S. Miller <davem@davemloft.net>
---
 net/core/sysctl_net_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index ad2741f1346a..c7769ee0d9c5 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -34,6 +34,7 @@ static int min_sndbuf = SOCK_MIN_SNDBUF;
 static int min_rcvbuf = SOCK_MIN_RCVBUF;
 static int max_skb_frags = MAX_SKB_FRAGS;
 static int min_mem_pcpu_rsv = SK_MEMORY_PCPU_RESERVE;
+static int netdev_budget_usecs_min = 2 * USEC_PER_SEC / HZ;
 
 static int net_msg_warn;	/* Unused, but still a sysctl */
 
@@ -587,7 +588,7 @@ static struct ctl_table net_core_table[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
+		.extra1		= &netdev_budget_usecs_min,
 	},
 	{
 		.procname	= "fb_tunnels_only_for_init_net",
-- 
2.48.1


