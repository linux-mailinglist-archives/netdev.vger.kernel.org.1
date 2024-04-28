Return-Path: <netdev+bounces-92010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E68D8B4C47
	for <lists+netdev@lfdr.de>; Sun, 28 Apr 2024 16:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FBE61C20CF4
	for <lists+netdev@lfdr.de>; Sun, 28 Apr 2024 14:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70CC5D732;
	Sun, 28 Apr 2024 14:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="MPbc/J/z"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE424A01
	for <netdev@vger.kernel.org>; Sun, 28 Apr 2024 14:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714315879; cv=none; b=RKoLYENzDH/4kYYFA4DfCcazfCmrBGPeOqZYk5HsmChanReC1g3ijW5ra4EWDcKzb+xtPkjnxwq0cgM8lQ/1+V1KrZVI4B7FqJUw/OaRD9vB8sGblNtHgTQ1FPzCbm16HZJXMd46FDGP3wN1fXTKfg6VFT/kJJ4GbIYx80Mr1g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714315879; c=relaxed/simple;
	bh=FCJXitBn4PWTLT+b/MyQePOnZDxsB62gNWgagvvn4VI=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=gA+aWBi018xjjcR/NYC0V0J7t5Pm22wYTTPfFVYcmHgZlrQFb74JaBaK4WuM48g8kwxVWxgBELt3sOGVFYmJiffAjXIxgPzsi6y/TDFhOZ5RTAmimL7/sdVIl1prniZ3D3mDUjSCj5yHyvqp66GAAEKaM/0hB7jZhJoUZzIB9Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=MPbc/J/z; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=QrDZGah/Y1vzOmCz3w453gWXAImNf2omFABCMv89MV8=; b=MPbc/J/zasjCwe2LkkVSXzuwu/
	17sFSoN/4yx9W8/4MaXIlkFUCQSwbgTQmoxRfL3DljLn+VDff/mx6e6emVlxtu/FcoUdpHD4mgs5B
	Hl41rhlVAkCl5vUTyAqayNmsDKJdCRYu1QVpEo9/toafw99z8EfeG4UAjP3tQC0vX8SCVufxsV3db
	q4aIfa8sB0TA7rBcyilSN6eIcqFcv116UkzqY0MEWzZDkZtoysQHR+XafYItyoJoQM1TOlsBLoJ/T
	oyJAGLcICmGJOlxl/A31ZkokMXzLoS/69SJ0NnV2511H6iVoR4fT0UswSXhGvmyGDg9fnF1a7VaC4
	bMhL6HVg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:49228 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1s15ry-0002Fn-31;
	Sun, 28 Apr 2024 15:51:11 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1s15s0-00AHyq-8E; Sun, 28 Apr 2024 15:51:12 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next] net: sfp-bus: constify link_modes to
 sfp_select_interface()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1s15s0-00AHyq-8E@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Sun, 28 Apr 2024 15:51:12 +0100

sfp_select_interface() does not modify its link_modes argument, so
make this a const pointer.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/sfp-bus.c | 2 +-
 include/linux/sfp.h       | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/sfp-bus.c b/drivers/net/phy/sfp-bus.c
index c6e3baf00f23..37c85f1e6534 100644
--- a/drivers/net/phy/sfp-bus.c
+++ b/drivers/net/phy/sfp-bus.c
@@ -355,7 +355,7 @@ EXPORT_SYMBOL_GPL(sfp_parse_support);
  * modes mask.
  */
 phy_interface_t sfp_select_interface(struct sfp_bus *bus,
-				     unsigned long *link_modes)
+				     const unsigned long *link_modes)
 {
 	if (phylink_test(link_modes, 25000baseCR_Full) ||
 	    phylink_test(link_modes, 25000baseKR_Full) ||
diff --git a/include/linux/sfp.h b/include/linux/sfp.h
index 55c0ab17c9e2..5ebc57f78c95 100644
--- a/include/linux/sfp.h
+++ b/include/linux/sfp.h
@@ -554,7 +554,7 @@ bool sfp_may_have_phy(struct sfp_bus *bus, const struct sfp_eeprom_id *id);
 void sfp_parse_support(struct sfp_bus *bus, const struct sfp_eeprom_id *id,
 		       unsigned long *support, unsigned long *interfaces);
 phy_interface_t sfp_select_interface(struct sfp_bus *bus,
-				     unsigned long *link_modes);
+				     const unsigned long *link_modes);
 
 int sfp_get_module_info(struct sfp_bus *bus, struct ethtool_modinfo *modinfo);
 int sfp_get_module_eeprom(struct sfp_bus *bus, struct ethtool_eeprom *ee,
@@ -593,7 +593,7 @@ static inline void sfp_parse_support(struct sfp_bus *bus,
 }
 
 static inline phy_interface_t sfp_select_interface(struct sfp_bus *bus,
-						   unsigned long *link_modes)
+						const unsigned long *link_modes)
 {
 	return PHY_INTERFACE_MODE_NA;
 }
-- 
2.30.2


