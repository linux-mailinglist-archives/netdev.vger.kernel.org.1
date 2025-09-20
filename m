Return-Path: <netdev+bounces-225013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3737BB8D19F
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 23:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E06B37C1F75
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 21:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0636D27B320;
	Sat, 20 Sep 2025 21:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7AawVBv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3B92749C7
	for <netdev@vger.kernel.org>; Sat, 20 Sep 2025 21:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758404053; cv=none; b=S/41WYUPji1wC+GWRuXi37hgmpWaThUP8gNljtZC9HPXX5phq/xEaNJyDJ3nfgKIc4vCYU685kMXJd6E0pRPgce8Pa8KTV1tuJs8NVlPuGKzRAmgIVVjE6u5XHu8Zyi9ezBixlOWIBnZTmcW1SDIQ97Ugvk3TdFEkz5rfwWcwhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758404053; c=relaxed/simple;
	bh=XYj9MZfsulWE92LraNOhmKOKvv43pfo7IEftxw4of5c=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=UgzH9kjmB9n2c1+rNL/TZRKUIsMcuLSRoUHOaR27cLT4hqPG+6DoEovuv3j4zEAh8epDbUP7FeLAJBgGYBn/Fu05kW7nIXGgb+XKzW8d3vpGMdyKl9zpQb9N4pxbMRpRjJw6vXQ0H4lxPqHPoSLj7sXRdwk19cXSqGRI2wq2KSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f7AawVBv; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45dd513f4ecso22810945e9.3
        for <netdev@vger.kernel.org>; Sat, 20 Sep 2025 14:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758404050; x=1759008850; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=f98FfYQXYU5KM1aMGGSGJSxB2TL9+Nka7u8U+SiTAlc=;
        b=f7AawVBvVQOhZ6mTAzbTtWzdMMna9Ylw5OBLSAxuhad9syTkR7CDfHPQJYZHrL5FDu
         oNfGZGJXwm8ruZRk/6Gms1DQR7rTKXGYLMKhoONCeIDrz3eWLEnN1Snl65r0NyHIUfUU
         3GDUVCuPBE77w6B8PMBU/01aw3+W3Mw6vKNaP9jpFRb6Z/FRQrQT12MBiZRiFYBZf50+
         cRf/le1aa0ogSTj/IJAber6mTm5/vgrXaMNmDZJezgyEK+17pM9AZNh/ICtRPs4TCDsB
         Qeoo9cvqvUMqBQhvbFKrJzS/wPMuvuYq1wkHrbNBEsbCP2v3vKtffdGXnR/nVQVvzeL5
         mKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758404050; x=1759008850;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f98FfYQXYU5KM1aMGGSGJSxB2TL9+Nka7u8U+SiTAlc=;
        b=jBiege+hfIQ/rp6cNuiBDuF1VyMR6FKAXHmAJqD8+S0cHi56useTMtk/KybTItUkHj
         qeBIFXqRWyTCkXFl1nALTKE1ZKiahmm94NTS+TeAqehlcrsCyg+jaUWQqSGynhTlPtvc
         /5h3EF23uc/9Bw5gNYdCcphNa9SztmUJnVwqeRnaxgeq5T3VK2Khz7W4NpywSOC2sDt7
         P/Z2aFLYGifO2ciTK31jyGMVv3isSeNpDoKjPXtUxCdeShbanHY5JgiQptXLVqc/hdT/
         FK1YVDsh5OJJHrsJ96nYyt2Vj0WrPir8rsp/az+FO3CT4+MIrGmKcnBtLSLxjbrQfbLi
         gBwQ==
X-Gm-Message-State: AOJu0Yy4H8/qQykQBZXKfxfT5G2NyoZN7WSgnR1qU1QsKLJZ3Snxz1sP
	wutE14ReFM2IZ74FbObKXGfTF8IH50fSL/IptHDSyizhBz83hfLWN8HW
X-Gm-Gg: ASbGncu+le9bgdC/Zi02gvfE6AXv61C5mSQKAYnFBVrKJHMa3rWkpPEakQI8E6YR8GH
	xLU5JbaOF1P5BG85KuP/NprS/soMiPOqLnInWEsmhGMG0MlblvGKzjnFMOLLemaU8do7Ps4pmFB
	VJzmAVWqzHCQrWnOYhFYLwdVuZctk3skwTXFe3vEVgtqUvhxifjzdYEdPVcgpF1sJRc+JHZRqmr
	MmjSs5Ojl1r9t2KsId6OHoIbqYe4vLYhHNgzm00WPmVNXdbDHUsv8Lnqq8bSoD43cO0ojOlbGqk
	UDfLe8Nl8tee+bcwKRjwR7yfChokjSFOyyoZNaLAX2iHFJKJnSBBYSHAdOhOkH/AEKHAYk3xaDZ
	MxQm9vdebafrUJPH4zoOl2Wqp5W0gX5RPWhP2KTC5AsP3EaZoUCvQpirVT4mRaE/YdwbnqVx4h0
	gFTVMJSqUx9ZEpvg6gemWy4A1nEUmzNbkOxY3SfXRE81hUUa6PAG1luF8IO9I=
X-Google-Smtp-Source: AGHT+IEjLVVdSRiHF8r0wPgbdIw4pCekzL6rLTJrbzihdiXhEmgK/bU6g8OibKorMOBzzm7Om+12bw==
X-Received: by 2002:a05:600c:a4c:b0:45f:2cd5:5086 with SMTP id 5b1f17b1804b1-467ebe9d9ffmr78902325e9.3.1758404050524;
        Sat, 20 Sep 2025 14:34:10 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f30:a300:65ae:147:ed4c:62d8? (p200300ea8f30a30065ae0147ed4c62d8.dip0.t-ipconnect.de. [2003:ea:8f30:a300:65ae:147:ed4c:62d8])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3ef166e62e5sm8470574f8f.40.2025.09.20.14.34.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Sep 2025 14:34:09 -0700 (PDT)
Message-ID: <dff44b83-4a85-4fff-bf6b-f12efd97b56e@gmail.com>
Date: Sat, 20 Sep 2025 23:34:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 2/2] net: phy: stop exporting phy_driver_register
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <b86c2ecc-41f6-4f7f-85db-b7fa684d1fb7@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <b86c2ecc-41f6-4f7f-85db-b7fa684d1fb7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

phy_driver_register() isn't used outside phy_device.c any longer,
so we can stop exporting it.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/phy_device.c | 4 ++--
 include/linux/phy.h          | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index c82c19971..01269b865 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3544,7 +3544,8 @@ static int phy_remove(struct device *dev)
  * @new_driver: new phy_driver to register
  * @owner: module owning this PHY
  */
-int phy_driver_register(struct phy_driver *new_driver, struct module *owner)
+static int phy_driver_register(struct phy_driver *new_driver,
+			       struct module *owner)
 {
 	int retval;
 
@@ -3587,7 +3588,6 @@ int phy_driver_register(struct phy_driver *new_driver, struct module *owner)
 
 	return 0;
 }
-EXPORT_SYMBOL(phy_driver_register);
 
 int phy_drivers_register(struct phy_driver *new_driver, int n,
 			 struct module *owner)
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 7da9e1947..bae34e7c6 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2027,7 +2027,6 @@ static inline int phy_read_status(struct phy_device *phydev)
 
 void phy_driver_unregister(struct phy_driver *drv);
 void phy_drivers_unregister(struct phy_driver *drv, int n);
-int phy_driver_register(struct phy_driver *new_driver, struct module *owner);
 int phy_drivers_register(struct phy_driver *new_driver, int n,
 			 struct module *owner);
 void phy_error(struct phy_device *phydev);
-- 
2.51.0



