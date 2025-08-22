Return-Path: <netdev+bounces-215904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3B9B30D34
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 06:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 445485E8B40
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 04:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2082B291C11;
	Fri, 22 Aug 2025 04:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hMC1zOky"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F15C263C90
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 04:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755835393; cv=none; b=kmLx7YtO75Ql2yCPp4qCjo6EfxNYeIVnHZQ8acnSupgg7EQ559i5HTOXOcextbKmFYkDT+rodbfZjMDadNu17yy++2AOtIiLJpZ88jigkqnxGK9gD+B7XPsZvYyLPOjUJ+Se9L0yUc+u4FW0TgWHrfXzhTkN06IUZ82hLOQaT3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755835393; c=relaxed/simple;
	bh=8eHMI1dJpNfGmRPMeGeM17UxD4c2koHw4cAWay6VUcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dQodUPgOW6nG3EPcZYd/ipO82WLE42txx+LaZvZ7LwOmXLfu/moKEV2TST+rZTbptREdZStG9uBYTi6mRw+uda/Ibe6fHkLUC8RFYRiTA24AFQpwDyYP22ujQpppnUGyve64E6WK1Qj3rT2MAleAv/T7XiLRVoTykEtYVl0tZ2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hMC1zOky; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-244582738b5so14997755ad.3
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 21:03:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755835391; x=1756440191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J/LMB3vSl06WMEV8FB1/kl58VTo4A3MhmlzJXN+ClZA=;
        b=pgrJ7QrVTgqa5eMc1VpO53O4et5108dvAGvTZ4e0QKisPNA4SA6q0pdc9ihSV8wqMG
         L80YrJaSc1YY9tzkAHKcpUrK51iDwhnaIPx9oWozU46+p1R08EvGVZIrjW8BJoii1pJd
         kg443GJzbaFKBXGwKKJW9JtFVM1r10sESPcAJ0r4NeuHpDfqcZywKonAq1iC/Co90K+k
         7hlV4rg5cUR5Knft6oIz7foRwyURTW+5fTPRjMoyYADVzMTE+1d1NHqZMRZVYXM+BEOu
         RIpRbxjfqkb1F/lNuSKOhaFchbLNxaohIlPLLcEXRTI3R391DMn5cYKt2lM6Na1UcMas
         1Ugw==
X-Forwarded-Encrypted: i=1; AJvYcCU/69rwWXbggKFDVMGFSb6Yto7uGMrYxZPO5+73IUxKbbYW0arzEjk/rhngbLvie8jbsqpS+3I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+OdvS9+pPTl7o7Wn7dJvcnwc3RXpWvl6XtWUi/3KQDSk6Hp4g
	fw9PAKhCMYY+e7O87+4+lMPgi9Ke9mrlQkRV2viqQjd8tviA5G1fDUVnZzxa3Jrnhv6LpKTHXak
	AS2NlTwoTY5DebQaotz3HlcibcrVuIJx23cupifGhQYTFAagIyFTaJ8hhsNH63u8uu9uhh8PLc+
	nz5UEUscyR+v8Es7Al+842iq4m1V7XO9IuEMncsWMUxca+HS7wrprpWESMvk04FT5gA4JKdYdSM
	I6afCX5XgDWwD3R/AtrKCs8
X-Gm-Gg: ASbGncs3NbF2lvBEa6VHuASWW/IFyV2PD5UDxM0YtJ2OtoST3HzyZSjZHSt87wqhxx+
	rNhLIrosQMJ+yyKCKR6pwDpU1OP+2EXbzx1YOpUCaimNkBxsPUXtsjuN6Xzuk9mA7B5QuNMStP0
	r4wrxBC7U4FAdQQLy0IlLHIDrzVAMrYZEjaub+XbRy1tRR+1WfLWLdFm62BY7o/Yfy4LUuqYZ/b
	nszhXyQeDa9xm/8EZyHiprmta+tf0HXR3JY4kxUEeCEQjqG6FEvxect/+Yyw6SZG3FWxCzOT5Pt
	mhoTzJApkxjiWzg7bjoClE7zx7BpkgRvxXsngjFkBz6w6QGN0DDaepeabpV+6cLKyLayvWRJ3kR
	ocJYJve3lbFl4bqKl1sJUXNBil/IFfOYp+akECY/y9O28hXW3ZzfzhN64027ybgHQZJN80KC7CG
	iWoqtY10z8hb16
X-Google-Smtp-Source: AGHT+IGHvUl2rtqXG+oT5N8/3+gEUu7c+x1/JHlb04QnNqTcZdeHhBiShg3cBP/r6niQzbLswbuCFU5cu1aU
X-Received: by 2002:a17:902:f705:b0:242:a3fa:edb4 with SMTP id d9443c01a7336-2462ef6ac7dmr21826925ad.44.1755835390836;
        Thu, 21 Aug 2025 21:03:10 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-245fc761736sm4060415ad.26.2025.08.21.21.03.10
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Aug 2025 21:03:10 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3235e45b815so1978171a91.0
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 21:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755835389; x=1756440189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J/LMB3vSl06WMEV8FB1/kl58VTo4A3MhmlzJXN+ClZA=;
        b=hMC1zOkyqn5yOIdHB8bHUUNgOZTPpMi6vEcxKJxoiC9u/VR2nyGlSZuCsvBTMLcpTm
         uyi6I3gUmwpWoLnq6lArQZV3rgOk1yLye8BM03kWSZCoooTMy3TSZNQ9rwADIuy8MkeC
         3P6sAC7WUoUfS0FEJsgLHszFwd0+wh5lfpS9M=
X-Forwarded-Encrypted: i=1; AJvYcCWgrcT17wFW08iiCc5faHEBcJ/0ijxBJuQzpj55CqDtYotOHLi1umEb6Vibuq7WpYpxq4Y0/fg=@vger.kernel.org
X-Received: by 2002:a17:90b:4f8e:b0:321:38a:229a with SMTP id 98e67ed59e1d1-32515ee4be2mr2464109a91.7.1755835388865;
        Thu, 21 Aug 2025 21:03:08 -0700 (PDT)
X-Received: by 2002:a17:90b:4f8e:b0:321:38a:229a with SMTP id 98e67ed59e1d1-32515ee4be2mr2464057a91.7.1755835388267;
        Thu, 21 Aug 2025 21:03:08 -0700 (PDT)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d0d3abdsm9659814b3a.11.2025.08.21.21.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 21:03:07 -0700 (PDT)
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
Subject: [PATCH rdma-next 08/10] RDMA/bnxt_re: Initialize fw with roce_mirror support
Date: Fri, 22 Aug 2025 09:37:59 +0530
Message-ID: <20250822040801.776196-9-kalesh-anakkur.purayil@broadcom.com>
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


