Return-Path: <netdev+bounces-194726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F5AACC244
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 10:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECC351664EF
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 08:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50024268FDE;
	Tue,  3 Jun 2025 08:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KSlLLa/z"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E547918FC92;
	Tue,  3 Jun 2025 08:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748939751; cv=none; b=I+Nt1Mcx2DJXgiUUNlXZn+NpwvEMUiTofS6NoPJAhX8rcYlAP4t8XQUCQC7k3p9CLA5Nb7iJmSajRjjDdCF0ETDwLak5AqPdMezGnnfsuLX7fIRleKSqZz+qK8cJXC2nfSk2Kf+g4ISwkFqYu5mkW0eWFye/MXNKy0QdTCHZY7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748939751; c=relaxed/simple;
	bh=iodA1TKQ/rp5dkp3P8YFyYWk1y8wZhPZffAodSc5e70=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PCy2UTUtSn533Us7E0ck3yDf65cRq/kbxfSY3/Z+AcjL3IuF5r/Z8FNaNKPAZ+nxjn6/xpz0ZZYY4P/bw9IWtySGA2FIfeiGf/mzeN7nSPgESeofROEpPsL2+/BPoOiPPOoMnkENGB5vDuN6+6GZjPeQH1t7SrmLJ2pSUJ9ouNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KSlLLa/z; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5F022431D5;
	Tue,  3 Jun 2025 08:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1748939747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1srqlJJ+HV0tLpY/tiu7cWFoNzbjcxmBJOZW2g3nTFE=;
	b=KSlLLa/zTBpglEQ4+WRGl8m6hWvFQckutVPUKKherQtDW9EawdRjGZ4pGH+Im8l596QO5z
	zijbQoXjO+NH90VDrtmzNx+N6k0jw5mjJDITnJ3TKhOIpP9Sz0d3g1Uk1JBhY1cYspE3Ar
	fJYI4oywX9qyu+eqejFtmtpPXcPG1MsRVrTB9dg6M9mG7w9+GBXT+gUlyoCdO9IvSWlu/c
	EWqhqKNFJZ7SFPUGoTNfXlwUsoW0kMdJc9u2pCh5/i+icwDKYsVLZNRsNbLahWufB04iZX
	7UXcGLjJNCBjamL470mhrmQl6wEIrT89lTiL2G9LSfDCaWIO3F9p4+w1P+pOJw==
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
	Jijie Shao <shaojijie@huawei.com>
Subject: [PATCH net] net: phy: phy_caps: Don't skip better duplex macth on non-exact match
Date: Tue,  3 Jun 2025 10:35:40 +0200
Message-ID: <20250603083541.248315-1-maxime.chevallier@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdegtddtjeculddtuddrgeefvddrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeejhfelieehgfffiefftdffiedvheefteehkedukefgteffteevffeuueejiedtveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvuddvrddutdehrdduhedtrddvhedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdduvddruddthedrudehtddrvdehvddphhgvlhhopehfvgguohhrrgdrrddpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduiedprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepp
 hgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: maxime.chevallier@bootlin.com

When performing a non-exact phy_caps lookup, we are looking for a
supported mode that matches as closely as possible the passed speed/duplex.

Blamed patch broke that logic by returning a match too early in case
the caller asks for half-duplex, as a full-duplex linkmode may match
first, and returned as a non-exact match without even trying to mach on
half-duplex modes.

Reported-by: Jijie Shao <shaojijie@huawei.com>
Closes: https://lore.kernel.org/netdev/20250603102500.4ec743cf@fedora/T/#m22ed60ca635c67dc7d9cbb47e8995b2beb5c1576
Fixes: fc81e257d19f ("net: phy: phy_caps: Allow looking-up link caps based on speed and duplex")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phy_caps.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/phy_caps.c b/drivers/net/phy/phy_caps.c
index 703321689726..d80f6a37edf1 100644
--- a/drivers/net/phy/phy_caps.c
+++ b/drivers/net/phy/phy_caps.c
@@ -195,7 +195,7 @@ const struct link_capabilities *
 phy_caps_lookup(int speed, unsigned int duplex, const unsigned long *supported,
 		bool exact)
 {
-	const struct link_capabilities *lcap, *last = NULL;
+	const struct link_capabilities *lcap, *match = NULL, *last = NULL;
 
 	for_each_link_caps_desc_speed(lcap) {
 		if (linkmode_intersects(lcap->linkmodes, supported)) {
@@ -204,16 +204,19 @@ phy_caps_lookup(int speed, unsigned int duplex, const unsigned long *supported,
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


