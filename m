Return-Path: <netdev+bounces-223848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81539B7DA1B
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34C141899E58
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 04:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4762F6562;
	Wed, 17 Sep 2025 04:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NT7cWfX3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f99.google.com (mail-oa1-f99.google.com [209.85.160.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E4B30276F
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 04:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758082173; cv=none; b=I1sVa50S17L7wad9qwj2k7jDkkovmUza5GsaHurp0cdnbM9ZkQ7DeO+g8SQeszjLdk5JKuIhQ1pcSt9WqSKfyTS+3eUORU4BeWs9LAIqtUTR6hB3ZpF9KcGRQLiOmFso/2W5Qvg1ejdR7gAtUy8VlaC4ipPJr4ik92edJZqAhew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758082173; c=relaxed/simple;
	bh=Z2HP034WLJxt1xtBpmuwYhZhGaffMXpBNN4SemLlAJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mij7sAtRLCx5tU3q76U9OWN454QxYaBG3XpkBXDcG36rUGjcRguANw4M0tsWCiA2+EyBHyheOIt9mozxFjs8ZaBLU97Vd/cE8fnjyD/ImKAdm7xbz5kjsSs70pYuR7rUIUkt/PRue8h9nhkmRYnWmFckDqKmG5bDgwuRKMntg5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NT7cWfX3; arc=none smtp.client-ip=209.85.160.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f99.google.com with SMTP id 586e51a60fabf-331503fdc51so1626136fac.0
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 21:09:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758082171; x=1758686971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wP2tSczpYkkayL0mVNq2cemVEDei9ioz8Cn2wGm0gRs=;
        b=bHy5HWfZaGNubciA/S+diQWLSX1J9Xy9GoK7k+mzlD0ffkD7CyH0IQxRaRsA0B8lrd
         qYTGrr6SNF2s7pW/LNwLBVT3mJ/Cbnc4vd58rw4OoL4If3APezRRPXV9uG9wvKtUutIv
         jCBSlH3fvXaPWZrxZGza48dF7NcVhxU+RkORMbkddlYBIWg2UGJnXu/BG3bStQaWbBeK
         RF8psoPaOK3+dJLsHzLv9mmiOL2J4AIj2oDhRMSMeLpguOsUD9ubCoLQVANmbE3E6vib
         8XtJWjntFC+rJO1Exs+uIClaC0L5H8jqzIDpfXhJLo1L5H6UyzXVeJ7FLryGj8NUUa5r
         RQZA==
X-Gm-Message-State: AOJu0YwRWYoWFO2m+G0YKrP4SC+4QYgJ4i5Dv5MJ6IlAGsCyIGbnEavP
	kHLQFRIhls5ezddR5skYG8Iv8MvxEhnbivzsuw7a08U8U4umjklRRQdQmpXzTGlqw5oDIHIW02D
	JL15bkQZFbWKc0p9GzEtbRrzo0T0yNiSoQVcw3cfGNVXynUVdD325PkmSP5tXhHNrgN7DukF1NB
	oyuRkCurrh6Gs+ENbc/vtXUA/Cg18/trvUs81+K75GSI93NnOZoG7sgG9rlZKxs0BuCHATKiy63
	2MerHLH9Cs=
X-Gm-Gg: ASbGncswt/A/4Kk1UKl7ofbDw4JhWpX8xY8RbC5iD5uyypaIrzUDeauHhdYOVLip0G5
	O2z4AYPd3GhPfReF1jAs41nBUoVmy2ViMBOjNomde+d8NsQCis9XKz6INRV77Eihxxm0PEdzbcU
	yzSXvsCs31icDtTTXYN7Inj1H85KFqUGDzZSbvIBORCmDPxd6cFEzu9IjOImeI7/wKZM1Xira+T
	mcyvGTNtBb/Gtq/b7Mq+rIVrwYC29vrSKUiqTGtWBfUQtfZfjQrVgcln3dPGDhDmIRHS7OXekuD
	s8OPJHV4jOyOzltBQjfGKcZdkuxKbqS02QXBeAZj9E/3oZ0QbCzpVuvno8aspPE1CzXhMkyPzER
	4jx6ss+/yIidYizn0U2bqLKxOtYCysvwcKSvTNRMvrPtsKhPyhtLjD2M7A/Iau4/NAw+NNuNcwi
	t3fg==
X-Google-Smtp-Source: AGHT+IFfP7Sa9j14mwfq2aSaD9wCoQRfIoONdfhxJwRMZIdDxWLF2BPkrxzATnxBu86XknrVgLEtT3lgyEs7
X-Received: by 2002:a05:6870:320f:b0:321:28f7:77fa with SMTP id 586e51a60fabf-335bf727901mr455870fac.32.1758082170838;
        Tue, 16 Sep 2025 21:09:30 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-32d34a9017bsm1632937fac.14.2025.09.16.21.09.29
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Sep 2025 21:09:30 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b522c35db5fso4119353a12.0
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 21:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758082168; x=1758686968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wP2tSczpYkkayL0mVNq2cemVEDei9ioz8Cn2wGm0gRs=;
        b=NT7cWfX3UtljrrYqAGpJpEggvbNeSku0fjqBzwOtXGYWzPLVXHy0z/kjyDgNA7oQrE
         n4BS4o7fLvMXTkG9oxvLPFJseh1vgLUH1drr4bIOLmAJOh1AIEyeEq2ZpAK8eXf7SIht
         KbXh/M+jKpY0tJgc4ggZ/cdSgdJPvhHyCCyHs=
X-Received: by 2002:a05:6a20:6a05:b0:262:9461:2e59 with SMTP id adf61e73a8af0-27aa204bb20mr911850637.39.1758082168288;
        Tue, 16 Sep 2025 21:09:28 -0700 (PDT)
X-Received: by 2002:a05:6a20:6a05:b0:262:9461:2e59 with SMTP id adf61e73a8af0-27aa204bb20mr911826637.39.1758082167897;
        Tue, 16 Sep 2025 21:09:27 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ee223f2ecsm558562a91.18.2025.09.16.21.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 21:09:27 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Anantha Prabhu <anantha.prabhu@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net-next v2 07/10] bnxt_en: Support for RoCE resources dynamically shared within VFs.
Date: Tue, 16 Sep 2025 21:08:36 -0700
Message-ID: <20250917040839.1924698-8-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20250917040839.1924698-1-michael.chan@broadcom.com>
References: <20250917040839.1924698-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Anantha Prabhu <anantha.prabhu@broadcom.com>

Add support for dynamic RoCE SRIOV resource configuration.  Instead of
statically dividing the RoCE resources by the number of VFs, provide
the maximum resources and let the FW dynamically dsitribute to the VFs
on the fly.

Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Anantha Prabhu <anantha.prabhu@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c       | 8 ++++++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.h       | 3 +++
 drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c | 7 +++++++
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index bdf8502d3131..4ffc4632991b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -9632,10 +9632,10 @@ static int __bnxt_hwrm_ptp_qcfg(struct bnxt *bp)
 
 static int __bnxt_hwrm_func_qcaps(struct bnxt *bp)
 {
+	u32 flags, flags_ext, flags_ext2, flags_ext3;
+	struct bnxt_hw_resc *hw_resc = &bp->hw_resc;
 	struct hwrm_func_qcaps_output *resp;
 	struct hwrm_func_qcaps_input *req;
-	struct bnxt_hw_resc *hw_resc = &bp->hw_resc;
-	u32 flags, flags_ext, flags_ext2;
 	int rc;
 
 	rc = hwrm_req_init(bp, req, HWRM_FUNC_QCAPS);
@@ -9702,6 +9702,10 @@ static int __bnxt_hwrm_func_qcaps(struct bnxt *bp)
 	    (flags_ext2 & FUNC_QCAPS_RESP_FLAGS_EXT2_ROCE_VF_RESOURCE_MGMT_SUPPORTED))
 		bp->fw_cap |= BNXT_FW_CAP_ROCE_VF_RESC_MGMT_SUPPORTED;
 
+	flags_ext3 = le32_to_cpu(resp->flags_ext3);
+	if (flags_ext3 & FUNC_QCAPS_RESP_FLAGS_EXT3_ROCE_VF_DYN_ALLOC_SUPPORT)
+		bp->fw_cap |= BNXT_FW_CAP_ROCE_VF_DYN_ALLOC_SUPPORT;
+
 	bp->tx_push_thresh = 0;
 	if ((flags & FUNC_QCAPS_RESP_FLAGS_PUSH_MODE_SUPPORTED) &&
 	    BNXT_FW_MAJ(bp) > 217)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 57a1af40cc19..c0f46eaf91c0 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2479,6 +2479,7 @@ struct bnxt {
 	#define BNXT_FW_CAP_ENABLE_RDMA_SRIOV           BIT_ULL(5)
 	#define BNXT_FW_CAP_ROCE_VF_RESC_MGMT_SUPPORTED	BIT_ULL(6)
 	#define BNXT_FW_CAP_KONG_MB_CHNL		BIT_ULL(7)
+	#define BNXT_FW_CAP_ROCE_VF_DYN_ALLOC_SUPPORT	BIT_ULL(8)
 	#define BNXT_FW_CAP_OVS_64BIT_HANDLE		BIT_ULL(10)
 	#define BNXT_FW_CAP_TRUSTED_VF			BIT_ULL(11)
 	#define BNXT_FW_CAP_ERROR_RECOVERY		BIT_ULL(13)
@@ -2523,6 +2524,8 @@ struct bnxt {
 #define BNXT_SUPPORTS_MULTI_RSS_CTX(bp)				\
 	(BNXT_PF(bp) && BNXT_SUPPORTS_NTUPLE_VNIC(bp) &&	\
 	 ((bp)->rss_cap & BNXT_RSS_CAP_MULTI_RSS_CTX))
+#define BNXT_ROCE_VF_DYN_ALLOC_CAP(bp)				\
+	((bp)->fw_cap & BNXT_FW_CAP_ROCE_VF_DYN_ALLOC_SUPPORT)
 #define BNXT_SUPPORTS_QUEUE_API(bp)				\
 	(BNXT_PF(bp) && BNXT_SUPPORTS_NTUPLE_VNIC(bp) &&	\
 	 ((bp)->fw_cap & BNXT_FW_CAP_VNIC_RE_FLUSH))
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
index e7fbfeb1a387..1d8df44c3f9e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
@@ -541,6 +541,13 @@ static void bnxt_hwrm_roce_sriov_cfg(struct bnxt *bp, int num_vfs)
 	if (rc)
 		goto err;
 
+	/* In case of VF Dynamic resource allocation, driver will provision
+	 * maximum resources to all the VFs. FW will dynamically allocate
+	 * resources to VFs on the fly, so always divide the resources by 1.
+	 */
+	if (BNXT_ROCE_VF_DYN_ALLOC_CAP(bp))
+		num_vfs = 1;
+
 	cfg_req->fid = cpu_to_le16(0xffff);
 	cfg_req->enables2 =
 		cpu_to_le32(FUNC_CFG_REQ_ENABLES2_ROCE_MAX_AV_PER_VF |
-- 
2.51.0


