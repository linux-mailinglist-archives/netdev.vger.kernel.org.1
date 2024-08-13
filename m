Return-Path: <netdev+bounces-118061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0B99506EC
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 15:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6049E1C22B78
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 13:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C7519D078;
	Tue, 13 Aug 2024 13:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ahzPcV1U"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAFB19CD19
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 13:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723557274; cv=none; b=OYg8NBQNWjOW1KlXYYjobBBvkbbQOsJwIj1kfsONe4mC0eF9J0trd5h+KLUxLLIOQYihFxtWrjwL9UZP8cf/thr+KNG6CXLQv69j3A7R6cIdGmv6N4xFVA5cOUUBORaQpm/jq2TqR+UM8m5zXcKGiPBizIiEECfuYzjwXpNp8CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723557274; c=relaxed/simple;
	bh=VXxCCJXPNv8rAnDPDBR/EdsEcMV2Jfe8Wu2+Nlrny5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OIXCvy8DMaO94CRySCFwPAHrhaF8rSXPiAXhWB21F///otfdEo+U44zHWntWHW413imc+VH6wrrBCF4ZdhGyto/oRfjo671bAyioHfc/6L96pSYyMG7xfLKDMtW6CU1StCg1YDkGk0QTRQxIGa8QzH7bRrHjtf+8rC4iXrPrFt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ahzPcV1U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723557271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ftSvgbnin9t8+uyc0Qyra1ua6IsRzeg+RnvJFpXFr3Q=;
	b=ahzPcV1UK8WZFsA3WyW9iO/HA8YyYXN/UGr7HMQTzMAsFjvVQyS7vBjYq95UWp6b755mc8
	EpRibJimuSS6m5Ygbuk3ehmtke91w7RPgdofeqO0lCcVJmJrx6EzJypeDQrnAwQnDuOwwl
	Hk4H9dcNqSAZt1WigUrZDujm1SBIX50=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-2k4kTbqdNK2S0UhNMhtEgQ-1; Tue, 13 Aug 2024 09:54:26 -0400
X-MC-Unique: 2k4kTbqdNK2S0UhNMhtEgQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42818ae1a68so10508775e9.2
        for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 06:54:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723557265; x=1724162065;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ftSvgbnin9t8+uyc0Qyra1ua6IsRzeg+RnvJFpXFr3Q=;
        b=I0LasXsUPzbi30ciVK63Id98R1lrRHpPWQY+9ZLJVM3VMvokY2ZvJPToGBamU5udY2
         xZwpyLZAOlrDyX5E+Oxu7JFievsQsoRNx260u2db/2NQuEKIvEGIffeh/LQ2FrUiafJT
         z4ncKOGKbtZU9gGx0XERSnrQsTmKTwpxyky8x3At0KhU9kN93j+wEZbRqUFsEuTRJ0wv
         AZReHnvihVHtAG5G5LzracJM9k/QaqyT2EpDP51dAzfu6FAvycSVhUMXKJJroKb6oHQx
         Rz7XdjVTwC1c1u6Gvq65FXhRgBFLIQ6q/ojsJnS6l7IVer3BYJunkaUgjq9NADwj76LP
         /zIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnY4l0e+0XlmUwF0bmkEhKpmveYzSb+btKMhdwbCrNcQ/oZcCmTPrbsd/tdvvVWaxOXbSdCpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSk3Xsd38paW9bNvXcrhKnxiXr99MEcAVZ0OALqTR9770+fIiI
	1dbvmzSdS2zlqdeapsjtZqKbccAnV9Jzmui89323gVoY/P8NupRIvzpzKa1l/8D2j6buSd4+Git
	CSCDaQGjdMxGRLkPIVIUulxUWfDhJU8g78rWC9MebCRO8IxqxBep1QQ==
X-Received: by 2002:a5d:64e7:0:b0:368:4c5:12ec with SMTP id ffacd0b85a97d-3717028178fmr1083058f8f.8.1723557265266;
        Tue, 13 Aug 2024 06:54:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkGXvuWmr9Mw17RK3kt8FwYNiZEJrqhn5ZvawfheaNNHSvSGHpYTP6xuawTq17tPof0GuX2Q==
X-Received: by 2002:a5d:64e7:0:b0:368:4c5:12ec with SMTP id ffacd0b85a97d-3717028178fmr1083037f8f.8.1723557264732;
        Tue, 13 Aug 2024 06:54:24 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1708:9110::f71? ([2a0d:3344:1708:9110::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4e51eb47sm10459247f8f.88.2024.08.13.06.54.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 06:54:24 -0700 (PDT)
Message-ID: <8dfa7ffb-f40b-452c-9c3e-6bb500e1a46a@redhat.com>
Date: Tue, 13 Aug 2024 15:54:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/2] net: dsa: microchip: Add KSZ8895/KSZ8864
 switch support
To: Tristram.Ha@microchip.com, Woojung Huh <woojung.huh@microchip.com>,
 UNGLinuxDriver@microchip.com, devicetree@vger.kernel.org,
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240809212142.3575-1-Tristram.Ha@microchip.com>
 <20240809212142.3575-3-Tristram.Ha@microchip.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240809212142.3575-3-Tristram.Ha@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/9/24 23:21, Tristram.Ha@microchip.com wrote:
> @@ -542,11 +545,11 @@ static int ksz8_r_sta_mac_table(struct ksz_device *dev, u16 addr,
>   			shifts[STATIC_MAC_FWD_PORTS];
>   	alu->is_override = (data_hi & masks[STATIC_MAC_TABLE_OVERRIDE]) ? 1 : 0;
>   
> -	/* KSZ8795 family switches have STATIC_MAC_TABLE_USE_FID and
> +	/* KSZ8795/KSZ8895 family switches have STATIC_MAC_TABLE_USE_FID and
>   	 * STATIC_MAC_TABLE_FID definitions off by 1 when doing read on the
>   	 * static MAC table compared to doing write.
>   	 */
> -	if (ksz_is_ksz87xx(dev))
> +	if (!ksz_is_ksz88x3(dev))

I think that for consistency and readability the above should be:

	if (ksz_is_ksz87xx(dev) || ksz_is_8895_family(dev))

Thanks,

Paolo


