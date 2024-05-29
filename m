Return-Path: <netdev+bounces-99118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AE58D3BD2
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 18:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CB9E1C2348F
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 16:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3861118734D;
	Wed, 29 May 2024 16:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="Ub05n4wz"
X-Original-To: netdev@vger.kernel.org
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EA01836F7
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 16:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716998746; cv=none; b=iPb3xJghV+9U26o9JCBI60gid0allRL+2cb6WPQqyCrDsynIiyMovE/2Oe85fgGU5OxcLmfONjCry9FQSI3bCYyu/Gbw8LDuzzJvJCSdGi+9ueWw2eqZ4AtsNyCKgHzbC6noR7UpBFHU8OhMBHMHk/pPfbDgvTIqjTzuWaKxqXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716998746; c=relaxed/simple;
	bh=GBHTWr2BnrN47pHjde4zU2Ymt2L9Uyv/LPS9yMcrrpQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ki5AHsrlRDmxvmry/rQAzct/KlGdTLwE6qHbmnY2OXEKmckDH4ajdFGNWn9buMomYFiL11asWk9pe/TCnv1OvljNIhp0vmgxas3edgIKswcpq8ZyGaGHGyDhCrmTJcQEhMFrIt9Lm+NeisXniaxfgTbhGP8H1a5jGHcxyYZm8mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=Ub05n4wz; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20240529160536973565ae3a16023d7b
        for <netdev@vger.kernel.org>;
        Wed, 29 May 2024 18:05:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=nwXt6q8QKspJwmhkWLeD3CLZmgPMizmWsw7PtC72yaI=;
 b=Ub05n4wzAPstphetgUBoyH9OsOW1oxLs8CCqs3WasDCip2xIEI6gd7+vCXobNZFCmuNsDq
 DeNKGRm1H5sACHL4jgVMPuDmu1UOSW5jtGo89bCGHdURV44B2bYfJDvDoMYAu3K7qkVUiaBj
 OkjDaDlDcFk0kpT6G00tXTReV62TI=;
From: Diogo Ivo <diogo.ivo@siemens.com>
Date: Wed, 29 May 2024 17:05:11 +0100
Subject: [PATCH 2/3] net: ti: icss-iep: Enable compare events
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-iep-v1-2-7273c07592d3@siemens.com>
References: <20240529-iep-v1-0-7273c07592d3@siemens.com>
In-Reply-To: <20240529-iep-v1-0-7273c07592d3@siemens.com>
To: MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Diogo Ivo <diogo.ivo@siemens.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716998732; l=4374;
 i=diogo.ivo@siemens.com; s=20240529; h=from:subject:message-id;
 bh=GBHTWr2BnrN47pHjde4zU2Ymt2L9Uyv/LPS9yMcrrpQ=;
 b=CBoxiMoLa+EbsUCvAE0tkPjV2/mnvh7/5mbTG4DrmbNhVn/xV6vxoaYZtb8ftR6Rnv9Y5/DSH
 YaBM0ITea7wAdUJOI0/x2wGTDnkPQFX57+6z3uojexZgE3P+4S+62Cj
X-Developer-Key: i=diogo.ivo@siemens.com; a=ed25519;
 pk=BRGXhMh1q5KDlZ9y2B8SodFFY8FGupal+NMtJPwRpUQ=
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1320519:519-21489:flowmailer

The IEP module supports compare events, in which a value is written to a
hardware register and when the IEP counter reaches the written value an
interrupt is generated. Add handling for this interrupt in order to
support PPS events.

Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
---
 drivers/net/ethernet/ti/icssg/icss_iep.c | 71 ++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/drivers/net/ethernet/ti/icssg/icss_iep.c b/drivers/net/ethernet/ti/icssg/icss_iep.c
index 3025e9c18970..8337508ce8f0 100644
--- a/drivers/net/ethernet/ti/icssg/icss_iep.c
+++ b/drivers/net/ethernet/ti/icssg/icss_iep.c
@@ -17,6 +17,7 @@
 #include <linux/timekeeping.h>
 #include <linux/interrupt.h>
 #include <linux/of_irq.h>
+#include <linux/workqueue.h>
 
 #include "icss_iep.h"
 
@@ -122,6 +123,7 @@ struct icss_iep {
 	int cap_cmp_irq;
 	u64 period;
 	u32 latch_enable;
+	struct work_struct work;
 };
 
 /**
@@ -571,6 +573,55 @@ static int icss_iep_perout_enable(struct icss_iep *iep,
 	return ret;
 }
 
+static void icss_iep_cap_cmp_work(struct work_struct *work)
+{
+	struct icss_iep *iep = container_of(work, struct icss_iep, work);
+	struct ptp_clock_event pevent;
+	unsigned int val;
+	u64 ns, ns_next;
+
+	spin_lock(&iep->irq_lock);
+
+	ns = readl(iep->base + iep->plat_data->reg_offs[ICSS_IEP_CMP1_REG0]);
+	if (iep->plat_data->flags & ICSS_IEP_64BIT_COUNTER_SUPPORT) {
+		val = readl(iep->base + iep->plat_data->reg_offs[ICSS_IEP_CMP1_REG1]);
+		ns |= (u64)val << 32;
+	}
+	/* set next event */
+	ns_next = ns + iep->period;
+	writel(lower_32_bits(ns_next),
+	       iep->base + iep->plat_data->reg_offs[ICSS_IEP_CMP1_REG0]);
+	if (iep->plat_data->flags & ICSS_IEP_64BIT_COUNTER_SUPPORT)
+		writel(upper_32_bits(ns_next),
+		       iep->base + iep->plat_data->reg_offs[ICSS_IEP_CMP1_REG1]);
+
+	pevent.pps_times.ts_real = ns_to_timespec64(ns);
+	pevent.type = PTP_CLOCK_PPSUSR;
+	pevent.index = 0;
+	ptp_clock_event(iep->ptp_clock, &pevent);
+	dev_dbg(iep->dev, "IEP:pps ts: %llu next:%llu:\n", ns, ns_next);
+
+	spin_unlock(&iep->irq_lock);
+}
+
+static irqreturn_t icss_iep_cap_cmp_irq(int irq, void *dev_id)
+{
+	struct icss_iep *iep = (struct icss_iep *)dev_id;
+	unsigned int val;
+
+	val = readl(iep->base + iep->plat_data->reg_offs[ICSS_IEP_CMP_STAT_REG]);
+	/* The driver only enables CMP1 */
+	if (val & BIT(1)) {
+		/* Clear the event */
+		writel(BIT(1), iep->base + iep->plat_data->reg_offs[ICSS_IEP_CMP_STAT_REG]);
+		if (iep->pps_enabled || iep->perout_enabled)
+			schedule_work(&iep->work);
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
 static int icss_iep_pps_enable(struct icss_iep *iep, int on)
 {
 	struct ptp_clock_request rq;
@@ -602,6 +653,8 @@ static int icss_iep_pps_enable(struct icss_iep *iep, int on)
 		ret = icss_iep_perout_enable_hw(iep, &rq.perout, on);
 	} else {
 		ret = icss_iep_perout_enable_hw(iep, &rq.perout, on);
+		if (iep->cap_cmp_irq)
+			cancel_work_sync(&iep->work);
 	}
 
 	if (!ret)
@@ -777,6 +830,8 @@ int icss_iep_init(struct icss_iep *iep, const struct icss_iep_clockops *clkops,
 	if (iep->ops && iep->ops->perout_enable) {
 		iep->ptp_info.n_per_out = 1;
 		iep->ptp_info.pps = 1;
+	} else if (iep->cap_cmp_irq) {
+		iep->ptp_info.pps = 1;
 	}
 
 	if (iep->ops && iep->ops->extts_enable)
@@ -817,6 +872,7 @@ static int icss_iep_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct icss_iep *iep;
 	struct clk *iep_clk;
+	int ret;
 
 	iep = devm_kzalloc(dev, sizeof(*iep), GFP_KERNEL);
 	if (!iep)
@@ -827,6 +883,21 @@ static int icss_iep_probe(struct platform_device *pdev)
 	if (IS_ERR(iep->base))
 		return -ENODEV;
 
+	iep->cap_cmp_irq = platform_get_irq_byname_optional(pdev, "iep_cap_cmp");
+	if (iep->cap_cmp_irq < 0) {
+		if (iep->cap_cmp_irq == -EPROBE_DEFER)
+			return iep->cap_cmp_irq;
+		iep->cap_cmp_irq = 0;
+	} else {
+		ret = devm_request_irq(dev, iep->cap_cmp_irq,
+				       icss_iep_cap_cmp_irq, IRQF_TRIGGER_HIGH,
+				       "iep_cap_cmp", iep);
+		if (ret)
+			return dev_err_probe(iep->dev, ret,
+					     "Request irq failed for cap_cmp\n");
+		INIT_WORK(&iep->work, icss_iep_cap_cmp_work);
+	}
+
 	iep_clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(iep_clk))
 		return PTR_ERR(iep_clk);

-- 
2.45.1


