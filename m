Return-Path: <netdev+bounces-218258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DD6B3BB52
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 14:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67CF43ADA22
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 12:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E4B318137;
	Fri, 29 Aug 2025 12:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NFRhnKmy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f99.google.com (mail-oa1-f99.google.com [209.85.160.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDDE3164B9
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 12:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756470683; cv=none; b=PE9AjuCgIzk213N415s6UL9NhkxSgY14ilgc5ljjySWLFRKSyqZ2vGpLQemK6Rd2yR6C17doT2KZemaAXA9CZpwmh7jgWkE4T56LSrLYemPKBif0IFREKOTzllcebb9DYUxUJ6n88wSypYianlkQsb+nEJPC1A/iJ/9LUiX0tvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756470683; c=relaxed/simple;
	bh=QQ5/d/ctfKXMji9r0IFstTlSPne+z4grdxzK8BCUkL8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TlFImDaFHOlrL4nzlTUqLiM7ysq+qBn1Y/j1a0pYozyrMLwY39e33IXjZ8oapfIaSm5xjvopCF0VanNT2Ci2Sqvs5N6buvrXB983U2N9UO9usQTW1Z6nIximGs/7cZnq/htMS5Eq/dMA56UkkHM/zmT38iZqfbolwjwNp0dGLu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NFRhnKmy; arc=none smtp.client-ip=209.85.160.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f99.google.com with SMTP id 586e51a60fabf-30cceb07f45so1939095fac.2
        for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 05:31:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756470681; x=1757075481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6jNDerxCWY7R0RDSnHboaIKwbrYOEqJkI+IEOXiZnEQ=;
        b=A1wNkRyPPs5FddfnWQWn8zDIMPOAA56rGtGCbN4EA7VQVyle3/1fg1TNYBNIGDPPDe
         yxyHcZjXdPpPPJOu6zaF9YALyIvFch1A7hlKBGrx76nQv0rS+RhnKs/LrDc7Xo9XIocX
         YKYXsICZbSZjMb0StIa3gfqLyt1zPi80sV7YTUXwVt8S4FqARBJ7co/9kha0+cwnr911
         ZyUAdU9hfk98m28YFlJraGD0CwybzPWIsRxNIYGarXX7qrBvcnnpCXfHWitT4503JBoo
         mapQBZZJEidVVTdwIsl8offrrd8XTmjLcAslQ7v2JsMX9wrkHu1C6K4W9LKYY+2HEEg8
         /nfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIBFCLpXuk0kp6ULZ+pX8DLscsbiBCMZlEPfqLCL58L0EJ/+HqF+Haw4twnAYTLtn3jlTSHGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCZ4XiENr3M0gmN4hZM1jctkwjWXogGJl8OWELraWbsz1ujjBC
	GUhBPkmPGyn0WwodTg3FgWD/nVHGFyB4MGFJwDkdnb1IZRyJ9iDc2MP3+va8BFH1zleBSCUIYrf
	weZkqkShw8EkDZLMiHtH3xNV7BIIKxDAfSKKeQWWyb6F0ydVf1sA8/+0MNH8XkdqgsLkRWMTxpP
	8JiaSby87bUk820xquY4hhyFOkTFO84Hl0GrLhGWJ3tNKCfICN88iTI/OpgbAy+fgT6lNdsi2+i
	mfTbPputMV3
X-Gm-Gg: ASbGncuoEb1pofPsPVJlOmCdaBsd4kT05BjAyv4k/IuCUWvcvIlnwV0+tUG7on4gIoA
	DJzkrW9pp0V9yikhe1PL35wFNi8bIRUIy5K7ZUyV1zeqevMQwPdLZPW31RodtRPvwcDykPrKMrQ
	gfTWAxNc78HQsIIdcZSr1kE5aL7uMKuCCssa2Ts+PmlpikBpOc3ScqfEuZF6vq0co6dOGO296Cj
	i1ewVPGKpmmMArLx7MepVcLqGn7ZRR3bfhxo3Xz9Sm5X4coRbNYvpcJhwm/ghqXOH6ph9ZCwH85
	MZO3k0dIYCuVH3aaZTa2e6lxinpHGVg6utCPcJBW+ffJmWnoPeaitBnOl/uT5vfbPjvTgT7qoxV
	nWwwqSv0cKrzRnShunPLjSZwB3UJye6wAK3zyyTizMS0J5oJRYB3CVPA8qu9WffcyTX8bIV3QzS
	Ff
X-Google-Smtp-Source: AGHT+IHp+fyQp7SNx2y777wl7JG5z/eh6GLuLFRiX9peRzYSmHvpKQMneSkWUI0ev35LENnDhYzxMrLSnQqI
X-Received: by 2002:a05:6870:2491:b0:30b:85a0:eb66 with SMTP id 586e51a60fabf-314dcb3ea88mr11992782fac.12.1756470680817;
        Fri, 29 Aug 2025 05:31:20 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-50d7be9c82csm112536173.21.2025.08.29.05.31.20
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Aug 2025 05:31:20 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7fa717ff667so331102885a.3
        for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 05:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1756470680; x=1757075480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6jNDerxCWY7R0RDSnHboaIKwbrYOEqJkI+IEOXiZnEQ=;
        b=NFRhnKmyhXu7vN5mRormeBiFxiQP+Nx0bu/IZKCZxHQtvvVk+/m62ztdd8/A2zMpaB
         M3wGr3jBB8YoRU5R85/0S2XcvbvbHGuBZeWNDYh5pLxYvjHdB13sXNng5LRSq/Vl/5De
         Ln1vXo3lG0jPXejVI+g8QNUff/vpZF2MwN/hc=
X-Forwarded-Encrypted: i=1; AJvYcCUXxOi+c3rk0aSyuuLVbNYUcg27XulA5+fOEa1CNDZOnGceWJ9n0HZgdHCBx/YtILGhxcY1vds=@vger.kernel.org
X-Received: by 2002:a05:620a:4091:b0:7e8:44ac:8136 with SMTP id af79cd13be357-7ea10f86c69mr2947252785a.2.1756470679693;
        Fri, 29 Aug 2025 05:31:19 -0700 (PDT)
X-Received: by 2002:a05:620a:4091:b0:7e8:44ac:8136 with SMTP id af79cd13be357-7ea10f86c69mr2947248985a.2.1756470679131;
        Fri, 29 Aug 2025 05:31:19 -0700 (PDT)
Received: from sjs-csg-thor3-swe-29.lvn.broadcom.net044broadcom.net ([192.19.224.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7fc16536012sm162384585a.66.2025.08.29.05.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 05:31:18 -0700 (PDT)
From: Siva Reddy Kallam <siva.kallam@broadcom.com>
To: leonro@nvidia.com,
	jgg@nvidia.com
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	vikas.gupta@broadcom.com,
	selvin.xavier@broadcom.com,
	anand.subramanian@broadcom.com,
	Siva Reddy Kallam <siva.kallam@broadcom.com>,
	Usman Ansari <usman.ansari@broadcom.com>
Subject: [PATCH 3/8] RDMA/bng_re: Register and get the resources from bnge driver
Date: Fri, 29 Aug 2025 12:30:37 +0000
Message-Id: <20250829123042.44459-4-siva.kallam@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250829123042.44459-1-siva.kallam@broadcom.com>
References: <20250829123042.44459-1-siva.kallam@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Register and get the basic required resources from bnge driver.

Signed-off-by: Siva Reddy Kallam <siva.kallam@broadcom.com>
Reviewed-by: Usman Ansari <usman.ansari@broadcom.com>
---
 drivers/infiniband/hw/bng_re/bng_dev.c | 149 +++++++++++++++++++++++++
 drivers/infiniband/hw/bng_re/bng_re.h  |   5 +
 drivers/infiniband/hw/bng_re/bng_res.h |  16 +++
 3 files changed, 170 insertions(+)
 create mode 100644 drivers/infiniband/hw/bng_re/bng_res.h

diff --git a/drivers/infiniband/hw/bng_re/bng_dev.c b/drivers/infiniband/hw/bng_re/bng_dev.c
index 208844e98bd6..a9196b765a58 100644
--- a/drivers/infiniband/hw/bng_re/bng_dev.c
+++ b/drivers/infiniband/hw/bng_re/bng_dev.c
@@ -7,8 +7,10 @@
 
 #include <rdma/ib_verbs.h>
 
+#include "bng_res.h"
 #include "bng_re.h"
 #include "bnge.h"
+#include "bnge_hwrm.h"
 #include "bnge_auxr.h"
 
 static char version[] =
@@ -40,6 +42,144 @@ static struct bng_re_dev *bng_re_dev_add(struct auxiliary_device *adev,
 	return rdev;
 }
 
+
+static int bng_re_register_netdev(struct bng_re_dev *rdev)
+{
+	struct bnge_auxr_dev *aux_dev;
+
+	aux_dev = rdev->aux_dev;
+	return bnge_register_dev(aux_dev, rdev->adev);
+}
+
+static void bng_re_destroy_chip_ctx(struct bng_re_dev *rdev)
+{
+	struct bng_re_chip_ctx *chip_ctx;
+
+	if (!rdev->chip_ctx)
+		return;
+
+	chip_ctx = rdev->chip_ctx;
+	rdev->chip_ctx = NULL;
+	kfree(chip_ctx);
+}
+
+static int bng_re_setup_chip_ctx(struct bng_re_dev *rdev)
+{
+	struct bng_re_chip_ctx *chip_ctx;
+	struct bnge_auxr_dev *aux_dev;
+
+	aux_dev = rdev->aux_dev;
+
+	chip_ctx = kzalloc(sizeof(*chip_ctx), GFP_KERNEL);
+	if (!chip_ctx)
+		return -ENOMEM;
+	chip_ctx->chip_num = aux_dev->chip_num;
+	chip_ctx->hw_stats_size = aux_dev->hw_ring_stats_size;
+
+	rdev->chip_ctx = chip_ctx;
+
+	return 0;
+}
+
+static void bng_re_init_hwrm_hdr(struct input *hdr, u16 opcd)
+{
+	hdr->req_type = cpu_to_le16(opcd);
+	hdr->cmpl_ring = cpu_to_le16(-1);
+	hdr->target_id = cpu_to_le16(-1);
+}
+
+static void bng_re_fill_fw_msg(struct bnge_fw_msg *fw_msg, void *msg,
+			       int msg_len, void *resp, int resp_max_len,
+			       int timeout)
+{
+	fw_msg->msg = msg;
+	fw_msg->msg_len = msg_len;
+	fw_msg->resp = resp;
+	fw_msg->resp_max_len = resp_max_len;
+	fw_msg->timeout = timeout;
+}
+
+static void bng_re_query_hwrm_version(struct bng_re_dev *rdev)
+{
+	struct bnge_auxr_dev *aux_dev = rdev->aux_dev;
+	struct hwrm_ver_get_output ver_get_resp = {};
+	struct hwrm_ver_get_input ver_get_req = {};
+	struct bng_re_chip_ctx *cctx;
+	struct bnge_fw_msg fw_msg = {};
+	int rc;
+
+	bng_re_init_hwrm_hdr((void *)&ver_get_req, HWRM_VER_GET);
+	ver_get_req.hwrm_intf_maj = HWRM_VERSION_MAJOR;
+	ver_get_req.hwrm_intf_min = HWRM_VERSION_MINOR;
+	ver_get_req.hwrm_intf_upd = HWRM_VERSION_UPDATE;
+	bng_re_fill_fw_msg(&fw_msg, (void *)&ver_get_req, sizeof(ver_get_req),
+			    (void *)&ver_get_resp, sizeof(ver_get_resp),
+			    BNGE_DFLT_HWRM_CMD_TIMEOUT);
+	rc = bnge_send_msg(aux_dev, &fw_msg);
+	if (rc) {
+		ibdev_err(&rdev->ibdev, "Failed to query HW version, rc = 0x%x",
+			  rc);
+		return;
+	}
+
+	cctx = rdev->chip_ctx;
+	cctx->hwrm_intf_ver =
+		(u64)le16_to_cpu(ver_get_resp.hwrm_intf_major) << 48 |
+		(u64)le16_to_cpu(ver_get_resp.hwrm_intf_minor) << 32 |
+		(u64)le16_to_cpu(ver_get_resp.hwrm_intf_build) << 16 |
+		le16_to_cpu(ver_get_resp.hwrm_intf_patch);
+
+	cctx->hwrm_cmd_max_timeout = le16_to_cpu(ver_get_resp.max_req_timeout);
+
+	if (!cctx->hwrm_cmd_max_timeout)
+		cctx->hwrm_cmd_max_timeout = BNG_ROCE_FW_MAX_TIMEOUT;
+}
+
+static int bng_re_dev_init(struct bng_re_dev *rdev)
+{
+	int rc;
+
+	/* Registered a new RoCE device instance to netdev */
+	rc = bng_re_register_netdev(rdev);
+	if (rc) {
+		ibdev_err(&rdev->ibdev,
+				"Failed to register with netedev: %#x\n", rc);
+		return -EINVAL;
+	}
+
+	set_bit(BNG_RE_FLAG_NETDEV_REGISTERED, &rdev->flags);
+
+	if (rdev->aux_dev->auxr_info->msix_requested < BNG_RE_MIN_MSIX) {
+		ibdev_err(&rdev->ibdev,
+			  "RoCE requires minimum 2 MSI-X vectors, but only %d reserved\n",
+			  rdev->aux_dev->auxr_info->msix_requested);
+		bnge_unregister_dev(rdev->aux_dev);
+		clear_bit(BNG_RE_FLAG_NETDEV_REGISTERED, &rdev->flags);
+		return -EINVAL;
+	}
+	ibdev_dbg(&rdev->ibdev, "Got %d MSI-X vectors\n",
+		  rdev->aux_dev->auxr_info->msix_requested);
+
+	rc = bng_re_setup_chip_ctx(rdev);
+	if (rc) {
+		bnge_unregister_dev(rdev->aux_dev);
+		clear_bit(BNG_RE_FLAG_NETDEV_REGISTERED, &rdev->flags);
+		ibdev_err(&rdev->ibdev, "Failed to get chip context\n");
+		return -EINVAL;
+	}
+
+	bng_re_query_hwrm_version(rdev);
+
+	return 0;
+}
+
+static void bng_re_dev_uninit(struct bng_re_dev *rdev)
+{
+	bng_re_destroy_chip_ctx(rdev);
+	if (test_and_clear_bit(BNG_RE_FLAG_NETDEV_REGISTERED, &rdev->flags))
+		bnge_unregister_dev(rdev->aux_dev);
+}
+
 static int bng_re_add_device(struct auxiliary_device *adev)
 {
 	struct bnge_auxr_priv *auxr_priv =
@@ -58,7 +198,14 @@ static int bng_re_add_device(struct auxiliary_device *adev)
 
 	dev_info->rdev = rdev;
 
+	rc = bng_re_dev_init(rdev);
+	if (rc)
+		goto re_dev_dealloc;
+
 	return 0;
+
+re_dev_dealloc:
+	ib_dealloc_device(&rdev->ibdev);
 exit:
 	return rc;
 }
@@ -67,6 +214,7 @@ static int bng_re_add_device(struct auxiliary_device *adev)
 static void bng_re_remove_device(struct bng_re_dev *rdev,
 				 struct auxiliary_device *aux_dev)
 {
+	bng_re_dev_uninit(rdev);
 	ib_dealloc_device(&rdev->ibdev);
 }
 
@@ -90,6 +238,7 @@ static int bng_re_probe(struct auxiliary_device *adev,
 	rc = bng_re_add_device(adev);
 	if (rc)
 		kfree(en_info);
+
 	return rc;
 }
 
diff --git a/drivers/infiniband/hw/bng_re/bng_re.h b/drivers/infiniband/hw/bng_re/bng_re.h
index bd3aacdc05c4..db692ad8db0e 100644
--- a/drivers/infiniband/hw/bng_re/bng_re.h
+++ b/drivers/infiniband/hw/bng_re/bng_re.h
@@ -11,6 +11,8 @@
 
 #define	rdev_to_dev(rdev)	((rdev) ? (&(rdev)->ibdev.dev) : NULL)
 
+#define BNG_RE_MIN_MSIX		2
+
 struct bng_re_en_dev_info {
 	struct bng_re_dev *rdev;
 	struct bnge_auxr_dev *auxr_dev;
@@ -18,9 +20,12 @@ struct bng_re_en_dev_info {
 
 struct bng_re_dev {
 	struct ib_device		ibdev;
+	unsigned long			flags;
+#define BNG_RE_FLAG_NETDEV_REGISTERED		0
 	struct net_device		*netdev;
 	struct auxiliary_device         *adev;
 	struct bnge_auxr_dev		*aux_dev;
+	struct bng_re_chip_ctx		*chip_ctx;
 	int				fn_id;
 };
 
diff --git a/drivers/infiniband/hw/bng_re/bng_res.h b/drivers/infiniband/hw/bng_re/bng_res.h
new file mode 100644
index 000000000000..d64833498e2a
--- /dev/null
+++ b/drivers/infiniband/hw/bng_re/bng_res.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+// Copyright (c) 2025 Broadcom.
+
+#ifndef __BNG_RES_H__
+#define __BNG_RES_H__
+
+#define BNG_ROCE_FW_MAX_TIMEOUT	60
+
+struct bng_re_chip_ctx {
+	u16	chip_num;
+	u16	hw_stats_size;
+	u64	hwrm_intf_ver;
+	u16	hwrm_cmd_max_timeout;
+};
+
+#endif
-- 
2.34.1


