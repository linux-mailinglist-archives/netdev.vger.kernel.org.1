Return-Path: <netdev+bounces-151817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBED19F10CF
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 16:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CE01283BD3
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 15:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58CE1E2850;
	Fri, 13 Dec 2024 15:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltc1osyn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E131E2614
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 15:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734103374; cv=none; b=ac9oMs4MillRDOzUZQEMDgCGa+cP17vX3rpNusoOWkZtbf5S8A2UOGpNpq0kWf5tPaVF6yV2MWz1CsCtjKVDt60dWOQFaL/qxLPDYBwSAzceko4ht3fT882Vl7YjhQxMl4kUtL49y3evQ6FOjLmaxu9Eh+7IwtxWt6G7D8clUJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734103374; c=relaxed/simple;
	bh=oxa3ts/7B5y3l8N+Y2mQnRTz3SO9TFP1CuLjZ1q9kKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VtiHvHoC0uraagbzTfcUX9WcvFE2VBKTpiBSmJXKkvzw4au094963zihbIcK515fmmoKvLNtt6N+bkQIMDHkNx0IWLgX8X9i0ewIf4qpYFWBYWRXqpNO0nLzQyONgQaCxH9LeK0KexqlgABSALnitH8+z1w1A6qs+J6HLXSu5lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltc1osyn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AE13C4CEDD;
	Fri, 13 Dec 2024 15:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734103374;
	bh=oxa3ts/7B5y3l8N+Y2mQnRTz3SO9TFP1CuLjZ1q9kKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ltc1osynIIpnBLB+0/kcJ3C0AgUFyeSNL0ru+OAZ8Qw3Q8Ri2oKFKdm6/SEcEGHVh
	 Z5Z/WfFoTFfifftBD+1iqj70iVywrOOsX5MMbNHl7kvr4v68keirCX5v2meacIBOYN
	 gueUFuxBK/XCuBM6pKns7Rbalb7KMJOfF5MnZAy5Tzw9UlJkrnhlmJIjo88m/VQbyu
	 6KgEQ/uIaEnfbmCieMyOvlWPjxy6/Waip9+QkSJJ6R4/6NvRtw8LOQR+5COWh7Jl8M
	 wzGL57/uH+rHvEKbG42eF3J8ajqUZOtweQE9vTH/nvtmQKV3shQlNPpJdFxjQ2gOgh
	 3B25957hXV/Jw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	jdamato@fastly.com,
	almasrymina@google.com,
	amritha.nambiar@intel.com,
	xuanzhuo@linux.alibaba.com,
	sdf@fomichev.me
Subject: [PATCH net 2/5] netdev: fix repeated netlink messages in queue stats
Date: Fri, 13 Dec 2024 07:22:41 -0800
Message-ID: <20241213152244.3080955-3-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241213152244.3080955-1-kuba@kernel.org>
References: <20241213152244.3080955-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The context is supposed to record the next queue do dump,
not last dumped. If the dump doesn't fit we will restart
from the already-dumped queue, duplicating the message.

Before this fix and with the selftest improvements later
in this series we see:

  # ./run_kselftest.sh -t drivers/net:stats.py
  timeout set to 45
  selftests: drivers/net: stats.py
  KTAP version 1
  1..5
  ok 1 stats.check_pause
  ok 2 stats.check_fec
  ok 3 stats.pkt_byte_sum
  # Check| At /root/ksft-net-drv/drivers/net/./stats.py, line 125, in qstat_by_ifindex:
  # Check|     ksft_eq(len(queues[qtype]), len(set(queues[qtype])),
  # Check failed 45 != 44 repeated queue keys
  # Check| At /root/ksft-net-drv/drivers/net/./stats.py, line 127, in qstat_by_ifindex:
  # Check|     ksft_eq(len(queues[qtype]), max(queues[qtype]) + 1,
  # Check failed 45 != 44 missing queue keys
  # Check| At /root/ksft-net-drv/drivers/net/./stats.py, line 125, in qstat_by_ifindex:
  # Check|     ksft_eq(len(queues[qtype]), len(set(queues[qtype])),
  # Check failed 45 != 44 repeated queue keys
  # Check| At /root/ksft-net-drv/drivers/net/./stats.py, line 127, in qstat_by_ifindex:
  # Check|     ksft_eq(len(queues[qtype]), max(queues[qtype]) + 1,
  # Check failed 45 != 44 missing queue keys
  # Check| At /root/ksft-net-drv/drivers/net/./stats.py, line 125, in qstat_by_ifindex:
  # Check|     ksft_eq(len(queues[qtype]), len(set(queues[qtype])),
  # Check failed 103 != 100 repeated queue keys
  # Check| At /root/ksft-net-drv/drivers/net/./stats.py, line 127, in qstat_by_ifindex:
  # Check|     ksft_eq(len(queues[qtype]), max(queues[qtype]) + 1,
  # Check failed 103 != 100 missing queue keys
  # Check| At /root/ksft-net-drv/drivers/net/./stats.py, line 125, in qstat_by_ifindex:
  # Check|     ksft_eq(len(queues[qtype]), len(set(queues[qtype])),
  # Check failed 102 != 100 repeated queue keys
  # Check| At /root/ksft-net-drv/drivers/net/./stats.py, line 127, in qstat_by_ifindex:
  # Check|     ksft_eq(len(queues[qtype]), max(queues[qtype]) + 1,
  # Check failed 102 != 100 missing queue keys
  not ok 4 stats.qstat_by_ifindex
  ok 5 stats.check_down
  # Totals: pass:4 fail:1 xfail:0 xpass:0 skip:0 error:0

With the fix:

  # ./ksft-net-drv/run_kselftest.sh -t drivers/net:stats.py
  timeout set to 45
  selftests: drivers/net: stats.py
  KTAP version 1
  1..5
  ok 1 stats.check_pause
  ok 2 stats.check_fec
  ok 3 stats.pkt_byte_sum
  ok 4 stats.qstat_by_ifindex
  ok 5 stats.check_down
  # Totals: pass:5 fail:0 xfail:0 xpass:0 skip:0 error:0

Fixes: ab63a2387cb9 ("netdev: add per-queue statistics")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: jdamato@fastly.com
CC: almasrymina@google.com
CC: amritha.nambiar@intel.com
CC: xuanzhuo@linux.alibaba.com
CC: sdf@fomichev.me
---
 net/core/netdev-genl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 9f086b190619..1be8c7c21d19 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -668,7 +668,7 @@ netdev_nl_stats_by_queue(struct net_device *netdev, struct sk_buff *rsp,
 					    i, info);
 		if (err)
 			return err;
-		ctx->rxq_idx = i++;
+		ctx->rxq_idx = ++i;
 	}
 	i = ctx->txq_idx;
 	while (ops->get_queue_stats_tx && i < netdev->real_num_tx_queues) {
@@ -676,7 +676,7 @@ netdev_nl_stats_by_queue(struct net_device *netdev, struct sk_buff *rsp,
 					    i, info);
 		if (err)
 			return err;
-		ctx->txq_idx = i++;
+		ctx->txq_idx = ++i;
 	}
 
 	ctx->rxq_idx = 0;
-- 
2.47.1


