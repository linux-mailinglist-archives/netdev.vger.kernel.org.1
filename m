Return-Path: <netdev+bounces-243209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF07C9B8CD
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 14:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B80333478B4
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 13:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0B33148C1;
	Tue,  2 Dec 2025 13:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IbjlIVHE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LYE0WAs1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F7E313E3A
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 13:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764680617; cv=none; b=HtLw/zJchOIqu1YIt27NuYek4kRaMgD9XMk9R2Dvd93OFwzt5f/V+rQE6DYqolqx7Lv/8umCSIEPx6N9l5bJOzYLO9IlMnCuYm16qLfdY1USm6CzaPG0bj5gZnnOhoRJqP351nKBkt3761KlTSQCAXN+6Ps5qb1lCAnqGYXXY5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764680617; c=relaxed/simple;
	bh=KdKmDoBxn/rPOKUCTHhKFuAtVgA9Ufb6RRmosnME1ac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AUWEr2PXoK2NvBWb2Zirs6dcocEyklsgy77KWjGeO5uzKZG7JgXQQTo0euoGyM48RmrwiJ7spNbk/cdPtU2Q+0Umk4+HamW/kW+dq+moWMYpHhaztPTHpnvwSSaoE6HJkkXJMxVsqCFqX16adXpJIA1BPatkFX4FPmRnndchK5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IbjlIVHE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LYE0WAs1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764680614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ey6wtgDcQ116K7LfiiQ+bxQUIrUIywSYa0E8sps1NXc=;
	b=IbjlIVHEEexRMBkBbTpwQzIPXVd4O/mbz2eLxYGcfYMLPWUV/GQZ4kfdjVGXYpSZDdNKgV
	GssSGDWFgYFDfRZFUVKGKI4O4nO0JYpLDrJIHUrbB+BM0t83U/ShQPl2LvsRAzOxqFSO8/
	5rENaXxNrmkurEqn71zqqRlRWL8+qnE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-BBuM-bvePVKzWOBx9sdiTQ-1; Tue, 02 Dec 2025 08:03:32 -0500
X-MC-Unique: BBuM-bvePVKzWOBx9sdiTQ-1
X-Mimecast-MFC-AGG-ID: BBuM-bvePVKzWOBx9sdiTQ_1764680611
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477939321e6so31867885e9.0
        for <netdev@vger.kernel.org>; Tue, 02 Dec 2025 05:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764680611; x=1765285411; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ey6wtgDcQ116K7LfiiQ+bxQUIrUIywSYa0E8sps1NXc=;
        b=LYE0WAs1DDSDkJyXgmhQfyA1qlDf3KHTgPYaOd+TkDuf3XF7BGA55qwbd2eACxcQQB
         tAQi1UXKhpmDgCXAR6dM+ItCNt1axhyZ0ZJVWm6+dxn23te5DjAYqKaUHCEFdNflXGhP
         f2OKAr9kWfc23uxxOQmUg3XYaD4ymIm2PIyjby2YGLHwtnpttFF/1eFfAF0QPWiFrHTx
         MLk28/TGSG3w3MRvGuJKsaVDYNcDtCc0SVepE9/mz8k7JAsOD6lT4+s0Po0XchwUupZ9
         nVOSoJjMhvxpyKHOLPrp2WsMtvoPmAe7TRKngdYtga4pAbL75TB1IgBFolK1LzS8LE1N
         Ohvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764680611; x=1765285411;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ey6wtgDcQ116K7LfiiQ+bxQUIrUIywSYa0E8sps1NXc=;
        b=rz2CDjrXXiPS1IpSEyLNzqTjN6w6RNpZFUyGARcOK9/PrdcR8zdF0y1CmpeTDsw8kb
         JQReY5cnsAWv7R1QjpdbeKqcghxk+dSaX56fSGBwpBckOQ51PedNESMQe1quvzu9Xcfj
         tWbIFDn+92CGn9rX3K3qrDBj6hQLDp0ggtgq9NRYFZQmcrkJk/dZfdHdliDJjYIRvDuD
         TYPnI3Zwj/nZ/C3J6o8yqFr+rOMjlDFq9inNKHJeL6wkyuycG9q8Briiru1RIt+7H9aD
         nvDeMF1bERcokrNWaOitglS8/TfL/Akn/54qHrRYdaybuyGY+zZTMTrptYSrfbCmdpR4
         HQsQ==
X-Gm-Message-State: AOJu0YwAwZqa6TLjnwVH0EMJLEsDiO1GRiYfM419B0tmWLjNOGHb0nZj
	Dc5pIXiprwwv4m7cup6btDZhqFYJ9G0vpO2aLpEV3xRuZEYrAHAR1PLuCOgFs9THbXaExwYViSx
	J0IeoVo/dsg9OGowv7rc3T24WhcKyMwEtcHrTt1R6/CjxniytCFRV00AxxA==
X-Gm-Gg: ASbGncv92ly8oHKLBcSq6Iby6teoPGr0y3qQGCWWWv5c1h4avUqBtuYYpjaPnqtllsx
	r67AqTbKXM+v0KEthWrIlj1JnxUYMXZTckvsKRXL9HQoPDZzleaHM8D/MsnLD/OMcjKSkjpkb0g
	mD55TFlHuFZco/JDkjSPJ3vLNxTviOxyngJF152M4ptxtuAtKnKauUzfBXtAdybMatSea11YTTm
	lSWN0GGAWAnUYnb2MzkKRexG7DROA8931jC2MQMMQbXnXkWok+e93bI2/Rl00O+SMaQMxnuWX6I
	L74+Y0sFSN1wS3p6RNWZZz6/d3m6aHbO3zbZLXxDa3C6f9LdkAbLLN6vdFUhRbQ7+yQ2AdFEsC2
	gG0wAcvcsO4mR6A==
X-Received: by 2002:a05:600c:35d2:b0:46e:4e6d:79f4 with SMTP id 5b1f17b1804b1-47904ae214emr355760595e9.15.1764680611297;
        Tue, 02 Dec 2025 05:03:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmafT5DyC4RoGwnfp5MmrgkftnBIjDmLkHPcVwpalWPTKpHlhk1u8H7c9dIZ7UKqeyugJgdw==
X-Received: by 2002:a05:600c:35d2:b0:46e:4e6d:79f4 with SMTP id 5b1f17b1804b1-47904ae214emr355760035e9.15.1764680610815;
        Tue, 02 Dec 2025 05:03:30 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.136])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790add60e2sm355758785e9.6.2025.12.02.05.03.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 05:03:30 -0800 (PST)
Message-ID: <298e982d-7796-4e46-ad1d-a7f57c573f35@redhat.com>
Date: Tue, 2 Dec 2025 14:03:27 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v21 02/14] net: ethtool: Introduce
 ETHTOOL_LINK_MEDIUM_* values
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, thomas.petazzoni@bootlin.com,
 Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?Q?Nicol=C3=B2_Veronese?= <nicveronese@gmail.com>,
 Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
 Antoine Tenart <atenart@kernel.org>, devicetree@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>,
 Tariq Toukan <tariqt@nvidia.com>
References: <20251129082228.454678-1-maxime.chevallier@bootlin.com>
 <20251129082228.454678-3-maxime.chevallier@bootlin.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251129082228.454678-3-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/29/25 9:22 AM, Maxime Chevallier wrote:
> @@ -298,138 +321,149 @@ static_assert(ARRAY_SIZE(link_mode_names) == __ETHTOOL_LINK_MODE_MASK_NBITS);
>  		.speed	= SPEED_UNKNOWN, \
>  		.lanes	= 0, \
>  		.duplex	= DUPLEX_UNKNOWN, \
> +		.mediums = BIT(ETHTOOL_LINK_MEDIUM_NONE), \
>  	}
>  
>  const struct link_mode_info link_mode_params[] = {
> -	__DEFINE_LINK_MODE_PARAMS(10, T, Half),
> -	__DEFINE_LINK_MODE_PARAMS(10, T, Full),
> -	__DEFINE_LINK_MODE_PARAMS(100, T, Half),
> -	__DEFINE_LINK_MODE_PARAMS(100, T, Full),
> -	__DEFINE_LINK_MODE_PARAMS(1000, T, Half),
> -	__DEFINE_LINK_MODE_PARAMS(1000, T, Full),
> +	__DEFINE_LINK_MODE_PARAMS_PAIRS(10, T, 2, 4, Half, T),
> +	__DEFINE_LINK_MODE_PARAMS_PAIRS(10, T, 2, 4, Full, T),
> +	__DEFINE_LINK_MODE_PARAMS_PAIRS(100, T, 2, 4, Half, T),
> +	__DEFINE_LINK_MODE_PARAMS_PAIRS(100, T, 2, 4, Full, T),
> +	__DEFINE_LINK_MODE_PARAMS_PAIRS(1000, T, 4, 4, Half, T),
> +	__DEFINE_LINK_MODE_PARAMS_PAIRS(1000, T, 4, 4, Full, T),
>  	__DEFINE_SPECIAL_MODE_PARAMS(Autoneg),
>  	__DEFINE_SPECIAL_MODE_PARAMS(TP),
>  	__DEFINE_SPECIAL_MODE_PARAMS(AUI),
>  	__DEFINE_SPECIAL_MODE_PARAMS(MII),
>  	__DEFINE_SPECIAL_MODE_PARAMS(FIBRE),
>  	__DEFINE_SPECIAL_MODE_PARAMS(BNC),
> -	__DEFINE_LINK_MODE_PARAMS(10000, T, Full),
> +	__DEFINE_LINK_MODE_PARAMS_PAIRS(10000, T, 4, 4, Full, T),
>  	__DEFINE_SPECIAL_MODE_PARAMS(Pause),
>  	__DEFINE_SPECIAL_MODE_PARAMS(Asym_Pause),
> -	__DEFINE_LINK_MODE_PARAMS(2500, X, Full),
> +	__DEFINE_LINK_MODE_PARAMS_MEDIUMS(2500, X, Full,
> +					  __MED(C) | __MED(S) | __MED(L)),
>  	__DEFINE_SPECIAL_MODE_PARAMS(Backplane),
> -	__DEFINE_LINK_MODE_PARAMS(1000, KX, Full),
> -	__DEFINE_LINK_MODE_PARAMS(10000, KX4, Full),
> -	__DEFINE_LINK_MODE_PARAMS(10000, KR, Full),
> +	__DEFINE_LINK_MODE_PARAMS(1000, KX, Full, K),
> +	__DEFINE_LINK_MODE_PARAMS(10000, KX4, Full, K),
> +	__DEFINE_LINK_MODE_PARAMS(10000, KR, Full, K),
>  	[ETHTOOL_LINK_MODE_10000baseR_FEC_BIT] = {
>  		.speed	= SPEED_10000,
>  		.lanes	= 1,
>  		.duplex = DUPLEX_FULL,

The AI review points that medium is not initialized here:

https://netdev-ai.bots.linux.dev/ai-review.html?id=437cd013-c6a6-49e1-bec1-de4869930c7a#patch-1

Is that intentional? It should deserve at least an explanation in the
commit message.

Somewhat related, AI raised on the first patch the same question raised
on a previous iteration, and I assumed you considered that valid,
according to:

https://lore.kernel.org/netdev/f753719e-2370-401d-a001-821bdd5ee838@bootlin.com/

Otherwise I think some wording in the commit message explaining why the
AI feedback is incorrect would be useful.

/P


