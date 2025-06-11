Return-Path: <netdev+bounces-196573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C25AD56B1
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 15:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56DE11892C1C
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 13:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677AF2874E8;
	Wed, 11 Jun 2025 13:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WX6O2unF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D450C284B4A
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 13:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749647680; cv=none; b=fcATS+BnFjK4naM4xm1/nHxoYLkYoNCGywB6wpkteKz9URdHSdzl6T1z1J17IKiyy8G9Gz5H+isGWBZUCsZoTPrFpXuniC61Pa08F2mSDz4TPFBTGhzGPI2Ub7WdfOKZcMQL6mv8CAnsuVKgM5Or3G1x1id/F1zJi6JVMghd4lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749647680; c=relaxed/simple;
	bh=ZbBHn47dMGWJ53QUL91wDWCBgtkYk1bF33LwhgsK/8M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OItiRtZGc6n8jWOZ7Hn0Jlothkc97tDWzNGlZEFYCWuX7WYk8jxrOl2wMsaa8SBXYXNOKcv5UEpowuegW5ra2Djlp+8n/JcFvoehEpWmqbXalpnNi9Nx3OstG+tmP7Qevr6iQmvA6PXTFDMNkTXU2foJknjuwwU0NKb8AX6p1HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WX6O2unF; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a3798794d3so5774005f8f.1
        for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 06:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749647676; x=1750252476; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1wi9vi2VZkar6XQ2+UOcqg15dLLnETew3y6pYXACG3U=;
        b=WX6O2unFfTmUoeV2HPmWQJaWIfIlmS31kfMa3AA+NI/GcftSDAetnmLVj9Zk+JPDvO
         zediAdwvckV4FWVeK0A0rgV7wLcEKqzEo3sF7YBlWK7F5L0KrF9dLyx2FGg5NgA47RoZ
         0cYvEABurjOHFF/O6/QPiYUdcF1IjHZ0oUnnYZ5WdUc7V5InhXeHYi2S9PRDgMdLs+d1
         3thsURD/QRIEU5QyRsa2H9/yWmYQu3TBiID5QNDtKD+T2MmybXFVl4JDzw06G/zsnc9v
         h2OCvYUerxC7CWuxWKRv5QIiszpK9eDl9o7xh0aXXEc+OG5gAlueMTYHrhAJbviy+XFm
         LCIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749647676; x=1750252476;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1wi9vi2VZkar6XQ2+UOcqg15dLLnETew3y6pYXACG3U=;
        b=B9us/tZqzc8x1oddjUf6rIfEqE4oJbE0Kd2wCiYFZ3rs//oPM2QG238sBeFflQijCH
         T8n1qKeAHEPsLvZ5DZZVUjV2CcKCGB/0SF2JtJns2e8sH7p8IRMSNPWjV9lkpx1B6jhN
         vJZN1AIGkFI0d2SHmqwuItW97QOMDzQVj6CJc0U8528qqlpu1iKyaoEFZJ04Q44hie7a
         4ITSlfSKbsl1wuhwEsoxYpPNgRdQjVKX6XJsiSjFlyBeOK06SAUvkM3Q/wKrIb3+OBiI
         8NHrHefM1F5a9e3S2S84hRYRjwZezE38FOBOi2LKKKpU0jgmWmPMTeyDggycXiabJapU
         BCuA==
X-Forwarded-Encrypted: i=1; AJvYcCWrQuehU625q/9gdIYSmQSKF4dw4VP2TYvs00mRMkXTcqrLTqtlc6Y3+1uRrtt+iYM7n8TDT0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YximIIEiPZ1BQpdeDnL9SjYNCnJkXv2KU39imN2zHHEv9FJT5fM
	1I/O5RXxnFdQ56QJpKQAWxYsxze1Po+XCrXOD+11M65/4oIvywk+YdKJhz54IYV9Zk4=
X-Gm-Gg: ASbGncvZpU6V3ggGYW9a+nrQ4xbnleR4qkIb4l6mS30vyxGVQVbxNG06gHcsMnAWbCi
	tlPLtjGL5Zf6biuEoU3g507OoGiKXZN1DDziFHFp3yirev5yxj2/ut5tviRkUs32ah0nOE9Rf+l
	a5FFgS1qt6ZjeZSBb+9gJsNHFfPDZ8ylyY7ei6o5FRxJ6imyOQtHOEHftkCvg46oeh8OMf7cTmO
	3XFADLLBNOvMtPYy5OvIL5rPoAWHTtgOiSBvOp3oYpKkOYom9xNMQuk0QQ1MnfG06TbAD8XyBB2
	ylMRnjLFazyNAn4PoK7P3yXMfvNemyuouTl3AkwVNsuU3r04ESRWgoxdbkBpF70ikvIcYUKCANJ
	GKg==
X-Google-Smtp-Source: AGHT+IEZYxPPB8go7zapmJs8ZEVjldo61z1jUHfLZWjVjqXCaiPBg1do2SuJ9+yFiiv/enBgtuPakQ==
X-Received: by 2002:a05:6000:2010:b0:3a5:4b67:5a70 with SMTP id ffacd0b85a97d-3a5586c9eb3mr2584527f8f.18.1749647676139;
        Wed, 11 Jun 2025 06:14:36 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a5324520e7sm15326874f8f.84.2025.06.11.06.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 06:14:35 -0700 (PDT)
Date: Wed, 11 Jun 2025 16:14:32 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Yevgeny Kliteynik <kliteyn@nvidia.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Cosmin Ratiu <cratiu@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Vlad Dogaru <vdogaru@nvidia.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH v2 net] net/mlx5: HWS, Add error checking to
 hws_bwc_rule_complex_hash_node_get()
Message-ID: <aEmBONjyiF6z5yCV@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Check for if ida_alloc() or rhashtable_lookup_get_insert_fast() fails.

Fixes: 17e0accac577 ("net/mlx5: HWS, support complex matchers")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v2: Add error checking for ida_alloc() and add cleanup.

 .../mlx5/core/steering/hws/bwc_complex.c      | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc_complex.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc_complex.c
index 70768953a4f6..ca7501c57468 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc_complex.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc_complex.c
@@ -1070,7 +1070,7 @@ hws_bwc_rule_complex_hash_node_get(struct mlx5hws_bwc_rule *bwc_rule,
 	struct mlx5hws_bwc_matcher *bwc_matcher = bwc_rule->bwc_matcher;
 	struct mlx5hws_bwc_complex_rule_hash_node *node, *old_node;
 	struct rhashtable *refcount_hash;
-	int i;
+	int ret, i;
 
 	bwc_rule->complex_hash_node = NULL;
 
@@ -1078,7 +1078,11 @@ hws_bwc_rule_complex_hash_node_get(struct mlx5hws_bwc_rule *bwc_rule,
 	if (unlikely(!node))
 		return -ENOMEM;
 
-	node->tag = ida_alloc(&bwc_matcher->complex->metadata_ida, GFP_KERNEL);
+	ret = ida_alloc(&bwc_matcher->complex->metadata_ida, GFP_KERNEL);
+	if (ret < 0)
+		goto err_free_node;
+	node->tag = ret;
+
 	refcount_set(&node->refcount, 1);
 
 	/* Clear match buffer - turn off all the unrelated fields
@@ -1094,6 +1098,11 @@ hws_bwc_rule_complex_hash_node_get(struct mlx5hws_bwc_rule *bwc_rule,
 	old_node = rhashtable_lookup_get_insert_fast(refcount_hash,
 						     &node->hash_node,
 						     hws_refcount_hash);
+	if (IS_ERR(old_node)) {
+		ret = PTR_ERR(old_node);
+		goto err_free_ida;
+	}
+
 	if (old_node) {
 		/* Rule with the same tag already exists - update refcount */
 		refcount_inc(&old_node->refcount);
@@ -1112,6 +1121,12 @@ hws_bwc_rule_complex_hash_node_get(struct mlx5hws_bwc_rule *bwc_rule,
 
 	bwc_rule->complex_hash_node = node;
 	return 0;
+
+err_free_ida:
+	ida_free(&bwc_matcher->complex->metadata_ida, node->tag);
+err_free_node:
+	kfree(node);
+	return ret;
 }
 
 static void
-- 
2.47.2


