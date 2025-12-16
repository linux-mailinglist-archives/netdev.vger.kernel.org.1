Return-Path: <netdev+bounces-245025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7F4CC5664
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 23:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D0EB3030925
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 22:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5BE33F8C7;
	Tue, 16 Dec 2025 22:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ViRQANN5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931B032FA3B
	for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 22:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765925324; cv=none; b=Gd0nODweLxP18X2ArGF29eXruqJVZ9PMcYWETDxL6UHWTbmuW5rVyI2Sk8SjeCYYHG8GKEnwSYegXnNtbpq8tIvZ2KBUGm4EDLF4jKnX69BuQKo2OH/ifAkpfUeFkXKWnK2ez/l5ycWE1DuBENHTx0yhFMypVwJHqwoSqubMrbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765925324; c=relaxed/simple;
	bh=IxHqxoNNy3wXGQLhP0+4PHorGbBuY0pS5c5hJzhMoo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kSbS+KgOpNs948tL3wHZ1rKD8taD/Nq7TcGVp+4VjfCKjBrwx51UhT/wFtU6+PgnciYx84UKzDWoDK2Ex/ZGAYgK3rs5uEszXVbmaV6HHcahB1Zg6mPDLY1sqVLq3hp90bTzZW0fQwh3xzCJ48LH3rV2KW1F9kZqYS2emEUQR84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ViRQANN5; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47bd9de2ed2so951985e9.0
        for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 14:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765925321; x=1766530121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tGXRZ05qx8U5oH8vemlQWNqv2IHE34HX0JuKIxOR9r8=;
        b=ViRQANN5khlC7XbV9jDxj8ycLqBeIwdpoS05CGwNlENtORb9VglgOWlBfAvef9b7mJ
         mKropc2lWyU/puIqniDJuAKcAYbnRnbGj6w3K1fST3eXsdJBAwUFA4PskesDLK7jMygf
         qQsR2r2W/elQI0mYwONL4fYtEFxe7xDTlTwsj+MXaFFID6ylm4wfr0a9zqqAo0zoRuft
         ZmvSWcyQ0rE1kf+0ilu/9k9oBNXfkXhAdorvJAAiTngKOvW0Gw2bHdH0knCAzjLYsSkB
         hVRfdA1ls1+410/OD4tzA59KH/QJewdQO3nJdsFoitzX68x3C18lySu2qWXAoaf7YZmL
         l83w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765925321; x=1766530121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tGXRZ05qx8U5oH8vemlQWNqv2IHE34HX0JuKIxOR9r8=;
        b=Gd9BJgUIGFqOgflhwQe8A5fYV/jRYmdnfG1WqMCZF0YMvgjha0zcxfBBJm3g3S9F4L
         cBrBuziNoW4cv7gpn46LUK0DBhvx2Mn4xHBUooS0caBY/0q9sqWizA1sHlSNnvnfOjM+
         NsMmVSkAT6JGojmu48LwmAPJdXsoYPg/sudPLzVZfOc8PIiiD0ZvFQ7O05QetL61CN5i
         muBPDnMuj3+c4F4r7Tqs1czHgsfsEFMo3/6Wa+zPi57ROqcV1yqh+on9khYD0Btg53dd
         uofES2JY6y6C/yXthDeN6cp0EmkGpwoQtygn6TbhSHoh6oDxagn7q36neTuGzKXXh9Ke
         jCIg==
X-Forwarded-Encrypted: i=1; AJvYcCUYhLGEBm7BboMG6//YYxnd+6FnpuKVHDuMSTxITydrqPRVoVvmlkd868V6nfVhTnrPfWRFY2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YynJg5IHK7U8SZKXQ2mOz5TJrJnX+ksYnnrCMYGJ+s5URzWjEJ3
	EoZeVpB5pzu9cb8BTQg+mz07o3E+Demf4gDpGqUOGmY097zGgzDHK4o+
X-Gm-Gg: AY/fxX7znf+MfKFDdIwtVXE/pK0O0/tbZu4oyrGFQv0qvaH3I2+pGAcuy4wTiDjnjM/
	SrflnXH8ocZcJbYhHmiXGNPjywAbZoFWQPsE+0880lJzIh6Liyb1WWUbmXt21e2dpQsGDHru+Nt
	V9adnNkgiHgr2g4P1O/ailiK6JTHcFMko0Pq7Lr3PzZPtxcCAFZckQMv8onZTsSzmCZFIrAKrMt
	bGVupI2pkQ4O7yfbEaP/BCb9A/GLxAWbGzVTVZsO+rpVUXUbBNcaXqDGRWYcUuadtySFoJHKYiS
	6g+esEn9z7MujPQMuNQ4UkMjJJ9SHMWTvsfaChbTaLsXgzxSN9bdLvQH7otpRpgliVTU3F3n88K
	CLth6iLk+Sj4ACwRZRI0Tbqhz/NYRRlTOhC/jFyOSnQuiFyTVJKEvZ7hDBg6lDwquYhdPyXjWUv
	2Y
X-Google-Smtp-Source: AGHT+IFvce4UGc7D5Mr+v+EA824QMnFjv+6amcat5/cBlI/KPdmjkfJCha9ggV5j0f7bEEnuAqtWqg==
X-Received: by 2002:a05:6000:18a7:b0:429:ebf5:ff1d with SMTP id ffacd0b85a97d-42fb42d1641mr8793864f8f.0.1765925320745;
        Tue, 16 Dec 2025 14:48:40 -0800 (PST)
Received: from skbuf ([2a02:2f04:d106:d600:c18:aa1:b847:17e5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4310ada8477sm1452258f8f.7.2025.12.16.14.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 14:48:39 -0800 (PST)
Date: Wed, 17 Dec 2025 00:48:34 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH RFC net-next v3 1/4] dt-bindings: net: dsa: add bindings
 for MaxLinear MxL862xx
Message-ID: <20251216224834.ondmgo4av5vn24qg@skbuf>
References: <cover.1765757027.git.daniel@makrotopia.org>
 <cover.1765757027.git.daniel@makrotopia.org>
 <cf190e3a4192f38eecba260cd2775b660874746e.1765757027.git.daniel@makrotopia.org>
 <cf190e3a4192f38eecba260cd2775b660874746e.1765757027.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf190e3a4192f38eecba260cd2775b660874746e.1765757027.git.daniel@makrotopia.org>
 <cf190e3a4192f38eecba260cd2775b660874746e.1765757027.git.daniel@makrotopia.org>

On Mon, Dec 15, 2025 at 12:11:22AM +0000, Daniel Golle wrote:
> +examples:
> +  - |
> +    mdio {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        switch@0 {
> +            compatible = "maxlinear,mxl86282";
> +            reg = <0>;
> +
> +            ethernet-ports {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                port@0 {
> +                    reg = <0>;
> +                    label = "lan1";

Please remove port labels from the example.

> +                    phy-handle = <&phy0>;
> +                    phy-mode = "internal";
> +                };
> +
> +                port@1 {
> +                    reg = <1>;
> +                    label = "lan2";
> +                    phy-handle = <&phy1>;
> +                    phy-mode = "internal";
> +                };
> +
> +                port@2 {
> +                    reg = <2>;
> +                    label = "lan3";
> +                    phy-handle = <&phy2>;
> +                    phy-mode = "internal";
> +                };
> +
> +                port@3 {
> +                    reg = <3>;
> +                    label = "lan4";
> +                    phy-handle = <&phy3>;
> +                    phy-mode = "internal";
> +                };
> +
> +                port@4 {
> +                    reg = <4>;
> +                    label = "lan5";
> +                    phy-handle = <&phy4>;
> +                    phy-mode = "internal";
> +                };
> +
> +                port@5 {
> +                    reg = <5>;
> +                    label = "lan6";
> +                    phy-handle = <&phy5>;
> +                    phy-mode = "internal";
> +                };
> +
> +                port@6 {
> +                    reg = <6>;
> +                    label = "lan7";
> +                    phy-handle = <&phy6>;
> +                    phy-mode = "internal";
> +                };
> +
> +                port@7 {
> +                    reg = <7>;
> +                    label = "lan8";
> +                    phy-handle = <&phy7>;
> +                    phy-mode = "internal";
> +                };
> +
> +                port@8 {
> +                    reg = <8>;
> +                    label = "cpu";
> +                    ethernet = <&gmac0>;
> +                    phy-mode = "usxgmii";
> +
> +                    fixed-link {
> +                        speed = <10000>;
> +                        full-duplex;
> +                    };
> +                };
> +            };

