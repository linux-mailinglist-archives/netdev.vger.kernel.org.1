Return-Path: <netdev+bounces-172398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8FEA54767
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 11:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6A89171E37
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 10:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEAF21FCFE6;
	Thu,  6 Mar 2025 10:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4TZxPxm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD59C1C6FE1;
	Thu,  6 Mar 2025 10:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741255962; cv=none; b=UcBxoW6vC3zw239THG7zalOb8ieLUAv7/zh9tGS6oGu69++uZKc1bKlFTOXGFwhuDiddQrT8xAzkhwywVxtoE19MbJ95xwess9/uIw0ELsiobkPP06tooPTnB7EMb7j8qOlAzfa6J3RnxyGrE0xB51v/NZNNyOtPhfWLxx3QViE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741255962; c=relaxed/simple;
	bh=EEyYORts2CMueLDR9VZbU5UMnAqVG45Sr/bOW0NMhmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o/JObz46ZM6s3EPQufcSBx04fRUj0QabwstVrxIG9hwCipLKurMvV+3qZ/QquANG7BpGG7FA5GqElfhu638yjhHIJj8IU1lGRuLGawOc87NRdi+efaaJB7kmceWRpzW8EP0poMHqu34+/A6fEVR5/NKlsnY4lbTS/EYHteuZz1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4TZxPxm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0608C4CEE0;
	Thu,  6 Mar 2025 10:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741255962;
	bh=EEyYORts2CMueLDR9VZbU5UMnAqVG45Sr/bOW0NMhmA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=L4TZxPxmtq0jcpy7Sb1fJTA5fgxlkRosdts8TFcF5tYqHJPWgp5YbKYnTpqhzZ5w4
	 7SI4a2byI9ua5WQL9pOIG8yjzjKhm+WayFhI3UoId2cRPI4QPI60rvS+cm18+tBkNH
	 e357EZYrTtR4wSTJWtGdWcYvfxzqhtzlG2SWDrGcEPYq+9+aWFC9Oa3OB++DZydayp
	 jtmaQr49l+dMShIJ1qvcspH4slr7w05up649FWpz3Ukiy1Ci7DaJxwQe4BFDrPd2oB
	 0bGwDvP1OEouIjwJyZjWgbUZrhNlp2urdiqqiFY3r98J+d1v6RUBlza0ijx+SG8isQ
	 9Wt1+u/NIJnXA==
Message-ID: <a3266974-d561-4e8f-a23a-9c0774ee2bbe@kernel.org>
Date: Thu, 6 Mar 2025 11:12:36 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next] tcp: clamp window like before the cleanup
Content-Language: en-GB
To: Eric Dumazet <edumazet@google.com>
Cc: Jason Xing <kerneljasonxing@gmail.com>, mptcp@lists.linux.dev,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250305-net-next-fix-tcp-win-clamp-v1-1-12afb705d34e@kernel.org>
 <CAL+tcoAqZmeV0-4rjH-EPmhBBaS=ZSwgcXhU8ZsBCr_aXS3Lqw@mail.gmail.com>
 <CANn89iLqgi5byZd+Si7jTdg7zrLNn13ejWAQjMRurvrQPeg3zg@mail.gmail.com>
 <281edb3a-4679-4c75-9192-a5f0ef6952ea@kernel.org>
 <CANn89iKVsDrL9YFx883wTfRSAe6tOR7x2U5zk=TcgHBMr+VtkQ@mail.gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <CANn89iKVsDrL9YFx883wTfRSAe6tOR7x2U5zk=TcgHBMr+VtkQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 06/03/2025 11:02, Eric Dumazet wrote:
> On Thu, Mar 6, 2025 at 10:55 AM Matthieu Baerts <matttbe@kernel.org> wrote:
>>
>> Hi Eric,
>>
>> On 06/03/2025 10:45, Eric Dumazet wrote:
>>> On Thu, Mar 6, 2025 at 6:22 AM Jason Xing <kerneljasonxing@gmail.com> wrote:
>>>>
>>>> On Wed, Mar 5, 2025 at 10:49 PM Matthieu Baerts (NGI0)
>>>> <matttbe@kernel.org> wrote:
>>>>>
>>>>> A recent cleanup changed the behaviour of tcp_set_window_clamp(). This
>>>>> looks unintentional, and affects MPTCP selftests, e.g. some tests
>>>>> re-establishing a connection after a disconnect are now unstable.
>>>>>
>>>>> Before the cleanup, this operation was done:
>>>>>
>>>>>   new_rcv_ssthresh = min(tp->rcv_wnd, new_window_clamp);
>>>>>   tp->rcv_ssthresh = max(new_rcv_ssthresh, tp->rcv_ssthresh);
>>>>>
>>>>> The cleanup used the 'clamp' macro which takes 3 arguments -- value,
>>>>> lowest, and highest -- and returns a value between the lowest and the
>>>>> highest allowable values. This then assumes ...
>>>>>
>>>>>   lowest (rcv_ssthresh) <= highest (rcv_wnd)
>>>>>
>>>>> ... which doesn't seem to be always the case here according to the MPTCP
>>>>> selftests, even when running them without MPTCP, but only TCP.
>>>>>
>>>>> For example, when we have ...
>>>>>
>>>>>   rcv_wnd < rcv_ssthresh < new_rcv_ssthresh
>>>>>
>>>>> ... before the cleanup, the rcv_ssthresh was not changed, while after
>>>>> the cleanup, it is lowered down to rcv_wnd (highest).
>>>>>
>>>>> During a simple test with TCP, here are the values I observed:
>>>>>
>>>>>   new_window_clamp (val)  rcv_ssthresh (lo)  rcv_wnd (hi)
>>>>>       117760   (out)         65495         <  65536
>>>>>       128512   (out)         109595        >  80256  => lo > hi
>>>>>       1184975  (out)         328987        <  329088
>>>>>
>>>>>       113664   (out)         65483         <  65536
>>>>>       117760   (out)         110968        <  110976
>>>>>       129024   (out)         116527        >  109696 => lo > hi
>>>>>
>>>>> Here, we can see that it is not that rare to have rcv_ssthresh (lo)
>>>>> higher than rcv_wnd (hi), so having a different behaviour when the
>>>>> clamp() macro is used, even without MPTCP.
>>>>>
>>>>> Note: new_window_clamp is always out of range (rcv_ssthresh < rcv_wnd)
>>>>> here, which seems to be generally the case in my tests with small
>>>>> connections.
>>>>>
>>>>> I then suggests reverting this part, not to change the behaviour.
>>>>>
>>>>> Fixes: 863a952eb79a ("tcp: tcp_set_window_clamp() cleanup")
>>>>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/551
>>>>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>>>>
>>>> Tested-by: Jason Xing <kerneljasonxing@gmail.com>
>>>>
>>>> Thanks for catching this. I should have done more tests :(
>>>>
>>>> Now I use netperf with TCP_CRR to test loopback and easily see the
>>>> case where tp->rcv_ssthresh is larger than tp->rcv_wnd, which means
>>>> tp->rcv_wnd is not the upper bound as you said.
>>>>
>>>> Thanks,
>>>> Jason
>>>>
>>>
>>> Patch looks fine to me but all our tests are passing with the current kernel,
>>> and I was not able to trigger the condition.
>>
>> Thank you for having looked at this patch!
>>
>>
>>> Can you share what precise test you did ?
>>
>> To be able to get a situation where "rcv_ssthresh > rcv_wnd", I simply
>> executed MPTCP Connect selftest. You can also force creating TCP only
>> connections with '-tt', e.g.
>>
>>   ./mptcp_connect.sh -tt
> 
> I was asking Jason about TCP tests. He mentioned TCP_CRR

Oops, I'm sorry, I didn't look at the "To:" field.

> I made several of them, with temporary debug in the kernel that did
> not show the issue.
> 
> 
> I am wondering if this could hide an issue in MPTCP ?
Indeed, I was wondering the same thing. I didn't see anything obvious
when looking at this issue. The behaviours around the window clamping,
with MPTCP single flow, and "plain" TCP were quite similar I think.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


