Return-Path: <netdev+bounces-189453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF643AB2352
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 12:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76D8B1BA5BE8
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 10:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CA6236424;
	Sat, 10 May 2025 10:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hreR7Otp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4D81E32C3;
	Sat, 10 May 2025 10:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746872670; cv=none; b=BWPRfHilW2H9G3Uc+4x3lRZLp0d6+w916/Jvi5/ORtmhbYuAjWKBTHBdCJ9xJzr5esg6reCE3xe9RjX6zbIPIB2B/EuxafAF3n7chFDUEA+27ufu06j8JFlaNrioLabKP60G5GIAFOztAmoQEQ5v1KKfKR96rrEPERYxZevOdis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746872670; c=relaxed/simple;
	bh=wrmp2LSwPgwNKJnArG8IijGvZzsMq5cRrMXTvwCX/X8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o1oWaOI2M7nTBG9y8xFzWeFAM1U2bFCjlrtTNl8jpavpZkdU0HGFrZ0brYbjc3Ux5qVeOoeD0c8GteVSWHMxHZXhvLUhi9oeoDGY+x3biuBt1mkiA5/Rl3DTQDJHMRV9CoCLx7BmJFqfDne4LdElByGk/bKyMciM9BNuYNQEOdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hreR7Otp; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cfdc2c8c9so15398265e9.2;
        Sat, 10 May 2025 03:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746872667; x=1747477467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=orWgUHmQriyeNcYTKTqzfO4CbKpuvQ3L/489i8p8bBQ=;
        b=hreR7OtpEk4VwZy8pI3zHt6csw7iVecInbWIJ1Mf2q5wNDwiM+UOHlaWNTMkaQqd8S
         iaU8cO43/D+Of7K0kFWpwdNNQoctL0911FrDGKk/vbs4TATDLVysqV4b8k1pHQ0Yp6YJ
         aaccQOl0t9SoIeeIe2ppLOIQ0qvwx4+FplAs675Zy4yNiajvWd2Ju3IJXbWLWWm0Wosk
         F67DcJiNlsJc39+hc7MZXErlKw19hNMmkrAieu6lyotcDEdvsAO2RcQk8/V9yquAGmLW
         +PFbEVVSqudgFFXW/nOZJTHAzR7h6TS8yVBwg/5JZ0bCAzRzyYB+NVLxGwnr7EEhdFWN
         2TPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746872667; x=1747477467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=orWgUHmQriyeNcYTKTqzfO4CbKpuvQ3L/489i8p8bBQ=;
        b=bZuSzJq1G6mU1elc+qkXY0iDKo60ePwivTjvY3RrFym11de6KBa2Mdy/f/dMKSAIe8
         TY4MqRn2ADnyyP7wS7DBnpR3dkShrkHVL59QKViPyfYUUVEH2pKoczGGvK44YJG0J1Xx
         TpaFztzz6udEmG/NPY+A6CgJOpxLX45ejwnlyQzDXYIa0pYzJ1W6ssika6ih/AyDXxtM
         CPB+fMC4hJ4J82xbfC2NGcszUQmrEAmvBYQR83p9zFo5AgTz21zuvIkcJkruIPAv+YK3
         l8/KV9KQvNplb4F8mV0gf+4Es0CmHbU9cyAy0IvQhoNewuo7qu3zwV2YLA9T2+6YB1xh
         WpRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJa5qblhVKTykclrnKQ7a+kc+jmTBoXaiogrNDmcvqcoOJt5epGTQpxhCx72TkC3tWeEn2Fh+Izfbc7jlK@vger.kernel.org, AJvYcCUhcLlPLGSPHOKXaaCGAbS8rXLQ6WXjYdrpPxQVFJ5/dRFWg8P/bH5blFcLIAh6tC1rHJoGXVGpBT8o@vger.kernel.org, AJvYcCWQxuTsjOoPn2ALuBYwVP2Jh+MbFzebQAy/irZCcnb78JiFTUAr8EXcqSMvWhnv9Z7x5HEAyy0s@vger.kernel.org
X-Gm-Message-State: AOJu0Yww6AP7HqvJZc765ZK8pMKgVPIOfJppZOCyFumBBviYOteS61hU
	nwOWE7hFn4IXKrSYA47nOuczAN9FW6OCJwNuVHXmmJhcolGu/eVB
X-Gm-Gg: ASbGncuALQNRrB7uSBEpUNw8718C5wqSx+xJGZ5pZ8qMUONzzAk89qrkGHpMyfPIGpj
	/8zWw9OZnrC8tgJJkPrmd0mcHKnWUGIfFEe+mAEu6KMeF/NUWjHNZlg3eN69rjiHES7F6OtjqkR
	QGyB45W06JqV5QIqYNcTbgoyO9y7HoZCRqbQE1EiCnWlxzSRSbSwabLE/YKcSUZLooOnY8mG9Ti
	hpJwsrE808ZsGty2/OpEKl2bQ7E4hAEbXsb0K14mClm4V+luf0sOF6vTOLcwoE59TC+Ekr+OpQt
	w2/el6orixcYBpaBoGljP/Cel4bdXmAgn/tILhtuXQ3NjwAfByFuywNs47H9YPqp+tWuktnLM7K
	qe9NWoCfmC9cuL5K3I6kq
X-Google-Smtp-Source: AGHT+IF8fF8mgD9KREMGAiFhe0OUNtFJZt1x4egNmFWBpaRbum1X6E6uSAwHuhPCucDqGUyba997Lw==
X-Received: by 2002:a5d:64ac:0:b0:3a1:1229:8fe0 with SMTP id ffacd0b85a97d-3a1f6482c15mr5576406f8f.38.1746872666782;
        Sat, 10 May 2025 03:24:26 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-442d67df639sm57981265e9.13.2025.05.10.03.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 03:24:26 -0700 (PDT)
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
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [net-next PATCH v3 01/11] net: phylink: keep and use MAC supported_interfaces in phylink struct
Date: Sat, 10 May 2025 12:23:21 +0200
Message-ID: <20250510102348.14134-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250510102348.14134-1-ansuelsmth@gmail.com>
References: <20250510102348.14134-1-ansuelsmth@gmail.com>
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
index 0faa3d97e06b..ec42fd278604 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -59,6 +59,11 @@ struct phylink {
 	/* The link configuration settings */
 	struct phylink_link_state link_config;
 
+	/* What interface are supported by the current link.
+	 * Can change on removal or addition of new PCS.
+	 */
+	DECLARE_PHY_INTERFACE_MASK(supported_interfaces);
+
 	/* The current settings */
 	phy_interface_t cur_interface;
 
@@ -610,7 +615,7 @@ static int phylink_validate_mask(struct phylink *pl, struct phy_device *phy,
 static int phylink_validate(struct phylink *pl, unsigned long *supported,
 			    struct phylink_link_state *state)
 {
-	const unsigned long *interfaces = pl->config->supported_interfaces;
+	const unsigned long *interfaces = pl->supported_interfaces;
 
 	if (state->interface == PHY_INTERFACE_MODE_NA)
 		return phylink_validate_mask(pl, NULL, supported, state,
@@ -1809,6 +1814,9 @@ struct phylink *phylink_create(struct phylink_config *config,
 	mutex_init(&pl->state_mutex);
 	INIT_WORK(&pl->resolve, phylink_resolve);
 
+	phy_interface_copy(pl->supported_interfaces,
+			   config->supported_interfaces);
+
 	pl->config = config;
 	if (config->type == PHYLINK_NETDEV) {
 		pl->netdev = to_net_dev(config->dev);
@@ -1967,7 +1975,7 @@ static int phylink_validate_phy(struct phylink *pl, struct phy_device *phy,
 		 * those which the host supports.
 		 */
 		phy_interface_and(interfaces, phy->possible_interfaces,
-				  pl->config->supported_interfaces);
+				  pl->supported_interfaces);
 
 		if (phy_interface_empty(interfaces)) {
 			phylink_err(pl, "PHY has no common interfaces\n");
@@ -2684,12 +2692,12 @@ static phy_interface_t phylink_sfp_select_interface(struct phylink *pl,
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
 
@@ -3576,14 +3584,14 @@ static int phylink_sfp_config_optical(struct phylink *pl)
 
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
@@ -3729,7 +3737,7 @@ static int phylink_sfp_connect_phy(void *upstream, struct phy_device *phy)
 
 	/* Set the PHY's host supported interfaces */
 	phy_interface_and(phy->host_interfaces, phylink_sfp_interfaces,
-			  pl->config->supported_interfaces);
+			  pl->supported_interfaces);
 
 	/* Do the initial configuration */
 	return phylink_sfp_config_phy(pl, phy);
-- 
2.48.1


