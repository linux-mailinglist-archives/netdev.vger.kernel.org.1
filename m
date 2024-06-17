Return-Path: <netdev+bounces-104144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 658BA90B50E
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 17:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D95D61F24FC4
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 15:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB7F15AD95;
	Mon, 17 Jun 2024 15:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="PPK0kgPl"
X-Original-To: netdev@vger.kernel.org
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4447215A865
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 15:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718637753; cv=none; b=u7Sjamrr5KJeZ2l7rhoGoRiqB5udZBossuk061rYwhOtru+6Ku/9LM2s0yO3lfhfgAZoxVUp7sovaEZsMrRfYCSsZAygIq+FWvFz72w5X2ReyrPPbJh7u5pz50WH5KpuzAqy07jRRasGJu8L73f9tYjGQI/XZunRtsKaGf/1Jos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718637753; c=relaxed/simple;
	bh=fO1eAsDw//HX2p9KxidsmYOgQKS3QAodQl/810m/2AY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HFqf2nB278nRbYstCiHTvstyO5QxlTwA4wK0PqDES66KIsGFXs3ri7zEks/ODBMHtCbNBRv1sS5S2gu8KVtKXpDgKa87ugqizMbDFZBTyj6BOZFoZyvlj6otchL/HEHzCCRViAe/Kict4bN4QZklk31lCuXIGZq5ti/fEK7gey8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=PPK0kgPl; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20240617152230ad090e4a6b00c83149
        for <netdev@vger.kernel.org>;
        Mon, 17 Jun 2024 17:22:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=57dUQPLvnS8ZYgZDKTpi5rNWIAVWWGiuIo2qscKtvtg=;
 b=PPK0kgPl2PmHQT914CoAaKQoU9FxwYMxlRbCO9LmBo+tVGs274t4q6r/CiCzgeqguWC/2O
 TsGbNXLq42PsqQFU6V6frZFrTAwzPd584iKzPfZqA+H6xAgwuPbJuSt1a7Yz8wuCCa/1VU/9
 DvvLr1HnuYIZl1VDEkVf+98sSVofA=;
From: Diogo Ivo <diogo.ivo@siemens.com>
Date: Mon, 17 Jun 2024 16:21:43 +0100
Subject: [PATCH net-next v4 4/5] net: ti: icss-iep: Enable compare events
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240617-iep-v4-4-fa20ff4141a3@siemens.com>
References: <20240617-iep-v4-0-fa20ff4141a3@siemens.com>
In-Reply-To: <20240617-iep-v4-0-fa20ff4141a3@siemens.com>
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
 Diogo Ivo <diogo.ivo@siemens.com>, 
 Wojciech Drewek <wojciech.drewek@intel.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718637741; l=4428;
 i=diogo.ivo@siemens.com; s=20240529; h=from:subject:message-id;
 bh=fO1eAsDw//HX2p9KxidsmYOgQKS3QAodQl/810m/2AY=;
 b=iMQ7miuewdgkUjwbfheQtTO0XmunnIbQk0W6zNLcK5l/tmDITDomUUgQu3M77vVJepsIBAWkZ
 isO/GJs6ihBBabB4yi7Z5LmI4uDjS2ouwhrqT00AJgwMkXEB21PqndW
X-Developer-Key: i=diogo.ivo@siemens.com; a=ed25519;
 pk=BRGXhMh1q5KDlZ9y2B8SodFFY8FGupal+NMtJPwRpUQ=
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1320519:519-21489:flowmailer

The IEP module supports compare events, in which a value is written to a
hardware register and when the IEP counter reaches the written value an
interrupt is generated. Add handling for this interrupt in order to
support PPS events.

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
---
 drivers/net/ethernet/ti/icssg/icss_iep.c | 74 ++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/drivers/net/ethernet/ti/icssg/icss_iep.c b/drivers/net/ethernet/ti/icssg/icss_iep.c
index d52e42fa64f2..003668dee738 100644
--- a/drivers/net/ethernet/ti/icssg/icss_iep.c
+++ b/drivers/net/ethernet/ti/icssg/icss_iep.c
@@ -17,6 +17,7 @@
 #include <linux/timekeeping.h>
 #include <linux/interrupt.h>
 #include <linux/of_irq.h>
+#include <linux/workqueue.h>
 
 #include "icss_iep.h"
 
@@ -121,6 +122,7 @@ struct icss_iep {
 	int cap_cmp_irq;
 	u64 period;
 	u32 latch_enable;
+	struct work_struct work;
 };
 
 /**
@@ -563,6 +565,57 @@ static int icss_iep_perout_enable(struct icss_iep *iep,
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
+	mutex_lock(&iep->ptp_clk_mutex);
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
+	mutex_unlock(&iep->ptp_clk_mutex);
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
@@ -591,6 +644,8 @@ static int icss_iep_pps_enable(struct icss_iep *iep, int on)
 		ret = icss_iep_perout_enable_hw(iep, &rq.perout, on);
 	} else {
 		ret = icss_iep_perout_enable_hw(iep, &rq.perout, on);
+		if (iep->cap_cmp_irq)
+			cancel_work_sync(&iep->work);
 	}
 
 	if (!ret)
@@ -764,6 +819,8 @@ int icss_iep_init(struct icss_iep *iep, const struct icss_iep_clockops *clkops,
 	if (iep->ops && iep->ops->perout_enable) {
 		iep->ptp_info.n_per_out = 1;
 		iep->ptp_info.pps = 1;
+	} else if (iep->cap_cmp_irq) {
+		iep->ptp_info.pps = 1;
 	}
 
 	if (iep->ops && iep->ops->extts_enable)
@@ -804,6 +861,7 @@ static int icss_iep_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct icss_iep *iep;
 	struct clk *iep_clk;
+	int ret, irq;
 
 	iep = devm_kzalloc(dev, sizeof(*iep), GFP_KERNEL);
 	if (!iep)
@@ -814,6 +872,22 @@ static int icss_iep_probe(struct platform_device *pdev)
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


