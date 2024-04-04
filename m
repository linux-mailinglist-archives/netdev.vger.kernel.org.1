Return-Path: <netdev+bounces-84804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE0F8985FF
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 13:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29A5A1C2456E
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 11:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EF082871;
	Thu,  4 Apr 2024 11:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGh4W6k2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D840757F8;
	Thu,  4 Apr 2024 11:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712229838; cv=none; b=l17lVEi52r9x9rGNviRMBJDGHqDcUyco5vmw2lzG6Lr8eotSv7zaYLQMfNkuqvm6+8YVsKIXZ/gZtWO0ddQpDcLJb+S8xe7aIrvFpI523TtSOCH4Q1is6pTEFrUs7cUi2NOuuokRiFVE/ew6SqGk7CvrJFzd1Fd32zySw9kJTBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712229838; c=relaxed/simple;
	bh=Y+5uB6ya45iH0N47tEEHl6dTEm9h/ITDLtDCoUztF34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QujO6Tr2Ynau5C6P5kC+7rDGTcF/PbxqTKhL4abO86qVLiHKz9ifoHDHgoQCTEfnZ1JfFvW9C+MTkHzYOWjKrDb2smuWbVhhfG39kyfOC40/n0CBwBw8+Vn226ZQlrueg7KGvw36Tj8OyF9euBIvvb4/WJJbidB11IXVMYqlGb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGh4W6k2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7281AC433F1;
	Thu,  4 Apr 2024 11:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712229838;
	bh=Y+5uB6ya45iH0N47tEEHl6dTEm9h/ITDLtDCoUztF34=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EGh4W6k2KNsABUiQ4uNVSsXhb2UJ5hnxsXxsacdF7yic71/h6oFHDQdD1UOtm0WdC
	 b0JtokyP38X9BTaHFel2bAiuk3pBMKg2Ifxe3FWs+F23KibGsS0KXYnKwsielqtn3Y
	 zoXg5Mxnm5l9Oz+4lo7rIjpOq18vXcxBBR0jaL53fLoVB3CLB2hfUoSPO2hLc1JlT6
	 z5IVk5f+zfpVEdSxm8zXKqjCgSkb1awo55gtVz3Pv9uP3auXB6ApPgoMomC0F+nXJi
	 mkaY1qEy17PFj4jJPeJezgkKC4dH5dWl4wGc7FIUOSGeNoVx5uJ+oRzw0Zmm9zrMiF
	 XEz06ILZhw2zg==
Message-ID: <5a0db8a6-6d73-48a6-8824-3191657ff11a@kernel.org>
Date: Thu, 4 Apr 2024 13:23:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/4] bpf: test_run: Use system page pool for
 XDP live frame mode
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20240220210342.40267-1-toke@redhat.com>
 <20240220210342.40267-3-toke@redhat.com> <87sf1lzxdb.fsf@toke.dk>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <87sf1lzxdb.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 21/02/2024 15.48, Toke Høiland-Jørgensen wrote:
> Toke Høiland-Jørgensen <toke@redhat.com> writes:
> 
>> The cookie is a random 128-bit value, which means the probability that
>> we will get accidental collisions (which would lead to recycling the
>> wrong page values and reading garbage) is on the order of 2^-128. This
>> is in the "won't happen before the heat death of the universe" range, so
>> this marking is safe for the intended usage.
> 
> Alright, got a second opinion on this from someone better at security
> than me; I'll go try out some different ideas :)

It is a general security concern for me that BPF test_run gets access to
memory used by 'system page pool', with the concern of leaking data
(from real traffic) to an attacker than can inject a BPF test_run
program via e.g. a CI pipeline.

I'm not saying we leaking data today in BPF/XDP progs, but there is a
potential, because to gain performance in XDP and page_pool we don't
clear memory to avoid cache line performance issues.
I guess today, I could BPF tail extend and read packet data from older
frames, in this way, if I get access to 'system page pool'.

--Jesper

