Return-Path: <netdev+bounces-156624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6264AA072B9
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 11:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43A2F7A132D
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 10:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CF221661F;
	Thu,  9 Jan 2025 10:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pCOb91C+"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D24A215F6E;
	Thu,  9 Jan 2025 10:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736417936; cv=none; b=SPAY+TNNutZqZ+86KT3wBi8rXPjugWTNj+XEHOSQTrBacI5g1VFHZiMHnY3sqFcVVG3TOW07Ha8xulXTVgNblYyk1Yxch5EDW5nCpvh+LpM8eszRqv89oxuaoOIr+SqqiPbmMjIBsAPjLhJDRCoI+aZKI4Kf2BzNSOhx3d0OQM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736417936; c=relaxed/simple;
	bh=EGF2XBjDW8Awwg0TvF7irUc+FKwZ1gZh75vwlba8OpE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uUPjTCZ6z8qMYsYfZhda1gjptff+qCe+cMtd6YS8a9L5PxJ2zsXlqR/8Id+rxmIXiwFSBo8XlGh/CP9Pn9yEmlwzqYabj3fco07aGAlC7bbB/6uxsxZQWcWYNwcn9h5Bwcp0cUehxX6jKbC7UMaNHPTFIUYestNFlDpEKFgSQP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pCOb91C+; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 64B0AE0014;
	Thu,  9 Jan 2025 10:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736417927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+g+gzoMaoPkSJtDI4tWVLE+Mf/2uUCxQvYzgSnTXlNQ=;
	b=pCOb91C+gWLsFPrXCxjKoYjXGcv/7B3EX4gKQaS6oX5ixLdwWMeirqB+78ZZvskMHbBTJd
	aBYIRrVGoajyLoi6VWU+fk+zkxTp9rDnfkKmFvhCC/bTS2rYZNJu+ErFXtojra0QliNz3D
	6TePWpDe7KcTxEX0k8bErXPG0egNfBaMhVKtZAm/oUufDnwc+ujId454NxQxVe/r11I8B4
	O/DFcGLSzQmImB8sDjl0TZUNDrXoOhcz+hdso1KQy03vi4f5AyTb1zD+qfJtuLriepH5wB
	Y/r1Eplxl8hbUByVByLgoVDFu1OkjF0SkrXsF3NAxl8yTruWeMFTRWhpu1Nd3A==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 09 Jan 2025 11:17:57 +0100
Subject: [PATCH net-next v2 03/15] net: pse-pd: Add power limit check
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-b4-feature_poe_arrange-v2-3-55ded947b510@bootlin.com>
References: <20250109-b4-feature_poe_arrange-v2-0-55ded947b510@bootlin.com>
In-Reply-To: <20250109-b4-feature_poe_arrange-v2-0-55ded947b510@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Checking only the current limit is not sufficient. According to the
standard, voltage can reach up to 57V and current up to 1.92A, which
exceeds the power limit described in the standard (99.9W). Add a power
limit check to prevent this.

Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 drivers/net/pse-pd/pse_core.c | 3 +++
 include/linux/pse-pd/pse.h    | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 9fee4dd53515..432b6c2c04f8 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -877,6 +877,9 @@ int pse_ethtool_set_pw_limit(struct pse_control *psec,
 	int uV, uA, ret;
 	s64 tmp_64;
 
+	if (pw_limit > MAX_PI_PW)
+		return -ERANGE;
+
 	ret = regulator_get_voltage(psec->ps);
 	if (!ret) {
 		NL_SET_ERR_MSG(extack,
diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h
index 85a08c349256..bc5addccbf32 100644
--- a/include/linux/pse-pd/pse.h
+++ b/include/linux/pse-pd/pse.h
@@ -11,6 +11,8 @@
 
 /* Maximum current in uA according to IEEE 802.3-2022 Table 145-1 */
 #define MAX_PI_CURRENT 1920000
+/* Maximum power in mW according to IEEE 802.3-2022 Table 145-16 */
+#define MAX_PI_PW 99900
 
 struct phy_device;
 struct pse_controller_dev;

-- 
2.34.1


