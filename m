Return-Path: <netdev+bounces-216104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEAEB320B5
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 18:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D87DB7A15BC
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 16:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E733126AC;
	Fri, 22 Aug 2025 16:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDq+4BJB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82DB307ACD
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 16:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755881267; cv=none; b=dYHRubwM+9E+7EyZ4L+HblGH0AWy0fM/JSrpkaRBg6Kpj+hnSzistbkXSRMQShb1ZNK9VMGDSmh3HGXqsxIUzto3CRZAYfRpxZKcf30kS+JGWX0slR+9jOFz+gKNLKRrlZDL9sehsdUskiia6XYC7WBz7q7SMjnyLHnkdB//0gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755881267; c=relaxed/simple;
	bh=9N3BXdRwG4fxWySHXAp2vn9TwBods6VCUtdhwpiME7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J9QBmZs4ffZqdl45Z2J8t5R8GTtPE2AzloOZXgZPXpO63+dxpbf3k/BSm9IvCbSYfJN3koWKu9V1Wpz7bj9KW2osHDR0xVjRnQTlyeUlu5L1gbsAhfYj10NQGTs1+tLBraSKmF2l9C5YM1ZbXW4nYnuYtyCNurQbBqW8+EAUNeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDq+4BJB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4918CC116C6;
	Fri, 22 Aug 2025 16:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755881266;
	bh=9N3BXdRwG4fxWySHXAp2vn9TwBods6VCUtdhwpiME7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QDq+4BJBBBdh1RhAvTysfjRlqZeTZk/ZT7UwUD1sspRt5+FsGsVf+TDzuCPDUAyQr
	 JDsmgFFJIkqpcFecDa4YQarpGYD7DkvfN34pOjXfEkkKaya9fNolyyCO1xiStf4X2g
	 PHKSVXTkNxpySMUCK240ZYaJUBk61IvS65gTvrGVO+Nq0NKWfIPVjlg7W3/kgUotxr
	 lbqtiBe1kNMw0A4ZJtx6THLHNVl4teCnDxxABWxA6Qvj4zPHhedBZNi4uRIy3Vw2h6
	 uuogm+IX29ugGQANxk0+SbjQpvo74uCN9ugK1zsbABaWP1NcgGSu/cwrzHGk9ZTgmS
	 XLTOwPIr55nXw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	alexanderduyck@fb.com,
	linux@armlinux.org.uk,
	mohsin.bashr@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 3/6] eth: fbnic: Reset MAC stats
Date: Fri, 22 Aug 2025 09:47:28 -0700
Message-ID: <20250822164731.1461754-4-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822164731.1461754-1-kuba@kernel.org>
References: <20250822164731.1461754-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohsin Bashir <mohsin.bashr@gmail.com>

Reset the MAC stats as part of the hardware stats reset to ensure
consistency. Currently, hardware stats are reset during device bring-up
and upon experiencing PCI errors; however, MAC stats are being skipped
during these resets.

When fbnic_reset_hw_stats() is called upon recovering from PCI error,
MAC stats are accessed outside the rtnl_lock. The only other access to
MAC stats is via the ethtool API, which is protected by rtnl_lock. This
can result in concurrent access to MAC stats and a potential race. Protect
the fbnic_reset_hw_stats() call in __fbnic_pm_attach() with rtnl_lock to
avoid this.

Note that fbnic_reset_hw_mac_stats() is called outside the hardware
stats lock which protects access to the fbnic_hw_stats. This is intentional
because MAC stats are fetched from the device outside this lock and are
exclusively read via the ethtool API.

Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../net/ethernet/meta/fbnic/fbnic_hw_stats.c  | 20 +++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |  2 ++
 2 files changed, 22 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
index 77182922f018..685a4c999fec 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) Meta Platforms, Inc. and affiliates. */
 
+#include <linux/rtnetlink.h>
+
 #include "fbnic.h"
 
 static void fbnic_hw_stat_rst32(struct fbnic_dev *fbd, u32 reg,
@@ -510,6 +512,16 @@ static void fbnic_get_pcie_stats_asic64(struct fbnic_dev *fbd,
 			   &pcie->ob_rd_no_np_cred);
 }
 
+static void fbnic_reset_hw_mac_stats(struct fbnic_dev *fbd,
+				     struct fbnic_mac_stats *mac_stats)
+{
+	const struct fbnic_mac *mac = fbd->mac;
+
+	mac->get_eth_mac_stats(fbd, true, &mac_stats->eth_mac);
+	mac->get_eth_ctrl_stats(fbd, true, &mac_stats->eth_ctrl);
+	mac->get_rmon_stats(fbd, true, &mac_stats->rmon);
+}
+
 void fbnic_reset_hw_stats(struct fbnic_dev *fbd)
 {
 	spin_lock(&fbd->hw_stats.lock);
@@ -520,6 +532,14 @@ void fbnic_reset_hw_stats(struct fbnic_dev *fbd)
 	fbnic_reset_hw_rxq_stats(fbd, fbd->hw_stats.hw_q);
 	fbnic_reset_pcie_stats_asic(fbd, &fbd->hw_stats.pcie);
 	spin_unlock(&fbd->hw_stats.lock);
+
+	/* The only other access to MAC stats is via the ethtool API which
+	 * is protected by the rtnl_lock. The call to fbnic_reset_hw_stats()
+	 * during PCI recovery is also protected by the rtnl_lock hence, we
+	 * don't need additional locking to access the MAC stats.
+	 */
+	ASSERT_RTNL();
+	fbnic_reset_hw_mac_stats(fbd, &fbd->hw_stats.mac);
 }
 
 void fbnic_init_hw_stats(struct fbnic_dev *fbd)
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index 953297f667a2..ef7928b18ac0 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -491,7 +491,9 @@ static void __fbnic_pm_attach(struct device *dev)
 	struct net_device *netdev = fbd->netdev;
 	struct fbnic_net *fbn;
 
+	rtnl_lock();
 	fbnic_reset_hw_stats(fbd);
+	rtnl_unlock();
 
 	if (fbnic_init_failure(fbd))
 		return;
-- 
2.50.1


