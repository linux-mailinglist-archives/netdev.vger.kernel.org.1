Return-Path: <netdev+bounces-134762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9A699B09C
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 06:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B7311C224FE
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 04:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33802EB02;
	Sat, 12 Oct 2024 04:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="avct6TWJ"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3761411185
	for <netdev@vger.kernel.org>; Sat, 12 Oct 2024 04:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728705733; cv=none; b=g1b83xiCCQB3up15da6JSmJVdkakaJpE0ipfz/obdQs0uI53Y4y28c9fJEjI8W55/xLPVbWLOTsESUZrrnKuo8ZY1Fcsat9oXhw2zW7hrGQxc6cI2s4L23cW3oV8jdTBnrJitrZYuaQ+kjIhQ6aYgrhzBtyfABv/9HLfzOLqoY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728705733; c=relaxed/simple;
	bh=JJ8yNaoSLbQlu6ZnBrINGtkz8scxtFJpO56qP+SBMmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jTDqAQjTi0mbiht+iRAw89WEy9nA51JTrsED/jJwfHZhs1vxEenxs1SGJSo14SQqhA5a4OIJRIrla7JD1BDMltGru4KH8PXy0RPAu80QvtqprpmKRePYKQ2VXSNyw0VsUZpDuggC0PAgB/mmeEm+TvTMvhbmDj4pwgcr1/4LQiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=avct6TWJ; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b55e2ca0-42f2-4b7c-b445-6ffd87ca74a0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728705729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XHFsvHATlCz4dsg86bj8ELTbqzh+gP01whmsEw8Guxc=;
	b=avct6TWJY2loZ2sdoiDX9QykwM1E8xkx0Ai4sRbw1YwXtK7PnRHelPmgpOwb4XwL8A2Tbr
	NFnI2ffKauXIsHgXvwsffCzi6qTl3hmWGJaKRqo7JX1zHjD/sxCcecntc6ncgd3EixwVXW
	tKy92GIHLV7mW/yiaPSOD4YSvHsIlqA=
Date: Fri, 11 Oct 2024 21:01:59 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 net] tcp/dccp: Don't use timer_pending() in
 reqsk_queue_unlink().
To: Kuniyuki Iwashima <kuniyu@amazon.com>, edumazet@google.com
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
 kuni1840@gmail.com, martin.lau@kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com
References: <CANn89iLUqJrO8VR2PTqNaZOb7Jn_CO1F792ec3cLNfXwgAdyrg@mail.gmail.com>
 <20241008144205.83199-1-kuniyu@amazon.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20241008144205.83199-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 10/8/24 7:42 AM, Kuniyuki Iwashima wrote:
> From: Eric Dumazet <edumazet@google.com>
> Date: Tue, 8 Oct 2024 16:28:53 +0200
>> On Tue, Oct 8, 2024 at 4:21 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
>>>
>>> From: Eric Dumazet <edumazet@google.com>
>>> Date: Tue, 8 Oct 2024 11:54:21 +0200
>>>> On Tue, Oct 8, 2024 at 1:53 AM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
>>>>>
>>>>> From: Jakub Kicinski <kuba@kernel.org>
>>>>> Date: Mon, 7 Oct 2024 16:26:10 -0700
>>>>>> On Mon, 7 Oct 2024 07:15:57 -0700 Kuniyuki Iwashima wrote:
>>>>>>> Martin KaFai Lau reported use-after-free [0] in reqsk_timer_handler().
>>>>>>>
>>>>>>>    """
>>>>>>>    We are seeing a use-after-free from a bpf prog attached to
>>>>>>>    trace_tcp_retransmit_synack. The program passes the req->sk to the
>>>>>>>    bpf_sk_storage_get_tracing kernel helper which does check for null
>>>>>>>    before using it.
>>>>>>>    """
>>>>>>
>>>>>> I think this crashes a bunch of selftests, example:
>>>>>>
>>>>>> https://netdev-3.bots.linux.dev/vmksft-nf-dbg/results/805581/8-nft-queue-sh/stderr
>>>>>
>>>>> Oops, sorry, I copy-and-pasted __inet_csk_reqsk_queue_drop()
>>>>> for different reqsk.  I'll squash the diff below.
>>>>>
>>>>> ---8<---
>>>>> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
>>>>> index 36f03d51356e..433c80dc57d5 100644
>>>>> --- a/net/ipv4/inet_connection_sock.c
>>>>> +++ b/net/ipv4/inet_connection_sock.c
>>>>> @@ -1188,7 +1190,7 @@ static void reqsk_timer_handler(struct timer_list *t)
>>>>>          }
>>>>>
>>>>>   drop:
>>>>> -       __inet_csk_reqsk_queue_drop(sk_listener, nreq, true);
>>>>> +       __inet_csk_reqsk_queue_drop(sk_listener, oreq, true);
>>>>>          reqsk_put(req);
>>>>>   }
>>>>>
>>>>> ---8<---
>>>>>
>>>>> Thanks!
>>>>
>>>> Just to clarify. In the old times rsk_timer was pinned, right ?
>>>>
>>>> 83fccfc3940c4 ("inet: fix potential deadlock in reqsk_queue_unlink()")
>>>> was fine I think.
>>>>
>>>> So the bug was added recently ?
>>>>
>>>> Can we give a precise Fixes: tag ?
>>>
>>> TIMER_PINNED was used in reqsk_queue_hash_req() in v6.4 mentioned
>>> by Martin and still used in the latest net-next.
>>>
>>> $ git blame -L:reqsk_queue_hash_req net/ipv4/inet_connection_sock.c v6.4
>>> 079096f103fac (Eric Dumazet             2015-10-02 11:43:32 -0700 1095) static void reqsk_queue_hash_req(struct request_sock *req,
>>> 079096f103fac (Eric Dumazet             2015-10-02 11:43:32 -0700 1096)                                  unsigned long timeout)
>>> fa76ce7328b28 (Eric Dumazet             2015-03-19 19:04:20 -0700 1097) {
>>> 59f379f9046a9 (Kees Cook                2017-10-16 17:29:19 -0700 1098)         timer_setup(&req->rsk_timer, reqsk_timer_handler, TIMER_PINNED);
>>>
>>> Maybe the connection was localhost, or unlikely but RPS was
>>> configured after SYN+ACK, or setup like ff46e3b44219 was used ??

I don't know what exactly caused the ack to be handled on a different CPU. We 
have a recent packet steering test, so it could be caused by this test 
adjusting the steering config.

>>
>> I do not really understand the issue.
>> How a sk can be 'closed' with outstanding request sock ?
>> They hold a refcount on the listener.
> 
> My understanding is
> 
> 1. inet_csk_complete_hashdance() calls inet_csk_reqsk_queue_drop(),
>     but del_timer_sync() is missed
> 
> 2. reqsk timer is executed and scheduled again
> 
> 3. req->sk is accept()ed, but inet_csk_accept() does not clear
>     req->sk for non-TFO sockets, and reqsk_put() decrements one
>     refcnt, but still reqsk timer has another one
> 
> 4. sk is close()d
> 
> 5. reqsk timer is executed again, and BPF touches req->sk

The above is also what I think is happening.
The kernel reqsk_timer_handler() is not using req->sk, so it has not been an issue.

> 
> reqsk timer will run for 63s by default, so I think it's possible
> that sk is close()d earlier than the timer expiration.
> 


