Return-Path: <netdev+bounces-83950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7225189506C
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 12:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA785B259DD
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 10:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4108484FC3;
	Tue,  2 Apr 2024 10:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qn4PmMW3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556B75D749
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 10:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712054132; cv=none; b=qsFOj10+tKbT1eOfivnDBxVADdKBo1ASOh/ebfS/7eUcOQ270mzSxdVJ0WNtVZoGjunHgQSUGDzdG+aoOx2A6xixBeG4+pMxCr7EakjU9CpZcbMx3z02/LTPx9PyML/zc7ae18cyMPSOD6Car5DG/oJfKWhkoyn5KiaXDyp70EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712054132; c=relaxed/simple;
	bh=JqK9X2irpyaetN9XKh1gA7fVuUNk/TXTEORE3XbD6OA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JXyjgZFPvqbkYWcWK/hUEiAkc0k5U+igzojBuXvjt12kS0Flhz7p4V7mO/ZJCkFeiSrfnfS+i6woq96yFY3wNMwhLhQBHgORVCZC67YcOvd517uCr7Amjqs8JPf/TNqmlmmU0BQhnblXV2mSE8WQjT0H3EyFxiiNkIsun+gO5wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=qn4PmMW3; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3436b096690so305455f8f.1
        for <netdev@vger.kernel.org>; Tue, 02 Apr 2024 03:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712054129; x=1712658929; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=McEKzkmjcf11I9OhkP/1LlQGEjlZMSP7VYzBPCvWmZI=;
        b=qn4PmMW3ZtsuePMH0p1NR7ic/57c82mFlHV4/U2XjytW5SdLPEkrTCKJEMaAGeKfoC
         rgkwN4vp76pZEOvIZDx/rR0Eu7O5jaXr9R63l8tBXrbGGSbhd4F1ecTUxDJ6XTmVmXOl
         K7Lvf1krrjW8CEGq+rNLcumhUdjoARJcaxkn7xJZyqO2wdQXtKNJ30yeeX97anjGOSPw
         pkEnYDz6OrcdfUiiPyBUMQBYBz5twGA80Y2GyfjkJkjGgara4+9pcliJLcKq8cHEl9V/
         I3bVpYkH+PceeOQ89momXeGTjGx78al38uFwf8AlBO/IWhjsBh9BP1hBjtSdYhKYus2S
         vDog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712054129; x=1712658929;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=McEKzkmjcf11I9OhkP/1LlQGEjlZMSP7VYzBPCvWmZI=;
        b=BeJjJkVQTOfQHqwlIgqRIvxvTA/sGvFp6q27Ty5ews3DCcvnVHGQ/fCpBySCOMEjtl
         Rzx3KZ7YjiACrRUwCTn0uae8IcAqwT4mOKRFKeMk99cwpIecoKcZXut3UzFoA8hBVmsI
         oH1+lnZr6IjREQDUac+3CkXOV9TLHfSBXObMud4aBBrxZpJNtrl51hdMpnZg48hLRngK
         DquG+cqH6Sr7641m1HQRgdrhkgb7MZ9h/VWPWle1SQQdQcCq0Z79KIGciUtzPLGEr5gV
         IFGSSJ8H0Jl7zGE1m6jE9zMKnnNn3EDAAM1jIUyx0O2E5ukusWc3fR/wJFTj7nwkGoKv
         73aA==
X-Gm-Message-State: AOJu0YySsft2xKBysKuE0Z8LvuJKEjMPnL72LuN3dzgoepiFqFHJjX3Q
	QqWiiKQPVdTUwntKhE90RoHxd8wJMhKGBK49HITvJfhWAEzDPD6/SWKrzXMEOzEpp91UyLcaFO5
	8
X-Google-Smtp-Source: AGHT+IGRSK/fl84w6cZBBgj9gS95ddEk1o8Np66jcKd23QVuHMJ1s5FpuAz37cfNRE6vOLx7p0CPJw==
X-Received: by 2002:a5d:590e:0:b0:33e:2d7b:c5a8 with SMTP id v14-20020a5d590e000000b0033e2d7bc5a8mr12175864wrd.17.1712054128881;
        Tue, 02 Apr 2024 03:35:28 -0700 (PDT)
Received: from [127.0.1.1] ([84.102.31.74])
        by smtp.gmail.com with ESMTPSA id bu7-20020a056000078700b00343587cfa7dsm1825769wrb.77.2024.04.02.03.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 03:35:28 -0700 (PDT)
From: Julien Panis <jpanis@baylibre.com>
Date: Tue, 02 Apr 2024 12:33:44 +0200
Subject: [PATCH net-next v6 2/3] net: ethernet: ti: Add desc_infos member
 to struct k3_cppi_desc_pool
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-am65-cpsw-xdp-basic-v6-2-212eeff5bd5f@baylibre.com>
References: <20240223-am65-cpsw-xdp-basic-v6-0-212eeff5bd5f@baylibre.com>
In-Reply-To: <20240223-am65-cpsw-xdp-basic-v6-0-212eeff5bd5f@baylibre.com>
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
 "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 Julien Panis <jpanis@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712054122; l=3534;
 i=jpanis@baylibre.com; s=20230526; h=from:subject:message-id;
 bh=JqK9X2irpyaetN9XKh1gA7fVuUNk/TXTEORE3XbD6OA=;
 b=NS6rVlJ3bzM/qBzed/AFmshpOzte0/YsVsF/Bd275btEdYT5ruh1Os605yzuE8eOQ9Js1Wq2K
 CAL9sQWzCK4DoSA6oUoVVlu+qgyQmARelBrVHoAdrJ+rPsRdVLlSkbm
X-Developer-Key: i=jpanis@baylibre.com; a=ed25519;
 pk=8eSM4/xkiHWz2M1Cw1U3m2/YfPbsUdEJPCWY3Mh9ekQ=

This patch introduces a member and the related accessors which can be
used to store descriptor specific additional information. This member
can store, for instance, an ID to differentiate a skb TX buffer type
from a xdpf TX buffer type.

Signed-off-by: Julien Panis <jpanis@baylibre.com>
---
 drivers/net/ethernet/ti/k3-cppi-desc-pool.c | 25 +++++++++++++++++++++++++
 drivers/net/ethernet/ti/k3-cppi-desc-pool.h |  2 ++
 2 files changed, 27 insertions(+)

diff --git a/drivers/net/ethernet/ti/k3-cppi-desc-pool.c b/drivers/net/ethernet/ti/k3-cppi-desc-pool.c
index 414bcac9dcc6..3c4e576a44db 100644
--- a/drivers/net/ethernet/ti/k3-cppi-desc-pool.c
+++ b/drivers/net/ethernet/ti/k3-cppi-desc-pool.c
@@ -22,6 +22,7 @@ struct k3_cppi_desc_pool {
 	size_t			mem_size;
 	size_t			num_desc;
 	struct gen_pool		*gen_pool;
+	void			**desc_infos;
 };
 
 void k3_cppi_desc_pool_destroy(struct k3_cppi_desc_pool *pool)
@@ -37,6 +38,8 @@ void k3_cppi_desc_pool_destroy(struct k3_cppi_desc_pool *pool)
 		dma_free_coherent(pool->dev, pool->mem_size, pool->cpumem,
 				  pool->dma_addr);
 
+	kfree(pool->desc_infos);
+
 	gen_pool_destroy(pool->gen_pool);	/* frees pool->name */
 }
 EXPORT_SYMBOL_GPL(k3_cppi_desc_pool_destroy);
@@ -72,6 +75,14 @@ k3_cppi_desc_pool_create_name(struct device *dev, size_t size,
 		goto gen_pool_create_fail;
 	}
 
+	pool->desc_infos = kcalloc(pool->num_desc, sizeof(*pool->desc_infos), GFP_KERNEL);
+	if (!pool->desc_infos) {
+		ret = -ENOMEM;
+		dev_err(pool->dev, "pool descriptor infos alloc failed %d\n", ret);
+		kfree_const(pool_name);
+		goto gen_pool_desc_infos_alloc_fail;
+	}
+
 	pool->gen_pool->name = pool_name;
 
 	pool->cpumem = dma_alloc_coherent(pool->dev, pool->mem_size,
@@ -94,6 +105,8 @@ k3_cppi_desc_pool_create_name(struct device *dev, size_t size,
 	dma_free_coherent(pool->dev, pool->mem_size, pool->cpumem,
 			  pool->dma_addr);
 dma_alloc_fail:
+	kfree(pool->desc_infos);
+gen_pool_desc_infos_alloc_fail:
 	gen_pool_destroy(pool->gen_pool);	/* frees pool->name */
 gen_pool_create_fail:
 	devm_kfree(pool->dev, pool);
@@ -144,5 +157,17 @@ void *k3_cppi_desc_pool_cpuaddr(const struct k3_cppi_desc_pool *pool)
 }
 EXPORT_SYMBOL_GPL(k3_cppi_desc_pool_cpuaddr);
 
+void k3_cppi_desc_pool_desc_info_set(struct k3_cppi_desc_pool *pool, int desc_idx, void *info)
+{
+	pool->desc_infos[desc_idx] = info;
+}
+EXPORT_SYMBOL_GPL(k3_cppi_desc_pool_desc_info_set);
+
+void *k3_cppi_desc_pool_desc_info(const struct k3_cppi_desc_pool *pool, int desc_idx)
+{
+	return pool->desc_infos[desc_idx];
+}
+EXPORT_SYMBOL_GPL(k3_cppi_desc_pool_desc_info);
+
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("TI K3 CPPI5 descriptors pool API");
diff --git a/drivers/net/ethernet/ti/k3-cppi-desc-pool.h b/drivers/net/ethernet/ti/k3-cppi-desc-pool.h
index 3c6aed0bed71..63b96fd53b13 100644
--- a/drivers/net/ethernet/ti/k3-cppi-desc-pool.h
+++ b/drivers/net/ethernet/ti/k3-cppi-desc-pool.h
@@ -28,5 +28,7 @@ void k3_cppi_desc_pool_free(struct k3_cppi_desc_pool *pool, void *addr);
 size_t k3_cppi_desc_pool_avail(struct k3_cppi_desc_pool *pool);
 size_t k3_cppi_desc_pool_desc_size(const struct k3_cppi_desc_pool *pool);
 void *k3_cppi_desc_pool_cpuaddr(const struct k3_cppi_desc_pool *pool);
+void k3_cppi_desc_pool_desc_info_set(struct k3_cppi_desc_pool *pool, int desc_idx, void *info);
+void *k3_cppi_desc_pool_desc_info(const struct k3_cppi_desc_pool *pool, int desc_idx);
 
 #endif /* K3_CPPI_DESC_POOL_H_ */

-- 
2.37.3


