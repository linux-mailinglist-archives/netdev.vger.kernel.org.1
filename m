Return-Path: <netdev+bounces-231815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 66825BFDCA9
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 20:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 54F964E9354
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 18:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5158B26ED3B;
	Wed, 22 Oct 2025 18:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DD5PtZxK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38352D6E78
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 18:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761156853; cv=none; b=AYviQJhGfxhCQ/suaZKH/Rbo8umqkdkGJDo52h38XJqavBTIv63CpaclL0TF9NJ2PPq0b2UYpVgmay/9BIASWl5YGVe50vnfIIn6pFUzsFuwtFzUlONRNphQp0LblOtg+CGyhtcrIzgTUAtInD5MYMvrTXt2oicrJF9yO/sAICQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761156853; c=relaxed/simple;
	bh=N/BgZJtqNkpzFldw/3kGEGU4tBVEydldaT3hqKRO25c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZFezTYYtnI6bJXqzuKJck+uW3pneSK+A0nlDwGGs77s7E1J6CX5UpjvMByh6/QH6yxppoejVR3Pc6mRZHv71KSYy+kHq5fu8bcDw5yqAlQvjXuvB/FmilddpgN7HUXebE8PHy9mUKVkgLBMIO+WOSk4eO057PlwHdUvIIs+mJpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DD5PtZxK; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-78f3bfe3f69so6341885b3a.2
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 11:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761156851; x=1761761651; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z2kFn+Q9bHJC3Z5Ojn03a1WB7AFdkKhdOTMatKkfbRQ=;
        b=DD5PtZxKln2l/fa2iRnl133HXl3WetzopKGeihmjGxdXEyu9+yFYSmmUuovEcwv6xh
         jMrh/dwLthF/LKZNVWthDvgDrml3i7blvVhch8q21LQFe9hCFo7/MTvJrS/QXDHlGxB4
         2MsfsFcgpeLy7/DDxKUe+LhYMPewHTqNflMUtFGEybxzQ5bObmxqpRfPHVtsP8WxkuHP
         MYh7Gbj7qK6849E+/u3aLLEYip4U7FFN/kPx/tmDXRaDwogRt5N6RKYNTnY3AT3n5j6K
         c1bKquPEdFmJ1D5IpHAc9QgOPKhERL/Ps/yrmYstW1X7IU9ihR7wfGUgKFOmyc3oZyR+
         IedQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761156851; x=1761761651;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2kFn+Q9bHJC3Z5Ojn03a1WB7AFdkKhdOTMatKkfbRQ=;
        b=QHO1QzemSfp8SlJ1MzNG8URgd20jnPC5M+8+ptwUT00lU4AAZ3PkCo6QI2McuO6N3Y
         Wit2r0gElRSAMKcWdpLvRPBji6DyPtdaQBTdczY854TkMT31u4AOjWkOLk+4vqOiwdyK
         SiDFEUSVgfK27K/Koko8BhkIs8Zmwmh/7Hlg0e9omz9Yz4FnnB30VxGji0YSsBXtiIKH
         ebktu5fvQ3ldJnmzLw3PHbFkmSnnnF+TYnMiKVT+6mVbBVCpNaZrbMlZ37P6O7r/4fQI
         5AcEzw6Khek5f3GwJvz6u68TgVDY7OG8NGOXI1VelYE3wsYjiqjogLPVn8L0KE6qW5A1
         lnZw==
X-Forwarded-Encrypted: i=1; AJvYcCWSNlGxKPRnYKc78Snf5hTtFJhmMdiCiSBRIMeXiPcKesbzfoH02f73bLqG+kLBVJu9uHXGR2E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2VLDi7dxAWqPXOTjIatlBsatpEtLikKJA2Rx9RI/m/pu+CqUR
	1EAe6FM6i196yIm9aZmj+xt1KToU1uSAqT3JTDXXKKWcSd5ht1EI026H
X-Gm-Gg: ASbGncs6A2G1u7qYqnYbxJwKKtZvu6RpN9Lc0JKKDVB+8Gmcsx320KHnJbP4cRJ4ppG
	kFssrcZkS8E3YjmCF8OYOVp6VrK9jrQMRUA+tJCuNlav49ocIGis1FQaejeWTU8r4WSXxtjjs6K
	N3lqILo0wZYZlIpMgJnxoQMvMZ3EpIb2W+wrgbpcATi1cklHVcRMGqwjq7TeTHXPTSMBOyXBYJ+
	VtUrvf7w5gAVtaesKprWLed/33glfBj5gk0xOHXckGlMtgzOZx0rWx938k5NkvhkvWBk8Mlz8uO
	cgkIV97/hmOSjKWRVkxjwCYsCjn993hnXDs9sNYG+VdOxwClTa+CVvJUthQSQ6CdAuCcMABTaoc
	SxSCoVIJMn7xswjbUpb6gZHzRnYAB4F+8A3H/gljZgpFUANYEf7qA0NmeAIe0xND4MwPIkZnHwq
	M4x834OA36IsHBr13CLiIB9Q+9I10=
X-Google-Smtp-Source: AGHT+IF2Mft5qBX8wVUVoHYsw+dNzDnWTlX/e+wgKxFPHsJD8mgW5lDVoEORt0wiViK+vK7wTKEhow==
X-Received: by 2002:a05:6a20:939d:b0:334:8e2e:2c55 with SMTP id adf61e73a8af0-334a8525dadmr26726146637.18.1761156851043;
        Wed, 22 Oct 2025 11:14:11 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a834de75bsm11192507a12.12.2025.10.22.11.14.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 11:14:09 -0700 (PDT)
Message-ID: <432ac9c4-845d-4fe4-84fb-1b2407b88b3f@gmail.com>
Date: Wed, 22 Oct 2025 11:14:08 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/6] net: phy: add phy_may_wakeup()
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
References: <aPIwqo9mCEOb7ZQu@shell.armlinux.org.uk>
 <E1v9jCO-0000000B2O4-1L3V@rmk-PC.armlinux.org.uk>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <E1v9jCO-0000000B2O4-1L3V@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/17/25 05:04, Russell King (Oracle) wrote:
> Add phy_may_wakeup() which uses the driver model's device_may_wakeup()
> when the PHY driver has marked the device as wakeup capable in the
> driver model, otherwise use phy_drv_wol_enabled().
> 
> Replace the sites that used to call phy_drv_wol_enabled() with this
> as checking the driver model will be more efficient than checking the
> WoL state.
> 
> Export phy_may_wakeup() so that phylink can use it.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

