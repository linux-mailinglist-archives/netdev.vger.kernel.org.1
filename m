Return-Path: <netdev+bounces-143156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D689C1485
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 04:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D240285EFD
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 03:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF3D7DA95;
	Fri,  8 Nov 2024 03:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LuaXZf2D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D567014012;
	Fri,  8 Nov 2024 03:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731036253; cv=none; b=uGtTx6L0Lv4r/VASmdm8h7o2NTX1iro8YqEB1SjAvtnB0AOAqDgbGtITsS8lgZYzcPvf+abx5oN5Cr/+rpBIqKXQiJP+zghqQiAChDyGvABI1yKAGp8dkERgFUs+AN5CIJb+TVCdHDIprLbcC9E0rgPW+ABGfN8FTc0Lwi7DlZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731036253; c=relaxed/simple;
	bh=IYaperpEdtSoZ06BR7dEbW6DPyyiwzWseXt2Fpea7Dc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DJt3yKVYdhnSDGl9/JaCUGF2/AZlFjAdSXBdfOX/eLJ47sQcdNsigEE3zUltpyhj4m4wjRkDjXjR0V0xNaLKwL9rNLmEVY1S5SKXzXpwOsVY+TFgt/hhUVVT5213uGQKiKzlA3VAaeLJYLLXMXDk9dsrB4odziWVslVRy9SCqVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LuaXZf2D; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-723db2798caso1870627b3a.0;
        Thu, 07 Nov 2024 19:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731036251; x=1731641051; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FiQi+zVrti/4lwYHeXMzDjh6Y9tSUZHidpZ6r5DzMFs=;
        b=LuaXZf2DI1AyA3TscXf6GhthunB73JMfzDVO0hNfzx33AMwL7+O0cKDbgr7yRZaNOE
         uMxpUs8zpnmbpDVp2O86+p/PCBKGwviWEfb+OsLJJ2J5Y+8PafFWKPwLTKuJ9OU5Uinp
         wq8CInKynUsS7MQnk3RJFXmORnF1VZd7NzcXw7PrnuveHWB+IU8f4b0xp3kMUIIRkriW
         ZFDaCNFPwr0t8NgGZiO2CYs7uTaMo7GbkpUlJbwHjJutsOqshuvKkhF04X44axJJv4QS
         o01V0serPSkf6bwiVBMuXBZCCULEO+NFQKlW/u7r2WQRKKN1OIOF/CxI+6zKBojD1E0t
         UTvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731036251; x=1731641051;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FiQi+zVrti/4lwYHeXMzDjh6Y9tSUZHidpZ6r5DzMFs=;
        b=DbFcNYqarDnf3AAmmeJ9sXJDh8Pvk6LuBEy3kNwYZI5uIKfMLWOcqFxI1Wdi9twt4u
         2+bfFioybolyn1yw1gbbkoNiueOmtZ8La3Sx8+WgB7R+3lxD2Fc7OKbyw0rKZiKqal+F
         oMHC/15ogL2rOOaXtcHP9EpIDcw7k5hflKgdhdv7OOhdIjDmcuQKCkhgbHHsG9IeByNq
         7I3OttQyZIgbkKJs/la08GH4YabsqDAiYDMUpkKclnU5Qsw9u+xJGpA4NA/MWOHub7Nz
         EvjiV8JSSKoewqV/fdlhalt/EA9cWmWiL6bdH8lc8BzPHw1ve6F85QUrYVl6+RoqZKTd
         jm3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUV32pIPtYUrpRBM7Nz5ChdP6O0CmpNEUNH7DhzvxW92Xn7g4Chn0VYMt3Bjdfqmr1ewkfPutdGMyYHgPu4@vger.kernel.org, AJvYcCUo3Q6RohNRJiasNP++8KJetcF7S02SW2NTBwkIlwC48FJy6nYxQ7p3UbskS7zXuux5DYCPZbeb@vger.kernel.org, AJvYcCUpvwIbTxFIwe8tBlrF3fNtMa6Edk/etbngpzcSRJ5zmEEcn4qFhtElfECikhszK4ax9C4y6YPcGR5D@vger.kernel.org
X-Gm-Message-State: AOJu0YyBwTimZFeoJcF3Gh34mjq+orNIOHzr0UM+XXOKt6Y8Ogq4tIyX
	khhsfqLKEtBb/hyEWZAo4dnBajdOCR28DGSgPw4Chh7HlqnM67cy
X-Google-Smtp-Source: AGHT+IEuCqDHEhTNFZCpyyg20d0b3Zu/p1XC6BTzBjuWov+1G8DqVUKH6K6wMKylQPRL5ggF5yB5RQ==
X-Received: by 2002:a05:6a00:1a89:b0:71e:4ee1:6d78 with SMTP id d2e1a72fcca58-7241327a424mr1559577b3a.1.1731036250950;
        Thu, 07 Nov 2024 19:24:10 -0800 (PST)
Received: from [192.168.0.104] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7240785fbe9sm2556540b3a.37.2024.11.07.19.24.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 19:24:10 -0800 (PST)
Message-ID: <7a476087-9efc-4271-bd2c-d04a0c1d0dff@gmail.com>
Date: Fri, 8 Nov 2024 11:24:04 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: net: nuvoton: Add schema for Nuvoton
 MA35 family GMAC
To: Conor Dooley <conor@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, mcoquelin.stm32@gmail.com, richardcochran@gmail.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, ychuang3@nuvoton.com,
 schung@nuvoton.com, yclu4@nuvoton.com, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20241106111930.218825-1-a0987203069@gmail.com>
 <20241106111930.218825-2-a0987203069@gmail.com>
 <20241106-bloated-ranch-be94506d360c@spud>
 <7c2f6af3-5686-452a-8d8a-191899b3d225@gmail.com>
 <20241107-slip-graceful-767507d20d1b@spud>
Content-Language: en-US
From: Joey Lu <a0987203069@gmail.com>
In-Reply-To: <20241107-slip-graceful-767507d20d1b@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Conor Dooley 於 11/8/2024 1:09 AM 寫道:
> On Thu, Nov 07, 2024 at 06:15:51PM +0800, Joey Lu wrote:
>> Conor Dooley 於 11/6/2024 11:44 PM 寫道:
>>> On Wed, Nov 06, 2024 at 07:19:28PM +0800, Joey Lu wrote:
>>>> +  nuvoton,sys:
>>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>>> +    description: phandle to access GCR (Global Control Register) registers.
>>> Why do you need a phandle to this? You appear to have multiple dwmacs on
>>> your device if the example is anything to go by, how come you don't need
>>> to access different portions of this depending on which dwmac instance
>>> you are?
>> On our platform, a system register is required to specify the TX/RX clock
>> path delay control, switch modes between RMII and RGMII, and configure other
>> related settings.
>>>> +  resets:
>>>> +    maxItems: 1
>>>> +
>>>> +  reset-names:
>>>> +    items:
>>>> +      - const: stmmaceth
>>>> +
>>>> +  mac-id:
>>>> +    maxItems: 1
>>>> +    description:
>>>> +      The interface of MAC.
>>> A vendor prefix is required for custom properties, but I don't think you
>>> need this and actually it is a bandaid for some other information you're
>>> missing. Probably related to your nuvoton,sys property only being a
>>> phandle with no arguments.
>> This property will be removed.
> I'm almost certain you can't just remove this property, because you need
> it to tell which portion of the GCR is applicable to the dwmac instance
> in question. Instead, you need to ad an argument to your phandle. The
> starfive dwmac binding/driver has an example of what you can do.

Yes, I will use this method instead.🙂

mac-id and tx/rx-delay will be arguments of syscon.

Thanks!


