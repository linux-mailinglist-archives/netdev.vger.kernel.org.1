Return-Path: <netdev+bounces-68734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D72847C94
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 23:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDCA22873AD
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 22:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426F1126F34;
	Fri,  2 Feb 2024 22:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="KIi1NqP5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC31126F2E
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 22:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706914725; cv=none; b=F+HXjWQTFqdWFzTmUpq56QpHBrYOiul2/vwbSj4s8Xy05s0/cpb/x5hSdr1YI+vVmgfN0Val9vQ9FqM6juVtQKbmjmOgbk/NquLJ+UkTIp56y7MQEzZGJd0Mo40nn7M9tVDUcXwqv7/mdQldN/RqqYLEgGnOPQxycyXOi69NL3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706914725; c=relaxed/simple;
	bh=lZdHTBSpIOAQwH9fEkAUNqvyIh0RqARV321QonH+vv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u4cb+fvOsTSRE79zjMUYkNkhuNAR5YOoY0YW3Ka8y0lYHtTq4vEJuQCEztaozURRRxMWhGBOpcGte69tSzGQlX4DupjTPspyH4INmDbuvCv6pxDYbGqhfqyOzUBX6SocVASNEiVA6Fc0/w1qVcs4Zyn8zpZ/IqIJmlTw3t7ifBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=KIi1NqP5; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3be110bbff9so621428b6e.1
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 14:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706914722; x=1707519522; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vkHG6ll7IPHRZzRe2/2j/wkTPRs5NfbRx2SENCBoh84=;
        b=KIi1NqP5njwufkElRSxDcOERlAwPkSQqGX/VeH3v7duO7l9GsGyScXAIC0Zk+VsUl5
         JZLQZRmP7LL80SpE1VyjFRPbEi9Pz61U5+igkTNTI4BPrYC4siLjVNB8aJWq1xJzjdO1
         i37WDyq+wQR5DEvKJiGbLboDzfARzcryG4+tIXZj9CVr+czH96Y1p5+J7XklrJktipjo
         HZtosrTyc9tnJrhdHGAV+8wKOJj0GllTc5rtva+58+LHYofQGp/Zl0PAhCcu7BbLpCEJ
         wqHYvyY4MRHwUOtl6UZXYgw09vi+kQwp/lo3vbjnETupM3QT4htyGcBNlHQm2qCHNsKX
         h53Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706914722; x=1707519522;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vkHG6ll7IPHRZzRe2/2j/wkTPRs5NfbRx2SENCBoh84=;
        b=W905yaAQZaMv8A6f34/9MpPewIaXjzdNMUzVBG7GEb2SIl1cniab6a+UAUv8RR/XXJ
         3WNDUYYUON6YizmYSwxnuVLMpyDYC+4asAK3EEQ94NwLOWQCbMsY7oX90vq1Hq3dwiRh
         r+4eNgSKs4nI/RNAiW5IBSr2mfIJMOi61Q+hoLp6BO8bmBRBXehvfTOote7sUpqeSGVC
         hYuguZDoLL3ASTvgDw36Odcuog5/lwPPrZPECqlCNLKhqAd/wklcAoUITYBqMKYHvlAR
         pnxtZa8dp5FjxtgU4KRCXjlkS17WyUjzC6TJljlCOIrSetUVvsT9MKJmN1FBKNm8szj2
         dV7g==
X-Forwarded-Encrypted: i=0; AJvYcCVrZqzBk1kXaUMPoVqsb6Cv8t9PAtKApqBE4FJdrrX2L3qgbbVrp3b3vCm3/OdX1dTjG1uumpujPy99PHViQ4i3DGLNS/DE
X-Gm-Message-State: AOJu0YzZmrAUklNKOwr1oXdimMNXtlUwRFXqEM41HANvV1B+TVAbOhkr
	O+UDoGcB202izJmfTY5BTfn9GvN0pZVkDjIywtxx+ON1e+ZCq3dIy2waFM7Xted55gKn8YJgS1C
	tl4I=
X-Google-Smtp-Source: AGHT+IFq7I9kRxjbd+pNEQUNmfxSem64EVPi/xya2PNA9rrBKprcwC0miFZGbMbxXc2tDRSnG+On+w==
X-Received: by 2002:ac5:cff3:0:b0:4c0:15bb:2070 with SMTP id m51-20020ac5cff3000000b004c015bb2070mr1277635vkf.1.1706914701229;
        Fri, 02 Feb 2024 14:58:21 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVEixzsvLyCiJOMRL5ilFxz+PIOjKK26c4usnFV5P4+10H2lFZmv1jcs4HrI5IXxiovmi8l4XQK6AOwftkJfYv7mT036QDTBRi+2JjbsQCm92I9vWjuPCc90I8Sl7DGiSe+GCdapokAvVcAGtbWaMdQPXRkR6NqSRrvEHxgk6ZU2aE7kCQyTrplylFjkAiHcesV8sdp339K
Received: from [172.19.131.115] ([216.250.210.90])
        by smtp.gmail.com with ESMTPSA id kx3-20020a05621453c300b0068c8ba22806sm480810qvb.145.2024.02.02.14.58.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 14:58:20 -0800 (PST)
Message-ID: <8041ba2f-3ab9-44a8-b039-283be3f4960c@kernel.dk>
Date: Fri, 2 Feb 2024 15:58:07 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 0/7] io_uring: add napi busy polling support
Content-Language: en-US
To: Olivier Langlois <olivier@trillion01.com>,
 Stefan Roesch <shr@devkernel.io>, io-uring@vger.kernel.org,
 kernel-team@fb.com
Cc: ammarfaizi2@gnuweeb.org, netdev@vger.kernel.org, kuba@kernel.org
References: <20230608163839.2891748-1-shr@devkernel.io>
 <58bde897e724efd7771229734d8ad2fb58b3ca48.camel@trillion01.com>
 <2b238cec-ab1b-4160-8fb0-ad199e1d0306@kernel.dk>
 <45a21ffe4878d77acba01ec43005c80a83f0e31a.camel@trillion01.com>
 <b6dc538a-01eb-4f87-a9d4-dea17235ff85@kernel.dk>
 <34560e193660122ea142daa0fbeb381eb7b0eb6d.camel@trillion01.com>
 <c28b3f5f40ed028ba9d74e94e3cc826c04f38bf7.camel@trillion01.com>
 <a0f5b96b-c876-4c0a-a7b5-3809c26077d6@kernel.dk>
 <0ae91303c53aff4758bc07ee70add5c0f1ec524e.camel@trillion01.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <0ae91303c53aff4758bc07ee70add5c0f1ec524e.camel@trillion01.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/2/24 1:20 PM, Olivier Langlois wrote:
> On Wed, 2024-01-31 at 13:52 -0700, Jens Axboe wrote:
>> On 1/31/24 12:56 PM, Olivier Langlois wrote:
>>> On Wed, 2024-01-31 at 12:59 -0500, Olivier Langlois wrote:
>>>> On Wed, 2024-01-31 at 10:32 -0700, Jens Axboe wrote:
>>>>>
>>>>> Thanks for testing!
>>>>>
>>>>> Any chance that you could run some tests with and without NAPI
>>>>> that
>>>>> help
>>>>> validate that it actually works? That part is what I'm most
>>>>> interested
>>>>> in, not too worried about the stability of it as I have
>>>>> scrutinized
>>>>> it
>>>>> pretty close already.
>>>>>
>>>>
>>>> There is maybe a test that I can perform. The data that I receive
>>>> is
>>>> timestamped. I have a small test program that checks the age of
>>>> the
>>>> updates on their reception...
>>>>
>>>> I would expect that it should be possible to perceive the busy
>>>> polling
>>>> effect by comparing the average update age with and without the
>>>> feature
>>>> enabled...
>>>>
>>>> A word of warning... The service that my client is connecting to
>>>> has
>>>> relocated recently. I used to have an RTT of about 8mSec with it
>>>> to
>>>> about 400-500 mSec today...
>>>>
>>>> because of the huge RTT, I am unsure that the test is going to be
>>>> conclusive at all...
>>>>
>>>> However, I am also in the process of relocating my client closer
>>>> to
>>>> the
>>>> service. If you can wait a week or so, I should able to do that
>>>> test
>>>> with a RTT < 1 mSec...
>>>>
>>>> Beside that, I could redo the same test that Stefan did with the
>>>> ping
>>>> client/server setup but would that test add any value to the
>>>> current
>>>> collective knowledge?
>>>>
>>>> I'll do the update age test when I restart my client and I'll
>>>> report
>>>> back the result but my expectations aren't very high that it is
>>>> going
>>>> to be conclusive due to the huge RTT.
>>>>
>>>>
>>> As I expected, the busy polling difference in the update age test
>>> is so
>>> small compared to the RTT that the result is inconclusive, IMHO...
>>>
>>> The number of collected updates to build the stats is 500.
>>>
>>> System clocks are assumed to be synchronized and the RTT is the
>>> difference between the local time and the update timestamp.
>>> Actually, it may be more accurate to say that the displayed RTT
>>> values
>>> are in fact TT...
>>>
>>> latency NO napi busy poll:
>>> [2024-01-31 11:28:34] INFO Main/processCollectedData rtt
>>> min/avg/max/mdev = 74.509/76.752/115.969/3.110 ms
>>>
>>> latency napi busy poll:
>>> [2024-01-31 11:33:05] INFO Main/processCollectedData rtt
>>> min/avg/max/mdev = 75.347/76.740/134.588/1.648 ms
>>>
>>> I'll redo the test once my RTT is closer to 1mSec. The relative
>>> gain
>>> should be more impressive...
>>
>> Also happy to try and run it here, if you can share it? If not I have
>> some other stuff I can try as well, with netbench.
>>
> I have redone my test with a fixed liburing lib that actually enable
> io_uring NAPI busy polling correctly and I have slightly more
> convincing result:
> 
> latency NO napi busy poll (kernel v7.2.3):
> [2024-02-02 11:42:41] INFO Main/processCollectedData rtt
> min/avg/max/mdev = 73.089/75.142/107.169/2.954 ms
> 
> latency napi busy poll (kernel v7.2.3):
> [2024-02-02 11:48:18] INFO Main/processCollectedData rtt
> min/avg/max/mdev = 72.862/73.878/124.536/1.288 ms
> 
> FYI, I said that I could redo the test once I relocate my client to
> have a RTT < 1ms...
> 
> I might not be able to do that. I might settle for an AWS VPS instead
> of a bare metal setup and when you are running the kernel on a VPS,
> AFAIK, the virtual Ethernet driver does not have NAPI...

I'm going to try some local 10g testing here, I don't think the above
says a whole lot as we're dealing with tens of msecs here. But if
significant and stable, does look like an improvement. If NAPI works how
it should, then sub msec ping/pong replies should show a significant
improvement. I'll report back once I get to it...

-- 
Jens Axboe


