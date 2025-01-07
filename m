Return-Path: <netdev+bounces-155748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B316A03922
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 08:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B63B33A3308
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 07:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9AB158868;
	Tue,  7 Jan 2025 07:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AxPWcgqD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EF91DDC04
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 07:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736236602; cv=none; b=blS3fDRNjq4fBAu3cK/u//RRvzx+k842mjCMS6/1wt7QJu+R8mEStnuAdloRaP/l1mhEp/bIQpIUfhaT7uN2ScTovqX/BhkoWdmVWT77VU5T5X1GfeljkazfCTaqNH4DTrcTKDrmXvLz0OPOSQLawBc6XF9mGyCnsSQulnY9GOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736236602; c=relaxed/simple;
	bh=Gm75I/Svd9qhS2sVAOt6JjGZXoxfT7jT6fLmGqtBQZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZmexZvCJs1LdRi7R6nmI/hBPtzFp83fcqmZaltwBDitpRIByiE6z+V52shQSgcSRXGD+LAYR7guBkhCo+dVrDyTZEyn+ZG0UWprv/53Id1xbxLZ6D0WujpJhmy48+UPS5Mrj0SVQSO/21J3XbTEKLchEeP1x3Mqn2saPUC1MJrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AxPWcgqD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736236599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vxUnWXJlHQJ/roVMFA6urDaZ/9zjztbdx0/oIIE5jd0=;
	b=AxPWcgqDtUbFfw+MHbR0wNSeu6jL79QgjNb+fJjGwVTOsXVeDndo4biSXQk+NfM3xTONjz
	sgzLUiUVp1gctYKFz6CgWvzsFO9oz+2+k3Ls2+kPmjEEQclsS4SDa+TeG+bflrHJ8XUY/3
	8JUqXWULKW2pkUXZoRUauvXJsRDsdWk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-jioEt20YPiumTITBgDDtGw-1; Tue, 07 Jan 2025 02:56:36 -0500
X-MC-Unique: jioEt20YPiumTITBgDDtGw-1
X-Mimecast-MFC-AGG-ID: jioEt20YPiumTITBgDDtGw
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6d8fe8a0371so254088256d6.1
        for <netdev@vger.kernel.org>; Mon, 06 Jan 2025 23:56:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736236596; x=1736841396;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vxUnWXJlHQJ/roVMFA6urDaZ/9zjztbdx0/oIIE5jd0=;
        b=eypVjBPVV5lKD95v2L134QmFUfF+Z9EiQhMCu30jXiPXuxUkJnmIPZptUjlFW1U3Il
         ZygbmQO8YcD+9YuOfY+//GAhGUav/+zkyiWIaKVHFy1BZ8csKC7Xf86mmoqcx/MyxcTt
         LzYpPbh1b92uF1hI8fN7BaOd/Dw32/+PgNfEEnhO5/CT+ohGe5zb8rFhRVy5TQljoIWA
         0CGTNbLl2xEVx7vJv3JU7j9BEnBrrXg9Msumqnhsai+qa79OLoZj+yBZd6SOcHj24fhx
         WZVotOSLP/djHODk13IfjSaCTloB2wTNPj+Nq2FYcGxG8J9m8KlxfyO3OsjKnXWmE03B
         xF0g==
X-Gm-Message-State: AOJu0YwGOFrGSfMN6h2ERX3klOzzf2cnDCDptkdz11fotcdguEpaSpty
	jN/HQw+6Htop8AdDZvMcTw1ARUcYa7XFctD4ZmaNFYSYAcio00hwElKaYo2huAPwrZM+boInqt9
	Wol+zwH0RxQtBFAtm8sftnlu+lzjdN7XqjypSA3tY63/06ZsFUFEugrOv1vsR3/iu
X-Gm-Gg: ASbGncsK8AjbzomRBbEzSGdRSHN7gWdV6OXn4qKb8G5L1LtYP0F878wU/xqdOkgac5t
	plf1CvA5fM/SO5lTnKQJUbbq5FTT4/VZQmH2T5XlD1UbbwDBe41jcHQxa96XkQCtpPaXNelsO51
	tFnBqbIoFtC8V1VTHg9dZitTXrfG91PTU+roHlgf+XObgLxODUwwkEypDbLQ5OT/F0mIME2K7C4
	9gTT6pGTDHEYCt66LzSCCSLaarn7qpfpmbPw++7MppVdNKqTPzb0tNSCHtYe8NtrNPtO1Z41Hru
	qqt+1A==
X-Received: by 2002:a05:6214:620d:b0:6df:93dc:9161 with SMTP id 6a1803df08f44-6df93dc93a0mr4825036d6.27.1736236595893;
        Mon, 06 Jan 2025 23:56:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGBvL6SKfMkJ7AangzbaQocjlO4piC9sPGGh+xgzOs5v06V9YSkguAQIHO7aRuCW3/B9pG79Q==
X-Received: by 2002:a05:6214:620d:b0:6df:93dc:9161 with SMTP id 6a1803df08f44-6df93dc93a0mr4824876d6.27.1736236595594;
        Mon, 06 Jan 2025 23:56:35 -0800 (PST)
Received: from [192.168.88.253] (146-241-73-5.dyn.eolo.it. [146.241.73.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd35b0c471sm155030606d6.29.2025.01.06.23.56.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 23:56:35 -0800 (PST)
Message-ID: <939fa561-841e-442a-be0b-0e71c6843e5c@redhat.com>
Date: Tue, 7 Jan 2025 08:56:31 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] udp: fix l4 hash after reconnect
To: Philo Lu <lulie@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Fred Chen <fred.cc@alibaba-inc.com>,
 Cambda Zhu <cambda@linux.alibaba.com>, Willem de Bruijn
 <willemb@google.com>, Stefano Brivio <sbrivio@redhat.com>
References: <4761e466ab9f7542c68cdc95f248987d127044d2.1733499715.git.pabeni@redhat.com>
 <CANn89i+aKNhzYKo3H3gx5Uhy4iPQ4p=6WDDF-0brGyR=PzJqjQ@mail.gmail.com>
 <CANn89i+k11E9XeJZwvgZ7VO0yr1nWge8+U-ESw2GLYDq7-sdBw@mail.gmail.com>
 <b46a7757-f311-4656-a114-68381d9856e3@redhat.com>
 <a4085013-daaf-4141-af56-cd438bf8b4c9@linux.alibaba.com>
 <63b0f262-066a-4f7b-b55a-a7f0ed4aa7f4@redhat.com>
 <febf62f6-7439-4628-ad47-041ebbb86ede@linux.alibaba.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <febf62f6-7439-4628-ad47-041ebbb86ede@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

I'm sorry for the latency, I was off in the past days.

On 12/31/24 8:55 AM, Philo Lu wrote:
> On 2024/12/10 16:32, Paolo Abeni wrote:
>> On 12/7/24 03:34, Philo Lu wrote:
>>> On 2024/12/7 00:23, Paolo Abeni wrote:
>>>> On 12/6/24 17:01, Eric Dumazet wrote:
>>>>> BTW, it seems that udp_lib_rehash() does the udp_rehash4()
>>>>> only if the hash2 has changed.
>>>>
>>>> Oh, you are right, that requires a separate fix.
>>>>
>>>> @Philo: could you please have a look at that? basically you need to
>>>> check separately for hash2 and hash4 changes.
>>>
>>> This is a good question. IIUC, the only affected case is when trying to
>>> re-connect another remote address with the same local address
>>
>> AFAICS, there is also another case: when re-connection using a different
>> local addresses with the same l2 hash...
>>
>>> (i.e.,
>>> hash2 unchanged). And this will be handled by udp_lib_hash4(). So in
>>> udp_lib_rehash() I put rehash4() inside hash2 checking, which means a
>>> passive rehash4 following rehash2.
>>
>> ... but even the latter case should be covered from the above.
>>
>>> So I think it's more about the convention for rehash. We can choose the
>>> better one.
>>
>> IIRC a related question raised during code review for the udp L4 hash
>> patches. Perhaps refactoring the code slightly to let udp_rehash()
>> really doing the re-hashing and udp_hash really doing only the hashing
>> could be worth.
>>
> 
> I'm trying to unify rehash() for both hash2 and hash4 in 
> __ip4_datagram_connect, when I noticed the inet_rcv_saddr checking 
> before calling rehash():
> 
> ```
> if (!inet->inet_rcv_saddr) {
> 	inet->inet_rcv_saddr = fl4->saddr;
> 	if (sk->sk_prot->rehash)
> 		sk->sk_prot->rehash(sk);
> }
> ```
> This means inet_rcv_saddr is reset at most once no matter how many times 
> connect() is called. 

... if you make consecutive connect(<dst address>) calls.

 __udp_disconnect() clears saddr, so:

connect(<AF_UNSPEC>); connect(<dst address>);

will yield the expected result

> I'm not sure if this is by-design for some reason? 
> Or can I remove this checking? like:
> 
> --- a/net/ipv4/datagram.c
> +++ b/net/ipv4/datagram.c
> @@ -67,11 +67,9 @@ int __ip4_datagram_connect(struct sock *sk, struct 
> sockaddr *uaddr, int addr_len
>          inet->inet_dport = usin->sin_port;
>          if (!inet->inet_saddr)
>                  inet->inet_saddr = fl4->saddr;
> -       if (!inet->inet_rcv_saddr) {
> -               inet->inet_rcv_saddr = fl4->saddr;
> -               if (sk->sk_prot->rehash)
> -                       sk->sk_prot->rehash(sk);
> -       }
> +       inet->inet_rcv_saddr = fl4->saddr;
> +       if (sk->sk_prot->rehash)
> +               sk->sk_prot->rehash(sk);
>          reuseport_has_conns_set(sk);
>          sk->sk_state = TCP_ESTABLISHED;
>          sk_set_txhash(sk);

This sounds like an unexpected behaviour change which may broke existing
applications.

I suggest retaining the current beheviour.

Thanks,

Paolo


