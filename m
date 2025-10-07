Return-Path: <netdev+bounces-228141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F85BC2C0A
	for <lists+netdev@lfdr.de>; Tue, 07 Oct 2025 23:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 169F9189F06B
	for <lists+netdev@lfdr.de>; Tue,  7 Oct 2025 21:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032D4225762;
	Tue,  7 Oct 2025 21:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="YL7bFwDw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1FB28E9
	for <netdev@vger.kernel.org>; Tue,  7 Oct 2025 21:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759872733; cv=none; b=UZu7DG15jTP4Zrh6Yadde/9kuV3vvA7eq5XCfCENXNHS3J4QBtN1OwkxUK3EtggW4d1JrITGt/5xLBgVoVdJ2U+iA7CD36aQk7BrSGJWlingPsIAh9V6EHY8LIhMqudJcCxUxHzmlQyklja24lxsLZat1d0nxKEzt2JgnVtNUgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759872733; c=relaxed/simple;
	bh=alpREjgK1eb9d2WzbY/++kmoOsgMpKrtiUsGTM52poA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aQlZwnyOFaq+6dz7rlpKv0zbvMy0XS1Y/nD8NQkepXRNWUJxNA9H/3HkWBz2WVVRpJ1YW6Srsyl05A0zABH3Lg/PAFpH/2JG7yh8I98iX7ZMa4ozXN/uS/gesSpEa7n4wNDo23ccCdVtbxDVwItVOYPpdMjEA/TWP/HzopzIpRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=YL7bFwDw; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-781206cce18so386800b3a.0
        for <netdev@vger.kernel.org>; Tue, 07 Oct 2025 14:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1759872729; x=1760477529; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uDp4t9nZUmWZxLO8Bh/gA0xB0TK0RnQo3L4TlW98y8Q=;
        b=YL7bFwDwKprF5x/M8DI/ruhhWfA0ZgZjKtlCwLPZ8JXAxTvBlssS95EodJGuF2zCGl
         WG/v7KhnXeBVTIuoFLjjQClutW2dsSv8KJ0V+MhYrL+mmZXjlA4rwOp9viiKz61sKTBX
         3uefS4ml5AsWO9Z4Y3tZRNOsUgk0g2R4MCrejlKEhRORZkZU/VeYdDDCT9uUWcrMNPrc
         AJEdMnquTCfw/1A9CRTioyxnnJuU5LG0R7yc8i+6d2JOqC+MFODxOyQC0DglxIPr2h1O
         nc6XUwfr0QjADeTU8VOGj7Y+FIzWZLeq5CopCJ0HENK2EuO8xn0Ib1v814QMOiKzAv44
         Wknw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759872729; x=1760477529;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uDp4t9nZUmWZxLO8Bh/gA0xB0TK0RnQo3L4TlW98y8Q=;
        b=kfzm94jKReJgbYs8baYm++6JQDIvTGJcF3cAUoGLm6WbGS0wVY1HzMjoukW8KOno6I
         DGR5yFe2rwCJbIVUi7TZBptAISVO0BDrITyX8dcwFRz3+53vvzOC3wlvOCBKb1LmQwxd
         un3gcNms/Gm35730cPWbO3HP9HO5JrxXYBjYRqpmSu4kGQG/XUg5ycfR9ZnQ5cn5eqVl
         EgdEu9LWf79OVp43X9qcEsrmy7B8Ulb9zG2pcI63ngrg5Nn2hyQA4y0J9/qlwbUP7rrv
         xeXZFigvSEanumi7R76mVsopreYDX00G2CTnpLKeZzAIRMup27zkwR8Yy2QECBWQOzQe
         5sbw==
X-Forwarded-Encrypted: i=1; AJvYcCWbqrb2v5qQpKl1Z6rj+l4fe2+MUBX6elDZ07ws8khlQvrPDwmwGvSZ4jT/CeGLGi6De9GyPss=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3g+qr3ZaD05/lTgFCGEACWZ2cJLFwkyCGewYfQAimBOiXcR4J
	u8J7GCtXMI7U9bA0arGiryOr7upRAiIV1569Q1vHxlNXvS7CKhyY0CX5OfhH2eufmQ==
X-Gm-Gg: ASbGncvWE9G8Ol6GgpWuX+A66uOVm8Lqoi3wNm68od0g5+oRBLYQ1hQmjdGcZTUgwxI
	4RYxhl0irHivRqQo3mj5t3PVOdJXQ7zSi0XBF6NYz60tjzA+LKbE9htAbyb/mZTC+sitr/HI34C
	c1rdzvdNx8ylQBs9UNDylmhSLzStvshgUc/RqcbDCOlPDtpqqt3DJPvJniaJBC0DoykC2hyld++
	Fz6/hiM0aECUFpUl+s16n3Tyqw/IWnyFoDgD1NUv9DEYuN+PuvCBgEQqiQuhaYvMVb8mpNdAe59
	3CL7T7IBWjUNH3h0Og6qDRDeFVjBdsWfrhIJ+0P41/3NAVZrEoMCsulOPoiIWAFDyZSsI+V0BI3
	9UYEfUttju86GmZvcGztHoMVfkQQitzBC/Cj5WyPWxOabwCrZM2M8J6TV
X-Google-Smtp-Source: AGHT+IGPwtfg4zcx8QJNjZslMkNIPJCsM/SfwuOsd2rZB3rcIJSTRM4aZ6OzJ3I1D2DaKyU389Yy/Q==
X-Received: by 2002:a05:6a00:1887:b0:772:6856:e663 with SMTP id d2e1a72fcca58-79397c125e2mr857675b3a.8.1759872728970;
        Tue, 07 Oct 2025 14:32:08 -0700 (PDT)
Received: from [10.80.4.93] ([208.66.251.34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01fb3d95sm16533756b3a.32.2025.10.07.14.32.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 14:32:08 -0700 (PDT)
Message-ID: <b8c5db88-49dd-4c9e-b530-ac3bc73c2617@arista.com>
Date: Tue, 7 Oct 2025 14:32:06 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: TCP sender stuck despite receiving ACKs from the peer
To: Neal Cardwell <ncardwell@google.com>
Cc: edumazet@google.com, netdev@vger.kernel.org
References: <CA+suKw5OhWLJe_7uth4q=qxVpsD4qpwGRENORwA=beNLpiDuwg@mail.gmail.com>
 <CADVnQy=Bm2oNE7Ra7aiA2AQGcMUPjHcmhvQsp+ubvncU2YeN2A@mail.gmail.com>
Content-Language: en-US
From: Christoph Schwarz <cschwarz@arista.com>
In-Reply-To: <CADVnQy=Bm2oNE7Ra7aiA2AQGcMUPjHcmhvQsp+ubvncU2YeN2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/3/25 18:24, Neal Cardwell wrote:
> On Fri, Oct 3, 2025 at 8:29 PM Christoph Schwarz <cschwarz@arista.com> wrote:
>>
>> Hi,
>>
>> tldr; we believe there might be an issue with the TCP stack of the Linux kernel 5.10 that causes TCP connections to get stuck when they encounter a certain pattern of retransmissions and delayed and/or lost ACKs. We gathered extensive evidence supporting this theory, but we need help confirming it and further narrowing down the problem. Please read on if you find this interesting.
>>
>> Background: We have an application where multiple clients concurrently download large files (~900 MB) from an HTTP server. Both server and clients run on a Linux with kernel 5.10.165
>>
>> We observed that occasionally one or more of those downloads get stuck, i.e. download a portion of the file and then stop making any progress. In this state, ss shows a large (2 MB-ish) Send-Q on the server side, while Recv-Q on the client is zero, i.e. there is data to send, but it is just not making it across.
>>
>> We ran tcpdump on the server on one of the stuck connections and noticed that the server is retransmitting the same packet over and over again. The client ACK's each retransmission immediately, but the server doesn't seem to care. This goes on until either an application timeout hits, or (with application timeouts disabled) the kernel eventually closes the connection after ~15 minutes, which we believe is due to having exhausted the maximum number of retransmissions (tcp_retries2).
>>
>> We can reproduce this problem with selective ACK enabled or disabled, ruling out any direct connection to it.
>>
>> Example:
>>
>> 11:20:04.676418 02:1c:a7:00:00:01 > 02:1c:a7:00:00:04, ethertype IPv4 (0x0800), length 1514: 127.2.0.1.3102 > 127.2.0.4.46598: Flags [.], seq 1380896424:1380897872, ack 2678783744, win 500, options [nop,nop,TS val 2175898514 ecr 3444405317], length 1448
>> 11:20:04.676525 02:1c:a7:00:00:04 > 02:1c:a7:00:00:01, ethertype IPv4 (0x0800), length 78: 127.2.0.4.46598 > 127.2.0.1.3102: Flags [.], ack 1381019504, win 24567, options [nop,nop,TS val 3444986302 ecr 2175317524,nop,nop,sack 1 {1380896424:1380897872}], length 0
>> ...
>> (this pattern continues, with incremental backoff, until either application level timeout hits, or maximum number of retransmissions is exceeded)
>>
>> The packet that the sender keeps sending is apparently a retransmission, with the client ACK'ing a sequence number further ahead.
>>
>> The next thing we tried is if we can bring such a connection out of the problem state by manually constructing and injecting ACKs, and indeed this is possible. As long as we keep ACKing the right edge of the retransmitted packet(s), the server will send more packets that are further ahead in the stream. If we ACK larger seqnos, such as the one the the client TCP stack is using, the server doesn't react. But if we continue to ACKs the right edges of retransmitted packets, then eventually the connection recovers and the download resumes and finishes successfully.
>>
>> At this point it is evident that the server is ignoring ACKs above a certain seqno. We just don't know what this seqno is.
>>
>> With some more hacks, we extracted snd_nxt from a socket in the problem state:
>>     sz = sizeof(tqi->write_seq);
>>     if (getsockopt(fd, SOL_TCP, TCP_QUEUE_SEQ, &tqi->write_seq, &sz))
>>        return false;
>>
>>     // SIOCOUTQNSD: tp->write_seq - tp->snd_nxt
>>     int write_seq__snd_nxt;
>>     if (ioctl(fd, SIOCOUTQNSD, &write_seq__snd_nxt) == -1)
>>        return false;
>>     tqi->snd_nxt = tqi->write_seq - write_seq__snd_nxt;
>>
>> Then we cross-referenced the so acquired snd_nxt with the seqno that the client is ACK'ing and surprise, the seqno is LARGER than snd_nxt.
>>
>> We now have a suspicion why the sender is ignoring the ACKs. The following is very old code in tcp_ack that ignores all ACKs for data the the server hasn't sent yet:
>> /* If the ack includes data we haven't sent yet, discard
>> * this segment (RFC793 Section 3.9).
>> */
>> if (after(ack, tp->snd_nxt))
>> return -1;
>>
>> To verify this theory, we added additional trace instructions to tcp_rcv_established and tcp_ack, then reproduced the issue once more while taking a packet capture on the server. This experiment confirmed the theory.
>>
>>    <...>-10864   [002] .... 56338.066092: tcp_rcv_established: tcp_rcv_established(2874212, 3102->33240) ack_seq=1678664094 after snd_nxt=1678609070
>>    <...>-10864   [002] .... 56338.066093: tcp_ack: tcp_ack(2874212, 3102->33240, 16640): ack=1678664094, ack_seq=308986386, prior_snd_una=1678606174, snd_nxt=1678609070, high_seq=1678606174
>>    <...>-10864   [002] .... 56338.066093: tcp_ack: tcp_ack(2874212), exit2=-1
>>
>> The traces show that in this instance, the client is ACK'ing 1678664094 which is greater than snd_nxt 1678609070. tcp_ack then returns at the place indicated above without processing the ACK.
>>
>>  From the packet capture of this instance, we reconstructed the timeline of events happening before the connections entered the problem state. This was with SACK disabled.
>>
>> 1. the HTTP download starts, and all seems fine, with the server sending TCP segments of 1448 bytes in each packet and the client ACKing them.
>> 2. at some point, the server decides to retransmit certain packets. When it does, it retransmits 45 consecutive packets, starting at a certain sequence number. The first thing to note is that this is not the oldest unacknowledged sequence number. There are in fact 88 older, unacknowledged packets before the first retransmitted one. This retransmission happens 0.000078 seconds after the initial transmission (according to timestamps in the packet capture)
>> 3. the server retransmits the same 45 packets for a second time, 0.000061 seconds after the first retransmission.
>> 4. ACKs arrive that cover receipt of all data up to, but not including, those 45 packets. For the purpose of the following events, let those packets be numbered 1 through 45
>> 5. the server retransmits packet 1 for the third time
>> 6. multiple ACKs arrive covering packets 2 through 41
>> 7. the server retransmits packet 2
>> 8. two ACKs arrive for packet 41
>> 9. the server retransmits packet 1
>> 10. an ACK arrives for packet 41
>> 11. steps 9. and 10. repeat with incremental backoff. The connection is stuck at this point
>>
>>  From the kernel traces, we can tell the sender's state as follows:
>> snd_nxt = packet 3
>> high_seq and prior_snd_una = packet 1
>>
>> At this point, the sender believes it sent only packets 1 and 2, but the peer received more packets, up to packet 41. Packets 42 through 45 seem to have been lost.
>>
>> This is where we need help:
>> 1. why did the retransmission of the 45 packets start so shortly after the initial transmission?
>> 2. why were there two retransmissions?
>> 3. why did retransmission not start at the oldest unacknowledged packet, given that SACK was disabled?
>> 4. is this possible given the sequence of events, that snd_nxt and high_seq were reset in step 5. or 6. and what would be the reason for it?
>> 5. does this look like a bug in the TCP stack?
>> 6. any advice how we can further narrow this down?
>>
>> thank you,
>> Chris
> 
> Thanks for the report!
> 
> A few thoughts:
> 
> (1) For the trace you described in detail, would it be possible to
> place the binary .pcap file on a server somewhere and share the URL
> for the file? This will be vastly easier to diagnose if we can see the
> whole trace, and use visualization tools, etc. The best traces are
> those that capture the SYN and SYN/ACK, so we can see the option
> negotiation. (If the trace is large, keep in mind that usually
> analysis only requires the headers; tcpdump with "-s 120" is usually
> sufficient.)
> 
> (2) After that, would it be possible to try this test with a newer
> kernel? You mentioned this is with kernel version 5.10.165, but that's
> more than 2.5 years old at this point, and it's possible the bug has
> been fixed since then.  Could you please try this test with the newest
> kernel that is available in your distribution? (If you are forced to
> use 5.10.x on your distribution, note that even with 5.10.x there is
> v5.10.245, which was released yesterday.)
> 
> (3) If this bug is still reproducible with a recent kernel, would it
> be possible to gather .pcap traces from both client and server,
> including SYN and SYN/ACK? Sometimes it can be helpful to see the
> perspective of both ends, especially if there are middleboxes
> manipulating the packets in some way.
> 
> Thanks!
> 
> Best regards,
> neal

Hi Neal,

Thank you for your feedback. The pcap file for (1) is available at:
https://drive.google.com/drive/folders/147C8Fzt9hsStolASh1tcdJArEYq-wUkY?usp=sharing

Handshake: tcp-stuck-w10-no-sack-server-handshake-5.10.165.pcap
Full TCP session: tcp-stuck-w10-no-sack-server-5.10.165.pcap

I stripped TCP payloads for privacy reasons (snaplen 66), but it still 
shows nicely in Wireshark.

We will be getting to (2) and (3) hopefully by the end of this week. We 
won't have 5.10.245 available but we can try with 6.12.40

thanks,
Chris


