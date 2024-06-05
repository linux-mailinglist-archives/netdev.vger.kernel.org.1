Return-Path: <netdev+bounces-100859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CA78FC4AE
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 09:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 440C01F22142
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 07:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C3218C331;
	Wed,  5 Jun 2024 07:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="kn5bhPLw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0E96A03F
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 07:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717573035; cv=none; b=JIQokKM5h7LzJXDnLvi86YPtrTxCS8JEPD+NXQQ4kxU+Xq35X4yQvS5iN5VHv4KBtFY7EdjYJpH+evZTKYrMo6jS5c++nzkycfdGD9GKSIBvvcsjqeXV1Ff+cVS/huhOOfPjpmFlnATWD4rnW5+Xr3N2LRGesxNZqIUNYBIGYUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717573035; c=relaxed/simple;
	bh=0bcrLTQX65w3+uAqgRwFhD9W+5+9d04Rnllfp2Q7OBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r+f/wqUy5p5jX4OabSFXW34v2Vw52QTl1erFppZIdyV2nEN1Xdvoa4NGwc2it0gw5A1bizzJ86NPfgCIP2A/Tla0RFv5tGr/dxfQ0vZmIBbm1lO+IX4M5Gn6A+VqQXLNC0Bmi3hxhowdpgTULnsuVl0JEj7DQ1c3BBV2biHRTzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=kn5bhPLw; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6f8ef63714cso4162312a34.1
        for <netdev@vger.kernel.org>; Wed, 05 Jun 2024 00:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1717573033; x=1718177833; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZPvDAH+YMalqInPfm8+iSZEqqgczyWUOtqvg5GoEtYE=;
        b=kn5bhPLw+5ax4LDVdlIBwEVbiI5Piwp6e4JTSEzHBMwUkgXwGWKMwavD/JVuudpyJf
         VvrJEmNWXalKvUHvidYPVXp/mYuyzRRBMgzPX9fAsIKsEIZ1eI3CvQ5JYGw5tGGqL3VH
         4H1zN4yYkGVQnYaLGZGmVyCw8XDmoOCleiZFR/Htj5LDm53ezR0+Mmh/+WwOOmElbZd6
         84K7Y/3XbpGfx7q92hO1XKt7iONYaL+OnDCwwOh4Sjhkq5S+48C0U8k13pTX/JQ6u/U6
         FFdP2qDRvl9e/XPmINcwTimDEE+T09HNPnXrE9LlsInOooz6pxNgn5zic89MLi8US5ap
         OUuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717573033; x=1718177833;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZPvDAH+YMalqInPfm8+iSZEqqgczyWUOtqvg5GoEtYE=;
        b=e8Z6wahMV9syfF/ODvH5fvImeqDES+B4fQDyFEesXtdaIeZ5K/fZSn3sxztYvojGSk
         Nq8mrXr0tDunDtkkb3MZRLyTTXu9l5pPEgs875FyJ9X8zxYotHwEbcIzD0k6Z7MI9RQ9
         xNmSdZj6gG580WPKtvQMdCFgQjCadvUyD+7OhykKEEiShpK4bLDCJ56ErIlOo/0Df+C8
         QDWcM5eipGwUMh2qutAaYcTZggRtsHZ6mnfcAsKPzf9JAwGDh2DN5DnBB7xjSoKBkkNP
         yoTvh8pozp97qN+XkiogH/oAGFnGAP8Q+vb2zcUuAR6Gn6/IZawD5h0Ah6SLdnIMOX0A
         skTA==
X-Forwarded-Encrypted: i=1; AJvYcCWQHKPBricf76M0+bsgdURYrLkejpueIfmcwpM0lk4UZuPveNF9FLKx9dRexRPX1h7xlHkhhQbvZb/Ky6HVNRT6E6OqGkhY
X-Gm-Message-State: AOJu0Yyah7Pbz2DP8nyZ4aQD/zp2u72gn3LzXtIb9oVj5+maCwLpWT35
	xFEmjiIalK4KvtDGv5QBgd/IuiJtPRxMC52nXIBJDFi0D7yVBvjudrtP8T2P01Y=
X-Google-Smtp-Source: AGHT+IHOM+Hm4FbbQZQFmS6lBFh9A0mBVXXYXd6sNx2AlIYuuH2UdvbbngptVM/wrFldErC1pE/3+g==
X-Received: by 2002:a05:6870:169e:b0:24f:d4b4:698f with SMTP id 586e51a60fabf-25121c77f82mr2124416fac.1.1717573032990;
        Wed, 05 Jun 2024 00:37:12 -0700 (PDT)
Received: from [10.68.123.4] ([203.208.167.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242c245absm8044149b3a.200.2024.06.05.00.37.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 00:37:12 -0700 (PDT)
Message-ID: <06bb3780-7ba0-4d88-b212-5e5b7a1b92cb@bytedance.com>
Date: Wed, 5 Jun 2024 15:37:01 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH bpf-next] bpf: tcp: Improve bpf write tcp opt
 performance
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: edumazet@google.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 laoar.shao@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20240515081901.91058-1-zhoufeng.zf@bytedance.com>
 <87seyjwgme.fsf@cloudflare.com>
 <1803b7c0-bc56-46d6-835f-f3802b8b7e00@bytedance.com>
 <87wmnty8yd.fsf@cloudflare.com>
 <d66d58f1-219e-450a-91fc-bd08337db77d@bytedance.com>
 <875xuuxntc.fsf@cloudflare.com>
From: Feng Zhou <zhoufeng.zf@bytedance.com>
In-Reply-To: <875xuuxntc.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2024/5/31 18:45, Jakub Sitnicki 写道:
> On Fri, May 17, 2024 at 03:27 PM +08, Feng Zhou wrote:
>> 在 2024/5/17 01:15, Jakub Sitnicki 写道:
>>> On Thu, May 16, 2024 at 11:15 AM +08, Feng Zhou wrote:
>>>> 在 2024/5/15 17:48, Jakub Sitnicki 写道:
> 
> [...]
> 
>>> If it's not the BPF prog, which you have ruled out, then where are we
>>> burining cycles? Maybe that is something that can be improved.
>>> Also, in terms on quantifying the improvement - it is 20% in terms of
>>> what? Throughput, pps, cycles? And was that a single data point? For
>>> multiple measurements there must be some variance (+/- X pp).
>>> Would be great to see some data to back it up.
>>> [...]
>>>
>>
>> Pressure measurement method:
>>
>> server: sockperf sr --tcp -i x.x.x.x -p 7654 --daemonize
>> client: taskset -c 8 sockperf tp --tcp -i x.x.x.x -p 7654 -m 1200 -t 30
>>
>> Default mode, no bpf prog:
>>
>> taskset -c 8 sockperf tp --tcp -i x.x.x.x -p 7654 -m 1200 -t 30
>> sockperf: == version #3.10-23.gited92afb185e6 ==
>> sockperf[CLIENT] send on:
>> [ 0] IP = x.x.x.x    PORT =  7654 # TCP
>> sockperf: Warmup stage (sending a few dummy messages)...
>> sockperf: Starting test...
>> sockperf: Test end (interrupted by timer)
>> sockperf: Test ended
>> sockperf: Total of 71520808 messages sent in 30.000 sec
>>
>> sockperf: NOTE: test was performed, using msg-size=1200. For getting maximum
>> throughput consider using --msg-size=1472
>> sockperf: Summary: Message Rate is 2384000 [msg/sec]
>> sockperf: Summary: BandWidth is 2728.271 MBps (21826.172 Mbps)
>>
>> perf record --call-graph fp -e cycles:k -C 8 -- sleep 10
>> perf report
>>
>> 80.88%--sock_sendmsg
>>   79.53%--tcp_sendmsg
>>    42.48%--tcp_sendmsg_locked
>>     16.23%--_copy_from_iter
>>     4.24%--tcp_send_mss
>>      3.25%--tcp_current_mss
>>
>>
>> perf top -C 8
>>
>> 19.13%  [kernel]            [k] _raw_spin_lock_bh
>> 11.75%  [kernel]            [k] copy_user_enhanced_fast_string
>>   9.86%  [kernel]            [k] tcp_sendmsg_locked
>>   4.44%  sockperf            [.]
>>   _Z14client_handlerI10IoRecvfrom9SwitchOff13PongModeNeverEviii
>>   4.16%  libpthread-2.28.so  [.] __libc_sendto
>>   3.85%  [kernel]            [k] syscall_return_via_sysret
>>   2.70%  [kernel]            [k] _copy_from_iter
>>   2.48%  [kernel]            [k] entry_SYSCALL_64
>>   2.33%  [kernel]            [k] native_queued_spin_lock_slowpath
>>   1.89%  [kernel]            [k] __virt_addr_valid
>>   1.77%  [kernel]            [k] __check_object_size
>>   1.75%  [kernel]            [k] __sys_sendto
>>   1.74%  [kernel]            [k] entry_SYSCALL_64_after_hwframe
>>   1.42%  [kernel]            [k] __fget_light
>>   1.28%  [kernel]            [k] tcp_push
>>   1.01%  [kernel]            [k] tcp_established_options
>>   0.97%  [kernel]            [k] tcp_send_mss
>>   0.94%  [kernel]            [k] syscall_exit_to_user_mode_prepare
>>   0.94%  [kernel]            [k] tcp_sendmsg
>>   0.86%  [kernel]            [k] tcp_current_mss
>>
>> Having bpf prog to write tcp opt in all pkts:
>>
>> taskset -c 8 sockperf tp --tcp -i x.x.x.x -p 7654 -m 1200 -t 30
>> sockperf: == version #3.10-23.gited92afb185e6 ==
>> sockperf[CLIENT] send on:
>> [ 0] IP = x.x.x.x    PORT =  7654 # TCP
>> sockperf: Warmup stage (sending a few dummy messages)...
>> sockperf: Starting test...
>> sockperf: Test end (interrupted by timer)
>> sockperf: Test ended
>> sockperf: Total of 60636218 messages sent in 30.000 sec
>>
>> sockperf: NOTE: test was performed, using msg-size=1200. For getting maximum
>> throughput consider using --msg-size=1472
>> sockperf: Summary: Message Rate is 2021185 [msg/sec]
>> sockperf: Summary: BandWidth is 2313.063 MBps (18504.501 Mbps)
>>
>> perf record --call-graph fp -e cycles:k -C 8 -- sleep 10
>> perf report
>>
>> 80.30%--sock_sendmsg
>>   79.02%--tcp_sendmsg
>>    54.14%--tcp_sendmsg_locked
>>     12.82%--_copy_from_iter
>>     12.51%--tcp_send_mss
>>      11.77%--tcp_current_mss
>>       10.10%--tcp_established_options
>>        8.75%--bpf_skops_hdr_opt_len.isra.54
>>         5.71%--__cgroup_bpf_run_filter_sock_ops
>>          3.32%--bpf_prog_e7ccbf819f5be0d0_tcpopt
>>    6.61%--__tcp_push_pending_frames
>>     6.60%--tcp_write_xmit
>>      5.89%--__tcp_transmit_skb
>>
>> perf top -C 8
>>
>> 10.98%  [kernel]                           [k] _raw_spin_lock_bh
>>   9.04%  [kernel]                           [k] copy_user_enhanced_fast_string
>>   7.78%  [kernel]                           [k] tcp_sendmsg_locked
>>   3.91%  sockperf                           [.]
>>   _Z14client_handlerI10IoRecvfrom9SwitchOff13PongModeNeverEviii
>>   3.46%  libpthread-2.28.so                 [.] __libc_sendto
>>   3.35%  [kernel]                           [k] syscall_return_via_sysret
>>   2.86%  [kernel]                           [k] bpf_skops_hdr_opt_len.isra.54
>>   2.16%  [kernel]                           [k] __htab_map_lookup_elem
>>   2.11%  [kernel]                           [k] _copy_from_iter
>>   2.09%  [kernel]                           [k] entry_SYSCALL_64
>>   1.97%  [kernel]                           [k] __virt_addr_valid
>>   1.95%  [kernel]                           [k] __cgroup_bpf_run_filter_sock_ops
>>   1.95%  [kernel]                           [k] lookup_nulls_elem_raw
>>   1.89%  [kernel]                           [k] __fget_light
>>   1.42%  [kernel]                           [k] __sys_sendto
>>   1.41%  [kernel]                           [k] entry_SYSCALL_64_after_hwframe
>>   1.31%  [kernel]                           [k] native_queued_spin_lock_slowpath
>>   1.22%  [kernel]                           [k] __check_object_size
>>   1.18%  [kernel]                           [k] tcp_established_options
>>   1.04%  bpf_prog_e7ccbf819f5be0d0_tcpopt   [k] bpf_prog_e7ccbf819f5be0d0_tcpopt
>>
>> Compare the above test results, fill up a CPU, you can find that
>> the upper limit of qps or BandWidth has a loss of nearly 18-20%.
>> Then CPU occupancy, you can find that "tcp_send_mss" has increased
>> significantly.
> 
> This helps prove the point, but what I actually had in mind is to check
> "perf annotate bpf_skops_hdr_opt_len" and see if there any low hanging
> fruit there which we can optimize.
> 
> For instance, when I benchmark it in a VM, I see we're spending cycles
> mostly memset()/rep stos. I have no idea where the cycles are spent in
> your case.
> 
>>

How do you do your pressure test? Can you send it to me for a try? Or 
you can try my pressure test method. Have you checked the calling 
frequency of bpf_skops_hdr_opt_len and bpf_skops_write_hdr_opt?

>>>>>> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
>>>>>> index 90706a47f6ff..f2092de1f432 100644
>>>>>> --- a/tools/include/uapi/linux/bpf.h
>>>>>> +++ b/tools/include/uapi/linux/bpf.h
>>>>>> @@ -6892,8 +6892,14 @@ enum {
>>>>>>     	 * options first before the BPF program does.
>>>>>>     	 */
>>>>>>     	BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG = (1<<6),
>>>>>> +	/* Fast path to reserve space in a skb under
>>>>>> +	 * sock_ops->op == BPF_SOCK_OPS_HDR_OPT_LEN_CB.
>>>>>> +	 * opt length doesn't change often, so it can save in the tcp_sock. And
>>>>>> +	 * set BPF_SOCK_OPS_HDR_OPT_LEN_CACHE_CB_FLAG to no bpf call.
>>>>>> +	 */
>>>>>> +	BPF_SOCK_OPS_HDR_OPT_LEN_CACHE_CB_FLAG = (1<<7),
>>>>> Have you considered a bpf_reserve_hdr_opt() flag instead?
>>>>> An example or test coverage would to show this API extension in action
>>>>> would help.
>>>>>
>>>>
>>>> bpf_reserve_hdr_opt () flag can't finish this. I want to optimize
>>>> that bpf prog will not be triggered frequently before TSO. Provide
>>>> a way for users to not trigger bpf prog when opt len is unchanged.
>>>> Then when writing opt, if len changes, clear the flag, and then
>>>> change opt len in the next package.
>>> I haven't seen a sample using the API extenstion that you're proposing,
>>> so I can only guess. But you probably have something like:
>>> SEC("sockops")
>>> int sockops_prog(struct bpf_sock_ops *ctx)
>>> {
>>> 	if (ctx->op == BPF_SOCK_OPS_HDR_OPT_LEN_CB &&
>>> 	    ctx->args[0] == BPF_WRITE_HDR_TCP_CURRENT_MSS) {
>>> 		bpf_reserve_hdr_opt(ctx, N, 0);
>>> 		bpf_sock_ops_cb_flags_set(ctx,
>>> 					  ctx->bpf_sock_ops_cb_flags |
>>> 					  MY_NEW_FLAG);
>>> 		return 1;
>>> 	}
>>> }
>>
>> Yes, that's what I expected.
>>
>>> I don't understand why you're saying it can't be transformed into:
>>> int sockops_prog(struct bpf_sock_ops *ctx)
>>> {
>>> 	if (ctx->op == BPF_SOCK_OPS_HDR_OPT_LEN_CB &&
>>> 	    ctx->args[0] == BPF_WRITE_HDR_TCP_CURRENT_MSS) {
>>> 		bpf_reserve_hdr_opt(ctx, N, MY_NEW_FLAG);
>>> 		return 1;
>>> 	}
>>> }
>>
>> "bpf_reserve_hdr_opt (ctx, N, MY_NEW_FLAG);"
>>
>> I don't know what I can do to pass the flag parameter, let
>> "bpf_reserve_hdr_opt" return quickly? But this is not useful,
>> because the loss caused by the triggering of bpf prog is very
>> expensive, and it is still on the hotspot function of sending
>> packets, and the TSO has not been completed yet.
>>
>>> [...]
> 
> This is not what I'm suggesting.
> 
> bpf_reserve_hdr_opt() has access to bpf_sock_ops_kern and even the
> sock. You could either signal through bpf_sock_ops_kern to
> bpf_skops_hdr_opt_len() that it should not be called again
> 
> Or even configure the tcp_sock directly from bpf_reserve_hdr_opt()
> because it has access to it via bpf_sock_ops_kern{}.sk.

Oh, I see what you mean, this will achieve the goal.



