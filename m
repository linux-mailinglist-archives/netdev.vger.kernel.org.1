Return-Path: <netdev+bounces-142238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E059BDF51
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 08:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6419284E7E
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 07:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672031CB9E0;
	Wed,  6 Nov 2024 07:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="V/dl6cII"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473F017995E;
	Wed,  6 Nov 2024 07:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730877841; cv=none; b=lXsnVnDj/GyjHbUF761DMJVrvRYrjG43f9dHEJ7DrO6tyKztGF7gPy9irCuFhNOTEaWtRixjQnKZ6Jb7PYptPB8Y3epI0NAr9NSoO4xlvWqNwe/Aj522J54LLUd/bFPWBMe+WBItOPmH9Eik73Z7wQ8hbvAr+1rZt/wfGN7h83U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730877841; c=relaxed/simple;
	bh=MN/UI52Rj6HjKSgYZUtiruuiPbJymTYGdmdUNhU9KtE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mVMzyO+ZW1x5X5UIdky4diaN4dWpe0dlrQE7QmagBIFvMfahpU5kj3TU/ngx0LVfW5kJIfDi2i7hyTEheOeRfxzF9pg5qpVeHECcLoVvyNCQLxuxrqVRTV+36LusHYpWXnhPPTQFQXdoe2zAvR/Gj2W91n5K8Hy7h1Svis8RBDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=V/dl6cII; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4A67NgPw084600;
	Wed, 6 Nov 2024 01:23:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730877823;
	bh=L2kiDY6j3nYdvBD4lilTFn1FykcKM28CEdpdyTD+P1Q=;
	h=From:To:CC:Subject:Date;
	b=V/dl6cIIb6IDM2zC3AEWa1wfCeW5YnPnE3k5sutNfP94TTN7p9d6eFqzlHKgXLgx8
	 jwrAxgksNlcttp3J3vKnRjVDNZdfKJgQ9htGd+ee4hEqRFLZTyA5vXLIqk+gTKOsDP
	 Z8h7iEJRE7avlJ5ySbfrq81GjNo06N9d4MESuAn8=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A67NgMP101272;
	Wed, 6 Nov 2024 01:23:42 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 6
 Nov 2024 01:23:42 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 6 Nov 2024 01:23:42 -0600
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A67NgKG050049;
	Wed, 6 Nov 2024 01:23:42 -0600
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 4A67NfPw031591;
	Wed, 6 Nov 2024 01:23:42 -0600
From: Meghana Malladi <m-malladi@ti.com>
To: <vigneshr@ti.com>, <horms@kernel.org>, <m-malladi@ti.com>,
        <jan.kiszka@siemens.com>, <diogo.ivo@siemens.com>, <pabeni@redhat.com>,
        <kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
        <andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net v4] net: ti: icssg-prueth: Fix 1 PPS sync
Date: Wed, 6 Nov 2024 12:53:14 +0530
Message-ID: <20241106072314.3361048-1-m-malladi@ti.com>
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

This patch is based on net-next tagged next-2024102.
v3:https://lore.kernel.org/all/20241028111051.1546143-1-m-malladi@ti.com
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
index 0556910938fa..cae8a4f450bb 100644
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
+	current_cycle = icssg_readq(emac->prueth->shram.va +
+				    TIMESYNC_FW_WC_CYCLECOUNT_OFFSET);
+
+	/* Rounding of current_cycle count to next second */
+	start_offset = roundup(current_cycle, MSEC_PER_SEC);
+
+	hi_lo_writeq(start_offset, emac->prueth->shram.va +
+		     TIMESYNC_FW_WC_SYNCOUT_START_TIME_CYCLECOUNT_OFFSET);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index 8722bb4a268a..5c194c6991bf 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -330,6 +330,18 @@ static inline int prueth_emac_slice(struct prueth_emac *emac)
 extern const struct ethtool_ops icssg_ethtool_ops;
 extern const struct dev_pm_ops prueth_dev_pm_ops;
 
+static inline __u64 icssg_readq(const void __iomem *addr)
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


