Return-Path: <netdev+bounces-222859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E41B56B3E
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 20:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F536188B4A8
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 18:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3012DEA97;
	Sun, 14 Sep 2025 18:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9w61XOr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE35D2DE70A
	for <netdev@vger.kernel.org>; Sun, 14 Sep 2025 18:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757874702; cv=none; b=MqqOKlwBbtVUOmhM2ir7OonS5KvoHm12t+rWRb3LXNrZ3UsGNpGocVgDcMy3UWr4TPFjioBNHQxeSR/XBe+9zCmFgvx5FPlqUncrWR9mtKoIHkaNU3pjvQZUHLusZIj05M+ywHsrYkYXqrKL1cCtVAc954kiu++gs40YSgrvJkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757874702; c=relaxed/simple;
	bh=7n4l+yd/t9dYFJyNm3d1lZn7lll+HFRskxQ0eebhwSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sfxk+Ad64gE5ybOtYp6uNAWmlH7U2pK1PJtyJSjg+1SHwld2L8UFmztehsLhd6VSVFD2lao9DXOl/PDhQNiZcA3zyl1qeuhMYHFpmvv/2lkyrQd+Qh22eJ7e9XbwJjg1NxeD5oGAXtmn1R4cYhA+eeVEw6bd+ESHv93vQ5CsI2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9w61XOr; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24457f581aeso34238095ad.0
        for <netdev@vger.kernel.org>; Sun, 14 Sep 2025 11:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757874700; x=1758479500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V72sOLpArLpSzz2BXmWvU3GzOolHbwO0RKkipSbHAww=;
        b=b9w61XOr9Y4dZVPLsn2XwH72ki9hLNuMj2MXWUcdMcH9d9VItki9xt40ZzZoVnAhH9
         siUCf8A1T+IEpumoj4kNlhfpPRw2c7hx00sss00H7Ab8P7Yh8PV/RiB3HZ0vI3N/DqzF
         qCTdIVdbNj8Egc2DT9rSFNmz5EXpLufdsjLoyrNKRBRump5+adcx+KqOODb9FE8undah
         EkT1UCVs/BrzMOdi2ghdt02YybREtW6c4FnRzbzaO1/niwCJ8KVU0NFN0whIllS24KzJ
         Jcytd2bsNAF9W8eUilXagUgKAzp64wVALBgQNEp+3cSTc7KsT9o3WRvI29LkO51nO0zz
         bK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757874700; x=1758479500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V72sOLpArLpSzz2BXmWvU3GzOolHbwO0RKkipSbHAww=;
        b=ZtUU9MpNaUGW9xQ8DFeY+M172xTIQ2xemkCCnrWhVzxz+DVCbOGv4gZT+4ljWAUHa+
         Kh59TT0ahZZZlSMzul1QFJQxB5inrigaGVK5omaKSnDEVVZu9MGLc0BlGBFgIbHxCQvk
         tOa/oul0WXUf5a8791nPwbLHcVPaXO6m9UvPJpjONM8WealA8mxSe7vrRVSp4r3qkN8/
         MDjebizchnT1d9/UTxcGkLiKrkaKdtRLsMxvKR+9dzvyhco4e6rl2ZprkMayVnosumZR
         VShV7/A5/bARtPy4FVtQ8FlNb786U0TI0NEPBxD+dDbEtrYUU12ljfbNCkHHPhSRO68d
         25sA==
X-Gm-Message-State: AOJu0YxzqnI6m46p3W2a/Z2ZNzOuvbGTOAPAHgzbkvPXj8r7UG/lL4L6
	0DSldom1gI0814bv46uyK5ko3/1l1Xt8f7G2O/6T/T32BIjlQ2rysOgx
X-Gm-Gg: ASbGnctJpzpedgs7XFna1btZm4n81BOBYZ5Mige0nT2LZ3qG2HJy+up6PUeisSR/21e
	83RheHLmNAWPfVplw8xBYxQVVTYMPZCISoQDVU8O93U/NRf2d66dvK9tuvIyT+m1VVnu+fpO+r4
	uIqTaH0s7Juz08Gpkh+SAcKl4zoQnDI4Vg+7uqoSzSmetrvUFk3fJ0kcM7VVjZC2L8y/dvYRNP6
	z18uMntivGuJG4iZXTaYrRKNmQnaFjY4XWgg0UKqnl9kUq6dniQa+aVGdaay0yOQBk4Is9K8uVx
	g+sA5iJE7VQ/7o1lEpXGyT8WJz3jFvEV33eqpgsKByROkvGmaWmWxF66iLu4ib7QGp6b7D4DnxO
	clJ+Qgsud/6cKTaOHnpMK3Sb3Dhv7sZ1TUtVq2MZAQVkE6oYFjtzPMT4SWGsrKFVLmDI=
X-Google-Smtp-Source: AGHT+IGmaVDfD3oDHDJpd9fsoafiirPe2B8PuFLQIPHGMomPNEO50epFPEOlslvGEv0RscjGM1SFbA==
X-Received: by 2002:a17:903:3c2e:b0:240:3b9e:dd65 with SMTP id d9443c01a7336-25d26079293mr119493085ad.38.1757874699961;
        Sun, 14 Sep 2025 11:31:39 -0700 (PDT)
Received: from mythos-cloud ([121.159.229.173])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25e2fb546f9sm71760225ad.127.2025.09.14.11.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 11:31:39 -0700 (PDT)
From: Yeounsu Moon <yyyynoom@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yeounsu Moon <yyyynoom@gmail.com>
Subject: [PATCH net v2 2/2] net: dlink: handle copy_thresh allocation failure
Date: Mon, 15 Sep 2025 03:26:54 +0900
Message-ID: <20250914182653.3152-4-yyyynoom@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250914182653.3152-2-yyyynoom@gmail.com>
References: <20250914182653.3152-2-yyyynoom@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver did not handle failure of `netdev_alloc_skb_ip_align()`.
If the allocation failed, dereferencing `skb->protocol` could lead to a
NULL pointer dereference.

This patch adds proper error handling by falling back to the `else` clause
when the allocation fails.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Tested-on: D-Link DGE-550T Rev-A3
Signed-off-by: Yeounsu Moon <yyyynoom@gmail.com>
---
 drivers/net/ethernet/dlink/dl2k.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
index faf8a9fc7ed1..a82e1fd01b92 100644
--- a/drivers/net/ethernet/dlink/dl2k.c
+++ b/drivers/net/ethernet/dlink/dl2k.c
@@ -965,14 +965,11 @@ receive_packet (struct net_device *dev)
 			struct sk_buff *skb;
 
 			/* Small skbuffs for short packets */
-			if (pkt_len > copy_thresh) {
-				dma_unmap_single(&np->pdev->dev,
-						 desc_to_dma(desc),
-						 np->rx_buf_sz,
-						 DMA_FROM_DEVICE);
-				skb_put(skb = np->rx_skbuff[entry], pkt_len);
-				np->rx_skbuff[entry] = NULL;
-			} else if ((skb = netdev_alloc_skb_ip_align(dev, pkt_len))) {
+			if (pkt_len <= copy_thresh) {
+				skb = netdev_alloc_skb_ip_align(dev, pkt_len);
+				if (!skb)
+					goto reuse_skbuff;
+
 				dma_sync_single_for_cpu(&np->pdev->dev,
 							desc_to_dma(desc),
 							np->rx_buf_sz,
@@ -985,6 +982,14 @@ receive_packet (struct net_device *dev)
 							   desc_to_dma(desc),
 							   np->rx_buf_sz,
 							   DMA_FROM_DEVICE);
+			} else {
+reuse_skbuff:
+				dma_unmap_single(&np->pdev->dev,
+						 desc_to_dma(desc),
+						 np->rx_buf_sz,
+						 DMA_FROM_DEVICE);
+				skb_put(skb = np->rx_skbuff[entry], pkt_len);
+				np->rx_skbuff[entry] = NULL;
 			}
 			skb->protocol = eth_type_trans (skb, dev);
 #if 0
-- 
2.51.0


