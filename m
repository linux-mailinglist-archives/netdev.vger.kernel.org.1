Return-Path: <netdev+bounces-165242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E227EA313CF
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 19:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E187E7A069A
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 18:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5401E47A6;
	Tue, 11 Feb 2025 18:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORGGg+bt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0651E3DEC
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 18:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739297642; cv=none; b=WJM1VfOtvg0pU40VJOWQfUwAB/8nVGCxJ0N9hnzcg8fXB82ULVBtsh0WaXUBbxMUGH9qnFETK/GnQPqs/o5wgAUhJUgyrg5zc+go6586LVZFfFKLe5TgBmixl48Qf8Zh1NKEIjwDiEVa8MMS7MifPsGccnYt6X1mKD8CH+nHMc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739297642; c=relaxed/simple;
	bh=u6BAnU3rqBdcQTY0+FEqwYQ/ZkOPr0nw31oH7bYMdn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LlOFzKePf0KbANLgl4PN1IaLsxjwWCMBYKp9nh/dDgu1dWTnfsbVm5YHRkkwags6fgxJwFPyyZgjuUsH2n7ahSx6tO1EzMblpr/P5wzIpZodRdR5eTZ1max9RoRZWAQiSUDkqkRXyqvnSo2/XFIYzliJXGf3KvS5dwtYzgX+uIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORGGg+bt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 981C0C4CEE8;
	Tue, 11 Feb 2025 18:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739297642;
	bh=u6BAnU3rqBdcQTY0+FEqwYQ/ZkOPr0nw31oH7bYMdn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ORGGg+bt0xDVZYy9T77ERpQTLs+g/GE4pE2zUW6Tp9/A5QBzxmvxwzMGlWRz1mCT6
	 Dj8sbQNA5VbJuD6hp2l0P6aqQCIL1F4Z7s6rRwpRSzhH6i7KderpqsG6+Ps2eJTMY0
	 c+RPLmHMXXq3nY9yKWogqbB4knKLrt5nKyiV/JkZIW1jEIOLCDuO2C5h+MrulwSpM3
	 +cZO0ugXQwdJdE/D884xI+v7zjBHlJ2ohoizY20DR7zAUHfsouCNp+OHxJNjg7Qab/
	 5gulEBlUKlYtqrH6zlK0WUV56QJ63RELXushJnUsVh9WC1iR+oxKTytgWn2iSlpSoi
	 nCp9Yr7ENrDIQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: alexanderduyck@fb.com,
	netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	jdamato@fastly.com
Subject: [PATCH net-next 1/5] net: report csum_complete via qstats
Date: Tue, 11 Feb 2025 10:13:52 -0800
Message-ID: <20250211181356.580800-2-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250211181356.580800-1-kuba@kernel.org>
References: <20250211181356.580800-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 13c7c941e729 ("netdev: add qstat for csum complete") reserved
the entry for csum complete in the qstats uAPI. Start reporting this
value now that we have a driver which needs it.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: jdamato@fastly.com
---
 include/net/netdev_queues.h | 1 +
 net/core/netdev-genl.c      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index 73d3401261a6..825141d675e5 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -23,6 +23,7 @@ struct netdev_queue_stats_rx {
 	u64 hw_drops;
 	u64 hw_drop_overruns;
 
+	u64 csum_complete;
 	u64 csum_unnecessary;
 	u64 csum_none;
 	u64 csum_bad;
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 0dcd4faefd8d..c18bb53d13fd 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -581,6 +581,7 @@ netdev_nl_stats_write_rx(struct sk_buff *rsp, struct netdev_queue_stats_rx *rx)
 	    netdev_stat_put(rsp, NETDEV_A_QSTATS_RX_ALLOC_FAIL, rx->alloc_fail) ||
 	    netdev_stat_put(rsp, NETDEV_A_QSTATS_RX_HW_DROPS, rx->hw_drops) ||
 	    netdev_stat_put(rsp, NETDEV_A_QSTATS_RX_HW_DROP_OVERRUNS, rx->hw_drop_overruns) ||
+	    netdev_stat_put(rsp, NETDEV_A_QSTATS_RX_CSUM_COMPLETE, rx->csum_complete) ||
 	    netdev_stat_put(rsp, NETDEV_A_QSTATS_RX_CSUM_UNNECESSARY, rx->csum_unnecessary) ||
 	    netdev_stat_put(rsp, NETDEV_A_QSTATS_RX_CSUM_NONE, rx->csum_none) ||
 	    netdev_stat_put(rsp, NETDEV_A_QSTATS_RX_CSUM_BAD, rx->csum_bad) ||
-- 
2.48.1


