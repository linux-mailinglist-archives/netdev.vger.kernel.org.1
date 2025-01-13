Return-Path: <netdev+bounces-157599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAF2A0AF61
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 07:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3B7A3A2347
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 06:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE68231C80;
	Mon, 13 Jan 2025 06:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Om9sbzye"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E504230D32
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 06:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736750410; cv=none; b=AZ7w7jd8MIiKtmFTC4pH3F2M42Og5EFIabJ5ASfA1RySctS1E9LiI2EtnimoHnY4lOJXkNRsYorDWnlrZiUWxJZsgrOTxezaBBz1zITL7rrupsunM+RokSiYW0z9unSEoX6cCSoPHwvOwPscezcGcVfSP4u44k2D435d/J5n24Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736750410; c=relaxed/simple;
	bh=mC+E9RwuFdjOgnkpmUfX9FY4jDWN/NFSd1zxwMrJIus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pTNKYUIMaZmyuUhRUQya1FmzBSz3e9I5kMyttTi1xrOQVF0LW6GDavpBoyLZ5SlDPN/ZGY2SP3do+sbhCOjMgh9I+VSWxrOfQAaO6ujpVmnJ5mxIF2y6dJglCSbZkTz2Zx/5noy9Gjf1yBob2Y5wz6tdvzc25ooZu+Ja3IKnimw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Om9sbzye; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-216395e151bso46678085ad.0
        for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 22:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1736750408; x=1737355208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+1wX2t3VqddUuQuqxX59a5UXsvxBQwbhQtXzmJevDk=;
        b=Om9sbzyeu+jV8Y3eB/eBuuVmFMQuVqzN4pF5j7oFoHNbgW6M+WVCnhvTJsZTnn3MAw
         pNrmDYno5umuKoO8aK7G4fCyYFPVIJCTOxILQF/g+E7WVTX6yYphAMamlf4498KP2oBm
         S3ZPB4OHw/YaiZ7wljDUmfrq56qT37fsEvAe8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736750408; x=1737355208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y+1wX2t3VqddUuQuqxX59a5UXsvxBQwbhQtXzmJevDk=;
        b=BbjitJUsHU45JEd+QNpt3SA/1ZGamiCDeFn/K9GyF4yRiOE60qlD96oAk+h4fPQn0P
         /fDm6+ON4NEwFYmkiz9zILCpta6cm2sC8OxQXYhrMYWJaxAmoC6i2CvWorkJsyL0QTlh
         FFzhPTmzKNKm5Ly6ZpBYzuVHf+7djtX5crkidYm2UBSMy08XDQnuoD69qPHCAkN5HqMy
         jdcs8kiGxDg1AhIODKseY1R4ZvDO9fttdZ+ZS68vpFU0bBQ/y2Hv85PrnbEMbxVlJrNF
         OpeGmJeO/1GmxUoVL7DRWmERHHd9rgy3pXE2KOvpZ/g8tY2Gk7Ko8KtMmdAl5jGzUHE4
         KMMQ==
X-Gm-Message-State: AOJu0YyAY/R2MhfvewsioLw7sHcwEDohZ2Fqwv4vmqlw52/UhXGjx2ha
	bwwN0q2OUYAmWaNBCdxB+2KhZoMe0b+n8q6ke8YpyKM7jh3H1144O8jBwnf4LQ==
X-Gm-Gg: ASbGncs8m+syTjkY+3h+EdlAxt5ohsmQNrmyOllFMdAbaKLHntX+2nRX7SXjAjqEJlo
	cWvPddCCe4Z2Wm9ttLceF+cI/9QwOAJ5OhAeHDfleHWjspW45BVKJdkoL+ZYq626xlk19qTyVZZ
	6bySkMaiIiAdspK5TuluEQTwP25rebIbH/iNeDppqeZyJ6mAbfFQd+q821WC6UIvi9m6wO1khef
	qyThzhxZkmlDFgOzUtwIDDYYwamOtJl0vbHN8SPjIpIRs3eV3st7AlJuDV4FchPwG9SpEkU8EPo
	Od7rPtjgAFWKLlWv8fcomp9Jo9pjKPHD
X-Google-Smtp-Source: AGHT+IGEzCmK+JS8UEJHTWm8JX0EEL7tOIj6hQKgYAN5QIzO9zRukA8GlFMLbsziwcoyGYcjpdOIog==
X-Received: by 2002:a17:902:dac9:b0:215:742e:5cff with SMTP id d9443c01a7336-21ad9f7ca15mr110659545ad.16.1736750408322;
        Sun, 12 Jan 2025 22:40:08 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f254264sm46488165ad.233.2025.01.12.22.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 22:40:07 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	somnath.kotur@broadcom.com
Subject: [PATCH net-next 01/10] bnxt_en: Set NAPR 1.2 support when registering with firmware
Date: Sun, 12 Jan 2025 22:39:18 -0800
Message-ID: <20250113063927.4017173-2-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20250113063927.4017173-1-michael.chan@broadcom.com>
References: <20250113063927.4017173-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NPAR 1.2 adds a transparent VLAN tag for all packets between the NIC
and the switch.  Because of that, RX VLAN acceleration cannot be
supported for any additional host configured VLANs.  The driver has
to acknowledge that it can support no RX VLAN acceleration and
set the NPAR 1.2 supported flag when registering with the FW.
Otherwise, the FW call will fail and the driver will abort on these
NPAR 1.2 NICs with this error:

bnxt_en 0000:26:00.0 (unnamed net_device) (uninitialized): hwrm req_type 0x1d seq id 0xb error 0x2

Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 5 +++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 884d42db5554..8527788bed91 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -5537,6 +5537,8 @@ int bnxt_hwrm_func_drv_rgtr(struct bnxt *bp, unsigned long *bmap, int bmap_size,
 	if (bp->fw_cap & BNXT_FW_CAP_ERROR_RECOVERY)
 		flags |= FUNC_DRV_RGTR_REQ_FLAGS_ERROR_RECOVERY_SUPPORT |
 			 FUNC_DRV_RGTR_REQ_FLAGS_MASTER_SUPPORT;
+	if (bp->fw_cap & BNXT_FW_CAP_NPAR_1_2)
+		flags |= FUNC_DRV_RGTR_REQ_FLAGS_NPAR_1_2_SUPPORT;
 	req->flags = cpu_to_le32(flags);
 	req->ver_maj_8b = DRV_VER_MAJ;
 	req->ver_min_8b = DRV_VER_MIN;
@@ -8338,6 +8340,7 @@ static int bnxt_hwrm_func_qcfg(struct bnxt *bp)
 
 	switch (resp->port_partition_type) {
 	case FUNC_QCFG_RESP_PORT_PARTITION_TYPE_NPAR1_0:
+	case FUNC_QCFG_RESP_PORT_PARTITION_TYPE_NPAR1_2:
 	case FUNC_QCFG_RESP_PORT_PARTITION_TYPE_NPAR1_5:
 	case FUNC_QCFG_RESP_PORT_PARTITION_TYPE_NPAR2_0:
 		bp->port_partition_type = resp->port_partition_type;
@@ -9502,6 +9505,8 @@ static int __bnxt_hwrm_func_qcaps(struct bnxt *bp)
 		bp->fw_cap |= BNXT_FW_CAP_HOT_RESET_IF;
 	if (BNXT_PF(bp) && (flags_ext & FUNC_QCAPS_RESP_FLAGS_EXT_FW_LIVEPATCH_SUPPORTED))
 		bp->fw_cap |= BNXT_FW_CAP_LIVEPATCH;
+	if (flags_ext & FUNC_QCAPS_RESP_FLAGS_EXT_NPAR_1_2_SUPPORTED)
+		bp->fw_cap |= BNXT_FW_CAP_NPAR_1_2;
 	if (BNXT_PF(bp) && (flags_ext & FUNC_QCAPS_RESP_FLAGS_EXT_DFLT_VLAN_TPID_PCP_SUPPORTED))
 		bp->fw_cap |= BNXT_FW_CAP_DFLT_VLAN_TPID_PCP;
 	if (flags_ext & FUNC_QCAPS_RESP_FLAGS_EXT_BS_V2_SUPPORTED)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 094c9e95b463..a634ad76177d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2488,6 +2488,7 @@ struct bnxt {
 	#define BNXT_FW_CAP_CFA_RFS_RING_TBL_IDX_V3	BIT_ULL(39)
 	#define BNXT_FW_CAP_VNIC_RE_FLUSH		BIT_ULL(40)
 	#define BNXT_FW_CAP_SW_MAX_RESOURCE_LIMITS	BIT_ULL(41)
+	#define BNXT_FW_CAP_NPAR_1_2			BIT_ULL(42)
 
 	u32			fw_dbg_cap;
 
-- 
2.30.1


