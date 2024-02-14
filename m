Return-Path: <netdev+bounces-71825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B71858553CD
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 21:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED317B280FA
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 20:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4967413DBA9;
	Wed, 14 Feb 2024 20:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MlHU1TCy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802A313DB9F
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 20:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707941784; cv=none; b=Gu2pw/mYpGdeIUA/PlfpDKvVqrPvS92rpjCisB/1QEL44oBxEcTJyHOokJQQgl2vJHZNnhPH0IsLhZKz1PNJlQTTJXIX1u8wPh8grl4h/OSkYFwlEWPBbs4bHcX9SH3SkB014oxemHmREEbnnXkRlVVhtSW9TMBTcs8pggvZTFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707941784; c=relaxed/simple;
	bh=0LLQp9A+4Wui1aJcoXZcdtVUwcgeVW47RuRQRZgxWE0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=afjGX+QawI/NypUs6pGPLQGE/dKCHiKUPQGirp8r23/h1QQRDtWG/9QEu5r75i+4iqIcEyU0pWHVY50w7h2wo4lRWeiOyzTn29Z32D7Ws5ckgzbdDww7pnT2U4ErtFXl3AXcqUrVAVM6uJbA1hUM+FyjqclhxjUqn7Nt/6kPSes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MlHU1TCy; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5638a717bf2so147120a12.3
        for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 12:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707941781; x=1708546581; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EEOPRGpOfPpzTAcP2veuN8SmmfPPSSW3yOxckZ2JjGg=;
        b=MlHU1TCyWzp7AKwzEeLbJJSc7HGWfBHSPbA7peafG6t2Ro8eptE/0v7WuEBUYYkIhV
         YkwdUE1JkrCVms1WLJTZZ5zhAEgu1RXrHP2lfingHTWPv5mb6EiuENW0bp+sUTuNCGRz
         yfTmcxlNxannpIQINjaqxdzMOIbBmiy1fP418EQOxB2uaazlDQgZP4gsRmeua8+0PzHQ
         c3+UVGROtHM8etnv2PnOj9wOLuiJHRSvaK/AQ39vGRE0MDzHeP83+o4AmqNZaZhV7BAk
         DSk06/a1zIds2cMvmz+ZSqIC/5armAhK+PVgwhRZKCykxxyFVmYle/TIcSR8/jSLS0On
         +OSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707941781; x=1708546581;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EEOPRGpOfPpzTAcP2veuN8SmmfPPSSW3yOxckZ2JjGg=;
        b=MG+AUGToUKYAu+gwp+JeEz+NqcbJcacbcwbbIzUeFQoBhk1KBRcihTsQa9iWfMeIrW
         T69PCZrF0SpReEFB8cM4OsqCUJxyAIbqhILokjTcV1MkPGJzB02TURL5Ak+rCzZlrrSC
         KRMdEAUn4hAYZZ2hygg/kP3w3JWVW00djpwmg8Qxg7UnA8MIt9scs5qTtw3mnIKRFVqE
         zCqo0d4JTK1E0+8bdUb7s/MrZ/tMGdFFB5r+017+dSj9EYBvFh6hDDuMwaEWEq9lkccP
         TVfC7v/6nW4CFq4IOYOoRzrOUZGju5wIwa8fG7i9PD0hyv+7XbeebZ/orsExnJWfFzYQ
         8fEQ==
X-Gm-Message-State: AOJu0YxQvEUSKSt0pJbGeMwxZZuzAi+iOyJTOuE6RFX3A9fAFHalA+mS
	+QGcL8hVbt0S76/NEJAOzYVRSTY3OofljxWoWA0TZw6w+zD/VWQN
X-Google-Smtp-Source: AGHT+IFXCVUKiMvAgohXuQdgzBICQp4YngZTHvJ/uTvRa7sSrmZNTOtmrQxpVhh8Y4Uvr6KKYa+ejg==
X-Received: by 2002:a50:ed94:0:b0:55f:e493:33b4 with SMTP id h20-20020a50ed94000000b0055fe49333b4mr3024276edr.15.1707941780512;
        Wed, 14 Feb 2024 12:16:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVzOKGSlejVYfueUvec98BxHgxIyKu4mee+DZFczSos/n7R5Pzq4Oby6epgpWvlDEELbKs86Ju4X4Hk3F59/kteA1cwpHAt5WUkQ/sjDUZQwtB2yR3C3KobMXUGuKlKEgnCDNtQRKBekLJNqPMB+GvJi7apzkEglvzCi5ZbWf8Xoh3MqJvsYoUK2PhUuK3YrplRzjY=
Received: from ?IPV6:2a01:c23:c153:4a00:f92b:249d:fae6:3a40? (dynamic-2a01-0c23-c153-4a00-f92b-249d-fae6-3a40.c23.pool.telefonica.de. [2a01:c23:c153:4a00:f92b:249d:fae6:3a40])
        by smtp.googlemail.com with ESMTPSA id en14-20020a056402528e00b0055fef53460bsm4979118edb.0.2024.02.14.12.16.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 12:16:20 -0800 (PST)
Message-ID: <48ab4dc3-4176-4b4d-b8e9-4e08418cfc19@gmail.com>
Date: Wed, 14 Feb 2024 21:16:19 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 1/5] net: mdio: add helpers for accessing the EEE
 CAP2 registers
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <558e122f-e900-4a17-a03a-2b9ec4fed124@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <558e122f-e900-4a17-a03a-2b9ec4fed124@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This adds helpers for accessing the EEE CAP2 registers.
For now only 2500baseT and 5000baseT modes are supported.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 include/linux/mdio.h | 55 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/include/linux/mdio.h b/include/linux/mdio.h
index 79ceee3c8..fd8ff310f 100644
--- a/include/linux/mdio.h
+++ b/include/linux/mdio.h
@@ -439,6 +439,42 @@ static inline void mii_eee_cap1_mod_linkmode_t(unsigned long *adv, u32 val)
 			 adv, val & MDIO_EEE_10GKR);
 }
 
+/**
+ * mii_eee_cap2_mod_linkmode_sup_t()
+ * @adv: target the linkmode settings
+ * @val: register value
+ *
+ * A function that translates value of following registers to the linkmode:
+ * IEEE 802.3-2022 45.2.3.11 "EEE control and capability 2" register (3.21)
+ */
+static inline void mii_eee_cap2_mod_linkmode_sup_t(unsigned long *adv, u32 val)
+{
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
+			 adv, val & MDIO_EEE_2_5GT);
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
+			 adv, val & MDIO_EEE_5GT);
+}
+
+/**
+ * mii_eee_cap2_mod_linkmode_adv_t()
+ * @adv: target the linkmode advertisement settings
+ * @val: register value
+ *
+ * A function that translates value of following registers to the linkmode:
+ * IEEE 802.3-2022 45.2.7.16 "EEE advertisement 2" register (7.62)
+ * IEEE 802.3-2022 45.2.7.17 "EEE link partner ability 2" register (7.63)
+ * Note: Currently this function is the same as mii_eee_cap2_mod_linkmode_sup_t.
+ *       For certain, not yet supported, modes however the bits differ.
+ *       Therefore create separate functions already.
+ */
+static inline void mii_eee_cap2_mod_linkmode_adv_t(unsigned long *adv, u32 val)
+{
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
+			 adv, val & MDIO_EEE_2_5GT);
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
+			 adv, val & MDIO_EEE_5GT);
+}
+
 /**
  * linkmode_to_mii_eee_cap1_t()
  * @adv: the linkmode advertisement settings
@@ -466,6 +502,25 @@ static inline u32 linkmode_to_mii_eee_cap1_t(unsigned long *adv)
 	return result;
 }
 
+/**
+ * linkmode_to_mii_eee_cap2_t()
+ * @adv: the linkmode advertisement settings
+ *
+ * A function that translates linkmode to value for IEEE 802.3-2022 45.2.7.16
+ * "EEE advertisement 2" register (7.62)
+ */
+static inline u32 linkmode_to_mii_eee_cap2_t(unsigned long *adv)
+{
+	u32 result = 0;
+
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, adv))
+		result |= MDIO_EEE_2_5GT;
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT, adv))
+		result |= MDIO_EEE_5GT;
+
+	return result;
+}
+
 /**
  * mii_10base_t1_adv_mod_linkmode_t()
  * @adv: linkmode advertisement settings
-- 
2.43.1



