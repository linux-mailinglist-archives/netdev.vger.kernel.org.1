Return-Path: <netdev+bounces-157069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68198A08D08
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 10:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC51D1884C55
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 09:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A1B20ADEE;
	Fri, 10 Jan 2025 09:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RU3Zy6XM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5C620969D;
	Fri, 10 Jan 2025 09:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736502855; cv=none; b=a+1FTSZn2zCGIRF3OWlzhh8A3kHo4mcIyKZNtWukYWBObd1G3heE6Ktx47fQAq7msTHAqKTbx4Z5nbzm6n9cH/g1tD96yv2eY4Bo5eVyo9Es3LTpVD6c5X/sKf9wxW8GQvvRuDHJufCz8d/yYovCrUIoGbL+P2sAEO8BlY9I4IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736502855; c=relaxed/simple;
	bh=U+eiV0d/i5OMqn8InIF1E943YQZtjb87eMZss1sSYJo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LIX7OlE19iSMwLBmxo3giKeqeutq/2BF+WRIl8FUBGRYxj/X64p/ghStmOG/IxLZDLATkZxrVyW6G2R03oHZ64b01kv4V6WLJQ/IkpMtLgKJIYiaPGk056KJ/3Io7gEtAZJiJD05OCyDzgxcYQ9GILLo2WpLDAKU3AUhxXRAUKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RU3Zy6XM; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21661be2c2dso28682825ad.1;
        Fri, 10 Jan 2025 01:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736502852; x=1737107652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SxF3XO1B6LZpy7SsHuT7EE8l6m2FcLCgWD0toKoIsSE=;
        b=RU3Zy6XMQV6i/nzTU9/q0sLMg3ju1h54L0NWFA//UqnHfxRw4bn0ppwx6EVLlLvfZ+
         QBS5jrIWWGtffFSgUUMnUtJX/DbFY9ZlTvlrKnn6ocvpr4GKajCJvzR40zcORg5rI1J1
         NYNaPBStEVJBpo7PYwRhcALi3YOPuJqxeAkDVgHMmWlg+M9Av96Sqg9qnHkSCDoEPGpx
         yhrHWo03W9cwsuT5GejORN1SpYTCJtIbrPGyCM/n5iUtbM85odEtJiprbLyWzZcOBVlw
         2buL5Pk49BI29/63XjmVWvR8N65UOkF4PyJhTNjyEO7PEBx3kj6Kt+1m+K1KfVRZVzc9
         zJpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736502852; x=1737107652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SxF3XO1B6LZpy7SsHuT7EE8l6m2FcLCgWD0toKoIsSE=;
        b=F5zfbQjFVYZEyYEKbjaD0OjEdDhx4thVv6XG9WHNZNHoYdCfKCPxg6tWkZFqcaoXmO
         tq1+ZGD2cvaQS3MawSosFezz4VAb8b1OYSxdCe2H8BJ/7koIf5ZXNUPM1H9YB8J7AycZ
         +6gZVpZfMRb99y5WUm2oK06+5DgVENNxGobiXM9Vm8IOn2JO+W/DBFnjlwOjd7ObNUpC
         1HcLSOXo2iBQ/hhPa1hpIstdsmeWuZUJ4wmTsOxKWvgb73RVJHh8rnzPwCBCaRYnctR7
         iN1iz7oRF4uXWYcLlfSEB3wjCKQHziKQs6kIUlirdTnRQwZYdSOtpSrRmADAaQlcrlOL
         IBzg==
X-Forwarded-Encrypted: i=1; AJvYcCU9hByJsWACLVtRrHDOZEstqMOHn+HCPX55mDVpj9aQi1LxHe9K/oSYHWEyvt1+K9g8kjV17vJJhp8/mnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaGhEYbi5Tt3CU5UjsRK32cHdnIFrKI5xhehbKlrEnEZU67Dt1
	afhQBG6R6IrpbCAYjT+Asbh5GWZHnXVz8leKwLCCAKjHhZti1M+z9/bj/Q==
X-Gm-Gg: ASbGncuBLg5WLaiTN09dUYv1/Qn22a06uktiPKUBQC7uILmNXHwG6TcLcCASrFhzWMf
	Fh+1IvXKG2URo0bzZ1ayGxEXvh42yaNYNZjZL47veBDwsfDFHdstf8QAQl4p8y8w1tD4+cvPHJi
	xE1r5r9hlnSwZWjXyr9Ku+cIMWSrxV3CxoWjcexRMA/4YWbAh1nn7lv+OMzFZ9eNfy8LK1Nm7IS
	EnCf1/L15lRvnDJRA/dGCJO3OJaEgejyuKLbX1/knAV+AWXnR9KNoh400kda6GaEuRZgA==
X-Google-Smtp-Source: AGHT+IFkCU9VmZRMCAwHW5xP2aexBm6vAYxF+cTLnmmRPs6gpn7mMaFELbrG88Frm/BNN1k4tXE+QA==
X-Received: by 2002:a05:6a00:1404:b0:725:d9b6:3958 with SMTP id d2e1a72fcca58-72d21f471c5mr15157812b3a.14.1736502852468;
        Fri, 10 Jan 2025 01:54:12 -0800 (PST)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-72d4069217dsm1186183b3a.151.2025.01.10.01.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 01:54:12 -0800 (PST)
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
Subject: [PATCH net-next v1 1/3] net: stmmac: Switch to zero-copy in non-XDP RX path
Date: Fri, 10 Jan 2025 17:53:57 +0800
Message-Id: <600c76e88b6510f6a4635401ec1e224b3bbb76ec.1736500685.git.0x1207@gmail.com>
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

Avoid memcpy in non-XDP RX path by marking all allocated SKBs to
be recycled in the upper network stack.

This patch brings ~11.5% driver performance improvement in a TCP RX
throughput test with iPerf tool on a single isolated Cortex-A65 CPU
core, from 2.18 Gbits/sec increased to 2.43 Gbits/sec.

Signed-off-by: Furong Xu <0x1207@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  1 +
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 23 +++++++++++--------
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 548b28fed9b6..5c39292313de 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -126,6 +126,7 @@ struct stmmac_rx_queue {
 	unsigned int cur_rx;
 	unsigned int dirty_rx;
 	unsigned int buf_alloc_num;
+	unsigned int napi_skb_frag_size;
 	dma_addr_t dma_rx_phy;
 	u32 rx_tail_addr;
 	unsigned int state_saved;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 038df1b2bb58..43125a6f8f6b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1320,7 +1320,7 @@ static unsigned int stmmac_rx_offset(struct stmmac_priv *priv)
 	if (stmmac_xdp_is_enabled(priv))
 		return XDP_PACKET_HEADROOM;
 
-	return 0;
+	return NET_SKB_PAD;
 }
 
 static int stmmac_set_bfsize(int mtu, int bufsize)
@@ -2019,17 +2019,21 @@ static int __alloc_dma_rx_desc_resources(struct stmmac_priv *priv,
 	struct stmmac_channel *ch = &priv->channel[queue];
 	bool xdp_prog = stmmac_xdp_is_enabled(priv);
 	struct page_pool_params pp_params = { 0 };
-	unsigned int num_pages;
+	unsigned int dma_buf_sz_pad, num_pages;
 	unsigned int napi_id;
 	int ret;
 
+	dma_buf_sz_pad = stmmac_rx_offset(priv) + dma_conf->dma_buf_sz +
+			 SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+	num_pages = DIV_ROUND_UP(dma_buf_sz_pad, PAGE_SIZE);
+
 	rx_q->queue_index = queue;
 	rx_q->priv_data = priv;
+	rx_q->napi_skb_frag_size = num_pages * PAGE_SIZE;
 
 	pp_params.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
 	pp_params.pool_size = dma_conf->dma_rx_size;
-	num_pages = DIV_ROUND_UP(dma_conf->dma_buf_sz, PAGE_SIZE);
-	pp_params.order = ilog2(num_pages);
+	pp_params.order = order_base_2(num_pages);
 	pp_params.nid = dev_to_node(priv->device);
 	pp_params.dev = priv->device;
 	pp_params.dma_dir = xdp_prog ? DMA_BIDIRECTIONAL : DMA_FROM_DEVICE;
@@ -5574,19 +5578,20 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 			/* XDP program may expand or reduce tail */
 			buf1_len = ctx.xdp.data_end - ctx.xdp.data;
 
-			skb = napi_alloc_skb(&ch->rx_napi, buf1_len);
+			skb = napi_build_skb(page_address(buf->page),
+					     rx_q->napi_skb_frag_size);
 			if (!skb) {
+				page_pool_recycle_direct(rx_q->page_pool,
+							 buf->page);
 				rx_dropped++;
 				count++;
 				goto drain_data;
 			}
 
 			/* XDP program may adjust header */
-			skb_copy_to_linear_data(skb, ctx.xdp.data, buf1_len);
+			skb_reserve(skb, ctx.xdp.data - ctx.xdp.data_hard_start);
 			skb_put(skb, buf1_len);
-
-			/* Data payload copied into SKB, page ready for recycle */
-			page_pool_recycle_direct(rx_q->page_pool, buf->page);
+			skb_mark_for_recycle(skb);
 			buf->page = NULL;
 		} else if (buf1_len) {
 			dma_sync_single_for_cpu(priv->device, buf->addr,
-- 
2.34.1


