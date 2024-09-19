Return-Path: <netdev+bounces-128953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F01B97C8E1
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 14:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F7E01C21A7D
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 12:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065BE19D074;
	Thu, 19 Sep 2024 12:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BvxYye7o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B26A38DD6;
	Thu, 19 Sep 2024 12:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726747856; cv=none; b=sb3QfF+MPIrorlGEgPzQxOXL6tBl7WLW0VhkCDQtEWeNNxlXmmwkhbyJMjHSD3QdbAvlc/qdOvqU24J5sI58dcorzJMogHdV/7VcniuRmW8J1fb25+XgAQhOp3yGhiRh3kgEJmgu2zVPfX4lrE5bcrK4zAB4oWtRg4TjUmDMLrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726747856; c=relaxed/simple;
	bh=fbD60ODl32TKXvojAtsP1tfik+n0hoD0w4wsFhDC2Zk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HbPFqgjyuulF3eXBNqvtqiRF2psS/jmXPB9kCSMzKplxBzddx7boErNPg7ysfVoMbED4AnMQl5BAPh/HD/RQHB6nheGRr78j8LRCLK2+1jvUxNy/oywN1g4rCrHPkI95zVN0C1zeI4WPGLLDOFMkLFzvXq1rQpsDTsG/7CB+0bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BvxYye7o; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2057835395aso9577135ad.3;
        Thu, 19 Sep 2024 05:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726747855; x=1727352655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o32/nc+Dqjrsv+Sp5j6ph6epltryoYejvMuSKLYsEsQ=;
        b=BvxYye7o1BqGqcxEJlgUyZv31+IGLYEf0LQZK7Ou7gi2ABsN8oeM7/G2nQxEieAv9m
         Tzt+/SZPY9o8gq5jIaU3c9Wuut72lCA9/TUjT4yx0mbJKvY69Lxaqd9g6Wv2BmawOvYK
         /H27qhQyPe8ZMWX3PnnzCd0+zRMrejiwk6vFh0+BCxY6XdY1qQ+gM1UXB4KRTEm6wXb2
         Bk9i5vQnt20DZGcOU+R7zAaU2wd/Va6WV5c9T8kG64z3e50AjzBcSTx58bNmXHENQc02
         S5wXxMGyDItwPuQPn/1rJhEh1HTvgo71PYfKGkxq+93A6ctvhANgKO2HZpFSNQkXxo8l
         FXzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726747855; x=1727352655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o32/nc+Dqjrsv+Sp5j6ph6epltryoYejvMuSKLYsEsQ=;
        b=RvPV7WSJ50ul7VQj2H6Q5/9YNIZSC8arwZD8ZxvLv8sPLIwDrRGuhCs+poMCgW+E0l
         D3mR7MoFxv/bVknbgvQXaxm7r4rs4EhDOGSI2nJeAcX/M1b1owGCnKdG7q+8OwVSoPWt
         FSkj0kH2v9BbqmrsmkmtvE4Q0+SQsOZdAcLQ9zD0ufqzgePS4ZAZTUw+EjLoq9kYvAz2
         Jjhm0/mcEvarVOdiSaYI1sFXBforCHzEIRqXdJCC+DTTj0958HJ2wEwhiTqZve1ROhea
         ksJjXHR70Ax1GWH7W7l6rDMmKhU+gwYMaG/1KNxbaAmIESo6CqROPGP84HnhI3f13TVa
         yG1g==
X-Forwarded-Encrypted: i=1; AJvYcCUWAN1GDNcK2tileDmEZZTclxNrHJPZD/UWCP5GwoX2dBpk2ezsR9mKBMBntDEKsKxIZzirz9v0CukUYJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDxKTyhVchONv7NLE8Txb984GWWMOLrbwFB4rCb2Cmhk7HlY9E
	0NVXbnZQwb68eTu/5ikq8Jg/gxvmykQN3giHIRkc49lp9XMRB7L7
X-Google-Smtp-Source: AGHT+IGZREsj4SQwgdJITtOEHoTSJHe60c5soOhc/Mx1CbgeWx979RO8pm0n67220rUA8Tpw/0tJSQ==
X-Received: by 2002:a17:902:f54c:b0:1fb:a1cb:cb25 with SMTP id d9443c01a7336-2076e3eaabcmr356890015ad.40.1726747854563;
        Thu, 19 Sep 2024 05:10:54 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2079460327bsm78691445ad.103.2024.09.19.05.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 05:10:54 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: Ong Boon Leong <boon.leong.ong@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	rmk+kernel@armlinux.org.uk,
	linux@armlinux.org.uk,
	xfr@outlook.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net v2] net: stmmac: set PP_FLAG_DMA_SYNC_DEV only if XDP is enabled
Date: Thu, 19 Sep 2024 20:10:28 +0800
Message-Id: <20240919121028.1348023-1-0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 5fabb01207a2 ("net: stmmac: Add initial XDP support") sets
PP_FLAG_DMA_SYNC_DEV flag for page_pool unconditionally,
page_pool_recycle_direct() will call page_pool_dma_sync_for_device()
on every page even the page is not going to be reused by XDP program.

When XDP is not enabled, the page which holds the received buffer
will be recycled once the buffer is copied into new SKB by
skb_copy_to_linear_data(), then the MAC core will never reuse this
page any longer. Always setting PP_FLAG_DMA_SYNC_DEV wastes CPU cycles
on unnecessary calling of page_pool_dma_sync_for_device().

After this patch, up to 9% noticeable performance improvement was observed
on certain platforms.

Fixes: 5fabb01207a2 ("net: stmmac: Add initial XDP support")
Signed-off-by: Furong Xu <0x1207@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index f3a1b179aaea..95d3d1081727 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2022,7 +2022,7 @@ static int __alloc_dma_rx_desc_resources(struct stmmac_priv *priv,
 	rx_q->queue_index = queue;
 	rx_q->priv_data = priv;
 
-	pp_params.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
+	pp_params.flags = PP_FLAG_DMA_MAP | (xdp_prog ? PP_FLAG_DMA_SYNC_DEV : 0);
 	pp_params.pool_size = dma_conf->dma_rx_size;
 	num_pages = DIV_ROUND_UP(dma_conf->dma_buf_sz, PAGE_SIZE);
 	pp_params.order = ilog2(num_pages);
-- 
2.34.1


