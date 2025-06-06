Return-Path: <netdev+bounces-195373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD47ACFF87
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 11:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E034189147E
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 09:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3525286424;
	Fri,  6 Jun 2025 09:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Sl5v8Ary"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381D0207A3A;
	Fri,  6 Jun 2025 09:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749203085; cv=none; b=OPUbe08bDn9evVN/dmeKFmBwK+WjrPSpca0zVzW1lKtbhe2BCQ1ze6MxaYQ7GuDTS5v7m4MtKjxw+N15oULFRfhcCbpwbHeGtM4WVewopODN+gw9xKf/Tuufm8XHK47dfUmVNmR9YkODQPTClqrYrfRMEpDr0EYUGnFZoaD6vFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749203085; c=relaxed/simple;
	bh=9qfH4e4DKeBNWo1tN5k/hRYd/YM+kbmrEZZ6Hb/KOZs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V1/qU3PHGEYXGSxASr7gWjET1ewqMCuq1SXaeV3acI6B5bOKKbazv3WnGB32AvU4Rk73SKsCcObM3uytNXcRttYkxsFvnnmP0kkjrZ4Llc5MD1+EfwXAlqLzaheMJgJDp2XbIujRKkt2Jv0cVWaLEpICzSrOvtPO2+9FjkdPf1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Sl5v8Ary; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 03E9542E77;
	Fri,  6 Jun 2025 09:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1749203081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eTDZAF5gNbxnNxj+lsJqqE9vfgSs2erOnFdEb7FBGt0=;
	b=Sl5v8AryVjAS3ndFPZhBmcx9hFXUMFuUCZ34zswapUR19vQWw3kr8zlh28JFfquff+41aw
	OqYBYRq7X+WjlTW/mT8YlsWcrPDu96IEpKTBfef0F+3XJMLpqiOdDjTkWRFKtOpr+MCZaT
	qPamB/Oik2zueznSG0VIz9HIfJr16PuUDvoY/dBY6bAXfn1GGTASm2+73unuCYAqEqNveb
	nUjHbCy3+bla4Dm9H0cdBYCPC37gB6WvwFEBUJ63FBdMdjQ7ntAdqfTQH47gG1ixy2uSu0
	2nK3Klxd9rMka1CHvRJf5SyrC7AXENylNnsiqB+EeaHWM24GhLOesCU+cFZq0A==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Simon Horman <horms@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>
Subject: [PATCH net v2] net: phy: phy_caps: Don't skip better duplex macth on non-exact match
Date: Fri,  6 Jun 2025 11:43:20 +0200
Message-ID: <20250606094321.483602-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdegleduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepjefhleeihefgffeiffdtffeivdehfeetheekudekgfetffetveffueeujeeitdevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvdduvddruddthedrudehtddrvdehvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvuddvrddutdehrdduhedtrddvhedvpdhhvghlohepfhgvughorhgrrddrpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudejpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtr
 dgtohhmpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: maxime.chevallier@bootlin.com

When performing a non-exact phy_caps lookup, we are looking for a
supported mode that matches as closely as possible the passed speed/duplex.

Blamed patch broke that logic by returning a match too early in case
the caller asks for half-duplex, as a full-duplex linkmode may match
first, and returned as a non-exact match without even trying to mach on
half-duplex modes.

Reported-by: Jijie Shao <shaojijie@huawei.com>
Closes: https://lore.kernel.org/netdev/20250603102500.4ec743cf@fedora/T/#m22ed60ca635c67dc7d9cbb47e8995b2beb5c1576
Tested-by: Jijie Shao <shaojijie@huawei.com>
Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
Fixes: fc81e257d19f ("net: phy: phy_caps: Allow looking-up link caps based on speed and duplex")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phy_caps.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/phy_caps.c b/drivers/net/phy/phy_caps.c
index 703321689726..38417e288611 100644
--- a/drivers/net/phy/phy_caps.c
+++ b/drivers/net/phy/phy_caps.c
@@ -188,6 +188,9 @@ phy_caps_lookup_by_linkmode_rev(const unsigned long *linkmodes, bool fdx_only)
  * When @exact is not set, we return either an exact match, or matching capabilities
  * at lower speed, or the lowest matching speed, or NULL.
  *
+ * Non-exact matches will try to return an exact speed and duplex match, but may
+ * return matching capabilities with same speed but a different duplex.
+ *
  * Returns: a matched link_capabilities according to the above process, NULL
  *	    otherwise.
  */
@@ -195,7 +198,7 @@ const struct link_capabilities *
 phy_caps_lookup(int speed, unsigned int duplex, const unsigned long *supported,
 		bool exact)
 {
-	const struct link_capabilities *lcap, *last = NULL;
+	const struct link_capabilities *lcap, *match = NULL, *last = NULL;
 
 	for_each_link_caps_desc_speed(lcap) {
 		if (linkmode_intersects(lcap->linkmodes, supported)) {
@@ -204,16 +207,19 @@ phy_caps_lookup(int speed, unsigned int duplex, const unsigned long *supported,
 			if (lcap->speed == speed && lcap->duplex == duplex) {
 				return lcap;
 			} else if (!exact) {
-				if (lcap->speed <= speed)
-					return lcap;
+				if (!match && lcap->speed <= speed)
+					match = lcap;
+
+				if (lcap->speed < speed)
+					break;
 			}
 		}
 	}
 
-	if (!exact)
-		return last;
+	if (!match && !exact)
+		match = last;
 
-	return NULL;
+	return match;
 }
 EXPORT_SYMBOL_GPL(phy_caps_lookup);
 
-- 
2.49.0


