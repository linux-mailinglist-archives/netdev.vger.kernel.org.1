Return-Path: <netdev+bounces-159562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C41DAA15D0F
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 14:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E465E7A352A
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 12:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C8B18893C;
	Sat, 18 Jan 2025 13:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDJJDhHY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5D8194A65;
	Sat, 18 Jan 2025 12:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737205200; cv=none; b=tLoGekkEnfqHhUn7GDxa6GynedlZ5uWfHJ7n/MtaqsSLhA2uFApBN77Ptd4PtR9QZcnHXdFH4zg2LmZ6yw9hUE84fHYmoSIDo8xcs+V0A12/ksudnaSeYUnRssHbkplOw2oZpHsPjZ7qnuq8qU75YJ/LLCXLOUomMopSeicC678=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737205200; c=relaxed/simple;
	bh=7Ds/AB65ztB9QuAavFN79YiSgvPDbfRibJI5Zw5XaJU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oW2a9SPveFfcCwOxMbciQaDZfFTyUgLtcbgpXvTVsfqnk9krLQvUuzTlRKwBxhQptI4ZXTnpKn6sC0QRqf1AKSyt95b2HcE5O/AnmP8JsN5U54OFrDxWKN1pDehQBNLmTlb+fmoQm+HA0NOfJvxU2q86DEMhr/YC9DEReBxyBNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UDJJDhHY; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2164b1f05caso57707505ad.3;
        Sat, 18 Jan 2025 04:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737205198; x=1737809998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wkHM0UCI1WBkqufXXmJcj9rLCEup3Pv0OZjQv5gTB/0=;
        b=UDJJDhHY1dmAudq2fxNvoz4HRq1NBmCY6YAOBAkShbv2jBHyHr7lGv+0qpEBHw+YJJ
         gKfrLYEx4e1UpHAA49tToCWOn7pA3bzUlLZdyVia5LY9CUj2y0tjUw4EEzW4ww7oHZ4Y
         i37RMVWiRueWXi/JIGiAXhv6AzFeQOzdDZVOefD06Qos8nZ3NbzUV7ET0/cp+07rsJuj
         xOCvlE/JhPUz9oc15iz8HFoCyDtSE/vXb7ITugZio5sEMiiICpDXD1iSLYXw9+s7mBcl
         loKln6h9jun2J0lZ4b2Vc1kjjONWkF/oxoBIGyxgW7R/zuDl+tga1Vr+GtXsfBwzoRRh
         CtNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737205198; x=1737809998;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wkHM0UCI1WBkqufXXmJcj9rLCEup3Pv0OZjQv5gTB/0=;
        b=OXojk1saq8Vj37rJBoTYR49L/xuqSRrHI8gmYIo6im4WZs7LYWt3ANe0J2NccMnn/t
         IcaG3Cn9nP3OgbluQgSCKeZw1f0l77OaPLfJmx2aO2cSBAfxQzhLHxtT0a3OPookZdK7
         FHZfJOCia+8oXsRnktQNj9LGQOu7wWUnVcWUoLyWzZsyF2gFOKcjMeQoQjKvW1KPKi36
         97p1aUein+oKKjre9ibmgymnVgl3AmLhsNKA4jwCMWUN6BqZvIvfZ8iiu2Lc4GLI7bWc
         a4xLTmuZLfrZaovqqR1rAsNKtjfXYTlno/gEKT+GnGUAJgl+0+FYmocNObV89TXq+QH8
         I3lg==
X-Forwarded-Encrypted: i=1; AJvYcCV33q08oKMOpByi8UyQU4MkbuPvMZA5xw5RZfvddgEzElYQL9MOrlzBygjms+4t4nq3SrSHCJZfyuF/m9E=@vger.kernel.org, AJvYcCVINpqu6PzGEfK8IOB1EP0BGUSBwwR1rjQ+4ndUWA6T2iMsgBzXOK9xjfPM/jh4bIeaD4nS5Icr@vger.kernel.org
X-Gm-Message-State: AOJu0YxhDtJrZOPOcxW0ErrGv6jAw7V12DJQmtyzV/Vgxl9WneW6aNX6
	+xSuSZ11IHN5tcvMN6lN7DyFaBaWUvqpPpHaG57p1xP1oHKuPIOk
X-Gm-Gg: ASbGncul9srKz+ONJictaATpyQ007oh6X9a7hS8JJ8qmo29TeF0Gx+hWWIu7jStObu/
	eYkUqCicaj4Kn5gY1Ss5JzRtPyRhYDSt6L1XNy72LLhdvIx58I+NHFqFJLaCa7fQvTkx3emrQq4
	uKk8kcI81kXAGYl7glqybCeIFsydQ0tDitq+PmdgZHFjyydAGNenCs67S/Jl5FgMYbr8Y0bglb3
	qb71uGNdiwLiAz4lTOZXyZtiG7MCDBZ7Se6J/g2771QJ3nAuHKi3M+91RX1yG5c/bWZ5SkPMA==
X-Google-Smtp-Source: AGHT+IFIGARkaMBlFuzV4VNvag2krQYyWbVBGYYyK7DMvxVgbCKL1dMuvkos15ubTl8+3FBFOuVLbg==
X-Received: by 2002:a17:903:320e:b0:217:9172:2ce1 with SMTP id d9443c01a7336-21c35544407mr96895095ad.22.1737205197864;
        Sat, 18 Jan 2025 04:59:57 -0800 (PST)
Received: from HOME-PC ([223.185.135.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d43252bsm31067135ad.258.2025.01.18.04.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2025 04:59:57 -0800 (PST)
From: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
To: wei.fang@nxp.com,
	shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
Subject: [PATCH v2 net-next] net: fec: implement TSO descriptor cleanup
Date: Sat, 18 Jan 2025 18:29:52 +0530
Message-Id: <20250118125952.57616-1-dheeraj.linuxdev@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement cleanup of descriptors in the TSO error path of
fec_enet_txq_submit_tso(). The cleanup

- Unmaps DMA buffers for data descriptors skipping TSO header
- Clears all buffer descriptors
- Handles extended descriptors by clearing cbd_esc when enabled

Signed-off-by: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
---
Changelog:

v2
	- Add DMA unmapping for data descriptors
	- Handle extended descriptor (bufdesc_ex) cleanup
	- Move variable declarations to function scope

 drivers/net/ethernet/freescale/fec_main.c | 29 ++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 68725506a095..acd381710f87 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -840,6 +840,8 @@ static int fec_enet_txq_submit_tso(struct fec_enet_priv_tx_q *txq,
 	struct fec_enet_private *fep = netdev_priv(ndev);
 	int hdr_len, total_len, data_left;
 	struct bufdesc *bdp = txq->bd.cur;
+	struct bufdesc *tmp_bdp;
+	struct bufdesc_ex *ebdp;
 	struct tso_t tso;
 	unsigned int index = 0;
 	int ret;
@@ -913,7 +915,32 @@ static int fec_enet_txq_submit_tso(struct fec_enet_priv_tx_q *txq,
 	return 0;
 
 err_release:
-	/* TODO: Release all used data descriptors for TSO */
+	/* Release all used data descriptors for TSO */
+	tmp_bdp = txq->bd.cur;
+
+	while (tmp_bdp != bdp) {
+		/* Unmap data buffers */
+		if (tmp_bdp->cbd_bufaddr && tmp_bdp != txq->bd.cur)
+			dma_unmap_single(&fep->pdev->dev,
+					 tmp_bdp->cbd_bufaddr,
+					 tmp_bdp->cbd_datlen,
+					 DMA_TO_DEVICE);
+
+		/* Clear standard buffer descriptor fields */
+		tmp_bdp->cbd_sc = 0;
+		tmp_bdp->cbd_datlen = 0;
+		tmp_bdp->cbd_bufaddr = 0;
+
+		/* Handle extended descriptor if enabled */
+		if (fep->bufdesc_ex) {
+			ebdp = (struct bufdesc_ex *)tmp_bdp;
+			ebdp->cbd_esc = 0;
+		}
+
+		tmp_bdp = fec_enet_get_nextdesc(tmp_bdp, &txq->bd);
+	}
+
+	dev_kfree_skb_any(skb);
 	return ret;
 }
 
-- 
2.34.1


