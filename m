Return-Path: <netdev+bounces-247164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1961FCF51F6
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 18:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E4EE8300E433
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 17:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A3C341AA0;
	Mon,  5 Jan 2026 17:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="FOhtzbIQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9FB309DA5
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 17:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767635932; cv=none; b=tRSc0FCnGerLPozc7Sj7gqxibifp+bLM7op7mWxRS8gOcbARirDBdFBGQ4AYllxgw0p/hZDm07G1osLZkeqBT3IRA2Z+1EJAgFfir8ptuKW6TDfJvqfDrbtlnrEo4XCqAHb8iQB46ZOafLjZbBR99HjsN2BguSc1tuy39vXw2iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767635932; c=relaxed/simple;
	bh=y8lyb5Qthe8A1KmGCLvELqTCy1n6DTr3wwSx0/VzBEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jkgM18BbfImpJY6Wj5PSMgWazab2rZ8VwzO4OUDZ3Dz3zK9adytaxxG/Uosec8r96d8/CxRoOz3gl+qEjvOa9X2YDf/1VMIyztn9XzevcMeWZhgmEoi/ktFeR61gnJT/AE/jasud8oZMWKqWHUF+Zg4cvPzNsh3jg98/9Tv4tEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=FOhtzbIQ; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-45392215f74so124548b6e.3
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 09:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1767635926; x=1768240726; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JG4W06PaZjVqA2yXXfbE163pQUmKP8y7EgYGG81GjIw=;
        b=FOhtzbIQ7/uWU8VQHuNfLOBbq9xpde+s+5BsYfunKz90NX0T8CyFTr1XpyhZJS0o9T
         OTxnD5uObDxqUU2m+lMd6IS/nUoJ6AzeFvdJ3O2kvksSDj0BRz/kGacX5PGidX2VcUSH
         jQT0pQsloVeLQ5+6ipM6rSNm53FfZuQHK/rXEK710MAfPz+lg4CGJqYvQ0bmbjkyqEUm
         14pVJtp1V30ikTmT0VWSAoyKdXxCAupm2Ska2ge0I/LSCktVeLqfHBtKT5ObgQowvLv+
         +SwI92siK4/mepf0Eb1kikBzASL9yiRKqT4bDmG0v6vtaAyLl2X0b0LUVJmnxgr3611E
         EWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767635926; x=1768240726;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JG4W06PaZjVqA2yXXfbE163pQUmKP8y7EgYGG81GjIw=;
        b=oFrx7ko4+5vyNqqRMXlAZtC2SilTiUCTGSoIlGDGf3tfe0OiaJEMW0PXTpzVTWUmfD
         7ftFSejb5W6NH5Jxlu545TvF8Ennx0XvhUug0c57Eq5RUDM9rER+cW3+jh1mIitnAS0w
         4ETWFOZcqhjStEnmDDsZCN8XFElEN6gk0yxB+u4wL7ftoOf6ZOLzni8TksbEogN8Zuck
         IkOPiBp3OqeM56iRKcFiSV/6uvaHTx67N1U3mfeJUp5YCgYQ1GeimfUad/9GFkoVghpI
         fXDvTaPon1TWXH/zqwCDTnaX29Zdug0DQGU1xVMiPv0UuvmAXgOJDzq6kGPkMIh5mzVS
         ut3Q==
X-Gm-Message-State: AOJu0Yw9OMdsaP63f0FVezyApE8K9RBL6KDnGRrEawQ/XRJWPnKjwUV2
	fKaqkX0jgf3n0YTO2/axMp3UhwsqouKUnI8naE8t8scmUedUehjYsOi6epimnh77BgeqPZRH+xh
	VWpJN
X-Gm-Gg: AY/fxX7tvX/+3LnJSIPaWmw3Bd1QzqlIJTwFzZNtdhEDv/IGG96un2xoPo98Jl6XKZu
	pbcrfRTdJlRHpLDI90kSggeMFwhdJ3mz96NEvCZr8/GD9wDAquftspFnNdfsF6P9mYYWUtq3KMW
	QeVMC01RNWJBLF0n5Xd1ofvhW7X6KhO0urLSY2leewWRJvOZdtFypnYdYvmED1DXG8io3kmjCEp
	IOJJMoM+spm2OCx0Rd8GPwkoSWRru9mxzHnQgEyXP+vrNMbImF9yKzm0Th2q9BV66HNdxT4K4Py
	34vQ6kfdZ9fA4ZTReO5puGLl7xJ4FiS7gBno7AMRfZENHL0w4DORRyLquL/2CHNfgoF+GvODtgh
	s6GvO2KkGnzEzm9VS1bjUtTFsGsroEOEClsgqg6k3D1yH61rFvIE5mHA96g7fM+m0s9h9nIGA07
	7JTYXSAupT
X-Google-Smtp-Source: AGHT+IFzU/MTQeNHRW1i1ZujZIXktFW3I+GkzQF9MdI3tE0YEj1QrhPH8LPBe7OLp6sqmhV3owu2oQ==
X-Received: by 2002:a05:6808:30a8:b0:453:50af:c463 with SMTP id 5614622812f47-45a5b128318mr250385b6e.41.1767635926317;
        Mon, 05 Jan 2026 09:58:46 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5bcacd4dsm105167b6e.10.2026.01.05.09.58.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jan 2026 09:58:45 -0800 (PST)
Message-ID: <fb772a80-7034-42b1-a80a-117a7339d371@kernel.dk>
Date: Mon, 5 Jan 2026 10:58:44 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: do not write to msg_get_inq in caller
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuniyu@google.com,
 Willem de Bruijn <willemb@google.com>
References: <20260105163338.3461512-1-willemdebruijn.kernel@gmail.com>
 <CANn89iL+AuhJw7-Ma4hQsgQ5X0vxOwToSr2mgVSbkSauy-TGkg@mail.gmail.com>
 <willemdebruijn.kernel.2124bbf561b5e@gmail.com>
 <5ce5aea0-3700-4118-9657-7259f678f430@kernel.dk>
 <willemdebruijn.kernel.4358c58491d1@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <willemdebruijn.kernel.4358c58491d1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/5/26 10:57 AM, Willem de Bruijn wrote:
> Jens Axboe wrote:
>> On 1/5/26 10:42 AM, Willem de Bruijn wrote:
>>> Eric Dumazet wrote:
>>>> On Mon, Jan 5, 2026 at 5:33?PM Willem de Bruijn
>>>> <willemdebruijn.kernel@gmail.com> wrote:
>>>>>
>>>>> From: Willem de Bruijn <willemb@google.com>
>>>>>
>>>>> msg_get_inq is an input field from caller to callee. Don't set it in
>>>>> the callee, as the caller may not clear it on struct reuse.
>>>>>
>>>>> This is a kernel-internal variant of msghdr only, and the only user
>>>>> does reinitialize the field. So this is not critical.
>>>>>
>>>>> But it is more robust to avoid the write, and slightly simpler code.
>>>>>
>>>>> Callers set msg_get_inq to request the input queue length to be
>>>>> returned in msg_inq. This is equivalent to but independent from the
>>>>> SO_INQ request to return that same info as a cmsg (tp->recvmsg_inq).
>>>>> To reduce branching in the hot path the second also sets the msg_inq.
>>>>> That is WAI.
>>>>>
>>>>> This is a small follow-on to commit 4d1442979e4a ("af_unix: don't
>>>>> post cmsg for SO_INQ unless explicitly asked for"), which fixed the
>>>>> inverse.
>>>>>
>>>>> Also collapse two branches using a bitwise or.
>>>>>
>>>>> Link: https://lore.kernel.org/netdev/willemdebruijn.kernel.24d8030f7a3de@gmail.com/
>>>>> Signed-off-by: Willem de Bruijn <willemb@google.com>
>>>>> ---
>>>>
>>>> Patch looks sane to me, but the title is a bit confusing, I guess you meant
>>>>
>>>> "net: do not write to msg_get_inq in callee" ?
>>>
>>> Indeed, thanks. Will fix.
>>>
>>>>
>>>> Also, unix_stream_read_generic() is currently potentially adding a NULL deref
>>>> if u->recvmsg_inq is non zero, but msg is NULL ?
>>>>
>>>> If this is the case  we need a Fixes: tag.
>>>
>>> Oh good point. state->msg can be NULL as of commit 2b514574f7e8 ("net:
>>> af_unix: implement splice for stream af_unix sockets"). That commit
>>> mentions "we mostly have to deal with a non-existing struct msghdr
>>> argument".
>>
>> Worth noting that this is currently not possible, as io_uring should
>> be the only one setting ->recvmsg_inq and it would not do that via
>> splice. Should still be fixed of course.
> 
> recvmsg_inq is written from setsockopt SO_INQ. Do you mean
> msg_get_inq?
> 
> I think this is reachable with a setsockopt + splice:
> 
>         do_cmsg = READ_ONCE(u->recvmsg_inq);
>         if (do_cmsg)
>                 msg->msg_get_inq = 1;

Indeed you are right, I mixed up the two...

-- 
Jens Axboe

