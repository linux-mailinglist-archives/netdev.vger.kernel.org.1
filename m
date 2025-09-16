Return-Path: <netdev+bounces-223682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 743DEB5A08F
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 20:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D87451C047BE
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 18:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBC52F2601;
	Tue, 16 Sep 2025 18:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcji2MQq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841D7143756
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 18:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758047608; cv=none; b=exLpzk4LdoL8GVJ7k77QhIpP64ppJ8NxOyVLO3s/8p4rwtnGGYMhpHl+hOiVWQiEuw/4LKEZWm8CNRLcKmI8cNfv9kUGF5gs2kIAwimClDMTiNg2cUCcW3NR1VQtJyr6A21oHBMKo2wKzJx0FEbKltKg6egre/zQgMNrlW3BHJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758047608; c=relaxed/simple;
	bh=ngLz/4Ezk/tubDYx/Lgk6Dje8hW93S4AUSflPV17tVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o964nFqk356u3jUhrQ4oXHOxxiinpAoHjulbKCdlzG3UvUw+Abg3kYYZSK3NmBI8z/OjymLH0IMFwsN1oAAQ8avBnWuuGLA7mHz3tFcPifbYtdOC/n/m0aj+ohA5SFMlBwGY6htkb8e37gNT4wDnDQKuWn37JIkf6a52B5PnwiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kcji2MQq; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-32e372c413aso2128892a91.0
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 11:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758047607; x=1758652407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e6Ht+bpIkPjtMXWp9XgtcAPi+mKoELdBIJyuizZRIWY=;
        b=kcji2MQquAD2JVt3OJKRrf1p8vg5M4YNXVvx/2sM60eL32dFKXxY9sAi32XwlFC6Gf
         xUyyBj1T3CueFhlzMzSNXRYYDTbvAaZLyNiru5ePn9r9k8olxyGvoqWvESAQCXLXVE5J
         RiV4OPRX9MlwEgUFB4NwJFtUxXN8mBFEpSJuqV//oFXYe2teuzvo0DBjrOpsRuWMS33m
         UZWgGPujhPQy410EPBa5z8tX+7TpD8iW3/y1fWxWlxoYqjmGnMIrflmwrmD+EHx4rwAs
         EaCcVZcru25bg9LQ5dDL7NzDF2TcyYEdWulvl5uyKvLZPulaCG+6jL16TCNZSBc19tSg
         BgUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758047607; x=1758652407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e6Ht+bpIkPjtMXWp9XgtcAPi+mKoELdBIJyuizZRIWY=;
        b=llJUSYBBQnt00cxFi8KpRr/ToRK9p5P0K7cJnV7aciwQovvZLyPBDw0F+IJCHgXZbP
         APmwtnmxCp04wuTgXTbasWOslXxLuPqdJ9FwOsSVii8K3JzacE41Ig7xYMmMRI+qsKGr
         MF2ViEsBDjF5Vltz+d1sKSNFaecTEsGhs8C+6fkqPEvbQ9SsZluINpJ2fDV6JT+yRseI
         zxmWkOnalDuiE8cULz+j8WC5bDpnzAsUL+7CDmlV+ny4RTrBIX0vqm75knmTS0ALsUfu
         mb0SMkgxOf+Fw6S82WY4TAZ2MQfIM3fx9FcbvNd/IkP3t4Ov7pTk1prRDuAy9Ai9nu0z
         5SVg==
X-Gm-Message-State: AOJu0YxcW3/j0XS0DvcRt1svtNPVUXdKxXHm+P5V8qhr6qcOEcfgsGaR
	SEAQQBkUuEO2ycyJhfG9fe7wMrxP6GBsItnGt+JrUHf5GOO6P8QUGnHNuDrIBvSL4mA=
X-Gm-Gg: ASbGncuY0Gg18nRk46f+hpHnjE/cqO55U/JLShgggEe4yVwfY7qPucrALRHmdRZJoU+
	qbVICvrOhXFQzK2cNY9+9UiGKtw5V4TNBrh/1MDOTZonZRPQ6kAOY3xJNMDDCGdbqEA2Eu9Lfat
	jPIQQ8EebzCV+ZCagWBz4S4pIuyT8aXWWGJYPdCJjf9vnhDORpDvoWA+R3Ijqglg3J14tJeBuPZ
	SUzJ6dJsJATBwX+78WoSoGwihXsDfdo2TZflUG2tLewuSxQ1VVk+Qj179UArH8Zrd/XVTb6c8gH
	0ns2JZFZ0YNFsV2gc31CDtUXF4tmqxI8/NTL0l+ALjBs6U6RFm6hH996naupIbAaTni0koFU5Cl
	iVWiuxzzP1dP1HKIvIA2QmozjmLZzIQ0wzVbGDdnbcwNShZBEqkVr9lIe
X-Google-Smtp-Source: AGHT+IE60FRNbaIgGLpS7RTlhNopZLjGLrwDqgS+R4ggALxBYN8fkG1Oyxxw7C+bn8mbnje6yiDdYg==
X-Received: by 2002:a17:90b:1fc6:b0:32e:1ff5:5af4 with SMTP id 98e67ed59e1d1-32e20049fbcmr14219148a91.35.1758047606752;
        Tue, 16 Sep 2025 11:33:26 -0700 (PDT)
Received: from mythos-cloud ([121.159.229.173])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a387b543sm14915968a12.33.2025.09.16.11.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 11:33:26 -0700 (PDT)
From: Yeounsu Moon <yyyynoom@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yeounsu Moon <yyyynoom@gmail.com>
Subject: [PATCH net v3 2/2] net: dlink: handle copy_thresh allocation failure
Date: Wed, 17 Sep 2025 03:33:05 +0900
Message-ID: <20250916183305.2808-3-yyyynoom@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916183305.2808-1-yyyynoom@gmail.com>
References: <20250916183305.2808-1-yyyynoom@gmail.com>
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
index faf8a9fc7ed1..cff90417c05c 100644
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
+					goto fallback_to_normal_path;
+
 				dma_sync_single_for_cpu(&np->pdev->dev,
 							desc_to_dma(desc),
 							np->rx_buf_sz,
@@ -985,6 +982,14 @@ receive_packet (struct net_device *dev)
 							   desc_to_dma(desc),
 							   np->rx_buf_sz,
 							   DMA_FROM_DEVICE);
+			} else {
+fallback_to_normal_path:
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


