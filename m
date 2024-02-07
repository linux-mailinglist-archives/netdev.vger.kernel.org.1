Return-Path: <netdev+bounces-69697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE1084C38B
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 05:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81F5028B8E6
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 04:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB27610A08;
	Wed,  7 Feb 2024 04:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbLIhqYa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F8F12E5D
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 04:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707279921; cv=none; b=e7kt7WkfbKmAKAo2ExzqmBK1z3YFYI8Ka6S8Q65+7btNtz2z/Tv6pCJLfr3CVOcbHW00j21xPBcAajmqNpymtpij/bIy+TU/LWdj0sgVSK8LZ7CRVNGDqxHHbKoVc9IaxSC3x3gxYtJLvTMR2Gz9UB1QeDmrR7yagSGvwF44zYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707279921; c=relaxed/simple;
	bh=Zhwtvfv8KjAkgd2fvuN9eQecnOCUHkLno3FqktplbRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kge1l2u/u/t9ji0959a6Qxs1oqMl2n65t2+tHcO5evnTp06KV5K76ah+o+IsF6iSnAeTYQGx2UlHsXjR9hZl1q2CaTzkJTzLHOVSuGVlFXCfGXUmRXrwnbQxJVKYXPc1ADVvbN1RpcXjn9B4MWk/yOIxu0fL+h8JZ4lT+oQRCJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dbLIhqYa; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d7431e702dso2386355ad.1
        for <netdev@vger.kernel.org>; Tue, 06 Feb 2024 20:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707279920; x=1707884720; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HMrlr7nZw5dCUAxbazVv9rYOkAKQRL0V1zpDd/IjA/w=;
        b=dbLIhqYascMigKAnAwgnbBawbRZ8CcHhWW9c8OQz4yyz0wKDwUnysEBg1j4ZwKIhqs
         etv6Ou0YnrYjOyb2gTdcGBqSQnH5g/izzbb2ebF+359jcEzmHIJXM/hM45PGtgpEBix2
         m+OcVQPdi4QyJ1NGzlz2sZPLggUkwVxNKx5i6WKk/R37GO1oG/kw2KQpkuTwB/e+0DAm
         VLLK/pfbmE85vWGfKglRtleZmydarpBIIETjKMZL25plkUquz8e3GI3wkgddmTjqTb4p
         u5rDv5s4q8c8VeelqVFRTKpe+3PKE7S/4li7ZV7VcZ2tWtwHqJEHK+KgP2jUKc0koIZX
         BrsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707279920; x=1707884720;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HMrlr7nZw5dCUAxbazVv9rYOkAKQRL0V1zpDd/IjA/w=;
        b=WBXJBSRHhtWvmZ92V+zUj2fuMve724GVFO0Pw7mx5bpnDQwl4HTOxQIuTz796tFXuu
         D3h4ZG4dkb+iVYTSXsdikZKZyN6i6sw2aMto97eJMPSb0xX1mF5HbctZ2IKoKYhR7tZo
         9aVR3QcZJYaSfQjEnxAs/vIOE3RPdrGy3uTl/GEDJU6PG8q3Ad5G4nTjRIfM13qa3xPS
         FMPCBIyKuoAkfxUeuHccsLkwaKNwL2QhZ/lz3R9d1M1jEqEKf/VYIay6DOUChUMjW8RZ
         GCkUWZE6pSd3mria9RQbZ+lqQ8kyLUwPA4nb9k+GFV7MNsz1YrLuubCanYhWGAyVC4qz
         xYmQ==
X-Gm-Message-State: AOJu0YyAShA0zaAOxYxW3WqCd865FF5Nl7iXIM6+3oiUbcG3J4Puhmr1
	vOxj6R+iPxuigsst5qlB6UupB36l/WIHKOdus7rkxiszRJMNscmc
X-Google-Smtp-Source: AGHT+IG1DZr3LGFkUE2k+B+E34X6XrM6TPAN3drCI1YmumoFCqZR38zQwG26rMMUWss43/w1Ye+Lmw==
X-Received: by 2002:a17:903:4286:b0:1d4:e04b:3eea with SMTP id ju6-20020a170903428600b001d4e04b3eeamr3529877plb.31.1707279919709;
        Tue, 06 Feb 2024 20:25:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWvfccdKYlKvU+hBjmZAQ9INqcyY5ToS/CHtFubvPLK9tdpGkqjKoiT4TuLRGMQeae/LdszWZNz1Wd7hVXGAEtu59DwJ/FCzlMtjna+B7HRMunLKWi3Pzln1pU7zvZEyN52DK5ETIujfc7r3sIzIUhtGR9NiRzgreUADGsovhmieURWqoxy1Zz2EhF5bpuwzeVf/M0siaQikBS+nIlIF33BBUcCjUQHqB2ya2d7YGnHfDqLVaaJAEB18Z2PJg7Wyh1eeocflQtsqF7jK+kx4dcz/+GTpRm5gK7DQgHGeeY0l7TQbXNysG8KCgSZfV7GDAM68x1S+DsUvuCrmnxu7EYtAv38TSJ1WpzFazsv3lTiCe9NzijijCieanpH2++WMkNCwdv9nn7fivxE4GWe1DsviLozDsLyVYGwZZHc23firDYL8ppxrtmR8CmVlV6jKubuwePZQoaflrowWHT3237giMTGOhghUtvmeIBLzdqguRnXvt5JXNmnadYoVvG1CGi24OJrX36++0OGqB9BRUL/zyKl4W36T0MloG6PxAHEz8oC5y+7klNfULZXxBZnhM3QXm6VllV3Tq77nNw1cRQtgPmFt/Si3Sr90NhpLtYANemzijjkbN5Adis3wqn6HAxFPAZxnKA5qDFvpSdmSbcdlpgCpdIcGMJpD/XaeHkc5QoUmWY3pIygQYKrEmJiNU7fErpsL2HdDOx/2le1xufkiJrWtw1RCyqfNJw=
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id iz6-20020a170902ef8600b001d95a70ee93sm357092plb.240.2024.02.06.20.25.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 20:25:19 -0800 (PST)
Message-ID: <57406055-ff3c-4788-bbf7-8476f63f90db@gmail.com>
Date: Tue, 6 Feb 2024 20:25:17 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 6/6] net: dsa: b53: remove
 eee_enabled/eee_active in b53_get_mac_eee()
Content-Language: en-US
To: Vladimir Oltean <olteanv@gmail.com>,
 "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
 Doug Berger <opendmb@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 bcm-kernel-feedback-list@broadcom.com, Byungho An <bh74.an@samsung.com>,
 Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Jose Abreu <joabreu@synopsys.com>, Justin Chen <justin.chen@broadcom.com>,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 NXP Linux Team <linux-imx@nxp.com>, Paolo Abeni <pabeni@redhat.com>,
 Shenwei Wang <shenwei.wang@nxp.com>, Wei Fang <wei.fang@nxp.com>
References: <Zb9/O81fVAZw4ANr@shell.armlinux.org.uk>
 <E1rWbNI-002cCz-4x@rmk-PC.armlinux.org.uk>
 <20240206112024.3jxtcru3dupeirnj@skbuf>
 <ZcIwQcn3qlk0UjS4@shell.armlinux.org.uk>
 <20240206132923.eypnqvqwe3cga5tp@skbuf>
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20240206132923.eypnqvqwe3cga5tp@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/6/2024 5:29 AM, Vladimir Oltean wrote:
> On Tue, Feb 06, 2024 at 01:12:33PM +0000, Russell King (Oracle) wrote:
>>> I know next to nothing about EEE and especially the implementation on
>>> Broadcom switches. But is the information brought by B53_EEE_LPI_INDICATE
>>> completely redundant? Is it actually in the system's best interest to
>>> ignore it?
>>
>> That's a review comment that should have been made when the original
>> change to phylib was done, because it's already ignored in kernels
>> today since the commit changing phylib that I've referenced in this
>> series - since e->eee_enabled and e->eee_active will be overwritten by
>> phylib.
> 
> That's fair, but commit d1420bb99515 ("net: phy: improve generic EEE
> ethtool functions") is dated November 2018, and my involvement with the
> kernel started in March 2019. So it would have been a bit difficult for
> me to make this observation back then.
> 
>> If we need B53_EEE_LPI_INDICATE to do something, then we need to have
>> a discussion about it, and decide how that fits in with the EEE
>> interface, and how to work around phylib's implementation.
> 
> Hopefully Florian or Doug can quickly clarify whether this is the case
> or not.

Russell's replacement is actually a better one because it will return a 
stable state. B53_EEE_LPI_INDICATE would indicate when the switch port's 
built-in PHY asserts the LPI signal to its MAC, which could be transient 
AFAICT.
-- 
Florian

