Return-Path: <netdev+bounces-170478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2EAAA48D85
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 01:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8999E3B3834
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 00:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CA7182;
	Fri, 28 Feb 2025 00:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s2H01BOT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70E71C01
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 00:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740703537; cv=none; b=jROwMZWHOh5R2kUe+HU3eWMypNaz9IKxz/gm3kV+G69mvCKjvv4BV00aGksOKJDunSTEzvk2z7GPG+SZLYxR1ld4Xnp2vCYygeSADvYh+G1sEvyjDVd6CMsJlPMsqdlCPOt8SK5h34YfqkrnlKi0c08eH3SbV2tGnxMznu6wXgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740703537; c=relaxed/simple;
	bh=TBo/xlf+r+SL1Q1UP3P5meehSzH07pJ76WqLfiaO5Qk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aGslLKHqRWfNmLkBXJyqp0pTHtLH4sVn/qhoDd9hy95/J2dlPPFx4Bog3TdIBQ5Pl/8WHPo9mU4UQadMCVyoBIGM7uQJKD7yz416cLAQFVIGFDjRJYYc5/Xxo/z4Rhvd78GcorVbTWRgti6dK3cvlqIVIkLbRRr8b7KgjJRr/2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s2H01BOT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D808EC4CEDD;
	Fri, 28 Feb 2025 00:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740703536;
	bh=TBo/xlf+r+SL1Q1UP3P5meehSzH07pJ76WqLfiaO5Qk=;
	h=From:To:Cc:Subject:Date:From;
	b=s2H01BOTpelX6t1lBijqukrNgNN3YljAiV4ugoh/GWMWYnvEAndb+orsmXvL5J1S0
	 UGBodDNqIqDMGF++Cc7WW14R47kfg0z8xxFG8gxVIC32WHo38kBhOynaZ50F7+8bwb
	 wslZI0Jhc5WZeqYKKBiTXAcwcEorJiVcj2cnT6EYYdewg9zndxrnHDDwkDuI7Rez9B
	 QRmPiXqF9izL2rQ4y6aFCTUDvd7OTfJMHYyzdCtfk4Mi/p6NsKq6sxRrHN2VsDqFxn
	 x7QGrY235VRl7fw2zgzC+mapNZSagNCT/MV9n9lvgaTPNhGuH5yrP2SX7EXmn4HUnj
	 0j98gJw3YHrvA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	linus.walleij@linaro.org,
	alsi@bang-olufsen.dk,
	andrew@lunn.ch,
	olteanv@gmail.com
Subject: [PATCH net] net: dsa: rtl8366rb: don't prompt users for LED control
Date: Thu, 27 Feb 2025 16:45:34 -0800
Message-ID: <20250228004534.3428681-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make NET_DSA_REALTEK_RTL8366RB_LEDS a hidden symbol.
It seems very unlikely user would want to intentionally
disable it.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
Sending for net because the symbol was added in net.
Trying to catch it before its released.

CC: linus.walleij@linaro.org
CC: alsi@bang-olufsen.dk
CC: andrew@lunn.ch
CC: olteanv@gmail.com
---
 drivers/net/dsa/realtek/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/realtek/Kconfig b/drivers/net/dsa/realtek/Kconfig
index 10687722d14c..d6eb6713e5f6 100644
--- a/drivers/net/dsa/realtek/Kconfig
+++ b/drivers/net/dsa/realtek/Kconfig
@@ -44,7 +44,7 @@ config NET_DSA_REALTEK_RTL8366RB
 	  Select to enable support for Realtek RTL8366RB.
 
 config NET_DSA_REALTEK_RTL8366RB_LEDS
-	bool "Support RTL8366RB LED control"
+	bool
 	depends on (LEDS_CLASS=y || LEDS_CLASS=NET_DSA_REALTEK_RTL8366RB)
 	depends on NET_DSA_REALTEK_RTL8366RB
 	default NET_DSA_REALTEK_RTL8366RB
-- 
2.48.1


