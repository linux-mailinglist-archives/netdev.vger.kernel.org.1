Return-Path: <netdev+bounces-247624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0C4CFC72F
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 08:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E53903031943
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 07:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFB0274B5C;
	Wed,  7 Jan 2026 07:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oijOWwFO"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02946225791;
	Wed,  7 Jan 2026 07:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767771997; cv=none; b=fHTwaAFBtSISSpvNCvT2BYSWB+EYvnisUWH2M8534lqBjBavE+dphHUKp0lFB98EEtB0rGv4dweviSvRcdebwOSqud59jLDJsEF0B11GxdF0l48BBKLuFdboA10R/BM8R1kySos3IscELoM29X0acl1Jgsb5VFT4SmT0h88JWA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767771997; c=relaxed/simple;
	bh=oEHgf362nF3r5k5tYC3FJ8OE41yoA8yImFGjf7YyWiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GKALNTgsfBdevKVYDCQ1NCV5l8PfdT5E31c8fpeuBeUC9lVNKCPX0Ia+2LCfNxvu7Em4X0//qE9QYDr2RTxpq+9RHU6pNMrhJv9O44K6uOGmSwLP81rIYihetF43nxu6HatbQhK/KmdF5tPwIdR2BYVfZYzHDNTGsQc3tCRl0H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oijOWwFO; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767771983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uiX85Z5lezt2DFKZA4ouDdPBVCKxRzKzaRrSuznEhAc=;
	b=oijOWwFOLaMMGtVO/AQFlDcGZqTXn8O3y0EVRpepyFKMEogXUTUVG/CuPcvZAWTIyk6Dh2
	7uorVC5/l2AN1RUdmq90lqAniT0WUPNcuUc1tyBMRy0UOZe3NdeXMjRTDROQn5UAk6ZKGm
	gcjKW/P1hVSYCSHGk/9lNl59/p9Y/Mk=
From: Menglong Dong <menglong.dong@linux.dev>
To: menglong8.dong@gmail.com, bot+bpf-ci@kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 dsahern@kernel.org, tglx@linutronix.de, mingo@redhat.com,
 jiang.biao@linux.dev, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
 yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject:
 Re: [PATCH bpf-next v7 04/11] bpf: support fsession for bpf_session_is_return
Date: Wed, 07 Jan 2026 15:45:51 +0800
Message-ID: <5069825.31r3eYUQgx@7940hx>
In-Reply-To:
 <7b965f06828236a16f0146550e01a581b1c202c427584a894d5a70a42ff06435@mail.kernel.org>
References:
 <20260107064352.291069-5-dongml2@chinatelecom.cn>
 <7b965f06828236a16f0146550e01a581b1c202c427584a894d5a70a42ff06435@mail.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/1/7 15:11 bot+bpf-ci@kernel.org write:
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 41228b0add52..95248b0d28ab 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -1229,6 +1229,9 @@ enum {
> >  #endif
> >  };
> >
> > +#define BPF_TRAMP_M_NR_ARGS	0
> > +#define BPF_TRAMP_M_IS_RETURN	8
> 
> [ ... ]
> 
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index bfff3f84fd91..d3709edd0e51 100644
> 
> [ ... ]
> 
> > @@ -22558,6 +22564,13 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
> >  		   desc->func_id == special_kfunc_list[KF_bpf_rdonly_cast]) {
> >  		insn_buf[0] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
> >  		*cnt = 1;
> > +	} else if (desc->func_id == special_kfunc_list[KF_bpf_session_is_return] &&
> > +		   env->prog->expected_attach_type == BPF_TRACE_FSESSION) {
> > +		/* Load nr_args from ctx - 8 */
> > +		insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
> > +		insn_buf[1] = BPF_ALU64_IMM(BPF_RSH, BPF_REG_0, BPF_TRAMP_M_IS_RETURN);
> > +		insn_buf[2] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1);
> > +		*cnt = 3;
>                 ^^^^
> 
> This inlined code reads the BPF_TRAMP_M_IS_RETURN bit (bit 8) from ctx[-1]
> to determine if the program is running at function exit. However, looking
> at arch/x86/net/bpf_jit_comp.c, the trampoline only stores nr_regs to
> ctx[-8] at this point in the series:
> 
>     emit_mov_imm64(&prog, BPF_REG_0, 0, (u32) nr_regs);
>     emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -nregs_off);
> 
> The BPF_TRAMP_M_IS_RETURN flag is not being set by the trampoline code.
> Is this intentional? The arch code that sets this bit appears to be added
> in a later commit in the series (93d4641b9513 "bpf,x86: add fsession
> support for x86_64").
> 
> At this commit, bpf_session_is_return() for fsession programs will always
> return false, even during fexit execution, because bit 8 is never set.

Yeah, this is intentional. The fsession is architecture specific feature.
For the architecture that doesn't support this feature, the "is_return"
flag will never be set.

After the commit (93d4641b9513 "bpf,x86: add fsession support for x86_64"),
x86_64 support this feature, and the flag will be set for fsession.

> 
> > +	}
> >
> >  	if (env->insn_aux_data[insn_idx].arg_prog) {
> 
> [ ... ]
> 
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 736b32cf2195..9d3bf3bbe8f6 100644
> 
> [ ... ]
> 
> > @@ -3314,6 +3314,12 @@ static u64 bpf_uprobe_multi_entry_ip(struct bpf_run_ctx *ctx)
> >  }
> >  #endif /* CONFIG_UPROBES */
> >
> > +bool bpf_fsession_is_return(void *ctx)
> > +{
> > +	/* This helper call is inlined by verifier. */
> > +	return !!(((u64 *)ctx)[-1] & (1 << BPF_TRAMP_M_IS_RETURN));
> > +}
> 
> The same issue exists here in bpf_fsession_is_return() - it reads bit 8
> which is not set by the trampoline at this point in the series. The
> comment indicates this is inlined by the verifier, but both code paths
> have the same problem.

The logic here is right, as I said above.

> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20773233136
> 





