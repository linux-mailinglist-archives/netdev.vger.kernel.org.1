Return-Path: <netdev+bounces-185406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C105A9A2FE
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 09:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B35DC7A143E
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 07:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045A71E633C;
	Thu, 24 Apr 2025 07:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CbCZT+Rd"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CBD8BE8;
	Thu, 24 Apr 2025 07:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745478761; cv=none; b=Ew9MZSzwJd3TKNEZnammKr4UI5kPLvnRP7lQPLHRMAVl1Xfos7YHXBZDmZRNhjhP0GoLcbu0SJN+jAC448IUOLglRluC7SHmZEnLHWUdrnfW4TumsX27SwNQlL2zj0wM6u7LmFFPupy+e+ZLkXNgn/7Slog+tAYIz3XX0rzWFTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745478761; c=relaxed/simple;
	bh=lHcMVN6gR3huhb4HD/G2e6A5kirMHkpsrZdynPaOKYU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h8zRW3giHqhrzFIlurxtMQaWpKN/fSJ1xyNDwFU0lgST7IGse6GUjpti2YLw4CTDXI8TDD2lSk+jh/t1+b5n92znQIFJIOBjOoXH2I31r4GgmUJmn/WyRUeLx5QVlXZTu63qjnhonH/1ft/7aDzaWVZxkk8K8kT7eNt1+DulRwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CbCZT+Rd; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3975143A4E;
	Thu, 24 Apr 2025 07:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1745478750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CGBKQP0ozZgi8SSFu8gigr2mI4CbgnOZryTHhEPMZd8=;
	b=CbCZT+Rdeqcs/wB6DjINTQ7gct4Pv/v0ovBacHSLBoggDrnVKL9cYb9y0QYiK/Jj0UjGi5
	j1k6aEKBDyY4DXp+Oeg9rEQjQr7qUYQb0eaPp3ceSnBB4+b9OL8jewRrWX7KCjDKJNqTNt
	+nJnLE02xC7P36rwG0DJJnc4KWUvtlIJydXrw8O8LO4SkT/poQoDS1IyTu6NF7ycoy6u9S
	G6LmCYrXwkSxOPeXGTRukAqfQk9RPkkCNDxwpWu4U2MtB8TQGVjL/zapprBDBiBFOuJUYc
	SZ/z0c+VSTQ2t8Ve0QcaEIir5dFn2k7Y46HPt/RlgW00qkVU14t89GVMXkyWNg==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>,
	Russell King <linux@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Simon Horman <horms@kernel.org>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next v3 0/3] net: stmmac: socfpga: 1000BaseX support and cleanups
Date: Thu, 24 Apr 2025 09:12:19 +0200
Message-ID: <20250424071223.221239-1-maxime.chevallier@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeekkeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepjefhleeihefgffeiffdtffeivdehfeetheekudekgfetffetveffueeujeeitdevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedugedprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtoheplhhinhhugiesrghrmhhli
 hhnuhigrdhorhhgrdhukhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi everyone,

This V3 is simply a re-send of V2, targeting net-next instead of net as
the V2 did by mistake.

No other changes besides a rebase on net-next were made.

This small series sorts-out 1000BaseX support and does a bit of cleanup
for the Lynx conversion.

Patch 1 makes sure that we set the right phy_mode when working in
1000BaseX mode, so that the internal GMII is configured correctly.

Patch 2 removes a check for phy_device upon calling fix_mac_speed(). As
the SGMII adapter may be chained to a Lynx PCS, checking for a
phy_device to be attached to the netdev before enabling the SGMII
adapter doesn't make sense, as we won't have a downstream PHY when using
1000BaseX.

Patch 3 cleans an unused field from the PCS conversion.

Changes in V3:
 - None besides targeting net-next instead of net

Changes in V2: 
 - Added Russell's review tags
 - Reworked patch 2 to check for phy_interface when configuring the
   adapter, as suggested by Russell.

V1: https://lore.kernel.org/netdev/20250422094701.49798-1-maxime.chevallier@bootlin.com/
V2: https://lore.kernel.org/netdev/20250423104646.189648-1-maxime.chevallier@bootlin.com/

Maxime Chevallier (3):
  net: stmmac: socfpga: Enable internal GMII when using 1000BaseX
  net: stmmac: socfpga: Don't check for phy to enable the SGMII adapter
  net: stmmac: socfpga: Remove unused pcs-mdiodev field

 .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c   | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

-- 
2.49.0


