Return-Path: <netdev+bounces-162437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEB4A26E8F
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 10:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05BDB7A3952
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 09:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CAD20AF96;
	Tue,  4 Feb 2025 09:33:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6268520A5D3
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 09:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738661595; cv=none; b=Y+ZoG9Uc2/O1tPKMTQld61rwuc80s344IC8RLe+qQ4b6p7C0E+Mt5c65lyfWgy/v63nzegJ5OfF+vXcyvb6rJnRzmBfZ7w7Vm0DnngJ2rDpy6ZuXowkkeO0zpAWLToAWubHm8fYKcNMxnWBCxu9EcRziuHSQrZI7R9Z9JHr/ALI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738661595; c=relaxed/simple;
	bh=UhmlX7NngGlKiQg7PIi1PHmw2RN8jM0tc7R87ORha08=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CIdBizfV4H5DnyfovZgnqr0ZHJl209on0uwS6BNW7Ln0Dvd4FfsKVpxsXBF/FnZtIZeDwXVqBpNQSbHiTbYLEB6oOAhV48u6JqongiFNSqckDAFrgbMilF+0F+DSs7+0uK8yQl8V6Le9NydnHe92hSujxmBKjr7vnUmXYqX54rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tfFIR-0002hT-5P; Tue, 04 Feb 2025 10:32:43 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tfFIP-003RRm-2s;
	Tue, 04 Feb 2025 10:32:41 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tfFIP-00ABRw-2d;
	Tue, 04 Feb 2025 10:32:41 +0100
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
Subject: [PATCH net-next v1 0/2] Use PHYlib for reset randomization and adjustable polling
Date: Tue,  4 Feb 2025 10:32:37 +0100
Message-Id: <20250204093239.2427263-1-o.rempel@pengutronix.de>
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

Hi all,

This patch set tackles a DP83TG720 reset lock issue and improves PHY
polling. Rather than adding a separate polling worker to randomize PHY
resets, I chose to extend the PHYlib framework - which already handles
most of the needed functionality - with adjustable polling. This
approach not only addresses the DP83TG720-specific problem (where
synchronized resets can lock the link) but also lays the groundwork for
optimizing PHY stats polling across all PHY drivers. With generic PHY
stats coming in, we can adjust the polling interval based on hardware
characteristics, such as using longer intervals for PHYs with stable HW
counters or shorter ones for high-speed links prone to counter
overflows.

Oleksij Rempel (2):
  net: phy: Add support for driver-specific next update time
  net: phy: dp83tg720: Add randomized polling intervals for unstable
    link detection

 drivers/net/phy/dp83tg720.c | 78 +++++++++++++++++++++++++++++++++++++
 drivers/net/phy/phy.c       | 28 ++++++++++++-
 include/linux/phy.h         | 13 +++++++
 3 files changed, 117 insertions(+), 2 deletions(-)

--
2.39.5


