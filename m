Return-Path: <netdev+bounces-115258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA43C945A43
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 10:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E08C286D48
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 08:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630201BF30D;
	Fri,  2 Aug 2024 08:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aw1vfFK9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35853132139;
	Fri,  2 Aug 2024 08:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722588512; cv=none; b=KdVS6QDetsbtNhaaZmoO82k2rDk+dE1whw5NS0dKg+ZuQDqoyl4shCUrk/N6heY7ehIwLLfOhvdE51eoAjF543JizgkmdGeak7YIjOjrfPH9qKkVTmY/vy7aZbqXgGwt92rVzN8mkgU/USiPRDxL/agRzcIAnqmy/LY2w3jTdg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722588512; c=relaxed/simple;
	bh=cQwlhsKmJKAFEKRQ/MzNl2oigPWjtiwSf5Pvm1J5Iuo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CfjiHD4Egc67eRzD24+1Mm6Lhg+fAsSexBd9K9InweWa4mQjEEbKZ7YWUXV7S6LxyumKroLgZ+CPo+DGeMxIDg8rl42Q6peAJ5M/PYJDQZHl4tUzbeom+2qV/6z7pJNXH3JAer753MciZbvMVDEPDGI3q7nATjHt5T6nZIMb7N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aw1vfFK9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5A5DC32782;
	Fri,  2 Aug 2024 08:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722588511;
	bh=cQwlhsKmJKAFEKRQ/MzNl2oigPWjtiwSf5Pvm1J5Iuo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Aw1vfFK9apg27Eh/1gmfHYfcrIr/w87XQZpiYjP8gCQ5ZEcbXaFOI1HcqQs26h5kw
	 WIuXOdlbri6X9DdHtr4qUDDSEnXi6u6+Oc6JPO1PsY0gVwOmihazc0RSahOKFZioBJ
	 Pmko/jMn6kt69UramvxjvdofOhgenLTw9Z8pzGvWc4pxjnodxDyBhxJQwUv7+xKWJD
	 K5a/Z4C53jwoiD/1naccN5Q3IkuDF3sgzqJ5Du0wr5Twi0RYG+Upq1N5x31zsqKZFo
	 khQtfpoXhLTd5Kdf0mlNZEdlywEPTxbZvp9p8ZzNAz0M67v1EItO/cN56OcTnHw7E+
	 /v4bxQPRJdFnw==
Message-ID: <79e327c5-f87f-4295-b461-81c09a699af6@kernel.org>
Date: Fri, 2 Aug 2024 10:48:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next] tcp: limit wake-up for crossed SYN cases with
 SYN-ACK
Content-Language: en-GB
To: Eric Dumazet <edumazet@google.com>
Cc: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>,
 David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>
References: <20240801-upstream-net-next-20240801-tcp-limit-wake-up-x-syn-v1-1-3a87f977ad5f@kernel.org>
 <CANn89iK6PxVuPu_nwTBiHy8JLuX+RTvnNGC3m64nBN7j1eENxQ@mail.gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <CANn89iK6PxVuPu_nwTBiHy8JLuX+RTvnNGC3m64nBN7j1eENxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 01/08/2024 19:52, Eric Dumazet wrote:
> On Thu, Aug 1, 2024 at 6:39 PM Matthieu Baerts (NGI0)
> <matttbe@kernel.org> wrote:
>>
>> In TCP_SYN_RECV states, sk->sk_socket will be assigned in case of
>> marginal crossed SYN, but also in other cases, e.g.
>>
>>  - With TCP Fast Open, if the connection got accept()'ed before
>>    receiving the 3rd ACK ;
>>
>>  - With MPTCP, when accepting additional subflows to an existing MPTCP
>>    connection.
>>
>> In these cases, the switch to TCP_ESTABLISHED is done when receiving the
>> 3rd ACK, without the SYN flag then.
>>
>> To properly restrict the wake-up to crossed SYN cases as expected there,
>> it is then required to also limit the check to packets containing the
>> SYN-ACK flags.
>>
>> Without this modification, it looks like the wake-up was not causing any
>> visible issue with TFO and MPTCP, apart from not being needed. That's
>> why this patch doesn't contain a Cc to stable, and a Fixes tag.
>>
>> While at it, the attached comment has also been updated: sk->sk_sleep
>> has been removed in 2010, and replaced by sk->sk_wq in commit
>> 43815482370c ("net: sock_def_readable() and friends RCU conversion").
>>
>> Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> Notes:
>>   - This is the same patch as the one suggested earlier in -net as part
>>     of another series, but targeting net-next (Eric), and with an
>>     updated commit message. The previous version was visible there:
>>     https://lore.kernel.org/20240718-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v2-2-d653f85639f6@kernel.org/
>> ---
> 
> Note: I am not aware of any tests using FASYNC
> 
> sock_wake_async() / kill_fasync() are sending signals, not traditional wakeups.

Thank you for the review and the explanation!

> Do we really want to potentially break some applications still using
> pre-multi-thread era async io ?

They are potentially already broken if we don't test them :-D

> Not that I really care, but I wonder why you care :)

More seriously, I sent this patch, because in previous discussions about
the crossed SYN case, Kuniyuki mentioned that he used the same condition
as the one I modified here. I didn't see why it is needed to send such
signal there for TFO and MPTCP cases, so I sent this patch. On the other
hand, I suppose such old apps relying on FASYNC will not natively use
TFO or MPTCP (except if they are forced externally).

In other words, I'm not fixing a problem I saw here, I'm only
restricting the condition to crossed SYN case, as mentioned in the
linked comment, then excluding TFO and MPTCP cases that don't seem to
require this signal at that moment. But then it's fine for me to drop
this patch if you think it is not needed :)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


