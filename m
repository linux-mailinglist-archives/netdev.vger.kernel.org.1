Return-Path: <netdev+bounces-179484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB77AA7D0EF
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 00:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEEDD169554
	for <lists+netdev@lfdr.de>; Sun,  6 Apr 2025 22:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB936221D85;
	Sun,  6 Apr 2025 22:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhIP/ZSF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3A4221568;
	Sun,  6 Apr 2025 22:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743977705; cv=none; b=aCQuzXEdrVV05JOuVw9s9AbJ1I6A198EkgZ9aYfK6D23cL+OF18BzHChJcLX9d83d1eKjm/LdgTWsAY0w2RGKUqS0CkB36rjJUPOVM8Eqn56DJI9e+Jk6U31GGjWuAsoSGTUGQk/rcPKtIFdK2VX2ie6J6TVP+piONSQ6rKl9pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743977705; c=relaxed/simple;
	bh=Y8x3/yRRsmo8SrLKlZluvtpYPWv5nKHX7S2lo5YHfgc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KeqKdPmquISArmvyfeaVXTh9jnIqaCjfDslP9TN1z5/LFBWGxJ8a9EIU1BmOqzUTMuUgWeN2rv1LLqtN0xh3J4RIWvXPOT9Vcd81IomsyOMqgDTHYi5AJDBb3PfIZRNFOAOBAUbnF8QMx0queGiQZnkbHmZqaz+wnptJs825Qd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PhIP/ZSF; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43d2d952eb1so24972655e9.1;
        Sun, 06 Apr 2025 15:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743977702; x=1744582502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1jotKc/Fqpl2Jd1jPfcmFs0z7oPm/HmjlcBjHuS3pTY=;
        b=PhIP/ZSF/kEn1iczBiq8QVg69EV89O5RYT6DRL745F9TyreiXpFQ4XwJgQ+J0wzNmK
         AODizfAtvzDsxGgq+92ATiYg2/P6Yxjq23xlrO6P3KEFPTbbWLHXb/eWFxpDEVneYKdU
         CgjYmZX2TZhzVF44XLMYwipAgMNSL28lEis3jFrtK9ZYe2YKECtkGB6YFCs/rc0/0wI6
         2hNFZW9+GriZR+ZMK5NFO06ZSbIantU+fuMM1ZaOHVfvbGVVeJfWfhKCK6fLhEJTbmDC
         f2Pnt8Uyw9VFp11sBu67xxDUE7EfS1OzEMaC+JV94mDvWl6mgtnO7XgT3l8mrEokgWm/
         sHdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743977702; x=1744582502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1jotKc/Fqpl2Jd1jPfcmFs0z7oPm/HmjlcBjHuS3pTY=;
        b=VwtberqKWB9H1eVFuBRZVTkUJUIqJ4RikXZMC6pFsbnPZvGKhdcW+RBwq1ka4pa/tA
         fQaLFbG3ig6t2kQSZQrWTDgKe4hxNjwbKNv+Qa4bC6Rk5zgWmpcljRbjbxU38fFYaatK
         Yc4rw3h3RZSMghCV018pXembP6tgl6AuGpmZ8z1puYoI7zh4iAn67ClTyv77EgdM7n7t
         4yd66IR8o5Y9RA6GY6ph8frwBILXSqhGyOEbaCjcF3Kp3PRfvYpGymU018GFiDVBMU1l
         U1H9QTAH1y5POl938cZMI+wH6fSQMj84BodBuF4/Pb3dk5RCOT4ejQR92P5ZQeWx6QmF
         m3vg==
X-Forwarded-Encrypted: i=1; AJvYcCUkI2u2V6jCkZoRzE4M5g7E/YOxSFFuxeYCer6XX3YuGQQwBvfQeAUgX62rumFmv9dq+CFdYAfO67p9@vger.kernel.org, AJvYcCWDX7/90uJVgDWVgJaDZbMhQhMdj/e2HgssG1Qji73JPWM+J7vHvDcaKRHcQrV1SZr2MWlnxTvd2XXEbzOp@vger.kernel.org, AJvYcCWX0PrC3MrEz14RY4azOnsiw+45MQP/VJHgVzOopRZ4oeoTMi7FdTRmJUOGYcfoUcu9ZLRKPC7M@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2KDdIbMpvyJ5RH90+d5QozimtiUKkK5yUs24GekXquUofJBru
	X5TwPAEDHo1q9KChnqzIzTc1rMW98kkWgKD7oZl2cynlRbGcboj5
X-Gm-Gg: ASbGnctYXKgODlSZkLXrLOyXmoo3YCcjtQgt6LH26yWpwipRVzdXeCgXSsk9T1hHvaA
	IMUFwA0qwUgFKEEiXHSXSdKsI2Pz8tknyJfFs4GOsu+JkUBPco2UhH1974F5Iw+nGnYedYPRdlT
	d5x3XebI45/40/pQDHpcZfDnPT1Q9ftwI5c7a078vMjUBkxd96jiBF8eEV5qeA41c9z/3YqoYni
	EnLGFcyzY45D0mpaEiONqBve55sBkrbEGFxoFEA9D4iJgKEYMRl3td3EmHh2r/EVvG5au6GXLgB
	lN/+Hwpx1F9ywtonivqKISRvCCkl5l8xQYs39LaKltLlpk4iGo/7oYgU52C7AOf/uX8JACK1Qft
	kYf/QBFgrB/J+2w==
X-Google-Smtp-Source: AGHT+IF4Orsr0uagyxWiA2SygCLbqK10XpF3iEqB0Ey1M4fJ6BNRGD2Cn9NKoC8AeNVhrjTx7AWL5g==
X-Received: by 2002:a05:600c:5785:b0:43d:209:21fd with SMTP id 5b1f17b1804b1-43ee0783d96mr59382275e9.30.1743977701942;
        Sun, 06 Apr 2025 15:15:01 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43ec366aa29sm111517055e9.39.2025.04.06.15.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 15:15:01 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	"Lei Wei (QUIC)" <quic_leiwei@quicinc.com>
Subject: [RFC PATCH net-next v2 02/11] net: phylink: keep and use MAC supported_interfaces in phylink struct
Date: Mon,  7 Apr 2025 00:13:55 +0200
Message-ID: <20250406221423.9723-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250406221423.9723-1-ansuelsmth@gmail.com>
References: <20250406221423.9723-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add in phylink struct a copy of supported_interfaces from phylink_config
and make use of that instead of relying on phylink_config value.

This in preparation for support of PCS handling internally to phylink
where a PCS can be removed or added after the phylink is created and we
need both a reference of the supported_interfaces value from
phylink_config and an internal value that can be updated with the new
PCS info.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/phylink.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 4a1edf19dfad..6a7d6e3768da 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -66,6 +66,11 @@ struct phylink {
 	/* The link configuration settings */
 	struct phylink_link_state link_config;
 
+	/* What interface are supported by the current link.
+	 * Can change on removal or addition of new PCS.
+	 */
+	DECLARE_PHY_INTERFACE_MASK(supported_interfaces);
+
 	/* The current settings */
 	phy_interface_t cur_interface;
 
@@ -616,7 +621,7 @@ static int phylink_validate_mask(struct phylink *pl, struct phy_device *phy,
 static int phylink_validate(struct phylink *pl, unsigned long *supported,
 			    struct phylink_link_state *state)
 {
-	const unsigned long *interfaces = pl->config->supported_interfaces;
+	const unsigned long *interfaces = pl->supported_interfaces;
 
 	if (state->interface == PHY_INTERFACE_MODE_NA)
 		return phylink_validate_mask(pl, NULL, supported, state,
@@ -1815,6 +1820,9 @@ struct phylink *phylink_create(struct phylink_config *config,
 	mutex_init(&pl->state_mutex);
 	INIT_WORK(&pl->resolve, phylink_resolve);
 
+	phy_interface_copy(pl->supported_interfaces,
+			   config->supported_interfaces);
+
 	pl->config = config;
 	if (config->type == PHYLINK_NETDEV) {
 		pl->netdev = to_net_dev(config->dev);
@@ -1973,7 +1981,7 @@ static int phylink_validate_phy(struct phylink *pl, struct phy_device *phy,
 		 * those which the host supports.
 		 */
 		phy_interface_and(interfaces, phy->possible_interfaces,
-				  pl->config->supported_interfaces);
+				  pl->supported_interfaces);
 
 		if (phy_interface_empty(interfaces)) {
 			phylink_err(pl, "PHY has no common interfaces\n");
@@ -2685,12 +2693,12 @@ static phy_interface_t phylink_sfp_select_interface(struct phylink *pl,
 		return interface;
 	}
 
-	if (!test_bit(interface, pl->config->supported_interfaces)) {
+	if (!test_bit(interface, pl->supported_interfaces)) {
 		phylink_err(pl,
 			    "selection of interface failed, SFP selected %s (%u) but MAC supports %*pbl\n",
 			    phy_modes(interface), interface,
 			    (int)PHY_INTERFACE_MODE_MAX,
-			    pl->config->supported_interfaces);
+			    pl->supported_interfaces);
 		return PHY_INTERFACE_MODE_NA;
 	}
 
@@ -3577,14 +3585,14 @@ static int phylink_sfp_config_optical(struct phylink *pl)
 
 	phylink_dbg(pl, "optical SFP: interfaces=[mac=%*pbl, sfp=%*pbl]\n",
 		    (int)PHY_INTERFACE_MODE_MAX,
-		    pl->config->supported_interfaces,
+		    pl->supported_interfaces,
 		    (int)PHY_INTERFACE_MODE_MAX,
 		    pl->sfp_interfaces);
 
 	/* Find the union of the supported interfaces by the PCS/MAC and
 	 * the SFP module.
 	 */
-	phy_interface_and(interfaces, pl->config->supported_interfaces,
+	phy_interface_and(interfaces, pl->supported_interfaces,
 			  pl->sfp_interfaces);
 	if (phy_interface_empty(interfaces)) {
 		phylink_err(pl, "unsupported SFP module: no common interface modes\n");
@@ -3730,7 +3738,7 @@ static int phylink_sfp_connect_phy(void *upstream, struct phy_device *phy)
 
 	/* Set the PHY's host supported interfaces */
 	phy_interface_and(phy->host_interfaces, phylink_sfp_interfaces,
-			  pl->config->supported_interfaces);
+			  pl->supported_interfaces);
 
 	/* Do the initial configuration */
 	return phylink_sfp_config_phy(pl, phy);
-- 
2.48.1


