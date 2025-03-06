Return-Path: <netdev+bounces-172657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD91A55A84
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 00:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B5A71896007
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 23:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1051C27CCE3;
	Thu,  6 Mar 2025 23:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enfabrica.net header.i=@enfabrica.net header.b="JAg5nyfN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619A5279349
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 23:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741302242; cv=none; b=Ea2619UqaDXZI3gq7fCvXtAl/38g0ayJISFECOzkBRfY1RDNaRPKSgM6cvYRGVBjPnSAZGhkekqFifmLSQd2IIvXj1/LlpQgXQzdOJiHrTUbAHZBUA8EC0Fm34jEBQUcVoYSVVrPp1vNm+MljiDGHfl2rDyWC9YpZwXNIg1yqmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741302242; c=relaxed/simple;
	bh=A9mobOvuIeF00fIfjCqC9uNVWIrG6j7W2+rdHsW6dwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JRNj4y1sanPhD2Kzg4dWmUtEzVwihXoeUZfqg6YdhFdo45RcuTq+C1mvHnl2eXMhhhaLTdSM9Iy9X/XptLW2vy8jZFMioQn45HOAWhGTiRqQHUCk1dXg1GfOCqD/2yOpRkA8mnUERgHDhF07DfhRDDv74OfGuMZTuRemrqxqJU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enfabrica.net; spf=pass smtp.mailfrom=enfabrica.net; dkim=pass (2048-bit key) header.d=enfabrica.net header.i=@enfabrica.net header.b=JAg5nyfN; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enfabrica.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enfabrica.net
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6e8f254b875so9606796d6.1
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 15:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=enfabrica.net; s=google; t=1741302239; x=1741907039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WdHcT+hSCoYTik958njnGQie2UZi8YbiCIJN/dVy/UQ=;
        b=JAg5nyfN5RaHuEntmBdUUTuczyCp7OYwxGwEeYFUtP4PxZRfWe4epLXmfUtpeNFrmh
         tn5nn65djzlxI93yakBkU+bvlEf1+nRy00RFlSoFP/ZtFxF1m7cnuUz4cIgQy4qruqFs
         s5I15mCxKpf8w1utGm+BrZuaCmTEJgQqQ6Wo10j4GhDjlZ35bZkunem6EI80D/TXMhGN
         fRNyJfZrzJ2+p+VcDUQmk4oEMdgaWjMXhfP3Mtg5DqhiqMH+f930EBOZeSgarB1jTVva
         zKMSCdYjnbms4JQ1WeqDE686761kovjU8tZNJZNrF1wAYqVw7r0gIpUupSxtFTTQ75zE
         865g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741302239; x=1741907039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WdHcT+hSCoYTik958njnGQie2UZi8YbiCIJN/dVy/UQ=;
        b=KJKPjIeyjYMSD1W9ZqLzhjbKiKR6SDG1GwaN+2j2Uc/quGMdvH1lfrHP7Twu46bYF3
         Q0kBaoKOJDuD5YjAN048T83wscnENnoQmu6DKi8dy38b7iWMf5Xw8twWt3GK/CqlzXpW
         ebUMn3X3cxWDyeM3u6V1K++wHu9NxDVm57Lf60xqDYzrLplXrwVdQbLNEtoWumGMACz6
         D79U+833oCZqKV43fU0V/cDlT83tl7NFJnbdMvdzIt7O1ekPO/rh7oPlSwbBX43SxJMW
         wVyGBEETm+PdrYbKLNNm6jB9C9m0UVg7gRspZbTSbpKq6Ad1iFt7O/TGXwO4j6Z4X4MU
         P/+Q==
X-Gm-Message-State: AOJu0YzIuLGBQhyLCxZBSoxq10JZ+VL/lcM4LcQ6uKk96EOMdmzayowS
	+oP9oWkUCztsVy514bVq1IYH079RjQsxB31lGSoOvXVuqm+EFTkB5WSCyBHu0Dt4E51MehNRmvp
	sRQYopVITte9RzZNPmtfwBmhMJIz7sMtg6QJn++RbygeUe2tyI5GSh9Au0TYPcgiaylPl8SGD3K
	YHs0JJUEx5iYd55MeV83F5y11hABph3fSV3iQTbf+AUN8=
X-Gm-Gg: ASbGncuB6tMU933WARqhsGQ6VCAd1k6xVtPo6btL6cz94cIgqlBd2jTZCe19ijZb1AR
	oNw1/9SDJfFHl2bxfKf3k/NAnym/eEO5wo3qJ4T3ToctObXqVP4jPlhj3jqoxdGazmBi5R9fdFT
	yCRuaPMZ4VRUCovnCtZe5QGssvL3m5nGIN14ay6OAqIdULjPJ1SODbyDMRBAShBh1PgN0FVhrSe
	bjsSDedrQo8CScCzznEL0nix/oEWkQ8d7hPq3ODuI5wPoO5aaVxk7aLD5SjQMf5Fs3Xd7/o6+BZ
	635oRK+obhKyIXyFc4nFDhHbCo7Ib/Fv8tdx/XVKTRZPeDpNC5Z9DqgQDyYYjFSqnAG/
X-Google-Smtp-Source: AGHT+IF1kfGspX38JaOE5QuV2pL9LaOd4NlYMWkRbiYsvXZp2jxSiWbyI1svMuCu7yxj+68lLI/tfg==
X-Received: by 2002:ad4:5d49:0:b0:6e8:fbb7:6764 with SMTP id 6a1803df08f44-6e9006ba2fbmr13156446d6.45.1741302239103;
        Thu, 06 Mar 2025 15:03:59 -0800 (PST)
Received: from debil.. (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac256654fa6sm14971966b.93.2025.03.06.15.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 15:03:58 -0800 (PST)
From: Nikolay Aleksandrov <nikolay@enfabrica.net>
To: netdev@vger.kernel.org
Cc: shrijeet@enfabrica.net,
	alex.badea@keysight.com,
	eric.davis@broadcom.com,
	rip.sohan@amd.com,
	dsahern@kernel.org,
	bmt@zurich.ibm.com,
	roland@enfabrica.net,
	nikolay@enfabrica.net,
	winston.liu@keysight.com,
	dan.mihailescu@keysight.com,
	kheib@redhat.com,
	parth.v.parikh@keysight.com,
	davem@redhat.com,
	ian.ziemba@hpe.com,
	andrew.tauferner@cornelisnetworks.com,
	welch@hpe.com,
	rakhahari.bhunia@keysight.com,
	kingshuk.mandal@keysight.com,
	linux-rdma@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [RFC PATCH 01/13] drivers: ultraeth: add initial skeleton and kconfig option
Date: Fri,  7 Mar 2025 01:01:51 +0200
Message-ID: <20250306230203.1550314-2-nikolay@enfabrica.net>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306230203.1550314-1-nikolay@enfabrica.net>
References: <20250306230203.1550314-1-nikolay@enfabrica.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create drivers/ultraeth/ for the upcoming new Ultra Ethernet driver and add
a new Kconfig option for it.

Signed-off-by: Nikolay Aleksandrov <nikolay@enfabrica.net>
Signed-off-by: Alex Badea <alex.badea@keysight.com>
---
 drivers/Kconfig             |  2 ++
 drivers/Makefile            |  1 +
 drivers/ultraeth/Kconfig    | 11 +++++++++++
 drivers/ultraeth/Makefile   |  3 +++
 drivers/ultraeth/uet_main.c | 19 +++++++++++++++++++
 5 files changed, 36 insertions(+)
 create mode 100644 drivers/ultraeth/Kconfig
 create mode 100644 drivers/ultraeth/Makefile
 create mode 100644 drivers/ultraeth/uet_main.c

diff --git a/drivers/Kconfig b/drivers/Kconfig
index 7bdad836fc62..df3369781d37 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -245,4 +245,6 @@ source "drivers/cdx/Kconfig"
 
 source "drivers/dpll/Kconfig"
 
+source "drivers/ultraeth/Kconfig"
+
 endmenu
diff --git a/drivers/Makefile b/drivers/Makefile
index 45d1c3e630f7..47848677605a 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -195,3 +195,4 @@ obj-$(CONFIG_CDX_BUS)		+= cdx/
 obj-$(CONFIG_DPLL)		+= dpll/
 
 obj-$(CONFIG_S390)		+= s390/
+obj-$(CONFIG_ULTRAETH)		+= ultraeth/
diff --git a/drivers/ultraeth/Kconfig b/drivers/ultraeth/Kconfig
new file mode 100644
index 000000000000..a769c6118f2f
--- /dev/null
+++ b/drivers/ultraeth/Kconfig
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config ULTRAETH
+	tristate "Ultra Ethernet core"
+	depends on INET
+	depends on IPV6 || !IPV6
+	select NET_UDP_TUNNEL
+	select GRO_CELLS
+	help
+	  To compile this driver as a module, choose M here: the module
+	  will be called ultraeth.
diff --git a/drivers/ultraeth/Makefile b/drivers/ultraeth/Makefile
new file mode 100644
index 000000000000..e30373d4b5dc
--- /dev/null
+++ b/drivers/ultraeth/Makefile
@@ -0,0 +1,3 @@
+obj-$(CONFIG_ULTRAETH) += ultraeth.o
+
+ultraeth-objs := uet_main.o
diff --git a/drivers/ultraeth/uet_main.c b/drivers/ultraeth/uet_main.c
new file mode 100644
index 000000000000..0d74175fc047
--- /dev/null
+++ b/drivers/ultraeth/uet_main.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/types.h>
+
+static int __init uet_init(void)
+{
+	return 0;
+}
+
+static void __exit uet_exit(void)
+{
+}
+
+module_init(uet_init);
+module_exit(uet_exit);
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Ultra Ethernet core");
-- 
2.48.1


