Return-Path: <netdev+bounces-166828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7FBA377BB
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 22:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29DED3AF932
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 21:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAEF1A0BFA;
	Sun, 16 Feb 2025 21:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgztB4Cp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C610D33C5
	for <netdev@vger.kernel.org>; Sun, 16 Feb 2025 21:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739740634; cv=none; b=KblzxwiOEqevtePvoEWNl5uQXZA1qy6ztLLaBE/VgQs77cZ0IkpFVu0i8nruE/xgyfo/wc9FaArm9htx9klIcCh8AVhqJg4l02Wr9UUf1em7rBC4T91NpV6kC+vfRo5YbQD/+Rm5keLde6oIh7BIMBywhUazipmOaWO3DYdYBQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739740634; c=relaxed/simple;
	bh=KFTE/HVZc2mJNDu4M6Ti7r/d54wWQ5LFN1lGeP/2suM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Lm9TAWY1Z8Ffj5B7tgcwMWA8G20+fFbdp4MJUW3rPq8XTmx+1sEofD3KFWXtfieciKkruBrrF0hE6h8gl21uOYYCfi5/tBL9q/1sy5GOwnf0AoMvQnIalwMhRAJgSaU35Aq+CA/XFSfYo3zEASQOfYsq5HeVzZHnDEt8zF4IJNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JgztB4Cp; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38f32c1c787so1255615f8f.1
        for <netdev@vger.kernel.org>; Sun, 16 Feb 2025 13:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739740631; x=1740345431; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zdisV4BUIGQaQrqQoPwiha8p1/aKRVD1xT2PbXYM4jg=;
        b=JgztB4Cp6/6IZN1ZZegTP0IX4eeQXnhBzmid87gp6t2vGbDyQXRToEefySUx7KufxS
         4lluwqqjYF7OPLfVTAmHHqQOPe3v+DqI9k2jG1DD7xybkeAR51oSWfLS9nQqmxjwLO51
         fmIjcUsyuJUaeHx7u+/E7tV5wc8ATvyoeIxH7Ta4eaHoX2H4SaCSIHWu9U5c8NA2Anet
         ElRHnn+7jgkaCIbGUzbuvMj/ZIrAZz/7++YbLDpzGJNjmvAdPvto1k7JZR9jC0SBmOFG
         iprXBf1j9vp7QPDUZpn29c9E59KwJOukkgOMwB+5AAY5cViYNddZ7NPTHM/6WajnXpU/
         8wTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739740631; x=1740345431;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zdisV4BUIGQaQrqQoPwiha8p1/aKRVD1xT2PbXYM4jg=;
        b=rmvVb3fUrRmMpcAqNChPQqVt7lQbE1yneogrG9icmfs5D47v2zIuQkYo515I4uENhZ
         f8E0NShzVSMKOeToS5e2OZDDWq35iCMGiv2MU9FeXLZeT2m23FyV4VZjnNFF6Bl9gQha
         fENTAQ/noSkFgF1F60d/i8xY0TlBZUloU98dnb9mXSvLotZyfGwnS8DUR32QRr6l1ZVx
         36VdXQmZCaA9H2szptWhFybnvkHpxgWLn9BTUNRwmI+ceri8teowH98mjzypPlm8YH0b
         78jzfTT26hIPu/6DRrBnoGn1ew8Ddf/LkzgrdD03b4cjwRfiHxd//bB0N4mf8xmUbT5A
         Z8XA==
X-Gm-Message-State: AOJu0Ywbse60tmA9osi0eU+K+K0i4Z6sXYoGIUnaGun3e2Y53pY/z01N
	Vn+Hu+btyh49HinLGaW51GFIc/5MWShUuyIlrs67xJyE3qva0QBx
X-Gm-Gg: ASbGnctbL1yQfqA3AWzMD7XXm4nMhm7uQKrDvVbxfUTTKGR9cOYqlVEA7X3oDm57QXm
	W0oDM9vS0lxswYiUeeQ6UDgFzAl+bpJYD8cKqv90346jdg2ZWpyyFC131IpC3s4ZVGyyX42mWEJ
	eP05tHgtSjgoCcbkvsqAodwg6OODZG/FzVXYaUrcHQQr6w6tZkXnVCQ53qVOawkfB1rcBCDMCzv
	/1hOmWHALkY+rgL3eL128NFVn2kO6k0NotSUILALXaUP4ebCMX0jvurjbcvQ9cRKmj3UPeQMaC4
	3VkwKIc4sxZGSeTVrYx1y+nJP4VLuo50hC2uH4s4Twpqn1K25jZpbAsouoV4wnq71+RIsF1NUkw
	tEtJCYhfIJyjD6ucqNHILbWeNjniemgbjKErWzCz2pzq7o0jMioPs0iXz1UOHad1jRALuTrzmmm
	hgZ+PmcsY=
X-Google-Smtp-Source: AGHT+IERG+G8Z7LPeh5K1dke9GCUZX3ZFjIxH5tY3aqVXc2A9vl+EXv/9xtOUxISTDdFBU54D/Cl1g==
X-Received: by 2002:adf:f9cc:0:b0:38f:231a:635e with SMTP id ffacd0b85a97d-38f33f2c2cbmr6734487f8f.25.1739740630973;
        Sun, 16 Feb 2025 13:17:10 -0800 (PST)
Received: from ?IPV6:2a02:3100:a14d:c000:1d06:77f1:27f3:ba49? (dynamic-2a02-3100-a14d-c000-1d06-77f1-27f3-ba49.310.pool.telefonica.de. [2a02:3100:a14d:c000:1d06:77f1:27f3:ba49])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38f25a0fe5esm10583443f8f.99.2025.02.16.13.17.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2025 13:17:09 -0800 (PST)
Message-ID: <493f3e2e-9cfc-445d-adbe-58d9c117a489@gmail.com>
Date: Sun, 16 Feb 2025 22:17:48 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 3/6] net: phy: remove disabled EEE modes from
 advertising_eee in phy_probe
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <3caa3151-13ac-44a8-9bb6-20f82563f698@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <3caa3151-13ac-44a8-9bb6-20f82563f698@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

A PHY driver may populate eee_disabled_modes in its probe or get_features
callback, therefore filter the EEE advertisement read from the PHY.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/phy_device.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 35ec99b4d..103a4d102 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3563,22 +3563,21 @@ static int phy_probe(struct device *dev)
 	if (err)
 		goto out;
 
-	/* There is no "enabled" flag. If PHY is advertising, assume it is
-	 * kind of enabled.
-	 */
-	phydev->eee_cfg.eee_enabled = !linkmode_empty(phydev->advertising_eee);
+	/* Get the EEE modes we want to prohibit. */
+	of_set_phy_eee_broken(phydev);
 
 	/* Some PHYs may advertise, by default, not support EEE modes. So,
-	 * we need to clean them.
+	 * we need to clean them. In addition remove all disabled EEE modes.
 	 */
-	if (phydev->eee_cfg.eee_enabled)
-		linkmode_and(phydev->advertising_eee, phydev->supported_eee,
-			     phydev->advertising_eee);
+	linkmode_and(phydev->advertising_eee, phydev->supported_eee,
+		     phydev->advertising_eee);
+	linkmode_andnot(phydev->advertising_eee, phydev->advertising_eee,
+			phydev->eee_disabled_modes);
 
-	/* Get the EEE modes we want to prohibit. We will ask
-	 * the PHY stop advertising these mode later on
+	/* There is no "enabled" flag. If PHY is advertising, assume it is
+	 * kind of enabled.
 	 */
-	of_set_phy_eee_broken(phydev);
+	phydev->eee_cfg.eee_enabled = !linkmode_empty(phydev->advertising_eee);
 
 	/* Get master/slave strap overrides */
 	of_set_phy_timing_role(phydev);
-- 
2.48.1



