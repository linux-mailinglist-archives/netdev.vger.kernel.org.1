Return-Path: <netdev+bounces-161401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 760C9A20F36
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 17:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BC8B3A8F9E
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 16:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE2919DF52;
	Tue, 28 Jan 2025 16:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oa0XH6Hm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE35194A67
	for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 16:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738083096; cv=none; b=FV/YTTvNlHDOPV5EOJNu7e0xYNXhXyiJo40B7qD9DJ2Ht9NHPQA7dU/ANRBukfYlMQAYV1ZXn4Shg+OxkGLayS9OdGPz6k3MvUlluHFg8jTTT4ZSsHbX0B3ocEBuv3AWiIo76dJPPHvPhIONPydd7gDGJlJiqBFChjmWpVoNnBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738083096; c=relaxed/simple;
	bh=0v6vhp14HNiEF4v500LR2QRhHQWjpUkgmORQMyl4yNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=isaNYoXm33DilpAXRxbhrByuh9tGSUvt+7qvCJZ2KZtUp3jwFiFyr960L5CShmYTj2U0SngUX0lr+36/BsFQuq4Avc1SWzwPqmwGk2mJT9S0KuFI8MxmHAmZOeXVzn728B8KyuYGN8IIj+5oERSCcIl7iPVEi6JDJlODwkjt674=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oa0XH6Hm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738083093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rboJfVxLlAbl2p+2/ud8/N7Cynxru4+mLw79GAjRHYA=;
	b=Oa0XH6HmWPzU2cG8ieXJbrXvKfbxAzHYsT/rX1iEQ9oBwq2Ki3zHmODOyPEL2z02a6XfSF
	0S+5dIAhIFLvKcZxuRRjPI/HKjh1VF7+DJ7uFUrfUTXe34IFWX70oIWf9LXsAykURKw0Ja
	dqOpfHfMsjQxx7OGFo6u8q1L3ZLeQRQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-cJq5NMMcO4aa4nYWOUoSOg-1; Tue, 28 Jan 2025 11:51:32 -0500
X-MC-Unique: cJq5NMMcO4aa4nYWOUoSOg-1
X-Mimecast-MFC-AGG-ID: cJq5NMMcO4aa4nYWOUoSOg
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4679d6ef2f9so137360821cf.1
        for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 08:51:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738083092; x=1738687892;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rboJfVxLlAbl2p+2/ud8/N7Cynxru4+mLw79GAjRHYA=;
        b=J+73hLCjmH18RbiUxqUOeG7XVaKbp5+08r6LDgToeYMgi6vT4sxJCB/rl+UtofwGXS
         SNCQaHhtbS7p1e0BXeG4EVrR0UhE2S26V3DNMoBGSKkTifin3Wpc2Hb7eGWimFDJ1VDI
         ipPK/TjOQ6HFIl8Hef9Px6mZiJ5ahaYORrWwHn9L0uBi8qXvhdRpmjBLV2J0F95bndrk
         4FdYEcEEvCK5YYNHS6qYSBCTcKQexHyh4G2khjb1KMU9iGRBTmPGqM/Wziwm8uLEs4Lt
         gEUwQS062pXEWFuDpaDo1qOlhGUKr+bHDYOpXu2mvHjVpmb04vSr6W4SUUN/L2vH1ba7
         /olg==
X-Gm-Message-State: AOJu0YzcCwIFcg2pxjCZvmKGVcdE2FOkZsC7zFo+eI+XF1wAZick1Q7h
	xUCMrM66MVL0J+79UaKCtQHAhtpm25JvL3/Syhq41sgTmBV9WZuIML18HGZLfY5TDexQYR8ugZz
	MLSJnR5X30bs6GJn2nRgv0Z0Hl/hNXU0RpLPYq7TKRG0foygfm65YmVzAuHmIid1n
X-Gm-Gg: ASbGncuuB8OW6767xzcLUin7l3Iv1tb5V8BiYFaRoTBiAXq+aO5bQ0uL4CRUbFVXSYG
	GwPHveaxviGxE4+DKG7QXmlYmsFKE6k2KQk+FcCKJAflRMoMA20i1Dgv57H9L9RLuQycTOytCUA
	/p9pOwzyO0lGvzfQh2Tn811atuTOS9RXAkS93ngIi1phzsZnm4chVdi2vEKP8se2z1Lse18QjgX
	TzGnaTmW6NC0LktbpfatCD1MIfAYj1b1vz7V3mvoTH6/yYyf9jny3V0hy/8Ctj87fDrwY9QZGsL
	Qgs=
X-Received: by 2002:a05:622a:199b:b0:46c:728c:8862 with SMTP id d75a77b69052e-46e12ab5b44mr741513551cf.31.1738083091566;
        Tue, 28 Jan 2025 08:51:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWMOKu3lU0YUt5wBrqc9F1Vb18MZCLlzXjmORmdWniXRd2yyciy6lpkjhypCkXKu8l02olUQ==
X-Received: by 2002:a05:622a:199b:b0:46c:728c:8862 with SMTP id d75a77b69052e-46e12ab5b44mr741512991cf.31.1738083091058;
        Tue, 28 Jan 2025 08:51:31 -0800 (PST)
Received: from [10.0.0.215] ([24.225.235.209])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46fc968abc1sm6680311cf.58.2025.01.28.08.51.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2025 08:51:30 -0800 (PST)
Message-ID: <415dde0a-2272-45d2-8fa8-473fe7637a78@redhat.com>
Date: Tue, 28 Jan 2025 11:51:29 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net,v3] tcp: correct handling of extreme memory squeeze
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 passt-dev@passt.top, sbrivio@redhat.com, lvivier@redhat.com,
 dgibson@redhat.com, memnglong8.dong@gmail.com, kerneljasonxing@gmail.com,
 ncardwell@google.com, eric.dumazet@gmail.com
References: <20250127231304.1465565-1-jmaloy@redhat.com>
 <CANn89i+x2RGHDA6W-oo=Hs8bM=4Ao_aAKFsRrFhq=U133j+FvA@mail.gmail.com>
Content-Language: en-US
From: Jon Maloy <jmaloy@redhat.com>
In-Reply-To: <CANn89i+x2RGHDA6W-oo=Hs8bM=4Ao_aAKFsRrFhq=U133j+FvA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025-01-28 10:04, Eric Dumazet wrote:
> On Tue, Jan 28, 2025 at 12:13 AM <jmaloy@redhat.com> wrote:
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
>> This means that this side's notion of the current window size is
>> different from the one last advertised to the peer, causing the latter
>> to not send any data to resolve the sitution.
>>
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
>>                         [copied_seq 259909392->260034360 (124968), unread 5565800, qlen 85, ofoq 0]
>>                         [OFO queue: gap: 65480, len: 0]
>> [5201<->39222]:     tcp_data_queue(<-)
>> [5201<->39222]:     __tcp_transmit_skb(->)
>>                          [tp->rcv_wup: 265469200, tp->rcv_wnd: 262144, tp->rcv_nxt 265600160]
>> [5201<->39222]:       tcp_select_window(->)
>> [5201<->39222]:         (inet_csk(sk)->icsk_ack.pending & ICSK_ACK_NOMEM) ? --> TRUE
>>                          [tp->rcv_wup: 265469200, tp->rcv_wnd: 262144, tp->rcv_nxt 265600160]
>>                          returning 0
>> [5201<->39222]:       tcp_select_window(<-)
>> [5201<->39222]:       ADVERTISING WIN 0, ACK_SEQ: 265600160
>> [5201<->39222]:     [__tcp_transmit_skb(<-)
>> [5201<->39222]:   tcp_rcv_established(<-)
>> [5201<->39222]: tcp_v4_rcv(<-)
>>
>> // Receive queue is at 85 buffers and we are out of memory.
>> // We drop the incoming buffer, although it is in sequence, and decide
>> // to send an advertisement with a window of zero.
>> // We don't update tp->rcv_wnd and tp->rcv_wup accordingly, which means
>> // we unconditionally shrink the window.
>>
>> [5201<->39222]: tcp_recvmsg_locked(->)
>> [5201<->39222]:   __tcp_cleanup_rbuf(->) tp->rcv_wup: 265469200, tp->rcv_wnd: 262144, tp->rcv_nxt 265600160
>> [5201<->39222]:     [new_win = 0, win_now = 131184, 2 * win_now = 262368]
>> [5201<->39222]:     [new_win >= (2 * win_now) ? --> time_to_ack = 0]
>> [5201<->39222]:     NOT calling tcp_send_ack()
>>                      [tp->rcv_wup: 265469200, tp->rcv_wnd: 262144, tp->rcv_nxt 265600160]
>> [5201<->39222]:   __tcp_cleanup_rbuf(<-)
>>                    [rcv_nxt 265600160, rcv_wnd 262144, snt_ack 265469200, win_now 131184]
>>                    [copied_seq 260040464->260040464 (0), unread 5559696, qlen 85, ofoq 0]
>>                    returning 6104 bytes
>> [5201<->39222]: tcp_recvmsg_locked(<-)
>>
>> // After each read, the algorithm for calculating the new receive
>> // window in __tcp_cleanup_rbuf() finds it is too small to advertise
>> // or to update tp->rcv_wnd.
>> // Meanwhile, the peer thinks the window is zero, and will not send
>> // any more data to trigger an update from the interrupt mode side.
>>
>> [5201<->39222]: tcp_recvmsg_locked(->)
>> [5201<->39222]:   __tcp_cleanup_rbuf(->) tp->rcv_wup: 265469200, tp->rcv_wnd: 262144, tp->rcv_nxt 265600160
>> [5201<->39222]:     [new_win = 262144, win_now = 131184, 2 * win_now = 262368]
>> [5201<->39222]:     [new_win >= (2 * win_now) ? --> time_to_ack = 0]
>> [5201<->39222]:     NOT calling tcp_send_ack()
>>                      [tp->rcv_wup: 265469200, tp->rcv_wnd: 262144, tp->rcv_nxt 265600160]
>> [5201<->39222]:   __tcp_cleanup_rbuf(<-)
>>                    [rcv_nxt 265600160, rcv_wnd 262144, snt_ack 265469200, win_now 131184]
>>                    [copied_seq 260099840->260171536 (71696), unread 5428624, qlen 83, ofoq 0]
>>                    returning 131072 bytes
>> [5201<->39222]: tcp_recvmsg_locked(<-)
>>
>> // The above pattern repeats again and again, since nothing changes
>> // between the reads.
>>
>> [...]
>>
>> [5201<->39222]: tcp_recvmsg_locked(->)
>> [5201<->39222]:   __tcp_cleanup_rbuf(->) tp->rcv_wup: 265469200, tp->rcv_wnd: 262144, tp->rcv_nxt 265600160
>> [5201<->39222]:     [new_win = 262144, win_now = 131184, 2 * win_now = 262368]
>> [5201<->39222]:     [new_win >= (2 * win_now) ? --> time_to_ack = 0]
>> [5201<->39222]:     NOT calling tcp_send_ack()
>>                      [tp->rcv_wup: 265469200, tp->rcv_wnd: 262144, tp->rcv_nxt 265600160]
>> [5201<->39222]:   __tcp_cleanup_rbuf(<-)
>>                    [rcv_nxt 265600160, rcv_wnd 262144, snt_ack 265469200, win_now 131184]
>>                    [copied_seq 265600160->265600160 (0), unread 0, qlen 0, ofoq 0]
>>                    returning 54672 bytes
>> [5201<->39222]: tcp_recvmsg_locked(<-)
>>
>> // The receive queue is empty, but no new advertisement has been sent.
>> // The peer still thinks the receive window is zero, and sends nothing.
>> // We have ended up in a deadlock situation.
> 
> This so-called 'deadlock' only occurs if a remote TCP stack is unable
> to send win0 probes.
> 
> In this case, sending some ACK will not help reliably if these ACK get lost.
> 
> I find the description tries very hard to hide a bug in another stack,
> for some reason.

I clearly stated in a previous comment that this was the case, and that
it has been fixed now. My reason for posting this is because I still
think this is a bug, just as I think the way we use rcv_ssthresh in 
_tcp_select)window() is a bug that eventually should be fixed.

> 
> When under memory stress, not sending an opening ACK as fast as possible,
> giving time for the host to recover from this memory stress was also a
> sensible thing to do.
> 
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> 
> Thanks for the fix.
> 


