Return-Path: <netdev+bounces-70373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C9984E931
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 20:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6569D28648D
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 19:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492D43770B;
	Thu,  8 Feb 2024 19:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KUz6ACgh"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55FD381C8
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 19:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707422141; cv=none; b=jZPBs8bfhZJI7jBtMb0+hCdD+gtJ5Y9Qr5jvlBG/wrnp0X92QLDbD5glicnFJmLr9Rhhzu328zJe5vXsDD7rDCoHEk7IMZHk5qqw5zP6pZsF0VigwJxzkMoJci0KZ3RL1hJIsJXM50hNVFu5IEQ/QDggKc/dcKn48bPde/0igak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707422141; c=relaxed/simple;
	bh=vkKf4gqkH1It4tkpW4lg1bfbSOZ0v4L8Z1f03hZYaAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=h+PXSIWLqGvJdcFUpQTpkmNsuNkcMhaVft9V6iGVCWRsL8Tt2f3lPOdKeCo84G3wg1Xj63KtB8/ZrEBHD484+/DmAQAZcuSiHoWjG5vbuF0sZZLIBZxnAxq5ePQD06YvsvlwfIF3a2Nq53OA4ZXDGP56bn6y+q59JY8ntcr2JwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KUz6ACgh; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f454d60a-c68e-4fcc-a963-fc5c4503d0ee@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707422137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2qZwnf3eLT77F+wMd8d8ZV/ZKpHiRdigBmtJ9b/L80c=;
	b=KUz6ACghBhSNcw+ISCXzdqa0VPKyaZu2eVm7n5Hypv1jb4iBjc4ZGtXhrkxKWXAwkIdq8U
	ggsiK7IEe0RIxJ1MCIXQibPLjHIWS0PjfsKtXKkgN+pS/KlrBSeduO7ty2vh1y/RZ0S5Zd
	wlNaomAgLWcKWUb8U+auLN4olxYPz6U=
Date: Thu, 8 Feb 2024 14:55:25 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: SOF_TIMESTAMPING_OPT_ID is unreliable when sendmsg fails
Content-Language: en-US
To: Andy Lutomirski <luto@amacapital.net>,
 Willem de Bruijn <willemb@google.com>, "David S. Miller"
 <davem@davemloft.net>, Network Development <netdev@vger.kernel.org>,
 Jakub Kicinski <kuba@kernel.org>
References: <CALCETrU0jB+kg0mhV6A8mrHfTE1D1pr1SD_B9Eaa9aDPfgHdtA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <CALCETrU0jB+kg0mhV6A8mrHfTE1D1pr1SD_B9Eaa9aDPfgHdtA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 08/02/2024 18:02, Andy Lutomirski wrote:
> I’ve been using OPT_ID-style timestamping for years, but for some
> reason this issue only bit me last week: if sendmsg() fails on a UDP
> or ping socket, sk_tskey is poorly.  It may or may not get incremented
> by the failed sendmsg().
> 
Well, there are several error paths, for sure. For the sockets you
mention the increment of tskey happens at __ip{,6}_append_data. There
are 2 different types of failures which can happen after the increment.
The first is MTU check fail, another one is memory allocation failures.
I believe we can move increment to a later position, after MTU check in
both functions to avoid first type of problem.

> I can think of at least three ways to improve this:
> 
> 1. Make it so that the sequence number is genuinely only incremented
> on success. This may be tedious to implement and may be nearly
> impossible if there are multiple concurrent sendmsg() calls on the
> same socket.

Multiple concurrent sendmsg() should bring a lot of problems on user-
space side. With current implementation the application has to track the
value of tskey to check incoming TX timestamp later. But with parallel
sendmsg() the app cannot be sure which value is assigned to which call
even in case of proper track value synchronization. That brings us to
the other solutions if we consider having parallel threads working with
same socket. Or we can simply pretend that it's impossible and then fix
error path to decrement tskey value.
> 
> 2. Allow the user program to specify an explicit ID.  cmsg values are
> variable length, so for datagram sockets, extending the
> SO_TIMESTAMPING cmsg with 64 bits of sequence number to be used for
> the TX timestamp on that particular packet might be a nice solution.
> 

This option can be really useful in case of really parallel work with
sockets.

> 3. Add a getsockopt to read sk_tskey, which user code could use to
> determine the next sequence number after a failed sendmsg() call.

I don't believe it's usable interface. Especially if we think about
multiple threads working with the same socket.

> 
> Thanks,
> Andy




