Return-Path: <netdev+bounces-216807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF99B3545F
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 08:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44F3B24131F
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 06:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B65D2F549D;
	Tue, 26 Aug 2025 06:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="O5j3yGyE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f97.google.com (mail-oa1-f97.google.com [209.85.160.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D792F8BCB
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 06:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756189262; cv=none; b=VN+AkJguR5TZsWcF3PZQb9oNp8YHnDla9w3Dc8oxCzThR9FNocaZG8PNiPzYPBT+L7Hgi5oIQMpfS+Q7DltgwFiNg+1XrVeJOJXY1/bCkKG1zDJGHpssrp/K5rJmTtlKD+yZhe2He6RUhhIcVwCZ5Xwt0UgRJyrZI/gqxOZWN+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756189262; c=relaxed/simple;
	bh=8eHMI1dJpNfGmRPMeGeM17UxD4c2koHw4cAWay6VUcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qGzozNZM0t6VNGzCdbW0iFdLO2ocyjF6xQaLssXJEyKwc0q5cfrq6fjSY0y2e1YJlqBRW9RyP2HBKPg6hYDOLHylll0fmAQAhoEIkASZHp8yd3/aynnKpEwiSJq1Xiij7Nr8wKmX2N1gz/HgFHFWtj1P8g4Cjr02xrYHXo0QYtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=O5j3yGyE; arc=none smtp.client-ip=209.85.160.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f97.google.com with SMTP id 586e51a60fabf-30ccea8f43cso3605535fac.1
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 23:21:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756189260; x=1756794060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J/LMB3vSl06WMEV8FB1/kl58VTo4A3MhmlzJXN+ClZA=;
        b=fpMRof4mVTO07y5Lbbc4I9I3F0Tg8zsstQCc/mYKSnF1nwUl4LGNzkbyNt6e2j6AsI
         MIn0k6iSOhz7bMyTwtv3K4yqClCMsFmyE0WT451PkV/4xWgHtiXrgnj1EulPYaqRVdwG
         UnYHfwj78lDaOf1XKDlkIRjd5eEGK0ERoCUFIkVvdllnpbIwvtBZm/Ba30AmVCXZEcKk
         6Ki2HZS6fQWAYCuLqF186xRNeF+n+WNfYFB6lFpK7Wam+fLiZdukhepVCJYgyDvdoAyR
         Ycl9UBUMfEykpZc/ImSJdYu1JHtJdCzG1nHfZtSwNvnHOqEvGbEY1emJn1lGelAg37gU
         xwsw==
X-Forwarded-Encrypted: i=1; AJvYcCXWd4E1pgMitsP0KEMYBTcxbB1Vwqvw+x2SMOQ/d/XdDRQxEVWEh9CSK2P4M94jcKFbZYfJFjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTpwE7rWHslG4KdxVJdkfPwKXRD+ii5E240aNiXYjwhpZ4RR+S
	fzGL3EzPLbxxiCQq6ct5XLVsSeCgDw/5pRIanjdp4qtHSAMupPjakpI+NrQFm9ul1m3ayPxziFQ
	YCBIViweZfEsevFxpTFN7Sd3uTaV25p13LAD+aInPRniKjWZuAOzSeO8N4xhWBQTCFx1fsC3k4R
	DEelfUyDJTKOPJTkTCuJJs+bl95Xaip5Tsd/w+Yx1F+Yo6rjzYKRNjx7I0Sxh2PLKsoz59qIGpJ
	QvDrQvpyrmEdnurXBkLZP34
X-Gm-Gg: ASbGncuDYffJJnex/na28eZgv1azWCIjdHOseNYRcgckccQKHiBGiLYWU9V1LFuyVMr
	A9d8mz/oEnX56FH4NtkrB+M5htpwxWFUf2y2RayppzJpOOpcChA+r/z12RDAiUQnbsRnqPbjUMe
	g8IoAzvncx/AkY0A4yl+wNa8pxF2Knl3FdeFj6cN34CAa+cYmnkTL1w/AYFKoQuhFMnAXcN6Ecn
	TM50VmA5Bwhu2Apeh0DeCK49ZxIke7xXQCvbq7GLU9Fw48+80pDLCnguqjPXfpUedZwtu+0LspC
	v9xi/fIBujsouWA4LhITFRmNi3fmAxBfqGUqIZeD6D+l9VoWzDsrOpyJapN0LMFdYLG1AO6Elk9
	VgglgakRvleYGk5td9av9oXCXok6mRU8TOMBM40iB5CXgdhvJ0jH1RUymbtj2np6KDVk3dwjwPF
	BBIYj4v2jR9BCo
X-Google-Smtp-Source: AGHT+IEZagYc0vKo8iKwrAvO2VBMLxp5oUmeaQikkoJh5nUDnoSiErEiHjReQtWPbea2rWAyI7lkxM9majfG
X-Received: by 2002:a05:6870:1f10:b0:30c:30f4:5df9 with SMTP id 586e51a60fabf-315542f82bcmr186883fac.10.1756189259981;
        Mon, 25 Aug 2025 23:20:59 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-314f7930122sm959231fac.2.2025.08.25.23.20.59
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Aug 2025 23:20:59 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3253937f26fso2865210a91.1
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 23:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1756189258; x=1756794058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J/LMB3vSl06WMEV8FB1/kl58VTo4A3MhmlzJXN+ClZA=;
        b=O5j3yGyE7HXVPp9HXmV7Ypi7czaffAqP49caD0JOV/jk7eyjcaRLw+sMmJgDIsXco8
         bkVD4eo+bStrBYAZEg2NMISb5T7tM+ggBx8tNfogKiwNO1VZ05Vo8RBwE9DwVePBtZun
         WlSN1uheOIzuj4ZTGNMscCGq+mtljkppHIYmM=
X-Forwarded-Encrypted: i=1; AJvYcCWXEpDBmigrr8AqcLOslXFElfq9GWf+Islj/Y9hr7E9X/JFlstpGfNCivjSMIdjI7gMybhjzGc=@vger.kernel.org
X-Received: by 2002:a17:90b:1fcd:b0:31f:35f:96a1 with SMTP id 98e67ed59e1d1-3275085dc90mr543765a91.15.1756189258395;
        Mon, 25 Aug 2025 23:20:58 -0700 (PDT)
X-Received: by 2002:a17:90b:1fcd:b0:31f:35f:96a1 with SMTP id 98e67ed59e1d1-3275085dc90mr543731a91.15.1756189257838;
        Mon, 25 Aug 2025 23:20:57 -0700 (PDT)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4c04c7522fsm4392543a12.5.2025.08.25.23.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 23:20:57 -0700 (PDT)
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
	Anantha Prabhu <anantha.prabhu@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH V2 rdma-next 08/10] RDMA/bnxt_re: Initialize fw with roce_mirror support
Date: Tue, 26 Aug 2025 11:55:20 +0530
Message-ID: <20250826062522.1036432-9-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250826062522.1036432-1-kalesh-anakkur.purayil@broadcom.com>
References: <20250826062522.1036432-1-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Saravanan Vajravel <saravanan.vajravel@broadcom.com>

- Check FW capability for roce_mirror support.
- Initialize FW with roce_mirror support.
- When modifying QP, use unique GID for sgid incase of RawEth QP.

Signed-off-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Reviewed-by: Kashyap Desai <kashyap.desai@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
Reviewed-by: Anantha Prabhu <anantha.prabhu@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c   |  2 ++
 drivers/infiniband/hw/bnxt_re/main.c       |  2 ++
 drivers/infiniband/hw/bnxt_re/qplib_fp.c   | 12 +++++++++---
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c |  4 ++++
 drivers/infiniband/hw/bnxt_re/roce_hsi.h   |  1 +
 5 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 90c23d0ee262..f12d6cd3ae93 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1037,6 +1037,8 @@ static u8 __from_ib_qp_type(enum ib_qp_type type)
 		return CMDQ_CREATE_QP_TYPE_RC;
 	case IB_QPT_UD:
 		return CMDQ_CREATE_QP_TYPE_UD;
+	case IB_QPT_RAW_PACKET:
+		return CMDQ_CREATE_QP_TYPE_RAW_ETHERTYPE;
 	default:
 		return IB_QPT_MAX;
 	}
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index fe1be036f8f2..059a4963963a 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -654,6 +654,8 @@ int bnxt_re_hwrm_qcaps(struct bnxt_re_dev *rdev)
 	flags_ext2 = le32_to_cpu(resp.flags_ext2);
 	cctx->modes.dbr_pacing = flags_ext2 & FUNC_QCAPS_RESP_FLAGS_EXT2_DBR_PACING_EXT_SUPPORTED ||
 				 flags_ext2 & FUNC_QCAPS_RESP_FLAGS_EXT2_DBR_PACING_V0_SUPPORTED;
+	cctx->modes.roce_mirror = !!(le32_to_cpu(resp.flags_ext3) &
+				     FUNC_QCAPS_RESP_FLAGS_EXT3_MIRROR_ON_ROCE_SUPPORTED);
 	return 0;
 }
 
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index 092310571dcc..43a4ef76272d 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -1335,6 +1335,7 @@ static bool is_optimized_state_transition(struct bnxt_qplib_qp *qp)
 
 int bnxt_qplib_modify_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 {
+	struct bnxt_qplib_sgid_tbl *sgid_tbl = &res->sgid_tbl;
 	struct bnxt_qplib_rcfw *rcfw = res->rcfw;
 	struct creq_modify_qp_resp resp = {};
 	struct bnxt_qplib_cmdqmsg msg = {};
@@ -1386,9 +1387,14 @@ int bnxt_qplib_modify_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 	if (bmask & CMDQ_MODIFY_QP_MODIFY_MASK_FLOW_LABEL)
 		req.flow_label = cpu_to_le32(qp->ah.flow_label);
 
-	if (bmask & CMDQ_MODIFY_QP_MODIFY_MASK_SGID_INDEX)
-		req.sgid_index = cpu_to_le16(res->sgid_tbl.hw_id
-					     [qp->ah.sgid_index]);
+	if (bmask & CMDQ_MODIFY_QP_MODIFY_MASK_SGID_INDEX) {
+		if (qp->type == CMDQ_CREATE_QP_TYPE_RAW_ETHERTYPE)
+			req.sgid_index =
+				cpu_to_le16(sgid_tbl->hw_id[qp->ugid_index]);
+		else
+			req.sgid_index =
+				cpu_to_le16(sgid_tbl->hw_id[qp->ah.sgid_index]);
+	}
 
 	if (bmask & CMDQ_MODIFY_QP_MODIFY_MASK_HOP_LIMIT)
 		req.hop_limit = qp->ah.hop_limit;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index b97e75404139..5e34395472c5 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -905,6 +905,10 @@ int bnxt_qplib_init_rcfw(struct bnxt_qplib_rcfw *rcfw,
 		flags |= CMDQ_INITIALIZE_FW_FLAGS_OPTIMIZE_MODIFY_QP_SUPPORTED;
 	if (rcfw->res->en_dev->flags & BNXT_EN_FLAG_ROCE_VF_RES_MGMT)
 		flags |= CMDQ_INITIALIZE_FW_FLAGS_L2_VF_RESOURCE_MGMT;
+	if (bnxt_qplib_roce_mirror_supported(rcfw->res->cctx)) {
+		flags |= CMDQ_INITIALIZE_FW_FLAGS_MIRROR_ON_ROCE_SUPPORTED;
+		rcfw->roce_mirror = true;
+	}
 	req.flags |= cpu_to_le16(flags);
 	req.stat_ctx_id = cpu_to_le32(ctx->stats.fw_id);
 	bnxt_qplib_fill_cmdqmsg(&msg, &req, &resp, NULL, sizeof(req), sizeof(resp), 0);
diff --git a/drivers/infiniband/hw/bnxt_re/roce_hsi.h b/drivers/infiniband/hw/bnxt_re/roce_hsi.h
index cfdf69a3fe9a..99ecd72e72e2 100644
--- a/drivers/infiniband/hw/bnxt_re/roce_hsi.h
+++ b/drivers/infiniband/hw/bnxt_re/roce_hsi.h
@@ -219,6 +219,7 @@ struct cmdq_initialize_fw {
 	#define CMDQ_INITIALIZE_FW_FLAGS_HW_REQUESTER_RETX_SUPPORTED     0x2UL
 	#define CMDQ_INITIALIZE_FW_FLAGS_OPTIMIZE_MODIFY_QP_SUPPORTED    0x8UL
 	#define CMDQ_INITIALIZE_FW_FLAGS_L2_VF_RESOURCE_MGMT		 0x10UL
+	#define CMDQ_INITIALIZE_FW_FLAGS_MIRROR_ON_ROCE_SUPPORTED        0x80UL
 	__le16	cookie;
 	u8	resp_size;
 	u8	reserved8;
-- 
2.43.5


