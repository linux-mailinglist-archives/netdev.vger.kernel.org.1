Return-Path: <netdev+bounces-215902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB487B30D29
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 06:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04B9A5E8A6E
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 04:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1E028CF5F;
	Fri, 22 Aug 2025 04:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZL1SWKJf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704CB27CB21
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 04:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755835385; cv=none; b=EGwtKB4nFjuORr55W5xeJC0T1VVjDjGcqLr6r85aKWbQ3B56eyop5BD9nN5hwzBXNKU6oY7qhbM77SAV0XDLY90X4JbRy54fUrbJt/66AaijI598mVif8F/GUkUvY5DtxHmYWR7yJJjzu+zWAInDDxf9ZVl6Aoa14zMnEcxCOdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755835385; c=relaxed/simple;
	bh=QeTeAJHCFEm5UTJkIDJ+Ggdpr1gcHI2zuVaOgJNljnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R1UpKaDdEgrCqf43fhtGQy4IDOFDs8/D4hMV/0feM6N1CxfcFgoqQ/45bFL9MFfyUPIbjfrpJVcfrGMmgxqsMBk8hldavjWcH+S03FGWD0L9jn3PLgS6i9AbD5mhW3nrUsv+1gISmu6TMnfjsTufr0droN/zexaWSnw257qoBbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZL1SWKJf; arc=none smtp.client-ip=209.85.215.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-b471756592cso1017338a12.3
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 21:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755835384; x=1756440184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mkme5IBl5KRWoBojbGS0RT/QRiWYZpAh+2JnOlGPjUk=;
        b=rdByLPrPqLTHz4KmN49ecclfq+kTAfC8lCOToAHLbGYr3UIX6JvJUmtIJ2NUPTAccZ
         OnY3KyxnHs+aUX3tj1aelm3QyHQO4rMKu5ja/pMzO4sVp0M8CU75kxJfELg7nq23gwSr
         p29gO9KKdUGGEZEx9W9whH73BqkU7nKd+Z2wgBW1sA9MvfyvjMuIeCpn1CmIIO2B3gOj
         RpUGtsVn8Xbm0Dv0Wp1AuMeRjKpIkR8VsdnaSgbyM0bmRQWkIF2EZvQD1R60+UXdmYJl
         T88cktqEgnrxXUx+7IQh72sPJjaGTcox1nH8mzxzVjIZO6ico90EEH497TczuJT9XMTD
         2ISA==
X-Forwarded-Encrypted: i=1; AJvYcCWeGHlZ9ArufXnGHo6buna34O07EWRE5utkldyijOAmt/XdLBidDFM8rFmQ8IxBarJ0Md9nfL0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc388OegyfjygKKcTrGC2oJgdrVoTblyq6r/IH/4oV+xqGtql4
	SVOd1CJL6ssdOmTQAtETSUANzJtaniAjK3njFtDitztV7iqvZsEojwBWB4iPYYNO7FIOVdED0Wl
	d1713Kt+qWPhqJYIYIQpzMRHnkv3iZuLvBFkvVNNVE2DMBVQVqr5JDK9BcTh1CCLPMSKnSvxk3K
	zzXCJQkxaDAfzAUyz0kLHN40FGdc+0XvvtKXODeABloZ6cMicm1vOsmIWJApJnSv1nNvDun9Ca9
	x7y/jdSQIghl42oE+cdJ6P0
X-Gm-Gg: ASbGnctZ5HNE7wEYUpHhs9C7NGs7llnvUkIBlf0CcQZNGZme6M1byuzfXd2D0s+Lxsx
	sLHbIZ+nR/inUIcB0/VtFOBFJQfwmzFlGMPUmmtMT0GWs2MnWkJ1qL9IwrIBniOa41zYbqh3d7g
	95Utr9DGWBYNu+kf2nfUyHvSxLTMdA5l8TwhkHIVF8TnEpuK70JUG+DGxYXlLjf3Ewg+lcJ0kzV
	IcgezwSs18yfbwk2ztpOQzD+TzxvNwA79dO4L9RCrOVTyjW6DQvtLBvugIlF5TEwHKk02QkXzsz
	5nHhNDZUFGhJ/Our/EL5IZrhgvvT/77/+asCJoAcFYb8qjOnGCVv8tMJgxapjFB5/NGs2+2D6BK
	V76ZfVFJTz6uzoyLRF8PYEHaG1QklMDbYpmuL/9bOT82oowQnPloHmPFcSNxL+jBuKQ9vou58U4
	WL6CjOHXJhHgsH
X-Google-Smtp-Source: AGHT+IHBM072qDPUqyRScrI24FDY2BVYEuiKkLVyoe46SQ3bAuuQ+3PNgU3uYRowM/WzooP48iIc2JVBQ89c
X-Received: by 2002:a17:902:d4cd:b0:23f:d903:d867 with SMTP id d9443c01a7336-2462ef1fd23mr25664145ad.35.1755835383514;
        Thu, 21 Aug 2025 21:03:03 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2460348eb8bsm3477205ad.62.2025.08.21.21.03.03
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Aug 2025 21:03:03 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-76e92b3dde9so1640999b3a.3
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 21:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755835382; x=1756440182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mkme5IBl5KRWoBojbGS0RT/QRiWYZpAh+2JnOlGPjUk=;
        b=ZL1SWKJfTMkK/oeoqkt2ggCSTfhAV3OKuCs+NdaavRTPsDbNhJPBYSo7DeGaA+Ka5X
         U3ebT0DUPD1oTnscFehc6zS4799Zz3hLt2H/Wv0MRabcjF2sDRG5uSGILC/24BMsVngv
         WKafvS0XYoc0n3P+/CbjmfJhK0fQTRQ9TBGCk=
X-Forwarded-Encrypted: i=1; AJvYcCXnDwKdx3xfroaWOLFu+M0D9nhc5j0XzTJYM31/4tO/IFQ1dIwzl/+F6kIZRfQmcq1vcPYIUlk=@vger.kernel.org
X-Received: by 2002:a05:6a00:23d5:b0:748:9d26:bb0a with SMTP id d2e1a72fcca58-7702fadbbedmr2387667b3a.18.1755835381745;
        Thu, 21 Aug 2025 21:03:01 -0700 (PDT)
X-Received: by 2002:a05:6a00:23d5:b0:748:9d26:bb0a with SMTP id d2e1a72fcca58-7702fadbbedmr2387629b3a.18.1755835381309;
        Thu, 21 Aug 2025 21:03:01 -0700 (PDT)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d0d3abdsm9659814b3a.11.2025.08.21.21.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 21:03:00 -0700 (PDT)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	michael.chan@broadcom.com,
	Saravanan Vajravel <saravanan.vajravel@broadcom.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH rdma-next 06/10] RDMA/bnxt_re: Add support for mirror vnic
Date: Fri, 22 Aug 2025 09:37:57 +0530
Message-ID: <20250822040801.776196-7-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250822040801.776196-1-kalesh-anakkur.purayil@broadcom.com>
References: <20250822040801.776196-1-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Saravanan Vajravel <saravanan.vajravel@broadcom.com>

Added below support:
- Querying the pre-reserved mirror_vnic_id
- Allocating/freeing mirror_vnic
- Configuring mirror vnic to associate it with raw qp

These functions will be used in the subsequent patch in this series.

Signed-off-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Reviewed-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h |  4 ++
 drivers/infiniband/hw/bnxt_re/main.c    | 67 +++++++++++++++++++++++++
 2 files changed, 71 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index 1cb57c8246cc..3f7f6cefe771 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -250,6 +250,10 @@ int bnxt_re_assign_pma_port_counters(struct bnxt_re_dev *rdev, struct ib_mad *ou
 int bnxt_re_assign_pma_port_ext_counters(struct bnxt_re_dev *rdev,
 					 struct ib_mad *out_mad);
 
+void bnxt_re_hwrm_free_vnic(struct bnxt_re_dev *rdev);
+int bnxt_re_hwrm_alloc_vnic(struct bnxt_re_dev *rdev);
+int bnxt_re_hwrm_cfg_vnic(struct bnxt_re_dev *rdev, u32 qp_id);
+
 static inline struct device *rdev_to_dev(struct bnxt_re_dev *rdev)
 {
 	if (rdev)
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 479c2a390885..07d25deffabe 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -540,6 +540,72 @@ static void bnxt_re_fill_fw_msg(struct bnxt_fw_msg *fw_msg, void *msg,
 	fw_msg->timeout = timeout;
 }
 
+void bnxt_re_hwrm_free_vnic(struct bnxt_re_dev *rdev)
+{
+	struct bnxt_en_dev *en_dev = rdev->en_dev;
+	struct hwrm_vnic_free_input req = {};
+	struct bnxt_fw_msg fw_msg = {};
+	int rc;
+
+	bnxt_re_init_hwrm_hdr((void *)&req, HWRM_VNIC_FREE);
+
+	req.vnic_id = cpu_to_le32(rdev->mirror_vnic_id);
+	bnxt_re_fill_fw_msg(&fw_msg, (void *)&req, sizeof(req), NULL,
+			    0, DFLT_HWRM_CMD_TIMEOUT);
+	rc = bnxt_send_msg(en_dev, &fw_msg);
+	if (rc)
+		ibdev_dbg(&rdev->ibdev,
+			  "Failed to free vnic, rc = %d\n", rc);
+}
+
+int bnxt_re_hwrm_alloc_vnic(struct bnxt_re_dev *rdev)
+{
+	struct bnxt_en_dev *en_dev = rdev->en_dev;
+	struct hwrm_vnic_alloc_output resp = {};
+	struct hwrm_vnic_alloc_input req = {};
+	struct bnxt_fw_msg fw_msg = {};
+	int rc;
+
+	bnxt_re_init_hwrm_hdr((void *)&req, HWRM_VNIC_ALLOC);
+
+	req.vnic_id = cpu_to_le16(rdev->mirror_vnic_id);
+	req.flags = cpu_to_le32(VNIC_ALLOC_REQ_FLAGS_VNIC_ID_VALID);
+	bnxt_re_fill_fw_msg(&fw_msg, (void *)&req, sizeof(req), (void *)&resp,
+			    sizeof(resp), DFLT_HWRM_CMD_TIMEOUT);
+	rc = bnxt_send_msg(en_dev, &fw_msg);
+	if (rc)
+		ibdev_dbg(&rdev->ibdev,
+			  "Failed to alloc vnic, rc = %d\n", rc);
+
+	return rc;
+}
+
+int bnxt_re_hwrm_cfg_vnic(struct bnxt_re_dev *rdev, u32 qp_id)
+{
+	struct bnxt_en_dev *en_dev = rdev->en_dev;
+	struct hwrm_vnic_cfg_input req = {};
+	struct bnxt_fw_msg fw_msg = {};
+	int rc;
+
+	bnxt_re_init_hwrm_hdr((void *)&req, HWRM_VNIC_CFG);
+
+	req.flags = cpu_to_le32(VNIC_CFG_REQ_FLAGS_ROCE_ONLY_VNIC_MODE);
+	req.enables = cpu_to_le32(VNIC_CFG_REQ_ENABLES_RAW_QP_ID |
+				  VNIC_CFG_REQ_ENABLES_MRU);
+	req.vnic_id = cpu_to_le16(rdev->mirror_vnic_id);
+	req.raw_qp_id = cpu_to_le32(qp_id);
+	req.mru = cpu_to_le16(rdev->netdev->mtu + VLAN_ETH_HLEN);
+
+	bnxt_re_fill_fw_msg(&fw_msg, (void *)&req, sizeof(req), NULL,
+			    0, DFLT_HWRM_CMD_TIMEOUT);
+	rc = bnxt_send_msg(en_dev, &fw_msg);
+	if (rc)
+		ibdev_dbg(&rdev->ibdev,
+			  "Failed to cfg vnic, rc = %d\n", rc);
+
+	return rc;
+}
+
 /* Query device config using common hwrm */
 static int bnxt_re_hwrm_qcfg(struct bnxt_re_dev *rdev, u32 *db_len,
 			     u32 *offset)
@@ -558,6 +624,7 @@ static int bnxt_re_hwrm_qcfg(struct bnxt_re_dev *rdev, u32 *db_len,
 	if (!rc) {
 		*db_len = PAGE_ALIGN(le16_to_cpu(resp.l2_doorbell_bar_size_kb) * 1024);
 		*offset = PAGE_ALIGN(le16_to_cpu(resp.legacy_l2_db_size_kb) * 1024);
+		rdev->mirror_vnic_id = le16_to_cpu(resp.mirror_vnic_id);
 	}
 	return rc;
 }
-- 
2.43.5


