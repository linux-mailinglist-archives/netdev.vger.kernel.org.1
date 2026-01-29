Return-Path: <netdev+bounces-254864-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMkXJoOVe2nOGAIAu9opvQ
	(envelope-from <netdev+bounces-254864-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 18:14:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B84B2B5C
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 18:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D0263015723
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 17:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0EA347BA8;
	Thu, 29 Jan 2026 17:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iJdBs1Uh"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623BA3314C4
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 17:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769706744; cv=none; b=Lv6v20B9tTGP5tKXjbRLzfjnIw2ecqxa9BNBrraNiNk1dHMGAaLzGsrq+06FyBUHO9SjReizcq659dsHb79fcOobjI5fRvJaWkX99bVrjuUCVdeTzVbGO/KGCvAe0Fe2GmG3+nSiQ/1/UgKs9IIV3p8e1GOkC3WOyiU+R5bIKWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769706744; c=relaxed/simple;
	bh=OXC1A2rsvEUcoHNtQ2UJItXyNZCYYO98F6lgzlaZNyg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IKjmyGuTMJJBOgtKACZnZ+ZAOF6WIkFZLEznBWn75A/pkoTtWuimNTCSDkLdp5oE+VEdejxJqKKiUFRxtUTzTuWbl1AQdfDtWenDQiHJdDyZJWAzP9haqKCKrKtuvqowTy92wbcUkmqZOQ02p9UEErbhvc+8272iknVHfnZ2qaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iJdBs1Uh; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769706739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EwiQGEV6gt5loAkyx50doAeyjzyj3tZN9e7LGO6xQp0=;
	b=iJdBs1UhjaO+argsRf0QDssIhZtdEWNURcYRXn0xhaL9XkL+VDwsHZtbGqSiL1p+EKtggj
	onxMDUpcomBMZX+B6ebYLmkafj2cV2Zmw0rjheGTeHZH/FSWnhUwJ41tNnCI5QgQjeuHNX
	F6xDARAbSi8lzyaH99pN03c681YaL60=
From: Sean Anderson <sean.anderson@linux.dev>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH net-next 1/2] net: phy: dp83867: Program TX FIFO for all interfaces
Date: Thu, 29 Jan 2026 12:12:04 -0500
Message-Id: <20260129171205.3868605-2-sean.anderson@linux.dev>
In-Reply-To: <20260129171205.3868605-1-sean.anderson@linux.dev>
References: <20260129171205.3868605-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254864-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.anderson@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 19B84B2B5C
X-Rspamd-Action: no action

All supported interfaces use the TX FIFO register at least some of the
time, so there's no point in checking the interface. Retain the check
for the RX FIFO level since it is only used by SGMII.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/net/phy/dp83867.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
index 5f5de01c41e1..7e16e9299457 100644
--- a/drivers/net/phy/dp83867.c
+++ b/drivers/net/phy/dp83867.c
@@ -744,27 +744,24 @@ static int dp83867_config_init(struct phy_device *phydev)
 	 */
 	phy_disable_eee(phydev);
 
-	if (phy_interface_is_rgmii(phydev) ||
-	    phydev->interface == PHY_INTERFACE_MODE_SGMII) {
-		val = phy_read(phydev, MII_DP83867_PHYCTRL);
-		if (val < 0)
-			return val;
+	val = phy_read(phydev, MII_DP83867_PHYCTRL);
+	if (val < 0)
+		return val;
 
-		val &= ~DP83867_PHYCR_TX_FIFO_DEPTH_MASK;
-		val |= (dp83867->tx_fifo_depth <<
-			DP83867_PHYCR_TX_FIFO_DEPTH_SHIFT);
+	val &= ~DP83867_PHYCR_TX_FIFO_DEPTH_MASK;
+	val |= (dp83867->tx_fifo_depth <<
+		DP83867_PHYCR_TX_FIFO_DEPTH_SHIFT);
 
-		if (phydev->interface == PHY_INTERFACE_MODE_SGMII) {
-			val &= ~DP83867_PHYCR_RX_FIFO_DEPTH_MASK;
-			val |= (dp83867->rx_fifo_depth <<
-				DP83867_PHYCR_RX_FIFO_DEPTH_SHIFT);
-		}
-
-		ret = phy_write(phydev, MII_DP83867_PHYCTRL, val);
-		if (ret)
-			return ret;
+	if (phydev->interface == PHY_INTERFACE_MODE_SGMII) {
+		val &= ~DP83867_PHYCR_RX_FIFO_DEPTH_MASK;
+		val |= (dp83867->rx_fifo_depth <<
+			DP83867_PHYCR_RX_FIFO_DEPTH_SHIFT);
 	}
 
+	ret = phy_write(phydev, MII_DP83867_PHYCTRL, val);
+	if (ret)
+		return ret;
+
 	if (phy_interface_is_rgmii(phydev)) {
 		val = phy_read(phydev, MII_DP83867_PHYCTRL);
 		if (val < 0)
-- 
2.35.1.1320.gc452695387.dirty


