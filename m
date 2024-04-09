Return-Path: <netdev+bounces-86331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F7589E684
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 01:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23E93B2159D
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 23:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815F91591FB;
	Tue,  9 Apr 2024 23:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="DiVP35/4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A754158DDE
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 23:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712707125; cv=none; b=ucemI9/kF7wwvMdOjPuG0Eiso6Iupfo3LPLd5d3gimody1dvoe8VNhNHIwSPxJ2+BoXevnZInZ9bAQu0Tx3vWAeWbjiahwDfE0ni9mVIaEfqKUavlFUAj8xG0ljY9QJEQbmhlWDTGhQPHstw9752ojFl1vfzjPrdS9PDPX4dWaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712707125; c=relaxed/simple;
	bh=7AbboQ/gnipe6E4c5lP4y5/BsV1xNOxEcCoCNJBcSiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=txAb2dn2tFfEh5w1edOIEOII3janyAqWzpvJGtD3MDgb+KuZvQ8eudrAJarFxrn3stN3mg/9ONU9qjmLZCNi41/N58tdyFdaKSDfgwjnf15SnI7mFqV0GmnRRxowppLysYEYAGFyqbq8TiShjzJXnVecy3+Wk5TDOT/OMwEOFFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=DiVP35/4; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-22a5df0f789so2803505fac.3
        for <netdev@vger.kernel.org>; Tue, 09 Apr 2024 16:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1712707122; x=1713311922; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V1mSJ72qscIqUozY8eEI2EOxydrgadKrbvKIcUCP0Zc=;
        b=DiVP35/4NehE9gYY6S0eDJIU0QjEBjLvNKgJ/7AmebfttfsPs/Whtwv6F4akbBk68Y
         sRMtfIlivPCvNyfUwlATIWkFzPz0SMOLuO5wbc9NYL6As1l5BbzcNyDA9fJdQzOag/6A
         Mvtknmr4+hAjageGGrnRzBda0igLl9/+qwlmjSmkPnjh3gQJ+qUYpcSP7d4LCaBza30b
         xo7pMBjy6tsYDgrM1xlE3Fv2pPpNzZBPLM1QQx/wm2ewnUAJCDIlF496OqZAsPZZl4eg
         lQtYlJSMS1xew/zxqv4Z4bJCdORsB1RxmE3ZWkW39HD+cbjMTFxCi8N9Bir3GK2EDF13
         OhXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712707122; x=1713311922;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V1mSJ72qscIqUozY8eEI2EOxydrgadKrbvKIcUCP0Zc=;
        b=KTa1LvhqVEPOR8hGCGLLTIhxv+kGgB76DYV7u5Vjsvc11r0s6OA4bOotejoru2iQuN
         fpnrr6fyy8JANyrh/SfzKALz4Kh0u05hojgvrtKK+0jzBxtkf2QlLEevqJmE4JxLHoFZ
         mxSaHHYgkaI4Um3khh9fIC56VcPy2OIOjZsDoQcYaSE7wbNRTVgFWQPkp8zcjkGKLVUY
         MoJoYKG4XNqULdQefdDbKwC3vJgvDwWB2c1YPMPcBinpKLtsqsnjI+3gjZuHwz78fW3O
         P6GA7Bue21XprgymENLuOvJj/+dphqQW7gwlANoiDXgfmNjRT2Oqx88yJJojaXaAUWXP
         OQmA==
X-Gm-Message-State: AOJu0YxLlM0vyxwCC3ByerX+tnQ/b0AF2xlsXmBqwgT5Ov9rrzWB6Wkv
	jnrf2QvcOt9X4nCJMAnAtGBXM+aXpxWVCmdmXaL2JpMUXwRwcLHlhvAfh3UJvv4=
X-Google-Smtp-Source: AGHT+IFxrXmmdLb2pnzinMo7TBLvBB//rBCnNuDDEAYsNLgkS2mMVozxd9nd9lrkC8Dt+oeS43LEZw==
X-Received: by 2002:a05:6870:390c:b0:22e:c925:a4b0 with SMTP id b12-20020a056870390c00b0022ec925a4b0mr1184258oap.42.1712707122265;
        Tue, 09 Apr 2024 16:58:42 -0700 (PDT)
Received: from [10.73.215.90] ([72.29.204.230])
        by smtp.gmail.com with ESMTPSA id he8-20020a056870798800b0022e1fb24440sm2820819oab.10.2024.04.09.16.58.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 16:58:41 -0700 (PDT)
Message-ID: <0c6fc173-45c4-463f-bc0e-9fed8c3efc02@bytedance.com>
Date: Tue, 9 Apr 2024 16:57:23 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH net-next 2/3] selftests: fix OOM problem in
 msg_zerocopy selftest
To: Eric Dumazet <edumazet@google.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 cong.wang@bytedance.com, xiaochun.lu@bytedance.com
References: <20240409205300.1346681-1-zijianzhang@bytedance.com>
 <20240409205300.1346681-3-zijianzhang@bytedance.com>
 <6615b264894a0_24a51429432@willemb.c.googlers.com.notmuch>
 <CANn89iLTiq-29ceiQHc2Mi4na+kRb9K-MA1hGMn=G0ek6-mfjQ@mail.gmail.com>
Content-Language: en-US
From: Zijian Zhang <zijianzhang@bytedance.com>
In-Reply-To: <CANn89iLTiq-29ceiQHc2Mi4na+kRb9K-MA1hGMn=G0ek6-mfjQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Firstly, thanks for your time and quick reply!

On 4/9/24 2:30 PM, Eric Dumazet wrote:
> On Tue, Apr 9, 2024 at 11:25 PM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
>>
>> zijianzhang@ wrote:
>>> From: Zijian Zhang <zijianzhang@bytedance.com>
>>>
>>> In selftests/net/msg_zerocopy.c, it has a while loop keeps calling sendmsg
>>> on a socket, and it will recv the completion notifications when the socket
>>> is not writable. Typically, it will start the receiving process after
>>> around 30+ sendmsgs.
>>>
>>> However, because of the commit dfa2f0483360
>>> ("tcp: get rid of sysctl_tcp_adv_win_scale"), the sender is always writable
>>> and does not get any chance to run recv notifications. The selftest always
>>> exits with OUT_OF_MEMORY because the memory used by opt_skb exceeds
>>> the core.sysctl_optmem_max. We introduce "cfg_notification_limit" to
>>> force sender to receive notifications after some number of sendmsgs.
>>
>> No need for a new option. Existing test automation will not enable
>> that.
>>
>> I have not observed this behavior in tests (so I wonder what is
>> different about the setups). But it is fine to unconditionally force
>> a call to do_recv_completions every few sends.
> 
> Maybe their kernel does not have yet :
> 
> commit 4944566706b27918ca15eda913889db296792415    net: increase
> optmem_max default value
> 
> ???
> 

I did the selftest on a qemu vm with linux repo v6.8-rc3 kernel.
It should have the commit 4944566706b2 ("net: increase optmem_max
default value")

"
qemu-system-x86_64 \
     -enable-kvm \
     -nographic \
     -drive file=$HOME/guest.qcow2,if=virtio \
     -device vfio-pci,host=3b:00.2,multifunction=on \
     -m 32G \
     -smp 16 \
     -kernel $HOME/linux-master/arch/x86/boot/bzImage \
     -append 'root=/dev/vda1 console=ttyS0 earlyprintk=ttyS0 
net.ifnames=0 biosdevname=0'
"

I did it again just now with a clean image, and there was no problem...
Unfortunately, I did not save the image I tested before, I will give you
more information about my network configuration if I could restore it.

Thus, it is not a BUG, but a problem due to my custom conf, sorry about 
this, I will delete this patch in the next version.

>>
>>> Plus,
>>> in the selftest, we need to update skb_orphan_frags_rx to be the same as
>>> skb_orphan_frags.
>>
>> To be able to test over loopback, I suppose?
>>

Yes.

>>> In this case, for some reason, notifications do not
>>> come in order now. We introduce "cfg_notification_order_check" to
>>> possibly ignore the checking for order.
>>
>> Were you testing UDP?
>>
>> I don't think this is needed. I wonder what you were doing to see
>> enough of these events to want to suppress the log output.

I tested again on both TCP and UDP just now, and it happened to both of 
them. For tcp test, too many printfs will delay the sending and thus 
affect the throughput.

ipv4 tcp -z -t 1
gap: 277..277 does not append to 276
gap: 276..276 does not append to 278
gap: 278..1112 does not append to 277
gap: 1114..1114 does not append to 1113
gap: 1113..1113 does not append to 1115
gap: 1115..2330 does not append to 1114
gap: 2332..2332 does not append to 2331
gap: 2331..2331 does not append to 2333
gap: 2333..2559 does not append to 2332
gap: 2562..2562 does not append to 2560
...
gap: 25841..25841 does not append to 25843
gap: 25843..25997 does not append to 25842

...

ipv6 udp -z -t 1
gap: 11632..11687 does not append to 11625
gap: 11625..11631 does not append to 11688
gap: 11688..54662 does not append to 11632

