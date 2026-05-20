Return-Path: <netdev+bounces-290076-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Lg0JFI1DmpN8QUAu9opvQ
	(envelope-from <netdev+bounces-290076-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 00:27:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C7F59C004
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 00:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A30963702D65
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 19:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69178341650;
	Wed, 20 May 2026 19:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqypyNd2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A53734A3D6
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 19:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779304875; cv=none; b=K52G5HewkekeTXQpbVeQrgvOmyr9sZGiU9cWED1sGU5O684YruJD3Tz5xbh3eQJovYKeZHa78MgbtidedTHnAWu6D3p+/EN9p9XhnPWS8SIRrE2F5KvsaJjf4HtQpEfRZR4TbT12hAF6upF1GnLA4/CGxjC81MwKiH4C1BjRiqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779304875; c=relaxed/simple;
	bh=1EHGQJVTvHcO0NWr+LthnDbKaBH8nWe0hgGTxx14wuI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uF3nUFkzLez2dTqNAsZTdGAeHZ82+eZ6oUoFQc8KQ5SvlQE2oYhwVCiOZ1wQufKBVsl7VRVcIDzFpNYQ3qCKWIZH0DHuk93Q66jpP5oJpTav5rj8pjj+VlBarA4aXWhV/AdtGF7uiyYlFtC6Kn48Cf2ANBMWfmaS16Lvsb7l4dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MqypyNd2; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7bdc947aa88so41605557b3.3
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 12:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779304866; x=1779909666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DEyh6yovzT6JB+lKAKq8HHwrVrpjTTej4bpwK3FkXdc=;
        b=MqypyNd2PZgS3nhTAuL68LiuH84GFjBsNnWDWHWHzdOcVXsDkJC+qZMarnfjME0MAE
         +bHeFW6dkba+s/azo7/IlEYQ8GhrnUAZFRzUo9txVM9Gs4d4A4SsspfLlCfmdBS7nFhy
         M6MP0yMJUCFky68z+ObP8WP8YYPPnWRa7/EELVCtlbxyhuDBal94/9EhArieW+kEpGk2
         c/0GTMnZfVsxRQzYsR1gGEyR1e4aY4nmcWp4eBjhOAUyRwGE9dVsiAlPdyBKnDsELFvl
         w5FgkoANGORxdGJ84aZBeYj4CE/G+d7I/+oJjjX4rMXBWKpIqJW7blcBbJ9MnRrIs6bq
         Bjhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779304866; x=1779909666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DEyh6yovzT6JB+lKAKq8HHwrVrpjTTej4bpwK3FkXdc=;
        b=rI6hkdbibnC3ntbk5KPp/kk/eFCFCvd7S2ae5BW9XNzyH8D6J8Zt8Sdm86FsRjmsZg
         TmcHzRJ3tntYIUJB+cj8IrYo7whezK96W50+IZmqqxlSQiNxl/gwq6vG+yZVeXPv4Ir9
         FqxGvTSWSTTUevfeZBX6dz50BYnBonnsG+PcJAvL87CWjHH0msZmWcSvFGT879lfIdxR
         uZEKwkx4fOsGhu280SXsuZHD2QTkcJ5f0pXt7+UrKONrvP5kfNDDQtHmlw3VKmXMA/iF
         UvR8V7iviJ8pAp46X0GltcqryXC3VJyyPWGhORhpFbFD8h4RIIn8ajZXdtYUU4xg+oc5
         YYYA==
X-Forwarded-Encrypted: i=1; AFNElJ8k+jQTe9yuOAa01PJ2sCpPeklqPdyWXbE050SLWuM/VlULBffOfTyMCDa0Ql2hkNhBMeP3UOg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/43M8+P6fibm1LCLtQ9hrQyHS2c9XcYKOrg+Qpv+P0yXIswgY
	2rnJPEUnt9iPWydfPNmlSkQdKfCMvW0muyRyvapCXxzbrZ+RYtK+dQc=
X-Gm-Gg: Acq92OFrXHVTMruNo1gbGvEXE3s4sQQY2PnlQTraELjGQ26mBEZ57zlvtKzD9vE4DVH
	05yKF1MC9YO/MXNo+D2orh3Bs7OMWiCliW1vK8FPkO/FJ535mto/9uOUjv2J16ud8FAB3++wMvV
	ymk38tXdMudSzGRzu3rENTdWeDq0+LR4NuHKbWCPSBOGTPKL9oWADOFftjOo4jeE1/zhL+HuePk
	8yv/Y9q3Lh/VICogoKNzxbvu9E4kOkjxZO1KkjCYKwtQrcenFtnV16TT5h8cxiSt7fE8zzaSVBS
	fZ2CgKm+qVeZQyzRcUS4XdyL66X0UOUAt16rRVKLbWkVg42lXOl49HO4nwyUVhhSR7xengM1ipB
	a5c1+uoj1L5JWA32zz19ZMauS08GUvHi9SnwLbOeZBsxBB/5Af1g+bOFQroDIjf4iDj0IJFg3ZN
	K+r0XA1QSmKbtCueFXkhEilsbYCKCeZwWkFEziJfu0NrjpPJw4Gt25Eaai
X-Received: by 2002:a05:690c:f15:b0:7b3:ca3b:84a4 with SMTP id 00721157ae682-7c95aa5f23amr273028787b3.18.1779304865390;
        Wed, 20 May 2026 12:21:05 -0700 (PDT)
Received: from alir-mac.sitimecorp.com ([12.1.37.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc9d18dcddsm56346757b3.49.2026.05.20.12.21.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 20 May 2026 12:21:04 -0700 (PDT)
From: Ali Rouhi <rouhi.ali@gmail.com>
X-Google-Original-From: Ali Rouhi <arouhi@sitime.com>
To: jiri@resnulli.us
Cc: vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	cjubran@nvidia.com,
	Oleg.Zadorozhnyi@devoxsoftware.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ali Rouhi <arouhi@sitime.com>
Subject: [PATCH v2 net-next 3/3] dpll: add SiTime SiT9531x DPLL clock driver
Date: Wed, 20 May 2026 12:19:43 -0700
Message-Id: <20260520191943.73938-4-arouhi@sitime.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20260520191943.73938-1-arouhi@sitime.com>
References: <20260520191943.73938-1-arouhi@sitime.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-290076-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rouhiali@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sitime.com:mid,sitime.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,work.work:url,zx2c4.com:email,devoxsoftware.com:email]
X-Rspamd-Queue-Id: 66C7F59C004
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a DPLL subsystem driver for the SiTime SiT95316 and SiT95317
clock generators. These devices provide low-jitter clock outputs
commonly used in telecom, networking, and data center timing
applications.

The driver exposes all inputs and outputs through the Linux DPLL
subsystem, supporting:
 - Lock status monitoring via register polling or optional INTRB IRQ
 - Input priority management for automatic reference switchover
 - Per-output frequency readback from hardware state
 - DCO (digitally controlled oscillator) frequency adjustment
 - Phase offset measurement via TDC (time-to-digital converter)
 - Phase adjustment for fine output alignment
 - Embedded sync (esync) pulse control
 - SYSREF/SYNCB/Pulser output mode control
 - Optional reset-gpios for hardware reset

The driver reads all configuration from the device's on-chip NVM
at probe time -- no firmware loading is required.

Co-developed-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>
Assisted-by: Claude:claude-4-opus [chat]
Signed-off-by: Ali Rouhi <arouhi@sitime.com>
---
 MAINTAINERS                    |    6 +
 drivers/dpll/Kconfig           |    1 +
 drivers/dpll/Makefile          |    1 +
 drivers/dpll/sit9531x/Kconfig  |   17 +
 drivers/dpll/sit9531x/Makefile |    4 +
 drivers/dpll/sit9531x/core.c   | 2636 ++++++++++++++++++++++++++++++++
 drivers/dpll/sit9531x/core.h   |  282 ++++
 drivers/dpll/sit9531x/dpll.c   | 1147 ++++++++++++++
 drivers/dpll/sit9531x/dpll.h   |   90 ++
 drivers/dpll/sit9531x/prop.c   |  345 +++++
 drivers/dpll/sit9531x/prop.h   |   39 +
 drivers/dpll/sit9531x/regs.h   |  359 +++++
 12 files changed, 4927 insertions(+)
 create mode 100644 drivers/dpll/sit9531x/Kconfig
 create mode 100644 drivers/dpll/sit9531x/Makefile
 create mode 100644 drivers/dpll/sit9531x/core.c
 create mode 100644 drivers/dpll/sit9531x/core.h
 create mode 100644 drivers/dpll/sit9531x/dpll.c
 create mode 100644 drivers/dpll/sit9531x/dpll.h
 create mode 100644 drivers/dpll/sit9531x/prop.c
 create mode 100644 drivers/dpll/sit9531x/prop.h
 create mode 100644 drivers/dpll/sit9531x/regs.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 27a073f53cea..1aff4e9d192c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24527,6 +24527,12 @@ F:	drivers/gpio/gpio-siox.c
 F:	drivers/siox/*
 F:	include/trace/events/siox.h
 
+SITIME SIT9531X DPLL DRIVER
+M:	Ali Rouhi <arouhi@sitime.com>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	drivers/dpll/sit9531x/
+
 SIPHASH PRF ROUTINES
 M:	Jason A. Donenfeld <Jason@zx2c4.com>
 S:	Maintained
diff --git a/drivers/dpll/Kconfig b/drivers/dpll/Kconfig
index be98969f040a..ea77b9c11ab1 100644
--- a/drivers/dpll/Kconfig
+++ b/drivers/dpll/Kconfig
@@ -23,6 +23,7 @@ config DPLL_REFCNT_TRACKER
 
 	  If unsure, say N.
 
+source "drivers/dpll/sit9531x/Kconfig"
 source "drivers/dpll/zl3073x/Kconfig"
 
 endmenu
diff --git a/drivers/dpll/Makefile b/drivers/dpll/Makefile
index 9e7a3a3e592e..4adc50d748d4 100644
--- a/drivers/dpll/Makefile
+++ b/drivers/dpll/Makefile
@@ -8,4 +8,5 @@ dpll-y                  += dpll_core.o
 dpll-y                  += dpll_netlink.o
 dpll-y                  += dpll_nl.o
 
+obj-$(CONFIG_SIT9531X_DPLL)	+= sit9531x/
 obj-$(CONFIG_ZL3073X)	+= zl3073x/
diff --git a/drivers/dpll/sit9531x/Kconfig b/drivers/dpll/sit9531x/Kconfig
new file mode 100644
index 000000000000..d5b3ee4af69c
--- /dev/null
+++ b/drivers/dpll/sit9531x/Kconfig
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config SIT9531X_DPLL
+	tristate "SiTime SiT9531x DPLL driver"
+	depends on I2C
+	select DPLL
+	select REGMAP_I2C
+	help
+	  Driver for SiTime SiT9531x family clock generators
+	  (SiT95317, SiT95316).
+
+	  This driver registers each on-chip PLL as a DPLL device
+	  and exposes input/output clocks as DPLL pins, providing
+	  runtime configuration via Generic Netlink.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called sit9531x.
diff --git a/drivers/dpll/sit9531x/Makefile b/drivers/dpll/sit9531x/Makefile
new file mode 100644
index 000000000000..b97d2656a460
--- /dev/null
+++ b/drivers/dpll/sit9531x/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_SIT9531X_DPLL) += sit9531x.o
+sit9531x-y := core.o dpll.o prop.o
diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c
new file mode 100644
index 000000000000..2f6a37720b5e
--- /dev/null
+++ b/drivers/dpll/sit9531x/core.c
@@ -0,0 +1,2636 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SiTime SiT9531x DPLL core driver
+ *
+ * Copyright (C) 2026 SiTime Corp.
+ * Author: Ali Rouhi <arouhi@sitime.com>
+ * Author: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>
+ *
+ * Core I2C probe, regmap configuration, hardware state management,
+ * and periodic work thread.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/clk.h>
+#include <linux/dev_printk.h>
+#include <linux/device.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/kthread.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+#include "core.h"
+#include "dpll.h"
+#include "regs.h"
+
+/* ====================================================================
+ * Chip variant table
+ * ====================================================================
+ */
+
+#define SIT9531X_CHIP(_id, _nin, _nout, _name, _map) \
+	{ .id = (_id), .num_inputs = (_nin), .num_outputs = (_nout), \
+	  .name = (_name), .clkout_map = (_map) }
+
+/* Per-variant output index -> physical slot mapping */
+static const u8 clkout_map_95317[] = {0, 3, 4, 5, 7, 8, 9, 11};
+static const u8 clkout_map_95316[] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11};
+
+static const struct sit9531x_chip_info sit9531x_chip_ids[] = {
+	SIT9531X_CHIP(SIT9531X_VARIANT_ID_95317,  4,  8, "SiT95317", clkout_map_95317),
+	SIT9531X_CHIP(SIT9531X_VARIANT_ID_95316,  4, 12, "SiT95316", clkout_map_95316),
+};
+
+/* ====================================================================
+ * Regmap configuration
+ * ====================================================================
+ */
+
+#define SIT9531X_RANGE_OFFSET	SIT9531X_PAGE_SIZE
+
+static const struct regmap_range_cfg sit9531x_regmap_range = {
+	.range_min	= SIT9531X_RANGE_OFFSET,
+	.range_max	= SIT9531X_RANGE_OFFSET +
+			  (SIT9531X_NUM_PAGES * SIT9531X_PAGE_SIZE) - 1,
+	.selector_reg	= SIT9531X_PAGE_SEL,
+	.selector_mask	= GENMASK(7, 0),
+	.selector_shift	= 0,
+	.window_start	= 0,
+	.window_len	= SIT9531X_PAGE_SIZE,
+};
+
+const struct regmap_config sit9531x_regmap_config = {
+	.reg_bits	= 8,
+	.val_bits	= 8,
+	.max_register	= SIT9531X_RANGE_OFFSET +
+			  (SIT9531X_NUM_PAGES * SIT9531X_PAGE_SIZE) - 1,
+	.ranges		= &sit9531x_regmap_range,
+	.num_ranges	= 1,
+	.cache_type	= REGCACHE_NONE,
+};
+
+/* ====================================================================
+ * Register access helpers
+ * ====================================================================
+ */
+
+/**
+ * sit9531x_read_u8 - read an 8-bit register
+ * @sitdev:	device pointer
+ * @reg:	register in SIT9531X_REG(page, offset) form
+ * @val:	output value
+ *
+ * Return: 0 on success, <0 on error
+ */
+int sit9531x_read_u8(struct sit9531x_dev *sitdev, unsigned int reg,
+		     u8 *val)
+{
+	unsigned int tmp;
+	int rc;
+
+	reg = (SIT9531X_REG_PAGE(reg) * SIT9531X_PAGE_SIZE) +
+	      SIT9531X_REG_OFFSET(reg) + SIT9531X_RANGE_OFFSET;
+
+	rc = regmap_read(sitdev->regmap, reg, &tmp);
+	if (rc)
+		dev_err(sitdev->dev, "Failed to read reg 0x%04x: %d\n",
+			reg, rc);
+	else
+		*val = (u8)tmp;
+
+	return rc;
+}
+
+/**
+ * sit9531x_write_u8 - write an 8-bit register
+ * @sitdev:	device pointer
+ * @reg:	register in SIT9531X_REG(page, offset) form
+ * @val:	value to write
+ *
+ * Return: 0 on success, <0 on error
+ */
+int sit9531x_write_u8(struct sit9531x_dev *sitdev, unsigned int reg,
+		      u8 val)
+{
+	int rc;
+
+	reg = (SIT9531X_REG_PAGE(reg) * SIT9531X_PAGE_SIZE) +
+	      SIT9531X_REG_OFFSET(reg) + SIT9531X_RANGE_OFFSET;
+
+	rc = regmap_write(sitdev->regmap, reg, val);
+	if (rc)
+		dev_err(sitdev->dev, "Failed to write reg 0x%04x: %d\n",
+			reg, rc);
+
+	return rc;
+}
+
+/**
+ * sit9531x_read_pll_u8 - read a register on a PLL page
+ * @sitdev:	device pointer
+ * @pll_idx:	PLL index (0-3)
+ * @offset:	register offset within the PLL page
+ * @val:	output value
+ *
+ * Return: 0 on success, <0 on error
+ */
+int sit9531x_read_pll_u8(struct sit9531x_dev *sitdev, u8 pll_idx,
+			 u8 offset, u8 *val)
+{
+	return sit9531x_read_u8(sitdev,
+				SIT9531X_REG(sit9531x_pll_page(pll_idx), offset),
+				val);
+}
+
+/**
+ * sit9531x_write_pll_u8 - write a register on a PLL page
+ * @sitdev:	device pointer
+ * @pll_idx:	PLL index (0-3)
+ * @offset:	register offset within the PLL page
+ * @val:	value to write
+ *
+ * Return: 0 on success, <0 on error
+ */
+int sit9531x_write_pll_u8(struct sit9531x_dev *sitdev, u8 pll_idx,
+			  u8 offset, u8 val)
+{
+	return sit9531x_write_u8(sitdev,
+				 SIT9531X_REG(sit9531x_pll_page(pll_idx), offset),
+				 val);
+}
+
+/**
+ * sit9531x_update_pll_u8 - read-modify-write a register on a PLL page
+ * @sitdev:	device pointer
+ * @pll_idx:	PLL index (0-3)
+ * @offset:	register offset within the PLL page
+ * @mask:	bits to modify
+ * @val:	new value for masked bits
+ *
+ * Return: 0 on success, <0 on error
+ */
+int sit9531x_update_pll_u8(struct sit9531x_dev *sitdev, u8 pll_idx,
+			   u8 offset, u8 mask, u8 val)
+{
+	unsigned int reg;
+
+	reg = (sit9531x_pll_page(pll_idx) * SIT9531X_PAGE_SIZE) +
+	      offset + SIT9531X_RANGE_OFFSET;
+
+	return regmap_update_bits(sitdev->regmap, reg, mask, val);
+}
+
+/* ====================================================================
+ * Input enable / disable
+ * ====================================================================
+ */
+
+/*
+ * sit9531x_input_get_regs - get force mask and state register addresses
+ * @ref:	input reference state (contains sig_mode and polarity)
+ * @force_reg:	output force mask register address
+ * @state_reg:	output state register address
+ *
+ * Selects the correct Page 0x02 register pair based on signal mode
+ * and polarity.
+ */
+static void sit9531x_input_get_regs(const struct sit9531x_ref *ref,
+				    unsigned int *force_reg,
+				    unsigned int *state_reg)
+{
+	if (ref->sig_mode == SIT9531X_MODE_DE) {
+		*force_reg = SIT9531X_REG_IN_DE_FORCE;
+		*state_reg = SIT9531X_REG_IN_DE_STATE;
+	} else if (ref->polarity == SIT9531X_POL_N) {
+		*force_reg = SIT9531X_REG_IN_SEN_FORCE;
+		*state_reg = SIT9531X_REG_IN_SEN_STATE;
+	} else {
+		*force_reg = SIT9531X_REG_IN_SEP_FORCE;
+		*state_reg = SIT9531X_REG_IN_SEP_STATE;
+	}
+}
+
+/**
+ * sit9531x_input_disable - disable an input reference
+ * @sitdev:	device pointer
+ * @index:	input index (0-N)
+ *
+ * Sets the force mask bit and clears the state bit for the given
+ * input, effectively disabling it.  Register selection depends on
+ * the input's signal mode (SE/DE) and polarity (P/N).
+ *
+ * Return: 0 on success, <0 on error
+ */
+int sit9531x_input_disable(struct sit9531x_dev *sitdev, u8 index)
+{
+	struct sit9531x_ref *ref = &sitdev->ref[index];
+	unsigned int force_reg, state_reg;
+	u8 val;
+	int rc;
+
+	sit9531x_input_get_regs(ref, &force_reg, &state_reg);
+
+	/* Set force mask bit: enable override */
+	rc = sit9531x_read_u8(sitdev, force_reg, &val);
+	if (rc)
+		return rc;
+	rc = sit9531x_write_u8(sitdev, force_reg, val | BIT(index));
+	if (rc)
+		return rc;
+
+	/* Clear state bit: 0 = disabled */
+	rc = sit9531x_read_u8(sitdev, state_reg, &val);
+	if (rc)
+		return rc;
+	rc = sit9531x_write_u8(sitdev, state_reg, val & ~BIT(index));
+	if (rc)
+		return rc;
+
+	ref->enabled = false;
+
+	return 0;
+}
+
+/**
+ * sit9531x_input_enable - enable an input reference
+ * @sitdev:	device pointer
+ * @index:	input index (0-N)
+ *
+ * Clears the force mask bit for the given input, returning it to
+ * hardware default (enabled).
+ *
+ * Return: 0 on success, <0 on error
+ */
+int sit9531x_input_enable(struct sit9531x_dev *sitdev, u8 index)
+{
+	struct sit9531x_ref *ref = &sitdev->ref[index];
+	unsigned int force_reg, state_reg;
+	u8 val;
+	int rc;
+
+	sit9531x_input_get_regs(ref, &force_reg, &state_reg);
+
+	/* Clear force mask bit: return to hardware default (enabled) */
+	rc = sit9531x_read_u8(sitdev, force_reg, &val);
+	if (rc)
+		return rc;
+	rc = sit9531x_write_u8(sitdev, force_reg, val & ~BIT(index));
+	if (rc)
+		return rc;
+
+	ref->enabled = true;
+
+	return 0;
+}
+
+/* ====================================================================
+ * Output enable / disable (Hi-Z control)
+ *
+ * SiT9531x outputs can be configured as differential (DIFF) or
+ * single-ended (SE) depending on the factory blob.  Each output slot
+ * has TWO Hi-Z force/state register pairs on Page 0x03 -- one for the
+ * DIFF path, one for the SE path.
+ *
+ * We write to BOTH pairs so the function mutes the output regardless
+ * of whether it's been configured DIFF or SE on this board.
+ *
+ *   slot 0-7 :
+ *     DIFF mask=0xF2 state=0xF3   SE mask=0xF8 state=0xF9
+ *   slot 8-11:
+ *     DIFF mask=0xF4 state=0xF5   SE mask=0xFA state=0xFB
+ *
+ * MASK bit = 1  -> driver takes control of that output's Hi-Z state
+ * STATE bit = 0 -> output is forced to Hi-Z (muted)
+ * STATE bit = 1 -> output is driven (active)
+ *
+ * The output "index" in the driver is logical; the physical slot comes
+ * from info->clkout_map[].
+ * ====================================================================
+ */
+
+struct sit9531x_hiz_regs {
+	unsigned int diff_mask;
+	unsigned int diff_state;
+	unsigned int se_mask;
+	unsigned int se_state;
+	u8 bit;
+};
+
+static void sit9531x_output_get_hiz_regs(u8 slot,
+					 struct sit9531x_hiz_regs *r)
+{
+	if (slot <= 7) {
+		r->diff_mask  = SIT9531X_REG_HIZ_DIFF_07_MASK;
+		r->diff_state = SIT9531X_REG_HIZ_DIFF_07_STATE;
+		r->se_mask    = SIT9531X_REG_HIZ_SE_07_MASK;
+		r->se_state   = SIT9531X_REG_HIZ_SE_07_STATE;
+		r->bit = slot;
+	} else {
+		r->diff_mask  = SIT9531X_REG_HIZ_DIFF_811_MASK;
+		r->diff_state = SIT9531X_REG_HIZ_DIFF_811_STATE;
+		r->se_mask    = SIT9531X_REG_HIZ_SE_811_MASK;
+		r->se_state   = SIT9531X_REG_HIZ_SE_811_STATE;
+		r->bit = slot - 8;
+	}
+}
+
+static int sit9531x_hiz_set_bit(struct sit9531x_dev *sitdev,
+				unsigned int reg, u8 bit, bool set)
+{
+	u8 cur, new_val;
+	int rc;
+
+	rc = sit9531x_read_u8(sitdev, reg, &cur);
+	if (rc)
+		return rc;
+
+	new_val = set ? (cur | BIT(bit)) : (cur & ~BIT(bit));
+
+	return sit9531x_write_u8(sitdev, reg, new_val);
+}
+
+/**
+ * sit9531x_output_disable - mute an output (force Hi-Z)
+ * @sitdev:	device pointer
+ * @index:	logical output index (0..info->num_outputs-1)
+ *
+ * Sets MASK+STATE on BOTH the DIFF and SE register pairs so that the
+ * output is muted regardless of its electrical configuration.
+ *
+ * Caller must hold sitdev->multiop_lock.
+ *
+ * Return: 0 on success, <0 on error
+ */
+int sit9531x_output_disable(struct sit9531x_dev *sitdev, u8 index)
+{
+	const struct sit9531x_chip_info *info = sitdev->info;
+	struct sit9531x_hiz_regs r;
+	u8 slot;
+	int rc;
+
+	lockdep_assert_held(&sitdev->multiop_lock);
+
+	if (index >= info->num_outputs)
+		return -EINVAL;
+
+	slot = info->clkout_map[index];
+	sit9531x_output_get_hiz_regs(slot, &r);
+
+	/* Take control (MASK=1) and mute (STATE=0) on both DIFF and SE */
+	rc = sit9531x_hiz_set_bit(sitdev, r.diff_mask, r.bit, true);
+	if (rc)
+		return rc;
+	rc = sit9531x_hiz_set_bit(sitdev, r.diff_state, r.bit, false);
+	if (rc)
+		return rc;
+	rc = sit9531x_hiz_set_bit(sitdev, r.se_mask, r.bit, true);
+	if (rc)
+		return rc;
+	rc = sit9531x_hiz_set_bit(sitdev, r.se_state, r.bit, false);
+	if (rc)
+		return rc;
+
+	sitdev->out[index].enabled = false;
+	return 0;
+}
+
+/**
+ * sit9531x_output_enable - un-mute an output (active state)
+ * @sitdev:	device pointer
+ * @index:	logical output index (0..info->num_outputs-1)
+ *
+ * Releases MASK on BOTH register pairs so the output returns to
+ * whatever the initial_config blob programmed.
+ *
+ * Caller must hold sitdev->multiop_lock.
+ *
+ * Return: 0 on success, <0 on error
+ */
+int sit9531x_output_enable(struct sit9531x_dev *sitdev, u8 index)
+{
+	const struct sit9531x_chip_info *info = sitdev->info;
+	struct sit9531x_hiz_regs r;
+	u8 slot;
+	int rc;
+
+	lockdep_assert_held(&sitdev->multiop_lock);
+
+	if (index >= info->num_outputs)
+		return -EINVAL;
+
+	slot = info->clkout_map[index];
+	sit9531x_output_get_hiz_regs(slot, &r);
+
+	/* Release control (MASK=0) on both DIFF and SE */
+	rc = sit9531x_hiz_set_bit(sitdev, r.diff_mask, r.bit, false);
+	if (rc)
+		return rc;
+	rc = sit9531x_hiz_set_bit(sitdev, r.se_mask, r.bit, false);
+	if (rc)
+		return rc;
+
+	sitdev->out[index].enabled = true;
+	return 0;
+}
+
+/* ====================================================================
+ * Input priority selection
+ *
+ * The SiT9531x has a 12-slot priority table per PLL on Page 1.  Each
+ * register holds two slots nibble-packed (even slot in [3:0], odd slot
+ * in [7:4]).
+ *
+ * The procedure:
+ *   1. Force PLL into holdover (PLL page reg 0x6F bit 4)
+ *   2. Enter PRG_CMD state (Page 0 reg 0x0F <- 0x01)
+ *   3. Write priority slots on Page 1
+ *   4. NVM update + loop lock (Page 0 reg 0x0F)
+ *   5. Release holdover
+ *
+ * Caller must hold sitdev->multiop_lock.
+ * ====================================================================
+ */
+
+/**
+ * sit9531x_input_prio_set - set input priority for a PLL
+ * @sitdev:	device pointer
+ * @pll_idx:	PLL index (0-3)
+ * @input_idx:	input source index (0-11, using the p_dic encoding)
+ * @prio:	priority slot position (0 = highest)
+ *
+ * Writes a single priority slot assignment.  The input source is
+ * placed at the requested slot, and all lower-priority (higher-numbered)
+ * slots are filled with the same source to avoid stale entries.
+ *
+ * Return: 0 on success, <0 on error
+ */
+int sit9531x_input_prio_set(struct sit9531x_dev *sitdev, u8 pll_idx,
+			    u8 input_idx, u8 prio)
+{
+	u8 pll_offset, reg_addr, val, slot;
+	int rc;
+
+	lockdep_assert_held(&sitdev->multiop_lock);
+
+	if (pll_idx >= SIT9531X_NUM_PLLS)
+		return -EINVAL;
+	if (input_idx >= SIT9531X_PRIO_MAX_SLOTS)
+		return -EINVAL;
+	if (prio >= SIT9531X_PRIO_MAX_SLOTS)
+		return -EINVAL;
+
+	pll_offset = SIT9531X_PRIO_REGS_PER_PLL * pll_idx;
+
+	/* Step 1: Force PLL into holdover */
+	rc = sit9531x_update_pll_u8(sitdev, pll_idx,
+				    SIT9531X_PLL_REG_HO_CTRL,
+				    BIT(SIT9531X_PLL_HO_FORCE_BIT),
+				    BIT(SIT9531X_PLL_HO_FORCE_BIT));
+	if (rc)
+		return rc;
+
+	usleep_range(10000, 12000);
+
+	/* Step 2: Enter PRG_CMD state (Page 0, reg 0x0F) */
+	rc = sit9531x_write_u8(sitdev, SIT9531X_REG_GLOBAL_UPDATE,
+			       SIT9531X_PRG_CMD_STATE);
+	if (rc)
+		goto release_ho;
+
+	/* Step 3: Write requested priority slot on Page 1 */
+	reg_addr = SIT9531X_PRIO_BASE_REG + pll_offset + (prio / 2);
+
+	rc = sit9531x_read_u8(sitdev,
+			      SIT9531X_REG(SIT9531X_PAGE_PRIOSYS, reg_addr), &val);
+	if (rc)
+		goto release_ho;
+
+	if (prio & 1) {
+		/* Odd slot: bits [7:4] */
+		val = (val & SIT9531X_PRIO_NIBBLE_MASK) |
+		      (input_idx << SIT9531X_PRIO_HI_SHIFT);
+	} else {
+		/* Even slot: bits [3:0] */
+		val = (val & (SIT9531X_PRIO_NIBBLE_MASK << SIT9531X_PRIO_HI_SHIFT)) |
+		      (input_idx & SIT9531X_PRIO_NIBBLE_MASK);
+	}
+
+	rc = sit9531x_write_u8(sitdev,
+			       SIT9531X_REG(SIT9531X_PAGE_PRIOSYS, reg_addr), val);
+	if (rc)
+		goto release_ho;
+
+	/*
+	 * Fill remaining slots (prio+1 .. 11) with the same source,
+	 * matching the procedure script's backfill behaviour.
+	 */
+	for (slot = prio + 1; slot < SIT9531X_PRIO_MAX_SLOTS; slot++) {
+		reg_addr = SIT9531X_PRIO_BASE_REG + pll_offset + (slot / 2);
+
+		rc = sit9531x_read_u8(sitdev,
+				      SIT9531X_REG(SIT9531X_PAGE_PRIOSYS, reg_addr),
+				      &val);
+		if (rc)
+			goto release_ho;
+
+		if (slot & 1)
+			val = (val & SIT9531X_PRIO_NIBBLE_MASK) |
+			      (input_idx << SIT9531X_PRIO_HI_SHIFT);
+		else
+			val = (val & (SIT9531X_PRIO_NIBBLE_MASK <<
+				      SIT9531X_PRIO_HI_SHIFT)) |
+			      (input_idx & SIT9531X_PRIO_NIBBLE_MASK);
+
+		rc = sit9531x_write_u8(sitdev,
+				       SIT9531X_REG(SIT9531X_PAGE_PRIOSYS, reg_addr),
+				       val);
+		if (rc)
+			goto release_ho;
+	}
+
+	/* Step 4: NVM update */
+	rc = sit9531x_write_u8(sitdev, SIT9531X_REG_GLOBAL_UPDATE,
+			       SIT9531X_UPDATE_NVM);
+	if (rc)
+		goto release_ho;
+
+	/* Step 5: Loop lock */
+	rc = sit9531x_write_u8(sitdev, SIT9531X_REG_GLOBAL_UPDATE,
+			       SIT9531X_LOOP_LOCK);
+	if (rc)
+		goto release_ho;
+
+	usleep_range(1000, 2000);
+
+release_ho:
+	/* Step 6: Release holdover */
+	sit9531x_update_pll_u8(sitdev, pll_idx,
+			       SIT9531X_PLL_REG_HO_CTRL,
+			       BIT(SIT9531X_PLL_HO_FORCE_BIT), 0);
+
+	return rc;
+}
+
+/* ====================================================================
+ * DCO tuning (inner and outer loop)
+ *
+ * The SiT9531x DCO mechanism adjusts PLL frequency in ppb via
+ * fractional divider manipulation.
+ *
+ * Inner loop (free-run mode):
+ *   - Reads DIVN integer/fraction from PLL page 0x30-0x3B
+ *   - Computes 48-bit DCO fractional word
+ *   - Writes to PLL page regs 0x51-0x56
+ *
+ * Outer loop (sync mode):
+ *   - Reads DIVN2 integer/fraction from PLL page 0x3E-0x4C
+ *   - Computes 24-bit integer + 32-bit fractional DCO word
+ *   - Writes to PLL page regs 0x5E-0x60 (int), 0x63-0x66 (frac)
+ *
+ * After writing DCO codes, a trigger pulse on Page 0 reg 0x64
+ * applies the increment (bit 6) or decrement (bit 4).
+ * ====================================================================
+ */
+
+/**
+ * struct sit9531x_dco_code - computed DCO register values
+ * @dco_frac:	48-bit inner loop fractional word
+ * @dco_int:	24-bit outer loop integer word (signed)
+ * @outer_frac:	32-bit outer loop fractional word
+ */
+struct sit9531x_dco_code {
+	u64	dco_frac;
+	s32	dco_int;
+	u64	outer_frac;
+};
+
+/*
+ * sit9531x_dco_read_divn - read DIVN values for free-run DCO calculation
+ * @sitdev:	device pointer
+ * @pll_idx:	PLL index
+ * @int_part:	output integer part
+ * @fracn:	output fractional numerator
+ * @fracd:	output fractional denominator
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int sit9531x_dco_read_divn(struct sit9531x_dev *sitdev, u8 pll_idx,
+				  u32 *int_part, s32 *fracn, u32 *fracd)
+{
+	u8 v, pbyq;
+	int rc, i;
+
+	/* Integer part */
+	rc = sit9531x_read_pll_u8(sitdev, pll_idx, SIT9531X_PLL_REG_DIVN_INT, &v);
+	if (rc)
+		return rc;
+	*int_part = v;
+
+	/* Numerator (4 bytes, little-endian) */
+	*fracn = 0;
+	for (i = 3; i >= 0; i--) {
+		rc = sit9531x_read_pll_u8(sitdev, pll_idx,
+					  SIT9531X_PLL_REG_DIVN_NUM + i, &v);
+		if (rc)
+			return rc;
+		*fracn = (*fracn << 8) | v;
+	}
+
+	/* Check P/Q enable bit (reg 0x31 bit 6) */
+	rc = sit9531x_read_pll_u8(sitdev, pll_idx, SIT9531X_PLL_REG_STATUS, &v);
+	if (rc)
+		return rc;
+	pbyq = (v >> 6) & 1;
+
+	if (pbyq) {
+		/* Denominator (4 bytes, little-endian) */
+		*fracd = 0;
+		for (i = 3; i >= 0; i--) {
+			rc = sit9531x_read_pll_u8(sitdev, pll_idx,
+						  SIT9531X_PLL_REG_DIVN_DEN + i,
+						  &v);
+			if (rc)
+				return rc;
+			*fracd = (*fracd << 8) | v;
+		}
+	} else {
+		/*
+		 * P/Q disabled: integer-only mode.
+		 * Set fracd = 1 to avoid division by zero.
+		 */
+		*fracn = 0;
+		*fracd = 1;
+	}
+
+	return 0;
+}
+
+/*
+ * sit9531x_dco_read_divn2 - read DIVN2 values for sync DCO calculation
+ * @sitdev:	device pointer
+ * @pll_idx:	PLL index
+ * @n2_int:	output integer part
+ * @n2_fracn:	output fractional numerator
+ * @n2_fracd:	output fractional denominator
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int sit9531x_dco_read_divn2(struct sit9531x_dev *sitdev, u8 pll_idx,
+				   s64 *n2_int, s32 *n2_fracn, u32 *n2_fracd)
+{
+	int rc, i;
+	u8 v;
+
+	/* Integer part (5 bytes, big-endian: 0x42 is MSB) */
+	*n2_int = 0;
+	for (i = 4; i >= 0; i--) {
+		rc = sit9531x_read_pll_u8(sitdev, pll_idx,
+					  SIT9531X_PLL_REG_DIVN2_INT + i, &v);
+		if (rc)
+			return rc;
+		if (i == 4)
+			v &= 0x07;  /* only 3 bits in MSB */
+		*n2_int = (*n2_int << 8) | v;
+	}
+
+	/* Fractional numerator (4 bytes, big-endian: 0x46 is MSB) */
+	*n2_fracn = 0;
+	for (i = 3; i >= 0; i--) {
+		rc = sit9531x_read_pll_u8(sitdev, pll_idx,
+					  SIT9531X_PLL_REG_DIVN2_FRAC_NUM + i,
+					  &v);
+		if (rc)
+			return rc;
+		*n2_fracn = (*n2_fracn << 8) | v;
+	}
+
+	/* Fractional denominator (4 bytes, big-endian: 0x4C is MSB) */
+	*n2_fracd = 0;
+	for (i = 3; i >= 0; i--) {
+		rc = sit9531x_read_pll_u8(sitdev, pll_idx,
+					  SIT9531X_PLL_REG_DIVN2_FRAC_DEN + i,
+					  &v);
+		if (rc)
+			return rc;
+		*n2_fracd = (*n2_fracd << 8) | v;
+	}
+
+	return 0;
+}
+
+/*
+ * sit9531x_dco_calc_inner - compute inner loop DCO code (free-run)
+ *
+ * Formula:
+ *   divn_code = int_part * 65536 + fracn * 65536 / fracd
+ *   dco_frac  = divn_code * ppb * fracd / 1e9
+ *
+ * Caller guarantees ppb >= 0; sign handled by trigger pulse.
+ */
+static void sit9531x_dco_calc_inner(u32 int_part, s32 fracn, u32 fracd,
+				    s64 ppb, struct sit9531x_dco_code *code)
+{
+	s32 frac_scaled;
+	u64 divn_code;
+
+	if (!fracd)
+		fracd = 1;
+
+	frac_scaled = (s32)((s64)fracn * 65536 / fracd);
+	divn_code = (u64)int_part * 65536 + frac_scaled;
+
+	/*
+	 * The triple multiply (divn_code * ppb * fracd) overflows u64 in
+	 * realistic ranges (divn_code ~ 2^21, ppb ~ 2^30, fracd ~ 2^32 =
+	 * ~2^83).  Use mul_u64_u64_div_u64() to carry out the multiply in
+	 * 128 bits internally.
+	 */
+	code->dco_frac = mul_u64_u64_div_u64(divn_code,
+					     (u64)ppb * fracd,
+					     1000000000ULL);
+}
+
+/*
+ * sit9531x_dco_calc_outer - compute outer loop DCO code (sync)
+ *
+ * The previous formulation computed divn2 with truncating integer
+ * division (n2_int + n2_fracn / n2_fracd), silently dropping the
+ * fractional part of DIVN2.  Mirror the inner-loop scale-then-divide
+ * pattern by keeping the un-divided numerator:
+ *   divn2_num = n2_int * n2_fracd + n2_fracn       (exact)
+ *   divn2     = divn2_num / n2_fracd               (conceptually)
+ *   dco_int   = divn2 * ppb / 1e9
+ *             = divn2_num * ppb / (n2_fracd * 1e9)
+ *   outer_frac = (divn2 * ppb / 1e9 - dco_int) * n2_fracd * 65536
+ *              = divn2_num * (ppb * 65536) / 1e9 - dco_int * n2_fracd * 65536
+ *
+ * Caller guarantees ppb >= 0; sign handled by trigger pulse.
+ */
+static void sit9531x_dco_calc_outer(s64 n2_int, s32 n2_fracn, u32 n2_fracd,
+				    s64 ppb, struct sit9531x_dco_code *code)
+{
+	u64 divn2_num, dco_int_u, adjustment_frac;
+	u32 fracd_eff;
+
+	fracd_eff = n2_fracd ? n2_fracd : 1;
+	divn2_num = (u64)n2_int * fracd_eff + (u32)n2_fracn;
+
+	/*
+	 * dco_int = divn2_num * ppb / (fracd_eff * 1e9).  The (divn2_num
+	 * * ppb) product can exceed u64 in the worst case, so use
+	 * mul_u64_u64_div_u64() which carries it out in 128 bits.
+	 */
+	dco_int_u = mul_u64_u64_div_u64(divn2_num, (u64)ppb,
+					(u64)fracd_eff * 1000000000ULL);
+	code->dco_int = (s32)dco_int_u;
+
+	/*
+	 * outer_frac = divn2_num * (ppb << 16) / 1e9
+	 *              - dco_int_u * fracd_eff * 65536
+	 *
+	 * The first term overflows u64 if computed as a flat multiply
+	 * (divn2_num ~ 2^67 in the worst case); the 128-bit helper takes
+	 * care of it.
+	 */
+	adjustment_frac = mul_u64_u64_div_u64(divn2_num,
+					      (u64)ppb << 16,
+					      1000000000ULL);
+	code->outer_frac = adjustment_frac -
+			   dco_int_u * fracd_eff * 65536;
+}
+
+/*
+ * sit9531x_dco_write_inner - write inner loop DCO registers
+ */
+static int sit9531x_dco_write_inner(struct sit9531x_dev *sitdev,
+				    u8 pll_idx,
+				    const struct sit9531x_dco_code *code)
+{
+	u64 frac = code->dco_frac;
+	int rc, i;
+
+	/* Enable DCO with dither mode */
+	rc = sit9531x_write_pll_u8(sitdev, pll_idx,
+				   SIT9531X_PLL_REG_DCO_FUNC,
+				   SIT9531X_DCO_DITHER_MODE | SIT9531X_DCO_EN);
+	if (rc)
+		return rc;
+
+	/* Write 48-bit fractional word (LSB first: 0x51->0x56) */
+	for (i = 0; i < 6; i++) {
+		rc = sit9531x_write_pll_u8(sitdev, pll_idx,
+					   SIT9531X_PLL_REG_DCO_FRAC1 + i,
+					   frac & 0xFF);
+		if (rc)
+			return rc;
+		frac >>= 8;
+	}
+
+	return 0;
+}
+
+/*
+ * sit9531x_dco_write_outer - write outer loop DCO registers
+ */
+static int sit9531x_dco_write_outer(struct sit9531x_dev *sitdev,
+				    u8 pll_idx,
+				    const struct sit9531x_dco_code *code)
+{
+	s32 dco_int;
+	u64 frac;
+	int rc;
+
+	/* Enable DCO with dither mode + outer loop */
+	rc = sit9531x_write_pll_u8(sitdev, pll_idx,
+				   SIT9531X_PLL_REG_DCO_FUNC,
+				   SIT9531X_DCO_DITHER_MODE | SIT9531X_DCO_OUTER_EN |
+				   SIT9531X_DCO_EN);
+	if (rc)
+		return rc;
+
+	/* Write 32-bit fractional (shifted >>16, LSB first: 0x63->0x66) */
+	frac = code->outer_frac >> 16;
+	rc = sit9531x_write_pll_u8(sitdev, pll_idx,
+				   SIT9531X_PLL_REG_DCO_OFRAC_7, frac & 0xFF);
+	if (rc)
+		return rc;
+	rc = sit9531x_write_pll_u8(sitdev, pll_idx,
+				   SIT9531X_PLL_REG_DCO_OFRAC_15,
+				   (frac >> 8) & 0xFF);
+	if (rc)
+		return rc;
+	rc = sit9531x_write_pll_u8(sitdev, pll_idx,
+				   SIT9531X_PLL_REG_DCO_OFRAC_23,
+				   (frac >> 16) & 0xFF);
+	if (rc)
+		return rc;
+	rc = sit9531x_write_pll_u8(sitdev, pll_idx,
+				   SIT9531X_PLL_REG_DCO_OFRAC_31,
+				   (frac >> 24) & 0xFF);
+	if (rc)
+		return rc;
+
+	/* Write 24-bit integer (LSB first: 0x5E->0x60) */
+	dco_int = code->dco_int;
+	rc = sit9531x_write_pll_u8(sitdev, pll_idx,
+				   SIT9531X_PLL_REG_DCO_INT_7, dco_int & 0xFF);
+	if (rc)
+		return rc;
+	rc = sit9531x_write_pll_u8(sitdev, pll_idx,
+				   SIT9531X_PLL_REG_DCO_INT_15,
+				   (dco_int >> 8) & 0xFF);
+	if (rc)
+		return rc;
+	rc = sit9531x_write_pll_u8(sitdev, pll_idx,
+				   SIT9531X_PLL_REG_DCO_INT_23,
+				   (dco_int >> 16) & 0xFF);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
+/*
+ * sit9531x_dco_mask - mask a PLL's DCO (prevent updates)
+ */
+static int sit9531x_dco_mask(struct sit9531x_dev *sitdev, u8 pll_idx)
+{
+	u8 val;
+	int rc;
+
+	rc = sit9531x_read_pll_u8(sitdev, pll_idx,
+				  SIT9531X_PLL_REG_DCO_FUNC, &val);
+	if (rc)
+		return rc;
+
+	return sit9531x_write_pll_u8(sitdev, pll_idx,
+				     SIT9531X_PLL_REG_DCO_FUNC,
+				     val | SIT9531X_DCO_MASK);
+}
+
+/*
+ * sit9531x_dco_unmask - unmask a PLL's DCO (allow updates)
+ */
+static int sit9531x_dco_unmask(struct sit9531x_dev *sitdev, u8 pll_idx)
+{
+	u8 val;
+	int rc;
+
+	rc = sit9531x_read_pll_u8(sitdev, pll_idx,
+				  SIT9531X_PLL_REG_DCO_FUNC, &val);
+	if (rc)
+		return rc;
+
+	return sit9531x_write_pll_u8(sitdev, pll_idx,
+				     SIT9531X_PLL_REG_DCO_FUNC,
+				     val & ~SIT9531X_DCO_MASK);
+}
+
+/*
+ * sit9531x_dco_trigger - trigger DCO increment or decrement
+ * @sitdev:	device pointer
+ * @neg_adj:	true for decrement, false for increment
+ *
+ * Pulses the appropriate bit in Page 0 reg 0x64 (1->0 edge).
+ */
+static int sit9531x_dco_trigger(struct sit9531x_dev *sitdev, bool neg_adj)
+{
+	u8 val, bit;
+	int rc;
+
+	bit = neg_adj ? SIT9531X_DCO_TRIGGER_DECR : SIT9531X_DCO_TRIGGER_INCR;
+
+	/* Set trigger bit */
+	rc = sit9531x_read_u8(sitdev, SIT9531X_REG_DCO_TRIGGER, &val);
+	if (rc)
+		return rc;
+	rc = sit9531x_write_u8(sitdev, SIT9531X_REG_DCO_TRIGGER, val | bit);
+	if (rc)
+		return rc;
+
+	ndelay(SIT9531X_DCO_TRIGGER_PULSE_NS);
+
+	/* Clear trigger bit */
+	rc = sit9531x_read_u8(sitdev, SIT9531X_REG_DCO_TRIGGER, &val);
+	if (rc)
+		return rc;
+	rc = sit9531x_write_u8(sitdev, SIT9531X_REG_DCO_TRIGGER, val & ~bit);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
+/**
+ * sit9531x_dco_adjust - adjust PLL frequency via DCO
+ * @sitdev:	device pointer
+ * @pll_idx:	PLL index (0-3)
+ * @ppb:	frequency adjustment in parts per billion
+ *
+ * In free-run mode, adjusts the inner loop only.
+ * In sync mode, adjusts both inner and outer loops.
+ * Masks all other PLLs' DCOs during the operation.
+ *
+ * Caller must hold sitdev->multiop_lock.
+ *
+ * Return: 0 on success, <0 on error
+ */
+int sit9531x_dco_adjust(struct sit9531x_dev *sitdev, u8 pll_idx, s64 ppb)
+{
+	struct sit9531x_dco_code code = {};
+	bool neg_adj = false;
+	int rc, i;
+
+	lockdep_assert_held(&sitdev->multiop_lock);
+
+	if (ppb < 0) {
+		neg_adj = true;
+		ppb = -ppb;
+	}
+
+	/* Mask all other PLLs' DCOs */
+	for (i = 0; i < SIT9531X_NUM_PLLS; i++) {
+		if (i == pll_idx)
+			continue;
+		rc = sit9531x_dco_mask(sitdev, i);
+		if (rc)
+			return rc;
+	}
+
+	/* Unmask target PLL */
+	rc = sit9531x_dco_unmask(sitdev, pll_idx);
+	if (rc)
+		return rc;
+
+	/* Unlock debug registers */
+	rc = sit9531x_write_pll_u8(sitdev, pll_idx,
+				   SIT9531X_PLL_REG_DEBUG, SIT9531X_PLL_DEBUG_UNLOCK);
+	if (rc)
+		return rc;
+
+	/* Determine mode and compute/write DCO codes */
+	if (sitdev->chan[pll_idx].mode) {
+		/* Free-run: inner loop only */
+		u32 div_int;
+		s32 div_fracn;
+		u32 div_fracd;
+
+		rc = sit9531x_dco_read_divn(sitdev, pll_idx,
+					    &div_int, &div_fracn, &div_fracd);
+		if (rc)
+			return rc;
+
+		sit9531x_dco_calc_inner(div_int, div_fracn, div_fracd,
+					ppb, &code);
+
+		rc = sit9531x_dco_write_inner(sitdev, pll_idx, &code);
+		if (rc)
+			return rc;
+	} else {
+		/* Sync: inner + outer loops */
+		s64 n2_int;
+		s32 n2_fracn;
+		u32 n2_fracd;
+		u32 div_int;
+		s32 div_fracn;
+		u32 div_fracd;
+
+		/* Inner loop */
+		rc = sit9531x_dco_read_divn(sitdev, pll_idx,
+					    &div_int, &div_fracn, &div_fracd);
+		if (rc)
+			return rc;
+
+		sit9531x_dco_calc_inner(div_int, div_fracn, div_fracd,
+					ppb, &code);
+
+		rc = sit9531x_dco_write_inner(sitdev, pll_idx, &code);
+		if (rc)
+			return rc;
+
+		/* Outer loop */
+		rc = sit9531x_dco_read_divn2(sitdev, pll_idx,
+					     &n2_int, &n2_fracn, &n2_fracd);
+		if (rc)
+			return rc;
+
+		sit9531x_dco_calc_outer(n2_int, n2_fracn, n2_fracd,
+					ppb, &code);
+
+		rc = sit9531x_dco_write_outer(sitdev, pll_idx, &code);
+		if (rc)
+			return rc;
+	}
+
+	/* Set trigger register base value, then pulse increment/decrement */
+	rc = sit9531x_write_u8(sitdev, SIT9531X_REG_DCO_TRIGGER,
+			       SIT9531X_DCO_TRIGGER_BASE);
+	if (rc)
+		return rc;
+
+	return sit9531x_dco_trigger(sitdev, neg_adj);
+}
+
+/* ====================================================================
+ * Output frequency set
+ * ====================================================================
+ */
+
+/* Per-slot DIVO base register offsets (6 slots per page) */
+static const u8 clkout_odr_divn_base[] = {
+	0x14, 0x24, 0x34, 0x44, 0x54, 0x64
+};
+
+/* XO doubler register */
+#define SIT9531X_REG_XO2_GENERIC		SIT9531X_REG(0x00, 0x2D)
+#define SIT9531X_XO_DOUBLER_ENB_BIT		7   /* inverted: 0 = enabled */
+
+/* VCO frequency bands (Hz) */
+#define SIT9531X_FVCO_LOWBAND_MIN		4915200000ULL
+#define SIT9531X_FVCO_LOWBAND_MAX		5898240000ULL
+#define SIT9531X_FVCO_HIGHBAND_MIN		6875000000ULL
+#define SIT9531X_FVCO_HIGHBAND_MAX		7812500000ULL
+
+/*
+ * sit9531x_is_xo_doubler_enabled - check if Fref doubler is active
+ * @sitdev:	device pointer
+ *
+ * Register 0x2D bit 7 is active-low: 0 = doubler enabled, 1 = disabled.
+ *
+ * Return: 1 if enabled, 0 if disabled, <0 on error
+ */
+static int sit9531x_is_xo_doubler_enabled(struct sit9531x_dev *sitdev)
+{
+	u8 val;
+	int rc;
+
+	rc = sit9531x_read_u8(sitdev, SIT9531X_REG_XO2_GENERIC, &val);
+	if (rc)
+		return rc;
+
+	return (~val >> SIT9531X_XO_DOUBLER_ENB_BIT) & 1u;
+}
+
+/*
+ * sit9531x_get_fvco - read VCO frequency from chip's DIVN registers
+ * @sitdev:	device pointer
+ * @pll_idx:	PLL index (0-3)
+ *
+ * Fvco = Fref * DIVN, where DIVN = int_part + fracn/fracd is read from
+ * PLL page regs 0x30 (int), 0x32-0x35 (numerator), 0x38-0x3B
+ * (denominator), and Fref = xtal_freq << doubler.  DIVN is the
+ * steady-state Fvco/Fref target programmed by the NVM blob and is
+ * authoritative in both free-run and sync modes; the previous split
+ * between free-run and sync formulas returned 0 on chips that didn't
+ * have a sync input populated, which broke the TDC phase readback.
+ *
+ * The numerator and denominator are unsigned 32-bit values.  When the
+ * denominator reads as zero (the chip's "implicit denominator" mode for
+ * pure-fractional DIVN), the convention is fracd = 2^32, so fracn is
+ * interpreted as a binary fraction over 2^32.
+ *
+ * Return: Fvco in Hz, or 0 on error
+ */
+static u64 sit9531x_get_fvco(struct sit9531x_dev *sitdev, u8 pll_idx)
+{
+	u64 fracd = 0, fref, divn_temp;
+	u32 int_part, fracn = 0;
+	int doubler, rc, i;
+	u8 v;
+
+	rc = sit9531x_read_pll_u8(sitdev, pll_idx,
+				  SIT9531X_PLL_REG_DIVN_INT, &v);
+	if (rc)
+		return 0;
+	int_part = v;
+
+	for (i = 3; i >= 0; i--) {
+		rc = sit9531x_read_pll_u8(sitdev, pll_idx,
+					  SIT9531X_PLL_REG_DIVN_NUM + i, &v);
+		if (rc)
+			return 0;
+		fracn = (fracn << 8) | v;
+	}
+
+	for (i = 3; i >= 0; i--) {
+		rc = sit9531x_read_pll_u8(sitdev, pll_idx,
+					  SIT9531X_PLL_REG_DIVN_DEN + i, &v);
+		if (rc)
+			return 0;
+		fracd = (fracd << 8) | v;
+	}
+
+	/*
+	 * Implicit denominator: fracd=0 means fracn is a binary fraction
+	 * over 2^32 (the chip uses this when no explicit denominator is
+	 * programmed).
+	 */
+	if (!fracd)
+		fracd = 1ULL << 32;
+
+	doubler = sit9531x_is_xo_doubler_enabled(sitdev);
+	if (doubler < 0)
+		return 0;
+
+	fref = (u64)sitdev->xtal_freq << doubler;
+
+	/*
+	 * Fvco = fref * (int_part + fracn/fracd).  Split the multiplication
+	 * to avoid 64-bit overflow on the realistic fref/DIVN range.
+	 */
+	divn_temp = fref * int_part + div64_u64(fref * fracn, fracd);
+
+	return divn_temp;
+}
+
+/**
+ * sit9531x_output_freq_set - set output clock frequency
+ * @sitdev:	device pointer
+ * @out_idx:	output index (0-N for this chip variant)
+ * @pll_idx:	PLL driving this output (0-3)
+ * @frequency:	desired output frequency in Hz
+ *
+ * Computes DIVO = Fvco / frequency and writes the 34-bit output divider
+ * to the output system registers on Pages 3/4.  The write sequence is:
+ *   1. Unlock debug registers (Page 3)
+ *   2. Enter PRG_CMD state
+ *   3. Write 5-byte DIVO to the correct page/slot
+ *   4. NVM update
+ *   5. Loop lock
+ *   6. Wait for lock to settle
+ *
+ * Caller must hold sitdev->multiop_lock.
+ *
+ * Return: 0 on success, <0 on error.  Actual frequency may differ
+ *         due to integer division; the output state is updated with
+ *         the effective frequency (Fvco / DIVO).
+ */
+int sit9531x_output_freq_set(struct sit9531x_dev *sitdev, u8 out_idx,
+			     u8 pll_idx, u64 frequency)
+{
+	const struct sit9531x_chip_info *info = sitdev->info;
+	u8 slot, page, base_reg, divo_bytes[5], msb_old;
+	u64 fvco, divo, fvco_min, fvco_max;
+	int rc, j;
+
+	lockdep_assert_held(&sitdev->multiop_lock);
+
+	if (out_idx >= info->num_outputs || pll_idx >= SIT9531X_NUM_PLLS)
+		return -EINVAL;
+
+	if (!frequency)
+		return -EINVAL;
+
+	/* Determine VCO frequency band limits */
+	if (pll_idx == 1 || pll_idx == 3) {
+		/* PLLB, PLLD: high band */
+		fvco_min = SIT9531X_FVCO_HIGHBAND_MIN;
+		fvco_max = SIT9531X_FVCO_HIGHBAND_MAX;
+	} else {
+		/* PLLA, PLLC: low band */
+		fvco_min = SIT9531X_FVCO_LOWBAND_MIN;
+		fvco_max = SIT9531X_FVCO_LOWBAND_MAX;
+	}
+
+	/* Read current VCO frequency */
+	fvco = sit9531x_get_fvco(sitdev, pll_idx);
+	if (!fvco)
+		fvco = fvco_min;
+	else if (fvco < fvco_min)
+		fvco = fvco_min;
+	else if (fvco > fvco_max)
+		fvco = fvco_max;
+
+	/* Compute output divider: DIVO = Fvco / freq */
+	divo = div64_u64(fvco, frequency);
+	if (!divo)
+		return -EINVAL;
+
+	dev_dbg(sitdev->dev,
+		"out%u: Fvco=%llu freq=%llu DIVO=%llu (effective %llu Hz)\n",
+		out_idx, fvco, frequency, divo, div64_u64(fvco, divo));
+
+	/* Map output index to physical slot */
+	slot = info->clkout_map[out_idx];
+
+	/* Determine page and per-page slot register */
+	if (slot > SIT9531X_PAGE_OUTSYS0_SLOT_MAX)
+		page = SIT9531X_PAGE_OUTSYS1;
+	else
+		page = SIT9531X_PAGE_OUTSYS0;
+	base_reg = clkout_odr_divn_base[slot % 6];
+
+	/* Step 1: Switch to Page 3 and unlock debug */
+	rc = sit9531x_write_u8(sitdev, SIT9531X_REG_OUTSYS_DEBUG,
+			       SIT9531X_DEBUG_UNLOCK_VAL);
+	if (rc)
+		return rc;
+
+	/* Step 2: Enter PRG_CMD state */
+	rc = sit9531x_write_u8(sitdev, SIT9531X_REG_PRG_DIR_GEN,
+			       SIT9531X_PRG_CMD_STATE);
+	if (rc)
+		return rc;
+
+	/* Step 3: Prepare DIVO bytes (34-bit, LSB at base reg) */
+	divo_bytes[0] = (divo >>  0) & 0xFF;
+	divo_bytes[1] = (divo >>  8) & 0xFF;
+	divo_bytes[2] = (divo >> 16) & 0xFF;
+	divo_bytes[3] = (divo >> 24) & 0xFF;
+	divo_bytes[4] = (divo >> 32) & 0x03;  /* only bits [1:0] */
+
+	/* Read existing MSB register and preserve upper 6 bits */
+	rc = sit9531x_read_u8(sitdev,
+			      SIT9531X_REG(page, base_reg - 4), &msb_old);
+	if (rc)
+		return rc;
+	divo_bytes[4] |= msb_old & 0xFC;
+
+	/* Write 5 DIVO bytes (base, base-1, base-2, base-3, base-4) */
+	for (j = 0; j < 5; j++) {
+		rc = sit9531x_write_u8(sitdev,
+				       SIT9531X_REG(page, base_reg - j),
+				       divo_bytes[j]);
+		if (rc)
+			return rc;
+	}
+
+	/* Step 4: Switch back to Page 3 for control registers */
+	/* (SIT9531X_REG_PRG_DIR_GEN is always on Page 3) */
+
+	/* Step 5: NVM update */
+	rc = sit9531x_write_u8(sitdev, SIT9531X_REG_PRG_DIR_GEN, SIT9531X_UPDATE_NVM);
+	if (rc)
+		return rc;
+
+	/* Step 6: Loop lock */
+	rc = sit9531x_write_u8(sitdev, SIT9531X_REG_PRG_DIR_GEN, SIT9531X_LOOP_LOCK);
+	if (rc)
+		return rc;
+
+	/*
+	 * Hardware requires settling time after loop-lock command.
+	 * This sleep is intentional despite holding multiop_lock;
+	 * the NVM + lock sequence must be atomic.
+	 */
+	msleep(100);
+
+	/* Update cached output frequency */
+	sitdev->out[out_idx].freq = (u32)div64_u64(fvco, divo);
+
+	return 0;
+}
+
+/* ====================================================================
+ * Phase adjust (PRG_RST_DELAY register-based)
+ * ====================================================================
+ *
+ * The chip exposes a per-output 34-bit coarse delay measured in VCO
+ * clock periods plus a 3-bit fine delay in fixed 30 ps steps.  The
+ * five bytes PROG6..PROG2 hold the field across registers:
+ *   base + 0  PROG6  [7:5] OPSTG_VCASC_BUMP (preserved via RMW)
+ *                    [4:2] PRG_RST_FINE_DELAY
+ *                    [1:0] PRG_RST_DELAY[33:32]
+ *   base + 1  PROG5  PRG_RST_DELAY[31:24]
+ *   base + 2  PROG4  PRG_RST_DELAY[23:16]
+ *   base + 3  PROG3  PRG_RST_DELAY[15:8]
+ *   base + 4  PROG2  PRG_RST_DELAY[7:0]
+ *
+ * Outputs 0-5 live on Page 3, outputs 6-11 on Page 4, with each
+ * output's block at base = 0x15 + 16 * (out_idx % 6).
+ *
+ * The chip only supports unsigned positive delay.  A negative phase
+ * adjustment (advance) is wrapped to (T_out - |phase|) modulo one
+ * output period, which is identical for a periodic signal.
+ */
+
+int sit9531x_output_phase_adjust_set(struct sit9531x_dev *sitdev,
+				     u8 out_idx, s32 phase_ps)
+{
+	const struct sit9531x_chip_info *info = sitdev->info;
+	u64 abs_ps, fvco, coarse, coarse_ps, rem_ps;
+	u8 page, base, prog6_val, fine = 0;
+	u8 pll_idx, slot;
+	u32 freq;
+	int rc;
+
+	if (out_idx >= info->num_outputs)
+		return -EINVAL;
+
+	pll_idx = sitdev->out[out_idx].pll_idx;
+	if (pll_idx >= SIT9531X_NUM_PLLS)
+		return -EINVAL;
+
+	freq = sitdev->out[out_idx].freq;
+	if (!freq)
+		return -EINVAL;
+
+	fvco = sit9531x_get_fvco(sitdev, pll_idx);
+	if (!fvco)
+		return -EIO;
+
+	/*
+	 * Convert to unsigned absolute delay.  Negative phase (advance)
+	 * is rendered as T_out - |phase|, modulo the output period.
+	 */
+	if (phase_ps == 0) {
+		abs_ps = 0;
+	} else if (phase_ps > 0) {
+		abs_ps = (u64)phase_ps;
+	} else {
+		u64 t_out_ps = div64_u64(1000000000000ULL, freq);
+		u64 advance = (u64)(-(s64)phase_ps);
+
+		if (t_out_ps == 0)
+			return -EINVAL;
+		advance %= t_out_ps;
+		abs_ps = (advance == 0) ? 0 : (t_out_ps - advance);
+	}
+
+	/*
+	 * coarse_cycles = abs_ps * Fvco / 1e12 ps/s.
+	 * mul_u64_u64_div_u64() avoids overflow when abs_ps approaches
+	 * one second of 1 PPS wrap-around.
+	 */
+	coarse = mul_u64_u64_div_u64(abs_ps, fvco, 1000000000000ULL);
+	if (coarse >= (1ULL << SIT9531X_OUT_PRG_COARSE_BITS))
+		return -ERANGE;
+
+	/* Fine delay = round((abs_ps - coarse * vco_period_ps) / 30 ps) */
+	coarse_ps = mul_u64_u64_div_u64(coarse, 1000000000000ULL, fvco);
+	rem_ps = (abs_ps > coarse_ps) ? (abs_ps - coarse_ps) : 0;
+	if (rem_ps) {
+		u64 steps;
+
+		steps = div64_u64(rem_ps + SIT9531X_OUT_PRG_FINE_STEP_PS / 2,
+				  SIT9531X_OUT_PRG_FINE_STEP_PS);
+		if (steps > SIT9531X_OUT_PRG_FINE_MAX)
+			steps = SIT9531X_OUT_PRG_FINE_MAX;
+		fine = (u8)steps;
+	}
+
+	/*
+	 * Map logical output index to the chip's physical output slot.
+	 * On SiT95317 the eight logical outputs land on chip slots
+	 * {0, 3, 4, 5, 7, 8, 9, 11}; on SiT95316 the map is identity.
+	 * Page/base must address the slot, not the logical index.
+	 */
+	slot = info->clkout_map[out_idx];
+	page = (slot > SIT9531X_PAGE_OUTSYS0_SLOT_MAX) ?
+	       SIT9531X_PAGE_OUTSYS1 : SIT9531X_PAGE_OUTSYS0;
+	base = SIT9531X_OUT_PRG_DELAY_BASE +
+	       SIT9531X_OUT_PRG_SLOT_STRIDE * (slot % 6);
+
+	/* Caller (dpll.c) holds multiop_lock around the whole sequence. */
+	lockdep_assert_held(&sitdev->multiop_lock);
+
+	/* PROG6 RMW: preserve OPSTG_VCASC_BUMP in [7:5] */
+	rc = sit9531x_read_u8(sitdev, SIT9531X_REG(page, base),
+			      &prog6_val);
+	if (rc)
+		return rc;
+
+	prog6_val &= SIT9531X_OUT_PRG_OPSTG_MASK;
+	prog6_val |= (fine << SIT9531X_OUT_PRG_FINE_SHIFT) &
+		     SIT9531X_OUT_PRG_FINE_MASK;
+	prog6_val |= (u8)((coarse >> 32) & SIT9531X_OUT_PRG_COARSE_HI_MASK);
+
+	rc = sit9531x_write_u8(sitdev, SIT9531X_REG(page, base),
+			       prog6_val);
+	if (rc)
+		return rc;
+	rc = sit9531x_write_u8(sitdev, SIT9531X_REG(page, base + 1),
+			       (u8)((coarse >> 24) & 0xFF));
+	if (rc)
+		return rc;
+	rc = sit9531x_write_u8(sitdev, SIT9531X_REG(page, base + 2),
+			       (u8)((coarse >> 16) & 0xFF));
+	if (rc)
+		return rc;
+	rc = sit9531x_write_u8(sitdev, SIT9531X_REG(page, base + 3),
+			       (u8)((coarse >> 8) & 0xFF));
+	if (rc)
+		return rc;
+	rc = sit9531x_write_u8(sitdev, SIT9531X_REG(page, base + 4),
+			       (u8)(coarse & 0xFF));
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
+/* ====================================================================
+ * PLL lock-detection thresholds (LL_REG2_PLL, reg 0x2A)
+ * ====================================================================
+ *
+ * Per SiT95316 register map p.80 (PAGE_PLL):
+ *   bits [7:4] LL_SET_VALUE_PLL[3:0]  -- threshold for declaring the
+ *                                        outer loop as "out of lock"
+ *   bits [3:0] LL_CLR_VALUE_PLL[3:0]  -- threshold for re-acquiring
+ *                                        lock
+ *
+ * Each 4-bit field selects from a 16-step ladder spanning 0.05 PPB to
+ * 4000 PPM.  Loop-filter coefficients on regs 0x10-0x15 are
+ * GUI/NVM-managed by the timing configurator and must not be reprogrammed at runtime.
+ */
+
+/**
+ * sit9531x_pll_lock_threshold_set - program lock-loss / lock-acquire thresholds
+ * @sitdev:	device pointer
+ * @pll_idx:	PLL index (0=PLLA ... 3=PLLD)
+ * @set_val:	LL_SET_VALUE 4-bit code (0..15) -- outer-loop unlock threshold
+ * @clr_val:	LL_CLR_VALUE 4-bit code (0..15) -- outer-loop relock threshold
+ *
+ * Writes PLL_PAGE reg 0x2A (LL_REG2_PLL).
+ *
+ * Caller must hold sitdev->multiop_lock.
+ *
+ * Return: 0 on success, <0 on error.
+ */
+int sit9531x_pll_lock_threshold_set(struct sit9531x_dev *sitdev, u8 pll_idx,
+				    u8 set_val, u8 clr_val)
+{
+	u8 reg_val;
+
+	lockdep_assert_held(&sitdev->multiop_lock);
+
+	if (pll_idx >= SIT9531X_NUM_PLLS || set_val > 0x0F || clr_val > 0x0F)
+		return -EINVAL;
+
+	reg_val = ((set_val & 0x0F) << 4) | (clr_val & 0x0F);
+
+	return sit9531x_write_pll_u8(sitdev, pll_idx,
+				     SIT9531X_PLL_REG_LL_THRESH, reg_val);
+}
+
+/* ====================================================================
+ * Notification clear
+ * ====================================================================
+ */
+
+/**
+ * sit9531x_clear_notifications - clear all notification registers
+ * @sitdev:	device pointer
+ *
+ * Clears all write-1-to-clear notification registers:
+ *   - PLL outer LOL notification (Page 0, reg 0x07)
+ *   - PLL holdover freeze notification (Page 0, reg 0x0B)
+ *   - PLL inner LOL notification (Page 0, reg 0x93)
+ *   - Clock monitor XO/PLL notification (Page 0, reg 0x9E)
+ *   - Clock input notifications (Page 6, regs 0x03/0x07/0x93/0x97)
+ *
+ * Caller must hold sitdev->multiop_lock.
+ *
+ * Return: 0 on success, <0 on error
+ */
+int sit9531x_clear_notifications(struct sit9531x_dev *sitdev)
+{
+	int rc;
+
+	lockdep_assert_held(&sitdev->multiop_lock);
+
+	/* Page 0x00 W1C notification registers */
+	rc = sit9531x_write_u8(sitdev, SIT9531X_REG_OUTER_LOL_NOTIF, 0xFF);
+	if (rc)
+		return rc;
+	rc = sit9531x_write_u8(sitdev, SIT9531X_REG_HO_FREEZE_NOTIF, 0xFF);
+	if (rc)
+		return rc;
+	rc = sit9531x_write_u8(sitdev, SIT9531X_REG_PLL_INNER_LOL_NOTIF, 0xFF);
+	if (rc)
+		return rc;
+	rc = sit9531x_write_u8(sitdev, SIT9531X_REG_CMON_NOTIF, 0xFF);
+	if (rc)
+		return rc;
+
+	/* Page 0x06 clock input monitor notifications */
+	rc = sit9531x_write_u8(sitdev, SIT9531X_CLKMON_P_NOTIF_01, 0xFF);
+	if (rc)
+		return rc;
+	rc = sit9531x_write_u8(sitdev, SIT9531X_CLKMON_P_NOTIF_23, 0xFF);
+	if (rc)
+		return rc;
+	rc = sit9531x_write_u8(sitdev, SIT9531X_CLKMON_N_NOTIF_01, 0xFF);
+	if (rc)
+		return rc;
+	rc = sit9531x_write_u8(sitdev, SIT9531X_CLKMON_N_NOTIF_23, 0xFF);
+	if (rc)
+		return rc;
+
+	dev_dbg(sitdev->dev, "All notification registers cleared\n");
+	return 0;
+}
+
+/* ====================================================================
+ * INTSYNC (inter-PLL synchronization)
+ * ====================================================================
+ */
+
+/*
+ * INTSYNC configuration register values.
+ * These are written to the source PLL's EXT page to enable/disable
+ * inter-PLL synchronization (lock frequency PLL to phase PLL).
+ */
+struct sit9531x_intsync_reg {
+	u8 offset;
+	u8 en_val;
+	u8 dis_val;
+};
+
+static const struct sit9531x_intsync_reg intsync_config[] = {
+	{ 0x2D, 0x02, 0x00 },
+	{ 0x50, 0x08, 0x00 },
+	{ 0x51, 0x04, 0x00 },
+	{ 0x54, 0x02, 0x00 },
+	{ 0x55, 0x28, 0x20 },
+	{ 0x5C, 0x0F, 0x00 },
+	{ 0x5D, 0xFF, 0x00 },
+	{ 0x6C, 0xDD, 0x00 },
+};
+
+/**
+ * sit9531x_intsync_enable - enable inter-PLL synchronization
+ * @sitdev:	device pointer
+ * @src_pll_idx: source (frequency) PLL index (0-3)
+ *
+ * Enables INTSYNC global bit, unlocks the source PLL's EXT page
+ * debug registers, writes configuration, and triggers a small
+ * update on the source PLL.
+ *
+ * Caller must hold sitdev->multiop_lock.
+ *
+ * Return: 0 on success, <0 on error
+ */
+int sit9531x_intsync_enable(struct sit9531x_dev *sitdev, u8 src_pll_idx)
+{
+	u8 ext_page, val;
+	int rc, i;
+
+	lockdep_assert_held(&sitdev->multiop_lock);
+
+	if (src_pll_idx >= SIT9531X_NUM_PLLS)
+		return -EINVAL;
+
+	ext_page = SIT9531X_PLL_EXT_PAGE(src_pll_idx);
+
+	/* Set INTSYNC global enable bit (Page 0, reg 0x40 bit 6) */
+	rc = sit9531x_read_u8(sitdev, SIT9531X_REG_INTSYNC_GLOBAL, &val);
+	if (rc)
+		return rc;
+	rc = sit9531x_write_u8(sitdev, SIT9531X_REG_INTSYNC_GLOBAL,
+			       val | BIT(SIT9531X_INTSYNC_EN_BIT));
+	if (rc)
+		return rc;
+
+	/* Small update on Page 0 */
+	rc = sit9531x_write_u8(sitdev, SIT9531X_REG_GLOBAL_UPDATE,
+			       SIT9531X_PLL_SMALL_UPDATE_CMD);
+	if (rc)
+		return rc;
+
+	/* Unlock debug on EXT page */
+	rc = sit9531x_write_u8(sitdev, SIT9531X_REG(ext_page, SIT9531X_PLL_REG_DEBUG),
+			       SIT9531X_PLL_DEBUG_UNLOCK);
+	if (rc)
+		return rc;
+
+	/* Write INTSYNC configuration */
+	for (i = 0; i < ARRAY_SIZE(intsync_config); i++) {
+		rc = sit9531x_write_u8(sitdev,
+				       SIT9531X_REG(ext_page,
+						    intsync_config[i].offset),
+				       intsync_config[i].en_val);
+		if (rc)
+			return rc;
+	}
+
+	/* Small update on source PLL */
+	rc = sit9531x_write_pll_u8(sitdev, src_pll_idx,
+				   SIT9531X_PLL_REG_SMALL_UPDATE,
+				   SIT9531X_PLL_SMALL_UPDATE_CMD);
+	if (rc)
+		return rc;
+
+	dev_info(sitdev->dev, "INTSYNC enabled on PLL%c\n",
+		 'A' + src_pll_idx);
+	return 0;
+}
+
+/**
+ * sit9531x_intsync_disable - disable inter-PLL synchronization
+ * @sitdev:	device pointer
+ * @src_pll_idx: source (frequency) PLL index (0-3)
+ *
+ * Clears INTSYNC global bit, writes disable values to the source
+ * PLL's EXT page, and triggers a small update.
+ *
+ * Caller must hold sitdev->multiop_lock.
+ *
+ * Return: 0 on success, <0 on error
+ */
+int sit9531x_intsync_disable(struct sit9531x_dev *sitdev, u8 src_pll_idx)
+{
+	u8 ext_page, val;
+	int rc, i;
+
+	lockdep_assert_held(&sitdev->multiop_lock);
+
+	if (src_pll_idx >= SIT9531X_NUM_PLLS)
+		return -EINVAL;
+
+	ext_page = SIT9531X_PLL_EXT_PAGE(src_pll_idx);
+
+	/* Clear INTSYNC global enable bit */
+	rc = sit9531x_read_u8(sitdev, SIT9531X_REG_INTSYNC_GLOBAL, &val);
+	if (rc)
+		return rc;
+	rc = sit9531x_write_u8(sitdev, SIT9531X_REG_INTSYNC_GLOBAL,
+			       val & ~BIT(SIT9531X_INTSYNC_EN_BIT));
+	if (rc)
+		return rc;
+
+	/* Small update on Page 0 */
+	rc = sit9531x_write_u8(sitdev, SIT9531X_REG_GLOBAL_UPDATE,
+			       SIT9531X_PLL_SMALL_UPDATE_CMD);
+	if (rc)
+		return rc;
+
+	/* Unlock debug on EXT page */
+	rc = sit9531x_write_u8(sitdev, SIT9531X_REG(ext_page, SIT9531X_PLL_REG_DEBUG),
+			       SIT9531X_PLL_DEBUG_UNLOCK);
+	if (rc)
+		return rc;
+
+	/* Write INTSYNC configuration */
+	for (i = 0; i < ARRAY_SIZE(intsync_config); i++) {
+		rc = sit9531x_write_u8(sitdev,
+				       SIT9531X_REG(ext_page,
+						    intsync_config[i].offset),
+				       intsync_config[i].dis_val);
+		if (rc)
+			return rc;
+	}
+
+	/* Small update on source PLL */
+	rc = sit9531x_write_pll_u8(sitdev, src_pll_idx,
+				   SIT9531X_PLL_REG_SMALL_UPDATE,
+				   SIT9531X_PLL_SMALL_UPDATE_CMD);
+	if (rc)
+		return rc;
+
+	dev_info(sitdev->dev, "INTSYNC disabled on PLL%c\n",
+		 'A' + src_pll_idx);
+	return 0;
+}
+
+/**
+ * sit9531x_pll_sysref_mode_set - configure SYSREF / SYNCB / Pulser output mode
+ * @sitdev:		device pointer
+ * @pll_idx:		PLL index (0=PLLA ... 3=PLLD)
+ * @mode:		one of sit9531x_sysref_mode (DISABLE, SYSREF, SYNCB, PULSER)
+ * @target_outputs:	12-bit one-hot mask selecting which physical chip
+ *			slots (0..11) are driven by this PLL's SYSREF/SYNCB
+ *
+ * Programs PLL_CONFIG47_PLL bits 6/5/4 (DIVO_PULSER_MODE / DIVO_SYSREF_MODE
+ * / DIVO_SYNCB_MODE) and bits 3:0 (DIVO_SYS_REF[11:8]) plus
+ * Sysref_sel_PLL (DIVO_SYS_REF[7:0]).  The per-PLL small-change trigger
+ * enable on Page 0 reg 0x19 is set when mode != DISABLE and cleared when
+ * mode == DISABLE.
+ *
+ * The mask is one-hot per physical slot.  Callers needing to convert
+ * from logical output index must do so via info->clkout_map[].
+ *
+ * Caller must hold sitdev->multiop_lock.
+ *
+ * Return: 0 on success, <0 on error.
+ */
+int sit9531x_pll_sysref_mode_set(struct sit9531x_dev *sitdev, u8 pll_idx,
+				 enum sit9531x_sysref_mode mode,
+				 u16 target_outputs)
+{
+	u8 mode_bits = 0;
+	int rc;
+
+	if (pll_idx >= SIT9531X_NUM_PLLS)
+		return -EINVAL;
+	if (target_outputs & ~0x0FFFU)
+		return -EINVAL;
+
+	switch (mode) {
+	case SIT9531X_SYSREF_DISABLE:
+		break;
+	case SIT9531X_SYSREF_MODE_SYSREF:
+		mode_bits = SIT9531X_PLL_SYSREF_MODE_BIT;
+		break;
+	case SIT9531X_SYSREF_MODE_SYNCB:
+		mode_bits = SIT9531X_PLL_SYSREF_SYNCB_BIT;
+		break;
+	case SIT9531X_SYSREF_MODE_PULSER:
+		mode_bits = SIT9531X_PLL_SYSREF_PULSER_BIT |
+			    SIT9531X_PLL_SYSREF_MODE_BIT;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* PLL reg 0x47: mode bits [6:4] + DIVO_SYS_REF[11:8] in [3:0] */
+	rc = sit9531x_update_pll_u8(sitdev, pll_idx,
+				    SIT9531X_PLL_REG_SYSREF_MODE,
+				    SIT9531X_PLL_SYSREF_MODE_MASK |
+				    SIT9531X_PLL_SYSREF_TARGET_HI_MASK,
+				    mode_bits |
+				    ((target_outputs >> 8) &
+				     SIT9531X_PLL_SYSREF_TARGET_HI_MASK));
+	if (rc)
+		return rc;
+
+	/* PLL reg 0x48: DIVO_SYS_REF[7:0] */
+	rc = sit9531x_write_pll_u8(sitdev, pll_idx,
+				   SIT9531X_PLL_REG_SYSREF_SEL,
+				   target_outputs & 0xFF);
+	if (rc)
+		return rc;
+
+	/* Page 0 reg 0x19: enable small-change (SYSREF) trigger for this PLL */
+	{
+		u8 trig_bit = BIT(SIT9531X_DIVO_SYSREF_TRIG_BIT(pll_idx));
+		u8 val;
+
+		rc = sit9531x_read_u8(sitdev, SIT9531X_REG_DIVO_TRIGGER_EN,
+				      &val);
+		if (rc)
+			return rc;
+		if (mode == SIT9531X_SYSREF_DISABLE)
+			val &= ~trig_bit;
+		else
+			val |= trig_bit;
+		rc = sit9531x_write_u8(sitdev, SIT9531X_REG_DIVO_TRIGGER_EN,
+				       val);
+		if (rc)
+			return rc;
+	}
+
+	dev_info(sitdev->dev,
+		 "PLL%c sysref mode=%d target_outputs=0x%03x\n",
+		 'A' + pll_idx, mode, target_outputs);
+	return 0;
+}
+
+/**
+ * sit9531x_output_pulse_ctrl_set - program per-output PULSE_CTRL byte
+ * @sitdev:	device pointer
+ * @out_idx:	logical output index (translated to chip slot internally)
+ * @pulse_ctrl:	8-bit PULSE_CTRL value (PROG0)
+ *
+ * Writes ODRn_PROG0 on the output page (Page 3 for slots 0..5,
+ * Page 4 for slots 6..11) at offset 0x1B + 16 * (slot % 6).
+ *
+ * Caller must hold sitdev->multiop_lock.
+ *
+ * Return: 0 on success, <0 on error.
+ */
+int sit9531x_output_pulse_ctrl_set(struct sit9531x_dev *sitdev,
+				   u8 out_idx, u8 pulse_ctrl)
+{
+	const struct sit9531x_chip_info *info = sitdev->info;
+	u8 slot, page, reg;
+
+	if (out_idx >= info->num_outputs)
+		return -EINVAL;
+
+	slot = info->clkout_map[out_idx];
+	page = (slot > SIT9531X_PAGE_OUTSYS0_SLOT_MAX) ?
+		SIT9531X_PAGE_OUTSYS1 : SIT9531X_PAGE_OUTSYS0;
+	reg = SIT9531X_OUT_PROG0_BASE +
+	      SIT9531X_OUT_PRG_SLOT_STRIDE * (slot % 6);
+
+	return sit9531x_write_u8(sitdev, SIT9531X_REG(page, reg),
+				 pulse_ctrl);
+}
+
+/* ====================================================================
+ * Phase offset readback (TDC)
+ * ====================================================================
+ */
+
+/**
+ * sit9531x_phase_offset_read - read phase difference via TDC
+ * @sitdev:	device pointer
+ * @pll_idx:	PLL index (0-3)
+ * @phase_ps:	output phase difference in picoseconds
+ *
+ * Reads the Time-to-Digital Converter (TDC) 40-bit code from the
+ * PLL page registers, then converts to picoseconds using the VCO
+ * frequency: phase_diff = tdc_code / fvco.
+ *
+ * Caller must hold sitdev->multiop_lock.
+ *
+ * Return: 0 on success, <0 on error
+ */
+int sit9531x_phase_offset_read(struct sit9531x_dev *sitdev, u8 pll_idx,
+			       s64 *phase_ps)
+{
+	u64 fvco, fvco_mhz;
+	s64 tdc_signed;
+	u64 tdc_raw;
+	int rc, i;
+	bool sign;
+	u8 v;
+
+	lockdep_assert_held(&sitdev->multiop_lock);
+
+	if (pll_idx >= SIT9531X_NUM_PLLS)
+		return -EINVAL;
+
+	/* Configure TDC */
+	rc = sit9531x_write_pll_u8(sitdev, pll_idx,
+				   SIT9531X_PLL_REG_TDC_MODE,
+				   SIT9531X_TDC_MODE_ENABLE);
+	if (rc)
+		return rc;
+	rc = sit9531x_write_pll_u8(sitdev, pll_idx,
+				   SIT9531X_PLL_REG_TDC_CFG,
+				   SIT9531X_TDC_CFG_DEFAULT);
+	if (rc)
+		return rc;
+
+	/* Trigger TDC sampling by reading the trigger register 3 times */
+	for (i = 0; i < 3; i++) {
+		rc = sit9531x_read_pll_u8(sitdev, pll_idx,
+					  SIT9531X_PLL_REG_TDC_TRIGGER, &v);
+		if (rc)
+			return rc;
+	}
+
+	/* Read 40-bit TDC code (5 bytes: 0xB5-0xB9) */
+	tdc_raw = 0;
+
+	rc = sit9531x_read_pll_u8(sitdev, pll_idx,
+				  SIT9531X_PLL_REG_TDC_DATA_4, &v);
+	if (rc)
+		return rc;
+	sign = !!(v & BIT(SIT9531X_TDC_SIGN_BIT));
+	tdc_raw = (u64)(v & 0x07) << 32;
+
+	rc = sit9531x_read_pll_u8(sitdev, pll_idx,
+				  SIT9531X_PLL_REG_TDC_DATA_3, &v);
+	if (rc)
+		return rc;
+	tdc_raw |= (u64)v << 24;
+
+	rc = sit9531x_read_pll_u8(sitdev, pll_idx,
+				  SIT9531X_PLL_REG_TDC_DATA_2, &v);
+	if (rc)
+		return rc;
+	tdc_raw |= (u64)v << 16;
+
+	rc = sit9531x_read_pll_u8(sitdev, pll_idx,
+				  SIT9531X_PLL_REG_TDC_DATA_1, &v);
+	if (rc)
+		return rc;
+	tdc_raw |= (u64)v << 8;
+
+	rc = sit9531x_read_pll_u8(sitdev, pll_idx,
+				  SIT9531X_PLL_REG_TDC_DATA_0, &v);
+	if (rc)
+		return rc;
+	tdc_raw |= v;
+
+	/* Apply sign */
+	tdc_signed = sign ? -(s64)tdc_raw : (s64)tdc_raw;
+
+	/*
+	 * Get VCO frequency for conversion.  Fvco==0 means DIVN is not
+	 * programmed (PLL unused on this board) -- skip silently rather
+	 * than spamming the log on every poll cycle.
+	 */
+	fvco = sit9531x_get_fvco(sitdev, pll_idx);
+	if (!fvco) {
+		dev_dbg(sitdev->dev, "PLL%c: Fvco unknown, skip TDC\n",
+			'A' + pll_idx);
+		return -ENODEV;
+	}
+
+	/*
+	 * phase_diff (seconds) = tdc_code / fvco
+	 * phase_diff (ps) = tdc_code * 1e12 / fvco
+	 *
+	 * To avoid 64-bit overflow:
+	 *   phase_ps = tdc_code * 1e6 / (fvco / 1e6)
+	 */
+	fvco_mhz = div64_u64(fvco, 1000000ULL);
+	if (!fvco_mhz)
+		return -EIO;
+
+	*phase_ps = div64_s64(tdc_signed * 1000000LL, (s64)fvco_mhz);
+
+	return 0;
+}
+
+/* ====================================================================
+ * Hardware state fetch
+ * ====================================================================
+ */
+
+/*
+ * sit9531x_ref_state_fetch - read input reference status from hardware
+ * @sitdev:	device pointer
+ * @index:	input reference index
+ *
+ * Reads LOS and OOF status bits for the given input reference.
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int sit9531x_ref_state_fetch(struct sit9531x_dev *sitdev, u8 index)
+{
+	struct sit9531x_ref *ref = &sitdev->ref[index];
+	u8 los_status, oof_status;
+	int rc;
+
+	rc = sit9531x_read_u8(sitdev, SIT9531X_REG_LOS_STATUS, &los_status);
+	if (rc)
+		return rc;
+
+	rc = sit9531x_read_u8(sitdev, SIT9531X_REG_OOF_STATUS, &oof_status);
+	if (rc)
+		return rc;
+
+	ref->los = !!(los_status & BIT(index));
+	ref->oof = !!(oof_status & BIT(index));
+
+	return 0;
+}
+
+/*
+ * sit9531x_chan_state_fetch - read PLL channel status from hardware
+ * @sitdev:	device pointer
+ * @pll_idx:	PLL index (0-3)
+ *
+ * Reads lock status and mode from the PLL status register.
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int sit9531x_chan_state_fetch(struct sit9531x_dev *sitdev, u8 pll_idx)
+{
+	u8 status, holdover, input_sel, inner_lol, ho_freeze;
+	struct sit9531x_chan *chan = &sitdev->chan[pll_idx];
+	int rc;
+
+	/* Read PLL lock/mode from PLL page */
+	rc = sit9531x_read_pll_u8(sitdev, pll_idx,
+				  SIT9531X_PLL_REG_STATUS, &status);
+	if (rc)
+		return rc;
+
+	/* Read holdover status from Page 0 */
+	rc = sit9531x_read_u8(sitdev, SIT9531X_REG_HOLDOVER_STATUS, &holdover);
+	if (rc)
+		return rc;
+
+	/* Read selected input reference */
+	rc = sit9531x_read_pll_u8(sitdev, pll_idx,
+				  SIT9531X_PLL_REG_INPUT_SEL, &input_sel);
+	if (rc)
+		return rc;
+
+	/* Read PLL inner loop loss-of-lock */
+	rc = sit9531x_read_u8(sitdev, SIT9531X_REG_PLL_INNER_LOL_STATUS,
+			      &inner_lol);
+	if (rc)
+		return rc;
+
+	/* Read holdover freeze status */
+	rc = sit9531x_read_u8(sitdev, SIT9531X_REG_HO_FREEZE_STATUS, &ho_freeze);
+	if (rc)
+		return rc;
+
+	/*
+	 * Holdover bit set means the PLL is in holdover -- i.e. NOT locked
+	 * to its input.  Invert the polarity so chan->locked reflects the
+	 * intuitive sense (true == locked, false == holdover / free-run).
+	 */
+	chan->locked = !(holdover & BIT(pll_idx));
+	chan->mode = !!(status & SIT9531X_PLL_STATUS_OUTER_DIS);
+	chan->selected_ref = input_sel;
+	chan->inner_lol = !!(inner_lol & BIT(pll_idx));
+	chan->ho_freeze = !!(ho_freeze & BIT(pll_idx));
+
+	return 0;
+}
+
+/*
+ * sit9531x_out_state_fetch - read output status from hardware
+ * @sitdev:	device pointer
+ * @index:	output index
+ *
+ * Reads the output PLL association from the PLL page output map
+ * registers.
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int sit9531x_out_state_fetch(struct sit9531x_dev *sitdev, u8 index)
+{
+	struct sit9531x_out *out = &sitdev->out[index];
+	u8 map_lo, map_hi;
+	int pll_idx;
+
+	/*
+	 * Determine which PLL drives this output by checking each PLL's
+	 * output map registers (0x27 = outputs 8-11, 0x28 = outputs 0-7).
+	 */
+	for (pll_idx = 0; pll_idx < SIT9531X_NUM_PLLS; pll_idx++) {
+		int rc;
+
+		rc = sit9531x_read_pll_u8(sitdev, pll_idx,
+					  SIT9531X_PLL_REG_OUT_MAP_LO, &map_lo);
+		if (rc)
+			return rc;
+
+		rc = sit9531x_read_pll_u8(sitdev, pll_idx,
+					  SIT9531X_PLL_REG_OUT_MAP_HI, &map_hi);
+		if (rc)
+			return rc;
+
+		if (index < 8) {
+			if (map_lo & BIT(index)) {
+				out->pll_idx = pll_idx;
+				out->enabled = true;
+				return 0;
+			}
+		} else {
+			if (map_hi & BIT(index - 8)) {
+				out->pll_idx = pll_idx;
+				out->enabled = true;
+				return 0;
+			}
+		}
+	}
+
+	/* Output not mapped to any PLL */
+	out->pll_idx = 0;
+	out->enabled = false;
+
+	return 0;
+}
+
+/*
+ * sit9531x_dev_state_fetch - read all hardware state at startup
+ * @sitdev:	device pointer
+ *
+ * Called once during probe to populate the initial state cache.
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int sit9531x_dev_state_fetch(struct sit9531x_dev *sitdev)
+{
+	int rc;
+	u8 i;
+
+	for (i = 0; i < sitdev->info->num_inputs; i++) {
+		rc = sit9531x_ref_state_fetch(sitdev, i);
+		if (rc) {
+			dev_err(sitdev->dev,
+				"Failed to fetch input %u state: %d\n", i, rc);
+			return rc;
+		}
+	}
+
+	for (i = 0; i < sitdev->info->num_outputs; i++) {
+		rc = sit9531x_out_state_fetch(sitdev, i);
+		if (rc) {
+			dev_err(sitdev->dev,
+				"Failed to fetch output %u state: %d\n", i, rc);
+			return rc;
+		}
+	}
+
+	for (i = 0; i < SIT9531X_NUM_PLLS; i++) {
+		rc = sit9531x_chan_state_fetch(sitdev, i);
+		if (rc) {
+			dev_err(sitdev->dev,
+				"Failed to fetch PLL%c state: %d\n",
+				'A' + i, rc);
+			return rc;
+		}
+	}
+
+	return 0;
+}
+
+/* ====================================================================
+ * Periodic work thread
+ * ====================================================================
+ */
+
+/*
+ * sit9531x_dev_ref_states_update - update all input reference states
+ * @sitdev:	device pointer
+ */
+static void sit9531x_dev_ref_states_update(struct sit9531x_dev *sitdev)
+{
+	int i, rc;
+
+	for (i = 0; i < sitdev->info->num_inputs; i++) {
+		rc = sit9531x_ref_state_fetch(sitdev, i);
+		if (rc)
+			dev_warn(sitdev->dev,
+				 "Failed to get REF%u status: %d\n", i, rc);
+	}
+}
+
+/*
+ * sit9531x_dev_chan_states_update - update all PLL channel states
+ * @sitdev:	device pointer
+ */
+static void sit9531x_dev_chan_states_update(struct sit9531x_dev *sitdev)
+{
+	int i, rc;
+
+	for (i = 0; i < SIT9531X_NUM_PLLS; i++) {
+		rc = sit9531x_chan_state_fetch(sitdev, i);
+		if (rc)
+			dev_warn(sitdev->dev,
+				 "Failed to get PLL%c state: %d\n",
+				 'A' + i, rc);
+	}
+}
+
+/*
+ * sit9531x_dev_periodic_work - periodic hardware state polling
+ * @work:	kthread_work pointer
+ *
+ * Polls hardware state at SIT9531X_STATUS_POLL_MS intervals.
+ * Updates reference and channel states, then delegates change
+ * detection to sit9531x_dpll_changes_check() for each registered DPLL.
+ */
+static void sit9531x_dev_periodic_work(struct kthread_work *work)
+{
+	struct sit9531x_dev *sitdev = container_of(work, struct sit9531x_dev,
+						   work.work);
+	struct sit9531x_dpll *sitdpll;
+	int rc;
+
+	/* Update input references' states */
+	sit9531x_dev_ref_states_update(sitdev);
+
+	/* Update PLL channels' states */
+	sit9531x_dev_chan_states_update(sitdev);
+
+	/* Check for state changes on each registered DPLL */
+	list_for_each_entry(sitdpll, &sitdev->dplls, list)
+		sit9531x_dpll_changes_check(sitdpll);
+
+	/*
+	 * Acknowledge the chip's notification latches after the tick has
+	 * read and acted on them.  Without this, the W1C bits remain set
+	 * and -- on boards that wire INTRB -- the line stays asserted,
+	 * re-firing the threaded handler back to back.  The helper writes
+	 * W1C bits across page 0 and page 6 and must run under
+	 * multiop_lock to serialise the page selector against userspace
+	 * dpll ops.  Failure is non-fatal: status was already consumed
+	 * for this tick and the next tick re-processes whatever stayed
+	 * latched.
+	 */
+	mutex_lock(&sitdev->multiop_lock);
+	rc = sit9531x_clear_notifications(sitdev);
+	mutex_unlock(&sitdev->multiop_lock);
+	if (rc)
+		dev_warn_ratelimited(sitdev->dev,
+				     "Failed to clear notifications: %d\n",
+				     rc);
+
+	/* Run twice a second */
+	kthread_queue_delayed_work(sitdev->kworker, &sitdev->work,
+				   msecs_to_jiffies(SIT9531X_STATUS_POLL_MS));
+}
+
+/*
+ * sit9531x_irq_thread_fn - threaded IRQ handler for the chip's INTRB line
+ *
+ * Triggered when the chip asserts INTRB (and only when DT wires up the
+ * client interrupt; absent property == handler never installed).  The
+ * action mirrors a periodic-work tick: queue an immediate run so status
+ * registers are read and DPLL changes_check fires without waiting for
+ * the next poll deadline.  Polling continues to run as a fallback.
+ */
+static irqreturn_t sit9531x_irq_thread_fn(int irq, void *data)
+{
+	struct sit9531x_dev *sitdev = data;
+
+	kthread_mod_delayed_work(sitdev->kworker, &sitdev->work, 0);
+	return IRQ_HANDLED;
+}
+
+/* ====================================================================
+ * Device lifecycle -- start / stop / dpll_init / dpll_fini
+ * ====================================================================
+ */
+
+/**
+ * sit9531x_dev_start - start normal operation
+ * @sitdev:	device pointer
+ *
+ * Fetches initial hardware state, registers all DPLL devices and
+ * their pins, and starts the periodic monitoring thread.
+ *
+ * Return: 0 on success, <0 on error
+ */
+int sit9531x_dev_start(struct sit9531x_dev *sitdev)
+{
+	struct sit9531x_dpll *sitdpll;
+	int rc;
+
+	/* Fetch device state */
+	rc = sit9531x_dev_state_fetch(sitdev);
+	if (rc)
+		return rc;
+
+	/* Register all DPLLs */
+	list_for_each_entry(sitdpll, &sitdev->dplls, list) {
+		rc = sit9531x_dpll_register(sitdpll);
+		if (rc) {
+			dev_err_probe(sitdev->dev, rc,
+				      "Failed to register DPLL%u\n",
+				      sitdpll->id);
+			return rc;
+		}
+	}
+
+	/* Start monitoring */
+	kthread_queue_delayed_work(sitdev->kworker, &sitdev->work, 0);
+
+	return 0;
+}
+
+/**
+ * sit9531x_dev_stop - stop normal operation
+ * @sitdev:	device pointer
+ *
+ * Cancels the monitoring thread and unregisters all DPLL devices
+ * and their pins.
+ */
+void sit9531x_dev_stop(struct sit9531x_dev *sitdev)
+{
+	struct sit9531x_dpll *sitdpll;
+
+	/* Stop monitoring */
+	kthread_cancel_delayed_work_sync(&sitdev->work);
+
+	/* Unregister all DPLLs */
+	list_for_each_entry(sitdpll, &sitdev->dplls, list) {
+		if (sitdpll->dpll_dev)
+			sit9531x_dpll_unregister(sitdpll);
+	}
+}
+
+static void sit9531x_dev_dpll_fini(void *ptr)
+{
+	struct sit9531x_dpll *sitdpll, *next;
+	struct sit9531x_dev *sitdev = ptr;
+
+	/* Stop monitoring and unregister DPLLs */
+	sit9531x_dev_stop(sitdev);
+
+	/* Destroy monitoring thread */
+	if (sitdev->kworker) {
+		kthread_destroy_worker(sitdev->kworker);
+		sitdev->kworker = NULL;
+	}
+
+	/* Free all DPLLs */
+	list_for_each_entry_safe(sitdpll, next, &sitdev->dplls, list) {
+		list_del(&sitdpll->list);
+		sit9531x_dpll_free(sitdpll);
+	}
+}
+
+/*
+ * sit9531x_devm_dpll_init - allocate DPLLs and start the device
+ * @sitdev:	device pointer
+ *
+ * Allocates one DPLL per PLL channel, creates the monitoring thread,
+ * starts normal operation, and registers a devres cleanup action.
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int sit9531x_devm_dpll_init(struct sit9531x_dev *sitdev)
+{
+	struct kthread_worker *kworker;
+	struct sit9531x_dpll *sitdpll;
+	unsigned int i;
+	int rc;
+
+	INIT_LIST_HEAD(&sitdev->dplls);
+
+	/* Allocate all DPLLs */
+	for (i = 0; i < SIT9531X_NUM_PLLS; i++) {
+		sitdpll = sit9531x_dpll_alloc(sitdev, i);
+		if (IS_ERR(sitdpll)) {
+			dev_err_probe(sitdev->dev, PTR_ERR(sitdpll),
+				      "Failed to alloc DPLL%u\n", i);
+			rc = PTR_ERR(sitdpll);
+			goto error;
+		}
+
+		list_add_tail(&sitdpll->list, &sitdev->dplls);
+	}
+
+	/* Initialize monitoring thread */
+	kthread_init_delayed_work(&sitdev->work, sit9531x_dev_periodic_work);
+	kworker = kthread_run_worker(0, "sit9531x-%s",
+				     dev_name(sitdev->dev));
+	if (IS_ERR(kworker)) {
+		rc = PTR_ERR(kworker);
+		goto error;
+	}
+	sitdev->kworker = kworker;
+
+	/* Start normal operation */
+	rc = sit9531x_dev_start(sitdev);
+	if (rc) {
+		dev_err_probe(sitdev->dev, rc, "Failed to start device\n");
+		goto error;
+	}
+
+	/* Add devres action to release DPLL related resources */
+	return devm_add_action_or_reset(sitdev->dev, sit9531x_dev_dpll_fini,
+					sitdev);
+
+error:
+	sit9531x_dev_dpll_fini(sitdev);
+
+	return rc;
+}
+
+/* ====================================================================
+ * Chip identification
+ * ====================================================================
+ */
+
+/*
+ * sit9531x_read_variant_id - read chip variant ID byte from hardware
+ * @sitdev:	device pointer
+ * @id:		output variant ID byte
+ *
+ * Reads the single-byte variant identification register from Page 0
+ * reg 0x02 (95317 = 0x17, 95316 = 0x31).  Reg 0x03 holds a separate
+ * revision byte and is intentionally not consumed here.
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int sit9531x_read_variant_id(struct sit9531x_dev *sitdev, u8 *id)
+{
+	return sit9531x_read_u8(sitdev, SIT9531X_REG_VARIANT_ID, id);
+}
+
+/*
+ * sit9531x_match_variant - match variant ID against known variants
+ * @id:	variant ID byte
+ *
+ * Return: pointer to chip_info on match, NULL on unknown ID
+ */
+static const struct sit9531x_chip_info *sit9531x_match_variant(u8 id)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(sit9531x_chip_ids); i++) {
+		if (sit9531x_chip_ids[i].id == id)
+			return &sit9531x_chip_ids[i];
+	}
+
+	return NULL;
+}
+
+/*
+ * sit9531x_derive_clock_id - build EUI-64 clock identifier
+ * @sitdev:	device pointer
+ *
+ * Generates a deterministic 64-bit identifier from the SiTime OUI,
+ * the chip ID, and the I2C address.  This provides a stable clock_id
+ * across reboots.
+ *
+ * Return: 64-bit clock identifier
+ */
+static u64 sit9531x_derive_clock_id(struct sit9531x_dev *sitdev)
+{
+	u64 clkid;
+
+	clkid  = SIT9531X_OUI << 24;
+	clkid |= (u64)sitdev->info->id << 8;
+	clkid |= (u64)sitdev->client->addr;
+
+	return clkid;
+}
+
+/* ====================================================================
+ * Probe entry point
+ * ====================================================================
+ */
+
+/**
+ * sit9531x_dev_probe - initialize SiT9531x device
+ * @sitdev:	pointer to device structure (caller-allocated)
+ *
+ * Common initialization: read chip ID, match variant, generate
+ * clock_id, initialize synchronization mutex, and register DPLL
+ * channels.  Called from the I2C probe function.
+ *
+ * Return: 0 on success, <0 on error
+ */
+int sit9531x_dev_probe(struct sit9531x_dev *sitdev)
+{
+	struct clk *xtal_clk;
+	u8 variant_id;
+	int rc;
+
+	/*
+	 * Read the external reference (XO) feeding the chip's XIN/XO_CLK
+	 * input.  Required: Fvco computation does
+	 * Fvco = Fref * (DIVN + frac/2^32) with Fref = xtal_freq << doubler,
+	 * so without a populated xtal_freq every freq_set/phase_adjust path
+	 * dividing by Fvco fails with -EIO.  DT property "clocks" pointing
+	 * to a fixed-clock node with clock-names = "xtal" is mandatory.
+	 */
+	xtal_clk = devm_clk_get_optional_enabled(sitdev->dev, "xtal");
+	if (IS_ERR(xtal_clk))
+		return dev_err_probe(sitdev->dev, PTR_ERR(xtal_clk),
+				     "Failed to get xtal clock\n");
+	sitdev->xtal_freq = xtal_clk ? clk_get_rate(xtal_clk) : 0;
+	if (!sitdev->xtal_freq)
+		return dev_err_probe(sitdev->dev, -EINVAL,
+				     "xtal clock rate is 0; DT must provide clocks=<&xo> and clock-names=\"xtal\"\n");
+	dev_info(sitdev->dev, "xtal_freq=%u Hz\n", sitdev->xtal_freq);
+
+	/* Read variant ID byte */
+	rc = sit9531x_read_variant_id(sitdev, &variant_id);
+	if (rc)
+		return rc;
+
+	/* Detect chip variant */
+	sitdev->info = sit9531x_match_variant(variant_id);
+	if (!sitdev->info)
+		return dev_err_probe(sitdev->dev, -ENODEV,
+				     "Unknown variant ID: 0x%02x\n", variant_id);
+
+	dev_info(sitdev->dev, "VariantID(0x%02X), %s (%u in, %u out)\n",
+		 variant_id, sitdev->info->name,
+		 sitdev->info->num_inputs, sitdev->info->num_outputs);
+
+	/* Generate deterministic clock ID */
+	sitdev->clock_id = sit9531x_derive_clock_id(sitdev);
+
+	/* Initialize mutex for multi-register atomic operations */
+	rc = devm_mutex_init(sitdev->dev, &sitdev->multiop_lock);
+	if (rc)
+		return dev_err_probe(sitdev->dev, rc,
+				     "Failed to initialize mutex\n");
+
+	/*
+	 * Optional DT-described reset line.  Requested in the deasserted
+	 * state so any prior chip programming is not torn down by the
+	 * request itself; the descriptor is held for an explicit reset
+	 * path.  Absent DT property == descriptor stays NULL, no
+	 * behaviour change.
+	 */
+	sitdev->reset_gpio = devm_gpiod_get_optional(sitdev->dev, "reset",
+						     GPIOD_OUT_LOW);
+	if (IS_ERR(sitdev->reset_gpio))
+		return dev_err_probe(sitdev->dev, PTR_ERR(sitdev->reset_gpio),
+				     "Failed to request reset gpio\n");
+	if (sitdev->reset_gpio)
+		dev_info(sitdev->dev, "reset-gpios: present (held deasserted)\n");
+
+	/*
+	 * Register DPLL channels and create the kworker first.  The IRQ
+	 * handler dereferences sitdev->kworker via
+	 * kthread_mod_delayed_work(), so it must be live before any
+	 * INTRB assertion can land on the request_threaded_irq path.
+	 */
+	rc = sit9531x_devm_dpll_init(sitdev);
+	if (rc)
+		return rc;
+
+	/*
+	 * Optional INTRB IRQ from DT.  The I2C subsystem populates
+	 * client->irq from the node's "interrupts"/"interrupts-extended"
+	 * property; if no IRQ is wired client->irq is 0 and we keep
+	 * relying on the periodic poll.
+	 */
+	sitdev->irq = sitdev->client ? sitdev->client->irq : 0;
+	if (sitdev->irq > 0) {
+		rc = devm_request_threaded_irq(sitdev->dev, sitdev->irq,
+					       NULL, sit9531x_irq_thread_fn,
+					       IRQF_ONESHOT,
+					       dev_name(sitdev->dev), sitdev);
+		if (rc)
+			return dev_err_probe(sitdev->dev, rc,
+					     "Failed to request IRQ %d\n",
+					     sitdev->irq);
+		dev_info(sitdev->dev,
+			 "INTRB IRQ %d wired (threaded handler kicks periodic poll)\n",
+			 sitdev->irq);
+	}
+
+	return 0;
+}
+
+/* ====================================================================
+ * I2C driver
+ * ====================================================================
+ */
+
+static int sit9531x_i2c_probe(struct i2c_client *client)
+{
+	struct sit9531x_dev *sitdev;
+	struct regmap *regmap;
+
+	regmap = devm_regmap_init_i2c(client, &sit9531x_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(&client->dev, PTR_ERR(regmap),
+				     "Failed to initialize regmap\n");
+
+	sitdev = devm_kzalloc(&client->dev, sizeof(*sitdev), GFP_KERNEL);
+	if (!sitdev)
+		return -ENOMEM;
+
+	sitdev->dev = &client->dev;
+	sitdev->client = client;
+	sitdev->regmap = regmap;
+	i2c_set_clientdata(client, sitdev);
+
+	return sit9531x_dev_probe(sitdev);
+}
+
+static const struct i2c_device_id sit9531x_i2c_id[] = {
+	{ "sit95317" },
+	{ "sit95316" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, sit9531x_i2c_id);
+
+static const struct of_device_id sit9531x_of_match[] = {
+	{ .compatible = "sitime,sit95317" },
+	{ .compatible = "sitime,sit95316" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sit9531x_of_match);
+
+static struct i2c_driver sit9531x_i2c_driver = {
+	.driver = {
+		.name		= "sit9531x",
+		.of_match_table	= sit9531x_of_match,
+	},
+	.probe		= sit9531x_i2c_probe,
+	.id_table	= sit9531x_i2c_id,
+};
+module_i2c_driver(sit9531x_i2c_driver);
+
+MODULE_AUTHOR("Ali Rouhi <arouhi@sitime.com>");
+MODULE_AUTHOR("Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>");
+MODULE_DESCRIPTION("SiTime SiT9531x DPLL subsystem driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/dpll/sit9531x/core.h b/drivers/dpll/sit9531x/core.h
new file mode 100644
index 000000000000..df94341ca449
--- /dev/null
+++ b/drivers/dpll/sit9531x/core.h
@@ -0,0 +1,282 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * SiTime SiT9531x DPLL core driver
+ *
+ * Copyright (C) 2026 SiTime Corp.
+ * Author: Ali Rouhi <arouhi@sitime.com>
+ * Author: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>
+ *
+ * Device structure, register access helpers, and core function
+ * declarations.
+ */
+
+#ifndef _SIT9531X_CORE_H
+#define _SIT9531X_CORE_H
+
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/kthread.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/regmap.h>
+#include <linux/types.h>
+
+#include "regs.h"
+
+#define SIT9531X_NUM_PLLS		4
+#define SIT9531X_MAX_INPUTS		8
+#define SIT9531X_MAX_OUTPUTS		12
+#define SIT9531X_NUM_PINS		(SIT9531X_MAX_INPUTS + 1 + SIT9531X_MAX_OUTPUTS)
+#define SIT9531X_STATUS_POLL_MS		500
+
+/* SiTime IEEE OUI for EUI-64 generation */
+#define SIT9531X_OUI			0x0090C2FFFEULL
+
+struct sit9531x_dpll;
+
+/**
+ * struct sit9531x_chip_info - chip variant identification
+ * @id:		variant ID byte read from register
+ * @num_inputs:	number of input clock pins
+ * @num_outputs: number of output clock pins
+ * @name:	human-readable variant name
+ * @clkout_map:	per-output slot mapping (output index -> physical slot)
+ */
+struct sit9531x_chip_info {
+	u8		id;
+	u8		num_inputs;
+	u8		num_outputs;
+	const char	*name;
+	const u8	*clkout_map;
+};
+
+/**
+ * enum sit9531x_signal_mode - input signal electrical mode
+ * @SIT9531X_MODE_SE: single-ended
+ * @SIT9531X_MODE_DE: differential
+ */
+enum sit9531x_signal_mode {
+	SIT9531X_MODE_SE = 0,
+	SIT9531X_MODE_DE,
+};
+
+/**
+ * enum sit9531x_polarity - input signal polarity (for single-ended)
+ * @SIT9531X_POL_P: positive / non-inverted
+ * @SIT9531X_POL_N: negative / inverted
+ */
+enum sit9531x_polarity {
+	SIT9531X_POL_P = 0,
+	SIT9531X_POL_N,
+};
+
+/**
+ * struct sit9531x_ref - input reference state
+ * @freq:		configured frequency in Hz
+ * @enabled:		reference is enabled for monitoring
+ * @los:		loss-of-signal detected
+ * @oof:		out-of-frequency detected
+ * @pll_mask:		bitmask of PLLs this input feeds (bit 0 = PLLA)
+ * @label:		board label from DT or default
+ * @sig_mode:		signal mode (SE or DE)
+ * @polarity:		polarity (P or N, for SE only)
+ */
+struct sit9531x_ref {
+	u32		freq;
+	bool		enabled;
+	bool		los;
+	bool		oof;
+	u8		pll_mask;
+	const char	*label;
+	enum sit9531x_signal_mode	sig_mode;
+	enum sit9531x_polarity		polarity;
+};
+
+/**
+ * struct sit9531x_out - output state
+ * @freq:		current output frequency in Hz
+ * @enabled:		output is enabled
+ * @pll_idx:		PLL driving this output (0-3)
+ * @label:		board label from DT or default
+ */
+struct sit9531x_out {
+	u32		freq;
+	bool		enabled;
+	u8		pll_idx;
+	const char	*label;
+};
+
+/**
+ * struct sit9531x_chan - per-PLL channel state
+ * @lock_status:	hardware lock status (raw register bit)
+ * @mode:		0 = sync (outer loop enabled), 1 = free-run
+ * @selected_ref:	currently selected input reference index
+ * @inner_lol:		PLL inner loop loss-of-lock detected
+ * @ho_freeze:		holdover freeze active
+ */
+struct sit9531x_chan {
+	bool		locked;
+	u8		mode;
+	u8		selected_ref;
+	bool		inner_lol;
+	bool		ho_freeze;
+};
+
+/**
+ * struct sit9531x_dev - SiT9531x device instance
+ * @dev:		pointer to device
+ * @client:		I2C client
+ * @regmap:		regmap for register access
+ * @info:		detected chip variant info
+ * @multiop_lock:	mutex for multi-register atomic operations
+ * @ref:		array of input reference states
+ * @out:		array of output states
+ * @chan:		array of per-PLL channel states
+ * @xtal_freq:		crystal oscillator frequency in Hz
+ * @dplls:		list of registered DPLL devices
+ * @kworker:		kthread worker for periodic polling
+ * @work:		delayed work for periodic state checks
+ * @clock_id:		IEEE 1588 EUI-64 clock identifier
+ * @reset_gpio:		optional reset line (DT "reset-gpios"), NULL if absent
+ * @irq:		optional INTRB IRQ number (from DT "interrupts" via the
+ *			I2C client), 0 if no IRQ is wired
+ */
+struct sit9531x_dev {
+	struct device			*dev;
+	struct i2c_client		*client;
+	struct regmap			*regmap;
+	const struct sit9531x_chip_info	*info;
+	/* Serialises multi-step register sequences */
+	struct mutex			multiop_lock;
+
+	/* Hardware state */
+	struct sit9531x_ref	ref[SIT9531X_MAX_INPUTS + 1]; /* +1 for xtal */
+	struct sit9531x_out	out[SIT9531X_MAX_OUTPUTS];
+	struct sit9531x_chan	chan[SIT9531X_NUM_PLLS];
+	u32			xtal_freq;
+
+	/* DPLL channels */
+	struct list_head	dplls;
+
+	/* Monitor */
+	struct kthread_worker		*kworker;
+	struct kthread_delayed_work	work;
+
+	/* Device identity */
+	u64			clock_id;
+
+	/* Optional DT-described GPIO / IRQ lines */
+	struct gpio_desc	*reset_gpio;
+	int			irq;
+};
+
+extern const struct regmap_config sit9531x_regmap_config;
+
+/* ---- Core lifecycle ---- */
+int  sit9531x_dev_probe(struct sit9531x_dev *sitdev);
+int  sit9531x_dev_start(struct sit9531x_dev *sitdev);
+void sit9531x_dev_stop(struct sit9531x_dev *sitdev);
+
+/* ---- Register access ---- */
+int sit9531x_read_u8(struct sit9531x_dev *sitdev, unsigned int reg,
+		     u8 *val);
+int sit9531x_write_u8(struct sit9531x_dev *sitdev, unsigned int reg,
+		      u8 val);
+int sit9531x_read_pll_u8(struct sit9531x_dev *sitdev, u8 pll_idx,
+			 u8 offset, u8 *val);
+int sit9531x_write_pll_u8(struct sit9531x_dev *sitdev, u8 pll_idx,
+			  u8 offset, u8 val);
+int sit9531x_update_pll_u8(struct sit9531x_dev *sitdev, u8 pll_idx,
+			   u8 offset, u8 mask, u8 val);
+
+/* ---- Input enable/disable ---- */
+int sit9531x_input_disable(struct sit9531x_dev *sitdev, u8 index);
+int sit9531x_input_enable(struct sit9531x_dev *sitdev, u8 index);
+
+/* ---- Input priority ---- */
+int sit9531x_input_prio_set(struct sit9531x_dev *sitdev, u8 pll_idx,
+			    u8 input_idx, u8 prio);
+
+/* ---- Output enable/disable (Hi-Z control) ---- */
+int sit9531x_output_disable(struct sit9531x_dev *sitdev, u8 index);
+int sit9531x_output_enable(struct sit9531x_dev *sitdev, u8 index);
+
+/* ---- DCO tuning ---- */
+int sit9531x_dco_adjust(struct sit9531x_dev *sitdev, u8 pll_idx, s64 ppb);
+
+/* ---- Output frequency ---- */
+int sit9531x_output_freq_set(struct sit9531x_dev *sitdev, u8 out_idx,
+			     u8 pll_idx, u64 frequency);
+
+/* ---- Output phase adjust (PRG_RST_DELAY register-based) ---- */
+int sit9531x_output_phase_adjust_set(struct sit9531x_dev *sitdev,
+				     u8 out_idx, s32 phase_ps);
+
+/* ---- PLL lock-detection thresholds (LL_REG2_PLL, reg 0x2A) ---- */
+int sit9531x_pll_lock_threshold_set(struct sit9531x_dev *sitdev,
+				    u8 pll_idx, u8 set_val, u8 clr_val);
+
+/* ---- Notification clear ---- */
+int sit9531x_clear_notifications(struct sit9531x_dev *sitdev);
+
+/* ---- INTSYNC (inter-PLL synchronization) ---- */
+int sit9531x_intsync_enable(struct sit9531x_dev *sitdev, u8 src_pll_idx);
+int sit9531x_intsync_disable(struct sit9531x_dev *sitdev, u8 src_pll_idx);
+
+/* ---- Per-PLL SYSREF / SYNCB / Pulser output mode ---- */
+enum sit9531x_sysref_mode {
+	SIT9531X_SYSREF_DISABLE,
+	SIT9531X_SYSREF_MODE_SYSREF,
+	SIT9531X_SYSREF_MODE_SYNCB,
+	SIT9531X_SYSREF_MODE_PULSER,
+};
+
+int sit9531x_pll_sysref_mode_set(struct sit9531x_dev *sitdev, u8 pll_idx,
+				 enum sit9531x_sysref_mode mode,
+				 u16 target_outputs);
+int sit9531x_output_pulse_ctrl_set(struct sit9531x_dev *sitdev,
+				   u8 out_idx, u8 pulse_ctrl);
+
+/* ---- Phase offset (TDC readback) ---- */
+int sit9531x_phase_offset_read(struct sit9531x_dev *sitdev, u8 pll_idx,
+			       s64 *phase_ps);
+
+/* ---- State helpers ---- */
+
+/**
+ * sit9531x_pll_page - get register page for PLL index
+ * @pll_idx: PLL index (0 = PLLA, 3 = PLLD)
+ */
+static inline u8 sit9531x_pll_page(u8 pll_idx)
+{
+	return SIT9531X_PAGE_PLLA + pll_idx;
+}
+
+/**
+ * sit9531x_ref_state_get - get reference state by index
+ */
+static inline const struct sit9531x_ref *
+sit9531x_ref_state_get(const struct sit9531x_dev *sitdev, u8 index)
+{
+	return &sitdev->ref[index];
+}
+
+/**
+ * sit9531x_out_state_get - get output state by index
+ */
+static inline const struct sit9531x_out *
+sit9531x_out_state_get(const struct sit9531x_dev *sitdev, u8 index)
+{
+	return &sitdev->out[index];
+}
+
+/**
+ * sit9531x_chan_state_get - get channel state by PLL index
+ */
+static inline const struct sit9531x_chan *
+sit9531x_chan_state_get(const struct sit9531x_dev *sitdev, u8 pll_idx)
+{
+	return &sitdev->chan[pll_idx];
+}
+
+#endif /* _SIT9531X_CORE_H */
diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c
new file mode 100644
index 000000000000..c766c7c2dd36
--- /dev/null
+++ b/drivers/dpll/sit9531x/dpll.c
@@ -0,0 +1,1147 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SiTime SiT9531x DPLL subsystem callbacks and registration
+ *
+ * Copyright (C) 2026 SiTime Corp.
+ * Author: Ali Rouhi <arouhi@sitime.com>
+ * Author: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>
+ *
+ * DPLL device ops, pin ops (separate input/output), pin registration,
+ * and periodic change detection.
+ *
+ */
+
+#include <linux/dpll.h>
+#include <linux/err.h>
+#include <linux/kthread.h>
+#include <linux/list.h>
+#include <linux/netlink.h>
+#include <linux/slab.h>
+
+#include "core.h"
+#include "dpll.h"
+#include "prop.h"
+#include "regs.h"
+
+/* Number of input + output pin positions for pin index allocation */
+#define SIT9531X_NUM_INPUT_PINS		(SIT9531X_MAX_INPUTS + 1) /* +xtal */
+#define SIT9531X_NUM_OUTPUT_PINS	SIT9531X_MAX_OUTPUTS
+#define SIT9531X_NUM_PINS_TOTAL		(SIT9531X_NUM_INPUT_PINS + SIT9531X_NUM_OUTPUT_PINS)
+
+#define SIT9531X_ESYNC_FREQ_10MHZ	10000000ULL
+#define SIT9531X_ESYNC_PULSE_DEFAULT	50
+
+static const struct dpll_pin_frequency sit9531x_esync_ranges[] = {
+	DPLL_PIN_FREQUENCY(0),
+	DPLL_PIN_FREQUENCY(SIT9531X_ESYNC_FREQ_10MHZ),
+};
+
+static inline bool
+sit9531x_dpll_esync_pin_supported(const struct sit9531x_dpll_pin *dpin)
+{
+	return dpin->esync_control;
+}
+
+/* ====================================================================
+ * Pin direction helpers
+ * ====================================================================
+ */
+
+static inline bool sit9531x_dpll_is_input_pin(const struct sit9531x_dpll_pin *pin)
+{
+	return pin->dir == DPLL_PIN_DIRECTION_INPUT;
+}
+
+/* ====================================================================
+ * dpll_device_ops callbacks
+ * ====================================================================
+ */
+
+/*
+ * sit9531x_dpll_lock_status_get - report PLL lock/holdover state
+ *
+ * reads holdover register (Page 0 reg 0x06), PLL
+ * status register (PLL page reg 0x31), inner LOL (reg 0x92), and
+ * holdover freeze (reg 0x0A) to determine lock status and error.
+ */
+static int
+sit9531x_dpll_lock_status_get(const struct dpll_device *dpll, void *dpll_priv,
+			      enum dpll_lock_status *status,
+			      enum dpll_lock_status_error *status_error,
+			      struct netlink_ext_ack *extack)
+{
+	struct sit9531x_dpll *sitdpll = dpll_priv;
+	const struct sit9531x_chan *chan;
+
+	if (status_error)
+		*status_error = DPLL_LOCK_STATUS_ERROR_NONE;
+
+	chan = sit9531x_chan_state_get(sitdpll->dev, sitdpll->id);
+
+	if (chan->locked) {
+		if (chan->mode)
+			*status = DPLL_LOCK_STATUS_LOCKED;       /* free-run */
+		else
+			*status = DPLL_LOCK_STATUS_LOCKED_HO_ACQ; /* sync */
+	} else if (chan->ho_freeze) {
+		*status = DPLL_LOCK_STATUS_HOLDOVER;
+	} else {
+		*status = DPLL_LOCK_STATUS_UNLOCKED;
+	}
+
+	/* Report inner LOL as an error condition */
+	if (status_error && chan->inner_lol)
+		*status_error = DPLL_LOCK_STATUS_ERROR_UNDEFINED;
+
+	return 0;
+}
+
+/*
+ * sit9531x_dpll_mode_get - report current PLL operating mode
+ *
+ * reads outer loop disable bit (PLL page reg 0x31[5]).
+ * Free-run -> MANUAL, sync -> AUTOMATIC.
+ */
+static int
+sit9531x_dpll_mode_get(const struct dpll_device *dpll, void *dpll_priv,
+		       enum dpll_mode *mode, struct netlink_ext_ack *extack)
+{
+	struct sit9531x_dpll *sitdpll = dpll_priv;
+	const struct sit9531x_chan *chan;
+
+	chan = sit9531x_chan_state_get(sitdpll->dev, sitdpll->id);
+
+	*mode = chan->mode ? DPLL_MODE_MANUAL : DPLL_MODE_AUTOMATIC;
+
+	return 0;
+}
+
+/*
+ * sit9531x_dpll_mode_set - switch PLL between free-run and sync mode
+ *
+ * writes PLL page reg 0x31[5] to enable/disable the
+ * outer loop, then triggers a small update via reg 0x0F.
+ */
+static int
+sit9531x_dpll_mode_set(const struct dpll_device *dpll, void *dpll_priv,
+		       enum dpll_mode mode, struct netlink_ext_ack *extack)
+{
+	struct sit9531x_dpll *sitdpll = dpll_priv;
+	struct sit9531x_dev *sitdev = sitdpll->dev;
+	u8 val;
+	int rc;
+
+	/*
+	 * Outer loop disable bit:
+	 *   0 = sync mode (outer loop enabled)  -> AUTOMATIC
+	 *   1 = free-run (outer loop disabled)  -> MANUAL
+	 */
+	val = (mode == DPLL_MODE_MANUAL) ? SIT9531X_PLL_STATUS_OUTER_DIS : 0;
+
+	mutex_lock(&sitdev->multiop_lock);
+
+	rc = sit9531x_update_pll_u8(sitdev, sitdpll->id,
+				    SIT9531X_PLL_REG_STATUS,
+				    SIT9531X_PLL_STATUS_OUTER_DIS, val);
+	if (rc) {
+		NL_SET_ERR_MSG(extack, "Failed to write PLL mode register");
+		goto unlock;
+	}
+
+	/* Trigger small update to apply without full NVM cycle */
+	rc = sit9531x_write_pll_u8(sitdev, sitdpll->id,
+				   SIT9531X_PLL_REG_SMALL_UPDATE,
+				   SIT9531X_PLL_SMALL_UPDATE_CMD);
+	if (rc)
+		NL_SET_ERR_MSG(extack, "Failed to trigger small update");
+
+unlock:
+	mutex_unlock(&sitdev->multiop_lock);
+
+	return rc;
+}
+
+/*
+ * sit9531x_dpll_supported_modes_get - report which modes the PLL supports
+ */
+static int
+sit9531x_dpll_supported_modes_get(const struct dpll_device *dpll,
+				  void *dpll_priv, unsigned long *modes,
+				  struct netlink_ext_ack *extack)
+{
+	__set_bit(DPLL_MODE_AUTOMATIC, modes);
+	__set_bit(DPLL_MODE_MANUAL, modes);
+
+	return 0;
+}
+
+static const struct dpll_device_ops sit9531x_dpll_device_ops = {
+	.lock_status_get	= sit9531x_dpll_lock_status_get,
+	.mode_get		= sit9531x_dpll_mode_get,
+	.mode_set		= sit9531x_dpll_mode_set,
+	.supported_modes_get	= sit9531x_dpll_supported_modes_get,
+	/* temp_get not available -- SiT9531x has no on-die temp sensor */
+};
+
+/* ====================================================================
+ * Input pin ops
+ * ====================================================================
+ */
+
+static int
+sit9531x_dpll_input_pin_direction_get(const struct dpll_pin *pin,
+				      void *pin_priv,
+				      const struct dpll_device *dpll,
+				      void *dpll_priv,
+				      enum dpll_pin_direction *direction,
+				      struct netlink_ext_ack *extack)
+{
+	*direction = DPLL_PIN_DIRECTION_INPUT;
+	return 0;
+}
+
+/*
+ * sit9531x_dpll_input_pin_frequency_get - read input pin frequency
+ *
+ * returns cached frequency from DT or last set.
+ */
+static int
+sit9531x_dpll_input_pin_frequency_get(const struct dpll_pin *pin,
+				      void *pin_priv,
+				      const struct dpll_device *dpll,
+				      void *dpll_priv, u64 *frequency,
+				      struct netlink_ext_ack *extack)
+{
+	struct sit9531x_dpll_pin *dpin = pin_priv;
+	struct sit9531x_dpll *sitdpll = dpll_priv;
+	const struct sit9531x_ref *ref;
+
+	ref = sit9531x_ref_state_get(sitdpll->dev, dpin->id);
+	*frequency = ref->freq;
+
+	return 0;
+}
+
+/*
+ * sit9531x_dpll_input_pin_state_on_dpll_get - get input pin DPLL state
+ *
+ * determines pin state from channel state: connected
+ * if this input is the selected reference on a locked PLL, selectable
+ * if enabled in automatic mode, disconnected otherwise.
+ */
+static int
+sit9531x_dpll_input_pin_state_on_dpll_get(const struct dpll_pin *pin,
+					  void *pin_priv,
+					  const struct dpll_device *dpll,
+					  void *dpll_priv,
+					  enum dpll_pin_state *state,
+					  struct netlink_ext_ack *extack)
+{
+	struct sit9531x_dpll_pin *dpin = pin_priv;
+	struct sit9531x_dpll *sitdpll = dpll_priv;
+	const struct sit9531x_chan *chan;
+	const struct sit9531x_ref *ref;
+
+	chan = sit9531x_chan_state_get(sitdpll->dev, sitdpll->id);
+	ref = sit9531x_ref_state_get(sitdpll->dev, dpin->id);
+
+	/* Check if this input is the connected reference */
+	if (chan->locked && chan->selected_ref == dpin->id) {
+		*state = DPLL_PIN_STATE_CONNECTED;
+		return 0;
+	}
+
+	/* In auto mode, enabled inputs with good signal are selectable */
+	if (!chan->mode && ref->enabled && !ref->los && !ref->oof) {
+		*state = DPLL_PIN_STATE_SELECTABLE;
+		return 0;
+	}
+
+	*state = DPLL_PIN_STATE_DISCONNECTED;
+	return 0;
+}
+
+/*
+ * sit9531x_dpll_input_pin_state_on_dpll_set - set input pin DPLL state
+ *
+ * disables or enables the input by writing Page 0x02
+ * force/state registers via sit9531x_input_disable/enable().
+ *   DISCONNECTED -> disable input (force override, clear state)
+ *   SELECTABLE   -> enable input (release force override)
+ *   CONNECTED    -> enable input (same as SELECTABLE; actual selection
+ *                  is done by the PLL auto-switching logic)
+ */
+static int
+sit9531x_dpll_input_pin_state_on_dpll_set(const struct dpll_pin *pin,
+					  void *pin_priv,
+					  const struct dpll_device *dpll,
+					  void *dpll_priv,
+					  enum dpll_pin_state state,
+					  struct netlink_ext_ack *extack)
+{
+	struct sit9531x_dpll_pin *dpin = pin_priv;
+	struct sit9531x_dpll *sitdpll = dpll_priv;
+	struct sit9531x_dev *sitdev = sitdpll->dev;
+	int rc;
+
+	mutex_lock(&sitdev->multiop_lock);
+
+	switch (state) {
+	case DPLL_PIN_STATE_DISCONNECTED:
+		rc = sit9531x_input_disable(sitdev, dpin->id);
+		break;
+	case DPLL_PIN_STATE_SELECTABLE:
+	case DPLL_PIN_STATE_CONNECTED:
+		rc = sit9531x_input_enable(sitdev, dpin->id);
+		break;
+	default:
+		rc = -EINVAL;
+		break;
+	}
+
+	mutex_unlock(&sitdev->multiop_lock);
+
+	if (rc)
+		NL_SET_ERR_MSG(extack, "Failed to set input pin state");
+
+	return rc;
+}
+
+/*
+ * sit9531x_dpll_input_pin_prio_get - read input pin priority
+ *
+ * returns cached priority (populated from clock monitor
+ * registers during pin registration).
+ */
+static int
+sit9531x_dpll_input_pin_prio_get(const struct dpll_pin *pin, void *pin_priv,
+				 const struct dpll_device *dpll, void *dpll_priv,
+				 u32 *prio, struct netlink_ext_ack *extack)
+{
+	struct sit9531x_dpll_pin *dpin = pin_priv;
+
+	*prio = dpin->prio;
+	return 0;
+}
+
+/*
+ * sit9531x_dpll_input_pin_prio_set - set input pin priority
+ *
+ * writes input priority table on Page 1 via
+ * core.c sit9531x_input_prio_set().  Forces holdover during update.
+ */
+static int
+sit9531x_dpll_input_pin_prio_set(const struct dpll_pin *pin, void *pin_priv,
+				 const struct dpll_device *dpll, void *dpll_priv,
+				 u32 prio, struct netlink_ext_ack *extack)
+{
+	struct sit9531x_dpll_pin *dpin = pin_priv;
+	struct sit9531x_dpll *sitdpll = dpll_priv;
+	struct sit9531x_dev *sitdev = sitdpll->dev;
+	int rc;
+
+	if (dpin->dir != DPLL_PIN_DIRECTION_INPUT) {
+		NL_SET_ERR_MSG(extack, "Priority applies only to input pins");
+		return -EINVAL;
+	}
+
+	if (prio >= SIT9531X_PRIO_MAX_SLOTS) {
+		NL_SET_ERR_MSG(extack, "Priority out of range (0-11)");
+		return -EINVAL;
+	}
+
+	mutex_lock(&sitdev->multiop_lock);
+	rc = sit9531x_input_prio_set(sitdev, sitdpll->id, dpin->id,
+				     (u8)prio);
+	mutex_unlock(&sitdev->multiop_lock);
+
+	if (rc) {
+		NL_SET_ERR_MSG(extack, "Failed to set input priority");
+		return rc;
+	}
+
+	dpin->prio = (u8)prio;
+
+	return 0;
+}
+
+/*
+ * sit9531x_dpll_input_pin_phase_adjust_get - read phase adjustment
+ *
+ * returns cached phase adjustment value (in ps).
+ */
+static int
+sit9531x_dpll_input_pin_phase_adjust_get(const struct dpll_pin *pin,
+					 void *pin_priv,
+					 const struct dpll_device *dpll,
+					 void *dpll_priv, s32 *phase_adjust,
+					 struct netlink_ext_ack *extack)
+{
+	struct sit9531x_dpll_pin *dpin = pin_priv;
+
+	*phase_adjust = dpin->phase_adjust;
+	return 0;
+}
+
+/*
+ * sit9531x_dpll_input_pin_phase_offset_get - read phase offset
+ *
+ * reads the TDC (Time-to-Digital Converter) hardware
+ * to measure the phase difference in picoseconds via
+ * sit9531x_phase_offset_read().
+ */
+static int
+sit9531x_dpll_input_pin_phase_offset_get(const struct dpll_pin *pin,
+					 void *pin_priv,
+					 const struct dpll_device *dpll,
+					 void *dpll_priv, s64 *phase_offset,
+					 struct netlink_ext_ack *extack)
+{
+	struct sit9531x_dpll_pin *dpin = pin_priv;
+	struct sit9531x_dpll *sitdpll = dpll_priv;
+	struct sit9531x_dev *sitdev = sitdpll->dev;
+	s64 offset;
+	int rc;
+
+	mutex_lock(&sitdev->multiop_lock);
+	rc = sit9531x_phase_offset_read(sitdev, sitdpll->id, &offset);
+	mutex_unlock(&sitdev->multiop_lock);
+
+	/*
+	 * -ENODEV means the PLL has no programmed DIVN (unused on this
+	 * board); report phase_offset = 0 so a full pin-get dump does not
+	 * fail just because one DPLL is dormant.
+	 */
+	if (rc == -ENODEV) {
+		dpin->phase_offset = 0;
+		*phase_offset = 0;
+		return 0;
+	}
+	if (rc) {
+		NL_SET_ERR_MSG(extack, "TDC phase readback failed");
+		return rc;
+	}
+
+	dpin->phase_offset = offset;
+	*phase_offset = offset;
+	return 0;
+}
+
+static const struct dpll_pin_ops sit9531x_dpll_input_pin_ops = {
+	.direction_get		= sit9531x_dpll_input_pin_direction_get,
+	.frequency_get		= sit9531x_dpll_input_pin_frequency_get,
+	.state_on_dpll_get	= sit9531x_dpll_input_pin_state_on_dpll_get,
+	.state_on_dpll_set	= sit9531x_dpll_input_pin_state_on_dpll_set,
+	.prio_get		= sit9531x_dpll_input_pin_prio_get,
+	.prio_set		= sit9531x_dpll_input_pin_prio_set,
+	.phase_adjust_get	= sit9531x_dpll_input_pin_phase_adjust_get,
+	.phase_offset_get	= sit9531x_dpll_input_pin_phase_offset_get,
+};
+
+/* ====================================================================
+ * Output pin ops
+ * ====================================================================
+ */
+
+static int
+sit9531x_dpll_output_pin_direction_get(const struct dpll_pin *pin,
+				       void *pin_priv,
+				       const struct dpll_device *dpll,
+				       void *dpll_priv,
+				       enum dpll_pin_direction *direction,
+				       struct netlink_ext_ack *extack)
+{
+	*direction = DPLL_PIN_DIRECTION_OUTPUT;
+	return 0;
+}
+
+/*
+ * sit9531x_dpll_output_pin_frequency_get - read output pin frequency
+ *
+ * returns cached frequency from state fetch.
+ * TODO: compute from VCO / divider chain for live readback.
+ */
+static int
+sit9531x_dpll_output_pin_frequency_get(const struct dpll_pin *pin,
+				       void *pin_priv,
+				       const struct dpll_device *dpll,
+				       void *dpll_priv, u64 *frequency,
+				       struct netlink_ext_ack *extack)
+{
+	struct sit9531x_dpll_pin *dpin = pin_priv;
+	struct sit9531x_dpll *sitdpll = dpll_priv;
+	const struct sit9531x_out *out;
+
+	out = sit9531x_out_state_get(sitdpll->dev, dpin->id);
+	*frequency = out->freq;
+
+	return 0;
+}
+
+/*
+ * sit9531x_dpll_output_pin_frequency_set - set output pin frequency
+ *
+ * computes DIVO = Fvco / frequency and writes the
+ * 34-bit output divider to the output system registers via
+ * sit9531x_output_freq_set().
+ */
+static int
+sit9531x_dpll_output_pin_frequency_set(const struct dpll_pin *pin,
+				       void *pin_priv,
+				       const struct dpll_device *dpll,
+				       void *dpll_priv, u64 frequency,
+				       struct netlink_ext_ack *extack)
+{
+	struct sit9531x_dpll_pin *dpin = pin_priv;
+	struct sit9531x_dpll *sitdpll = dpll_priv;
+	struct sit9531x_dev *sitdev = sitdpll->dev;
+	u8 actual_pll;
+	int rc;
+
+	/* Use the actual PLL that drives this output (populated by
+	 * out_state_fetch from the chip's OUT_MAP registers), not the
+	 * DPLL device id -- in our current registration all outputs are
+	 * bound to DPLL 0 for convenience, but physically they may be
+	 * driven by PLL A/B/C/D with different Fvco.
+	 */
+	actual_pll = sitdev->out[dpin->id].pll_idx;
+
+	mutex_lock(&sitdev->multiop_lock);
+	rc = sit9531x_output_freq_set(sitdev, dpin->id, actual_pll,
+				      frequency);
+	mutex_unlock(&sitdev->multiop_lock);
+
+	if (rc)
+		NL_SET_ERR_MSG(extack, "Output frequency set failed");
+
+	return rc;
+}
+
+/*
+ * sit9531x_dpll_output_pin_state_on_dpll_get - get output pin state
+ *
+ * reports CONNECTED when the output is driven and
+ * DISCONNECTED when it has been muted via sit9531x_output_disable().
+ */
+static int
+sit9531x_dpll_output_pin_state_on_dpll_get(const struct dpll_pin *pin,
+					   void *pin_priv,
+					   const struct dpll_device *dpll,
+					   void *dpll_priv,
+					   enum dpll_pin_state *state,
+					   struct netlink_ext_ack *extack)
+{
+	struct sit9531x_dpll_pin *dpin = pin_priv;
+	struct sit9531x_dpll *sitdpll = dpll_priv;
+	const struct sit9531x_out *out;
+
+	out = sit9531x_out_state_get(sitdpll->dev, dpin->id);
+	*state = out->enabled ? DPLL_PIN_STATE_CONNECTED
+			      : DPLL_PIN_STATE_DISCONNECTED;
+	return 0;
+}
+
+/*
+ * sit9531x_dpll_output_pin_state_on_dpll_set - mute/un-mute an output
+ *
+ * forces Hi-Z on the output pin via the Page 0x03
+ * force/state register pair.
+ *   CONNECTED    -> enable (release force, back to factory default)
+ *   DISCONNECTED -> disable (force Hi-Z)
+ */
+static int
+sit9531x_dpll_output_pin_state_on_dpll_set(const struct dpll_pin *pin,
+					   void *pin_priv,
+					   const struct dpll_device *dpll,
+					   void *dpll_priv,
+					   enum dpll_pin_state state,
+					   struct netlink_ext_ack *extack)
+{
+	struct sit9531x_dpll_pin *dpin = pin_priv;
+	struct sit9531x_dpll *sitdpll = dpll_priv;
+	struct sit9531x_dev *sitdev = sitdpll->dev;
+	int rc;
+
+	mutex_lock(&sitdev->multiop_lock);
+
+	switch (state) {
+	case DPLL_PIN_STATE_CONNECTED:
+		rc = sit9531x_output_enable(sitdev, dpin->id);
+		break;
+	case DPLL_PIN_STATE_DISCONNECTED:
+		rc = sit9531x_output_disable(sitdev, dpin->id);
+		break;
+	default:
+		rc = -EINVAL;
+		break;
+	}
+
+	mutex_unlock(&sitdev->multiop_lock);
+
+	if (rc)
+		NL_SET_ERR_MSG(extack, "Failed to set output pin state");
+
+	return rc;
+}
+
+/*
+ * sit9531x_dpll_output_pin_phase_adjust_get - read output phase adjustment
+ *
+ * returns cached value.
+ */
+static int
+sit9531x_dpll_output_pin_phase_adjust_get(const struct dpll_pin *pin,
+					  void *pin_priv,
+					  const struct dpll_device *dpll,
+					  void *dpll_priv, s32 *phase_adjust,
+					  struct netlink_ext_ack *extack)
+{
+	struct sit9531x_dpll_pin *dpin = pin_priv;
+
+	*phase_adjust = dpin->phase_adjust;
+	return 0;
+}
+
+/*
+ * sit9531x_dpll_output_pin_phase_adjust_set - set output phase adjustment
+ *
+ * Programs the per-output PRG_RST_DELAY registers for deterministic
+ * phase offset; see sit9531x_output_phase_adjust_set() in core.c.
+ */
+static int
+sit9531x_dpll_output_pin_phase_adjust_set(const struct dpll_pin *pin,
+					  void *pin_priv,
+					  const struct dpll_device *dpll,
+					  void *dpll_priv, s32 phase_adjust,
+					  struct netlink_ext_ack *extack)
+{
+	struct sit9531x_dpll_pin *dpin = pin_priv;
+	struct sit9531x_dpll *sitdpll = dpll_priv;
+	struct sit9531x_dev *sitdev = sitdpll->dev;
+	int rc;
+
+	mutex_lock(&sitdev->multiop_lock);
+	rc = sit9531x_output_phase_adjust_set(sitdev, dpin->id, phase_adjust);
+	mutex_unlock(&sitdev->multiop_lock);
+
+	if (rc) {
+		NL_SET_ERR_MSG(extack, "Phase adjust failed");
+		return rc;
+	}
+
+	dpin->phase_adjust = phase_adjust;
+	return 0;
+}
+
+static int
+sit9531x_dpll_output_pin_esync_get(const struct dpll_pin *pin,
+				   void *pin_priv,
+				   const struct dpll_device *dpll,
+				   void *dpll_priv,
+				   struct dpll_pin_esync *esync,
+				   struct netlink_ext_ack *extack)
+{
+	struct sit9531x_dpll_pin *dpin = pin_priv;
+
+	if (!sit9531x_dpll_esync_pin_supported(dpin))
+		return -EOPNOTSUPP;
+
+	esync->range = sit9531x_esync_ranges;
+	esync->range_num = ARRAY_SIZE(sit9531x_esync_ranges);
+	esync->pulse = SIT9531X_ESYNC_PULSE_DEFAULT;
+	esync->freq = dpin->esync_freq;
+
+	return 0;
+}
+
+static int
+sit9531x_dpll_output_pin_esync_set(const struct dpll_pin *pin,
+				   void *pin_priv,
+				   const struct dpll_device *dpll,
+				   void *dpll_priv,
+				   u64 freq,
+				   struct netlink_ext_ack *extack)
+{
+	struct sit9531x_dpll_pin *dpin = pin_priv;
+	struct sit9531x_dpll *sitdpll = dpll_priv;
+	struct sit9531x_dev *sitdev = sitdpll->dev;
+	u8 actual_pll;
+	int rc;
+
+	if (!sit9531x_dpll_esync_pin_supported(dpin)) {
+		NL_SET_ERR_MSG(extack,
+			       "Embedded sync not enabled for this pin");
+		return -EOPNOTSUPP;
+	}
+
+	actual_pll = sitdev->out[dpin->id].pll_idx;
+
+	mutex_lock(&sitdev->multiop_lock);
+
+	/*
+	 * This output is a dedicated embedded-sync pin.
+	 * Treat freq=0 as a request to disable the entire output.
+	 */
+	if (!freq) {
+		rc = sit9531x_output_disable(sitdev, dpin->id);
+		if (!rc)
+			dpin->esync_freq = 0;
+		mutex_unlock(&sitdev->multiop_lock);
+		return rc;
+	}
+
+	if (freq != SIT9531X_ESYNC_FREQ_10MHZ) {
+		mutex_unlock(&sitdev->multiop_lock);
+		NL_SET_ERR_MSG(extack,
+			       "Only 10 MHz esync frequency is supported");
+		return -EINVAL;
+	}
+
+	rc = sit9531x_output_freq_set(sitdev, dpin->id, actual_pll,
+				      SIT9531X_ESYNC_FREQ_10MHZ);
+	if (!rc)
+		rc = sit9531x_output_enable(sitdev, dpin->id);
+
+	mutex_unlock(&sitdev->multiop_lock);
+
+	if (!rc)
+		dpin->esync_freq = SIT9531X_ESYNC_FREQ_10MHZ;
+
+	return rc;
+}
+
+static const struct dpll_pin_ops sit9531x_dpll_output_pin_ops = {
+	.direction_get		= sit9531x_dpll_output_pin_direction_get,
+	.frequency_get		= sit9531x_dpll_output_pin_frequency_get,
+	.frequency_set		= sit9531x_dpll_output_pin_frequency_set,
+	.state_on_dpll_get	= sit9531x_dpll_output_pin_state_on_dpll_get,
+	.state_on_dpll_set	= sit9531x_dpll_output_pin_state_on_dpll_set,
+	.phase_adjust_get	= sit9531x_dpll_output_pin_phase_adjust_get,
+	.phase_adjust_set	= sit9531x_dpll_output_pin_phase_adjust_set,
+	.esync_get		= sit9531x_dpll_output_pin_esync_get,
+	.esync_set		= sit9531x_dpll_output_pin_esync_set,
+};
+
+/* ====================================================================
+ * Pin allocation, registration, and cleanup
+ * ====================================================================
+ */
+
+/*
+ * sit9531x_dpll_pin_alloc - allocate a DPLL pin
+ * @sitdpll:	DPLL device this pin belongs to
+ * @dir:	pin direction
+ * @id:		hardware pin index
+ *
+ * Return: pointer to allocated pin on success, error pointer on error
+ */
+static struct sit9531x_dpll_pin *
+sit9531x_dpll_pin_alloc(struct sit9531x_dpll *sitdpll,
+			enum dpll_pin_direction dir, u8 id)
+{
+	struct sit9531x_dpll_pin *pin;
+
+	pin = kzalloc_obj(*pin, GFP_KERNEL);
+	if (!pin)
+		return ERR_PTR(-ENOMEM);
+
+	pin->dpll = sitdpll;
+	pin->dir = dir;
+	pin->id = id;
+
+	return pin;
+}
+
+/*
+ * sit9531x_dpll_pin_free - deallocate a DPLL pin
+ * @pin:	pin to free
+ */
+static void sit9531x_dpll_pin_free(struct sit9531x_dpll_pin *pin)
+{
+	WARN(pin->dpll_pin, "DPLL pin is still registered\n");
+	kfree(pin);
+}
+
+/*
+ * sit9531x_dpll_pin_register - register a DPLL pin with the subsystem
+ * @pin:	pin to register
+ * @index:	absolute pin index for clock_id namespace
+ *
+ * Gets pin properties from firmware, creates or gets a dpll_pin,
+ * and registers it with the parent DPLL device.
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int sit9531x_dpll_pin_register(struct sit9531x_dpll_pin *pin,
+				      u32 index)
+{
+	struct sit9531x_dpll *sitdpll = pin->dpll;
+	struct sit9531x_pin_props *props;
+	const struct dpll_pin_ops *ops;
+	int rc;
+
+	/* Get pin properties from firmware nodes */
+	props = sit9531x_pin_props_get(sitdpll->dev, pin->dir, pin->id);
+	if (IS_ERR(props))
+		return PTR_ERR(props);
+
+	/* Save package label and firmware node */
+	strscpy(pin->label, props->package_label, sizeof(pin->label));
+	pin->fwnode = fwnode_handle_get(props->fwnode);
+	pin->esync_control = props->esync_control;
+
+	/* Create or get existing DPLL pin */
+	pin->dpll_pin = dpll_pin_get(sitdpll->dev->clock_id, index,
+				     THIS_MODULE, &props->dpll_props,
+				     &pin->tracker);
+	if (IS_ERR(pin->dpll_pin)) {
+		rc = PTR_ERR(pin->dpll_pin);
+		goto err_pin_get;
+	}
+	dpll_pin_fwnode_set(pin->dpll_pin, props->fwnode);
+
+	if (sit9531x_dpll_is_input_pin(pin))
+		ops = &sit9531x_dpll_input_pin_ops;
+	else
+		ops = &sit9531x_dpll_output_pin_ops;
+
+	/* Register the pin */
+	rc = dpll_pin_register(sitdpll->dpll_dev, pin->dpll_pin, ops, pin);
+	if (rc)
+		goto err_register;
+
+	/* Free pin properties */
+	sit9531x_pin_props_put(props);
+
+	return 0;
+
+err_register:
+	dpll_pin_put(pin->dpll_pin, &pin->tracker);
+	pin->dpll_pin = NULL;
+err_pin_get:
+	fwnode_handle_put(pin->fwnode);
+	pin->fwnode = NULL;
+	sit9531x_pin_props_put(props);
+
+	return rc;
+}
+
+/*
+ * sit9531x_dpll_pin_unregister - unregister a DPLL pin
+ * @pin:	pin to unregister
+ */
+static void sit9531x_dpll_pin_unregister(struct sit9531x_dpll_pin *pin)
+{
+	struct sit9531x_dpll *sitdpll = pin->dpll;
+	const struct dpll_pin_ops *ops;
+
+	WARN(!pin->dpll_pin, "DPLL pin is not registered\n");
+
+	if (sit9531x_dpll_is_input_pin(pin))
+		ops = &sit9531x_dpll_input_pin_ops;
+	else
+		ops = &sit9531x_dpll_output_pin_ops;
+
+	dpll_pin_unregister(sitdpll->dpll_dev, pin->dpll_pin, ops, pin);
+	dpll_pin_put(pin->dpll_pin, &pin->tracker);
+	pin->dpll_pin = NULL;
+
+	fwnode_handle_put(pin->fwnode);
+	pin->fwnode = NULL;
+}
+
+/*
+ * sit9531x_dpll_pins_unregister - unregister all pins on a DPLL
+ * @sitdpll:	DPLL device
+ */
+static void sit9531x_dpll_pins_unregister(struct sit9531x_dpll *sitdpll)
+{
+	struct sit9531x_dpll_pin *pin, *next;
+
+	list_for_each_entry_safe(pin, next, &sitdpll->pins, list) {
+		sit9531x_dpll_pin_unregister(pin);
+		list_del(&pin->list);
+		sit9531x_dpll_pin_free(pin);
+	}
+}
+
+/*
+ * sit9531x_dpll_pin_is_registrable - check if a pin should be registered
+ * @sitdpll:	DPLL device
+ * @dir:	pin direction
+ * @index:	pin hardware index
+ *
+ * For input pins: the pin is registrable if it is enabled.
+ * For output pins: the pin is registrable if it is driven by this DPLL.
+ *
+ * Return: true if pin should be registered, false otherwise
+ */
+static bool sit9531x_dpll_pin_is_registrable(struct sit9531x_dpll *sitdpll,
+					     enum dpll_pin_direction dir,
+					     u8 index)
+{
+	struct sit9531x_dev *sitdev = sitdpll->dev;
+
+	if (dir == DPLL_PIN_DIRECTION_INPUT) {
+		/* All configured inputs are registrable */
+		return index < sitdev->info->num_inputs;
+	}
+
+	/* Output -- check if driven by this DPLL */
+	if (index >= sitdev->info->num_outputs)
+		return false;
+
+	return sitdev->out[index].pll_idx == sitdpll->id &&
+	       sitdev->out[index].enabled;
+}
+
+/*
+ * sit9531x_dpll_pins_register - register all registrable pins
+ * @sitdpll:	DPLL device
+ *
+ * Enumerates all possible input and output pins, checks registrability,
+ * and registers each one.  Input pins come first, then output pins,
+ * with input pins first, then output pins.
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int sit9531x_dpll_pins_register(struct sit9531x_dpll *sitdpll)
+{
+	struct sit9531x_dpll_pin *pin;
+	enum dpll_pin_direction dir;
+	u8 id, index;
+	int rc;
+
+	for (index = 0; index < SIT9531X_NUM_PINS_TOTAL; index++) {
+		if (index < SIT9531X_NUM_INPUT_PINS) {
+			id = index;
+			dir = DPLL_PIN_DIRECTION_INPUT;
+		} else {
+			id = index - SIT9531X_NUM_INPUT_PINS;
+			dir = DPLL_PIN_DIRECTION_OUTPUT;
+		}
+
+		if (!sit9531x_dpll_pin_is_registrable(sitdpll, dir, id))
+			continue;
+
+		pin = sit9531x_dpll_pin_alloc(sitdpll, dir, id);
+		if (IS_ERR(pin)) {
+			rc = PTR_ERR(pin);
+			goto error;
+		}
+
+		rc = sit9531x_dpll_pin_register(pin, index);
+		if (rc) {
+			sit9531x_dpll_pin_free(pin);
+			goto error;
+		}
+
+		list_add(&pin->list, &sitdpll->pins);
+	}
+
+	return 0;
+
+error:
+	sit9531x_dpll_pins_unregister(sitdpll);
+	return rc;
+}
+
+/* ====================================================================
+ * DPLL device registration
+ * ====================================================================
+ */
+
+static void sit9531x_dpll_change_work(struct work_struct *work)
+{
+	struct sit9531x_dpll *sitdpll;
+
+	sitdpll = container_of(work, struct sit9531x_dpll, change_work);
+	dpll_device_change_ntf(sitdpll->dpll_dev);
+}
+
+/*
+ * sit9531x_dpll_device_register - register a DPLL device
+ * @sitdpll:	DPLL to register
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int sit9531x_dpll_device_register(struct sit9531x_dpll *sitdpll)
+{
+	struct sit9531x_dev *sitdev = sitdpll->dev;
+	int rc;
+
+	sitdpll->ops = sit9531x_dpll_device_ops;
+
+	sitdpll->dpll_dev = dpll_device_get(sitdev->clock_id, sitdpll->id,
+					    THIS_MODULE, &sitdpll->tracker);
+	if (IS_ERR(sitdpll->dpll_dev)) {
+		rc = PTR_ERR(sitdpll->dpll_dev);
+		sitdpll->dpll_dev = NULL;
+		return rc;
+	}
+
+	rc = dpll_device_register(sitdpll->dpll_dev,
+				  sit9531x_prop_dpll_type_get(sitdev,
+							      sitdpll->id),
+				  &sitdpll->ops, sitdpll);
+	if (rc) {
+		dpll_device_put(sitdpll->dpll_dev, &sitdpll->tracker);
+		sitdpll->dpll_dev = NULL;
+	}
+
+	return rc;
+}
+
+/*
+ * sit9531x_dpll_device_unregister - unregister a DPLL device
+ * @sitdpll:	DPLL to unregister
+ */
+static void sit9531x_dpll_device_unregister(struct sit9531x_dpll *sitdpll)
+{
+	WARN(!sitdpll->dpll_dev, "DPLL device is not registered\n");
+
+	cancel_work_sync(&sitdpll->change_work);
+
+	dpll_device_unregister(sitdpll->dpll_dev, &sitdpll->ops, sitdpll);
+	dpll_device_put(sitdpll->dpll_dev, &sitdpll->tracker);
+	sitdpll->dpll_dev = NULL;
+}
+
+/* ====================================================================
+ * DPLL allocation and top-level register/unregister
+ * ====================================================================
+ */
+
+/**
+ * sit9531x_dpll_alloc - allocate a DPLL device structure
+ * @sitdev:	parent device
+ * @ch:		PLL channel number (0-3)
+ *
+ * Return: pointer to allocated DPLL on success, error pointer on error
+ */
+struct sit9531x_dpll *sit9531x_dpll_alloc(struct sit9531x_dev *sitdev, u8 ch)
+{
+	struct sit9531x_dpll *sitdpll;
+
+	sitdpll = kzalloc_obj(*sitdpll, GFP_KERNEL);
+	if (!sitdpll)
+		return ERR_PTR(-ENOMEM);
+
+	sitdpll->dev = sitdev;
+	sitdpll->id = ch;
+	sitdpll->lock_status = DPLL_LOCK_STATUS_UNLOCKED;
+	INIT_LIST_HEAD(&sitdpll->pins);
+	INIT_WORK(&sitdpll->change_work, sit9531x_dpll_change_work);
+
+	return sitdpll;
+}
+
+/**
+ * sit9531x_dpll_free - deallocate a DPLL device structure
+ * @sitdpll:	DPLL to free
+ */
+void sit9531x_dpll_free(struct sit9531x_dpll *sitdpll)
+{
+	WARN(sitdpll->dpll_dev, "DPLL device is still registered\n");
+	kfree(sitdpll);
+}
+
+/**
+ * sit9531x_dpll_register - register DPLL device and all its pins
+ * @sitdpll:	DPLL device
+ *
+ * Registers the DPLL device with the subsystem and then registers
+ * all input and output pins that are connected to this PLL.
+ *
+ * Return: 0 on success, <0 on error
+ */
+int sit9531x_dpll_register(struct sit9531x_dpll *sitdpll)
+{
+	int rc;
+
+	rc = sit9531x_dpll_device_register(sitdpll);
+	if (rc)
+		return rc;
+
+	rc = sit9531x_dpll_pins_register(sitdpll);
+	if (rc) {
+		sit9531x_dpll_device_unregister(sitdpll);
+		return rc;
+	}
+
+	return 0;
+}
+
+/**
+ * sit9531x_dpll_unregister - unregister DPLL device and its pins
+ * @sitdpll:	DPLL device
+ */
+void sit9531x_dpll_unregister(struct sit9531x_dpll *sitdpll)
+{
+	sit9531x_dpll_pins_unregister(sitdpll);
+	sit9531x_dpll_device_unregister(sitdpll);
+}
+
+/* ====================================================================
+ * Periodic change detection
+ * ====================================================================
+ */
+
+/**
+ * sit9531x_dpll_changes_check - check for state changes and notify
+ * @sitdpll:	DPLL device
+ *
+ * Called from sit9531x_dev_periodic_work().  Compares current hardware
+ * state against cached values and sends netlink notifications on changes.
+ */
+void sit9531x_dpll_changes_check(struct sit9531x_dpll *sitdpll)
+{
+	struct sit9531x_dev *sitdev = sitdpll->dev;
+	enum dpll_lock_status lock_status;
+	struct sit9531x_dpll_pin *pin;
+	int rc;
+
+	/* Get current lock status */
+	rc = sit9531x_dpll_lock_status_get(sitdpll->dpll_dev, sitdpll,
+					   &lock_status, NULL, NULL);
+	if (rc) {
+		dev_err(sitdev->dev, "Failed to get DPLL%u lock status: %d\n",
+			sitdpll->id, rc);
+		return;
+	}
+
+	/* If lock status changed, notify DPLL core */
+	if (sitdpll->lock_status != lock_status) {
+		sitdpll->lock_status = lock_status;
+		dpll_device_change_ntf(sitdpll->dpll_dev);
+	}
+
+	/* Check input pins for state changes */
+	list_for_each_entry(pin, &sitdpll->pins, list) {
+		enum dpll_pin_state state;
+		bool changed = false;
+
+		/* Output pin states are constant -- skip */
+		if (!sit9531x_dpll_is_input_pin(pin))
+			continue;
+
+		rc = sit9531x_dpll_input_pin_state_on_dpll_get(pin->dpll_pin,
+							       pin,
+							       sitdpll->dpll_dev,
+							       sitdpll,
+							       &state,
+							       NULL);
+		if (rc)
+			continue;
+
+		if (state != pin->pin_state) {
+			dev_dbg(sitdev->dev, "%s state changed: %u->%u\n",
+				pin->label, pin->pin_state, state);
+			pin->pin_state = state;
+			changed = true;
+		}
+
+		if (changed)
+			dpll_pin_change_ntf(pin->dpll_pin);
+	}
+}
diff --git a/drivers/dpll/sit9531x/dpll.h b/drivers/dpll/sit9531x/dpll.h
new file mode 100644
index 000000000000..7982e1a27df1
--- /dev/null
+++ b/drivers/dpll/sit9531x/dpll.h
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * SiTime SiT9531x DPLL subsystem interface
+ *
+ * Copyright (C) 2026 SiTime Corp.
+ * Author: Ali Rouhi <arouhi@sitime.com>
+ * Author: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>
+ *
+ * DPLL device and pin structures, and function declarations for
+ * the DPLL registration and callback layer.
+ */
+
+#ifndef _SIT9531X_DPLL_H
+#define _SIT9531X_DPLL_H
+
+#include <linux/dpll.h>
+#include <linux/list.h>
+#include <linux/types.h>
+#include <linux/workqueue.h>
+
+struct sit9531x_dev;
+
+/**
+ * struct sit9531x_dpll_pin - per-pin DPLL state
+ * @list:		linked list entry within dpll->pins
+ * @dpll:		back-pointer to owning DPLL
+ * @dpll_pin:		registered dpll_pin object
+ * @tracker:		reference count tracker for dpll_pin_get/put
+ * @fwnode:		firmware node handle (from DT)
+ * @label:		package label string (e.g. "IN0", "OUT3")
+ * @dir:		pin direction (INPUT or OUTPUT)
+ * @id:			hardware pin index (input 0-N or output 0-M)
+ * @prio:		current priority for automatic input selection
+ * @pin_state:		last saved pin state
+ * @phase_adjust:	current phase adjustment in picoseconds
+ * @phase_offset:	last measured phase offset
+ * @esync_control:	esync/sysref control allowed for this output pin
+ * @esync_freq:		last requested esync frequency (0 means disabled)
+ */
+struct sit9531x_dpll_pin {
+	struct list_head		list;
+	struct sit9531x_dpll		*dpll;
+	struct dpll_pin			*dpll_pin;
+	dpll_tracker			tracker;
+	struct fwnode_handle		*fwnode;
+	char				label[8];
+	enum dpll_pin_direction		dir;
+	u8				id;
+	u8				prio;
+	enum dpll_pin_state		pin_state;
+	s32				phase_adjust;
+	s64				phase_offset;
+	bool				esync_control;
+	u64				esync_freq;
+};
+
+/**
+ * struct sit9531x_dpll - per-PLL DPLL device state
+ * @list:		linked list entry within sitdev->dplls
+ * @dev:		back-pointer to parent sit9531x_dev
+ * @dpll_dev:		registered dpll_device object
+ * @tracker:		reference count tracker for dpll_device_get/put
+ * @ops:		copy of dpll_device_ops (per-instance)
+ * @pins:		list of registered pins
+ * @id:			PLL channel number (0 = PLLA, 3 = PLLD)
+ * @lock_status:	cached DPLL lock status
+ * @change_work:	work for sending device change notifications
+ */
+struct sit9531x_dpll {
+	struct list_head		list;
+	struct sit9531x_dev		*dev;
+	struct dpll_device		*dpll_dev;
+	dpll_tracker			tracker;
+	struct dpll_device_ops		ops;
+	struct list_head		pins;
+	u8				id;
+	enum dpll_lock_status		lock_status;
+	struct work_struct		change_work;
+};
+
+/* ---- DPLL allocation and registration ---- */
+struct sit9531x_dpll *sit9531x_dpll_alloc(struct sit9531x_dev *sitdev, u8 ch);
+void sit9531x_dpll_free(struct sit9531x_dpll *sitdpll);
+int  sit9531x_dpll_register(struct sit9531x_dpll *sitdpll);
+void sit9531x_dpll_unregister(struct sit9531x_dpll *sitdpll);
+
+/* ---- Periodic change detection ---- */
+void sit9531x_dpll_changes_check(struct sit9531x_dpll *sitdpll);
+
+#endif /* _SIT9531X_DPLL_H */
diff --git a/drivers/dpll/sit9531x/prop.c b/drivers/dpll/sit9531x/prop.c
new file mode 100644
index 000000000000..bc026fc81ba9
--- /dev/null
+++ b/drivers/dpll/sit9531x/prop.c
@@ -0,0 +1,345 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SiTime SiT9531x firmware node property parsing
+ *
+ * Copyright (C) 2026 SiTime Corp.
+ * Author: Ali Rouhi <arouhi@sitime.com>
+ * Author: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>
+ *
+ * Retrieves pin properties from Device Tree firmware nodes (or
+ * applies defaults when no firmware node exists).
+ */
+
+#include <linux/dev_printk.h>
+#include <linux/dpll.h>
+#include <linux/err.h>
+#include <linux/fwnode.h>
+#include <linux/property.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+
+#include "core.h"
+#include "prop.h"
+
+/*
+ * sit9531x_prop_pin_package_label_set - generate package label
+ * @sitdev:	pointer to device
+ * @props:	pointer to pin properties
+ * @dir:	pin direction
+ * @id:		pin index
+ *
+ * Generates a package label string: "IN0", "IN1", ..., "OUT0", "OUT7", ...
+ */
+static void
+sit9531x_prop_pin_package_label_set(struct sit9531x_dev *sitdev,
+				    struct sit9531x_pin_props *props,
+				    enum dpll_pin_direction dir, u8 id)
+{
+	const char *prefix;
+
+	if (dir == DPLL_PIN_DIRECTION_INPUT)
+		prefix = "IN";
+	else
+		prefix = "OUT";
+
+	snprintf(props->package_label, sizeof(props->package_label),
+		 "%s%u", prefix, id);
+
+	props->dpll_props.package_label = props->package_label;
+}
+
+/*
+ * sit9531x_prop_pin_fwnode_get - find firmware node for a pin
+ * @sitdev:	pointer to device
+ * @props:	pointer to pin properties
+ * @dir:	pin direction
+ * @id:		pin index
+ *
+ * Searches for input-pins/output-pins child nodes in DT, looking
+ * for a child whose "reg" property matches @id.
+ *
+ * Return: 0 on success, -ENOENT if no firmware node exists
+ */
+static int
+sit9531x_prop_pin_fwnode_get(struct sit9531x_dev *sitdev,
+			     struct sit9531x_pin_props *props,
+			     enum dpll_pin_direction dir, u8 id)
+{
+	struct fwnode_handle *pins_node, *pin_node;
+	const char *node_name;
+
+	if (dir == DPLL_PIN_DIRECTION_INPUT)
+		node_name = "input-pins";
+	else
+		node_name = "output-pins";
+
+	/* Get node containing input or output pins */
+	pins_node = device_get_named_child_node(sitdev->dev, node_name);
+	if (!pins_node) {
+		dev_dbg(sitdev->dev, "'%s' sub-node is missing\n", node_name);
+		return -ENOENT;
+	}
+
+	/* Enumerate child pin nodes and find the requested one */
+	fwnode_for_each_child_node(pins_node, pin_node) {
+		u32 reg;
+
+		if (fwnode_property_read_u32(pin_node, "reg", &reg))
+			continue;
+
+		if (id == reg)
+			break;
+	}
+
+	/* Release parent node */
+	fwnode_handle_put(pins_node);
+
+	/* Save found node */
+	props->fwnode = pin_node;
+
+	dev_dbg(sitdev->dev, "Firmware node for %s %sfound\n",
+		props->package_label, pin_node ? "" : "NOT ");
+
+	return pin_node ? 0 : -ENOENT;
+}
+
+/**
+ * sit9531x_pin_props_get - get pin properties for a given pin
+ * @sitdev:	pointer to device
+ * @dir:	pin direction (INPUT or OUTPUT)
+ * @index:	pin index
+ *
+ * Allocates a pin properties structure, generates a package label,
+ * looks up the firmware node if available, and reads optional
+ * properties (label, connection-type, supported-frequencies-hz,
+ * esync-control).
+ *
+ * Call sit9531x_pin_props_put() to free the returned structure.
+ *
+ * Return: pointer to pin properties on success, error pointer on error
+ */
+struct sit9531x_pin_props *
+sit9531x_pin_props_get(struct sit9531x_dev *sitdev,
+		       enum dpll_pin_direction dir, u8 index)
+{
+	struct dpll_pin_frequency *ranges;
+	struct sit9531x_pin_props *props;
+	int i, j, num_freqs = 0, rc;
+	u64 *freqs = NULL;
+	const char *type;
+	u32 curr_freq;
+
+	props = kzalloc_obj(*props, GFP_KERNEL);
+	if (!props)
+		return ERR_PTR(-ENOMEM);
+
+	/* Set default pin type and capabilities */
+	if (dir == DPLL_PIN_DIRECTION_INPUT) {
+		props->dpll_props.type = DPLL_PIN_TYPE_EXT;
+		props->dpll_props.capabilities =
+			DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE |
+			DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;
+		curr_freq = sitdev->ref[index].freq;
+	} else {
+		props->dpll_props.type = DPLL_PIN_TYPE_GNSS;
+		props->dpll_props.capabilities =
+			DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;
+		curr_freq = sitdev->out[index].freq;
+	}
+
+	/* Allow phase-adjust over +/-1 ms window.  The subsystem rejects
+	 * pin_set(phase-adjust, X) when X falls outside [min, max], so
+	 * leaving these at 0 silently blocks every netlink call.  1 ms is
+	 * well beyond the DCO dynamic range but costs nothing.
+	 */
+	props->dpll_props.phase_range.min = -1000000000; /* -1 ms in ps */
+	props->dpll_props.phase_range.max =  1000000000; /* +1 ms in ps */
+
+	/* Generate package label */
+	sit9531x_prop_pin_package_label_set(sitdev, props, dir, index);
+
+	/* Get firmware node for the given pin */
+	rc = sit9531x_prop_pin_fwnode_get(sitdev, props, dir, index);
+	if (rc)
+		goto skip_fwnode_props;
+
+	/* Look for "label" property -> board label */
+	fwnode_property_read_string(props->fwnode, "label",
+				    &props->dpll_props.board_label);
+
+	/* Look for "connection-type" property -> pin type enum */
+	if (!fwnode_property_read_string(props->fwnode, "connection-type",
+					 &type)) {
+		if (!strcmp(type, "ext"))
+			props->dpll_props.type = DPLL_PIN_TYPE_EXT;
+		else if (!strcmp(type, "gnss"))
+			props->dpll_props.type = DPLL_PIN_TYPE_GNSS;
+		else if (!strcmp(type, "int") ||
+			 !strcmp(type, "int-oscillator"))
+			props->dpll_props.type = DPLL_PIN_TYPE_INT_OSCILLATOR;
+		else if (!strcmp(type, "synce") ||
+			 !strcmp(type, "synce-eth-port"))
+			props->dpll_props.type = DPLL_PIN_TYPE_SYNCE_ETH_PORT;
+		else if (!strcmp(type, "mux"))
+			props->dpll_props.type = DPLL_PIN_TYPE_MUX;
+		else
+			dev_warn(sitdev->dev,
+				 "Unknown pin type '%s'\n", type);
+	}
+
+	/* For input pins: read signal mode and polarity */
+	if (dir == DPLL_PIN_DIRECTION_INPUT) {
+		const char *mode_str, *pol_str;
+
+		if (!fwnode_property_read_string(props->fwnode,
+						 "signal-mode",
+						 &mode_str)) {
+			if (!strcmp(mode_str, "DE"))
+				sitdev->ref[index].sig_mode =
+					SIT9531X_MODE_DE;
+			else
+				sitdev->ref[index].sig_mode =
+					SIT9531X_MODE_SE;
+		}
+
+		if (!fwnode_property_read_string(props->fwnode,
+						 "polarity", &pol_str)) {
+			if (!strcmp(pol_str, "N"))
+				sitdev->ref[index].polarity =
+					SIT9531X_POL_N;
+			else
+				sitdev->ref[index].polarity =
+					SIT9531X_POL_P;
+		}
+	}
+
+	/* Check for embedded sync control */
+	props->esync_control =
+		fwnode_property_read_bool(props->fwnode, "esync-control");
+
+	/* Read supported frequencies property */
+	num_freqs = fwnode_property_count_u64(props->fwnode,
+					      "supported-frequencies-hz");
+	if (num_freqs <= 0) {
+		num_freqs = 0;
+		goto skip_fwnode_props;
+	}
+
+	/* Read frequency list into temporary array */
+	freqs = kcalloc(num_freqs, sizeof(*freqs), GFP_KERNEL);
+	if (!freqs) {
+		rc = -ENOMEM;
+		goto err_alloc_freqs;
+	}
+
+	fwnode_property_read_u64_array(props->fwnode,
+				       "supported-frequencies-hz",
+				       freqs, num_freqs);
+
+	/*
+	 * Seed the runtime ref->freq / out->freq with the first DT-listed
+	 * supported frequency so the netlink frequency_get callback reports
+	 * a sane initial value before any pin_set occurs.  DT lists the
+	 * physically-wired reference frequency for each input pin and the
+	 * default output frequency for each output pin.
+	 */
+	if (num_freqs > 0) {
+		if (dir == DPLL_PIN_DIRECTION_INPUT)
+			sitdev->ref[index].freq = (u32)freqs[0];
+		else
+			sitdev->out[index].freq = (u32)freqs[0];
+		curr_freq = (u32)freqs[0];
+	}
+
+skip_fwnode_props:
+	/* Allocate frequency ranges list -- DT discrete entries + current
+	 * freq + one catch-all wide range so the subsystem never pre-
+	 * rejects a frequency_set call.  The chip's real admissible set
+	 * is bounded by VCO / divider math in sit9531x_output_freq_set().
+	 */
+	ranges = kcalloc(num_freqs + 2, sizeof(*ranges), GFP_KERNEL);
+	if (!ranges) {
+		rc = -ENOMEM;
+		goto err_alloc_ranges;
+	}
+
+	/* Current freq as first entry */
+	ranges[0] = (struct dpll_pin_frequency)DPLL_PIN_FREQUENCY(curr_freq);
+	j = 1;
+
+	/* Copy DT-listed freqs (if any), skipping curr_freq */
+	for (i = 0; i < num_freqs; i++) {
+		struct dpll_pin_frequency freq = DPLL_PIN_FREQUENCY(freqs[i]);
+
+		if (freqs[i] == curr_freq)
+			continue;
+		ranges[j++] = freq;
+	}
+
+	/* Always append a wide catch-all range */
+	ranges[j].min = 1;
+	ranges[j].max = 1000000000ULL; /* 1 GHz */
+	j++;
+
+	props->dpll_props.freq_supported = ranges;
+	props->dpll_props.freq_supported_num = j;
+
+	kfree(freqs);
+
+	return props;
+
+err_alloc_ranges:
+	kfree(freqs);
+err_alloc_freqs:
+	fwnode_handle_put(props->fwnode);
+	kfree(props);
+
+	return ERR_PTR(rc);
+}
+
+/**
+ * sit9531x_pin_props_put - release pin properties
+ * @props:	pin properties to free
+ */
+void sit9531x_pin_props_put(struct sit9531x_pin_props *props)
+{
+	kfree(props->dpll_props.freq_supported);
+
+	if (props->fwnode)
+		fwnode_handle_put(props->fwnode);
+
+	kfree(props);
+}
+
+/**
+ * sit9531x_prop_dpll_type_get - get DPLL channel type from firmware
+ * @sitdev:	pointer to device
+ * @index:	DPLL channel index (0-3)
+ *
+ * Reads the "dpll-types" string array property from the firmware node
+ * and returns the corresponding DPLL type enum.
+ *
+ * Return: DPLL type for the given channel (default: DPLL_TYPE_PPS)
+ */
+enum dpll_type
+sit9531x_prop_dpll_type_get(struct sit9531x_dev *sitdev, u8 index)
+{
+	const char *types[SIT9531X_NUM_PLLS];
+	int count;
+
+	count = device_property_read_string_array(sitdev->dev, "dpll-types",
+						  types, ARRAY_SIZE(types));
+
+	if (index >= count)
+		return DPLL_TYPE_PPS;
+
+	if (!strcmp(types[index], "pps"))
+		return DPLL_TYPE_PPS;
+	else if (!strcmp(types[index], "eec"))
+		return DPLL_TYPE_EEC;
+
+	dev_info(sitdev->dev, "Unknown DPLL type '%s', using default\n",
+		 types[index]);
+
+	return DPLL_TYPE_PPS;
+}
diff --git a/drivers/dpll/sit9531x/prop.h b/drivers/dpll/sit9531x/prop.h
new file mode 100644
index 000000000000..d0f5cccb435c
--- /dev/null
+++ b/drivers/dpll/sit9531x/prop.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * SiTime SiT9531x firmware node property parsing
+ *
+ * Copyright (C) 2026 SiTime Corp.
+ * Author: Ali Rouhi <arouhi@sitime.com>
+ * Author: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>
+ */
+
+#ifndef _SIT9531X_PROP_H
+#define _SIT9531X_PROP_H
+
+#include <linux/dpll.h>
+#include <linux/fwnode.h>
+
+struct sit9531x_dev;
+
+/**
+ * struct sit9531x_pin_props - pin properties from firmware
+ * @fwnode:		firmware node handle (NULL if no DT node)
+ * @dpll_props:		DPLL core pin properties
+ * @package_label:	pin package label (e.g. "IN0", "OUT3")
+ * @esync_control:	embedded sync is controllable
+ */
+struct sit9531x_pin_props {
+	struct fwnode_handle		*fwnode;
+	struct dpll_pin_properties	dpll_props;
+	char				package_label[8];
+	bool				esync_control;
+};
+
+enum dpll_type sit9531x_prop_dpll_type_get(struct sit9531x_dev *sitdev,
+					   u8 index);
+struct sit9531x_pin_props *sit9531x_pin_props_get(struct sit9531x_dev *sitdev,
+						  enum dpll_pin_direction dir,
+						  u8 index);
+void sit9531x_pin_props_put(struct sit9531x_pin_props *props);
+
+#endif /* _SIT9531X_PROP_H */
diff --git a/drivers/dpll/sit9531x/regs.h b/drivers/dpll/sit9531x/regs.h
new file mode 100644
index 000000000000..f6b7063f55b4
--- /dev/null
+++ b/drivers/dpll/sit9531x/regs.h
@@ -0,0 +1,359 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * SiTime SiT9531x register definitions
+ *
+ * Copyright (C) 2026 SiTime Corp.
+ * Author: Ali Rouhi <arouhi@sitime.com>
+ * Author: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>
+ */
+
+#ifndef _SIT9531X_REGS_H
+#define _SIT9531X_REGS_H
+
+/*
+ * I2C register model:
+ *   - Page select register at offset 0x01
+ *   - Each page has 128 registers (0x00-0x7F)
+ *   - Some pages are paired (e.g. 0x0A/0x1A for PLLA)
+ */
+#define SIT9531X_PAGE_SEL		0xFF
+#define SIT9531X_PAGE_SIZE		0x100
+#define SIT9531X_NUM_PAGES		32
+
+/* Helper macros for page:offset addressing */
+#define SIT9531X_REG(_page, _offset)		(((_page) << 8) | (_offset))
+#define SIT9531X_REG_PAGE(_reg)		((_reg) >> 8)
+#define SIT9531X_REG_OFFSET(_reg)		((_reg) & 0xFF)
+
+/* ---- Page definitions ---- */
+#define SIT9531X_PAGE_MAINSYS0		0x00
+#define SIT9531X_PAGE_MAINSYS1		0x01
+#define SIT9531X_PAGE_INPUTSYS		0x02
+#define SIT9531X_PAGE_OUTSYS0		0x03
+#define SIT9531X_PAGE_OUTSYS1		0x04
+#define SIT9531X_PAGE_CLKMON0		0x06
+#define SIT9531X_PAGE_CLKMON1		0x07
+#define SIT9531X_PAGE_PLLA			0x0A
+#define SIT9531X_PAGE_PLLA_EXT		0x1A
+#define SIT9531X_PAGE_PLLB			0x0B
+#define SIT9531X_PAGE_PLLB_EXT		0x1B
+#define SIT9531X_PAGE_PLLC			0x0C
+#define SIT9531X_PAGE_PLLC_EXT		0x1C
+#define SIT9531X_PAGE_PLLD			0x0D
+#define SIT9531X_PAGE_PLLD_EXT		0x1D
+
+/* PLL index to page mapping */
+#define SIT9531X_PLL_PAGE(_idx) \
+	(SIT9531X_PAGE_PLLA + (_idx))
+
+/* ---- Page 0x00 (Main System) registers ---- */
+/*
+ * VARIANT_ID is a single byte at page 0 reg 0x02 (95317 = 0x17, 95316 = 0x31).
+ * Reg 0x03 carries an unrelated revision byte and must not be combined into
+ * the variant identifier.
+ */
+#define SIT9531X_REG_VARIANT_ID		SIT9531X_REG(0x00, 0x02)
+#define SIT9531X_REG_LOS_STATUS		SIT9531X_REG(0x00, 0x04)
+#define SIT9531X_REG_OOF_STATUS		SIT9531X_REG(0x00, 0x05)
+#define SIT9531X_REG_HOLDOVER_STATUS		SIT9531X_REG(0x00, 0x06)
+#define SIT9531X_REG_SYNC_STATUS		SIT9531X_REG(0x00, 0x07)
+#define SIT9531X_REG_STATUS_1		SIT9531X_REG(0x00, 0x06)
+#define SIT9531X_REG_STATUS_2		SIT9531X_REG(0x00, 0x0A)
+
+/* DCO trigger register (Page 0x00) */
+#define SIT9531X_REG_DCO_TRIGGER		SIT9531X_REG(0x00, 0x64)
+#define SIT9531X_DCO_TRIGGER_INCR		BIT(6)
+#define SIT9531X_DCO_TRIGGER_DECR		BIT(4)
+#define SIT9531X_DCO_TRIGGER_BASE		0xAE
+
+/* DCO trigger pulse timing: minimum 6 ns required by hardware */
+#define SIT9531X_DCO_TRIGGER_PULSE_NS		167
+
+#define SIT9531X_REG_HOLDOVER_HISTORY	SIT9531X_REG(0x00, 0x58)
+
+/* Page 0 -- PLL inner loop loss-of-lock */
+#define SIT9531X_REG_PLL_INNER_LOL_STATUS	SIT9531X_REG(0x00, 0x92)
+#define SIT9531X_REG_PLL_INNER_LOL_NOTIF	SIT9531X_REG(0x00, 0x93)
+
+/* Page 0 -- Clock monitor PLL / XO status */
+#define SIT9531X_REG_CMON_STATUS		SIT9531X_REG(0x00, 0x9D)
+#define SIT9531X_REG_CMON_NOTIF		SIT9531X_REG(0x00, 0x9E)
+#define SIT9531X_CMON_XO_LOSS		BIT(4)
+#define SIT9531X_CMON_PLL_INNER_LOL		BIT(5)
+
+/* Page 0 -- PLL outer-loop loss-of-lock */
+#define SIT9531X_REG_OUTER_LOL_STATUS	SIT9531X_REG(0x00, 0x06)
+#define SIT9531X_REG_OUTER_LOL_NOTIF		SIT9531X_REG(0x00, 0x07)
+
+/* Page 0 -- PLL holdover freeze status */
+#define SIT9531X_REG_HO_FREEZE_STATUS	SIT9531X_REG(0x00, 0x0A)
+#define SIT9531X_REG_HO_FREEZE_NOTIF	SIT9531X_REG(0x00, 0x0B)
+
+/* Page 0 -- INTSYNC (inter-PLL synchronization) global enable */
+#define SIT9531X_REG_INTSYNC_GLOBAL		SIT9531X_REG(0x00, 0x40)
+#define SIT9531X_INTSYNC_EN_BIT		6
+
+/* ---- Page 0x01 (Input Priority Table) registers ---- */
+/*
+ * Priority table: 6 registers per PLL, each holds two priority slots
+ * nibble-packed (even slot in [3:0], odd slot in [7:4]).
+ *
+ * Base registers for PLLA: 0x16-0x1B (slots 0-11).
+ * For PLL N:  base + 6 * N  (e.g. PLLB starts at 0x1C).
+ *
+ * Input source encoding (4-bit value):
+ *   0=IN0P, 1=IN1P, 2=IN2P, 3=IN3P, 4=IN4P,
+ *   5=OCXO, 6=INTSYNC,
+ *   7=IN0N, 8=IN1N, 9=IN2N, 10=IN3N, 11=IN4N
+ */
+#define SIT9531X_PAGE_PRIOSYS		0x01
+#define SIT9531X_PRIO_BASE_REG		0x16
+#define SIT9531X_PRIO_REGS_PER_PLL		6
+#define SIT9531X_PRIO_SLOTS_PER_REG		2
+#define SIT9531X_PRIO_MAX_SLOTS		12
+#define SIT9531X_PRIO_NIBBLE_MASK		0x0F
+#define SIT9531X_PRIO_HI_SHIFT		4
+
+/* Page 0 -- Global update register (PRG_CMD / NVM / loop lock) */
+#define SIT9531X_REG_GLOBAL_UPDATE		SIT9531X_REG(0x00, 0x0F)
+
+/* PLL holdover control (PLL page offset) */
+#define SIT9531X_PLL_REG_HO_CTRL		0x6F
+#define SIT9531X_PLL_HO_FORCE_BIT		4
+
+/* ---- Page 0x02 (Input System) -- input disable control ---- */
+#define SIT9531X_REG_IN_DE_FORCE		SIT9531X_REG(0x02, 0xE8)
+#define SIT9531X_REG_IN_DE_STATE		SIT9531X_REG(0x02, 0xE9)
+#define SIT9531X_REG_IN_SEP_FORCE		SIT9531X_REG(0x02, 0xEA)
+#define SIT9531X_REG_IN_SEP_STATE		SIT9531X_REG(0x02, 0xEB)
+#define SIT9531X_REG_IN_SEN_FORCE		SIT9531X_REG(0x02, 0xF2)
+#define SIT9531X_REG_IN_SEN_STATE		SIT9531X_REG(0x02, 0xF3)
+
+/* ---- Page 0x03 (Output System) registers -- Hi-Z control ---- */
+#define SIT9531X_REG_HIZ_DIFF_07_MASK	SIT9531X_REG(0x03, 0xF2)
+#define SIT9531X_REG_HIZ_DIFF_07_STATE	SIT9531X_REG(0x03, 0xF3)
+#define SIT9531X_REG_HIZ_DIFF_811_MASK	SIT9531X_REG(0x03, 0xF4)
+#define SIT9531X_REG_HIZ_DIFF_811_STATE	SIT9531X_REG(0x03, 0xF5)
+#define SIT9531X_REG_HIZ_SE_811_OE_MASK	SIT9531X_REG(0x03, 0xF4)
+#define SIT9531X_REG_HIZ_SE_811_OE_STATE	SIT9531X_REG(0x03, 0xF5)
+#define SIT9531X_REG_HIZ_SE_07_OE_MASK	SIT9531X_REG(0x03, 0xF6)
+#define SIT9531X_REG_HIZ_SE_07_OE_STATE	SIT9531X_REG(0x03, 0xF7)
+#define SIT9531X_REG_HIZ_SE_07_MASK		SIT9531X_REG(0x03, 0xF8)
+#define SIT9531X_REG_HIZ_SE_07_STATE		SIT9531X_REG(0x03, 0xF9)
+#define SIT9531X_REG_HIZ_SE_811_MASK		SIT9531X_REG(0x03, 0xFA)
+#define SIT9531X_REG_HIZ_SE_811_STATE	SIT9531X_REG(0x03, 0xFB)
+
+/* ---- Pages 0x03/0x04 -- Output divider (DIVO) registers ---- */
+/*
+ * Output divider registers in Pages 3/4.  Each output has a 34-bit
+ * integer divider mapped to 5 bytes (LSB at base reg, MSB at base-4).
+ * Outputs 0-5 are on Page 3, outputs 6-11 are on Page 4.
+ *
+ * The base register for slot N within a page is:
+ *   clkout_odr_divn_base[slot] = { 0x14, 0x24, 0x34, 0x44, 0x54, 0x64 }
+ *
+ * Layout: base=LSB, base-1, base-2, base-3, base-4[1:0]=MSB.
+ *
+ * Per-chip clkout_map[] translates output index to slot position.
+ */
+#define SIT9531X_PAGE_OUTSYS0_SLOT_MAX	5   /* slots 0-5 on Page 0x03 */
+
+/* Misc output system registers */
+#define SIT9531X_REG_PRG_DIR_GEN		SIT9531X_REG(0x03, 0x0F)
+#define SIT9531X_PRG_CMD_STATE		0x01
+#define SIT9531X_UPDATE_NVM			0x10
+#define SIT9531X_LOOP_LOCK			0x40
+
+/* Debug register (same offset, per-page) */
+#define SIT9531X_REG_OUTSYS_DEBUG		SIT9531X_REG(0x03, 0xBD)
+#define SIT9531X_DEBUG_UNLOCK_VAL		0xC3
+
+/* ---- Pages 0x03/0x04 -- Output PRG_RST_DELAY (per-output phase delay) ---- */
+/*
+ * Per-output programmable phase delay: 34-bit coarse (in VCO clock
+ * cycles) plus a 3-bit fine field with fixed 30 ps steps.  Each output
+ * has a five-byte block PROG6..PROG2:
+ *
+ *   base + 0  PROG6  [7:5] OPSTG_VCASC_BUMP (preserve via RMW)
+ *                    [4:2] PRG_RST_FINE_DELAY[2:0]
+ *                    [1:0] PRG_RST_DELAY[33:32]
+ *   base + 1  PROG5  [7:0] PRG_RST_DELAY[31:24]
+ *   base + 2  PROG4  [7:0] PRG_RST_DELAY[23:16]
+ *   base + 3  PROG3  [7:0] PRG_RST_DELAY[15:8]
+ *   base + 4  PROG2  [7:0] PRG_RST_DELAY[7:0]
+ *
+ * Outputs 0-5 are on Page 3, outputs 6-11 on Page 4.  The block base
+ * within a page is 0x15 + 16 * (out_idx % 6).
+ */
+#define SIT9531X_OUT_PRG_DELAY_BASE		0x15
+#define SIT9531X_OUT_PRG_SLOT_STRIDE		0x10
+#define SIT9531X_OUT_PRG_OPSTG_MASK		0xE0	/* bits [7:5], preserve */
+#define SIT9531X_OUT_PRG_FINE_SHIFT		2
+#define SIT9531X_OUT_PRG_FINE_MASK		0x1C	/* bits [4:2] */
+#define SIT9531X_OUT_PRG_COARSE_HI_MASK		0x03	/* bits [1:0] */
+#define SIT9531X_OUT_PRG_FINE_STEP_PS		30
+#define SIT9531X_OUT_PRG_FINE_MAX		7	/* 3-bit field */
+#define SIT9531X_OUT_PRG_COARSE_BITS		34
+
+/* ---- Pages 0x03/0x04 -- Output PROG0 (PULSE_CTRL, 8-bit) ---- */
+/*
+ * Per-output pulse-count control byte used in SYSREF / SYNCB modes.
+ * Slot N within a page sits at 0x1B + 16 * (slot % 6).  Same page
+ * mapping as PRG_RST_DELAY: slots 0-5 on Page 3, slots 6-11 on Page 4.
+ */
+#define SIT9531X_OUT_PROG0_BASE		0x1B
+
+/* ---- Page 0 -- per-PLL DIVO trigger enables (NVMSPARE1_GENERIC, 0x19) ---- */
+/*
+ * One bit per PLL (A=0, B=1, C=2, D=3) for the small-change (SYSREF
+ * trigger) path; bit n+4 enables the large-change (DIVO restart)
+ * path for the same PLL.  See SiT95316 register map p.6.
+ */
+#define SIT9531X_REG_DIVO_TRIGGER_EN	SIT9531X_REG(0x00, 0x19)
+#define SIT9531X_DIVO_SYSREF_TRIG_BIT(_pll)	(_pll)
+#define SIT9531X_DIVO_LARGE_TRIG_BIT(_pll)	((_pll) + 4)
+
+/* ---- PLL_CONFIG47_PLL (per PLL page reg 0x47) ---- */
+/*
+ * Mode bits 6/5/4 select the SYSREF/SYNCB/PULSER variants; bits 3:0
+ * carry DIVO_SYS_REF[11:8] of the 12-bit one-hot output select that
+ * continues into reg 0x48[7:0].  See register map p.84.
+ */
+#define SIT9531X_PLL_REG_SYSREF_MODE	0x47
+#define SIT9531X_PLL_SYSREF_PULSER_BIT	BIT(6)
+#define SIT9531X_PLL_SYSREF_MODE_BIT	BIT(5)
+#define SIT9531X_PLL_SYSREF_SYNCB_BIT	BIT(4)
+#define SIT9531X_PLL_SYSREF_MODE_MASK	(SIT9531X_PLL_SYSREF_PULSER_BIT | \
+					 SIT9531X_PLL_SYSREF_MODE_BIT | \
+					 SIT9531X_PLL_SYSREF_SYNCB_BIT)
+#define SIT9531X_PLL_SYSREF_TARGET_HI_MASK	0x0F
+#define SIT9531X_PLL_REG_SYSREF_SEL	0x48
+
+/* ---- PLL page registers (apply to pages 0x0A-0x0D) ---- */
+#define SIT9531X_PLL_REG_SMALL_UPDATE	0x0F
+
+/*
+ * Loop-filter coefficients on PLL_PAGE regs 0x10-0x15 (3 normal +
+ * 3 fast-lock) are GUI/NVM-generated by the timing configurator and must not be
+ * reprogrammed at runtime; the register map flags them as
+ * "GUI generated configuration should not change manually".
+ */
+
+#define SIT9531X_PLL_REG_OUT_MAP_HI		0x27
+#define SIT9531X_PLL_REG_OUT_MAP_LO		0x28
+#define SIT9531X_PLL_REG_INPUT_SEL		0x29
+/*
+ * LL_REG2_PLL -- lock-detection thresholds (PDF p.80):
+ *   bits [7:4] LL_SET_VALUE_PLL[3:0]  outer-loop unlock threshold
+ *   bits [3:0] LL_CLR_VALUE_PLL[3:0]  outer-loop relock  threshold
+ * 16-step ladder spans 0.05 PPB to 4000 PPM.
+ */
+#define SIT9531X_PLL_REG_LL_THRESH		0x2A
+#define SIT9531X_PLL_REG_STATUS		0x31
+#define SIT9531X_PLL_REG_NVM_UPDATE		0x3F
+
+/* DIVN registers (free-run divider readback) */
+#define SIT9531X_PLL_REG_DIVN_INT		0x30
+#define SIT9531X_PLL_REG_DIVN_NUM		0x32  /* 4 bytes (0x32-0x35) */
+#define SIT9531X_PLL_REG_DIVN_DEN		0x38  /* 4 bytes (0x38-0x3B) */
+
+/* DIVN2 registers (sync divider readback) */
+#define SIT9531X_PLL_REG_DIVN2_INT		0x3E  /* 5 bytes (0x3E-0x42) */
+#define SIT9531X_PLL_REG_DIVN2_FRAC_NUM	0x43  /* 4 bytes (0x43-0x46) */
+#define SIT9531X_PLL_REG_DIVN2_FRAC_DEN	0x49  /* 4 bytes (0x49-0x4C) */
+
+/* Inner loop DCO word registers (48-bit fractional) */
+#define SIT9531X_PLL_REG_DCO_FRAC1		0x51
+#define SIT9531X_PLL_REG_DCO_FRAC2		0x52
+#define SIT9531X_PLL_REG_DCO_FRAC3		0x53
+#define SIT9531X_PLL_REG_DCO_FRAC4		0x54
+#define SIT9531X_PLL_REG_DCO_FRAC5		0x55
+#define SIT9531X_PLL_REG_DCO_FRAC6		0x56
+
+/* DCO function register */
+#define SIT9531X_PLL_REG_DCO_FUNC		0x57
+#define SIT9531X_DCO_MASK			BIT(0)
+#define SIT9531X_DCO_EN			BIT(1)
+#define SIT9531X_DCO_OUTER_EN		BIT(4)
+#define SIT9531X_DCO_DITHER_MODE		BIT(6)
+
+/* Outer loop DCO integer registers (24-bit) */
+#define SIT9531X_PLL_REG_DCO_INT_7		0x5E
+#define SIT9531X_PLL_REG_DCO_INT_15		0x5F
+#define SIT9531X_PLL_REG_DCO_INT_23		0x60
+
+/* Outer loop DCO fractional registers (32-bit, shifted <<16) */
+#define SIT9531X_PLL_REG_DCO_OFRAC_7	0x63
+#define SIT9531X_PLL_REG_DCO_OFRAC_15	0x64
+#define SIT9531X_PLL_REG_DCO_OFRAC_23	0x65
+#define SIT9531X_PLL_REG_DCO_OFRAC_31	0x66
+
+/* Debug register unlock */
+#define SIT9531X_PLL_REG_DEBUG		0xBD
+#define SIT9531X_PLL_DEBUG_UNLOCK		0xC3
+
+/* TDC (Time-to-Digital Converter) phase measurement -- PLL page */
+#define SIT9531X_PLL_REG_TDC_CFG		0xB3
+#define SIT9531X_PLL_REG_TDC_MODE		0xB4
+#define SIT9531X_TDC_MODE_ENABLE		0x80
+#define SIT9531X_TDC_CFG_DEFAULT		69
+#define SIT9531X_PLL_REG_TDC_DATA_0		0xB5  /* [7:0] */
+#define SIT9531X_PLL_REG_TDC_DATA_1		0xB6  /* [15:8] */
+#define SIT9531X_PLL_REG_TDC_DATA_2		0xB7  /* [23:16] */
+#define SIT9531X_PLL_REG_TDC_DATA_3		0xB8  /* [31:24] */
+#define SIT9531X_PLL_REG_TDC_DATA_4		0xB9  /* [39:32] + sign */
+#define SIT9531X_TDC_SIGN_BIT		3
+#define SIT9531X_PLL_REG_TDC_TRIGGER		0xD0  /* read to latch TDC sample */
+
+/* PLL EXT page INTSYNC configuration registers */
+#define SIT9531X_PLL_EXT_PAGE(_idx)		(SIT9531X_PAGE_PLLA_EXT + (_idx))
+
+/* PLL STATUS register bits */
+#define SIT9531X_PLL_STATUS_LOCK		BIT(0)
+#define SIT9531X_PLL_STATUS_OUTER_DIS	BIT(5)
+
+/* Small update command */
+#define SIT9531X_PLL_SMALL_UPDATE_CMD	0x02
+
+/* ---- Clock monitor registers (Page 0x06) ---- */
+/*
+ * Per-input clock monitor status registers.  Each register holds
+ * status for two inputs (even input in bits [3:0], odd in [7:4]).
+ * P-polarity and N-polarity inputs have separate register banks.
+ *
+ * Bit layout per input nibble:
+ *   [0] freq_fine_drifted   -- fine frequency drift detected
+ *   [1] freq_coarse_drifted -- coarse frequency drift detected
+ *   [2] clk_loss            -- clock input loss (LOS)
+ *   [3] clk_loss_fd         -- clock input loss with freq drift
+ *
+ * Status register is at base offset, notification at base+1.
+ */
+
+/* P-polarity status registers */
+#define SIT9531X_CLKMON_P_STATUS_01		SIT9531X_REG(0x06, 0x02)  /* inputs 0,1 */
+#define SIT9531X_CLKMON_P_NOTIF_01		SIT9531X_REG(0x06, 0x03)
+#define SIT9531X_CLKMON_P_STATUS_23		SIT9531X_REG(0x06, 0x06)  /* inputs 2,3 */
+#define SIT9531X_CLKMON_P_NOTIF_23		SIT9531X_REG(0x06, 0x07)
+
+/* N-polarity status registers */
+#define SIT9531X_CLKMON_N_STATUS_01		SIT9531X_REG(0x06, 0x92)  /* inputs 0,1 */
+#define SIT9531X_CLKMON_N_NOTIF_01		SIT9531X_REG(0x06, 0x93)
+#define SIT9531X_CLKMON_N_STATUS_23		SIT9531X_REG(0x06, 0x96)  /* inputs 2,3 */
+#define SIT9531X_CLKMON_N_NOTIF_23		SIT9531X_REG(0x06, 0x97)
+
+/* Per-input bit offsets within clock monitor nibble */
+#define SIT9531X_CLKMON_FREQ_FINE		0  /* bit 0 / bit 4 */
+#define SIT9531X_CLKMON_FREQ_COARSE		1  /* bit 1 / bit 5 */
+#define SIT9531X_CLKMON_CLK_LOSS		2  /* bit 2 / bit 6 */
+#define SIT9531X_CLKMON_CLK_LOSS_FD		3  /* bit 3 / bit 7 */
+
+/* ---- Debug / NVM unlock registers ---- */
+#define SIT9531X_REG_DBG_UNLOCK1		0x24
+#define SIT9531X_REG_DBG_UNLOCK2		0x25
+
+/* ---- Variant ID values (single byte read from SIT9531X_REG_VARIANT_ID) ---- */
+#define SIT9531X_VARIANT_ID_95317	0x17
+#define SIT9531X_VARIANT_ID_95316	0x31
+
+#endif /* _SIT9531X_REGS_H */
-- 
2.43.0


