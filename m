Return-Path: <netdev+bounces-155096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FC5A00FC0
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 22:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5610218864DF
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 21:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3885E1C75F2;
	Fri,  3 Jan 2025 21:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DcpiShaz"
X-Original-To: netdev@vger.kernel.org
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E121B2199;
	Fri,  3 Jan 2025 21:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735938958; cv=none; b=ZglAUzjktFkDM8TXD0GcEGOPU722f1e5+h4qzEOF0RuovE2xdSiBFzPkzjWtTG5Rkkvj0xcvbR/iOvAjiPiZ2CzmJUH/bbSi/AFejRsV3mMiuoK4cchm3mVaexZV1RKbR0xcFdFxdq/mKItj8knA6GfNP3YBDFvGq0DCWpYFEt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735938958; c=relaxed/simple;
	bh=Z9ZNL3rh1rUDWm5Q3HrHpjTA0Zx0JXMguecu4dqyCSQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k9WWe8oi/jzo3jLQpKIRiUBTGYWaBDQi2ryTz22inUFzQqGIkxXbEtASEjooqB7PAch2uOpCcEeNYyfnRQ+gsCSBD+lqP0JS7aRI2lQhDznDgR+ZE6GcOANllYq1h60MSXH7YbRULTUvIQ0hJdNwsiB36B8W0DboBsXJkLBJQO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DcpiShaz; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 242F7C0CBE;
	Fri,  3 Jan 2025 21:13:43 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 19C84FF804;
	Fri,  3 Jan 2025 21:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1735938815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EmHAa5lzTlUKP9x1tLfYUr5FJHSMHYYBy7nd5w51Avs=;
	b=DcpiShazUmJY2snHFN8Oq6K8HWq/Fnz2sC8yxyoecbjpjOEBcNj8vzMXaAivblaQs+C89e
	9huuY71URhYuZnQa0zaEWqdrV+ULK36TOnmX/HmRgI7SQcgGRKoplyHkcOqMq3r/hG/7Rc
	OlGm+S9RVF1AvIwVj3q3EjusYHNfTfr1UnsIw/HamlCaTfyAN3nz5Y0/wRUHIk7uo6McYp
	DNJ5YLMLYWdJm2dr3hGIpRMO9LM1cZuzqhGGockTmaR6m2l254N2t9Qzj9VnkTO5EelkAq
	5Ym3yYqWYVzS4M61k9v2u0JrChhMgEar3cwISbDGXlfEZMG5Z01XpG5NVNKLgA==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 03 Jan 2025 22:12:51 +0100
Subject: [PATCH net-next v4 02/27] net: pse-pd: Avoid setting max_uA in
 regulator constraints
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250103-feature_poe_port_prio-v4-2-dc91a3c0c187@bootlin.com>
References: <20250103-feature_poe_port_prio-v4-0-dc91a3c0c187@bootlin.com>
In-Reply-To: <20250103-feature_poe_port_prio-v4-0-dc91a3c0c187@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, 
 Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 devicetree@vger.kernel.org, Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Setting the max_uA constraint in the regulator API imposes a current
limit during the regulator registration process. This behavior conflicts
with preserving the maximum PI power budget configuration across reboots.

Instead, compare the desired current limit to MAX_PI_CURRENT in the
pse_pi_set_current_limit() function to ensure proper handling of the
power budget.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Change ni v3:
- New patch
---
 drivers/net/pse-pd/pse_core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 2906ce173f66..9fee4dd53515 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -357,6 +357,9 @@ static int pse_pi_set_current_limit(struct regulator_dev *rdev, int min_uA,
 	if (!ops->pi_set_current_limit)
 		return -EOPNOTSUPP;
 
+	if (max_uA > MAX_PI_CURRENT)
+		return -ERANGE;
+
 	id = rdev_get_id(rdev);
 	mutex_lock(&pcdev->lock);
 	ret = ops->pi_set_current_limit(pcdev, id, max_uA);
@@ -403,11 +406,9 @@ devm_pse_pi_regulator_register(struct pse_controller_dev *pcdev,
 
 	rinit_data->constraints.valid_ops_mask = REGULATOR_CHANGE_STATUS;
 
-	if (pcdev->ops->pi_set_current_limit) {
+	if (pcdev->ops->pi_set_current_limit)
 		rinit_data->constraints.valid_ops_mask |=
 			REGULATOR_CHANGE_CURRENT;
-		rinit_data->constraints.max_uA = MAX_PI_CURRENT;
-	}
 
 	rinit_data->supply_regulator = "vpwr";
 

-- 
2.34.1


