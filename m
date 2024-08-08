Return-Path: <netdev+bounces-116810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EBA94BC6D
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 13:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CE621F21235
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 11:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378AB189F52;
	Thu,  8 Aug 2024 11:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="DDMPwD0p"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AC7189B84
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 11:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723117284; cv=none; b=GLD7DU5FMGH3aDGq7wVjeOWDsHRhPD1H8yW09n1Bn7CI1vu2O5vsmib5twlTGJyvfU7FukCkv8erfmxOMOj+yL1dkg27digaKcv9QERnDgT3n7mGc24e4LY28JKeEUr5zBbSK2yjGcgTBMWl7ljbjR2aUVIfCkddYnlquCBUwXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723117284; c=relaxed/simple;
	bh=2LEUaLbOT7ZdAm1GXhFXaVNCCC0pbae75orn8xKmoi4=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=sVh8vRir0sy5hdBnISwiMETw1l6LVz6tgZCsE/vlj1GfM8amuCJxr4gBmgMZYYiTRlotTYhySoeouJ4BQCrTChVYa5sSR4sMb7IDmlP0+14h02BGgsc0gY0cO7LxKXxb+SziZZ3XVPxKOObHLEOT80DxHpX3oBwBxdAG/jBFhds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=DDMPwD0p; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DKlQtLtglg4i+YYEmCOmlvzkiJpy+v7YCDqoIgQ8uXs=; b=DDMPwD0pbkrN6BR71V0gtdwhfC
	queFJCqZ0fhNAyYRh7nGve/zSCz2Xf4gT6OzyiOYoIBL6y5MuEHDH6KPenpXKx3t6Wd9P3xSu6pXl
	kT4nPy10yUzva5eoS6gxUqOl+6WV6ilmBcRaW+TQu0k2XL+4FuYtOiRxvoYl4MCdomtfZS9NeAtxT
	jqt93zN3wxy0m2gbUpdSRFEx/mVwbCUmeVyHIrJcQv1abQ8GNhFFc78Mp8dsQFI0K7fRf2nokJXd0
	PfnN9ObvLgqcLwB3MoFdwHnSZQG6WwEPKssXvJhc1eUBwxxI+c9vD/z2TxaMULvWoXkvH8VQdNJgK
	5Z4a17Kg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:47404 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1sc1W3-0001By-2M;
	Thu, 08 Aug 2024 12:41:11 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1sc1W9-002Fud-23; Thu, 08 Aug 2024 12:41:17 +0100
In-Reply-To: <ZrSutHAqb6uLfmHh@shell.armlinux.org.uk>
References: <ZrSutHAqb6uLfmHh@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2 1/2] net: mii: constify advertising mask
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1sc1W9-002Fud-23@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 08 Aug 2024 12:41:17 +0100

Constify the advertising mask to linkmode functions that only read from
the advertising mask.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 include/linux/mii.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/mii.h b/include/linux/mii.h
index d5a959ce4877..b8f26d4513c3 100644
--- a/include/linux/mii.h
+++ b/include/linux/mii.h
@@ -140,7 +140,7 @@ static inline u32 ethtool_adv_to_mii_adv_t(u32 ethadv)
  * settings to phy autonegotiation advertisements for the
  * MII_ADVERTISE register.
  */
-static inline u32 linkmode_adv_to_mii_adv_t(unsigned long *advertising)
+static inline u32 linkmode_adv_to_mii_adv_t(const unsigned long *advertising)
 {
 	u32 result = 0;
 
@@ -215,7 +215,8 @@ static inline u32 ethtool_adv_to_mii_ctrl1000_t(u32 ethadv)
  * settings to phy autonegotiation advertisements for the
  * MII_CTRL1000 register when in 1000T mode.
  */
-static inline u32 linkmode_adv_to_mii_ctrl1000_t(unsigned long *advertising)
+static inline u32
+linkmode_adv_to_mii_ctrl1000_t(const unsigned long *advertising)
 {
 	u32 result = 0;
 
@@ -453,7 +454,7 @@ static inline void mii_ctrl1000_mod_linkmode_adv_t(unsigned long *advertising,
  * A small helper function that translates linkmode advertising to LVL
  * pause capabilities.
  */
-static inline u32 linkmode_adv_to_lcl_adv_t(unsigned long *advertising)
+static inline u32 linkmode_adv_to_lcl_adv_t(const unsigned long *advertising)
 {
 	u32 lcl_adv = 0;
 
-- 
2.30.2


