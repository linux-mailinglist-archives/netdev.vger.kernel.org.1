Return-Path: <netdev+bounces-172427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D77BFA54922
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 12:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D550188DB5A
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 11:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C3C20A5DC;
	Thu,  6 Mar 2025 11:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCU8KJ+6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58162208989;
	Thu,  6 Mar 2025 11:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741260035; cv=none; b=ClHb5QH3GTVJ8OyWeSXnPWRrm8v9YWlRiHbGemu+d7Yso7la8fk0NOIi6x/5aSjaOHbWYVRhs3XMrF6nqV0crnMZa6F6vNE0iuwkiph2TxT3USKRhtnQZMSwLHnXIbd0/7NOizVIoYAbX3O8zsbMKMiCMLB+PXvDeysQV8TGPmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741260035; c=relaxed/simple;
	bh=/4FnzVillueFxVw5MMdU7a9zHKH1+gMQRj5ALkK7Iwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tcf4c7CsGGEkenJ7ALk5ZjJNNUqx7p6vShIyGq/+A/gUG2oGGJrp/T3UiRLAx8w7onhmoHTfn9AbWfWWLJSsF7WRdWNn4PX8XszwPOWp4SL8wOvxWy4V3tYvIkbbqZWHXI9jJ+LsosWh49/v66GzhIz+Y9NMAivKkC4jHK1+cA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCU8KJ+6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3991C4CEE0;
	Thu,  6 Mar 2025 11:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741260035;
	bh=/4FnzVillueFxVw5MMdU7a9zHKH1+gMQRj5ALkK7Iwg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kCU8KJ+6yCdt4JOVkkhZ2+UeO51IUo+aKDJzC6/AQ11AA720ifuT4KcTwWLGNPYMf
	 mSVQIVk1A10xf7P4RZdJlWD0w17ZjOIeaenPfb96vAnmUrCT4mA1rIT8Hx0uPkw8Jh
	 dnugb5bmRiy/roejzzvN7QFqolmWZpK7JzGkbaboJQ1x+abiYtr1mzs21ywUFs5YaZ
	 j+CKJ8S4IC7nFNjZLUnFhW+8d5pSyKFm4RRY7Eak760g/GomurjuS306/urh0QaB4E
	 TItcnLvsSGEnCikf983XdWkOHI+3sB8R9721nw9Vs7yaLWjPV7v6fzUQDNtLZpBufF
	 ZqpcDJGxxpLHg==
Message-ID: <58d604b3-760f-449d-95b4-c56d8b9da400@kernel.org>
Date: Thu, 6 Mar 2025 12:20:29 +0100
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
 <a3266974-d561-4e8f-a23a-9c0774ee2bbe@kernel.org>
 <CANn89iJ4DyC8OSEA2Qn3WhWHAUr9Bpo_ZmJdcx3ofM-qKvEU=g@mail.gmail.com>
 <CANn89iJ2S+mCs8PxZ-EBAfH--j6v9cUazCc8O4FWvMat=_yURQ@mail.gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <CANn89iJ2S+mCs8PxZ-EBAfH--j6v9cUazCc8O4FWvMat=_yURQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Eric,

On 06/03/2025 12:08, Eric Dumazet wrote:
> On Thu, Mar 6, 2025 at 11:16 AM Eric Dumazet <edumazet@google.com> wrote:
>> On Thu, Mar 6, 2025 at 11:12 AM Matthieu Baerts <matttbe@kernel.org> wrote:
>>> On 06/03/2025 11:02, Eric Dumazet wrote:

(...)

>>>> I am wondering if this could hide an issue in MPTCP ?
>>> Indeed, I was wondering the same thing. I didn't see anything obvious
>>> when looking at this issue. The behaviours around the window clamping,
>>> with MPTCP single flow, and "plain" TCP were quite similar I think.
>>
>> OK, let me run mptcp tests just in case I see something dubious.
> 
> I have no idea why only MPTCP flows can trigger the condition, I do
> not think it matters anyway.

Thank you for having looked! Did you manage to trigger this condition
with "plain" TCP (without MPTCP) when using "./mptcp_connect.sh -tt"?

The TCP only connections will be printed like this:

  nsX TCP   -> nsY (<IP>:<port>) TCP

But yes, it probably doesn't matter.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


