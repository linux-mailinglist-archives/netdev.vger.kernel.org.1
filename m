Return-Path: <netdev+bounces-249654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 11355D1BEBC
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 02:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13DC4304A105
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 01:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC0129AB1D;
	Wed, 14 Jan 2026 01:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYNfHb72"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E7F287245
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 01:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768353829; cv=none; b=Ete0ZIk2TgRBldhT2LRveAAI7ZP8iZJ2L7jcvgds1WlfLVrbmnzeYuWnrxp4l50kYStXa1OKnCNWbVsBvY0Z39CiMQXeGJXznU98/RDrbw+tWDpL4YEvTcGB/vZn9u9DBlkNT8kL4sYzZm851uthQk3w/yMQHPfkZUOSELiXG34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768353829; c=relaxed/simple;
	bh=aAEZWQ1KfSMzAPYtpG3tL2ijb088UuNcClfkzLAsxDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fMI1P3LiMwItlddT8zV+IwPyUFiYPMVmPwwMq5ZanxFuf8HI24vc1srJdCTelRZ3VDHha9rBdvSoI2bpKtgnQr1f7uLpM+bckmm6mEfhBx5QYVyLqUhZTSX717Vx1nLcZa9CxsZrrfpZUmEGs+0TNxkh6u438lpdA4lAgxjTSU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YYNfHb72; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6505d3adc3aso12640989a12.1
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 17:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768353826; x=1768958626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bUDSeyaDRV+JlrvmR3S5XBVgtWA/bfNivxnd3t19/tE=;
        b=YYNfHb727U5AkuiOCLV38nzaK+3g/Ch51suGrcMwaWJWuLaszChE/4N+CHzaZGTbqG
         SeRCme/PhOpio8OLQmzf57JjfgM5rw6mY2+OW9nLZYkpBpIyQNJ7RReqsO7xlRCpBcbe
         7LCfJLZf0VAbKW0vwdLJkTwcf15m9Ed5xDFcK87aXjL5cuDpzi7nHYQwvZDbILbt6T9B
         mBHjlJ349CijIWUX0M0VDUEbz4dOH8f22TqKw1wsSbvgpn0d07bsCIYxCZ4YNE0h8RfI
         zIIZUr0VenzGXbS9QxuaVjtZXB0csSQUe+jQDqJJa+I5bkrAJm3IZfbJ36/2PY7taxkS
         75oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768353826; x=1768958626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bUDSeyaDRV+JlrvmR3S5XBVgtWA/bfNivxnd3t19/tE=;
        b=Etnti1IAZrJjhOZxh4oqe2irMA+G9pgYDY/MvQSVfWsL45OUIigKEi7mVf3pMNLcCo
         EFlwrBAkefgTOc7+eCHMk5jXm/H1364Jm/G47D7agFNKJOb+NYwN143ZtxjwkJEbcfi6
         CYGJQ1XI37HxYWgnrgoPkgukUAhHQnsEDW6w+uop/L2naQVvv0ke3H3+f3FU3upH16BY
         NsH3xh3rmV+XVK7fMReRJavTC/poVJk2hk09QywKV5s4IFaF5KBFR1gjak7GNBdPU0mp
         WnnnJ+2InnO7qGGIRdTMQxpni01mfvZs0Vm35XHedFXfo4Gu+MoEc9pDs4a6BMcH91vq
         5uuw==
X-Forwarded-Encrypted: i=1; AJvYcCXYBe0SJYbRKq4ZqX1ayteA9FSLRerIFB/VDVG29AXDx3NHBmoyllxvZ36ufyKlDo5oqL5zWhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZxxR+UhYYS/6Hdh3fnkM8qTB+p/qmwAW5vLWYVkb+bYAdUn4x
	QjB/PJoVoG8MctkETnBNs97tHXs7mboT/XFgheOqTlXUkswq6U6s4yoFAX1LsrvLz3DqgPwxVHh
	dpDAvAtSNeoWL+n2UG+sxulVtc1tFHTA=
X-Gm-Gg: AY/fxX65E6nJsdo+r6b0RJVRE4PidnAB2/rspxdZ0TE89tK11ShatwJ6rBLaHERXHC2
	TsRPxemiyNVsgu1Mf7LIQ982SUt8rv6kXT7W7dZqYi26tpV31wJdf5Is2Xl8YVh4iwgS/3yFoJO
	bS5XDZBAYU/gL6f/DNYRZEdYVv5ctsO3gN+q94ifUpp+2Beedw9bhJlHEWs6potSU1FRXV/NSGI
	TaxoOaM/cdPc4OOf6e3w0sCUyuLgyUPmG+Vn3Qwbc1d5REXyatAur7xXhOnjM/u8tszYTtyevD6
	1kjame8eZ78=
X-Received: by 2002:a17:907:7757:b0:b87:65c5:602f with SMTP id
 a640c23a62f3a-b8765c56175mr16705366b.34.1768353826138; Tue, 13 Jan 2026
 17:23:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260110141115.537055-1-dongml2@chinatelecom.cn> <20260110141115.537055-3-dongml2@chinatelecom.cn>
In-Reply-To: <20260110141115.537055-3-dongml2@chinatelecom.cn>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 13 Jan 2026 17:22:44 -0800
X-Gm-Features: AZwV_Qhh4nrVKAaE708iS3vZTpxbmrywNIqG8up4OBkJsswM78KS0HeB58v781U
Message-ID: <CAEf4BzZKn8B_8T+ET7+cK90AfE_p918zwOKhi+iQOo5RkV8dNQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 02/11] bpf: use last 8-bits for the nr_args in trampoline
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net, 
	dsahern@kernel.org, tglx@linutronix.de, mingo@redhat.com, 
	jiang.biao@linux.dev, bp@alien8.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, hpa@zytor.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 10, 2026 at 6:11=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> For now, ctx[-1] is used to store the nr_args in the trampoline. However,
> 1-byte is enough to store such information. Therefore, we use only the
> last byte of ctx[-1] to store the nr_args, and reserve the rest for other

Looking at the assembly below I think you are extracting the least
significant byte, right? I'd definitely not call it "last" byte...
Let's be precise and unambiguous here.

> usages.
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
> v8:
> - fix the missed get_func_arg_cnt
> ---
>  kernel/bpf/verifier.c    | 35 +++++++++++++++++++----------------
>  kernel/trace/bpf_trace.c |  6 +++---
>  2 files changed, 22 insertions(+), 19 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 774c9b0aafa3..bfff3f84fd91 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -23277,15 +23277,16 @@ static int do_misc_fixups(struct bpf_verifier_e=
nv *env)
>                     insn->imm =3D=3D BPF_FUNC_get_func_arg) {
>                         /* Load nr_args from ctx - 8 */
>                         insn_buf[0] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_0, BP=
F_REG_1, -8);
> -                       insn_buf[1] =3D BPF_JMP32_REG(BPF_JGE, BPF_REG_2,=
 BPF_REG_0, 6);
> -                       insn_buf[2] =3D BPF_ALU64_IMM(BPF_LSH, BPF_REG_2,=
 3);
> -                       insn_buf[3] =3D BPF_ALU64_REG(BPF_ADD, BPF_REG_2,=
 BPF_REG_1);
> -                       insn_buf[4] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_0, BP=
F_REG_2, 0);
> -                       insn_buf[5] =3D BPF_STX_MEM(BPF_DW, BPF_REG_3, BP=
F_REG_0, 0);
> -                       insn_buf[6] =3D BPF_MOV64_IMM(BPF_REG_0, 0);
> -                       insn_buf[7] =3D BPF_JMP_A(1);
> -                       insn_buf[8] =3D BPF_MOV64_IMM(BPF_REG_0, -EINVAL)=
;
> -                       cnt =3D 9;
> +                       insn_buf[1] =3D BPF_ALU64_IMM(BPF_AND, BPF_REG_0,=
 0xFF);
> +                       insn_buf[2] =3D BPF_JMP32_REG(BPF_JGE, BPF_REG_2,=
 BPF_REG_0, 6);
> +                       insn_buf[3] =3D BPF_ALU64_IMM(BPF_LSH, BPF_REG_2,=
 3);
> +                       insn_buf[4] =3D BPF_ALU64_REG(BPF_ADD, BPF_REG_2,=
 BPF_REG_1);
> +                       insn_buf[5] =3D BPF_LDX_MEM(BPF_DW, BPF_REG_0, BP=
F_REG_2, 0);
> +                       insn_buf[6] =3D BPF_STX_MEM(BPF_DW, BPF_REG_3, BP=
F_REG_0, 0);
> +                       insn_buf[7] =3D BPF_MOV64_IMM(BPF_REG_0, 0);
> +                       insn_buf[8] =3D BPF_JMP_A(1);
> +                       insn_buf[9] =3D BPF_MOV64_IMM(BPF_REG_0, -EINVAL)=
;
> +                       cnt =3D 10;
>

[...]

