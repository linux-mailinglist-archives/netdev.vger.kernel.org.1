Return-Path: <netdev+bounces-141917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 299F09BCA42
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 11:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFD701F23A75
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 10:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9871D358B;
	Tue,  5 Nov 2024 10:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gphwC22X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD681D319F
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 10:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730802026; cv=none; b=ItgxO/Mcy3d1BLDyvvuq/KdH8zj6bBr7Zf31gMbFY98eCbvzF7TC7YEOKcxorBHQkTZwVcANpcwCcoMVKW9BbqDXd+Ytw2GT8MJ2upODlkmCDY5DTWigl0tQHZBa/rci2M5gLlvdrbaNuUY82fG4J2ND7L8xtewyKYE1z0ysFHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730802026; c=relaxed/simple;
	bh=Paw3NHGBKcpYWKx6/8kixwuXZd4axLGz+zE8p3Aik4E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=gHoYklwCLdv2fFhiumOcMB9S4yDMreuDr00suquj3+errcSNW7rhabR4eN5g5sUh3JCJ2HsYLtwORBsmd1rOB2qhqRqG4CQbZEwOEPgDvbSwwn+yAeQJgPtBobFM+gu9/rTsdCUpuvQKIziqer4IEeHA6S60hgV4092nTDG5cOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gphwC22X; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20cdda5cfb6so51295965ad.3
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 02:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1730802024; x=1731406824; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KpyF7OfeG3D1SjYyfRqhBhCivmBUEISeT2uU0LeHwvU=;
        b=gphwC22XoX9jAEwWZkDO9Pu0tryY9k4lG9StauzgTFCFW7g+W+7kR+aykHTbUed56v
         VnzOZIq+/HJXlzh2OcqrVIpAFIQA4H51q2zoKxPd1sDxoOeJ8CuW9SAdsfPw8P4OacDi
         Ff9tl7d5j9hJ5MLwh6g7WgvjVqFIM5wyN0Udw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730802024; x=1731406824;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KpyF7OfeG3D1SjYyfRqhBhCivmBUEISeT2uU0LeHwvU=;
        b=vYQaf3cffBMFSoGjzIvDz9A454/nDaXXTZgiNQZjGPB157CJ7m1p3FuZmIWEijFODn
         +FHpRnmHTedGVb9dBzCm1IqzWLiVxxHfr1tEfYWXmQfGOW0qpbpWnjMlck2qcxNHgjl1
         ddUm3JVLV6JNMtcH0ik3+t8KE+v5UvB4A/04eZ3MAgja0TupXQTFlPCGrH3msdcNDwyX
         crIaiGyVPhL4CNVRy+6slFvqj6KxDw8v2HWPC/6RcstKRZ2Rpk/k6wzdq3xvk9yRTyr2
         HBPCxJV99Hyg9/V66If2f7zL6jmFam1miOO5mhgDotQ5eQHY5H+LXhcbdZIsfuJ23/WW
         A8Vg==
X-Forwarded-Encrypted: i=1; AJvYcCVVvLCmeDIRFglzTwqRzUI3G8FzP5M8NzWKVsodSB1qissX+/AeVQahLpN8TQCjcqMNOHLcgWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWhM2dduwQkQ0jY0Gk5RppcxVk4C0YxYWFO4A4xihW5qITFRC4
	bxUko6yCbHSbj4gXyEDFlVkSEwwoa8q7UPK0NJiknWFbYc9ViYbtloS37u+Djg==
X-Google-Smtp-Source: AGHT+IGDA/T6jNMV6isflQdNhX8z5d4jQN6lHmbWf0KOf1PRzPJ2hcQhVufloO0CQOiqBtfzV2pATQ==
X-Received: by 2002:a17:902:ea12:b0:20c:dd71:c94f with SMTP id d9443c01a7336-21103c5c8a1mr263586265ad.41.1730802024616;
        Tue, 05 Nov 2024 02:20:24 -0800 (PST)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21105707132sm75306615ad.96.2024.11.05.02.20.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2024 02:20:23 -0800 (PST)
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
Subject: [PATCH rdma-next 3/3] RDMA/bnxt_re: Add set_func_resources support for P5/P7 adapters
Date: Tue,  5 Nov 2024 01:59:12 -0800
Message-Id: <1730800752-29925-4-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1730800752-29925-1-git-send-email-selvin.xavier@broadcom.com>
References: <1730800752-29925-1-git-send-email-selvin.xavier@broadcom.com>
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


