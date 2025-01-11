Return-Path: <netdev+bounces-157457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 120DFA0A5E9
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 21:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3AE87A3D94
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 20:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52F91B85CC;
	Sat, 11 Jan 2025 20:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxpH5r1y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2241B85D3
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 20:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736627370; cv=none; b=QGA1pn0KEej52iJ9G9/eH2KPnYY9o1pUlNrVUnfSz/GbanzmaPFEy55N0czWYJwLM3t3lrrh2m+ahMMRBUf9XjbChLyPBdMB6Q/n9C7vlEw1YMDcdH4WVYyDn1MRNSqX1lNmb8NgjMVGhH2A746Jy8wl/jr0DKxPw4CPKKIPOlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736627370; c=relaxed/simple;
	bh=jPx1NDxNEud4owSbvYgV5w/KsZRT+U7tOEdh19pm1Z4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=gKdom01gAg4+83r8OrsMvI3xIw+9InxkuG6MxbS/Mmq1veF7Rb2p6BGL+bTInC38Z5nQiJEXsuG5EYGiy+Q95WjtXJIX0RP6ZaX4biLZAcrR96IEldGOhM9I3X5aGKWlY0vmN5C6evnEv+2ckbBoXZPrdbTuK9IJlgwCJy1cPIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hxpH5r1y; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d7e527becaso4978174a12.3
        for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 12:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736627366; x=1737232166; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=D1GoVZaTZhrjTjAe0U0XKWytSXKvgBIDeabv1Mucsks=;
        b=hxpH5r1y0S3ZHbyYXqwueXQF1+nFo7UZUkP5M6Ii7lJBlsWtPAvjgQYW0NnlM1iISv
         Y7Yzj+i6+KU4IHaj2jPfjoUGnBArp80p1yKxjXxvsEQKW1Dd4MwYnFguT6Xh2/NK6iWG
         EiwRlkWkayLsY7mieXsoa4SU8q8l6r1Jp6j5mjEfIBQOLyp3uSE09V5i0jcCshKN3b7X
         SiwOR20v6onpPFOabo1TDGUWcAIoEM6r1OmjqjJMZREJLWWEj8GoSw7H8D2bM+j0EW9G
         Ci1u8lrOSPIrdvr/qwbvudh/vpGgFKTe+WwtI0vL74yamja9oJz80G6t37l8ZBn6GlMZ
         zOWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736627366; x=1737232166;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D1GoVZaTZhrjTjAe0U0XKWytSXKvgBIDeabv1Mucsks=;
        b=EuzRkxyBZZVHGri2W1defCzzOCDgSm6cBhtC/PJNZoI0jadnMvzrb1bNI2qvxhqQRB
         UrLzY7M7/x4Ntc06bycUX0wI5yNq9uxSorR7xBMBFzBAFZe7y2zQDdcaqtjBekGU4kQ/
         5Ph/eaU6oGAzejJMEfQDE2CXDfq4ylE12ZCvZWBzgvxermtmMLIl632/5exj6hkzG/6h
         G36UuT1roi+Vp4JE0LkzRf6tgxEjov4TWsiAgQbqSqOqK5bHPxqq0v71nU5RaIvImGzv
         vjegm1jp8620LP3GsmtHdFw414zHkhUGWP4O9Vm4SjlW3ROl63KDGgjmfEs249grmpdC
         MaAQ==
X-Gm-Message-State: AOJu0YzyjrgdWUgDdm1cWKb4eg6XMA7ZmGhNDey4vk277762hlbOtGFY
	vQPxH5jMh4xkF7UdGxfriXzowV6trcds9QhTe6VAuYCWI39kVyQZ
X-Gm-Gg: ASbGncuxHtf6OJIzxJh6BrPPJlCQ0Ohuf18ZovIBdQIjhTs4NjBCkK7O6X6YgJVUYak
	xXw6B/ckgklftRIR73lpZJKvFR2kMCAdCBMWaMnnygNU60ek/+BT6cukUcpYuspCuWj87QIIVk0
	PUL7YgRm5To2mm0ISKvu/9D9HI1xX2A5K3ZH1egYua20oSiEou9LSHMa9++gc45ghsHp6yd36xo
	7QirkYIjKG6v9qEQNQFErDELg4Ih+glAyHNPzi89Fnq3/anApPD07Bv+TEiNk7nm0VbVYE9C1dD
	NS/2BUnhe7ODRBrLrirAH+3zDtw0XsNeJ92HJAoMh+uFuw9toAtlCMib9AXZB+nREvU38z+MPUS
	I5EIwC7VCkuhugAZLifNMYatQszxqVwrNNclPbszhFwDU4jQb
X-Google-Smtp-Source: AGHT+IEt3z+b1QX9fWF+F6Nm7xHhLGepK+45KYaYO655Zhfo750cCv3cYC/torAHv1GDVn1p1K9DIg==
X-Received: by 2002:a05:6402:5109:b0:5d0:cfad:f71 with SMTP id 4fb4d7f45d1cf-5d972e7110amr32758282a12.32.1736627366085;
        Sat, 11 Jan 2025 12:29:26 -0800 (PST)
Received: from ?IPV6:2a02:3100:a90d:e100:d8f1:2ffc:4f48:89fd? (dynamic-2a02-3100-a90d-e100-d8f1-2ffc-4f48-89fd.310.pool.telefonica.de. [2a02:3100:a90d:e100:d8f1:2ffc:4f48:89fd])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ab2c9649c5asm300385966b.183.2025.01.11.12.29.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jan 2025 12:29:25 -0800 (PST)
Message-ID: <4f59387a-a164-486d-a8a6-2ec88c7482b0@gmail.com>
Date: Sat, 11 Jan 2025 21:29:24 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v2 05/10] net: phy: move definition of phy_is_started
 before phy_disable_eee_mode
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <90b3fbda-1cb7-4072-912c-b03bf542dcdb@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <90b3fbda-1cb7-4072-912c-b03bf542dcdb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

In preparation of a follow-up patch, move phy_is_started() to before
phy_disable_eee_mode().

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 include/linux/phy.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index 7138bb074..ad71d3a3b 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1318,22 +1318,22 @@ void of_set_phy_timing_role(struct phy_device *phydev);
 int phy_speed_down_core(struct phy_device *phydev);
 
 /**
- * phy_disable_eee_mode - Don't advertise an EEE mode.
+ * phy_is_started - Convenience function to check whether PHY is started
  * @phydev: The phy_device struct
- * @link_mode: The EEE mode to be disabled
  */
-static inline void phy_disable_eee_mode(struct phy_device *phydev, u32 link_mode)
+static inline bool phy_is_started(struct phy_device *phydev)
 {
-	linkmode_set_bit(link_mode, phydev->eee_disabled_modes);
+	return phydev->state >= PHY_UP;
 }
 
 /**
- * phy_is_started - Convenience function to check whether PHY is started
+ * phy_disable_eee_mode - Don't advertise an EEE mode.
  * @phydev: The phy_device struct
+ * @link_mode: The EEE mode to be disabled
  */
-static inline bool phy_is_started(struct phy_device *phydev)
+static inline void phy_disable_eee_mode(struct phy_device *phydev, u32 link_mode)
 {
-	return phydev->state >= PHY_UP;
+	linkmode_set_bit(link_mode, phydev->eee_disabled_modes);
 }
 
 void phy_resolve_aneg_pause(struct phy_device *phydev);
-- 
2.47.1



