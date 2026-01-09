Return-Path: <netdev+bounces-248557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC0CD0B688
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 17:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 323E3300856C
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 16:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4D03644C1;
	Fri,  9 Jan 2026 16:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLFIN7Q1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C1D50095F
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 16:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767977311; cv=none; b=REWj/94AgWkk35L/Kbjo7EPj35zc5ftrcIYrNU70NaucikGeiQEypz8cjaRBhu8mpmSaYoT8BpBURtigWpVsT5KsHFJ93gIqvA7yNYw/i/Y5/X2aE45n7op0RCIAKLkAsYhuYzGffnZsXIz70uLUG0hOPwAxJmvnn464CJbcVoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767977311; c=relaxed/simple;
	bh=pEw9/Gq13SmQvUNgKh7svxPebv6jRefx4XLFdD5yY+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y6ZCiNpDFwtrbiHoEBdjsOU2rlqygjm9eiUk3pcA6oQ8Mfgcd42eQ4rpFQikQ6LDIwRadYm5xzHLQ+C//PZTi+EktxL7ZAvUwdnMuN/iBxIkHYvINdti/btNQr9ihtywiO1neXmgMPgNOQMvUnlrCjyqgo/HnF5NXVNdCas6qC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kLFIN7Q1; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47d1d8a49f5so29849845e9.3
        for <netdev@vger.kernel.org>; Fri, 09 Jan 2026 08:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767977308; x=1768582108; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pEw9/Gq13SmQvUNgKh7svxPebv6jRefx4XLFdD5yY+8=;
        b=kLFIN7Q1ZiDoW0/03C3eoYLdPTDcVkj8MMragkw+nYu6G2abZ5qr0bZpyHdPLLxkqk
         DwehqhzLf8EW3UtS51X1B/dOIF8pSHobgfEbBmpSlSlo314OOUd7MPl/aphw5WhziCk1
         LeEL60TT2rfFmGSIsgMXD7t+jvu99YkZw6/feLxdzLnGQNNoLGq0Al7m+YbI4beg0uNh
         yNRm72ipHXxwZhNldChfK8xGpahTZFTtI+EQuNsfz2rcNPg+/7hGG2lNV+AqPOCZHIb2
         FC05Hjft+NZ5yIN3LtCJIwzKw2ni0s+IPSSiEB0zfahnHFGlK7HHM/jkQF/u4WIUDfvK
         CQ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767977308; x=1768582108;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pEw9/Gq13SmQvUNgKh7svxPebv6jRefx4XLFdD5yY+8=;
        b=bDyUnoRNvlMkbFvvSKxEChARSNapxlhEgI1kD3hv71Ucq3II9ez+HSzJQEnOzvZX7f
         dtbWxUA628ZIZQwsQQldLiWQkyQBl87H9nTyr+zJJvI9ZYMGjaBIe+QKqsQGicF3S7Rd
         LOqeF5aShnhivMgs6seZkDPAJ1y5ROql1k9xPnFU2rRnyqfGSmvT1XwdfUD8S4PRJjwZ
         OSBsUyCtUHrJLIFqTPaA7Op//DDAdrWDdrjvuE/bBKmiFbP9KzumSJAVT1cs+v8nr0RH
         BvzcyLImZPHBniv40kwJn2lPef65lMwdIO4Fag2hs7ppV12X2lxsMHdfKWGOgZNh/Xri
         2ogg==
X-Gm-Message-State: AOJu0YzJA1u7rjtLeRyludqTdFDyLHaOl2kmIeMoGHKpi2Jb/yf4qwXh
	eIOQV8+wNMGdRLU+73MzX6xbFj87wUaxLWbRgOfLjZ5S6e7w3K8ufOqX
X-Gm-Gg: AY/fxX7BkOGqr2Y85geIcKIxoMP/ZfshBGNYT9ZLSZuQCaumsm4hkJEil9s+8EaBPu3
	bHf0YjI/6oNiXpJRHCPYJFqVpqk9GgzqPRJKmPtq7o2fhawF3UFiKInfMcTXHVxUY3HKhkfprlP
	+9Hnmyz5z3Jzt3uDR0SEg5MXJPDU57K9NGaj4OA1un/9TbaPFSj+IpA00ENdBONzzOGhKHoBF4j
	14DYER6BUWxbCli9njePwsTazxu5FDDLmBP3iZ3TWczasOLPPkMPti2et+llXDQjUtbh+L27mPi
	WPAhSuWZ2KLxzBolcHTNCnwGDJ1SYPe7E5vUkDS9ZGHu0NGcshtgC/VCCRd7EHwvZhV+maFpjtk
	tjLEC5l+NmpjwzstB4qDrkdzoBGvul36GJt/HPlgFU7LzBs1UFL8E58vUJBsuEbOBkZUgp5fGfz
	fD+T0vWpQ+jmmXxKydBT6qRMYfrivKR+9SF95CIBpbhScJmzYNeDEVsCvMfcdK25DAhMKNi/hT3
	hUWew==
X-Google-Smtp-Source: AGHT+IGI5nsupq3rWJNQnF+bU5mo+kAONCP2tHg9upEUCl0EPvSbG1Y8KsHlGNZ5FmGlxx/Y3wZf6w==
X-Received: by 2002:a05:6000:40e1:b0:431:16d:63d1 with SMTP id ffacd0b85a97d-432c37a50aemr13343862f8f.44.1767977308388;
        Fri, 09 Jan 2026 08:48:28 -0800 (PST)
Received: from ?IPV6:2001:9e8:f116:2801:5cbd:7d69:3b4c:169? ([2001:9e8:f116:2801:5cbd:7d69:3b4c:169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432d286cdecsm9542332f8f.7.2026.01.09.08.48.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jan 2026 08:48:28 -0800 (PST)
Message-ID: <397e0cdd-86de-4978-a068-da8237b6e247@gmail.com>
Date: Fri, 9 Jan 2026 17:48:27 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4] net: sfp: add SMBus I2C block support
Content-Language: en-US
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
References: <20260109101321.2804-1-jelonek.jonas@gmail.com>
 <466efdd2-ffe2-4d2e-b964-decde3d6369b@bootlin.com>
From: Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <466efdd2-ffe2-4d2e-b964-decde3d6369b@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Maxime,

On 09.01.26 16:51, Maxime Chevallier wrote:
> Hi,
>
> On 09/01/2026 11:13, Jonas Jelonek wrote:
>> Commit 7662abf4db94 ("net: phy: sfp: Add support for SMBus module access")
>> added support for SMBus-only controllers for module access. However,
>> this is restricted to single-byte accesses and has the implication that
>> hwmon is disabled (due to missing atomicity of 16-bit accesses) and
>> warnings are printed.
>>
>> There are probably a lot of SMBus-only I2C controllers out in the wild
>> which support block reads. Right now, they don't work with SFP modules.
>> This applies - amongst others - to I2C/SMBus-only controllers in Realtek
>> longan and mango SoCs.
>>
>> Downstream in OpenWrt, a patch similar to the abovementioned patch is
>> used for current LTS kernel 6.12. However, this uses byte-access for all
>> kinds of access and thus disregards the atomicity for wider access.
>>
>> Introduce read/write SMBus I2C block operations to support SMBus-only
>> controllers with appropriate support for block read/write. Those
>> operations are used for all accesses if supported, otherwise the
>> single-byte operations will be used. With block reads, atomicity for
>> 16-bit reads as required by hwmon is preserved and thus, hwmon can be
>> used.
>>
>> The implementation requires the I2C_FUNC_SMBUS_I2C_BLOCK to be
>> supported as it relies on reading a pre-defined amount of bytes.
>> This isn't intended by the official SMBus Block Read but supported by
>> several I2C controllers/drivers.
>>
>> Support for word access is not implemented due to issues regarding
>> endianness.
> This patch should probably be accompanied with a similar addition to the
> mdio-i2c driver. for now, we only support full-featured I2C adapters, or
> single-byte smbus, nothing in-between :(
>
> Do you have something like this in the pipe ? not that this blocks this
> particular patch, however I think that Russell's suggestion of making
> this generic is the way to go.

I agree to Russell's suggestion and will work on that. Apart from that, I haven't
considered a similar change for mdio-i2c yet. No issue to deal with that but 
I think I have no way to test this properly.

> Maxime

Best,
Jonas

