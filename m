Return-Path: <netdev+bounces-159684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D599A16644
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 06:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFAD63AA7D2
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 05:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F2315E5A6;
	Mon, 20 Jan 2025 05:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A/ME3eDF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF5B1494AB
	for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 05:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737349398; cv=none; b=bYbxJgCupnj+oi3DOimIUMtZd7DNg1MuxceGxIh7oVrKDYKPmTye/sUcVnpwLqNxjh+C3IBKzGNbjrNEpLEOOHjDxi0ypvQwYkAaBY+0fQLDBRYXnksoxerhVQLW4rJeDzPqvEgmq2p+lZIFF4VSQdQjNCn/Q4t/McHxKwbt8vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737349398; c=relaxed/simple;
	bh=yi5/ejharP2rgAlv/th7bUVl8jGWfYzrQePYu8WE9wk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nAUT7R5kZAHH4iCikTmI4Sljp+kbhv6acbvIoRpz1if11VEqMrMrXOeFL2WXktbr5dQK2lB7/c5qwknGVLDF8jbN/Asu488S16OUyu/PQW7fG5oSVi8tTM02UKaKT4iw2Ov0j6BI48fmWS5da1e7vgfbo1x9l0FCR3L4zfWW15I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A/ME3eDF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737349395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Otj/i9YxH8Ex1BKeBO3WT3iArT/Id0Vg2/Mch4GIyjE=;
	b=A/ME3eDFbeOrzQuZ9hpLFaJ9tYib1ZVE9z8YjGO52+6f9E/oydbqKmKtqkjGHzqYQnI50m
	XKVGEi5QHFafQQDiXO4MWGaGDK/c4V3tgMzvHgIJIJcfXp+urtN+5k+6J4bVgM8/s32ap1
	odUfERow2xfKwu49Wv6c7NjQoJjeEtY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-f0Or8lY8Pw2z1xXKvk-AqA-1; Mon, 20 Jan 2025 00:03:13 -0500
X-MC-Unique: f0Or8lY8Pw2z1xXKvk-AqA-1
X-Mimecast-MFC-AGG-ID: f0Or8lY8Pw2z1xXKvk-AqA
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4679d6ef2f9so110393401cf.1
        for <netdev@vger.kernel.org>; Sun, 19 Jan 2025 21:03:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737349393; x=1737954193;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Otj/i9YxH8Ex1BKeBO3WT3iArT/Id0Vg2/Mch4GIyjE=;
        b=GWu3XTrJ8IC6X4fIW6QyjhZOwXShFa5RkA2tIiC86ya6FJcB+OaY9cWrPYg4Qt1BDL
         yux+rl6QJEo1TX55kQsTrCQJc9vI8opeqnmaioFhklFSra2cCZnUk/gwUJk4kmZQ1wJp
         zdlXJsUzpAJf3oYv+W1d6mbZ3i20s7l/B4LPkLVGcyP4jWJQ1nHulF6UhOyKWf8F0x4z
         v8180dENxVw/NCtUm1pRmzuzOTkOK2B2UigTS0N2hjbax4Ku6iPXDignBbAr3RHInEWq
         3DUA+GMYAzSs5rXFo9UYxeZsZrPdV8vHr/R6BgGU+ax7E0wQNHaIQ9B7xU/Mp1K8FG8/
         tn3g==
X-Gm-Message-State: AOJu0Ywq6l0vVJ5AAMxJphsViB3RdfB+0+xwkQZ46RYZYa3dcGa/ZV4A
	xEDdoP0zeg2bSxCvUdJkfMTVW0+B3SZIzJqSIki3plaqTT8rgAtHzXqG5v0cRA2pTc2oq/MOrgx
	RWt/QRgwUdp7C8otI2KLFLxel34V4NEnleHVibjvVu39lpcyhGAvK5A==
X-Gm-Gg: ASbGncu4tqa/y5H96/din/P5r/AnvehBikHBlJJYF4hSZjIo26PHTC1T1gKiF+r1GJT
	bq3YkeC0ygmQhs4IMtuThThaRrSbb0LlghQNJ5kqtwF/nEvzZc1/g4dg7l3WdUC3wcK/GK6kmgz
	znRD/Q7K0JLvOfr1tVFk9thbAfgQUlhZjoM1LGNucgDU9HzqwrWZUtDW3Ny0O8jVywJBkGtOXuJ
	RoxaX7hiziRT6phI5AVKsRNM8zzIfy1e/9eMXHfK9di/jQFjh2kn+d3goiHzkjWicrm
X-Received: by 2002:ac8:58c6:0:b0:467:61c1:df3e with SMTP id d75a77b69052e-46e12ab658emr167404501cf.30.1737349392689;
        Sun, 19 Jan 2025 21:03:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGen5rwylzwMI56v5RM4Bya0c7VtUEr8Gq9zlBAhsh0hHbQmx946wxszvjGZE3bI8lfp/gn2Q==
X-Received: by 2002:ac8:58c6:0:b0:467:61c1:df3e with SMTP id d75a77b69052e-46e12ab658emr167403421cf.30.1737349390765;
        Sun, 19 Jan 2025 21:03:10 -0800 (PST)
Received: from [10.0.0.215] ([24.225.235.209])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46e10403dc6sm38665451cf.53.2025.01.19.21.03.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jan 2025 21:03:10 -0800 (PST)
Message-ID: <afb9ff14-a2f1-4c5a-a920-bce0105a7d41@redhat.com>
Date: Mon, 20 Jan 2025 00:03:08 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net,v2] tcp: correct handling of extreme memory squeeze
To: Neal Cardwell <ncardwell@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 passt-dev@passt.top, sbrivio@redhat.com, lvivier@redhat.com,
 dgibson@redhat.com, imagedong@tencent.com, eric.dumazet@gmail.com,
 edumazet@google.com
References: <20250117214035.2414668-1-jmaloy@redhat.com>
 <CADVnQymiwUG3uYBGMc1ZEV9vAUQzEOD4ymdN7Rcqi7yAK9ZB5A@mail.gmail.com>
Content-Language: en-US
From: Jon Maloy <jmaloy@redhat.com>
In-Reply-To: <CADVnQymiwUG3uYBGMc1ZEV9vAUQzEOD4ymdN7Rcqi7yAK9ZB5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025-01-18 15:04, Neal Cardwell wrote:
> On Fri, Jan 17, 2025 at 4:41 PM <jmaloy@redhat.com> wrote:
>>
>> From: Jon Maloy <jmaloy@redhat.com>
>>
>> Testing with iperf3 using the "pasta" protocol splicer has revealed
>> a bug in the way tcp handles window advertising in extreme memory
>> squeeze situations.
>>
>> Under memory pressure, a socket endpoint may temporarily advertise
>> a zero-sized window, but this is not stored as part of the socket data.
>> The reasoning behind this is that it is considered a temporary setting
>> which shouldn't influence any further calculations.
>>
>> However, if we happen to stall at an unfortunate value of the current
>> window size, the algorithm selecting a new value will consistently fail
>> to advertise a non-zero window once we have freed up enough memory.
> 
> The "if we happen to stall at an unfortunate value of the current
> window size" phrase is a little vague... :-) Do you have a sense of
> what might count as "unfortunate" here? That might help in crafting a
> packetdrill test to reproduce this and have an automated regression
> test.

Obviously, it happens when the following code snippet in

__tcp_cleanup_rbuf() {
    [....]
    if (copied > 0 && !time_to_ack &&
        !(sk->sk_shutdown & RCV_SHUTDOWN)) {
             __u32 rcv_window_now = tcp_receive_window(tp);

             /* Optimize, __tcp_select_window() is not cheap. */
             if (2*rcv_window_now <= tp->window_clamp) {
                 __u32 new_window = __tcp_select_window(sk);

                 /* Send ACK now, if this read freed lots of space
                  * in our buffer. Certainly, new_window is new window.
                  * We can advertise it now, if it is not less than 

                  * current one.
                  * "Lots" means "at least twice" here.
                  */
                 if (new_window && new_window >= 2 * rcv_window_now)
                         time_to_ack = true;
            }
     }
     [....]
}

yields time_to_ack = false, i.e.  __tcp_select_window(sk) returns
a value new_window  < (2 *  tcp_receive_window(tp)).

In my log I have for brevity used the following names:

win_now: same as rcv_window_now
     (= tcp_receive_window(tp),
      = tp->rcv_wup + tp->rcv_wnd - tp->rcv_nxt,
      = 265469200 + 262144 -  265600160,
      = 131184)

new_win: same as new_window
      (= __tcp_select_window(sk),
       = 0 first time, later 262144 )

rcv_wnd: same as tp->rcv_wnd,
       (=262144)

We see that although the last test actually is pretty close
(262144 >= 262368 ? => false) it is not close enough.


We also notice that
(tp->rcv_nxt - tp->rcv_wup) = (265600160 - 265469200) = 130960.
130960 < tp->rcv_wnd / 2, so the last test in __tcp_cleanup_rbuf():
(new_window >= 2 * rcv_window_now) will always be false.


Too me it looks like __tcp_select_window(sk) doesn't at all take the 
freed-up memory into account when calculating a new window. I haven't
looked into why that is happening.

> 
>> This means that this side's notion of the current window size is
>> different from the one last advertised to the peer, causing the latter
>> to not send any data to resolve the sitution.
> 
> Since the peer last saw a zero receive window at the time of the
> memory-pressure drop, shouldn't the peer be sending repeated zero
> window probes, and shouldn't the local host respond to a ZWP with an
> ACK with the correct non-zero window?

It should, but at the moment when I found this bug the peer stack was 
not the Linux kernel stack, but one we develop for our own purpose. We 
fixed that later, but it still means that traffic stops for a couple of 
seconds now and then before the timer restarts the flow. This happens
too often for comfort in our usage scenarios.
We can of course blame the the peer stack, but I still feel this is a
bug, and that it could be handled better by the kernel stack.
> 
> Do you happen to have a tcpdump .pcap of one of these cases that you can share?

I had one, although not for this particular run, and I cannot find it 
right now. I will continue looking or make a new one. Is there some 
shared space I can put it?

> 
>> The problem occurs on the iperf3 server side, and the socket in question
>> is a completely regular socket with the default settings for the
>> fedora40 kernel. We do not use SO_PEEK or SO_RCVBUF on the socket.
>>
>> The following excerpt of a logging session, with own comments added,
>> shows more in detail what is happening:
>>
>> //              tcp_v4_rcv(->)
>> //                tcp_rcv_established(->)
>> [5201<->39222]:     ==== Activating log @ net/ipv4/tcp_input.c/tcp_data_queue()/5257 ====
>> [5201<->39222]:     tcp_data_queue(->)
>> [5201<->39222]:        DROPPING skb [265600160..265665640], reason: SKB_DROP_REASON_PROTO_MEM
>>                         [rcv_nxt 265600160, rcv_wnd 262144, snt_ack 265469200, win_now 131184]
> 
> What is "win_now"? That doesn't seem to correspond to any variable
> name in the Linux source tree. 

See above.

  Can this be renamed to the
> tcp_select_window() variable it is printing, like "cur_win" or
> "effective_win" or "new_win", etc?
> 
> Or perhaps you can attach your debugging patch in some email thread? I
> agree with Eric that these debug dumps are a little hard to parse
> without seeing the patch that allows us to understand what some of
> these fields are...
> 
> I agree with Eric that probably tp->pred_flags should be cleared, and
> a packetdrill test for this would be super-helpful.

I must admit I have never used packetdrill, but I can make an effort.

///jon

> 
> thanks,
> neal
> 


