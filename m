Return-Path: <netdev+bounces-120084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C369583CF
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 12:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FFF12870F0
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 10:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2323618CC17;
	Tue, 20 Aug 2024 10:13:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBB118CBE2
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 10:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724148792; cv=none; b=NLCIe1VpM7r1M67KMg9pRfrY1T944y6NIeNRrL8/+72tgOmm4PmgXlIln0ksA/TQe4z9P5bOvcu81bpWn2qx/MZPA/wNa180UxYgQFbV8Bmw95cJiUPqIhG/9rMuB9oBZSuaqF5F4FzowRe+JRI+NoGFdf2+OD7S5dsqj+qdiJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724148792; c=relaxed/simple;
	bh=PJ53OXMTro8zUUYvwyoc479yWOaAfo0UYmKBgi7t8ok=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZHry2mEYY5GwMqS+IdvgsGFJ3rEvVv25PcAc0kqUdbv6N9mIpwVAlTR/i95EsKiqUb43HVDUCpTqu54CmrBZDYjpXaW8282p5+luFocY0y2ccEe2j60iufBrBqXc5dVBJ9lEyVTL3S7cEaQyVLM74/TdVsbF233BHk2r/xJjGyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sgLrG-0000gj-Tm; Tue, 20 Aug 2024 12:12:58 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sgLrF-001kNa-EB; Tue, 20 Aug 2024 12:12:57 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sgLrF-006Ju9-1B;
	Tue, 20 Aug 2024 12:12:57 +0200
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
Subject: [PATCH net-next v2 0/3] Add ALCD Support to Cable Testing Interface
Date: Tue, 20 Aug 2024 12:12:53 +0200
Message-Id: <20240820101256.1506460-1-o.rempel@pengutronix.de>
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

Changes are described in separate patches.

Thanks,
Oleksij

Oleksij Rempel (3):
  ethtool: Extend cable testing interface with result source information
  ethtool: Add support for specifying information source in cable test
    results
  phy: dp83td510: Utilize ALCD for cable length measurement when link is
    active

 Documentation/netlink/specs/ethtool.yaml     |  6 ++
 Documentation/networking/ethtool-netlink.rst |  5 ++
 drivers/net/phy/dp83td510.c                  | 83 ++++++++++++++++++--
 include/linux/ethtool_netlink.h              | 29 +++++--
 include/uapi/linux/ethtool_netlink.h         | 11 +++
 net/ethtool/cabletest.c                      | 19 ++++-
 6 files changed, 137 insertions(+), 16 deletions(-)

--
2.39.2


