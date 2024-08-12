Return-Path: <netdev+bounces-117756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3C594F189
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 17:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A929BB20D0E
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 15:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA56A183CBD;
	Mon, 12 Aug 2024 15:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7wzhPds"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8BA130AC8;
	Mon, 12 Aug 2024 15:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723476122; cv=none; b=k8l++Bh33F8n/+ZLtH3LScn2rTS0iyNbRafhdzVBoYdehG0B/kWo/9A59EUw053GOmODZ9e6SAkWVKNJKRgUlklq4H+f4PhmnZ0yi21WNF7mViYglja3Z4C7qHmYuYX/aPrb5UHgaKbzz1Fotv9BQpz9IfH0F/3xhuas9SgVSNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723476122; c=relaxed/simple;
	bh=BdRss7HScnqpUPSGPbn5kRX0iD7ZVa9shtJAAuZFFgU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LfVuYR3FPnpOhWChDv9ACnO2tU193zNqS1Uq6ODn/fkjAyJVUzPyOAzcoipitfsSDj3h6yAyTg7rNiTgXyaiCUurv93WQ/KjZOTZUAybriylN3GlJtY2N5EfFCVWzTuDJFtg2KWjaEvedO79A73X7dUfQGiL4A12KpxiKzULuds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W7wzhPds; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3684407b2deso2449107f8f.1;
        Mon, 12 Aug 2024 08:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723476119; x=1724080919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PPD8gJ9cV6O2k5z5drN4BDffP3RH4AxPBal9IAvehBg=;
        b=W7wzhPdsKygIpuvfBQ7cO4rEiAzHGHMYkCDbTf0Pejf5xVKvT+hQmgslRd5Ve+kKtG
         1Td1eIRIrchejO0JkeANtwQXgqHqNex2UjpxePNTY8uj3sb7oHls1lzRwmgxLswQV9Ej
         vM9c8mq+Wd7Twi2jUYGX7C5JTksVslQg9JJw/6QxEbRXhCYaPoADDAHnvZzXuTu0pjvg
         JMQKCP+6FCcpiQ8pYRMwy/0Jja/J2/IaIOMNdyTTWiqGZ0TmL8vn+q0i3764d6BZWQGL
         sacc1t13XDAeJI3qsWHa8IfGZKNft9PLtMgm+bYIH0F5m13vm7mRRnBveGkK31xmtJzW
         LdFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723476119; x=1724080919;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PPD8gJ9cV6O2k5z5drN4BDffP3RH4AxPBal9IAvehBg=;
        b=QdxC1/9XJJ9JCfYq8e3j1ZyoAbN8m/8dZH+22KC5UB1OBIGRlfkCH5sB8mZ8ZLtOhj
         2WYWZxsa/sHQkDnpWfAAJFUj8kYtUmgBnCEPHgEuAhJvYN1C68suc/9SUtdXUf5vjy+T
         5J3CI98uaPvh0FHL32yZNOg9mIUoAWMjFl7Hs1jI4EeysHTZdBK9F57hhlMwf97xkhwC
         rFo/w0FcYYGnZjxHFJNYWZ5oOfUqiXFRNAlpXWouv65/wEzhKmGVOK60z6OCg6Fe/xSx
         zwR7lA4J3l3BdQrpdQOi+sFlM6LQbOxnxI6/eZbMItj/JyhkvtnoCEVFt5LpPqCJaf3G
         ReQw==
X-Forwarded-Encrypted: i=1; AJvYcCXcmgqO0+bUOtH/R2D+5Aoa4UKHL5BbGGvU5POEtzuZ9eNjEWMsfJKKuuF9VlsSDbGrJPtPrSX8wjECSwD0JPdle3TYSltENIuo9yp/4lyBUxjZY6CI9rYnjSd/IFIDd2uNDILB
X-Gm-Message-State: AOJu0YyZngX5FytqE3/s/IQmZ4zPbbMNgd9PQZnxrGpR0kLybgjakT6a
	s9hJsmkJA+L0DbFc0T6uCWEhaeptYOatXpvHQaAgChY8xAg4bzH1
X-Google-Smtp-Source: AGHT+IG5B4/73W1aLnLgYfjQ+u1fYxYYhA6rdRE3eEvzEhcHKfoxCgLH5sWm8jJSTeIvBvUOSmXxlA==
X-Received: by 2002:adf:fc47:0:b0:367:993e:874f with SMTP id ffacd0b85a97d-3716ccfecc3mr461173f8f.34.1723476118929;
        Mon, 12 Aug 2024 08:21:58 -0700 (PDT)
Received: from yifee.lan ([176.230.105.233])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4cfeedc8sm7860752f8f.55.2024.08.12.08.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 08:21:58 -0700 (PDT)
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
Subject: [PATCH net v2] net: ethernet: mtk_eth_soc: fix memory leak in LRO rings release
Date: Mon, 12 Aug 2024 18:21:19 +0300
Message-ID: <20240812152126.14598-1-eladwf@gmail.com>
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
v2: fixed compilation warnings
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 16ca427cf4c3..e25b552d70f7 100644
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
+		free_pages(unsigned long)data, get_order(mtk_max_frag_size(ring->frag_size)));
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


