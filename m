Return-Path: <netdev+bounces-96350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 791268C5606
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 14:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20009B20F88
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 12:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A5946B9F;
	Tue, 14 May 2024 12:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="hVc74mLU"
X-Original-To: netdev@vger.kernel.org
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A164122C
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 12:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715689576; cv=none; b=fDwH0qKk35VfC6R3m9xrfxMlumEfcP5hGqII1FHQ4nXTSSbIGmCfmmYs67rwxxGreEYj/liqd5mVelkV6ghaqQtaaJCfzYUqG+7588IT3U802heXaL1naclVkZXeGV4dFvMMkBZ1e19LK05WPSECzrt704ZBRdEWQOIVHQfNxNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715689576; c=relaxed/simple;
	bh=RQ1Y4YjjM5v4xsdRx8aubNJjFbH5C6J5KXTySs4ORFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BgJ8rRySr+9xJ9rsf2RNB3zKx2ZdnbETxOz2D25IYJuThlZEf/jkarMI+qRjLztIqUHDBV2vqE0wOAjYz8ddIN3y3X5EbdMUCVoQo44Ccp11XpFi0mh0EUwignyVrV0sCY/sDppx6V0Mx57WgCNkruVErEMhZMPo0ClL3RLmhBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=hVc74mLU; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20240514122609ae02d01fb82bc76662
        for <netdev@vger.kernel.org>;
        Tue, 14 May 2024 14:26:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=G1UZ6US877BIUB1UTqIAxhVqVfhaPq2imtMQ2xuHvmw=;
 b=hVc74mLUoCrOxCtA7CP0VAntF0s9Ud118p0Xp9CvCXwtygIiHEI1EfLy2N7Sdr5sbhnuSw
 FhoJdnfd5hLU1tqj0Kk8rliMTwfSfREsk8iPP2QN2Fdz8o3AlicHyIyXha6x9zPASt+rarIE
 Ob38uGBR/6aBR9uGkgvLE4bRKt3Bg=;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: netdev@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH] net: dsa: lan9303: imply SMSC_PHY
Date: Tue, 14 May 2024 14:26:03 +0200
Message-ID: <20240514122605.662767-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

Both LAN9303 and LAN9354 have internal PHYs on both external ports.
Therefore a configuration without SMSC PHY support is non-practical at
least and leads to:

LAN9303_MDIO 8000f00.mdio:00: Found LAN9303 rev. 1
mdio_bus 8000f00.mdio:00: deferred probe pending: (reason unknown)

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 drivers/net/dsa/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
index 3092b391031a8..8508b5145bc14 100644
--- a/drivers/net/dsa/Kconfig
+++ b/drivers/net/dsa/Kconfig
@@ -102,6 +102,7 @@ config NET_DSA_SMSC_LAN9303
 	tristate
 	select NET_DSA_TAG_LAN9303
 	select REGMAP
+	imply SMSC_PHY
 	help
 	  This enables support for the Microchip LAN9303/LAN9354 3 port ethernet
 	  switch chips.
-- 
2.44.0


