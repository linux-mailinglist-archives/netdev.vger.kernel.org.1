Return-Path: <netdev+bounces-142283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C62569BE1DF
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 10:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7873D1F25346
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 09:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CF91DDA0E;
	Wed,  6 Nov 2024 09:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gpP+p9cm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F7E1DD880
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 09:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730883944; cv=none; b=MZaoBqHJQU2iku6icci63MK0XAVQlOeR71hjFyiwOKXswzOiBCyl9GqbHGilxYcyNHWPj5BzR6QBnaSI58fEQHQ4DebfNwT5U/m+s1vs+nOjM+ggvSU6y39umtc1W9NJeSfhpr0sn2PQMvc8RT7iI/AMl+rY70zt/XsBexTqlCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730883944; c=relaxed/simple;
	bh=Paw3NHGBKcpYWKx6/8kixwuXZd4axLGz+zE8p3Aik4E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=JEeEP9+Ea5htuZTNpQTj1wPXkUJUvqU52c2jqEmw3hwjHA6BK6BKFO4hM/YsaP2B7cz4qKfLK1lYyRvk/GRekYnnYGu2Aw9DDdXl/KrNCDjFdHW94V1FOszWC4k9LyzId1WRl98HdOizQCeXQi3EBOgI2OxFa1mdXIEwmhpr8Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gpP+p9cm; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7ea9739647bso4626409a12.0
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 01:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1730883942; x=1731488742; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KpyF7OfeG3D1SjYyfRqhBhCivmBUEISeT2uU0LeHwvU=;
        b=gpP+p9cmKNiWbEScfck4H+8B0FdENOMlK0Gdc0zbeWB+0QIzFoh5iNnqzoZJd2DleJ
         Hx7gKsgOdk7WrajzW4xDqu1QA3qJr0xdX07H9UAwFPcFI0QwhqdXpfLRAoUYefmnhb81
         illP8wwORUJ9dRvBSJT3Aaud8LTE4zjYHA8VI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730883942; x=1731488742;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KpyF7OfeG3D1SjYyfRqhBhCivmBUEISeT2uU0LeHwvU=;
        b=Ikkc9jtgf3FegE6epBvEBy2dgyl+6awI2aVI6I3im65PseDfN2rzeCKPIkR7jEDIN/
         WwypoRgK15889L8Y40i8CC5IpVD0m/AxbInVgqHEiqOH/c9rgs9OiFfPo/HsL+Gp7rRW
         /jjTB7+vchz0mCT4Xr0uEjh1dxPAshA/RKbojvdnK7eu9okf53i2a/HvkfSPvmLgbJUi
         j3xvSyV1K6OBHkcKI8M1J8Zwtq4KTTqaEMLfaRw88YeKGLPzNjxCREPFPXhB/UoYnpGa
         aiCfGMcldKKXvnSzzJ379oCxLGRqLJgHO/oeiEkkoFbRpXxeM7e1DBo/gl8/TdT95ygT
         Iu0w==
X-Forwarded-Encrypted: i=1; AJvYcCUjBHxHTAHErPp7OlFKV2QEg1wVjkHDo55fcoCdDr2gGJXC8q9pTNIr5xzCNRUBidNgiuqInY4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmel8/oh7qJNLOs8SbvKYvciQ2nbCUINakcg4Lm6W4OgBk0RiG
	aY8INXCQeh5USCt7Sss3s/g9sLZ09oDEL2fIYo7tmtYPudRLko0IV7yIv6oKmQ==
X-Google-Smtp-Source: AGHT+IE2DaJ2SRKntdWmojupvyRQ48n1fwCI4ZCg/P3nRIBrDbwGV5WYxIPHn57KcSlLclx78itmsA==
X-Received: by 2002:a05:6a20:c6c1:b0:1cf:9a86:6cb7 with SMTP id adf61e73a8af0-1d9a83d5671mr52453452637.20.1730883941925;
        Wed, 06 Nov 2024 01:05:41 -0800 (PST)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057084casm91715395ad.92.2024.11.06.01.05.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2024 01:05:40 -0800 (PST)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	michael.chan@broadcom.com,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH rdma-next v2 3/3] RDMA/bnxt_re: Add set_func_resources support for P5/P7 adapters
Date: Wed,  6 Nov 2024 00:44:36 -0800
Message-Id: <1730882676-24434-4-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1730882676-24434-1-git-send-email-selvin.xavier@broadcom.com>
References: <1730882676-24434-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

Enable set_func_resources for P5 and P7 adapters to handle
VF resource distribution. Remove setting max resources per VF
during PF initialization. This change is required for firmwares
which does not support RoCE VF resource management by NIC driver.
The code is same for all adapters now.

Reviewed-by: Stephen Shi <stephen.shi@broadcom.com>
Reviewed-by: Rukhsana Ansari <rukhsana.ansari@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/main.c       | 11 ++++++-----
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 11 +----------
 2 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index dd528dd..cb61941 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -291,11 +291,12 @@ static void bnxt_re_vf_res_config(struct bnxt_re_dev *rdev)
 	 * available at this point.
 	 */
 	rdev->num_vfs = pci_sriov_get_totalvfs(rdev->en_dev->pdev);
-	if (!bnxt_qplib_is_chip_gen_p5_p7(rdev->chip_ctx)) {
-		bnxt_re_set_resource_limits(rdev);
-		bnxt_qplib_set_func_resources(&rdev->qplib_res, &rdev->rcfw,
-					      &rdev->qplib_ctx);
-	}
+	if (!rdev->num_vfs)
+		return;
+
+	bnxt_re_set_resource_limits(rdev);
+	bnxt_qplib_set_func_resources(&rdev->qplib_res, &rdev->rcfw,
+				      &rdev->qplib_ctx);
 }
 
 static void bnxt_re_shutdown(struct auxiliary_device *adev)
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index 005079b..7072991 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -851,10 +851,8 @@ int bnxt_qplib_init_rcfw(struct bnxt_qplib_rcfw *rcfw,
 	 * shall setup this area for VF. Skipping the
 	 * HW programming
 	 */
-	if (is_virtfn)
+	if (is_virtfn || bnxt_qplib_is_chip_gen_p5_p7(rcfw->res->cctx))
 		goto skip_ctx_setup;
-	if (bnxt_qplib_is_chip_gen_p5_p7(rcfw->res->cctx))
-		goto config_vf_res;
 
 	lvl = ctx->qpc_tbl.level;
 	pgsz = bnxt_qplib_base_pg_size(&ctx->qpc_tbl);
@@ -898,13 +896,6 @@ int bnxt_qplib_init_rcfw(struct bnxt_qplib_rcfw *rcfw,
 	req.number_of_srq = cpu_to_le32(ctx->srqc_tbl.max_elements);
 	req.number_of_cq = cpu_to_le32(ctx->cq_tbl.max_elements);
 
-config_vf_res:
-	req.max_qp_per_vf = cpu_to_le32(ctx->vf_res.max_qp_per_vf);
-	req.max_mrw_per_vf = cpu_to_le32(ctx->vf_res.max_mrw_per_vf);
-	req.max_srq_per_vf = cpu_to_le32(ctx->vf_res.max_srq_per_vf);
-	req.max_cq_per_vf = cpu_to_le32(ctx->vf_res.max_cq_per_vf);
-	req.max_gid_per_vf = cpu_to_le32(ctx->vf_res.max_gid_per_vf);
-
 skip_ctx_setup:
 	if (BNXT_RE_HW_RETX(rcfw->res->dattr->dev_cap_flags))
 		flags |= CMDQ_INITIALIZE_FW_FLAGS_HW_REQUESTER_RETX_SUPPORTED;
-- 
2.5.5


