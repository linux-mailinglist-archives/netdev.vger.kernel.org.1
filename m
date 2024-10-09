Return-Path: <netdev+bounces-133894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2DE9975F6
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 21:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 208181C21445
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 19:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360E31E1051;
	Wed,  9 Oct 2024 19:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="R2Nx/QM4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283D91E0DC9
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 19:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728503464; cv=none; b=b0BcknoN7s+m9mX+0f3SQM+dFSILfLopTNC++GN5yE6ISnrJygEb5ZHD4mAUZIohBR4jZbxqHoyJsjrk6h5lW5/Ppruamf1qp/AeVfmFHMtjFlB0Vw7CjI8rykaktlHLcsJxkZP+m5GufGNr6FktGKxRo2u7Vg0BuVM7StWe1Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728503464; c=relaxed/simple;
	bh=K3Sin6HsrhzRRP2HgMTVeCGgTRTQpKHKA+ETtOJS1ms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uyqe2dB9ZdNxH6SkcZYW+rFr27k2L0cEaZWUVSTDGOTIvAQJyKelWOl2Z5JGjblVJkzhXZSFVJ6uWlpyhFdRQ2qliaxo0e6tkqSAQy9YPxCtOj+x9ja/2CIzXfQl2+CfyyWd0L1fQ+Ii9PmQkOoFukwE36ZoNeFti70pbBqiDgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=R2Nx/QM4; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a3525ba6aaso870775ab.2
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 12:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728503461; x=1729108261; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hyzeTwQWm4QHExZgx/HQ8cPQRRp2JJMriJXGeys4Vd0=;
        b=R2Nx/QM4GYFd/yEcKVat7fuhEAM13FpJ6BVnprCf5AdGFE9ov7KP4qLszjL1ZeacMA
         /4mBKBQJZptZUg5pS7V7GT0zTPbW2pcAcLoevBLydTZr/CLBCUfXt1yvLz0B8FuXitpe
         YGpzsLxGVgMao+lDavmqN/DMg3QqMddroMuCzL7RkFHFUwaopbj67/Cl+sGkIVbSvsrX
         iWcEGSIsQoHLH/XLcCwsYd35dC6nKUJr2ALcISpq3TnugwdJ+iNnnSF508V4K7ZiqvOg
         kR2fx8XF+I0p72BVCxbetEIEcBztMQFPfqLjgbIFxbhDeomVkTV2MPpyxuOeFx/naUhk
         M6Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728503461; x=1729108261;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hyzeTwQWm4QHExZgx/HQ8cPQRRp2JJMriJXGeys4Vd0=;
        b=fbGsVOjjoyHFRYlNXkLqM+MhLSl1bqrK7wiOAuB40WHHB0wTRSuh4WG+p+OCVvg9Qg
         OZxn4PF/V874Hd9p9N78gxiZAuQoWicxIhRp40lCVP+ZKKcCfGfKiPVTWAt3eDHRnIPj
         ejIhTWWT+6B9ZxoN522bBjjP4j9mN2Dj96GO+AGB9ljcVju6PDTqdrI/drs6wzvbMfw7
         IaA2PC1JUkL9Y7+uBnAODfz+UmR9kJmYW4x1EB42/fvRG/+637YUYxgUTdlCABz3W+aC
         ETC6+7jh8dbFhc41haTPtmQrLCXmD5eLtB/TE9pyPc5g+hjaITA9y+9BkAbuol/Q9g6u
         JTYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmaKPzJCU4y7MUhF4fadv8Sjt2WgmulsSy8mUUhyEqljV64d/2bS1CMWQ7tZGtLR1/yNRQVS8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt32iMDXhhl7i8VhSEWztjCqRzmKTcVnFRBqhGTEWweMH5ETuy
	/P9bBxi56gUnL/A7wEHnlI7Xk7aWikzBlgY3gZyH7idHFRNHRZiPM76gZuLaHnA=
X-Google-Smtp-Source: AGHT+IEDtXerx531mxi3pVoSP4s1yifrJRdu3yBQSw7xZ3r6OWX3zbsW/0ceQm4MVFLJHpDyf3mzGA==
X-Received: by 2002:a05:6e02:1fcc:b0:3a3:9792:e9e8 with SMTP id e9e14a558f8ab-3a397ce8583mr33498195ab.5.1728503461140;
        Wed, 09 Oct 2024 12:51:01 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dba90f4166sm162232173.159.2024.10.09.12.51.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 12:51:00 -0700 (PDT)
Message-ID: <32a05d6b-1b82-467f-ac3e-f3cd2e5c0e22@kernel.dk>
Date: Wed, 9 Oct 2024 13:50:59 -0600
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
 <af74b2db-8cf4-4b5a-9390-e7c1cfd8b409@kernel.dk>
 <7cee82f7-188f-438a-9fe1-086aeda66caf@gmail.com>
 <177d164a-2ebc-483a-ab53-7741974a59c4@kernel.dk>
 <d5be304b-0676-4f4e-adbc-eea3f7b161de@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <d5be304b-0676-4f4e-adbc-eea3f7b161de@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/9/24 1:47 PM, Pavel Begunkov wrote:
> On 10/9/24 20:42, Jens Axboe wrote:
>> On 10/9/24 1:27 PM, Pavel Begunkov wrote:
>>>>>>> +    /* All data completions are posted as aux CQEs. */
>>>>>>> +    req->flags |= REQ_F_APOLL_MULTISHOT;
>>>>>>
>>>>>> This puzzles me a bit...
>>>>>
>>>>> Well, it's a multishot request. And that flag protects from cq
>>>>> locking rules violations, i.e. avoiding multishot reqs from
>>>>> posting from io-wq.
>>>>
>>>> Maybe make it more like the others and require that
>>>> IORING_RECV_MULTISHOT is set then, and set it based on that?
>>>
>>> if (IORING_RECV_MULTISHOT)
>>>      return -EINVAL;
>>> req->flags |= REQ_F_APOLL_MULTISHOT;
>>>
>>> It can be this if that's the preference. It's a bit more consistent,
>>> but might be harder to use. Though I can just hide the flag behind
>>> liburing helpers, would spare from neverending GH issues asking
>>> why it's -EINVAL'ed
>>
>> Maybe I'm missing something, but why not make it:
>>
>> /* multishot required */
>> if (!(flags & IORING_RECV_MULTISHOT))
>>     return -EINVAL;
>> req->flags |= REQ_F_APOLL_MULTISHOT;
> 
> Right, that's what I meant before spewing a non sensible snippet.

ok phew, I was scratching my head there for a bit... All good then.


-- 
Jens Axboe

