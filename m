Return-Path: <netdev+bounces-142455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 676EE9BF3C0
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 17:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0EC6B24046
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 16:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E635202640;
	Wed,  6 Nov 2024 16:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfxZSn5i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77120204090
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 16:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730912150; cv=none; b=L501GmAHbnX4bpB1DM/Fd3L3lrkyMo1hiLuQzsolluZwO4meThuP3zvmMc0He3z44ohEFQsqTnnM1UWdQNu5lvqLsuDM1o2iE0lJwXDbezvYuhmFEaSRuuYTVVQLGMClUUDc/81XHc5YuDka/KC9wqC0HPNc6Y84ikwf8FUkBMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730912150; c=relaxed/simple;
	bh=VPuEbgUuhm8Dtus7nZ5DTee8YK/6sZPuUDgMPMLQ3v0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZsQgQBe0Tr2EKGnUWff/nc8pKJBFI4Ex+rCWwKo8/mUtBEHT3ye2WlDIAm6aBi63W1LieISticRSSsexUJj6WwaC5AJwSavwWkvdZuANnfdEdmfqwr3IKGL1dgwiSNRIVKWtLvEzIh4W2ifwb+MXeHDbwkBDFWdjHP3puXv+ZQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mfxZSn5i; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9ec86a67feso161238366b.1
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 08:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730912147; x=1731516947; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SX+86z+Vfim8K/Jc1QS1oCuQE8Zm7X8/3uPP2PLlH0I=;
        b=mfxZSn5iIVXfnjQ4yWDBsguRo2MdhPHglLLnk2wsAASglE8x7lMexyzN2PcPkvjqlu
         AypETIvytTvuB0EYHNEJ6r5ArN5DWyIa9bU3qhzGj0JahoVY8zX9YUb9y1KUDEnBW2CZ
         Q65cWgpGqnBeFB39fGC1HavTvCAl0lFOCnB/a3giVBMmdaBddS+L9jipYMQL5Pem4S33
         3cW0O4g3WkYdIpMruoyssU/YyeBUPhy10vHks4uNwdl/QSldf5D5LngUnm9IH8jpS0zZ
         PoAoFYdBe4ImHWOZAL9Bv18fJ6SBJKuLPG+5apKJX3MYrj0RG8TWvOL5YXRVlwln0J+J
         5G7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730912147; x=1731516947;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SX+86z+Vfim8K/Jc1QS1oCuQE8Zm7X8/3uPP2PLlH0I=;
        b=MvO8RJOiqXeXVSPCtETDhW3bjg+V66dhcW34nCb7XM8O8mOtXsPXv4B6CLMmfj1JL9
         mvw7Ej3qEsuJ2VcJoDA8mtpDqO5QNWq8upD/MUK7f51u/45naiu5jUfSiJ9vuQ+d+kCy
         GGwXGj1GSr1hpdmBWtEWeAooWbLG9Fx/rOARY7oBlzxn9M7H98CrS9kqBPmJvgW7Ffh+
         ixnfRyzbKT0Omxq9Gg7PcIjDZUOvVe6KUMvgr/8iHXH9tnz3ex9cc65VwECEauhveOoe
         HWdeaAuIbV03pGCZ+1E6vyfCxWcZpWPKWZOTjeKRkZN3l91Qqfe5FEkRQ8zDWXe+6TiC
         ImQw==
X-Gm-Message-State: AOJu0YxlmBoGR+nKFb/6NHom2z6pyqCglb39ohkVOBAd7EOXxb7TJ4hG
	RC0NezZBGoYa+m53QEWhrxhsJOgWcoPN/A7IbyVDg3HwIVpJUybQ
X-Google-Smtp-Source: AGHT+IEsQg9gGnzwIthQ0hn+A8tZsI0gAOrlTZbLdZTUx35oUEeVRZ8Yo8M+iecCDCZYuF8PR2McMQ==
X-Received: by 2002:a17:907:60d6:b0:a99:fb10:1269 with SMTP id a640c23a62f3a-a9de5ce4ad3mr4257978666b.17.1730912146446;
        Wed, 06 Nov 2024 08:55:46 -0800 (PST)
Received: from ?IPV6:2a02:3100:a488:4700:cc12:ac39:a3b8:6ff6? (dynamic-2a02-3100-a488-4700-cc12-ac39-a3b8-6ff6.310.pool.telefonica.de. [2a02:3100:a488:4700:cc12:ac39:a3b8:6ff6])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a9eb16a2f86sm302718366b.5.2024.11.06.08.55.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 08:55:46 -0800 (PST)
Message-ID: <697b197a-8eac-40c6-8847-27093cacec36@gmail.com>
Date: Wed, 6 Nov 2024 17:55:45 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 1/3] r8169: improve __rtl8169_set_wol
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <be734d10-37f7-4830-b7c2-367c0a656c08@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <be734d10-37f7-4830-b7c2-367c0a656c08@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Add helper r8169_mod_reg8_cond() what allows to significantly simplify
__rtl8169_set_wol().

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 55 ++++++++++-------------
 1 file changed, 24 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index c7dc8b539..2ff95fde4 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -748,6 +748,20 @@ static void rtl_mod_config5(struct rtl8169_private *tp, u8 clear, u8 set)
 	RTL_W8(tp, Config5, (val & ~clear) | set);
 }
 
+static void r8169_mod_reg8_cond(struct rtl8169_private *tp, int reg,
+				u8 bits, bool cond)
+{
+	u8 val, old_val;
+
+	old_val = RTL_R8(tp, reg);
+	if (cond)
+		val = old_val | bits;
+	else
+		val = old_val & ~bits;
+	if (val != old_val)
+		RTL_W8(tp, reg, val);
+}
+
 static bool rtl_is_8125(struct rtl8169_private *tp)
 {
 	return tp->mac_version >= RTL_GIGA_MAC_VER_61;
@@ -1538,58 +1552,37 @@ static void rtl8169_get_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
 
 static void __rtl8169_set_wol(struct rtl8169_private *tp, u32 wolopts)
 {
-	static const struct {
-		u32 opt;
-		u16 reg;
-		u8  mask;
-	} cfg[] = {
-		{ WAKE_PHY,   Config3, LinkUp },
-		{ WAKE_UCAST, Config5, UWF },
-		{ WAKE_BCAST, Config5, BWF },
-		{ WAKE_MCAST, Config5, MWF },
-		{ WAKE_ANY,   Config5, LanWake },
-		{ WAKE_MAGIC, Config3, MagicPacket }
-	};
-	unsigned int i, tmp = ARRAY_SIZE(cfg);
-	u8 options;
-
 	rtl_unlock_config_regs(tp);
 
 	if (rtl_is_8168evl_up(tp)) {
-		tmp--;
 		if (wolopts & WAKE_MAGIC)
 			rtl_eri_set_bits(tp, 0x0dc, MagicPacket_v2);
 		else
 			rtl_eri_clear_bits(tp, 0x0dc, MagicPacket_v2);
 	} else if (rtl_is_8125(tp)) {
-		tmp--;
 		if (wolopts & WAKE_MAGIC)
 			r8168_mac_ocp_modify(tp, 0xc0b6, 0, BIT(0));
 		else
 			r8168_mac_ocp_modify(tp, 0xc0b6, BIT(0), 0);
+	} else {
+		r8169_mod_reg8_cond(tp, Config3, MagicPacket,
+				    wolopts & WAKE_MAGIC);
 	}
 
-	for (i = 0; i < tmp; i++) {
-		options = RTL_R8(tp, cfg[i].reg) & ~cfg[i].mask;
-		if (wolopts & cfg[i].opt)
-			options |= cfg[i].mask;
-		RTL_W8(tp, cfg[i].reg, options);
-	}
+	r8169_mod_reg8_cond(tp, Config3, LinkUp, wolopts & WAKE_PHY);
+	r8169_mod_reg8_cond(tp, Config5, UWF, wolopts & WAKE_UCAST);
+	r8169_mod_reg8_cond(tp, Config5, BWF, wolopts & WAKE_BCAST);
+	r8169_mod_reg8_cond(tp, Config5, MWF, wolopts & WAKE_MCAST);
+	r8169_mod_reg8_cond(tp, Config5, LanWake, wolopts);
 
 	switch (tp->mac_version) {
 	case RTL_GIGA_MAC_VER_02 ... RTL_GIGA_MAC_VER_06:
-		options = RTL_R8(tp, Config1) & ~PMEnable;
-		if (wolopts)
-			options |= PMEnable;
-		RTL_W8(tp, Config1, options);
+		r8169_mod_reg8_cond(tp, Config1, PMEnable, wolopts);
 		break;
 	case RTL_GIGA_MAC_VER_34:
 	case RTL_GIGA_MAC_VER_37:
 	case RTL_GIGA_MAC_VER_39 ... RTL_GIGA_MAC_VER_66:
-		if (wolopts)
-			rtl_mod_config2(tp, 0, PME_SIGNAL);
-		else
-			rtl_mod_config2(tp, PME_SIGNAL, 0);
+		r8169_mod_reg8_cond(tp, Config2, PME_SIGNAL, wolopts);
 		break;
 	default:
 		break;
-- 
2.47.0



