Return-Path: <netdev+bounces-146053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA2D9D1D90
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 02:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C36FB210D4
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 01:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6DF5588E;
	Tue, 19 Nov 2024 01:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kx2s9EX6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7106F42065;
	Tue, 19 Nov 2024 01:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731980914; cv=none; b=OAIS1sdjL+5waiRx2g/vhAKu0k2T2rdeOCiRq8WwU619y+hFFywttW/u6knzdK+/u5IKzVub45ubXXl7oAigyJ6BUoLVkIt05AIIJ3lx4emDDrIoW1nOzSCFlCY/qv1JmoiU3hKr5/aFAdejCHmIi2slVK3ccEWlmjB/1cIQkp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731980914; c=relaxed/simple;
	bh=vrQ8D5Fxh2GWkQtlVSENJgPbSGTIiVhdrEZ87raCjYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qIcSrmBW6Ib+iLHcRCnurUWVIHd5atIIXFep3cQspr34oOyPScIdMPbXBjZ3L9dxX8/9ux+GEsxD38I2E0r42e9pCh/Wfmi/ItEGC7vZwYbW1bbgQEjPMIJFrinKVaj3aaOlf3lnZHx8uY7TYTiMhEe3ZRMzI3F1tWLOmu9BGX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kx2s9EX6; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43152b79d25so31403215e9.1;
        Mon, 18 Nov 2024 17:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731980911; x=1732585711; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uz3wUrFKoqJPxl5SiP7C5+eQgBZgIkUDTl0uXwsGaqI=;
        b=kx2s9EX6nuxMrv4/AIBoNLOEX8JfuhnKVeIIA5YlLuRrwIoqIXyIupWSAmcOeQUzVN
         Ey6WOMwM17iC5ImymddmgXvXyGg5ExKf3u6decREY9tiayJaiLkxUZEcYrbKM60Dn4Rm
         SEH3nl92t5AjSVjdLDdqy8o/YvdyIYlC1SACf+QB3h86GpVs5+l2hEue73Se/i3MoxcJ
         E5iyV6nG55Bz0tPEXhv3FF8ItLU6ecoMIqaMj63AzNQMygFXNkFkO+6DkMFBWkgriaB5
         iKhRyBzQ6u5UkyFHCGZ3CReDLkwelUpUgPjm08Zv38ImmHNFfns4Tmy9Ald6gooWCADB
         CAbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731980911; x=1732585711;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uz3wUrFKoqJPxl5SiP7C5+eQgBZgIkUDTl0uXwsGaqI=;
        b=t7aAVT7di7sS1py2IRQz5F8QjBRkYGxuE9rWuwYIIBTIIDBSbYkFrs66jZb63Yh3Bx
         1HKWz3jekD1+m1i8+xjg+sZNf4P4b4xdjFe9dO/NRKoQ/+EiLW7hfyt6M4TnIO7YR42j
         TbK1f+oiczmaRm/VwDx/jfCKTt/5buSWcoq8xzt1AIcsj0sKUObDPCByD/eDPkA44QaJ
         rrtroCRyoFj7YbgrvXGyzvfwu5JOUf0K22fIyTP4O2d88yHckFReEzm5XYsQSEweu1f9
         ApQqov/eMEgsT26D9nQEcuq8R6zDidFTRk5KmwY7ANgz9Q0DR+cJiVUKQTwMJ/KQJa6u
         8eRA==
X-Forwarded-Encrypted: i=1; AJvYcCUIsKftz78I5UoA3atdSPAcU387dKp+EdW+2d6qpJaOT9SxolyqNFAxx70eWbLOJDdFZ/i/5iSi@vger.kernel.org, AJvYcCWKsfei0nEz8aR58/fLP5vKwcgPCRFri485Vm0oDJ9MRUXHWbyLQ7r+5uhQSohHcHAJeUI3KqJgOWOxQxM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycui5lbPeQdtbYnXu32GbWcywwWhdzFsNbL+OQwOpK2wMDfyuP
	czzEbBVdMmYHabNWVj/x34Zdr7GPIL6f5sIjD5kML1DUNvNwz/NG
X-Google-Smtp-Source: AGHT+IEMDKefmR/xn05F+WwOBdB/MRuqus2iBEEiU6xnxfkhXrtsTCNYxPWuLEcy8mr+Jnx2qKSQIA==
X-Received: by 2002:a05:600c:4693:b0:431:55af:a22f with SMTP id 5b1f17b1804b1-432df72c9e7mr127191905e9.13.1731980910678;
        Mon, 18 Nov 2024 17:48:30 -0800 (PST)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da244cabsm176505115e9.8.2024.11.18.17.48.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 17:48:30 -0800 (PST)
Message-ID: <6ec331d6-16b7-4e0d-a32a-0fa92a439d97@gmail.com>
Date: Tue, 19 Nov 2024 03:49:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 02/23] net: introduce OpenVPN Data Channel
 Offload (ovpn)
To: Antonio Quartulli <antonio@openvpn.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 sd@queasysnail.net, Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, steffen.klassert@secunet.com,
 antony.antony@secunet.com
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-2-de4698c73a25@openvpn.net>
 <f35c2ec2-ef00-442d-94cd-fa695268c4f2@gmail.com>
 <466ec41a-24b7-43a9-b75f-94556785800a@openvpn.net>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <466ec41a-24b7-43a9-b75f-94556785800a@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15.11.2024 11:56, Antonio Quartulli wrote:
> On 06/11/2024 01:31, Sergey Ryazanov wrote:
>>> As explained above, in case of P2MP mode, OpenVPN will use the main 
>>> system
>>> routing table to decide which packet goes to which peer. This implies
>>> that no routing table was re-implemented in the `ovpn` kernel module.
>>>
>>> This kernel module can be enabled by selecting the CONFIG_OVPN entry
>>> in the networking drivers section.
>>
>> Most of the above text has no relation to the patch itself. Should it 
>> be moved to the cover letter?
> 
> I think this needs to be in the git history.
> We are introducing a new kernel module and this is the presentation, so 
> I expect this to live in git.

Sure! I hope Jakub can literally merge the series as a branch with the 
merge commit containing the text from the cover later. If it's not Ok, 
then keeping the introduction in the first patch is a good idea.

> This was the original text when ovpn was a 1/1 patch.
> I can better clarify what this patch is doing and what comes in 
> following patches, if that can help.

The text itself looks a nice introduction into the functionality, keep 
it please.

>>> +/* Driver info */
>>> +#define DRV_DESCRIPTION    "OpenVPN data channel offload (ovpn)"
>>> +#define DRV_COPYRIGHT    "(C) 2020-2024 OpenVPN, Inc."
>>
>> nit: these strings are used only once for MODULE_{DESCRIPTION,AUTHOR} 
>> below. Can we directly use strings to avoid levels of indirection?
> 
> I liked to have these defines at the top as if they were some form of 
> greeting :) But I can move them down and drop the constants.

715 of 784 network driver modules directly specify the description. I 
see mostly old drivers are using a dedicated macro. But it's up to you 
how to say hello to future code readers.

>>> --- a/include/uapi/linux/udp.h
>>> +++ b/include/uapi/linux/udp.h
>>> @@ -43,5 +43,6 @@ struct udphdr {
>>>   #define UDP_ENCAP_GTP1U        5 /* 3GPP TS 29.060 */
>>>   #define UDP_ENCAP_RXRPC        6
>>>   #define TCP_ENCAP_ESPINTCP    7 /* Yikes, this is really xfrm encap 
>>> types. */
>>> +#define UDP_ENCAP_OVPNINUDP    8 /* OpenVPN traffic */
>>
>> nit: this specific change does not belong to this specific patch.
> 
> Right. Like for the Kconfig, I wanted to keep "general" changes and 
> things that touch the rest of the kernel in this patch.

Ok. I believe it's not a technical problem to introduce it here. The 
module will be buildable. It's more about facilitating reviewers' life. 
A code, introduced just in time, saves from two kinds of wonderings: (a) 
do we need this at all, when you see an unused definition, and (b) what 
it exactly means, when you see a user two patches after. Anyway, it was 
just a nit pick, and it's up to you how to introduce the module.

--
Sergey

