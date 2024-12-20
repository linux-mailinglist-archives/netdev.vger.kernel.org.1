Return-Path: <netdev+bounces-153729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25ECB9F9768
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 18:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9841A164EC5
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 17:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3185521CA12;
	Fri, 20 Dec 2024 17:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="E13S3b+z"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EC921A450;
	Fri, 20 Dec 2024 17:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734714255; cv=none; b=Ber5TUAIA7IU+kmPPxW85p+JOw50VKdssZEzi4yT1/fGJps/pQIG20vuIurvNW1QwyIzFKEME0Pf/Ut59xxDTkqC828z2tAqu5dwFhctHz9eVpE3wn+y5vjLx9EB67JbQelL5CteIhEur/y9xJ+ps4jPGOQmpyEiC9w5JHBvfU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734714255; c=relaxed/simple;
	bh=Laf5kMNXa8RJzpKBMv9hwEeOlQXnAb9vetfv0EwqAXs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=caUldrtJfGzGgfUWZE1+UAUyawL+GTXRbUgjyU06IhwZscDb38YbO+Foj1ZHUwpKgoxxWAXK844M35AdykAVt/KeLV0G/rztLqQhZ87a849ObWVgnRVXinCfkJfomajHaiJRUd5g7z2a2ozrtCLn2O+wnKcUgP5OcsFjj1gLEL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=E13S3b+z; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DADC3FF804;
	Fri, 20 Dec 2024 17:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734714245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=one7ZY+Rv/dQMmdZcLiYKy5WaZpZu4illxlnlMbAEYE=;
	b=E13S3b+z0UdWg02TWIKDo14g6SaVylJoK/npVa/x7VHJeYIlYa5lJ8AGNJ2lwWVc6SoMtH
	ma0JOUks2/vZSbbJISZCPLnMRNYApwtswUWEFflktzdNq2iqkrRumqEdzUamIUG1n+G/iU
	udNZo5FhYgRTuuTr/Bbq5J8t7NABAsOZK/7fsppvqirx0r1rERbd9Idf6uY0tLt3IOlTGH
	GlL/FWtOAbo3h/VOERbLYd6Jrbtcp+DCEYMkjKY2ZTMRRlJB73VmlV3//VEA0/+dhc2Dqy
	8xaowcsoPjje8xmeqgzMnQbI7KLCF5OI44MRcd5yqs2VebOhB/NwRCevsGqAWw==
From: Kory Maincent <kory.maincent@bootlin.com>
To: "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: thomas.petazzoni@bootlin.com,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net] net: pse-pd: tps23881: Fix power on/off issue
Date: Fri, 20 Dec 2024 18:04:00 +0100
Message-Id: <20241220170400.291705-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: kory.maincent@bootlin.com

An issue was present in the initial driver implementation. The driver
read the power status of all channels before toggling the bit of the
desired one. Using the power status register as a base value introduced
a problem, because only the bit corresponding to the concerned channel ID
should be set in the write-only power enable register. This led to cases
where disabling power for one channel also powered off other channels.

This patch removes the power status read and ensures the value is
limited to the bit matching the channel index of the PI.

Fixes: 20e6d190ffe1 ("net: pse-pd: Add TI TPS23881 PSE controller driver")
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 drivers/net/pse-pd/tps23881.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/net/pse-pd/tps23881.c b/drivers/net/pse-pd/tps23881.c
index 5c4e88be46ee..8797ca1a8a21 100644
--- a/drivers/net/pse-pd/tps23881.c
+++ b/drivers/net/pse-pd/tps23881.c
@@ -64,15 +64,11 @@ static int tps23881_pi_enable(struct pse_controller_dev *pcdev, int id)
 	if (id >= TPS23881_MAX_CHANS)
 		return -ERANGE;
 
-	ret = i2c_smbus_read_word_data(client, TPS23881_REG_PW_STATUS);
-	if (ret < 0)
-		return ret;
-
 	chan = priv->port[id].chan[0];
 	if (chan < 4)
-		val = (u16)(ret | BIT(chan));
+		val = BIT(chan);
 	else
-		val = (u16)(ret | BIT(chan + 4));
+		val = BIT(chan + 4);
 
 	if (priv->port[id].is_4p) {
 		chan = priv->port[id].chan[1];
@@ -100,15 +96,11 @@ static int tps23881_pi_disable(struct pse_controller_dev *pcdev, int id)
 	if (id >= TPS23881_MAX_CHANS)
 		return -ERANGE;
 
-	ret = i2c_smbus_read_word_data(client, TPS23881_REG_PW_STATUS);
-	if (ret < 0)
-		return ret;
-
 	chan = priv->port[id].chan[0];
 	if (chan < 4)
-		val = (u16)(ret | BIT(chan + 4));
+		val = BIT(chan + 4);
 	else
-		val = (u16)(ret | BIT(chan + 8));
+		val = BIT(chan + 8);
 
 	if (priv->port[id].is_4p) {
 		chan = priv->port[id].chan[1];
-- 
2.34.1


