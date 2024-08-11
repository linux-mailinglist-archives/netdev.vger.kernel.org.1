Return-Path: <netdev+bounces-117527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F9094E2BA
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 20:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E378B20E71
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 18:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0C914B96A;
	Sun, 11 Aug 2024 18:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTnupB4/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3025C2837F;
	Sun, 11 Aug 2024 18:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723402212; cv=none; b=WGwQrKkdkikxkrc68qx3feJYjALWCdCM1jYt8qIkWZEFwGrdTqvxvH67U0aMNdOVzvJv74pcKWuX25sVzElTzANkqUf06BXZHkpOjylYwGjzp5mDEjsw0z90VDb6RTBoFQUg3uJG8oEs6QU3sNqUdStgzGau9OY/DHUH5Wspnjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723402212; c=relaxed/simple;
	bh=b5JVz5Tpar0c5FAXwXBzPwG6rJWMlMlb4vO/RI7Hoko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gr1UD4G5+5cuKRa9Tmtd4wJ+AKbq96X1Jd/5gFr2h3JMXKJ2NzHXXaWYOHp0yK8To/FTvF/GMhmNBMM0AZsLpbdEyOhsklb2Ra35yRWhUTS5an8PbNBIzwWezspdaKzpC/JtyR/+A8utLP1Odfm//3qlq6HlHkVmYUdIYC1UXLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OTnupB4/; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3684bea9728so2209257f8f.3;
        Sun, 11 Aug 2024 11:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723402209; x=1724007009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+q3yH2GVKTI88q3BAmiWkMTGDbrf/3EozEWfMZeP1ec=;
        b=OTnupB4/wDUUsj9n/KSjyJYVm2Vac1GecVtFeQ7hocAW7a0AkPy4+K7DqJ7r8QcCPq
         ZHvNVWExMKtf1tslPk+P4ML00NRdgTR4AyrZCa5rBw40S+g7JX0D0D4F2VVdxMtdLNhC
         p1jJ232f7mIqZgc9cC4TQaDJ0BXuAKy8P3ZU0p1E4kIH2lAEDiLM+A7sJVWILJ8MSXLc
         sL2ngsySvqlEb7F5GPBmrm/kE/TjLguAhUJb4USYn4hIhejq8R2nn7sp0snhldmRYtZk
         tcX1m0pd2hhn+RttTKFuSxLlS3ggpLKTMZQZnobDlprF2Kk7ExLiTAKi/b0cYv2xfrg1
         evIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723402209; x=1724007009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+q3yH2GVKTI88q3BAmiWkMTGDbrf/3EozEWfMZeP1ec=;
        b=kTyumkCutmstSMOtBu/gi/jFmTglPltCHpeURCvAm/nUe9y30g0AgRMn9DRknRGHYN
         tQ1Hf5GUBc6sQ8cCT1jMtjg/Q9lRs7zP/Sge774dpj//acOswfc/eooMMq+/VehMPV78
         Q0GOpM8q5cn1E4OfhIGZElD87D8vmVbjNyHfXG4jdTFq7voFMcwOv7lY1Yfl6QggbV3+
         DPHRjuL2/V2JsffakaDTHPf360woY+Pp2RjheAxGDnX+hMBIptvsggO2MssDq0LAyzY8
         qLV7qYHJWjJxvfavlcb3CnH3eqLKbEOTenoQUtVvO+QmvTnRk+So9olnaX7h/cPvNgea
         bE3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUhmIQ/fx/jGR4z2GNozBu4eWKCtFhZLRnxU3sjm2VcLEPYhreith8zm8u6R0nKKSh9Bsv8p3QXCLp7ojHpTKvGm2FfIzYJOeSFTVmHuDlXv7/8OpmnQm0aJK57LCaGuvnu3SM9
X-Gm-Message-State: AOJu0YzP5DQITwrIcsYbsbypWf50qIpGgcnM0R2gE8HwPWx44SmZUItg
	zNLZloOvkMfAjDGA6st0avAhUgoR2t4IhuVSHr23/4WnKMV6+5be
X-Google-Smtp-Source: AGHT+IH9FjXsU3WtmkAc/rzXtJFMjqHYnqwh8bqjz1y9HWu7myVmeb6vI9Hl9TlvZKwTXMnYMroIbQ==
X-Received: by 2002:a5d:60c5:0:b0:360:7c4b:58c3 with SMTP id ffacd0b85a97d-36d603555f9mr5650727f8f.54.1723402208958;
        Sun, 11 Aug 2024 11:50:08 -0700 (PDT)
Received: from yifee.lan ([176.230.105.233])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4e51ea8dsm5539929f8f.87.2024.08.11.11.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 11:50:08 -0700 (PDT)
From: Elad Yifee <eladwf@gmail.com>
To: 
Cc: eladwf@gmail.com,
	daniel@makrotopia.org,
	Felix Fietkau <nbd@nbd.name>,
	Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chen Lin <chen45464546@163.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net] net: ethernet: mtk_eth_soc: fix memory leak in LRO rings release
Date: Sun, 11 Aug 2024 21:49:45 +0300
Message-ID: <20240811184949.2799-1-eladwf@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For LRO we allocate more than one page, yet 'skb_free_frag' is used
to free the buffer, which only frees a single page.
Fix it by using 'free_pages' instead.

Fixes: 2f2c0d2919a1 ("net: ethernet: mtk_eth_soc: fix misuse of mem alloc interface netdev[napi]_alloc_frag")
 
Signed-off-by: Elad Yifee <eladwf@gmail.com>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 16ca427cf4c3..bac6d0c48d21 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -1762,8 +1762,10 @@ static void mtk_rx_put_buff(struct mtk_rx_ring *ring, void *data, bool napi)
 	if (ring->page_pool)
 		page_pool_put_full_page(ring->page_pool,
 					virt_to_head_page(data), napi);
-	else
+	else if (ring->frag_size <= PAGE_SIZE)
 		skb_free_frag(data);
+	else
+		free_pages(data, get_order(mtk_max_frag_size(ring->frag_size)));
 }
 
 static int mtk_xdp_frame_map(struct mtk_eth *eth, struct net_device *dev,
@@ -2132,7 +2134,7 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
 				ring->buf_size, DMA_FROM_DEVICE);
 			if (unlikely(dma_mapping_error(eth->dma_dev,
 						       dma_addr))) {
-				skb_free_frag(new_data);
+				mtk_rx_put_buff(ring, new_data, true);
 				netdev->stats.rx_dropped++;
 				goto release_desc;
 			}
@@ -2146,7 +2148,7 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
 			skb = build_skb(data, ring->frag_size);
 			if (unlikely(!skb)) {
 				netdev->stats.rx_dropped++;
-				skb_free_frag(data);
+				mtk_rx_put_buff(ring, data, true);
 				goto skip_rx;
 			}
 
@@ -2691,7 +2693,7 @@ static int mtk_rx_alloc(struct mtk_eth *eth, int ring_no, int rx_flag)
 				ring->buf_size, DMA_FROM_DEVICE);
 			if (unlikely(dma_mapping_error(eth->dma_dev,
 						       dma_addr))) {
-				skb_free_frag(data);
+				mtk_rx_put_buff(ring, data, false);
 				return -ENOMEM;
 			}
 		}
-- 
2.45.2


