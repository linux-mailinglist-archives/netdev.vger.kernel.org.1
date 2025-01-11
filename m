Return-Path: <netdev+bounces-157464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C95A0A5FB
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 21:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D4F61889A78
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 20:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2761B85EB;
	Sat, 11 Jan 2025 20:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHBsLxX+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B8E1B6D0A
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 20:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736628515; cv=none; b=ZkEEjr8JnN4HT7vXb7tjfEseNCZhWX+ub0mSghZh1+BC4ciEuODy/zjNiKYYXUqrGMvCEhVK6oqA/aWq0yL7QzBL6Amd7Fm8mXWpqvQMS4obqBKBgIzW6xkvqlQF6mbtNJjhXyeAtzjlkw8ERjmaUV4LdVdwrSs7dvxqBAVLcbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736628515; c=relaxed/simple;
	bh=oBk1vzueyC3qa+l1PtrbPoaM2us3+XwQPhok34C7YfU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=Q0GyNw3mUExoVlmiQoMsNr9DYD7Mwxg3K/zsx3uOKCIJxnOcY2XlnS0MFONxDh+rBIEgSVVlGZDZ03TaTMQ8seAj9qtyUuw2SDeJ7bW4MCY63S2w1ANt3g5inXfVMKsftkZy6t7I9348qQ2UgKr4csoEdsiQIrJuO4dN3F1UDmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NHBsLxX+; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43621d27adeso22191385e9.2
        for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 12:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736628512; x=1737233312; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YTvie0bsvCeZd7cKWMzWigy8IxfDSjJ7mj56cDkqXZw=;
        b=NHBsLxX+g2EPh64PbdwwiLqfDX/9aSSja5d6gd3QNuvqne6CxsF6OfCyoA8PeSJXsh
         IHpEBz27pHO1EdBjJ9wy8K0kVUJsX6mcSWfzVsd0spSZmyjXJmY1BwNoVB8lySJ9iWgL
         OaYLNuWFPgX+1hEYnbiJrd6q1FDLKjjeXWeDs+brBSlEGhicO4FAzUyQSi0GicfO5lHR
         JcLsqQSpG3OTVaA0mJrFgQvsvH8UeYmTPzM51TihoukBiypLSMnlqRV/L0ogqONWziyz
         06sFbqYPN3ibuhrxk4sWbnIoCUNqkJ3YBltzkRzvsNJhp8vR8jfd1BdBtyDJfkPJG1CO
         P0vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736628512; x=1737233312;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YTvie0bsvCeZd7cKWMzWigy8IxfDSjJ7mj56cDkqXZw=;
        b=ODzzgL8wfY6F2V8dVl4ZYmpwylEIqxqyahRyllvCRoaYlbj/WHULEMN2ObaIPeJfoa
         lbnzaRbmUVlG0zgnrdsSBC/IBmxT4+sKYMcIUzu2tZKcvJwBKn4+Ul3rSb8KMYyo/M5T
         RhuIHdwhxGJTMrCRdjMRlSuBeztYEVCCciBRMC0UVBK8Ln47KA+9ZsiXSek4RjsZ6orc
         yTmXN+nRsjSghFPyC8jPj55mxj9kG0h/JslbmDIBe7BNh+yn4lhKJjsMZ5zZvoSVeoKK
         cDm8Stjbwicyd9djUdKNJ47GnBxnxj2QadfAQQ61MVw4TWf1sw+R7vAGNn8MxV7AHCs+
         reyA==
X-Gm-Message-State: AOJu0YyKMETts8/qtJylB4JntXxTrZJslK620CZtagv90PTtiEUSqMP6
	fYddpQhWTFGLvh6+UMVTY+IQsDnOY337jo3Uyvxq1qNdx+kKcauy
X-Gm-Gg: ASbGnctyN8ecLyrTxpuDS312LfHZgd8C6Nybad3HM/Ju3Df5S0RnxmBBaIZH4uBcP/h
	8Xih0Ld8YYKw23wBzFTMqo6VxPKBMgTIA8lWx1Fph/mH/DJBezaTf21vVc1c0DAO7U6UfhZW7NG
	0qpuOzyweR+bNqoMI/kAdDuRTbXqaYabl+wZIURbIsk5y6TGaOXZyJibDOUIQzobKbSLmkSn5vl
	qzUu02RDVDSgFNweOf3eKW+IG0GxGTKAc2CDUGDvsjtwakwDt1Zaa7nyGSPrZy1tlrkTOmFPFG5
	R7W68qIm2SxzppUCi6+o6duP0mKaeCx8fs1js2ACGpeBpY8IPL6ZH/xQmXd+y3pBT95Zz7ZevKC
	EcCfuB91oFNarkbkDSHdFCnraZ4ebKE2Q3JAuy96KpIOSHZTw
X-Google-Smtp-Source: AGHT+IH48G1KPn18GbssQonmgTkKAjRM0hSKXJUAbYPqEVVOfnbA4D7Q8NxaKmOZG3Q284E4PDptyw==
X-Received: by 2002:a05:600c:468f:b0:431:52f5:f48d with SMTP id 5b1f17b1804b1-436e26ebe46mr147739625e9.31.1736628511626;
        Sat, 11 Jan 2025 12:48:31 -0800 (PST)
Received: from ?IPV6:2a02:3100:a90d:e100:d8f1:2ffc:4f48:89fd? (dynamic-2a02-3100-a90d-e100-d8f1-2ffc-4f48-89fd.310.pool.telefonica.de. [2a02:3100:a90d:e100:d8f1:2ffc:4f48:89fd])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-436e2dc0069sm128129625e9.11.2025.01.11.12.48.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jan 2025 12:48:30 -0800 (PST)
Message-ID: <7319d8f9-2d6f-4522-92e8-a8a4990042fb@gmail.com>
Date: Sat, 11 Jan 2025 21:48:29 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next v2 0/3] net: phy: realtek: add hwmon support
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This adds hwmon support for the temperature sensor on RTL822x.
It's available on the standalone versions of the PHY's, and on the
internal PHY's of RTL8125B(P)/RTL8125D/RTL8126.

v2:
- patch 2: move Realtek PHY driver to its own subdirectory
- patch 3: remove alarm attribute

Heiner Kallweit (3):
  net: phy: realtek: add support for reading MDIO_MMD_VEND2 regs on
    RTL8125/RTL8126
  net: phy: move realtek PHY driver to its own subdirectory
  net: phy: realtek: add hwmon support for temp sensor on RTL822x

 drivers/net/phy/Kconfig                       |  5 +-
 drivers/net/phy/Makefile                      |  2 +-
 drivers/net/phy/realtek/Kconfig               | 11 +++
 drivers/net/phy/realtek/Makefile              |  4 +
 drivers/net/phy/realtek/realtek.h             | 10 +++
 drivers/net/phy/realtek/realtek_hwmon.c       | 79 +++++++++++++++++++
 .../phy/{realtek.c => realtek/realtek_main.c} | 24 +++++-
 7 files changed, 128 insertions(+), 7 deletions(-)
 create mode 100644 drivers/net/phy/realtek/Kconfig
 create mode 100644 drivers/net/phy/realtek/Makefile
 create mode 100644 drivers/net/phy/realtek/realtek.h
 create mode 100644 drivers/net/phy/realtek/realtek_hwmon.c
 rename drivers/net/phy/{realtek.c => realtek/realtek_main.c} (98%)

-- 
2.47.1


