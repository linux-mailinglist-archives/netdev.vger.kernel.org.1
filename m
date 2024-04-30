Return-Path: <netdev+bounces-92349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C40C88B6C22
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 09:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E74661C21FA9
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 07:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1553F9C2;
	Tue, 30 Apr 2024 07:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ee7W6fMj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A133EA98
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 07:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714463413; cv=none; b=sZjhV8Y8efdAovEUtPTyMfHI6RO2H14PbbAGbyO2cZFBxc9aNs9gS10LBJjlV33uSt/SECNGKEJmn2bQwHBK3b6L+6ELtEL5UXz0Kx9GZfUacRGQhwiJUtoFV8fsvSrQwVqsM7LbJ1eU92qP782uxPIlnbqspinQoPFwJ1gvzAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714463413; c=relaxed/simple;
	bh=y3GPHREQOB5v6cbz7zi466YFbYAsd74MT7Yxe2f9iMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S7GfKVn4v0+SW/2VnXbokLlSFzudxUK7DrmU+hP//3BxdUlfMia2MlTEK66J5qqR0BVU7hN6m4FlxixjvmvvA2SaTn6W2oMqlfPQY87lYJD9jX+aOZ/1XwnFZNBwp9o0PmKfJ7xKaYww2Twr6f7++3+uLWsMUJoUs8GdavubURU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ee7W6fMj; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57230faeb81so3181557a12.0
        for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 00:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714463410; x=1715068210; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CdZMwTmpWj9xg3Z7thMGgyDqIb86JCoZXlPnTCASMNo=;
        b=Ee7W6fMjxq/0Ng6dDmxZYvak3RsZvdezsgNNuketcCPT/bA/weVB2bg4Cbj/2tHTd9
         2Glt/hcoNnijWDdDfROIjR+nyx6hX3hfBZLcDd9+uu2/f3l+OZSPTu8w8vnw5i58G4Qm
         1ntDlsa9lnVBTYDaDD+TtOa/yF+hbGzu9vjoNb3zAdL0olYO2QunT2Gw0WYsOc6f5IZF
         JzN0p3yRob+sDwsmc9VMH8k4VL5aaIX0YSWk+E7QU0i7XpztuxIHCn+IP5ImBNlVX6k1
         BrJz+YD5hP0PeB8qRbWVYiLQVXFtZ8hz/OyZloaFQTIsZ+P6gDV1eePm9X20EWlSSCYU
         kMBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714463410; x=1715068210;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CdZMwTmpWj9xg3Z7thMGgyDqIb86JCoZXlPnTCASMNo=;
        b=sz4vpF3SY/OLaae5RXHgdQsggJ37BaJq7HU8N4uWivqsSatGBDGF1OaIDm/kl2C97A
         novIEW8kBq+iCfQIKwh5CPKidiAjSnUmsPushEd/64F1bGfM68J5gPWDnViSYArSIwkU
         GCy32UXMZxqoQLx3kcjRPHkpmUmzYSsMNUttN3wyDZFJgW7ubCdKsdZ/Mh1qVdINH6fC
         e1l5yUMJlKUdp719xNzzOvMx4IcGXkKyN5sgTUu33VE4A0yED4Qho8xkU5cuQpouXmx8
         9LC/eeA12zcxvQa0JHl0Y8/PE1OUwZ/ZvdHaUmksRHW9BmuAzjAZBX6TbnphyWcA/oPY
         RnxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOeAauxqdP9lpg2o9J7ccor6Vn1K2KR6BFf/CyYrYSQaR0qr8jk4E74Vjz+KAsLAabFkflAu3172whkkaYjd3BGQydV5d5
X-Gm-Message-State: AOJu0Yy3759OGG8OyIQNOoV0cQBbuJNkWSMvqI81/KfSPFZOVM+TYogG
	FPbeR5HycPkxUZEm0TmiUmEGma5Ms/VwAQMrbs9pRefYJurwlWjHVH9Oc/pyItM=
X-Google-Smtp-Source: AGHT+IHi0Sn9aiR+1OAfx4ul4FSxAOk5uyAUhpJrG+gB+VwB0CVMGXcCFuSrzyCx2E0mx7Tck8Y7ug==
X-Received: by 2002:a50:f61b:0:b0:572:325a:8515 with SMTP id c27-20020a50f61b000000b00572325a8515mr11052060edn.36.1714463409850;
        Tue, 30 Apr 2024 00:50:09 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id n18-20020a05640205d200b005727b2ae25csm273823edx.14.2024.04.30.00.50.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 00:50:09 -0700 (PDT)
Message-ID: <5ed51fdb-ffa7-482b-8789-a190e9b3459a@linaro.org>
Date: Tue, 30 Apr 2024 09:50:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: net: broadcom-bluetooth: Add CYW43439 DT
 binding
To: Marek Vasut <marex@denx.de>, linux-bluetooth@vger.kernel.org,
 Marcel Holtmann <marcel@holtmann.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Conor Dooley <conor+dt@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, netdev@vger.kernel.org
References: <20240319042058.133885-1-marex@denx.de>
 <97eeb05d-9fb4-4c78-8d7b-610629ed76b3@linaro.org>
 <93eeb045-b2a3-41d7-a3f2-1df89c588bfd@denx.de>
 <793d016d-2bde-407a-8300-f42182431eb1@linaro.org>
 <c21823f2-4dd7-490a-8b76-7cab422428ba@denx.de>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <c21823f2-4dd7-490a-8b76-7cab422428ba@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/04/2024 22:44, Marek Vasut wrote:
> On 4/29/24 8:22 PM, Krzysztof Kozlowski wrote:
>> On 29/04/2024 17:10, Marek Vasut wrote:
>>> On 3/19/24 6:41 AM, Krzysztof Kozlowski wrote:
>>>> On 19/03/2024 05:20, Marek Vasut wrote:
>>>>> CYW43439 is a Wi-Fi + Bluetooth combo device from Infineon.
>>>>> The Bluetooth part is capable of Bluetooth 5.2 BR/EDR/LE .
>>>>> This chip is present e.g. on muRata 1YN module.
>>>>>
>>>>> Extend the binding with its DT compatible using fallback
>>>>> compatible string to "brcm,bcm4329-bt" which seems to be
>>>>> the oldest compatible device. This should also prevent the
>>>>> growth of compatible string tables in drivers. The existing
>>>>> block of compatible strings is retained.
>>>>>
>>>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>>>
>>>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>
>>> Is there any action necessary from me to get this applied ?
>>
>> I recommend resending with proper PATCH prefix matching net-next
>> expectations.
> 
> I don't think bluetooth is net-next , it has its own ML and its own 

True, indeed. The net prefix confused me.

Best regards,
Krzysztof


