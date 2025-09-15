Return-Path: <netdev+bounces-222903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1E4B56EA9
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 05:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1990318957D9
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 03:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8CE2264C6;
	Mon, 15 Sep 2025 03:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="K32YIrdq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f228.google.com (mail-yw1-f228.google.com [209.85.128.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62326225401
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 03:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757905556; cv=none; b=n+WX42OtHuCWAksf6apGWf/FwKBZ4PXRgt/zrO8VA0Bpzu+FoC3ELnguPgkJctrRb/90yH7G0hIc/c4Yw+BLMKFGytoCVy16BN5jEg6rXgAQyJfC+h8AX7MtAIZTbMhuMyR+jUYJgnIBgXaHgbUsWcvtbjsFfYWHNHI8Hbyt1v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757905556; c=relaxed/simple;
	bh=1nbW0v70adXEjK5v131fvPPmXdBie4xXZtI9Su8JQQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ECGXQnTx5spu33SXncCmQxLc41OefexAxxxI2n7oeWzbJoJhMhwI2bnwICOgEsBAy9Ea27pWJsjkcsOlQ82vnN+Osy0r4YKC23rm6UmtmX+NceSx3Wcv1TGzJSKulrsmgYtlyGpCOy2slrNyT6Tj35uVFwILx3oOx95vk7sQMkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=K32YIrdq; arc=none smtp.client-ip=209.85.128.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f228.google.com with SMTP id 00721157ae682-71d6014810fso27986017b3.0
        for <netdev@vger.kernel.org>; Sun, 14 Sep 2025 20:05:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757905554; x=1758510354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u3ps0+Kop2I5dzyjN0cMSVErMJv5b2g2qWh5qR/XUKU=;
        b=hcvZQUMbUOp3+k9LutQtzedKTf0oD4/yTLXDuDr6J1DxXKZkgSS7wG5dywgvtZbNm5
         FrRPzoqxmxCpS0e3vUSOaMpedeFWOm87bNGLG30n5M3eE4aggAH5L1zsRPgn2yg8x4y1
         HE4nCirHlIbY7KKUCYCqkhl/iq22iKAtvHzOlGB3PiSliGP/VPBpCY2vf3/Uz2J63YNz
         EQiQq9HOQO6ewhZ94VJJumelYm0ouRIjuol1RIlchOkK+BX5UJNjlKIw4TQTGtYwrt2C
         FROFJWLeJwN6OIWE01uaU5wIAGKDOdMLeD2P5MMpgdVokjzSO3K2/CqO8j7rremFEgoe
         MplA==
X-Gm-Message-State: AOJu0YyWK6CzNn/Jcu8MurIyAo4vsYxsEi9OQtm89L7XEs73MaKDbwAB
	i1bsBEQ1mp5YmdhUbQNuFn2/6oeqntkKb8VKKNCl5bC0F64o8oDpAGtgKFKL3QNEs+1cgX1gC/u
	tDN0USJ99RVYxy1COXS01qzcwq/FSFb0zH5vvgvq1HimnihRdxfAArTuylr/cO6SKClbGMgg7ya
	Pcrg0ZjL8ljneSN15eVCGB2lc7zQKoX8JYHH7biME6DmkZtWSk4SunOzcbu5JhjLGN9M9zUIm9q
	5XllJpVUZ0=
X-Gm-Gg: ASbGncuRdYwNcZbkkInaINn+g/Q1DDcocZoLaxQ+0BRcuYucSG38TfWsc5T8uxlTaL/
	YKBzMd1G7HfdKAPuZWftfSJDVwUubnORB5K91Myxy6Ikkt4aMGYi+HuTqq9+ZG750BleOX+wjH4
	WL60JNbL6Dk5UxYtKlLIEUEao4gFcBWJ1qtaofZwhXHgBrz2OSkvaczLyPvTnXUwSWCHpFH5yUR
	AopkQZTCIO61DjTQXMEm+kZyTGC/E4AbEM8zwiw/CIrd0fND2XrpVZTGTJQ/+IK83AlRAMzV8O+
	i9wQcDDsY+3PTBj7jcCGtl3LyDiCu0wXxKWIc3gr4EtgaeyLNLZyWaZ1LBrK7102oZvaawl04Sg
	ETZh7WzTMpSxbxXaZ1Jan70CDz84qcnSNWaXk1Jx637rQ+Vjvw6O3rI8cH6CZx5e7/VFqK1BdkR
	1yuA==
X-Google-Smtp-Source: AGHT+IF0KsMdpw07p+oHSiSIvO9uWghFo4i1s1ZW/aJ80R6aWdUNEYwOoXDWCHWHD0R8kmOabISH9nG70RVM
X-Received: by 2002:a05:690c:6604:b0:721:aca:b1e3 with SMTP id 00721157ae682-7306319122emr110232607b3.24.1757905553474;
        Sun, 14 Sep 2025 20:05:53 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-72f7a166b6asm6486647b3.45.2025.09.14.20.05.53
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Sep 2025 20:05:53 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-25177b75e38so43044675ad.0
        for <netdev@vger.kernel.org>; Sun, 14 Sep 2025 20:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1757905552; x=1758510352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3ps0+Kop2I5dzyjN0cMSVErMJv5b2g2qWh5qR/XUKU=;
        b=K32YIrdqyfkhbI/OtpHvd8Nb38HKTcIcbD49urQtOFOFWIT+Da+1tadIzyEvNyGq5w
         /GTurYxjtYhsZOZ1cRKKfbT2JdmrXt5vn5dO2jxF/a72B3ARBpuhTyGyQVoT6aSkYpno
         pwNEkhXvet/9B+ktfe5BuqTFpX4VswKxe35kQ=
X-Received: by 2002:a17:902:ef11:b0:235:e8da:8d1 with SMTP id d9443c01a7336-25d24caa073mr112322105ad.8.1757905551831;
        Sun, 14 Sep 2025 20:05:51 -0700 (PDT)
X-Received: by 2002:a17:902:ef11:b0:235:e8da:8d1 with SMTP id d9443c01a7336-25d24caa073mr112321915ad.8.1757905551479;
        Sun, 14 Sep 2025 20:05:51 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3b0219f9sm112723575ad.123.2025.09.14.20.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 20:05:50 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH net-next 03/11] bnxt_en: Optimize bnxt_sriov_disable()
Date: Sun, 14 Sep 2025 20:04:57 -0700
Message-ID: <20250915030505.1803478-4-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20250915030505.1803478-1-michael.chan@broadcom.com>
References: <20250915030505.1803478-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

bnxt_sriov_disable() is invoked from 2 places:

1. When the user deletes the VFs.
2. During the unload of the PF driver instance.

Inside bnxt_sriov_disable(), driver invokes
bnxt_restore_pf_fw_resources() which in turn causes a close/open_nic().
There is no harm doing this in the unload path, although it is inefficient
and unnecessary.

Optimize the function to make it more efficient.

Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c       |  2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c | 12 ++++++++++--
 drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.h |  2 +-
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 5f4f4d99f1e7..a74b50130cc0 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -16156,7 +16156,7 @@ static void bnxt_remove_one(struct pci_dev *pdev)
 	struct bnxt *bp = netdev_priv(dev);
 
 	if (BNXT_PF(bp))
-		bnxt_sriov_disable(bp);
+		__bnxt_sriov_disable(bp);
 
 	bnxt_rdma_aux_device_del(bp);
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
index 480e18a32caa..e7fbfeb1a387 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
@@ -919,7 +919,7 @@ static int bnxt_sriov_enable(struct bnxt *bp, int *num_vfs)
 	return rc;
 }
 
-void bnxt_sriov_disable(struct bnxt *bp)
+void __bnxt_sriov_disable(struct bnxt *bp)
 {
 	u16 num_vfs = pci_num_vf(bp->pdev);
 
@@ -943,6 +943,14 @@ void bnxt_sriov_disable(struct bnxt *bp)
 	devl_unlock(bp->dl);
 
 	bnxt_free_vf_resources(bp);
+}
+
+static void bnxt_sriov_disable(struct bnxt *bp)
+{
+	if (!pci_num_vf(bp->pdev))
+		return;
+
+	__bnxt_sriov_disable(bp);
 
 	/* Reclaim all resources for the PF. */
 	rtnl_lock();
@@ -1321,7 +1329,7 @@ int bnxt_cfg_hw_sriov(struct bnxt *bp, int *num_vfs, bool reset)
 	return 0;
 }
 
-void bnxt_sriov_disable(struct bnxt *bp)
+void __bnxt_sriov_disable(struct bnxt *bp)
 {
 }
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.h
index 9a4bacba477b..e4979d729312 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.h
@@ -38,7 +38,7 @@ bool bnxt_is_trusted_vf(struct bnxt *bp, struct bnxt_vf_info *vf);
 int bnxt_set_vf_trust(struct net_device *dev, int vf_id, bool trust);
 int bnxt_sriov_configure(struct pci_dev *pdev, int num_vfs);
 int bnxt_cfg_hw_sriov(struct bnxt *bp, int *num_vfs, bool reset);
-void bnxt_sriov_disable(struct bnxt *);
+void __bnxt_sriov_disable(struct bnxt *bp);
 void bnxt_hwrm_exec_fwd_req(struct bnxt *);
 void bnxt_update_vf_mac(struct bnxt *);
 int bnxt_approve_mac(struct bnxt *, const u8 *, bool);
-- 
2.51.0


