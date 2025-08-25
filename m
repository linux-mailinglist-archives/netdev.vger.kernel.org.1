Return-Path: <netdev+bounces-216634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3276CB34B68
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 22:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F16C01B25AC0
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 20:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78112296BDF;
	Mon, 25 Aug 2025 20:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oe03IC52"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E3628DF36
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 20:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756152156; cv=none; b=IIvQD0EBe5ozViBunFgjJT7UCLDvs5UK1z4nlLbIRNoEDTB12XQihKMT6LeZTwGto7xxChJqLAau4kJGx11nUWxiYitGpEQOFits2C0PvadHA3/fL761aqeD5IhoZ/ivBdYCEe8Rr4J1pGXRRC2O2f7KkUCgWtvVQPXEBomILr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756152156; c=relaxed/simple;
	bh=8AQ8CSTwaEsG+BVIT05Sqb4uhCtzlGJ4/RTfQYphKnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=heQlgMRmnzFwjSDXE6eSGwJXGQkcCqvjLX4roAwGvCnmPJS2VX0vtjdLf3pc2wBEg/stzvsk+53+QXtw5DC9VgMSmKxQQT+GumqiyWV9gNtOyWv+Et01PoP3bSRjSmz6Um4t0bmHnqWxEKNsZZf2nqOzhytvDtLzV6dCg7FngJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oe03IC52; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BA76C4CEED;
	Mon, 25 Aug 2025 20:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756152155;
	bh=8AQ8CSTwaEsG+BVIT05Sqb4uhCtzlGJ4/RTfQYphKnw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oe03IC52E0e3uVm/NwXKgTIdCDO2w/rTau94MBrDiNZBaUVkZJztT9gOfqxmv+u9m
	 zh2jzgrKFcISFy4Mvkjqh+tQ1XA7K14urGhKmz3VXU0BOqZ7vthFJEBYeQAlubAqW/
	 M4DJhu5ep6VFqndHg8NK36Hw54EjPDLxEwNUQE5KkhbNSoBAZtef8UmdgsSM/70rU4
	 X63kiy1T/h+5i4WJjB/+gARKFWcsRnunbx5QIzwQj6DCOekO3u1rmz4c62SdusK8tm
	 voyEcpFtoAIyonC/hb862xloredd0iwq/aGIOMHq6EMEocbFKaivU1ze5EGrUDcEyr
	 A1ui+3iu/nGSw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	mohsin.bashr@gmail.com,
	vadim.fedorenko@linux.dev,
	jacob.e.keller@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 3/6] eth: fbnic: Reset MAC stats
Date: Mon, 25 Aug 2025 13:02:03 -0700
Message-ID: <20250825200206.2357713-4-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250825200206.2357713-1-kuba@kernel.org>
References: <20250825200206.2357713-1-kuba@kernel.org>
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
 .../net/ethernet/meta/fbnic/fbnic_hw_stats.c  | 22 +++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |  2 ++
 2 files changed, 24 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.c
index 77182922f018..8aa9a0e286bb 100644
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
@@ -520,6 +532,16 @@ void fbnic_reset_hw_stats(struct fbnic_dev *fbd)
 	fbnic_reset_hw_rxq_stats(fbd, fbd->hw_stats.hw_q);
 	fbnic_reset_pcie_stats_asic(fbd, &fbd->hw_stats.pcie);
 	spin_unlock(&fbd->hw_stats.lock);
+
+	/* Once registered, the only other access to MAC stats is via the
+	 * ethtool API which is protected by the rtnl_lock. The call to
+	 * fbnic_reset_hw_stats() during PCI recovery is also protected
+	 * by the rtnl_lock hence, we don't need the spinlock to access
+	 * the MAC stats.
+	 */
+	if (fbd->netdev)
+		ASSERT_RTNL();
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
2.51.0


