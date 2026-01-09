Return-Path: <netdev+bounces-248556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DC2D0B5FE
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 17:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F2143029D3F
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 16:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D513644CF;
	Fri,  9 Jan 2026 16:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePPlebfZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6031F3644BD
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 16:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767977190; cv=none; b=YNFUbu6aTTg/kSOD64akts6Hz9v66AmQTW74cWsrxzDWx/nDoCIwgEmdQFRhc8LV9cRPr0xMCdHkMFtrVGVBmRU+7JcvpyV+ESa7TUkr3P7ysMAYailiUEc819hITmpJi2zHuJqQ7OJRYOj7ifgOOpGlZfAmyChvQGJvVuLLJWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767977190; c=relaxed/simple;
	bh=DwF3SqCOufYVEKJlQsLZXEKLkZR/ulbFkCnyykmzN0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vD5uGUtpU2xtafOfWVVVe9tPLXCug+Ay9TeLSaX4KqUdAduuq+ShLrrvb5hH4+WohYDPkL9Ly9TbnvyGcWhKxRqyM6ogg92iMcz5OSXciVnlco7Z67iy8ZxZliCa1GP0lADLIVo+CTkNHCC+nmD4C5UmtBodl3lQhrY3PZAEw4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePPlebfZ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4775ae77516so49177715e9.1
        for <netdev@vger.kernel.org>; Fri, 09 Jan 2026 08:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767977183; x=1768581983; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N2HTlKYpOW86DgnaF2KWZRrdaVbBQotXHitT2ePEDuU=;
        b=ePPlebfZyUe7PuIztjJ0NpEXeS285iX2hx3WxYZWBkrvdWiknsFPhYWAr8MQIUDAY+
         cQjTOwFJrdI8rnVINTKCBzGz4LBQ55E8F8GaiqnZK36t5DxVNY7YgvxBbJqW6XLsEWCa
         DLp0Fsakb+Laa4qlXlC/zjkwFNbHwyGg/8i01TlLHZou3WyDlZJAY8+BzN8C4mHE3jxw
         ZimR9ksOa2MbGL+VJk5MiVTCqAZ4jZi86fkUZ8XY6u6PRWxsdRTi9NG72zVpwQhubm61
         3PfZDcA7uZacxHWKMTOIrC0aohwhVaSlxzrgSE0ALpZZnioKhxdKs74UtkF2yvcaR66h
         bZtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767977183; x=1768581983;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N2HTlKYpOW86DgnaF2KWZRrdaVbBQotXHitT2ePEDuU=;
        b=trQPbdXT08eKkSV1BqWiP3VZ2mU2hAJIw8pfqZR2irO7qE/8gF5PIAzka70Unz7f/v
         Kc8syXAcKo/dc9fEayZNpwe/miks2i6a12JhVh3cEX89TlvTACii6bHVmNcJx5gz5Z/T
         oD51/l7tQPTMVcGIoW0lK3TB2+E0KvJfVpYSBENQeGlU9xHi8lUnq0Lgw5nAFAOmru8k
         AvYJ6AcCk13pkEzpdZJg4yS6UZcWDW136jAZ85bVPcUun87vOVUr+TDq4GImfg+j7lD4
         4TUHjQB6X7j02ujy4Gl7AnfFo6FtqLQp9JvO63R8SCHBYzKtVjTlaFnPF1P0wsOAkLPX
         mBXg==
X-Forwarded-Encrypted: i=1; AJvYcCUTysNpJxEMEu+ibAj+pfsYAWjPpQNFqN3ok9MvjIAfWYoHP+0eZjUVvClJDzipRj8UG6PwsA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiH9Kn8UMbhC8qhzRC7RjDFo6HTJF/BS4HQgfLoZShZZde+C0b
	muSFTKqtnyxXgyPqzJIkm50k9T0AE3MJTib4zyVVL0dMQULbDPs8BQkW
X-Gm-Gg: AY/fxX7MhQK1BATPBABDloU7b9e0IT82PZYetfL+yWjACiyXgZmcOkcclrnMD+kHvNv
	ZoWxL3+a3/bucbfnqYJ0Y94DVD0Op2nIXBfgbQapTpUQKlWbVORnjGfDhlWK4U6JaZq9Dz/Vosj
	elif4Xl6OZ2NG3orCgh/JfW7hhB2lrqF4OfswdC3YsultpE0lR4J2tcK3OBai55dyLexOKWlEEN
	zj2zc7ImBF/yStjBnh2ZzR9WQTroy8jixNu5mQNR+GJmXIefCOjDlZYCzI9m4ByI75O2h31cGu/
	GzsfawG2YCcxbf01m1/dQoyjw4Pimiov2ZQV/Q8rta2q8Ykr5iZkB3t34Ouu6s8XclKZlgOwRvB
	zC4lHWYaNaIuWs14r1IvjFXtqLqkQBosvP2JaaNjDQKo44uUmRu3LfNW8I6bWVd65ySPo1w2Baq
	jpEEprXJT1c5PP3quhRe4MFUPKDZaOw99a232XkQbTDZpPjhv+9D2oZ5Bi4ufRNVYhG7qBcsEsP
	kMWIpbuEEUO9NJd
X-Google-Smtp-Source: AGHT+IHnL0DXnjf5grmc8kFqboTCBQH7jNsckL4Ib5Ns6ZQkI8W4vFRRk1sMaI3PNYP25f/TkgV3kg==
X-Received: by 2002:a05:600c:3152:b0:479:1a0a:ebbe with SMTP id 5b1f17b1804b1-47d84b18db4mr121604445e9.14.1767977182547;
        Fri, 09 Jan 2026 08:46:22 -0800 (PST)
Received: from ?IPV6:2001:9e8:f116:2801:5cbd:7d69:3b4c:169? ([2001:9e8:f116:2801:5cbd:7d69:3b4c:169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f6953fasm210190305e9.5.2026.01.09.08.46.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jan 2026 08:46:22 -0800 (PST)
Message-ID: <a04ac2eb-1bf8-428a-8b77-639d01bfd5c4@gmail.com>
Date: Fri, 9 Jan 2026 17:46:21 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4] net: sfp: add SMBus I2C block support
Content-Language: en-US
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>
References: <20260109101321.2804-1-jelonek.jonas@gmail.com>
 <aWDw0nbcZUaJnCQX@shell.armlinux.org.uk>
 <aWErEyV8UhemgiRy@shell.armlinux.org.uk>
From: Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <aWErEyV8UhemgiRy@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Russell,

On 09.01.26 17:21, Russell King (Oracle) wrote:
> On Fri, Jan 09, 2026 at 12:13:06PM +0000, Russell King (Oracle) wrote:
>> On Fri, Jan 09, 2026 at 10:13:21AM +0000, Jonas Jelonek wrote:
>>> Commit 7662abf4db94 ("net: phy: sfp: Add support for SMBus module access")
>>> added support for SMBus-only controllers for module access. However,
>>> this is restricted to single-byte accesses and has the implication that
>>> hwmon is disabled (due to missing atomicity of 16-bit accesses) and
>>> warnings are printed.
>>>
>>> There are probably a lot of SMBus-only I2C controllers out in the wild
>>> which support block reads. Right now, they don't work with SFP modules.
>>> This applies - amongst others - to I2C/SMBus-only controllers in Realtek
>>> longan and mango SoCs.
>>>
>>> Downstream in OpenWrt, a patch similar to the abovementioned patch is
>>> used for current LTS kernel 6.12. However, this uses byte-access for all
>>> kinds of access and thus disregards the atomicity for wider access.
>>>
>>> Introduce read/write SMBus I2C block operations to support SMBus-only
>>> controllers with appropriate support for block read/write. Those
>>> operations are used for all accesses if supported, otherwise the
>>> single-byte operations will be used. With block reads, atomicity for
>>> 16-bit reads as required by hwmon is preserved and thus, hwmon can be
>>> used.
>>>
>>> The implementation requires the I2C_FUNC_SMBUS_I2C_BLOCK to be
>>> supported as it relies on reading a pre-defined amount of bytes.
>>> This isn't intended by the official SMBus Block Read but supported by
>>> several I2C controllers/drivers.
>>>
>>> Support for word access is not implemented due to issues regarding
>>> endianness.
>> I'm wondering whether we should go further with this - we implement
>> byte mode SMBus support, but there is also word mode, too, which
>> would solve the HWMON issues. It looks like more SMBus devices support
>> word mode than I2C block mode.
>>
>> So, if we're seeing more SMBus adapters being used with SFPs, maybe
>> we should be thinking about a more adaptive approach to SMBus, where
>> we try to do the best with the features that the SMBus adapter
>> provides us.

Makes totally sense, my initial version was just a pragmatic attempt to solve
the issues downstream for a single target. But covering byte, word and I2C block
is a better approach.

>> Maybe something like:
>>
>> static int sfp_smbus_write(struct sfp *sfp, bool a2, u8 dev_addr, void *buf,
>>                            size_t len)
>> {
>> 	size_t this_len, transferred, total;
>> 	union i2c_smbus_data smbus_data;
>> 	u8 bus_addr = a2 ? 0x51 : 0x50;
>> 	u32 functionality;
>> 	int ret;
>>
>> 	functioality = i2c_get_functionality(sfp->i2c);
>> 	total = len;
>>
>> 	while (len) {
>> 		if (len > sfp->i2c_max_block_size)
>> 			this_len = sfp->i2c_max_block_size;
>> 		else
>> 			this_len = len;
>>
>> 		if (this_len > 2 &&
>> 		    functionality & I2C_FUNC_SMBUS_READ_I2C_BLOCK) {
>> 			.. use smbus i2c block mode ..
>> 			transferred = this_len;
>> 		} else if (this_len >= 2 &&
>> 		           functionality & I2C_FUNC_SMBUS_READ_WORD_DATA) {
>> 			.. use smbus word mode ..
>> 			transferred = 2;
>> 		} else {
>> 			.. use smbus byte mode ..
>> 			transferred = 1;
>> 		}
>>
>> 		buf += transferred;
>> 		len -= transferred;
>> 	}
>>
>> 	return ret < 0 : ret : total - len;
>> }
>>
>> sfp_hwmon_probe() will do the right thing based upon i2c_block_size, so
>> where only byte mode is supported, we don't get hwmon support.

Thanks for providing this. I'll take that as a starting point and come up with
a better patch.

> I should also note that, when checking for the appropriate
> functionality in sfp_i2c_configure(), we need to be careful that
> we can read single bytes.
>
> In other words, if an adapter reports that it supports smbus word data
> access, we need it to also support smbus byte data access or smbus i2c
> block access.
>

Good that you mention it, haven't considered this yet.

Best,
Jonas


