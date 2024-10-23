Return-Path: <netdev+bounces-138147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0309AC330
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 11:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E727C28179F
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 09:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E37172BD3;
	Wed, 23 Oct 2024 09:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="P/rkZNKt"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DA61714C8;
	Wed, 23 Oct 2024 09:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729674761; cv=none; b=eQD3t4r24FA0Kd2zdn1gI4+r2SK0XABn6uPrLDptMkvDesuwAtZ8HHpaqrI/H1LLyK/+EiTwjuOXxzrCaPHYsnI1QMuIpGg6qIcCxnbc74CV9u9bAu5SX7fMhZUvy+u7f7pc2aT3UDHHX68zZr3jCdn3BUuG+BK4kJq6iilwuF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729674761; c=relaxed/simple;
	bh=rtHCU1dRvpAXHwI2rS1X2e8wtl39V1tSgdj+NIIG/J8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KLXGYtT6u+n4/j7kd6aT/n4pxCgbUwEuJ2jaT1Q02r4aQ5LsFUc1RbdrU8OMDNfrTauIzpyAUk7NNaWnI8SOwNvBCd8aeFrIfob0WW+zVvA8tssGp+ffNiqgX0FwrUAw4xuA73hRPh7cVy86ZYAYQaFVfpCvj9vmoX+yLyiCJaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=P/rkZNKt; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49N9CL0M097005;
	Wed, 23 Oct 2024 04:12:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1729674741;
	bh=LKQibn8A/Kbr7PK5vWjRMEeinVr3jKgKgEFBSe99U/8=;
	h=From:To:CC:Subject:Date;
	b=P/rkZNKtba6Kr6JVbLHB8vubv9MD8ilKaV5PGgeeDo+/hE5qbrXvHFaDobg2d1LaT
	 ege7xG3O3ILieCIoW90lpvuKTbgBCMlkHfoe16lEN44SCaTFDUJxPJsETe9NDj3+ys
	 8ENAJjapQ0nil3bvYecPv/zA84q/wrPCuDEBZs2I=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49N9CLD8114316;
	Wed, 23 Oct 2024 04:12:21 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 23
 Oct 2024 04:12:20 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 23 Oct 2024 04:12:20 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49N9CKJq045456;
	Wed, 23 Oct 2024 04:12:20 -0500
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 49N9CJ0d004526;
	Wed, 23 Oct 2024 04:12:20 -0500
From: Meghana Malladi <m-malladi@ti.com>
To: <vigneshr@ti.com>, <horms@kernel.org>, <m-malladi@ti.com>,
        <jan.kiszka@siemens.com>, <diogo.ivo@siemens.com>, <pabeni@redhat.com>,
        <kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
        <andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net] net: ti: iccsg-prueth: Fix 1 PPS sync
Date: Wed, 23 Oct 2024 14:42:13 +0530
Message-ID: <20241023091213.593351-1-m-malladi@ti.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The first PPS latch time needs to be calculated by the driver
(in rounded off seconds) and configured as the start time
offset for the cycle. After synchronizing two PTP clocks
running as master/slave, missing this would cause master
and slave to start immediately with some milliseconds
drift which causes the PPS signal to never synchronize with
the PTP master.

Fixes: 186734c15886 ("net: ti: icssg-prueth: add packet timestamping and ptp support")
Signed-off-by: Meghana Malladi <m-malladi@ti.com>
---
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 12 ++++++++++--
 drivers/net/ethernet/ti/icssg/icssg_prueth.h | 11 +++++++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 0556910938fa..6b2cd7c898d0 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -411,6 +411,8 @@ static int prueth_perout_enable(void *clockops_data,
 	struct prueth_emac *emac = clockops_data;
 	u32 reduction_factor = 0, offset = 0;
 	struct timespec64 ts;
+	u64 current_cycle;
+	u64 start_offset;
 	u64 ns_period;
 
 	if (!on)
@@ -449,8 +451,14 @@ static int prueth_perout_enable(void *clockops_data,
 	writel(reduction_factor, emac->prueth->shram.va +
 		TIMESYNC_FW_WC_SYNCOUT_REDUCTION_FACTOR_OFFSET);
 
-	writel(0, emac->prueth->shram.va +
-		TIMESYNC_FW_WC_SYNCOUT_START_TIME_CYCLECOUNT_OFFSET);
+	current_cycle = icssg_readq(emac->prueth->shram.va +
+				    TIMESYNC_FW_WC_CYCLECOUNT_OFFSET);
+
+	/* Rounding of current_cycle count to next second */
+	start_offset = ((current_cycle / MSEC_PER_SEC) + 1) * MSEC_PER_SEC;
+
+	icssg_writeq(start_offset, emac->prueth->shram.va +
+		     TIMESYNC_FW_WC_SYNCOUT_START_TIME_CYCLECOUNT_OFFSET);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index 8722bb4a268a..a4af2dbcca31 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -330,6 +330,17 @@ static inline int prueth_emac_slice(struct prueth_emac *emac)
 extern const struct ethtool_ops icssg_ethtool_ops;
 extern const struct dev_pm_ops prueth_dev_pm_ops;
 
+static inline u64 icssg_readq(const void __iomem *addr)
+{
+	return readl(addr) + ((u64)readl(addr + 4) << 32);
+}
+
+static inline void icssg_writeq(u64 val, void __iomem *addr)
+{
+	writel(lower_32_bits(val), addr);
+	writel(upper_32_bits(val), addr + 4);
+}
+
 /* Classifier helpers */
 void icssg_class_set_mac_addr(struct regmap *miig_rt, int slice, u8 *mac);
 void icssg_class_set_host_mac_addr(struct regmap *miig_rt, const u8 *mac);

base-commit: 73840ca5ef361f143b89edd5368a1aa8c2979241
-- 
2.25.1


