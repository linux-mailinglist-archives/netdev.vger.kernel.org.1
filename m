Return-Path: <netdev+bounces-46722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 769737E6146
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 01:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2ECE1C208A7
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 00:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5064F363;
	Thu,  9 Nov 2023 00:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Quu+joIj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339D5362
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 00:09:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 362FBC433C7;
	Thu,  9 Nov 2023 00:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699488549;
	bh=krYc3gc4p+L6r0RoI311O2EKgq/PD9o4KG4eS/ctDt8=;
	h=From:To:Cc:Subject:Date:From;
	b=Quu+joIjXBYP3MZqXQT4QO6j66vYzPxpCOW985bRj1dKthB+FSarrNdOJM0sS1/LK
	 yeqj+cWJ03XwGdw5t2jWDWPCny0Bb9xrkH+KLPpOhLk3u9aY7+5UZYg/DvofuqrrLg
	 kDAK4oIZTWV+492zCKHAqVzSgfyMhgID69RgM2eZllx2B5VSRytHmtShJZqU8+YVc6
	 Kws3KfLPFNUWNtFZGX2SoNk5y6e30N66FJZpnJEZg/sznaIsDhNwmChDuAekNuRAM/
	 baNroLE67imrtuCAWfmjRxhFuNOprHSPt1A7NgcRm9ms7I5/SXRv4Y2oIYqijbfPTn
	 R8exwIrS065cQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	syzbot+d55372214aff0faa1f1f@syzkaller.appspotmail.com,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us
Subject: [RFC net-next] net: don't dump stack on queue timeout
Date: Wed,  8 Nov 2023 16:09:01 -0800
Message-ID: <20231109000901.949152-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The top syzbot report for networking (#14 for the entire kernel)
is the queue timeout splat. We kept it around for a long time,
because in real life it provides pretty strong signal that
something is wrong with the driver or the device.

Removing it is also likely to break monitoring for those who
track it as a kernel warning.

Nevertheless, WARN()ings are best suited for catching kernel
programming bugs. If a Tx queue gets starved due to a pause
storm, priority configuration, or other weirdness - that's
obviously a problem, but not a problem we can fix at
the kernel level.

Bite the bullet and convert the WARN() to a print.

Before:

  NETDEV WATCHDOG: eni1np1 (netdevsim): transmit queue 0 timed out 1975 ms
  WARNING: CPU: 0 PID: 0 at net/sched/sch_generic.c:525 dev_watchdog+0x39e/0x3b0
  [... completely pointless stack trace of a timer follows ...]

Now:

  netdevsim netdevsim1 eni1np1: NETDEV WATCHDOG: CPU: 0: transmit queue 0 timed out 1769 ms

Alternatively we could mark the drivers which syzbot has
learned to abuse as "print-instead-of-WARN" selectively.

Reported-by: syzbot+d55372214aff0faa1f1f@syzkaller.appspotmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: jhs@mojatatu.com
CC: xiyou.wangcong@gmail.com
CC: jiri@resnulli.us
---
 net/sched/sch_generic.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 4195a4bc26ca..8dd0e5925342 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -522,8 +522,9 @@ static void dev_watchdog(struct timer_list *t)
 
 			if (unlikely(timedout_ms)) {
 				trace_net_dev_xmit_timeout(dev, i);
-				WARN_ONCE(1, "NETDEV WATCHDOG: %s (%s): transmit queue %u timed out %u ms\n",
-					  dev->name, netdev_drivername(dev), i, timedout_ms);
+				netdev_crit(dev, "NETDEV WATCHDOG: CPU: %d: transmit queue %u timed out %u ms\n",
+					    raw_smp_processor_id(),
+					    i, timedout_ms);
 				netif_freeze_queues(dev);
 				dev->netdev_ops->ndo_tx_timeout(dev, i);
 				netif_unfreeze_queues(dev);
-- 
2.41.0


