Return-Path: <netdev+bounces-105587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E596B911E22
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 10:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FC6BB21209
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 08:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2314172BD3;
	Fri, 21 Jun 2024 08:02:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CEA171675
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 08:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956938; cv=none; b=D4avTjPVoIeWSDLCHjJUNfDeETri6N6Kvv+s+VZgkwWjYo2HDNCjg0JbTIiFZcgn2kfBrDxYvmLLO9DbJ+fc5qd7MzPncKXrpaKV+ycGYc3VwTuvwGIuj+O1z4TsEjAjKcRc8JO+tnZKAHmMXtLxmaRYlk01Gp/DlSZgRwjYCJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956938; c=relaxed/simple;
	bh=AS8bkESlyFlqiUMd17YWu3HKTlLPnlp40sq/mLYzOkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XuG7GxUU6UGHBN4lE6Qi9qJ4c3/aVGH43U4PfGWDDRxTUWuyohS87jbdTzqSCTxsjLU+TbVP8crwnTF79n3mKTkOlb6UHngoaLXrxXaXXiytOONIH3apQmg05bcHmDYJSDbAIPb+M+F3wtooGOWLs1mWwT71MHoJyucIk7UgSg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKZDp-00047L-1j
	for netdev@vger.kernel.org; Fri, 21 Jun 2024 10:02:13 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKZDk-003tNG-JR
	for netdev@vger.kernel.org; Fri, 21 Jun 2024 10:02:08 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 42C682EE450
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 08:02:08 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 71BEE2EE3C6;
	Fri, 21 Jun 2024 08:02:04 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 7e7fd571;
	Fri, 21 Jun 2024 08:02:04 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 23/24] can: mcp251xfd: simplify with spi_get_device_match_data()
Date: Fri, 21 Jun 2024 09:48:43 +0200
Message-ID: <20240621080201.305471-24-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240621080201.305471-1-mkl@pengutronix.de>
References: <20240621080201.305471-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Use spi_get_device_match_data() helper to simplify a bit the driver.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/all/20240606142424.129709-3-krzysztof.kozlowski@linaro.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
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



