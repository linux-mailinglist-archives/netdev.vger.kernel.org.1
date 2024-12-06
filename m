Return-Path: <netdev+bounces-149747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0AB9E7299
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 16:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A787A1887E79
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 15:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D77206F0F;
	Fri,  6 Dec 2024 15:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LD6SH0a9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E921FCCE5
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 15:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733497830; cv=none; b=qXyl9RJDjJDYMjj3A4gxq/i2KHa2PMen6IV3rxhdoXQEGIK0mQsWPE2cwxFhguGgp7MhuuAtn8o8funAGTYQzKtg4N21xeDfgkZ2ywDf2ADRJ1lDKebLCw7NkFlQhLOo6toUgOMGmEPAcpBBCrnxwqKfxnZIotjI7BmgKvC3fHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733497830; c=relaxed/simple;
	bh=FAlnjciA5uKVBIQ22gTJTlVV2i/VlTdSjVq2J5wf1z8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hgjHYzHq/gHbjzeGohHK6rGEEoaO7YRVBcOEh933QusjGvDvCOKkLvspFb6xnEtp10XJSpi3JGflkE23YyfArJuEDbFJCZQPUXRziajKw9zvpDi0MtWLue9H2C7KRauCweiYMP9FRQQ5dH10OF4wWOFZlc+t1slfV2Rk6rpZK/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LD6SH0a9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733497826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zB/eFC62fRkcq2Dvz4UyvSknu6AJwZi0HQ9wWUzjC0M=;
	b=LD6SH0a9i4CJ07dmVYwCXg8gd8fJHvn0jfB+KamSmy3dFHiSIGjhzJbqxaO+a8RRidN4Db
	9bvxx0piBtmsr9v0BXggFkotfCyPLsg6aIZ1FdmZ2NjAfPMJsWq3r/AXTA4vo8mY3Vwcr+
	vaPw4m3sE2z/fppXtUXJgZTfvNDRW70=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-8K3HJa3WPzOUOBoZIrGHww-1; Fri, 06 Dec 2024 10:10:23 -0500
X-MC-Unique: 8K3HJa3WPzOUOBoZIrGHww-1
X-Mimecast-MFC-AGG-ID: 8K3HJa3WPzOUOBoZIrGHww
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4667c1c3181so28765151cf.0
        for <netdev@vger.kernel.org>; Fri, 06 Dec 2024 07:10:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733497823; x=1734102623;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zB/eFC62fRkcq2Dvz4UyvSknu6AJwZi0HQ9wWUzjC0M=;
        b=fAM83fbm8iC0zcWE+evgWLdkBG6gKt0wCy0Fa9wkoN6yJx8A/4TADqEWrlji1s94nS
         Z4wBXZYeVEKR3mWc+hrxUP+8rbe7dT/chRhSgz85uYDeGTQaDXEVNeklvvYp9LjnaZu+
         n/zabAG0p1V1/ljWERVw93X7kBsOSl0xkCaAYse5k2mggUeDk5A3HS+6RTE68oVSjSEI
         LKYM6NMQ860fG798w9gPeQbohyJLdtNgnlTsr3NxkKW3Pb8IEsWs4TP1JSVuNBuNO17S
         t6v9w54PaRitlOAQTWX61NB3PL2ONoUPdNcVA6UPLkf2BMjmSKjTChw6QCX+OLA17pxz
         5qPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFwWv2JR4fmL9HGovaOgc+KbtkuUMe4Y2vpJkt0ZW+MfAolLBzI6MVNYDxAHv0yGAE51UCx6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUvg0sPqhAw7BmG6qXqXPWaXVXUOa3xNrR0ODCb62PX7lalxOl
	CiN5Kh3VmTYWr5UWK8f490lfcsskscccqDjYlLuPgjL/CckTH1dCJkzzpZc2G8s+n2V6YyNmfmc
	iu/Zmpd/jInHBfG8Jhrjeh4f3ZpbHMRixR85BDJWv/+x1toonmIxlKw==
X-Gm-Gg: ASbGncuM4ZdpjcHr8T0Rdpu1ijION7hr1ewcuCImtdokMnAgBCREzO+d78jGJb6arJD
	C5D2nzo6dUbvwEFw82iuwqS1N+VhIzXXhym4PFmpQZZ4S4fOXCAUzLlOxBcOmRmOLfw96+vVWvZ
	qgsgilsYpafpMdKkRp/Oik4ej9q+Sel11HibcOrTUthbx4uSPOKb1lyVAwtcDVgq9TOw47XT4Kf
	dwERJRnsSRAnCZfgrTMbn8yuJH9jzFKjZSQUmXU0vl/FwxvlNrPNs9ivnJOfHXs/H2iz4vr+PrY
X-Received: by 2002:ac8:58d4:0:b0:466:9388:84d2 with SMTP id d75a77b69052e-46734cf3cd6mr56279171cf.17.1733497822774;
        Fri, 06 Dec 2024 07:10:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGvgOF7eK+g13iPjq1+BOSx/DodbbIw5Qxr9M7awmxXuryNjCTDROxPsHW2cgAv1U0jb7Z0BQ==
X-Received: by 2002:ac8:58d4:0:b0:466:9388:84d2 with SMTP id d75a77b69052e-46734cf3cd6mr56278701cf.17.1733497822430;
        Fri, 06 Dec 2024 07:10:22 -0800 (PST)
Received: from [192.168.88.24] (146-241-38-31.dyn.eolo.it. [146.241.38.31])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467296cb98csm21713411cf.30.2024.12.06.07.10.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 07:10:21 -0800 (PST)
Message-ID: <857fae8c-d0cd-4c9d-bfd0-881af9e77b0f@redhat.com>
Date: Fri, 6 Dec 2024 16:10:18 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] datagram, udp: Set local address and rehash
 socket atomically against lookup
To: Stefano Brivio <sbrivio@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Mike Manning <mvrmanning@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Paul Holzinger <pholzing@redhat.com>, Philo Lu <lulie@linux.alibaba.com>,
 Cambda Zhu <cambda@linux.alibaba.com>, Fred Chen <fred.cc@alibaba-inc.com>,
 Yubing Qiu <yubing.qiuyubing@alibaba-inc.com>
References: <20241204221254.3537932-1-sbrivio@redhat.com>
 <20241204221254.3537932-3-sbrivio@redhat.com>
 <fa941e0d-2359-4d06-8e61-de40b3d570cb@redhat.com>
 <20241205165830.64da6fd7@elisabeth>
 <c1601a03-0643-41ec-a91c-4eac5d26e693@redhat.com>
 <20241206115042.4e98ff8b@elisabeth>
 <e02911ae-3561-48be-af92-c3580091015f@redhat.com>
 <20241206143535.3e095320@elisabeth>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241206143535.3e095320@elisabeth>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/6/24 14:35, Stefano Brivio wrote:
> On Fri, 6 Dec 2024 13:36:47 +0100
> Paolo Abeni <pabeni@redhat.com> wrote:
> 
>> On 12/6/24 11:50, Stefano Brivio wrote:
>>> On Thu, 5 Dec 2024 17:53:33 +0100 Paolo Abeni <pabeni@redhat.com> wrote:  
>>>> I'm wondering if the issue could be solved (almost) entirely in the
>>>> rehash callback?!? if the rehash happens on connect and the the socket
>>>> does not have hash4 yet (it's not a reconnect) do the l4 hashing before
>>>> everything else.  
>>>
>>> So, yes, that's actually the first thing I tried: do the hashing (any
>>> hash) before setting the address (I guess that's what you mean by
>>> "everything else").
>>>
>>> If you take this series, and drop the changes in __udp4_lib_lookup(), I
>>> guess that would match what you suggest.  
>>
>> I mean something slightly different. Just to explain the idea something
>> alike the following (completely untested):
>>
>> ---
>> diff --git a/net/ipv4/datagram.c b/net/ipv4/datagram.c
>> index cc6d0bd7b0a9..e9cc6edbcdc6 100644
>> --- a/net/ipv4/datagram.c
>> +++ b/net/ipv4/datagram.c
>> @@ -61,6 +61,10 @@ int __ip4_datagram_connect(struct sock *sk, struct
>> sockaddr *uaddr, int addr_len
>>  		err = -EACCES;
>>  		goto out;
>>  	}
>> +
>> +	sk->sk_state = TCP_ESTABLISHED;
>> +	inet->inet_daddr = fl4->daddr;
>> +	inet->inet_dport = usin->sin_port;
>>  	if (!inet->inet_saddr)
>>  		inet->inet_saddr = fl4->saddr;	/* Update source address */
>>  	if (!inet->inet_rcv_saddr) {
>> @@ -68,10 +72,7 @@ int __ip4_datagram_connect(struct sock *sk, struct
>> sockaddr *uaddr, int addr_len
>>  		if (sk->sk_prot->rehash)
>>  			sk->sk_prot->rehash(sk);
>>  	}
>> -	inet->inet_daddr = fl4->daddr;
>> -	inet->inet_dport = usin->sin_port;

Side note: I think that moving the initialization of the above fields
before the rehash is separate fix - otherwise reconnect will screw hash4.

I'll submit just that (sub) chunk separately.

Cheers,

Paolo


