Return-Path: <netdev+bounces-165749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C08EA3346F
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 02:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72F651881954
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 01:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B774C126F0A;
	Thu, 13 Feb 2025 01:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LRxB+RgI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7D47DA6C
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 01:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739409208; cv=none; b=C1XXPx1Oi5FYulKeXMRf6JfBWS4YdJa8v+2KbFBPAiETCOjpk+IseiH2yZVYY92+4o0K8Ve28wD/l/0vWFOqc0seJleuha9vqyQ5tf6seTwKmbYJ3aIREEtL4TuamPFqCSEZQtcJbCs1jxZfqsi1ni5jMv7u3oU1+Qa0oZe7mdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739409208; c=relaxed/simple;
	bh=IkC5DrSpwBzYVtxuuXtzRppK51yx82yjGQY9KwH7jcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OQDQAxT4gNEHQRh3PCbGRCfA9QUXmqKbOZHLx0ITsynvtpjqixXqQtrZsVvU7yK9bDw/5I9/H7Irp1VDN3jhRmngBFtluHZdNGqpWqN5gFIF7g3WVtr6jZ2AaF3NuRjMUw0gix8tUtuzHCRESTh6CERoUDfkXjhF/4F1i+d0NBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LRxB+RgI; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-726cdf7541eso158204a34.1
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 17:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1739409206; x=1740014006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xs0HqGMlTz4yprx8RCINcEsYohiRoMzfTFTjyXVzrPs=;
        b=LRxB+RgIp8cQZ18AkrK0eM0fcsWze2PYT/5Cr7GZf7siPyjminFvht90ttQOmEK5PA
         bvgqwvjqTTVjFxmmFsuPKfW6tuUjB9JCsXnqg1ywBamTzLHsk0OoFhvTea1xGERT4A7M
         yvQDr1BRS2GaWLwAjOfByZqGui8jGlz9cbWZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739409206; x=1740014006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xs0HqGMlTz4yprx8RCINcEsYohiRoMzfTFTjyXVzrPs=;
        b=Nt/caCMkjlOyO0r/2pc5Tg7hSOQNbVaDns2UJpDw8mxnzGvCYr71rcymPdrloVcWwo
         fSXqZb4H7tUfEhIS56iG4J2TOruUFEsRLGjZBYkLr6Jtql4LVRgkX6ujWhq/+PA0wRpJ
         xU7y0Nvf6UVcB72dAm5/009UCd48OwbdOO+0dfhv1iaJj7TN8fXIKjYc4ePB4z85zlrb
         pQkfrK7mJaAVAqcEfQ+P8k4HvIBvzG+mkFpkau42RBjeXmJZmdibhwj2e74OpuRy0XPA
         VZ+jAzx0PJVLHoNHxrrRnJQrm+AJX1c3wTZgBzsOp7TGpOUabNNSFaapY//O5tHyv0+F
         zVpA==
X-Gm-Message-State: AOJu0YwkSqk0lqKnbhbH0jltFwPI376toabZggk9c2sS54uDGJRUpBvk
	vi5CniYn7CXDEVz6UxCFSo5szvQDan2l5FaJ2AVngPgIqRntZS/ufU2uyyp4Rg==
X-Gm-Gg: ASbGncuLcPaQDGRHbUkDY7tXXLWr4qwkEuyn086PkDc0ToVuiBpZfdIejROeC+C/WEI
	qZrBljgHxFjqyFd1Le+3u/DvsBt62usPI4B6Uf8d8Dofo4/g0tcEY3EbM99qjPnjXTiFTAr1IIG
	btEzjhcZJdwFtVcNLC2fwPt4c5IsUinCOyDkkwOrIUGAYzbKdMV/6rGECdJpWTsTD2jVuPlvyGv
	QxGh6cR5Svr4nL3M18ybIDhcHEZ+c11M1eusjP+WYiUXzMkwYcdTdV7n8S3fsGAPPZ72jGzAMYl
	JptCl/vRf1T961JwnYNIqEfkI3BK2Pw+38NTQoRdA4bxCjGfbNWP52ASYFWZmYszYj4=
X-Google-Smtp-Source: AGHT+IF/90JA6hBCg9mTROhXerY/WnHdDUfq+jLIX9BjVR5CxSdS8gMp97PBgBoUcYKw4CfxvBzv7g==
X-Received: by 2002:a05:6830:6e8c:b0:71e:15f7:1a3a with SMTP id 46e09a7af769-726fefd3a0emr603731a34.2.1739409205848;
        Wed, 12 Feb 2025 17:13:25 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-727001cdb70sm195967a34.13.2025.02.12.17.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 17:13:24 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	michal.swiatkowski@linux.intel.com,
	helgaas@kernel.org,
	horms@kernel.org,
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH net-next v5 01/11] bnxt_en: Set NPAR 1.2 support when registering with firmware
Date: Wed, 12 Feb 2025 17:12:29 -0800
Message-ID: <20250213011240.1640031-2-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20250213011240.1640031-1-michael.chan@broadcom.com>
References: <20250213011240.1640031-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NPAR (Network interface card partitioning)[1] 1.2 adds a transparent
VLAN tag for all packets between the NIC and the switch.  Because of
that, RX VLAN acceleration cannot be supported for any additional
host configured VLANs.  The driver has to acknowledge that it can
support no RX VLAN acceleration and set the NPAR 1.2 supported flag
when registering with the FW.  Otherwise, the FW call will fail and
the driver will abort on these NPAR 1.2 NICs with this error:

bnxt_en 0000:26:00.0 (unnamed net_device) (uninitialized): hwrm req_type 0x1d seq id 0xb error 0x2

[1] https://techdocs.broadcom.com/us/en/storage-and-ethernet-connectivity/ethernet-nic-controllers/bcm957xxx/adapters/introduction/features/network-partitioning-npar.html

Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
v4: Fix typo in NPAR and improve the description of NPAR
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 5 +++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 7b8b5b39c7bb..fc870c104c56 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -5565,6 +5565,8 @@ int bnxt_hwrm_func_drv_rgtr(struct bnxt *bp, unsigned long *bmap, int bmap_size,
 	if (bp->fw_cap & BNXT_FW_CAP_ERROR_RECOVERY)
 		flags |= FUNC_DRV_RGTR_REQ_FLAGS_ERROR_RECOVERY_SUPPORT |
 			 FUNC_DRV_RGTR_REQ_FLAGS_MASTER_SUPPORT;
+	if (bp->fw_cap & BNXT_FW_CAP_NPAR_1_2)
+		flags |= FUNC_DRV_RGTR_REQ_FLAGS_NPAR_1_2_SUPPORT;
 	req->flags = cpu_to_le32(flags);
 	req->ver_maj_8b = DRV_VER_MAJ;
 	req->ver_min_8b = DRV_VER_MIN;
@@ -8365,6 +8367,7 @@ static int bnxt_hwrm_func_qcfg(struct bnxt *bp)
 
 	switch (resp->port_partition_type) {
 	case FUNC_QCFG_RESP_PORT_PARTITION_TYPE_NPAR1_0:
+	case FUNC_QCFG_RESP_PORT_PARTITION_TYPE_NPAR1_2:
 	case FUNC_QCFG_RESP_PORT_PARTITION_TYPE_NPAR1_5:
 	case FUNC_QCFG_RESP_PORT_PARTITION_TYPE_NPAR2_0:
 		bp->port_partition_type = resp->port_partition_type;
@@ -9529,6 +9532,8 @@ static int __bnxt_hwrm_func_qcaps(struct bnxt *bp)
 		bp->fw_cap |= BNXT_FW_CAP_HOT_RESET_IF;
 	if (BNXT_PF(bp) && (flags_ext & FUNC_QCAPS_RESP_FLAGS_EXT_FW_LIVEPATCH_SUPPORTED))
 		bp->fw_cap |= BNXT_FW_CAP_LIVEPATCH;
+	if (flags_ext & FUNC_QCAPS_RESP_FLAGS_EXT_NPAR_1_2_SUPPORTED)
+		bp->fw_cap |= BNXT_FW_CAP_NPAR_1_2;
 	if (BNXT_PF(bp) && (flags_ext & FUNC_QCAPS_RESP_FLAGS_EXT_DFLT_VLAN_TPID_PCP_SUPPORTED))
 		bp->fw_cap |= BNXT_FW_CAP_DFLT_VLAN_TPID_PCP;
 	if (flags_ext & FUNC_QCAPS_RESP_FLAGS_EXT_BS_V2_SUPPORTED)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 2373f423a523..db0be469a3db 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2492,6 +2492,7 @@ struct bnxt {
 	#define BNXT_FW_CAP_CFA_RFS_RING_TBL_IDX_V3	BIT_ULL(39)
 	#define BNXT_FW_CAP_VNIC_RE_FLUSH		BIT_ULL(40)
 	#define BNXT_FW_CAP_SW_MAX_RESOURCE_LIMITS	BIT_ULL(41)
+	#define BNXT_FW_CAP_NPAR_1_2			BIT_ULL(42)
 
 	u32			fw_dbg_cap;
 
-- 
2.30.1


