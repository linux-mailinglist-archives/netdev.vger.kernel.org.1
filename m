Return-Path: <netdev+bounces-130656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D6C98B026
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 00:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5218D1F2322B
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 22:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007901A38CB;
	Mon, 30 Sep 2024 22:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZO444W0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A65C1A3055;
	Mon, 30 Sep 2024 22:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727736072; cv=none; b=Z6ubeHznivqNWh8QBl0rOar9fnxTXms/EDO38NUQHfCCMvDjFKFgRgYrieVV5qlHMlzdwWeYsDMX04Vc6SnlyFNL2YJuinHui/k/C+h6f6xLVA3+0X6+RKeZ9UBvU0StO52FGoGk1mCwm9Rduy12nZmyDgw/bH9tB/OgGoHhUSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727736072; c=relaxed/simple;
	bh=8IiCzwGKIwb37DfUyFbvLs9jfmb+OQepO33PB7ogdd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gqdUuNu7WdXozIdsZQSmWGRpl1I7HbQcR/c47ypW80NKhVreHuZsTQ//13VD/zHQMJq/F9Gd27vL14JbvU3FMjNOsH9/ZRSWiuzlDW8j8Irb0I/tBaMZVvkeL8/Ptwh6F1BxqZwcOLdTvbKJyQSM6qwyH/1JLWpORwoh4qm7OV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dZO444W0; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71b0d9535c0so3417676b3a.2;
        Mon, 30 Sep 2024 15:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727736069; x=1728340869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kIGQVSC8663lz/zqOAP4sD5qctnun30Gq2oDBE/53KU=;
        b=dZO444W0Wk60bp9yWso2R1zDRev0LIamwrb0nSrX42fQWxVFJdBxmHj00inBkuyD2c
         kJ6VjtxGsDQQDzl+RSBHE4xafc7U7Zam8W0G9YxzHRIIslUeJc5iNiEfXon/95xHWtTb
         BzuwvTj2kHWwe38EeBeZE95qnzbj0Na8HEVY81bUWT0/kC65ZYsUZFf9qaZbl3uDVtWp
         bziYJmBvUYjRtC77GLRwZ/qM7r0TJE9FG6Qa5kiJJAjE217eqvgc7wtZ2qZ6ZajImnKi
         8kvz7FtY2XbwW9487BQ4Nc/w1wrIBbkhRSo65clY8Ng7vf5Og4wdguRXKVvw+5GyQfnC
         T/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727736069; x=1728340869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kIGQVSC8663lz/zqOAP4sD5qctnun30Gq2oDBE/53KU=;
        b=IJR44U0bydy03ZNPUzTrJm0uupeiMYL01bgoIiXEQ3Zr1RnVJO+2D5FYsl5xuzs817
         ReDoW5lOCoR//whqNH2IE/Ywimn5FFbwm6awa+bhk36+ppLHguSbFeZg70Wv/bn8LFIr
         mTSO06tzQHKTb+6WG7YAhPUnrHRigu8aL3OaqPrXqDh60sgP4ryXjdI2g3RAEcpD2h48
         Ph/uKYVc0F7d0aA7wQaRsuSkHcPvennkOPG6zwJ40qlIRW8iREuZN5o448lEN0X7N6hN
         dqnXpRRyl7KuT5MIbSo7hJsgeIhxJosCepD98YMwG+cTjVQ/SARw1AtUDv2wt23wJcRG
         FThQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLUEb1zFB+aL/VoeQodsj5QmosTmtPOk5/uBvue9QMK6Tnq3z3SgHyJ02GQQN0gM1Gb+n+GXIE/PTzDcA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtuQY7jvmVL5UQhMXxDIuHPBj94oHk9nAY4is6bLAserQWnaG0
	3NAyELX2ysllraLiHQiIf/mqSCmhbE9LXGBPfKSLrXfzDiGjPEE4+c5mB3oU
X-Google-Smtp-Source: AGHT+IHoIr3EZcchDHINeOyI3s1TIx2YDqAOXi8em11nNeEQMidqglapMlkLQM1Z2d05xdXBAjI2YQ==
X-Received: by 2002:a05:6a00:114e:b0:714:1fc3:7a00 with SMTP id d2e1a72fcca58-71b2604408bmr21061635b3a.18.1727736069162;
        Mon, 30 Sep 2024 15:41:09 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26515e40sm6786921b3a.117.2024.09.30.15.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 15:41:08 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	steve.glendinning@shawell.net
Subject: [PATCH net-next 7/8] net: smsc91xx: move down struct members
Date: Mon, 30 Sep 2024 15:40:55 -0700
Message-ID: <20240930224056.354349-8-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240930224056.354349-1-rosenp@gmail.com>
References: <20240930224056.354349-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These are only used in these functions.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/smsc/smsc911x.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/smsc/smsc911x.c b/drivers/net/ethernet/smsc/smsc911x.c
index e757c5825620..5eea873db853 100644
--- a/drivers/net/ethernet/smsc/smsc911x.c
+++ b/drivers/net/ethernet/smsc/smsc911x.c
@@ -131,9 +131,6 @@ struct smsc911x_data {
 
 	/* register access functions */
 	const struct smsc911x_ops *ops;
-
-	/* Reset GPIO */
-	struct gpio_desc *reset_gpiod;
 };
 
 /* Easy access to information */
@@ -378,14 +375,12 @@ static int smsc911x_enable_resources(struct platform_device *pdev)
  */
 static int smsc911x_request_resources(struct platform_device *pdev)
 {
-	struct net_device *ndev = platform_get_drvdata(pdev);
-	struct smsc911x_data *pdata = netdev_priv(ndev);
+	struct gpio_desc *reset_gpiod;
 	struct clk *clk;
 
 	/* Request optional RESET GPIO */
-	pdata->reset_gpiod = devm_gpiod_get_optional(&pdev->dev,
-						     "reset",
-						     GPIOD_OUT_LOW);
+	reset_gpiod =
+		devm_gpiod_get_optional(&pdev->dev, "reset", GPIOD_OUT_LOW);
 
 	/* Request clock */
 	clk = devm_clk_get_optional(&pdev->dev, NULL);
-- 
2.46.2


