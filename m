Return-Path: <netdev+bounces-230603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC15BEBC7A
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 23:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A74F34E1071
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 21:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC602459D9;
	Fri, 17 Oct 2025 21:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZmdYsem"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7972E354ADC
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 21:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760735043; cv=none; b=JZHDve3J6RuTMeKeckH9Ntl+TDbejS0HhWySDSv90/j/6l+FqgQAVKElaupcK+Y3J5sVSI+Jn8rl99mygqi02hemzP6RKhkNBS0v8eMztqe4oKxQ4RCQ7gV0WasZvo5bTvhyk4Dz9/zzZpJZg12e/VRhSSyXK9HR0Y8zaM0TG70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760735043; c=relaxed/simple;
	bh=ePZZB2GD1bDnMalOg+FvQjsyh9Vv0kLcqvrA6O87e1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uQJFqy6/S74rdfhLFqqPJzDt0Zg22dJ3Y+muwECbAUQhW1g5F2Y+FALgdWAMZNHmUtGh76e8qp1B70JfJtDXrY3J6UzlzlPdt+9m/Nx7YAxBJux0vEtDR0VBXbp4OFl02nB0ocFaqDd/5kA6kbGml0wqL/fe4tofCv7DFqY+9s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZmdYsem; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3ee130237a8so1554704f8f.0
        for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 14:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760735040; x=1761339840; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QSuDqpOxIaWktZpGDN+ql9Tk9+vxvv2TIkkewn9O7kE=;
        b=PZmdYsemRSlngfNm/RRCCOn3bJe6Nmc2xeboMmGtT9LK+MM6pa+kWwaleuu8QwsbSG
         qn7RNKGvC5//jgFPHOym8jFBJ7BCr7m2rb3dfmIRRsWpkRrcg5JFsJn0Oxo8+I7yhSzC
         3WMW06HmcFQByAZ9juE0Wx+wiIOWWFNYC0cb+gg04G/KwJXxGRQBpfFXA1VqWrt976Kk
         EIzoMCEY2oLE+/jDp4zZ4YQwRbURSyu8JrJ/T7HPYRqO+U0Y7ZW4jj6qBiwqVlEjBQuK
         eVRFtp1/tKbxNPZQPqMGx6RurNgnrzTauzBuOaXwnip/3+vx8KrTT4UbjXHXHoxKWop/
         80DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760735040; x=1761339840;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QSuDqpOxIaWktZpGDN+ql9Tk9+vxvv2TIkkewn9O7kE=;
        b=irb0esG2VqJVggRsvn5jomjWzCp3ErM4yaLVJqzCiD3DqtPAwr5S8Lhepj6IpaN5Vn
         OemFku9qbMeRCEXOOENeV7giumWuYHu8LCQOSW89A0pP9wDEWb9RAtNreTvBYDhjvVgt
         8qWbQPkwgrDZD6kEZlEgz+zDYyQ0FHjssD4ZzO/kUP3Xg5klwFK30aVwxo+D40njabBB
         EDNX8pB50nSBrm902VrKn5xQoR1iT8yohH0uIZnOaFu+JuNMN39EwnBF4/ntiF5UpTwE
         4Pm/DcuzoqYa+RnOmEMAL3P1k+ez2h37bbe57U8g8KXmkslzFCec2MhAghBwq+gkMJnY
         UVFg==
X-Gm-Message-State: AOJu0YzvRXqSbJtbUyCbsRVSqd4NQUpN5OjssfANqmuQY65C/+tlXIRm
	gxpCQSiqHIwWj1K0nN25O0wUZ9QyHr1T/Wey6hy15EIK1kq275gtbQCO
X-Gm-Gg: ASbGncs7CmfIoUgN2Wa5N4pWn9mmJDO8qz4X/pWsHr+S85FcxO/4/60Vc2LtPll49bX
	Jtaopu7d/FMs7mS5yYTGdmCy8ERWK3G14jD0J2+9oDCx6l4op6yOCNJfjy3L6O/AUv5aR8iptur
	3HD2OCrskPm32yZxdcJoJrtTWIngQNxmyZfyOVobad1RpcFns56HbpbCv543h4pyai93r7U1exZ
	EyMr1goRruB4CHaVVB9Zrb+ZuR02bNYcIOHc/aTlfjLQok6MdQc/NZjOqERh8F2MxaHRwZ2g8eV
	bM/LxTDgMNL1u1fmZBlLqgJbVjXGbkr88rGexFKW28j68kWGYY6AW55DZycrg6ZgxRsJ9xc1LH+
	WS0zCuUALqfG7khq0ml/go7Vt1NaWzi9wMcwfcFCEUBA5sGfAKpw0G9+y5iQVj08/c34g/zpOLG
	s8uWqAOO5g6lBzF/VHL7P7REjhGpUPoKbzaxCErBqkpRw+uyBjvJwnM5nAvVOiGy3KuECR1J7tG
	e0NOEL7LiIHEtjRfAggwVVuf0Jhy9QkWgA2lHqv
X-Google-Smtp-Source: AGHT+IGkzo43o64Qr2oOuLwbNsQnM1aNmN4BYj8mW1Ayn1+gSXNV7H1WkIErkjDnUYjmkKWOpLI/aw==
X-Received: by 2002:a05:6000:2f83:b0:3e4:64b0:a776 with SMTP id ffacd0b85a97d-42704e07f1emr3745582f8f.52.1760735039595;
        Fri, 17 Oct 2025 14:03:59 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f33:9c00:f581:27c5:5f61:b9b? (p200300ea8f339c00f58127c55f610b9b.dip0.t-ipconnect.de. [2003:ea:8f33:9c00:f581:27c5:5f61:b9b])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-427f00b97f8sm1147708f8f.36.2025.10.17.14.03.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 14:03:59 -0700 (PDT)
Message-ID: <e12d0e59-bbac-4c16-989c-9753ad10f61d@gmail.com>
Date: Fri, 17 Oct 2025 23:04:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: phy: fixed_phy: add helper
 fixed_phy_register_100fd
To: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Vladimir Oltean <olteanv@gmail.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <d6598983-83b1-4e1c-b621-8976520869c7@gmail.com>
 <e920afc9-ec29-4bc8-850b-0a35042fea12@gmail.com>
 <c7191096-963d-4436-bc63-8ccad2c5a002@gmail.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <c7191096-963d-4436-bc63-8ccad2c5a002@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/17/2025 10:55 PM, Florian Fainelli wrote:
> On 10/17/25 13:12, Heiner Kallweit wrote:
>> In few places a 100FD fixed PHY is used. Create a helper so that users
>> don't have to define the struct fixed_phy_status.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>   drivers/net/phy/fixed_phy.c | 12 ++++++++++++
>>   include/linux/phy_fixed.h   |  6 ++++++
>>   2 files changed, 18 insertions(+)
>>
>> diff --git a/drivers/net/phy/fixed_phy.c b/drivers/net/phy/fixed_phy.c
>> index 0e1b28f06..bdc3a4bff 100644
>> --- a/drivers/net/phy/fixed_phy.c
>> +++ b/drivers/net/phy/fixed_phy.c
>> @@ -227,6 +227,18 @@ struct phy_device *fixed_phy_register(const struct fixed_phy_status *status,
>>   }
>>   EXPORT_SYMBOL_GPL(fixed_phy_register);
>>   +struct phy_device *fixed_phy_register_100fd(void)
>> +{
>> +    static const struct fixed_phy_status status = {
>> +        .link    = 1,
>> +        .speed    = SPEED_100,
>> +        .duplex    = DUPLEX_FULL,
>> +    };
>> +
>> +    return fixed_phy_register(&status, NULL);
>> +}
>> +EXPORT_SYMBOL_GPL(fixed_phy_register_100fd);
> 
> Would not you want this to be a static inline helper directly?

Wouldn't then again each user allocate its own struct fixed_phy_status?
As-is we allocate it only once.

