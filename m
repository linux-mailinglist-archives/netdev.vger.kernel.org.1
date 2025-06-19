Return-Path: <netdev+bounces-199414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DECAE02FC
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 12:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF3681BC423C
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 10:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD11224B1A;
	Thu, 19 Jun 2025 10:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNQmYQyb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE3B18EFD4;
	Thu, 19 Jun 2025 10:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750330669; cv=none; b=Q4JktPt23wrFbgqNvnvSJXeMEbXUXjqO+W3BGDUsNX13ok71koDPrXWi0Ay6W1EHQ2Z6z8GO3F1PXSpsLvc945IdmNJiMt8drikJNze2k6ZaCUjhXGnNIlg4m3Ohf+EdFElUONR7vm8agJ8nTGpnH27g17KIAWsvcyClH7JuNmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750330669; c=relaxed/simple;
	bh=j5rhOpW/laBF82M2HY8CKc0EfimQr1NJoDaoSLw2njw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k6/Kl5vTZQR220MlnA7SQiiWwKyEs1Vh5iG4Hf7CrFO1uNBIepNwN5V31DI4egql5jqWjmN9SB1goDzNZhkZbkbbZtZ+eBFi4yjn94EC4mqqeh/5IvPArhMaEOwwgAqhUv0enB+uu8FqiLmsTd7LTnTd0YU7VgmQRLkMxHB/lSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TNQmYQyb; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a52878d37aso114282f8f.2;
        Thu, 19 Jun 2025 03:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750330665; x=1750935465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vmK1bvc5vh/SERc7Pq049o40EvKsXEw1iFHeTVG0Glo=;
        b=TNQmYQybRYVtKIufCYFqLc1L6jDz8fkZwFcCMlkmufg23X3s6YFC7zXkTXlu+OgZwx
         YRoRERfIFkdOfihLE8GFIILyMvVzm1a7AUToteBF+0eKmdZXf1EkV0zzzabIwfUFbV6i
         UVNfibkczDNoYZSuKqMwGbCgxT3z81su7LhbmKckxRcNy9dDIPSwLGUW9xDyRnA4eS8n
         8S83pycTNLdARgdqT56aZRBSEZ2051xJhRlX5PnNjqgHMb++uD9XMSnwBXlbtoKjnf80
         bfo2j/eRp+MkhGptFReO8GI+GkMxjSNX0N79F2gF05wsuWABZ5j1eDAclNNPUTG9nWI9
         7a4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750330665; x=1750935465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vmK1bvc5vh/SERc7Pq049o40EvKsXEw1iFHeTVG0Glo=;
        b=ayLgMqRn++MsR+o+bdMvV5peUuzVdmPiOtDlrruJHgqWne61lGbKQDSm7v7Uwf37Qb
         XQa4VbIMwpgn6mfzpPC+wbbObKfHNvks4vY25xErlmQV/Tti01TmvsjZwrT9rVTiRRSq
         Qo/sjQqeQ99+bycby0+0wmyZVeu3uZ+kyyC+pDWAgeoSqE/qYDNX8wkLZX519lzYXFUx
         i7Y9xi3JpWpWFdi757ejudEIthociRPvh50lckrfx6uf166S8G9Tew6JiGwtScLt0e1E
         zDRu+0gz7nNGPEZMcSbSrwlncGXI4y3zQJNmEl1G/A0c8ZFvl/MilmnFPyBsdOWJ2Afv
         KQcg==
X-Forwarded-Encrypted: i=1; AJvYcCVOFjLpi4GsQa4/DP3JuTcJfbOisj+PCjCy9p/3Lf6t6ORVAOyhR9qP7EalMz87FKZVpApaNv1O@vger.kernel.org, AJvYcCWaK4a6M8Ur7Q4+ISOWUhQ2fryGuTFy4OJVPPst038RQy97AuT8djj0u/wOQbZAXlB7/eFN7nOn/7jw1fs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywocu8oxCSjhkRMD1vjrXazPR+b+BzmXJ4LgudvIfPZW/c51JAR
	PImFfahILWoGEEwIdw/hDuggzMBbOdU7KVd/8UUOo/L5kQXB3LitAiq8
X-Gm-Gg: ASbGncswtxpF/9oO2M6X41mxgn3huY76SpdW4OZp6/pqilp8dCV17NAULNx3s9EKRlT
	lvkK5XwNRUIbGUvwubeDCKzFL7r8CUj839AnSxOnxoGcPT3+i2wccCar3uXYCRVNyWm6B72vKmK
	Fp83IvfQCy9vZLRV31UJ3J5zy9dSoFc0nYRfNGaOFYfQ5zn6xCm2rjqMWDiuiLeHqRCS6JD513s
	0cHg+DTtKiWd2YjQP3qNVg4yy3NZD8shwOC0NVNFxmhxP1eeNoeu1aluQUpALaJwgC/UONvVb5d
	GmdjRle2EPrE4DZkcZhKH1hOCLpJUK3Z35cPQAKMTEF+sqWNOJZdNSkK2BnKjwV8SEiQmE1AcK+
	ETf/e0juwmyiiJ77ym/aYux7BHEncKsNEbJMO670Nta4z75J6KnQWTHTmyYjLkhAznK8ozqSong
	I=
X-Google-Smtp-Source: AGHT+IHhNR1Vyub4RCtWQ+nJC19r77hWU+mF/WXIXr/eAXq/yPW7ddIq3+qyBkxmJsRa7SaB+3K/mA==
X-Received: by 2002:a5d:64e7:0:b0:3a4:dc42:a09e with SMTP id ffacd0b85a97d-3a6c98ee80dmr880624f8f.5.1750330665314;
        Thu, 19 Jun 2025 03:57:45 -0700 (PDT)
Received: from thomas-precision3591.home (2a01cb00014ec3008c7e3874bfd786a1.ipv6.abo.wanadoo.fr. [2a01:cb00:14e:c300:8c7e:3874:bfd7:86a1])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4535eac8bb6sm25078625e9.25.2025.06.19.03.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 03:57:45 -0700 (PDT)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Chas Williams <3chas3@gmail.com>,
	linux-atm-general@lists.sourceforge.net (moderated list:ATM),
	netdev@vger.kernel.org (open list:ATM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] atm: idt77252: Add missing `dma_map_error()`
Date: Thu, 19 Jun 2025 12:57:06 +0200
Message-ID: <20250619105707.320393-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DMA map functions can fail and should be tested for errors.

Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/atm/idt77252.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/atm/idt77252.c b/drivers/atm/idt77252.c
index 1206ab764ba9..4217586a82d6 100644
--- a/drivers/atm/idt77252.c
+++ b/drivers/atm/idt77252.c
@@ -852,6 +852,8 @@ queue_skb(struct idt77252_dev *card, struct vc_map *vc,
 
 	IDT77252_PRV_PADDR(skb) = dma_map_single(&card->pcidev->dev, skb->data,
 						 skb->len, DMA_TO_DEVICE);
+	if (dma_mapping_error(&card->pcidev->dev, IDT77252_PRV_PADDR(skb)))
+		return -ENOMEM;
 
 	error = -EINVAL;
 
@@ -1857,6 +1859,8 @@ add_rx_skb(struct idt77252_dev *card, int queue,
 		paddr = dma_map_single(&card->pcidev->dev, skb->data,
 				       skb_end_pointer(skb) - skb->data,
 				       DMA_FROM_DEVICE);
+		if (dma_mapping_error(&card->pcidev->dev, paddr))
+			goto outfree;
 		IDT77252_PRV_PADDR(skb) = paddr;
 
 		if (push_rx_skb(card, skb, queue)) {
-- 
2.43.0


