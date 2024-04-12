Return-Path: <netdev+bounces-87222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A9F8A22F7
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 02:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6004288DF5
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 00:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22205360;
	Fri, 12 Apr 2024 00:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="D5zLuyKv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEFD195
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 00:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712881572; cv=none; b=cxyBRVcsw6/1sBHpLHpOKknnN2qGDXrcZMAMsL31P/dLeZfFejruARcWAqzyLR0/c7P1nbhlbD9IoG6oqJZRrwFJnJ8BwEOX35LEPa4G48lYI4XRy9+yitRWAFkDjW1IXxxVGn8qEWHpSL3tt4f35Kw/xyZXQ4iCavsq8eDC3Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712881572; c=relaxed/simple;
	bh=6t5oKGgd72X+8yCxr6UXxdWJXM7jQ4DJY/zZP9ekd5s=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=i0duSlfAbUqKcdu9QPJgMJ/XyQvmQpPmxV9cTRqoFgEblvNo41e9o65yHUvWhck7B3MKHF0MvZdfghKhTyYCiX3+WA7inuB2GZD1KffEUhnhpDLw+MOLsnpRe2q+yzkrjhDjzXKpPHYnKdg+LKiuATDKwm4oEuzYEe8ljXL3Ld0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=D5zLuyKv; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5aa25e99414so272829eaf.3
        for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 17:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1712881568; x=1713486368; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=reTf0+DHsDK7dcQvol/MU7kiUECvdoLTRe9igBGf5Iw=;
        b=D5zLuyKvIWCzarnH18+xf37o3dXozmv2xxJeW33mVLAiTZbgKUUmSGWmchC1/bfDcs
         1YJY2RDOslc8IiLsh1laUcM6zGSsc0wkaMugq3y22zsbky3k+Co8HmntLjyKCXhrGDzl
         4CLM5JFEIbrcP600NHNiIc1JEy7Mk/dIMs3/CDOfyDOyirwnyKdofZ2SuUzDaF4CA7ga
         MB8n7z4gj74Xnw9t8qokBMNHiKHIGYth1lyOxzI/p6PzbhiWoc9zpYyZU9ktfH7F98Cy
         FXpAhlveNG4afvsEuZRSFfzZttEjyWXCTRbViZBEBIeJDD4CH/FsCpkuh9kEddEQYg/B
         +npw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712881568; x=1713486368;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=reTf0+DHsDK7dcQvol/MU7kiUECvdoLTRe9igBGf5Iw=;
        b=RPdwWwchoW+X/dKtYNoRliTACjBI6Y623Qecq4BpY9NmeHm1jW4XcrSalktTrKcHwz
         CPeOI8VoZuad8wp633FqQEiI9TNvLRmPFyuyWuPh5OPKGak8rLowkxFCosGOtT2vFw/9
         hnqtLoMeFjL+6AHljPpKJZH6hg8Vnw4KD+KPFSQuFTztUA4XAuc0aJi8fp9wT+PxZf4Z
         3pxLigRhL2bGtpl9PQ59FQ/YbFZYPRNwWRWqdmencdZyAMgXXFSovXZXasRpNGdDNLUM
         sj++0CIHcRr2l0ea0yE5/o5VofOGvY0zudqf6N5JK8GXu/ibJ4rQw2f4uTgRm8/o6Tzk
         GYWw==
X-Gm-Message-State: AOJu0YxfRGQHb86QKD3YnbHqFLutcSK/M0MJCk4kPbzC1GgmOtFd1xje
	//wjBlqWXXshobW5D0WwT/ZAZ1J14hKXCenhF5FSfa8rLUubMrDnPlXhFnLdkUAZuIlj6+mAqiF
	H
X-Google-Smtp-Source: AGHT+IEBVxREWfPHt8nakKoCNpKRBFiQXt7a9w0XzzWjLKR871xxXHiJPQDT9bjaY2rD5B4s30OPxw==
X-Received: by 2002:a05:6870:214e:b0:22e:a686:a943 with SMTP id g14-20020a056870214e00b0022ea686a943mr1026342oae.31.1712881567728;
        Thu, 11 Apr 2024 17:26:07 -0700 (PDT)
Received: from [10.73.215.90] ([208.184.112.130])
        by smtp.gmail.com with ESMTPSA id hj14-20020a056870c90e00b00233a6abb24dsm191547oab.1.2024.04.11.17.26.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 17:26:07 -0700 (PDT)
Message-ID: <0ac5752d-0b36-436a-9c37-13e262334dce@bytedance.com>
Date: Thu, 11 Apr 2024 17:26:06 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Zijian Zhang <zijianzhang@bytedance.com>
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
Content-Language: en-US
In-Reply-To: <66171b8b595b_2d123b29472@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/10/24 4:06 PM, Willem de Bruijn wrote:
>>>>> In this case, for some reason, notifications do not
>>>>> come in order now. We introduce "cfg_notification_order_check" to
>>>>> possibly ignore the checking for order.
>>>>
>>>> Were you testing UDP?
>>>>
>>>> I don't think this is needed. I wonder what you were doing to see
>>>> enough of these events to want to suppress the log output.
>>
>> I tested again on both TCP and UDP just now, and it happened to both of
>> them. For tcp test, too many printfs will delay the sending and thus
>> affect the throughput.
>>
>> ipv4 tcp -z -t 1
>> gap: 277..277 does not append to 276
> 
> There is something wrong here. 277 clearly appends to 276
> 

```
if (lo != next_completion)
     fprintf(stderr, "gap: %u..%u does not append to %u\n",
         lo, hi, next_completion);
```

According to the code, it expects the lo to be 276, but it's 277.

>> gap: 276..276 does not append to 278
> 
> This would be an actual reordering. But the above line already
> indicates that 276 is the next expected value.
> 
>> gap: 278..1112 does not append to 277
>> gap: 1114..1114 does not append to 1113
>> gap: 1113..1113 does not append to 1115
>> gap: 1115..2330 does not append to 1114
>> gap: 2332..2332 does not append to 2331
>> gap: 2331..2331 does not append to 2333
>> gap: 2333..2559 does not append to 2332
>> gap: 2562..2562 does not append to 2560
>> ...
>> gap: 25841..25841 does not append to 25843
>> gap: 25843..25997 does not append to 25842
>>
>> ...
>>
>> ipv6 udp -z -t 1
>> gap: 11632..11687 does not append to 11625
>> gap: 11625..11631 does not append to 11688
>> gap: 11688..54662 does not append to 11632
> 
> If you ran this on a kernel with a variety of changes, please repeat
> this on a clean kernel with no other changes besides the
> skb_orphan_frags_rx loopback change.
> 
> It this is a real issue, I don't mind moving this behind cfg_verbose.
> And prefer that approach over adding a new flag.
> 
> But I have never seen this before, and this kind of reordering is rare
> with UDP and should not happen with TCP except for really edge cases:
> the uarg is released only when both the skb was delivered and the ACK
> response was received to free the clone on the retransmit queue.

I found the set up where I encountered the OOM problem in msg_zerocopy
selftest. I did it on a clean kernel vm booted by qemu, 
dfa2f0483360("tcp: get rid of sysctl_tcp_adv_win_scale") with only
skb_orphan_frags_rx change.

Then, I do `make olddefconfig` and turn on some configurations for
virtualization like VIRTIO_FS, VIRTIO_NET and some confs like 9P_FS
to share folders. Let's call it config, here was the result I got,
```
./msg_zerocopy.sh
ipv4 tcp -z -t 1
./msg_zerocopy: send: No buffer space available
rx=564 (70 MB)
```

Since the TCP socket is always writable, the do_poll always return True.
There is no any chance for `do_recv_completions` to run.
```
while (!do_poll(fd, POLLOUT)) {
     if (cfg_zerocopy)
         do_recv_completions(fd, domain);
     }
```
Finally, the size of sendmsg zerocopy notification skbs exceeds the 
opt_mem limit. I got "No buffer space available".


However, if I change the config by
```
  DEBUG_IRQFLAGS n -> y
  DEBUG_LOCK_ALLOC n -> y
  DEBUG_MUTEXES n -> y
  DEBUG_RT_MUTEXES n -> y
  DEBUG_RWSEMS n -> y
  DEBUG_SPINLOCK n -> y
  DEBUG_WW_MUTEX_SLOWPATH n -> y
  PROVE_LOCKING n -> y
+DEBUG_LOCKDEP y
+LOCKDEP y
+LOCKDEP_BITS 15
+LOCKDEP_CHAINS_BITS 16
+LOCKDEP_CIRCULAR_QUEUE_BITS 12
+LOCKDEP_STACK_TRACE_BITS 19
+LOCKDEP_STACK_TRACE_HASH_BITS 14
+PREEMPTIRQ_TRACEPOINTS y
+PROVE_RAW_LOCK_NESTING n
+PROVE_RCU y
+TRACE_IRQFLAGS y
+TRACE_IRQFLAGS_NMI y
```

Let's call it config-debug, the selftest works well with reordered
notifications.
```
ipv4 tcp -z -t 1
gap: 2117..2117 does not append to 2115
gap: 2115..2116 does not append to 2118
gap: 2118..3144 does not append to 2117
gap: 3146..3146 does not append to 3145
gap: 3145..3145 does not append to 3147
gap: 3147..3768 does not append to 3146
...
gap: 34935..34935 does not append to 34937
gap: 34938..36409 does not append to 34936

rx=36097 (2272 MB)
missing notifications: 36410 < 36412
tx=36412 (2272 MB) txc=36410 zc=y
```
For exact config to compile the kernel, please see
https://github.com/Sm0ckingBird/config


I also did selftest on 63c8778d9149("Merge branch 
'net-mana-fix-doorbell-access-for-receive-queues'"), the parent of 
dfa2f0483360("tcp: get rid of sysctl_tcp_adv_win_scale")

with config, selftest works well.
```
ipv4 tcp -z -t 1
missing notifications: 223181 < 223188
tx=223188 (13927 MB) txc=223181 zc=y
rx=111592 (13927 MB)
```

with config-debug, selftest works well with reordered notifications
```
ipv4 tcp -z -t 1
...
gap: 30397..30404 does not append to 30389
gap: 30435..30442 does not append to 30427
gap: 30427..30434 does not append to 30443
gap: 30443..30450 does not append to 30435
gap: 30473..30480 does not append to 30465
gap: 30465..30472 does not append to 30481
gap: 30481..30488 does not append to 30473
tx=30491 (1902 MB) txc=30491 zc=y
rx=15245 (1902 MB)
```

Not sure about the exact reason for this OOM problem, and why
turning on DEBUG_LOCKDEP and PROVE_RAW_LOCK_NESTING can solve
the problem with reordered notifications... If you have any thoughts or
comments, please feel free to share them with us.

If the problem does exist, I guess we can force `do_recv_completions`
after some number of sendmsgs and move "gap: ..." after cfg_verbose?

