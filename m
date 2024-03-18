Return-Path: <netdev+bounces-80385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA4687E92A
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 13:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10D7CB21443
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 12:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53D737714;
	Mon, 18 Mar 2024 12:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omFYthG0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1E738382;
	Mon, 18 Mar 2024 12:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710763978; cv=none; b=JrgFyI9nSkWVTf7qdtGulohwnx0FBG65x0b4fD6+2RqgGDzCOeQmVpsO9+N7cQTODB78xkJAIIW3VfHxErcK39mLhn91Y2/qVKUdwv86D85oWXThEYjpvZtpS5Aj2A/bUeNYgRIwQ/OQMfkXMXP3hoW0cugmuR7J4Al7JFQA/yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710763978; c=relaxed/simple;
	bh=HLuck12upJDUcz1Z3oOsil9KA5H2QT2T3rExgKJluOU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IPJEbsQdv61YfavkuVuRqtXJg7fOgHiOOKMoyEhtCeU6Fl9+dApjZDYNEGLNZC8D0j31CloPhv1iZsXrJcH3npzej9dd8Ik+Oam7363+VdetheK8KMZR2t8EYUvIMscl+XlXG+OlUbTt+WIevVO/UIid/ha0lPEZ7JRVpU3IW8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omFYthG0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C97F9C433F1;
	Mon, 18 Mar 2024 12:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710763978;
	bh=HLuck12upJDUcz1Z3oOsil9KA5H2QT2T3rExgKJluOU=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=omFYthG0kHVa39d/Ee5/nLEfNOYh2nN3O+5zT/flV4LFoqCIZ96TG7rLZ/dH2U7O9
	 DuRgTdVu/38c0vgMHvX4Ak0hU7WOwF0OmEReUnHrjbXPOEJn5tUUrfJdI4lp/lCM12
	 KHO88QV4UqM5Cs3mwbKXmLwCh+Tsuq2R946r3ZD6Zn+dq45gGwd0oD1FCGizdKLnrk
	 CYeG+pf7sNEYfr6oURdU5v3loaMKErxXYoj+EPmnWVJ4rIFZV4H43N7eWN4RgI+KHX
	 4cel6OknNSwONw2iZHKCIEq94HGZGlnu9xeMDEH34eBj8wE9Fv78vJQeZbKwlgYZE8
	 We3sPRcfYNb7A==
Message-ID: <447caa0d-10d6-42f9-958b-5d6d7c472792@kernel.org>
Date: Mon, 18 Mar 2024 13:12:55 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpf/lpm_trie: inline longest_prefix_match for
 fastpath
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <borkmann@iogearbox.net>, martin.lau@kernel.org,
 netdev@vger.kernel.org, kernel-team@cloudflare.com
References: <171025648415.2098287.4441181253947701605.stgit@firesoul>
 <2c2d1b85-9c4a-5122-c471-e4a729b4df03@iogearbox.net>
 <860f02ae-a8a8-4bcd-86d8-7a6da3f2056d@kernel.org>
In-Reply-To: <860f02ae-a8a8-4bcd-86d8-7a6da3f2056d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 15/03/2024 18.08, Jesper Dangaard Brouer wrote:
> 
> 
> On 15/03/2024 16.03, Daniel Borkmann wrote:
>> On 3/12/24 4:17 PM, Jesper Dangaard Brouer wrote:
>>> The BPF map type LPM (Longest Prefix Match) is used heavily
>>> in production by multiple products that have BPF components.
>>> Perf data shows trie_lookup_elem() and longest_prefix_match()
>>> being part of kernels perf top.
>>
>> You mention these are heavy hitters in prod ...
>>
>>> For every level in the LPM tree trie_lookup_elem() calls out
>>> to longest_prefix_match().  The compiler is free to inline this
>>> call, but chooses not to inline, because other slowpath callers
>>> (that can be invoked via syscall) exists like trie_update_elem(),
>>> trie_delete_elem() or trie_get_next_key().
>>>
>>>   bcc/tools/funccount -Ti 1 
>>> 'trie_lookup_elem|longest_prefix_match.isra.0'
>>>   FUNC                                    COUNT
>>>   trie_lookup_elem                       664945
>>>   longest_prefix_match.isra.0           8101507
>>>
>>> Observation on a single random metal shows a factor 12 between
>>> the two functions. Given an average of 12 levels in the trie being
>>> searched.
>>>
>>> This patch force inlining longest_prefix_match(), but only for
>>> the lookup fastpath to balance object instruction size.
>>>
>>>   $ bloat-o-meter kernel/bpf/lpm_trie.o.orig-noinline 
>>> kernel/bpf/lpm_trie.o
>>>   add/remove: 1/1 grow/shrink: 1/0 up/down: 335/-4 (331)
>>>   Function                                     old     new   delta
>>>   trie_lookup_elem                             179     510    +331
>>>   __BTF_ID__struct__lpm_trie__706741             -       4      +4
>>>   __BTF_ID__struct__lpm_trie__706733             4       -      -4
>>>   Total: Before=3056, After=3387, chg +10.83%
>>
>> ... and here you quote bloat-o-meter instead. But do you also see an
>> observable perf gain in prod after this change? (No objection from my
>> side but might be good to mention here.. given if not then why do the
>> change?)
>>
> 
> I'm still waiting for more production servers to reboot into patched
> kernels.  I do have some "low-level" numbers from previous generation
> AMD servers, running kernel 6.1, which should be less affected by the
> SRSO (than our 6.6 kernels). Waiting for newer generation to get kernel
> updates, and especially 6.6 will be interesting.

There were no larger performance benefit on 6.6 it is basically the same.

Newer generation (11G) hardware latency overhead of trie_lookup_elem
  - avg 1181 nsecs for patched kernel
  - avg 1269 nsecs for non patched kernel
  - around 7% improvement or 88 ns

> 
>  From production measurements the latency overhead of trie_lookup_elem:
>   - avg 1220 nsecs for patched kernel
>   - avg 1329 nsecs for non patched kernel
>   - around 8% improvement or 109 nanosec
>   - given approx 12 calls "saved" this is 9 ns per function call
>   - for reference on Intel I measured func call to cost 1.3ns
>   - this extra overhead is caused by __x86_return_thunk().
> 

> I also see slight improvement in the graphs, but given how much
> production varies I don't want to draw conclusions yet.
> 

Still inconclusive due to variations in traffic distribution due to
load-balancing isn't perfect.

> 
>>> Details: Due to AMD mitigation for SRSO (Speculative Return Stack Overflow)
>>> these function calls have additional overhead. On newer kernels this shows
>>> up under srso_safe_ret() + srso_return_thunk(), and on older kernels (6.1)
>>> under __x86_return_thunk(). Thus, for production workloads the biggest gain
>>> comes from avoiding this mitigation overhead.
>>>
>>> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>

I'm going to send a V2, because kernel doc processing found an issue:
  - https://netdev.bots.linux.dev/static/nipa/834681/13590144/kdoc/stderr

I'll try to incorporate the production improvements we are seeing, but
it feels wrong to write about kernel 6.1 and 6.6 improvements, but I
(currently) cannot deploy a bpf-next kernel in production (but I do test
latest kernels in my local testlab).

--Jesper

