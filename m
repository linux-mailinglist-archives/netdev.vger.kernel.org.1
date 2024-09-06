Return-Path: <netdev+bounces-126011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5FC96F92E
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 18:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CD9F1F23493
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 16:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D39B1D1F6F;
	Fri,  6 Sep 2024 16:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/xytK1+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147B5130E57;
	Fri,  6 Sep 2024 16:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725639754; cv=none; b=WT1U0p6b+ZPwXenOGuM7MGs9ITVd17mq6bKI6fOh/nxe0OOBjQt4R9okrEcqe52bd6qN6r8PnGvCJayqpo33gSbirwdmG4/qIigXr9/n4N0rBWGshClcOm5efn82yumirBybyK9rQrpvcLc4q2TxD1/XKNwH9foEE7lLSlBZf0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725639754; c=relaxed/simple;
	bh=7xZRqQZFYMicKr7Y7HxECuRVtEF/RNP7D+JPQ6I9uuo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bje+EDGuV90t8hdUPUuWH+/QCfYH302nZ0Gomi3RHxdCmR2ChICLyvCDgtb2hBCWTIQL02dCcbBzNQ7eQ+UYCmPPzO1A2adrKwsX3G/A2KoKmOASIUxBtjFue6copDdpuKYP053WUU0Q7kLmlwhb4eipRConSawmNI3/NYFAq98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/xytK1+; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7cd8803fe0aso1656261a12.0;
        Fri, 06 Sep 2024 09:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725639751; x=1726244551; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=D+wuDR3NGTxq+kb130tcJ/AlmaENXx8g9XCBaYcUzas=;
        b=R/xytK1+KqF0KQcnxbHTtKhJ5XM6Bccc8Witz4MTNZSvNrtz31MpStr0eA72RoqkKU
         BaGLUX3j4g4Wwpz2MyM9tAxuxd+kYaxC2tbM7jmUqVsCE2T4E39rDs5q05iMC571B2ft
         aBsi1kO7pRu3UGe/peH2B2boMYfuDAapDk+oI2YeiIDH5UqD9E+6qeC0y710HmpkOqPv
         saA9mE4EphnF27RnhramATwCfRNo8XcatVnW2S70rt+xI1i8ciL/RDx7eGq0ivmuhmvi
         L8infC8iJNsozITSTymlOAY2VvjxM33B7XdEtny+DuZXrpsz/OSfKT5+UlF2gyXR5eUy
         uDPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725639751; x=1726244551;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D+wuDR3NGTxq+kb130tcJ/AlmaENXx8g9XCBaYcUzas=;
        b=IiZVheNKISgF6ueCSwVaw+BNqJMr9ntGHyxZTBAIb0b7LDMHDCR6aoHpCG/hqmnYr/
         NYIXSS4f+db7TE9iqQ/mgusdijqU7RNxpsV2nxIdhjUFMG8k/x/ivLuPaA6MTLakIZjG
         n8gRR7D/TNCVu0YpdUhfC7dyMtIu26SwQonCXeLGOCF/9A6AgeHIMQccvGTF3z5gqI68
         RfSx+UwjoAw5QdX62MGKDTgnHnRoNwghEMPdAitnRxF/qcLaZPJPUCTxUsRN++8zkHHm
         g2iYh3w0OY9qDSsupuELMbzxRSid665bK3T2vGshWpTx5yWKrwU+DdGUSI6+r8C+lm87
         Avow==
X-Forwarded-Encrypted: i=1; AJvYcCUH+2sE5FEgNN+a/o7AV2JVjIq4qBzN7ZRkGh+fn6HxP1JHNOyXuzLtNt2nQ32k+ouRLM8D5j9Z@vger.kernel.org, AJvYcCVIkzpyQ2xdCRrbVM78jn1dsjkxzMRx5LnbigyhX+omaNA653ifZXwcGRVxAqmT688E8ZQ5quLpb+VB@vger.kernel.org, AJvYcCXSgV1cTVlRPvQM/lkC6XdRXBeBdg9aWFLfHcPyLawFrsWXRsrqFW8LVsHb6tpz49EpjOmFP3etCbsa7jSU@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf1ceQKVB/lNglfEMcYxW88uAVTl/CnjDsuI1jn6oqNHZnjkT9
	EcV6ePe9DnS6xM77W7EeFA1cNPLaPfohLiQSdB/+pkWzzo8csecW
X-Google-Smtp-Source: AGHT+IGe4A3pYTMGxO58fRzZ7SNKtNwWxcQtKJfBK/Gfpm4JWBqg3flxaje5e1XRd6yAqMwUJGv/cA==
X-Received: by 2002:a05:6a21:151a:b0:1c6:f9ea:f2df with SMTP id adf61e73a8af0-1cce100dc0fmr27669262637.12.1725639751192;
        Fri, 06 Sep 2024 09:22:31 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7178ee9cc99sm2888395b3a.31.2024.09.06.09.22.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 09:22:30 -0700 (PDT)
Message-ID: <24097072-1d54-4a24-aaf3-c6b28f31a6cb@gmail.com>
Date: Fri, 6 Sep 2024 09:22:29 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] dt-bindings: net: ethernet-phy: Add
 forced-master/slave properties for SPE PHYs
To: Andrew Lunn <andrew@lunn.ch>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
 Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org
References: <20240906144905.591508-1-o.rempel@pengutronix.de>
 <c08ac9b7-08e1-4cde-979c-ed66d4a252f1@lunn.ch>
 <20240906175430.389cf208@device-28.home>
 <fde0f28d-3147-4a69-8be5-98e1d578a133@lunn.ch>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <fde0f28d-3147-4a69-8be5-98e1d578a133@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/6/24 09:11, Andrew Lunn wrote:
>>> 10Base-T1 often does not have autoneg, so preferred-master &
>>> preferred-slave make non sense in this context, but i wounder if
>>> somebody will want these later. An Ethernet switch is generally
>>> preferred-master for example, but the client is preferred-slave.
>>>
>>> Maybe make the property a string with supported values 'forced-master'
>>> and 'forced-slave', leaving it open for the other two to be added
>>> later.
>>
>> My two cents, don't take it as a nack or any strong disagreement, my
>> experience with SPE is still limited. I agree that for SPE, it's
>> required that PHYs get their role assigned as early as possible,
>> otherwise the link can't establish. I don't see any other place but DT
>> to put that info, as this would be required for say, booting over the
>> network. This to me falls under 'HW representation', as we could do the
>> same with straps.
>>
>> However for preferred-master / preferred-slave, wouldn't we be crossing
>> the blurry line of "HW description => system configuration in the DT" ?
> 
> Yes, we are somewhere near the blurry line. This is why i gave the
> example of an Ethernet switch, vs a client. Again, it could be done
> with straps, so following your argument, it could be considered HW
> representation. But if it is set wrong, it probably does not matter,
> auto-neg should still work. Except for a very small number of PHYs
> whos random numbers are not random...

Having had to deal with an Ethernet PHY that requires operating in slave 
mode "preferably" in order to have a correct RXC duty cycle, if you 
force both sides of the link to "slave", auto-negotiation will fail, 
however thanks to auto-negotiation you can tell that there was a 
master/slave resolution failure. (This reminds me I need to send the 
patch for that PHY errata at some point).

In the case that Oleksij seems to be after, there is no auto-negotiation 
(is that correct?), so it seems to me that the Device Tree is coming to 
the rescue of an improperly strapped HW, and is used as a way to change 
the default HW configuration so as to have a fighting chance of having a 
functional link. That is not unprecedented, but it is definitively a bit 
blurry...
-- 
Florian

