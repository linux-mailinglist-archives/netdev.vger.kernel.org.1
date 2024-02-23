Return-Path: <netdev+bounces-74436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C73861534
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 16:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8300B23E3C
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 15:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4D981ADE;
	Fri, 23 Feb 2024 15:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="fy52DF3L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530C86FD1
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 15:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708700860; cv=none; b=Tfe0BT8+b7B0GhMv8z1ObFmSbzcN+qWH8DmCCfpHXUYh0BFV4AwX1eb2KhyZAVg2HD4igP4+b8aMO0NhbLTWs8ht2fGtSFwB20WpiVcPq3v6X4DyI8y5y70pKwUaQW+TeuOnSD8Ax4Ys4KHV4GHyaM42uRmczGtinpnYURBmn+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708700860; c=relaxed/simple;
	bh=l4OiHX7XVBYqvsomD8QhDfeqjVpD/agK+viKeLK0ACY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c9y/Vkhih+2jJEGmx+hGXCg2tsY0MkhIA2XBzPC4E49YbveQBzDWd/BI7mXKwLB/h9fDQznPHo5UhcyAmOnsSxvOPp5kv5UlF5F+jp28nYhsNLQ5AdnkjE3zB9fTdyBbR2WABjxyOL8WuxF6aM3+JqFmTMNfZN27KOu9+n1nN8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=fy52DF3L; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-512d19e2cb8so1348331e87.0
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 07:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1708700856; x=1709305656; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=31GqPVzGQ1Q78j5Y1/MwkTM0w3abIUGTaVKvcPiJlLE=;
        b=fy52DF3Ll8tYh68JjFnpvFGmCO1bG9jEfGAigiDSQtW/OsZ/GixPmjwaV+k3Y3okek
         Z9lCrZmmiXA6c1Cp8i0xSDtA0SCfSvL2t7tYrzKgE8aIWoJZ2Tfpsyp+JDqJtpuG0a8i
         cSBihj1eUZxHKBuvvGSDyZ8wyElHvKFPR8d2BJH2XoGInf6PVFwxlZJToLwkacGXl6fK
         FkULezfGfjgdv7FbdxV7MXnT23TebtHE8RBnG2bpdRlFTkBxIWU7jd0C3yKkIBIdPVmE
         FA1EhFR2nyXRiRDv3HBnbQafruaRa7hmk+3WZs/NJ/w2uzLi7Ts8664OzZtYRxsx0+fB
         G2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708700856; x=1709305656;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=31GqPVzGQ1Q78j5Y1/MwkTM0w3abIUGTaVKvcPiJlLE=;
        b=STqkeA60aj7AlAGzMGbTlKPM7Hiy49idyjzxbmhQKYLdVV1J6yOHQII7SJnatzNViz
         BTa3w04iv5BATjKyE79UCZ5PC3b+o6I2y5J7I/DCxTXRwzp6He/mvrk/dHhilEyUN8Ko
         ndJlLpqwyTenBqcZPUohZ/ZtsbOpiCTTLffdPpzAkaciBsInhrNWKJsdNQ54VDkwrl8z
         puOA0Rfg/c9TT2y9ZPgd3gvgfuz4/tqli6htlmxpF3DMyPUhklI+3NVKOc0DB9SYZ/Jf
         0His6eOWjhDy7ZYx7XlnAHPeo+B9obaMSiIqIWC56u4FRJIcAufOZFaXmEQhpzUSZfzO
         lWfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXH9zgIp0eiONoso8JEC4QFqMQpW+CX/X+Ey+SIKTGvCAqBYW89NwhcXRT6SbIEng+sJZHLuMgjlwHysXcKcoinGhV6dy3m
X-Gm-Message-State: AOJu0YxmZehs0nkkM+j1qfFjPbJyqvn1uNNm8PrFNuIKbru13yM5UE0V
	mMCCAM+bipJ+xe8gBEtRAru3GiKEtuW3TznrDUrfM4F+HKspLWv4/XoJwMBi+0U=
X-Google-Smtp-Source: AGHT+IEFROIY7CJbeu3dmTHU2j2LMNLuhEq6FQMQN+tie3n+hK/caXBBzVZaIx3rsubfq+RLxTOrbg==
X-Received: by 2002:ac2:4295:0:b0:512:da71:b162 with SMTP id m21-20020ac24295000000b00512da71b162mr47548lfh.3.1708700856060;
        Fri, 23 Feb 2024 07:07:36 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:25c8:f7d3:953d:aca4? ([2a01:e0a:b41:c160:25c8:f7d3:953d:aca4])
        by smtp.gmail.com with ESMTPSA id by4-20020a056000098400b0033daa63807fsm2604508wrb.24.2024.02.23.07.07.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 07:07:35 -0800 (PST)
Message-ID: <dfb07217-0b0b-426f-974a-76b81eca3935@6wind.com>
Date: Fri, 23 Feb 2024 16:07:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next 01/15] tools: ynl: give up on libmnl for
 auto-ints
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, jiri@resnulli.us, sdf@google.com, donald.hunter@gmail.com
References: <20240222235614.180876-1-kuba@kernel.org>
 <20240222235614.180876-2-kuba@kernel.org>
 <5ec74f4d-5dbd-4c2d-ab11-d00b0208b138@6wind.com>
 <20240223063504.7a69f2c5@kernel.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <20240223063504.7a69f2c5@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 23/02/2024 à 15:35, Jakub Kicinski a écrit :
> On Fri, 23 Feb 2024 14:51:12 +0100 Nicolas Dichtel wrote:
>>> +static inline __s64 mnl_attr_get_sint(const struct nlattr *attr)
>>> +{
>>> +	switch (mnl_attr_get_payload_len(attr)) {
>>> +	case 4:
>>> +		return mnl_attr_get_u32(attr);
>>> +	case 8:
>>> +		return mnl_attr_get_u64(attr);
>>> +	default:
>>> +		return 0;
>>> +	}
>>>  }  
>> mnl_attr_get_uint() and mnl_attr_get_sint() are identical. What about
>> #define mnl_attr_get_sint mnl_attr_get_uint
>> ?
> 
> I like to have the helpers written out 🤷️
> I really hate the *_encode_bits macros in the kernel, maybe I'm
> swinging to hard in the opposite direction, but let me swing! :)
No problem :)
Anyway, after the patch #2, the code in different ;-)

> 
>>>  static inline void
>>> -mnl_attr_put_uint(struct nlmsghdr *nlh, uint16_t type, uint64_t data)
>>> +mnl_attr_put_uint(struct nlmsghdr *nlh, __u16 type, __u64 data)  
>> Is there a reason to switch from uint*_t to __u* types?
> 
> YNL uses the kernel __{s,u}{8,16,32,64} types everywhere.
> These were an exception because they were following libmnl's types.
Ok.

