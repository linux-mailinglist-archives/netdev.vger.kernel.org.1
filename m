Return-Path: <netdev+bounces-130610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D4998AE69
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 22:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BA57283C65
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 20:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF311A2C0D;
	Mon, 30 Sep 2024 20:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="drAr7cDO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B450B1A2646;
	Mon, 30 Sep 2024 20:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727728198; cv=none; b=agzWQdkI3LVy7iQKCWkiEDsAJSuY5idxHD8AyNcvKx9hzR562H5p+cXFdejSBpISj5aglgA0xbLRX2nQiBhFT3drI6IpyYgKZP69W8ltZnas80FIkVIJ87p6RATVCqacNLhy1LZuAKR+uNrZ/F/Czq15SZ5ZqG1wCbfRXBfAy48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727728198; c=relaxed/simple;
	bh=iWf626H8Q+2FZQodXiYoFTnASSgaPE6KWBTgvxM7qgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uQc2SONF7xW9B7r1Mc0OtBUvSv+m/StfdxzKlqHDvNFUfPIqA41dpdfjEJfntouJnx/jwjdyuigkGntX2WW4a+HtvbpgUX4GIAqMgQHyDiQIvcw1fMPWR4jnBYOg6/pkCj3yoY+dbIG8nnZFsSLjjJZ9oSbqoWiS1K1HeeiofYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=drAr7cDO; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3e2a1049688so2386051b6e.1;
        Mon, 30 Sep 2024 13:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727728195; x=1728332995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dOyB2Jo2ejc9eXn3CRqEZnVgRt9TH8TV7IBi/XBYhs4=;
        b=drAr7cDOoqGOrbyNUVJEkEOK55SN6oD85kdsTFIQe5Wn9qUNrmPSLOTYxFHK9tcG7u
         X6NpgeIAsdyCsBDDr6kVVI1STm+iIq4DHfGknqSN2oBzBuB6H6Gr2l1IRwc1R46MpSRS
         gGqo81rGsbmEmS7LMDRvZYfe3lkTEzjLjSHUhaIHHM21dbLO3at6qbGZEC3GvSN7GqTh
         3lTYsGYUCPR0McKPgu2gJ66O7qNS0z+4fL/rbrekDpzoDSVo4Yj1iMoXZ8AYRs2+lC5c
         Hkpc3vaYZRsnFi345Kqf/BNdMDgO4YylnbtJjT/WsDzVNoTT5qTgNM1hqrtJR9fCRWsK
         uLcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727728195; x=1728332995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dOyB2Jo2ejc9eXn3CRqEZnVgRt9TH8TV7IBi/XBYhs4=;
        b=KdsATKX7z0NjabsyWIa1JvMViE5Ww1gtzPpsK1yd4efzHRiXxL1VX1y8BOaASX03GK
         Zqw18sjaratIh0Bp/1yUr7s76vzEhlRGLERMd5ZLBO1K60JyxklbW/YNTpVSZ/LLMN4w
         x6Ie9rPbgZV6nwy175Sl/TmZCUiyOsb+W4ca9/5F87kEvhxOWHXvmnM9rRc6WFg4VyJf
         QOJNCz7QAqF51RAy3zvyRld9rl/81GeF4zIkyZzB029T6UVPKdz7tzqDkOEPw/rwrZsP
         ODGBB5MfZVVJey0pV5+nvbQopo3UDD3h+kbyNcwkEpYiuYGuvG3rj5Xm4gZ3H8jfBKe6
         U89A==
X-Forwarded-Encrypted: i=1; AJvYcCU/bRpm8OH2Oh5zNKHnKNsGt5DNuIgsx3DAiIbB1Svze5SGoFdo7gpkx+IqqgHCiSPY6CKVg3LBJAe/zkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj8ArhNAqMlavOiMMZWXqS7sh5hQ3zfGm3KKPpU9uaPiAGHQ23
	Rmrua+Zo0u6C2DESqD3HWaeAh2zTFoFhlrbAWG9Tv3zTqRKQFCzhAxAE4RmH
X-Google-Smtp-Source: AGHT+IFmuRmg7PQQbecFM4j/4CN9Kc8i6T+U3rIPSu3F1jvFz2Xk9MkgFV7aQcGwHEs+lp3erJ4WBQ==
X-Received: by 2002:a05:6808:3021:b0:3e0:47eb:baa with SMTP id 5614622812f47-3e393968f85mr9084358b6e.14.1727728195537;
        Mon, 30 Sep 2024 13:29:55 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db5eb3ecsm6812943a12.60.2024.09.30.13.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 13:29:55 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/2] net: mv643xx: fix wrong devm_clk_get usage
Date: Mon, 30 Sep 2024 13:29:51 -0700
Message-ID: <20240930202951.297737-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240930202951.297737-1-rosenp@gmail.com>
References: <20240930202951.297737-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This clock should be optional. In addition, PTR_ERR can be -EPROBE_DEFER
in which case it should return.

devm_clk_get_optional_enabled also allows removing explicit clock enable
and disable calls.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/marvell/mv643xx_eth.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
index 36646787885d..73094b3b590c 100644
--- a/drivers/net/ethernet/marvell/mv643xx_eth.c
+++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
@@ -2854,9 +2854,9 @@ static int mv643xx_eth_shared_probe(struct platform_device *pdev)
 	if (IS_ERR(msp->base))
 		return PTR_ERR(msp->base);
 
-	msp->clk = devm_clk_get(&pdev->dev, NULL);
-	if (!IS_ERR(msp->clk))
-		clk_prepare_enable(msp->clk);
+	msp->clk = devm_clk_get_optional_enabled(&pdev->dev, NULL);
+	if (IS_ERR(msp->clk))
+		return PTR_ERR(msp->clk);
 
 	/*
 	 * (Re-)program MBUS remapping windows if we are asked to.
@@ -2867,7 +2867,7 @@ static int mv643xx_eth_shared_probe(struct platform_device *pdev)
 
 	ret = mv643xx_eth_shared_of_probe(pdev);
 	if (ret)
-		goto err_put_clk;
+		return ret;
 	pd = dev_get_platdata(&pdev->dev);
 
 	msp->tx_csum_limit = (pd != NULL && pd->tx_csum_limit) ?
@@ -2875,20 +2875,11 @@ static int mv643xx_eth_shared_probe(struct platform_device *pdev)
 	infer_hw_params(msp);
 
 	return 0;
-
-err_put_clk:
-	if (!IS_ERR(msp->clk))
-		clk_disable_unprepare(msp->clk);
-	return ret;
 }
 
 static void mv643xx_eth_shared_remove(struct platform_device *pdev)
 {
-	struct mv643xx_eth_shared_private *msp = platform_get_drvdata(pdev);
-
 	mv643xx_eth_shared_of_remove();
-	if (!IS_ERR(msp->clk))
-		clk_disable_unprepare(msp->clk);
 }
 
 static struct platform_driver mv643xx_eth_shared_driver = {
-- 
2.46.2


