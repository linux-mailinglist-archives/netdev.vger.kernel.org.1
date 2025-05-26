Return-Path: <netdev+bounces-193310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 078EFAC3831
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 05:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90E5E1892411
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 03:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D092815689A;
	Mon, 26 May 2025 03:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfRX780E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D342DCBF0;
	Mon, 26 May 2025 03:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748229686; cv=none; b=gnhI4HB6zpZE2lFZT64XT1UImBvnbzxq1++KVpYMkXXxEWnKXNSE+IF8XRCEOyaDJFB/FHT9uN1u6P8a14EoQfJenHQQpjtEK072sX5YfbjVnPQEIvC4OXivmuAYVUUDR+SrV+yHUJYgiG917siC4jN144hwUfS6FGJgG0K129U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748229686; c=relaxed/simple;
	bh=+u6/d+XbCdFX1pm63kx46uf2xnEbiZPm/ThfbOK0UwM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c+uyx+IBHp3opbNehBx7R61iJxB+5RZJ74qbI8UqjthGDBgWMt8Mmd0ArSIphyukL4uBy81pw5vHNxGnvRitVa/vuqCArfV6XyOi5dyvnKHkbbXZt51tg41w9XFFa1f144qKujIRuFKZWvBkBmZB30fm1fbo8YQpZLgU76CkZks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nfRX780E; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-734f2ddb868so1127561a34.1;
        Sun, 25 May 2025 20:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748229684; x=1748834484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b4x4mz4TArl3IKHWSg5MqZs1vRBlLQZMLHZs6OUc52Y=;
        b=nfRX780EBJScfR7Dv+8p5fKRLgB3YuTIsQSLvJUQUBUaj26o2sNHxZKagDG2ywQVqZ
         Fjm50qv43wvejTVwmVrBcpMHwoamjER7L8AvVJJ11tGS6hPNYYNQ5CHDVHLPW6JrkiVF
         RD0n0hLuOnkWsQzMQZ8t7OqUHhyL0EXMfomewOENbjSAoL4Xhyv3ijVJBnDrsOIvboJr
         HnxVZsbMy+2rDBGhMUK8/rL3RtZX+0KBOF+mDiyoac3c1oV0uCHc8UzY5BM8lJY7wG3n
         F7OC8jTftOWmzH3/VAT7vh1c4BoLZ7KSqw76PLGpKxVSxsAgaRzB7Wwko1NVogesF7yO
         0+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748229684; x=1748834484;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b4x4mz4TArl3IKHWSg5MqZs1vRBlLQZMLHZs6OUc52Y=;
        b=pnoroOkW2vzjeoHkf7IiYl+hrJby9svT4nACMqIZtRd/0S4cevphBy++tigZNU8gy8
         9wh4RvDbAq9XG4BDBs+y/0XFll19AH8hnBq9oYAueIhhydQ4xhh8nIslanFueT8HA5BJ
         2kY4t1fXwIehUW+y8znamANiz7qSXUN0/rVRi+BRZAv3CHQPsokctHFsTnKbS43N2F6z
         4ojj3CqgYm6YSc7O5PmfICaNOd4WExaHVetfcHJB0ayORa4l1UZnwSLa3uHcxeimhjwC
         ZdnbNexjanhIl6LNkHpg8EOkzHf5C3dimwbD14ab+7jxHJHfL5HlQ9don4wYWiyLmjPN
         vaFg==
X-Forwarded-Encrypted: i=1; AJvYcCXFktdeoEO7k7cDbXjqSacVw37UCvRyZ6Yi1JerR8Yp4b5hmrxeBDSsezVN8xZGI9ea29FB7cr9@vger.kernel.org, AJvYcCXtRYPUUy88Sh8XC+aIg45x++yaHufvvlxthMkfboCKRXlZerqfHO4E+ACpD7brMfjF/f/62YfcsK8S+SA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTHA3f5Ct+9SqfC5jrLNLdlGBwoy7BKBFFfr5PybuJ2GeQmB4R
	UgQpZd6lrIV3xsbcVQtiDKv8Dl3hRWsdJb9mzcsKzC+6KpjgHigZSCRF
X-Gm-Gg: ASbGncvgxYiWYxBGKJ9d2NbkGQy8iEaLr0z43ke2HBq9EdKxlSH7Wc8RD+a0vJWE5xN
	yuHZPYGR9stIaZGB9h1N1+8lCByvNm4VWtVu24syY/WYvO1FiWKYuQHuzbPOHacrxIWmCB1p05U
	iR65dds97rNd5TYg3o930YsWzDiluH+7UADmMBp2Zyc5wvL2Q+P6v5Xn45cTLn78OUvGTaT87Yf
	NSttQTmFHHoonRx8sRgG+T+KsfLYNaHJjclYKvesIeDLyAwwbTk3hxbTY4BJxC6a52ggJCiCb0F
	Iw6wewgMTUoIrN3Ajb/S8QxVMkhoxKaw9V+6k/8J7lKmLep3VPep
X-Google-Smtp-Source: AGHT+IF6axbFUws2RP6cfaZQ4YYiXxs4u+AvT4/cyANKARrl7608c75edUewBimyD/8tCjp7gSO1RA==
X-Received: by 2002:a05:6830:3697:b0:727:24ab:3e4 with SMTP id 46e09a7af769-7355cf36760mr4664491a34.9.1748229684198;
        Sun, 25 May 2025 20:21:24 -0700 (PDT)
Received: from s-machine2.. ([2806:2f0:5501:d07c:2dbd:5b7c:c33f:21f])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-734f6b3cadesm3815833a34.47.2025.05.25.20.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 20:21:23 -0700 (PDT)
From: Sergio Perez Gonzalez <sperezglz@gmail.com>
To: nicolas.ferre@microchip.com,
	claudiu.beznea@tuxon.dev
Cc: Sergio Perez Gonzalez <sperezglz@gmail.com>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shuah@kernel.org
Subject: [PATCH] net: macb: Check return value of dma_set_mask_and_coherent()
Date: Sun, 25 May 2025 21:20:31 -0600
Message-ID: <20250526032034.84900-1-sperezglz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Issue flagged by coverity. Add a safety check for the return value
of dma_set_mask_and_coherent, go to a safe exit if it returns error.

Link: https://scan7.scan.coverity.com/#/project-view/53936/11354?selectedIssue=1643754

Signed-off-by: Sergio Perez Gonzalez <sperezglz@gmail.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index e1e8bd2ec155..d1f1ae5ea161 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5283,7 +5283,11 @@ static int macb_probe(struct platform_device *pdev)
 
 #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
 	if (GEM_BFEXT(DAW64, gem_readl(bp, DCFG6))) {
-		dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(44));
+		err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(44));
+		if (err) {
+			dev_err(&pdev->dev, "failed to set DMA mask\n");
+			goto err_out_free_netdev;
+		}
 		bp->hw_dma_cap |= HW_DMA_CAP_64B;
 	}
 #endif
-- 
2.43.0


