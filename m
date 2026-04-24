Return-Path: <netdev+bounces-281071-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOnwDIL662k1TgAAu9opvQ
	(envelope-from <netdev+bounces-281071-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 01:19:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0E146400C
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 01:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 045C73014670
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 23:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE06037CD2E;
	Fri, 24 Apr 2026 23:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lAdngFjW"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE5F35DA76
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 23:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777072743; cv=none; b=C9SJ1uhd+R/UtzvqPIh3LN0Vv5TDPDdeSItLwy8NvDcYu38Ax3Mt/vytDTl5TrQihdIdCHNqfIh4w1knAkGRL66bBt8mMGEu9zDMT5C1l14GR+lEUe96td7kyBerWCgtXDkI3naJryQiIzy/AFHY95CGbgNO8DNJV0hA8PPwtZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777072743; c=relaxed/simple;
	bh=ZdbPOHovsxwmyuM1J5PjCAiEqYjwYOZZUtcY/EJqJr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TxlQGruKZKVd+oNtrhVW+5oJI+7+TL3Kv4/0mw9IQvLibPlHA0wYT6qyN7BcOxk4f8icySTVTR8rfxYJoxA7daZn/MdLCPtvTK+UHRZ90aCFqAqmSgXfUgViYz299eknaGrd5Pm5L6N/GeSdPWqrbXDVuqy9WrTDkMeg3FsgVFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lAdngFjW; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7dd64547-25a4-46de-a896-98fcec04468e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777072738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P3XVMe3dGeABivLaYIdooN1MvQa1CctnziG70XU09po=;
	b=lAdngFjWpn+SFIEIgyjCn6oyJ7s6mP8JViggHzKVI1eQOG8r8fZE96FmVDJRHvA5PSglKz
	UM1P3b5Y3bU4XRPVejznw6aBsaRiopshcyt4CJCQ3+MTz1tCmr61vtPiwmaHEKEmgNqEbm
	tyMnnBKBDxXtgqkPNrAauQU71Wd0y8w=
Date: Fri, 24 Apr 2026 16:18:29 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RFC bpf-next 2/8] bpf: mark instructions accessing program
 stack
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
 <20260413-kasan-v1-2-1a5831230821@bootlin.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260413-kasan-v1-2-1a5831230821@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 8B0E146400C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281071-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,bootlin.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On 4/13/26 11:28 AM, Alexis LothorÃ© (eBPF Foundation) wrote:
> In order to prepare to emit KASAN checks in JITed programs, JIT
> compilers need to be aware about whether some load/store instructions
> are targeting the bpf program stack, as those should not be monitored
> (we already have guard pages for that, and it is difficult anyway to
> correctly monitor any kind of data passed on stack).
> 
> To support this need, make the BPF verifier mark the instructions that
> access program stack:
> - add a setter that allows the verifier to mark instructions accessing
>   the program stack
> - add a getter that allows JIT compilers to check whether instructions
>   being JITed are accessing the stack
> 
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
> ---
>  include/linux/bpf.h          |  2 ++
>  include/linux/bpf_verifier.h |  2 ++
>  kernel/bpf/core.c            | 10 ++++++++++
>  kernel/bpf/verifier.c        |  7 +++++++
>  4 files changed, 21 insertions(+)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index b4b703c90ca9..774a0395c498 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1543,6 +1543,8 @@ void bpf_jit_uncharge_modmem(u32 size);
>  bool bpf_prog_has_trampoline(const struct bpf_prog *prog);
>  bool bpf_insn_is_indirect_target(const struct bpf_verifier_env *env, const struct bpf_prog *prog,
>  				 int insn_idx);
> +bool bpf_insn_accesses_stack(const struct bpf_verifier_env *env,
> +			     const struct bpf_prog *prog, int insn_idx);
>  #else
>  static inline int bpf_trampoline_link_prog(struct bpf_tramp_link *link,
>  					   struct bpf_trampoline *tr,
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index b148f816f25b..ab99ed4c4227 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -660,6 +660,8 @@ struct bpf_insn_aux_data {
>  	u16 const_reg_map_mask;
>  	u16 const_reg_subprog_mask;
>  	u32 const_reg_vals[10];
> +	/* instruction accesses stack */
> +	bool accesses_stack;
>  };
>  
>  #define MAX_USED_MAPS 64 /* max number of maps accessed by one eBPF program */
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 8b018ff48875..340abfdadbed 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -1582,6 +1582,16 @@ bool bpf_insn_is_indirect_target(const struct bpf_verifier_env *env, const struc
>  	insn_idx += prog->aux->subprog_start;
>  	return env->insn_aux_data[insn_idx].indirect_target;
>  }
> +
> +bool bpf_insn_accesses_stack(const struct bpf_verifier_env *env,
> +			     const struct bpf_prog *prog, int insn_idx)
> +{
> +	if (!env)
> +		return false;
> +	insn_idx += prog->aux->subprog_start;
> +	return env->insn_aux_data[insn_idx].accesses_stack;
> +}
> +
>  #endif /* CONFIG_BPF_JIT */
>  
>  /* Base function for offset calculation. Needs to go into .text section,
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1e36b9e91277..7bce4fb4e540 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3502,6 +3502,11 @@ static void mark_indirect_target(struct bpf_verifier_env *env, int idx)
>  	env->insn_aux_data[idx].indirect_target = true;
>  }
>  
> +static void mark_insn_accesses_stack(struct bpf_verifier_env *env, int idx)
> +{
> +	env->insn_aux_data[idx].accesses_stack = true;
> +}
> +
>  #define LR_FRAMENO_BITS	3
>  #define LR_SPI_BITS	6
>  #define LR_ENTRY_BITS	(LR_SPI_BITS + LR_FRAMENO_BITS + 1)
> @@ -6490,6 +6495,8 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
>  		else
>  			err = check_stack_write(env, regno, off, size,
>  						value_regno, insn_idx);
> +
> +		mark_insn_accesses_stack(env, insn_idx);

I am not sure this can be done unconditionally here.

It may be possible in different states to have different pointer
types for the affected reg (PTR_TO_STACK in one execution path and say
PTR_TO_MAP_VALUE in another). And if set uncoditionally,
instrumentation may be skipped for legitimate targets.

Maybe reset by default in check_mem_access()?

>  	} else if (reg_is_pkt_pointer(reg)) {
>  		if (t == BPF_WRITE && !may_access_direct_pkt_data(env, NULL, t)) {
>  			verbose(env, "cannot write into packet\n");
> 


