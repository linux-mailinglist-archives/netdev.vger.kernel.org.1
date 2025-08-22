Return-Path: <netdev+bounces-215897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F162DB30D20
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 06:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FB205E87A8
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 04:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF9F23370F;
	Fri, 22 Aug 2025 04:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="P4GCaXm4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f226.google.com (mail-pf1-f226.google.com [209.85.210.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8846B24166E
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 04:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755835370; cv=none; b=HXeViKT3Fo5CRiEtGLICus8jkq0/Py0LMGOVPyiGhkNq7LqoljdzWqitEh7/YLKZD5BQYdbRS709cagDnicEDl6mdaTe5ZKQlYkNVTmhQ68LUVoXThLSJcHRUEu0KTbhE/x4G2yM81TkUqiPrTVdu6KROeeCeSMu2h/Iyj4vY7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755835370; c=relaxed/simple;
	bh=nxUOv8dfzm63SFp8Xyv5vlUs2tMwxn8JTvMr5g9MoJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=auExdmT0dbFvylPV7uBmwcFRQm42k8g+lkuTB8jSR+nGEXxiywt+sWdsehoJPtmSwlHK/a+BfW7u3RdWMEhbDG8t1TJIFSbaJ5fwZZEQawvP6GMMLZm0ixr+fk7CfOeIOKaU27q7ZM9NWsCNmrD7PWxXkz1f6+UlCUlBJ2yd5sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=P4GCaXm4; arc=none smtp.client-ip=209.85.210.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f226.google.com with SMTP id d2e1a72fcca58-76e2e89e89fso2289946b3a.1
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 21:02:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755835368; x=1756440168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0RmzXB/mtoS5IGKjeLpL7wv74SB+zkqtf+L6pucSh1U=;
        b=sZsTjqZbGnACG2H0VFgC3mayjN/ZL4YLNyvS60mIyA3UhUSMx3f8c8xb9EQGOcV6fv
         jO6SweEZsSnuxThIrmH0Cl/IyUaezsZtWrObM4IvE1/vYP+EqHVAMHPqrk9e3yeNLQRw
         5eAXCz0ZkfJJUYXgjXrCOH+dzGc407dVmYYFdZfe7zqcxuvWMBRmtQccNP7gRyqKBW2K
         IhGGYVwnanNYzQjcwoVN4d5PVdqbP0M52uKBmy+3YLe43ZTidYKV08C6N0eEeC2Iuqke
         7eTignVHK3dfn+12NaPnYkmpjsKz5CR+OBe+RJ4dVQLEtd8fCxviLB3GJI16jm9LvGK1
         SRTw==
X-Forwarded-Encrypted: i=1; AJvYcCX/YtTvhiFjAJeMy12vCYmRURbOOk+Q7xYxhKfVOjz8UWc16D+tknBGLsiqF0qGiRtnPV/CWoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP3hwRf3NuefYUSpC5Zb2QXlRg1iRlN+TpGrCGTrUdCExtZfLZ
	1aAkxEnX46wdV1gj5t5TxjOgX07q3YBpdg7CDw0SWulmNy1Mbcie7Ac233FzKlnTZt5i4Lq3b+S
	n2CXGvlQ3H8ab34bvg6D5vhJqjNoFr9Ps7L5qOPlR6R5KfNVXxGJs/F0zrnn8mYPDaPX3Y3kIH/
	A8/WPMEL2ZiHD4POXqY/sTTTaWG5eVa/5C4jdLxPCvI1DPbwSYKJDz862nVPzFI8S9LsaE5maB0
	2wYN5IEVxmLPdCaEcUkNrj9
X-Gm-Gg: ASbGncuyEEjmHDxPHtHljp+LTnTe3sWcle7RVYA0irg7jCTa0hiTQRz2JsEYeq23mFa
	Sz52oHmZGrbhuSm5Dk273banwF+Q2tvNYf6PAh3jItLF7Z39/BQYonC1BFQCoZ+APqM7KmiD5Sh
	2pie0AD3h3xeLoA67M6AK0gynRPqKx5jBrB88gQ6AmdGt5SxLoJCQuSbVWsv3ACgSnYuiFmfnZW
	ex4kjtc9d2BKZ8P6eMxWGoMeklHGhsZ5RHbsqbJQ5rSiZpevtWA06n+YLQoBcgPPK57wMN5XmoP
	ACUsYtuLvMwaO1S0fULS1Z9Lg+3LGgPOmeQcMhwYJVrX4dViLo02aWngZXEX23m6V/Z5EvXIfLq
	LZLtYx644bZyPM8/SyOnBjJDoShJzTUVawkcBiS0V6l1n4HB/ebm/uuQnIxljtFft+qpxIl/vyr
	cj77QkwaInhYRb
X-Google-Smtp-Source: AGHT+IGF6UeBGmUs/iQoLcEyZeKf1UJoazim92btoRa+WLGcUOCI3m/i7X0EJ05kTmPFCmsDbfLxo60YpGdB
X-Received: by 2002:a05:6a20:734f:b0:240:406b:194c with SMTP id adf61e73a8af0-24340e611b0mr2096190637.41.1755835367737;
        Thu, 21 Aug 2025 21:02:47 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-72.dlp.protect.broadcom.com. [144.49.247.72])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-b476406e7ddsm519511a12.13.2025.08.21.21.02.47
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Aug 2025 21:02:47 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-76e2eb47455so3412791b3a.3
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 21:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755835366; x=1756440166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0RmzXB/mtoS5IGKjeLpL7wv74SB+zkqtf+L6pucSh1U=;
        b=P4GCaXm4hOcqzcKcQ62J3aWF+4PG7kVrIffeBT5Q1AUcHdAf99zlg5rYtkjY3vZQb2
         /jChr7EU2fn4M6jMAhAOVR50NayY94NdJskYtubEn2WPBjrzJDJOkmUYKTIKPm3UQOxn
         dDLX7fTjIMXsMiRBzupn7UgHVpBvrqmhFDFSg=
X-Forwarded-Encrypted: i=1; AJvYcCW9tZlea4lrhEFTsQA6Kh3vfy/XGyBcNZGGYuVSdzVKINAXs+eUYpCQ7JuGV2jDb5nLah2jZz8=@vger.kernel.org
X-Received: by 2002:a05:6a00:4fcf:b0:748:3385:a4a with SMTP id d2e1a72fcca58-7702fad48famr1849712b3a.23.1755835366192;
        Thu, 21 Aug 2025 21:02:46 -0700 (PDT)
X-Received: by 2002:a05:6a00:4fcf:b0:748:3385:a4a with SMTP id d2e1a72fcca58-7702fad48famr1849690b3a.23.1755835365729;
        Thu, 21 Aug 2025 21:02:45 -0700 (PDT)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d0d3abdsm9659814b3a.11.2025.08.21.21.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 21:02:45 -0700 (PDT)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	michael.chan@broadcom.com,
	Saravanan Vajravel <saravanan.vajravel@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH rdma-next 01/10] bnxt_en: Enhance stats context reservation logic
Date: Fri, 22 Aug 2025 09:37:52 +0530
Message-ID: <20250822040801.776196-2-kalesh-anakkur.purayil@broadcom.com>
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

When the firmware advertises that the device is capable of supporting
port mirroring on RoCE device, reserve one additional stat_ctx.
To support port mirroring feature, RDMA driver allocates one stat_ctx
for exclusive use in RawEth QP.

Signed-off-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Kashyap Desai <kashyap.desai@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
Reviewed-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 8 ++++++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     | 3 +++
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c | 6 ++++++
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 5578ddcb465d..751840fff0dc 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -9601,10 +9601,10 @@ static int __bnxt_hwrm_ptp_qcfg(struct bnxt *bp)
 
 static int __bnxt_hwrm_func_qcaps(struct bnxt *bp)
 {
+	u32 flags, flags_ext, flags_ext2, flags_ext3;
+	struct bnxt_hw_resc *hw_resc = &bp->hw_resc;
 	struct hwrm_func_qcaps_output *resp;
 	struct hwrm_func_qcaps_input *req;
-	struct bnxt_hw_resc *hw_resc = &bp->hw_resc;
-	u32 flags, flags_ext, flags_ext2;
 	int rc;
 
 	rc = hwrm_req_init(bp, req, HWRM_FUNC_QCAPS);
@@ -9671,6 +9671,10 @@ static int __bnxt_hwrm_func_qcaps(struct bnxt *bp)
 	    (flags_ext2 & FUNC_QCAPS_RESP_FLAGS_EXT2_ROCE_VF_RESOURCE_MGMT_SUPPORTED))
 		bp->fw_cap |= BNXT_FW_CAP_ROCE_VF_RESC_MGMT_SUPPORTED;
 
+	flags_ext3 = le32_to_cpu(resp->flags_ext3);
+	if (flags_ext3 & FUNC_QCAPS_RESP_FLAGS_EXT3_MIRROR_ON_ROCE_SUPPORTED)
+		bp->fw_cap |= BNXT_FW_CAP_MIRROR_ON_ROCE;
+
 	bp->tx_push_thresh = 0;
 	if ((flags & FUNC_QCAPS_RESP_FLAGS_PUSH_MODE_SUPPORTED) &&
 	    BNXT_FW_MAJ(bp) > 217)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index fda0d3cc6227..fa2b39b55e68 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2507,6 +2507,7 @@ struct bnxt {
 	#define BNXT_FW_CAP_VNIC_RE_FLUSH		BIT_ULL(40)
 	#define BNXT_FW_CAP_SW_MAX_RESOURCE_LIMITS	BIT_ULL(41)
 	#define BNXT_FW_CAP_NPAR_1_2			BIT_ULL(42)
+	#define BNXT_FW_CAP_MIRROR_ON_ROCE		BIT_ULL(43)
 
 	u32			fw_dbg_cap;
 
@@ -2528,6 +2529,8 @@ struct bnxt {
 	((bp)->fw_cap & BNXT_FW_CAP_ROCE_VF_RESC_MGMT_SUPPORTED)
 #define BNXT_SW_RES_LMT(bp)		\
 	((bp)->fw_cap & BNXT_FW_CAP_SW_MAX_RESOURCE_LIMITS)
+#define BNXT_MIRROR_ON_ROCE_CAP(bp)	\
+	((bp)->fw_cap & BNXT_FW_CAP_MIRROR_ON_ROCE)
 
 	u32			hwrm_spec_code;
 	u16			hwrm_cmd_seq;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
index 61cf201bb0dc..f8c2c72b382d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
@@ -100,6 +100,12 @@ void bnxt_set_dflt_ulp_stat_ctxs(struct bnxt *bp)
 		if (BNXT_PF(bp) && !bp->pf.port_id &&
 		    bp->port_count > 1)
 			bp->edev->ulp_num_ctxs++;
+
+		/* Reserve one additional stat_ctx when the device is capable
+		 * of supporting port mirroring on RDMA device.
+		 */
+		if (BNXT_MIRROR_ON_ROCE_CAP(bp))
+			bp->edev->ulp_num_ctxs++;
 	}
 }
 
-- 
2.43.5


