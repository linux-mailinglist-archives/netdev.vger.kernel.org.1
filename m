Return-Path: <netdev+bounces-159810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30974A16FE6
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 17:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EA041680A3
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 16:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD4A1E9B1D;
	Mon, 20 Jan 2025 16:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WFybYBBO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E451B1E990A
	for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 16:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737389439; cv=none; b=U33FwsomNDSDcj6muB6iFk9g6A0L089pfCeU4bycAvihiut5Rdq9wJOz4xSNKlYWuLyx+5Et16YqS3m2yMhGDikxtdqIf8TxrdNwzi3EXZc++5aUjneZzF3rUxaJXwuCcC44o5mPH0PkVm71e+9NqHM+bd4TSziraxTFHZFc/LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737389439; c=relaxed/simple;
	bh=GDx7Mu4RrnufKxEfPiKUQum3Mi8SoBc0J0Rtm1jdeTo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=H7z2pXbpXiqV5+l+pvWuD3b9uvXNFDE3uLX9qjfFn6+YjXcJgp/9jpUH03e7Cuqpsdmz2Rd0zZTYFmxpNSKgCsrNyLvkmcrJrDTYQ+4/JxIlG0Y9K2IpHY8NL07zO8+Lizc6Rvl4cApsywpKW5tsenWUP8KKCeC5DZRQDDGPGY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WFybYBBO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737389436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ri3SMYvQPCeY1bR1GnymUd0egQws7tzEKq8qVlLHNGQ=;
	b=WFybYBBO4SJEAlAOsAllCrq9fIrnQU6tQTlbHWIBbFAI7u82Uc2hhU2AxronMKpmEAO7hs
	SgMdJ5aZp7xVn48rw2grwLq3fXAUydKqRAtUxBsFaS2gLLBum8T0faFJYJCBZK1UEm/8kA
	m8V41GvT1N6RraEWLJPVsk/aVgePwhw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-NnhYNvH-M3ak2-rsXAzFCA-1; Mon, 20 Jan 2025 11:10:35 -0500
X-MC-Unique: NnhYNvH-M3ak2-rsXAzFCA-1
X-Mimecast-MFC-AGG-ID: NnhYNvH-M3ak2-rsXAzFCA
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4679becb47eso125801461cf.3
        for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 08:10:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737389435; x=1737994235;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ri3SMYvQPCeY1bR1GnymUd0egQws7tzEKq8qVlLHNGQ=;
        b=Ytd88aMdj3a5HtktSh4jp1Xg4eQ5iI38rsZfj1/9ginbnnqEcps36ipJNaJmLqmHqS
         34uWjWcFBSOtbiGP/VUenIPMczwQPVgtkZ562Djoj5wO0YBVDP80S4fBm7VZDbwCfBOV
         cDrQpoqdN0lo56wdB/ViijKuBrDUzrEk1PbvpvKcihPZcU2/+ZHB39UJ+sxiZmR4QjtT
         dQ2q+o8PUFo2Ulam7lL2a3r9kUgBnvSc5iXDVEVS2EtYaYhbu9tPwajxgtJW0Ow4Zp7D
         +JljAOfrVIGkFH/sO0jsCQD95c3h7Cq+bjwQ17/hBVvm2Spp6HszPgqnh3i3nNt257KU
         cZ3g==
X-Gm-Message-State: AOJu0YxLeNzbyQfJxfKWDww1aO7P7ERbImtzzGj6VBME0kY1UEO3Jy7E
	xaHD4JKTYDJhEzsnheRE0Mhw88LRkyTjj9KNbmxB32mWgt4+0LEr/G0icX/b6zzAw8eEpCNl7hE
	ZdIHCz6Jgxqf3HOZHKHnJtJY29vigOlSufSpAFvwuEhtlt5i2aVNJ5w==
X-Gm-Gg: ASbGncuptNlc8CXGPmu+9IvE5709HxwbLAOOtXOitFJT1CDKZOuvJsQet/plwj9U+fN
	O+tUoybun1eal6aHfTFQ76yHYhGiAJm+z//L06MVYwAMiG9orELj5qqQMHdQQ1981FJ00ACz0ox
	52wklPKsLi8DnGrm3Ab7bDWbEmZ6VTweJ5rh5G0msN48wtQasWixtxSY9UegOP7axob0mrMV36h
	QM4yiTvh6k3cHVqybN87NvOtQd7qsJnkzjdxb2AZccMZ/KvEdpRBCQIp3cp41LipHIk
X-Received: by 2002:a05:620a:4252:b0:7b1:3bf5:11f8 with SMTP id af79cd13be357-7be6320a5efmr2224501585a.25.1737389435044;
        Mon, 20 Jan 2025 08:10:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlpZ0W4K8TO5Ce8IJmPQUTs/oNxMtHzbVCB0Dhz2gxAltYaO9P+5ofPeTe3G0EQsVd/7SmRw==
X-Received: by 2002:a05:620a:4252:b0:7b1:3bf5:11f8 with SMTP id af79cd13be357-7be6320a5efmr2224496985a.25.1737389434720;
        Mon, 20 Jan 2025 08:10:34 -0800 (PST)
Received: from [10.0.0.215] ([24.225.235.209])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be614dabeasm458117585a.86.2025.01.20.08.10.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2025 08:10:34 -0800 (PST)
Message-ID: <c41deefb-9bc8-47b8-bff0-226bb03265fe@redhat.com>
Date: Mon, 20 Jan 2025 11:10:32 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net,v2] tcp: correct handling of extreme memory squeeze
From: Jon Maloy <jmaloy@redhat.com>
To: Neal Cardwell <ncardwell@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 passt-dev@passt.top, sbrivio@redhat.com, lvivier@redhat.com,
 dgibson@redhat.com, eric.dumazet@gmail.com, edumazet@google.com,
 Menglong Dong <menglong8.dong@gmail.com>
References: <20250117214035.2414668-1-jmaloy@redhat.com>
 <CADVnQymiwUG3uYBGMc1ZEV9vAUQzEOD4ymdN7Rcqi7yAK9ZB5A@mail.gmail.com>
 <afb9ff14-a2f1-4c5a-a920-bce0105a7d41@redhat.com>
Content-Language: en-US
In-Reply-To: <afb9ff14-a2f1-4c5a-a920-bce0105a7d41@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025-01-20 00:03, Jon Maloy wrote:
> 
> 
> On 2025-01-18 15:04, Neal Cardwell wrote:
>> On Fri, Jan 17, 2025 at 4:41 PM <jmaloy@redhat.com> wrote:
>>>
>>> From: Jon Maloy <jmaloy@redhat.com>
>>>
>>> Testing with iperf3 using the "pasta" protocol splicer has revealed
>>> a bug in the way tcp handles window advertising in extreme memory
>>> squeeze situations.
>>>
>>> Under memory pressure, a socket endpoint may temporarily advertise
>>> a zero-sized window, but this is not stored as part of the socket data.
>>> The reasoning behind this is that it is considered a temporary setting
>>> which shouldn't influence any further calculations.
>>>
>>> However, if we happen to stall at an unfortunate value of the current
>>> window size, the algorithm selecting a new value will consistently fail
>>> to advertise a non-zero window once we have freed up enough memory.
>>
>> The "if we happen to stall at an unfortunate value of the current
>> window size" phrase is a little vague... :-) Do you have a sense of
>> what might count as "unfortunate" here? That might help in crafting a
>> packetdrill test to reproduce this and have an automated regression
>> test.
> 
> Obviously, it happens when the following code snippet in
> 
> __tcp_cleanup_rbuf() {
>     [....]
>     if (copied > 0 && !time_to_ack &&
>         !(sk->sk_shutdown & RCV_SHUTDOWN)) {
>              __u32 rcv_window_now = tcp_receive_window(tp);
> 
>              /* Optimize, __tcp_select_window() is not cheap. */
>              if (2*rcv_window_now <= tp->window_clamp) {
>                  __u32 new_window = __tcp_select_window(sk);
> 
>                  /* Send ACK now, if this read freed lots of space
>                   * in our buffer. Certainly, new_window is new window.
>                   * We can advertise it now, if it is not less than
>                   * current one.
>                   * "Lots" means "at least twice" here.
>                   */
>                  if (new_window && new_window >= 2 * rcv_window_now)
>                          time_to_ack = true;
>             }
>      }
>      [....]
> }
> 
> yields time_to_ack = false, i.e.  __tcp_select_window(sk) returns
> a value new_window  < (2 *  tcp_receive_window(tp)).
> 
> In my log I have for brevity used the following names:
> 
> win_now: same as rcv_window_now
>      (= tcp_receive_window(tp),
>       = tp->rcv_wup + tp->rcv_wnd - tp->rcv_nxt,
>       = 265469200 + 262144 -  265600160,
>       = 131184)
> 
> new_win: same as new_window
>       (= __tcp_select_window(sk),
>        = 0 first time, later 262144 )
> 
> rcv_wnd: same as tp->rcv_wnd,
>        (=262144)
> 
> We see that although the last test actually is pretty close
> (262144 >= 262368 ? => false) it is not close enough.
> 
> 
> We also notice that
> (tp->rcv_nxt - tp->rcv_wup) = (265600160 - 265469200) = 130960.
> 130960 < tp->rcv_wnd / 2, so the last test in __tcp_cleanup_rbuf():
> (new_window >= 2 * rcv_window_now) will always be false.
> 
> 
> Too me it looks like __tcp_select_window(sk) doesn't at all take the 
> freed-up memory into account when calculating a new window. I haven't
> looked into why that is happening.
> 
>>
>>> This means that this side's notion of the current window size is
>>> different from the one last advertised to the peer, causing the latter
>>> to not send any data to resolve the sitution.
>>
>> Since the peer last saw a zero receive window at the time of the
>> memory-pressure drop, shouldn't the peer be sending repeated zero
>> window probes, and shouldn't the local host respond to a ZWP with an
>> ACK with the correct non-zero window?
> 
> It should, but at the moment when I found this bug the peer stack was 
> not the Linux kernel stack, but one we develop for our own purpose. We 
> fixed that later, but it still means that traffic stops for a couple of 
> seconds now and then before the timer restarts the flow. This happens
> too often for comfort in our usage scenarios.
> We can of course blame the the peer stack, but I still feel this is a
> bug, and that it could be handled better by the kernel stack.
>>
>> Do you happen to have a tcpdump .pcap of one of these cases that you 
>> can share?
> 
> I had one, although not for this particular run, and I cannot find it 
> right now. I will continue looking or make a new one. Is there some 
> shared space I can put it?

Here it is. Look at frame #1067.

https://passt.top/static/iperf3_jon_zero_window_cut.pcap
> 
>>
>>> The problem occurs on the iperf3 server side, and the socket in question
>>> is a completely regular socket with the default settings for the
>>> fedora40 kernel. We do not use SO_PEEK or SO_RCVBUF on the socket.
>>>
>>> The following excerpt of a logging session, with own comments added,
>>> shows more in detail what is happening:
>>>
>>> //              tcp_v4_rcv(->)
>>> //                tcp_rcv_established(->)
>>> [5201<->39222]:     ==== Activating log @ net/ipv4/tcp_input.c/ 
>>> tcp_data_queue()/5257 ====
>>> [5201<->39222]:     tcp_data_queue(->)
>>> [5201<->39222]:        DROPPING skb [265600160..265665640], reason: 
>>> SKB_DROP_REASON_PROTO_MEM
>>>                         [rcv_nxt 265600160, rcv_wnd 262144, snt_ack 
>>> 265469200, win_now 131184]
>>
>> What is "win_now"? That doesn't seem to correspond to any variable
>> name in the Linux source tree. 
> 
> See above.
> 
>   Can this be renamed to the
>> tcp_select_window() variable it is printing, like "cur_win" or
>> "effective_win" or "new_win", etc?
>>
>> Or perhaps you can attach your debugging patch in some email thread? I
>> agree with Eric that these debug dumps are a little hard to parse
>> without seeing the patch that allows us to understand what some of
>> these fields are...
>>
>> I agree with Eric that probably tp->pred_flags should be cleared, and
>> a packetdrill test for this would be super-helpful.
> 
> I must admit I have never used packetdrill, but I can make an effort.

I hear from other sources that you cannot force a memory exhaustion with
packetdrill anyway, so this sounds like a pointless exercise.

///jon

> 
> ///jon
> 
>>
>> thanks,
>> neal
>>
> 


