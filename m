Return-Path: <netdev+bounces-252993-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJhtKB8JdGmE1gAAu9opvQ
	(envelope-from <netdev+bounces-252993-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 00:49:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D41977B8C8
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 00:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81B3B3012C5C
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 23:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8EE254AFF;
	Fri, 23 Jan 2026 23:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ABSaO2mn"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02DD1ACEDE
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 23:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769212188; cv=none; b=gR3XeGz6JT7xB8VRmREvO6onvOCFpsVeqh3lSNcX2RBgstJkMOptA6WK9iD42jDe526L2iotz8gzcxgZTtsPLUwoXKYkxM1v5QiJCz57Fzdzfxvo+OVPfSlhwvveKOc+J5NmOXahUQa7k++1akMPuEwuN2H5wKqUhwFV3G72IdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769212188; c=relaxed/simple;
	bh=b4VnQeWoptQ28TK9HlENzSnHiRsKOxr1MYsi2SmPhdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JAmAZasQxNrxzP2rFWt/HcLFk6h5VaCop1CqKMuy6eo0iltd3/+WdR0Ocq0/HKfsbRXtsObl4SVMUPt0F6Ix6Mcx/fYsK+u9KA15F8ayOzKw/RFYjxsTzRnq/ePllPoLZE5PA59ToZBuMxmQfP84dSiUtDSeCfghnHHaPVffJoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ABSaO2mn; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bbbf1b30-dfc9-4206-9285-0ce96e934e54@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769212183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xHM7cDEq2dLPRUsQsCW2aeoo3VeBsaynbMV8WcG9udo=;
	b=ABSaO2mnDYnQU5l6W0hwizoC8ZOSsTNyag7YtxswruaYmuQBHHFiJp5EX6fC4HSfggosEq
	AwCZIU98MhKBhEOqJZ/p8hMPBK8FeBUyF41XI//cMFoVuhhhZ3VE8X8iTtdF+OXI2U+h7c
	7eqjTX7bdLBftvJIC+laqg2DxrqoZq0=
Date: Fri, 23 Jan 2026 15:49:34 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/4] bpf, verifier: Support direct helper
 calls from prologue/epilogue
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Amery Hung <ameryhung@gmail.com>, netdev@vger.kernel.org,
 kernel-team@cloudflare.com, ihor.solodrai@linux.dev, bpf@vger.kernel.org
References: <20260123-skb-meta-bpf-emit-call-from-prologue-v2-0-0e50db4d4663@cloudflare.com>
 <20260123-skb-meta-bpf-emit-call-from-prologue-v2-1-0e50db4d4663@cloudflare.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20260123-skb-meta-bpf-emit-call-from-prologue-v2-1-0e50db4d4663@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252993-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,vger.kernel.org,cloudflare.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D41977B8C8
X-Rspamd-Action: no action

On 1/23/26 9:05 AM, Jakub Sitnicki wrote:
> @@ -23909,6 +23928,9 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
>   			goto next_insn;
>   		}
>   patch_call_imm:
> +		if (env->insn_aux_data[i + delta].finalized_call)
> +			goto next_insn;
> +
>   		fn = env->ops->get_func_proto(insn->imm, env->prog);
>   		/* all functions that have prototype and verifier allowed
>   		 * programs to call them, must be real in-kernel functions
> @@ -23920,6 +23942,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
>   			return -EFAULT;
>   		}
>   		insn->imm = fn->func - __bpf_call_base;
> +		env->insn_aux_data[i + delta].finalized_call = true;
>   next_insn:
>   		if (subprogs[cur_subprog + 1].start == i + delta + 1) {
>   			subprogs[cur_subprog].stack_depth += stack_depth_extra;
> diff --git a/net/core/filter.c b/net/core/filter.c
> index d14401193b01..cb39388f69a9 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -9082,8 +9082,7 @@ static int bpf_unclone_prologue(struct bpf_insn *insn_buf, bool direct_write,
>   	/* ret = bpf_skb_pull_data(skb, 0); */
>   	*insn++ = BPF_MOV64_REG(BPF_REG_6, BPF_REG_1);
>   	*insn++ = BPF_ALU64_REG(BPF_XOR, BPF_REG_2, BPF_REG_2);
> -	*insn++ = BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0,
> -			       BPF_FUNC_skb_pull_data);
> +	*insn++ = BPF_EMIT_CALL(bpf_skb_pull_data);

Ihor reported that the test_map has started failing on arm64.

https://github.com/kernel-patches/bpf/actions/runs/21298510237/job/61311053284
https://github.com/kernel-patches/bpf/actions/runs/21298505282/job/61312363930
https://github.com/kernel-patches/bpf/actions/runs/21301695907/job/61321375157

For BPF_PROG_TYPE_SK_SKB, the BPF_FUNC_skb_pull_data has a different
func_proto. It is sk_skb_pull_data instead of bpf_skb_pull_data.
A different func needs to be emitted here based on prog type.
Not sure why it only fails on arm64.

The set has been reverted to get the CI going.
Please address the issue, add a test for this case, and
then respin. Thanks.


