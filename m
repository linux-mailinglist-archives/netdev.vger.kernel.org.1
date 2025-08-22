Return-Path: <netdev+bounces-215898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8312B30D22
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 06:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEA645E8906
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 04:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FE92459D1;
	Fri, 22 Aug 2025 04:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QhP+hDej"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D36280A58
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 04:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755835374; cv=none; b=cjxh3oUTG/D2ydTbHd3spVsq7o8hhjdesSus0hZBldgDEFUGUad16bZit6gCOQDQSf2nKpBYty+YW7OdpU3C44LsdNfigVrPIsKwCW6cJx7+32UkIxt6JRYW5JZe5iiVF+kBmXl3d90lXH1atU3fg2/q/cmjt43wPnDOjRx6fsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755835374; c=relaxed/simple;
	bh=HHxPkKFO68DwvJQ89HY4caOTXRPrZb045gPytbEKCIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GyPtrYIqBE7K76JlwPJW8o99ZFZmrZKYrtcogJI2D1EpJ1bcPXvghEMuJCCBO5XUUS2fJE1vOzWaMO1o2P8U0jNBEWuUPxdRAe3/F2aGNY4zP6wV5Vlmbxp5XcVWWEQXCIGT8YCCPPOpsiBAIcYFBfWsHdXWWuXRXYcoTEhyfpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QhP+hDej; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-246151aefaaso9112245ad.1
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 21:02:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755835371; x=1756440171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bga66DR6seDFuWWS/YdTu2FVMkAZbIW1gGlwkMrpsLU=;
        b=A3bxlp82QsABfBrfXxBnDBY8/x38m5DVSBa4hD5x/0QPwqY4zc/QnquYjTy/zWRNJB
         Ag32ARR/5G+OzDzOeB2zpxA5s4QmGi/aOa7xp7yic/N1AU+umyv2XNIK0SmsBwcuIjgu
         NaOQ2mEMeWMFzjWiJZN+sLAr6Yk/IYSbrf6nW19daLno4ZWefwK86a/QzGnfV+guALNA
         21hdE6rGildh7mR5D1Ox3xK6ggmU/ZWzpYq0MtH85jnuUo4w4qye/7iA1zro0bdPaHCj
         ON6fjBQIMRpkgXDAQf7QvUs9MwKXahf8dW6zE9TnJi4mOvoS09Z4F6iAhpub1J8eVNPJ
         TYcA==
X-Forwarded-Encrypted: i=1; AJvYcCXXFQv6FhQ079j/tYaheVMDmrZpNyj20WFSse2lufNn4bs3YNG6ixIqbm/mXyYdohzslE+Jsd0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym+oTiKNO3I6JadlBeGllIKfCRhcNfvU0l8Q598GvxjrRBApwn
	C9WQRl8J1TBhHrzOBjfAv9g6oSzQix85RWef/bsJR8iB2QgfZfMHvulqx9qcRsBb1NECxcxdKJP
	ROBD51R5vTtJVVZ23eHrZBX1yD5pJd1OOXEtfUeRbyUTYVnvYPlPr47At8TsS0TGDvR/tMRXwyW
	Masp5OpFKb1N6dBsvX9U8j4kO3PX3HGVaSgq3DKsgY4jm4KajLnD0VG7H7p4WAdk/7kt3edrPHX
	JjB2MvhZt9XpGZMU1plUX7z
X-Gm-Gg: ASbGnct8f/p4edXZ5NkcRqLzvGLT+eu9nmUfCyZ/NbSKHvaCEqhBj8Zk9A8emCZh93h
	1GFOnCfwgUbhtabiBb2GQYBPqg6D0kRrc+oqGvhMN75/VO/2jfG0earpc/gsOxSbASPfx84m7BE
	riwfpkgmJYGcsO0bdqE11DTx+hl7x6pemiokAopdpcOm2j1DU+Zc8cLXCjH5ok+72KwpRN2o26V
	RVK85sgoUqd/hC0SBvzq6VUh6jn/BSpaaWDgVxS0GRCKLYLUIrEMGz2kcOw9YJZCSvEAVfD/2h0
	a6HQsiPKFPIvf6gOfgfKu2PRUBdqC+XeTrUcB/PJhCiFfHv5fGc1+kIYTSm++igT3DxFGeBHt53
	cGnTh8M2lz6Y2PasJqymOuT3nh5TM3dNcEKMfAB91smjt4ZtpkpkyYm4LqkBJd0cEHTTF1o3EbK
	oEVwPQ9+USow4c
X-Google-Smtp-Source: AGHT+IHnHZZi5wapaz52Z9AmkGPge7UPGj3+mObg+Els9n/hAtH9qMvobFrKNvGlu1IpmPJOM2EXWaLK2p4p
X-Received: by 2002:a17:902:ce03:b0:234:325:500b with SMTP id d9443c01a7336-246337abb11mr17533135ad.22.1755835371358;
        Thu, 21 Aug 2025 21:02:51 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-245ed4ad753sm6419215ad.75.2025.08.21.21.02.51
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Aug 2025 21:02:51 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-76e1fc66de5so2641916b3a.0
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 21:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755835369; x=1756440169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bga66DR6seDFuWWS/YdTu2FVMkAZbIW1gGlwkMrpsLU=;
        b=QhP+hDejDz+fcvamUuJEZ/zMgVWRlg9vSXJvMQRt96YrihIYtmEiqpq5eFqWCtsGq1
         HoRFsIYM8HyuBvPv7KkcfJinLQUSoANQAfkMQibiulnFW8XKTwCoZ+JBBB0h7cipDPG3
         Umwqnq80H2A9kQNBQfa7GL8TAMV9cq38KAym0=
X-Forwarded-Encrypted: i=1; AJvYcCXzqXvKkzjTS/PJZMrdbKwEAxSuLYIywJxqvl2uSl9CX+6oXifU/cTl33sgbvY7jqefA9VaoXU=@vger.kernel.org
X-Received: by 2002:a05:6a00:1786:b0:770:2c33:2708 with SMTP id d2e1a72fcca58-770305bbb85mr1976574b3a.9.1755835369416;
        Thu, 21 Aug 2025 21:02:49 -0700 (PDT)
X-Received: by 2002:a05:6a00:1786:b0:770:2c33:2708 with SMTP id d2e1a72fcca58-770305bbb85mr1976535b3a.9.1755835368931;
        Thu, 21 Aug 2025 21:02:48 -0700 (PDT)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d0d3abdsm9659814b3a.11.2025.08.21.21.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 21:02:48 -0700 (PDT)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	michael.chan@broadcom.com,
	Saravanan Vajravel <saravanan.vajravel@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH rdma-next 02/10] RDMA/bnxt_re: Add data structures for RoCE mirror support
Date: Fri, 22 Aug 2025 09:37:53 +0530
Message-ID: <20250822040801.776196-3-kalesh-anakkur.purayil@broadcom.com>
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

Added data structures required for supporting mirroring on
RoCE device.

Signed-off-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h    | 5 +++++
 drivers/infiniband/hw/bnxt_re/ib_verbs.h   | 5 +++++
 drivers/infiniband/hw/bnxt_re/qplib_fp.h   | 1 +
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h | 1 +
 drivers/infiniband/hw/bnxt_re/qplib_res.h  | 6 ++++++
 5 files changed, 18 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index b5d0e38c7396..1cb57c8246cc 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -172,6 +172,7 @@ struct bnxt_re_dev {
 	struct list_head		list;
 	unsigned long			flags;
 #define BNXT_RE_FLAG_NETDEV_REGISTERED		0
+#define BNXT_RE_FLAG_STATS_CTX3_ALLOC		1
 #define BNXT_RE_FLAG_HAVE_L2_REF		3
 #define BNXT_RE_FLAG_RCFW_CHANNEL_EN		4
 #define BNXT_RE_FLAG_QOS_WORK_REG		5
@@ -229,6 +230,10 @@ struct bnxt_re_dev {
 	struct bnxt_re_dbg_cc_config_params *cc_config_params;
 #define BNXT_VPD_FLD_LEN	32
 	char			board_partno[BNXT_VPD_FLD_LEN];
+	/* RoCE mirror */
+	u16			mirror_vnic_id;
+	union			ib_gid ugid;
+	u32			ugid_index;
 };
 
 #define to_bnxt_re_dev(ptr, member)	\
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index fe00ab691a51..445a28b3cd96 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -164,6 +164,11 @@ struct bnxt_re_user_mmap_entry {
 	u8 mmap_flag;
 };
 
+struct bnxt_re_flow {
+	struct ib_flow		ib_flow;
+	struct bnxt_re_dev	*rdev;
+};
+
 static inline u16 bnxt_re_get_swqe_size(int nsge)
 {
 	return sizeof(struct sq_send_hdr) + nsge * sizeof(struct sq_sge);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.h b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
index 074c539c69c1..3bd995ced9ca 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
@@ -345,6 +345,7 @@ struct bnxt_qplib_qp {
 	u32				msn_tbl_sz;
 	bool				is_host_msn_tbl;
 	u8				tos_dscp;
+	u32				ugid_index;
 };
 
 #define BNXT_RE_MAX_MSG_SIZE	0x80000000
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
index ff873c5f1b25..988c89b4232e 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
@@ -236,6 +236,7 @@ struct bnxt_qplib_rcfw {
 	atomic_t timeout_send;
 	/* cached from chip cctx for quick reference in slow path */
 	u16 max_timeout;
+	bool roce_mirror;
 };
 
 struct bnxt_qplib_cmdqmsg {
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infiniband/hw/bnxt_re/qplib_res.h
index 6a13927674b4..12e2fa23794a 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
@@ -65,6 +65,7 @@ struct bnxt_qplib_drv_modes {
 	bool db_push;
 	bool dbr_pacing;
 	u32 toggle_bits;
+	u8 roce_mirror;
 };
 
 enum bnxt_re_toggle_modes {
@@ -582,6 +583,11 @@ static inline u8 bnxt_qplib_dbr_pacing_en(struct bnxt_qplib_chip_ctx *cctx)
 	return cctx->modes.dbr_pacing;
 }
 
+static inline u8 bnxt_qplib_roce_mirror_supported(struct bnxt_qplib_chip_ctx *cctx)
+{
+	return cctx->modes.roce_mirror;
+}
+
 static inline bool _is_alloc_mr_unified(u16 dev_cap_flags)
 {
 	return dev_cap_flags & CREQ_QUERY_FUNC_RESP_SB_MR_REGISTER_ALLOC;
-- 
2.43.5


