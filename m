Return-Path: <netdev+bounces-148505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E319E1E96
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 15:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59B17164783
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 14:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FD81F4274;
	Tue,  3 Dec 2024 14:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="TvSfRQ0+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284D51EE004
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 14:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733234565; cv=none; b=nBwgS5pdM7efqnJMmWEMVJOyi0gGA33BhKmpnerkp6Riw2+bsMyZ1p2YwZyO4GLJSJVNVFwCyzlXwACT9mnZWAfqS12QW5fd+OnmmPId9VvnaZl7hml3Kx3b4Cfh0CpdceovhVFpiZ43x1mxTi9FsFfKhY725oXqib8Gmm3QoeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733234565; c=relaxed/simple;
	bh=JphR2ZL5jGAJVJAbP4vcv2rrT5CT9AGb1z3/ovzSqH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ozjdcu/5IZjHbCrsWeUdUtTSya7TwKkmcqKDVq8e7bbDH/MSqmo4ecesziF2JbZZKjE4mrdYJgxQbMRYbV9uVhgTPvOhyHuBeG7lnglgOFI9+ylIi3tfxF7StJzdSSLMYHMAjKxcKwBxovdcqlPPiwQ1fCqoGykyVEai/2OVxns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=TvSfRQ0+; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53e18b1baecso617203e87.3
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 06:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1733234561; x=1733839361; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JphR2ZL5jGAJVJAbP4vcv2rrT5CT9AGb1z3/ovzSqH8=;
        b=TvSfRQ0+K5Y3AnPKXaHSNHIwFpMSx7cXAuWn847/MJybR9lEHAXlh2bxja6dAGv8Cs
         7RCO/sNHejDP4GdP2GznHiCALSDyTeQ4DR0o9T1/VpcELJyHNORL1Adr7iD52DxpbA9N
         4qpFT+y8UAufvmuKD59yrDJm5P/Va7Gtv2nVK1gDLhiTfCgmCgmhasBNY1TvybWd0x7x
         B82KXU3264erw7q2c/IVbMWk9hWG3coqXGnru8esNmhpv6sOzV4QGSfZJQsY90E3ScBP
         GZ25C5/lmlrFcV1oFOZ4Rr1jS9lswCblPflyrr+fBoXjevsSKFTExfSxzpBc6tF37C0G
         M/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733234561; x=1733839361;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JphR2ZL5jGAJVJAbP4vcv2rrT5CT9AGb1z3/ovzSqH8=;
        b=cVyDT0vPUacPKMy4baKPAuavcmH9Ab3W2k39zWk3ejT7lSfW6rG2avGoHPptS7ii1G
         Ks/0UH2LPv8yuE/CpYydPp0kyewoPREAHKXk4cZtJQKFKOGQ7QesZ2ZhBOCuXxWO8C3D
         OhYM9J081rIX8CfF4fOmVi3ghlmQ+yoxUpeZYdOtU7nSEAy41/O+MhtHtjrJo2iJ6dIP
         3Lfd4hTfAr+1PU/w75+9Hv83fW6vrrW/3qExN1PJVsB7AzRYTQ9um3rz5Ln6jKPMQarG
         nVYC/OWIJj8d78Hg34cjZKl+R6Lf8wBsmpEnYB5IfmDyEiVzhyTjQmvcSSABgdNIPwU8
         y3dA==
X-Forwarded-Encrypted: i=1; AJvYcCXG3b9fS/74zc7bUpNF+Biu4K9Mp2jAhZaZy0qTHFMSOMeIJDqvDIbRzMKNp+qnj478hVladZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS8PUkAdAzXUIjzHfjGhvk0i5rOjo4BizKk0tmyWk1vB4tBuyH
	ITcJsbmLD6YM+N8flZcuZcPhfPF1OjDK3QUQffdzuAxVjbtRAwHv8vIrmrTjJbY=
X-Gm-Gg: ASbGncstlytxAtyZAf7v6lC05tYhfUo12MoECaQ74HssEg/9LEwD64rv30rvbEzDBZq
	WQ/QDRoB3g09qpCK7t3sizQRPxGM7HfhuMOhWm3EyOz1FY3Gca1UsF2x32rGUJPIJrzfRqPoeJe
	4vxg1bLbDLCLTA7gG8lzS69V//54AOFpcx8Ekh44y3D4k6JVvW2YpLPmcCNhRr+LsByD5C9mBk5
	lnO66XYqKDmiY0vS6SUqfArWyvwQZoOo8TbsQNs+EDkLCTVrkPgTL8u4O/m93W6DNZuVg==
X-Google-Smtp-Source: AGHT+IFthPhHBgWWTuy4bv5pfQrn/RUEg3HXOZPUVZODT11J6Bsy1x1LBHaM4rykKQzP6dyUiQP8EQ==
X-Received: by 2002:a05:6512:b97:b0:53d:e8f5:f98a with SMTP id 2adb3069b0e04-53e12a2612cmr1584431e87.46.1733234561059;
        Tue, 03 Dec 2024 06:02:41 -0800 (PST)
Received: from [192.168.0.104] ([91.198.101.25])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e19a2e7b9sm96883e87.172.2024.12.03.06.02.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 06:02:40 -0800 (PST)
Message-ID: <d47cd2a9-441a-47ea-b509-f00657dc5495@cogentembedded.com>
Date: Tue, 3 Dec 2024 19:02:38 +0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: phy: phy_ethtool_ksettings_set: Allow any supported
 speed
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Michael Dege <michael.dege@renesas.com>,
 Christian Mardmoeller <christian.mardmoeller@renesas.com>,
 Dennis Ostermann <dennis.ostermann@renesas.com>
References: <20241202083352.3865373-1-nikita.yoush@cogentembedded.com>
 <Z02GCGMOuiwZ4qvA@shell.armlinux.org.uk>
Content-Language: en-US, ru-RU
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
In-Reply-To: <Z02GCGMOuiwZ4qvA@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> Does IEEE 802.3 allow auto-negotiation to be turned off for speeds
> greater than 1Gbps?

Per 802.3-2022 ch, autoneg is optional:


| 125.2.4.3 Auto-Negotiation, type single differential-pair media
|
| Auto-Negotiation (Clause 98) may be used by 2.5GBASE-T1 and
| 5GBASE-T1 devices to detect the abilities (modes of operation)
| supported by the device at the other end of a link segment,
| determine common abilities, and configure for joint operation.
| Auto-Negotiation is performed upon link startup through the use
| of half-duplex differential Manchester encoding.
|
| The use of Clause 98 Auto-Negotiation is optional for 2.5GBASE-T1
| and 5GBASE-T1 PHYs.

