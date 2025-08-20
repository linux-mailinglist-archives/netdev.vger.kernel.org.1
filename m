Return-Path: <netdev+bounces-215271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3198DB2DDB6
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 15:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC3DF17B46C
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 13:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD35A304BAB;
	Wed, 20 Aug 2025 13:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="flAtSwJo"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB312D3231;
	Wed, 20 Aug 2025 13:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755696496; cv=none; b=M3TobycmlSp22VdfEGSl4DlY2cLpJrimGAAstqC3crseLaZgw4w5purhFNnYYec9+m5eaEZvHUTxOLEronRbohQD+rBdeoIzEocoMD67+YPuRClb8T9Cei38pyIcFiEy2FZK1Pbv2SIdHAn6KTBv/zikwMjW2zBO74iQ7/Hih1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755696496; c=relaxed/simple;
	bh=rqJbnI2LdCG9yqQrLaRMCg0AxlACV88Dlzc/cSANipg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kRHcCxRvfKQLi6pQWWBKYbOgRjDVlj7zIS3MJMQmoF+m13fLRrsCuKOcm3JuthZT3lKmMgBtj57riyAnfnkyuMrRwOk5gAU9NT1QfdqDNkLW+aa/62uo/YrfTnpVLWNcMoB0CHWSIPzOk9LfbqHNENC1qbiC/U11ZtTSYXc8gUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=flAtSwJo; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 9B372C6B3A5;
	Wed, 20 Aug 2025 13:27:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1C970606A0;
	Wed, 20 Aug 2025 13:28:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 116271C22CF41;
	Wed, 20 Aug 2025 15:28:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1755696491; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=EHAQSf51OR0tJUv4YhXS/cAsONEhMwCoETXsLmZdqH8=;
	b=flAtSwJoVuLKUIu6A6Lu8a3rW/eFBrG/1J74vlxdW+K/uvlQwFgj1JsUtxvxDr7edjdAmP
	No5yf6W5NRqjbtvFEqMckVs1RBAp+uBnFD3txX/Pg/87tBmft95Z8uFT3f1hOWixB9gIMq
	ErBzF3aO+iesXm8tiXSweptFOtdOKetoBdumlUof/puykah5Ur+p4zgKZ+N9i7gfllfiZV
	CPs4svUCdtUDaVxcbTHD1UcV2tyUZLn+md+YeQ8Nvv9sk7cWXPB4hkA9Lu31dtNddZi05O
	/+WC4K70DaUFDReqqYBUCHeb0E3sm2U+XE+C/4NYdSQKPJ9846h90cUe7xbqwQ==
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	"Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net] net: pse-pd: pd692x0: Fix power budget leak in manager setup error path
Date: Wed, 20 Aug 2025 15:27:07 +0200
Message-ID: <20250820132708.837255-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Fix a resource leak where manager power budgets were freed on both
success and error paths during manager setup. Power budgets should
only be freed on error paths after regulator registration or during
driver removal.

Refactor cleanup logic by extracting OF node cleanup and power budget
freeing into separate helper functions for better maintainability.

Fixes: 359754013e6a ("net: pse-pd: pd692x0: Add support for PSE PI priority feature")
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 drivers/net/pse-pd/pd692x0.c | 59 +++++++++++++++++++++++++++---------
 1 file changed, 44 insertions(+), 15 deletions(-)

diff --git a/drivers/net/pse-pd/pd692x0.c b/drivers/net/pse-pd/pd692x0.c
index 399ce9febda4..395f6c662175 100644
--- a/drivers/net/pse-pd/pd692x0.c
+++ b/drivers/net/pse-pd/pd692x0.c
@@ -1162,12 +1162,44 @@ pd692x0_write_ports_matrix(struct pd692x0_priv *priv,
 	return 0;
 }
 
+static void pd692x0_of_put_managers(struct pd692x0_priv *priv,
+				    struct pd692x0_manager *manager,
+				    int nmanagers)
+{
+	int i, j;
+
+	for (i = 0; i < nmanagers; i++) {
+		for (j = 0; j < manager[i].nports; j++)
+			of_node_put(manager[i].port_node[j]);
+		of_node_put(manager[i].node);
+	}
+}
+
+static void pd692x0_managers_free_pw_budget(struct pd692x0_priv *priv)
+{
+	int i;
+
+	for (i = 0; i < PD692X0_MAX_MANAGERS; i++) {
+		struct regulator *supply;
+
+		if (!priv->manager_reg[i] || !priv->manager_pw_budget[i])
+			continue;
+
+		supply = priv->manager_reg[i]->supply;
+		if (!supply)
+			continue;
+
+		regulator_free_power_budget(supply,
+					    priv->manager_pw_budget[i]);
+	}
+}
+
 static int pd692x0_setup_pi_matrix(struct pse_controller_dev *pcdev)
 {
 	struct pd692x0_manager *manager __free(kfree) = NULL;
 	struct pd692x0_priv *priv = to_pd692x0_priv(pcdev);
 	struct pd692x0_matrix port_matrix[PD692X0_MAX_PIS];
-	int ret, i, j, nmanagers;
+	int ret, nmanagers;
 
 	/* Should we flash the port matrix */
 	if (priv->fw_state != PD692X0_FW_OK &&
@@ -1185,31 +1217,27 @@ static int pd692x0_setup_pi_matrix(struct pse_controller_dev *pcdev)
 	nmanagers = ret;
 	ret = pd692x0_register_managers_regulator(priv, manager, nmanagers);
 	if (ret)
-		goto out;
+		goto err_of_managers;
 
 	ret = pd692x0_configure_managers(priv, nmanagers);
 	if (ret)
-		goto out;
+		goto err_of_managers;
 
 	ret = pd692x0_set_ports_matrix(priv, manager, nmanagers, port_matrix);
 	if (ret)
-		goto out;
+		goto err_managers_req_pw;
 
 	ret = pd692x0_write_ports_matrix(priv, port_matrix);
 	if (ret)
-		goto out;
+		goto err_managers_req_pw;
 
-out:
-	for (i = 0; i < nmanagers; i++) {
-		struct regulator *supply = priv->manager_reg[i]->supply;
-
-		regulator_free_power_budget(supply,
-					    priv->manager_pw_budget[i]);
+	pd692x0_of_put_managers(priv, manager, nmanagers);
+	return 0;
 
-		for (j = 0; j < manager[i].nports; j++)
-			of_node_put(manager[i].port_node[j]);
-		of_node_put(manager[i].node);
-	}
+err_managers_req_pw:
+	pd692x0_managers_free_pw_budget(priv);
+err_of_managers:
+	pd692x0_of_put_managers(priv, manager, nmanagers);
 	return ret;
 }
 
@@ -1748,6 +1776,7 @@ static void pd692x0_i2c_remove(struct i2c_client *client)
 {
 	struct pd692x0_priv *priv = i2c_get_clientdata(client);
 
+	pd692x0_managers_free_pw_budget(priv);
 	firmware_upload_unregister(priv->fwl);
 }
 
-- 
2.43.0


