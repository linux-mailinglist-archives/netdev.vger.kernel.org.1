Return-Path: <netdev+bounces-163121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8D6A2959B
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 17:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A94121613A1
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D259F19883C;
	Wed,  5 Feb 2025 16:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="I9Zbqyel"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FD8154C1D;
	Wed,  5 Feb 2025 16:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738771309; cv=none; b=iquq2yIhYuzLlsxbO2cVlgz64+l0QXAHDoCJeK4f+06dVNKlV7LT8Ps246Q4PqHx7gvLuQ14un5/SLV4Rd6LRtR0qmbbyjnHykOdMUSJsc6MAps1Rr9Jn6UtWNe4cmFpV/CZ7zeYNhyEtd/EwN/nvgz28ZdaIpi78TA4G+giZ5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738771309; c=relaxed/simple;
	bh=Enx8fjI8mpv5hd03bzqWaf6lquHttoAxyQTNA8BDmeQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fFSSswLiIKHUC915OraWzAVBAtklrGiceryIqXGcxT7awTkgzK0iciVmNcjEo+f6iJhmVQvSwTVd8cAWdSUGlOUDu1y68tCQhpvVDE61Mi8x2W/84q+HfTyDb0UFZNu9nD41A+MaemEG0SHAwMpOWEOCfpy7N4f9S/ypkfDcfPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=I9Zbqyel; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 515G1S2X2628652
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Feb 2025 10:01:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1738771289;
	bh=fGZxVK+AIixjKxkzre/ttdxbnP7tzokMQgPYrUhhzhI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=I9ZbqyeljCB6jstxCKnaKVgLii0ApWW4u4RtFl445FexTNF/EtJxGsD/xV/smEW8x
	 q0wxlrhhUrvlVjH1nrZ3/3NbyOL9ttEoAnO7gKRVgCenA0xkBsdtJNkPOSNDNXTIJt
	 3EhQtnv09geqo3i4XyRXYzkMrPDfEg8ccfLsLH64=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 515G1SXS028582
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 5 Feb 2025 10:01:28 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 5
 Feb 2025 10:01:28 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 5 Feb 2025 10:01:28 -0600
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 515G1R3e055330;
	Wed, 5 Feb 2025 10:01:28 -0600
From: Chintan Vankar <c-vankar@ti.com>
To: Jason Reeder <jreeder@ti.com>, <vigneshr@ti.com>, <nm@ti.com>,
        "Chintan
 Vankar" <c-vankar@ti.com>, Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski
	<kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Thomas Gleixner
	<tglx@linutronix.de>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>, <danishanwar@ti.com>, <m-malladi@ti.com>
Subject: [RFC PATCH 2/2] net: ethernet: ti: am65-cpts: Add support to configure GenF signal for CPTS
Date: Wed, 5 Feb 2025 21:31:19 +0530
Message-ID: <20250205160119.136639-3-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250205160119.136639-1-c-vankar@ti.com>
References: <20250205160119.136639-1-c-vankar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Add support to configure GenFx (periodic signal generator) function which
can be used by Timesync Interrupt Router to map it with CPTS_HWy_TS_PUSH,
in order to generate timestamps at 1 second intervals. This configuration
is optional for CPTS module.

Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---
 drivers/net/ethernet/ti/am65-cpts.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/net/ethernet/ti/am65-cpts.c b/drivers/net/ethernet/ti/am65-cpts.c
index 59d6ab989c55..c32e6c60561d 100644
--- a/drivers/net/ethernet/ti/am65-cpts.c
+++ b/drivers/net/ethernet/ti/am65-cpts.c
@@ -171,6 +171,7 @@ struct am65_cpts {
 	u32 genf_num;
 	u32 ts_add_val;
 	int irq;
+	int genf_irq;
 	struct mutex ptp_clk_lock; /* PHC access sync */
 	u64 timestamp;
 	u32 genf_enable;
@@ -409,6 +410,11 @@ static irqreturn_t am65_cpts_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t am65_cpts_genf_interrupt(int irq, void *dev_id)
+{
+	return IRQ_HANDLED;
+}
+
 /* PTP clock operations */
 static int am65_cpts_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
 {
@@ -1216,6 +1222,21 @@ struct am65_cpts *am65_cpts_create(struct device *dev, void __iomem *regs,
 		goto reset_ptpclk;
 	}
 
+	/*
+	 * This API is used by Timesync Router's driver code to map
+	 * GenFx output of CPTS module with HWx_TS_PUSH input to generate PPS
+	 * signal.
+	 */
+	cpts->genf_irq = of_irq_get_byname(node, "genf");
+	if (cpts->genf_irq > 0) {
+		ret = devm_request_threaded_irq(dev, cpts->genf_irq, NULL,
+						am65_cpts_genf_interrupt,
+						0, dev_name(dev), cpts);
+		if (ret < 0)
+			dev_dbg(cpts->dev, "GENF output will not be routed via Time Sync Interrupt Router
+				%d\n", ret);
+	}
+
 	dev_info(dev, "CPTS ver 0x%08x, freq:%u, add_val:%u pps:%d\n",
 		 am65_cpts_read32(cpts, idver),
 		 cpts->refclk_freq, cpts->ts_add_val, cpts->pps_present);
-- 
2.34.1


