Return-Path: <netdev+bounces-239700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AECC6B845
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 21:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3FAA74EB39A
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 20:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7662BE7DD;
	Tue, 18 Nov 2025 20:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1znWSqv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363A12E8B98
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 20:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763496144; cv=none; b=lz3F5rhLVFkfYdxmJc5Zi6cbiZJnfJMe9kPNeu2wE22zwgnTtspwzX65a1MEDjVJDD3kdJO2TjKc/RlZUfz64lTwZ/W5Erq57XwNbStTpA97Dv/iwOHgydiMlXfpveZLzotqM+Iygs+oxElNsZ0IE9acFGBjw5LUt6vBa4B9Brk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763496144; c=relaxed/simple;
	bh=CKn6PKW2vuSE0Z5h+0ILh/4ECVDG71EHVEwN6mcRvNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U2S3eeRlsfFsIjzDFDsglsIp0bD/+ag3/gmo6ZDfukpDwBd1dvbZWqz/f5fNMDW1h9NPDxWHpqDh7cIGajlPF2YW6xggKVWRXjaOWnBeedcyNBBQq+JlUJwCCDkrm6RL/5iabJqI7ZW5TlmnGQOu9Uk5K5LHJ70HUlhBCZmfd6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z1znWSqv; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42b3c965cc4so104786f8f.0
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 12:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763496140; x=1764100940; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E9eTMEVkW1xNiE9PqQ5snGtAxfd66QMGM9GqQRGyhUc=;
        b=Z1znWSqv3QN2UWIcaILUsbbFmbYOsC3nX83b5hsEgHGLge9BuPAr/NBkkem921YPkT
         BywJoYRJa3LwAgNvRx93sv43O1pcCrGommZDMdjrYOSam/aP8LzV2peidqxgJUCzjRd8
         MVhw/WT9H7AbMxlJojyrRpXNUbO6u7jhYd2AmUJx3If7Pml6qbxjqxNkZoFoxD5dvib+
         DOgfk0lGTK+IDf9liEe9wykgfEQBWubU3Y95LkQegPbspLHsZCRP/BkmHrixC3dYIUqe
         SbyFg5DxOsU8rCtkT6IMIlW3luprKFUjcFkq2QKYkElsuQzzg++foScltpyx0wnVe+Bp
         Skrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763496140; x=1764100940;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E9eTMEVkW1xNiE9PqQ5snGtAxfd66QMGM9GqQRGyhUc=;
        b=Y4Ega98AN6qzDDAnwxfB0xd0YXbjheysdtl2nRblzJa2woToX9H7Dxpc8HvYRD8tME
         aspFa8l4jSLB4LaQHB+wNzXEa0vbuUWN82Dq33p3Ktszl5lFHUabbo0xoxEBF/Vw5k3l
         t7O6oRXHRlr91OtZKQEB6ajO8XIvr69oO7n7I5bKAfc1UhHya0n6cov/C96E3ospAj+v
         IZk1NBovbe3LOPlrkfz++3dh6B7ztVidiOIAy6P71utw8gSXxUbBud3J9b/26v+ucP4h
         AVUB6siEyn4fct9FenJBP9NOtSbfp81Aloi2EWL2hSidfQVgckUXHwcBuUTxr4aeJ6DZ
         IieA==
X-Forwarded-Encrypted: i=1; AJvYcCUFDDLI0WEI8sZosfu+HGSdLBiS6NnD9LNsZnjHb1ASeNw0nSmPLRkXwvgUv3qrrf5+BKLqnd0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQe9lW8QvArKl2FeRhsXQ4RgPwMaMPWw7GESx6jNAqCCVR8jpe
	Tb+9uvbP5HdQrG9w8qoV8YdY8alSgFaxIBHcEwrBq/CTRl3+ksqZo9/T
X-Gm-Gg: ASbGncuPmJ6io/er/bk5IuctcUBPCj7i27742uehcr6F/6x9z+OmdDZsjOteuEOuH/b
	cyHrk1WZXlHq4o0HkhOUeULhFxhYk/jYBf8CXFcPcNzX1ZaGogFE2kbvimI5qExBX1Ihtyb38h+
	SlWg8Ch0QKU1klHNyh9bNJv/Kgh7C8bgz5g/lOGSRqz3k2hSYYG3p8zWTlVOPVyqqGe/Ez7HoRq
	Gea8+BTvi4FNHyn9qj/WFFSQ0UDgqgRo5k0KtSGd4H4sFHO8dN552LFLpsUZvg2esfVm9/68i2t
	SXkjygm6y1t9zL/ZVNSlGLax557PxEqJSeQAi2GJFqk7Fw8B40GR8rCCa40EoZin44RILVl0LjH
	t8L2V/PtI6qroxOOm31BU+jKhHT7dEQ7l2n3TWcEkuR+OYAifXCuDZe3EbI3BtMAyt8XI1kgKlD
	HjhvsxmTmNZnppJpDGgzFnEIX+ijxWgrnYbMQs7Q/DmF1y9ihiZIhjLSp2oOCPP/rpYjDExqmyc
	pfsFLSyXLf6Lplbje7KX97k8CC7uF1MRs9ecx5TdRQuV8N1W/VZCTI/Xn1b0Q==
X-Google-Smtp-Source: AGHT+IFWNROA0fNsC2tzebVqd3TzfeuL5sV6EbCxaKS+MVRaVwCbyPFgBHZ6NVRfVSaxuj8FFFbS7Q==
X-Received: by 2002:a5d:5f92:0:b0:429:d253:8619 with SMTP id ffacd0b85a97d-42cb1920a61mr142300f8f.5.1763496140340;
        Tue, 18 Nov 2025 12:02:20 -0800 (PST)
Received: from ?IPV6:2003:ea:8f37:1a00:5d3:6147:37fb:5feb? (p200300ea8f371a0005d3614737fb5feb.dip0.t-ipconnect.de. [2003:ea:8f37:1a00:5d3:6147:37fb:5feb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53dea1c9sm34070297f8f.0.2025.11.18.12.02.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 12:02:19 -0800 (PST)
Message-ID: <ff55848b-5543-4a8d-b8c2-88837db16c29@gmail.com>
Date: Tue, 18 Nov 2025 21:02:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] r8169: add support for RTL8127ATF
To: Andrew Lunn <andrew@lunn.ch>, Fabio Baltieri <fabio.baltieri@gmail.com>
Cc: nic_swsd@realtek.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251117191657.4106-1-fabio.baltieri@gmail.com>
 <c6beb0d4-f65e-4181-80e6-212b0a938a15@lunn.ch> <aRxTk9wuRiH-9X6l@google.com>
 <89298d49-d85f-4dfd-954c-f8ca9b47f386@lunn.ch>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <89298d49-d85f-4dfd-954c-f8ca9b47f386@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/18/2025 8:31 PM, Andrew Lunn wrote:
>> I see, unfortunately all I have for this NIC is the out of tree Realtek
>> driver and it does not seem to implement the API for reading the module
>> EEPROM data, and there's no datasheet available, so I'm afraid that
>> either the Realtek folks pick this up or it's not going to happen.
> 
> Heiner is of the opinion it is not going to happen.
> 
Realtek seems to do all SFP handling in firmware, w/o providing info about
to which extent this firmware can be controlled via chip registers.

A contact in Realtek confirmed that only 1G and 10G speeds are supported.
He wasn't sure whether copper SFP modules are supported, and will check
internally.

I'll try to strip down the patch as far as possible, likely supporting 10G
only in the beginning (as 1G requires some more vendor magic to configure).
I assume the typical user won't spend money on a 10G card to use it with a
1G fiber module.
Reducing complexity of the patch should make the decision easier to accept it.

I don't have hw with RTL8127ATF, so I would give the patch to Fabio for testing.

> 	Andrew

Heiner


