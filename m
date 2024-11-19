Return-Path: <netdev+bounces-146138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A713D9D2166
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 09:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CAB71F217EC
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 08:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617D014F125;
	Tue, 19 Nov 2024 08:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Ro01NaRU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4257A1A28C
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 08:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732004147; cv=none; b=ra5tYbJ0jBuq+WmBIbSlgCuqa2/gydyGJWtFHN78JjKjh8+dKj4thHw7KpFA5q7MAkInbiwV5ujdllhLjXXaUXVF0SO15ofDw04asfsFEMcRctVceszb+a20NWpvoY2q6MxM9XZYGpsvJaH1B6pUFn6wkdz6HnZoFCIaWfWlg6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732004147; c=relaxed/simple;
	bh=nh3qg+dpw6wJugS2b0ETXcerIj6+agTQV21HgtF5r0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EvBoJnxjk+A3TwJq02bG8YmNe7OrgvQxDKazb13cLbP/7ThSgLchETP/O52odI48+LgcH/s9uI5IkBl1+Xtvrd9sh/G3Tq5XFNo6cNYYhwzMS2kITQc9bwjdcrpls/yrsBf0esSMBbND2p38L88uqWRWh9SFLlkZWyz6DgZYGWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Ro01NaRU; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa1e87afd31so408414466b.3
        for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 00:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1732004143; x=1732608943; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Dlb3+qv9gg1JV6Cl4CDNWBpSyFp7lVILgVs8ILCA4eA=;
        b=Ro01NaRUbn91xcHQ78cM0iBrNZ9ea/UBCjrf/vNfO5qLF5Yl28iYAkw9kb0Awln3xx
         XpdRLEza4+gqgeqP1sK1LmBVYgRlzuFE3Jh+/X1A4Yncdoem4g414dGjJRwQrKV1mIpR
         zzl5iPlVUhzIkNDMI6aD+d4kc1qMTJQgkvU2qKmFEWXvQ/OAczitTJb02Hvi0JibgyyD
         pRQRHHqLpyjRx6Upd8p2q6OCQA/Xw5juFo/Err7XvQP0ykbeTYiD3KcfkYAjha3BF8Di
         MVmpVgPmQpUMyxtN+5ucZoYiPJEtr6F45dk/+CK6QFrIQ2A7oLUM2EHXZ2ay2H0OG7LA
         R5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732004143; x=1732608943;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dlb3+qv9gg1JV6Cl4CDNWBpSyFp7lVILgVs8ILCA4eA=;
        b=rrWgLm87CEB5D9vWDNb9NgBlLz6VhIEQTtTbNGNAsY0Z7xjp1yiZh/d8q+tHicMiW7
         gU2jXEhR0Dg2fJG+U09mfWMNubnCKUF1WdB6hTPJmG0GqLkWXiC4NvcldyLtQ80LQmin
         XVs3PJdq79+KQ+JIdA8UxnM+JJLrX8caIDfn5pNx78jmNN599FvcxP4VTMz6jUtkS+EI
         7yYj5rPnLY3b0YzTJ31fuKrICL5N7ktNtdwlmdJUy3n/YeIbpl9vfNQpdhRPrINrIHuT
         nzgLoOjeZkDzZKmALrETL06Rk72q4t0nMixbIjww50DEvurmYpKkOvcB0JYNoEnYuZqm
         FOJQ==
X-Forwarded-Encrypted: i=1; AJvYcCV85HctPnnFmYERYKSawRX04a1EAqkStQPsmbE39CkD3FLW0N6aPvsjJRiOA5RwbPM49ERBljo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvwt+MtBGfCYNMMZHRCM6b+O8x6e7mwRf4Ehc3wr1QeJbVjayc
	6DfoSBbEX+h5GKv/qy9XwrEQwuegNyVjtmRJDMTUBXZO3pHKJyGl4AF7cWZeGHc=
X-Google-Smtp-Source: AGHT+IH1oPLqiWB9nvjMfiow2lsNMatAoaYTZq+VpYZVjDfmiH/yzZPdZ9PNMrDF2+D834C4i02E5A==
X-Received: by 2002:a17:906:6a20:b0:a9e:c267:78c5 with SMTP id a640c23a62f3a-aa483553e28mr1404043466b.55.1732004143604;
        Tue, 19 Nov 2024 00:15:43 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:a2be:8cd5:8845:cfce? ([2001:67c:2fbc:1:a2be:8cd5:8845:cfce])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20dffaa0fsm628382066b.106.2024.11.19.00.15.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 00:15:43 -0800 (PST)
Message-ID: <22d63b13-2c20-4ee7-9783-7b061bd6d942@openvpn.net>
Date: Tue, 19 Nov 2024 09:16:11 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 03/23] ovpn: add basic netlink support
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-3-de4698c73a25@openvpn.net>
 <21c0887b-1c7d-424d-a723-2a8d212cbde1@gmail.com>
 <dc63a3cb-7ace-4aca-9b67-f3c50297b2d2@openvpn.net>
 <b624293b-5143-4602-bf50-f4a14ff83d3a@gmail.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <b624293b-5143-4602-bf50-f4a14ff83d3a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 19/11/2024 03:23, Sergey Ryazanov wrote:
> On 15.11.2024 12:19, Antonio Quartulli wrote:
>> On 09/11/2024 00:31, Sergey Ryazanov wrote:
>>> On 29.10.2024 12:47, Antonio Quartulli wrote:
>>>> +/**
>>>> + * struct ovpn_struct - per ovpn interface state
>>>> + * @dev: the actual netdev representing the tunnel
>>>> + * @dev_tracker: reference tracker for associated dev
>>>> + */
>>>> +struct ovpn_struct {
>>>
>>> There is no standard convention how to entitle such structures, so 
>>> the question is basically of out-of-curiosity class. For me, having a 
>>> sturcuture with name 'struct' is like having no name. Did you 
>>> consider to use such names as ovpn_dev or ovpn_iface? Meaning, using 
>>> a name that gives a clue regarding the scope of the content.
>>
>> Yes, I wanted to switch to ovpn_priv, but  did not care much for the 
>> time being :)
>>
>> I can still do it now in v12.
> 
> This topic caused me the biggest doubts. I don't want to ask to rename 
> everything on the final lap. Just want to share an outside perspective 
> on the structure name. And let you decide is it worth or not.
> 
> And if you ask me, ovpn_priv does not give a clue either. The module is 
> too complex for a vague structure name, even after your great work on 
> clearing its design.

Well, the word "priv" to me resembles the "netdev_priv()" call, so it's 
kinda easier to grasp what this is about.
In batman-adv we used the same suffix and it was well received.
Also, if you grep for "_priv " in drivers/net you will see that this is 
a common pattern.

Since I already had in mind to change this struct name, I moved on and 
renamed it to ovpn_priv throughput the patchset (git rebase --exec is my 
friend ;)).

Thanks

Regards,

> 
> -- 
> Sergey

-- 
Antonio Quartulli
OpenVPN Inc.


