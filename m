Return-Path: <netdev+bounces-101449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 802E18FEF61
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 16:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E0C6288626
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 14:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FAF1A2FA2;
	Thu,  6 Jun 2024 14:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WeROrlgf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A631A2C2A
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 14:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683875; cv=none; b=Nada5dhypzkcBdUV/oE6YX/4jTMrWeUEEhEnDUUjpbFwXeQy8jTkxYbU7ME6cHbJRLPTt+rJdIMR3uawNR/vLypwbsLxKYa8SrySPQe73pj9JVyiN5gg6paZqM6j4CC31csBB04kwK4hbiyqjEVZyuMtGmKHpedtzFZ/Bcics3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683875; c=relaxed/simple;
	bh=8XJvY4PRNd7QP5IlcghDRm7uf8FuIIF+wmBZT8DMjQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OVb50F44/Dhle8QvyGymHWEWyWsBJb3dtufVrYf4i2vpw8TCe2oFaMDWDNUwEX/9Ti1E1YqwlyqGITPaBbbiZdsEd1HZqQ0eRVMaitvUAgGnn7gC6XjwcsZzlrCNZbY4Wtj9fsoQ0Y5QDv1Iasg44cED0/yqPakLJV0McR13WIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WeROrlgf; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52b9d062526so1181067e87.3
        for <netdev@vger.kernel.org>; Thu, 06 Jun 2024 07:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717683872; x=1718288672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++6vpzo3dEirc2BXnRm0i3mFbJVPl95CbYYtfzrVJSQ=;
        b=WeROrlgfNQ1p0/j3NdlyeOT/+NO75Z1fur4SfX8sst39SBCzDJcHmKeKIxhpsn8SI+
         currbqjo+DETlrHvAD+JuWpMLoTzVbIhHluRjtNeJ8OV9iBNEekCrXBNvR97GspzHPZ1
         nffqEIjyRJuRRdKvOyIOLBuM3LMnCPRRz3mda8ObD/kJL4jzLKlR2kkYtcSnm6XG1SbL
         eFUaOZ3H2KYiRvg1EOs3+e2GznVMLEIDzu/Bl68Vee9O+s/n3rq/Ar0JtJf68+DyZgsq
         TTJ58EQFkFRihRSufULY9iRXzTre4Qssh/sJTTmxf5/kJvRkvq0AQJQhtBKC+0F4sxED
         EtPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717683872; x=1718288672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=++6vpzo3dEirc2BXnRm0i3mFbJVPl95CbYYtfzrVJSQ=;
        b=Rsw/AMvnLvyjHz9GcwitWWiiKYdSdR2qDOG+Lo7b19YoH6udufCL1WvdPvuS5D+ASb
         DR1hRqwHLv95fIByHf6rz6UYMx6xVBwaPRXhiKDk1P5KbdmlEqKc1hmrAinaX3nKCEWn
         Z9Tf6B5XWaXCD6LHbud5HOaAaUubtPeZTn8cgPXmEi7hQgeTXEhX/lyAVPstc4uc6R14
         790CD+HOy+ijpNpEg/+nisqj+v5M0n86rfuzQbIAfQtE5fSiQFRv5/KbWmNstnMCo0iC
         zp4aHsyCIOKDqvoVDutIbWyk2EuANMNzyhhZbAeRAUq7tQ6Y+BzlTqh/lf5YQ0j63VmI
         OSrg==
X-Forwarded-Encrypted: i=1; AJvYcCXr6YmMh9O7eM2T084uHnNxttHYBG7oatijwhg34VYfCWeMdkkPHVuuT3+X8V1wO4f254CwT3S2Pk6kKzjiITBSsLNwotdh
X-Gm-Message-State: AOJu0YzG6+xpVL2iHvNC2xwQVUqczhRuWaMN9izJypWVbs2fonYlGK60
	IwZ55bkG/LIOEykp6g5gYqcicgeqnxIQiT9l0eXwe/NEm7lMVjM5YIocavvohK4=
X-Google-Smtp-Source: AGHT+IGK6NHwjN3jn4VsJlrqvbN9hjMoiszVr84okdXBzSyf4bSyTjksFWYG+VZCJ382BSeLaVQeGw==
X-Received: by 2002:a05:6512:2035:b0:529:b609:fa0c with SMTP id 2adb3069b0e04-52bab50b666mr2809751e87.67.1717683871828;
        Thu, 06 Jun 2024 07:24:31 -0700 (PDT)
Received: from krzk-bin.. ([110.93.11.116])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52bb423ceeasm211659e87.185.2024.06.06.07.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 07:24:30 -0700 (PDT)
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
Subject: [PATCH net-next 3/3] can: mcp251xfd: simplify with spi_get_device_match_data()
Date: Thu,  6 Jun 2024 16:24:24 +0200
Message-ID: <20240606142424.129709-3-krzysztof.kozlowski@linaro.org>
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
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 1d9057dc44f2..4b7e08e8ed56 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -1989,7 +1989,6 @@ MODULE_DEVICE_TABLE(spi, mcp251xfd_id_table);
 
 static int mcp251xfd_probe(struct spi_device *spi)
 {
-	const void *match;
 	struct net_device *ndev;
 	struct mcp251xfd_priv *priv;
 	struct gpio_desc *rx_int;
@@ -2081,13 +2080,7 @@ static int mcp251xfd_probe(struct spi_device *spi)
 	priv->pll_enable = pll_enable;
 	priv->reg_vdd = reg_vdd;
 	priv->reg_xceiver = reg_xceiver;
-
-	match = device_get_match_data(&spi->dev);
-	if (match)
-		priv->devtype_data = *(struct mcp251xfd_devtype_data *)match;
-	else
-		priv->devtype_data = *(struct mcp251xfd_devtype_data *)
-			spi_get_device_id(spi)->driver_data;
+	priv->devtype_data = *(struct mcp251xfd_devtype_data *)spi_get_device_match_data(spi);
 
 	/* Errata Reference:
 	 * mcp2517fd: DS80000792C 5., mcp2518fd: DS80000789C 4.
-- 
2.43.0


