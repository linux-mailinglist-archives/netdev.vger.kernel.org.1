Return-Path: <netdev+bounces-68850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5154C84889E
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 20:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2A48285689
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 19:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4C25DF08;
	Sat,  3 Feb 2024 19:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EG9/+I/u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDE65EE80
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 19:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706989999; cv=none; b=NzyxN/mNH93gTy1ykWTihUWfhKHmBXmtPL2Bmn4Pe27l9KDwjbD+o1wYt36WoSZ/ruVw/PvevQ0AQNXI/3spciowxDFiTPtNMWmU2A8nm1ML2fDZ53ToIuXLYYk9rojB9RsMgR4vOkFAr51Ta5BrzlC2EC4+tfQK5IKqyFYatRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706989999; c=relaxed/simple;
	bh=cFNh/YPwBYZhQcvfIQvV6Srk2BsC5QizQQFLKLIqWoc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=HER/xZLJGZ3ZTqwn5o1IOZJCpvrovf+r7OYm9D2nIYwtrvGSLtjg2/qfEhVG+yQjrFSkPb9CTikKj/GFhYe+xZLx1AnPVkeARiF5v4tJES6UpAtA2R+FV1eXhESAtys7Yd3wVCBIFUMRkxKTsF4bxTIY/MbOeou/QCcPlPQ1H/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EG9/+I/u; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55a5e7fa471so4192524a12.1
        for <netdev@vger.kernel.org>; Sat, 03 Feb 2024 11:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706989996; x=1707594796; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LDrtPs/n1fwhF9j9xwT8zx9hz5ne3tb4JVnaJJXcRo4=;
        b=EG9/+I/ubm7uH5sgTa5rlfVsUtHIAoOfXvB0qufGRvXZJTV0vfcTygG6UvHdNKqSAa
         eIPnrGG0WaT4twvDFjpdXYZyMZOM+t1rLx0poO4CQGMHXMmcwj66CUUXWJ7NwiL8Sxp1
         ZfniwJNjUeWqrVf30kyXZ95K3w3js021UjXppAFERYy+igG/0SEXicRy5vaq1UBKHIOK
         0XOViyCErelpiP+9YQ/1YPUYmaWPnM5CzRjczwU481SNSinO2pLB3qx0OXu68b5gbcVE
         CEfOSUhZIP+UeJhTxPSWBigImiqfVwt09YGn3vJpntOZX2Wh9apAbysxSkGx6MDXDJKu
         YE0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706989996; x=1707594796;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LDrtPs/n1fwhF9j9xwT8zx9hz5ne3tb4JVnaJJXcRo4=;
        b=aeIj8AMFj6H3AYuxr0UZSYx68XJP+GiSwmsmgw0omo+iJUNbZnHDZbJ4vKjhom6shd
         1S+2AUqHFLvkRZrcf+zq14Nt+qxI40LEkQ2FNUqyzdygoPqbytguKfruE4ActU2SuerH
         fTKA2OPXST21/K3B06zTnUkHS4kMn3Mme12Y3ASWg8yKnmbZEzMlx7y2Y4R+tH3h+RnJ
         hMng9kpqq3AojpoSO7FwzImfFxGQUBvhCBoKsWkIOiPLxmIsF1T8vOPk5hsIlPPrup34
         L/km/NK9bVpfUGJccaJI156t8XUWx8e47YkeFXHJiPD9h112a3F2YHmC0wIEwWQDq01A
         cgcw==
X-Gm-Message-State: AOJu0Yw1uHFlQwd05HC1QukrBSMHpvO0h0gjbP+0wPYFbBDy34H5PUDa
	WbI/1DrJZwV0E9ilkKg6jH3zCPn00AaR+P4mXYlsqyzHr6FiSbul
X-Google-Smtp-Source: AGHT+IGl2dTKBDY/FqmpPVXaurAT+DpM1DC7h4+dh53Wlj69ZwKsqhBqAMO5UvyNpyz7gt4IR2qADg==
X-Received: by 2002:a05:6402:545:b0:55f:a1af:a1eb with SMTP id i5-20020a056402054500b0055fa1afa1ebmr1972625edx.23.1706989995962;
        Sat, 03 Feb 2024 11:53:15 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUK7lCKlQoDg9ody0De4LzTxSf+6hZHpn5irvF/2/PDUv9tFyTknziq9xc6wSI980b3CUShtuYRudHlZbNNBs8+9blTVZ+5EAcVC0Px0iicW4f9OTopzcbSmAT5oWkx0BdvWoIFppyiffrUbGMS3oSQuOcO9paKAPICMfjMwFvbJ/s3T6T36bpIjLkchpMfQfBu7hspsaLgHWaILo5IAjnBmWwnRs89X+Nt
Received: from ?IPV6:2a01:c23:bde4:a000:48dd:a4bf:88d3:e6ac? (dynamic-2a01-0c23-bde4-a000-48dd-a4bf-88d3-e6ac.c23.pool.telefonica.de. [2a01:c23:bde4:a000:48dd:a4bf:88d3:e6ac])
        by smtp.googlemail.com with ESMTPSA id n22-20020a05640204d600b0055f50417843sm2039152edw.22.2024.02.03.11.53.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Feb 2024 11:53:15 -0800 (PST)
Message-ID: <20bfc471-aeeb-4ae4-ba09-7d6d4be6b86a@gmail.com>
Date: Sat, 3 Feb 2024 20:53:15 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v2 1/2] net: phy: add helper phy_advertise_eee_all
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>,
 Realtek linux nic maintainers <nic_swsd@realtek.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <0d886510-b2b7-43f2-b8a6-fb770d97266d@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <0d886510-b2b7-43f2-b8a6-fb770d97266d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Per default phylib preserves the EEE advertising at the time of
phy probing. The EEE advertising can be changed from user space,
in addition this helper allows to set the EEE advertising to all
supported modes from drivers in kernel space.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- extend kernel doc description of new function
---
 drivers/net/phy/phy_device.c | 16 ++++++++++++++++
 include/linux/phy.h          |  1 +
 2 files changed, 17 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index dd778c7fd..dda5ece0d 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2769,6 +2769,22 @@ void phy_advertise_supported(struct phy_device *phydev)
 }
 EXPORT_SYMBOL(phy_advertise_supported);
 
+/**
+ * phy_advertise_eee_all - Advertise all supported EEE modes
+ * @phydev: target phy_device struct
+ *
+ * Description: Per default phylib preserves the EEE advertising at the time of
+ * phy probing, which might be a subset of the supported EEE modes. Use this
+ * function when all supported EEE modes should be advertised. This does not
+ * trigger auto-negotiation, so must be called before phy_start()/
+ * phylink_start() which will start auto-negotiation.
+ */
+void phy_advertise_eee_all(struct phy_device *phydev)
+{
+	linkmode_copy(phydev->advertising_eee, phydev->supported_eee);
+}
+EXPORT_SYMBOL_GPL(phy_advertise_eee_all);
+
 /**
  * phy_support_sym_pause - Enable support of symmetrical pause
  * @phydev: target phy_device struct
diff --git a/include/linux/phy.h b/include/linux/phy.h
index a66f07d3f..1343a4081 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1960,6 +1960,7 @@ int phy_get_rate_matching(struct phy_device *phydev,
 void phy_set_max_speed(struct phy_device *phydev, u32 max_speed);
 void phy_remove_link_mode(struct phy_device *phydev, u32 link_mode);
 void phy_advertise_supported(struct phy_device *phydev);
+void phy_advertise_eee_all(struct phy_device *phydev);
 void phy_support_sym_pause(struct phy_device *phydev);
 void phy_support_asym_pause(struct phy_device *phydev);
 void phy_set_sym_pause(struct phy_device *phydev, bool rx, bool tx,
-- 
2.43.0



