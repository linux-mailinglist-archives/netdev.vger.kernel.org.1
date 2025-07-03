Return-Path: <netdev+bounces-203751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E67AF6F9F
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 12:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EE351C4218C
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 10:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D102D3753;
	Thu,  3 Jul 2025 10:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XcuQ3A2M"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9F823ABAA
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 10:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751537029; cv=none; b=bqt8BkpvLL/WVgmIGtnLyc/dznYQFJSqz6HYfe7QDlepAOHmvwr3B4y/TMSmVcIxXlR8dnGj4QXSioUrHjQS/HWIB9gncfB4p7VynQvkJ2nalOF/ibxBrOJ2EVWuWqDFqlGjaHYVv11DUbPA6H8Gm/E6zHuj1wtUClv81BNK+jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751537029; c=relaxed/simple;
	bh=t2jpb7/Z5KgiLlt/9TEa+jgLsbUjBOFYGE/Oo12VC6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iWzFeTj03mgb2XPjybQGc31fO2RTQU7sIzUJUCRR4gLFdlbX4O11oT0dzKdqbV/iyZG5gIFHgp9eW6QAsa5Jk9+iJCGSZKksiAl6zPjSPx7ncnL7tWNst+Jxsn0XSFnMl/7Seul8ivtTa085FjGlqkeLc0hxkKpBcX1Ja7X19G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XcuQ3A2M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751537027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9B3ihYuWOeAFzcnls83zQtIbBYRAt2J+SrasgFV6Zjc=;
	b=XcuQ3A2Miu8jY89mQTMNdLRFMjst87wQz43hxcO9sfGP5Ykw6ilDUVLw351XMG6QI9kcfl
	cTQvZMC//yfWsaXnH/UmejNAt0zhLbQ6AztLtnloFgNZj+TvH1DXykfMhzxhB8Ndb0Po7v
	qFqpt/FldoK1sxA5NuDrzcNC7KUJsaQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-4xxOim6ROXGwc3peCBZJxw-1; Thu, 03 Jul 2025 06:03:46 -0400
X-MC-Unique: 4xxOim6ROXGwc3peCBZJxw-1
X-Mimecast-MFC-AGG-ID: 4xxOim6ROXGwc3peCBZJxw_1751537025
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3b20f50da27so412724f8f.0
        for <netdev@vger.kernel.org>; Thu, 03 Jul 2025 03:03:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751537024; x=1752141824;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9B3ihYuWOeAFzcnls83zQtIbBYRAt2J+SrasgFV6Zjc=;
        b=uh0dBBmLa92BDuvgqX3UM38reU67ti9QL1Ib5JtsQo2Yxb9qr16frkgL87cPT/ZyR0
         xa6dmnHwxDXmfgdItyzuXt/DuvkrMTaSxpuaesQFqzdkBFPdJu2mPpnpdn6vrkXZI2Vb
         VqcJCND9mrycfGnOn5v9bAG4NYeCr9Gg5HZ8hmS/vk8qcVDkAJjnumNIFb1ffO56Y55M
         t6khrL3fo0KbN1aUmCt89XXq/YA6lfqdZkEmKy9LOYfVXoQnLENECh5fBxSblQtPJuwa
         W/+guTIieGRpknV/MKk7XyIlfSswRXo8OfnnNpQvaOn1Qvn7vjI+hzdoPURZUMTRcFib
         9wHg==
X-Forwarded-Encrypted: i=1; AJvYcCUMtsFTBs0dP9U9TmDxhFsHWPqiqamJ843c+mc0EmSZ9ipHeiV7ArALJaM+cx6XKloUFBkaKRU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs3AgFmYpNGlWHxhixESwZCToPl4MiPv0fF4iyM4yc7fx5NFwu
	WRsif+S2TOs9UDLQqYstjbk+cDX10lMK2ji9tRaLs+J+PRoCJK72MdjeEdhHIdEI6hfnlESS1z1
	kLzDzi6JYaUKqJZ0+UbSiM7Z0/JY72Tz3bq4KmcW2n7LTAS0AW+df+UXAZg==
X-Gm-Gg: ASbGncsgmBTcPB7LrasMANPn6vv9G1TeRuohGUNaQvbZQgvfbrBB9VL8p20PDz/iuju
	LmjiOcvPFQPrbbn0Olt14ePDWYyMuac0gtC6IjH6HauaqLIecrkvC7w9zDDTv84OcAjwFGllpXB
	UrY1FiMlaH+bszdOD6ePsINRzeFPvoX6vtG4RPCJ67x42XSUeRKn3Fl8c4qoLTaZKluZdcQDhtV
	+9WyLmxLcwBvEw17EQrAdsBWhHF5wo5mdS8juZMuecqQu+cK8zX34EBDhi9RvJnlZm4rWSM+DDI
	J0CEPxbs4g6AOXCQn4GlglRuDiq1vXokiyw/4qyfafm/ffecUtYTNNx74XVMFrmGaZo=
X-Received: by 2002:a05:6000:2207:b0:3a5:8934:4959 with SMTP id ffacd0b85a97d-3b3450a2240mr1717367f8f.27.1751537024220;
        Thu, 03 Jul 2025 03:03:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEk+YmnervE/9rlaKNpBDo2E1RoLkBUfVqR7jtbbm8XVo68a+HMCOaP16O0KFNsHAN0CxbnUw==
X-Received: by 2002:a05:6000:2207:b0:3a5:8934:4959 with SMTP id ffacd0b85a97d-3b3450a2240mr1717328f8f.27.1751537023692;
        Thu, 03 Jul 2025 03:03:43 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:270a:b10:5fbf:faa5:ef2b:6314? ([2a0d:3344:270a:b10:5fbf:faa5:ef2b:6314])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3aba76e40c0sm14156922f8f.59.2025.07.03.03.03.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jul 2025 03:03:43 -0700 (PDT)
Message-ID: <56cb86e1-db38-43c9-857b-f14bb4a5ecd8@redhat.com>
Date: Thu, 3 Jul 2025 12:03:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 0/4] net: phy: bcm54811: Fix the PHY initialization
To: =?UTF-8?B?S2FtaWwgSG9yw6FrICgyTik=?= <kamilh@axis.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: bcm-kernel-feedback-list@broadcom.com, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, robh@kernel.org, andrew+netdev@lunn.ch,
 horms@kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org
References: <20250701075015.2601518-1-kamilh@axis.com>
 <20250702150216.2a5410b3@kernel.org>
 <da323894-7256-493d-a601-fe0b0e623b00@broadcom.com>
 <b89e3a66-3c98-45b3-9f16-8247ac1dc1f4@axis.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <b89e3a66-3c98-45b3-9f16-8247ac1dc1f4@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/3/25 11:03 AM, Kamil Horák (2N) wrote:
> On 7/3/25 01:46, Florian Fainelli wrote:
>> On 7/2/25 15:02, Jakub Kicinski wrote:
>>> On Tue, 1 Jul 2025 09:50:11 +0200 Kamil Horák - 2N wrote:
>>>> PATCH 1 - Add MII-Lite PHY interface mode as defined by Broadcom for
>>>>     their two-wire PHYs. It can be used with most Ethernet controllers
>>>>     under certain limitations (no half-duplex link modes etc.).
>>>>
>>>> PATCH 2 - Add MII-Lite PHY interface type
>>>>
>>>> PATCH 3 - Activation of MII-Lite interface mode on Broadcom bcm5481x
>>>>     PHYs
>>>>
>>>> PATCH 4 - Fix the BCM54811 PHY initialization so that it conforms
>>>>     to the datasheet regarding a reserved bit in the LRE Control
>>>>     register, which must be written to zero after every device reset.
>>>>     Also fix the LRE Status register reading, there is another bit to
>>>>     be ignored on bcm54811.
>>>
>>> I'm a bit lost why the first 3 patches are included in a series for net.
>>> My naive reading is we didn't support this extra mode, now we do,
>>> which sounds like a new feature.. Patch 4, sure, but the dependency
>>> is not obvious.
>>
>> I don't see the dependency either, at least not in an explicit way. 
>> Kamil, could patch #4 stand on its own and routed through "net" while 
>> patches 1-3 are routed through "net-next"?
> It can be done this way, however, even the patch #3 is effectively a 
> fix, not new feature, because the bcm54811 PHY in MLP package only has 
> MII-Lite interface available externally. As far I know, there is no BGA 
> casing available for bcm54811 (unlike bcm54810, that one having both MLP 
> and BGA). Thus, it cannot function without being switched to MII-Lite 
> mode. The introduction of MII-Lite itself is clearly a new feature and 
> it is even (theoretically) available for any MII-capable PHY. So if 
> putting it all to net it is really impossible or contrary to the 
> net-next vs. net selection rules, let's divide it....
> To get fully functional, bcm54811-based networking, all patches are 
> necessary so any other user out there must wait for both branches to join.

The above makes sense to me, but I think it would be nice to capture
some of this info in the cover letter - the fact that many people were
confused by the series is an hint the info was indeed missing and required.

Please resubmit with an extended cover letter, thanks!
(unless Florian jumps in and explicitly asks for something different :-P)

Paolo


