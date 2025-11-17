Return-Path: <netdev+bounces-239196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D5792C6582B
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 18:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1F46E35F27F
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 17:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C38F326D6A;
	Mon, 17 Nov 2025 17:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IeM2eJwQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f227.google.com (mail-pf1-f227.google.com [209.85.210.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7A430ACEA
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 17:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763399547; cv=none; b=JI3SBimPq0AtwvHAQJTj7ccyl26kY06HpkVncoQM8QI5BoESGKZzNtcJ5l0WervfJmEeOf87ZuUnjptVgrwm19/x6gqrQCtuK1JOWf+nnKI58ChbKkNZ0/HuL8AkfN1gzArEdTlaXrZSsUexoWTWoR48kvjRxSZ9f+xDFyf8lgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763399547; c=relaxed/simple;
	bh=ALAtK3sghBbxxJOjxjUOo6sRvxke1zc2axaOb8T5T80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uwKaIgXJNzIKbYbS7blsCBeu+g8MD3FK6foPVnOGi0V8p3NALXFEH/3cbeu578E/MlUnGjjaNNh36ziWSzJzJcraDOLJws0wvl4EYKewo1KeMIdIJKVNS13aHrph2MMY0hDDf8pru8Abw9mUwYJ3RqEE6bBUOE2sNmbBYGkkDS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=IeM2eJwQ; arc=none smtp.client-ip=209.85.210.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f227.google.com with SMTP id d2e1a72fcca58-7ad1cd0db3bso3844304b3a.1
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 09:12:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763399545; x=1764004345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dqAkTy4AdXnknLONc8taxeHkJmasigZAmZf7NrWPGbg=;
        b=kDH4vmGz+hx+feqNFyd/6Bx5NnIuo62HZ4qowlCg5TiVI9ivgvZNeBvsKRc6gyZZFr
         syWFF1FyOdjt3fEa0Xtc2QbUquvRuAtuNGJuDSy9DRPNPNTYEUbeiQyJ1BSD5Ya985SP
         qKXsG9aSwc2NepQykYpydScAf7KaKRBpOBQU3wmJtEaOSyFTR9glhyCVxkced0frYl5i
         G1pK0jBSYJ0dVsyAjo+ntMVXsObtuAZJh9J1IWXMq1gRLS/WBxrRtiKlMGckeTAG9rhg
         M6bgxiBjEtNRy2prVHoWC1ItcYc+xBJt9LDp5C6Gc+jgJblYS+UmhGAu4hk07j2Uyto+
         V0kg==
X-Forwarded-Encrypted: i=1; AJvYcCVnXzfYOKSflXIfhc8/51yynK0I0zQtyjJINc+gcJiCvfyWVsV7381y8M+yihplQELI1q4LVlo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoNKn7mqWnSsgllssqd11j4dtqHvGiz1JJ6NFp7y7HnG17bTTG
	jQjPfYUIl4oEbis/sSHW3bppYVCKtzM8Z9gWMqxsnPVHOCZNkJEnH8hJMdXLoGB+TDldWm01zqD
	iU+yq8TJjtQaYaBsGae/Om2YDbXQnw0IHTqB3/OwT3LBf6C7nJWR5YNzwPF6pbKzuUOiDP+RCKQ
	EyUlaAqKvM/b3WBI1NdqggGPdmeC4apvZoW6DoWkvveS8S3vow6YmLvXLsY/kMvdLM3J8lWs3B2
	gYUTRWysreA
X-Gm-Gg: ASbGncsvf/cOEV+s4OqzRleO/2nyO1Ym3Tv7SeHJHDV3k8zHzOqDplwQtkKNZ+HkuX4
	jXusKMQhzQP7dCGObUM2cMYjac6KiR6jmUKDMJdRtrrf5M+tu8xqWsevA3ql8VR5peA1Jv+5Ork
	vdILo9Te6mJx4Amw8N2I5yRVybOH9pet1qbauJI54iFPrPdtfRNLCefQ1M3ZqRlYMQNnOI5ex9U
	THZNXk5Q77E5/d+GMxXbcnb5w5bz4y8HxrL5HlIjboV7zIQsBrVBCHLnkeYCUC7Vox9u3v5pUZw
	u3wyaWU8vbiet8rJXbst8cYSscX0ycRvhnIOTVF7qOW7YfE6ISCkRUe99Dd+1Po9QSoSZ8LoBTE
	pshIPs0eufxLWeA1vlYNV44we0Uk8PBwkHMXvlbkcYWasTrQE2pM8LLjp7LwIXUDVBuKGMKzQ6t
	kox090gjy6ukYC0MZCerG7cmdEyUGXvGkQ
X-Google-Smtp-Source: AGHT+IH35xoxOkaCogpJqH5jhYbnh/QG4/rMIYhPJrz/qc+V+Dz4e2HoT6wATfrAYMSlLGrqNFkbv3IaWabh
X-Received: by 2002:a05:7022:221:b0:11b:2138:4758 with SMTP id a92af1059eb24-11b411fe7f5mr6646920c88.21.1763399543952;
        Mon, 17 Nov 2025 09:12:23 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-17.dlp.protect.broadcom.com. [144.49.247.17])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-2a49daf833fsm1326654eec.3.2025.11.17.09.12.23
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Nov 2025 09:12:23 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8823acf4db3so133939096d6.3
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 09:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1763399543; x=1764004343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dqAkTy4AdXnknLONc8taxeHkJmasigZAmZf7NrWPGbg=;
        b=IeM2eJwQsnPr1dYbK6URMjyIDox+Qqm2ecyHgrcaXPDu3HSjfOYYEv+pduMIJ9W1QP
         hwaWsSkcfTuSVYy2FGznQpSzNVhK4sCF3aXj/+8XLh1W65h1lht+A3MwiYRNCcvptGWB
         1GcQYUvlry0tc0nvEmH4DohWczpntUh83Eyvg=
X-Forwarded-Encrypted: i=1; AJvYcCUqVMhrp7tYCQXdsA5KvdZzq1GHniXFzqFC5Zje3vCYO/qiGwETmlHJ1LqCkJltZwqtukBcabA=@vger.kernel.org
X-Received: by 2002:a05:6214:cab:b0:880:5001:17d3 with SMTP id 6a1803df08f44-88292646ed9mr178660376d6.40.1763399542487;
        Mon, 17 Nov 2025 09:12:22 -0800 (PST)
X-Received: by 2002:a05:6214:cab:b0:880:5001:17d3 with SMTP id 6a1803df08f44-88292646ed9mr178659856d6.40.1763399541962;
        Mon, 17 Nov 2025 09:12:21 -0800 (PST)
Received: from sjs-csg-thor3-swe-29.lvn.broadcom.net044broadcom.net ([192.19.224.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88286314557sm96082236d6.20.2025.11.17.09.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 09:12:21 -0800 (PST)
From: Siva Reddy Kallam <siva.kallam@broadcom.com>
To: leonro@nvidia.com,
	jgg@nvidia.com
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	vikas.gupta@broadcom.com,
	selvin.xavier@broadcom.com,
	anand.subramanian@broadcom.com,
	usman.ansari@broadcom.com,
	Siva Reddy Kallam <siva.kallam@broadcom.com>
Subject: [PATCH v3 2/8] RDMA/bng_re: Add Auxiliary interface
Date: Mon, 17 Nov 2025 17:11:20 +0000
Message-ID: <20251117171136.128193-3-siva.kallam@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251117171136.128193-1-siva.kallam@broadcom.com>
References: <20251117171136.128193-1-siva.kallam@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=all
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Add basic Auxiliary interface to the driver which supports
the BCM5770X NIC family.

Signed-off-by: Siva Reddy Kallam <siva.kallam@broadcom.com>
Reviewed-by: Usman Ansari <usman.ansari@broadcom.com>
---
 MAINTAINERS                            |   7 ++
 drivers/infiniband/Kconfig             |   1 +
 drivers/infiniband/hw/Makefile         |   1 +
 drivers/infiniband/hw/bng_re/Kconfig   |  10 ++
 drivers/infiniband/hw/bng_re/Makefile  |   7 ++
 drivers/infiniband/hw/bng_re/bng_dev.c | 142 +++++++++++++++++++++++++
 drivers/infiniband/hw/bng_re/bng_re.h  |  27 +++++
 7 files changed, 195 insertions(+)
 create mode 100644 drivers/infiniband/hw/bng_re/Kconfig
 create mode 100644 drivers/infiniband/hw/bng_re/Makefile
 create mode 100644 drivers/infiniband/hw/bng_re/bng_dev.c
 create mode 100644 drivers/infiniband/hw/bng_re/bng_re.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 46126ce2f968..1f7aa2a3bec1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5191,6 +5191,13 @@ W:	http://www.broadcom.com
 F:	drivers/infiniband/hw/bnxt_re/
 F:	include/uapi/rdma/bnxt_re-abi.h
 
+BROADCOM 800 GIGABIT ROCE DRIVER
+M:	Siva Reddy Kallam <siva.kallam@broadcom.com>
+L:	linux-rdma@vger.kernel.org
+S:	Supported
+W:	http://www.broadcom.com
+F:	drivers/infiniband/hw/bng_re/
+
 BROADCOM NVRAM DRIVER
 M:	Rafał Miłecki <zajec5@gmail.com>
 L:	linux-mips@vger.kernel.org
diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
index f0323f1d6f01..794b9778816b 100644
--- a/drivers/infiniband/Kconfig
+++ b/drivers/infiniband/Kconfig
@@ -80,6 +80,7 @@ config INFINIBAND_VIRT_DMA
 if INFINIBAND_USER_ACCESS || !INFINIBAND_USER_ACCESS
 if !UML
 source "drivers/infiniband/hw/bnxt_re/Kconfig"
+source "drivers/infiniband/hw/bng_re/Kconfig"
 source "drivers/infiniband/hw/cxgb4/Kconfig"
 source "drivers/infiniband/hw/efa/Kconfig"
 source "drivers/infiniband/hw/erdma/Kconfig"
diff --git a/drivers/infiniband/hw/Makefile b/drivers/infiniband/hw/Makefile
index b706dc0d0263..c42b22ac3303 100644
--- a/drivers/infiniband/hw/Makefile
+++ b/drivers/infiniband/hw/Makefile
@@ -13,5 +13,6 @@ obj-$(CONFIG_INFINIBAND_HFI1)		+= hfi1/
 obj-$(CONFIG_INFINIBAND_HNS_HIP08)	+= hns/
 obj-$(CONFIG_INFINIBAND_QEDR)		+= qedr/
 obj-$(CONFIG_INFINIBAND_BNXT_RE)	+= bnxt_re/
+obj-$(CONFIG_INFINIBAND_BNG_RE)		+= bng_re/
 obj-$(CONFIG_INFINIBAND_ERDMA)		+= erdma/
 obj-$(CONFIG_INFINIBAND_IONIC)		+= ionic/
diff --git a/drivers/infiniband/hw/bng_re/Kconfig b/drivers/infiniband/hw/bng_re/Kconfig
new file mode 100644
index 000000000000..85845f72c64d
--- /dev/null
+++ b/drivers/infiniband/hw/bng_re/Kconfig
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config INFINIBAND_BNG_RE
+	tristate "Broadcom Next generation RoCE HCA support"
+	depends on 64BIT
+	depends on INET && DCB && BNGE
+	help
+	  This driver supports Broadcom Next generation
+	  50/100/200/400/800 gigabit RoCE HCAs. The module
+	  will be called bng_re. To compile this driver
+	  as a module, choose M here.
diff --git a/drivers/infiniband/hw/bng_re/Makefile b/drivers/infiniband/hw/bng_re/Makefile
new file mode 100644
index 000000000000..f854dae25b1c
--- /dev/null
+++ b/drivers/infiniband/hw/bng_re/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+
+ccflags-y := -I $(srctree)/drivers/net/ethernet/broadcom/bnge
+
+obj-$(CONFIG_INFINIBAND_BNG_RE) += bng_re.o
+
+bng_re-y := bng_dev.o
diff --git a/drivers/infiniband/hw/bng_re/bng_dev.c b/drivers/infiniband/hw/bng_re/bng_dev.c
new file mode 100644
index 000000000000..08aba72a26f7
--- /dev/null
+++ b/drivers/infiniband/hw/bng_re/bng_dev.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2025 Broadcom.
+
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/auxiliary_bus.h>
+
+#include <rdma/ib_verbs.h>
+
+#include "bng_re.h"
+#include "bnge.h"
+#include "bnge_auxr.h"
+
+static char version[] =
+		BNG_RE_DESC "\n";
+
+MODULE_AUTHOR("Siva Reddy Kallam <siva.kallam@broadcom.com>");
+MODULE_DESCRIPTION(BNG_RE_DESC);
+MODULE_LICENSE("Dual BSD/GPL");
+
+static struct bng_re_dev *bng_re_dev_add(struct auxiliary_device *adev,
+					 struct bnge_auxr_dev *aux_dev)
+{
+	struct bng_re_dev *rdev;
+
+	/* Allocate bng_re_dev instance */
+	rdev = ib_alloc_device(bng_re_dev, ibdev);
+	if (!rdev) {
+		ibdev_err(NULL, "%s: bng_re_dev allocation failure!",
+			  BNG_ROCE_DRV_MODULE_NAME);
+		return NULL;
+	}
+
+	/* Assign auxiliary device specific data */
+	rdev->netdev = aux_dev->net;
+	rdev->aux_dev = aux_dev;
+	rdev->adev = adev;
+	rdev->fn_id = rdev->aux_dev->pdev->devfn;
+
+	return rdev;
+}
+
+static int bng_re_add_device(struct auxiliary_device *adev)
+{
+	struct bnge_auxr_priv *auxr_priv =
+		container_of(adev, struct bnge_auxr_priv, aux_dev);
+	struct bng_re_en_dev_info *dev_info;
+	struct bng_re_dev *rdev;
+	int rc;
+
+	dev_info = auxiliary_get_drvdata(adev);
+
+	rdev = bng_re_dev_add(adev, auxr_priv->auxr_dev);
+	if (!rdev) {
+		rc = -ENOMEM;
+		goto exit;
+	}
+
+	dev_info->rdev = rdev;
+
+	return 0;
+exit:
+	return rc;
+}
+
+
+static void bng_re_remove_device(struct bng_re_dev *rdev,
+				 struct auxiliary_device *aux_dev)
+{
+	ib_dealloc_device(&rdev->ibdev);
+}
+
+
+static int bng_re_probe(struct auxiliary_device *adev,
+			const struct auxiliary_device_id *id)
+{
+	struct bnge_auxr_priv *aux_priv =
+		container_of(adev, struct bnge_auxr_priv, aux_dev);
+	struct bng_re_en_dev_info *en_info;
+	int rc;
+
+	en_info = kzalloc(sizeof(*en_info), GFP_KERNEL);
+	if (!en_info)
+		return -ENOMEM;
+
+	en_info->auxr_dev = aux_priv->auxr_dev;
+
+	auxiliary_set_drvdata(adev, en_info);
+
+	rc = bng_re_add_device(adev);
+	if (rc)
+		kfree(en_info);
+	return rc;
+}
+
+static void bng_re_remove(struct auxiliary_device *adev)
+{
+	struct bng_re_en_dev_info *dev_info = auxiliary_get_drvdata(adev);
+	struct bng_re_dev *rdev;
+
+	rdev = dev_info->rdev;
+
+	if (rdev)
+		bng_re_remove_device(rdev, adev);
+	kfree(dev_info);
+}
+
+static const struct auxiliary_device_id bng_re_id_table[] = {
+	{ .name = BNG_RE_ADEV_NAME ".rdma", },
+	{},
+};
+
+MODULE_DEVICE_TABLE(auxiliary, bng_re_id_table);
+
+static struct auxiliary_driver bng_re_driver = {
+	.name = "rdma",
+	.probe = bng_re_probe,
+	.remove = bng_re_remove,
+	.id_table = bng_re_id_table,
+};
+
+static int __init bng_re_mod_init(void)
+{
+	int rc;
+
+	pr_info("%s: %s", BNG_ROCE_DRV_MODULE_NAME, version);
+
+	rc = auxiliary_driver_register(&bng_re_driver);
+	if (rc) {
+		pr_err("%s: Failed to register auxiliary driver\n",
+		       BNG_ROCE_DRV_MODULE_NAME);
+	}
+	return rc;
+}
+
+static void __exit bng_re_mod_exit(void)
+{
+	auxiliary_driver_unregister(&bng_re_driver);
+}
+
+module_init(bng_re_mod_init);
+module_exit(bng_re_mod_exit);
diff --git a/drivers/infiniband/hw/bng_re/bng_re.h b/drivers/infiniband/hw/bng_re/bng_re.h
new file mode 100644
index 000000000000..bd3aacdc05c4
--- /dev/null
+++ b/drivers/infiniband/hw/bng_re/bng_re.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+// Copyright (c) 2025 Broadcom.
+
+#ifndef __BNG_RE_H__
+#define __BNG_RE_H__
+
+#define BNG_ROCE_DRV_MODULE_NAME	"bng_re"
+#define BNG_RE_ADEV_NAME		"bng_en"
+
+#define BNG_RE_DESC	"Broadcom 800G RoCE Driver"
+
+#define	rdev_to_dev(rdev)	((rdev) ? (&(rdev)->ibdev.dev) : NULL)
+
+struct bng_re_en_dev_info {
+	struct bng_re_dev *rdev;
+	struct bnge_auxr_dev *auxr_dev;
+};
+
+struct bng_re_dev {
+	struct ib_device		ibdev;
+	struct net_device		*netdev;
+	struct auxiliary_device         *adev;
+	struct bnge_auxr_dev		*aux_dev;
+	int				fn_id;
+};
+
+#endif
-- 
2.43.0


