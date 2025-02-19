Return-Path: <netdev+bounces-167689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAE4A3BCE4
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 12:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9907A7A5C6B
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 11:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1022F1DEFEE;
	Wed, 19 Feb 2025 11:34:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D3A1D86D6
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 11:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739964843; cv=none; b=OWQhglnvAhVCnzrmhgjKvveckJiFsKnx5U818yTbO37UYu7MehkcYMZ+O9RNPB4Ndi+a1hqNoRzyPmIi022AqbESRTGvX3PGYR2HOmIKtOEY4/iaAzVUbrKmx9JVWLWf67921QArQycvROUKBWj2/SHb1Bbu/ctthD7rcpnjgJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739964843; c=relaxed/simple;
	bh=fAHio248YW71Z6pNE2puRW6rgBccgzKQ8brtyYlTCpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C/IvEvpttO0z7n+Hs96G4ZCO1+nlNo/QG/QE394tYAE3EAKdI1tC7bzUgHlQlQykvu0PrC6scsmeSvLS8hBdma4l0wRYdl8QcsEeC99sILkSKq2NFlxmF+3QZwM+dtUPu5dXGciWJqHqQaewoXWtgw4S2wS+tKse6xJzUmqrdzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tkiL1-0001UC-Ls
	for netdev@vger.kernel.org; Wed, 19 Feb 2025 12:33:59 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tkiL1-001kyp-0V
	for netdev@vger.kernel.org;
	Wed, 19 Feb 2025 12:33:59 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id CC4313C6900
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 11:33:58 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id ED5DF3C68D6;
	Wed, 19 Feb 2025 11:33:56 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id f193d139;
	Wed, 19 Feb 2025 11:33:56 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 01/12] can: c_can: Drop useless final probe failure message
Date: Wed, 19 Feb 2025 12:21:06 +0100
Message-ID: <20250219113354.529611-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250219113354.529611-1-mkl@pengutronix.de>
References: <20250219113354.529611-1-mkl@pengutronix.de>
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

Generic probe failure message is useless: does not give information what
failed and it duplicates messages provided by the core, e.g. from memory
allocation or platform_get_irq().  It also floods dmesg in case of
deferred probe, e.g. resulting from devm_clk_get().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://patch.msgid.link/20250212-syscon-phandle-args-can-v2-1-ac9a1253396b@linaro.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/c_can/c_can_platform.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index 399844809bbe..8968b6288ac7 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -269,30 +269,22 @@ static int c_can_plat_probe(struct platform_device *pdev)
 
 	/* get the appropriate clk */
 	clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(clk)) {
-		ret = PTR_ERR(clk);
-		goto exit;
-	}
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
 
 	/* get the platform data */
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		ret = irq;
-		goto exit;
-	}
+	if (irq < 0)
+		return irq;
 
 	addr = devm_platform_get_and_ioremap_resource(pdev, 0, &mem);
-	if (IS_ERR(addr)) {
-		ret =  PTR_ERR(addr);
-		goto exit;
-	}
+	if (IS_ERR(addr))
+		return PTR_ERR(addr);
 
 	/* allocate the c_can device */
 	dev = alloc_c_can_dev(drvdata->msg_obj_num);
-	if (!dev) {
-		ret = -ENOMEM;
-		goto exit;
-	}
+	if (!dev)
+		return -ENOMEM;
 
 	priv = netdev_priv(dev);
 	switch (drvdata->id) {
@@ -396,8 +388,6 @@ static int c_can_plat_probe(struct platform_device *pdev)
 	pm_runtime_disable(priv->device);
 exit_free_device:
 	free_c_can_dev(dev);
-exit:
-	dev_err(&pdev->dev, "probe failed\n");
 
 	return ret;
 }

base-commit: aefd232de5eb2e77e3fc58c56486c7fe7426a228
-- 
2.47.2



