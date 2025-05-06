Return-Path: <netdev+bounces-188390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA883AACA45
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 17:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF3CF1C280A8
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 16:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275DB283123;
	Tue,  6 May 2025 15:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cp4jdsp2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E48E280003
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 15:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746547190; cv=none; b=FJNOCvqDC6TgFbc70EjO7DnI/Xi7wsn8wdEc/sqPVFTfhioTKaDgWX0M5RMNak71GI/wZk9UDKxe7EQTCCVD8q6f1mH9Ivv4m/fBVRND4D1Nn3S2Ehn9OE4Z5wkI1YlcU+4rUT8z18X+pgMAPR1N0Af16Am94UtPfmV3sjDdXPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746547190; c=relaxed/simple;
	bh=QCJsYoj1oTmfmIvCzyHgTWLzbBR2fy47aVNnPBdMjDA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MdV7WRmtR0vj0YiYkdSsVqOoln7+PiTBTVIH9F2ez4hPbLCSkuwfVxjoeJtpuYO49y7lU/VuUR7uoUxweJeM7ctqtM7cygbVJxRedGgGZTsTkghU69zEBjepy1LcGOGvkCTlfoJ78D+bdOFDBmvjpozs4tyb96+KJ4PJIGCZMjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cp4jdsp2; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22e4d235811so9185105ad.2
        for <netdev@vger.kernel.org>; Tue, 06 May 2025 08:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746547187; x=1747151987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P51NVSKjCWPc4SX9Q6nhl8qupFiAz/rGmoEXT+YMWZc=;
        b=Cp4jdsp2VMy7bwDtD7jKY2z9lyHOannP0I9PbAG3WiH8KxKdSRA0BBaEZ/DyV2hhgE
         Li4ZW9ycmZ1U54YODdsw0Bp1fIBAsMbvGYb5mFhKk2b9CIfrsEsHQ5hk8sIKR/oFfOo9
         fQdzDXnGR7qaRk/JtpcshjXn8OIs/K9s+QlSnP/jkNgXFeABPZXQ9fay7MIg3/URIiku
         8acnhzs7lCoCelYlSLrbaKjmEQn0oOlXqh+AF9OdMzHf8oEVoBkA0lu375114HZjtHbB
         wBaiB+485jvpxtNNyB63zQ7IEKJ77BJ5BIxuC3js+qctIpeRZ81xSyMgsNkxmzwd4oeU
         Lvhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746547187; x=1747151987;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P51NVSKjCWPc4SX9Q6nhl8qupFiAz/rGmoEXT+YMWZc=;
        b=jLkyNT71fXOENeW2o5n6u+A8r6hRefG2SRYn+Tlr/voH7/WpRtIk1E/QWjnv7HsmP/
         1keWntPh44VGC38/HANS0d9bEkDuw4WTuZ9oUrV8CUbAA278IMHtzBHc2RzKGaO/IW0m
         fHrtVyMfoItAXWZ/fWIZJFDfjOZ2n9400j7+8/yHhL8jiof2Nnk4ZON9UTGBE230dgwb
         E73VRoXLKInHIoVHoDihzostxLuMPt6MMM6nCgsWhnXMSGsr1obYUpwHNwOOq5nsJi/v
         jYwCpkhhff6RJ6qyreUc41eskYopbG8nng97o3gAFmg4hqvRXeznzDfK6I03nhG+evkt
         meBw==
X-Gm-Message-State: AOJu0YxQ/EfMMN32ImoEQzxmMo+CWJjzwNNZ7OLoqpDpq3+7VnmkJ/X7
	JX3egXFwA/bmjndEf9u5+OusYroO4yWcTRSVR17nWrAfEOyKVzew
X-Gm-Gg: ASbGncu7ruilyxVxgL3oLOp5JNWL2l5kAMyHqUQtzbM99BjbrrT+ZFvkrl9AEOIXz3O
	Jjs4YiZ1F+WSY6cUzV1CvGNA83ms3q1IUjSu1X1IhA0dRy40TARz1jw6dEz8dlURBOl4TnMwL3V
	xMcKHKpMieAU41T+mxTfTRaVTjxwfkwBQfH7lJfy5bDFTCQgs0UzR8zwj+W4ndvAqmGUCHEAdUi
	6337o06zodMzyrBhSI8CC1PCbk5R9SkqNs/YuFnPlPE+ImTNaPWX7nJTgBZ6vdgim2Jgg/HV4Uk
	k5n2HpfUp0DeQXdj4V/IdjAGlARCjfIWPun/s5ciJWGSkqaXMio35nqsINwqyx3iokkmJ3LHuXw
	=
X-Google-Smtp-Source: AGHT+IGnCsLhz0tXjXWgJPa4tUw3jNt7+N5mm0iG4mYphBKwEcq5JJJ7QzwtRzXtnNd83zLEtS3HgQ==
X-Received: by 2002:a17:902:e1cd:b0:22e:4cab:f786 with SMTP id d9443c01a7336-22e4cabfa3bmr14133865ad.18.1746547187571;
        Tue, 06 May 2025 08:59:47 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e152321cfsm75114285ad.244.2025.05.06.08.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 08:59:47 -0700 (PDT)
Subject: [net PATCH v2 2/8] fbnic: Gate AXI read/write enabling on FW mailbox
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Date: Tue, 06 May 2025 08:59:46 -0700
Message-ID: 
 <174654718623.499179.7445197308109347982.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <174654659243.499179.11194817277075480209.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <174654659243.499179.11194817277075480209.stgit@ahduyck-xeon-server.home.arpa>
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
Reviewed-by: Simon Horman <horms@kernel.org>
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



