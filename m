Return-Path: <netdev+bounces-88789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF0F8A8925
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 18:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC223284687
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 16:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60BF172765;
	Wed, 17 Apr 2024 16:43:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C45D171E6A
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 16:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713372218; cv=none; b=PmD5zW1MF9PTk8egaU8EYUS1CH6eI95B0R36cndICnS/J2t/5x2TkdWT6an55Ki17XgWHNoHJzQv/xAdwun9fNzylzT2bYzeOomxFVXLeiwfxyzJPE2t3LpmF3i1kNq1+vq1gX2h5bamOuvtkzKGLiM+D+rmivm1MNWbBsq7OqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713372218; c=relaxed/simple;
	bh=SnmDTYTizwIk3M6MqOWLopWd5C0GG8II866ZqhvHzXI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oOGTivOxfhw2LmObZht59DA9pcbSiHP+jFyZ5JYqqYcK4fHY4UicnljWrY60prjkG4LoX+Z4ZDIgmZlijXvNJnCYlz9B/dvGWO8gkriKcHzfjY4yiYJ0oCr3C0IM0RxuY16Wb8q7bCZXsD7JjhRF4HeWWjpHgT15r8pJP7poaIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rx8NT-0007Mz-VQ; Wed, 17 Apr 2024 18:43:19 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rx8NR-00CpCZ-On; Wed, 17 Apr 2024 18:43:17 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rx8NR-007Mdi-2D;
	Wed, 17 Apr 2024 18:43:17 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH net-next v1 0/4] add support for TimeSync path delays
Date: Wed, 17 Apr 2024 18:43:12 +0200
Message-Id: <20240417164316.1755299-1-o.rempel@pengutronix.de>
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

Add support for TimeSync path delay information to the PHY framework to
allow PHY driver provide path delay information and extend STMMAC to
make use of it.

Oleksij Rempel (4):
  net: phy: Add TimeSync delay query support to PHYlib API
  net: phy: micrel: lan8841: set default PTP latency values
  net: phy: realtek: provide TimeSync data path delays for RTL8211E
  net: stmmac: use delays reported by the PHY driver to correct MAC
    propagation delay

 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  2 +
 .../ethernet/stmicro/stmmac/stmmac_hwtstamp.c |  4 ++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 17 +++++-
 drivers/net/phy/micrel.c                      | 55 +++++++++++++++++-
 drivers/net/phy/phy_device.c                  | 57 +++++++++++++++++++
 drivers/net/phy/realtek.c                     | 42 ++++++++++++++
 include/linux/phy.h                           | 31 ++++++++++
 7 files changed, 206 insertions(+), 2 deletions(-)

-- 
2.39.2


