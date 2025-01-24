Return-Path: <netdev+bounces-160834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9F9A1BB97
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 18:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A1623AD4BF
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 17:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD981D5147;
	Fri, 24 Jan 2025 17:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I/JMHkc1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C2E19E975
	for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 17:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737740422; cv=none; b=RUeazY2HM0UIxR3P8Ak05S3dt614dDb9H8QNFqopVXetAiU6TL70e38Bpi0Ds2lNfA+OPwKpQiaJHq07rU8G3n+rE/n6GnE2kk72Krt6Isy1ApTr2cvp0xuU2yTmbnEP6WgjDGAmkNkqHuVjydKumqZ7V6dzmimdz3MeySO6rX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737740422; c=relaxed/simple;
	bh=c7BfuM+aNXzOUVz+X9FBiS6MH1xtBeoLBoLWszcrx/A=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=OP7yaOcwOAk0hPKcXC0BrYJjqwqlAsRxVgwBn3pmpRzsaGNIfuwplTrKLwGHgnhqmI0CBRzhTEDrzBQDCvDqGCnvQbCFCJDs+Q2wmDHXaEtxaWwRX5atngKciuFSafpqXTa+Kv0rAlGzU1nWOZhjg6tHTIMjmp0MYxLPqJZPrQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I/JMHkc1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737740420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qiYtl14QZ7zAxHwkUe2JLFCtGQr8FTCdbM8LxS988CI=;
	b=I/JMHkc1SvGyBqOK+VdhWypF7qj3X24vWexpsR1sVOD3PNXIyLl6wkQIjHvIImG4Y0svTV
	61KstUm1bsIrBNvmvm8IHMPvCMYZoazSDx2YFDUR6XvYCCxyp0+F3NIMxCem6X1Eo0aLmJ
	3HP6Adh8EFQzwiGCz3mwnCQGKChrJYs=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-9x1bexOtPyOzbO4DW6rwgw-1; Fri, 24 Jan 2025 12:40:19 -0500
X-MC-Unique: 9x1bexOtPyOzbO4DW6rwgw-1
X-Mimecast-MFC-AGG-ID: 9x1bexOtPyOzbO4DW6rwgw
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7bb849aa5fbso532473485a.0
        for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 09:40:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737740418; x=1738345218;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qiYtl14QZ7zAxHwkUe2JLFCtGQr8FTCdbM8LxS988CI=;
        b=mRIU1Kk12CBDS8Z+7P4jnv8VaY4VuyDdcwbV02Ighnm2Eiaf9CNlIzdfJlKlhCd7WA
         t5iiX8Tp5/kKrCowxnJNzeKFun+REUGgB1xu3GO7X6+LPE6w6c66W6ym8+465sydKYB0
         7FWndYbz2mwijjB4o8bUaiqFf4S9ERtJ3IgzkFyWJ+s3lXUPdRpo58AZAUCxfPhLJktG
         L1Rhbp2COtu5TiPNP3YZgVSO5H2QV543oOXjrkQ7nxsDCio+01jx3R8mGIHUsNPRzszK
         mdAlraU3XKwAAFYptC3SDgCtWnRFbincOdTLFDrmu4p1eB6toCbPWILEGNmGvBWfXZm9
         AFGQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0QsQMw9JvR0ipR0MZfGPZjnx0hupfBf/Hjvq1uLhYxBcvIQJni6lr1dlXJkVU0tewCvobDTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF+dPN2tiIjEGHAlRQB+03IZWtzulD/8Baf5kQeV9Kr09Dga7C
	y2BKasGFIJGddZsY85dkh1wGcwQHUUVJvJKJ7dTaP6Opg80Zt+J6zcGnSlj11Pd5aYLvg3GKiXF
	5DCPXogrJVElXuiiaIXyk7q79jWd6KFk38UdfWCVf7s3mRBeQIh1XIw==
X-Gm-Gg: ASbGncvlkJ2eI8IiDDhfNtLXi1F++ZEUhwGwvOTlZolkFcMdqR+XL1aCDL77MdYskiP
	oZYXLjd+iN3zArM8U2zBPTgyhG9yDzWjAzBYY202Od0EpLsirw8Km8mSbVvzju5RZPnMAFaBQd2
	efQ4pXTzvFcDy3/VKp1gPI6bj3xRlaJQkRQwGXqzRpj0zWhz53obJWZosZPkqzDfkT0Cl98Z33e
	dG3UA1zH+Z4tAZvoiRDCdqyNWJ0eNWbsQ0JURoxLH2a7xdm9lhZR73pW00sx6JYFSyZ
X-Received: by 2002:a05:620a:408e:b0:7b6:eef3:aeaf with SMTP id af79cd13be357-7be6314c992mr4581223985a.0.1737740418532;
        Fri, 24 Jan 2025 09:40:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxmVhPWR7fVNGigt+spyE8WWD83ve2cHRaJVuBSHFxWI070EZJPVN31nh9mZWqAudHBkvXzQ==
X-Received: by 2002:a05:620a:408e:b0:7b6:eef3:aeaf with SMTP id af79cd13be357-7be6314c992mr4581220685a.0.1737740418235;
        Fri, 24 Jan 2025 09:40:18 -0800 (PST)
Received: from [10.0.0.215] ([24.225.235.209])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be9af0d181sm113605385a.105.2025.01.24.09.40.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2025 09:40:17 -0800 (PST)
Message-ID: <e15ff7f6-00b7-4071-866a-666a296d0b15@redhat.com>
Date: Fri, 24 Jan 2025 12:40:16 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jon Maloy <jmaloy@redhat.com>
Subject: Re: [net,v2] tcp: correct handling of extreme memory squeeze
To: Eric Dumazet <edumazet@google.com>
Cc: Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org,
 davem@davemloft.net, kuba@kernel.org, passt-dev@passt.top,
 sbrivio@redhat.com, lvivier@redhat.com, dgibson@redhat.com,
 eric.dumazet@gmail.com, Menglong Dong <menglong8.dong@gmail.com>
References: <20250117214035.2414668-1-jmaloy@redhat.com>
 <CADVnQymiwUG3uYBGMc1ZEV9vAUQzEOD4ymdN7Rcqi7yAK9ZB5A@mail.gmail.com>
 <afb9ff14-a2f1-4c5a-a920-bce0105a7d41@redhat.com>
 <c41deefb-9bc8-47b8-bff0-226bb03265fe@redhat.com>
 <CANn89i+RRxyROe3wx6f4y1nk92Y-0eaahjh-OGb326d8NZnK9A@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CANn89i+RRxyROe3wx6f4y1nk92Y-0eaahjh-OGb326d8NZnK9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025-01-20 11:22, Eric Dumazet wrote:
> On Mon, Jan 20, 2025 at 5:10 PM Jon Maloy <jmaloy@redhat.com> wrote:
>>
>>
>>
>> On 2025-01-20 00:03, Jon Maloy wrote:
>>>
>>>

[...]

>>>> I agree with Eric that probably tp->pred_flags should be cleared, and
>>>> a packetdrill test for this would be super-helpful.
>>>
>>> I must admit I have never used packetdrill, but I can make an effort.
>>
>> I hear from other sources that you cannot force a memory exhaustion with
>> packetdrill anyway, so this sounds like a pointless exercise.
> 
> We certainly can and should add a feature like that to packetdrill.
> 
> Documentation/fault-injection/ has some relevant information.
> 
> Even without this, tcp_try_rmem_schedule() is reading sk->sk_rcvbuf
> that could be lowered by a packetdrill script I think.
> 
Neal, Eric,
How do you suggest we proceed with this?
I downloaded packetdrill and tried it a bit, but to understand it well 
enough to introduce a new feature would require more time than I am
able to spend on this. Maybe Neal, who I see is one of the contributors 
to packetdrill could help out?

I can certainly clear tp->pred_flags and post it again, maybe with
an improved and shortened log. Would that be acceptable?

I also made a run where I looked into why __tcp_select_window()
ignores all the space that has been freed up:


  tcp_recvmsg_locked(->)
    __tcp_cleanup_rbuf(->) (copied 131072)
      tp->rcv_wup: 1788299855, tp->rcv_wnd: 5812224,
      tp->rcv_nxt 1793800175
      __tcp_select_window(->)
        tcp_space(->)
        tcp_space(<-) returning 458163
        free_space = round_down(458163, 1 << 4096) = 454656
        (free_space > tp->rcv_ssthresh) -->
          free_space = tp->rcv_ssthresh = 261920
        window = ALIGN(261920, 4096) = 26144
      __tcp_select_window(<-) returning 262144
      [rcv_win_now 311904, 2 * rcv_win_now 623808, new_window 262144]
      (new_window >= (2 * rcv_win_now)) ? --> time_to_ack 0
      NOT calling tcp_send_ack()
    __tcp_cleanup_rbuf(<-)
    [tp->rcv_wup 1788299855, tp->rcv_wnd 5812224,
     tp->rcv_nxt 1793800175]
  tcp_recvmsg_locked(<-) returning 131072 bytes.
  [tp->rcv_nxt 1793800175, tp->rcv_wnd 5812224,
   tp->rcv_wup 1788299855, sk->last_ack 0, tcp_receive_win() 311904,
   copied_seq 1788299855->1788395953 (96098), unread 5404222,
   sk_rcv_qlen 83, ofo_qlen 0]


As we see tp->rcv_ssthresh is the limiting factor, causing
a consistent situation where (new_window < (rcv_win_now * 2)),
and even (new_window < rcv_win_now).

To me, it looks like tp->ssthresh should have a higher value
in this situation, or maybe we should alter this test.

The combination of these two issues, -not updating tp->wnd and
_tcp_select_window() returning a wrong value, is what is causing
this whole problem.

///jon






