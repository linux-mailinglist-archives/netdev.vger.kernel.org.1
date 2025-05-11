Return-Path: <netdev+bounces-189595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C41CAB2B42
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 23:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1E861899D1A
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 21:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B142C1AA1D9;
	Sun, 11 May 2025 21:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqI5Dvi/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53D238DF9
	for <netdev@vger.kernel.org>; Sun, 11 May 2025 21:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746997585; cv=none; b=EQH402K4FSVuc/6Ptiha1Lji0IibMNU+qZwP19tD3AKxetEkCk0OFLJ2zJSoBW8E2a/ZDq8W9FB1lT6LPkhPjBhZYg4P3GoKzqPt4rlUhMY85A1SNYflU8yhASHjITgjVNPRiz00CY80H6nPVlJeSnhDRItfdTsaw1T8nZ4cSUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746997585; c=relaxed/simple;
	bh=Yparvh47DZUMmDg4hz1POyGhEXF3/29a+awFGUB1+3I=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=o/mTHecxH4IhIyLtbTfE3gilS/fYagUfmDDzesi8Jn05QEt+upXz7g54n+srQ+TdLT4+/Zpg9aa2SGL+KxPUaTWCVAhwgK9LasooIlmIveoCCSd/6RfLum6ojl4elD97Thokuf3e4i8ywd9WIxACbUofabuZDammGXq8gzLskrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WqI5Dvi/; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cfdc2c8c9so20820895e9.2
        for <netdev@vger.kernel.org>; Sun, 11 May 2025 14:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746997582; x=1747602382; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tvjb4mRr9IYq+BLguoXBjbpKA7hhbwJYkSPBEc2D78U=;
        b=WqI5Dvi/ITI1ejlChTNJNuW3DizOCreIBW2w7TxOsT8tm21mucKoWLo29lYVKxMFTF
         b+e547ZewSJB+1dwbB7pkzJf4/HVgsNUpS4PJBC/MGjri5C7VrtCilh2JCiJ0JWcoyez
         Yy7Sko+RMtqZV+33uzEF4M0FaMani5R3siAUTgxn7aBHGUlrAI6gMMHch29AVuPMK3pE
         kWXXXdKPVlSX659ezHrln6wNaIR9ESJoOIYmvEkYj8tdPPcKLg/BWRUhp7LsaRj1tojq
         aWfi91FyNjhonMlKhXSPkck2g3W9Mc7w+WqldQaWFyQ3n9dR3MfJ1ViQ060VTQllaDdM
         LnOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746997582; x=1747602382;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tvjb4mRr9IYq+BLguoXBjbpKA7hhbwJYkSPBEc2D78U=;
        b=W9sn8Msu7+yT+AMB6mNfJNj1yGKi12jG2LNfHDMShupQSC7OjIzeZ+IiwKXeR+eK2z
         ClP/Sl0E3+WUpNFEaEny+Iz6lHmp2VJFWPYGMV91ROk/sJV3FKmShoSI6A+0vRhTriDh
         1XudZ+4h3fniEo/uS/I8BF3uTo0tEdwUaQ2EbZCmIQ0+troM7aeseJEs66j1MK7+2C+0
         h8A8REChrRrPTjwrEOfFMNcgCktF9fFIq8Jxn1YRztFI7cL0eU2aTqD/6viEuJoCj5ws
         wLQQwkc69hzXypu/VKAi2NqY31Au4GlfPjAIx6+COD1YmoZ0q/UDSdfd7T7tXtogunhi
         7pxw==
X-Forwarded-Encrypted: i=1; AJvYcCWhvyFFDCFf3BgCvi7gIFogQXGwyepu3q1oLDaoDTa+NJ0T9Nqhk2si/7JGR3Kh27m/9mxgN38=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMrdzrK2krPCnunW5ym93eVaP3eStzhXdabYrTcvWHd7hV4jnW
	RaSl62RA3IDxJp5+xDK/R07afqnUNjPWiVDBYMbDdJ6V5HdwzGsf
X-Gm-Gg: ASbGncvtA/KcrNhYuogc+/ppUs0RGcVJ6ov3QCR73RbW6ux7y+e/+RSHqPLQCjJ9R8Z
	6dq/5pkeI3qpOKe9qbs/yO7gRYKfE2S4baqV+yAkq93usIaPbnNkcUPdK6MFNrM5SpmrIj4VCBb
	dlOTsdMQ9JLGPhlHOdkJTmGKuUcNMtqzn15RqZ4jTyGYZ83fXCMiITh7fjIxWsFnu1DwJoj0RtF
	+kUSK4XKA2HBf88r5qR7PLl2XIQ0ytByTKlBn1XxSY2PrA/Pg2CX52cNZvvsWgeqXY2hYzA1fkt
	Iksa//XYHq7rMDRyEF/vCRY+PpBnbRNO9tc9MZuaWzPQTGsF6vfHhQm30NOyZFXSwFrFD5ko+8G
	8t3jPcMU9h06TseZkkKEkem7M7cECcwaez3Z7TsWr9bPQAIkJPStWwRQAz4eEbtTwwftvQF6x5O
	Eww32lThOsv/MsIiw=
X-Google-Smtp-Source: AGHT+IHfMrdrZYUkBPsO5gXbfZrDhjtzT+/IQ57iHwbBK0o7+FJS5fnONsRBPu61wTGfMF/VqbDzYg==
X-Received: by 2002:a05:600c:a42:b0:43d:24d:bbe2 with SMTP id 5b1f17b1804b1-442d6ddcff4mr66728965e9.28.1746997581919;
        Sun, 11 May 2025 14:06:21 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f15:c500:b4b8:71b1:ffc8:3022? (p200300ea8f15c500b4b871b1ffc83022.dip0.t-ipconnect.de. [2003:ea:8f15:c500:b4b8:71b1:ffc8:3022])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-442d685c3bdsm101866495e9.29.2025.05.11.14.06.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 May 2025 14:06:21 -0700 (PDT)
Message-ID: <03e2e1c7-326f-4b0e-94dd-18536c2f537e@gmail.com>
Date: Sun, 11 May 2025 23:06:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: phy: remove Kconfig symbol MDIO_DEVRES
From: Heiner Kallweit <hkallweit1@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Claudiu Manoil <claudiu.manoil@nxp.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Wei Fang <wei.fang@nxp.com>,
 Clark Wang <xiaoning.wang@nxp.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, imx@lists.linux.dev
References: <9c2df2f8-6248-4a06-81ef-f873e5a31921@gmail.com>
 <aBs58BUtVAHeMPip@shell.armlinux.org.uk>
 <5ecf2ece-683b-4c7b-a648-aca82d5843ed@lunn.ch>
 <aBtYdq2NurrTIcJi@shell.armlinux.org.uk>
 <fbe1e3e7-cd44-4e13-8cae-9b128d896a0e@gmail.com>
 <c7771c90-9c0e-429e-b703-661e21e2b1e5@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <c7771c90-9c0e-429e-b703-661e21e2b1e5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07.05.2025 20:39, Heiner Kallweit wrote:
> On 07.05.2025 16:21, Heiner Kallweit wrote:
>> On 07.05.2025 14:56, Russell King (Oracle) wrote:
>>> On Wed, May 07, 2025 at 02:49:05PM +0200, Andrew Lunn wrote:
>>>> On Wed, May 07, 2025 at 11:46:08AM +0100, Russell King (Oracle) wrote:
>>>>> On Wed, May 07, 2025 at 08:17:17AM +0200, Heiner Kallweit wrote:
>>>>>> MDIO_DEVRES is only set where PHYLIB/PHYLINK are set which
>>>>>> select MDIO_DEVRES. So we can remove this symbol.
>>>>>
>>>>> Does it make sense for mdio_devres to be a separate module from libphy?
>>>>
>>>> I _think_ Broadcom have one MDIO bus master which is not used for
>>>> PHYs/Switches but regulators or GPIOs or something. In theory, you
>>>> could build a kernel without networking, but still use those
>>>> regulators or GPIOs. But given that Broadcom SoCs are all about
>>>> networking, it does seem like a very unlikely situation.
>>>
>>> I'm pointing out that:
>>>
>>> libphy-y                        := phy.o phy-c45.o phy-core.o phy_device.o \
>>>                                    linkmode.o phy_link_topology.o \
>>>                                    phy_package.o phy_caps.o mdio_bus_provider.o
>>>
>>> mdio_bus_provider.o provides at least some of the functions used by
>>> mdio_devres.
>>>
>>> obj-$(CONFIG_PHYLIB)            += mdio_devres.o
>>> obj-$(CONFIG_PHYLIB)            += libphy.o
>>>
>>> So, when PHYLIB=m, we end up with mdio_devres and libphy as two separate
>>> loadable modules. I'm questioning whether this makes any sense, or
>>> whether making mdio_devres part of libphy would be more sensible.
>>>
>> I was asking myself the same question. If mdio_devres is a separate module,
>> then it won't be loaded if no active phylib user requires the devres
>> functionality, saving a little bit of memory. However mdio_devres is quite
>> small and we don't gain much.
>>
>> For now I decided to keep the current behavior of mdio_devres being a
>> separate module. However if consensus is that we better make it part of
>> phylib, fine with me.
>>
> After thinking again, I'll submit a v2 and will make mdio_devres part
> of phylib.
> 
kernel test robot reported circular dependencies. So I'll re-submit
the original version, leaving mdio_devres a separate module.

depmod: ERROR: Cycle detected: libphy -> of_mdio -> fixed_phy -> libphy
depmod: ERROR: Cycle detected: libphy -> of_mdio -> libphy
depmod: ERROR: Cycle detected: libphy -> of_mdio -> fwnode_mdio -> libphy

>>
>>> Maybe the only case is if mdio_devres adds dependencies we don't want
>>> libphy to have, but I think that needs to be spelt out in the commit.
>>>
>>>
>>


