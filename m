Return-Path: <netdev+bounces-145607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF5A9D00D5
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 21:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 245BC2874FE
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 20:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D13194C7A;
	Sat, 16 Nov 2024 20:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwWj51xu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF9BB652
	for <netdev@vger.kernel.org>; Sat, 16 Nov 2024 20:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731790341; cv=none; b=kvEcBMWKknv1nJ8yZqPFEUwDEK+CobmepPEVVw9UTGAlCFp8LU6aD9W1JSjdBhjvndutNYwoxUnH3F1YfwnPNUke89apZB0g+yCErtLA7IpODRLF7vaYIc9WoJiatbz4Tam//2GSbRhuHkrjgn7Kb4D7/curFzon/PerdDktB4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731790341; c=relaxed/simple;
	bh=AHbLoMFEhd3tECmorJvmYpW1yb3v36B4CBuTRTivNOE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=tc/rcgbdUm7vFz71R2S/X6Lc2gc4Qp+Uw0hhlsLkcWIvYqZA1r+lT3e+RofgiIm95F87EMMPPhD1GphwH0K09uLxzYgKqN07QXxrBiQXLL7y6CaR3zCdeBWheWQqwiZRaEr9OPg5ZXlCxzfkqxzYE3t8fgLM7cMXpFAuxYruoxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UwWj51xu; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9e8522c10bso448089666b.1
        for <netdev@vger.kernel.org>; Sat, 16 Nov 2024 12:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731790338; x=1732395138; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FgkMyQFQwRj6FZbHFiOFzAptz/h8l2tCUJSN2STQqJs=;
        b=UwWj51xubw+NDCgo/aUVXX8af+SSkJ/u2c/b83SI9Mv6WjSiH8h1THrMCw7s/5kQHa
         e1VWwD10sTNwtUb7CAfJqZvB+5hXuJG3Zwo8hf4aNZB12VHwYDNcUZCef5khBxh9CL7K
         Le2wJj/cmRjmnRuLAvqMyL40m9TPaoDx4et28XRPERido0jY3/B8toqTYT56RbYRusXT
         ZsXm51J6bvM2B453u3cCg4b/yijb68K3DRFbiMOiuK7kfxSFRajVofAzrRpaJL3aFWPG
         dj3fz4GZsfT/LjMSXO1BeJOvATKJZ+8dIUMCkdGL3m0rXtWu08VJEpggav5IC3qRvXEF
         4xRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731790338; x=1732395138;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FgkMyQFQwRj6FZbHFiOFzAptz/h8l2tCUJSN2STQqJs=;
        b=UXrwK9Rb2VaR54fpQaFRb6tdXGJ71eDxPc8RNGBhFoo/Vay+N6U6Tuaz/X5I5OZNb/
         5tXehV3Vg2iN56rJ2SPuDOxypikmr3ltfO7gBcdcNo1YL/H7hyLeXHdqMg+kJqAN2Ot3
         iCC3InU7ghkb8JDaaaXjrK46oEDQzSTG7p6lP29McWsUOl37tHOkY1er+jPVCrf5luMH
         vwOwTvMbSCcwYN3jOSJkVawMnbp8fEOnh3kntc/cOuQvh1kaVyV5KvzGuGspI0lTbyN4
         31D8HdymwACMvwQulO4Pyw79wqxnEjdRhzZ/OzpCj87LmxMo+G5OH6YD6DJjtOgHfrrm
         rflA==
X-Forwarded-Encrypted: i=1; AJvYcCXfu+nmgOyqQsCti1KIpDyck1DQ0v1jjvOou0tXhxChRURLfjIg4AYM9ffLVSVpEYaVqHRnoq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWzWUPZur1eehWLDKknuPq3wnWvUEDuIA0Ea71ew/Vne9z10xo
	+pTwpXG/DADWXyTxogSTchXYTG1LXZT4NKVejq35XYId1lkx29ec
X-Google-Smtp-Source: AGHT+IGZ9uGTngvfA1GFTSi5tHSBtLyJ6ONIZDWvk6RGBXdfcQsBpLMq+tKR7PvZ7Lf27+ctYN02UA==
X-Received: by 2002:a17:906:4783:b0:a9a:130e:11fd with SMTP id a640c23a62f3a-aa20763a62dmr1178403666b.5.1731790337658;
        Sat, 16 Nov 2024 12:52:17 -0800 (PST)
Received: from ?IPV6:2a02:3100:a557:e100:45f4:697f:1405:21be? (dynamic-2a02-3100-a557-e100-45f4-697f-1405-21be.310.pool.telefonica.de. [2a02:3100:a557:e100:45f4:697f:1405:21be])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aa20df570ddsm344542566b.74.2024.11.16.12.52.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Nov 2024 12:52:16 -0800 (PST)
Message-ID: <a5efc274-ce58-49f3-ac8a-5384d9b41695@gmail.com>
Date: Sat, 16 Nov 2024 21:52:15 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Russell King <rmk+kernel@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2 net] net: phy: ensure that genphy_c45_an_config_eee_aneg()
 sees new value of phydev->eee_cfg.eee_enabled
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This is a follow-up to 41ffcd95015f ("net: phy: fix phylib's dual
eee_enabled") and resolves an issue with genphy_c45_an_config_eee_aneg()
(called from genphy_c45_ethtool_set_eee) not seeing the new value of
phydev->eee_cfg.eee_enabled.

Fixes: 49168d1980e2 ("net: phy: Add phy_support_eee() indicating MAC support EEE")
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- change second arg of phy_ethtool_set_eee_noneg to pass the old settings
- reflect argument change in kdoc
---
 drivers/net/phy/phy.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 8876f3673..2ae0e3a67 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1671,7 +1671,7 @@ EXPORT_SYMBOL(phy_ethtool_get_eee);
  * phy_ethtool_set_eee_noneg - Adjusts MAC LPI configuration without PHY
  *			       renegotiation
  * @phydev: pointer to the target PHY device structure
- * @data: pointer to the ethtool_keee structure containing the new EEE settings
+ * @old_cfg: pointer to the eee_config structure containing the old EEE settings
  *
  * This function updates the Energy Efficient Ethernet (EEE) configuration
  * for cases where only the MAC's Low Power Idle (LPI) configuration changes,
@@ -1682,11 +1682,10 @@ EXPORT_SYMBOL(phy_ethtool_get_eee);
  * configuration.
  */
 static void phy_ethtool_set_eee_noneg(struct phy_device *phydev,
-				      struct ethtool_keee *data)
+				      const struct eee_config *old_cfg)
 {
-	if (phydev->eee_cfg.tx_lpi_enabled != data->tx_lpi_enabled ||
-	    phydev->eee_cfg.tx_lpi_timer != data->tx_lpi_timer) {
-		eee_to_eeecfg(&phydev->eee_cfg, data);
+	if (phydev->eee_cfg.tx_lpi_enabled != old_cfg->tx_lpi_enabled ||
+	    phydev->eee_cfg.tx_lpi_timer != old_cfg->tx_lpi_timer) {
 		phydev->enable_tx_lpi = eeecfg_mac_can_tx_lpi(&phydev->eee_cfg);
 		if (phydev->link) {
 			phydev->link = false;
@@ -1706,18 +1705,23 @@ static void phy_ethtool_set_eee_noneg(struct phy_device *phydev,
  */
 int phy_ethtool_set_eee(struct phy_device *phydev, struct ethtool_keee *data)
 {
+	struct eee_config old_cfg;
 	int ret;
 
 	if (!phydev->drv)
 		return -EIO;
 
 	mutex_lock(&phydev->lock);
+
+	old_cfg = phydev->eee_cfg;
+	eee_to_eeecfg(&phydev->eee_cfg, data);
+
 	ret = genphy_c45_ethtool_set_eee(phydev, data);
-	if (ret >= 0) {
-		if (ret == 0)
-			phy_ethtool_set_eee_noneg(phydev, data);
-		eee_to_eeecfg(&phydev->eee_cfg, data);
-	}
+	if (ret == 0)
+		phy_ethtool_set_eee_noneg(phydev, &old_cfg);
+	else if (ret < 0)
+		phydev->eee_cfg = old_cfg;
+
 	mutex_unlock(&phydev->lock);
 
 	return ret < 0 ? ret : 0;
-- 
2.47.0


