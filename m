Return-Path: <netdev+bounces-191925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6C0ABDE68
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 17:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53A6A3A44B4
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 15:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76402512CA;
	Tue, 20 May 2025 15:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JD2jMFIC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C688C250C18;
	Tue, 20 May 2025 15:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747753771; cv=none; b=ja1mv0IE5FuYKuf0HkK2myiEswJ0ER3zGKup7QHDqY+c1ZikaRX3BDnT9lLa6JDsge1vzLc+1Wfex7t4zl68GnIuXEWUsEkDu7QPIXu1SWIpmsFnJtBZFE0H0wZaixjKjj/632M6pwUq29u+9Pl/tNBcCL6OFePE5tYoVodXO+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747753771; c=relaxed/simple;
	bh=LxISO3z6KWXiemomrWzTw2ALScLyGRqLuUgSVlA0vWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dBtSmBxB9/zkYiV4ktFvP0+jsYTnsm0R1LGYqr97yfLzWtu9MA9J0lDdA+ZJRGPde1Q02LMHNVPRiwjoANd2XXdmPdw8e1HqdqV+wkgPZk0KGbIKO596N14x26MSBO41b8I6nWAjbNY/ZPFIO+WzRsvCrVBzwgc7bETv4Kq9K3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JD2jMFIC; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ad574992fcaso396149566b.1;
        Tue, 20 May 2025 08:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747753765; x=1748358565; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K4fg7CBjj81Y+lIyXwgfxY20nHUQb0kdLesg6+u2b6k=;
        b=JD2jMFICf9U0zXaOo09Kp3hB9E5oQ3RE26q2mRTF0Yd4HzdP05HQ0abpdg9ZcudPYM
         gMPim2t/DIgACqLHdeukSPUY9aibTfVG8FEngv1/1Owd07B334QUJpyFEYkOcPkAINp5
         XadJAduV/yk4YF4FZY4gyOavwqYcgu3Pwz/jJmVq5s9hxNWILZaNYb0WHsu+nKdZh1vQ
         ZeDmLFkCJ7AAgBdnejUFbuVjVE74KVgVr0pAvl6AxjvgMA1qyiGoHDVBMOn6HjGSoyQ5
         etFNOMDjHY/2MQ7ISFlfd2ujFyMHztp1kMotljbjp0bPyESkDLL8UUR6Egn0eJwPdNSh
         s2Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747753765; x=1748358565;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K4fg7CBjj81Y+lIyXwgfxY20nHUQb0kdLesg6+u2b6k=;
        b=RzcwhJwX9JeV9dOnWsFvszkJRqPHD+Y1Tf96UY4cNigJuCoan0WEBcXQBuu3HadZBH
         AljGyH+lioZpeVAYs5B2tEYtmwOdD1H+H8tKm9XXOnBXCe58CZ95VTHeY9M5ZFY/3OKv
         6RQMNzvSW4+dW1+JNzQ4LHfPdCqlEZMiXXas7AtyZGCObQPtADepgkWy2a3iR7FwiB0d
         29fTB5tLkqkX7zXSMlc/EW3fWRTDflhqNHQQE9a/PZeoXaHDs8YfM1fC8jGolYSrMlNP
         6GUhK4qJpkWiEOZ24pNXlMQjmUB0ngdx0+IGx4dDroA0H+Q13vmT9FKygFsJ2O7++sip
         RokQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9m5UmdAOw6ajaTHlzuS6ZxtKnw6tiPs77wAuFgMeU7JBmRQUWaLUtXVchfgvA8iNk+SNXD2JAhW8e2aQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7+pho7F/GD/hLoRkoWJ/Gc+rCSDhopKj4iwC7DbquO7YL4j30
	zJAfiqQBL6HeyCISbc35tSO8DPtS5vCTXtxDKHzbIeb1JqHy1rz9yU7H
X-Gm-Gg: ASbGncuMsUAE7u4PcHdBfjmtCj++wAlANjOp3/0Jjkaxh25UEfD0of362uVuKzRGrsX
	VgfKSb8X2mx9Gyn7hI6xhxgyisD/txcDv6IyVERQtKfxYTZY4eAC05TGUhtHF1eSG1QPCauqfGQ
	4gvDNlZqX73SRcYJStTO5SFMbjn5oTGOQjfy1SEk+OOgMORMq5d3F6rA11UoEUg1BttGof0rg0V
	G+GTxJHur+XQ0yAaWL8nnw+M9CCGd/tC/Fh0bqW4aNF5ffg0o2g7JEEYkng6SVB6Ih0qzE0Bk2w
	laXaIzpI3Qsr43csy3LNIm8TDueYegT5x80lrK3qYsck9ytfHy/jrm3wDzaY5MXuiBcI4w22Bhx
	HaNTrHCk=
X-Google-Smtp-Source: AGHT+IHnJC0l+gbDs00pwG1808MP+xOdj+5geC/SnK90Q7YfSO2tawHe9nZ1kBJXaAyfhzoTYpFF1A==
X-Received: by 2002:a17:907:d716:b0:ad4:f5ed:42db with SMTP id a640c23a62f3a-ad52d4b3699mr1761549666b.17.1747753764479;
        Tue, 20 May 2025 08:09:24 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:e7c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d08058bsm750241866b.68.2025.05.20.08.09.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 08:09:23 -0700 (PDT)
Message-ID: <7f06216e-1e66-433e-a247-2445dac22498@gmail.com>
Date: Tue, 20 May 2025 16:10:42 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: devmem: remove min_t(iter_iov_len) in
 sendmsg
To: Stanislav Fomichev <stfomichev@gmail.com>,
 Al Viro <viro@zeniv.linux.org.uk>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, willemb@google.com,
 sagi@grimberg.me, almasrymina@google.com, kaiyuanz@google.com,
 linux-kernel@vger.kernel.org
References: <20250517000431.558180-1-stfomichev@gmail.com>
 <20250517000907.GW2023217@ZenIV> <aCflM0LZ23d2j2FF@mini-arch>
 <20250517020653.GX2023217@ZenIV> <aCfxs5CiHYMJPOsy@mini-arch>
 <20250517033951.GY2023217@ZenIV> <aCgIJSgv-yQzaHLl@mini-arch>
 <20250517040530.GZ2023217@ZenIV> <aCgQwfyQqkD2AUSs@mini-arch>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <aCgQwfyQqkD2AUSs@mini-arch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/17/25 05:29, Stanislav Fomichev wrote:
> On 05/17, Al Viro wrote:
>> On Fri, May 16, 2025 at 08:53:09PM -0700, Stanislav Fomichev wrote:
>>> On 05/17, Al Viro wrote:
>>>> On Fri, May 16, 2025 at 07:17:23PM -0700, Stanislav Fomichev wrote:
>>>>>> Wait, in the same commit there's
>>>>>> +       if (iov_iter_type(from) != ITER_IOVEC)
>>>>>> +               return -EFAULT;
>>>>>>
>>>>>> shortly prior to the loop iter_iov_{addr,len}() are used.  What am I missing now?
>>>>>
>>>>> Yeah, I want to remove that part as well:
>>>>>
>>>>> https://lore.kernel.org/netdev/20250516225441.527020-1-stfomichev@gmail.com/T/#u
>>>>>
>>>>> Otherwise, sendmsg() with a single IOV is not accepted, which makes not
>>>>> sense.
>>>>
>>>> Wait a minute.  What's there to prevent a call with two ranges far from each other?
>>>
>>> It is perfectly possible to have a call with two disjoint ranges,
>>> net_devmem_get_niov_at should correctly resolve it to the IOVA in the
>>> dmabuf. Not sure I understand why it's an issue, can you pls clarify?
>>
>> Er...  OK, the following is given an from with two iovecs.
>>
>> 	while (length && iov_iter_count(from)) {
>> 		if (i == MAX_SKB_FRAGS)
>> 			return -EMSGSIZE;
>>
>> 		virt_addr = (size_t)iter_iov_addr(from);
>>
>> OK, that's iov_base of the first one.
>>
>> 		niov = net_devmem_get_niov_at(binding, virt_addr, &off, &size);
>> 		if (!niov)
>> 			return -EFAULT;
>> Whatever it does, it does *NOT* see iov_len of the first iovec.  Looks like
>> it tries to set something up, storing the length of what it had set up
>> into size
>>
>> 		size = min_t(size_t, size, length);
>> ... no more than length, OK.  Suppose length is considerably more than iov_len
>> of the first iovec.
>>
>> 		size = min_t(size_t, size, iter_iov_len(from));
>> ... now trim it down to iov_len of that sucker.  That's what you want to remove,
>> right?  What happens if iov_len is shorter than what we have in size?
>>
>> 		get_netmem(net_iov_to_netmem(niov));
>> 		skb_add_rx_frag_netmem(skb, i, net_iov_to_netmem(niov), off,
>> 				      size, PAGE_SIZE);
>> Still not looking at that iov_len...
>>
>> 		iov_iter_advance(from, size);
>> ... and now that you've removed the second min_t, size happens to be greater
>> than that iovec[0].iov_len.  So we advance into the second iovec, skipping
>> size - iovec[0].iov_len bytes after iovev[1].iov_base.
>> 		length -= size;
>> 		i++;
>> 	}
>> ... and proceed into the second iteration.
>>
>> Would you agree that behaviour ought to depend upon the iovec[0].iov_len?
>> If nothing else, it affects which data do you want to be sent, and I don't
>> see where would anything even look at that value with your change...
> 
> Yes, I think you have a point. I was thinking that net_devmem_get_niov_at
> will expose max size of the chunk, but I agree that the iov might have
> requested smaller part and it will bug out in case of multiple chunks...
> 
> Are you open to making iter_iov_len more ubuf friendly? Something like
> the following:
> 
> static inline size_t iter_iov_len(const struct iov_iter *i)
> {
> 	if (iter->iter_type == ITER_UBUF)
> 		return ni->count;
> 	return iter_iov(i)->iov_len - i->iov_offset;
> }
> 
> Or should I handle the iter_type here?
> 
> if (iter->iter_type == ITER_IOVEC)
> 	size = min_t(size_t, size, iter_iov_len(from));
> /* else
> 	I don think I need to clamp to iov_iter_count() because length
> 	should take care of it */

FWIW, since it's not devmem specific, I looked through the callers:
io_uring handles ubuf separately, read_write.c and madvise.c advance
strictly by iov_iter_count() and hence always consume ubuf iters in
one go. So the only one with a real problem is devmem tx, which and
hasn't been released yet.

With that said, it feels error prone, and IMO we should either make the
helper work with ubuf well as Stan suggested, or force _all_ users to
check if it's ubuf. Also, I can't say for madvise, but it's not in
any hot / important path of neither io_uring nor rw, so we likely
don't care about this extra check.

-- 
Pavel Begunkov


