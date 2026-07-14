Return-Path: <netdev+bounces-307464-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rtnTKy82VmoY1gAAu9opvQ
	(envelope-from <netdev+bounces-307464-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 15:14:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C35754F17
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 15:14:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=resnulli-us.20251104.gappssmtp.com header.s=20251104 header.b=LYWJSnYI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307464-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307464-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B63C30A2FC2
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 13:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5453A46AF15;
	Tue, 14 Jul 2026 13:06:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E8046AF0E
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 13:06:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784034373; cv=none; b=AUgYOSko5Cc+lWKDC1azR1V7GWHVNSJit2w4DgQY4aGcdT/bDWL/J4e13rInrQrS4GiwipFoTBy9gqLuOdBkdi27L8kQuwD+InKjWv09fcZInBCMYeuwzoxsdA7Zv+tFa45kmZ60L0GNDajavDaO9MXPo2lLUkUdT3gFT3kr/Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784034373; c=relaxed/simple;
	bh=8cBHeNQEUivsqPKa+xnCsJWbAFPW2Q+TAFwvi2r+T/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hrPBzjs1wejbry7USwwsIkh/gapGBDwQYj7vsZf2qFXBe5ksJ5vbknyb8aZgJr58BVUQ8MhHp8iCYgblGdwZIuxVzh+TvwLeYXjj51u31CW4e9p8UIZ7eM/UvpU1j6uD33hqkm5vPI4opzyDoe7QWA1k2F8QTfSYpfMh3P/Aa9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=LYWJSnYI; arc=none smtp.client-ip=209.85.208.180
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-39c9107baa7so40747161fa.3
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 06:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1784034368; x=1784639168; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JvuhX6iIT9+TXre87bDU9k38RCYa7DnAf3sxW1AuAnQ=;
        b=LYWJSnYI5TntY80VPSLi68qbwS+HNidQnVnvIXVoS6vcM5Tse2TIZPTz5xXggtz3nI
         LDEMWW4c2hOyMTaqiw3AwmCBT97tJ5piqE4GVlB9ASy6yaWec83hHajv9WdLc18vM/0h
         4xmb2sBx6OtaPMjmDxOWJKNVtXTDcBiAgRaUITR2t/U3klOdpi4j6s4uhDFgz83/dSBc
         lHEWtPij9LZwd02NruQlBgmd9pSHmluYsNCnv9oYk4Yid6+e0QXtzYyblzm2GYuIjoz6
         ASp/q2Cnmvz+pwgH6AgDVhpdmatX0BsffgUJAZ8z8J2jJMuf5jkszyPcHTmbe7v/IC7i
         FYhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784034368; x=1784639168;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JvuhX6iIT9+TXre87bDU9k38RCYa7DnAf3sxW1AuAnQ=;
        b=TKnw0LMxLfVfozReSJf/za8GJoOXEAClEGImcVGsZ9OU2UZ5RNSkMzeRV31uwRH2Yu
         W99KAgWP6HNHp6X/SvF98LCcsAlrvV0yoVBhvTVLdTYm0rtl8YEh79SsbKMDw8fmFQ/c
         +S21BuW7MnSdGVFBjHx+YHaro2A/z0cc61WwolzNJfHf0brpz7NZ9mId/1mV31Yu+Yhm
         ie4l9tWrArp0DUTsKq9WI+jymHN175itlfU2gxryWLMB4GIRVvnhtL8sYF+KZx/9+ncy
         10tmpLKBEr0TSGpw1MMsscZiesp89KSlRchoRR+IxO6N91OmlCsJyWHCpwsW6x7LI+FC
         H0tw==
X-Forwarded-Encrypted: i=1; AHgh+Rr6hklsQIYssT6rWQ7NcOQTT8JbcI6tKDElZWz5PTgguMtKFh/2gjXWZGbjtBZ3vIyQitfzn/U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx52xqflFUVqqWrflJjvWo0kRbpFQ/0zWJczJQOQmIu/gIaM+fD
	oONwg8J+qeNzy7UxR1p32GjtWn9pr9BmwCmPtH/6Nb+EQD50kWthUQzjpw4FNg22p04=
X-Gm-Gg: AfdE7cmkl0UwUjnecZfkIEIdplD4pil+Capj7i3Bh+bM223WCI5V7xa2GctgbbJRi4q
	GF2GKPgyGIftCbXrXtXfZYDMhmSPa73lUKj4ChV+/Gpk0d1hjylJevMXftlWfJr/V21FG9sxIxc
	OmFRMwuPmJ37pqk8AdoFgjdfWOaIqYzRvqUjn5zaaL9ApmWOMa2LSgWbNYWaBdG5wWwNM2qyDn/
	JEBLw7T2+GIJdIZaaRMP33Qn0SbVay/RTVkYiVzUeRm7vEBfEvbprn/xC3OJAxsMCTe2wG3MR6g
	JuSDImh+EqL9iaFeyQBl1H9dZtrM+4LJtLsLhA9MjAgMwfNQD5mVVfQAr6d/P0Tr6pTcBlIvxlh
	/ZUfgnQLeL0QQLcVrlHqEAUeIah6x4+FRBbidlPor8VwwGDnSWVmn3iKPF1m2iA7VLNYp5fAc/i
	evA405kd9D8+Q4efBFllbAog==
X-Received: by 2002:a05:6512:12cc:b0:5ae:bb52:b09d with SMTP id 2adb3069b0e04-5b0236bbb61mr3730138e87.52.1784034368171;
        Tue, 14 Jul 2026 06:06:08 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b01cab1491sm3457312e87.82.2026.07.14.06.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 06:06:07 -0700 (PDT)
Date: Tue, 14 Jul 2026 15:06:01 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: han.junyang@zte.com.cn
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, ran.ming@zte.com.cn, 
	han.chengfei@zte.com.cn, zhang.yanze@zte.com.cn
Subject: Re: [PATCH net-next v8 1/2] dinghai: add ZTE network driver support
Message-ID: <alYzSz_X1Ft1Hegb@FV6GYCPJ69>
References: <202607132221104795CMBHxJGy8iTj3qc36Qw6@zte.com.cn>
 <20260713222420704lmwNL8xT8mgOhTKbqAfRX@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713222420704lmwNL8xT8mgOhTKbqAfRX@zte.com.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307464-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:han.junyang@zte.com.cn,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:ran.ming@zte.com.cn,m:han.chengfei@zte.com.cn,m:zhang.yanze@zte.com.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zte.com.cn:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux-foundation.org:email,resnulli-us.20251104.gappssmtp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 17C35754F17

Mon, Jul 13, 2026 at 04:24:20PM +0200, han.junyang@zte.com.cn wrote:
>From: Junyang Han <han.junyang@zte.com.cn>
>
>Add basic framework for ZTE DingHai ethernet PF driver, including
>Kconfig/Makefile build support and PCIe device probe/remove skeleton.
>
>Signed-off-by: Junyang Han <han.junyang@zte.com.cn>
>---
> MAINTAINERS                               |   6 +
> drivers/net/ethernet/Kconfig              |   1 +
> drivers/net/ethernet/Makefile             |   1 +
> drivers/net/ethernet/zte/Kconfig          |  20 +++
> drivers/net/ethernet/zte/Makefile         |   6 +
> drivers/net/ethernet/zte/dinghai/Kconfig  |  34 ++++
> drivers/net/ethernet/zte/dinghai/Makefile |  10 ++
> drivers/net/ethernet/zte/dinghai/en_pf.c  | 195 ++++++++++++++++++++++
> drivers/net/ethernet/zte/dinghai/en_pf.h  |  52 ++++++
> 9 files changed, 325 insertions(+)
> create mode 100644 drivers/net/ethernet/zte/Kconfig
> create mode 100644 drivers/net/ethernet/zte/Makefile
> create mode 100644 drivers/net/ethernet/zte/dinghai/Kconfig
> create mode 100644 drivers/net/ethernet/zte/dinghai/Makefile
> create mode 100644 drivers/net/ethernet/zte/dinghai/en_pf.c
> create mode 100644 drivers/net/ethernet/zte/dinghai/en_pf.h
>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 2fb1c75afd16..73692b09bf7b 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -29440,6 +29440,12 @@ S:	Maintained
> T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
> F:	sound/hda/codecs/senarytech.c
>
>+ZTE DINGHAI ETHERNET DRIVER
>+M:	Junyang Han <han.junyang@zte.com.cn>
>+L:	netdev@vger.kernel.org
>+S:	Maintained
>+F:	drivers/net/ethernet/zte/
>+
> THE REST
> M:	Linus Torvalds <torvalds@linux-foundation.org>
> L:	linux-kernel@vger.kernel.org
>diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
>index b8f70e2a1763..c2b6996b0cfe 100644
>--- a/drivers/net/ethernet/Kconfig
>+++ b/drivers/net/ethernet/Kconfig
>@@ -188,5 +188,6 @@ source "drivers/net/ethernet/wangxun/Kconfig"
> source "drivers/net/ethernet/wiznet/Kconfig"
> source "drivers/net/ethernet/xilinx/Kconfig"
> source "drivers/net/ethernet/xircom/Kconfig"
>+source "drivers/net/ethernet/zte/Kconfig"
>
> endif # ETHERNET
>diff --git a/drivers/net/ethernet/Makefile b/drivers/net/ethernet/Makefile
>index 57344fec6ce0..a34bcbd4df4e 100644
>--- a/drivers/net/ethernet/Makefile
>+++ b/drivers/net/ethernet/Makefile
>@@ -104,3 +104,4 @@ obj-$(CONFIG_NET_VENDOR_XIRCOM) += xircom/
> obj-$(CONFIG_NET_VENDOR_SYNOPSYS) += synopsys/
> obj-$(CONFIG_NET_VENDOR_PENSANDO) += pensando/
> obj-$(CONFIG_OA_TC6) += oa_tc6.o
>+obj-$(CONFIG_NET_VENDOR_ZTE) += zte/
>diff --git a/drivers/net/ethernet/zte/Kconfig b/drivers/net/ethernet/zte/Kconfig
>new file mode 100644
>index 000000000000..b95c2fc7db77
>--- /dev/null
>+++ b/drivers/net/ethernet/zte/Kconfig
>@@ -0,0 +1,20 @@
>+# SPDX-License-Identifier: GPL-2.0-only
>+#
>+# ZTE driver configuration
>+#
>+
>+config NET_VENDOR_ZTE
>+    bool "ZTE devices"
>+    default y
>+    help
>+      If you have a network (Ethernet) card belonging to this class, say Y.
>+      Note that the answer to this question doesn't directly affect the
>+      kernel: saying N will just cause the configurator to skip all
>+      the questions about Zte cards. If you say Y, you will be asked
>+      for your specific card in the following questions.
>+
>+if NET_VENDOR_ZTE
>+
>+source "drivers/net/ethernet/zte/dinghai/Kconfig"
>+
>+endif # NET_VENDOR_ZTE
>diff --git a/drivers/net/ethernet/zte/Makefile b/drivers/net/ethernet/zte/Makefile
>new file mode 100644
>index 000000000000..cd9929b61559
>--- /dev/null
>+++ b/drivers/net/ethernet/zte/Makefile
>@@ -0,0 +1,6 @@
>+# SPDX-License-Identifier: GPL-2.0-only
>+#
>+# Makefile for the ZTE device drivers
>+#
>+
>+obj-$(CONFIG_DINGHAI) += dinghai/
>diff --git a/drivers/net/ethernet/zte/dinghai/Kconfig b/drivers/net/ethernet/zte/dinghai/Kconfig
>new file mode 100644
>index 000000000000..121be3bf7707
>--- /dev/null
>+++ b/drivers/net/ethernet/zte/dinghai/Kconfig
>@@ -0,0 +1,34 @@
>+# SPDX-License-Identifier: GPL-2.0-only
>+#
>+# ZTE DingHai Ethernet driver configuration
>+#
>+
>+config DINGHAI
>+    bool "ZTE DingHai Ethernet driver"
>+    depends on PCI
>+    select NET_DEVLINK
>+    help
>+      This driver supports ZTE DingHai Ethernet devices.
>+
>+      DingHai is a high-performance Ethernet controller that supports
>+      multiple features including hardware offloading, SR-IOV, and
>+      advanced virtualization capabilities.
>+
>+      If you say Y here, you can select specific driver variants below.
>+
>+      If unsure, say N.
>+
>+if DINGHAI
>+
>+config DINGHAI_PF
>+    tristate "ZTE DingHai PF (Physical Function) driver"
>+    help
>+      This driver supports ZTE DingHai PCI Express Ethernet
>+      adapters (PF).
>+
>+      To compile this driver as a module, choose M here. The module
>+      will be named dinghai10e.
>+
>+      If unsure, say N.
>+
>+endif # DINGHAI
>diff --git a/drivers/net/ethernet/zte/dinghai/Makefile b/drivers/net/ethernet/zte/dinghai/Makefile
>new file mode 100644
>index 000000000000..f55a8de518be
>--- /dev/null
>+++ b/drivers/net/ethernet/zte/dinghai/Makefile
>@@ -0,0 +1,10 @@
>+# SPDX-License-Identifier: GPL-2.0-only
>+#
>+# Makefile for ZTE DingHai Ethernet driver
>+#
>+
>+ccflags-y += -I$(src)
>+
>+obj-$(CONFIG_DINGHAI_PF) += dinghai10e.o
>+dinghai10e-y := en_pf.o
>+
>diff --git a/drivers/net/ethernet/zte/dinghai/en_pf.c b/drivers/net/ethernet/zte/dinghai/en_pf.c
>new file mode 100644
>index 000000000000..034b8519a71c
>--- /dev/null
>+++ b/drivers/net/ethernet/zte/dinghai/en_pf.c
>@@ -0,0 +1,195 @@
>+// SPDX-License-Identifier: GPL-2.0-only
>+/*
>+ * ZTE DingHai Ethernet driver
>+ * Copyright (c) 2022-2026, ZTE Corporation.
>+ */
>+
>+#include <linux/module.h>
>+#include <linux/pci.h>
>+#include <net/devlink.h>
>+#include <linux/dma-mapping.h>
>+#include "en_pf.h"
>+
>+MODULE_AUTHOR("Junyang Han <han.junyang@zte.com.cn>");
>+MODULE_DESCRIPTION("ZTE DingHai series Ethernet driver");
>+MODULE_LICENSE("GPL");
>+
>+static const struct devlink_ops dh_pf_devlink_ops = {};
>+
>+static const struct pci_device_id dh_pf_pci_table[] = {
>+	{ PCI_DEVICE(ZXDH_PF_VENDOR_ID, ZXDH_PF_DEVICE_ID) },
>+	{ PCI_DEVICE(ZXDH_PF_VENDOR_ID, ZXDH_VF_DEVICE_ID) },
>+	{ }
>+};
>+
>+MODULE_DEVICE_TABLE(pci, dh_pf_pci_table);
>+
>+void *dh_core_alloc_priv(struct dh_core_dev *dh_dev, size_t size)
>+{
>+	void *priv = kzalloc(size, GFP_KERNEL);
>+
>+	if (priv)
>+		dh_dev->priv = priv;
>+	return priv;
>+}
>+
>+void dh_core_free_priv(struct dh_core_dev *dh_dev)
>+{
>+	kfree(dh_dev->priv);
>+}
>+
>+static int dh_pf_pci_init(struct dh_core_dev *dev)
>+{
>+	struct zxdh_pf_device *pf_dev = dev->priv;
>+	int ret;
>+
>+	pci_set_drvdata(dev->pdev, dev);
>+
>+	ret = pci_enable_device(dev->pdev);
>+	if (ret) {
>+		dev_err(dev->device, "pci_enable_device failed: %d\n", ret);
>+		return ret;
>+	}
>+
>+	ret = dma_set_mask_and_coherent(dev->device, DMA_BIT_MASK(64));
>+	if (ret) {
>+		ret = dma_set_mask_and_coherent(dev->device, DMA_BIT_MASK(32));
>+		if (ret) {
>+			dev_err(dev->device, "dma_set_mask_and_coherent failed: %d\n", ret);
>+			goto err_pci;
>+		}
>+	}
>+
>+	ret = pci_request_selected_regions(dev->pdev,
>+					   pci_select_bars(dev->pdev, IORESOURCE_MEM),
>+					   "dh-pf");
>+	if (ret) {
>+		dev_err(dev->device, "pci_request_selected_regions failed: %d\n", ret);
>+		goto err_pci;
>+	}
>+
>+	pci_set_master(dev->pdev);
>+	ret = pci_save_state(dev->pdev);
>+	if (ret) {
>+		dev_err(dev->device, "pci_save_state failed: %d\n", ret);
>+		goto err_pci_save_state;
>+	}
>+
>+	if (!(pci_resource_flags(dev->pdev, 0) & IORESOURCE_MEM)) {
>+		ret = -ENODEV;
>+		dev_err(dev->device, "BAR 0 is not an MMIO resource\n");
>+		goto err_pci_save_state;
>+	}
>+
>+	pf_dev->pci_ioremap_addr[0] =
>+		ioremap(pci_resource_start(dev->pdev, 0),
>+			pci_resource_len(dev->pdev, 0));
>+	if (!pf_dev->pci_ioremap_addr[0]) {
>+		ret = -ENOMEM;
>+		dev_err(dev->device, "dh pf pci ioremap failed\n");
>+		goto err_pci_save_state;
>+	}
>+
>+	return 0;
>+
>+err_pci_save_state:
>+	pci_release_selected_regions(dev->pdev,
>+				     pci_select_bars(dev->pdev, IORESOURCE_MEM));
>+err_pci:
>+	pci_disable_device(dev->pdev);
>+	return ret;
>+}
>+
>+void dh_pf_pci_close(struct dh_core_dev *dev)
>+{
>+	struct zxdh_pf_device *pf_dev = dev->priv;
>+
>+	iounmap(pf_dev->pci_ioremap_addr[0]);
>+	pci_release_selected_regions(dev->pdev,
>+				     pci_select_bars(dev->pdev, IORESOURCE_MEM));
>+	pci_disable_device(dev->pdev);
>+}
>+
>+static int dh_pf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>+{
>+	struct zxdh_pf_device *pf_dev;
>+	struct dh_core_dev *dh_dev;
>+	struct devlink *devlink;
>+	int ret;
>+
>+	devlink = devlink_alloc(&dh_pf_devlink_ops, sizeof(struct dh_core_dev),
>+				&pdev->dev);
>+	if (!devlink) {
>+		dev_err(&pdev->dev, "dh_pf devlink alloc failed\n");
>+		return -ENOMEM;
>+	}
>+
>+	dh_dev = devlink_priv(devlink);
>+	dh_dev->device = &pdev->dev;
>+	dh_dev->pdev = pdev;
>+	dh_dev->devlink = devlink;
>+
>+	pf_dev = dh_core_alloc_priv(dh_dev, sizeof(*pf_dev));

Does not make any sense to me. Why you don't just merge struct
dh_core_dev and zxdh_pf_device. Why dh_core_dev contains *priv pointer?

What puzzles me is the naming of funct structs:
dh_core*
dh_pf*
zxdh_pf*

Could they all be dh_pf* perhaps?

Then inconsistencies like "_dev", "_device" etc. Please try to be
consitent with names. Makes the code easier to follow.


>+	if (!pf_dev) {
>+		dev_err(&pdev->dev, "dh_pf_dev alloc failed\n");
>+		ret = -ENOMEM;
>+		goto err_pf_dev;
>+	}
>+
>+	pf_dev->bar_chan_valid = false;
>+	pf_dev->vepa = false;
>+	mutex_init(&dh_dev->lock);
>+	mutex_init(&pf_dev->irq_lock);
>+
>+	dh_dev->coredev_type = GET_COREDEV_TYPE(pdev);
>+
>+	ret = dh_pf_pci_init(dh_dev);
>+	if (ret) {
>+		dev_err(&pdev->dev, "dh_pf_pci_init failed: %d\n", ret);
>+		goto err_cfg_init;
>+	}
>+
>+	devlink_register(devlink);
>+
>+	return 0;
>+
>+err_cfg_init:
>+	mutex_destroy(&pf_dev->irq_lock);
>+	mutex_destroy(&dh_dev->lock);
>+	dh_core_free_priv(dh_dev);
>+err_pf_dev:
>+	devlink_free(devlink);
>+	return ret;
>+}
>+
>+static void dh_pf_remove(struct pci_dev *pdev)
>+{
>+	struct dh_core_dev *dh_dev = pci_get_drvdata(pdev);
>+	struct devlink *devlink = priv_to_devlink(dh_dev);
>+	struct zxdh_pf_device *pf_dev = dh_dev->priv;
>+
>+	devlink_unregister(devlink);
>+	dh_pf_pci_close(dh_dev);
>+	mutex_destroy(&pf_dev->irq_lock);
>+	mutex_destroy(&dh_dev->lock);
>+	dh_core_free_priv(dh_dev);
>+	devlink_free(devlink);
>+	pci_set_drvdata(pdev, NULL);
>+}
>+
>+static void dh_pf_shutdown(struct pci_dev *pdev)
>+{
>+	if (system_state == SYSTEM_POWER_OFF)
>+		pci_set_power_state(pdev, PCI_D3hot);
>+	pci_disable_device(pdev);
>+}
>+
>+static struct pci_driver dh_pf_driver = {
>+	.name = "dinghai10e",
>+	.id_table = dh_pf_pci_table,
>+	.probe = dh_pf_probe,
>+	.remove = dh_pf_remove,
>+	.shutdown = dh_pf_shutdown,
>+};
>+
>+module_pci_driver(dh_pf_driver);
>diff --git a/drivers/net/ethernet/zte/dinghai/en_pf.h b/drivers/net/ethernet/zte/dinghai/en_pf.h
>new file mode 100644
>index 000000000000..87fa29b2d13d
>--- /dev/null
>+++ b/drivers/net/ethernet/zte/dinghai/en_pf.h
>@@ -0,0 +1,52 @@
>+/* SPDX-License-Identifier: GPL-2.0-only */
>+/*
>+ * ZTE DingHai Ethernet driver - PF header
>+ * Copyright (c) 2022-2026, ZTE Corporation.
>+ */
>+
>+#ifndef __ZXDH_EN_PF_H__
>+#define __ZXDH_EN_PF_H__
>+
>+#include <linux/types.h>
>+#include <linux/pci.h>
>+#include <linux/mutex.h>
>+#include <linux/device.h>
>+#include <linux/slab.h>
>+
>+#define ZXDH_PF_VENDOR_ID	0x1cf2
>+#define ZXDH_PF_DEVICE_ID	0x8040
>+#define ZXDH_VF_DEVICE_ID	0x8041
>+
>+enum dh_coredev_type {
>+	DH_COREDEV_PF,
>+	DH_COREDEV_VF,
>+	DH_COREDEV_SF,
>+	DH_COREDEV_MPF
>+};
>+
>+struct devlink;
>+
>+struct dh_core_dev {
>+	struct device *device;
>+	enum dh_coredev_type coredev_type;
>+	struct pci_dev *pdev;
>+	struct devlink *devlink;
>+	struct mutex lock; /* Protects device configuration */
>+	void *priv;
>+};
>+
>+struct zxdh_pf_device {
>+	void __iomem *pci_ioremap_addr[6];
>+	bool bar_chan_valid;
>+	bool vepa;
>+	struct mutex irq_lock; /* Protects IRQ operations */
>+};
>+
>+#define GET_COREDEV_TYPE(pdev) \
>+	((pdev)->device == ZXDH_VF_DEVICE_ID ? DH_COREDEV_VF : DH_COREDEV_PF)
>+
>+void *dh_core_alloc_priv(struct dh_core_dev *dh_dev, size_t size);
>+void dh_core_free_priv(struct dh_core_dev *dh_dev);
>+void dh_pf_pci_close(struct dh_core_dev *dev);
>+
>+#endif /* __ZXDH_EN_PF_H__ */
>-- 
>2.27.0
>

