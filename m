Return-Path: <netdev+bounces-185503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B07CA9AB93
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 13:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 944DE16B8D3
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 11:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605291F5834;
	Thu, 24 Apr 2025 11:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OQLWUTgz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E10433A8
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 11:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745493575; cv=none; b=IfQURP5GuD4fE0y3clkx6jzYm3PBgEvnolDFafpDvB+trpvjZubMS/mIrCTkZuoS8mepjMOhjxGZrWF0duN+NIXOWOeoxU+vtamFJPtrz2gaciEvH/kOgIB7smnamIGcTOjfmR1uFDEQ9TjVy0JP0UNHmiT3/+eFA9pYr92brHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745493575; c=relaxed/simple;
	bh=Lef3LJcLWvlPCx2dx3DqtnT6/y9ED1VY40Y8HLKJHLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DYA6aOSSxoADIXa8/rVye/fgW8KulSZk/Xr1clWVoYVlrlXER+tksfP+yi5DMkYz5hH55szRK9Dpu8kpHKVnJ4qP36zkvSEP7Pq2Mkhuz7n6Bl/DE5sI9hzAqflm1t1FjfuppQhKyvAYtvd0LR0FSZl0bnnWNdk/aDYoWy1O8fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OQLWUTgz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745493572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bzx7KR46iIZIb+R4l7Ce1Sw/xRYo/0+s/bLe9DXjA+E=;
	b=OQLWUTgzmNClv5GoSUPB34INXFl06GmF0d6IWHHebQv9YP4+cbHI0F8bk03AgBiAvbgkdG
	ngT/fUc/t5GD1Dfk3XbzpiJf/V+dufwptglyAqGGfj57wTAtg0WKRo0rcJ4dT0KdKx5otn
	o2O32Lwoko21xCQD/Ow8a386TE/bXr8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-VhKqs0hpPiqXSiSeyvQKog-1; Thu, 24 Apr 2025 07:19:29 -0400
X-MC-Unique: VhKqs0hpPiqXSiSeyvQKog-1
X-Mimecast-MFC-AGG-ID: VhKqs0hpPiqXSiSeyvQKog_1745493568
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43f251dc364so4838265e9.2
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 04:19:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745493568; x=1746098368;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bzx7KR46iIZIb+R4l7Ce1Sw/xRYo/0+s/bLe9DXjA+E=;
        b=JeVjLACzxlKqSIkFlgDHLPNxsoz1slYdKdKjURtJL8T/f7iscTJ3BnE+m1U8nA1x9o
         tdGWxDaGTqe/g/Rtu2257nVfNqsjcPDYfasUBgsip2X0P3XI7Pb+VtL+jTuw3OOL4Qg1
         DQJvniwNPMQ0vho97LU7CSdZMgTqXufW68tde0Shjs96rzmfQ19Xs+8QWHNawQqM2RDf
         xMWLPnPLasecXfgnubqtWicVxm/JMAv0dIaCsDOQdcjeUk5EtDsMr8mYXpErDd8zWk/c
         YVjXxpote7R/o3/0wJ8KbaEwfGSheuCYO2uSHUEDJHb1FteZULusleFKKsTyo9iElPeJ
         ZPHw==
X-Forwarded-Encrypted: i=1; AJvYcCXrjmdU1ScpwyR6f54Zq4qrqmS0Tuw4n02LrlXHmUpKQMVeNZ5C9zyfdFPh3BO/XKSuBonLUFU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4N+oc5tkA8lrIaAwPKApCp1AF62oaJyTyU8i3iBnOlpQohccE
	MYNKtpcMRhaqEdenTooDuFyEGOWq+GAmzh6WlcpdeG9DhZqyvANFwSrWz2Fnyx3itk3oJXfG9VW
	fwULovh1h6E5hSqRDUfeoJw+O299IFTLbIf9r5Lp/kLWPBMmHIX0+1g==
X-Gm-Gg: ASbGncte3yn/dJKcP7gLOc3+oQjSh35sYCADpk3tcSFnhDLu3UJcmi5RszM8ujU2ViA
	RZNJZPFYJZxTPE+gsrvdrRpPCJNLSQaWdRhA3nfdJs4+bn1C4X/GETVfxY+hN+G38Q72w/MB9E4
	qUTz/SXoibx1KjCMvVuxEryAxDQiVwMDw0JDm2bF8EOAnYR9VskMxmZOaPTT0UrssAaD2Hc2lU4
	c4PPEjXVhbRCnvBj054cH4hBsI9+cM7qMxr0kNNmoFYqnw7j5OzA/TPpAxP2Iif9O/VVKQl/to6
	Wg20eZsCDQ6lQh7ltVbjHrZFlIsir8adPAFapNw=
X-Received: by 2002:a05:600c:384b:b0:43d:160:cd9e with SMTP id 5b1f17b1804b1-4409bd2295dmr23783285e9.17.1745493567929;
        Thu, 24 Apr 2025 04:19:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvDVI9tm/E6+nrZZJjCTTjoDjwSuUR69Vl/dO0bCx9vn5aK6eO3ANAy9rSrpVBCz2N7xPXEw==
X-Received: by 2002:a05:600c:384b:b0:43d:160:cd9e with SMTP id 5b1f17b1804b1-4409bd2295dmr23782935e9.17.1745493567545;
        Thu, 24 Apr 2025 04:19:27 -0700 (PDT)
Received: from [192.168.88.253] (146-241-7-183.dyn.eolo.it. [146.241.7.183])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a06d4c565esm1797641f8f.56.2025.04.24.04.19.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 04:19:27 -0700 (PDT)
Message-ID: <d9ccea14-04c1-4f5a-8b55-b6f9166289ab@redhat.com>
Date: Thu, 24 Apr 2025 13:19:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,v2] net: phy: marvell-88q2xxx: Enable temperature
 sensor for mv88q211x
To: Heiner Kallweit <hkallweit1@gmail.com>,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
 Andrew Lunn <andrew@lunn.ch>, Russell King <linux@armlinux.org.uk>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>,
 netdev@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
References: <20250418145800.2420751-1-niklas.soderlund+renesas@ragnatech.se>
 <5d416bce-9ad3-48cd-95bc-0436aefd4baf@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <5d416bce-9ad3-48cd-95bc-0436aefd4baf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/18/25 6:10 PM, Heiner Kallweit wrote:
> On 18.04.2025 16:58, Niklas Söderlund wrote:
>> The temperature sensor enabled for mv88q222x devices also functions for
>> mv88q211x based devices. Unify the two devices probe functions to enable
>> the sensors for all devices supported by this driver.
>>
>> The same oddity as for mv88q222x devices exists, the PHY link must be up
>> for a correct temperature reading to be reported.
>>
>>     # cat /sys/class/hwmon/hwmon9/temp1_input
>>     -75000
>>
>>     # ifconfig end5 up
>>
>>     # cat /sys/class/hwmon/hwmon9/temp1_input
>>     59000
>>
>> Worth noting is that while the temperature register offsets and layout
>> are the same between mv88q211x and mv88q222x devices their names in the
>> datasheets are different. This change keeps the mv88q222x names for the
>> mv88q211x support.
>>
>> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
>> Reviewed-by: Dimitri Fedrau <dima.fedrau@gmail.com>
>> ---
>> * Changes since v1
>> - Clarify in commit message that it's the link that must be up for the
>>   reporting to work, not just power up. Hopefully this oddity can be
>>   solved in the future by patch [1].
>>
> Following this link I don't see anything which would deal with incorrect
> values being shown if link is down. What are you referring to in detail?
> I think you have to modify mv88q2xxx_hwmon_is_visible(), or return an
> appropriate error in mv88q2xxx_hwmon_read() if link is down.

@Heiner: my take is that the temp reading oddity should/will be handled
in a separate (net) patch, let's not block this patch due to that.

Thanks,

Paolo


