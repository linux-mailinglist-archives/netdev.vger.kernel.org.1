Return-Path: <netdev+bounces-165578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C311A329BF
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 16:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4A78166204
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 15:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3127211299;
	Wed, 12 Feb 2025 15:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="T+khC9ie"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6084920E038;
	Wed, 12 Feb 2025 15:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739373481; cv=none; b=jYaq1IjV6VZropgVMlFbBwaydDPxtqsqIre27bGvFUBnY8HWhEKatLo/NCMB577wTHqsbipIltrt9Hg/jiqD2wZvow60/U4o/EWEgUP+yw4rkZfh7ZsyK29y+TohvUd9A/FWcsoXszDWiVByrSaZOJYhYjAAfzjPsB0o9GxUANE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739373481; c=relaxed/simple;
	bh=79BkFClHg3ibPNKf3mEPOvsxU1Un7oWJ7nQvafqJEUI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u0m5vrZtkdwhQSRsESW6dTzdvV+khfxm7LK/bJLJ3IH7o+5mt/y3HZgq4om6BCpX5vSuyRPVTzgjgzRZSI+wXaR+x2pVtbB0PxywsKQsvDmdhpDG+OQxK4tOEh5gpodTEXq2VeyINfkOdlLl81O4H+WCRW0yPRYdTfN2Dv/3QSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=T+khC9ie; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C69B5431BA;
	Wed, 12 Feb 2025 15:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739373475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kHLLzYnEVSsinP5QyTy7367pxDbJUwnih7l0G0RRA6g=;
	b=T+khC9ie7xVXUKopDSpQfH9zuEKcXO3Mn1xAmktj3ldhoazhoDlcQ6CoDKUuMgv0+m2Zb2
	7+TZhlwFDDn+pfyH1VeGUM6Lk8G5OuOPcs4Ed44eO3Nh/868YyhlAwparf4jo/HBn3yEVK
	XV5JAGD86Z/yyEl48fvXDqFmMjrCNOpG94HjvDzLTZVO08QicF+Mhso9jbuwZKP1XLlS/u
	zeyxGNtNCIRhhkQuxCxsCbccoLRRak9kwKUGuZKxVz8h0jCEW3eAYt2V8460RA59mNCShM
	E359HTiuxFQYiA+3suGgyvJGtjxUgZbyKx63ZD6D1kydHicTTZZzsjrX1mpSfg==
From: Kory Maincent <kory.maincent@bootlin.com>
To: Kory Maincent <kory.maincent@bootlin.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net] net: pse-pd: Fix deadlock in current limit functions
Date: Wed, 12 Feb 2025 16:17:51 +0100
Message-Id: <20250212151751.1515008-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeggedvvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegudegvdeklefhheefueeiieegteegteeuudegteduvdevffeikefgjeekgfdukeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghlohepkhhmrghinhgtvghnthdqigfrufdqudefqdejfeeltddrrddpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedutddprhgtphhtthhopehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehordhrvghmphgvlhesphgvnhhguhhtrhhonhhigidruggvpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghls
 ehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvght
X-GND-Sasl: kory.maincent@bootlin.com

Fix a deadlock in pse_pi_get_current_limit and pse_pi_set_current_limit
caused by consecutive mutex_lock calls. One in the function itself and
another in pse_pi_get_voltage.

Resolve the issue by using the unlocked version of pse_pi_get_voltage
instead.

Fixes: e0a5e2bba38a ("net: pse-pd: Use power limit at driver side instead of current limit")
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

It seems the current limit configuration was not tested in the last
patch series. Sorry for that.
---
 drivers/net/pse-pd/pse_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 4f2a54afc4d0..4602e26eb8c8 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -319,7 +319,7 @@ static int pse_pi_get_current_limit(struct regulator_dev *rdev)
 		goto out;
 	mW = ret;
 
-	ret = pse_pi_get_voltage(rdev);
+	ret = _pse_pi_get_voltage(rdev);
 	if (!ret) {
 		dev_err(pcdev->dev, "Voltage null\n");
 		ret = -ERANGE;
@@ -356,7 +356,7 @@ static int pse_pi_set_current_limit(struct regulator_dev *rdev, int min_uA,
 
 	id = rdev_get_id(rdev);
 	mutex_lock(&pcdev->lock);
-	ret = pse_pi_get_voltage(rdev);
+	ret = _pse_pi_get_voltage(rdev);
 	if (!ret) {
 		dev_err(pcdev->dev, "Voltage null\n");
 		ret = -ERANGE;
-- 
2.34.1


