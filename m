Return-Path: <netdev+bounces-168255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D4FA3E453
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 19:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76EEA4213C4
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 18:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BC9264634;
	Thu, 20 Feb 2025 18:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RZYB1PR6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF93264619
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 18:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740077755; cv=none; b=nKnSTmjHV8zkvvAkmwCEMZkJPMXe5a61K1NszBqcKTHBAw8vwbMSvvX2P/gHv0k+mPbW2r1vcaN4Xwl0mLsTPzqCmCxYQ10454xrOFcl9im4EqjKergeGVz+xkz1pQ0csjqt3rna8qYcgawJB8NG+aI2JkNhYMep5u11CNM9kNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740077755; c=relaxed/simple;
	bh=DRyXIrtbadlAOTbSf4eaomN59p5ysVYTfj15XxsNg3g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=uCl9Ln8hKtKgLthdT+C/EwkqIYb8+ZktE4eJ52VOqHC/w0SMF5huav8tpYCkbtOqC95Mwnf/3d+x79WvEtyV0b1rnjcN82EBudaz1fGI3Te1+TpLVBUMAAOZdvOVrtjFfUV6hIBUyJFFd5l8vmQtgPHvPV2ycGvN5ac5XhDzhg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RZYB1PR6; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-220e83d65e5so25573315ad.1
        for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 10:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1740077752; x=1740682552; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=10BDGIGdjI+2I+pAbbcrEY6QirgZ2x3nU1sHIH+QS5U=;
        b=RZYB1PR6ijthAtsMhmqlMzLE83mJx0DGZRroLbuD73yvXyF0mar2TdIGBlB3lx1ynh
         k1K0yiK5inm9H6NKUc0pBSdBBHPeDuRyCLh2dIauccOpSPbQrCkmmF99qO/KAfMLCjwh
         c8LSkOgvlmIiDQoOnX0eKXGyJBuZsTRgmOv3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740077752; x=1740682552;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=10BDGIGdjI+2I+pAbbcrEY6QirgZ2x3nU1sHIH+QS5U=;
        b=fpfGpPRdPLY8GVWgKuxI6ravk32cEQDnyG1WTe+VTpRwSI9P/SKVP6QMIvR0eM6Gov
         3AMCnALz+WAhwlEdegQpmOghXfMs4Zpc99yrgbd9+pldwD6XgBRU/VhmGF3sYDKsUHLH
         EaLGcHyxtAOOmiWOrO4/E7jNU8qL+M7ZlqVWILqpUQM2SxKYvWAvTygH5DSqPT9tStuS
         jWu4DrlxRyWh5ttmMJzeocUxYoLOSO7k337WOW1yt2gO8eXhPVvVgkDNyyKAj6SK4NpQ
         LtF2++9b0Zs24aVqjrrculbHf1OzUEV5BZIUvgN6NVX56B9XVR3+Sz4yAs+gGMb2vAXu
         V8Xg==
X-Forwarded-Encrypted: i=1; AJvYcCUPLfTn/emqCd3FV6E4G3vm+/8M6/wOmiHub1tVJ5E/0Ue4NTvjymWUC2H5pIWYrtdhtV6Fx9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQiwZMS+hltdEhuRmJp1wZYgxwEhFEC5MUa4R0wsZKAlEg5LF5
	IFxioqiKMK7zkxr9jXC0zK0s3/zkGnDQsL4RKHjj48XKPo1wyL8AntofzF0qRA==
X-Gm-Gg: ASbGncvA0ujVTyccxL0+TvDbKdFF3YjuXW7Ad2zw3CRteLGxFcwY8zqSOIaLwNkBlis
	YJ/8D+Cdpk8WEvGrxImHotvwM62gExhys80hRHtuDznNVEKOyoFtW+QQPWgelq2CVGrCUG7hkSM
	dSa18LeAcO7wGDo8t8Qfvipa9LaUkjVwUDFPqMxlpHL5Itmsmz2LQuxc3rAakglWVgYXn8F6xw4
	J/bYvjJk7oLFvA0tF6DMiYtT4CTvqdocGCLpxybJ3V54TtFaHuXNo2ZHZ1mSPuTEn5oWnzY2q2n
	DQzfOL2Gk/ekNdXIAugXIYoDNOhoty2NEJRVxoiXVstMh6Do0g4xi4e/4g7OLU6pfMKFgNs=
X-Google-Smtp-Source: AGHT+IFjAlHdQjg7jtPWPxhoIoMWi6AdSAqqq3IVW4vbmaqpvymP+c1FKAid6KJD2t7F+UXIzoE+KQ==
X-Received: by 2002:a05:6a20:9184:b0:1ee:ce5b:853d with SMTP id adf61e73a8af0-1eef3dcc063mr381560637.39.1740077752042;
        Thu, 20 Feb 2025 10:55:52 -0800 (PST)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-addee79a984sm9572262a12.32.2025.02.20.10.55.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Feb 2025 10:55:51 -0800 (PST)
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
	Saravanan Vajravel <saravanan.vajravel@broadcom.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH rdma-next 1/9] RDMA/bnxt_re: Add support for collecting the Queue dumps
Date: Thu, 20 Feb 2025 10:34:48 -0800
Message-Id: <1740076496-14227-2-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1740076496-14227-1-git-send-email-selvin.xavier@broadcom.com>
References: <1740076496-14227-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

From: Saravanan Vajravel <saravanan.vajravel@broadcom.com>

As part of enhancing the debug data collection, allocate
few data structures to hold the resources after the queues
are destroyed.

Initialize the data structures to capture the data. By default,
driver will cache the info of the QPs that are in error state.
The dump levels can be changed from debugfs hook in a later
patch. Driver caches the info of the last 1024 entries only.

Signed-off-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h | 64 +++++++++++++++++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/main.c    | 18 ++++++++++
 2 files changed, 82 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index b33b04e..5818db1 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -173,6 +173,67 @@ static inline bool bnxt_re_chip_gen_p7(u16 chip_num)
 		chip_num == CHIP_NUM_57608);
 }
 
+#define BNXT_RE_MAX_QDUMP_ENTRIES 1024
+
+struct qdump_qpinfo {
+	u32 id;
+	u32 dest_qpid;
+	u64 qp_handle;
+	u32 mtu;
+	u8  type;
+	u8  wqe_mode;
+	u8  state;
+	u8  is_user;
+	u64 scq_handle;
+	u64 rcq_handle;
+	u32 scq_id;
+	u32 rcq_id;
+};
+
+struct qdump_mrinfo {
+	int type;
+	u32 lkey;
+	u32 rkey;
+	u64 total_size;
+	u64 mr_handle;
+};
+
+struct qdump_element {
+	struct bnxt_qplib_pbl pbl[PBL_LVL_MAX];
+	enum bnxt_qplib_pbl_lvl level;
+	struct bnxt_qplib_hwq *hwq;
+	struct bnxt_re_dev *rdev;
+	struct ib_umem *umem;
+	bool is_user_qp;
+	char des[32];
+	char *buf;
+	size_t len;
+	u16 stride;
+	u32 prod;
+	u32 cons;
+};
+
+struct qdump_array {
+	struct qdump_qpinfo qpinfo;
+	struct qdump_mrinfo mrinfo;
+	bool valid;
+	bool is_mr;
+};
+
+struct bnxt_re_qdump_head {
+	struct qdump_array *qdump;
+	u32 max_elements;
+	struct mutex lock; /* lock qdump array elements */
+	u32 index;
+};
+
+enum {
+	BNXT_RE_SNAPDUMP_NONE = 0,
+	BNXT_RE_SNAPDUMP_ERR,
+	/* Add new entry before this */
+	BNXT_RE_SNAPDUMP_ALL
+};
+
 struct bnxt_re_dev {
 	struct ib_device		ibdev;
 	struct list_head		list;
@@ -232,6 +293,9 @@ struct bnxt_re_dev {
 	unsigned long			event_bitmap;
 	struct bnxt_qplib_cc_param	cc_param;
 	struct workqueue_struct		*dcb_wq;
+	/* Head to track all QP dump */
+	struct bnxt_re_qdump_head qdump_head;
+	u8 snapdump_dbg_lvl;
 	struct dentry                   *cc_config;
 	struct bnxt_re_dbg_cc_config_params *cc_config_params;
 };
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index e9e4da4..87fdf69 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -2008,6 +2008,11 @@ static void bnxt_re_free_nqr_mem(struct bnxt_re_dev *rdev)
 	rdev->nqr = NULL;
 }
 
+static void bnxt_re_clean_qdump(struct bnxt_re_dev *rdev)
+{
+	vfree(rdev->qdump_head.qdump);
+}
+
 static void bnxt_re_dev_uninit(struct bnxt_re_dev *rdev, u8 op_type)
 {
 	u8 type;
@@ -2018,6 +2023,7 @@ static void bnxt_re_dev_uninit(struct bnxt_re_dev *rdev, u8 op_type)
 	bnxt_re_net_unregister_async_event(rdev);
 	bnxt_re_uninit_dcb_wq(rdev);
 
+	bnxt_re_clean_qdump(rdev);
 	if (test_and_clear_bit(BNXT_RE_FLAG_QOS_WORK_REG, &rdev->flags))
 		cancel_delayed_work_sync(&rdev->worker);
 
@@ -2063,6 +2069,16 @@ static void bnxt_re_worker(struct work_struct *work)
 	schedule_delayed_work(&rdev->worker, msecs_to_jiffies(30000));
 }
 
+static void bnxt_re_init_qdump(struct bnxt_re_dev *rdev)
+{
+	rdev->qdump_head.max_elements = BNXT_RE_MAX_QDUMP_ENTRIES;
+	rdev->qdump_head.index = 0;
+	rdev->snapdump_dbg_lvl = BNXT_RE_SNAPDUMP_ERR;
+	mutex_init(&rdev->qdump_head.lock);
+	rdev->qdump_head.qdump = vzalloc(rdev->qdump_head.max_elements *
+					 sizeof(struct qdump_array));
+}
+
 static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 op_type)
 {
 	struct bnxt_re_ring_attr rattr = {};
@@ -2235,6 +2251,8 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 op_type)
 		hash_init(rdev->srq_hash);
 
 	bnxt_re_debugfs_add_pdev(rdev);
+	if (bnxt_qplib_is_chip_gen_p5_p7(rdev->chip_ctx))
+		bnxt_re_init_qdump(rdev);
 
 	bnxt_re_init_dcb_wq(rdev);
 	bnxt_re_net_register_async_event(rdev);
-- 
2.5.5


