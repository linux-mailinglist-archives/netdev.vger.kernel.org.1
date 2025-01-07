Return-Path: <netdev+bounces-155696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C627A03586
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 03:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 161F11648A9
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 02:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C09814B087;
	Tue,  7 Jan 2025 02:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="g7iHe1/L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB2A17D358
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 02:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736218419; cv=none; b=obFHi8YopjYz2Y84dwRRHDVXpfAMf81YKu5AS3nwmwO3nNf8v2q73bCsEvPp8wnwLlc2Uert5bHnVzwipAgq8cXV1NBv/cNQTh7ArrL001VvOHFzuq+SukYyrrJvI6BCsthqJOQUewHVkZ4r03GBAqwwCzpckIs/kODhx0yCMZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736218419; c=relaxed/simple;
	bh=9Et+OTL51PQqtzERuMR71pZCuvpO0dF7doaSmf2iD3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lnFZN3fYzzdXjlt5crYlTh/1AgbCJFogaNZGfL0Frw8h78HYyO2E5JrEpSGjBFD/5Kw1pHB5T2tAnbA17bjIGGe6mkEekD04/7RmofJYXuLtgaWg5a+8lPpzCWXSb0CPhzjhMQGnExLOFkcLHeCiwM/gfRCzFnigL7F1BcDIta8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=g7iHe1/L; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-218c8aca5f1so23088015ad.0
        for <netdev@vger.kernel.org>; Mon, 06 Jan 2025 18:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1736218414; x=1736823214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fcVwvAn82oDbL4UZKDanDj9GdX7S4bHhDPNmufyqUqc=;
        b=g7iHe1/LmUDN9CFya0OOQ9gKitZITgLgalmyf8hewHBs3y/NZ5BtrgQJXMeq+qgiHm
         L1mmpZ68uPOu/k7ibaUOZVjbRFZJlCXNMSEKVYDh3QqGe5SE8rBp5oiD+SXH9Evmse6P
         WOPrRSNpWPGtLpN8VaFScRQQD6B6JkUohV+3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736218414; x=1736823214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fcVwvAn82oDbL4UZKDanDj9GdX7S4bHhDPNmufyqUqc=;
        b=aS1HvE+bft3uz/RIFXPqDL/WqDXb95pWVg/oCi6LMWUP7H7c/qR6Ml4SA+dWq4uzMV
         Sn2qjZpCUXE06wT49DEhlsUQ/AwG16FZnIu8goDtQUvE9stBrvvxf3dcsA4MJeZiOyHE
         mudIul0pQNZJNyhwYQ1rNt660205VYAsSX7JZTTmNpLtoWrHRje92qJVYhicq4AQ9XVU
         jJbd9VWf1SUxKZLRUVZsoEFZ3aPNzISYXS4paX4QwksKng4KKje1a9aq8Uu4Y0KOmwOO
         B+JS7PzNNUib1mfwEN/9QVaV5dZvRYAPhCZzPOLZupPOJrUZ9rB87Zmg7gmT29r6bWf2
         FGXA==
X-Forwarded-Encrypted: i=1; AJvYcCXBxfniofjhVCalbZOXXBwW4pnqCcp2uz5fJz1tkrhOYp6sTeiQ8tjeFVfQgFMZJhniDQaNafU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoO1WF+kYsR2MwXM38xjbr/fvcPGipBK3Nwkx6J/dzahNyEg2E
	u6sHgvCXNoUsTs8e5bpySa3NuGMjZzx3xBHfI3JwlCF1GKzesN/YW4hORVOaMg==
X-Gm-Gg: ASbGncv2jLvPKz/qGqlIxPCG+lvlw6De7md8pw+DJaonv9ElmSKegeU+UOk/HfmNcBp
	BazhgIpRUFTkh9OIC3ko0S6FlWuATtleBTvAF8Q1iN/a2EIVMHZIaWvfhto1elJhe3Fp+4YoeMe
	2AOR3R3MXAGqFQOI3p89WWtchLBX3a8oRC+JOvCuFNGt1QYsIN6azjS2ytFUpZyx5Ul64KFQaj4
	pOZM6wm0fhF1tGI45hosKFmSJ/Pqf6O78mcNT5Z2OqPYAcc7cFG+ehOBoJNSaJ4YkBPpFpxpKzh
	bj744c1ICTYgSbvWhSKD6p4/+3G6dIOL9TsVTimvKl7lLAMc/DPtPGGnOTk=
X-Google-Smtp-Source: AGHT+IEQpvEF4lvCoCgENoLYRwJnaTxd3vjOWWeO7RvKuZHfHB2z6ebBtEQL8WpZb0cfxJbZjQdPxA==
X-Received: by 2002:a17:902:d58e:b0:216:4724:2757 with SMTP id d9443c01a7336-219e6e8bc23mr976777985ad.4.1736218414282;
        Mon, 06 Jan 2025 18:53:34 -0800 (PST)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9f692fsm300093285ad.216.2025.01.06.18.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 18:53:33 -0800 (PST)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH rdma-next v2 RESEND 3/4] RDMA/bnxt_re: Query firmware defaults of CC params during probe
Date: Tue,  7 Jan 2025 08:15:51 +0530
Message-ID: <20250107024553.2926983-4-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250107024553.2926983-1-kalesh-anakkur.purayil@broadcom.com>
References: <20250107024553.2926983-1-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added function to query firmware default values of CC parameters
during driver init. These values will be stored in driver local
structure and used in subsequent patch.

Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h  |   1 +
 drivers/infiniband/hw/bnxt_re/main.c     |   5 +
 drivers/infiniband/hw/bnxt_re/qplib_sp.c | 113 +++++++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/qplib_sp.h |   2 +
 4 files changed, 121 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index 018386295bcd..f40aca550328 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -230,6 +230,7 @@ struct bnxt_re_dev {
 	struct dentry			*dbg_root;
 	struct dentry			*qp_debugfs;
 	unsigned long			event_bitmap;
+	struct bnxt_qplib_cc_param	cc_param;
 };
 
 #define to_bnxt_re_dev(ptr, member)	\
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 1dc305689d7b..aa08eb5bbb68 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -2104,6 +2104,11 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 op_type)
 	set_bit(BNXT_RE_FLAG_RESOURCES_INITIALIZED, &rdev->flags);
 
 	if (!rdev->is_virtfn) {
+		/* Query f/w defaults of CC params */
+		rc = bnxt_qplib_query_cc_param(&rdev->qplib_res, &rdev->cc_param);
+		if (rc)
+			ibdev_warn(&rdev->ibdev, "Failed to query CC defaults\n");
+
 		rc = bnxt_re_setup_qos(rdev);
 		if (rc)
 			ibdev_info(&rdev->ibdev,
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
index 7e20ae3d2c4f..d56cc3330d1b 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
@@ -1016,3 +1016,116 @@ int bnxt_qplib_read_context(struct bnxt_qplib_rcfw *rcfw, u8 res_type,
 	dma_free_coherent(&rcfw->pdev->dev, sbuf.size, sbuf.sb, sbuf.dma_addr);
 	return rc;
 }
+
+static void bnxt_qplib_read_cc_gen1(struct bnxt_qplib_cc_param_ext *cc_ext,
+				    struct creq_query_roce_cc_gen1_resp_sb_tlv *sb)
+{
+	cc_ext->inact_th_hi = le16_to_cpu(sb->inactivity_th_hi);
+	cc_ext->min_delta_cnp = le16_to_cpu(sb->min_time_between_cnps);
+	cc_ext->init_cp = le16_to_cpu(sb->init_cp);
+	cc_ext->tr_update_mode = sb->tr_update_mode;
+	cc_ext->tr_update_cyls = sb->tr_update_cycles;
+	cc_ext->fr_rtt = sb->fr_num_rtts;
+	cc_ext->ai_rate_incr = sb->ai_rate_increase;
+	cc_ext->rr_rtt_th = le16_to_cpu(sb->reduction_relax_rtts_th);
+	cc_ext->ar_cr_th = le16_to_cpu(sb->additional_relax_cr_th);
+	cc_ext->cr_min_th = le16_to_cpu(sb->cr_min_th);
+	cc_ext->bw_avg_weight = sb->bw_avg_weight;
+	cc_ext->cr_factor = sb->actual_cr_factor;
+	cc_ext->cr_th_max_cp = le16_to_cpu(sb->max_cp_cr_th);
+	cc_ext->cp_bias_en = sb->cp_bias_en;
+	cc_ext->cp_bias = sb->cp_bias;
+	cc_ext->cnp_ecn = sb->cnp_ecn;
+	cc_ext->rtt_jitter_en = sb->rtt_jitter_en;
+	cc_ext->bytes_per_usec = le16_to_cpu(sb->link_bytes_per_usec);
+	cc_ext->cc_cr_reset_th = le16_to_cpu(sb->reset_cc_cr_th);
+	cc_ext->cr_width = sb->cr_width;
+	cc_ext->min_quota = sb->quota_period_min;
+	cc_ext->max_quota = sb->quota_period_max;
+	cc_ext->abs_max_quota = sb->quota_period_abs_max;
+	cc_ext->tr_lb = le16_to_cpu(sb->tr_lower_bound);
+	cc_ext->cr_prob_fac = sb->cr_prob_factor;
+	cc_ext->tr_prob_fac = sb->tr_prob_factor;
+	cc_ext->fair_cr_th = le16_to_cpu(sb->fairness_cr_th);
+	cc_ext->red_div = sb->red_div;
+	cc_ext->cnp_ratio_th = sb->cnp_ratio_th;
+	cc_ext->ai_ext_rtt = le16_to_cpu(sb->exp_ai_rtts);
+	cc_ext->exp_crcp_ratio = sb->exp_ai_cr_cp_ratio;
+	cc_ext->low_rate_en = sb->use_rate_table;
+	cc_ext->cpcr_update_th = le16_to_cpu(sb->cp_exp_update_th);
+	cc_ext->ai_rtt_th1 = le16_to_cpu(sb->high_exp_ai_rtts_th1);
+	cc_ext->ai_rtt_th2 = le16_to_cpu(sb->high_exp_ai_rtts_th2);
+	cc_ext->cf_rtt_th = le16_to_cpu(sb->actual_cr_cong_free_rtts_th);
+	cc_ext->sc_cr_th1 = le16_to_cpu(sb->severe_cong_cr_th1);
+	cc_ext->sc_cr_th2 = le16_to_cpu(sb->severe_cong_cr_th2);
+	cc_ext->l64B_per_rtt = le32_to_cpu(sb->link64B_per_rtt);
+	cc_ext->cc_ack_bytes = sb->cc_ack_bytes;
+	cc_ext->reduce_cf_rtt_th = le16_to_cpu(sb->reduce_init_cong_free_rtts_th);
+}
+
+int bnxt_qplib_query_cc_param(struct bnxt_qplib_res *res,
+			      struct bnxt_qplib_cc_param *cc_param)
+{
+	struct bnxt_qplib_tlv_query_rcc_sb *ext_sb;
+	struct bnxt_qplib_rcfw *rcfw = res->rcfw;
+	struct creq_query_roce_cc_resp resp = {};
+	struct creq_query_roce_cc_resp_sb *sb;
+	struct bnxt_qplib_cmdqmsg msg = {};
+	struct cmdq_query_roce_cc req = {};
+	struct bnxt_qplib_rcfw_sbuf sbuf;
+	size_t resp_size;
+	int rc;
+
+	/* Query the parameters from chip */
+	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req, CMDQ_BASE_OPCODE_QUERY_ROCE_CC,
+				 sizeof(req));
+	if (bnxt_qplib_is_chip_gen_p5_p7(res->cctx))
+		resp_size = sizeof(*ext_sb);
+	else
+		resp_size = sizeof(*sb);
+
+	sbuf.size = ALIGN(resp_size, BNXT_QPLIB_CMDQE_UNITS);
+	sbuf.sb = dma_alloc_coherent(&rcfw->pdev->dev, sbuf.size,
+				     &sbuf.dma_addr, GFP_KERNEL);
+	if (!sbuf.sb)
+		return -ENOMEM;
+
+	req.resp_size = sbuf.size / BNXT_QPLIB_CMDQE_UNITS;
+	bnxt_qplib_fill_cmdqmsg(&msg, &req, &resp, &sbuf, sizeof(req),
+				sizeof(resp), 0);
+	rc = bnxt_qplib_rcfw_send_message(res->rcfw, &msg);
+	if (rc)
+		goto out;
+
+	ext_sb = sbuf.sb;
+	sb = bnxt_qplib_is_chip_gen_p5_p7(res->cctx) ? &ext_sb->base_sb :
+		(struct creq_query_roce_cc_resp_sb *)ext_sb;
+
+	cc_param->enable = sb->enable_cc & CREQ_QUERY_ROCE_CC_RESP_SB_ENABLE_CC;
+	cc_param->tos_ecn = (sb->tos_dscp_tos_ecn &
+			     CREQ_QUERY_ROCE_CC_RESP_SB_TOS_ECN_MASK) >>
+			    CREQ_QUERY_ROCE_CC_RESP_SB_TOS_ECN_SFT;
+	cc_param->tos_dscp = (sb->tos_dscp_tos_ecn &
+			      CREQ_QUERY_ROCE_CC_RESP_SB_TOS_DSCP_MASK) >>
+			     CREQ_QUERY_ROCE_CC_RESP_SB_TOS_DSCP_SFT;
+	cc_param->alt_tos_dscp = sb->alt_tos_dscp;
+	cc_param->alt_vlan_pcp = sb->alt_vlan_pcp;
+
+	cc_param->g = sb->g;
+	cc_param->nph_per_state = sb->num_phases_per_state;
+	cc_param->init_cr = le16_to_cpu(sb->init_cr);
+	cc_param->init_tr = le16_to_cpu(sb->init_tr);
+	cc_param->cc_mode = sb->cc_mode;
+	cc_param->inact_th = le16_to_cpu(sb->inactivity_th);
+	cc_param->rtt = le16_to_cpu(sb->rtt);
+	cc_param->tcp_cp = le16_to_cpu(sb->tcp_cp);
+	cc_param->time_pph = sb->time_per_phase;
+	cc_param->pkts_pph = sb->pkts_per_phase;
+	if (bnxt_qplib_is_chip_gen_p5_p7(res->cctx)) {
+		bnxt_qplib_read_cc_gen1(&cc_param->cc_ext, &ext_sb->gen1_sb);
+		cc_param->inact_th |= (cc_param->cc_ext.inact_th_hi & 0x3F) << 16;
+	}
+out:
+	dma_free_coherent(&rcfw->pdev->dev, sbuf.size, sbuf.sb, sbuf.dma_addr);
+	return rc;
+}
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.h b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
index e6beeb514b7d..debb26080143 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
@@ -355,6 +355,8 @@ int bnxt_qplib_modify_cc(struct bnxt_qplib_res *res,
 			 struct bnxt_qplib_cc_param *cc_param);
 int bnxt_qplib_read_context(struct bnxt_qplib_rcfw *rcfw, u8 type, u32 xid,
 			    u32 resp_size, void *resp_va);
+int bnxt_qplib_query_cc_param(struct bnxt_qplib_res *res,
+			      struct bnxt_qplib_cc_param *cc_param);
 
 #define BNXT_VAR_MAX_WQE       4352
 #define BNXT_VAR_MAX_SLOT_ALIGN 256
-- 
2.43.5


