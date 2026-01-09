Return-Path: <netdev+bounces-248553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA5DD0B439
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 17:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3F8F13022F1B
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 16:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553BC30FF23;
	Fri,  9 Jan 2026 16:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jbxnvxnF"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E0635FF70
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 16:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767976310; cv=none; b=h6p+Ie4sOplFA51Ddcs2/h9qQ0q5Gs0gbX10SU8z1jW7lkvxAf7Lwd7Z4F77T3fm/FN2yP6w34Wza9VEA11sgWvN2E/Dfd5ZeLddigzKDIAa6r4u8wNP7IStGStuNg1qXe4N4aHtqy9xCcHkja2hIGJaih9a213d5vTnwVKVUmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767976310; c=relaxed/simple;
	bh=BCRMP2eyuWt/cu6xQkRQpDmqsMIlGvgreC2eYv+qXgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HWJyoM16CblGt+cQUIhrv0qB84O9c8wergzYvz42icczFMZC2amN0yfE2wuRJDXp53IoXXPfUvvsX7qXoBy8l3+3b/b7ias9mMH2XOm4VaBQh7/WosbSydLZ92z5jg4s/ypr3oImfvulhCeSSBIj704dUN3R8vVE9qaZSfn7tZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jbxnvxnF; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <216a9728-ae69-43af-8632-471b71c56607@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767976296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m76scKJtcG0f+dGnY7fKIibaFnzEOHd/0jl+nbkZ6eY=;
	b=jbxnvxnFjlfyjXnAnVY3GRMUKcPkHWm/nZvlrsuH8xBOhF7hR/8erFycp+tmsGUMpZVrSx
	nt/p5Ggn+hboMbDHzGnJD55WkF0fJg1stkFeetLmsHjlOMYFOti9jshlSZMaOR+B3lioeS
	H0HZCDx3JuVadET64fJNMuIdZ1Uvntk=
Date: Sat, 10 Jan 2026 00:31:20 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/3] bpf, x64: Call perf_snapshot_branch_stack in
 trampoline
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 David Ahern <dsahern@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>,
 "H . Peter Anvin" <hpa@zytor.com>, Matt Bobrowski
 <mattbobrowski@google.com>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Shuah Khan <shuah@kernel.org>, Network Development <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 kernel-patches-bot@fb.com
References: <20260109153420.32181-1-leon.hwang@linux.dev>
 <20260109153420.32181-2-leon.hwang@linux.dev>
 <CAADnVQK4O-igzuSvfgjG1ZqdUBXrjNL=4tJZuS1uy36GCD2mVg@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAADnVQK4O-igzuSvfgjG1ZqdUBXrjNL=4tJZuS1uy36GCD2mVg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2026/1/10 00:24, Alexei Starovoitov wrote:
> On Fri, Jan 9, 2026 at 7:37 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>

[...]

>> @@ -3366,6 +3416,14 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
>>
>>         save_args(m, &prog, regs_off, false, flags);
>>
>> +       if (bpf_prog_copy_branch_snapshot(fentry)) {
>> +               /* Get branch snapshot asap. */
>> +               if (invoke_branch_snapshot(&prog, image, rw_image)) {
>> +                       ret = -EINVAL;
>> +                       goto cleanup;
>> +               }
>> +       }
> 
> Andrii already tried to do it.
> I hated it back then and still hate the idea.
> We're not going to add custom logic for one specific use case
> no matter how appealing it sounds to save very limited LBR entries.
> The HW will get better, but we will be stuck with this optimization forever.
> 

Understood, thanks for the explanation.

I won’t pursue this approach further.

Thanks,
Leon


