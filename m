Return-Path: <netdev+bounces-281070-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCdwN3T462kKTgAAu9opvQ
	(envelope-from <netdev+bounces-281070-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 01:10:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 653FA463FB7
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 01:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 231AC301BA67
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 23:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7EC379ED2;
	Fri, 24 Apr 2026 23:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VXHbxxZf"
X-Original-To: netdev@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F30361651;
	Fri, 24 Apr 2026 23:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777072240; cv=none; b=KEDE286NQatxMVAgy1Ox218aeqsMHulTWYeRcTFphXF04ksMUKvzojL/IzTmmtU7JK/l5A+QL+zgPlBH5NtvtTgGK1i9EpGbh0l7Eie+DFDtlK1filH6y82A9X6I2lnUqfnee0/NUnX3jAJFsd77qOCVA17oBE0dd5KsTB0kSSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777072240; c=relaxed/simple;
	bh=VX1tYX9cRv+eO+feWH8A3dJq6HWUr6MsMOHqfw2gbSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gAuGG1cI/1dY8WRIburhqxEeLtq5S2GEj6kuTeFMauzXeGFVzHa7Z6droxB6EgnSUHMw/5jXLLBwlYuJuEWDRU/iywl5d0VdOmNwkRQgzuoYqKGd7uq3Pg2aYtsP6W+S1V0zsUBD20QmDce4Dmz5ypWOxuI7XYPcdBDzJzMImPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VXHbxxZf; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <71fb19ff-6dde-43f4-a0e9-5c8cf2ba4ed4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777072234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZF2xo+im5ABqQb8juDoszdqEpMu6aUbnETaBqpZGMY0=;
	b=VXHbxxZfy9OoLtXfzxZ8LCjQMjD/OkCiG8Davia89CJr1Bfd4TuZZXt6E5Iwkup+l0h+3v
	cFjh3APLkpXSJQIKe7Yoo0ID2ftKfKivDSn005tkbrPGCE8tOLFAb99bTVlgqSaCzwUXKq
	dS3LDHdZC3mJaN1fdjTfIxwCD2pD6Pc=
Date: Fri, 24 Apr 2026 16:10:19 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RFC bpf-next 0/8] bpf: add support for KASAN checks in
 JITed programs
To: =?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?=
 <alexis.lothore@bootlin.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Shuah Khan <shuah@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: ebpf@linuxfoundation.org,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Xu Kuohai <xukuohai@huawei.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, kasan-dev@googlegroups.com,
 linux-mm@kvack.org
References: <20260413-kasan-v1-0-1a5831230821@bootlin.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260413-kasan-v1-0-1a5831230821@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 653FA463FB7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281070-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[bootlin.com,kernel.org,iogearbox.net,linux.dev,gmail.com,davemloft.net,redhat.com,alien8.de,linux.intel.com,zytor.com,foss.st.com,google.com,arm.com,linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[40];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ihor.solodrai@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:email,linux.dev:dkim,linux.dev:mid]

On 4/13/26 11:28 AM, Alexis LothorÃ© (eBPF Foundation) wrote:
> Hello,
> this series aims to bring basic support for KASAN checks to BPF JITed
> programs. This follows the first RFC posted in [1].

Hi Alexis,

Thank you for working on this, it's a real testing gap.
I have a few comments, see below.

The series doesn't apply cleanly on bpf-next right now, but I was able
to apply to a little older revision (eb5249b12507).

> 
> KASAN allows to spot memory management mistakes by reserving a fraction
> of memory as "shadow memory" that will map to the rest of the memory and
> allow its monitoring. Each memory-accessing instruction is then
> instrumented at build time to call some ASAN check function, that will
> analyze the corresponding bits in shadow memory, and if it detects the
> access as invalid, trigger a detailed report. The goal of this series is
> to replicate this mechanism for BPF programs when they are being JITed
> into native instructions: that's then the (runtime) JIT compiler who is
> in charge of inserting calls to the corresponding kasan checks, when a
> program is being loaded into the kernel. This task involves:
> - identifying at program load time the instructions performing memory
>   accesses
> - identifying those accesses properties (size ? read or write ?) to
>   define the relevant kasan check function to call
> - just before the identified instructions:
>   - perform the basic context saving (ie: saving registers)
>   - inserting a call to the relevant kasan check function 
>   - restore context
> - whenever the instrumented program executes, if it performs an invalid
>   access, it triggers a kasan report identical to those instrumented on
>   kernel side at build time.
> 
> As discussed in [1], this series is based on some choices and
> assumptions:
> - it focuses on x86_64 for now, and so only on KASAN_GENERIC

I wonder if it's feasible to implement KASAN support on the verifier
side in post-verification fixups. AI slop for illustration:

  ;; Original (1 BPF insn):
  dst = *(u64 *)(src + off)           ; BPF_LDX | BPF_MEM | BPF_DW

  ;; Rewrite (~7 BPF insns):
  r_tmp1 = src                         ; BPF_MOV64_REG
  r_tmp1 += off                        ; BPF_ALU64 | BPF_ADD | K   (full address)
  r_tmp2 = r_tmp1                      ; copy
  r_tmp2 >>= 3                         ; KASAN_SHADOW_SCALE_SHIFT
  r_tmp2 += KASAN_SHADOW_OFFSET        ; shadow address
  r_tmp3 = *(u8 *)(r_tmp2 + 0)         ; BPF_LDX | BPF_B   (load shadow byte)
  if r_tmp3 != 0 goto +2               ; BPF_JNE | PC+2
  dst = *(u64 *)(src + off)            ; original access (fast path)
  goto +1                              ; skip slowpath
  call __asan_report_load8             ; BPF kfunc
  dst = *(u64 *)(src + off)            ; retry the access after report (non-fatal)

A sort of inline kasan directly in BPF.

There are plenty of issues with it: instruction limit, exposing asan
API as kfuncs, etc. On the flip side we get cross-arch support out of
the box with no or mininal JIT changes.

Honestly I'm not excited about this approach, but curious if anyone
thought about this, or maybe it was already discussed?


> - not all memory accessing BPF instructions are being instrumented:
>   - it focuses on STX/LDX instructions
>   - it discards instructions accessing BPF program stack (already
>     monitored by page guards)
>   - it discards possibly faulting instructions, like BPF_PROBE_MEM or
>     BPF_PROBE_ATOMIC insns
> 
> The series is marked and sent as RFC:
> - to allow collecting feedback early and make sure that it goes into the
>   right direction
> - because it depends on Xu's work to pass data between the verifier and
>   JIT compilers. This work is not merged yet, see [2]. I have been
>   tracking the various revisions he sent on the ML and based my local
>   branch on his work
> - because tests brought by this series currently can't run on BPF CI:
>   they expect kasan multishot to be enabled, otherwise the first test
>   will make all other kasan-related tests fail.

AFAICT this can be trivially fixed on BPF CI side, we just need to set
kasan_multi_shot for the VMs running the tests. I will do that, your
next revision doesn't have to be and RFC.

> - because some cases like atomic loads/stores are not instrumented yet
>   (and are still making me scratch my head)
> - because it will hopefully provide a good basis to discuss the topic at
>   LSFMMBPF (see [3])

Apparently, KASAN reporting routine takes a lock [1]:

   __asan_load()
     -> check_region_inline()
        -> kasan_report()
           -> start_report()
             -> raw_spin_lock_irqsave(&report_lock, *flags);

BPF programs can run in NMI context, and so it appears to be possible
to get an unflagged (because of lockdep_off() in start_report)
deadlock, if an NMI fires on a CPU already holding report_lock.
Although I guess you'd need two KASAN bugs to happen
simultaneously for that to occur?... A rare event, I would hope.

It could be addressed with either in_nmi() check at runtime, or
forbidding kasan for NMI-runnable BPF program types.

That said, this may be a case of being overly defensive to appease the
ai overlords.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/mm/kasan/report.c?h=v7.0#n204

> 
> Despite this series not being ready for integration yet, anyone
> interested in running it locally can perform the following steps to run
> the JITed KASAN instrumentation selftests:
> - rebasing locally this series on [2]
> - building and running the corresponding kernel with kasan_multi_shot
>   enabled
> - running `test_progs -a kasan`
> 
> And should get a variety of KASAN tests executed for BPF programs:
> 
>   #162/1   kasan/bpf_kasan_uaf_read_1:OK
>   #162/2   kasan/bpf_kasan_uaf_read_2:OK
>   #162/3   kasan/bpf_kasan_uaf_read_4:OK
>   #162/4   kasan/bpf_kasan_uaf_read_8:OK
>   #162/5   kasan/bpf_kasan_uaf_write_1:OK
>   #162/6   kasan/bpf_kasan_uaf_write_2:OK
>   #162/7   kasan/bpf_kasan_uaf_write_4:OK
>   #162/8   kasan/bpf_kasan_uaf_write_8:OK
>   #162/9   kasan/bpf_kasan_oob_read_1:OK
>   #162/10  kasan/bpf_kasan_oob_read_2:OK
>   #162/11  kasan/bpf_kasan_oob_read_4:OK
>   #162/12  kasan/bpf_kasan_oob_read_8:OK
>   #162/13  kasan/bpf_kasan_oob_write_1:OK
>   #162/14  kasan/bpf_kasan_oob_write_2:OK
>   #162/15  kasan/bpf_kasan_oob_write_4:OK
>   #162/16  kasan/bpf_kasan_oob_write_8:OK
>   #162     kasan:OK
>   Summary: 1/16 PASSED, 0 SKIPPED, 0 FAILED
> 
> [1] https://lore.kernel.org/bpf/DG7UG112AVBC.JKYISDTAM30T@bootlin.com/
> [2] https://lore.kernel.org/bpf/cover.1776062885.git.xukuohai@hotmail.com/
> [3] https://lore.kernel.org/bpf/DGGNCXX79H8O.2P6K8L1QW1M8K@bootlin.com/
> 
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
> ---
> Alexis Lothoré (eBPF Foundation) (8):
>       kasan: expose generic kasan helpers
>       bpf: mark instructions accessing program stack
>       bpf: add BPF_JIT_KASAN for KASAN instrumentation of JITed programs
>       bpf, x86: add helper to emit kasan checks in x86 JITed programs
>       bpf, x86: emit KASAN checks into x86 JITed programs
>       selftests/bpf: do not run verifier JIT tests when BPF_JIT_KASAN is enabled
>       bpf, x86: enable KASAN for JITed programs on x86
>       selftests/bpf: add tests to validate KASAN on JIT programs
> 
>  arch/x86/Kconfig                                   |   1 +
>  arch/x86/net/bpf_jit_comp.c                        | 106 +++++++++++++
>  include/linux/bpf.h                                |   2 +
>  include/linux/bpf_verifier.h                       |   2 +
>  include/linux/kasan.h                              |  13 ++
>  kernel/bpf/Kconfig                                 |   9 ++
>  kernel/bpf/core.c                                  |  10 ++
>  kernel/bpf/verifier.c                              |   7 +
>  mm/kasan/kasan.h                                   |  10 --
>  tools/testing/selftests/bpf/prog_tests/kasan.c     | 165 +++++++++++++++++++++
>  tools/testing/selftests/bpf/progs/kasan.c          | 146 ++++++++++++++++++
>  .../testing/selftests/bpf/test_kmods/bpf_testmod.c |  79 ++++++++++
>  tools/testing/selftests/bpf/test_loader.c          |   5 +
>  tools/testing/selftests/bpf/unpriv_helpers.c       |   5 +
>  tools/testing/selftests/bpf/unpriv_helpers.h       |   1 +
>  15 files changed, 551 insertions(+), 10 deletions(-)
> ---
> base-commit: 7990a071b32887a1a883952e8cf60134b6d6fea0
> change-id: 20260126-kasan-fcd68f64cd7b
> 
> Best regards,
> --  
> Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
> 


