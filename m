Return-Path: <netdev+bounces-207035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 185AAB05653
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 11:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6233C560D78
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 09:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572292356C3;
	Tue, 15 Jul 2025 09:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EuvzzO3B"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D3D6FC3
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 09:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752571893; cv=none; b=Br+Zg2HKvZMR/VzuUIOfX2IpprHJmY3aK4dWzPEGxONYW4ztfOJ9577K/rv3rfdHTyVgAPH7pYR60YylycdyUOoQRZoD2o29DgEYklzte/4+TqoqW2XNA0MX/5YiNA4O87WXzEYXM7HHydZBl44eDbHPR2sGqzU8aDgkxZGx/EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752571893; c=relaxed/simple;
	bh=O6JvNQl9xBY2bpg9LmsVRPGmuCcGyKF26AwgbCaUKes=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=poEXRkNnY4IZu8NkSQ/wGFz6PXiSladVKgz+MXXFPVD+dwLeJLl1yBnkuv0jYG7ey0R/erPYiW5aQX2NgIPHcXggEav7DnmPalqhQXGbxpm2zyAoVkFMRTgvndUrU5BRjXJtjvXgexd+aQMC6p1w9QBA77fYoy2hBrdwZ/MXkDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EuvzzO3B; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3bccb986-bea1-4df0-a4fe-1e668498d5d5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752571879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xeb/5krIjlgFOYTQ1dg8crO5sGUnJfkG9s1zmFFtH8Y=;
	b=EuvzzO3B/H/e5s4kCNrtS+wt9dPXsnn0AgakROKGTq+yeKTtz8On47cQoohDsrc3Watfqv
	/q8qpaNKC2KQvfLz4cXso5ZF9T+MYK5sCHmvqf3FnjZtWdrkuYvhwby9VxL99rxSNcyUAk
	ZrjOy28AcgB7oZApVxf0z4uE2IKxLrM=
Date: Tue, 15 Jul 2025 17:30:19 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 02/18] x86,bpf: add bpf_global_caller for
 global trampoline
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Menglong Dong <menglong8.dong@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <jolsa@kernel.org>,
 bpf <bpf@vger.kernel.org>, Menglong Dong <dongml2@chinatelecom.cn>,
 "H. Peter Anvin" <hpa@zytor.com>, Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
 <20250703121521.1874196-3-dongml2@chinatelecom.cn>
 <CAADnVQKP1-gdmq1xkogFeRM6o3j2zf0Q8Atz=aCEkB0PkVx++A@mail.gmail.com>
 <45f4d349-7b08-45d3-9bec-3ab75217f9b6@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Menglong Dong <menglong.dong@linux.dev>
In-Reply-To: <45f4d349-7b08-45d3-9bec-3ab75217f9b6@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 7/15/25 16:36, Menglong Dong wrote:
>
> On 7/15/25 10:25, Alexei Starovoitov wrote:
>> Pls share top 10 from "perf report" while running the bench.
>> I'm curious about what's hot.
>> Last time I benchmarked fentry/fexit migrate_disable/enable were
>> one the hottest functions. I suspect it's the case here as well.
>
>
> You are right, the migrate_disable/enable are the hottest functions in
> both bpf trampoline and global trampoline. Following is the perf top
> for fentry-multi:
> 36.36% bpf_prog_2dcccf652aac1793_bench_trigger_fentry_multi [k] 
> bpf_prog_2dcccf652aac1793_bench_trigger_fentry_multi 20.54% [kernel] 
> [k] migrate_enable 19.35% [kernel] [k] bpf_global_caller_5_run 6.52% 
> [kernel] [k] bpf_global_caller_5 3.58% libc.so.6 [.] syscall 2.88% 
> [kernel] [k] entry_SYSCALL_64 1.50% [kernel] [k] memchr_inv 1.39% 
> [kernel] [k] fput 1.04% [kernel] [k] migrate_disable 0.91% [kernel] 
> [k] _copy_to_user
>
> And I also did the testing for fentry:
>
> 54.63% bpf_prog_2dcccf652aac1793_bench_trigger_fentry [k] 
> bpf_prog_2dcccf652aac1793_bench_trigger_fentry
> 10.43% [kernel] [k] migrate_enable
> 10.07% bpf_trampoline_6442517037 [k] bpf_trampoline_6442517037
> 8.06% [kernel] [k] __bpf_prog_exit_recur 4.11% libc.so.6 [.] syscall 
> 2.15% [kernel] [k] entry_SYSCALL_64 1.48% [kernel] [k] memchr_inv 
> 1.32% [kernel] [k] fput 1.16% [kernel] [k] _copy_to_user 0.73% 
> [kernel] [k] bpf_prog_test_run_raw_tp
> The migrate_enable/disable are used to do the recursive checking,
> and I even wanted to perform recursive checks in the same way as
> ftrace to eliminate this overhead :/
>

Sorry that I'm not familiar with Thunderbird yet, and the perf top
messed up. Following are the test results for fentry-multi:
   36.36% bpf_prog_2dcccf652aac1793_bench_trigger_fentry_multi [k] 
bpf_prog_2dcccf652aac1793_bench_trigger_fentry_multi
   20.54% [kernel] [k] migrate_enable
   19.35% [kernel] [k] bpf_global_caller_5_run
   6.52% [kernel] [k] bpf_global_caller_5
   3.58% libc.so.6 [.] syscall
   2.88% [kernel] [k] entry_SYSCALL_64
   1.50% [kernel] [k] memchr_inv
   1.39% [kernel] [k] fput
   1.04% [kernel] [k] migrate_disable
   0.91% [kernel] [k] _copy_to_user

And I also did the testing for fentry:
   54.63% bpf_prog_2dcccf652aac1793_bench_trigger_fentry [k] 
bpf_prog_2dcccf652aac1793_bench_trigger_fentry
   10.43% [kernel] [k] migrate_enable
   10.07% bpf_trampoline_6442517037 [k] bpf_trampoline_6442517037
   8.06% [kernel] [k] __bpf_prog_exit_recur
   4.11% libc.so.6 [.] syscall
   2.15% [kernel] [k] entry_SYSCALL_64
   1.48% [kernel] [k] memchr_inv
   1.32% [kernel] [k] fput
   1.16% [kernel] [k] _copy_to_user
   0.73% [kernel] [k] bpf_prog_test_run_raw_tp

The migrate_enable/disable are used to do the recursive checking,
and I even wanted to perform recursive checks in the same way as
ftrace to eliminate this overhead :/

Thanks!
Menglong Dong

