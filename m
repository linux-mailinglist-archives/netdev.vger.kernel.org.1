Return-Path: <netdev+bounces-87519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AB18A3613
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 20:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11F011F237C1
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 18:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1BF14EC60;
	Fri, 12 Apr 2024 18:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="en8Rn3yk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A566A23778
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 18:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712948383; cv=none; b=GJw1Wi0lo2nzg0cjrnGWhL2AE4NP9aMaTk44k1B3uzdJTT90y5hEh+k2DGcNANNmcFCIiM3ozjV0wMQ/IxNmMq4g/04Jep7v1YEPTTu1rRd2IZPRvCCQ4/GpyZpbCYto44mBXoYBd4lI8rd9VrOPK9vZ7e5ctjeBlAD/QBZOe8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712948383; c=relaxed/simple;
	bh=XgMsC4RKRDE6R6g/ghDEHHySIhOTu+QETvWopYW/dBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZfG9LdTzj7GnIP+63PmGBXl4tA46WV7tY2YITiTdv9jYqB7opSRRHIXLpqAJ9sOmvV/UoODn92ve61IxZsSFduESieKmeZTTh0B4kaU85I1baSfVsa57HATRyDZrtQhy1K/LNCnnfrbwxtaxcrXYubfdG7aneBDQzGpDz+R5voo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=en8Rn3yk; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5a9ec68784cso670176eaf.2
        for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 11:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1712948381; x=1713553181; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n8ObryqrhtjTQeSVSFRYZKDmL6GQ8TuuFlxTZALzzzU=;
        b=en8Rn3ykAd2qRWTk65vF8d7nGY/aWajWG/SrIAHkkgIzrQ15Ay0iF9v+z4yNozkUXQ
         MXnbEbo8cEX8xX9Gawwxdn3W34L8R6k8xIcGDnN07UBQ6BG/bqNo6ZbPvkXiyiA0lU3t
         x/clWkkKxpWLC9FDW2IA6YKIZ/BHqYZPaexGVckbrn8luzkaHlu73DsTaiNfpkRjczUy
         PwK1WZ13875XxIs8y/UgsgIeHCLGQqS0R5zjyYY1gGTxHd05Bv4FJMkRKzzwwfdgMs60
         8tozE2PASOmwSaJzhezRlyGcNuOTOf9GCJjxzLuvo+knvX1kt5NymYMEmFjc2WMRJgpb
         qLpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712948381; x=1713553181;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n8ObryqrhtjTQeSVSFRYZKDmL6GQ8TuuFlxTZALzzzU=;
        b=pHf5Vud9LDSiulKH6I3AMaha4L+WbaKtCI67rtqIA29MME8bzJDhDohMpCsonKzv4Q
         +54BplApvQ0RWVE60K7QNOi1AYhlBhvyttzsVKY6YXbmTV3P9xbeaApe+9w7r8rINLal
         JbXjFpX/loUQe9MBgLZc5dhAApSqJapTUQ0+dTcNNpOS50/3MB0Qvfcb4EWDbMhIWfp2
         sH69vIFXVhefGqpak6zqnIrwgWRzrkUhAtTeuIvyVr6ochBs2ISwjL2saE0xuWax+9jO
         UpHK7CVtt0QRNdvsvIAQgu4oYOeYRH2KTokl6GMbh8gj+oQpRieTUlUv09ieGO1ZExTJ
         gFng==
X-Gm-Message-State: AOJu0YwcloO27Rs/KPBqwSwoF5JVQE6lgvCiFvxNdWjayK7Y+aphjMdL
	FpHL3Uo6KyRlST1JoqHNS/Dsw7SupcT6rpvl6B5CryoZuZUPq0jpaahG1zRikgA=
X-Google-Smtp-Source: AGHT+IGYBy+1bCocRcBusy9YSugPUHYa2Ne/gpb3LH1Wuz/de+Ht8PIjdJAWBJ7/Rt1QDDSYwHvlJQ==
X-Received: by 2002:a05:6820:98a:b0:5aa:596c:52d0 with SMTP id cg10-20020a056820098a00b005aa596c52d0mr3733922oob.6.1712948380610;
        Fri, 12 Apr 2024 11:59:40 -0700 (PDT)
Received: from [10.73.215.90] ([208.184.112.130])
        by smtp.gmail.com with ESMTPSA id bq6-20020a0568201a0600b005a22f8ae2dfsm875735oob.34.2024.04.12.11.59.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 11:59:40 -0700 (PDT)
Message-ID: <13cdc078-770f-4083-826f-89d13b13140d@bytedance.com>
Date: Fri, 12 Apr 2024 11:58:23 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH net-next 2/3] selftests: fix OOM problem in
 msg_zerocopy selftest
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 cong.wang@bytedance.com, xiaochun.lu@bytedance.com
References: <20240409205300.1346681-1-zijianzhang@bytedance.com>
 <20240409205300.1346681-3-zijianzhang@bytedance.com>
 <6615b264894a0_24a51429432@willemb.c.googlers.com.notmuch>
 <CANn89iLTiq-29ceiQHc2Mi4na+kRb9K-MA1hGMn=G0ek6-mfjQ@mail.gmail.com>
 <0c6fc173-45c4-463f-bc0e-9fed8c3efc02@bytedance.com>
 <66171b8b595b_2d123b29472@willemb.c.googlers.com.notmuch>
 <0ac5752d-0b36-436a-9c37-13e262334dce@bytedance.com>
 <661954fce5f33_38e2532949f@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Zijian Zhang <zijianzhang@bytedance.com>
In-Reply-To: <661954fce5f33_38e2532949f@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/12/24 8:36 AM, Willem de Bruijn wrote:
> Zijian Zhang wrote:
>> On 4/10/24 4:06 PM, Willem de Bruijn wrote:
>>>>>>> In this case, for some reason, notifications do not
>>>>>>> come in order now. We introduce "cfg_notification_order_check" to
>>>>>>> possibly ignore the checking for order.
>>>>>>
>>>>>> Were you testing UDP?
>>>>>>
>>>>>> I don't think this is needed. I wonder what you were doing to see
>>>>>> enough of these events to want to suppress the log output.
>>>>
>>>> I tested again on both TCP and UDP just now, and it happened to both of
>>>> them. For tcp test, too many printfs will delay the sending and thus
>>>> affect the throughput.
>>>>
>>>> ipv4 tcp -z -t 1
>>>> gap: 277..277 does not append to 276
>>>
>>> There is something wrong here. 277 clearly appends to 276
>>>
>>
>> ```
>> if (lo != next_completion)
>>       fprintf(stderr, "gap: %u..%u does not append to %u\n",
>>           lo, hi, next_completion);
>> ```
>>
>> According to the code, it expects the lo to be 276, but it's 277.
> 
> Ack. I should have phrased that message better.
>   
>>> If you ran this on a kernel with a variety of changes, please repeat
>>> this on a clean kernel with no other changes besides the
>>> skb_orphan_frags_rx loopback change.
>>>
>>> It this is a real issue, I don't mind moving this behind cfg_verbose.
>>> And prefer that approach over adding a new flag.
>>>
>>> But I have never seen this before, and this kind of reordering is rare
>>> with UDP and should not happen with TCP except for really edge cases:
>>> the uarg is released only when both the skb was delivered and the ACK
>>> response was received to free the clone on the retransmit queue.
>>
>> I found the set up where I encountered the OOM problem in msg_zerocopy
>> selftest. I did it on a clean kernel vm booted by qemu,
>> dfa2f0483360("tcp: get rid of sysctl_tcp_adv_win_scale") with only
>> skb_orphan_frags_rx change.
>>
>> Then, I do `make olddefconfig` and turn on some configurations for
>> virtualization like VIRTIO_FS, VIRTIO_NET and some confs like 9P_FS
>> to share folders. Let's call it config, here was the result I got,
>> ```
>> ./msg_zerocopy.sh
>> ipv4 tcp -z -t 1
>> ./msg_zerocopy: send: No buffer space available
>> rx=564 (70 MB)
>> ```
>>
>> Since the TCP socket is always writable, the do_poll always return True.
>> There is no any chance for `do_recv_completions` to run.
>> ```
>> while (!do_poll(fd, POLLOUT)) {
>>       if (cfg_zerocopy)
>>           do_recv_completions(fd, domain);
>>       }
>> ```
>> Finally, the size of sendmsg zerocopy notification skbs exceeds the
>> opt_mem limit. I got "No buffer space available".
>>
>>
>> However, if I change the config by
>> ```
>>    DEBUG_IRQFLAGS n -> y
>>    DEBUG_LOCK_ALLOC n -> y
>>    DEBUG_MUTEXES n -> y
>>    DEBUG_RT_MUTEXES n -> y
>>    DEBUG_RWSEMS n -> y
>>    DEBUG_SPINLOCK n -> y
>>    DEBUG_WW_MUTEX_SLOWPATH n -> y
>>    PROVE_LOCKING n -> y
>> +DEBUG_LOCKDEP y
>> +LOCKDEP y
>> +LOCKDEP_BITS 15
>> +LOCKDEP_CHAINS_BITS 16
>> +LOCKDEP_CIRCULAR_QUEUE_BITS 12
>> +LOCKDEP_STACK_TRACE_BITS 19
>> +LOCKDEP_STACK_TRACE_HASH_BITS 14
>> +PREEMPTIRQ_TRACEPOINTS y
>> +PROVE_RAW_LOCK_NESTING n
>> +PROVE_RCU y
>> +TRACE_IRQFLAGS y
>> +TRACE_IRQFLAGS_NMI y
>> ```
>>
>> Let's call it config-debug, the selftest works well with reordered
>> notifications.
>> ```
>> ipv4 tcp -z -t 1
>> gap: 2117..2117 does not append to 2115
>> gap: 2115..2116 does not append to 2118
>> gap: 2118..3144 does not append to 2117
>> gap: 3146..3146 does not append to 3145
>> gap: 3145..3145 does not append to 3147
>> gap: 3147..3768 does not append to 3146
>> ...
>> gap: 34935..34935 does not append to 34937
>> gap: 34938..36409 does not append to 34936
>>
>> rx=36097 (2272 MB)
>> missing notifications: 36410 < 36412
>> tx=36412 (2272 MB) txc=36410 zc=y
>> ```
>> For exact config to compile the kernel, please see
>> https://github.com/Sm0ckingBird/config
> 
> Thanks for sharing the system configs. I'm quite surprised at these
> reorderings *over loopback* with these debug settings, and no weird
> qdiscs that would explain it. Can you see whether you see drops and
> retransmits?
> 

No drops and retransmits are observed.

```
ip netns exec ns-djROUw1 netstat -s

Tcp:
     1 active connection openings
     0 passive connection openings
     0 failed connection attempts
     1 connection resets received
     0 connections established
     16158 segments received
     32311 segments sent out
     0 segments retransmitted
     0 bad segments received
     0 resets sent

ip netns exec ns-djROUw1 ip -s link show veth0

2: veth0@if2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 65535 qdisc noqueue 
state UP mode DEFAULT group default qlen 1000
     link/ether 02:02:02:02:02:02 brd ff:ff:ff:ff:ff:ff link-netns 
ns-djROUw2
     RX: bytes  packets  errors  dropped overrun mcast
     1067646    16173    0       0       0       0
     TX: bytes  packets  errors  dropped carrier collsns
     2116207634 32325    0       0       0       0
```

>>
>> I also did selftest on 63c8778d9149("Merge branch
>> 'net-mana-fix-doorbell-access-for-receive-queues'"), the parent of
>> dfa2f0483360("tcp: get rid of sysctl_tcp_adv_win_scale")
>>
>> with config, selftest works well.
>> ```
>> ipv4 tcp -z -t 1
>> missing notifications: 223181 < 223188
>> tx=223188 (13927 MB) txc=223181 zc=y
>> rx=111592 (13927 MB)
>> ```
>>
>> with config-debug, selftest works well with reordered notifications
>> ```
>> ipv4 tcp -z -t 1
>> ...
>> gap: 30397..30404 does not append to 30389
>> gap: 30435..30442 does not append to 30427
>> gap: 30427..30434 does not append to 30443
>> gap: 30443..30450 does not append to 30435
>> gap: 30473..30480 does not append to 30465
>> gap: 30465..30472 does not append to 30481
>> gap: 30481..30488 does not append to 30473
>> tx=30491 (1902 MB) txc=30491 zc=y
>> rx=15245 (1902 MB)
>> ```
>>
>> Not sure about the exact reason for this OOM problem, and why
>> turning on DEBUG_LOCKDEP and PROVE_RAW_LOCK_NESTING can solve
>> the problem with reordered notifications...
> 
> The debug config causes the reordering notifications, right? But
> solves the OOM.
> 

With config, OOM is introduced by dfa2f0483360("tcp: get rid of
sysctl_tcp_adv_win_scale"). And, it can be solved by config-debug,
but reordering notifications are observed.

With config, there is no OOM in 63c8778d9149("Merge branch
'net-mana-fix-doorbell-access-for-receive-queues'"), everything works
well. But with config-debug, reordering notifications are observed.

>> If you have any thoughts or
>> comments, please feel free to share them with us.
>>
>> If the problem does exist, I guess we can force `do_recv_completions`
>> after some number of sendmsgs and move "gap: ..." after cfg_verbose?
> 
> I do want to understand the issue better. But not sure when I'll find
> the time.
> 

I also want to understand this, I will look into it when I find time :)

> Both sound reasonable to me, yes.
Thanks for the review and suggestions, I will update in the next iteration.

