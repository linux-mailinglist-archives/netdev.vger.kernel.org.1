Return-Path: <netdev+bounces-83624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B627F89336F
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 18:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 427301F228A1
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 16:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9B5145339;
	Sun, 31 Mar 2024 16:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSUTNg54"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAA54416
	for <netdev@vger.kernel.org>; Sun, 31 Mar 2024 16:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711902947; cv=none; b=pcIs82DSTmQqFcGvEQl/Wg2AUy/rcoUQeDuW1vTApdpigUsdzjnLDaNrPA99RTnuIFQCzdkoWda3RDIalMswrohHXmOV11HQYIojwZAtH5Fms13PebEmP/GZGm0CWHG1Vt0qI4muImVrHlP8cJ9ANUgKLr/EnkOfzDBAQDH2Aro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711902947; c=relaxed/simple;
	bh=Eh3I7iRvRWrwA461cTR6TFpbCiH1SpsnpmcgrmLTgMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NIap6ak8x4Wt0TAKWFp/t8ZWcJNQyyArq+EX2WDG6QI7mgxApUu4k3TnpHbp9H36ob5rcvVO6BxnxnA7D5kKhNLK6zKqE+OtT2AQxRtWi7y4fXX30ZoCNXgm/w/VIgts6HTg+SLdimw+LZ69y5ORUVeCIfh28MYOetrJAlizlrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nSUTNg54; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e24c889618so2317305ad.2
        for <netdev@vger.kernel.org>; Sun, 31 Mar 2024 09:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711902945; x=1712507745; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wthhvj87V4GOReBDgXHd8C3zO9AWbqO00rsqBPehgmE=;
        b=nSUTNg54zY7OO1LK4OUGVMzzxqvK9mSF+OevsPh4xu8vMsC3m+wa89B6pKu8a2cu2R
         O6rud4Uxp9/oiFKWcSHKSJdnQORsCDMLbJTKbbYNdC3fNU74XWyctcDY/v1HQm6Y2ywm
         HKoc/9gscix2pnGC1swZCoeuOTNdgxmOxnhi4dsTDXBQM+A0dZreXJO2vBKg7ulfjb2B
         ASqchBVqU5J4fQwaf+cm8lHpTHdN70ogKCz8sxXCqdaagyO97G5gVZp+pU5S37cI8Pl/
         hc3/fWTnH4TS0xlLb/+NWmgNSd/P6pL+CanIFAVzD44p3qvE5VHl6UXu0zRydCLoOPOf
         OypA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711902945; x=1712507745;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wthhvj87V4GOReBDgXHd8C3zO9AWbqO00rsqBPehgmE=;
        b=GPaA0opMR7HDJfXOQ7UKjBaCVDsP/MbrIHSM1QqmeCYHAZJYyuQVj2xj2IoqMVt6Lg
         jH28N1B/4lHcdRJ+6xV7FDZEsSDO23QsrpgPT1ZhBcuOYpOh14A5zsL5/YPfxQq1slXI
         o3I2Zln5UuBT8KcnhSg0Ymm96ynHsU/pDSW14Pq6ka20JfJF+2WYY8fe7AOBWIiow4sV
         M1HmqHppY9ssZylZboCxRimyqvobgsWH+9MgHQAdhBIz4Owt4dr76EcDhKMiBGnYW4pk
         s3xq77oN7DSyj/CWl4zfIm1m4qfGQTcr6dWAWgmKdgu6HDmjQQ5phy1BvgwWhlOhLRmn
         fveA==
X-Gm-Message-State: AOJu0Yz3AW+AiHjcKXY6K32odwTsyHBrQwrVVrRVzA7Ufri5PF/0ln3/
	Z32bu6YTphfIdM+fwq8jnjo7Nng+3T7ofNT9SoVaopD7+FY5nJ+FnRAFxk1HnXQ=
X-Google-Smtp-Source: AGHT+IF8lwXjdb3rP18uIXAYD0VXSuPP/yey5z8XCNNFm4iNcxBB7FzeUd5uIPgS3ibyyibo5C0UUw==
X-Received: by 2002:a17:903:2350:b0:1e2:4c59:a016 with SMTP id c16-20020a170903235000b001e24c59a016mr1468737plh.61.1711902945373;
        Sun, 31 Mar 2024 09:35:45 -0700 (PDT)
Received: from [10.230.29.214] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id m3-20020a170902f20300b001e0d6de7198sm7098627plc.283.2024.03.31.09.35.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Mar 2024 09:35:44 -0700 (PDT)
Message-ID: <01b0a1bc-861a-43bc-85cd-dd4f23b302d8@gmail.com>
Date: Sun, 31 Mar 2024 09:35:39 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 7/7] arm: boot: dts: mvebu: linksys-mamba: Add
 Ethernet LEDs
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>,
 Gregory Clement <gregory.clement@bootlin.com>
Cc: netdev@vger.kernel.org
References: <20240330-v6-8-0-net-next-mv88e6xxx-leds-v4-v2-0-fc5beb9febc5@lunn.ch>
 <20240330-v6-8-0-net-next-mv88e6xxx-leds-v4-v2-7-fc5beb9febc5@lunn.ch>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20240330-v6-8-0-net-next-mv88e6xxx-leds-v4-v2-7-fc5beb9febc5@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/30/2024 11:32 AM, Andrew Lunn wrote:
> List the front panel Ethernet LEDs in the switch section of the
> device tree. They can then be controlled via /sys/class/led/
> 
> The node contains a label property to influence the name of the LED.
> Without it, all the LEDs get the name lan:white, which classes, and so
> some get a number appended. lan:white_1, lan:white_2, etc. Using the
> label the LEDs are named lan1:front, lan2:front, lan3:front, where
> lanX indicates the interface name, and front indicates they are on the
> front of the box.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
[snip]
>   			ethernet-port@4 {
>   				reg = <4>;
>   				label = "internet";
> +
> +				leds {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					led@0 {
> +						reg = <0>;
> +						color = <LED_COLOR_ID_WHITE>;
> +						function = LED_FUNCTION_LAN;

Should this be LED_FUNCTION_WAN since this is the "internet" label?
-- 
Florian

