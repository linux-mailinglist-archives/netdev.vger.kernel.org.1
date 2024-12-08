Return-Path: <netdev+bounces-149968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D792E9E8474
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 10:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4C0216563F
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 09:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4ED913B780;
	Sun,  8 Dec 2024 09:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="VOyNYOcq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECA51448E0
	for <netdev@vger.kernel.org>; Sun,  8 Dec 2024 09:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733651416; cv=none; b=AILn538bURoNybCH51Lth2L8/1eRtuBGQW+HWGl+K1E5v/ch2pPqEeTAIOx+8kEOoTOa1IFvQPiLRNY0Tcr455K51DxTZ5vwAKjyfw0DPgSTty2Ms4pLBZ0qdQillFj9YO7YENPuVUWng/R5hDpODqlViBtN8WpcYRTjq7C5JDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733651416; c=relaxed/simple;
	bh=wXdUfPDZdTp7uaCmZH8pm7BfzwNL7Ba4+AgLadvA+oE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hMit8s9mnVp4tSOO2xB6gcqrP35YQXbLjbY3+BAg4+am5jmkuuzehHvc7C2HS2/h4Skyi/0Eco+axJgJmRFSm1r0N0Xo9I2tMSVTKsveeCeD4ziXWrrC7lMzZw08wxeKlZRHzh8NjccJa+NE8uqm1u/ZWFoii5q0J5WaTHeYLmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=VOyNYOcq; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53ffaaeeb76so631332e87.0
        for <netdev@vger.kernel.org>; Sun, 08 Dec 2024 01:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1733651413; x=1734256213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4qJbTipl5jmcN+zl+yZ2AXjrvMRunb990PfhdGFi+FM=;
        b=VOyNYOcqXtcI3aCNYRedaRVcOaFPSgTgnsDW1JqQD3s/C/3NnzJwJVPCd1TkgATPzf
         nt4UwqQWzNDhbwqL3TWfYdICpAb/b2LY+DRvtVlNMAHcaqIjDhwVpc7j/tbuc4czCv7U
         Ju0b31JTSxN7K0l5o/5yspnzzyTYRfYouZLvaKDTAEqJZQyvhtcUJd/Cyq2Jwr7w7JdZ
         K16SFeY0qMdvJ0LH/WDSbPaZZIzp7svCNisKyU1yOm0oCWdyHMX4wLR8FQSDCusp3hHe
         v6pqZ0kbObYDI3a483+JP6zgGJo/DbQ7ztkoD7CrKDTTBsccasIyC554v85uBUGeQzGe
         /8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733651413; x=1734256213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4qJbTipl5jmcN+zl+yZ2AXjrvMRunb990PfhdGFi+FM=;
        b=AfjH6HODs5JkzutjImJv/CnrqbtnH5PRtNt1SMdOWcjX3PmxQGbna007yC8jg/ZLM6
         64IAcDzZ72rcLpgNUDOg55qmTPaHozVVT4YdQOyMGJlS/ecVpEB3A86tYRBegLePQW5o
         Q/SPGsKYsA61jnO3ed1zVKhzvZx4UhSd8xskCK/6NCDhEhfwuGW5CE9yM0bLgh+pTbAb
         SUA7E8PooaFmvwJkLjIbPTx+6pA1zvaZlwYQZ5sb4XFbIDceZz3g7DnRr7r6YPjUu3li
         I7Jc4Tmh5klPFcmTwmubU4qNB+jePIPB4H+4it1F8Mb/BJOTWk8cOdz42rZM2ATHn0Lz
         7L6A==
X-Gm-Message-State: AOJu0YwRp7GLmIvJUfUw5QNy96ikDfRyvih3cYZeBY9sbYISkOBl0D4+
	2v0gOdYhWm94HPXY6Tg/TkDgvAAABxx1WRWlQ4luut8ogQ9mnoMbQ5KTVezxGS0=
X-Gm-Gg: ASbGncvbxgFrsuS64ui3NdhbeISS4W4/5FqNVFQjgX3wV7VxNlACtXHn8qs5QtQMFzg
	rHZRHVPEfIa79ZWw0H2ICq/xrbpqclNte/plLpwG/sddDtXnjaBLE9umG2/2QultJM0K+auZytR
	sYlK+kWNzSs7y3fiCHvoMGS0nzbr8RCYdRmilM4WCUAMSp6mJ8nYYhhAdEXX+NOmK+0H3LiUM+n
	JSAxSY3+lH322RAWwIAHMDRcjO6UfTOOkmrO9YNbdrrp4zenxex013Cajuf+MBG
X-Google-Smtp-Source: AGHT+IHjfkWlUO9ktjjTWDVzSSef25MV2HxBTpd82UrqbQLyW1H2AFrdbCeLYV2NDHOM5jBn6C1seA==
X-Received: by 2002:a2e:bccb:0:b0:2ff:55f0:ae4b with SMTP id 38308e7fff4ca-3002fc2585amr46517131fa.21.1733651413281;
        Sun, 08 Dec 2024 01:50:13 -0800 (PST)
Received: from cobook.home ([91.198.101.25])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30031b80e7fsm6645311fa.120.2024.12.08.01.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 01:50:13 -0800 (PST)
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Dege <michael.dege@renesas.com>,
	Christian Mardmoeller <christian.mardmoeller@renesas.com>,
	Dennis Ostermann <dennis.ostermann@renesas.com>,
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH net v2 resend 2/4] net: renesas: rswitch: fix race window between tx start and complete
Date: Sun,  8 Dec 2024 14:50:02 +0500
Message-Id: <20241208095004.69468-3-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241208095004.69468-1-nikita.yoush@cogentembedded.com>
References: <20241208095004.69468-1-nikita.yoush@cogentembedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If hardware is already transmitting, it can start handling the
descriptor being written to immediately after it observes updated DT
field, before the queue is kicked by a write to GWTRC.

If the start_xmit() execution is preempted at unfortunate moment, this
transmission can complete, and interrupt handled, before gq->cur gets
updated. With the current implementation of completion, this will cause
the last entry not completed.

Fix that by changing completion loop to check DT values directly, instead
of depending on gq->cur.

Fixes: 3590918b5d07 ("net: ethernet: renesas: Add support for "Ethernet Switch"")
Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 drivers/net/ethernet/renesas/rswitch.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/renesas/rswitch.c b/drivers/net/ethernet/renesas/rswitch.c
index 32b32aa7e01f..c251becef6f8 100644
--- a/drivers/net/ethernet/renesas/rswitch.c
+++ b/drivers/net/ethernet/renesas/rswitch.c
@@ -862,13 +862,10 @@ static void rswitch_tx_free(struct net_device *ndev)
 	struct rswitch_ext_desc *desc;
 	struct sk_buff *skb;
 
-	for (; rswitch_get_num_cur_queues(gq) > 0;
-	     gq->dirty = rswitch_next_queue_index(gq, false, 1)) {
-		desc = &gq->tx_ring[gq->dirty];
-		if ((desc->desc.die_dt & DT_MASK) != DT_FEMPTY)
-			break;
-
+	desc = &gq->tx_ring[gq->dirty];
+	while ((desc->desc.die_dt & DT_MASK) == DT_FEMPTY) {
 		dma_rmb();
+
 		skb = gq->skbs[gq->dirty];
 		if (skb) {
 			rdev->ndev->stats.tx_packets++;
@@ -879,7 +876,10 @@ static void rswitch_tx_free(struct net_device *ndev)
 			dev_kfree_skb_any(gq->skbs[gq->dirty]);
 			gq->skbs[gq->dirty] = NULL;
 		}
+
 		desc->desc.die_dt = DT_EEMPTY;
+		gq->dirty = rswitch_next_queue_index(gq, false, 1);
+		desc = &gq->tx_ring[gq->dirty];
 	}
 }
 
@@ -1685,6 +1685,8 @@ static netdev_tx_t rswitch_start_xmit(struct sk_buff *skb, struct net_device *nd
 	gq->skbs[(gq->cur + nr_desc - 1) % gq->ring_size] = skb;
 	gq->unmap_addrs[(gq->cur + nr_desc - 1) % gq->ring_size] = dma_addr_orig;
 
+	dma_wmb();
+
 	/* DT_FSTART should be set at last. So, this is reverse order. */
 	for (i = nr_desc; i-- > 0; ) {
 		desc = &gq->tx_ring[rswitch_next_queue_index(gq, true, i)];
@@ -1695,8 +1697,6 @@ static netdev_tx_t rswitch_start_xmit(struct sk_buff *skb, struct net_device *nd
 			goto err_unmap;
 	}
 
-	wmb();	/* gq->cur must be incremented after die_dt was set */
-
 	gq->cur = rswitch_next_queue_index(gq, true, nr_desc);
 	rswitch_modify(rdev->addr, GWTRC(gq->index), 0, BIT(gq->index % 32));
 
-- 
2.39.5


