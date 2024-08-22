Return-Path: <netdev+bounces-120952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 930C395B46E
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 14:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF73B1C22FAE
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 12:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7371C9450;
	Thu, 22 Aug 2024 11:59:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D751C9430
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 11:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724327996; cv=none; b=m3aNMPjvlrGZnC7FguZMyyV4zDQAL3ezSBXOph/12bSZ17JOwJaLsJyKom9W+cy+TpQJ0b8d/fvOs4DGxnljOlOgI0zo+4Y562DzleaeIUCZ8q4NbPgvp3/bnb/aA1ulpCsRt0cSqMoYYa+bc/0t6a9zoCwk+vXKFagc6NZR/sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724327996; c=relaxed/simple;
	bh=ifZIL4p+x8sjQzuIiUtGafg1V5DS9QctREj8LGSkcBE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MDhbGEfMsellw1MlsTOrVUo63Rd1NNoTzsGQ23L2r/2n3VM6TOSp+3Bd2RmFHJEFH5kNdY1aESxFu3MI7ijHByYrEQwoXR3HYlrhK953WaaLrne47QyONQRPDeU9OFAPw9eNiFT0KPe6g/cdGPWcaraufpMz3+i87gpt5Ob8FiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sh6Te-0005ot-WC; Thu, 22 Aug 2024 13:59:43 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sh6Td-002EyQ-3q; Thu, 22 Aug 2024 13:59:41 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sh6Td-005oph-08;
	Thu, 22 Aug 2024 13:59:41 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v3 0/3] Add Statistics Support for DP83TG720 PHY
Date: Thu, 22 Aug 2024 13:59:36 +0200
Message-Id: <20240822115939.1387015-1-o.rempel@pengutronix.de>
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

This patch series primarily focuses on adding statistics support for the
DP83TG720 PHY driver. Along the way, to achieve this goal, I introduced
defines for various statistics to ensure they are reusable across
different PHY drivers.

Changes are tracked in separate patches.

Oleksij Rempel (3):
  phy: open_alliance_helpers: Add defines for link quality metrics
  phy: Add defines for standardized PHY generic counters
  phy: dp83tg720: Add statistics support

 drivers/net/phy/dp83tg720.c             | 324 ++++++++++++++++++++++++
 drivers/net/phy/open_alliance_helpers.h |  14 +
 include/linux/phy.h                     |   6 +
 3 files changed, 344 insertions(+)

--
2.39.2


