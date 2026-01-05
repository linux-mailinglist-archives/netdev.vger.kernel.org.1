Return-Path: <netdev+bounces-247132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 976ADCF4D12
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 17:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FF693060A60
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 16:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4616D33F8A2;
	Mon,  5 Jan 2026 16:39:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6AC2D8DD9;
	Mon,  5 Jan 2026 16:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767631178; cv=none; b=IzMAo04ZRjFWg3Thwmx/DWPy9dMx5vEhjx6B+AmXRzb2T/R5KfTJS+Lr0+RzWcCz6VoxyUGN542Y6gIOAyj1kZxN9qRDiljs0tW1Ubo0NQD/4b3WW9DAJu4XqjWNLBbIs0ea1aQDlZD2D0AQTEbt25yQS81uqTz3FPVQOAJIVE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767631178; c=relaxed/simple;
	bh=iyNTJho95yZntWYL1oKISWYbwiehceitYDeeeo3NiOQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4szUYImhgZalxX4LeE8s7Cz07o2jqDGek6hO7ejSbqqLDlz70zLyi/msjSkULMWGoHxmRFdsq7uiQZLnqXIbI4zLi/E5NgYoemQAs7Dy+aNywKK4k8/V35qXf4VaonXBjJsjoWqpsFhylP8Y1xxRfz45QsyLfOvQ2lc/LsmlDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vcnc8-000000000zu-3lqw;
	Mon, 05 Jan 2026 16:39:28 +0000
Date: Mon, 5 Jan 2026 16:39:26 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Michael Klein <michael@fossekall.de>,
	Daniel Golle <daniel@makrotopia.org>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Bevan Weiss <bevan.weiss@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 5/5] net: phy: realtek: get rid of magic number
 in rtlgen_read_status()
Message-ID: <a53d4577335fdda4d363db9bc4bf614fd3a56c9b.1767630451.git.daniel@makrotopia.org>
References: <cover.1767630451.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1767630451.git.daniel@makrotopia.org>

Use newly introduced helper macros RTL822X_VND2_TO_PAGE and
RTL822X_VND2_TO_PAGE_REG to access RTL_VEND2_PHYSR register over Clause-22
paged access instead of using magic numbers.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2: no changes

 drivers/net/phy/realtek/realtek_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index d1c7935a13acc..eb5b540ada0e5 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -1154,7 +1154,8 @@ static int rtlgen_read_status(struct phy_device *phydev)
 	if (!phydev->link)
 		return 0;
 
-	val = phy_read_paged(phydev, 0xa43, 0x12);
+	val = phy_read_paged(phydev, RTL822X_VND2_TO_PAGE(RTL_VND2_PHYSR),
+			     RTL822X_VND2_TO_PAGE_REG(RTL_VND2_PHYSR));
 	if (val < 0)
 		return val;
 
-- 
2.52.0

