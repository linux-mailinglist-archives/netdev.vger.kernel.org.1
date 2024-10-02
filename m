Return-Path: <netdev+bounces-131302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84EA398E0A5
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 18:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47F35282CFC
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 16:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECAFB1D0E29;
	Wed,  2 Oct 2024 16:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FGk/ANKk"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63B21D049A;
	Wed,  2 Oct 2024 16:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727886549; cv=none; b=D84GwPHhqkcqelNtIdbR8L65z9qNtnRu0yyBYSrY94q4bKGWPhn80n+c2YLOIIWbV2VvW62DKqMkBc+/7wg5TeV6gcOfg+9pzZZ8jh+eONLE7WN0jH4rTa4Oa2POLHdelj0jif/psyDnFVi6lttr1leytzwPj1MPi7ZtZ3f8wlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727886549; c=relaxed/simple;
	bh=k+l8NvHNF0Rq60lqLNz6z89Ccblbf/w4q4LDoOKMFmo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=snJySWusiovC/UO5Pv7fGgvlwtYb5VVoBc2Xq7jd95VhR1/4lYwQRLvRfGM53+IQWll8k1QXUTOjNga6fb6/tiBqrAJ4eGKPYmtHvgTIUxm3WNRj93DRme2fEOjF+yqNfknP3wQae8pqGbRAGfICJ3jHMiRLXBnaT2Ulk2J4VMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FGk/ANKk; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3F3281BF204;
	Wed,  2 Oct 2024 16:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727886546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3IOGE5DuxU1rVrz5JJqkijX1lb9Jty0fXaR7az9v+iI=;
	b=FGk/ANKkOJVlPzTLNNrk0H6H9nQkmr2iQ3/JLyKDE9PYQOdynsQMWP0bgsIjrHfij8jiKN
	thwEubji3RpwDdDsLmCfqedRzr0oHpnpZTd0ezCqIfcgMLeR3QoPuO7fv1ljNgtgEsDIqT
	YSyMCN7TGVzhoPjw5bMd0zbNTD/ieuIVW6V7tWoJEDTPpeY6RGG+gpJOD81iWlFrmrqeW8
	+bz4OzUXBczhWlyMWXkPE7qfN1yZQjXEoRCP1bw/Pfkj1WehAjPhMbse6je5oxuA5tqvZT
	+arPZj77XU9QJ5w883BUXAuNA/YNmQ76EZVZM9d7oEiyGv/5EvkzWKbjFjE51Q==
From: Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH net-next 00/12] Add support for PSE port priority
Date: Wed, 02 Oct 2024 18:27:56 +0200
Message-Id: <20241002-feature_poe_port_prio-v1-0-787054f74ed5@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAIx0/WYC/x2MzQqDMBAGX0X23EB+lNK+SikS4qfdSxI2qQjiu
 xs9zGEOMzsVCKPQu9tJsHLhFJuYR0fh5+MCxVNzstr2+mWcmuHrXzDmdCF1zMJJ+cF4TE/nLAK
 1Ngtm3u7vhyKqitgqfY/jBCuiJBxxAAAA
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

This series brings support for port priority in the PSE subsystem.
PSE controllers can set priorities to decide which ports should be
turned off in case of special events like over-current.

This series also adds support for the devm_pse_irq_helper() helper,
similarly to devm_regulator_irq_helper(), to report events and errors.
Wrappers are used to avoid regulator naming in PSE drivers to prevent
confusion.

Patches 1-3: Cosmetics.
Patch 4: Adds support for last supported features in the TPS23881 drivers.
Patches 5-7: Add support for port priority in PSE core and ethtool.
Patches 8-9: Add support for port priority in PD692x0 and TPS23881 drivers.
Patches 10-11: Add support for devm_pse_irq_helper() helper in PSE core and
               ethtool.
Patch 12: Adds support for interrupt and event report in TPS23881 driver.

This patch series is based on the fix sent recently:
https://lore.kernel.org/netdev/20241002121706.246143-1-kory.maincent@bootlin.com/T/#u

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
Kory Maincent (12):
      net: pse-pd: Remove unused pse_ethtool_get_pw_limit function declaration
      net: pse-pd: tps23881: Correct boolean evaluation for bitmask checks
      net: pse-pd: tps23881: Simplify function returns by removing redundant checks
      net: pse-pd: tps23881: Add support for power limit and measurement features
      net: pse-pd: Add support for getting and setting port priority
      net: ethtool: Add PSE new port priority support feature
      netlink: specs: Expand the PSE netlink command with C33 prio attributes
      net: pse-pd: pd692x0: Add support for PSE PI priority feature
      net: pse-pd: tps23881: Add support for PSE PI priority feature
      net: pse-pd: Register regulator even for undescribed PSE PIs
      net: pse-pd: Add support for event reporting using devm_regulator_irq_helper
      net: pse-pd: tps23881: Add support for PSE events and interrupts

 Documentation/netlink/specs/ethtool.yaml     |  11 +
 Documentation/networking/ethtool-netlink.rst |  16 +
 drivers/net/pse-pd/pd692x0.c                 |  23 ++
 drivers/net/pse-pd/pse_core.c                |  66 +++-
 drivers/net/pse-pd/tps23881.c                | 532 +++++++++++++++++++++++++--
 include/linux/pse-pd/pse.h                   |  43 ++-
 include/uapi/linux/ethtool_netlink.h         |   2 +
 net/ethtool/pse-pd.c                         |  18 +
 8 files changed, 674 insertions(+), 37 deletions(-)
---
base-commit: 8052e7ff851b33e77f23800f8d15bafae9f97d17
change-id: 20240913-feature_poe_port_prio-a51aed7332ec

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


