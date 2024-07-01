Return-Path: <netdev+bounces-108044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2887091DA95
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 10:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57F6C1C2182D
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 08:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7328913C908;
	Mon,  1 Jul 2024 08:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="O2WA0yoj"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97F6127B57;
	Mon,  1 Jul 2024 08:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719823850; cv=none; b=f34uUmcW8wVLZLBMFDnGDKDZ82C+bVRNLCJcxQvWIjIK+gRrBlOEN+lwhu9ToUtJkvX+Ki74kNoQVip4eZPyEbQMD2Szlp5l88MoR0si1b1N+rOah3KittiLAgNNspo/daLMfIX1xfAHFSuPr2Oq3W+6sV8l0CBQMU3YeRnqsxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719823850; c=relaxed/simple;
	bh=NpDLeoWlfO75xR5lZbpySzJDKMvQSBb/ujqrRwpiHN0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XGnw9CiCJW1x+dKZU1IdhJtJVGlfjbn/r65Ocyrp3Ps7lnmViO3RVw00F04V/se3OyQhnTd4bQYiksHJjqgoLLllSL7YQZhVb7VaU8aCsI+/6Zh/3AhwqK7iuSzwpHZ0JzS22wKSI6FDqGLjSHK7XW3trcql98/URwrh4vWVvbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=O2WA0yoj; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1FE68C0005;
	Mon,  1 Jul 2024 08:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719823844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RTR8H7b1tl9eAKDR+Ps9ZqecKHhEcbAUOFZfLXxFeyo=;
	b=O2WA0yojVx3gRuuWY0lO6f9o943QQ5LaJuaTzA1sWGFhsyQRorPD0spZv+xVilAj2+UDnT
	YYdXrlmtCNqbYVqWuzEjLi/yFoxdQ4ABqzw7OgnH0HEkFhzZZFqclMfhWqxQuIeOSl7Fbz
	kRB+nxe22S3/JCm7Qk5/Di3Ce0m92sAyCIywlkUwgM4fvQz7tR7fy86POx1VJPC4gxDVNo
	tdiiYugGoh0tPgOldlkx8MdOiXCGR3X26Fh3KpAMn2YLBd2iPKFQsNT9qzhkhCKIlEi0pN
	Q0NRz7Kw8R/QvxKd8V2dBWj+AvzBhnTAtReazzC6Lzlt5yOiBU+EhA8SvMQFWg==
From: Romain Gantois <romain.gantois@bootlin.com>
Subject: [PATCH net-next 0/6] net: phy: dp83869: Add support for downstream
 SFP cages
Date: Mon, 01 Jul 2024 10:51:02 +0200
Message-Id: <20240701-b4-dp83869-sfp-v1-0-a71d6d0ad5f8@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPdtgmYC/x3MTQqAIBBA4avErBswFZm6SrToZ6zZmGhEIN09a
 fkt3iuQOQlnGJoCiW/JcoaKrm1gPeawM8pWDVppq5wmXCxukQy5HrOPSDz3bjHeGlqhRjGxl+c
 fjhD4wsDPBdP7fv1VkKpqAAAA
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Romain Gantois <romain.gantois@bootlin.com>
X-Mailer: b4 0.14.0
X-GND-Sasl: romain.gantois@bootlin.com

Hello everyone,

This is version one of my series that adds support for downstream SFP cages
to the DP83869 PHY driver.

The DP83869HM PHY transceiver supports a variety of different conversion
modes, including RGMII to SGMII and RGMII to 1000Base-X. With these last
two modes, the DP83869 can act as a bridge between an Ethernet MAC and an SFP
cage in one of the following two configurations:

RGMII-SGMII bridge:

+-------+       +------------+        +-----------+--------------------+
|       |RGMII  |            | SGMII  |                                |
|  MAC  |<----->| DP83869HM  |<------>| SFP cage with SGMII SFP module |
|       |       |            |        |                                |
+-------+       +------------+        +-----------+--------------------+

RGMII-1000Base-X converter:

+-------+        +------------+1000Base-X+-----------+--------------------+
|       |RGMII   |            |          |                                |
|  MAC  |<------>| DP83869HM  |<-------->| SFP cage with DAC/fiber module |
|       |        |            |          |                                |
+-------+        +------------+          +-----------+--------------------+

The RGMII-SGMII and RGMII-1000Base-X are currently supported in the PHY
driver, but there are some flaws that prevent proper operation with
downstream SFP modules. Additionally, the sfp_upstream_ops callbacks which
are needed to interact with the downstream SFP modules are not yet
implemented.

This series adds full support for both SGMII and DAC SFP modules by
implementing these sfp_upstream_ops callbacks and fixing relevant issues in
the existing DP83869 operational modes.

Best Regards,

Romain

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
Romain Gantois (6):
      net: phy: dp83869: Disable autonegotiation in RGMII/1000Base-X mode
      net: phy: dp83869: Perform software restart after configuring op mode
      net: phy: dp83869: Ensure that the FORCE_LINK_GOOD bit is cleared
      net: phy: dp83869: Support 1000Base-X and 100Base-FX SFP modules
      net: phy: dp83869: Support SGMII SFP modules
      net: phy: dp83869: Fix link up reporting in SGMII bridge mode

 drivers/net/phy/dp83869.c | 269 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 233 insertions(+), 36 deletions(-)
---
base-commit: 30972a4ea092bacb9784fe251327571be6a99f9c
change-id: 20240628-b4-dp83869-sfp-8ea96b3f438c

Best regards,
-- 
Romain Gantois <romain.gantois@bootlin.com>


