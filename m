Return-Path: <netdev+bounces-211262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CC6B17689
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 21:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 452F4541662
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 19:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FCC242914;
	Thu, 31 Jul 2025 19:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="byjjAZE0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52F1A29
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 19:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753989641; cv=none; b=hp2gUk6KzK5QS0QuPrRRDPJHNwg/MbsNJkiGOL7LKfYCmW9CG1Itn/eVXy9wDntyWxaaD8jguAZq1lujCWSluVj55j+ixStV8nlRHXAn72pCXCbnnMFxUSetoYWFJP3B8C0xgLQcGaBY207JlP0Ggh2abDVLNGhUaLbE2/u+UmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753989641; c=relaxed/simple;
	bh=i9HXTt/WtEa9jEmYlSgCkrJ6sTOfz0LMAeBr6TibgLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GE2qv2PJFnViQTa71sqG18oq8aiE36UEx0ylyJdNkqto6H0qQ7kxnqQn4fwBybWOCMqZho0NBgcdhAg1TR5PX5D3rcQ1cBAJJNRYzJl9ul4QmLrRonewiFGri0QYaNVke1jfwUjfI3190L5nRCL73hf5d8UicIpPnbk5UKa3lr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=byjjAZE0; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b7892609a5so986344f8f.1
        for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 12:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753989637; x=1754594437; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9UMEZr0opwfPKRv0ihnB+Vjf1l6t5J9I2VL8uLtY5rA=;
        b=byjjAZE0/Qv7yu+gRf1uYVOa2Wq5OtHalaayTM853iR5gpi8JZ2C52JThAdRMLvQnX
         lM7Xa9m3LN70PCfWQpChY0yLxU4aY58A+5RLs7PzKdPvsMg+EURejY2RiafvqeFIgi/G
         uLi2hn4bVPxxb9PWk47ewb0xtseUlBYn8/QcfwZLiqR7ZenEf1AS6P6/fJFZcev8mXju
         Uc5jVN8giMzNPknRhgCV7bspmYtyHoSaW2RrWqMg/qmefvEBoRqoxCaHWcf/mrNMFHOw
         yGhdkzNTByE8KPhRNX7uFyYL3EemUjROjGbF3mYrNroOj8/+MNMlUFYtA7jRW3k04sA9
         kfrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753989637; x=1754594437;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9UMEZr0opwfPKRv0ihnB+Vjf1l6t5J9I2VL8uLtY5rA=;
        b=LKQN214Fb6xOLJWWd4YWy6SzaMZz3MFOZgZrto+JuUcFt29zqFvJ/9R7TzPzBL9kHE
         3sARacAGGVaMHLXkfX8w/6NAqWwOgHS+ebXIy5FFFPO37CfIgxvKpgROOFRyZSs5Rfd4
         xF6Npf2TpoGjTEyJWNAZcfWSIlbUsIONHydfeezO4LUWXT8t1SMxVLNJg2m0osB8QGc4
         CgElyk2Nd9GYbCQ1+TIcTHJ3AIoDD+VGGnf92wqXZpiHG2gCrZeWTV1j616aXgAu1qss
         jpfISKjPufVUtmMdvH2cY8GQZ/VBd0X9L6djaSj3S2bBMoMQPVJu+dPsP0i/KQgbgokL
         GkuA==
X-Forwarded-Encrypted: i=1; AJvYcCUGshDiTJp19f5CRo/h0KLx2hcu32nc5kbwS4MLqgxj2JODrcX7HBMXVVgXlassytScJYXKyMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL7ET9bbKQ+1Wl7KZn1+8ImiRkgYFkoUp4UXEkYXCoDe/38HD7
	EDp/GQjMP7GyNYqqIHySdqdrdkUD7hx9yFwn1tqhnCyb/+KLuCFKT1foAazmbQ==
X-Gm-Gg: ASbGncsGE6L1v452lwoL1UGYDEs1aQz4EHJPGtnqW++FYJjqVSCbF1d1jtQgeviM681
	UUzhMT9xjSB9+KxCkYhk3gdsdHQxavnk4K6AYZUEwDc18pWU8U0VHWwR5Z+Z1DbW+3FQj+2helW
	JKA0EJ9JKhQ/aUKruL5hECg/Y6qNbt8LBnBYlIjQG9zmmZM6KoYZDx6i3zd9XTw7r3c27qfi6mb
	iHVmtvXKbOyYBLZCIa0ndTj+4spNbA7BUgaaPauKKvb7Y7uHx0sIcmOopcCEysqszxwe4oBvRgj
	0PQxeDZnD4wH5RBNLaX8TJPrYaCSaq1lbJQ2a69jC2D6a6oUzUXGbnaMnw1j4/qB2q3oDXT34VK
	Y2y+IFWMPYZA+P0ZxohB9y0jJA+k0TjE7Yl/6hscJf7VzzMtz5FYxMQ4KEP3uDzoptK8+LY3GRc
	G3orhYO2tB2nN03Einl2JvIURKbIhxEURSU9S2E5Q560cDQ9HQ26WSp5J1FKxi2A==
X-Google-Smtp-Source: AGHT+IHGL0O4BtNwcAkPoZGy6wg/EvPU0lGhSN8Krx/5o8wihnw9p/wyxb8oBOHEmufvra5x6NAMAw==
X-Received: by 2002:a05:6000:240b:b0:3b7:b3f2:f8c3 with SMTP id ffacd0b85a97d-3b7b3f2fd1fmr2696260f8f.57.1753989636730;
        Thu, 31 Jul 2025 12:20:36 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f46:f500:c1f2:95ad:fcfc:bc63? (p200300ea8f46f500c1f295adfcfcbc63.dip0.t-ipconnect.de. [2003:ea:8f46:f500:c1f2:95ad:fcfc:bc63])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b79c3b95f4sm3258499f8f.23.2025.07.31.12.20.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 12:20:36 -0700 (PDT)
Message-ID: <b16f2601-c876-4959-b40a-58a676903594@gmail.com>
Date: Thu, 31 Jul 2025 21:22:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: ftgmac100: fix potential NULL pointer access in
 ftgmac100_phy_disconnect
To: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: Jacky Chou <jacky_chou@aspeedtech.com>,
 Jacob Keller <jacob.e.keller@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <2b80a77a-06db-4dd7-85dc-3a8e0de55a1d@gmail.com>
 <ddbfdf8c-53ab-4993-a53a-60c45d36cae9@linux.intel.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <ddbfdf8c-53ab-4993-a53a-60c45d36cae9@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/31/2025 10:58 AM, Dawid Osuchowski wrote:
> On 2025-07-30 10:23 PM, Heiner Kallweit wrote:
>> After the call to phy_disconnect() netdev->phydev is reset to NULL.
> 
> phy_disconnect() in its flow does not set phydev to NULL, if anywhere it happens in of_phy_deregister_fixed_link(), which already calls fixed_phy_unregister() before setting phydev to NULL

I can't follow this argumentation. Look at phy_detach(), there we have:
if (phydev->attached_dev)
	phydev->attached_dev->phydev = NULL;
So netdev->phydev is NULL after the call to phy_disconnect, provided that the PHY was attached to the netdev before.
If use_ncsi is true, then fixed_phy_unregister() will be called with a NULL argument.

This is independent of whether of_phy_is_fixed_link() is true or not.
Very likely it's false in the NCSI case.

> 
> From my understanding (which very much could be wrong) of ftgmac100_probe(), these two cases are mutually exclusive. The device either uses NCSI or will use a phy based on the DT "fixed-link" property

>> So fixed_phy_unregister() would be called with a NULL pointer as argument.
> 
> Given my analysis above, I don't think this case is possible.
> 
> Best regards,
> Dawid
>> Therefore cache the phy_device before this call.
>>
>> Fixes: e24a6c874601 ("net: ftgmac100: Get link speed and duplex for NC-SI")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>   drivers/net/ethernet/faraday/ftgmac100.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
>> index 5d0c09068..a863f7841 100644
>> --- a/drivers/net/ethernet/faraday/ftgmac100.c
>> +++ b/drivers/net/ethernet/faraday/ftgmac100.c
>> @@ -1750,16 +1750,17 @@ static int ftgmac100_setup_mdio(struct net_device *netdev)
>>   static void ftgmac100_phy_disconnect(struct net_device *netdev)
>>   {
>>       struct ftgmac100 *priv = netdev_priv(netdev);
>> +    struct phy_device *phydev = netdev->phydev;
>>   -    if (!netdev->phydev)
>> +    if (!phydev)
>>           return;
>>   -    phy_disconnect(netdev->phydev);
>> +    phy_disconnect(phydev);
>>       if (of_phy_is_fixed_link(priv->dev->of_node))
>>           of_phy_deregister_fixed_link(priv->dev->of_node);
>>         if (priv->use_ncsi)
>> -        fixed_phy_unregister(netdev->phydev);
>> +        fixed_phy_unregister(phydev);
>>   }
>>     static void ftgmac100_destroy_mdio(struct net_device *netdev)
> 


