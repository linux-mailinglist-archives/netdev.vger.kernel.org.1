Return-Path: <netdev+bounces-167429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1DCA3A3E9
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 18:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40A8F3AAB3B
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 17:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B57B26F443;
	Tue, 18 Feb 2025 17:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eepZ5Mzi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF1324113C
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 17:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739898996; cv=none; b=fiaKcNu1InedHzYpJUAIS+3wybeA7XJY3X+uNwTjaa4gdt+WrYwhpqXyHGpV5WQH+QGR7h8MpStQOmRroonOpmmsWAgSR2HH+2ZfizAzg/GqP24r0h+/YAvc4y5vLaz5a7isPTnr9xH2bJprJ8ITsSwMv2qY9URPHdzaZJnJUO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739898996; c=relaxed/simple;
	bh=9dIIdFQgmysnp5dqxXCZNDzCI2/9ZCDa1aTFsYRVot4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=dvwvkKD/d9DwRc4d4yrrmFilnfHZfeGZOUIS2JWcxjWEw5JGG3clX176Aata1I5IqiPTtMdt8dEkhzVuC/L1ZTfak0pQKi8Nlxp3z4SMfic7dJfDzOHJU96hizXVnPh8yoORD0mfv0lynRL0Em+hstZJmA5r+ecmkxqTEhM7eZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eepZ5Mzi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739898993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p6QQXdqzTnem+UBcwWG6Cta9dSxQF1jtODmeDWvwxLw=;
	b=eepZ5MziuClZjM5x85xO+XQiS99bjfIEzxx4yslEL0xT1V7K75mlGeBr3YwgnUMN8tSIY6
	X4SkncPZMqLZId5GWRnFz+jFKbicmhgiIpkfesy5QzCrPGh8mcOOdUkh/qm43PDycOHcqy
	bv9sBFfA+BPu0aVDJDqiCrCeooPa3jg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-0CJ3LZyBNvWLjhrgtIqkfA-1; Tue, 18 Feb 2025 12:16:31 -0500
X-MC-Unique: 0CJ3LZyBNvWLjhrgtIqkfA-1
X-Mimecast-MFC-AGG-ID: 0CJ3LZyBNvWLjhrgtIqkfA_1739898990
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4398e841963so10665775e9.3
        for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 09:16:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739898990; x=1740503790;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p6QQXdqzTnem+UBcwWG6Cta9dSxQF1jtODmeDWvwxLw=;
        b=TuKI7acJv6ClqhPXAwn7N6viEzWxvxjSogRUVnzLLMOQDfKj2jMQ5uPz+nBuiqSSfN
         ng0+MPuwUhkm/EM1CeHtvSE8Q99JoVPme6RA5JkbpbtgqPmqvk/YPwZ981HFkqrNumcs
         NShaUQhdr9PN6KqJ4pvlqcnjFrwXV8fZIeb1h9FA5UI/06peDIMLPvkeSStdVoTNRIbN
         zYpnC2Pxxxj9VmquCmx8krhjNL7/etibl7latE9Q73Mq4qrO8mclLxq3sZOP7rKt4KoP
         emCEIzz3DH9cgYIo5okLJ5on4l8jErL+2EEIg6HdNDx5/XdfWqikBgFVzHd4yEn4UgqC
         b0fQ==
X-Gm-Message-State: AOJu0YwI6UpuZFADb6vkmlB35MmcUC79vkY2TyAOI/Ab/jE6+tDaxqnW
	bdrMOOdemvOBAglEeTMJYCT3z2JWGyJTGm3UmAVa76GlGYakOXj2/+QtTh79+ctQJPGNH4OfeqY
	aoH2hAdHFaknN++G4oJGIRfHTW9zO9HHwnkLoAIEKBRISRvt3c2w57g==
X-Gm-Gg: ASbGncstK8NcWpMaMLFEqdAX1MHPeDhHg2/OXdA3fck6eJmGkyT7z/nkUlYsqL6FZ2P
	KjT79Vmm4Vv4e2INsETYlbICGloApuowVmUkGrbPY7lM/SSJv1nwJCk42ui2+NPTIJJZy5xr4D6
	Ca2lBcfkZW5GqsLYuLsIljYlB8dqDkepCIFkmdrUZjBDbq1PTtxCFfquuV4GZvjD5siaziQHBfW
	KW/6ksHd9HCKp6MSB8po1NkU3PGJd5NFzi8FziImYMVg13VR+VVxybw4F5Au+9m+dwtFoFgb9Tv
	hta0CA4kfqnGZVRSl6Fj5KmIzKHG8vUs3+4=
X-Received: by 2002:a05:600c:4e8c:b0:439:99e6:2ab with SMTP id 5b1f17b1804b1-43999e60444mr3983465e9.28.1739898990492;
        Tue, 18 Feb 2025 09:16:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBNYQl/sWuYrb8KfZHgyvvRIWCctaAlN/OMIdNckSEKQleSM880AHK5Jh9HukV3sX6BA4xCw==
X-Received: by 2002:a05:600c:4e8c:b0:439:99e6:2ab with SMTP id 5b1f17b1804b1-43999e60444mr3983115e9.28.1739898990175;
        Tue, 18 Feb 2025 09:16:30 -0800 (PST)
Received: from [192.168.88.253] (146-241-89-107.dyn.eolo.it. [146.241.89.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4399600257asm19958835e9.4.2025.02.18.09.16.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 09:16:29 -0800 (PST)
Message-ID: <2f3b3cef-e623-4c02-af71-9d1f861075d1@redhat.com>
Date: Tue, 18 Feb 2025 18:16:28 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: allow small head cache usage with large
 MAX_SKB_FRAGS values
From: Paolo Abeni <pabeni@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Sabrina Dubroca <sd@queasysnail.net>
References: <6bf54579233038bc0e76056c5ea459872ce362ab.1739375933.git.pabeni@redhat.com>
 <CANn89iJfiNZi5b-b-FqVP8VOwahx6tnp3_K3AGX3YUwpbe+9yQ@mail.gmail.com>
 <41482213-e600-4024-9ca7-a085ac50f2db@redhat.com>
 <CANn89iLbe2fpLUvMJk-0Keaz1yvWb7WUe9X-3Gd5wmNQn7DN9w@mail.gmail.com>
 <389ee8e5-8c25-414c-ae19-7dfeebecf1d3@redhat.com>
Content-Language: en-US
In-Reply-To: <389ee8e5-8c25-414c-ae19-7dfeebecf1d3@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/18/25 3:50 PM, Paolo Abeni wrote:
> On 2/18/25 2:43 PM, Eric Dumazet wrote:
>> On Mon, Feb 17, 2025 at 3:48 PM Paolo Abeni <pabeni@redhat.com> wrote:
>>>
>>> On 2/12/25 9:47 PM, Eric Dumazet wrote:
>>>> diff --git a/include/net/tcp.h b/include/net/tcp.h
>>>> index 5b2b04835688f65daa25ca208e29775326520e1e..a14ab14c14f1bd6275ab2d1d93bf230b6be14f49
>>>> 100644
>>>> --- a/include/net/tcp.h
>>>> +++ b/include/net/tcp.h
>>>> @@ -56,7 +56,11 @@ DECLARE_PER_CPU(u32, tcp_tw_isn);
>>>>
>>>>  void tcp_time_wait(struct sock *sk, int state, int timeo);
>>>>
>>>> -#define MAX_TCP_HEADER L1_CACHE_ALIGN(128 + MAX_HEADER)
>>>> +#define MAX_TCP_HEADER L1_CACHE_ALIGN(64 + MAX_HEADER)
>>>
>>> I'm sorry for the latency following-up here, I really want to avoid
>>> another fiasco.
>>>
>>> If I read correctly, you see the warning on top of my patch because you
>>> have the above chunk in your local tree, am I correct?
>>
>> Not at all, simply using upstream trees, perhaps a different .config
>> than yours ?
> 
> Could you please share the conf, if you have that still handy?

Please ignore, the needed config is actually quite obvious. I did not
take in account that my running config here had a few common options
stripped down.

Cheers,

Paolo


