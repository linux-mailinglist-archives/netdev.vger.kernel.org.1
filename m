Return-Path: <netdev+bounces-78555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2B7875B65
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 01:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 329361C20CCE
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 00:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C565F163;
	Fri,  8 Mar 2024 00:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="e8OlHtfI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D74D179
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 00:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709856480; cv=none; b=A+OZwq9Cw/HLNdjuBmoHqwsOBN+ElLgim3/WMPZo1wQCOAHFVQ/mHXUrSMAXlA3uqaQckQRx3pdVDjGqSPF/gyBomjflHCNGsnP5A94ESzlipJ/gjZ5XvRcMJ4zJSaVioCC9XIbYMOyjeCxz9KB1gca89q6s5u84PfedBhtjMOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709856480; c=relaxed/simple;
	bh=8AkWK/d7GsbY/m6D0pIzblhuCXW01MyOynE+rX8tYJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c0Yrb6SPWJYXnjiAjDYd5oIK2/Tq1k49Hl13T1Lga0KwiaFl+2Awr8ZeH1W9HDORXaa6sMMZjE4yKRIwW47F3h8DpshXpKKN8T8+KSa2Fz0bsKs93gsHY41F7uwfc3KCFzXcTNIEaiIgyYjIumd5DyWoOlnhNZ30ApGpPhVk0rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=e8OlHtfI; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56829f41f81so304363a12.2
        for <netdev@vger.kernel.org>; Thu, 07 Mar 2024 16:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1709856477; x=1710461277; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=W/SgjPb5JtOPtVxFT1xzLEWNZZkMTE1/xZIAtxriWHE=;
        b=e8OlHtfIvbFsWPSF2mF6tNyIcFQAQRmmeycCMNFumUOTNBD1JqBnvMpwv/fI/B0djW
         Gyy2zrV/RHdyRFaNLyvstDf1THcEBBUG9h+8Db0dtvOVAOuf7pBbFYr9WMYF+g3JBVsz
         +3Z30zXRes3SyOFgBFqSmwkhC8K70rmvSU6OtEcSrcOhfh136VuBGAnuxS9JJ94Mmp0A
         cR0gyNshtEDG9DHlC9WUQ/N6XJh+Mf+Q3+tGSaSouhA81yCrSzuRpuymO0q3dPcGcGVR
         HJNbxWkPBoH/CCb8z+2Ednyk7lL7jx0T3d59pNKbd9xGR1y8uHtU9Q0ML6swsayh9r0M
         GgQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709856477; x=1710461277;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/SgjPb5JtOPtVxFT1xzLEWNZZkMTE1/xZIAtxriWHE=;
        b=UT0XGyR0V1cUMdajKc+oQUw4dA+gcIqHQuwcIkSjg/wbwn8TNP+26g6Xz4bgLgz0HC
         mtQjjSt5sFIL/rVhh8W7TRHW+pqQf7LjPbj3/yDovdRMseCySevdUJsBytG+zd4j4/Hd
         WMn0xWKo+SHGx9m8Sjj7DLudYPhgE59FZocsk1gi+6pSJRQydRPG8EvfT7JmrUyhyxVJ
         z11qg/Pfp6d1gKX2kAYiqYCO8XfPvN5M4mLvOygDahn4eRmUauPNS4uHpNQkF8NRKiSy
         JhWTQqs1Bh6WX8IA2SFJzekhUOhMhvmzn1AhThV9jFYQqp/dr5QH3iqN1R3NaqsfT4P7
         jMeQ==
X-Gm-Message-State: AOJu0YyfVJ7XeQ6ZY9kUZFeiU1yM/MVIAd+W7ONU1t0LcSp06l9Pa2fF
	EpB7RVqnfEoUdGUGdV5GTQqoAqpEDkfW1kxurdYquOW7WM0IaP9iWDQQuNsPm4c=
X-Google-Smtp-Source: AGHT+IE9d5yA8OwUV6IiUxWVPpPfG9HDykT0djvDj5kJKvpLOmBoVaZ/KMy50hmOBM17jhMCPwTAmg==
X-Received: by 2002:a17:906:40c7:b0:a45:6ef8:1e3b with SMTP id a7-20020a17090640c700b00a456ef81e3bmr8959258ejk.14.1709856476655;
        Thu, 07 Mar 2024 16:07:56 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:0:460d:9497:9f21:53e7? ([2001:67c:2fbc:0:460d:9497:9f21:53e7])
        by smtp.gmail.com with ESMTPSA id w9-20020a1709064a0900b00a44f0d99d58sm6297382eju.208.2024.03.07.16.07.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 16:07:56 -0800 (PST)
Message-ID: <d896bbd8-2709-4834-a637-f982fc51fc57@openvpn.net>
Date: Fri, 8 Mar 2024 01:08:21 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 04/22] ovpn: add basic interface
 creation/destruction/management routines
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>
References: <20240304150914.11444-1-antonio@openvpn.net>
 <20240304150914.11444-5-antonio@openvpn.net>
 <e89be898-bcbd-41f9-aaae-037e6f88069e@lunn.ch>
 <48188b78-9238-44cc-ab2f-efdddad90066@openvpn.net>
 <540ab521-5dab-44fa-b6b4-2114e376cbfa@lunn.ch>
 <a9341fa0-bca0-4764-b272-9691ad84b9f2@openvpn.net>
 <b3499947-f4b6-4974-9cc4-b2ff98fa20fc@lunn.ch>
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <b3499947-f4b6-4974-9cc4-b2ff98fa20fc@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/03/2024 20:31, Andrew Lunn wrote:
> On Wed, Mar 06, 2024 at 03:49:50PM +0100, Antonio Quartulli wrote:
>> On 05/03/2024 17:27, Andrew Lunn wrote:
>>>>>> +void ovpn_iface_destruct(struct ovpn_struct *ovpn, bool unregister_netdev)
>>>>>> +{
>>>>>> +	ASSERT_RTNL();
>>>>>> +
>>>>>> +	netif_carrier_off(ovpn->dev);
>>>>>
>>>>> You often see virtual devices turn their carrier off in there
>>>>> probe/create function, because it is unclear what state it is in after
>>>>> register_netdevice().
>>>>
>>>> Are you suggesting to turn it off both here and in the create function?
>>>> Or should I remove the invocation above?
>>>
>>> I noticed it in the _destruct function and went back to look at
>>> create. You probably want it in both, unless as part of destruct, you
>>> first disconnect all peers, which should set the carrier to off when
>>> the last peer disconnects?
>>
>> I think keeping the carrier on while no peer is connected is better for
>> OpenVPN.
> 
> I then have to wounder what carrier actually means?
> 
> Some routing protocols will kick off determining routes when the
> carrier goes down. Can you put team/bonding on top of openvpn? If the
> peer has gone, you want team to fall over to the active backup?

IIRC team/bonding requires a L2 interface, but ovpn creates a L3 device.
So I don't think this case applies here.

To be honest we don't have any real concept for the carrier off.
Especially on a server, I hardly believe it would be any useful.

However, on a client or on a p2p link, where there is exactly one remote 
host on the other side, it may make sense to turn the carrier off when 
that remote peer is lost.

There is an extra detail to consider: if the user wants to, the ovpn 
device should remain configured (with all IPs and routes) even if 
openvpn has fully disconnected and it is attempting a reconnection to 
another server. Reason being avoiding data leaks by accidentally 
removing routes to the tunnel (traffic that should go through the tunnel 
would rather go to the local network).

With all this being said, it may make sense to just keep the carrier on 
all time long.

Should we come up with something smarter in the future, we can still 
improve this behaviour.

Regards,

> 
>       Andrew

-- 
Antonio Quartulli
OpenVPN Inc.

