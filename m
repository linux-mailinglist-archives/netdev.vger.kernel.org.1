Return-Path: <netdev+bounces-153885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F83F9F9F32
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 09:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54BF5188B77C
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 08:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E651F0E27;
	Sat, 21 Dec 2024 08:15:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C511E9B0C
	for <netdev@vger.kernel.org>; Sat, 21 Dec 2024 08:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734768951; cv=none; b=LROpVRteXynHt+bI/mCxYeChdjVJpIegp9QM60CRNbheZdFw7wmq30pSmV5cD0qA0zZu/B5+br8RVJH/u+uWm8CuuWNvmlcJBi1X66dCPlWFv8FAqw0r5Sfkl1+oUbP7Bw7tIB9et1EulgCPOlgdHA91BkmewSzgDQUMd5p8R6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734768951; c=relaxed/simple;
	bh=5/zeVG6zhz2RUTXu9PuGhV9qbyrvh+Ch2nkjQ+KaGCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HOaUnyx+V1UiywAu9V5jDZssQUqMwI19MjNFQk1v9gRPTSpAtCNPgwR2MKwuk0OpM7g2yTGs9lbZD4dl9mEEra91Pdx90fInaAxGaOOjx5X+8vOHyXj1RG7SDxJtOytFb1BQ8uhk8Q1xGKRxd9OL2wygz1zEf+ubgknydyryIc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tOue8-0000Qj-3p; Sat, 21 Dec 2024 09:15:36 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tOue2-004Vdn-2k;
	Sat, 21 Dec 2024 09:15:31 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tOue3-00CbSZ-1l;
	Sat, 21 Dec 2024 09:15:31 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next v4 0/8] Introduce unified and structured PHY
Date: Sat, 21 Dec 2024 09:15:22 +0100
Message-Id: <20241221081530.3003900-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
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

This patch set introduces a unified and well-structured interface for
reporting PHY statistics. Instead of relying on arbitrary strings in PHY
drivers, this interface provides a consistent and structured way to
expose PHY statistics to userspace via ethtool.

The initial groundwork for this effort was laid by Jakub Kicinski, who
contributed patches to plumb PHY statistics to drivers and added support
for structured statistics in ethtool. Building on Jakub's work, I tested
the implementation with several PHYs, addressed a few issues, and added
support for statistics in two specific PHY drivers.

changes are tracked in separate patches.

Jakub Kicinski (2):
  net: ethtool: plumb PHY stats to PHY drivers
  net: ethtool: add support for structured PHY statistics

Oleksij Rempel (6):
  ethtool: linkstate: migrate linkstate functions to support multi-PHY
    setups
  Documentation: networking: update PHY error counter diagnostics in
    twisted pair guide
  net: phy: introduce optional polling interface for PHY statistics
  ethtool: add helper to prevent invalid statistics exposure to
    userspace
  net: phy: dp83td510: add statistics support
  net: phy: dp83tg720: add statistics support

 .../twisted_pair_layer1_diagnostics.rst       |  39 +++--
 Documentation/networking/ethtool-netlink.rst  |   1 +
 drivers/net/phy/dp83td510.c                   | 112 ++++++++++++
 drivers/net/phy/dp83tg720.c                   | 161 ++++++++++++++++++
 drivers/net/phy/phy.c                         |  20 +++
 include/linux/ethtool.h                       |  39 +++++
 include/linux/phy.h                           |  97 +++++++++++
 include/uapi/linux/ethtool.h                  |   2 +
 include/uapi/linux/ethtool_netlink.h          |  14 ++
 net/ethtool/linkstate.c                       |  25 ++-
 net/ethtool/netlink.h                         |   1 +
 net/ethtool/stats.c                           |  54 ++++++
 net/ethtool/strset.c                          |   5 +
 13 files changed, 550 insertions(+), 20 deletions(-)

--
2.39.5


