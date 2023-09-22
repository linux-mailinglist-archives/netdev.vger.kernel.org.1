Return-Path: <netdev+bounces-35731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4C77AACC2
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 10:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 4A8F5B209C7
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 08:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2364C9CA43;
	Fri, 22 Sep 2023 08:36:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A3C642
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 08:36:16 +0000 (UTC)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D146283
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 01:36:15 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68bed2c786eso1701446b3a.0
        for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 01:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1695371775; x=1695976575; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RICN8tort+CWLhQVSIa56+kaySuy9xkNGnfuP8kUQqc=;
        b=ai9yrCLfMgYecX1TwSjw1MSxfZ+DTTw9hIpklIUEzd9HwAEZwDRRhdonxBnuj9mCSf
         6yYHNUFLOOmvwL2gtoRTzlRQyAFkdEw7Qs//kym4jZC+oNCt4GqF9SZD+weCsbpay59I
         JNUnWpn72CeAZksLhCaRHiroAJi2Ej2HcGBY7zT/uE+ewxi2aPvbO4OXwXR7BA/ngyF4
         EbyJwZhsP3SZo16GTeCWYLfFivM9snZ1654VapK7vL95EXIJNWnA5bpL91XcG+z5hAPN
         K/ZGfp2YKsDcza//zlI0yKhvR039lVl7eZwGyEtKRDG3ESKIY5W22Io/t5ijpXqOtIFv
         GaTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695371775; x=1695976575;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RICN8tort+CWLhQVSIa56+kaySuy9xkNGnfuP8kUQqc=;
        b=PIW/XGaUt8DoBGqrIR5o9B7ZNqjgnU5/D2tGnuOhX4PaVVgRItVZ5WJmxPS6bCgLh3
         pN4GaW91aGV7te3EhAVCs5Ses9+TO0h/US276w0mJKUrJsi1Ix47mUevo+ItuqaeC894
         hexm7bMDWl6lKd0ySyobXIORY4xuD70AMoUQNhSU0ke4f64sp2FLNo3h88+wxQx3YzXF
         aLaYyZ6lw8mSVpZYQmmn8xI7psnRf1DOv6LjXSTx6KSgYyebZVLSieufEIxSYTaG0ciS
         Y18B6VXJvYlfYLnpXbP8oknZSAeYbSDR8NaWJ0TxkmMXI5rR6pXdLI/MpzIDMz6Ag+8N
         I5lg==
X-Gm-Message-State: AOJu0Yz7eJiiwQZgwMhPRXI/bmLf+pyC3E0jMrZjjuJgwq7uICuEaQDS
	wRW9adW7N1LJEU9FnHrQ5+1Jmg==
X-Google-Smtp-Source: AGHT+IHQicYWUr71AoSVKdMJTN6JBrukXsgFBu6GSXWiWDNZ+lmpI706oyztJpAziLn93L03VpRJ3g==
X-Received: by 2002:a05:6a20:9187:b0:15a:2d98:bc81 with SMTP id v7-20020a056a20918700b0015a2d98bc81mr8767748pzd.53.1695371775244;
        Fri, 22 Sep 2023 01:36:15 -0700 (PDT)
Received: from [10.254.1.169] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id z1-20020a170902708100b001bb0eebd90asm2860013plk.245.2023.09.22.01.36.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Sep 2023 01:36:14 -0700 (PDT)
Message-ID: <82c0a442-c7d7-d0f1-54de-7a5e7e6a31d5@bytedance.com>
Date: Fri, 22 Sep 2023 16:36:04 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: Re: [PATCH net-next 2/2] sock: Fix improper heuristic on raising
 memory
To: Shakeel Butt <shakeelb@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
 Breno Leitao <leitao@debian.org>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 David Howells <dhowells@redhat.com>, Jason Xing <kernelxing@tencent.com>,
 Xin Long <lucien.xin@gmail.com>,
 KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujtsu.com>,
 "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20230920132545.56834-1-wuyun.abel@bytedance.com>
 <20230920132545.56834-2-wuyun.abel@bytedance.com>
 <20230921190156.s4oygohw4hud42tx@google.com>
Content-Language: en-US
From: Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20230921190156.s4oygohw4hud42tx@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/22/23 3:01 AM, Shakeel Butt wrote:
> On Wed, Sep 20, 2023 at 09:25:41PM +0800, Abel Wu wrote:
>> Before sockets became aware of net-memcg's memory pressure since
>> commit e1aab161e013 ("socket: initial cgroup code."), the memory
>> usage would be granted to raise if below average even when under
>> protocol's pressure. This provides fairness among the sockets of
>> same protocol.
>>
>> That commit changes this because the heuristic will also be
>> effective when only memcg is under pressure which makes no sense.
>> Fix this by skipping this heuristic when under memcg pressure.
>>
>> Fixes: e1aab161e013 ("socket: initial cgroup code.")
>> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
>> ---
>>   net/core/sock.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/core/sock.c b/net/core/sock.c
>> index 379eb8b65562..ef5cf6250f17 100644
>> --- a/net/core/sock.c
>> +++ b/net/core/sock.c
>> @@ -3093,8 +3093,16 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
>>   	if (sk_has_memory_pressure(sk)) {
>>   		u64 alloc;
>>   
>> -		if (!sk_under_memory_pressure(sk))
>> +		if (memcg && mem_cgroup_under_socket_pressure(memcg))
>> +			goto suppress_allocation;
>> +
>> +		if (!sk_under_global_memory_pressure(sk))
>>   			return 1;
> 
> I am onboard with replacing sk_under_memory_pressure() with
> sk_under_global_memory_pressure(). However suppressing on memcg pressure
> is a behavior change from status quo and need more thought and testing.
> 
> I think there are three options for this hunk:
> 
> 1. proposed patch
> 2. Consider memcg pressure only for !in_softirq().
> 3. Don't consider memcg pressure at all.
> 
> All three options are behavior change from the status quo but with
> different risk levels. (1) may reintroduce the regression fixed by
> 720ca52bcef22 ("net-memcg: avoid stalls when under memory pressure").

Just for the record, it is same for the current upstream implementation
if the socket reaches average usage. Taking option 2 will fix this too.

> (2) is more inlined with 720ca52bcef22. (3) has the risk to making memcg
> limits ineffective.
> 
> IMHO we should go with (2) as there is already a precedence in
> 720ca52bcef22.

Yes, I agree. Actually applying option(2) would make this patch quite
similar to the previous version[a], except the below part:

  	/* Under limit. */
  	if (allocated <= sk_prot_mem_limits(sk, 0)) {
  		sk_leave_memory_pressure(sk);
-		return 1;
+		if (!under_memcg_pressure)
+			return 1;
  	}

My original thought is to inherit the behavior of tcpmem pressure.
There are also 3 levels of memcg pressure named low/medium/critical,
but considering that the 'low' level is too much conservative for
socket allocation, I made the following match:

	PROTOCOL	MEMCG		ACTION
	-----------------------------------------------------
	low		<medium		allow allocation
	pressure	medium		be more conservative
	high		critical	throttle

which also seems align with the design[b] of memcg pressure. Anyway
I will take option (2) and post v2.

Thanks & Best,
	Abel

[a] 
https://lore.kernel.org/lkml/20230901062141.51972-4-wuyun.abel@bytedance.com/
[b] 
https://docs.kernel.org/admin-guide/cgroup-v1/memory.html#memory-pressure

