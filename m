Return-Path: <netdev+bounces-232497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DC8C060BB
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 13:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C63123B5D4B
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 11:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B6B3191A0;
	Fri, 24 Oct 2025 11:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DY6QzpVe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AF530EF64
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 11:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761305022; cv=none; b=DK4k6Ha7Kb+cEhPokDTVHZodCml6ZcTzdPlnQMm/3KAroxiuc4eaec9QF23BFXXIUgT/+bFBbrUAMVdkTkhq01lJRLFraGj18+/t+jmWjl293nzdDt1mCLQREg8hxFqdCaF8qPUc0xWp2OPF8Gz5HksdRZlnJN5XXkHBtqBI49k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761305022; c=relaxed/simple;
	bh=0zowZQE/EmMI6GxlKIwg6FGmmiIJo4BbJNTy9TYrt7c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=u5x3KUz4UyX04GgWs9179iBQn+ZxNQmKGvN5GrfVc4wFH7DGeb3GErfg+q6gt5sTwhSn1DP31S346uiwQJow7Q/yzfnSgm1V1EmyMIoeINNKIhRuxgXjqH4iz8FaOEn8DQf6E2gIMkSU23hTywjdSkvg856xfal75P+rFazSnX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DY6QzpVe; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4298b865f84so1019473f8f.3
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 04:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761305019; x=1761909819; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FQOc+jM39ubvRhhSlIjQuPooaB7ldn1LylmA2tOzblM=;
        b=DY6QzpVe0rxSgKfR1z1haUEhujvUsfah5zRuRK+UNKDNuQwQDhgN9Q2Pv/I6rSunfn
         myhJ/e2273OQCiglJIDkS1JB7voG3EU0MHqMxLATAb7bdAAEjJTA+W43vpbn1mDCkAOL
         so0Nynvwyo56spz7PdCkRP35AB1hil/QXwMtKf+3aKT2DBgN078yqy8k287KyXHTEBKG
         VfAAaEVJGfCPaAXFbU3Hane6Llc8DORtJcAQsubIDVvHZqQip9BjGrhcbhiWL/5j/siA
         4HZO3RKb+H5LYfSEKByhCnp6fEMQXcFNXrisTI3nts0WKc2RSv82LRwO3DKU1FpKV21W
         zx3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761305019; x=1761909819;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FQOc+jM39ubvRhhSlIjQuPooaB7ldn1LylmA2tOzblM=;
        b=YxIDIQB8qsZUDM+WCkGy6Ag9CRDHf3vBWgBtL34//zYJqK5KV7eyVWl2oUaVRrGrUd
         Fy006/qd4RhpjVkqzAvi4jrTp/d/04UtItgwn3jBxmLDHcu0v6k7aimpFPpIN1ZaJVDo
         sGS286POGiwVr5DjGIawRNBoxbvacu0/zp8JVOoozEztDm355Lxn27f9juxICXj6sJ/n
         xTK018uzIeDONGkfArMAuMIfa3zag8mSQO3WZhrNKipHrOlOGRhEBLh8nOMVwyHBR9aQ
         GhuN73Z+89p+j2nLcU+V3jkFHN8ZpRJXsFzeUHRsvDo5tMsgk+qW68Z3RV//oKTr+V3q
         8yvg==
X-Forwarded-Encrypted: i=1; AJvYcCU9/kTBCD3J1wExTw9eUUVJXPh0Gtc7xebLu9odqtI+TwD8sauk6Cu0HYUelSJ5o5hD5khK634=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBUjQZEH1a8Al6uL96RQfqh4Uu30X6vnR5Bm9p9C+AidPmiNC6
	/KPCgSIP9aV9A6bbzTgfq6lortgQ3je8Z8YoVh/pIdVXZTVJFi5che1fug0fCLs3MxI=
X-Gm-Gg: ASbGnct/FVUA9ZGgAG6xCoTDiTTWw+Ebd1YIjmsmfnBKW7P4qDKzv88+N9EoQJ09My8
	FGWyWFCsKBsOZKyskNMRq1ePX2u1mJVzABcxg31QlvvhoLJd7+d0kb6K4zcnYDOaE6dvu6+XkPE
	Ywraudcqy1wOXR4scElcsJXzNFNZINJeF+1QYw9i2o3/2OKLcjqHgikoArLYwtJ+OLYNPq/yNt1
	wpyW1+n4xTk7sz+/lOGCqKO+Hx6qL2XRyCxD8x4FCRKhYrBw1D0AXaY3XB961SCCkQJR36zld5r
	lOTAyK0+Ix9dQfu6g+lXlJQzwKeAds9hh0Uiipy2dOgS5j8jzn1IRnGEQBNnfKDbPxnyN9fSjcn
	dkDISm4uP0HuhvFdrVFX/ddsp34Rkehvd3Z2vy9ROb81g0EzRMEEIAbQWo2INOsKWE9GnO1TBoZ
	TEOvvQBWPxA1WjmOXG
X-Google-Smtp-Source: AGHT+IExQzOyk4omzvi9Zz7XZjs/LOOnvxM4yvkC9gtz1IfMXQ9aSiPVkXwgXIxJvNBEVGrXMNkh3g==
X-Received: by 2002:a05:6000:4a09:b0:427:62b:7f3 with SMTP id ffacd0b85a97d-427062b07f9mr22219100f8f.33.1761305018812;
        Fri, 24 Oct 2025 04:23:38 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-429898ec1dfsm8923611f8f.43.2025.10.24.04.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 04:23:38 -0700 (PDT)
Date: Fri, 24 Oct 2025 14:23:35 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net-next] net: airoha: Fix a copy and paste bug in probe()
Message-ID: <aPtht6y5DRokn9zv@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This code has a copy and paste bug where it accidentally checks "if (err)"
instead of checking if "xsi_rsts" is NULL.  Also, as a free bonus, I
changed the allocation from kzalloc() to  kcalloc() which is a kernel
hardening measure to protect against integer overflows.

Fixes: 5863b4e065e2 ("net: airoha: Add airoha_eth_soc_data struct")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 8483ea02603e..d0ef64a87396 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2985,11 +2985,11 @@ static int airoha_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	xsi_rsts = devm_kzalloc(eth->dev,
-				eth->soc->num_xsi_rsts * sizeof(*xsi_rsts),
+	xsi_rsts = devm_kcalloc(eth->dev,
+				eth->soc->num_xsi_rsts, sizeof(*xsi_rsts),
 				GFP_KERNEL);
-	if (err)
-		return err;
+	if (!xsi_rsts)
+		return -ENOMEM;
 
 	eth->xsi_rsts = xsi_rsts;
 	for (i = 0; i < eth->soc->num_xsi_rsts; i++)
-- 
2.51.0


