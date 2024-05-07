Return-Path: <netdev+bounces-94024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 310748BDFBD
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 12:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0B87288889
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 10:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAD614F109;
	Tue,  7 May 2024 10:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UGjtGGpE"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BF314EC57;
	Tue,  7 May 2024 10:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715077710; cv=none; b=kf8NYCo9b7coH/0syi8mas0KoVK4DqibG1xv2rpgzhOSc/Op++NG2fvpAsDbjS5YV0WEVNE+T6fv4Y38TpUHMuWXBFjOrtwmI0pwXLVN4gEev6LCXV2S+3daWN/S05aHttgXQKRJANirOe0qF9NlMzncxABqH8PWLI0VmZ5W4yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715077710; c=relaxed/simple;
	bh=6CnyBCfUboxU3/U3ye8c0caHs5VAVKFQUQ8qAVJv1h4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MzdefhRpF7pEvMwZWFFfBZ123+iopMNVFYp/CQLR2NhZFOJY6eBSaUtvvgdMsjHCFxw0KTQSo0mkBsZZncMZM0pcr3Y300984V9A80+XjQSnwbeBgGfyLC9HS05mBRd8xbzJ+8BHGaR5nhpecojd0oXBxB8+BJShQrwOjM1sA2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UGjtGGpE; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0E539E0005;
	Tue,  7 May 2024 10:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715077706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ITqhCXxazLVoon+f4GaKjONLG3gav92beVQ3JgZzLx0=;
	b=UGjtGGpE4rd7LX+l/EyEO0DnN+BFdH/Xu2VbbKi5pmFj58CLrusoue/Plm15glu3hLdsbp
	Sw/3iecWrxz2gU0eWaLlQKRMXh7ofmMJ58Ou01Bq/OFucprUxy1aGH67osXz7f6I1Bj5Ed
	BSptWkqA5GNYma2blriEIzSbjp94VrzYzy51fG2e3TWja+odb+clfRMc55pnZUwHsZVaAX
	l/nmunTJB9s+SggcgRPr59b5uk1Cam7TnO3vYs9E6lytjIQY4luh2c11a0QGJM6r+vAb4f
	1IEUk71xttc8GMlPUSgqBZn6Vr78ltyMOaOkKaFG2eNgM8GhYWnPXa+ekFdQ1Q==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>,
	mwojtas@chromium.org,
	Nathan Chancellor <nathan@kernel.org>,
	Antoine Tenart <atenart@kernel.org>
Subject: [PATCH net-next 0/2] Fix phy_link_topology initialization
Date: Tue,  7 May 2024 12:28:19 +0200
Message-ID: <20240507102822.2023826-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Nathan and Heiner reported issues that occur when phylib and phy drivers
built as modules expect the phy_link_topology to be initialized, due to
wrong use of IS_REACHABLE.

This small fixup series addresses that by moving the initialization code
into net/core/dev.c, but at the same time implementing lazy
initialization to only allocate the topology upon the first PHY
insertion.

This needed some refactoring, namely pass the netdevice itself as a
parameter for phy_link_topology helpers.

Thanks Heiner for the help on untangling this, and Nathan for the
report.

Maxime Chevallier (2):
  net: phy: phy_link_topology: Pass netdevice to phy_link_topo helpers
  net: phy: phy_link_topology: Lazy-initialize the link topology

 drivers/net/phy/phy_device.c           | 25 +++++----------
 drivers/net/phy/phy_link_topology.c    | 44 +++++++++++---------------
 include/linux/netdevice.h              |  2 ++
 include/linux/phy_link_topology.h      | 40 +++++++++++++----------
 include/linux/phy_link_topology_core.h | 23 +++-----------
 net/core/dev.c                         | 38 ++++++++++++++++++----
 net/ethtool/netlink.c                  |  2 +-
 7 files changed, 88 insertions(+), 86 deletions(-)

-- 
2.44.0


