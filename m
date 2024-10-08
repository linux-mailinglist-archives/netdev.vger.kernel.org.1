Return-Path: <netdev+bounces-133046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F63D99459D
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 12:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D1C31C248B3
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 10:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA111C2DBA;
	Tue,  8 Oct 2024 10:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RINhXa6E"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD388179953
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 10:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728384093; cv=none; b=Sgm8FQHbN0KlHTZfDJXKTyczfaUpZRtZ7nfSFN+nGWYJWbM/IE9X/S1QsZQkuU4sjLfnznKpW7XFvSwNlWEXAK0QouE/7a/LzreCHDY+FjhUxxHMe3kDxE5rbXqyc9r1qlu6AIMgkWB+pknSqbZ7+YzbVnjVdlbC/QGKfWwIFvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728384093; c=relaxed/simple;
	bh=WgKxJ9pCWs4GQb+jzYCJZb306YSOQP54ctM/2u9ohKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=NbqZQzzPTn0UBAtONYCrSahaEcpcQjJ0Quo94VIj38Cz1e/+dSJ6idiO41uhKNW81Q43z9Ov9mXduSlzp+8Ib0EU9JBDthVHMsIpBGiPLH3BGAuAJ0ldL+Cvyzgd5929xcJgXph82Kr8fC3fZXHuPjs1RGAVQAIeSqA2Gul5oNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RINhXa6E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728384090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gHHd2icZKgk4pSzuMgOd1pN2aINhcj29NSO/V6FULLo=;
	b=RINhXa6EELW790JJQwlmcsp495hCzPyU6meT/MK3Q2Kfdis3UT9i4kNSoKY8iHNg3SqaQu
	8iMgmmrn8Mn1C7Zy+9E7baPzm89qSVDFtb6gXlNmXBrJMX5vP8Qha60GegvynjR/vHpXB0
	R70FbVXZUAC4VIG01/RRJm06afZGDYc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-qcYPJV7aNBOHn04POBwSdQ-1; Tue, 08 Oct 2024 06:41:29 -0400
X-MC-Unique: qcYPJV7aNBOHn04POBwSdQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37cccd94a69so2812389f8f.0
        for <netdev@vger.kernel.org>; Tue, 08 Oct 2024 03:41:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728384088; x=1728988888;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gHHd2icZKgk4pSzuMgOd1pN2aINhcj29NSO/V6FULLo=;
        b=aV97DmcWBd/88YZZMp4nm6HcjwTMx09iFUHLQm6pw/gNRQA7nWJf9FKKWxp3hAiOcz
         XOA+6XGh7KGt7mDTAwNTkOLNHKEeTMJFWBeoXXvz3wbcwKLzUoxNB1FnNjhotOi5y16m
         8ai7UoqDBKfe3SYF0jrE5ylH3E1fvqG7f4NS3RmSKDHYeZQACdutYQ17Zt+y2B6bi865
         /DX6HEdaMabPn0/wnGdgUMa/78ZWsgCmTFR7PyB3QqnDBvSot7ZBGlDBOXnZb1uZO0nx
         y2yGEalbgsbZcE9r/e0DDkBrcyDikqvJp2pVY1xz0Z4bpn+iAHQVl1CIWsMnMPjxn8p0
         Z8lw==
X-Gm-Message-State: AOJu0YzX0KcjWDjVMnI4vhEctXC0T2UGCFmz70OS1ENrfE51oQoBAH23
	aDTciobusaXHCaqtKtVunIxjp6djKjueIw7wejUjPRPaXGTYaQqw5cw9zOwEKo+z/3v5noA7vlx
	4rH7Db9er5iIMc9bvSenJWzIs4qokwB8GVvRO/8XVy8A2x3HrQiSe5Q==
X-Received: by 2002:a5d:59a1:0:b0:367:9d05:cf1f with SMTP id ffacd0b85a97d-37d0e7374acmr12444786f8f.14.1728384088064;
        Tue, 08 Oct 2024 03:41:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE14dLeeJaBUEZBUmRwSG+MoB9O5AptGScWNuvSxEgmBpzkSQf1bA8IQGcOzD/JBRRzXAhfQg==
X-Received: by 2002:a5d:59a1:0:b0:367:9d05:cf1f with SMTP id ffacd0b85a97d-37d0e7374acmr12444768f8f.14.1728384087665;
        Tue, 08 Oct 2024 03:41:27 -0700 (PDT)
Received: from [192.168.88.248] (146-241-82-174.dyn.eolo.it. [146.241.82.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1688a486sm7837056f8f.0.2024.10.08.03.41.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 03:41:27 -0700 (PDT)
Message-ID: <89dd313f-e135-4369-8818-f5259c0879b8@redhat.com>
Date: Tue, 8 Oct 2024 12:41:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: phy: realtek: check validity of 10GbE
 link-partner advertisement
To: Daniel Golle <daniel@makrotopia.org>
References: <ZwBmycWDB6ui4Y7j () makrotopia ! org>
Content-Language: en-US
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <ZwBmycWDB6ui4Y7j () makrotopia ! org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 10/5/24 00:06, Daniel Golle wrote:
> On Fri, Oct 04, 2024 at 11:17:28PM +0200, Andrew Lunn wrote:
>> On Fri, Oct 04, 2024 at 04:50:36PM +0100, Daniel Golle wrote:
>>> diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
>>> index c4d0d93523ad..d276477cf511 100644
>>> --- a/drivers/net/phy/realtek.c
>>> +++ b/drivers/net/phy/realtek.c
>>> @@ -927,6 +927,10 @@ static int rtl822x_read_status(struct phy_device *phydev)
>>>   		if (lpadv < 0)
>>>   			return lpadv;
>>>   
>>> +		if (!(lpadv & MDIO_AN_10GBT_STAT_REMOK) ||
>>> +		    !(lpadv & MDIO_AN_10GBT_STAT_LOCOK))
>>> +			lpadv = 0;
>>> +
>>>   		mii_10gbt_stat_mod_linkmode_lpa_t(phydev->lp_advertising,
>>>   						  lpadv);
>>
>> I know lpadv is coming from a vendor register, but does
>> MDIO_AN_10GBT_STAT_LOCOK and MDIO_AN_10GBT_STAT_REMOK apply if it was
>> also from the register defined in 802.3? I'm just wondering if this
>> test should be inside mii_10gbt_stat_mod_linkmode_lpa_t()?
> 
> Yes, it does apply and I thought the same, but as
> mii_10gbt_stat_mod_linkmode_lpa_t is used in various places without
> checking those two bits we may break other PHYs which may not use
> them (and apparently this is mostly a problem on RealTek PHYs where
> all the other bits in the register persist in case of a non-NBase-T-
> capable subsequent link-partner after initially being connected to
> an NBase-T-capable one).
> 
> Maybe we could introduce a new function
> mii_10gbt_stat_mod_linkmode_lpa_validate_t()
> which calls mii_10gbt_stat_mod_linkmode_lpa_t() but checks LOCOK and
> REMOK as a precondition?

I think this last option would be preferable.

Thanks,

Paolo


