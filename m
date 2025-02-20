Return-Path: <netdev+bounces-168257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEBDA3E457
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 19:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8936C189F05C
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 18:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E11264F8D;
	Thu, 20 Feb 2025 18:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CqV5TGlh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58E3264630
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 18:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740077762; cv=none; b=fnniODKINRLELVvSlrt0XCmb+gLON5wyC6BldCRXzu1NRlvYnyvmidF7V2LuL+c3rpa1TGilwQL1660iwkG5RuDQSXIa5KVucRAXjCMmGwb+Zh/kS/lviS60xQu8o+8rpMtpFEEeKPGjmFj5Qb8OYoQlqX+N94qiXi5ZrRFmZUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740077762; c=relaxed/simple;
	bh=OO35DOOYWqXdZ4O8hec5kL6h6m3RU0cEIxNWZ1peCks=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ZYUm2es5s1QtIMF7zRSzSDiiVXbYLS7A/kQAnSmycHKo4FtopQPP/tGLVe2ErrTU5CwFLS3dACHqIS333RElTCo5JrD8QaliukXYjLOzLXGfr8xGjf3Buu2FcAZ/Y9rpRKXOsjexFf5Hv7+v/3Ab0Hcfnel1PYH22CiXF3Wtf5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CqV5TGlh; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-220f048c038so23609315ad.2
        for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 10:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1740077760; x=1740682560; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AmBAXHsxWXsrXYjGGcmVq0b9Wu0WtSKDOr6er0hlrAA=;
        b=CqV5TGlh4p2MJMYKQNuZ7iLdmkqcP7mzR4vcAaxFq05Z97B3KF271+KIDYJWOVyT73
         3f7XzcL9yFUQ85FNeceHxWy2z+sY9OsuFRNRqatR558ITaFFz/j+hxvdT1WO45D5aPWp
         THyQ4wo2jLnrPft0sAT+7IyoPSdK1grQ9W2EI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740077760; x=1740682560;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AmBAXHsxWXsrXYjGGcmVq0b9Wu0WtSKDOr6er0hlrAA=;
        b=TRDbs8mllUaREUIfOidHwXsoT4Wnjao/qhJD/s29Uo1lnPcrizP74HRpjEsoLwVaez
         BvQ98qQq5RH0etLIFw9+N2iVMrfZCuE56fk3fnSuUu4B1t2nx6/WmTiiWTh1ifmPGmSR
         S50YbNlhZ33bNI9PZJPNLYwdinLYiDqMhLES7sfRa3SvPFuzHLE707Q3QRoAaHBNu75x
         ZtNk29edfpYXbmO6yDOGJpnLW2VDRClqsOe+Wy7Slz/fnGqMDfvZR5wNc/ZNoT9tKv9g
         zc5KkDHawTWXz/pBipcwhl9BgwbZiPKw0CVucBZIG+zJYbV95lRs/qG3Cam2Zb6/GGGn
         JE5g==
X-Forwarded-Encrypted: i=1; AJvYcCUSaUXcXHXd4xtVurLU4eE/3aIfUaTNYIgl2Qju1Hwg4nrFmEacWtWnQOUQ+40g69PRg0eqmDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdWnr7AybsIAc/NaZAFNokHkpJ/MmvKk6wVzaCFwbe1Vl/IZ33
	iTRoEQ3N2LiM7z4uKWhUgKDx6SLddH1w9emEQc4bAtRZRAU4F5d7R8L1h3WzFw==
X-Gm-Gg: ASbGncuf7a8QCXws2FhUhxfJa1v6t0sTSCBfMTaMkk1rf6Ka1fvBOsJh3feGWmULxzo
	qxY3dKfXu3UdO5vWyNI41ViaER6xei2UyLRHT0iRr5FqLDo3++eq5MWhwvVSfFtZCztI++rngES
	H9ip3ejzj1/QCQb/TtspIvJuxxFxayMisLVjOZ9u8xNo3SNUz/4JyyOzzXXVHRrjHIEZQERJD5t
	nsmeS5Ue9oF12xi50eAygNca/qfch6N0pIW+O81R/8RLZmWEufC5UJcxIrehAEoVvZRH4Pars8+
	tENmgq6DH+MsbTvyeAagJNZaGGaKXY75WLDthEnr0g/onfH4mP4VlRQsSkSAdZGpbqkajNk=
X-Google-Smtp-Source: AGHT+IEvYFGe/Oy8MoaSy7XrmhDwHcku3iPlGrY6y4GGF0RxJLx00BwkgxaeUR0BhRu6J4lU7uyVIg==
X-Received: by 2002:a05:6a21:9215:b0:1ee:e4f0:629 with SMTP id adf61e73a8af0-1eef3ca07b3mr368607637.18.1740077760124;
        Thu, 20 Feb 2025 10:56:00 -0800 (PST)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-addee79a984sm9572262a12.32.2025.02.20.10.55.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Feb 2025 10:55:59 -0800 (PST)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	abeni@redhat.com,
	horms@kernel.org,
	michael.chan@broadcom.com,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH rdma-next 3/9] RDMA/bnxt_re : Initialize the HW context dump collection
Date: Thu, 20 Feb 2025 10:34:50 -0800
Message-Id: <1740076496-14227-4-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1740076496-14227-1-git-send-email-selvin.xavier@broadcom.com>
References: <1740076496-14227-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

From: Kashyap Desai <kashyap.desai@broadcom.com>

HW context of the destroyed resources are returned during
the destroy operation of the resource. Initialize the
data structures to collect the HW contexts. Check if the
FW supports the context dump and initialize the FW to
send the dump to host.

Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/main.c       | 32 ++++++++++++++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c |  2 ++
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h | 12 +++++++++++
 drivers/infiniband/hw/bnxt_re/qplib_res.h  | 14 +++++++++++++
 drivers/infiniband/hw/bnxt_re/roce_hsi.h   |  2 ++
 5 files changed, 62 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 67d2bf0..6b5a169 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -2016,6 +2016,12 @@ static void bnxt_re_free_nqr_mem(struct bnxt_re_dev *rdev)
 
 static void bnxt_re_clean_qdump(struct bnxt_re_dev *rdev)
 {
+	struct bnxt_qplib_rcfw *rcfw = &rdev->rcfw;
+
+	vfree(rcfw->qp_ctxm_data);
+	vfree(rcfw->cq_ctxm_data);
+	vfree(rcfw->srq_ctxm_data);
+	vfree(rcfw->mrw_ctxm_data);
 	vfree(rdev->qdump_head.qdump);
 }
 
@@ -2075,14 +2081,40 @@ static void bnxt_re_worker(struct work_struct *work)
 	schedule_delayed_work(&rdev->worker, msecs_to_jiffies(30000));
 }
 
+static void bnxt_re_init_ctxm_size(struct bnxt_re_dev *rdev)
+{
+	struct bnxt_qplib_rcfw *rcfw = &rdev->rcfw;
+
+	if (bnxt_qplib_is_chip_gen_p7(rdev->chip_ctx)) {
+		rcfw->qp_ctxm_size = BNXT_RE_CONTEXT_TYPE_QPC_SIZE_P7;
+		rcfw->cq_ctxm_size = BNXT_RE_CONTEXT_TYPE_CQ_SIZE_P7;
+		rcfw->srq_ctxm_size = BNXT_RE_CONTEXT_TYPE_SRQ_SIZE_P7;
+		rcfw->mrw_ctxm_size = BNXT_RE_CONTEXT_TYPE_MRW_SIZE_P7;
+
+	} else if (bnxt_qplib_is_chip_gen_p5(rdev->chip_ctx)) {
+		rcfw->qp_ctxm_size = BNXT_RE_CONTEXT_TYPE_QPC_SIZE_P5;
+		rcfw->cq_ctxm_size = BNXT_RE_CONTEXT_TYPE_CQ_SIZE_P5;
+		rcfw->srq_ctxm_size = BNXT_RE_CONTEXT_TYPE_SRQ_SIZE_P5;
+		rcfw->mrw_ctxm_size = BNXT_RE_CONTEXT_TYPE_MRW_SIZE_P5;
+	}
+}
+
 static void bnxt_re_init_qdump(struct bnxt_re_dev *rdev)
 {
+	struct bnxt_qplib_rcfw *rcfw = &rdev->rcfw;
+
 	rdev->qdump_head.max_elements = BNXT_RE_MAX_QDUMP_ENTRIES;
 	rdev->qdump_head.index = 0;
 	rdev->snapdump_dbg_lvl = BNXT_RE_SNAPDUMP_ERR;
 	mutex_init(&rdev->qdump_head.lock);
 	rdev->qdump_head.qdump = vzalloc(rdev->qdump_head.max_elements *
 					 sizeof(struct qdump_array));
+	/* Setup Context cache information */
+	bnxt_re_init_ctxm_size(rdev);
+	rcfw->qp_ctxm_data = vzalloc(BNXT_RE_MAX_QDUMP_ENTRIES * rcfw->qp_ctxm_size);
+	rcfw->cq_ctxm_data = vzalloc(BNXT_RE_MAX_QDUMP_ENTRIES * rcfw->cq_ctxm_size);
+	rcfw->srq_ctxm_data = vzalloc(BNXT_RE_MAX_QDUMP_ENTRIES * rcfw->srq_ctxm_size);
+	rcfw->mrw_ctxm_data = vzalloc(BNXT_RE_MAX_QDUMP_ENTRIES * rcfw->mrw_ctxm_size);
 }
 
 static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 op_type)
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index 17e62f2..435b01f 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -903,6 +903,8 @@ int bnxt_qplib_init_rcfw(struct bnxt_qplib_rcfw *rcfw,
 		flags |= CMDQ_INITIALIZE_FW_FLAGS_OPTIMIZE_MODIFY_QP_SUPPORTED;
 	if (rcfw->res->en_dev->flags & BNXT_EN_FLAG_ROCE_VF_RES_MGMT)
 		flags |= CMDQ_INITIALIZE_FW_FLAGS_L2_VF_RESOURCE_MGMT;
+	if (is_roce_context_destroy_sb_enabled(rcfw->res->dattr->dev_cap_flags2))
+		flags |= CMDQ_INITIALIZE_FW_FLAGS_DESTROY_CONTEXT_SB_SUPPORTED;
 	req.flags |= cpu_to_le16(flags);
 	req.stat_ctx_id = cpu_to_le32(ctx->stats.fw_id);
 	bnxt_qplib_fill_cmdqmsg(&msg, &req, &resp, NULL, sizeof(req), sizeof(resp), 0);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
index 88814cb..155e24f 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
@@ -228,6 +228,18 @@ struct bnxt_qplib_rcfw {
 	struct bnxt_qplib_qp_node *qp_tbl;
 	/* To synchronize the qp-handle hash table */
 	spinlock_t			tbl_lock;
+	u32 qp_ctxm_data_index;
+	u32 cq_ctxm_data_index;
+	u32 mrw_ctxm_data_index;
+	u32 srq_ctxm_data_index;
+	u16 qp_ctxm_size;
+	u16 cq_ctxm_size;
+	u16 mrw_ctxm_size;
+	u16 srq_ctxm_size;
+	void *qp_ctxm_data;
+	void *cq_ctxm_data;
+	void *mrw_ctxm_data;
+	void *srq_ctxm_data;
 	u64 oos_prev;
 	u32 init_oos_stats;
 	u32 cmdq_depth;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infiniband/hw/bnxt_re/qplib_res.h
index be5d907..93200ea 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
@@ -592,4 +592,18 @@ static inline bool _is_cq_coalescing_supported(u16 dev_cap_ext_flags2)
 	return dev_cap_ext_flags2 & CREQ_QUERY_FUNC_RESP_SB_CQ_COALESCING_SUPPORTED;
 }
 
+static inline bool is_roce_context_destroy_sb_enabled(u16 dev_cap_ext_flags2)
+{
+	return !!(dev_cap_ext_flags2 & CREQ_QUERY_FUNC_RESP_SB_DESTROY_CONTEXT_SB_SUPPORTED);
+}
+
+#define BNXT_RE_CONTEXT_TYPE_QPC_SIZE_P5	1088
+#define BNXT_RE_CONTEXT_TYPE_CQ_SIZE_P5		128
+#define BNXT_RE_CONTEXT_TYPE_MRW_SIZE_P5	128
+#define BNXT_RE_CONTEXT_TYPE_SRQ_SIZE_P5	192
+
+#define BNXT_RE_CONTEXT_TYPE_QPC_SIZE_P7	1088
+#define BNXT_RE_CONTEXT_TYPE_CQ_SIZE_P7		192
+#define BNXT_RE_CONTEXT_TYPE_MRW_SIZE_P7	192
+#define BNXT_RE_CONTEXT_TYPE_SRQ_SIZE_P7	192
 #endif /* __BNXT_QPLIB_RES_H__ */
diff --git a/drivers/infiniband/hw/bnxt_re/roce_hsi.h b/drivers/infiniband/hw/bnxt_re/roce_hsi.h
index 0ee60fd..041e9ac 100644
--- a/drivers/infiniband/hw/bnxt_re/roce_hsi.h
+++ b/drivers/infiniband/hw/bnxt_re/roce_hsi.h
@@ -218,6 +218,7 @@ struct cmdq_initialize_fw {
 	#define CMDQ_INITIALIZE_FW_FLAGS_HW_REQUESTER_RETX_SUPPORTED     0x2UL
 	#define CMDQ_INITIALIZE_FW_FLAGS_OPTIMIZE_MODIFY_QP_SUPPORTED    0x8UL
 	#define CMDQ_INITIALIZE_FW_FLAGS_L2_VF_RESOURCE_MGMT		 0x10UL
+	#define CMDQ_INITIALIZE_FW_FLAGS_DESTROY_CONTEXT_SB_SUPPORTED               0x20UL
 	__le16	cookie;
 	u8	resp_size;
 	u8	reserved8;
@@ -2215,6 +2216,7 @@ struct creq_query_func_resp_sb {
 	#define CREQ_QUERY_FUNC_RESP_SB_REQ_RETRANSMISSION_SUPPORT_IQM_MSN_TABLE   (0x2UL << 4)
 	#define CREQ_QUERY_FUNC_RESP_SB_REQ_RETRANSMISSION_SUPPORT_LAST	\
 			CREQ_QUERY_FUNC_RESP_SB_REQ_RETRANSMISSION_SUPPORT_IQM_MSN_TABLE
+	#define CREQ_QUERY_FUNC_RESP_SB_DESTROY_CONTEXT_SB_SUPPORTED             0x100UL
 	#define CREQ_QUERY_FUNC_RESP_SB_MIN_RNR_RTR_RTS_OPT_SUPPORTED            0x1000UL
 	__le16	max_xp_qp_size;
 	__le16	create_qp_batch_size;
-- 
2.5.5


