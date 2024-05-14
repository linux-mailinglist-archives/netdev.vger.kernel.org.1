Return-Path: <netdev+bounces-96293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CADB88C4D75
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 10:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE6111C20FC0
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 08:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E30D179B7;
	Tue, 14 May 2024 08:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qFC9MbDA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FD5125A9;
	Tue, 14 May 2024 08:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715674001; cv=none; b=J9JTwKBgAxdwcf93uOPtLM/afsC2Gq69IHuF+CCHa0t3b2CJIOooEp/4NLwCf9m5v10BQ5Ops7GrQFN7hfoFkVHE9lwWuEA/VwRvROk1RcFfv1plOqkesQdbQg+iLRiFbclXpKSncYORq3ZOQuaVyM1fJc+owW8mBq3TkaMLAwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715674001; c=relaxed/simple;
	bh=N34ThgQd0DAt0wVs05B2Jna+Ohlf1SF698RKdtXprvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bYHaUgGnej1xyz/2AUJbG0K9wW6OQM8koKGN6FLbNwdjeJ+Tz2NbnS4HdudEyl7441aGfVzucoZzyX7VLzJCi3+QeJHQos7oXA9IPAKW7Kla5Cc75sELrd/Q8qWy9AoPaAKFLf3WcaQxPgry+g5zn4Lxn6SaW9NQZQEGcwxWKBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qFC9MbDA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71464C2BD10;
	Tue, 14 May 2024 08:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715674001;
	bh=N34ThgQd0DAt0wVs05B2Jna+Ohlf1SF698RKdtXprvQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qFC9MbDAqXMBEKQOAZcQKthbdtSWGuG13AGjjl4wN61HX2uQa0flzwQRhjMHucY6p
	 OG9WbbNBKmaDuCqHtk19AyD7FjuXklOhhWbvEw1SMKDfYJKmtZ/pzxVcC8/ifCcC6K
	 QBCR6+J3Z42dd1Vkv3dxYNivkKiG1Ao8lPuqGlgYFz5P3HiFoI6ayzuo2HBXzNfPO/
	 bnJepdgfUyYKZadHNHBBsu4uINkXW2cRfcLeo6ERT6kRrMWfwMT0Mq+KeV8I5rFEJq
	 tWrmBOIsUDIb2rAtSXeQc2HIzJ42Rw8FiW8jf4H2jKUSLOX6scIFbIX440XbW4jrTb
	 EKHkmdlykHO5Q==
Message-ID: <76755d03-04a7-4489-a155-355026ad998f@kernel.org>
Date: Tue, 14 May 2024 10:06:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next 0/8] mptcp: small improvements, fix and clean-ups
Content-Language: en-GB
To: Mat Martineau <martineau@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: mptcp@lists.linux.dev, Geliang Tang <geliang@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Florian Westphal <fw@strlen.de>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gregory Detal <gregory.detal@gmail.com>
References: <20240510-upstream-net-next-20240509-misc-improvements-v1-0-4f25579e62ba@kernel.org>
 <20240513160630.545c3024@kernel.org>
 <f60cac35-5a2b-16cf-4706-b2e41acfacae@kernel.org>
 <20240513172941.290cc5cd@kernel.org>
 <8829dfe5-d05a-4103-34af-90f0434ef390@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <8829dfe5-d05a-4103-34af-90f0434ef390@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mat, Jakub,

On 14/05/2024 02:33, Mat Martineau wrote:
> On Mon, 13 May 2024, Jakub Kicinski wrote:
> 
>> On Mon, 13 May 2024 17:24:08 -0700 (PDT) Mat Martineau wrote:
>>> The conflict here is purely in the diff context, patch 2 of this series
>>> and "tcp: socket option to check for MPTCP fallback to TCP" add cases to
>>> the same switch statement and have a couple of unmodified lines between
>>> their additions.
>>>
>>> "git am -3" handles it cleanly in this case, if you have time and
>>> inclination for a second attempt. But I realize you're working through a
>>> backlog and net-next is now closed, so that time might not be available.
>>> We'll try again when net-next reopens if needed.
>>
>> Your -3 must be more powerful somehow, or my scripts are broken because
>> it isn't enough on my end.
>>
>> If you can do a quick resend there's still a chance. The patches look
>> quite simple.
> 
> 
> Thanks Jakub! Spinning a quick v2 right now.

Thank you for having sent a v2, and for having applied them!

I'm sorry about the conflicts: I moved the code around on purpose to
avoid them, but it looks like it was not enough. Like Mat, I didn't have
these conflicts locally when I tested before sending the patches. I will
check if there is something I can do to have the same error as the one
you had, to prevent such issues next time.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


