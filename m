Return-Path: <netdev+bounces-140544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3A09B6DDE
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 21:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A7FE1F22CC2
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 20:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8EC1218D8B;
	Wed, 30 Oct 2024 20:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvlgz9R9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E719C218925;
	Wed, 30 Oct 2024 20:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730320668; cv=none; b=socYxSU/hITFzyfSvPE7TOLt5YqLIh0oOj4D9Dmzv94VIPVGh/+RFEVoSjh7zrfaARCJsPzc2Ap1zW9/zzepjuqljFqj4+04loOEvkKByiKFN/eMo2wF5Q/JgWsAugAiW9fkSxR8WUfMNZShbmt3uoPxcnl+yqiR1EkH+WxQeq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730320668; c=relaxed/simple;
	bh=+29W1hGAiiSPNBeHDHEL6mYe0YOrEjIjkU4LktL0Nk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tdTWs0z7ckaGJxa38F1d0o7ftsBOJwWRaUvSnGJ7DdkAGDs2DQkDLbZ4lWMyXT3XVUFcRlaz0lyDH4yPDvE3lFI5wsq72Ql/duIBSombC9aet89H5mZe6JzTrHBA5+M5w6fsctE4Z9egt4K4Odn2R4r4so9mxqmAic8ydEj3DXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gvlgz9R9; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20c805a0753so2813475ad.0;
        Wed, 30 Oct 2024 13:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730320666; x=1730925466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7UNwU0Pp2g8R4kSmqpFNoaUX/T46EUzMVaC6ZnQkuv0=;
        b=gvlgz9R9Y13A7jshgz/5wuML82zyfJc+EYXYBEfLDLUePmTihDtxueCjNmXujYQoVQ
         sR8TgReTVlBMEvX1Ib7ownx23dIKxO3AL/0dygsQa5sSCmjBX3y1+nyqUIQs4L7mvCb0
         mJQ1sSZQnQ0OUDhJIzSqZ+4g7DB2lnysAGkX4fkvhbkd1fIxRs3x0eLCMV4TfvuhDwpH
         QvVMS0bgnnBUrsmWnyd5I0hKeAs3v2F5siHcGAGHqmqIs+L46bocG0b2KGpha4p7Bf3K
         73+kRYAqU+rfuGVP8fN4b/UWCdQEXSkxP2GgZMQ4Y2XnTCzzq9KMQydABRm2kBTwwVQb
         B+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730320666; x=1730925466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7UNwU0Pp2g8R4kSmqpFNoaUX/T46EUzMVaC6ZnQkuv0=;
        b=SGBliWme4RGrnm2StWusSKQf2XM875+h3l1ow4iHtguqxaXE+cCdPEbuO9MidT3inz
         fXH5tkaFeKdAJgSowMYxqnRrBS8Zgvbi1aBb0JFA1wbbS6+iehdwHTAC5LmO3Wr7x8n/
         rIlJWLqc6zKUBMlaOihNdMWc5wjmfWK332Fg7i622znO17iAblW5YKTWfjzBDttK0FbS
         tGhun6w9XCexX84yt1IBXvkt1csB1yq0ZQ24ZUSf+LVoOypq6PZLPCYcfdSzyDt5ePDQ
         ahN/RofBr7daRNI0SdMx4TlExj1L9fjbH5VKrw2Me8qJw/2QOP+sXYc+erfw5HFi8yty
         TMOg==
X-Forwarded-Encrypted: i=1; AJvYcCXOfIQhwDkSNxdSu7kr2RdxSqyK2451t7np28942cuRdZJNCJogkjWYU5fOqdr0amjyfBd+8y78cFaMT64=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw95glF3G2E94C2gM+w6S5AN/yUtNd2amOJkprrfE1jZD71srKr
	eeYQlOwdfquo94FV9uh+2QUmka7h1JTLDFK3UJ8+FX62LC/lJpdbqqG9R7n2
X-Google-Smtp-Source: AGHT+IFYUUgxNrDPxXSain3rNUQ/d87FHplCyGSIpV/m2lazGrVxfpG61SeBR7BIXFI9OEKT07OwSg==
X-Received: by 2002:a17:903:1108:b0:20c:e262:2580 with SMTP id d9443c01a7336-210c6c3ffb6mr180712505ad.44.1730320665813;
        Wed, 30 Oct 2024 13:37:45 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056ed85dsm40645ad.5.2024.10.30.13.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 13:37:45 -0700 (PDT)
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
Subject: [PATCH net-next 07/12] net: ibm: emac: zmii: use devm for kzalloc
Date: Wed, 30 Oct 2024 13:37:22 -0700
Message-ID: <20241030203727.6039-8-rosenp@gmail.com>
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

Simplifies the probe function by removing gotos.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/zmii.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/zmii.c b/drivers/net/ethernet/ibm/emac/zmii.c
index 03bab3f95fe4..e9097b9ceb3d 100644
--- a/drivers/net/ethernet/ibm/emac/zmii.c
+++ b/drivers/net/ethernet/ibm/emac/zmii.c
@@ -235,29 +235,26 @@ static int zmii_probe(struct platform_device *ofdev)
 	struct device_node *np = ofdev->dev.of_node;
 	struct zmii_instance *dev;
 	struct resource regs;
-	int rc;
 
-	rc = -ENOMEM;
-	dev = kzalloc(sizeof(struct zmii_instance), GFP_KERNEL);
-	if (dev == NULL)
-		goto err_gone;
+	dev = devm_kzalloc(&ofdev->dev, sizeof(struct zmii_instance),
+			   GFP_KERNEL);
+	if (!dev)
+		return -ENOMEM;
 
 	mutex_init(&dev->lock);
 	dev->ofdev = ofdev;
 	dev->mode = PHY_INTERFACE_MODE_NA;
 
-	rc = -ENXIO;
 	if (of_address_to_resource(np, 0, &regs)) {
 		printk(KERN_ERR "%pOF: Can't get registers address\n", np);
-		goto err_free;
+		return -ENXIO;
 	}
 
-	rc = -ENOMEM;
 	dev->base = (struct zmii_regs __iomem *)ioremap(regs.start,
 						sizeof(struct zmii_regs));
-	if (dev->base == NULL) {
+	if (!dev->base) {
 		printk(KERN_ERR "%pOF: Can't map device registers!\n", np);
-		goto err_free;
+		return -ENOMEM;
 	}
 
 	/* We may need FER value for autodetection later */
@@ -271,11 +268,6 @@ static int zmii_probe(struct platform_device *ofdev)
 	platform_set_drvdata(ofdev, dev);
 
 	return 0;
-
- err_free:
-	kfree(dev);
- err_gone:
-	return rc;
 }
 
 static void zmii_remove(struct platform_device *ofdev)
@@ -285,7 +277,6 @@ static void zmii_remove(struct platform_device *ofdev)
 	WARN_ON(dev->users != 0);
 
 	iounmap(dev->base);
-	kfree(dev);
 }
 
 static const struct of_device_id zmii_match[] =
-- 
2.47.0


