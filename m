Return-Path: <netdev+bounces-214892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B49BEB2BA41
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 09:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1CFC5649A1
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 07:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEC83101CD;
	Tue, 19 Aug 2025 07:13:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204752848B9
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 07:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755587604; cv=none; b=fyeGz/9T8dC4x84TTioLqYnG3E6Qk8v6+DSiaEsWkfaKmtspYyq7seJUuK53EW+tmdH9OptrWgKOTQEOOvf0/vNdUJVvVHccqM+ZwO/5UvUsVfZZpt7RmnqOfhiOHqZ5LqBEZFTtUSPbevuVR3WCjkPuurD+ZwjIDK5lHNGvO00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755587604; c=relaxed/simple;
	bh=g6vZS+BOsJbYG+Z16z05pePoADv6yTls1nRLg9R2Pv4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=FzykIYwIVwcKIQt1rXMTBH/nQrCanG6DA8hwiDWyij9IiajlrU5KdRVBnJEbIt6wdEL4PfqgtR65K0LrmHtox+qdcQLXuTrwNysuT7FTUkCnVLQcaAT+TkqsyWLzwQcy17xEAQqs/uiEQ9h25caO2AUT+urFjoYZY6FtI89WuDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uoGWj-0004jI-QK; Tue, 19 Aug 2025 09:13:01 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uoGWf-00121W-0Q;
	Tue, 19 Aug 2025 09:12:57 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uoGWf-00EEam-07;
	Tue, 19 Aug 2025 09:12:57 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Nishanth Menon <nm@ti.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	linux-doc@vger.kernel.org,
	Michal Kubecek <mkubecek@suse.cz>,
	Roan van Dijk <roan@protonic.nl>
Subject: [PATCH net-next v3 0/5] ethtool: introduce PHY MSE diagnostics UAPI and drivers
Date: Tue, 19 Aug 2025 09:12:51 +0200
Message-Id: <20250819071256.3392659-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

changes v3:
- add missing ETHTOOL_A_LINKSTATE_MSE_* yaml changes
changes v2:
- rebase on latest net-next

This series introduces a generic kernel-userspace API for retrieving PHY
Mean Square Error (MSE) diagnostics, together with netlink integration,
a fast-path reporting hook in LINKSTATE_GET, and initial driver
implementations for the KSZ9477 and DP83TD510E PHYs.

MSE is defined by the OPEN Alliance "Advanced diagnostic features for
100BASE-T1 automotive Ethernet PHYs" specification [1] as a measure of
slicer error rate, typically used internally to derive the Signal
Quality Indicator (SQI). While SQI is useful as a normalized quality
index, it hides raw measurement data, varies in scaling and thresholds
between vendors, and may not indicate certain failure modes - for
example, cases where autonegotiation would fail even though SQI reports
a good link. In practice, such scenarios can only be investigated in
fixed-link mode; here, MSE can provide an empirically estimated value
indicating conditions under which autonegotiation would not succeed.

Example output with current implementation:
root@DistroKit:~ ethtool lan1
Settings for lan1:
...
        Speed: 1000Mb/s
        Duplex: Full
...
        Link detected: yes
        SQI: 5/7
        MSE: 3/127 (channel: worst)

root@DistroKit:~ ethtool --show-mse lan1
MSE diagnostics for lan1:
MSE Configuration:
        Max Average MSE: 127
        Refresh Rate: 2000000 ps
        Symbols per Sample: 250
        Supported capabilities: average channel-a channel-b channel-c
                                channel-d worst

MSE Snapshot (Channel: a):
        Average MSE: 4

MSE Snapshot (Channel: b):
        Average MSE: 3

MSE Snapshot (Channel: c):
        Average MSE: 2

MSE Snapshot (Channel: d):
        Average MSE: 3

[1] https://opensig.org/wp-content/uploads/2024/01/Advanced_PHY_features_for_automotive_Ethernet_V1.0.pdf

Oleksij Rempel (5):
  ethtool: introduce core UAPI and driver API for PHY MSE diagnostics
  ethtool: netlink: add ETHTOOL_MSG_MSE_GET and wire up PHY MSE access
  ethtool: netlink: add lightweight MSE reporting to LINKSTATE_GET
  net: phy: micrel: add MSE interface support for KSZ9477 family
  net: phy: dp83td510: add MSE interface support for 10BASE-T1L

 Documentation/netlink/specs/ethtool.yaml      | 175 +++++++++
 Documentation/networking/ethtool-netlink.rst  |  74 ++++
 drivers/net/phy/dp83td510.c                   |  44 +++
 drivers/net/phy/micrel.c                      |  76 ++++
 include/linux/phy.h                           | 126 ++++++
 .../uapi/linux/ethtool_netlink_generated.h    |  94 +++++
 net/ethtool/Makefile                          |   2 +-
 net/ethtool/linkstate.c                       |  84 ++++
 net/ethtool/mse.c                             | 362 ++++++++++++++++++
 net/ethtool/netlink.c                         |  10 +
 net/ethtool/netlink.h                         |   2 +
 11 files changed, 1048 insertions(+), 1 deletion(-)
 create mode 100644 net/ethtool/mse.c

--
2.39.5


