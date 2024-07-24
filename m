Return-Path: <netdev+bounces-112729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F61293ADD9
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 10:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 234FB1F21AED
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 08:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67ABD14B968;
	Wed, 24 Jul 2024 08:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpoyGaeM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8E314B960;
	Wed, 24 Jul 2024 08:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721808961; cv=none; b=VWi608EtyJwf0gWNq/8S+L4vV0mxWQjm3KiBtrWO7EwPJSuZOg7dcHQ44Vf4wIdznpWC6FE1m/PzssE/nzbVeHRuBSnOIneQJUHNZWsIU1CBuv8oUqo8SFnuhCxrL0R2xkv49Y2ggVIfH8QbYpedNY1CmavLW5ym4XlKrmjcj94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721808961; c=relaxed/simple;
	bh=/mIEHHXkDVq16jXgWsjxyuQ8xG0Avx6YZlNQpXLG+5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pghAoT1avrZIueycTkZZk7gE/BPXI3KCWLkHq/ILNnvOmZd6E9RWwlUrRcX52ldZWST9gxMMT5onhGh//0Y9hsIC+K1mWyGmahTtbgQtjKsd6pyA4kwz9KBc3tnmX8Jda59oN4SiX2nCDzR7CjjH6BwyFUx1MUx6uyQsr61alYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BpoyGaeM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F2C1C4AF0B;
	Wed, 24 Jul 2024 08:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721808960;
	bh=/mIEHHXkDVq16jXgWsjxyuQ8xG0Avx6YZlNQpXLG+5g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BpoyGaeMppx7PiTxCI3JUwEm/ucho4ymnpXiklBDXAWWhJ9G05hdRWyZI5qxuiF2M
	 t03P1NxauOLqJkHCMZ+hJzsVN5xKomlDgmJnW4PVVtyUDw1j15ShQ/a0xRq4c01iKt
	 3VainrhzQvpvVIbEG//NvepFaoma4pf7dogfYHd8InGVnEb0JE5XOqcqq8D9eWihVK
	 k4X78GBh7Y6Mp7B41NMwaFDbAW5dQ49q5ABpC6fK9yBH8QOFse5tfaEaRybB24g/mk
	 K/DvPpTxcsGDFcr+ORI2JG1yuupdJWfpj7V9X9oyFwSxHQ2jTBPPUoKfQMGOwl3k37
	 oEsdxsNDSkYaQ==
Message-ID: <7c992504-51ad-4104-a039-382fe69ff1c8@kernel.org>
Date: Wed, 24 Jul 2024 10:15:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net v2 1/2] tcp: process the 3rd ACK with sk_socket for
 TFO/MPTCP
Content-Language: en-GB
To: Neal Cardwell <ncardwell@google.com>
Cc: Eric Dumazet <edumazet@google.com>, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240718-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v2-0-d653f85639f6@kernel.org>
 <20240718-upstream-net-next-20240716-tcp-3rd-ack-consume-sk_socket-v2-1-d653f85639f6@kernel.org>
 <CANn89iJNa+UqZrONT0tTgN+MjnFZJQQ8zuH=nG+3XRRMjK9TfA@mail.gmail.com>
 <2583642a-cc5f-4765-856d-4340adcecf33@kernel.org>
 <CANn89iKP4y7iMHxsy67o13Eair+tDquGPBr=kS41zPbKz+_0iQ@mail.gmail.com>
 <4558399b-002b-40ff-8d9b-ac7bf13b3d2e@kernel.org>
 <CANn89iLozLAj67ipRMAmepYG0eq82e+FcriPjXyzXn_np9xX2w@mail.gmail.com>
 <9c0b40e5-2137-423f-85c3-385408ea861e@kernel.org>
 <CADVnQy=Aky08HJGnozv-Nd97kRHBnxhw+caks+42FUyn+9GbPQ@mail.gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <CADVnQy=Aky08HJGnozv-Nd97kRHBnxhw+caks+42FUyn+9GbPQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Neal,

On 24/07/2024 00:01, Neal Cardwell wrote:
> On Tue, Jul 23, 2024 at 3:09 PM Matthieu Baerts <matttbe@kernel.org> wrote:
>>
>> Hi Eric,
>>
>> On 23/07/2024 18:42, Eric Dumazet wrote:
>>> On Tue, Jul 23, 2024 at 6:08 PM Matthieu Baerts <matttbe@kernel.org> wrote:
>>>>
>>>> Hi Eric,
>>>>
>>>> On 23/07/2024 17:38, Eric Dumazet wrote:
>>>>> On Tue, Jul 23, 2024 at 4:58 PM Matthieu Baerts <matttbe@kernel.org> wrote:
>>>>>>
>>>>>> Hi Eric,
>>>>>>
>>>>>> +cc Neal
>>>>>> -cc Jerry (NoSuchUser)
>>>>>>
>>>>>> On 23/07/2024 16:37, Eric Dumazet wrote:
>>>>>>> On Thu, Jul 18, 2024 at 12:34 PM Matthieu Baerts (NGI0)
>>>>>>> <matttbe@kernel.org> wrote:
>>>>>>>>
> ...
>>>>> +.045 < S. 1234:1234(0) ack 1001 win 14600 <mss
>>>>> 940,nop,nop,sackOK,nop,wscale 6,FO 12345678,nop,nop>
>>>>>    +0 > . 1001:1001(0) ack 1 <nop,nop,sack 0:1>  // See here
>>>>
>>>> I'm sorry, but is it normal to have 'ack 1' with 'sack 0:1' here?
>>>
>>> It is normal, because the SYN was already received/processed.
>>>
>>> sack 0:1 represents this SYN sequence.
>>
>> Thank you for your reply!
>>
>> Maybe it is just me, but does it not look strange to have the SACK
>> covering a segment (0:1) that is before the ACK (1)?
>>
>> 'ack 1' and 'sack 0:1' seem to cover the same block, no?
>> Before Kuniyuki's patch, this 'sack 0:1' was not present.
> 
> A SACK that covers a sequence range that was already cumulatively or
> selectively acknowledged is legal and useful, and is called a
> Duplicate Selective Acknowledgement (DSACK or D-SACK).
> 
> A DSACK indicates that a receiver received duplicate data. That can be
> very useful in allowing a data sender to determine that a
> retransmission was not needed (spurious). If a data sender receives
> DSACKs for all retransmitted data in a loss detection episode then it
> knows all retransmissions were spurious, and thus it can "undo" its
> congestion control reaction to that estimated loss, since the
> congestion control algorithm was responding to an incorrect loss
> signal. This can be very helpful for performance in the presence of
> varying delays or reordering, which can cause spurious loss detection
> episodes..
> 
> See:
> 
> https://datatracker.ietf.org/doc/html/rfc2883
> An Extension to the Selective Acknowledgement (SACK) Option for TCP
> 
> https://www.rfc-editor.org/rfc/rfc3708.html
> "Using TCP Duplicate Selective Acknowledgement (DSACKs) and Stream
> Control Transmission Protocol (SCTP) Duplicate  Transmission Sequence
> Numbers (TSNs) to Detect Spurious Retransmissions"

Thank you for the great explanations!

I was not expecting this in a 3rd ACK :)
I don't know if it will help the congestion control algorithm in this
case, but I guess we don't need to worry about this marginal case.

I will then send the v3, and the Packetdrill modification.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


