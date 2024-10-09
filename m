Return-Path: <netdev+bounces-133880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 562AE99755A
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 21:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AF4E1C228C9
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 19:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B8A1E105F;
	Wed,  9 Oct 2024 19:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="grc9m9ZX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E1D1E0E18
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 19:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728500509; cv=none; b=vGnQOOAspnIuB/i0kh1SFTdRxy2tQo7ILFNecgvReqvW7UDWMGu722P6L1xIRuX9lTtNt1KHWqRaWWJTLilsy/TC+ZZVtB+AKhWzDZjos00TZgtP8ODQKsu04TpLPh+sLcyuNKH/IZlbibKb8tTtr3XY3wb2pQLHNHNluSxZWYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728500509; c=relaxed/simple;
	bh=ZERkZQUmj3NIzKvPv2s4yZoZAzwUZW6hwxGwTDLSIiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u8MAZordubae/nNrBK7nVvjKHhEq1LmNvGLTYdzUw84RgbQG5REH36pViUnEW/NFzgSf6lQV1TGjPtPH5HXvpFzwPX4YMdqlCAB9Uf0IpdExZJ1H8NIXD/6NbxzaaYgK0dXnVcEojZFum7cTmRVXTmfPq+1QCA7vpJM3YE5HD6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=grc9m9ZX; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a39620ff54so935825ab.1
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 12:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728500506; x=1729105306; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dOS2JisAoHa0cARLuAlDWjfKWnjZWZhuSgzV0J+AbPc=;
        b=grc9m9ZX8Vde3l1KWdMiLNe9ggyUr6mzNy7opyfPHjJaElnvPkz8EdHrpUYJOpmnP5
         FUqTeE3PpFLDj6JTkLDfjPniyolamdJUFnX8dM/vpQVwCIF2gVnt7Prss2cNrMKd8Zxs
         43QY59ITinsTd/pcQJuqpImyaBfW9ud+uxoAzCx34dy+GNCQn9OTq5rxEWZi1cC9gth3
         XwB5CLCa/YUaTKsTpOIfGasGV/9zGjpj6QnlRRGZK8+vwE4CG+KQxz7K/0qLzUxrClLl
         jmtLbj0yF1M/XmGIBEuWiddlJWP70Iv14ufETiDNDaxzRGu7bfBqTDNU3XNx7rPu6oiT
         v1OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728500506; x=1729105306;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dOS2JisAoHa0cARLuAlDWjfKWnjZWZhuSgzV0J+AbPc=;
        b=wdNchFxnazNyo8eyZl8HF6awWAIL+c2NhW83ROxnuYoNm1QMNLi/FcSVSslH9zRO9G
         P6qfMxkth21j/u6/xGkxXqIovWKwJ9WN27gM4MGY5DaNX/PXNC9omcD1CXcDTHvn+FNG
         kpSs73yzBuh2ldwqC3EhSIVH3Q+TKrOpGQZ8qHT4A6a/8ydTIVfzjJM0JfUyFANUmCvM
         VXXfl9jTM275Rj97ipmwu7Z3xN26K2tDHAhJgI1697ijFYpYp9HobC71yP6oe0LJQO3g
         ng9qwqXlDIGnGOHuE6+jjdohnHTJaPGpcM8z1Jh8b+lefQEAv3oc/hA5KZGvjzVhOy8q
         OzGA==
X-Forwarded-Encrypted: i=1; AJvYcCVMN7rB658NTs9xGAKB4bFvSBHsB+NGQfBYS2c8yxdItODAB1+L39npVrT1BMhhXz3wUVbTk2c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/9EQQLC9RRP1i9jp0OVvu+lTR1BEWAxKOKldE6A0f2WTVyMh6
	Fyzv5hnoy5nOiM0XE+D9cSUQ50uT5Q46tU9cnjzNres42RNoq7cdklTfYdvO574=
X-Google-Smtp-Source: AGHT+IEvFaEf6WOrpba+7ebLWeo7XarhalgW21yIs6hXxoOesfE8rZRObCC8M5O3r+v2g06mtjJLSA==
X-Received: by 2002:a92:c54d:0:b0:3a0:9b56:a69 with SMTP id e9e14a558f8ab-3a397cf7cbemr45910245ab.7.1728500506114;
        Wed, 09 Oct 2024 12:01:46 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a3a030a20fsm3091455ab.8.2024.10.09.12.01.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 12:01:45 -0700 (PDT)
Message-ID: <af74b2db-8cf4-4b5a-9390-e7c1cfd8b409@kernel.dk>
Date: Wed, 9 Oct 2024 13:01:44 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 12/15] io_uring/zcrx: add io_recvzc request
To: Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>,
 io-uring@vger.kernel.org, netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, David Ahern <dsahern@kernel.org>,
 Mina Almasry <almasrymina@google.com>
References: <20241007221603.1703699-1-dw@davidwei.uk>
 <20241007221603.1703699-13-dw@davidwei.uk>
 <703c9d90-bca1-4ee7-b1f3-0cfeaf38ef8f@kernel.dk>
 <f2ab35ef-ef19-4280-bc39-daf9165c3a51@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <f2ab35ef-ef19-4280-bc39-daf9165c3a51@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/9/24 12:51 PM, Pavel Begunkov wrote:
> On 10/9/24 19:28, Jens Axboe wrote:
>>> diff --git a/io_uring/net.c b/io_uring/net.c
>>> index d08abcca89cc..482e138d2994 100644
>>> --- a/io_uring/net.c
>>> +++ b/io_uring/net.c
>>> @@ -1193,6 +1201,76 @@ int io_recv(struct io_kiocb *req, unsigned int issue_flags)
>>>       return ret;
>>>   }
>>>   +int io_recvzc_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
>>> +{
>>> +    struct io_recvzc *zc = io_kiocb_to_cmd(req, struct io_recvzc);
>>> +    unsigned ifq_idx;
>>> +
>>> +    if (unlikely(sqe->file_index || sqe->addr2 || sqe->addr ||
>>> +             sqe->len || sqe->addr3))
>>> +        return -EINVAL;
>>> +
>>> +    ifq_idx = READ_ONCE(sqe->zcrx_ifq_idx);
>>> +    if (ifq_idx != 0)
>>> +        return -EINVAL;
>>> +    zc->ifq = req->ctx->ifq;
>>> +    if (!zc->ifq)
>>> +        return -EINVAL;
>>
>> This is read and assigned to 'zc' here, but then the issue handler does
>> it again? I'm assuming that at some point we'll have ifq selection here,
>> and then the issue handler will just use zc->ifq. So this part should
>> probably remain, and the issue side just use zc->ifq?
> 
> Yep, fairly overlooked. It's not a real problem, but should
> only be fetched and checked here.

Right

>>> +    /* All data completions are posted as aux CQEs. */
>>> +    req->flags |= REQ_F_APOLL_MULTISHOT;
>>
>> This puzzles me a bit...
> 
> Well, it's a multishot request. And that flag protects from cq
> locking rules violations, i.e. avoiding multishot reqs from
> posting from io-wq.

Maybe make it more like the others and require that
IORING_RECV_MULTISHOT is set then, and set it based on that?

>>> +    zc->flags = READ_ONCE(sqe->ioprio);
>>> +    zc->msg_flags = READ_ONCE(sqe->msg_flags);
>>> +    if (zc->msg_flags)
>>> +        return -EINVAL;
>>
>> Maybe allow MSG_DONTWAIT at least? You already pass that in anyway.
> 
> What would the semantics be? The io_uring nowait has always
> been a pure mess because it's not even clear what it supposed
> to mean for async requests.

Yeah can't disagree with that. Not a big deal, doesn't really matter,
can stay as-is.

>>> +    if (zc->flags & ~(IORING_RECVSEND_POLL_FIRST | IORING_RECV_MULTISHOT))
>>> +        return -EINVAL;
>>> +
>>> +
>>> +#ifdef CONFIG_COMPAT
>>> +    if (req->ctx->compat)
>>> +        zc->msg_flags |= MSG_CMSG_COMPAT;
>>> +#endif
>>> +    return 0;
>>> +}
>>
>> Heh, we could probably just return -EINVAL for that case, but since this
>> is all we need, fine.
> 
> Well, there is no msghdr, cmsg nor iovec there, so doesn't even
> make sense to set it. Can fail as well, I don't anyone would care.

Then let's please just kill it, should not need a check for that then.

-- 
Jens Axboe

