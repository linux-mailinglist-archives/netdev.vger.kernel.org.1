Return-Path: <netdev+bounces-87460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 114F58A32A9
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 17:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 344401C21E0F
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 15:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BE614900F;
	Fri, 12 Apr 2024 15:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="au4W21XD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22148148841
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 15:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712936334; cv=none; b=prIGEry20XAqar04E/5xTmQUDOjtkJF2aVM0rWFHZLUuj0qmNDQ5ziJvC8Z1lKuHFOuU+GfumgJ4ooqGqxm5FfcqWVOO5Du9yDdZ8D7Dr0y4Fht3QFxUZTUfl16sPsc5E03o/AxtXD3pR4FhpyTfrgbBtT3B5K4TES7gqsQpeRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712936334; c=relaxed/simple;
	bh=D70tecQdxEFhN2T90LYAjmlmzEPD00PhK6njTdKkNcg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IEFBbKcv191lsh0soCh4R6cv2RaVrXYwnP6BwWijDipnfNzzzubSUNbAQA9is4/xWASuRaTv2YdNfPUVVyz1+1Y0tHjsP4Ea7RBpnpaOEN3B7WTIlOGMFH4iHhKAoqNmw70zIuTZFA/Ulh1+vIvloMYW/gplcmDBy6/tmxE0WyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=au4W21XD; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-343c7fae6e4so782841f8f.1
        for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 08:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712936331; x=1713541131; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DlychnL65xg4rRD6rFMEjcsL9jG7kDN0jMkphCm2a5k=;
        b=au4W21XDyzU4kJh4/PlpR1xIQ2eQOKouWXn21H1Q60U1g+IH8x5pN+b7XeL+LNoSvq
         irg+ZNVT2goETRziXoq7874Ti8dLLJHfUDeQf/Qa4uUDlBnQwAiJkaQgk5Rcx8BK+rDu
         0bDsWdlJXvJ4ZrLHWbYmjz3gyPeWh0o+BizeIcio1lSksQ/q5gaokAVgD6C2EA1b6L9Q
         QxfsJhrfzfI/2pymBkZcuRSXrhMvCDLfi/o0JujbkdZEKNTLU7NnUYk5FzXeDS9XKKGO
         RHpaYLPhlBv82YIA84b3zqR9ZvD39mKBBBzePUcauSnCKCOBWvq7/rZmtK5ueu/cUjlu
         62qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712936331; x=1713541131;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DlychnL65xg4rRD6rFMEjcsL9jG7kDN0jMkphCm2a5k=;
        b=fttKQtWNT6tNvfK4rIK1RdVqB6bucv85cleoR65fwT2zCEAoaoqlRQljubynz7zLR0
         XNnVFLDc6sYrGFCoP1lEEKZNAswKe0F3YYvKOd5cPPiDhOYaousuMh3SHsXHFGERqmUU
         uswo3n8pTryqhglJEk1ieHEm41gBEcxD8+BwC5gWmaIjJMOEgi84/z2PYry7zy8NktvX
         rnw0Q8N41GvfeJR9qaqnwUHZ0LGRdPwFoNH3DqKuQbUeox5a2AlP5kvi+M4qVnSh02hh
         pppjFbfPCy7ff4Nx4UgllBA95NXHHtjjeGjg0SsrJwqGwtmbCa6P8vEf9skizGxoXavs
         +zZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuH/kwb8SYO4WfRQ4uDtMI0S7+99rYUPZrxRVvm0mNVI9A0afCzy3gULAmfTVENiGeYD4R5niFH0C4ezYY80Ph7Zzfaadz
X-Gm-Message-State: AOJu0YyHgg5BTg1PjXKuQ8boHVOPJcO+CshdqlKWPxu0MMduLl3xoL2v
	5Nnp6XwYOcfYTlQavBn8CBOhxUdikFnFZBuAcVCZ/MgOmu0gTxBaLDnd6UkXvvc=
X-Google-Smtp-Source: AGHT+IFb2+KL5iLIOly5x0hIiJjAVufAzhuUpYpTYTPnK0Gg201imseBOxf7BnR6QWHdfgeK8CMFCA==
X-Received: by 2002:adf:fa8b:0:b0:343:b686:89a0 with SMTP id h11-20020adffa8b000000b00343b68689a0mr1969349wrr.13.1712936331591;
        Fri, 12 Apr 2024 08:38:51 -0700 (PDT)
Received: from [127.0.1.1] ([84.102.31.74])
        by smtp.gmail.com with ESMTPSA id k9-20020adff289000000b0033e45930f35sm4545791wro.6.2024.04.12.08.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 08:38:51 -0700 (PDT)
From: Julien Panis <jpanis@baylibre.com>
Date: Fri, 12 Apr 2024 17:38:33 +0200
Subject: [PATCH net-next v9 2/3] net: ethernet: ti: Add desc_infos member
 to struct k3_cppi_desc_pool
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-am65-cpsw-xdp-basic-v9-2-2c194217e325@baylibre.com>
References: <20240223-am65-cpsw-xdp-basic-v9-0-2c194217e325@baylibre.com>
In-Reply-To: <20240223-am65-cpsw-xdp-basic-v9-0-2c194217e325@baylibre.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Ratheesh Kannoth <rkannoth@marvell.com>, 
 Naveen Mamindlapalli <naveenm@marvell.com>, 
 Jacob Keller <jacob.e.keller@intel.com>
Cc: danishanwar@ti.com, yuehaibing@huawei.com, rogerq@kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, Julien Panis <jpanis@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712936324; l=4285;
 i=jpanis@baylibre.com; s=20230526; h=from:subject:message-id;
 bh=D70tecQdxEFhN2T90LYAjmlmzEPD00PhK6njTdKkNcg=;
 b=3nuWtDIz2tUECi5ze87zSnbefuWdEDPrkEy2/SGn48lAXiiZmrSq3rq+Se67PfmmmSqf5PT6q
 B8987UN2Q6pBRQXgQ2Dn7tnD6yeeM2qV3o19vKvsCGg7rr9+VjD3NgH
X-Developer-Key: i=jpanis@baylibre.com; a=ed25519;
 pk=8eSM4/xkiHWz2M1Cw1U3m2/YfPbsUdEJPCWY3Mh9ekQ=

This patch introduces a member and the related accessors which can be
used to store descriptor specific additional information. This member
can store, for instance, an ID to differentiate a skb TX buffer type
from a xdpf TX buffer type.

Signed-off-by: Julien Panis <jpanis@baylibre.com>
---
 drivers/net/ethernet/ti/k3-cppi-desc-pool.c | 34 ++++++++++++++++++++++++-----
 drivers/net/ethernet/ti/k3-cppi-desc-pool.h |  4 ++++
 2 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/ti/k3-cppi-desc-pool.c b/drivers/net/ethernet/ti/k3-cppi-desc-pool.c
index 414bcac9dcc6..739bae8e11ee 100644
--- a/drivers/net/ethernet/ti/k3-cppi-desc-pool.c
+++ b/drivers/net/ethernet/ti/k3-cppi-desc-pool.c
@@ -22,6 +22,7 @@ struct k3_cppi_desc_pool {
 	size_t			mem_size;
 	size_t			num_desc;
 	struct gen_pool		*gen_pool;
+	void			**desc_infos;
 };
 
 void k3_cppi_desc_pool_destroy(struct k3_cppi_desc_pool *pool)
@@ -37,7 +38,11 @@ void k3_cppi_desc_pool_destroy(struct k3_cppi_desc_pool *pool)
 		dma_free_coherent(pool->dev, pool->mem_size, pool->cpumem,
 				  pool->dma_addr);
 
+	kfree(pool->desc_infos);
+
 	gen_pool_destroy(pool->gen_pool);	/* frees pool->name */
+
+	kfree(pool);
 }
 EXPORT_SYMBOL_GPL(k3_cppi_desc_pool_destroy);
 
@@ -50,7 +55,7 @@ k3_cppi_desc_pool_create_name(struct device *dev, size_t size,
 	const char *pool_name = NULL;
 	int ret = -ENOMEM;
 
-	pool = devm_kzalloc(dev, sizeof(*pool), GFP_KERNEL);
+	pool = kzalloc(sizeof(*pool), GFP_KERNEL);
 	if (!pool)
 		return ERR_PTR(ret);
 
@@ -62,18 +67,21 @@ k3_cppi_desc_pool_create_name(struct device *dev, size_t size,
 	pool_name = kstrdup_const(name ? name : dev_name(pool->dev),
 				  GFP_KERNEL);
 	if (!pool_name)
-		return ERR_PTR(-ENOMEM);
+		goto gen_pool_create_fail;
 
 	pool->gen_pool = gen_pool_create(ilog2(pool->desc_size), -1);
 	if (!pool->gen_pool) {
-		ret = -ENOMEM;
-		dev_err(pool->dev, "pool create failed %d\n", ret);
 		kfree_const(pool_name);
 		goto gen_pool_create_fail;
 	}
 
 	pool->gen_pool->name = pool_name;
 
+	pool->desc_infos = kcalloc(pool->num_desc,
+				   sizeof(*pool->desc_infos), GFP_KERNEL);
+	if (!pool->desc_infos)
+		goto gen_pool_desc_infos_alloc_fail;
+
 	pool->cpumem = dma_alloc_coherent(pool->dev, pool->mem_size,
 					  &pool->dma_addr, GFP_KERNEL);
 
@@ -94,9 +102,11 @@ k3_cppi_desc_pool_create_name(struct device *dev, size_t size,
 	dma_free_coherent(pool->dev, pool->mem_size, pool->cpumem,
 			  pool->dma_addr);
 dma_alloc_fail:
+	kfree(pool->desc_infos);
+gen_pool_desc_infos_alloc_fail:
 	gen_pool_destroy(pool->gen_pool);	/* frees pool->name */
 gen_pool_create_fail:
-	devm_kfree(pool->dev, pool);
+	kfree(pool);
 	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(k3_cppi_desc_pool_create_name);
@@ -144,5 +154,19 @@ void *k3_cppi_desc_pool_cpuaddr(const struct k3_cppi_desc_pool *pool)
 }
 EXPORT_SYMBOL_GPL(k3_cppi_desc_pool_cpuaddr);
 
+void k3_cppi_desc_pool_desc_info_set(struct k3_cppi_desc_pool *pool,
+				     int desc_idx, void *info)
+{
+	pool->desc_infos[desc_idx] = info;
+}
+EXPORT_SYMBOL_GPL(k3_cppi_desc_pool_desc_info_set);
+
+void *k3_cppi_desc_pool_desc_info(const struct k3_cppi_desc_pool *pool,
+				  int desc_idx)
+{
+	return pool->desc_infos[desc_idx];
+}
+EXPORT_SYMBOL_GPL(k3_cppi_desc_pool_desc_info);
+
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("TI K3 CPPI5 descriptors pool API");
diff --git a/drivers/net/ethernet/ti/k3-cppi-desc-pool.h b/drivers/net/ethernet/ti/k3-cppi-desc-pool.h
index 3c6aed0bed71..851d352b338b 100644
--- a/drivers/net/ethernet/ti/k3-cppi-desc-pool.h
+++ b/drivers/net/ethernet/ti/k3-cppi-desc-pool.h
@@ -28,5 +28,9 @@ void k3_cppi_desc_pool_free(struct k3_cppi_desc_pool *pool, void *addr);
 size_t k3_cppi_desc_pool_avail(struct k3_cppi_desc_pool *pool);
 size_t k3_cppi_desc_pool_desc_size(const struct k3_cppi_desc_pool *pool);
 void *k3_cppi_desc_pool_cpuaddr(const struct k3_cppi_desc_pool *pool);
+void k3_cppi_desc_pool_desc_info_set(struct k3_cppi_desc_pool *pool,
+				     int desc_idx, void *info);
+void *k3_cppi_desc_pool_desc_info(const struct k3_cppi_desc_pool *pool,
+				  int desc_idx);
 
 #endif /* K3_CPPI_DESC_POOL_H_ */

-- 
2.37.3


