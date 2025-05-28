Return-Path: <netdev+bounces-193890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DCB8AC630D
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 09:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E084188F73F
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 07:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C494F2459E5;
	Wed, 28 May 2025 07:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JqX/HIQm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AAC24469C
	for <netdev@vger.kernel.org>; Wed, 28 May 2025 07:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748417492; cv=none; b=lNg34/4cH9I9ysVfwCCalF9CwhKdcPnIoP1MaP47TTp/QkTgoxYESAWsvXdwX7IAjLS1StLfSnBy0qpX1zaSgV8NiRz+wwM6mcBJYACFqMqTXs8CQAolt5x0Pjhn5WKV9lOwEgKgpsZHoIm0Tla6vzmPbp/62SvsxUwWCAIvffw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748417492; c=relaxed/simple;
	bh=UvIexZRUn+BGBcUY9tnDQQ7cZOqImj0Tt0QmErOJPf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ukkv27zffLAMWOi7ht8I2+XpdK/N+3gQObSjIKRuKqnQIFK5ytdeCcfLkebfiYWcC1Fd/mo7fdrohBi5DxON+BQ6YgjO9N7qGMlJDUaGiwDoiPk64OUfr79Gex0X0Wg9Wv44w8qmfV1wmlRh3qeOz6r7X8gBl2k4jeh28sQ54iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JqX/HIQm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748417490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NnNK+PMtqB0rA55xSs019Lt6frpG94moy6NPZkqGYPI=;
	b=JqX/HIQmPgJ+CPURIHMMcjV2lPvriESRIhZa2UTD+9xZojq3ZFka4JhiB+PoQzPFovPP8m
	lgQZeQLFeo7PrzS30S2NgdCvNfgsH75NjwKdwOrQrwgR4DnWagtQtTNb4wH97NuZek2Xq6
	Om7bptF5rfffHyruuEFPt85vx3Z79zU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-lOrXdiCFNuy79pXMQrDsyw-1; Wed, 28 May 2025 03:31:25 -0400
X-MC-Unique: lOrXdiCFNuy79pXMQrDsyw-1
X-Mimecast-MFC-AGG-ID: lOrXdiCFNuy79pXMQrDsyw_1748417484
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-442ffaa7dbeso31558605e9.3
        for <netdev@vger.kernel.org>; Wed, 28 May 2025 00:31:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748417484; x=1749022284;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NnNK+PMtqB0rA55xSs019Lt6frpG94moy6NPZkqGYPI=;
        b=O1efOyyLe2Dc0znso7TSs9JnrnA+Y8je4WyU2t8/55qZIWPUU2huYYVQaLVLQ8xWxJ
         eLAapH8NMQq0QywpL112+nz8smnbEGb4D6sQSFrnstl03/UY3+jZZqqoiPPvsYwfszvj
         nyjc5USJPAZfHfXmQmL/TvwEGEvRQ3gPHcDwxP8jlRYgQXaFjNZjIF3aP+1/6nB77OMz
         DwHHU72P9psuvRX9YkK841uldl16R+13ZkWpYFFQtYdhU/iXw0DXIl/5m4G8gNF4MxLF
         ibi5RZLEO9wax5uO6WOgffuIDNLEm5ne38FCYoWud2VOy/seBgLkwhCAONL3i84z/Cwt
         nJBg==
X-Forwarded-Encrypted: i=1; AJvYcCXl6VA7u8lstAUvnD1WP+zwco4TJ86cjTZIjLB/VmGJXVcUETxEIIjyuO/n1CqkwHrwbopDN8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF+t/s7ptDGdc9ypTSR9UAyXB5sR2fZkc56JbNuje0+Pn1ovC8
	A8m23CeEPodZocdJ/b7+sRLO+dW4bO0WAXKwbQ/8Jn6uiJbM4Y0RIMYoWPvQW1cdv2vjUBSQ+mr
	QQ0WEvOOtgMPgsU4adzzdcDF0c0jKsS0BdMXWY7g8QmnFD598/LSNIuAmxg==
X-Gm-Gg: ASbGncvZRSJc/iaMvBq8LpRXRvdiIxK3G8SwgeTCVJa25v853zxnLK+XuXyirQGcT/2
	JZ088W+QOYBu40X+M5Q28SZo0xEkvWg4Uh5iUStefVDf5yMppNIXTSjameKzNumE+hfdnXwqANB
	NaR3wq1U3P13wTxXHIRzDbit7wiwzH3gNowQBTSqwELUJkqXkTzBWkgmikEw1lFvqrErqXgYK+O
	S5RMm8cn9WsHUZSdhEv3uGiZDORai3Ps9Wa5hQ/yQxbf2LHLe7XR710ryT+kdXKIzStCf3vvQjH
	vWZG7xPl6vnofP160oszZvpnr2zrdT18MbGW5xMH3rCEEZd8d2w/GCV3aFk=
X-Received: by 2002:a05:600c:4fd6:b0:442:e9ec:4654 with SMTP id 5b1f17b1804b1-44c91cc3dc0mr138588645e9.8.1748417484112;
        Wed, 28 May 2025 00:31:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdJu619yR1tj683v5lEJt4BlhCq4Yc5mhZCTSaskqgJ5HAGUteqarVvWl0xRjxTsnjM5kpEw==
X-Received: by 2002:a05:600c:4fd6:b0:442:e9ec:4654 with SMTP id 5b1f17b1804b1-44c91cc3dc0mr138588065e9.8.1748417483603;
        Wed, 28 May 2025 00:31:23 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2728:e810:827d:a191:aa5f:ba2f? ([2a0d:3344:2728:e810:827d:a191:aa5f:ba2f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45006498c83sm12303485e9.5.2025.05.28.00.31.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 00:31:23 -0700 (PDT)
Message-ID: <8b3cdc35-8bcc-41f6-84ec-aee50638b929@redhat.com>
Date: Wed, 28 May 2025 09:31:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 00/13] Add support for PSE budget evaluation
 strategy
To: Kory Maincent <kory.maincent@bootlin.com>, Andrew Lunn <andrew@lunn.ch>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Donald Hunter <donald.hunter@gmail.com>, Rob Herring <robh@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>,
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20250524-feature_poe_port_prio-v12-0-d65fd61df7a7@bootlin.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250524-feature_poe_port_prio-v12-0-d65fd61df7a7@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/24/25 12:56 PM, Kory Maincent wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> 
> This series brings support for budget evaluation strategy in the PSE
> subsystem. PSE controllers can set priorities to decide which ports should
> be turned off in case of special events like over-current.
> 
> This patch series adds support for two budget evaluation strategy.
> 1. Static Method:
> 
>    This method involves distributing power based on PD classification.
>    It’s straightforward and stable, the PSE core keeping track of the
>    budget and subtracting the power requested by each PD’s class.
> 
>    Advantages: Every PD gets its promised power at any time, which
>    guarantees reliability.
> 
>    Disadvantages: PD classification steps are large, meaning devices
>    request much more power than they actually need. As a result, the power
>    supply may only operate at, say, 50% capacity, which is inefficient and
>    wastes money.
> 
> 2. Dynamic Method:
> 
>    To address the inefficiencies of the static method, vendors like
>    Microchip have introduced dynamic power budgeting, as seen in the
>    PD692x0 firmware. This method monitors the current consumption per port
>    and subtracts it from the available power budget. When the budget is
>    exceeded, lower-priority ports are shut down.
> 
>    Advantages: This method optimizes resource utilization, saving costs.
> 
>    Disadvantages: Low-priority devices may experience instability.
> 
> The UAPI allows adding support for software port priority mode managed from
> userspace later if needed.
> 
> Patches 1-2: Add support for interrupt event report in PSE core, ethtool
> 	     and ethtool specs.
> Patch 3: Adds support for interrupt and event report in TPS23881 driver.
> Patches 4,5: Add support for PSE power domain in PSE core and ethtool.
> Patches 6-8: Add support for budget evaluation strategy in PSE core,
> 	     ethtool and ethtool specs.
> Patches 9-11: Add support for port priority and power supplies in PD692x0
> 	      drivers.
> Patches 12,13: Add support for port priority in TPS23881 drivers.
> 
> Signed-off-by: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

I'm sorry, even if this has been posted (just) before the merge window,
I think an uAPI extension this late is a bit too dangerous, please
repost when net-next will reopen after the merge window.

Thanks,

Paolo


