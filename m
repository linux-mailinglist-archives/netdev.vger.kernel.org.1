Return-Path: <netdev+bounces-203222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A9DAF0D2E
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 09:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 296351763DB
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 07:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9EF21CC40;
	Wed,  2 Jul 2025 07:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uf3qTihf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58DD1D63F0;
	Wed,  2 Jul 2025 07:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751442750; cv=none; b=LNzjViw5jVWbd1tpyx3w8gHEuLQnopWd/UZt/yzfBZN6mD4SYLeCCgFepYvXHkwzr67jXLyRmjIhIkp7LIVkwbdrga3uF7Z4iUCJLlAbRhrPIjzhXQX1obH5VZV2ijx+Tk7GLJb12QhiFDZytxFK5dufYlBTUtVXA/Xpb6o8C+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751442750; c=relaxed/simple;
	bh=psC4EIcRFAA6nXCkfRSfcP/9nJC3Ic+ED7YumMPPN0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iQb4V3UtM1YN7wM15n7PEeH8nW2IosGGyo1EF+/rPcKdS39oeE3YD21yTEGr1AR1YhGlp9ucGCemZPlB11JuOKDwT3ukJAuqCcvHLpDDwRBVm79ez5MZg32/YzH+T+6P5dZrI3uWAiHkpofJxKvzwej29r4P2twHuMtsvO9gGFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uf3qTihf; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b20fcbaf3aso56230f8f.0;
        Wed, 02 Jul 2025 00:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751442747; x=1752047547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eZekfSyAqtX7ay8LYeSzU2qV2gsXWRfo6lTGO3aiPrE=;
        b=Uf3qTihf8z9yZockwNv/tA+1Mz7rVBr9TxsAw/o8JhSaZmpi5x/gHJ7qDpgsAvrY5d
         7bvp7WShNX1PQC+JCKnbtBYCVih1m1NG09Gq2XJZFWVtJnH3neS06NsoQp60UE0Hu0xO
         n8/qIEohUuxY4DVBtWqsBoWRKBdJ4O4kMQ6kPSrJS9oeNk9rW0/HEzUX7GBZkpo4ikId
         YENS0TxNi6GIECR9DfFqbBlzvkc5m/7eIF4KNf5Yo9XhxLK73RYp5GDVhskNqT37/BDY
         D/Zxkp5EAuCJBDWCZp6GY0FIPg9eodnKdbJ50QjmBvpQj8Ieu5fwfeGF+8Y7We0T+Hgy
         49Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751442747; x=1752047547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eZekfSyAqtX7ay8LYeSzU2qV2gsXWRfo6lTGO3aiPrE=;
        b=i8gN6hkZxfCTM3r7K0NNksiX5QN31FNgOmb12alf4ekGnPptd952BZvOYvPq3kSbQ8
         2rTXo4xR+UvyOhWGMgz5Y8thSHYpl/qI7eTGUszt/i7rUDiLxWjw44xMpVgVpaguwQBR
         vaW1VvcwTpiFEynAizLu5LX6Y//HfVMwFfQABoyDxrGtbXm2WcvW0ENsQWVQIXO8K+2T
         5Qk5PNYXqN7GGR74E4XsptEVN9Z8OpfLVjalTYUmZMBXexcjnwYFk8ta9JN2W7Vyc5NX
         wuNC+YukgJhW9Tmi+ULIA+wZuJgnhudyL4W85+gc2/TjPw5JEfQT4OnlQfeVMIYgt01W
         nKMw==
X-Forwarded-Encrypted: i=1; AJvYcCUiZNxGQ5Jc3ogcxTrnAUbnuYAvu4PcmZdeyvJKKUJFkxEtaVXKEqXwn6pKW93tKZmahe65lelYlMeCUTM=@vger.kernel.org, AJvYcCXNbYInR4mCq0diAgFk7DV6tsS3h3nAfxTH6se/VNbZUshjdLejdKtSnxb85BNCOo3uc7sYf7Ka@vger.kernel.org
X-Gm-Message-State: AOJu0YyMmBxyi41zwGg9TLKy/po0C0k3iJLnAHj0PRJJOsdl1j9TVP5V
	3tC2HDCSzg6OUg9L53rRz+eQ/8eiqi4K9g+kGqCnadqLYkKeEB0KVaLX
X-Gm-Gg: ASbGncsJd+Xqt4gMJiVtun0mnPPTznCbWeWAm9IOcNVTupWqBQPUF/QtBcs35y4nX0T
	NXZK6Cx+dqzlUtFQO9lWHe5VEBJi1gXHN5o3dKCLQDT/CH68SPhHS2Tso7wPK3buo5eUG2XA89a
	pl8IBe4yMCysr6H2wSXfSiPBfzsewmpGwAcLNC7IUtmiAZyH2YigpOGatf+JxgK5wTd4aBGMy8q
	wP5Gz46ULcZ+MIvqGZnsXOhV9i+XN2+/VCoNikz2pgx3CoQCEUDk5JTiI8hhtaxKOzZqi4Uw81e
	bistqS/ACrEqalyU3Cs67WbZW1M6OTsIyMUCIGdIORVpfes63a+MFuemtF+wtE0tNcvHwvXaNeL
	8rAV4OIa31HkITmtFbFhtBOgAPMLGcuHt
X-Google-Smtp-Source: AGHT+IHtpOODdNjCttcGEwAR/ZOVtqTOG2M4YBetjV1pmZw+7+K6bzUcgHkJ0WZIOMLzC9g7ohrktw==
X-Received: by 2002:adf:ec52:0:b0:3a4:e0ad:9aa5 with SMTP id ffacd0b85a97d-3b1fd26862cmr323703f8f.11.1751442747049;
        Wed, 02 Jul 2025 00:52:27 -0700 (PDT)
Received: from thomas-precision3591.. (eduroam-109159.grenet.fr. [130.190.109.159])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a88c7e6f74sm15321418f8f.3.2025.07.02.00.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 00:52:26 -0700 (PDT)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Chris Snook <chris.snook@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: ag71xx: Add missing check after DMA map
Date: Wed,  2 Jul 2025 09:50:46 +0200
Message-ID: <20250702075048.40677-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DMA map functions can fail and should be tested for errors.

Fixes: d51b6ce441d3 ("net: ethernet: add ag71xx driver")
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/net/ethernet/atheros/ag71xx.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
index d8e6f23e1432..0e68ab225e0a 100644
--- a/drivers/net/ethernet/atheros/ag71xx.c
+++ b/drivers/net/ethernet/atheros/ag71xx.c
@@ -1198,7 +1198,8 @@ static int ag71xx_buffer_size(struct ag71xx *ag)
 
 static bool ag71xx_fill_rx_buf(struct ag71xx *ag, struct ag71xx_buf *buf,
 			       int offset,
-			       void *(*alloc)(unsigned int size))
+			       void *(*alloc)(unsigned int size),
+			       void (*free)(void *))
 {
 	struct ag71xx_ring *ring = &ag->rx_ring;
 	struct ag71xx_desc *desc;
@@ -1213,6 +1214,11 @@ static bool ag71xx_fill_rx_buf(struct ag71xx *ag, struct ag71xx_buf *buf,
 	buf->rx.rx_buf = data;
 	buf->rx.dma_addr = dma_map_single(&ag->pdev->dev, data, ag->rx_buf_size,
 					  DMA_FROM_DEVICE);
+	if (dma_mapping_error(&ag->pdev->dev, buf->rx.dma_addr)) {
+		free(data);
+		buf->rx.rx_buf = NULL;
+		return false;
+	}
 	desc->data = (u32)buf->rx.dma_addr + offset;
 	return true;
 }
@@ -1241,7 +1247,7 @@ static int ag71xx_ring_rx_init(struct ag71xx *ag)
 		struct ag71xx_desc *desc = ag71xx_ring_desc(ring, i);
 
 		if (!ag71xx_fill_rx_buf(ag, &ring->buf[i], ag->rx_buf_offset,
-					netdev_alloc_frag)) {
+					netdev_alloc_frag, skb_free_frag)) {
 			ret = -ENOMEM;
 			break;
 		}
@@ -1275,7 +1281,7 @@ static int ag71xx_ring_rx_refill(struct ag71xx *ag)
 
 		if (!ring->buf[i].rx.rx_buf &&
 		    !ag71xx_fill_rx_buf(ag, &ring->buf[i], offset,
-					napi_alloc_frag))
+					napi_alloc_frag, skb_free_frag))
 			break;
 
 		desc->ctrl = DESC_EMPTY;
@@ -1511,6 +1517,10 @@ static netdev_tx_t ag71xx_hard_start_xmit(struct sk_buff *skb,
 
 	dma_addr = dma_map_single(&ag->pdev->dev, skb->data, skb->len,
 				  DMA_TO_DEVICE);
+	if (dma_mapping_error(&ag->pdev->dev, dma_addr)) {
+		netif_dbg(ag, tx_err, ndev, "DMA mapping error\n");
+		goto err_drop;
+	}
 
 	i = ring->curr & ring_mask;
 	desc = ag71xx_ring_desc(ring, i);
-- 
2.43.0


