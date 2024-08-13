Return-Path: <netdev+bounces-117927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E9C94FEE4
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 09:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 738BA1C2230F
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 07:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C4A58ABF;
	Tue, 13 Aug 2024 07:37:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79E67A15B
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 07:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723534669; cv=none; b=WQVZcXR4v7dZxYCaq9gaDCLxUjywlcnXaxtKZboex0Qul+VuBNmt/VAWMQFK+Y/WGqQqh5QAbkptkA2Nam+LhUvXoECdKxs+6vESM4bR9ydEo46h17BgsDfUhy2pot1Vy5kfEsnPXElAVWOFo2xJ+g6UxXXqM/QMW04htxGbDm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723534669; c=relaxed/simple;
	bh=vNeBkbDomSrSGaIQ5HOn+4DBZI3T8XqvDYiun/Tp6Qs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uQbPK+nToa4cOygKR3iy133XywwGZLkfsDRyHuG5Rtk90a8RokzlD9LIYPGkoKwJhnETt1Rf8IZKki+xSJQDKZIEM0MZl4phBUcKE1h7V3rqzsTiuFOFpCjkbXdjL1vul6ag2wbP62rXZqVd71cgorty0zpi56qSsSlVm24M368=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sdm5q-0007w6-UU; Tue, 13 Aug 2024 09:37:22 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sdm5p-0004mJ-1y; Tue, 13 Aug 2024 09:37:21 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sdm5o-009fXp-3C;
	Tue, 13 Aug 2024 09:37:20 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Kory Maincent <kory.maincent@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net v1] pse-core: Conditionally set current limit during PI regulator registration
Date: Tue, 13 Aug 2024 09:37:19 +0200
Message-Id: <20240813073719.2304633-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Fix an issue where `devm_regulator_register()` would fail for PSE
controllers that do not support current limit control, such as simple
GPIO-based controllers like the podl-pse-regulator. The
`REGULATOR_CHANGE_CURRENT` flag and `max_uA` constraint are now
conditionally set only if the `pi_set_current_limit` operation is
supported. This change prevents the regulator registration routine from
attempting to call `pse_pi_set_current_limit()`, which would return
`-EOPNOTSUPP` and cause the registration to fail.

Fixes: 4a83abcef5f4f ("net: pse-pd: Add new power limit get and set c33 features")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/pse-pd/pse_core.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index ec20953e0f825..4f032b16a8a0a 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -401,9 +401,14 @@ devm_pse_pi_regulator_register(struct pse_controller_dev *pcdev,
 	rdesc->ops = &pse_pi_ops;
 	rdesc->owner = pcdev->owner;

-	rinit_data->constraints.valid_ops_mask = REGULATOR_CHANGE_STATUS |
-						 REGULATOR_CHANGE_CURRENT;
-	rinit_data->constraints.max_uA = MAX_PI_CURRENT;
+	rinit_data->constraints.valid_ops_mask = REGULATOR_CHANGE_STATUS;
+
+	if (pcdev->ops->pi_set_current_limit) {
+		rinit_data->constraints.valid_ops_mask |=
+			REGULATOR_CHANGE_CURRENT;
+		rinit_data->constraints.max_uA = MAX_PI_CURRENT;
+	}
+
 	rinit_data->supply_regulator = "vpwr";

 	rconfig.dev = pcdev->dev;
--
2.39.2


