Return-Path: <netdev+bounces-47607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 673AF7EA9F8
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 06:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97A061C20866
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 05:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752CEBE5E;
	Tue, 14 Nov 2023 05:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gEpK3qcs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACCCC2C3
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 05:11:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E30BC433C7;
	Tue, 14 Nov 2023 05:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699938706;
	bh=6TwyQyR+IRDGyqtvdoDFmoTYpVWciLrghrehNqTSiyY=;
	h=From:To:Cc:Subject:Date:From;
	b=gEpK3qcsGaj+FQsXc/Dcj/CUsHWqWTrUgh5G/DuJ3Ahw4zLxHBF7xLbneE+PlsthQ
	 EVIZThDmMeDitZOFF60zBPbhwPC6qKw3VJ2q/uQBVCNpaDIuAuwh99hY1EAmHFw9uS
	 BspRpwqtQanFsu3AgbqAezvQuJuFawajVLC7jEQXTMvx8dHCicKrI+2gNjzxhRug5D
	 CJsfnHRmap6Cgwd5Ab2lwccLsGjRzJDFVQr8SCOZtHeobWOPjJIiAVzcUID6dD4VHX
	 s2mjq/ay8M7Lxvt0ZjixtQPb/qKzxgxoXs/Td2H7BWzZkK5j+flX1yBuh3C7DtPn2Q
	 g1ie15yJjAtGg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	syzbot+d55372214aff0faa1f1f@syzkaller.appspotmail.com,
	Jiri Pirko <jiri@nvidia.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	xiyou.wangcong@gmail.com
Subject: [PATCH net-next] net: don't dump stack on queue timeout
Date: Tue, 14 Nov 2023 00:11:42 -0500
Message-ID: <20231114051142.1939298-1-kuba@kernel.org>
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
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
RFC: https://lore.kernel.org/all/20231109000901.949152-1-kuba@kernel.org/

CC: xiyou.wangcong@gmail.com
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


