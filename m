Return-Path: <netdev+bounces-178816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FD0A79045
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 15:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87200171B5C
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 13:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8223323A9B0;
	Wed,  2 Apr 2025 13:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mG4IBJyL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042221DFF7;
	Wed,  2 Apr 2025 13:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743601847; cv=none; b=T3eAB8hLri2mwuaeJHTMnxX2XNI4W5q718JnAfXiEh5S7X/rw6BVLGGLJYyhDB+O3E9i0BUjm8DrVyw8n+qS1qtajcYRtyILG4gyip4GvoG36S/XO48whPdmIUbWG0klok0j4j1kORo9aY8RKLR9ytuwhPb14LzP9XvbW9uN1OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743601847; c=relaxed/simple;
	bh=r4I+uoYa0hZKd3pO7uuNLQmaLp0lpziSguB3WKXNzi0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m/J+eVSwML6KYOplTuxKMDeugI5KXF60KgKp4FgRKeJ8g2Az/ec/qgg4phWtLW5I/1UFtQRaEhBGAox4gxM5xMOhkHVRt/2azqDkqiUPgLW7KPiTujCkMKUqPfOviYMkn4LQYK6INOIAo63WviSnvys5i6qDPZKxKGHZU4crrUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mG4IBJyL; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-22401f4d35aso131181375ad.2;
        Wed, 02 Apr 2025 06:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743601845; x=1744206645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rIOO0RX/K5KkOu+JztllmzVSVHzx/kVyU+bn7Yx0fOQ=;
        b=mG4IBJyLMi5zPcA7BGRtuvpaGQQyanbGQN59eUmuIN5mRceurSyCLEU+687Y2taCis
         GT9ybUwV+U6St7KHzUVbCj5l1EAXo5BuDiRk7BYWR4CMOn+3UvLwLqct/O0nlIzIfmQD
         D7x74lShdKJ4fd7jBFKtpg89hT2UQs0zajVofMGR8+sBrd3aiCyh5noHgUU5u/jEhzNc
         Znj9eF7F7eiQjxXqhNUzXh/BAUwpq1QhLS0YICiYuXJ0B1ZnkskRntHaUi9rtLYydw40
         uTenJicPNriZuBmo6p2dObe5oOX9jKeq9gUsbFEJc3/AASb4zhCAhJZ9ikS7jCi02V1W
         fubA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743601845; x=1744206645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rIOO0RX/K5KkOu+JztllmzVSVHzx/kVyU+bn7Yx0fOQ=;
        b=TqIxAxFLAdmzS0Lu9mIpDDBaUiJZLo1RSd0V9+G48aToft+8ho9beF52YrXVk6Gr2C
         LmGgMYerqg7F+zFap5FiI/ZcoH2qi33H+1tM4qgl+xVVe1lxuM0z0BYVdl/oIgsTw1oD
         uBzYZyMxmRe6cYrPbh5BKvQrWE7d29mGCHUHpyIOGSf1ATjvUrZ5KtV5M8rmhsKrBBSU
         D1NQQpwi5foV2YEztVjuVdNw4Gi9MqFkqZW8ziPbHcVcwE/5BmoEY7wxPgWCUjF22ODJ
         YJFch+bZYXDpibT554lo0tTs3B5ffOWs17fpVl3RJnLfEOAMb3cenbkOIyHpQc0pXHlK
         3xzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUg8XxR9k/iOKkiB1uqpIWXQFuddSyhSU+rsWqkTu6Kas/NDdCiJFXEc06bbxV07OL79GMV7nzbjHZ7nm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiWgtq1I+rVm2OarTPUPfBKkYBePxKpLWSNApD6yztrL3Z3uhC
	iXS1RWsJFPZJrHk7v/fjCjb97yxaUkuPVOwwvzaeWOANWRmIWOe1
X-Gm-Gg: ASbGncukfobdCwpSBYDraPegqQNqgRLI7C2dmHI5RwzERZgrlVSunUNH8GsWmXvMYEX
	ryEOY8Rh9H34G6pChJsZxyAwrF6nsS9K+f3Bjkq42lrO76jUuT4o0Usyuy+EPuxESvb1czVUNxd
	t98yQ54i5EZo744Gh3Rb51cT7u6/T2bOnAqjJ/6/N7PvCeBXwcNOHxiFZ0FkSrdb5IceB8B0zN3
	BtlBFMgkF/XovUQ6K2UgiPLTqdyxJuhUzFj5+4ixEhC2uzO9U8wM5eKJnyRturC6cClxniUAmH4
	nQ1LAgiZuXUN2TdZBUd8M+m7lNrfQ0Oa5jqfjLvlZZay62y+zjWQ30A8WMog3N/msvzX8Cs=
X-Google-Smtp-Source: AGHT+IHo/p/gGQJd/YdAzTR1DUcuJESA6Rxl5GAJP1rddIxYQIkiEv2jK16daHUY1yK+mQvCwY5IiQ==
X-Received: by 2002:a17:903:2312:b0:223:fb3a:8647 with SMTP id d9443c01a7336-2296c8606e2mr34093985ad.41.1743601845042;
        Wed, 02 Apr 2025 06:50:45 -0700 (PDT)
Received: from henry.localdomain ([111.202.148.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291eeca24csm107969895ad.25.2025.04.02.06.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 06:50:44 -0700 (PDT)
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
Subject: [PATCH v3] arcnet: Add NULL check in com20020pci_probe()
Date: Wed,  2 Apr 2025 21:50:36 +0800
Message-Id: <20250402135036.44697-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250402090751.GH214849@horms.kernel.org>
References: <20250402090751.GH214849@horms.kernel.org>
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

Add NULL check after devm_kasprintf() to prevent this issue and ensure
no resources are left allocated.

Fixes: 6b17a597fc2f ("arcnet: restoring support for multiple Sohard Arcnet cards")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
V2 -> V3: Reuse label err_free_arcdev for exception handing.
V1 -> V2: Add a test after each devm_kasprintf().

 drivers/net/arcnet/com20020-pci.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/net/arcnet/com20020-pci.c b/drivers/net/arcnet/com20020-pci.c
index c5e571ec94c9..0472bcdff130 100644
--- a/drivers/net/arcnet/com20020-pci.c
+++ b/drivers/net/arcnet/com20020-pci.c
@@ -251,18 +251,33 @@ static int com20020pci_probe(struct pci_dev *pdev,
 			card->tx_led.default_trigger = devm_kasprintf(&pdev->dev,
 							GFP_KERNEL, "arc%d-%d-tx",
 							dev->dev_id, i);
+			if (!card->tx_led.default_trigger) {
+				ret = -ENOMEM;
+				goto err_free_arcdev;
+			}
 			card->tx_led.name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
 							"pci:green:tx:%d-%d",
 							dev->dev_id, i);
-
+			if (!card->tx_led.name) {
+				ret = -ENOMEM;
+				goto err_free_arcdev;
+			}
 			card->tx_led.dev = &dev->dev;
 			card->recon_led.brightness_set = led_recon_set;
 			card->recon_led.default_trigger = devm_kasprintf(&pdev->dev,
 							GFP_KERNEL, "arc%d-%d-recon",
 							dev->dev_id, i);
+			if (!card->recon_led.default_trigger) {
+				ret = -ENOMEM;
+				goto err_free_arcdev;
+			}
 			card->recon_led.name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
 							"pci:red:recon:%d-%d",
 							dev->dev_id, i);
+			if (!card->recon_led.name) {
+				ret = -ENOMEM;
+				goto err_free_arcdev;
+			}
 			card->recon_led.dev = &dev->dev;
 
 			ret = devm_led_classdev_register(&pdev->dev, &card->tx_led);
-- 
2.34.1


