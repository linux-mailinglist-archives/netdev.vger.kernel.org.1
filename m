Return-Path: <netdev+bounces-168262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13197A3E470
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 20:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E244C16FEAD
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 18:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A202641DC;
	Thu, 20 Feb 2025 18:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bUGHchtp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE678266585
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 18:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740077782; cv=none; b=OMzh5wX6QQOxXQn/2TKVKALIhQ8waqgZ1Bpf2xjZhzkXu7BzUGK9eSUQ24ase3XzNA4KqLBlERVzaw0TrGmp05MoPAwe3u+r6CZXZ4mhRQ9iElqBnSABmbJGa2JV6pBi47M7LpctA/DHJjPNY8SVZh5idV5jXz1/hgZrDJmgPQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740077782; c=relaxed/simple;
	bh=ps9j0Wix5FxOg6J4lOpwhIo0pwUPZtapGIIm3Ker8C8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=XBMASTO+9IiRWbYeVkfbvLwb1toZq7PfZqn2Jw+AGSYAPuR+T9T/9yLvidpZRZHvwblLZyvi+q2vF2xcAxBxoZt1zCUZA2/jXWqaWEoBdTAdxdDbraZrnkIvm3kVUsbHNszX88xyX+0xr5NxEmmrZbMdmvkP+JODJ83BC+jc3E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bUGHchtp; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220c4159f87so18527155ad.0
        for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 10:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1740077780; x=1740682580; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tif6h+vIQ6/biBxnmUJxR84piPWX45JJ651sYhwJ4MA=;
        b=bUGHchtplBXLKm8Rk3lJo84LP25Yj4pfjWc7sMUIBtgO8w7ZhoV0/di4HrhBAt6qbD
         LwE4rcicn4EQnf/tndGKWC3h357DwLjSRyrKKz0LZ/r4XgxrD28jzDLtySI1YL8+/9ha
         yWqmbC9q7KkVOCIu4wdA91gsxB7gjZsb6Re4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740077780; x=1740682580;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tif6h+vIQ6/biBxnmUJxR84piPWX45JJ651sYhwJ4MA=;
        b=f6KT9PT++U2z9xboCGn6vF1DtWerX505Eo+zpdWZ+qc3B4C8CRNju9MO5AFnTtG3iJ
         qpSOXrN8FM3t4A8TDqWndfQnhHOwq+byGGvsKdww/IpBZrSp9PTQ91Mihk7x8LReK3Qu
         +dRipChwzrCfpqGIP7Bns3L9zkFk0UAU1Nr4619fZzTNHj7x8bn+E55Jsjt1LbaZmNXB
         NNNg+uN8G+PanCTNXBHVdH2+wSh+bbrXzgUz6X3k8JKle5i+Ee0ROfZAsOe/J3+tynS/
         pQPnzgKu6FldON0xt1VCMe7KxTgB91hPXKktWhMtCiYqrNoYBg7aSpdt/ZydIYKSpWR+
         Tpug==
X-Forwarded-Encrypted: i=1; AJvYcCXM97yY5hPMZN/3bJUshSjrYrjwtGo8MmUVoOdy8fOJEFG6ODngUInUXRaB+tdoi4H/T6aGvMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO5FHFfGdR5Wop8OdW3LwDauIgeLnCE6/0o9inodWaM7u6mGtB
	Rq5uaqPFrOV2IpL9e8UdVibk8NyxmNhyT/kH+qIw2IizbW6NUdK6JijuLHHyQw==
X-Gm-Gg: ASbGncuyceABtz9QHh9qNH4mkVbfuCsfHORAmHvEZp2DknNCyMcMjnRfXCzrO9fNN0R
	GTRNgswRip3GgmTqwUoDu05G4K41QOAJzEqhnxRiKLtL/wBh6J7q1xO7UHuUPSZ5LUZmEg8rKF3
	KpSpYWgy0f54l695pzbKTdei15nq5aJx+1ljPk8ukb2CTOq7tgsJkdzSWI/UNKXFMFmxM0rI/fq
	qtFu77weY/74Or31q59iK9sNe94a4hZZj5aO7DzLotw8m67KtVZKfPPZHjkFg5SGeJ2qhHP2KEB
	Yy5qjjRreZC7QpjStD5PLrnKRwsgK4Sr545zQRD8G90/EKC43ovR6uItSJX4Ymn1jz+6gOo=
X-Google-Smtp-Source: AGHT+IFw4WLUXvlZeVZ7DNjlcwoAVhBgMp/91u56hwsVYXz4XkQ5BCYpHuWdsyyiEkUv1s+GRqSPCw==
X-Received: by 2002:a05:6a21:6b0f:b0:1ee:c093:e23c with SMTP id adf61e73a8af0-1eef3db70e6mr504945637.41.1740077780108;
        Thu, 20 Feb 2025 10:56:20 -0800 (PST)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-addee79a984sm9572262a12.32.2025.02.20.10.56.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Feb 2025 10:56:19 -0800 (PST)
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
Subject: [PATCH rdma-next 8/9] RDMA/bnxt_re: Dump the HW context information
Date: Thu, 20 Feb 2025 10:34:55 -0800
Message-Id: <1740076496-14227-9-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1740076496-14227-1-git-send-email-selvin.xavier@broadcom.com>
References: <1740076496-14227-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

From: Kashyap Desai <kashyap.desai@broadcom.com>

Dump the cached HW context information for QP/CQ/SRQ/MRs
when the L2 driver queries using get_dump_data

Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 10 ++++-----
 drivers/infiniband/hw/bnxt_re/main.c     | 38 ++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index a1ee6ca..dca435e 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1079,7 +1079,7 @@ int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata)
 	struct bnxt_qplib_nq *rcq_nq = NULL;
 	unsigned int flags;
 	void  *ctx_sb_data = NULL;
-	bool do_snapdump;
+	bool do_snapdump = false;
 	u16 ctx_size;
 	int rc;
 
@@ -1087,17 +1087,15 @@ int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata)
 	bnxt_re_debug_rem_qpinfo(rdev, qp);
 
 	bnxt_qplib_flush_cqn_wq(&qp->qplib_qp);
-	ctx_size = qplib_qp->ctx_size_sb;
+	ctx_size = rdev->rcfw.qp_ctxm_size;
 	if (ctx_size)
 		ctx_sb_data = vzalloc(ctx_size);
-	do_snapdump = test_bit(QP_FLAGS_CAPTURE_SNAPDUMP, &qplib_qp->flags);
 
 	rc = bnxt_qplib_destroy_qp(&rdev->qplib_res, &qp->qplib_qp, ctx_size, ctx_sb_data);
 	if (rc)
 		ibdev_err(&rdev->ibdev, "Failed to destroy HW QP");
-	else
-		bnxt_re_save_resource_context(rdev, ctx_sb_data,
-					      BNXT_RE_RES_TYPE_QP, do_snapdump);
+	do_snapdump = test_bit(QP_FLAGS_CAPTURE_SNAPDUMP, &qplib_qp->flags);
+	bnxt_re_save_resource_context(rdev, ctx_sb_data,  BNXT_RE_RES_TYPE_QP, do_snapdump);
 
 	vfree(ctx_sb_data);
 	if (rdma_is_kernel_res(&qp->ib_qp.res)) {
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index afde0ef..b2bf0d0 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -506,6 +506,44 @@ static void bnxt_re_start_irq(void *handle, struct bnxt_msix_entry *ent)
 static void bnxt_re_dump_ctx(struct bnxt_re_dev *rdev, u32 seg_id, void *buf,
 			     u32 buf_len)
 {
+	int ctx_index, i;
+	void *ctx_data;
+	u16 ctx_size;
+
+	switch (seg_id) {
+	case BNXT_SEGMENT_QP_CTX:
+		ctx_data = rdev->rcfw.qp_ctxm_data;
+		ctx_size = rdev->rcfw.qp_ctxm_size;
+		ctx_index = rdev->rcfw.qp_ctxm_data_index;
+		break;
+	case BNXT_SEGMENT_CQ_CTX:
+		ctx_data = rdev->rcfw.cq_ctxm_data;
+		ctx_size = rdev->rcfw.cq_ctxm_size;
+		ctx_index = rdev->rcfw.cq_ctxm_data_index;
+		break;
+	case BNXT_SEGMENT_MR_CTX:
+		ctx_data = rdev->rcfw.mrw_ctxm_data;
+		ctx_size = rdev->rcfw.mrw_ctxm_size;
+		ctx_index = rdev->rcfw.mrw_ctxm_data_index;
+		break;
+	case BNXT_SEGMENT_SRQ_CTX:
+		ctx_data = rdev->rcfw.srq_ctxm_data;
+		ctx_size = rdev->rcfw.srq_ctxm_size;
+		ctx_index = rdev->rcfw.srq_ctxm_data_index;
+		break;
+	default:
+		return;
+	}
+
+	if (!ctx_data || (ctx_size * BNXT_RE_MAX_QDUMP_ENTRIES) > buf_len)
+		return;
+
+	for (i = ctx_index; i < BNXT_RE_MAX_QDUMP_ENTRIES + ctx_index; i++) {
+		memcpy(buf, ctx_data + ((i % BNXT_RE_MAX_QDUMP_ENTRIES) * ctx_size),
+		       ctx_size);
+		buf += ctx_size;
+	}
+
 }
 
 /*
-- 
2.5.5


