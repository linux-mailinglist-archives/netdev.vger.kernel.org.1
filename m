Return-Path: <netdev+bounces-228803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C7DBD40E4
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 17:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69A3C3E0418
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 15:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A77B30C620;
	Mon, 13 Oct 2025 14:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vqk0YYK4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B5E3148A7
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 14:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367248; cv=none; b=N19gKZPmh7A27fXV1WkL1XaEDwXZSZjYjOXx3h7XLZF8QnAfXR+JX58xJtuCUBa30y5HDmcq8acsyWO5kUij3wp9DP90DSXkLz+wJHjWWeINnz5lpmGNDWeX8GGish2kvnVWRMfxy3weOA8UYs+uOCCcahPIRvAhCdjilDl1wog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367248; c=relaxed/simple;
	bh=UN20xXoo/DIsknQaKnQS3nE5pqQGdfuGllMStEKfLhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s+3JZDFlyRh6sWcOd/5EdSpJYuHQYiv/dg8c82OvNwoTvX3yBklk5hHqpVxCVbil46nMAU0hFzFhjvJKDEaDpYL3IIlhSQM9jHyWC1wTg7jfiZQO/oupR3qly3276eCtS3zmWhQWlAJtFcwPBJedoI7lhcXIKSwfjlJPYZ/Jmro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vqk0YYK4; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e37d10ed2so39819375e9.2
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 07:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760367243; x=1760972043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kBVbea7flwKQsaU79NLWmhrt2gwy8JKbrcaG5BbSXQs=;
        b=Vqk0YYK4D39Lu3ifEgEsEVQoPaxkf9bJepAlOQBM79Vx3AxqTiUZmN0owgmjsEjzOG
         +EUXHJdOAb3fDTEloWsDBtBHUQDqOgTS4KrsQcwZ6AfcJ3pew8XTxJkywrhFfJupikPo
         gG6plI4kX8Stj5BPTj3JMNGg5bISxNAchPeDHn4pwm0tpwVcG0gLIPHKltmbZ+zvvQKv
         mgA/VlnG5okocDEzcM2C0Co+BFPDv25CGel0/VNvAtx038t3jqqACW8B8oevVONulD4+
         9NOxAE+P3JjJxpheoXkxJIKweAEnkxYtPSj43uf0lrtZUkcmIRh/utLnFyV1YR9SxEra
         RwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760367243; x=1760972043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kBVbea7flwKQsaU79NLWmhrt2gwy8JKbrcaG5BbSXQs=;
        b=m7rKqoZ2znsiMNa2RpX1X3aYQZXyIqdoZbYEo0l4DnLg5i0vDIAMXsKIs/6pS5itvW
         DN+yOoJg5osFGOYhy1AgBgaQJVQ4i8RnYcMaxKqPy+PzO7PKwWvf0r4tBhMaiWCVKvwe
         eQWbtyP1Up0WR/U5hTaokSU9If7Q/XdtgF7S0v8pRFgBOV9QJXHAHo/GuG2E/+WAJBL7
         TxF8AU0R01YgwbLA1B7iUR3qS/FROwgScwato5GOCS8QX7SKaTMq9541NjsJgATB2D43
         jkrXWZQr+JLM5TxAs8y7MomUl3A8LJR8FIYd54tYQDFY0sR5js30/F+f7VsrCME8hRct
         hU7w==
X-Gm-Message-State: AOJu0YwM3QwuujAjfcE84TElPCAkkFfhATpb/aQYqtyZ/GW2RKZr9HGZ
	rPF65E8PXENSls1YdUtkEdL9VJDpGi418lmCXhWefg69LPH7BpTCn3nTLX4jZiQj
X-Gm-Gg: ASbGnctQ5jOskxJCb1xrSURvQ5RZIKSVf/WZfu4sqrZ6ckxhd5AsqpuPSJmdxp1WTOw
	VqgaiLtB16GMkk8WkAyjwl++TbJ90S05+4CWERzhN8gj5QSKm6IwG7jzMO3iq2P2PERJGN2fcbi
	/LDoYoDcTGWf+o5FlEGjpnkOCxm60DuyJMtzIBQsm7Gi8UcgB3c8yq8YLJlIJGqyI2MXhKTahVR
	YRbyJDAXyGrGyaA2D8Bxc7fZQg7msL/4X7/fFXiMSXmARn5kDSrATCTeaj4D2H+LuVaW6bKZgW+
	H9VziJd6urSt7PuicicpomPEeLjd8xM26ytyTYOL/yyFy018OL0iaNiepAuKDqT0eW9gBc1ZhH+
	6ArCsV50hwPGEVzOnKfXlSOni
X-Google-Smtp-Source: AGHT+IGvZad4w3tGfNyelo8jRaGthiTAOmBgbASb/CfTYlM5+kxTUyX0ReE6Y+6587qOM/YD4IdmEg==
X-Received: by 2002:a05:600c:1d1b:b0:46f:b32e:4f3e with SMTP id 5b1f17b1804b1-46fb32e4fa5mr121333895e9.37.1760367243089;
        Mon, 13 Oct 2025 07:54:03 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:eb09])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e0e70sm18641085f8f.40.2025.10.13.07.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 07:54:02 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Jian Shen <shenjian15@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	kernel-team@meta.com,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Joe Damato <joe@dama.to>,
	David Wei <dw@davidwei.uk>,
	Willem de Bruijn <willemb@google.com>,
	Mina Almasry <almasrymina@google.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH net-next v4 22/24] eth: bnxt: support per queue configuration of rx-buf-len
Date: Mon, 13 Oct 2025 15:54:24 +0100
Message-ID: <29f1f23b21eb1de0920aa912bcbefc6312160102.1760364551.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1760364551.git.asml.silence@gmail.com>
References: <cover.1760364551.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

Now that the rx_buf_len is stored and validated per queue allow
it being set differently for different queues. Instead of copying
the device setting for each queue ask the core for the config
via netdev_queue_config().

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index ea95a06ae62b..a734b18e47c4 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4320,6 +4320,7 @@ static void bnxt_init_ring_struct(struct bnxt *bp)
 
 	for (i = 0; i < bp->cp_nr_rings; i++) {
 		struct bnxt_napi *bnapi = bp->bnapi[i];
+		struct netdev_queue_config qcfg;
 		struct bnxt_ring_mem_info *rmem;
 		struct bnxt_cp_ring_info *cpr;
 		struct bnxt_rx_ring_info *rxr;
@@ -4342,7 +4343,8 @@ static void bnxt_init_ring_struct(struct bnxt *bp)
 		if (!rxr)
 			goto skip_rx;
 
-		rxr->rx_page_size = bp->rx_page_size;
+		netdev_queue_config(bp->dev, i,	&qcfg);
+		rxr->rx_page_size = qcfg.rx_buf_len;
 
 		ring = &rxr->rx_ring_struct;
 		rmem = &ring->ring_mem;
@@ -15928,6 +15930,7 @@ static int bnxt_queue_mem_alloc(struct net_device *dev,
 	clone->rx_agg_prod = 0;
 	clone->rx_sw_agg_prod = 0;
 	clone->rx_next_cons = 0;
+	clone->rx_page_size = qcfg->rx_buf_len;
 	clone->need_head_pool = false;
 
 	rc = bnxt_alloc_rx_page_pool(bp, clone, rxr->page_pool->p.nid);
@@ -16032,6 +16035,8 @@ static void bnxt_copy_rx_ring(struct bnxt *bp,
 	src_ring = &src->rx_ring_struct;
 	src_rmem = &src_ring->ring_mem;
 
+	dst->rx_page_size = src->rx_page_size;
+
 	WARN_ON(dst_rmem->nr_pages != src_rmem->nr_pages);
 	WARN_ON(dst_rmem->page_size != src_rmem->page_size);
 	WARN_ON(dst_rmem->flags != src_rmem->flags);
@@ -16239,6 +16244,7 @@ bnxt_queue_cfg_defaults(struct net_device *dev, int idx,
 }
 
 static const struct netdev_queue_mgmt_ops bnxt_queue_mgmt_ops = {
+	.supported_ring_params	= ETHTOOL_RING_USE_RX_BUF_LEN,
 	.ndo_queue_mem_size	= sizeof(struct bnxt_rx_ring_info),
 
 	.ndo_queue_cfg_defaults	= bnxt_queue_cfg_defaults,
-- 
2.49.0


