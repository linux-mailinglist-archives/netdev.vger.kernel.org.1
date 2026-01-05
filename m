Return-Path: <netdev+bounces-247113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB64CF4C04
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 17:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A74B30CC03C
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 16:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C674A34846A;
	Mon,  5 Jan 2026 16:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lo/yI9IN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DDA305046
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 16:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767629972; cv=none; b=EFw6NjGLg6t/2Jd6vi0H5ikZ1sxvik+XYuGd6X82QQHuAvEWbYzfQaCOqJ0to6VPgYYHoV9VKkQ3b8aDpZIFXknWZr+px6trsjmMuB0PsLqswCQK/LpkAyXROVm97nGNbtNV4G9V7SDhIXfZfoFAKa1BsvvOu3D/dZF1N8Yw/oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767629972; c=relaxed/simple;
	bh=a36Fpl8dK7Cm4QBDTUTt8YmQybW2yw4PWrJPCwvYWnU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CiViN0taA81Mqcb8IDuhn/vOGiZEt4FMLTx1/Am2vz7BqVyn1CP/kKnPjpD2kNxGAYSPdZp14k58OqW3p5QyZIWJCHXCSYSanq+g5G3gCKi53X9np9aNAg1PNgNxlJXRGf1NZvAR89qdv98Cg/HDEGoxuTUjtGBS2rWqklITpXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lo/yI9IN; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b76b5afdf04so24802966b.1
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 08:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767629969; x=1768234769; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8vbHP6EgxfnPPG46ofBR2iGBWBGXr2Ynn4AlyB7dNSQ=;
        b=Lo/yI9IN/AD9KALDdtHM0Xf+/VtyrtVeLXVbL7fjrj4NgvHuQadgw1fGDpXdLEIciz
         v9WPY6jJDngis6tZNC62w3iW2c2cBCexjOUQlgbyOVCjUJOZmoDuMziqsfe3Q6kgJm7D
         xwpgcwI1leMVUgCB/xonbc+J4VtdlGnKyAy83cLrvOMCawkejfQh6JTneTbRnyfqciuT
         zyo3Xa4Zfuayalsbl6Qlx9HpxpSEu4zeVqwIEme39j8mUYi2IPXjjuzAnl4K1lyouDFQ
         Tt2OD7WA/VyGSRKVRrM+SkcDF4YmB7opzU8yZLKwqzXL2zolYexa2cFvm5h6+DqEvKJd
         Oz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767629969; x=1768234769;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8vbHP6EgxfnPPG46ofBR2iGBWBGXr2Ynn4AlyB7dNSQ=;
        b=sxny4XNBWI0ZkQKvcjbcyOFbPmjX6LzFmbbiBK8omq/Eyqyckv+ElhF2DW1nasHtiK
         neXzuNwSKHeShadTuug7pFXG4yfwgJNrCMxP9v7b1gdzQnHz+SwutWVq54VWjs4OJvsi
         wE1hp21OmAAN+CO3rBcoS3ZdchzdhF5KjTuJIZ04zCexdUrXlAjUryxJbXnlelF5tf8T
         BeZEYinelm8zJdJowbwFg+T2IJpFnefjse+AtYP2sEeRtg8W0kWqC3oINvWgFGH4HtZe
         OLg2N5FF5yn+9KMayoNTcqHVSs3agb0kQmH1yZooEI/Qdk1Us1XVvmVPfct9S4tbRkMZ
         oZEg==
X-Forwarded-Encrypted: i=1; AJvYcCVeYf2vM3dcH38Q6uxAxFvt6oyle+rrJ0Dw/pk32gEPGUempe6HK3h/slz/Jut4Jxv+UddwTfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDk58JgSVtlOO1Pi8NAASat5FYCkbGj/Bns5/oo16ARvW1ENm2
	as9Y6hkIO6Q7G2ya76iSUjccRuwFrA1gVnUiZu7j5bKH5HIzIN93R/9Q
X-Gm-Gg: AY/fxX4VDkinpXoaOKq0S3iBc0DwmoOQgQ4fIny6XUVSNgDdREKAp4wFBxbQTx8BRyc
	tBUW2HFdG6U22Gy80v/4LU4uJkIZ+uSnv1MMVb2mNNFydkrf8US/bY3t7mdLaj5MWCi62mea0NE
	m0QjZxkaukLta0ykTGfGVqk6fVBr8pNDitveUK8Gi2RnOAlsxk7K0d4vtigeki51xHp7Ofqwe2v
	GmhUY541uoG5E/YMhQcbWvI8oxTav0cNdfhfuTKn+JTuQdzZwYbq/DWiHivUGGPd6pEpH5i/BkE
	UOWwyMftHgoS5Mguwqhrqba1IXg7EJHr0eG52QzkAWcOEgfrQz+mavPe3LK5vV5A7xhHw88duMh
	YxrS7Z+geEb7P+yp8vrF1MM9faw+F7YPHvcoOUhKmOSRo/rJlzD8gPh9eucOmJP+Jo3t4PkYhWG
	Qq8xFbrK3YQ37fwFTusr9bLIa+Wg2LBW+rtWmaZNtt85MkFGjd8oGinth8yQimjfVfEannPQiYy
	I8=
X-Google-Smtp-Source: AGHT+IE7UBVxHf8IfqaF03Np4FiKfyEW4mW5ECPUq+FGOrE+adYr7A3rTwSvGxpJ/o2ddY5uk1NIUg==
X-Received: by 2002:a17:906:f582:b0:b80:4478:d43f with SMTP id a640c23a62f3a-b8426a423d0mr32590366b.2.1767629969089;
        Mon, 05 Jan 2026 08:19:29 -0800 (PST)
Received: from [192.168.255.3] (217-8-142-46.pool.kielnet.net. [46.142.8.217])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b84265abec6sm32761566b.14.2026.01.05.08.19.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jan 2026 08:19:28 -0800 (PST)
Message-ID: <f976d637-defd-4e32-8a82-6705e69246d2@gmail.com>
Date: Mon, 5 Jan 2026 17:19:27 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: sfp: add SMBus I2C block support
Content-Language: en-US
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>
References: <20260105154653.575397-1-jelonek.jonas@gmail.com>
 <aVvjyWzKuczNf3lt@shell.armlinux.org.uk>
From: Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <aVvjyWzKuczNf3lt@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Russell,

On 05.01.26 17:16, Russell King (Oracle) wrote:
> On Mon, Jan 05, 2026 at 03:46:53PM +0000, Jonas Jelonek wrote:
>> @@ -765,26 +794,70 @@ static int sfp_smbus_byte_write(struct sfp *sfp, bool a2, u8 dev_addr,
>>  		dev_addr++;
>>  	}
>>  
>> +	return data - (u8 *)buf;
> A separate fix is being submitted for this.
>
>> +}
>> +
>> +static int sfp_smbus_block_write(struct sfp *sfp, bool a2, u8 dev_addr,
>> +				 void *buf, size_t len)
>> +{
>> +	size_t block_size = sfp->i2c_block_size;
>> +	union i2c_smbus_data smbus_data;
>> +	u8 bus_addr = a2 ? 0x51 : 0x50;
>> +	u8 *data = buf;
>> +	u8 this_len;
>> +	int ret;
>> +
>> +	while (len) {
>> +		this_len = min(len, block_size);
>> +
>> +		smbus_data.block[0] = this_len;
>> +		memcpy(&smbus_data.block[1], data, this_len);
>> +		ret = i2c_smbus_xfer(sfp->i2c, bus_addr, 0,
>> +				     I2C_SMBUS_WRITE, dev_addr,
>> +				     I2C_SMBUS_I2C_BLOCK_DATA, &smbus_data);
>> +		if (ret)
>> +			return ret;
>> +
>> +		len -= this_len;
>> +		data += this_len;
>> +		dev_addr += this_len;
>> +	}
>> +
>>  	return 0;
> This is wrong. As already said, the I2C accessors return the number of
> bytes successfully transferred. Zero means no bytes were transferred,
> which is an error.
>
> All callers to sfp_write() validate that the expected number of bytes
> were written. Thus, returning zero will cause failures.
>

yes. I totally messed up v2 but already pushed out a v3 that fixes that, and
has the separate fix as a prerequisite.

Sorry for the confusion.

Best,
Jonas

