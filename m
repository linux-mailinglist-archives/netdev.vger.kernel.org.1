Return-Path: <netdev+bounces-187337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFCBAA676E
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 01:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D354B175C0E
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 23:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7047626AA83;
	Thu,  1 May 2025 23:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dsixik8R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0A8269CED
	for <netdev@vger.kernel.org>; Thu,  1 May 2025 23:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746142207; cv=none; b=JXcSJN9LiK1NFAWQIVxA//R8Sdl94DJHKs78KrblzDTnAOC9wr08FF1/mPvya4x9fX27n1JOZLM8Po0VqOlOtHoSOjTTOInp6d7RI3Y/pjABnt69eEa+tf8qnUR+It89PopBL2N2KEldhOZVUcla0VNj1mVYkCIenm1XeACcdx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746142207; c=relaxed/simple;
	bh=R4/af6cJwJdQBeDpOZaGe6Uj14/Fg/JatIj+tJx8yjY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qRr94Lk3bkEdnK0oBm1o6kdVM/fhSE5zRnEQZcpY2IsRaG/X2QP1Btc1HWpam+9z1bWExzoshK8FjHvPMqKFPm4Rkljm9aUlbWII5UCSJxpICZkPKuJ10CFgWcnVHKPr+eySfLu8B60rNSMMVdNdeGE19zlS8e9V1NdMs9EwrPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dsixik8R; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-73bb647eb23so1460921b3a.0
        for <netdev@vger.kernel.org>; Thu, 01 May 2025 16:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746142205; x=1746747005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9lBZNIZFe2O+eHpsTGsQ1WDmkrJ/xuACWlcVt0AaO9Q=;
        b=dsixik8RatchTNlsGuAZjfokWQ4aTYmRFQvAPiF3QUZaLKL+uGaYVtZahRwH5YCmRV
         QG2UzIX0wrv8VaCgSs96JU42nIXe4eYBctFyM/9znO7ZuLRfZPudQJpklCjKOuiXtRhD
         rY0/wohwIudwawclW6guEFfXFBjzPJy7RT+E07QdyUlPpiOf+R7q20Rwi7K2RpYP/58z
         JAMYrm+U/GDrxDrfSTDL+DStGvW1UDhQ4X7D4RI0xSRF6j85w9AAsG9fDxe/SC3TWipx
         XVvpKYYd35afQB7pCQGkwWld3tR0Buwt32uWZpSlzPpYZF+FtMRnMYk/qQvteTCa+OyB
         574Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746142205; x=1746747005;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9lBZNIZFe2O+eHpsTGsQ1WDmkrJ/xuACWlcVt0AaO9Q=;
        b=pQVYRIE8r1dcrrMw6HWdEgBN/MRIj0EviuIiuhMk01A/mbuq1zLAQMSARzh5h83GNJ
         7cgzGbGqNsW7LfLai/367WlaqjuLNnx+9mgfOWpVlaukpNMJnzwPn4KL5qbCyHeWTSyN
         Bu90VOP1431efkBxMLbwko9j70jKKA5VlqqKld5/Ll/4s02BqZrgQpGXvswKOOvoHoVW
         caeqBUoMMpFcPf63Tc2RSdUcRas9egGlf8hnexMHbjxEabNg1xqpKXFDcHJBH2cy1B4D
         M1ChHaFYadMfwWwLCC+dnnlQyDE1Q4F1WvI/1RdNLfekbkOe9F0xay7ap0LK9O5+T8L1
         dKqQ==
X-Gm-Message-State: AOJu0YwzKHXbEZhusWywdJNDLKXjAvjc603RV+kBDlpG+GDjo9Sc8X0a
	ZywcvP+4dS33VSTuoEAW59FGxeRpfS/KJ8hb00sNA3WuzNNH+bUoBkZCAA==
X-Gm-Gg: ASbGnctx3X9ORJIl7YAvMYcbb+/mFg1N6YpTgYlR94b+alOd38+7M05m7emk6B2xoAf
	2MwmWHqwU3kqzDiOupgPyHqCsD16IroXm7RtWj53a00KYX3Xfh8q2V7TrPp+r2pdMDoa+52wJQH
	tGJbS2Jzwpj4eP+wcx5eE5ZphBPqaHjCcf3dBi2XCPNQfSmY4dEVP0PR6zo0opBqKSrd6+CZEoJ
	/yjaMDd13LPrRIB1LiSvyUxscoSVnfA1RMjYFv+XSbg5uhf/1I2PxrccWeEQs/bNmUtC/PY4veY
	2PiEsCqhGn571ViccVYvyRQec80l2puh/k4mz0mxsBXlhlRVTdLMsFX32Iizk3ZkFJQcyiKInxU
	=
X-Google-Smtp-Source: AGHT+IFKobAJTtxJIGJaAx17ryx1yg45L997d3JlZLBWrJ1g0d1qNJnrlZ3CdwZNzr52yVPnAqaCzQ==
X-Received: by 2002:a05:6a20:918e:b0:1f5:619a:8f73 with SMTP id adf61e73a8af0-20cdfdf47b8mr823523637.26.1746142204887;
        Thu, 01 May 2025 16:30:04 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b1fa82b568asm164889a12.41.2025.05.01.16.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 16:30:04 -0700 (PDT)
Subject: [net PATCH 2/6] fbnic: Gate AXI read/write enabling on FW mailbox
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
Date: Thu, 01 May 2025 16:30:03 -0700
Message-ID: 
 <174614220363.126317.10550539950263575976.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <174614212557.126317.3577874780629807228.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <174614212557.126317.3577874780629807228.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexander Duyck <alexanderduyck@fb.com>

In order to prevent the device from throwing spurious writes and/or reads
at us we need to gate the AXI fabric interface to the PCIe until such time
as we know the FW is in a known good state.

To accomplish this we use the mailbox as a mechanism for us to recognize
that the FW has acknowledged our presence and is no longer sending any
stale message data to us.

We start in fbnic_mbx_init by calling fbnic_mbx_reset_desc_ring function,
disabling the DMA in both directions, and then invalidating all the
descriptors in each ring.

We then poll the mailbox in fbnic_mbx_poll_tx_ready and when the interrupt
is set by the FW we pick it up and mark the mailboxes as ready, while also
enabling the DMA.

Once we have completed all the transactions and need to shut down we call
into fbnic_mbx_clean which will in turn call fbnic_mbx_reset_desc_ring for
each ring and shut down the DMA and once again invalidate the descriptors.

Fixes: 3646153161f1 ("eth: fbnic: Add register init to set PCIe/Ethernet device config")
Fixes: da3cde08209e ("eth: fbnic: Add FW communication mechanism")

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h |    2 +
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c  |   38 ++++++++++++++++++++++-----
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c |    6 ----
 3 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
index 3b12a0ab5906..51bee8072420 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
@@ -796,8 +796,10 @@ enum {
 /* PUL User Registers */
 #define FBNIC_CSR_START_PUL_USER	0x31000	/* CSR section delimiter */
 #define FBNIC_PUL_OB_TLP_HDR_AW_CFG	0x3103d		/* 0xc40f4 */
+#define FBNIC_PUL_OB_TLP_HDR_AW_CFG_FLUSH	CSR_BIT(19)
 #define FBNIC_PUL_OB_TLP_HDR_AW_CFG_BME		CSR_BIT(18)
 #define FBNIC_PUL_OB_TLP_HDR_AR_CFG	0x3103e		/* 0xc40f8 */
+#define FBNIC_PUL_OB_TLP_HDR_AR_CFG_FLUSH	CSR_BIT(19)
 #define FBNIC_PUL_OB_TLP_HDR_AR_CFG_BME		CSR_BIT(18)
 #define FBNIC_PUL_USER_OB_RD_TLP_CNT_31_0 \
 					0x3106e		/* 0xc41b8 */
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index c4956f0a741e..f4749bfd840c 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -51,10 +51,26 @@ static u64 __fbnic_mbx_rd_desc(struct fbnic_dev *fbd, int mbx_idx, int desc_idx)
 	return desc;
 }
 
-static void fbnic_mbx_init_desc_ring(struct fbnic_dev *fbd, int mbx_idx)
+static void fbnic_mbx_reset_desc_ring(struct fbnic_dev *fbd, int mbx_idx)
 {
 	int desc_idx;
 
+	/* Disable DMA transactions from the device,
+	 * and flush any transactions triggered during cleaning
+	 */
+	switch (mbx_idx) {
+	case FBNIC_IPC_MBX_RX_IDX:
+		wr32(fbd, FBNIC_PUL_OB_TLP_HDR_AW_CFG,
+		     FBNIC_PUL_OB_TLP_HDR_AW_CFG_FLUSH);
+		break;
+	case FBNIC_IPC_MBX_TX_IDX:
+		wr32(fbd, FBNIC_PUL_OB_TLP_HDR_AR_CFG,
+		     FBNIC_PUL_OB_TLP_HDR_AR_CFG_FLUSH);
+		break;
+	}
+
+	wrfl(fbd);
+
 	/* Initialize first descriptor to all 0s. Doing this gives us a
 	 * solid stop for the firmware to hit when it is done looping
 	 * through the ring.
@@ -90,7 +106,7 @@ void fbnic_mbx_init(struct fbnic_dev *fbd)
 	wr32(fbd, FBNIC_INTR_CLEAR(0), 1u << FBNIC_FW_MSIX_ENTRY);
 
 	for (i = 0; i < FBNIC_IPC_MBX_INDICES; i++)
-		fbnic_mbx_init_desc_ring(fbd, i);
+		fbnic_mbx_reset_desc_ring(fbd, i);
 }
 
 static int fbnic_mbx_map_msg(struct fbnic_dev *fbd, int mbx_idx,
@@ -155,7 +171,7 @@ static void fbnic_mbx_clean_desc_ring(struct fbnic_dev *fbd, int mbx_idx)
 {
 	int i;
 
-	fbnic_mbx_init_desc_ring(fbd, mbx_idx);
+	fbnic_mbx_reset_desc_ring(fbd, mbx_idx);
 
 	for (i = FBNIC_IPC_MBX_DESC_LEN; i--;)
 		fbnic_mbx_unmap_and_free_msg(fbd, mbx_idx, i);
@@ -354,7 +370,7 @@ static int fbnic_fw_xmit_cap_msg(struct fbnic_dev *fbd)
 	return (err == -EOPNOTSUPP) ? 0 : err;
 }
 
-static void fbnic_mbx_postinit_desc_ring(struct fbnic_dev *fbd, int mbx_idx)
+static void fbnic_mbx_init_desc_ring(struct fbnic_dev *fbd, int mbx_idx)
 {
 	struct fbnic_fw_mbx *mbx = &fbd->mbx[mbx_idx];
 
@@ -366,10 +382,18 @@ static void fbnic_mbx_postinit_desc_ring(struct fbnic_dev *fbd, int mbx_idx)
 
 	switch (mbx_idx) {
 	case FBNIC_IPC_MBX_RX_IDX:
+		/* Enable DMA writes from the device */
+		wr32(fbd, FBNIC_PUL_OB_TLP_HDR_AW_CFG,
+		     FBNIC_PUL_OB_TLP_HDR_AW_CFG_BME);
+
 		/* Make sure we have a page for the FW to write to */
 		fbnic_mbx_alloc_rx_msgs(fbd);
 		break;
 	case FBNIC_IPC_MBX_TX_IDX:
+		/* Enable DMA reads from the device */
+		wr32(fbd, FBNIC_PUL_OB_TLP_HDR_AR_CFG,
+		     FBNIC_PUL_OB_TLP_HDR_AR_CFG_BME);
+
 		/* Force version to 1 if we successfully requested an update
 		 * from the firmware. This should be overwritten once we get
 		 * the actual version from the firmware in the capabilities
@@ -386,7 +410,7 @@ static void fbnic_mbx_postinit(struct fbnic_dev *fbd)
 {
 	int i;
 
-	/* We only need to do this on the first interrupt following init.
+	/* We only need to do this on the first interrupt following reset.
 	 * this primes the mailbox so that we will have cleared all the
 	 * skip descriptors.
 	 */
@@ -396,7 +420,7 @@ static void fbnic_mbx_postinit(struct fbnic_dev *fbd)
 	wr32(fbd, FBNIC_INTR_CLEAR(0), 1u << FBNIC_FW_MSIX_ENTRY);
 
 	for (i = 0; i < FBNIC_IPC_MBX_INDICES; i++)
-		fbnic_mbx_postinit_desc_ring(fbd, i);
+		fbnic_mbx_init_desc_ring(fbd, i);
 }
 
 /**
@@ -894,7 +918,7 @@ int fbnic_mbx_poll_tx_ready(struct fbnic_dev *fbd)
 		 * avoid the mailbox getting stuck closed if the interrupt
 		 * is reset.
 		 */
-		fbnic_mbx_init_desc_ring(fbd, FBNIC_IPC_MBX_TX_IDX);
+		fbnic_mbx_reset_desc_ring(fbd, FBNIC_IPC_MBX_TX_IDX);
 
 		msleep(200);
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
index 14291401f463..dde4a37116e2 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
@@ -79,12 +79,6 @@ static void fbnic_mac_init_axi(struct fbnic_dev *fbd)
 	fbnic_init_readrq(fbd, FBNIC_QM_RNI_RBP_CTL, cls, readrq);
 	fbnic_init_mps(fbd, FBNIC_QM_RNI_RDE_CTL, cls, mps);
 	fbnic_init_mps(fbd, FBNIC_QM_RNI_RCM_CTL, cls, mps);
-
-	/* Enable XALI AR/AW outbound */
-	wr32(fbd, FBNIC_PUL_OB_TLP_HDR_AW_CFG,
-	     FBNIC_PUL_OB_TLP_HDR_AW_CFG_BME);
-	wr32(fbd, FBNIC_PUL_OB_TLP_HDR_AR_CFG,
-	     FBNIC_PUL_OB_TLP_HDR_AR_CFG_BME);
 }
 
 static void fbnic_mac_init_qm(struct fbnic_dev *fbd)



