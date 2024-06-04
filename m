Return-Path: <netdev+bounces-100565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D1F8FB350
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 15:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2984B26160
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 13:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C330214532F;
	Tue,  4 Jun 2024 13:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="wOYgqgAn"
X-Original-To: netdev@vger.kernel.org
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1321DDDB
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 13:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717506938; cv=none; b=VWSmAWjMUybgkmWQMl/bqCSEXVb3GfpBoOrCZC3aAT5A5NJX8cHRRxHQnG81bR1ycCUN5kDdDIFG+96QTNaUDj9xApM7IipT/fB+vPGVwQikb7VtyvKAi7Kj8xx8ZVgA14gYWb1KZgsOWUYddjKo7i2ebzXqrAyVrEXFFLblsgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717506938; c=relaxed/simple;
	bh=tYEiktMsYhEI/3DljhvYKcxvngWwY2GgTbEqPcF9Oes=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iOV+pVmrvKa3sqZEohue9PggLyJ0FxLSYtSF0qOg5qwyYYXyb4Q0UXiRTUvJqJbEbsU9/ivRfP0Jo45Vhg/qSXnRkLYpWsr3M70v0IVZ6kAk076DfnJjqyIbD9HvCKGi3u6uO/9d8cxUZZhIlWGebz03E2Zz629q4toZUrabnig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=wOYgqgAn; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202406041315283b9a37c8a571feacec
        for <netdev@vger.kernel.org>;
        Tue, 04 Jun 2024 15:15:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=cUuJQtWj1E6BZdNmi0B8/vzR0ETmxqYy2zTQzpCKm6M=;
 b=wOYgqgAnWbti+b2j+7p+wtA8wJCBsNOh1svd2qPQtMQIa8vYdgb3hlsRa0LmDVo/avZmRe
 9nR8Ld4uZ7ouvolcg/H9x2b6dbXb6qw1HRLX9vbXaGU0G1RLxU/sSImgmEPknS7kMoHectK2
 zLvviWMpEx6YvKDycEbZZLLrASHbw=;
From: Diogo Ivo <diogo.ivo@siemens.com>
Date: Tue, 04 Jun 2024 14:15:11 +0100
Subject: [PATCH net-next v2 2/3] net: ti: icss-iep: Enable compare events
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240604-iep-v2-2-ea8e1c0a5686@siemens.com>
References: <20240604-iep-v2-0-ea8e1c0a5686@siemens.com>
In-Reply-To: <20240604-iep-v2-0-ea8e1c0a5686@siemens.com>
To: MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
 Jacob Keller <jacob.e.keller@intel.com>, Simon Horman <horms@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Diogo Ivo <diogo.ivo@siemens.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717506924; l=4358;
 i=diogo.ivo@siemens.com; s=20240529; h=from:subject:message-id;
 bh=tYEiktMsYhEI/3DljhvYKcxvngWwY2GgTbEqPcF9Oes=;
 b=BFtMrBXcc91356i3IxivZAU1rk5nWyrqL8iLM1cUkHdKOdkb+CRQaSXouphOkh5S3dCPt/R5z
 Lo6AU1xN9+7AvmUp7HUExx0PbWz9i3pTuRIGAiWKVRcMOxqeHUnME2o
X-Developer-Key: i=diogo.ivo@siemens.com; a=ed25519;
 pk=BRGXhMh1q5KDlZ9y2B8SodFFY8FGupal+NMtJPwRpUQ=
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1320519:519-21489:flowmailer

The IEP module supports compare events, in which a value is written to a
hardware register and when the IEP counter reaches the written value an
interrupt is generated. Add handling for this interrupt in order to
support PPS events.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
---
 drivers/net/ethernet/ti/icssg/icss_iep.c | 74 ++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/drivers/net/ethernet/ti/icssg/icss_iep.c b/drivers/net/ethernet/ti/icssg/icss_iep.c
index 3025e9c18970..b076be9c527c 100644
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
@@ -571,6 +573,57 @@ static int icss_iep_perout_enable(struct icss_iep *iep,
 	return ret;
 }
 
+static void icss_iep_cap_cmp_work(struct work_struct *work)
+{
+	struct icss_iep *iep = container_of(work, struct icss_iep, work);
+	const u32 *reg_offs = iep->plat_data->reg_offs;
+	struct ptp_clock_event pevent;
+	unsigned int val;
+	u64 ns, ns_next;
+
+	spin_lock(&iep->irq_lock);
+
+	ns = readl(iep->base + reg_offs[ICSS_IEP_CMP1_REG0]);
+	if (iep->plat_data->flags & ICSS_IEP_64BIT_COUNTER_SUPPORT) {
+		val = readl(iep->base + reg_offs[ICSS_IEP_CMP1_REG1]);
+		ns |= (u64)val << 32;
+	}
+	/* set next event */
+	ns_next = ns + iep->period;
+	writel(lower_32_bits(ns_next),
+	       iep->base + reg_offs[ICSS_IEP_CMP1_REG0]);
+	if (iep->plat_data->flags & ICSS_IEP_64BIT_COUNTER_SUPPORT)
+		writel(upper_32_bits(ns_next),
+		       iep->base + reg_offs[ICSS_IEP_CMP1_REG1]);
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
+	const u32 *reg_offs = iep->plat_data->reg_offs;
+	unsigned int val;
+
+	val = readl(iep->base + reg_offs[ICSS_IEP_CMP_STAT_REG]);
+	/* The driver only enables CMP1 */
+	if (val & BIT(1)) {
+		/* Clear the event */
+		writel(BIT(1), iep->base + reg_offs[ICSS_IEP_CMP_STAT_REG]);
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
@@ -602,6 +655,8 @@ static int icss_iep_pps_enable(struct icss_iep *iep, int on)
 		ret = icss_iep_perout_enable_hw(iep, &rq.perout, on);
 	} else {
 		ret = icss_iep_perout_enable_hw(iep, &rq.perout, on);
+		if (iep->cap_cmp_irq)
+			cancel_work_sync(&iep->work);
 	}
 
 	if (!ret)
@@ -777,6 +832,8 @@ int icss_iep_init(struct icss_iep *iep, const struct icss_iep_clockops *clkops,
 	if (iep->ops && iep->ops->perout_enable) {
 		iep->ptp_info.n_per_out = 1;
 		iep->ptp_info.pps = 1;
+	} else if (iep->cap_cmp_irq) {
+		iep->ptp_info.pps = 1;
 	}
 
 	if (iep->ops && iep->ops->extts_enable)
@@ -817,6 +874,7 @@ static int icss_iep_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct icss_iep *iep;
 	struct clk *iep_clk;
+	int ret, irq;
 
 	iep = devm_kzalloc(dev, sizeof(*iep), GFP_KERNEL);
 	if (!iep)
@@ -827,6 +885,22 @@ static int icss_iep_probe(struct platform_device *pdev)
 	if (IS_ERR(iep->base))
 		return -ENODEV;
 
+	irq = platform_get_irq_byname_optional(pdev, "iep_cap_cmp");
+	if (irq == -EPROBE_DEFER)
+		return irq;
+
+	if (irq > 0) {
+		ret = devm_request_irq(dev, irq, icss_iep_cap_cmp_irq,
+				       IRQF_TRIGGER_HIGH, "iep_cap_cmp", iep);
+		if (ret) {
+			dev_info(iep->dev, "cap_cmp irq request failed: %x\n",
+				 ret);
+		} else {
+			iep->cap_cmp_irq = irq;
+			INIT_WORK(&iep->work, icss_iep_cap_cmp_work);
+		}
+	}
+
 	iep_clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(iep_clk))
 		return PTR_ERR(iep_clk);

-- 
2.45.2


