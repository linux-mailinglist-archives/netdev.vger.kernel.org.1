Return-Path: <netdev+bounces-239197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 37316C657A7
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 18:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 34DD63859F7
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 17:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A90A32A3C6;
	Mon, 17 Nov 2025 17:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PwN2YBOJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f228.google.com (mail-il1-f228.google.com [209.85.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421B632937E
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 17:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763399555; cv=none; b=QYtNYj3CaU2B3Ndrt2xfO9m6xw7RTwXWRZnJxG9+SChgPUE0g4o5I71BSvH5RJfCME5yI3bggrZi60Xa7h+3/p2H8W99XqGmctwDyjNeUl3RMlgbBiF6ddFMyDtkOP54yfNWgfVQ6695ydNbA6gTw3W+tQ/DkELXCJhrQ+M6Si4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763399555; c=relaxed/simple;
	bh=xQaoQUyFA2OOoOxPb7HMFwHrbLGMuZvFEhsS7oOEFRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mrDEu9y1AnRxDNJjQlZXSdSzs6UI+m1ZPv1Fo1DIo1DFymaIU1R9mgrC37+sezAUX3M2tF4j9k/eudPae8PYJMR4IZYcyrU5yfAVO6uQSZdiiiKaLBvR9bVwm7DV9gFd3Ff9vfgqZXUmMIMaQgeXgVMG8MKPiZjRNaEOKc2my4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PwN2YBOJ; arc=none smtp.client-ip=209.85.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f228.google.com with SMTP id e9e14a558f8ab-43379251ff9so24738475ab.1
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 09:12:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763399552; x=1764004352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0bliFMzDhNAvMQaBtvLYCtrwp9ER8GDCWnv/7cQ7F4w=;
        b=xMlm8sNqI/6mMGhSVTOpjRkqyuy0ykg3I8X9D5bXWh6ZXtFcT3V08grVsDC2quy5FH
         ma9IgZlgH83Gfe2rp1t1MYChPmMnWv9SoyNnKY6pnUdx8DabfzNp84ccpmdYOjRB5nZC
         uvKuv45epvYkK/MwPdh2FoUppBTaqLWO87uWfaCcmE9wZ/HlRVcrYGFbl8ftaUBKj+mI
         DQtwAwcy1XhXfvvj1O3MEcw3uJjmh/7nnzwe90LXqvglM5tDtAHUF4YpLTS6dg89qJm/
         1SIL8Vx3CduGMurAJOrCXpz5Q9YUnfumRmCyCOpumSTWHMXi26e7uzCyCyRmUCSpK2ZC
         svzg==
X-Forwarded-Encrypted: i=1; AJvYcCWWi06mU1G1/dS6gXA+HSQJ6H7LGYLeWcZqWd/hyVXHzPjKwr1MCpVoAIhez4YPhug1Yk/++zA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmn12V9HeFVywaDr3VM0uQzYWeJw2dxD2DBHJiHPeOGajSrm3h
	olao5FatZEz5kF6JZePkC827cLCMyQrXfwyX1fVcjoMCk8SsSbOyzZSQNVb3r9WzXfHgzFYbxZ/
	OnB/vCW6uMXyL3+WxwG+3IZXpVKuo/I4q0Tgv6sMLDSyA06EJ1FBf9SkMX4zf6pkxgZRBsK43V7
	qE5TnzpqkCXhWbLr6R3fEk/+bwbFB0goX/vlaDVLMbl+wQpQfPc1y31sEDvRUoNlyEyBXmUh2UZ
	na8UOknOAXL
X-Gm-Gg: ASbGncuxBVmPWtDIeNh2gCvxA1ihnvnxmA+0umi/2QRig+4YeTXpR/M7q5320yN3IaV
	LuWWMAhzvDoUfKe3fnvAC21Na49onlEOfdwDRxr69fjDTDoXK0zNpMZx3vp9wLBMeZalPx6t4yL
	HedSnMojbpHNeSJ5yScXfg6ZVJIiWD+VULPBVoIo3LM57Ct0e1efd6Y9+ThHp9XmuQ1icm73M5P
	EbhWzNFTwn14dgCPSaFpyn5QVs+kI7P9U27qyv7MgB4oz+RwWHc20EmLpWOKV3KvI2F/UZWuXlB
	ektUn+dp3Ua7AwgNhC9WH0eesGd1DTbbWyOPL3zcSlWuosJOEccuCgQP9nL4UsW8nZduITpBuh1
	13FDktXq/5lF4pL+ao/i45B5U7gIRlXMgBvAI7r6OyKvtInXZ9fDPmFfJQVTdhmRy2csu3U0sN+
	cdINpHi/A2eIKHkoknnmvq3vCx9L2ZiQGOUhg=
X-Google-Smtp-Source: AGHT+IHdTOb1izSjP87L8BGthRo8+WHPYTjkR+WoPVyYoS3z4sawLd/i4mYX5QwT8sLaDUzwhJlA/3IOqLA1
X-Received: by 2002:a05:6638:c08c:b0:572:957d:4ff6 with SMTP id 8926c6da1cb9f-5b7fa51a25fmr134839173.0.1763399552016;
        Mon, 17 Nov 2025 09:12:32 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-5b7bd267d81sm952944173.16.2025.11.17.09.12.31
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Nov 2025 09:12:32 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4edad69b4e8so110340921cf.1
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 09:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1763399551; x=1764004351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0bliFMzDhNAvMQaBtvLYCtrwp9ER8GDCWnv/7cQ7F4w=;
        b=PwN2YBOJIC/JXRSkYzO9XP+FAY9AwVPPaL7ObQ4NoQD1bgRSv1YkJINxpBxvqtF17B
         s5a+gacAeqpb64Yean5L2NQyQbN1eN4YuhglZQWAJjEOzJm2xHZ3MqMCVqbMl/QyZDpp
         TPKw1SzYLRfyO/c7dqd86QUrU2BRXuNT4nnO8=
X-Forwarded-Encrypted: i=1; AJvYcCVvkuFmEe7iERXBcfHXVmDtQiBQ8bNwUrmiUYlwoJJriNNABo1oXtf0Z/a/BkizlOVi0vCpPls=@vger.kernel.org
X-Received: by 2002:a05:622a:120c:b0:4ee:199d:649c with SMTP id d75a77b69052e-4ee308a565emr774611cf.33.1763399550608;
        Mon, 17 Nov 2025 09:12:30 -0800 (PST)
X-Received: by 2002:a05:622a:120c:b0:4ee:199d:649c with SMTP id d75a77b69052e-4ee308a565emr773931cf.33.1763399550161;
        Mon, 17 Nov 2025 09:12:30 -0800 (PST)
Received: from sjs-csg-thor3-swe-29.lvn.broadcom.net044broadcom.net ([192.19.224.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88286314557sm96082236d6.20.2025.11.17.09.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 09:12:29 -0800 (PST)
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
Subject: [PATCH v3 3/8] RDMA/bng_re: Register and get the resources from bnge driver
Date: Mon, 17 Nov 2025 17:11:21 +0000
Message-ID: <20251117171136.128193-4-siva.kallam@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251117171136.128193-1-siva.kallam@broadcom.com>
References: <20251117171136.128193-1-siva.kallam@broadcom.com>
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
index 08aba72a26f7..cad065df2032 100644
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
2.43.0


