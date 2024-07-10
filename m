Return-Path: <netdev+bounces-110555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 687EE92D0E3
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 13:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83A7B1C22FAB
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 11:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701BF190488;
	Wed, 10 Jul 2024 11:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RyJ0N4ou"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD30618FA02;
	Wed, 10 Jul 2024 11:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720611763; cv=none; b=S+2zRl2cVEx0GIbAcc3iKe2Nc4KAmbcgtnf/4DkIp85va7Sd60trFrII1qvuATFfZN8UBbCsAOIq8XPtKeIWKFfFwK/AS8DJ0lFi+MucUmMSzbpSaK0QdIWFzvwTLI9Uq/DlKNX5rhLsIqxmstkvwliPV8uwjtK1FfEuEQRi5d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720611763; c=relaxed/simple;
	bh=znjGy39C1npmblToIx+FyOtCMLLb0RTKiAz/2zeJerk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ouq2fH1Qt0SxhGFXJvwBrGN5mtuF6AIaoJCu+v7x3luuQCvPlAUGFGCGnIth0+1Rp94xZz8r325aDSevP9fdHqUWT9uVOZqRneoWZnUkwB0nk0fYglgSZFGU4RA84rBT6mBRRccdi+17U1YUsBbPDz1fwh6brufz5OL0H+H/t+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RyJ0N4ou; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 21D9820007;
	Wed, 10 Jul 2024 11:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720611759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wuDJHn3ercIUcLR103Clt+Q0LNc7jTkBi80l92bbsqo=;
	b=RyJ0N4ouBMDoHXQ4N0LedKERGxZxyGYEGqUdU8tcssY34b/FIZl2Nw37uxhXvA+bAHvUas
	vnuPBlMWDpaT7VBUBI3+tPRPiVCkGrYv/MHm37PkKrZ8eFZd5L9Al/Sl51xcTDPH8oLWQ2
	hx48+uGkLF44k90aRNUyyGznF/jaWO9RNgBaPHE1tlUk+GPncB3i62GuXgDu1JT+ChrXRz
	RdkupUaB1/MluXNjXbM0WyBlD5lULQjsyHnyxGt4IgKyUQzCM1ljLtJWt3g0DsQP9r4DFv
	7oVX3nvPUxcJcGSiGHt3vYk9R8/ABNtV8sURCgdOd939//hd5e577kMgLX2Hag==
From: Kory Maincent <kory.maincent@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>,
	"Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: thomas.petazzoni@bootlin.com,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH v2 1/2] net: pse-pd: Do not return EOPNOSUPP if config is null
Date: Wed, 10 Jul 2024 13:42:30 +0200
Message-Id: <20240710114232.257190-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: kory.maincent@bootlin.com

For a PSE supporting both c33 and PoDL, setting config for one type of PoE
leaves the other type's config null. Currently, this case returns
EOPNOTSUPP, which is incorrect. Instead, we should do nothing if the
configuration is empty.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
Fixes: d83e13761d5b ("net: pse-pd: Use regulator framework within PSE framework")
---

Changes in v2:
- New patch to fix dealing with a null config.
---
 drivers/net/pse-pd/pse_core.c | 4 ++--
 net/ethtool/pse-pd.c          | 4 +++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 795ab264eaf2..513cd7f85933 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -719,13 +719,13 @@ int pse_ethtool_set_config(struct pse_control *psec,
 {
 	int err = 0;
 
-	if (pse_has_c33(psec)) {
+	if (pse_has_c33(psec) && config->c33_admin_control) {
 		err = pse_ethtool_c33_set_config(psec, config);
 		if (err)
 			return err;
 	}
 
-	if (pse_has_podl(psec))
+	if (pse_has_podl(psec) && config->podl_admin_control)
 		err = pse_ethtool_podl_set_config(psec, config);
 
 	return err;
diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
index 2c981d443f27..982995ff1628 100644
--- a/net/ethtool/pse-pd.c
+++ b/net/ethtool/pse-pd.c
@@ -183,7 +183,9 @@ ethnl_set_pse(struct ethnl_req_info *req_info, struct genl_info *info)
 	if (pse_has_c33(phydev->psec))
 		config.c33_admin_control = nla_get_u32(tb[ETHTOOL_A_C33_PSE_ADMIN_CONTROL]);
 
-	/* Return errno directly - PSE has no notification */
+	/* Return errno directly - PSE has no notification
+	 * pse_ethtool_set_config() will do nothing if the config is null
+	 */
 	return pse_ethtool_set_config(phydev->psec, info->extack, &config);
 }
 
-- 
2.34.1


