Return-Path: <netdev+bounces-223213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEB6B58543
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 21:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 370884833E9
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 19:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5296D27D77A;
	Mon, 15 Sep 2025 19:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLWoOQ30"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708D722F01
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 19:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757964343; cv=none; b=FCoOpdfrPzPj+kQeRPL7A37GLh71muqsLjZdrGul9BF1TM+2/h+ZJS7uwOylOXjfRsX+KwXyG2woSy4N3CuiiZFXrDG7YadUXg/6OsnF62lLeGqIQqZRAADspGfTTJLUdh1g75TWkFVdjipCvl2xrT8FF5BykWr/kc74pEzS4M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757964343; c=relaxed/simple;
	bh=fQVUGCUIXuaFo1Urwv1kuILRhXR3rPrEGQZlyHN9H8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fZy+MzyyMa3m9ct2jq6b+g4tRDkg9i/27lZVSN9l4Zw78Lm4kEnmi4EojdMrIasioyi6aeD4+mkOPj2bfzdKPIuk54hatWtqdcwOUZh7t1A1bxHQYj1UerwE7fkHMKmMJKk9G8K9YozK0pHx9l797nf+cmfgXvBz7jLjawk/J+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLWoOQ30; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b9edf4cf6cso3398675f8f.3
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 12:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757964340; x=1758569140; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UMi8nMDjSvcc/4oPjLyj9SwiZzkeUlr+be6gfQzi07E=;
        b=dLWoOQ30AKb5ncDW0wN/LmGt5zsFlOFnknhjYtPmC7nXyeuNiE8E2sGwv1doN9ezCo
         noSx6gBhv+kZ1sNvbwSI9uIwXjMUuSXuvb6yW1y2w4nwI3wHavwoAxkIgw04UM4+YLCf
         d38VkcB8NnVU1aA0uLIEWwT2JmCQ4GOVfG/44fhXJT5ahvCn31whgNjdCfrtw0N3Cctt
         pALH/0Il44sp1q4aF/kRqz9JAnyUI9qE+twv/qC4KCLJbJXpwZa+afCfe0pHutlj/gCb
         LAJ7yyiNSP+YvED7GOMyJzbNdQxZb4xP3g69y08JhrqTB0ArIpCNu1d73nSUV2lMJtlc
         rmGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757964340; x=1758569140;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UMi8nMDjSvcc/4oPjLyj9SwiZzkeUlr+be6gfQzi07E=;
        b=ow0+xJH+SyNMnNeHEiYJlpekOsqDtZEUibzDlmConMhqQ+RtD8orhjJzrxnK7pIGbf
         JJCASBElRUrpTnY/bPMJC6FjvWnmsFPcH9eY7tlSMald4SETl8O3BnWyQLk7paujTS0P
         oaXwGGctZikqEjqFm7lLCX1MhCYS2u6tet5FEasNCfbNNGwDy2DTBEFAFxZU6aI7FXVG
         XUx+5uprd3Xk/qZsv/n7K3O0Mh4bOGB8p1PHynlJDP1Kd4FvnrRJ4MR/gqrnIN8xVJsK
         sOfntwpmr6y+zLeHVwPiy170+yBeK/UvbMJnEPsSMC9LRXFNmhqTVTHu5KcelxZojCb0
         dGUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWx7aSxILgp/VT30LMZeyxAQbAKIQybjzsLYeSsSFcFSgfovRfHT78jMWdmNhtGUnLnWNgDV+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtTtlsynstiNh5+C3HNOZFUST7pTGeKkHjwrVhhVjx76i72J7p
	bgSOi6EeOIAn41ESoKUwhibhU0e5n04Y5YNzKrcf28bG6ZOVD8qbTXHQ
X-Gm-Gg: ASbGncv1YVKIxaEJs6GHlpU/++pEkuCj7CignZG12WV2+XledofajcGwl8PUOs9K26O
	gMat2K4Fn4A6Y1CSEeEeYLq8HzzYhF9zYJmRyJyqBZrDZUHdUePd9tZxXJ7M2vkpClEwb4aJzrO
	QfvVT3VlUGAN9XrlZoD6mLeEexEyS4XE8LIVllo8L8Gxza654XbxfZuqnngpfZ2HuYD9SWxRXiN
	FEFLfxtucyOhoIUig02v5oFikrR2kJq6oTa0k68dd7Z8TIUORYPJdP0rfIFYFbKeqgEjpkthQpN
	njqT4f8HzNgGgBESZF6FNyMuZqklf0hJr538nvfsdzlgYGnHakxhjk8q8OdwCUj2Kvxj9xv9VFp
	Gc7iQQE0Pe+n3fnJoMb1HEFFjBbGcOs9s8y+W4yqOL3lsz4RTvaIX39lf0xM9MbTTH1SMzU4QMn
	Sa67LVYpbNvCmkve1Asj0QRbL8diCV2+MgJK2aRSAc1+vVQIXAmycQHQ/udbHKCYroJrTTazYrr
	YcMGXhvLy0=
X-Google-Smtp-Source: AGHT+IEgi9fktpWrxoxiVpaufU35Q/Bff224hnIAaOdHErf/XZE7j/ho/zlwoBMI9eWjoKuEhErftQ==
X-Received: by 2002:a5d:5d82:0:b0:3c7:36f3:c352 with SMTP id ffacd0b85a97d-3e765a562b3mr12714085f8f.59.1757964339590;
        Mon, 15 Sep 2025 12:25:39 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f28:4700:f9c8:b333:70a3:96ba? (p200300ea8f284700f9c8b33370a396ba.dip0.t-ipconnect.de. [2003:ea:8f28:4700:f9c8:b333:70a3:96ba])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3e9511abbccsm9116774f8f.9.2025.09.15.12.25.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 12:25:39 -0700 (PDT)
Message-ID: <ec602131-ed22-44a8-a356-03729764a690@gmail.com>
Date: Mon, 15 Sep 2025 21:25:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] r8169: enable ASPM on Dell platforms
To: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>, nic_swsd@realtek.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Wang, Crag" <Crag.Wang@dell.com>, "Chen, Alan" <Alan.Chen6@dell.com>,
 "Alex Shen@Dell" <Yijun.Shen@dell.com>
References: <20250912072939.2553835-1-acelan.kao@canonical.com>
 <cc91f4ab-e5be-4e7c-abcc-9cc399021e23@gmail.com>
 <rqeme247cojqejerkedcj7m6t6zglks3pe2wcro3xvprit6npt@s4ymo5357hiv>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <rqeme247cojqejerkedcj7m6t6zglks3pe2wcro3xvprit6npt@s4ymo5357hiv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/15/2025 3:37 AM, Chia-Lin Kao (AceLan) wrote:
> On Fri, Sep 12, 2025 at 05:30:52PM +0200, Heiner Kallweit wrote:
>> On 9/12/2025 9:29 AM, Chia-Lin Kao (AceLan) wrote:
>>> Enable PCIe ASPM for RTL8169 NICs on Dell platforms that have been
>>> verified to work reliably with this power management feature. The
>>> r8169 driver traditionally disables ASPM to prevent random link
>>> failures and system hangs on problematic hardware.
>>>
>>> Dell has validated these product families to work correctly with
>>> RTL NIC ASPM and commits to addressing any ASPM-related issues
>>> with RTL hardware in collaboration with Realtek.
>>>
>>> This change enables ASPM for the following Dell product families:
>>> - Alienware
>>> - Dell Laptops/Pro Laptops/Pro Max Laptops
>>> - Dell Desktops/Pro Desktops/Pro Max Desktops
>>> - Dell Pro Rugged Laptops
>>>
>> I'd like to avoid DMI-based whitelists in kernel code. If more system
>> vendors do it the same way, then this becomes hard to maintain.
> I totally understand your point; I also don’t like constantly adding DMI
> info to the list. But this list isn’t for a single product name, it’s a
> product family that covers a series of products, and it probably won’t
> change anytime soon.
> 
>> There is already a mechanism for vendors to flag that they successfully
>> tested ASPM. See c217ab7a3961 ("r8169: enable ASPM L1.2 if system vendor
>> flags it as safe").
> Right, but writing the flag is not applicable for Dell manufacturing
> processes.
> 
Can you elaborate on why this doesn't work for Dell?

>> Last but not least ASPM can be (re-)enabled from userspace, using sysfs.
> That doesn't sound like a good solution to push the list to userspace.
> 
> Dell has already been working with Canonical for more than a decade to
> ship their products with r8169 ASPM enabled. Dell has also had lengthy
> discussions with Realtek to have this feature enabled by default in the
> r8169 driver. I think this is a good opportunity for Dell to work with
> Realtek to spot bugs and refine the r8169 driver.
> 
One more option to avoid having to change kernel code with each new
and successfully ASPM-tested system family from any system vendor:

We could define a device property which states that ASPM has been
successfully tested on a system. This device property could be set
via device tree or via ACPI. Then a simple device_property_present()
in the driver would be sufficient.
A device property would also have the advantage that vendors can
control behavior per device, not only per device family.
An ACPI device property could be rolled out via normal BIOS update
for existing systems.

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/Documentation/firmware-guide/acpi/DSD-properties-rules.rst?h=v6.16.7


