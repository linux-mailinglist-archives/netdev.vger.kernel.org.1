Return-Path: <netdev+bounces-163122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C1EA2959F
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 17:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B94371886AED
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27C319884C;
	Wed,  5 Feb 2025 16:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vTPaHc5c"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01028190685;
	Wed,  5 Feb 2025 16:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738771309; cv=none; b=gTSklEUmSuSGPIr5B2h9JZf/Zxa9j6y3rSf47DgDz6x2Nj6si+MJGJZIqUhZa5NjVvzFzNFIa+5u7B24/QBgc92RdH2Sp0e02iN0F2kFM1p+SFdOc8wrOjSYoCS5RW3P071scmy91SWJcNYAycbVA3t+hvDn663Pb27rmVdVRTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738771309; c=relaxed/simple;
	bh=cW6AZrn+HbhqnqWaZmBExnziWa4NQpa86V2vNEyLA7M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AYttItmL08gU2D850wXJXjWvLumd1JziRIUn0wkdtqpjP1NcLCxEQwNYICMvX1x5/Nrm3+pp772iZaDKObEeMLctJnqSwWzvLs2MWIJsPH1qD6i1buoTv16liCOuXU53ZRbbsMTd+X1R213Dl7CQlBwQO1w4d06HwWItvk46cO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vTPaHc5c; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 515G1RwM2628648
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 5 Feb 2025 10:01:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1738771287;
	bh=UeNsg0C7mYNScV6RqFrjfgKhb5kKMjO3hjrkgI6tI/E=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=vTPaHc5cs40g5/SGMnRgwlEJERdbl4VoyVFGdinOUbnJZKjAmGvP38GjkKc9uU6EN
	 qQLCACgACkuTnjohT621UNjmBtVG23/HIF3JcuHWk8yRW56xEpa2vzQUSTfjr0DzwL
	 T476QYQWCWGpp8+ZzmEhUzSdCrPXC02Lf+o4BgZA=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 515G1ROw027805;
	Wed, 5 Feb 2025 10:01:27 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 5
 Feb 2025 10:01:26 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 5 Feb 2025 10:01:26 -0600
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 515G1QgC055307;
	Wed, 5 Feb 2025 10:01:26 -0600
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
Subject: [RFC PATCH 1/2] irqchip: ti-tsir: Add support for Timesync Interrupt Router
Date: Wed, 5 Feb 2025 21:31:18 +0530
Message-ID: <20250205160119.136639-2-c-vankar@ti.com>
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

Timesync Interrupt Router is an instantiation of generic interrupt router
module. It provides a mechanism to mux M interrupt inputs to N interrupt
outputs, where all M inputs are selectable to be driven as per N output.
Timesync Interrupt Router's inputs are either from peripherals or from
Device sync Events.

Add support for Timesync Interrupt Router driver to map input received
from peripherals with the corresponding output.

Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---
 drivers/irqchip/Kconfig            |   9 +++
 drivers/irqchip/Makefile           |   1 +
 drivers/irqchip/ti-timesync-intr.c | 109 +++++++++++++++++++++++++++++
 3 files changed, 119 insertions(+)
 create mode 100644 drivers/irqchip/ti-timesync-intr.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index c11b9965c4ad..48b9d907be0f 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -557,6 +557,15 @@ config TI_SCI_INTA_IRQCHIP
 	  If you wish to use interrupt aggregator irq resources managed by the
 	  TI System Controller, say Y here. Otherwise, say N.
 
+config TI_TS_INTR
+	bool
+	select IRQ_DOMAIN_HIERARCHY
+	help
+	  This enables the irqchip driver support for K3 Timesync Interrupt
+	  router available on TI's SoCs.
+	  To enable Timesync Interrupt Router's mapping, say Y here. Otherwise
+	  say N.
+
 config TI_PRUSS_INTC
 	tristate
 	depends on TI_PRUSS
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 25e9ad29b8c4..00c49f6d492a 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -129,3 +129,4 @@ obj-$(CONFIG_IRQ_IDT3243X)		+= irq-idt3243x.o
 obj-$(CONFIG_APPLE_AIC)			+= irq-apple-aic.o
 obj-$(CONFIG_MCHP_EIC)			+= irq-mchp-eic.o
 obj-$(CONFIG_SUNPLUS_SP7021_INTC)	+= irq-sp7021-intc.o
+obj-$(CONFIG_TS_INTR)			+= ti-timesync-intr.o
diff --git a/drivers/irqchip/ti-timesync-intr.c b/drivers/irqchip/ti-timesync-intr.c
new file mode 100644
index 000000000000..11f26ca649d2
--- /dev/null
+++ b/drivers/irqchip/ti-timesync-intr.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL
+/*
+ * Texas Instruments K3 Timesync Interrupt Router driver
+ *
+ * Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/
+ *	Chintan Vankar <c-vankar@ti.com>
+ */
+
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <linux/of_address.h>
+#include <linux/list.h>
+
+#define DRIVER_NAME	"ti-tsir"
+
+#define TIMESYNC_INTRTR_ENABLE			GENMASK(5, 0)
+#define TIMESYNC_INTRTR_INT_ENABLE		BIT(16)
+#define TIMESYNC_INTRTR_MAX_OUTPUT_LINES	48
+
+struct tsr_chip_data {
+	void __iomem		*tsr_base;
+	struct irq_domain	*domain;
+	u64			flags;
+};
+
+static struct irq_chip ts_intr_irq_chip = {
+	.name			= "TIMESYNC_INTRTR",
+};
+
+static u32 output_line_to_virq[TIMESYNC_INTRTR_MAX_OUTPUT_LINES];
+static struct tsr_chip_data tsr_data;
+
+static int ts_intr_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				    unsigned int nr_irqs, void *arg)
+{
+	unsigned int output_line, input_line, output_line_offset;
+	struct irq_fwspec *fwspec = (struct irq_fwspec *)arg;
+	int ret;
+
+	irq_domain_set_hwirq_and_chip(domain, virq, output_line,
+				      &ts_intr_irq_chip,
+				      NULL);
+
+	/* Check for two input parameters: output line and corresponding input line */
+	if (fwspec->param_count != 2)
+		return -EINVAL;
+
+	output_line = fwspec->param[0];
+
+	/* Timesync Interrupt Router's mux-controller register starts at offset 4 from base
+	 * address and each output line are at offset in multiple of 4s in Timesync INTR's
+	 * register space, calculate the register offset from provided output line.
+	 */
+	output_line_offset = 4 * output_line + 0x4;
+	output_line_to_virq[output_line] = virq;
+	input_line = fwspec->param[1] & TIMESYNC_INTRTR_ENABLE;
+
+	/* Map output line corresponding to input line */
+	writel(input_line, tsr_data.tsr_base + output_line_offset);
+
+	/* When interrupt enable bit is set for Timesync Interrupt Router it maps the output
+	 * line with the existing input line, hence enable interrupt line after we set bits for
+	 * output line.
+	 */
+	input_line |= TIMESYNC_INTRTR_INT_ENABLE;
+	writel(input_line, tsr_data.tsr_base + output_line_offset);
+
+	return 0;
+}
+
+static void ts_intr_irq_domain_free(struct irq_domain *domain, unsigned int virq,
+				    unsigned int nr_irqs)
+{
+	struct output_line_to_virq *node, *n;
+	unsigned int output_line_offset;
+	int i;
+
+	for (i = 0; i < TIMESYNC_INTRTR_MAX_OUTPUT_LINES; i++) {
+		if (output_line_to_virq[i] == virq) {
+			/* Calculate the register offset value from provided output line */
+			output_line_offset = 4 * i + 0x4;
+			writel(~TIMESYNC_INTRTR_INT_ENABLE, tsr_data.tsr_base + output_line_offset);
+		}
+	}
+}
+
+static const struct irq_domain_ops ts_intr_irq_domain_ops = {
+	.alloc		= ts_intr_irq_domain_alloc,
+	.free		= ts_intr_irq_domain_free,
+};
+
+static int tsr_init(struct device_node *node)
+{
+	tsr_data.tsr_base = of_iomap(node, 0);
+	if (IS_ERR(tsr_data.tsr_base)) {
+		pr_err("Unable to get reg\n");
+		return PTR_ERR(tsr_data.tsr_base);
+	}
+
+	tsr_data.domain = irq_domain_create_tree(&node->fwnode, &ts_intr_irq_domain_ops, &tsr_data);
+
+	return 0;
+}
+
+IRQCHIP_DECLARE(ts_intr, "ti,ts-intr", tsr_init);
+
+MODULE_AUTHOR("Chintan Vankar <c-vankar@ti.com>");
+MODULE_DESCRIPTION("Driver to configure Timesync Interrupt Router");
+MODULE_LICENSE("GPL");
-- 
2.34.1


