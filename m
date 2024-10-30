Return-Path: <netdev+bounces-140545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA7E9B6DE0
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 21:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7DE9280DE1
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 20:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D90921949F;
	Wed, 30 Oct 2024 20:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0Hqg9vM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FFD218D62;
	Wed, 30 Oct 2024 20:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730320669; cv=none; b=ZrxGPsmzhHlMV5YuEDLp7x1YyvsD+pawgTk8UpZdy5Hx9m1i7W1Drrw36Yui+UM2EpTfTxdw62l1nDwjKacc+Ji4J/5sLoAMn/3x9L5jUFCM/syilawqoeRQMRVCnEtI9tRtbri2Pt02DUU435DRd6OmGkMMBokktPlRDJAh0Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730320669; c=relaxed/simple;
	bh=rCl9KUSKOelviF42N+RjutZ3gn8ll0dQ23dBMW+WlIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FTtDmqWe0weMzAOBapE4OVNGo8F22c2rqpw5Da8YNkmX3QGOP3g/5my00RlMlQSh/5NDJ36N4H9lepo+OJzL3J2hje4oRpUFxjblqUbhQPpKcbtY46IVrgnIpMvdZ/srmy16aNWJDb/6C8rLkHAm8mi3sgR7H9r0JbaUGlWJeKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W0Hqg9vM; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20cdb889222so2661865ad.3;
        Wed, 30 Oct 2024 13:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730320667; x=1730925467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zLiQhACMTYsRCBHRriNGhiQgk9Pih5KygQx6n+YOD34=;
        b=W0Hqg9vMTgtjwed6QhQejZ7NpYi7mB6GgHHmy2HEMLgSMP1SLSv7zq9fdMSXa1IInu
         iqiemAbdi6HcYr+tvulSGqw2rHJFOP99pgcXFrDcLSd8jBM+aQXhMN+dvB1nK07y3Wk1
         oaqTJAy93/Mvk8eWQuro09y85VINaNyA9MVn+salm1CBOaVMOlK0TB7b5wL7+1L6REC4
         R/airSQyZ3S6+HQyE2kzvq2kDTTLQM92++kWl/jk6kJO9FZXqsBbq7L+lT5gseGqouna
         ejj8+8BQVOFyzhPS11WpN2+HjTu2tp0m34UK8a7A1Obpk1fCYJlW1uaSH99wq2lVIeWO
         3hWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730320667; x=1730925467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zLiQhACMTYsRCBHRriNGhiQgk9Pih5KygQx6n+YOD34=;
        b=fNrzfLpZH/f52mt2PZn/qOSFvVI8W2EfwrvtIJ69/9iPcpZXZvwAOz3muDUQlMKzMa
         9M+LOaph+5Kg7pSzsItLGOD0oXVbv9M+ffyQk3g2ykn7a2R6NcsabWkLwrbMZ2vO9mtR
         32PG1ToVecvD94jL1ldBZMbsvcGcnhU80H/fQzfhKayMAXg6YSUpX3hisPHHlKDiTm7D
         t3D4YwysAokMpCBCALSYsSJtRNi1thDoprzdGiyOuZllkPRfexpPN+l1Xrm3DNktPCzy
         Vdifg/H6FeiYXUvCn46wkldM6BxM89F1Awoa/WYSXzuQymmE9vA6l9R1PzmLQ3feCDRe
         rIgg==
X-Forwarded-Encrypted: i=1; AJvYcCW/eSf0KaY8OwxJy5fTYKN30QpdEIgD+c0ggfqXVNe8Ug60kBiDsF9sNgovTGWmjPko1ICXH76JDkQutMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAN6Ac8btA+nyovsy5h7no+P2m4V0PRaU6wkm9ah3XymoD1pNw
	Lu6F4nNhxeEkupUaH0h1k5cqY/BiiwyAh+b6s4f61d5thWzufKxJmSd2f/bQ
X-Google-Smtp-Source: AGHT+IEd+FXNwDj5VgJj3TSE8VWyd3/j+oKdoAK5NMAcab9IKqXGydMNJgIMmqKuG88zHnJ2xwtx3Q==
X-Received: by 2002:a17:902:cf4c:b0:20b:7be8:8eb9 with SMTP id d9443c01a7336-21103c971c0mr7910975ad.54.1730320667235;
        Wed, 30 Oct 2024 13:37:47 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056ed85dsm40645ad.5.2024.10.30.13.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 13:37:46 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rosen Penev <rosenp@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 08/12] net: ibm: emac: zmii: use devm for mutex_init
Date: Wed, 30 Oct 2024 13:37:23 -0700
Message-ID: <20241030203727.6039-9-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241030203727.6039-1-rosenp@gmail.com>
References: <20241030203727.6039-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It seems that since inception, this driver never called mutex_destroy in
_remove. Use devm to handle this automatically.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/zmii.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/emac/zmii.c b/drivers/net/ethernet/ibm/emac/zmii.c
index e9097b9ceb3d..cb57c960b34d 100644
--- a/drivers/net/ethernet/ibm/emac/zmii.c
+++ b/drivers/net/ethernet/ibm/emac/zmii.c
@@ -235,13 +235,17 @@ static int zmii_probe(struct platform_device *ofdev)
 	struct device_node *np = ofdev->dev.of_node;
 	struct zmii_instance *dev;
 	struct resource regs;
+	int err;
 
 	dev = devm_kzalloc(&ofdev->dev, sizeof(struct zmii_instance),
 			   GFP_KERNEL);
 	if (!dev)
 		return -ENOMEM;
 
-	mutex_init(&dev->lock);
+	err = devm_mutex_init(&ofdev->dev, &dev->lock);
+	if (err)
+		return err;
+
 	dev->ofdev = ofdev;
 	dev->mode = PHY_INTERFACE_MODE_NA;
 
-- 
2.47.0


