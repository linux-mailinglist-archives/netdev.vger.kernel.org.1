Return-Path: <netdev+bounces-101447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6762F8FEF5C
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 16:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAB3EB241EC
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 14:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF28B1993A6;
	Thu,  6 Jun 2024 14:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qsrVF80r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6538E19645C
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 14:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683871; cv=none; b=kCUWP/2RHHniKKyDIQAd7O3ByCfFec9OYsbsqzBOXK6QiEHmehdseV8zB7wbh716EhLr0oIeTrcQJdHzk6LB04DKVq4w8r2Z6j3eX4bOPoF25FGuTffp9YlpfzCexzFoUsBKvDWQ5oNySIj7ZPt8i36SBnPNoUL0dscc93Ewsk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683871; c=relaxed/simple;
	bh=dxFGGhzrS7LrLExlJB0Xcypo/XjMKtA9vb1gGePZ7dE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y0BXSb4wlQXtlpDWyk5Ddc+nkufkKJskcihLjB3R7XLPZFkqFkhH2zTb639irAszlBNzbXUOXXr1CdfzZaALnUbr8moh4XCFqrG4G3470kl53rgbszQcSZD0wWpSdu0zF7IHbdoa9Elb7YH3fBaPURkWy7Pb3yXWe9yjCSqcTWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qsrVF80r; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5295eb47b48so1311781e87.1
        for <netdev@vger.kernel.org>; Thu, 06 Jun 2024 07:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717683868; x=1718288668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s0R2FTqs9h57UOEpdGtqZQ+WmWHV210ccwRY3/zwf0g=;
        b=qsrVF80rCPEFZznlSUlCbhZn1Z4VCAEV8jySdl9wNaHolJRwkEDIP7wIV0XjE9YIS+
         CgQcTr6C+e60KKYRypTvWdqhEBO/0cwuOZg9OkeyjD9mao4wTyTVxZk2j+MBhA/YHoI3
         bVEBpr6JfjNXED57BcQwiGLqAZXd7f2Yzv+R0YO0giATtA8//AVpuODKaL3ksgd1Lc9Y
         gu0Zbsf/liwc/kozAycb/HPT0d9xu4ZC2w6mMAW4rZPg+hr3tP8c7C3tSg8q9vKMHPX9
         J5BcmLTuEKXcLAZsu6pOL9m2Plw5QT80cknHl1xtcOSIhVyqqrd8MdW/JetSv+QmhK4j
         QFMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717683868; x=1718288668;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s0R2FTqs9h57UOEpdGtqZQ+WmWHV210ccwRY3/zwf0g=;
        b=Wyt7WMx9LQsF4VSGo6sFx/Yz/4kj/vp3D3mDgF1qJwp5E5bZWYx+umLarhhrnYj+aU
         I+eX3NwGkMcs01PUkMUahwyLS3oF+jYxsvhh410orfXNfT1F7rzzqdX0kqPqgVhq0mKB
         nEpb9c1831UVCQz2H8ZQZ7hIyHKfBeBnc62LHXi0i9mctWDmwOuHUkvjvPO8T4s6QHR8
         113s4GTdfJWfbdjhWfX/uvyGUdPnGnfM9j1gA3VqDJw/1tqNvNa7qu3kwOEbqCmz9wGi
         wdwZSIzlMhN+qW29ek3vt+zMw9e2yp7HkQwxMu3gqZCsBAIxBjX8G8qom4b436+ilzMF
         M53Q==
X-Forwarded-Encrypted: i=1; AJvYcCXoFY7AxR7wC4MVL5bFjsejc3qNiQCZBn0bb0TnoO6pHZ5EkkDO0SOjTaggwGt2PJ2GWnVXB75V/YbgLsJAXWZc2zOVVw0o
X-Gm-Message-State: AOJu0YydPt3E/fVwheZcsRPbgcijjTmQl7E3wS4je2GLkPE8EwiW9ym9
	FSUtK1Q73IoC+oydr3uWjft6t+YOif7PAVptJzSgzE8qiMklGYwnda31l2SjV8E=
X-Google-Smtp-Source: AGHT+IF2Y2cO7geMFPXXxqbIXWUwXl2dSb3X6DXNOt4MeEsT3SiqSkUR2bYkClLkKDNyX3YkIQLemA==
X-Received: by 2002:ac2:4906:0:b0:52b:79a5:517a with SMTP id 2adb3069b0e04-52bab4e5283mr3281219e87.33.1717683867645;
        Thu, 06 Jun 2024 07:24:27 -0700 (PDT)
Received: from krzk-bin.. ([110.93.11.116])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52bb423ceeasm211659e87.185.2024.06.06.07.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 07:24:27 -0700 (PDT)
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
Subject: [PATCH net-next 1/3] can: hi311x: simplify with spi_get_device_match_data()
Date: Thu,  6 Jun 2024 16:24:22 +0200
Message-ID: <20240606142424.129709-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
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
 drivers/net/can/spi/hi311x.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/can/spi/hi311x.c b/drivers/net/can/spi/hi311x.c
index e1b8533a602e..5d2c80f05611 100644
--- a/drivers/net/can/spi/hi311x.c
+++ b/drivers/net/can/spi/hi311x.c
@@ -830,7 +830,6 @@ static int hi3110_can_probe(struct spi_device *spi)
 	struct device *dev = &spi->dev;
 	struct net_device *net;
 	struct hi3110_priv *priv;
-	const void *match;
 	struct clk *clk;
 	u32 freq;
 	int ret;
@@ -874,11 +873,7 @@ static int hi3110_can_probe(struct spi_device *spi)
 		CAN_CTRLMODE_LISTENONLY |
 		CAN_CTRLMODE_BERR_REPORTING;
 
-	match = device_get_match_data(dev);
-	if (match)
-		priv->model = (enum hi3110_model)(uintptr_t)match;
-	else
-		priv->model = spi_get_device_id(spi)->driver_data;
+	priv->model = (enum hi3110_model)spi_get_device_match_data(spi);
 	priv->net = net;
 	priv->clk = clk;
 
-- 
2.43.0


