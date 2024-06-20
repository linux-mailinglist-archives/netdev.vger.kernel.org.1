Return-Path: <netdev+bounces-105191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 508FC9100ED
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 11:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B855AB20D51
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 09:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06E91A4F1F;
	Thu, 20 Jun 2024 09:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZdQzlxBY"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CE250288;
	Thu, 20 Jun 2024 09:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718877493; cv=none; b=GmO+OEnBFfpoGsQy7FDsSDWx/CLBjmq7TyGBdlXtqKSWLJur6PAOn3Xr4pee1xbyHZxxPyh+PdUD2Wufg5BcGff2qr6DsMbCIPSOCbK6pGMJ0RAYA0fRdkeiQGbDYJ4nbc1hbGS3NHkbL2YOf0O68tlV+1EvG6qM7PiOaCHcP2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718877493; c=relaxed/simple;
	bh=/5H0W6bpzr/xWhXo2uhsjMtRPyGadwTtdkaBlFBjGAE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hvfuepSj8Fz1rpSn/n1J3jOrO0uTmFtCoDase3+nCw2czbCag/RKNoEPGZxKdnGxM0uW+l0dmS6bteaIHwUrPcg5L5WOEtN96mYy9wUS56PpXEcz771gKLD6BjtCTrkxKhHeF+N4aAPOc2FI8lvyBabi5taaDrxSpdECzZMQZmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZdQzlxBY; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B17D14000F;
	Thu, 20 Jun 2024 09:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718877483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4TKdOT/QJ+8CsEXFGrsw+K9KP2TGcydZi7LEpJK+X3E=;
	b=ZdQzlxBYx8G+CVIeNAuIX/YEYMZhhsaSCExXfuLZ/X72ldsAX/7+bj00Y7zCvUceOGHtc2
	wcZ1064qqwTJw/IhVuXUuKPpyhcKlCjSiUV2cPYcjqcvP0BJkYu6fkoSVKYl00z61QMU7R
	5Vto2f1x3bHrBzMy6hQX/QByxRQDPRGYc4oAeo2ikWmfFPoDkqgc3bSTz9Hkz1u7Y8En3G
	ziYU8VaWCiMMECi+yTsSm+gPP0z71hrgFkxpwJ5o+HaLb7rwrSKHYdI8gFyzuUxuQWm6Sc
	eHRrstwFEf6xFzWRHSxjb/5hv1p+34miSnRjsXab8+WkI21gqkJdBEvSROpX+Q==
From: Kory Maincent <kory.maincent@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>,
	"Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel test robot <lkp@intel.com>,
	thomas.petazzoni@bootlin.com,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net] net: pse-pd: Kconfig: Fix missing firmware loader config select
Date: Thu, 20 Jun 2024 11:57:50 +0200
Message-Id: <20240620095751.1911278-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: kory.maincent@bootlin.com

Selecting FW_UPLOAD is not sufficient as it allows the firmware loader
API to be built as a module alongside the pd692x0 driver built as builtin.
Add select FW_LOADER to fix this issue.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202406200632.hSChnX0g-lkp@intel.com/
Fixes: 9a9938451890 ("net: pse-pd: Add PD692x0 PSE controller driver")
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 drivers/net/pse-pd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/pse-pd/Kconfig b/drivers/net/pse-pd/Kconfig
index 577ea904b3d9..7fab916a7f46 100644
--- a/drivers/net/pse-pd/Kconfig
+++ b/drivers/net/pse-pd/Kconfig
@@ -23,6 +23,7 @@ config PSE_REGULATOR
 config PSE_PD692X0
 	tristate "PD692X0 PSE controller"
 	depends on I2C
+	select FW_LOADER
 	select FW_UPLOAD
 	help
 	  This module provides support for PD692x0 regulator based Ethernet
-- 
2.34.1


