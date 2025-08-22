Return-Path: <netdev+bounces-215901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56379B30D27
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 06:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 543325E8905
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 04:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0486B28D82F;
	Fri, 22 Aug 2025 04:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Imk4DBPv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f98.google.com (mail-oa1-f98.google.com [209.85.160.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1A528CF5F
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 04:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755835382; cv=none; b=pMrF1DOIPp5emZZO0M+sQv7PaSmUV92uawCAwG9mz2lvVxpDwQlKPQz8xueWSXZXbb+B/6lmeiTpweexItZAqJk2df6Wnh463NrYbHqWNqEJmMD4K1VMkQuFjBxDZPtft55SYkxsIyuSD31RratCa/m63ywMd3dj99bvXSSescc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755835382; c=relaxed/simple;
	bh=kgLWykzDGE/b6FrWKGyRLhq2eXNsrpe9+bBTJFazARk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SVJjac+TLB4HIvBFFjUZmOHcN52Y1kQFc6wxRIOUX0xl6L/R30pOwQFVCqywpJglnCj1j3bIMVT/hTdrpbZHWrGE1CZsdfxrcS59worIYMrNAtuVMht9e4i9y5xPyurBafbd6n+IcNtP8so2nS5tnH/x7JVjo24skYy3/Yiqldg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Imk4DBPv; arc=none smtp.client-ip=209.85.160.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f98.google.com with SMTP id 586e51a60fabf-30cce8c3afaso1147532fac.1
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 21:03:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755835380; x=1756440180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zBBZzN7y0OVyFseGBaJQazrtC2PqzNlf45FYh0j9gF4=;
        b=qGNTsM+h+baLbFb/BANi3z2wLX++6QJfHNgWNGhplaaIO/mS06K/12eEH6GxmruLKq
         wwVQYh0A8QVBRCnLVqnefl3+gb71S5CozoMV2DZV4oP5Dfentszwp/gRFiLgMmwbrYCC
         Ccv3mNQ43uwplJgPQMBHQgXGZagnpWUCrFqYWcW8t5xXewY0F6aLR3x8t0nmWwuKSxG0
         J4cTECEZp1Z0V1wSgVkVPHhZ7katlyC8ZoGm0f/RK9TjVorzUjXIizna/p76su/gXBjl
         iZlZe6KKHoqSCOWP6AL6wLo77CZIQhViUEAsPi6Rg/QRP5NoqAXVTcPzBZbi2zyKCaa/
         WXsA==
X-Forwarded-Encrypted: i=1; AJvYcCVVmupkSXBJrqSweyhNRxig4PY670mwZlnm1+ONsj8lty68A86r1mWvtZ+F3Ab2eIi12qN7zBk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+aAVMYwpJziV+2Nfi+yLuEyRCxOATJGLeCSwj37uAlIgiZMar
	ftxhsvjf1aNyiJQ5C2NIctDMQIADR8ttKH3TuRNMs9M0nSYE8/O8Yat+i3nlvSZ2Tkeuc0n4sqS
	Sd7D786nvbRkIonQXI+SWNBuDKaZXvllICsdinq9UggIMmwz19U+VWJg5BhNorf6Ypq9G/Xi7ZF
	irv31rI7zZcbZQuItZkRize4I861bFSDHACUg/qp5meKiD+L0+iGa+UHHmRjykPWpZhs0kLQA6h
	sPIM4+pZGuJnvDGdrQxz1MF
X-Gm-Gg: ASbGncupPmewba1bL7jVzWpfcZSLBmyKZ8z9A+Enzxz62/BGoBi7H5/n0i9WhtW0IET
	N1/gIGMe5zepo+FWTfkbus+WdanfzbWYU9fSfmKIsmePe5kBpPNsc96qsrM8YVx8HSbU3BBBes7
	zxPjBO/R5FcypXbALXQt2HYjyf6gGG8WQXCwExrRvnNIdAHDsXAaGVak0auV2qpc5QkZuRibDXS
	po5SCustKTNjpYo12MkreI4MW8TpQq9M7iUJUOeMXE3oh8wmExiBkyCbs+XFO+08x0R94T3zrKz
	D7j2VpL4qsy1ex9hnzdKkr4nHq9NqnmKDh2cIjihs/OzItotKC3YQjpvaBG8aXC8tWiklMlVK0w
	tSHPqOu5cICNrPhRQtpexiUHM/pidnOTdHesS1PL8UbvRUA3jK1yffmljc7ugy21VYBeDSp0VPG
	1c/kjDrYVTXLYn
X-Google-Smtp-Source: AGHT+IF74Y7AgwosJO3V/XoobtJB8DESkIvW6aFnG8G5HZiJZgWXwm/eOG80x7V6jEHtNWeDCCdLtVZ5KEmL
X-Received: by 2002:a05:6871:810e:b0:2f5:2bb1:e85e with SMTP id 586e51a60fabf-314dcd2db9fmr626002fac.24.1755835380029;
        Thu, 21 Aug 2025 21:03:00 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-314c24fd918sm404747fac.9.2025.08.21.21.02.59
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Aug 2025 21:03:00 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-76ff2335c1eso980855b3a.1
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 21:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755835378; x=1756440178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zBBZzN7y0OVyFseGBaJQazrtC2PqzNlf45FYh0j9gF4=;
        b=Imk4DBPvmPQKYZxztf/+zKgRDvKBwmI45hjRgBFRh1pxKITtDK3WpOQnp2RSCPW598
         tp3yeeEoDMh6BaV9mr2AbepNahIh5bg85Ui1PfKP/4vnHaV98opd/sCSQps6qo1UTzcn
         T9uxVwG8GY0qm8whugzq7Q7vJe0tGKs6lMWGU=
X-Forwarded-Encrypted: i=1; AJvYcCVzEHX5bIaRt3XP12YVgI0KZ99GIaD9V4wfV6VBcWa5mQ/L7UIBoC4qoElTv9kgp8dSwS/t01E=@vger.kernel.org
X-Received: by 2002:a05:6a20:734b:b0:23d:e026:5eec with SMTP id adf61e73a8af0-24340af1359mr2532199637.6.1755835378548;
        Thu, 21 Aug 2025 21:02:58 -0700 (PDT)
X-Received: by 2002:a05:6a20:734b:b0:23d:e026:5eec with SMTP id adf61e73a8af0-24340af1359mr2532160637.6.1755835378064;
        Thu, 21 Aug 2025 21:02:58 -0700 (PDT)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d0d3abdsm9659814b3a.11.2025.08.21.21.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 21:02:57 -0700 (PDT)
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
Subject: [PATCH rdma-next 05/10] RDMA/bnxt_re: Add support for unique GID
Date: Fri, 22 Aug 2025 09:37:56 +0530
Message-ID: <20250822040801.776196-6-kalesh-anakkur.purayil@broadcom.com>
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


