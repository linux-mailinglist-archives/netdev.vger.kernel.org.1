Return-Path: <netdev+bounces-80143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E6F87D275
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 18:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A22171C2230B
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 17:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2FF45C08;
	Fri, 15 Mar 2024 17:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o92RSMkm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360C239AF0;
	Fri, 15 Mar 2024 17:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710522532; cv=none; b=A2hFwazgd7sRVVtB/Ozvn/veKQ+b9gNlbF9linzvq69J7Fd5tfeBohhYF4zoiGBTWZyWiWiDpD53wTQV1914H1gMj3vso1oU5KyiIr5ik1DZfOIhWQ+ABIfnJQDaRCLigHCeU2ACCzEIUcR1Uv9pF5XpksOHoTRUc9D2Fft3hz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710522532; c=relaxed/simple;
	bh=LAiO+oLFXMWQ/BVhBgoJWAKn509c7RuQ4nIeC9QIXKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GSK64Ue1GIcDCVXM9AgxNGXHNzWlSlJOVIC4VNtCIxZ5S0UzyY+ini/E8IMe9eJt1/9ZGtNpU1VH8hS77VM+rvDcOv6DbxxRvDFXI4RwtaltGzP7JNJO26q3uFCrGwRyJnQk0YBtTsXWyg4NQgeRna32IiZH0zQ+KYWAUUCQtF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o92RSMkm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CBDCC433C7;
	Fri, 15 Mar 2024 17:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710522531;
	bh=LAiO+oLFXMWQ/BVhBgoJWAKn509c7RuQ4nIeC9QIXKE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=o92RSMkmambBzKExnTwpLGkzs0dwG0Q0KQPmrkctZSAR2822/m4Q+W3gxMCExw20G
	 oFUGtKu3xl7asHmJmgejxx4W+HXQNb3pN9vKDHA5HTNOqUZH32kajipQmtZz/QmOn2
	 O0Db4LsNCVmlx+mRRAsnk/cSGA18spJM0DsWKm75WqBFrqSBS+5Gnrsc2b2qqFaZiW
	 gXZ+su6hqJe5JpM6vZfzFvrsl6t9azKyF12H0dcZBXe7lVCFQ/bb5WB9XNeu6Tgta+
	 fP+FJaI4mb07U7E3pf2IkXdz5/yN2mMRp5ISjjimOyR61uweIJl9bi1Xc64rqPm//n
	 o2m0yZktJqh6Q==
Message-ID: <860f02ae-a8a8-4bcd-86d8-7a6da3f2056d@kernel.org>
Date: Fri, 15 Mar 2024 18:08:48 +0100
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
To: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <borkmann@iogearbox.net>, martin.lau@kernel.org,
 netdev@vger.kernel.org, kernel-team@cloudflare.com
References: <171025648415.2098287.4441181253947701605.stgit@firesoul>
 <2c2d1b85-9c4a-5122-c471-e4a729b4df03@iogearbox.net>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <2c2d1b85-9c4a-5122-c471-e4a729b4df03@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 15/03/2024 16.03, Daniel Borkmann wrote:
> On 3/12/24 4:17 PM, Jesper Dangaard Brouer wrote:
>> The BPF map type LPM (Longest Prefix Match) is used heavily
>> in production by multiple products that have BPF components.
>> Perf data shows trie_lookup_elem() and longest_prefix_match()
>> being part of kernels perf top.
> 
> You mention these are heavy hitters in prod ...
> 
>> For every level in the LPM tree trie_lookup_elem() calls out
>> to longest_prefix_match().  The compiler is free to inline this
>> call, but chooses not to inline, because other slowpath callers
>> (that can be invoked via syscall) exists like trie_update_elem(),
>> trie_delete_elem() or trie_get_next_key().
>>
>>   bcc/tools/funccount -Ti 1 
>> 'trie_lookup_elem|longest_prefix_match.isra.0'
>>   FUNC                                    COUNT
>>   trie_lookup_elem                       664945
>>   longest_prefix_match.isra.0           8101507
>>
>> Observation on a single random metal shows a factor 12 between
>> the two functions. Given an average of 12 levels in the trie being
>> searched.
>>
>> This patch force inlining longest_prefix_match(), but only for
>> the lookup fastpath to balance object instruction size.
>>
>>   $ bloat-o-meter kernel/bpf/lpm_trie.o.orig-noinline 
>> kernel/bpf/lpm_trie.o
>>   add/remove: 1/1 grow/shrink: 1/0 up/down: 335/-4 (331)
>>   Function                                     old     new   delta
>>   trie_lookup_elem                             179     510    +331
>>   __BTF_ID__struct__lpm_trie__706741             -       4      +4
>>   __BTF_ID__struct__lpm_trie__706733             4       -      -4
>>   Total: Before=3056, After=3387, chg +10.83%
> 
> ... and here you quote bloat-o-meter instead. But do you also see an
> observable perf gain in prod after this change? (No objection from my
> side but might be good to mention here.. given if not then why do the
> change?)
> 

I'm still waiting for more production servers to reboot into patched
kernels.  I do have some "low-level" numbers from previous generation
AMD servers, running kernel 6.1, which should be less affected by the
SRSO (than our 6.6 kernels). Waiting for newer generation to get kernel
updates, and especially 6.6 will be interesting.

 From production measurements the latency overhead of trie_lookup_elem:
  - avg 1220 nsecs for patched kernel
  - avg 1329 nsecs for non patched kernel
  - around 8% improvement or 109 nanosec
  - given approx 12 calls "saved" this is 9 ns per function call
  - for reference on Intel I measured func call to cost 1.3ns
  - this extra overhead is caused by __x86_return_thunk().

I also see slight improvement in the graphs, but given how much
production varies I don't want to draw conclusions yet.


>> Details: Due to AMD mitigation for SRSO (Speculative Return Stack 
>> Overflow)
>> these function calls have additional overhead. On newer kernels this 
>> shows
>> up under srso_safe_ret() + srso_return_thunk(), and on older kernels 
>> (6.1)
>> under __x86_return_thunk(). Thus, for production workloads the biggest 
>> gain
>> comes from avoiding this mitigation overhead.
>>
>> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>

