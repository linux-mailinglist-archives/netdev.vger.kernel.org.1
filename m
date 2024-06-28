Return-Path: <netdev+bounces-107565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A2C91B78C
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 09:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7703BB21298
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 07:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F73348788;
	Fri, 28 Jun 2024 07:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="M+iz6T6Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5B2125AC
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 07:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719558283; cv=none; b=Yd9bez4w8/n1BmCMwt2KYH5IrfHck2Qe4ZnMxxlKZVX6MM+rgFcUrkAuaJpHIF78BZU5DGGCXefz23jGOmpvUcjuxquUnGNRiM1KDx/c2XfV125yW+WFXXWvhu9fzcjixS+Hy9b01rHnaUZb6Rbe+1geAhJhca4UJYj1V9OPQXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719558283; c=relaxed/simple;
	bh=TNRCRQRphWRHNiKCjpdfQeClEGzlS/9rG/r4U1D6SHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XafPQ8MoBh7YKp+fCV7icTAwZa1zg5ANqRhYyOMxkW3AF/kt2vTegdR4btmXojwWQCNQj7KdEd0f6Q2zbiCtW62OCwtUbq5rLP+T9N9KlUqUn2d7xaozekmyYh6ifnTZ8+Y5UM+S7FUydinfoyVbnYsMbIa9DhxjKLkauXF1wBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=M+iz6T6Z; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a72420e84feso35781566b.0
        for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 00:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1719558280; x=1720163080; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B0ccEIPqJDw1UNA11+VDhYJTv3xIl5wO8QiUrak+S/w=;
        b=M+iz6T6Zlpnm5IfItOtluFYDFmwS2pCdXC5+HHp1weRFwLuHucz4jFYbSt6irHuQ+d
         Ukzmt+GxToRZs1MWusgp1/FsDlptUDICWtQ//DiyUjEhlAGfrZZomlhAlIFgm85B00ol
         q4cDYJO+4QVtNvJR5a/gyCi3FnfNgHWBzcqUFRsDEgSH4h20Bc+2/8cd4QmMZ3SWN4dt
         dodDQzz5zu2aRaGOMw/yIy6Ezn6nOacdZ+Y8B/diFDhuGUULOMHTKrv/LqV+KEA/F0rL
         2/Mn7jsNIBQkVgCnvtW0lYKb9rBvQt+Il55bGPjRCTaEapwV/TTONo8zZK9mtc4nvbUC
         CXmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719558280; x=1720163080;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B0ccEIPqJDw1UNA11+VDhYJTv3xIl5wO8QiUrak+S/w=;
        b=amkzC77s9WonNdqVWRKoLj3m2uubiaHFqj4foVOtC7DzX8qT3bVvCXmD1rzymCk+TZ
         4l4u82t20eqX/EjJ/+hPg/ueBIQTLeN9HXa6ozCF0+DmE688kPf6lBDanVlSiI3VNmCs
         E1O+9vuZvaeC2zQ7yN3KVlr11dagBry6JwCJFOmLEV6AWjiXHFzijpccE91dxQ0Z9eMj
         BXNEKJr5d1VBcee0HQmN5qoJLitKxZag9boF7K1fHDKLmUapSQC4he1TK8PFkVsfUjwm
         cpmbFy/y0eLckoBKhVK8ObUYIzNVYxHt37xbYFDoXKkVntoqLsZGU7CRwPbTovd+SUY5
         YERw==
X-Forwarded-Encrypted: i=1; AJvYcCU6DzgaYdsAg1DcG6R8T97RqO1zv/F4WhN7Icm75sOgpxK4IRQfzW0Lb3jovRNN0qC6xN0gW929fNwm8eKFd85AK3DwjJ+j
X-Gm-Message-State: AOJu0YzWTgTG2+Hi2FtsRC8OA21lDMtW4QEJhJ94NDjwe+0NwoGLZRvh
	OrM2kRuOAcHvkmxNpmbhw0oysucyAeo5oFCRO8NNHjlXl09FJP6+HzMapFhGdeI=
X-Google-Smtp-Source: AGHT+IGRKjMx9UldsfKmjnL35yXWeQNvXIKHaS7NL8+UxaPCLFhDJqrT4+i2GKuQOiT/bNSkNK2GBA==
X-Received: by 2002:a17:906:aecf:b0:a6f:e111:d592 with SMTP id a640c23a62f3a-a7245be0890mr1047818366b.35.1719558279464;
        Fri, 28 Jun 2024 00:04:39 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72aaf638f3sm47153266b.89.2024.06.28.00.04.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jun 2024 00:04:39 -0700 (PDT)
Message-ID: <efd0bf80-7269-42fc-a466-7ec0a9fd5aeb@blackwall.org>
Date: Fri, 28 Jun 2024 10:04:37 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 net-next] bonding: 3ad: send ifinfo notify when mux
 state changed
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
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <Zn4po-wJoFat3CUd@Laptop-X1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/06/2024 06:10, Hangbin Liu wrote:
> On Thu, Jun 27, 2024 at 07:24:10AM -0700, Jay Vosburgh wrote:
>> Hangbin Liu <liuhangbin@gmail.com> wrote:
>>> Ah.. Yes, that's a sad fact :(
>>
>> 	There are basically two paths that will change the LACP state
>> that's passed up via netlink (the aggregator ID, and actor and partner
>> oper port states): bond_3ad_state_machine_handler(), or incoming
>> LACPDUs, which call into ad_rx_machine().  Administrative changes to the
> 
> Ah, thanks, I didn't notice this. I will also enable lacp notify
> in ad_rx_machine().
> 
>> bond will do it too, like adding or removing interfaces, but those
>> originate in user space and aren't happening asynchronously.
>>
>> 	If you want (almost) absolute reliability in communicating every
>> state change for the state machine and LACPDU processing, I think you'd
>> have to (a) create an object with the changed state, (b) queue it
>> somewhere, then (c) call a workqueue event to process that queue out of
>> line.
> 
> Hmm... This looks too complex. If we store all the states. A frequent flashing
> may consume the memory. If we made a limit for the queue, we may still loosing
> some state changes.
> 
> I'm not sure which way is better.
> 
>>
>>>> It all depends on what are the requirements.
>>>>
>>>> An uglier but lockless alternative would be to poll the slave's sysfs oper state,
>>>> that doesn't require any locks and would be up-to-date.
>>>
>>> Hmm, that's a workaround, but the admin need to poll the state frequently as
>>> they don't know when the state will change.
>>>
>>> Hi Jay, are you OK to add this sysfs in bonding?
>>
>> 	I think what Nik is proposing is for your userspace to poll the
>> /sys/class/net/${DEV}/operstate.
> 

Actually I was talking about:
 /sys/class/net/<bond port>/bonding_slave/ad_actor_oper_port_state
 /sys/class/net/<bond port>/bonding_slave/ad_partner_oper_port_state
etc

Wouldn't these work for you?

> OK. There are 2 scenarios I got.
> 
> 1) the local user want to get the local/partner state and make sure not
> send pkts before they are in DISTRIBUTING state to avoid pkts drop, Or vice
> versa. Only checking link operstate or up/down status is not enough.
> 
> 2) the admin want to get the switch/partner status via LACP status incase
> the switch is crashed.
> 
> Do you have any suggestion for the implementation?
> 
> Thanks
> Hangbin


