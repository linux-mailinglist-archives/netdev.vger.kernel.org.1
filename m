Return-Path: <netdev+bounces-172163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 560B7A506A5
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 18:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EB2616C787
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 17:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E2A245010;
	Wed,  5 Mar 2025 17:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0UNO2f/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f193.google.com (mail-yb1-f193.google.com [209.85.219.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279EC18D65C;
	Wed,  5 Mar 2025 17:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741196698; cv=none; b=KJgv3HSctZCYzRaKJ2bEPC6KrX5jtu9rwCUXl5s10uTcrnC/oWw9ROettlNAqV+zH5+EuP0KwD5323SIS1rTQl0jJ+3JBmwIX3OxcMw48Rx/V6KCQDoP0COXwbQvjOcf29B2GIlBV/4K5zxlVaVm8eY3RhGbWzAD8Udz9Cm0qj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741196698; c=relaxed/simple;
	bh=eru01qJPLZRma4cwnw7amedWbYee+QZrkhjm7vs2p94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lfTdVI4jJIC9XAj2uLpYRej+vA08GE4uq1bdfpBu48MkJqcWTRga8v12yZsz8Fwcp3yAa0ZG/sutJujvccMsf3btXTi/tLhX+ng+wJqL/J726H81CqhenrlpcpBWiV2Y+8Z2CQdRzSPBRveoHfJHhLvRPahqaRjG5rnYjoFHkbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0UNO2f/; arc=none smtp.client-ip=209.85.219.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f193.google.com with SMTP id 3f1490d57ef6-e62d132a6a7so561477276.3;
        Wed, 05 Mar 2025 09:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741196696; x=1741801496; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IrPArySxWj0hN/u8syEF3HrRazPbso2JNukCorkCFeI=;
        b=g0UNO2f/vAY+O/HrXcS9LLKQgmLA33JRacSA5zFR/vdVD+cVDtOQKWkDYLEv9V6AxK
         nPnRb72kl4JxHPh/VDidEnPAoB7MxWd5qOzAfcIU4Tp1M8cdjsbFKFQeX7sdZnBeyy1/
         A7TTCZmtgzLFu4h1SLE6kKa4Xs9xf0f+J/06f+yS2ZPEN8LH8mec2LDxYl2DfjPPUdaH
         IJCINNVDd25JPqlif7IWVYpTv9rEii0+Cs0zfxVWIZOG0MioP/G8hpJ4xEUGN7MzgUWi
         LVmXsdn2cmOXOQQJs8fFWOmvxA7AoNVCInjpr6kOumR0XnN7z/ZAEjJeNOMxZLlr/BDO
         xhCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741196696; x=1741801496;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IrPArySxWj0hN/u8syEF3HrRazPbso2JNukCorkCFeI=;
        b=CGDuosTP9gA7CmguUktN2horHXhMucc70wev4YQVFiWBnpTvI/780gkEgDMqzZspiT
         3Ed7RJbHy6yrqwYsspY3nkPOzvhs79rBMxKgsCfKrUgVcr8Zi3+n9GgMyR+M9PUTb2DX
         tvFgvi2yl2hVX6wRx3ccYMpMAmrJUr2ma9xGZ5gV2zi+hBXVhhkMkqxQYqG+5fNr87SX
         qwKGOLxyV/TyOwTUN+HakWj362vP/Lk94BO2/vAYZg2PQV+Jt/Wuowef9dSIbOo7+mvo
         6gZTAmWyKQKDmpAZA6tG3u3UdoN3zv5IICCV4yVaXEzWBloguYlp4u9wDP2WVIW+jO8T
         fWBg==
X-Forwarded-Encrypted: i=1; AJvYcCXsUnHRRxm3MI4lECa/i6aQPaIcbRqVxKogY6UIEhg10I9z61jHecnM8K6ucJdBH5BD032Y0gAY3z/EhnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn1vPLYw42+pI+v6UYP8y+pIn46Fz5F2yVHQwc8RXMGczvBoQa
	Sy5VdHZelZATP8YGzc+8MFPXfo7t7Rl5rknMH+2QLB3/0X5btuar
X-Gm-Gg: ASbGncuVYZbQnqgUeKa+eQ/rjeH6XhxsujvD/ql2CPUvXfz1vb1hBjrpSDHRYkfNk4b
	xUsGx+n/UJA+dhxvyhxqYnFbDDroNDuOUB3qPE53rVDCZYmNpC25UC3aZ8Q8NfjgiBgxzbDysgN
	gqwLygPu+fNFHVwIFPRmXq28sIwxU4a/3sftUUk+NjZ9L0dFRuFv3JJ1kryy93k2HKp0Ey5X1BR
	YQCHmA5qdW7JsclfAUtj9VxnJfDlR523TELZzrth3rOyNPtB62hc2OeDFwbr4jtSEk2pG6ndISe
	sfTG4DQyDusgjcxtHuekHhL+m96WZhw/n7Jf+T5epdhjXa9ku9T/5UXX708tFVkNY5U=
X-Google-Smtp-Source: AGHT+IEGqb6bMX99bdb48p+jlKdXJzi/Nxp56tDcGRzsT9dJZPEMisMbuuQK7XQwD8kll+UdneF4ZA==
X-Received: by 2002:a05:6902:1b12:b0:e60:c10f:c6b9 with SMTP id 3f1490d57ef6-e611e1b7408mr5441603276.15.1741196695636;
        Wed, 05 Mar 2025 09:44:55 -0800 (PST)
Received: from [10.102.6.66] ([208.97.243.82])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e60a3ab0251sm4419617276.49.2025.03.05.09.44.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 09:44:55 -0800 (PST)
Message-ID: <669d9f33-e861-482a-8fd1-849fc3d22cd2@gmail.com>
Date: Wed, 5 Mar 2025 12:44:54 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: dsa: mv88e6xxx: Verify after ATU Load ops
To: Andrew Lunn <andrew@lunn.ch>, Joseph Huang <Joseph.Huang@garmin.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org
References: <20250304235352.3259613-1-Joseph.Huang@garmin.com>
 <2ea7cde2-2aa1-4ef4-a3ea-9991c1928d68@lunn.ch>
Content-Language: en-US
From: Joseph Huang <joseph.huang.2024@gmail.com>
In-Reply-To: <2ea7cde2-2aa1-4ef4-a3ea-9991c1928d68@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/5/2025 10:14 AM, Andrew Lunn wrote:
> On Tue, Mar 04, 2025 at 06:53:51PM -0500, Joseph Huang wrote:
>> ATU Load operations could fail silently if there's not enough space
>> on the device to hold the new entry.
>>
>> Do a Read-After-Write verification after each fdb/mdb add operation
>> to make sure that the operation was really successful, and return
>> -ENOSPC otherwise.
> 
> Please could you add a description of what the user sees when the ATU
> is full. What makes this a bug which needs fixing? I would of thought
> at least for unicast addresses, the switch has no entry for the
> destination, so sends the packet to the CPU. The CPU will then
> software bridge it out the correct port. Reporting ENOSPC will not
> change that.

Hi Andrew,

What the user will see when the ATU table is full depends on the unknown 
flood setting. If a user has unknown multicast flood disabled, what the 
user will see is that multicast packets are dropped when the ATU table 
is full. In other words, IGMP snooping is broken when the ATU Load 
operation fails silently.

Even if the packet is kicked up to the CPU and the CPU intends to 
forward the packet out via the software bridge, the forwarding attempt 
is going to be blocked due to the 'offload_fwd_mark' flag in 
nbp_switchdev_allowed_egress(). Even if that somehow worked, we will not 
be fully utilizing the hardware's switching capability and will be 
relying on the CPU to do the forwarding, which will likely result in 
lower throughput.

Reporting -ENOSPC will not change the fact that the ATU table is full, 
however it does give switchdev a chance to notify the user and then the 
user can take some further action accordingly. If nothing else, at least 
'bridge monitor' will now report that the entries are not offloaded.

Some other DSA drivers are reporting -ENOSPC as well when the table is 
full (at least b53 and ocelot).

> 
>> @@ -2845,7 +2866,8 @@ static int mv88e6xxx_port_fdb_add(struct dsa_switch *ds, int port,
>>   
>>   	mv88e6xxx_reg_lock(chip);
>>   	err = mv88e6xxx_port_db_load_purge(chip, port, addr, vid,
>> -					   MV88E6XXX_G1_ATU_DATA_STATE_UC_STATIC);
>> +					   MV88E6XXX_G1_ATU_DATA_STATE_UC_STATIC,
>> +					   true);
>>   	mv88e6xxx_reg_unlock(chip);
>>   
>>   	return err;
> 
>> @@ -6613,7 +6635,8 @@ static int mv88e6xxx_port_mdb_add(struct dsa_switch *ds, int port,
>>   
>>   	mv88e6xxx_reg_lock(chip);
>>   	err = mv88e6xxx_port_db_load_purge(chip, port, mdb->addr, mdb->vid,
>> -					   MV88E6XXX_G1_ATU_DATA_STATE_MC_STATIC);
>> +					   MV88E6XXX_G1_ATU_DATA_STATE_MC_STATIC,
>> +					   true);
>>   	mv88e6xxx_reg_unlock(chip);
> 
> This change seems bigger than what it needs to be. Rather than modify
> mv88e6xxx_port_db_load_purge(), why not perform the lookup just in
> these two functions via a helper?
> 
>      Andrew

I will make that change. Thanks for the review.

Thanks,
Joseph
> 
> ---
> pw-bot: cr


