Return-Path: <netdev+bounces-81196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3CD88681F
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 09:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0ABA1C2274D
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 08:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8F979FD;
	Fri, 22 Mar 2024 08:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="GsTTbXi3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641F21754B
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 08:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711095610; cv=none; b=okrgHtN2MCnknK3vwyqX7ydni9bVqFjZdAwNnWyKqBrVQjpTsiZZNx0p0P1ny5ZcZ4laxMdfuWfBzN2cniiwyk4ePSWnl0qm/JvaVwtxAJxg81/7MIhOYk/8lrBaO+56ZT28yU9J2pAnn8Td0Etvjf/hCZXoAqE5Ogp2I4/YuPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711095610; c=relaxed/simple;
	bh=C02p7lidHezF6NKfdzS/EQpOodUYyJrhkt9/F538xHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X6w0dCTu32B9DEfdRpr9PSXuaoCKR1W/80ZtbLDfPoXk+S1u5ZYBWCSwSw6ANZ0IDf3w0BILZ1UcrY/7t1GZ/LxqA2FXcO9xWR2cI5WFYcglGYpsOe709yUUS7dexh29w7xM9QdVpl326YFxpjmRD16wwCDnovZX5xXKm2oztpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=GsTTbXi3; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-414783a4a4eso6910555e9.0
        for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 01:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1711095607; x=1711700407; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GmPWBxHJO9BBBh4etLTaTWP0ZpidPU/5RMxd962Cx5E=;
        b=GsTTbXi3plUMn/tESP3jeDrCSLb6RllZG9KMchzJToPFXQ7EIWhVoiE/5au9ImExPf
         5G2dZWGyArW2iITViN6WSNak00X8X8XE3CBrhlWsqnNNTCckzXe7GpN0YnCXqAQzeAt3
         LsuBSG001lhWZfCRGY3AuV5j+c60XO+mFIQWnhT0GMC1keJbbPxycJ0LcM4fPZv0FYIz
         HLnvQhlEscUm6wDY7F0WvuNrVF262LqNasAdm6NEbk64jjRVTia8cDbFPlyKLBzVnw1E
         FEtqW/s8d3SiaQSYYEaxzgN05OiHs7IERzjFa58rW0YHdxgMtSrrgkU8YQiK4wXC5vq/
         Sw6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711095607; x=1711700407;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GmPWBxHJO9BBBh4etLTaTWP0ZpidPU/5RMxd962Cx5E=;
        b=Rwco/YC3XJ37SX5Z1F9cfx6mSKTeCbdSydfQXsttmlya1GPZ5UG0xJYWslzN1yXPAi
         9GaIy8qszjrZB24YLmXaRO+KqMz85Vz6BCmkJlUh+cO+2BmX3nwX4+BM+VFsF2yXGCmH
         L0mxqnW5tcaUqRaUIeiF/55ELVLsltu31MxesnfyAvr3BmZBt2so92tY5XO+BbUOFhxp
         QcWhEL4loE+thKXgUGPK2ksuD+s5EEzG512lmx2y/cyDVAh2zhLsCmaGYJZdDpONcSY0
         r0dOvnYaqlHbnBNzxvFb3zbp9trLnu0zlnpN/ljp/CRazt1gTuAXMB2TCezkEwmZXV3B
         bP0g==
X-Forwarded-Encrypted: i=1; AJvYcCVVpHWgHdgaVtviVfa0rLLAfaKpEj9W5FLqbt700+6RNA/t9IhkbMOtr9xjMm2ofxlZM2/OoZshQRI9qQrETSl92kHWC1Py
X-Gm-Message-State: AOJu0YzdIHaB9GTjJldBRRRkGa0Q2OUwGHgxrTEFyqsUuur2bjfQa4mX
	xb62cscEFDz53AtPAFBTLavS/1trNZKKKjxrhf1lDIc+bcHBakHdYAm5uLnZ7jKbrcLse9aF6En
	7
X-Google-Smtp-Source: AGHT+IE39BPlEggRVTAc/xDdUTQ4ZV5nWezeR3d8OiMq90gfS1BzyKxsPvKTnfbZVbx/xSW032Fyhg==
X-Received: by 2002:a05:600c:4507:b0:414:759a:71d5 with SMTP id t7-20020a05600c450700b00414759a71d5mr816216wmo.34.1711095606601;
        Fri, 22 Mar 2024 01:20:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:9c8c:46c2:3747:1cc8? ([2a01:e0a:b41:c160:9c8c:46c2:3747:1cc8])
        by smtp.gmail.com with ESMTPSA id v5-20020a05600c214500b004140a6d52e9sm1195418wml.1.2024.03.22.01.20.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 01:20:05 -0700 (PDT)
Message-ID: <b3e0c716-fc74-4cb4-9778-c92749cd4b4b@6wind.com>
Date: Fri, 22 Mar 2024 09:20:05 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH ipsec-next v4] xfrm: Add Direction to the SA in or out
Content-Language: en-US
To: Antony Antony <antony@phenome.org>
Cc: antony.antony@secunet.com, Steffen Klassert
 <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 devel@linux-ipsec.org, netdev@vger.kernel.org
References: <515e7c749459afdd61af95bd40ce0d5f2173fc30.1710363570.git.antony.antony@secunet.com>
 <c2b3203b-fcc7-452f-88d8-1ef826509915@6wind.com>
 <Zfdv8dLMhpwItqGL@Antony2201.local>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <Zfdv8dLMhpwItqGL@Antony2201.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 17/03/2024 à 23:34, Antony Antony a écrit :
> Hi Nicolas,
> 
> On Thu, Mar 14, 2024 at 03:28:57PM +0100, Nicolas Dichtel via Devel wrote:
>> Le 13/03/2024 à 22:04, Antony Antony via Devel a écrit :
>>> This patch introduces the 'dir' attribute, 'in' or 'out', to the
>>> xfrm_state, SA, enhancing usability by delineating the scope of values
>>> based on direction. An input SA will now exclusively encompass values
>>> pertinent to input, effectively segregating them from output-related
>>> values. This change aims to streamline the configuration process and
>>> improve the overall clarity of SA attributes.
>>
>> If I correctly understand the commit, the direction is ignored if there is no
>> offload configured, ie an output SA could be used in input. Am I right?
>>
>> If yes:
>>  1/ it would be nice to state it explicitly in the commit log.
>>  2/ it is confusing for users not using offload.
> 
> 
> I see why you're asking for clarification. This patch is designed for 
> broader use in the future beyond its current application, specifically for 
> the HW offload use case. Notably, the upcoming IP-TFS patch, among others, 
> will utilize the 'direction' (dir) attribute. The absence of a 'direction' 
> for an SA can lead to a confusing user experience. While symmetry is nice,
Thanks for the explanation.

> configuring values that are not utilized and are direction-specific can be 
> very confusing. For instance, many users configure a replay window 
> (specifically without ESN) on an outbound SA, even though the replay window 
> is only applicable to an inbound SA. With ESN, you can just leave it at 1.  
> SAs have historically lacked a direction attribute. It has been brought up 
> many times but never implemented.
Maybe it would be worse to reject this new XFRMA_SA_DIR attribute when it is not
used (for example if there is no offload configured). It will make the API clearer.


Regards,
Nicolas

> 
> Following the email I shared earlier 
> (https://lore.kernel.org/netdev/ZV0BSBzNh3UIqueZ@Antony2201.local/), I 
> discussed this proposal with more users/developers, and there is interest in 
> adding a direction to SA for future values. Maybe I will addd one line in 
> the message this is in preperartion for upcoming IP-TFS.
> 
> -antony

