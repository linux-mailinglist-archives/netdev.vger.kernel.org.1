Return-Path: <netdev+bounces-166826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87755A377B7
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 22:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 543153A6C03
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 21:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2508A1A2557;
	Sun, 16 Feb 2025 21:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/IdKGvg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54369433D1
	for <netdev@vger.kernel.org>; Sun, 16 Feb 2025 21:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739740508; cv=none; b=XbTAHhqKbDBbKsMOJtO/wcZ41uqZkcnWgxUN9qt0wqJ6aD9RELdMbKPwPrwkniS8ABGZr7ZpuDFmGH8rP/hHJxuHye861u99kF2bEcPCFWhxnvdKSYm0yeYMOKO0YJeCqhAQSrRdp0sbrkwIxlrqpjR5gmG/liqGBHQ83qZtbHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739740508; c=relaxed/simple;
	bh=jPeX9p344IoX6dxmWwhjCWmIixTYDHVJP1T0PIm0xZo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=V6Lc3jVXtx5skAKdlm2Oo+qyK6fF/u4m8th8krUuPldiVvgIT84LOcfL2ZWb7UjkmZL9Q6rP9yARytxaIZ1eNRLoKFWEIBRrA8MBpPbP569wXhceXQ5tWtqNPbybyu3VgrhZl3bmpxtLRGYSqX97TW2IuFm4qzIkvEOvfUSlURA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/IdKGvg; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4395b367329so22752665e9.3
        for <netdev@vger.kernel.org>; Sun, 16 Feb 2025 13:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739740504; x=1740345304; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ah1/ABujv0hHMeI4NVypuU5Gt7sfMnaXyFY/a+EGQI4=;
        b=B/IdKGvglZqC5kEwN1G9yAT6medbTJClTno2LwMguQSFVNXyQhXxGihHtoT0f+8sNQ
         3YQmlOGRuisCdv386vYC068w4TMf7TpcxrbQlIxk4PCFK7pkdxEYYexm41lf78AsrzpE
         Oi8mgjXnvMmBX1AQ+WTPUByFrO2uyZRfYjZ09DwnFi41uvt5fkVB7IOX+wJHG++fd+n5
         zuoYEfYkxia5foEBNY4o9KeZ9PYqGLfG/q+ovZ7DC9/3E5H/HMoo2d7DBctWHXTPVnz7
         d2mL9PLOBuQg2KmXtZ+q7fLrvMouQfOZyhn3qVqT5ZvwrNmuXymW3PBZgj+lh0opAhwc
         bPMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739740504; x=1740345304;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ah1/ABujv0hHMeI4NVypuU5Gt7sfMnaXyFY/a+EGQI4=;
        b=RETyVMdX5GZ8ve5vwHbQvNdUs2Wv4BOrZbEWLE79aShOrcLBKDHfZYSrqMWP61ldOa
         X23wd6lmA9rLNDIk2FDOs5Jz2OZVw9ZbQ7mpdRx97DS4R9fIrFEXPnPTID00V7DI/qYs
         GT2S1wiCQO7eMqr9EQqaQlf72cikR1SpBq7Kwlw0/ued/SFUw7xcsibqHTElAhzxfOfI
         qAipNG2ZI6vmSRzepAxEWwFAHtsculofQozkG5oz1c2gFLPXdocvF4xquft3/0cIp+B7
         HqPOmAT9ECt+YXRDBUAwnvk/st3V5Nw5unies/iUWkHVvXe1R6UiFPjS1N6FMtDTs6pD
         6OHQ==
X-Gm-Message-State: AOJu0YxSDh/0c5JBnMFcspBENfZxOrohmp5M9PXAtqV5/w0MD2VLtI6i
	JvGHl1CTsHWWGL4A2NGSCigv0pNctVwV9OSqfbE5gX2v54cSzS+v
X-Gm-Gg: ASbGncvs3hLu4xSxzyiimfsicoMUrJeHl/5rgnClws9efTElVaY0SI2Nnx1jIYQfMI1
	vWwUSBy+iIJy+dh0WBzm5XRrsemwSpao4IQbBDdTYDFdwxSE+PBfPr1I4Gtaunao3RtXAC828y8
	UD8IPiIsxj8ij2CgIE4dWQwiy0jXxQIxHF3gt6aS3bTMmy0jfmRoAFCYf4dH91+I6HpMfhZLjjd
	w4RH9IWc8M2ZDC41eKarIZuJ2mFA80tkGG/umvyK02Pz9GD40Bqmgtc2GefRpdCeLycthp54aXM
	S1zuzGpaFAuSXUGxFaHDmETpEmV14AnD/xIkHwnnOBeYwlRZ9fWfsSCHr6a7gUSsdC/sXjy+xdf
	ueBQxmqS+WZuvAv+1N6f/ADJxCRTpLqu9MMx01cRLweddY6qCOnBdZtbhvfNN9jhA0JIah4sddd
	Ikj9OeSIw=
X-Google-Smtp-Source: AGHT+IHx0ok5S1d7+8pOfIVJSQD8CY0TYHszZw/mYTq0+ZDrroe+gjfChjPbcHUOWYrs8+f8uIgJ6A==
X-Received: by 2002:a05:600c:5247:b0:439:574c:bf76 with SMTP id 5b1f17b1804b1-4396e6e9c2dmr64836575e9.7.1739740504402;
        Sun, 16 Feb 2025 13:15:04 -0800 (PST)
Received: from ?IPV6:2a02:3100:a14d:c000:1d06:77f1:27f3:ba49? (dynamic-2a02-3100-a14d-c000-1d06-77f1-27f3-ba49.310.pool.telefonica.de. [2a02:3100:a14d:c000:1d06:77f1:27f3:ba49])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43984dd042fsm10070855e9.12.2025.02.16.13.15.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2025 13:15:03 -0800 (PST)
Message-ID: <04d1e7a5-f4c0-42ab-8fa4-88ad26b74813@gmail.com>
Date: Sun, 16 Feb 2025 22:15:42 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 1/6] net: phy: move definition of phy_is_started
 before phy_disable_eee_mode
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

In preparation of a follow-up patch, move phy_is_started() to before
phy_disable_eee_mode().

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 include/linux/phy.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index 8efbf62d8..481f8e21f 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1330,22 +1330,22 @@ void of_set_phy_timing_role(struct phy_device *phydev);
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
2.48.1



