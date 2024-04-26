Return-Path: <netdev+bounces-91759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 641768B3C6B
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 18:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16F2C1F219EA
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 16:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1056114B09E;
	Fri, 26 Apr 2024 16:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="0KGyUGRY"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7201474A0
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 16:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714147687; cv=none; b=gYVyWCEaPGwPahcdZTv1WOPtwkiGrj7IZat/Ou6aYaVn+NhUVa4eyYGJ8v0jSNSIJYKJLgvlNQAHJXRuZghuKYuzV2qhhmqq9g9phxaArXaa3EP80wXkQBABUJqnummn4e6RAELcqlkE9QzbuS2uyb4Z3zNhK4t3NejEazwdAcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714147687; c=relaxed/simple;
	bh=XiPwtNLmDVvOTa0KrgEClx2QJWpEAwEm/Qqpkr7WZHg=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=McmCb3bItY09Xi6gpBS0IfGMMbI08xhlgwEoioQvWXnhahMIoGpYZuNPGiGhbxjCx/7JWXvPpH5VzmojfKqBvYo8Wz2/RN8+ZaRlyVavAcizYwJ4s/3V5lDvmLLTtiv3CT2mIbwSGMwWYRwQQQSjBIgNHWUcmJPdf9a7BhYXUAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=0KGyUGRY; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7wS3u64mzk8R/EdSUQvc1bMvTrpSHU/1ojepj2hvF/E=; b=0KGyUGRYC8WXTnO/IC/sMpjTOO
	jR+oneN8d65IMvFqHyU/v8NLDRZWnxBHvBtX7pUOhbruCaWtt3W2eU9ub0mEELQdBOy/0kp6seD1I
	TufPRE8C6RNRO1HhJEP0jQ7ya6QTH9e1Li/06vdrkrnP3lyFBD0YDBW7I7Nygg0P+4knmbbDM3Pp3
	y4a7cPdNVlyb2Wuiaa77Bfy7Mn4271Xgy/zNlUafuZ5pzsdN/J9evyQCkKN3ABx20U6MBS/XdO2/x
	pOzMKEcVTgMXeWTMLPlZkKGEtBcAyFbG21/Sw1nsdCjFyPW+z31rW7XXppzEBAg9YefbjYmSs3D/r
	StshgWDA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:42106 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1s0O7B-0000Tp-0L;
	Fri, 26 Apr 2024 17:07:57 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1s0O7C-009gpk-Dh; Fri, 26 Apr 2024 17:07:58 +0100
In-Reply-To: <ZivP/R1IwKEPb5T6@shell.armlinux.org.uk>
References: <ZivP/R1IwKEPb5T6@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	 Florian Fainelli <f.fainelli@gmail.com>,
	 Vladimir Oltean <olteanv@gmail.com>,
	 Woojung Huh <woojung.huh@microchip.com>
Cc: UNGLinuxDriver@microchip.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next 1/4] net: dsa: ksz_common: remove phylink_mac_config
 from ksz_dev_ops
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1s0O7C-009gpk-Dh@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 26 Apr 2024 17:07:58 +0100

The phylink_mac_config function pointer member of struct ksz_dev_ops is
never initialised, so let's remove it to simplify the code.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/microchip/ksz_common.c | 3 ---
 drivers/net/dsa/microchip/ksz_common.h | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 2b510f150dd8..f4469ee24239 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -3087,9 +3087,6 @@ static void ksz_phylink_mac_config(struct dsa_switch *ds, int port,
 
 	ksz_set_xmii(dev, port, state->interface);
 
-	if (dev->dev_ops->phylink_mac_config)
-		dev->dev_ops->phylink_mac_config(dev, port, mode, state);
-
 	if (dev->dev_ops->setup_rgmii_delay)
 		dev->dev_ops->setup_rgmii_delay(dev, port);
 }
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 40c11b0d6b62..c88ab5e89ecc 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -349,9 +349,6 @@ struct ksz_dev_ops {
 	int (*change_mtu)(struct ksz_device *dev, int port, int mtu);
 	void (*freeze_mib)(struct ksz_device *dev, int port, bool freeze);
 	void (*port_init_cnt)(struct ksz_device *dev, int port);
-	void (*phylink_mac_config)(struct ksz_device *dev, int port,
-				   unsigned int mode,
-				   const struct phylink_link_state *state);
 	void (*phylink_mac_link_up)(struct ksz_device *dev, int port,
 				    unsigned int mode,
 				    phy_interface_t interface,
-- 
2.30.2


