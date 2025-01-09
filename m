Return-Path: <netdev+bounces-156619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E60BA072AA
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 11:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7E6E3A277C
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 10:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8C1215F71;
	Thu,  9 Jan 2025 10:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="STwe3ogN"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6305321579F;
	Thu,  9 Jan 2025 10:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736417934; cv=none; b=op1e2ji/uBqsxqOH2i/j24+EpQ1xwobLl2UTCcfl6Ns4U3K15Jc8hWT3vopesuHjoNFRhNh5Uo5p0zX0CcOWNStwBbb01Lkd3MfuC8klq6XEX8VGZBbhJFbk1EL/op2RzAOkwZ7+E7yYaBTGfmjnjQmOgu/lZVOiSdVAZjacMqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736417934; c=relaxed/simple;
	bh=m2/2B8DgsQWKP2dTKHY6Uo/hbqT8KQFiKmV/nwAePok=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=civ6GGSALJ6Sjy+vZU9ycLYurX9rwz/tLfx/a6MGwL5NMhYJNA7gxGCj//il22EDnlFMNN5LjRl3hg7RpNIdnNjG8AlvsARIHp2xbxlsQYklaeKr4yYJPfpnn87Jx54t6I30ZWyQX0FRtmsnGCbaid4ghrKyBy/RoWhNyysfRRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=STwe3ogN; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8CF61E000C;
	Thu,  9 Jan 2025 10:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736417924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QQzbUGpRpqJpruHFivHLZPolA0wMskDZ+pQZE56/8yo=;
	b=STwe3ogNYIyg384FVkecEy4NjGiK7VWz9GpTOtrGo5O+Sk8v5NlCILz4bgJIA9P56WDrrO
	A8ugqZsA9abF6kSoDts56RkRlZMnJlz6hDWA8z/IXEmIuqAG3XaiJedMJ9Y5l7RbI0Sd7x
	ufjsg+1XDAXsSSx7z6wM4TY0jYrW1XtAGduqrZt/Jj6Lz2pvW2LyZ3IcmGCAzN1hctx78u
	RVLuuhKm5WccoWUUtf6X4dFk3MRAovYmnuiw/tyVmPSoZDT1qGR7sZKmdkJ9HoFn4L/g+v
	yvwIdro+XQGDLnhmcyxfoF4K/bkSwgJ/2r4DBm+wYRIN1WqA9x+IFe25Xg2NVg==
From: Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH net-next v2 00/15] Arrange PSE core and update TPS23881
 driver
Date: Thu, 09 Jan 2025 11:17:54 +0100
Message-Id: <20250109-b4-feature_poe_arrange-v2-0-55ded947b510@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFKif2cC/4WNUQrCMBBEr1L220gaolW/vIeUkjQbu6BJ2cRSK
 b27IRfwc3gzbzZIyIQJbs0GjAsliqEEdWhgnEx4oiBXMiipTrKVWlgtPJr8YRzmiINhrq3OOKn
 PyivjEcp4ZvS0VvEDAmYRcM3QFzJRypG/9XFpK/8nX1ohxVX5i9TWdRrd3caYXxSOY3xDv+/7D
 6tQh5bIAAAA
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
 Kory Maincent <kory.maincent@bootlin.com>, 
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, 
 Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.15-dev-8cb71
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

This patch includes several improvements to the PSE core for better
implementation and maintainability:

- Move the conversion between current limit and power limit from the driver
  to the PSE core.
- Update power and current limit checks.
- Split the ethtool_get_status callback into multiple callbacks.
- Add support for PSE device index.
- Fix PSE PI of_node detection.
- Clean ethtool header of PSE structures.

Additionally, the TPS23881 driver has been updated to support power
limit and measurement features, aligning with the new PSE core
functionalities.

This patch series is the first part of the budget evaluation strategy
support patch series sent earlier:
https://lore.kernel.org/netdev/20250104161622.7b82dfdf@kmaincent-XPS-13-7390/T/#t

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
Changes in v2:
- Add a patch to clean ethtool header of PSE structures
- Link to v1: https://lore.kernel.org/r/20250104-b4-feature_poe_arrange-v1-0-92f804bd74ed@bootlin.com

---
Kory Maincent (15):
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
      net: pse-pd: Add support for PSE device index
      net: ethtool: Add support for new PSE device index description
      regulator: core: Resolve supply using of_node from regulator_config
      net: pse-pd: Fix missing PI of_node description
      net: pse-pd: Clean ethtool header of PSE structures

 Documentation/netlink/specs/ethtool.yaml       |   5 +
 Documentation/networking/ethtool-netlink.rst   |   4 +
 drivers/net/pse-pd/pd692x0.c                   | 224 ++++++------
 drivers/net/pse-pd/pse_core.c                  | 207 ++++++++----
 drivers/net/pse-pd/pse_regulator.c             |  23 +-
 drivers/net/pse-pd/tps23881.c                  | 449 ++++++++++++++++++++-----
 drivers/regulator/core.c                       |  39 ++-
 include/linux/ethtool.h                        |  20 --
 include/linux/pse-pd/pse.h                     | 138 ++++++--
 include/uapi/linux/ethtool_netlink.h           |   1 -
 include/uapi/linux/ethtool_netlink_generated.h |   1 +
 net/ethtool/pse-pd.c                           |  12 +-
 12 files changed, 798 insertions(+), 325 deletions(-)
---
base-commit: 849b7ca06e68813750c71c4c204372999cea6d0a
change-id: 20250104-b4-feature_poe_arrange-7ad0462f2afe

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


