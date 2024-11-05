Return-Path: <netdev+bounces-141908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AF99BCA13
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 11:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 357E4285BEA
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 10:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61FC1D1745;
	Tue,  5 Nov 2024 10:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JyBFB0vX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9A31CF7C9
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 10:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730801529; cv=none; b=bvOMYe+ts8EGbAoluzc841MzFTn3I4S98DeI3UZYxUV0h+1m96kppuvxyKW743bf9AZvXWAvyqpGVEqzQhWdJaL8HEfe0qPF6WG/7K9H3cr0mmF1+aWZeoa2c4rZMIFmGJmxcjaqNVIYPfzm0BJPPJEkNyhwto+x0FdTc64amew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730801529; c=relaxed/simple;
	bh=cpt71/bLiOiqE1gF+TeDOwmJxM+T2IyKU2AVh4tkDGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hvczdeCkVnUX+4Hu5e91igtCJWNd+eXkWufvNVWSSXLAwSUO8u/T7dz3pJTE38CotzXtqQLZ81TypPnHSS4aQV46X749dkqkGWujsiouHz9GzJw5oyR5nNoHWqHcJQ25Twm6ZJbeKnAfIizlvsMcddatomdZ0CuyQqJt2Qrn7K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JyBFB0vX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730801527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HQnkdcY7feykH+birl/6TXwo5UC0vkcvq+DsAIFByQs=;
	b=JyBFB0vXauEMK/sCysnG39QALffE/8sLrPUabz/vkgFw6St5ZqwNr7pzxWZ72I1EwML+7i
	Ra3IHzbY+D7AUmtILpd3ONu3o+hODuY02K2zMg1lwwhmrbLAYgRmq9ORvsPDakb65mYsY2
	ei+3Eq7UbPTakExLNNSdfADCzjqrWls=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-yJQFqbJCO4yF3Cm4JtN0lw-1; Tue, 05 Nov 2024 05:12:05 -0500
X-MC-Unique: yJQFqbJCO4yF3Cm4JtN0lw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43151e4ef43so37184335e9.3
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 02:12:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730801524; x=1731406324;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HQnkdcY7feykH+birl/6TXwo5UC0vkcvq+DsAIFByQs=;
        b=fFaMoT4xxtwkRJkmtQ25+17p0umbaqmXoo1l5ZmxYqe+9Nh9E0IRwNjvhYQ+jxT+5h
         f0S/HcrU1tihUElbKwqPLohUIA12vQUNbbVZKSPIFS+CeUDGqQvZGqJzENb7j7inatUB
         jQ2jBPDpYxeQk/Q+iB4CgElUTPtPdf06FkzJ6AdV1TGN80/7ZlMTC7GPn2F5j5i4/94z
         jN6hgiCs5ziG8KSB36++7ife/anUlGbzXXPTkspsxlwDkwO4D8CF6A/FyAs4sYyBVFR0
         hD0h3IxwZMVt+S7lvqdSlUnhGkTfKWJFnl3T8xgUnaXbSMQ8g2RT6Dp4Po9XkjQ0dk7C
         ABcQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8t1ksOTABiEwLZvt+BcmUwnM1Nc31XVjDcSS381WwayOibkt3bGLjmI7Ay+f4TPaXGY+rjYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgQMCHMwvjgBE8sfjeL63MAwkg4jTpSmX/RvSweLkjziEaI+MT
	M3LZMnEFwO3d2HpdQ+GiY0GKbiL0novLRh/LP63Msi0kYGOLLtXVpqXdbG9o0jm9BcGwpU22JBU
	75PVbJrpQF/YBItjdGgunGtMi2y0Uq+eoQLsjuCu3k2N1WiK0xibFSw==
X-Received: by 2002:a05:600c:1d05:b0:431:60ec:7a96 with SMTP id 5b1f17b1804b1-4327b7eaa40mr175935495e9.25.1730801523779;
        Tue, 05 Nov 2024 02:12:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYPIxWbQIwoksDNGfnE1zJyrPy8WQrcllrbh3+7Y8qknj0tDs4mk/zu6RQVNrWfgm4vmRYsA==
X-Received: by 2002:a05:600c:1d05:b0:431:60ec:7a96 with SMTP id 5b1f17b1804b1-4327b7eaa40mr175935105e9.25.1730801523335;
        Tue, 05 Nov 2024 02:12:03 -0800 (PST)
Received: from [192.168.88.24] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c116b181sm15548637f8f.107.2024.11.05.02.12.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 02:12:02 -0800 (PST)
Message-ID: <959af10c-8d51-4bc5-9a85-ec00ad74994d@redhat.com>
Date: Tue, 5 Nov 2024 11:12:01 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/8] net: Shift responsibility for FDB
 notifications to drivers
To: Petr Machata <petrm@nvidia.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
 Amit Cohen <amcohen@nvidia.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Andy Roulin <aroulin@nvidia.com>, mlxsw@nvidia.com
References: <cover.1729786087.git.petrm@nvidia.com>
 <20241029121807.1a00ae7d@kernel.org> <87ldxzky77.fsf@nvidia.com>
 <7426480f-6443-497f-8d37-b11f8f22069e@redhat.com> <874j4mknkv.fsf@nvidia.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <874j4mknkv.fsf@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/24 10:45, Petr Machata wrote:
> Paolo Abeni <pabeni@redhat.com> writes:
>> On 11/4/24 12:43, Petr Machata wrote:
>>> Jakub Kicinski <kuba@kernel.org> writes:
>>>> On Thu, 24 Oct 2024 18:57:35 +0200 Petr Machata wrote:
>>>>> Besides this approach, we considered just passing a boolean back from the
>>>>> driver, which would indicate whether the notification was done. But the
>>>>> approach presented here seems cleaner.
>>>>
>>>> Oops, I missed the v2, same question:
>>>>
>>>>   What about adding a bit to the ops struct to indicate that 
>>>>   the driver will generate the notification? Seems smaller in 
>>>>   terms of LoC and shifts the responsibility of doing extra
>>>>   work towards more complex users.
>>>>
>>>> https://lore.kernel.org/all/20241029121619.1a710601@kernel.org/
>>>
>>> Sorry for only responding now, I was out of office last week.
>>>
>>> The reason I went with outright responsibility shift is that the
>>> alternatives are more complex.
>>>
>>> For the flag in particular, first there's no place to set the flag
>>> currently, we'd need a field in struct net_device_ops. But mainly, then
>>> you have a code that needs to corrently handle both states of the flag,
>>> and new-style drivers need to remember to set the flag, which is done in
>>> a different place from the fdb_add/del themselves. It might be fewer
>>> LOCs, but it's a harder to understand system.
>>>
>>> Responsibility shift is easy. "Thou shalt notify." Done, easy to
>>> understand, easy to document. When cut'n'pasting, you won't miss it.
>>>
>>> Let me know what you think.
>>
>> I think that keeping as much action/responsibilities as possible in the
>> core code is in general a better option - at very least to avoid
>> duplicate code.
>>
>> I don't think that the C&P is a very good argument, as I would argue
>> against C&P without understanding of the underlying code. Still I agree
>> that keeping all the relevant info together is better, and a separate
>> flag would be not so straight-forward.
>>
>> What about using the return value of fbd_add/fdb_del to tell the core
>> that the driver did the notification? a positive value means 'already
>> notified', a negative one error, zero 'please notify.
> 
> That would work.
> 
> How about passing an explicit bool* argument for the callee to set? I'm
> suspicious of these one-off errno protocols. Most of the time the return
> value is an errno, these aberrations feel easy to miss.

I would be ok with that - a large arguments list should not be something
concerning for the control path. Just to be clear: the caller init the
bool to false, only the callees doing the notification set it, right?

Thanks!

Paolo


