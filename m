Return-Path: <netdev+bounces-149270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB339E4FB8
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 09:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE4B61881D27
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 08:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956F01D358F;
	Thu,  5 Dec 2024 08:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QZS8SI7L"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EF41CEE9F;
	Thu,  5 Dec 2024 08:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733387369; cv=none; b=AcIkzqKOln3Wzd4tM4xm3p1/hia6n7ZiTLPNPp4rwSEymNaWLO0bip9/5+qAHAIXBmslQO9kZySXVrvY6C5uNNUIsgXcIW6GemCvs3UXYMgza+NP1BgvE3BtZJ25JmwefPHVM2TtmSXF6vy9u9sDw+OSEVmGXEQVjz+ODL2Rc9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733387369; c=relaxed/simple;
	bh=w2fYW6rtSYCx9qTBP92ngyvaxxFGH5Qf58yHs2E7NxY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZmUx1xn2LzCuYaIaTzucwAPjQEDma6jQw4pj7kJdI+34JMhIAjVjs7tpSbvY3E0wX64R2g9U2fmlMyo7z2flIPrtnyACQ+Iq2dQQQhFW10twvMRr5QqIhgQDCtTgvOEGOSSryTCDc013qwAd+W9Bi8OFZjUyP4NxgXkUR4I0o/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QZS8SI7L; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4B58T0dQ2175164
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Dec 2024 02:29:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1733387340;
	bh=+/NJI+xsMwC2ZaiGrYbKttbYCAhIk4oabrielzqyPHM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=QZS8SI7Lh8PBFOUTH/uObH6mP7nC5Nw0GOMTjmEUg+dc+vbzufwuIqe+X+2zEm/2P
	 xLX4RecvMADbX4n804y2sVIzbNm/xFqfU31E+Xtuewqa0vKuhD/z0oQR0jh15yk8z4
	 ffvqt5hy2+y0JTnFOP4e1vneEzYBW+4u94DCSpsI=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4B58T06c006590
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 5 Dec 2024 02:29:00 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 5
 Dec 2024 02:29:00 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 5 Dec 2024 02:29:00 -0600
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B58T0m4039999;
	Thu, 5 Dec 2024 02:29:00 -0600
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 4B58Sxl0021724;
	Thu, 5 Dec 2024 02:28:59 -0600
From: Meghana Malladi <m-malladi@ti.com>
To: <vigneshr@ti.com>, <jan.kiszka@siemens.com>,
        Roger Quadros
	<rogerq@kernel.org>, <m-malladi@ti.com>,
        <javier.carrasco.cruz@gmail.com>, <diogo.ivo@siemens.com>,
        <jacob.e.keller@intel.com>, <horms@kernel.org>, <pabeni@redhat.com>,
        <kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
        <andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <danishanwar@ti.com>
Subject: [PATCH net v3 2/2] net: ti: icssg-prueth: Fix clearing of IEP_CMP_CFG registers during iep_init
Date: Thu, 5 Dec 2024 13:58:31 +0530
Message-ID: <20241205082831.777868-3-m-malladi@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241205082831.777868-1-m-malladi@ti.com>
References: <20241205082831.777868-1-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

When ICSSG interfaces are brought down and brought up again, the
pru cores are shut down and booted again, flushing out all the memories
and start again in a clean state. Hence it is expected that the
IEP_CMP_CFG register needs to be flushed during iep_init() to ensure
that the existing residual configuration doesn't cause any unusual
behavior. If the register is not cleared, existing IEP_CMP_CFG set for
CMP1 will result in SYNC0_OUT signal based on the SYNC_OUT register values.

After bringing the interface up, calling PPS enable doesn't work as
the driver believes PPS is already enabled, (iep->pps_enabled is not
cleared during interface bring down) and driver will just return true
even though there is no signal. Fix this by disabling pps and perout.

Fixes: c1e0230eeaab ("net: ti: icss-iep: Add IEP driver")
Signed-off-by: Meghana Malladi <m-malladi@ti.com>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
---

Hi all,

This patch is based on net-next tagged next-20241128
v2: https://lore.kernel.org/all/20241128122931.2494446-3-m-malladi@ti.com/

* Changes since v2 (v3-v2):
- Collected Reviewed-by tag from Roger Quadros <rogerq@kernel.org>

 drivers/net/ethernet/ti/icssg/icss_iep.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/ti/icssg/icss_iep.c b/drivers/net/ethernet/ti/icssg/icss_iep.c
index 5d6d1cf78e93..a96861debbe3 100644
--- a/drivers/net/ethernet/ti/icssg/icss_iep.c
+++ b/drivers/net/ethernet/ti/icssg/icss_iep.c
@@ -215,6 +215,10 @@ static void icss_iep_enable_shadow_mode(struct icss_iep *iep)
 	for (cmp = IEP_MIN_CMP; cmp < IEP_MAX_CMP; cmp++) {
 		regmap_update_bits(iep->map, ICSS_IEP_CMP_STAT_REG,
 				   IEP_CMP_STATUS(cmp), IEP_CMP_STATUS(cmp));
+
+		regmap_update_bits(iep->map, ICSS_IEP_CMP_CFG_REG,
+				   IEP_CMP_CFG_CMP_EN(cmp), 0);
+
 	}
 
 	/* enable reset counter on CMP0 event */
@@ -780,6 +784,11 @@ int icss_iep_exit(struct icss_iep *iep)
 	}
 	icss_iep_disable(iep);
 
+	if (iep->pps_enabled)
+		icss_iep_pps_enable(iep, false);
+	else if (iep->perout_enabled)
+		icss_iep_perout_enable(iep, NULL, false);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(icss_iep_exit);
-- 
2.25.1


