Return-Path: <netdev+bounces-178624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACEBA77E47
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 16:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CB3016A469
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 14:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C79B204C23;
	Tue,  1 Apr 2025 14:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqqB4upY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950521EBA18;
	Tue,  1 Apr 2025 14:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743519226; cv=none; b=GLFx9joDiHZLA808RNjjyCFYqpgMQKJS+TH5q0agg3DdzlIzLzx0/fslea8u3Ajb5yamvGttIOZphDf3Oec6ye5WG1/0Z0NXXcnpmI7vScom9Bk5RzeVIrSBYSMZQeyRfga6bTwqjMDshNL8aRu+QSWWNN+PLKdLt/gLr9xinf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743519226; c=relaxed/simple;
	bh=4FkhmSzO3emrgAKl7jpt/VDBlwXggkwj7CCDI2+WVkY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QsZkD5j8t+YO3nxmWQHw0sv+nxDct/czaSN62TZkC8DE97Vy43iev8aOTusDlMu4oku6cyWodpXqjwj6y//TMDN9YQjVTI7sw+23AMnof0/ym1URJYz7u2EjI/7eWs22IuRBjChA2+mFFdydsqsS4DvvIcnm9s84es4tOqopBHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iqqB4upY; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-223fd89d036so120035845ad.1;
        Tue, 01 Apr 2025 07:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743519225; x=1744124025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3shcPmJPyywfUEnkc1vsjK39f5Wjo5m/FVotOaA0e0o=;
        b=iqqB4upY73Bj37kDfmmxfDbT/UhlP/4TlDRV74P5CzVkcECJ7KwFtH6kP1qHqyDNZa
         umTTc3xjmm48dtjPxAmdqoTozq6e1yWN/GTtR7eD0Y51qpCHudnfXxJRhv3YPZBeDAOF
         8SkQ/aACKh6eYqtARTOylf9uqnUYyLKHzFjWvJWTiazEzAeDa8YfGTMtCmbjnNCwA9wP
         7/tmQYrGgBD1tR2H/g8kZr7+cDZPcRFpYHZmBtbHat0MFxo2+ba188/ADMExuqZ/n7VM
         y1jF5+9boWRxoSK7HWeltnR4bMOR+2M8AWQCI74f60MvuyJOGDA2nCljQ0FbJTmqqg5/
         f/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743519225; x=1744124025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3shcPmJPyywfUEnkc1vsjK39f5Wjo5m/FVotOaA0e0o=;
        b=O71O1aCvVMc4fNULfpah1ZLwjgYWKMwGPpdDJlhuCJIdWEUJbGKmxszq6DRwvX6Ivi
         ZV9Aj07iOYLf40Yq6IEUL6Qn55O7vWZiwYGGWdQVl8aEwnFTGUa9MzXkEsukwhABKkCO
         ItC8XrkfmUwLsPl2o8vG1haWWlnLbjzntWe8SLqeFL1VuJ+QJ3tI1EYZ5i5rL8uL1oaI
         wHCPGgYapythEb8+Zn3rDsbPDuNdXejGgMssZUpleri0EF3tanrPPhbRRStf02lBRm4Z
         Lb/pTPf4jEFhzuYfI/u5OPMJcLw+fs0iOs/nIbaNtLnOE0YlLVMekedvzGjhwFSYT86h
         84mg==
X-Forwarded-Encrypted: i=1; AJvYcCWE5LmSl+C37xs5+NnWEK1q4kZOyrcfbHS4J0crnYnSOfVXCvKd3J3oa0nfTHtnZ/ghKOLN5WuVo7Ztliw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9xcxo7Oc3jpmogQ7BJh4mo1fmMTBbgcrhHBXIXCVsgqkVJVJt
	ML55swzzqA79IotNyTjOBYyAZt7ULowMZiMb9GtqJSMjNNw2oULY
X-Gm-Gg: ASbGnctijKPt+JTDuhR3iS2damE0ZlZi5fw3YpLZs7qEstLdGM3tDG+O97y079DjXkz
	tmgTgN5vAEgxBljxAF0WUCoiISD2dmlVgWhdUPap/EW6XWQIAzvxZpR3JycTPY2h/kF2T3qG1J1
	xI3hWeNIKAuIo32Enerq2ljDDmR2ayL6k7hhSytsHSsFySSUT3Ezmj9EP7RFfkdJ3D2MQWzMUMF
	4hKC7avdNlBTUqctSVt4xwKw5NOfi/jhXSrWKCZdCAeF13OhXtdrh10CXReastaKT5MY0UBXg3E
	QROAg4x4mfs03qABsyltFoUSF2FvCUumU9pyaxb6+aq3HSEzrhaVwO7Zm/ySCDZuNzA6VScKXHk
	2k2ZvdA==
X-Google-Smtp-Source: AGHT+IHdkBbOirJYaDO1sQGf9Q7L4Q9mqibWfxg/zzY0BD6PotqX7PXBZisjT7998z6JnyfaOlMdFg==
X-Received: by 2002:a17:903:2350:b0:223:628c:199 with SMTP id d9443c01a7336-2292fa1adeemr168194185ad.52.1743519224760;
        Tue, 01 Apr 2025 07:53:44 -0700 (PDT)
Received: from henry.localdomain ([111.202.148.167])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739710dd3d4sm9244310b3a.177.2025.04.01.07.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 07:53:44 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: m.grzeschik@pengutronix.de,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>
Subject: [PATCH v2] arcnet: Add NULL check in com20020pci_probe()
Date: Tue,  1 Apr 2025 22:53:30 +0800
Message-Id: <20250401145330.31817-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

devm_kasprintf() returns NULL when memory allocation fails. Currently,
com20020pci_probe() does not check for this case, which results in a
NULL pointer dereference.

Add NULL check after devm_kasprintf() to prevent this issue.

Fixes: 6b17a597fc2f ("arcnet: restoring support for multiple Sohard Arcnet cards")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
V1 -> V2: Add a test after each devm_kasprintf().

 drivers/net/arcnet/com20020-pci.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/arcnet/com20020-pci.c b/drivers/net/arcnet/com20020-pci.c
index c5e571ec94c9..b848968d6c9c 100644
--- a/drivers/net/arcnet/com20020-pci.c
+++ b/drivers/net/arcnet/com20020-pci.c
@@ -251,18 +251,25 @@ static int com20020pci_probe(struct pci_dev *pdev,
 			card->tx_led.default_trigger = devm_kasprintf(&pdev->dev,
 							GFP_KERNEL, "arc%d-%d-tx",
 							dev->dev_id, i);
+			if (!card->tx_led.default_trigger)
+				return -ENOMEM;
 			card->tx_led.name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
 							"pci:green:tx:%d-%d",
 							dev->dev_id, i);
-
+			if (!card->tx_led.name)
+				return -ENOMEM;
 			card->tx_led.dev = &dev->dev;
 			card->recon_led.brightness_set = led_recon_set;
 			card->recon_led.default_trigger = devm_kasprintf(&pdev->dev,
 							GFP_KERNEL, "arc%d-%d-recon",
 							dev->dev_id, i);
+			if (!card->recon_led.default_trigger)
+				return -ENOMEM;
 			card->recon_led.name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
 							"pci:red:recon:%d-%d",
 							dev->dev_id, i);
+			if (!card->recon_led.name)
+				return -ENOMEM;
 			card->recon_led.dev = &dev->dev;
 
 			ret = devm_led_classdev_register(&pdev->dev, &card->tx_led);
-- 
2.34.1


