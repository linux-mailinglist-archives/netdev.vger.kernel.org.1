Return-Path: <netdev+bounces-305636-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QMXGDljETWrp9wEAu9opvQ
	(envelope-from <netdev+bounces-305636-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 05:30:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3DB72162D
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 05:30:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=KeC+qsRv;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305636-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305636-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 89015301E7F9
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 03:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C95E373BE9;
	Wed,  8 Jul 2026 03:30:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C4742087F;
	Wed,  8 Jul 2026 03:30:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783481426; cv=none; b=BqkIZC11YJn/p5TX8O4nwQFUbiaSxA9wnUymxfAcZTJSoH+OglFLX+C7/l1Qe6wuDU2HZUtiKjYqQ/At2qroB2Nz+Tgy7oihSAl79dGXvzIo1eSBgc5aoEy1lzb724Ldj8d3L1oAf+uK1T2B+m6eUtu1dNWx9l80VeCppDHr9ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783481426; c=relaxed/simple;
	bh=4SeRtoGkiJ0YU+DChKH2d4yuDJUGWWHBlkzM6OpeQFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CmN1QQvjNwzWs9fQNh6kCxqjbEImgGxQegzcScXhCpAU/kyMvMeEHMHg1oI3dpmtuDJRejkyEnYQS7ispM654wDkT1qZzFT3+avhUTcfKr/Jw0+iJYvVzVC4ouuvzjsaegEY9qxT/s+uFwH+Ewy9mb62hoLz/tIPzYEUs2yFy20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KeC+qsRv; arc=none smtp.client-ip=91.218.175.178
Message-ID: <6702d2f1-dcd4-4b68-b1ac-daa8661235a0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783481422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hAfIYp1qkUw5nv6HMpuzXiAFinGF8d61HsxbLIT9CoI=;
	b=KeC+qsRvkercaCeJMK0baG7g9L7IgTKrKgPQLRzPzmRJhODWz3t6hFjU3qk3vjnirrr/PY
	LEAGp/rwAN1aiEXn0JNmpcePjQBzkbz42gsEWfYnJ5dCk0RlqCHZAPCVHFv3oTVnUGadbf
	4XsOUfePghJg0y58QGJAtrnwoi4vNvk=
Date: Wed, 8 Jul 2026 11:30:06 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf 1/2] bpf, x86: Fix FineIBT #CP in BPF dispatcher's
 indirect-jump fallback
Content-Language: en-US
To: David Windsor <dwindsor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H . Peter Anvin" <hpa@zytor.com>, "David S . Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <c5a6bff16c0885d3ec756a1cdfb623636d0bdb4a.1783479101.git.dwindsor@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <c5a6bff16c0885d3ec756a1cdfb623636d0bdb4a.1783479101.git.dwindsor@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:dwindsor@gmail.com,m:bpf@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:davem@davemloft.net,m:kuba@kernel.org,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:shuah@kernel.org,m:peterz@infradead.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-305636-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER(0.00)[leon.hwang@linux.dev,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,etsalapatis.com,redhat.com,alien8.de,linux.intel.com,zytor.com,davemloft.net,fomichev.me,infradead.org,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:from_mime,linux.dev:dkim,linux.dev:mid,qemu.org:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9F3DB72162D

On 8/7/26 10:57, David Windsor wrote:
> commit 4f9087f16651 ("x86/cfi,bpf: Fix BPF JIT call") updated
> emit_cfi() to emit FineIBT preambles for JIT-compiled BPF programs, but
> did not update emit_bpf_dispatcher(). When prog->bpf_func is not in the
> dispatcher table (e.g. an XDP_REDIRECT target program in a CPUMAP or
> DEVMAP, or BPF_PROG_TEST_RUN of an unattached prog), the dispatcher
> still jumps directly to prog->bpf_func. Without a FineIBT caller
> sequence, under FineIBT this raises #CP:
> 
>   Missing ENDBR: __cfi_bpf_prog_..._xdp_dispatcher_unattached+0x10/0x10
>   ------------[ cut here ]------------
>   kernel BUG at arch/x86/kernel/cet.c:133!
>   Oops: invalid opcode: 0000 [#1] SMP NOPTI
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
>   RIP: 0010:do_kernel_cp_fault+0x126/0x130
>   Call Trace:
>    <TASK>
>    exc_control_protection+0x46/0x80
>    asm_exc_control_protection+0x2b/0x30
>   RIP: 0010:__cfi_bpf_prog_..._xdp_dispatcher_unattached+0x10/0x10
>    bpf_prog_test_run+0xda/0x1b0
>    __sys_bpf+0x70b/0x990
>    __x64_sys_bpf+0x2d/0x50
>    x64_sys_call+0x1079/0x2d40
>    do_syscall_64+0x12a/0x3c0
>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>    </TASK>
> 
> To fix this, we precede the indirect jump in emit_bpf_dispatcher() with
> the FineIBT caller sequence: load cfi_bpf_hash into %eax and subtract
> cfi_get_offset() from the target so it enters the preamble's real ENDBR.
> Only needed for CFI_FINEIBT.
> 
> Fixes: 4f9087f16651 ("x86/cfi,bpf: Fix BPF JIT call")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Windsor <dwindsor@gmail.com>
> ---
>  arch/x86/net/bpf_jit_comp.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index de7515ea1bea..1c8249d8ca3b 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -3740,6 +3740,15 @@ static int emit_bpf_dispatcher(u8 **pprog, int a, int b, s64 *progs, u8 *image,
>  		if (err)
>  			return err;
>  
> +		/* If running under FineIBT, enter the preamble so the following
> +		 * indirect jump lands on a real ENDBR instead of the poison.
> +		 */


Comment style: /* should stay at its own line.

> +		if (cfi_mode == CFI_FINEIBT) {
> +			EMIT1_off32(0xb8, cfi_bpf_hash);	/* mov $cfi_bpf_hash, %eax */
> +			EMIT1(add_1mod(0x48, BPF_REG_3));	/* sub rdx, cfi_get_offset() */
> +			EMIT2_off32(0x81, add_1reg(0xE8, BPF_REG_3), cfi_get_offset());
> +		}


Better to emit_cfi()?

Thanks,
Leon

> +
>  		emit_indirect_jump(&prog, BPF_REG_3 /* R3 -> rdx */, image + (prog - buf));
>  
>  		*pprog = prog;


