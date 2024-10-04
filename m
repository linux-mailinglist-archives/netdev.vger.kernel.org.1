Return-Path: <netdev+bounces-132144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 098BE9908DE
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 18:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCD5728495E
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 16:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144111C877A;
	Fri,  4 Oct 2024 16:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QNpaTKOz"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8321C75EF;
	Fri,  4 Oct 2024 16:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728058579; cv=none; b=D3M2GWV4Il47QtdXXE6tfu6VquvOu1Dhwrtqll2245JZm4ucPb8HNaediliETSLsQQ37+G5sZY2hKt8k6u3/SY8rThw0hD3YWA3ElUJE+VAqH5uBCn2FJej+esflmk1JZA4iNSYEhEEhORvc9b4egkLfjVTt9i7ii1MdvRlX6vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728058579; c=relaxed/simple;
	bh=/t/i/v7Y4wFFXBA5yU25ZUKM1qTMIM422hMgQyatXM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qWrlSmsEq3PPuB1L3YnPiCxZXs1A06lfmLEo19QvMaPTZjSO/WfwgXYlhHLD0PhSnTJSIvpcrcJkt7uPEcWuBVLCGOCc2V3HINdpsL0L5ezsH5qqEkGRClB06m1tU5bMF0qWTP68sB3HmIw+Www30Ndzk3IQtXDexpbNnFRWCzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QNpaTKOz; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BE61520008;
	Fri,  4 Oct 2024 16:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728058569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l94MYM9aLPoFsocgRBRMqaai5hzItvu6ewJPpEKL7nk=;
	b=QNpaTKOzl/37uWbR/6MeQsbwPIWLvqndTwQ++ICUhcct7Pw1conr08/X46fycgOrW/c1EZ
	hBlr1Xa3n6BrNPtFJmHfYxRiJAd+DikF4FdXXTcqPuegnspwpahzwtXXSXlf4P4p2Xpfn4
	zVZmet0cMxUZUdTNi7Ui6nO5s96JM5q7WJczt8PMOvDgn7DrLbrbQvcm/MrzRh582Y1qz1
	Be2czEbCDSI6fVAOBM9/AfmTtJl8K/9ApxRts9+uTctBFg62jtF5B3GMiE5+7W0SmVTWx7
	B9Ws1iFtsoWLoStLhjPIfvlJzGKJ91qnSTkwYgx3XWDN0RYijr4FrdhWIkn9DA==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH net-next v2 4/9] net: phy: lxt: Mark LXT973 PHYs as having a broken isolate mode
Date: Fri,  4 Oct 2024 18:15:54 +0200
Message-ID: <20241004161601.2932901-5-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241004161601.2932901-1-maxime.chevallier@bootlin.com>
References: <20241004161601.2932901-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Testing showed that PHYs from the LXT973 family have a non-working
isolate mode, where the MII lines aren't set in high-impedance as would
be expected. Prevent isolating these PHYs.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V2 : Use callback instead of flag

 drivers/net/phy/lxt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/phy/lxt.c b/drivers/net/phy/lxt.c
index e3bf827b7959..45f92451bee8 100644
--- a/drivers/net/phy/lxt.c
+++ b/drivers/net/phy/lxt.c
@@ -334,6 +334,7 @@ static struct phy_driver lxt97x_driver[] = {
 	.read_status	= lxt973a2_read_status,
 	.suspend	= genphy_suspend,
 	.resume		= genphy_resume,
+	.can_isolate	= genphy_no_isolate,
 }, {
 	.phy_id		= 0x00137a10,
 	.name		= "LXT973",
@@ -344,6 +345,7 @@ static struct phy_driver lxt97x_driver[] = {
 	.config_aneg	= lxt973_config_aneg,
 	.suspend	= genphy_suspend,
 	.resume		= genphy_resume,
+	.can_isolate	= genphy_no_isolate,
 } };
 
 module_phy_driver(lxt97x_driver);
-- 
2.46.1


