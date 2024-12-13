Return-Path: <netdev+bounces-151816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C80219F10D0
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 16:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A6AE163469
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 15:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6681E25F1;
	Fri, 13 Dec 2024 15:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNps1728"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F07C1E2312
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 15:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734103374; cv=none; b=nIYbVeQ259scaBEzv2jkh5+rtVPm2Gyy0US8YOrCPQ4ybdBB2JA+ac3TpRHgRfDVD07OJKWrQKQf21rB5YRZRd3XzZDj60Uh3CElPjVeGVEIZqsgxft4p0sEQrp/znBG8ZYYY6z3V1qBwMqUyE4dS7gZfC5V1lRzN+DB4vW7z/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734103374; c=relaxed/simple;
	bh=D5vMP2Y/iWgk+eAx+fRPz67cMTrMx15yn8URoAuq0Wk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NosljMSmkA4t8Ueq7AXl6RYDgKD0yq6SVV05gDduJcJTG64A/CtcZR3ccrZxOn+AgEphUIZ7Is/P8V5x8By+6VoB9GMloU1sXY4fXxRpEbtM6kVYlB8pvA0mqLpjtBxAMRM27YsNJx42iQFueF2bTe/Blul4+PnXIY0yfcuOVsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNps1728; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86466C4CED2;
	Fri, 13 Dec 2024 15:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734103373;
	bh=D5vMP2Y/iWgk+eAx+fRPz67cMTrMx15yn8URoAuq0Wk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PNps1728hVl1IR2Ql30pgvvgPbqM4BoYJwQB+BwLzhZVyehVHUvAaukamiE0WYFgd
	 EzYdQsKUqVIQyuqzKliXiMZ5DnRz6zOoZ1sDAEPJGe/fshtUqMy4K7aW32ntIceCGg
	 mP/LUPXPs9jNO+z2sENcwbQkM0LTfBP8qGKI2DESb4fIdpnlHIzUPJKrxPq/HfBcOv
	 NfDP2+o2cVxUuSzhHtvh2QdAY9lmBpfG0Adn15r61/0MG60bk+2lS52p0t8/lbsXac
	 fZFpmdx6hPiMtnFOLfEuvaw3CJq0Jt/aBZcwFTpIJzln9SgigVUQq4dn9yRfPrBh7z
	 IjKgochN9esOg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	jdamato@fastly.com,
	almasrymina@google.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com
Subject: [PATCH net 1/5] netdev: fix repeated netlink messages in queue dump
Date: Fri, 13 Dec 2024 07:22:40 -0800
Message-ID: <20241213152244.3080955-2-kuba@kernel.org>
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

  # ./run_kselftest.sh -t drivers/net:queues.py
  timeout set to 45
  selftests: drivers/net: queues.py
  KTAP version 1
  1..2
  # Check| At /root/ksft-net-drv/drivers/net/./queues.py, line 32, in get_queues:
  # Check|     ksft_eq(queues, expected)
  # Check failed 102 != 100
  # Check| At /root/ksft-net-drv/drivers/net/./queues.py, line 32, in get_queues:
  # Check|     ksft_eq(queues, expected)
  # Check failed 101 != 100
  not ok 1 queues.get_queues
  ok 2 queues.addremove_queues
  # Totals: pass:1 fail:1 xfail:0 xpass:0 skip:0 error:0
  not ok 1 selftests: drivers/net: queues.py # exit=1

With the fix:

  # ./ksft-net-drv/run_kselftest.sh -t drivers/net:queues.py
  timeout set to 45
  selftests: drivers/net: queues.py
  KTAP version 1
  1..2
  ok 1 queues.get_queues
  ok 2 queues.addremove_queues
  # Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0

Fixes: 6b6171db7fc8 ("netdev-genl: Add netlink framework functions for queue")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: jdamato@fastly.com
CC: almasrymina@google.com
CC: amritha.nambiar@intel.com
CC: sridhar.samudrala@intel.com
---
 net/core/netdev-genl.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 9527dd46e4dc..9f086b190619 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -488,24 +488,21 @@ netdev_nl_queue_dump_one(struct net_device *netdev, struct sk_buff *rsp,
 			 struct netdev_nl_dump_ctx *ctx)
 {
 	int err = 0;
-	int i;
 
 	if (!(netdev->flags & IFF_UP))
 		return err;
 
-	for (i = ctx->rxq_idx; i < netdev->real_num_rx_queues;) {
-		err = netdev_nl_queue_fill_one(rsp, netdev, i,
+	for (; ctx->rxq_idx < netdev->real_num_rx_queues; ctx->rxq_idx++) {
+		err = netdev_nl_queue_fill_one(rsp, netdev, ctx->rxq_idx,
 					       NETDEV_QUEUE_TYPE_RX, info);
 		if (err)
 			return err;
-		ctx->rxq_idx = i++;
 	}
-	for (i = ctx->txq_idx; i < netdev->real_num_tx_queues;) {
-		err = netdev_nl_queue_fill_one(rsp, netdev, i,
+	for (; ctx->txq_idx < netdev->real_num_tx_queues; ctx->txq_idx++) {
+		err = netdev_nl_queue_fill_one(rsp, netdev, ctx->txq_idx,
 					       NETDEV_QUEUE_TYPE_TX, info);
 		if (err)
 			return err;
-		ctx->txq_idx = i++;
 	}
 
 	return err;
-- 
2.47.1


