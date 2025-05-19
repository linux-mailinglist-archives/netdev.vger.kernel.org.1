Return-Path: <netdev+bounces-191597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4EA6ABC5CB
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 19:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2BD5189806B
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 17:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3511128935E;
	Mon, 19 May 2025 17:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgF8yVqT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB60288C86;
	Mon, 19 May 2025 17:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747676785; cv=none; b=Ki9nDfhApgNBAdOymnBfF8GZa6wWifBYeAfJFJ6WRN5QBU3/Zo+l+c1wtvU0yUxhMo7ZqtwM105Zk2VrXkA/I8/2XcA1Er9VJSOsQKLXl+zrFYlT7wW7CJx7mRPYKPZPMmjZt1RzQllhXEIbALj2M6IKpD/t0EL92agC8cef1jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747676785; c=relaxed/simple;
	bh=uqiw7kPHnRXfh4KjJ6YjxUfuMjfIRbxc3MxfKiuob40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q5H5CgrNHcDR5Cn+53mu+eKAqmbrrhVUD2XY25i6aMcx5LNYAWM0Bqv1cih2wcp8DdmuJfU7DdmbTiythCx7byfWKKWjOg5QXSWvsfh0bvEiO1B8INA24Cyg0rfCLIbx3ydkur7l1jbcfBoc4tSdWTCZ+wcY0rwaJ216Go7rKY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dgF8yVqT; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6000f2f217dso3962452a12.1;
        Mon, 19 May 2025 10:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747676782; x=1748281582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GUhHJEXQrlPdO/IBxhxTsANnm82xLSOlInc80+87whs=;
        b=dgF8yVqTczljL/ocjchAMjYEwieu6TifSpZAC5Byl9e/N+4HFlGOWSPkT6EeRsvoRv
         diLaBpUcoQvwO2YK20ab/Go1jvHWrL2U+nwIVvlL1Mb7rwfza6XVQWPYJ2eoC30zzAyI
         Gu0+R2ivtc76eUJUpW0+qrK7LBM9QZ5lN7Ig6veTq/vFYrZtFllntqfmgPe2Ag0WOCJY
         n5n6bI+KIuJ7PpovVCIXLiDz1hQsDQausYvQzYgy6GuOqoIg6e5iVShFlvcgsYHnOJ1h
         6cUuf1O//lprZFttDjX+dFZInaRgT+N4sBXrxXK+Xj5A1f9U1sLhSXFT3kJe990j5hTo
         6mlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747676782; x=1748281582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GUhHJEXQrlPdO/IBxhxTsANnm82xLSOlInc80+87whs=;
        b=ESYqedq3C2Z8QyMvzOq4+DcQpKH8TVf3Kkdkx6Pk7ZUZ1yFuPljY7+/rvHLUDj5Y6A
         vnJ3WK/fPLaHYqZ0xyKFefIQi+fltIXAP7a+VGK9w4aUomGGC2zPKrI5f9HMh1YcsMCr
         eMj4L7rEHkn2ZOx7BT1MKsLqSrZiX0BRnOchNZat2RPTdU6m6QwblGvpj9YG335i5P3r
         GhIkF8lzL10czZtOAgVLXsDbZ1CEOd2PCQvKXYFB4udQnlC8qPtcm9Zg5kuO5RhViKYQ
         tfwrDyaL16FVBTCu7N0lGOnsD84VhC2rqN73FUAIireudDNwVU83YTVAt05yEauX3AFZ
         3VoA==
X-Forwarded-Encrypted: i=1; AJvYcCVoBsH3EROtv9PmjcLJ5O7XczFl1G9qrjbgth8NzuQ9NyeimfL+zkeTm7gt6UqYlkiAPFuAZ1n+DyO9EMI=@vger.kernel.org, AJvYcCVqwJY1BNcDbTAZBm9Zt3UmxcbiPfpWSV/qg4xDafUCPcOSiiAetqUl8g5MSvXgiw+87kUwm3vi@vger.kernel.org
X-Gm-Message-State: AOJu0YwJSYJtLqtePOXKuOcTFPlIEPNQvUf1o5AdOlhjTt7h4Yvh0nBR
	kM31HD6j0WjAMKV64hxxIubfqG3TbwU+I2wfsKUVQQh5EuBnWWOnOhzk
X-Gm-Gg: ASbGnctVUj8ujAX5Y1CEyOiM906WvRTIWYJUHUFiAVhse+l2q8HLtzs6fi8FcKGi8u0
	u5p/hvHnefZ3AOJ6fj5a9nJDKptESFD6VEz/qxbr6Ocfra+9Ww2ENDzGNjrWdNnSgX2daD0+uYo
	9am13pNjCsN+EPsFEPhPAwbbxO1wD0ncZU2bhAanDikdemTt49x57MrYjbSWwCCEwVS4eSbf+Tb
	jxZiXCs3LS+CikUgzacqEVlhZGCF1+lV9u9klHmoRH8Z+UpAy6Q3TGticNDd8szCvLrQQ/qw03R
	InjagFHUczEA44iPPOLG4LJbnt/LHW+OGLq7hisbOMdUcKpnud/bJqR6J4maIvCZ+yTtyMZBypj
	ChDBUJNxBtFrjCTD1Oz6WTYfHLq0+n37h3rZI+/7j/A==
X-Google-Smtp-Source: AGHT+IFeYwhCeA6tAalFdp6N+IAjFVHwQXe3scg3Xdf5BUfVsFrivmVXWqv6JMq7KetvOHwL3ocb4A==
X-Received: by 2002:a05:6402:4301:b0:602:3e4:54de with SMTP id 4fb4d7f45d1cf-60203e45620mr711671a12.10.1747676781464;
        Mon, 19 May 2025 10:46:21 -0700 (PDT)
Received: from localhost (dslb-002-205-017-193.002.205.pools.vodafone-ip.de. [2.205.17.193])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6004d50364dsm6047560a12.32.2025.05.19.10.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 10:46:21 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	=?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 3/3] net: dsa: b53: allow RGMII for bcm63xx RGMII ports
Date: Mon, 19 May 2025 19:45:50 +0200
Message-ID: <20250519174550.1486064-4-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250519174550.1486064-1-jonas.gorski@gmail.com>
References: <20250519174550.1486064-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add RGMII to supported interfaces for BCM63xx RGMII ports so they can be
actually used in RGMII mode.

Without this, phylink will fail to configure them:

[    3.580000] b53-switch 10700000.switch GbE3 (uninitialized): validation of rgmii with support 0000000,00000000,00000000,000062ff and advertisement 0000000,00000000,00000000,000062ff failed: -EINVAL
[    3.600000] b53-switch 10700000.switch GbE3 (uninitialized): failed to connect to PHY: -EINVAL
[    3.610000] b53-switch 10700000.switch GbE3 (uninitialized): error -22 setting up PHY for tree 0, switch 0, port 4

Fixes: ce3bf94871f7 ("net: dsa: b53: add support for BCM63xx RGMIIs")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index b00975189dab..9d97ad146ce4 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1458,6 +1458,10 @@ static void b53_phylink_get_caps(struct dsa_switch *ds, int port,
 	__set_bit(PHY_INTERFACE_MODE_MII, config->supported_interfaces);
 	__set_bit(PHY_INTERFACE_MODE_REVMII, config->supported_interfaces);
 
+	/* BCM63xx RGMII ports support RGMII */
+	if (is63xx(dev) && port >= B53_63XX_RGMII0)
+		phy_interface_set_rgmii(config->supported_interfaces);
+
 	config->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
 		MAC_10 | MAC_100;
 
-- 
2.43.0


