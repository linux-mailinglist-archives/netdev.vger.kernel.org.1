Return-Path: <netdev+bounces-189585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B6EAB2AB6
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 22:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B3833B5C12
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 20:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE97262D0B;
	Sun, 11 May 2025 20:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0KCa5No"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9202C2609FD;
	Sun, 11 May 2025 20:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746994407; cv=none; b=K1HYuE7wlwad617Ik0PB7xZfQihaxYgZmwVEKvkKzwtVuirXIaijK96QBTjUthjpWw0Wg/XuajtWdH1JosbHjU14f/voT6Ca9k0o422yjlgsem0m+c2DI3VzzjT7lo/JEtGKouydRYyhkpRQqbdJE2TukSEDd+KjuWgOcZpFQlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746994407; c=relaxed/simple;
	bh=wrmp2LSwPgwNKJnArG8IijGvZzsMq5cRrMXTvwCX/X8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KjYkP5+ouL2fzCBj+dzim2o4L8m37iv1MuBzvfaLwEstW4C+TNqZmMH6G4Mkyt2xczSZatibFiwhTM3qHO7BFHhzFq5YgyrtW/yJ+Bpr1/SYlG1+GcVnHFhx/NY6uXp8w8ATjgDbSJVDz1g6CW8KsA6np4Er8hvrUae5GcLs4zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0KCa5No; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso38160245e9.2;
        Sun, 11 May 2025 13:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746994404; x=1747599204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=orWgUHmQriyeNcYTKTqzfO4CbKpuvQ3L/489i8p8bBQ=;
        b=O0KCa5No7wfJDL6PEfrmNJkxdEeK/dCKD8Nr+z6B/kkLlXHUdlvL37Zubxz5ejRif1
         9wqBEEtHCHUU3a6iWaRD6u1esXKzqMjfNJebwiGpl6SCbruB66Cc+xc6LkVbBdwuajtQ
         jEchgGHQsnjR5OBmjgiBb9D5IN5394ZR56Ypj7aMPvy091P7bJo95DyTvat2PZ/oEuWN
         i0QF7IqFOSa8js7gPjTb0Bbi+Wew0L/d+fg8G7EwnOxH9U4KU3pBxhapIpD7BaQs8/d2
         N6UqeNFKV3U85Z8WhZjUc6qWJxz4d99hJWFZAkGDfr88gBnSRZ9LefTVS5GbMiZRmr2r
         OFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746994404; x=1747599204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=orWgUHmQriyeNcYTKTqzfO4CbKpuvQ3L/489i8p8bBQ=;
        b=HwzCPhOSzqy2pmAzytvbSgWtpOqh3ZtmS8AzA5ywX9CZdTJrWvplikhSIBU6mLvUx2
         ReJ6L2yHaOk5sLgglW5L4r5RPp0udrmx6SQxdiVN5kr+aNMxfJMxNKw2A9aQvy9tzvnm
         KlPrg285ydiWfg9vfQGNDi7QFPdoymMV89JJCcQx4XUZEMijqckAoMU2i/VSXE4/J4b0
         5+Sb9DdRpNjMPpW2WiXjVcPXD2qxu6kzK1bEScM+/nw8V+af/C13M9x3wUwaWsRrBNuB
         rbM0waT8gDxE5uSkHcxiQatPziWWQ0OE+iljtCRKZSIEg7baG3/Y56DUKz3+k02n+rCZ
         UxDg==
X-Forwarded-Encrypted: i=1; AJvYcCUBuW8afQfm/yGOAL1ce6AHmNoA0zNjnf+oWKBVFfRmMiB4hWlNs1Wqm0Y1Sk3t9xpoWq3YsNLbjNV2sMsV@vger.kernel.org, AJvYcCWWQmJz+5aRBlQmmeCNa4G8YLnE3/Q6hGIYz0bRxi6O+g/jWhjvIxqh7kcKYZVkRWVYBYRZDZ90@vger.kernel.org, AJvYcCXJmMrAcnt8TXtxewJQLmfZlnPnh/Nnv0pLKkDgJtIhPiPM617NBzk32Tz1oRRw2T/3v2eMOpKcO9JK@vger.kernel.org
X-Gm-Message-State: AOJu0YwiF8c/P4KoVBN9awYF6Aqya7Mt2R9cbDrwf7ZGWrL9XHM9Bq+Z
	MZuMkrIVQ32OkhstRziVeEtp5vONKtQwBjmWjdHFBU7CHVx6mdlG
X-Gm-Gg: ASbGncvFMGaTRnMOpAnF2BYsiZQVe4spBfdRmePlgKiO2Kllnbbryxrr5p6mgJ5dLEM
	JFChuGM24y65bnow6jxpHOxQOzEk300Z6l71OswbSQpesGC0e3cop76U6eiED/pqEVofI+eD7t8
	xEMzlMifNj77Vej7XHfvUad4EzSMdunbs27l9ZfILCngJ6GlklZi7SzvppxfMr/eZKKPtTZRY4S
	6iRhtjc+uTxLfTR53K051BVn/pGR2zldZiNqx9M8nQcJjAfqn6cgpih14T1lytGrCKTAzR5yWNf
	TWsQnRmcfncMTCqVfwJZvhi1qC+PuwMIiaGu7BcjH0ZmwNIdYFcuHJHLTbGEjpDsEKx8ZVZk27S
	cemkEdo6d8YFHvFf0GLBm
X-Google-Smtp-Source: AGHT+IHWxj+KdF4Fuo3sU2eTz3DS6XFpP3uC5wf0mdEBBT1l4DVSLSioRRGfxBvH8wk86+wmiuanpA==
X-Received: by 2002:a05:600c:384a:b0:43c:ea36:9840 with SMTP id 5b1f17b1804b1-442d6dd24a4mr90298855e9.22.1746994403445;
        Sun, 11 May 2025 13:13:23 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-442d67ee275sm100615165e9.19.2025.05.11.13.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 13:13:22 -0700 (PDT)
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
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	llvm@lists.linux.dev
Subject: [net-next PATCH v4 02/11] net: phylink: keep and use MAC supported_interfaces in phylink struct
Date: Sun, 11 May 2025 22:12:28 +0200
Message-ID: <20250511201250.3789083-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250511201250.3789083-1-ansuelsmth@gmail.com>
References: <20250511201250.3789083-1-ansuelsmth@gmail.com>
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


