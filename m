Return-Path: <netdev+bounces-81428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB595887E54
	for <lists+netdev@lfdr.de>; Sun, 24 Mar 2024 19:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 507271F2159A
	for <lists+netdev@lfdr.de>; Sun, 24 Mar 2024 18:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42EA3B787;
	Sun, 24 Mar 2024 18:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VP5Q2opu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB793A287;
	Sun, 24 Mar 2024 18:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711304808; cv=none; b=VpP8fMMVYBgyz2qs94RmtU+Q1VWtLOopPteKc8vH3FpUU1SpvdMINswsWnzTuHNjwnx7imB2zYmDDDaS4KtccdxJUP7RJk6wwKnXicaDe9nHarUyhWJ7OO7jTjOTgnFH76PqmG9It77rCMbvT3ZBWgZLvptW2vKPvvWUoe22aPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711304808; c=relaxed/simple;
	bh=Te9pO6QlW1ce96bLPk19S/y/gdZyxbmLtdjJ0aVTPqk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sqKxNT/Ld/aqJff5EwmG+bhAw6A9/IVf9C35WglU47BzLTXYNb+4jJIYGmfecbiN40P9DropXmM0A61pp2sNM8MVrGqbanMJnMeEEuYO+l4lgp//0CdFJQHEYU0uNytesQUyq+5us3DRf6mWruWeux/fdMGdWCuDy1RQCiv1cYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VP5Q2opu; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33ed6078884so2589764f8f.1;
        Sun, 24 Mar 2024 11:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711304805; x=1711909605; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=u+Ls1dKkFPNQiQ9nFIFn5kDnUmZHvTMoqpHKOkVOgt0=;
        b=VP5Q2opuN3aC1uNgeVvO7ih2xa41c4qd27+Fr8Wg4ujTNljNiIKIfQwQlYiuYPBkoG
         2Hl/w5UoVANYGphwVYK2HGWYOfv6X5/Yh1HRep1s10Fwnd0Z5f2VkdEke9xLHMR/8Ycc
         ptwvrA6Tj/UsqGuYMUkuD/J5VDtjw3n3r5jM2XN5brjj/IiTy6UWPLggXtIZkIJk+vzk
         AmhurNARoaz8ZTrzCNRckNGGGUzc3CokKPljC6rfyh/ndTYHVz62lrXVI5xKOQLlLUKw
         KbQFlGGHN1IdVFyuy3+FRMUWmAhEJ32yCmrhLoSOe1gmKaHKzlj07Pf9GNE7s10RK0rH
         ySoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711304805; x=1711909605;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u+Ls1dKkFPNQiQ9nFIFn5kDnUmZHvTMoqpHKOkVOgt0=;
        b=IGEpYL6kBbXP++Mj4ibrLgEl5RF+PXArwoJK6qh6ZWmsRLGuw9pJiT6Io0Rz10fPrY
         DseKOBLPb+ooClnpidGbusisNoz232AAZlmZ15pk0gVGpWhfhakRjlN+KaOantB9X7Wn
         s2ecUT93eHuxnJCQFxee7uPE11ZqNLzGc9bTv2TrNFqIehVVMbX77W5/1ZsDnm2c5Tlu
         XIbafhNOd3Sl28seOVNAjvLJ2DYppkFOBgugIWHa980hN92H9r+2dCtcogzAfKy7oQTg
         ItYR8pK5CQH1eprPJin+bI9CglnwHll8NZU3I8idMfSX+fuSi/UmDXgtDvfszXPA159l
         liVg==
X-Forwarded-Encrypted: i=1; AJvYcCVrVhWBCx9NkeWvvkriVGPLwqtnZnh0oCzL9QZdFiYBbPk0oHXqVi/LNeFxJxX0gKVDThFgOYUd5CLn/QsPsp+M1Tdiv+RPWpQICL7JaRo/11Op1AG8bhweW9bX
X-Gm-Message-State: AOJu0YzZGxPWhZo+5RZA8sw+qlfVo6KNEQYEotvD7DhLlxyfNgAPjitD
	rc18uMNZfvK0U2RvLPiRhrpVC6IYMkhoYqqxeR7BVBP3Tu02Sf2g
X-Google-Smtp-Source: AGHT+IGD+HLUBULsf54WlTfOv9yJoIGNmUIUl90i/TbwD7oaZnasbzE1t6knA4CbSmr+lj8G1d0lfQ==
X-Received: by 2002:adf:e348:0:b0:33d:8c9d:419 with SMTP id n8-20020adfe348000000b0033d8c9d0419mr3168883wrj.24.1711304804896;
        Sun, 24 Mar 2024 11:26:44 -0700 (PDT)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id n7-20020a5d4847000000b0033ec9b26b7asm7259940wrs.25.2024.03.24.11.26.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2024 11:26:44 -0700 (PDT)
From: Puranjay Mohan <puranjay12@gmail.com>
To: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, netdev@vger.kernel.org
Cc: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Luke Nelson <luke.r.nels@gmail.com>, Pu Lehui
 <pulehui@huawei.com>, Pu Lehui <pulehui@huaweicloud.com>
Subject: Re: [PATCH bpf] riscv, bpf: Fix kfunc parameters incompatibility
 between bpf and riscv abi
In-Reply-To: <20240324103306.2202954-1-pulehui@huaweicloud.com>
References: <20240324103306.2202954-1-pulehui@huaweicloud.com>
Date: Sun, 24 Mar 2024 18:26:42 +0000
Message-ID: <mb61pfrwf7afx.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pu Lehui <pulehui@huaweicloud.com> writes:

> From: Pu Lehui <pulehui@huawei.com>
>
> We encountered a failing case when running selftest in no_alu32 mode:
>
> The failure case is `kfunc_call/kfunc_call_test4` and its source code is
> like bellow:
> ```
> long bpf_kfunc_call_test4(signed char a, short b, int c, long d) __ksym;
> int kfunc_call_test4(struct __sk_buff *skb)
> {
> 	...
> 	tmp = bpf_kfunc_call_test4(-3, -30, -200, -1000);
> 	...
> }
> ```
>
> And its corresponding asm code is:
> ```
> 0: r1 = -3
> 1: r2 = -30
> 2: r3 = 0xffffff38 # opcode: 18 03 00 00 38 ff ff ff 00 00 00 00 00 00 00 00
> 4: r4 = -1000
> 5: call bpf_kfunc_call_test4
> ```
>
> insn 2 is parsed to ld_imm64 insn to emit 0x00000000ffffff38 imm, and
> converted to int type and then send to bpf_kfunc_call_test4. But since
> it is zero-extended in the bpf calling convention, riscv jit will
> directly treat it as an unsigned 32-bit int value, and then fails with
> the message "actual 4294966063 != expected -1234".
>
> The reason is the incompatibility between bpf and riscv abi, that is,
> bpf will do zero-extension on uint, but riscv64 requires sign-extension
> on int or uint. We can solve this problem by sign extending the 32-bit
> parameters in kfunc.
>
> The issue is related to [0], and thanks to Yonghong and Alexei.
>
> Link: https://github.com/llvm/llvm-project/pull/84874 [0]
> Fixes: d40c3847b485 ("riscv, bpf: Add kfunc support for RV64")
> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> ---
>  arch/riscv/net/bpf_jit_comp64.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
> index 869e4282a2c4..e3fc39370f7d 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -1454,6 +1454,22 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn, struct rv_jit_context *ctx,
>  		if (ret < 0)
>  			return ret;
>  
> +		if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
> +			const struct btf_func_model *fm;
> +			int idx;
> +
> +			fm = bpf_jit_find_kfunc_model(ctx->prog, insn);
> +			if (!fm)
> +				return -EINVAL;
> +
> +			for (idx = 0; idx < fm->nr_args; idx++) {
> +				u8 reg = bpf_to_rv_reg(BPF_REG_1 + idx, ctx);
> +
> +				if (fm->arg_size[idx] == sizeof(int))
> +					emit_sextw(reg, reg, ctx);
> +			}
> +		}
> +
>  		ret = emit_call(addr, fixed_addr, ctx);
>  		if (ret)
>  			return ret;
> -- 
> 2.34.1

Thanks for doing this, it fixes the issue I was seeing with arena_htab
selftest after enabling arena on RISCV.

Tested-by: Puranjay Mohan <puranjay12@gmail.com>
Reviewed-by: Puranjay Mohan <puranjay12@gmail.com>

