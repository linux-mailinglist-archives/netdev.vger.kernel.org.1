Return-Path: <netdev+bounces-166361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5A5A35AA2
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 10:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9A5916C5B6
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 09:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A3A256C67;
	Fri, 14 Feb 2025 09:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="g4i/Wqpm"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDD2253B63;
	Fri, 14 Feb 2025 09:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739526263; cv=none; b=GoHSca4mPs8j8+B+t9G5sBylv0lrRNOEZon/Csl1XPGMwtdEciUyF6QF5P/C5pePHeU3kb4/VDC4lWG2OGmfGsZ1+GDolGK4VekaRCI4EgaXrPR66RUO3HNH1QD0a3L8GDZMUfDW+fULMqAr48Z1CNICepvhtpKr1D/95T4IVQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739526263; c=relaxed/simple;
	bh=b7kk20Vy7kIAWPb5mHOyRWhQF+a76Ol5POv8++vJ45I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P3dvmlpalUT3e3mwJ3Ekrqy8J9eykqPa0Ta7cM1frp8mlJGVQeilLVla+W57iS9k/m/j85zDcpQPLb3eR7wOkXPuEllf9AN+T/q+9vqWkzvfEvOtyZAKb4xdOEjja42psduQqM+d79p+o/dPTSQfzcPYIcDKMIhEn5e/dddQnhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=g4i/Wqpm; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E455643288;
	Fri, 14 Feb 2025 09:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739526258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dSMUyOt0IHc5cBv2WcgqbOcbVpTKb7K35N8tucB1ktE=;
	b=g4i/WqpmeYhRhhT12N4NHTn5dp5IX6SGs/vWShcebhLKP/zPPhyt1QPhmTnlRUkj3wDaUQ
	2ui98n/ZPzZNgRkC4voWK0rVUpsFD7IvJb18bp9XCVkiqxzLMQ2aC+PUph41exvLdd6VRz
	f72t+7FuPP5O5gugfx0qJGz4hkhPlHel8OSdwDs6nrzbALocuIjsMut1B6tFLfwVFdGdCf
	ZduNcQx94Xbrj+kA7N5bOtrMbKXWcuumIWqXveyX7Jz/yVwBddCrjW9RkT2HpYO5szitwz
	B9cmYj1Ol1+D6o3Vs3N3EKoVfaf9joPDvvfgiRhHZ1y37JUDcbb+YtNASP4iow==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH net-next] Documentation: net: phy: Elaborate on RGMII delay handling
Date: Fri, 14 Feb 2025 10:44:13 +0100
Message-ID: <20250214094414.1418174-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegleefvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeejhfelieehgfffiefftdffiedvheefteehkedukefgteffteevffeuueejiedtveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgdphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudehpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhrtghpt
 hhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqughotgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhg
X-GND-Sasl: maxime.chevallier@bootlin.com

As discussed here [1], the RGMII delays may be inserted by either the
MAC, the PHY or the Board through the PCB traces.

Elaborate more on what the firmware properties represent, and what is
the expected role of MAC and PHY in delay insertion, with a preference
on PHY-side delay insertion.

[1] : https://lore.kernel.org/netdev/c83f0193-ce24-4a3e-87d1-f52587e13ca4@lunn.ch/

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 Documentation/networking/phy.rst | 36 +++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/Documentation/networking/phy.rst b/Documentation/networking/phy.rst
index f64641417c54..c6b8fa611548 100644
--- a/Documentation/networking/phy.rst
+++ b/Documentation/networking/phy.rst
@@ -73,8 +73,16 @@ The Reduced Gigabit Medium Independent Interface (RGMII) is a 12-pin
 electrical signal interface using a synchronous 125Mhz clock signal and several
 data lines. Due to this design decision, a 1.5ns to 2ns delay must be added
 between the clock line (RXC or TXC) and the data lines to let the PHY (clock
-sink) have a large enough setup and hold time to sample the data lines correctly. The
-PHY library offers different types of PHY_INTERFACE_MODE_RGMII* values to let
+sink) have a large enough setup and hold time to sample the data lines correctly.
+
+The device tree property phy-mode describes the hardware. When used
+with RGMII, its value indicates if the hardware, i.e. the PCB,
+provides the 2ns delay required for RGMII. A phy-mode of 'rgmii'
+indicates the PCB is adding the 2ns delay. For other values, the
+MAC/PHY pair must insert the needed 2ns delay, with the strong
+preference the PHY adds the delay.
+
+The PHY library offers different types of PHY_INTERFACE_MODE_RGMII* values to let
 the PHY driver and optionally the MAC driver, implement the required delay. The
 values of phy_interface_t must be understood from the perspective of the PHY
 device itself, leading to the following:
@@ -106,14 +114,22 @@ Whenever possible, use the PHY side RGMII delay for these reasons:
   configure correctly a specified delay enables more designs with similar delay
   requirements to be operated correctly
 
-For cases where the PHY is not capable of providing this delay, but the
-Ethernet MAC driver is capable of doing so, the correct phy_interface_t value
-should be PHY_INTERFACE_MODE_RGMII, and the Ethernet MAC driver should be
-configured correctly in order to provide the required transmit and/or receive
-side delay from the perspective of the PHY device. Conversely, if the Ethernet
-MAC driver looks at the phy_interface_t value, for any other mode but
-PHY_INTERFACE_MODE_RGMII, it should make sure that the MAC-level delays are
-disabled.
+The MAC driver may fine tune the delays. This can be configured
+based on firmware "rx-internal-delay-ps" and "tx-internal-delay-ps"
+properties. These values are expected to be small, not the full 2ns
+delay.
+
+A MAC driver inserting these fine tuning delays should always do so
+when these properties are present and non-zero, regardless of the
+RGMII mode specified.
+
+For cases where the PHY is not capable of providing the 2ns delay,
+the MAC must provide it, if the phy-mode indicates the PCB is not
+providing the delays. The MAC driver must adjust the
+PHY_INTERFACE_MODE_RGMII_* mode it passes to the connected PHY
+device (through :c:func:`phy_connect <phy_connect>` for example) to
+account for MAC-side delay insertion, so that the PHY device
+does not add additional delays.
 
 In case neither the Ethernet MAC, nor the PHY are capable of providing the
 required delays, as defined per the RGMII standard, several options may be
-- 
2.48.1


