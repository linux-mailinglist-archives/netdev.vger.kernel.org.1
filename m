Return-Path: <netdev+bounces-205104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D80AFD5E6
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 20:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A5B81C24A7F
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 18:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4216C219A79;
	Tue,  8 Jul 2025 18:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="TB+9f15L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71261DE2A7
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 18:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751997663; cv=none; b=I9jFXK9isDKXM8/t+0AHMJHwKuY6Y/yiUV+WQNMtnXgg4hajEnqWWB3UL7zzolCOhf8wYOq3IxZJrSqaadnOK0a6f4lEEKfne/+2gnO7mlCDtadsaNnvGpyST7g1g8CDBYhrw2EQY7jBJCTormr8svtaQvX4vaFsRR+c9POr+LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751997663; c=relaxed/simple;
	bh=+USx5CH57n6QwmD2K0OGycX899v5Rmxu0jTTkKyLlwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nsxww27JbTCFelidreyR8Cw18bNUfCSgAz0KghsIvWpxw+aqObVOXt4KWE8SCKkNjBWLg9a9cp3vQaprTN9jk9CEXuRLKdcbg3b6bEBl+odhPZK5vLobyeM8VKIO0ETTSjRfJ7LfiVaZj341HTWlW6WhtKcqKujEU77tzz9qU6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=TB+9f15L; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-875b52a09d1so143074139f.0
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 11:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1751997661; x=1752602461; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=so5kYvoSvBzjaegr3s+w/1MNs5lssVlBMaQJAReKVt8=;
        b=TB+9f15L2uSUVpkA/n2aFYC4ruNbP8ibgCW8L6lVcdSH9s2q3FJADKCX6FEnCWE71H
         Fs2XRUFlLJkuF0D+Md+EoopqJ8LD8B6725GE073VuLuSv1UAyKZHMfhR7eg1McUAXKis
         2j2hCaJ4Y7f+/oaAe4o4O0LOyqo9zD5oPEEykZZtv0FXtiJFooS3FoIhnZrrYoQykja4
         K+9vh9Smsr9YdokvecxWea411PGOfX8Rm6Q8u93Ys5YHMdUSLxOA08Lu8lCXUSwp8UZZ
         eOitUisbS2b14+UitgdrAh6Fxn52rzaLkaKZ6IBITl31Qp3ZzrcNnmPyyPEVfne5Go/J
         16NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751997661; x=1752602461;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=so5kYvoSvBzjaegr3s+w/1MNs5lssVlBMaQJAReKVt8=;
        b=Z0id6ZzmU2DpDmtAivC/UCzY6FagtPGJFYw7S8ObH7LUJHKsArU4+2be1VSGydZ3gL
         4gK3SrEminvEHiqIJ1hDt4vsMRWBZzQaBiOzQKM61qT/nIZuQbonnUK8RxdAtpL5VEHZ
         wJXe3iq+60UtO5XyK5/nS6CoIT0t27FytcD6sEV8H2E+K0x97gUl+3gXe3c+cwIQV556
         JR/RqtqKig0lBXJ0ai0XwZ7Y3fcM4+Gk7PvLKBp3hwVUXcus301n0L9TehM3b8/o8Pfr
         CT3j4nVV1HjZq8aJEJqPIM1I5jH2UXGw4mdgV09cD0ICViQgCfGYML+Qrg9e37gw64Ln
         A2AA==
X-Gm-Message-State: AOJu0Yzxl0PCSXjmXgZEq614TgswjqYXa+RcPadEi6DNhJgLWxTSNG8f
	Yk/wbG8bfvqh0Z7RcAxGY77B9JMXgaewdiN1IiIMga71epfXOBqPWz4nCQucE2c+bNw=
X-Gm-Gg: ASbGncttsZM99901ieE5Ikl2fy0Ofd23Cs69+B5SIhUG1ulHDF40RY/ySr16ASD5ZVX
	Fy3gVoqWYIkViBCDGVc1Rb2n/7uLLbJSFBiP7FDJAaam21hcjzO0UeoJXx885vKQaCC/pha99wC
	NwgX0kZ8hIKPNt4PsB3FnNbQw+M4tXMOBWslMiM67ZV021Pr5rASc3QobQ7UJe7fOgsfZ7UYnuf
	kqEE0gZO1RmnkwQNwcJV5v7Dd8D9w4iwBSF6WpRGM3CtZoJaDQk4GN9AwvN47JU5ICL6rh4bV98
	d/EKO/FQ97pg2KspJMTKsvBsGuT/laCtj72xBBiRh1kk9MRzJbJZr0ud5Q==
X-Google-Smtp-Source: AGHT+IFtPgVsC0Dx3w9AbbC/p8IouDOmZruioyseA2FMsL3Zxakw0A33b0jn5x9d2fV9wQVF3L/UBA==
X-Received: by 2002:a05:6e02:1f86:b0:3de:128d:15c4 with SMTP id e9e14a558f8ab-3e136d0ff9amr155063835ab.0.1751997660907;
        Tue, 08 Jul 2025 11:01:00 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e0fe221071sm33769005ab.44.2025.07.08.11.00.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 11:01:00 -0700 (PDT)
Message-ID: <46642bea-f9d4-4b56-9d22-393567328075@kernel.dk>
Date: Tue, 8 Jul 2025 12:00:59 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH v5 0/5] io_uring cmd for tx timestamps
To: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Jason Xing
 <kerneljasonxing@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>
References: <cover.1750065793.git.asml.silence@gmail.com>
 <175069088204.49729.7974627770604664371.b4-ty@kernel.dk>
 <a3e2d283-37cd-4c96-ab0b-dfd1c50aae61@kernel.dk>
 <cf277ccc-5228-41dc-abd5-d486244682dd@gmail.com>
 <caba8144-4e27-4eaa-9819-8601d66988a5@kernel.dk>
 <a8ac223d-6bb0-4c47-8439-b0d0de4863dd@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <a8ac223d-6bb0-4c47-8439-b0d0de4863dd@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/8/25 12:00 PM, Pavel Begunkov wrote:
> On 7/8/25 18:55, Jens Axboe wrote:
>> On 6/28/25 12:10 AM, Pavel Begunkov wrote:
>>> On 6/27/25 18:07, Jens Axboe wrote:
>>>> On 6/23/25 9:01 AM, Jens Axboe wrote:
>>>>>
>>>>> On Mon, 16 Jun 2025 10:46:24 +0100, Pavel Begunkov wrote:
>>>>>> Vadim Fedorenko suggested to add an alternative API for receiving
>>>>>> tx timestamps through io_uring. The series introduces io_uring socket
>>>>>> cmd for fetching tx timestamps, which is a polled multishot request,
>>>>>> i.e. internally polling the socket for POLLERR and posts timestamps
>>>>>> when they're arrives. For the API description see Patch 5.
>>>>>>
>>>>>> It reuses existing timestamp infra and takes them from the socket's
>>>>>> error queue. For networking people the important parts are Patch 1,
>>>>>> and io_uring_cmd_timestamp() from Patch 5 walking the error queue.
>>>>>>
>>>>>> [...]
>>>>>
>>>>> Applied, thanks!
>>>>>
>>>>> [2/5] io_uring/poll: introduce io_arm_apoll()
>>>>>         commit: 162151889267089bb920609830c35f9272087c3f
>>>>> [3/5] io_uring/cmd: allow multishot polled commands
>>>>>         commit: b95575495948a81ac9b0110aa721ea061dd850d9
>>>>> [4/5] io_uring: add mshot helper for posting CQE32
>>>>>         commit: ac479eac22e81c0ff56c6bdb93fad787015149cc
>>>>> [5/5] io_uring/netcmd: add tx timestamping cmd support
>>>>>         commit: 9e4ed359b8efad0e8ad4510d8ad22bf0b060526a
>>>>
>>>> Pavel, can you send in the liburing PR for these, please?
>>>
>>> It needs a minor clean up, I'll send it by Monday
>>
>> Gentle reminder on this. No rush, just want to make sure it isn't
>> forgotten.
> 
> You already merged the (liburing) test
> 
> commit 21224848af24d379d54fbf1bd43a60861fe19f9b
> Author: Pavel Begunkov <asml.silence@gmail.com>
> Date:   Mon Jun 30 18:10:31 2025 +0100
> 
>     tests: add a tx timestamp test

I totally did... Just going over old emails, guess it got lost in post
vacation juggling. Sorry for the noise!

-- 
Jens Axboe

