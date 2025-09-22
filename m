Return-Path: <netdev+bounces-225299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1040B92070
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 17:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93BDB1902B4D
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 15:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D2E2EBBB5;
	Mon, 22 Sep 2025 15:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bGvKSfaC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com [209.85.219.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66C22EB87E
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 15:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758555817; cv=none; b=BbkPufgKF5EdZNdHlsTS5Mzb+Euod2B+Xz1JXG2KE3joHfZUbJrgsemVen69g0muUYj0jRjFZSCjqnYY/76CYYShZJSy/3/OAoPeaWKamcTkYZk+OdQ5y+6nw5ye5HGlhNnWIPo3Stjo0vIZb/RzpDXYtX9D5H19IqoRnIl0mlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758555817; c=relaxed/simple;
	bh=5K22EYFqwhSZtpxvZ7pw6FhqwGWzT59lHJi/dIXRS/c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LuchYPn675SSeXpxIHLTPxKmTYMQ0xOIEp9VsaBjo1HQcq6IzCLOjJifgn3+JkTpSQA/alt6gP7h9tRjdtWkR0ZnpY96D+7PjFd1N7cYWZwsFjNWeSspjnRRrDm1plC7VPNZqP4DMbpIW+ojDY86+7jyJchtjfqLzwNKEw0n2Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bGvKSfaC; arc=none smtp.client-ip=209.85.219.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f97.google.com with SMTP id 6a1803df08f44-79390b83c7dso38342356d6.1
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 08:43:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758555815; x=1759160615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ljzRf+fQkTXrHRLgyTo6IBmxzVI6wZ2jIzrNCpRNIRY=;
        b=XQfdoHwcKRn1meD0BscN4xDrcEuu3fynuyIePEf5qxjv2FNmhhFA7qOYunqsbu4Iaf
         6xqS8q+yIrx5sgrS2dpC5N2ele0evVs5SG5OEdIja2wpU//tkO0lszGiPrgC3JO6MhL2
         fkpzvXqSp6P+T1T2iOZTND5VJ97bOMsvNzFZjaYINSVmFnjASVNbaxcfeEdIQBZEAmS/
         c28uTJu+cxwgytztary6PYhbaLnWDjDFWuenHrzXhymPh7hAXcGKgxH+d8Eh1p3pekb4
         qRCVNIOyXIH9cS0AcsDJUp2FZlG3ntFEBeNo9dNzHrIbfYv4to4K4YFVad8euZ2e7vhC
         nmaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvfGxOuOh6LeuFrGTx+/2gNUk1DBw06duVlRwb/OV6tI5T8bDY2ytJjD3XLgDZIvb7nYuTNEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxqsnwcAY01ay9gIxZqFCR9ULaplAjZBeM0dW7BlnmEBqFt9Uz
	Pn29T8o1V23wdLtCEx0SagE7VuOvvNmOn/r1YG2Q0PjoL4DWAGWoRxujVqPY2UFSwJK53jyi/aG
	oAZmPskGTSalZPYwREcXa7KOM1O+9FSxmu8A7psNGixmwZpOMSpqs1vv0XJM1pZH5pUTaOUka2b
	a3hydaHH0FBoVTgUlD17C5p6ZMH33FUentBaP53K8VbgFZ7SKD85vResXxU4b/MNWMeGlGVXH0T
	jkHKIyaAFPa
X-Gm-Gg: ASbGncvAc2gl961s+aF7dPgM6v5WeSDUjuVVK4AYJTW/rN83DP11iik0Ftnu+4/WZt0
	WRJQBMdfOCRKKV3YtlJZLx/7aC+6MLCDkchucjCka8Ca4vfEnzhW64C19CHbna6rsYpLkU+FJix
	ESnASjbc3qeKj5KocJ1MZ69A+nRWQTKvhiTgB4aVB3fSN9LPyNXjsLNcD1xumeVtK8HE6+PTFed
	Bk39E3prq41Y3mvvhdHC/d8nUF4v9ourDib/8mqL7FcTAVyckfIpIZ6drC1ZWodgzt23zgU11Z2
	4s/fIn1/A918d0WApIKm3sMwLp2a+9cqmuQPkGxjXWD+CuWUeEZq+Ypg7pQ+WcCH+6/17BZPnEI
	WX6h0BcaYQwiP0HTVrKXTPsIOqPWl9DpjhE7MSGTFKlv1zbL/Bn6n3ODiYpPZXBMkQCPsqFcecw
	==
X-Google-Smtp-Source: AGHT+IGTQuCqVnrIYHM7lzOUDt15pnPyq4qmk1Z5WcYPjQUfW94Kdo7cPpJRMtA5EHvFNV0+jwlQ684jvKLT
X-Received: by 2002:a05:6214:29ec:b0:794:5578:6a with SMTP id 6a1803df08f44-7991164d54emr158948456d6.10.1758555814423;
        Mon, 22 Sep 2025 08:43:34 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-7934ee8bab1sm8035706d6.22.2025.09.22.08.43.34
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Sep 2025 08:43:34 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b5e303fe1cso77031791cf.2
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 08:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758555814; x=1759160614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ljzRf+fQkTXrHRLgyTo6IBmxzVI6wZ2jIzrNCpRNIRY=;
        b=bGvKSfaCG6tAo7MrSsH4Aev7e4FQ/ss91LWgHs58r823qu/LgkgQlWT43+AYbhXVwJ
         8B5d2VU4jRmnk2KK23nyb4NmCjwZmjwQ93jkZdKttorCYj2d4bDeUPP6hixgAjE61g63
         D1ALaLPXCNLp8+BStdQ+fLcBXjDM1k9Mc07QQ=
X-Forwarded-Encrypted: i=1; AJvYcCUlaAxakK/QyWrNdsfFVO3haPHxjf/HkxaemhKBbifTl+wnR+auCy0AF7YRDFSacTcRdSrES9s=@vger.kernel.org
X-Received: by 2002:a05:622a:4295:b0:4b3:741:2e1f with SMTP id d75a77b69052e-4c06f8423acmr155597221cf.33.1758555813580;
        Mon, 22 Sep 2025 08:43:33 -0700 (PDT)
X-Received: by 2002:a05:622a:4295:b0:4b3:741:2e1f with SMTP id d75a77b69052e-4c06f8423acmr155596821cf.33.1758555813032;
        Mon, 22 Sep 2025 08:43:33 -0700 (PDT)
Received: from sjs-csg-thor3-swe-29.lvn.broadcom.net044broadcom.net ([192.19.224.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-84ada77bb17sm179496785a.30.2025.09.22.08.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 08:43:32 -0700 (PDT)
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
Subject: [PATCH v2 3/8] RDMA/bng_re: Register and get the resources from bnge driver
Date: Mon, 22 Sep 2025 15:42:58 +0000
Message-Id: <20250922154303.246809-4-siva.kallam@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250922154303.246809-1-siva.kallam@broadcom.com>
References: <20250922154303.246809-1-siva.kallam@broadcom.com>
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
2.34.1


