Return-Path: <netdev+bounces-107567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CC791B836
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 09:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98B0A1C212A2
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 07:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A631013E3FD;
	Fri, 28 Jun 2024 07:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="FOQErfZa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BB614372B
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 07:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719559350; cv=none; b=am0XSueQRCuwGCB96tUA3SdEb3jFSCLQYT9QV36X5wI9eoMdrSVT6KyBHHhnWZLmuTayaFLWMGb2+MQkHPpMsWHWZOrGwEkDCqrlf7YNHTgMpS3LfbPR0o2F0oIZmIp9wHCeH31NPdT+yNb+LQAw03WUk1RRXTeb8T+wXQyVz6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719559350; c=relaxed/simple;
	bh=a8cCohTKWTSk+klZedjaNxkZe8pRILhJIqkF6oomqmM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=hFh6aQRG9HFBvQj7hlK7JVo2OtWjwoAtVnF3aUDstF91k2M+z+OPDIOxzxsCneun+MPYLmdECe4oKJEadGG6S8Ek6NSRbUxMhtI9212OBSlwfRKZwDoSNJooXK9M64JRPJ/P/RwOE3ExxJX7mqEVBAX5FjF4DTpAXS2lQxFslnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=FOQErfZa; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a727d9dd367so30887666b.3
        for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 00:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1719559347; x=1720164147; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mnYsCeVsFxB9gW97f97uREWVYGGY9Zu5LkLH7hxYVE8=;
        b=FOQErfZaziRkiVhNpKBANTKPdm76sT9R1h+chCZTXYjoTYgfY+Jv9HmIrSvdbjMNhJ
         v0OQVdhALDBSmyMRXkjjKNPPHQnNpFwQ8H7akM/X0cO7plAU2CgbqcbXxxTieySZRgXS
         sbpZJxqV5kP7FUeLXnWg3kNrk2UGOo+LW7cvVloZn+G6ZmICI5Qj7GzVYFJzwBkfJ34d
         7/50eoUPV0tS8oUeo5a7tIKpvEAqnlu2ldvZcW1pD01ryBtnDyNIot8vrS4BJeREEt0c
         +yaSEpObVFNMFlXL+JSnT+E3+XNLH0+g+sEALiGHRSa5aC1t/A6ra0bh6zPpkVVjWXUR
         H06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719559347; x=1720164147;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mnYsCeVsFxB9gW97f97uREWVYGGY9Zu5LkLH7hxYVE8=;
        b=ElZeQPrjzIJPGTByw4ydFMuJbP4gOTwafRX+sfgP9/+k1nvFYQFAUY+WjYv5e6QF8g
         cA7Bx0dlbfuqlIviYSlQWRO4JfNRUgM81cw1R0r6LK+Gwd/8W0z2OZhybYGgo7QfiLjA
         jy3+weuRmcCiwa4izMXoHqLoJYXoACPSW+L0VipOZUXa01WpWdUQNM7dqcBmjqXPnFZt
         mI5E2At//Cpwwj9m9oWJ//dO/0yOrcQ446p5cYCV383n4c5m63XvGpZSCLjtRjD4a2Wo
         bOspfkEp7b3XKtSRccGgDlIk5/ipEyVQAutkuW4P2dFufJixLte/E1Jfc5fQfnMqP5Hy
         GAiw==
X-Forwarded-Encrypted: i=1; AJvYcCWEvr+6cBO7u77k436AmK6/lm4rpaJeanmD7SCujbzKgVWKNqDCg5MRQMWLorkwa+xe5DjL8ShNbaxZZ7GUZsq+9PmOPsMo
X-Gm-Message-State: AOJu0YzhEKUvkf4gZ+YrsWPrY4Hkw9rblKVFhW0KUNv8fDlNsV36lELy
	/vI0lUK1GVfvJNhf44SUF/kZ+xiYI4jaapuGIgMtq56S7/gh8nPAmjC1KVrFk0E=
X-Google-Smtp-Source: AGHT+IE3TJL3OMrzex7yJ6C9J0G308h/Ih0UGZde2vdvleZeu7e8Jj1fkZIDSYrI6Vflek25XytTpA==
X-Received: by 2002:a17:907:a649:b0:a72:8135:2d4f with SMTP id a640c23a62f3a-a7281352e3cmr730983366b.48.1719559346964;
        Fri, 28 Jun 2024 00:22:26 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72ab0b3475sm47959366b.195.2024.06.28.00.22.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jun 2024 00:22:26 -0700 (PDT)
Message-ID: <8e978679-4145-445c-88ad-f98ffec6facb@blackwall.org>
Date: Fri, 28 Jun 2024 10:22:25 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 net-next] bonding: 3ad: send ifinfo notify when mux
 state changed
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Hangbin Liu <liuhangbin@gmail.com>,
 Jay Vosburgh <jay.vosburgh@canonical.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 Andy Gospodarek <andy@greyhouse.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>,
 Jiri Pirko <jiri@resnulli.us>, Amit Cohen <amcohen@nvidia.com>
References: <20240626075156.2565966-1-liuhangbin@gmail.com>
 <20240626145355.5db060ad@kernel.org> <1429621.1719446760@famine>
 <Zn0iI3SPdRkmfnS1@Laptop-X1>
 <7e0a0866-8e3c-4abd-8e4f-ac61cc04a69e@blackwall.org>
 <Zn05dMVVlUmeypas@Laptop-X1>
 <89249184-41ac-42f6-b5af-4a46f9b28247@blackwall.org>
 <Zn1mXRRINDQDrIKw@Laptop-X1> <1467748.1719498250@famine>
 <Zn4po-wJoFat3CUd@Laptop-X1>
 <efd0bf80-7269-42fc-a466-7ec0a9fd5aeb@blackwall.org>
Content-Language: en-US
In-Reply-To: <efd0bf80-7269-42fc-a466-7ec0a9fd5aeb@blackwall.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/06/2024 10:04, Nikolay Aleksandrov wrote:
> On 28/06/2024 06:10, Hangbin Liu wrote:
>> On Thu, Jun 27, 2024 at 07:24:10AM -0700, Jay Vosburgh wrote:
>>> Hangbin Liu <liuhangbin@gmail.com> wrote:
>>>> Ah.. Yes, that's a sad fact :(
>>>
>>> 	There are basically two paths that will change the LACP state
>>> that's passed up via netlink (the aggregator ID, and actor and partner
>>> oper port states): bond_3ad_state_machine_handler(), or incoming
>>> LACPDUs, which call into ad_rx_machine().  Administrative changes to the
>>
>> Ah, thanks, I didn't notice this. I will also enable lacp notify
>> in ad_rx_machine().
>>
>>> bond will do it too, like adding or removing interfaces, but those
>>> originate in user space and aren't happening asynchronously.
>>>
>>> 	If you want (almost) absolute reliability in communicating every
>>> state change for the state machine and LACPDU processing, I think you'd
>>> have to (a) create an object with the changed state, (b) queue it
>>> somewhere, then (c) call a workqueue event to process that queue out of
>>> line.
>>
>> Hmm... This looks too complex. If we store all the states. A frequent flashing
>> may consume the memory. If we made a limit for the queue, we may still loosing
>> some state changes.
>>
>> I'm not sure which way is better.
>>
>>>
>>>>> It all depends on what are the requirements.
>>>>>
>>>>> An uglier but lockless alternative would be to poll the slave's sysfs oper state,
>>>>> that doesn't require any locks and would be up-to-date.
>>>>
>>>> Hmm, that's a workaround, but the admin need to poll the state frequently as
>>>> they don't know when the state will change.
>>>>
>>>> Hi Jay, are you OK to add this sysfs in bonding?
>>>
>>> 	I think what Nik is proposing is for your userspace to poll the
>>> /sys/class/net/${DEV}/operstate.
>>
> 
> Actually I was talking about:
>  /sys/class/net/<bond port>/bonding_slave/ad_actor_oper_port_state
>  /sys/class/net/<bond port>/bonding_slave/ad_partner_oper_port_state
> etc
> 
> Wouldn't these work for you?
> 

But it gets much more complicated, I guess it will be easier to read the
proc bond file with all the LACP information. That is under RCU only as
well.

>> OK. There are 2 scenarios I got.
>>
>> 1) the local user want to get the local/partner state and make sure not
>> send pkts before they are in DISTRIBUTING state to avoid pkts drop, Or vice
>> versa. Only checking link operstate or up/down status is not enough.
>>
>> 2) the admin want to get the switch/partner status via LACP status incase
>> the switch is crashed.
>>
>> Do you have any suggestion for the implementation?
>>
>> Thanks
>> Hangbin
> 


