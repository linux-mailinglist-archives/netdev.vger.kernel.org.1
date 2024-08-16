Return-Path: <netdev+bounces-119157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01173954650
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 11:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8C481F21D73
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 09:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376E116C69F;
	Fri, 16 Aug 2024 09:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="G967YlJm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604E536C
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 09:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723802316; cv=none; b=iR0XzuiZrw5v+oBajNb/pbNlxYvvo+hIU3j/t3/9ymTSeKBlhrh+/w6YxMzWokVoWTGEkNUfEbXnfR4k2WKjHrZP/7cA4EQ2AWXZypcg8YIqXyQKhg2legeaklSGV1fhboa5Bi0Lul9rVLCt7pb/oRXdbCMvTmICqRs1FaSAfyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723802316; c=relaxed/simple;
	bh=OumBy7TCU3N/VpZy7ND89lMgLM66f67c1xqdU4VBJh4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=pPLq0DR+m/evTtcNNSE28CIVt/eGzg9Wwgcust2IWFiJouS9FNKAHuqhxTAcTcmuIlVaus80BsxncrvyJDNfhceRS1uuwEOPTp+pMAuwXq6GIhYJ/tWUVGKbcYmAU95cD3pzbHta0o7RxZgVkZAS+74uyVj+KEVNED2Z1gCze8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=G967YlJm; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5bec4e00978so1307882a12.0
        for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 02:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1723802313; x=1724407113; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Zl+hd3BrnmF0mZkERWZJnOOgZlicvOau8G1gwejR6H0=;
        b=G967YlJmy0wqPO4L3Z//tKyanwba1viyWO3vG0mkYtPw09e83HRMSe4+hzdsVmENiA
         P9oeWo2vv36v4pJugm4qaimOmUns7hXPVJfYeAqlfRkJ5MqOe2I8BXIAji3Yvebnju+g
         07dJTySG7zI/CInZMCeIyZSWnvrPRZ+N38Uuy5CGuYlPcDXlXqUg0CaR47guLyLCgChV
         McmDf4SWSB9Xm3I1vhvoUNyCE6W0guD0BjKtzf6krCkeqBDF7usTcDHn/UOj6cpPnsWn
         EE71rEyeCOErIngC1N2PF999vBAv6RwZsqooTnaf1KlWwwj/d2Rlb8u1cG0Ki+KNOwS9
         ExWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723802313; x=1724407113;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zl+hd3BrnmF0mZkERWZJnOOgZlicvOau8G1gwejR6H0=;
        b=lFEKSyytMlGTG9EcaMfOKD+27CesxMnQY1MxhOQUcRS9DwQNImHYIe+5uH8Ox8oQQ+
         K7N7xa7uuyBfqINhoc2niQpyYEHdiZndmjILU0ZnuvuNlD0sL+RzQs85FkTOrak2jz1V
         LWpkZGbnP+1ICv+LAhDqBC3yzLcN4XQXo1z/y2OKt2KkbVt/DzAtOUeL7rorxPp/j/hI
         PP8gC0WdF23dO9M/ZnaS+M1IAOTdv1+hjg0SgdAEkjs4GezI03rPIrEo3elbPnaZETmB
         NBUoBqM2f1WTbN91efgCH+Os72iyzfxUvwjYWQjVfXMgbP0Vg53GnAwklTrbS0vlz3OK
         UOuw==
X-Gm-Message-State: AOJu0YzQA6MffamvrNj7gQUMhskKq0pfbg8KlTrKwgA5jInvMmWAeOYC
	NUzYw0E8POAtch3HWhCacPZxxvjybOH0trmSU88b/8QG7Td/6SRvURZwVmLoVO8wmESSgbOR3bK
	+
X-Google-Smtp-Source: AGHT+IHNlc3aajiU+vAI4ZJ2PBWTm8K7uRgB+c8gTrf++4nBHafk+V9W0Y+5Dss0/s66ll6sNuZjgQ==
X-Received: by 2002:a05:6402:2809:b0:5a1:cab1:fbd0 with SMTP id 4fb4d7f45d1cf-5beca4d5f71mr1534652a12.5.1723802312248;
        Fri, 16 Aug 2024 02:58:32 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbde4913sm2017068a12.27.2024.08.16.02.58.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 02:58:31 -0700 (PDT)
Message-ID: <69a8ec12-ac65-46e3-9d0c-ba9a56dbe5bb@blackwall.org>
Date: Fri, 16 Aug 2024 12:58:30 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/2] Bonding: support new xfrm state offload
 functions
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <j.vosburgh@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
 Sabrina Dubroca <sd@queasysnail.net>
References: <20240816035518.203704-1-liuhangbin@gmail.com>
 <334c87f5-cec8-46b5-a4d4-72b2165726d9@blackwall.org>
 <Zr8Ouho0gi_oKIBu@Laptop-X1>
 <13fecb7a-c88a-4f94-b076-b81631175f7f@blackwall.org>
 <bbb2c180-d38d-4bda-bc24-9500eb97cd65@blackwall.org>
Content-Language: en-US
In-Reply-To: <bbb2c180-d38d-4bda-bc24-9500eb97cd65@blackwall.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/08/2024 12:04, Nikolay Aleksandrov wrote:
> On 16/08/2024 11:37, Nikolay Aleksandrov wrote:
>> On 16/08/2024 11:32, Hangbin Liu wrote:
>>> On Fri, Aug 16, 2024 at 09:06:12AM +0300, Nikolay Aleksandrov wrote:
>>>> On 16/08/2024 06:55, Hangbin Liu wrote:
>>>>> I planned to add the new XFRM state offload functions after Jianbo's
>>>>> patchset [1], but it seems that may take some time. Therefore, I am
>>>>> posting these two patches to net-next now, as our users are waiting for
>>>>> this functionality. If Jianbo's patch is applied first, I can update these
>>>>> patches accordingly.
>>>>>
>>>>> [1] https://lore.kernel.org/netdev/20240815142103.2253886-2-tariqt@nvidia.com
>>>>>
>>>>> Hangbin Liu (2):
>>>>>   bonding: Add ESN support to IPSec HW offload
>>>>>   bonding: support xfrm state update
>>>>>
>>>>>  drivers/net/bonding/bond_main.c | 76 +++++++++++++++++++++++++++++++++
>>>>>  1 file changed, 76 insertions(+)
>>>>>
>>>>
>>>> (not related to this set, but to bond xfrm)
>>>> By the way looking at bond's xfrm code, what prevents bond_ipsec_offload_ok()
>>>> from dereferencing a null ptr?
>>>> I mean it does:
>>>>         curr_active = rcu_dereference(bond->curr_active_slave);
>>>>         real_dev = curr_active->dev;
>>>>
>>>> If this is running only under RCU as the code suggests then
>>>> curr_active_slave can change to NULL in parallel. Should there be a
>>>> check for curr_active before deref or am I missing something?
>>>
>>> Yes, we can do like
>>> real_dev = curr_active ? curr_active->dev : NULL;
>>>
>>> Thanks
>>> Hangbin
>>
>> Right, let me try and trigger it and I'll send a patch. :)
>>
> 
> Just fyi I was able to trigger this null deref easily and one more
> thing - there is a second null deref after this one because real_dev is
> used directly :(
> 
> I'll send a patch to fix both in a bit.
> 
> 

TBH I don't know how bond xfrm code is running at all. There are *many*
bugs when I took a closer look. I'll try to prepare a patch-set to address
them all. This code is seriously broken...


