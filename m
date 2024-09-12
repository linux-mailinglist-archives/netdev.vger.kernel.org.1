Return-Path: <netdev+bounces-127744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FAA976503
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 10:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18B531F248DC
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 08:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B361E1917C0;
	Thu, 12 Sep 2024 08:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iaJUlmOj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA3B126C16
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 08:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726131434; cv=none; b=S2S4+q1TxJZt8F7uRhIRHn/RyUPaXJU/q21tLF5AcnoXPxtQGuJ6UyGKWOWLTj1b2Nmf+Lu7K01QoG8meU6M+iMun4xC0iXg+Fiyf8B051mBPET4OQmtfslOWZL3bv8jIgWNVyK7nzmsGmJTgTCJ9yt1/lXqnCnZNEsbg0X7grE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726131434; c=relaxed/simple;
	bh=DjtjHEGrvANFI5B9lVHCDNbOIvLuaXQEHlBzxQ+GrD8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZUOtMojwiiuH0hzUJRZDJagUa0bMP5ZqRZmy75Qw7njQWnGzpP6/oSkRsfl0kLhkba1DYG6R1eCFjinCP1vc1ygf41cEPQp9iuL8PAybhyHNGNUPmEUJ6uvX+SS3ltof5hzVQt2BZKleFqFfTNU1W101CkQOsoYUuR6z0+NT/dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iaJUlmOj; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-374b25263a3so487444f8f.0
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 01:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726131431; x=1726736231; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6GB2egBmowzD1BmyczzI/bnYTjW28edWluz9NwGsMtk=;
        b=iaJUlmOjKxDaMOBKXtRgFCUWa40wevVN/1VF0qOP2LPqgM3V/Pm3wK9BWcnMcvXVVX
         wwZLl9ppQAqOyrpjQcXXy2EtzQch1FpNI6EGviMX0spfdUSq0N6A76R5W0i/lEUfrMCc
         egMNVdqdA6njVK5NifQlEcik7tOfraRcXjOpCg2A2190xnrQIiAKIdjQS0wWiXKLtvOM
         OW9xyQelGI2Q9/bp+lsfFcVdIBoIbsjvbvE+vh647IjF+37r1VD7iB5Agg46KLQcM/0b
         i8PcAgBZ5WGH0o0DKACTpRD6gX6pbtY5b959biMB+S36UakfqFUaNbpg0eMwJzqtwfz+
         WM2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726131431; x=1726736231;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6GB2egBmowzD1BmyczzI/bnYTjW28edWluz9NwGsMtk=;
        b=T5jKtAVrgK/ezfnUZlGbJ1VYplNbNhFnzxD+oQosyl8v8zFOJmKzBmUj3LUTaoGeWN
         uRY5zhMeWRGK0ZH9re8pSuq1ltdCHH+Ib/fLHfk72oYJTel2lMtfm4f9VJ5erkm3rOfO
         gyoe+lJkrUFxPsUW34BkdzqhXeK/8qfGCk4RbMf7f7RprqifCC5p4jZhgtO1nKyUDEfJ
         i+MA4/IyGU81WigJytR+OfEa9kqBis2d7zOipCYMhqCpL7qE0TU+bTe2tBAi/vkNNd8T
         GHiYLmPs7BGOJR23swC8r0jZCYtotm2+eNuQHHv9Ayga5TIcOawekkALT7F/PAwJsNEm
         pSfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVabX3ZSOx+CfzN/kBDeK7RI4FvkR67BfQf8iTDBoXK0dq+r/eRjNJbkb1fFo8ypu/6uPiXVNo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/JfdS5+6lmGYPJtVnSGLm43/fg7z7myD4G/g1vbGKlzNSD5vE
	8526OEkUA1ayCrmWX6upBLI155Yp3nVkTXlWSeP3+CFsm2TeB6pInxfLXw0EsTU=
X-Google-Smtp-Source: AGHT+IEOtJzJsuwuqY2oaUeNN42g94gx2ZHs0ZQuD1RVXqzgi2ozhnck9PoCMtBGjepfFwTy/BEe8Q==
X-Received: by 2002:a5d:65c9:0:b0:374:c793:7bad with SMTP id ffacd0b85a97d-378c2cf3c57mr1155356f8f.16.1726131431260;
        Thu, 12 Sep 2024 01:57:11 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3789567609esm13746480f8f.59.2024.09.12.01.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 01:57:10 -0700 (PDT)
Date: Thu, 12 Sep 2024 11:57:06 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: Larry Chiu <larry.chiu@realtek.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net-next] rtase: Fix error code in rtase_init_board()
Message-ID: <f53ed942-5ac2-424b-a1ed-9473c599905e@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Return an error if dma_set_mask_and_coherent() fails.  Don't return
success.

Fixes: a36e9f5cfe9e ("rtase: Add support for a pci table in this module")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/ethernet/realtek/rtase/rtase_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index 7882f2c0e1a4..ffebc67cba5a 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -2023,7 +2023,8 @@ static int rtase_init_board(struct pci_dev *pdev, struct net_device **dev_out,
 	if (ret < 0)
 		goto err_out_disable;
 
-	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64))) {
+	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
+	if (ret) {
 		dev_err(&pdev->dev, "no usable dma addressing method\n");
 		goto err_out_free_res;
 	}
-- 
2.45.2


