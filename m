Return-Path: <netdev+bounces-228328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D36BBC7EC7
	for <lists+netdev@lfdr.de>; Thu, 09 Oct 2025 10:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28D883A2BC2
	for <lists+netdev@lfdr.de>; Thu,  9 Oct 2025 08:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2552D7DF8;
	Thu,  9 Oct 2025 08:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AKw/JXTV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F318F2D5927
	for <netdev@vger.kernel.org>; Thu,  9 Oct 2025 08:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759996971; cv=none; b=VSwFCM7OulCjeMxga6Ej9Il+x1FpFQRoJOaqR4fX0OUGo/JWz4oOmXCzhS8f0E95ohy8ukl0VbWRFQRizDT6BKBVFIS5cayyxmCY0hh5V0VMsG2YIG4Jn/D2pZGUF+vM2GYkfVmh1dcH6Z5pCvaQ701R1V01qtC5wP/tXBji4hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759996971; c=relaxed/simple;
	bh=KfgP8PKHQkhMPJ6eadK+yTkypPjqTwhIA8NepWDeE9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kytn3sup3X1MXyHuGvSyRB4DbqKj1esoJ9aiJZQ3SrXiTecRKgSLvTydFfFMlGrlfIvoX8v3Qcjb4DCHp2GXIVRJd67W4UVmjAslcb0HNgXhGQhS08rcb97EJhbOrVCwQlHwYL3g58FS7QF/S6sZtfxn9BHuA0rHhET8Qx+A+p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AKw/JXTV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759996968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V6zsf8fjJWbuUz6EJwoT59Z49B5oYOEITBMV+N/RaV8=;
	b=AKw/JXTVyvDw4cD5PZBbcwJWzSxkLXr64lpoIyOfgUenGbtYo80Qjoh8PQrV6HvEjIg/Ca
	7gEBHPTqaJ2NDyJ2040eioPFF2feErLrjoYUoxzIRrC7A427HcuYt71/bT6/Vk36zfRnCW
	05u5OeleOkHAROlnxYNkCE5bbC2+NRQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-U9X_TVdyPAGVUSmF7JXZHQ-1; Thu, 09 Oct 2025 04:02:47 -0400
X-MC-Unique: U9X_TVdyPAGVUSmF7JXZHQ-1
X-Mimecast-MFC-AGG-ID: U9X_TVdyPAGVUSmF7JXZHQ_1759996966
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ece0fd841cso696730f8f.0
        for <netdev@vger.kernel.org>; Thu, 09 Oct 2025 01:02:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759996966; x=1760601766;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V6zsf8fjJWbuUz6EJwoT59Z49B5oYOEITBMV+N/RaV8=;
        b=j28EdzO5TEEc/xWm9JA2GjqtJyJhaLzUiBumd9MIbvVQil89Twnq3/WpCmsNbsE5Xv
         BbzfVy8gJY1dd5qQr+Ww0T5na/fn1qSCGBhEAzgh9OPnYwx/jWNxc6KxAwsgCf9QIV+5
         6XrEUKtBaHK9E7i97TPpiyxYJQyOeIzZy/dZD8alHG0tiYP1tM6vSWzfnMtQceGDTBJn
         ELDxP/7zFwkgRdeFrboskWukhshgbHVrPunsXByNXspdyeMEQuW9C375zdZXvtIHcTUm
         Efqn6zMqQmhhBz6d89HrjD04zvhOu1FjOg+ohce6d3CTz1BTfl1vv2CZXVdWQAQ9Rh23
         lj1g==
X-Gm-Message-State: AOJu0YxpsqnVqGnLwl7+UYbtdfztNLe84ChkxNnarWLci6KJg7bXn6rm
	iX5Rjj2x2p5tx3UF7EjSXFK4GHJmDF1APTW5dHeS73XLyxSMrVh/uCfm/9ce/pR/rNx77hk6jf4
	ALB59HOg2k5yZ7GnjdutbluDS5mXaGK8kG2CRqdxAmzx/ff5eMS04lh7Qs3KBf4i4fQ==
X-Gm-Gg: ASbGnctMi8XX9zfCeYh/+T3Uxb5TQoJwPawH+8Co6YWXztAx+jgtRmxhvfRclFQF06/
	klgKptadH2eya0YaTn4MHIMt5l69Zr/bwDjNl9+xc0kQSoW4lVTp2xsLacn/Bbi/3Kznl7Tif/v
	qheSrU4j3OUavMd0/7VMzgexbNIx+n3qKtWG4BJXokdWaStjRy/e/lHYeKop/ANvWc/8GQmIFlT
	SBhBMrjkaBw8Vb57AgSgs8ussA1NB3X07aUXuuK79roPF+w4fxMOMlE/KV2JaejsgnwomIj+AvZ
	YinhbMz3q0v2FPdAuFCKfLgesEksGhenkOGQJsWQqbgLZvJCQ5bj7RpqPRCDjuRWFGMTjabtoBb
	GY1um1GFceMm9b+uX1w==
X-Received: by 2002:a05:6000:26d0:b0:425:8bf9:557d with SMTP id ffacd0b85a97d-4266e8dd3c2mr4394918f8f.44.1759996965730;
        Thu, 09 Oct 2025 01:02:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErg2jmKIzfr0le15oKD1DjKM11Y25v2S6Dk1KGneA1BBfPBadVcx+OCodmaVYpJSX8X4ibLA==
X-Received: by 2002:a05:6000:26d0:b0:425:8bf9:557d with SMTP id ffacd0b85a97d-4266e8dd3c2mr4394872f8f.44.1759996965224;
        Thu, 09 Oct 2025 01:02:45 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f45e9sm33944702f8f.51.2025.10.09.01.02.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 01:02:44 -0700 (PDT)
Message-ID: <ef6fd852-0e9a-41fb-a4f9-8cc95c78f9bd@redhat.com>
Date: Thu, 9 Oct 2025 10:02:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: usb: lan78xx: Fix lost EEPROM write timeout
 error(-ETIMEDOUT) in lan78xx_write_raw_eeprom
To: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>,
 Thangaraj Samynathan <Thangaraj.S@microchip.com>,
 Rengarajan Sundararajan <Rengarajan.S@microchip.com>,
 UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, khalid@kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org,
 david.hunter.linux@gmail.com, stable@vger.kernel.org
References: <20251009053009.5427-1-bhanuseshukumar@gmail.com>
 <b183a040-3d1c-47aa-a41a-9865ba70b94d@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <b183a040-3d1c-47aa-a41a-9865ba70b94d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 10/9/25 7:41 AM, Bhanu Seshu Kumar Valluri wrote:
> On 09/10/25 11:00, Bhanu Seshu Kumar Valluri wrote:
>> The function lan78xx_write_raw_eeprom failed to properly propagate EEPROM
>> write timeout errors (-ETIMEDOUT). In the timeout  fallthrough path, it first
>> attempted to restore the pin configuration for LED outputs and then
>> returned only the status of that restore operation, discarding the
>> original timeout error saved in ret.
>>
>> As a result, callers could mistakenly treat EEPROM write operation as
>> successful even though the EEPROM write had actually timed out with no
>> or partial data write.
>>
>> To fix this, handle errors in restoring the LED pin configuration separately.
>> If the restore succeeds, return any prior EEPROM write timeout error saved
>> in ret to the caller.
>>
>> Suggested-by: Oleksij Rempel <o.rempel@pengutronix.de>
>> Fixes: 8b1b2ca83b20 ("net: usb: lan78xx: Improve error handling in EEPROM and OTP operations")
>> cc: stable@vger.kernel.org
>> Signed-off-by: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
>> ---
>>  Note:
>>  The patch is compiled and tested using EVB-LAN7800LC.
>>  The patch was suggested by Oleksij Rempel while reviewing a fix to a bug
>>  found by syzbot earlier.
>>  The review mail chain where this fix was suggested is given below.
>>  https://lore.kernel.org/all/aNzojoXK-m1Tn6Lc@pengutronix.de/
>>
>>  ChangeLog:
>>  v1->v2:
>>   Added cc:stable tag as asked during v1 review.
>>   V1 Link : https://lore.kernel.org/all/20251004040722.82882-1-bhanuseshukumar@gmail.com/
>>
>>  drivers/net/usb/lan78xx.c | 11 +++++++----
>>  1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
>> index d75502ebbc0d..5ccbe6ae2ebe 100644
>> --- a/drivers/net/usb/lan78xx.c
>> +++ b/drivers/net/usb/lan78xx.c
>> @@ -1174,10 +1174,13 @@ static int lan78xx_write_raw_eeprom(struct lan78xx_net *dev, u32 offset,
>>  	}
>>  
>>  write_raw_eeprom_done:
>> -	if (dev->chipid == ID_REV_CHIP_ID_7800_)
>> -		return lan78xx_write_reg(dev, HW_CFG, saved);
>> -
>> -	return 0;
>> +	if (dev->chipid == ID_REV_CHIP_ID_7800_) {
>> +		int rc = lan78xx_write_reg(dev, HW_CFG, saved);
>> +		/* If USB fails, there is nothing to do */
>> +		if (rc < 0)
>> +			return rc;
>> +	}
>> +	return ret;
>>  }
>>  
>>  static int lan78xx_read_raw_otp(struct lan78xx_net *dev, u32 offset,
> 
> Hi,
> 
> The subject prefix must be [PATCH v2] instead. I overlooked it. Should I resend it?

This is not a review, and given the current amount of queued patches a
real one will not follow soon, but please do not send a new version just
for this.

Thanks,

Paolo


