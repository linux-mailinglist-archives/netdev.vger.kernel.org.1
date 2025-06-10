Return-Path: <netdev+bounces-195976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0E1AD2F90
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 10:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 712A016E7EB
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 08:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC46F280001;
	Tue, 10 Jun 2025 08:11:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6ACE19CC3C
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 08:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749543093; cv=none; b=ooh8r0iFVTjNDQs9AV8WGzi4al6+lb0UQqzQ73ArZhiz10+y+EZGX8cAvs3eAdb+FLNr8E78z2+xsSVpplSCIyQpXwvf6Hm86SZaJUeVngmCEeHTsVEcsA9a+DHNp9r5kIP8XsIhhnvXWQZl3EXP6uZN3zd3PqP90y6eV/MEP1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749543093; c=relaxed/simple;
	bh=WBM0iHONcgfXQ0gQPFjD0cs2K6wuRhwoywRwN5wmuew=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=oUV+H7rWJ3mx7XFVmGELN7AngWM/JbBmi1haN4n73NenugwBAn4SdAIkZo3NNT4R0WOjFKQ5my3LzURhk7N05BSl7diABpYoLTYcS2I9+D42gTFiTWoPWpSIySqmIQejDmI+hJ9tWp5AtFZk8KBLkgDMre3mLfq6flyjzWy9o5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uOu4T-0006BD-AY; Tue, 10 Jun 2025 10:11:01 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uOu4S-002jx2-0W;
	Tue, 10 Jun 2025 10:11:00 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uOu4S-00G7cP-0G;
	Tue, 10 Jun 2025 10:11:00 +0200
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
Subject: [PATCH net-next v1 0/3] dp83tg720: Reduce link recovery
Date: Tue, 10 Jun 2025 10:10:56 +0200
Message-Id: <20250610081059.3842459-1-o.rempel@pengutronix.de>
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

This patch series improves the link recovery behavior of the TI
DP83TG720 PHY driver.

Previously, we introduced randomized reset delay logic to avoid reset
collisions in multi-PHY setups. While this approach was functional, it
had notable drawbacks: unpredictable behavior, longer and more variable
link recovery times, and overall higher complexity in link handling.

With this new approach, we replace the randomized delay with
deterministic, role-specific delays in the PHY reset logic. This enables
us to:
- Remove the redundant empirical 600 ms delay in read_status()
- Drop the random polling interval logic
- Introduce a clean, adaptive polling strategy with consistent
behavior and improved responsiveness

As a result, the PHY is now able to recover link reliably in under
1000 ms

David Jander (3):
  net: phy: dp83tg720: implement soft reset with asymmetric delay
  net: phy: dp83tg720: remove redundant 600ms post-reset delay
  net: phy: dp83tg720: switch to adaptive polling and remove random
    delays

 drivers/net/phy/dp83tg720.c | 179 ++++++++++++++++++++++++------------
 1 file changed, 120 insertions(+), 59 deletions(-)

--
2.39.5


