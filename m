Return-Path: <netdev+bounces-157070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14503A08D0B
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 10:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A5657A04B7
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 09:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F893209F57;
	Fri, 10 Jan 2025 09:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3j3unXX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B01207A2A;
	Fri, 10 Jan 2025 09:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736502861; cv=none; b=Reu2XnMzCCMMVG76JrCEjfsTIa3u2FI/uXwmTO67krBmTjefnrZzAetn3R3ARQG/LjVHkvrrwr/dZ3aV3c4XDw+5TXZncHOunbZS2dUe3ksnjUaUexK0D3UNnZ1k7VoXuQ+Diei2w8IscrSrCyI2LJVWh154XhE/0YK2mxMrIOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736502861; c=relaxed/simple;
	bh=30f2ez8x6hKGpO7dpUM7/KVxepJSM03jK0tXKMas4N4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AV0j6YU73GELmqEiPo1Yv624lvBPXMAJQF6galnTs+ftbFwvyKmmPmikh00B2hmXvYcE6MX1F4RV1oLyUMC3oykqoIvnEfoc54O8X3b2pYgKSZd8EGM6G+/WXeFBteIp/E8WQfho2pZtXRyCYyO/aMvSVo9cOrpbAa06Ni2BJa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3j3unXX; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21628b3fe7dso30898095ad.3;
        Fri, 10 Jan 2025 01:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736502857; x=1737107657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SUq/PWSOM6Jgkh8a1Vg6y06uVsWzXgd/e9CTRW/3aLI=;
        b=S3j3unXXQGGivR+BiIy6kq77PxlzAqG7CqcuY4i1bF8+Przn3odAAWgbPSH8UIP43o
         LENsPLoX4xLYS14socGBBONp8R5EHioTZzzmAcXpbudVpRY8GNTFL8EMVzXjfg7McWVs
         m8ZeHzsUnKT0L2yIBJcHx239l4viGUKQs3AMNOprMcjulRhwlfipCVn40YxhWLVjExAI
         nwJeag5+9ksmCpnFRDDM5PgQGM++8SA8CV9F8Xe5U9hX/oMEhnNWo37WH71a5nuoDQuO
         R/W7gUpNLk9wc4ednvp5Z4cfE6GKARhBUhpyFe4GfqFHYOYs3cdWKN4u1j7a8NUdxiqf
         lGnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736502857; x=1737107657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SUq/PWSOM6Jgkh8a1Vg6y06uVsWzXgd/e9CTRW/3aLI=;
        b=LQRGHQaoS/7eT4X/3ZSOL/Q+J4SJLzcPJsSXOP+wJyI3fj0AFbGau0QU0rr9zgAWqL
         Q6nqsB+P8edA/DkOhNnJTkOry80/VMPp2tXYWLt9ydCstNnqHGaAhX/M7w3WihzCDFf/
         CH3Swat4msFwjMH6iMYwmIXfLR66n368nAkZ3o4SBQDY6qd6HuMMWxBVu0yyOnYUNzTy
         tkOTVs84B1qtXcUt1oL/qz1z2vrWh89IhqZ7mYQmCccWK54Hvl7FC3QiRWlCnfnbTX2i
         Uu2/bPvYJy9bl2s+q28jfYMFSVeAQOZl7l0sejBvaHqdk+rUDTL9SHSCSxjtq7iZvWaK
         UlhA==
X-Forwarded-Encrypted: i=1; AJvYcCUhJu5ycC+z2hZuaxw+3agLtO81cXBWmansH4I+stznDmkb8g/VyF/8welf+fF7uNRv7chegPtIvC7w2SY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwMcwOlBtMFtwjtoon6az29LloVKyIQP4aovlQX0DAGDU51X+2
	GnSsUzJtHEnnC0gj+txijBjqAg0ZBp0VQ+NPyCuqEprFT+V2DMfGxEBhOw==
X-Gm-Gg: ASbGnctx9TEFoyDcmn75g+kS9SrvMrQydyHvJsa3E8uvQ5iTRkVtZFOLfSasCZUhG8q
	gPnI4gmYAknIYvofUx/cHQyqb+1tzFX5LP4kJq9nrj4VILaBFoTs8YrtuMhk02JrRMNz6efKPu2
	BN3eC5NcT7VwRswpHgtTtZ3ZQuw0dN9dCE5vbXOT4ohkqtKc5yRAQn4yr0CLApLtHSOtH9hGCq0
	zFOYXsU1OhYLzclo1eiL9cTgxZ3G4G07pjtJIn6k4o07GuQZiGUnIvaxbZYluFxe1okcw==
X-Google-Smtp-Source: AGHT+IHNOyExXpjKEAJvj5VF4TsAcm/8iRdMra6jEOVD+0OivVdVmbGUe1wn2Z9fO5OhUfPCMwcgdA==
X-Received: by 2002:a05:6a00:91cb:b0:72a:bc54:84a5 with SMTP id d2e1a72fcca58-72d21f296edmr12960201b3a.6.1736502856641;
        Fri, 10 Jan 2025 01:54:16 -0800 (PST)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-72d4069217dsm1186183b3a.151.2025.01.10.01.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 01:54:16 -0800 (PST)
From: Furong Xu <0x1207@gmail.com>
To: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	xfr@outlook.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v1 2/3] net: stmmac: Set page_pool_params.max_len to a precise size
Date: Fri, 10 Jan 2025 17:53:58 +0800
Message-Id: <4bfc67ece5ef615ce65972173f5256f10ea27f9a.1736500685.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1736500685.git.0x1207@gmail.com>
References: <cover.1736500685.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DMA engine will always write no more than dma_buf_sz bytes of a received
frame into a page buffer, the remaining spaces are unused or used by CPU
exclusively.
Setting page_pool_params.max_len to almost the full size of page(s) helps
nothing more, but wastes more CPU cycles on cache maintenance.

For a standard MTU of 1500, then dma_buf_sz is assigned to 1536, and this
patch brings ~16.9% driver performance improvement in a TCP RX
throughput test with iPerf tool on a single isolated Cortex-A65 CPU
core, from 2.43 Gbits/sec increased to 2.84 Gbits/sec.

Signed-off-by: Furong Xu <0x1207@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.h  | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 43125a6f8f6b..c1aeaec53b4c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2038,7 +2038,7 @@ static int __alloc_dma_rx_desc_resources(struct stmmac_priv *priv,
 	pp_params.dev = priv->device;
 	pp_params.dma_dir = xdp_prog ? DMA_BIDIRECTIONAL : DMA_FROM_DEVICE;
 	pp_params.offset = stmmac_rx_offset(priv);
-	pp_params.max_len = STMMAC_MAX_RX_BUF_SIZE(num_pages);
+	pp_params.max_len = dma_conf->dma_buf_sz;
 
 	rx_q->page_pool = page_pool_create(&pp_params);
 	if (IS_ERR(rx_q->page_pool)) {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.h
index 896dc987d4ef..77ce8cfbe976 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.h
@@ -4,7 +4,6 @@
 #ifndef _STMMAC_XDP_H_
 #define _STMMAC_XDP_H_
 
-#define STMMAC_MAX_RX_BUF_SIZE(num)	(((num) * PAGE_SIZE) - XDP_PACKET_HEADROOM)
 #define STMMAC_RX_DMA_ATTR	(DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERING)
 
 int stmmac_xdp_setup_pool(struct stmmac_priv *priv, struct xsk_buff_pool *pool,
-- 
2.34.1


