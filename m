Return-Path: <netdev+bounces-173367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A007AA58805
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 21:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 774AC168F38
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 20:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8CF1FF7CC;
	Sun,  9 Mar 2025 20:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PGRy8z82"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2FC1DF279
	for <netdev@vger.kernel.org>; Sun,  9 Mar 2025 20:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741550599; cv=none; b=Ijyb/9hOxiyj86pJ+tcchh9IDGeEYTBrHB1mZ5WEk/A4QVi4QB/T7kWbOzwIvF50mP4tD8NMSyr7/bt5QwCY1uEuzKopKPWLYFNOwDPGY2CHTjcMitVnlzWkv8s9W1dlHP/JEDnsamOIbbyC4l38f0KdQH1H8SM+RuoDGcMh3z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741550599; c=relaxed/simple;
	bh=uT+xfwLHQk5uheFDJlg5tv6cOVv4CbAFXLVX/VO7NvI=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=j9BZgfU7CUQdPMggeTkLwWS5cJMr/hd8hzTzItYQO+5X5JcnQVvNFyylv/IY9PoVXXrfaNVNbweZB86e3XAQE0oeSlAOXFNgnVduh5FECT74CWAyFbSddzfrSVOrWgSIgSKHgw9ea1vgZ3Kpeyqa5ZnhNz5/P6o/BWWjFm/O1J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PGRy8z82; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aaec61d0f65so721415566b.1
        for <netdev@vger.kernel.org>; Sun, 09 Mar 2025 13:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741550595; x=1742155395; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MK78NCwodh9OSm0OmcDNKYVeagWsw6NpPwP8Da6VxLo=;
        b=PGRy8z82ZZekK7ow6/ZLqP+oy4ahM+9jpcv1NSyhIKrOdObr58L3P29ksS5A15Xpz0
         OcgFQiRqoZ4LKyt68nFYiHY29D3X4nC2eGpq//XBXRBy8Bcv0usGOElEVV7V6rsWCCUJ
         hF7WPX5YOw/ibAc9UG+E8xzjhyF4FJBp0HZ+bHYyyplS+ck6NjRGYMbzHdCrbnh0HD0a
         TgD+jRfqSJoKUA98K/mt9Y8lGzFG10+HA5y8URkoY0Oo61m/dFEAf8RTB264mNrdZLnM
         IfFuJF+JWCJQAfVGAsixpsHDo9meJAzFVrMUigxVdVEAAc/E/bd0OFarDniWzXU/h84O
         SwZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741550595; x=1742155395;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MK78NCwodh9OSm0OmcDNKYVeagWsw6NpPwP8Da6VxLo=;
        b=pt8uS51iU0K2hrjWH9c7z2r4SONGCs3kwVZdsTNiaywfqI4TO+F5fgWl6nM2mZVBBv
         gDgR5eXl+8OABaEATDEsg6TVRk4iWBYkmdLC5ykSYptX/cCuY+lLY8jxpWHAoarHWT/v
         /CdmvMpZr5Ty6Lqc3FhhFS37p89k0bdXBaa9gr1m2eW2i/N7FEFirgvobQ5rvux/jUxu
         TOAAhb4shRohG4gYg1kzorxfk3GcWSo7N7rHYFyozPK7KzXEPsRl73MSKL8XI+uljo2J
         PvQRSx10rKa3Q/vm0cB/urgAUxjK9KQjlhU99Khot39LpkzUv0A+SYx0CtKviq6okx76
         PveA==
X-Gm-Message-State: AOJu0Yz/YNODuyAcIqLHIVMdLuBpUfzoh6yXc83wixfTZ6LVVEc61Pn2
	EFIhUq7yThwc9DZsbKMKwofZnxAL64GyZOas4eJeeHS1LcxrPspv
X-Gm-Gg: ASbGncsh0D+iZr3qc8kwgsJ8W9mJDb5O9MF1GEsE+oR4HHEMkU9dEj+3McUjew9lE/v
	H4qPjSsuBuY4y4q/7S7i3f+KKKHoftfCDBa2lBWm8q6hFqOore5ttaJutvi5DkzgD8YPxFp0Hol
	QOewvzfhwAM/1K7YfDwumaWGNq1Je6+xEEw7HkSxnDsi1q6ZQTFaAy36uE9Irsf0zhhQ2TJWoWW
	ezzt07BBbG7ClLGTvKuRP9EyOpvMr1N/bCMfWuO1cpeXz7knvY4Nqo/Ar0N/58AwBA+O1nY/iD0
	+/po/mvVMHDNa4x+qo9nmFP6L88HBPBau6gE2pA+UYqYFGCTXYHvKdQzEcvmmsMF741VaO+xi6t
	5586wTXcpPUBEDds4YaUJcrNQe2x0ngRwJBRPbCSa16pfxjK+Sjm1aVeLd6nneqB+lZjrLSP2Wd
	JCxi2EPg14xwuyC37W50+lyTyW1/RFeeQ3gurV
X-Google-Smtp-Source: AGHT+IEV1Xd9UJUSSWF0QbsGn/Sjttr/g7W9om+mPq9/1K6FztDb+Cc2pyTcbq4CYtF07m15h/an8w==
X-Received: by 2002:a17:907:7147:b0:abe:c894:5986 with SMTP id a640c23a62f3a-ac252ba0916mr1077315966b.39.1741550595193;
        Sun, 09 Mar 2025 13:03:15 -0700 (PDT)
Received: from ?IPV6:2a02:3100:acdd:4200:b9d3:2874:813c:4af4? (dynamic-2a02-3100-acdd-4200-b9d3-2874-813c-4af4.310.pool.telefonica.de. [2a02:3100:acdd:4200:b9d3:2874:813c:4af4])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ac29f5d2638sm65925466b.160.2025.03.09.13.03.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Mar 2025 13:03:14 -0700 (PDT)
Message-ID: <b624fcb7-b493-461a-a0b5-9ca7e9d767bc@gmail.com>
Date: Sun, 9 Mar 2025 21:03:14 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Russell King - ARM Linux <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next 0/2] net: phy: clean up PHY package MMD access
 functions
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Move declarations of the functions with users to phylib.h, and remove
unused functions.

Heiner Kallweit (2):
  net: phy: move PHY package MMD access function declarations from phy.h
    to phylib.h
  net: phy: remove unused functions phy_package_[read|write]_mmd

 drivers/net/phy/phy-core.c | 75 --------------------------------------
 drivers/net/phy/phylib.h   |  6 +++
 include/linux/phy.h        | 16 --------
 3 files changed, 6 insertions(+), 91 deletions(-)

-- 
2.48.1

