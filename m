Return-Path: <netdev+bounces-119741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA502956CE5
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 16:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76645B27038
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 14:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF71216EB5B;
	Mon, 19 Aug 2024 14:12:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA85616D4E7
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 14:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724076777; cv=none; b=JL7Q37rwArDmOMliUZhVuRJJA9bOs2zTcK19eLwc/0ksTUdwUjGtCRd1h9ZS2wUNCCbVeUwrBzPPbFjX/nPiNwYZtSx5Hdx3cLSOm7InhNh3rJfefvL3uhSIuxIn5Tb0IcrRmfpqyuGgfAt4aSLrIwTM2fJpj94Oe4LLpOUv+/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724076777; c=relaxed/simple;
	bh=DRJl4YIIwn2E46f2qaLLxQyDiot9CEz8UryloBmtKWs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nv3vn8NbfW6JXFDBwdFAwFi4y56GQ001CNCEvvuFOreY1Z0TxmG360Gz+YHx0u6vGOaDIjmaf6plxF3lqEe8QpXdNvE3asNP0PElQt0N8jdsOHmxWjJYAoZRUhGrTa1jajvtMH6wpoccganQ4D0PPUyE4ZR0hHWx9PbF1TU0oaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sg37k-0007o5-Cj; Mon, 19 Aug 2024 16:12:44 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sg37i-001YDn-OQ; Mon, 19 Aug 2024 16:12:42 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sg37i-00BNPu-2A;
	Mon, 19 Aug 2024 16:12:42 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH net-next v1 0/3] Add ALCD Support to Cable Testing Interface
Date: Mon, 19 Aug 2024 16:12:38 +0200
Message-Id: <20240819141241.2711601-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
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

Hi all,

This patch series introduces support for Active Link Cable Diagnostics
(ALCD) in the ethtool cable testing interface and the DP83TD510 PHY
driver.

Why ALCD?
On a 10BaseT1L interface, TDR (Time Domain Reflectometry) is not
possible if the link partner is active - TDR will fail in these cases
because it requires interrupting the link. Since the link is active, we
already know the cable is functioning, so instead of using TDR, we can
use ALCD.

ALCD lets us measure cable length without disrupting the active link,
which is crucial in environments where network uptime is important. It
provides a way to gather diagnostic data without the need for downtime.

What's in this series:
- Extended the ethtool cable testing interface to specify the source of
  diagnostic results (TDR or ALCD).
- Updated the DP83TD510 PHY driver to use ALCD when the link is
  active, ensuring we can still get cable length info without dropping the
  connection.

Thanks,
Oleksij

Oleksij Rempel (3):
  ethtool: Extend cable testing interface with result source information
  ethtool: Add support for specifying information source in cable test
    results
  phy: dp83td510: Utilize ALCD for cable length measurement when link is
    active

 Documentation/networking/ethtool-netlink.rst |  5 ++
 drivers/net/phy/dp83td510.c                  | 83 ++++++++++++++++++--
 include/linux/ethtool_netlink.h              | 29 +++++--
 include/uapi/linux/ethtool_netlink.h         | 10 +++
 net/ethtool/cabletest.c                      | 14 +++-
 5 files changed, 125 insertions(+), 16 deletions(-)

--
2.39.2


