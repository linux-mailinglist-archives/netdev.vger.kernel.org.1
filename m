Return-Path: <netdev+bounces-143699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D157E9C3B82
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 10:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6265C1F23852
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 09:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D393170A2E;
	Mon, 11 Nov 2024 09:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rVz6yzYd"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2973716F858;
	Mon, 11 Nov 2024 09:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731319196; cv=none; b=oRHsLJ3ofAZlXNcVPHuz+zhdbu4CHUqVBZqLG2AQvQGqANNBmEJ1f4VfkQ5tHoCm+UVcZmDdnP2LdeALzUlivO8GD23irjqTZfOXlttKQJuEGrohAI3fujy3GE/CN4zyfo5/xHveCkHkDwY5VoID2X7/SJt9hLAzXq5IKKXAPIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731319196; c=relaxed/simple;
	bh=bIJwGwnZhgydUP9HixzoG4F/M97aQMiwDArSFhPD9e0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VhvSO/FW4vKUmM6WLiuBwqteKwkHEI5ZNkMQjfL+K43sHaHHVrWpanFnElr7DC6x88Woldpv7+sL6RG8qJ6HZCs9jCRLzSXg1vYSThyCsUn5PSZ97t/SlWLE3DutRjFIWCIUcUeD8UBFv5QKvK9BAET2glBDsOqV09QaMLNo2h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rVz6yzYd; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4AB9xRc02486061
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Nov 2024 03:59:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1731319167;
	bh=qOZgMXXmNdkh/0G34tPm9VkLBa+JI0Wd6dwHPk5P1VU=;
	h=From:To:CC:Subject:Date;
	b=rVz6yzYdl8XV3og7OgrsP3vauDC4bPvxhpBhxfUbuPUcsRBrHvB5JZb7foilv6Qok
	 owGX+236MjlheYflpqpXF5AB4znAlqqh2ASH/jUlYz79095btIaftg/mKv8i0WpJSn
	 KgECfJq58sYH78vmxuv7dG5yY5Pgp3A/YVMfrnWM=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4AB9xRmF073856
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 11 Nov 2024 03:59:27 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 11
 Nov 2024 03:59:26 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 11 Nov 2024 03:59:26 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AB9xQ7l029483;
	Mon, 11 Nov 2024 03:59:26 -0600
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 4AB9xPW3022843;
	Mon, 11 Nov 2024 03:59:26 -0600
From: Meghana Malladi <m-malladi@ti.com>
To: <vigneshr@ti.com>, <horms@kernel.org>, <m-malladi@ti.com>,
        <jan.kiszka@siemens.com>, <diogo.ivo@siemens.com>, <pabeni@redhat.com>,
        <kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
        <andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>, <danishanwar@ti.com>,
        Vadim Fedorenko
	<vadim.fedorenko@linux.dev>
Subject: [PATCH net v5] net: ti: icssg-prueth: Fix 1 PPS sync
Date: Mon, 11 Nov 2024 15:28:42 +0530
Message-ID: <20241111095842.478833-1-m-malladi@ti.com>
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
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Reviewed-by: MD Danish Anwar <danishanwar@ti.com>
---

This patch is based on net-next tagged next-2024110.
v4:https://lore.kernel.org/all/20241106072314.3361048-1-m-malladi@ti.com
* Changes since v4 (v5-v4):
- Apply nitpicks suggested by Jakub Kicinski <kuba@kernel.org>
- Add missing RB tags

* Changes since v3 (v4-v3):
- Update read function to handle hi/lo race between reads as 
suggested by Jakub Kicinski <kuba@kernel.org>

* Changes since v2 (v3-v2):
- Use hi_lo_writeq() and hi_lo_readq() instead of own helpers
(icssg_readq() & iccsg_writeq()) as asked by Andrew Lunn <andrew@lunn.ch>
- Collected Reviewed-by tags from Vadim and Danish

* Changes since v1 (v2-v1):
- Use roundup() instead of open coding as suggested by Vadim Fedorenko

 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 13 +++++++++++--
 drivers/net/ethernet/ti/icssg/icssg_prueth.h | 12 ++++++++++++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 0556910938fa..0ec8867af1f6 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -16,6 +16,7 @@
 #include <linux/if_hsr.h>
 #include <linux/if_vlan.h>
 #include <linux/interrupt.h>
+#include <linux/io-64-nonatomic-hi-lo.h>
 #include <linux/kernel.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
@@ -411,6 +412,8 @@ static int prueth_perout_enable(void *clockops_data,
 	struct prueth_emac *emac = clockops_data;
 	u32 reduction_factor = 0, offset = 0;
 	struct timespec64 ts;
+	u64 current_cycle;
+	u64 start_offset;
 	u64 ns_period;
 
 	if (!on)
@@ -449,8 +452,14 @@ static int prueth_perout_enable(void *clockops_data,
 	writel(reduction_factor, emac->prueth->shram.va +
 		TIMESYNC_FW_WC_SYNCOUT_REDUCTION_FACTOR_OFFSET);
 
-	writel(0, emac->prueth->shram.va +
-		TIMESYNC_FW_WC_SYNCOUT_START_TIME_CYCLECOUNT_OFFSET);
+	current_cycle = icssg_read_time(emac->prueth->shram.va +
+					TIMESYNC_FW_WC_CYCLECOUNT_OFFSET);
+
+	/* Rounding of current_cycle count to next second */
+	start_offset = roundup(current_cycle, MSEC_PER_SEC);
+
+	hi_lo_writeq(start_offset, emac->prueth->shram.va +
+		     TIMESYNC_FW_WC_SYNCOUT_START_TIME_CYCLECOUNT_OFFSET);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index 8722bb4a268a..f5c1d473e9f9 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -330,6 +330,18 @@ static inline int prueth_emac_slice(struct prueth_emac *emac)
 extern const struct ethtool_ops icssg_ethtool_ops;
 extern const struct dev_pm_ops prueth_dev_pm_ops;
 
+static inline u64 icssg_read_time(const void __iomem *addr)
+{
+	u32 low, high;
+
+	do {
+		high = readl(addr + 4);
+		low = readl(addr);
+	} while (high != readl(addr + 4));
+
+	return low + ((u64)high << 32);
+}
+
 /* Classifier helpers */
 void icssg_class_set_mac_addr(struct regmap *miig_rt, int slice, u8 *mac);
 void icssg_class_set_host_mac_addr(struct regmap *miig_rt, const u8 *mac);

base-commit: 73840ca5ef361f143b89edd5368a1aa8c2979241
-- 
2.25.1


