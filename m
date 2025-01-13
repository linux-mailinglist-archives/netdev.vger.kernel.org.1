Return-Path: <netdev+bounces-157760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B277A0B951
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 15:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67B743A64A5
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 14:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D33C23ED73;
	Mon, 13 Jan 2025 14:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exrPIoy5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75731CAA80;
	Mon, 13 Jan 2025 14:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736778064; cv=none; b=on4UP9Dmlz0uZqIFHixlCWCqIfVUYQnxwnAw4FepAWc1DG7dB9IcgRWYjeMkpmWt0VFLH8UVuzh0YHInFj2OFexTYrHZYVkpC+ii7lB8xpt83N6rKQZUOt9PV/8AnRMwSDRpCVg2o8IjR6XAZu9hFBjxxi0t4dj3i5PC4qSa9mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736778064; c=relaxed/simple;
	bh=/b1oafs5v3Q21RTlmWKOsnPyCGjsECPHxzk/z9aCqsI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SL/uq6zjYO43hqe+JGlp64tMPjMMdaKZbQBiusxpqLN2b95O6xur0W2Wai44R0Rmn5AlX/bUPZt1nUfxnVNoUFKD7WKPbNcYXObWoKmHz2N1zqR8jrpAb6L69lUlhcXDQM7OaZMU73I8iyX35BUUtoQ3tY5xQKXzn5d4UgT9QiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=exrPIoy5; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21636268e43so101022245ad.2;
        Mon, 13 Jan 2025 06:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736778061; x=1737382861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YMPRQoz16EyCK3xxuYYjiNmaFFaTgtlHtG3fh6pk8TQ=;
        b=exrPIoy5KwB0pv9wvAtslZz748DclA9Vy50jo925ybnOOWCVYIdAynt93tuigpd9Fr
         yRMCkA5+X/yqtL5NULoXWMMukjcy1rNYURBZMzAS+7jhDME+tcNo9/OdMbyoFfFTNi+H
         LE/9z+yS0EPAodUn+OVq17Th8P5OGQWlrI3OnO51cicQySMV1IHIcgz40F4WYfM6TwFl
         U9b/7WZROGfouPaq4Yrp6iABplzPk0EDXsPnkZIwzNZUhMGEn3AJ94vsHgd5L0ZCDApB
         d+hHkSQcErgRxM9gLJ68c771+9e+rwG/7/BSQqhldA7u75+/2rdr6Gtcsp60nVJyUwsa
         UCGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736778061; x=1737382861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YMPRQoz16EyCK3xxuYYjiNmaFFaTgtlHtG3fh6pk8TQ=;
        b=krI6KuoJYVTEwwdBBQILbi1/TLKqDe+N+T354Iyslm3ifKDqClZa2/CYo7rnTyE5z2
         WXfp8hz1q49zkHHukQAiyV5+zGdrcH8q0DRLK2EU2UEwbdowOIergd4XKP82X3Mt3yEi
         SQEwCpmy6cWJvkGEfHzCLmk1Y5YiAAR1pU/THqGbh0uq4rvrRjhLaHOwsBVW2f8oO3Ic
         cYJxp12XXQ9EX2KWDpLKJya4TKRcZhQ3bwi+Q0ywojgOCHlJVFezFCnnJVDzO1oE7mw9
         oHwf9VxBypw8Xj344o4rbj6MEDw63l2qwbNQRFMQPvO5v/AwUfx5o9JkdkhZUzxOnEl/
         QpVw==
X-Forwarded-Encrypted: i=1; AJvYcCU3u84s+voShpExgPL1/ZlboF8liVrEROkMc7y4JjMmlZk6Ge9MMvTfDJZ+3iz+2P7NYbkg1La7vf0Xi3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA4iyL50R3d49V9dfqY0vJJk1rqou/nkLQoeU5AMt7CsFYKHuN
	YfNfsoSC9zDjxshSoezfCSo77TvGpDmkdJMxzSIXGpp3zefAt05t1m0JjQ==
X-Gm-Gg: ASbGncvPZQKJm5OEwJdcnRjviceLY2jSEC5vKK5bGjqu1kThUi5SmqkXdsqR7p6GQNS
	V/g86/1q7L73Ari706o5avKANfrZJpdXSKTxkJXVzCuygAUj5/sbzUEE2YEFhm1/BvL0ai7Y4/e
	SVVcvIiwbgvr1JgZIcRUaQBaWzuJ4/zpxhv2+RrmYGA5Yf6SdWizUOB/xBge3/mLm1oIA/oq19o
	uC6czALs2HF6HBoGex5mzKrSRdQ6wHtCBEKl5ekm/cBmlu2lcb3WrXaVxDpNpsgDVCRgw==
X-Google-Smtp-Source: AGHT+IEzC0EK5taqL22BOdLKvphG994lgupCqXrHRE6t3LRIiNlReqX+BVov6VJfmVVXuiJkjK9M/A==
X-Received: by 2002:a05:6a20:7491:b0:1e1:a06b:375a with SMTP id adf61e73a8af0-1e88d0ddc82mr38181731637.35.1736778061055;
        Mon, 13 Jan 2025 06:21:01 -0800 (PST)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-72d4067f0d1sm6089222b3a.136.2025.01.13.06.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 06:21:00 -0800 (PST)
From: Furong Xu <0x1207@gmail.com>
To: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	xfr@outlook.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v2 2/3] net: stmmac: Set page_pool_params.max_len to a precise size
Date: Mon, 13 Jan 2025 22:20:30 +0800
Message-Id: <3f0cad344d45bb15957e20059f9cda44d6369419.1736777576.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1736777576.git.0x1207@gmail.com>
References: <cover.1736777576.git.0x1207@gmail.com>
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
index 6ec7bc61df9b..ca340fd8c937 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2048,7 +2048,7 @@ static int __alloc_dma_rx_desc_resources(struct stmmac_priv *priv,
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


