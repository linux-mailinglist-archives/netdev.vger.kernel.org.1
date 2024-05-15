Return-Path: <netdev+bounces-96636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC96B8C6CEA
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 21:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E81471C20946
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 19:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140B615AADA;
	Wed, 15 May 2024 19:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="WBLaOi1q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94653BBEA
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 19:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715802208; cv=none; b=moezkHtME/ztmGV2G2QouLgjktHLFZ/z3rwiPzIuFqTVUeF4Lttox3f6Eb24MTgIyx2xrW285WdQERVVk7HVaCvkaGSlguAXJrK1yC+Dj/f2eeKmzdxVntP2lAFeNo0RVyQqh53mTh/Envg9t1isLzUDTvfL2eINRbYa6nQvR78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715802208; c=relaxed/simple;
	bh=Q9qMP7KkXZ/ERRR/5oQpf4r0fmpY5OoazQUJUJbOJi8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M+kk3IIIbt9ebo6+q/q/h0/BfYtvIsIug4p3WGgKb2rWedhYC8pm59kkiY+sC0J+QF/bBWirbXvAahnvUVFCf1ErVLMz3jvQ9tGYArVtxxYOtlBnuOFzjhrbVj/cgL24s+UsyeWrNubazyV4RUpfGuy54FzbDVhmYoPoFzl2BBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=WBLaOi1q; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-420180b58c3so26334835e9.2
        for <netdev@vger.kernel.org>; Wed, 15 May 2024 12:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1715802204; x=1716407004; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CYVJn1CbukbBP+sll8hPst8R1OuEdHutO8ePyBD/L0M=;
        b=WBLaOi1q1p0MZgdVF0/RPhNY5ZR5Kmvd0lm5IHRHBg7YtWhlJAZwGa2hmqEi5Dpcs3
         Z3FgyRN/qrWGBkWKgG6We+8Nm0QztoZGtWlYpihNf+9ZeuAxTYKE23yC+rYJDNEDLkaU
         H8az60TvYypszulrNxKV1Q/kDlMvpjAv6YYWpyZ2GFJpmviVCknATrlt9qnTwxg0bktN
         tNiPn/n6ZlfE0T4zpvC6fNY04MW7rG31uBNaNzVpIWzlL7lU6NonlRXIUkfHKR0d+xeG
         EWwj5ekKuzJI6YcruHdYYrMdbCKv6M1NanUpPOtbNoYpJzGlZCrvNLPYYpJk40J6AcEX
         WDrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715802204; x=1716407004;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CYVJn1CbukbBP+sll8hPst8R1OuEdHutO8ePyBD/L0M=;
        b=nTobgJM3uc+laDpskXmyrWkxJCAz61dRF136YQ76100XdAyoOSSSfxTR+uUn+LfoOZ
         13ultWyhjCGlOxvC3GhZ43YtPmFiQBib2juIQldUAu2AEGsi3YvpBnx1fmYBNKYUr51o
         gpsXotywUPMWf+7nKYStrOoKcWDUjFK9yqr5tWx7AIYLQZAu8cxkxvmdGh4hWUQcyCIk
         TOfPo/8kUQji/0WruyCBWI7imGTlyORK53ZZshnEXr/rurEdQ5SR14NU/+NvhRW7trh7
         LrrONTdLa2c2kxMNJ1c6KQJD+r/jihkjE2jw5gUtIo9wr9j6Ijbf4XoBcT1yonLhx6nV
         KjwQ==
X-Gm-Message-State: AOJu0YzSm1TM6VRodwTHM9UaWYIlAqWEdWxD9WEM1cLg+s3TaGUQoOIL
	BrBB1VB6ooUUM3T8LEu0I05W3PVElaB3eSDeUw5CZXfPAMdqYxlcVs/EniD+1nb7lffi8MOGyFP
	9
X-Google-Smtp-Source: AGHT+IFOR7oXXwZ+6AkPeZ0TBf5uovGy5cXJjaiK4yzpzwGVMQ13M70uwb7exoklhcL8xudhP6HmBQ==
X-Received: by 2002:a05:600c:310d:b0:41a:e995:b915 with SMTP id 5b1f17b1804b1-41fea92873amr107318445e9.1.1715802204124;
        Wed, 15 May 2024 12:43:24 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:0:1ebc:be00:b4c3:bcf2? ([2001:67c:2fbc:0:1ebc:be00:b4c3:bcf2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccee92bcsm242824185e9.36.2024.05.15.12.43.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 12:43:23 -0700 (PDT)
Message-ID: <7a3909c1-818d-4701-b3b3-012976db7a34@openvpn.net>
Date: Wed, 15 May 2024 21:44:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 13/24] ovpn: implement TCP transport
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
 Esben Haabendal <esben@geanix.com>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-14-antonio@openvpn.net> <ZkIosadLULByXFKc@hog>
 <73433bdf-763b-4023-8cb9-ffd9487744e0@openvpn.net> <ZkMnpy3_T8YO3eHD@hog>
 <2ddf759d-378f-475c-8fc1-30c6e83c2d14@openvpn.net> <ZkSMPeSSS4VZxHrf@hog>
 <6de315a7-8ef1-4b5d-8adc-fcfae26f6f88@openvpn.net> <ZkTM9b8oU8Rw31Qp@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <ZkTM9b8oU8Rw31Qp@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/05/2024 16:55, Sabrina Dubroca wrote:
> 2024-05-15, 14:54:49 +0200, Antonio Quartulli wrote:
>> On 15/05/2024 12:19, Sabrina Dubroca wrote:
>>> 2024-05-15, 00:11:28 +0200, Antonio Quartulli wrote:
>>>> On 14/05/2024 10:58, Sabrina Dubroca wrote:
>>>>>>> The UDP code differentiates "socket already owned by this interface"
>>>>>>> from "already taken by other user". That doesn't apply to TCP?
>>>>>>
>>>>>> This makes me wonder: how safe it is to interpret the user data as an object
>>>>>> of type ovpn_socket?
>>>>>>
>>>>>> When we find the user data already assigned, we don't know what was really
>>>>>> stored in there, right?
>>>>>> Technically this socket could have gone through another module which
>>>>>> assigned its own state.
>>>>>>
>>>>>> Therefore I think that what UDP does [ dereferencing ((struct ovpn_socket
>>>>>> *)user_data)->ovpn ] is probably not safe. Would you agree?
>>>>>
>>>>> Hmmm, yeah, I think you're right. If you checked encap_type ==
>>>>> UDP_ENCAP_OVPNINUDP before (sk_prot for TCP), then you'd know it's
>>>>> really your data. Basically call ovpn_from_udp_sock during attach if
>>>>> you want to check something beyond EBUSY.
>>>>
>>>> right. Maybe we can leave with simply reporting EBUSY and be done with it,
>>>> without adding extra checks and what not.
>>>
>>> I don't know. What was the reason for the EALREADY handling in udp.c
>>> and the corresponding refcount increase in ovpn_socket_new?
>>
>> it's just me that likes to be verbose when doing error reporting.
> 
> With the "already owned by this interface" message? Sure, I get that.
> 
>> But eventually the exact error is ignored and we release the reference. From
>> netlink.c:
>>
>> 342                 peer->sock = ovpn_socket_new(sock, peer);
>> 343                 if (IS_ERR(peer->sock)) {
>> 344                         sockfd_put(sock);
>> 345                         peer->sock = NULL;
>> 346                         ret = -ENOTSOCK;
>>
>> so no added value in distinguishing the two cases.
> 
> But ovpn_socket_new currently turns EALREADY into a valid result, so
> we won't go through the error hanadling here. That's the part I'm
> unclear about.

you're right. I had forgotten a little but important detail.

With UDP OpenVPN creates one socket and uses it for all peers.
With TCP we forcefully need one socket per client.

Consequently, when a UDP socket is found to be used by our own instance, 
  we can happily increase the refcounter and use it as if it was free 
(we are just attaching it to yet another peer).

In TCP this is not possible, so the socket must be unused, otherwise we 
can't attach it.

I hope it makes sense.

> 

-- 
Antonio Quartulli
OpenVPN Inc.

