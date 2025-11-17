Return-Path: <netdev+bounces-239087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 719B9C639AF
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 11:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ADE204E1892
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 10:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8189C2FF664;
	Mon, 17 Nov 2025 10:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9Fs0Vr0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59146242D79;
	Mon, 17 Nov 2025 10:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763376157; cv=none; b=MbRbUcdl1GF0GygWZiapo//2FPcWBfvtkuP/GwOs1UfPb/TsUzMT4HEoFj99NeNdzn0psIIX9JcWIdEC4AV7ydLTgFekbVWONyqlk6B3fKVtWBuxDo9Z5nRHk7phRisg+JoY6E1M2uSoYXRazpcl7e2ZK3mlcABRMtLY0DOG4gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763376157; c=relaxed/simple;
	bh=h4naylcnZ42ygadbcjyMy/mQYI5dhbIUSRYT93UZJSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lPm++EHQB3gQl8LFtWrNPl1OA1W/UtT5aJeYrjXa75meyjoTnwaO6K62KG4wF+QYLWu6Cxf6Z/WpguVhncMcYn2MfXjFTegB5GtXFkL77UmSZuAGZn7cInT872rYDcPnyqfODDENSV/CBtXjVOBtcFr0KWnwfsuOPpIrNr+djTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9Fs0Vr0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 790F7C116B1;
	Mon, 17 Nov 2025 10:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763376156;
	bh=h4naylcnZ42ygadbcjyMy/mQYI5dhbIUSRYT93UZJSQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=f9Fs0Vr0csPEvrpD9S43ms3eZKlpnL46BEa1SuW/dFVovda15xZVVFC6JC44ByEdT
	 8494DP4aPmT7reXAS8r0QEojLSWDUZT6hNeOagxsHuakgc+UddP7NvPaMLAcLCCJf5
	 VKPxidMQWzwg7vKxGbkFpa7ODvuuedr/hWTX87XTBn2eHpFXY5x/oIS1m2JUbffxQ4
	 ixyZUo2v49UbyLO0jBAu/9TYn+1cZJeTjHZ8XEVVhX3lHZKC9f/tCjZ+xHMmein+zV
	 y05wI8MGQQQOYeGzIEnzKF5Dmhtmi6lrOGHs7tlPDyOHmtqYuZD9S1jMP78GT8ItPg
	 /RUwpQsOuwwtg==
Message-ID: <a155bf8b-08cd-4cd9-91d9-f49180f19f6c@kernel.org>
Date: Mon, 17 Nov 2025 11:42:31 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] mptcp: fix a race in mptcp_pm_del_add_timer()
Content-Language: en-GB, fr-BE
To: Eric Dumazet <edumazet@google.com>
Cc: Mat Martineau <martineau@kernel.org>,
 Geliang Tang <geliang.tang@linux.dev>, Florian Westphal <fw@strlen.de>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+2a6fbf0f0530375968df@syzkaller.appspotmail.com,
 Geliang Tang <geliang@kernel.org>, MPTCP Linux <mptcp@lists.linux.dev>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
References: <20251117100745.1913963-1-edumazet@google.com>
 <c378da30-4916-4fd6-8981-4ab2ffa17482@kernel.org>
 <CANn89iLxt+F+SrpgXGvYh9CZ8GNmbbowv5Ce80P1gsWjaXf+CA@mail.gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <CANn89iLxt+F+SrpgXGvYh9CZ8GNmbbowv5Ce80P1gsWjaXf+CA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 17/11/2025 11:21, Eric Dumazet wrote:
> On Mon, Nov 17, 2025 at 2:15 AM Matthieu Baerts <matttbe@kernel.org> wrote:
>>
>> Hi Eric,
>>
>> (+cc MPTCP ML)
>>
>> On 17/11/2025 11:07, Eric Dumazet wrote:
>>> mptcp_pm_del_add_timer() can call sk_stop_timer_sync(sk, &entry->add_timer)
>>> while another might have free entry already, as reported by syzbot.
>>>
>>> Add RCU protection to fix this issue.
>>
>> Thank you for the report and even more for the fix!
>>
>>> Also change confusing add_timer variable with stop_timer boolean.
>>
>> Indeed, this name was confusing: 'add_timer' is in fact a (too) short
>> version of "additional address signalling retransmission timer". This
>> new 'stop_timer' boolean makes sense!
>>
>>> syzbot report:
>>
>> (...)
>>
>>> Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
>>> Reported-by: syzbot+2a6fbf0f0530375968df@syzkaller.appspotmail.com
>>> Closes: https://lore.kernel.org/netdev/691ad3c3.a70a0220.f6df1.0004.GAE@google.com/
>>> Signed-off-by: Eric Dumazet <edumazet@google.com>
>>> Cc: Geliang Tang <geliang@kernel.org>
>>
>> The modification looks good to me:
>>
>> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>>
>> While at it, just to help me to manage the backports:
>>
>> Cc: stable@vger.kernel.org
>>
>>> v2: Updated/Added Reported-by:/Closes: tags now syzbot report finally reached netdev@ mailing list.
>>
>> Out of curiosity, is it not OK to reply to the patch with the new
>> Reported-by & Closes tags to have them automatically added when applying
>> the patch? (I was going to do that on the v1, then I saw the v2 just
>> when I was going to press 'Send' :) )
> 
> I am not sure patchwork has been finally changed to understand these two tags.

Ah yes, thank you! If there is a dependence on Patchwork, I think
indeed, it doesn't recognise the 'Closes' tag (but I think 'Reported-by'
is OK).

While at it, I forgot to add: this patch can be applied in net directly.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


