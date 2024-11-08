Return-Path: <netdev+bounces-143215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1BC9C16C4
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 08:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 903EC1C20DD5
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 07:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75F31D043C;
	Fri,  8 Nov 2024 07:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhe7x63I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E54DDA8
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 07:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731049637; cv=none; b=E3HiTux7/L8suX1doUGQvb/j/jT598N/+WXdfqDdY6m/UNUPon44BvzkLK99kRMuU0QrZAYwfd5LGCzGeVQRrFICD7A5i1qn0Ld9snn6pm11sNsdIP0yOwthhmAT3Ht+DkrlGv+sYj+5uTl7hT7VtmMKoSHU2eVeRrLvka/K0dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731049637; c=relaxed/simple;
	bh=eTld1C64A8kzDhCWEWh4XrCvq/Mllj6nrWvQATHh5XI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kGztcX9vCaatCvpRnhr2TVdqH8fIhIDkr71onTduSubWomzxivR9lMXAhmxGMUcMUjlZcVhxVgmh/ES+vsh3PY786gqc7G6S+ouvdEYjMTCu/ikmHYF4mAXQvNcu4N+Di6ay/S+VmcnTTis9PTa3MxMnYNxXKi2wUwUQVntlGC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hhe7x63I; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4315baec69eso16319855e9.2
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 23:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731049634; x=1731654434; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=R+7VU+QGMOhfOlsv4FF1t/0rHeJ37hUMWHfqUV8OuSI=;
        b=hhe7x63IpRuG24Uygfsd6VLK2Ek+6EhxFLHp9EV07vlXwcUOP1qGEGQXnwRwGg+7vg
         GYDxnemvCFgPKIpGiPwO9OqZbQzWgYuuWkyExI2eMFySlT4c6d5L6y5yZ0b/5YlFC+ud
         ZXLkU2WwL3oRPBCJiRx24pbOIakyZE/9gB7LwBR+rw5NRDxLFBt6+DqBH9Nc4gCLL0bn
         bVJ8RY3BnQ4yO8GPur0uOT9IeeKZ7lDeNpHv+O1vzqC5HR0vTc/FVzs8lQz6w3eqYsfu
         swM0ToYnOgrcYah5XMmj1KcBo7pFjKw9Lbq1IabA1JIHlP/GKyc06CpoANaq30pL2cPZ
         pqJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731049634; x=1731654434;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R+7VU+QGMOhfOlsv4FF1t/0rHeJ37hUMWHfqUV8OuSI=;
        b=KbwAXiNX1J9Q+J5Ed1SURwzGz6iH1t6MvU2ZtfL3c9GOgU5GVAjIgUpfCThZ5wCwU3
         NC6gjp/pRA09IBV0Dksj8eL6yPHypZThnuJyk4WPBvb4XWqtBA/dfphOlYLld/JOOd/6
         ijX3VuoeaZSgQ3WGsDDGeO2Ks4JfWqLBhKgrLxT06P+qdBOcwSy+kdCxycjiJUfpMeu2
         36E9busdOQmfFfZYR6jiutPpzfqHTFd4lYcX5Ro9ac0FqeY2s1i0JKPQ6KmU4TW6ewBe
         WXhbvukD1P2fJsuXJU0Nq2ey47PCHm7lgaFcoPIRUsYWDYoJFTj1I0602ZliI4GTz0+h
         xdBg==
X-Gm-Message-State: AOJu0YwrBgYp+yVV+iaGMMLkRN8EfUDKotNZk/4l9pZblPVcmrVmsLE4
	2uUZ/+ecUNFaQXxo3EPVDu0KAZhkPCrYBF9tZGe75mXk5Ti0M2Nl
X-Google-Smtp-Source: AGHT+IFYyVNiZYEf4ESzZ3NKGt4eMIk6ZFz+R85WrF/eMDU/QnOSCkTHZDF0BsQHFSPhrq2bcswRyw==
X-Received: by 2002:a05:600c:4e8d:b0:431:57e5:b251 with SMTP id 5b1f17b1804b1-432b751cf06mr10905705e9.28.1731049631769;
        Thu, 07 Nov 2024 23:07:11 -0800 (PST)
Received: from ?IPV6:2a02:3100:a8c7:1100:21c3:489d:8064:fe8b? (dynamic-2a02-3100-a8c7-1100-21c3-489d-8064-fe8b.310.pool.telefonica.de. [2a02:3100:a8c7:1100:21c3:489d:8064:fe8b])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-432aa73a2d8sm86248215e9.41.2024.11.07.23.07.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 23:07:10 -0800 (PST)
Message-ID: <0f8ee279-d40d-4489-a3b0-d993472d744a@gmail.com>
Date: Fri, 8 Nov 2024 08:07:10 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 2/3] net: phy: add phy_set_eee_broken
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <405734c5-0ed4-40e4-9ac9-91084b9536d6@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <405734c5-0ed4-40e4-9ac9-91084b9536d6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Add an accessor for eee_broken_modes, so that drivers
don't have to deal with phylib internals.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 include/linux/phy.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index e3b578afb..793d9945d 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1263,6 +1263,16 @@ void of_set_phy_eee_broken(struct phy_device *phydev);
 void of_set_phy_timing_role(struct phy_device *phydev);
 int phy_speed_down_core(struct phy_device *phydev);
 
+/**
+ * phy_set_eee_broken - Mark an EEE mode as broken so that it isn't advertised.
+ * @phydev: The phy_device struct
+ * @link_mode: The broken EEE mode
+ */
+static inline void phy_set_eee_broken(struct phy_device *phydev, u32 link_mode)
+{
+	linkmode_set_bit(link_mode, phydev->eee_broken_modes);
+}
+
 /**
  * phy_is_started - Convenience function to check whether PHY is started
  * @phydev: The phy_device struct
-- 
2.47.0



