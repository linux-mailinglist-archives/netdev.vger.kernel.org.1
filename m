Return-Path: <netdev+bounces-36311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83ED97AEE52
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 16:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 3711E2811D4
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 14:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8F22AB35;
	Tue, 26 Sep 2023 14:07:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7F91C296
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 14:07:05 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057A4FC
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 07:07:04 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-32329d935d4so3997301f8f.2
        for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 07:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695737222; x=1696342022; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3fL7byGgITI5Pp0Gd+G4m6HpKfvXhtfMbVSSCjqe9VQ=;
        b=BnCASo/Tc6qi8EZNvvmtD3lpKkDK5Jr10FBAjpayIpuUuTWRz+oWq5JIEXd8y8Oi9y
         5MbEsapYW42020HkaAUkZGGEG1TxizLzNgG+0sLORgH4dbUuOe8B/yo8Fmac0/LSOWRm
         vnGYrva4u1M3QdsYVkLOiU+wVOiOkkW6MJfbPxtqcvKSqClcAfBYIYkWKqwkXtUjOM4a
         x1IuOqaJZ37If7bT35bvHgR3EZNHfQX4+jROIFzLAhXQ5pAOWeAeHA1lubjEQ2FT4o52
         rbIf4hqF71maWXWVBUQiz1x+Dqla2Elt4xhwbwveJAOhcRqLxHIR6LZRcHoWWPTK/ivS
         32Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695737222; x=1696342022;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3fL7byGgITI5Pp0Gd+G4m6HpKfvXhtfMbVSSCjqe9VQ=;
        b=pwzWw+b7li7B0R06Xs6HKzw52/O8d2xFSeqFoo+E8n3UPUhAp/pFVwD+scGP1bLiNW
         zIggT6bRLc7B9ishY7M4Ejq9EsF1YW5VO2kUN4TDmnxPpoRqTPQ/D2GhFA9EqAKeC9En
         xtvxLD0eeJsfZ9Qu811izWYlloltxU3EKPX+IGqP8vKTv9+ZLY/HmcPKhlIZbrpojFUr
         JBXH9K/V7YvtQqoRV7dSbqdhB18dhcBQxgXH3HLNnKuMFXdBdI7BI9Bae2wAkG0Ltjee
         Iuitf4p1kegyHObnpfBKrcKaKj+2vBUm0WFSL8TXbmbHQFSftwcBtjSU55Qz2kQrLaGy
         a4lg==
X-Gm-Message-State: AOJu0YznzEJaAzTE4u7CWABqcAs/SApGWGk5TUMlx76Bm1ERU6wM4g4u
	5UgkrJnVEYcZgbUqJH14RVOATQ==
X-Google-Smtp-Source: AGHT+IHrmM3RsXnpLcivnylPyp5TD1hIjaMqvfDzbaCd3y/aleld6b+go0DyjpPmtjDYj1lye7oReA==
X-Received: by 2002:a5d:4c85:0:b0:317:6ef1:7939 with SMTP id z5-20020a5d4c85000000b003176ef17939mr9042370wrs.23.1695737222048;
        Tue, 26 Sep 2023 07:07:02 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id b1-20020a5d4d81000000b003215c6e30cbsm14632256wru.104.2023.09.26.07.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 07:07:01 -0700 (PDT)
Date: Tue, 26 Sep 2023 17:06:58 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	MD Danish Anwar <danishanwar@ti.com>, Andrew Lunn <andrew@lunn.ch>,
	Vignesh Raghavendra <vigneshr@ti.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH 3/3 net] dmaengine: ti: k3-udma-glue: clean up
 k3_udma_glue_tx_get_irq() return
Message-ID: <bf2cee83-ca8d-4d95-9e83-843a2ad63959@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c2073cc-e7ef-4f16-9655-1a46cfed9fe9@moroto.mountain>
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The k3_udma_glue_tx_get_irq() function currently returns negative error
codes on error, zero on error and positive values for success.  This
complicates life for the callers who need to propagate the error code.
Also GCC will not warn about unsigned comparisons when you check:

	if (unsigned_irq <= 0)

All the callers have been fixed now but let's just make this easy going
forward.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/dma/ti/k3-udma-glue.c                | 3 +++
 drivers/net/ethernet/ti/am65-cpsw-nuss.c     | 4 ++--
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 4 +---
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/ti/k3-udma-glue.c b/drivers/dma/ti/k3-udma-glue.c
index 789193ed0386..c278d5facf7d 100644
--- a/drivers/dma/ti/k3-udma-glue.c
+++ b/drivers/dma/ti/k3-udma-glue.c
@@ -558,6 +558,9 @@ int k3_udma_glue_tx_get_irq(struct k3_udma_glue_tx_channel *tx_chn)
 		tx_chn->virq = k3_ringacc_get_ring_irq_num(tx_chn->ringtxcq);
 	}
 
+	if (!tx_chn->virq)
+		return -ENXIO;
+
 	return tx_chn->virq;
 }
 EXPORT_SYMBOL_GPL(k3_udma_glue_tx_get_irq);
diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 31e84c503e22..24120605502f 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -1747,10 +1747,10 @@ static int am65_cpsw_nuss_init_tx_chns(struct am65_cpsw_common *common)
 		}
 
 		tx_chn->irq = k3_udma_glue_tx_get_irq(tx_chn->tx_chn);
-		if (tx_chn->irq <= 0) {
+		if (tx_chn->irq < 0) {
 			dev_err(dev, "Failed to get tx dma irq %d\n",
 				tx_chn->irq);
-			ret = tx_chn->irq ?: -ENXIO;
+			ret = tx_chn->irq;
 			goto err;
 		}
 
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 89c0c3449d98..3c611b9aaecf 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -317,9 +317,7 @@ static int prueth_init_tx_chns(struct prueth_emac *emac)
 		}
 
 		ret = k3_udma_glue_tx_get_irq(tx_chn->tx_chn);
-		if (ret <= 0) {
-			if (!ret)
-				ret = -EINVAL;
+		if (ret < 0) {
 			netdev_err(ndev, "failed to get tx irq\n");
 			goto fail;
 		}
-- 
2.39.2


