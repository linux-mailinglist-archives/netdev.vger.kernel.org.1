Return-Path: <netdev+bounces-118924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84150953867
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 18:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 300A7287C48
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 16:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5DB19E7E8;
	Thu, 15 Aug 2024 16:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0qqiAzO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE671AC8B2
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 16:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723739934; cv=none; b=c2NP/3BZwBjHlKE0o5PxRb+YrJfmwOMtqIEzVTWgOzn2RtcZsoJ9MdN5EVW58E+t1OPA98dtity8V/14rvSqZNLujSdNL7Pi718GKJ0jqHlaOxrDLIv/w+2En98HuHBIX09hSt0b9nJEWPI84//oRTeTmHr6DXML19qK0SClNbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723739934; c=relaxed/simple;
	bh=XNqqCRvGv06TG9C6Suu5ay22wjRBbLYGGKqYBW2PhWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gyVQQq+Mjy9RHXFfOSIYiLBDoUhP49PB+IGK/Lx/34o0ezvQlQP7qNlOIp9m2Iuh4sUKlK1pE1nW4qMh5wTO82v6jjc/3/PDEqcrMLo56UlQ2yg0Xz54a+LlQ/RYo1UIhxS8bpRosx65RoL4uckrckgGobue7F4IYANOdaZKm2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C0qqiAzO; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-201fbd0d7c2so4466875ad.0
        for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 09:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723739932; x=1724344732; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rl9lcgzrBFJlPh/Jc5JC63Tk/Sye9b2WgE/pAAjbI/Y=;
        b=C0qqiAzOVgQkiZNXCuqfGvufkfzqYObytfg48C9mbQMS3wSSVsRXIX59Co7/WOfOsZ
         PR536ssUH/G0r0toTbaQj6shW0bVhqk6bB6tirq0+Wv5eNqHKjHGQs8NILr7Zwk5+7Bw
         NSHNlqbed8XDnaDZbBX8yqqinHKa8AX1NX0Fl+7iS/j0p7mEBkBiFElDo2DoagC87A/A
         4y918cEVzAB0+ruUV8jDx0hCuK+b696AGX3JjrjkTPGsfqCNoW6TGY1+1VBXu8lFF+tO
         c+MbKTj9rY3+9YHgEYQ770GVeUqE35l7wZs51QRnxrL3eHfiyAZIX6Ei5NlzQKA0PKnB
         yZ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723739932; x=1724344732;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rl9lcgzrBFJlPh/Jc5JC63Tk/Sye9b2WgE/pAAjbI/Y=;
        b=S5Do0ImvATAj0sqTx6dFDl55adPmZhPAE/IjGm2vpuWhQ+vlZdJHk01H49CEpldE5V
         bKEuz7TdN/WdKogdBnHE/Ivq8FYKtV3/0Fa8qLOlG6FXH/LjfYwsYvf8wRKggEWMOfLJ
         CiTf9nym2XCw7uXhNoJ5HCuVWF8OK+K+cm/CBLRLR6KGcrKhQUsv+NJz7W1x89mdHYnj
         klPJmsAEBPLt24v35TxQD9A/2AGlm3p0UytcJLwaffhBzgMwlbM2oCUBCMxTgzLvos3o
         OQS9EmzH2zvChZzK6UVI7s2fy+qtykczvthYs7iFQVuUZz8qAy2+MzIb4GSPV/8n471j
         Mt4A==
X-Forwarded-Encrypted: i=1; AJvYcCXHOT5Ely9Mfq8m+ZNIAur2u4yGnT8v1qCd4rMwDbrF6OW4hCk39FG9h8vSUP5lKh7wTRJqQ8eULH+KkyTC/bT5Oy2pko3o
X-Gm-Message-State: AOJu0YxMyl8+fVuDOjRtmVqIiVZKg0zUfTkP1wm+Byl/IvR6T0bYke+O
	+vyG7JD5yuDgaNxeZDc6E9O8OgJm02sTL/BzbTuVgmebQOh5J+nz
X-Google-Smtp-Source: AGHT+IGeOYsXfEqtNRRSVyeVNwo3VEOcdS7lFTAZKqWeXr/AhU4GI4FIQBuK1b14La1/N88EWZgsUQ==
X-Received: by 2002:a17:902:ced2:b0:201:eed3:80dd with SMTP id d9443c01a7336-20204062fc9mr3379795ad.65.1723739932070;
        Thu, 15 Aug 2024 09:38:52 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-201f03a5706sm11970205ad.296.2024.08.15.09.38.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 09:38:51 -0700 (PDT)
Message-ID: <a9027470-f4b4-483b-b0f3-88e17edaa7a1@gmail.com>
Date: Thu, 15 Aug 2024 09:38:48 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ethtool: add tunable api to disable various
 firmware offloads
To: Jakub Kicinski <kuba@kernel.org>
Cc: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>,
 Doug Berger <opendmb@gmail.com>, Justin Chen <justin.chen@broadcom.com>,
 =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>,
 Linux Network Development Mailing List <netdev@vger.kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>,
 Ahmed Zaki <ahmed.zaki@intel.com>, Edward Cree <ecree.xilinx@gmail.com>,
 Yuyang Huang <yuyanghuang@google.com>, Lorenzo Colitti <lorenzo@google.com>
References: <20240813223325.3522113-1-maze@google.com>
 <20240814173248.685681d7@kernel.org>
 <b46f8151-29ab-453c-9830-884adcecdcfb@gmail.com>
 <20240815084526.5b1975c3@kernel.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240815084526.5b1975c3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/15/24 08:45, Jakub Kicinski wrote:
> On Wed, 14 Aug 2024 20:08:05 -0700 Florian Fainelli wrote:
>>> You gotta find an upstream driver which implements this for us to merge.
>>> If Florian doesn't have any quick uses -- I think Intel ethernet drivers
>>> have private flags for enabling/disabling an LLDP agent. That could be
>>> another way..
>>
>> Currently we have both bcmgenet and bcmasp support the WAKE_FILTER
>> Wake-on-LAN specifier. Our configuration is typically done in user-space
>> for mDNS with something like:
>>
>> ethtool -N eth0 flow-type ether dst 33:33:00:00:00:fb action
>> 0xfffffffffffffffe user-def 0x320000 m 0xffffffffff000fff
>> ethtool -N eth0 flow-type ether dst 01:00:5e:00:00:fb action
>> 0xfffffffffffffffe user-def 0x1e0000 m 0xffffffffff000fff
>> ethtool -s eth0 wol f
>>
>> I would offer that we wire up the tunable into bcmgenet and bcmasp and
>> we'd make sure on our side that the respective firmware implementations
>> behave accordingly, but the respective firmware implementations
>> currently look at whether any network filter have been programmed into
>> the hardware, and if so, they are using those for offload. So we do not
>> really need the tunable in a way, but if we were to add it, then we
>> would need to find a way to tell the firmware not to use the network
>> filters. We liked our design because there is no kernel <=> firmware
>> communication.
> 
> Hm, I may be lacking the practical exposure to such systems to say
> anything sensible, but when has that ever stopped me..
> IIUC you're saying that FW enables MLD offload if the wake filter is
> in place. But for ping/arp/igmp offload there's no need to wake, ever,
> so there wouldn't be a filter?

That is right, we only want to wake-up on mDNS in our case. There are 
two cases deployed, at least the first one is, the second one might have 
been more of a "to be added in the future" improvement:

- a simplistic one where we use the hardware filters to trigger a 
wake-up event, and then some piece of firmware will look at the mDNS 
query contents and figure out whether the query was for one of the 
services in the local database (typically _googlecast._tcp.local is of 
particular interest). If that is the case, we trigger a system wake-up 
and we let the Host CPU process the mDNS query and we stay awake for a 
few seconds in case a streaming operation happens

- a more sophisticated one where after the mDNS query wake-up event has 
been identified we wait until we get a 3-way TCP handshake targeting the 
_googlecast._tcp.local service before waking up the Host CPU. This is 
more reflective of an actual intent to use the device that was asleep

Hope this helps.
--
Florian


