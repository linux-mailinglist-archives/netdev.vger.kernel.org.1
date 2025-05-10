Return-Path: <netdev+bounces-189476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C75B8AB2400
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 15:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B50BF1BA003B
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 13:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F327221DA6;
	Sat, 10 May 2025 13:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkwQgREX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB47522257D
	for <netdev@vger.kernel.org>; Sat, 10 May 2025 13:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746884918; cv=none; b=Nf5FZmcq8B1h+2lTKFUESrvBM9ZT4ieVpx8hDNCEOF/2bM+em5cQ8gzUWorT2AIiLerZffFgGc/BW8UFaMxgGzETSpe8Wjup95UhtYAAjjZvVqAVteJ/pLvtvHsjM0Q/QjsNV8M9b1bUVRH7miJRN7Ur1gZV5il+OgorNOBemK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746884918; c=relaxed/simple;
	bh=NooZdFE5WAk58obpNN1VKmIHlnAFKWsgXV/e5KA0AkU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Io9mP8yLkWmkZp3bURnrGsHMF5HABV1EyyDkT6lOYXwrDvqhQUQR633Q3Fx6bteYX+lvuJTNp1xUi1f83qOHdzCYYsJyuf5DtXzn795bAW2N0d3TVbvVndC0ncErKafQ7/VpOVmD3t/GS9wrtSZxxNU0oOPwBplX6R+PbBdT1tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GkwQgREX; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7399838db7fso3012588b3a.0
        for <netdev@vger.kernel.org>; Sat, 10 May 2025 06:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746884916; x=1747489716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HPNtmFJxQ6qfkaV/7sUcFpQ7Up10ht/uIC/UAoosXBs=;
        b=GkwQgREXKXlmUfdc6D4a7Z4AHC8NFgHssza1ptMKQ3x65prB2I+MHg4Q3QdGomsF5d
         mDDjiHxV00eI2ACu1IxYKQI2EMj3lJ5FO2197YhkO/N6Vqlt5BOYwLbM0NyfFoAlKTZy
         jpjPKHmSmEjdu+RlZih+ITVXNIlRa2Wfz0gjfwkQBsZLcXdkK+ZUNfVMjyPGc9WELDx4
         QgOFarTTYiAryBfr/kIODoJY55e2w5CRvV9jBKwQYPsMMKJi8CGHT/3SL9PQSwMzHabd
         64tNun6ZgD/f6HwoPzyOyxAhMp+JjBDinGYVByE9VvYOC1hMFGb1ClflHwu/JbyoE5H+
         y8yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746884916; x=1747489716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HPNtmFJxQ6qfkaV/7sUcFpQ7Up10ht/uIC/UAoosXBs=;
        b=VTrxTBEHGOoUpw462v7XRuGj0Gglc35MVljdp6+B5UH4ul92S/j4hlCWZPItznV51y
         bDpeEVOsBoFDKWwPrDwUYs0FheUJQYWaxKP1aGe0D9qmsQ+vZ2XiU/SlxU901Y3RUIZj
         md70LvMpw165LF39FUYtIXSkk9PHIBCt0zy9FFAZJrhNI573LyHgawr+MqzT4Kd+0w5v
         MRCJpyyu2pWCwCWrhCNHjs9FOFHVDg8EdAtpJYv4Y3lIlxJlVpM/dWcGHylVcmesr7J3
         siTgAPzIi/mDXo7vGHiGj5hcg64DOjf+vCbDhScV8147X4pav2jmBYJ4naG8whe75c8B
         t0cQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEx3gR38r/kcxLgkG0wdhhbP5hJALJjoutGPNOoDygK5XBhkbeZhZlOab/iNyF0DCbJS9Gx7E=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl4KULYpsJLcKkxqaSqWEn4KXECvL/3czu7605j5tjxQduzXC5
	2uFZUVxHr9ePExL2ITM7P2+ptvQmO/HmhvUWkZuBRyLogqEe1G+D
X-Gm-Gg: ASbGnctlUkoy3QF7aAh9iiZNxTfu0rLKiBXegG+CUSD76kcLClNIqy8ZKJTgaBQEj9h
	ydHpAtKeeEfkUqn+aLE1l6p+gkbezUAxptGKpDZ7zSidvNkfG5Dwct82gMOXOLHsVLVn4LWyhLv
	wzwtfpVh1qgmPHLDQR5FiXOD6cs2DFbm0DMdDXUH02MJpvxIDnPiv99HNb5Bk1LjROlZhnbhc7j
	/0I3k0bV+O6kQOXBUEEwudsvbjK0DsKg713ILNEZ3ZQ9JbNBdap9U/YVnPpN7cic8wful2OCFr9
	yJaeCxFLQKz1uXhNzbgEekOl+X08G3hd0tVOJ27nK8CG9pQJNkz7dGzUQKrms1JYpnkDCVFzzQM
	+meIBwDHIdmptbQ==
X-Google-Smtp-Source: AGHT+IH9EOAr3sj5GMToa8RFMVGWPuFZ626Vwp9kQBaou2wEWvAFIFPcR7SdOshO8pN0E64g87eTdg==
X-Received: by 2002:a05:6a00:138a:b0:73c:3f2e:5df5 with SMTP id d2e1a72fcca58-7423c06f4b4mr9918280b3a.9.1746884915850;
        Sat, 10 May 2025 06:48:35 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([114.253.36.190])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7423773939fsm3360424b3a.62.2025.05.10.06.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 06:48:35 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: tariqt@nvidia.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com,
	irusskikh@marvell.com,
	bharat@chelsio.com,
	ayush.sawal@chelsio.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com
Cc: linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2 3/3] net: stmmac: generate software timestamp just before the doorbell
Date: Sat, 10 May 2025 21:48:12 +0800
Message-Id: <20250510134812.48199-4-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250510134812.48199-1-kerneljasonxing@gmail.com>
References: <20250510134812.48199-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Make sure the call of skb_tx_timestamp is as close as possbile to the
doorbell.

The patch also adjusts the order of setting SKBTX_IN_PROGRESS and
generate software timestamp so that without SOF_TIMESTAMPING_OPT_TX_SWHW
being set the software and hardware timestamps will not appear in the
error queue of socket nearly at the same time (Please see __skb_tstamp_tx()).

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 28b62bd73e23..4446599ba6ee 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4497,8 +4497,6 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (priv->sarc_type)
 		stmmac_set_desc_sarc(priv, first, priv->sarc_type);
 
-	skb_tx_timestamp(skb);
-
 	if (unlikely((skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) &&
 		     priv->hwts_tx_en)) {
 		/* declare that device is doing timestamping */
@@ -4531,6 +4529,7 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 	}
 
 	netdev_tx_sent_queue(netdev_get_tx_queue(dev, queue), skb->len);
+	skb_tx_timestamp(skb);
 
 	stmmac_flush_tx_descriptors(priv, queue);
 	stmmac_tx_timer_arm(priv, queue);
@@ -4774,8 +4773,6 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (priv->sarc_type)
 		stmmac_set_desc_sarc(priv, first, priv->sarc_type);
 
-	skb_tx_timestamp(skb);
-
 	/* Ready to fill the first descriptor and set the OWN bit w/o any
 	 * problems because all the descriptors are actually ready to be
 	 * passed to the DMA engine.
@@ -4822,7 +4819,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 	netdev_tx_sent_queue(netdev_get_tx_queue(dev, queue), skb->len);
 
 	stmmac_enable_dma_transmission(priv, priv->ioaddr, queue);
-
+	skb_tx_timestamp(skb);
 	stmmac_flush_tx_descriptors(priv, queue);
 	stmmac_tx_timer_arm(priv, queue);
 
-- 
2.43.5


