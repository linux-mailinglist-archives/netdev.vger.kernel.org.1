Return-Path: <netdev+bounces-216804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E910AB35462
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 08:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC5371B65CD4
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 06:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B550E2F747F;
	Tue, 26 Aug 2025 06:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bpF3gDX0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f225.google.com (mail-qt1-f225.google.com [209.85.160.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC272F7478
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 06:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756189252; cv=none; b=baW/UB/cz/llaBBt8oAvKA4hwGJi/cvOU8ANCId+6XwT0+EmUk4wKQGtCJGmeb1478oV4FLe+WSTxbmcgNTkOpXb4lZCdpip9ZnMu5CNNjZJT1SCvVr0kcn1K+8IlWl1F1DJkwO6ZsSjwar0iIS8o1MjiZD/P+7lLlj6OKjV8ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756189252; c=relaxed/simple;
	bh=kgLWykzDGE/b6FrWKGyRLhq2eXNsrpe9+bBTJFazARk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JZrBizYQkgpRbaMd8At747R6HkQBUJsmsq2cbrgqUlohRIEfdEJZCM8UT1VTxR8DqIW9wpBvi0P4V6vsTY0fHAzqccwk5fVmD/7xMwRtQBvnBOdvEr6QXpfFEBlmJsAORrMhmcj4faBG5Z8FpVfuxUPWNnOtOoUON7lvstARYM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bpF3gDX0; arc=none smtp.client-ip=209.85.160.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f225.google.com with SMTP id d75a77b69052e-4b1099192b0so94471901cf.0
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 23:20:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756189250; x=1756794050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zBBZzN7y0OVyFseGBaJQazrtC2PqzNlf45FYh0j9gF4=;
        b=Yo8ZHg6ZIpsjLckwUgMFHyUvRcFcn1p5+yknY5pzClQvSA0KM23o+dVmOgWGNsOu4P
         GkXG4tjsot6fMSS7pYNVso5xrxLVjnseVksWceUWZumVCM5YLxX1T/1+OuYGM5cAWeVX
         rPKSolZTSlDqx+rkBkHPq5DAa/7Cu8p2c9+n7kuqVaAAFPoK4e6RjlWNYZae7GT2MM+x
         7e9MZLmds8NmUKMeDO/qSQo1pje5+kkOIQBdwXYuP3L8m59rvUy3gC+bseZDZJxxq+Gp
         NfLlbxcHWpD8xYJaik1kQ0ae8rPnNY5keRyRrBOLRu+8eYQqV5uiW8ECEWlwikykr3TZ
         e+1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUFuxGW6U2CI0j0RR/wQX1a+ZpRcWTYw+6sDZCn6bPIq++GTxw1iFPU/E7Vjt61XhAV14M83Jw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/bXkIFsyljLRYVQ7bHfxVzcnLy0PX3Mc8/EBcHYqceAIw4lnx
	szsEPT2Bd+ZVeSnzZ9tIO6G0/c4CQbI8kQPUJKs1Bvwey6+0Ient4Au6owbhHAqBdgmnx/EjGRo
	7Qa4b4Rgnrv2F9fnSgHXEYWASldJ9Eu5swWcPeQjlz5dV8EvXt2Ok4LBe8XZmE6LbtsiYEh1xKR
	WtC6yQHYZsvFODtjBImWvuuOsQMZhZXvvtWP4PsNq7KNpKm7x0n8V/vG0BTUv/gzF68I+PJim/C
	jQRJ1+KFK3YnESKqmpdRZnA
X-Gm-Gg: ASbGncsQcy32DtNG2wvmPXqQ+9d4MPyUfDWKTwpuRPReUz4XK7XyEceYdaKHGp5O9oD
	cY2iwNECiJp3RaYIjZxyMPVji0PMM2SLMAIvavA8MZTD1YJArgDBhCYCJ5RAMp39cJbEcSn8mRW
	iXu5tcRKwwY71B++TGk0rLeothr7XfuSqKHKrZ8bM7HrjCcmCwSVxtmAF+Xf+pIXQCb6W+LoiMU
	6fdv61BhmHMW3hRXZC+dPuwf7Qfb8NiKwc9E3eZv12asGl2jRFSWPxrICGZnt0d26DBXfU6fehF
	vgt7mi3W4OgeB4fg6HCrEguE2TLLAEYInHZnFxl6Z1RqF9BKKag5N2UDGJDNhXI85BeDZmMKdy/
	pemiaKoyCwXOw7XCkxL09HkX9avZSOCoKPDf6Pi4aPfbidTXb2zolVGGG7B1LyL1IFb5eEe8aD+
	VNnf+bNZL0+PR2
X-Google-Smtp-Source: AGHT+IFbXAXkBcxZQkLzL5MXB8bZXwFMPN9++V7PRc8FH5q6pZq+5ROVKSa9PubR+NAQXgkVSFpjzm1Qsiwj
X-Received: by 2002:a05:622a:1b0e:b0:4b0:ed9d:60ca with SMTP id d75a77b69052e-4b2aaa7ff79mr151179311cf.10.1756189249648;
        Mon, 25 Aug 2025 23:20:49 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-4b2b8c6dd80sm3297811cf.5.2025.08.25.23.20.49
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Aug 2025 23:20:49 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-324e41e946eso9664808a91.0
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 23:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1756189248; x=1756794048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zBBZzN7y0OVyFseGBaJQazrtC2PqzNlf45FYh0j9gF4=;
        b=bpF3gDX09dPa9eVn8zVK/caqPsSVHHZ9eJT5XRVVsBrS0DN+ZAxsAqPheK/JXBZRbG
         AHH9e2MuRWJXM5snI8g/CIWkV42+IjCGLHx4k+piHpzISYK9Ymxxi4LvYUpJj+Rsd/Xv
         LpYlkQQS/yiMtxBl32AM8KxvyAFyKpAv7NT8Q=
X-Forwarded-Encrypted: i=1; AJvYcCXW5u7YfrMmT82wHbmZTiVFFqQAch8cXhbJSho/akZ6QxXZN6l6/StDnRd8n1pqqZEoHtdT03E=@vger.kernel.org
X-Received: by 2002:a17:90b:3e44:b0:31e:ebb6:6499 with SMTP id 98e67ed59e1d1-32515ec135dmr20647362a91.24.1756189248124;
        Mon, 25 Aug 2025 23:20:48 -0700 (PDT)
X-Received: by 2002:a17:90b:3e44:b0:31e:ebb6:6499 with SMTP id 98e67ed59e1d1-32515ec135dmr20647332a91.24.1756189247590;
        Mon, 25 Aug 2025 23:20:47 -0700 (PDT)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4c04c7522fsm4392543a12.5.2025.08.25.23.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 23:20:47 -0700 (PDT)
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
Subject: [PATCH V2 rdma-next 05/10] RDMA/bnxt_re: Add support for unique GID
Date: Tue, 26 Aug 2025 11:55:17 +0530
Message-ID: <20250826062522.1036432-6-kalesh-anakkur.purayil@broadcom.com>
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

- RawEth QP requires unique GID so that per function stats_ctx
  is not polluted by packets mirrored to RoCE vnic.
- Added support to add unique GID when RawEth type QP is created.
- Added support to destroy unique GID when RawEth type QP is
  destroyed.
- Allocated exclusive stats_ctx to use for RawEth type QP.

Signed-off-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Reviewed-by: Kashyap Desai <kashyap.desai@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c  | 57 ++++++++++++++++++++++-
 drivers/infiniband/hw/bnxt_re/main.c      | 42 +++++++++++++++++
 drivers/infiniband/hw/bnxt_re/qplib_res.h |  1 +
 drivers/infiniband/hw/bnxt_re/qplib_sp.c  |  6 ++-
 drivers/infiniband/hw/bnxt_re/qplib_sp.h  |  3 +-
 5 files changed, 105 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 195a9ba6f65d..c83809c72f5b 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -288,7 +288,9 @@ int bnxt_re_query_port(struct ib_device *ibdev, u32 port_num,
 	}
 	port_attr->max_mtu = IB_MTU_4096;
 	port_attr->active_mtu = iboe_get_mtu(rdev->netdev->mtu);
-	port_attr->gid_tbl_len = dev_attr->max_sgid;
+	/* One GID is reserved for RawEth QP. Report one less */
+	port_attr->gid_tbl_len = (rdev->rcfw.roce_mirror ? (dev_attr->max_sgid - 1) :
+				  dev_attr->max_sgid);
 	port_attr->port_cap_flags = IB_PORT_CM_SUP | IB_PORT_REINIT_SUP |
 				    IB_PORT_DEVICE_MGMT_SUP |
 				    IB_PORT_VENDOR_CLASS_SUP;
@@ -429,7 +431,7 @@ int bnxt_re_add_gid(const struct ib_gid_attr *attr, void **context)
 
 	rc = bnxt_qplib_add_sgid(sgid_tbl, (struct bnxt_qplib_gid *)&attr->gid,
 				 rdev->qplib_res.netdev->dev_addr,
-				 vlan_id, true, &tbl_idx);
+				 vlan_id, true, &tbl_idx, false, 0);
 	if (rc == -EALREADY) {
 		ctx_tbl = sgid_tbl->ctx;
 		ctx_tbl[tbl_idx]->refcnt++;
@@ -955,6 +957,20 @@ static int bnxt_re_destroy_gsi_sqp(struct bnxt_re_qp *qp)
 	return rc;
 }
 
+static void bnxt_re_del_unique_gid(struct bnxt_re_dev *rdev)
+{
+	int rc;
+
+	if (!rdev->rcfw.roce_mirror)
+		return;
+
+	rc = bnxt_qplib_del_sgid(&rdev->qplib_res.sgid_tbl,
+				 (struct bnxt_qplib_gid *)&rdev->ugid,
+				 0xFFFF, true);
+	if (rc)
+		dev_err(rdev_to_dev(rdev), "Failed to delete unique GID, rc: %d\n", rc);
+}
+
 /* Queue Pairs */
 int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata)
 {
@@ -994,6 +1010,9 @@ int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct ib_udata *udata)
 	else if (qp->qplib_qp.type == CMDQ_CREATE_QP_TYPE_UD)
 		atomic_dec(&rdev->stats.res.ud_qp_count);
 
+	if (qp->qplib_qp.type == CMDQ_CREATE_QP_TYPE_RAW_ETHERTYPE)
+		bnxt_re_del_unique_gid(rdev);
+
 	ib_umem_release(qp->rumem);
 	ib_umem_release(qp->sumem);
 
@@ -1595,6 +1614,29 @@ static bool bnxt_re_test_qp_limits(struct bnxt_re_dev *rdev,
 	return rc;
 }
 
+static int bnxt_re_add_unique_gid(struct bnxt_re_dev *rdev)
+{
+	struct bnxt_qplib_ctx *hctx = &rdev->qplib_ctx;
+	struct bnxt_qplib_res *res = &rdev->qplib_res;
+	int rc;
+
+	if (!rdev->rcfw.roce_mirror)
+		return 0;
+
+	rdev->ugid.global.subnet_prefix = cpu_to_be64(0xfe8000000000abcdLL);
+	addrconf_ifid_eui48(&rdev->ugid.raw[8], rdev->netdev);
+
+	rc = bnxt_qplib_add_sgid(&res->sgid_tbl,
+				 (struct bnxt_qplib_gid *)&rdev->ugid,
+				 rdev->qplib_res.netdev->dev_addr,
+				 0xFFFF, true, &rdev->ugid_index, true,
+				 hctx->stats3.fw_id);
+	if (rc)
+		dev_err(rdev_to_dev(rdev), "Failed to add unique GID. rc = %d\n", rc);
+
+	return rc;
+}
+
 int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 		      struct ib_udata *udata)
 {
@@ -1656,6 +1698,17 @@ int bnxt_re_create_qp(struct ib_qp *ib_qp, struct ib_qp_init_attr *qp_init_attr,
 		}
 	}
 
+	/* Support for RawEth QP is added to capture TCP pkt dump.
+	 * So unique SGID is used to avoid incorrect statistics on per
+	 * function stats_ctx
+	 */
+	if (qp->qplib_qp.type == CMDQ_CREATE_QP_TYPE_RAW_ETHERTYPE) {
+		rc = bnxt_re_add_unique_gid(rdev);
+		if (rc)
+			goto qp_destroy;
+		qp->qplib_qp.ugid_index = rdev->ugid_index;
+	}
+
 	qp->ib_qp.qp_num = qp->qplib_qp.id;
 	if (qp_init_attr->qp_type == IB_QPT_GSI)
 		rdev->gsi_ctx.gsi_qp = qp;
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index c25eb2525a8f..479c2a390885 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -2006,6 +2006,42 @@ static int bnxt_re_get_stats_ctx(struct bnxt_re_dev *rdev)
 	return rc;
 }
 
+static int bnxt_re_get_stats3_ctx(struct bnxt_re_dev *rdev)
+{
+	struct bnxt_qplib_ctx *hctx = &rdev->qplib_ctx;
+	struct bnxt_qplib_res *res = &rdev->qplib_res;
+	int rc;
+
+	if (!rdev->rcfw.roce_mirror)
+		return 0;
+
+	rc = bnxt_qplib_alloc_stats_ctx(res->pdev, res->cctx, &hctx->stats3);
+	if (rc)
+		return rc;
+
+	rc = bnxt_re_net_stats_ctx_alloc(rdev, &hctx->stats3);
+	if (rc)
+		goto free_stat_mem;
+
+	return 0;
+free_stat_mem:
+	bnxt_qplib_free_stats_ctx(res->pdev, &hctx->stats3);
+
+	return rc;
+}
+
+static void bnxt_re_put_stats3_ctx(struct bnxt_re_dev *rdev)
+{
+	struct bnxt_qplib_ctx *hctx = &rdev->qplib_ctx;
+	struct bnxt_qplib_res *res = &rdev->qplib_res;
+
+	if (!rdev->rcfw.roce_mirror)
+		return;
+
+	bnxt_re_net_stats_ctx_free(rdev, hctx->stats3.fw_id);
+	bnxt_qplib_free_stats_ctx(res->pdev, &hctx->stats3);
+}
+
 static void bnxt_re_put_stats_ctx(struct bnxt_re_dev *rdev)
 {
 	struct bnxt_qplib_ctx *hctx = &rdev->qplib_ctx;
@@ -2028,6 +2064,8 @@ static void bnxt_re_dev_uninit(struct bnxt_re_dev *rdev, u8 op_type)
 	if (test_and_clear_bit(BNXT_RE_FLAG_QOS_WORK_REG, &rdev->flags))
 		cancel_delayed_work_sync(&rdev->worker);
 
+	bnxt_re_put_stats3_ctx(rdev);
+
 	if (test_and_clear_bit(BNXT_RE_FLAG_RESOURCES_INITIALIZED,
 			       &rdev->flags))
 		bnxt_re_cleanup_res(rdev);
@@ -2232,6 +2270,10 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 op_type)
 	if (!rdev->is_virtfn)
 		bnxt_re_read_vpd_info(rdev);
 
+	rc = bnxt_re_get_stats3_ctx(rdev);
+	if (rc)
+		goto fail;
+
 	return 0;
 free_sctx:
 	bnxt_re_net_stats_ctx_free(rdev, rdev->qplib_ctx.stats.fw_id);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infiniband/hw/bnxt_re/qplib_res.h
index ed1be06c2c60..2ea3b7f232a3 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
@@ -304,6 +304,7 @@ struct bnxt_qplib_ctx {
 	struct bnxt_qplib_hwq		tim_tbl;
 	struct bnxt_qplib_tqm_ctx	tqm_ctx;
 	struct bnxt_qplib_stats		stats;
+	struct bnxt_qplib_stats		stats3;
 	struct bnxt_qplib_vf_res	vf_res;
 };
 
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
index 79edff6bda95..d10741151543 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
@@ -308,7 +308,8 @@ int bnxt_qplib_del_sgid(struct bnxt_qplib_sgid_tbl *sgid_tbl,
 
 int bnxt_qplib_add_sgid(struct bnxt_qplib_sgid_tbl *sgid_tbl,
 			struct bnxt_qplib_gid *gid, const u8 *smac,
-			u16 vlan_id, bool update, u32 *index)
+			u16 vlan_id, bool update, u32 *index,
+			bool is_ugid, u32 stats_ctx_id)
 {
 	struct bnxt_qplib_res *res = to_bnxt_qplib(sgid_tbl,
 						   struct bnxt_qplib_res,
@@ -373,6 +374,9 @@ int bnxt_qplib_add_sgid(struct bnxt_qplib_sgid_tbl *sgid_tbl,
 		req.src_mac[1] = cpu_to_be16(((u16 *)smac)[1]);
 		req.src_mac[2] = cpu_to_be16(((u16 *)smac)[2]);
 
+		req.stats_ctx = cpu_to_le16(CMDQ_ADD_GID_STATS_CTX_STATS_CTX_VALID |
+					    (u16)stats_ctx_id);
+
 		bnxt_qplib_fill_cmdqmsg(&msg, &req, &resp, NULL, sizeof(req),
 					sizeof(resp), 0);
 		rc = bnxt_qplib_rcfw_send_message(rcfw, &msg);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.h b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
index e9834e7fc383..58f90f3e57f7 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
@@ -323,7 +323,8 @@ int bnxt_qplib_del_sgid(struct bnxt_qplib_sgid_tbl *sgid_tbl,
 			struct bnxt_qplib_gid *gid, u16 vlan_id, bool update);
 int bnxt_qplib_add_sgid(struct bnxt_qplib_sgid_tbl *sgid_tbl,
 			struct bnxt_qplib_gid *gid, const u8 *mac, u16 vlan_id,
-			bool update, u32 *index);
+			bool update, u32 *index,
+			bool is_ugid, u32 stats_ctx_id);
 int bnxt_qplib_update_sgid(struct bnxt_qplib_sgid_tbl *sgid_tbl,
 			   struct bnxt_qplib_gid *gid, u16 gid_idx,
 			   const u8 *smac);
-- 
2.43.5


