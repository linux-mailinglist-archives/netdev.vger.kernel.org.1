Return-Path: <netdev+bounces-159682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F12A1660C
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 05:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 303023A357D
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 04:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A091487D5;
	Mon, 20 Jan 2025 04:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfiemEm9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E915A36D;
	Mon, 20 Jan 2025 04:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737347192; cv=none; b=cDNf8TcRuiE1eYN2EsPBneV7K3eGohX6a3XpBl/grivzYpfCJGlGuec+q5QZyvEuC0BbGyE5hBjcqwlSIrW97/Wx3B9Oy40nF6gTGCd0PuzyrR0LlMp2u/H4CakzKVJQh3e1LFZF0mskIDrv4QKukA7KW18ztcZB34zQh5ffMi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737347192; c=relaxed/simple;
	bh=YUV/kZlqp7x5oBoGxQBRhNwBZgCb/VkEHX5Q4FFN+Uc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UD3gSCVUX9niW2brD8c9BcwEOwtN6vtKQE8HkprIlQ1uUHXtMaVPata4C48ceV/4YdtHLyDyLwkQ2dw+uMkE/IKfQKJT2vbUjAD43i0n2YA5OcrkWKWcWWplvTbWGzdvsnj58y0D9joqYtV9z1y1aZmnSntShW1KTeVqnHIRE5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mfiemEm9; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-216426b0865so68653985ad.0;
        Sun, 19 Jan 2025 20:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737347190; x=1737951990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b5FC5Qqw1jL3v7FrQx+Z2e4fqL2PltW+m+8hWqQHPpg=;
        b=mfiemEm9NxgeoRdQulh+en3EZzpB0K3LOnIMTnGgfX02q7t+MaJfHqNTge6P+KYVtE
         Zb8MZ2NC1Q04iB4+bNbPa6FbRQpIbpX8WENIGfcOE3zh+KA+Tj4f3CD8EoPaMUrZX810
         Yqxm9ukMHhVY146AdwqvqNrAljUMLv/f6U3ZOuUiVY8R3mANpqi6DiyciPo+2exe3t3z
         rOwLs8bsKguWDr/Frxp/x3Yrxd7nCsohTdjpQGAdlJaqb4ItuAcVi/SL5/HNlx70aFcs
         8gfkTPU3KO4Wi4uqH4YTsAGb5Enzn8F+cBqTC5PQ8A6zOLvz6KgxtI10xxvACqGZOMhN
         KLYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737347190; x=1737951990;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b5FC5Qqw1jL3v7FrQx+Z2e4fqL2PltW+m+8hWqQHPpg=;
        b=SjE471M70a7cOAxebB8fsgewsnrwtik9BRWFQlP50LsX4Iim7ldm6vbUJpPRkDfxPX
         Fy9G/lxaWwcmGPvVWmWutRKCZBPTkYW9RfzNt+Rsx/1GM7C+OtegKsAW1R50PIfh7StY
         zGOpxi69RDsBk/jRnkQDD4FbYhYa8Ka0GiQvWlBSytuJfEHRp2BsX+Ar79kklaC8MbAN
         1H5c6lbVFONxq7/kIV8uMexhm2mItskhJjzQ49pLImOajKPgbS3mqa2CQoAqb71FyhXG
         2RliPZB+F5DmNeMZIG29DXAOTeJfGMgenp2AW6OP5qcd6poGj1hLFf6YieoARAADQwAe
         GRbA==
X-Forwarded-Encrypted: i=1; AJvYcCUjhjL8FoYBZFTx2yOfaOdWfenTFtOD4melP6ru+Hx22ZgsYdytKRHkAJEbgmX5wk5ZbSl9jvfn@vger.kernel.org, AJvYcCXhoZW8iFT0HV/p0Cj8IOdu1GVOAx5rRA2ZVV29hOZ5fwULu3vkyXv1ySBaDfAtN3V9R31AV8aLsMYeVf8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg0kSN8qR6qBDQapqG1YUAXwN3iCiFViLJhF1//ggMi6Dfq+J6
	XIMjgvzv4GCbh0UPneS8ZE05AGK5MQ8eOCsd7ejTuXPsXHUd1IAL
X-Gm-Gg: ASbGnctCaFxMunKZ0rh3e02zHa/ZwskE/ylJUBtY17V4H+1GNcnnuTKFftnRMDFUqly
	FdkeOxIzc1AZMu0iS8o6sQ1fvwrnCqmxRxJY7m24qPyJHc9hEgocRGSX8tybqZM6sK4QJ0GwZFA
	ue7i7GZ8Fp7ZU6LcN81bC6arbGezGrVFAsxfFtNvoVo5Ds6huGHpwBSp1fSKFLXnQ5cbwCplwMR
	h0+8iYGuQ0PCrSjP9MuRMbCSNFmedD26tawrcMBkvbINAEzzYJId5XVS3X4L3vbDR+31zNrzA==
X-Google-Smtp-Source: AGHT+IFreBXW8qMfUZdbH38vaaqKKX3QrsSBIPF8z1VO+RAxIh9FlcywQ5RZy5gYFYZfHzAMqolr0A==
X-Received: by 2002:a05:6a20:3d86:b0:1e0:9cc2:84b1 with SMTP id adf61e73a8af0-1eb2158d07amr20098664637.30.1737347190100;
        Sun, 19 Jan 2025 20:26:30 -0800 (PST)
Received: from HOME-PC ([223.185.135.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dabaa751asm5971652b3a.162.2025.01.19.20.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2025 20:26:29 -0800 (PST)
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
Subject: [PATCH v3 net] net: fec: implement TSO descriptor cleanup
Date: Mon, 20 Jan 2025 09:56:24 +0530
Message-Id: <20250120042624.76140-1-dheeraj.linuxdev@gmail.com>
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

Fixes: 79f339125ea3 ("net: fec: Add software TSO support")
Signed-off-by: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
---
Changelog:
v3
	- Update DMA unmapping logic to skip all TSO headers
	- Use proper endianness conversion for DMA unmapping
v2
        - Add DMA unmapping for data descriptors
        - Handle extended descriptor (bufdesc_ex) cleanup
        - Move variable declarations to function scope

 drivers/net/ethernet/freescale/fec_main.c | 30 ++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 68725506a095..9ac407d30e85 100644
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
@@ -913,7 +915,33 @@ static int fec_enet_txq_submit_tso(struct fec_enet_priv_tx_q *txq,
 	return 0;
 
 err_release:
-	/* TODO: Release all used data descriptors for TSO */
+	/* Release all used data descriptors for TSO */
+	tmp_bdp = txq->bd.cur;
+
+	while (tmp_bdp != bdp) {
+		/* Unmap data buffers */
+		if (tmp_bdp->cbd_bufaddr &&
+		    !IS_TSO_HEADER(txq, fec32_to_cpu(tmp_bdp->cbd_bufaddr)))
+			dma_unmap_single(&fep->pdev->dev,
+					 fec32_to_cpu(tmp_bdp->cbd_bufaddr),
+					 fec16_to_cpu(tmp_bdp->cbd_datlen),
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


