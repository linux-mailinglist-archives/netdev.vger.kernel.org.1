Return-Path: <netdev+bounces-56089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B19380DCE2
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 22:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC77B1C214AF
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 21:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73ADF54BF6;
	Mon, 11 Dec 2023 21:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ss4AyKB6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF55AAC
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 13:24:08 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-67abaab0bc7so30823026d6.2
        for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 13:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702329848; x=1702934648; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qXlKFFfxfLrISqFUeGcrFNruw+dfQL+GNEDZrMGRGRk=;
        b=Ss4AyKB6SUtzQXWZRyAWSKCUqZqTX2BEpNVOeJ1ke9qSYLAa1aEESnE4G+NrI8wq3I
         KWOljpdp+Uqxjyn3QhectKjKJQ+UhRi144t3Mmjgy6ffoncnsLKR76qQp7vLw72SkHbR
         RBGt3IiSiD+SW5QkGpAN/dXzquhNQBgf5AZzi4+0KJEp8BDkHk+GqruzvUclbw/CdPj+
         cH4ZxAVKwuBEkmko+D822dOxUEBeThUS6n4l4f00sSQjLtk5iBzKqncnsnubhxtTE7vp
         GJ5d5KMhR4R6tVLpJwIJbyemuCyADjME9VGunTfphIsPWA+a56zdOKQZVMTI4rnvT2Qc
         gOEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702329848; x=1702934648;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qXlKFFfxfLrISqFUeGcrFNruw+dfQL+GNEDZrMGRGRk=;
        b=JOVNSRkFbie5gJV8qL/0wKkq3WVg8Pibd1yk0dUCnqHX6wn8oQWdtrHWsEbuxtVGsP
         W+EnbseuXbLs5DtYdca8yA6I5CMkmlr6cF2ylIC8uJXQgSOgBJwdtUOTKPhgpVwJsg8i
         PtDIGgwUIaikm4CS/cR9I9umWOr4gka6J3MkL2odhndQA6R37riz813aM0sSP/jBZunj
         FJUj85GrYtLkCyxoXVJ6aLepvNZZLHgdzSOfpO/wO2Ed9KKkav2zcOa3MyJqb6CGIoIS
         7We74RvpwaJalvK4tjbkFp/+ZGOr3tkre1UmOtFDeK5sZtTd9CEVenqP2stGQnyDLvw4
         KbLw==
X-Gm-Message-State: AOJu0YxU2QW/8CUXLs7HyuHeIX3tE8CU1kqzU/yC6zHg01bSPdRK7m3S
	3ZsUR9v4RvxY7Z7um3hiA5U=
X-Google-Smtp-Source: AGHT+IFKco/aZMKekjPNwhwdaF1PPZFSgxaDP5hzcZF2o83IkRAhBGUouDd8A/1T3lCGDaQzBHx1zg==
X-Received: by 2002:a0c:f7c3:0:b0:67e:aaa5:d802 with SMTP id f3-20020a0cf7c3000000b0067eaaa5d802mr5146536qvo.87.1702329848006;
        Mon, 11 Dec 2023 13:24:08 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id pz8-20020ad45508000000b0067ad69c7276sm3610975qvb.75.2023.12.11.13.24.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 13:24:07 -0800 (PST)
Message-ID: <b01fb27b-2d8d-4652-8f64-cbda79bcd266@gmail.com>
Date: Mon, 11 Dec 2023 13:24:03 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: dsa: realtek: Rewrite RTL8366RB MTU
 handling
Content-Language: en-US
To: Linus Walleij <linus.walleij@linaro.org>,
 =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
References: <20231209-rtl8366rb-mtu-fix-v1-0-df863e2b2b2a@linaro.org>
 <20231209-rtl8366rb-mtu-fix-v1-2-df863e2b2b2a@linaro.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231209-rtl8366rb-mtu-fix-v1-2-df863e2b2b2a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/9/23 14:37, Linus Walleij wrote:
> The MTU callbacks are in layer 1 size, so for example 1500
> bytes is a normal setting. Cache this size, and only add
> the layer 2 framing right before choosing the setting. On
> the CPU port this will however include the DSA tag since
> this is transmitted from the parent ethernet interface!
> 
> Add the layer 2 overhead such as ethernet and VLAN framing
> and FCS before selecting the size in the register.
> 
> This will make the code easier to understand.
> 
> The rtl8366rb_max_mtu() callback returns a bogus MTU
> just subtracting the CPU tag, which is the only thing
> we should NOT subtract. Return the correct layer 1
> max MTU after removing headers and checksum.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


