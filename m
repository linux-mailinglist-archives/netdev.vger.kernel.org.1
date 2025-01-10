Return-Path: <netdev+bounces-157050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A78EBA08C71
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 10:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2027D188DC97
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 09:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5657020C470;
	Fri, 10 Jan 2025 09:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QyT0cvwi"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52F620B819;
	Fri, 10 Jan 2025 09:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736502047; cv=none; b=KH0Rcdc35/c3cGJR0EXTLGYgbvJXxj6ltr4ztpnoF0ozS7tJm0XR2rl9av3DZ0H6Z9cmGbAEEJbXmWSxPpbufXj+d+KPcKBKymopOFD1opi8erffZQZwmLcJZdaal/gSRPo9uGzyOLvRB/qb4Az0a+Y5xIAhbtPdEJ4a8oob9sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736502047; c=relaxed/simple;
	bh=otSAI726UPSW5yZP19QT9AMB+lmCMNzhXgqogdXpnXQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=p+7x+etJF/BBYQNnNICFgIlI7s0hOrYEjgHCm+03yr1hCads7BQ1uqCxK99QX2QBrO8WxgtYwLW5X7zjsjPtVExTMCINVMECP2gln1n3FBYF2wi8t9KtJUtCeJCzS10kc70xBgPGkUs3CbkdWeB3gSBDRjRiF7g0edQXV0W0pFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QyT0cvwi; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 44A1260002;
	Fri, 10 Jan 2025 09:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736502042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KvKxG2m3PbqglKqADysMRddDRGxPmp8YOzbE4c6xDbI=;
	b=QyT0cvwiee5k0OMA53N8cZOBYeMHe4/NYZIFhQ0GIWGPpmtZ25Ud+4jkluqDFiTV3vG0UX
	lC99GKaqyOeIZeBopqtuGTg+MZsv9VVy7GhpzrOY8eteedwKScMfE1fLd8tbmeIJAFrxyo
	Lk9X4ulcIhhhxxkqrn9wympofkHfD7uGTunMXCGpNYnmNW9KYItumkvqR1jZHUEScmBrOf
	AXY0Y519ArEht5XKS35yg2+1lxAO96ZAcXQtrIJg8H/vIh2UhLzgFrbsor294N6j3F4EX6
	gkA3R5jJ6i7xW5+Wc+mVntEU6Q6lIJNFsQB7lYCgdcSE0IV56vst0+TCODNptQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH net-next v3 00/12] Arrange PSE core and update TPS23881
 driver
Date: Fri, 10 Jan 2025 10:40:19 +0100
Message-Id: <20250110-b4-feature_poe_arrange-v3-0-142279aedb94@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAPrgGcC/4XNQQ7CIBAF0KuYWYuhCNa68h7GNFAGS6LQAJKap
 neXsNKFcfnz579ZIGKwGOG0WSBgttF6V8J+u4FhlO6GxOqSgVEmaEM5UZwYlOkZsJ889jKEetV
 KTfmBGSYNQhlPAY2dK3wBh4k4nBNcSzPamHx41Y+5qf0/PDeEko6ZI+VKtxz1WXmf7tbtBv+oa
 GafUPcTYgUSQqPueKtEQ7+hdV3fNAkjohEBAAA=
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, 
 Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.14.1
X-GND-Sasl: kory.maincent@bootlin.com

This patch includes several improvements to the PSE core for better
implementation and maintainability:

- Move the conversion between current limit and power limit from the driver
  to the PSE core.
- Update power and current limit checks.
- Split the ethtool_get_status callback into multiple callbacks.
- Fix PSE PI of_node detection.
- Clean ethtool header of PSE structures.

Additionally, the TPS23881 driver has been updated to support power
limit and measurement features, aligning with the new PSE core
functionalities.

This patch series is the first part of the budget evaluation strategy
support patch series sent earlier:
https://lore.kernel.org/netdev/20250104161622.7b82dfdf@kmaincent-XPS-13-7390/T/#t

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
Changes in v3:
- Move support for PSE index out of this series
- Remove regulator patch which gets merged in regulator tree.
- Link to v2: https://lore.kernel.org/r/20250109-b4-feature_poe_arrange-v2-0-55ded947b510@bootlin.com

Changes in v2:
- Add a patch to clean ethtool header of PSE structures
- Link to v1: https://lore.kernel.org/r/20250104-b4-feature_poe_arrange-v1-0-92f804bd74ed@bootlin.com

---
Kory Maincent (12):
      net: pse-pd: Remove unused pse_ethtool_get_pw_limit function declaration
      net: pse-pd: Avoid setting max_uA in regulator constraints
      net: pse-pd: Add power limit check
      net: pse-pd: tps23881: Simplify function returns by removing redundant checks
      net: pse-pd: tps23881: Use helpers to calculate bit offset for a channel
      net: pse-pd: tps23881: Add missing configuration register after disable
      net: pse-pd: Use power limit at driver side instead of current limit
      net: pse-pd: Split ethtool_get_status into multiple callbacks
      net: pse-pd: Remove is_enabled callback from drivers
      net: pse-pd: tps23881: Add support for power limit and measurement features
      net: pse-pd: Fix missing PI of_node description
      net: pse-pd: Clean ethtool header of PSE structures

 drivers/net/pse-pd/pd692x0.c       | 224 +++++++++---------
 drivers/net/pse-pd/pse_core.c      | 183 ++++++++++-----
 drivers/net/pse-pd/pse_regulator.c |  23 +-
 drivers/net/pse-pd/tps23881.c      | 449 ++++++++++++++++++++++++++++++-------
 include/linux/ethtool.h            |  20 --
 include/linux/pse-pd/pse.h         | 134 ++++++++---
 net/ethtool/pse-pd.c               |   8 +-
 7 files changed, 733 insertions(+), 308 deletions(-)
---
base-commit: 47fcecb5cea2db70aafc8c9757e7fbbdb715db22
change-id: 20250104-b4-feature_poe_arrange-7ad0462f2afe

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


