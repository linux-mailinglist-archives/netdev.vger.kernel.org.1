Return-Path: <netdev+bounces-101446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F8D8FEF58
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 16:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40E281C2350E
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 14:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4549819925A;
	Thu,  6 Jun 2024 14:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TAuzFzh1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CC8197554
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 14:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683835; cv=none; b=lxwAI/76MMn0QQkzi7EZf7V7POVgRaEkLyZfGngazdvFZDGjcrLvi2btlWsFq4gKKSXWmN9b1Rv0IL7oKKg9Pt9SuwrUPYVQ767OnDzO4q8vt9Atc2XjnEzFuvEgt2Oa9f/hv4i3vuRySzMX8zrOa4zu3T9juCrXJ3fjPWFm4lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683835; c=relaxed/simple;
	bh=ynPjpCEfE7qSWExl4NgQiPtqK2yUqs1tb2YKL7htCQc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VRn/xAYULgbM1tJejLF3Fcq2tnXEAl+/XsOsE3eQpKbdYP7giBfKSin4V1ugvbXo3DbqfnjRX6enliKsjSJyMLJtYU7qhD5N9MQyvHa1XcYe9y72BX6hUNw1hheDRwqRbSKHmXlrC+++G6LKLlNuyuixIhSuep3beVQW/CNXloM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TAuzFzh1; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57a30b3a6cbso1287919a12.1
        for <netdev@vger.kernel.org>; Thu, 06 Jun 2024 07:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717683831; x=1718288631; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=is6s/GpBASAFrFWj8/JczGtlu19laRTn68QOzHiY+QA=;
        b=TAuzFzh1ztewaKlWOOkEAbU72MCh8tyQTPFVHKaTVRyBzukszqXCY7BzVBH2Y2HKFH
         HJm65QOk6bF5jFHBMjb7aHsEBLnz/LGKW0+fs8mxQEYBcsDwmiNImgavpzgzTKLCQqDI
         Tg2Dam0XheN2PZ011ZqfcKKWV0H+zHUu/7UzB20wptG2ZwOv6wyKff9WgvGmVYj9kVMX
         ud7I7DQq3jMkHk/+t7YIADCooy38mZlvfKzF6+JiKuRFwDy5anHNl9CnMBFGDKFDU/D+
         rHie/AAeArCl9iY+z7cjQQhiOkTx5OKvP6g9KTTNF7il/lO+zJ4QIpmid1uCDdgzSp7i
         nHJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717683831; x=1718288631;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=is6s/GpBASAFrFWj8/JczGtlu19laRTn68QOzHiY+QA=;
        b=Pqkyj6ui0OKt+TOfTxo6+8Gb6Du0xSizX3KComtTwnjxhy3xyMOxIVd866SGs4aC+S
         osiFq1Dyht2OlfLW2DqJTkMtFY6x49ytwQPhLcXPGhIoA15tzxHAr1gd+mCl16l6L91n
         n6vh7MGDqXCWjFXIwAmTOWzqgYJyS4PrpNn1NTmTUrfkaLVD0/aa6nrVL45JDCKS+/qJ
         pgn35ijOcwC5EcIFhbH+g+1sM2NbjMdGEAakWzIi7dwbBnwDCUXgeI+WWtlBOmCSAyYv
         yHa5mmJtHekLvZdrOyfuhzhitVtecWUJhPq6a33PDmtIPhfWH+CsgaS8vtZwzVWaajQm
         c8vA==
X-Forwarded-Encrypted: i=1; AJvYcCVwYav5dm6DPqeY3Xv9oEg8OrHEQfpzVI7YPxOpNhcUp/EEmCgpwSvg8A5C0oUZ9thB8eR00YpjWAzTAKn7DY66emlXqPBv
X-Gm-Message-State: AOJu0YzZXMMrRK8hu1Fa2yCx3u67JQiC6DLpjHiFZvOq3igb3Jai14Uj
	n5ybfw5428JSwEvH9RUw7tjkCWzzrJWzMddVLa5XVL0WsEoedwDN9Ft0Mujdb90=
X-Google-Smtp-Source: AGHT+IHgstzJ2kZrCspX8fsFXWFYWZkQB0H/XNx5XJ20AdVItbU/LBbuTqT5RL9D/+AsyONocr+DnA==
X-Received: by 2002:a50:d79b:0:b0:57a:259a:489a with SMTP id 4fb4d7f45d1cf-57a8b6a698fmr3514806a12.14.1717683830353;
        Thu, 06 Jun 2024 07:23:50 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae2323f7sm1159364a12.85.2024.06.06.07.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 07:23:49 -0700 (PDT)
Date: Thu, 6 Jun 2024 17:23:44 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	MD Danish Anwar <danishanwar@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Julien Panis <jpanis@baylibre.com>,
	Chintan Vankar <c-vankar@ti.com>, Diogo Ivo <diogo.ivo@siemens.com>,
	Simon Horman <horms@kernel.org>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net-next] dmaengine: ti: k3-udma-glue: clean up return in
 k3_udma_glue_rx_get_irq()
Message-ID: <2f28f769-6929-4fc2-b875-00bf1d8bf3c4@kili.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Currently the k3_udma_glue_rx_get_irq() function returns either negative
error codes or zero on error.  Generally, in the kernel, zero means
success so this be confusing and has caused bugs in the past.  Also the
"tx" version of this function only returns negative error codes.  Let's
clean this "rx" function so both functions match.

This patch has no effect on runtime.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/dma/ti/k3-udma-glue.c                | 3 +++
 drivers/net/ethernet/ti/am65-cpsw-nuss.c     | 4 ++--
 drivers/net/ethernet/ti/icssg/icssg_common.c | 4 +---
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/ti/k3-udma-glue.c b/drivers/dma/ti/k3-udma-glue.c
index c9b93055dc9d..b96b448a0e69 100644
--- a/drivers/dma/ti/k3-udma-glue.c
+++ b/drivers/dma/ti/k3-udma-glue.c
@@ -1531,6 +1531,9 @@ int k3_udma_glue_rx_get_irq(struct k3_udma_glue_rx_channel *rx_chn,
 		flow->virq = k3_ringacc_get_ring_irq_num(flow->ringrx);
 	}
 
+	if (!flow->virq)
+		return -ENXIO;
+
 	return flow->virq;
 }
 EXPORT_SYMBOL_GPL(k3_udma_glue_rx_get_irq);
diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 4e50b3792888..8c26acc9cde1 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -2424,10 +2424,10 @@ static int am65_cpsw_nuss_init_rx_chns(struct am65_cpsw_common *common)
 
 		rx_chn->irq = k3_udma_glue_rx_get_irq(rx_chn->rx_chn, i);
 
-		if (rx_chn->irq <= 0) {
+		if (rx_chn->irq < 0) {
 			dev_err(dev, "Failed to get rx dma irq %d\n",
 				rx_chn->irq);
-			ret = -ENXIO;
+			ret = rx_chn->irq;
 			goto err;
 		}
 	}
diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index 088ab8076db4..cac7863c5cb2 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_common.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
@@ -440,9 +440,7 @@ int prueth_init_rx_chns(struct prueth_emac *emac,
 			fdqring_id = k3_udma_glue_rx_flow_get_fdq_id(rx_chn->rx_chn,
 								     i);
 		ret = k3_udma_glue_rx_get_irq(rx_chn->rx_chn, i);
-		if (ret <= 0) {
-			if (!ret)
-				ret = -ENXIO;
+		if (ret < 0) {
 			netdev_err(ndev, "Failed to get rx dma irq");
 			goto fail;
 		}
-- 
2.39.2


