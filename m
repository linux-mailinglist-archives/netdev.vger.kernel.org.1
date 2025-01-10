Return-Path: <netdev+bounces-157071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF097A08D20
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 10:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 532633A99D2
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 09:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB61B20B21B;
	Fri, 10 Jan 2025 09:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RAQ0A+Se"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2686A20ADCA;
	Fri, 10 Jan 2025 09:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736502863; cv=none; b=Li89YAr34tsbc55wZMscx4hVIcUWlgESuPpSDutn+mYlQfrip+iukgzzl+yeWS/riFVJbUv+CO7mlMAxnH3Y0Ds+tqHBmmPSiH4MrWAeaAazIzH9NG6CORPEJ8/XXr+h/fqfsLoOjkJEZ8FSjnCFs1jKgS9HMgwQE41iwEZeVPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736502863; c=relaxed/simple;
	bh=MDiHtDtCxAKrxu2Y8Tbr5jhnAYSpC+h1/eBK8wy37us=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AMlgtSzQ9QGFk9MlnnRzfQeXlCARvUsHqT9L0sNOJ9J+RFY7+fckSo+iS0dfwLLM3oHDah+jEVpRP0+yHNroCSyURM8WqgPSiNyAVnMrjZmskAHkpUOqnGkIgmijbqwqT4123WiGbYKfiWl7DnCnBC6BvGFIqW1vx71mfL8Bixo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RAQ0A+Se; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2165448243fso34107385ad.1;
        Fri, 10 Jan 2025 01:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736502861; x=1737107661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ion4rvgZVuG6XSBAcwwShmk186Mw8JOkfuQ4D1b8sOM=;
        b=RAQ0A+SeHPbm03SVc5K/8FQB+wiX+X/5vUqwYdFJAaMIKE/l5qy5l33Mjsc7ztN3XF
         o9IOFmqA580cq/5sVmVVMDuiANxWxgVlhGg4IykEFqgAqKsVstYwGskICSxY+8c57qGp
         krKGRYcqwOAgWK8tqJevWBQX1dRpuE8v1wziH8Gvlg83gYHXwF5czZkA/TDswfiUpwTu
         5jeOBv56gBKn3r3EC9BIldR/jl4jMmqtiOnfgGI86bwqmcBqPflrjEaLcpFjPhB/a7g/
         tpx+rnYWqxv7ygu3toorxXnbQMmV4ir52UpdkbNmkqJaCAQei0DjAmkS7H0ZBKREl8PA
         qOfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736502861; x=1737107661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ion4rvgZVuG6XSBAcwwShmk186Mw8JOkfuQ4D1b8sOM=;
        b=ddNr8BO9e4a7DcGN7DfRafk+kOL8obIuV/TJev5QEZiVMXx+sN2ZiB244vYnbtO1X5
         EnT2EM8m7O6OvMxEZIeB74t4QUKHahOP2v5+L6BmpxRkm4W9AbUuAEXqh9tD5gyGYPfx
         vJhUA7NDu0mVCHH/qLXs7hbJTep3Qb6Eg69Lnrfwkw7x8yl948ct0WYtgTymmSyOed57
         foJc6D8BUOV8FyCl1BNd1rE5zlxKOnTSq+1/pOLs7NnjmpgdN+6nXflh0BRfBO4hRJmP
         sBbjEOu/YZXcQAnGWQbr8mi7hoNXLxjx+wCtpu2qMQnYpHyVHeLZTtRfpc3cqzc4RSaf
         mnlw==
X-Forwarded-Encrypted: i=1; AJvYcCWX0FRxlhhh7Ijbf/T33Z3LoCA0wqN4FLnpn5lyW6R2/COh9bce1xJtzI2srRrFGI5xvtRu5VEOY/laJYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbtAX6XeecxrApa/t5zSyLY5f99Tg8Gp3JqAQ0gxUcAuKSb349
	amvuj7Y7sN8bR1KE6VxnKWevBLGVIc1/OlUtBFd6xuhVAgB0l9RqqqKT4g==
X-Gm-Gg: ASbGncuEstLfvAY7PU0i2MM6+U5SxAt/iYLAElyC6RCrCwDzxYgDjl6O8WK2aj3DJWd
	tIyqU75q8ZAQ52PnFlF0Y7F/Eu+H1nu0GMRYBy7v684bF24K+j+yllJojYWDAyyK5gO3pMd800Q
	XzHq0RY1vf9xYdKPNl/YSwY3GFx/W2Fo0y6rizmWzbP+KX1eD1TdfZJBUaI6sdC+NuRldkmRWpR
	amC4NboIrJkEqHZL+GLapcLSYmvqoP6qRL2ylQ/hPb6Enl/5nJ9CINLJnldWEsFQQdTSw==
X-Google-Smtp-Source: AGHT+IFujh/KkTTFRhKx5MyKUB6ge9k+IJCqCvJTkEaAIWn/8HcGt05DziMhWszOmGBiewczqCOY1A==
X-Received: by 2002:a05:6a21:339b:b0:1e8:bd4e:c330 with SMTP id adf61e73a8af0-1e8bd4ec502mr734199637.30.1736502861030;
        Fri, 10 Jan 2025 01:54:21 -0800 (PST)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-72d4069217dsm1186183b3a.151.2025.01.10.01.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 01:54:20 -0800 (PST)
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
Subject: [PATCH net-next v1 3/3] net: stmmac: Optimize cache prefetch in RX path
Date: Fri, 10 Jan 2025 17:53:59 +0800
Message-Id: <b992690bf7197e4b967ed9f7a0422edae50129f2.1736500685.git.0x1207@gmail.com>
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

Current code prefetches cache lines for the received frame first, and
then dma_sync_single_for_cpu() against this frame, this is wrong.
Cache prefetch should be triggered after dma_sync_single_for_cpu().

This patch brings ~2.8% driver performance improvement in a TCP RX
throughput test with iPerf tool on a single isolated Cortex-A65 CPU
core, 2.84 Gbits/sec increased to 2.92 Gbits/sec.

Signed-off-by: Furong Xu <0x1207@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index c1aeaec53b4c..1b4e8b035b1a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5497,10 +5497,6 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 
 		/* Buffer is good. Go on. */
 
-		prefetch(page_address(buf->page) + buf->page_offset);
-		if (buf->sec_page)
-			prefetch(page_address(buf->sec_page));
-
 		buf1_len = stmmac_rx_buf1_len(priv, p, status, len);
 		len += buf1_len;
 		buf2_len = stmmac_rx_buf2_len(priv, p, status, len);
@@ -5522,6 +5518,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 
 			dma_sync_single_for_cpu(priv->device, buf->addr,
 						buf1_len, dma_dir);
+			prefetch(page_address(buf->page) + buf->page_offset);
 
 			xdp_init_buff(&ctx.xdp, buf_sz, &rx_q->xdp_rxq);
 			xdp_prepare_buff(&ctx.xdp, page_address(buf->page),
@@ -5596,6 +5593,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		} else if (buf1_len) {
 			dma_sync_single_for_cpu(priv->device, buf->addr,
 						buf1_len, dma_dir);
+			prefetch(page_address(buf->page) + buf->page_offset);
 			skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
 					buf->page, buf->page_offset, buf1_len,
 					priv->dma_conf.dma_buf_sz);
@@ -5608,6 +5606,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		if (buf2_len) {
 			dma_sync_single_for_cpu(priv->device, buf->sec_addr,
 						buf2_len, dma_dir);
+			prefetch(page_address(buf->sec_page));
 			skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
 					buf->sec_page, 0, buf2_len,
 					priv->dma_conf.dma_buf_sz);
-- 
2.34.1


