Return-Path: <netdev+bounces-133412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEADF995D8A
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 03:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 085651C20E35
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 01:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247327DA6D;
	Wed,  9 Oct 2024 01:57:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9924C76035;
	Wed,  9 Oct 2024 01:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728439034; cv=none; b=c279D58UAQBhlZv08tm/K8KRi3xq2mtxfM6kQ8ibAEVbrELqJyoIwNOc9g1FMcUWXGInWi1AWzUtxQmUTN9I20db4wkD0V/lh/1jMZk9HFzpqpdguCqvDs+6Lk+mW35SGlnhO2+4hWlt/nV1GraQ0IEfKIwWY96nkgsW1XPoyvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728439034; c=relaxed/simple;
	bh=mbw00cvuCGQSvmtJ08Yq0zuVY0bhWYpIq5OWoanYgyc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bEpxFINZT91Ep75h9eqLIkWUKAQMp2IB0ZnoEUGdPM1rzYTalrs0M6AQsaxXZsHmHaavXaa4Q3kHPd7++y//pkQgFDYa7thQcma9izxMidtJd4mkMTHc7xQP2frzzkOSGozihOh5mRCEbCHKaHd1CCX5A2y39vufHrdhv1Q1qzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1syLwr-000000003LB-09eE;
	Wed, 09 Oct 2024 01:57:09 +0000
Date: Wed, 9 Oct 2024 02:57:03 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: phy: populate host_interfaces when attaching
 PHY
Message-ID: <ae53177a7b68964b2a988934a09f74a4931b862d.1728438951.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Use bitmask of interfaces supported by the MAC for the PHY to choose
from if the declared interface mode is among those using a single pair
of SerDes lanes.
This will allow 2500Base-T PHYs to switch to SGMII on most hosts, which
results in half-duplex being supported in case the MAC supports that.
Without this change, 2500Base-T PHYs will always operate in 2500Base-X
mode with rate-matching, which is not only wasteful in terms of energy
consumption, but also limits the supported interface modes to
full-duplex only.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/phy/phylink.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 4309317de3d1..5d043c47a727 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -2111,6 +2111,13 @@ int phylink_fwnode_phy_connect(struct phylink *pl,
 		pl->link_config.interface = pl->link_interface;
 	}
 
+	/* Assume SerDes interface modes share the same lanes and allow
+	 * the PHY to switch between the
+	 */
+	if (test_bit(pl->link_interface, phylink_sfp_interfaces))
+		phy_interface_and(phy_dev->host_interfaces, phylink_sfp_interfaces,
+				  pl->config->supported_interfaces);
+
 	if (pl->config->mac_requires_rxc)
 		flags |= PHY_F_RXC_ALWAYS_ON;
 
-- 
2.47.0


