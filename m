Return-Path: <netdev+bounces-131179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEB298D11D
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 12:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 891D81F22EC0
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 10:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8481E5031;
	Wed,  2 Oct 2024 10:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="S5Pepdfm"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAA41E500C;
	Wed,  2 Oct 2024 10:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727864634; cv=none; b=vAowT6yZrWA7/G8e0C7BnpwsVvitgEZ2k3pykXCcRHdcCyHsQpZKd1JZteSbtcdEm6eN9gSLOeLJRXLwkoqEtY2Lb6Bt493PCOi7HfbDx2yV00TMDC0VCstGaguUp+qIpvX5wKngniTEoFN/lkx1m+/npnWEa7rfcb/T7//2u6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727864634; c=relaxed/simple;
	bh=UETMzQ3OoNiJhQdIh6ZaufX7J4Bz2WQvXdr/VFEIA6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B1DkRZH9cpsLi3rnVBkYYlUaWOthk2QB85AnWxo7/pEsjGDko1Wsdar8E6I7Y5BgOlLaaBM7n4pz995j80IyBeqHbc2QTXogy/wiNjR2Aic1Mi5hetjknp5LrU9I7Qpgxq8XxUXRG8CT7wmV54fLjcECISyzpINLpIgnhkwyW+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=S5Pepdfm; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7C8E7E0002;
	Wed,  2 Oct 2024 10:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727864625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KRHxjIX8VwP6K29LEBgziOfkVkHwg5LR9DISQvSAH4A=;
	b=S5PepdfmdUU+ffyK54VOUCB4Uq2H32JBV4LA3PYXUOm4JF3Mj1eIy/j6bNvw8yxwnDsbAA
	nv0Qv8Aj6qtpua/8v/57Ymhb0illV1oDr69WCY6FR5qBf61w6FU0i48fUEhFumcN9g3Rvr
	othGzyM7MnHFyg6zR98dWMNvlHOSy3AXr8DwhpwRCltZC+98RNJwBysNdhetRHXN8+GjEi
	7CAjLIHP2muE5SmZy7MguDiZax44zVib9giyjj3JPcM4oRkP3xUt7u4DF260KHfG2Y+NW2
	jP1s+AXcteuAgSoK5hzBzrpOm2/4ylyOVtC6wh7ImQKdUgCUAG9sYDZg6ZRhYA==
From: Kory Maincent <kory.maincent@bootlin.com>
To: "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Kyle Swenson <kyle.swenson@est.tech>,
	Simon Horman <horms@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	thomas.petazzoni@bootlin.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net v2] net: pse-pd: tps23881: Fix boolean evaluation for bitmask checks
Date: Wed,  2 Oct 2024 12:23:40 +0200
Message-Id: <20241002102340.233424-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: kory.maincent@bootlin.com

Fix incorrect boolean evaluation when checking bitmask values.
The existing code directly assigned the result of bitwise operations
to boolean variables. In the case of 4-pair PoE, this led to incorrect
enabled and delivering status values.

This has been corrected by explicitly converting the bitmask results
to boolean using the !! operator, ensuring proper evaluation.

Fixes: 20e6d190ffe1 ("net: pse-pd: Add TI TPS23881 PSE controller driver")
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Change in v2:
- Update commit message to describe the issue.

 drivers/net/pse-pd/tps23881.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/pse-pd/tps23881.c b/drivers/net/pse-pd/tps23881.c
index 5c4e88be46ee..1a57c55f8577 100644
--- a/drivers/net/pse-pd/tps23881.c
+++ b/drivers/net/pse-pd/tps23881.c
@@ -139,9 +139,9 @@ static int tps23881_pi_is_enabled(struct pse_controller_dev *pcdev, int id)
 
 	chan = priv->port[id].chan[0];
 	if (chan < 4)
-		enabled = ret & BIT(chan);
+		enabled = !!(ret & BIT(chan));
 	else
-		enabled = ret & BIT(chan + 4);
+		enabled = !!(ret & BIT(chan + 4));
 
 	if (priv->port[id].is_4p) {
 		chan = priv->port[id].chan[1];
@@ -172,11 +172,11 @@ static int tps23881_ethtool_get_status(struct pse_controller_dev *pcdev,
 
 	chan = priv->port[id].chan[0];
 	if (chan < 4) {
-		enabled = ret & BIT(chan);
-		delivering = ret & BIT(chan + 4);
+		enabled = !!(ret & BIT(chan));
+		delivering = !!(ret & BIT(chan + 4));
 	} else {
-		enabled = ret & BIT(chan + 4);
-		delivering = ret & BIT(chan + 8);
+		enabled = !!(ret & BIT(chan + 4));
+		delivering = !!(ret & BIT(chan + 8));
 	}
 
 	if (priv->port[id].is_4p) {
-- 
2.34.1


