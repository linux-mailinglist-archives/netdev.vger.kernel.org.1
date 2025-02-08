Return-Path: <netdev+bounces-164369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0097A2D89D
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 21:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35EF718888E5
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 20:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC26243961;
	Sat,  8 Feb 2025 20:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Pv6ePcn1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CCE22DFE3
	for <netdev@vger.kernel.org>; Sat,  8 Feb 2025 20:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739046606; cv=none; b=Y4p2INUPyVpxZHx0GSJzzfbmLbKDcFylpGnrvjmViVy9khDP1Za8fhUPN+OmjADBNQvKREWibq5bZ5sru0ThqggdLRJZZBx4Iv9jEmFpLqed4bf2oKTLAfiWFAQzrQ53clzd8iVlWWgH2vjZaqqea1mlMw+P2BaBWT9mFixp8/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739046606; c=relaxed/simple;
	bh=3Wv6fRui6JUppkVHVPDhuyoEourXEdFIz2Ar68Mhcgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZxumCYe8eet+vddgqjkV4PL6h556ml1DtPuxAB+pcOVfV9Ev8ZXwvv0Pxm7BaDqQNJRg1NVmIw9JRISDzLiHzxMCHYyl64O3smzsXj6FhbSkIAKuUA/XxVbIMeQP9db8eV9+ym0Ng9uqhhYpBV02EFcOrIPkTpsZAMXXGjGysIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Pv6ePcn1; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-71e2aa8d5e3so1903046a34.2
        for <netdev@vger.kernel.org>; Sat, 08 Feb 2025 12:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1739046604; x=1739651404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tYbE7VuTl9BMV8ls+ftV23iDp1ujBGiTUNoHs2AfpuI=;
        b=Pv6ePcn18QvHBQb4tc75AvJdQCpxXBBa8cdVCdvyyjo9vx7Hhp/F+u5DDYm3oMX4aw
         blJnIc7G4ltFgvnERAGT99kXlAubAf/yGVpRHOFjJHafFg7IOBrUjUmWGF6sSHWk/pdm
         GsOXa5/SGzIDNhiJVi/RFZTlqfz3CV80+/i/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739046604; x=1739651404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tYbE7VuTl9BMV8ls+ftV23iDp1ujBGiTUNoHs2AfpuI=;
        b=HUW2QfrBe/9SFoZElt70kZj1NRInmEZuJ05GpaJIMycMyUyMB7TW4hi8fsT/sXEOOX
         73YLIarNrXASHPprx/D6CPyo1lHhFnYevWJE7TWf/IdZMZRUa4IrX0Bk6YDqydOOH5Oj
         kIsl0NBUwLOhFT8I7oFsHKSM+qUp7lqYRSiB3plMtojPqV9JcVwLpNu8X7OFD8I+diBB
         ZRJW7UqnIsLBpUQaRskHXCAmrtMEDsNHiNKrnD0zuo1gZj1BvwE0+7P5IulwMipQYR1k
         Xcu7IWkLv3HqmkIgGsaqFVXV64eBdRZCrJjRX4Ly0aTHPPYF+kf/ugPnScjbW24bR/LE
         WD4g==
X-Gm-Message-State: AOJu0YxFvn9NyWugS/sjXI+cV5psm5aHfsyVTBv+7lA+uwbTuL0xcELi
	XxBzSz4rN8NJhf6GWryCq9vWClxRK34wGxC6DH5plAn1ZSqVfVbrIChRpXozMQ==
X-Gm-Gg: ASbGncvylZJogcOv3od8IR2QiHvXGr6VZ+j8kg2D7q/BqcVUbK7UqqZkarDYPK+1qjX
	LblP89DvM3J+8GkMTTpq44iZt2U32KQkKrDyXzyKiEbpOEtw7Dmnu91Qh4fW1wwcimL7kqqzEHK
	abnZoQkTfQ/gNVSd547Sg5/rYVO1JTI+LvODcXT+GeRNadpp5Bwik7lNe8Wofj54a8Rby+GoTea
	xjScbFf3z+4SlwsNth6YxmFOMazHMcqbUauDHMUvGfxAB2t9SxEaNWWdwGZKkvkdwfYB3dxiqLz
	WOFSdlOf/e5icEVeS1AXwTnfZrKyRlEV2qbjQAauJfo1j99fqYjSRmvF9QeiHxnoc34=
X-Google-Smtp-Source: AGHT+IFuS7l4bzDp+1KhGR5m5TnOeXcvhMnfJRyDd3XNg3VQ4kAXenRRPKyiWxlqEHBj6Lxq5zknlg==
X-Received: by 2002:a05:6830:6dcb:b0:71e:4fc:6ee1 with SMTP id 46e09a7af769-726b87db8bamr6394010a34.9.1739046603726;
        Sat, 08 Feb 2025 12:30:03 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-726af932f78sm1564130a34.18.2025.02.08.12.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 12:30:02 -0800 (PST)
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
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net-next v4 04/10] bnxt_en: Refactor completion ring free routine
Date: Sat,  8 Feb 2025 12:29:10 -0800
Message-ID: <20250208202916.1391614-5-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20250208202916.1391614-1-michael.chan@broadcom.com>
References: <20250208202916.1391614-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Somnath Kotur <somnath.kotur@broadcom.com>

Add a wrapper routine to free L2 completion rings.  This will be
useful later in the series.

Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 26 ++++++++++++++---------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 8ab7345acb0a..52d4dc222759 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7405,6 +7405,20 @@ static void bnxt_hwrm_rx_agg_ring_free(struct bnxt *bp,
 	bp->grp_info[grp_idx].agg_fw_ring_id = INVALID_HW_RING_ID;
 }
 
+static void bnxt_hwrm_cp_ring_free(struct bnxt *bp,
+				   struct bnxt_cp_ring_info *cpr)
+{
+	struct bnxt_ring_struct *ring;
+
+	ring = &cpr->cp_ring_struct;
+	if (ring->fw_ring_id == INVALID_HW_RING_ID)
+		return;
+
+	hwrm_ring_free_send_msg(bp, ring, RING_FREE_REQ_RING_TYPE_L2_CMPL,
+				INVALID_HW_RING_ID);
+	ring->fw_ring_id = INVALID_HW_RING_ID;
+}
+
 static void bnxt_hwrm_ring_free(struct bnxt *bp, bool close_path)
 {
 	u32 type;
@@ -7450,17 +7464,9 @@ static void bnxt_hwrm_ring_free(struct bnxt *bp, bool close_path)
 		struct bnxt_ring_struct *ring;
 		int j;
 
-		for (j = 0; j < cpr->cp_ring_count && cpr->cp_ring_arr; j++) {
-			struct bnxt_cp_ring_info *cpr2 = &cpr->cp_ring_arr[j];
+		for (j = 0; j < cpr->cp_ring_count && cpr->cp_ring_arr; j++)
+			bnxt_hwrm_cp_ring_free(bp, &cpr->cp_ring_arr[j]);
 
-			ring = &cpr2->cp_ring_struct;
-			if (ring->fw_ring_id == INVALID_HW_RING_ID)
-				continue;
-			hwrm_ring_free_send_msg(bp, ring,
-						RING_FREE_REQ_RING_TYPE_L2_CMPL,
-						INVALID_HW_RING_ID);
-			ring->fw_ring_id = INVALID_HW_RING_ID;
-		}
 		ring = &cpr->cp_ring_struct;
 		if (ring->fw_ring_id != INVALID_HW_RING_ID) {
 			hwrm_ring_free_send_msg(bp, ring, type,
-- 
2.30.1


