Return-Path: <netdev+bounces-96678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA518C71D8
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 09:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA57528293C
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 07:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067492C6A3;
	Thu, 16 May 2024 07:09:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852882744D
	for <netdev@vger.kernel.org>; Thu, 16 May 2024 07:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715843348; cv=none; b=p9LFv5B02I7NHBhVfp93At4NSJGS4nLAhaCRcJ0T6nKXIewqpxHXfj//AKIwUJD0xWJkWM/i6nOSlr3bY28Sj2V/ts1VubJyeiUeQkzyZY8K7QkI8L8FpwRE7sVwyflqnzwt8rEAQSQC+jFCAyJFw+j9k+BfRZYPnhxJYYyPaK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715843348; c=relaxed/simple;
	bh=f3MDXizVpz5AMps7xWG2L7B0OhEHYRetsA5RWxit9fg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=clpdvJLojMWEm+NYaN65FqkZA/UVPv6vbkeCDHLxqAwH4IJXA9Tn5LSan0r8sFBesmYtBAa95Qn87QuLhpLVvi0mB6LMvH1nehYtELmGVTkyo5g21UF7MtMO07yZC35r2vsA3It5FPlUzrkLwOqSudVjozAkopvcy3uSmIuOJUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1s7VEV-0006C4-R4; Thu, 16 May 2024 09:08:55 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1s7VET-001fTT-No; Thu, 16 May 2024 09:08:53 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1s7VET-008CG3-21;
	Thu, 16 May 2024 09:08:53 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	David Ahern <dsahern@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	=?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>
Subject: [PATCH net v1 1/1] net: dsa: microchip: Correct initialization order for KSZ88x3 ports
Date: Thu, 16 May 2024 09:08:52 +0200
Message-Id: <20240516070852.1953381-1-o.rempel@pengutronix.de>
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

Adjust the initialization sequence of KSZ88x3 switches to enable
802.1p priority control on Port 2 before configuring Port 1. This
change ensures the apptrust functionality on Port 1 operates
correctly, as it depends on the priority settings of Port 2. The
prior initialization sequence incorrectly configured Port 1 first,
which could lead to functional discrepancies.

Fixes: a1ea57710c9d ("net: dsa: microchip: dcb: add special handling for KSZ88X3 family")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/dsa/microchip/ksz_dcb.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz_dcb.c b/drivers/net/dsa/microchip/ksz_dcb.c
index a971063275629..19b228b849247 100644
--- a/drivers/net/dsa/microchip/ksz_dcb.c
+++ b/drivers/net/dsa/microchip/ksz_dcb.c
@@ -805,5 +805,18 @@ int ksz_dcb_init(struct ksz_device *dev)
 	if (ret)
 		return ret;
 
+	/* Enable 802.1p priority control on Port 2 during switch initialization.
+	 * This setup is critical for the apptrust functionality on Port 1, which
+	 * relies on the priority settings of Port 2. Note: Port 1 is naturally
+	 * configured before Port 2, necessitating this configuration order.
+	 */
+	if (ksz_is_ksz88x3(dev)) {
+		ret = ksz_prmw8(dev, KSZ_PORT_2, KSZ8_REG_PORT_1_CTRL_0,
+				KSZ8_PORT_802_1P_ENABLE,
+				KSZ8_PORT_802_1P_ENABLE);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
-- 
2.39.2


