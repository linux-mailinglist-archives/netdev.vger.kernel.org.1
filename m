Return-Path: <netdev+bounces-191232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F4CABA73B
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 02:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6894E1C0089A
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 00:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7929920B22;
	Sat, 17 May 2025 00:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R9/+X0iG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB56910E0
	for <netdev@vger.kernel.org>; Sat, 17 May 2025 00:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747440686; cv=none; b=o47vXV7gh6QtctqmxODgJcCbO4IzSOaxrjGDhhs8fOU7aQ+0HiXHAPJjjl5LQBvV7Cch3AnF6NWaAR/3zBqvJVMcyfRKTMFMb41FKINmfYCLBNyaHZrN1yODyLHHfTaZ3xn2bZrG5cQNnjypkfHINaEY0XCgPSVdzFS232fdsFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747440686; c=relaxed/simple;
	bh=9wz9A6ZhWnv4sHTAE+Yi2UtRzAuqbl9I6dfwSAE0DSc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cf0YU3tNMI0aeUS4ZJgGoABKWcNfiEkPMPGPJ0p+aUke2hfsuW6RVL0tzMo2WlSfgxhX3G6BmTF5sM0+V0Xiy0vin2En2JFZWQ7UVMvmHWYXcIH8i6P8dArYMPSlFSQe2XyseKP8fZXC36fYG9SMGDgZRCOsbtDTyszEIyGGUw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R9/+X0iG; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30e8346b49cso1099920a91.0
        for <netdev@vger.kernel.org>; Fri, 16 May 2025 17:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747440684; x=1748045484; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Oy26cfCmc6sp3CkrnhJzJ5Gv1rNunR4QAXWZSb4CvI=;
        b=R9/+X0iGXUD+ZsTSdGOsMRO8w6FCrW36qpetZmGBMe40aJxeUf5ZduYOzRvQdgst8l
         LkiaCjTlaxex4XgimXc084a9PXjqlZ0cHUUF4tKQUoZH0fi7mih7Po0dSJ4LCzGeYYMx
         6fC9bzXFIFgSz7WiuNcY3F6xE8ECjH+wSy6XX+3+g2NQc1SFsBt7+E7bkKstXhPxAO98
         mX/QMsrgMXUyqbOGIYWbwarT1Rm/JXCHStD17cH60meiaVdpXyrpLu5RP2hUX5DPXuqn
         hVET5CqdwFlNfG4l/0Qk5XasJNFoT3BijAswTlNWmHlbyAqF/bX46bZzqxnAkK/KIEGx
         F9lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747440684; x=1748045484;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Oy26cfCmc6sp3CkrnhJzJ5Gv1rNunR4QAXWZSb4CvI=;
        b=QrJgNeGVx63zfqJis4xssBvhI/SqHY6Hs/INgigh0MMMs8lSTPsvU9T7DJjTS/mXfT
         IIsxK8JUpKfHV0qhF904Sk0uhoMAIgu9zKc30kO8oXMpmBPN4SOoKgOrF5yD8sIZA4qE
         tkOXgjvii65UbfX+OGFJZMJA1UHGejIWr9k/8h1LDCDAh0ltxnKSpQ1gBETWNtmkz0T+
         Wd7GncGAF0o0cp+7FqqFiKvpGMe27OcA1tXpaEelOmp2ISFrBaL/rRcZOetkF7iWo4Zv
         sRS37PZUtOpub+45Z6fNJxoi5KmhuKmlxUScQyyhfvx58K4TWc9B5F2v6X443IPDRD1Z
         wlaA==
X-Gm-Message-State: AOJu0YxCHsJAOJXEwiydB4Ee0fcxj5TOKWng5qxWFis+46RMMpMpneKJ
	HLSrukjso9kbd8gwX5MRD9HbrMbRqDRvu4sKOAeLnQGaoBv+kWmZiZ9pbZoUY2U9QS/b8A4yVm2
	wlaK4+Q4j3kMYNh5KfTuqarde7faxO0OWkbhMvAfUESCpOwxso7JoQoGTRajRCK+lTeDHnj49Cm
	5XEUpCWX+MYMXdH0Y+qrAfbUiPgOLd9QGBefpaDHbbHmslZ7VlkgLlG0u2WCZYlaE=
X-Google-Smtp-Source: AGHT+IHirGqqBdLOW0UfuLcd5oRFp90PeaPE75634MGtyiblMRSPxGVoC5Lkl4bsP25R43acec8mGLqZ/Iov6PAPyg==
X-Received: from pjbpv7.prod.google.com ([2002:a17:90b:3c87:b0:301:1ea9:63b0])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3c90:b0:30e:37be:6963 with SMTP id 98e67ed59e1d1-30e83228d1cmr7043404a91.29.1747440684049;
 Fri, 16 May 2025 17:11:24 -0700 (PDT)
Date: Sat, 17 May 2025 00:11:05 +0000
In-Reply-To: <20250517001110.183077-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250517001110.183077-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <20250517001110.183077-4-hramamurthy@google.com>
Subject: [PATCH net-next v2 3/8] gve: Add initial PTP device support
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, jeroendb@google.com, hramamurthy@google.com, 
	andrew+netdev@lunn.ch, willemb@google.com, ziweixiao@google.com, 
	pkaligineedi@google.com, yyd@google.com, joshwash@google.com, 
	shailend@google.com, linux@treblig.org, thostet@google.com, 
	jfraker@google.com, richardcochran@gmail.com, jdamato@fastly.com, 
	vadim.fedorenko@linux.dev, horms@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If the device supports reading of the nic clock, add support
to initialize and register the PTP clock.

Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/Kconfig       |  1 +
 drivers/net/ethernet/google/gve/Makefile  |  4 +-
 drivers/net/ethernet/google/gve/gve.h     |  8 +++
 drivers/net/ethernet/google/gve/gve_ptp.c | 59 +++++++++++++++++++++++
 4 files changed, 71 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/google/gve/gve_ptp.c

diff --git a/drivers/net/ethernet/google/Kconfig b/drivers/net/ethernet/google/Kconfig
index 564862a57124..14c9431e15e5 100644
--- a/drivers/net/ethernet/google/Kconfig
+++ b/drivers/net/ethernet/google/Kconfig
@@ -18,6 +18,7 @@ if NET_VENDOR_GOOGLE
 config GVE
 	tristate "Google Virtual NIC (gVNIC) support"
 	depends on (PCI_MSI && (X86 || CPU_LITTLE_ENDIAN))
+	depends on PTP_1588_CLOCK_OPTIONAL
 	select PAGE_POOL
 	help
 	  This driver supports Google Virtual NIC (gVNIC)"
diff --git a/drivers/net/ethernet/google/gve/Makefile b/drivers/net/ethernet/google/gve/Makefile
index 4520f1c07a63..e0ec227a50f7 100644
--- a/drivers/net/ethernet/google/gve/Makefile
+++ b/drivers/net/ethernet/google/gve/Makefile
@@ -1,5 +1,7 @@
 # Makefile for the Google virtual Ethernet (gve) driver
 
 obj-$(CONFIG_GVE) += gve.o
-gve-objs := gve_main.o gve_tx.o gve_tx_dqo.o gve_rx.o gve_rx_dqo.o gve_ethtool.o gve_adminq.o gve_utils.o gve_flow_rule.o \
+gve-y := gve_main.o gve_tx.o gve_tx_dqo.o gve_rx.o gve_rx_dqo.o gve_ethtool.o gve_adminq.o gve_utils.o gve_flow_rule.o \
 	    gve_buffer_mgmt_dqo.o
+
+gve-$(CONFIG_PTP_1588_CLOCK) += gve_ptp.o
diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index cf6947731a9b..8d2aa654fd4c 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -12,6 +12,7 @@
 #include <linux/ethtool_netlink.h>
 #include <linux/netdevice.h>
 #include <linux/pci.h>
+#include <linux/ptp_clock_kernel.h>
 #include <linux/u64_stats_sync.h>
 #include <net/page_pool/helpers.h>
 #include <net/xdp.h>
@@ -750,6 +751,12 @@ struct gve_rss_config {
 	u32 *hash_lut;
 };
 
+struct gve_ptp {
+	struct ptp_clock_info info;
+	struct ptp_clock *clock;
+	struct gve_priv *priv;
+};
+
 struct gve_priv {
 	struct net_device *dev;
 	struct gve_tx_ring *tx; /* array of tx_cfg.num_queues */
@@ -874,6 +881,7 @@ struct gve_priv {
 
 	/* True if the device supports reading the nic clock */
 	bool nic_timestamp_supported;
+	struct gve_ptp *ptp;
 };
 
 enum gve_service_task_flags_bit {
diff --git a/drivers/net/ethernet/google/gve/gve_ptp.c b/drivers/net/ethernet/google/gve/gve_ptp.c
new file mode 100644
index 000000000000..293f8dd49afe
--- /dev/null
+++ b/drivers/net/ethernet/google/gve/gve_ptp.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/* Google virtual Ethernet (gve) driver
+ *
+ * Copyright (C) 2025 Google LLC
+ */
+
+#include "gve.h"
+
+static const struct ptp_clock_info gve_ptp_caps = {
+	.owner          = THIS_MODULE,
+	.name		= "gve clock",
+};
+
+static int __maybe_unused gve_ptp_init(struct gve_priv *priv)
+{
+	struct gve_ptp *ptp;
+	int err;
+
+	if (!priv->nic_timestamp_supported) {
+		dev_dbg(&priv->pdev->dev, "Device does not support PTP\n");
+		return -EOPNOTSUPP;
+	}
+
+	priv->ptp = kzalloc(sizeof(*priv->ptp), GFP_KERNEL);
+	if (!priv->ptp)
+		return -ENOMEM;
+
+	ptp = priv->ptp;
+	ptp->info = gve_ptp_caps;
+	ptp->clock = ptp_clock_register(&ptp->info, &priv->pdev->dev);
+
+	if (IS_ERR(ptp->clock)) {
+		dev_err(&priv->pdev->dev, "PTP clock registration failed\n");
+		err  = PTR_ERR(ptp->clock);
+		goto free_ptp;
+	}
+
+	ptp->priv = priv;
+	return 0;
+
+free_ptp:
+	kfree(ptp);
+	priv->ptp = NULL;
+	return err;
+}
+
+static void __maybe_unused gve_ptp_release(struct gve_priv *priv)
+{
+	struct gve_ptp *ptp = priv->ptp;
+
+	if (!ptp)
+		return;
+
+	if (ptp->clock)
+		ptp_clock_unregister(ptp->clock);
+
+	kfree(ptp);
+	priv->ptp = NULL;
+}
-- 
2.49.0.1112.g889b7c5bd8-goog


