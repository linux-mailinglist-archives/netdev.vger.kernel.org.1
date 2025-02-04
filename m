Return-Path: <netdev+bounces-162325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B32CA268DE
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 01:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6FD418866B1
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 00:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E751E13D53B;
	Tue,  4 Feb 2025 00:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aWo1c8mB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4611213BC0E
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 00:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738630031; cv=none; b=AuxXKGe8RFo6Yc7byxSfExSC10SlFDFj17BqJ6+Pf1c2FA3eHJmfS5uVMoXazlIFVZGfVAdfN93DIn1KewnZNpNWE8UoS174g1fqD9jQkWfymZcOw2dfbXGuXXjbKmUwqM/WOEwx5jXOhnK9gxGKl41R2TWkvABPkTqPsdTYS4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738630031; c=relaxed/simple;
	bh=/Z40j/J42ZiQ048j2vF3aU41dOC1PM7eOBd+ElrAFQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NrJ8wb57bByH8hvHHNtykYg1Cx1ROx3vZ1vo6Q34HWI5NQZpf81UXNOQvauj4rAqboheDhYpf1kcXw5FfM+9CV8VmWVAPeejLJW/G0tSsYdHYVYLQlU19JkNG7RVTyCxOnLhUPtRfrZrfvgvtv2pPjfNit/rK+mn5UTk/aWIeo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aWo1c8mB; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2b38896c534so1579709fac.0
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 16:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1738630029; x=1739234829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I4ASapAG1egWbtPE1ui+0PISpvbEH/BCpm+FdWZFb9A=;
        b=aWo1c8mBQG0GHRt+bvUpSdCdTcc6vDyVlwvn63/1yL4HyF2ts2tSOZYrctp3fpaRA8
         xWAZzkaNb4ZmsfcnHEviPUynt4hSBFJmp0MCBEr+zUcdfoYl7PhTo7xqjF/H1b0mkxKw
         VAe6WDQdzfTf/yvuOIe5/4Z76GT8/tpEtxT40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738630029; x=1739234829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I4ASapAG1egWbtPE1ui+0PISpvbEH/BCpm+FdWZFb9A=;
        b=kqnz6ST/oqLowd5HMbWHb1DZzFC2EFVLDpquzh7hmJuCY9kjD/DkkKr2pOR8S4SmyY
         LtCzv4NN+PuestDIb5C0c0h26qG8dpCM6o8CoLbX6sG9wKVNX0aCP2+iOrAerbfmODx9
         fIiHqgial7c16JWCtppqe07+WLsn4jkO3xIL3A8EegLqoxOlX8PDYXvVkttzOpP+tk9u
         VklRxDP8ApGXpjdp3S+eMSSAGyavqZrC4mZZxSLcC9sTSp9M10+UjTutaYNUNWtVYVzz
         CiYNgcpMPekhP107oCWRv8JNB2BxOZzasto6ibeibG3nQjQzkzuTix7BCeZPg7PcReF4
         RHTg==
X-Gm-Message-State: AOJu0YyBXcCG8YV+N1B2kRbYSGedU6M1apvoG1ZmKsMrSN2J6rx6pK6b
	dQUNUJu1BpdHgfYCIJCzdOTZDcctNReSAOGLOOLQDEqm6e6y3CHuqPMp+/N3iQ==
X-Gm-Gg: ASbGnctEJzCyxkktu8P6BcxCWjjyX2XdX7qKUIW+vCOCXvBapc9Lz8r79gcGOzJpBv+
	j1j6Hl2KvwlK2M2y9CWSlhZekfp2/OtVCRqfFE2bDSMuzxbbKZijjaDWcT9slbR7fKvcMmuoWn+
	PjHI209nWAnm70V5mU0/WZweGSNU2qx33/KDhgZiLd9yF5pURUpVGM0Nt//JzuBT5LYYxVEH4RS
	VUnx/49NytKl9Ju/6BgBs67PMvsPFnC6NqpE0bfjUIP/gvpFmdt47YUs2nitXZ7oxkGKtYovpul
	z5In/q8T8u9455JO0pkOiF8exNfKhcPNcXNFVRGD3wohYmJVEnqzOqmTw5Y+pJjStBg=
X-Google-Smtp-Source: AGHT+IFk3q/GgSkRy/mZS7Gvnx9Q3/oDzno7LYedYezPQ8NDa17Q6Y9K1skzu6mdmxytpwvkdJggHA==
X-Received: by 2002:a05:6870:718d:b0:288:60d6:f183 with SMTP id 586e51a60fabf-2b32f405d98mr14046537fac.38.1738630029361;
        Mon, 03 Feb 2025 16:47:09 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b356658291sm3680495fac.46.2025.02.03.16.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 16:47:08 -0800 (PST)
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
	Hongguang Gao <hongguang.gao@broadcom.com>,
	Ajit Khaparde <ajit.khaparde@broadcom.com>
Subject: [PATCH net-next v3 07/10] bnxt_en: Pass NQ ID to the FW when allocating RX/RX AGG rings
Date: Mon,  3 Feb 2025 16:46:06 -0800
Message-ID: <20250204004609.1107078-8-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20250204004609.1107078-1-michael.chan@broadcom.com>
References: <20250204004609.1107078-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Newer firmware can use the NQ ring ID associated with each RX/RX AGG
ring to enable PCIe Steering Tags on P5_PLUS chips.  When allocating
RX/RX AGG rings, pass along NQ ring ID for the firmware to use.  This
information helps optimize DMA writes by directing them to the cache
closer to the CPU consuming the data, potentially improving the
processing speed.  This change is backward-compatible with older
firmware, which will simply disregard the information.

Reviewed-by: Hongguang Gao <hongguang.gao@broadcom.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index ac63d3feaa1d..c6cf575af53f 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -6949,7 +6949,8 @@ static void bnxt_set_rx_ring_params_p5(struct bnxt *bp, u32 ring_type,
 				       struct bnxt_ring_struct *ring)
 {
 	struct bnxt_ring_grp_info *grp_info = &bp->grp_info[ring->grp_idx];
-	u32 enables = RING_ALLOC_REQ_ENABLES_RX_BUF_SIZE_VALID;
+	u32 enables = RING_ALLOC_REQ_ENABLES_RX_BUF_SIZE_VALID |
+		      RING_ALLOC_REQ_ENABLES_NQ_RING_ID_VALID;
 
 	if (ring_type == HWRM_RING_ALLOC_AGG) {
 		req->ring_type = RING_ALLOC_REQ_RING_TYPE_RX_AGG;
@@ -6963,6 +6964,7 @@ static void bnxt_set_rx_ring_params_p5(struct bnxt *bp, u32 ring_type,
 				cpu_to_le16(RING_ALLOC_REQ_FLAGS_RX_SOP_PAD);
 	}
 	req->stat_ctx_id = cpu_to_le32(grp_info->fw_stats_ctx);
+	req->nq_ring_id = cpu_to_le16(grp_info->cp_fw_ring_id);
 	req->enables |= cpu_to_le32(enables);
 }
 
-- 
2.30.1


