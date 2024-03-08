Return-Path: <netdev+bounces-78560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BEF875B80
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 01:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0634283268
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 00:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4B5163;
	Fri,  8 Mar 2024 00:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="OLsfkccd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94042363
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 00:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709857241; cv=none; b=YTZDzPmCgTSU8AaYxtDLEWYndr6Gtz+rhkKW1710DtJdXwtMdw/yP5IBrRNw7DoI4+uVRO2/fv9rd2nCuNPYQ689eh0+iUQmZk803N4V7mxPaPC7VRhnP5PNHHH888xU+PkhZEOBfdkuRiFoyszbf7fu1WBeG3nA3N+tvyfFJg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709857241; c=relaxed/simple;
	bh=VXsFh+GIlxGPFrDIggLsXOeRtcpCk5AKprcpE5fkvyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E+BAfAxDNhBQL+Xdk7L0QMDRbvAoNtwOHDOdNtZLP7Z++gNYF1VrOsG3qakBbLHO0+RxjTBAeY7Lyot+aPrEbXh9s5WjanMVGejeqBLsV9+LXsD/U9ZnJZroMJJmESDjkrSLuFjcN4I+McK27OKPZxzF2b+n7l5/3yekjgvNLJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=OLsfkccd; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d29aad15a5so2770471fa.3
        for <netdev@vger.kernel.org>; Thu, 07 Mar 2024 16:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1709857236; x=1710462036; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dtqbo4Rz0t5XAMAOzOvejGMeqGxtyx0LZp7Qlf2R2ak=;
        b=OLsfkccdoMivwv92rdoV6721K89LlXyTlA8fHq96n80YEmpRKxcNseUrACIYIgNUHI
         0dIbRegxoOHwMnWGWXWW5Xyl6Jep1qqj5BCnrBElPPfhH2KBImBOzUOWH5VcXtQPI1//
         SZ6AMzWAjcCWN9tpSeI4xxKbg9dVyMOcTdPf5K5t2ChxeNawgjhi+xSxStKchXomEcJw
         AccZTwOO01bU1p9YZP3yeqB1PBr3Wsknk2QQ5Xn7dD73Zavgulx9mUj8Earajn15tjrQ
         eENW1Wd+TYG5M4Oh1pmuauL2tfQONVYfW/qpBRYZ3Nu22E67OqVErk4pUWI7dI1HrVLV
         TP0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709857236; x=1710462036;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtqbo4Rz0t5XAMAOzOvejGMeqGxtyx0LZp7Qlf2R2ak=;
        b=Bnw3uA7Jbo+DGQqzA7eNFIqksIRGfd53jgY1GLQJLT+aFCYMPTwJFk2XEfEO9arIzh
         z59yvb8D28XjB2K33qmuHw8rYgQaLrYWfo7Z0TvSP5xVnxkWQnpl2V4QOVFwK4QZ00qN
         KsQGMxfpTHraEJ1L02KBxpn1JUr7THU/89sj/gz7tdBkEnp7ins2rsUT2RHAp8FmBQfH
         I+xtlBoThWki/PyRLPKJfl1l3PzbqL1sCrZng7wbxZ+YtvWg9G3+kaKG+tv9uzVsNpTk
         wC6B4EkMXJevUmyLJTQ/12hkjdG01yrZmI7Hlr4EO5/HWwsX1NeBnMqoIQU8OuSvUUvF
         WDZg==
X-Gm-Message-State: AOJu0Yx462ZA4b8M+99fjn2jlfbwvekknLPRdoyc8+JXSvEJjU3duhB7
	hhxqPdYsuN9FmCpN2Ni4TJjt/MnnzYszgN4Tg/qAUUrspNQJO3Ufcu5Tqb7Wquo=
X-Google-Smtp-Source: AGHT+IFozVmkm5F9Dq+D2o6gLGUbEsrn4KJ7kpGPlc0Rxgvr+NlwOVkQlsSsXX3uyxYAUjiCopY4nA==
X-Received: by 2002:a2e:909a:0:b0:2d3:aa05:47d6 with SMTP id l26-20020a2e909a000000b002d3aa0547d6mr2511641ljg.31.1709857236581;
        Thu, 07 Mar 2024 16:20:36 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:0:460d:9497:9f21:53e7? ([2001:67c:2fbc:0:460d:9497:9f21:53e7])
        by smtp.gmail.com with ESMTPSA id g16-20020a056402321000b00567e27c72c4sm2453744eda.62.2024.03.07.16.20.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 16:20:36 -0800 (PST)
Message-ID: <97577da6-ab0d-474c-ab43-60958287d1e4@openvpn.net>
Date: Fri, 8 Mar 2024 01:21:01 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 22/22] ovpn: add basic ethtool support
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>
References: <20240304150914.11444-1-antonio@openvpn.net>
 <20240304150914.11444-23-antonio@openvpn.net>
 <57e2274e-fa83-47c9-890b-bb3d2a62acb9@lunn.ch>
 <25cc6fba-d8e5-46c0-8c16-f71373328e7d@openvpn.net>
 <01adab06-78c9-421e-bd3f-453e948f5bbb@lunn.ch>
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <01adab06-78c9-421e-bd3f-453e948f5bbb@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/03/2024 20:40, Andrew Lunn wrote:
> On Wed, Mar 06, 2024 at 04:42:03PM +0100, Antonio Quartulli wrote:
>> On 05/03/2024 00:04, Andrew Lunn wrote:
>>> On Mon, Mar 04, 2024 at 04:09:13PM +0100, Antonio Quartulli wrote:
>>>> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
>>>> ---
>>>>    drivers/net/ovpn/main.c | 32 ++++++++++++++++++++++++++++++++
>>>>    1 file changed, 32 insertions(+)
>>>>
>>>> diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
>>>> index 95a94ccc99c1..9dfcf2580659 100644
>>>> --- a/drivers/net/ovpn/main.c
>>>> +++ b/drivers/net/ovpn/main.c
>>>> @@ -13,6 +13,7 @@
>>>>    #include "ovpnstruct.h"
>>>>    #include "packet.h"
>>>> +#include <linux/ethtool.h>
>>>>    #include <linux/genetlink.h>
>>>>    #include <linux/module.h>
>>>>    #include <linux/moduleparam.h>
>>>> @@ -83,6 +84,36 @@ static const struct net_device_ops ovpn_netdev_ops = {
>>>>    	.ndo_get_stats64        = dev_get_tstats64,
>>>>    };
>>>> +static int ovpn_get_link_ksettings(struct net_device *dev,
>>>> +				   struct ethtool_link_ksettings *cmd)
>>>> +{
>>>> +	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported, 0);
>>>> +	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising, 0);
>>>> +	cmd->base.speed	= SPEED_1000;
>>>> +	cmd->base.duplex = DUPLEX_FULL;
>>>> +	cmd->base.port = PORT_TP;
>>>> +	cmd->base.phy_address = 0;
>>>> +	cmd->base.transceiver = XCVR_INTERNAL;
>>>> +	cmd->base.autoneg = AUTONEG_DISABLE;
>>>
>>> Why? It is a virtual device. Speed and duplex is meaningless. You
>>> could run this over FDDI, HIPPI, or RFC 1149? So why PORT_TP?
>>
>> To be honest, I couldn't find any description to help me with deciding what
>> to set there and I just used a value I saw in other Ethernet drivers.
>>
>> Do you have any recommendation?
>> For the other fields: do you think they make sense? The speed value is
>> always debatable...The actual speed depends on the transport interface and
>> there might be multiple involved. Maybe SPEED_UNKNOWN is more appropriate?
> 
> Turn it around. What is your use case? What is using this information?
> I would just not implement this function. But maybe you know of
> something which actually requires it?

At the moment there is nothing on my side requiring this function.

I thought it was recommended to provide an implementation so that any 
potential user would be happy (some monitoring tool? some other module 
in the kernel?)

But if you think there is no meaningful use case for it, then I think it 
makes sense to just drop it, as we are filling it with random/virtual 
values.

> 
>>>> +	strscpy(info->bus_info, "ovpn", sizeof(info->bus_info));
>>>
>>> This is also not accurate. There is no bus involved.
>>
>> Should I just leave it empty then?
>>
>> My concern is that a user expects $something and it will crash on my empty
>> string. But if empty is allowed, I will just go with it.
> 
> Empty is allowed. The bridge uses "N/A", which i would say is also
> correct. tun/tap does however use "tun", so "ovpn" is not that
> different i supposes.

I just grepped through the kernel and I can see various patterns.
I also found:

  899         strscpy(info->bus_info, "batman", sizeof(info->bus_info));

:-)

All in all, I agree we can sick to "ovpn".

Regards,

> 
> 	Andrew
> 

-- 
Antonio Quartulli
OpenVPN Inc.

