Return-Path: <netdev+bounces-82344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D46D88D586
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 05:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EDA21C232CA
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 04:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BBF36B;
	Wed, 27 Mar 2024 04:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jHxXhwLZ"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124961849
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 04:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711514854; cv=none; b=HBe+02fq1BJj1Lt09+CjoxPNcNgPNe/yv5gfzw1nEAR8qLiG/53XU8VlDmiq72wNVBEF6ZGGkruD6ncFxNVpSKlA6MuR4ITD6l4Dn0VYWq14Rv6M7naFpePzlgaN551Cnps9HVUp5A0eizRTmTnNWpdGwzCsn9L2rvfFzkU4Q0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711514854; c=relaxed/simple;
	bh=GoAYJoUbDvL+mnkA0okNy+Gw9hafyMKwLrOYooCCFpc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mRSunQUObge7tm1YGp9xOZxWcbaELc+1sA7jYTvNDyX10zX8lXNXHU7+AQBTYDN3FLtwxu8YzhKA4JciXEXtRqVWD7GauYiOB/1jGnDidGRUA/ofm25gVbOdSGmk+IIc8lu3i+sD5O//+SulfbeCYMeYRdnc2XfawRDQGqH0aOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jHxXhwLZ; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5063d525-d9df-4aaf-991d-bcb9f495c041@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711514849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IbK/ZW/7K1EL+Nq+KEdi1fO9koy8r8tuTSZhqjqIDLg=;
	b=jHxXhwLZAtItISUimSJNjxg2zvqb2tFGCkNTaO6P7vfwuDuFq8E7KGiu1sSUSiliZtlIo7
	8M6GNF23yDP5uiYyPqC/hgWLYEcl86fEEkUTB4Gu4EYNt37JkL3VfNLjYrEOu9C/oaV7Gf
	JPklqrU3PIqJNs0EYfxBA20Od30YaCQ=
Date: Tue, 26 Mar 2024 21:47:14 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] [bpf?] [net?] KMSAN: uninit-value in dev_map_lookup_elem
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 syzbot <syzbot+1a3cf6f08d68868f9db3@syzkaller.appspotmail.com>,
 bpf <bpf@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eddy Z <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
 KP Singh <kpsingh@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Song Liu <song@kernel.org>,
 syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <0000000000006f876b061478e878@google.com>
 <a402206e-a9c9-40bd-bf78-710054506071@linux.dev>
 <CAADnVQLXyQ_o5hSA0OpHYj231WKPFNRNMyr0NePMr2ypusiLmg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQLXyQ_o5hSA0OpHYj231WKPFNRNMyr0NePMr2ypusiLmg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 3/26/24 6:07 PM, Alexei Starovoitov wrote:
> On Tue, Mar 26, 2024 at 5:54 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>> On 3/25/24 2:36 AM, syzbot wrote:
>>> Hello,
>>>
>>> syzbot found the following issue on:
>>>
>>> HEAD commit:    5e74df2f8f15 Merge tag 'x86-urgent-2024-03-24' of git://gi..
>>> git tree:       upstream
>>> console+strace: https://syzkaller.appspot.com/x/log.txt?x=148872a5180000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=e6bd769cb793b98a
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=1a3cf6f08d68868f9db3
>>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15921a6e180000
>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12e081f1180000
>>>
>>> Downloadable assets:
>>> disk image: https://storage.googleapis.com/syzbot-assets/1a82880723a7/disk-5e74df2f.raw.xz
>>> vmlinux: https://storage.googleapis.com/syzbot-assets/fd3046ac43b9/vmlinux-5e74df2f.xz
>>> kernel image: https://storage.googleapis.com/syzbot-assets/2097be59cbc1/bzImage-5e74df2f.xz
>>>
>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>>> Reported-by: syzbot+1a3cf6f08d68868f9db3@syzkaller.appspotmail.com
>>>
>>> =====================================================
>>> BUG: KMSAN: uninit-value in __dev_map_lookup_elem kernel/bpf/devmap.c:441 [inline]
>>> BUG: KMSAN: uninit-value in dev_map_lookup_elem+0xf3/0x170 kernel/bpf/devmap.c:796
>>>    __dev_map_lookup_elem kernel/bpf/devmap.c:441 [inline]
>>>    dev_map_lookup_elem+0xf3/0x170 kernel/bpf/devmap.c:796
>>>    ____bpf_map_lookup_elem kernel/bpf/helpers.c:42 [inline]
>>>    bpf_map_lookup_elem+0x5c/0x80 kernel/bpf/helpers.c:38
>>>    ___bpf_prog_run+0x13fe/0xe0f0 kernel/bpf/core.c:1997
>>>    __bpf_prog_run256+0xb5/0xe0 kernel/bpf/core.c:2237
>> It should be in the interpreter mode.
>>
>> The C reproducer is trying to run the following bpf prog:
>>
>>      0: (18) r0 = 0x0
>>      2: (18) r1 = map[id:49]
>>      4: (b7) r8 = 16777216
>>      5: (7b) *(u64 *)(r10 -8) = r8
>>      6: (bf) r2 = r10
>>      7: (07) r2 += -229
>>              ^^^^^^^^^^
>>
>>      8: (b7) r3 = 8
>>      9: (b7) r4 = 0
>>     10: (85) call dev_map_lookup_elem#1543472
>>     11: (95) exit
>>
>> I think this KMSAN report (and a few others related to lookup/delete_elem)
>> should only happen in the interpreter mode.
>>
>> Does it worth to suppress it by always initializing the stack in the interpreter
>> mode considering the interpreter is not very speed sensitive ?
> Maybe we can mark it as initialized from kmsan pov ?
> There are kasan_poison/unpoison helpers that may fit ?

Maybe use kmsan_unpoison_memory()?

In lib/Kconfig.kmsan, we have

config KMSAN
         bool "KMSAN: detector of uninitialized values use"
         depends on HAVE_ARCH_KMSAN && HAVE_KMSAN_COMPILER
         depends on DEBUG_KERNEL && !KASAN && !KCSAN
         depends on !PREEMPT_RT
         select STACKDEPOT
         select STACKDEPOT_ALWAYS_INIT
         help
           KernelMemorySanitizer (KMSAN) is a dynamic detector of uses of
           uninitialized values in the kernel. It is based on compiler
           instrumentation provided by Clang and thus requires Clang to build.

           An important note is that KMSAN is not intended for production use,
           because it drastically increases kernel memory footprint and slows
           the whole system down.

           See <file:Documentation/dev-tools/kmsan.rst> for more details.

So enable KMSAN, KASAN and KCSAN needs to be disabled.


