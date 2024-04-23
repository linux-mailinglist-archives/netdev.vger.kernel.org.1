Return-Path: <netdev+bounces-90402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 222688AE04B
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 10:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB0E3282FA2
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 08:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634EF55C2A;
	Tue, 23 Apr 2024 08:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MrWSi8Pf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2D8335D3
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 08:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713862277; cv=none; b=a5SNfo8hsPp0zgMr5/Y3M3ymB5lOlX59pb56dwZ5Oq8XVCWr0tI8PzymenzNI0gyA6bZPyPvWbbAq2C7XyBha6j8CfL/gCOKOUcuFLjz9jjqD/V4Q3/xmNBoftXmh7b7UuavaGSceqD+ycCHTXPUwYM+Kx/KXEfM86YKxONzp3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713862277; c=relaxed/simple;
	bh=+BoeEmbdAK89bwxQkfuoQwFJs95Q6OdKjcMhP9nHIZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UYzku0rPVtLuCS2oxx83/DWsVKCvhVQK/eMt9PeLrgmia33fbwc7x2LiumuEDw9LtfMOr8M1iwG9Dzb9MDXTjmKNnnpHal7dt/9HLZH/kJfmwP/J289u3igewZWxUh86NqClOeBg7WcpE6tK+EvWIobB8a3GvT2jSBsdSWhPXtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MrWSi8Pf; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a51f9ad7684so321553366b.2
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 01:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713862274; x=1714467074; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O5Ft088w1fId5UT+vnYyc4OiAEIej4DZWj8ovlc2tP0=;
        b=MrWSi8PfKAnMYmqX48nYX08KpqZZDysKhTqqGrMBg8euUcoeyCDv4wtbhwAMkw+AS1
         zkcD68uZFPlGZIlm+hACl47uhEbHOq26RZvHakJIIAfBGO+dT+OlLt/xxEIb/M/L+Qro
         yoqguUtB4VdtoMTt6YRA1lVOVdBegzGZ1wWz/5vJRnEB6k/yoa7wSgXns6zWQlu68708
         x/IEN+4+lCuoSXooWnxwn6yQJUln0k3ood4foAr/ShF5d28YEvMq6C+uW1J4gpnjMGMh
         mNm5KZk/N9H6H1MpRb85VSS49F4ffC/rxH/czuM6v+y2pBt1sJmjp8dA7JINStMESPjy
         JrJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713862274; x=1714467074;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O5Ft088w1fId5UT+vnYyc4OiAEIej4DZWj8ovlc2tP0=;
        b=P9kivamlcBDEt9w7KMRCJdC770Rne91Cxp0Je3czd6GlNpCuzMnpBWdKDs0DwllGCN
         yimvJijy4sqRAM129OH32XXSk8ysyDk7NijME447R5THWA5NcYevOicBU4gvc0LnAkoN
         f98zSWI7hAfa0bV82j0HV5bM7kg0vXWPHM60PPmpMNQEzdLoUTko7IwJQIqNrorQmJZi
         36nNW6lXjYGFGXBinMEOcwdq6YmE+u2Lpd++INocyrXmJnOyfD4XdGcYZrAnhXFCL+hL
         xJI338l6NPMQz51PJIxMLdEC2xp8zMDV2p0ob5bxnhacllRfqUP39xQVuWjImLMU/ICI
         XDuA==
X-Gm-Message-State: AOJu0YwfX1q+3O4XhuOUOGkk4s6TGGoBVF6J3UpPZOT0S8GDQz3qmY5U
	J6L9neBBkgI1Rp0EL0VgX+xajTh7mV4JqoGx0Utbb+wxuE00HVnQV9ZfIQ==
X-Google-Smtp-Source: AGHT+IGlSy71XgVSBmzcwXq7fPidPeJcYQSwui6GdmcWSzlITFFZgcuNCCsq81+/PSRRWdcA1nj7hQ==
X-Received: by 2002:a50:a451:0:b0:56e:3293:3777 with SMTP id v17-20020a50a451000000b0056e32933777mr9793237edb.17.1713862273836;
        Tue, 23 Apr 2024 01:51:13 -0700 (PDT)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id c4-20020a056402100400b005720caa01easm2038904edu.69.2024.04.23.01.51.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 01:51:13 -0700 (PDT)
Message-ID: <919416c4-334a-42da-8140-3ee85e71c15a@gmail.com>
Date: Tue, 23 Apr 2024 10:51:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: sfp: enhance quirk for Fibrestore 2.5G
 copper SFP module
To: =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
Cc: netdev@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
 Raju Lakkaraju <Raju.Lakkaraju@microchip.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Simon Horman <simon.horman@corigine.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>
References: <20240422094435.25913-1-kabel@kernel.org>
 <20240422094435.25913-2-kabel@kernel.org>
 <ea9924d3-639b-4332-b870-a9ab2caab11c@gmail.com>
 <20240423104041.080a9876@dellmb>
Content-Language: en-US
From: Eric Woudstra <ericwouds@gmail.com>
In-Reply-To: <20240423104041.080a9876@dellmb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/23/24 10:40, Marek Behún wrote:

>>
>> Also any code I found for the yt8821 is C22 only. And even more, even
>> though we are facing with an almost similar MCU, RollBall protocol does
>> not work. I think it is almost the same mcu, as it responds to the same
>> eeprom password, and also the rollball password does something, but not
>> give the expected result.
>>
> 
> What about I2C address 0x56?
> 
> I noticed that the Fibrestore FS SFP-2.5G-T with the realtek chip
> also exposes clause 22 registers, but the current mdio-i2c driver wont
> work, because the module implements the access in an incompatible way
> (we would need to extend mdio-i2c).
> 
> Eric, can you check whether the motorcomm module exposes something on
> address 0x56? With i2cdump, i.e. on omnia:
>   i2cdump -y 5 0x56
> (you will need to change 5 to the i2c controller of the sfp cage).
> What does it print?
> 
> Marek

The device at 0x56 is not up at the time the eeprom is checked and read.
So when it is time to decide whether to use RollBall protocol or not,
the data at 0x56 cannot be used.

We have more info on i2cdumps on the BPI forum (rtl8221b topic and
yt8821 topic).

