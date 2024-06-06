Return-Path: <netdev+bounces-101448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C50508FEF5E
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 16:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C81401C24261
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 14:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26351A2C21;
	Thu,  6 Jun 2024 14:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U9uM23Hl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D3D199394
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 14:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683872; cv=none; b=UisBwNL6zSxcXpPzdP+e7pgQetPFGOp7ykKhRHAE2B2Jv8EAC1aXQQFoVs2dXYjUwhlQK8QFfO+bYMGGS0qTdOZwOCBaPWSRwWhnTSxNUT218m1KyasI3NRO9qPcReMtCuoAjaoJ0MkVWJ8hFSCNx3pPubguBdZ+dplVWuBOMfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683872; c=relaxed/simple;
	bh=ZBbi+lp0LjKTZzWwECBjKHrcXcDJTSGheSra+uYGleE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I4TXXCzLvuERrgofIj4w9CWK8cFuW3WWlJiTjbmZatMP3RGOhe+8aSkvnOnN588nbIw1ictjnxkHAGcOaYkow4sJ41xSjhSUPJoRRdyJzjkisSBLbJTaM6jJTzDu0luJIX3VHXnhXCTWcnyJHBJDW7o+8qDYYhQUjO9wGLUgUuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U9uM23Hl; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52b8e0e98adso1562118e87.0
        for <netdev@vger.kernel.org>; Thu, 06 Jun 2024 07:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717683869; x=1718288669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=adPYuwzND43MGJ8XDbcG7/Wy5Ym6DF8sMplXI10tv3c=;
        b=U9uM23HlvcqKtRBeUesYq/9U09qNrNO/Jiv0nT1spk1WF/ZY+3tgyeOd9YTWmNJwes
         +n/p9rU/zG/A/kcEXF6lnbRvZABK/7sfva20jkVOOcJzO+tcdpMZO6Ov4DQZIrfhPVKE
         RHlmuZteCqIUf7iy8754BU8o6pRbAUkAcnHvAqCHiQTC2y2LDtC20PNe9D/x8a4I0uSl
         WGIuDYYMVzHV0bJ8uR6dyk2iQQZ4d3Qj5CwNpJQwhJYwhBRP1gLBCN6Q1ExHoWd63cqh
         YZOvkHvIxsyqGSMZjr0iGNyxKCDlsTvm3QoufyckriipaVyI3jP5o5PEWfC9i1ABd5mq
         BpYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717683869; x=1718288669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=adPYuwzND43MGJ8XDbcG7/Wy5Ym6DF8sMplXI10tv3c=;
        b=TGWaibq57gVaczDZARXW/AqyRR3qGs6cxUZQ/Mi7jPWDXnxU8JsczQQ60bQ6Fbk6ih
         w24Dx4EzGrBuwTWhWTBi8TGOVs66vl+Hohg75vsHHiVoCqCEcBTbdnWbMOEZtRt8nzSJ
         lQCtEMj/xNNNoT2C6E35QG4VcXU+YmC6Yr+Ahelu/bZiQNU9nzjsdIrbjULyAwU4cH+c
         lpTFzFJ8QA94py09VxfjVgukLuAmJk0ZaCcSFEG4ZGKg/5pU7mJhswDXtyGI+fRaBB+T
         Db8j9zzHItAr87yzdQ3gqpY7SRAMxlYoMhYfkGFtWWJ89zuMiTqlTKcY3usfCIYGcdKB
         a/vg==
X-Forwarded-Encrypted: i=1; AJvYcCVXZ3hpykPvwJDByPBqtF901gV8QjXTiBTd2FigI6VBuroUYvH+yBYt5UX3koqX1ivWTjxm5Huzy8C/M2469Awdm5ESBeRw
X-Gm-Message-State: AOJu0Yzw6eDQSw0aPpS143lJG7oAz39O70YeM0O2P8L3LBljTNBO7CHc
	tsqxw5g9h2Z7JTH0Y69H9LNXKzBuWFCaeZRykGtdzqD5BcgKH9aWsacsbu3mdL0=
X-Google-Smtp-Source: AGHT+IEq71kXnNrBuSLPtc6t7FA3EOuDZXOrq5ZDO002bnc0f5Xwz0UNijcj7UFoFYFcYsbxNeK+xg==
X-Received: by 2002:a05:6512:3d0d:b0:529:bc99:1cd8 with SMTP id 2adb3069b0e04-52bab509406mr4685409e87.59.1717683869546;
        Thu, 06 Jun 2024 07:24:29 -0700 (PDT)
Received: from krzk-bin.. ([110.93.11.116])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52bb423ceeasm211659e87.185.2024.06.06.07.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 07:24:28 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Thomas Kopp <thomas.kopp@microchip.com>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next 2/3] can: mcp251x: simplify with spi_get_device_match_data()
Date: Thu,  6 Jun 2024 16:24:23 +0200
Message-ID: <20240606142424.129709-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240606142424.129709-1-krzysztof.kozlowski@linaro.org>
References: <20240606142424.129709-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use spi_get_device_match_data() helper to simplify a bit the driver.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/net/can/spi/mcp251x.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index 79c4bab5f724..85998b4b08c3 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -1301,7 +1301,6 @@ MODULE_DEVICE_TABLE(spi, mcp251x_id_table);
 
 static int mcp251x_can_probe(struct spi_device *spi)
 {
-	const void *match = device_get_match_data(&spi->dev);
 	struct net_device *net;
 	struct mcp251x_priv *priv;
 	struct clk *clk;
@@ -1339,10 +1338,7 @@ static int mcp251x_can_probe(struct spi_device *spi)
 	priv->can.clock.freq = freq / 2;
 	priv->can.ctrlmode_supported = CAN_CTRLMODE_3_SAMPLES |
 		CAN_CTRLMODE_LOOPBACK | CAN_CTRLMODE_LISTENONLY;
-	if (match)
-		priv->model = (enum mcp251x_model)(uintptr_t)match;
-	else
-		priv->model = spi_get_device_id(spi)->driver_data;
+	priv->model = (enum mcp251x_model)spi_get_device_match_data(spi);
 	priv->net = net;
 	priv->clk = clk;
 
-- 
2.43.0


