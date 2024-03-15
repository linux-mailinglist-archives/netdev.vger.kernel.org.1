Return-Path: <netdev+bounces-80094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC7C87CFB9
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 16:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53020B22D42
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 15:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA6D3D0BC;
	Fri, 15 Mar 2024 15:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="jb4P97x8"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703CB3B79E;
	Fri, 15 Mar 2024 15:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710515011; cv=none; b=jNeYbtalXNfR6Ul+FIfVCIRgYBJBp2cVNbqIbEL5ZHnnTK37esxYcSbsHU3qWWveZ0Zx+RV0f+wwYgmvLCiw62t5JqUPD2VieTxd7WUB8ZzFaX62D7bwNtn8gemwVxMpBlapyZyobJW2ckgyxf99IPZZSLA2UCaJdWRQcogyJno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710515011; c=relaxed/simple;
	bh=sEr/vaiHB5VhLhULj6YsYvAfbXtqg071A1ufYJkeEOk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=NWzTLSxBsohLFqOXORRJ15YtXJM5evYT+2SZRC0uBMc5Q6ZWL+dnbtxeBZ2a/d1p5mu5dwg400k/Q4rErQoCreeRM8Wk74PXaaltnwS6lGR0zhnSkWt85JpfofrfALeE7/ht8LoeuE+rFf3LHEeYSLH2e/6GM9ysbbCHhCh69FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=jb4P97x8; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=+ThZ0oxHlJAo2xyJ267h3CcALjVFa5k61H12id9wLzA=; b=jb4P97x8MgMDyQj2e1lBi1J6bd
	LCrTeBt0P9mYCrQaX9Wzv0mGqH3pjaHhmhHf56Mp/mBD72LAV3Ui02OndGbKfEOi0pUheyTUahvL4
	dizBPty0PJwJBuGQnNl+2rWhGZgGeXjlCQwRt4Tjxv49Ro+sgiqo0E7cT4Sng8l+n6Ma2YA+ly8EB
	3pVfpo6Q3Gs8w61Rq+MQ3tfMfcFN8dc6FX5K9UUlYemXQQpXLGOpJdf2yiU0vPV6RpWoI94ZqhaQE
	PABrWITsAqgrcc0DgNJZvHueF5Xjqj5O9AyTCr4hQIgHCKjm0GGk9GL1miqInz+fAB2GHnEnPTK1s
	FAAPMpNA==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rl95e-0006tz-Dd; Fri, 15 Mar 2024 16:03:22 +0100
Received: from [178.197.249.11] (helo=linux.home)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1rl95e-000NrA-00;
	Fri, 15 Mar 2024 16:03:22 +0100
Subject: Re: [PATCH bpf-next] bpf/lpm_trie: inline longest_prefix_match for
 fastpath
To: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <borkmann@iogearbox.net>, martin.lau@kernel.org,
 netdev@vger.kernel.org, kernel-team@cloudflare.com
References: <171025648415.2098287.4441181253947701605.stgit@firesoul>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <2c2d1b85-9c4a-5122-c471-e4a729b4df03@iogearbox.net>
Date: Fri, 15 Mar 2024 16:03:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <171025648415.2098287.4441181253947701605.stgit@firesoul>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27215/Fri Mar 15 09:31:18 2024)

On 3/12/24 4:17 PM, Jesper Dangaard Brouer wrote:
> The BPF map type LPM (Longest Prefix Match) is used heavily
> in production by multiple products that have BPF components.
> Perf data shows trie_lookup_elem() and longest_prefix_match()
> being part of kernels perf top.

You mention these are heavy hitters in prod ...

> For every level in the LPM tree trie_lookup_elem() calls out
> to longest_prefix_match().  The compiler is free to inline this
> call, but chooses not to inline, because other slowpath callers
> (that can be invoked via syscall) exists like trie_update_elem(),
> trie_delete_elem() or trie_get_next_key().
> 
>   bcc/tools/funccount -Ti 1 'trie_lookup_elem|longest_prefix_match.isra.0'
>   FUNC                                    COUNT
>   trie_lookup_elem                       664945
>   longest_prefix_match.isra.0           8101507
> 
> Observation on a single random metal shows a factor 12 between
> the two functions. Given an average of 12 levels in the trie being
> searched.
> 
> This patch force inlining longest_prefix_match(), but only for
> the lookup fastpath to balance object instruction size.
> 
>   $ bloat-o-meter kernel/bpf/lpm_trie.o.orig-noinline kernel/bpf/lpm_trie.o
>   add/remove: 1/1 grow/shrink: 1/0 up/down: 335/-4 (331)
>   Function                                     old     new   delta
>   trie_lookup_elem                             179     510    +331
>   __BTF_ID__struct__lpm_trie__706741             -       4      +4
>   __BTF_ID__struct__lpm_trie__706733             4       -      -4
>   Total: Before=3056, After=3387, chg +10.83%

... and here you quote bloat-o-meter instead. But do you also see an
observable perf gain in prod after this change? (No objection from my
side but might be good to mention here.. given if not then why do the
change?)

> Details: Due to AMD mitigation for SRSO (Speculative Return Stack Overflow)
> these function calls have additional overhead. On newer kernels this shows
> up under srso_safe_ret() + srso_return_thunk(), and on older kernels (6.1)
> under __x86_return_thunk(). Thus, for production workloads the biggest gain
> comes from avoiding this mitigation overhead.
> 
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>

