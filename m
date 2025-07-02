Return-Path: <netdev+bounces-203254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F33AF106C
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 11:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FD634A55CF
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 09:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B068725BEE6;
	Wed,  2 Jul 2025 09:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="StgesMK0"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADFB2580F1
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 09:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751449517; cv=none; b=pth07E4y9jrb7QMkpwx0+q8fRklqM5wG1awuHMBQXiH8Cca3cOQiVrhilbQ6M70UWA0WVds9xjzrhrPiGM/zcsrlYTRC1Dx368Kwst7q7/yUzkGNURb5wxJc4/t2FgWAahG57/1ygAZGbdPIJ5gisYP74Hj9uNmNT24xcJ5mgO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751449517; c=relaxed/simple;
	bh=HwO90/2G7hf1LBjtiLTrhBg1aS8dSR142vRMwHqvC+c=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=DDd6m5ldvxzKyQX5BF7d0qiG4X97x+X6aQBVPAkZw+NWoRgIrgwXuVRVELQnrBkUYTkQ5m8GNhiWVYkC3+PV2Cg0wnQL7H5440MaSwvv+mV9YhqBp/uD0hXKhBEKZ38QXqFmIBRblyhsamtjLvo5E9PvrO1rcmU4saFhrFE44ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=StgesMK0; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wtqxJxg8h5eXR2GcgUSD1Ag3pB7dBgrx3s1AVMQ98gM=; b=StgesMK0JzWOzbcEXU1+DkFHUu
	rkMArHRKxea8epYOCxW1vJlCmZ5UO/s+1JwsbnOReq05FxX/IqfnRaN3gIDzByy91Dk9CdeKVP95e
	3d4oYbllBkDXHsUJVaouCvi0ZB7yDh0AIyn0gJkJnB2qLzaIGVKyo89279cYuIRyqXl8wh63h02wJ
	zl2Yg+97sgyzoRcVdNd0faOOvod6nyNFTn2RU3T7ynB6111Yqcodd54W8CSlKSETOIakQZoauV4KF
	ISKyHfsp+D9jHmjeuFtFFJVnPY0QYIvHm+eHBz4t/rVCsf6JaAE5AJyUoEAralZHnUWQ5f0Qjx215
	uAJiSvGA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:52898 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uWu1f-0007OQ-0K;
	Wed, 02 Jul 2025 10:45:11 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uWu0z-005KXi-EM; Wed, 02 Jul 2025 10:44:29 +0100
In-Reply-To: <aGT_hoBELDysGbrp@shell.armlinux.org.uk>
References: <aGT_hoBELDysGbrp@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 2/3] net: phylink: clear SFP interfaces when not in
 use
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uWu0z-005KXi-EM@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 02 Jul 2025 10:44:29 +0100

Clear the SFP interfaces bitmap when we're not using it - in other
words, when a module is unplugged, or we're using a PHY on the
module.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 6420e76f8ab1..c92a878ab717 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -3536,6 +3536,8 @@ static int phylink_sfp_config_phy(struct phylink *pl, struct phy_device *phy)
 	struct phylink_link_state config;
 	int ret;
 
+	/* We're not using pl->sfp_interfaces, so clear it. */
+	phy_interface_zero(pl->sfp_interfaces);
 	linkmode_copy(support, phy->supported);
 
 	memset(&config, 0, sizeof(config));
@@ -3673,6 +3675,13 @@ static int phylink_sfp_module_insert(void *upstream,
 	return phylink_sfp_config_optical(pl);
 }
 
+static void phylink_sfp_module_remove(void *upstream)
+{
+	struct phylink *pl = upstream;
+
+	phy_interface_zero(pl->sfp_interfaces);
+}
+
 static int phylink_sfp_module_start(void *upstream)
 {
 	struct phylink *pl = upstream;
@@ -3757,6 +3766,7 @@ static const struct sfp_upstream_ops sfp_phylink_ops = {
 	.attach = phylink_sfp_attach,
 	.detach = phylink_sfp_detach,
 	.module_insert = phylink_sfp_module_insert,
+	.module_remove = phylink_sfp_module_remove,
 	.module_start = phylink_sfp_module_start,
 	.module_stop = phylink_sfp_module_stop,
 	.link_up = phylink_sfp_link_up,
-- 
2.30.2


