Return-Path: <netdev+bounces-159700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA72CA16879
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 09:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E88218866C8
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 08:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD58196DB1;
	Mon, 20 Jan 2025 08:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYbhHxHs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96090149DF0;
	Mon, 20 Jan 2025 08:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737363277; cv=none; b=VSDxYOJOD20DPnXYEFz+cs4oB8IQmI6lRwqYgo2XBkQmH/YBfq6YAVoR6Sr97pOQpHgiM/fgDVBUnPf5+w2yFBF/YGwiYocY6eQ58flTNX6MFoXWkssj+0oPl5Wc4flMrF5BYg6dTzycYrgU8w4eIVicdTAcRFVofTG/7ZkQQXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737363277; c=relaxed/simple;
	bh=ITRStiQHXvmZSkeU6QkY+Un384bN2CWEtLkFd5X62jM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R2CvfLZLaSqP8ZlBUCvfY8HOcV0nKoaefpHOVuz6ZwLFBurElBwYhNQW7FDxAE+maAE8VIHcnW0whkfJnUBzD8xAmYgkIiZD2KK9Q3ohoOCpQudb/r8aNLlL/m4uqX233e+w9UEAcN9g/w+DDRXugG6FmJ9IGB7U8NtiiEhc2zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BYbhHxHs; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-219f8263ae0so74231785ad.0;
        Mon, 20 Jan 2025 00:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737363275; x=1737968075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6gzGw0TGSeLlBT+PXh+TmInRomUcMmT6P6MAXrdk0NE=;
        b=BYbhHxHsCJPSXuuogMpGsw6b6FA6tH2qanfbp7vvLSelcIBaSelzzUbZH2PqcE0IUT
         wGU3UpoZpYbwPb04Ne0/qlbJ2AaWFDJiyj5Ne8tMgI+Ch9wvCl8msmTg0OWfwXjb+yub
         cHKnMc3sS3CkIyt9szC4+LUZd61qFdICdtvLxPJbv4h0kf7B97Pk7C2BGrcTSdHeMkTl
         aFw2YnGwmhy+1tZfSuPG0aJNTJpzQtLlK6k2y99EAWHqWitHtOL6OXTwKQCJw3Q+dO3d
         LdtgB7OL4PmMY0jImEGCw1fSOsx8Bwiy2e2IdPyl9wGuuuEL2LcX7F8X4nTzYAt8wjAv
         aG+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737363275; x=1737968075;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6gzGw0TGSeLlBT+PXh+TmInRomUcMmT6P6MAXrdk0NE=;
        b=IgcQ45evIB8wyQZ/H39gOYOKFFjvCs3YJjChXPuw8lZulzefBvkjsi6cwamc9lh/JB
         7WZp+OI4fTcvjpf/fDii3wNmr34BHF7G6qb7kqgzsFAJkejPSv/ERvOW/QwVBfCLekuZ
         6PkpPNo/jHRRd6DL19tkA++wabWFLq2xVtJiz/DoDhAUDXOMdb8ig0b6cTRtX3DN8B9Q
         ZArKuMzFF1ZsOtDsjUqik0Ly4V3ArI1EMXOnhtv222N6W/VvTGS3natoDdwANi/vNm82
         IuLviNXuGcODuoYZK9n9UG5eEMuZw5ycxbySfXVIiw6C2lIOgeJkddfZV+Bip3mAjkIr
         SVQg==
X-Forwarded-Encrypted: i=1; AJvYcCUCoQUq5B9Ov0ylEVGF9cRMP6NQy0FQdY5eYLc6zevqy/QEj6TOTwrV7KwfjeCbsj5ekd1G9xO8@vger.kernel.org, AJvYcCVFUK9ih7mWfXxx9f3tbye4LqtUfh3O/dw8HztPaK/wlFtN519spG+01CWtW3LKYQ2kn2z4dNzutgHZ+d0=@vger.kernel.org
X-Gm-Message-State: AOJu0YymcEQRm85OH18GE2GJcjC5PHOQKBWV9lJd5AoFghqdRFEeWzpj
	+W2ehkreubEcClTXNHCb+gds84ZEVlB2/8MNGCo85m57SWaPqEK1
X-Gm-Gg: ASbGncu8WPpWvOBrDWL9p62qG1gIFhMfIby65nvCvbNHNuIsZab1jAsWJogIBgUiBgp
	8UaQ5D2Am30E893hUxQueh/LP/TygM32FXhjGLA786tP/Y1s9dFvsBu93BWFBu+alGTgcg7Z9VD
	0F/Tqj6ZJisMq8fbK6pmHd5/6ir57BjSAoH7o2Wg5nW8jw6ibeijtG08Zk7Se94PPBgBGXq6XAA
	lPZ00Xq9OVeEanEFmcNyaVOUUtKbuO6wyqfa9MY+ZtmH3lXtGZ1XF8AmDo71ykLUxCP2s+c4w==
X-Google-Smtp-Source: AGHT+IG1Ikwlf8hT9+rwA9+g+Ks4MwShL+e4FuTQhDR/yhQyIgu0oKyJOv++HVvQBmKvMMVognNZew==
X-Received: by 2002:a17:902:d2cd:b0:216:5556:8b46 with SMTP id d9443c01a7336-21c3562998bmr173720355ad.49.1737363274809;
        Mon, 20 Jan 2025 00:54:34 -0800 (PST)
Received: from HOME-PC ([223.185.135.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d3ac64csm57075545ad.149.2025.01.20.00.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 00:54:34 -0800 (PST)
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
Subject: [PATCH v4 net] net: fec: implement TSO descriptor cleanup
Date: Mon, 20 Jan 2025 14:24:30 +0530
Message-Id: <20250120085430.99318-1-dheeraj.linuxdev@gmail.com>
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
v4
	- Add a blank line before return
v3
        - Update DMA unmapping logic to skip all TSO headers
        - Use proper endianness conversion for DMA unmapping
v2
        - Add DMA unmapping for data descriptors
        - Handle extended descriptor (bufdesc_ex) cleanup
        - Move variable declarations to function scope
 drivers/net/ethernet/freescale/fec_main.c | 31 ++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 68725506a095..f7c4ce8e9a26 100644
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
@@ -913,7 +915,34 @@ static int fec_enet_txq_submit_tso(struct fec_enet_priv_tx_q *txq,
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
+
 	return ret;
 }
 
-- 
2.34.1


