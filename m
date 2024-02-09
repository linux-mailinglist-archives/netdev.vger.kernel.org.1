Return-Path: <netdev+bounces-70431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A7684EF5D
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 04:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D9121C24BCC
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 03:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC144A39;
	Fri,  9 Feb 2024 03:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ci88VPMR"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3344C89
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 03:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707448959; cv=none; b=Ot/Eak+IpeCfvMCLIA2E3l/C9QQMAVykjUoKqXRF0TblmnbospPd4HsPIPz1brrQ7L2mmmgFniXnMMHRc0PPab93O/Al5TKfmW3rO6dQUPSrm0fJm5I1FIjEnW/3yvIsPqB6Tb/bxC4EJqQBE5hshtoFdc+5yFjIzleFVD6u3yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707448959; c=relaxed/simple;
	bh=9a3iW9pbuJ745EVDY22B0e9Upfs70edXuETeQluUv2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j/wMyhjjMw++sYX3iBfTwGaOHgK1BL+m7B5H6XTKfvjn+KSD/xDwRNhGydwx5tK7tp0MW5opmXMXBEOfDsOoggLYi+4Q05bhp4vScyTuNyvIUdxgNJhbvhozs0ap6bNxZ9PWcoxrkAB9p4+nvJ8ueE6+qGBaMBRGNsPUkw35D3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ci88VPMR; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <afdc2a12-7069-4c68-97d3-cf514233de1c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707448954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7oHm7DmLnqsZ9rq14xTTpmvxVr6pywXIKTIbzOBP3Rs=;
	b=Ci88VPMRETWmGen8QQQ+qh7dAIlTdx0GhJ5oBQhJWGRKPrx6D0G3RBR0OeXgbFR60+9/ge
	GNgYmH47s/Q9soYPhf+Qa143Dkjo5WJNbbE/SZTqKC/07S1jK+Cv6WfpgeNyPVRE5Rwov+
	8WM94IVW4J+hOw4sJBySkI5s6RPBNPY=
Date: Thu, 8 Feb 2024 22:22:21 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: SOF_TIMESTAMPING_OPT_ID is unreliable when sendmsg fails
Content-Language: en-US
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Andy Lutomirski <luto@amacapital.net>
Cc: Willem de Bruijn <willemb@google.com>,
 "David S. Miller" <davem@davemloft.net>,
 Network Development <netdev@vger.kernel.org>,
 Jakub Kicinski <kuba@kernel.org>
References: <CALCETrU0jB+kg0mhV6A8mrHfTE1D1pr1SD_B9Eaa9aDPfgHdtA@mail.gmail.com>
 <f454d60a-c68e-4fcc-a963-fc5c4503d0ee@linux.dev>
 <CALCETrWu63SB+R8hw-1gZ-fbutXAAFKuWJD-wJ9GejX+p8jhSw@mail.gmail.com>
 <65c54cc9ea70c_1cb6bf29492@willemb.c.googlers.com.notmuch>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <65c54cc9ea70c_1cb6bf29492@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 08/02/2024 21:51, Willem de Bruijn wrote:
> Andy Lutomirski wrote:
>> On Thu, Feb 8, 2024 at 11:55 AM Vadim Fedorenko
>> <vadim.fedorenko@linux.dev> wrote:
>>>
>>> On 08/02/2024 18:02, Andy Lutomirski wrote:
>>>> I’ve been using OPT_ID-style timestamping for years, but for some
>>>> reason this issue only bit me last week: if sendmsg() fails on a UDP
>>>> or ping socket, sk_tskey is poorly.  It may or may not get incremented
>>>> by the failed sendmsg().
> 
> The intent is indeed to only increment on a successful send.
> 
> The implementation is complicated a bit by (1) being a socket level
> option, thus also supporting SOCK_RAW and (2) MSG_MORE using multiple
> send calls to only produce a single datagram and (3) fragmentation
> producing multiple skbs for a single datagram.
> 
> If only SOCK_DGRAM, conceivably we could move this to udp_send_skb,
> after the skb is created and after the usual error exit paths.
> 
> An alternative is in error paths to decrement the counter. This is
> what we do for MSG_ZEROCOPY references. Unfortunately, with the
> lockless UDP path, other threads could come inbetween the inc and dec,
> so this is not really workable.

As I've mentioned before, parallelism with OPT_ID is unpredictable by
design, I don't believe we have real apps doing this, so I think it's
better to decrement sk_tskey to have consistent behavior. I can make the
patch to do it.

>>> Well, there are several error paths, for sure. For the sockets you
>>> mention the increment of tskey happens at __ip{,6}_append_data. There
>>> are 2 different types of failures which can happen after the increment.
>>> The first is MTU check fail, another one is memory allocation failures.
>>> I believe we can move increment to a later position, after MTU check in
>>> both functions to avoid first type of problem.
>>
>> For reasons that I still haven't deciphered, I'm sporadically getting
>> EHOSTUNREACH after the increment.  I can't find anything in the code
>> that would cause that, and every time I try to instrument it, it stops
>> happening :(  I sendmsg to the same destination several times in rapid
>> succession, and at most one of them will get EHOSTUNREACH.
> 
> UDP might fail on ICMP responses. Try sending to a closed port. A few
> send calls will succeed, but eventually the send call will refuse to
> send. The cause is in the IP layer.
> 
>>>
>>>> I can think of at least three ways to improve this:
>>>>
>>>> 1. Make it so that the sequence number is genuinely only incremented
>>>> on success. This may be tedious to implement and may be nearly
>>>> impossible if there are multiple concurrent sendmsg() calls on the
>>>> same socket.
>>>
>>> Multiple concurrent sendmsg() should bring a lot of problems on user-
>>> space side. With current implementation the application has to track the
>>> value of tskey to check incoming TX timestamp later. But with parallel
>>> sendmsg() the app cannot be sure which value is assigned to which call
>>> even in case of proper track value synchronization. That brings us to
>>> the other solutions if we consider having parallel threads working with
>>> same socket. Or we can simply pretend that it's impossible and then fix
>>> error path to decrement tskey value.
>>>>
>>>> 2. Allow the user program to specify an explicit ID.  cmsg values are
>>>> variable length, so for datagram sockets, extending the
>>>> SO_TIMESTAMPING cmsg with 64 bits of sequence number to be used for
>>>> the TX timestamp on that particular packet might be a nice solution.
>>>>
>>>
>>> This option can be really useful in case of really parallel work with
>>> sockets.
>>
>> I personally like this one the best.  Some care would be needed to
>> allow programs to detect the new functionality.  Any preferred way to
>> handle it?
> 
> Regardless of whether we can fix the existing behavior, I also think
> this is a worthwhile cmsg. As timestamping is a SOL_SOCKET option, the
> cmsg should likely also be that, processed in __sock_cmsg_send.

Do you think about extending inet_cork and sockcm_cookie to provide
OPT_ID value? If yes, I can give it a try also.



