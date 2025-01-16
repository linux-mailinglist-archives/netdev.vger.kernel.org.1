Return-Path: <netdev+bounces-159019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D46E7A14230
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 20:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0233818896F8
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 19:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E0D22F39F;
	Thu, 16 Jan 2025 19:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ez6OGNLl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB9622B8A9
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 19:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737055483; cv=none; b=gaSk2dUySfnHyl9HAJmmTe7SiqcvjeBKNv9W1GqKILZXmh9wDMl35KESmCwTQNIKOeTLjl5c86Ssfqbjkbk9ZT50GruVFQ/j+Z7N9xO1r/LZl5fWEgLX5432U6EEe7+wBZRIQj3eiJNOolP8poZh0olOBdWWO8mxF76c/hZBCQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737055483; c=relaxed/simple;
	bh=LYbyOJTeU0RS3sb8eNK2pi6KYWNiweEbKG9ET9ULzwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ifNpAY1A2na+kjRqm0N+5npfO/UPZnx8tlghl2fey1UjMHmm+1dsYvc9rcmGp7eDv3mp9pjIwizIB1fDY7+YyhZ/dGotLPgXwv0tkfMxpVSEyE+2Sbrp231U7g2ODGK9n1zds8ZvtX9o9Rd7Mjis6/z4NcFBexraKHp4k1eFVNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ez6OGNLl; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ef72924e53so2296343a91.3
        for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 11:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1737055481; x=1737660281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZLziLblqXn0X0vNxrEaoY/jJlf8gIk/09LOvv2VBV+A=;
        b=ez6OGNLlRIBoWFwsNcJxdR89VEh+PeMazy0MfmzZUQ8MFeiIAbPFfrlJqp+HKJbBio
         fs5jH+yunvHTCkCm6oxkpdNYsosbVxpsPvtOqbhKVsZnSWQB7Pv2p4a1q1fimuIXtwTM
         wd3F/IxOePZA0L3xMQpx9R5XJ8qsTGp9MtVoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737055481; x=1737660281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZLziLblqXn0X0vNxrEaoY/jJlf8gIk/09LOvv2VBV+A=;
        b=qriDrFsYCprfbDbnG0nAlPFdRnC0dRDK0Hf9uM9lJiW+1TR8xjPg85OpxMV4HbSIqy
         9V9v6McGeEBMpMvuBsw1KXF7PPsh8hSpoacklJH3eyggOhtgn4qLt/bLDVU31I8UyQ1r
         l4dGrcCUS4rUXtpsOpNwP9yMlsUSqOGhM32E1I4YIFP0kdeKjKZtoPFGGIpr9YCNc30z
         XRkCtHA1jLXmzvI6I/mLEj5nVk/7iHflVOA6t96NcDTxuNxaUYDOgiSwy/gGCNNnWgtO
         8P0TxJdJ+hqEUjHEfLmeb3RAyID9PIw4Q4X8qdmm5tdZM/ghCmK4W9CL5AWzdmW6eqHz
         Cpjw==
X-Gm-Message-State: AOJu0YyisYvz1e1U/XokfuAmZWKmx7mXIPzOs+BQRsb9IxVxedfYBZiS
	fOHIr3c2svI1SBzu/STriVUBDqeNWcyDmwFyxihdOaLIOHhrRg29nevizo+WzQ==
X-Gm-Gg: ASbGncul6jSQ3qDNjSyhbU1Ou6hZazz7fg5eqr9tvryxb0kLHMj23TnwTabOnLhMHju
	a4uVFZGUE5vH17bwKtSZGpe+thYJ5pT24khrfn5Q/i8V00FkZ5lfv+PKwtqXSWnUseWTVbVI9H/
	MCJ6+jp9B8H5XbHEfvFmD5LpYn0DsSeb2h3G5yca8fOEYab1WLoZeLTd99e173UH98bMIByyW4d
	kj2Qs2Y0p8z/MywHO4j1BLUrCTK9Q1ZRTBTU7+PhZKUmwwibAAcJCCFXOJNRZfVJREazQOLOnr/
	PEn0G38wfWf/+qqXRu7KeazK10+WvfZr
X-Google-Smtp-Source: AGHT+IEUS93mkL0UFabFnO4gO2jhZsqggWyX53oFcpNG82e5EYpIwRvcNSbW7LQljo+1SWNgZoNsZA==
X-Received: by 2002:a17:90b:2f45:b0:2ef:2f49:7d7f with SMTP id 98e67ed59e1d1-2f548ece7afmr54534775a91.18.1737055481256;
        Thu, 16 Jan 2025 11:24:41 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f77615720asm491017a91.19.2025.01.16.11.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 11:24:40 -0800 (PST)
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
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH net-next v2 01/10] bnxt_en: Set NAPR 1.2 support when registering with firmware
Date: Thu, 16 Jan 2025 11:23:34 -0800
Message-ID: <20250116192343.34535-2-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20250116192343.34535-1-michael.chan@broadcom.com>
References: <20250116192343.34535-1-michael.chan@broadcom.com>
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
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 5 +++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index caddb5cbc024..5fda41acbb5a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -5543,6 +5543,8 @@ int bnxt_hwrm_func_drv_rgtr(struct bnxt *bp, unsigned long *bmap, int bmap_size,
 	if (bp->fw_cap & BNXT_FW_CAP_ERROR_RECOVERY)
 		flags |= FUNC_DRV_RGTR_REQ_FLAGS_ERROR_RECOVERY_SUPPORT |
 			 FUNC_DRV_RGTR_REQ_FLAGS_MASTER_SUPPORT;
+	if (bp->fw_cap & BNXT_FW_CAP_NPAR_1_2)
+		flags |= FUNC_DRV_RGTR_REQ_FLAGS_NPAR_1_2_SUPPORT;
 	req->flags = cpu_to_le32(flags);
 	req->ver_maj_8b = DRV_VER_MAJ;
 	req->ver_min_8b = DRV_VER_MIN;
@@ -8343,6 +8345,7 @@ static int bnxt_hwrm_func_qcfg(struct bnxt *bp)
 
 	switch (resp->port_partition_type) {
 	case FUNC_QCFG_RESP_PORT_PARTITION_TYPE_NPAR1_0:
+	case FUNC_QCFG_RESP_PORT_PARTITION_TYPE_NPAR1_2:
 	case FUNC_QCFG_RESP_PORT_PARTITION_TYPE_NPAR1_5:
 	case FUNC_QCFG_RESP_PORT_PARTITION_TYPE_NPAR2_0:
 		bp->port_partition_type = resp->port_partition_type;
@@ -9507,6 +9510,8 @@ static int __bnxt_hwrm_func_qcaps(struct bnxt *bp)
 		bp->fw_cap |= BNXT_FW_CAP_HOT_RESET_IF;
 	if (BNXT_PF(bp) && (flags_ext & FUNC_QCAPS_RESP_FLAGS_EXT_FW_LIVEPATCH_SUPPORTED))
 		bp->fw_cap |= BNXT_FW_CAP_LIVEPATCH;
+	if (flags_ext & FUNC_QCAPS_RESP_FLAGS_EXT_NPAR_1_2_SUPPORTED)
+		bp->fw_cap |= BNXT_FW_CAP_NPAR_1_2;
 	if (BNXT_PF(bp) && (flags_ext & FUNC_QCAPS_RESP_FLAGS_EXT_DFLT_VLAN_TPID_PCP_SUPPORTED))
 		bp->fw_cap |= BNXT_FW_CAP_DFLT_VLAN_TPID_PCP;
 	if (flags_ext & FUNC_QCAPS_RESP_FLAGS_EXT_BS_V2_SUPPORTED)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 8f481dd9c224..826ae030fc09 100644
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


