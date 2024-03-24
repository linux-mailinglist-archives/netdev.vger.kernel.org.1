Return-Path: <netdev+bounces-81430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A9A887E5F
	for <lists+netdev@lfdr.de>; Sun, 24 Mar 2024 19:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4942A1C20C06
	for <lists+netdev@lfdr.de>; Sun, 24 Mar 2024 18:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C4CD266;
	Sun, 24 Mar 2024 18:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0goaxNE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D7B6FB1;
	Sun, 24 Mar 2024 18:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711305635; cv=none; b=C95MGf5WM3HGqcGJKIHUiqVHak9aaOcZgDBCZvMSP9my+UDlcHV/BtqmIFbNgXdr9JNqOFsfTE10awOqCSmco+ZC3L0pV8Fn/CfUnM0QwcjAiEFBW01P+kP9C9YsJtNzZq+ZnBHDGuKBavBQI2nCickcyJxEcdV/KZHCaIrmrnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711305635; c=relaxed/simple;
	bh=C56z9WQQZ0ymNRrYt2ycyZ44b3l0BTHjL4HJOGjztJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P7k0DrTnz08LwgYDMm8KLUFMEB7qbMb1LnEmpSyIVIFJRegbICklnG8OiBqLscxuUQGgg94Gl0De1p3VGntJCL2pbsQl8G+S3Q1F26Pl75ZWWWHWMCEWC24T4U3Z2uZMudaKJ1DWrv+sOXsSc8Md2Epq71kqndhiNMFI2y58Ixg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C0goaxNE; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33ec7e1d542so2553200f8f.1;
        Sun, 24 Mar 2024 11:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711305632; x=1711910432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dJKbpIBc4Yk3hVeaC0TWE3PUYRF5GQ/zo/JVhWXgRF4=;
        b=C0goaxNEKfeiiBfsVTf6EErP4Y9H9zwOWJ3XgQWUNMj1XONyhthVYZZllw/22mUBr3
         Tyel6MfAxrF3GhJSUbzyzxXBBrtmRICkVVcTN+7Y6YcKW5NeILfBPNA5bZaiB0rsyQI3
         5JBjjb3wUPuInXQvrA8kfiLjdgdJd3An44n4Hyd/uv73aH2kEanq48J0/KYeT75OQvsw
         AtZhNbmn+SCyvOLmbTcPDfGahCvIRBYe1kanPcOcJcjOIIu4SeR5kJTxbHKqgDqJxXUm
         5RJ9c2h5O3AprwL20QGvCX36UpugrPEEbJMBDnwylrFJpbcsayR79PYGITCTjlsHIB/C
         yOww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711305632; x=1711910432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dJKbpIBc4Yk3hVeaC0TWE3PUYRF5GQ/zo/JVhWXgRF4=;
        b=APv6aLBh5UuIEh2BPjRjVvNR4tCE6lSsjJV4R0d5e6me73wiL7EfC/NHktclZW40wf
         LB6hWfRQTe0mv7cxz8kLZcmvQY1+D036HZGEevIwcrwCmgGe/17as2kAY4/hbprdtQqR
         EpKdaSfFh4dmnLy9vTT/ct6elS2KRx3KglSEmgDl1u2CC73yaQdYruPZm2kojKq0Jukm
         KuzZq6nulbvUwNdgqlMWYAwm1DHhJo8dtk8q1YjsqQC1m2TPW9NjEWnDaMalLDyIJfPU
         8K0UzSCmsrxGJ4b1coNCOb1hqrgdCx0ZyOZEoVGbH9Y4ZrG9xJLXSXRu9WGjlHr2nIfc
         7I9g==
X-Forwarded-Encrypted: i=1; AJvYcCXpKeJ4q/qrvDabwuWlDioF6ROSOSlC/JR14mbIXmvCL8FmCtmt59BeoABnNtmhkSHo0hWcAgi9mgsDB+HkoQCVpw6xZJHd
X-Gm-Message-State: AOJu0YzKSYzBcXn0Hl7ZJJjBP8RtGlcz7T+NXzlr5w/fV6tHt/npTh+i
	aM0osKI9E6gaiC1GM7zWmcHLxEy2R981aCkPv0tds7abvobcDr5OtxV+wQ761PbcP2njoOVRJmI
	4NXLZvErJ02ii2r9fXaG3auoUG54=
X-Google-Smtp-Source: AGHT+IFzKEkY15yhx27Y6RGVrqzcqiPDvwvdtOsJddWLuUBEN2lntnvbXLjYRQxGyEL3NiLUINN58t818qvcHl3O+OI=
X-Received: by 2002:a05:6000:4593:b0:33e:d547:4318 with SMTP id
 gb19-20020a056000459300b0033ed5474318mr3801146wrb.47.1711305632179; Sun, 24
 Mar 2024 11:40:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324103306.2202954-1-pulehui@huaweicloud.com>
In-Reply-To: <20240324103306.2202954-1-pulehui@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 24 Mar 2024 11:40:20 -0700
Message-ID: <CAADnVQLhfN7f6AFxa_19E0g2_YADEkrfPPffi43HeH9VCi8MqQ@mail.gmail.com>
Subject: Re: [PATCH bpf] riscv, bpf: Fix kfunc parameters incompatibility
 between bpf and riscv abi
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, linux-riscv <linux-riscv@lists.infradead.org>, 
	Network Development <netdev@vger.kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Luke Nelson <luke.r.nels@gmail.com>, 
	Pu Lehui <pulehui@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 24, 2024 at 3:32=E2=80=AFAM Pu Lehui <pulehui@huaweicloud.com> =
wrote:
>
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
>         ...
>         tmp =3D bpf_kfunc_call_test4(-3, -30, -200, -1000);
>         ...
> }
> ```
>
> And its corresponding asm code is:
> ```
> 0: r1 =3D -3
> 1: r2 =3D -30
> 2: r3 =3D 0xffffff38 # opcode: 18 03 00 00 38 ff ff ff 00 00 00 00 00 00 =
00 00
> 4: r4 =3D -1000
> 5: call bpf_kfunc_call_test4
> ```
>
> insn 2 is parsed to ld_imm64 insn to emit 0x00000000ffffff38 imm, and
> converted to int type and then send to bpf_kfunc_call_test4. But since
> it is zero-extended in the bpf calling convention, riscv jit will
> directly treat it as an unsigned 32-bit int value, and then fails with
> the message "actual 4294966063 !=3D expected -1234".
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
> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_com=
p64.c
> index 869e4282a2c4..e3fc39370f7d 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -1454,6 +1454,22 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn,=
 struct rv_jit_context *ctx,
>                 if (ret < 0)
>                         return ret;
>
> +               if (insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL) {
> +                       const struct btf_func_model *fm;
> +                       int idx;
> +
> +                       fm =3D bpf_jit_find_kfunc_model(ctx->prog, insn);
> +                       if (!fm)
> +                               return -EINVAL;
> +
> +                       for (idx =3D 0; idx < fm->nr_args; idx++) {
> +                               u8 reg =3D bpf_to_rv_reg(BPF_REG_1 + idx,=
 ctx);
> +
> +                               if (fm->arg_size[idx] =3D=3D sizeof(int))
> +                                       emit_sextw(reg, reg, ctx);
> +                       }
> +               }
> +

The btf_func_model usage looks good.
Glad that no new flags were necessary, since both int and uint
need to be sign extend the existing arg_size was enough.

Since we're at it. Do we need to do zero extension of return value ?
There is
__bpf_kfunc int bpf_kfunc_call_test2(struct sock *sk, u32 a, u32 b)
but the selftest with it is too simple:
        return bpf_kfunc_call_test2((struct sock *)sk, 1, 2);

Could you extend this selftest with a return of large int/uint
with 31th bit set to force sign extension in native
kernel risc-v code ?
I suspect the bpf side will be confused.
Which would mean that risc-v JIT in addition to:
        if (insn->src_reg !=3D BPF_PSEUDO_CALL)
            emit_mv(bpf_to_rv_reg(BPF_REG_0, ctx), RV_REG_A0, ctx);

need to conditionally do:
 if (fm->ret_size =3D=3D sizeof(int))
   emit_zextw(bpf_to_rv_reg(BPF_REG_0, ctx),
              bpf_to_rv_reg(BPF_REG_0, ctx), ctx);
?

