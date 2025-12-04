Return-Path: <netdev+bounces-243585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDA7CA4316
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 16:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6313C31C5455
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 15:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCCF2D6639;
	Thu,  4 Dec 2025 15:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpJY+GbT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234F12D97AF
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 15:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764860916; cv=none; b=e+1Muu5SVa0twEyHYj3IijRLZ7h+KAdMn8j935BEOP4pyVgRLCPwdA4lX+oLAAD9h8O09wBDZJH47QxEiG45JcLLtlZCh2HlmHXIDlVMExLWZDigUQmJvcjukcfIoBJUWxlbm0nvBpjnQMjN0buT9Am7/glkfHdP2Tz6ttQTB4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764860916; c=relaxed/simple;
	bh=mow+fg3+RlIbDNumBSEnGyZekiI5a4ukShUjLnnu0Js=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IrnMfK9yvrZUovi3Oj9l7uADJPrG1hN4LwxIi1sSirNSKK0dd+E3ZxwzjNp4aqpKdeHD7sbv8J88Ge9NiufyH0MXxIPuZhoGdm6Cu8euDgpzCEeVxsvr7Xuwqjvd8pw3JoqOs/kUx/DpvuoRVZ3ZaT6KoZ4EaQ72gqb0pdRs29c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EpJY+GbT; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7e2762ad850so919555b3a.3
        for <netdev@vger.kernel.org>; Thu, 04 Dec 2025 07:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764860913; x=1765465713; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t1iqQ0ov45xjnCibqFJmGxUgMKunIGbHn1CsgPvUOa0=;
        b=EpJY+GbT2GuIEWdtU0ZHL742loWruVKtuTyFoCR8XRNym3OZBw4Yk5zRe6sd7P8XME
         1NLacDQsksq4E1UckNBW7dbFes5qLwbXNZsmrhPIDkAs3uUhapi9Syd30ucWM5N80u0S
         yab9GrQboMOSjBO4dSaLOpKaS9St1IZcKFadd9azjKPFWQE98mFYJ5u2aIm715Hm+yHJ
         NuAICmdYffQudeH8KmIOFwXXGS8/UbcrNlncWZe1nLHdJ84Fy+7a7TP7zjjoM2k3z971
         j/lq5R9MBymtH2gcTwy6ZOdY4dyVMBGGMCEwA15RBG65EZ0veXzKfx5lqTg+clEpFicT
         xQJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764860913; x=1765465713;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t1iqQ0ov45xjnCibqFJmGxUgMKunIGbHn1CsgPvUOa0=;
        b=YBh+0lU7glI9ik5mOL2eE3+qMwzmSoWNrqV94XowW6SKo1Gpws7SgYOEg2q/YqOKei
         MsueqAHjp7TFSdYV/iaIMpzqoYL0q/XMVNg870lnkTSuhMzNrp2p+VR8I3U74WxZADai
         LWUoyDQxsKLcIZeaSr3rfN7Bu49ZtedeXJ8O+TrE/mk1uUQQHkuOD2VfrE9CpwII10No
         mkDpgk86tnDvtv8Ptkmnx08gtUA89FB/o5VwXikbmwBxS5zV7J0tUa5BXz3YBN7h0DH4
         1eT0bSks7Q+SHzTtWwDGLlviFKHOtxm5U3+KTx6CSM8VrIVvyPdSTG3cLYsKd0155zwi
         PUjw==
X-Forwarded-Encrypted: i=1; AJvYcCU1VZGbeeqrGtM5cUbkb2EhAUZC3kDwxuAKQTHwjeo2tHFb34qmpvCZc4xssDbja6X5cxW+csQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmqIxiZ2Cwx8qzlYOmVxSwJZKZtiBqV5iXIb7m827Uag1Hz7Yu
	JSAon7zcVxTAprR5qrTNYQsjnlueVDzYeLF4d1/SRrmZIGDALLwvR0nY
X-Gm-Gg: ASbGncufDgl7x9WWo6FyGu8z1e6s3s1Ufc7UHfOhQsOn6IUDg3q2nzYrY6Ceg3k8ZEI
	iAKa58Te5a7QHiWlk43P/e9rAeGWKQmo76fIoHPle+UEkkMlcqxmLXpUaCtIlnk8zF7l70edU0f
	GAjSaCJbbfQkGe1igCmU7HHhGbN8xB6dY7Yxbx7agSopvU2NG+CIJW3IIgnzRH30wutZ2vY5EZ6
	Y/SYO30l7uCmDHn0rH7DJ1qY5+ZJvcUCHNfO2ubCecnu1YQiIjCtc1S4hkshMcQmqEMdMW5jgRj
	8K6bEiSK8aZhV35Q8i3sQmqtOGixlaF4WzFEp8hPBpKOlPA2tI0japGhskmU53ccqEc0ABfpePC
	bC1h+ALFRrD1U24Wd+uFRmHESLMpjFojU8f8uBYqAKAoppogoZIpNB0gl9gCftGdYV9z0pUkUS4
	RokN9kcbbfviCzZluPEN1IzhpZKFKGM4mXRn2fVcQrCHAyEv7kkYwx5LYokQZRoA==
X-Google-Smtp-Source: AGHT+IGT33HgCqLOZfJ01RgUk00qwFrULoYZQaMW53xI5BI0UsjXz8kyxp1vtyO+ouK42MOcyxdiSA==
X-Received: by 2002:a05:6a20:3ca6:b0:34e:1009:4222 with SMTP id adf61e73a8af0-363f5e95146mr8047704637.51.1764860912867;
        Thu, 04 Dec 2025 07:08:32 -0800 (PST)
Received: from ?IPV6:2001:ee0:4f4c:210:c2bc:6984:75c5:9339? ([2001:ee0:4f4c:210:c2bc:6984:75c5:9339])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bf686b3b5a9sm2145622a12.9.2025.12.04.07.08.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Dec 2025 07:08:32 -0800 (PST)
Message-ID: <eabd665c-b14d-4281-9307-2348791d3a77@gmail.com>
Date: Thu, 4 Dec 2025 22:08:25 +0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] virtio_net: gate delayed refill scheduling
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org
References: <40af2b73239850e7bf1a81abb71ee99f1b563b9c.1764226734.git.mst@redhat.com>
 <a61dc7ee-d00b-41b4-b6fd-8a5152c3eae3@gmail.com>
 <CACGkMEuJFVUDQ7SKt93mCVkbDHxK+A74Bs9URpdGR+0mtjxmAg@mail.gmail.com>
 <a9718b11-76d5-4228-9256-6a4dee90c302@gmail.com>
 <CACGkMEvFzYiRNxMdJ9xNPcZmotY-9pD+bfF4BD5z+HnaAt1zug@mail.gmail.com>
 <faad67c7-8b25-4516-ab37-3b154ee4d0cf@gmail.com>
 <CACGkMEtpARauj6GSZu+iY3Lx=c+rq_C019r4E-eisx2mujB6=A@mail.gmail.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <CACGkMEtpARauj6GSZu+iY3Lx=c+rq_C019r4E-eisx2mujB6=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/3/25 13:37, Jason Wang wrote:
> On Tue, Dec 2, 2025 at 11:29 PM Bui Quang Minh <minhquangbui99@gmail.com> wrote:
>> On 12/2/25 13:03, Jason Wang wrote:
>>> On Mon, Dec 1, 2025 at 11:04 PM Bui Quang Minh <minhquangbui99@gmail.com> wrote:
>>>> On 11/28/25 09:20, Jason Wang wrote:
>>>>> On Fri, Nov 28, 2025 at 1:47 AM Bui Quang Minh <minhquangbui99@gmail.com> wrote:
>>>>>> I think the the requeue in refill_work is not the problem here. In
>>>>>> virtnet_rx_pause[_all](), we use cancel_work_sync() which is safe to
>>>>>> use "even if the work re-queues itself". AFAICS, cancel_work_sync()
>>>>>> will disable work -> flush work -> enable again. So if the work requeue
>>>>>> itself in flush work, the requeue will fail because the work is already
>>>>>> disabled.
>>>>> Right.
>>>>>
>>>>>> I think what triggers the deadlock here is a bug in
>>>>>> virtnet_rx_resume_all(). virtnet_rx_resume_all() calls to
>>>>>> __virtnet_rx_resume() which calls napi_enable() and may schedule
>>>>>> refill. It schedules the refill work right after napi_enable the first
>>>>>> receive queue. The correct way must be napi_enable all receive queues
>>>>>> before scheduling refill work.
>>>>> So what you meant is that the napi_disable() is called for a queue
>>>>> whose NAPI has been disabled?
>>>>>
>>>>> cpu0] enable_delayed_refill()
>>>>> cpu0] napi_enable(queue0)
>>>>> cpu0] schedule_delayed_work(&vi->refill)
>>>>> cpu1] napi_disable(queue0)
>>>>> cpu1] napi_enable(queue0)
>>>>> cpu1] napi_disable(queue1)
>>>>>
>>>>> In this case cpu1 waits forever while holding the netdev lock. This
>>>>> looks like a bug since the netdev_lock 413f0271f3966 ("net: protect
>>>>> NAPI enablement with netdev_lock()")?
>>>> Yes, I've tried to fix it in 4bc12818b363 ("virtio-net: disable delayed
>>>> refill when pausing rx"), but it has flaws.
>>> I wonder if a simplified version is just restoring the behaviour
>>> before 413f0271f3966 by using napi_enable_locked() but maybe I miss
>>> something.
>> As far as I understand, before 413f0271f3966 ("net: protect NAPI
>> enablement with netdev_lock()"), the napi is protected by the
> I guess you meant napi enable/disable actually.
>
>> rtnl_lock(). But in the refill_work, we don't acquire the rtnl_lock(),
> Any reason we need to hold rtnl_lock() there?

Correct me if I'm wrong here. Before 413f0271f3966 ("net: protect NAPI 
enablement with netdev_lock()"), napi_disable and napi_enable are not 
safe to be called concurrently.

The example race is

napi_disable -> napi_save_config -> write to n->config->defer_hard_irqs
napi_enable -> napi_restore_config -> read n->config->defer_hard_irqs

In refill_work, we don't hold any locks so the race scenario can happen.

Maybe I misunderstand what you mean by restoring the behavior before 
413f0271f3966. Do you mean that we use this pattern

     In virtnet_xdp_se;

     netdev_lock(dev);
     virtnet_rx_pause_all()
         -> napi_disable_locked

     virtnet_rx_resume_all()
         -> napi_disable_locked
     netdev_unlock(dev);

And in other places where we pause the rx too. It will hold the 
netdev_lock during the time napi is disabled so that even when 
refill_work happens concurrently, napi_disable cannot acquire the 
netdev_lock and gets stuck inside.


>
>> so it seems like we will have race condition before 413f0271f3966 ("net:
>> protect NAPI enablement with netdev_lock()").
>>
>> Thanks,
>> Quang Minh.
>>
> Thanks
>

Thanks,
Quang Minh.

