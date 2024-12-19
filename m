Return-Path: <netdev+bounces-153362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EDE9F7C4A
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 14:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B26816E6D1
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 13:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26799226885;
	Thu, 19 Dec 2024 13:26:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D60122617B
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 13:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734614760; cv=none; b=ajON6xiwZwkHlsMbOJ789yB3CeVYgVqKAwjS2MNpWe4nn3ifcdxMcEXZpRzidN15cGgp3G6P/oUVOL2jeKWhrFKUMy4HtQNteTVFW9/XvXA5JG6FDqtiWh8LVWYRbmSe/b8XI4WdgQJ0hIP8gLA7dS4Atdy6TM7TZSssH2k4SpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734614760; c=relaxed/simple;
	bh=H8PBU6YBunl5m+XVqkNlGY6nm88AacUolrH6LXGR5bg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ae5wqC15O846yON7nT6RDJare+eAZu3EhkCJuDwvjZI26ILH9rt6QNzs6szl0IpRH6qa/yENtgP7SvS/t0lGc3uq7VDs414R0y0lQb3GbeUrRSoEcq6NbX59T+YZcjtlfg8yCwLcG36wbbQZSwnLSLs6uiRB0WBPfvDjKCGP32M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tOGX5-0001b5-Oe; Thu, 19 Dec 2024 14:25:39 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tOGX0-004DD9-1b;
	Thu, 19 Dec 2024 14:25:35 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tOGX1-0032gj-0d;
	Thu, 19 Dec 2024 14:25:35 +0100
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
Subject: [PATCH net-next v2 0/8] Introduce unified and structured PHY
Date: Thu, 19 Dec 2024 14:25:26 +0100
Message-Id: <20241219132534.725051-1-o.rempel@pengutronix.de>
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
 drivers/net/phy/phy.c                         |  64 +++++++
 include/linux/ethtool.h                       |  39 +++++
 include/linux/phy.h                           |  62 +++++++
 include/uapi/linux/ethtool.h                  |   2 +
 include/uapi/linux/ethtool_netlink.h          |  14 ++
 net/ethtool/linkstate.c                       |  25 ++-
 net/ethtool/netlink.h                         |   1 +
 net/ethtool/stats.c                           |  54 ++++++
 net/ethtool/strset.c                          |   5 +
 13 files changed, 559 insertions(+), 20 deletions(-)

--
2.39.5


